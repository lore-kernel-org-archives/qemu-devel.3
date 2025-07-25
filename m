Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D1DC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOwN-0000xR-91; Fri, 25 Jul 2025 16:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrO-0005s3-6i
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrM-0000pN-2r
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so1875762b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474658; x=1754079458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E8h6PUuy46iYtWk/kPGPrLRfA5dKcU3GTa22nF6Dz0=;
 b=C3zImqqCyUnoIGbhrWXiEZ1jiRfgk+pOlD9Izqm6Grae7tr/uUho+Hslg+QvabMXRa
 LXk+Qs9f1Rjix7mUkvz/L34WdjXEadpPHFYdMeyJ78kjhHPsSQSDI//Ww4pR7n0hS1t+
 8jNPYNYEZjQajsboz8rgcXQAoGK6jkGC2RGs/eQzuoBPcwYOrv/K450xtBZ3JiKCa0+u
 23g93dUNJkAw3Op0SMfeBW6PghmbBQDpkJmZAMlpOhoelmtxFq1gNiq1TnzrYbc3KLMY
 +tgelWz1ujxRXwVFeeFYyE/QlvA3u6eL5hQHexmouBtnUlN18aETx7aY4+Uh/GpcwbK0
 Mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474658; x=1754079458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4E8h6PUuy46iYtWk/kPGPrLRfA5dKcU3GTa22nF6Dz0=;
 b=QqTBTu3hOyrKT3kdkdd7jHk/++Yk+42hl6XaOlBThnX3YFDgnh78ixrC7arPAzmtUl
 D2OQj96fFRca55691lXT5zpXeAGhk+/M6zLCbqwiuIwGMi4Hr2UUwxVjkyQvD7EqEwyZ
 qw8do26GxY1wcDnWLU6qW01ONf/IR81gMZV7fT0GDBLjbcs4WYf+4vIFX1svLVcsIugZ
 sPOUdIgOen+iLQFNnhK3gBVb/8m8th9P3zq4P3+Tod5fHOsILqykkBq+6+tXw1d0UQMB
 4fsoEyscEjFFWIcE2XpmR0ixkxjngZ7zh1v3qFbSN19w9FMflX+Yimrjk2i6Se9+PkiE
 Iqmg==
X-Gm-Message-State: AOJu0YyJkWR+EUuONuqei6H14W2+UGRDrVcVwHZsfIKpKiS8WAnyjaYq
 BT6deIGSzsVafB3lW3k2WFSH02ICd2NakiX+Oe+WwLg9M3aH8TOD3o5iGZpNkZ28hultTzLk+DN
 5Hknh
X-Gm-Gg: ASbGncsoekuA/6jj3tbdTOf2gwKuAhBKhfVB8C16le1wbXlj5lnegDMw5ZhoMRXoYhl
 RCT17XJGsHAS0iDFUWCN4ASN0DKwV/3fiU15PxkNJQvukpFuKFP91RR2OscbEit43r2PhsPbv6r
 Xt7MEYldtoKL64zqCm2cmJTr6BgIUlAGLc4yrguIznJMDPDTnheeeGlfoxLcQwaIRlvittFoikw
 R/IZhZkAHY4+MUmIFFMjA3Y3H/HSoMW3SMdTtD9CN8VLce0fLuRJwMnv685q4h8SCf8mU5xL2OQ
 0p0feqhryIoaQ/VPMhC8dU3lzJ2DxYFVcn2ypiMws1fgVdL1kwqi91ipOXQQbyTZHtxYZ5cs2WQ
 TVC9wzQyO5Gg3m5LTMnmmYA==
X-Google-Smtp-Source: AGHT+IFN+s2lu3GbMNOFf+FIWoUvMiLEKIpWxBQKMonySfwzXEC99bc6ALS3Re9XSESfnqsEUcsAIA==
X-Received: by 2002:a05:6a00:14ce:b0:736:4d05:2e2e with SMTP id
 d2e1a72fcca58-76335985230mr4853238b3a.6.1753474658312; 
 Fri, 25 Jul 2025 13:17:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408c023absm383611b3a.38.2025.07.25.13.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:17:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/3] migration: compile migration/ram.c once
Date: Fri, 25 Jul 2025 13:17:27 -0700
Message-ID: <20250725201729.17100-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index 9aa48b290e2..36fb950b3b1 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -31,6 +31,7 @@ system_ss.add(files(
   'multifd-zero-page.c',
   'options.c',
   'postcopy-ram.c',
+  'ram.c',
   'savevm.c',
   'socket.c',
   'tls.c',
@@ -50,5 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('ram.c',
-                               'target.c'))
+                if_true: files('target.c'))
-- 
2.47.2


