Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AB2CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDPZ-00041f-Sk; Mon, 28 Sep 2026 11:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDPV-0003zy-Rh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:36:57 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDPU-00046V-E0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:36:57 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-67413c9dcf0so2424683d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609815; cv=none;
 d=google.com; s=arc-20260327;
 b=rmWHNJ6RTff87d4EvYD2kdYEfbvjB+z0QDLdIYP3zi46Eh7IrZPAeEPhNhAGPOk3KJ
 r7ymy+D/HogjJFGd99L+kJDqouA3BJUVi/HfpQvLfaKvROzzyA5+YJCnw/BUH0OwsiGv
 gF47xjC/F7YYdMlEjGs4M4OZ7BAVme5lxDrthFxwMmLYjhJz9fjas8UuDUFXg4Empf53
 4KWoJ+B4aWfTCy0Srqx7LCHDjCfsu66O7M6NmrUqH6YiGEkR5DrkvtH62ZhKAqRh+54M
 GnDJelctwbRzW/9TANSTzXFI0SyfBOci7WijXbhfcZzfGhhkZCFWIKAHgsAW9fwBQNgo
 64ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5a5z5TBdzXzcWjaqRCZjk3mWtpgfot9Ir2y5mBBuiqk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=mDAgEUCQIUA1MOO1h3V9cXu0Csfmdhms7F/eNEh5iX0ztrXOIQU39tkJw2qqu4uu6J
 SAQAPn2uZGPt2QpAXHSMX+WK1VTGhBcriakTkEgb2FmyCUElADMa0mBe29I1WsAy51nu
 uFwztUUfTQvCS4f67YJAjVuCalgl5IydhkKq3z7DuKd2aGQPee5CekoDZJRn6k+AWYa1
 HxD9YcEwxX7L4FLfXH7KlxK4A1tKmTuMZWpqy/AB3U2CkZBG50Z/rOnO7JtGCrol5eg3
 7mceCuwLCICvQOQn5XlKTNrSeKmBwy3Ya9EYLA3B39bd0UvvHqNUNec5C+HA4Pl2Y//K
 fWhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790609815; x=1791214615; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5a5z5TBdzXzcWjaqRCZjk3mWtpgfot9Ir2y5mBBuiqk=;
 b=Qz8wI8vE8sN2X44StpvvY/CCGXmFQ7sp+avg9FQV39usla8hmtQvQAPQjbQMAv4DYg
 rxDdcqitfl0c5CTwbtyr86tbR0gfYkBphnvwBXIdtlK/PC0emqnG+YH9ROgEs/tZeGW6
 ARtBCLu+F4afQ/VNe/uB80XStoHqo8EdaFYn984BL5XjPvTVR4ILKG54QosJNTuk6IqY
 dkr5Q7WhkYW0KEgWj2Ro6iCFTsoaxZ1EZ/BFbyrzHa6L1Rnbqsg4hb+P1+NmAzbOgpLK
 0pek9F9h5IO1/AHT9Ebgjw5uYYYtVZrA9I0EdwBZPMGkIW4pPL9uNdBahvkQ6Qi8VAem
 sk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790609815; x=1791214615;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5a5z5TBdzXzcWjaqRCZjk3mWtpgfot9Ir2y5mBBuiqk=;
 b=czbA4bCl2hFH78RxOY1ROeee7UL32Sdw2yqeKXIzmfKFemdcGZ4P2lma0yFFQO+7rw
 r+p0La+b2usGq6/Sd9qma4f7TlWXRcTkXzqRF8rVU8GZF87m/DG0Um/VnEYETyWeQIzI
 yvtxoJqnMOjn3pQZGNGtIHbffFTCZCVvTSrsurhKARGluxdvEIVweMQsXjwBrRx92FyV
 aRxzKw8KLaHb/NYOQqV8WYupmDFyZowiAG8wqQY68vKEfh0dA9Ju2IAig2NuRHqHWoXp
 Aauh7Pg1BuYSgzQ/qbh9LFMCUJJuyIJ3n7ZS302KdBMbJl47kqUpE6pnVqzgDJF5BLgU
 K6/A==
X-Gm-Message-State: AFuF++kjy/7mWbS7mu8+Mr10cP9lgeFtQpr7f1eqVvPJ9Gk/wOoiFfM3
 AE5j7m6EvPjmnqEo2kLlRYU6cy3hqtC5v8icMZHR54dI/0RLtK4lcATjFVEDYr36ZhEcWenCQ2P
 9Ci5WqgKJqrBiJXeDJPO9cRIR4XP7w4viffGWRwb4Zg==
X-Gm-Gg: AYBFou0OoAXFFfRnSvZAW3E1LmYiNzwSqTrVGJA4ljROuRiSxr2EMS3EwqhBVGfa1lk
 uTpCsBe35AI/iaRl9vRyQ6IMexqdWbbCzfQLf+r2o/ocpuU489yRYBDJFNTaZHlzDn6/e00lfPT
 wNG4q7rg+OfY/28x7L1JAuqqoG+gLQkBU+lFcKgGQZ5NpcaJ5lyVekBAX2qjDIqsjrdK/sRAJ61
 jId+yLI4YXGn8XGbGIcuzWMfY61RAmuBW0NfKEWgo2WCYQz9x+JRf6qDDBVgB2DCWbZQs4jRP2Q
 c5WiLGy7OxYWn5s/K23bQQ4cZpyHjKy8s3/lCbQtZL/PNksyICnpbFjip8xUriQnYtT6sivzMB1
 NJ4tMWpqQP9JhzsVaAE3BOA9b7W68i5X3BKnBDZD9
X-Received: by 2002:a05:690e:1343:b0:672:99e1:11f4 with SMTP id
 956f58d0204a3-672ed523ab0mr4214756d50.145.1790609814986; Mon, 28 Sep 2026
 08:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-3-richard.henderson@linaro.org>
In-Reply-To: <20260925215004.456336-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:36:43 +0100
X-Gm-Features: AclHuK-Sdmn0RY5k6jbxbp8w59rVdx46jmoMyGCQDJ0eIwwh3bSZl5tErGC-CxM
Message-ID: <CAFEAcA-C=1FH9jf=qqjK76Eoy41aGgg=Cy=weVcqBa1C_RWtBA@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] target/arm: Reorg rebuild_hflags_common*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
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

On Fri, 25 Sept 2026 at 22:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Invert the call ordering of rebuild_hflags_common_32 and
> rebuild_hflags_common vs the rest of the flags setting.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

We do have "set a TB flag and then later in the hflags calculation
functions read it back" dependencies in a couple of places:
UNPRIV, ATA, FGT_ACTIVE, PSTATE_SM -- but in all four cases
these flags are both set and read inside rebuild_hflags_a64(),
so reordering whether we do the common flags first or last
doesn't move the "read" before the "set", so it's OK.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

