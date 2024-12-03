Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCBAE64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR3Y-0007XP-L9; Tue, 03 Dec 2024 06:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR3W-0007X1-Qk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:27:02 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR3U-0008OI-Uv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:27:02 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53dde5262fdso6221365e87.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225219; x=1733830019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wUjoYVidgDMXvSJZyoW5eEVXVvcgS9gqwDzCapZSYnY=;
 b=H/YqBd3dZKAHtfcpzVPt5Nw/7AqDJiY3yLPBk/C5t/BbdZd2jXEMDrpounK20lpgIg
 +hzNh9hf/a7DeH4f1jn0/qmiIlH4lhcK6X2A9OqVHWueXQt7kXYfEzPiFAh9jQXyeQxj
 WV+MnVUukSVGbBOVNHlM7Hs/BU0csX/6QhpRm5CdGi9rysv22fgDiFsb3HS9oANX/CQE
 VQ0zICeJoBFkjqM5/IApSsAYCZm4NTPtcJtCF3zJhpCWm0jnVKvVsBsRW8jbFgptKZC1
 +YQ1zwX+UmSpG5u+X0Znrf3vvdPNY6/cx01NHHIGXy7eLsnsyl4+XHQoap4JnnDpin8T
 DV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225219; x=1733830019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wUjoYVidgDMXvSJZyoW5eEVXVvcgS9gqwDzCapZSYnY=;
 b=WayPWddKThHJH59u/e24CBlW42Khomwp/tMw3ORYNfEhcAuHEP5jdSIwoaDGYWsZbO
 qpErhD1a1CcS53Qslm98Yf0m1JFVcBJQJK6/yyDCJxlhHrfzC4KjW9h0/ZHG2FnNDElC
 sise+ZWS70cKl5xKgf5NxM3Q8I/B6/wXIj3fgyjvdzj/CTxdhXtGQIoPBxHj8tJxN2v9
 2xyJ6idyQmQIWNWfacG1XvFc14GqucNiK8gVJpNlYQ9cqC8fvobk1uCbAylKwDu90WnO
 By3yn7qVpntKzcHKDS5q0hdCu0VoCTwSOv/ki8Cg3pUtcEjbSHLCMGrlBBulJrpCcYrf
 ZfnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA0zGLkoj6yMp3yTNZFQQtaYiDX7C0xmYem76W/OQGg9RlGWTLPxwyZH5shWL+y2Yj+RpWH0CG80+L@nongnu.org
X-Gm-Message-State: AOJu0YxNi6uVHR3/k/Pp4WnUodOqAOqvIvJBgt9KRxiCMpQhi7PS5ure
 GVogwA1+2Y13MKs6IAotDlsUdQqYIx6vlNrRvBBucepQrvDdpQs78OXp1xW83P4=
X-Gm-Gg: ASbGncuf5Jt7qVGsYSriV9z7dih/oYGVrl6YPDdDLTayqw01FifMbRsh/neketzvAJG
 oqnPnVHbshpgEkSUW3OeOiT4Rla6u19rVqtr93UurFXQcLzeEQpovOFf1xq3yzR7+ZBmP9dQWMq
 vTTiWjPMZNacrBpOsSwgee5yV+USWtRmXGgv8F0vKlMaCfdEC0R0t/w2o/y7vSraJ7pL9s4H5k9
 Idhyxr+yw7jNlfVtaVawuCR4izgzJbARyfvH+kEmVzXE/TQXFwV2cC1ogvZo3HSnA==
X-Google-Smtp-Source: AGHT+IGpfk8yLy/UxPXT2yneVIsc3gOiyRhB1rRId5KjNZolaRzVnXtOHgBCnKi5UjMnm6yGyhlskA==
X-Received: by 2002:a05:6512:12cd:b0:53d:e5b0:1709 with SMTP id
 2adb3069b0e04-53e12a22fc1mr1361361e87.38.1733225218739; 
 Tue, 03 Dec 2024 03:26:58 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm12926410f8f.1.2024.12.03.03.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 03:26:58 -0800 (PST)
Message-ID: <57005744-a8af-4652-9e35-1851c399c9c3@linaro.org>
Date: Tue, 3 Dec 2024 12:26:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] OpenRISC fixes for 9.2.0
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20241203110536.402131-1-shorne@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203110536.402131-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 3/12/24 12:05, Stafford Horne wrote:
> This series has 2 fixes for OpenRISC that came in over that past few months.

> Ahmad Fatoum (1):
>    hw/openrisc/openrisc_sim: keep serial@90000000 as default
> 
> Joel Holdsworth (1):
>    hw/openrisc: Fixed undercounting of TTCR in continuous mode

Thanks, series queued.

