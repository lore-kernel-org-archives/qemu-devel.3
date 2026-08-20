Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C41C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yM-0003vI-5u; Thu, 20 Aug 2026 12:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yK-0003pk-5K
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yI-0005Q6-EO
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4QwzswuwF0jepQXhCEoiysrwUOjMxfh0RxhCZqzITw=;
 b=FfCEmYMON2ZNttG7OzKVy7JvAfQArT02908+7bpDGbbrH/426MzfltZtB3N947fxi/dUPg
 8pZfuesYQeMETKjFoWIGuH4ffXmc4YjoqVdiaPu/jJRlT2GO4rH9Wwt2GbR5HQLkIvI1dD
 sp2jiH7zVlhQCuB9PiwUDbBDyx9Rswo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-uzT5gn-tP_K3F9ZVcDyzAA-1; Thu, 20 Aug 2026 12:50:27 -0400
X-MC-Unique: uzT5gn-tP_K3F9ZVcDyzAA-1
X-Mimecast-MFC-AGG-ID: uzT5gn-tP_K3F9ZVcDyzAA_1787244626
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso224495e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244626; x=1787849426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+4QwzswuwF0jepQXhCEoiysrwUOjMxfh0RxhCZqzITw=;
 b=mNf5QDEaxoCYKQceqhdJb4rbKg6qx7mfljWrm4JlQeUt+D9vo1f47R+BMhl5/zMb92
 Zyl/xlF1M9vNanVYHZPPlvkqwaai+j+xcpGHuUlBV/4gyphFAdGtNyeibfDvY1R4GC/x
 wp7J8p1b8mXne8Ti4cG82rqBmvKQo5Zi3d2xXvBgFk0WU7ezh4tc1YtK4Ktwo8XsQuGI
 PKTOgoZZ07WUKETdaP0YwvEQowBUjzxWPecDJuC+9zDGFtg0LOZDSyqZhWJ5HrN7QqE1
 z3b5MLmK+AWOSQaNmiRoWzThfS4zMsmDFBdJ8oxQiSteQvLEgFYDATpNs9EsbuAQsrj2
 Rjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244626; x=1787849426;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+4QwzswuwF0jepQXhCEoiysrwUOjMxfh0RxhCZqzITw=;
 b=b4mpv4BAm9VL0i35iMG+HHeQtqtXW9OiIxO5xRdaYcGIAncUzjISzrkHTUn4Y74UIx
 KwqaMd4tVXNMVnb1QJcRwG9RULetRLrp53FGuUShveMjiPfttDLg1ZZ3kIYzvuWVUp2Y
 gr6HbmyTD1BxoZnv57hwBq3JmW4g8fVe8eS2JbRmGc+/tKAYI/hQWY86aqHpJHmYg2TV
 HRkkdxqvmehAY5e++//YaATJ/fidvm1rusNOawbkSoDBPpe/euvhU6uPSQgxYdSZqEeu
 d+ZorIcrqJoMNiiEtoppC6ymRXjo7QAQjdTYEnGQu1CBSPh+CA3cjBfd3KEtG7kjv/Wp
 w7tQ==
X-Gm-Message-State: AOJu0YwMYadQFb0DasbdNucf0beOVsYC68OIIWJR8oSxeGFta7pEvQEU
 XfL/58gvTomw1srW71HlK9YO1pQ3+TSzbqenEXBn4DajJ6Qsu9TBF12FHBgan7/ecTajJIlk8hN
 Lme6VSelMu/QVdULP49ANhCmUq5pcts1x9aH6xclJRvr3udJAjssVN98K75bTvbNAG/c1WbHjcA
 dUdEYFQPfsLtnK9iKZajODLhIPuYexIcwyYwwnp58m
X-Gm-Gg: AR+sD11iazfGHBKCt3szKlc+c0qikW/dpU9FZDM+OwYIvuAS8vRH4mAN2SthXEADeoU
 jw+3lv64hlSj79eZHLiPTNskFSFLl6EboDIhtBvLoW7UQFHPuklR0iNm0+rICpqOWHo/XmfNUJt
 Wx0l6wErAz6WmH7+Q9xtRTYT0DzRwBq1eFkkkoKzNidty1q84T6qd9rEbLu5TgEsPbs33MwW+Ei
 Ry5yCHaZZUmn9wW/wLTwKTUCxvHIoOVZuJGuPhrlVh93SQBBzdPAV8iFMN7XrLPSKqXh25SfHzJ
 mLng/7Wvu8m9yHpvuU9djPrb1Illz7g4ZUdHTeqxebeXN0UkZ+L6MnSf5vDEIOc5/xWVi9ulqgw
 C8Tpw/WtdtVU7JGWKJytRrl2lcBAzRWpBnGM1hIM5J8yL9NQx0YAtbI6tY+Nh7nJCZxxgvT9fka
 1YIyU=
X-Received: by 2002:a05:600c:a44:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499b82f4158mr4221125e9.3.1787244625836; 
 Thu, 20 Aug 2026 09:50:25 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499b82f4158mr4220365e9.3.1787244625437; 
 Thu, 20 Aug 2026 09:50:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784a4sm151237485e9.1.2026.08.20.09.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 08/53] target/i386/mshv: disable AMX TILE features
Date: Thu, 20 Aug 2026 18:49:11 +0200
Message-ID: <20260820164957.1895963-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

For the time being we disable AMX TILE in partition processor features
and CPUID b/c AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds
the current fixed 4KB XSAVE buffer size.

For now we filter it until buffer sizing is computed dynamically from CPUID.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-2-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c       |  8 ++++++++
 target/i386/mshv/mshv-cpu.c | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 72721d0f0de..5e8756ede22 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -203,6 +203,14 @@ static int create_partition(int mshv_fd, int *vm_fd)
 
     /* enable all */
     disabled_xsave_features.as_uint64 = 0;
+    /*
+     * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
+     * current fixed 4KB XSAVE buffer size.
+     */
+    disabled_xsave_features.amx_tile_support = 1;
+    disabled_xsave_features.amx_bf16_support = 1;
+    disabled_xsave_features.amx_int8_support = 1;
+    disabled_xsave_features.amx_fp16_support = 1;
 
     /*
      * query host for supported processor features and disable unsupported
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1c433c408c8..8eca01a8fae 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2156,6 +2156,22 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
          */
         ret &= ~CPUID_7_0_ECX_LA57;
     }
+    if (func == 0x07 && idx == 0 && reg == R_EDX) {
+        /*
+         * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
+         * current fixed 4KB XSAVE buffer size. Filter until buffer
+         * sizing is computed dynamically from CPUID.
+         */
+        ret &= ~CPUID_7_0_EDX_AMX_TILE;
+        ret &= ~CPUID_7_0_EDX_AMX_BF16;
+        ret &= ~CPUID_7_0_EDX_AMX_INT8;
+    }
+    if (func == 0x07 && idx == 1 && reg == R_EAX) {
+        ret &= ~CPUID_7_1_EAX_AMX_FP16;
+    }
+    if (func == 0x07 && idx == 1 && reg == R_EDX) {
+        ret &= ~CPUID_7_1_EDX_AMX_COMPLEX;
+    }
 
     return ret;
 }
-- 
2.55.0


