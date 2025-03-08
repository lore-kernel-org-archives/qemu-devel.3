Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84134C28B2E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3JM-0005wb-TE; Sat, 08 Mar 2025 18:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JJ-0005kr-4f
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:25 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3JF-0001Rw-SR
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:24 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390edaee0cfso2129458f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475420; x=1742080220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJXNBj0mVkk7ow8GecZF5txwITRLIlUvrzgwdEPrsZI=;
 b=N1bf1Ba+UwLnU5tNjq+e9qNOcqglkDcqpdZz2dN96O8aDkjGnUIhM0xFZfOs0ac630
 cMUy5qJ4OV1NFcs3y4MbDCyRqRWms8AMDP66/jODmSh37eHum8IkVYSzg4utkEkY1rtz
 RGngwS1NP7EK4OvUE2QN2ztf4q32TKRN+kGQoGzfieyfRqimwjDEj5gYthWulrGedhCK
 Hg3cDAJK/mH/CqLZLSspr/VsoxZJAR8F4VsruFwv0QssgilqcUmmQO4km7DbIWW8eRiF
 uvyqZq6PXpsvAdHoTiHqgO1g3NIrPuwIubxtRIQbGKs0RjTNpqYV9k3jKmdSIlHfzO91
 pVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475420; x=1742080220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJXNBj0mVkk7ow8GecZF5txwITRLIlUvrzgwdEPrsZI=;
 b=k6uoYDekB+IZqeGXS0wdTi6g1F7QmzcDEdPsFhL7SUPCH/zvMxPnmO09W/Byv36YEi
 SgfCFhWtqu3BgwtH8Z3/GBgFAOVvK4haaZKojnsLkyB5oJiT1i2bS/bZXye9ru/vzDiW
 TAdhynN2IVBt9k+lA1je1B9iVbiKsjkfwif3Bk1RXgEB2Tji8yFkEaKaSbNl17qiNhtg
 3WUoPH305h4dFBUtNEcaXqoo0SXaPuTNyTDQuiKRjw+PYRPB3yZQFJMdO3rGb52ehGck
 e01rtNymM2ZpbHljWOQDx3xbhZM2CNUqWjBiONGYVl8IyNyMA2cJQ5AIHa+O5JXYWYgt
 adXQ==
X-Gm-Message-State: AOJu0YwaY6VLT73V42ngc0PwADARCece+yR9TgPXgqNM2kY0UtUI7gos
 +ti29rXyogg1qml2G9UyCPwaexMFOkkjSVx/ScaU8MIJ5yv0ck2B2OUAXz3wYR74gkiXViy0pH9
 qLZs=
X-Gm-Gg: ASbGnctkz1IfTdEoIL9br/kjLZF7vPVDRTwOI6tJWpNXkIEKFU8a9iFTGXD+WwSn2Kw
 a+bcl50g62DCiur/2dq60vF/fxDxF6k8yLumMVFJcT5QGCUCfkCkLSL6ZavJfSmtQ8jrE+mPj0m
 1UAV6ZPB0ZpmWDEsPNO9H2H138WM8iHi3Kti1wUja8JrrcVyKXEYKL8IUMjfKEvyUOucWwg76jB
 7zoDwRVW2POay323JkmFz13+3IiGqGMQ4roJo0GLWQUZQGctbrnhT6ythpN0LNkRaVaTXexnlu2
 VY9g0830tRlqs0lJQ4/PeoX/lpKh8j9Wfr4aG8TZhDt7bZtaA1QotKT0IHOkqa443elfaRtxjIt
 VEptZE+EApfzT07K9Bti6F7oaX31l/g==
X-Google-Smtp-Source: AGHT+IHQgGDKYnpS8cvxChOVuSZsAjnTKah2viEVS9oNKXufBZ9Ckl/6tU+y5xvoKE6/Q1ES0ORdxg==
X-Received: by 2002:a05:6000:1545:b0:391:2ba9:4c51 with SMTP id
 ffacd0b85a97d-39132d98bb8mr5365371f8f.44.1741475420168; 
 Sat, 08 Mar 2025 15:10:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm10260184f8f.62.2025.03.08.15.10.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/21] qom: Introduce type_is_registered()
Date: Sun,  9 Mar 2025 00:09:06 +0100
Message-ID: <20250308230917.18907-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

In order to be able to check whether a QOM type has been
registered, introduce the type_is_registered() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/object.h | 8 ++++++++
 qom/object.c         | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..5b5333017e0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -898,6 +898,14 @@ Type type_register_static(const TypeInfo *info);
  */
 void type_register_static_array(const TypeInfo *infos, int nr_infos);
 
+/**
+ * type_is_registered:
+ * @typename: The @typename to check.
+ *
+ * Returns: %true if @typename has been registered, %false otherwise.
+ */
+bool type_is_registered(const char *typename);
+
 /**
  * DEFINE_TYPES:
  * @type_array: The array containing #TypeInfo structures to register
diff --git a/qom/object.c b/qom/object.c
index 01618d06bd8..be442980049 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -100,6 +100,11 @@ static TypeImpl *type_table_lookup(const char *name)
     return g_hash_table_lookup(type_table_get(), name);
 }
 
+bool type_is_registered(const char *typename)
+{
+    return !!type_table_lookup(typename);
+}
+
 static TypeImpl *type_new(const TypeInfo *info)
 {
     TypeImpl *ti = g_malloc0(sizeof(*ti));
-- 
2.47.1


