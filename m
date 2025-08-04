Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DA6C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqiM-0003Ry-W8; Mon, 04 Aug 2025 04:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqiH-0003On-89
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:38:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqiD-0001Px-Ab
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:38:32 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso9751295e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296707; x=1754901507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UTPdy7RE9p1dL3WSLFGiCNi/FE+9/65cL2ijfj0r+TE=;
 b=OP+eksjDPie+oQ/geFiG8qPHzCiCy5aZztoNxN5EbIh8q+7lr75gs7ejIEMRseTJ4I
 iMt78L8Rc8YzntfYga3AuRsLFvKgKB4ct0nTBSegDisJEQMrY5SkLePiKfsXeF1hdZgo
 p4m/EpuSDWusiOVP7tUqn/FMi142kgdwliM1d1yULTyBBvdanrUiqeyFWldmoMoTWtyb
 Qo+pPpPE93p+AR5XTq9DL85WIe+9NGtp3znJNDKqvWREWEkdWJeHdVFc9TBDPNQZyrYS
 SQbFcW2ZChS5Lo5JGNPtN65v6cg1dAuQniUc/S2k8Y8M7iiemi84IkcmdQJcoNzaNZFQ
 c51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296707; x=1754901507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UTPdy7RE9p1dL3WSLFGiCNi/FE+9/65cL2ijfj0r+TE=;
 b=FCLxZyoSOups9zxI0Zk+xtczTaXZrLLxl1Sk6v9iCNlAb8Apm4b5eJdc5YtDLabN2M
 3CdhMAmam60spdInZPn50AA+1G52BU3PhUxFfkPQo8NcjRTei5fSza48mBm1zreEp+jv
 pGbBrq0rxqUYmb7R1TH6YUTZ9yTgflXslDYjFFc2yJNYs0qcru/44BizsXUWIS9AqGMq
 tFh/D4sfWgnVDbtZzcWWwUi6FCh+iplIoqNZNtimpWMT6ikac6D3jxTfGYYMLK14cOMA
 FHkUC6K76Fpx4VF6AUCmewhh70pDEbTm8O6zbfx9tqAOEO9Y4WkVxtqXKpY2IDQwsrXC
 V44A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2FjLBu/MjHjwZA8PAKrOgNFiBQn5XzBwdQU9QmSc+Zh8s9eAUcttbq2GTVhGUcqOK+QT6ZCJM01cc@nongnu.org
X-Gm-Message-State: AOJu0Yx+RkUzPxpjWyCkNeeO3XKLZkS866tx0/hWdacmhvBKIVsicB7G
 HK4biOirZSzqBaB/1uIp8zYjkdWBAiQAJbqS7TLY1oUf7HFlx2oP6wS86/DQ/a5GoNnW2C3DBQW
 tXumK
X-Gm-Gg: ASbGncuxES96vbVwK2YUhgK+UxtDvLejiKq2xPqy+o5CNtMwx8aLWyYTvo04QMoaEz6
 vIaNp7QV3XRlUxZ+v5wunmpKdNnmUoh9Btnfu2HrRQ1WxuzIErqUIJ2lVTKTtL/IU+XQkCDcw1S
 A6cBChHARNtCedL601z/DD/Jw0WFmIaF1CPUZsd4pBd50m96ZwhQkb093sj0+ND03eDpM2DmuQa
 LKjiMOCVbXwkWuwPfoLiMZwGNef0Dc+kkySIUIN5DZrp9+sV0kfa+6GqqZ4tduS/sV1WmWEN0dp
 yAOes01CQPAvveXW1jP3y3Wr8tUbiadJeAJhagdKsfX3fGv9mvJXH2MDHQbusZKbESfh0rB8wYg
 gJYU/LETZyDlB1bDqjpG8mIhmPDcjaN7oEc9zoqogCKGFKgV+gAu3Rt57P/ax576t0hNavng=
X-Google-Smtp-Source: AGHT+IHbBRPE3PFgV46zmk4kdJfJao3kRa9XMVnnjPufADL0B2PNo7+lETYsb1Lk2xcY1sUDCq3b6A==
X-Received: by 2002:a05:600c:8b41:b0:458:affe:a5c1 with SMTP id
 5b1f17b1804b1-458b69cbe0cmr66853175e9.5.1754296707512; 
 Mon, 04 Aug 2025 01:38:27 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm161264135e9.30.2025.08.04.01.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:38:27 -0700 (PDT)
Message-ID: <ab76629d-9095-4ec2-9649-09b67529e583@linaro.org>
Date: Mon, 4 Aug 2025 10:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] tests/functional: Move sparc/sparc64 tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-22-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-22-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> sparc tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  6 +++---
>   tests/functional/meson.build                  | 20 ++-----------------
>   tests/functional/sparc/meson.build            | 10 ++++++++++
>   .../test_migration.py}                        |  0
>   .../test_replay.py}                           |  0
>   .../test_sun4m.py}                            |  0
>   tests/functional/sparc64/meson.build          | 10 ++++++++++
>   .../test_migration.py}                        |  0
>   .../test_sun4u.py}                            |  0
>   .../test_tuxrun.py}                           |  0
>   10 files changed, 25 insertions(+), 21 deletions(-)
>   create mode 100644 tests/functional/sparc/meson.build
>   rename tests/functional/{test_sparc_migration.py => sparc/test_migration.py} (100%)
>   rename tests/functional/{test_sparc_replay.py => sparc/test_replay.py} (100%)
>   rename tests/functional/{test_sparc_sun4m.py => sparc/test_sun4m.py} (100%)
>   create mode 100644 tests/functional/sparc64/meson.build
>   rename tests/functional/{test_sparc64_migration.py => sparc64/test_migration.py} (100%)
>   rename tests/functional/{test_sparc64_sun4u.py => sparc64/test_sun4u.py} (100%)
>   rename tests/functional/{test_sparc64_tuxrun.py => sparc64/test_tuxrun.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


