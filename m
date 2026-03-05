Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDC9F3D332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC0D-00051p-Vh; Thu, 05 Mar 2026 11:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC09-000514-0W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:56:41 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyC06-0003LO-Mz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:56:40 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64caaacb9bcso7951907d50.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:56:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772729796; cv=none;
 d=google.com; s=arc-20240605;
 b=lTmi20w31WU6ciog9GKK3yK0HKS3TOOuVsZsg159T818K65UBmeNV6BIWbI/Lt2MXm
 W5DpSV9LbvjiOudb5OxBzFZ6BM2gu9L5+gtlwf9pNEkQ1Dw+sfK4EQvKmBR2K6buVVIC
 4l69qBtCGIOXWchfsgyGzlajVqkd5jaU1bVXxzVfU7C+u9O1Q/nJzS6Z0mS4ZlNMDGt2
 lTaRz6CYHafuMegW4MKOSOt4XdQGbuYeLtAkikZdALgW9byNKxbJPrbajW2IRu10L0sh
 IdYFAJutt5RkI0ad7Tfzt0VQ9sqQrklKaxQ0Gxvd1f0iHOMaFWTNIPFZIPDXCA1e4IQP
 oO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2xYrQAbt91GM0FfKNIKQLWtB+ANUec5LFD6Hk925IYM=;
 fh=/xakVGD2n2FDCL1IO59hU5yecVDHv+Y6YC8TaqIjnb8=;
 b=ALLJ4546zRaPTZ0LWQV9JD99I8RET93NDc725c+n0czdS5PlrVhax6ceKAjejLKtWG
 9mSbsLKfETCnszG2AbnFTHATDo1PJ66AlEHluHZGamynLh5izQ2JqhpCzftp7dD4Nu4q
 +npEJ44fjDo+vituYuOFF6QKOpIhoYFfpAX30y/BQyE4tmHnxct1hwQKmeN/Q1eKM55T
 x6N1qlCJ1tb9sMUBmjbQFuwK6atg8KgobZg8Cxja8B+A61pLGoc0vEplZrOdrgX/KT/R
 GAjMV9TIe5/7sxNZStykD6vd6blhpRQo/cxF+pdmJ8qjOMcGhnlbRZpCdxPOuJ847fMr
 pBBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772729796; x=1773334596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2xYrQAbt91GM0FfKNIKQLWtB+ANUec5LFD6Hk925IYM=;
 b=aJDifSMcZ8QI9n4gKtW0fm1SDaZIXO+vnqBzPghh25Z9kUnPsnPLn03Ir3jG2MAef8
 GRSMDNINbvzMESmwFGhpscC5IjCYO+84c8KvJ/oDkTBGRURCPnIvJ24KGlvpB2NY/SyM
 AS+HVlvTDpUOafQ12qE/u1yD0raiVG9JvDpW6cNFDeE25+3OAhBQLa7GA7ObNPMe+rL9
 PvNqnydZhhFkzVCmzyOoJMUxfDxSNmEw1GH1EhEtisTyxhz3qacOB9onu163J5fYiBqa
 bxzcXB2bE7l7dgWYQP3x173havgh4tNO3VzdG60n+LsbVsqwYQ5f2k7o3zNJ7WigZEmu
 kYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729796; x=1773334596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xYrQAbt91GM0FfKNIKQLWtB+ANUec5LFD6Hk925IYM=;
 b=HcnPeIslNumIOtcTJQPjAMUablMTwAx7BkaQRO1NSDgoojIQTWxmPW+/LdjzEiy7Vy
 aRDR65uIMHdu+e2484O7YaX7RZ8CpYA33I8Y411BVoI2l5gDnLOg6qXpUtTWx4AZ1l8y
 7+cCa0gw8nvgP6wqkVsvzM3FKI1xNvRAH4xlmti/FTRsloEp2hiKqvesLqSAM1Y41oi7
 SGR6cSznbFz2ItYlvPGdF24B6HP70+G28CAAT5Kc1FDXnPmLfCXnWyxRJNtmqGgpnUMJ
 KqVjrJV2PWZXlgX96/svJMp20jfHNjPXROWaLAp5jVQjhA4TR6QFyXBbCTFDw0fbxs4Q
 jkAA==
X-Gm-Message-State: AOJu0YyU2p2fL6aFJrn/0kNcWM0byiaAHYu0btq6Y7hzBSuWBu/4BF4u
 LlzKDJhzp4jcqfpaIjGJakJC0N3ain2Ga6G5wInYCX5BPU+F+L9BqYBmTcG1luyp7nbtXdCA0WH
 PjYNr3EbK+iN7Qzwx5EDUsy/UhRoGS7Uy+mSsytiuQy15tEAtRMPX
X-Gm-Gg: ATEYQzwgneiT2JL7s6TLUhcKZyp2u40y7zyYt+C0lt3IlqGVPxZbQyJHMIZNyQuiaDE
 fzkZzVl7dpuaoI8FE85bhbpgU1wPAa6+ZpNfs9YLf3rZ3LrWuYLzS9YlwT8OdPr2K5X5QnIEJcg
 i3+e38FdYIvlkxXaDShstgnv0BJ9G6r8MLgo8w9GCvi8DYAWpvewFqjjFXXs/BxMab3qF2IzmtO
 1AczCeZgCCoD0kCUbjleEI0HcHBpNkfRKdoGrdWh7u0iCrfPNN2XSXf57R1+D+Pm2vMMfs2/+QW
 hMfJxVYdyLMgdrsD6FzOTQKtsnDkFPzx/9BRV25LceBwDBi+QFjzJQu4ehOCjpGK29k=
X-Received: by 2002:a53:b44b:0:b0:64c:9ec3:d70f with SMTP id
 956f58d0204a3-64cf9ffb47cmr4036401d50.71.1772729796066; Thu, 05 Mar 2026
 08:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20260303005101.3561064-1-gaosong@loongson.cn>
In-Reply-To: <20260303005101.3561064-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 16:56:24 +0000
X-Gm-Features: AaiRm52uodG27-yQ06LgI_ureryaoiknCHCbN_BFj0EhZie6bYyaZe8FfZzvo_M
Message-ID: <CAFEAcA-JjgoDgNMaTPGpk9HNo=smVxKZH7Jn34712==TKM-Qvg@mail.gmail.com>
Subject: Re: [PULL 0/8] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Tue, 3 Mar 2026 at 01:17, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit ffcf1a7981793973ffbd8100a7c3c6042d02ae23:
>
>   Merge tag 'pull-11.0-testing-updates-270226-2' of https://gitlab.com/stsquad/qemu into staging (2026-02-28 14:30:23 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260302
>
> for you to fetch changes up to 45e3ef638e73799815a07a31041afe162d856dc3:
>
>   target/loongarch: Add some CPUCFG bits with host CPU model (2026-03-02 18:02:38 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20260302
>
> ----------------------------------------------------------------
> Bibo Mao (8):
>       target/loongarch: Add missing vCPU features with QMP method
>       target/loongarch: Add full type support with query-cpu-model-expansion
>       target/loongarch: Add property set with query-cpu-model-expansion
>       target/loongarch: Add detailed information with CPU Product ID
>       target/loongarch: Add default cpucfg3 with LA464 CPU
>       target/loongarch: Add generic CPU model information
>       target/loongarch: Add host CPU model in kvm mode
>       target/loongarch: Add some CPUCFG bits with host CPU model



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

