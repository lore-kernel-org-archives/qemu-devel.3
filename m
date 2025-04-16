Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B194C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xx3-00025d-J9; Wed, 16 Apr 2025 04:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwP-0001lk-Ve; Wed, 16 Apr 2025 04:16:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xwN-0005qe-V5; Wed, 16 Apr 2025 04:16:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so5952950b3a.3; 
 Wed, 16 Apr 2025 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791373; x=1745396173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZwfnw5vxnLL2zR1KniO5W7Nb6K9SEbOa4Rm3mdsFsU=;
 b=l8q1Lp3DqL+73LdSXLFHoMCAelNn0OYN4JO3R+5jTpMrde5wWkjV/giYr9RCiHrCva
 F5zaHxNYdqiMEQVyeO0NajWvpHKSt4oPyMc6I7I3Lgmw79l9T/qCfY5oa/mD7CAe0eHb
 7RKiGEVMJpLoVwRnVp6IxNpJkQCkS9Hdz172bzMEa8L0M7QLNAoV2rZJC7/lNeUx14MV
 +NJGQgehsvFmFEzKVYmGt1860eAfFw0m7s/EHFjLZI7BLygk9qx1fD/deIhEYwFnkxui
 Y6055qlRjiktMfeKR0/S9XcaVQAkFJGSmklhi3qYVgSCbvKlZHRRyBzVmU4lypnGEqac
 sT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791373; x=1745396173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GZwfnw5vxnLL2zR1KniO5W7Nb6K9SEbOa4Rm3mdsFsU=;
 b=SU2NwByCh3FsAOIlY4TYwI1CM89r0yzIm29XqPNtrsmaBfr06ptgeqlMZ1x5WAKGx1
 kPcrTojVqWGw5xkP+j84SFkXuwe5Y+LK9oBRfKAyOvCgGCkGsHL9WkxHKt5vO6MCAT2F
 SWayGqe6kpcTpP7btPt4SxIjFOFz2XocbAV41rNVxfYb26lg4pO+dAJ9Q3svE1fBqXxs
 3F39PJ+bSxddBH1LB2S6ZG5fgSmoeTvbpInPFDbid7+9Pce++wwUj3UvaLxK4cEnl5xJ
 hyy7oa/1X67HVUyaq8OQkRDz3yStYnP+TfDUCkT9xjAwQRirQxMzNCjR01VIagkEvr42
 W8LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHngnwCygZlD3hDtcU/H0UlaWLdbu2DGqg0ZNKBbMvEZscQjT8egNWEQ13qIsKEx2aMJUKPITiW6o=@nongnu.org,
 AJvYcCVxNtLCa67uZ4p9M33KIknp0z925zNnZrPRMG4HhYqcXAN93+s61+VKokX77iIhH1FOsesftazD+g==@nongnu.org,
 AJvYcCX8N/JoWD5zKVKE1Irk3KGclgP5TQhHsCWAgR4cCezWDEVaNoNeeOXcCGxjWT6acUcOWPdjveyqHo6kGA==@nongnu.org,
 AJvYcCXY3frG5ryaHEVVzYUXaF9vneyrc9tpE1RhddLoa4Lc9HkpYRkIy0bLNQfBX9x9FV4YD5PaAymHnRdQHA==@nongnu.org
X-Gm-Message-State: AOJu0YxJiR0RzFWQ6wdsR+1WP4tWnvKxZYAkQkO9rOOHKGQiqr3S7UuC
 6BxrzWZC29uxm/ldjV/wSmeOco7Fa9t7+hrdPBmftLoW1os+Vg3a8hsZONMB
X-Gm-Gg: ASbGnctt7p7BmvVUzFDBjDXrI5DN+Qyzlu0jcIAlVuVaMi5QzTPJEw+vTDq4cEp8N0u
 iO9pBW7JFFGW13FJ4cXmiZ2EWBFFYouGZZR/nFPkG+ObcuovkmtaDNg6jqOAibwEw7MXva9o3W3
 96a7u82yDoVey0eJ5CjnrYZPEtrnUSTKzQLlBQYwGkku8aCR0OPeVBKvON1fvfXKvASZS36bnGW
 1HVeVJV0PYl+ay7nUOO46AFWuuk2JdqYpf2Geac6tb/psX5GfkUTtleorw7QD7ipyM3ZNstEXrp
 dGn25ojY9s/XxMZPu9+fq+qkmz+pDLlFEWTXPFlSx7RWJj+M6OvJn05CcQ==
X-Google-Smtp-Source: AGHT+IGQOK7n+6TprGHiO2Lrr347LOOWE18O3SkbS/KKjF+Q4XTcV+l8OwYIIP3q4cnQwUmzahCevA==
X-Received: by 2002:a05:6a21:789d:b0:1fe:9537:84a0 with SMTP id
 adf61e73a8af0-203b3e9fec3mr1108892637.15.1744791372610; 
 Wed, 16 Apr 2025 01:16:12 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:16:11 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 09/19] target/s390x: Fix type conflict of GLib function
 pointers
Date: Wed, 16 Apr 2025 17:14:14 +0900
Message-Id: <a6c885f0f022816e19fa169ede5f2599db94a889.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/s390x/cpu_models.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 93a05e43d7..48cdef285d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -373,7 +373,7 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     const S390CPUClass *cc_a = S390_CPU_CLASS((ObjectClass *)a);
     const S390CPUClass *cc_b = S390_CPU_CLASS((ObjectClass *)b);
@@ -415,7 +415,7 @@ void s390_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_S390_CPU, false);
-    list = g_slist_sort(list, s390_cpu_list_compare);
+    list = g_slist_sort_with_data(list, s390_cpu_list_compare, NULL);
     g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.25.1


