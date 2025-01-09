Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218D7E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVpy6-0003FQ-WF; Thu, 09 Jan 2025 05:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVpy1-0003ED-Bf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:40:45 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVpxx-0006QL-8j
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:40:44 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa6c0dbce1fso111421666b.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736419238; x=1737024038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNY9UDW3SddgF1XxwN+STkrhkBMltkGqpGwuospRT1U=;
 b=qEazp6DiUiMn+wsKsUWq7siPw2V9s15WtxBmohn55GLblAuiVURMpg1uOIicm2NAI/
 pHj59KVJX1MFu96B/23egFKEUDB7N95zvrkOqMBGKx6hfj1jDChOihSvUzAa9UukFuOE
 /+D1+zAKK8ZwIJjXZDpQ+bUcYWzwL2nwismVjjqC1nPZEeM4LHU7UDzbCf0g6TnA9BRx
 h7klD03echyq6fquTN/5JZ7LB4k/YyvYVcHtJCu6NE0MINVf0ZvEIF5B4MH8FXilypCx
 G916i+i3w2G1FOj0+cy3S5nBAbaff0OT7S3wpIjF+ruaW+lxl32SvXykmCW+uxG7Yc3s
 e2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736419238; x=1737024038;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNY9UDW3SddgF1XxwN+STkrhkBMltkGqpGwuospRT1U=;
 b=S3d88H7GxwvNqKDexChg4MHVssG9cyK4M8xTeJT6sdCA2pQfQaFS0Z63piDLUBmWVW
 DanuvKffCw7cHNxxsQtWNoyqm8amvUAzB/71o3nN0w+tvX/Qt59Z3ny2z2uTjnU7KmBX
 snSxUK7HAIWN9baRQd95oBe5oIxJdmbiyPWlIJ4GwSyvAf6oyALe0Z7ius8/R516Zet/
 Kt0YXmBBluShDXpYtb2AN0V37SKCm4qRytXxW8+ETJhPRfpKU+NUcJfuj9Ozte3+c+eG
 q3u1B8kGyLgJ55cTju/fIThIEepyM4XQUiw6DAfdNweH1J8cDt1jWhIPU//itz04qtFz
 M/MQ==
X-Gm-Message-State: AOJu0Yy9Iqg5R9LKuePdC8L9+GrHCmZyIa2mDx//pgbHBC582Tgas22g
 L40RNFCLuaoZUhvDLZCFKu7rZSbjRwCavVsPSlE07ArvW+8OMTMo+ZzyCbPt0BQ=
X-Gm-Gg: ASbGncvd6JXtqMfkSj9LKz6yeMz5GxHJZkHRlWPyfXTN0fmyyKDV4VNjCvh8Ct5zUCe
 nRXbNs9JfxM0QHtlO+ailaNOaODI+f82Mmx+R8caUoDTPgm+vja8ZQwdO2X0qMftVbkCQpwY6bw
 72vBjE9Q/sXbnJnDbtcdKwtoG4x773t4ocLjEAXBt2VzDExwLuUTeSSOv7VutRy12Ec3jymt2JF
 RDSFRQ5GWGpZa5JjbTQdSzHjdW21rZr9dIuXpBjJVycMvx29ov3kmc=
X-Google-Smtp-Source: AGHT+IF89mXwXzaZzGvlrUkSCriVSFrH0a80X8csuICcvWdEiNZOYWfFZj2lv1rDbw/QLFR2dZSnbQ==
X-Received: by 2002:a05:6402:520d:b0:5d9:ae5:8318 with SMTP id
 4fb4d7f45d1cf-5d972e1da12mr13600948a12.20.1736419238435; 
 Thu, 09 Jan 2025 02:40:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af424sm58054466b.137.2025.01.09.02.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 02:40:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6DD565F87E;
 Thu,  9 Jan 2025 10:40:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,  Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/5] target/arm: implement SEL2 physical and virtual
 timers
In-Reply-To: <20241218181511.3575613-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 18 Dec 2024 18:15:06 +0000")
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 10:40:36 +0000
Message-ID: <87cygw9snv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Follow Peter's review I've split this into a several patches as there
> are some other fixes that should be made to other EL2 times that
> shouldn't be rolled together.
>
> v2
>   - split machine enabling into patches
>   - rename IRQ
>   - use CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases
>
> v1
>   - improve GTIMER docs
>   - fix gt_recalc bug
>   - address review comments for the main patch
>   - cc qemu-stable (no rush for 9.2.0)
>
> The following still need review:
>
>   hw/arm: enable secure EL2 timers for sbsa machine
>   hw/arm: enable secure EL2 timers for virt machine
>   target/arm: implement SEL2 physical and virtual timers
>   target/arm: ensure cntvoff_el2 also used for EL2 virt timer

Gentle ping - I think everything is ready for merging.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

