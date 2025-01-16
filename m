Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAF1C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSMN-0004g0-LH; Thu, 16 Jan 2025 11:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSLC-0003Yo-Ny
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL2-0001JC-0O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:29 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso7410955e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043398; x=1737648198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=Ba/EfVrsOYsgr6+CoC1Z41kcWp9YAg6op3MYoPUHEnFVOR+gWex6JAeCZUjoIdAJnU
 //gIa/FUiclbbc+BKNbOrNbK1mFHr5c36kaLPF/ITbdBTY+5aWY3f+BE12HXcjyz8cQj
 y3XNtZG8zECCKuNALiqpWoASp8b92h0z4hvCTJoDh2b/3gZ0ghpchIOMj8FHzmYX5+tb
 U1S1dXwngTOkMJtB3SjMKdkL8A/n9Ym0tCar/bs3H4IqMjZjIX8N1/qEBEiC6udijbtF
 1R7HCg1zUk6rSVSuL5e2HMH8bTMwpY71Jpcs/FP6+ZHJndw9EumA6bgeOVO1/VJUPL/w
 F/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043398; x=1737648198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=LIJpoCWbS85S5qHC+9tTLaaSoJAWbCJ/A9tKH/7NAbfsHRAt/4d0R/vcBY72QrPZSx
 5c64hU8Wqy28z8b2ZzP4zfwxxH/XN0x4kTZjYJ0Dy5shGP6xJ1UnvS1YxerGSqetl0uF
 uh7S2rn+sNP2loHUUyndNO1s65F9cv8rpfZGYV0DDNoGTyT5c2xPpbWyRtqqsyY9xbPe
 8PIP6veU7OQHeZVvDHVgZdGkr174nB+v+nVEcnJQSKsm1jP5Vg+zCWCF0PULVNRFnh6K
 w/ehRoig1mGmX5jDFivPBo98dNPE7vpy5Z8Wi5ohM+kdY2HmoM/jL8OeWfyuYx/6p8x0
 8pVg==
X-Gm-Message-State: AOJu0YwDHxf4RytuKRsMvOt4qagOZu6Ul2kjXPSsHJaO2QBbqtwbX1B6
 M84YB2kEjbeFMUGVgxebC8JG2yJPlNJ9ve+anQcw3Feu6QcU+9bUzQu99d1Aygs=
X-Gm-Gg: ASbGncuyJny/oozphs9dELMMw94SL8D8qPJFk+9ZfornqyAbQSNJ+cN+7cbQ9n41qIU
 aD5k/81cgi0YfSIrhnQFxHVm9dCPX74OskJYsfGbLSVmY6IL2NGNhlHRCzQ+hya2+i1arhuaM77
 ABO2B6feMLxFUXY0M8NU58YniAjk60243VG/PUqQ16wfpI5qx5Z583DEhKOwhqmocU4m0gu0sYH
 jIVy1n2g9avfxCVuQgdwkWXKVeJ66QlIFHYfDUsrV/pVmUlGhx8YU4=
X-Google-Smtp-Source: AGHT+IEsPJ2fEtJ3ToRLLeugaErUBp47L/VU23T4vSomhb7DKI7czO+7HyZEsWueFPMCkm9qqsDMLw==
X-Received: by 2002:a05:600c:314f:b0:435:9ed3:5688 with SMTP id
 5b1f17b1804b1-436e26a1f79mr339091715e9.18.1737043397377; 
 Thu, 16 Jan 2025 08:03:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c65b7sm64838375e9.23.2025.01.16.08.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBC2160890;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
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
Subject: [PATCH v3 14/37] tests/tcg/plugins/mem: fix 32-bit build
Date: Thu, 16 Jan 2025 16:02:43 +0000
Message-Id: <20250116160306.1709518-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..d87d6628e0 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
     g_assert(offset + size <= region_size);
 
     g_mutex_lock(&lock);
-    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
 
     if (!ri) {
         ri = g_new0(RegionInfo, 1);
         ri->region_address = region;
         ri->data = g_malloc0(region_size);
         ri->seen_all = true;
-        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+        g_hash_table_insert(regions, &ri->region_address, ri);
     }
 
     if (is_store) {
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (do_region_summary) {
         region_mask = (region_size - 1);
-        regions = g_hash_table_new(NULL, g_direct_equal);
+        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
 
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
-- 
2.39.5


