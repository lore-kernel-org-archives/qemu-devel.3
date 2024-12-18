Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BAFE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNtDs-0003q8-1z; Wed, 18 Dec 2024 07:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tNtCw-0003je-KC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:31:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tNtCs-0007py-He
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:31:16 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5521989f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 04:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734525070; x=1735129870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ixAP0AO6/46cJ/jWuvmUI7KMqJXizbt7Hm42tv5K8WY=;
 b=LjhtCKD4REbLRcpUyIqn61/xeliu5Ls45x4YcKqfkUGTrdJRKM49X8nPiuu+Glwsvt
 8MffinxfdTOnn9ZWkcEtzjy/D27CSOphcWJSOKp+nAWZS14PrqSG/N4IQExIBiKVyGW6
 E06JGbiHnWTKVg4KlaHAftWVyNJ+zcGcXnQXEQLHBQggIij0aBh+E1yOlcJuOxGBLfPz
 jadRbz7SLy6FEzHXE2/b8F1Z70RtCOcdbxeHFP+CImkH1S8Fte4/prSBLUr7xcdg8zlk
 9qX3UDcVGwHlDmfDWXV8kNy9yclvWV8eHg1uH+CQejeJrYoNaNVYB/z+p3bA4wqXR/ZA
 sNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734525070; x=1735129870;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixAP0AO6/46cJ/jWuvmUI7KMqJXizbt7Hm42tv5K8WY=;
 b=rrjRKBYVUhlppQH/4wyEav/HRhD8FH1OMJ1CRw7yKh7l96V7In4FvLDwOGk6y4QMLw
 MUJ3MNQ9hL1Sf24MptnB6liKuN2XZdjtzsX+/Czm/q5dNHwpMfFdK4paaxyVy4u12qlE
 u/WTgFiJo/zHNJjcXOO+eqwQUHJy4meQKdwKPls2CAtXQMlAg6JT3WeProwoXrvtykQ0
 xF91TeRcvN3FM6UmW8XdZuvVRg5j/Vja/w+WP7p7ARNHwGCkGaxgYVgU6HULhv3TN64+
 u8toUcVjkzwtj7AiPAQAC9sD/1Hvs8nFBhReXFLAq/2TBCVk26L/J5UkOWcPSNVsOrwd
 /+5w==
X-Gm-Message-State: AOJu0Yyv2pHal3qv7JXBXBWO291Y5+WIE5wo9oArmUgIQlZa1Y+GubeU
 HDP4u7W6YSpx8XAbOq3wLdNkDwkZVs+WZK2fP/I0MTKKqSihPLgbDUUEGw==
X-Gm-Gg: ASbGncsiFlpUmNwVa349X1M0pY0juKrN9/kWum+10Zc8mgQC5bnFHPcSzXLZn4Lg2a1
 /NMApD6T3bjDMqcptL6xwvkOxJV5il9+zegYEv55zpqNy7DjsJiR9GIy+nR4QcUXq7eAu5nE6C1
 mh2xW1q3HLsoF6lcYEgYyXITPPI0xLjk9J7Iv5N251E7oBzMYqnyMRFRUxsHJ2uBkAC14gmzTD2
 1WjmblcrTU2Gz01mbE2axpMLKtMJl1dq1QH8s46ZAf48u4xzdqp2tacBX+RSXoWjEByQNsc1ttz
 pvFGs5XS08VXvdHI3mLYIQXWxM4WBItn
X-Google-Smtp-Source: AGHT+IFaFJoenALi29QHQ+yWUlCWzy0Dpcj+KjEUTYrGjWwKTsrjkIRhEfThVANtrbWa/kY4U1872g==
X-Received: by 2002:a5d:59ae:0:b0:386:3082:ee2d with SMTP id
 ffacd0b85a97d-388e4d8eb0cmr2102083f8f.41.1734525069899; 
 Wed, 18 Dec 2024 04:31:09 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-019-174.93.128.pool.telefonica.de.
 [93.128.19.174]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806115asm13811036f8f.107.2024.12.18.04.31.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 04:31:09 -0800 (PST)
Date: Wed, 18 Dec 2024 12:31:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/24] hw/ide: Constify sysbus_ahci_properties
In-Reply-To: <20241216035109.3486070-3-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
 <20241216035109.3486070-3-richard.henderson@linaro.org>
Message-ID: <3CE6C8D3-97F0-43E0-B805-23C048A81E3B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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



Am 16=2E Dezember 2024 03:50:47 UTC schrieb Richard Henderson <richard=2Eh=
enderson@linaro=2Eorg>:
>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>---
> hw/ide/ahci-sysbus=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/ide/ahci-sysbus=2Ec b/hw/ide/ahci-sysbus=2Ec
>index d43db0923f=2E=2E2432039290 100644
>--- a/hw/ide/ahci-sysbus=2Ec
>+++ b/hw/ide/ahci-sysbus=2Ec
>@@ -62,7 +62,7 @@ static void sysbus_ahci_realize(DeviceState *dev, Error=
 **errp)
>     ahci_realize(&s->ahci, dev, &address_space_memory);
> }
>=20
>-static Property sysbus_ahci_properties[] =3D {
>+static const Property sysbus_ahci_properties[] =3D {
>     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci=2Eports, 1),
>     DEFINE_PROP_END_OF_LIST(),
> };

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

