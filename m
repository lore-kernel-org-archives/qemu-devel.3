Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BC7D10DCF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2tO-0004Kn-VH; Mon, 02 Dec 2024 04:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI2t7-0004Jn-V8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:38:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI2t6-0004ur-Ec
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:38:41 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e96a285eso736856f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733132317; x=1733737117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/gZF90aJgqliQnKr6n0e1Gi4AgI6x/oeiV1DAnxLpE=;
 b=s4lDxjaJ3rp+krAjKlDhLUypgL9NGIo/R1G3lZUBf3Q5JiN9bsqYSli8YXl1xg+fvs
 2sMDDF/I+mpRkcJLfx4Mi33PqNTh99jphY+xW7a8F61IQOkn/hzBfSxBX73UwI5j871J
 bPQGpvrO+OufX9dtJRdtsYx//VdD/l+3i4eAJLbDunNvJAWzgOlc3k0se/L4t5kWigy6
 e1nMeSDcsql7TTSModSUiC/ryTdYM/rPN45zRSpBuABVuV5RyCdQRDrNbZh69zZbUvMg
 5PXHqBJS77YJNujmniNoLmIE7TId3WDQ+s8lDTRo9B2vCaU8PgY/92aFFrUOgZ74yqV6
 zvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733132317; x=1733737117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/gZF90aJgqliQnKr6n0e1Gi4AgI6x/oeiV1DAnxLpE=;
 b=it0jrpwSFhbj1Uy199cy2h8mTnSl1xZ6Fwehmk0CoQmcKhYxv/KYMJVophA0gcM3L1
 eJNlXdSdZdE79CimgTLpiZGCF+FScEZDkrChH/6ejKP29hXvOCEeGIEA22FDUNuRgsKb
 KgSqiYffjETRIUIOY4dne6Wbon9vY2hUyYs0Qlejnn1WMOartbMUMwS6Mq3C94UmCi+n
 cXBa7rluvmFfowlmDf+0cBp1QJ9MhKk0T3EZTtMEWBpUzurvNXqqgNvHCEfMJrnUvlTx
 O5mo6tzw5TUOd4dvfcvvP342a3usKLrK13e+PA7/DINn4+WJ6anJrga0DTQar3RI+p7r
 RAzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfugwja+M3heC79zaZANuX5c5CRizNVOFjxkV2ECbS9n/jv4mgpxgNlGoeVqKROeC3pR40SpimB7jW@nongnu.org
X-Gm-Message-State: AOJu0Yz+UJ+3xdZDSRk6O1xZjLtxEOADgaW3UCb+3hBnATSRrK6dVDFS
 HDmokKDO1XjyCoiuVwX9L0jv8VOYaGmaaxwPwWHFPLSbJ71Rqa+j+7AFb7Jhmck=
X-Gm-Gg: ASbGncuuWocCjurdccX8vqQF0RF5h+0w8QbStN/mlPo819iS3EerjBs63iyoQzw2L4s
 RgwhclqlIe5c/Yf7yCRfTLB1xKjWeyBq634oFD6emwRAH1nDDNjZ/LK4/rad9i9nRSd+wx0at60
 a1Ip+Ms/I3cHXI1dpCFSht7hbcOHi5x7iNXRkH7RZ67DbevU2Py5TWyoDYUQucD9wvVXJoViEwb
 B5731GCNhLSc50lcmsTNoR4fW2zojdZPapDbVAD/zkJ0n3FwGwbHcm2QgM/qBBulo1dkmNOt03i
 XPJPG8AmEQ==
X-Google-Smtp-Source: AGHT+IFUbM8M1ri8p634zKdM8cs89O8t3oX399HcTB0IK2XpdlP6jLCoi4GiycIuL2I20k0hDJkCtA==
X-Received: by 2002:a05:6000:a1b:b0:385:f15f:c96f with SMTP id
 ffacd0b85a97d-385f15fc9fcmr3948837f8f.42.1733132317287; 
 Mon, 02 Dec 2024 01:38:37 -0800 (PST)
Received: from [192.168.77.213] (51.22.205.77.rev.sfr.net. [77.205.22.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e0d4778dsm8382571f8f.45.2024.12.02.01.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:38:36 -0800 (PST)
Message-ID: <038264db-fbde-40b3-8936-badcdd5428ae@linaro.org>
Date: Mon, 2 Dec 2024 10:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] clock: inline most of qdev_init_clocklist
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241129180326.722436-1-pbonzini@redhat.com>
 <20241129180326.722436-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241129180326.722436-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 29/11/24 19:03, Paolo Bonzini wrote:
> Move object creation out of qdev_init_clocklist.  The input/output
> cases are very simple, and the aliases are completely different.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/qdev-clock.c | 71 +++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


