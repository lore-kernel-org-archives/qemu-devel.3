Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89047C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdWJ-0006TU-Rg; Fri, 03 Jul 2026 09:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdVw-0006I4-CQ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:01:10 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdVq-00060a-Ko
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:01:01 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-664ee752958so771895d50.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783083656; cv=none;
 d=google.com; s=arc-20260327;
 b=Qz8RHrrA/gJsGrg/P6URWTv4g3t6Pk9PoG9FamjvwlzRDz4NqgGsX4frULkmcOgZSd
 mzrztReFcquMzGoqa8D34JxJH8AZK9zez120NBqNrAKIuhY1n4wb5DnCnKMSZ5OCYuN9
 CChayibblDOMZW4eXFiNn44Mp3WoLno3edjbPssrO1Bv2Ku6DzGSSDuL574iP1A4qbMr
 4rc4LdMC6fz/3mDeysgJ/cyCyNWIdxXah/Ko8huFSIVP68+rzGgn/20viOq0Se4Wjf8C
 pwKzD4LU2UeKCGsWmxm3wFCqEJpdyhAaW/dx0j9ERKNv3H7VTtSU4eQOVRJyFxYHC48K
 DfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UckMtLVF6KhaXmpXJv5ywf6Zb6vXY25s7Sc1MAYSPQk=;
 fh=ob3YloXYN33yWGQYE26wZFeQH2KGVIg4AV3YMg6OfNg=;
 b=C9KF7Da9nVwTT+8GcUUGsVXeQDKlKhf60XN5VMBF5SdglAkrigDe8/wZFnh/ffD3GU
 E9CeDBO/qkwuYTovzTIO1zNlnxg32cERVzAHfoCoMg9u9Dxse5q4TyK+vqydY+Wy3o+b
 qWuaPtqW1TSxhlGZ7BKEPLHO329u9Rmw43YndybLRgaM5TOfVhlRaqY+/EM/JfoNDx1v
 iXe5pcfVUMOZHBuXzOsyfcFI/tJSP3S3cJ+aiK2Gl7HPh61qvspQ9zTbrBlmhVpiaDj3
 jQtXJLWe9UOVGmyLVgTSNhMQbFm9wkcpnjPsFCjq83oDN0RyV3vEVRKLeDFWj7oBOgyL
 Nm9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783083656; x=1783688456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UckMtLVF6KhaXmpXJv5ywf6Zb6vXY25s7Sc1MAYSPQk=;
 b=u91y83MFniygD8brX5sibrgm+HESuActVv48fscF4JWR68SXSiZJEXKut4Luf/BEt4
 /y4i2Vq/PjrEuBV9ExQxBTuwNkUR1bp23eXbcw20c1GB5WOHDWSZED5s9/u7ESWWfIzl
 +2+4zkrqKTk2Zber4x81SAx+YEFC/BU05zjafz5LI5V+ccHTB45AmnPvdZDXlsi7kN+m
 Ca0gVrbSrNapB1gBPgwi7JNjIOI8USNbHj93XawLZjHug/XTo9HbvW2if599iwJRuTFO
 bfOsGwLNMi81tLSoI53ne05wmOIUlzlYvhroDTZ0uFks+nDNoUaFYuFk+q8o2T8stPoI
 7qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083656; x=1783688456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UckMtLVF6KhaXmpXJv5ywf6Zb6vXY25s7Sc1MAYSPQk=;
 b=AzqAE4BLjJBE2oOrk6gvGejm0T6dVNyxY0gd7YNnHYzWBZu+eXCKcXk7JNaEuFIpfm
 rfl9D16heG/kibrgYcOE7fUI/pzFIlS0xzyNUPjTgc/6Fi3ggnGKbnSByyL+MZ3S0X6j
 jd/vYBIIEf/bRTKv0pa4SSNN3otEGlX0FTtE1VKkam+ao6nf3IRLm1k8CzIT/dfV4SGs
 bZWW8hKrp4zunWHWvis/2GLGnkNpi1LHMXplKZHvHMH2z+afsJ7KcdzfndJtlA9bpS73
 eHI/8H7jlZUKwRIX5P6g0KY5RljLAJDo/UKWLkhmPc2+R2wb3UfV9HPc6AL1yPyb1VGz
 VC5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0sSfEklRpVNkSTbV3omRxOy4xuU2fU/g9N8DS/wf7gTvZNCeEk0eIgLRJMNhjVvDk9DsnxUOwYAxC@nongnu.org
X-Gm-Message-State: AOJu0Yw9kDsome0w7kAz8w27x8OGJQJJWOdMF9e2iZuTOn/b7J0IzkWT
 Xm6QPWVahXJd2g2k7PVH98TiDjwgPMVNyp1sf4cf9Kit4ssghkumiqyFHFkshHVbDVRdoHSBXEE
 75ANOzqJeaQuU6b+ugyPc0bwrys3QZ7t/yP+24KN5sA==
X-Gm-Gg: AfdE7cmPr5T4hTYodNLIKyAS4M3dF05V3ZTRVZakZqE/FPmHiS6zMK/JAVoZH26mQdd
 OxVeKDlhFnvD+rwBFh6yi0/2zYcTV/Umr/fuuV3PEcI/v0sE2sveloTgCfyTLN059g4KEroF5W5
 +wpy0g+Ptc/Y0Atu7wLNYTqnjE4mwaQ3bjSa/jak9Rkn5piZZJAVGW39QySTgrLwKl5AYolzzZv
 qV2QX2qU996tFSiKECgewO8qdSeh+LUpTo47msBmGu9BxWAkTkECygjXKo6+GggS3SESr58Rzge
 GXJ91sg9HcOFLe5vHn0bsLF0tbo944Ayk8v03viNiF3kNgADCVmNazzx
X-Received: by 2002:a53:d014:0:b0:664:d162:6b95 with SMTP id
 956f58d0204a3-66521d4f223mr8780360d50.78.1783083656035; Fri, 03 Jul 2026
 06:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260702133606.34529-1-sebott@redhat.com>
In-Reply-To: <20260702133606.34529-1-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 14:00:44 +0100
X-Gm-Features: AVVi8Cdjp4rhgW4B84oSynffNmIv6XYhu6GnwNTUBNFSpV6yRtac02uO6Md2tug
Message-ID: <CAFEAcA_0KOc_4DHioDbXKrAy-R45PEyDg1iS_dz7XgB0=0m9jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] arm: demuxed ID registers (CCSIDR_EL1)
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 2 Jul 2026 at 14:36, Sebastian Ott <sebott@redhat.com> wrote:
>
> Handle the demuxed ID register CCSIDR_EL1 as part of the
> idregs array. V3 of this series was posted here:
> https://lore.kernel.org/qemu-devel/20260622135627.40573-1-sebott@redhat.com/
>
> Changes V3->V4:
> * added R-B from Eric
> * incorporated suggestions from Eric

Hi; there's no description in this cover letter of
what the series is trying to accomplish. Could you
explain a bit what the motivation is, please?

thanks
-- PMM

