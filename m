Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669B8CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 04:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOTob-0007TW-QW; Wed, 26 Nov 2025 23:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOToa-0007TO-Q8
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 23:41:08 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOToY-0006kk-8R
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 23:41:08 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so2125405e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 20:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764218464; x=1764823264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXyGtCDpVCZYoCaBmKoULk8BJHRfceyU7gKc+1QbAuo=;
 b=rWis1B6XczKB686eOrcg/50Ffd/2rgpYCACNX/Q86hDMzaK4tC1T/QivjdSoFE4TGI
 S3O0MSIS9uHwOyiHD8794wPoovKa90CdXiDEWDd4Bl8Yykdo08YzN17y3xPH+nKrnpFd
 oxkxYwX1oM5fJj762E1d0W1QAFrUPKpKAq+6Cb3pG25Kq9XpRHFthjMR+eEi1jMBL6Bq
 73IszHpn/Wf15UWg0ihjlDODKrGUip4fyss04WxnuOaJqwA52ne1G6tOqvhynFqBmVjQ
 76wb7RBiAFowIlC/iF/lb0aMXSuMocWe3nZ6kibk4KUovKg+BEAyfhv/t81wT/9AlA8J
 wmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764218464; x=1764823264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXyGtCDpVCZYoCaBmKoULk8BJHRfceyU7gKc+1QbAuo=;
 b=r0zvKe0YeA5f7zbAlVhr8oIK5L3+PTbHkN8xzHJjk3k/Ik4rZZR1c8TPi44TTbttZR
 vUxdnyGgFGsaIGQfw7FL2sxjJM3QyeaMCLTIYt/WCjAEWh4XcyGZNe4OShZF/f05jTcM
 xI0K3TTpSULsN0hNg+Gs7DJD+oS7AhYqHHQGfuIFjHAOkUH6aS0oUC7tMdlvPmWrLKOT
 sY7rO3i4/gBt8StyJ077Jq3qRvmWQFoBDItX5r/oTEua2C2G0jY2eqLdI+Hcgftk4p1Y
 T5GdDyKrRB8JIYpCK070oLPRdExdWufoz4Xp0dw4/pp1wfRjs5dZUcS7LypTBtsnk4ug
 gBMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIdPy0AazJm2SX12eApLDMqiQxtIqs9LuqPHO5DIpZTcURYcopP2BxDgZ7yKayikAueWvGXYIbuiYF@nongnu.org
X-Gm-Message-State: AOJu0YxaSjKzzd4Y7qWW698d0ogbHsGMwiQ1yoT5c2gpqil/zqAOi2cL
 eZG5L0vdDx+liIMXtEoJGxhnbhe4Rqvh09Bc5bmymBJ24vWQl3DPF46YyQjWJXuMDJI=
X-Gm-Gg: ASbGncv1dPOdaCiMVIr5V8i5v3EqWEfivI+m1qdsrCISUTVZ4DHHJE5HOQbmq60914q
 oKposRmL8jgFgGWfpq+kkwBPc5tiwG9L9Z7Oeqww0RbUrNMuZngL9h9dBOUwbsLiBoQpuMAXD7r
 71+MWeVRWxSjHRALXXMF6h4VA6qaoVpzi2GcbwaCYTWRtuo0NDsDJSmpd2Pg1kc1UmPvLjJhSWN
 II+gNMXdRo7p0amKXFV7zPrkVoq4AcAsYfpSHt9gw7OvCpgwENMDrPRXzaUPENlkCga2eOHsQyz
 4b+DJM63hDvDbehdAZeWdzdJ5Kt7SgCMyjw74bJvysbiiVU7UgrZsXCbp6TO0KYZjjurJ3AGkUu
 2Ij+i9OazzCXwHi1Zfdez3FfHXYiazGN3kSc1ADeDlh4jHoftP9Yvmj07aoCNOfzFqZTv+89QT9
 xQnfmEY8GL+6PJni+hg9GMu3lrji7T2ydeyJK2S+uLdb/Mn5KCjURE7wfs8J/72SUQ
X-Google-Smtp-Source: AGHT+IFJMdxvOhNYBnh67mzwm34Fw/CSmnYDdjb0w0ecfcwu1etZj3NgX6cnSr0fpr4jN5BOTlILUQ==
X-Received: by 2002:a05:600c:1914:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-477c112587fmr177249835e9.25.1764218464430; 
 Wed, 26 Nov 2025 20:41:04 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3022sm1237853f8f.4.2025.11.26.20.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 20:41:03 -0800 (PST)
Message-ID: <ccfffc00-0d71-4dce-94ee-4cb0f68bda45@linaro.org>
Date: Thu, 27 Nov 2025 05:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 031/147] accel/tcg: Implement translator_ld*_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi,

On 22/4/25 21:26, Richard Henderson wrote:
> Add a new family of translator load functions which take
> an absolute endianness value in the form of MO_BE/MO_LE.
> Expand the other translator_ld* functions on top of this.
> Remove exec/tswap.h from translator.c.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 49 ++++++++++++++++++++++++---------------
>   accel/tcg/translator.c    | 26 +++++++++++++++------
>   2 files changed, 49 insertions(+), 26 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 205dd85bba..3c32655569 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -18,7 +18,7 @@
>    * member in your target-specific DisasContext.
>    */
>   
> -#include "qemu/bswap.h"
> +#include "exec/memop.h"
>   #include "exec/vaddr.h"
>   
>   /**
> @@ -181,42 +181,53 @@ bool translator_io_start(DisasContextBase *db);
>    */
>   
>   uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc);
> -uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc);
> +uint16_t translator_lduw_end(CPUArchState *env, DisasContextBase *db,
> +                             vaddr pc, MemOp endian);
> +uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian);
> +uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
> +                            vaddr pc, MemOp endian);

I just realized we missed to document these new methods in
docs/devel/loads-stores.rst.

