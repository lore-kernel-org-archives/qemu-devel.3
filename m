Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EEACDE010
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrXM-0008Az-Ks; Thu, 25 Jun 2026 17:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXL-00089q-NL
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrXK-00048O-2J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag7F9xteFBEKBw2pzxGC4debp42G/GndA61uJ7Hkh+c=;
 b=Qo+gujvqOV5QehMoTbmQ1gOLkHJQnzI03hbsFplVQSopwkI8RCclYb7ThjmsqCReXs4Dzq
 0c0eG3NDuPqMBMK9jubLuILOXb13xrLgPqUmCwtbk0Bpk8wryT/3Kuj7e3kRHuGSdQsmvd
 nePt+tMJSOyd+iYQA2kvgbvebfRZWBE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-6wNs1QmpN26t1RYs9BIEHg-1; Thu,
 25 Jun 2026 17:22:58 -0400
X-MC-Unique: 6wNs1QmpN26t1RYs9BIEHg-1
X-Mimecast-MFC-AGG-ID: 6wNs1QmpN26t1RYs9BIEHg_1782422577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E87A1955D54; Thu, 25 Jun 2026 21:22:57 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B38F180059F; Thu, 25 Jun 2026 21:22:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:39 +0400
Subject: [PATCH v2 38/39] monitor: guard HMP internal helpers with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-qemu-no-hmp-v2-38-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gtrBrCcURBTHkW9jIWAENQN706Ffioe+/a51GP4eiLU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZterzQUa0BCgIB5pptrvVtY1I4DDoVshOXKv
 2Ptij36ebeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5V3rD/96Us4HYv8jfvrvJEpaeGYHOHM6hHBaldJT/aN7EExRhwzLWlr/IFR4NVmBiM1+wW8uqBu
 LVwrxJ0tUmOY4KiJyxGNkgFQzg6DMWCyIccuDXGiuvu9mb0y9tKmwKTjJrcVMFXXUjSagvxdabd
 rpB0XQH/R5zI1rzdSWQAMqrMQAoZJYl9V6p2eeoFtvVrnneFNBB5cvqHMN8P5u7yEhm6B/PqmAx
 z9vMDSo2CKYe+DnCBsscwofOGg1unA6Y0ZjyzDccOTHCdXsTetUBrcjdUyqVXMoRPjOtad5YYfB
 8PB4CaHRr9NvovU1oMviiyZum7KRHHxEVRU+h6ijesbCczZeOzu93DanBhxZIZ5pYcwF2+skLlM
 68zYHczZvLVas4pgSNtudrbXNKjt0EdP51TtjT90FgvvuxyXtIKLNvYgsOdGQRAuybQTWJtQoNQ
 Q1Yb0TE0kcVlKAgAzw4HREIhRTClXdzM1MXA20BxZoultLOf4xnLaSYCL5pn1y2bbK1U/Z1gaab
 qZt2iVO4M/cLq8gSyfkCJLdzvH/R9g4yNhcktOoMAkLVmY4zRD7ni4z1eIUx51FLZSJL/uf93G5
 1mcTAdlgpoiZjaRI8yTWIpPf6OuBTJR9zUIsA0UISp9HAgZeW2GT01scd4DcUFlOXGoInODqPX/
 eGZZQd2qq4qmUiQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Guard monitor_uses_readline() and monitor_is_hmp_non_interactive()
with CONFIG_HMP, providing a stub returning false when HMP is
disabled. Also guard the HMP code paths in monitor_accept_input()
and monitor_data_destroy() that reference MonitorHMP fields.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 50f1fe77c33..c8207af57ec 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -116,6 +116,7 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
 
+#ifdef CONFIG_HMP
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
@@ -134,6 +135,12 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
 
     return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
 }
+#else
+static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
+{
+    return false;
+}
+#endif
 
 static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
                                   void *opaque)
@@ -540,6 +547,7 @@ static void monitor_accept_input(void *opaque)
 {
     Monitor *mon = opaque;
 
+#ifdef CONFIG_HMP
     qemu_mutex_lock(&mon->mon_lock);
     if (!monitor_is_qmp(mon)) {
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
@@ -555,6 +563,7 @@ static void monitor_accept_input(void *opaque)
     } else {
         qemu_mutex_unlock(&mon->mon_lock);
     }
+#endif
 
     qemu_chr_fe_accept_input(&mon->chr);
 }
@@ -631,9 +640,11 @@ void monitor_data_destroy(Monitor *mon)
     if (monitor_is_qmp(mon)) {
         monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
     } else {
+#ifdef CONFIG_HMP
         MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
         readline_free(hmp_mon->rs);
         g_free(hmp_mon->mon_cpu_path);
+#endif
     }
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);

-- 
2.54.0


