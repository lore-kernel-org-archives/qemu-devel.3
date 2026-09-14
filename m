Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4DEC88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x630Z-0006ae-Lz; Mon, 14 Sep 2026 05:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x630J-0006WH-IY
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:29:36 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x630H-00086H-Tq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:29:35 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d46e4cdcaso12674127b3.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378172; cv=none;
 d=google.com; s=arc-20260327;
 b=G/VmvT+XJznc/1asKkVmw+4C/KvGaKSsL0geKVS8o+DHBXiLa7vELdaAD38GeBg5sx
 an+vKbc7AxRZgEC+9XvZ63skLFpE0YcGSfccQTVrMTTgisr4EdilJpypCzPgTBf3CcIq
 kFBrwcfU4jz9EFPk1PfBpHNBZ9CcU0SxjNK5d+fJW9MUm63QVHCdHsq3mABIE7qNP6BQ
 +sIcJ3GkyjqKViUoGxK0rIALLcVlVupAY3Uqi0Vem2qDJYUzc2jGL/C3yfFsavT0U69I
 2TiZm3CimzwjtKNeqeDe3Dp1I81qvQVsJ02W89kxB+qMWGs5MBnS/XDn+voqMhp9MGkb
 0lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+nnJwaGlgH6eFFaTQ5yar1VPfJUy50dmKxlNCgUy0TU=;
 fh=nRI9Fidq+4duWSo7/we2KdFUpsYGvxmfIloNPNqCF40=;
 b=s4TpwQFQTHxpTEB/Iyj4s5kBaCP60J5w6g1/HYdUB9zxrnJqpzgu1kZasziydiDmrx
 oG08j5mAF0d0uEdl24lROFmhqMhhSvc2GOUrp99JzJWHcJ2EKXysbIfdqDoa9Vokueei
 qmNCva47oEVKVsaaW9W8/csGnA3tGOyyDnSSzGHXnx9uBkqSeprmlFCxTCSOgKT6/E+u
 6cyZYHuMdDS1QHYAEsxv9nc0GU1exFxFVubCg/Bb8dGe+IclBjHDKnga7StmhqfeDvsq
 AYcPkjKDWYeob3K5s/tZOpMVo3a8FApXR+htnfpgkVrxWXZz28VKnmtM/suQTRQTpWUC
 J2fA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789378172; x=1789982972; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+nnJwaGlgH6eFFaTQ5yar1VPfJUy50dmKxlNCgUy0TU=;
 b=XBOO4KFxuhYxi4m66QIg6NJRHSs4/Bj4OUjz/obOwxT/9dTwb2rAorg7SVf0/yp8w7
 5U+DXa5Rr/TKZ6lg+jnRwbSGn4NdTrSmHm67rXOqNPVoiZXiPdFeaOiUvg2DFP9xpqjN
 MvRbtobEDlzYElqaldY2CClMc4l0w7sWQnV/cW0uX7XQb62VVVEkaNhTNi+gqYLaPxvD
 TUvhGvlHHKzyskEKlZp+reztBPEdNQz4y+S5AB80eH6GrTTzykh0QVneusQPJM/X1MdB
 YEfrfyhoM7GVZjLDSjdbEef8n4yBT+FFK+ZIw4jswmiHiRMPx9ijvbPdeGf3AIFchDgy
 qnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378172; x=1789982972;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+nnJwaGlgH6eFFaTQ5yar1VPfJUy50dmKxlNCgUy0TU=;
 b=mnN4xNgRjQYcNEKUQCmwNKIGj29p2Njttqf5SYPUPeyG67C6yQjt/dBDOPBDS9zz+p
 57XcIImud3qLYgzd3MlJLIkjYNJLzUJlwIdhsjDv1QiKmA4f9RRIT3VKnL5YdpaakFPX
 fs5+FFfaZVGcQRaPqvWSqedbcggfdUcYgV35oQXD7VQvMBy65RuTJj27zJKfDN0NcJ9q
 foekP9g5jEzXpEM27d1Bkw0UqdpmAF4080ZDjgRHPp9CfPlPBIl1cj8BSK/V3YoVdKyW
 tmHA6SvmAZe3lS3pFFXMpCGrHoOqtp8aWAsZTX3RKdWEY1y2PuDytizlaRcKHwraZavH
 N/pw==
X-Gm-Message-State: AFuF++mqqgCvctx8u8Oy2C9Dxhm+cYvMuHTW8dphNQ3IdQ1dK5eqBeZK
 +gazRLkHMeVLNhsWicP0yBeRwTWxQEG+Cj3JzFQJIt0qtmsKu1/7I+smvYJEbn7a3/3e13Q1FlJ
 8Lml7Sz8LfldhU9FP6iZw3yh9SmVrNNpMTye3CCk9DQ==
X-Gm-Gg: AYBFou1o7O93gLcwqMSvov4UD1LYgduQS/0Ap9RqQBZK7Gt1MVN2Cilfj/rU7x+LpBY
 SC3MJPrxXMp8vi6vl2XVF/JXlQaY497FhYmbC4b1uICadsEyJGzGkZZC3OYVdRUsOelL2/WCE+U
 SV4QxZ1SNGSlTaCeD5BPDZ0K+rhOLtfHuwC4Rm5VFXPajwBCUdiOF85rsXHUmkk+QPWO+jOO5my
 9FEOfpGONm8LWHN2Dhsnc73rQNbYoMjW4bFl0xSk0JUGDx2MJ23qOmL05d3XR+c9kJzj32Omzef
 JV3UwlN2s6bSD2isSmP1ypCJWs4mwPKy5MGhmR6SdlT6Tbf/Fr1lWJuzSNLuFdw54ccs+gicOvU
 HHx7/60KegMMKD37LqlDL86uGO7oRpNf+FdD+FIY=
X-Received: by 2002:a05:690e:128b:b0:671:1620:5b56 with SMTP id
 956f58d0204a3-6714dfc8c89mr579298d50.7.1789378171553; Mon, 14 Sep 2026
 02:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260913-bcm2835-v1-1-b3719ca0df13@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260913-bcm2835-v1-1-b3719ca0df13@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:29:19 +0100
X-Gm-Features: AcwNN1W5qkZ7ZTgrNWoY7SU-bxJhe0texKFx4E5yacAv4loVyh0ochkqEdfQrPA
Message-ID: <CAFEAcA9aJJc_yRNYbATjA8d4ggZr_B=r5EmVNma1rzhi_ZrWLw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_powermgt: Free the watchdog timer
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
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

On Sun, 13 Sept 2026 at 07:44, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> It leaks with introspection.
>
> Fixes: 21fcfb604608 ("hw/misc/bcm2835_powermgt: implement a real watchdog timer")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/misc/bcm2835_powermgt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Hi; Thomas Huth sent the same patch a few days earlier:
https://patchew.org/QEMU/20260910175001.76278-1-thuth@redhat.com/
so I'm going to take that version.

thanks
-- PMM

