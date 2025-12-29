Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EDDE9273E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 17:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHSA-0006NO-GK; Mon, 29 Dec 2025 12:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHRt-0006IX-Iw
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:54:32 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaHRq-0004nI-RQ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 12:54:28 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so4520657b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767030865; x=1767635665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5mESAwMIaZhTqkXM52ikDUvB0G0HmjkijOpwFN/LSz0=;
 b=aDX9kzppoiXMGQ9doY21zNY6tYjuSlX4mNu18gOM8ykY5rRj0SzZ/T4/A7JaYJs1AA
 juKOLnrXLaTy9kKkD+PUOfCJxUaSqFG+UqN1OaEtVqvjwqTdm8qe4LcCdPcWT45iwv2b
 0sJZx0iYmp1j4VnQ+iXR4qfpdVjczHy3w1hqakJ0448koubBo6R1xd+rqCoVxfc8VOhy
 V62CNlCy6PW2SXeDLFjKNVcM/UorcmT7MK6wL6a/m/kvv7SIZLYyVWCV2aYZyZlE8p85
 BnvLgl3EEd1z6UL4hxJV8PEXpEJOGeS2y7SFkUG87tvpEw7cCzGztOH3viLUZF3cXMlR
 wDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767030865; x=1767635665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5mESAwMIaZhTqkXM52ikDUvB0G0HmjkijOpwFN/LSz0=;
 b=lonzvlWodBjGhrzfEevXvSNTtOb2ou5SKKlrsaTKRfnZNEGPk8XYnnuEWfpJ4OqtMu
 WNL12Fx8Z2NSk/mdq0aztm6Pp0bUZD9wDXRV16r8FtypvMEvTXS0ueXfZX9FhuBWpvVe
 i0qh1K6MUrixEG6nwP4X+Q8OPmKt9vly7vqKrMV0r++hgyZI25wF+dE8aZsF40dY1YMT
 KjMg8ITsMcNbwylLhMeRtrQlifJVwIgaeWHEZLk2FcES0ewnAW4i1DZkwxRKr1yDpLBF
 hpalAmScJ6spxazr9i91IWpprRQTuY+o2UR6P2x9oQ4fmy37oU4+PEAuFWpcyrZp09To
 R6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRvRaUxcJh2xQcVmLWk6KzTf+X2sJ8losCQQiqnZbukVNm8BMy2qyovfFLYayPkSmvzLQZFw/9ZT8+@nongnu.org
X-Gm-Message-State: AOJu0YyYWqA7BWtvd98X03lR/5cQHfj4fKL1yprV/2lGLqrnSfK6n6+V
 uJiW7rCkDb+RYzmB5dslr0lfeFUt5NnAwZc6+XG7hou9+24UyL3Ao7F6IK8dmf3yuPQ=
X-Gm-Gg: AY/fxX66pblFf73+8fGXKpxxdpvpA9vE7PZ7FQ21ab8sWn+d76WVZbWPfA9U9EawBXk
 jQ6Sp4TfeG2KbQX0lNXG+udxBeEvQ9QR632TzXjC/5UIc8pDorcy9suRpSo4pQlevroe0FDgUe7
 NesMOUlNHsUd9UKUF5iobkgeq+qPgkzlkCFJaN7l2h9w/AQEyYaKB9ELkNFysxUMLhj+p8PHp6q
 2V80xt7oCNdx4m4t/8pZQyBaQtlcKn+X84aFWFl4fJW8XgrzNkMFtjRzcXXWnkvlo5IvyXPPwxH
 artEIpZ31f4OTP06N4f1BH9VR5B/WjbqNyaae2yOY9x7R8bjMbvHOXXt+MRv1oJWiSLigHe4RTb
 xO6g+q9HJlsKjOHw081BebFkS3AhV2WVfOGFgZIhCKBMp33HrlpuaZOLTYj/S7+yp6WLRiSVxkY
 wJYdLGPlB4BZt4vsDKSZvXKcRvvTci9HRvRUJgSbOSIhY8PYs7IZhtid0wLPck/EbZmL0=
X-Google-Smtp-Source: AGHT+IHQ8yYvue4jDg7JeE3lH+Gt+4MdRjzYLTmvkOUCJGp4EE3jFYwbcLmUa8MKW1PV9cUvFd421Q==
X-Received: by 2002:a05:6a21:99aa:b0:366:14b0:4b17 with SMTP id
 adf61e73a8af0-3769ff1ba96mr30143190637.34.1767030865328; 
 Mon, 29 Dec 2025 09:54:25 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c147943sm26110508a12.26.2025.12.29.09.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 09:54:24 -0800 (PST)
Message-ID: <6f75cae4-817f-495d-98ec-c7af210db9db@linaro.org>
Date: Mon, 29 Dec 2025 09:54:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/28] hw, target, accel: whpx: change
 apic_in_platform to kernel_irqchip
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
 <20251228235422.30383-15-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251228235422.30383-15-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 12/28/25 3:54 PM, Mohamed Mediouni wrote:
> Change terminology to match the KVM one, as APIC is x86-specific.
> 
> And move out whpx_irqchip_in_kernel() to make it usable from common
> code even when not compiling with WHPX support.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/stubs/whpx-stub.c        |  1 +
>   accel/whpx/whpx-accel-ops.c    |  2 +-
>   accel/whpx/whpx-common.c       | 10 +---------
>   hw/i386/x86-cpu.c              |  4 ++--
>   include/system/whpx-internal.h |  1 -
>   include/system/whpx.h          |  5 +++--
>   target/i386/cpu-apic.c         |  2 +-
>   target/i386/whpx/whpx-all.c    | 14 +++++++-------
>   8 files changed, 16 insertions(+), 23 deletions(-)  

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


