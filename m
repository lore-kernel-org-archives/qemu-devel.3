Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082EEC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwWj-00025a-Ic; Wed, 19 Mar 2025 12:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuwWb-00023X-Mq
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:44:13 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuwWZ-0002Z5-PM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:44:13 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e643f0933afso830425276.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742402650; x=1743007450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VErEszxUOaPKAbKh1++OIPzhYU/AVlkBfO/ypAed8AA=;
 b=hrcCN0av0SzP+acg7FFVuQgiUcF1ZgYduPW+A7BQQJMtDOlyF2z7XCOo17Y9ACA1pL
 CgEoz/PoVxwZkF+QVHQ6EoTaHJ+8cEaPhvpt6asfJemeO9CqdmvweA1JvbH01wguYV6z
 ZJxRvs8NgHtA20D8sypS4cxYNNon+EWsoHSECkVNWc7XGNUSVn37wGCBAbdhaOyvO8uS
 /dGb2AkRvkZPAcZ+OCU6wDTocwSfYB9BPwM2P/1cNtiCHuugiMMPhXGiddfjA9ebhBZM
 6zUgJkCG9wLOqpNQLBknhr283t6xCBr2b3qoESSJirzi6zfMnl2lGDHm7lxMYO0cjWpm
 fqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402650; x=1743007450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VErEszxUOaPKAbKh1++OIPzhYU/AVlkBfO/ypAed8AA=;
 b=gFo3BcU0L5qWpk44vrHBpeMEaT1AWH53Dd48VLb8qzEZnn6iHjnQ2XlgWRhOBIEkZ4
 UGvtwtpBARRMBvrkUfi707kWRP8v4h3byTrA4OB/Vfo62QYOsnP+r0u+uO0ihRxy4ESz
 mCsbIObqI4WAIJeprMd3ZEplBNGIktcwjrf7NAN5E5cmChesVkAZje+xkqWn6Fng7q9/
 iTG8ZXRJkvQz22t8Em19m6HRKGCT3v0qRkieXXNd0KqclLbvjzAezIYQzhXYkhPI/7N4
 bgH5bipukQm80ud9STMM31k8KL2Ysy1q9np7V5HBavO/MACxCT3TLgpVZ6uccxdrN1C0
 ZYpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLFIOUKxAe8ZtaCg0rXjjRc0kH4xOCsSkHb6p/2J0FbEESQvhk8vht7qHDQFnGa1XB/mQBGYorlOm@nongnu.org
X-Gm-Message-State: AOJu0Yzi7fTYuIeQirVWcmq0H2yLeZy8BUvBuKb037RmG4KIZce4sP19
 GC5WryOCVLx59ai0/pxcj4EZn1RMFRdNeQWg2Dkq7jJKUNPK486i9nP5VKilGUmyKtTfM+LQlk3
 1D0eEpytVnJuTJyJeO74w4HCVIgGoJUxgANPs9A==
X-Gm-Gg: ASbGncvRoHGcKgmYrP9uiJosM7WLeL8muUA6Ls7navY8wtPMT20A4NQq67MhdmiwXAO
 kn2nC8MJMGxFeskgpq2Im5Iccv19eyumBBmvElDftf77U7SCqYDMS3i4ce6ezIOxo8D/BLJruxP
 aNyOcngICQThSWZS5L11IwIHKLTSM=
X-Google-Smtp-Source: AGHT+IHmjfSQXSjH1XU+Xl5n5D6sC8s6BrTCQrNsUBYdvyh43s6MyHsLxhzLcTRZw12bn9DiQg62QN/AtiaBMBI+W00=
X-Received: by 2002:a05:6902:250f:b0:e65:c4d2:dc48 with SMTP id
 3f1490d57ef6-e6690dccf55mr273202276.2.1742402650415; Wed, 19 Mar 2025
 09:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
 <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
 <954c3f61-f338-45e3-9f23-b45cef5c81e2@linaro.org>
 <CAH_Y1jeG4msDoRMrsG+v=3Mx4Lrv_znTM_0FJVMDOean16pRiw@mail.gmail.com>
In-Reply-To: <CAH_Y1jeG4msDoRMrsG+v=3Mx4Lrv_znTM_0FJVMDOean16pRiw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 16:43:58 +0000
X-Gm-Features: AQ5f1JqYbp1L_ureWgSSy9Oj0icml2v6ZC4-2NnNUOq2KqCdG2px69FXoS4s0Xo
Message-ID: <CAFEAcA9S6PC7CMiLV5PQZSJpsb3hUNR-GSePDjAX0KWgmtQyww@mail.gmail.com>
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Wed, 19 Mar 2025 at 14:02, Tanish Desai <tanishdesai37@gmail.com> wrote:
>
> It will work for PL011 but there are other devices using the same method =
for selecting rust or c++ file like HPET in timer.
> You can check this:-
> https://github.com/qemu/qemu/blob/master/hw/timer/Kconfig
> Wouldn=E2=80=99t it create inconsistencies in code if we change only for =
PL011?

Yes, we should do the same thing for all the devices we have
dual implementations of (currently only pl011 and hpet).
I have some patches which I'm just testing to do that.

thanks
-- PMM

