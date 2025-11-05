Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB12CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiuv-0003Vd-T7; Wed, 05 Nov 2025 14:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGiuu-0003Tx-Jo
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:11:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGius-0006Zd-H1
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762369892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qsYU4Gw/ezc9iVquBadYorstNJZqdzAxMM5vBETHEA0=;
 b=aBnH47MR0wFJLg/+6DFYIaKbK8SxwnEwFzvIgR7coLyLQN2BQ8lZB9VqYIaNcDwKGi2hZ+
 KOIOesD7mCJlvl7/JWpIZiZQB3EOJ+f6LZbPixJlh+MPk7kPfLfvq7oYpHhNBxWPnDJtSG
 XOUznVeV6VVxavAbQEC27HV68oS/14M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-JHfA1ZI_OwmIPiFlBXjf8A-1; Wed, 05 Nov 2025 14:11:31 -0500
X-MC-Unique: JHfA1ZI_OwmIPiFlBXjf8A-1
X-Mimecast-MFC-AGG-ID: JHfA1ZI_OwmIPiFlBXjf8A_1762369890
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-89ee646359cso47340785a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 11:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762369889; x=1762974689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qsYU4Gw/ezc9iVquBadYorstNJZqdzAxMM5vBETHEA0=;
 b=GK8i5MHUbelEwytU4zQGLdpNRNZNu6dIhOMl6uccHz7ppB/5Nqo8jfAc66NWkHKazC
 n/hrKi09GxfSI9InkNI6s/e/rRCGQ/41fZak85Ocn4WYmEZkI/bs54pUwI/y2T18isEY
 YzdhuyRWwY29igCxV9/aRx7O6PLn6CCC2utyL/oX5o1rrWWCHMGVY80r/9yMQrlOZMPy
 yVycX1nmTjUGdjx657UbpAy/wLI8Cbos72ehegTPjSLo0d5+5xYBnFPamzXeIlmmKz+y
 lExSpSB9Rh35l8JodU1R059LkWrtfIocT69saeM0v4IO6A+PpT7fLg/NRvk+64vK8wDC
 Hbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762369889; x=1762974689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsYU4Gw/ezc9iVquBadYorstNJZqdzAxMM5vBETHEA0=;
 b=xNRjbC/cEyWIu6482VDN5cHwqCiQEewZ5wXQVA8y970001wMtqvzNVzc93ksYo+x39
 SHCufUDqpRVpbvepAC+WbluICQoMWE7W3CMbs8LCYq2UnTLQct71CJLHQV7CH0tYww0Q
 bwxz0wls6+sqMxqSJTh5Z3LbWvR+ZmajNmtGvTLzzllTzNaQiPDBDmvMqCbVDMbUd6vc
 awh0ctCLAcWKTnXQTnffmFPF4bVeUugHyZgXUp95G8JEFLulB1cwMltZa7W0eMg6t/LD
 CzZyDDKZZ1IGsF6v17pIfJo7+Bzh64ha1nQqYt4f+Qwq0+7Y0w1uLPwktKY5OQrGbBrC
 Vhvg==
X-Gm-Message-State: AOJu0YyUsmbacF2Ad3z2kxfc2QC3U/km8SnpB7JlMunpt5RyEiwu7IQg
 SrDpVftt2fJ3RMAnQ7x/liNDTU8OtqIEwU9fZr4HeemK6yD2lIMbpJk2d/uYIZQeH5xmCN2vY+B
 z92vx/IJDK+gfYb5CY+/N2qOV1U8pqDEyquVcqVvAN9D+XqQutlsMPLz67leXAlu41NP+9+yZMG
 SQVTFHap3RYBUmbjSqHtfd06lwzLp7N9tgJUZpjA==
X-Gm-Gg: ASbGncsS8fmbugrfF9e1dl99TNtMFkbeC/D+i9p4U2smeLyGkzviSmUT1jmwLcXb40F
 DJ4WNmWAayhWtkj70BNkhTw69mpz/n9Nh6wq4M8c4ytrb1W6LrAFphDn000BxfLEuzjdQ0qHTXa
 JtCdKfqtZFkGdNgIe09aCAzcKtYrJq4GrFOjXbvMr7wb+NZCV1fMZN3/Ccxab4c8t+/Mtr2KvLA
 1a7kkL916YPCsEbK9CgFbu6g49nxGgILia2ksCI8KL1LNSDniHaD2laWLEQ7x3GZELOUT1pJlBP
 68sqQXPtaipGVz+2GI6cSYuUqz8OGhio3GCX/wk1UhUVAt2crhqgROVjQTJ9BZ1v
X-Received: by 2002:a05:620a:31a8:b0:891:adc4:f9a1 with SMTP id
 af79cd13be357-8b220abeea2mr527744685a.55.1762369889409; 
 Wed, 05 Nov 2025 11:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEACFvxBoIdlvZwH1FfwNhEkXSyIU09BPqfthC4lH4YuRjyGgTCtX8KTncoOvWwnJSNFfBksA==
X-Received: by 2002:a05:620a:31a8:b0:891:adc4:f9a1 with SMTP id
 af79cd13be357-8b220abeea2mr527738985a.55.1762369888836; 
 Wed, 05 Nov 2025 11:11:28 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b23580a00fsm22669785a.43.2025.11.05.11.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:11:27 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] machine: Provide a description for aux-ram-share property
Date: Wed,  5 Nov 2025 14:11:20 -0500
Message-ID: <20251105191120.3820787-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It was forgotten when being introduced in commit 91792807d1 ("machine:
aux-ram-share option").

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0580550e12..8dd8ce4cac 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1200,6 +1200,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "aux-ram-share",
                                    machine_get_aux_ram_share,
                                    machine_set_aux_ram_share);
+    object_class_property_set_description(oc, "aux-ram-share",
+        "Use anonymous shared memory for auxilliary guest RAMs");
 #endif
 
     object_class_property_add_bool(oc, "usb",
-- 
2.50.1


