Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF189FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUH-0006nB-EF; Mon, 27 Apr 2026 08:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00086E-O0
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNj-0005g4-43
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso109080205e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294089; x=1777898889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YY1tm1vPSzbBUTbdxWQFuXKrfsrK/NMFeG62EkzTKa8=;
 b=evL/9kjqwa/E4E1a/+U/HMKpW9w7tbiIXmjvEHRMbQRYuoXtp1PtriTcJG3+vQH6jr
 qM0Lycr1vdZSaISbPspR5ZucYbwtzId/5H/StETcMC3i0e5pqcm62hUuLVG22B8cEc8e
 RxfxNT+zHL36xWsmrOLdBgHF80VLFjziivTuibqVJEj4hw64cragtm6m5JSos/GPczyS
 ZyqIqvofDxOEc9Rwm5UOlceaClfFDcJOdBNw7TtNL9OEmjzOMDqkWbwPeQ8vmfjAObSJ
 9RMIVd7KQ4YYYjwbQ714ZUZZnP8R34ZN3cD+RgYZv/OOxYz++uTWk3dcZIxWT2YshZ6A
 wptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294089; x=1777898889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YY1tm1vPSzbBUTbdxWQFuXKrfsrK/NMFeG62EkzTKa8=;
 b=clsC0eAUhBxJRGqPuUikUFucICPki/8i3r7F+dWjeaD3VCj1hUpPAR49fIscQEaouu
 Ey+6mcYRqTJj0rwv0AyNOpaVdp0KhXvXoaXPPE/feib/0MXS3lObeQM5fHKsvUo6CGaY
 VqwDY0Xl+fS7+UpIbNfwKwqzJ3UfR4IoXGYrJYs9UBEqOPvufeHLT71w3F8mE9YUwhbF
 Y/tS84DzEVlAwrAiIcCtvZ6JyiFXi4NOAD2AGB1K2ylMHFOA4cp0rxTPDh9dSm3cBtId
 2hWXK0Fo4DJkRhx7Wdv1HDxKBS2YQV7dpxFNskGkKdpaJMmEC3UzEJ21RsLedTg46Pg7
 DCOw==
X-Gm-Message-State: AOJu0YzxqM1KKABZgt9dmvmaUAhfJC9f23506JQ/o53+1qRnHTT3htmT
 DsP64DQg+hKehLtq9LEtfkl0Yrlscqyg7kjSJkpLnsoi0bDnf0OwZI3s9IjuZZw/tFq0cE4KNnL
 8vby/
X-Gm-Gg: AeBDietcBH2zIQM+pe5TKZnA12QlVGE3RpfkX0WB2cHCiPuymOO1hVzHNT4NApOm36F
 j++an1h0d7UkcDMBGejhUP2uIY5oOa64PcEiw7+lvW0dI1Ic4ef8uA/oHe9R9iRqDM8vlellli4
 J8nOAgC4asTeCWBX1nQXuHgwu5Uvs6aNw8ug/Ncq1RZRuqWh45v7SAIKl83lln7JyCgCA6P3k4B
 LOfC7/i10Wyjma9CGvTj9XJMgF2ejvtpPqNAJ8h64Qsl55ZT3sQTwf0TzK0LaKxchdv3eJ6zTYA
 a/s13ds8Al8eCcJL4B/ELIXpZ06Bg+LlEliDuqkK1q01afI59CBM0FltBHo5hPoh+k/rjyrVuvS
 PNbqfd8FAwE31mzVMeISJ+idOr3fRlnjsVi9m7xDwiZLD9VKb+jT22k78WOhVAxgmHc+UJI5Ki8
 K76xopTgacmLWz5KCR8ZM8MjloAdVQou4tlEY+awa7vy3Q+tChf9kx7mHQbvjxHJcTimbQpFwmk
 cil6c1AjHby5pmirrjKYGUlyB4OzBg5N6RjgA38zQ==
X-Received: by 2002:a05:600c:19c8:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48a554dba51mr430812665e9.6.1777294089274; 
 Mon, 27 Apr 2026 05:48:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/63] target/arm/machine: Handle ToleranceNotOnBothEnds
 migration tolerances
Date: Mon, 27 Apr 2026 13:47:06 +0100
Message-ID: <20260427124738.966578-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Eric Auger <eric.auger@redhat.com>

If there is a mismatch between the cpreg indexes found on both ends,
check whether a tolerance was registered for the given kvmidx. If any,
silence warning/errors.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260420140552.104369-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c    | 21 +++++++++++++++------
 target/arm/trace-events |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 50d80ffb68..b2bf129334 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1063,25 +1063,34 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
 {
     g_autofree gchar *name = print_register_name(kvmidx);
 
+    if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          0, 0, ToleranceNotOnBothEnds)) {
+        trace_tolerate_cpreg_missing_in_incoming_stream(name);
+        return;
+    }
     warn_report("%s: %s "
                 "expected by the destination but not in the incoming stream: "
                  "skip it", __func__, name);
 }
 
 /*
- * Handle the situation where @kvmidx is in the incoming stream
- * but not on destination. This currently fails the migration but
- * we plan to accomodate some exceptions, hence the boolean returned value.
+ * Handle the situation where @kvmidx is in the incoming
+ * stream but not on destination. This fails the migration if
+ * no cpreg mig tolerance is matched for this @kvmidx
+ * Return true if the migration should eventually fail
  */
 static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
 {
     g_autofree gchar *name = print_register_name(kvmidx);
-    bool fail = true;
 
+    if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          0, 0, ToleranceNotOnBothEnds)) {
+        trace_tolerate_cpreg_only_in_incoming_stream(name);
+        return false;
+    }
     error_report("%s: %s in the incoming stream but unknown on the "
                  "destination: fail migration", __func__, name);
-
-    return fail;
+    return true;
 }
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 2de0406f78..8502fb3265 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -29,3 +29,5 @@ arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 
 # machine.c
 cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
+tolerate_cpreg_missing_in_incoming_stream(char *name) "%s is missing in incoming stream but this is explicitly tolerated"
+tolerate_cpreg_only_in_incoming_stream(char *name) "%s is in incoming stream but not on destination but this is explicitly tolerated"
-- 
2.43.0


