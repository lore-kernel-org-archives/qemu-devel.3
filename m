Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721B3CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLOb-0005lK-2f; Mon, 27 Oct 2025 07:28:18 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDLOX-0005ko-6W
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:28:13 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDLOO-0002iR-2r
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:28:11 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so7222094d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761564479; x=1762169279; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4jP1Cz7ht3qDcaecQqPJ9B0CKFuaGBf31D4PnuDzK0=;
 b=JXppUf3hUAPqAFqr6l5bVrhjB1AdY+08odD7TPoAWMyylSZQbcyJO6Gbii6bCHFW6L
 C5bqUm984Uat7XDgx0NOQHoCjvTqyVTgmaILOfBg4HbPzk/2YSiPFKvQ/aTwWDwNaZ22
 gQHDYrXPBwIT1BAecze6a2II5HxJYSP1+5fR1Mbfc7tLFrK92DYV6JH8EYnwee3F0q/P
 zNNfyxjPcOFFkhEkjiiLyP7JYsL7AJgVIm8H0y7jc9uNhUa//EQ9BuS6YuC8WGNRW3Nw
 n45x+4kEm9dcrGqlcEaqWoosh0d/+sx16sfl/PDkM61EhgoGHlSXSoddmtFQnfCvnvLR
 jjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564479; x=1762169279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4jP1Cz7ht3qDcaecQqPJ9B0CKFuaGBf31D4PnuDzK0=;
 b=eBZjHP5VG6+56eII31wIHDbG/90+t+i52zTKABclKFnLHCmSyAanlvWCod8FEiLzxu
 7o50eKdN62gMFCDYLXRIrt1ueHFsln6e4pZ04Eie+e9PNCVQluOZPI/rkBDAhd+4zooq
 DvFUVX7U135nWwmOFEbJ2UWmmM1GHMFkkcvg4rte3HvlPgsNx9lXQiM7HCnRiVDC+3RT
 5unKihnBYz95JkJNQE7LskFJtyPnjFFtDLA2pCnT5Yut96x2SFFrbkPVYpEAw/ogOLaQ
 +zXWysrUUAE9ovwubITbEAG9k4HSnSraHh3XScfKjLtP2MqsaMowsY++BW9LQYu03zL8
 iYVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy9mhEuyWT27iF2DAlAhVuyQC8kf1dAfSYfVQnA/7nc9qEm4xwrDTJKnNh+qQUDhKWVDlbMqNUE+Ve@nongnu.org
X-Gm-Message-State: AOJu0Yy88F0AXIUggFTZ2dDQqbHc3qpdICLS302S30+PSNHl/R7hLERE
 ys1tgnwIb0tztOgJGZbVoYNzy76GvyLLtmTBw1i+LZHsveLKuFayiIbR3r3W+QBMPGNfyuUcZER
 EyHeRl3250Ir46oQRzfsuYEsT5wNaK5ghvo7GFEMSFQ==
X-Gm-Gg: ASbGncvJfSjJWnvPkuHL+enqA8xrQDwOw4RqPEcqUmKNnofgapvICa0nJWA6rgTqmnK
 iUUWr7T4p4YiLX9JRU6RnOmXkIGv0EkPApEj47shbnr/eRl3bMhZEYKx+x7mPKk9mJqbIqaE9zt
 TMcQvw5LR8Fk6PpWQypql8wr8utok/ZD14TRuNMwK/3NaHEHWq01sVu0b0mD3c4XFGX+7pZMI3s
 ThvnehzQdheCJOvt5iWyaJyz4CWlahPYoBYvN+qy6V69nJcjm9w8/sBhVGtGA==
X-Google-Smtp-Source: AGHT+IFhI0/JA7jprOmtw2+D/ZgGi0FtUpueH2qezsAlbhu3t0Bca3EO3/REmwYGsQH11b1j/tgHLZd3UCRIQq91Tzg=
X-Received: by 2002:a05:690e:1543:10b0:63b:a941:90c1 with SMTP id
 956f58d0204a3-63f42b28a6cmr8268042d50.12.1761564479440; Mon, 27 Oct 2025
 04:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251024084350.252702-1-skolothumtho@nvidia.com>
In-Reply-To: <20251024084350.252702-1-skolothumtho@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 11:27:48 +0000
X-Gm-Features: AWmQ_bnr7tBjA-xLdosCLQmQwrzb33y_WPyCjqWOt-OWzaKBeJHlADY9T_Js7f0
Message-ID: <CAFEAcA8SAQO0frmN-rK6zp_-fEGXLefAXAxHmT=LASqEL-UU5g@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system/arm/virt: Document user-creatable SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 nicolinc@nvidia.com, ddutile@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 jonathan.cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 24 Oct 2025 at 09:46, Shameer Kolothum <skolothumtho@nvidia.com> wr=
ote:
>
> The virt machine now supports creating multiple SMMUv3 instances, each
> associated with a separate PCIe root complex.
>
> Update the documentation with an example.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks. I have some minor word-smithing tweaks, but I'll just
apply them to this patch in target-arm.next if you're OK with
that:


--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -224,23 +224,24 @@ SMMU configuration
 """"""""""""""""""

 Machine-wide SMMUv3 IOMMU
-  See the machine-specific ``iommu`` option above. This allows specifying
-  a single, machine-wide SMMUv3 instance that applies to all devices in
-  the PCIe topology.
+  Setting the machine-specific option ``iommu=3Dsmmuv3`` causes QEMU to
+  create a single, machine-wide SMMUv3 instance that applies to all
+  devices in the PCIe topology.

   For information about selectively bypassing devices, refer to
   ``docs/bypass-iommu.txt``.

 User-creatable SMMUv3 devices
-  Allows creating multiple user-defined SMMUv3 devices, each associated
-  with a separate PCIe root complex. This is only permitted if the
-  machine-wide SMMUv3 (``iommu=3Dsmmuv3``) option is not used.
+  You can use the ``-device arm-smmuv3`` option to create multiple
+  user-defined SMMUv3 devices, each associated with a separate PCIe
+  root complex. This is only permitted if the machine-wide SMMUv3
+  (``iommu=3Dsmmuv3``) option is not used. Each ``arm-smmuv3`` device
+  uses the ``primary-bus`` sub-option to specify which PCIe root
+  complex it is associated with.

   This model is useful when you want to mirror a host configuration where
   each NUMA node typically has its own SMMU, allowing the VM topology to
-  align more closely with the host=E2=80=99s hardware layout. Supporting m=
ultiple
-  SMMUv3 instances is also a prerequisite for future accelerated SMMUv3
-  support.
+  align more closely with the host=E2=80=99s hardware layout.

   Example::




(I deleted the sentence about SMMU acceleration because that
isn't upstream yet. When it lands then we can update the
docs if the version of it that lands can't support acceleration
of a single machine-wide accelerator.)

thanks
-- PMM

