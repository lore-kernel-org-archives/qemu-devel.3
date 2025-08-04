Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B0DC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqkV-00062K-0w; Mon, 04 Aug 2025 04:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqjf-0005lr-U3
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:40:06 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqjd-0001dT-RL
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:39:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so3213961f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296796; x=1754901596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJGmf6TtoH0Yx7x1xGBQhkJ3Vnxk6XzJohDpKgXk1UI=;
 b=v/zLAYhWGYweXWzoqKIA9VRK8j5uf7PrUicyCdqRmWaz9Xm2vtZklNTH+7ZDgFdEAe
 ie8Q+dP/0yz8M8QVaxK9g35pToElQvdIdspbC0hvtmqnBiT7yXMXZk7eTW/plNk8cA6h
 FdHdk5YNsfBxrHLnflojDZLXjuqlMdQRWqYLEx12MS03CdFqDaZS15tz3z/F0J9Xjo2t
 8QaM7C/sn/AkF+Gg8curjjXDTSuw5F7k3N5y9CaaSqAAodu28vmOOQUvzFfL8lhYDNp9
 aTr5wYPtyTqclKHuDaqiUOoQ9cqLrLw1OkL7/eBu+6GF6vulgQS+EiUv8hEbo+g+bYSu
 B4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296796; x=1754901596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJGmf6TtoH0Yx7x1xGBQhkJ3Vnxk6XzJohDpKgXk1UI=;
 b=j9GF+bPLyuX9wZtKCPUpZDLvdDhPNABVeBrJ2GOdVp8VhKUwwDd7REPjQAu/tajHRK
 RPOQNVl4cWe4oQyDu32gU/VVvT5Gw2oIL1hW1xYQ4BeBcyhdZ2legyENslMc9IiP1z1P
 bCQyU4d+5Lbo5eZj7yrLMwivIkhyr2pmFsbk4SAOv/zyu8Ls91boW8aYN3QGldjJL7WA
 hoq0WKqCG0fKQzZTp+MiZEgoeiyJf6TItbfxYMq56fJaInfN5EFwFVNw6hIq9aJbPKnM
 OTwuh0HR/ATlgpzq9l28RiRSYuoZeDcOBs/ANhCGURRb6x3EgWv0XDkzNhnQODqdGS+z
 YOng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlUL/PrhkGsPRYCHCr2C07y+KDhhVhgsL7PgvtzmxqIpgQQKF3XrfpEE+NFHODMHxkcupAmDIhWjgz@nongnu.org
X-Gm-Message-State: AOJu0Yzvs9c0icHuiqSyte/4WJtzco1qllujSbpSiKLG7s2C+rTsMQZq
 VjZv2zsaB0XHS89gdBIAG7NWxIQGEBoy+4eP7H/5yoVVNKgL87Np3lf3HTxslrF9lzwsqpthhAH
 7/1L1
X-Gm-Gg: ASbGnctP5Hdb+j6gloxYoaLEc1FTvkyqWoPgoBzz+Kdjux7N0iEY1ml7QifcZzOdbca
 ytoY5Dcy5naMoLELM5fjoHVOvRBw+H4sxJr7cdyUKsTPzhW9sk4gyV/9YeLQ1EiV0O5rVgCtZ3D
 R0Pjvst3u+sz+wCuzeqKwTj61GzjXZWyydK31t+I3trZd5RrREGJuq3/EPDJwKUpp983qV6Gzqx
 Iww5+u34pUzFFMOfCbxNOXAKAqk0/gMgnJnHGhsHfLpw1Ks3sIhVPi32WRYJ02zELV1ERHIVt7A
 TcHbVyX3+6hnSQKD1cGN+EDdzY3fQdMVtooi0XZiFo3oQr0uljflzWzfT3lD29TkKM5RFoYA0DL
 f4iksTKorSe4Z4RaWgAe5maZaP8UeBYatGUy2i9xn2T/OjlT7Z33mlOLg53Sx/yLX6cE/v4c=
X-Google-Smtp-Source: AGHT+IElvMu9ig6qA6OAvBUBOC09G0K8Bi76FCKZIP3WXYbJCBWC/Vg0Yz8kt2HCjBu4rgpwzo2WQA==
X-Received: by 2002:a05:6000:144f:b0:3a5:8d08:6239 with SMTP id
 ffacd0b85a97d-3b8d9474fefmr6498925f8f.21.1754296795907; 
 Mon, 04 Aug 2025 01:39:55 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0b2d2fasm4635496f8f.50.2025.08.04.01.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:39:55 -0700 (PDT)
Message-ID: <25998fdf-9053-4f4c-ba8a-0743f3d750e6@linaro.org>
Date: Mon, 4 Aug 2025 10:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/meson: enter target hw first
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
 <20250801174006.2466508-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801174006.2466508-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 1/8/25 19:40, Pierrick Bouvier wrote:
> We can reuse target source sets for "generic" devices that are related
> to a single architecture (like interrupt controllers).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/meson.build | 45 +++++++++++++++++++++++----------------------
>   1 file changed, 23 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


