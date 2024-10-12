Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C48DCF2570
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szfG4-0000cw-Mz; Sat, 12 Oct 2024 12:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szfFy-0000Vt-Jy
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 12:46:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szfFw-0004AN-Gw
 for qemu-devel@nongnu.org; Sat, 12 Oct 2024 12:46:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e49ef3b2bso829474b3a.2
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2024 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728751575; x=1729356375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hGCBSw1ifG3jWM/rBVqiVHh/f1AhITQo4AMd6yz3xLE=;
 b=udYUI6taFJq3Bn9xRN9rpuYl+6Fuek4jlgD6R8WZycoG0KI05OwFI41S8MeXvqGBaY
 hmanR4O3KWyNElDnitulPa6oAxbMuvpB7Jp36LTCwLNCGGTqcSDx3D6IZDocq1SIidDP
 X8vMi/K3Fm+NMIrHeOKGwaVZ3FXxMCTmxgX8kROGJyc492UVo9Nk2knq4IA7eon5ui8T
 EH3H0ioXE7WjgYURG34/wMayvvJXE2TG528dJc+Xb5EdiCry5mDIJ/OWnNpC346mkSZW
 6oC4sSQ1TaGWRPbQxRbTuukr56iDgoKMK0GADeW9IbVQJzKp57+F3vds8QK9DX8PwDC+
 u9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728751575; x=1729356375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hGCBSw1ifG3jWM/rBVqiVHh/f1AhITQo4AMd6yz3xLE=;
 b=BssebMlHZxKjnKFdthHH1CPfrEsZmNwuno7LC2lKesGCMCbP2PdleBPDmXtXlunvdT
 cP8lWcqmNmF08CyUW2pPy0LrkHV5Pf66r3V/24btQifHW3Yh0WvLEeIKQkJSUaDV3Qog
 lsa/FXR5XpU6Yw/4MyeKOYtRdMBWiP1N1qBuNm1ArkwdkRkJ7lETJKDP+ttGpYnjYEta
 mt9ZFckoZuYvOmgwqgPyA5YNGQfeDP78rt+ewA1h4+oHazP9FdD8Q3VUCtaxh+14dHAK
 FaChQkFc2SxsJWYS0Le8jXyFfUOaGJ+uE/2yWu0SiuBICn9PZ05MlUY3gqNA8y+GeaoR
 rN3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl/i5o/1XOgwrKvndn23uQBOcY5w+GviQp6CINwc6DOaRZSQ2zGhoOSbWFi1TWJGAaoU1Dgh822akY@nongnu.org
X-Gm-Message-State: AOJu0YwNlnRGZziLWWVQB2F3WjrFrL9+Z8NSkHRH+Ao7MhXANxZ5hbQe
 1lt6IaYMdeFq8pgPeNgj1pVcQg1ppdfnmHJknSMiNHbxDRkrE7H2I/F8fzuExKI=
X-Google-Smtp-Source: AGHT+IGsqNL94RUj9tN1UY1xe8xqL6q0X8s8xkUGsYHrkCZHCs1thnqj9kFuTY2F1oDFgTnMTAwT1w==
X-Received: by 2002:a05:6a00:c93:b0:71d:f27f:a86 with SMTP id
 d2e1a72fcca58-71e37f48211mr10562387b3a.19.1728751575069; 
 Sat, 12 Oct 2024 09:46:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2ab0fcdesm4342355b3a.214.2024.10.12.09.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 09:46:14 -0700 (PDT)
Message-ID: <e80e3e19-f27a-4914-b8f1-a26e7f159176@linaro.org>
Date: Sat, 12 Oct 2024 09:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gdbstub/helpers: Introduce ldtul_$endian_p()
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20241010175246.15779-1-philmd@linaro.org>
 <20241010175246.15779-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010175246.15779-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/10/24 10:52, Philippe Mathieu-Daudé wrote:
> Introduce ldtul_le_p() and ldtul_be_p() to use directly
> in place of ldtul_p() when a target endianness is fixed.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

