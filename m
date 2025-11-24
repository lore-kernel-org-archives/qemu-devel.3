Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569FCCFD347
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbQE-0004L7-Mq; Mon, 24 Nov 2025 13:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbQ7-0004IF-Vi
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:36:16 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbQ4-0007KO-Qc
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:36:14 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7bc248dc16aso3465061b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764009371; x=1764614171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fQpYlTe2VGIgHDWUmv431DdYIP9a1PSDSntgiIVS+Sk=;
 b=ulZP4ZzH/u/O2fiBLVXTpdSbB7+0wqs7xlKKszBUSROts9HWCLn0W/OLP/sNHgvPiU
 6soMGh/aClxf4Uzrd13ZeJlh73LnkJdGL1JcAadBn5CY4WzEHm0RFsq+xDJ2vUtnh8S0
 squQeM78/lbUkpKNouzxOsC/I415dlZHHKJrNHyamcbIHQ5pbp1Kjzy4E1nl+CU0uhWn
 bRMcxjFYwg2Zk5QROAnQcJylE8lz/3qieyc1uEFyBXGxIbWgnB2oP1EgOriRYUEWsxdo
 fOcYyASdgETbsbUr+kp+15jLl7n/jLhUfd5+nJicSV4cTw7Sev8ivklS9wEGLQ24oa9S
 PsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764009371; x=1764614171;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQpYlTe2VGIgHDWUmv431DdYIP9a1PSDSntgiIVS+Sk=;
 b=SUnFN3raW1MT4zbUAlMQem+9hWovGGt0SIvDRIBlO3WeCnmrYe6MMg/87CNdHpMjM4
 qw8fHxNFvDSau3SzPvqiBkwO09CU0uSYlmEvdRm3yTFVm3q/e/TfBETczRgBdRq9AVtd
 ss+w4ILAhjPpWsFmKafuPhw4GRr41JRAM60B1StHKvRbOhY3YJZoHiErTP84YFOtdEyu
 TQhzojIv2RkRC9Tjyi7ZMs/HXuG4w4yLCZ+2dqqxlSjEwPTJ30WQCYTFGRNEpoP7Y3Z+
 XQzoyGaCw6BFhvXU5I/kAkiNcIfGCpAsT3WZW6Ba3iSfpab7azVNfU6hHxsOonw2QFaZ
 RvNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVnDTEAcvvbUOu57ZbRQi+FrLLbk8CL6P6UaboIMo50J1S+Le2LCbHh2qPB50Pt2rIGGOPOlpvks1B@nongnu.org
X-Gm-Message-State: AOJu0YxUirtQRLDDHMZc6NNfKH2ALYzcdEioV9m5Xg+QYMrBq3JQNpUE
 J4+ZQPKM+NAqXws9YGFo2XN9qOMthWzf8CW0p1V945L+xe79mwZ8D+R5LXWhag6lP7Y=
X-Gm-Gg: ASbGnctJMv0IM2tjuRefV+7osNmx80RqNkWlQohYM1j+BcMmNHTnJ2J7Fj4mZJsCd5g
 eECAoZcuu+oWoZR/LlTwTIdExAAr6OqXlc5/CE3ceJJ8OB0JrNRRqtVkZrLF3G/DgoLsCAYHYK5
 LWpzcWOhiS/skJ7stNMO3H5r5oXJbhDyDLIphgzQx90E+9CA6WtAVmlbHz6JA52JmHFB96zeAYL
 y4ejQwMpDKTWjMjlIgIiozQuXWq3Ibw2ASUy61o9N8FvXMkd48DFrtaC43KpAtF/qK0BXqt2jfW
 PFRjo4oX9AT/Wltxqq4au7N1bbfeSut90ONEcbHUMJ3/3GgYsmM2W5cwLr/1sWv/QyH1U8VNR1Q
 giDgPDgNCZhupVsnSfOZ508TQotJInFapk/ncVnBKMla3t1Q9A6UfShext7SZAcR+f1JxcpmczS
 OaCxZd3626hYkUatpybBfyoIWXA0jsdiAMrzjYwtrj7A87I2eDHg==
X-Google-Smtp-Source: AGHT+IHIiUD30cVG/dB5ouBgMLbebXnchXcidxvPhFF/4gYiPGQfNoPDdpTFE6JuX0wD15bltsv78g==
X-Received: by 2002:a05:6a20:1593:b0:342:f5bc:7cec with SMTP id
 adf61e73a8af0-3614ee83725mr15087277637.50.1764009371350; 
 Mon, 24 Nov 2025 10:36:11 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd760fafe62sm13851136a12.35.2025.11.24.10.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 10:36:11 -0800 (PST)
Message-ID: <5b85f8d4-c323-46cd-a0dc-ac62e770295a@linaro.org>
Date: Mon, 24 Nov 2025 10:36:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251124070524.240618-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251124070524.240618-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 11/23/25 23:05, Cédric Le Goater wrote:
> The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:
> 
>    Merge tag 'staging-pull-request' ofhttps://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20251124
> 
> for you to fetch changes up to e9a8b04dbb98fba7942b23b3ac5c35f2f0b9c4a0:
> 
>    hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilities and enable MSI to support hotplug (2025-11-24 07:52:42 +0100)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Fixed typo in the AST2700 LTPI device
> * Fixed missing wiring of the SPI IRQ in AST10x0, AST2600, AST2700 SoCs
> * Updated ASPEED PCIe Root Port capabilities and MSI support


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

