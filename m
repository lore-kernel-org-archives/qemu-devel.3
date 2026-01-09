Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD8FD26D9F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKI5-0000se-3X; Fri, 09 Jan 2026 16:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKHs-0000pB-Mi
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:44:53 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKHr-0006PM-1v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:44:52 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso4672276b3a.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995089; x=1768599889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lBgQoaA8YjVYbZDBGE2PwLchBM0dWMWS7lkPx6KXEd4=;
 b=jxeijyGm4TBqEsrknWl8O40f6CxMqyYqhvJ8Ga9tpApc1UZ2bKkwUy6aFLFtBXSmeE
 1G8lIMqUGnV/xPX+8I+PsDdpPReIT0PsU5IbCX9SVSrsk1JIaFDbTEyU9XK96y67oEAH
 A0+sFC4XZzRH3i6LUaO7YA6IhmK7ke9EXFNGkaIcueyWDaM8874CaRvRRybyGHy9G7uq
 gkTG+UEOOPGReRySPloCFH4u9bfiQPEgbvjZU1EjXHwPSNH+oUgyZikyx+DT9TSr12KX
 DBDWXRhV5h5SfqD6dfQNJpOuVNsc+jtv07qKi4hkdMAzt1rNuL5yhkiLMx99QcAolsCP
 +hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995089; x=1768599889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBgQoaA8YjVYbZDBGE2PwLchBM0dWMWS7lkPx6KXEd4=;
 b=SyQoBJHh58RmGipLswoMeueSjd11n+u4mMDvZp+0GL4fIGy7snBkiwXFUnnC08IfmA
 4+zAsXzhqAZEsKvszcxmwmUHrTRYenDbclJ/lqdNIzJKkJMKH74Gxhb1Ek6//aSesRiQ
 INzuE7MdohuUh8KSC6U1xswhpxzyyk5Vm+DIvaPtMMPKAvBjon6JKMJbeQPUEeAWewaY
 kDkg571rv4HZKWVt5OB3+y7flK1hdHZUkrD7wUOlOE1pJduynv4M2QwWk7m0HWZES5te
 DibC1BSdSNsMtzc7j9pJKzQzjpaXvV7lXoa17vxdZpPhyeqAdjRalXNNto90IKHIUftI
 lQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz4NqAPpVFlFisCjXpJIkHlk7Tf7D7KkaZ9iPSizrLYpCVlXo7BhIz3NIEPRPNvYMtmZ4G73D/diTD@nongnu.org
X-Gm-Message-State: AOJu0YwgfXYC9MaRC6jodJcKmLJZMXKN/MZvGNnEVy47b1Szbh+Sy1UP
 id2n+fKxv8N1Y7na89gYQeFj/aKEmTMAs5vj8plaHw2W9TFen2QKsXYk2ws0DRHrASA=
X-Gm-Gg: AY/fxX59037V8fBxnxgPdCEjTbl4n9i+7DkF2slYTrpb0aibqH7/xGep9llz29590AB
 gNlmrKNIRqqv7Xx4gdQQcHRHP1L7knRkqOajG9Sb2GDQkIiH7dMFGwaV8XV9HRDK1J6HulQzAFx
 nXUcPBqE1bP7q6XLUVxih/jVUcHYU5WTlFPhNWtgqPqGjX+kmWLzWL68iHz3bHg3E6UCu0hxU/P
 6dbzMl/Bc6nFKek0X7hJvNnODIngftRSVOPZbtqOYqC/dYRhEDRulYnrOaZ2B+KTC2GqMFiVcdV
 y6tzKCcas1UigPUb7NGaKM0DuahWEllU9Ef3uazsM10BfrR6xxFsS4q74IWcKZZ2C4OJZRjB3sQ
 6h/26iHFmPLcRCeRuJxavjaZxo85Qs9bbWY52Inm4Pax20zJAGhdCZHbBmVxMZ1X7i+CYC9vVAw
 nerB85Do6Ul/3wlogo1gpGXDizTw==
X-Google-Smtp-Source: AGHT+IFaczoDPMX3fo4WNU2CxH4CjhjaUm6L7Sy2vr01cvtw51qM9xNTXKu4hT9YygTo3tPDaEGoow==
X-Received: by 2002:a05:6a00:f94:b0:81e:f623:ba0c with SMTP id
 d2e1a72fcca58-81ef623bc8dmr1617066b3a.44.1767995088808; 
 Fri, 09 Jan 2026 13:44:48 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e3eb854e3sm2721092b3a.5.2026.01.09.13.44.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:44:48 -0800 (PST)
Message-ID: <6ceec36f-2059-429a-b59b-1da03b59a49a@linaro.org>
Date: Sat, 10 Jan 2026 08:44:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/29] target/arm/tcg/vec_helper.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-10-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> We need to extract 64 bits helper in a new file (vec_helper64.c), and
> extract some macro definition also, since they will be used in both
> files.
> As well, DO_3OP_PAIR was defined twice, so rename the second variant
> to DO_3OP_PAIR_NO_STATUS to reflect what it does.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h |  49 ++++++++
>   target/arm/tcg/vec_helper.c   | 225 +++-------------------------------
>   target/arm/tcg/vec_helper64.c | 140 +++++++++++++++++++++
>   target/arm/tcg/meson.build    |   4 +-
>   4 files changed, 210 insertions(+), 208 deletions(-)
>   create mode 100644 target/arm/tcg/vec_helper64.c

The whole 32-bit helper vs 64-bit helper thing is a bit of a mess.

I think we need to ask if it's worthwhile to separate them, or just always include them 
all.  I know some of the vec_helper.c ifdeffery is because of the helper-a64.c separation.

On the other hand, since you've now done the work,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


