Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A312D78333
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9gs-0003HI-7d; Mon, 02 Dec 2024 11:54:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9go-0003F3-Bq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:54:27 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI9gm-0007S7-Sl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:54:26 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so5180041e87.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733158462; x=1733763262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GhOkAt4qkRIzcTGO9xIGvFEjdD+DdmLYAWhXodCkt7w=;
 b=KnVAeZsnRqwZm/d8bjVB3ndqTxzfKP7jc08sB38X4xomWdkr9hUo52hk5begVsgrVm
 mtqjpYzDjiwk86BH0XN7CcwCw63M8GJy/45UOvWB5RXstyhBgGZoECFk3tzx4WCY1o4Y
 B+Waayb3TXWvr+SC+XvCn0hJQx47EfDDMOx2hz6y/Z+KjuVHPFqPL0I6qRZWoGQR04gu
 Zg1Bj2wduQX5RL2Kp6b+Ke+X8mVQtIvj5hO545xmaV3+iEsiYTD7Uca0VBT1XXJ9yEQS
 bTycPJQES8JQJLyeQC2CP7muCyDjN+s/xZLszyrRVQaSOAcLobOE/CVfAFVpXG0XyVRR
 RKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733158462; x=1733763262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhOkAt4qkRIzcTGO9xIGvFEjdD+DdmLYAWhXodCkt7w=;
 b=pHrZLpLIY0OPeppwvxsn71DogLiskQiWeij81Jh4akcsEKWHhxhTT+yESgoSrkhU1z
 Lg4RF6g9j7wzGqrrNsoSefDgFbSuc8cNhlZBJofqPRkKDIsstbUIEeF1+3Fm7x6PYA/U
 A4wdhSyYrMdmXdkXq5CxwlaG40V2JC9S1PV3kffCLidisYYSfCnWcEMhjF3jjI6Yi427
 Bv4FGsBvtS/fHSgEM0JiLLUxYrIF2vyr4Ohowt9KSqxWju4ovpgu1Ju3sOsqViD2KmPD
 b+BX+ZOQbcIcPlxAv5fJOA6jIr/zkVsUQTYyPFxNW1js33TcYi4beveLth1hNWThgn+y
 Iigw==
X-Gm-Message-State: AOJu0YxAjfdFyQg5DQq11t3O85BFpdoZ6rua5z+8aeRHk1gBe6k7HUqm
 BhAbva97QWpUz3k63Me/kDRl8/+L6M2WB2tdQEj9BSUjTfQFzFfyqdbGjswg4XJZtOvafHM4Ujd
 gSspNIAWPgwuybJenYsa+A01SFayA16sql4OcY7JZQLk7/cZJ
X-Gm-Gg: ASbGncvuptN0xlOuWzTJnS9vy8pC8CLdVMZMv5rzwKUE0t8QJ039kV2I6A3VqEVNEi+
 MFAQ+8O9uZoMjvz7VJoqWWCFPSqhKWwiI
X-Google-Smtp-Source: AGHT+IHj2TQ3tVOAOQPx3vqZoxbNSe8hFiSWUn2/RJYg5evA585YaYfJQ1AVxCNzHTiBym/Ej1wdmbjCm01GQ5cEAdk=
X-Received: by 2002:a05:6512:3f1f:b0:53d:d3ff:77f6 with SMTP id
 2adb3069b0e04-53df010900cmr14042696e87.46.1733158462451; Mon, 02 Dec 2024
 08:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20241201070955.223360-1-shorne@gmail.com>
In-Reply-To: <20241201070955.223360-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:54:11 +0000
Message-ID: <CAFEAcA_mACDyLcr+ZDO5xVW9Od0Vh4K_yBeC31YnsnZ9z=1upg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Misc OpenRISC fixes for 9.2.0
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Sun, 1 Dec 2024 at 07:11, Stafford Horne <shorne@gmail.com> wrote:
>
> This series has 2 fixes for OpenRISC that came in over that past few months.
>
> Since v1:
>  - Use DIVIDE_ROUND_UP instead of open coding as pointed out by Richard
>  - Fix off-by-1 bug in TTCR patch pointed out by Richard
>  - Fix commit message and reverse registration order as pointed out by Peter.
>
> Ahmad Fatoum (1):
>   hw/openrisc/openrisc_sim: keep serial@90000000 as default
>
> Joel Holdsworth (1):
>   hw/openrisc: Fixed undercounting of TTCR in continuous mode

Note that since rc3 is due to be tagged tomorrow, fixes
targeting 9.2 need to be in a pullreq on the list by
Tuesday lunchtime-ish UK time (or if not possible, at least
let me know something is going to be late arriving).

thanks
-- PMM

