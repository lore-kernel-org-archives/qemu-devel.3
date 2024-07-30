Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C675C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 23:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvtW-0006mf-U6; Tue, 30 Jul 2024 19:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYvtV-0006mB-BZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 19:04:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYvtT-0006Mw-U3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 19:04:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc5239faebso33553355ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722380674; x=1722985474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VwgfPw1XCFUOGlNnoIqRvZJnLsAfZWYBgOQL00C4u78=;
 b=bQ0p5lXte7qi53SrBKePi5v92MTW1MZR2NZIMTOjc1nmXblIuo47wf+q2iiQ2uOggJ
 G1zgbAdfGDxttXbziQJqcI6XBt020ID2BXnyzxpGzGu3D2FeybyX2h8ZY+Lo+LsPYFOx
 71BS3ZtvA6e+dIp1kI7ZrvDUctlf3xeEArAUNqun+I65jN4yKpt37FqKP2YmVulmMBHo
 zAbQT54PPzm2ZJgU6WPgjEKacFdjKTxTTcE1C+WSDXS56LvIvQi3gY5PpaicPOGS4kat
 CZekdJODMOZsh6WzDVEh3+7fuwj3WSyoVObzztWiRKEJpzphwrpl/iKiyrZmZ6xQdCmW
 Lhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722380674; x=1722985474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VwgfPw1XCFUOGlNnoIqRvZJnLsAfZWYBgOQL00C4u78=;
 b=kFUQ3KHFj+DylpTVpIrIUykuE2gRmMrbygW2k8OQx9Gyqrjd6MHqoXv2lybtcio8AW
 4tCbATjOrnrs0tfVBj3EBnQTuK/pQdEYFkRDnYLeULQ1W7Ni2DOKSFOdun0ixDDZHen0
 PkpyQRCJSN2OsV4IjQTcaJe8sDayn5T4KRanUO8t5Eu0NgVkMWreEYVeFs/83/gIWqYJ
 3rTDMg3mMYn/ZCGLxQ4yJwSwwoalX59cjk0Bf2U5YCW/TI4bd9rhc5hyR4grq/Y0FI7q
 LYVwB4yISGmCNR4jiDARUl5nSfMRcGWdNO13qMOJd7qio8C4XhnltHGMzBwgktsbDPVQ
 5fTw==
X-Gm-Message-State: AOJu0YwE2v+InPYb1MlHyEKY6mEfy1q3fIMGP1Qp+BLxuReIPWz6Ocoz
 ut8irFs4mH4gUPXg3HFGYrS1IHcBLtgfi/gXkzkstL8iUc6F5J7cSQTBC/mjnrI=
X-Google-Smtp-Source: AGHT+IF+DGDiHE0hsN3eNYO7mteDZvWvdkjJcw8pi4Xqmvf221A+Y5O5cH0gZuVzr6+wED6OZ4Y8pw==
X-Received: by 2002:a17:90b:3882:b0:2c8:da73:af7d with SMTP id
 98e67ed59e1d1-2cf7e09577cmr11037182a91.3.1722380673670; 
 Tue, 30 Jul 2024 16:04:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb73b7674sm13107976a91.20.2024.07.30.16.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 16:04:33 -0700 (PDT)
Message-ID: <d5e48656-737b-4a91-a004-1da913834594@linaro.org>
Date: Wed, 31 Jul 2024 09:04:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20240730215532.1442-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730215532.1442-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/31/24 07:54, Ilya Leoshkevich wrote:
> While qemu-system can set tb-size using -accel tcg,tb-size=n, there
> is no similar knob for qemu-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   linux-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

