Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF759CA1005
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 00:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utbKg-0004m3-UO; Tue, 02 Sep 2025 20:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utbKc-0004kc-7O
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 20:26:34 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utbKa-0005Lu-8t
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 20:26:33 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so6231740fac.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 17:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756859190; x=1757463990; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ojMM3DSGurOM+fnFHd1qQ6BjKqQ2fmjMD9Qvz0IqYE8=;
 b=g68KSz2gM0HXo1AS7Qe2zwM5XLX6m/df3Ge7ccB8IRsXSJnSxTLF7lDGRBtOWZjHHv
 MzUNDFEREoQgKMmYeBPVR16slSw3wkvAAI0kaYmwsCGyeF0/+SiusLHgx2G9jJcf8tqK
 QkXm9Qc9G6w7amnAhpAlO2TlPJEFAs4JFT/BiA2/WLZFm35JT7AvmrBI52ThpGqZzD8M
 XhHlgHzDRblwQnn3p0NcALLHnPAXz5swR3JEH6gcUFbIfH9razzsOCmVcy2wP7bGKg+g
 YFgG10Mo1vehZ5Odr/XggpTcjMh4HFVtwIR6IXhARvTn6d3GKiTgMJabPwvaaj+Ywyju
 TGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756859190; x=1757463990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ojMM3DSGurOM+fnFHd1qQ6BjKqQ2fmjMD9Qvz0IqYE8=;
 b=X3UMFwIxfz+nSPiY9mPsHcO/iUFFZ6y/f3NrZsazv3cWboca+a2f8Hd0CQjmHkDtSg
 3m234PFa738aZ1nYKOrWclbfwqjoBtRQLsYnDE7MElrNKsMvxZiAhT/S6oqv0lwPbUo4
 p0OO+lfWNFEtgmxTNhFY7vCC04ukppuTnCPWLRQ5Mx11hOB3dBcI8fjqVdzRq2ZSqWRM
 vdbvpEeDbNYmjc6yvjbYH/SbYyvoVuJqqmw9qBrDJgij/VgBFlLm+CwdVTCD2eQTbc2Z
 kxryj0OX65RVkeAUcqQGopebd5AkCXrKAjrmVkYXIp6weg2P3tUB5dsvXI6b+9pltt8w
 vgSQ==
X-Gm-Message-State: AOJu0YyG6yTfcfYniCoHI9Jmk7HZCdIAOYYrnnhyIIDL8EmB2KDI6z/h
 zuo2f5VeFRyv58nIPlz41s6OeEIcOUv+Uvj/HTpYjch3+1fuVEplMSAj/J1NumXIFwtdeBAWH2a
 rEvQy1o1mk/1Hn47nB7jMBQYl5w6x59MSBgWOxuqTXA==
X-Gm-Gg: ASbGncu7fvXUBF3okOFSlXTstRqWMAt4F8xbEKKFU/8F6Fa1VRWb7bEmVSUll4qKtQP
 98ZziS721/M1AoVwOSsHip6nEs4SHY0iUFl/wNIkNwRo3Lg7G4eoWnWy788RX2rFXDuZcYpww8t
 Rv5GUCnAhihbYhM9hTw0JSozNpate4KDErGSVeytiNAd986POd8iJlY53NkWM0izf1n9I0qq3qb
 +rwOKBN
X-Google-Smtp-Source: AGHT+IFs99mPixsyJ7Yc5+bPiusaqxlL/x91MA6N4XVfRs1vfq3g7wgdhCpYcsA6e+4W7EqOtyVaJheNM/x05upZAJ8=
X-Received: by 2002:a05:6870:3913:b0:314:b6a6:6860 with SMTP id
 586e51a60fabf-3196347d06dmr6794377fac.46.1756859189731; Tue, 02 Sep 2025
 17:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250901133815.1693077-1-max.chou@sifive.com>
 <20250901133815.1693077-3-max.chou@sifive.com>
 <5d0fe741-9063-441d-8abc-3bb0662c1fbe@linaro.org>
In-Reply-To: <5d0fe741-9063-441d-8abc-3bb0662c1fbe@linaro.org>
From: Max Chou <max.chou@sifive.com>
Date: Wed, 3 Sep 2025 09:26:19 +0900
X-Gm-Features: Ac12FXylKOyKFvo1kcQ4fxqouJUxJBvy15oY_D2DjL7KHKy4t-bpFws7dh5NXLU
Message-ID: <CANiaA1sP1KvhFhOOZRYJPzb=cf1DwTJNMTgEx5j2oppFNj6mdA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] target/riscv: rvv: Add Zvqdotq support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000ecb7ec063ddaa729"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=max.chou@sifive.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ecb7ec063ddaa729
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 22:38 Richard Henderson <richard.henderson@linaro.or=
g>
wrote:

> On 9/1/25 23:38, Max Chou wrote:
> > +#define OPMVV_VQDOTQ(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2)
> \
> > +static void do_##NAME(void *vd, void *vs1, void *vs2, int i)
> \
> > +{
>  \
> > +    int idx;
> \
> > +    T1 r1;
> \
> > +    T2 r2;
> \
> > +    TX1 *r1_buf =3D (TX1 *)vs1 + HD(i);
>  \
> > +    TX2 *r2_buf =3D (TX2 *)vs2 + HD(i);
>  \
> > +    TD acc =3D *((TD *)vd + HD(i));
>  \
> > +    int64_t partial_sum =3D 0;
> \
>
> I think it's clear partial_sum should be the 32-bit type TD.
> Indeed, I'm not sure why you don't just have
>
>         TD acc =3D ((TD *)vd)[HD(i)];

Thanks for the suggestion. I=E2=80=99ll update version 2 for this part.


>
> > +
> \
> > +    for (idx =3D 0; idx < 4; ++idx) {
>  \
> > +        r1 =3D *((T1 *)r1_buf + HS1(idx));
> \
> > +        r2 =3D *((T2 *)r2_buf + HS2(idx));
> \
> > +        partial_sum +=3D (r1 * r2);
>  \
>
>         acc +=3D r1 * r2;
>
> > +    }
>  \
> > +    *((TD *)vd + HD(i)) =3D (acc + partial_sum) & MAKE_64BIT_MASK(0, 3=
2);
> \
>
>         ((TD *)vd)[HD(i)] =3D acc;
>
> because that final mask is bogus.
>

The partial_sum and the final mask are created to ensure the behavior
described in the Zvqdotq isa spec section 3 as follows:

=E2=80=9CFinally, the four products are accumulated into the corresponding =
element
of vd, wrapping around signed overflow.=E2=80=9D

Thanks,
Max.

--000000000000ecb7ec063ddaa729
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPk9uIFR1ZSwgU2VwIDIsIDIwMjUgYXQgMjI6MzggUmljaGFyZCBIZW5k
ZXJzb24gJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIj5y
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxkaXY+
PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlkO3BhZGRpbmctbGVmdDox
ZXg7Ym9yZGVyLWxlZnQtY29sb3I6cmdiKDIwNCwyMDQsMjA0KSI+T24gOS8xLzI1IDIzOjM4LCBN
YXggQ2hvdSB3cm90ZTo8YnI+DQomZ3Q7ICsjZGVmaW5lIE9QTVZWX1ZRRE9UUShOQU1FLCBURCwg
VDEsIFQyLCBUWDEsIFRYMiwgSEQsIEhTMSwgSFMyKcKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7
ICtzdGF0aWMgdm9pZCBkb18jI05BTUUodm9pZCAqdmQsIHZvaWQgKnZzMSwgdm9pZCAqdnMyLCBp
bnQgaSnCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyAre8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIGludCBpZHg7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDsgK8KgIMKgIFQxIHIx
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDCoCBU
MiByMjvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAg
wqAgVFgxICpyMV9idWYgPSAoVFgxICopdnMxICsgSEQoaSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgVFgyICpy
Ml9idWYgPSAoVFgyICopdnMyICsgSEQoaSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgVEQgYWNjID0gKigoVEQg
Kil2ZCArIEhEKGkpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCBpbnQ2NF90IHBhcnRpYWxfc3VtID0g
MDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPg0KPGJyPg0KSSB0aGluayBpdCYjMzk7cyBjbGVhciBwYXJ0aWFsX3N1
bSBzaG91bGQgYmUgdGhlIDMyLWJpdCB0eXBlIFRELjxicj4NCkluZGVlZCwgSSYjMzk7bSBub3Qg
c3VyZSB3aHkgeW91IGRvbiYjMzk7dCBqdXN0IGhhdmU8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBU
RCBhY2MgPSAoKFREICopdmQpW0hEKGkpXTs8L2Jsb2NrcXVvdGU+PGRpdiBkaXI9ImF1dG8iPjxk
aXY+DQo8ZGl2Pg0KPHAgZGlyPSJhdXRvIj5UaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLiBJ4oCZ
bGwgdXBkYXRlIHZlcnNpb24gMiBmb3IgdGhpcyBwYXJ0LjwvcD48L2Rpdj48L2Rpdj48L2Rpdj48
ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdC13aWR0aDoxcHg7Ym9y
ZGVyLWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleDtib3JkZXItbGVmdC1jb2xvcjpy
Z2IoMjA0LDIwNCwyMDQpIiBkaXI9ImF1dG8iPjxicj4NCjxicj4NCiZndDsgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7ICvCoCDC
oCBmb3IgKGlkeCA9IDA7IGlkeCAmbHQ7IDQ7ICsraWR4KSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgcjEgPSAqKChUMSAqKXIxX2J1ZiArIEhTMShpZHgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgcjIgPSAq
KChUMiAqKXIyX2J1ZiArIEhTMihpZHgpKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgcGFydGlhbF9zdW0gKz0g
KHIxICogcjIpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGFjYyArPSByMSAqIHIyOzxicj4N
Cjxicj4NCiZndDsgK8KgIMKgIH3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCAqKChURCAqKXZkICsgSEQoaSkpID0gKGFjYyArIHBh
cnRpYWxfc3VtKSAmYW1wOyBNQUtFXzY0QklUX01BU0soMCwgMzIpOyBcPGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgKChURCAqKXZkKVtIRChpKV0gPSBhY2M7PGJyPg0KPGJyPg0KYmVjYXVzZSB0aGF0
IGZpbmFsIG1hc2sgaXMgYm9ndXMuPGJyPg0KPC9ibG9ja3F1b3RlPjxkaXYgZGlyPSJhdXRvIj48
YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXY+DQo8ZGl2Pg0KPHAgZGlyPSJhdXRvIj5UaGUg
cGFydGlhbF9zdW0gYW5kIHRoZSBmaW5hbCBtYXNrIGFyZSBjcmVhdGVkIHRvIGVuc3VyZSB0aGUg
YmVoYXZpb3IgZGVzY3JpYmVkIGluIHRoZSBadnFkb3RxIGlzYSBzcGVjIHNlY3Rpb24gMyBhcyBm
b2xsb3dzOjwvcD4NCjxwIGRpcj0iYXV0byI+4oCcRmluYWxseSwgdGhlIGZvdXIgcHJvZHVjdHMg
YXJlIGFjY3VtdWxhdGVkIGludG8gdGhlIGNvcnJlc3BvbmRpbmcgZWxlbWVudCBvZiB2ZCwgd3Jh
cHBpbmcgYXJvdW5kIHNpZ25lZCBvdmVyZmxvdy7igJ08L3A+DQo8L2Rpdj4NCjwvZGl2Pjxicj48
L2Rpdj48ZGl2IGRpcj0iYXV0byI+VGhhbmtzLDwvZGl2PjxkaXYgZGlyPSJhdXRvIj5NYXguPC9k
aXY+PC9kaXY+PC9kaXY+DQo=
--000000000000ecb7ec063ddaa729--

