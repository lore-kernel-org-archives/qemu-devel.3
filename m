Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C726F9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrky-0000tD-RW; Thu, 23 Apr 2026 06:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrks-0000sj-VF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFrkr-00053z-H0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776941876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgN/ukMWymzGqahQ+VgRQORedjrDucZiGjhPdE4VcbI=;
 b=RVtMHHMfz1NKoS2Zqpig8bD74eIgCZ/b29eT8wU5Ag125joMVatLd8elZ2+zs57/iA0TR4
 1RCiDBBJl77iF2a+qeaQHZKa2DBo35ch+X0HNbUYemEygtFFespBB9C90cwQIwAqX81cG+
 u8kwkbu7r5l56XbIUpZncAkcBxG7pgE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-OYieTkxaM9eqqfcKSwx58w-1; Thu, 23 Apr 2026 06:57:55 -0400
X-MC-Unique: OYieTkxaM9eqqfcKSwx58w-1
X-Mimecast-MFC-AGG-ID: OYieTkxaM9eqqfcKSwx58w_1776941874
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3595485abbbso8088050a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776941874; x=1777546674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgN/ukMWymzGqahQ+VgRQORedjrDucZiGjhPdE4VcbI=;
 b=Ljr3RTo3mLJWpyUISkhotzej79vINXDhhPUEmsJlvrBQ0fYCD8m7g9hWdE1lTcmxfF
 LWibP9mvhD6ykCBvmt12rP68iDT7qFDpdFTCoiDEKWqgwdFZDyzivpQbvCWZfOK7is1E
 +cqfz32+dU0tBQ5LC0rvwgGRbvkjiJhP9V+G4PfC0fQrz2FaNtiyDh1PYp9dvrSLj0bV
 dIKmEOTPwSWNvEjH6rgDkSPvk2+ztxjcqQcXt+bT9qyxS5IsG97dvPkdmmYPeQe0XSwB
 DHp33zFNLOaWbj+F5vA7gEAhqnAQFSB1OiwEXRa2pYkVCvs/NkrOLbEQQu3iP8Prgz2V
 i7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776941874; x=1777546674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dgN/ukMWymzGqahQ+VgRQORedjrDucZiGjhPdE4VcbI=;
 b=EZx1ISP3jiXna7MZHhAftqf4aqW2781wsGpxLptDcEMC211wai3F9bcbBHOT8uQKL/
 jooIs1PtUAjhcaC2CQYCuWmBBwGtChKTeqOi+AjJmhxehE1n/2z2RJFsKX5UNy0ubiNy
 augo0IrTVaFQ2SjS9ILuDjTu6c+nBO9Wuqk9edmGcF41ipSmrewISstbjOORcECGskW7
 05uNIdHhGXVyN9bO8c8688os3n8EPu31aCu1IPpDIxIr2auqVfEuF8WFl54iJ+Ut3jIU
 KpA0Y1viJTKnMNQPAlZfYUOTAakSfs50sxA1mWcIuS0spKcRHxVGSgXq1gq1J2yDIOYe
 lJXg==
X-Gm-Message-State: AOJu0Yz6x4VyPNDvSv+AjQ45hoIn4wvoGXgrzsdaa0fQlMJ4PqTwCs5B
 vvDrT/N1bEyTTJ9AWDJKAtwZ9qDUdltTXjMyQh+qdCTXeUTOwEfK6XnVzsHi+8hD2k5uFOHWfWD
 JqR7ahb0gxgmumXQSMsb0jf0ckI35RVUdoScoGZRFeh+VMaSDho/S5jDZZzKdNLPxjh9WJuyRyP
 qwHY9vRFdahjZZGfcB80vttABJ1nM6tgdbAM33DRM=
X-Gm-Gg: AeBDietfrqAcOZIhecLtWGyuRrh2v6NxazqgLj16yWSaRYT18UST5/xTPBSHmQu4tCZ
 pSpvOExHgrfz9qTHPRiQtLbIkTlywwAKA39ZEGHaDwEG30q+kaTCiwMXYPG3ZJxoikiOtfGw4xr
 0FbO1umJLX94WW5T+9C/qYwa5d0d2rWZpCE8PDLJQTuuE06DZ5jKVwPIEqj9dLnKTDvCfoTN1xj
 wkFGcdlzrBUo3vIDRZXP3fxa1KqsC3a+Df0gVdGPPf+i9yb1J+3LlOGi7GPr5yFG51vcDfPRBc4
 FPa/PzsZ89Dte6f/CFjFMiMD8uo8JJO4aSNmpq9kuMZx8W3+7a3YmoBefvdbNyGIJ6bd+xBHfnk
 RRNGLOfncRwG6eeeQVAayIKznvhezmlITyia7wZa9XFLWtao/4jI7wK8XM7sA+8DwojTYqHXIYq
 lx3PEnXDK/
X-Received: by 2002:a17:90b:6cd:b0:35d:ac4d:3cb6 with SMTP id
 98e67ed59e1d1-361403b790dmr27124367a91.5.1776941873594; 
 Thu, 23 Apr 2026 03:57:53 -0700 (PDT)
X-Received: by 2002:a17:90b:6cd:b0:35d:ac4d:3cb6 with SMTP id
 98e67ed59e1d1-361403b790dmr27124340a91.5.1776941873036; 
 Thu, 23 Apr 2026 03:57:53 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc575bsm19835240a91.4.2026.04.23.03.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:57:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 2/2] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
Date: Thu, 23 Apr 2026 16:27:33 +0530
Message-ID: <20260423105733.113046-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423105733.113046-1-armenon@redhat.com>
References: <20260423105733.113046-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdagent
to store the outbuf variable.

Signed-off-by: Arun Menon <armenon@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
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


