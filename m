Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A88C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQQX-0005BZ-7A; Mon, 27 Jan 2025 09:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcQQB-0004yt-7F
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:49:04 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcQQ9-000738-Oe
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:49:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso29471945e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989339; x=1738594139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ceWUtx5mop+7o7DhXRcs+WHayWugqRN39zY3y/WGXKQ=;
 b=SVO5dJHwxL+W2dP+gFgNJduI1whMbiTjQ4oSNtbMcnnTZyR+06DVAUOgwCOPaegJiB
 lGgV/ddJOfeynRC69IakfXw7Il03gbPDK5S+Mf02JD1toN2xl/Ri6k9mYUZUiqIiUmrY
 Y9prwofg61UMTh9BxuyKof2JxssItrw6V76P9JOMByY8QIZCG9dFS8c00/s51LowHjGo
 qHg9Hj5m/L7/aZW5Kan+kT/dDlmGMn+r6guZoO+5iKApGDb/VtmVcwBXmGL0eKyCH7me
 7mjjJGaYjjgXy/lFDnWUtv1oUSVgrLAucZS1wSv2yZ3ndTKdgAhGolM79wT0ejj9rv1P
 LGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989339; x=1738594139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ceWUtx5mop+7o7DhXRcs+WHayWugqRN39zY3y/WGXKQ=;
 b=hso+AEXcXvnlw/Em3mTtTvyjYCZv/lYFE7FGSBdteiagsQp48a2F5OZOJrKA7b0e7P
 AGycbe4jkiQ9NQY2PvMqtNVijY8q4PaxN5zrgYqSXa4viN3le9G8Z9Fioc9jv3Bw8xq9
 xMqtPtKmO79nrBnF6zMFkzAy6w//vtGSzAtswZqtFxOCbAzWZHFFHOJfeKYw1au3NFk+
 VhyYjJEsgtx9VWk0FwAeEeYLk+xWEa+v78/vNrFsxJ+9mX/YSCv+QBvG3Nmzb9xI+kqS
 NLXNaqgOOHuExirgYKxc302UeerBO4LzDOiR2rHsOI8Q1gvVlsuFV+C/jBBwjG0jK4hz
 t0sg==
X-Gm-Message-State: AOJu0YziyZ75d8i+VMZCuZKXA+nbeS7EyWjKUjEiG87ad7+1VeqXaIRS
 YOoTK1VkWMIT7fcvXgZDdnA1BEhe5p/z2rb35qhhOK2qPO8AFJUgrHJJoOLVMDg=
X-Gm-Gg: ASbGncszzrogia52fgm1RQwtvHQ2k/QhIYjVudHAYJdaTrLHn48tobUO3l422MemW/D
 elFCx8qYM9snKdNgBwBkHgm0c6b36ycR+7UVtVPd5fRqe22koANBVi42aONYh6eXBZWbsLd2uyq
 ysdo67aH/A7UMYKAEKRAyxq8TbVTh2Y7kk/sEWO3nKtnPgyEyIuI900Zoqjzbtx+NLfjWZvrzfx
 Z9i5Td4NdaOr8EbBUn3m3KYKDAJl2UiguJb4yxiRD4hyoAOroyC5VqsZ5DMTDUHcGRCpV0XAk3w
 7GXnzXfwUliOyYJVaulTSoEnCVZFb5r6CUPWKgHeYnJwGaaT
X-Google-Smtp-Source: AGHT+IG1ulsgpZyZe+UyL2d4Cm4qf3xGgVisrpW7kFbnSRSRL7lJdjoBEVyJe3JPzwiAmQeafGMQfQ==
X-Received: by 2002:a05:6000:2ce:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-38bf565f06bmr35402074f8f.19.1737989339601; 
 Mon, 27 Jan 2025 06:48:59 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188673sm11033131f8f.46.2025.01.27.06.48.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 06:48:58 -0800 (PST)
Message-ID: <d2a59e25-51f8-494d-8bd5-a1d5c50e8696@linaro.org>
Date: Mon, 27 Jan 2025 15:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/arm/stellaris: Fix overwritten IRQs and cleanups
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250110160204.74997-1-philmd@linaro.org>
 <CAFEAcA95_AcsszEwqybegfabb-bcZK0qfvF1BjmbsSReTbwvaQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA95_AcsszEwqybegfabb-bcZK0qfvF1BjmbsSReTbwvaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 27/1/25 15:31, Peter Maydell wrote:
> On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> Applied 1-6 to target-arm.next; left review comments on the others.

Thanks, could you s/http/https/ in patch #1 or should I post a patch
on top?

Regards,

Phil.

