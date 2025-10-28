Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857DACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDem2-0004xW-3y; Tue, 28 Oct 2025 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDeln-0004rq-72
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:09:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDelk-0001RS-Ep
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:09:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so35686825e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638966; x=1762243766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3Q842JtEA97RNc6zbk+HgDVLhIp8lx7SKgQXkLwS8g=;
 b=M/OFhzKLmwccO3jcD7luvjfxShzdT2rywVguxsV7oe5rPMsu5JiPRqiiwJNFGh7Htr
 /Y1GPmkwk0SvdWnbIti068mI4SdtycHG3YgP1ZD+emnKicKgoT2zVOOb8oVRLL5z5kc1
 4gBc7Q8hqBbB3jel9fVoTmw5jup6JsKfJzGhWIrwVotT/dF9PDjXMZP5Ecr4SZkad4UL
 s52UCOCr4PPwHb8QX4rtIGgs4x+sXJuTpsUsNyLvIbYjWVdKOnWltxwb3qBHsaQwlfzG
 zAwdAFxqK6fukfMmv3K9wk8xqb2/lDU9rLmNhd9ZEGvIBWsyduNqG3ls4O52fdOUTQOM
 DObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638966; x=1762243766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s3Q842JtEA97RNc6zbk+HgDVLhIp8lx7SKgQXkLwS8g=;
 b=I0cPhAeIVSBdUAC9C37O/5xnjnbTCV3S/H3o1dfzgBfexKoFLjjraOLY5wTf5Wxp1a
 58upz8LKErCq6wGGRcPdUan09oryHDBXUBsDpbQH1OkKpbxf8kv0ohpOTvs+vbQmhGTM
 9rcX3G7Mzi9zOuAEJAy6HJhEgPm3TaEDRwPC2zBoKKdPz1GyIeEU0LSXFE8BEL/wBtct
 ueFziN6kPgpzptmjCgCmwPHaPSM9KxwBLSC3ArvaxyYpFPtwbtcXCrkjvqvF/DWEiQ6k
 72A0OGQZuzi2xo8bnPq3nHV/J5y7ztIUSZ+1T3D/j+I9HUHvAeOzJHThgkayTLzkKurb
 seIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXox0zvdLUpMMUvehe5FgpUOG3BEk794PtATIr3pNQKgi5TSJUKuILshX7tNxm5CWRDiv7NzRvGnMfa@nongnu.org
X-Gm-Message-State: AOJu0Yxb2YmaRNmQ2KaStA52E0GEu9YmhZM5b+VeXrxMEbJr8AsV6lJK
 +Emj9C9h35yY2vlYrmu8z73Ce/yRM2bYiLtmdmtb+9pInlAMEhrDMvmflzzklpeeT6M=
X-Gm-Gg: ASbGncvxeh4X3/vIQnC/7gqFLaaRxQw21XbjiVSip1OENPww1yYTXSr3M3000Z/JMgc
 SAV4FXCHVPIVrfY562CYPUF5WsZSiXjur+J4wn4lafweV/5mFssQCH8kzRbeNMJvdzTooHHaqTA
 Mg1wG0RToTmbbbWstYUPBq1aSP5hA4GTmXKxLKcqfuyIaTACg/o7TKZ6FOBlxCBl5PQeJFWzR/n
 JGyRpaXved7vzOrXkVIhlHUvW6alMhMteXACL9gnQGSuvEixLMXs1p0AC4GRbU+cQBujncSO0CZ
 3Uj1o6W95e4qWEvvjyKD+LC5Pc6WMFDBmLG5lH9ZdvL93Oy870bzaYUVFIOK1wxD/yrX9xxZjcf
 HfrV6QXF3wBLUJEBvuSkylq9qbSmA+i1JwMs/ID9dkoBSk0FeX+MyY67DGh3ekAkO8L6WsVuEpI
 4F3FpV6lWTDdDlHxO7mVqvDhM3OV2o1A2PHynQMC8hvu6OjaI4UmtAhow=
X-Google-Smtp-Source: AGHT+IHID5e8uBGPQLvO5Mm9gwxpOr/rM39suLHjKNm8MlJEv+Itxnbzy1ijVhWeoY04xD5t1A3jZQ==
X-Received: by 2002:a05:600c:190a:b0:471:9da:524c with SMTP id
 5b1f17b1804b1-47717dfd4bbmr19110135e9.12.1761638965836; 
 Tue, 28 Oct 2025 01:09:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4a36easm182193715e9.10.2025.10.28.01.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:09:25 -0700 (PDT)
Message-ID: <17cc53d4-6819-443f-bfff-5de787d87329@linaro.org>
Date: Tue, 28 Oct 2025 09:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/xen: Replace target_ulong by agnostic
 target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251022140114.72372-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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

On 2025-10-22 16:01, Philippe Mathieu-Daudé wrote:
> Both are equivalent:
> 
>    target_long_bits()
> 
>    sizeof(target_u?long) * BITS_PER_BYTE
> 
> Prefer the former which is target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


