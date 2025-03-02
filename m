Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55EFC19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 20:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toqD8-0006qO-B7; Sun, 02 Mar 2025 15:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1toqD2-0006na-UN; Sun, 02 Mar 2025 15:46:48 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1toqD1-0001HE-Bv; Sun, 02 Mar 2025 15:46:48 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abf4802b242so291929566b.1; 
 Sun, 02 Mar 2025 12:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740948404; x=1741553204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kdcd4RXFyiStCTqm54RuatpYjBx6eqFMkIpMCno5Uzo=;
 b=D6+J5ybYEGx2AleC80djoaLAIJuJysJptIUvYybN2dj28lmgyfSUh0EwHBAb/W05dt
 6ZPbAax0Bo8pZ4bUVrggPxEnEnW9HtPd1X7PdjmCpaGknH596pw6540Xg2zuYOafXRvQ
 fEsq6SAngqlm5C88jxurXRVBWhW+nUQnRg6TZWmc5TP2PtCviDr7BkumgSWZLnj9InPp
 eNRHwBROXX4UesFdz8ji+NNQ4qpEBgc/CkzN6qaigKcTlPesPRWiALaNbL+zFt5/zuGg
 ubU5hFtqrYklWAuSltlPHfyqZrakdTImLSGFzH19FRAKRaGTe+MgmUd+km+PKNuCvoDb
 Zupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740948404; x=1741553204;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kdcd4RXFyiStCTqm54RuatpYjBx6eqFMkIpMCno5Uzo=;
 b=hvrnnLamzBHPnNQDsNpDJCtPUts+EklhEyJ79JM+9oSE7IBq5ZESCkVy+djz/tgCgk
 YQuk69g2kvsWnTnYtevR0oRNrTr1yc0uOqpjb7+gJV/iKqCLwn7gWyJrLGz8oL6CDina
 XKTLqOt54J9k34xSn7li7bps7oBfEYKELnGtMGOaBsIMzR2+Ug0BFylmgMAQmmeUgx6e
 pEo8MZqZGNQKS0Brqp4VzRmFBvKgb4rx3/zNZJNsl6cqpHXQ9S98B/mvEehseTtnBqcQ
 U9ftXM8YZmngxiImY1P+TkqS+Iib3/+MYhHre6KfhADxCSEe9oG6bUN5bjF0Fgf3Wmlu
 7i0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxWtsV+2t11BsXnunGkN/NJryTtxYSoe2n/6+tQ79ifQoA5JA7PTrkw9aHtZ0g8cSTTqRucG/3FQ==@nongnu.org
X-Gm-Message-State: AOJu0Yy2NxRjqeFDUCsWMLDS/HY6azgyuKL3Snezb/C1GFGTarlFv1PO
 hxi9vgfGY8GAWg0iSrTcUj2KqdQ3v7yPj6TX3WSW1oCOUNRHnZk0oQBeRQ==
X-Gm-Gg: ASbGncvncnl3cv4REvLnkASMZXGAyCQUzMIqETPGyqKIDE3PwwGf/rqryQTkx0UzPso
 TN8rizy58e+0rRvHpxwMntO+Sd/GFkjvyssmBjpFIN+qWIP0ZYNgb/xdnc/L7UmDpEHOCxktYpP
 uKB9YL/EFsDmJM7KUrK8mWUDQ2y8U2ZKuTkJM7+bQMC2Mq2scHrwOD/ZlmRz7haUqfC3HxSImxx
 i9vDw9Gry5huMnLRe7kEI3f74co7O+Omu7jibSeKDQKLbtlyqpJMzLmWAhRVnwAYMfmNr/TFCJg
 eeJyjWlJ+YMscZJgjOsJwY3G7MtQBQbcJJorc73fDD/9oNoDWpsgIBUo9elr0tsqN5VkkFPQylx
 S0aDdDxeDTmre+MY+AJC/aDrKv8Jnyb8JmiKmXunEsDfQRZgmyfYm
X-Google-Smtp-Source: AGHT+IEEuLVmNMFxNiYvBihuLnNzZDEPIgvLNdoz1G2x3nVgD16NQ4PZpmVICEU0l3lUayVnEM6JJw==
X-Received: by 2002:a17:907:6d0f:b0:abf:7a26:c47c with SMTP id
 a640c23a62f3a-abf7a26c669mr138811266b.47.1740948403968; 
 Sun, 02 Mar 2025 12:46:43 -0800 (PST)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2f94-9100-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:2f94:9100:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7bf82fsm696637466b.173.2025.03.02.12.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Mar 2025 12:46:43 -0800 (PST)
Date: Sun, 02 Mar 2025 20:46:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org
CC: philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/net/fsl=5Fetsec=3A_Set_e?=
 =?US-ASCII?Q?TSEC_device_description_and_category?=
In-Reply-To: <20250218155407.838774E600E@zero.eik.bme.hu>
References: <20250218155407.838774E600E@zero.eik.bme.hu>
Message-ID: <4D68CE5A-4E7D-4B89-8E60-1CA435866306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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



Am 18=2E Februar 2025 15:54:07 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>Add description and set category for eTSEC device so it shows up
>better in -device help=2E
>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>---
> hw/net/fsl_etsec/etsec=2Ec | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/hw/net/fsl_etsec/etsec=2Ec b/hw/net/fsl_etsec/etsec=2Ec
>index 3ce4fa2662=2E=2Eadde644892 100644
>--- a/hw/net/fsl_etsec/etsec=2Ec
>+++ b/hw/net/fsl_etsec/etsec=2Ec
>@@ -423,8 +423,10 @@ static void etsec_class_init(ObjectClass *klass, voi=
d *data)
>     DeviceClass *dc =3D DEVICE_CLASS(klass);
>=20
>     dc->realize =3D etsec_realize;
>+    dc->desc =3D "Freescale Enhanced Three-Speed Ethernet Controller";
>     device_class_set_legacy_reset(dc, etsec_reset);
>     device_class_set_props(dc, etsec_properties);
>+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> }
>=20
> static const TypeInfo etsec_types[] =3D {

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


