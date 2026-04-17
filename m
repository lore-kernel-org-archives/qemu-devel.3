Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615F5F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDaV8-0003CE-PH; Fri, 17 Apr 2026 00:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDaV3-0003Bq-5m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:08:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDaV0-0003WR-Ig
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:08:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-671fe205535so407301a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776398889; cv=none;
 d=google.com; s=arc-20240605;
 b=kTW2RexggK+SpvD+iv7eBh3ahcq7Zy/RzlTFn+GRtS79uy0RtBqOwmz43CbrVo7BHE
 8MX4mv5TQbqL8F/tFYc9UnZcQsOksOtFI0gHi2XGzOkaguxYLE4jvgus0xTIgGCvclhW
 olp6LQnDjU7M6od99n2cJdG84BBawMKt+KDdEM41bNlHeBdz1r0qCU06yIad2Bb71MtG
 /+2RzHnktACR2gS8jFVvoCq42azjjaakv4A37Au7gad3FbXspydq1SC5IwvsYQQDVaHO
 apZsWbqzUMwquHQWaq3fZLxuHC5YtiEeNn56sC2hLef9Awzdtkp8BsQko1lpBrYrOBpx
 6QVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mOZb0pg+dxIpSiuDutsc+d9wNhY1ccwLlGJCdyc1RXc=;
 fh=f/M3ENS//nJgq1FqmUjWGXlFlYacAou6cKFIhuV6wHc=;
 b=gYmzbKeASMDizi/EqNQq30VNVpfbJ82muw5EtG+jHz2a2MMIzuBm9C9J7Mr8rw5iPb
 MIEsT3zqq63UGJbg0ba8HVOkV9JG/P8J6lSisp6aP4ZXakaet61wKJzOxgOL/OCfEJAk
 s1NFdqzBdpLTqVwJOuUnA+/BLR8jsDzilJ14liPMth/yKKwB5k473Qxb27JZ32Z5nkiM
 pb0ixTgD0U2MDx4o+zLDXkcYPh6PEZM58nQ3DqbIcSA6eD4wQTvZVkfjlYYEDEKyIhX2
 1UvBGctiAYG8viggke1qFLlcguVywjWkJDrOKd/C8uCOSOctJe5ZqmfqCI+uRjkcM7Aj
 plUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776398889; x=1777003689; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOZb0pg+dxIpSiuDutsc+d9wNhY1ccwLlGJCdyc1RXc=;
 b=GeaPe+30E7XOshfpKDI+HmaHSmkfdURZd5CYCGrxIl8wD4Dmtrybo3jZiwIa0lV0Sm
 DORavbA8xN4UcW7yVpQLiG1WkrlCm69/APkPoXYsuVaw2Tj6SruhELfcI4wUjHKNoDEV
 D2yWzoMSOYcVtgBu7SwXJwrOo2eCGZpxzak1mH9FxfXO6+zZ9nDZCyJ88F9S2xZy7CQ3
 aH0h+uHnilBieQbR4/+njFhFwfZykEZEkbJTDpkq3h/A6ah2R+/NJCNueYj0uQDkQ/TN
 2CJ1XBNpbgNcHVM1uKR4HsAT9wDkFkBw9y7qO3Y6CijfQLFIuZzrpSm/zN1ajnhLi0pC
 lN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398889; x=1777003689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mOZb0pg+dxIpSiuDutsc+d9wNhY1ccwLlGJCdyc1RXc=;
 b=dPawxbvpm/rCZA+n6A0vzsI8qEu5yhZNkloXgHVRecV4wEiXWF5bXGtdt89ULJ7Xs8
 Hh0qWjPg1RbjjvC4ZpjhL7kWmCeLOwqZrPS0ovusz65o4gN+v6lV93QKQfSC206ahquh
 G4YMNso09NKNU9f0ewlBe90e4QuCngORFP+mZtUVDhkegWfXJZAHi+hY2o0828MtGIRp
 9UvPd/cM/eihxH0ppaLZ82yJAR4EdDmIrmN/eNFjh+ln8CyVcwsV9TsdJiSDoSnzsqGe
 futO04vWlnYZAKGNJB8uMfSZY/9ZvqOhrWne+cDU6xHUtSdEzpiNxHb6SgTdxdIAKgoG
 8/BQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R82tzRpO+ClG7yWCM+C7VzkjJ8ffcKdGsRD/pqmlb4pMQgHfpHiawrRP0sYErgQ6LoJjjhGgGaCU9@nongnu.org
X-Gm-Message-State: AOJu0YzBg5i6kX2lTgaRN4Cj3GYijI4r72qOxjQXyKDoMolAG3BmoGAu
 SzBNjmYizTwZp1utP7IwAiMC06WGoKwiNJixNgoene7UrW5WR2VvM1b4DQhJ8XN7SXX+dXkMxUu
 /H7EC9UKj1s0Ge/CR6hh5iIl5g16hm2k=
X-Gm-Gg: AeBDieuqO6Q/OExnGO7CIUtwT2o/j0F7PFjffILXx+YelG3Ps3+PQDsh/8PdJtTpubo
 IJnqohZRTE5UOvX8tN0ocUx5VsqnTn22hKQvWXvaHmNRnajpLPrJoETCetJn0zEc60SrJT2DLzR
 n6fKIKx69moyQ+tUcacuCk0EJJkgfUGhEWKJQvLI5D/L91trRNCVab2n/v32mxyS8OW95f4UMFD
 6qqWILiMZIU9ABrpMFH+EmfcrZmUOJnnZz4FgXlSpt17HdR9FkCAjbWhw7Xdzf/3oJZsBBYrKSm
 pHqr2ZDByKIPHv92GCjzJ1LhwybYcdr0VxVQVoYxc77NGl2U
X-Received: by 2002:a17:906:6a19:b0:b97:6147:def1 with SMTP id
 a640c23a62f3a-ba41a53df70mr52500266b.33.1776398888662; Thu, 16 Apr 2026
 21:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
 <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
 <8112ea21-10ca-4784-b530-2143218dbb05@canonical.com>
In-Reply-To: <8112ea21-10ca-4784-b530-2143218dbb05@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 14:07:42 +1000
X-Gm-Features: AQROBzAm4PPvBG7n79EzlO4CuZsevRxIcunRU2T_YqfI-ou0wDPW5x7-qHGsz2s
Message-ID: <CAKmqyKMje+WpOy-ydpZGNrCUtEt6X3S4dCS6M2x+6uKD82iM3w@mail.gmail.com>
Subject: Re: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Fri, Apr 17, 2026 at 6:05=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/16/26 04:35, Alistair Francis wrote:
> > On Sun, Apr 12, 2026 at 11:25=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmai=
l.com> wrote:
> >>
> >> Update the expected SPCR binary to match the corrected field
> >> sequence after the Terminal Type and Language fields were swapped
> >> back to their proper order.
> >>
> >> This fixes the qtest-riscv64/bios-tables-test CI failure:
> >>    https://gitlab.com/TaoTang/qemu/-/jobs/13879552268
> >>
> >> Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
> >> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> >> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> >
> > Thanks for the fix!
> >
> > Do you guys (Heinrich and Chao) mind if I squash this with "hw/acpi:
> > correct field sequence in SPCR table"? They are both in my tree and if
> > I can squash them then it keeps the tree bisectable
> >
> > Alistair
>
> Sounds reasonable to me.

Urgh, squashing them causes a checkpatch failure

```
ERROR: Do not add expected files together with tests, follow
instructions in tests/qtest/bios-tables-test.c. Files

 tests/data/acpi/riscv64/virt/SPCR

and

 hw/acpi/aml-build.c

found in the same patch

total: 1 errors, 0 warnings, 12 lines checked
```

I'm going to drop this patch and the original patch, Heinrich can you
re-send a new version with no build, check or checkpatch failures?

I think UEFI usually disables the test, adds the feature/fix and then
re-enables the test

Alistair

