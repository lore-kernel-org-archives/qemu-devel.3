Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E9C54EFC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 10:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woICq-0000Cz-Ri; Mon, 27 Jul 2026 06:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woICp-0000Cb-L3
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:05:07 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woICo-0006GU-32
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 06:05:07 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-664b05d408bso1927473d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 03:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785146704; cv=none;
 d=google.com; s=arc-20260327;
 b=Aqeu1CPLOaSI/UCriNM7VHoCatiZFA7WjU1rLIxiownORij4iovLSA7Skc+85pZzyq
 nw1QlYelzjGwjJyUqPltSzeFZzMlmhIwPSIFCJp4YLmsCMPHllqbqMKP5zBFPU3yuZYV
 y9LHcVlNnQpIIeKiSdZIKBKiAdLXm0+MMpP5Pb1HjdQKfwqrk6PIRqau0Msf1AYUs0lZ
 7PSrMi3kEFkXcn1yt8ww7Xd80X6u3E0pkAfIRnnr0HmLdbh6pK7XKDHxNPG7kopn8Vd9
 OQvb+xGQhTdogMojjXfobPuXvmUI7GX5p4QVWwKe9ysDZ2bXPwe1oZla/fbrMFcs3VNo
 BUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mzk1OFpsPkIMuuBU6ZG6dN6///TBASQuFccmd8wYFlM=;
 fh=q6gO72aZZuonrr2QqRsVLQkOu9+GhpRhRZHUKJhb7ho=;
 b=UOKWiEqISaR9e+RBPPVv48VzQntH1Op/zlTf/71jB/vV2ZztPhFsHpjNTnUTzy2Roz
 1zuiIwJ/4/rAwkxdRoJ/HZqqqPCFNJIs8kY65v7hIAxFTO05MQMkPsTdxZGyGW3kEHu0
 jUoecinHKYfMPFH/WFsB4f7NjTotVss6BOrkdECVD+JMdZO5SNlPgDdqGyaKo1HeBGyv
 KHaz9cpdzlSNA/q3GFCWrasiJoxjD7PcE8CNTRWXAChKJNK7TBp3rmdl6k6KHFb/JKXi
 2/OmX1Lk1OqTBRLzAMEAy6CUa/eauSSVrPLvGtkMg3KTRRvrmyWQxuAc2ilZBdUjCFlu
 AUyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785146704; x=1785751504; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mzk1OFpsPkIMuuBU6ZG6dN6///TBASQuFccmd8wYFlM=;
 b=yXuZSd0u7VBCJmhxzayqVw4gHuvC3w3plGmita8oNdHeKv8fBMZ3T1IzroAW1wOYGh
 My10t49K9j2pE0Cpb/qpfvoJ6NPxeSrvMIN6xiJaug7haOMHp5fG1BS/fkNqSz0vJ4GZ
 +wGq2+9CC9FNkiKc0fcOgEAlgr25q/zj85WUJRJwFUMbi7W3OeU+LIr4rzhjtAl8Hffo
 TezdeEpliKYgsIYKQdqz19w63GnD8az76x5bq7lzRLLijyeCShuegWSm6iE0TtRXGUl/
 cNFgnMUstfB/K+mRTFBeBx/lqXOwwUqaEdFP/+a++aS3jmDaK3VG8+B5Vd6KGb+csxGC
 OPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146704; x=1785751504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mzk1OFpsPkIMuuBU6ZG6dN6///TBASQuFccmd8wYFlM=;
 b=UMhPoOP8giUmCjEV2hpt0qe6Y+5GCDvVenWhkI9+8Bix4gmSkBIubsfq4ECra7osoJ
 ma7sdkiB9yoOqZtVBStvNL/b55zvJbrLknyf7kXOWAoHR/hZa9u1BXL+qCV/p4147RT+
 Tcw5sL+8+nJrDpuWEzBxIdzbFvJMAXoJWbq8oZwIa1vaPI31KJWgiNUlOU9UNsw4svCt
 nnMlUj7lijD4Cj/q4i/PBivUuoiqQh1NXkyFSVh1svd9fjTfmwSW1AMFMSGY74NcLO3L
 3IfIUtbApmQpPxwlvQvFweHqvjs6+mzaoq3GR1E1+wwJ8ThF3Exyla+DDXTq0+v8WYdv
 EWgA==
X-Gm-Message-State: AOJu0YwVjwaC46og6B+SW8TgIVDV7nYWAZuEMbkzKed1/+L4I+7NhuBQ
 7r5K7U4YHYyWIYfxwB4xb2jB9wX5358bXatMS0aDLqbL+X+P1IT3JV1kyLYF5DI1D7tw+2EtCC5
 UmBIn4sealV+rC6ZaJw9eAvl6IGKLLJgR6/YoGKqGwQ==
X-Gm-Gg: AR+sD12ymfN6Hju1zJk0KNlUV1ukuDk0YwWMg1ZCIJQYwFhgwN6Tv6UZNedLMw0VSbh
 ekBXtj6RdagGp9HsoxkYs+IhV98KcvgOvKnffH8kJ3Kfxgi3WE7DLQ6FNqjw08i++q+3pK/xhjn
 mJjxkVcflNIKAemgYb9dounAcD1naHeP8QgyhNZ5qLulfIP5dC214rSDnJvtSwnXKejYAMF+hif
 g9YtLrh5S8/w3pB0Z/7K5f8ydTUw7rCOwSaVjgCFmR0vqAgNdylZaRNimFbcVghBITwjJe4GLjE
 lXax9tlM9xsPlvqiqs1v57evfmikAoU6ZVBFyBsgErI0wA==
X-Received: by 2002:a05:690e:158f:10b0:668:9b2a:3f1 with SMTP id
 956f58d0204a3-668c7cb9e15mr1587486d50.107.1785146704413; Mon, 27 Jul 2026
 03:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
In-Reply-To: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 11:04:52 +0100
X-Gm-Features: AUfX_mw0bvpRXxcQLiKs-ag9eUHn01oMQV0PoPhBGsrxZhawTxtJes092BCM1_Y
Message-ID: <CAFEAcA-q5ihYpgYtEosQ3+SgbMdw7e7=xk4motLFL-A==g1k0w@mail.gmail.com>
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
To: botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, qemu-arm@nongnu.org, 
 sef1548@gmail.com, botszhuang <22925483+botszhuang@users.noreply.github.com>, 
 botszhuang <botszhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 24 Jul 2026 at 13:51, botszhuang <huang.botsz@gmail.com> wrote:
>
> hw/i2c/bcm2835_i2c: Correct CLKT register offset
>
> The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C controller is actually located at offset 0x1c, not 0x20.
>
> The previous incorrect value caused the guest OS to read from and write to the wrong memory address when configuring the I2C timeout, which could lead to unexpected controller behavior.
>
> Update the BCM2835_I2C_CLKT macro to match the hardware specification.

Checking the datasheet, this is definitely the wrong value,
so the fix is correct. I'm a bit confused by your commit message,
though. The value here in QEMU can't cause the guest OS to write
to the wrong memory address, because the guest OS doesn't ever
see what we have defined here. It has the offset hardcoded into
its own source code.

It looks to me like the effect of getting this wrong is that when
the guest writes to CLKT (at its actual 0x1c offset) we will log
a guest error and give read-as-zero behaviour. That's not correct,
but I expect for most guest OSes it'll be pretty harmless because
the guest probably doesn't write the value it wants to configure
and then read it back to check. (QEMU ignores the value written
anyway.)

I've applied this to target-arm.next.

thanks
-- PMM

