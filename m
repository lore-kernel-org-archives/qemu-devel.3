Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F154FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Gdw-0001ZS-18; Tue, 22 Apr 2025 12:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Gdt-0001Yq-Ll
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:38:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Gdr-0000gL-Sn
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:38:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so4050666f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745339916; x=1745944716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8n8Zuow/S9YnpQXwV4ZideYFrafbjnZ9LBkj+Em9s1o=;
 b=lkOV62Zu+0gIqlkpKzpTxSQOY1DghjXBn9RlVFRZb2/sUlBeuPCyRWjrAffxxNm5h6
 a5ieaQ7+HCl7jGq9JIEq3Jge3gldXNmdWoUp4toq5AuXb96WqX+1/0KnaqETAhedQdyi
 Bx4qh5w3DT0PAUz4jSFQO8sWvX3CUNb5aGsQKmvqTMpUDYe5w8z33q2pMz+asZJkoxIE
 dx8/coupHyu88Gia1iR9RnBJwz8TVb0h4p7FuK7F3Gn+PPWlp8elZ6cZIgQh4R4WvbgN
 AmEwY2J32/SbGHGI7qiI+gyWxhjrYZSjTeKeNiyBYNmLk7hnuy7yY6ldL2gannrLAl7/
 HAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745339916; x=1745944716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8n8Zuow/S9YnpQXwV4ZideYFrafbjnZ9LBkj+Em9s1o=;
 b=O5PNV4S9M4kdH4fKykzFbwiI705x8iXFtPCUy3O5i5jelFDwTMF6dqLzcQky3yJEdL
 LuJgW6Xd/H1eEeblgRnMbYaVWoPQPYZMcp1PwssF+lvs5HMjEawz+lCnf0qdvZpdjfRG
 RloVnEHwbo66ivwyL2L7GtQ2wzTOeTrAkVq7nyJC1ciNW/mVM8GhkTmci4jfZiAnwm7M
 ZUp9agrdy/1k+BCUnpuuwQvPVcTQjgfogMTcfsbhK11fovP0gvH+f/csixal8OPyODMD
 epEmtgi6ToUpf1zoAXgSEwwalhTOeZYTUjYCb34+Lndcffw+x17HRc+g9qGzvS1y4udG
 i5zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjVPie0Xv1hL/If1E7yzH6JP9uO9joLI58atWYcJVYmB465ubCKur4wxy7W1FnTIHq8VazDcWP8KG3@nongnu.org
X-Gm-Message-State: AOJu0YwNTTy/Ep9HDGCLaRki0kensZ42FR3/Y9dz4Of4vFl8VUWCqba4
 qzf0cdD/JGQsEmdAMTjhSpvktfIKM6/fuq4uiF12uAs4UW7elC5//U4BJVyK3S2MuQIcfcQCSD5
 J
X-Gm-Gg: ASbGncsic3oAz0nOquAVPWU4AqJ2mrlDVSlKdu25KbF1qt/iSZD1sxZshdO9PZF9a52
 PdrDeVG1lfOz4mNkRIq+OVs21QxgJnq+F6ITuiMU7dJ4BLrT2BMxSZlbpbEjMZdh7Cq7B23oBrz
 i2JCZVctf44C7mvvdca2yGwP7Oo5icmeZpYxEZks90qL3dO+Rb2VEV7qZZld4WLRW3hD90XVLu3
 zxiqIYKQsX1feGoAXXe4U8xw0BONzpB3AcxZcCoVYh3UH2a65NB9WQTnZXf5p9KbJde70QU5cvY
 T0lTgRrFmNzbZPgdm0cTvH1jJyXzZW9L/u/3pJjv1aLbzF1qKDGf74Q/sAfzaomUcaKyIoHTp+Z
 IfqY61HwMaoYwnlitt6I=
X-Google-Smtp-Source: AGHT+IHmiIqIc2W3ADwx5xjY409vzbY1Hm4H7Be3H8N3AUTv2xzHysDqosIBMdLIbGpKrPfnSYyZ2g==
X-Received: by 2002:a5d:6da6:0:b0:39a:e71d:ef3f with SMTP id
 ffacd0b85a97d-39efba2af49mr13928808f8f.5.1745339916189; 
 Tue, 22 Apr 2025 09:38:36 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43ce2esm16068923f8f.57.2025.04.22.09.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:38:35 -0700 (PDT)
Message-ID: <101c2a52-1555-4fd0-b627-8dc70e3d6c78@linaro.org>
Date: Tue, 22 Apr 2025 18:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 132/163] target/tricore: Use tcg_gen_addcio_i32 for
 gen_addc_CC
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-133-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-133-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/tricore/translate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


