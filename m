Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09937C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqxs-0004D6-Ii; Wed, 05 Mar 2025 10:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tpqxq-0004Ct-JU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tpqxo-0003bJ-3O
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741189633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+qIQfbx9rmVOsAsqywWh8I3RJVLEPLhoLGrzhAqy9E=;
 b=XM8YQ35x66SDpZXbBaPiwFqhuutDojR9GvTg2OOSUkUDkMCmIE83iPkjcul/Esj0kfU2A+
 3VLVkm91rdywEbVyPGlOW6vkpJjmbCIANYSBGGD6lJ5oo7P3fDPhHL0gI1mIGCxduhnIA9
 l3YPOF3HSmrBOg4F3aNhJIIIzct5F/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237--ewqNipGMBurOWX4XZwzJg-1; Wed, 05 Mar 2025 10:47:11 -0500
X-MC-Unique: -ewqNipGMBurOWX4XZwzJg-1
X-Mimecast-MFC-AGG-ID: -ewqNipGMBurOWX4XZwzJg_1741189630
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3910b93cb1eso1632310f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189630; x=1741794430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+qIQfbx9rmVOsAsqywWh8I3RJVLEPLhoLGrzhAqy9E=;
 b=EaAPea5MwHTvgCYNXNLQHeXAMl8SkoTySGrZeGOWJp5reDe6B1N5HvFUcuJlaGzaU+
 M6YZg/5NOSbM3wruI6nZm7yq+ai1ai5x0+wyHTAh+liw6a1jj6Ewwp98aYDg1QMq9yW+
 3A52zIsxWieOhRdtYX32vOsnVrdi+zlDZ+TAwmj2tN66y+iSuD+eeWYrWk9p9GX1n8XA
 i0iYqaPwfhg1L1oA+koiflzjXEUfMPXcyPjyF24HhK3lgseQJxqejjnUownWfgM2sMj9
 HnyPvxtTfOU99P9KVKjqiAa7lKI5Wg9ZXyGqS5dB22N3D0w/LnLUiiSD0qa4xOYQQLiV
 n/eg==
X-Gm-Message-State: AOJu0Yx3H32Z8GEy12Zjlo4jHvJbc5IlXT84k+334ZKs7ycFnCehN7ix
 248UC9jg0gUc7QR6M+4G8/0a869LQg5gzsr/mVqLU9Il3ztkR/EbbaG/3C91UiXc8pqqbYk2QBM
 CtWE7ucDJNHYj8otAPlcj1eJGnwATxwwG/HRhEqo1QtMiVrLP22pe
X-Gm-Gg: ASbGncuOvDbe1Vd7PsoAAogYpLjsThj+3imHwMEtnxPrC12d6xqWbsH8T7Jm4JwBX17
 aJ85S2ReERje/G6vOleHqXfs0Ozj0FowAi+3pVhrVOlmO4W8lhDPMUmD4dJn9Y6tOkP7jsGuF1o
 ynY36q16l75J5oaAwy47oNqgRNGbcpOlr0o9LCpK4UqKQ1u+mEKLSWinIs6+txGGl+uHs1+Fosf
 zAfREOveomGhDoaxYgmAMC6gPCtVX+H8WkaLKLzSE/nKYbEhbCgk+vbSZz3ujz2sqHI0ZYHUIQR
 OLN6y4FoYsru3skFXYZ8rRZ/4E5zszy2JX8GhWKhR/Jhxv4cu4F6i/K6Tt+wmxiZ
X-Received: by 2002:a05:6000:2b0a:b0:391:5f:fa30 with SMTP id
 ffacd0b85a97d-3911f7700d4mr2104701f8f.28.1741189630395; 
 Wed, 05 Mar 2025 07:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7H26qrX/QzPdemWW+4mjYgJ5+MI7HiyPmwcilqoI5/JXb44U4BiPSdSusW05cyoqeMgl3ig==
X-Received: by 2002:a05:6000:2b0a:b0:391:5f:fa30 with SMTP id
 ffacd0b85a97d-3911f7700d4mr2104669f8f.28.1741189629765; 
 Wed, 05 Mar 2025 07:47:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352ec1sm20912515e9.25.2025.03.05.07.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 07:47:08 -0800 (PST)
Date: Wed, 5 Mar 2025 16:47:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Roy Hopkins <roy.hopkins@randomman.co.uk>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Joerg Roedel <jroedel@suse.com>
Subject: Re: [PATCH v7 00/16] Introduce support for IGVM files
Message-ID: <CAGxU2F4pq3Y7QnQBCEPQ35kQ2hxrwU5nVA9FmR=J6id+EJXAtA@mail.gmail.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Roy,

On Thu, 27 Feb 2025 at 14:47, Roy Hopkins <roy.hopkins@randomman.co.uk> wrote:
>
> Here is v7 of the set of patches to add support for IGVM files to QEMU. This is
> based on commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62 of qemu.
>
> Firstly, apologies for the amount of time between the last version and this one.
> I moved roles to a different company and, although I always planned to see this
> patch series to completion, it took a while before I found time to setup a
> development environment and be in a position to send a new version. I will
> continue this series using a personal email address for now, hence the change
> to the author and signed-off-by emails.
>
> The only changes in this version are to rebase on the current master branch and
> update commit metadata, including Signed-Off-By and Author emails for my
> replacement email address, and to include the final Reviewed-By that were added
> in the last review. There were no requested changes on the previous version [1]
> so I believe this series is ready to merge.
>
> As always, thanks to those that have been following along, reviewing and testing
> this series. This v7 patch series is also available on github: [2]
>
> For testing IGVM support in QEMU you need to generate an IGVM file that is
> configured for the platform you want to launch. You can use the `buildigvm`
> test tool [3] to allow generation of IGVM files for all currently supported
> platforms. Patch 11/17 contains information on how to generate an IGVM file
> using this tool.

I was testing this series with the IGVM file generated by COCONUT SVSM, 
but QEMU was failing in this way:

   qemu-system-x86_64: KVM does not support guest_memfd
   qemu-system-x86_64: failed to initialize kvm: Operation not permitted

After spending some time debugging, I found that IGVM is parsed in 
kvm_arch_init(). One of the handler called during the parsing is 
qigvm_prepare_memory(), which adds a new memory region calling 
memory_region_init_ram_guest_memfd(), but it fails:

kvm_arch_init()
-> qigvm_prepare_memory()
   -> memory_region_init_ram_guest_memfd()
      -> kvm_create_guest_memfd()
           ...
           if (!kvm_guest_memfd_supported) {
               error_setg(errp, "KVM does not support guest_memfd");
               return -1;
           }

So, I applied the following change and SVSM booted!

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa3..840f36675e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2722,17 +2722,17 @@ static int kvm_init(MachineState *ms)
 
     kvm_state = s;
 
-    ret = kvm_arch_init(ms, s);
-    if (ret < 0) {
-        goto err;
-    }
-
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
         (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
+    ret = kvm_arch_init(ms, s);
+    if (ret < 0) {
+        goto err;
+    }
+
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }

Checking, I discovered that it was done on purpose by Paolo, so not sure 
if my fix is valid:

commit 586d708c1e3e5e29a0b3c05c347290aed9478854
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Oct 11 10:39:58 2024 +0200

    accel/kvm: check for KVM_CAP_MEMORY_ATTRIBUTES on vm
   
    The exact set of available memory attributes can vary by VM.  In the
    future it might vary depending on enabled capabilities, too.  Query the
    extension on the VM level instead of on the KVM level, and only after
    architecture-specific initialization.
   
    Inspired by an analogous patch by Tom Dohrmann.
   
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

@Paolo any suggestion?

Thanks,
Stefano


