Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD57C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 13:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujeEG-000785-S9; Wed, 06 Aug 2025 09:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ujeEF-00071y-60
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 09:30:51 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ujeEB-0004m0-7j
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 09:30:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-af949891d3aso618540766b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754487043; x=1755091843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwxUBOZgXfuYuAToVWduQKmIwfK7VwyWPFRBajT7nMo=;
 b=bh17A0YRJHKJAM7LNhhAuThjC/vM7sLUa9ajW5+7rnaznZhfnZsgCJz4IRbiov3x/k
 MoANcSaupfuHR7h1s03yBbgWtapFtUIWvM2F1by1zQRB6MSGgtIQzgu2+lNUhSGlYaFJ
 x+NF/nL5lrzhvCe4vLHowSxlxp9fvcDdpgdjyFyZEzGR32hBmnoZRh5Pz7zfaFjKNu2g
 DynFqoKvSWycKkkIuw9/4d2WSuJS3o2UwQLtDKdrRsWp4ahRHyCX97E18rbDOJqn/bgW
 tTMsKyK7/8zkn3HO2hac7w5eEA+g9DePT9eD/Z7ssXNslQf0Lnh4IiB38ttXKBTPLK1m
 +XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754487043; x=1755091843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwxUBOZgXfuYuAToVWduQKmIwfK7VwyWPFRBajT7nMo=;
 b=FfVljYtxuJBv2fjBkTtUtUz2Rzse8uOGXDYlhkEvt6u2hnXAacorC3z5nji4M78vs+
 HCoESkvYcsBv0ypPHe8Nr+sRKJAPJ/Z5qazxPF73uZqyjPc7VF3mvOCRTcWhWjnLY1l0
 DiC3FYGPaCRd7TLE031dMZreL3SXiv1RjZpbNYoLc4ZpsVj6FvcVKThHAWZCTtIIZvW/
 Jud6xEHiN08nWovfQzh9hIh0r34IvNje996yJQmMkDmXrnwR8Snya1qFHMoxk1NBVn0T
 LPA5AEPzVkDIBSzkknV7raNcgQeSWEjP5vO4kUMWXfSrvydtA5a0uy5EgUa9q+Wa5rkW
 q+Ow==
X-Gm-Message-State: AOJu0Yz2xl8ocSWiUtzgedQI7PPpSUb0mgmnUMjKFxwONVyxi1rHqNUT
 Hvj3eMGf7BFWm8s3V9+/l6XYhYhoBlT7KBhiFiiF7nSbXDDnos9ZR9PBGczC0P74FApbwCuQhig
 BL5b3R+BtiuW16TE9pcw2pGnnUaD9dwrgZ0U7
X-Gm-Gg: ASbGnctVO2wiRdmf7H3n/HWlvz1T7T/2lQn5B/wla+isp8rIamz9F9Wzvwb4Z7eYI8P
 Ily8SWtWIIBbnxJiSVSZFyq6aePpSYqhgzuIYephzTin+4/JDKKLwVqYkEEpHegn+zcL2t3nciF
 2rI5PEl+PX3CqlPpE9uOJdtxBJzGyy9QmajWU/sqt+qv18cO/ABzi5aD83Y7ysYmOtH0mVVXkS4
 hF3bg==
X-Google-Smtp-Source: AGHT+IG2JThTM8fpIzPgY1JY/65HiPxlKpvaEEwOJKxZDaYiekg2IN/AqgS/i39ZHh2p6JgKqd5jFDM+6YCARybCqrU=
X-Received: by 2002:a17:907:6d09:b0:af9:885e:d36c with SMTP id
 a640c23a62f3a-af99048e805mr273420966b.51.1754487043254; Wed, 06 Aug 2025
 06:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAN=g_Ls_H-YfomjYOyEpCTGG998=25FQCA8DEEStPQY-oWUjMw@mail.gmail.com>
In-Reply-To: <CAN=g_Ls_H-YfomjYOyEpCTGG998=25FQCA8DEEStPQY-oWUjMw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Aug 2025 09:30:30 -0400
X-Gm-Features: Ac12FXxCmg7wJna3uRiCIqQnid6CkUJaRzfWTmQT7Xlrvn9IlUA8CbWeTdQWzxM
Message-ID: <CAJSP0QUmhMGLLHh__NPRUamSkcDpeaLy8YjLVemsRHs_oV+uPw@mail.gmail.com>
Subject: Re: Potential license violation on fork of QEMU.
To: BallOfEnergy_ <ballofenergy11@gmail.com>, 
 QEMU Leadership and Conservancy <qemu@sfconservancy.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Aug 2, 2025 at 1:00=E2=80=AFPM BallOfEnergy_ <ballofenergy11@gmail.=
com> wrote:
>
> Hello!
>
> I am emailing about a fork of QEMU called AQEMU (Android QEMU; not to be =
confused with the more common AQEMU fork made by tobimensch). The public Gi=
tHub repository can be found here, and violates several GPLv2 license terms=
.
>
> This project copies files from the original QEMU project without the prop=
er licensing or crediting. The project as a whole may violate sections 1, 2=
.a, and 2.b of the GPLv2 license (as seen in the COPYING file inside the QE=
MU repository).
>
> I'm not sure of the actions that would need to be taken here, however the=
 goal is to bring this to your attention in case something needs to be done=
.

Thank you. I have included the QEMU Leadership Committee and Software
Freedom Conservancy (QEMU is a member project).

At first glance it looks like the copyright situation has been resolved:
https://github.com/AQEMU-dev/AQEMU

The repo includes a script to download the QEMU source code, replace
two source files (they include the copyright headers from the original
QEMU code they are based on), and compile it on the user's device.

Do you have any remaining concerns about license compliance?

Thanks,
Stefan

>
> Thanks,
> Microwave.
>
> Microwave (BallOfEnergy)
> ballofenergy11@gmail.com

