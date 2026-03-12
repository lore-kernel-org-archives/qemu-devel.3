Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BC106ACEC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nnW-0004SE-7Z; Thu, 12 Mar 2026 17:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nnS-0004S4-VH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:42:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w0nnR-0002Og-Ah
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 17:42:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c73bbdc01b7so568367a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 14:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773351740; cv=none;
 d=google.com; s=arc-20240605;
 b=VFLl5CQfaVwuThK7GYnQKMbBBAixvr3XUKoO60nwYKC6d7/tf+sI0UBAFDlatw6fdV
 G06M/JHPH8CHAglIpSJPia4Ie7IygFF01SYIa4R/q04HklxhM7OrTKnj/Tiw1YOoNbDb
 6YjEK1J3k4wY6MVmn+6tdokyxJdbvfVVvuRpFDT4TtrPt8GSrJqkiUgbDIYHGL61wk7J
 beY4RwQPpoa079gj9J19c5yBCxN7nXXC9FWejQc5K6+Gfa2cwnJS7xvf7Mq6Pq2ZopJF
 TyYZRRTNh7UJcTn6zfTDpb5GC8ua1SVur0LN3ik+HRAxxFfPMol5/mhPMX5WgEgFDh/Q
 vVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9GwGXIQkjx2VpGBF1LcT32T+6lCF7oYJXgAYwIrkN8U=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=Z6dT8XeA6EMnBRQwXCoUAk9zpZKu86WoKiWOeIZLmGfbvtrwf/9jWi6cTKeEgM2Y0R
 qIeLV5y6tT/5KOsis/k4PoXykAz0hfLKV03xh4SSiI85WIp4Ck4vtyRC4PLWK02ebDM4
 8AdFidUwr/S95ojRTv5+HWUXt3rXL4GnuytWW+AZ9mg06lOdLchySQSrmbxgurSUsgbF
 X7zrF5vE1a1IrDcNm8NBrgVe1lZHaLkGoM6GOWvNzNQ875KrdrdO6glRxQL55VY+3Srk
 328dt4VvnI976Gv6ZG/mLqE2kFgO0aMjm7c1obdtCIrS+BvZaCzXv/zr3HKsmSD3c9WB
 dgxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773351740; x=1773956540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9GwGXIQkjx2VpGBF1LcT32T+6lCF7oYJXgAYwIrkN8U=;
 b=I3HLKfxOTjcVZHxCtQkULcvtxsvfTdQfFCUwXzanCeo55WwhFbDNprkuNEOIUl9nhs
 dsKE6XU2dJp0iHw8N3j0/IqhgcZh6qUTes4FWWZfr/AKr9JfwMyTcNnzso+r3ottmaXM
 SGxIPDGDjWdiPnKAa8qGwaA+vK6lxJVrT2xiH0C9fUn5ULPaIttwxXiGUaVso/7k2Cxy
 Un3EYLRExx/DRKvjX8/9+5iZd584vXs7zqslv2a4e8rWU4L5y9fNYB/bRVR/qI2z638B
 TV5OZabEHeGwZEq4P9GRLHdQVksyW9KtDw4MV6Z/WoMpTdJSSO8+qRye0dyckZPrrcs8
 RtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773351740; x=1773956540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GwGXIQkjx2VpGBF1LcT32T+6lCF7oYJXgAYwIrkN8U=;
 b=iXzMz+gv3roZyqxLUgFCP6G+SwHXa44Ip7R7bdzOxjaX7Kr6Tq0o+mIeohNdBIxOY7
 cp4NQHayEkrRdJbWi4gTcitw9yQmbwQ8PACtNjybNTKsAIs3N/zH0Jr4eDl4mXuttpnl
 mFD5B0Nlj7ilC3qtWMVlhwJKtuQEQk0+PPSIp+JWEYrHBM+g0gbf+N3YIguVphrrWQ38
 3bnLrIZ7MlwM7bm4MHOCYn6LYOxGnQmkmS+9nPUMf+1ZmkZ8YxHvjbmlmiGBzqpvVFEW
 DoOIiyoFXcRZPAdEXyo8wWGHgmfD9LbBM3T1Qz1yiAPYk63Lj+26Iupfq81PdNyNZnMn
 Gnng==
X-Gm-Message-State: AOJu0YyOmd3Y23WM8gPWQEMYghqh6wzo3yl6MsD3JTMhXwlY9TKKBfd3
 bfXqrP+tFh9aiyYNn/RTlJjm9T8T0OS8n2XafqfgPZUwevCT1M9ofZq8dlvjvrCL4RntDPoWlAA
 v82xVmkq/miKmaye6VRAhp8ulVnin56Q=
X-Gm-Gg: ATEYQzx5hrMHfGA61PVaEsuhz9JyaceQD4ChYTEf5DPjyq4jE7UYNwHxiIEZXpyYaxj
 p2F84VhemXt0TPDYtr/GNZr/IA6lE585dwU4TbWWTssvWmb/VXe9bulFh2vycKD2hY5W2eQGY7H
 Z2anE5YcX1ES6zkJYDkBiR8Mho6aszWuNu674FV4tC+YcDnZPVorE787DgMB5iKrPiERNSLEeOB
 0SG3Ohxvm/Me7ao4jsdd94gI4tk7qW5J3OVjXZzqsNYDz5MA2X0M+8weUWMMPsoks6jSQCzutMZ
 XizaAO9W8Rc15hrGn0a62PrdD0YA6qYsKytWGQ==
X-Received: by 2002:a17:90b:1641:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-35a21fd7f8cmr935140a91.16.1773351739742; Thu, 12 Mar 2026
 14:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-6-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 12 Mar 2026 15:42:08 -0600
X-Gm-Features: AaiRm53Dtal6g7983rOmsT44pFN_mhqxVUqPvjP1b0az0EQK2_xUffCUWX_lfSE
Message-ID: <CAATN3NoXYSYy5sBMfL6aXu0toJnZpbM8uPXEsE29jJErQsJcwg@mail.gmail.com>
Subject: Re: [PATCH v3 05/32] target/hexagon: Implement {g,s}etimask helpers
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000825f8a064cdaa098"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52e.google.com
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

--000000000000825f8a064cdaa098
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 82605f1d4aa..161c7eaf31f 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1496,12 +1496,43 @@ void HELPER(resume)(CPUHexagonState *env, uint32_=
t
> mask)
>
>  uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
>  {
> -    g_assert_not_reached();
> +    CPUState *cs;
> +    BQL_LOCK_GUARD();
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env =3D &found_cpu->env;
> +        if (found_env->threadId =3D=3D tid) {
> +            uint32_t imask =3D found_env->t_sreg[HEX_SREG_IMASK];
> +            qemu_log_mask(CPU_LOG_INT, "%s: tid " TARGET_FMT_lx
> +                          " imask =3D 0x%x\n", __func__, env->threadId,
>

Don't use %x


> +                          (unsigned)GET_FIELD(IMASK_MASK, imask));
> +            return GET_FIELD(IMASK_MASK, imask);
> +        }
> +    }
> +    return 0;
>  }
>
>  void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask=
)
>  {
> -    g_assert_not_reached();
> +    CPUState *cs;
> +
> +    BQL_LOCK_GUARD();
> +    CPU_FOREACH(cs) {
> +        HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);
> +        CPUHexagonState *found_env =3D &found_cpu->env;
> +
> +        if (tid =3D=3D found_env->threadId) {
> +            SET_SYSTEM_FIELD(found_env, HEX_SREG_IMASK, IMASK_MASK,
> imask);
> +            qemu_log_mask(CPU_LOG_INT, "%s: tid " TARGET_FMT_lx
> +                          " imask 0x%x\n",
>

Ditto

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000825f8a064cdaa098
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
=C2=A0target/hexagon/op_helper.c | 35 +++++++++++++++++++++++++++++++++--<b=
r>
=C2=A01 file changed, 33 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index 82605f1d4aa..161c7eaf31f 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -1496,12 +1496,43 @@ void HELPER(resume)(CPUHexagonState *env, uint32_t =
mask)<br>
<br>
=C2=A0uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *found_env =3D &amp;found_cpu-=
&gt;env;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (found_env-&gt;threadId =3D=3D tid) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t imask =3D found_env-&gt=
;t_sreg[HEX_SREG_IMASK];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot=
;%s: tid &quot; TARGET_FMT_lx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot; imask =3D 0x%x\n&quot;, __func__, env-&gt;threadId=
,<br></blockquote><div><br></div><div>Don&#39;t use %x</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (unsigned)GET_FIELD(IMASK_MASK, imask));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return GET_FIELD(IMASK_MASK, ima=
sk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
=C2=A0void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t im=
ask)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+<br>
+=C2=A0 =C2=A0 BQL_LOCK_GUARD();<br>
+=C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *found_cpu =3D HEXAGON_CPU(cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUHexagonState *found_env =3D &amp;found_cpu-=
&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tid =3D=3D found_env-&gt;threadId) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SET_SYSTEM_FIELD(found_env, HEX_=
SREG_IMASK, IMASK_MASK, imask);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(CPU_LOG_INT, &quot=
;%s: tid &quot; TARGET_FMT_lx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot; imask 0x%x\n&quot;,<br></blockquote><div><br></div=
><div>Ditto</div><div>=C2=A0</div><div>Otherwise</div><div>Reviewed-by: Tay=
lor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@=
gmail.com</a>&gt;</div><div><br></div></div></div>

--000000000000825f8a064cdaa098--

