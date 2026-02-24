Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D65E9B24E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqVe-00086U-TA; Tue, 24 Feb 2026 06:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqVd-00085t-7z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:23:21 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqVb-0003QT-O9
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:23:20 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad79df972so5191366d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771932198; cv=none;
 d=google.com; s=arc-20240605;
 b=XQcK2GptXoWHTblgSJJ/CNZDpv7mG4kcFa2owhIFfIyYaqQ8vQQc2TTXxndVc8i6g3
 R8Drt2sxg5X0L4xIkjiEikcW2dclXiNwz5tSNk/Wg/aadxTJHSnDJdPehDkzs6dnu2t8
 ZYeY5w5nX51v9tU7+7/KIBc+JZV/oWsRIDEd9U4wSqkryE1OLCBRvPXGPaIli4t4wu1K
 LVdzApsndpSHz784v62j5SL12TV+VHEPH3d33YwTDgiJLJF8ueVRCI29wTK8+6m2TZTa
 3Aw0lFdr2/G1oFB+9YzbhF4q284ZnEueZoKpt3OZcbaPwCUQguivO88Nf6tO/1z0YUyB
 JDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gPNIaGczoKm6TqN06zgo5LuM6yHZBKuS80qJ7rpFt+U=;
 fh=ST6Z/4gOJCkkIGTLgolqD+0YY9YU8p2GfIs2yEr0NyU=;
 b=buubzi5kCZ3VM2C6hAilLmtCUCsT/wDWY9NOVO1NzZ6QWbhed2QPMcTXY/RUmEkMWe
 wkGZCfSyeI4IqO9qxXzLLBq+WVSgfwoT2sO7WQ7xqnEL84mLUUhaig4bA/5gjraLWRns
 7QJbQCB++lglMTuDb1DvwIx16NtWQkS8+F1YwWJ5VNMdHKwHlr+oH1vUczKprnSWKPsH
 N0lZbVQW/+CD5FfcrNHmuO8dZdvESa4DfsLieonIbeQkX0bStS1ijLjH08a2B4wPeZV3
 wq8MZUTTqxI2vXYMgFSSxLYKQX9jvmg376+qlwzxY1t+QRhicfhHbEFKf83znhxCdR6q
 acgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771932198; x=1772536998; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gPNIaGczoKm6TqN06zgo5LuM6yHZBKuS80qJ7rpFt+U=;
 b=b4sAJFmwawjRE6xBRgMOB6wR1DAQZ4eTYBFiIdaL5Zo8oDIdMMnMxTvlYSp955sjXi
 8KBMyWnmHVcxtE26V08kiKu9l5As6A1IDe6M6Q5Nz+eTCi5N6rkquF0v07MpTjUDkwrS
 Vlcl0zk8FAFfzn+/ESpPRgitFhrYC4fT8//FVxMFU0QjG6ZV6V8eQpEsOuerJRO4QPfC
 BZ0LcaT6796WN3LEUqPb+1W0B3S8XXeRon8SG1+Ailidip9bxNr6oVPFiSv5p95DlvIe
 KjzcZVrYkyj1sbGu5iREBzcK48m0QN0HzV/tXcRSgjW3QpyY+6GOmTs3fIQshu0c1UD0
 qWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771932198; x=1772536998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPNIaGczoKm6TqN06zgo5LuM6yHZBKuS80qJ7rpFt+U=;
 b=iTs8eItxOt9KlUd03FB0HfsjI9wt84a/32EeLi+FMom27EIKbF4SiPQErNs29ke+Gm
 y93H4g+fLYvVo+dyFSxjZGGemLuDpStFaW/ypNJMP8cb94RFpNRol5xOzlTyg+ZTYGf1
 ywEcP2HtRav8d7tLrT6nguG5RrpnsRHvx2NBe9Hd73+BJQ41IuxMSO1aXtk7iGz48uyJ
 l/wX8pjOZh/2eOUh/IzyZc6QAEk52bzs3AvrUkzbdiIl3D60sx05nSt4VRBav6K93yQT
 PGHwChJujGygrF6xxEtdPrnKBWs7E+CGuxVLgpSSoj29ut5Ie48MK9IEjnrfN/GRa8ky
 2HfQ==
X-Gm-Message-State: AOJu0YzlKtar1Pw4oBz+qcIxe+L9A9Lmtp55n9qptY5tw3izpnFd7eRD
 AaczFMgW4kQEZJ8vakoMv2mu0cftAdj1WbivmU7hKDLTpIAm9VXPhGBfEBpWDlYyINRpQP2HgGK
 8MLDs8EQ1aAFUFjk2ieRB3HSbOtrJ4FOFApWNUtheVg==
X-Gm-Gg: ATEYQzyk/6NQbVqIfe1vHZPrfez2lnArM+HNEjdcgR+K4I/gSQIwIn7UU3Lv/h0e6xD
 DuOC3qkKaxyzCvh24mCypIKzfcPyA2Sgj2MWD/JAV+yJ4/AZuxUC+WX5hcICra06Niafnqm0JWV
 Hj4V0T87Jt0q8vYmImwvg6wejl2DfnR9/vKu9KXf8d+kYUC3WWMR4axf704CTW8sS/s/jtNkNHk
 WVrixvQXOOdFmKnKyidX8w4jAjygoxR0pzEtjQcklh8PRxuaK1mITh+f/RTgNtmhZBNuOHr4zjH
 GqlbULGCF5bA01Y5Ooz+iv6NiDp0Pi4q7oU4C8sqf8s4ybBVMDzFPUFYqP7wf91MAAttCOqDUod
 4cw==
X-Received: by 2002:a53:cb52:0:b0:64a:d6a2:c6a with SMTP id
 956f58d0204a3-64c790a0058mr7286471d50.88.1771932198240; Tue, 24 Feb 2026
 03:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20260219173256.152743-1-mbawa@redhat.com>
In-Reply-To: <20260219173256.152743-1-mbawa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:23:07 +0000
X-Gm-Features: AaiRm50eD6Qre34J8fKsjnMs6f5YhfQcUg41YGdrbOl6PIklpzKTnaAbjIsX2mk
Message-ID: <CAFEAcA-=wdJMrV8UsHPRqFQK-FqLAXsNGbocBAv_c3+cmq3CVg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/virt: Add virtio-mmio-transports property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, pierrick.bouvier@linaro.org, shannon.zhaosl@gmail.com, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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



Applied to target-arm.next, thanks.

-- PMM

