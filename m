Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43222CD6E51
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTXgI-000174-Ew; Sun, 31 May 2026 00:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXgF-00011O-9T
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:21:43 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTXgD-00024s-5v
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:21:42 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36ab8816a35so4157637a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780201300; cv=none;
 d=google.com; s=arc-20240605;
 b=CicTbx2nmvNSdOjMXcyki3TAyiaMwiLYa376aGUj1obC/Nox3a4fViFu9CjkImvOEv
 uI/nxUrjASH5jMu/z63Rm4zeLU/HLHoysaBc5llJMty1hKyZA6NCNyBuRSvfryreSWPF
 lVzOKMWbeuQLdVN5850uv+RVpncXiR1Yd2FpsO+1lFNCUe0PH0HyPrAnZL0Uu8rNoZOk
 ebxbO1CWtkIc3CBMUWQcDK4i2JojDAA6mm/Xko/cwVWiMymF3ONVGtiHuApZGfDGvScQ
 bAPXnYlpeHPVge3mgT6x0FNzHew+qHYfSObNwvKL2ggfR7FGqLcZYL+O+DyQ0h+Ie05S
 Rihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MlXH6qehXEGDuJ9bgVUkp56Nsht/7JkrkIygiP0yR8g=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=k09S1D5Cy3TLwanqQHkrcVuMt9WXjzjWmWjnytQbaB811mnIrwYrB89dSmy9SVKRiL
 7iV5SXboFFZa+Ow2/ZtdUtdd2Q37UtRv6RX/plyA3NmsIaCqIzitVUPULhkd9Lyw3TeI
 t1m29mbbPIWIhmjf51L7WdFovRWAfDjC1YQhd0kkRtQT61yQlW44iacK+OvVUTe2X4WL
 80jvsNNtLpu1qdzgbd/qz1c4hN/ogGJ7X0fMfaE/UYZUQRgDvgfcV69o8gguvnaX/Jje
 U+mFnAq1QD6smPPoPhx4pSId2WCLY14ejP2lYcMxzsRgAtUu6364a6UZc5ytyri/+y7n
 3+Jw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780201300; x=1780806100;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MlXH6qehXEGDuJ9bgVUkp56Nsht/7JkrkIygiP0yR8g=;
 b=K5yko4k+kb4THTsOwGTF0Q13J2dxZBRqWbmcg6S3O1Y+0vawhxUHvXolpgm8bLuTBr
 YUcDYosM+5p5MAj7ixYPHYl0xzwOsJsPTep/toKV8rrCQZHP5Vi1CNlLpsr/sG4O1pyq
 bvJilVJ7E572vdlfqxLQw5DB3mPdkLH89jP2s1CO1keG0sabZRMD6Hnk9IWQEjlFkCOQ
 TVsfRtxL6gNJE1EfZLkx5IMT+CE08t35Ia/0f7FrbEv5s746zyXbdL4hZiFsa+Y/mVtJ
 3lWnzoX0GhxE6JLy3aUJVASJz8pE/39L5cyP30fCbUi/3LGW7Kwi3wXZi2hJ5ujLPfi0
 CQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780201300; x=1780806100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlXH6qehXEGDuJ9bgVUkp56Nsht/7JkrkIygiP0yR8g=;
 b=OS5Crq6b+pDeKqJImCSdZ2+ehYaOojhvfnC+WyunSRd7TTpEPudXJl/r9uiZISP0Qw
 3/MPyoCDl6bgsHaycskRvWXy/Jbm2ZsQq3gMXNWeK28MM2BhTsoUUzY4fVlL9gOPQzyG
 Exrgl07jwsboQhqbzkBugCRKS7vYLasY7unf1n0rRZ+fYzXwW5ZAOwAqIZguPIEENEgw
 1PrebA1Kx6S5UmiFe+GKb14GS+DvPaTTWztOLsSGbO58eWqtkgZgXCkuEMek9g5/plyv
 fxYNnLOf3TwcdvU52rXfV34goxMHM0/B8HeBFxOB95ixkwvWdLmtM8qwSLdhXuJjj+pq
 FGvQ==
X-Gm-Message-State: AOJu0YydaqO8IgCFMwlRHNKAMeDd7llGNAMY2VsV04aVKrPgg8reeek9
 HVOfulu2fNNB0uIOER2O5aed+50PjIO73bI+CQFDTyHniSIgWdlnE++yDeKGTdzjfCpJ4PMDDJx
 sfXZczOF+wKHbX6p6r3cbG/5A516sRKOo0RMD2FsAxKHsMzLFJR6o
X-Gm-Gg: Acq92OEw18GHXWOVmapASRFx75hWJZenQfQXZWWxYLxR9dL9uvEXX0TX7WgpVH8MNNK
 /CuGB54Zgh7j0z5kL0G1qEWVTEYWq+kO77kkNeJRU8xc/f71lwDg4cEvWa+UJ9YYidyeVkciwSQ
 o9xHODof4Xug7P5RGULJADIiDf4W3n1eDQMUhCF4Fj55EpXF6wtKvLyULYiKmNpHgOiJQ8Ql/IO
 KuCDeaoNlkYA7eyiJMvwkgo+Is9+1s22LN62TSWk3mBlttiNYEELzI0SQ0qN+F5BPAFp3eGfPhD
 N74/P2RTuLhKFEabfVRPgBOdQp3moBLj3Q8EbCxWqvIz/8Q=
X-Received: by 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-36c501eb0a7mr5754690a91.16.1780201299853; Sat, 30 May 2026
 21:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-9-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-9-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:21:28 -0600
X-Gm-Features: AVHnY4LuE_m7jE0a6rf6ndDn3YU1bjuQoAZTHmGU3Wxnu5rx2dSyPRKFawJYQdw
Message-ID: <CANCZdfp4FCNcNvzrco9f4QCuMmdum516HfAVn80-s2gLG9iXLQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] include/user/guest-host: Include missing cpu.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000001b51760653156a79"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000001b51760653156a79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:13=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This file uses CPUState without including the required header.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/user/guest-host.h | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/include/user/guest-host.h b/include/user/guest-host.h
> index ef83ad8a18..506efc097e 100644
> --- a/include/user/guest-host.h
> +++ b/include/user/guest-host.h
> @@ -10,6 +10,7 @@
>
>  #include "exec/vaddr.h"
>  #include "user/guest-base.h"
> +#include "hw/core/cpu.h"
>  #include "accel/tcg/cpu-ops.h"
>
>  /*
> --
> 2.43.0
>
>

--0000000000001b51760653156a79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">This file uses CPUState wit=
hout including the required header.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/user/guest-host.h | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br></blockquote><div><br></div><div>Re=
viewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com=
</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
diff --git a/include/user/guest-host.h b/include/user/guest-host.h<br>
index ef83ad8a18..506efc097e 100644<br>
--- a/include/user/guest-host.h<br>
+++ b/include/user/guest-host.h<br>
@@ -10,6 +10,7 @@<br>
<br>
=C2=A0#include &quot;exec/vaddr.h&quot;<br>
=C2=A0#include &quot;user/guest-base.h&quot;<br>
+#include &quot;hw/core/cpu.h&quot;<br>
=C2=A0#include &quot;accel/tcg/cpu-ops.h&quot;<br>
<br>
=C2=A0/*<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000001b51760653156a79--

