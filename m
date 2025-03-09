Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B307BC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC4x-0005M4-Aw; Sun, 09 Mar 2025 04:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trC4I-0004p1-S5; Sun, 09 Mar 2025 04:31:33 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1trC4H-0001PA-Aq; Sun, 09 Mar 2025 04:31:30 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abf45d8db04so494220566b.1; 
 Sun, 09 Mar 2025 00:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741509086; x=1742113886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bw/UdLloc25XSKtFzgJIxRsEEw6Y8ybT4ArThY2gBs0=;
 b=ly/LG7BB3uwjmGD0v6EzLH6GrcbSl6jaEge1un55zU/OaBwKltwXeKL2/7ia1XBz5L
 Jq1X7lAzBAk7FiwnK9Wgu+gtpo5DbfzUqczsxLjsPt/GWJfnvdcSp7WWueppkcylQYH2
 P6NJSJmWoe7OkUvq9VdBESXbFBY9kTxUGQcm4j5MTAfnrBVWWpUWdQvAiy5uOqArWHyR
 3+MNun+qXvlaSRzpDPgEWH5crPjbGhxVns5DZgArVgqkqVscNANNOMBgbvOu407ekDVA
 q4Qf1cW9J3f0ZJQGCwvurTDYpPt6otEr6bX1ANPNRU+ULnAgP1SSAaymRUNweG5xWjmp
 v2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741509086; x=1742113886;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bw/UdLloc25XSKtFzgJIxRsEEw6Y8ybT4ArThY2gBs0=;
 b=Hk+EWdk6pbPaA1EE1AugtETfilKOq9pgsmvWZD+zfkBaGr+lLgBd7lvVKfmzfY4b28
 4ZeRw133KvX+EJigK7YKtFx8xYzouL+lcZyn16mbTTsn2K0ssoYFWhuNsNAOlK+tgutZ
 8b8pqaedGCjfqHEtPQ2LJRRB2Ngkq61tjVuQB60fvFd8Q0VD5KpWqumvDmE/Y/WLs7O0
 hOc8KH58gBL4/GlkhcUnWnheixJ1+FOxDTw8G7CXRYJhJJKgFROfDF7uuCzteTFfvdd0
 Ae1JYet7zexS7nuJDnLg/SZDDAoSXsBuiXouiFBG7HYPQXCuFGSfeqzUSejbZ3qctD/q
 Jlrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0c7T6UaoxVi2ZWKNU20yVk+bAMrSZpl+HqXrMzJIiQNmaTmKgrHDY1jtf1CCnDl3PFTB182zURPQ=@nongnu.org,
 AJvYcCV7JpY1VMg2T93DFaF3rhvIdv2cGDO2XmI87Tr83BhVkySnuSlb8wHgPFw3hukvTB1espUqpwbAS3m5iA==@nongnu.org,
 AJvYcCVPn7M2iG4hxmyc8M5gMUJLqud1YmjvqrhudZQmxbmn752H2Ea4EktiQ4Y0q2iA20V5YEQkeMYfZjWEYw==@nongnu.org,
 AJvYcCX6b30P6lfh2SlxEsBeQsCGj6wZfg0jKMJPitXucEP2sYmeJPEt99B8IzqBmK5t+NHCzVsk3cebEA==@nongnu.org
X-Gm-Message-State: AOJu0YyUFtUW3a/DbLf9ACArgYAja+Ft1WgxY6ZmE9YA5ouleSwaBQbG
 84NtAD38fJdhtLnld/ri4s3Cnt12BflbgAkrkg1Y3x4SJkb+WeoM
X-Gm-Gg: ASbGnctW3LRh4x4B9OVCRfsWyqq0zmZ0K7ZCgEmrv5Mvnz1xvOaaFFtx21k4Fe3nXmW
 0POss/FWjoQ35LtFOK1RuTAJYP4by2l1lrDQUDuGD+jyqTiWeYd1Su146zoc7dr5o3L6UuWdXHL
 GeIWMCqD3xlAy3bPI73mKzwRpTfDYtst5R3mhb3waXlUW3j4DzyHg8Bi5x6Rh86FFFwJFU3DnGi
 LFcDaso9aoS9p/aVjkibXKW0RIXFVUA010Wx8UdaUaMgb3dCPUbhmkuPh6FLz4EydESRrUjaiur
 1IeMaesS3SUNmPxhNKydiWbzp2q91vSPbTqiPaOciHORq+/UwJfbfiXp0hsUjQiQgOFD518yJgj
 invvlwhk5j+xAH2Ufg6jqIdH0e7EJw7dwaPS5gm+n0qW5xVssJf/oNX88jvE98z0=
X-Google-Smtp-Source: AGHT+IGi133NskoYmnKIlIAzBNcmLVjSfh1evaTSxc7QnZ7h4UmR2hWEKx2Tf9pQJoRW9RoC0K93dQ==
X-Received: by 2002:a17:906:b39a:b0:abf:7a26:c486 with SMTP id
 a640c23a62f3a-ac252e9ceaamr904557066b.40.1741509085648; 
 Sun, 09 Mar 2025 00:31:25 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1a10-8c00-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1a10:8c00:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac254b805f6sm410824866b.88.2025.03.09.00.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 00:31:24 -0800 (PST)
Date: Sun, 09 Mar 2025 08:31:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
CC: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_14/14=5D_hw/ppc/e500=3A_Rep?=
 =?US-ASCII?Q?lace_generic_SDHCI_by_Freescale_eSDHC?=
In-Reply-To: <20250308213640.13138-15-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-15-philmd@linaro.org>
Message-ID: <6C65764B-E579-4361-94B5-5D217363AC05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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



Am 8=2E M=C3=A4rz 2025 21:36:40 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>As Zoltan reported, some U-Boot versions seem to expect
>correctly initialized registers before expecting interrupts=2E
>
>Now than we have a proper Freescale eSDHC implementation,
>use it=2E
>
>Reported-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> hw/ppc/e500=2Ec | 10 +---------
> 1 file changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index e85e000f054=2E=2E7d15c926887 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -1027,20 +1027,12 @@ void ppce500_init(MachineState *machine)
>=20
>     /* eSDHC */
>     if (pmc->has_esdhc) {
>-        dev =3D qdev_new(TYPE_UNIMPLEMENTED_DEVICE);

"hw/misc/unimp=2Eh" include is now unused and should therefore be removed=
=2E

With that fixed:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>-        qdev_prop_set_string(dev, "name", "esdhc");
>-        qdev_prop_set_uint64(dev, "size", MPC85XX_ESDHC_REGS_SIZE);
>-        s =3D SYS_BUS_DEVICE(dev);
>-        sysbus_realize_and_unref(s, &error_fatal);
>-        memory_region_add_subregion(ccsr_addr_space, MPC85XX_ESDHC_REGS_=
OFFSET,
>-                                    sysbus_mmio_get_region(s, 0));
>-
>         /*
>          * Compatible with:
>          * - SD Host Controller Specification Version 2=2E0 Part A2
>          * (See MPC8569E Reference Manual)
>          */
>-        dev =3D qdev_new(TYPE_SYSBUS_SDHCI);
>+        dev =3D qdev_new(TYPE_FSL_ESDHC);
>         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>         qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_BIG);
>         s =3D SYS_BUS_DEVICE(dev);

