Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C301CD16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0L5z-0005fT-4o; Mon, 14 Oct 2024 09:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0L5w-0005ey-DX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:26:44 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0L5u-0001OM-7x
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:26:44 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f4d8ef66so1349701e87.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728912400; x=1729517200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbLgX7DuJw98YWzeuezvh9OWbezXIfspssTClnD49IQ=;
 b=PuMm2XhYvnHmPbrIlCcoDeHZ320m76yXc6Kw+Z4tyElHKQtFUCXjlpVOuXB+2ovX39
 GUoKTU5A3MClRb1k5Y0oG+oPlttqtUDYynUN44t22pgdPTD0w42jhyWroYDhXEGFJYV+
 kQO5s2wuGrEbI/8qEPMcOy6Lutu+QEbK+vTUM6xxaHUpYc0baytszzEPLOQcO+tKenoc
 scNZyQLdN8+tisTHEHl99o1XM+VrsTrUIeOvSjV/C/QPeYgtHWtpAbap8IaRXfCz7CmP
 dwnpRu+LmMylOKl07OvnzCjobKn0TEWU9UzU3zBjZgORg7N1tmq2exnIMSrxWXqxfgry
 NiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728912400; x=1729517200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbLgX7DuJw98YWzeuezvh9OWbezXIfspssTClnD49IQ=;
 b=AsjqpiqfVNOupvHkveBbR4ImoMtalqD9mPFdLN9W7YvoTvBPvREWt26eJ4j8yLlj84
 MpqjcRvVvAW41EVXEGC2gnOWaH5qWf7tGBpLFesQeFxWBtUTpHUtMz1U7iKeVlp1cD/n
 yb9Tl3QvNKX5SK4ZkagAORPbVqmVawKZZBUI8kdJPgLqZwMIK0ZUM6hg53wrHv4xkWAW
 XzF3yV7XNQjdVaIXX+uhBRe6AJRhTpBN90ORYyZhrS2W+Jt/59XonmSyjfDqwq/7Y9qx
 M4jWz22SQbcUwKhU1FvL5HIRIC2FST1uNnKUO4afB0KfNQi/vwtngHL6plQKmUGs/4yN
 ibBQ==
X-Gm-Message-State: AOJu0YyaF9F8tbgtLL0/ooQkrn9GWDa7KZbJJQsv5S+uHm233sUz7R2z
 xENHC9hSL8FLANI7tMYOz87xxVeU4sOUmr1gt7i6iZX0JDZaxiFWbWQ8GokpkhFbGdr0ra6MEJR
 2/WAGvMAqln4nc/ZVEcwm9GU+TNDaaUZrhvyWpg==
X-Google-Smtp-Source: AGHT+IFLom2IeWbKInYob1gBF8XQR5V52pbAVyLRrV857LTxH83tjolIbOLgEIwy0S+VwPJQTOiLz6m3KMosbUrWIuA=
X-Received: by 2002:a05:6512:2208:b0:539:ec1a:5873 with SMTP id
 2adb3069b0e04-539ec1a5949mr2599899e87.28.1728912399770; Mon, 14 Oct 2024
 06:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241014130255.10119-1-berrange@redhat.com>
In-Reply-To: <20241014130255.10119-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 14:26:28 +0100
Message-ID: <CAFEAcA8oJvasajohf5BA1MehD0pvLWYdX=iV2fk_gJz=AU_WHQ@mail.gmail.com>
Subject: Re: [PATCH] tests: update lcitool to fix freebsd py311-yaml rename
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Mon, 14 Oct 2024 at 14:03, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> This addresses the py311-yaml -> py311-pyyaml rename in FreeBSD.
>
> The change to the OpenSUSE dockerfile is something that will allow
> QEMU to access rust bindgen in future.

That sounds like it should be in a separate patch?

thanks
-- PMM

