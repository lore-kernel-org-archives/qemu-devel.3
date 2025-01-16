Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F01C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSNJ-0006ct-QE; Thu, 16 Jan 2025 11:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLC-0003Yr-RD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL3-0001KI-Qr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43626213fffso13957395e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043400; x=1737648200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MpW/2n8t4Ifykf0XW914wylYygUjob9/Znajs96aYA=;
 b=FNiUvkM7sFZQ+a2zMmgWkVi7l+PH2hFj57ISsO/gO9zQxUVuOq0T7bIvg2H8XAhL8i
 0V/M0HKR4OFgNoVbOe+1KlyjoVXHdzqmacrPK+kplBlhxPXRiYH0azNZYvrv1B3fSY2G
 o0fq1nhgnBc/09XECcgn7WFxsFMULpN+jwW6gbQMEtg3DIc63ODAKMJ2Pl1veju7NBJu
 Bixj+7AHcKC2sqT1NjOcKVoEZXRLYLBvW3dC7cRgy6+yYobJrSLZC8USF+foNHJ3Rr3j
 hk1S1PI8UC6yxr6EBlDFjcM0KuVQlJVeRe0FL2Eae9dykHvXTScN2bu4SoXlEzQAGF1V
 4qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043400; x=1737648200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MpW/2n8t4Ifykf0XW914wylYygUjob9/Znajs96aYA=;
 b=jI1Ut4uMbsc6Ug+ShPUdNqQ470qGZ/hv95qPMTvLz5va0os2TpOsLS5qypdXub1TIF
 ov4KGOmApbeAOzoxf+C9VIo2wE6fBfHPh8jyIWux4LShw0Cf4UYu4uk5SAxZbxzcjiq7
 XkFXNx/++uyVJnbwA+s6R1RWgI+pkIc2JgRQXnTOStDPSMotLyDXvluhdCrHyPugGGvc
 7yx1XOajZKQoaJk8BVrAe8rWRhpcz8PcitBG9PxkpHvS+0km9mTwwEX4DKgoGb8L7Heu
 xhPIoQDgMJZcly1WdD7VSDr1Ro/NXKhdxUPCoGZe00FlldQMdgZnmE4hRP9lDQezFqJ6
 FopA==
X-Gm-Message-State: AOJu0YzWZfuNVUqdpNV5f8wZa7IK8++spWun39FdXxmmMGbKH3lj6YVJ
 ieIw6Srabe3z4aOeRqQY+hUXz5OycEt85iqiLF9Sx8ygvM0D3/M7RDBz+62kiC0=
X-Gm-Gg: ASbGncsJKoWAksZGTQSllcBxGXToymCjZHnwfOPoKb7o4rgT3u2FgIAbsNO6ZO/CHW9
 JSo3lVTZVknl+PN60MtuKYwnVc+NTj13ZBEmd9LX/6mElJvJ4grjGxwKhtnQ4YenVMV9u4UVH+m
 oud192Ie0I76PQUJLRkkFhtqnqXTDmDyeMX54/sXVF1f2xuYJ1UX2cjXEHmxmpCjxaUEtECkQwv
 tp66cpdYlYBaLguEHCxHQa3qDP812lWfGb6oOR6zHk3H3g++8RNvxM=
X-Google-Smtp-Source: AGHT+IEzCBNZqjXj7lI7kQGMQKTBiw3kExicUVC7Y/NSCX3NC0264VjSQecdUyV2soEPeDvQrXfDkg==
X-Received: by 2002:a05:600c:4f54:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-437c6aecbf0mr65929325e9.1.1737043398506; 
 Thu, 16 Jan 2025 08:03:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890367b48sm3792705e9.0.2025.01.16.08.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52FBD608DF;
 Thu, 16 Jan 2025 16:03:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 29/37] include/exec: fix some copy and paste errors in kdoc
Date: Thu, 16 Jan 2025 16:02:58 +0000
Message-Id: <20250116160306.1709518-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A number of copy and paste kdoc comments are referring to the wrong
definition. Fix those cases.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..605687befa 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1194,7 +1194,7 @@ static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
 MemoryRegionSection *memory_region_section_new_copy(MemoryRegionSection *s);
 
 /**
- * memory_region_section_new_copy: Free a copied memory region section
+ * memory_region_section_free_copy: Free a copied memory region section
  *
  * Free a copy of a memory section created via memory_region_section_new_copy().
  * properly dropping references on all relevant members.
@@ -2510,7 +2510,7 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
 void memory_global_dirty_log_sync(bool last_stage);
 
 /**
- * memory_global_dirty_log_sync: synchronize the dirty log for all memory
+ * memory_global_after_dirty_log_sync: synchronize the dirty log for all memory
  *
  * Synchronizes the vCPUs with a thread that is reading the dirty bitmap.
  * This function must be called after the dirty log bitmap is cleared, and
-- 
2.39.5


