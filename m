Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F26DEE3692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvK-0005qx-6H; Thu, 12 Feb 2026 09:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXv0-0005OJ-NH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXux-00068F-76
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MC3+KU0icfjmOgw8k+VWmnV40sQ8cN56y9GBvwmJBjY=;
 b=GEZfycfyd4qL5JkEfX8bnHFVOcEJsdNO2HBweA8E44No4zVeRsQp4agsZqAizMcooQXw57
 LYq0CpE9Gybj/DGYtazr7Y7yFt2o4ncA3StXlYgUSoS247qENBpplOh0lz1fFWFp/GBW9B
 h9mxxBGiBfbxvIv5/6ElPecFIQhZHd0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Qel78NACOf-7Oho0y_rEGA-1; Thu, 12 Feb 2026 09:43:38 -0500
X-MC-Unique: Qel78NACOf-7Oho0y_rEGA-1
X-Mimecast-MFC-AGG-ID: Qel78NACOf-7Oho0y_rEGA_1770907418
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so55402655e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907417; x=1771512217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MC3+KU0icfjmOgw8k+VWmnV40sQ8cN56y9GBvwmJBjY=;
 b=FfBtYFNILZK29ef6QYjuB69Nr/aAgm/lUuxh3rhG5di2MtSd/sWyQiGMgyzW+XcCZb
 t+khgACePbw/panGHDO51Vx4ra1voDeNVt49QHegmBK3hO7iU6rBmIme9iTW6AFtBLX4
 lNy6y+9OwU8JLUV1oP81Aoijfe8QL7m4jPft5FTw3dfOqfq5ASjJPsgrZEqsBtKRJ7Lo
 xasw1WnV6bopv+3mgAdd/4YSRHD9KfKB7EVVxqzSYTpA2uPZ8YK5nqoKQeYX3+YiR0nU
 ld1jYrFOY1LRzlBX0tfDagmTzAa3RyL+00dRkorN3zJzp8Ha0Q5ujRrYe7mH+zbDnZYL
 qTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907417; x=1771512217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MC3+KU0icfjmOgw8k+VWmnV40sQ8cN56y9GBvwmJBjY=;
 b=Un3T/rE5d6/36JU0xzDAltii2j5pkzastv0dS0g5gKzu1gE3HU8BoFxOEf5mWE/+iz
 5bmvFqaZOH8QfBMtM+3lEqse2La+RpzEZV1K7Wkj2oVayYZU2tFIYKwxblC970Ck7PgT
 M/l8fB3W4X6SNFN2d2BkZ8ZxbfG3xsd9GrM5pcIED5rRxYymH7e0MnKE4Wyz7j1hKniY
 tp1Fd/QcpAtau+YOUtXfw9cOtewBx0jXQx9LGP0AkuXNCv0EMxAPUIMgaKBisNlJHzUG
 VMVxiPNsZl9FMjxN5uGlWKDAAnY1fPXwOUDsHt5VJ0+OwsOzNDmGXxPpYrnqYsrkYJSl
 IwDg==
X-Gm-Message-State: AOJu0Yz9Ipj8Tfjlt8vu6c6sXdla5tEOCPcrFkPzGMEI/o6Man/gFU+0
 W//P20rmOgJudLnVixLy64mqYS1FHxPYEgzKaUl5DMazZNrHApFr6f8Hxg3puUQS3csipuTkxhU
 l1XKoZh7dTFmSxtl4fUPENtZjkCnLkEgOAwu4OymPraayBElmCujrzBUJlPjtGaJukBfzazvMwL
 TS1F7PZvoAim3tkewPeS4BE8tZSH0YG6egnBnBq+A+
X-Gm-Gg: AZuq6aLxF8blzpaQhtnSBLim23HHvgzTj1IcymvXmLwT4vvKlzD3ZUpyQ93PMF9eMjC
 Qfwl8Ws8BQqcHuokydRv9oPEYU+PnjJVI8nraIxtW18QXKELBPJNj1XIth3WxU9ac/gzIZzuekH
 B08AvXERHQk/bhrwrK0eRP5XSW6QlEiGKKwJZeRHlkKoFAerQH/dEE6qAEvDDoTLsHW5UasiLHn
 kKCZycP3X5cSBTSvTAvbck8LrBvt/oD58kUFaSs6hlkyFMmUvo8AVRYeAxB9f4v4NhB+SjE/+66
 cFvzBFaOwYsrinkCiVyMq0Unbxmq/2UHstOj/ysuP9wMQj0eI+yv9JCMt/boApbkmAB9kBMxRZJ
 PGJ4ExTlq4w+17fT3cGY9IoEhzs+cneb8DB1iOLXBJ5s4UM6o3SnOVpMdNK4C3jyly6b4zRJRWj
 YEqskMz2zKMgWlqDjy1WAlZa2/2+4P5TDcr2j23IqGy5OT/zSV6Pg=
X-Received: by 2002:a05:600c:3e0d:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-483656ae35fmr44964505e9.7.1770907416938; 
 Thu, 12 Feb 2026 06:43:36 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-483656ae35fmr44964055e9.7.1770907416500; 
 Thu, 12 Feb 2026 06:43:36 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm101547965e9.4.2026.02.12.06.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 22/41] hw/i386/pc: Remove pc_compat_2_7[] array
Date: Thu, 12 Feb 2026 15:42:24 +0100
Message-ID: <20260212144244.22579-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The pc_compat_2_7[] array was only used by the pc-q35-2.7
and pc-i440fx-2.7 machines, which got removed. Remove it.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-22-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d6d54852375..1cf88c16975 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -295,9 +295,6 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
 
-extern GlobalProperty pc_compat_2_7[];
-extern const size_t pc_compat_2_7_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 12f139c6798..5a70e5a7da4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -256,16 +256,6 @@ GlobalProperty pc_compat_2_8[] = {
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
-GlobalProperty pc_compat_2_7[] = {
-    { TYPE_X86_CPU, "l3-cache", "off" },
-    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
-    { "isa-pcspk", "migrate", "off" },
-};
-const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.52.0


