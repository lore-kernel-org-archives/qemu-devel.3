Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B7AC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoPE-0005PL-VJ; Thu, 27 Jun 2024 08:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sMoP8-0005NO-Bl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sMoP6-0007Rc-4p
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719491947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7G5yMMAULPdfA62qHoyWahrZY1PyXyLJBLzlRLOr6c=;
 b=YGopjoYFKAWO7mOEeHgO/jFnL9AdOq7Q3ceszI44Ab/Vf0CB8OoVipqRJJl4gsBvVCKmoY
 c0ltemMdtA5S6EitRkQhl2WBGxPi3TZfIjEt6DFuZi9gK5/cu/Jn9Vbq/ppCoaQdXwSapD
 16uMTinMFwO9AQSKnV1MTSKbrVApOYA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-H9cdh-_7N6-XO3jBZldsYg-1; Thu, 27 Jun 2024 08:39:05 -0400
X-MC-Unique: H9cdh-_7N6-XO3jBZldsYg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d34e190d9so873403a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719491944; x=1720096744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7G5yMMAULPdfA62qHoyWahrZY1PyXyLJBLzlRLOr6c=;
 b=uTnY0mNgp/HXi2cbJSTVvGVP3mJX/p5HoV56dNVFkRSaD/wiXNdD4raFRRyjKSTb0q
 3js9o5eocTnyltNOWrtpXcjZTnUW4hrEHUI3Z+wYgxnvRFQPfSNZR1GicJHqJrtxf2HE
 7Ql0t7FbAvR0obLkSlj8/DEYCEI6PGNwDkPeKA08gHhN8lnTkJn8QhpU+9NYx7nnkuad
 5EnuHMb2t7K0AX0hV5REq9iosMm3A8LgR7Q24UXdzN7gafbUXawrn3NWWb5kZTSK4Jb8
 NraTEjnclKmpD/YlE/kO8PoHJg32COnJ8vmwu7wgTkRxuvPjIxdPbeeJDkzfMQb0GLE9
 4EKA==
X-Gm-Message-State: AOJu0YwUrPnrCBB5Sg52NRtX2JfC7lA+wRYQbtosN+xZnLHuhgWbCkpF
 JSOz4Zo55P3TwkReOSzthl+tN2yk3j9wdKNGCpGkbEfmUBHSjHFVh7uyUjkA5c3o6Hj0GpgBbkM
 urHl6VUO4wgssg1zxPU5zEBihaz7g+ar7W+Gw7EKH7dQDAdc65pTB
X-Received: by 2002:a50:99d4:0:b0:57d:34e2:f554 with SMTP id
 4fb4d7f45d1cf-57d4bd61381mr12299394a12.11.1719491944432; 
 Thu, 27 Jun 2024 05:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoAEV5PbcMWz7iUEzXYCn+kOXyEyWNrge8IL7aSTsAdqIvcow8YQBcjyBNmx5zU+HFKMY6WA==
X-Received: by 2002:a50:99d4:0:b0:57d:34e2:f554 with SMTP id
 4fb4d7f45d1cf-57d4bd61381mr12299328a12.11.1719491942800; 
 Thu, 27 Jun 2024 05:39:02 -0700 (PDT)
Received: from sgarzare-redhat (83.0.40.93.internetdsl.tpnet.pl. [83.0.40.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5855a0f07cdsm382414a12.42.2024.06.27.05.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:39:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:38:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 05/15] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
Message-ID: <irp5co5giwcafxf6jd6vdbzt4r7aeag2ozwkxasex5rqwfeesx@t2m6ssrkckor>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <97a1d5af646b0d6c3d1fe30022bcb61a16e46d95.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <97a1d5af646b0d6c3d1fe30022bcb61a16e46d95.1718979106.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 21, 2024 at 03:29:08PM GMT, Roy Hopkins wrote:
>When using an IGVM file the configuration of the system firmware is
>defined by IGVM directives contained in the file. In this case the user
>should not configure any pflash devices.
>
>This commit skips initialization of the ROM mode when pflash0 is not set
>then checks to ensure no pflash devices have been configured when using
>IGVM, exiting with an error message if this is not the case.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>---
> hw/i386/pc_sysfw.c | 23 +++++++++++++++++++++--
> 1 file changed, 21 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>index ef80281d28..39e94ce144 100644
>--- a/hw/i386/pc_sysfw.c
>+++ b/hw/i386/pc_sysfw.c
>@@ -239,8 +239,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     }
>
>     if (!pflash_blk[0]) {
>-        /* Machine property pflash0 not set, use ROM mode */
>-        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);

We have the same call, a few lines above if `pci_enabled` is false, 
should we make the same change there as well?

>+        /*
>+         * Machine property pflash0 not set, use ROM mode unless using 
>IGVM,
>+         * in which case the firmware must be provided by the IGVM file.
>+         */
>+        if (!MACHINE(pcms)->igvm) {
>+            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
>+        }
>     } else {
>         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>             /*
>@@ -256,6 +261,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
>     }
>
>     pc_system_flash_cleanup_unused(pcms);
>+
>+    /*
>+     * The user should not have specified any pflash devices when using IGVM
>+     * to configure the guest.
>+     */
>+    if (MACHINE(pcms)->igvm) {
>+        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>+            if (pcms->flash[i]) {
>+                error_report("pflash devices cannot be configured when "
>+                             "using IGVM");
>+                exit(1);
>+            }
>+        }
>+    }
> }
>
> void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
>-- 
>2.43.0
>


