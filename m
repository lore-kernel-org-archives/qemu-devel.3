Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086EDC04FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNcz-0007kL-Bn; Mon, 15 Apr 2024 10:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNcy-0007cp-0y
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:48:12 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNct-0001If-3I
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:48:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso3196423f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192485; x=1713797285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I14xZoOhCN/d2QEm8WMQE3AhL3lOziHCxQO2yF5PK+4=;
 b=qsLk+BFAB6dldEW4UlYGPtkqYQQtm9AAe/jW4u/1ZqOA7IX+Jzm7ELKExsNSn4qWMm
 w4WT8NJWT9uio15NbRSmsg+qM9XEPjnZE7pDrXjPVd3SHGEyDgubkp5bzRQM+v+O33mI
 0dY1XX06zG0gcgkp+BE/bxyPSV/d13p5RZE2OgEd6zbqoLkMKpEcUfusvjxlfbRleXFs
 j/dQgCBLLNjJF2eXAPBiPMrmAKkH9treXBBG1Qy0yzJoPWW77acRDF9XEXBgUQo0993j
 R6WQ/qBaqYjsr7rKgkAIjBnT3R77+Os4/LFPczk9VbINwHznF6OL+/FsbxGlRLkJu7um
 ehLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192485; x=1713797285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I14xZoOhCN/d2QEm8WMQE3AhL3lOziHCxQO2yF5PK+4=;
 b=F3o4+Utx8EnkmJbDrusolBKlELQ2wshq6T9iArZjLuzFh4GTfDA5qzQeYn+vgNFf93
 6LsP2kWZGjSeLjaXoEqUFPVOjcQ6luZczNxIJwLhmZ+CTtl8LOgKUYiwmqr6Am/fzdJk
 XqqYTj/sIRPP/VycAJC1A2c6UR9wA5asRYewZc8JesDW3HHALXomWRwS5mCo8oPEOwCt
 iOhTf/GWBYPtLYq/ktK7f0F28ZuFXT7nQQbatUzS5TXyOF9MIJ4pnbfUo42/XOqt4J+I
 D+8k8upv3biCkjYfvhTu8turf2gkoyljfAcKapfQr6j+uhfNhgwRh1bYbbhZDhR2bh1h
 iOYw==
X-Gm-Message-State: AOJu0Yz9obZoOayybtkPyOd/Z+4D8CWvjSd2xNTuTLMcAJJNxzXnChss
 eJMN4efBjneOk/ALe0PRJ1mqJMAGGYB1yWqaDewasKtwyiH8pjuCjdJe0+UkNos7HS/xA7iRP3Z
 8
X-Google-Smtp-Source: AGHT+IFJ/xTgjF//TOAd8lkq3/CBPSjzJNJsVBVwQAxGTbEX1BAA5d9nXAyhY50luzOojyYA25OulQ==
X-Received: by 2002:adf:f84a:0:b0:347:ec04:6ac5 with SMTP id
 d10-20020adff84a000000b00347ec046ac5mr1636743wrq.6.1713192484806; 
 Mon, 15 Apr 2024 07:48:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a5d6807000000b0034354a99d43sm12311494wru.43.2024.04.15.07.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:48:04 -0700 (PDT)
Message-ID: <22b139b8-0376-4021-9129-5fd18951af9e@linaro.org>
Date: Mon, 15 Apr 2024 16:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/applesmc: Simplify DeviceReset handler
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20240410180819.92332-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240410180819.92332-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/4/24 20:08, Philippe Mathieu-Daudé wrote:
> Have applesmc_find_key() return a const pointer.
> Since the returned buffers are not modified in
> applesmc_io_data_write(), it is pointless to
> delete and re-add the keys in the DeviceReset
> handler. Add them once in DeviceRealize, and
> discard them in the DeviceUnrealize handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> As discussed in
> https://lore.kernel.org/qemu-devel/6fbcf565-f12c-4196-b6c8-559843c7a78c@linaro.org/
> ---
>   hw/misc/applesmc.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)

Queued, thanks.

