Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37022C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DL-0005LA-7B; Fri, 27 Jun 2025 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DD-0005F2-52
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D6-0007Ek-LZ
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:42 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so1637024f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023535; x=1751628335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BidNnNLM1rUcFeA/dLJqRUtobHsgBklQOV2aV4NWhB0=;
 b=ZdgwYgkRipXAVAO0+3u952iR3sCnwqcGXcebw07XhK0OTfEEIA8JzvHGHUSMKaYIW6
 RWjY/e+Jr41QIbB3LuOW+VcL0m01Jj+NV2pNqRwDnsz4Vq16FgBDr3lQ7+dD52JwnCne
 5/szRgK8HLW5+lg0ycpUACxBMayjEkLC+7xxNDi3c+R/eV14tnVjeKR8ig1yO5dmjpe3
 dME7RHCJAQq+7klgQG3l1kXeRJUOREwrX2wUOJaDIVMGD2WOPWfyjzKereHdnTcSB1cR
 MmE8s++kML/AGrA+JkkOe0HTwEzGUgLYcfSIOL7890hq4pjBFkQ8fSk0bQUvZyAMLZ0Q
 h2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023535; x=1751628335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BidNnNLM1rUcFeA/dLJqRUtobHsgBklQOV2aV4NWhB0=;
 b=mjYKJXOksBQXo2HfTp4WhH9M/5h2S6tGKvE+FtycToAIv9ozX0R0jZhD4pKbUnBPpA
 xeHNWDTMjl9WNHAQ0hwy8leQQF72xeBsXP6hUf9OLz6kI1RDYW4TD+HQ8EaqXXUQ+pIp
 KcJOC+ydLYpCkMMbtTZwebXL1mth2Tb8YrRLWx0cCHr4/5wY3L9aLtmxk+EyvmnQ2Lcz
 NnJ8G/1VjOggdeWB+lk5iMSnFL2kcqd34RyYsdm3/1+fii3stYkvhoJYJ1mUVq+WQ2F4
 LPJOffWGIEKBKvVUQgSTdODlVAHWkiIMWooTLwKUcy0Wn1kikN1ZrVE/FVrp1EYkhSSn
 rWnA==
X-Gm-Message-State: AOJu0Yzin+u1LBXagXpP4HGexbSi1wRf+LI9sUbWebeRk2JnKkERuf3N
 K/S3dmJX3eY38xilwVM6e3i+FYseln6Tou+9c+1bkMrBiM2mcWNdI3q+q2zFty4kz8Q=
X-Gm-Gg: ASbGnctY829d0yxHtHWXeWJ7W7+m26sA4sMj1bfZPA4x4kuHyprJ4ZhC68yyqKo/LDn
 fG1HN5Knf6/NF/+SxJMsb8zK/vRyNapiqTbwloUBwYhGGJzTBpYW8StbBrRDWwxw7yiP3837HB0
 W0gc+6V+u2Oo52Mws4txTusmjwfggZyfvO1gr6ZsDkSxeEbrBcPrfsduWkTyUkQeRr5OJhowboT
 CBv6xkqZwRfkFmM+EyL5SsrljBlCqIqunuEHzVuxtrFjJCu7bTK3pRZIQndJJbPVDvt4HkJ3J+4
 Y3kQs5XJHjMT+XEhvHQJC0/T2oJxjrr432GsN6WAvrikHQqFG39WCOG8G9x1hCApjGgjQUUebg=
 =
X-Google-Smtp-Source: AGHT+IGeZTzgPMyLh7NTsJQ2mZLboaEbGrxlWVe/A2OfF8W6yTae6W9vF4shOu0P8w8F6eQPrRJW9w==
X-Received: by 2002:a5d:64e3:0:b0:3a4:f52f:d4a3 with SMTP id
 ffacd0b85a97d-3a8fed705ffmr2997155f8f.28.1751023534979; 
 Fri, 27 Jun 2025 04:25:34 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45380d0f15esm69791405e9.1.2025.06.27.04.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C3C05F91C;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 13/15] MAINTAINERS: add myself to virtio-gpu for Odd Fixes
Date: Fri, 27 Jun 2025 12:25:09 +0100
Message-ID: <20250627112512.1880708-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Seeing as I've taken a few patches to here now I might as well put
myself forward to maintain virtio-gpu. I've marked it as Odd Fixes as
it is not my core focus. If someone with more GPU experience comes
forward we can always update again.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-8-alex.bennee@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a7c7f3770..0f96a8d956 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2677,7 +2677,8 @@ F: hw/display/ramfb*.c
 F: include/hw/display/ramfb.h
 
 virtio-gpu
-S: Orphan
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
-- 
2.47.2


