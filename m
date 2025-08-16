Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BCDCA0EE6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 08:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unBvG-0004Jm-8X; Sat, 16 Aug 2025 04:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1unBvD-0004Ja-Tc
 for qemu-devel@nongnu.org; Sat, 16 Aug 2025 04:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1unBvA-0001ZB-RR
 for qemu-devel@nongnu.org; Sat, 16 Aug 2025 04:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755331546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vbHvXGC+RfUnaSd9ye/zy56zPGb6I01VrbXEkgDsHOA=;
 b=i1qqS0e/SILlEaLdEQz4TY81RyRVfU9jePl20h3GkoEdF/N5wEq5O0M2Dc1voeveViOZ3L
 HyoBtOlAHcdRJdqcJqPxe3y6KAX+AKTLuezoK5vxjOb2SWO58TWJDftzYMFIJjgrKRI3NH
 0ety8NM5Xlsh59433Ysbs15puaqLW7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-vFWqugb7NC6C2Q2ZiWa3jw-1; Sat, 16 Aug 2025 04:05:43 -0400
X-MC-Unique: vFWqugb7NC6C2Q2ZiWa3jw-1
X-Mimecast-MFC-AGG-ID: vFWqugb7NC6C2Q2ZiWa3jw_1755331543
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b9edf2d82dso1341601f8f.2
 for <qemu-devel@nongnu.org>; Sat, 16 Aug 2025 01:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755331543; x=1755936343;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vbHvXGC+RfUnaSd9ye/zy56zPGb6I01VrbXEkgDsHOA=;
 b=V0hhslkewNI8E9JkewB6H7146IQfLx6YzELzyZTKAqA416f73ikE9AmY23RmYuQdVu
 h1XYNhsnffL62zh42JsW7v3KsGPnsVcJO578+XgY8rcUNhsYQwu1GX9tbAri6qVxqEqB
 vAs+c9icD50A/C8MoTqMzwaOVgq++N9bqkaxkvycjZbBJLHmT8Pnq8ChTkIuvcZ1ErjV
 n8n7FQRbSt7j1UmO8AX+v5buqc04/cqQ3GGw3XUOAM6WCBmMNqiNI0lonndjwi03fy/E
 C/Rn7I0tVMCMFcz9GWfiB44v18s5kwaXzI/iWMBuiksrJKzrvSjiTHVzfyZeMQYgX7Td
 GA5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHs7vbjUXSwAXj2T7KT4LR5VmhIhoiPOhtH/nOqJ0iyZ26vtSkCCDMUvG26FakPJ3lPvR3xs0bkzyG@nongnu.org
X-Gm-Message-State: AOJu0Yx75LkoIyzxT2sMDvUzviHhRf6cKQxf7of0gJV0Q3KGOyPOl4A1
 hDTyiIeANaiPSKH1cGd6TqUdn18yqWWkiGg+gN6fa4xRnV1IZmeYr9e2fXKtT+sP0LFDymqYOjS
 1VArC1ETC2mUR9uEElqpl8kKYG4pIHnVkSTLrt3m0MYpZ/euSiz0os9h7
X-Gm-Gg: ASbGnctbwmln/reE3naNnnAmDQGDquL4UBjbIZ09vUKRXBuRas8fisqMg0XccjiMbxn
 agbWbjF/Gx3VvsI9QB06fyMmeVsl4uCIcjTqIC+bsKqHRVuhHJ1266vFnY4Kmghw2YPm18vRYmy
 J88OX1Nt4yYwIwgo/5HzPrtnNLastml61k2c8IqLM22eIC3guKxk3pPNrFutMPvJCKWdi4lXOiY
 ReOVtQnzCoyEI1vVyojFK2QuCm7Hk72mQ+XCgT3BA9t5MtVjwV538krzqR59T93n7PXtJfc+R8S
 5j4HFqBthWF4W09qPlz1WLTGrVzI5/D8hd8RCMfdOULj
X-Received: by 2002:a05:6000:2012:b0:3b8:d16a:a4b1 with SMTP id
 ffacd0b85a97d-3bb6969a801mr3446047f8f.58.1755331542697; 
 Sat, 16 Aug 2025 01:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5NHlMGlNhYlBmryFLBRXLScY4f+/QftcTYwht+BoY9SwTeTioAesZhwLdsSxP9mg0sJREdQ==
X-Received: by 2002:a05:6000:2012:b0:3b8:d16a:a4b1 with SMTP id
 ffacd0b85a97d-3bb6969a801mr3446023f8f.58.1755331542216; 
 Sat, 16 Aug 2025 01:05:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3bb64d29a70sm4876544f8f.17.2025.08.16.01.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Aug 2025 01:05:41 -0700 (PDT)
Message-ID: <9351d1d2-d487-45fe-8251-16c6c6ad5976@redhat.com>
Date: Sat, 16 Aug 2025 10:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v4 1/1] Default disable ignore guest PAT quirk
To: ~myrslint <myrskylintu@proton.me>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <175527721636.15451.4393515241478547957-1@git.sr.ht>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <175527721636.15451.4393515241478547957-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/15/25 18:53, ~myrslint wrote:
> From: myrslint <qemu.haziness801@passinbox.com>
> 
> Most Intel CPUs in current use have self-snoop. The few added lines of
> code also check for availability of the quirk disablement option so if
> some CPU does not have this feature no change of behavior will occur.
> 
> Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943
> ---
>   target/i386/kvm/kvm.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8..1102866a89 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -16,6 +16,7 @@
>   #include "qapi/qapi-events-run-state.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> +#include <asm-x86/kvm.h>
>   #include <math.h>
>   #include <sys/ioctl.h>
>   #include <sys/utsname.h>
> @@ -3367,6 +3368,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>   
> +    /* rationale: most x86 cpus in current use have self-snoop so honoring
> +     * guest pat is preferrable.

More precisely, KVM will not expose KVM_X86_QUIRK_IGNORE_GUEST_PAT if
the CPU doesn't have self snoop:

         if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
                 kvm_caps.supported_quirks &= ~KVM_X86_QUIRK_IGNORE_GUEST_PAT;


> +     * as well, the bochs video driver bug which
> +     * motivated making this a default enabled quirk in kvm was fixed long ago
> +     * */
Unfortunately, "less than one year" is not long ago. :(  Maybe it can be
done in a machine-init-done notifier, and only if a bochs-drm device has
not been added?  You can add a function call

	kvm_hack_do_not_enable_guest_pat();

to bochs_display_realize(), and something like this to target/i386/kvm/kvm.c:

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f9c63c422f0..0b51457e605 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2696,13 +2696,13 @@ static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu,
      return true;
  }
  
-static Notifier smram_machine_done;
+static Notifier kvm_machine_done;
  static KVMMemoryListener smram_listener;
  static AddressSpace smram_address_space;
  static MemoryRegion smram_as_root;
  static MemoryRegion smram_as_mem;
  
-static void register_smram_listener(Notifier *n, void *unused)
+static void register_smram_listener(void)
  {
      MemoryRegion *smram =
          (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
@@ -2730,6 +2730,18 @@ static void register_smram_listener(Notifier *n, void *unused)
                                   &smram_address_space, 1, "kvm-smram");
  }
  
+static void kvm_machine_done(Notifier *n, void *unused)
+{
+    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
+        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        register_smram_listener();
+    }
+    if (!kvm_got_bochs_drm) {
+        disable_ignore_guest_pat_quirk();
+    }
+}
+
  static void *kvm_msr_energy_thread(void *data)
  {
      KVMState *s = data;
@@ -3310,12 +3322,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
          return ret;
      }
  
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
-        smram_machine_done.notify = register_smram_listener;
-        qemu_add_machine_init_done_notifier(&smram_machine_done);
-    }
+    smram_machine_done.notify = kvm_machine_done;
+    qemu_add_machine_init_done_notifier(&smram_machine_done);
  
      if (enable_cpu_pm) {
          ret = kvm_vm_enable_disable_exits(s);


Check out how kvm_arm_supports_user_irq() is done, for an example
of adding KVM hooks/hacks to commoncode.

Paolo


