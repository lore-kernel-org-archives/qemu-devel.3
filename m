Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CEBCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBoS-0004tG-V0; Wed, 27 Aug 2025 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urBoO-0004sZ-2h
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urBoL-0001m2-Qz
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756284432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P7oh0kYRXLfOT4xiMY985mOkJaJPeTctoCXm7NsWsOo=;
 b=Rf3lAaEu1VrDLsbHRvdCMBfk3SNm0xTqedIy6ZbYaSZc9gj3Ntu0nal8ZzB3D1cx6q47k4
 414dmplwGLb/jir3C03l800wkHttgQZgyHD12SGQ7+dD+sPc39oc6wf2IYhH+/hI5IIeGy
 8K1xFDIoRKv7c6JmL/qSE6M4bLRuA/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-KUfKzkl-NUWc88mD68b41Q-1; Wed, 27 Aug 2025 04:47:09 -0400
X-MC-Unique: KUfKzkl-NUWc88mD68b41Q-1
X-Mimecast-MFC-AGG-ID: KUfKzkl-NUWc88mD68b41Q_1756284428
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0caae1so33396945e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756284427; x=1756889227;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P7oh0kYRXLfOT4xiMY985mOkJaJPeTctoCXm7NsWsOo=;
 b=mLzdFx4oac+puzvXzg1VfzzIcVGCm4eMsVA4wbnppptRKV/vTYSECCKPKDfSIyvSKs
 VKPR65DiG+lp7rmwgiPJiQYGSeVxFNFc2PGKmm4pBkfdD9N/F1v/v4LgclQRs/8xepij
 GkaZ5x8se791DsBYWzLPVcSgQYVOPmCU0vHoOdqMkxyTIT6hVFwji/WGD7h+YIgjAvcV
 cUYqtqFvprT3DTGOIS/tsbIvTGq+O7liCKiPKjFTKPaHCoIPr3fzMScx0mwXjQsTMS17
 2hvoRuRacsqWy46Lt4eqTGqJ0ZEy8zpe+0JxM1+m2xpNQ0FZcgjDbFAgXTDnXYpzky8O
 /ncA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvfi5GCD30L6WgUugLZvCupxLcNeGRL0hkVvrisensdWysqJ9nADY9V+cZncNQFrlXsjJUO2DhLpLu@nongnu.org
X-Gm-Message-State: AOJu0YxwHqwUI8GHhdZVnCH0xfS9tRskwH01nIiXBS2AngumiocTcCkK
 D4FnQcxslsj8k3rc0ckW1mb3yFoftcOUdISw3QwJdfZbwP2EPC+tgTF6/mWOLM4npAS5bkB/OUp
 qSBnFuVRMPnooPzPNIqPnsIl/4x5WeUVfXSnZBwFG3gFC1XJTy2Mku5xB
X-Gm-Gg: ASbGnctNWKiz1DlDL282ldPc559Q/cbmmXIS8do/z/pPD/auE8Y0Jz2KlEGTj5BbE+P
 Dsf/ymip5eNv7Jr1xFcP02yjGZVuFw+JnRtIj0ikwVcGDUzD0u9LGujyV2hO3HUIhsXqYIolffV
 O22haA+z59QKIQAm4uo7SpKDp8D2Ih9c17Og8vQkeYQpt4RGm5HEUSyjhj77O2KKkW/GJcccA4E
 52DMbnsJpGt++KhcWwZNyhxbzTbj9oX76XyaBVFLzTNlJKMtedq/gGfAYEXuteOZjC1C4IBR/N6
 BLA61PGXtewhXJg4zZUdNZLyVAOW/fWEf48Hi1iRAm3+otuWvf4MVgLc/ShS0BpJ+Ot/hBU5meu
 cTOtmECGTQc0NoRKCM/jOws7ePZ3fPssO3v83AKfnC0E=
X-Received: by 2002:a05:600c:8416:b0:45b:6163:c047 with SMTP id
 5b1f17b1804b1-45b6163c356mr92937915e9.17.1756284427542; 
 Wed, 27 Aug 2025 01:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgBI3WTYhNTYfVP3/nccL2jjI8xH8pbWlZ95T2NZBqH37oB2+os5RQ91UAjI9F9AxqK7kq2w==
X-Received: by 2002:a05:600c:8416:b0:45b:6163:c047 with SMTP id
 5b1f17b1804b1-45b6163c356mr92937735e9.17.1756284427085; 
 Wed, 27 Aug 2025 01:47:07 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45b69b7529asm20278755e9.0.2025.08.27.01.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 01:47:06 -0700 (PDT)
Message-ID: <1426a2bf-24fa-4424-b045-4cd37d2f091c@redhat.com>
Date: Wed, 27 Aug 2025 10:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Weird conflict with gcc-15
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <CAATJJ0++oPyjgXsekOKpHosps4jTpe9p9TWGGDpb2igbf6iipw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAATJJ0++oPyjgXsekOKpHosps4jTpe9p9TWGGDpb2igbf6iipw@mail.gmail.com>
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

On 8/27/25 10:26, Christian Ehrhardt wrote:
> Hi,
> in testing qemu 10.1 since rc levels I've found yet another odd
> behavior. As far as I can tell it's not your fault, but I wanted to
> tell you for awareness and potentially to help me get the right debug
> data.
> 
> A test that triggered when checking Ubuntu was the one of EDK2,
> emulating riscv when running on ppc64, example log [1]. Yep, yet again
> not the most common setup :-) and the same emulation in all other
> Ubuntu architectures as host works fine.
> Gladly this was reproducible and it eventually led me to a wild
> journey which now makes me consider gcc-15 (15.2.0-1ubuntu1) as the
> suspect here.
> 
> Since I know the arch, the function and the tunable - I can use a
> rather surgical mitigation like this.
> 
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index a68809eef3..5317d8be57 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -189,6 +189,13 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu,
> uint32_t ctr_idx)
>    * env->priv and env->virt_enabled contain old priv and old virt and
>    * new priv and new virt values are passed in as arguments.
>    */
> +#if defined(__powerpc64__) || defined(__ppc64__)
> + #define NO_GCSE_ATTR __attribute__((optimize("no-gcse")))
> +#else
> + #define NO_GCSE_ATTR
> +#endif
> +
> +NO_GCSE_ATTR
>   static void riscv_pmu_icount_update_priv(CPURISCVState *env,
>                                            target_ulong newpriv, bool new_virt)
>   {
> 
> But a mitigation is all that it is, ideally, I'd report this as a gcc bug.
> Yet the - understandable - hard requirement of getting the
> pre-processed files makes this quite complex. As I can't even exactly
> point to where exactly things go wrong.
> I'd ask if one of you has experience in providing gcc-bugs out of a
> qemu build. Is it as obvious as throwing -save-temps into *flags or is
> there more to consider get what would be needed?

Yes, it's like that.  Run "ninja -v 
./libqemu-riscv64-softmmu.a.p/target_riscv_pmu.c.o", stick -save-temps 
at the end and submit the resulting .i file as an attachment to the GCC bug.

Paolo


