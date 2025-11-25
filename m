Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B5D0EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxF-0007oN-EL; Tue, 25 Nov 2025 15:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwA-0007Bw-FG
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzw7-00030E-6r
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SakKHzjVHPbNfUtqiJIRl0r8TRpSYCjKDdinimjTYiY=;
 b=ii9zgR8lE0vowrgZz5fjLxhAdCY6bAD6WYeuqHsV5KrqWDsKK6eIJlcFxByyS45/rF3DKd
 ScCVt7+p8ekbYSJs6hgszv4dcB+MUd9WTv3e9jvu4U+XDkFxHhZtnvZkdRZ0+ceeyW5ndv
 1MC465QOWU6ZHNHgmFEdbPJckYZfXsw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-VFCW4ZlfNkaz5rEdpp_R5g-1; Tue, 25 Nov 2025 15:46:53 -0500
X-MC-Unique: VFCW4ZlfNkaz5rEdpp_R5g-1
X-Mimecast-MFC-AGG-ID: VFCW4ZlfNkaz5rEdpp_R5g_1764103612
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e9b2608dso391485285a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103612; x=1764708412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SakKHzjVHPbNfUtqiJIRl0r8TRpSYCjKDdinimjTYiY=;
 b=Vgjl8ZVda++u34/x99YHpgBmJN226qC4qe9nA2pZwB7/wYLCcc1JrhivK6f+gDUvhj
 X4NKtqaFCcGtExtl7keCHjRSziegsQVD91rYi//kFQIXiSbMEwhRuQ3WGL6BB2R+dnqX
 qYlnki1GJVx4DNXNYmTX/OWJwEv/xnOkzBFJSDyeepxzVp6tIfcNz7kKJ5L/D67yyPBg
 YNIaofigqj8V1emHcCO7VdYDaBQhMH3QwYfK6179sew+uQ4gqjBfjlYLQyJWuWmPWRoe
 7jomzBISD6zt0MKx56z5DDufrBBKEGzeFb52Qveus8Guohn0O3h1odpvNZYz8eC3Gdqc
 ZKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103612; x=1764708412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SakKHzjVHPbNfUtqiJIRl0r8TRpSYCjKDdinimjTYiY=;
 b=LQ+95cXPO0gjkL4sKx7vqiDQGx3JG2YGt8sEa66l+bZA2KwmJkNjA9Wa6YJH8YYCcq
 aI8qKyq4x0qU9qaWM8uQjcOJN25jQJ+LOBDk1S9EIkJleh6oIeK4qoIFZpx5otFgmuTr
 avL8CSR/+lahJ5aJ6AisUg1d0B+3LMoKhaLOVnM/pFQKXcKh3h6h6II6CR7orkC/AphG
 IseYwvf9I6HMdO/gtDL5zduaZkLzzkcRuGZdkfvpHEY+HNfRggsqJqSetxNus32axzGP
 kWvcbQbbIf2mUkCpOBfRTsOXVqbl9JBq0bLI9MIF7k5yEfB1oL+xzgTy0idZCxk9h8z0
 /eLg==
X-Gm-Message-State: AOJu0YwiISf0nDUdNmJUE7Fe9Rub//Lv1QepaoTfeVzqDBnkH99mwYRi
 UySjDJLEha+lmmbWFd5NvVCEIkpV7t/m5zXxq/gGCq5MNQwH7KaTBJ/F88/CmPvzI5y1HBI7+Ts
 hNFnTboaDHMzQgo6pym/FzNwNMAo22d9BfQwW2CfuFLMpgnf28M897rpZzjQDOKm0LutYdS81z0
 k+uPTd8Mn13ymlxn+V8Ewt9GVnduwrPV21Qt+z2g==
X-Gm-Gg: ASbGncshc0ZyYxfofjswgVCv9S+7ts4OesDwKYe/5CNAJEX9A++ahrNK4TCCcR9Vvue
 wmurBBOAcC24/5fg//e2wFnNlaXP4qFBe2A4Qg43+clbsKMlwMydxOX4vNGmLq5Vdwg9v8/X4bW
 Vtmqpj57Ebs09ScwXhCzUjSBcCAx5LNnH21lhUODjMVWQTExqFZ63nHu5gwY71ypsAmwjd9QbS5
 RrPYxOkFDbO51RG9NePztK4gTF/4bN+9w1TkGHDtsiIv9L+ckHqFwc3LYmbCBw6uOTHbrVMr7x5
 uWWEfWVa6q1uKGFflOjU2Kj5GpXEC8pNu3WyzCEzEU3AdzOQUNUjFyS/RriaryNBYPXfREC8LiQ
 DuZo=
X-Received: by 2002:a05:620a:6910:b0:8b2:e990:5114 with SMTP id
 af79cd13be357-8b4ebdae72emr569419885a.42.1764103612086; 
 Tue, 25 Nov 2025 12:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4opvrwsE3cfcibnqP1KMmWuT3YknLfwh1RZqjWyFMCkK3t/r1GWiHGk565qWqjq0GY6kmkw==
X-Received: by 2002:a05:620a:6910:b0:8b2:e990:5114 with SMTP id
 af79cd13be357-8b4ebdae72emr569415685a.42.1764103611534; 
 Tue, 25 Nov 2025 12:46:51 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 1/6] migration: Use explicit error_free() instead of
 g_autoptr
Date: Tue, 25 Nov 2025 15:46:43 -0500
Message-ID: <20251125204648.857018-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125204648.857018-1-peterx@redhat.com>
References: <20251125204648.857018-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

There're only two use cases of g_autoptr to free Error objects in migration
code paths.

Due to the nature of how Error should be used (normally ownership will be
passed over to Error APIs, like error_report_err), auto-free functions may
be error prone on its own.  The auto cleanup function was accidentally
merged as pointed out by Dan and Markus:

https://lore.kernel.org/r/aSWSLMi6ZhTCS_p2@redhat.com

Remove the two use cases so that we can remove the auto cleanup function,
hence suggest to not use auto frees for Errors.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd-device-state.c | 3 ++-
 migration/savevm.c               | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
index fce64f00b0..db3239fef5 100644
--- a/migration/multifd-device-state.c
+++ b/migration/multifd-device-state.c
@@ -140,7 +140,7 @@ static void multifd_device_state_save_thread_data_free(void *opaque)
 static int multifd_device_state_save_thread(void *opaque)
 {
     SaveCompletePrecopyThreadData *data = opaque;
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->hdlr(data, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -159,6 +159,7 @@ static int multifd_device_state_save_thread(void *opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
diff --git a/migration/savevm.c b/migration/savevm.c
index 62cc2ce25c..638e9b364f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2823,7 +2823,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
 {
     struct LoadThreadData *data = thread_opaque;
     MigrationIncomingState *mis = migration_incoming_get_current();
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
         MigrationState *s = migrate_get_current();
@@ -2841,6 +2841,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
          * return we end setting is purely arbitrary.
          */
         migrate_set_error(s, local_err);
+        error_free(local_err);
     }
 
     return 0;
-- 
2.50.1


