Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58CCCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBELU-0005D2-Ah; Mon, 28 Sep 2026 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xBELN-0005Ch-Be
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:36:45 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1xBELL-000265-OK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:36:44 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so1817032a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790613402; cv=none;
 d=google.com; s=arc-20260327;
 b=XywBYTbikM9FL3VFLW1EqY6HWAoA3Vrf9lH7Uw5uVe4qhQvN8jnfeT7l9W1WDMPqVN
 6tJifYdKIGYj28PgV5GKJw/MFU8zbLQ1aOBsNAWjTbqCME7iSy/8EO7oXJare+PWvDXo
 ZYU2NosfWE7w0t8IBo7xRof+dDM5Tu+yNiQ9514Gguh2O9H3QF3GzNi0RQnKRLsW7etb
 kJfGb32UPn3hKKij3K2FN1t5YgDq1iOt+7MEyB6Lcd+NSEpMFlK3u1rPi2MqXBjjMO2n
 vohWYMBSkDwoV2jYfYHmkY3X9s8I3oQbFcV3DEUF7yi+GCx5OkY9InVkIonBZxvWW8YR
 omlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NkVuU0j+bebAFPDQNwPXET2UAiI/Ff5F2Ff1K6JPqjw=;
 fh=aFQfxpNWovoQ01QbmIMn6V+zwDnbq7aiAeCFl39L+kU=;
 b=Fy/IadP8CfFau4eAiGBUr/nMyEng8IjS+wcjlAkVQd9fL9rG2jJemIwpiBjO5oF3Ph
 FYxRB9oT16EWJmF29YnF8tog1yoHO5O71FhghHeqi4HB9fc7p0BdS8X+grika6micVcg
 Gi/+njIGI0hhDPu7a95wlghnvxq9/nQuMYkwgFWcMxxS84//926PUaL+scTX96O/2jWs
 0uFD2wRMeb/T3zs/quZB/+IcG3QfSsKCGDnvwIm9PXevUlRToCB/mvV+PceaZPAdE9Qd
 Crng7TRN98z6/WRGXxEpUTQ+mtcojK4+2dOYoX0KaTo1j2IOLRFYMUWiM0cAuf1HNBqA
 tCqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790613402; x=1791218202; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NkVuU0j+bebAFPDQNwPXET2UAiI/Ff5F2Ff1K6JPqjw=;
 b=jwfF+NxMQq6SwGdZGlhMneE1HSR/nWWyau5T5ggLw/9nhGwwCGOkZFcKRe0supxbsH
 65JkeNcoIg9v24wnIsuGG7yzjBISAaeRbTqWyozdBDk7bVh0g5DkNzJSll43Ormg8GLO
 NlegFHl3JCgUdXaoTi05NZAigMDzkbkbpahyitekmpGMoTYXTk0Hi1cndHmO0zCzhImy
 b4c8LkqFt2j+lC71psckxaaAsu32TdhvXY0c/NCfHrHjTqJcY1bReF6Lk34YRPdThg7M
 pk4sVBhMzmgR6P0FjBjyq2yNdF8f3kNoWjM9OEgq9UdAGSc5cu1F85lWZIYuNhVKTo6X
 3Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790613402; x=1791218202;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NkVuU0j+bebAFPDQNwPXET2UAiI/Ff5F2Ff1K6JPqjw=;
 b=EQKO+iUVcyisKhaW1iLphj3F3LfSggnaXznIaRctVfMLEgJAPhcW2nOIzfeSgVC+/R
 8/kj/x+imu4ij+GL3htBydHT/7TRu8aLaKYOXUfJuETQagmo34Vpg23l3n6KHXXEL112
 6jh5ps3hY+LkTeth4R/BNuk5JZTDJGZS0IiRcz5h4p7EK7dP0itKuX1XH/yg6OxkFTSV
 uEKh0g+8okPOWHq4WKUaPvrbSoSUKcLGDWwhZX5m2szp6rH8is2m1DRUI374epMBoelQ
 SLpyOZ9kh2WHa2AHhMuAwW94AaqAf2PcwwdQml2Nhpg9as0v3cX5BEAUpyjTlVb2Q3eS
 cl3A==
X-Gm-Message-State: AFq9FYIIJgQNnF/24XAqfJFxFb503FQ7lerWVPbiVWDEPxVMcwopS8BF
 lNyz5hzSRMrIbzNftqU97Of5Om8veOVm3bu5/ZjmAn9AaQ/GT0+NymjOxgNTASQwKHV16Q7t+8Q
 fcIvK2uA7n8HY3ZB32wUHrFBW/nvPLzM=
X-Gm-Gg: AYBFou2hhMte+uFtU2Clu7Z7OR2fUzq3mrUib+GmsPmkI46A7Bgh4jzWYlvoa+RHtE6
 eizyCU9L4V8NEcu+vRaAqV2Pm8d4awR16L6lh+dI9UuNz5GzxVuhDCuWylbcggRpTAQnfdU183p
 IzOQO+LNI/ZPXZioq4VdCpt6CiWQJ/5fa7mhpRGGVo3+5bjapyRQ/DB75m0PSQ2iYfeK43fz89n
 VqtjyGH8v3XYes0a71vPofR9sCfst6ah6yobwzfOXyCpsyPfJD0BRs0cJlpfJ/OiyoAwonVGslV
 S2QvjHXAopITVFReV3FtqrEZdtqdIGDllT8armQgxx7Vwr8/lHRAyuiZ9z3jqR1cPk2y0Tvn4VR
 yPOjsjIC2KNE=
X-Received: by 2002:a17:90b:5292:b0:39e:6c68:c784 with SMTP id
 98e67ed59e1d1-3a098e56107mr11412996a91.58.1790613401825; Mon, 28 Sep 2026
 09:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 28 Sep 2026 10:36:30 -0600
X-Gm-Features: AclHuK8BbqAEfwPOzylwyTAFQhSPVKLuM-OuDLizddAvbL2aTZpPLOE4g2R_110
Message-ID: <CAATN3NqmGA4+BdgjiYue_mnP8F6brkcWchGEqFxSXqm9bBUsqA@mail.gmail.com>
Subject: Re: [PATCH 01/10] target/hexagon: Allow temporary HVX write and
 future write
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000bef5a0065c8dab0d"
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000bef5a0065c8dab0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> HVX packets with Vx.tmp/Vx reg writes were incorrectly rejected.
>
> Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000bef5a0065c8dab0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 26,=
 2026 at 1:23=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">HVX packets with Vx.tmp/Vx reg write=
s were incorrectly rejected.<br>
<br>
Cc: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com" target=
=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.h | 13 ++++++-------<br>
=C2=A01 file changed, 6 insertions(+), 7 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></di=
v></div>

--000000000000bef5a0065c8dab0d--

