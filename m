Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C4C982E9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgoIP-00089r-Jm; Fri, 16 Jan 2026 13:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgoIJ-00086O-Ki
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:11:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgoIH-000099-DM
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:11:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso16924035e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768587089; x=1769191889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=01Gdt93eIQRnq6CwwyQPKMW66a9DKXVSODPcsAvUe5A=;
 b=zJLOOTGkEukBhFKeZmvjSPwIxamzm35uhlLA9XD5QywClOsoR2Kb/IytYN7z8K0zmZ
 TnZKmE1WMS0k2+DQVJGBg51y/+RKnISBrHpJwSXDrzvdMUGqNfWeJYphaAfOkHzt+FAw
 rI3UUIt4y/TW685kmdVw6So5SdvNlV7eFlD6JI69FJOLxyYatXTONR4gQANfD8LTBR8m
 ndD+YxFqpIUp3LrnRJajXx9b6n6AWqEeDMcma7Q4pbxM7xW98CgHRG5K0D4XqeA8IrxJ
 v5MRpk6DVmwASCmhAdYbTINnYj5xGAhkR1sD3pEAH1/8pqMJzx6C4A0w+WcqfW+nlpeK
 pvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587089; x=1769191889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=01Gdt93eIQRnq6CwwyQPKMW66a9DKXVSODPcsAvUe5A=;
 b=Gn+43xbvLuDC8y8oHVxirAIL0sZSgkarcN496NtR/QguFv0w4APoMncDLIKORcFL/H
 LXwaapW5hsRCCqp9YwUuKQk1ZxgUz+2/7g2fxsoZ80LmiPwmdnBAtr5nn2ofWFtpWhPX
 ibLPjwrW1ArCmfu3ng5bj8q3qReSlFumzTnrKGvXnG/Iv2kSx/Krwplc92QgSVZrgpM9
 Q2mq2DqYOMADCbwr9Z7ltdcJe7r9pY0CYb3PTD1yW2daTK+dzReWq2K7PThB43XQV8MX
 uNs2nkisS5VtBsRdBntp+iLJ1E4UwCtTdWysfjfvErVE4xWog3/LvPXrJxMXFFY84bBH
 CjoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5yVW+TtefvCvXfISZe9esn3aDRSf/kQW+MVO6KykQK4/V0PkysY2YDmw2wqxvdGoBg/xQpV+8kgV9@nongnu.org
X-Gm-Message-State: AOJu0Yy8UK4YXVwy5FZYbfXDuD/qVK3wC3Uc5ro4kufHBgoB7xn60ZAk
 x8R0FbAH+n9OtuOv8EtCmbD9FMXsJbyrlUzx5lrmUOdJiSmt3SHwrCrdCHS4wLFcScM=
X-Gm-Gg: AY/fxX7dbctT+uIe+9n2yVeO2abXKpw0ZsdGrw71QMUa8MnQvF0EErTJZtt7bblVzni
 g6zX7/ExP9yHgRvsqT8jHR7W7O4IRDeoR2LA3HHyDxV5UG3LE77FmeDc8FaWFnbv5XK+SrJuW8B
 5ELcqvkCLhchttuuyRRaR9Bj47hXCTojP0++5ABj7RRIzejEy14SComXTqfuSCFYQb/fBqrJQAP
 Us5Iw4M7Ggdh3mAluLA49ZIqJBXZLZNcaDpebrNNFrDKAtNjT4uEjMU50E6dv3tCBG7Ulg4NeL3
 z12XRd554ta1qQJIcBjk3PBMzf29Qe9wUiNeQMsq1+VdPZ7TYBiDFi6VbtR75cfziyhnRs2Vx9J
 sQ6IzwSlsxEamSaTA2JUVcqbu9ndFH3iwRsOdijQEU760P2uNBoPcPw33MBSMVW5S4y+x9Zy4m6
 yvQpxMWDNMNfr6nkoekIaCyzGUBO4k0Cyjj3inObQKL09RLPXuEKghUQ==
X-Received: by 2002:a05:600c:548a:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-4801eb12369mr39508255e9.32.1768587088653; 
 Fri, 16 Jan 2026 10:11:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm6859556f8f.6.2026.01.16.10.11.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:11:27 -0800 (PST)
Message-ID: <6f783a44-2ed4-4e66-a003-00b668ca279d@linaro.org>
Date: Fri, 16 Jan 2026 19:11:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/26 18:38, Florian Hofhammer wrote:
> The return value in the docstring did not match the return value in the
> code (see plugins/api.c).
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   include/qemu/qemu-plugin.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

