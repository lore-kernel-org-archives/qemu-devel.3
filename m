Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710A1CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOY-0005uf-Sp; Thu, 25 Jun 2026 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclOX-0005oy-FB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:33 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wclOV-0000Sp-VS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:33 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-662bb8b1f93so2621143d50.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782398971; cv=none;
 d=google.com; s=arc-20260327;
 b=Gqg2GotTUy309o/3snzy8tIEbvDwxxPXUocO6Kt0I4iQxXt+woAucJUd2+d5TOeb0n
 mQ91DF7J18MIKv70ClWaMNkYKoBM6LAbQfxCu8ztY5Iiv4i0il27YRk6nbyNqNM93bxU
 D/DIoRcNgQaAJPEVW8To6oENAb13Q4IB6TDtxzW0EtWVKgl0GYsXL5Qv9CS+8yHg4lRh
 FYLj5Iy72DTj7oHe5QTqZbeV1r3MVJihSvr4//DfWTnsMVHmPgBeSA3wQ5a0pKIDfSlI
 UPqHWgmd0guG+NcLtDELYqrw8tdgWuAJ9SluQ1m0ZmoTwPTjYjtMEgDiIF4TJCJO4ktn
 pDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rw0HfhI7BJOD+4UVug9ahXXlWhekFk0Jzb2lruLBVeM=;
 fh=waM909xNckwKm7pPQFH3nLBAWEC+k9YWzSA1XeTt6rM=;
 b=C2F8SnEnrxEB8xL73ay8aTjJGQmsmFgCUI9GSAbwAKnjfY2dlAVO42ArfhPcPYAIXU
 Wj6pQUne+jmpmIoDrD5yI+R87ezL5i7cYukFEEaYitaI9Zvpiu89kqz58q9HiQm/oUor
 cWABQLnf+89HNvXRAvYiSFYpHby6RApkWCmzCnHmVXkKJtZN7rv25K1QqhPQWtTLnZ9Q
 fgvQna2DbTbYqJeuLdbgP13nRscQsnm1IVW6rejpl0ONS8e62Nx23eVyrJMKWOstgZ4e
 qfF8mAquVUMgtgBh5fot1KGiWyUhP/VpWesYWnVwX2XGaZ8Pzj8QZzefpImGHL+eiNHr
 OKAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782398971; x=1783003771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw0HfhI7BJOD+4UVug9ahXXlWhekFk0Jzb2lruLBVeM=;
 b=CGI5nKud5zkJLghvEknCZZUPVyskefk+khJccaOKsSS1dsQoH9Y7Lp4Oh9C/Ez8Hf1
 2aPFe16iH+RcempJX9MTN5Ipqk9o2hIpQxI91OQS3jCt+7zg3qKzS8FnT/bqOWME9e3K
 MJVrqUV3b7ikmVLhKKQupeLwbGAV3CG85lMSkuB/9LLbBq0nDyKbVhg9oZvkFYABVMtT
 uBWlypu2Gksh8CAkeO1DIOtC+RSaaaEDRZPWX8URAqJJhIBuA9q9seIlHoZfVOE2tgWH
 ItbYOJS/WnAyz7HdCNO0TCJxvgtBFWuY62ND21xih38HzmtF1uQ5eY7OLCLcSgcG8O78
 6QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398971; x=1783003771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rw0HfhI7BJOD+4UVug9ahXXlWhekFk0Jzb2lruLBVeM=;
 b=NEQ3FxDuyqVZyHHEsj2kcBmg6rk1acLV3YkQoNieWehc12FQEBV31f96/Ri9bl/t5r
 OQAtX3Dek7XnfOzU/mbkabb9awtc6Lqgz1cGPej13cvOa+TG03hBX52i8QgJSoWj7Gp8
 a/BgzOA0PrMiUD2p/q3adO9NDLGcUiN7UODhugBhGRL8pwrSkWXXL4ycjkZXvXec6j35
 JogJKIz0DN3ybzKrrIQdPuNJaeQST1RLlaNHib2StfVHWe14G+wdulUwgVjGAroPOga/
 +yF4WKUKc6t+SRL1IYszYDTsNT0/LW4hCaIc8RQdwoZRCCKxpmQMPPe/Px1Nazuk1zQR
 8HzA==
X-Gm-Message-State: AOJu0Ywg537ibQbgIrwy71CHlbsVOrb2H5m7xJpUVYqBTcB069UStHGw
 MUl0D0E1pxvzt0VUaxvEHIu3RsipOQcWtElS1xyxVPhqW+agMtRFMsuVYoqm9NVsYhgvuhz08QJ
 jHdmyyGrWjZkFCVVwp4/63ILqN4pF1RQeHnBHj7spDA==
X-Gm-Gg: AfdE7clNwSiaLOyuJb5rISU883jHgXPr0IuHVEFs9+GjPh5DobyNT5hgTrCGbE7kAdZ
 MYT1cue3BjxUQmEWBcMKoq2yL9mAdL5Xw8+kA7TnLmWSRCmLOiu17ukZ1LAokthZqO8VVxn9E1P
 WpBMj55luRMzfe48g/oxUE5sdJ4Byzm3mjq0UiJELEgUWIGz5fos9vMndZNqCNu6quCtkt1KEDT
 d6H9GGLlLXdvFVdfwYRmSxciBVoUa//+k7Pp/xvKoaLS9sijguifILawOPswPvVCTQ+UJWaPusj
 aBSd+b2PzqcjhudmxI+Gxkkcb6nLWtpqDUPNM6Cb1DetRzPQh7x1baVu
X-Received: by 2002:a05:690e:1686:b0:662:c587:4351 with SMTP id
 956f58d0204a3-66487e02aa3mr1957554d50.55.1782398970624; Thu, 25 Jun 2026
 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1782140438.git.matyas.bobek@gmail.com>
In-Reply-To: <cover.1782140438.git.matyas.bobek@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 15:49:19 +0100
X-Gm-Features: AVVi8CemKf_lxAexYgtSsYH1dl92XnW4W0vQgF5o42uyydlYUN3ajK12BHWnobQ
Message-ID: <CAFEAcA8NPX2uARh-OriY8geKB-a67A_yc3LGCLB7G=-NWDG+WA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/arm/sabrelite: Add FlexCAN support
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>, 
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, Andrey Volkov <andrey@volkov.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 22 Jun 2026 at 17:08, Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.co=
m> wrote:
>
> This series adds emulation of the FlexCAN CAN controller, version 2,
> found in NXP i.MX6 series SoCs. The controller is integrated into
> fsl-imx6 and the Sabrelite ARM board.
>
> The chip has two FlexCAN controllers, but the Linux Sabrelite
> device tree enables only one by default. Linux kernel with both
> controllers enabled has been tested to work properly (using a custom
> device tree).
> See docs/system/devices/can.rst for an example of QEMU command line
> invocation.
>
> More information about the implementation can be found in my bachelor
> thesis [1].
>
> Changes from v5:
> - fixed buffer overflow due to unchecked input in
>   flexcan_enabled_mailbox_count
> - rebased onto latest master
> - Link to v5: https://lore.kernel.org/qemu-devel/cover.1781111270.git.mat=
yas.bobek@gmail.com/


Applied to target-arm.next, thanks.

-- PMM

