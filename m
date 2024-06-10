Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33A8C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYgl-0001FB-VD; Mon, 10 Jun 2024 02:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYgk-0001Ea-9Z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:39:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYgi-00082Y-L6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:39:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42121d27861so35111195e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001566; x=1718606366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QE6ywMC2Y3F0kXOuPqXscnbjAt0RsUPn5zxXXLMDLGw=;
 b=OIhwIsPQPA03ToQywD9ViOJ6WosX/AzKe5lcbeaJo9PeXO/8kmYnyt2cmMe3OjqV9U
 jOh3zrJOqS7e9+W3Gu9OmAWwXGYSZPa6PP3tGnU7h2sDyBkgMBZ0JedJt+OzRTSj0pqc
 kkxEb4BYC7gXUl0Wqhl96bb/TZaZ6UxXqHXOw5nT08p4JWV7NyjjHPjt04CYyDmoxn8J
 SpcSToK2XSXAnjrNmRY1c5dOXSNej3ykdrRxj5omqwljCFuwel8qRTmahip+9pEQ20a+
 w7u7GxSibwO8VnzFEq/quA0o6c0JVUs6R1fQ3NCsZP9d8vfb3WG+UjlCTOUqiDGlbVdn
 pL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001566; x=1718606366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QE6ywMC2Y3F0kXOuPqXscnbjAt0RsUPn5zxXXLMDLGw=;
 b=dgxU9jzT6g/j284POmmVfbtFY9bngu2tXd5TKY5JCpyuVXbvZhd/lQb7W3G9jbUSWN
 9Eeo2Z3WVZubIZjn9NKWvMbEsEXUmESaPqfEthBD+tjP/ueEFkCU2DCRX9KqTG6/DKzE
 a/Imc4ezYpdmxh7FPKohVfRhtpiSq+d01Yd4NkSjQvULKoMxKWIZbCcAjn6pnEgKPr07
 JTGNGmyGmvwkis23Z9K6BGU8YIzk93RSOmGaftVrkxufJiCvwlD6u+/3NkZgmpfAsd0g
 fZmI+dIpCMy/7+W/mz3ifsbjhIrDkz6+M9QLbe6qfnH4NG38ojc3zoVdtz4apRgTeJpl
 fQ+A==
X-Gm-Message-State: AOJu0YxYBd1KrsckT4GKIeBn0EPrrL1adfvauIKc/UACpg90yc4b745m
 TBaV7HfE/j8lJ1xIeDi3IABMt3ACkDoB3KviPK2H9FmD4oslrEmorwFb2WpO1CmMvxvrxDwMv1v
 1
X-Google-Smtp-Source: AGHT+IFkGztUHx+WvYStyvonb6/CFHRyOn9GYwYDgcEOAl+5IkWAP6R2vDkAIx6EWl1xBLljY1kWvw==
X-Received: by 2002:a05:600c:4fc1:b0:422:aca:f887 with SMTP id
 5b1f17b1804b1-4220acafc14mr3611855e9.28.1718001566589; 
 Sun, 09 Jun 2024 23:39:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421f23d06ddsm12019235e9.8.2024.06.09.23.39.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:39:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] monitor: Remove obsolete stubs
Date: Mon, 10 Jun 2024 08:39:24 +0200
Message-ID: <20240610063924.51154-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

hmp_info_roms() was removed in commit dd98234c05 ("qapi:
introduce x-query-roms QMP command"),

hmp_info_numa() in commit 1b8ae799d8 ("qapi: introduce
x-query-numa QMP command"),

hmp_info_ramblock() in commit ca411b7c8a ("qapi: introduce
x-query-ramblock QMP command")

and hmp_info_irq() in commit 91f2fa7045 ("qapi: introduce
x-query-irq QMP command").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Note x-query-roms is used as example in
docs/devel/writing-monitor-commands.rst
but was removed in commit dd98234c05
("qapi: introduce x-query-roms QMP command").
---
 include/hw/loader.h   | 1 -
 include/monitor/hmp.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8685e27334..9844c5e3cf 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -338,7 +338,6 @@ void *rom_ptr(hwaddr addr, size_t size);
  * rom_ptr().
  */
 void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
-void hmp_info_roms(Monitor *mon, const QDict *qdict);
 
 #define rom_add_file_fixed(_f, _a, _i)          \
     rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 954f3c83ad..ae116d9804 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -35,7 +35,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
 void hmp_info_spice(Monitor *mon, const QDict *qdict);
 void hmp_info_balloon(Monitor *mon, const QDict *qdict);
-void hmp_info_irq(Monitor *mon, const QDict *qdict);
 void hmp_info_pic(Monitor *mon, const QDict *qdict);
 void hmp_info_pci(Monitor *mon, const QDict *qdict);
 void hmp_info_tpm(Monitor *mon, const QDict *qdict);
@@ -102,7 +101,6 @@ void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
 void hmp_object_del(Monitor *mon, const QDict *qdict);
 void hmp_info_memdev(Monitor *mon, const QDict *qdict);
-void hmp_info_numa(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
 void hmp_qom_get(Monitor *mon, const QDict *qdict);
@@ -141,7 +139,6 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
-void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
-- 
2.41.0


