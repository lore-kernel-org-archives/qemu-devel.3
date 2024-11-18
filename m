Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D3D49207
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4VA-0007RB-Gc; Mon, 18 Nov 2024 11:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD4V9-0007R0-8Q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:21:23 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD4V7-0002ee-Hq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:21:23 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53da2140769so2231388e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731946879; x=1732551679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08+ikrcWxwZkDrScwoy6KNhNKlIS0dnOfcTx0vsmBXo=;
 b=CDRqnr5qzRrq91IyGQZz+pbe+AUBivKLYUgnEYaN/ltDqlULYKcnGYkUfcf/kTBeRN
 b8Um+5F3XDXgeFqJLBRHJkerZNntfVRIbQdLSkE0Sqcv/R85+PHGA4b/5VO3QiIWossW
 g5UcmLTRPvIOEtWAsk+fWt9eexkj0TblFp+vR/hRWe7GIB80Al001yLUXcKQynkHN28V
 nIrGREi/YjxkDaCMXkWaZcn5002/zrG7OAKJHEU7Sm8HutDlVjqjXSEzV2Wz5IKSGmVz
 +Y5/XIVsCqBWf7ebJ8z2VPtJMXDhZVBxDrE9ZUVXzKzOrJj7FylFpj9Jq1aLAsTE7SSV
 Zb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731946879; x=1732551679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08+ikrcWxwZkDrScwoy6KNhNKlIS0dnOfcTx0vsmBXo=;
 b=PXaOaAhAWeWLVZtRvz6y6zxhU6VgvbUD+T/EzLb2UB7dTzA/zqHdilDyet/0imWVp9
 WI/bc7BPo4HlS22zuxNLtuxd9eLMk9sZ+7Fc80IvTo3TUHWWsPWq81zoRywvnnOB6WOa
 32g5U1rucSZOemavcO/7ve5yh1oY3i0glWzXvBcTEr4VVMouHVS5TIcKMC2mcgcnEx1V
 ExAh65dbp1dvkcA3mZlu3//kgU7OVLpbXxLcY3buWGaLGo5Hib4nuPzQmf7lJ9FSCzQp
 kgmN7dy1eNwTqzCbP4gtbQ8UsTOzRte5yXhCUFMsXgAcz8xREuifyZs2LxT3u08Dsrlj
 q3Yw==
X-Gm-Message-State: AOJu0YwrFjqUf2GDTCeLhRMAE7Ot8thUDobHWKg1dVPbNai4bhSDPPYW
 anGzfm9zNjO9BNHJ8C7QBZZbWEtcRMRdQ9QH9Q7aW4bkOVlMSLVFrkqLmEC1FsCxtZG+iN1doI4
 crmYII0MZO06fF3UHRRQ2yfwizqKjXVRJnKKzYQ==
X-Google-Smtp-Source: AGHT+IF9+uvXjxdQvc5ROGEmRfgx6Wyl3PVATfUny6gUFpO2iLUF2qPnvXMUAC+SA9VxIDxMqoy8WsNJWHnUJdT3fik=
X-Received: by 2002:a05:6512:239f:b0:536:9f02:17b4 with SMTP id
 2adb3069b0e04-53dab2b3c51mr4666523e87.40.1731946879040; Mon, 18 Nov 2024
 08:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20241118124643.6958-1-philmd@linaro.org>
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 16:21:08 +0000
Message-ID: <CAFEAcA9PZOZwC8ZjcQwzTpXSDJxr9OfhptrMEj5WJEHgXRGDOw@mail.gmail.com>
Subject: Re: [PULL 00/15] Misc HW patches for 2024-11-18
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 18 Nov 2024 at 12:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8cc=
db:
>
>   Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into s=
taging (2024-11-16 18:16:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20241118
>
> for you to fetch changes up to b6db70bc0a9e53e7aa04cc940db1ddbee17fa700:
>
>   hw/watchdog/cmsdk_apb_watchdog: Fix broken link (2024-11-18 13:45:45 +0=
100)
>
> ----------------------------------------------------------------
> Misc HW fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

