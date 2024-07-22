Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00049C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZv-0005L4-Aj; Mon, 22 Jul 2024 12:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvZq-00055J-7H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVvZo-0007fe-Hh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36887ca3da2so1874392f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664469; x=1722269269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9OXBMV4qUioh74t9F5ySrsmXcQ3/BZ3r66GlJck4oz4=;
 b=YrWD88QoRVS359JEH3k6CVsgZVP1+EUlYHYbFfv46q8dos/oHe02uiY6t7lUc/pW4I
 rjBYTAsCm45CUssQ97GQpnAtgPjndTCSicGLZCqmfjXwGYRwPmzFlcyg94UB7fcUixEB
 Mh4xRLBXQZAY88z+IY/3M2AqnycHQOBEtYW3ZQ2sFPlFQIkmdYkSBm3SXwp/s0vxJzG0
 nTbm7eZCwMrVkpr+g+8k+zwIz+2OWfUb1XhserRwPEKeTTj04wv62vSV/Rwux6kliDJ0
 hN/NHJ1jibom3kBQHdVNeBUDXLZ/BaJgrwyqereDN/xa2tstJPKeREhWOrWtPwiVHyk0
 qKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664469; x=1722269269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9OXBMV4qUioh74t9F5ySrsmXcQ3/BZ3r66GlJck4oz4=;
 b=qJ7fWz7EAiVKpNAMV52EHFIGfpbDI8957NKFWHkCXpyFJNOYmU5Al8Twn6M224pNQ2
 gzwdyKlm+xgSiYHJcmjf8F6zbRm9RPXqnrm87qa8/6KZLBqLIq1gE5jvVuiel38YzUbW
 jwN+WxQ51bFh09c+nvRmbRjP46h5pK8i0dCCL9fcxTcJCerBtoJR1+3V+RdYtYqi2ahn
 BBJsPg+0U1uKWWtWpBwCkbnxb3iOz8HOsWMpNxkKqWRBpVBtfS1eX00/YD8lpto82Gba
 BCavKRMYvO3S0U0/Kyp8Ih7G/RkXVJG8Pc+7wt2nSoc9DjfrtTckaBu6Gi6dJH29QbF0
 dWeQ==
X-Gm-Message-State: AOJu0Yxr6wcbqzeIHqup2bzK4aKiWKpGRYCyDWmjoro++6V+rH4w414B
 QIXMiJQ94sPTfc1CcosyhIvDSgHZ8i1u3BCVpDfm+wn+HTduQUSbj7tl71/5qZzAtJUicvqi/mo
 A
X-Google-Smtp-Source: AGHT+IEEQOaEyC3ZGAb4KHeZ8onREs/k5/cfmjlsYZOkpswDb0x9vz5R37amm7ALKpaOtZ57CUFwGw==
X-Received: by 2002:a5d:4e45:0:b0:367:991f:4377 with SMTP id
 ffacd0b85a97d-369dee62a5cmr205724f8f.58.1721664468689; 
 Mon, 22 Jul 2024 09:07:48 -0700 (PDT)
Received: from localhost.localdomain
 (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr. [176.184.20.254])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebd50sm8868499f8f.93.2024.07.22.09.07.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Jul 2024 09:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] util/fifo8: Rework fifo8_pop_buf()
Date: Mon, 22 Jul 2024 18:07:38 +0200
Message-ID: <20240722160745.67904-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Rename current fifo8_pop_buf() as fifo8_pop_constbuf()
and expose ESP's fifo8_pop_buf() which takes care of
wrapped FIFO buffer.

Supersedes: <20240719151628.46253-1-philmd@linaro.org>
  util/fifo8: Introduce fifo8_change_capacity()

Philippe Mathieu-Daudé (7):
  chardev/char-fe: Document returned value on error
  util/fifo8: Fix style
  util/fifo8: Use fifo8_reset() in fifo8_create()
  util/fifo8: Rename fifo8_peek_buf() -> fifo8_peek_constbuf()
  util/fifo8: Rename fifo8_pop_buf() -> fifo8_pop_constbuf()
  util/fifo8: Expose fifo8_pop_buf()
  util/fifo8: Introduce fifo8_discard()

 include/chardev/char-fe.h |  3 +++
 include/qemu/fifo8.h      | 50 ++++++++++++++++++++++++---------------
 chardev/msmouse.c         |  2 +-
 hw/char/goldfish_tty.c    |  4 ++--
 hw/net/allwinner_emac.c   |  2 +-
 hw/scsi/esp.c             | 38 ++++-------------------------
 ui/console-vc.c           |  2 +-
 ui/gtk.c                  |  2 +-
 util/fifo8.c              | 48 +++++++++++++++++++++++++++++++------
 9 files changed, 85 insertions(+), 66 deletions(-)

-- 
2.41.0


