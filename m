Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D0ED7B87
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZ9v-0007aO-1z; Tue, 14 Apr 2026 04:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9t-0007Za-QY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9s-0003yW-1y
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8b4xtkIhhKFmSZ8qyvLhxx+v9owHMfnrKqDv6T+JeSY=;
 b=Tsh8YWOX+dlPmcwLIqtlRA//6uxqoTSM09V34l4ntIGzm0nzG9Bf1YE+gfli7FQUaGzfFL
 BtMnskgxs5KBpjDsOKE0+Tmrsqw0E2i6mQB8S7t1WWoy+EVMMoUdFvyGxHBqLKxslNISI7
 qj5jR00hO1Dvsiw6o6X7r/sLN3hYrvQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-LKiWTZFUMqKa881Uj6gn4Q-1; Tue, 14 Apr 2026 04:29:50 -0400
X-MC-Unique: LKiWTZFUMqKa881Uj6gn4Q-1
X-Mimecast-MFC-AGG-ID: LKiWTZFUMqKa881Uj6gn4Q_1776155389
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso48062265ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155389; x=1776760189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b4xtkIhhKFmSZ8qyvLhxx+v9owHMfnrKqDv6T+JeSY=;
 b=Q2brY/xVZSe3eGIHtrCZhIy/H2lCOlT5LW8q2fbnSD9Pte7h+rmuoD44qaBzTaC9O/
 cHmSutOfHJmblnOSDiX7dVy9beiuQ3NII3TGn5pjT0/Fdq4ppjI4WFWZJLC90wBcbwVk
 furroyIBxDkVs5lB+8GLxnLRuJUtq3oX+9ul0sZeh4KwZDBXjtOrTcUPtbWEta11KTXI
 4ZNj0BUBtmUwxU7Mq0wRvaf5g/tlSzd4iMmRmLrM/bWd33e4kxiehqmqn09u12bApXqE
 hmTZ1ZMIfNDTlxWBDpf3NYXxO5iceG6Qm3qjVpMvkJJAQiPqanhMcn+x3nCjpx7OJcS1
 5Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155389; x=1776760189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8b4xtkIhhKFmSZ8qyvLhxx+v9owHMfnrKqDv6T+JeSY=;
 b=Cv9XhguNJ2/oSnstqWsdhV0xNdQyQH5wYVKmsSGf22KWgxbluUTwclJwnbONCKxijL
 hUxIAxOsiKs+axIgsD9aSgQDqN2KyrsRB7YQeNsC7iZq6/zNYyisoCuF7rTruFwzshn8
 JbHZ2LwA5zyZSYdGN6lvpVYBjoQ41Hb32Zb+suM5zoZuEZYlOIctTNJbtCZ3rAqFeMcA
 HZ7k18DoVL8AiUlRM3LBmFEeB36A0UF634+k8vZLcikCfMcLuuAw3upWdhh9GTr7SXso
 JRBiNh0qs9c7Sbbcc9LDErdWlkicQvmf+nkdSXPOF9v7MyTlaK4Q8YGyU2OT7xMVwUBo
 2wwQ==
X-Gm-Message-State: AOJu0Yxv0lQzvTkyf8yuHxKnY8Gh2PJMsdQvZUas9NCuRgVUk4FRysQq
 tQJs658gy7BjWfXD3RMpEt+wTKZs9wbmyg6R9ITLJcDBCDg11TW3LJH6jEHfLZAyjZaGoPlNL4S
 Xty8GfPBt+zmvYccekT/7ptFu1A9jnjgCgRPYGfK4+xIfWv02T/TtfPxh5b/SD9/ko2YScmX0sF
 0NHgLKyxkG1yZ7J/vy+mHNUnhQNN4ti2T46+sm96k=
X-Gm-Gg: AeBDietzcrzOtit8Po3d1Rc2S81jvXPi73opgoEcbip45I4ZHLpIKVuBl2yNrqny6N3
 5ZVEbYUQicRU2gk18nL/Wi9j0Ar5NngnD5KsJGRjb8wIuYej4ck9+UMfrBeB2y/yMOHHnA3UXtp
 tr8w1ZRI0O4nXmElec6vTsPo2pWsA2VCRE3puYkQ+xOKuMVVonxzeKnNDMDVS+i0pY1SybPV+5h
 ox3oCajf65I7PPdxxYoBSYHwjOev+ey9pxQx32buCSAM4UBiPy4GzVzL3bCSIfOUuA1IVlLG/Oi
 /QEEKUxAsWg9IML4gpIW70lLdVsjRV17cschm/HJ2U/bZQ8XjSvIcyGdwh86HaERctpxXEfNChf
 fs3jxBwGPctDDBEnnFtShpO9dvtlusXkMMMZIUQ8p8DhOYgYKPhz0QqdY8DNoidg=
X-Received: by 2002:a17:902:be03:b0:2b2:71b4:a3cf with SMTP id
 d9443c01a7336-2b2d59d398emr130703135ad.19.1776155389072; 
 Tue, 14 Apr 2026 01:29:49 -0700 (PDT)
X-Received: by 2002:a17:902:be03:b0:2b2:71b4:a3cf with SMTP id
 d9443c01a7336-2b2d59d398emr130702705ad.19.1776155388490; 
 Tue, 14 Apr 2026 01:29:48 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:29:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 01/10] hw/tpm: Add TPM CRB chunking fields
Date: Tue, 14 Apr 2026 13:59:06 +0530
Message-ID: <20260414082915.112122-2-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

- Add new fields to the CRB Interface Identifier and the CRB
  Control Start registers.
- CRB_CTRL_START now has 2 new settings, that can be toggled using the
  nextChunk and crbRspRetry bits.
- CapCRBChunk bit (10) was Reserved1 previously. The field is reused in
  this revision of the specification.
- Refer to section 6.4.2.2 of [1]

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c      | 3 +++
 include/hw/acpi/tpm.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f93..0a1c7ecdc6 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -59,6 +59,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
 #define CRB_INTF_CAP_CRB_SUPPORTED 0b1
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
+#define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
 
@@ -262,6 +263,8 @@ static void tpm_crb_reset(void *dev)
                      CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c5..6eece21397 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -149,7 +149,7 @@ REG32(CRB_INTF_ID, 0x30)
   FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
   FIELD(CRB_INTF_ID, CapLocality, 8, 1)
   FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
-  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
+  FIELD(CRB_INTF_ID, CapCRBChunk, 10, 1)
   FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
   FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
   FIELD(CRB_INTF_ID, CapCRB, 14, 1)
@@ -168,6 +168,9 @@ REG32(CRB_CTRL_STS, 0x44)
   FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
 REG32(CRB_CTRL_CANCEL, 0x48)
 REG32(CRB_CTRL_START, 0x4C)
+  FIELD(CRB_CTRL_START, Start, 0, 1)
+  FIELD(CRB_CTRL_START, crbRspRetry, 1, 1)
+  FIELD(CRB_CTRL_START, nextChunk, 2, 1)
 REG32(CRB_INT_ENABLED, 0x50)
 REG32(CRB_INT_STS, 0x54)
 REG32(CRB_CTRL_CMD_SIZE, 0x58)
-- 
2.53.0


