Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EDEC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAeN-0004EM-St; Wed, 31 Jul 2024 10:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZAeL-00044P-BZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:49:58 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.reisner@linbit.com>)
 id 1sZAeI-0005eo-Ql
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:49:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a975fb47eso809262366b.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1722437391; x=1723042191;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KaoxBzIIywVnQdSBrnOgH21sK/NEKHNZyj6SYMBRxs=;
 b=NBxP0jPdAN6cQ6okYaZmDTKLLR5U8tEIVj3T/Y4yQPUg0CcZRpUbJ5cN0nv6bF/3lT
 HxUck20KhKfoy63/XqUO+dc42e/BLNK5ZAB/9sfjiRU3w45c367IQoB8Ya7pJ8jIH8v2
 ElQ6e9IUzP+1SF4f3PMdDM1fuI9J47pQw4IOqiGPCTSL2KsUaLM8Ln7nkOxV9zJgVaCH
 M8xi9oDnUK6IFPSraBSeVJknrJ99g8LnbnkugMo3sFj28EdShGg5cspL9ZE+GwuWbrlZ
 /gdATMTYOGNCEklHCY+HsNEru+/k4/GJ0wb5fuR1iAsTBXQjWDCI8CtgtYFzPYwW8ah3
 24Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437391; x=1723042191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KaoxBzIIywVnQdSBrnOgH21sK/NEKHNZyj6SYMBRxs=;
 b=C1xzBU2jbbCBnxptS+/YR/hoM6e6z15Bnc+tue3KcoDcQeNVPUJfj0hlLv8xih2y6J
 hv/AwYQZz7hXoojq1cZtUgYHgjJ8xwCrFbhyvSmNsd7zYkrM/hRbINIsAhWrnj3WGGqT
 YIY4p616SCU5OAmzLEcNHpBVl9L4LaVArmIeBH/b/8QqDnTUVDyYDEhHQyscrBLKb9iy
 iVn2pZfkWKRAZmgxIDbrL/gofieIHU61t6dJiPQk+jE/Le5+oSsb0Zy7oVqGb+9yY0El
 ScYVhMz+eJr/DQYWyxXIyZ8QMTsjMjsEHPFtWOVlpnS5G8ri0piaTt5T8XpqquE14SZi
 P3ZA==
X-Gm-Message-State: AOJu0YzlmEl4rVpBrKNnsgO5sSsAYAZ24EfR/QIgFZeZsU0oifwweMCI
 XvlhW1lTub+SqqpfTLpw7hobSRVb01y2C6aUN2SuRF7I5k/hg6CI7C2eBVyIwXFEH/L2IW4Mla3
 m
X-Google-Smtp-Source: AGHT+IGRJujEA8FhVJdUsxTMGkfPJm0ohneerJcJ1QRysk3lrHNOmAyWkJ+auV6fyD2gNSYMsZQ2gQ==
X-Received: by 2002:a17:907:3e1a:b0:a7a:9a78:4b4e with SMTP id
 a640c23a62f3a-a7d400e8951mr933366466b.40.1722437391499; 
 Wed, 31 Jul 2024 07:49:51 -0700 (PDT)
Received: from ryzen9.home (193-80-247-151.adsl.highway.telekom.at.
 [193.80.247.151]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23125sm779180466b.1.2024.07.31.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:51 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] util: retry open() when it gets interrupted by a signal
Date: Wed, 31 Jul 2024 16:49:46 +0200
Message-ID: <20240731144946.322498-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
References: <CAFEAcA9J37Z1JJb34zyRDo=ow0h1QgOq9bm10dCc0u5bMyQKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philipp.reisner@linbit.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

As with many syscalls, open() might be interrupted by a signal.

The experienced logfile entry is:

qemu-system-x86_64: -device virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-format,id=virtio-disk0,bootindex=2,write-cache=on,serial=1b990c4d13b74a4e90ea: Could not open '/dev/drbd1003': Interrupted system call

Retry it until it is not interrupted by a signal.
FYI, dd has the same kind of loop aroud open().
https://github.com/coreutils/coreutils/blob/1ae98dbda7322427e8226356fd110d2553f5fac9/src/dd.c#L1294-L1299

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 util/osdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..13a09d0dd5 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -295,9 +295,9 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
 {
     int ret;
 #ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
+    ret = RETRY_ON_EINTR(open(name, flags | O_CLOEXEC, mode));
 #else
-    ret = open(name, flags, mode);
+    ret = RETRY_ON_EINTR(open(name, flags, mode));
     if (ret >= 0) {
         qemu_set_cloexec(ret);
     }
-- 
2.45.2


