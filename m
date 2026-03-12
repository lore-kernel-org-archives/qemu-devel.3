Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67F4106ACEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nir-00036N-8B; Thu, 12 Mar 2026 17:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nip-00035u-Ly
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:37:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nin-0003g5-VN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:37:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c738fecf349so986331a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351452; cv=none;
 d=google.com; s=arc-20240605;
 b=HYDLyyxbAC606nGPNGkeBedGezn17hQlfX71/9uUsJiCA05ELwq95AxiMtJi5+IRMF
 n+qZyg1JNbzmU7ulWIoqi3zUm519yIHpGlp9UBV9PXELaH8byURK8ITUaCWIf3Oek6hF
 /527o4wsADDBBvq04MG7VGwv8eIJRB/YHzrQzaieI/SEtF/ZSAqLGLGn7u+xTrnjCnvk
 L7njrcksuiNlNhNMgbizNucaKAVvNik88x3j03tlBH5IiUOvPHVbzxRATzK1v0grW5y2
 QUBc4Cp17XHyRzO0PkG1740M//zwMeHMZyxLwzumbqUZnbfUErj4NXgn4jLuk4tthYqn
 qOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A56dJ1XUNaMiJ02ZAD0Rtn3U3GgkBw7IEbGy90VIH9I=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=aSF+d/nauL8Asu6hgiVK75GTZn/cm0W3mpMIjEOqnmGOmnAE6rjCD+WbCndWEuSyfu
 VkgeRlAE+18JF6hZRdOOGAap9uqSJzJcKfnHI9wt+bRlicidcEHTs4Nl3rhE8C5uzMBO
 /QCyM8RAXUyp1nzIZHGIzPV7NxuYIk5Qgt9LR2HmYaXQVZ6K6ktSCbUGYBaMbJHguMXb
 bQQUD2guGqrbyQRO8A7Tt9bSqFs3Pvlu7HwgAMRmT93aQAtUCXrNCHJqTwizwRLxVdBX
 WL8pb8PA2bGUAegP1LPbrjlo0DKrtO8vO4n4zto3i0EXH0rSB5ATgozXa3xBxprMIe3m
 7nEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773351452; x=1773956252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A56dJ1XUNaMiJ02ZAD0Rtn3U3GgkBw7IEbGy90VIH9I=;
 b=D8/YHgECPw6Gh38dAp+z68FZjdcIrJjFe8AXa2kDALIP69Htd8DpZtuKZvsFuGtEiH
 4jxOWIbltBBMe6UCR6UwhJAxGN8GalYfSo5npT2gqHU0VMXh9SxoqW2JnMvBfnI63hr8
 NcW5vvRUQ7qFVn2Rd3chyjm2vU0QflvYf/Z/sWy3kCs/YJi+5To8aWI/F+JlZmFcJDdE
 ST9IQBjVksmkoHHGAjbiRJR2ZFglyn68Vp7ZBZq9r/sPpVDVaWwIcf2tSnhc/A0gCWJr
 OhY21WfqiZfpIn59Xd4BsYfS6CDPeeezYUBSD0G9rmx+DKA89XpuYX+naOpCLRW41w0I
 h+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773351452; x=1773956252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A56dJ1XUNaMiJ02ZAD0Rtn3U3GgkBw7IEbGy90VIH9I=;
 b=aXxWdT1syT+I66np/pHMreN2BZyGZdvRD2haJ9tQtHHAFaWcKV2rrhRhqYmHz+ve/x
 tL4zj9zXeVnkZs0zx2AsYpgdnLI07PUiAD4lblTUgCLQbZ5v8rsanEhKhzu3/7z83qxi
 QXObQUj7v5wIi4EJkXk/P93JeCQo3G2URKpU2i96jbJFbTsxjKea3+FKPF4+5zNTddDM
 m+Zs+wqknwdQLPd1pKxoHbO6YIihgpBT8UZaJqVJXLX1lm2yHSeowHWctvPhNO41bb5t
 6VoIo2lIchu/Zc//fvN5kteiK6L8nHN7ZccTbZpdMyZriTWRYX3IF4JgzM2jOPi1AonC
 UXVQ==
X-Gm-Message-State: AOJu0YydCrN8+il9nUBigA6Trwni3Jcb+mLYmeSTfX6uQt+/0fsK4uvs
 GvpEaLdGJ/Ti72Z32AWw5FA8am7mr9LMZ0Y2VnJM3mw4l+Qar6O2ohnNCMLzyA/JIAeRAvHTKpT
 Nih5W4giSevk8Ty8GNnLk/GlVbVMSax4fKQGo
X-Gm-Gg: ATEYQzzJqYhDiPOtSmx8L3ACvspFiCgnDvQsBvgaEjjZOn4P70bktNUCakB9a5MWdB0
 N9uVsCWRM3DwaF1mrAfM6fDd1nglUeCyRFrJxDnGlJBenFemzh9jSODWzs9BqCDkyu07wswuvxs
 s3qSXdyHC7nPlHw3GVprAwSUXtvILtMcr32zbhr2WRjYzIAvknySKxnUMaeCewY1E7F/DsESJoY
 tvGTTJ4Jy3PiWRRQVME39nBr8F4Q/6SbM87WVYY/ue5TGom61LLlMHm0S7Y1XrHEeMmRuLtZPNF
 je1SWqZeDaCbcH/jJSAl7g7NfO9RzufKsoaiMA==
X-Received: by 2002:a17:902:f552:b0:2ae:54e3:9299 with SMTP id
 d9443c01a7336-2aeba51229cmr39047915ad.21.1773351452357; Thu, 12 Mar 2026
 14:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:37:21 -0600
X-Gm-Features: AaiRm52t4E0ENHB0cnHmVbdcl9nLKI_GNCBIyWPUIy1IosMYGOGD9-Vk9hdOPfc
Message-ID: <CAATN3NoSdHEuK1LsT4-uGKmFgxFxSYQoRPSfjv7EKX1bVaWSuQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/32] target/hexagon: Implement start/stop helpers,
 soft reset
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000061393f064cda8f47"
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x534.google.com
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

--00000000000061393f064cda8f47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h        |   7 +++
>  target/hexagon/cpu_helper.h |   3 ++
>  target/hexagon/cpu.c        |  26 +++++++++-
>  target/hexagon/cpu_helper.c | 100 ++++++++++++++++++++++++++++++++++++
>  target/hexagon/op_helper.c  |   4 +-
>  5 files changed, 136 insertions(+), 4 deletions(-)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 0017be9dff7..1a3c9014455 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -207,6 +207,13 @@ G_NORETURN void
> hexagon_raise_exception_err(CPUHexagonState *env,
>                                              uint32_t exception,
>                                              uintptr_t pc);
>
> +#ifndef CONFIG_USER_ONLY
> +uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
> +uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
> +void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t
> val);
> +void hexagon_cpu_soft_reset(CPUHexagonState *env);
> +#endif
> +
>

The first three above belong in a different patch.



> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> index 6fbf5fc8e2f..c251790e5a5 100644
> +static void set_enable_mask(CPUHexagonState *env)
> +{
> +    g_assert(bql_locked());
> +
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    const uint32_t modectl =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
> +                               env->threadId) : 0;
> +    uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modectl);
> +    thread_enabled_mask |=3D 0x1 << env->threadId;
> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E,
> thread_enabled_mask);
>

Do you want to set modectl when cpu->globalregs is false?


> +}
> +
> +static uint32_t clear_enable_mask(CPUHexagonState *env)
> +{
> +    g_assert(bql_locked());
> +
> +    HexagonCPU *cpu =3D env_archcpu(env);
> +    const uint32_t modectl =3D cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_MODECTL,
> +                               env->threadId) : 0;
> +    uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modectl);
> +    thread_enabled_mask &=3D ~(0x1 << env->threadId);
> +    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E,
> thread_enabled_mask);
>

Ditto


> +    return thread_enabled_mask;
>

It's strange that set_enable_mask returns void and clear_enable_mask
returns the new mask.

Thanks,
Taylor

--00000000000061393f064cda8f47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +++<b=
r>
=C2=A0target/hexagon/cpu_helper.h |=C2=A0 =C2=A03 ++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 +++++++++-=
<br>
=C2=A0target/hexagon/cpu_helper.c | 100 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A05 files changed, 136 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 0017be9dff7..1a3c9014455 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -207,6 +207,13 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagon=
State *env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t exception,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uintptr_t pc);<br>
<br>
+#ifndef CONFIG_USER_ONLY<br>
+uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);<br>
+uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);<br>
+void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t v=
al);<br>
+void hexagon_cpu_soft_reset(CPUHexagonState *env);<br>
+#endif<br>
+<br></blockquote><div><br></div><div>The=C2=A0first three above belong in =
a different patch.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">diff --git a/target/hexagon/cpu_helper.c b=
/target/hexagon/cpu_helper.c<br>
index 6fbf5fc8e2f..c251790e5a5 100644<br>+static void set_enable_mask(CPUHe=
xagonState *env)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 const uint32_t modectl =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_MODECTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modect=
l);<br>
+=C2=A0 =C2=A0 thread_enabled_mask |=3D 0x1 &lt;&lt; env-&gt;threadId;<br>
+=C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_en=
abled_mask);<br></blockquote><div><br></div><div>Do you want to set modectl=
=C2=A0when cpu-&gt;globalregs=C2=A0is false?</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static uint32_t clear_enable_mask(CPUHexagonState *env)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(bql_locked());<br>
+<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D env_archcpu(env);<br>
+=C2=A0 =C2=A0 const uint32_t modectl =3D cpu-&gt;globalregs ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hexagon_globalreg_read(cpu-&gt;globalregs, HEX=
_SREG_MODECTL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;threadId) : 0;<br>
+=C2=A0 =C2=A0 uint32_t thread_enabled_mask =3D GET_FIELD(MODECTL_E, modect=
l);<br>
+=C2=A0 =C2=A0 thread_enabled_mask &amp;=3D ~(0x1 &lt;&lt; env-&gt;threadId=
);<br>
+=C2=A0 =C2=A0 SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_en=
abled_mask);<br></blockquote><div><br></div><div>Ditto</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 return thread_enabled_mask;<br></blockquote><div><br></div><=
div>It&#39;s strange that set_enable_mask returns void and clear_enable_mas=
k returns the new mask.</div><div>=C2=A0</div><div>Thanks,</div><div>Taylor=
</div><div><br></div></div></div>

--00000000000061393f064cda8f47--

