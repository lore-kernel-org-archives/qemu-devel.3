Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF88DC44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkVf-0004Q8-QP; Thu, 09 Jul 2026 04:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkVa-0004Pd-LI
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:53:26 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whkVY-0007WY-SS
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:53:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15ba5b151dso221632566b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783587199; cv=none;
 d=google.com; s=arc-20260327;
 b=FFNxeXm1FT/cct4CFT8vCFXxPKFD9XnWyzy2eV/X9SQTWZ33s3DyFW5jl7LZTh9y1L
 dUNrn4Y6fU5H3phMowwAKqTwUeOH/La88TujIFvLA6xH76O0NyXuNT6LmREpkUTbJ+P6
 X2sp+R0pCSzFE2RtuBvCqheHqI1v1u8qiue51cHiS8yOtyZM6+7TFy23u2gNble6sHGx
 odKucbVq6dbt8D5SEwwYc52cmdcX6ryHbv7Vu3R+pZkp+P1h2CX6ahUNkSBVwER5w3RU
 O+pbtQ9YbJhnsQm2IPjrRSaoG6LVGvm5bLTwA12kekCQy2ieH7icCY3PvCj073d5yJtN
 3ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ah9HhzQ3pzgbNse0JKc9DbI9BxGwCUbNNKlPZAFazlQ=;
 fh=WYZv+RFsrAIfj1zlwKe5+05ouc6abPBDzlDOtJ5Wv18=;
 b=Tao70bR0yEv0EvHvJD2FGREEE9T3G0QKeyrDbjYnOV1LgMHNgl5C3xxcukVGBOJ2aP
 CGS0Vp+AdZr6HKHdCkPt/4g1xJaIwVwv6tY/K+8aQNAgX9h0zWz/RLVZ7hpbjI8wbb81
 wfPLbgQgGQd00qKgDEPYz2We66INAjhWImwxIKQEkjGry3nY9AMDDuS2pltfA4cEhlbr
 hGFZCiAqKfAUODitXNL+vQBTNcZMRT7QB/z0oQrCp3pjSpKSYjG3g5Yv80Dt4J/XOCdJ
 tRPgT7CryapDxP4rFhfwGXEzXjamNgPit9iSJMbXUQcUQLfLUxfHVmSy6THOGuKLe/fh
 OepQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783587199; x=1784191999; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ah9HhzQ3pzgbNse0JKc9DbI9BxGwCUbNNKlPZAFazlQ=;
 b=Tefkb/sUVgWqTC34DQ/PWOYiRlAbVY1FpAsMhP2/Na21j5qWXr59B80C2SgjHS048+
 jCPtHaKq4jRdWpKlyCN8Oe7x+Q/geVyu2ZU7YZLlLEVJD1DfTT8aWui3eKVyGTKOUt/o
 /NhJeuu/yVJl5nssAGvuIEmzL70sGyNmexkcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783587199; x=1784191999;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ah9HhzQ3pzgbNse0JKc9DbI9BxGwCUbNNKlPZAFazlQ=;
 b=EQUOg0ChgtNxFy68TOVIO3EHNt4MjDXIvUWxpSg5CrWUuTdx0Mc/R4wOSTu3fws9Yj
 RyF/+daO+I1n5dygX4rut4f5vusiseotQArd/1265279IyFoiTA5TTDIT9n7rVcY7Pfo
 oHJrYu9PmOJUB4fE23meuY4gE4by6NyM84ZZYz4KXoK8ffSBx6GEpIK4MS6xmfpUyb62
 2E7Wpj8WoOsDjrXNz01v7Ahh2+KTZwhk6pMwg0wJp4txoQynkneK9nD/6XilHmsIQt1n
 G6RYZjTVVDw0J4Wv4Ya+vT4lwTk7sPOghmwxX6CErMuG5eeOZU8xivg3Sy90i2hLjea9
 Lkcw==
X-Gm-Message-State: AOJu0YzfN6t3wV5I1e7t6dfrwDD/V06ehjQWNYMx5VzSgAQzuhxyt8zU
 x3JGUDvQbV+8VxMTscf6RQ0eWdlzH8WXsKfh95LoaF6D+ObK3xT5M7RFF+npKAmHpff8cUnFBJv
 R3jOTFljSKOeIm2EVS6VSK1cI+MOeYhDD6H9JFTCazg==
X-Gm-Gg: AfdE7clS3xqIb83f5cKHvObNcQv0ANTa1AElFkUDLsJJoW0SWz4vhBxj32nDN0Ig7di
 ZSLvV2k9ZZt0rsvRxYByW9M62xkb6KIX78KbcOzIaQI2YcjvpfoffxQN2+kxfwJU5tJJWJwejxJ
 gguTTvN9Z+5q7HMrVUgNaiMR4lrbYsNu2rQAb4uICMesYRHa+dtEFB1Kzy9Rrz3UFeluK1lAz0B
 7nkWwdl5iVonndsNngGwUuocvHzWZaHmH1ruDH+is5GmuaFJrGOnpWnOmzcjRudr5jVMfoZ0JV7
 ySf2EKr9JL8hPDYYMkaC1yZRL/YM
X-Received: by 2002:a17:907:1c24:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c15cdfe6657mr290274866b.5.1783587199117; Thu, 09 Jul 2026
 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260709084728.92862-1-alexander@mihalicyn.com>
 <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
In-Reply-To: <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 9 Jul 2026 10:53:07 +0200
X-Gm-Features: AUfX_mxuqo_MN31jjbd2TJwisfg0ormYrqcCDGiljE5MqDn1qR5jrY9si9VKOJo
Message-ID: <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x633.google.com
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

Am Do., 9. Juli 2026 um 10:51 Uhr schrieb Peter Maydell
<peter.maydell@linaro.org>:
>
> On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Let's use GPtrArray to build a list of blocker features and then
> > g_strjoinv() to build a final comma-delimited string.
> >
> > While previous approach was technically correct, it is fragile
> > (because we need to take care of static buffer size choice) and
> > Coverity dislikes it too.
> >
> > Note, that we use g_ptr_array_new() to allocate array which means
> > that GDestroyNotify callback is not set, so we can pass pointers to
> > a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
> > any problems as there won't be any attempt to free that memory.
> >
> > Resolves: Coverity CID 1663673
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > ---
> >  hw/nvme/ctrl.c | 41 +++++++++++++++++------------------------
> >  1 file changed, 17 insertions(+), 24 deletions(-)
> >
> > diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> > index a67e1598891..95a586d82a9 100644
> > --- a/hw/nvme/ctrl.c
> > +++ b/hw/nvme/ctrl.c
> > @@ -9352,22 +9352,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> >      }
> >  }
> >
> > -#define BLOCKER_FEATURES_MAX_LEN 256
> > -
> > -static inline void nvme_add_blocker_feature(char *blocker_features,
> > -                                            const char *feature)
> > -{
> > -    if (strlen(blocker_features) > 0) {
> > -        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> > -    }
> > -    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);
> > -}
> > -
> >  static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> >                                          Error **errp)
> >  {
> >      uint64_t unsupported_cap, cap = ldq_le_p(&n->bar.cap);
> > -    char blocker_features[BLOCKER_FEATURES_MAX_LEN] = "";
> > +    g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();
> >      bool adm_cmd_security_checked = false;
> >      bool cmd_io_mgmt_checked = false;
> >      bool cmd_zone_checked = false;
> > @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> >              }
> >
> >              if (namespaces_num > 1) {
> > -                nvme_add_blocker_feature(blocker_features,
> > -                                         "Namespace Attachment");
> > +                g_ptr_array_add(blocker_features,
> > +                                         (gpointer) "Namespace Attachment");
>

Hi Peter,

> Is the cast here because we're dropping the const property of the
> literal string?

yep.

Compiler output without this cast:
>../hw/nvme/ctrl.c:9418:42: error: passing 'const char[21]' to parameter of type 'gpointer' (aka 'void *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
 >9418 |                                          "Namespace Attachment");

Kind regards,
Alex

>
> thanks
> -- PMM

