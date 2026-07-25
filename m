Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76855C53200
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncw5-0003mX-LB; Sat, 25 Jul 2026 10:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncw3-0003jw-GT
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncw1-00054e-VJ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayGYuMqLtdZ4tO4DWqG//BYWp/04yuY/5uhQAQdO2WU=;
 b=c0Kq6RyMB5GygXemYIIR8lN25GM+dd670Lucc21gXtSg1RRzlmwfLe67RKS9unAqiiiGCO
 KgV6KgrSAdpkpvKnWZKNeP682FssFwqGY0IMSIQ4m8fGEyM7bNCHdrcBhc8cqVggYIok6F
 pcIv4dpWpmuBaPUI4AntPGPbN+O3PaE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-UIgTjnWwPw-WTRys6eze3Q-1; Sat,
 25 Jul 2026 10:00:59 -0400
X-MC-Unique: UIgTjnWwPw-WTRys6eze3Q-1
X-Mimecast-MFC-AGG-ID: UIgTjnWwPw-WTRys6eze3Q_1784988057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4366E1800366; Sat, 25 Jul 2026 14:00:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9723B300019F; Sat, 25 Jul 2026 14:00:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:08 +0400
Subject: [PATCH 7/7] qdev-monitor: drain RCU callbacks in
 qdev_device_add_from_qdict
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tc59tpUIOnJATfZj0Ow9IZihAQ/ju8XXCdAihZfGr0Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmg2IQSzXLgb1HeD4VQxrb08w/yBiPzE55j
 2UdhTQdlO+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5RgpD/46Kwqoedezh17/7AwZORHSgHU7hKbFErb7X4Ikhq1/dLQSkXBtm5abklnGQO7N8TO4sS8
 OfbbNBDS/aeA+btHMl5bLz/O7y3tWsqLYR76CbHnw+iWqxre97mP4BVZzLr1YyhxzsGM6xMQndb
 zV+npve/xAPguVU5RtwD4l9qK3BQAhLagSqG5zWC0otLwxithRDCHnVRVtDGpiO0i3QkmlzLTjq
 HHuCMUOKjJZNHFuCej8YbXh78jDonklWR/aBbeONo2zlTo9k5vGjOp2unuKBB+SftjxALcevMGu
 e4ivmu6IKX83FV9zzfo8M3bshxBabng6IzOITBfuDh7KTAdHyC0F+H9CuS5aCIk3eHXJebdYcDK
 fi51MqFwAukd/0ePcpgm8loFqF6gJGoeiaA7n6SmkYtdV6mlkpyzw3BWftmoxMWob+6QU2OIszu
 LHsbC3TBB/suz8NCRQLpuLIf6f3HmO7pcUW6FLP5S4UvKX73xCwh+wuJCz1Db50DpTvwbiPJfEH
 S8S9v0H9tD1SNUuPILRTVH6U7iSfQ+6zUXRBfKDebGFmsgypyReuwWpSODYgP/qEJdet3krd74m
 GHVq0aVf0YH7DTRUU1zmpI6q3tLCdRl9XlD+PZAVfuFqiSonRAF9X5dJ6qwv2bvDia/Dx+5FmJ/
 GijtQUiJ8r6cJCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qmp_device_add() and hmp_device_add() drain pending RCU callbacks after
a failed device_add, since some bus teardown (e.g. bus_remove_child())
is deferred to call_rcu(). -device on the command line reaches the same
qdev_device_add_from_qdict() with errp pointing at error_fatal, whose
ERRP_GUARD() exits before control returns to the caller, so the caller's
drain_call_rcu() never runs.

Move the drain into qdev_device_add_from_qdict()'s own err_del_dev path
so it always runs, and drop the now-redundant calls in qmp_device_add()
and hmp_device_add().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qdev-monitor.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..884d407d60d4 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -746,6 +746,16 @@ err_del_dev:
     object_unparent(OBJECT(dev));
     object_unref(OBJECT(dev));
 
+    /*
+     * Drain all pending RCU callbacks. This is done because some bus
+     * related operations can delay a device removal (in this case this
+     * can happen if device is added and then removed due to a
+     * configuration error) to a RCU callback, but a caller might expect
+     * the failed device to be fully torn down once this function
+     * returns.
+     */
+    drain_call_rcu();
+
     return NULL;
 }
 
@@ -870,18 +880,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     DeviceState *dev;
 
     dev = qdev_device_add_from_qdict(qdict, true, errp);
-    if (!dev) {
-        /*
-         * Drain all pending RCU callbacks. This is done because
-         * some bus related operations can delay a device removal
-         * (in this case this can happen if device is added and then
-         * removed due to a configuration error)
-         * to a RCU callback, but user might expect that this interface
-         * will finish its job completely once qmp command returns result
-         * to the user
-         */
-        drain_call_rcu();
-    }
     object_unref(OBJECT(dev));
 }
 
@@ -1017,17 +1015,6 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
     }
     dev = qdev_device_add(opts, &err);
     if (!dev) {
-        /*
-         * Drain all pending RCU callbacks. This is done because
-         * some bus related operations can delay a device removal
-         * (in this case this can happen if device is added and then
-         * removed due to a configuration error)
-         * to a RCU callback, but user might expect that this interface
-         * will finish its job completely once qmp command returns result
-         * to the user
-         */
-        drain_call_rcu();
-
         qemu_opts_del(opts);
     }
     object_unref(dev);

-- 
2.55.0


