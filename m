Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E30CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH21w-0000Vf-E7; Thu, 06 Nov 2025 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vH21u-0000SW-NH
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:06 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vH21s-0003fD-Du
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:36:06 -0500
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b72134a5125so105211966b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762443359; x=1763048159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USW+KWepaiP6dhVS8miNlW4VqVFRYFFw1EyWfJnZGbg=;
 b=ZTMOxe+gdB+DpsxzuK9UXeUebhD2kFqBFNmbVVZJwjPREtAMzvgLLR8UN2yc97v6RG
 ESkmjxyhKS40Gs02THQxntLSyn4AC4g717zQczxXL429crtqJ1sCBIut0Kbz82i9C+Cs
 ISLoT0wR7IV6Isr6J7zxzofDIxvGbCL38MmT3cD2O6VnJJuZRc1gcz1YemhingukJmvO
 ypVys8IQs01bt2g3m2Stoi1XV75CY+DgMXKv+ur1HBwkin426UYcxxKzoc26N2b+tiUB
 abNc3GFTl0WuwCNl3Qdt7LEgB7uaW0ry//zRb8UXvADIY9tnbUY7Z6GiHWscbtK4Q/+u
 j66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762443359; x=1763048159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USW+KWepaiP6dhVS8miNlW4VqVFRYFFw1EyWfJnZGbg=;
 b=H39Vs1CAqo627CPlUtxGt7awVT9eJn/+Q5c86YYU/KELxv7MXEnesKP/3zUv4M9lxm
 o0TC/TosGHup01UEeioqyxkl7z3VUfOhJV8iJdbRZk5Vf1QV47f+eYMPwkSeeM8jj4/Y
 gAmstRG8L0bmxDavkM9vlWwdbE5eHyz/+C6Tw0tZMRsOeDh7WJOIWJMnfrj/6AM/S/A8
 OfVz2GDQiVYsIZ6o4q74hwP6kUqmO5D88VgszVlgrVPy+dC9yTpspS71ZDmACJGvhzuv
 rqvkaD69sHgTjarAeWwVeZpW0V6I4nhZpqTYvftshBtqNvyip5WMzuElSyTYoyh4Pcgs
 yXBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmWHiYJ5TwnPgTqZQNIqxkltjSk9XNp9fZ0Bm2rhf82UhN6cu28PLTptG6Wh9wjwz0IF9ZiAjW6uWr@nongnu.org
X-Gm-Message-State: AOJu0YxGAmS0vg5/v0Qq4Q6rSVC0BOmuA/MmCJTy3s943NU7FmhC5mZu
 fN8K9gxZbtfLthnnAipWwIpRNB0PP2brovorhgOk42/PUZXZ/lvZjZDsXSMQIJ+Awyk=
X-Gm-Gg: ASbGncsIGhAwxYOUBtdGKv9ojCSdAWV5g4vE6tCdzcPvj+fI2McCAcIB62nSWMflxDF
 84Bw2fMo1dvhlsPuX8WfjLUr4xUKMudim8WdbRKlQIaKZNjWdkqPjqRYRxtTs09zbWK1FmT+p6k
 +AdmpA6CRrh/B7scxRKozdydd5hmTGFq4feC/wB9//ARZjDTa9YRPVFrgEKxbBIZGI1QFZjCKT9
 1ynyGuYLolC3JwwyHParxW/pZ3vOAD5YHJqysp7birkibemCbDAqGOjRrVL7Sg/EfOv8od9NWKF
 /CmG20r5+y7XydOZzrMyn0k3/HyrecaWFQybQA56jI4JHOHZ43hV3e9y6OXIZlPkVBpAhu3xAaL
 C/p+EgeGpXi9dBWJAuG/cVAAoW1wLgdY2yEiJeSaU6aJLPQOkHAPpQzSbkPKSW8JT+MqJc75MF/
 LVUOIefg+H1R22yw0g+4b5hH1R
X-Google-Smtp-Source: AGHT+IFeaJhd91Dp/D5auUd0xCgfNgMHM+Kae1yjbuTeJ4y3+oQTg3CS/UU4hx9AMbgoBGdIdlaTkA==
X-Received: by 2002:a17:907:6096:b0:b6d:73f8:3168 with SMTP id
 a640c23a62f3a-b7265155843mr952815066b.3.1762443358811; 
 Thu, 06 Nov 2025 07:35:58 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7289684a48sm242339666b.63.2025.11.06.07.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:35:58 -0800 (PST)
Message-ID: <4948f1c6-db23-4880-b982-1cffcdfd48a9@linaro.org>
Date: Thu, 6 Nov 2025 16:35:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/display/xlnx_dp.c: Don't abort on AUX FIFO
 overrun/underrun
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251106145209.1083998-1-peter.maydell@linaro.org>
 <20251106145209.1083998-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251106145209.1083998-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x642.google.com
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

On 6/11/25 15:52, Peter Maydell wrote:
> The documentation of the Xilinx DisplayPort subsystem at
> https://www.xilinx.com/support/documents/ip_documentation/v_dp_txss1/v3_1/pg299-v-dp-txss1.pdf
> doesn't say what happens if a guest tries to issue an AUX write
> command with a length greater than the amount of data in the AUX
> write FIFO, or tries to write more data to the write FIFO than it can
> hold, or issues multiple commands that put data into the AUX read
> FIFO without reading it such that it overflows.
> 
> Currently QEMU will abort() in these guest-error situations, either
> in xlnx_dp.c itself or in the fifo8 code.  Make these cases all be
> logged as guest errors instead.  We choose to ignore the new data on
> overflow, and return 0 on underflow. This is in line with how we handled
> the "read from empty RX FIFO" case in commit a09ef5040477.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1418
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1419
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1424
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/xlnx_dp.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

