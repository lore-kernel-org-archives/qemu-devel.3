Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136EDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJQH-0001nY-7Y; Sun, 04 Oct 2026 06:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ4-0000Wg-J2
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJQ3-0003OO-2w
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHDmjCgbfQArhlEtEuXHeNkZ/ZvkHnFYbiMtXRFba9g=;
 b=BIitXF8OjtsJ8+SlS3HQlwTIgs6S2sik3Oqtks/x1IVbxxr6sMtZJTq0BZmHL846U0cwl/
 Aolascc4/H5HzoYwdRlzXgZISbatbW7gTg7dZjV54RSoYFeFSPOHuubf/Vjafjr3SxtKho
 v403Xg8Ml4Nvdlb1VgOYxynClsfqK4A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-Vwyy02chOc6BtGnFPQNHJw-1; Sun,
 04 Oct 2026 06:26:09 -0400
X-MC-Unique: Vwyy02chOc6BtGnFPQNHJw-1
X-Mimecast-MFC-AGG-ID: Vwyy02chOc6BtGnFPQNHJw_1791109568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CDDE1954B01; Sun,  4 Oct 2026 10:26:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D94EF1800345; Sun,  4 Oct 2026 10:26:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:56 +0400
Subject: [PATCH 42/63] hw/char/virtio-serial-bus: validate scatter-gather
 state in post_load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-42-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2IGecb6hvvP/19/o1LurCVTdvHIR26KitHXZyHYrMVo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikkDrEh/6U9L7kM6RiJBFnODG7n99xUX4H2T
 RqdfViwJsOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpJAAKCRDa6OEJdZac
 5WnYD/9Pnxop/UCf8x4LgHAL72LOvEKipDROOS1GknWsjoZ3FBh1rpETH7+68zGchrx+uJSHzre
 va4ZS1dv20wx/iGzDRepk8P7u5Al6eWFo1B4IGwtDaA0IcVP+Hc/4bRT8BhyeNoWRwhDEp215zx
 QInNit0A374LqQvMUoujPM53qM6fQ747Ol8N5EQTqQ8//5ntQnRDsioZIrq0dwLiisPfjiboQN6
 AZbz5+Ij00FTPQ3cBeUqvQYyQ91uSitiYES/Vpox8M1HoC00UHK8MdSFQmmB1Bj7tyqSSdEC+13
 XDdnr8pgRa85B2jyYCew9wjbuwIWQI26f7cIM+wvjktga5qpD0XPJ/HekapQQu2Qpyy91GKC8XH
 UiDB5ZloFBWX5+sE/faueZoqiYuPx8OK8HGOtT+CFYC9Fy5WZfijuqorJi19Ba/jGiFnsGcGJU6
 iJaGhi1+GunT2ZsG83yPzo+43HlY7XiEbeXilzBflt34iJ1E7YQFVxcJPL0rUhDZU5gt9yJ3KfT
 ykM/x4llsLJEkDLX3643ce11jMDPYhu9tpDQhdT6JgDNR4KBvz1rj3r89gMyNo/GF9dT/AVgh3s
 HUB9zyNYNF92RWZPuuR30+FZNPdfVqgiuy8LafUjRi/Fhwn+qQUpH7QVCpYfacyOk77FtZAxe0e
 6fCvZPNGu30XwEQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

After restoring a VirtQueueElement during migration, validate that
iov_idx and iov_offset are within the bounds of the element's
scatter-gather list. A corrupted migration stream could cause
out-of-bounds access when the port is later unthrottled.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/char/virtio-serial-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c36e18a4cfb5..8b9d5f32dea6 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -768,6 +768,12 @@ static int fetch_active_ports_list(QEMUFile *f,
                 error_report("Failed to restore virtio-serial element");
                 return -EINVAL;
             }
+            if (port->iov_idx >= port->elem->out_num ||
+                port->iov_offset > port->elem->out_sg[port->iov_idx].iov_len) {
+                error_report("Invalid iov indexes");
+                g_clear_pointer(&port->elem, g_free);
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's

-- 
2.56.0.rc0.29.g47ce80527c56


