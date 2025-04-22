Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2319C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hdj-0002NS-0g; Tue, 22 Apr 2025 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HdX-0002Jl-N2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:42:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HdV-0000AF-5K
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:42:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so21777645ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343739; x=1745948539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxkXDwEoNeoFx4RY5/A9K08Dk8Quxbr/EgVHX9SnA4A=;
 b=oIIHiGcvKWJLZZ1ph66KFtVqr3DOjWNHEMaSbV4DeUcvOt+A11XqVgpilWzqPoiJWA
 mYkwTKW6+H3Q0Bb74yG0QkB7iqfCs0piIL28h4v5cuxvzMyjcXm4LI4lncTZk0SxOqeC
 Vs+WIbeEEJms0YbAnsMqTO47iY6/U2Nb1YWw3L+xOlM7cABO0jp8ioJ4PuMN3KqZARZ2
 Pf5GyLrNi3ryuUDQaFyqfBWbMbe2st7ZXOw0/gD8VuF4G73KjiQraUcbdFkUcwx5Dft/
 1dism+k36lpV09CG86ICa/xcryumbFQXteqiwgM+H2Eps4l8sMia46B3lNDxZ1W6LFDz
 x6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343739; x=1745948539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxkXDwEoNeoFx4RY5/A9K08Dk8Quxbr/EgVHX9SnA4A=;
 b=axnWP3PXsLHPGnwXdKJ8tfKMbHLwU7eukTOg8IG5HzckC95YZYpSv5V0VgvM5MshG+
 mHt7eo+Xymi+/M3jPLQeIrcyGgsYqUt1QQQ3gStmVF5Xmy3qFt3W4DwDTHjWiQmRFvBt
 cXRJNYJgdtBdQr612POB4wfUjJVE0UJhuqujbwmZg1BvlOKHUO21go3OegdTKUHJoS6Y
 xVUZyqlcE9HZTOGrPn98D2xqpWyRYAHBW/djW0qki3IJkLKwhJByJY9BVItuOZyY+jsu
 CWowxp5fI6/+NIJL3vFUk9G7DlKTfLMqOJxvSjbx7V1NtJOyjlhEgY9jMSWGTCJnbMh3
 TriA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp8PSR1GKzZC6JYUBnOBCin9Ys5eC3iXWdjDJAfHeochiqbqxVZenCeu57+g6gT6HE6OIVHoevr4ZA@nongnu.org
X-Gm-Message-State: AOJu0YxS8MuRCRPSRB/W1Eoitce1CW9SD+ttv5MNvjuf4Qx92KbFDWYU
 MXIWyb2OvdkG58VWXyU8CnuSegfSsQNcNEGJ4FWooG4R6Cj5AaXfKddZevbf8bw=
X-Gm-Gg: ASbGncvD53sA7GxhiyJbei+0YgXIYysXP4BIR0KJsLkd9wLqWrFxOVDNVPB2NmfEs4D
 OF41eVnPIVHNkjCOF5RROxcvsHgU5L//VokKfsS4A/6BdZYOfGZD1J2OlVqLwR7ptx5UB8sOYNu
 e92pprfg7GC20IxCjaOSnU9v7/Jq6xqJwxSILUby61HMV2dWvTvk6H266RF8rWaSmkQN53OM6Kj
 8jQUsEdUWnJagnLUPehqIjScRLy13TfBiwl4aBZMoYyhl18Qou0UcNIyDNvflIGGUtDFIkGjH/Z
 BoLjdkXeT7ppGF17mkeIwrkAnqGS5Z7mKUFAvMxzXtncWICm5NvOu5CHkTNsttWhA2/75SlFUDI
 askoX6hJvbnmeRHUMTA==
X-Google-Smtp-Source: AGHT+IGCvmhL5oS0wgnu2Q3bHYBThoTcn80l8onGxDP7MFqtcmBszsRcTsV5FeqAvm9w6i16z2xu8A==
X-Received: by 2002:a17:902:f690:b0:223:6744:bfb9 with SMTP id
 d9443c01a7336-22c53618cfemr238638165ad.41.1745343739481; 
 Tue, 22 Apr 2025 10:42:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb463asm87751685ad.141.2025.04.22.10.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:42:19 -0700 (PDT)
Message-ID: <dab923d3-2f51-47c9-9e2a-6857f73ddb7c@linaro.org>
Date: Tue, 22 Apr 2025 10:42:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/19] config/target: Implement per-binary
 TargetInfo structure (ARM, AARCH64)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
> Implement the TargetInfo structure for qemu-system-arm
> and qemu-system-aarch64 binaries.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS                       |  1 +
>   configs/targets/aarch64-softmmu.c | 22 ++++++++++++++++++++++
>   configs/targets/arm-softmmu.c     | 22 ++++++++++++++++++++++
>   3 files changed, 45 insertions(+)
>   create mode 100644 configs/targets/aarch64-softmmu.c
>   create mode 100644 configs/targets/arm-softmmu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

