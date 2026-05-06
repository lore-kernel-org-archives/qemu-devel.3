Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D51CD3439
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 23:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKlni-0003o4-1f; Wed, 06 May 2026 19:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKlng-0003nX-QH
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:37:08 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKlnf-0003o8-5j
 for qemu-devel@nongnu.org; Wed, 06 May 2026 19:37:08 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso41591766b.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 16:37:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778110625; cv=none;
 d=google.com; s=arc-20240605;
 b=FgoDXb+5mcHbs0cq9O8f1+4t3gUy0M0LiGefTuHYUWqzjt4gTrFy2ObEc+dZ2dcoPv
 yuBUYFgiIftvrSyaNoppxpVG02iPR64k4zOY64nVhspX19tnRrhoKdCMeXhc3HCZFMQF
 eHg5Z7vIfyGyIDEu4R3eL61TwGXGTekaKzGtzLVMgOatXS/xF8wyGNBehcENltmrXHT3
 RLXLuz9qnDj0mAxo23YPzIh98RBx5KxxHjhxJxwT4koDKX/IsCO7rulqLHwTuGozsVHS
 dLTtSglfVRBjqLF88HYSZsBYgsOpz4n78YvpLBcgzkEfAhbOpsakv2tpSv/Jo3EyHk+B
 +cOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WiyRe0fA8rGsgW9JyMcIjJttm1X0S+p86O0S+j75GUg=;
 fh=JbnVJFVu4wNr1W0MejQRfJxRPrlYRc1HJgZBdYspcCM=;
 b=lHdn1DQ7mrZyUxjZgtstWW+1W3SX9Mw01Noh01FqsU65W2rsZSx6Y2p6kASVJVPqZR
 YA8cFnneDuv/P7JdKtLxTXndXIsLAvYBKlyotRgL8pqk0oS8ZJ0zH7gQuOtDXQDCzZ1Y
 6RRgCK8qtZTqlg8Pv7pOW8XHEygvhV0VqqjJ1Km4Q39zdXmz3KUslce1a8N/DArU0TQj
 MHC+NA4DuyYNnAwSe3xBuqm0mVxVIWPxTEhcdkJk1KF87N1s5w44tJ17N9cUoBHjk2B0
 tfI/c8rZqBwSijqu3dpX3rWEZ4qcreaOkxaHpytHkXxnrLYZ4TeIigrJPt4wuJIFwRmW
 ehKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778110625; x=1778715425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiyRe0fA8rGsgW9JyMcIjJttm1X0S+p86O0S+j75GUg=;
 b=bkYens/rJXSsRZACVDaV7xLpw53gRMg4nIHaNWTtraCi20wkD1cgjs5lMmCydOOX8c
 TORVh4lS8J0z98wG2JHvYQ89j5EcVltHuocSDnOcIxSbFx8ym2a+VScjaA1Ix9k5O4tW
 n94qBpT8zcXvQm8w/wU8JoxvDtjBcd7ObKTOvTHj9r2PF8yK3m4RwT9ZlBpBVEbxNb7T
 QkOkLrMAZbaftkyyOWYsgB62LB6c5O+U8nqTcI6wp4omA3iXxMitmV0Rjy9ZILXL6m3/
 EJ1GojHMXgzoyIEKz9VR+l4GojI+3TUNQ8ZJ+RDzvUtZiq4FbSxONwa3RdoF7/YU8HgJ
 ceHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778110625; x=1778715425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WiyRe0fA8rGsgW9JyMcIjJttm1X0S+p86O0S+j75GUg=;
 b=nYo0l87/Cu5GZcyYH0aFf7CxaahwLGuE6FTZTgWe8BGcAWTPCBgctIt/onUOWuUjBe
 aQ/wzgZIiV5i+MR+TudhWn2aeZpvsndp6z6EGSz6/UnLhChgAHvKffRkN4s3XW15rF/S
 GLvAmGEeTyVt6PzIoUQo7gH9BGQYs7l3EdCvAAy6DoahCSH5VAAwiqDIAOVGE0pzZ8uI
 7IGaG22wbDiokLkNEEMlPvsxQxABWoLPTieBPTggBtpfNHO/+VBZAF9L/VwjrpCjLf6h
 260O3pjnHkDWh3twRyeRUAGiPYwzkMmeXx+YNIv9yZQ7G6ur5S+46EYqs3ib0loKNrPO
 eagQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/698pjMTvnKt6g4fVOFnchB3hUSUJrKWlaGHzksd5idHguoWLBa8TmtYFiHun8blT+gAiJ9IdujgfS@nongnu.org
X-Gm-Message-State: AOJu0Yz9WMO5wY//MqhhxVryAXTLsfzh/sMVy9G2vj9IIfHny4P+79uR
 BOSmQxFSiyFvf1fksStKfKq7xEIanm7xf45Mljq/2Bf9goA9iPWCSLFe6ezKPfTg7ubHRKqbSr4
 Drjj4x/K8fO1WzvBkm5nqHwcXCV5+v+M=
X-Gm-Gg: AeBDieu7TvJEyNehshY7EFm45M7qmcgEvNBuM0mEyWSCeI530nPHQoUVqyykd9+Fd8y
 56VlQ7txC6PSKUBA86xK898ZLCD0gF5Ddvr4tQl2prxnKFYAMFI5W5VKiSvkWJ2In//hiENnrE+
 7oDHK8A950LofqBHYA21XwIYTWBJPxbmiZZ9lTxDoBpkLxoxQVwsyR9UiaF9H+4oJbJ2ZaqWWwn
 UVdepieNNiAva/e7fiDoB0fM7CirFfCZTwaLNUOuaI8qdJC0mEHzZG+plVjv5l7JDnGWJSx0WxS
 MwcGRD1HG9pD8q8k2Xv0Qe0e2OCWzi2HY46uy7HN1yFOBPp7CMBJnjR9mos=
X-Received: by 2002:a17:906:ee84:b0:bc5:114c:956 with SMTP id
 a640c23a62f3a-bc84cc73483mr24017166b.1.1778110624690; Wed, 06 May 2026
 16:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-2-alistair.francis@wdc.com>
 <CAFEAcA886dgJ8Rj9uDDQwJRTxeMjJj4QouVUDYQ=L1Tzjx_vWQ@mail.gmail.com>
In-Reply-To: <CAFEAcA886dgJ8Rj9uDDQwJRTxeMjJj4QouVUDYQ=L1Tzjx_vWQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 May 2026 09:36:37 +1000
X-Gm-Features: AVHnY4JNIsxEHIstPADyyZX7riQnqo5ZfGZk-LgghaXFBqvMONstNA51Y-O8CkI
Message-ID: <CAKmqyKMRoGdLQ6woJqBa5dnWEWp36y3Qzjd0chZ8u2EK7WKH9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Remove spike as default machine
To: Peter Maydell <peter.maydell@linaro.org>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

On Fri, May 1, 2026 at 11:28=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 30 Apr 2026 at 06:23, <alistair23@gmail.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > In QEMU 10.0 we deprecated the default spike machine, let's finally
> > remove spike as the default and require users to specify the machine.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  docs/about/deprecated.rst | 19 -------------------
> >  hw/riscv/spike.c          |  1 -
> >  2 files changed, 20 deletions(-)
>
> Generally when we move something from "deprecated" to
> "dropped" we add an entry to removed-features.rst
> (often more or less the same text that we take out of
> deprecated.rst).

Good idea, I added this diff to this commit

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.=
rst
index 626162022a..e5a8206523 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1186,6 +1186,19 @@ Arm ``highbank`` and ``midway`` machines
(removed in 11.0)
There were no known users left for these machines. If you just want to
boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.

+RISC-V default machine (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''
+
+RISC-V used to define ``spike`` as the default machine if no machine optio=
n
+was given via the command line.  This happend because ``spike`` was the fi=
rst
+RISC-V machine implemented in QEMU and setting it as default was
+convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
+and having ``spike`` as a default is no longer justified.
+
+The default machine option has been removed, forcing users to always set t=
he
+machine they want to use to avoid confusion.  Existing users of the ``spik=
e``
+machine must ensure that they're setting the ``spike`` machine in the
+command line (``-M spike``).

linux-user mode CPUs
--------------------

Alistair

>
> -- PMM

