Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76073D2069A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 05:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0wZL-0006cR-TN; Wed, 16 Oct 2024 01:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t0wZH-0006bA-CM; Wed, 16 Oct 2024 01:27:31 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t0wZE-000178-DU; Wed, 16 Oct 2024 01:27:29 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-84fed1ff217so312018241.1; 
 Tue, 15 Oct 2024 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729056446; x=1729661246; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7s6LaF8HLU1+LTUpLEbCCMuQlW1z2c45d0NbMycco1I=;
 b=FjyJim0zyiBzSbaflBxiVdiGqgNZHQTVL2m3062KotlM9DYanpYDbr53pKcMjoN21k
 xDs8nMgxDTw+Z3+YQUrDqwLk7MDUu6zqhSEhmL56zQ7WDm/Ct/NI68SXBeSCUPbD/Zai
 iuhBAH9cdlorKKE3OEdd2Q2G05rYHgyM4HBzHNM+z4atAhblSgiqqdlaVYR+1dth6HQ2
 uw6cmTk041ZexB/omse8zbjrroaT2scUnLt5wcYhfzVvo/ZkOoelBG8YQdgWU06z1XVv
 kdMFNUHqugt/EgaSe46mksQJOjT4c1EnHJn9opCAKYJG1ip5RKhqXZ0RUjC86XVo1d0M
 iJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729056446; x=1729661246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7s6LaF8HLU1+LTUpLEbCCMuQlW1z2c45d0NbMycco1I=;
 b=ReJhmzY9jbNvDK1nIPDLmDvXZU/nxzerSZ+20HXMyxMfUde8DRIcFCE6hgjBF+zYMa
 zwEigWnnz8HJsYbKH3Gyb27/yzurrr9att/gQq66HV/htDPIzb0DjYrJXNFeDT1/J5Su
 77huM6m7ahWblkW9AXHuooQ5iYOzJaoToc9TuYhPUh6W9gOEgAmMHAs8jHPjkbVIVbz2
 6q0aNOJAGlgcpwqPpB3wyKrRnOGyrfdBC52UH7uwZ9O9bq7ATHojvhfvBH1rjvfFYE7P
 41040eAAS36qP/0XZxnOJSwniLAsFRpJZooogVXovYNVITa3cYgPB/134jpVqyTpBRnY
 +zPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdZ/tdqvfEdmQ4rKWhf81/N4hoHrz/GG72tARd2heJ0lQkUkt6+fgtd4LVYc+sv3ESxbdF6E7oFvG@nongnu.org,
 AJvYcCVaykhY7gqW68duEDYOozkEKNEFMMisVc7k6uls2P3f/nBQbKvnztQj4BuffK1+iGoMi7pijTVLKMTduw==@nongnu.org
X-Gm-Message-State: AOJu0YyZQwGRJdnHuGy3RqZmZdxOk5rKpMW4pfzXT1+etJGv+JRoPfQw
 mD9x8a7T8jhZNSq3UnKimAUYXZski5xDTJlMvgKJ6q9SFJIQRcIc+9aaHUxi/MNRRJUZ/NuBbb4
 +kwTvCB6Lu3NoVQPZnBsq3v8dWFk=
X-Google-Smtp-Source: AGHT+IFC5XjkHzTNtKDVIS9Ac3vApduksqwHE1M1Mn284/aWIC4svcZYidWBrlqCzGC/BhBU0wUzgx4xFV+icZ1BthQ=
X-Received: by 2002:a05:6122:17a6:b0:50d:6cfc:ac4d with SMTP id
 71dfb90a1353d-50d6cfcc2d5mr5332269e0c.5.1729056446251; Tue, 15 Oct 2024
 22:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
 <CAKmqyKMobSzu-q8jdPhAU9PMG2GsGG1eOsemSS-Ny2vrX+wSbQ@mail.gmail.com>
 <52abee8d.225ee.1928a805a21.Coremail.yanmingzhu@iscas.ac.cn>
In-Reply-To: <52abee8d.225ee.1928a805a21.Coremail.yanmingzhu@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Oct 2024 15:27:00 +1000
Message-ID: <CAKmqyKOvgXKg+WioV2P1+Pe_DfgY1uUYs3cmMFQ8UtefPdDYKw@mail.gmail.com>
Subject: Re: Re: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes
 infinite loop in ACT.
To: =?UTF-8?B?6ZiO5piO6ZO4?= <yanmingzhu@iscas.ac.cn>
Cc: MingZhu Yan <trdthg47@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Mon, Oct 14, 2024 at 8:08=E2=80=AFPM =E9=98=8E=E6=98=8E=E9=93=B8 <yanmin=
gzhu@iscas.ac.cn> wrote:
>
> Thank you for your reply and I'm sorry that I didn't explain it clearly.
>
> - ACT is an official riscv test suite to check the riscv support of the D=
UT(device under test).

It's probably worth including this in the commit message.

> - Currently ACT support using [sail-riscv](https://github.com/riscv/sail-=
riscv)(default) or [spike](https://github.com/riscv-software-src/riscv-isa-=
sim)
> - QEMU is not supported yet=EF=BC=8Cbut someone made a commit: [commit](h=
ttps://github.com/qemu/qemu/commit/66247edc8b6fb36d6b905babcd795068ea989ad5=
)
>
> But there are still problems, so I'm trying to fix it. After debugging, I=
 found that it's a htif problem, and the idea of fixing it is referenced fr=
om the sail-riscv implementation

It would be good to reference the sail implementation and the
justification for the change there

Alistair

>
> "Alistair Francis" &lt;alistair23@gmail.com&gt;=E5=86=99=E9=81=93=EF=BC=
=9A
> &gt; On Fri, Sep 27, 2024 at 11:26=E2=80=AFPM MingZhu Yan <trdthg47@gmail=
.com> wrote:
> &gt; &gt;
> &gt; &gt; Applications sometimes only write the lower 32-bit payload byte=
s, this is used
> &gt; &gt; in ACT tests. As a workaround, this refers to the solution of s=
ail-riscv.
> &gt;
> &gt; I'm not sure what ACT is, but this feels like a guest bug, not a QEM=
U issue.
> &gt;
> &gt; Alistair
> &gt;
> &gt; &gt; if the payload is written a few times with the same value, we p=
rocess the whole
> &gt; &gt; htif command anyway.
> &gt; &gt;
> &gt; &gt; Signed-off-by: MingZhu Yan <yanmingzhu@iscas.ac.cn>
> &gt; &gt; ---
> &gt; &gt;  hw/char/riscv_htif.c | 35 +++++++++++++++++++----------------
> &gt; &gt;  1 file changed, 19 insertions(+), 16 deletions(-)
> &gt; &gt;
> &gt; &gt; diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> &gt; &gt; index 9bef60def1..d74cce3bef 100644
> &gt; &gt; --- a/hw/char/riscv_htif.c
> &gt; &gt; +++ b/hw/char/riscv_htif.c
> &gt; &gt; @@ -65,16 +65,8 @@ void htif_symbol_callback(const char *st_nam=
e, int st_info, uint64_t st_value,
> &gt; &gt;  {
> &gt; &gt;      if (strcmp("fromhost", st_name) =3D=3D 0) {
> &gt; &gt;          fromhost_addr =3D st_value;
> &gt; &gt; -        if (st_size !=3D 8) {
> &gt; &gt; -            error_report("HTIF fromhost must be 8 bytes");
> &gt; &gt; -            exit(1);
> &gt; &gt; -        }
> &gt; &gt;      } else if (strcmp("tohost", st_name) =3D=3D 0) {
> &gt; &gt;          tohost_addr =3D st_value;
> &gt; &gt; -        if (st_size !=3D 8) {
> &gt; &gt; -            error_report("HTIF tohost must be 8 bytes");
> &gt; &gt; -            exit(1);
> &gt; &gt; -        }
> &gt; &gt;      } else if (strcmp("begin_signature", st_name) =3D=3D 0) {
> &gt; &gt;          begin_sig_addr =3D st_value;
> &gt; &gt;      } else if (strcmp("end_signature", st_name) =3D=3D 0) {
> &gt; &gt; @@ -290,18 +282,26 @@ static void htif_mm_write(void *opaque, h=
waddr addr,
> &gt; &gt;                            uint64_t value, unsigned size)
> &gt; &gt;  {
> &gt; &gt;      HTIFState *s =3D opaque;
> &gt; &gt; -    if (addr =3D=3D TOHOST_OFFSET1) {
> &gt; &gt; -        if (s-&gt;tohost =3D=3D 0x0) {
> &gt; &gt; -            s-&gt;allow_tohost =3D 1;
> &gt; &gt; -            s-&gt;tohost =3D value &amp; 0xFFFFFFFF;
> &gt; &gt; +    int htif_cmd_write =3D 0;
> &gt; &gt; +    if (size =3D=3D 8 &amp;&amp; addr =3D=3D TOHOST_OFFSET1) {
> &gt; &gt; +        htif_cmd_write =3D 1;
> &gt; &gt; +        s-&gt;tohost =3D value;
> &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST_OFF=
SET1) {
> &gt; &gt; +        if ((value) =3D=3D (s-&gt;tohost &amp; 0xFFFF)) {
> &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> &gt; &gt;          } else {
> &gt; &gt;              s-&gt;allow_tohost =3D 0;
> &gt; &gt;          }
> &gt; &gt; -    } else if (addr =3D=3D TOHOST_OFFSET2) {
> &gt; &gt; -        if (s-&gt;allow_tohost) {
> &gt; &gt; -            s-&gt;tohost |=3D value &lt;&lt; 32;
> &gt; &gt; -            htif_handle_tohost_write(s, s-&gt;tohost);
> &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 0, 32, value)=
;
> &gt; &gt; +    } else if (size =3D=3D 4 &amp;&amp; addr =3D=3D TOHOST_OFF=
SET2) {
> &gt; &gt; +        if ((value &amp; 0xFF) =3D=3D (s-&gt;tohost &amp; 0xFF=
00)) {
> &gt; &gt; +            s-&gt;allow_tohost =3D s-&gt;allow_tohost + 1;
> &gt; &gt; +        } else {
> &gt; &gt; +            s-&gt;allow_tohost =3D 1;
> &gt; &gt;          }
> &gt; &gt; +        htif_cmd_write =3D 1;
> &gt; &gt; +        s-&gt;tohost =3D deposit64(s-&gt;tohost, 32, 32, value=
);
> &gt; &gt;      } else if (addr =3D=3D FROMHOST_OFFSET1) {
> &gt; &gt;          s-&gt;fromhost_inprogress =3D 1;
> &gt; &gt;          s-&gt;fromhost =3D value &amp; 0xFFFFFFFF;
> &gt; &gt; @@ -312,6 +312,9 @@ static void htif_mm_write(void *opaque, hwa=
ddr addr,
> &gt; &gt;          qemu_log("Invalid htif write: address %016" PRIx64 "\n=
",
> &gt; &gt;              (uint64_t)addr);
> &gt; &gt;      }
> &gt; &gt; +    if ((s-&gt;tohost =3D=3D 1 &amp;&amp; htif_cmd_write) || s=
-&gt;allow_tohost &gt; 2) {
> &gt; &gt; +        htif_handle_tohost_write(s, s-&gt;tohost);
> &gt; &gt; +    }
> &gt; &gt;  }
> &gt; &gt;
> &gt; &gt;  static const MemoryRegionOps htif_mm_ops =3D {
> &gt; &gt; --
> &gt; &gt; 2.34.1
> &gt; &gt;
> &gt; &gt;
> </yanmingzhu@iscas.ac.cn></trdthg47@gmail.com>

