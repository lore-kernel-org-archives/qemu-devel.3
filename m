Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA10D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 19:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ9pz-0000oX-Sm; Mon, 01 Dec 2025 14:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9py-0000nY-3Y
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQ9pw-0005IX-4j
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 14:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764618327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kWVrVdnd8jt0TShIHQCg4+CRPqbkyfemQjl5ovQg5U=;
 b=W5ZwzD4ddag9TaHUYGhvDfsyctncdIB4i1OnoE/6LGkIqFs4i4gVa0/t7Gze0I4KXnuzR5
 qSMeEGt/jL1PK9uXzS90HY3J6MuH5eRsdOSj0LLB93ZRtgRYC3Pqn4cacLs1vqYLxDPAjA
 10AcqoA1XdbVOnXOc2pqdR8j9503t40=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-rlOPxvLMP4yDu6Hi2KdQWA-1; Mon, 01 Dec 2025 14:45:26 -0500
X-MC-Unique: rlOPxvLMP4yDu6Hi2KdQWA-1
X-Mimecast-MFC-AGG-ID: rlOPxvLMP4yDu6Hi2KdQWA_1764618326
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8823acf4db3so84167026d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764618324; x=1765223124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kWVrVdnd8jt0TShIHQCg4+CRPqbkyfemQjl5ovQg5U=;
 b=uGpyTLFsPXiSr6cpWexgdGHhT8peA+kVtftyWYmIZb7L4AlrVR7foMM7bcB2mCIQcc
 kSuQxXMrInY7pRkUKocKK1YG0QqU6zto64VLKAvOMXb0GusFCG55IfuKLSVe2S/Gffqz
 0pQyaeMk+9HbN820OgIsnYrW7+s1Biui5oMO9OPV5ujLQpIf9kvoZPlp2kj+xTB/ySbs
 Jyy5mNwEp2c9mho/BMQ2bkTqVpVnl3Aidu+QFMjwBh+Qffb7grqWjP3ersWuIZDQKlDv
 8D08glqKOlevAyiSmELJhBHifrHyTmUKUEfkLAbgfDNuVfQ2adnJk3szKgvcsO1ojrh6
 iQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618324; x=1765223124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/kWVrVdnd8jt0TShIHQCg4+CRPqbkyfemQjl5ovQg5U=;
 b=c0eIeDo5hBDObvbX7NosCQLTYv2eVU2bBmnQ2wkESdW3EIm/UAFxo+DA6+JNjrYyYD
 Mh/y764rHfGPLPWLiMGAjsBMlvF97B8Aa7tYVLoYV/iOP5Xngu8Q09C2rBt7oExZb2DT
 4Ny68vwlYHIVzCbd9AhQmCX4hghtYGDL0sv+1eNqXtPV26TGhnb6LJFSTZff0ZJRyYKC
 x1LCTsY2MKbZk38gNrnV4nymQxJ1FjhlklQokcGYs1mJXupH3lmqsKPS5Rdmd2qgtFy1
 rOtuem54edhfBrtChApIbLTDcjs9B36MZ3kDS5qo+lWgTbMut4W+n2MC9oMSP9QqmJ66
 B8BQ==
X-Gm-Message-State: AOJu0Yz8lbu3KLcGmmTly9/EiUZTXdtgFh+WtMd/yRCnP8aux4ehHz4I
 7GGyXw2V+iWLhMGAlDuY/pPTBeKerDcXxU2wc/kFR1eOFIybRkS6qqKqRrfqvywlsGeCBuaBawU
 6sXgGJ582AmFgrkgWr0kZf6Mc8InrlYW7wzw+ETrQiu0q/euVKPfs4Qz1mNzQ1o8RPBmS3ifL/U
 uYe7sAuV/4S1aw9143lGWZTWS9h2kLYHOdrlQvIQ==
X-Gm-Gg: ASbGncsostkOra30gPm/0PF2A5ljX2muRQf3R8C4S7LEwZbd2IJZxDQgQYT36JziXtZ
 4ayF+RAlHO4i/fbvmnrtIz/kXLqmF26c7TtxufxqpeDbnm+VOZ8Q2cGsictklsACCqTq/97lMB0
 Tfth14Sgv9ykw1ZI+9JNQXOrdpoq6Ay90uWrzPwAaqyDfDNN7ytFPr63cvl7S+r6Qh4nM97MGBY
 nB1XQhpjnRyZ+IB69lA3zLKFGdKQumPfDwZiTbP5e+KFJ0JLYGFZfP8jQJ9c8g9/9kE4FTyM2ex
 aWKhBaYN2gInePGnnUXr4NeVdO921eKARmKVx4qq0+9D52E9Ea2Lvwz+KjeEt5VT3TOv8F8wqfK
 N
X-Received: by 2002:ad4:5be1:0:b0:882:489e:a7a3 with SMTP id
 6a1803df08f44-8863afb10a1mr462160886d6.52.1764618322979; 
 Mon, 01 Dec 2025 11:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsN7TcDaqsVVsVWqFxD1zeWiHPGTvy2T/hcr0r5N88NJ0K9SYrEfwFimc6f5FrDxYqKoXAaQ==
X-Received: by 2002:ad4:5be1:0:b0:882:489e:a7a3 with SMTP id
 6a1803df08f44-8863afb10a1mr462158326d6.52.1764618321268; 
 Mon, 01 Dec 2025 11:45:21 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b91ba3sm88835156d6.53.2025.12.01.11.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:45:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH for-11.0 v2 5/7] migration: Make multifd_send_set_error() own
 the error
Date: Mon,  1 Dec 2025 14:45:08 -0500
Message-ID: <20251201194510.1121221-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201194510.1121221-1-peterx@redhat.com>
References: <20251201194510.1121221-1-peterx@redhat.com>
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

Make multifd_send_set_error() take ownership of the error always.  Paving
way for making migrate_set_error() to take ownership.

When at it, rename it to multifd_send_error_propagate() to imply the
ownership transition following Error API's naming style.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3203dc98e1..651ea3d14b 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -414,7 +414,7 @@ bool multifd_send(MultiFDSendData **send_data)
 }
 
 /* Multifd send side hit an error; remember it and prepare to quit */
-static void multifd_send_set_error(Error *err)
+static void multifd_send_error_propagate(Error *err)
 {
     /*
      * We don't want to exit each threads twice.  Depending on where
@@ -429,6 +429,7 @@ static void multifd_send_set_error(Error *err)
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
+        error_free(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -777,9 +778,8 @@ out:
     if (ret) {
         assert(local_err);
         trace_multifd_send_error(p->id);
-        multifd_send_set_error(local_err);
+        multifd_send_error_propagate(local_err);
         multifd_send_kick_main(p);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -901,14 +901,13 @@ out:
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_send_set_error(local_err);
+    multifd_send_error_propagate(local_err);
     /*
      * For error cases (TLS or non-TLS), IO channel is always freed here
      * rather than when cleanup multifd: since p->c is not set, multifd
      * cleanup code doesn't even know its existence.
      */
     object_unref(OBJECT(ioc));
-    error_free(local_err);
 }
 
 static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
-- 
2.50.1


