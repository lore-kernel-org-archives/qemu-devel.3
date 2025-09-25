Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D033CCAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 04:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1daS-0007iJ-Hn; Thu, 25 Sep 2025 00:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1daP-0007ht-MD
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 00:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1daF-0000PT-J8
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 00:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758774470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1G6GLoMD3es4OIjijZ84AvYLdNBulIJbXLYOSfnKxw=;
 b=b1fJwtEI73/5Fp1asIDZQS9ZHuahMf0wA4aEdid4UogpQPM/1INBb2gM/FKcB4Ue6srFaE
 lD3nkshy7fSVDwH8PanRYPLf4gNxZvWq4xfnDkRKpQUDS3FancGgn3guHBGsHPOGOcMxbu
 TqKduLKd04pRGi7LCM1Bs6yBl84SWD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-z1gi34uiN_SA0nnNGnC9Qg-1; Thu,
 25 Sep 2025 00:27:45 -0400
X-MC-Unique: z1gi34uiN_SA0nnNGnC9Qg-1
X-Mimecast-MFC-AGG-ID: z1gi34uiN_SA0nnNGnC9Qg_1758774464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D12A41800378; Thu, 25 Sep 2025 04:27:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56D6D19560B1; Thu, 25 Sep 2025 04:27:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EFFB21E6A27; Thu, 25 Sep 2025 06:27:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com,  philmd@linaro.org,  berrange@redhat.com,
 jdenemar@redhat.com,  pbonzini@redhat.com,  richard.henderson@linaro.org,
 eduardo@habkost.net,  mst@redhat.com,  marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386/isapc.c: remove support for -cpu host and -cpu max
In-Reply-To: <20250924124653.1395094-1-mark.caveayland@nutanix.com> (Mark
 Cave-Ayland's message of "Wed, 24 Sep 2025 13:46:30 +0100")
References: <20250924124653.1395094-1-mark.caveayland@nutanix.com>
Date: Thu, 25 Sep 2025 06:27:40 +0200
Message-ID: <87qzvvxikj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> Following recent discussions on the mailing list, it has been decided
> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
> it is preferable to disallow them and use the existing valid_cpu_types
> validation logic so that an error is returned to the user instead.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Do we need to note this in docs/about/removed-features.rst and/or
release notes?


