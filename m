Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22728C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 06:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgf7H-0003lj-EB; Wed, 21 Aug 2024 02:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgf7E-0003j8-Mv
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:46:44 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgf7B-0006cD-U3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 02:46:43 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70cb1b959a6so2433685a34.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724222800; x=1724827600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZ2+aTPGA9FvmXmggQ83QpSrFjLEMPcmmXbYkXybUH8=;
 b=XKoR5OnwGPWOLij6qv8vItscjTOOtOe4Sj9g5EVWmtEOujmVJRRiGcdfd2qgVSdhO8
 gKhQlDAIPpIj5nxew9VydG4pHY1v0m2AUL8Rp9zA8I35s/kzELQVD4EhpD1gZKPGP6XA
 UlFr8LzylEF1IyXDMqf3Ns30IUiyLbgJqiublzTg5zU7YqSvbjEiBFLdi6QOAI/ZYArF
 KaQWa3rSjPNPCYRZhpcCtTlv01PO+hlcN02s0Hych0W3nCRlil6fy1zb+MNXllMIOpOr
 Aonvdb29u2/2lYfne4Z3+wAXTm1pa+gT7FSrqxF68asrZYrD5VSSYm5oB+XIwAbkffLG
 qL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724222800; x=1724827600;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZ2+aTPGA9FvmXmggQ83QpSrFjLEMPcmmXbYkXybUH8=;
 b=DV7/U77MOUPUs20+wzPSTXNQb1JaqkQDpYgTvfZLlpbksrrZA3xMEHMKmh3Vh8iL90
 uKYFLLmXVU+xRYc8gm3VDrcUDZVFmdFEFIYArtJnGtTEiYtrwUtAMUpqYCq5agjRh5OD
 SMbwFGgyCQTMMpJZdmiK5fDBbRwM1pQdVswkp64Piu2zXZ0jNsYb1p266SKsiahFvvf5
 LSCaJXvJI8zZzFGyYnW81S7WvZDnHdFUau+VuSsf4rkb5fAhRs5xDY87XIDyPYKDvwgr
 XNtyAY+C1Q/WxJxfHjXpo1Q868a/KcZe8QlukwfO6x64GByXFxxoqeNZR/pS+KPvt2DG
 FYLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0LkzlXFFddT2faDwgsA6wK6S/Iqi3NQQ2PVUwsgBaWUMyDVqWqFAbjapIIdkKwPLc/0ZrTMSVs3bm@nongnu.org
X-Gm-Message-State: AOJu0YyKBhTJyAG6t+Ja1ZiJ9TI8Kfm4j+42oCoRN0FyHUFmdFMC89sR
 bQl8Xf4LpMN8gPxQpFeI+WOEjK2RT7F1C4u/1abJSNpmRPquOAyeW/rgjnd+pcDg8eNACTzJewl
 +luo=
X-Google-Smtp-Source: AGHT+IGr4p24+WxQ1t8HovcBrhqGbf7L08G1skMcIMYne6DN3Kpmz6N9pHmVGi4l2aEjIthgshMG3Q==
X-Received: by 2002:a05:6830:6b0b:b0:709:4e4f:931a with SMTP id
 46e09a7af769-70df887c4ecmr1624424a34.22.1724222799793; 
 Tue, 20 Aug 2024 23:46:39 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7fdc:73f7:8bc4:7fda?
 (2403-580a-f89b-0-7fdc-73f7-8bc4-7fda.ip6.aussiebb.net.
 [2403:580a:f89b:0:7fdc:73f7:8bc4:7fda])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71426fdfcbesm438801b3a.76.2024.08.20.23.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 23:46:39 -0700 (PDT)
Message-ID: <fac0cc02-060b-47ff-86fb-56f8390b509d@linaro.org>
Date: Wed, 21 Aug 2024 16:46:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] LoongArch: Fix for 9.1
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240821024739.3024705-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240821024739.3024705-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/21/24 12:47, Song Gao wrote:
> The following changes since commit 4220ebde107c44412755d593fb46e168eeaed936:
> 
>    Merge tag 'migration-20240820-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2024-08-21 08:46:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240821
> 
> for you to fetch changes up to d4f5e5af86d2e28edb578e556b307e3ad01ebf08:
> 
>    hw/loongarch: Fix length for lowram in ACPI SRAT (2024-08-21 11:01:09 +0800)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

