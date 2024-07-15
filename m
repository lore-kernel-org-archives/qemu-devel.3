Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE78C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHTc-0007nN-G7; Mon, 15 Jul 2024 04:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sTHTa-0007gA-GA
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:54:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sTHTM-0005Mf-UW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:54:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fb3cf78fcaso27707765ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721033654; x=1721638454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHntyS8Bl+V6jyChnRVxLkBaG1KNp5GLTw7JtNq6Qso=;
 b=mU3apMJ8x3GywVvMSkmrjgVGLUdnUmQO5dRCs3qlHU6eesrmK8wok2rVwDlmFnlNch
 LgQcljUPaRNbs/AInVjEw7v0eXPlyTELfQy1MbqCgPvB3ipU+DH0WgmnYk4zurlPdNAI
 gnIPudMI72aYGts8LCXdT9DZ4J3lyxtLIqQh8VwAIAEbyg8jnTlsn2jleCR3hbKn9Ado
 28Ww45uUgZoHlNHt7SVJJaAps1w9hwut9zeUsFUlKo8PG3PhbHFxl5M6476QxRC4S4Tg
 DL08EQBuSOezWRdZRhBAVm20Uhtyl5ofGVZoE3mo0LeUlfPnJVqX5jVnftZLdpxxq5+7
 WE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033654; x=1721638454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHntyS8Bl+V6jyChnRVxLkBaG1KNp5GLTw7JtNq6Qso=;
 b=lvRq6GJXlRQSYBSoKcs97nKpWkReFRVx/ImnAzOANLlm4AtcRTZ4aVuPI9+Rn72qBo
 RQuZqjlh7pMXrslVzw0MeSzr8ns0suzJkDtQvSfgIrALhanRkJWGjCPy47zQhhiG5AK4
 lzKRDzB8kqEOZMWvjIqcK0upSVvhPiHU8saOv91ocOHVHWK1cwsAmCH0Vv5yoUhgfvE/
 HIddbwYHv1YdLvfZ7uqopx6XU6uLTcYkN3bjbWlHsFlD7Ru+ZBPvpfY0MWgc+Z0Qob04
 Ee3Vra4M25JlZUcgufXrTb/jBnsSyR1dbPYKyxFPOC/sg0hCOi36xkstTn0U2k8xXwZt
 bbjw==
X-Gm-Message-State: AOJu0YyzvnMnqcUf41/0nPl0t6jKFmFXfT0S23289jwvRRpVS4AFmHfI
 BkUCMx3ZT2Ll6fz6LmXYFxwWCxRRFphFaiPeOZjfCgL7TKTzrRpoPOCCwUfRo1M=
X-Google-Smtp-Source: AGHT+IE8HxN8mfq/VWXMTsyQMq5fiuVRB1clDQlDoeBFfl4TH29yYhSQ+su6/tUhlugQgdYX3bvjgA==
X-Received: by 2002:a17:902:d48d:b0:1fb:4fa4:d20 with SMTP id
 d9443c01a7336-1fbb6d59ed0mr199157815ad.38.1721033654321; 
 Mon, 15 Jul 2024 01:54:14 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc6027bsm35746325ad.305.2024.07.15.01.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 01:54:13 -0700 (PDT)
Message-ID: <53bfd9c7-432d-425d-b911-818305bc0c48@ventanamicro.com>
Date: Mon, 15 Jul 2024 05:54:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt.c: re-insert and deprecate 'riscv, delegate'
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, Anup Patel <apatel@ventanamicro.com>
References: <20240713174325.107685-1-dbarboza@ventanamicro.com>
 <20240713-wreckage-humid-79c9acd37542@spud>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240713-wreckage-humid-79c9acd37542@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



On 7/13/24 3:57 PM, Conor Dooley wrote:
> On Sat, Jul 13, 2024 at 02:43:25PM -0300, Daniel Henrique Barboza wrote:
>> Commit b1f1e9dcfa renamed 'riscv,delegate' to 'riscv,delegation' since
>> it is the correct name as per dt-bindings, and the absence of the
>> correct name will result in validation fails when dumping the dtb and
>> using dt-validate.
>>
>> But this change has a side-effect: every other firmware available that
>> is AIA capable is using 'riscv,delegate', and it will fault/misbehave if
>> this property isn't present. The property was added back in QEMU 7.0,
>> meaning we have 2 years of firmware development using the wrong
>> property.
>>
>> Re-introducing 'riscv,delegate' while keeping 'riscv,delegation' will
>> make current firmwares to keep booting with the 'virt' machine and
>> dt-validate won't complain about it since we're still using the expected
>> property 'riscv,delegation'. 'riscv,delegate' is then marked for future
>> deprecation and its use is being discouraged.
> 
> dt-validate /should/ complain about it - does yours not? It's probably a
> bug if it doesn't. Whether dt-validate complains or not here I don't
> think is relevant though, only the impact on firmware of removing it.

We'll keep the property as a temporary documented band-aid that we'll remove
a few releases from now. OpenSBI was also updated to use the right property
recently so we shouldn't have any problems.

Oh, and dt-validate will complain about it if we use the right command line that
creates the controller ... something that I failed to do in v1 :(  I'll re-send
the patch with an updated commit msg.


Thanks,

Daniel

> 

