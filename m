Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B8ED42B82
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArOk-0004LG-2i; Tue, 12 Nov 2024 08:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peternewman@google.com>)
 id 1tAo8C-0000ze-5A
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:28:20 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peternewman@google.com>)
 id 1tAo8A-0001ES-Mi
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 05:28:19 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso968538366b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731407296; x=1732012096; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eg3RrlTKyDjzp7z3nB5GMKe0hLLj/sCNp4qRuY388Bw=;
 b=OMT0WfUol0mU1l1HmUCEHuA6MzK11Yd/14oOKVUmT0sNvtmFBWlBwVhIb0hRwPHb0p
 nLAxhc1sXse4ECk675+yCW0L32PbdJijCTb0CZQZ6NBKxcDPXCVqqW10P2iNL4c0jquW
 liSFWSbBBRvN+e2CPOJ+jMICcGMbYkvM2ECn6scTMYn46mmyIhQE1KtTCg0uJHvcu5ZV
 qtqRgVxSIdG1tX+p++8PeWg7gSZNEHbLSIIl7QS9S33G2izmBBdFhYfa3HqmQPVSxAji
 sjBOuhYGsarEmrVtBivxklzMiY1H7TtFszY5ulPqtHDm3Yk1GtfCRfpZ3d13JPp88Obx
 q1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407296; x=1732012096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eg3RrlTKyDjzp7z3nB5GMKe0hLLj/sCNp4qRuY388Bw=;
 b=tS8+mlwxFwUil2/ogdpS1+8yDgDjDJE+N6z+V07gQjgHN6bKCOy/0rp6eP60sv8txO
 MJgLITvId1Osscp3xKH5HSle+GyQWsRox57XyDupxaZWIZYnN/TGVZOuTq8gF6Eaugnn
 h4yx9TiB24ac7UmJqpZgrybx4omoEHgVwGck1jUQCYgHpzpLqA0lu5x4YhzruX4SLvQm
 mqTIVnpI/gytNS3yl8105TrGUOiWtelO69t4pLRqhg6tFCo4/maj4dH1FVgrHuAwigxI
 KvHTPHcINlph+2UmyUYKYnFU2YjUpeBkP3nWK4wTNNl/GjDdbpCOgUC3UUcpC1Qy9mad
 pYXg==
X-Gm-Message-State: AOJu0Yx026JR2F1jdLwcUqfbbi6yLvA6n/VPeS7KwZ8EeSzU0vNrltEE
 DhgMqwuuSl1Eo4/EZ1uB8NslCvVO1RO3givi9wtpf/fX0fv6znYmuteHtodlXC2ubkJM3CKEhmo
 C/yaP2wPNIvFZzT39YG29MJQ1f2R1d/R8UN+C
X-Google-Smtp-Source: AGHT+IEAEaBuXYpA6xr+MYKjUhxeZfl0cut4cVQcf6wT9HUpvpVutgsyxGlTKuf6xw50oUTRxyvYxbkEkNAIw9qJjh8=
X-Received: by 2002:a17:907:7e8e:b0:a99:37f5:de59 with SMTP id
 a640c23a62f3a-a9ef001919bmr1544916366b.53.1731407296101; Tue, 12 Nov 2024
 02:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
 <20240905112237.3586972-6-whendrik@google.com>
In-Reply-To: <20240905112237.3586972-6-whendrik@google.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 12 Nov 2024 11:28:05 +0100
Message-ID: <CALPaoCjtrn=EcuYxqH7rT5tn5u_EPJeQMx1gq1+5gdVuUvAJhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] i386: Add CPUID enumeration for RDT
To: Hendrik Wuethrich <whendrik@google.com>
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peternewman@google.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 08:57:34 -0500
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

Hi Hendrik,

On Thu, Sep 5, 2024 at 1:22=E2=80=AFPM Hendrik Wuethrich <whendrik@google.c=
om> wrote:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2..a5c4e3c463 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -42,6 +42,7 @@
>  #include "hw/boards.h"
>  #include "hw/i386/sgx-epc.h"
>  #endif
> +#include "hw/i386/rdt.h"
>
>  #include "disas/capstone.h"
>  #include "cpu-internal.h"
> @@ -6629,6 +6630,68 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
>          assert(!(*eax & ~0x1f));
>          *ebx &=3D 0xffff; /* The count doesn't need to be reliable. */
>          break;
> +#ifndef CONFIG_USER_ONLY
> +    case 0xF:
> +        /* Shared Resource Monitoring Enumeration Leaf */
> +        *eax =3D 0;
> +        *ebx =3D 0;
> +        *ecx =3D 0;
> +        *edx =3D 0;
> +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM))
> +            break;
> +        assert(cpu->rdt);

If I just add the command line from the cover-letter: "-cpu
Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba", this assertion fires. I
needed to add "-device rdt" to the command-line as well.

Would it be friendlier to warn the user that there's no rdt device and brea=
k?

Thanks!
-Peter

