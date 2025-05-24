Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888C4C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIoPa-0001aG-AX; Sat, 24 May 2025 08:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoPZ-0001Zm-0K
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:55:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoPX-000484-1s
 for qemu-devel@nongnu.org; Sat, 24 May 2025 08:55:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so3857635e9.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748091333; x=1748696133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9N33DF1xZp9jCtZ6B0TcdwvHYyV+fSwoVuf806uc7qc=;
 b=MIUdp1C05YTubE3vMgwSkQgTltxqpV9aLkiWGpgV+h/JeZD0RHlfKSjzvlkLXt9+mG
 gD9z2ASdLtFxEc9+scM4BDr03OOulnbrKIFv9yDAJsdXwvg+W9plh9F3MLJ9OhgLwBms
 4xJ7dGt1cSUYWwL99OEdIysCPL4/jnYjNF3FrbxuYsnINxsog+3FsmTIa0Xir3m5NDeW
 9YVSxJ6ZMkSEWyiTtMOWD7VhavS3WZTRvZU92NtQpJYhdu/gSlMlQGLUYNWlE0m2hqXD
 Y2+XVrJOthf7mHgwXaQfwMEvOFiZ4dK4GhIqUIEiHXNVXxXCKNoEywahKhK+mESWOp81
 S4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748091333; x=1748696133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9N33DF1xZp9jCtZ6B0TcdwvHYyV+fSwoVuf806uc7qc=;
 b=qPsEmzDxpNlPMmW7oqSIu04JZU1VT0cVRkCZEKoLowgNflp7S3K/CzCpU4Sg9rCh0W
 aqRoE3Or2FJJ9zB4Hn2onLlL4j6OMYQipQ1rL0ReQ45QCVa0TTSZ/g197FgXlq86cpEV
 CG+R5DxFmTkmbFw4i5xxIDQgzFGC6RMAJjj/A4/SqhTakbCt3SHAYKHRmPc7WggXqe7y
 mJLjxD68/fs5/RUqCTvS29bi15poMDyQAFVocC6GgpKcQ3OE5FE0baFS4+B7IdHignPx
 9SFRWx0YyqoFaxEN4X+ll7Iy0NsURg5RKlUpstp9twKR9ndaxTLG6+BrtpXSKFNgLInz
 lpGg==
X-Gm-Message-State: AOJu0YwhDkjtJ474Se0LFhnuD7szKdf/s0RcxxvIpDYQQjkX2pt/hYLP
 G2kgvJjVZJ6sq6MKJMbc/V9okD73MP62vy+q3YTK0ixb8FntAhWj/KWS9ceotv1HP8AXOupIOok
 ELEo/iJ5pYA==
X-Gm-Gg: ASbGncv+L1DGMx9BKwbqF05+oNfIi2iAaR00g/EqX+0fwWnp2UBquJijFgU9TIH7499
 eP5x6O3Jo2Zm6Hp/8UngSEIouqR6Ud6qkEvHeqr22f3hYQzmE8FCQBt3yyWPLn27D2mTkEzNZvU
 9FaJW/ATNZS/0LtQoESL9KM3LZHaukc0ZTn8LTVbhAujZb86HuKHUzyYHSS3c2Ica/Lt+eiKgrZ
 sotgNOAylT3G1YqJ3ITdjfcUSQqz6cBCBzloDveLTSSgDS1nruG/I+lQqNKTZ1aJk9F3kIOr17P
 J+xBpm6PYoaLMe+NF63naueYpAUfJ/84fJf/N6au9tYXYbMCFEiFpgcj/TD0jBEl6Q==
X-Google-Smtp-Source: AGHT+IEZPGHaLgtHvEEMs6Tn+W1c5O53P/lAWVfEgNSxpYzTmKADIVbMGUgeqsZct1PDAp4uyS+XuA==
X-Received: by 2002:a05:600c:3c93:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-44c933f0edfmr18793775e9.32.1748091332703; 
 Sat, 24 May 2025 05:55:32 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1fe4fa6sm172959035e9.16.2025.05.24.05.55.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 05:55:32 -0700 (PDT)
Message-ID: <00ec097f-b43a-4831-b4b6-c5d20aac236f@linaro.org>
Date: Sat, 24 May 2025 13:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/microblaze: Add endianness property to the
 petalogix_s3adsp1800 machine
To: qemu-devel@nongnu.org
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-2-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250515132019.569365-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 5/15/25 14:20, Thomas Huth wrote:
> +static int machine_get_endianness(Object *obj, Error **errp G_GNUC_UNUSED)
> +{
> +    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
> +    return ms->endianness;
> +}
> +
> +static void machine_set_endianness(Object *obj, int endianness, Error **errp)
> +{
> +    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
> +    ms->endianness = endianness;
> +}
> +
>   static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
>                                                       const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> +    ObjectProperty *prop;
>   
>       mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
>       mc->init = petalogix_s3adsp1800_init;
>       mc->is_default = true;
> +
> +    prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
> +                                          &EndianMode_lookup,
> +                                          machine_get_endianness,
> +                                          machine_set_endianness);
> +    object_property_set_default_str(prop, TARGET_BIG_ENDIAN ? "big" : "little");
> +    object_class_property_set_description(oc, "endianness",
> +            "Defines whether the machine runs in big or little endian mode");


Better with Property?  You don't have to write get/set...

   static const Property props[] = {
     DEFINE_PROP_ENDIAN("endianness", S3Adsp1800MachineState, endianness,
                        TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE),
   };

   device_class_set_props(dc, props);


r~

