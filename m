Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C29C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HuO-0005A9-Hi; Tue, 22 Apr 2025 13:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hu3-00054n-Lb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:59:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hu1-0002SE-SF
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:59:27 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4226864b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344764; x=1745949564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o61QcWLoPVgUg9t786R+CUx65FIyjDAKelns5KvwtxY=;
 b=E+JAnAcpjTYJgsVClcKcoS4Lv7sMSCOC7hZFe1vkrZt3sk4okhHnUWSu+yPbRcW+k1
 OpmpMBFVGEVz6R+4MbOaSWho+auDn3GaOAxT+T2ab4dKnlZ+6DWJarbXMprIgQRD2J7s
 TBqMteUN88Ik3tomgn6F1LQLI8QtYoUa13mgZjrSuVfQvRtix06qxhoqQ6V27CJtIVv5
 nlIdujrUAwbEgGcf6Mw7gybJZAKE/EF0YIPf+bJ7NK8vJzXg1josRG3/RMSD6O+sWx05
 uN7YJ2E2x64S2JQ6+GaId9IHI5JSjp7DQlBgji74Y346p/eLnZAlfDPVJoJwsWG9EZRo
 MR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344764; x=1745949564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o61QcWLoPVgUg9t786R+CUx65FIyjDAKelns5KvwtxY=;
 b=YuP8sSJqF4kP6oafI9b2wU8SvrsigL+YTq6c+0262ejT//1YWWFQ1D/nTWE7vNgtui
 qIPBEcQ6Rw2kK+Iu2jUc++SbdL4AFqiFGwMCrINoeCup+1J3DHwAKtjoVAT8PgVOfGZh
 SEV3LJ3NKvIb7KNnW6pb0+3b0mqG87tiHYBX/bC3LY8oGzhCXgbtln+sXWmLKgsztSk5
 B8VRmixcR+tAqgTkJlIozhaS/5UExj5GemhRlpVjNVu0QC3HOXbnwm+/1v24HtJ2ePzh
 EH9qHocyH7mBv0OnAgJktOf9thS+cEZRyfx4MjJjOOBPSoubp6Yonm1tVR6AzA6PidXt
 /R3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0LS1qMURyscw0U0ocV/y4wD1mfhGQ36F4Wbds2ErkJEvtWFV3VrniGHGBlKG55X6BcUdXDXTemsV7@nongnu.org
X-Gm-Message-State: AOJu0Yx3B64W65Bo6EQdYIV31M4v+AhC9d164xRg1zq6l0qOCUn4fmEz
 K4YdLW7RnAYq8gLszckMNryGXLikzB9m3YObEqbAB6OOovPvz6D9bLJvzUe/6LPjIfjYYW5User
 o
X-Gm-Gg: ASbGncvFEKWpAU6wt8h14F8Tvi4N8XngjIbo4eyOAAsyRVHK2zcEAi1Qsttr6UVxWPb
 GpihcPwfYZvcqwD7OTIhHa/alE4sX/iq/Ktk9LPOjMhOSHGBZelXoWnqi2zrjbVH9lwQjmQcNzo
 fMg2q0YKlIm8+VtzjPO/teQ2q7dSDn4t/eTuRJ/ZmJVJ35SkxcHxrjV7W82kqqoiYSBBJNjzrf8
 vt/hF5Ix/Ln4dECjrUUIWU+7knHtmljQA0TIut9jtVJPMU704e8MviwL89BdpNCfyOey6KkzhlF
 xlR6WYJXZanFVvQbu1XiwuNKx8FsUIMuq8sycBNvIfl8lEGBJZ+dNkc52qrhGLY9kS6gSywO6oB
 jTRHw0dh8JDDpokaFIQ==
X-Google-Smtp-Source: AGHT+IE5iZgfDhy3XBRtIMiXaMsZAVPzGb3g+yEfB+0WTk6krDcDTnYrp5JPubQjmui1ddiGtzzi5Q==
X-Received: by 2002:a05:6a00:3928:b0:736:755b:8317 with SMTP id
 d2e1a72fcca58-73dc15d32b0mr23148337b3a.21.1745344764448; 
 Tue, 22 Apr 2025 10:59:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa52a4bsm9247703b3a.97.2025.04.22.10.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:59:24 -0700 (PDT)
Message-ID: <f62780da-1f37-4646-9189-b8ae2876c360@linaro.org>
Date: Tue, 22 Apr 2025 10:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 18/19] hw/core: Introduce
 MachineClass::get_default_cpu_type() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-19-philmd@linaro.org>
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

On 4/22/25 07:55, Philippe Mathieu-Daudé wrote:
> MachineClass::get_default_cpu_type() runs once the machine is
> created, being able to evaluate runtime checks; it returns the
> machine default CPU type.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/boards.h |  6 ++++++
>   hw/core/machine.c   | 10 ++++++++++
>   system/vl.c         |  2 +-
>   3 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

