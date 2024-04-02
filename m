Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8E8C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgoc-0004Py-GQ; Tue, 02 Apr 2024 12:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgob-0004Pp-MT
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:16:49 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgoa-00012e-6a
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:16:49 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56d5d4d2e2bso3364846a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712074606; x=1712679406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cY7a0MSuSZXrf7HPefUvSlSV/UzNMemAWGF8D6/Yq3k=;
 b=wj2phm32J73dG8d8HrPx4i6IxdyMQf+Hdl1okU5N83X354M65IT1jNqtjowjIHmq29
 WAhA5Qiax4faqaZI4uAEqeG/BomiZkiF5fRaYy4XT8Lvk0gW3FE0OW/K05iCuxkwTXDJ
 /Uvfi9Dvunlf4m1jE2xx27gyMB0lDF4iXlWwBKo+biFEVfFt+jx2E3U0/M5kos/ccFkb
 fHDNxqnPKvIFsHyVKaq1hoY/d0nOXzwcZukEWyHOawWRtfuq5Z2G4E/qa18uPoV/c63E
 rzWzPkiBJtoQlvmLKfl+nujanh1KAdEdtJGnMLn9vZTKI+poACqGO4/s2365ozNSJQc+
 zyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074606; x=1712679406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cY7a0MSuSZXrf7HPefUvSlSV/UzNMemAWGF8D6/Yq3k=;
 b=q02l8E8+8NXpCZPkd7JItmaLv/sg+2WLGHZgd6x0UFQAOhixUmFGJt8gxfjGiytWNB
 mwxoWwbe99SgAhBN8/fRim7WpNIxeRjhdSw0p0H1wZrFZZ0xRYJXv5InQlh8AVXEZEfR
 jPDcVa+FLUYag8H7jeG8kuKjXWbmBmEgPb08WAD9e9CZqRIE2n62c7Y2rW3JB+ryHRem
 7T7ga+RYqAkkYj38mlCl3cYMjz9Ut875tgFSUfTpHCKV3hAn9SoNcpERwZH6hhgnxUp5
 JCP16WL5zV/1yNd7w2NdSIIsgfX1ZfDU3ncQLGYCIUMXMO3mzIzV8F7Qn2Xlg1L4Fb/H
 8F+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtHi+oqcsQamacKw+ylny27+HiN8ArUQIGMDwCn12qgCdK+Pczqx5kqtcXbu3DVmdFHpVSMoedqc5lJJO9jSoCEU0psEY=
X-Gm-Message-State: AOJu0Yxh/NFvSSipNkteQEH5z4BobZLKUE0lZu+gasw9xyTFapGo2lHp
 DETQILX5adgDTQTTT73VKL9TEXHB4m0wUS4sXNvnbXVlTyoxy+T9uT08sZQIUvqoFZs97h5Gmq3
 CkzX9hengu1L4HU1BX4ZlBsL5PtzbtqbAL9v6sQ==
X-Google-Smtp-Source: AGHT+IE87XDf4OXxLK3jWmjvDKctqxxqUXiupWOnbIHIoyl43IKA8deMZw+nKu3LTPZvSvjbH3JJfmhWMv3ItLNbEME=
X-Received: by 2002:a05:6402:1ed4:b0:56b:a969:e742 with SMTP id
 g20-20020a0564021ed400b0056ba969e742mr9534672edg.4.1712074605943; Tue, 02 Apr
 2024 09:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-20-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-20-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:16:35 +0100
Message-ID: <CAFEAcA9t+O8vwp0F_LWTiibEusaPPgWGSoe3Q04ZpowRzr=paw@mail.gmail.com>
Subject: Re: [PATCH v11 19/23] hw/intc/arm_gicv3: Implement NMI interrupt
 prioirty
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI prioirty

Typo in multiple places in this commit message and in the
subject line: should be "priority".

> is higher than 0x80, otherwise it is higher than 0x0. And save NMI
> super prioirty information in hppi.superprio to deliver NMI exception.
> Since both GICR and GICD can deliver NMI, it is both necessary to check
> whether the pending irq is NMI in gicv3_redist_update_noirqset and
> gicv3_update_noirqset. And In irqbetter(), only a non-NMI with the same
> priority and a smaller interrupt number can be preempted but not NMI.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

