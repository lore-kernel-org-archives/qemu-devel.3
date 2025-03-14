Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782C3C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tr-0005zg-67; Fri, 14 Mar 2025 13:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tC-0005ck-LA
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8t5-0008Gy-O4
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:02 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so62105425ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973518; x=1742578318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PABH8iZPN9WF+wJr72ZMp6Lm7i1C+9jWBJAvssLik90=;
 b=RigcekInGiGOc5YBWHVAb7RUpSErD0BgiyvMOpduGne9YVutA9AXx6IkvO4qmIb1+z
 R8ScThTT+KIO7cJrAeEhpojkUWNTA5ezfgWvBgU1WUspo8kjXKWcO/OhPMaUTub3GTA1
 2aw9jSYKWpp/kSjHfEKwrsouLQoLoHLycqTiYdjbkPG951OBpBXGCdNuQtQduIQuOjxA
 pZ0aL7clQO8h2W1CTPv4UZm6tFeOcwvquV9kd0gVXtCuaGSX9e1E+iIGXHmICHphEza7
 sCTiVPs5R6G5YK8ozHNw1WcRXAUDE2UrbGpRgJKt++vTqHWiStwuTmnS5JuQ+8N3WQSk
 sRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973518; x=1742578318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PABH8iZPN9WF+wJr72ZMp6Lm7i1C+9jWBJAvssLik90=;
 b=oITGXpFiNERy3AL+vCqecvWhmyBjHuWtYPUwyYU3Zpa3FJSrnA11WntNYwn4UQNnkN
 OIQXjA3wMhjAs2ZPgfO+Du0f3KDNFWVP/ZUtJ7cx7QjaqIfJ1wdKnCzjJytZ9Siy2vNy
 Dpd3gZ3fjBy8EjwUk8/lWt3YD4vKBYaWB7K8Z5D8fa4hgLnQz9vbN/5fh6EBrnMyXeGI
 sYEQ7EAtCvs88cX3rF2+HsMhOEeefGkrwOBJ9kKFUqJdvRusyf9urzSNE8fbMP3M5VPx
 BN9kDCgF6zd2fLiWGpEx3Y/DiOkY7dqNTRpRuerL8jqOYedQUi5b57CJa2zNHHqhPdKg
 mB4Q==
X-Gm-Message-State: AOJu0YzNYUeJ/XxvSHGuQTjbMzqofrEA5baDTSK58gcVFGG+AabVQSoS
 mcEFRzHD64Dv9ju92hG4thsu8lHXt00le1b3pUdIAZk6t0A9zUB2y5qxtshrSCGIgsByJZZMCEa
 lTSU=
X-Gm-Gg: ASbGncvlx6LxKjv7bZprMDZaPk4oEXtsa7Za7QFSdnal/2MPr7hiKblXNgshgqbQc3h
 QnExyUT6p/Hx7vk8R/zA1r+fpr0eJCqJPFtYqmhKvkH+0sZzGkQ3QisMVA5Rhd4cGiJTGgcFnxp
 E3ZnwYv0b6mzP78WrFZ37/DnxCMZ6cwp538hsAJWyeerhovYPUjhum4AxWyEs8rUuKTQHrnCw9f
 CWmdY0pYb1M0552uCjVB3CzM10QYdo/RAvTmufbGowPgls+gmll5/8ENQh/wutFIXWFO928cvid
 ft9FwCQWAMw/3n3J3zgERORB9t3zXvnPiphE1890vn7/
X-Google-Smtp-Source: AGHT+IGnTvSqXO1fzlE+2xVmojsF7Bo5wJQ+q4TppfmkSKTjR2FsyvyfU5Ot+87AVkRJkvXuDcvBmA==
X-Received: by 2002:a05:6a00:228e:b0:736:562b:9a9c with SMTP id
 d2e1a72fcca58-7372242d387mr4348766b3a.18.1741973517785; 
 Fri, 14 Mar 2025 10:31:57 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 11/17] exec/ram_addr: call xen_hvm_modified_memory only if
 xen is enabled
Date: Fri, 14 Mar 2025 10:31:33 -0700
Message-Id: <20250314173139.2122904-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/ram_addr.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f5d574261a3..92e8708af76 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -339,7 +339,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -415,7 +417,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
-- 
2.39.5


