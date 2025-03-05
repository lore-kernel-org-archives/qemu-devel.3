Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2188BC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprMi-00037O-Nx; Wed, 05 Mar 2025 11:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMh-00036L-96
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:12:59 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tprMf-0007ZV-MZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:12:58 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390e6ac844fso6239295f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741191176; x=1741795976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iRGFcNlfrygrR4654WJl6FH925RxAyYFzhn3HJMQeo=;
 b=UqD7P4r6VSqYqoQwk31geuFK3XCZaBH2HkulAKGiv7Q5YJzqCLW/lf9LRuudfoOf5J
 2NQWy0lODSwbUwbjXPovBFIVCOb41EtySUeGyiTIOuTTDXNs54UJcibkaKXfwXHaWvaa
 0mjSdkZpXjV/877s3snXeciwhMu9NGa36FRWFPcad8fvMIEr3oYqIchRO0t/94FawJgX
 VwxIXhDv81zTEd7sUItXjAzOrtateCDsPKaBXRAd5Qdx9bo8OuPHugYRmd7jbPCd7Ghv
 2nfpeakbZAX+A/IOTEpmckDGKdRZ7/DhnLfboB1U7nxQFAJlB89+TpMFm2uA3t57obJh
 bPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191176; x=1741795976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5iRGFcNlfrygrR4654WJl6FH925RxAyYFzhn3HJMQeo=;
 b=KDo1GHZMuMU6WU4qtWx5iY42MRjc04iNPLy/CB7Gd7S8HkcPxuXrnGh2N47tPgOyKX
 EFfC+doqnPEbK4+GQ5Tabs7bcfsO/JKIcuDuSov0dg3/Yz1KR7xqozRlNdFtalETVT1G
 /6LWOV1Zo9GLthT56cw7AXzWPMfu56q7YbQ4h2PdKIi24KzIThHi/sQ0UioyP5h86Xc6
 uKxv4dXdgRpCHWr9g+j06qH6hBNfQ4HrU+2T7fLiEjXaXUKZkIb8dr6ARxss6wCLLgq2
 6wo9jAn8AbQi9PBZ9revTehdpsa5rErXEylCAHjiWP3feyviMjXtMhGI1zSS1YR7AaEw
 sYlw==
X-Gm-Message-State: AOJu0YxWJ+0S3rRUQDwkA3wkIeh3UN7LQGgj5iRrhTLbEO6Ujp7Ar1R4
 ogG0DQYbj7RIiEK7klB6j39veAEawZm3g3plSchIcbQ+f6F0xFcav99vt/BAGgAQuRRsf/ARzie
 FRTU=
X-Gm-Gg: ASbGncuRZ12Maq1Zz2q4bnS9BVerflEuLdZ1jwi6SDiC13EtKB3eDUtWURGHqI5BxA1
 Bbksfr/bwiqJ8qdDn2gcuyPU1a3MUyTIlhm26RQ9AP4oulHadmwedKO2cQ7C+fMyNP/EpMGmghY
 8EX3DTGqrmZzxcPFo0djziBirvMUnEVXc7uyG2oZE/Sm483G3ymu5LBNQIRYMK6jfRuBrxEiEdl
 R251rVjkMH8rbj6vr0UN8A5CNg7WFJ4NpWqAITkcG9sYwRH5c3j/DWhthmTgUuqDSM5dHpSdqKB
 9PMQlqACaaR282Y9oYuk7zjH5lOPxVGpTGFGBQY6cv4RouH7njzIbZGsfTIZ9kJWq6KKgSc+h6R
 WOW7Wx7fCTu1wlc9TWs0=
X-Google-Smtp-Source: AGHT+IFLvOuqcQaWIvhKOfkOIDgBwiLE7r039mnF8WCMADboJoIwCgmIqRFmjouKEZ5ItO7SLhnuBw==
X-Received: by 2002:a05:6000:144e:b0:390:fbdd:994d with SMTP id
 ffacd0b85a97d-3911f74e691mr3439508f8f.27.1741191174532; 
 Wed, 05 Mar 2025 08:12:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479609asm21179412f8f.2.2025.03.05.08.12.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 08:12:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/4] qom: Introduce TypeInfo::registerable() callback
Date: Wed,  5 Mar 2025 17:12:45 +0100
Message-ID: <20250305161248.54901-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305161248.54901-1-philmd@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Introduce the TypeInfo::registerable() callback to allow
runtime decision on whether register a QOM type or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 1 +
 qom/object.c         | 4 ++++
 qom/trace-events     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..f046791f60c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -476,6 +476,7 @@ struct TypeInfo
 {
     const char *name;
     const char *parent;
+    bool (*registerable)(void);
 
     size_t instance_size;
     size_t instance_align;
diff --git a/qom/object.c b/qom/object.c
index 01618d06bd8..c62b7fd1695 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -168,6 +168,10 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         fprintf(stderr, "Registering '%s' with illegal type name\n", info->name);
         abort();
     }
+    if (info->registerable && !info->registerable()) {
+        trace_object_register_skipped(info->name);
+        return NULL;
+    }
 
     ti = type_new(info);
 
diff --git a/qom/trace-events b/qom/trace-events
index b2e9f4a7127..29af95d8507 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -3,3 +3,4 @@
 # object.c
 object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
 object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
+object_register_skipped(const char *type) "Not registering '%s' type"
-- 
2.47.1


