Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C61BC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3L-0004XO-S6; Tue, 28 Jan 2025 08:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm36-0004Sg-Tw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm35-0006Yn-A3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso40353585e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072476; x=1738677276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFX3tCyD8J8AsK027Or5bRe/fC+DXtJLFTNEYqXZkJ0=;
 b=KzKpqIB1fQ7eS0wvaQ5VJeIJBGjxaOmmXyMClK+RF/9ckMQ6+rE7Km4rR044ramPNV
 nhLZPoLpk+Dy/4HPTykpdyabeVL93qmVxpbNnOAcd2mbC+2yI8pVhUN6TJVr+SCXCYdp
 4SeL50RgUFJNIAGmwjbdV6J93Uj1R0OvruLRX20XecQEOE0yy5iE280FYr6SItvPeSID
 b2QZUjwKuLAduAD533iE+godwxiwaO+IXEV6zX06GG+tAOkpnMhf90PRbHeOBP7OGX40
 BVzHiv3HCCjse76yZMIbhls8XAgz3ZoHtzrWda+IXRan8A1TjMvZWiijXd6PiAx1mOe1
 cQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072476; x=1738677276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFX3tCyD8J8AsK027Or5bRe/fC+DXtJLFTNEYqXZkJ0=;
 b=iV9hWeIZfqSYZfKq9MLp1UAzeXH7sE+O9XTRoX859yRH77uZGZQ1+4WW0JIRz3cSSw
 mvxYA5iR12w96VRZx9mf34rGWYeKENO4Wq4zHYNqzIINmmojJ8jRFlIUIntcfj04QayV
 qrqnH4Vf8P0+s/oOTNe0fYDV1PFLN+v0xuOFsMTF3olBQSRDFxRZpv36jDegBhl8tcBT
 u6FhQZEJCB25JF1XG0KwRfTWWzU5ct4JRES+Gqdjo/NTRUr0JzP/RT/26G+I2VqUq9tz
 7Xlxag19bZ0ctHZawd6LEGAiiXSl9rakiF5tuhdqMQep8xp8YYIQF2pTBv78Vvp7VAMB
 A4AA==
X-Gm-Message-State: AOJu0Yz35AB+W36g2FPK5CQOXzotD+febkN5juDE7UGZeQpJYMgE/DvP
 0K3prAFMja5l+D+1b5F11RR7nyomvPuDDhydBX86GEonyAsGi4x52Gybl4ygR1y3k11MgPp3IZ+
 TVNg=
X-Gm-Gg: ASbGncuK1591MMN8tB+fuKYOSKEgkg5/bqtMmwA7ltMFsznuTZgLpagJy2LM4xlKMVt
 ojKOl7L6XpOsRDM+sBN+1xv4WCr1OHc9aKqSVT0tjRRcyNf9g0cJtdiIdFl+KCvb9Bk1Hdd6pFY
 PCTBV1yo+gnRTBajmkS3YV/1ubzvklJA5u2E70uJdNs2DCE28i23iTZzaSGHWnViuuixPQeCP03
 yjgkngZ3C3/slQzB6rjReeQS0moPyVrrZbm6k8hkZfsNqwm6rFgm3a3k7XNZuJGMdAejEhDQnf+
 K4WEztWerLUGxY8PqOu+eDBAqOdez+L6/dsyNyWIbhLuIWAb81hQl1b2CYz4ESmq5w==
X-Google-Smtp-Source: AGHT+IFACyEWOGSeWrN0Jbyt1XTZ0wcCq1PQoT8zk7QDW032i2AACfFKvtrPgaE6qgWr0/IwqfDm3Q==
X-Received: by 2002:a05:600c:4f48:b0:42c:b16e:7a22 with SMTP id
 5b1f17b1804b1-438913cb740mr458739165e9.12.1738072476039; 
 Tue, 28 Jan 2025 05:54:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd5730a6sm167998125e9.35.2025.01.28.05.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] migration/dirtyrate: Do not unlock cpu_list lock twice
Date: Tue, 28 Jan 2025 14:54:23 +0100
Message-ID: <20250128135429.8500-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
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

&qemu_cpu_list_lock is locked within the WITH_QEMU_LOCK_GUARD()
context, then unlocked. No need to manually unlock it.

Fixes: 370ed600296 ("cpu: expose qemu_cpu_list_lock for lock-guard use")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/dirtyrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 7c955894e47..4b94dd7c500 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -174,7 +174,6 @@ retry:
         if (gen_id != cpu_list_generation_id_get()) {
             g_free(records);
             g_free(stat->rates);
-            cpu_list_unlock();
             goto retry;
         }
         vcpu_dirty_stat_collect(records, false);
-- 
2.47.1


