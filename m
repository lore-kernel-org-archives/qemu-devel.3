Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534AE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTjAA-0003uF-S1; Fri, 03 Jan 2025 10:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTj9w-0003tF-B8
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:00:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTj9s-00020P-0S
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 10:00:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso81599875e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 07:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735916413; x=1736521213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dpXuYcdvuojmHsWcWvPx03ZkYKyOJt6Gyjb+5tlWOc8=;
 b=eho8gqTFucg/ZC0A9kG1/Twhc4b/+jqBtKIBdWAqN3KthRs6BzDj4V3St97PmXnwys
 7hg/3qYIVAZZSYq0vye8n+KzqJjm9Kq2lMXwaI5CTD3mPP4ENIwXJ2jeinYb7hRg1Xl4
 iENRuOBnGBQTodewWhGfH0zwAvuuUASP3LRe63/wX4OJHSLITy2XcgHHn9+ylPFcaPw3
 eKJ1thkLxtvnG3ayIT4DY0VR2UL6L6oYKGsZkB8Pr6TVqiZw7JlPC/NcgDBKGkDyC1wg
 iSFgpFM8T1CSFiaE1wjCZsX7xc76YWDbYstWBhpCBsf9oaBjJNNX/l0xvR6zE/vJfhhN
 5j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735916413; x=1736521213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dpXuYcdvuojmHsWcWvPx03ZkYKyOJt6Gyjb+5tlWOc8=;
 b=cmX/KZmZuCRfjmiTbznvWmh/0LHToDuMAB7JGC8Pt1xE77xB6QlHq2u5S6dOMiv5KE
 vpnVIrhoQwOXruXMR+Eh25AWNh86+Fk+pgMwCCu5m1H6ERlLZoQwymZ8qJRGFai1jKhv
 UmmtU2sgHewzFnXv2fEEKB7MtT9R6hJN5O/IY62m5w8lHdFTyIAQ2zb0uUy6z8n/UTxJ
 kC8GyCyYN5IxwB9g8KLTdUsB5747AcN4aFzp22AuqiGM/2vD4WuDt8Sbt33TabuIVA87
 NIjFx2Kp6p46E9x1Wg2FQ8XSSbjoXvTyWRrAvYAxtA+f5zBFkwiGj2IhrtNx7+Mx3wPi
 dZcw==
X-Gm-Message-State: AOJu0YxJ44EQWRXFQGne/ciQ0jO98nHWYPG59rX0AvwPHoHLTOTdPGUO
 SdMLeGOJ8+M/sMa2RHrHOnLOvRXFwH6sxYGMZvWD3MTT6TDaOAonXlhltzqkWwY=
X-Gm-Gg: ASbGncsXAZk9MUCPpuQDHzPSDWogtVjdcuTC5hUMOA+0dq58u14hIDVjBvmZoViounM
 oNa5ZQTKyIY37Y2HD6Dmf9I0xgMhHwdH+LcxuitD3ZrlougVIJsmmKDyZ1Zr8l9EQ9UPk38nCm1
 EeQpXffedQVuwfxJA/9LxKRjeBunqo/0uzL3ap4UrWmI0B99kZVJDiJMtN5owkLVzF+X96Q7f7C
 H5laCcXtTbFu4v3vpHQgFZ+SDdFfUfF+0Lq/CQb5BlCG2OkiSneitF3Z6QS19D9TJ+MnmmAgb3L
 hk+7r1nEeUUIn4TrMZ4WrFIu
X-Google-Smtp-Source: AGHT+IHK/bgoMWiu1lahUIOprunmigPNOk04PFY1GNM0q0FVCDFKgxiHkrqgYXJqXOT4uB048T7+4w==
X-Received: by 2002:a05:600c:46c7:b0:434:a1d3:a331 with SMTP id
 5b1f17b1804b1-43668b5f36amr403667065e9.22.1735916413464; 
 Fri, 03 Jan 2025 07:00:13 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612899f0sm485864225e9.38.2025.01.03.07.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 07:00:12 -0800 (PST)
Message-ID: <2f674a4a-ca98-4a73-b0a7-c239d8bbe519@linaro.org>
Date: Fri, 3 Jan 2025 16:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dockerfiles: Remove 'MAINTAINER' entry in
 debian-tricore-cross.docker
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
References: <20250102152513.61065-1-philmd@linaro.org>
 <87ed1luhc4.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ed1luhc4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 2/1/25 20:49, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> AMSAT closed its email service [*] so my personal email
>> address is now defunct. Remove it to avoid bouncing emails.
>>
>> [*] https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/

Maybe safer to directly start with an archived version:

     [*] 
https://web.archive.org/web/20240617194936/https://forum.amsat-dl.org/index.php?thread/4581-amsat-mail-alias-service-to-end-august-1-2024/

>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Queued to testing/next, thanks.

Thanks Alex!

