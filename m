Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3CCC982CC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 21:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x82ck-0001LY-7C; Sat, 19 Sep 2026 17:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82ci-0001Kn-Ux
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:29:28 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x82ch-0008LL-Fa
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 17:29:28 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8c5231570so1478032e87.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 14:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853366; cv=none;
 d=google.com; s=arc-20260327;
 b=rKhuGpJ7g8MgdEqUVrX/oOGJiLuaJjEMavwa5QDhbcAyxtWIAg8fsne5O8Il+zYl65
 br4tOJo1fft8k9u8Y0ATL/WuBXtYrbcEqB403moIfSysqezN6nWFl8nd+WfBYzIa+wMd
 hR/7tCYCYfFxEYWC+HAVYAee2Tk9k7QRys8ECKLyK8FoRrg50qe9IyvtT358Mim1hvsN
 zYxElqDUS5kk/1+PTnhZtRNQBzrsR0le5YRi984zACOuBa+0bLkyTHhVbGDy5tOChhDK
 NTuOuIvr/JYJHYr+lMELBn44yiTBVhNfax9I9hNCgD75AgSyjH5l+9zD+Qxbsll5Md8Y
 hgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fuNWABrishWnLrDEhHBF2am3xP3fBgsX85ikthBwQlg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Fi56YkcSQncWkfH8BJ2wkoQbxKjjdi4jbGfRlFS+sidOLmypKv1JirHxBkBvPaNyGV
 Ow8zwhAiYVC6bgFbBhD8IYmD8Hy3kNh5ZP297cRbWfFPPtaU2DgzbiZoxy+zaiDb7+FP
 jHtxObEKKEwwv9LiJF6cTzUlOvrp7rFPrK4oNFaMqWyf0vbH8t4PTzBreaAvdt06+U+k
 bf/Hx7I60YWUyA9YUyGIq5nSm6FW9maUQsMs7nxRQNJKGjujCMw8YAnCrf6tqJAUC3GC
 gowlsVbqzTvSN/FUxrvqZMnwle8UIAr6jgHSoj+cQlih+tWXSp3hfFe2t9EQwZ9nk0xz
 RsWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789853366; x=1790458166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fuNWABrishWnLrDEhHBF2am3xP3fBgsX85ikthBwQlg=;
 b=g0hTS/NoC6fuUGHX9DZq0MSsis5Ga/7BqHAKfyEBFDZapWsHebASisrX/wneQuyicm
 bidI2LH8MesPKzRbKeo1SpvkOZSCjejAGhrj9lmdHe+ZQPZ1kZ9hXWkLy43oPk0ES+da
 5adaV2zlBpRkKrCXGFujekwyDs/x1UtQZuCfl2t/N7Zmr6CsryP1U4EzUeci4U6QEF9n
 QagkFoyJvxNJ4T6Ewc8wu1MM8ZMefAgLQVCTR4sEiMZrAecAK6sEO0a5NzLP282PP9aF
 1Ygww+EZ0R0YwEfH8xGlXCN+l0QVwfwd1nrpe639gH2uOytNTooD88RxVxLjxPAlfGNs
 Jm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789853366; x=1790458166;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fuNWABrishWnLrDEhHBF2am3xP3fBgsX85ikthBwQlg=;
 b=U1P+Z8GpMEkCRM4vXPPqTsOHuH3GY+poKliaY509K/vQ7h7VttJcgZUzDXmLOIyhRG
 Ms/2Y7beM+z3U1qUQR5KgDB95TbXfPENyQWiw0YHcP29PAVWzWJxTo60VjcOOUNkRi/j
 Mdu82B4cqDH2zgPI8Sp5Lg+zJD4+VeKubj5FkopGDO/fL/30TuL5wuI5xfhDP+yV7yz3
 TjXFYp+1Mys7T8MNa8EvzSsJuSTqJba/itqsOLwym9/OfrAK5xlkqXVW/FMuLyT8A0V5
 TWkvoKM1tALTTCsoH6vPHbRQCr7ctbcKkPKU0/SENRADPigrylXLTWo+VL4BTx+LiAtg
 qITw==
X-Gm-Message-State: AFuF++kh74bcQ8F402UXGzgPjLxUmaPtataZrSPiZTj8Teu918vHLqHZ
 3J41ZPoFB6HyzkoIzUwsOezu3yOhFfUEmDK/EhXkWMhxUyd0ZWXKD8vz4uUvYHYkh11vNFAqhBO
 +rjDjYoplfSMTjNZeI2jhKCiWvS5OGnpgg8Zc
X-Gm-Gg: AYBFou3g0CO+/Q7T9gW55DU71G3Tt3VTKQnQwi3EROo6mn0ga2wqVDyUAPjVmsZ/hPm
 shwEeSd+OszFUoCCVXuWo48D/6itaDiakav+oxnSLHCvie8YzbzV7Ys8U5TQqqyQSt6gdIOKio/
 NVAgEgiWDwK3gNCO0JB7o6RMjSfQ5OymQDJjOywcQB2ZLHn8i0NTe1A61IjMGGKCusDyVaTlaEM
 5VccKvBe+lJ3WxphlyFWJFMhaibywgnNmI//9hzebiv77uPhMsMO5TBhwlHD1ONw8jH5NBTJHED
 QOYFlI/Jh13u5HC0jct+EghmwJs3mHsAqsOVTuQWZ3cUWbu7IbUc6BLRFWGavOPF+E/++HLz6y0
 n6nbnDMYIzpg/cw==
X-Received: by 2002:a05:6512:a86:b0:5b6:1783:f0f2 with SMTP id
 2adb3069b0e04-5b8c17eea2cmr2201388e87.13.1789853365744; Sat, 19 Sep 2026
 14:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
 <20260917093307.1092084-13-richard.henderson@linaro.org>
In-Reply-To: <20260917093307.1092084-13-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 17:29:12 -0400
X-Gm-Features: AcwNN1XKz6q35nV9JJeEIr5VcqlPXhdqRJs1EU1uzMhGUaAVf-9DuDrZe08PjZM
Message-ID: <CAEdQ38EdmX0tUGs2V0xBRCpyj=OxdnWsMir8ONyd+L7FZDoWfQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] tcg/aarch64: Implement INDEX_op_goto_jc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 17, 2026 at 5:33=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use ldp to load multiple values at once.
> Use ccmp to reduce the number of branhes.

typo: branches

