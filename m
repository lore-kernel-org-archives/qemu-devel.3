Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573A2C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6cvk-0004I1-Dl; Tue, 15 Sep 2026 19:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cvj-0004Ht-1x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:51:15 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cvh-0004jj-HI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:51:14 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2db18fe433fso2967315ad.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789516272; cv=none;
 d=google.com; s=arc-20260327;
 b=rYw0osDAZwApl2Bc5RT2g12HvaL3LoBSd2vYIk7lPoZf7KQ70Jp6SXRrD4vnDY9/p9
 vwqYNUI3ew2Oh8FVrkESHPo+HXn94Vi7cRvxu3vHA50cs5y3hx590vsMypw3N33/v5W1
 bwZDE9tpgQdKx0d4srlHCK8RCK+EKZH13f1ov/0Z4jCAisu7W0f1/xeu3r6FjGyNHpEn
 gGw+gpAq38I7wDIuF8Tf6DYmqnig5yBNGDGYkliQbY3yw/bWhIWVvnogT5bqNEU9QQ//
 m367lmSUuhPiOZBrhiydf2gTkdIjgYaxMcK2Zu4L8EBLp+PJf2ScvZNpdLk9w29I8pdI
 kF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fMRMWXUelerBOkhz92trC0V1BLUNAcW51am+I+vQn3I=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=XBd/ZzDeD3W/4S5x9d7ufuqHuqfBIPDsHlqDEQ9raYJNwqfgRiOr8wpQhWW3Xf8K7Q
 gHZQ+lK3oKkMxiADlz8HC40AgKlNLsmMKFWvH0Ra/V7TGMl48Er+emLpiLZmeoF4uFFx
 Tk/CdM1XNnc7uQTVLnDOmgh3Vl0BhsFzSdoM5IVu5uH21s3dAqsr4dvmFP2VeAw8oISR
 RQXxgG1wU/5JwmhhzwIk8dr106MujIARbM8ZCYYjxUlle3N1k1RTXjYpfPrO+NnZ4ZDy
 zcMcfVHLz59avriaPuUwRg9SejP7NrgD8vP5AdCQStiZUeOZ0Ri26tslpOLC+oToybA7
 Gc4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789516272; x=1790121072; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fMRMWXUelerBOkhz92trC0V1BLUNAcW51am+I+vQn3I=;
 b=Her0LEdrO+0Hj+VUxHkOI8p69Er8WTb8jvEWlOV0uPI31ZIjevGI1xgEJDCs8pun54
 muq5NMjAciMDZvX2ui2bRcloh84waHMk+FCJq0RtQ9sLWUF8SHJMYL5ArE2yWoVQP6X4
 X6ukbbUWGtNZgFfAIZqpL+FnyCIfEKLcphjg5UiiMU2kseWesfDLL9nAjBtPamuCbin7
 OvSIg74TCTsOM+4BFw++i6rYg/iJvo5Ge6IiWT+m2QLB9AnLN76epD/PffFKPpP1aKVB
 y0H/iBUqhB/fe2VTsfX0f0wdGfwmBjwDTLUBhiq6rfkbLnZt3688AJ7vfFcckruUtzff
 62AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789516272; x=1790121072;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fMRMWXUelerBOkhz92trC0V1BLUNAcW51am+I+vQn3I=;
 b=p4/+mjdud9QI2zDSAa0BW149fvUWse17DSk+bByz7eVOt+bIu8uJ6mY+ttBXX2BId4
 ZPmRVNfJgFUODGL+80lamQJ+gbWuRUkUpoehvWtsIDkzsnmqhTilBduIKzE8QiugFqY/
 KTnJkmAtoBke6H3vr8pnJ/wa7WpASuhhZT/rFc4l4ipDgiwkVdBFKFFKtO91HGLoKYII
 gDY8ZrS9Wp7JFSVtSzQJ9FDWC7saq1MTvceuXTNo21vgKSLD32VpvhZwD95Y4Lbs/7EJ
 hXRdJh0SEG9ERr72TFxEmMobPIO5CBg5SiOnzwpXp/8Y5+AsbaO9eHe6+8orEdCxGx0U
 nyOg==
X-Gm-Message-State: AFuF++mh0XvtLqMBks/w58ThCh+8LB522qisI9hiSTuDTxnzLdvjo/jN
 ODrpbTEOOV8nnIxMWGJK2mpikvL9DM8DBoB9X4Fx9M5mxP0LFONEnn/QWcognd3RtgYc4I0AVZH
 Z+qsUZxL+xupR6USFFwSfebjTv+AqIow=
X-Gm-Gg: AYBFou2Jfiv41WSHE4Jdo82M9DXM++WoACMgJXMgCNnsmpVEm/IKvbV0Dy8ZxtMefpE
 QEUrvFcFmDXk3HkQzwfIhcICQqE64QX70N8U5iTsrtKCnq/ropL3xWiBBIaOOFItZa3nDiVPvSL
 pVRX2GKFe/KN52xeuFi1O88yDXpRI9I8I8ZdiL7dLCSwK98jq36gPv37mL8sXyVB1aVUPGx64HW
 zw3kix7hlbzYjIMYTBjBW4HYs9wUXayctqIa6UMxwd9V5QWtcG4StHv7D3FUMUP0EO9tUrx8TKF
 U6IpgtDiuwvceiOLEpRqe0u0dZPipV2BUNXoU8QzumFhibeUfJzLA1I21iaRpQPLT7MOUfkmbDr
 KyJzuKuYOJfbxkZmfp85ecQ==
X-Received: by 2002:a17:902:f68f:b0:2db:20fa:9443 with SMTP id
 d9443c01a7336-2dd8e5247fcmr8003135ad.13.1789516272190; Tue, 15 Sep 2026
 16:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
 <20260915154502.4106597-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260915154502.4106597-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 15 Sep 2026 17:51:00 -0600
X-Gm-Features: AcwNN1Wkw-KmwZ3KhSlJMN4_iQNltDulg2h5B934aalhrjdRykay9NSG1AnPVVo
Message-ID: <CAATN3Npo2ofcFHAz-eCTogcnHihahmahdfHdukOWd77N20VakA@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/hexagon: drop wait_next_pc
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000b9487e065b8e39f6"
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b9487e065b8e39f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:45=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Read the live PC instead; it already holds the same value once the
> PC-staging removal in the previous commit landed.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h            | 1 -
>  target/hexagon/gen_tcg_sys.h    | 2 +-
>  target/hexagon/helper.h         | 2 +-
>  target/hexagon/cpu.c            | 1 -
>  target/hexagon/cpu_helper.c     | 8 --------
>  target/hexagon/hex_interrupts.c | 4 +---
>  target/hexagon/hexswi.c         | 2 +-
>  target/hexagon/machine.c        | 1 -
>  target/hexagon/op_helper.c      | 7 +++----
>  9 files changed, 7 insertions(+), 21 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000b9487e065b8e39f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 9:45=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Read the live PC instead; it already=
 holds the same value once the<br>
PC-staging removal in the previous commit landed.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<b=
r>
=C2=A0target/hexagon/gen_tcg_sys.h=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<b=
r>
=C2=A0target/hexagon/cpu_helper.c=C2=A0 =C2=A0 =C2=A0| 8 --------<br>
=C2=A0target/hexagon/hex_interrupts.c | 4 +---<br>
=C2=A0target/hexagon/hexswi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0target/hexagon/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 =C2=A0 =C2=A0 | 7 +++----<br>
=C2=A09 files changed, 7 insertions(+), 21 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylors=
impson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></=
div></div>

--000000000000b9487e065b8e39f6--

