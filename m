Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A93C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 03:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u35ST-0004cw-Ua; Thu, 10 Apr 2025 23:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u35SP-0004ca-Vp
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 23:53:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1u35SO-0002V4-1c
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 23:53:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736a72220edso1577459b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 20:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744343610; x=1744948410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=B0ewmJxnVVIA/Mq2fOuSHVqqsvkOyAED3vGoPhuOgww=;
 b=RYEnPuA5tqS9geiLK0yhYGcBT07SAw+ZCvVW2FC/wiXXMopIb9d8UFVQI39dRkGdb+
 VgjigNkjmwed2Nu6fXbhs1SuL8agyMXGohUzYza/MMQjann+piKUs7CNhVxVZkR+TBBb
 4SqarZS2p/iJfqep33b8ZQfySoSM2LUVVeM6U3BGC8WdUK1Wqd8o1PWtA5I63mVqpeY+
 8dLMDjwHSszmHVtMBnXgXLPkf2taGxKyX9/BDZTeN2eX+NpW7QCPflerrBe03OTaF8rw
 ouPIEEv68IqR1zRyqEZTR1hp7d/D4czmAhqY+z24l9SwDk3+XTM4MbsWASr/wA9CTLRs
 uZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744343610; x=1744948410;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0ewmJxnVVIA/Mq2fOuSHVqqsvkOyAED3vGoPhuOgww=;
 b=nvtP78anFaE5Pcossu8/S7MoULDjSm0jgnGspq12jpIj0xQzWuZbBYgtFtuHuEsZFb
 jFZdfvDLaaFgts2bJA0l24OZOMyTLZBdxBElKz8XR18teMDB2KJmJvBm9ev4zWts0nCt
 j1hwTv8dJL9ZE/SPaWE5a3X8yb0e6fyeoNiAiZjpk34MjH811vckKXIDMIAoHvVAjSUn
 rB1VNJjRqtebZQ+yF1h2SHkArqYL4cmlo/orNbkI3gMM6vQ/+Q4a0wBw0KwFqpfMsnyQ
 UiqHjiMjvGYPDLKF/f4RIHqVN35KQdnqZ9fs309t1mZLmoLuxe4v48si3C3SIkT9QAqp
 0oyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvADcG3WHD1dwNwExWUSqSUQkvVzrjV6escHsJ5e2NsN8+Gxn7jVp/b3XpmpZsONJ01lq3amHAs4MI@nongnu.org
X-Gm-Message-State: AOJu0YwtxtU/GMNbHlo4WQMdyQ7egkG54ccfzcNid1bZJFAeAM/igvI7
 y08pqjj8f0XZ7s93Qb+JtWGAeeiVWLO9V1oob6MO2QtfTU/VImludlUaGw==
X-Gm-Gg: ASbGnctxPqYVHoi+AUG04SY+cjtev4OOt9s4jExepbD8u5PUsKPNTy8lK83Go8Tv9LL
 aq6CKatEEberNL/+sp73yn7M1/XfIazYQWkOs8st30BoZuy5U+X0oA+nuelcuGf7aLJQ19Nwrz7
 5cjA1mIRl1JgPblIAPChD4FeoRS41DocFQ/vMoH0O/b2vu9mAB5DoFlO4DxRWTdh4QVmJd6SRAz
 Jvg8Whfx1x3o+mtEQz8FskJLhaXGxYN+pISq+qRkbVEkCU/hTbCrCy1lJuKvfFSi1EP/IhiPlVH
 B9kbaZJqSCkU3LfyRs4p/vjf64PNA597GzXAJ1MG+fl/3ikhu6fzpMNEG80CIgxQNnna9gGzvB0
 4hJPfKZiv87hNFg==
X-Google-Smtp-Source: AGHT+IGIUOmZo5PfZunfQ0IoRi8UM+fxkvaL/avn7k4yvX14BrjlHLKV7UIm6U96VOw8xstyPU0YLA==
X-Received: by 2002:a05:6a21:9981:b0:1fa:995a:5004 with SMTP id
 adf61e73a8af0-20179921cd4mr1624041637.26.1744343609662; 
 Thu, 10 Apr 2025 20:53:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f830esm421946b3a.95.2025.04.10.20.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 20:53:29 -0700 (PDT)
Message-ID: <d7f43c28-e328-4b19-b045-3b6fde881c89@roeck-us.net>
Date: Thu, 10 Apr 2025 20:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add property to support writing ERSTBA in high-low
 order
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <ae8cd367-8580-4476-9a75-3fa4f7aa2536@linaro.org>
 <7ed5d213-9429-45c8-bbf3-6f3f841a2299@roeck-us.net>
 <7C5A41A1-38EE-4D22-8F84-6A5A3A2BDD82@gmail.com>
 <42a82455-7fa1-4890-a9e8-690fec3433c3@roeck-us.net>
 <9239BBD2-DCB8-4B97-9EAA-FFB06CAB660C@gmail.com>
 <89b70bdd-00e3-46ee-8810-099da032f485@roeck-us.net>
 <C5389B31-E7B2-43E0-A10D-368571DAD081@gmail.com>
 <cd6dafe1-f291-46f4-8fb1-7555dc6a60db@roeck-us.net>
 <6A2167BC-910A-4801-8FB0-24C114EF5181@gmail.com>
 <3b0367ca-7242-4555-a6b2-ddf546374138@roeck-us.net>
 <A3422A32-92AB-4D53-A53F-DD9D0FD5C1EE@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <A3422A32-92AB-4D53-A53F-DD9D0FD5C1EE@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/8/25 14:56, Bernhard Beschow wrote:

>>>> Tt turns out that sabrelite has the same problem.
>>>
>>> Did it work with QEMU 9.2?
>>>
>>
>> No, the pcie interfaces on sabrelite don't instantiate for me with qemu 9.2 (9.2.3,
>> more specifically). I see the pcie root port, but nothing behind it.
> 
> You need to add `bus=dw-pcie` to the pci devices' options in QEMU 9.2.x and earler, otherwise it will end up on the wrong bus. This is fixed in master.
> 

Just to give you a quick update, I needed the diff below to get virtio-net-pci
to work on sabrelite.

No luck with any other non-virtio PCI controllers, though.

Guenter

---
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 9da32fc189..7325f3f2c4 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -456,10 +456,10 @@ struct FslIMX6State {
  #define FSL_IMX6_MLB150_LOW_IRQ 117
  #define FSL_IMX6_ENET_MAC_IRQ 118
  #define FSL_IMX6_ENET_MAC_1588_IRQ 119
-#define FSL_IMX6_PCIE1_IRQ 120
-#define FSL_IMX6_PCIE2_IRQ 121
-#define FSL_IMX6_PCIE3_IRQ 122
-#define FSL_IMX6_PCIE4_MSI_IRQ 123
+#define FSL_IMX6_PCIE1_IRQ 123
+#define FSL_IMX6_PCIE2_IRQ 122
+#define FSL_IMX6_PCIE3_IRQ 121
+#define FSL_IMX6_PCIE4_MSI_IRQ 120
  #define FSL_IMX6_DCIC1_IRQ 124
  #define FSL_IMX6_DCIC2_IRQ 125
  #define FSL_IMX6_MLB150_HIGH_IRQ 126


