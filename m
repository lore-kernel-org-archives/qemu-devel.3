Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983BCD3C533
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 22:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Z0Y-0000YU-Dw; Thu, 17 Oct 2024 18:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Z0X-0000Xt-0h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 18:30:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t1Z0U-0001mb-CK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 18:30:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e52582d0bso1143570b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729204205; x=1729809005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBPFVvnr+1JURmu1PrglpzYtpug3pt5Zh3R2pEzZkuY=;
 b=wIeHTYMEi0nGCOlhT1IJrS8t5v9rkh9OnydXgW24A2EdyRX/BLnwvAfKT0vakwLkcl
 VlTkYD2Bv8GGguo6+3iHepEmvlT7mrzkH4oRQFQ4yQq1sUwdmReZKqtjwU364puFn54G
 rTdwda6wrCqfWv3up5NcOIieupfEO3ql7uKyug0RRfoPQlhuKVHu07E+PJjclCnTLFEN
 BynNIpsxpxJb5dCOuGAxrseTvN2/bOskJBF6yosEd9wRoR+VWLWcl6M/EL7fE6/31PYP
 vg13ifwnU6IaFiiPqizy/HsmHasurPbuzE6CTcREPcTYHQbCIchbEsFtBVPEoP3ll0Zd
 Kmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729204205; x=1729809005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBPFVvnr+1JURmu1PrglpzYtpug3pt5Zh3R2pEzZkuY=;
 b=vlv+Bpo/bAkOTEXpTQ3yKAjbyeocEH8rRkWkCuUpCSAxnLJzhZJo6CCwUkE1c2B+Bm
 0h2Qiq4OznZhKTS8UjqS2JMvI5KPL90z0m5YzFm6YJ/ICxJZVGX2n/SF/nRIQmpRrTyT
 Q11IMRePRciwA+qRLpS2/pbN/s2VymMCcUNYSUTKIy9g+gzvqpBUAGjxZy4p3c3HPXy9
 1MLXoc0XFimjr/Btb85eKIvDxtqJwIMz3B5qaH3XWZVgU5YehsIMecnIyce4HgKFkN1U
 WBgsjH1Z1jQm8zCmoqdCA+9UupV7ucekpyYBxdjA67psJi+jhjnEPKhQ407khca+N2wg
 +Clg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ5ZZ+cnZHXbu6GRAI2t1WbFt4vyYwCfTUVm1Gdi+qRWxdrqwd5ehMegkSom4NDv0Qm1jLLJ4Z1OZn@nongnu.org
X-Gm-Message-State: AOJu0Yz764w811enNp1j2Wq0m0xtiqulQ/1tu+J6xZ/9Mubth/r3h13T
 WZw0idyseJOmGEetJqOlyBbTXOArSX5LnC2Wbg/CPcyL7EA5PAGxOKpLvNwgNe8=
X-Google-Smtp-Source: AGHT+IE7oxa1pNKXbknYm0iDvvAEewF1XwILscsKND6czFcSOdxM5HUMPngN37TZW+9yCYOD7YSXHA==
X-Received: by 2002:a05:6a00:b4b:b0:71e:cb5:2219 with SMTP id
 d2e1a72fcca58-71ea31dcc63mr679657b3a.9.1729204204795; 
 Thu, 17 Oct 2024 15:30:04 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ea345b3e2sm165681b3a.176.2024.10.17.15.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 15:30:04 -0700 (PDT)
Message-ID: <c7077fab-aa63-46a0-bfc8-57187d812623@linaro.org>
Date: Thu, 17 Oct 2024 19:30:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20241017091401.783102-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241017091401.783102-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 17/10/24 06:14, Paolo Bonzini wrote:
> 32-bit TSTEQ and TSTNE is subject to the same constraints as
> for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
> using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").
> 
> Adjust the constraint and make tcg_target_const_match use the
> same sequence as tgen_cmp2: first check if the constant is a
> valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
> non-test comparisons, finally check if the constant is a valid
> operand for 64-bit non-test comparisons.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/s390x/tcg-target.c.inc | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


