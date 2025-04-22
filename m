Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B511DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hi8-0005p4-UF; Tue, 22 Apr 2025 13:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hhl-0005nO-TN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:46:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hhk-00017P-2S
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:46:45 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227914acd20so1019775ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343997; x=1745948797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ql7EAaByutC5h6FqfSoz0NE5jL9l2QsXocQ6Vm2P6ec=;
 b=eK5mmT+Rx9KGy3R2CYSDe76XZa5QifEul7ZHAggsRkMwZXuCSk1CdAczoubAPD7OoH
 E+el+bPrJVWJWE86aV2Bq4I+x0AqjDU21hNNwiR2g+ZEQ2Ixc/0cYFHsu2HfPmmiGKU6
 hguoi1a6IAdCbrIs5urb59outET10zY98kHF1GrYgvSZrS4m+Hj6PdNaUus949Slxojd
 aUroMQFkVavz+tCvHx/MCAHo5cVttITRdv7PcVgDSDqdc1NuPetGUd/Hkn7up3BDY753
 C11JjjSzGDT0qJYJbsqXBsUGI+o3PXD0lZ1Gcry5mFXF6tsSZFL5e20UjFmxNeDnwlZC
 KHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343997; x=1745948797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql7EAaByutC5h6FqfSoz0NE5jL9l2QsXocQ6Vm2P6ec=;
 b=K3MM6SzFNxK+ldGWWXy272EA2vNH4EwKImftPRK0c+VDC2/rehJ8zf2cSC23HmFxNi
 +cfXrhoT33gDCn1YqRmCu4MlHMYeUjjMU9gROHF+c4NaAzXaCmLwnj/pTzNerJ9zERfl
 B09eH5VfODaXWHiV3AEikROGXWX0gQ8mRf56PrNBpiZC5dlxwspRc07dZZaZGYM8sign
 dZklE+S4vNwK3kV8ERc8+IBhF8d3esPdHRTVaCc1Z+FmhgDKq6Od1uTUWLPTIh88j06x
 KlV2hzw9nkCj46CnyqVJpZQC+51VsKrCEu07F4YZvGqaY4ZMEOxeWIKWxhEmAZnvhXJ9
 i/tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwMk3nGN8OnneuQ9iNxRm+hZrxOmDssq51xhoiqHSBt6IxEN95ODlSTRlYI4ZbAdMii9/15pgQszKN@nongnu.org
X-Gm-Message-State: AOJu0Yy77k9pzEjrPf7bj4a4Xg+tqcpDAAA0ZLxUGxJRq546pkDFYiG4
 U5wdjc8d31udXk7b/YkpUv7KzrwsWUrHLA05+YRGt77v75fLFTpUs1jS8pjXAfZrD/EdJIcTeih
 p
X-Gm-Gg: ASbGncscA4bg7VUsxvnQOJSM9yYFNiOpNbJq1R74y4LkKXFjFBmhRF3sLeMWoFHgtai
 HCKnTsGCSqpa5X1r2oulXv6gNS5tv5Zbu8bJnpzf+/bQdlOg1zof3bHF7qLpRCDXY9c4KIxmacx
 VRb8sHMnGQEDXqeDJLWAtSXXy882IIYKzaEVPUJqcSSuNO/e8LWNdIV2XmofioHjo9HI8+3TN4r
 WD+h3SMNQOKidg4GnbMO0E/K8Vpq9kX7kKxeW18EN9nsciVM6536whwnCrzGp6ihqYidRRf+5LM
 WwWD3ZyyNSjjuzqBgsEoUEoYqGsboVSLNQ8ra22p+Mw/OQV4U7ZJHRsseHgVV3uhMoJnqViQdoC
 lNje5nnI=
X-Google-Smtp-Source: AGHT+IEHcxARicvj/S6nRMtMHLJ+ebqUpR45vw1g9X0BwdVtdSTYP6QZwAZDUriDKBl0iNUJtYFxxw==
X-Received: by 2002:a17:902:d505:b0:215:44fe:163d with SMTP id
 d9443c01a7336-22c53ef246emr222680885ad.17.1745343997634; 
 Tue, 22 Apr 2025 10:46:37 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdb1d2sm87762675ad.25.2025.04.22.10.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:46:37 -0700 (PDT)
Message-ID: <b6df5915-36c8-4887-aab1-b8a6354d24e0@linaro.org>
Date: Tue, 22 Apr 2025 10:46:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h   | 4 ++++
>   configs/targets/aarch64-softmmu.c | 1 +
>   configs/targets/arm-softmmu.c     | 1 +
>   target-info-stub.c                | 1 +
>   4 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

