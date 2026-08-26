Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD66C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwm-0006TM-My; Wed, 26 Aug 2026 12:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwl-0006Se-9p
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:55 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwi-000342-La
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:55 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso159285566b.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763471; x=1788368271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mej/GOjOB4msaOASMQyySgYgxjyLTC9ytu/Mxqd0hKc=;
 b=jgB2QyxJ8h+s24JLkST3ukYhncpxaVjtZnAkoIRJttghSJjKVp3iA/E5nNadJ04Lma
 zJjZV/7NKF5EDVkKp8d+mquchOFP/4r+sbRFmp/njacMJKulRprGOaEXtZk63F/52Gz5
 XWcXoAVuMpkOt/ENubpElALklnFSntmGUJIWKagTBjK+zGcU37IlIRfpL/EDtBqkHq95
 EJtl9qPa9GdTQJ3MXnJ2AhwlmFHI6ucLQ/WIqjS8ucFgnXOcbvFXtnoRS8YQDcEkNC2e
 nQSwiZPmBo6ugMEZgJu9Q49Ng0P6e1L8g2ieBJ50jq6zNHtBwQOBCAmbVMdL9FijTTZP
 0wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763471; x=1788368271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mej/GOjOB4msaOASMQyySgYgxjyLTC9ytu/Mxqd0hKc=;
 b=dklxru7HzxLp0XKYwh1FXdYyzg0iMgHvFsMMs1/3xpCkPhp2bhZG4g8wNs4QT1d3P2
 Qa1UYEGTJXWrM4aq7o7Klefam3MEAfJAsteK9tuqOK+b2lJ5CQy4Id2CWJdS26Ixr4VP
 Dvoz2xdvMXV8SN4OfnZZIf6Z1IrnpgZR7lPQGP3g4UpLR/0e6rcz5DUb06lp+mv2kMzi
 u/BTPCpa89GF83luniLhOHwrwKtc6PgUGzdSOqs7E/eKR7TYwOyk/kveSwBF6vM+xnb6
 N9uIVeOhX3iHVZ2FLk4R9ijkq9gYzMTRBbCs5/AWC1vz/kEj3bRvR3g2/KEXQMJR3/Ca
 KxRA==
X-Gm-Message-State: AFuF++mtwDYlHVDugVEojBGCyL1bNJnd6eH83PuJvi+DaVc+wrNx584X
 CO0U3yUcFq2KchMbL+VID4K87QRHa4lJitMquZrQk/mfnLmWFOYpd6q9rgmK/4AnaI5cyvIEkHC
 9Bchl
X-Gm-Gg: AR+sD13lxZjAPtljSeZXkOl8UGOQJNywgV5Adb4Luf22iI7X08QTzr8jK40XtGcooVl
 7CFmjiwVPPBWku+meitx8B30l9roZ761szkqX4bryTzsakNyBNqbemUD/vdRKyNMM08O+RNCwZy
 69q4GnS/eFTEPK95g1tX0oo93DsDhalWV69lAmo/hNuIATusc9DN19P2+i5BiUKjkiekQw1x+xp
 /UN/Ww5DE0Bgu9zGJSH31xHQeWM7D1d4xVaZG2VBUxzxwgn3HL5mVY4yFIg/G87WwbH1cJQnCgn
 Oqr6JWhXBZOmIgsgJ06lgfQZwJ17GrO/kPd9Ha0/vLn9Mpu/BwNnhvGOpPJppwPx5upVn36Yi1p
 NZqs/+d9SV1Rxx5ahPmKcYbvFWUR2TLQqXMsfo6PdhfVLqwBh9lK3TQK5gILVYCw3qHBI8piByw
 EopGe4uuPrj1cPTp+NeqLu58ZQUSnkCO8y5khZ+pw3TmN9e3OXR6QKI7ox
X-Received: by 2002:a17:906:fe08:b0:c1f:e9d9:64d4 with SMTP id
 a640c23a62f3a-c250bc2dc95mr1065357766b.11.1787763470695; 
 Wed, 26 Aug 2026 09:57:50 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 0/5] nbd: accept a large NBD_CMD_CACHE,
 cover the transmission commands
Date: Wed, 26 Aug 2026 18:57:42 +0200
Message-ID: <20260826165747.3768674-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=den@openvz.org; helo=mail-ej1-x62e.google.com
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

NBD_CMD_CACHE carries no payload in either direction, yet the server
rejects any effect length above the advertised maximum payload size.
The specification explicitly allows the oversize request, and we
already accept it for NBD_CMD_TRIM and NBD_CMD_WRITE_ZEROES. Patch 2
drops the check.

The rest of the series adds tests/qemu-iotests/tests/nbd-commands, a
small client which speaks the NBD transmission phase itself. Nothing
in the tree does that today, so the protocol surface of the server -
reply modes, command flags, error codes, sparse and extended replies -
is covered only as far as our own client happens to exercise it. It is
useful both as coverage and as a regression tool.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (5):
  iotests: add coverage for NBD transmission commands
  nbd/server: accept NBD_CMD_CACHE above the maximum payload size
  iotests/nbd-commands: exercise the simple and structured reply modes
  iotests/nbd-commands: cover NBD_CMD_BLOCK_STATUS with a payload
  iotests/nbd-commands: cover the command flags and sparse replies

 nbd/server.c                              |   4 +-
 tests/qemu-iotests/tests/nbd-commands     | 269 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 3 files changed, 275 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out


base-commit: bde2492aace2b5acb755a5b057013e915163a77f
-- 
2.53.0


