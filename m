Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E91DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGd7-0006y7-V2; Tue, 21 Jan 2025 10:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGd3-0006iX-NE
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:26 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGd1-0002CF-5H
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:57:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21634338cfdso137177485ad.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475042; x=1738079842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4wDzsNbQZmZ06uH+ya/l6f07WSn261srnfiAxHen/9A=;
 b=z6qAT5c2DzRSjeK76R0t7EP+GSAKsNKsvqqg3WwhoVVL1jsdiuGIiM3MuF17vrB1mr
 0TBe1PZ2aCWgiigcdBPPkhvVxgzuNtULsMmEsLL0e63p63zP1W6jT4B03XUmttdEqUNo
 BVwLFWxmUFGB5b7lov0HrT+IHloV5amnl7VRbt5BYKQ4azGvTd5pH3+42CU/H2k2okmc
 AeGFoUyDR3rvII356tJluCDqGSN+oKJ/EaZR4YGqh2Zj7dseP8Kbtw9lSTEyCvMZkbaW
 U9D219qr1qgh9yxAMsoPRo6U8mo97YMootCcMPV4BiIe//zVw7s+90DH8O1VrORS40i0
 a/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475042; x=1738079842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4wDzsNbQZmZ06uH+ya/l6f07WSn261srnfiAxHen/9A=;
 b=t7GImQIXyFpbg7mXrqJLNSM5YQbHY7HUu7hZYj9vmXxHXr6WJ0B4IUTF7M8JILgCXT
 3ss5AX2uoe7rJ/2FsBuEWfYG0y53XOSjx7djOUlJU5OuOdrC0nDMfVIeqPW4KcCdkVpd
 Jk+cQLGm0efUPykJuELwfUIrD0fC7OxtnAOEBgTY3vKA53c7eFZvyS88DLIPCzsC5I6+
 36UhfiR5BZE2gPXyX+WuNlT4GER9XAs4zNiDTM38oluotPA35hxvUQC3Qhr/k1iZNjRD
 7ktbxLDWyCDiWqC4q4luGRC4LEVBlMHZUyRgr9xZG9jGWI509fT58iLkg8ye8gRgJlyY
 QbgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQJero6VEuk2jg/6vREi2gJNRLEJ5052Po3gA1lG/RR21DxRcs7dr+UxgPOlKDdn0tHDXE7EsiwKlK@nongnu.org
X-Gm-Message-State: AOJu0Yyi7cQw9Hv4OhlbRCKRj00chacCC/hLAu/udCL0c7PMJN82bqBe
 IxsmfZTVnQdpn/I/QGrb2/uCOp1TRdcJlIvC1BUQMe8sZhTQ2Zl7WiCMMu+a3TWxo3VEndghOpM
 h
X-Gm-Gg: ASbGncvRDURP0w/52v8rUic9LWOKYn9T6RlTaSZ9N4AbtJh+azifWqHgRXD8Nh/8UNF
 PNsCVxMjbJHPQDT5Cim8No+ISb2oWVIKKOTikUFYrlGGMl6VvxHVC48ufY88X/TEItTcNIXBAga
 PczDEU2vyZ6VETs+xsEfde2Hg94hTRhOL5G8RzrHjGJbJsK1mh/0qdDmaScniZXHCxlEUxatoUW
 WcolbyXgAulaZBZg7QpoCVBBGn1uZGis9Y50EiCXMTghRWdRLIc7HF1T6oJjnnqGGKa0DO5R+Cb
 bscZtZ0rN8nYQSacuH4JPOxpCFITmDz/ZLMj
X-Google-Smtp-Source: AGHT+IG5LBEX6jqir5XDRicsWBDWGzUoTWVlFGeospg6Dan/9Sgp9SHpp37qORngecmNFSLAN06EEQ==
X-Received: by 2002:a17:902:f68f:b0:215:a964:e680 with SMTP id
 d9443c01a7336-21c355eb678mr284443905ad.25.1737475041723; 
 Tue, 21 Jan 2025 07:57:21 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21cc440b929sm36480875ad.68.2025.01.21.07.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:57:21 -0800 (PST)
Message-ID: <9c20ea71-f662-4961-8e25-b9d53178be30@linaro.org>
Date: Tue, 21 Jan 2025 07:57:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] user: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/alpha/target_proc.h | 2 +-
>   bsd-user/signal.c              | 4 ++--
>   linux-user/signal.c            | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

