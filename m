Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDA5CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 07:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Tvx-00080o-FW; Sat, 11 Oct 2025 03:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tvw-00080R-9l
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Tvr-0003tZ-Az
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760167340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7rrdTKc/yIaTd21uQ+OkG12xCM0OQVAwT3ozeBh/qTs=;
 b=Sl+fSFKGf/dDt/X/3zqjbYt+7jAU8rLwluRTSs1nL3d1cSiZ2hh2/g6+hMdxGmqTi32zuC
 uKUzwTSs3NkSG9mIK/JWiBtm0mDl5Njf/F7rMlOBZXg0nGZ/69YRUot1GOJcX6OVDdr31Q
 WcfilSoJTqf9kkXvCFaiZ5NM2i7sZvA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ViVRfuQtODG2h_mqkBvVkw-1; Sat, 11 Oct 2025 03:22:18 -0400
X-MC-Unique: ViVRfuQtODG2h_mqkBvVkw-1
X-Mimecast-MFC-AGG-ID: ViVRfuQtODG2h_mqkBvVkw_1760167337
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b4ea3f1c12eso339159666b.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760167336; x=1760772136;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7rrdTKc/yIaTd21uQ+OkG12xCM0OQVAwT3ozeBh/qTs=;
 b=JOD22h8C4caNQFPUf0M9P0n5Rd2KHFkCmrwIpRlbZYRI9coi/9s+0aMD5r3dcnC7jI
 W39CTXcBQ+ns0gY2lYTWyyO2GtUYMi0JAfG6oIHgN9u8pvOmYO440CN0GTLN2XOTadNi
 BDkGiJBdwUy+6vquvoHPicqAFo2dfKEOj6ayN2CuT/jUU1F874FlRFYFLg9nwIASAiAp
 Jf451gbzd8rZMdMf7s1MQzSYwELS7QYyqmsIsk7Id29NyZLpoKVtxIoRGh2NjxeMwoQB
 2AslhhjscF0WPlV/W4YNR14pas9B1H0tv2NoC8txpZFWWfqhREX03JU26Sy/0aMJpP6J
 fjMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ZdrulyDYFeMZoWfhKtVvduHrQ/qLTLFENqSw0bLIGbBZW+ntywaWhUIyAjW/h2HxkeCXXQ1SuKdR@nongnu.org
X-Gm-Message-State: AOJu0YzQltM6XYO8BeCa5Y7wLAxTvDnyqZcKdQFP3h+yjBZklUDBa9wb
 CsNyumdM8Nx/fplOzxXnfW0tcrhyumh9wKWU9+v831waxSl8Oy73bvQoKYmeSTLVUS4KInhLzF6
 yLV4TOQzqWz9kLQzFh8ktFVGNjAunJ6mG9We8s17T/z4E04V1EX5LqwOBdb2F8kb0
X-Gm-Gg: ASbGncuXKS0oMx4SO1ZtFlPFJM0xeJS+RT7R7eI+bkn97Xu3+Mt3B1q8+urTXCvSbYu
 UPk/R4N2KWqOFUNyMJFPba5VgHuvqrk1dp14Ov7H8GHOcZJKlNJTYa3cyRwrgABL8/WoOGwwQkn
 mpm/WwFaV058Cof31eKUXYsuJ3IvjNURa3Jr3bLy6wGTN3g+7Q0dJVwM7HJdm1URRboCOMCk8Qs
 YJ9pYkRr74k0KR7MUQ00TdoTRGeGnTfXurLE+aGdhlAmzmq8Z6zJ7RX6sjAvbIW7H9+BZnxo6CY
 vQe+ikqmui8mcLC1CO9bhSe+IVDtpNfPPCf2bF9HgRrgAZ1HBtlpjpZTwAxzeg8S2XP8YBfnILo
 pC746HlUVl2SeE3zqF2HXnxgv7pKE11a8lg9ntfuzQfGr
X-Received: by 2002:a17:907:c05:b0:b3e:fe8f:764 with SMTP id
 a640c23a62f3a-b50ac0cc05fmr1478851766b.32.1760167336591; 
 Sat, 11 Oct 2025 00:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFolHZDr/hilaBuYpn/xuoq2o2sw7kV6NjzNz8W0VyvOLJC7Gg7q9fNdh7/o1Vu9xzKl0xFkQ==
X-Received: by 2002:a17:907:c05:b0:b3e:fe8f:764 with SMTP id
 a640c23a62f3a-b50ac0cc05fmr1478846566b.32.1760167334852; 
 Sat, 11 Oct 2025 00:22:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b55d5cac043sm418010166b.13.2025.10.11.00.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Oct 2025 00:22:14 -0700 (PDT)
Message-ID: <b4223672-19c2-4d06-b7b0-0eed1a55bde0@redhat.com>
Date: Sat, 11 Oct 2025 09:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i386/tcg/smm_helper: Properly apply DR values on SMM
 entry / exit
To: YiFei Zhu <zhuyifei@google.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-stable@nongnu.org,
 unvariant.winter@gmail.com, YiFei Zhu <zhuyifei1999@gmail.com>
References: <cover.1758794468.git.zhuyifei@google.com>
 <2bacb9b24e9d337dbe48791aa25d349eb9c52c3a.1758794468.git.zhuyifei@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <2bacb9b24e9d337dbe48791aa25d349eb9c52c3a.1758794468.git.zhuyifei@google.com>
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
> do_smm_enter and helper_rsm sets the env->dr, but does not sync the
> values with cpu_x86_update_dr7. A malicious kernel may control the
> instruction pointer in SMM by setting a breakpoint on the SMI
> entry point, and after do_smm_enter cpu->breakpoints contains the
> stale breakpoint; and because IDT is not reloaded upon SMI entry,
> the debug exception handler controlled by the malicious kernel
> is invoked.
> 
> Fixes: 01df040b5247 ("x86: Debug register emulation (Jan Kiszka)")
> Reported-by: unvariant.winter@gmail.com
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Applied, thanks!

Paolo

> ---
>   target/i386/tcg/system/smm_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
> index 251eb7856c..fb028a8272 100644
> --- a/target/i386/tcg/system/smm_helper.c
> +++ b/target/i386/tcg/system/smm_helper.c
> @@ -168,7 +168,7 @@ void do_smm_enter(X86CPU *cpu)
>                          env->cr[0] & ~(CR0_PE_MASK | CR0_EM_MASK | CR0_TS_MASK |
>                                         CR0_PG_MASK));
>       cpu_x86_update_cr4(env, 0);
> -    env->dr[7] = 0x00000400;
> +    helper_set_dr(env, 7, 0x00000400);
>   
>       cpu_x86_load_seg_cache(env, R_CS, (env->smbase >> 4) & 0xffff, env->smbase,
>                              0xffffffff,
> @@ -233,8 +233,8 @@ void helper_rsm(CPUX86State *env)
>       env->eip = x86_ldq_phys(cs, sm_state + 0x7f78);
>       cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7f70),
>                       ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK));
> -    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7f68);
> -    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7f60);
> +    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
> +    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
>   
>       cpu_x86_update_cr4(env, x86_ldl_phys(cs, sm_state + 0x7f48));
>       cpu_x86_update_cr3(env, x86_ldq_phys(cs, sm_state + 0x7f50));
> @@ -268,8 +268,8 @@ void helper_rsm(CPUX86State *env)
>       env->regs[R_EDX] = x86_ldl_phys(cs, sm_state + 0x7fd8);
>       env->regs[R_ECX] = x86_ldl_phys(cs, sm_state + 0x7fd4);
>       env->regs[R_EAX] = x86_ldl_phys(cs, sm_state + 0x7fd0);
> -    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7fcc);
> -    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7fc8);
> +    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
> +    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
>   
>       env->tr.selector = x86_ldl_phys(cs, sm_state + 0x7fc4) & 0xffff;
>       env->tr.base = x86_ldl_phys(cs, sm_state + 0x7f64);


