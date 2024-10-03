Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05FCCF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 20:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swSmv-0005EL-A7; Thu, 03 Oct 2024 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSms-0005DN-6J
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:51:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swSmq-0006y5-Mz
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 16:51:01 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so1439329f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727988658; x=1728593458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I8KwwV6cPoYlAXm1UCsfz3UXPAIlrMmYqtEhYKNa01M=;
 b=hW0p+FaXzM5QY2K1xJk02iwm0yMnYPUc8SAVZlHNulzwLLw7uKFDJnSALMzCm5KKJX
 nPFqmss0SXOK7y2ixEfS27ULQMcSKiZbnVpvOVLAOtJcMCkFYLSq6sU6SQTQ600DbxXw
 yUxki2jYAohXZPXfYUCc3xyIyQl+ffCxi4i2noYEhwMAohsgsoH2J20nWYEd46/Eljms
 jyVfkKVIoru1eBGg1CmDAJQLYigsLvwMGibePYTGDfGbvwVduzADX5dGu7d1XwaGcIxK
 3ir+bZs6se0I7T8I68wRTk1WX3mWuOBEN6XnVfqgL5RS+H1HeR5VFtUDYCy2vEmlC5a1
 FztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727988658; x=1728593458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I8KwwV6cPoYlAXm1UCsfz3UXPAIlrMmYqtEhYKNa01M=;
 b=GuiYMVYMgodmd8S5t+Ajtf818jOiNvNT0eK9UEqStao63F0wJtLFl2/yTiPOyMHtJl
 XTQBz9B/KEamUOCs18Be/sGVmoIUavTeWmpHcbMQroqGZUSlL2iVZXPEAFGthuxcN1b9
 1CvYTzxNr/Zkc5tVQ7tYiC4NPhG7I41Abqh70E38+2Yq5QP3MJM4kzbLiIHnppYQpgDv
 TlIqLgbdlDWkWi5UW+zr+4H51hPWizAaZfq7FkimQe+3Fshfk2yuEmrSv0h19EWt8WQ/
 JT52fDzGyFweM6NjJPEQ/aY/o0pfIRPfqZaY3rgayRbsxBoC/9iQxlRAjiO2XydHUoM3
 n7BQ==
X-Gm-Message-State: AOJu0YzTV0pVQanKqlviioARoQCfTe+z4Gyk9Om404zsYrEcvrwUGX4S
 g7Z8D5JAFRFaUOwUUT8P85yw+MSK1Qbj7q8soXZO1BsKdwhmZ6+pGRaKicF7syJPFkxVF3EYnL/
 96oM=
X-Google-Smtp-Source: AGHT+IH1mo7DalbKvkLgigXtYyVJZR9IxRNksPSeOcbziKjzHtfV0KQN28K7ltFU0fIsRKgZRNYolA==
X-Received: by 2002:a5d:538d:0:b0:378:c6d5:e2b3 with SMTP id
 ffacd0b85a97d-37d04a57a45mr2626299f8f.23.1727988658462; 
 Thu, 03 Oct 2024 13:50:58 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f8025b3d6sm23484715e9.18.2024.10.03.13.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 13:50:57 -0700 (PDT)
Message-ID: <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
Date: Thu, 3 Oct 2024 22:50:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240930073450.33195-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 30/9/24 09:34, Philippe Mathieu-Daudé wrote:
> Introduce the ld/st_endian_p() API, which takes an extra

Alternatively we could use ld/st_te_p() since we already
have ld/st_he_p() for host endianness.

> boolean argument to dispatch to ld/st_{be,le}_p() methods.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: Update docstring regexp
> ---
>   include/qemu/bswap.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index ad22910a5d..ec813a756d 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -433,4 +433,23 @@ DO_STN_LDN_P(be)
>   #undef le_bswaps
>   #undef be_bswaps
>   
> +#define lduw_endian_p(big_endian, p) \
> +                     (big_endian) ? lduw_be_p(p) : lduw_le_p(p)
> +#define ldsw_endian_p(big_endian, p) \
> +                     (big_endian) ? ldsw_be_p(p) : ldsw_be_p(p)
> +#define ldl_endian_p(big_endian, p) \
> +                    (big_endian) ? ldl_be_p(p) : ldl_le_p(p)
> +#define ldq_endian_p(big_endian, p) \
> +                    (big_endian) ? ldq_be_p(p) : ldq_le_p(p)
> +#define stw_endian_p(big_endian, p, v) \
> +                    (big_endian) ? stw_be_p(p, v) : stw_le_p(p, v)
> +#define stl_endian_p(big_endian, p, v) \
> +                    (big_endian) ? stl_be_p(p, v) : stl_le_p(p, v)
> +#define stq_endian_p(big_endian, p, v) \
> +                    (big_endian) ? stq_be_p(p, v) : stq_le_p(p, v)
> +#define ldn_endian_p(big_endian, p, sz) \
> +                     (big_endian) ? ldn_be_p(p, sz) : ldn_le_p(p, sz)
> +#define stn_endian_p(big_endian, p, sz, v) \
> +                    (big_endian) ? stn_be_p(p, sz, v) : stn_le_p(p, sz, v)
> +
>   #endif /* BSWAP_H */


