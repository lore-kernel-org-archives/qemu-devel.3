Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0FCD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv7l-0003Id-RX; Mon, 18 May 2026 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7Q-0003B9-55
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:40 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7K-0004V3-5u
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:22:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so21080375e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099752; x=1779704552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlD13GW3HkBQzSNsvYt00iukjgNFx85GSZQFoAIQSXA=;
 b=BLsywvVuZPqaMcr4/FLMCgRKyg+CFKMn+O4rZHmQx5RccZo9ywiYOo80k8WwkR5nFy
 +CdChbba4d5Jue8NzZv65Nt0DsML57g0ajsJ9L9WQ1HXyuhxE8x80Tx2UGfEwXw17b/j
 b6PuXnACt+90udgWwdmm6xLb6izvzzdgFx7uCHJBPjTFhXUCbOPmroCFFHXhATLCneUz
 OO1Yxx6ue5M5LPYQLu2JOybhTCx7ikN+3IgAEjzhNQhARuWIoYDG+BMZ8LGwK6hvwaF2
 aJwL9zjWSgMfynuXp2ZfWlg3aWVwK0F4nG+6BMO21IzY3GyY8ccI5RKuW7JM4h/Ro5qM
 jKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099752; x=1779704552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OlD13GW3HkBQzSNsvYt00iukjgNFx85GSZQFoAIQSXA=;
 b=oIFKKnCglp+kuYIIIYRnPGUqRuAbYzV0b8A47NQ0i9i63RF8jAgcI6/6VsdOx2uXOa
 VsNjTpirxlR9h743baRfmrYoZ31VU5wOdxhpnqZOZezjuFMpk/7k3cJH5lbAg6Mm4vyO
 IFIHxfwTJda7+VYuLDGIFnnCBDl7iQkOk7lyKSsEatgjoKIYCwmagoosQhI6UmO7XeNz
 dqJ+lmHZr8o4JEQnD2xGV5rM42aLDbSTCKviAgJN7JMJMK4uMx2UETmHWdPvy+/3CwRy
 ZtD7OJClH7wXK7BeFi/NuSVmmZXI9nBcNy+ETqZ7RItDA8OiCZrNgE2TKnLvQEOGIAjk
 nzag==
X-Gm-Message-State: AOJu0YzIlHcEMMH54WZA46NRhbCEbmLowpWHCWBw3bw7ybjYbSZ76qYY
 W2KnLibZwiM8F5y/gXrNP7evAjvtkq/w90Sq27TQHje+SX/nYJQEPFNuUO1tIfmJYAaKZNYcRnW
 vuHPjcEc=
X-Gm-Gg: Acq92OF/ItVpkwIxiR51cIjeru4ONAyCMIq17eYnLirkA5b4fGFVVhUSyDT9Z53t94J
 PvfB/jFlPtaikkbWRR/Du3wQ3g5CO3u52C0U+MMe+D3Nf0jVxDpfa+6NIx/486CURFK5HaW/8l9
 8HGyP3OqzHH92DrgMb9z4KltxJnRFwIyQb93wGuNMqG8aN643M7RyoPe788zmB059yfOjLm8mLr
 RqlCZq9ITn1r3Ihw3Aa9DUciLCKrxGfyCx807BgjYjzqOguXAHPT/haUU2jf1trY6RHVrjIkGLf
 ZPblmvBCRMH53za/km0x6/zQnjYZGpr7rZIh3j21m4cAJInfHFYrGdonGhYFVYbfu62w6TAT6Ma
 uDSCt5ud1PbDkuRpRfECIMGOgtrShYsOMXEydCqhSibCuctGwKw18NkNBhnUJMT8IpFqNLfDCa4
 1ehGHw75pGGH1hXLfSrNdcPyEt9qUTME7UAEiPGbckMdRG68EYXMonCPwNNYPWNBmNTOJgigQ4
X-Received: by 2002:a05:600c:34c4:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48fe60ecdafmr227540795e9.11.1779099751721; 
 Mon, 18 May 2026 03:22:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4dac000sm252040455e9.0.2026.05.18.03.22.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
Date: Mon, 18 May 2026 12:22:16 +0200
Message-ID: <20260518102222.80735-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
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

Fixes: afbdf0a44ea ("docker: Add Hexagon image")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eda1e84268a..b1df7a4dd96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -257,7 +257,7 @@ F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
-F: docker/dockerfiles/debian-hexagon-cross.docker
+F: tests/docker/dockerfiles/debian-hexagon-cross.docker
 F: gdbstub/gdb-xml/hexagon*.xml
 T: git https://github.com/quic/qemu.git hex-next
 
-- 
2.53.0


