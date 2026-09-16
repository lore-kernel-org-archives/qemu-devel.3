Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6C3C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6oqL-00041t-59; Wed, 16 Sep 2026 08:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6oqJ-00041d-AD
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6oqH-000393-Br
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789562064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MkLF4nUNFDGdNIKWjQGK9h2d0x/s1kvWCz3q3Obwcd8=;
 b=VnpwuvxjB8C9v/RxL5ewMpYNgrLN6SO05jxl0pCNZlCxHd0kO8iDfS6gjysA1axCAtsF5m
 PWafih5eEKiPIqtWrCz/DexTaLXgVeRQ92SeSAkriapW8zI/6H2MdgHfIhMflz4GMFd1+4
 bcKF1VkWJ2GEgz1lZtS0G0LThwEsD3c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-uYFW5wC0PbqIylxWWGlFWQ-1; Wed,
 16 Sep 2026 08:33:17 -0400
X-MC-Unique: uYFW5wC0PbqIylxWWGlFWQ-1
X-Mimecast-MFC-AGG-ID: uYFW5wC0PbqIylxWWGlFWQ_1789561996
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29837184B397; Wed, 16 Sep 2026 12:33:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E289B180034C; Wed, 16 Sep 2026 12:33:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A28421E6A04; Wed, 16 Sep 2026 14:33:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: a vincent163 <vincent.163@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [BUG] x86_64 guest: vpmovmskb produces wrong mask on a riscv64
 host (user-mode) -- root cause = TCG_REG_TMP0 clobber in tcg/riscv
 tcg_out_dup{m,i}_vec (10.0.0-10.0.7, 10.1.0-10.1.3, 10.2.0)
In-Reply-To: <SA1PR20MB7041B36B079598503E672E59ABB92@SA1PR20MB7041.namprd20.prod.outlook.com>
 (a. vincent's message of "Wed, 16 Sep 2026 09:41:47 +0000")
References: <SA1PR20MB7041B36B079598503E672E59ABB92@SA1PR20MB7041.namprd20.prod.outlook.com>
Date: Wed, 16 Sep 2026 14:33:13 +0200
Message-ID: <87zexh8jg6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Please read docs/devel/code-provenance.rst section "Use of AI-generated
content".


