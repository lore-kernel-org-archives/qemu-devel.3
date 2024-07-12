Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74479C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHdY-0002NP-Ra; Fri, 12 Jul 2024 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHdT-0002MZ-DI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:52:36 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sSHdQ-0005xk-ST
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:52:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a79a7d1a0dbso67962566b.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720795951; x=1721400751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SLsdzrr3nP9KPrSgXX9PyOyS+z1dk5VBqT/bFCFiuig=;
 b=Ds1tsiZSNom7Rc2rIRvxsOZlULtbVqF5tmOTd+NWrgFtTZMyouZq0FAU+FbXufO9qB
 IxlM0RGnVCo9YvdYtCYwkb4mmBlGt3iO5cSBc8O8B/1+4JOBSf4LgHQ0W/mpAGGRKOGy
 FjIK/EOxWL8zVz3qmMmaa/XoadSSYgTXjTFUfL+c/hX3UitaxdsjUb0nGGB0g5AR5Uuz
 E2rjypl22vXN9c9NZnFpIN3/GBp40lD1i85KrP80eeQAyDGxPRo2eWaOMczuPKcvZFPu
 2QVG3mSehwsfiLewI0reCtxqkaQQoZCcL6aJW4uq28Doe5D+i8PhhRuPphhC1BToW/sT
 ncwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720795951; x=1721400751;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLsdzrr3nP9KPrSgXX9PyOyS+z1dk5VBqT/bFCFiuig=;
 b=OGCrhNEbgXXiTCiHCgh5oi3hRYPk89iTQFfkpfRRDCrlnFbTTwWWqrJvIr9aTWaYoU
 aWwwPEkN3LYohjpqzbJwlV72gdOkrjnb9n0uX6riHWn/nk/EVPTCIW6Wtzr7jB1o2LgZ
 7NXPE00+6DED7auEIeOTRYhUM5up1o8RGq3ubu0IRjIoLnHMT0H8//4G58jjHqOerTzA
 OBgtA/0e7VBqmo1xQq9joKdWb7wTLJWOz7y6Mru3zsyDZI36llTi8HTLJkrx77gFWJbT
 GhsfAdmP1hvr5H0MzlpH3xMLRmka60JJyvt6g+gRWhocnyBpuKtcQFqOPPAkCMrbhO1o
 zdLg==
X-Gm-Message-State: AOJu0YxevXt6s2RBqNws7KpbXvpq6WtWxf6W1oDXQS69foiLlj/00alr
 YcL56u30y8S49ghSxuoyrFj8NAVFMzD35i+jGGfYxesVTkbDdh4LUca7YYBi8LM=
X-Google-Smtp-Source: AGHT+IF++uzRAULeNAD3dTax5y8tAX7G+Q0ygQlx67x3/Ve/yEroyWtVTLjb7+kcym85Mldf3XMrew==
X-Received: by 2002:a17:907:771a:b0:a77:e94c:5bf with SMTP id
 a640c23a62f3a-a780b87f7b9mr764286566b.61.1720795951181; 
 Fri, 12 Jul 2024 07:52:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a86ed10sm351653766b.190.2024.07.12.07.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 07:52:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14E385F713;
 Fri, 12 Jul 2024 15:52:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH] accel/tcg: Make cpu_exec_interrupt hook mandatory
In-Reply-To: <20240712113949.4146855-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 12 Jul 2024 12:39:49 +0100")
References: <20240712113949.4146855-1-peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 15:52:30 +0100
Message-ID: <87plripsr5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The TCGCPUOps::cpu_exec_interrupt hook is currently not mandatory; if
> it is left NULL then we treat it as if it had returned false. However
> since pretty much every architecture needs to handle interrupts,
> almost every target we have provides the hook. The one exception is
> Tricore, which doesn't currently implement the architectural
> interrupt handling.
>
> Add a "do nothing" implementation of cpu_exec_hook for Tricore,
> assert on startup that the CPU does provide the hook, and remove
> the runtime NULL check before calling it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

