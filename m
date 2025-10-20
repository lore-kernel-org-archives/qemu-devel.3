Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249DECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApr8-00030H-ME; Mon, 20 Oct 2025 09:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApr5-0002za-PB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:23:19 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vApr3-0008NH-NI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:23:19 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-78487b0960bso18411207b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760966595; x=1761571395; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9egt/9Hwhp6Onvn+4vsjbCWth6QxdvUQI9K6mF2srk=;
 b=PAa+brgYY/hABkHIW3U7QkH+z8HQjf8ljsGrx3YC3F6X2XFMAGw0PCQoPZgoeDcpvd
 cShfnkoR800xsr35nuXvAsI2Q5OnroM8Je1y0dp9lFyqo6UsTXiWNK+/BBSAwaAzWqsY
 izAneVK+Qs7PEe2BVXYNE1MydiIC7+NshPCLCXjf11oVUVHEuaEPrSv0WgcD20i5dcJl
 kNA5B+x6hewKqbCPmwclA1tjwudczx84i10vUBxm5xhooCqkynesCgSX5jQSCGJoBFJ1
 LJ/trZyq/yRBisQ5ucLCfFsLRo+DN3EkVSRTSWY+BDRDKjnkUJ/k/cLJnzlwIeBgHnw0
 jmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760966595; x=1761571395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9egt/9Hwhp6Onvn+4vsjbCWth6QxdvUQI9K6mF2srk=;
 b=PDD2cn1jqdqa+GbyZh0PR5G27fALTeWJ/U1KxbAaSTVvKYQHsTdvyQEghyrtRGKBXx
 zbF0LUWHeyDrJJDFLXOXxUHImFPCC0Ci+6+0zQguB4E6dE/8Egihy6hy9J7q7btG4YLv
 T1l+OZN426Rc/PdQZ9kztRkRqaz5gloUX1SVYKC44AkJUvJbvsKciqutn9XsjaQKWVgH
 h2fl1AUpvg7s9ChVNjrqS0T6fywsN6rKb9yuKcrkXb/Kv4PE3/mHU0r5O5qs3F7OLeIb
 SG9b0+2j0osf3VHxcex3n8Hizk4xtTTRvTCnzYQ1+QGY/zjQuXPREMrhP0pg6ZtDyxDk
 FpGg==
X-Gm-Message-State: AOJu0Yy3xrKX6AsTgO5TtVMxC7mBHOmKE5TtQvfNh4WsD62s6ST/3lxU
 3TRKJFPCwXFRYItBjU0ugt8mg7ahwGMa+F/FXPL+jUPoIImSU1Hgis8PQk5H1A6IujWT+B16Q2U
 dUkXWh3Gam24HV71ROFSFgQIYBo22p+EDI63I7yg+j+1Zv2vDYCPY
X-Gm-Gg: ASbGncsCfxIsMPn25nPN9wTVgHuES1hAUzyPgFCeKfkT6QGNK9Ppb8yX28lN/4aJG7h
 bnVeUVua1xaWIRGyzvT0Q7D1NPwDN83QQG8O9csxRrPnOp4aMRc5PrnboyVViPKDGhQLext6SuZ
 j2diTDHsah5ZKIffTg7dLgLoMELSdTSxgyXdkFDPD1w2FE9uIl3WprQcQXOb5DXo+gTqsbGKTht
 AMW3j344Z8yijwYVqmzqF0QIoYNQvsiaiXZ1kCd5rrohchGN4t5yt5XwNOg8e/938ryKtCK
X-Google-Smtp-Source: AGHT+IG2dPtNBdhu+MWiLmeQmudTw1vZny2562UyoBM+bqLvvazAbgF3CDI3g6RP8F+3zo9+DjQyabMQWQZLRC7X2n8=
X-Received: by 2002:a05:690e:4086:b0:63e:1878:b951 with SMTP id
 956f58d0204a3-63e1878b9dcmr9583968d50.64.1760966595297; Mon, 20 Oct 2025
 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-8-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 14:23:02 +0100
X-Gm-Features: AS18NWA3MraPAwaI5UA27UVboQa0HDxR-eE6mwmdYplIlkFZgL3dOl1o7Qnn-NQ
Message-ID: <CAFEAcA8w6XV6AAycu1nYSqhpoOr3BsYn-x6Bk=Sybz0=FWK5JQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] target/arm: Add read_raw_cp_reg128,
 write_raw_cp_reg128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 14 Oct 2025 at 21:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the functions and update raw_accessors_invalid to match.
> Add assertions for !ARM_CP_128BIT in read_raw_cp_reg and
> write_raw_cp_reg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h |  1 +
>  target/arm/helper.c | 49 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 46 insertions(+), 4 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

