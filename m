Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2756E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QR-0003om-9h; Tue, 23 Dec 2025 09:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PP-0001Jy-U2
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PL-0003pO-Kl
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7BRFh1Cw0AiV8Ulykk8MuKNbm9xn6mz3jfv8tqNVkE=;
 b=gwu1zxy6cPZ4nSObPw9grcGsOoEpzCgMBC+sXItiwnbUfkTCL9hUVeP/LzuUCwYUfDYhLh
 EjxkiSp2DUj1G59LUO8AccVQ+jaeqip4GUSH+dh7zHeAS4HJZHZ8fESL6ujIXK3jJBCque
 N498AnRZi8vMF2KhhkUkW2IyF6tEYLU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-m5uXLypZPbClcAxZ6zUngA-1; Tue, 23 Dec 2025 09:30:37 -0500
X-MC-Unique: m5uXLypZPbClcAxZ6zUngA-1
X-Mimecast-MFC-AGG-ID: m5uXLypZPbClcAxZ6zUngA_1766500237
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2e19c8558so154802485a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500237; x=1767105037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7BRFh1Cw0AiV8Ulykk8MuKNbm9xn6mz3jfv8tqNVkE=;
 b=YAooTl7GMC+fUPmy/SeM8/GbRiobA3zjsLykigPRHAY/NyN71VLfyFAdKxcdKrqnpE
 4QlLfkoWEewieGgIcGMH2nCGzxMGXMXtil2Uk6D1EmUXv/aHbnQknmkW8pZrNGR1BeIe
 Exeu1udh78gMhv4086kpoDmUVmx8/rkzMxAEaILiiUGdY4KEYqF8007tNzH1z/A/MhQF
 NeFYXa+bLwu19D42oxDKp0bqjn3FnGXKa6vP/baxVUEMEsoX32E8f3hHdbbVCehqthnW
 L6nziQ3CkcZ5eHJh2nhMKxChn6yLhXN8ZX59Me51nCvTpqCvYe9R0hPvXhHYQGFGaiPt
 1z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500237; x=1767105037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q7BRFh1Cw0AiV8Ulykk8MuKNbm9xn6mz3jfv8tqNVkE=;
 b=cgxBDKH6OcuVG2Hi1MV3oTiNmWaEtClE7yHQqFM9w/AYVJj9a66TZqxp52m6A8jpam
 btrF9ZIZpYoGSHmoQNtpnt/05vB6lF576Xx7HUuohPJlTzQZxHz+NxqKeKa3AdysLNrj
 K5yZxVkJEC1KRJV6ccnMGtCaMrxyD1rzSmREF6Ug9K7Qjdi4vzNfFd4cEirm8I8de7GX
 iemKOpPvkBeK/XLEqjwb2gflUDRg+MyrAXv0prv1XuAgbRjM2Izjb4X+0O89yjGpSBXQ
 r4OI5Tf53/FtqRwc7UKoDyYXFCMEs8+5SKn2taK5jmX+SWzHPo1tO6HCaxonelvqaxsa
 KCTA==
X-Gm-Message-State: AOJu0Yy9fz76JZBX9yMQo0szXmJBYlB9eKbslN7iV9T6zErgrYSM35MC
 mU5qK4bLyYjIkAYbtxqW3fcf9IObU01MkzsCDWKC+QsnrNFBzW08U7FrG4FdY0xmj1y24H3Ldd6
 d+07prX4hnwPFVKeR21m75Wcl7KkbLjl0wC7PWu43knRq5lwmdCrz5sjEs36JG6TUP6PzZ3cDXZ
 ze9XdNA6SlMbcnXSnvp6+znXLtybERYat4TeM6qA==
X-Gm-Gg: AY/fxX5CoPObH6fTROQpP2MLHmSCDuWlJDfIEELnyzFtSHVuGqxAH17rQ3s9ZG5Dpd6
 NNxw8PDE1s0cronxM+90sGmcweJxqxGMtI2J0nUlMQ9Irq07+FtvJbzRKg50SSq2l4OsFnacPHQ
 r/U2a6N2hpJadHijR8YudTfixdCSn7GyuOw6fxGzLngVDDyPs1KwUgvNmkbzRKvQ/zZ5S+EIHk/
 0CMJsFJFcqLxAGj7YAH9J18nN/tZlJ0PKEjtyFaz0PJqxpLHmsaluuFFFPkfkWcvFWfBqUNOkJr
 g94yYt+ZiO3WKMvPwl1+rpkEZqYXKMJ2eW80jb+kigWCJFk/pZ3sPqbiq6wyLYb0TEowJWgxaik
 9mL8=
X-Received: by 2002:a05:620a:4511:b0:8b2:e6dc:179c with SMTP id
 af79cd13be357-8c08fc01245mr2117571985a.1.1766500235322; 
 Tue, 23 Dec 2025 06:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGE/m5+hbdU6IYIF3l+ih6LwIq1h9kdlQLZpO/pAsFDMJUtfOkmx0Gkb6s4QYKzJs8eT8QSQ==
X-Received: by 2002:a05:620a:4511:b0:8b2:e6dc:179c with SMTP id
 af79cd13be357-8c08fc01245mr2117564385a.1.1766500234755; 
 Tue, 23 Dec 2025 06:30:34 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:34 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 27/31] migration: Use QAPI_CLONE_MEMBERS in
 query_migrate_parameters
Date: Tue, 23 Dec 2025 09:29:55 -0500
Message-ID: <20251223142959.1460293-28-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

QAPI_CLONE_MEMBERS is a better option than copying parameters one by
one because it operates on the entire struct and follows pointers. It
also avoids the need to alter this function every time a new parameter
is added.

For this to work, the has_* fields of s->parameters need to be already
set beforehand, so move migrate_mark_all_params_present() to the init
routine.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251215220041.12657-14-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 418cb44413..9a5a39c886 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1060,47 +1060,9 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
 
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
-    MigrationParameters *params;
     MigrationState *s = migrate_get_current();
-
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
-    params = g_malloc0(sizeof(*params));
-
-    params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
-    params->cpu_throttle_initial = s->parameters.cpu_throttle_initial;
-    params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
-    params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = QAPI_CLONE(StrOrNull, s->parameters.tls_creds);
-    params->tls_hostname = QAPI_CLONE(StrOrNull, s->parameters.tls_hostname);
-    params->tls_authz = QAPI_CLONE(StrOrNull, s->parameters.tls_authz);
-    params->max_bandwidth = s->parameters.max_bandwidth;
-    params->avail_switchover_bandwidth = s->parameters.avail_switchover_bandwidth;
-    params->downtime_limit = s->parameters.downtime_limit;
-    params->x_checkpoint_delay = s->parameters.x_checkpoint_delay;
-    params->multifd_channels = s->parameters.multifd_channels;
-    params->multifd_compression = s->parameters.multifd_compression;
-    params->multifd_zlib_level = s->parameters.multifd_zlib_level;
-    params->multifd_qatzip_level = s->parameters.multifd_qatzip_level;
-    params->multifd_zstd_level = s->parameters.multifd_zstd_level;
-    params->xbzrle_cache_size = s->parameters.xbzrle_cache_size;
-    params->max_postcopy_bandwidth = s->parameters.max_postcopy_bandwidth;
-    params->max_cpu_throttle = s->parameters.max_cpu_throttle;
-    params->announce_initial = s->parameters.announce_initial;
-    params->announce_max = s->parameters.announce_max;
-    params->announce_rounds = s->parameters.announce_rounds;
-    params->announce_step = s->parameters.announce_step;
-    params->x_vcpu_dirty_limit_period = s->parameters.x_vcpu_dirty_limit_period;
-    params->vcpu_dirty_limit = s->parameters.vcpu_dirty_limit;
-    params->mode = s->parameters.mode;
-    params->zero_page_detection = s->parameters.zero_page_detection;
-    params->direct_io = s->parameters.direct_io;
-    params->cpr_exec_command = QAPI_CLONE(strList,
-                                          s->parameters.cpr_exec_command);
-    params->block_bitmap_mapping =
-        QAPI_CLONE(BitmapMigrationNodeAliasList,
-                   s->parameters.block_bitmap_mapping);
-
-    migrate_mark_all_params_present(params);
+    MigrationParameters *params = QAPI_CLONE(MigrationParameters,
+                                             &s->parameters);
 
     /*
      * The block-bitmap-mapping breaks the expected API of
@@ -1118,6 +1080,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
+    migrate_mark_all_params_present(params);
 }
 
 static void migrate_post_update_params(MigrationParameters *new, Error **errp)
-- 
2.50.1


