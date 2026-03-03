Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF938EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWie-0008Dy-H4; Tue, 03 Mar 2026 15:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWiW-0007w8-1L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:45 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWiU-0001Tm-2R
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:43 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso2234348a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 12:51:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772571100; cv=none;
 d=google.com; s=arc-20240605;
 b=ToeKoFwxduoBUrjnMgC2E+uF9unWI9VRHUVwE0pNgSx1gpcYznDli7AyhitWBpYPsz
 SteNk35xcaVXAF8cv4/No+6tVNMTrlHLr/I5h81zF6KMVfzZPWCBYjL4yZsURsZ3+zm2
 C78yf5HUUEk/CkfbVx5SOhJcqrJwUvdELQTVVG3lRcBkkKGR2uGfpRvb4Jc3Plj397Sk
 EhUt37iT9Vf4B9Rr6QtdoNrsty070LWEWFP5GLOkLzrq9VLU5KyUoI8M8q6XBsr0xIhl
 SMQx01+vGtSzV9o3lqqN2EkGId/EbAmxZZFEmbCl6/cjRK6FvXqe7snikFX59+AQ6Xun
 qyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iw2X+Z42H7TVZANdWL8MqmVMi7kL+i890vlsGyqBK6s=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=Fq1fwT0hsPp/X37OXpObErjH94SBM6Nut8kMkcy4YtCxvWOL55PA3YpFGjlqH++uWt
 lPrp9k6uVOawCFoiPec83XE9prK5atDAGZYiJxcPDtQ2irrLE2Ts6ItIvNyzcNAB2Lpe
 6+fmi73Xb+NrQpyp4rj1shqH8rqfKwuimCqIeMRMNXYZ3D+RnfB6Aj9C23XQeyApV+nf
 kULS4lqlupB8Wz5QrPIxOwzZDLDtY/gJwxO2GGoKfiGTsnBOg2sEJsNETZzBuDyKtFlI
 cg4FOrZExG+YiCYodPPBvwNeJbhRisJX7z7yi0sKhptNBkT2qvtiP93Nr/jJ0wsNq5gN
 K6nA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772571100; x=1773175900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iw2X+Z42H7TVZANdWL8MqmVMi7kL+i890vlsGyqBK6s=;
 b=PPg72646uHm3CkfxYEHW2jkdj0yX4hqktU+LG668WME0t3YUsrbQ1ysxu9PQXAZpMQ
 rvvnpcXqHc+Ux3Azp8pt6eYOhPp8ZsmJLOocQgdbWRbJbIuUaeeuk9QsifLYN0voHY85
 OXTUNUPvusXV479Ukz/2RtNsU5qy6PS7Yf3FfsrXKo0mlWKZYAIz2wVaQ07ldBvGssBi
 TkXpF/+7CCwXjxAmQa6A25n+SdAOkk9wJAVX77rfAiSPk+o31FRlXQN3cdrOz63h5jmj
 ayJ4RBNkW0uTTyobCUejCOZ1sY4ood/wImNEBcOlDDHnk9/Jsqp2xbTiDnuUiNCvfq7g
 uSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772571100; x=1773175900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw2X+Z42H7TVZANdWL8MqmVMi7kL+i890vlsGyqBK6s=;
 b=p61JBVLVl/P2MgVG7lsH1na+AkZbNN9W74wNN4xe6tbAG+3coyuiK+FFCSTOdtGwg+
 ycsyXRnJuGZcnQFVej4auYG7UCcXgNw+H2Z0pfWc2IMJVzfybr8EyRm+mp+yJWzv6PmY
 I7pRgfNxVetbMBm5rJ0WEEEIUfltoICocrdyhHyPaG5ABiQCK+lwiqUQ6APZ0tzfEnsQ
 sVIlWJn5ZBabbzsJw+8Zk01duIGItSA+3I2nRfocqIcZFO0QBC+STi3fhLX7B1VPYj7b
 N4/6URLJskiALkmTWMWGCYeCxeFqRRXKTgTjKEoUPTwrlRoeAtsGYogN4m/cRIbBdfac
 TW9g==
X-Gm-Message-State: AOJu0YwATXeWklESvsOw5FTCxVbpz3XRsLVNC2ovnJje59Y/J5zwWl4W
 S8cXSPT95bUhXfOKOl1xqmvoedByy8j7CtvAkInt6OBBsMhgi6nUut2ZRmJVY9vJ628pcztM+Im
 jRWT4PuIBkhs9C0GO39aBT1UNzYs/7f0=
X-Gm-Gg: ATEYQzzQRtOqLctz0G+y5Mqzot235/4TcemPFF18W+LaejYGHsyhsFkv97h3mdYXkbp
 pU4pKhaj7HBkX8O/ldtoJW23HA5666dHxYb8fRP8pwXSLyUeDLuTbMaplUChwwAP3mVFKUI9loe
 Ha8nuUvzCImKuvixqNnECuIJxpbckzLCgAaZPHq4iwu/SMmueXHKjdwd0JRkqN5nn2NVcA/BUTY
 6FTGe3FzBjeXV3+n3kQE36byMaMK0LEaRnerdHwZR62SpeZTNroJT+i9b9W1T4SHSWLXkISCtNT
 67sCVbLUBdxwiqqTZwOBEYg3qnWNviaEhuqxf48=
X-Received: by 2002:a17:903:4765:b0:2ae:47c9:68c4 with SMTP id
 d9443c01a7336-2ae47c96d75mr96591075ad.50.1772571100475; Tue, 03 Mar 2026
 12:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-24-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-24-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 13:51:29 -0700
X-Gm-Features: AaiRm51wThFyyAlxR22qjVoPKyerRS2bYYMTqdx3YZAUdJkIJIouUJiDL2Ojuno
Message-ID: <CAATN3NrjWHTJt1AKwHJJMhnXOTc4UjxTB55_u-WJdf_=KPDkSw@mail.gmail.com>
Subject: Re: [PATCH v3 23/37] target/hexagon: Implement do_raise_exception()
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000c8743b064c24de6a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52d.google.com
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

--000000000000c8743b064c24de6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:37=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/internal.h  |  5 +++++
>  target/hexagon/op_helper.c | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index cd06ff41d4f..d94f84b46a7 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -31,6 +31,11 @@ void hexagon_debug(CPUHexagonState *env);
>
>  extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
>
> +void G_NORETURN do_raise_exception(CPUHexagonState *env,
> +        uint32_t exception,
> +        target_ulong PC,
> +        uintptr_t retaddr);
> +
>  #ifndef CONFIG_USER_ONLY
>  extern const VMStateDescription vmstate_hexagon_cpu;
>  #endif
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 13e3c2c3a41..54b22f2fee4 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -37,6 +37,25 @@
>  #define SF_MANTBITS    23
>
>  /* Exceptions processing helpers */
> +G_NORETURN
> +void do_raise_exception(CPUHexagonState *env, uint32_t exception,
> +                        target_ulong PC, uintptr_t retaddr)
> +{
> +    CPUState *cs =3D env_cpu(env);
> +#ifdef CONFIG_USER_ONLY
> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x\n", __func__, exception);
> +#else
> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x, @ %08" PRIx32 "\n",
> +                  __func__, exception, PC);
>

Just print this in both user and system mode.

Also, use PRIx32 instead of the x in the format string.


> +
> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
>

Consider defining this macro to a nop in user mode.  Then you don't need
the #ifdef CONFIG_USER_ONLY in this function.


> +#endif
>
>
Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000c8743b064c24de6a
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
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/internal.h=C2=A0 |=C2=A0 5 +++++<br>
=C2=A0target/hexagon/op_helper.c | 19 +++++++++++++++++++<br>
=C2=A02 files changed, 24 insertions(+)<br>
<br>
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h<br>
index cd06ff41d4f..d94f84b46a7 100644<br>
--- a/target/hexagon/internal.h<br>
+++ b/target/hexagon/internal.h<br>
@@ -31,6 +31,11 @@ void hexagon_debug(CPUHexagonState *env);<br>
<br>
=C2=A0extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];<br=
>
<br>
+void G_NORETURN do_raise_exception(CPUHexagonState *env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t exception,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong PC,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t retaddr);<br>
+<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
=C2=A0extern const VMStateDescription vmstate_hexagon_cpu;<br>
=C2=A0#endif<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index 13e3c2c3a41..54b22f2fee4 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -37,6 +37,25 @@<br>
=C2=A0#define SF_MANTBITS=C2=A0 =C2=A0 23<br>
<br>
=C2=A0/* Exceptions processing helpers */<br>
+G_NORETURN<br>
+void do_raise_exception(CPUHexagonState *env, uint32_t exception,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 target_ulong PC, uintptr_t retaddr)<br>
+{<br>
+=C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
+#ifdef CONFIG_USER_ONLY<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot;%s: 0x%08x\n&quot;, __func_=
_, exception);<br>
+#else<br>
+=C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot;%s: 0x%08x, @ %08&quot; PRI=
x32 &quot;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, e=
xception, PC);<br></blockquote><div><br></div><div>Just print this in both =
user and system mode.</div><div><br></div><div>Also, use PRIx32 instead of =
the x in the format string.</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);<br></blockquot=
e><div><br></div><div>Consider defining this macro to a nop in user mode.=
=C2=A0 Then you don&#39;t need the #ifdef CONFIG_USER_ONLY in this function=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#endif<br><br></blockquote><div><br></div><div>Otherwise</div><div>Reviewe=
d-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylo=
rsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000c8743b064c24de6a--

