Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C12EFCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPI-0004kz-SB; Mon, 09 Mar 2026 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP7-0004ff-Mk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP2-0007kf-VA
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsMTrpzimSV7ykM9K2H9v+kajidUb0NZsCJPw9IEnVQ=;
 b=EIzoWBpg9YLnnQzgrEy2+2h7I7KZGVYhdheI/OA/+P1S3Flr3fV6Ir34OBbzLr2luBYfgG
 SPr9qzIsneVVP3sYcVTCztqrYA9tNrusugvVq8OwI4PgalwaPnkpyUJxChg5QhSLK+epuS
 4OKffxLFAmEMA+T1joN7Z+Sxx9jJYdg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-1guHJnQVPvWeAgKP_911Zw-1; Mon, 09 Mar 2026 16:40:34 -0400
X-MC-Unique: 1guHJnQVPvWeAgKP_911Zw-1
X-Mimecast-MFC-AGG-ID: 1guHJnQVPvWeAgKP_911Zw_1773088834
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50917996cfaso115180721cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088834; x=1773693634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsMTrpzimSV7ykM9K2H9v+kajidUb0NZsCJPw9IEnVQ=;
 b=bBxb+cPm4iD2u8Zfxh/fTYOGCm8dnADXLBSqVvjnoVoUbRqFl86uK3fhpxodEnanqU
 D1/hbm2NwjCozTcci8vIIt4eUe3abjnGUQ5OvfhUlswCywERDs4VVWw0yznJQTeqBHTV
 GtnKqxpxVasO7VChoL0JzfhxUB4wfzItTdauCn4YseM3jCSs4IEULgQO5+D8/Lw+WSRP
 zy6Uca7IsYBJpo/WSBcD/bEayhApAZpSix5vcAiVfDD7Wfh/4TtkVyG4LRZXZcicmHtO
 5R10JfAb3yMwOsLCWdf14xPhg2d1eSOkEGCCQ6COc362L+khapTLNS7mVxlG8MzG6UWD
 IHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088834; x=1773693634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lsMTrpzimSV7ykM9K2H9v+kajidUb0NZsCJPw9IEnVQ=;
 b=RpkSLbWwNss0GVMe/b6Onk3XfvRuxcmmPjI6pD4OU1+AuQjG8hqWgTFm95i+ThdARd
 JxkcxvBgjgrrJZg0BoNmpenrrawUjKsTOX+d2Zs7tQ3+o4Oy7+7kqJR/9DYOA5CKOoPt
 tQczazHS5A6pkUDD9TC88OvLC2bhkjZbYAcEPHtysaeqBzbkxeuA3vV2tpJyNVbhZ3zv
 BNwGcliHyjxPtzbvfLEqyL6sGCSwtGiFeR/ZkjxIHYAKg3thbzIlH0hRJejfmlfveHG9
 bh2xTnZHxobCeWmp/gi5A4fCmptAmWImSNT5Lx6Pfjt555eUlSeyoQuzH8PVuCWNwoUC
 /13g==
X-Gm-Message-State: AOJu0YwnoEQSaYql18ru0yFpr+R4qxXufgXyyyx+Is1zoyO1qMVcAIuV
 HNkrlJ6W28aFSw1ElPVG3c4Gm9dzNyf0Nx3TNdJ8KN6klXsSN4zOO2U0sWPdRhYYXKrLXeuvYUY
 DP0nFHW/qY0THd4UTCLnLf2YAg5p8AkKc8p7oUKhY6XFMPXf1Mv/HCinsdgnXCcEeRqSenzpbQw
 ou1uV3gOUw8/e9lpOQ5BW11Aqes4xP1GTagFFkTw==
X-Gm-Gg: ATEYQzySNkd0Ad1yxQ6L8VdTuOze6to+x80hgDbU8UDc5sfE94COQgl7ZMpc3uuEgIe
 8m0kIAbCKlYxDYZJisKikSxCQQByLzD0QqUnlYVGNvBNjVnbxN2rYtARDW11G1ynNSERQOq7gRi
 D1Ac/Tl1PX3H/OpZRaKmLYtst7EkBYG7g7VRxLNiSdvXd4uj7tONNxRCiogVkWIT9aMyQwI/E0y
 e6jJ/ZkfPX6PsBK0379X1PoCL42xIu8QSDPllXFOdYXlIbI9NDToLHswEXZWJN29VUwFJhKM//V
 3CzLh4UeFnHXJ4zkexL65BB8q/3GCqV72PQkjQs/2ssSRiA3GLQPBD6ZkbbzG5dC9Lr5AeJ1ti+
 aIQtmkL8RdIEFFPp4KNpb7vSMHzUvDDCVY2fr5HgqxWklTSxpZVIqhZGKZa3fEX9tMQGAhgANzZ
 dx+uasNg==
X-Received: by 2002:a05:620a:31a8:b0:8cd:93b7:ec10 with SMTP id
 af79cd13be357-8cd93b81d00mr135511585a.64.1773088833753; 
 Mon, 09 Mar 2026 13:40:33 -0700 (PDT)
X-Received: by 2002:a05:620a:31a8:b0:8cd:93b7:ec10 with SMTP id
 af79cd13be357-8cd93b81d00mr135508585a.64.1773088833164; 
 Mon, 09 Mar 2026 13:40:33 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PULL 12/18] virtio-mem: use warn_report_err_once()
Date: Mon,  9 Mar 2026 16:40:01 -0400
Message-ID: <20260309204007.1709441-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Link: https://lore.kernel.org/r/20260226140001.3622334-4-marcandre.lureau@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/virtio-mem.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 251d1d50aa..a4b71974a1 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -594,18 +594,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         Error *local_err = NULL;
 
         if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
-            static bool warned;
-
-            /*
-             * Warn only once, we don't want to fill the log with these
-             * warnings.
-             */
-            if (!warned) {
-                warn_report_err(local_err);
-                warned = true;
-            } else {
-                error_free(local_err);
-            }
+            warn_report_err_once(local_err);
             ret = -EBUSY;
         }
     }
-- 
2.50.1


