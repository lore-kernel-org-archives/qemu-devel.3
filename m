Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49371D6552C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 11:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVppi-0008Uh-G2; Wed, 17 Dec 2025 06:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVppW-0008UK-Qn
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:36:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVppU-000526-43
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765971387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qIZ34esG1c6ZVBCQVE14sm24RyVINchDFCkdTTRXKY=;
 b=V1zxJh6+XtEwRucRb1R3iNmeQ1B3xYHQMBzLUtnNSjULMIujpoUQGPV4PkdJCioCPcHPLQ
 FEk/N1JxWzcPDoQrSFCnH6vFztP3sALQzuXYTzyeNGQUDI42yaB2k3C+cRsXoGNKzo32R2
 Q+AlKrF524QjSw/rfF78GoP5uwQb1Hw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-Mfhed5YQNtSX-Yw_i8PhqQ-1; Wed,
 17 Dec 2025 06:36:25 -0500
X-MC-Unique: Mfhed5YQNtSX-Yw_i8PhqQ-1
X-Mimecast-MFC-AGG-ID: Mfhed5YQNtSX-Yw_i8PhqQ_1765971384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93D2918005B0; Wed, 17 Dec 2025 11:36:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32D0B1800576; Wed, 17 Dec 2025 11:36:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BD75A1800869; Wed, 17 Dec 2025 12:36:21 +0100 (CET)
Date: Wed, 17 Dec 2025 12:36:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, vkuznets@redhat.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 13/28] i386/tdx: finalize TDX guest state upon reset
Message-ID: <ubmc2igckwxxpgw3zq7lmrhztygazibobjq3ruuhr3kbuzhfpr@odnoz7izs4hn>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-14-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212150359.548787-14-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 12, 2025 at 08:33:41PM +0530, Ani Sinha wrote:
> When the confidential virtual machine KVM file descriptor changes due to the
> guest reset, some TDX specific setup steps needs to be done again. This
> includes finalizing the inital guest launch state again. This change
> re-executes some parts of the TDX setup during the device reset phaze using a
> resettable interface. This finalizes the guest launch state again and locks
> it in. Also care has been taken so that notifiers are installed only once.

> +    if (!notifier_added) {
> +        qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
> +        notifier_added = true;
> +    }

Is this notifier needed still if you finalize the initial guest state in
the reset handler?

take care,
  Gerd


