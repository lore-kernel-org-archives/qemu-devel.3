Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E92D0C61E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4LnM-00048D-8T; Fri, 25 Oct 2024 11:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4Ln9-00046x-8y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:59:56 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4Ln5-0005Uw-QP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:59:54 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb587d0436so22673981fa.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729868389; x=1730473189; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yx8WWFi7cO3HhTtKp+iLZGRZthbFwoDb/ZGl/AoIn6s=;
 b=LGcLV29IszruggUVDZDVmQQvU0ca0c5cOkcs29LRjs2NOruNuLYghGN0LK/h1vs9DO
 O8Y+ZfJO1JrBT0jEXFMdqbD4j5KVmM4DdnMxzgVk5kNwfDH7hLmqzffPiix0Bba0zD6d
 d+6yjShot6AMfGG5XMapuKIZxgTdIOQl2GnGRlUB8wk6pjhCYj3p0mVATVbR8Cscc4He
 L8X6UQilYqMJqUuRSEde9QISMXEpo0QxcRCq6Alikhb6XCButi+o9r2y3uwmxIz8tmDC
 ZJrgD8LxvuYiubAlG+K6JBDW9D1O/RB1alBm5KyIUlFIoc/VGyAEt3AZQvF1mP6Kndfk
 +g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729868389; x=1730473189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yx8WWFi7cO3HhTtKp+iLZGRZthbFwoDb/ZGl/AoIn6s=;
 b=kp7LTVlzze83HcmkTOtS5DymcC1iv+1Pn7jCemKEf22Da12iuUt9JWi/WH3gJPby8+
 xDuKD84iUda9J9vXnBOE9whj9jYXx27z+qK6A+sm4tPsOpegKp1ap5AQtDAG65b677E7
 zVJ8vubK9dA5u7g3CmI11Zj1qFL9ovLdx1ym1zdvhx/fcRwLDpowzRp4ldlqjJO2xNlh
 ut4ttjql1HrXX4x6EgEVw30l7fBzhIkh2PU7ys4Asn68n3iuofAf2InaKwwehnDK3O99
 0u795w6Bgi+i0Vr8T8qsqOalLorCTYaLGH0Sli6oSvnp22EYWcM/x9SJIpK6FK65LCzB
 jBcw==
X-Gm-Message-State: AOJu0Yyp7HVoDiFFAEAGFd706zsayP2K1rZ0YbVLZKslWXNQ/fhCFy3y
 TTOOKSyMr61l5EMtyV3zEJnsIKS466+AUwJSGEEbLXf1Bqjv1jZi3ChvWIyt5zUN2c2lV9GNOd9
 yuQwErcivMSV56qeISPuwpYDoqBF0Mjhxi5Lx6A==
X-Google-Smtp-Source: AGHT+IGG/JRzFSH8PPlNlw5IUzat4ZLpAQO0no3QTc+XQcGGFMF2CeIQwSUon2XPtaV6ETFkUk6g1R3UZzywzPfIPqM=
X-Received: by 2002:a2e:a592:0:b0:2fb:8774:440c with SMTP id
 38308e7fff4ca-2fc9d32fc0cmr52624031fa.10.1729868388989; Fri, 25 Oct 2024
 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <e5e9e5e8-febd-43bf-bfad-8932b29fdd0b@gmx.de>
In-Reply-To: <e5e9e5e8-febd-43bf-bfad-8932b29fdd0b@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 15:59:37 +0100
Message-ID: <CAFEAcA-UZbFxXRt5pzQP9Fa40DJAvuYz0_a=AEsVjUb8A3Z4nQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] softfloat: Set 2-NaN propagation rule in
 float_status, not at compile time
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Fri, 25 Oct 2024 at 15:49, Helge Deller <deller@gmx.de> wrote:
>
>
> On 10/25/24 16:12, Peter Maydell wrote:
> > A summary of those TODOs and other oddities I have noticed but not
> > tried to tackle is:>
> >   * hppa really ought to implement a CPU reset method
> >   * alpha also doesn't implement CPU reset
>
> I used the alpha code as template to implement the hppa machine.
> That's probably why the CPU reset method is missing for both :-)
>
> The TODO about implementing: ?
>         resettable_class_set_parent_phases(rc, NULL, hppa_cpu_reset_hold, NULL,...)...

Yes, basically. The reset method should restore all the
state of the CPU to what it was when QEMU started.
Typically you put an end_reset_fields marker in the
CPU state struct so you can memset() everything up to
that point to zero, and then manually reset anything
else that needs special handling.

thanks
-- PMM

