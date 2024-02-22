Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5839DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd6UP-0005gI-SB; Thu, 22 Feb 2024 05:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6UN-0005ft-Jp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:39:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6UL-0005j9-KT
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:39:39 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4128cfb6c1aso1230825e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708598376; x=1709203176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5pxAELprgtTCX3cSuzh+GnotpXByZskl+q67h0DuRU=;
 b=uNc7n6DkhjbrF64SZXcHNGkpnXsnutEZP7rgV7p2trhT/rwZb+ayZQuG2wIkcJTnow
 LzMkrhMvA9NqmdaZs4j7igOxK5COuk6t0XnDPTPjS2fyn8CemA1a/2QsaT+UTyjPbeDu
 OSjAMgWP0kDKa8aJDc85odijDW6q/PD0vpvn5KakTM0R1RdE3AgcEJTvD70wrZbNDZUu
 fOePaEMDaGHzOJf5cNLPgycA2+nIw8jkR/Qy4jHrZbV/A6I2kwyn+vLx2wvYWsGVzZUR
 2Gyr1TxnB4WleKpveASRAD6XaHUAhTHwzgTF6YDuhcKujTk31yVGYGEnoanlbXX4zhvE
 QOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708598376; x=1709203176;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m5pxAELprgtTCX3cSuzh+GnotpXByZskl+q67h0DuRU=;
 b=vDuAlcSofWUYJRarxKalmfhtdz10lF3W4yS2A+HNpTe6/b1VYZgkS85sU7R00GJ4Aq
 +EMA/h4PYZAyxNNutbOc89Nup8SYcbUGr4HYtbXtz4U07R0MfdBpzhDEzvylvtB0zCPf
 GKZJWI4k6NIBdcqO2whFIFBmWCtvssHsjNHUUSdvr3uksxgnL769+1c1xvwPfs4+EqqE
 g6eWhIW74LADhJ/gbCCVGy64S10Q0gt/h3FDY4x+xrodYXg47s6NxXdDT0J1m7bjOWT8
 +f5nb4DKLIt3Wte4/fbK38vrc1VRGAFr3gemPldnS1cvnu6INZ8kfZrfui9BS0brlh/Z
 lMqA==
X-Gm-Message-State: AOJu0YwmM7NJ/JkEFag6Y3eX7rZx/+WDXPTZoE0+goRhPpGxm56uL6FZ
 UIPaYpPsibOZWM4K2DxopMhfdZz1wURIt8a1r7MBiTVgJF3SOqsZmZWGG0EdRwd1Cqg7OAi6/4G
 4
X-Google-Smtp-Source: AGHT+IFP0nenBA9wdqN779ZP4AamiElcQGWHfgTdOAep1KLBZxAaeEjBwnjmTaLE+cHT9Tg3kP41Zw==
X-Received: by 2002:a05:600c:4f4d:b0:412:52bd:5632 with SMTP id
 m13-20020a05600c4f4d00b0041252bd5632mr1588070wmq.20.1708598375794; 
 Thu, 22 Feb 2024 02:39:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600010ce00b0033d06dfcf84sm19752104wrx.100.2024.02.22.02.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 02:39:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1BE495F89B;
 Thu, 22 Feb 2024 10:39:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: RR NN <rnn59437@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Support Android hypervisors
In-Reply-To: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
 (RR NN's message of "Thu, 22 Feb 2024 09:07:54 +0330")
References: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 22 Feb 2024 10:39:35 +0000
Message-ID: <877ciwail4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

RR NN <rnn59437@gmail.com> writes:

> Android Virtualization Framework (AVF) supports "KVM(pKVM)"

Does the user-space API change for pKVM? As far as I'm aware the
userspace API is the same.

> also Qualcomm's "Gunyah"

Feel free to review:

  https://patchew.org/QEMU/20240109090039.1636383-1-quic._5Fsvaddagi@quicin=
c.com/

> and MediaTek's "GenieZone" as
> the hypervisor. Please Add these hypervisors to QEMU.

Generally the QEMU community hasn't the bandwidth to implement every
requested feature so we rely on those with an interest to step forward
and work on the code.

That said it doesn't look like the kernel side of UAPI is anywhere close
to getting merged:

  https://lore.kernel.org/lkml/20240129083302.26044-1-yi-de.wu@mediatek.com/

I should also note that proprietary hypervisors locked to specific SoC's
make it even more challenging for open source developers to work on it.
I for one wouldn't want to try and get a hypervisor working if I
couldn't see the code and get it up and running under QEMU's emulation.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

