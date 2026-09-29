Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD0ACA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWkO-0007nT-7l; Tue, 29 Sep 2026 08:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWkD-0007eR-Gv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:15:37 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBWkB-0002rl-Uv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:15:37 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ab41af29caso4107417b3.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790684134; cv=none;
 d=google.com; s=arc-20260327;
 b=mNU85LM7UXY1ziCsd62t1iN3aidt2iu+Q3wgPwsQ686PLeBAHpOewTpn+fmQxVC0RA
 GMpHFv8u0Cu012lrqIQpW8v1sthKVwMf13LmCGF+ztXmBnehUnqlHmRRdCXTSd7XWkMj
 6Iapl+2mNsXQzmCg6UxTPmuS0qwcsCdhXo092HbaASGRslFpvbqzXm7ybX/bkaFprfFe
 VAHHNQ510NCnWWV5Uz/v6B0qvYJksFAooODCWvJewtM560IE4w5zokCRaWox1DPTbQP7
 8pNLnQYTXFoilNK8d6IuWqeJfqAPFiecxrAlx8czq4NbBrnrGoUUJDLINYPtmLXpw6tY
 9p1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NgRE/g2boNxBAVV7q8bFHzfRQh0hM0mGvccNojMeDD8=;
 fh=FwY+JvRirSf9rT7rq36uEcs5QuzgraQN7XQgCQEGUB4=;
 b=ny0x1W1rdH4YWDu+i2Nw0TrzMwSroPrn/s+EKCVYECLRipyysmpykx81/pimwfdZsl
 1fErYlgZgT4ielLylRPmxmqY6oPKTZMQtSWRiemLOsgEuMh/vY62tvaaR+EyZsYDibPV
 dvstOS6TQwtWSs+JC2gsKaHkRu13WP6jvBroXjYJR+staN9sqirotf2Z+NVUt6kGCv5y
 GgvJZLw5Xa9pLKHed/+43N1SuNnMZrKEPassc8qB8fWbBok6YzFvRcCJVjpFp4Z02h5B
 qWLFUdlp3W39xkqt+8qTqA56AA9fhVek6hvmZPUdic9TgW0fQnS3NNCrvTFSVYK6c6Rp
 pJNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790684134; x=1791288934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NgRE/g2boNxBAVV7q8bFHzfRQh0hM0mGvccNojMeDD8=;
 b=IrgnPQHfSZVpFq+TVUeYDBC0P0UNbRAi6oI4SqGlaA+D+OR0shPVZRpjWJOLPG8f+3
 IQxQv/V3veUSzpCkN5GhSdX9HQLIOuMZvtWdE2zf2g/aUa5HEWcLYtWBqyVAM7wYg6rw
 IOBjE1WRhesHWW05M1sgEPgKNklv9c1itD2JXy+7cbfJ5x6H1n4sktO5UquyBNCajLqu
 FUJjVYQGMEvq7Y9QBjd9U0Dvm7ieKfd7ZXK0t9vZvLtv4zqI81FcYEsXCznX1WGY+p3h
 yGhMjooNyLk3gTbuPnIH/uL4KEgc7yY16jhgFcb+RWT5s27d6QqPabGBkCRgoInbozda
 UTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684134; x=1791288934;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NgRE/g2boNxBAVV7q8bFHzfRQh0hM0mGvccNojMeDD8=;
 b=O/T3F3b7g2DPLtEJVKv1B8VMuuC3aojNWnoVcBccfc5WWRs4j3VVqCViWdfumvvZ1g
 4xAHRaRONYet0WQYcCavhrj/8+TVuapxUF8rnRk0AJtaxU7DGpOlxtFrG3I7VWsvOvew
 OHmXEmL1lh/nr/lgbWRGFA0GDv40OEvQmYBVLFAHTYhJ58TlfXVmv1W8gcnLK2xsv/5Q
 zMUARn54JXfO47KtyLiMSWADyhLAnMl3yTs6aP4/zrCDSponroET1HIji8XS+30psfj+
 PKAXQep49rCtkWbfe1fOh3zIldlG6Bbx1TxIf0WzrEIRjSCrXNqwgJEsveAwDNQ8l4Rw
 Ykmg==
X-Gm-Message-State: AFq9FYJw+DYUR6U2gbE5yAt4TS/OEKcVBP92Vzae0OjXlRkizagKN+Xn
 8mOMKDXqG7yJnRjVFKk3xfo9i3RpdAK+hmpVHFvts5eThikw8NjtAuJLbELL31XalVp0dQKNdrt
 pqampWXCEYRjU3oeSg59lml/q/BW6gkQNEgwrtBkhLmiZ3YLnO6CQjek=
X-Gm-Gg: AYBFou2aNFu0nQTMvPGJnUoPEw9DesvDpXELeFvSq2bfYhMWTPvTy0lBaoy0UqPl1+f
 bW3lz88dZQx1WM8gSESxpnD4Wjxfpc7EFbIFeOrq4DSTNdxyAiwMXWJPOETr4lUS+8ucIbeImIo
 2R7ub5lLZaBVURVGFr3K5BTFI3f3j5qW9GtUBaK0saaMvjZWM/aCB2te1rsbegYK35jYPyuV6mZ
 R1rVUFUriMTD6H4mpMYBiIBF11ZGnsl8gSpYMeYTATr+KtVISkufRHqain+xIOAz0hMHKlcyRHA
 pE72T/kDT2jtTtm8c0zR1K8zINZwKzO5+gHSMtTac5uOIOtJ82M0wqWvXErqAI53KzOyNaUBG1c
 NJgLdB+bpwqrTaXsrwRWvhE+dPlWStExTP+X9ofQ=
X-Received: by 2002:a05:690c:87:b0:882:1d1e:9aaf with SMTP id
 00721157ae682-8a649b6a5demr86427777b3.29.1790684134321; Tue, 29 Sep 2026
 05:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260929120838.13583-1-philmd@oss.qualcomm.com>
 <20260929120838.13583-2-philmd@oss.qualcomm.com>
In-Reply-To: <20260929120838.13583-2-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2026 13:15:21 +0100
X-Gm-Features: AclHuK-BTfRtj-AvKbyWS8dZtO5-e2NxfZP41HpMSjSY6X7Ae6eaQO27NPS0gHc
Message-ID: <CAFEAcA9bhWXLSbwhb_fsM0JOQsAXFKDj1QbK2_80q_W=NyU=jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/rx: Unify BRK and INT trap handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 29 Sept 2026 at 13:09, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> BRK is equivalent to INT #0, so route both instructions
> through the same trap helper.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/rx/helper.h    |  3 +--
>  target/rx/op_helper.c |  7 +------
>  target/rx/translate.c | 21 ++++++++++-----------
>  3 files changed, 12 insertions(+), 19 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

