Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A711C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9q0-0008AW-1t; Fri, 14 Mar 2025 14:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9pw-00088V-1p; Fri, 14 Mar 2025 14:32:48 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9ps-0007gg-SM; Fri, 14 Mar 2025 14:32:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so634119966b.0; 
 Fri, 14 Mar 2025 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741977161; x=1742581961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=owSHC0s3QPx0SLb3xaDF6tuKeYSyEsNCk1P2bbtZypY=;
 b=AQFmdElfH7t2MR5E1YZ4mYK935DO9+Jq2XCsoI+t45ZQ8LCMLQt+F5vL67QUAuhpwH
 Lv0/kDh/NIeyNCPBeaiAHI/PvbidMdPunKgqp60lSdVJD3AIkwKKzL/ZDf295n5q2hea
 B+vlKTweNF0I989edkfJJIwadovrIVfd3S0zs3v3cfsyUvf5qm1JJyTXb5b2a1fGQ1BC
 Wslc6dI+tgdZ1WAuUK72LFSBc5B3C7Sz8lOuZY4/JAqomj0jI7OwW6bdkMSEeM0zSQIi
 TKyO52l9V9uLo2QN1cqYX9Q6zrGoY5nXQPEkZ5E6TAFUH7NIzqPjGKS7joWylTbWm9rF
 4Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977161; x=1742581961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owSHC0s3QPx0SLb3xaDF6tuKeYSyEsNCk1P2bbtZypY=;
 b=ng503ZzOhewZsu4pb8GABArC/sE4qyGVcNJRCB2kPKS0h1VMHD3HYAuuMCRbR+9Q+b
 c0P1bUHcD6fHfZbY/hZuroGeqMyoEyydpkuxqSr9uiqA4/LBFlrettyx1ng2u0SdUUNk
 wQa2b+qtx7V6wQZIIkt1HItQ5CY/Us5Xbrc28aCwV8X1OYY5UVoz2kt+Q0ilDhVc0IUi
 MqTIufjk/MRk3K7DwJcuHSALQSbFnqXoUC5WqxLyFFarSwvMmVa6rlkIv+1UsUPYiA6C
 O2x3nUKD4AV2oNiY5rS+YPkoFEt4ja4mm7moezWH3k7P+Hq9ZvrPFkSQtLWjM6KXYY/S
 lmWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLAi4mgCotjK4x/TCmOE+qMvJrVRYZ7iUSR6RCLxkP/yX7j4Hg/E9GU6SJqDxSFCvAxopiN+qbHw==@nongnu.org
X-Gm-Message-State: AOJu0YxtC1lVote2+G+9qz7RvfAyhLJLNxIfKUsArG1rj8OpARHmZDp+
 e6GAgbKl3HLynTNor0CG3OdfCqvG8/U1GYmAJ3sDnUJNjw71jo1mUMjQ6w==
X-Gm-Gg: ASbGncsIUf2hlC3pM0wtGb1qs+wQnDhp65Qy/+z2/mqKX38ftPEXJ6/WJqZCRemQPDM
 UtDNhQutVFpTk+JWlE1JeEJLxvJ/yjk2hOexq/YX+42ox27YyyRs0MOJfA7jgSwbBReBksTXRxR
 0Jwcp738qQY4Qbd7dMUPrHzIvu0IRaDP5HBPtn3gqD0cKyoTMpHxgV2rCQxK9DtNkXh7VIrjvwx
 MakP004otTJGrFLS8W3N8qotlSS2EWH6cDimbIMrq9TuZf+xqKfO8pwRLqeb3vig0/I2Z02/ptI
 N8n1u3tUMk4Rib97wIdPRwKmpjaijMnwXKngHYpl7yed9kO/CEuPHAfJwHgddGgucfADjsmuFjj
 XBtjkJL77DW7YdD7uQzT9LOvZBIhi8dj4naGjMYT2XCHEFra19lu2ftFZXFWqLpRJ
X-Google-Smtp-Source: AGHT+IFd4FaTn545QqLX3bn8qed5+BIPYCfVW+EvVUGJcbrRLuQZ/sgqkwARf7rTaTZBXz3sphlWBg==
X-Received: by 2002:a17:906:c147:b0:ac3:d1c:89ce with SMTP id
 a640c23a62f3a-ac3313056d6mr349067166b.9.1741977160878; 
 Fri, 14 Mar 2025 11:32:40 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1ac1-f400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1ac1:f400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f0ca7sm262104466b.60.2025.03.14.11.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 11:32:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/2] i.MX 8M Plus EVK Fixes
Date: Fri, 14 Mar 2025 19:32:22 +0100
Message-ID: <20250314183224.21822-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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

As discussed in [1], this series modifies the SoC class be derived from=0D
TYPE_SYS_BUS_DEVICE to fix the reset mechanism and to prevent it from being=
=0D
user-creatable. It also removes an unused define.=0D
=0D
v2:=0D
* Do not set user_creatable =3D false; (Zoltan, Peter)=0D
=0D
[1] https://lore.kernel.org/qemu-devel/1cdb6643-8fcc-4bd8-93fc-fcc93589c9a3=
@redhat.com/=0D
=0D
Bernhard Beschow (2):=0D
  hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from=0D
    TYPE_SYS_BUS_DEVICE=0D
  hw/arm/fsl-imx8mp: Remove unused define=0D
=0D
 include/hw/arm/fsl-imx8mp.h | 4 ++--=0D
 hw/arm/fsl-imx8mp.c         | 2 +-=0D
 hw/arm/imx8mp-evk.c         | 2 +-=0D
 3 files changed, 4 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.48.1=0D
=0D

