Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5443CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulsHd-0002Bb-QC; Tue, 12 Aug 2025 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsHR-0002AD-5x
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:55:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsHJ-0007Ar-Kk
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:55:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so4663008f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755017702; x=1755622502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iykB/wO7QLiWxtlNd7cPgV5kQRD4HhNNzKjA0ftA4uY=;
 b=jx8Tdns6aVMU8cNKfCpjU3YQL5uvoAYYsSP//1hvWD9/vi0Dl74JBXA+VFIzVwHMm0
 1MVRE1uml7wuYKVxPorUZa15oHRJWGxuqZxSNJyTFz0fqVwFulJAIhkSQIpi7QTcRb1n
 Lhu9f4QVTCSCA60/ZYpnljiKMCKKB0SbHW/587SpRcskQaMmTkqjWO8ECbj/t+o+6Xue
 wGdd3VEw2oX0A3ttLQwZm1itPZywLJjZRoRk+G5YxyBWPyjfv+XA2OnuUoCG2X9ijNAl
 UkQavqVdPY8MgE8Y+RihOL3QGM7+sF+tbiHUfjLlK8xnkcNRPPjyaPNlsVEY1mvLkUVn
 qlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755017702; x=1755622502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iykB/wO7QLiWxtlNd7cPgV5kQRD4HhNNzKjA0ftA4uY=;
 b=wecmJrsQvmPiOzCsnDe/NDwIOLBuMiuvroXCToqbhfaRtN9C0GBJERhcuzgMoO02q6
 CHsYSuvONgJKkvcxAdsS9deoc+F+t5vu5QWgTE4AmZ4NDpBqxYf9E7rXizlIvgz5CChN
 XfYAwtxn7GaJb9opdWVI6Om9av3kLe3JSShVOfD9Y0cA6LrvPyX/doSjE/K1JwbvdL22
 BPYF5nbZUpfm8ITvgK9syQ/cSNuA64Wk4hZUAEG8hIFRek6fD73Smc8O+Gu3dgOrPIEN
 JfzjmDOGVfv59l1IhjCyxdnx6zyLqC7OeVYq9HduxVPoJcJhOotoHpcOYSh91ShZUe8d
 OfyA==
X-Gm-Message-State: AOJu0Yw9cHfzXssZzISy+WpmIzy+MD/yS9t+d8ukZdIE7QumfGL0VxIS
 XjsHfHo/dAGgvPlsJchNkYRFsMPXpvVpTCCrdNp9kkNqtFzJhkqzsqwwaGyKHc4ddP654aXcFZx
 tXRvK
X-Gm-Gg: ASbGncvJZbK2u8NH5WXvUWqS/h82Sj+q1dWNfRbXmXRLeykbCrKPvbhDbaRlmASy5db
 UR/5K7Bh614F9eSZhANPl1QpoAL6bw/DhjEFQBn5ca1dLczUEGuwUqVyvhhRUtBwz8oP1zfFw03
 LiEqgGF1jEAHnNbz+jQJG9CPHVRrlBLKrsWNxBD+c75IdKUgENmt984QsPBfRhbEUbuQ/UM2QqX
 9db5Nq+HuH49WQcvATTRoDoq2KMYqMHAiHq/DYTT3LD+agmmTqB+zR0wZBqcGyOdmQtt8JXxx+l
 uRhtbzYFRtTLdytUnEm5MjsDxJBfAT1gLCfpF9tMNNcUhOYyph1axUAetQYIjM0+HjRPkv46RIL
 4T9KeBd7xrJjaDjQL7nefPmEJ/uZxtwebNM1JtnF0K/fBXE+17OnOzkEjMZAcF5rQCg==
X-Google-Smtp-Source: AGHT+IGB9Gf6Q8+4tpImxsjSkjkgGC+wrME652b3/FjhCkXkJxOpQu5MBo6D7V5lEpkvccuZH1VPeg==
X-Received: by 2002:a05:6000:2383:b0:3b7:75e8:bd17 with SMTP id
 ffacd0b85a97d-3b917254e27mr105360f8f.8.1755017702125; 
 Tue, 12 Aug 2025 09:55:02 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e58554f2sm302974285e9.12.2025.08.12.09.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 09:55:01 -0700 (PDT)
Message-ID: <32344620-22f2-4492-9005-3f58ecd87e2f@linaro.org>
Date: Tue, 12 Aug 2025 18:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 RESEND RESEND v2 0/3] hw/sd/ssi-sd: Return noise
 (dummy byte) when no card connected
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250812140415.70153-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250812140415.70153-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 12/8/25 16:04, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
>    tests/functional: Test SPI-SD adapter without SD card connected
>    hw/ssi: Document ssi_transfer() method

Series queued, thanks!

