Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE40FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3F-0008LC-Lb; Mon, 27 Apr 2026 04:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH38-0007yR-58
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH35-0002b6-D0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso98958715e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277432; x=1777882232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/VyMpbZZBycD9uof5+Mpu9kfOlAUg4ZoswdMUmEvtEU=;
 b=vIpp4t7VkMzVW+R+oE4YRUXLC2z7owgFIl6fqZTccFUV0ljJux1pJYZhkWeJdeYLWw
 LzHxxD38E9TGEz7cm1Z4xQD8GmsOdH3djdTkaZ1KbmDUEquUVCCghocLhyISAZMf3RXD
 mjrbNxJcF2yvCiIr1vgkWav6sVC2sE8lnWP3wZ0BpM+jb/nC8NlaZIVWWcOu6AkKirLb
 ZaPs3+ADJF3vv0MbxyyAZWbqhn0mUyXgemxH/1oCrTQaFcttNqMKvHvrDRj/PmmpcVKM
 28rZGIGoEOL6c9j2+zQntEyT3usbFAN00CdQjNem/ryVoMTv/C0mRJjZaGjI4kuvTsq/
 9YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277432; x=1777882232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/VyMpbZZBycD9uof5+Mpu9kfOlAUg4ZoswdMUmEvtEU=;
 b=q8F+ybM3+gUqHw6MjvqM7Fvvyle2qCY5YWFl65B/VIGP1D2WntVCi0j0Usw2RN+y7t
 jFPdKbmZl1SZfP1DgyY+kAlnI1he4xxGwOJ9CTSnc5/8s3yfICsipZCe567DodqgFBr+
 l7HGa4fJt06+O05nW8hMZZgwbaRJznIdMK7gC3cugOiX6OXs1RF0v6x/htfIUHtI3umO
 s+a+KTG/J5uyEKoKaIlxIC6FGaCvIUY20nsEQi3ETIf0rk0oiTvDOWYEswlkVfzeAez8
 KxCCvqFdGrQHAbMm38DnxpPkVrYYnzQHaVTdBFO7bDafLvcCM6EuVlbfQvj5SGCrCuuz
 nZPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Jgb0tbXPOQJy57LqMj36Wq8tQNrDqH9+NU652+o13fO9sKB1JtrkS+StQY1fbU7IpT2hH6FQl6L62@nongnu.org
X-Gm-Message-State: AOJu0Yxnag+owCtjG7/beDkr8ONhzPlPsRfctS38YILThW9Ju6po+XZT
 SFGagPjNgfT9QvIQXWoamkso5Q6KlNgKUHZKyPbFyU8qUrVlI6hC0SRHyIIFYNK/++g=
X-Gm-Gg: AeBDiev/qbvI7bIQMfVm0FNbYN/cgJRIeB1YfIkkE4gT+IJdW+uwjAdLaZQ81VzzrnH
 NNjzvKdofAUvem/uNRmNBLI9dUz2ptL8dBkJf1TMQQVGZ5aFSSs1w3QsXXkC0pbdC+fM+eH4NMX
 2m9pYb1w9w6GR2NkZdAx7gyUq5417k1WKMMTrWajcp3uqEnsF/y7KpPUDbFt8LkgKSwpa9uBIwu
 LHnWhdQ+/tiFeDpjK4Q49dpXaB/iA6LH35QlfsdPpXGOecY4BqfK6ggdtzLZ6CRlIOPuaxHidG/
 M40cYhK+a/T0F6tqGH+VEFiMolvBlkpG9yImQFBYRXjp76Tf3MPh7srYi6YQqXHK0DtCnIZ/zTI
 sDe+Fqe7C/uMVnAvwDZqIqq3mTRGVTsNDF38f0V/c+rk4B2gSLA68maAA10ZESRX/wf6MDbstOy
 nXKPjAuLgwZJQJnJLDKjBZW+oDxY2lCxkYaLy4g2F8U5biiPZyLH77fsH3ZHjyWDT2G5IUK8JnD
 UTg9xmFitE=
X-Received: by 2002:a05:600c:37c4:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-48a55017b71mr410419755e9.18.1777277431729; 
 Mon, 27 Apr 2026 01:10:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7bf7besm280894725e9.34.2026.04.27.01.10.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 25/32] monitor: Forward-declare the MonitorDef type
Date: Mon, 27 Apr 2026 10:07:31 +0200
Message-ID: <20260427080738.77138-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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

Rather than having core header forced to include "monitor/hmp.h"
to get the MonitorDef type declaration, forward-declare it in
"qemu/typedefs.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp.h   | 6 +++---
 include/qemu/typedefs.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 8abe3168924..22784bd4c79 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,11 +24,11 @@
         g_assert_not_reached(); \
     }
 
-typedef struct MonitorDef {
+struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-} MonitorDef;
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+};
 
 const MonitorDef *target_monitor_defs(void);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acea..07f2ae7c9f1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,6 +72,7 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
+typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
-- 
2.53.0


