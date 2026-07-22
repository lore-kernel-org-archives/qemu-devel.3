Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827E1C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVbj-0003gX-IZ; Wed, 22 Jul 2026 07:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmVbh-0003g8-Ns
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wmVbf-0003HJ-Sg
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 07:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784721563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBTHXIDrKQBMbS/hqYFOEtbwvmZ4ypWwp3sieITJ9ec=;
 b=ExYqVlglVRdYytdFFZvOds6PzfRPvU2ka/VsQ60bv8QtKJyXXmzksqotuPdYoU0OWI0xGn
 dnGK4DLZCXEbvG0qVejK7duijHI/75LA1LnZ79W3TAyvj+HKKXQtGMzrGcVEnRABXeH9HU
 taVy0yG3zuzRgKUvrEVlTUfwrc+395U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-X5R_xLAKPO-Vs6I4qc8dJw-1; Wed,
 22 Jul 2026 07:59:21 -0400
X-MC-Unique: X5R_xLAKPO-Vs6I4qc8dJw-1
X-Mimecast-MFC-AGG-ID: X5R_xLAKPO-Vs6I4qc8dJw_1784721560
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54A191955F3F; Wed, 22 Jul 2026 11:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E87F3D70; Wed, 22 Jul 2026 11:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62B6021E6920; Wed, 22 Jul 2026 13:59:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: kernel@0in.de
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P . Berrange" <berrange@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,  Justinien Bouron
 <justinien.bouron@gmail.com>
Subject: Re: [PATCH v6] input-linux: Add option to not grab device on guest
 start
In-Reply-To: <20260714091109.63544-1-kernel@0in.de> (kernel@0in.de's message
 of "Tue, 14 Jul 2026 11:10:27 +0200")
References: <20240307062823.2377318-1-justinien.bouron@gmail.com>
 <20260714091109.63544-1-kernel@0in.de>
Date: Wed, 22 Jul 2026 13:59:17 +0200
Message-ID: <87qzkvjkve.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

kernel@0in.de writes:

> From: Maximilian Senftleben <kernel@0in.de>
>
> Some workflows start a guest in the background and do not want evdev
> devices to be grabbed immediately.  In that case, the current behavior
> is annoying because the host loses control of the keyboard or mouse
> before the user actually wants to interact with the guest.
>
> Add a new boolean input-linux property, grab-on-startup.  When true,
> the device is grabbed during initialization, which keeps the existing
> behavior.  When false, the device remains ungrabbed until the toggle
> key combination is entered.
>
> Also make sure startup grabbing is skipped entirely when
> grab-on-startup is false, even if keys are already pressed during
> device initialization.  Without this, QEMU could still perform a delayed
> grab once those keys are released.
>
> This revives an earlier patch originally posted by Justinien Bouron and
> incorporates the follow-up review feedback.
>
> Link: https://patchew.org/QEMU/20240403055002.890760-1-justinien.bouron@gmail.com/
> Link: https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04004.html
>
> Signed-off-by: Maximilian Senftleben <kernel@0in.de>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


