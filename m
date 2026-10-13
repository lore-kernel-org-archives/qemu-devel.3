Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E892CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGkcB-0001LB-SZ; Tue, 13 Oct 2026 18:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkc8-0001KR-Tf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:53 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGkc6-000611-Vl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 18:04:52 -0400
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CEE53F4BE
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791929089;
 bh=G2hpG13YabfCyUAcMOEObGBz9CyjT9IcqeL+5/8o7RA=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=cA6JtjHR15NIQiHrplLOfhOqvHGKNN0o2kxGjAj6EzeMhTiY1joMpD9PB12Mlaxw3
 Q1v3mP+R4Ag6bNoy5CK4ZgAB0VtVyuu1l6QvT6/fDkrzG6WspPlA6FOliOwSQKrDS1
 yez8Tx/TOowZxW3lMC1ACxSlzFjrxywl3n5uZJbR/Mb30KIwdlk5Ln6oQOlXQp+qBC
 G7CXr9VIBlf1a0F2q6ELz24SnWNwL/C0hm2IJ/z/dgyv8j8dy/nxkieqNzd1QqfQPH
 YmMCp+e6gD8opQ+a9rTuB9Tntnx7DXiu94mjbTPfqPTgwxsd1uphTuGBBww529pK7p
 yxJGrjP1Lxo7Q6vl7NOllu9udSp3ypTVd0PHkcrpJYUfcywipLO8H94cBs5OJwwuxK
 FNtxE1r3T96QxjJynAJz1OSUVrRWvhcOLSFr71L9y6DS5hnuD2eJyGOiNtBsQPBzu6
 /bDHjA9U2624YRudqNgveYAvOwn9aA3Qw+WrNE5PczexxWvKYRBf7EO1x6abfM+QMc
 FNwbitRrNPYK8dszfPBTmvb7WIbxBuWVPhQ5x+V+z4+g8SuAPFFIL3jQxadNBfSadQ
 tV4ClrzlARLd5I/2cIuDSkLp9pw4wOyaaWoF6M1M1SuJ49hGIIdoIZhGpoDIBsbJuR
 kkXO1GFzzIjq272o+/UVvhTE=
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67682d4d684so3890422d50.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 15:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791929088; x=1792533888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G2hpG13YabfCyUAcMOEObGBz9CyjT9IcqeL+5/8o7RA=;
 b=S56cLYlPIBTZSwJUHr3cYFhQoawvozQj5/PlalOl6E/moBq1fVJzoo2U1EHjkYGaqI
 VRpIP5DghBgp4E/x5jsiZNChL0GW2tokSC/fXjnh/8vshW1rxmNBFoQEU5d8VelgZx59
 KJ6RHCvRI9g/EKh9l/uL5CMByES6QzhdDAcjQU6p2OKU0Yzm42KDBXrbGfmHnSLQlfsa
 MIxhuSXxHxkbOz01JVwh2NajVjTyvdeq3o2Pm6BJtU1Oso+GtvS3Xv2i53+3KgIhSojM
 N0Mg1HCdrHuIHRgWwViDZIfy4oFb4nZP+QjGGvnCs1qF5w5gp05aekIZvN2s6mezojEW
 HD1g==
X-Gm-Message-State: AFq9FYLe6k9JAUWeLT3wRHfy4zyaThS8suocfVzf57iB8hY9cqc+KTuQ
 bo4jTtcmo91uyPN1S6gmTpvGXtGjGsCHRoBYmUP9MBzmVAXpDKc9jLoS+1pTKHFmwg6Ze6lmNTO
 ixx6lEek1gR+wPEHJVKRilCrbcyrtT7Ro0HKEaF1qoeKWv5UqZqkq8akQphlg/rlgv2nUrfJm
X-Gm-Gg: AYBFou3ds0vha6nv6UlHnMdPBQJ0zazq8XxEf70PGKUMLe0U6FcxLN1MntdIO3EeaWO
 J5x6PWVJgYN0gzZ2MXZ6KoOqIHJfjKV8Xfq0oCu5KoqJ9gc5XHoMXn0tEFTveayGpfuluvvlToQ
 SN2fsXdMTJFK70D3HwZ6k2dVyw53BBibVvAG7IjqxE7w847NH2fPuvjWYREN+oLKEEm0vZdABDO
 yasQXVJYgVXVm9R1uNjlMNtOeqmoxTwFOUbxpbnb5nX92Kz40PA2ooC6kWt6VNSioLR86Ie3tEa
 3Xli3gB0QPN1YzGu5M5bGl2NKA8dxinOmgBtFbSK8ow/2vSvt+u3YaO2NeJ2r30bBrLYzCytCvn
 L1Zd358xZQUaBKbfIZeKJLV+F12x76yJmbPjjLH2bbKwdQA==
X-Received: by 2002:a05:690e:441c:b0:679:24b6:fb42 with SMTP id
 956f58d0204a3-6793601374bmr2624512d50.31.1791929088183; 
 Tue, 13 Oct 2026 15:04:48 -0700 (PDT)
X-Received: by 2002:a05:690e:441c:b0:679:24b6:fb42 with SMTP id
 956f58d0204a3-6793601374bmr2624504d50.31.1791929087874; 
 Tue, 13 Oct 2026 15:04:47 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67986a679ecsm336019d50.13.2026.10.13.15.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:04:47 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 13 Oct 2026 17:01:00 -0500
Subject: [PATCH v3 1/2] util/coroutine: trim sysctl's max_map_count newline
 before parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-set-default-pool-size-v3-1-d36e8c31f9a6@canonical.com>
References: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
In-Reply-To: <20261013-set-default-pool-size-v3-0-d36e8c31f9a6@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hector Cao <hector.cao@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>, 
 alex.ramirez@canonical.com, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=cnXWUgGXywRy8ir9sJQn0UoozXdGanK56QieQtHLDm0=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzqr8TASbuCWA9lHwCZn1elE9ADdv6Djdqiu8s
 42CTvOBYr+JAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas6q/AAKCRD5KICs4jod
 uZIuC/9QTh/owzMXy4NapcKhloaWZp4aXSRc/ilxtm3xhg9UVrT4/HDvkZib2MYfxS3X9HnvNOD
 aSkLEDUsatZmtFn99+hUGhi7bh5mjYq+hcaaQZAn0dgbDRkF0U9S4x4QmgnaO002oOT7sVeOkiS
 /9HdSW8EYTn72fOmRJkpXl1kSZmaZmB6smc/kL/NZVJ88nAjEkr0b0WuCGr/TQiQeusN4NBMLqr
 yscxf8GFBiv3/GTS5w/jIWI6Dkzj2P/hr2G/7gnvnmWbNM1c56Zakz/2+cQvTVVhwy3NT45Dv0m
 ql+rHLfhDAkYl5hGRR4x5kvomZG94NeuWRCjBMCFo0r1RPdrMlT8dKcB23STl2K0oGzOsn5N+5k
 nofnv1eKUSnb+2MQt12U9vwv9GFhqbP2jYkmAt6Yn2dy9tyyyHkD+CIG3D9CKuJhhlSf+706liN
 e/yMasw39s4iunpanOJDkuemDYnREGucVxt1lBiOD10RiX21fODE5ujA5UQEqgSDrmzmY=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Hector Cao <hector.cao@canonical.com>

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,

-- 
2.53.0


