Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAACFC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uec85-000225-95; Wed, 23 Jul 2025 12:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uec7r-0001wW-0E
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:15:30 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uec7m-0005Op-Qu
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:15:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so13213f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753287313; x=1753892113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hvAUS/xV1zawJvjZHVI4R7iZGq/C4rpQ1LNngA3/Oms=;
 b=lTD00XWpjMR6u+YnfynAGr6ibLHHn9+g2CyoCLaTtCqsyiXBR+PVGKRrety6yGyDC7
 KNMB9eSX+2PaZRFLcoV3Pca83cY18BNCnREPJLoHHAzg36MylTWevpwXu+d2e+pwzub+
 6svU5K2cZnlovYJQJXURmIrJE4J3rjovws6pevy87+hnuJMe4tpLDsfpFNWAQs+iZdhy
 kDRqyKPej5F6p1UT7PNvlaZ66UZrHbx38/AF2w9vYfY1sTJZkjfNWa2DVn9CUgRban4E
 SDkYyLuVBM2sZlDqUzdcbNWHbG/7Mk0auMmnZI3J1rMsj+hS0xJmC1X+pytzfFdboK5K
 mZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753287313; x=1753892113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvAUS/xV1zawJvjZHVI4R7iZGq/C4rpQ1LNngA3/Oms=;
 b=L2h/jenV4kUg/uD1F7oK+xGe/hOEkYHSOAEjJp/1PJ0B/6tqavBripktI9MMbcD+6b
 QC21YvTqhMc7CgMWUOMCG4EmqqUTAUH0xh/SYXcLzKAIHsDXaTXLnGOqgdUVmIiMYo5j
 QKK9Vm+BAXj1/bXrJ8zhmvw69UMYSdrMkjeOJzYD032sMtoaBHx8zdUCyIpNL8wIua6E
 Kd7Z7RmBLwkSjlmFmsClJV0A3f5XfcZKZtei/sJj68Na2Tywfu41PJ/kvlv2eGK3LekX
 3Nmb7WG3mWYjXLLGhxzShJNLfqrXORQiC0fmZ2NJV6n4waqcgpiYT55BbjmYn1KFRGOO
 z/uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpDle6pt35CwVFK/6CrW428NfYbPzZN74TNGKCdOA/o9hYMUuzsoHPysZU0Ed2Eh3LmSM1apdgH43p@nongnu.org
X-Gm-Message-State: AOJu0YxuLa8KmkXiTlsR1p7tzKtZPG2rD19DXFZNXg0lmm0ZNs7WnhvV
 cLq0ns2VLMG7srtHYZcoSe0/rLO5G7aIOaDkWlTz4I9ZzK2HSyky8iJZnrDvzxoJe4E=
X-Gm-Gg: ASbGncuhiTOhsQgO6O0eWwJD1FlRPtFMS2KZb9cCFKPUPQpea23G6vgWILDtS+jLLK4
 zx0mt1KH2gax4bjLnDRqELvPPScXmp+m25UJkCPKozFgMi9qJob6iB2UQ/OBoxUd3cK00J8XL6S
 1wVYxwwh8W0LJGaZnHJnojvq7UJ9vu+yWY1nXZfCzIIZaomA9QSBFkmjK3tWPSIDoEYS6cUwPss
 dcsOiJCoQo1MMhM98eXmQ8hIS45tWM5UpWVoy/H3puPwXxSShRGsmaFsTrE09OHZwIEfi+9fw6g
 Lhfs4o9nNnRoZqxT4ah9HXusj35gStFTPy6SRQdFRHRl4h4V3+74hEXTb0Wev1q6s2DH53XbRWQ
 c61cbagKeIBaXkTOCcU9aiAhSDOOmiIbWEDnj9WK1SUfW1fAimU9VgLVAbxcZ0cF4Ng==
X-Google-Smtp-Source: AGHT+IE62jva8OYr7H8AsibhyyzT94bGvhpPcLIz2g5IC9EQngRLVF3IZu4PfmUAbTbLcyNdjIwEKg==
X-Received: by 2002:a05:6000:2901:b0:3a6:d255:7eda with SMTP id
 ffacd0b85a97d-3b768ef3c05mr3397965f8f.28.1753287313317; 
 Wed, 23 Jul 2025 09:15:13 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693f27ecsm26793015e9.31.2025.07.23.09.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 09:15:12 -0700 (PDT)
Message-ID: <ca62472b-c187-4100-9247-cf9d6cb73d7d@linaro.org>
Date: Wed, 23 Jul 2025 18:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: add hypervisor test for aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Burton <mburton@qti.qualcomm.com>
References: <20250721153326.783646-1-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250721153326.783646-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 21/7/25 17:33, Alex Bennée wrote:
> This is a simple test case that runs an image with kvmtool and
> kvm-unit-tests which can validate virtualisation works. This is useful
> for exercising TCG but can also be applied to any nested virt setup
> which is why it doesn't specify an accelerator.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Mark Burton <mburton@qti.qualcomm.com>
> ---
>   tests/functional/meson.build         |  1 +
>   tests/functional/test_aarch64_kvm.py | 83 ++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_kvm.py

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


