Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A8DC36011
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 15:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txST6-0004ol-5H; Wed, 26 Mar 2025 11:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txST4-0004oX-HX
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:14:58 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1txST2-0003hM-SC
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 11:14:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso22767435ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743002094; x=1743606894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIj16oXVDDtqDyVJ9nWRvKkOHJASjCpABULlghJil98=;
 b=DcK5MsL/cx0QyN/qH6iK8WflWXYf1jffm1ktPYhSEfXXdZRc1GtKpsMinmM6h5S2/e
 WS9RjaiMxpKn1EITsncDVjsu3vA6BpydjIO8G2PDhVLy3OaAO4btj4IkdSobcZaDySyg
 2fMGRbCpK+2qHhiop8d6DpWvyb2nfEiLnSg4HAkqD2/DcqSffFjClJHiD/3qJALo634E
 zMKT0j5f4o5auPyhB7h7seJmOvjgDiYdFowQ8I3izH3aC16vr1/+4JHXlL+DPwUR8cff
 lFjJo4hDwtNBnC1S9ggW1wHC0MJN0yWPSrd8eh3LeKClZQtnizGOWTyPMqUU6xTtriWA
 NbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743002094; x=1743606894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIj16oXVDDtqDyVJ9nWRvKkOHJASjCpABULlghJil98=;
 b=WRPv12rHFEoxqDlvDCevh3lI4QGgaXyccXhkhRPC/N5bR3w1+wbk2V1w1EjDOmN8zC
 x7U5PgKFZXZOFb8jWNYl/rEMGe1eIhXNccidPtYVcbB326xIzbeMXXdBIuPRofK/9iIA
 VFVrEktfhe6f9ryeAaw+UT1SnTzi/MZBFH9Y2ZmrjZuYVQKnoOzbeFSK3EE3Z2/MhMy0
 x/uEG5b2tMfpzSzduqixegvqIqDjBv0naSw0ebsQo+SzAxHuarbWvhSTna2MUrx/3cFR
 n/QfrQ+PBMzqHdPDPibknzvfE6TtkHkyKXMwEOo7PEWAxIzP5WmNRIeJn2mCGUUfgxjr
 KMqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGnwHkDe0hGr1UxhQrv+32ENL03DLplyde+4/ei2mwv03KVfzqOTMRr3iGo0MkNTILbfmVyJRygKzn@nongnu.org
X-Gm-Message-State: AOJu0YwF8L12jiUPaygblSskQwgE7EVREIhFiiIKOH2EUAJNB5/bX9W0
 b92XPIum3kksxd60OH60H12TAkzt6uOUb1RXZ4oHV4YLHTUPNG00fHetKxieA2s=
X-Gm-Gg: ASbGnct1TpPrepWCJd7/7ysDSrbdOFBpIm/ZoLpxlnCfQvjJd1qT1VDsrMX9pnE5fVQ
 RyriWPr292tyPTtkSo+nNwwG/mXwxH8ruHkgS/EXYeNWpk9B6g6Y4PdRJt7/2yXXcbEQADWZCZz
 7ePCJcHF9FMHmiyjyPWpoYsDRla0PZrZIpp/Hlmr+dpBBwrhTLr0jDOzCy4+9yg70KaOAxYkdyr
 vG7cuWd52sjWAIg2vaKEwfPzvPJ2d0fMG9oLPi84QYNyFJPOybqY7i0UxRpt0l6K7mnXahYKccv
 5mcjvA+4EufIR3N56ikuSFApLmSdC2G3yt1guDmbght3k3fTb9HuFG0z1w==
X-Google-Smtp-Source: AGHT+IE6pCg4+nxNAMgbhcPqJ0T1XRVxIPNCmHWriqvR+NlZ/gFmvYR24umNuLv8VMZp0NzZs3I97w==
X-Received: by 2002:a17:903:3c43:b0:215:58be:3349 with SMTP id
 d9443c01a7336-228039b7515mr2756215ad.14.1743002094146; 
 Wed, 26 Mar 2025 08:14:54 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da374sm111632465ad.173.2025.03.26.08.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 08:14:53 -0700 (PDT)
Message-ID: <24816be8-51a5-4efd-b18c-aad27db09222@linaro.org>
Date: Wed, 26 Mar 2025 08:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] target/avr: Remove NUMBER_OF_IO_REGISTERS
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-6-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325224403.4011975-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/25/25 15:43, Richard Henderson wrote:
> This define isn't used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 84a8f5cc8c..b49e7a7056 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -44,8 +44,6 @@
>   
>   /* Number of CPU registers */
>   #define NUMBER_OF_CPU_REGISTERS 32
> -/* Number of IO registers accessible by ld/st/in/out */
> -#define NUMBER_OF_IO_REGISTERS 64
>   
>   /*
>    * Offsets of AVR memory regions in host memory space.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


