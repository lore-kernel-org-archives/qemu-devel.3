Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B72D715FE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 23:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjnFt-00014l-Hk; Sat, 24 Jan 2026 18:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vjnFr-00014c-LX
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 18:41:23 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vjnFp-00067t-UE
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 18:41:23 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34f2a0c4574so2997068a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 15:41:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769298080; cv=none;
 d=google.com; s=arc-20240605;
 b=FLRW9oEhjHljFFv4flglh+SlBjyXl3i3tXV7/D4zpxhN2/RcNTQNnMyzdNew2GyeRC
 hwdsOZg6Eg7R9Yh4dz83zSinlR2TJZGHIWou1LpkCbRUItJzaXci3i+YOmKzaeF+7Id0
 El/UXqAo/w+XHZnTYHa5noTZndWmdz9vM0mij/ScHGLlwLcRecwvNKnMH6vNQ/i7zhRG
 r4T4mStPEIJh8HGs7uW+yPfeUA6iyk86sJs1BzOYOREtt0hXuZzJqQ4jxTcMQDQCmN7D
 jgelK3ygKao0jB74oz2qt4JZxsXTjxve6k3JkblkYcAsgo1ZVOipK1wOC5EYugdq0q9Z
 NDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nuYpJT9Cz0+xIPhvU/sIFsUeybzJju0YRNabfECE94c=;
 fh=HMorgUNBgejytIvOYdxrAsrIoD5WoaQ4S7Oaqtzu/uU=;
 b=e4Eyc2YJcO71AZCFyNywG2oiODla4upvoZnLsV7S2gtpu603JbsZYZa8ipjIr451RF
 4OC8Xf6I7UkUFFR2YuDgtQGc5iMYIy/EFnnxvBSTETS1CZNHaJO6Unr7rUPcVzmHzA8d
 R925RFmpAOqojR67zq+0JAcwgDmoWXaJK31qq3WJ23K2FXOhdFCic1JhB1s+0G6TSsWG
 xqijYlI+Zs55yyfI14kiFnfqzEvp3xa6BcQ+X7qv2HBU+GTJI4s+44dMOooS5bclI3mf
 VWdn924WdpfP9I3K0uZ/0RStX2ggX75hTW9nW8hrz6Ndx5pUF2lxcygq8zFKUiSXBwe0
 tX3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769298080; x=1769902880; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nuYpJT9Cz0+xIPhvU/sIFsUeybzJju0YRNabfECE94c=;
 b=aSjdigpA9+V0/KciikbZlrzhNATd/dIzWqAqSY2CMbLdoDLBvrB2VKir4ClkPJ/Z4B
 nF6e0ofIiAnTIaNrqqfPCEtCcLEZiwuh9yQtUBvcz7sy5ojeAt9psRz/6rRkwk2Rncch
 4kqWhGjVi4z2bPNuH335VJVtVvEhnANC0G53QnlzaV8QhThYIvKQ5+jieqaGJysTnAcj
 7dZPktkshP5wHUZAsKmPji+/O6Y5t3FIClcJK/e5n9k11B5i+1eZJVfB+HssKWAEvRgT
 SR1K+17QPQPihAWiRhiQkhZjSsPR8Cv4zdkskCm6sz/GBieARPTZ75rMICYhTG1GFIZW
 RM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769298080; x=1769902880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nuYpJT9Cz0+xIPhvU/sIFsUeybzJju0YRNabfECE94c=;
 b=Domx76LFkk3j3JLEYxZdeSUuW3wnQw99jYU4jo1VummxdrxQuMSIMed3WC0EYQwcV2
 9lwfq43TydITXGGz0gJLSzqHsWpOK3fsr3NcK/RILiy0Dpfkfo9k67NS+xgIHRve/Sm2
 f5Rw1rkR2Tkao4JMaSYfFTrnF6krQM6d69LXcj7wttty/uizODMIVnku2O3bThncN7n5
 ovMI46hI6EGrtQNb3y7E+M7PO0v9xPjkSZ0dI714ZWGlsAZon5l0MwUbMKfCuCtmQ7gf
 62GHmpLUs1Jo3ySNF6yuU2Kcsv6dTU6pSaytHKxWoM2ZC2e22Han50eQX8L0sU/QQ8F+
 g41A==
X-Gm-Message-State: AOJu0YwV4H9N+cnK4dhOnV4BwwEi32tn8M44ydexqbU6wB9ePki8IF6i
 EgEZOyiG8QrUy2CpbKDbXPTW0bGzYngNatxmSIkZCSQerZI/BmAefriNj95sdf2/dYnh3xiKGPc
 o9RvKOFahzGd20N8lVwagZ5LpQn7GUBbjKA==
X-Gm-Gg: AZuq6aJf4W5AE39/x+b74lsMz2K/SVWC2hwNqMQla582bm/2ROe7hkbhVYYXd7ZlB3k
 W6ygfBTb1uen2KVCLIQBeQ49aDnxajCUqSibC5VgHi/EozDmaJdiWnu6ouuLEcvs6gr0bZHDKmc
 hyVFuP2/fMVqDLinfC05B1T7PDi2wZVihRRfJoFbumRdC3HJVXf7TQJDwjDLhuLmiGvo76QuX7F
 cTLrRSONsduDgjX3ySiN2z5wXSHnU8xMjOVkMwDsUzHTMBG/qEyCYM3bX8LLqzyE4H1yOFD65sD
 hsQQeiv7QmBD+vcBs+QHzfO/oz4=
X-Received: by 2002:a17:90b:2d8e:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-353c40b7edemr201045a91.8.1769298079803; Sat, 24 Jan 2026
 15:41:19 -0800 (PST)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 24 Jan 2026 16:41:08 -0700
X-Gm-Features: AZwV_QhVA0S8UISB2K2i1OBFqT_u2QpHZ886vHVXWhUrCiIOypoGYGSW3vNbpco
Message-ID: <CAATN3NoZiPj5wfVm6+4MGEnrVX4sdZhnS4Wj7-_0SUe5u0wZ5w@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="0000000000008c6bf806492acf76"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102b.google.com
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

--0000000000008c6bf806492acf76
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 3:34=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> The pkt variable inside DisasContext is of type Packet * and gets
> assigned to a local variable in decode_and_translate_packet. Right now
> there seems to be no problem with it but future changes to e.g.
> hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed
> after the local variable goes out of scope.
>
> Since packets are being translated one at a time, the type of pkt can be
> changed to just Packet to avoid risk of having a dangling pointer.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h        |   2 +-
>  target/hexagon/macros.h         |   6 +-
>  target/hexagon/translate.h      |   2 +-
>  target/hexagon/decode.c         |   8 +--
>  target/hexagon/genptr.c         |  14 ++--
>  target/hexagon/translate.c      | 111 ++++++++++++++------------------
>  target/hexagon/gen_tcg_funcs.py |   2 +-
>  target/hexagon/hex_common.py    |   4 +-
>  8 files changed, 65 insertions(+), 84 deletions(-)
>
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index a0102b6cbd..ffbfc3ac0e 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -28,7 +28,7 @@
>
>  typedef struct DisasContext {
>      DisasContextBase base;
> -    Packet *pkt;
> +    Packet pkt;
>

This patch would be alot smaller if you kept pkt as-is and added a new
member
Packet packet;


>      Insn *insn;
>      uint32_t next_PC;
>      uint32_t mem_idx;
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
> index b5ece60450..c2516d927d 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nwords=
,
> bfd_vma pc,
>                          GString *buf)
>  {
>      DisasContext ctx;
> -    Packet pkt;
>
>      memset(&ctx, 0, sizeof(DisasContext));
> -    ctx.pkt =3D &pkt;
>
> Then, this line would be
ctx.pkt =3D &ctx.packet;


@@ -930,7 +915,6 @@ static void decode_and_translate_packet(CPUHexagonState
> *env, DisasContext *ctx)
>  {
>      uint32_t words[PACKET_WORDS_MAX];
>      int nwords;
> -    Packet pkt;
>      int i;
>
>      nwords =3D read_packet_words(env, ctx, words);
> @@ -939,16 +923,15 @@ static void
> decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
>          return;
>      }
>
> -    ctx->pkt =3D &pkt;
>

Ditto

Thanks,
Taylor

--0000000000008c6bf806492acf76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 22,=
 2026 at 3:34=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">The pkt variable inside DisasC=
ontext is of type Packet * and gets<br>
assigned to a local variable in decode_and_translate_packet. Right now<br>
there seems to be no problem with it but future changes to e.g.<br>
hexagon_tr_transalte_packet are potentially dangerous if pkt is accessed<br=
>
after the local variable goes out of scope.<br>
<br>
Since packets are being translated one at a time, the type of pkt can be<br=
>
changed to just Packet to avoid risk of having a dangling pointer.<br>
<br>
Signed-off-by: Marco Liebel &lt;<a href=3D"mailto:marco.liebel@oss.qualcomm=
.com" target=3D"_blank">marco.liebel@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/gen_tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +=
-<br>
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A06 +-<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A08 +--<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 14 +=
+--<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 | 111 ++++++++++++++--=
----------------<br>
=C2=A0target/hexagon/gen_tcg_funcs.py |=C2=A0 =C2=A02 +-<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A08 files changed, 65 insertions(+), 84 deletions(-)<br>
<br><br>
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<br>
index a0102b6cbd..ffbfc3ac0e 100644<br>
--- a/target/hexagon/translate.h<br>
+++ b/target/hexagon/translate.h<br>
@@ -28,7 +28,7 @@<br>
<br>
=C2=A0typedef struct DisasContext {<br>
=C2=A0 =C2=A0 =C2=A0DisasContextBase base;<br>
-=C2=A0 =C2=A0 Packet *pkt;<br>
+=C2=A0 =C2=A0 Packet pkt;<br></blockquote><div><br></div><div>This patch w=
ould be alot smaller if you kept pkt as-is and added a new member</div><div=
>Packet packet;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=C2=A0 =C2=A0 =C2=A0Insn *insn;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t next_PC;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t mem_idx;<br>
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
index b5ece60450..c2516d927d 100644<br>
--- a/target/hexagon/decode.c<br>
+++ b/target/hexagon/decode.c<br>
@@ -748,14 +748,12 @@ int disassemble_hexagon(uint32_t *words, int nwords, =
bfd_vma pc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0GString *buf)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DisasContext ctx;<br>
-=C2=A0 =C2=A0 Packet pkt;<br>
<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;ctx, 0, sizeof(DisasContext));<br>
-=C2=A0 =C2=A0 ctx.pkt =3D &amp;pkt;<br>
<br></blockquote><div>Then, this line would be</div><div>ctx.pkt =3D &amp;c=
tx.packet;</div><div><br></div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
@@ -930,7 +915,6 @@ static void decode_and_translate_packet(CPUHexagonState=
 *env, DisasContext *ctx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t words[PACKET_WORDS_MAX];<br>
=C2=A0 =C2=A0 =C2=A0int nwords;<br>
-=C2=A0 =C2=A0 Packet pkt;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0nwords =3D read_packet_words(env, ctx, words);<br>
@@ -939,16 +923,15 @@ static void decode_and_translate_packet(CPUHexagonSta=
te *env, DisasContext *ctx)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ctx-&gt;pkt =3D &amp;pkt;<br></blockquote><div><br></div><di=
v>Ditto</div><div>=C2=A0</div><div>Thanks,</div><div>Taylor</div><div><br><=
/div></div></div>

--0000000000008c6bf806492acf76--

