Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECF1D715EC
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 14:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjef8-0002r7-Eg; Sat, 24 Jan 2026 09:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjef0-0002pk-0F
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 09:30:47 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjeey-0001bC-Fi
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 09:30:45 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79420190633so30418147b3.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 06:30:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769265042; cv=none;
 d=google.com; s=arc-20240605;
 b=hzkd4OdahSbzXZEWT73vj5Du6KgUeYJMGwViSQ2StA+n23DN8hbo/xOTh1FYps0cbc
 W3PPTuEPexCOVBSRXfFPiowV10xSC6xoSKqI5E+bS0QD/D/kO9rx1p6NiF1CA4dgo2LD
 B4kgIMqmSRKrI7gWRn78ICzjvd1hUX5z7i+ZbGRN2yXsJaz21phdsqKm92JYJr3MblVW
 m6cP3eNuxJebNQaLYEj3UYiMhqy6Rt2FVGbwxmmZL4d9rYQA4kfbu0y7jl3yEBE5+LW1
 8tMf0SmhquS521ycKVyxDTfhm1OyydDrf+91gwsPWvNb4pDyiIijnAff2hDVaAuhB4iJ
 rurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DhJ/UdAQLCRU+RscUv9toppMvl7eN/qqmC7TQ5GfHHw=;
 fh=ZydQy//n0U/S7R2L18eAX372JrTfha8Z683DjmYt4Jw=;
 b=XGIZIedJvnVLIyhm7Zwbr0hqysgFlMMLH6yGkRgzOFhAhnWyWIuqqsE72ad6jRnDWK
 +e/6R+cmRzdrCPHnBhuJfcIh7OcL3zsGjJYmLuu5xnVwrkVFDadEMC1fWluiR8sFBjC1
 GbJB/9ggjhCXOHMRPpC8nVdUSxVy/7vkTzzvPU8c0BLj+nSoCqUnLAJFYzLcwDwt3YdF
 OQBpWFYBJ9HBacgFISimygpct7ff7bwd2992lCHqEVq6dmrSMa6RhMQ01aC3mIc/O6Av
 0moYU3Rcc+hTVf4cfqoM343G0YW39auFy1tLNLsEkBXpSWrjtYAdXANb+0QIC6tGnOqL
 Ovkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769265042; x=1769869842; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DhJ/UdAQLCRU+RscUv9toppMvl7eN/qqmC7TQ5GfHHw=;
 b=Eo7KcugyUPJhweHg44WMqQPdFK7O/NxPu0OtmzKX/6IW1Ao1H+TUpwpEIauzbZMowx
 LMtxppmvT3n/DIV+9fxrCLatt4R1e4Du3QPQvxMeki7BZO94/k+MwGzjcSjq1cnBVGT6
 jGgPz/zoAlyjnr0WcZCQPiI8l8qha6JseY9ZZju+Q8fXIdRl0t83nwiupS5MHLallGXv
 K6/6JqM5E95/d2JfmnFBD2Dk/rFVdZmmuSTJmz69TVfMfUb4VFMkTmlgx7SB7FWUdM5e
 NJ4Raj7rxakGS3gcjPHvZF8SBov2h0lOQ0kvtusPMpp6Em0Cs94KiUc7ZjJztYTF+dFV
 alPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769265042; x=1769869842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhJ/UdAQLCRU+RscUv9toppMvl7eN/qqmC7TQ5GfHHw=;
 b=dYR0gcK3byZrGSg7O1CIQAX4Pm3j8DzGbeWhODfxjBPpkV2P4TzCxb3oRNCn/6K9Qa
 JI/eg1jX5VCB2AXCg6sEF7kH5O54BGVS1g2z17VQOddd0MzLhhFdTtwjLbA2bSM7Duvc
 lT1BJ3pAVMuWEdlmUvq+D05NS7SXptFaYUd3auQIN2DPiBeRbbu9MQrXnKCulVh5AOWG
 oMqNwPA7knF4mDmWtVfeH4XI6k8+PE7LC+tN7tC+2YvCxQYcK1sl9gdztUB7yyLabqoL
 bALfMl9kUiTgGy9e6daWh7tKh2MbTXmGMh7K3ajgA7/X6sYOSnh3NHYLC1Nd0j5uoJgb
 HzpQ==
X-Gm-Message-State: AOJu0Yz3ijsZ4v1Ac8mJrnE2BEktFhJ/fCIHMLpbm6Cme0SzMnTTWWH8
 3K7pqoc46u99kgp0rjtPCTMT9EIN78zXpWIe500PB0Rl27FUpG5VRbtqWA1y2kF/uiY0kEk0UHN
 kMEaQzLj0Nb43p6/IDcvZSpt28m6DEH0IagyUKpDmMw==
X-Gm-Gg: AZuq6aLZzk+WHZ68ZN90rpe119hJwLS+rILFjLtxOJzQfs5ngYf2M3OIA9wDODNXqCF
 cOCSkFBxi0dpDR4RGosKShKFiqn51J2ZX4eYntT7TrW3Y3ABvD2MiNBwTP0S5xCPbQqADhtJnS0
 DVkWWJWa0vrHF9ITw7pIdtHAoGkKS9X8qT8nqo2kTE4W60w2a4JUpB6MmVfAy38RCOGrxo9gmMF
 8Q/PiuuLnW8dOYcazeVNNiXttgPoRtu627HW2KhUeExX5LCfF1gJpYYWLYvkapPemPdrQ==
X-Received: by 2002:a05:690e:13c5:b0:644:402a:8d3b with SMTP id
 956f58d0204a3-6495bed2ec7mr5816189d50.10.1769265041940; Sat, 24 Jan 2026
 06:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20260124131537.78942-1-AlanoSong@163.com>
In-Reply-To: <20260124131537.78942-1-AlanoSong@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Jan 2026 14:30:30 +0000
X-Gm-Features: AZwV_QgCywjbwXj4LCpFuaqxYFa5HjDQhPJvVuhP7pkLrBc2H7kpyu6Pwe7hc8c
Message-ID: <CAFEAcA9=xMfeGzUZikdBmiqYU_VOow5+Efhg7g2fWeN-fjG0dw@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] hw/i2c/dw: Add DesignWare I2C controller emulator
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, crauer@google.com, joel@jms.id.au, 
 jonathan.cameron@huawei.com, philmd@linaro.org, ani@anisinha.ca, 
 cminyard@mvista.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sat, 24 Jan 2026 at 13:16, <AlanoSong@163.com> wrote:
>
> v1: Initial version:
>     1) Add DesignWare I2C controller according to DesignWare
>        I2C databook v2.01a.
>     2) Confirmed under v6.18 kernel driver.
>     3) The slave mode is not implemented, cause this feature
>        is usually not used.
>     4) The 10 bit slave address is not implemented, cause
>        this feature is usually not used, and not supported
>        by qemu I2C core bus currently.
> v2: Refine according to review comments:
>     1) Define registers by using registerfields.
>     2) Use SPDX license.
>     3) Confirmed under v6.18 kernel driver.
>
> ------
>
> This patch seems to be a duplicate of Joel & Chris's work:
> https://lore.kernel.org/qemu-devel/20260109123211.368869-1-joel@jms.id.au/
>
> It's just a coincidence, :)
> But it's okay even if it not been merged, I just want share it and hope
> it can help others.

Please can everybody who is interested in the designware i2c
model get together and figure out what they want to do as
a forward path for it?

I am not going to review any of these patches until you have
collectively determined which is the best base for doing it.

thanks
-- PMM

