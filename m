Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C8BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgDU-0002D8-KM; Wed, 20 May 2026 08:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgDJ-0002CZ-Q6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:39:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgDI-0006ns-3G
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:39:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso63987145e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779280790; x=1779885590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xUF0UjGwnO2I9AJrPIdq7UBa/lEjw7u0NQLej4z+Tv4=;
 b=Aef1qDSulRivhiSsagxaulnuEAy5pTK4ScNtDKD6hRLAlzIk+Ei5Vbv9qIVvRkoB/0
 6BmJo6bIqN2+v9pQIAA5x8ow7rWZVVX9JeWfZTBUXhaOZnTy69BU7lt3eBRzDgW/yD1j
 cZngwYnOWtE1ppUXjbBuQYo0Cehk7MZct9XEBcI2siAYKWFJQ2y6dyKyaG1BEyICbD+m
 fMzlZWris3L5Cwo5RpL3/JnA+RssC2o74fvAJ/hi7AMpfsjfWADQyRL1m61a/mfkxV6x
 9i9dw7jfAhppkZNHrNuJf1C1ce378tANexe6ozT1RiBuTyTH1nRH+6pDnRRLAxpnH0co
 lxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280790; x=1779885590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUF0UjGwnO2I9AJrPIdq7UBa/lEjw7u0NQLej4z+Tv4=;
 b=lw5+2HpvToqIQl/fAKJKvlfIvMLbonNrqkuZn+woOwaaZgP9ZN0a3o6zkXAgF0e/x6
 U9cqufh+CML/Y+hFR+XYiiy5il/Q+hWW0D9utjXQjdX8yIDemVfU5tqtQyLp81eGBeF0
 1DoAsItdSi5m4v+GnqEh87bln5Sig4dMABaohLr9HdOT99iCRb4PC+W6en0ce42AnxmY
 LgkUFJgIgyzaqRKUVF6CXH9wF5xl4OZjTtWfeMe7fV035w4P3ZzdgJoJq6aYMDEZFkZx
 Id5HrQNNlgTpyQqjBljKGFRT8FuMd/T2rjz/86cZJoaa9jAm+1pw3hpv68ptlwI0MkP0
 Y3cg==
X-Gm-Message-State: AOJu0YyPt8NPueQX4ozYUM/yUccvS8167VYs9tvGnz061uiYrD0k383f
 Ddehp5dkk8Nj5Txn01poJ1Y/Gieqh4Au/swkb4aXyhEK86YabOd1hrvgPNhb27D60bi2SGrdJOK
 z354BjkM=
X-Gm-Gg: Acq92OF8cW38T543nurVf7AfcBwkTDTQgLsJGD9tKbUb3l891mtYmtFe1CqdqyXnvky
 /7DO8YG8PgcjIsq9Pbnbk4FG+jJxBvFiEdu/9pZltvi9SZ7Dj71RmSW6uDQjlMDWFjk6akLh9Ie
 A8AMCIvGCDkmSrkbKUKsM1MNrekinFCUNaNaAdQa6XJvZnLkBEpREMa1TTUQ4WvjuZDAuF0lKhH
 kTyUcfGqGJC1n6n5ZRzQWL+ampDUu3Fh+BASoRgj+q2yXVgvzWztVAZWfMVFaN5RQWzGYabGn3U
 ML78ImL9dmfchBc+kaoziOTzPEj7iUNJ3c/MYNf3xhElqKxm2vYfm4f/HH+0MkTKYmLAFK5VQZI
 BFzTe3bj05Nzzzp8spqIP9wUvTj4QOwqbe6KNaY6HINGv6iMOOQs+SQBOzrZOMDwvNdkX1d3H5a
 gCPOOrEMT8HCcD4fuS83CprrhkSeee+V3NG+lfP0hDJup2hx4o0hO1tDw9YZjgZiYwMS+SCWX9Y
 Dc5m6J14o5h/GOr4+/1iQ==
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr312400645e9.30.1779280789828; 
 Wed, 20 May 2026 05:39:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm387518015e9.4.2026.05.20.05.39.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 05:39:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
Date: Wed, 20 May 2026 14:39:47 +0200
Message-ID: <20260520123947.12711-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b75f3222f2f..2a4d124fb3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
 F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
-F: configs/targets/hexagon-linux-user/default.mak
+F: configs/targets/hexagon-linux-user.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/quic/qemu.git hex-next
-- 
2.53.0


