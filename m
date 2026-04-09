Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E56EA3C4E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoHb-0002xq-Og; Thu, 09 Apr 2026 08:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wAoHY-0002ws-A5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:14:48 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wAoHW-0001P0-KC
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:14:48 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a0ff30b240so1052688e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775736884; cv=none;
 d=google.com; s=arc-20240605;
 b=AqTW5QtTH7eslWL5F2jgayIfIMDvqKqCcp6C3qnEX+tbMzRXhHlRn1b/Z+rT9JV0ZN
 j36DqzdW/s5fgRci1kg3rpffISNYpeXr194nPi25q3G2Y7CIzYT0+jyXubEPxMjKe0ci
 sPohl9kI7Z1J6tqf4U+0J44e+IfCeVHdkGh0mjP6PmVygPrNtj/pvLNugDKCJeW5D5Yr
 s7K0C7w6ywsbmq0CMFHf1BnkBYEEbXBWffsw1/TXW5n8bxsPq7mfbKxfwpqKyHgCvDvj
 +S8DgHCEDrZYwz1zMLpTFi39+A+bYAPBA2F4NNV8ZLaquW5U7jBusAVeUtkYDoOlglU3
 6Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQ2QLRC2q4nCs8Ix6HIfoqeh1t1V7GUWmwnYj6Hr1rM=;
 fh=Mhn3iCZUwUHrsfmkOmDR9xkZAHbThDVH63k510t4Ymw=;
 b=j4uZvmyH/YoK8VUAsl5gRPj8T/eOBH3OHVhLFVCgwLQePPIE+t3hYzHTpzDapF/qR4
 EMcBmUJLa8bT5kJACvmo14qbO3JKCBV2HT/Ezxg2v+iIAOLdLvKQT8BFbLsFbo+EByuM
 1/3yMCyl97yqzhST8TVNgWVoJ7Wk1Xe8FJ5RJCoCFG8HtXDOPCXv0Re7vt3efgNwDYOD
 mKSG+xee3JA1kxbAjM3FZDkEGFo2QX0Y/bpjBxN5Mnvtx8dfzNEcEjB0p6yFV9mM6WJk
 Q+Iv7hhjLLSHodnEOqTk6hUJCilbDfivdhjxJzsgML/sMD6nIWYE10mLOhylGkwr4dS/
 8/dg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775736884; x=1776341684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQ2QLRC2q4nCs8Ix6HIfoqeh1t1V7GUWmwnYj6Hr1rM=;
 b=dP4yTZtmHfMyAmHXxLtPkSI7F+ViM4CQdV7/bQn0LhWbZs9pkvcZ7opEiK2FJXPQhc
 tr8RHuOjI1SGUQbZUwA0U1k9RF3ytBhvh3lwevZAxbtofIZws2NIXzB7wwGKIrxCqoyL
 Gqg7OiVrt851rc7+sJSxaC/I8BVmtOb7Tzhv5LZGA2DqLaIs3LFQtNwjRBr7Gi90QTpP
 1/tE/SN6Del3MSRndKHY4xsDFoURl0ivu/HrmtsnUEbOh8j9+G6hbZWa3PuTs0GkAu/O
 k7Hwg66trV02kgMx0FQSeZ4bZUCAdGJFlYP2H1yXSKwDWhnA10q0uS8x5Bm53FKKnGAi
 etaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775736884; x=1776341684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GQ2QLRC2q4nCs8Ix6HIfoqeh1t1V7GUWmwnYj6Hr1rM=;
 b=TSe5r0XET59vtyqqLeIBOccvtAuJDd5GxU7jZDG15YdGBJjIx1re9FM3qXqE7+sCCk
 cyceHlEw6964W+/8qfP/QCKb0be2Oo87j0Ft8LMVh6qQCDRS1vLmM9/QSkrTpuAj4PQm
 WAz26PmYlkQHMqaQ5PaprvnfaFNQZmTUdv0rKIbg4lUEslh+5JLRq2DM8hKWW4nWqikz
 KEdOI1I97edfIZX/QjeFdP+z8Ye9yZOP7unITbYqv7Rqw6IEv6qYphIKnMjFZy/dDlYf
 AQdaq2ngw8hQR60LKEvu05r+Sm1A0YEYF/6NJMWAq5FospRcWMs0UtCjR3HSBCdq9IEa
 RlQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtLCr7CxYHVkVNAt5Txp52m5GQwmwy6uy3+vq2xGlWVT1q9rL+pCteF2uZIzVUItexg42jc42YIR99@nongnu.org
X-Gm-Message-State: AOJu0Yz/i6pA25i0aEDY/N8s7N8fe43fICvf7xCsc0eSCM5UAowJ+RfD
 oY4FGDq47VbV2LIk6hVLba+KhLbTaLy86nYzJF5CrKFCsn1UGM/4PxaNuOodWcLNmlyCSg5H+Wb
 vq9QQ4LnvNWPuP8Ix2WXY3ZH6aAGsWRU=
X-Gm-Gg: AeBDievuhLRxTPB1tHKqxHxFssz2GHhp+P+wxWV0iOBSXDaaZoSQWnCt9HTZrMdSQP8
 a0hayUukglSRPPqyUVSXA/J7yxw/bxtzQfuzV24bpL8Z43Srr0vaqSjab3pmb5++sUBP0ojwrF4
 eudJdcxwsyCm+ooACmBiQcqtXZVqcEOQ7Bbx2Zk+LcJwbBLOTmww8H/cRTojGxok90dW1LbfvTP
 AYubbUPc7ddMhUkzPhXwMmaAurQ4UQ9PPisVAyGDh/zKonaTz6VJe4+uZryRzQn7WmgERf7VIBV
 l5cFwwIucHn8wu41CM5GARi5SKHeOTiEZ2FtnsHVlguuljJEUbo=
X-Received: by 2002:a05:6512:3a92:b0:5a2:8571:459e with SMTP id
 2adb3069b0e04-5a337566ef7mr9314082e87.13.1775736883967; Thu, 09 Apr 2026
 05:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
In-Reply-To: <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Date: Thu, 9 Apr 2026 14:14:35 +0200
X-Gm-Features: AQROBzCTnHcgliZbIiCuNrAXGgg5mu1IMi78KMQF-GSSQVVvy9Tfkk2VeHBfegg
Message-ID: <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=gyorgy.tamasi@gmail.com; helo=mail-lf1-x12a.google.com
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

Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>

Additional independent testing (bug + fix cases) is documented here -
see comments by sourav/@kishu279:
https://gitlab.com/qemu-project/qemu/-/work_items/3371

On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> > In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> > TARGET_LOONGARCH64 are defined!) we can not use the struct
> > target_stat64 for data-transfer, since this struct target_stat64 is
> > defined for 32bit environments with its int-sized (4byte) st_*time
> > sec/nsec components.
> > The user side compiler headers of the LoongArch64 env uses long-sized
> > (8byte) st_*time sec/nsec components.
> >
> > (This is similar to the case of 32bit vs. 64bit RISCV: the original
> > code does not use struct target_stat64 in 64bit RISCV env, when both
> > TARGET_RISCV and TARGET_RISCV64 are defined.)
> >
> > This fix is important for LoongArch64 ABI1.0, where stat() is using an
> > fstatat syscall with this struct target_stat64, if its usage is
> > enabled.
> > (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
> > problematic struct target_stat64 is not used, struct statx is correct
> > in the LoongArch64 env.)
> > See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> >
> > Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> > ---
> >   linux-user/syscall_defs.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

