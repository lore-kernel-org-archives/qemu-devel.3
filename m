Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1FEC61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 13:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0IjY-0004rK-O6; Sat, 29 Aug 2026 09:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1x0IjX-0004r9-7A
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 09:04:31 -0400
Received: from mail-pj2-x03.google.com ([2607:f8b0:4864:39::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <olegendo1024@gmail.com>)
 id 1x0IjV-0003Oa-GU
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 09:04:30 -0400
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-3859292bb51so125796a91.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788008668; x=1788613468; darn=nongnu.org;
 h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
 :to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0drcZXCFoxT7Wldeebnd1GWfRKJ1z20mESczlN/b5W0=;
 b=QQs6XeN0+BB9lxg/l7ESSxEi3GakfNh7bvQmvgz+j/xSkTiu3izNgMGezkludW8KcC
 w7QgidPtvdTNkwdW/wjlmNHu1kpDG0ocOipSV4fZIfF+tM9U8ynbCQz0FiUV0Mn4YnSl
 ZXUytf8VPwaEqXBbSUMu2f3Szvu6fjpxoCoillJeFiawc7zKSfy4NtF1lYzo4l7/wsRV
 ImXiI9jkjGXQMKsH2rYV+gVg4kU4BqvRAC2SttIjwUGvNhqM/Fmz450xEIyg6XO527Qc
 egHPzO+1FbGMrlqW4szJzsajywUtJmimVRKt+nfFWxdjCZwhVoJqBtLMapFGz4FZqaet
 mPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788008668; x=1788613468;
 h=mime-version:user-agent:content-type:references:in-reply-to:date:cc
 :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0drcZXCFoxT7Wldeebnd1GWfRKJ1z20mESczlN/b5W0=;
 b=MVMYTLtez2Q7EBQPJx19OWGm1s6Tv2pmsbq3D7sUagbwI6QgW0CDNGvuDuEc0itdPp
 w7WroADAT3ulo1NAdIt0yj5QwM5IFfdIGh43zAPxdt50IFmE6DKtiA2HQB0z2Tcmfequ
 sgQ64mXkShZD7Sjofh9TATIZRx0WxA8LRC5NvMoGEGxKpvCKZQbvooUem7VoPQ8vWvrs
 OAmr2rns/m3h4VT9rDOnC8oZuXvkSGxnWu2r9lh1lljMhSe71paAPKlKIsyI8xiiahO+
 4wUTjsgSvJ8OY3s3PsY0FRND3qby7N3NNg9qZUsY8JT388R3iQe3muewnY8XQcrpD7WB
 hbnA==
X-Gm-Message-State: AFuF++nhY6D0n8L4Fx0tS3OdS1+/JNBBVEBmGs12Wi3cv6wUUFI00MIy
 +5fdf0XRLbOx8TXg7OoWeIOkcHibLzHPJHOveW0iA12T7go7+AIpvJAW2Wjbpt1w5Ls=
X-Gm-Gg: AYBFou00hFg4FklM2tK1otrC0uWI3rYBZooJ8i+VeD0p45eL3uNrLoUjGV91SVpQ49A
 MhFg/mUkjhFoAAH41HrWD6MfqpCDrgDKF2y0O4Tj2lGoolj3UpkYIQ1BMyPp2FnUdcMuwVTHcuB
 krUyO5uM4dsc0AY7GCShDQfG3PmDL6qeQnhRvASwMcC3B8Ycg3mUBWL4Ib++VcnPS9iTwpHQu4f
 UEgq58X4sSnM9vvbTGdkKvxdwRXYLeAqAWIqHtBcEZsk7C6Z6kMUrIjVIAB8OEkaZPrLZ7iYHqe
 2Rd4QGlc/JUXQbAFVOo3ezE+McARhuWvVq32+r5vtFIisy3QSeiDGeIglFYuZITqVQe+olIYgef
 UAo3Yo3DvZBSqvGjdpARKuM8amkQRUmi170h4TdqZHvjvAx9t1bEMwYHHN0e7Gah7YTCTHkxG7g
 M6xDLe8cVH28ukDO5tQ7w+0XreVNdl297OiNfAM4EcX1h7DCJUe4v7C3cdWjuZD8CU6pOqr1v5p
 x1kXvU9
X-Received: by 2002:a17:90b:5287:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3989b533bc5mr5730081a91.3.1788008667527; 
 Sat, 29 Aug 2026 06:04:27 -0700 (PDT)
Received: from localhost.localdomain ([2407:c800:3620:e800:7910:9280:8105:5a2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b1992435sm12191036a91.13.2026.08.29.06.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 06:04:26 -0700 (PDT)
Message-ID: <50649a6bdc2c69fe5a2994cae7787288840e4d4c.camel@gmail.com>
Subject: Re: [PATCH][SH] Fix mac.w / mac.l insn
From: Oleg Endo <olegendo1024@gmail.com>
To: yoshinori.sato@nifty.com
Cc: qemu-devel@nongnu.org, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>
Date: Sat, 29 Aug 2026 22:04:24 +0900
In-Reply-To: <1b76d526ad21616241b433a254653977e009a2e3.camel@gmail.com>
References: <4a86e81ffa5e392efa069463cd21457374915b93.camel@gmail.com>
 <87jypdqf6f.wl-yoshinori.sato@nifty.com>
 <1b76d526ad21616241b433a254653977e009a2e3.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-I78KCk0CH2RDY/0af+BC"
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:39::3;
 envelope-from=olegendo1024@gmail.com; helo=mail-pj2-x03.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

--=-I78KCk0CH2RDY/0af+BC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-26 at 21:27 +0900, Oleg Endo wrote:
> On Wed, 2026-08-26 at 20:44 +0900, yoshinori.sato@nifty.com wrote:
> >=20
> > It is true that the current behavior differs from the pseudocode in the=
 manual.
> > Wouldn't it be simpler to just generate a TCG that matches the pseudoco=
de?
> > I'm sorry, I haven't actually tested this change yet.
> >=20
> > diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> > index e503a97b22..64fe2cd31d 100644
> > --- a/target/sh4/translate.c
> > +++ b/target/sh4/translate.c
> > @@ -801,13 +801,13 @@ static void _decode_opc(DisasContext * ctx)
> >          {
> >              TCGv arg0, arg1;
> >              arg0 =3D tcg_temp_new();
> > -            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> > -                                MO_TESL | MO_ALIGN);
> > -            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
> >              arg1 =3D tcg_temp_new();
> >              tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
> >                                  MO_TESL | MO_ALIGN);
> >              tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
> > +            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> > +                                MO_TESL | MO_ALIGN);
> > +            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 4);
> >              gen_helper_macl(tcg_env, arg0, arg1);
> >          }
> >          return;
> > @@ -815,13 +815,13 @@ static void _decode_opc(DisasContext * ctx)
> >          {
> >              TCGv arg0, arg1;
> >              arg0 =3D tcg_temp_new();
> > -            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> > -                                MO_TESW | MO_ALIGN);
> > -            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
> >              arg1 =3D tcg_temp_new();
> >              tcg_gen_qemu_ld_i32(arg1, REG(B11_8), ctx->memidx,
> >                                  MO_TESW | MO_ALIGN);
> >              tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 2);
> > +            tcg_gen_qemu_ld_i32(arg0, REG(B7_4), ctx->memidx,
> > +                                MO_TESW | MO_ALIGN);
> > +            tcg_gen_addi_i32(REG(B7_4), REG(B7_4), 2);
> >              gen_helper_macw(tcg_env, arg0, arg1);
> >          }
> >          return;
> >=20
> >=20
>=20
> Thanks, I think you're right.  I'll have another look and report back in =
a
> few days.
>=20

I've checked it, the attached patch has less clutter, as per your suggestio=
n
and it works.

Best regards,
Oleg Endo

--=-I78KCk0CH2RDY/0af+BC
Content-Disposition: attachment; filename="qemu-sh4-mac-order-v2.patch"
Content-Type: text/x-patch; name="qemu-sh4-mac-order-v2.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3RhcmdldC9zaDQvdHJhbnNsYXRlLmMgYi90YXJnZXQvc2g0L3RyYW5zbGF0
ZS5jCmluZGV4IDUzYjA5MjEuLjRhYjQzOWIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9zaDQvdHJhbnNs
YXRlLmMKKysrIGIvdGFyZ2V0L3NoNC90cmFuc2xhdGUuYwpAQCAtODA2LDI4ICs4MDYsMjggQEAg
c3RhdGljIHZvaWQgX2RlY29kZV9vcGMoRGlzYXNDb250ZXh0ICogY3R4KQogICAgICAgICB7CiAg
ICAgICAgICAgICBUQ0d2IGFyZzAsIGFyZzE7CiAgICAgICAgICAgICBhcmcwID0gdGNnX3RlbXBf
bmV3KCk7Ci0gICAgICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzAsIFJFRyhCN180KSwg
Y3R4LT5tZW1pZHgsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1PX1RFU0wgfCBN
T19BTElHTik7CiAgICAgICAgICAgICBhcmcxID0gdGNnX3RlbXBfbmV3KCk7CiAgICAgICAgICAg
ICB0Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzEsIFJFRyhCMTFfOCksIGN0eC0+bWVtaWR4LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNT19URVNMIHwgTU9fQUxJR04pOwotICAgICAg
ICAgICAgZ2VuX2hlbHBlcl9tYWNsKHRjZ19lbnYsIGFyZzAsIGFyZzEpOwotICAgICAgICAgICAg
dGNnX2dlbl9hZGRpX2kzMihSRUcoQjdfNCksIFJFRyhCN180KSwgNCk7CiAgICAgICAgICAgICB0
Y2dfZ2VuX2FkZGlfaTMyKFJFRyhCMTFfOCksIFJFRyhCMTFfOCksIDQpOworICAgICAgICAgICAg
dGNnX2dlbl9xZW11X2xkX2kzMihhcmcwLCBSRUcoQjdfNCksIGN0eC0+bWVtaWR4LAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBNT19URVNMIHwgTU9fQUxJR04pOworICAgICAgICAg
ICAgdGNnX2dlbl9hZGRpX2kzMihSRUcoQjdfNCksIFJFRyhCN180KSwgNCk7CisgICAgICAgICAg
ICBnZW5faGVscGVyX21hY2wodGNnX2VudiwgYXJnMCwgYXJnMSk7CiAgICAgICAgIH0KICAgICAg
ICAgcmV0dXJuOwogICAgIGNhc2UgMHg0MDBmOiAvKiBtYWMudyBAUm0rLEBSbisgKi8KICAgICAg
ICAgewogICAgICAgICAgICAgVENHdiBhcmcwLCBhcmcxOwogICAgICAgICAgICAgYXJnMCA9IHRj
Z190ZW1wX25ldygpOwotICAgICAgICAgICAgdGNnX2dlbl9xZW11X2xkX2kzMihhcmcwLCBSRUco
QjdfNCksIGN0eC0+bWVtaWR4LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNT19U
RVNXIHwgTU9fQUxJR04pOwogICAgICAgICAgICAgYXJnMSA9IHRjZ190ZW1wX25ldygpOwogICAg
ICAgICAgICAgdGNnX2dlbl9xZW11X2xkX2kzMihhcmcxLCBSRUcoQjExXzgpLCBjdHgtPm1lbWlk
eCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU9fVEVTVyB8IE1PX0FMSUdOKTsK
LSAgICAgICAgICAgIGdlbl9oZWxwZXJfbWFjdyh0Y2dfZW52LCBhcmcwLCBhcmcxKTsKICAgICAg
ICAgICAgIHRjZ19nZW5fYWRkaV9pMzIoUkVHKEIxMV84KSwgUkVHKEIxMV84KSwgMik7CisgICAg
ICAgICAgICB0Y2dfZ2VuX3FlbXVfbGRfaTMyKGFyZzAsIFJFRyhCN180KSwgY3R4LT5tZW1pZHgs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1PX1RFU1cgfCBNT19BTElHTik7CiAg
ICAgICAgICAgICB0Y2dfZ2VuX2FkZGlfaTMyKFJFRyhCN180KSwgUkVHKEI3XzQpLCAyKTsKKyAg
ICAgICAgICAgIGdlbl9oZWxwZXJfbWFjdyh0Y2dfZW52LCBhcmcwLCBhcmcxKTsKICAgICAgICAg
fQogICAgICAgICByZXR1cm47CiAgICAgY2FzZSAweDAwMDc6IC8qIG11bC5sIFJtLFJuICovCg==


--=-I78KCk0CH2RDY/0af+BC--

