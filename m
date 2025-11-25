Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65293D0EE1C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxF-0007pF-TA; Tue, 25 Nov 2025 15:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwG-0007CL-5o
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwC-000316-8V
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1pESVjBvJTZ/CKgbTrEvkbhJJvwnKZXdmxAANhR78Q=;
 b=EH5A+PPIA6JgEhxwKDg466MXrQR2smk6t83ZKXAGtmlIyyR9/j2NtUkHFaFg57Z2W1FoMv
 /SUGqeY8TLbg0NooEZ8BZxXz2ENyugWNrtrBiaet9YfvIWHRi080LWmpegEKL3xIJIHtuS
 ouI89KCQztBGcL7v1nN/leaYEWw+BPg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-hQ1D67DOOTuxjN-swfJctw-1; Tue, 25 Nov 2025 15:46:57 -0500
X-MC-Unique: hQ1D67DOOTuxjN-swfJctw-1
X-Mimecast-MFC-AGG-ID: hQ1D67DOOTuxjN-swfJctw_1764103617
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b286006ffaso1437774885a.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103616; x=1764708416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1pESVjBvJTZ/CKgbTrEvkbhJJvwnKZXdmxAANhR78Q=;
 b=p/CwXOKX2+GQaX8mCqIAL6oSYw2hdShJyz4sr9fW6RMY+qPKhw3ECizzpzMOG0Rgh+
 hEsnc3BiHdlvWuIsdsyupwpe2uFXaR1py6bhh9Ob3hYPD6Sy2rQvlEMrLvxNjWtd2iM+
 ef0nHbmWGQ1j6pGhwQpY8/wOHEiJ/Ni9GSp5iNfCuC8dhs/kYiSfkR87JMWoYhNyePgt
 GYuARZlICOjOEOY1argMpo+ShJd35hmFBt3dcrlzI7J7X60n/fGjwJtbEXEsftGpao08
 FG4B3DcnHZpFRaAOnz2DQuyjHQolKTCD6x7boOVZ9s6DrrKvNJlJdfd0wjhxvZ83nh0E
 HKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103616; x=1764708416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h1pESVjBvJTZ/CKgbTrEvkbhJJvwnKZXdmxAANhR78Q=;
 b=kmyESE4q/4Q+Clu8jkgVLZ8pRL3FO7M39iWVqNWbz/23Lt+MmkXydKRpxgU/7PtMpQ
 gg7zFIM4Qf2sYs+jAJ97Z9pct+TjiAnT0MVa3ufjHL/pl5RtMl8LT7oGbE3bGZhHvIbF
 zlNVEx0bTPb7J9LwX/2hVp2D3bU8EtTfDs16ulgg5BdO8pqv4O9wsZunEejIXkV+sd2R
 SjXp/rIsDs+aBTPK9yRt7iHngS9YFXCEItq0mavyUAp351nmfNunOqOuFhjKQseh7px2
 UGKU6+nmNCGcjnA8OLHEhwRN4rSzKvlPdhaNsOTjynjGS7m1/Jo5cmqc0C6fq5BXqmqb
 pCpA==
X-Gm-Message-State: AOJu0Yy8NFVxdDsXXGjms6egmof4ETZzRD/OzyqCbTO5/sPuVkJnSkvM
 O291EGWWpWGqSgKXs3q92SJO/m1UEIuZD05eRJ/sXF1Ser+Kx0IgOkLdVshNPTMlTPPRtkvR6O2
 3mNK+1koLAZpKWNTsQCvmoQ6AR+QiXSCPoT5l3mHgVdNcBw0U2hJ1Mpj5/lEYLjVHGyGSKg1/kr
 dYu6rOCXo4exFemnEyq61s8Roq/RwvQSeq+SI/xg==
X-Gm-Gg: ASbGncs0+QzUOaWITVopSLu2iT0f7kKQqtyhVeY3pLmS2BYgyd3X2aEE3eSheAcmFXr
 QbUdFtrk27YNzeu22QsSKhNOqOhv864PkKAdAEIN8+fJ4tg6K4+yUlaJXHin+VfwpCfEDOGYNHg
 5UgsIsbuGBKrPrUIplFtYRUhqnPMXxBlrNCaX67FgVsh0DnPcxU4XECN7kjlQoC8khmHtkealc7
 l2nTfNLxO1qe8/o9m4j8rxvbwIPVOJ5utOnGRa0Z5xKbs4gTR1Z8toQSUW/7MB/s0CjubaazyxG
 fwdoYKva+r0t2pyFXFu938WM9ldf5cO5+ue5F19BWAHv5bCLTK8HssfYw8e7kpB8wwArj3mmRoK
 uojk=
X-Received: by 2002:a05:620a:1714:b0:89f:5541:b5f5 with SMTP id
 af79cd13be357-8b33d1b2657mr2289593785a.17.1764103616234; 
 Tue, 25 Nov 2025 12:46:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmGYxeLhGq5kkXinQxC/A+b0ffjCDohLyrrNxCIwhrkXmk828epRwgT0l/5UCL0duyL3ZJCw==
X-Received: by 2002:a05:620a:1714:b0:89f:5541:b5f5 with SMTP id
 af79cd13be357-8b33d1b2657mr2289589485a.17.1764103615539; 
 Tue, 25 Nov 2025 12:46:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:55 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 4/6] migration: Make multifd_send_set_error() own the
 error
Date: Tue, 25 Nov 2025 15:46:46 -0500
Message-ID: <20251125204648.857018-5-peterx@redhat.com>
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

Make multifd_send_set_error() take ownership of the error always.  Paving
way for making migrate_set_error() to take ownership.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3203dc98e1..930eee9949 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -429,6 +429,7 @@ static void multifd_send_set_error(Error *err)
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
+        error_free(err);
         if (s->state == MIGRATION_STATUS_SETUP ||
             s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
             s->state == MIGRATION_STATUS_DEVICE ||
@@ -779,7 +780,6 @@ out:
         trace_multifd_send_error(p->id);
         multifd_send_set_error(local_err);
         multifd_send_kick_main(p);
-        error_free(local_err);
     }
 
     rcu_unregister_thread();
@@ -908,7 +908,6 @@ out:
      * cleanup code doesn't even know its existence.
      */
     object_unref(OBJECT(ioc));
-    error_free(local_err);
 }
 
 static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
-- 
2.50.1


