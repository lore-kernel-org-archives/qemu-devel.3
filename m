Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B79C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuo9x-0002Wh-Ia; Fri, 14 Aug 2026 05:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuo9w-0002WS-GM
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:25:04 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuo9u-0002yo-U9
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 05:25:04 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81ee6b2da98so10588637b3.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 02:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786699501; cv=none;
 d=google.com; s=arc-20260327;
 b=sIpb+6GptyNB5m78400sn4DBVMzhDh1vxxlHG6ufXX6XzfAB6laKGV6rklDEl5amco
 iWgqYMMV5VEB1UhYUdve+bJ/QzhdcVN3yN9w5g8dVYRUCVt7csWJ0Xv722f+sfc9RJnc
 Jy/5+eXpAliw8HExMWe2Rc3gVAKfOjIIakV7FsuHssAkorydhHjApyDe89W8OZnXSrco
 ivuuRwBufV+lWBVYtQfGbux+H6YKK67UOBbY2VD4kgrvqRJXnoN92mQiFuDuKmQacqXq
 sp04JVjFoarhfKiAhJgNYynpEpLwrV3UTzGgviSKTmlqIih/K3c81q34g2tBQItESYVl
 z43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D6HXSRZ4cCxR5YTkKMmN9nEy6ALkYJE+zO23hmTEEM4=;
 fh=DLsCS/inX+RkvRQxwYBFfNhxsDndjb9n6uWalY9lDOY=;
 b=Kp7QStxbGUOquiD+686mkUO5LlYPWJTpzVWA9xFbtF5q8/qtRhG4IZcRP2+OP5c5+O
 YdbAZBzKhUbqP7gArxxbt/Y4xYraknJch30pltP5Pkz3OXGtURwL99+jCoQQB67AorgD
 gf6HPmAAMbHAUBSMJWzz6j1rF2n1nJqSwy1+V0GU7D97erNAH82n12ycQi7TGazz/05J
 pqPXsVhsHVmbprgysw1TKJUi6Hc/w5Yv2LJeZJYZVyG8Qc3AqY9rJVwsY3Ye8AI66Pwh
 3XJ57rRMFHafS+Sa/symdho2agFrx6MfACSZKTnUrqH8FwOm4HhOed+yo92Cqw2YoHe/
 6SnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786699501; x=1787304301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D6HXSRZ4cCxR5YTkKMmN9nEy6ALkYJE+zO23hmTEEM4=;
 b=KJqaC5bp9qD0PBEsq+1H5GBJa7JfuEli196MPGrBxwoZ2oGk7CZqApXgaH3umr3QM5
 eQBqIEd31TlcThb4tknaYyoIX2I8BQq1LZ5IfzX6b9daPobdzvA23fFarNrWRyxdijrj
 2ftab8Axs84sBTcIR49dPC/lMlcRpUBDC6LLDNCVP16EoIJhCitu0sGHiIms4BgK9Cub
 Lp710PpUFHmUvLkTeukrQ0lMc6NGUS6HzfyYfElA+8EzzGg1Si/2ESJ0amFDAt05Vvwl
 c4/MWWyem6GgssggY9gfDlGVnHCMPnnfHvFxXvDq8L44cFmsn6SMpCXQbM70XGFGQqUl
 fVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786699501; x=1787304301;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D6HXSRZ4cCxR5YTkKMmN9nEy6ALkYJE+zO23hmTEEM4=;
 b=W5b7Ce5UxiDMmqXNH4EUTKHU76rPeVC+AKaoQwpS/5cumAZ2bJLWPPp/oIJ5DoExuw
 rRO3MoI176HRRTj/IoXfzBfKuEpZnstMiJbf2VSSNT0lfHhD5EXCouDFxCvsyb58KAf8
 NGr6tw1Y0fYXcL6KQ/bBIrMdx4z5cixM6gh300YIDFUw76QfMtyRuGa0nC/WkwvAeOWu
 Wa0Dpn2ZGJ3hDjMvK/5tEf9PMzJNDJ7WDxQh6vv5WXLGyzg0SWGsDTDyLSRpjQYNUbSg
 bP/PdT4iQ0JzL/yA9m9t9IHJVYIGm1jT6ohV0rkYKYyfLnpcXYKFu9ZOgORmZrIgwFZ6
 5VKg==
X-Gm-Message-State: AOJu0Yw+BQHD2nRquH88HqIbQXKp6KYNE8b6J0YEKV7ccEOnw5JvtKRE
 0zO4zpZux+iIK90zJS1oXDIr856+HjtpltdnXFh052gVGsbumi6SY24mJ8/I8Jk3qK1YYHGJPWr
 L2zi+AFDybjtDU5pFY+YcjyWWl4Nb/mw=
X-Gm-Gg: AR+sD108TmRFP+K6nnlQHoQDK8CYu45TjhUnGO9kiPI/hOvL4frBIorJ4IuORrF9fVm
 ZS1GwQKlnw4tdOivd2Zu+ooWGjhf2WA3+yLB5LAI9bv8p8v4TM6F/DI4xLZhP/2J+fO5SBAUtsB
 t3qpbnuQvrgKPa/VsApXWnm1Sgv0/bZ0q+4yWIyFyHzuVJe90W8u5zPFHFQRd2d2xCO561P4mIu
 5U+h14/sLk32rC/Xg5TxWyIHQx0bABwbyppCbxSbFr32ykI4pXCbwpauiVBTdBfGTA/8DnEMT5f
 0Zy9WzqxK76j730sRn2R6YL8im0K3gl5ogIf8dvqB1Au
X-Received: by 2002:a05:690c:60c7:b0:80f:8faa:b8e0 with SMTP id
 00721157ae682-8370ddc82e6mr17751877b3.8.1786699501477; Fri, 14 Aug 2026
 02:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260808182956.290561-1-flamboyant.h.01@gmail.com>
 <CAAW0U4azckLqyWEy=bGRH3Js8AOeW=rpN2+rgkhVStzC0Jv5mA@mail.gmail.com>
In-Reply-To: <CAAW0U4azckLqyWEy=bGRH3Js8AOeW=rpN2+rgkhVStzC0Jv5mA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 17:24:50 +0800
X-Gm-Features: AUfX_mxP6UtELlxPE0AMyKHJxX5uJNxkOBR6ppA5gtvNjeXBGvIcYXjsGQ6Q-TU
Message-ID: <CAEUhbmU1LYzeQU39eOhd-S+WY6w7A--MOtmcG+cbTgeyCEMr9A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] hw/riscv: Add K230 DWC SSI Standard PIO support
To: Kangjie Huang <flamboyant.h.01@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Kangjie,

On Fri, Aug 14, 2026 at 1:02=E2=80=AFPM Kangjie Huang <flamboyant.h.01@gmai=
l.com> wrote:
>
> Kangjie Huang <flamboyant.h.01@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=889=E6=97=A5=E5=91=A8=E6=97=A5 02:30=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Testing:
> >
> > * Built qemu-system-riscv64 and the K230 DWC SSI qtest target.
> > * Ran all 14 K230 DWC SSI qtests, including Standard PIO modes, registe=
r
> >   contracts, interrupts and PLIC routing, and Standard SPI NOR reads.
> > * Standard 1-1-1 transfers were also exercised manually through the K23=
0
> >   SDK U-Boot and Linux SPI paths against the attached flash.
> > * git diff --check passed.
> > * checkpatch.pl reported no code errors; its MAINTAINERS coverage warni=
ngs
> >   are expected because this series does not modify MAINTAINERS.
> >
> > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > Suggested-by: Chao Liu <chao.liu@processmission.com>
> > Suggested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> Hi Bin, Chao, and Anirudh,
>
>   Just to clarify, I added the Suggested-by tags in this patch based on t=
he
>  concrete suggestions during the v1v2 review. None of the tags was explic=
itly
>  provided by you. Sorry for any confusion this may have caused.
>
>   Thanks again for your suggestions. Looking forward to your reviews!
>

For review comments raised during a normal process to the *existing*
patches, the Suggested-by is usually not needed.

This tag is mainly used for *new* patches inspired from the review
process / discussion thread.

Regards,
Bin

