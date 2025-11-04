Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKGH-0007UL-PV; Tue, 04 Nov 2025 11:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKFl-00077O-91
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:51:38 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKFj-0005nP-NV
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:51:28 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b70fb7b531cso378152666b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762275086; x=1762879886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLK5zPOn2Qd+fIBciZykhnynu1KprR6IZOpUKkfwkq0=;
 b=k2F4HOpc0lrBRUo/hVPYgv7Qlk4iE3OndjGYBctF/zBBjBbVlv/7+pKDWx8ikKpufp
 uL0cBQOhwL8P2RmzbH9y0SqApH3PYF9+qa9vCPGOyieP7ZVTtatqTrKxJo+vuf1OAE+T
 Ck1B2S3edQbm0JpPngjFzUQGpGX2BcmSrmJ89vFzpTlVZ7bGGHcLKJ6reOXZnUS8XwWb
 NAYmBnBrlYDf1kx+/TzfEcQVajc+J8l9LQPQ0N7IQcPjTYhTcsVvLhJPw3aalyHXcCB/
 Scp7Uhxh3wU/dEAQoVJo885AUrSChJwGoaHOfseYTXTos6I5OgyoFR+WujdZYevcfB56
 SDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275086; x=1762879886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLK5zPOn2Qd+fIBciZykhnynu1KprR6IZOpUKkfwkq0=;
 b=sJMS3pTGjVBPjVQ+sSTcNjxcWJTb1VTZ0oMSnVnpGqI9571NPMb46MU0C1wKrv6woq
 6i3zHxxJ4NZ8jBFVkIXPvW8HB3seBgC2/W2M9FV+g95I/1pCcP6QaH6dRqtfmBf94JTZ
 Py/kiULm1bOLurBBBV/ncqKuVb5Ac3T8sEHDx5VGoTYAyJFVfOFJhubdjayvISqdqEQo
 fHjZgtqOWCMolXZ/YcOUQ7i1Fqa7M+JUxga5kkO6Ltb9hOGipgRldHwj47u/dX+eovWh
 qDimtm+TzZ9eZx4Uix60NZ/cVpjhm9qWOCCA/nlUBH5dm+N7ocw+bMJqfpPvt8aRcV/C
 i+zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+A6hfzP3sSUH1AjG6dqseC0hvJlJOeZ12xrE5d6b8kBlXB0H6/oVhnEVginvy5nbyfh3OyTNG0Hbj@nongnu.org
X-Gm-Message-State: AOJu0YxIOFMioF4dHQ7y9Yts1gBWrMJWTqjcKoBGjRtqICTPIQHYOmWb
 G2D/77Rw4DuipydcunGsANpyi41d/AtojoI4PnjgjStK/fh0/AZDocM7YqTkmtOD3wg=
X-Gm-Gg: ASbGnctZH4b8tCK/IvwnsN7knPNjCWcZ9NO9VsUhWuuqDvnWokhguv0ZSDV7+LvHuuK
 eWH2RFJ0Iyw4w5yGn3pByfT9PVqU3u+14+gGSg0a31myqOqWa1yZDSUbiRNyshNKimhw21cVlXf
 tZQD0IHzZ8PvgXboCsKhEbI1h/SxeMUNGRCsbVJYQaiK1FGh4MdT/xR/h4DgGXqy27yqdBvAcSF
 3dTXWVu+tPIe1namHSKITEdb/JxWde+gb1zdsgY3gamPCywmKNi7Gh5rzFy2BdQcVegv1MiPEl1
 QFC9JbVBkUEEyaUZOBSsIYuTG7Az/riwUMVS+AZzV7WDclc6gl21dMWln+6AqWf4Sl5ZEXzhSei
 A5QVX82jjrN4MZUFM/xe5LMHo9bpxLNvDgOzHN1u/hitPKmy7yt13S/vC8TW6khvOEJef5imZl+
 Rsgb/SIlww8AU6LlPFAGc=
X-Google-Smtp-Source: AGHT+IG5IX7b/CwbWhY61zOyPf3DcKiVetnHaDyjOYkBdHJCOz9TLsuDs0gKsji4Wwn8/8Ot5w3r4Q==
X-Received: by 2002:a17:906:c10c:b0:b40:5752:16b7 with SMTP id
 a640c23a62f3a-b707063e279mr1861244666b.51.1762275086055; 
 Tue, 04 Nov 2025 08:51:26 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723da0e6acsm258341566b.29.2025.11.04.08.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:51:25 -0800 (PST)
Message-ID: <7d7bc82d-5d99-4499-95ec-f21f60b52ddd@linaro.org>
Date: Tue, 4 Nov 2025 17:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] cxl: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251104160943.751997-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 4/11/25 17:09, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git cxl hw/cxl hw/mem
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 2 +-
>   hw/mem/cxl_type3.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


