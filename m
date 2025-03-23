Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9846CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPhN-0003tV-Ft; Sun, 23 Mar 2025 14:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPhL-0003s7-30
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:05:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPhJ-0006aT-GW
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:05:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223a7065ff8so56106425ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742753120; x=1743357920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aQ7+rDmSlpXdDKbxQNUBuf7IuJHZekYcp5Msdaypbv0=;
 b=xBTbRyXBEabBjl7Azt6WXTj1eh2B/UI/m2cs1cfZsSwi65UHUlzYAYb/eSo2o0y5dY
 Fw7kTEQ19eh1bDD+wagjEOyftlK5rD3MWam25h+1JlfOoX/afHQo74lT32sFtEklM1xe
 jblgy+AQVIr+5ofiamEs4LAggWbF2PYkNMYyyeL4dHql5fl5WhMTSmYHgLYEZHyHjiB/
 Zujp2OOnEEFIrzZfygGRKmhv2pzAokGKJHkZd/g//n1J9hNKYF0JvwzXarYk5zg5787r
 3mC8zhCTwK4jmGKfae5qFzZlQmGrRkfOub521v3nduypgml48IRq7JOt5dgs38jBgKY7
 uTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742753120; x=1743357920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ7+rDmSlpXdDKbxQNUBuf7IuJHZekYcp5Msdaypbv0=;
 b=K9/5Z800/jtl7RYR3X8HfeMlHIVNCTE4G82pa4Jqfu+Q11syg5vdBRxfATMyGE85uR
 n2qLzfrXR99TlSi1yRoo6/GAOBjbDCe/oA6arxzBnlqLJVJPyqw7vUtYvJeX4Y/cKqBy
 wS6Qb0Ll9SmhNIBidWzmIxHSOlMfC0MdO4Rm4pJNl6neA9Vgf7wN6QjEmba2XAjbFB9c
 DoVy+QcByUTX+3F2xhVOSFolRz86PhT/9kz5lMbuaX6vEzmAi7uMp0QxAgSWs2DoufqD
 x2aF42OD2Mnv2FWjaVSdlTiEOB3YvXkfRWGdUiJrGNU2sNn+f4EdRDN1jOkEdzO7vuSb
 tE3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjsu/QwtxbKwfvxHvihV/vU0pzB5qZEjySFcLkpWGRGVnv4A2bpmEx/meG+Hk/Ze2WWgRQAQfda7Bt@nongnu.org
X-Gm-Message-State: AOJu0YyLuYRjDnzT3ORTXf+ik0r0P3Vsft4PFNwGhFOnaZWKGz/weyhH
 TQ2kGPywloCWLLxDBhA5SpJsiYZBBjJpThwS+gsyO7i2s9NhjKLorz9KxrFrLKQ=
X-Gm-Gg: ASbGncv4O87/E0SAfVKxS8yZAS03HVRryeyxQxdSeh7GMauFogCLLXHOxOIgTWEDJUj
 0FnqD6kntKgpu0AyF7Weu/1+r9DxAxJiOcSxwxuUHnuZ+C1Q4SATw2MNsl+YWhhiwNhKCVoLo2k
 k9Hf5BIwqA6rSecfCRbFiJcMLP46IeoEn7pyRiumzOo4FzxdWYZm7uY3i8zrn4tgZq9qRx8lAvH
 8Jao5OQJt6ASwlOgsg6n862H3FJw8tilrRMXMWohBhT/qdyQm7TXkRIP0N+XPZuOtslBBvVY8I2
 d3dTXld5gX+AWNebSleip9Z/uxVPAPpcTr1rlKbGuaMZwiakvY8I5CRD1pTTcDoEKvzDuiHF/xZ
 QqxrrLkuA
X-Google-Smtp-Source: AGHT+IFrETehbKuWsjGwg85bGXuFHr5kvfb592zsOJ2V/I7WQTucK1RE772P6EhZfKQ0D8lPeJ/QnA==
X-Received: by 2002:a05:6a20:9151:b0:1f3:47d6:aa05 with SMTP id
 adf61e73a8af0-1fe42c6bce5mr19714562637.0.1742753119795; 
 Sun, 23 Mar 2025 11:05:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27db633sm5557685a12.15.2025.03.23.11.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:05:19 -0700 (PDT)
Message-ID: <191852cc-5efb-4648-bada-70ba3b736afd@linaro.org>
Date: Sun, 23 Mar 2025 11:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v2 5/7] tcg: Propagate CPUState argument to
 cpu_req_mo()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
 <20250321181549.3331-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321181549.3331-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
> In preparation of having tcg_req_mo() access CPUState in
> the next commit, pass it to cpu_req_mo(), its single caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h |  3 ++-
>   accel/tcg/cputlb.c          | 20 ++++++++++----------
>   accel/tcg/user-exec.c       | 20 ++++++++++----------
>   3 files changed, 22 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

