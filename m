Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1CC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 18:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVyiH-0006ct-K3; Fri, 02 Feb 2024 13:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVyiG-0006cU-PR
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 13:56:32 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVyiF-0005gy-7N
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 13:56:32 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55ff4dbe6a8so1274439a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706900189; x=1707504989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvu6MmllqjtEsa66bGWbi7R/fQSWAWjf9fSY7mFH+Vs=;
 b=SPZNOeVmogH+yXK7sUeE2HdmIDqVAV4cCLMLm76LVKqD85nRiUY/z9mstjlc78aDcs
 +i9hcvye8hQgO3wYUWZAibGChBpWr1uQx1L/aXmQUmvjBPnCoBDZ9ZKZcA482PWXJFKe
 0ypK1B4k/enQjhLkGfZBH+44vOYZpFubroZdKcWXmfWesUfrt9MtIBFoN3nWppVamAOf
 iWMO8NS/p2cq1xUtytYg7mBREmINzGm8cU2+vTAo5xskxxgiy4WTL7/GGT3I8C+ImQz0
 AvP+FC+3FAMUeuQstapq8KfMRl2PmQDM4uI0f91VT1+uVoTn6nDqy/RpNfKkeOu93JEk
 8qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706900189; x=1707504989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvu6MmllqjtEsa66bGWbi7R/fQSWAWjf9fSY7mFH+Vs=;
 b=NUFaL5uFbgFv2UE1jWjIgByE7W+hAiON2B3+OQjMGOs/NKgmecitl6lCiCFr33nLLR
 NJHbLSDMSrCGR0eTK6lLoBMJrT0kSUmnFjr8QHSgy5hZQmmi0lsdmrbi84z0Ak7ERLJH
 ITLLEl9PbcFWPRMV7ngTATxkXxJXv23h6OseRl19XvJbfiP7cX8yPiJT9pU2v+Et1ALG
 gi6uXnzPFJqQ5QXTLIgTtJ1Tns9u+3zpHhZ7k4t4CJgj2VgIrXaalcky5M9QlTF6Y+c3
 iXLnyBpboYhuYl57WtBYKiZ7SO6nLeSlLzQf2MASX5F8s06vnxo3VwhYIv8aQy+Pki6k
 u+hA==
X-Gm-Message-State: AOJu0Yx9NjJYgTegLD7miWvF0HYZ5gIQLLuBPZMy2DTfqOhpmwMUuSPx
 DW/pH5t+dnr2D/YOp10sY7vtDj2bLxU1MpzWR9lPN+TRY6N/Copim28jn8Q9Uzvcr1BCnAgXXLl
 UxYtqvIZ7wiTFwgxKv4XcRMlkdg4fOmsZtlB5WLUT1Ku5q83K
X-Google-Smtp-Source: AGHT+IGmrCZhI0vtKbDXo8R1DKaUuiS7vVjIKXhrs7bi8GNn/8o6wUULXnnqJvrH9Z8pJu36v953hTXQhk6/SClejDU=
X-Received: by 2002:aa7:df89:0:b0:55f:7a8:fdf1 with SMTP id
 b9-20020aa7df89000000b0055f07a8fdf1mr367462edy.29.1706900189247; Fri, 02 Feb
 2024 10:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20240202163801.914495-1-dwmw2@infradead.org>
In-Reply-To: <20240202163801.914495-1-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 18:56:17 +0000
Message-ID: <CAFEAcA9sjovBLdV1NsUnDGPs9hX1XYn7szbetQ-crtZ84VO4dQ@mail.gmail.com>
Subject: Re: [PULL v2 00/47] nic-config-2 queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 2 Feb 2024 at 16:38, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The following changes since commit c3709fde5955d13f6d4f86ab46ef3cc2288ca65e:
>
>   Merge tag 'pull-aspeed-20240201' of https://github.com/legoater/qemu into staging (2024-02-01 14:42:11 +0000)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/dwmw2/qemu.git tags/pull-nic-config-2-20240202
>
> for you to fetch changes up to e8c5c4525cbbd7207c085732cfd1e67d8f3d662a:
>
>   net: make nb_nics and nd_table[] static in net/net.c (2024-02-02 16:23:48 +0000)
>
> ----------------------------------------------------------------
> Rework matching of network devices to -nic options (v2)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

