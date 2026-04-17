Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FCF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxr-0003qA-Ld; Fri, 17 Apr 2026 05:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDfxk-0003YJ-26
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:58:14 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDfxg-0003MI-IF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:58:10 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c6680aaf8so90904366b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776419887; cv=none;
 d=google.com; s=arc-20240605;
 b=U0ATBmHHvlx59NoJ9YYaWEW0UrlK7aRhTCDPo9WwaRy/LG7HEqb5dINN3JeBJnS03Q
 ibD5ODg9FlAaLD0yoUZDFq5OR2DbN0bHRtAS1GynVQAaWhi+o1eDI3Qmxjc+/Vq6JEwN
 ngQS8diEQlURc+K1zpUETAQ5xkXMnsvAQ8aCmsTpIRu5afgX78kb1FouaCPZkDVItv1o
 aEUxx9Gji9G2ipyeOWSbuW+NC+RwVnUJ9nrgJqP4c2VW/efs4D7bneWM7/Lp/orF3slD
 0pWkrDWoX6SM6ZpSp311Uev24KdRduGP0cQkW+4jYV9rcW/9k82Vj9fgVsumgECwtFYC
 pdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wg1KuTtaSvZV1naO23Ae8NZFw9i6uBmBWD+NLek5x6o=;
 fh=0rFLonDjf1x7nu1Z4Bhj5EugRREEa3hVinoztSRbPqA=;
 b=hUwa+9/shWwldHqHC8ZWLc7RSlwIJQ6g3qu1pWlYJGkSBlYR792or2xuW5ZbBbPP88
 dlxhh3lsz3TkGtU8Afe+ylcScQLoQFQKgcebJ7pXeIKb7evtRK6/Z10sp8BK7pW4JDf4
 YzvjqyOJiKIh/47BvaWmISv7Kixj0WjHko0nqT0pjk7n4HgQlp+mYWrdclL3GjvAfJjb
 PwbHg8JeREj5ubGLwnQC73PyH0qiWDwxLvsAkIXRl8apdCkbS9E3yJXAuEuxT04OIqrk
 mpg1dDHQnV0bMmBbS28jQmYf+7f2n/rb2/MmQER4UMHXyam4XHc2mlR1AsQfCQc0XnFH
 KNZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776419887; x=1777024687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wg1KuTtaSvZV1naO23Ae8NZFw9i6uBmBWD+NLek5x6o=;
 b=mWfZzXftv48iM2uVdGRwCdVAm7AYujc5gS7UT/eQiPcdxhLc6kcCjtrUsENBVUZABF
 DIaD6wjMfigeFs95hnU/ZOaBqNUMywdSY2wwhB0T8CpYpNGqCT4XLTqSBWiJ6fs3XaYl
 ISK0F9azcwSWHJnugPpPweenMsAfuCv/PY2tL0wa7NliZ5zl3HC/WnnAfXxP/I2qR3Dp
 ckKodE21giuJndLth30nN8IYxZprb3ZmClsRIojCDQJNAlsHOEPklGu733gu9DLNgYLP
 4sNT4mvQUN3heRugpXMizQ+Tq3Vq1POVkwwL0/5YsPNd5hmWm2VqJ3wsrF9c2AniirBB
 VR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776419887; x=1777024687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wg1KuTtaSvZV1naO23Ae8NZFw9i6uBmBWD+NLek5x6o=;
 b=ExoRD7Bu/ADrTLn/paGuRSGW5Jr0HiT8xJKIj7m+KlJFnzrmBN3Ftl7EJDOChCF5BX
 0KgyQF1xZAJvIc09OQMmbYI3Tn6i/Lt94lvFb3xqC58wSl865v9lFZwf3bt1YRXuA5C3
 yugq90EY61V1J4H6z5hYJnh5/86X6NX+fklCWmRlUJFuMGit3VKSn7aLnAiWBQlPfddM
 FuuGKEwHz+6XoIEb+/eYMnp2bN15nqgtfO4WW8wFfjFowe5EXjuFpR9QCevcRY1x53qC
 X8ZsAOgVOjGWgslBTrDG1VGT7LA60PPw8aHV2Do6xSy8myzfUncz48NMtoUXJzmP91KZ
 jn5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Fdrd51mA4sKpJhYqpZTuqbBGRkfYxzQYkEnPO1EjLUtDKPzO2ASLSLtvCEYRpKxy4dAWHfQ5hY237@nongnu.org
X-Gm-Message-State: AOJu0YxkKWKel0h+Jml3QTpY2qR1sc/0Z5wVLcyPUMuB68uBJvE0k0f7
 0ujFCpx7AzUv3CijzTwFJYI5KyeSDiNWH8vqW4MA+sBtNY1TG/uP7j6JlchrIr9OPIatVHrvf6p
 jjondmowwL+nCbAcdMtsEVxOPLRPHqdXnUQ==
X-Gm-Gg: AeBDies7F9PFwCJiShPIPPEfi8UcdlqehLr387ekcq1HLLJZp46/vaLZSGgEOHNGDk0
 LP9/Jx6CwVuQST67TY/EXhBNiJBqNeS+AQis0ukp3SR9ZxRm6SuleKcOMhkrWk4Ao8oh+1p4nSS
 KNAvbjSWwIdIgMvKmCcSUlJGl7Pd0OMvtI3NYAESSuikHwV9kRati0z+DsB/DkgkIaQIAaOoUAy
 2MPQWx2rh+LtfXv8GK4G0LBnT+vfk87ymcuetMw1ZMM56GYwSILzbc1zpYfL4J/9Pw58GPTJ0yr
 UH5Vs62BCkROJHgjKxx7T/Y9v05htojhWLa5uaEAgu/XU9P8
X-Received: by 2002:a17:906:5190:20b0:b9d:166f:ff82 with SMTP id
 a640c23a62f3a-ba41916f331mr85808666b.6.1776419886429; Fri, 17 Apr 2026
 02:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
 <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
 <02e21af2-d6e8-4418-9cab-af56c81afc27@phytium.com.cn>
 <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
In-Reply-To: <a75dcca3-9cab-49e3-818c-4d52c2a1bdd6@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2026 19:57:39 +1000
X-Gm-Features: AQROBzBmq9jOVoiN6-9iv8EFNigagNc7sokbtWB4zybCx-m29HZmI5pzSDiNOfo
Message-ID: <CAKmqyKMf+RhUb_jzOfTVCiQV7EW25e5z3C1fjdarcWVS3V3-7g@mail.gmail.com>
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Fri, Apr 17, 2026 at 6:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 16/4/26 18:07, Tao Tang wrote:
> >
> > On 2026/4/16 19:28, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 16/4/26 11:16, Peter Maydell wrote:
> >>> Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
> >>> respond to a query about whether they still wished to be listed in
> >>> our MAINTAINERS file.  Remove them, on the assumption that they are
> >>> no longer active in QEMU.
> >>>
> >>> This makes "PCIE DOE" orphan.
> >>
> >> Cc'ing Tao & Gustavo who are working on Security Protocol and Data Mod=
el
> >> (SPDM) which IIUC use DOE.
> >
> >
> > Thanks Philippe. DOE is indeed relevant to SPDM and RME-DA work we have
> > been looking at.
>
> Commit 4f947b10d52 ("hw/nvme: Add SPDM over DOE support"), described as:
>
>      Setup Data Object Exchange (DOE) as an extended capability for
>      the NVME controller and connect SPDM to it (CMA) to it.
>
> introduced the docs/specs/spdm.rst file which isn't maintained:

Urgh, I can fix that.

>
> $ ./scripts/get_maintainer.pl -f docs/specs/spdm.rst
> get_maintainer.pl: No maintainers found, printing recent contributors.
> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>
> Would it make sense to move hw/pci/pcie_doe.* to the SPDM section
> instead of orphanize them?

Yeah, I think it would make sense under the SPDM section. DOE can be
used for other things, but right now SPDM seems to be the major use
case.

Would you like me to send it Peter? I can apply it after this seris if you =
want

Alistair

>
>    SPDM
>    M: Alistair Francis <alistair.francis@wdc.com>
>    S: Maintained
>    F: backends/spdm-socket.c
>    F: include/system/spdm-socket.h
>
> Added in Cc contributors who might be interested in being listed
> as co-maintainer or reviewer ;)
>
> >
> > I will help review changes in this area as they come up.
> >
> >
> > Best regards,
> >
> > Tao
> >
> >
> >>
> >>>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>>   MAINTAINERS | 3 +--
> >>>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 0b2adbc247..bc7c9b61da 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
> >>>   F: docs/system/sriov.rst
> >>>     PCIE DOE
> >>> -M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> >>> -S: Supported
> >>> +S: Orphan
> >>>   F: include/hw/pci/pcie_doe.h
> >>>   F: hw/pci/pcie_doe.c
> >
>
>

