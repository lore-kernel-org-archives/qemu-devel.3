Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01E8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5sM-0005Oe-2C; Tue, 25 Jun 2024 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5sK-0005O2-23
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:06:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5sI-0006z2-6z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 09:06:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d106e69a2so158649a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719320776; x=1719925576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=daJwH3TpEvhFy7z51X7AKTRuLJM31mKSMpN38C0iSMI=;
 b=EloEZun4dYkuiGE4TpIg5MpuwI6Vd77NTnIZTRRKsKbpO8xYmkVWaKNqQzkGUgeraX
 +UKgntHoBBU6Zjc/jbvF+p2UwZukiZQGHuU157u7HJy3OcmqZY1Vqi9FzBIvfX6E5O9T
 b6rzOgMwAcMaVCX8h1lD4n5X2G5kg2UtYgZYtYfBVsw8SaUsdqmSPQKQdjSr5BO8P+5h
 LC7XSGhUwe6k3zuRD/C0PLnJnwXUZAalYhTUuBfrbN4yFg6MvH8/GmZn6yt3zyNgFd0j
 epuCvRDMVEyJPMKWVNHBuiJ6LJW/31EHNyE4PKHwQlvWehMG9XD8CpjfLGu4tZj3zxqZ
 /2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719320776; x=1719925576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daJwH3TpEvhFy7z51X7AKTRuLJM31mKSMpN38C0iSMI=;
 b=bAW9QRLZoyZeUpv1RyEiOMChxyDZsLVYwWkFVB87SGoRfGiJYuhAY8ceq4LhCZYszx
 YulXVnRt4sUapIsuLh15/1VcT4w+T6QKIPVWn+3+fy7FeCajIqpCj1zdAwJw/vXW3Gen
 5KS7AC0aK86U4aD6d0lh4TUD2D40DqogdCa7eMcxVom0wf0jl+LNxLHinw8jY/0xXriu
 uwv+LrufMXLmxPg3N2PA85WJ6xb5mPhGd1fX4ACymWrFN8KdhfnVa7Ar+8va7l7c1sGt
 ulV/4oHP1v0C2z71vW0Il3/MIIA8IoQrW/+F8LTmul+B23LrMV3WNjc+ekYLg6Gvz94c
 dKTg==
X-Gm-Message-State: AOJu0YzoNReYje30HpcoTN2d3A9B/2QBouLQB74A3PU+ijs+zmT0/+No
 covItwdL2gdtXVHqubCDljo7Ti0ti7VtgR/xcMripteWX7/vOANEzcA5vUpy253krcHFZlQdbqS
 Pzoq7rQlQcgp96PVxzM6ZfgLUVT1BgOrxILfmRA==
X-Google-Smtp-Source: AGHT+IHU71qft/Tb+1/wWCEgHtHdL6tbfcqkNL6ZX5347bmnUtT78T7YAyKlbkAkLZPv/H445eP/YtERaltRJI1DWUk=
X-Received: by 2002:a50:9f49:0:b0:57c:c171:2fb6 with SMTP id
 4fb4d7f45d1cf-57d701badadmr2130914a12.1.1719320775918; Tue, 25 Jun 2024
 06:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1717527933.git.mst@redhat.com>
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 14:06:04 +0100
Message-ID: <CAFEAcA_cJjtN8Qq=9xJiyJLtazL-8zTWJTgjFG74SE3MQHpdNA@mail.gmail.com>
Subject: Re: [PULL 00/46] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
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

On Tue, 4 Jun 2024 at 20:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> ----------------------------------------------------------------
> virtio: features,fixes
>
> A bunch of improvements:
> - vhost dirty log is now only scanned once, not once per device
> - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> - cxl gained DCD emulation support
> - pvpanic gained shutdown support
> - acpi now supports Generic Port Affinity Structure
> - new tests
> - bugfixes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Cindy Lu (2):
>       virtio-pci: Fix the use of an uninitialized irqfd.
>       virtio-pci: Fix the failure process in kvm_virtio_pci_vector_use_one()

Hi -- I was wondering what happened to this virtio-pci patch,
which I reviewed. It seems like it got into this pullreq
which didn't get merged because of a bios-tables-test failure.

Michael, do you plan to respin this pullreq soon ?

-- PMM

