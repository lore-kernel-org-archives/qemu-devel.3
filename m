Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6150ED7B87
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZ9z-0007dd-Ni; Tue, 14 Apr 2026 04:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9y-0007cy-Et
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZ9w-0003ys-Si
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTAqWnAdiH3HJati0mXuI/rgGigN90zxb/bv+x0XDUw=;
 b=HfX8Zfuh4exGqs8HVcN6NDBS6qnNEdlvezIgXG87tSi64lrrukkcbIVI2gTdX+RWOt+5z6
 LmdBfILfhxn9tiCe/xYiXR3XG/OD4iCvjcbRB8Gye4uu4FEcN43x1CnV0Zjysj7O0AUdx0
 MObFDuYNP8ZgBBwBUNiBQR1PkDvqdVU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-nuQv22ExMtKixMwh7636vA-1; Tue, 14 Apr 2026 04:30:05 -0400
X-MC-Unique: nuQv22ExMtKixMwh7636vA-1
X-Mimecast-MFC-AGG-ID: nuQv22ExMtKixMwh7636vA_1776155404
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e6ee9444so26853955ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155404; x=1776760204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTAqWnAdiH3HJati0mXuI/rgGigN90zxb/bv+x0XDUw=;
 b=R6QxZsMbfjiofFHkjZ9RCejf7YcrT2yGhMFjYgYilqJs2STOfbCSg/JctEeMw2tR9h
 NGlg+6gLXIkGOFwgzkL4oAP3YafnuMkxtrjip6H/D95XryN2UsdjZfjnwH3x4xHhYl4r
 C+yXksYC9q4ulaC6aRHTe9JCXbwaajkHZ6TGsQCSTjW1LcLbqG4n6+0j5xYScPaZtJOR
 d71nBvuWoyx+K6FPdRDS/PkZwoGdxyzkV/KiGSRdTp2KjmDE/RoSkBnmrYnZ0nPiszkR
 g3MSmV/ddaexbSipicz9lIeLnBPNDHMkNigWqW9nQgVYhN1ARQEkWGFUJCj10d4BTp6T
 gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155404; x=1776760204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jTAqWnAdiH3HJati0mXuI/rgGigN90zxb/bv+x0XDUw=;
 b=a9ol1bjUGFWUySL0v4FWLcxZ2wu/qBcpiD5onytC662u3XLgZ18ICbktKLkDng4gxi
 W9uJFnVY8sfM8/+Kr6EabdI85cNgKLTQBaqEoZEOIO6SBdz+KPBj/RP7Lf5CY8vJgzPh
 wPdEnMXoXb4/qyvpjsWpGMtoo5nd3Op5tFpZOtp4BEuVwb87CYh470WphMM86/+AayTI
 h089f78KyKtqeOJxz2HtwJc/HRh1DPN+u5WfAFDg2eQCcUuHkbHJpV2vzqjyqXhl1xgo
 MbjpYvO3z6X3ww993ZpdsJwf4fpRxii2H0rXfYujr9FhGAX4tcb/f4yOib8zl1+PoGzD
 fY/Q==
X-Gm-Message-State: AOJu0YxnF44hY4Qg0EGB+jmlBW6AkPN4QcuUmoBZ2Jf0DmKh/wwatCdU
 vC1s5XarYn2INVu9NlVtztmNd5aJwtHb/+fnnHz6cMp+Tg5WwD5WGmOfKOR50l0532Oy/ekBXqv
 C1iWkgN5tbD831zfU+au68GtHnR/8QfBUxC45fSjl8IdlnugbZUGAawO5bkJU8FXS/qymm+k3OI
 XtEKVPoQZR/aIoac/wKZZC1g87lBKueuZazq0ob/c=
X-Gm-Gg: AeBDieu7l5JnuoDDJiw5J25pHZcq8KBhTe4msVEHp/1M5oIeWZ8+08ep/5UPoeTPQWD
 Ab0I/Py9GFs9sNZgHLo90sQ6ETBW219Ix2f65hJhF6yuueSX36do+oQxSDuxy05pNGrPQlqwvU1
 jcmhxNsUSx5sTkrUkS22JLncQLIZUyVh6F17P07Scveu0SPtH3PBlytqhymtO2Wfl6/nWa5/n5V
 VvGr44dI/LM1foAZ3RMyb/l76B0OFahl/a/kqU9Zuv5I/SDMSZ825l3sdaeejeW9V1FuYfB5N08
 vYLS5Bs4HYrgulbx4iJuMfUnezKm1r23xiKZKPfwhbR5C8t8iM/91wJVKYdTYqHvyxfyuFjOPHT
 KM30auw4AsO/VYQJGiUzcEqy2TLbMwM9uJoEDUmQbRYb8b1n0/wSBYcTrpe9FKGY=
X-Received: by 2002:a17:902:ce09:b0:2b4:6529:7b9e with SMTP id
 d9443c01a7336-2b465297fc7mr46253795ad.12.1776155403808; 
 Tue, 14 Apr 2026 01:30:03 -0700 (PDT)
X-Received: by 2002:a17:902:ce09:b0:2b4:6529:7b9e with SMTP id
 d9443c01a7336-2b465297fc7mr46253245ad.12.1776155403282; 
 Tue, 14 Apr 2026 01:30:03 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:30:03 -0700 (PDT)
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
Subject: [PATCH v4 02/10] hw/tpm: Refactor CRB_CTRL_START register access
Date: Tue, 14 Apr 2026 13:59:07 +0530
Message-ID: <20260414082915.112122-3-armenon@redhat.com>
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

Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
No functional changes.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 0a1c7ecdc6..8e6ec44711 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.53.0


