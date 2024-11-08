Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574E0D5C0CF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Q4S-0007nK-5V; Fri, 08 Nov 2024 09:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Q4O-0007mw-OF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:34:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9Q4M-0003An-G2
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:34:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so20369445e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731076475; x=1731681275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ywvmif2CfhKLEiSr6eR3b+OMXKkCCkLWV/IN5bY7Ii8=;
 b=AKl4/E4RvmhQ0Is/I6hTKlTAxLs9fxQcI/fnRlzlEKMVqsKKekrlIZZ58UlCQXyOwB
 b+6IOPV9oD3KHBhSvMKVHUjNBhdzTNCM11VPgZ0f1CcdqDXvDAsJB5lN85LW5Q+STqJ3
 5cYKfODBrn3anHG2B2Lnw9fXrdbabA+0bE/H4iUH8gRRcn66x/COlMBjEeDkhZr4Gi5I
 8MY8qRLiRVzT2jnFG3yBzQMHCn04N2VRJmYmGFmcikT8EBQZ7qIdPj0AWmiH+XnYb+Yw
 XsRijx2UycaJy5XbsPklgs59c+c9hUjGDs0wD0j0sN7WeIWAuaB6nR322GNBDO+QNJi6
 dx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731076475; x=1731681275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ywvmif2CfhKLEiSr6eR3b+OMXKkCCkLWV/IN5bY7Ii8=;
 b=NGCIV4O7SbRzJENOmAizA/LgLbtYpBcoOkTNcQi72vtdKC/xvV4Xu9omhWYWHK5J8l
 Bq0I+6ZMHYHdCMl3+MUOwH2XK+2O46n7Vbk9drtq5oYWQsvNy5rLGhWklUQAmZYo5BzT
 AMBZDRoUBgHi6hTMw4ghwyRMaRsOmLqZqKPb69KZ/OS+D1VXnDyZDjbhFqav2DEMBA91
 U8BeNIbCJBWH9LtTegRKI25yQ8SZ5yo878VcUiqzEndFb5l2BHG0IJl6ccxf5ezCmchr
 BktWwOl1jAfC3ZzCDyEVyIs19vJM06qrjTL7YP1PqqNdL52dcycFXD48hGYXWU++b9ed
 3EUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwxt8xwlykx9DDNyn43/WTMXtSnCVeiH8MQ2RqU247Nrb5tiGj+hCgasRQu/WHWOrW+7Uj3KrNvHe1@nongnu.org
X-Gm-Message-State: AOJu0Yy0oh4e9xkn4xS8aaezGh6xE9lChtv0ocOSvXajqug6CtUcbrRb
 PhyivwksoWF/ckZNtxkxEgefxXFLyJBx9Y6GffH6GUaReMRq7/55MiqMsiGgN3w=
X-Google-Smtp-Source: AGHT+IFxGMuLeFpM328P1rIaSd5LQYutdtnfIEOujF299wXe1K7LXyKGzUJmGQA9NhTqTf4n9rkRCg==
X-Received: by 2002:a05:600c:46c4:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-432b7501c6bmr26959225e9.12.1731076475614; 
 Fri, 08 Nov 2024 06:34:35 -0800 (PST)
Received: from [172.16.22.241] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c1298sm105790735e9.24.2024.11.08.06.34.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 06:34:35 -0800 (PST)
Message-ID: <d4dc42a2-3959-4758-a7de-611f379d1413@linaro.org>
Date: Fri, 8 Nov 2024 14:34:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/igd: fix calculation of graphics stolen memory
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241108124904.93201-1-corvin.koehne@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108124904.93201-1-corvin.koehne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/11/24 12:49, Corvin Köhne wrote:
> From: Corvin Köhne <c.koehne@beckhoff.com>
> 
> When copying the calculation of the stolen memory size for Intels integrated
> graphics device of gen 9 and later from the Linux kernel [1], we missed
> subtracting 0xf0 from the graphics mode select value for values above 0xf0.
> This leads to QEMU reporting a very large size of the graphics stolen memory
> area. That's just a waste of memory. Additionally the guest firmware might be
> unable to allocate such a large buffer.
> 
> [1] https://github.com/torvalds/linux/blob/7c626ce4bae1ac14f60076d00eafe71af30450ba/arch/x86/kernel/early-quirks.c#L455-L460
> 
> Fixes: 8719224166832ff8230d7dd8599f42bd60e2eb96
> Signed-off-by: Corvin Köhne <c.koehne@beckhoff.com>
> ---
>   hw/vfio/igd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



