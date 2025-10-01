Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46916CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3reD-000718-KB; Wed, 01 Oct 2025 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdq-0006c5-6s
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdf-00039P-6p
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIwJgVYIGZUKll1gghbqQt5+easj/kEX2fqVE1B0CB4=;
 b=Qi1CgX4wgmS0KVArEQGImPdmlEdzCeayvUTSvJ3lnK9tMJyM425BEm2BCNp7/4NWAfLZQn
 aOlQaU+hm5PSfc9Ckbb0HQ6dsSU/RwLJW1R9q9Xr33XIGx/UfRweX1HA8p74+nAORyin+9
 fEYuPuNZ7zEgTpdsyh3HYBcI+0QD5RM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-MGS7lVC-PhyTqhbbGvk6pw-1; Wed, 01 Oct 2025 03:52:33 -0400
X-MC-Unique: MGS7lVC-PhyTqhbbGvk6pw-1
X-Mimecast-MFC-AGG-ID: MGS7lVC-PhyTqhbbGvk6pw_1759305152
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b3bc13c24d6so70881066b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305151; x=1759909951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIwJgVYIGZUKll1gghbqQt5+easj/kEX2fqVE1B0CB4=;
 b=WE1zvLS5dLofoHx273ZDfkYoyBffzl/FrZlnLvGN7KtlGdRqtMtqVH9qagd0TaZebK
 o6yLvo+Ky+ZTql2bcR7EcglF5dpPZZywjePvsIll18l8suhC09vc8uIzQuGUSRHXdKg8
 x1gLHR04M+qaPfRMkYLBBGuyVrKP8irsUCMcO2vvhUlVLSaARBYh+E+ZDYsMHIrbTGzB
 SV+L2dXqvaqlQDmGPrFzFFuxjoqV7NxsshLDki2QTPJL748+Y1Vm0pAkZNgNAJijY+Wz
 lJELpKS2XT3QhxFxk89XjbcixpaBTirCU/hi0RCaxW17xBMhB9zazCx65AQu2OGoUydd
 AMtA==
X-Gm-Message-State: AOJu0YxcGy3J6N0/+YThZE9Cd0I1JliTXSi0136N+FCjVRwvWm35vwNq
 gf/AXmORz1hm03sJst2j17xlRAjGebOq4IER4AR400a4tFSwzbFyqHPgr45wPz6n3p1uQx8xWEE
 dpldG3POx4dOalQAfHTLmoqssUQrYDHM5nSjYloJTsni38IG3Mc+aJ9LzsXkagGAGsCJW0SM6PE
 bdEXDxJ8X06R+s20jorLJdbte/raAHUzTMN7ZMTZcK
X-Gm-Gg: ASbGnctcGfPGlQIKzRCnOCIdo7X7Bgm0L63HnloZN8AxeFPSobzezJH+2PJrEqIbGs7
 f5f+9Rwm68WvWfSfhDjPrtZVEgr5KZNHXsf5T0X/9zP70s5w4FiaeiA0Qy9XvqiI4GyD3o2WLzM
 RXEBumEXKcVue9LpPwGr8KeOC2jIYQMk26tv8dESul9Nnv8EWIibT4p7v9k1xqZohSZA3EVbHxg
 UnxQ6xgxRPGJJzyn511xowVwAmy8jr0+gaphgdedW3t1hnzIGHaXhNAwRJu7sfchjGboddHTsvp
 q2P9VsbZDZdhypC6A/3TJnWthNa6YKSZvfpVOhwtjYxuuixZD9nMPaEkRiaIMAr0mOV5KvXhgE/
 Yba3JQselb6LgSZzZD8oDu7+seIV+Ox68TVMCuLJbp1HhEwwZWmY=
X-Received: by 2002:a17:906:c106:b0:b0e:83e7:f6e1 with SMTP id
 a640c23a62f3a-b46c75b4ec2mr307729766b.15.1759305150916; 
 Wed, 01 Oct 2025 00:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLT7LxT6vvj3hOMDIfZFwKIxPBumaSlDhUZygjElR5Bli6XhI5D1vtWWoZtC0eAMZ/NtFYyg==
X-Received: by 2002:a17:906:c106:b0:b0e:83e7:f6e1 with SMTP id
 a640c23a62f3a-b46c75b4ec2mr307726566b.15.1759305150375; 
 Wed, 01 Oct 2025 00:52:30 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3545a98e54sm1325751166b.97.2025.10.01.00.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/11] timer: constify some functions
Date: Wed,  1 Oct 2025 09:52:08 +0200
Message-ID: <20251001075210.1042479-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/timer.h | 6 +++---
 util/qemu-timer.c    | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index abd2204f3be..aec730ac257 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -699,7 +699,7 @@ void timer_mod_anticipate(QEMUTimer *ts, int64_t expire_time);
  *
  * Returns: true if the timer is pending
  */
-bool timer_pending(QEMUTimer *ts);
+bool timer_pending(const QEMUTimer *ts);
 
 /**
  * timer_expired:
@@ -710,7 +710,7 @@ bool timer_pending(QEMUTimer *ts);
  *
  * Returns: true if the timer has expired
  */
-bool timer_expired(QEMUTimer *timer_head, int64_t current_time);
+bool timer_expired(const QEMUTimer *timer_head, int64_t current_time);
 
 /**
  * timer_expire_time_ns:
@@ -720,7 +720,7 @@ bool timer_expired(QEMUTimer *timer_head, int64_t current_time);
  *
  * Returns: the expiry time in nanoseconds
  */
-uint64_t timer_expire_time_ns(QEMUTimer *ts);
+uint64_t timer_expire_time_ns(const QEMUTimer *ts);
 
 /**
  * timer_get:
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1fb48be281a..56f11b6a641 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -89,7 +89,7 @@ static inline QEMUClock *qemu_clock_ptr(QEMUClockType type)
     return &qemu_clocks[type];
 }
 
-static bool timer_expired_ns(QEMUTimer *timer_head, int64_t current_time)
+static bool timer_expired_ns(const QEMUTimer *timer_head, int64_t current_time)
 {
     return timer_head && (timer_head->expire_time <= current_time);
 }
@@ -475,12 +475,12 @@ void timer_mod_anticipate(QEMUTimer *ts, int64_t expire_time)
     timer_mod_anticipate_ns(ts, expire_time * ts->scale);
 }
 
-bool timer_pending(QEMUTimer *ts)
+bool timer_pending(const QEMUTimer *ts)
 {
     return ts->expire_time >= 0;
 }
 
-bool timer_expired(QEMUTimer *timer_head, int64_t current_time)
+bool timer_expired(const QEMUTimer *timer_head, int64_t current_time)
 {
     return timer_expired_ns(timer_head, current_time * timer_head->scale);
 }
@@ -649,7 +649,7 @@ void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 #endif
 }
 
-uint64_t timer_expire_time_ns(QEMUTimer *ts)
+uint64_t timer_expire_time_ns(const QEMUTimer *ts)
 {
     return timer_pending(ts) ? ts->expire_time : -1;
 }
-- 
2.51.0


