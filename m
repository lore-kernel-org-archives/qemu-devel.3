Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B077D358CF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 06:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlLv7-0000Gy-MX; Thu, 29 Jan 2026 01:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vlLv6-0000GQ-93
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:54:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vlLv3-0006u1-0u
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769669660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2SjvqO7WJD5PhgU5kWDQw5OJswjnx3MpfcjC6gBombM=;
 b=fVV7vpfOIFH84KmlB5hTdOsdUymdYwBxVrlJlAx8mjgSmoSshk+q4QCVOHonkrcqvxAiZA
 jxiiGO7ZghImVysv4eLH1yfwsjWr0eBE5LlnuQWmBXFUEpuCrG26D7yfrfxTkatAmfgehY
 pU1rQxhD93MHISzmtY+H8LvHcJB7UQA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-wcMnoMTWPiukiQuk1txKnQ-1; Thu,
 29 Jan 2026 01:54:14 -0500
X-MC-Unique: wcMnoMTWPiukiQuk1txKnQ-1
X-Mimecast-MFC-AGG-ID: wcMnoMTWPiukiQuk1txKnQ_1769669653
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF0C1800447; Thu, 29 Jan 2026 06:54:13 +0000 (UTC)
Received: from localhost (unknown [10.44.32.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A0E91800665; Thu, 29 Jan 2026 06:54:11 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 0/2] arm: move DCZID_EL0 to idregs array
In-Reply-To: <20260105154119.59853-1-cohuck@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260105154119.59853-1-cohuck@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 29 Jan 2026 07:54:08 +0100
Message-ID: <87tsw4sycv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05 2026, Cornelia Huck <cohuck@redhat.com> wrote:

> This is part of the ongoing effort to move all id registers to the idregs
> array (so that we can work with an autogenerated list of registers.)
>
> Changes v2->v3:
> - separate patch for adding the helpers
> - put some rationale into the patch description
>
> Cornelia Huck (2):
>   arm: add {get,set}_dczid_bs helpers
>   arm: add DCZID_EL0 to idregs array
>
>  target/arm/cpu-sysregs.h.inc   |  1 +
>  target/arm/cpu.c               |  2 +-
>  target/arm/cpu.h               | 14 ++++++++++++--
>  target/arm/cpu64.c             |  4 ++--
>  target/arm/helper.c            |  5 ++++-
>  target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
>  target/arm/tcg/helper-a64.c    |  2 +-
>  target/arm/tcg/mte_helper.c    |  4 ++--
>  target/arm/tcg/translate-a64.c |  2 +-
>  target/arm/tcg/translate.h     |  2 +-
>  10 files changed, 36 insertions(+), 22 deletions(-)
>

Friendly ping. Is this one good to go?


