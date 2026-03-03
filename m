Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D640AEDEBE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVse-0003gK-Rz; Tue, 03 Mar 2026 14:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVsb-0003g2-AG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:58:06 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVsY-0005Jp-Lv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:58:04 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so5385679a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567881; cv=none;
 d=google.com; s=arc-20240605;
 b=hqchd311gGZ8Xq7D5TLzRD7sd3+0/3Cydumv3JjeBxaaJMYUOSyV4kXvDJyPIyaUID
 w4/81izaKyAj0p04SOwIR+zuzWoaS36f6C0sukc2MxokwZ4I8gpMtYFE1TiM9SYciPFO
 C2I7z9rdfgzXWjLCPjfjmZAOZzq1SjCnacEpY88Jeg+uJSdd5eFnqYjRB/YUrqMXVzwK
 gaoJauZkb6cc955YuROW5XC6oVWJ10hPnbqKRmshxfc3R+JG965kH/AoT5MaJoEvVmE6
 kkfVHbcsK5g65vyK+EGwQ9YYLpdLvzYfCLI31AvQUTZIlDD+DCQGLsopmqh1FqMxH69A
 ra+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+UeXlceFs919Cl+1aPY5+mwZqA6oJiG6ZHFeMNQjxQE=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=cd98pQDjSXKxlEuBStLhqniuP5lOaVz/B5+zGwAP9tTqsgdISyi1hm0EgZYb0xhktO
 z9HgMOLpqDOkUik9LdH3xq+Qa+CYiOnTj8q2brYK9KT/H18ZcYf3CwXr5dHYJ4/dRDT2
 QOmlyys4MZhXwDvzO9EBcR8XOSbzAHhF9irXivsNIa98qM849C58k+4a85gMkvfvxi6E
 9K0pnq/TLLBO1xV7kJKejHX9gZbKRomaBE+Yr8qp+NnlKM+ZV0+jyvmGMY0YmDM86mMD
 bnnvviLWNZAOltp42ILv8q0gMn6JbRK9G0LiR8oAkw01A/oD8oSlVFBRMV2pD5WJYKY7
 E6rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772567881; x=1773172681; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+UeXlceFs919Cl+1aPY5+mwZqA6oJiG6ZHFeMNQjxQE=;
 b=drEubjiPOriUZMPDk04Hx7YA4Uj/cCAkW3sjFuUcac05oqhYqMh1BliC8qjfDRC8Jl
 sDAFgi1JyEvxOunT7EDm/p05g03W/FwLJ6EODlFL7PCA4TovBRYNLLYedzWLMYGAroPn
 4aI1Fu4BNewiSC1StgH3jGv7+3RVKkxOQ66731XuS3Veusj9VU31lVw5n1uz44EuDgNg
 WT03Ia2xYmDAzsSElQIgqgn0NcuhluXWWZtcFfTmpIy0tT9p7iEmN0tkSDac4KyC9qZf
 eCRiB9MUMXsnPZSlj5Z8g5VSknPP2yPk0Q74In/Ux5AmTWAjROSbUfGmQWgA0OSxccKH
 WMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567881; x=1773172681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UeXlceFs919Cl+1aPY5+mwZqA6oJiG6ZHFeMNQjxQE=;
 b=bMqDVwptMYtlmKdCtPCBNPgdUYN7CtpqTlzuQ/dDMoGvfmTAVTO2diWx1uuDvwkg8C
 kuPOb0HHaOVydagYL/gUf7JsI02Aj940wjlvvnwnQ57U/r20r1ZO6w2PCb5KM5Z+b4di
 PRAPOLTLgLpjOq76T/cw7HpMqY9dEa6yYtk1dav7t0x+z1XMIwiShcMXAczAFiI1z70S
 3HyJ+/+5kdn4eg0ySh/5VSdaMN7M0Tetq+J5vYaIUgjXGnfa1ns7+npHmuBlONvSqrTs
 qTPu5e5Eg8RvJuM11Z6RdCMjgTCbQb8NOGrRcdQ/HL4yJJJwcZnhYpgn1Zya/CUdht/X
 keEA==
X-Gm-Message-State: AOJu0YxdlL4Ja3o+8uhGEck0x088eQT9EISFpr5yhCST/7T6cwML6vvb
 QW6rsnVWdlvu28x0twkgFCsMbAps3j7oyxG0c/grQBwDWzsduAjX6sd5rX5nQHnioPpta0s1RFm
 VSj9q7eX5CKd/hhnPZUUF48mqm5xn1Fk=
X-Gm-Gg: ATEYQzwy7Pttyy9mEmvb/lRnnwp0Ct4MiCEmgzsZdd7M2SAcJ9G5wGeDO98kEn5X9DE
 vi1sq3qD4eqFOePGOvLqJyp9fjWICwo9zmcXOo/8sM8ue5Huv7UcIj/nmglIWq58v/44X4HFm6n
 jAZ6RJD5/Vequsm4bjXUxejBPkxcZxyGOPU4BX58lPl9v5tQpae3DsKZFIijIidMppwgIs96xqq
 A/E1rxU7rT0inJo5+JmOQQYc9GXVAyakahjWU1qL3QPNVIymAQX3IST+pkQCQmAcit6LGJWtgZd
 BKKLn2Ivaz424ttyr36945Xwy6GSqSq5RJb5ShU=
X-Received: by 2002:a17:90b:4a:b0:359:1063:6b02 with SMTP id
 98e67ed59e1d1-35965c903d4mr15771062a91.18.1772567880945; Tue, 03 Mar 2026
 11:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-18-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-18-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 12:57:49 -0700
X-Gm-Features: AaiRm53k8-4n5fnDo-JBZPpKVRX3yPpr9oncHTF3al-pCkBXCVwx6fSGOABS6ZQ
Message-ID: <CAATN3NoVMp770F7L5o0WstQGKTEXHNMN9jj1ZRcf966NhdVU-Q@mail.gmail.com>
Subject: Re: [PATCH v3 17/37] target/hexagon: Add new macro definitions for
 sysemu
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000e25239064c241eb2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1036.google.com
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

--000000000000e25239064c241eb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Also: add nop TCG overrides for break, unpause, fetchbo; add TCG
> override for dczeroa_nt (non-temporal variant of dczeroa).
>
> break: this hardware breakpoint instruction is used with the in-silicon
> debugger feature, this is not modeled.
>
> unpause: this instruction is used to resume hardware threads that are
> stalled by pause instructions.  pause is modeled as a nop, or in RR
> mode as an EXCP_YIELD.  This instruction is safe to ignore.
>
> Since prefetch functions are not modeled, fetchbo is safe to ignore.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h   |   7 ++
>  target/hexagon/gen_tcg.h    |   9 ++
>  target/hexagon/macros.h     |  25 +++-
>  target/hexagon/sys_macros.h | 237 ++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  |   1 +
>  5 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 target/hexagon/sys_macros.h
>
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 91e9da09e03..3cbf8b7f570 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -97,6 +97,13 @@ enum hex_cause {
>      HEX_CAUSE_INT7 =3D 0x0c7,
>  };
>
> +enum data_cache_state {
> +    HEX_DC_STATE_INVALID   =3D 0x0,
> +    HEX_DC_STATE_VALID     =3D 0x1,
> +    HEX_DC_STATE_RESERVED  =3D 0x2,
> +    HEX_DC_STATE_UNUSED_WT =3D 0x3,
> +};
> +
>

Are these needed?



> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> new file mode 100644
> index 00000000000..3b66b83695c
> --- /dev/null
> +++ b/target/hexagon/sys_macros.h
> @@ -0,0 +1,237 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_SYS_MACROS_H
> +#define HEXAGON_SYS_MACROS_H
> +
> +/*
> + * Macro definitions for Hexagon system mode
> + */
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +#define READ_SGP0()    (env->t_sreg[HEX_SREG_SGP0])
> +#define READ_SGP1()    (env->t_sreg[HEX_SREG_SGP1])
> +#define READ_SGP10()   ((uint64_t)(env->t_sreg[HEX_SREG_SGP0]) | \
> +    ((uint64_t)(env->t_sreg[HEX_SREG_SGP1]) << 32))
> +
> +#define WRITE_SGP0(VAL)           log_sreg_write(env, HEX_SREG_SGP0, VAL=
,
> slot)
> +#define WRITE_SGP1(VAL)           log_sreg_write(env, HEX_SREG_SGP1, VAL=
,
> slot)
> +#define WRITE_SGP10(VAL) \
> +    do { \
> +        log_sreg_write(env, HEX_SREG_SGP0, (VAL) & 0xFFFFFFFF, slot); \
> +        log_sreg_write(env, HEX_SREG_SGP1, (VAL) >> 32, slot); \
> +    } while (0)
> +
>

Are these READ/WRITE macros needed?  They look like remnants of the old
generators?

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000e25239064c241eb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:36=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Also: add nop TCG overrides for break, unpause, fetchbo; add TCG<br>
override for dczeroa_nt (non-temporal variant of dczeroa).<br>
<br>
break: this hardware breakpoint instruction is used with the in-silicon<br>
debugger feature, this is not modeled.<br>
<br>
unpause: this instruction is used to resume hardware threads that are<br>
stalled by pause instructions.=C2=A0 pause is modeled as a nop, or in RR<br=
>
mode as an EXCP_YIELD.=C2=A0 This instruction is safe to ignore.<br>
<br>
Since prefetch functions are not modeled, fetchbo is safe to ignore.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_bits.h=C2=A0 =C2=A0|=C2=A0 =C2=A07 ++<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 |=C2=A0 =C2=A09 ++<br>
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 25 +++-<br>
=C2=A0target/hexagon/sys_macros.h | 237 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A05 files changed, 278 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 target/hexagon/sys_macros.h<br>
<br>
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h<br>
index 91e9da09e03..3cbf8b7f570 100644<br>
--- a/target/hexagon/cpu_bits.h<br>
+++ b/target/hexagon/cpu_bits.h<br>
@@ -97,6 +97,13 @@ enum hex_cause {<br>
=C2=A0 =C2=A0 =C2=A0HEX_CAUSE_INT7 =3D 0x0c7,<br>
=C2=A0};<br>
<br>
+enum data_cache_state {<br>
+=C2=A0 =C2=A0 HEX_DC_STATE_INVALID=C2=A0 =C2=A0=3D 0x0,<br>
+=C2=A0 =C2=A0 HEX_DC_STATE_VALID=C2=A0 =C2=A0 =C2=A0=3D 0x1,<br>
+=C2=A0 =C2=A0 HEX_DC_STATE_RESERVED=C2=A0 =3D 0x2,<br>
+=C2=A0 =C2=A0 HEX_DC_STATE_UNUSED_WT =3D 0x3,<br>
+};<br>
+<br></blockquote><div><br></div><div>Are these needed?</div><div>=C2=A0</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">diff =
--git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h<br>
new file mode 100644<br>
index 00000000000..3b66b83695c<br>
--- /dev/null<br>
+++ b/target/hexagon/sys_macros.h<br>
@@ -0,0 +1,237 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HEXAGON_SYS_MACROS_H<br>
+#define HEXAGON_SYS_MACROS_H<br>
+<br>
+/*<br>
+ * Macro definitions for Hexagon system mode<br>
+ */<br>
+<br>
+#ifndef CONFIG_USER_ONLY<br>
+<br>
+#define READ_SGP0()=C2=A0 =C2=A0 (env-&gt;t_sreg[HEX_SREG_SGP0])<br>
+#define READ_SGP1()=C2=A0 =C2=A0 (env-&gt;t_sreg[HEX_SREG_SGP1])<br>
+#define READ_SGP10()=C2=A0 =C2=A0((uint64_t)(env-&gt;t_sreg[HEX_SREG_SGP0]=
) | \<br>
+=C2=A0 =C2=A0 ((uint64_t)(env-&gt;t_sreg[HEX_SREG_SGP1]) &lt;&lt; 32))<br>
+<br>
+#define WRITE_SGP0(VAL)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_sreg_w=
rite(env, HEX_SREG_SGP0, VAL, slot)<br>
+#define WRITE_SGP1(VAL)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_sreg_w=
rite(env, HEX_SREG_SGP1, VAL, slot)<br>
+#define WRITE_SGP10(VAL) \<br>
+=C2=A0 =C2=A0 do { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_sreg_write(env, HEX_SREG_SGP0, (VAL) &amp;=
 0xFFFFFFFF, slot); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_sreg_write(env, HEX_SREG_SGP1, (VAL) &gt;&=
gt; 32, slot); \<br>
+=C2=A0 =C2=A0 } while (0)<br>
+<br></blockquote><div><br></div><div>Are these READ/WRITE macros needed?=
=C2=A0 They look like remnants of the old generators?</div><div><br></div><=
div>Otherwise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:l=
taylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br></d=
iv></div></div>

--000000000000e25239064c241eb2--

