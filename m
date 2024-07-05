Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C081C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr2t-0001Wn-Ug; Fri, 05 Jul 2024 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2r-0001WE-Rt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:45 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr2q-0007A9-4n
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so14159495e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217082; x=1720821882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfXglVFItdMvYp2Ch/WZz6ab4++EfcJpsrja1IJfWWk=;
 b=P0kAaTzOb7/WQubpeDPsbYBAUj+5TooA0UFtSfWOzP0ThsWx4xuUJI6N+WoZwqjYp1
 2xtvtkv+lBnqeCJvAHFSGji8rWjWYJ4qQqt92Tut0gRQVTc+7pXP00XI7OT2nAQcpwUY
 CmXOzj3tnhQw8OrQ150erRAun386Ioq5TlrD8qMau1jbS+wzKKdDsw8e5e7IhZXuBgff
 UCd9qbwNk8EhMZt/4L3ERnmYHqET4QnlANQipJRpxSSIvMw4vjFkToaBxRFrJ96HMqUO
 L3fQ6b9cRn5NKpd/X40YJXCJXLNywB2ABgHTg8o9p64hf97eDr0Aaf6zN45mN0GbxAMo
 AkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217082; x=1720821882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfXglVFItdMvYp2Ch/WZz6ab4++EfcJpsrja1IJfWWk=;
 b=Ve7vJMiWHwmftIdt6bLdGwGoCl/sU9GAHO32kRFgxr2Z0gjov4Dv6kn4rorztK/jnD
 TRjd0QqRTasR6cyL5J4jN6aWfgQSy6Z5JZhoqZrOe7TjRjCDgqopaBK7vYaEpJOFh/5j
 qwtTQIEpAy76SoFNnYwRfiKndfLyUvBmE2munKW04LWIgaUEUCWiGZTv9uh22fSF+aQX
 5qF5popHXTfgV2gliasK/TPgz4yy/aXZJi3DwHbCQY6EvIXsplVYQOhfg51uolRQIXuz
 YAUf+3M0uI18QqLQ9s5skf98YGjR4vuP7aM2bH0IqgUr+iyG/D/Nt9g+qHxu3G6+C5PU
 9Y1w==
X-Gm-Message-State: AOJu0YyVdFK/11u0AIWny+mfxC1EwqFexB8xmEjbose6I9uLyDig7z1O
 bNLayyphohJtnBdDR379dvZZXpqPKZxSWyOFKblXb27qKMzA7mB4M61FkUzmJBQIhBrQ6vYcwOW
 s
X-Google-Smtp-Source: AGHT+IEiaBYqDXCZomUx9F3ltw5EiG68Go6/Fi1EMTax4vKTSEkBKsIoSSS1/RwCr/32HVKLhwejgQ==
X-Received: by 2002:a05:600c:3217:b0:425:6fe4:5472 with SMTP id
 5b1f17b1804b1-4264a3d978cmr38039775e9.2.1720217082522; 
 Fri, 05 Jul 2024 15:04:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a28327fsm74533965e9.39.2024.07.05.15.04.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:04:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 01/16] hw/sd/sdhci: Log non-sequencial access as GUEST_ERROR
Date: Sat,  6 Jul 2024 00:04:19 +0200
Message-ID: <20240705220435.15415-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-Id: <20240702140842.54242-3-philmd@linaro.org>
---
 hw/sd/sdhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 27673e1c70..d02c3e3963 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -983,8 +983,9 @@ static inline bool
 sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
 {
     if ((s->data_count & 0x3) != byte_num) {
-        trace_sdhci_error("Non-sequential access to Buffer Data Port register"
-                          "is prohibited\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SDHCI: Non-sequential access to Buffer Data Port"
+                      " register is prohibited\n");
         return false;
     }
     return true;
-- 
2.41.0


