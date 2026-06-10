Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD55CD8CAD
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX6e9-0004L9-4J; Tue, 09 Jun 2026 20:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6e6-0004Ke-Su
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:18:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6e5-0007G7-BJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:18:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so41335755ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781050691; x=1781655491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KgyRmT6XiT2z2kerw8LLABkwWb8/4HFcILLuqJsOx4M=;
 b=o4P9ms+ksTc3lSw8nzHSXG+qXiikuMsCnNRzVND70Y/SHoTmLGLfTdLUZjoo9u5b72
 wAtt0pbDb1wsywDd27s3CvmGaDp6w4q+WSYSvpsI74Y4S7Xo6LY1CNo70+OCctQ21aIo
 IQloYpDbOpLU7TIZU2Bt/MDKHYBVo7PfOdae+q3AlNG4UW+c2bHF6XjnwO0iYN4sk5/0
 1Sdu8LBAr5+RFXQnnYutojT/ZJlJGJn5DY2+CeXnbpJMtpBW0+/9plPmtN2vep9Rf94n
 8sv2Szs3++Fl9DrYaXhQYk6jJ9PLkXE0hMFhm+YuTtO+ojx/xJQ2vBWOqtOWfwz7TaTv
 VGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781050691; x=1781655491;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgyRmT6XiT2z2kerw8LLABkwWb8/4HFcILLuqJsOx4M=;
 b=q4t9R59tOjMGNxe7vcGZuExmaxNedNMwg7R5cdoVc7At0wHiZ5NHih8UUQMC+SFo8J
 v74Cvrr6zrTROEvlx42ab2d81p35QsotzLGHfMiYgVsHhvWJXYIarHa64qyh0TAJN/LT
 YenYoCO2AFmGZkw9uxEvZv65vEnDx7Lk56GiRViuLaE9QBt5ALyyFtng0h7nhVahr1xB
 97li4GrfCRDWnnlguTA7nfwBHGJsFp6wLQZ5OEf7+GESFZWVAVvk3MJ+Lh34Egh5hPKq
 itdriOm0P5vLsemZpBfQv+3rPFj61Hq6i4iGiAa1N0kAGBp8iXc0CpAotC92pWi6zs05
 cFrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hA+H7H/wBwqNLv1mZwkpsv8M/ICh4m+/BPKcgDM+pzidNGacXkurgxeSujGRPX27lMbUB5f+Lxi17@nongnu.org
X-Gm-Message-State: AOJu0Ywiu4DySedOWiLBUChey/tM/pUDKWgUMwVO9HUQ7h7oCuCOuKxw
 8EN54gbb87LlSkQKet3KS1aknKdwoDurZMyEIwUXHSSbl/WeZkS7SefFqqkbFwn13SQ=
X-Gm-Gg: Acq92OG+qqY5A8ACA4cUgaHlpUy1/39a3L/fyHnu8yQj6O9ky41bLRh7ludTnghmVT4
 TtQhse3DV87HfOdwzGQWKKx2jY1iJt0BuhmmQzOCUJvlPPqv6XvIZCybTjwZvTTXcZJ5xTyO6Ik
 F9+qLDrunY6DBUFx4pfNQYNptG3oLXCVcDPvUS8xUNQqXVK1/QjPt6XZozEXllac5EDavrHLO4A
 Ed/fU+gfb3ai3jMIoC/uSTCALUGMNEW54n52h30wjBaiksrj1wuxUmFaJPEILkN32N4POPeEIfy
 kk0Qmtboj+rBldIZUQIUd+AVgTDHVKFALnMOYETiM5R8RZBhlN8kI4a1vJS1+/SiCeiW74zYtQ9
 5Wwmfrw5qX/840qbXltKZj/9kIKni7R0xzUC3ytgFB3uN3XDsuJHt8mghH8dAMYqHWxii60x3Dx
 4MULEbGxu8kPUl7slUDt+pUL7EaM4PVy0hh+3FyLjMmMH/gwk=
X-Received: by 2002:a17:903:a46:b0:2c0:c37d:dfc1 with SMTP id
 d9443c01a7336-2c1e820e316mr172532735ad.34.1781050691446; 
 Tue, 09 Jun 2026 17:18:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c166396fa9sm226229245ad.66.2026.06.09.17.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 17:18:10 -0700 (PDT)
Message-ID: <3d519b95-595a-4a5e-97cb-6116eb577e09@linaro.org>
Date: Tue, 9 Jun 2026 17:18:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] tests/tcg/aarch64: add user tests
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-22-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609214745.772536-22-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 6/9/26 14:47, Pierrick Bouvier wrote:
> +++ b/tests/tcg/aarch64/meson.build
> @@ -0,0 +1,213 @@
> +cc = find_program('aarch64-linux-gnu-gcc', required : false)
> +
> +if not cc.found()
> +  subdir_done()
> +endif

The primary thing we lose here is the ability to use containers for the cross-compile.

We detect cross-compilers in configure.  We currently write them to 
build/tests/tcg/${target}/config-target.mak.  It's not very meson to parse a file like 
that, but I imagine we could use scripts or meson variables somehow.


r~

