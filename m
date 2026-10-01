Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74FACA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsq-0000pb-72; Thu, 01 Oct 2026 09:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGru-0007pk-0O
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrr-0006Lb-Rb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCbAGx8WjlZGv6Bg2nLZNpWSf10g/7d6frsVCktm5Q4=;
 b=HOY3NGGSGaBink9x/vA8mTXlyuBaqvQ70qJcgFiG3AgewoS3ih8v1ng0QDn7Ee451AWOEd
 ZdppWKrY6KU2zvYueesTjk4usUbRDNS/LTdrPVndxYQt+EbIKf+q1y/tAUfQoPkAwpWTkq
 WQKbex3/xpSaWUPm9yzOKtfujwE7FHQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-uwiTTwzPN4SvZWF1NPeyJA-1; Thu,
 01 Oct 2026 09:30:31 -0400
X-MC-Unique: uwiTTwzPN4SvZWF1NPeyJA-1
X-Mimecast-MFC-AGG-ID: uwiTTwzPN4SvZWF1NPeyJA_1790861430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE3B188304E; Thu,  1 Oct 2026 13:30:29 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ECF23000229; Thu,  1 Oct 2026 13:30:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:51 +0400
Subject: [GIT PULL 12/27] hw/usb/dev-smartcard-reader: fix
 RDR_to_PC_Parameters dwLength
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-12-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WWP3k/LX8Esr33UDZLikH9XsKKdMbOQczyz8XhGffzY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIjNXwWHHNHaJFJYbef1OkCCfNTOzemoOEx
 2Lpfv/gmgmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5faeD/9Jx/XSGiam2gnXM7AfTvlW5EQrJDYrudKOVyj3kiouKZcnNBXebLwYJEnrnK1RAFgvoYV
 Uxlk5KOKEPkgRL94dGC6D9+XrdkUCO9KqtosvwIG6igCw0poc6JYgMpC7ly2eT8FsyGpBwyJuwN
 K+YNctuTcoPfQyZbBUwKq9GlDSoDBygQtNxxG/q8W4c53ptUeescDqHfWytQc9pS7acp5RtQO77
 F8hZpsqIzpJ3sLu+HPsa6o8TVhxzm9NY4ZKpBOQJ2vAaHN2XwILO6/Mck1Z0XV5wh0wi+bZL/wK
 Ww0L2ektiaRtnqnC2DESdD2INheCgKzHXQm8IBqaGgKycYLLLS2zK6MVxBrjg1G1FZLBHhizAdQ
 JKnVGdmIH6fS6roOcfGe8l2eOcKO6Atl+mH1MHKB9xVStbDgsVAYH/lpUNQQxfL16ZDF32l/D51
 Qw9PBpujrX5p4IuxoT5LBKRRO89PqP+IuHGwTGQzTVjwArkVP1Z5/Sgz/LNXktPFtOXRT3QaDB5
 HsmDhYvMQL5TB/KVg/dh0XHs7TkA7aozbpPmPjhtQCzbft4rJ25kz+mOcFbNk9wXFgjI6Ok2EJp
 WsGwM2tewP5TilVMZAStKOz76vbxZ2YWBg/+gEBzd01f5zFKhqU/DBgKapOAp+Dmi/7eqO5LQJL
 ezpT2XgvTnREYJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

dwLength in the RDR_to_PC_Parameters response was always set to 0
instead of the protocol-dependent size mandated by the CCID spec
(5 for T=0, 7 for T=1). Since bulk_in->len is what determines how
many bytes the guest actually reads, the reservation size must also
match the wire message size.

Set dwLength from bProtocolNum and compute the reservation size
accordingly, so the guest receives a spec-compliant response.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 279fef03652b..16f248a0969f 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -748,19 +748,20 @@ static void ccid_write_slot_status(USBCCIDState *s, CCID_Header *recv)
 static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 {
     CCID_Parameter *h;
+    uint32_t dwLength = s->bProtocolNum == 1 ? 7 : 5;
 
-    h = ccid_reserve_recv_buf(s, sizeof(CCID_Parameter));
+    h = ccid_reserve_recv_buf(s, sizeof(h->b) + sizeof(h->bProtocolNum) + dwLength);
     if (h == NULL) {
         return;
     }
     h->b.hdr.bMessageType = CCID_MESSAGE_TYPE_RDR_to_PC_Parameters;
-    h->b.hdr.dwLength = 0;
+    h->b.hdr.dwLength = cpu_to_le32(dwLength);
     h->b.hdr.bSlot = recv->bSlot;
     h->b.hdr.bSeq = recv->bSeq;
     h->b.bStatus = ccid_calc_status(s);
     h->b.bError = s->bError;
     h->bProtocolNum = s->bProtocolNum;
-    h->abProtocolDataStructure = s->abProtocolDataStructure;
+    memcpy(&h->abProtocolDataStructure, &s->abProtocolDataStructure, dwLength);
     ccid_reset_error_status(s);
     usb_wakeup(s->bulk, 0);
 }

-- 
2.56.0.rc0.29.g47ce80527c56


