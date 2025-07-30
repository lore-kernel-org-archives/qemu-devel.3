Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30072C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDv6-0002xb-3u; Wed, 30 Jul 2025 17:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDd2-0007rY-RY
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:42:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDcz-00008M-VW
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:42:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-240418cbb8bso1715765ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908140; x=1754512940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=go0CL4xkPoqpYmv+5T48I91u032jyfdQ/CW7yY5b8TY=;
 b=oOS5tCN32eLXQYeX+/5DpwBd0atSMvCOro/tVczxNVxZyRguoJjbNg81lUMCgLSDu3
 kq/WESfr7ykLUgBilKRGoaFbxGl19dBNTK80weCKeU+j+TspzHXFuP2CZdnoiL+O20Y+
 shg6gkHagJo5Oanfmfv+b6sC4awtb4k4mLpaX0SxakAdHdafBWl07nWQmak6lCDR3erh
 7Fv1+PzCNb93bl/GsYZDs04+vE+VLpk3fA92kfv+I4A54g7eDdthZQzAFfOCJlIpsJwz
 ue2zLOh2B+cxmL12KNfciQkzL+XDKvciSuCyHfZFob2v48yuchqjlAqK+ouXCkoAeFx+
 CY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908140; x=1754512940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=go0CL4xkPoqpYmv+5T48I91u032jyfdQ/CW7yY5b8TY=;
 b=cV5IOhnrN49aAwn+9bDWwAWXB/EEsl774FKic+nnepMAK2Y9nZYPmhnmbaqoFPIw7B
 Mia0+jAU2O5B6EM+IeUX1qY9XQzBx2Xr8Va4GS3mcNMXqj+7iomCZXd4Pk2kj6C9BvkS
 na2m1NmBVE8OYEd4tmSDZo3i7u6Gas7bpgBo9pxeha/g3HQZVl3g8SidapCug9NvH8br
 Vei/WmOO3kAaqJg+mW5TPX2jtwNQph+iU0zZ2Tg6BfX40rzX0aJ14YJ/KcZwf3Dgs+2e
 R5If9TZCJeHwUAhfl4+YUjOTAvAwKwdpAqSULlwc4Lz81d9AewI7pm2LLTrQg3SRho82
 UB6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwUR/h1i0NdYDvN5QiCh5jTVVxriNHmlbRozGsxlcgyI088PrkL/y8HO224/btCaILdW0JQwqM1sU@nongnu.org
X-Gm-Message-State: AOJu0YxuCBLkHdOw42o7A2wqcCwDARLK/gQ0XfX6AOoz9h9QrUXG/jlW
 mW63+MXCTHAKSwat2Lu5lYklIBxkzwYo0++uR/0v1IrFiK/rFTn83UVqs7AcA4RcAf8=
X-Gm-Gg: ASbGncvV8wJIQq0LJbBPL4Dcw9h8/h6lowX/93ayWEi+OhGoHkXScb4o3VkSOc1tJ4f
 ckJLwnwqM1TUetWsvGlPdu6D82sWB1xECtDx8qbnZW44+B0YCC/AltbSr+eyN5Ca4Iw5VmhaPI3
 HRgdnGhalXaiZa+qroZ67giw/PIoInQnhw9yiYmI9IYlDLs88SPGx+m8obyNxqLEmbGNavO5ofI
 5q7Qu11NN0LAvsvlS+Lka4uCPk2KSfKLOL/rL6biK3rGhRi3//uNwopyUIKFJfyspH0/6+2bc4H
 /1xchXiPCdQks/29aQYTXoHkqAdsvGQqi12ZxXi/VL14fZ7uV+2qmb5IUNyU7qQQKOJ52ahtILG
 qsg+A1QiRr5no0Nf0JdGhb5wL/oYpt9OJEAY=
X-Google-Smtp-Source: AGHT+IELl42hccrVCOeNwHTS5+IF9FmbDVP+Tb4hdkBipLa6LcdtL4Y1TSIb8pllvk8gTAY4GxZGbw==
X-Received: by 2002:a17:902:ce01:b0:240:a05:5b79 with SMTP id
 d9443c01a7336-24096b41452mr77644515ad.44.1753908140640; 
 Wed, 30 Jul 2025 13:42:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef595esm188265ad.13.2025.07.30.13.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:42:20 -0700 (PDT)
Message-ID: <6b9f8d50-2adf-4a4b-879b-79929c4ab8bd@linaro.org>
Date: Wed, 30 Jul 2025 13:42:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/82] target/arm: Force HPD for stage2 translations
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Stage2 translations do not have hierarchial permissions.
> Setting HPD means we can eliminate an extra check against
> regime_is_stage2.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c |  7 +++++--
>   target/arm/ptw.c    | 24 +++++++++++++-----------
>   2 files changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


