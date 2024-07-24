Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F12EC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVaS-0001qn-1z; Wed, 24 Jul 2024 02:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sWVaQ-0001j8-2Z
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:34:54 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seven.yi.lee@gmail.com>)
 id 1sWVaO-00040S-Em
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:34:53 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e0b111b59dfso343033276.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721802888; x=1722407688; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xSiZTufX1EzkB2XUbimRP/iK/8+x3uWd1G8aKYPDyvw=;
 b=dNoJxgQAYzHk8tkHLE0zPFt+mrcsZgGRar6TOporF44GEKJKNIrSVh96eD2ZsDRN1f
 Lq6asJuBz1IIU0Q7sdQ0j+5dwVbSTnm7zmv7v0TbOUm3QqycVzXH8gSuzSOPEwUqWUpY
 +I5QKXnOS3e3MUnz1YXc/wyngITRarXY4K1H0sBjaEWsBN++M5ICETBKr3mLzLrLDvSN
 3VhLIKHpNqy0e5v9708Y+/qm/DpzgHmr01OJwJfypVZQjzERZFlrvczKY9GXMsV0uH9c
 8am1hKWMxzowfJ2Ozaai23I0dyO2uqg9mTc6waWoXQAgMq9QEajIkZXJUnTaKbxiL0n9
 Otqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721802888; x=1722407688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSiZTufX1EzkB2XUbimRP/iK/8+x3uWd1G8aKYPDyvw=;
 b=b0tgnQpLG8Qwk0AXYu2/iBMre4qZvrKsUtk/Hcmpiwq4zFkM+K2sFj+mHe/Roz2O1I
 YTviDhdA6qrlHkF5QErPZFfxIqP0lYvIlCTxaBVAB+UtveZZwq3N7bgvk5gKO/O12JSG
 6W6cFak4CuDlMrDuXST7MNWDUrP8sUVEHRYYR0Q46e6PkghSBZFskNdxWVAIEtPlkqZe
 Q2LnBgygcRVkuUaCPmqCi3PTayWqZBJ8HnTxfsP7BcJosW1NYmzLt7wYPlizJylAupcg
 t0zmX0GD+itOqVgjN+bOQFdoxGK0IsbtBl/2mKEECrs6JR38mohiOzY2004p7gb+ximb
 rP1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXvMEPcPfwsaEBoOCpK0axeN6WoSTx75NiT/5b7DyQsTqFrCSUGnzwrvrQZdtTcfMjx/AUF4JxYFJ4oKbX3iZASnu6bzc=
X-Gm-Message-State: AOJu0YxpnZ4RjTc7OHsA5lD2bUYNgfP5TG62aMILqS2KOxl2Byoja4td
 mN+i2Bn6Eu7idMFw8ABizj5SH4VeItBONl2kOenncYKcQyaThwWu4NISG6su/Fg5N+H2/Nc3hVQ
 DdNtiyV0l20iZXz1a+TBiJraHPcI=
X-Google-Smtp-Source: AGHT+IH4EKcPwVeDNn6NPIwIM92IO6LjpBmWGgk/O5do0gHLkxIejeMIla8+jHVWLsO3tBllyhz5coauHRzFX7cfkCI=
X-Received: by 2002:a05:690c:2e0d:b0:65f:86a2:b4c5 with SMTP id
 00721157ae682-6727ce1e0dcmr11787037b3.31.1721802888476; Tue, 23 Jul 2024
 23:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
 <20240720142902-mutt-send-email-mst@kernel.org>
 <CALX8JfRTecBexP8bV8LW2yGuj-hfWuYYz97FzTKdrL43GF3+Ew@mail.gmail.com>
 <6996e344-d0af-469f-98e2-180336bcfb55@intel.com>
In-Reply-To: <6996e344-d0af-469f-98e2-180336bcfb55@intel.com>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Wed, 24 Jul 2024 14:34:10 +0800
Message-ID: <CALX8JfQNVv=8Qruri3sp6Pn-qGd7G3QCQ8DJRtdqZVTApsG3kw@mail.gmail.com>
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=seven.yi.lee@gmail.com; helo=mail-yb1-xb33.google.com
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

> So you found it by checking the debugfs output, and it looks to miss
> the DW bit. is it? Put a clearer commit message would be helpful.

Yes, it is. So, "dropped the value of DW field" is indeed a bug?

> Please address Michael's comment, add a "Fixes: xxx" tag and resend.
OK, I will.

