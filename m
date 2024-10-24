Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CB2CE8E6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41mn-0001fF-VH; Thu, 24 Oct 2024 13:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41mn-0001f7-4e
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:38:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t41ml-0000Bw-Ki
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:38:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so834668b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729791490; x=1730396290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HCkA72Al+fLXp2aws/gCeHnzhsyDnDthCWS7L8A744=;
 b=snsDxCP6uKGF8pklijjgkog2fi3O1yinqmZ3RhSziNmGoW6S7OjM5z99MpSh7bgK1i
 vT5XsboWsjiSEZYD10aanKevosArwEdy885tPJY8PwhPeb1voPt8LGD2qK2dsuxiUxnJ
 be4j/0L8MtTcS1tln3XxpA8rhtKvPL31oP4RBSNEYbxwfHltFDn6JRyc9n2hxVMjp2Sv
 cl4X8chNvwoMacUQm7Jkd4hnlSqpwZgNkOXLscdWnobtICtymzuFX+W6CKm/g5QvZ67j
 sVJVi+okGPCyjy+q1eLD3BS4gPrZLBg+dtcllcVdjLX5qE2JkY9wDqrtFYUyk0pG6jd9
 PPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729791490; x=1730396290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/HCkA72Al+fLXp2aws/gCeHnzhsyDnDthCWS7L8A744=;
 b=Nf9wJO2UBYG9+VL+pqoW2AW7tD9sY0GFUE3IcNDwHuiecpJWYhOZnXwF+rGm8ghc1t
 8h9RfwdZNw0obEl/8HxrHS5bYbm9VngsgmuHGUy52SZqE9+dFO8Cw1zs9cSQjGTyfHg2
 gybe3SRzaVfbKaVJGJCva6ZPaa7+ypeKd8wcWvicUOggjD2RnXZl+5iFRLhBlKlRtWh2
 G8TKpuBVaRXp9rLN11nrybAePH+Tez1iNKunKd8r7CtrKnCQnx5eIKmk1ruJygRoVMNO
 Kzv2IawqVa2CawVgoqg9qkBPaz8yjoS8k4q4jTpiUDiA8kf2xXSINWIe8dpfLuNv2hnx
 BWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2uA7VApJVMTlsWFbs9ZZt2j7/qyuS4fhT+EAIs1L18BBMFB7FNVRTOmHoSzwIa/l3ixJP65apJPd1@nongnu.org
X-Gm-Message-State: AOJu0YwxYts1JREYZ3q/AJtruNiQ7k1oDWZTgNQfIyxWW4MMmnhEQGnL
 LQiy0n8PERbQt+l0Ep1t0eoJBiZNGQ3LlRZObkvbUu8XIZrYaC5u6YaOQSEB/XI=
X-Google-Smtp-Source: AGHT+IGK6gaqL43vWCwzDSJc5KN0PIvvTEaAcApOEKd7z10jrdWecDMqb+OzBbENK93g+8/u8AChYg==
X-Received: by 2002:a05:6a00:1804:b0:71e:792b:4517 with SMTP id
 d2e1a72fcca58-72045e78207mr3588873b3a.14.1729791489821; 
 Thu, 24 Oct 2024 10:38:09 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d7462sm8250653b3a.109.2024.10.24.10.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:38:09 -0700 (PDT)
Message-ID: <aa4caeed-275b-459c-a244-bf3835f48227@linaro.org>
Date: Thu, 24 Oct 2024 14:38:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Add a test for sh4eb
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Magnus Damm <magnus.damm@gmail.com>
References: <20241024082735.42324-1-thuth@redhat.com>
 <20241024082735.42324-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241024082735.42324-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 24/10/24 05:27, Thomas Huth wrote:
> Now that we are aware of binaries that are available for sh4eb,
> we should make sure that there are no regressions with this
> target and test it regularly in our CI.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build       |  3 +++
>   tests/functional/test_sh4eb_r2d.py | 33 ++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100755 tests/functional/test_sh4eb_r2d.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


