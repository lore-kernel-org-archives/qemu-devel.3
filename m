Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3019C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcg9-0004XU-GZ; Thu, 27 Aug 2026 12:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcg8-0004Wv-6r
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcg6-0007u4-92
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so12348435e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787847008; x=1788451808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iF5ga2tpXylLpY2GYV1QrkHGIJHHIciIhCJzpfwHipk=;
 b=rRP08nuwYtNEiXrnFJGZ7AeBJtaJ0jIJSMWghS4EEp7ZrIIsBGpkPQoGbVa+wh5fYK
 syJwNhYrH//UTIfW+aokp5psyM5FcdYHfIUriZM3E9VqlHTZakd+0I7KVhZMhnqUUpq3
 zGOLscTkfNxWBViYh7H/Q6N7xt9axDfhYmfEPkOlahPm3R7n9uXDUnmfR1TJPMaiIrS3
 BoD7PYdjTVAmBOcJJnccjz7PDjP4ZFn6V/XKhS1EcjLs3ehYRqRuwKShBCEp1qPy7vWf
 OeuyPJSbOzPFJ9GmGG9lswwcTVqnFz+gUdb54DrGEqjjd1lWqxWETztgQfUqOg/YY6X3
 xO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847008; x=1788451808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iF5ga2tpXylLpY2GYV1QrkHGIJHHIciIhCJzpfwHipk=;
 b=gPIENRi0eV9thPh7cIMyEvYke3k81U4ZvQJDMqGRWGIPdEpFsA+xEn2DXAAJ43HPZF
 66gG8kotZS17qC5ziblXo+l6wlCAgSuRLxOaSncJr2TVsnKVNAaSOjbUjOL47ef+Q/PA
 0fhWWZ0qqRgFUrVz73H4QNCHZr3tLmjP4P1Aa+n9nagZmB54qicjzCa5SlO5a3wvtKWv
 /oUr8wE/lbF7TCWT9iOMLuCaYYOsjphpTryicvP3GWG9ivMRuZsFtcjlyLXPVr2ymaKP
 mX1jbl8nyZWTmgYbnaU3RSppz8RGDTLkYBqJ9FHbCcmxagFftlo82VsCH64Vvq1m2FKO
 j5ww==
X-Gm-Message-State: AFuF++lDzEpvaSyP260nhkLcKmKlICxvZNMWCrq/6KG2/f2MYOa9KEpa
 nbM6hf3h5PsIU4a9V5jJ1yzG4nOYunz/mdCOXMpO1sPxp3laTmV5CkIr0JSkpNkuzd/6XryFzJf
 3JiQk
X-Gm-Gg: AR+sD100xE56oMBk9ZsRAdJO4GXkcix62j+0pbnjIxZvtcGcs7JTox/8rW4dXRInMMH
 3AgEo+XjN86n4gVgeczLQTQ2WyJDJRz9shRZ8BqLAjXT96L/I/CR0nG8Pb4XudlTGTvbjpl5uAh
 zEVLETyhpXuRYJ2prX/9maBjridZEx38QqVt7n4GP77M0qJ/s4Mmo4bqPH/MggYVHeM+itV27zR
 6zUtD/RnZf3J0QHd+t+K8x15ArCT4gpJM/t6eCu47zbYmAuQjAkXLtKXcg9SQkflwQkhsM0cF+U
 aDSfi1dOYn1fUkq8g3B1NkwgPU1xlPe19GPRvoDVJa6k6irejAP8jdg7eKIxpT6ozAT2PJYHbn2
 kma2ISOtoM1Pue93SqeUGVa5p05+cyozjzSpoA8CQwihhgYnR2JSb8ufRH9IbT4GIa1ucTjC2Sb
 8ApavrRoOdBFKGdsj149AP6vgNeI5b4f3StCElSfJSnyL/wsO5
X-Received: by 2002:a05:600c:8b75:b0:499:d22a:8973 with SMTP id
 5b1f17b1804b1-49b91c1da1emr265815e9.1.1787847007862; 
 Thu, 27 Aug 2026 09:10:07 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:e57e:de8:330d:26d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm71359465e9.4.2026.08.27.09.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:10:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 0/5] nbd: accept a large NBD_CMD_CACHE,
 cover the transmission commands
Date: Thu, 27 Aug 2026 18:09:57 +0200
Message-ID: <20260827161002.310688-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

Changes since v1:
- the libnbd handle now lives in setUp() and tearDown() instead of a
  context manager entered by every test case, which drops a level of
  indent everywhere (Vladimir)
- one block_status() helper returning a context to extents map, in
  place of the three near identical extent collecting callbacks
  (Vladimir)
- the unused callback arguments are named with a leading underscore,
  so that iotest 297 stays pylint clean; v1 added eight
  unused-argument warnings, which would have failed 297 wherever
  pylint is installed
- Vladimir's Reviewed-by is kept on patch 2, which is unchanged, and
  dropped from the four test patches, since the two points above
  rewrote most of the test

v1: https://lore.kernel.org/qemu-devel/20260826165747.3768674-1-den@openvz.org/

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
 tests/qemu-iotests/tests/nbd-commands     | 244 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 3 files changed, 250 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out


base-commit: bde2492aace2b5acb755a5b057013e915163a77f
-- 
2.53.0


