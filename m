Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4127BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwj-0005gw-IU; Sun, 05 Jul 2026 10:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwh-0005gV-3u
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwf-0001Rc-K8
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyVIPTtjvDwClzpwMwcfeN9BG2/EOcSdSHSa/m2GmrU=;
 b=atPfE1jJgXbexviBFIvQCRmwSpXqL8SjAM1c6uiBiK4kVX+JUo/di0la4+qS689JijFy+r
 kZZI0lbg9MR4JP7tt/sMRqq4jKMQDTkULNKtOE1yeMyae4+lNChrUFX4csHBzTwsbj4YiU
 VqX2xoAh7dz0j5u+C2Ysw6GcucX30FQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-yLS2rQVvPJeon93qAV8D9g-1; Sun, 05 Jul 2026 10:35:43 -0400
X-MC-Unique: yLS2rQVvPJeon93qAV8D9g-1
X-Mimecast-MFC-AGG-ID: yLS2rQVvPJeon93qAV8D9g_1783262143
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so25557705e9.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262143; x=1783866943; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QyVIPTtjvDwClzpwMwcfeN9BG2/EOcSdSHSa/m2GmrU=;
 b=bY1n/loDfNew3S60n061fy793rDAms/BN0kFmnqYEWvsIGWOYonGlrgiDMLQvTvNzV
 lmK/O6K8uXUBLiNxxMfdc9Fjg0lU1L0HsJCCYJ3Jrz/IUoxGoMi4fVdl2eYsqg2S3K/H
 ZwfkOMPTRh5tjQO9YYH1tKMeURpLXvC+/daWgfCkSC/8H9G11jB1r5kzu0mavMIQXssL
 SgFW4PCR45v4xaG951TyCRdT5vgLY7cqCml7+SBVg+b3p3TH5oW85mPayqLC50GqgYqm
 tpYuksDXtT+tO/QF4nTovJ6E/OkwIU72b66zz6Ria1HXv6aluKl9Hfk9Bh2B74YCjtcQ
 7qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262143; x=1783866943;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QyVIPTtjvDwClzpwMwcfeN9BG2/EOcSdSHSa/m2GmrU=;
 b=CTKGt1Ai3X1RDXt3Buz2mEz47eMQKWvZaCn927OERu7K8ObPToidlWHcNeu01/S6Dt
 oK1B64dtamggzWk1Zr++K5JtUq7+8/CuvivbmljgkJYT4JH0EwT7qtZPKyRkb5DLGcP/
 yTa7Q8v9xxBq+J+4Ttzecd0QhLERzmJj8c4NWorJbQ01o6fSo44PSGtQRUrYFI7Na7w0
 7/V0/Ktvf1a7ERG+O2Yb/1PVVxFYaa35drgIAosFECV4XXO82OFwondEoRn19Wvot8of
 uVK05hXmjkYvXjGp25Xbz5QPeaCaefib3KRT5SU1Dw7GrxEDkjDmfWgiovgfDKMs80wk
 swGQ==
X-Gm-Message-State: AOJu0Yw1zD3vCjUTTfd2yecvwNKNZ4LQC9o0KIBSkcCKDe2iiTJsmXRJ
 9qUqsmKh+xQKt+r6vp4y3J2xqn42qlVxK2FmZbB7z1IjOST760Jzs2oXOuL0KFSfZwlOUXfJzcl
 EgjEWwhWrGtXcc+CKIxBcHdCbATT2lXW5vMcI1zpDqIAajl7PLC3QNSzUwiqlT+IHG2/JcLLFp2
 sxQXAQgHLSb0WBpUMKsWaiE6rze8XVk8DDhQ==
X-Gm-Gg: AfdE7cnyTcY0coZEcu8TxaVN8d9q+NMt5w6NfdnEniJZp9/CGoRaxgyPEmrd/DTNTtI
 8a7McVp9t9yY88KKRONTmLQUIu8iIr5VttcDfmd965PF9hS+pHta+9p06DAkJ44FWmMZj4S7+Dc
 GtN11MCl4vLP0MbuZRU0KWwSJk025LmnqbWix5PoJq6m5nXZzK8WVd3qE5ejJdrK2+O2k0bBAJz
 P6krwt4/nkvfXjZFdlrLMJVgcGuKSVoyPus8c680EoASLKdFJatnQG2B7eDkNRgqdSPW2+5furY
 v6ExoS1uunDbfWG0fd+ym1B17puGVzE+j+obgQFBzvPMxBnEnOMAaEQxbMVW5St5TwizjPFNQpI
 IHDYP25wonA9pqYeQvcs/fPXKaUoYAM0u
X-Received: by 2002:a05:600c:c4a5:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-493d11fa9abmr78828685e9.28.1783262142607; 
 Sun, 05 Jul 2026 07:35:42 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a5:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-493d11fa9abmr78828345e9.28.1783262142119; 
 Sun, 05 Jul 2026 07:35:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm283450795e9.2.2026.07.05.07.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:40 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 24/44] vhost-user-base: free virtqueue array during cleanup
Message-ID: <ed963d3967fd8e5ca551c1cc6fcbabaef010d72e.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

vhost-user-base stores the VirtQueue pointers in a GPtrArray, but its
cleanup helper only deletes the VirtQueues and leaves the array itself
allocated.

Free the GPtrArray after deleting the queues and clear the pointer so
cleanup remains safe if the error path reaches it with no queues to
release.

Fixes: 6275989647ef (virtio: split into vhost-user-base and vhost-user-device)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260629092619.2607275-1-zhaoguohan@kylinos.cn>
---
 hw/virtio/vhost-user-base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 39b5e637fc..6ac523f9eb 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -193,9 +193,13 @@ static void do_vhost_user_cleanup(VirtIODevice *vdev, VHostUserBase *vub)
 {
     vhost_user_cleanup(&vub->vhost_user);
 
-    for (int i = 0; i < vub->num_vqs; i++) {
-        VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
-        virtio_delete_queue(vq);
+    if (vub->vqs) {
+        for (int i = 0; i < vub->num_vqs; i++) {
+            VirtQueue *vq = g_ptr_array_index(vub->vqs, i);
+            virtio_delete_queue(vq);
+        }
+        g_ptr_array_free(vub->vqs, true);
+        vub->vqs = NULL;
     }
 
     virtio_cleanup(vdev);
-- 
MST


