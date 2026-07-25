Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313CCC531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 14:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wncvU-0003X2-QC; Sat, 25 Jul 2026 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvT-0003Wh-41
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wncvQ-000515-My
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 10:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784988022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sMkB49AJSC8avS3ylIG8JsgdXl7kTvtqlZEz34WRqRI=;
 b=N45Wh2GMWACS2XxHnbUzlzBoYz4nnh3clp2OgMepyxOsVA+zajK+i2ZYtXZJoqn6ZYFKGE
 dgydH83ltW/uXkjqZ8rJEXNvE4uakdP1ZuNxfuLby1yckLIo1gkIpJ7jlGq15mgNdHlzSQ
 lMhPzv3kcJFxThN9P9hgF13dmAWg1vM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-bru7P_bxMZaU1UpPJHRhFA-1; Sat,
 25 Jul 2026 10:00:18 -0400
X-MC-Unique: bru7P_bxMZaU1UpPJHRhFA-1
X-Mimecast-MFC-AGG-ID: bru7P_bxMZaU1UpPJHRhFA_1784988015
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 098BA18002D1; Sat, 25 Jul 2026 14:00:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3844180057F; Sat, 25 Jul 2026 14:00:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/7] Fixes for 11.1
Date: Sat, 25 Jul 2026 18:00:01 +0400
Message-Id: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3bTMCiNds1RTwxQjY0NzS5MkJaDSgqJUoDjYmOhYCL+4NCkrNbk
 EpFepthYArFUDzGgAAAA=
X-Change-ID: 20260725-fix2-6e51d231794b
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Haotian Jiang <jianghaotian.sunday@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lXenDq8VhO/CQidP59Zf/rUFYaTPbWRyfx8K5nWqM3A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFlzjhua2XJ9qKFuUZoGltAjqoD+6VC0jRdO
 mHxxqlOAlSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5YblD/9uGULyoQvLf1S4WJHbuo6j884tmQ+nnyp+i6ItXJ8pYluxd/VhKRg0SZMRj/Zt9Z25ePm
 pysfYH/TVKngEmDXdzvSb+j83YE/emPoUJKSDiwmw7EwOXuBtMP9ZhTMa+lLf0WcvGHIYEhmEkX
 EfsVaRvIgOeriij+EV3QdVeZPhXf1gggfl+PWsvc00dXO0c6SRQ+y8/KmdIhPIH3Ijr6Gas/bwq
 WkrCTc1O2keHN075MIheEIUDFzFh2uW8eJzff5AA99Hkk2TUF1K1y05uZkfXfN58NCUWz4bwU0Q
 FbHz64oc4piO4d9R4/t0MXvjmWreLdsI0wjv/Fffv9AR2MO4dpIqo9DZSHLbnGOONamEsnOsSoc
 FtCQ9BnMcdXxPvCrd6idvwCObmXvXqR2R1F5l7RjOomUqgqaONpJyTPMLld/yfoQDV68p4SSBkL
 kPrknSWHRwAhFmQXiIV8jjZDbl83MLDi2ikGpUy66z0UbWVezBI7H68F7+REjdaXIXFFtLQ1NS2
 NQ4pngMIDMoFq49ONkI3u7TFPZ2Uh2TG4KlH17mqIx9wUbjea+VRDnU8FHYa7FNQr+JGzXKDHAe
 MtgvjsheQpp1B1KdhHU+37y9c0pRO3WrKFCGq7LQlm5kMTCj3fIZpf5+PkbJIsnlZJcdoRrDGNa
 jDaT6eprT55WC2g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Hi

Here are some assorted patches worth considering for the 11.1 freeze
bug-fix period.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (7):
      hw/display/virtio-gpu-rutabaga: zero-init capset info response
      block/blkio: fix error return value on getlength()
      Fix many -Werror=maybe-uninitialized
      hw/hexagon: fix machine->fdt leak in qom-test
      hw/core/machine: free machine->fdt in machine_finalize()
      migration/multifd: fix Error leak in multifd_recv_terminate_threads()
      qdev-monitor: drain RCU callbacks in qdev_device_add_from_qdict

 block/blkio.c                    |  8 ++++----
 block/qcow2.c                    |  2 +-
 hw/core/machine.c                |  1 +
 hw/cxl/cxl-host.c                |  2 +-
 hw/display/virtio-gpu-rutabaga.c |  2 ++
 hw/hexagon/virt.c                |  9 +--------
 hw/scsi/scsi-disk.c              |  2 +-
 hw/scsi/scsi-generic.c           |  4 ++--
 hw/scsi/virtio-scsi.c            |  2 +-
 io/net-listener.c                | 10 +++++-----
 migration/multifd.c              |  1 +
 system/qdev-monitor.c            | 33 ++++++++++-----------------------
 target/i386/cpu.c                |  3 ++-
 target/i386/emulate/x86_mmu.c    |  4 ++--
 14 files changed, 34 insertions(+), 49 deletions(-)
---
base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
change-id: 20260725-fix2-6e51d231794b

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


