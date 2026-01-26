Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5ACD19520
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 22:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkVRt-0005ou-Sc; Mon, 26 Jan 2026 17:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkVRs-0005m9-2V
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:52:44 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkVRq-0000SC-Gk
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 17:52:43 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso274481b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 14:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769467960; x=1770072760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3bDBB5PvXxVVUgGswtmShbKVtzQwtdZDU1f29shfLgU=;
 b=Igam9gacUhyB0GByFLrXLTJgV+Yhpok5wJXua4DrSm9hL48pR05icDHJxU5VOOzd7d
 pOR9K9b3D4rzRdRoxg5QRaft8aev2xjER73FhkEOh7FoViaSAhPpGPv6ZSp542vzx0tk
 9LOUoy193HvE5QE3zCL4oaIwlWzjtahLIMMH0AQtJwA9RPENCJ6zQNvZ7z5wUaUhedja
 O8UBIdVNmjxbsZ+NhLrHyqoW1vuqdNRJ4bS28k6OVspLTH2zIkrZv9Odexzf8Ufz8Wyh
 7EhT1lhuPrIVFGo7f1J2qzMZKchbjGlAcC04RvLUUaG9l100KncV3rJ1PFoTWsoNBXlN
 wePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769467960; x=1770072760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3bDBB5PvXxVVUgGswtmShbKVtzQwtdZDU1f29shfLgU=;
 b=U8UgDjDdmwXGf2ZRj8o0qYSVgOw5k7Z2ZebiqMC8vebzXo6dMGpxArwbSzMNJvhVI/
 8f47oWQWP7DADPODzjNNA+ZbKPbXOj3izqgOjd91/hoDXctmQwRQP3fpRcU1fzbKpskB
 T9UI7Tbc+7FQMMzuEgx8pgcJ2HOpfa5eOQ0dIEGcNUW5CZ78OVxWA6LihBQ3iFA2JQ+b
 75lmnbUBi9DC+jfhuRpBp0P3kAyfWooZ0Ygx1betnbkttjbtCGkmkwjxoHPqDdshzqE0
 3a4XB7PO8metm6FtfBC08cnrtQ4cM+fqkywz5QCH/2HhgZ9rqvj17mPOEOAAQ/ADwmvF
 FYHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVekikztHUGPZyAnvEODvKOXAhz6BJNZseKe5ly8a6GlTA+dkhP0UHB/a639xVtEaQwL4B9FCSy7YJN@nongnu.org
X-Gm-Message-State: AOJu0YwGUZ0ZART8FLqzU7eGUCWHuNSCzximaPu2MKPpzdJurr5l2DwR
 CdUc9f7yu2sWSU2S0Ir5BjKm0/NtFsP4PjZ4uvg/+6N7oSuDc/kTtyKYi9lvqcjRhIgP77oi7vb
 hSYN3sbcutw==
X-Gm-Gg: AZuq6aIKh+gcTw9OlU4vH64vyIlxMpsoVh69S3W7fr0olT9ck1b+BTslBSw9CaZNumS
 Emhbdd0Ru9BBw/kzx+lF87AEMnI+evVXSXjd+Ra1FEhICbNw+AYplAVE5JB6CZ6x/n/ffY++67E
 O0DFeR2ei+Ge0U6k1WRwo69h0+BixJmo4PAykvnrByadglydj4YWV7jd6VFrzSSXWgcfQA8rkKt
 IO478It7UypWDIyx/5Updqx4PLTG5QHYFOcGT+WZhmikO7LnQJVXUX5w1n9g3xZT5hMWHi8anw/
 I54CxGwQ6Bdw11LbJMIn1GZf37jgd2u7TzIz2ZpR7/ILSah4NshBi0Thjh/5p5LEMVu5aDvD0rn
 TnOd3YfLglLrYMxGxdXNfchb7tknq6sU+o6oxdFDivesy8Co/IH/Jh+CfRpOUrqLNrKPSAIqiXJ
 X4WKp4pzM+G3SbZa2a3mNM15mm3AByyQ==
X-Received: by 2002:a05:6a21:a48:b0:350:55e0:5522 with SMTP id
 adf61e73a8af0-38e9f1cdfd4mr5487766637.37.1769467959759; 
 Mon, 26 Jan 2026 14:52:39 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c635a424cf9sm8869276a12.28.2026.01.26.14.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 14:52:39 -0800 (PST)
Message-ID: <b3ea321a-6c58-4ceb-8e3e-04384af34955@linaro.org>
Date: Tue, 27 Jan 2026 09:52:35 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260126092212.503162-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126092212.503162-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/26/26 20:22, Cédric Le Goater wrote:
> The following changes since commit fea2d7a784fc3627a8aa72875f51fe7634b04b81:
> 
>    Merge tag 'linux-user-for-v11-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-01-24 21:31:17 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20260126
> 
> for you to fetch changes up to 4c5e5d66f991599bd34a65fc243d3c513e6b1e81:
> 
>    vfio-user: update VFIOProxy flag constants to use the BIT() macro (2026-01-26 08:30:04 +0100)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fixes for vfio-user and CPR
> * Fixes issues detected by Coverity
> * Updates linux-headers to Linux v6.19-rc1
> * Adds support for the creation of dma-buf objects for PCI BARs. This
>    allows safe P2P DMA operations when using iommufd host backend.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

