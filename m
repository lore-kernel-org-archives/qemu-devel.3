Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009D8CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYu-0001H1-6e; Wed, 20 May 2026 17:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYs-0001GO-9t
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYq-0007Io-Jc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCucB0SdvXatQHZlXd7SoYpVSV5RtFANyZbw09AWLW0=;
 b=aTxowvNfEnzCy8BLth5swWBgeHLYYlUWeRrCB2R1hn5E5Vv3hBLU7GqSw+hJCmf8MY11HW
 0YMXchjDqMUkYUab2njcudybpRg4VLPpcYAdp5tBRqPMn6kwl0fN1ExEWLUCfu7Kw7/Bnk
 psTLIW4dKNdPaB+QwlvMOi+yygP7TOY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-oZEkZ5dFN6ykNZKSryhaJQ-1; Wed, 20 May 2026 17:34:38 -0400
X-MC-Unique: oZEkZ5dFN6ykNZKSryhaJQ-1
X-Mimecast-MFC-AGG-ID: oZEkZ5dFN6ykNZKSryhaJQ_1779312878
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b7105dfb5eso166564456d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312878; x=1779917678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCucB0SdvXatQHZlXd7SoYpVSV5RtFANyZbw09AWLW0=;
 b=W00dT+SyecbZ1OGkeq3vcriMgydLCFNxAwgWC7L/1LcOkVowoGc9ePXKIE/p/OBvL3
 12uu+xIV8ETkdxYBTcFdg9lfu8Hj0ai8OwBECYrqHDws5KZEUHgHCPQJ54onnN0SRid7
 uXD39ogLMIjKG7L2DBDEI1IAo7wzvM6Ttxp0R1RAL43tQ2I3fMzt1JrsUcN5J2Flw7xL
 9tKcLqE6n1NBmeEQyroHkWOR5lQwN5DLRaJnQPFN40fha8/F3N5/gz9p0rhFjumZKGDg
 TaP7HaPZK85UiLWa8MvMz3uZw7TS0BO+trgyvn5mMjHO6f2NSS3xbT+5x2DEbJfpYVoT
 COYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312878; x=1779917678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCucB0SdvXatQHZlXd7SoYpVSV5RtFANyZbw09AWLW0=;
 b=i25e+c3ndRTpNnpPo7V/vBBAy35xU/CQ+vRF2i0mKrIEO20ccyJ8BjMOs2QGXQNSsk
 e115iQzJ8LX7Y8LQ5NhLXUPvYuxeZihEcc9+sGesPcyr17qk7gKwTwz8Qk2HmdpG5Thw
 5flRsq5++Y8KdaNuxksvvkPbfndmAVBGO3QzKrCQEPNVwl2aycG3VdUykZ/0MUbbAk3U
 fySc1UQLSpmHqAgcVOI6Y3/YazJHpScvXVzQ0+HIZqslLCQ/XITI15NrkWRH4pNgK70n
 y4IC7Db6VXm/z8jgrxyrnL2eRxvQjCikbKpmWyWCPHmz8nZco8MRLwknS5F0TBdvbjJC
 QMqw==
X-Gm-Message-State: AOJu0YyC03lo4va/jKxyJV0q8Jym3AInC6RidWPBHcPpuUl7MR8A6t+u
 SdnXV3OzOZq1nWRzMEqwzH6QCX/7wCxSoSPgoQNs+m3Pmz0NNZ4JnMiLdOcvxjfm9SwS9jTWU5b
 j8sMcXTvxhYwfVVl2+JlEiZVJNI3q158EoQSiJpB2QSw5iqSDxP4tBA8dTAeQHHu1ww0gr69VsN
 6Jflwragc3M8lXl3AcJekIQzWi6cpB7is26o3MaA==
X-Gm-Gg: Acq92OEmHkSxhlX5at0KlFpRv1XcK03rSgMxFBvdF6p7IO1fpNMSfbhNbCigLudrO0N
 5lI9s9HBpyaxeeRGf0bK2Xj78OrSSNqpJNFH0goZZK4dSEqbsRWYxz08Ac2Uh7smEhIAYZ3Vsuv
 XNWgpdgL2kRrMffuzzfvAPGzocHGqFT5VZlHoMzJLwQhtIFYdHUiDr/4rSrh3/5DKxBkyX1x6L+
 vqEshiCO8DQHmPySSHBcM5+DkUhOtBH/aeceOYr2GesqHjv+ceBxT5TRzHzdqIusBiGCTHS/Xud
 QJ+w4OvTGjTI02zC+aSiQbcKJH8nO8i2492hG/fVeHpC8grj/2geUs3QV5OevVmiK0kBiVcP5D+
 5Q2Q1cc/IstfoBUkISdbUROLfodsz0vUFueYY0OXOtfRQ
X-Received: by 2002:a0c:f40f:0:b0:8bb:2e70:7a2b with SMTP id
 6a1803df08f44-8cc6e308ef8mr4761606d6.15.1779312877528; 
 Wed, 20 May 2026 14:34:37 -0700 (PDT)
X-Received: by 2002:a0c:f40f:0:b0:8bb:2e70:7a2b with SMTP id
 6a1803df08f44-8cc6e308ef8mr4760906d6.15.1779312876829; 
 Wed, 20 May 2026 14:34:36 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 14/29] tests/qtest/migration: Set compression method in
 compression-tests
Date: Wed, 20 May 2026 17:33:42 -0400
Message-ID: <20260520213357.40646-15-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Stop calling a common function to set the multifd compression
method. The default method is "none", so the common function is not
necessary for tests that don't set compression and will be removed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-9-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/compression-tests.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 134bf44db6..848576054f 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -20,6 +20,13 @@
 
 static char *tmpfs;
 
+static void set_multifd_compression(QTestState *from, QTestState *to,
+                                    const char *method)
+{
+    migrate_set_parameter_str(from, "multifd-compression", method);
+    migrate_set_parameter_str(to, "multifd-compression", method);
+}
+
 #ifdef CONFIG_ZSTD
 static void *
 migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
@@ -27,8 +34,9 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 {
     migrate_set_parameter_int(from, "multifd-zstd-level", 2);
     migrate_set_parameter_int(to, "multifd-zstd-level", 2);
+    set_multifd_compression(from, to, "zstd");
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
+    return NULL;
 }
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
@@ -58,8 +66,9 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 {
     migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
     migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+    set_multifd_compression(from, to, "qatzip");
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
+    return NULL;
 }
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
@@ -77,7 +86,8 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
                                            QTestState *to)
 {
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
+    set_multifd_compression(from, to, "qpl");
+    return NULL;
 }
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
@@ -95,7 +105,8 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
                                             QTestState *to)
 {
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
+    set_multifd_compression(from, to, "uadk");
+    return NULL;
 }
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
@@ -141,8 +152,9 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
      */
     migrate_set_parameter_int(from, "multifd-zlib-level", 2);
     migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+    set_multifd_compression(from, to, "zlib");
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
+    return NULL;
 }
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
-- 
2.53.0


