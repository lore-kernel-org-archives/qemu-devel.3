Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C326C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNGd-0002Iy-7R; Mon, 15 Apr 2024 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwNGZ-0002IM-VK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:25:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwNGX-0004xA-83
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:25:03 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e2c1650d8so3063842a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713191097; x=1713795897; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=crDx7qj6hVccrprernvGpQInL+r05z8AKCSESGMvltU=;
 b=S80pbHeTqWtEL72HfOkXpSGo4Bl+bA7RvBRpDkTi0wu6W+CRb3t/nrV8vU/K1x5p3R
 tooTnZG61DctsLKqvnqTo0cuAjRpStfPMF48JGiHYIl8Wyb8ibEyhUxCFh/4tKDIaUun
 91aKtiZisoP7TSkm/xVjqaIseKhAO1GDfgTjGDrpEEwNFjzLgk8by9V8XYUD+eI6cO3S
 psANSmK2qluQE32x/AWCEjNnmPm4JSsUTs73fS8DgX7jhRiNnag+M1zMxAFepFLLRX3F
 g0Kgteg4w+metGmYBgy8p5o4Ho3+LASHWKH11rBSk1lilBkiUlxByPBqaiWN4OvlvXON
 1XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713191097; x=1713795897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crDx7qj6hVccrprernvGpQInL+r05z8AKCSESGMvltU=;
 b=MCTQX/CYRxyCa60r9UykSz45d0asKJEPWAfC7bBAHLxVShnF0j4WoS9y1YsvVdsIsm
 SB/O3PRPngWk0kPpf1p33pybkJEVmNPPpzQbHmRwMd9ZTsKQwYnP/qcwr8wu2CjvZDG1
 iuJmCJ3eNfhMCDs+oTOgLxOWPaY2FjobPAknVkhmERIr2m0ZfnERCeTLlQkf2LtmOn15
 0X2Q/HuMrzVyOlC46SlfbQw8wdd0ctkcTHtvgP9CmlFUgp6sHla21gulmImv9lrNV+Eq
 v5V043ecZSq18vvME+J/0FQ6+oe3/3xMctU1yVGjuIAC07XqJ8E5Y0G0StXebn8GqBuX
 Lt1A==
X-Gm-Message-State: AOJu0YzVj6SJwnjajbk11qN2bjEE8Iz5sArSgJXB45GxF6+nd0FybiXx
 j3uyuiDlIJFZEL/xGlGpToSUnWU9ELKKYFxtQI5geYC9ZUggu9WBHKSwmyR6qWLz9UYg8zUrLE4
 i7FrDsimyvCxt6tnzvBEN6YvgmmAFzaNnAibPKw==
X-Google-Smtp-Source: AGHT+IETaLnWCVd/uqtyWZitiMuO8jIrSeY7KNKTRrmD8ObWAmccdpTuN6UfRSZOkWhFftmyLBIwwqj2HRhQwOESzUc=
X-Received: by 2002:a50:8a96:0:b0:56e:603:9ff2 with SMTP id
 j22-20020a508a96000000b0056e06039ff2mr7267539edj.11.1713191097534; Mon, 15
 Apr 2024 07:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
In-Reply-To: <cover.1713178348.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2024 15:24:46 +0100
Message-ID: <CAFEAcA_KDdMBiEsfcdznhSSZgpmbUwS7ZZSCWmzMr5ciwWjAFA@mail.gmail.com>
Subject: Re: [PULL 0/1] virtio: bugfix
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 15 Apr 2024 at 11:52, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit e1999904a960c33b68fedf26dfb7b8e00abab8f2:
>
>   qdev-monitor: fix error message in find_device_state() (2024-04-09 02:31:33 -0400)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 2ce6cff94df2650c460f809e5ad263f1d22507c0:
>
>   virtio-pci: fix use of a released vector (2024-04-15 06:50:44 -0400)
>
> ----------------------------------------------------------------
> virtio: bugfix
>
> A last minute fix for a use of a vector after it's released.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

