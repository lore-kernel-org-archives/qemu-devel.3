Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F830C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiDe-0000Ek-T0; Fri, 05 Jul 2024 08:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiDa-0000D6-9O
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:39:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiDY-0003rt-Ay
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:39:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so1066345f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720183150; x=1720787950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f1LKp34FYELTp/+mAMc133AHvjK9bpe4E1qnRAwwCVM=;
 b=qwXhiMmXLG/P03yGn3dCX1n81pIveEwBpT3MRap/f76U8RfWoEA1w5y20bR4KPBMgg
 ixQgGUPFyUD1/f7X1aH7MKxSx4TcEFkOyYsMlysGbUKJBVo06GJ+CszhhEo7TXiLHZeh
 4fPCBMjVNstbMHu9SLeW3zA81pp95H2hhkOw/0p01NXXmaDIL8JaH5ozcQhXLVoDctGk
 QR5BijZkNJ8KlQhHaptQ2uvacYDwoUUm74iJ4vQuuBA6+x9+q/gYq59iSf+SEKWCGR86
 ZQznoaQcVhJ9tngFoPez5IUWUC2WC8yNAYU05J3Ka8tLnhFstus9iybgMdN+0CHqo9dS
 rl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720183150; x=1720787950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1LKp34FYELTp/+mAMc133AHvjK9bpe4E1qnRAwwCVM=;
 b=E2kbBUWsv9uHCpCWNSOGwszpdfTixu8Ypf7JEdlXtyVoloJo/zuy+0f1IFXQAkw6tc
 G0/QMEByfnKDCNbAVNUvEP6sTe/zTDDiPwWC2UkckftTM/WOFgDpPi9aB5OpmN7Zp9ro
 94MKgzGjw16LPOOb27MGsnBSQPkXtV2SuiIgSl5mWeFbfjuC0Mr3fnzxjsa5/5KWFzO+
 c0xERpU3W6l8qnjLeJPzWpy/6CiuZ2pNZ+Wqvf/XKILH8r6v+fAcSBrwOOGc046vsAps
 1Se17015KcZc2tPaO5z1HmNyJTG06Y6xXKdJtGDjMHcj7ulm6pjjqDIKjsSLfjWVobm6
 Y9/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXf1+nXldGSr5uS7wMhmiovlBAVBPQ7PHU2Ou1RceiGJAvm0hvQKwgH6z5CvgVqUxcZBvc1RF1DsJSGU/E2lxRoeSosl4=
X-Gm-Message-State: AOJu0YzArh6YH6t4u1Ew4yaoscoQIFq9QcOktS1dDONx2CcDVN9VuK3p
 PxE8aWmlBFXabGfaa+BEkYi+lW3vbktcE8p8C0QkFheSpI7AWbHiqks1kehloDA=
X-Google-Smtp-Source: AGHT+IEZELc3jACuwRHMdLRc/9v9Nin523Qmz0/qNqvfIYMrTlPCpi4jbgoYh7r2ZzL1gdSI4g7+AQ==
X-Received: by 2002:a5d:56c5:0:b0:363:7788:b975 with SMTP id
 ffacd0b85a97d-3679dd67d08mr3758781f8f.52.1720183150269; 
 Fri, 05 Jul 2024 05:39:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3679aa0edccsm4381041f8f.60.2024.07.05.05.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 05:39:09 -0700 (PDT)
Message-ID: <73a0498e-8f66-46ff-a4f2-fcb6b80f9d42@linaro.org>
Date: Fri, 5 Jul 2024 14:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Enable the device aliases for or1k, too
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
References: <20240705090808.1305765-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240705090808.1305765-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/7/24 11:08, Thomas Huth wrote:
> Now that we've got a "virt" machine for or1k that supports PCI, too,
> we can also enable the virtio device aliases like we do on other
> similar platforms. This will e.g. help to run the iotests with
> qemu-system-or1k later.

Indeed, since 2022 in commit 40fef82c4e ("hw/openrisc:
Add PCI bus support to virt").

> 
> While we're at it, sort QEMU_ARCH_LOONGARCH alphabetically into
> the list.

Suggestion: a preliminary patch sorting 1 arch per line ;)

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/qdev-monitor.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


