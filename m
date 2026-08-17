Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1FAC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Kk-0006gi-8s; Mon, 17 Aug 2026 16:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KT-0006av-EP
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KR-0006kb-4M
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so31684125e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999986; x=1787604786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywlkrEZ3c9Jf0YAOLGjGWCEeFiOhos4YHtOtMUf8ShY=;
 b=Qw/cCpLwMK3RD3rGCroGpvHxZXq2usgPiyItsLzENbeSCDiVcQtU7zNXUF5EBjB2Hl
 it9m9r9WsIrUF+L1oEHFkYD15POysVi/wArDGAf5BQudHTHOx0QthdNzKFzJxRi9Xiy1
 hisojwnVDz6k2aU0uPTHt/aFR6SLSTpBXAK8huDLKyFmWla0Ju879e0wIoTfN1ID0mXl
 qqdI0h1LB+D+b8sWA6XiKlZo77Fw0aqqJJu1rNMMUq8olhVhv/isVuLBZuDBlfxzm9tr
 u/gNgk6H7OjceJ4682vtaeR0JIG99u/jOQBCKswOwV11Yob/S2WIEijrPF4YhxWrNd+k
 pTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999986; x=1787604786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ywlkrEZ3c9Jf0YAOLGjGWCEeFiOhos4YHtOtMUf8ShY=;
 b=iVj4yPh8GeCrdU8evfZmnOf6t6K+YCL3cqGp0NmndFniUuUOF8lVQRzpAnM9M5tqJq
 40CDmZIa9EEsszrxXDMBNxyFV4CnK5LYK7znT0ksiO6vB3nEXI+DGWAztGxKMpjczdXQ
 Nlw3h0ecunuWsmdEzi6HHDaBIajeWyr8I/uhzIQHUFsV14D5iJpPCf5ktQj7jKnCp3gV
 olvi010JUBNt7T6L+u5mnrRZji1rfy1BRNds25bK7gw4VmnRVNkqRCYKd1uNSH641e5O
 lHKBMP3opB6zRU/d1F1qhQXvIUEAPPH2NVNPLfwTFRLeuJ/M5x6sIqnD42BG+SGZCku4
 TGlw==
X-Gm-Message-State: AOJu0YyNH+R+zzKCFHq6OC5ibYf0dVBd1dfeSCjjg7n5WU3LCi8j2C+b
 oDqZcF6kk8Rxs12YZhJ0Bqcbgcsv+J0eBD4jwGG8RkSTOqgXUka37u9GwXyH4DeflIoALsrsePO
 jJy/S
X-Gm-Gg: AR+sD12R8stuJigAB6DpLxpNpzvsh2w86vs9ZXWPZxbRKkbhCDSSxmYy3+CRacf+9Xm
 BojqdydlsFT9dbtZ6XVYJGCMjxaAzu+ZEFVutJpc6qVnF0fIAY1DuVhePipxvP4YXh96CGHusZw
 Gvlsk3SWJP2us9RJDtDZjsHjS43QV2ag2AFkkmqcxBc9mtx5b5sbmsRarYLOAacEFt4Nkui10Ax
 K4Aq6OjrHQ6Eg2WlILlB9bGJkU/OJL17Wwd8Jg9+BjPmNgdhDK0vE9+y+859LbTo1A1A7QefPkU
 NqJoK/3w67zc8jPhZYX80QIArFL92adwN9kTyM7qKT7xZk9iGm3qO6PBtG3RKhkIWgOyy0HnI0X
 SmKywgj8fdFyBflr2iFv3Pdulc/Bn27v1t0D+Fw5LIM8ZVlUYqM0iXTIj1LdDdlRwGTPWkdL5uN
 LvRhLUONGfU6hcGzRy2Rhd2vNqlQCrv8h+zzq6DOy6hemOZKQM/Q==
X-Received: by 2002:a05:600c:870c:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4999fb3be85mr52789335e9.9.1786999985699; 
 Mon, 17 Aug 2026 13:53:05 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:53:05 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 15/15] hw/ide: drop a redundant interrupt from INITIALIZE
 DEVICE PARAMETERS
Date: Mon, 17 Aug 2026 22:52:42 +0200
Message-ID: <20260817205242.1199851-16-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=den@openvz.org; helo=mail-wm1-x335.google.com
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

From: Denis V. Lunev <den@openvz.org>

ide_bus_exec_cmd() raises the interrupt for every command handler that
reports the command complete, which cmd_specify() does, so the request it
raised itself was the first of two. The one from ide_bus_exec_cmd() is the
one that belongs there, being raised after BSY is cleared and after
ide_cmd_done() has let the bus master post its own completion.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index bd155f8d3a..1b86826e2e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1675,7 +1675,6 @@ static bool cmd_specify(IDEState *s, uint8_t cmd)
     if (s->identify_set) {
         ide_identify_chs(s);
     }
-    ide_bus_set_irq(s->bus);
 
     return true;
 }
-- 
2.53.0


