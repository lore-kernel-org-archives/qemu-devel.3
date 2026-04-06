Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81153EF4ECA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9iVw-0002cz-Ly; Mon, 06 Apr 2026 07:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVv-0002Yp-9D
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVt-0002MN-Oe
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775476385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xZ4atkg7nPuazSS+BRhIaW+e8ja5lz+OBs+fqAB4WM=;
 b=Ri8x/NGI9Qz5wSWxsoHfZVHm3jXRl1Ffn8NEqoIuGGIhGaGRtRpBfn1tWCKtNqTrpdZpxF
 HgQw/fETBHzAs3Bo5baiO+r86rVN/AZQg0cbZLnT6+lLbPHdFx4EmOZTe+BwA1AEizR2VE
 Pn30pCebmpxaiNH7wYuIsFNoY9pRU34=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-ey_v-KgxNDKp73JAjLdtfQ-1; Mon, 06 Apr 2026 07:53:04 -0400
X-MC-Unique: ey_v-KgxNDKp73JAjLdtfQ-1
X-Mimecast-MFC-AGG-ID: ey_v-KgxNDKp73JAjLdtfQ_1775476383
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c613194caso2406020b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775476383; x=1776081183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xZ4atkg7nPuazSS+BRhIaW+e8ja5lz+OBs+fqAB4WM=;
 b=WMcbI9vO+mJOmpGUrbjg26+v4U38W9FKvb99j4zOkoA+xmBDrD4ruHnCfEYfVw7kL4
 BixHumWuNzMgeiOxxSend1DNkkIdW/iu0Ep6BjLx+JOSnGknpwzx3HBXFdFuIkfFkbUR
 N8Hk5JGAU435axoHTbduGiDPWGAu73cqIO6V8wkU2CWDZPcro8VVP0qP7/HHA8JNs784
 Na96zv/tjp5NgKwoMnY2195Z2oLZPCXyG2iJHejLvpHTWPPVbrjVblLDk6Ku/YCGM6rJ
 3AAbkh/ZEshH7RonclUw4k/A6E+6cIq65l4ly4ZLffsns8AMvDwvk9adYyZPx0fbb3mP
 85SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775476383; x=1776081183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4xZ4atkg7nPuazSS+BRhIaW+e8ja5lz+OBs+fqAB4WM=;
 b=UeWHOF7FQl+kaf/KXcZ6jrjGGfxR+kBjmvtgk4wbGIMlHtxZfG+7l+M7OMlvRBA+st
 q82f4CcalaecQMuYSPCT6/QBpnDLleFh6NYEUE3e+qVCcZ0fGReoUKiFp2xnmkHlEGaW
 IItJVyJyRUarKvTqJFpmYAEBUPZY+DbsrCMKVDEdih3U/KzdFpt4kcoXdXhX0mhMtOJf
 AIzjXEhvsZfumnNvbHTiRrFGlEWv8k53CfToji3GYCIVxwBHHikRwogb3aYmSeYDuSi7
 LsDbBhyEoNj/uhapY6JSUYeF60REb1ITay9BfJaU9gAeEb3oZIof9SFHfghG9ObcQga6
 ANfQ==
X-Gm-Message-State: AOJu0YzNACweYkkcLYv8lVEs2+8PbsZSbJM9cG2KMABEaJ2IHl+WSIgh
 iL7rudNRtsQLvaX0ErnQ3/xv91KdrpRXs2MGjT/GUmmAtc84imvbto2yHoPZhi0srsHdA0yjZZi
 Hbp3wWmIrhrM06RS2PJKPhz4B33oFsc5lS99d1LZnfUyVFBlbGXddX+y6zYicqzigc4EPPJtbkQ
 i7aA9MRAUyhSCEGqqlq9dMqsHS6bPNgEXqcN2KB8s=
X-Gm-Gg: AeBDietJAJCd8zYql3L4WP9kBJyGSk9z2Il07To/Hqu5uvmwQR1SMzxvxk4On5Cf0Zu
 srcihRVm0Z0b0RvPdU+wQGzOBk0pW7DF8LqRdeKONIrtth61gahlHtI34+mZfHhNApvoUUBZt9q
 16Xf/ENuhuSWQDpUTDU7TpFyuwsHJ75xd7TuDcK70jFFB3RDT6BZxSdqdszccXYDLvJFS8Xr5wf
 RpOyr3B4FCm/J4Wd8mxO0cLcZB3ThcHKd5KFvlRO2DiRFLOe5wmmbcj+a0StjbUhSoxqE0NTI1b
 1uEh0ryUBmXfkn6ZJRiP4d1pOsl/ge0mg4fMV1v6pBpyQz++ntB47Z5L7nh3p+0pRQyOBdIxQik
 G+fuDZgCPlT5UXZrlTRvQpb24Y/GcKoyLBDz3LonZMnMNJatXRrbPhmDFe8TB9PDMnEmS
X-Received: by 2002:a05:6a00:4fc6:b0:82c:daa4:ce29 with SMTP id
 d2e1a72fcca58-82d0dbc51d3mr12286171b3a.47.1775476382608; 
 Mon, 06 Apr 2026 04:53:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc6:b0:82c:daa4:ce29 with SMTP id
 d2e1a72fcca58-82d0dbc51d3mr12286135b3a.47.1775476381972; 
 Mon, 06 Apr 2026 04:53:01 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d12218738sm11547849b3a.21.2026.04.06.04.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 04:53:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
Date: Mon,  6 Apr 2026 17:22:47 +0530
Message-ID: <20260406115247.4879-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406115247.4879-1-armenon@redhat.com>
References: <20260406115247.4879-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Arun Menon <armenon@redhat.com>

Migrating a GLib GByteArray is now possible directly using the newly
introduced VMSTATE_GBYTEARRAY. It uses the standard GLib API calls to
create the array, or resize it.

This is safer than implementing a C struct and manually updating the
data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdaagent
to store the outbuf variable.

Signed-off-by: Arun Menon <armenon@redhat.com>
Fix-Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vdagent.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb0c4aa14c..9206e47000 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -967,17 +967,6 @@ static const VMStateDescription vmstate_chunk = {
     }
 };
 
-static const VMStateDescription vmstate_vdba = {
-    .name = "vdagent/bytearray",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(len, GByteArray),
-        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 struct CBInfoArray {
     uint32_t n;
     QemuClipboardInfo cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
@@ -1067,7 +1056,7 @@ static const VMStateDescription vmstate_vdagent = {
         VMSTATE_UINT32(xsize, VDAgentChardev),
         VMSTATE_UINT32(xoff, VDAgentChardev),
         VMSTATE_VBUFFER_ALLOC_UINT32(xbuf, VDAgentChardev, 0, 0, xsize),
-        VMSTATE_STRUCT_POINTER(outbuf, VDAgentChardev, vmstate_vdba, GByteArray),
+        VMSTATE_GBYTEARRAY(outbuf, VDAgentChardev, 0),
         VMSTATE_UINT32(mouse_x, VDAgentChardev),
         VMSTATE_UINT32(mouse_y, VDAgentChardev),
         VMSTATE_UINT32(mouse_btn, VDAgentChardev),
-- 
2.53.0


