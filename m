Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E658CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb0p-0003V8-5O; Thu, 31 Jul 2025 17:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaoZ-0007pm-R5
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:27:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaoX-0007nm-Hj
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:27:50 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso226984b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997268; x=1754602068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCyROFDtAnSwYWUlhHSj0509pgu87OOt5KfPZt9VUJY=;
 b=yEYdOB9BVNsUdNtr3jzQ+OnptxZJQZ0H64qyoAGO3zWeUIGqBZ5T11pGnqevzEM6Qo
 nh5wfEyFh/NAoERno0yrmJ+Of7Fyjt2glGO037CxSscAs0r8s5bQR3lrX8/22OboTCQ6
 V34f0aYJKpwm+kyuMGxhS0C7wOrxSNNqF/q+DzDeBt2jRmpUfz3EB7OAASIgwOwu0c31
 7zg90kGqfb6oNjlTqll01wpuwSVJ0xCz5XT8PAuwy59ctpPXXEVtokSEsbCuYM21CPQh
 /UzZV//GmFx1MCfork7daW1I/DOYpJuWEMKYetdZjSo6S0EwiuSJsvC89tKgWtxF1c9u
 4LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997268; x=1754602068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oCyROFDtAnSwYWUlhHSj0509pgu87OOt5KfPZt9VUJY=;
 b=IE+UNSkkm6VxVtpi+zP0bU6/K65cYPfx/23uWm4ya6HkXUE86g1f9gZgwMhh6b9c0a
 MIbcqXzkP+F3WhC8CgO4pInlDIIfaq8eFzcLP+ov1inEBgI8Yz5qNJyvIv5z/0yJLmOy
 iRzr68WwXKV8loEoVrN7iCIKVsFFZmiqJRyVnqmb0rgoqr0l/kv0v7mdkDEb6ETaZcS2
 5unQjO62vaiNT+qhslWtAq74Aqw2nljB7aPwSEs430d8zOiJgDGlJWwZsdrDRxY9Y5y9
 Bb1BsyNa4EoE18JGmWCBumgp9CIl8bHreY6Rktg4ZqGDJv2n4gXzPQxtK+2KIkQjePBD
 m+0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUlsqCRP6Lbdoy/v7ZuaKI7gcrmEIuaTXDiJ2GdZrXoDreH7tSF9JQRQQXV+2D6mF+RoYbRfp7S0Pm@nongnu.org
X-Gm-Message-State: AOJu0YwA0jxJ9V9/6+dHwm6xTyUXzaPC1AQNjYMzb5wwdEziVqOqX8D6
 KsArKH27+l1nU+ERrFbPgtehhTi52xjRonL3WAHKvpBm16Nn9AFncFeBYzjtyry490LiKkLTq6T
 wUqzZ
X-Gm-Gg: ASbGncsLrFZLgfgCqDCexXPqSG8E6HbmQGm6TkMjLKZUC3U8RCoCOJTvUM4tPyVbx61
 tTEpLDGJhbgfYj0N3EF/F8UDm0LZ8RggeiiOGcnBwPYaCW3pehkGFasfUCWFUdUJvQEMCeKdBLn
 zsF8T0qdMzTUS4kBHAHQl7GqsEW7lNj/VmnLUKjWumkDOiipEAfP6gBCsqoV+V+HuNvyICDbO+2
 MfzkIFslqSgMPg11ZkkkC5TLtr0HEil9VMA481Uv+Sp9SFVccFITQ0gEAvCd+bpJsHAJo00NrMQ
 Bgps/WmzmCcmY5t+IimjTOHd69BDmL/x5vjrS2dPVvc1sPSnrjwBgkPtVDgnoAqDBTp586SRjjz
 d9zNvHl5NrZf8ol7LvCjDWihhh23X72cXsb4=
X-Google-Smtp-Source: AGHT+IHsXG067uA95rUUthiwRgmKHcirISt17rwQ/T7NJXuLotoma9V8gNIWxVdSKGjDDaH8SdyI+g==
X-Received: by 2002:a05:6a00:854:b0:76b:a439:be4a with SMTP id
 d2e1a72fcca58-76ba439c1dbmr8076576b3a.12.1753997267957; 
 Thu, 31 Jul 2025 14:27:47 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbd05dsm2383940b3a.81.2025.07.31.14.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:27:47 -0700 (PDT)
Message-ID: <d2992753-eb8f-438e-bf14-df5e9f3b10fb@linaro.org>
Date: Thu, 31 Jul 2025 14:27:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/82] target/arm: Implement GCSB
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-56-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 8 ++++++++
>   target/arm/tcg/a64.decode      | 1 +
>   2 files changed, 9 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


