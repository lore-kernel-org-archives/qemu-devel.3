Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD7CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFu7-00075p-Uo; Mon, 30 Sep 2024 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFu5-0006wK-D3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFu3-0006Vv-Nt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:53:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cdbdbbb1cso1238566f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700806; x=1728305606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UpOp8oGufmY3S6ihnzDOSjknSoy4QyFyqBbpPmz4V9I=;
 b=hdjjrsrOwM3I71Fu8IIzA/q4m7WZttX4Vpa0YSPVHb+tUSeOGIEhWleUPW7VRJrTaj
 bQL0A7w9qC9SvXa8DrtB5P240lgRfCbRBpyd/vQGxkOljvDjTYJvaaIWADwzRgmkUODT
 cCeXiwqu17+QdbROPjO3tLAiY0w3n4keeB4zYF70NR5DYlLFEIX6BtEcDhy6+fuKuRvJ
 F7wKm2da7CaTM7I//kIj3dn/feAht56JidpJwSL1qY3YfyNrcX2U5v3cOgglnAxdQP4z
 iuQPlGlJD+fAIY5OvvVg6vOnLZfAFf0i6fdcjBHF6yYvOnbBj65QXsyOh3jGZa8iT02N
 qzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700806; x=1728305606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpOp8oGufmY3S6ihnzDOSjknSoy4QyFyqBbpPmz4V9I=;
 b=vlHAEGI5GKI1c6ros5JCjklKiTeRo1U5R0OTGAzLQrXZF1BRo9ihWiu4QxbuptpJhE
 N16ibn9jTFNeo2HNYgYwRpZyOdPNzYKjlinMdvPkMyzoiNJtAFVVBtiwNUTeaE+/6/hH
 qin5N9pftpBtBb04s8IyjELKvZwLD9MgePvySzaQOex4GG6RHJlkBNlbqOmjaVU59/m7
 oRfD5IkDG9LrZHkijfooXND4gKpDdVgTwmR6CXbEbncH0kgsFp4TLDOx/Zf+jBJPPxtD
 rhOJtPurriWonTVeCU4rrlQPie6JBfZXR8TCCHB4ZNyX6aSr1MKgS6L/sq6nd2MsiPAy
 O2ig==
X-Gm-Message-State: AOJu0Yx/QK6G5kxOMKBljagBY9EUt+h98b7QivxmtgxLV4CoNArs22XE
 2LN3cnRmwytzfGv1ER2g3mPCci2WEx1mlgR3GT15gkI//UlJA69HusK+Ma93EqQnOvStTAZmbiK
 WVY8=
X-Google-Smtp-Source: AGHT+IFKsnptfKt4VvsJnjtm8wBuhu7PhkwSJXpb//Rj8PHkouRP3ipFnT+vkd7Lo6CXLn7uNRQjQw==
X-Received: by 2002:a5d:6749:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-37cd5a62bf7mr6856121f8f.5.1727700805796; 
 Mon, 30 Sep 2024 05:53:25 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e90cd8c5asm179023635e9.1.2024.09.30.05.53.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 05:53:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/ppc: Replace tswap32() by stl_endian_p()
Date: Mon, 30 Sep 2024 14:53:20 +0200
Message-ID: <20240930125323.54671-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Expose ppc_cpu_is_big_endian(), then use it calling the target
agnostic stl_endian_p() method, removing the use of the target
specific tswap32() method.

Philippe Mathieu-Daudé (3):
  target/ppc: Expose ppc_cpu_is_big_endian() prototype in 'cpu.h'
  hw/ppc/sam460ex: Replace tswap32() by stl_endian_p()
  hw/ppc/virtex_ml507: Replace tswap32() by stl_endian_p()

 target/ppc/cpu.h      | 2 ++
 hw/ppc/sam460ex.c     | 5 +++--
 hw/ppc/virtex_ml507.c | 2 +-
 target/ppc/cpu_init.c | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.45.2


