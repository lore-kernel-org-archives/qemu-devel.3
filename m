Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22822C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDBc-0007Ui-36; Tue, 21 Jul 2026 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmDBa-0007OS-29
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmDBY-0007ZJ-Ez
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784650751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=73qJ/wX2AV358W8VtAs2RZM0ZZNuM2sd0/LpTCR/P9s=;
 b=USPypL1I9Oqrq3hQusC1LsRD+h8VbI9LiBO5N8iRj17NAsN+AbTNGo0TgxTKgG6MyUNeGM
 s8MubzDo0QbcDRzZ/iYe7lqnavb4zAZTK27BgjSccy3ohGT/W3hmJofGflUJ9OA9wPvNBR
 glMyck3uwWgzKsGUOfa80G5Thq9WPj4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-AIQT-Fm2PBy6f169r99PXg-1; Tue, 21 Jul 2026 12:19:10 -0400
X-MC-Unique: AIQT-Fm2PBy6f169r99PXg-1
X-Mimecast-MFC-AGG-ID: AIQT-Fm2PBy6f169r99PXg_1784650749
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-476608a9fefso4889472f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784650749; x=1785255549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=73qJ/wX2AV358W8VtAs2RZM0ZZNuM2sd0/LpTCR/P9s=;
 b=E0TZL665HE9fCHtqKPvln1IkFYOmmgc7mpHCMpJDy5LOFS4MayI8Ybi6wfMAsFnyIp
 RLs0RUXoSQNKEeKU0acql8Wc49r9SoihMB7LE85ZJywxY7+Gbn5F+miNqKOohZNbGKj+
 W84bQAwV6ToOaJuBEypeKlw9kdN6vZ7hkfWzRBjscpIvuSEi+nIPLgvs48iocON8mduN
 o1KVMoOENMWekZEB29t8HSLj0U6OgKiRCI8hCHKCYAN22URK+8y419So2bhxK169Fz1F
 GlBC0YAUlt6eWXlmLtj6nWRZ2YXLnV+f8iB7j38xcBpzO3dpVT4Vy/TeLcl1cqItvrhN
 ZWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784650749; x=1785255549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=73qJ/wX2AV358W8VtAs2RZM0ZZNuM2sd0/LpTCR/P9s=;
 b=ocDoPeJgDjpTi7svS/UxKV0AFVLrHd0Y/+x2IWOJ6z2pQNmbfXGtOp/PPzVvADmNme
 1HLcuXCpnBQoqidVovRhzB6pdI1P9r1T27b/7Mdmz+yqheS9q4x3v9q5AbWOyyT/9sxw
 cJcL4pJuD8R48MMLvsJfyYY4oXaAuGVP86hWnwmzfcDVmBJjHIaGBdTL/kH4MCWw699d
 wjLoOuDCW9EmBnGQPOY2xtcbkdO3EXkP8YLgac7jEAp96kbOGT5HpkhHHPtFmsifu+lC
 8Is8z9TNrH1Zoec7gpwPY0ie1MdKBkv3XzN+V5XZYya8LhNPd8yiDtwxN0QuSAhYPUJi
 9IvA==
X-Gm-Message-State: AOJu0Yzv+AbKdDFO4osFt8UY9sIA8yh+SjtM9GgLPQM1bzQ2u6mh/Nqs
 edjhPAAP0+rJ4yq8RWXnNxRMjxC1Uyqj14lbemlhoXLb4lOOD28est/XXipw/Z8tLQ3sI30oiI4
 zhMhA6C54O/pnj5qm0CKwQDH0s0PNdBVa9QcUh0Lc0lsdWjHC1kcrlM4ak18TksfhlIFk68+BJB
 Y4tfXpk5mdbQi0QtqGtC5lMVwnQZo8rkcqG7WPllun
X-Gm-Gg: AR+sD100lJNPwmB03pJ1NgvDqDScURWW0v1T94bYEfa5fI/hC995r5IZcdY6wWwtiKt
 JrNEtsCTXdNObZLkRxjZk8Rxh5uCTCn7om3E2hB1PJR0zKG9boG4ECBxZfyNNGwFeyu41tNImaA
 Qcj/WFyMGN87MhWXw7w23/X1t9qn19cmvnbJQrBMmuszQuxdygFLj+ssCmDriDeBK6/WFat+GD0
 8cFGRi7riUOPiLgYJ9KiuFING/0q+Q4v7uv13cXXxhnKuIEbxiLrj44Me53XblZbzdj51yOgVje
 k08MERFmDgh6M78YSW9nsyGd4yuOiTR3l4hVbToAAfcDRvhfReghL59PEMOSfdzR9vlwAGrsc4K
 NuQUb86xhyz2v99zN4ObpCKh6/56+p7oUqcLfvdkONKrdnEgEhbqOhXqRrzcAEn51HkBprpkpZ8
 Uf/Q==
X-Received: by 2002:a05:6000:2386:b0:46b:70db:2113 with SMTP id
 ffacd0b85a97d-47f8405f230mr554938f8f.0.1784650749006; 
 Tue, 21 Jul 2026 09:19:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2386:b0:46b:70db:2113 with SMTP id
 ffacd0b85a97d-47f8405f230mr554895f8f.0.1784650748474; 
 Tue, 21 Jul 2026 09:19:08 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e519f4sm38555499f8f.14.2026.07.21.09.19.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:19:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scsi-disk: fix off by one in assertion
Date: Tue, 21 Jul 2026 18:19:07 +0200
Message-ID: <20260721161907.363392-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

When documenting the invariant that mode pages need to fit the smallest
output buffer of all callers (which is SCSI_MAX_MODE_LEN), the expression
used by the assertion was incorrect.

Even though SCSI_MAX_MODE_LEN is indeed 256, using "length < 256" had
two issues: 1) it used the wrong operator, since "length < ..." is more
related to having room for extra data; 2) it missed the extra two bytes
for page number and length.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 85d0bd0b811..1b0cce128c5 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1321,7 +1321,7 @@ static int mode_sense_page(SCSIDiskState *s, int page, uint8_t **p_outbuf,
         return -1;
     }
 
-    assert(length < 256);
+    assert(length + 2 <= SCSI_MAX_MODE_LEN);
     (*p_outbuf)[0] = page;
     (*p_outbuf)[1] = length;
     *p_outbuf += length + 2;
-- 
2.55.0


