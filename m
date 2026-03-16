Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5307DF53D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Bgd-00044V-IO; Mon, 16 Mar 2026 13:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BgV-000444-Ut
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:24:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2BgU-0003Sq-CH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:24:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35a1f3f07ebso1922901a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681893; cv=none;
 d=google.com; s=arc-20240605;
 b=V5OG6utrl6nB3tUJy+UB3NI/eqoEoAWYDMAlsLA1L9g3ZYYqcZzPxEF+qknsywYuWI
 troiq5gAFgvfBA6+kQ25mGypmKdgQfN1RsMRqjec/gtXbLmG9ohNFduP4S1Kc+9g7/3l
 to1wemrYzKB+zBQNYyPj4zYhmR3NWvkISvtXyrNyM2yq8oPlWhgu4bgcywtdZz8clRSS
 4GFAB+gMDyqttOwRJTA3xqcY69ATWF6THrXvwKaTNGDFuitNcUDq3lpt69ORl2wxhaLv
 yR25MLTILCWM6qE0lBMIyEXDeMlgME8zboaN8uT/fvPX8bChitVtFY4h/zqSVt8x3Zjx
 nSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X4foYIlGwPcV/frYrr8gyeWxWPiNykcrtIixRJI3Kgk=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=lsLj7O/dOdo8EPOqD0KALO+54FtaC0O2/nGOK1Q5/b3WkD26AQ5iYeE/+zUEL3ihin
 kTjRS2a3IO1maVSUO7KWFY+NoAXikoivF0na+/SXEc6L8ZGztbljFT9k3t2ERQnp+B+N
 kPkY8WL5VK9VF7GOylPRG8ljt2hEkXLXE4bGYh/xJRUYMps0MBzvTMzkOG7qGfskqJuc
 2dHtHjGHNzjGABCAphkznsvroKGAijo3P4BBW5B8uTrd79nrBLwfr9L4iwj2DVJUDxHM
 sJ3kjAvjWAekB68ETeOUYZPlESdMgVJhOXEwDqMYkufO3arEXcPA+r9l5doWVnS6B9eD
 ZSxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773681893; x=1774286693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X4foYIlGwPcV/frYrr8gyeWxWPiNykcrtIixRJI3Kgk=;
 b=UZ36lewSOLuiBi+1yrN2gsRCPgKviopt/DA06rJPONKbf2IG9nryutCbdOUjOlFdzx
 VJRcKu0Rs3kGeZwbVjbDHRJo5q8T8FuksuBU5DkH5X3E0BSgAaj0iUIBwG7u0QiQiRtv
 anUyAJPYxXwVdaHNJ3/d14VPSZmT8cWiYWhTPMdl2JmZC8nfKxUUBmHV/AOnKLfg/BEM
 lGjef526k1se3jxPEaHeGcNIinCLFPEQ4Kno+6gSHi6rxLtCBk81WVPCa7w3nE/8hFoq
 T6wl5PVm9gSjaDXIoD4an7T/LC3+voB46ddPEE2KmfaDNmbfaCI7RyJMo/TMSL3uhjkL
 MN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773681893; x=1774286693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4foYIlGwPcV/frYrr8gyeWxWPiNykcrtIixRJI3Kgk=;
 b=Q+xY4N7lQfM/6aVFG5lweL/p6SOf1jiW4owMVVGmRJCvE1Ak6N++BbE4PddWrAbJc0
 PoWYcbUe6VdE13FIeA4rzmBjIc78YsrPl344879YVGwwRwIYxArbeCchgsxAPQJy137r
 uNfkY0ufVhjjuI9W0LUDfNXvHboAb4w8fZ9Z7ECiduxL7xCjp3gcHXpGOkiAY5aP7ka/
 Dc7GJm16AVSloho9lAdIH8nmI0NVejl4bhYQw0i/5RY6PY8wQ+0k+P0hUtBG3UQ1EZ+c
 Kvum+U6VtAeXldUIBiaY1w0aUlXc1+H5D5d/591xFNLbwHKzuteJ6prEUz54EBVyJKxn
 yDBA==
X-Gm-Message-State: AOJu0YxfY5R3mVcdxdoisNb00HCR+Z6SuydnPPbSbDVRcgWtK7kRY2OR
 0xULog7JuNohKbXaG2u9PkuHPpenOlnHM9w4OJ9+rtttMDIJzCwxtbioiq12opqilI2Qv9DqAOd
 bH2tdZYRALXDuyZYLcmgOuu4+XmqXZFA=
X-Gm-Gg: ATEYQzyN7Vy9el3eyuVpw5jBRnbKxO/dHPPxZOXZ1NDTI5c2miwExyvzaDPs/8Oh/Gt
 cpvHXLeSod+R3jyIv3r326tXLtyCTgiiIdMacr3Z38aIwehMBb95Mzf01aOu1qvsezC86LG4Hiq
 DSsnI4fzdPLCjK72HdB7oSiPB4M0pUFkAkXngVRpBQEcrB2I6XYBF5dxXW8I3fXg9uue77I8Aha
 RDO64flSMUSa7FlKmlgdRrixuJcTh4YFT+ey0No7P98o6V5Dtj/xf2FtDYxeSk3KCkdxebaNAXx
 nt23miQ+EHwATktqyqc91k39kWiZu66g0SY1Cw==
X-Received: by 2002:a17:90b:4a47:b0:359:ff8a:ee55 with SMTP id
 98e67ed59e1d1-35a21ec0e5fmr11706466a91.14.1773681892719; Mon, 16 Mar 2026
 10:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-28-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-28-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:24:41 -0600
X-Gm-Features: AaiRm511TF2Dplncp4F7a9i58DlSVa9XDGavQerm4OpwinsnYSaXSWghpOs8Z_s
Message-ID: <CAATN3Npcybx3x2e6V+8nKHCfOrRXo54ndqKTBQz_2ZBGWtjxBQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/32] target/hexagon: Add TLB, k0 {un,}lock
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000029014b064d277fc2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1035.google.com
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

--00000000000029014b064d277fc2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/sys_macros.h |   3 +
>  target/hexagon/op_helper.c  | 117 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
>
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1232,6 +1235,120 @@ void HELPER(modify_ssr)(CPUHexagonState *env,
> uint32_t new, uint32_t old)
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Double k0lock at PC: 0x%x, thread may hang\n"=
,
>

Don't use %x


> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %d attempted to unlock k0 without having
> the "
> +                      "lock, k0_lock state =3D %d, syscfg:k0 =3D %d\n",
> +                      env->threadId, env->k0_lock_state,
> +                      GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
>

Don't use %d

The patch description mentions TLB, but this patch only implements k0

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000029014b064d277fc2
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
=C2=A0target/hexagon/sys_macros.h |=C2=A0 =C2=A03 +<br>
=C2=A0target/hexagon/op_helper.c=C2=A0 | 117 ++++++++++++++++++++++++++++++=
++++++<br>
=C2=A02 files changed, 120 insertions(+)<br>
<br>--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>@@ -1232,6 +1235,120 @@ void HELPER(mod=
ify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)<br>+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;Double k0lock at PC: 0x%x, thread may hang\n&quot;,=
<br></blockquote><div><br></div><div>Don&#39;t use %x</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;thread %d attempted to unlock k0 without having the &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;lock, k0_lock state =3D %d, syscfg:k0 =3D %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 env-&gt;threadId, env-&gt;k0_lock_state,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));<br></blockquote><div><br></di=
v><div>Don&#39;t use %d</div><div><br></div><div>The patch description ment=
ions TLB, but this patch only implements k0</div><div><br></div><div>Otherw=
ise</div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimp=
son@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div><br></div><div><b=
r></div></div></div>

--00000000000029014b064d277fc2--

