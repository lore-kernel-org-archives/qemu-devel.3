Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A2AD70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjoH-0007V8-Gf; Thu, 28 Nov 2024 14:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo8-0007T0-7R
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGjo3-00014j-P5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 14:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732820642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiAuo9+wcwyjELbBvX9cPcyNm6cXW718y3hyCUiqNXA=;
 b=NTWuHkdsF+udxQlxI2C4/kkHvfFCFfpUNKY6ssEIYPdvyi5WxX9J3u8+mv4gKFA58cHkG8
 pB+7PzpBkku9G5WzuLXlmILo9/oP9qPLft4KiOonrm2v/A0ZIaUuLiw/Wx1e7h+jlyjhT8
 fHuAjMfkWxbzDrPRYG2Rnu8LmQ9eKqo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-Kz18RYt5Pu6luq37s5tIaw-1; Thu, 28 Nov 2024 14:04:00 -0500
X-MC-Unique: Kz18RYt5Pu6luq37s5tIaw-1
X-Mimecast-MFC-AGG-ID: Kz18RYt5Pu6luq37s5tIaw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dc37cb3eso87949f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732820638; x=1733425438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiAuo9+wcwyjELbBvX9cPcyNm6cXW718y3hyCUiqNXA=;
 b=CwKh4xtH2vSDx9Zy0+gJrqtaECBiTd0diO/RdF+0xdGNFTQwzVBQukkRaVnxfAHcUF
 NiLixCSewK7kw76gE7DLOl5gfT8TNJkueTnZw+njqlY0yCkYzuPVMi3alg+wHJS5Vlff
 d3r7dV8iwQipFu8xgx/BA+D0ubha11fl2K8AH8W2FfHYOtnaoDG4BVjo7FMUSVPQXIme
 qdEk2zWk+zOCs3+fCLTjIGd5hKj4GZJCCSo8Ikq5DEXFQ32vKZNhEewiOSoEAJpmgsVe
 uVFgVFsOfbjM7htIu94v34U7ajV2cNekEHq3OwTcQzckd3J2tmtzLmGRZy6CFFudNGjO
 WpPQ==
X-Gm-Message-State: AOJu0Yxuwvc/T1wuSoTrcKI8dzh5wuXMFM2Nt5nPZZHSp3wNxbaR/lPj
 coJw095aIWx/QWLyLVm5HSM5OtimodjOf4PBEU3zA+V08uqmeKpv07wvmkzgQX92wtoQYPJnxbG
 Me/6VpKIr1v4j0c0Huf6q4MvFtWKhPTdvvGBKIaOgRrwpT+HJmufAzsktI/a2XjtMfqTwucEdb5
 sdu09a84UZFeGtj29C9YHBBvs/22ItzPNdlge6
X-Gm-Gg: ASbGncvuQKz3Nef0mYKXkPVFH30DAmwi8q0E+T0DjhFwx0igeD+LcYRi1On78aalqb/
 zGrzrijdmtE2p4kV1F4CYaa6bFmMMM+/ZUMV/z+fHvFLDwrWdGryoeqlcsptCPhhM/nzkQ1wwBG
 0z5NydC5FqafaH6VYX0vCNnAYHgA4+dEwONegOehKeJ8U5muL6i5/dX605/tR1zj2SR6Ff4BqdO
 1iYblQT7nxiOA7MQURFsDN4nu3Yir61I8PuudhDN1uwuUwqQnCgPBc=
X-Received: by 2002:a5d:64ac:0:b0:382:4421:811a with SMTP id
 ffacd0b85a97d-385c6ef3978mr6899122f8f.49.1732820638630; 
 Thu, 28 Nov 2024 11:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe4vlitL7OyaXrAhfVGYjuVUBrA3iM7RWhR3APnmitCGqK52qW8/BVP3bMq8qqJWA5j7KZBg==
X-Received: by 2002:a5d:64ac:0:b0:382:4421:811a with SMTP id
 ffacd0b85a97d-385c6ef3978mr6899086f8f.49.1732820638233; 
 Thu, 28 Nov 2024 11:03:58 -0800 (PST)
Received: from [192.168.10.47] ([151.49.236.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3690dsm2316944f8f.35.2024.11.28.11.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:03:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org
Subject: [PULL 3/3] scsi: megasas: Internal cdbs have 16-byte length
Date: Thu, 28 Nov 2024 20:03:49 +0100
Message-ID: <20241128190349.541014-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128190349.541014-1-pbonzini@redhat.com>
References: <20241128190349.541014-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Guenter Roeck <linux@roeck-us.net>

Host drivers do not necessarily set cdb_len in megasas io commands.
With commits 6d1511cea0 ("scsi: Reject commands if the CDB length
exceeds buf_len") and fe9d8927e2 ("scsi: Add buf_len parameter to
scsi_req_new()"), this results in failures to boot Linux from affected
SCSI drives because cdb_len is set to 0 by the host driver.
Set the cdb length to its actual size to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.kernel.org/r/20230228171129.4094709-1-linux@roeck-us.net
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 221b06d6aaf..b33229d71a4 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1781,7 +1781,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
     uint8_t cdb[16];
     int len;
     struct SCSIDevice *sdev = NULL;
-    int target_id, lun_id, cdb_len;
+    int target_id, lun_id;
 
     lba_count = le32_to_cpu(cmd->frame->io.header.data_len);
     lba_start_lo = le32_to_cpu(cmd->frame->io.lba_lo);
@@ -1790,7 +1790,6 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     target_id = cmd->frame->header.target_id;
     lun_id = cmd->frame->header.lun_id;
-    cdb_len = cmd->frame->header.cdb_len;
 
     if (target_id < MFI_MAX_LD && lun_id == 0) {
         sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
@@ -1805,15 +1804,6 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
-    if (cdb_len > 16) {
-        trace_megasas_scsi_invalid_cdb_len(
-            mfi_frame_desc(frame_cmd), 1, target_id, lun_id, cdb_len);
-        megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
-        cmd->frame->header.scsi_status = CHECK_CONDITION;
-        s->event_count++;
-        return MFI_STAT_SCSI_DONE_WITH_ERROR;
-    }
-
     cmd->iov_size = lba_count * sdev->blocksize;
     if (megasas_map_sgl(s, cmd, &cmd->frame->io.sgl)) {
         megasas_write_sense(cmd, SENSE_CODE(TARGET_FAILURE));
@@ -1824,7 +1814,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     megasas_encode_lba(cdb, lba_start, lba_count, is_write);
     cmd->req = scsi_req_new(sdev, cmd->index,
-                            lun_id, cdb, cdb_len, cmd);
+                            lun_id, cdb, sizeof(cdb), cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
             mfi_frame_desc(frame_cmd), target_id, lun_id);
-- 
2.47.0


