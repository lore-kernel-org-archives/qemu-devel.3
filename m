Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC2BE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 08:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyyX-00032A-Te; Thu, 19 Feb 2026 03:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsyyW-000322-O0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsyyU-0002LS-Ki
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 03:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771488085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAxpUG9VW3YNXnvK9kA9pTeaSV/UZYNFuQ0Xzap3dn8=;
 b=DbJDfxsSsBakMAnonnR94ZvAIPo42xw/q2nQND5kKqJq4b0gTBw9hPMWB+dn5Y1dR25lZO
 gEIUjz7RQKMnMY+cbYmOczEISNScrkCTGHETEbYX5XNNcbE91daVcyeDwdmekRVgAq+9Ds
 d8ipUaV0FTCKD37+DOWgjUlyezGs2FQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-DOQu0LyBM0GAe4fdTYrwFw-1; Thu, 19 Feb 2026 03:01:23 -0500
X-MC-Unique: DOQu0LyBM0GAe4fdTYrwFw-1
X-Mimecast-MFC-AGG-ID: DOQu0LyBM0GAe4fdTYrwFw_1771488082
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aaf2f3bef6so7180885ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 00:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771488082; x=1772092882; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HAxpUG9VW3YNXnvK9kA9pTeaSV/UZYNFuQ0Xzap3dn8=;
 b=jDlnJ41wrniNx00B0g96DOVjELAmMa+T9VoGB6N5qVljYX9Tcmd5Rlb3XxKu410HUs
 9WXU7ormyH6YFLlEtbpT5HP01WFtWajT7wTmaWOmeBiHvgE2Zj62FSAfrDPZ54NJwWR3
 /kFF0mcBExEldsecdb0/fPv5meJ70thig8Z/5Kcz9d4L79zC4U2wkGWVZ1ruyphBdJEI
 hBxiOm8JZcICMvcsA1dRUuKOElnBkbt82JGUKcF2MMMgTiTQqwhi4DDs3d15VG8h6NKP
 S7WUa/mOo6nugQgRFFgjTjq2tFRg+q5i7HzPUCUQFimSfoq7YrdVNe6AkhfVnU3G5OFd
 z4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771488082; x=1772092882;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HAxpUG9VW3YNXnvK9kA9pTeaSV/UZYNFuQ0Xzap3dn8=;
 b=RvDFeJuevchR6RYNvXa3MVFr1g/wEXwrJ133RRqgOYIYeQ+H4u64u2ahTimvNWM4ZA
 0FBw65NOXQeWQAUXNgih20HRrS7EFRhNzbyJMRNgdBGRdv82N3hwhVJvCULeIntR7YKA
 nmHcyJKcV8vVkgrx6Hyrh0RhnXJzGvW3WV3Kg7mT+AZRY3MyE3ddnbNuRhNDYbjdsEFH
 izeds3uD3UCfAYB++WbZMfnJIxm3V9ywW4PqxTomb/UMOX6bI39+ahiu95+S4qptB95e
 8gfvCQz77vWP7U+i8AiXg6GfybmNMv9vT37z7+9vQ+1zDkBOBuY5lxZM0pEQQHpn7w3C
 p1Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6OVlWkLSqDKgevdlTruWYqwNxIsCWU2FPusdI6oKSJ1OO2+gHVbcKNrhL9Zvxfl4YgUSvDCZ67Mre@nongnu.org
X-Gm-Message-State: AOJu0YzqiSjXm9EYBfXxiU5cbnKehkUypSpw93U6prdZvpxfYi3ZquOT
 TqNd4RTJfokr19kxMzeM+1yhsp7eEYvLTJ6+akryVIFn3dvXcjbCzmokrD9OYu2Vh+7WPvNkEJc
 Xe40qexBkcBd9mvG5Oaa0vOXLvCMMksXJhE/WkCHtFRnZ+C3kT1SKg2bC
X-Gm-Gg: AZuq6aJtPvgtpsT9lG3Q+1pZzKV6IqR1axK8gNN3QrTVXsv2D337JM4Okul0ewuEGDI
 Ifml1Rbo2ZG/YHN3t2ImRBL1yC8xg+T2zmE3MBTiDOuTV1JPus+KUD8B1muRS4lBDLC0zZJuZd4
 lxjVrT+MA7YjJqBzAqblSPaoeI69zRV5Hgjq8BP1FHA56cuyvmy8UWTiBUz+KOqg2EL6PfVlKxN
 tdSL0606j0jyzzPXvswl6E52GAoqVFF1vTQq1GaDJUueTcvLDupmegkHfqdXGmiqFCh6QJlPHSU
 d6aiFiKKQVXr6zXTPr1B6UuOMPIw2YmOxGG7wPTYlcryRXKGfFdmXlBof8lVFlWoTleGE/ijnCy
 /8LPVMxLcHiHK16u9dKTih3b9yF35AlMk1X5XhqyWaBtuu3gva5Y=
X-Received: by 2002:a17:902:fc4f:b0:2aa:cfee:a472 with SMTP id
 d9443c01a7336-2ad1751b6a9mr185217755ad.45.1771488082279; 
 Thu, 19 Feb 2026 00:01:22 -0800 (PST)
X-Received: by 2002:a17:902:fc4f:b0:2aa:cfee:a472 with SMTP id
 d9443c01a7336-2ad1751b6a9mr185217445ad.45.1771488081689; 
 Thu, 19 Feb 2026 00:01:21 -0800 (PST)
Received: from fc40 ([117.99.83.54]) by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa31asm157429325ad.4.2026.02.19.00.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 00:01:21 -0800 (PST)
Date: Thu, 19 Feb 2026 13:31:16 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
In-Reply-To: <3D89ED00-C696-4ECA-BE4C-7ADF04631900@redhat.com>
Message-ID: <a03128b2-ce06-3e22-08f2-2eea68f0afe1@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
 <CAK3XEhOFvXUEiO3z1MhGqjBQUH3hB_3u9suLpweBs9vaTr1zog@mail.gmail.com>
 <61f1dfa8-705e-4f2f-ac9c-35da4e8eac02@redhat.com>
 <3D89ED00-C696-4ECA-BE4C-7ADF04631900@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="279738495-1192910796-1771488081=:26053"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--279738495-1192910796-1771488081=:26053
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 19 Feb 2026, Ani Sinha wrote:

>
>
> > On 18 Feb 2026, at 11:09 PM, Cédric Le Goater <clg@redhat.com> wrote:
> >
> > On 2/18/26 18:33, Ani Sinha wrote:
> >> On Wed, Feb 18, 2026 at 9:00 PM Cédric Le Goater <clg@redhat.com> wrote:
> >>>
> >>> On 2/18/26 16:07, Ani Sinha wrote:
> >>>>
> >>>>
> >>>>> On 18 Feb 2026, at 7:37 PM, Cédric Le Goater <clg@redhat.com> wrote:
> >>>>>
> >>>>> On 2/18/26 12:42, Ani Sinha wrote:
> >>>>>> Normally the vfio pseudo device file descriptor lives for the life of the VM.
> >>>>>> However, when the kvm VM file descriptor changes, a new file descriptor
> >>>>>> for the pseudo device needs to be generated against the new kvm VM descriptor.
> >>>>>> Other existing vfio descriptors needs to be reattached to the new pseudo device
> >>>>>> descriptor. This change performs the above steps.
> >>>>>> Tested-by: Cédric Le Goater <clg@redhat.com>
> >>>>>
> >>>>> There is a regression since last version.
> >>>>>
> >>>>>
> >>>>> 'reboot' from the guest and command 'system_reset' from the QEMU
> >>>>> monitor now generate these outputs:
> >>>>>
> >>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
> >>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
> >>>>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
> >>>>>   ...
> >>>>>
> >>>>> and QEMU exits after a while.
> >>>>
> >>>> I have only seen this in SEV-ES with more than one vcpus. Never with TDX or SEV-SNP (single or multiple cpus).
> >>>> On which host/guest type did you see this?
> >>>
> >>> SEV-SNP on a RHEL9 host. Same guest I used before and host says :
> >>>
> >>>    [1816531.409591] kvm_amd: SEV-ES guest requested termination: 0x0:0x0
> >> Strange! I am not sure why KVM thinks it's SEV-ES. I have done all my
> >> SEV-SNP and TDX testing on a fc43 host and for SEV-ES I used a fc42
> >> host. I have not seen this kind of guest termination on SEV-SNP or TDX
> >> on that host. I am sure there are some differences between the RHEL9
> >> host kernel and fc43 kernel.
> >
> > The same issue occurs with a rhel10 kernel.
>
> OK good news is that I see this issue on the latest rhel9 host but not on a fc43 host.
> The issue happens only when > 1 cpus are created for the guest. With only one cpu seems its fine.
> I tried a minimalistic guest with only a kernel passed as UKI as well as a full blown fc43 guest. Both manifest the same issue with > 1 vcpu threads.
>
> There is a regression indeed between versions. My v3 which I posted just before FOSDEM seems good and does not show this behaviour on the same RHEL 9 host.
> Both v4 and v5 are affected. This means regression is somewhere in my changes, not due to host kernel changes.
>
> This shows a little bit more information:
>
> bash-5.1# /usr/sbin/reboot -f
> [   43.920835] ACPI: PM: Preparing to enter system sleep state S5
> [   43.922988] reboot: Restarting system
> [   43.924242] reboot: machine restart
> qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00800f12
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
> ES =0000 00000000 0000ffff 00009300
> CS =f000 00800000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> It is likely that the changes towards fixing non-coco reset case with QMP “system_reset” introduced this regression. I will have to audit changes between v3 and v4.
>

Alright fixed this. Basically I had dropped
https://gitlab.com/anisinha/qemu/-/commit/b413141cd8a5b599214153a5e37b485443885718
but this is needed. Also I need to call cpu_synchronize_all_post_init()
for the coco case as well. This will also set vcpu->dirty = false and this
will make subsequent code paths happy.

please try this patch on top of my v5. It should fix the issue. I tested
on a RHEL 9 host and a fc43 SEV-SNP host, 1 or multiple vcpus, two
different guests and all looks good.

From 26db44eba8c727160dd9e97c9d5582a0ddc5884d Mon Sep 17 00:00:00 2001
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Feb 2026 13:12:02 +0530
Subject: [PATCH] Call cpu_synchronize_all_post_init for coco as well

Fixes issue reported by Cedric

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d7ea60f582..0610bf8434 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2816,7 +2816,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }

     s->vmfd = ret;
-
+    kvm_state->guest_state_protected = false;
     kvm_setup_dirty_ring(s);

     /* rebind memory to new vm fd */
@@ -2872,6 +2872,9 @@ static int kvm_reset_vmfd(MachineState *ms)
      * kvm fd has changed. Commit the irq routes to KVM once more.
      */
     kvm_irqchip_commit_routes(s);
+    if (ms->cgs) {
+        cpu_synchronize_all_post_init();
+    }
     trace_kvm_reset_vmfd();
     return ret;
 }
-- 
2.49.0

--279738495-1192910796-1771488081=:26053--


