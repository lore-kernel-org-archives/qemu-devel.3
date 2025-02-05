Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6392C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfiVP-0006Fu-1U; Wed, 05 Feb 2025 11:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfiVN-0006Fg-8d
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:44:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfiVL-0001QB-Gd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:44:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so69613045e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738773838; x=1739378638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tx2YvHuoO9CXgFF/ODWjAo+NxE4mqGJE4nDUTD+xoW4=;
 b=JaR/bx4XwmVbEpNAZHa04PYdUV8JyUyjDqKZ9awjHi11PjWME4MDUMpqazcNFXkBRu
 PPTeM53NRbp50pK/T+JFsYI/YjrRk60BaEfyHtROPRd5Rmxdw/mz31osTmq87xvsTSZT
 PEe+VUWaO505Qq2zFy/GJcRN8kKB1h7dMX/fDdqgv+KY2+61Ghau2v2gKyDPDGylOUeb
 Li8KgOl8d+5rKrlRuzN1MpwPL2marHC3mSb/tMDaRyZDbxtOxrgyGdAE8yL4EO9F670K
 190/AH0mEb79D3UGCY7ECFd3RIfXBKCO+uL7IrsAzsl1L0jeUX3ZrPwswUNXtg2KmM25
 w5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773838; x=1739378638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tx2YvHuoO9CXgFF/ODWjAo+NxE4mqGJE4nDUTD+xoW4=;
 b=qJj2aDK+5JgfDtOnh2xcfGlvvkxPXiMYnZ9s5kxF2QdTCH/KMCgZ1wqOj+7JbMd9/r
 GL6ySl97WgazeHwaIOG35ek67WNDsiGyXQJ6g2oKva8XA4Mrkzs0VE1+TVynuAnI9dH+
 CSErmhJCAKw3BIrIWWPb8hbbdO5o/c+7LgS2MJEDwVus1r9WK2KjG8jMMs2aIJyYOi0K
 Wk0o7SJOPb4HoJjGsN174phGGLqgOXLtcgHCsDJzIcnD7pB9giUYYoa96oxMEEoeKvKp
 KiPGz6a/h1SNwWd5SWvL5Dj57iwd8IsEtsuOjQSJHNVP27oX4RwxSbh0In7rcHRsJuoA
 aYew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbKtgXNIoomUFK8fdO21cMDv03mh3e6vecmeAREuwCNQ8G+mWTe3qcTxLERqh20OmhcnDr1DANwLX7@nongnu.org
X-Gm-Message-State: AOJu0YyZI31uM0j7EmiGw9b+EkFLESBF4fODbGYioz1VoKW4lpSgM5aH
 9A5/twciiJrzFY/Q6nv5lvcIjm3C0+HAaAeB9UIvoJCLNhObZ5YIXwaK8AlmJcI=
X-Gm-Gg: ASbGncscBilJ4Zx6VguozD5+yZ86XYzf6Ixos0hquTFJNRy9B1j5C9z1D1UE/h8mLtk
 7U3jdapB7gne3Gbef9+TLtKPOe1fY+mexmPHLLTGCAq/yI/Yya14YhMWC+M+QRQCu+gyGPwkDXj
 E+VCU/aPYllY0TDhwCBABzZHmAMn0szXJ4sDNd/p/duvrnWUpw2uJXfUYVe8oArIwra4ziImBnR
 k1RMDZkSY3PO5wmH4qxFfg2kGFJFn+SQ3+6sq2GhmdcsWTHgr/AH+sVnEkzqr9yNQ/WO5fLh5J/
 SmtBrEaHzCUrxdydtN6EDKHNAvv0QplomEci2nAf3FUUAhYbNJIsr4w3hMM=
X-Google-Smtp-Source: AGHT+IGiDMVTaqg89acaK5HibVevL5p+k+gGb/YSVwViYRk8rsn4JA2LeS5CA3NaCMsSTbhd6QYH8w==
X-Received: by 2002:a05:6000:2c6:b0:38c:5e03:5cd with SMTP id
 ffacd0b85a97d-38db48bd642mr2700310f8f.19.1738773837823; 
 Wed, 05 Feb 2025 08:43:57 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d9651d0sm26442135e9.19.2025.02.05.08.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 08:43:57 -0800 (PST)
Message-ID: <684643f0-02ac-4183-88bd-024b2356faa2@linaro.org>
Date: Wed, 5 Feb 2025 17:43:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] meson: Disallow 64-bit on 32-bit KVM emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204215359.1238808-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/2/25 22:53, Richard Henderson wrote:
> Require a 64-bit host binary to spawn a 64-bit guest.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


