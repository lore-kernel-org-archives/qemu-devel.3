Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE48F53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CDC-0003Sm-5k; Mon, 16 Mar 2026 13:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2CD3-0003SV-MY
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:58:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2CD1-0005wN-EE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:58:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso2892660b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683910; cv=none;
 d=google.com; s=arc-20240605;
 b=UGEt3VwBWVypcQTvAQ01/qa3poLOf9rl2UDcz13Yn3gI+Mt+axPPM/agbCjQJUsmD7
 W0fCTcArRyxNuXNm6GaTaUjZB2Yz7iRaGWJdmwnof8h0U7uYdrSxTB3VHKUGxEQHD/zK
 zWENddf+uNqfmjTYUBqikB28WYnja8h9LhqC+4xL/liKsPYlb/KHlXQPf1euTamwLuIX
 1DIC8kNzKnudtP/wKMOwrklPGIX8ORlB7ZVPFcwuMP6we3EPO6xEoIGnPaNE8IPch7Ux
 2HfajXHO3DLsH/kAb8pSQlPWpAAb0yc6ewp4fzVcUDQmJN2qNlY9TAOjUcvwb1KASBZ+
 0G0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b7avKvJDlDpO7eQa9sY5KuAE8ae6oeJlCYUfrw9D7dM=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=EJaJb43n8HsBv9VJ4mqgjQx4TnycljI3E6NCrmruPb6L1T5UTJtxc+A+b3jm8D4Lnj
 LsU95EBxYzZVO/nPX632LrtpdstLMtnJ6/7BxJ7ueYF1JT3E5fKpLEPQAVioVxeH75LM
 IOrDWDaf5hi2p7ZcEnwZSwznnIyDaJczwV6LUmnG+YDWhTG/9nkYVddlojI39cgZPAJ+
 lSknfCHOZ4eHlzf70MGQdRB/WEWSRRbkgxgypos03o3fYn3cxixdDYYFdISUkAlnDxaq
 J2xTAFdC45Cm++ElObbcDEdw+8d46E57Ux1mX3SS+xYRyUiBssOMdrNz81KIRiHO5np8
 3pQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683910; x=1774288710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b7avKvJDlDpO7eQa9sY5KuAE8ae6oeJlCYUfrw9D7dM=;
 b=C8ClZf2DRIWQqwyL/7we/LCOAmjhFfkol0TLzDTraVnqUz8f0wcX3xNUHz0NjAPMT/
 wSK+bdkJK2gffXS2/FOo2fAtVOLI9BeAvEetoBcbDaMGBMNWSRjUwh/dqMjPG6k7rSBr
 7JN7cufT7teRQB3SCjmRLFR0n+B+MW+M2O+mLY1c6mgiRsoQZhu2VRTwUpcSdOQQVVPN
 AHIBbIUVh6sJU9km/k//sl5C5pwMFWTdGFbvfK2cwbxNZcnUAdGj/PdlKWh7Cbd9fKxS
 W9ppHPhqkeWy8AhXl1Azfx49BIxkkGAEx3npWfcxiHi2WNj+m2JKU3RLR7hPMlE6TMPW
 uSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683910; x=1774288710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7avKvJDlDpO7eQa9sY5KuAE8ae6oeJlCYUfrw9D7dM=;
 b=oVVZsasRI0iG0zyggF8IaivMeELGqgq+oxDwtrTd7XfpkBUVtJV8tjDPsBpwZprqCJ
 1IJ+i1iPvPPBKoaki9poj8sMsZPOw3aJmVAxy2oL+YCHGB9cpJFX7ebakUU8IJP3/TCj
 qKdnozScVZfWcHWtg7+J9YYQpw3F7QgnjzCqZ3S5yi0n9Q4dQWSWKjE5Y6OjOdo44Mdk
 lufSpmfxFia5eLADBbkTyitaozsR+1wM0TqumiV8frSpiR3nCjfkqV7QTwBFRL6UPbp5
 UcAaTFH6cXymwfHHkrGV7ru/7EVYu2MRZCixc/5An7x3x8AmlmgoXi1sEcDe/m+WbpQV
 iECA==
X-Gm-Message-State: AOJu0YzYetsYR0Gvm4r/fcGIOCoNp5v0QlSxZzMH9ldQcK2Cn7GtkFK6
 Pq/aApO4ovQtsQIrvWiZSxb4hm3ywVtUr9ys9JQ7BGOUg1OzpgMi/usvYoNScGp6x1WNbs8C6tA
 JU6tkLd3vyBmwK0SLScF4sDAGseilMG4=
X-Gm-Gg: ATEYQzwnDkgq+EeCmN/g/kKnBssqAhqzva8Ow9tbJPd2hsRouB2fkqgIimsZd2NcMex
 EdyhAwOqW/pclLTbbQKqI84rz7KMbpGGyMEqq5hK549TxposFieObJRiJDlatMTgmDrcGCUBi/h
 VBIFmTpt6vD9+LQJdcij//adDZFw7mj6JX/+0nzbWW5g+pDjphT+8fMhAwLp+LBWXM0wJNmTLgu
 Y4WzmFn/QGIaWpxj+8wUPXu6FMQpxYNAqWT6Q4yAj4kmqbjxevGkgQCOCl2MxPkchX51el9Inu3
 rKPYfHDz6p9qnrT/cdM9dGWL9GYkGJ0+U6ssvg==
X-Received: by 2002:a05:6a21:6001:b0:398:ae03:722f with SMTP id
 adf61e73a8af0-398eccb81abmr13055195637.45.1773683909813; Mon, 16 Mar 2026
 10:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311042019.1085030-2-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:58:17 -0600
X-Gm-Features: AaiRm51rMd5I_Yv9-a5zCf95r-KvPYHCWlRkoNKcnd7VcHguL-29E2-zliPDMss
Message-ID: <CAATN3Nq0Z0KKMGiryVg-hXJY7ogaVA+kvSrcMNt-qyC6iCFjng@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] hw/hexagon: Add globalreg model
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000636842064d27f76f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x432.google.com
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

--000000000000636842064d27f76f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Some of the system registers are shared among all threads
> in the core.  This object contains the representation and
> interface to the system registers.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_globalreg.h |  56 ++++++
>  hw/hexagon/hexagon_globalreg.c         | 240 +++++++++++++++++++++++++
>  2 files changed, 296 insertions(+)
>  create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>  create mode 100644 hw/hexagon/hexagon_globalreg.c
>
> diff --git a/include/hw/hexagon/hexagon_globalreg.h
> b/include/hw/hexagon/hexagon_globalreg.h
> new file mode 100644
> index 00000000000..c9e72f30b0a
> --- /dev/null
> +++ b/include/hw/hexagon/hexagon_globalreg.h
> @@ -0,0 +1,56 @@
> +/*
> + * Hexagon Global Registers QOM Object
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_GLOBALREG_H
> +#define HEXAGON_GLOBALREG_H
> +
> +#include "hw/core/qdev.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "target/hexagon/cpu.h"
> +
> +#define TYPE_HEXAGON_GLOBALREG "hexagon-globalreg"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)
> +
> +struct HexagonGlobalRegState {
> +    SysBusDevice parent_obj;
> +
> +    /* Array of system registers */
> +    uint32_t regs[NUM_SREGS];
> +
> +    /* Global performance cycle counter base */
> +    uint64_t g_pcycle_base;
> +
> +    /* Properties for global register reset values */
> +    uint32_t boot_evb;           /* Boot Exception Vector Base
> (HEX_SREG_EVB) */
> +    uint64_t config_table_addr;  /* Configuration table base */
> +    uint32_t dsp_rev;           /* DSP revision register (HEX_SREG_REV) =
*/
> +
> +    /* ISDB properties */
> +    bool isdben_etm_enable;     /* ISDB ETM enable bit */
> +    bool isdben_dfd_enable;     /* ISDB DFD enable bit */
> +    bool isdben_trusted;        /* ISDB trusted mode bit */
> +    bool isdben_secure;         /* ISDB secure mode bit */
>

Should the TLB entries go in here also?


> +};
> +
> +/* Public interface functions */
> +uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
> +                                uint32_t htid);
>

Why is htid needed?


> +void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,
> +                             uint32_t value, uint32_t htid);
>

Ditto


> +uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s,
> uint32_t reg,
> +                                        uint32_t value);
> +void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t
> reg,
> +                                    uint32_t value);
> +void hexagon_globalreg_reset(HexagonGlobalRegState *s);
> +
> +/* Global performance cycle counter access */
> +uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s);
> +void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,
> +                                       uint64_t value);
> +
> +#endif /* HEXAGON_GLOBALREG_H */
> diff --git a/hw/hexagon/hexagon_globalreg.c
> b/hw/hexagon/hexagon_globalreg.c
> new file mode 100644
> index 00000000000..5187b91dcae
> --- /dev/null
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -0,0 +1,240 @@
> +static void hexagon_globalreg_init(Object *obj)
> +{
> +    HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);
> +
> +    memset(s->regs, 0, sizeof(uint32_t) * NUM_SREGS);
>

Should we memset the whole thing?


> +}
>
>

--000000000000636842064d27f76f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:20=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Some of the system registers are sh=
ared among all threads<br>
in the core.=C2=A0 This object contains the representation and<br>
interface to the system registers.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0include/hw/hexagon/hexagon_globalreg.h |=C2=A0 56 ++++++<br>
=C2=A0hw/hexagon/hexagon_globalreg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 240=
 +++++++++++++++++++++++++<br>
=C2=A02 files changed, 296 insertions(+)<br>
=C2=A0create mode 100644 include/hw/hexagon/hexagon_globalreg.h<br>
=C2=A0create mode 100644 hw/hexagon/hexagon_globalreg.c<br>
<br>
diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon/he=
xagon_globalreg.h<br>
new file mode 100644<br>
index 00000000000..c9e72f30b0a<br>
--- /dev/null<br>
+++ b/include/hw/hexagon/hexagon_globalreg.h<br>
@@ -0,0 +1,56 @@<br>
+/*<br>
+ * Hexagon Global Registers QOM Object<br>
+ *<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HEXAGON_GLOBALREG_H<br>
+#define HEXAGON_GLOBALREG_H<br>
+<br>
+#include &quot;hw/core/qdev.h&quot;<br>
+#include &quot;hw/core/sysbus.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;target/hexagon/cpu.h&quot;<br>
+<br>
+#define TYPE_HEXAGON_GLOBALREG &quot;hexagon-globalreg&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)<br>
+<br>
+struct HexagonGlobalRegState {<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 /* Array of system registers */<br>
+=C2=A0 =C2=A0 uint32_t regs[NUM_SREGS];<br>
+<br>
+=C2=A0 =C2=A0 /* Global performance cycle counter base */<br>
+=C2=A0 =C2=A0 uint64_t g_pcycle_base;<br>
+<br>
+=C2=A0 =C2=A0 /* Properties for global register reset values */<br>
+=C2=A0 =C2=A0 uint32_t boot_evb;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* Boot Exception Vector Base (HEX_SREG_EVB) */<br>
+=C2=A0 =C2=A0 uint64_t config_table_addr;=C2=A0 /* Configuration table bas=
e */<br>
+=C2=A0 =C2=A0 uint32_t dsp_rev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 DSP revision register (HEX_SREG_REV) */<br>
+<br>
+=C2=A0 =C2=A0 /* ISDB properties */<br>
+=C2=A0 =C2=A0 bool isdben_etm_enable;=C2=A0 =C2=A0 =C2=A0/* ISDB ETM enabl=
e bit */<br>
+=C2=A0 =C2=A0 bool isdben_dfd_enable;=C2=A0 =C2=A0 =C2=A0/* ISDB DFD enabl=
e bit */<br>
+=C2=A0 =C2=A0 bool isdben_trusted;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ISDB trus=
ted mode bit */<br>
+=C2=A0 =C2=A0 bool isdben_secure;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ISDB=
 secure mode bit */<br></blockquote><div><br></div><div>Should the TLB entr=
ies go in here also?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+};<br>
+<br>
+/* Public interface functions */<br>
+uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t htid);<br></blockquote><div=
><br></div><div>Why is htid needed?</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value, uint32_t htid);<br></blockqu=
ote><div><br></div><div>Ditto</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint32_t=
 reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 value);<br>
+void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t reg=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t value);<br>
+void hexagon_globalreg_reset(HexagonGlobalRegState *s);<br>
+<br>
+/* Global performance cycle counter access */<br>
+uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s);<br>
+void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t =
value);<br>
+<br>
+#endif /* HEXAGON_GLOBALREG_H */<br>
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.=
c<br>
new file mode 100644<br>
index 00000000000..5187b91dcae<br>
--- /dev/null<br>
+++ b/hw/hexagon/hexagon_globalreg.c<br>
@@ -0,0 +1,240 @@<br>+static void hexagon_globalreg_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);<br>
+<br>
+=C2=A0 =C2=A0 memset(s-&gt;regs, 0, sizeof(uint32_t) * NUM_SREGS);<br></bl=
ockquote><div><br></div><div>Should we memset the whole thing?</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+}<br><br>
</blockquote></div></div>

--000000000000636842064d27f76f--

