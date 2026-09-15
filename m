Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B3C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 23:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6cwU-0004df-Pb; Tue, 15 Sep 2026 19:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cwR-0004dJ-0L
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:51:59 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6cwP-0004lG-Hl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 19:51:58 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85f0fc1fd8eso213633b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789516316; cv=none;
 d=google.com; s=arc-20260327;
 b=KjKMGkAGFZZgGFzMqkHEsJGvBQCi6w1Q+OcSnW5o+ObhGtXqUaUIjaLlxDFZHXL7Or
 XCeDxvtLsr52zepiuGyF+VRa5vYKuBKS29Ds6rnjEqzXe9CWA7L+ASg4P7Z8wPx+SELU
 lw2XkUaI6A6/xMp+n404zp8VOqgdel7b8xiQa9l1pgIg8twNohGmc59w1kvKP4lEvJ8O
 IHedr9odEWtb+96E9BgVdS5eeX/d4xiiw3NHZr3PtHFO20yDhYfs9PibFXY5hEez1p0b
 3V4xecsl0d2yXjhzLB7u0hPaqZFws6+G4mk2DUvUfjiZj7MJ+Le3Ute5/kNiuUSMyetx
 LSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DcTktokyCWgS/l+JQBzl0U6NqJPXYg2gW7F4ECFbL5M=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=RrDaVFvVqs/WYXf3p+XBgVhqzo2U4nLaCd6coYI+vaefZUSDbrhS7cKGkD2jG3oRUY
 SGiWoXfFpPs68boX1pQnf2O/oqclRZhZK8f6KGbmMhvoxLfOOohVOWlKZk9jb8JGw+TQ
 RjjnCLE0x36xwa1qH6SagyY522QtMtyKmU5Fleos+NEXh04O6tyZcRaPYu1GCVsmjDjo
 JncXc35to7Q3U6rE7XRiv3DZGdW5/8s5YCDLXRMP81egq4nNaiEyEzgTcppmVcFburgi
 0/JAuwwOTtdjMBwnwGcaMxbwNT2L4QnJbJZQrQi4QjxpyuNUoY7xPTaSEzkZCpp0K58p
 slpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789516316; x=1790121116; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DcTktokyCWgS/l+JQBzl0U6NqJPXYg2gW7F4ECFbL5M=;
 b=JSNJwwXp2GrDYlLa/qI9HGo3FA5uw7fN/yibyWId7JtMuhOn+4ptlrW5+VgEFWYOGd
 q7V3vLWXuJmKrF5I/6pHeZwkPTIXsjqZVJmKFKmnuoU39iDwIc/YtsDG1C2ogX9mqfl/
 xtnqw+7fcEGFrl6v8a27pM8cXhIBnM5sp1+1zxPgrj26nO2MY89YXhwXpYGNkibkPcZp
 M4B4YbPzPrSK2gblER+b+y19OAzO8QQCtPsABaTamBJfb6Cy94z6dwbkyHFph4LswhjQ
 yjgBVpYPEPXpd3seI+g6orQ3fVA669sSLJbB8wbn5wzSfaZvXhvh2T4J0gr3vlXukLR6
 8KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789516316; x=1790121116;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DcTktokyCWgS/l+JQBzl0U6NqJPXYg2gW7F4ECFbL5M=;
 b=fWkYLnOyVz2MUOYMDcVhxRISGhJwZgBbudwlzPpB7VnFGa+6Sro7sRsxFjz601u/rt
 EZdd/wyyiJNyIKDqVumCYTjiOVI3JyM8CGbfjeD+zEXbqnYOPoUPiVkY5wBF4/bpcUtd
 DguWf76fCiI3GcAaDgqth66PdIGZQyHsl9LJCc25YqOy43lLPF6yrIloEIFDRWUR8lq2
 yd+x4dMQJA+1VP0Nm6FpU1DMp4VW2BgiIegRfNWai+ZajsvqGZ5d2KzHDTDaxrRokEXy
 vm1MJhJyGd+xBm7zRLUONeRrrEK3pnBVvXt7dy4sxO4GfIYGphnuWLab/74+JTtkPhBl
 EL5Q==
X-Gm-Message-State: AFuF++kyEEtI9QdCSxbuCPGfVO08qLMbZhuvwkF2EU5aT8GRq5n52d8+
 UPzdxuDZaaZsbwKsN5d6oXgd9RKJbO+gM4BX12i3XVs7OlAGLnrE+VMXM+DCaoK7kLTVs3u9ok6
 lyDSWH4i29IqH+jKwYXDCrNMMmCuORhU=
X-Gm-Gg: AYBFou0EklfOo2ZY2+RHqF4/Q95Zh5qUF2qBmyhIRN5T0zKIl/WHon4yuZbl6gJWFLk
 PHToCQEg4gYN6or37VPMovyFMNdabvIRsg/Ob0LT6dVOgwBYjYhSgbQ7NhRBeACawWQjbvgy6d4
 UFJqYmm7Y7OG2ipzSiYC3jZ8D/xDyW/htzBpjJnHjH95QBzMoZphlXcDzlewBjIoFHPqHruuxNZ
 NF2wekJVE0iNE34JrgCFW1uEjcA54NiLgmKZ7M8w0ymQP/c5asJxRkHRU/2UGFgEi+HEHhZ3IF8
 Xr7NGxxinnnGhJNW6wLbu/EMfCa9Ny5oLlucZCbVL3B8a+EnW+4+dVJH0fPMCYIPyqZXulbEsKD
 7ax//w1Ae0mqchgzB4uNgbA==
X-Received: by 2002:a05:6a20:6f8c:b0:3c2:dcdd:a85a with SMTP id
 adf61e73a8af0-3dd5f5dd0a9mr1160118637.13.1789516316052; Tue, 15 Sep 2026
 16:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
 <20260915154502.4106597-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260915154502.4106597-5-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 15 Sep 2026 17:51:44 -0600
X-Gm-Features: AcwNN1Xff25ia5jSxblIBY3SW-oXsoIK4VamULZ2ueajxuMeUvEgEPolDyvcIQ8
Message-ID: <CAATN3NpD++_Tkdmd+4oF7qT=KfyT4khDaJJ88oXZo=TG1HiNCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tests/functional/hexagon: add bestwait systest
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000568f83065b8e3caa"
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pz2-x10.google.com
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

--000000000000568f83065b8e3caa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:45=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_systests.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/functional/hexagon/test_systests.py
> b/tests/functional/hexagon/test_systests.py
> index 2779efa9172..15c6d22acfa 100755
> --- a/tests/functional/hexagon/test_systests.py
> +++ b/tests/functional/hexagon/test_systests.py
> @@ -93,6 +93,9 @@ def test_semihost(self):
>      def test_dtg_interrupt(self):
>          self.run_exit_zero("dtg_interrupt")
>
> +    def test_bestwait(self):
> +        self.run_exit_zero("bestwait")
> +
>      def test_mmu_multi_tlb(self):
>          self.run_exit_zero("mmu_multi_tlb")
>

Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000568f83065b8e3caa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 9:45=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Signed-off-by: Brian Cain &lt;<a hre=
f=3D"mailto:brian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.q=
ualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/functional/hexagon/test_systests.py | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/h=
exagon/test_systests.py<br>
index 2779efa9172..15c6d22acfa 100755<br>
--- a/tests/functional/hexagon/test_systests.py<br>
+++ b/tests/functional/hexagon/test_systests.py<br>
@@ -93,6 +93,9 @@ def test_semihost(self):<br>
=C2=A0 =C2=A0 =C2=A0def test_dtg_interrupt(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.run_exit_zero(&quot;dtg_interrupt&qu=
ot;)<br>
<br>
+=C2=A0 =C2=A0 def test_bestwait(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.run_exit_zero(&quot;bestwait&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_mmu_multi_tlb(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.run_exit_zero(&quot;mmu_multi_tlb&qu=
ot;)<br></blockquote><div><br></div><div>Acked-by: Taylor Simpson &lt;<a hr=
ef=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</di=
v><div>=C2=A0</div></div></div>

--000000000000568f83065b8e3caa--

