Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0359C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 16:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhVzb-00053z-EX; Thu, 31 Jul 2025 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhUgk-0005Dr-Ry
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:55:24 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhUgj-0005S5-2q
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:55:22 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e8e2a260926so991013276.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753973719; x=1754578519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxItBQpn09h908+2a6FGV3m8QXYlJKJZ2Ok7R+lMOuM=;
 b=Z+ofYxEGQrCM46cyE6yL9q5Du90f/oExANLUV/9/1uTw7F1PS949Q/fnKmoJ0pj96H
 a4LBnCCQvF8fsyOTQLRaRcxal7nfdYXga49qH3kvLQHd1xkfxi3YGTxwEkV7RLLyiv98
 NHViKwDfk6vYxNFQCRFoD9Qi59bZSdF245ObnfGHe/8U1Od5tiJXeqWgGix1DmacXVEE
 WTiN0s19/4VqWFoQXTHKdzZTR8uDV7UvH0MRo/h0v+AnffPTkmwONz/aFJsG7WFCLvsn
 G8FmaXwgRQV5AtrobxHsEyX2RgKuyFrUJRPXMqqrMYVXzUCmmeNhpXq5XfAnq39fTImh
 /AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753973719; x=1754578519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxItBQpn09h908+2a6FGV3m8QXYlJKJZ2Ok7R+lMOuM=;
 b=IqPLe7jqqJIhUFCEDW/8eenay6canENfMTBAQY/oHv/Xt1yTDam8R1yDxLZkdZ/Yb5
 p2gEHOAaUm4TliAqod1gu/vVNzXN2HdJkLyXG88djuiZ9gYK5rrqNO2pYStwcSpk7ELo
 yuv+rIxg74rq7oOffNOVvcZ6mMtnib1G+4eQiraxlsRR7UkgmVH254BEcpfJ0Requnr+
 +x42KWV+n0Ex2EJivwhLdm++QyFg538uow/nmFk4rGLK1Uhg260soEA4AtNpH82d3Qaj
 tO5R63fjRdSr1XhzRQQ0oZmpOWf+gKik4arW6C72L2wyhkOwuBkSsrn7RfN84T3ex6W4
 8sbQ==
X-Gm-Message-State: AOJu0YwgyYfTuBh08gL5QWTrpTSP2BMKreiGp2w59df/di/9GE/swgci
 GViKsQWVEIosQw/t//JGMNyZYv5YzjaaY9gaFioGCNLiShdOfxLROPaPZWqwbIeMBethAGTZE2Z
 e6AL8ZcQaKVSmQv0bBJ4rnetGmqFNW1UKpP7JfFBi9A==
X-Gm-Gg: ASbGncsnZXZmJcjsJrSR3BryxDBk86NKNTJsssF1sMRDCU/q5UPMDi2+gTxBX51Oki7
 AmD1CDG7JC420XVbxRW7N68nApTV/+Yx1irsDrBxkcuOFpQx2Br2Y4nFMSxcbrE3DcIt0vzU8wD
 Q/7J6AiSodCtyEhbzSLEUEon/H45ILa7UZY3aiDUdF7D9HRJO/DMyvWE0F7JXQRBoSr9Gf7y/XW
 6nSM5xbhL7Sb7Vxzp4=
X-Google-Smtp-Source: AGHT+IGDVq9cQb3gd+8vnD9TEFiCkB9s55WG6nNIAcMvJruDNKqpz6nrLYdzRU3Q0xo1KKi5xrQ4Wj1yy/vajb0T1t4=
X-Received: by 2002:a05:6902:6b16:b0:e8e:29bf:df08 with SMTP id
 3f1490d57ef6-e8e315c9869mr9306737276.44.1753973719467; Thu, 31 Jul 2025
 07:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250731144019.1403591-1-clg@redhat.com>
In-Reply-To: <20250731144019.1403591-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 15:55:06 +0100
X-Gm-Features: Ac12FXyvCstHCOGFnTX2PbmT7NFr1P4qSpqUNY2t43DfN2SPkGoTu78XcQZbMhg
Message-ID: <CAFEAcA-FZq4RJrDfDiSqC5-L3720cYALamJGU5fQXQnV9J_-Rw@mail.gmail.com>
Subject: Re: [PATCH for-10.2] hw/arm/virt: Include 'system/system.h'
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 31 Jul 2025 at 15:40, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> hw/arm/virt.c should include 'system/system.h' for :
>
>   serial_hd()
>   qemu_add_machine_init_done_notifier()
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ef6be3660f5fb38da84235c32dc2d13a5c61889c..e1b6241f7bee4c2fddde31c51=
2561e87229cebc2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -50,6 +50,7 @@
>  #include "system/kvm.h"
>  #include "system/hvf.h"
>  #include "system/qtest.h"
> +#include "system/system.h"
>  #include "hw/loader.h"
>  #include "qapi/error.h"
>  #include "qemu/bitops.h"

Presumably we're currently pulling in this header
indirectly via some other header (the vfio ones)?
Might be helpful to say which.

If this is a dependency for your vfio-platform removal
patches, feel free to include it in there.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

