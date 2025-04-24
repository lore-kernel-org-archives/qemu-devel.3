Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E706CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 21:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83wQ-00034z-5f; Thu, 24 Apr 2025 17:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83wN-00034i-TX
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:17:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u83wL-00023R-Sm
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 17:17:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso1542779b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745529420; x=1746134220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ocxHxQoXm86xOw/of9C6RCOKFBv2y9J9E+r6Bu7RMc=;
 b=bfb3wIB837Kx3DAIa5bj4IeDz4yxd8WtwCc9sLRWqfm3qSlrVNWq69gZSSNrOincYN
 9Mo+WHD+Niq3953zAejfQe/FcoQLVLrPR2H5LjzVW2bYkrmBTVZaRwc4PKtgnBeYIhP1
 48t2YWCfm05zDVZ+MJwAg3t7Y9lQ2VnkgQkN/0H6rGoTsE7h3Grg4c10ls+ggqog4SE/
 gjR2yglsRoSMsdkJ0nEJa4SHIy5RhsIIzkwTKHuKHNfKfBsmXDUIMdrNxKZhZVbfIz6f
 jVjTK45aGeB/XsSoBSDMhSRFLq5V0K1J8Vfom49It0M0oc/o3ArT83lnha0n896m2xew
 UE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745529420; x=1746134220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ocxHxQoXm86xOw/of9C6RCOKFBv2y9J9E+r6Bu7RMc=;
 b=dErq9XIF7dDZg3DgUxJX8rXNi6p6vj3S1oEHQtWmfkl+1ZLrq+z057anJNQG2Q4XKI
 abiRvLxyfUVrLqLrmLOuXCf857FgIwu8PhI/g8qrDZVaF2UqalIgWFLh1hbRCVZx6WDI
 o1iTTosjY7VUnEloITA0WwbbulB3AiJSb3TwM/PWG1ZduKoM9Y/mrYl6Qkb8e9QT3uUy
 vIEKX9rcCoykYv+W8fsy+yC+5EPoJGZ9Dn12ui8LYoaRtKTGK8vUqD7XkMhIIg+0jIdZ
 AO+PKHiwHlD4vyTC9/HifPsgK3WZoXK/OYpJNw3UUN5Hd5ip+3KKszZPXOeWs6K1pjr1
 TmGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqrNLqL2Jp9MXyKjeNVBsAJu5K+alC/zt2TbMhtoAIdiJNUDiMdGNEaH7uBL4ndCnwR0VYw/uqcPcm@nongnu.org
X-Gm-Message-State: AOJu0Yyla3ek6hn5mI3VB0ISsvAMtY22syDx0dYtxKF80NkV9SM1KpYZ
 DJiLm+MnprUdUq/bY64RzZvxnmgKrBOFHh5fh+4RstFyFDL4wtdjh9eF7CLQP4fl5co8URnkRPJ
 /
X-Gm-Gg: ASbGncv+5hSdAs0AhVKAxd7pv0J5jaRMTK+/8LW2A8sYSo5mJTWpFKTbSi+7PsbS4wy
 tx3xyUpzhwUOFZ/TaBs76JfIyYVvGn1ht/IVcLQfwuMpJr+evSO53wvhwR4qCaTSd1h9s3mLMMZ
 zjamkuaBScBXeewqdRP5NXDn74fwI0qeCoz+H9T+tEDhakCOr8MJCWD0oq05lqyky6aJh9aT1N0
 7QLC7pSmuKZ5tEZt6R2os76u1UzAx2v3BGdIor2/iqp0DZvhv6uRym7Xv3mQyu+Qy1HMUpzvGTC
 tWjNSs+FB5w7SjLGFT3UQ6ACzOoFcgzGTcgNeP9wFA2uTeuTNDGOQMiZXYPW2zoVGUCYaKa6KKk
 OlBYSIVU=
X-Google-Smtp-Source: AGHT+IGsT6DnsR3egoqXC9sVUhfGI/54Ogs1H9jPicG6ldBX2OzR2tqtTcL3FJYlEh0O15ZejmXY/g==
X-Received: by 2002:a05:6a00:a02:b0:736:39d4:ccf6 with SMTP id
 d2e1a72fcca58-73e245e643dmr6521651b3a.8.1745529420157; 
 Thu, 24 Apr 2025 14:17:00 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912c5asm1901562b3a.6.2025.04.24.14.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 14:16:59 -0700 (PDT)
Message-ID: <d8004938-9eb8-4756-a02c-d9aff45d7e35@linaro.org>
Date: Thu, 24 Apr 2025 14:16:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/misc/edu: Convert type_init() -> DEFINE_TYPES()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250424194905.82506-1-philmd@linaro.org>
 <20250424194905.82506-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424194905.82506-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/24/25 12:49, Philippe Mathieu-Daudé wrote:
> Prefer DEFINE_TYPES() macro over type_init() to register
> QOM types.
> 
> Initialize the .interfaces struct field as compound literal
> casted to InterfaceInfo type like the rest of our code base.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/edu.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index 504178b4a22..5723ef0ed13 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -429,21 +429,18 @@ static void edu_class_init(ObjectClass *class, void *data)
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
>   
> -static void pci_edu_register_types(void)
> -{
> -    static InterfaceInfo interfaces[] = {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    };
> -    static const TypeInfo edu_info = {
> +static const TypeInfo edu_types[] = {
> +    {
>           .name          = TYPE_PCI_EDU_DEVICE,
>           .parent        = TYPE_PCI_DEVICE,
>           .instance_size = sizeof(EduState),
>           .instance_init = edu_instance_init,
>           .class_init    = edu_class_init,
> -        .interfaces = interfaces,
> -    };
> +        .interfaces    = (InterfaceInfo[]) {
> +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +            { },
> +        },
> +    }
> +};
>   
> -    type_register_static(&edu_info);
> -}
> -type_init(pci_edu_register_types)
> +DEFINE_TYPES(edu_types)


