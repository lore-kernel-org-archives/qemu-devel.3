Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E0EF53D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2C01-0000c2-B6; Mon, 16 Mar 2026 13:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bzn-0000aA-JH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:44:53 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bzm-0007dB-0g
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:44:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35a211df8e3so2360125a91.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683088; cv=none;
 d=google.com; s=arc-20240605;
 b=XJ4uq0QCSGugyUziXytB+Nf/8rF8Q5pECtr4a5N/Z0u48PDPv3gU2L51Ys8Ph0hiXu
 1K1GSJ7Q75JSfXPzhvB2ZkFJSKIXe5QxDrf0SR/GYhdwFeG0tG3vbZ30S6lGoBgKp6vb
 qaNLtQpqOmLpyJV4areeYwfsNsMJyCmJQg/Y4vyTy3XCtvOH44KNwjj/Y/gmjQ9KGYp8
 XttgtJYYxLN7jUZHGzryrmzzoSaICfz+/yn05/ghDXD9n8KS5n1Blw6LcJsK3dzAQ+WH
 THtC1ujNUeV9DJJ7WgzUlz3gkVtZ4X0CAQOsNZI7YDmlb1dZ8tpForetXGBYf5oXg16t
 gkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wCjt1SLPpY11Tx4M6+SICeFDokzUbqGLeZBJ386Jotw=;
 fh=i4bqhp4tX+yXDV/4yN3Y1brN4XMmOfl+v8GydVIDoOk=;
 b=OAN1meHnvqg+nq7HiYIsNT88HR1lZXplEFCPig1YBt3LGyLJehUr0E4qJxhW9Z6Rrw
 2Mm244hRo/ppS+UuU+UrXZWZYYNVdnYwDlA9S12AsRS66Lk50D3Lziuor1HHPhx0F90y
 PuAHPFrFdi86V/SFzlWm8Cv/27awvWpsAvPujh/6VGfDmJG7Qy4qXoF+jJTKcqEqZmsv
 nx9R6rhGoyGrA6l5CXhxvARKR6VTI7iXtp07ZsfPZNckPWRryQj6vHA43mK3L4dcuoZN
 Cbmajx4f/G0OyW7wrLeJro2Xw3l2vYz66cBpBD+gXo4/tE7P+fa3wnO0ghscpakmrYj3
 g3UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773683088; x=1774287888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCjt1SLPpY11Tx4M6+SICeFDokzUbqGLeZBJ386Jotw=;
 b=C9f+acKs7utxsh0Pul6enJdejZA49LMtU/ZY25bwZPs5u3Nb1sh94IWm3hY7M7mtWh
 667BKTfqF4cWVqYI58dcWhyExXzGubsoRlVEIr7ijUB1971WEkJNjC4GRySPD5OaNvcl
 QTBHP3bzBNFo1Xg74aBKeHqQrO4lKcKUUn6HXEgsnjONgIf5/cHxM9N+I2rEHW/SQVaO
 WZeyF/TlXI1olgqSKz+epyuyBHmzbCwydnV/JeoW67S8esa7cN5ouL91msHBL8HVbmP0
 7NCPxxUw0Z2gXlpICpLLznm359rH+3yuusjFOIynV1lAcwbcVJMah+4SZLE9Ld6IOX6H
 zM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773683088; x=1774287888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCjt1SLPpY11Tx4M6+SICeFDokzUbqGLeZBJ386Jotw=;
 b=kdZjKXkgkbyfz4DnId1lBgzzejoLKo/6WQTSeoPe6LiyTDRUVtD78Atr3RHllRDFtV
 zP7bbzjhyXPpOMslFBlc7rOSkt3Zy4mFa7W2gQ7S7mMUt9kG+peF0OgtYZJ0Ge2AALnN
 XprTHQcL46p3ElHUkhfZg0CWvJboO//dtgINjrntzm+mM9oIbs+Ky3uSFrj/N2L/Hhih
 1bk+cw+oVWICy3sW32Bq97iwE2nljeS8DzDwICzVEjdLXFXRxg7W9pcM8EyzgvJblbk6
 YK/h7iU9h5PuVRDCDg8H9gXA5btZleUePdaI9k9BIxGMxxwv0dZ/9HvsvMSUSLLkjWhl
 K04A==
X-Gm-Message-State: AOJu0Yy36IdZJ1nNSOayjndHKTbRHCvb/OsVHuF+G6KxUMAXj79uOrdh
 y3YwGpmfINFykMZDGaCbKYvDWN7Ha6ypXE8xXXa1SFc0KsdJnqLCvfr7rm33rgpB/SQqCDzEgCl
 YmtMmef3uLlifMDU/0+FOL1jJGPF6ifw=
X-Gm-Gg: ATEYQzyLTgBBr70Tf1rXfqtOjhtZkgFSKYkeZjB9KJ2xQ+WQbudwpTuRtuHwSuFTyVC
 EX61vCCySoSarYZI7BrvOhYpCXbJUCp9YmKZzMaKLTqQRUdLDe/NespmfSK06XDNowRTbCOkvmG
 bEc4VrjUXE10SP03s2OcFO/S/eraNUTP6yyM70yUloyMiL/+mmLGdLoEc8Q+q+LuEQ2pQqInxVT
 KzH8Hm8O6Og3ae+r+VrjVIahMkzNEjnCGuolkKnxMirHl8iIVRsQqw3n6XzcqxkNp8IMYTLYXaA
 3BGv+6FTQ+9et9LPZGCV3oKOrPGTFKTu9j6aaQ==
X-Received: by 2002:a17:90b:4e84:b0:35b:9d0c:a2f5 with SMTP id
 98e67ed59e1d1-35b9d0cb646mr3959360a91.33.1773683088374; Mon, 16 Mar 2026
 10:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-32-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-32-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:44:36 -0600
X-Gm-Features: AaiRm52SvFawdRqtDukjxM7d9DdF4RWCb39SQMUTfAOhX2T79aeaebAUQUarVkk
Message-ID: <CAATN3NpSot45xR+o3t1WLe4s+BG-vkQXst9r=PrHpCFJyAdNqQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/32] target/hexagon: Add guest reg reading
 functionality
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Content-Type: multipart/alternative; boundary="0000000000006d3d94064d27c6c6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1030.google.com
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

--0000000000006d3d94064d27c6c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/cpu.c       | 21 +++++++++++++++++++++
>  target/hexagon/op_helper.c | 16 ++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--0000000000006d3d94064d27c6c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Matheus Tavares Bernardino &l=
t;<a href=3D"mailto:quic_mathbern@quicinc.com" target=3D"_blank">quic_mathb=
ern@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:quic_mathbe=
rn@quicinc.com" target=3D"_blank">quic_mathbern@quicinc.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 +++++++++++++++++=
++++<br>
=C2=A0target/hexagon/op_helper.c | 16 ++++++++++++++--<br>
=C2=A02 files changed, 35 insertions(+), 2 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylors=
impson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></=
div></div>

--0000000000006d3d94064d27c6c6--

