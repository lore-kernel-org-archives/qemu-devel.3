Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB35BC87FD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 07:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uipwv-0006o9-HI; Mon, 04 Aug 2025 03:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uipvA-0005lM-7B
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uipv3-00073e-AO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 03:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754293655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=QW3v+d/KV2HmtzkOjrB9KA7cANT8gS7B+Co+5DzmitA=;
 b=PzZBBmSjAvYLySA9h21GZOkIzgD4D7ZQk4X8aicU2zTXAuH/UinALx9edS//hg5RJHV082
 hSEW+DePToi9b5WqeO4CXVvLxo3rib2FdIra/SJZDThlIVZWiWgc4LR2XP8lvkPAO808V6
 6H8f80OQeoFGaHCnvVWYKWxuLPwi/pY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-ISr5MWvCO86uOtU-L-jUNQ-1; Mon,
 04 Aug 2025 03:47:31 -0400
X-MC-Unique: ISr5MWvCO86uOtU-L-jUNQ-1
X-Mimecast-MFC-AGG-ID: ISr5MWvCO86uOtU-L-jUNQ_1754293650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E592195608D; Mon,  4 Aug 2025 07:47:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD61F1800EEC; Mon,  4 Aug 2025 07:47:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A00121E6A27; Mon, 04 Aug 2025 09:47:27 +0200 (CEST)
Resent-To: eduardo@habkost.net, qemu-devel@nongnu.org,
 steven.sistare@oracle.com
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 04 Aug 2025 09:47:27 +0200
Resent-Message-ID: <87tt2njzow.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: steven.sistare@oracle.com
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH 0/5] qtest/qom-test: Leak plug, faster, better coverage
In-Reply-To: <20250725135034.2280477-1-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 25 Jul 2025 15:50:29 +0200")
References: <20250725135034.2280477-1-armbru@redhat.com>
Date: Mon, 04 Aug 2025 09:01:22 +0200
Message-ID: <875xf3lge5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Steven, this is follow-up to your work.  Care to review?


