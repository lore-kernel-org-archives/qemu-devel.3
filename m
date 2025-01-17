Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5579C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpWV-0003R9-P4; Fri, 17 Jan 2025 11:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpWU-0003Qw-1M
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:48:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpWS-00015y-Et
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:48:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361c705434so16086695e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132518; x=1737737318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EyB/skZvZi5uJeOintJiNKAPBkRWLZ20o9jozeM0sDo=;
 b=sihHzkFXDXtdfgrPlaZRKVYlgwt0ta99oZHE7fqsJB1XRD0yFyPbqTNnTAY4eH06/j
 plV4ZTJykBgwhy3LzY6Xvg6obMQ/IgJt7s9nHjyC0k5HBaiyJrjPb6+CF31mjyCcv8e7
 JexVm7B6iT0rJRNErWdHXqAulaRZN8XO7ChdMHKT6UQ7Ddn4cqnlYugYoho2tbePeW4/
 3QZ/HRlNucVrtbIB7xoYbW32mOiErqYtLozzhXh/aGSCuNM8QxonYsFz+JABiLkVaqd5
 UpHIteJ8xATfhvrFxnuQkpjrn7TcrSRVn/gPnOIDzjrW2sRDJM3T2m0YCn7Td8JvDBzW
 BKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132518; x=1737737318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EyB/skZvZi5uJeOintJiNKAPBkRWLZ20o9jozeM0sDo=;
 b=WCmaycVN65k38PPtSdjOwJcTC7iFXDUaeV+88vB/CCC4FAZgh3yNTKa8scNcDIUmpf
 0hacFl2BNyOx9mHi6spouLK+R0zhrQ22l1JGrE69Sw5yI8klz0oW3g1oJSvkIDPK4x8j
 dNXPbbtPWleL+Qf+ced7MUmmgtSQSFKNc7xKao98Fyn6TTfjzW7505YLouaHVud3h4KT
 XbMlrV3mvjBLtPNy9wE2IB8J2twaWM//kx177iRs4oirmuWfP6TS0gI8bnVznsVXoO9y
 S/6oXnNJ3WHwNvZbqUwwPCub8eKS2W7CAhOOKtxHWqpSHnb4n+dKR2LDO8k3jFb3XuWE
 dq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7mDB0r7X6xShDIUhbKtaxtWT3looZTpQPdO3XW7w7Gexdt+1To1yHshRg33B2Ou+susN7xwqnaSjd@nongnu.org
X-Gm-Message-State: AOJu0YzTB/es3ZWMcQhLtHvBJSLvBjFyyZHuOuTugawzaMnfMhZ/gB0u
 4MS9N9bNSHlJCtHyguD3CAa244oShm2+C54JgqW1CZk4zJbyZoj/SildgRrDbEQ=
X-Gm-Gg: ASbGncujuZUlYl4IeAB5DzCU0NEZtShnK/+zNmmVQ6RMh0b791JhUy9AKZLVKvVoup6
 TtHlLgwSu1xGi6PY8FDC0EO+b6xKVuOPKYuVZRKkEbdXX+oZfQeAv8S/5aqqQQhsFZupf8e6MIF
 zGEqWN+NFRtPunqRvQ2s3aOkh/zSJQ+JsAYQ6CYfgyRRW6TFlIcezQe4126BVT/DrNBcpKncPo2
 SORQBmcH9Sce5Yr505zIfPGplastSMTCKcDBZkwzg4ltae4IdxJWR3C60ScwmVP0NNy2pmhaJGL
 /nVMRYC3t7xxKccPQfXCrOa3
X-Google-Smtp-Source: AGHT+IHcwTZqhllsjZcr6dTTjo21JPVBa85FJBWd3krKSuv4oWAYor30jLWPmcSzlCHrKV0c65cBtw==
X-Received: by 2002:a05:600c:46c5:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-438914297c0mr33579875e9.24.1737132517696; 
 Fri, 17 Jan 2025 08:48:37 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3275622sm2968059f8f.69.2025.01.17.08.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:48:37 -0800 (PST)
Message-ID: <7991a31a-7397-4f31-963a-5818d388c096@linaro.org>
Date: Fri, 17 Jan 2025 17:48:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest/test-x86-cpuid-compat: Remove tests
 related to pc-i440fx-2.3
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250117102738.59714-1-thuth@redhat.com>
 <20250117102738.59714-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117102738.59714-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/1/25 11:27, Thomas Huth wrote:
> The pc-i440fx-2.3 machine type has been removed in commit 46a2bd5257
> ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine") already, so
> these tests are just dead code by now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/test-x86-cpuid-compat.c | 18 ------------------
>   1 file changed, 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


