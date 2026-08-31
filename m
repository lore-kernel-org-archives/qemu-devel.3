Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30142C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yq5-0003Wm-4A; Mon, 31 Aug 2026 06:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypx-0003VT-Tr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:01:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypw-0001hR-2E
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:01:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so389985f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170514; x=1788775314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6mzly1CBUe4Sf/Yf/dvAMrTn8OmlXYos0/3g7s29vJk=;
 b=bYIXEBRiVCUyHkFhgdrH4myyI7KuRCU+0m7yAIiaDtis7rD2264l+ys/nZvarKSqNX
 eEtA29VTTErO0cHkBc91QG66Ohfj21cLIo8DFkpOBqHxFfl5qrgoPr1vifbBiPQn5374
 tDAvyCjw0r7M3D8cf2X24q9bYz1l2QDFmWd+KyQAFrl0tsu6ovESyFXAG1zzggm9R9ZL
 AmB2wfdYMAJ8l/1nSGH93PoiggBX5blMP4JXIRFS7h1uCQff50CC7dIYMZHbo8Obqn5O
 iPbCciWvnaqC2RvUjgDXtdV7XIM9aqQ6EIn+R873BIkk8qFU/IltaRqrKf3jBHnFMAr8
 WNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170514; x=1788775314;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6mzly1CBUe4Sf/Yf/dvAMrTn8OmlXYos0/3g7s29vJk=;
 b=bBP0IIz1hST19MSPGcZN5VWAPtx9p6ZnYdjuq9DYnF//Y1geR4FEPIriNp68OotO7E
 se3D91PnMZGXtJFQdLVgH0veeXwX1sFY0B1IwrmT+x+qw/APG7epvNZiqMjgQ1mBs75h
 cGVaon/TVLVFvKd/aeNOZdgbg+LDTwnhHsy1ZxyeJ9HPZMCk78Dz17ADr9OdjiumCZnV
 bB9VEbsCDm2pNJqmCrlHqvGCYo7Ro5W4WxLpReMypsvAuAQrBveoIzyDEYHPHyXAXJm0
 lr6X7a5ckTGRlVkGBTvwfkpn6Jl09t7FDlLMMMP3fONldwj/UPzzE/R1InDpk/TjqfWB
 0l3A==
X-Gm-Message-State: AFuF++lWfDNo/5AUcNWNi3N3nFrUZOQHzJePx6L3a7JiTy+/zMJTW/aS
 4X1o7IAczBNVHtNnxjhA2yuKNyegqiECOlJ5tEhnaKM8FI0qFL56yeGTEaM2XQdJMQAA3PmGahF
 nbhFA
X-Gm-Gg: AYBFou0hnDlqnwQt60BYIgocmAeIDsvnlE/z2QGFxdn2YYtlUodOq1Wfeqqeah5Fvt3
 3dtdpOnOWPUNTFQWRBTSfwYEtLRHs+H/Gc1IezVDlWUSNVmVE7d+4RU3GFxLMP8hwGnsI9XLCfa
 AgI0qq3RWyNGGEpJMUWEczu3q5i01duwccrdqrl692dIgwCN7CcShN0ZhsN0fMz7GseDED4gtF1
 9tlj8GFRMIcsFV6NsWUJjzh4zFU4z/GkBTF5za6cJRKtOmy0AofnwAZZgChUBnyKRq7bG/RCRxg
 jqWxwbqEXcu1j1naUNc+0irhHmuTlaVEzVeJZ0Udr1tqpIm00IZsSKeJyG30K3AFpRGUkZ3pTTM
 SSacU/EDIDALsftsx7wzr5NP7HLMLabcP/RHgC1VXt3rtGcoLNOh67ydVhBDNkC/Ip+yoeSYoXL
 nuj2LX9icN0F2+YNseCuGShz6H7Q9t8NRm8iuNa1yROuD6ZwRV2cqS/mRX3oaJnz4S9UY=
X-Received: by 2002:a05:6000:2281:b0:482:e1b0:8a1a with SMTP id
 ffacd0b85a97d-4843f88480emr1691387f8f.15.1788170514167; 
 Mon, 31 Aug 2026 03:01:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/6] io/channel-websock: fix an unauthenticated crash in the
 handshake
Date: Mon, 31 Aug 2026 12:01:45 +0200
Message-ID: <20260831100151.914178-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
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

A client which can reach a VNC websocket port crashes QEMU before it has
authenticated, by sending an HTTP greeting whose request line holds no
space:

  printf 'stats\r\nx\r\n\r\n' | nc $host $port

Three defects line up to produce it. The greeting is rejected without
queueing a response, so the handshake goes on to flush an empty buffer.
A zero length sendmsg() succeeds and returns 0, which
qio_channel_socket_writev() mistakes for failure and reports as
QIO_CHANNEL_ERR_BLOCK with errp left unset. The handshake treats every
negative return as fatal and hands that NULL Error to
error_get_pretty(). Patches 1 to 3 close the three links.

Patch 5 is the same NULL Error on the read side of the handshake, where
ERR_BLOCK is folded into -1. It is reachable for a wss:// client, whose
master channel is then a TLS channel: a wakeup carrying only part of a
record makes gnutls report EAGAIN.

The tests drive the handshake through a channel which reports ERR_BLOCK
on demand, covering both directions. No test reproduces the original
crash itself, which turns on a stale errno and is not reliably
reproducible in a unit test. What they pin is that a 400 is emitted and
that ERR_BLOCK no longer reaches error_get_pretty().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Daniel P. Berrangé <berrange@redhat.com>
CC: Marc-André Lureau <marcandre.lureau@redhat.com>

Denis V. Lunev (6):
  io/channel-socket: do not treat a zero length write as an error
  io/channel-websock: send an HTTP 400 when the greeting has no space
  io/channel-websock: handle a blocked write during the handshake
  tests/unit: add websock handshake test
  io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
  tests/unit: cover blocked IO during the websock handshake

 io/channel-socket.c                  |   2 +-
 io/channel-websock.c                 |  10 +-
 tests/unit/meson.build               |   1 +
 tests/unit/test-io-channel-websock.c | 249 +++++++++++++++++++++++++++
 4 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 tests/unit/test-io-channel-websock.c

-- 
2.53.0


