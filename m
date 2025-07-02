Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B5C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2f-0000FS-VU; Wed, 02 Jul 2025 06:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2c-0000AI-B7
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2a-000343-AK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso40869775e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453409; x=1752058209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLr3MJ/hu5ri+yIW2Higb0CF3yMxJGbnYgVNVmgIUMg=;
 b=fdGlJZBuY/I1zfRM8VUHZm/PFTTtespxyzHgu4ODTKAYsV4F2cxb+Tf08HOIWRd2Jk
 j5rxizpLsXTYGttmmG24NuYDfVvTMMctK9sQ+x8GIOLjBxyeK3904DwNdBu2AhQEPx25
 LSA4H16iSmAGG6BruI+efdrFWP2Syk1XzrCj8SqMaKuwBwYJFu7e1Me29Q0SQUApfsso
 C7Lp+a6iggnMWO/cYJafqTTs2GT0pTlW/LrWH2md2MqRdMKzJugF6gJVQ2XtgcNiOzht
 FnVFz1iBlI0DiMGW0B+2xgJ9BxHocXW6Q9Vl6w3xtEedp02J8RySQwa+SHsKosdJbfT3
 lpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453409; x=1752058209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLr3MJ/hu5ri+yIW2Higb0CF3yMxJGbnYgVNVmgIUMg=;
 b=S3TAw36C+FPcYY0jRbJCqYMRMju6MdvTXbL3qqNHzSxODA6a57H4B5XO24/F9/Mc9L
 6D6eVYmDJxphx2s7m3SxMDtRv7R5PyrBmEAv/O4R3VbzoqAGykeZpfyE8/hQizanEYLX
 YK3tDcfJvsY2xIYelAmjYga+Re5zbpMdJmbhYzJeMew8TbmgmyYyWcZRsw9gNeCB9TwF
 w1t5Bp3FFU26TRp/kCY/bbr0NQMRV2u5d7l+7llQln/RuCeQBsjjNw5HGPvAKXoaPNNI
 JaZFKP2SvJAVwahYknpj4wNoPON6luG+fWLrMCIKgrNFaSxtiZrKqlLMygt1e34UDkon
 QrWQ==
X-Gm-Message-State: AOJu0Yzv99DYbiDoAAjCZ5t1v1/7wV2VYAm+CpyGgSKoZ+GBPq1fOvfA
 fL/lgDOrKkdNdrJbDLM3I5TG9I236Tebn30ahEn3HKurQ7guhyiOXA8ZC9KU+1KiwSc=
X-Gm-Gg: ASbGncvOhomNApyYw2RuSZtH+hFOzfgAqvpK7MEH688KuC1/4GIP5HdJYw1+06aMH3I
 TXAH//90rMSM6jJjp2n63SEXNRV79X/bEvQr3PJ53vw90+F8lAttOr6WZ7+yEbBqVkJQIm5KRux
 RYw98+vRDtfRSNr96F30yf51GGm+l3fk6GyGgHN9TymVpw8/N5IGVmFVNTQTXTPo1bhHAQ0YIHV
 w5TyJqL9y2UeetJ43BCag1SUGNeMblF4B3RBOK1U3CB0iljAixUnH/YQ+6MEzK0Y3yWIdHhAi9r
 BqydkK7GcVPj2vqNuYuhV8g2bmoxGVx2+oT0BC4j11PH8ZwN6xqXPx+hcmoen1QTu1A7FcTpkQ=
 =
X-Google-Smtp-Source: AGHT+IFV5QZz2b/4vbp9zwoolcs4zGqIScmWHWo2keKkDQZ0sEdgKUJtI1Lgm0KD00/Rh/B+FRY8Vg==
X-Received: by 2002:a05:600c:4e86:b0:453:c39:d0c6 with SMTP id
 5b1f17b1804b1-454a3737eccmr20557885e9.32.1751453409352; 
 Wed, 02 Jul 2025 03:50:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a421434sm197069495e9.37.2025.07.02.03.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:50:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2375D5F930;
 Wed, 02 Jul 2025 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 14/15] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Wed,  2 Jul 2025 11:49:54 +0100
Message-ID: <20250702104955.3778269-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250603110204.838117-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-15-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f0164edf..3932a6e56f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2685,6 +2685,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.47.2


