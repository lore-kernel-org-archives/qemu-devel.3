Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB21D68BCB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByQb-0002J4-QU; Fri, 15 Nov 2024 10:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByQa-0002IR-Ev
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:08 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByQY-0008Qq-S3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:08 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so132183066b.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685205; x=1732290005; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqfWi++rl3hUmZxn6nytbfYNM7OV2L7ofeIN9m8YA/w=;
 b=jIu8vf/gh/PH1yK7ITkZV1FXUdlIweUBPKQY56wi2K6lD4mI6gspIK2Iv7tXNjByug
 0RgFfgwDB+S8nHveve71Mw3miqBkxXVaDxXATHpHIKvb7gifKdm6ZvrhQ+ZsjRpq3uy0
 nmmqj7zsTiSO7BGnwDYXjHVDDHhljj4J0QRKUrhmAJxgymeA7wHXpuXvjuTNwEhi2HXo
 YpAq5hffszU57GDBsl6sbuYTqHiL2IbIxlhqW7rfdwgx9zbrGf/yKjpRzk/KLoKPa+dJ
 5saMTYTiw1yZNcFSfHdwCbtAQfDcg82Lzzssp5SE8JE7iRiNROB3ZvMNJdQNJv2mu3ar
 sdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685205; x=1732290005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqfWi++rl3hUmZxn6nytbfYNM7OV2L7ofeIN9m8YA/w=;
 b=QXS3a/2WfmHKOir0qKz/VLlBO0gg9/3kWAgpudCMqmAO/jObLIw8sO7NeyGKb6B067
 6LKvfHOsOyNx1eM7JeIkhJJD+m6EG39djxJtm8FFnNlAWhcGJrFGc/Uh592sbYJOi5VL
 DShH6/qbL1vpN4ZEoJf3mwTVObrV8i+DZ089ebgvVKjJwL07x5aYqVOkWiDBZu+CsHei
 p/8RaIoZ9WKs3/8Pe29WNmWFKJoACK4/w7CQbKykYSPuBE/ceUN77jWwh8EHaPCPtOS8
 owv3zwch+J/DuUIgqnmsT5UfHeJasXxB/2XtEUcyCi2h3tStva+jeTqaQZygt5WfAZbO
 yG4A==
X-Gm-Message-State: AOJu0YwY+bDmYHCvguchV7UHGU06JnwOQZhHl0njYd5T9b/ds2oyap2t
 ef+9g3GfAg3F+MiFklqGWwm/ZafxbbsQ36iYR67XybJcAO3wfd/sLXjf5PqN+fYy+7suhUQv3BA
 ts+f7CH4oFfmsN4HLdvgEIJX0yGT2amawILLEgw==
X-Google-Smtp-Source: AGHT+IFoFiuEWll6pWsX0Nf/f3qccARchQmm6gBo28hnSuflt+SbWrXoEyKNZz6nTUKYQayKn8hOlYM3LpO+dbDpfnk=
X-Received: by 2002:a05:6402:908:b0:5cf:45be:2569 with SMTP id
 4fb4d7f45d1cf-5cf8fd2ccbdmr3029855a12.21.1731685205029; Fri, 15 Nov 2024
 07:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-2-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:39:54 +0000
Message-ID: <CAFEAcA98_8h5Kg_J7c5U79OqCWfKgqkCLHrDg7rd4n93xBEk0A@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/mips: Drop left-over comment about Jazz
 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Fri, 15 Nov 2024 at 15:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Commit 3803b6b427 ("target/mips: Fold jazz behaviour into
> mips_cpu_do_transaction_failed") removed update on TCGCPUOps
> and commit 119065574d ("hw/core: Constify TCGCPUOps") made
> it const. Remove the now irrelevant comment.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

