Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6900E9B250
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqfy-0004PC-3u; Tue, 24 Feb 2026 06:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqft-0004ON-LG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:33:57 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqfs-00070e-4W
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:33:57 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad019bb5eso4711440d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:33:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932834; cv=none;
 d=google.com; s=arc-20240605;
 b=Du0TY947rXuQa0e+UKM/Fp3Y5DKzgDxkC+4geqFlRr3v0v/wYk3FjlA8/HoVNcDxOZ
 lcxAg5ICD2mNFKToOCa3OHWxoPQdv/V+3EWBprWB3xXxH0YKi2MEaGUTrFJFpGSRbgMw
 tU90nQ1G3w8Flkeg8qxu7GXnzivtPtrsUOWr471VoQdxhM2qlu6S+f0bTQPZUFEbbGYe
 kjJ8OuItOY6FdhlN+VxD9kM91LnO0JtA+bAhm9K35J/eOkzs8H47aN3476FCbpmN5T2q
 qGrvFbZxnxbbgsavl+5SEvrsf9xvJV6TRrLoneKmgJww54GLRJUV9yb3haMuh57Vxi8B
 7+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jw6b1uRWo4mfiI+KIp1Eux/GBFRajqTINbXE0wTohKw=;
 fh=ST6Z/4gOJCkkIGTLgolqD+0YY9YU8p2GfIs2yEr0NyU=;
 b=XDDT6GG3ol1j+Kj/ATlgaEenIQpVDx4/xKUldJMmjM1P3byBVxq9Gp1h4yNDHgvAcM
 t/BKaKz/gBnv+mciF4+J8fIozSwLoXGgpxtFGXO74s4DEDTTf8yVZwpTou8LH5FqD22p
 vC+XZPvA0svKsqT+wDhXEyZHPjRquXeMzOHuwFAYDZJ9ZfstNb4PjVGpHOEOMV1n0ZqA
 eHEkKYoAcEsqwQbVDjiLSrsqNobEh3U0V2GQyyaX6/OzY+lOjoM1NqS5NMcwwv9zRN50
 NqvF/elpGxA2b9gF0wXVHbcFgeYA13Y7c1kiaf5VgcFu2COPYsuXz6bBeMrZI6kNZIjW
 TrYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932834; x=1772537634; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jw6b1uRWo4mfiI+KIp1Eux/GBFRajqTINbXE0wTohKw=;
 b=LN0R3/B/DeKl6adPwzpTaFI9AFhN//WnbpYTV3BvMCxk/zMelxLTwXni0F4nj8VD2g
 m2VKu27jrmRBz5agA1g5UJXJnJcr1HBbXnY0cBmwvDfeOCRiMS8/SbMm+EWnbi5O/AgZ
 WaUq38LbTF7rRe7fBhdkzT43QpFSe33UaI8SCGjPYjzodv5PC7vZ16sJOOQPQgODObW+
 UpFyzzZC2chBZy0/zDtaiE/IOw8XNuvC5R09/R7LDhJSO2jjJ6vkl9SOoBk3uwr7HdqX
 bZwIKBlDGIdwp5+XApMSPHNygaXw6A76kpDbscbhQQBm4Kx4VQ1P/t/zRlc/fm8qSaVT
 TBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932834; x=1772537634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jw6b1uRWo4mfiI+KIp1Eux/GBFRajqTINbXE0wTohKw=;
 b=iQGY0BI+2NbX2si7GzLEGT+LJMLR6a9Fjp7aKTNuOjOqz2iJ0Y4L3dVKf6SlsA9F/a
 nBpXx2qNLMdxiwSePdzOunGmADWw4j1nhviZMACD1bi+2TzeIVBeRgGzuj+h0FTGlxux
 E8rIy6ri4XQpghunD8uEfs9/mwcxNL6vYfIvF/6ilyUmouvJIFv3EboALLrLmix3kqEA
 SjHmRexzwUJbRHkbEN7yKc6fr+y/brWTxVIe0/nQsIe2LYbCjmHzrO1pfSPNJGckcjgg
 WidwNsueHw++pxHaUo8mlobslle6Y0KvxC5uC/G8VKId6IjNo9fYW6eXnzVdYgRSCYF1
 yBnQ==
X-Gm-Message-State: AOJu0Yxo6jXFvmjErKV2nGRvKHC4re15N3BVd/uwihw/Jt+wxqaOgLur
 v6rEPSP8BfLFafwE1kFgilkpu1vAD91prFPvDrhQN0CECQv+PlHhQpCOCnsdzjuXQtn1FdSHjdI
 yb+xnKb5ptW/uP0iXauZnmWS9rSR/N/Xw1NbFRINbKQ==
X-Gm-Gg: ATEYQzzBVTFZxrk9LhZGkc5H+5vrFxseBCvFDhJLrkLZ2KIKG5HWbqmxcfz5FMxMcY+
 8pTRY9mxxML+EAEosHFQfizl5ghR4fuT58W3LKRjunoapKgB1qO9djK3209fav4NQMHS0VKpmCr
 7kal+a/r7ksVicXTK+vskGMxsVmbb4lT82WIDBVPvGOZv7JGqzkMNv8m4mfqMvCeGk/X040d2Zu
 dEZdWat2usQKPUsnlImsIi04YUWH1mpBez1+VFlKDHxSyfjG/didzarjPo3XMX56STXgp/W9sAQ
 r4jWLbd3gD4ufrqp2t1FYSCY5mZou62OfQF3dKkRupnNb3hprQ1HEw5Welhr+qbYzyw=
X-Received: by 2002:a05:690e:1288:b0:64a:e7e0:a723 with SMTP id
 956f58d0204a3-64c786d10cfmr10444477d50.18.1771932833963; Tue, 24 Feb 2026
 03:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20260219173256.152743-1-mbawa@redhat.com>
In-Reply-To: <20260219173256.152743-1-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:33:42 +0000
X-Gm-Features: AaiRm51KPda6_GbjYDWxvFkE8dUc6UIpQij_WTrbflbE-_hSpv5J4ehItPKeGeg
Message-ID: <CAFEAcA-No=5WiKoeFMC5qLdRzmCAKbqA2oROyvo+WkLVQmpW7g@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/virt: Add virtio-mmio-transports property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, pierrick.bouvier@linaro.org, shannon.zhaosl@gmail.com, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 19 Feb 2026 at 17:33, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
>
> Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> tables even when no backend is attached. This causes "Unknown
> devices" (ACPI\LNRO0005) to appear in Device Manager.
>
> Until Windows fixes that by supporting, add a new machine
> property 'virtio-mmio-transports' to control the number of
> virtio-mmio transports instantiated. The default remains
> NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> Setting it to 0 allows users to disable virtio-mmio entirely.
>
> Usage: -machine virt,virtio-mmio-transports=0
>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
> Changes in v2:
>  - Renamed property from virtio-transports to virtio-mmio-transports
>  - Added documentation in docs/system/arm/virt.rst
>



Applied to target-arm.next, thanks.

-- PMM

