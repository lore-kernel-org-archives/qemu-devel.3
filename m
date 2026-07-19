Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7D3C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 21:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlZ6x-0004Pl-W9; Sun, 19 Jul 2026 17:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wlZ6w-0004PZ-JS
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:31:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wlZ6u-0008J1-Tx
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:31:46 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso7855087a12.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 14:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784496703; cv=none;
 d=google.com; s=arc-20260327;
 b=D+kmkcs6qdAMjJPF21GSEC3a9by4ciPDx6Onkf2UybOy2dlX5ITFTfo+07+7FuXjLk
 Ffn54dkenpa2IZ9nsxL2ZY4PwgA9kqlSs9kyYey52TGDOQ7i30S1OoVt3ZBrePRFHvVt
 u2LpD25WWxWFFHZ36J0v3Zu39FKb5BAswOlSTp8C7iHAxE5gpHlWQ1G9dgYv8c1ImxB+
 VZrVuhpWUrOrfHlgLXgKJGlJGnYtFfN6TIZ8v2jFpyaiARyOyVsdf3QAqZgbkaUvCewp
 /wvpwPmZrwd469G4gDqAYXIctoOE1+JNq2TSFOzu663JiDVEoedYll9s7sYfNSLElfNE
 dGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I9D++XKaA7sRSwWl9BhH9LVqyHpbfYDXpnovj1NZvy8=;
 fh=JuLQCNmMiksbImbnJAcswwnmIBEA9QO04KFWdo98ljw=;
 b=NLfWviH5vzxxZ8IR86IbEmv2wmMNu41vUdyJyUYbPItt878qgypWhh61bKv8vn1hGU
 tl4XIrDTwA+n6L7i6YFkRMS0/hGregtSm53vIB5/0Ps42uuo7trM3+IQMe8u1cOWm3I1
 2tQ4p3m9/GOiiLnScrHALbeGORga+E1N/sQ29Mkui/xLvai8ngyMnPh7NPpp4HVbJjwv
 Is1kM/9eq7gX83dC3LOKWd0TkcWYqPL9a8b9ZK5asVnT6ocjTwdGvOVoVAKtbEYQw7bO
 jf+ptYAXt7Bvq3qTPxzamJ2I6j+t+7BQnrLWIfSfSieAIGrGsuoo1G7xbn+TWxbRcZz/
 OLwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784496703; x=1785101503; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I9D++XKaA7sRSwWl9BhH9LVqyHpbfYDXpnovj1NZvy8=;
 b=OHcw1S19m8KdvAEEEOnDtM2uccLNzQk38X1Q+N/NebI/3RwHF//FbBPLkvlVMKlBTI
 jGocEdh6b3z5ZRDpftjDpJg4QbKCspaYIRVwIyI0w/7n6t3Jc+sAPCN89+nuFOlTt0KO
 CwmehM6AkNxEBllCLF7SFOBdqP4f4N92w5V7xJF45XBqbMtBtpEXNLJCMtDbzSpdm2B7
 8HzGOTEOAXUzeGf+rWKh1bXjml3S0c96ykJlZIuBm9Uej8EN04+TLiNhe3Q3egE+bNob
 6xNAahwO/seiC+C/u/HLG9By/blvcjbuoYBlQzu8vp4V1I0NOv6zH0sxkJ5xroDQGDvs
 twtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784496703; x=1785101503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I9D++XKaA7sRSwWl9BhH9LVqyHpbfYDXpnovj1NZvy8=;
 b=NkOU3wKQQazYAD/83VAs4ERMq4V/RYQeX7nuLbGdYq6NDSNnciKEgrEj2nlXxYVXsO
 Hu+gfkeusqUX30gsdqDVHrHv9M0yoYgzEhReUFCioy/sT58FyYUmQbBhYZeaZJJ+VyIF
 40IwIa2n+Q4wsvF35T/8pEAP/Hl4ggPnj9zATP6Dx4b5ieTqRgvBcXQ98vfeuzXlOWNR
 I7JHTCpD9njpgPGLmk/+X+FonswRmZ9+EDlyl6FS+o5pT0XoHr7pBwmRBDHEZJWifzNR
 6U/8efNbN3hEI+6JYt+Gpc1ZKXMvP6FZv55MlFeGfKQsQZhXdIA1PdvrAO2pwNHEutag
 t4dw==
X-Gm-Message-State: AOJu0Yw7iqBE4S+a4yoqhqtm+Zw9aDESrGlXXn6BeUqBZVYll1GcFZ+l
 ZVzwXdXq+Wqt1TohWmAFrXQnsBq+KpooE3sULc6JzNZ1aw4LuGGCdGxc8qOuqeW3bYvUxVHfsJZ
 CkoXzhvBOshFZr3753E4f1hysrTNPvLs=
X-Gm-Gg: AfdE7ckru4NelxBy/94hdP4eJq7RH98Yg6BHMnpl8NK+GKRu/Utxxto8rouldZy8eQG
 8TlfOVuS4py6EC0bcnQUuAIP9ez3ZgFwz+DWbgCTuYdKhc83ggcEW5dw7hMo9aq/F/wb0OnY8pr
 u16mVYva+lD9DCwRTrQHxnNeQ00oCm3Mg5mQDT4Svj91kLS/j6AoRJwAyRD1W0a/nq4DJVWfUfC
 SrFFndvzUB6qh9YKLiPzVPQFaneHBk01FqZi/Fz25QHObREN0Ns2HdSQwJ5CtfDDOOP1B7wKgV3
 XVGlP6Bt3hm6std2rw==
X-Received: by 2002:a05:6a00:2445:b0:848:469b:3d19 with SMTP id
 d2e1a72fcca58-84c292ac511mr11062517b3a.29.1784496703349; Sun, 19 Jul 2026
 14:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260715185701.1287176-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sun, 19 Jul 2026 15:31:32 -0600
X-Gm-Features: AUfX_myemHmXq-urnmlwdDg2uB98LSy--ntqihnmj5tQOod9-hHtEkvQ1NyZifs
Message-ID: <CAATN3NrrFdrU7Be=q+nSH6s-r0Bixh3qetEOL-+ov+F8o7HiWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] target/hexagon: fix PC not advancing for non-COF
 TB-ending packets
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000001b26c90656fd84b1"
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

--0000000000001b26c90656fd84b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:57=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Add hex_next_PC, a global mirroring CPUHexagonState::next_PC,
> and ctx->need_next_pc, so that gen_write_new_pc_addr() can write the
> branch target through hex_next_PC instead of hex_gpr[HEX_REG_PC]
> when a later unconditional write of PC is expected. gen_end_tb()
> then commits hex_next_PC into hex_gpr[HEX_REG_PC] at the end of the
> packet.
>
> Previously, non-COF instructions that still end a TB did not advance the
> PC, since next_PC's value was never written back into the PC register.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |  3 +++
>  target/hexagon/genptr.c    | 14 ++++++++---
>  target/hexagon/translate.c | 51 ++++++++++++++++++++++++++------------
>  3 files changed, 49 insertions(+), 19 deletions(-)
>
>
> @@ -1327,6 +1344,8 @@ void hexagon_translate_init(void)
>      }
>      hex_new_value_usr =3D tcg_global_mem_new(tcg_env,
>          offsetof(CPUHexagonState, new_value_usr), "new_value_usr");
> +    hex_next_PC =3D tcg_global_mem_new(tcg_env,
> +        offsetof(CPUHexagonState, next_PC), "next_PC");
>

This only lives within the context of a single packet, so it shouldn't be
global.

Put it into DisasContext and make it a tmp similar to new_value.

--0000000000001b26c90656fd84b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 15,=
 2026 at 12:57=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Add hex_next_PC, a global mirroring=
 CPUHexagonState::next_PC,<br>
and ctx-&gt;need_next_pc, so that gen_write_new_pc_addr() can write the<br>
branch target through hex_next_PC instead of hex_gpr[HEX_REG_PC]<br>
when a later unconditional write of PC is expected. gen_end_tb()<br>
then commits hex_next_PC into hex_gpr[HEX_REG_PC] at the end of the<br>
packet.<br>
<br>
Previously, non-COF instructions that still end a TB did not advance the<br=
>
PC, since next_PC&#39;s value was never written back into the PC register.<=
br>
<br>
Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qu=
alcomm.com" target=3D"_blank">pierrick.bouvier@oss.qualcomm.com</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.h |=C2=A0 3 +++<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 | 14 ++++++++---<br>
=C2=A0target/hexagon/translate.c | 51 ++++++++++++++++++++++++++-----------=
-<br>
=C2=A03 files changed, 49 insertions(+), 19 deletions(-)<br>
<br><br>
@@ -1327,6 +1344,8 @@ void hexagon_translate_init(void)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0hex_new_value_usr =3D tcg_global_mem_new(tcg_env,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(CPUHexagonState, new_value_usr),=
 &quot;new_value_usr&quot;);<br>
+=C2=A0 =C2=A0 hex_next_PC =3D tcg_global_mem_new(tcg_env,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 offsetof(CPUHexagonState, next_PC), &quot;next=
_PC&quot;);<br></blockquote><div><br></div><div>This only lives within the =
context of a single packet, so it shouldn&#39;t be global.</div><div><br></=
div><div>Put it into DisasContext and make it a tmp similar to new_value.</=
div><div>=C2=A0</div></div></div>

--0000000000001b26c90656fd84b1--

