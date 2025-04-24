Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A3BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qWM-0005Pi-P9; Thu, 24 Apr 2025 02:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qWJ-0005PL-Cu
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:57:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qWD-0001HD-SF
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:57:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so560325f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477827; x=1746082627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmsV/IF9CjX5n4NTaMWcGAKHEUluO/TCwQgVCRZxmw4=;
 b=BgkyGK5PciUek4VpWArLeV25V+KJAtUM37nWYwEX7h/4HSRYrNyvQjMBf8GYOtlBkV
 ubJHw/pene5cmWz6RMAlRYQP0Lvm1U7VLz5nxFKDW+4gaMJthBdSd5P1O9HPSWJo5zer
 L0jRDuCD3VgSH1K422hv18qu7+suW0/39KV5mbpqI2i1gISzOZsKGGoy574vrKQeJDtU
 xIRFxKimTKNfDZZrPqfjEsOp4rlsq8hFvOWJRmR4XRBSC+FOGPVvV1OMGNORSvpLqQgF
 aaiC7czxD2F78bRtIWsZVDPhnmF5FClnO0/H58QAdrcrJQwvhJq/VxXF+6veGUhX6HMz
 GXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477827; x=1746082627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmsV/IF9CjX5n4NTaMWcGAKHEUluO/TCwQgVCRZxmw4=;
 b=KxPiXoSY/0hhRmpZljCJw6jMxas4pwnFwFnjFZoIsYP+KybYsMaWHCFDVYLXUiXbzR
 hRdfiz5tPP5e3lC/NaM0qeYzORLWBsfKUZdQbNwOZMPNQmOSfZoZLflm2pg9H3YVXd/2
 athXD2gmInsGfu8GBROZMK7gV/JLiAMgTKApr6BlGVyEmp16MidSJbNXJ/VjWfHnT9Zr
 fMrGZWfaokEqnPGwPYdFndPlTDSzCb48rvG6vU3chjm8vdvGU1fDlP3VZLc0ABNXWGYu
 iTeB+xzg5ivv+v936/o0mPy9MpG2TmQ7giIdf18T7Enav4anOuM/i2nUD6Z+VNwIkgip
 Eq+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyag2i8F6ew+s1jjHlO4PcEw+rJoZ1KEG3t/+2E72CyIApZNvPqSLdeRJNdKk280arLLzypddY07tg@nongnu.org
X-Gm-Message-State: AOJu0YyYOtywCYvsqQ3guIsgzXHRpkzqS83dom2TkBIQg4W+duAPdFXk
 S3WA+3tpQuGpIEg1Qm5fUfb7y8GzJubmoQ4d+UshcRn2avXbUSUv+6rrfRY6QDk=
X-Gm-Gg: ASbGncuk4fFgHH8+LtfazuRBI5Xr7Ks/N3jYmqgnKThUzL2Y4iA7CgwcSrhRo/fMJhW
 l5G9sC8CKO7xwY27h52E6k7fffsTdI2FcWQkai576BXzam7S7gB/dUn0VYhPwC4B/CGCktQ01rv
 D8wUzh+Amd2Tx+4dWxtuy0FpdUxtrDTg0Wa5wbBUSxKhSqiGgwDDEv/EiVIxAQfqX7zErNFJ1VA
 oUhheNwxZIZdCy5bxhYZ+sVsfdS0PWxe3GikeTlkfvyHopoJsvqS+Y9Tv2R2AtVZVBGW1KFHPU5
 M13J0Xv0AKQTmVw8iB+gpTW+v0pC+XNmoYEgeYBvietiNNMQ5zGpAMqYBF4FYcy8cbQBq+Hxiiy
 0eWd6gqV9n9aoqg==
X-Google-Smtp-Source: AGHT+IFb1hKVmpMq7/vZUdwwEGMcIJzvyu0cIrHAt11NQrUvwObKOx7/tOErTgdd9F6e/kNHPA3WEA==
X-Received: by 2002:a5d:6488:0:b0:39f:fec:448b with SMTP id
 ffacd0b85a97d-3a06cf4f606mr942671f8f.9.1745477826799; 
 Wed, 23 Apr 2025 23:57:06 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4bc3a0sm1061388f8f.35.2025.04.23.23.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:57:06 -0700 (PDT)
Message-ID: <162bd688-b708-4373-9fbf-dd16950f859f@linaro.org>
Date: Thu, 24 Apr 2025 08:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] accel/tcg: Merge tb_invalidate_phys_range{__locked}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Merge tb_invalidate_phys_page_fast__locked into its
> only caller, tb_invalidate_phys_range_fast.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 36 +++++++++++-------------------------
>   1 file changed, 11 insertions(+), 25 deletions(-)

Clearer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


