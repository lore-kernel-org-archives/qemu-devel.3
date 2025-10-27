Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F4BCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDN3j-0007oN-DA; Mon, 27 Oct 2025 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDN3V-0007la-Ac
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:14:39 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDN3O-0003Sa-Ds
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:14:36 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63e1b52b452so4902249d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761570862; x=1762175662; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UzLCfnD0X6+PLKZ84lv7cfbztSnyOCgfU/eKNL0xcsI=;
 b=jjsXQewQk99fa7wVrdXHxAwVA80uuf/49kZhZ1N+OH5i3ibUwApUyV5ilIEMyYTi4o
 u46WqfGObnyxgA0jD7CcFGJFvdSr7AS44BIL2hUfb7y9eBHW2brCyC3WDWgP/GKRIIjj
 2IS2hHLZpQYcJRW2o1IaiIQJDrLtfMGj8rNFx5p0mPJV6Zo6L2n7QY4BCMwnafvwr64s
 IqBhmJpWfzb4clOuGp0WZODSFCuIU1hQkcz4m0RnBhmOHkP8G5GQeLlc3Ts3ogGe050x
 pHYxhODBs2DvBSBKNxqiiAna+wpEnc3zAYFMxSeaHdBIKrNnX37OQ+beJlF7P2S9qA/u
 R3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570862; x=1762175662;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzLCfnD0X6+PLKZ84lv7cfbztSnyOCgfU/eKNL0xcsI=;
 b=Ms7gCJbnmajNn7xqEmMPSxKUUWt+Xy8X1bhz2RwbSxkuNQH6P5Yi+uIBYj01Uk5wQh
 upV2gFJEuC4q6OUmBzFEj4JSQjgjLQlrntOg99AAVd3G5MAa6Tow5nalK1Lul5cQ05GY
 QGT7xxPTpWdYfrwdiIHKd+nQ4TlNFw4+dufLGEW1mz1ztu2SmjDYRz0Sa5rKLxaitJYl
 HCyEyUuXX9VvyzJhc3UFSLdYjoeCDspvzsKDgOkXdtQ4cjeLOrjISuGWRkWjz66pMIPs
 JpDuve5G8XIpfIuypKWtM2WP3ma6hkFjiac3B+GsUthWI6hbP2P0spWtvZobPoGThrgJ
 eGNA==
X-Gm-Message-State: AOJu0Yyvv3uk/Hmkr/cwLaQ0TiMzS0o3uOKTWhOJQjdnGS0Kn49fswn5
 qNji7SE3tWqfrPbp/PYaBT3zy79retZi15d+Q45+XXawr/T/SyeDgwPZvUuVrsDStxOLZWQIgrV
 1FhwrI5BOp8/A1e/2tw2KMOfKS+uUDqlulbWO83/Umg==
X-Gm-Gg: ASbGncsESSpeEplh8M49eCujRSA9VMT1K6HcHF9aJBTZP8Qzgar8ewC3FYKQsE92zj3
 CrfOJQIaC2THir8dYroK3ehz9mHZCdkJ+Diku5gE4QUYFl/KZe6N/jDg0+vGrHOM41TrDEYrhzd
 Nbm6GAbqX5AKe5exHUIeaSxACfzwb37GLmb5t0LIXx0ssNGbNL2aDOLKuKkSZlIp6fECdZfG5h0
 p6GM0o/GpE6XM+CUfQFlMkkcomCo59dfZoq79P7ueXSgQpUDRj52XbiZoMoznfkYwKLooo8
X-Google-Smtp-Source: AGHT+IHFTCOBgHZlejUYGfKL7gyyltAulWYxbj80OI7496c/O3xYaNPWpObCXMNz4W322Up9m83BcbX+KcQRmxz18GE=
X-Received: by 2002:a05:690e:258b:b0:63e:3099:df54 with SMTP id
 956f58d0204a3-63f6b9d0dfemr27403d50.20.1761570862394; Mon, 27 Oct 2025
 06:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
 <20251023121653.3686015-16-harshpb@linux.ibm.com>
In-Reply-To: <20251023121653.3686015-16-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:14:10 +0000
X-Gm-Features: AWmQ_bldvJdlNLKveZGocWKnG0gT6nrmNGJSJWIDva_YcKnifl5pMT5EVCWPy0M
Message-ID: <CAFEAcA8qbC-1LhHXxiYXZjiCvstch1UFtMNxGdR1fquLB9i2PA@mail.gmail.com>
Subject: Re: [PULL 15/32] hw/ppc/pegasos2: Change device tree generation
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 23 Oct 2025 at 13:22, Harsh Prateek Bora <harshpb@linux.ibm.com> wr=
ote:
>
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> We generate a flattened device tree programmatically for VOF. Change
> this to load the static parts from a device tree blob and only
> generate the parts that depend on run time conditions such as CPU
> type, memory size and PCI devices. Moving the static parts in a dts
> makes the board code simpler and more generic.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/383891fc2696609b27d2de9773efe1b4=
f493e333.1761176219.git.balaton@eik.bme.hu
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Hi; Coverity points out (CID 1642027) that this change
accidentally introduces a memory leak:

> @@ -780,7 +675,10 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d=
, void *opaque)
>                                       pci_get_word(&d->config[PCI_VENDOR_=
ID]),
>                                       pci_get_word(&d->config[PCI_DEVICE_=
ID]));
>
> -    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  =3D=3D
> +    if (!strcmp(pn, "pci1106,8231")) {
> +        return; /* ISA bridge and devices are included in dtb */
> +    }

In this function we define at the top:
    GString *node =3D g_string_new(NULL);

This change introduces an early-return which does not free
the GString.

The simplest fix is probably to declare node as
   g_autoptr(GString) node =3D g_string_new(NULL);

and delete the now-superfluous g_string_free() from the
bottom of the function.

thanks
-- PMM

