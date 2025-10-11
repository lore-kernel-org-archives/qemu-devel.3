Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF4CCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Ttj-0007EG-4s; Sat, 11 Oct 2025 03:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Ttb-0007Dj-Fe
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7TtV-0002mu-Vh
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760167194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XCJCEykNdI7950mUbWVAavAfoDTDY8M442ttT/PHhVo=;
 b=GoOTq6gQCgHkUztiRGmiqTOotl0FkQV8do5jo2H+sL1BtGL8rM529CJ1CeNkw2h/1gFDTG
 NgBLXwmxCEqENrm+uAZCwGNWcFHi4HxaxOWFP5VgUqQRrlsFeFuxshkRaMv9CWlVIxnitz
 WHqsdu2qtHacqtBh9zEDS6X97O4uDQ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Miu1noLcOZqT5kzk0U9LXg-1; Sat, 11 Oct 2025 03:19:53 -0400
X-MC-Unique: Miu1noLcOZqT5kzk0U9LXg-1
X-Mimecast-MFC-AGG-ID: Miu1noLcOZqT5kzk0U9LXg_1760167192
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so218612666b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167192; x=1760771992;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCJCEykNdI7950mUbWVAavAfoDTDY8M442ttT/PHhVo=;
 b=ZZMYBGlMXDGg6t7a2BEi2Fz8vlRy1s0p+NdotUnJ9RJ2kNUcAkmoBXCHvle4Oow3NC
 fHe5jb1O62dmaMH+d0gy+mhx0IM7Y24V4Wi+UNj0aTB57USoSTlXWbfxKuMdrKtfkHAj
 JSXQTm/u6+ZCAt3wsOg/fEU45PKi672DQt6UsTLERTJpxvHcRI3ClgHGAFglAI3aickP
 GmM6Nt/GD38WqF8xv4csisGcrMT95tpmyhEOYSi9NC+m7dBOcbzWGzRD4Ru/qkCATEDZ
 3h6LlFk9/IUxIZF7XOr2g68RBSS7HoZ7/alW5VbJASYe3eN+00jbPHoVukyB+usJP18i
 Zzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk3EnXPenZfjKXC5AR9rMQGSoQLn27A6sVwXXMoY1gXNIAQKgxhMLiZkG3nMbzP9BBe5z8OmJ8iF5Q@nongnu.org
X-Gm-Message-State: AOJu0YxMTm8kC2mBmfJQpOcF+tQUaQWR56I8Xf34lzQrcYYCtP2dmppB
 H4GzLmwdKl8YiD7HcTMkwM1cmxUQhDxKktOmN6fEXdosnM52Dr5p3K5rCCmaFECHgDpw7DXe13t
 6P24ZCN1TWRtAI43g/qAsnkEwKEXsW6s5eGSTi574li5x30NBslV7BKqe
X-Gm-Gg: ASbGncsWZe2daDTs/y0cJZe0E+KylWZm7UDOYelaXwoHxuHL5i4IP0QdTxCihh7FrhR
 8bZJkvLUR5KNuSSzhZxMZMltJaXExJWN1aoFG3OVC+cEQwjhiSGQynj5n0WNiX7wz2Rq2BCnZYA
 SddZAYGphfU0Q8LbzxhPGgQCHKQJGRdY7nbGUTYEEOt1pqir3PHndziqozP7bMzJpDrryRh77ez
 pWmgS1Fq5gYAcKpS0qz8iwFVGBZ7uAF1vb+yWI+e0I/AohDHfCkHLK33fmTjUTVZnU6irfKzxWQ
 yv6fgzWz6Lfe7bpsHVSv1TmyrotfjbbFEqcwl74OawuROl0k+0kqlK4lrQ3sqmqifScsbbFiCZA
 ZLoas7Fr2hJKvtz2dg6OXSC29sXQPzb/rt09UeH6oF/vC
X-Received: by 2002:a17:907:da2:b0:b48:baf8:a737 with SMTP id
 a640c23a62f3a-b50acc2f57fmr1518422466b.58.1760167191981; 
 Sat, 11 Oct 2025 00:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFpcdcEPmZcEt4kb1ePUD7yL125WmYyNHf426/gyzRYZXjkOqQQsE7/JwCf9MeVHafg+Olag==
X-Received: by 2002:a17:907:da2:b0:b48:baf8:a737 with SMTP id
 a640c23a62f3a-b50acc2f57fmr1518419966b.58.1760167191501; 
 Sat, 11 Oct 2025 00:19:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b55d900e151sm418148166b.68.2025.10.11.00.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Oct 2025 00:19:50 -0700 (PDT)
Message-ID: <2f1ab909-d220-495e-bb14-c231a0e0bb49@redhat.com>
Date: Sat, 11 Oct 2025 09:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/cpu: Prevent delivering SIPI during SMM in TCG
 mode
To: YiFei Zhu <zhuyifei@google.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-stable@nongnu.org,
 unvariant.winter@gmail.com, YiFei Zhu <zhuyifei1999@gmail.com>
References: <cover.1758794468.git.zhuyifei@google.com>
 <ca9b26db036fe39ffcb2ebbf7b8629b08632b8c2.1758794468.git.zhuyifei@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <ca9b26db036fe39ffcb2ebbf7b8629b08632b8c2.1758794468.git.zhuyifei@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/25/25 12:30, YiFei Zhu wrote:
> A malicious kernel may control the instruction pointer in SMM in a
> multi-processor VM by sending a sequence of IPIs via APIC:
> 
> CPU0			CPU1
> IPI(CPU1, MODE_INIT)
> 			x86_cpu_exec_reset()
> 			apic_init_reset()
> 			s->wait_for_sipi = true
> IPI(CPU1, MODE_SMI)
> 			do_smm_enter()
> 			env->hflags |= HF_SMM_MASK;
> IPI(CPU1, MODE_STARTUP, vector)
> 			do_cpu_sipi()
> 			apic_sipi()
> 			/* s->wait_for_sipi check passes */
> 			cpu_x86_load_seg_cache_sipi(vector)
> 
> A different sequence, SMI INIT SIPI, is also buggy in TCG because
> INIT is not blocked or latched during SMM. However, it is not
> vulnerable to an instruction pointer control in the same way because
> x86_cpu_exec_reset clears env->hflags, exiting SMM.

Thanks for the reports!  For this bug, I prefer to have the CPU eat the 
SIPI instead of latching them:

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6d7859640c2..c7680338563 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -646,8 +646,6 @@ void apic_sipi(DeviceState *dev)
  {
      APICCommonState *s = APIC(dev);

-    cpu_reset_interrupt(CPU(s->cpu), CPU_INTERRUPT_SIPI);
-
      if (!s->wait_for_sipi)
          return;
      cpu_x86_load_seg_cache_sipi(s->cpu, s->sipi_vector);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 651041ccfa6..a96834c4457 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -621,6 +621,9 @@ void do_cpu_init(X86CPU *cpu)

  void do_cpu_sipi(X86CPU *cpu)
  {
+    if (env->hflags & HF_SMM_MASK) {
+        return;
+    }
      apic_sipi(cpu->apic_state);
  }

diff --git a/target/i386/tcg/system/seg_helper.c 
b/target/i386/tcg/system/seg_helper.c
index 38072e51d72..8c7856be81e 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -182,6 +182,7 @@ bool x86_cpu_exec_interrupt(
          apic_poll_irq(cpu->apic_state);
          break;
      case CPU_INTERRUPT_SIPI:
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
          do_cpu_sipi(cpu);
          break;
      case CPU_INTERRUPT_SMI:


Fixing INIT is harder, because it requires splitting CPU_INTERRUPT_INIT 
and CPU_INTERRUPT_RESET, but I'll take a look.

Paolo

> Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an SMI")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   target/i386/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 6d85149e6e..697cc4e63b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9762,7 +9762,8 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
>       if (interrupt_request & CPU_INTERRUPT_POLL) {
>           return CPU_INTERRUPT_POLL;
>       }
> -    if (interrupt_request & CPU_INTERRUPT_SIPI) {
> +    if ((interrupt_request & CPU_INTERRUPT_SIPI) &&
> +        !(env->hflags & HF_SMM_MASK)) {
>           return CPU_INTERRUPT_SIPI;
>       }
>   



