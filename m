Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7775C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfM-0004TO-9q; Wed, 26 Aug 2026 07:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfJ-0004Mr-LZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:33 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfF-0005hz-KJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1035382a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743168; x=1788347968; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C6H3NdyVYWe4GYERbpE77/jB82tWhh8EMucyigehmHE=;
 b=kmAcSmOm6eI+W3FCD5Jl937rPbDhAc6ovkO6EJw+qkzaDmMYiMv3GZlHlWATcDovM7
 O7zS10Bzru6gX/kE90gWQ1nHPN+JOuqjxlktEGkl9utawYvlGKfRdnXyIRNjYXac+mTv
 pibSQ6yVv2k7DnYrbCSpGR3vZpB6V5jn7j/6s6JwVYVqm3W1FY8QPSqhrCRyHqhvvdn3
 /CeXTAlHZfeo3ikM+KuBQdV78/TbkKjWG4wuTuyvdBV/4j5u6IEtTrhptLPwEtqr4I/x
 hgsrawgxa0yszUKHN0r9T9t1LocPbEVPrdmADBfN2ZY7Qdxk+2LZnR5yWELN+Dr/JtV4
 lwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743168; x=1788347968;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C6H3NdyVYWe4GYERbpE77/jB82tWhh8EMucyigehmHE=;
 b=NJVRYw6Ah8NJOJS9xW8vPj05Y9gtONMx1bkJFCB8l52hi8SCftxrnlY/NSZw7/DTkA
 mWE/PV4bz8vMzbeoq8HeGhMKwwMSrqPMVK9ewRp0y3ntFSjNWQK+0+Ca4+RUWxNeouYi
 b5nRFkkEJIPreufP5x+YRDOKNgQ/467uvIkyto33j1cvNUMnk4rFwdql5tIQ2qAYeFoY
 FS2RY9+gYnkNtpfjOlCOL5WPnS8fqbU5Ys/pFcyTM1soVkyVywDdeRJwzPYwD3zIrAxP
 M8oAQyp4AYWE/tvu3kJb/5dC8jvoYBrQ22UcGw2uDv3CfV3KtxduQn7Vz7d5I0pUkZGU
 AsRQ==
X-Gm-Message-State: AFuF++lL0R2Nu5uLcWUtF3Mu2eUJaxilBD7gej5Qu+NYiubm3V22ql2u
 /ta+O9v8Ur9vthNMuzV8BQ9aAFNsuBGOP8Wlze29qDak3arw/hBkiXUCqoNLiZYLu4eOaMbA4EF
 d/e73
X-Gm-Gg: AR+sD11A6QN4eP34X+ba9EF9keNeJ2jw0QMEt2Iuy8EQcY3y2C4hoG8UMa9uV6h8pDf
 KBbw3SwGni3B3FiuaKALKN2DGTvqXnSBS/8+l0mFVwz4+ZAmS9UyOoCZONoMZR/ToYubZTvCnTs
 JZ9sCNfIOc2+tBRAEuKPqXn7ACr9s1Hc0S+m+KoAijsp0aBb3CYSSyOkpZAvMcK1b/KMuvC3MBC
 dLyZZu/jrqlbkZsTRL/xWYzt6dXgJXqYBVrQ6Mo+Cjp4vApqEX4sADu7RuZRtFyjMvDxkunUy7/
 VRpozMLyKUF0AfrhmY+AwZY+MGFcxSr9+GDga+x4c8Zf/ke22RARMc10B8nHmYt6whO3ZyJd10L
 QNi9l63HqADck9LGBG0e1eQAsH7WBGo3Od84QOd/EpX8anhT+ZAbj5+bFSpSBoxsOyD/IS3ROJZ
 CrRgsg4pbe4vTP/aFPRaaJpth9GR1x3Xg7FWFJ/BVDqKQw2ehD
X-Received: by 2002:a05:6402:4025:b0:6a0:9c84:ce0e with SMTP id
 4fb4d7f45d1cf-6a5df663cbfmr8736265a12.14.1787743168155; 
 Wed, 26 Aug 2026 04:19:28 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:27 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 17/28] hw/ide: drop a redundant interrupt from INITIALIZE
 DEVICE PARAMETERS
Date: Wed, 26 Aug 2026 13:19:04 +0200
Message-ID: <20260826111915.3387926-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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

From: Denis V. Lunev <den@openvz.org>

ide_bus_exec_cmd() raises the interrupt for every command handler that
reports the command complete, which cmd_specify() does, so the request it
raised itself was the first of two. The one from ide_bus_exec_cmd() is the
one that belongs there, being raised after BSY is cleared and after
ide_cmd_done() has let the bus master post its own completion.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ide/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 3716cf1b5d..8190549ee8 100644
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


