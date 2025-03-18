Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD5C35FFB
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZF-0002Ou-Gw; Tue, 18 Mar 2025 17:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY4-0001KE-I7
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY2-0000nd-3w
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2255003f4c6so110623335ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333548; x=1742938348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=Ug9fZVCU9vAKmyL4VhCcn2zGXK5szRjo54OJnmp5vr4Ztrg24rA/E+BhMg7WUSxVQF
 lSTcOYYrLA4pScOqViZdaeZq/2RYYv+UGGrQV2B1hgSJZ4GbXU462WYnJ8sZw4UwFqTi
 yzEhvATHchPJ/+MU5O54TyQQN+TT2zftBpS/ReL8m5dS0ldlKa9ApKN1uyK8bOloJh+g
 +NDpYLNSkw2oLgp4dIr1HUn0LQ5bIeDTnk+90ZUi37OLZ7bNKgSKugomR8laUc5BDvbn
 wHsAWBh5SL5nejLzKPLXL+biyNnWFEW19plZVD/mALj7/04rWtqAUGJJd7DREENFOkOh
 Lr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333548; x=1742938348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=CbiJvs1Ti3SKjNJiOp9iK/MbW+x6W6F/jfVujGSmIYJLmO8YwDGxMBdLEu8jKdRt0Q
 9Zod4wenyaNQSCXuygD/4tIBtWiWYb1uVyqPwN0HLtQF9K5jYwA9bqsPC4uWrd8I1BeD
 Kl9eYxSxMISGd6DyD/NrgJgwqpDfbINn0cTmXxHHyMZpx4O3JKdQIkWhNO51JNFQtC7Y
 abzitQgJBCEhpWAORRR4+or/U5e/oG42HxaEBkrA+Xh+96yaM4NxA/ttDILDAo6C6jp4
 jUgrGzyrkpytaeGDWiKtM1bgmGzp1I+lSOzpD1YxkXY7sgSEXJdVT5TFbDXyrbTYlIcd
 HzYw==
X-Gm-Message-State: AOJu0YzDxFjhkWDN3R+dvSUU/y/yhqAKkRm0jFq+jTXMzcXKJFs09Tup
 QWezr9vq2WMk8rpNB7qJmI0/Id4qsaqq4RpncWEhMQPSQbhoquiEndmg39xLPyIWV0VZKeHuc7V
 W
X-Gm-Gg: ASbGnctZH6G6gT83b5ZGicWqjSRP2C/oMXi/O/C6wvBpjUa/HYgJXIM7TvC9rR3wWXz
 ZN3Ui+F4MVolwFAGC/9S3eksZ7A2886VO3IGFjuT9re9Mqqz202nPYZ1n4GAxLSvi81KSuxbXMd
 lWMuszmUOlHTeAOmESByLrOxfhsIZKGXT+uTKEFINoh1uM2FDBrUPzDQY7DBm/YlAGy1YfuSbJG
 3l67qjSByMCR87Loq7yT5Mifhx5UxhQz7q7BZGS8cK4fvIK0SzfKhOXXr038JGLSXeWnMvG4NJy
 j6Ot0KlXDBUk2RWuJawT1g+nVM5ts1gaQLya7l7+l7LPXrbpQwzoZyEBZoxE5ifa8JNQ+yAJNo2
 E
X-Google-Smtp-Source: AGHT+IHEd94KTdA0pkgWVhu0jlVJRUgCNmZYrr5glF4pGl2ECArhuTTUjby1rWYJDajgztQVhV1IvA==
X-Received: by 2002:a05:6a20:2d23:b0:1f5:8a03:ea22 with SMTP id
 adf61e73a8af0-1fbece408e9mr272333637.33.1742333548526; 
 Tue, 18 Mar 2025 14:32:28 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 25/42] accel/tcg: Use libuser_ss and libsystem_ss
Date: Tue, 18 Mar 2025 14:31:50 -0700
Message-ID: <20250318213209.2579218-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

While some of these files are built exactly once, due
to being in only libuser_ss or libsystem_ss, some of
the includes that they depend on require CONFIG_USER_ONLY.
So make use of the common infrastructure to allow that.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 185830d0f5..72d4acfe5e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,12 +1,21 @@
-common_ss.add(when: 'CONFIG_TCG', if_true: files(
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
+tcg_ss = ss.source_set()
+
+tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
 if get_option('plugins')
-  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+  tcg_ss.add(files('plugin-gen.c'))
 endif
 
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -22,11 +31,11 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
-user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libsystem_ss.add(files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


