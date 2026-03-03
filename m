Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8502EDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxX0p-0003TU-IF; Tue, 03 Mar 2026 16:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxX0i-0003T7-5u
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:10:33 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxX0g-0001so-A2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:10:31 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3598b95ad7dso2006504a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:10:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772572229; cv=none;
 d=google.com; s=arc-20240605;
 b=gs5G7uPLO/MuwaY4bGZlvwQ08/0XMotgS/oLvmCGx46nz1aLrcQOsoVTYHg9YgeHPF
 vFND3+c9/dznqTrX2WPZ+p+TbfVe3vxWHH/2FAEcecW5yhW34HHz3bcMFXzyt0X1+HUq
 SWGHq/b9tSHeZPSx584NGmwBWXy6pHZYvqrsOEpw5I87hyDA9e3bNAQ4mscq1JmiZ3uY
 nEhR+d6q4h6T9a8UGpofh0fuR66jv6nR3AbshI8drmofk66U4+7/iFu3R4zLDriNcmX4
 RbBJ6eLV7BO/w6FsCtbuqf/G//CGivTModvCbDuX/RRUJ8QsLweDErZaGn4jRGPlbztO
 SiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P48zqWmSnLH1BfIPPdGGrtFwjuq7bP/3qKht/FFDI1c=;
 fh=LTC/EzKqonC77YLlFp5XpY/nmmTX3D5H/BmyinvQv1o=;
 b=QcgBG/I8qWWrpZLBcdg0C6uUzEAu8SDqzd3ERhVdWORjLC5cTMVAW6tiayfezUv3vo
 GDr+PPu4Zql2c9jwdWjACOHeqBgRm+c5UahOJGUyRGMuvHHordrEDKps7B6Sk2LCXt4C
 o4Rc+aCWl9T326sO5E8tlbsvrP+xIsm3WcqHk86HEKr+GR6vC7a8wTsforDNn5yJwxPq
 ivWy87FPAp7AWj1X6SOq/dmActy0O/hJAIswrbqXoMCCn6jZi8dt7EjSRSSAmCwrKfaz
 upzBjRcykZmIbY5Qk87ZFCZ9oU437cPy17Ly4LwTnA+tcShSQs1VPS1tKZjI2RHNucZU
 zW+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772572229; x=1773177029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P48zqWmSnLH1BfIPPdGGrtFwjuq7bP/3qKht/FFDI1c=;
 b=R2H8bpMdPSFEc13mM9VXr8XVeXs0wVeqTI1NPQQ/zYc+dYpvDz0rJtrbUMvP/Hqn79
 Nkpy2gK6WtQoIn6r+bXywahTZBkvd31RkhYqy5MVkX0AySuMxozg7mGZlwynnnIvuwrC
 GHYRrenzfXq7iNL9ck+ZxMulhaOBIDlQCWki5OZdG20VXu/Qj8o2hRzwqHTN9qVf09T3
 //q0ym2SaIOOO8X3lWU5tamcE3cKDM6lHzJD420DMlN4ak0+BWSqpCx+30wmkPosysOH
 fymO87gOcsKT03FgKf1PDkYIoolCaLRH0yQR6fenTbjo1EkDt6xVyUrWCXsMMWJ5kcJ1
 QDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772572229; x=1773177029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P48zqWmSnLH1BfIPPdGGrtFwjuq7bP/3qKht/FFDI1c=;
 b=VxwABighAd/hCenY3GATEn30g56E77mguYTfCd4IWHMjs2xs09QU2azD00kG3ulNRh
 H9cnMAtxGMBytHLlcI9iUYnfUjh9zNDZc9oEMPTl6colUUT7Ablk1yuyyK4LzwXiP3Y/
 mtbz2cXuxGyvbRYNWGh6as4Zlpp1VvJDNMR4SL6vB97oHO1RhMJdUYJvGxBQgEcQyzS3
 Z5wzke19J05ffEvaKQbKFcHcIzx0+4MCQzPLbOiv/kxsPfdgThCAWvA7/06vAje/10tL
 FwXOuDZ/KETWVC2rxIOlca/To72fA0M5Yf71PUn8Kj1tOVQyi7O96UEh5gCe4fXZNzWp
 alvw==
X-Gm-Message-State: AOJu0Yw0osbflnrB+pD/WDBIw9u73nUE0Mst6v8O0yARDeg4dqXNccu2
 QCImmvbkSOTrjQD8LvkhDDEjZdmeOPX5zpqDgqvPCQV2ZolhLIKLOGBEbWpoYtMyaGzZPfxzAtj
 rY5IgphEU7Q/mcVh6AqTgcnQyxmckC0g=
X-Gm-Gg: ATEYQzyo25pIlToTYv+FAcqps86N1gaRFEdPMqDid0ImQZEhqSq63pCl3xTwpbuuuSU
 R1cjAQJ6cbnapqFA2Zb0cbNMZWq6hY4Sne8vZMhNft4PpvBytyUKkic6zXaohMTXPxLnn6zeNK4
 Lf6pvVk9CB/+M5QwtxKC8xo2+H6aNVQH3OE96raMKlPTKPSfv5tzWuWBaI8V6HGBL6clPvz2oYK
 KCL2rwPSSM/XxvEAYyHVUpSdW/3kJsydzIzE5gnyaf7xvBebR+3X+5ujMsIaG2DrrqmPrecEd0k
 wXiB9bYMDdaw8inWfqNkcMe2OemnB0o7s80Rl03dWI35AnqG0g==
X-Received: by 2002:a17:90b:2487:b0:359:8f13:667d with SMTP id
 98e67ed59e1d1-3598f136724mr4522716a91.27.1772572228711; Tue, 03 Mar 2026
 13:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-31-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-31-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 14:10:17 -0700
X-Gm-Features: AaiRm51UKsUqJTbRp12VDEX-OBQk9jxJjAyf_kEcxNFdS9JPvXe-fvqLyWEsjqQ
Message-ID: <CAATN3NqGRohm8MDpM0_DvupFW4F54iGOXb78YO01-rDfBH-Mdg@mail.gmail.com>
Subject: Re: [PATCH v3 30/37] target/hexagon: Add sreg_{read,write} helpers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000007f9ce064c252202"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102d.google.com
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

--00000000000007f9ce064c252202
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:37=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |  8 +++++
>  target/hexagon/helper.h     |  3 +-
>  target/hexagon/cpu.c        |  1 -
>  target/hexagon/cpu_helper.c | 70 +++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  | 28 ++++++++++-----
>  target/hexagon/meson.build  |  1 +
>  6 files changed, 100 insertions(+), 11 deletions(-)
>  create mode 100644 target/hexagon/cpu_helper.c
>
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -338,7 +338,6 @@ static void hexagon_cpu_realize(DeviceState *dev,
> Error **errp)
>
>      qemu_init_vcpu(cs);
>      cpu_reset(cs);
> -
>      mcc->parent_realize(dev, errp);
>  }
>
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> new file mode 100644
> index 00000000000..8e11cbb20dd
> --- /dev/null
> +++ b/target/hexagon/cpu_helper.c
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef CONFIG_USER_ONLY
>

Is the complete file guarded by this when all is said and done?  If so,
remove the guard and put it in the softmmu file list in meson.build.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000007f9ce064c252202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:37=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Co-authored-by: Sid Manning &lt;<a href=3D"mailto:sidneym@quicinc.com" targ=
et=3D"_blank">sidneym@quicinc.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_helper.h |=C2=A0 8 +++++<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0target/hexagon/cpu_helper.c | 70 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 | 28 ++++++++++-----<br>
=C2=A0target/hexagon/meson.build=C2=A0 |=C2=A0 1 +<br>
=C2=A06 files changed, 100 insertions(+), 11 deletions(-)<br>
=C2=A0create mode 100644 target/hexagon/cpu_helper.c<br><br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -338,7 +338,6 @@ static void hexagon_cpu_realize(DeviceState *dev, Error=
 **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_init_vcpu(cs);<br>
=C2=A0 =C2=A0 =C2=A0cpu_reset(cs);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0mcc-&gt;parent_realize(dev, errp);<br>
=C2=A0}<br>
<br>
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c<br>
new file mode 100644<br>
index 00000000000..8e11cbb20dd<br>
--- /dev/null<br>
+++ b/target/hexagon/cpu_helper.c<br>
@@ -0,0 +1,70 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br></blockquote><div><br></div><div>Is the comple=
te file guarded by this when all is said and done?=C2=A0 If so, remove the =
guard and put it in the softmmu file list in meson.build.</div><div><br></d=
iv><div>Otherwise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mail=
to:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br=
></div></div></div>

--00000000000007f9ce064c252202--

