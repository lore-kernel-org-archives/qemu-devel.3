Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8DFC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0U3-0008Tw-7D; Thu, 06 Feb 2025 06:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0U1-0008TU-S1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:55:49 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0U0-0000FM-8O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:55:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so1199837f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738842946; x=1739447746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CA/dXdowQ5Z8MBm0t+JciI+P8nSeSoHs1GjTv6IxbE8=;
 b=Tdz1aIUxAc9Uya7bhBW14QoeaoenEMQ8MsR2cDYUyGojANZ0LSMyr/K2j+8yvd9z1m
 7+w3zkCUcJvQ4uYNHB7stc+MTBj+Pt0hbPKWr4F3ckY+aa62rAelcxYrp+lyAhapBA2j
 NStoYQKRNUnXCF/fxXopG/5Sz/k5qcrsf9GD4s2bxhy7Ifh0n5tusHsEVyxxCvMlpV0w
 2w5YYhUhE0HttGZtUcQVnWsnhnvqGHpWlVhpG9w5tpAH2Pz7uLJz7rwkfENP4h5bmsDN
 CMlUu/i6BtxWXJLC9ogRuK5lDuzj4rO54EoMtH+BUI9v4UUqr4HqL17p/bXO7xVPwKzi
 y+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738842946; x=1739447746;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CA/dXdowQ5Z8MBm0t+JciI+P8nSeSoHs1GjTv6IxbE8=;
 b=eAFGI40fEx6I+2EqspKcTyqJwk2+KAsYd3X4Qos9mgZRrpvV/Miyp/MoECHukwI89t
 4v/rMkRDLBWaqdpE978mMPvGx4iubnsY5DQsZZ8ABxUNR5xTqPF6FpCIZdrXbY1CO+bY
 8e4koIuq96GPxf/g2qnLOJoixoa3Iss3d4qxvHMyF+J4RGrXhnT3end4RTdYwdUQYft1
 kv+g5/L8ZJL+W2UAMs6IwGOfYLcJ8/tOCD4H0HktwrhLuMWb0YB36Il0/S9+RymaSCgr
 DtckHehPrbFRD/PtknVYKk8ivj/cBqCfwWDSSfk/Zc4oc7xn4IASoNjgdg7vDjJPR/ah
 0ZBg==
X-Gm-Message-State: AOJu0YxDgRk9ont+QAQF2pRVtdvyNuwWLhdxOTj7zVD+A/MrOG1vzfHH
 pXjkrcnVr7q3N9zDi9Qhr/h+sWJ/zwmNpSy3ccvyXtwF2KSAdJFlnnc618mNLt1cKJALpRjR4R7
 99qY=
X-Gm-Gg: ASbGncvs9LR9aJDMpJXmLXDXr90q8bV1Lq55TAk+xGZsMTIgeQdRd+XfhgXa4kAUHg7
 TjNaDRYuGruCODd5O1VwYmhizApccRsbuabaoAX+2XPh2fa4JiTfg5TzTMuIJph4TgXTxhjg/zr
 4/ClO/d5i0mDhvqKGatxaHzOpG6r+EFcqC6/wwn84TxNHkjaMzacNv6ox9p3MpMmmMkvdjYzfXB
 8l/Kjv51COIvOLUm5CkiaH6CYhCMYdFlpF6/pXlnB4j6AWrL1GIP76npiAZQnLAQuDDWLS3CX0V
 6B9bZb1msvGA3zw+IS4ov0hYbIhPXk9am51HtbdDl3wpMXi9X7ccNaS/a9Q=
X-Google-Smtp-Source: AGHT+IG4ZrowLTaDXcRGnSDg98abu3rx9bXnkOW9gj6RS9RozGbTyj7AnzT4bEirLona4ScwyADTJQ==
X-Received: by 2002:a05:6000:1f83:b0:385:faf5:ebb8 with SMTP id
 ffacd0b85a97d-38dbb24ca21mr2241758f8f.7.1738842945955; 
 Thu, 06 Feb 2025 03:55:45 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd53a6esm1525725f8f.43.2025.02.06.03.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 03:55:45 -0800 (PST)
Message-ID: <e7ff4aa6-96b2-48d5-ad12-567be6fe1393@linaro.org>
Date: Thu, 6 Feb 2025 12:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/char/sh_serial: QOM housekeeping
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20250124175053.74461-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124175053.74461-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 24/1/25 18:50, Philippe Mathieu-Daudé wrote:
> - Parity in realize / unrealize
> - Define TypeInfo structure
> 
> Philippe Mathieu-Daudé (2):
>    hw/char/sh_serial: Delete fifo_timeout_timer in DeviceUnrealize
>    hw/char/sh_serial: Convert to TypeInfo
> 
>   hw/char/sh_serial.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 

ping?

