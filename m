Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4008FF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdjk-0005DI-Bw; Mon, 09 Mar 2026 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzdjW-0005Ah-9J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:45:30 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzdjU-0000t4-C5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 12:45:30 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so11545911d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 09:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773074726; cv=none;
 d=google.com; s=arc-20240605;
 b=gujyKX7mFXjRcaAZjpbB7EPAi8EimCc0RH/aYPHTfAmJ+IwsgQ2fr/m3DCKkne2dkh
 CmPUZAgqsil5c/QJTy8/ydHzUrc6X1hbKGAuYFga/TjKd7GwjG/XOnuSFtuHzrszfgtK
 2wqxPg5U+lOFyJvkzZ1k7kQU1oRW9M/zKbIbYsQpl+n2KdKzWPYLbT5nxh1jXEWcLvjM
 DcsZ4ddaLIeAFX9eRjoQpRj4zuDPNyGKjBJImTIzN128ZFqpgi0ZORIFq5NuEUXLEblM
 t2LUttfgq0WrRKiS71wvze7EGmSec6YDxzDjabvi89P72c744atKD590rWrmq2/JxfKW
 nS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lJIOrcKWDh0mlmwwpQLhiBx8VG6WriqhGT85GDbI8IA=;
 fh=zxz4leYHlK8liCTg8IjU8MgvAL+aTbMLdpPccU2byLQ=;
 b=bmXV9bstzrPhpRuu4J7azUx1EfforWcyFj+PKfZB1YubzPtmn7vsaj2FVgsmj64cv3
 HACynzjhZ8SMCYOcq7/8ZSrg1wWasgapeELvRU6TbtxQmDCmunvekT2ZTJD3oGrcPsDU
 h7QXoeWGwo2Bz86rJoCJBlYGHatKdu8w/ipJ/aDWw/r3d2ZitF4GvEvq2Q1P6mxDA5Kz
 VLgen3usQYzMWTsMMbO/gmGCA9knU4JbMCTFddo3ZkW9DIaEDtoF4z0ZuJXVhliS5MpE
 2H+6EIRcfjRP8vwmWZvWybC+yxIl+30goQs3pKyE2w6gYjP3pX0gu8f5/Ek5DydLLrU/
 raeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773074726; x=1773679526; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJIOrcKWDh0mlmwwpQLhiBx8VG6WriqhGT85GDbI8IA=;
 b=pURZUouoHzH7hXy9HJ6NPPCIjkhFZOiDci0Q4/qPseuU/cvnZiwCEnTmeA15ftrzCX
 87M6PQiMf3SEB9Avju6GyhjX4lcwE9U8ErWSCbIi40PtXDp2eoPwlv/LAVC1Ncepl2A0
 I4igiV1PMNFjxLfw1Bbkt1uomjsAYizaMqt4UStz5+Zts2AT3Uy7Gd/ZLQau5kOJR/XI
 u/eWhjn7gehz6+SUuNLVHVffU/+54NH4UU+D04TWdW0zPBROeJqX7978+QA/FREGoYng
 fBaA/wqCM1c5p/ggZTq5bObA7us9oFvtQ7f8etJDAxbmVNVjl7dmTlQ14u0yGuugwGTb
 /cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773074726; x=1773679526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJIOrcKWDh0mlmwwpQLhiBx8VG6WriqhGT85GDbI8IA=;
 b=FbeVWfQhObMV+0htKhTfSiYr0MP9BRj6CIN0smp0ePRFhp2XSSk3R9RrZ8HcqwY1/4
 kCwEr/I5/Ra73g1Bme4PHGjdlauK4VRmKaXJxd3cv2LF/DAuxcqJFiTty/yNsWfPnlfd
 aCPdNYdYvEFEpluWhdDGDrJO2J1+sUaWGL82aEMckKJAKJ0Tb4Bc9TR51QNQswDznAWa
 DGkuPypoyj/nGgRvCvU0tzYuT+GW32wqz52BFjdVYKjZLbieUvfK46Er9RTkWjiu/mJb
 q06unUFpyOmLF2PKiVhh7gXbSHNw6PLqh8pAFz8J72KoXbzXv8rn4BMxp2BUdfPbOz8A
 wppQ==
X-Gm-Message-State: AOJu0Yw8+BHD8gQu63QM3NE7ynzfpB7i7eD2GFFl/fWAKPArhrf5rGzd
 wSCAoOSxJSfxuNs3RP4P291zhqgKdO9NCSB9fBipFv7BUgViYZnZedJT6zy152J2xchV3Mut1wh
 Z+7bpDS537VUYFHyn/s03risVmU2g5ovB8zG0d1SwNg==
X-Gm-Gg: ATEYQzzyqSXM4q8HNZxW5a97VgmqPHvFHIRr4MfU4aKrBlpYK5tiZyzDl3nlO1F+Ccv
 IUFD++u+WRVl2wzBCzkQa3Ll+9pIHeQTYjsOWlecRh4ezMCUrPHGZS6D6EUIBkGtvmvwzQOHnNd
 DqFRTY4IJPnVAvULHSzM4FnBjqUmI4K2nooe/sFsCBP71yEejqomjbB4y3W4Swtd3iikZpndAuT
 xu47HhIGDoSPofW42y88b1JNGaXh8mXLH5x1jD2Z7CVBT/V4NJpOfNTx/yjAB7ItNXRfMrt8WZa
 pOkuD0vbbAwBqc9fOJZXC7JoJsr/K8vFp3lxgQ4R0PhtwvdKEKnM8g63IVq71KpBWVU=
X-Received: by 2002:a05:690e:44a5:b0:649:b943:2ca9 with SMTP id
 956f58d0204a3-64d1414fc2fmr8211407d50.33.1773074725569; Mon, 09 Mar 2026
 09:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260309152617.1611566-1-peter.maydell@linaro.org>
 <87fr69ge53.fsf@draig.linaro.org>
In-Reply-To: <87fr69ge53.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 16:45:14 +0000
X-Gm-Features: AaiRm51gb6IH8BYTyf3sj0Mohhhg0cS0cbBpQ9tFvCWETX2pQRmfH4YRnGhkfuo
Message-ID: <CAFEAcA-JEtwT_AkKHQCOgvRjkAwcO3rAZjv7_4rdpkyQHEQGVw@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/decodetree: Fix formatting in "field examples"
 table
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 9 Mar 2026 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The rST syntax for a table uses ASCII art to draw the cell
> > boundaries; then inside each cell the text is treated as a body
> > element, so it is rendered the same way as text at the top level of a
> > document.
> >
> > The "field examples" table was assuming a "literal document" format
> > for its cell bodies; this meant that the single line cells were being
> > rendered in plain text, not a fixed width font, and the multi line
> > cells were rendered as definition-lists because of their "second and
> > subsequent lines are indented" layout.
> >
> > Fix this by consistently using inline-code markup for the left column
> > and literal blocks for the right column.  (We want to be consistent
> > within each column because a literal block renders differently to
> > inline-code, with a green background.)
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > You can see the mis-rendered version at
> > https://www.qemu.org/docs/master/devel/decodetree.html
> > ---
> >  docs/devel/decodetree.rst | 44 ++++++++++++++++++++++++---------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> >
> > diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
> > index 98ad33a487..33cd6fe583 100644
> > --- a/docs/devel/decodetree.rst
> > +++ b/docs/devel/decodetree.rst
> > @@ -64,23 +64,33 @@ A field with no ``fields`` and no ``!function`` is =
in error.
> >
> >  Field examples:
> >
> > -+---------------------------+-----------------------------------------=
----+
> > -| Input                     | Generated code                          =
    |
> > -+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
+
> > -| %disp   0:s16             | sextract(i, 0, 16)                      =
    |
> > -+---------------------------+-----------------------------------------=
----+
> > -| %imm9   16:6 10:3         | extract(i, 16, 6) << 3 | extract(i, 10, =
3)  |
> > -+---------------------------+-----------------------------------------=
----+
> > -| %disp12 0:s1 1:1 2:10     | sextract(i, 0, 1) << 11 |               =
    |
> > -|                           |    extract(i, 1, 1) << 10 |             =
    |
> > -|                           |    extract(i, 2, 10)                    =
    |
> > -+---------------------------+-----------------------------------------=
----+
> > -| %shimm8 5:s8 13:1         | expand_shimm8(sextract(i, 5, 8) << 1 |  =
    |
> > -|   !function=3Dexpand_shimm8 |               extract(i, 13, 1))      =
      |
> > -+---------------------------+-----------------------------------------=
----+
> > -| %sz_imm 10:2 sz:3         | expand_sz_imm(extract(i, 10, 2) << 3 |  =
    |
> > -|   !function=3Dexpand_sz_imm |               extract(a->sz, 0, 3))   =
      |
> > -+---------------------------+-----------------------------------------=
----+
> > ++-----------------------------+---------------------------------------=
-------+
> > +| Input                       | Generated code                        =
       |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > +| ``%disp   0:s16``           | ::                                    =
       |
> > +|                             |                                       =
       |
> > +|                             |   sextract(i, 0, 16)                  =
       |
> > ++-----------------------------+---------------------------------------=
-------+
> > +| ``%imm9   16:6 10:3``       | ::                                    =
       |
> > +|                             |                                       =
       |
> > +|                             |   extract(i, 16, 6) << 3 | extract(i, =
10, 3) |
> > ++-----------------------------+---------------------------------------=
-------+
> > +| ``%disp12 0:s1 1:1 2:10``   | ::                                    =
       |
> > +|                             |                                       =
       |
> > +|                             |   sextract(i, 0, 1) << 11 |           =
       |
> > +|                             |       extract(i, 1, 1) << 10 |        =
       |
> > +|                             |       extract(i, 2, 10)               =
       |
> > ++-----------------------------+---------------------------------------=
-------+
> > +| ``%shimm8 5:s8 13:1         | ::                                    =
       |
> > +| !function=3Dexpand_shimm8``   |                                     =
         |
> > +|                             |   expand_shimm8(sextract(i, 5, 8) << 1=
 |     |
> > +|                             |                 extract(i, 13, 1))    =
       |
> > ++-----------------------------+---------------------------------------=
-------+
> > +| ``%sz_imm 10:2 sz:3         | ::                                    =
       |
> > +| !function=3Dexpand_sz_imm``   |                                     =
         |
> > +|                             |   expand_sz_imm(extract(i, 10, 2) << 3=
 |     |
> > +|                             |                 extract(a->sz, 0, 3)) =
       |
> > ++-----------------------------+---------------------------------------=
-------+
>
> Shouldn't we just use the proper markup
>
> .. list-table:: Field Examples
>   :widths: 30 70
>   :header-rows: 1
>
>   * - Input
>     - Generated Code
>   * - %disp   0:s16
>     - sextract(i, 0, 16)
>   ...
>
> ?

What "proper markup"? This is using the "grid tables" syntax from
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#tab=
les
You're suggesting "list table" syntax, which requires that the data can
be represented by a uniform two level bullet list. I don't think either
is more "proper" than the other. (Can you even put literal-block markup
inside a bullet list item?)

thanks
-- PMM

