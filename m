Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA470C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg6Ng-00083P-Km; Sat, 04 Jul 2026 15:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6Nc-00082X-6b
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:50:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wg6Na-0001JL-Lf
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 15:50:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c821a50615so13206475ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783194621; x=1783799421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f8AqneuYZKjvIhU4ShAc1IXfueCmz4SLPvUVKeW3lSk=;
 b=V2rlaSiLI3NGiwp/Sl6QoM0t5P8U4re0IBG5Zg3ISbMUUzbsKaWPiFqnlPcOQvsDhW
 scJbgbAHr3gwJuxmq+sUExBAW4jTJ3cUDZbFLe/bVyovRv4imJ7AWfVabOeM3aIiLeJU
 1OI9pnuReTbfphZG/DcO6vLERu9727UqWmYEQFfqH8t5QSCqvzZEtx4ZmgzzvFcK1qHC
 Q38KH/N6H4LArtHGwP5ex7zQeJOd7REKBLqlG87u0zpeUNbWs/b7uHI9pbw3C35Fn0fk
 whWnzn/FOwlB8yOzqyZ93FKBA5EWxcgcJGCn4lGkB1b2QdGGNCpnofT5JzJItKCMPzBK
 ujRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783194621; x=1783799421;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8AqneuYZKjvIhU4ShAc1IXfueCmz4SLPvUVKeW3lSk=;
 b=JF6OKER5GBf/mFvE+Ebj6FMJG02+Z+7ahQyrdBlGjS523fC3jQIscMQF9Ad6qTxDqT
 kL8XG5M+or3K5PZZ360xINwRZoXbAwmfhy0o6yRkRos5EfbKpMejib63b88k0aNxTku8
 klvIvL2bNO8OqbrF8YzzjUp/+bf8xgkBQNs2ypXlgRUqaSUpzdMqYf8eL3UUJooCKyLw
 g5zt99GA4vwxy7ZqDkCErAmfTh1phia+TaCEpJYDIjtrdozDe/eO8cerWWgaS24ngKfm
 wiFT2QDV4Rk2GxDE8/jrhqXAASaKRbAG/f3UfEcIx/GWBalg9RO4LiXPZacSqe/Ns+Sk
 CYKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEFlpXdDtiI17EgFaImDJMAoD//5Pi5InIat2ymTjqlwk+DNPi08Ww7ecNn+DtqeuRjwZGacxcmuL+@nongnu.org
X-Gm-Message-State: AOJu0YxLwk10+3KxVrnsV62FnKnO+R8Zo09vI9eVCFxw/0ONZ4xWVoOX
 YZ6L/Y3oG34FD5hzOKBU+U8WHWtiiy5eyWCjiPfSKG1eQwsoW7m+zBEPdWTMJAMMfcg=
X-Gm-Gg: AfdE7cmfxl69kJfh1NASUf7f94sMb4EoUXTaVuIz/qX8/t8BNXMGlKLY2zddel6ROtT
 1kbOF+2fDJ32wx96qCNuOVfYyTHmgFoCF/sh+raNKgAQNiLhRvbdSqYc4tgEJMXWNeyf6Pvapsr
 uq5hiAY4F1dMgEHWzH0c/icS5PhdOwKBYn4ZDK6lhnDiBgBoCzzUBiQRe2/1OaIoH5Cgx7VMVJI
 vt8ZCqTpa+9wCIGtQcWseQwINWQI1N9tF8qu9D2TDu80cRfUW+2285TQ/4WdpOyhcXMo1bAOkZu
 iQ66mRR9G9IIb35bwQlHYYwfHQGoJ9I+1ETWQ8PjgaWQONxcDad0SeBE9RHd81TU/ySXIpUj8XD
 0c9nSS1g8L5pzkNFSrsmm+kUbsLwRaCYXkA7bQJO+M2FopzAmja5gnEtJJ7ji2OXuNxkkjjRGDV
 qXvRj0mAvr8r4splBVY7xdA5/QzDPcvAXctmfJGXZR2+oX78vKlQbK61w=
X-Received: by 2002:a17:903:2f81:b0:2ca:1bbe:c3d0 with SMTP id
 d9443c01a7336-2cbb9f25511mr38055745ad.43.1783194620515; 
 Sat, 04 Jul 2026 12:50:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad7871697sm25975135ad.67.2026.07.04.12.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2026 12:50:19 -0700 (PDT)
Message-ID: <ce9c60c5-123a-4b02-bb9b-5415b8de1698@linaro.org>
Date: Sat, 4 Jul 2026 12:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/33] accel: Hold @can_reverse information in
 AccelGdbConfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-17-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260703163757.55500-17-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
> @@ -158,6 +158,7 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
>            * them occurring every time we single step.
>            */
>           as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
> +        as->gdbstub.can_reverse = true;
>       }

This is under replay_mode == NONE.

> -bool gdb_can_reverse(void)
> -{
> -    return replay_mode == REPLAY_MODE_PLAY;
> -}

This isn't.


r~

