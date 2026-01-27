Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7AED2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoBx-0003Gv-Kb; Tue, 27 Jan 2026 13:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBV-0002oM-70
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBT-0000fo-OM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDn7c5HvZHkPnAmOw0nvWD++OXb12kobFYVEkU88Rag=;
 b=SbWZ2HhtdBd+w/CnGM7uhKgaBwyk2O1UyxplhBNVs3Sj3vQiIEApIVpccVLXAcu7SDaxpK
 2Wi5kv7FY44wcLxHXs9fVz0mMfzW0GeG3+4wevWVW8ITkGiwG/UW9afel4BRK423jlNKES
 pGezKbFNuztnNyzEdpblo527OoIndEc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-jM90Q4SKPJy0lCjVxO2QpQ-1; Tue, 27 Jan 2026 13:53:01 -0500
X-MC-Unique: jM90Q4SKPJy0lCjVxO2QpQ-1
X-Mimecast-MFC-AGG-ID: jM90Q4SKPJy0lCjVxO2QpQ_1769539981
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894769f8732so290374746d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539981; x=1770144781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDn7c5HvZHkPnAmOw0nvWD++OXb12kobFYVEkU88Rag=;
 b=n+Gb9r19V8EE4uGdWR3oo9Go4em5lXdIl0h+dNFsz1UXHlhuTaVewhxDSnI+RSVFdQ
 j7ya+sQFYz0PEe10vNAymi2jwIL51qsJ3+u71clp8subR4c1PjuAxwBhLWIVtifTbMLr
 5UZCO2082Je31Swhe/5Rhl+RNMITgj4LTniJtqNMRDhMEFCjxSRtxrhuucbDVUyQ2/Y9
 kWDCEWE7sQxjDQcsmKRnFYWiHYCSbK/fd6soLhG2ddp4i8GuNQ8lT9G0bmRKTZdpK1MA
 +XMtNRGGkpMVk47NQA0+UQAp6zOUQhISG1mnEssSVM1uLBSrBo4bNydDWevMBNsZ9Wx5
 Q7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539981; x=1770144781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uDn7c5HvZHkPnAmOw0nvWD++OXb12kobFYVEkU88Rag=;
 b=AZ95zO9CFRhWwYsgO/C1LasuXrMaxd/MyHx3E1rBg/shKSiwAhDn2ysJ+p9FLxn5Wj
 rjCE5oITjfj/RS4v9d1MDYjxhW+eoxomA4iXLT0Ijthw+rXNl0db3qQ9QS8cSS7/nU5q
 vszINKHCvRnSz+V50rKg9zJHtRXfc+1n+np6Zl4DsHuePi5evHIqxqcMv73zb230XAZJ
 0szUkWqYQfzMCirMn1pA03pvT9Js5TOrr6tiaBSitQL5pa4KVKA6uAngPIMeCq7aS5Dh
 3HsJqY3B5TdL+ouhklpzEbnuLBxoAg0oqfWi7fYn0pTWJkPGMLAcWdYdQ10N1X8Zds/C
 CKNQ==
X-Gm-Message-State: AOJu0YwKtYdHZroTgHA+WD+DbS9eN+IqHZtmbyl4drflk1mBxFq+Qzl+
 qOEvevuVUjaWalpuXvccY/Jg8YkO7gF85X2bwse02ARBmR1oLBBnv/F8idoakHQgRrebV0hpwGp
 kBfN6dNN9c0xY7qwFzaZfM8MjiyzaMGEoxadnbdu5nPvASf6gGeoxlxLEkWnT9HSxpq0w9wR5nT
 ji87kiiv1ytIeFvMOo/zXuUG+Wy0u2Y7NXmEoTWQ==
X-Gm-Gg: AZuq6aIa7bxeFSIII7wumyl6XPwp/sBOIGhtf7vcA4xc2+T1wPppCw7T+4WJe7umaxz
 MiuDYMqBZGihMizDdP5nLw8FzjGiGlAFNLACD4yTPhHi7e/oduyK+a+f9k795cZPs2TSicY3kOX
 aRaGg6rp+uN2KV9Fu8eOrdZlDLukmjrsN42+VX18aCOd2vFLD291x304p2U0RO6FZnH2vNeBQMh
 GocF5wal6GuBMVPVLdZmVcDz8/5lKFmXfngfjy9YeAbt54Lj/Fy50Y+5iykizpq4PGD4AQcqSOi
 HJOuBEKYiHy+K2e0fvPjDBQSGinLcLZA0O4/m1o35FsLwnqOdW+zioo/z8wuxLMPqu0ODV9QzxZ
 x
X-Received: by 2002:ad4:5d46:0:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-894cc7b9c61mr43017956d6.13.1769539980764; 
 Tue, 27 Jan 2026 10:53:00 -0800 (PST)
X-Received: by 2002:ad4:5d46:0:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-894cc7b9c61mr43017486d6.13.1769539980281; 
 Tue, 27 Jan 2026 10:53:00 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:52:59 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 03/24] migration: Remove one migration_in_colo_state()
 occurance
Date: Tue, 27 Jan 2026 13:52:33 -0500
Message-ID: <20260127185254.3954634-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move the send header operation directly into Xen's QMP command, as COLO
doesn't need it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 64bf445c98..61e873d90c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1871,9 +1871,6 @@ int qemu_save_device_state(QEMUFile *f)
     Error *local_err = NULL;
     SaveStateEntry *se;
 
-    if (!migration_in_colo_state()) {
-        qemu_savevm_send_header(f);
-    }
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -3335,6 +3332,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
     qio_channel_set_name(QIO_CHANNEL(ioc), "migration-xen-save-state");
     f = qemu_file_new_output(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
+    qemu_savevm_send_header(f);
     ret = qemu_save_device_state(f);
     if (ret < 0 || qemu_fclose(f) < 0) {
         error_setg(errp, "saving Xen device state failed");
-- 
2.50.1


