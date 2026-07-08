Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9769AC44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPFe-0001oB-Ra; Wed, 08 Jul 2026 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPFZ-0001nf-G7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:11:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPFX-0004AI-8B
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:11:28 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6679d88abdcso709914d50.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783505484; cv=none;
 d=google.com; s=arc-20260327;
 b=csFd2zQEjI7gY5OZnQ3oxX5Rb955qmnNbsZhij9MAzbPm5MFRsLgcrM7MlxhcxJ7gY
 hAifJGH1pRuzDip9XxFMox9+fdWtETfBAkuPAjjZVrK8IAPDt57of0LSFfH7iDAaGDpz
 lcmkyAm15iurvngYCkegfbpHsPTX8UDHZ6sxgU90ookeVV0eckcxiLj1ac2c8H+KcY5h
 MbnA8R+fxhJkIMPHrU3KUnaYlals41wc4PdCPxdgind4KTF7eIcYHBckMmSjnvepqcmk
 5n/9RkV1exVIf4c8uhHb29xq+I7XSRsBNJ0csbFjxg1ZZ++2WbluGgeGEJFSaUx6EYD5
 FNng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GIyecIii8VEKjz7Xb04A8BTlCRTZO5FE8tkVBIVX8oc=;
 fh=10RhduUL+W3qe6vLjqIRiE+Qmxow+4xQKKoTl/PCTPg=;
 b=D79o4tfG3uYS3urNU0GndQkJCmtlXbD4NmwxQzzxGfpmq9JamQnClf14lC3mWM5jKJ
 dMUHRQcyywygBX6b7v3ihPcjEhJXHrrClN8sUVJck17OM3Y7VMSLwTwxZ/XhBH33kefR
 7uqQxQHAN66DTnSnUTvpBSo6rmXVXAmnCasuhr23DiwL6bYPURKiFLfgRO7UI9Aug8qT
 2iECjb2d+bRTfEIjefiC1q57qkSLACZyBzBDJaJFUh2FupwCOuWliebQkQmkhKPYYagO
 +QXStx3t8oHjCL7WsQM/xzk//NowphCG4xYi3EdUF24gTMmSLTBfzCs4xv7wrgD8+880
 HZMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783505484; x=1784110284; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GIyecIii8VEKjz7Xb04A8BTlCRTZO5FE8tkVBIVX8oc=;
 b=LMRYq9KCJ8g1+zg9NvB2s/Ea+lmh41HhIMIQ1vWYN80gyL2HpzrDWwH9OcrVP0aW8+
 l/FDZzSl8MwXV5T4csD+1Q0d7F38E40OCPP4COHkY2T4/fjtUZso5AFIF0/H3tjIPYUN
 8emfHQ1AP8NOoS8nqRx5vlgoLe68kPvQJjPRE/po4DgRfW5za6RPloMPa1K3rRr12CCe
 ZyAX1LLf+Py0xzoKuU36S5SwGxsdrdFPNa/rjdIXN0yOmYSXrKKcrPKiYdUpggSP+ZA6
 0tshA4ZT4HW5ZI6iuhIWoHLwDjo3GS1cFHhJlgbtio6PUCF/bwfemPtsGkKMmOO4S+fK
 Ad4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783505484; x=1784110284;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GIyecIii8VEKjz7Xb04A8BTlCRTZO5FE8tkVBIVX8oc=;
 b=kxfAxDscuf1jCB2Z0mQVvTNPC7S5PmkJDwij7NtDxolyEyVGxnDUbOXTgAycxKb78w
 5tVZFoS2k2V7TF9OaGaHN7GYmtPMVOtDb0f9xvPm2NHaGaps+eEVw/Ob2RtkR6xxcqMf
 Dvxkh8ROU0QIREz9j+UJGjAk5R+dFr33sUQNxygYla+AqJLhRpJmRZh4oevcPcV/W9sP
 lqrWABZxLja5e2ZOk9NUXk6v4IpMSgySy8x8NrTbky3LYWwZbUIsTA8PT8ql+iju/Dwt
 RaGcHN+gMhr0vpkAwDLYaRjC9mOPOaHqhLr6c9MO/ZNMXTTpkFBCi+kAR/4kv8FWK279
 D01w==
X-Gm-Message-State: AOJu0Yz5avKlzKXpb1HTL/KlQglifMDK1loNezFf6qGp/jNz278ihxe6
 wREapwg+fkEHJuCZdbu2CTYUvbYsA/l4aqVg9xYN52v6IF7YJeMZRFGUzGx1r3VkmRZyqU4EEPj
 Wwx3wESmb69wkURMmR18OKjbr86yqZqM+Xt/GtjXLXg==
X-Gm-Gg: AfdE7cng+SrcKQZ9AuLkfb3kDuX1bDw8NOJW6MCVF8IKKTTI4hk/VoYLYmNv6o6aFig
 RJtBDPNEKWtzt54XTo+1w0IKm/J/HihE7bsfnul8kWD0TxeTasZ3DCw6hu2BV8P0acD6lX88bxU
 CC2aMQsl+nrue5XuHfhQ+h8BIzaGVdFCK8d2HJlNBYY8nFuqYs6AHhnSOZd7kLa1H53BTsKun77
 HtnVFgAqk/rJo8nGPfPio7z55WjbjZIaLFbqFLI3VOR9/kyZgJ+BOotud59ZHHMTArdW1/cH4DK
 2pLer2lm5sfAtdEy//dRkZOhG/7qJb1trNCNMwOfdAG4jK1pu326HHfQ
X-Received: by 2002:a05:690e:d44:b0:667:8ba0:f79c with SMTP id
 956f58d0204a3-6679f2fe908mr1239627d50.108.1783505484576; Wed, 08 Jul 2026
 03:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260706224426.14156-1-its@irrelevant.dk>
 <20260706224426.14156-5-its@irrelevant.dk>
In-Reply-To: <20260706224426.14156-5-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 11:11:13 +0100
X-Gm-Features: AVVi8CeYmuBMIfJ6gJq-__MYYnbgxVd6jYaYuFEr1xevfgeA3KTbz9VFPb3cxWw
Message-ID: <CAFEAcA8ZQX01i9u0dUziRP0rAC1fSF=zbWcmQdLs=82D8ECg4Q@mail.gmail.com>
Subject: Re: [PULL 04/11] hw/nvme: add migration blockers for non-supported
 cases
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 6 Jul 2026 at 23:44, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Let's block migration for cases we don't support:
> - SR-IOV
> - CMB
> - PMR
> - SPDM
>
> No functional changes here, because NVMe migration is
> not supported at all as of this commit.

Hi; Coverity has a complaint about this commit (CID 1663673):

> +#define BLOCKER_FEATURES_MAX_LEN 256
> +
> +static inline void nvme_add_blocker_feature(char *blocker_features,
> +                                            const char *feature)
> +{
> +    if (strlen(blocker_features) > 0) {
> +        g_strlcat(blocker_features, ", ", BLOCKER_FEATURES_MAX_LEN);
> +    }
> +    g_strlcat(blocker_features, feature, BLOCKER_FEATURES_MAX_LEN);

g_strlcat has a return value to tell us whether it managed to fit
all the text in, but we aren't checking it.

In this case it looks like that's not a big deal (it does always NUL
terminate even if it truncates, and we're only using the string
to report migration blockers), but I think it would be nicer to
avoid using a fixed-size char array: they're usually a bit more
bug-prone.

How about we use glib's GPtrArray and g_strjoinv() instead of
manually building the string? Something like:


    g_autoptr(GPtrArray) blocker_features = g_ptr_array_new();

    if (...) {
        g_ptr_array_add(blocker_features, "SR-IOV");
    }
    [etc...]


    if (blocker_features->len > 0) {
        g_autofree blocker_list = NULL;

        g_ptr_array_add(blocker_features, NULL);
        blocker_list = g_strjoinv(", ", (void *)blocker_features->pdata);
        error_setg(&n->migration_blocker,
                   "Migration is not supported for %s", blocker_list);
        if (migrate_add_blocker(&n->migration_blocker, errp) < 0) {
            return false;
        }
    }

thanks
-- PMM

