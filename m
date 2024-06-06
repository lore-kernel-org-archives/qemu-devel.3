Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D89C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8zp-0002Pw-59; Thu, 06 Jun 2024 05:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8zl-0002PN-HE
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8zi-0000m2-Bh
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717664473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hTyBkHfOUJ9uxF1C9hwpYjJJ5ZfdYCgdDu/nl255Im0=;
 b=LExVxHn9d6TtiItB0Lt3r40KSxMJNTc6zggDyN1j4sSm8TUcXO/GwSWF/so5ZWCiGvx2Gr
 hOt02W/b1q9nXGLVgcHiXUq3Tu6cEbkhpfhHE/VTW7mli4z6/kbbplJBTtQEufXEvSMty9
 rD2T81YdvRH5evM+uVLD4nsNz0XcKWE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cv2-ODvTNYi1x2gvrmRWRg-1; Thu, 06 Jun 2024 05:01:02 -0400
X-MC-Unique: cv2-ODvTNYi1x2gvrmRWRg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6c71ca9d55so36874666b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717664461; x=1718269261;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTyBkHfOUJ9uxF1C9hwpYjJJ5ZfdYCgdDu/nl255Im0=;
 b=UmwVyDQsJHqnbQ6DTCVgLfk1hZKDbEJL0ZBLrGIRoRkTAoANyD0rg8tqtdE7GQU/tA
 G10Tz2j2PxzglDrxzeqMJ17rDPXDhxOEvLsVCn4NBt8JJFg7WftIUjdCblUEbvqXR8vm
 GqBgVZrBiybM3mJcjPq6W8nVUP0eLtKb9FgMEUEPJis7YZnjrazBlSYUkAtwlCnSveeu
 ggWNJ2tzGEnqvOm4rVitDGsiazuGyl55ekI9VXorTSCjoqlOtn2NmnMIrBaOJKoqKp8M
 gdx1ydY/hCYr5Cxitr38ZEW9awPkCGonNkP1uF+vACFcm//hQCpB+/cZNhnQ90laA1tm
 LKSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL0MWp6ENafpa8Ie+vnRNWRdxmYnck0ax+hekqBH3K+4ODTWNqPT2YTlcAuKU6M19yhuhv7dhyjZnJc03uVa1yUegc0YM=
X-Gm-Message-State: AOJu0Yw/O7ziDjlIpfFXS+1NgpbJjC5L+N1cCMg/rmhL7LUU/m3PaChR
 Uvm0/USDN+OLNIXpjdjRnCNSdrTE77/qinJDLY1RWCpwfut4rrBbaB/ssvdEMCcJikwmlzbGMEo
 m8bYaRtXFO0R1QFlU+8jDG0U+24GTv3TPPxle8mRFHxzBHdqhfxBs
X-Received: by 2002:a17:906:50b:b0:a6c:6fac:f1ff with SMTP id
 a640c23a62f3a-a6c6fad1464mr198292666b.12.1717664461347; 
 Thu, 06 Jun 2024 02:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMGQE7XUl40zUD7peELEaXzGUsB73fs884FprBoYCJ5e5eKQfRB6K05jDAFqxikuBBYvakyA==
X-Received: by 2002:a17:906:50b:b0:a6c:6fac:f1ff with SMTP id
 a640c23a62f3a-a6c6fad1464mr198291366b.12.1717664460837; 
 Thu, 06 Jun 2024 02:01:00 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.115.112])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6c806ebd21sm66634266b.100.2024.06.06.02.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:01:00 -0700 (PDT)
Message-ID: <bc9560e2-39e6-4391-9fb8-b972f3605c80@redhat.com>
Date: Thu, 6 Jun 2024 11:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] target/i386: add support for VMX FRED controls
To: Xin Li <xin3.li@intel.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, eduardo@habkost.net,
 seanjc@google.com, chao.gao@intel.com, hpa@zytor.com, xiaoyao.li@intel.com,
 weijiang.yang@intel.com
References: <20231109072012.8078-1-xin3.li@intel.com>
 <20231109072012.8078-5-xin3.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231109072012.8078-5-xin3.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/9/23 08:20, Xin Li wrote:
> Add VMX FRED controls used to enable save/load of FRED MSRs.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>   scripts/kvm/vmxcap | 3 +++
>   target/i386/cpu.c  | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
> index 7da1e00ca8..44898d73c2 100755
> --- a/scripts/kvm/vmxcap
> +++ b/scripts/kvm/vmxcap
> @@ -229,6 +229,8 @@ controls = [
>       Allowed1Control(
>           name = 'secondary VM-Exit controls',
>           bits = {
> +            0: 'Save IA32 FRED MSRs',
> +            1: 'Load IA32 FRED MSRs',
>               },
>           cap_msr = MSR_IA32_VMX_EXIT_CTLS2,
>           ),
> @@ -246,6 +248,7 @@ controls = [
>               16: 'Load IA32_BNDCFGS',
>               17: 'Conceal VM entries from PT',
>               18: 'Load IA32_RTIT_CTL',
> +            23: 'Load IA32 FRED MSRs',
>               },
>           cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
>           true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 227ee1c759..dcf914a7ec 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1285,7 +1285,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>               NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
>               "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
> -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
> +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
>               NULL, NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
>           },

The bits in the secondary vmexit controls are not supported, and in 
general the same is true for the secondary vmexit case.  I think it's 
better to not include the vmx-entry-load-fred bit either, and only do 
the vmxcap changes.

Also, in patch 1 there should be a dependency from LM to FRED.

I applied these changes and queued the series, thanks.

Paolo


