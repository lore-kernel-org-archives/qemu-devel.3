Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B069C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 11:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueY3J-0002QK-I2; Wed, 23 Jul 2025 07:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY3E-00025Y-BA
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:54:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueY3B-0003pe-He
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 07:54:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so5169862f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753271658; x=1753876458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F5UYc63R13I0sB8gTeo4oXt3OJ3GV8nT4O74lNv6kpk=;
 b=CuDtv8gLDp3Xt6sid1gEqb9lf5P+CyrKyRKLnCyncVUa+Qz6VC3b1dUsm55xG7+EJE
 60GE6ZddKVj5n2Gsujebp0GTkz731+2Uu7Uo6EH05IOzzSiZU+ZC4gXIw3Elh507yI6C
 p1qhIcx3jKia5oI7egj0FSv6fO5i+uNazgvrzVgSZhkhBiJ2nATHULZeNAqM6dCsAHbc
 N4IJqMSD81KzwKjphWxv9c+Umvx0/kvmU7dbfyHgTrHvGUe/kh259odPCwI1ILS9/NUa
 Qw2Cj0juGpX9Rnw1Qm61XBu+b/kc9ljqby7uk70d5bJnr7FLgJzkVjIOhJO+5Zm114AS
 OTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753271658; x=1753876458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5UYc63R13I0sB8gTeo4oXt3OJ3GV8nT4O74lNv6kpk=;
 b=BKvHkQLDK0SUqwP8kzqKATlHOhlnUSytX10TdZVr34FC+0RJdACeustI+OLNUsrQY0
 Z1u4lggv4zsAZ0AdghjMBoSbD3xBKCB07aqzJ7RclLSoaD8M7jxaEF7NlFFmNdh543OE
 BdlNS3HGJQ61lmxYm4zkn1zyLEYKR4l3v1Cf8GufRBoVp2BXkYG7mk7xVJDdAn/101/C
 KTpS18MYjHLKx9rfv1eqKV6AmBEthxHEsJTBpO8eVo5z98Ttz5gJsRZBgST//1TleNZ0
 7NBs1Gy8GSMESZzHDpBiww84jFWdwjPObAM6YCTxXVLy1S29443XNluHbOvdftouiFp0
 gGKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaEN50NzvOEZpPjrhWCjR3o1L7f9zML75bhu2SbmEAKKZi0nWdQc0+uwo4dzbKr/KDBj99AlKebRJP@nongnu.org
X-Gm-Message-State: AOJu0YzEfep4OLphPTrj7AQNRwa4Yya98U3890rPuA3AyT1qR2lF1EsZ
 39NZ3tBGg8j9gbuAZ48lSsS1OeGpXaRHr4TlJeFC9dbSCOxAl7Mbe6pP5EUy8fR+CL0=
X-Gm-Gg: ASbGncsbc6xbzaenvnnFXx8uWBQT4Y/lK5UyjJy9lBbVFA7+HZTyyqb3VD9RRmLcR9H
 RYRZ4zvxpLlQxwpacPWP78mZSYboweSHtObXWL/k3MMUQ+cPn4CYUdaaa+XzKo8vjoFduzlru8j
 +Kz3iW3eK+8cwkbIEtqPgj5YfA9AyhJ4LvJ6si2ikim6iGXjdzoFHcSqZ8MGvWgHJW5mX5G3eL4
 gn0nljABp2Og2JryfhSCjn9Pz5GNQW44l6tOou2chqmpvfbsI0xAVEr1DIIJCzQ8gITedVDi0Sm
 pQR4RcQv1ZVGPQQrkckL0NUlkjEEDzaIhYYXp1DhnrLKjUHw5V1co40SbzNIorqZXX1t3Zs7t0e
 FPkh1bN3BTnBlRFqxXlDk+/KB9uWuWkkoCCsq/2jqtzcNSOHI7mVG6cxGKtWOZg5F3EGNlX/umE
 SxFhFM6A==
X-Google-Smtp-Source: AGHT+IGwOaP8SmdEP7ecmG77ADFCHnid9q77WuZNuuzN/3/fLElZr1moowBIkbq3LgFmVkBGKMdnow==
X-Received: by 2002:a5d:584a:0:b0:3b3:9cc4:21ce with SMTP id
 ffacd0b85a97d-3b768f07c8amr2054389f8f.50.1753271657788; 
 Wed, 23 Jul 2025 04:54:17 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693e2ddesm21292615e9.29.2025.07.23.04.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:54:17 -0700 (PDT)
Message-ID: <78f613a6-dd60-4f76-bbb4-8ba4fb91a7a2@linaro.org>
Date: Wed, 23 Jul 2025 13:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] target/arm: Added support for SME register
 exposure to GDB
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Cc'ing Gustavo.

On 22/7/25 22:14, Vacha Bhavsar wrote:
> The QEMU GDB stub does not expose the ZA storage SME register to GDB via
> the remote serial protocol, which can be a useful functionality to debug SME
> code. To provide this functionality in Aarch64 target, this patch registers the
> SME register set with the GDB stub. To do so, this patch implements the
> aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> specify how to get and set the SME registers, and the
> arm_gen_dynamic_smereg_feature() function to generate the target
> description in XML format to indicate the target architecture supports SME.
> Finally, this patch includes a dyn_smereg_feature structure to hold this
> GDB XML description of the SME registers for each CPU.
> 
> Furthermore, this patch series increases the value of MAX_PACKET_LENGTH
> to allow for remote GDB debugging of the ZA register when the vector
> length is maximal.
> 
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> 
> Vacha Bhavsar (2):
>    target/arm: Increase MAX_PACKET_LENGTH for SME ZA remote gdb debugging
>    target/arm: Added support for SME register exposure to GDB
> 


