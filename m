Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC15C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6U3z-0000I5-Vs; Mon, 13 May 2024 07:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1s6U3p-0000FF-MG
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:41:42 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1s6U3l-0002aQ-Fn
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:41:41 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7e1b4f96994so192963339f.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600491; x=1716205291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7Bv9T2I+JD4H04PCwBmUc+ZcldaNG/7gTeBCfpATZk=;
 b=ag2+BB9Yw5ZwpBM1ZRFRHpRgfGIukEGsZqN3gdmSkcNQrN7T+a+v+NZtYwIBmXDaNe
 IfbRvMNz3G48WoExqF6fqk5M22d2EQ9LleYcgJKdyI8jHraJExwuGkZXQXXHVfXwXJgv
 yprx3hTTRarn4Ei7BSgLuoYE3UlOs1OhzNTL5M8avtBK0/L+szrGUKgLEs97lttMgWh2
 cHJXc+WBrTPAKXQmcY9660ztyI0pCpYh5lNXtumOcddTemDF8FkYlAh2+gYs8rAUVcFr
 Lnk+lUjm3iQvVuJA+MHHD4bRbJyfT3Uw6yhfP+MJDhOvzLVoNq4b2kgpB+kuoaKFV0jK
 kZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600491; x=1716205291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7Bv9T2I+JD4H04PCwBmUc+ZcldaNG/7gTeBCfpATZk=;
 b=uZ3Mj53+L+5BvbwK4v/s84/IdEGtwS2LZl3IsQaXpZck+ONHgCSF197UAFhWHRPct9
 RFunWauk2+Ox0w939fHqldn5d7Cp9kh+MkCaTZ49ugtZVOfTd19W0+PyFNcZaYRv6jm/
 rkXis1C2Pfcom5+3Cll564NrqG2MmN7rdvZzM181QHzJg1KNLjLpsBZvjTEdsZkfPb4u
 GBZAjN5Q4+at+Gd+3AonbsqQX2qY1ylvrY9FTrJnKaSppGHtF8iiEaBIL74Y3v4Nb5jN
 kbOjXk+DH5yYrMf7gTsL5MmiLMV8JMRTnIcK1LbWMyx90/GB5I66cGaYujnesU2wcm8m
 ib6Q==
X-Gm-Message-State: AOJu0YyjgLkZ8Ovbs2IxCKSnhx/pbkufZWamZ0QF0DW1dX6+TWnB5V7H
 cCYd9qSwI9dHjtxf/YYqbd1f2GEyg+c/RWpkZo9hi53nll/M9OICoJD1rugnMH/L6/qN10GWwEf
 LrBoc7jvYlL89T88LR6ZPD3sSU9kLRl+k/SdJm//5nlOHtDwSZOleHJTT
X-Google-Smtp-Source: AGHT+IHbOwRRtRlKlkkfpwba1jcrAHcW7c/htsmS55ga6CDzuSAkkf2eg2o47AX+GfvIbtjnfC/7Hynb+WPHqpPPMDc=
X-Received: by 2002:a5d:8c86:0:b0:7e1:7d63:887 with SMTP id
 ca18e2360f4ac-7e1b5217766mr1167777439f.18.1715600491182; Mon, 13 May 2024
 04:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
 <20240425000023.1002026-5-richard.henderson@linaro.org>
In-Reply-To: <20240425000023.1002026-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Mon, 13 May 2024 13:41:20 +0200
Message-ID: <CAPMQPEKpVPG96L5FMLpvmNm00ynPyK1f-FVY6yUWp0_RvjRmtg@mail.gmail.com>
Subject: Re: [PATCH 04/45] target/hppa: Pass displacement to do_dbranch
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-io1-xd33.google.com
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

On Thu, 25 Apr 2024 at 02:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass a displacement instead of an absolute value.
>
> In trans_be, remove the user-only do_dbranch case.  The branch we are
> attempting to optimize is to the zero page, which is perforce on a
> different page than the code currently executing, which means that
> we will *not* use a goto_tb.  Use a plain indirect branch instead,
> which is what we got out of the attempted direct branch anyway.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

