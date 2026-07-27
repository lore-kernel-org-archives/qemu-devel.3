Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F57C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJt5-0008N7-Qi; Mon, 27 Jul 2026 07:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJt4-0008MR-E4
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJt2-0003oh-U8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/0isXKD3/hBm2hphOJMNjEF/saHYsIPIuvxzEaJYnA=;
 b=cKpJZ4QO1rP0/HbSVkWUmJn9sqLEwQFRCYjrMc7uf/oiNXUzbpcTI48gRLroeNm3yQPYYr
 c3ZuR0SfVohFADgBgz3uj5bEAR2i3bTgFxar1sjPaYhN978KPlfEAOFtstOGm+Ln5zp/iz
 xkWJoqe7i1oxPq9wKBWwa79wswWSBqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-MhzpsPIYOlO7VgUDfH-Q9w-1; Mon,
 27 Jul 2026 07:52:46 -0400
X-MC-Unique: MhzpsPIYOlO7VgUDfH-Q9w-1
X-Mimecast-MFC-AGG-ID: MhzpsPIYOlO7VgUDfH-Q9w_1785153165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA5B718015DF; Mon, 27 Jul 2026 11:52:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 896B11955F78; Mon, 27 Jul 2026 11:52:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:22 +0400
Subject: [GIT PULL 13/23] hw/display/virtio-gpu-rutabaga: zero-init capset
 info response
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-13-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=r58tj1oUeJZbOynomaBno1bx+WtjtaCGEeJ5HQ+OHNw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/SUbhFSMMVsWZ4VgcsfHu1GsSztRcEwiEU
 C8qteFx+WeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5c9hEACZttDd77GO+gOv37BXbSohLFjjY6ZJW48jFJ1RQ08txpECNV+C0iIUtVLle76dypxSSCt
 1UR6g6RMGDooOFXM1+1CpGSAGkU0AVx7gIoX68D+ApSYdiavzD3KswD6+tZu2PmC3UtHxnJbhVV
 JKcPgbSnSjykQSqNEtSZOWls5L7uMQU9BlUKxTrOVoOBkKmzTNKRy+rV8fd3FKXZj4Lp2qoMAKm
 PyOBPvlUvtMeXulCMcewQ/yksoy6HZ1bVH4xbLGFU6CpRBZ0KE9wJbmNv7FC6umcT8pO8nNqZb+
 v4hisH+oOUasgDPG36VZkRaekdyTG4GBcDVCyObgcExhhgXFmZwwLiRNkYaoUISQpZV/AeicHnP
 uZXHvI/vOwdGro92MjDevlaHPaHLxChYkyVPZ5xbv1N7dm59TFZwsXy6RnkcN1LWrD00TrCd1rf
 XVronA/NlN6bfQiwPEJtgG89W45LFpJWfLhFp0Nt+F0MtFI1fBccC+gTlAYhq8/QhkRs+21Jt7Q
 8h4kHT+4QU2kb/aL/1PT6t5ssxgXzIb6AhJBEYNHL9ui65xBMSNAwlodG3x+gaBIdQ3CC2gUrI/
 yMN/1mFifMHEvgRQuahn7cGUoc1+vPag1indxyaJk0JfPwRRItGJEJV5NC05sw+iChBlSTen2Ct
 ppAd6wIVOwqE1pA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

rutabaga_cmd_get_capset_info() only fills in capset_id,
capset_max_version and capset_max_size before sending the response to
the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
stack garbage and leaked to the guest, including host pointers useful
for an ASLR bypass.

Zero the response first, matching virgl_cmd_get_capset_info().

Not a real risk thanks to -ftrivial-auto-var-init=zero, but only with
gcc >= 12 or clang >= 16.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 8e6c7a0d5ddc..e28aad94eead 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -556,6 +556,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
 
     VIRTIO_GPU_FILL_CMD(info);
 
+    memset(&resp, 0, sizeof(resp));
+
     result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
                                       &resp.capset_id, &resp.capset_max_version,
                                       &resp.capset_max_size);

-- 
2.55.0


