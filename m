Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C843CC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 19:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfOLc-0003Z5-KB; Tue, 04 Feb 2025 14:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfOLY-0003SV-M4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 14:12:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfOLW-0007yW-43
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 14:12:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4368a293339so68888785e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738696348; x=1739301148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uhHhvRU/BGikXKHNsjTq2q46NE2D8U8FefZtc09pRc=;
 b=U7LT57lSksdBrCNlZFKXvk/oImbV90v4kwQR9KBGLMqn5L02aUbBSQzbUhr+v4L5qD
 gWjO3M8WYjMJjOdC45D5S80DlWAuTIwgJc1O3gj+VChOznAxcvn9NXXukTPsIFVzXvbF
 K0Fz2PTE+MQQUWHRciNKH16To25grZaineCUqsXl3NPnpeaYcz+XxdUV6lH4vnxm6xTt
 dE61Omf4txeIU48K82fePe4Yq/baRWu8lSz+KMPXdoCoesQsp+QOe5fLQo+X+v6tx3Ga
 nKyYjfTHPCUUVc5btKBNyGVKZxkCHlwYk12xihhbwSwt8phzbdK254/zmWAeLyPjVr5Z
 6+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738696348; x=1739301148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1uhHhvRU/BGikXKHNsjTq2q46NE2D8U8FefZtc09pRc=;
 b=pU+sN9TzuvNWCPIkVAgBruaOSZb5gn6eOjupq7x07lWXRluogBYyr2B8DcASgBRDXm
 x+NiGgPn2y4NjPfH96a4wtNJbo0u4FMBmgaH1aRCuM+dEvpooZrwIVxTR3dh/0Sbwlvx
 Sobnqwml+j8nIYRYZZyHWb9VxGqAPzsMqnLcNn9PA/NnNBg7PtKbMgjUKpC9R63eOBfu
 t5xGgfdfi+7roD0W4Mjh9aSHYhGZ5MKnE5+Rz1XhoCba0LP3Ve1CDJNzKVZx+J67swvx
 MkF5JomN1YMudCuyRM29JkUJUXK5i7MTUmcTfmWG8Bpu5IN5Nnf7AL3YLzTbOLqUha/T
 5asw==
X-Gm-Message-State: AOJu0YyKRXFWKhPu+4QRLJc9E/lrf9Im+ooqz3BjQ50ruTyGzeuAibKp
 Qh11x2h1f86dmm4lBhg7xFjRXGaOpic3x9Gn8ZlDfB7yJoo2VnLz5cQolCHJEG8/gqzAPruK24b
 j/c8=
X-Gm-Gg: ASbGncuLg4aBc+sYlGseYUqi0ZhZtck/vlJ00AsKl7+tkhJcFkpfF4qU+n6a5nVYICn
 sm6Q/XiEY4SFy63RRHQQGYkt4TtIUmaFqk91BD+9sC66Zykk/+rQCPDejsTbhwLrrN88C/GdjQX
 bTurusLfEDksthv3q3tD/pRV2RytRpteJTBH0BFZDaN95eW2hneUm9TeRYavP53KGQr0VPjqpqm
 uEMcKisg7jwN258SblgQ4y0PQI6Vg1G/kMnqVqqgFeFpB989Kr25DhT9g+qeP6LdEXIh6ENlIeV
 er81VRW1k06FmBoiidTk19MatjzMM7vTPFXPCUlW4Z1UbJllcetXKtGeP1k=
X-Google-Smtp-Source: AGHT+IE4Yj47EUyCHLt5Q1kF54DsHrXlF76hFpyWiqdPCpLwBMfZpVOKCt58+zzfXvmaWMzQbkn5Lg==
X-Received: by 2002:a05:600c:3488:b0:436:ed38:5c85 with SMTP id
 5b1f17b1804b1-438dc3cbc24mr258085405e9.14.1738696348146; 
 Tue, 04 Feb 2025 11:12:28 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6dfb5sm240172815e9.31.2025.02.04.11.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 11:12:27 -0800 (PST)
Message-ID: <075834df-6e81-43f8-81e0-2b2df5b9a828@linaro.org>
Date: Tue, 4 Feb 2025 20:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] hw/arm: Remove all invalid uses of
 auto_create_sdcard=true
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20250204182903.59200-1-philmd@linaro.org>
 <20250204182903.59200-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204182903.59200-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/2/25 19:29, Philippe Mathieu-Daudé wrote:
> MachineClass::auto_create_sdcard is only useful to automatically
> create a SD card, attach a IF_SD block drive to it and plug the
> card onto a SD bus. None of the ARM machines modified by this
> commit try to use the IF_SD interface.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed.c            | 21 ---------------------
>   hw/arm/b-l475e-iot01a.c    |  1 -
>   hw/arm/bananapi_m2u.c      |  1 -
>   hw/arm/collie.c            |  1 -
>   hw/arm/digic_boards.c      |  1 -
>   hw/arm/exynos4_boards.c    |  2 --
>   hw/arm/fby35.c             |  1 -
>   hw/arm/highbank.c          |  2 --
>   hw/arm/imx25_pdk.c         |  1 -
>   hw/arm/kzm.c               |  1 -
>   hw/arm/mcimx6ul-evk.c      |  1 -
>   hw/arm/mcimx7d-sabre.c     |  3 ++-
>   hw/arm/microbit.c          |  1 -
>   hw/arm/mps2-tz.c           |  4 ----
>   hw/arm/mps2.c              |  4 ----
>   hw/arm/mps3r.c             |  1 -
>   hw/arm/msf2-som.c          |  1 -
>   hw/arm/musca.c             |  2 --
>   hw/arm/musicpal.c          |  1 -
>   hw/arm/netduino2.c         |  1 -
>   hw/arm/netduinoplus2.c     |  1 -
>   hw/arm/olimex-stm32-h405.c |  1 -
>   hw/arm/raspi.c             |  5 -----
>   hw/arm/raspi4b.c           |  1 -
>   hw/arm/sabrelite.c         |  1 -
>   hw/arm/sbsa-ref.c          |  1 -
>   hw/arm/stellaris.c         |  1 -
>   hw/arm/stm32vldiscovery.c  |  1 -
>   hw/arm/versatilepb.c       |  2 --
>   hw/arm/virt.c              |  1 -
>   hw/arm/xen-pvh.c           |  1 -
>   hw/arm/xlnx-versal-virt.c  |  1 -
>   hw/arm/xlnx-zcu102.c       |  1 -
>   33 files changed, 2 insertions(+), 67 deletions(-)

As Thomas noted in v2, this patch isn't correct.

