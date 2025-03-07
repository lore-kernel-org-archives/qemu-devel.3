Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51018C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVR8-0000fn-GU; Fri, 07 Mar 2025 06:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVQq-0008Tj-DK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:59:58 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVQn-0006Zq-Rq
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:59:55 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so15628837b3.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741345192; x=1741949992; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7RfL2K9/nW+zFcsaQ4NiQEoxg0Iv6ZXZQKdoDL2K2/U=;
 b=QZENsdNkoSZYpy/NnZaFzzEG96hFD/J1bfJm53J+TF3MBX7bS2EDZZcs/ULcJ3wkT3
 Ht02NSDHFqfSBmejCMTZJ/5UVxAB0Y1pICAuLQEI4Rq2akUYYm4vKr3HnI1qqqohbOKW
 ZWrDTfVBMXWk//Og+bytT66H4+TxIpVo2isRga7/bmoOc86yQYhZsr3S2NVYD1f8/Hc3
 FrdHCwMukzm4JNZKnjClefxDEf0Vr9QfYl9WeZsEwWVRyPgO1OkHl/hQn6H4+84d9Oli
 aX9wdZ0fSaca+gACHs5y7BIeZATmgQT3cSOJNybinpHHJoLeV7W2jQTr6mjWZLF2n6/Z
 GlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741345192; x=1741949992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RfL2K9/nW+zFcsaQ4NiQEoxg0Iv6ZXZQKdoDL2K2/U=;
 b=YDUfjjquDHisQMoZeI1H1NOlkxDEzQ2DgtKNEJLb3S4I97MEXFtGXs+TItr1/JZprR
 aEts+vboCCN2RrxLCP9XuzFYgd3zcLumTrJPY5tcqhGLmqikC/l38J93bJ+/Vmgwobhl
 jQdW/yHmG19a2VmvoHP+fpk8Gi3Wr+3QqawnR7POKUyu7oXsuMGDTGnilNnWEiOOfpWv
 eCY+3uz9i9cIY0/LGhoPNCjPzMsLs1reTSY2PoOnFJzfqN9vJHoXq2f5mwemFt+E4coQ
 5Ov7P3mvURzHiC69bEMqthnfPbqU+OpiEH9YNYW4vux/2N9gYzTYiRvWAYa8bW4rcpCr
 J6Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyzqffEuAT2gkni55DFXOICtc8sMAXvBawFRQB62jXVXrpXLnS+k74S40fl2m20K3/yrJDlXwXkIF8@nongnu.org
X-Gm-Message-State: AOJu0YwFDFsYnmDQzbEitzQ4q7/DuNAg1TpmNJMk5xogfB4vYOjWLS0F
 kQLrOqXgP+CgGSA2sQ3eFucXEkAoX4QcoBsR4jMPlKZM8fKVyNUHTb1jJMY3GltTspcDZQasjCB
 8UczsA0RWAnXhteoUGfisDG4mDUlEE2THJj6jPw==
X-Gm-Gg: ASbGncu7p5kPRYtI/qzy5S1ullPhkgvyrPh59jqo0XyFvIO8FmrLwqAYFG+6gJ6tvUE
 TBkTfTPGLoM3Gq+eG48FWMBLsEsbEYbBGjVG4YsLGxpuiUkURXZmzhgvkh/8AhvBCm+pdLIwYys
 /BbR+hxx4jaL38O0z8M0RJdz7ipdk=
X-Google-Smtp-Source: AGHT+IH6rbxN5xMlTW0F8tVZpEod+FcO2odRO56U2rAe886HXp0nseFk/n/M6Y4MdW4MAtCPKF+3m7tcgZ9urSLBc2g=
X-Received: by 2002:a05:690c:6f90:b0:6fd:4072:2c5b with SMTP id
 00721157ae682-6febf35f2b6mr41151787b3.24.1741345192726; Fri, 07 Mar 2025
 02:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20250228031438.3916-1-jansef.jian@hj-micro.com>
 <a55764ff-5e44-4057-af0f-3beb9ae1c0c1@redhat.com>
In-Reply-To: <a55764ff-5e44-4057-af0f-3beb9ae1c0c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 10:59:41 +0000
X-Gm-Features: AQ5f1JqX8RLdcIBQShyNJFZbp6jUNVixVLdoaKCWBGDMJZlAIxjXT-WYKd7-mqY
Message-ID: <CAFEAcA8j2crjxpz0_ndf4fHCETRH5xa4wPdZpo6TdVW6CeZPxA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/smmu: Introduce smmu_configs_inv_sid_range()
 helper
To: eric.auger@redhat.com
Cc: JianChunfu <jansef.jian@hj-micro.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 5 Mar 2025 at 16:56, Eric Auger <eric.auger@redhat.com> wrote:
>
>
> Hi,
>
> On 2/28/25 4:14 AM, JianChunfu wrote:
> > Use a similar terminology smmu_hash_remove_by_sid_range() as the one
> > being used for other hash table matching functions since
> > smmuv3_invalidate_ste() name is not self explanatory, and introduce a
> > helper that invokes the g_hash_table_foreach_remove.
> >
> > No functional change intended.
> >
> > Signed-off-by: JianChunfu <jansef.jian@hj-micro.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>


Applied to target-arm.next, thanks.

-- PMM

