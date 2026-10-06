Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC778CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMwM-0005On-N2; Wed, 07 Oct 2026 04:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHlN-0006TC-Nz
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEHl2-0004rJ-0U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791341436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=YXNO/cwtkSYOEOjRyod1LXzm3+nBXixYBwPQNmvSiKSe9E20AquRtojgjdbx/VxVIeHCId
 rzVBNrYEmVZGQ6xt/sTKLQsBOQ00MJ2rjtpNSmpBOIyiYASti3Kl0kp8PWDDW5duDozudm
 R+fwJURMXYmq5+pTha2aT0+uehofSSw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-R2SdGNe2MUKVab-khd489g-1; Tue, 06 Oct 2026 14:20:50 -0400
X-MC-Unique: R2SdGNe2MUKVab-khd489g-1
X-Mimecast-MFC-AGG-ID: R2SdGNe2MUKVab-khd489g_1791310850
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso489126285a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310850; x=1791915650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=paBa48t7Qv0edq8+PfrBLyxsyoAPWoXNbEa67fJ84dH4fOnah52KRy1UCcLI8Hz1hj
 apeI/DANKaWHjhsxGjz0Xfk8vITjE/en6jGb7S0TRIfFfdd5FHnRedWrYhM2I+d9ayi7
 Sbrlr6ebS1ZEG6Q7Bvn2xtITXl8SQfOFHDfGDrE7Fxj8fcwWpIkfkBkM/sROyLsY3SuW
 XiWoKR6v7IznlQ5toFvhw1C1WEfiw6A2i86e0dRykG4OYIgTGOvY8mwPSsOPtMUBjcf8
 I18rX5Rda6KZAHuowaDXaxTt4j7yxmM2op/UjSGUfogScwaXVb1QtWSS+1kTvfBXNn7t
 EtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310850; x=1791915650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qaVb+pX+Dprf1Z/whMh/eAqXrLOZN7xKMykck4AAS0Y=;
 b=IZuO5DDygnAZBIiAVq2gXB89vjMREOyL594xiQLaf+T5xr0iAfYJb2J6G3AUG2wIjX
 3grVE3DgGP3LKIoj75gM2f7KZQOs0tVrdGVj2wlguTbB63Vzy6b/RVtoykM2ijMWri0E
 OJlubREqj3WXuaJWVI5DMBh5JZYjd62XeEX3HYcgNtEA84+o8oJOdmsec6HG948FQ25c
 1kTOGpoWi4Ju1MF0RMYcXNfW5R8+M3gnSwdmU0ao2TWBYj8pKLcY5/BcAfEsrlIGVVoh
 2YGUg7jGuYNJ7dzc9XIzIzwZDPuHkLsE6Sgb+5Hgw/a1GJSRrzivqtUJopYCR93n3pz0
 X9Dg==
X-Gm-Message-State: AFuF++l8w4ybVxcXXH5qhLk69469URYGF+NoqZlPk3a+C+vkndeR6zUJ
 kdjLd8zYRUSN+dG49XftUBM0DC8FuOUMRkGEiZQg/ya7dUu2kfRz8zfJ9BMjZQRVjT2DDaMLunz
 nAZA6wRZsH/qe8kOr1MqxNCaIOSDvPnv1FPgJk0VOWkLF4EaZkM3r18RC+/ULrtl1pl4xanu8/5
 2ctIDqSI0oFPZVia84Ee0q//BKUG4tN2pUEcAY9A==
X-Gm-Gg: AYBFou3Av3llwabINGYMTweakkgtfXgra1T4oaKCiY297+Bjx3MFWp7C2cNLvDm8yEg
 qsAOUGRgeEsVAY0xjLHR63iTsI3J1WQ0xxJ3tfw8T+YaKXG/ykr/K3QqXW6139DNzmuyjBi6akt
 Ol+qoojAFTjtLJpFP3Fb9n4raOM/DQez2Q2xMRR5H3HfiH8+zo+SD0VGvdSilAYRcIDTqSdq1zv
 GWWSfepYGzNocnYHDaxKnr3q3Ll4Esgrt26lCkc5/Zh4GvZOUa38WUut2Jc0XFEkW8r1QIquPXu
 TIu/7MDscZQnmXdv8eqOTzOLRpO46ggUonKjlu2v98SGDdBhKy8gz01+ngfbpUhKUAUFVgA=
X-Received: by 2002:a05:620a:3911:b0:93e:980a:2ff9 with SMTP id
 af79cd13be357-93e980a3102mr138785985a.77.1791310849851; 
 Tue, 06 Oct 2026 11:20:49 -0700 (PDT)
X-Received: by 2002:a05:620a:3911:b0:93e:980a:2ff9 with SMTP id
 af79cd13be357-93e980a3102mr138777485a.77.1791310849244; 
 Tue, 06 Oct 2026 11:20:49 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e98da8aeasm25815485a.0.2026.10.06.11.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 1/7] tests/migration-test: Add multifd+postcopy test for
 preempt recovery
Date: Tue,  6 Oct 2026 14:20:40 -0400
Message-ID: <20261006182046.3767283-2-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We have one for TLS, but we don't have the non-TLS version.  Add it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/postcopy-tests.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 13a5759655..6c4fd31152 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -89,6 +89,15 @@ static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
     test_postcopy_common(args);
 }
 
+static void test_multifd_postcopy_preempt_recovery(char *name,
+                                                   MigrateCommon *args)
+{
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -113,6 +122,8 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
                            test_multifd_postcopy);
         migration_test_add("/migration/multifd+postcopy/preempt/plain",
                            test_multifd_postcopy_preempt);
+        migration_test_add("/migration/multifd+postcopy/preempt/recovery/plain",
+                           test_multifd_postcopy_preempt_recovery);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.55.0


