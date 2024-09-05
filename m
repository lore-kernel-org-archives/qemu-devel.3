Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC87CD4F4E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 01:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm1M1-0004PB-6S; Wed, 04 Sep 2024 21:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm1Lx-00044y-GU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 21:32:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sm1Lv-00044F-QE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 21:32:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-714186ce2f2so223365b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 18:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725499922; x=1726104722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwAn1kv44t+Nf9cSQ/+meM94picUQMmPMlITw8CcnV8=;
 b=MnUljAcwjLdLcDq57wT0umjuWsDhIG928imVdVYz6LXZqPoPHhKXAC/R2pgM4YdcUz
 Z0ykxT3zm56cWZFgtgIxAx1hL9R5L3rw/ileQvaVljQxD1EZmpAPscbGJE3cLezZjkha
 v121dcTftKWiY6vIzlhYPCwM7x+tPtpMRTRCXIpglRlAKcTlo7J0elUyr/wLIAhla8RO
 lwSNDjRZgBCNoGn9xGwvnx0QMwf95NIWzFLWC3Zo5Z7hW0DvKvwQYi9770qqFPRPy0y0
 JcuNk8E04WLPH2N8BM+enuD1CBsandsLs+GgoanSQN9o2jW3CKjmSpn88zsWGX6/FcXt
 gHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725499922; x=1726104722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwAn1kv44t+Nf9cSQ/+meM94picUQMmPMlITw8CcnV8=;
 b=W2HbiI9ooIYxtVkOjw8GyQY/h7tmgx+t/9mXGa5rzF4HVSrMBZCeOFYgbPwTtpVprS
 LxnFnVwuMV/v5ALt5/Js6LcGSfFo0bX3ELxKQKahlTpSBswY6IkvxtSGdF5JP3Bbz4TA
 X7cjqs7rU3ReDjlRqcp+h2Nfwr/WuLsxliVRCE6N70o8nQX0pgD8EA6MNcbPTBgO5Ktj
 eFLQd8qVQRHK5mJYXV0qa6DxL/m6/spNSDL4Q2c7GgqHLz+9ExofVUhnbD9i3h5k33d0
 EYsfGmaI46WRWRFT/WdxG7vhJuAUkcEp13gFiLZ5NjBdFcyKXPEUEHF3ehR/YabQdfn0
 ZREw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU035n+0iFNEi33zLpDBWltUMWuPpAl+ExrHsb4DJSRZCMO5yRJ2gjw/C7AjlBj7lGd/cKLmjKKtNrh@nongnu.org
X-Gm-Message-State: AOJu0YwSooFff7rgpkZrno3CX0C/+zOIr5dQUUCTY9/6sfk0mkgpwirI
 Iwd4zdcBQCMJSw13LXCsHn3ght8US0dEk+f1w4rQg7g4Esp2H84iqfWQXlnE6CI=
X-Google-Smtp-Source: AGHT+IGIjVThl37BMRPt1gckIobO2jQSC+3mxdvaxNbfv4QdmqW3ud4nOHTez2lYXOjDhnW9DCd/bA==
X-Received: by 2002:a05:6a00:608b:b0:714:3de8:a616 with SMTP id
 d2e1a72fcca58-71745884fe4mr12654507b3a.19.1725499922003; 
 Wed, 04 Sep 2024 18:32:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71778520ea9sm2236065b3a.3.2024.09.04.18.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 18:32:01 -0700 (PDT)
Message-ID: <54c411bd-63cf-42cc-a3fa-1bb2ac5e2b6b@linaro.org>
Date: Wed, 4 Sep 2024 18:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] target/cris: Remove the deprecated CRIS target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org
References: <20240904143603.52934-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/4/24 07:35, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (15):
>    tests/tcg: Remove CRIS libc test files
>    tests/tcg: Remove CRIS bare test files
>    buildsys: Remove CRIS cross container
>    linux-user: Remove support for CRIS target
>    hw/cris: Remove the axis-dev88 machine
>    hw/cris: Remove image loader helper
>    hw/intc: Remove TYPE_ETRAX_FS_PIC device
>    hw/char: Remove TYPE_ETRAX_FS_SERIAL device
>    hw/net: Remove TYPE_ETRAX_FS_ETH device
>    hw/dma: Remove ETRAX_FS DMA device
>    hw/timer: Remove TYPE_ETRAX_FS_TIMER device
>    system: Remove support for CRIS target
>    target/cris: Remove the deprecated CRIS target
>    disas: Remove CRIS disassembler
>    seccomp: Remove check for CRIS host

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

