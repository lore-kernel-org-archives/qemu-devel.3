Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDE9C4829D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 12:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZVU9-0005aM-LQ; Mon, 12 Feb 2024 07:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZVU8-0005a2-4c
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 07:32:32 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZVU6-0004qM-9g
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 07:32:31 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5610b9855a8so7045108a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 04:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707741148; x=1708345948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n5+OP/V+bXhIhPzeg7Q+fZwnwG9v8oGGXWdd6REyCoM=;
 b=uUQpgjqrnMmykiD49T3QFJJdJK5iUZVzJ4bALx0epwiAJvOoJtF+IWO0QRliBVima/
 9FxyBBtE8nMQfcG96BlvNNk7V1MNMUDozISZHbrH1aUyzZ/9xf5TgHfIewmtyTG1aqgV
 5J7KexkRhVG7g5mm+m4aHFmNI3XilcpSbOX6k9iEgSdnN4WTPwYzPoSj/UlHxKheeySW
 n5tpBunUVeDLVARJdxhiyziM/GADaPHICjoHUwat018FTI730SvfWeE3RY0tTGYV1Szb
 1I40eBDleoOzzW7aovUcyYTy7cuCJZUeIIdfTIOwitbatydcles8ArILHkyDyy26u7Qf
 n7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707741148; x=1708345948;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n5+OP/V+bXhIhPzeg7Q+fZwnwG9v8oGGXWdd6REyCoM=;
 b=fLjT4ade4oeK4Fojhz/ZuNwZMhAbVUxlHCTmzz4p0Ewg25wpiLQ0CfToNP679GPZm+
 eQamq+K9i9lJoUKvCFfSKBaJhn7dGuuGX8cnXatxi0VUaPjjS1nJVA7PSPJ1K34gADMn
 u8cmbuEv9td8GbZkleTuqLvO2OFn/XclI1B59XQKQksZdSWHZHLtdg8FRLVgwyeCbAt6
 lXGPePvMvg0l7sq2m4x9sT+0ITlaY2wp8xuK13bBFu2v1Owuk9mFiFNcNCYWD7FAXfTX
 Va2fbq1P4t5HpqoZyaz4SlpR9zxDC8GqLM0WWHYVd4INdOHc5SzOqMBXntIC4c/UO4H3
 Z+zw==
X-Gm-Message-State: AOJu0YzFiiR/kPilBFTv0TiXSGyHwbBIuQRjKmdaAlDEl+gxfwtIkYKl
 X1CB5bfia/0XPP9E5Z0wDpC4d7046GMYT/7gkYHmB1nxVqPcFMMsKhm/pAvtUr+/9Yk14wcdpvo
 pAhW1WqNF1YLJWIGTM/qYRB++JKIkJXiWvAgUVgnMdhgDtL40
X-Google-Smtp-Source: AGHT+IHAiuj+HYLpWLPJha/J79NmB4/L+NNjy37arnEgJJY/HRCcp07A/p68TyP3MDh1gbQ1IBsv3PkQC8BbTV8+H44=
X-Received: by 2002:a05:6402:35d2:b0:561:841f:ed03 with SMTP id
 z18-20020a05640235d200b00561841fed03mr5879014edc.14.1707741148266; Mon, 12
 Feb 2024 04:32:28 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 12:32:16 +0000
Message-ID: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
Subject: possible deprecation and removal of some old QEMU Arm machine types
 (pxa2xx, omap, sa1110)
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Guenter Roeck <linux@roeck-us.net>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QEMU includes some models of old Arm machine types which are
a bit problematic for us because:
 * they're written in a very old way that uses numerous APIs that we
   would like to get away from (eg they don't use qdev, they use
   qemu_system_reset_request(), they use vmstate_register(), etc)
 * they've been that way for a decade plus and nobody particularly has
   stepped up to try to modernise the code (beyond some occasional
   work here and there)
 * we often don't have test cases for them, which means that if we
   do try to do the necessary refactoring work on them we have no
   idea if they even still work at all afterwards

All these machine types are also of hardware that has largely passed
away into history and where I would not be surprised to find that
e.g. the Linux kernel support was never tested on real hardware
any more.

So I would like to explore whether we can deprecate-and-drop
some or all of them. This would let us delete the code entirely
rather than spending a long time trying to bring it up to scratch
for a probably very small to nonexistent userbase. The aim of this
email is to see if anybody is still using any of these and would be
upset if they went away. Reports of "I tried to use this machine
type and it's just broken" are also interesting as they would
strongly suggest that the machine has no real users and can be
removed.

The machines I have in mind are:

PXA2xx machines:

akita                Sharp SL-C1000 (Akita) PDA (PXA270)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
connex               Gumstix Connex (PXA255)
mainstone            Mainstone II (PXA27x)
spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
z2                   Zipit Z2 (PXA27x)

OMAP1 machines:

cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
sx1                  Siemens SX1 (OMAP310) V2
sx1-v1               Siemens SX1 (OMAP310) V1

OMAP2 machines:

n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)

The one SA1110 machine:

collie               Sharp SL-5500 (Collie) PDA (SA-1110)

Obviously if we can remove all the machines that used a given
SoC, that's much more effective than if we just delete one or two.

I don't have any test images for the SA1110 or OMAP1 machines,
so those are the ones I am most keen to be able to drop.
I do have test images for a few of the pxa2xx and the OMAP2 machines.

thanks
-- PMM

