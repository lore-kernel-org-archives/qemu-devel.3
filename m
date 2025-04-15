Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ABEC369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4g40-0006jH-UW; Tue, 15 Apr 2025 09:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u4g3n-0006ex-SE
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:10:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u4g3g-0004q1-7B
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:10:42 -0400
Received: from loongson.cn (unknown [209.85.219.179])
 by gateway (Coremail) with SMTP id _____8Bx12nCWv5nmBm+AA--.52864S3;
 Tue, 15 Apr 2025 21:10:27 +0800 (CST)
Received: from mail-yb1-f179.google.com (unknown [209.85.219.179])
 by front1 (Coremail) with SMTP id qMiowMBxLse+Wv5nKUqDAA--.65335S3;
 Tue, 15 Apr 2025 21:10:25 +0800 (CST)
Received: by mail-yb1-f179.google.com with SMTP id
 3f1490d57ef6-e63a159525bso3716256276.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 06:10:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWgqJjPXfqFFEPmkgInWN6PmPU6t+lPIMy4WvhvGlAhTMfE8VdHVuM+e0QO7rvSt5/b2sSAZoDgSncI@nongnu.org
X-Gm-Message-State: AOJu0YxnukoYXS/+CXwU5qIMASqblm/xcLEE9m7M2i1mj1UGbMGrHDvR
 q5o4BOBgFGZKVCwNZ3jdaWz5OlwbYfI4ywAWoekfdtJz2Jpu94uqBBDx9zYAtLWA98FQIrtE35u
 trZb8yrFVMWLLz+vdF2EuLmpoozKNTIXvcmnM1A==
X-Google-Smtp-Source: AGHT+IERWD59WX4oW4/OQ/pGI7KW0Y3VYNzisMxhmHyytVllQflasXY92QhLU6RqelZe25kdFd90W5nNQSXgIcf97g0=
X-Received: by 2002:a05:6902:1281:b0:e6d:eb74:25e with SMTP id
 3f1490d57ef6-e704deb96fbmr24360922276.25.1744722621247; Tue, 15 Apr 2025
 06:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250415120628.141261-1-wangrui@loongson.cn>
 <b47c8670-42ff-445f-b5bf-c1fed7299a73@linaro.org>
In-Reply-To: <b47c8670-42ff-445f-b5bf-c1fed7299a73@linaro.org>
From: WANG Rui <wangrui@loongson.cn>
Date: Tue, 15 Apr 2025 21:10:08 +0800
X-Gmail-Original-Message-ID: <CAHirt9jWiycqRF8YUyzAdvaGs94FCVzr_iF+nDrZe+ASydnOHw@mail.gmail.com>
X-Gm-Features: ATxdqUEFy2gXWd96q27gnJyPsdd-id3MGNv4KAkhATuBY3V2RrPnsfhvDUz37CE
Message-ID: <CAHirt9jWiycqRF8YUyzAdvaGs94FCVzr_iF+nDrZe+ASydnOHw@mail.gmail.com>
Subject: Re: [PATCH v2] target/loongarch: Restrict instruction execution based
 on CPU features
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Gao Song <gaosong@loongson.cn>, qemu-devel@nongnu.org, qemu@hev.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMBxLse+Wv5nKUqDAA--.65335S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4DJF47Zw47JrWDWF4fCrX_yoW8uF45pw
 1IkF4UCFW8GrWxZ3Zaqw45ZrnrJF4SqF47X3Wft3s3Zan0ywnFvFW0grZ5KFWUX34UXr1j
 va10kasxWayUXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v2
 6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
 IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU=
 =
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On Tue, Apr 15, 2025 at 8:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 15/4/25 14:06, WANG Rui wrote:
> > Previously, some instructions could be executed regardless of CPU mode =
or
> > feature support. This patch enforces proper checks so that instructions=
 are
> > only allowed when the required CPU features are enabled.
> >
> > Signed-off-by: WANG Rui <wangrui@loongson.cn>
> > ---
> >   target/loongarch/cpu.c                        |  4 +--
> >   target/loongarch/cpu.h                        |  2 +-
> >   .../tcg/insn_trans/trans_atomic.c.inc         | 36 +++++++++---------=
-
> >   .../tcg/insn_trans/trans_branch.c.inc         |  4 +--
> >   .../tcg/insn_trans/trans_extra.c.inc          | 20 ++++++-----
> >   .../tcg/insn_trans/trans_privileged.c.inc     |  4 +--
> >   .../tcg/insn_trans/trans_shift.c.inc          |  4 +--
> >   .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++++-----
> >   target/loongarch/translate.h                  |  6 ++++
> >   9 files changed, 53 insertions(+), 43 deletions(-)
>
>
> > diff --git a/target/loongarch/translate.h b/target/loongarch/translate.=
h
> > index 195f53573a..cf6eecd7ab 100644
> > --- a/target/loongarch/translate.h
> > +++ b/target/loongarch/translate.h
> > @@ -14,6 +14,11 @@
> >       static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> >       { return avail_##AVAIL(ctx) && FUNC(ctx, a, __VA_ARGS__); }
> >
> > +#define TRANS2(NAME, AVAIL1, AVAIL2, FUNC, ...) \
> > +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> > +    { return avail_##AVAIL1(ctx) && avail_##AVAIL2(ctx) && \
> > +             FUNC(ctx, a, __VA_ARGS__); }
> > +
>
> What about simply:
>
>    #define TRANS64(NAME, AVAIL, FUNC, ...) \
>        static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
>        { return avail_64(ctx) \
>                 && avail_##AVAIL(ctx) \
>                 && FUNC(ctx, a, __VA_ARGS__); \
>        }
>
> ?

For the current case, I believe TRANS64 is a great option. I
introduced TRANS2 mainly for added flexibility -- it allows combining
any two feature checks. I'm happy to send a v3 if you'd prefer that.

>
> >   #define avail_ALL(C)   true
> >   #define avail_64(C)    (FIELD_EX32((C)->cpucfg1, CPUCFG1, ARCH) =3D=
=3D \
> >                           CPUCFG1_ARCH_LA64)


