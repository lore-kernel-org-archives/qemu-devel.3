Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADCCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 08:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNncg-0006ce-6e; Fri, 15 May 2026 04:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnce-0006XH-4B
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:10:16 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNncb-0003F5-13
 for qemu-devel@nongnu.org; Fri, 15 May 2026 04:10:15 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-651b4d09141so1467391d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 01:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778832612; cv=none;
 d=google.com; s=arc-20240605;
 b=hpvKotk1Meat5O+pdCs9RtADL/cwKZ2L3AgIq9SHl26rAwb9rO9KvmSdgJt3vJU7bc
 ZCll/MFCfw8smnxW8e3Tcn5zEdfVbPLeYQZ/kRk2aHs+JnUxPVtlrynQu5Ge/w5hDd9N
 mk7FfDklMJq1e05slQCNXwy3cPq0XkSP9x2ZHHmWxJ9d+3NY0pxx+ROjpCKCYReUDhP1
 hW8bzZfkG+gN3jf15Z6R5LRf++Wmeqx5qcsW08rPBCCYT88l1jI7my/mE7HuDQP/lMxG
 SMs6qa6IgqboMn6AXURQttU3Upczj9UsFlPI8XwkwrIYk5DEUvKFdwN1K2Qsd8nNCKqB
 qEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d5k81WlaxgiwhjPZuLN9+Zyth4LlK2+5FnTxOpjqhA8=;
 fh=kvOOaizNZldvZrGcUk8ta2JEDnV4vPRBdkt8TLZf/QY=;
 b=KmEoghLc6SAxF6CTYrHUEyP2JjeJ1V5aIhAUQi9VcZdSMJHd+EHZ8S58HD+hrsOG4h
 lvGJF324Yb3hPztxoinAjZa28U/J2N9nEp6EI2K+jdnG8Xh8H/AF57PBfQ59YCPYHXwn
 19Hvyp7tiM3/Pd8xL1jgjTJWL3BlQk3cr6L2oORVdQzTjPK6/Tnx5CIoU2KEfuhNbVhs
 1nZG4QrZwPT3xvOJhwGYCIrKFy4mGgEChWmHZAcb8dct18fyJVdvBXGHq0rUrv7kLp1G
 43TO9WbzXn1CkqYqTr3SkQ4vJw+0S/oFxmMGjALcT9uQuqGNHNKaPKtNRXEosD1n6x4g
 LjpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778832612; x=1779437412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5k81WlaxgiwhjPZuLN9+Zyth4LlK2+5FnTxOpjqhA8=;
 b=WbAr9EWkd1VQFmGwQOMs+RGheSdz4TZz7Wnkj0X6/2HJIHCrF8jxjEFdQJIkszlvT3
 99mRrDaDG5qEAKlFwath5TJjGWszAwY4AS+Dk4GChqf8Q44Nuh940zQN+d2qgYMjrFES
 cE+Zqm3VvpK6zkAI/MKJSLqg/H3WSz23Ut4YoD2frX0Y/j3yBrWoP+Jf4f4Ni3zoxssM
 t0LT6j1q0TSYSccgqLU2A2rEH4Eu1oNCeBBeEd27odlMYQuuU0n7Sh7OzMSbRwT5bvaG
 XVPNKrWFsG8INBu5+/KRuSknP7iI5r15UuChLX7Bhj9+evhncZJcDPWrAwP+7LuqN2EP
 EWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778832612; x=1779437412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5k81WlaxgiwhjPZuLN9+Zyth4LlK2+5FnTxOpjqhA8=;
 b=qLYD/KCJMgBTC2UIDqW3GG0rcHwL1QyzuhS596kqz2yEszh1sw5sThdnLGKOzHEvpG
 zpw4ie7jAtJ3VYvozdOsbfs7skzr86B2R0utVNlOUNwUrf4KkLC0wKTRf591Py3PHaBk
 B5mJz+XUd72Zv3SMJbtZTVjhZa/3b9jmHW+uHUaMVbPiFLqDYNzwAjX6Muk7GxDnWy99
 NNkECeb6RWHfYAoW4Z25lnOmDqNA7P1j0sQ6AzZFUABn/HAmpKkm2m72lwKOo18JHXuc
 PuUK598nrtYUmi8/ljlMRaeIdJJInzcsbUfSNtyUQkXsquG4qCCbrAgPNl3FtW8vLZBE
 7I6A==
X-Gm-Message-State: AOJu0YwGSI1z0sMcRZGhfzZHPqVwtDOsYku0NsFbE/lBhSUJv0xJJdiT
 MfBAojji5D+vloGlkYoaYYZ0UA2Nc3uDLhNqITbYPVRXLZ8YnG242iGXatRKMqVc2nY6rykvTp3
 RuQejFc0E8OKL/xNQ77NWjCQaAiDXtEstTMYMzlLg/Q==
X-Gm-Gg: Acq92OG/gdOtIYuU8zbxYYUoNkye1i6gRVX+hoDCHeHCpEE34LuA/Wr+BgccKcESGA7
 RmR57/sDO7e0hT4NLF28gU1kU2JZE30j+OYKwRvAvbcAtcEqAqyWG7NO5A5LkksRbjFM9pZ+rZU
 4gE2W5f1dOKphQAry+vtAOJK545XejSuuWWS12/iBE8q3DS/dz07OeC70n6LBofT0txO46zLT3n
 M69i8wU9bigZSGufSoKqpgy8+cRl52yHmOze3Yht9Ach5YSEuT42dMKE0DlUmsBGJJFw2ecpiY+
 tKFq4vc0VOax+xTv5HRv/14OEHpgSqIXx41WSmpbjBPsfGNITQjg4QcOwSnMBJgUtq0=
X-Received: by 2002:a53:d005:0:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65e216d83d6mr2228597d50.30.1778832611887; Fri, 15 May 2026
 01:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
 <20260513105517.146706-16-corvin.koehne@gmail.com>
In-Reply-To: <20260513105517.146706-16-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 09:10:00 +0100
X-Gm-Features: AVHnY4LhsCS6ErLIDSYFXTu_d6loJrxsEyIId2t14nGsemNciIMXY7n1NSdyhgs
Message-ID: <CAFEAcA8aLT4LQZ1HaQtduZeWm9w+62bDaXmLetbnJQHN3xq3jg@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] docs/system/arm: Add support for Beckhoff CX7200
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 May 2026 at 11:55, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> This commit offers some documentation on the Beckhoff CX7200
> qemu emulation.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

I had review comments on this patch too:
https://patchew.org/QEMU/20251204093502.50582-1-corvin.koehne@gmail.com/202=
51204093502.50582-16-corvin.koehne@gmail.com/

Please don't just ignore code review and repost a series.
If you disagree with the review or have a reason why you
don't want to address it, that's fine -- we can have that
discussion. But ignoring review silently is not a good idea.

thanks
-- PMM

