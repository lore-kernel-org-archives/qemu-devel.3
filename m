Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070F4FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM4-0004OX-9I; Tue, 05 May 2026 16:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM0-0004MT-VQ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMLy-0002Zd-E0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaNTaQWHkBdL/8GhbYMD+GsaQBu6eMR27XHz1q7MUT8=;
 b=eNwVy2wp8CzgfaIVEOS5BFCp7uEwSIrWTsmFdmapziu32ATipl6JPhIlsAhKEXyqr9qaB0
 y8OQdeiIvjKr/tsvVo3rOcW+c+Wy/Eq5GxZihUTQl00aT60LHcqzZ9TZlJsGr3LveatklN
 E3Z8zXBvBGJQCN4YkbfHo/2tqRxWPig=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-whxsDk6AM7CuCQYz2ge-jw-1; Tue, 05 May 2026 16:26:47 -0400
X-MC-Unique: whxsDk6AM7CuCQYz2ge-jw-1
X-Mimecast-MFC-AGG-ID: whxsDk6AM7CuCQYz2ge-jw_1778012807
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ba9baef44cso27199556d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012807; x=1778617607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaNTaQWHkBdL/8GhbYMD+GsaQBu6eMR27XHz1q7MUT8=;
 b=VY+yi6wnetvgT62Ybresc4YpWVqoGr2wLWCInYF8G2BZj6g+uzf5OtNG0DAD9KG7Sm
 Bcu193XAS3Ot/EIxovnqY2JMBNiBCwmsLNqrRLCK6p9RZ99HYrAuiue2F/QR6J3CvcJG
 EtC6lb11fBIP7lR4OmmNpjy8vuBFefrxqMS07+Ah0DSHJnXhObLiGM/j7DlCWZmuoc8j
 IC0bCpDRqPqP95BUJKCg8O2x9HyTd704jbMwhpMoojMgFaGj8Q3VXHWNeOYRZTQ1Zbab
 xeQYRLnCSDAsB+qbhcgwrG3yxszbW37nKFpPGKxur4lNJ66VVqO75fAcvBvlqoIW2xMX
 V8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012807; x=1778617607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZaNTaQWHkBdL/8GhbYMD+GsaQBu6eMR27XHz1q7MUT8=;
 b=mwk9CLUs+Oo5oOmOH5zzzLGX0tZsSUyKHGTyc+paffa23PVvL5PoSoUcX+r44jcpPr
 C9uVoB5IfbPwyzLsAfOcnpcOxr2CISguHZCJw4uLRPeoqlq37os+Zkm7onpX28YLIg9u
 v+E3zDCPEYPonnS3IgJJzJ+L7IGUw6salpWzV7VAN0e4UmrljCiM5ApNNIxnrevjoj4v
 53HM+VukMKf9+VuojMqj+wZfm7GHTQ/0N2PkbHEo3euOXHeLw8C99NV0Mtx77eLDz6XI
 CxbwkmEsLU3pQ5DpbLrJfXmPOKPq8X0CuDXRQSToFkjD36xhju37OpWsVcinjsOX3IIw
 M58Q==
X-Gm-Message-State: AOJu0Yza75FkweqLJOSu/KQXj+8v4cW1jpp+kZnVZrg2vj+JeAVB/5ax
 8Sm0fiyR8P9YNCFD0gV1IWNzLd/rZYtdSRGiIFnH/R3opk2BDxfNdwsAAlEl7s7G8jbzoY90nDe
 /yXxm94ZsZ5zmMip/d4uC/Y17nr6JTMkSVZAXylgT5/j7CWM/0t7j54mGnNX0DznbIc9bfRsSle
 TZVbRWKPpXiRgAMU1JNe0FXKrxS/N8seItdNay7g==
X-Gm-Gg: AeBDietbPAq6dixo/Z1q+NUIa15xpCdRERjig9uu2HgECMFZ5HM/s2//uewyMDzqYbG
 emWZvQ6Nsvvn8Fgd3DemVnGdkQHMA+7Znx+Eu1LcvNYKuoJPXGYSEhxhpOfU6yQ2ybrVmVV3d7J
 DI8Y8pc16gDzs8z6fSV+tcbXuLzsaymwgfa91B6taM3GZKboRk0GLS395tgrvTkwRwqFxZ3khWt
 wSrRct3KEHQhK8SJmLdQFTcINspoMMkgOXmk2wvBKruC3GwCfPj6fdLym18AQ75lNTFMsyu18XO
 bkPalJcmAmDwmXeQ5LLQs87C+1iVa3664WJh4iCd2JN3WNq9LGV/IiQIozOuOW+cAhw8/NHMbEm
 yQIidIf/8sAK3hUu70fEEXkvIOsUuTFvj4ISnfD9GmSE/RFuKjdu9Kdc=
X-Received: by 2002:a05:6214:c4f:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8bc4249d7a3mr5203196d6.9.1778012806773; 
 Tue, 05 May 2026 13:26:46 -0700 (PDT)
X-Received: by 2002:a05:6214:c4f:b0:8a1:8f74:3eab with SMTP id
 6a1803df08f44-8bc4249d7a3mr5202436d6.9.1778012806119; 
 Tue, 05 May 2026 13:26:46 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 02/23] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
Date: Tue,  5 May 2026 16:26:19 -0400
Message-ID: <20260505202640.1011006-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
method makes the handling of the TLS strings more intuitive because it
clones them as well.

This also fixes a segfault when a NULL TLS option is accessed as part
of a validation check for another option (e.g. in the zero-copy +
multifd compression case). Details follow:

Currently, after copying s->parameters to the temporary
MigrationParameters object before migrate_params_check(), the
references in temporary object to the TLS options are dropped, either
because:

a) the user set a new option, in which case that's fine as
   s->parameters still holds the reference to the old memory or,

b) the user did not set a new option, in which case keeping the
   references in the temporary object would later cause them to be
   freed along with it, leading to double-free when s->parameters is
   also freed later on.

In this second case, it was overlooked that the TLS options can be
accessed already during migrate_params_check() as part of validation
of another option. Those pointers should not have been cleared.

Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
is not stealing a reference from s->parameters anymore.

Cc: qemu-stable <qemu-stable@nongnu.org>
Fixes: aed97f0563 ("migration: Normalize tls arguments")
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/r/20260414223718.23965-1-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 7556fbc06b..68441f0276 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1279,9 +1279,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 static void migrate_params_test_apply(MigrationParameters *params,
                                       MigrationParameters *dest)
 {
-    *dest = migrate_get_current()->parameters;
+    MigrationState *s = migrate_get_current();
 
-    /* TODO use QAPI_CLONE() instead of duplicating it inline */
+    QAPI_CLONE_MEMBERS(MigrationParameters, dest, &s->parameters);
 
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
@@ -1300,24 +1300,18 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->tls_creds) {
+        qapi_free_StrOrNull(dest->tls_creds);
         dest->tls_creds = QAPI_CLONE(StrOrNull, params->tls_creds);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
+        qapi_free_StrOrNull(dest->tls_hostname);
         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
+        qapi_free_StrOrNull(dest->tls_authz);
         dest->tls_authz = QAPI_CLONE(StrOrNull, params->tls_authz);
-    } else {
-        /* clear the reference, it's owned by s->parameters */
-        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1374,8 +1368,9 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_block_bitmap_mapping) {
-        dest->has_block_bitmap_mapping = true;
-        dest->block_bitmap_mapping = params->block_bitmap_mapping;
+        qapi_free_BitmapMigrationNodeAliasList(dest->block_bitmap_mapping);
+        dest->block_bitmap_mapping = QAPI_CLONE(BitmapMigrationNodeAliasList,
+                                                params->block_bitmap_mapping);
     }
 
     if (params->has_x_vcpu_dirty_limit_period) {
@@ -1399,7 +1394,8 @@ static void migrate_params_test_apply(MigrationParameters *params,
     }
 
     if (params->has_cpr_exec_command) {
-        dest->cpr_exec_command = params->cpr_exec_command;
+        qapi_free_strList(dest->cpr_exec_command);
+        dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
 }
 
@@ -1555,4 +1551,6 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
     }
 
     migrate_tls_opts_free(&tmp);
+    qapi_free_BitmapMigrationNodeAliasList(tmp.block_bitmap_mapping);
+    qapi_free_strList(tmp.cpr_exec_command);
 }
-- 
2.53.0


