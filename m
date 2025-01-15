Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1054CC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2BF-0007Ft-6m; Wed, 15 Jan 2025 07:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2B9-0007ES-3v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:23 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY2B6-00019q-9U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:07:22 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso113637895ad.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942839; x=1737547639;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lQFjdceETSD5/425OU1xO0n984HLA1NXTxp9H2BhyUs=;
 b=eghjLPDRlWeW+qISl6nkY5zzo4W3rOpgrGwgFvMXHHdBWX50ur8AG0D8Mj1Ra6GxnW
 9W3/KgOvxmUo4bfa/nxGw/u7cX2GdvsCGeVMn9QbQMzgktW7ZksUx7BOp6JodmG/oX1N
 3jbtxmzbEZYjNdckiMfKa8AAFbQCvtmQWiJn+fW9p6mjJxXa/ea+y3mLVQSu0Jv2PB52
 nYtRzZJ6gig7OJ/9mnPZ15LLqwf9AgNj1HvMvRmKIbtg87Sy5XZ0EV4QMq0fOHh03afg
 hDqo4JrccSauXksjm5c6bYMaGW71RgG80/kxSHEsws29YBXv9sm3FQ7yCYmBs2MDK3aS
 GB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942839; x=1737547639;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQFjdceETSD5/425OU1xO0n984HLA1NXTxp9H2BhyUs=;
 b=pMoP+m8F6meV4EIEBFKjD2rAq1owa2fu78iIFtykRGITblEYZ1vftcvj8KMXFe/bPH
 1/FWJht4UPLIDJJ9WQB9pgwFbY3W5dfQ2ZbMXTAdKP5sr3OyAxgLUWtiWnO8kRda8irN
 WOOQbFth+ldxLBl/uB4sIagiSqOwLPCpF/W6Z+7wQQJo8JsbYd9TqG49WyIe1ExILm7d
 370voQQh+bhQ/7TqlTQIVVmU76GJgUNlXYGOgTxb0jjIsPpFe57PGQv+Ih5wwvmEIe23
 vCcx83R/17tDvF1ijtxlNRrw8hi8zSCigQ7mC0+GKWCp7svM9znNHT8gKBAquzfCxq0l
 OSuQ==
X-Gm-Message-State: AOJu0YwvJnEvVykGl99B48GFOuVL2ZF0kOSk9+nfPQvcAga13oKeAcIN
 W9S9uAov9E5YKvi0BrOlmiw4Ip4tQ4H/qwLPpGrz7RdaAxAz2/wSR71U6JxWh8M=
X-Gm-Gg: ASbGnct5WwM9SrjDCSF+G5UIBBePlzeG0ydOz7tMJWHlU55vSPu+GMT5/lF1nzjj/HN
 RHiBITSAxBRWAXWKcMufHyUKSqPTBno5WaC/M7nElHFV96ytuXULjG6EyCFAxXhAfVpGAAeCWqG
 a/z666Dvaq0JnxbcgQSMo1HEEep/OID52Yl3ePMrjujf+rGcbbZAjv3Y7aOudXGvY6k1T+Hz75x
 l8Rm0gnrqkCSkc8hsbn92SvIb90XzJWoTkmUTUqe1PJlMOt9doAXCDwOXHC
X-Google-Smtp-Source: AGHT+IEmVXvMRM6d+2kh0FgdUNlYtks2Ym0sd+Sixrw4yrDPZaA7RhryFhkCKMBBww8dROkWRsgmfw==
X-Received: by 2002:a17:902:da84:b0:216:501e:e314 with SMTP id
 d9443c01a7336-21a83f54b4bmr426524455ad.20.1736942838859; 
 Wed, 15 Jan 2025 04:07:18 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f1386bbsm82295515ad.81.2025.01.15.04.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:07:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/2] coreaudio fixes
Date: Wed, 15 Jan 2025 21:06:54 +0900
Message-Id: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6kh2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwNL3eT8otTE0pTMfN1kSwsTMwPzVMMUi2QloPqCotS0zAqwWdGxtbU
 AhbnKU1sAAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series contains two fixes for coreaudio. See each one for details.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      coreaudio: Commit the result of init in the end
      coreaudio: Initialize the buffer for device change

 audio/audio_int.h |  2 ++
 audio/audio.c     | 24 ++++++++++++++++++------
 audio/coreaudio.m | 50 ++++++++++++++++++++++++++++----------------------
 3 files changed, 48 insertions(+), 28 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20250109-coreaudio-c984607e1d8c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


