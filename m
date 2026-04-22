Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB51F9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrV-0006m7-0Z; Wed, 22 Apr 2026 06:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUr2-0006g4-Mj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUr1-0006r9-5v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PEYM9qQ2piMIA+95zgwlQONrThblb9q7SVsakFk7ZAY=;
 b=hCt3BWkwElhq5e6BRykT39PsTx2/BNvML4wRIXMTb4TVK2qCz2yUO9AjNPdQZllOJk2efb
 cDFnIewzZ6qb2RVnETqMGmESTK8yyuEZ+Nn3wCablMxrF98W46Eoso6+KDRZk3tBWGzrO9
 zcSs8qolzoCtsm5fVI4Ho1nHMlUkQrI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-jLp1p0qCPcKWWjzG4vWgtA-1; Wed, 22 Apr 2026 06:30:43 -0400
X-MC-Unique: jLp1p0qCPcKWWjzG4vWgtA-1
X-Mimecast-MFC-AGG-ID: jLp1p0qCPcKWWjzG4vWgtA_1776853842
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c795fa31e18so2587777a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853842; x=1777458642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEYM9qQ2piMIA+95zgwlQONrThblb9q7SVsakFk7ZAY=;
 b=LyDcjiAtd+I/l1mmb8yJK8AAeIfJyJ4JU3fIE/CGKoHAov17FmkafZ5uYjWQkAFB/t
 XRcflJdSQvyenDi3OUO5aOAUYXgkDj7jt3Hk0+9EMVmW0Iykah6685R28fagmJl2L3Fq
 zcMI++5o+nfSH1yLvfxKB+UX1k/hO4kf4+aNKR20Rfx22Y3wxjvpk8fb96COH+qJ3rZc
 iafpUKWqr1D+cxWxRm03EueVeLlMIdcnedxkYZgN1cWushfZBDM/IKW3iV0QHUv4WGD6
 eS+c76Rb4jVjfx/IAnNz+UUxzgiTSXij2SXldUPCnfGiTnDU2swBd2r9+TZlDIcxhK9z
 SDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853842; x=1777458642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PEYM9qQ2piMIA+95zgwlQONrThblb9q7SVsakFk7ZAY=;
 b=k6HHisWQPk9DA5uCOkiiMMQ53Bm3Pz0GRKHISNyY2y0xmOQ4Syg0YAgBe0WYvf+Y3Z
 rVy6zpO/MU/GQwquEp/XhxVLLnoUSF0UZVS4gPfUXeKjrZsY9W/MxUJhBPIxN2jBuQj8
 tY2wqfdIy6YwcSlwE3pfKHIDJU4yuqkYKwie+fFyEeHsq+cmrFa0eRVnCNucnOFgSM1K
 +dSRRRZi4BxtifB4Dt1gRlsiP/KKlWHbRFLEMO4z0pGlELZ5jGnKZHh4MWjttj183m6R
 08nBUReegMfc5wWlaRTl8ZGWLOlLau1wstUOINt5MssFraXjbI28C8556IM6cK2lMlED
 4QjA==
X-Gm-Message-State: AOJu0Yy8TIdNJHTdGn0txTRQJi0c8MDXeLmBL6DKG49Ur3wOUYBjycEa
 oMk7AoTqRMxiWXz3C/I091Ea0jDiv/yWz/hXt4VG4CIaAxmc/q/0aie3nL4H2adWEz/sFRCKYRt
 3scw1WBPGW8Fk677BAFhuyTj8EYr7hw36W4rHVfwgspAhdrpsXtab3lJVk4iYP2rqYGi4703Kfi
 cqAv14Yk4DS7Rsz0ZGTzPaYvTDaFhdN19A3NbxRCw=
X-Gm-Gg: AeBDieuhUEHT+XOMxWpudIqj8aVMYdjJWEMi1G5Cqsc2IHWAxFlIGcJgVM+Gof5cw4o
 p+dBHKFhrKtfnA0frFN2JDHPlrjuq/cigRG9KFGGgC+XLX20sof6Lrwk1CNkxlWgGpjoQsLvYVr
 8wMVPV5eWkhB0uB7LsNW6S1ZOCmv67cdpEERq27xuFsHLGWx6TENDsVRi5PnD6tTI24T/Z5zOEN
 6+ai+/mCGVKWQBKqcKe/k2kdquxSGr5/egKMWVrPjE0M0Lt46q0Ej9r1jUty/B390kgwPRLB3M1
 fAeVQmUzUhZ6eLDcSp4nG8eab+0kUg8vfe9lnSz00HVvZI7rCYZzZlKZjtQ4rsV9WQr1VW5rx+Z
 ApKCpakmBlSTTJXmQ5grG0U0Ld/njEDuPMPoGyGbgQW+k3UbXBYt01zjw+xIBBdkUpwppekXQtA
 ==
X-Received: by 2002:a05:6a20:9187:b0:3a2:dd8a:5087 with SMTP id
 adf61e73a8af0-3a2dd8a5ca7mr9849434637.46.1776853842128; 
 Wed, 22 Apr 2026 03:30:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:9187:b0:3a2:dd8a:5087 with SMTP id
 adf61e73a8af0-3a2dd8a5ca7mr9849370637.46.1776853841586; 
 Wed, 22 Apr 2026 03:30:41 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:41 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 02/10] hw/tpm: Refactor CRB_CTRL_START register access
Date: Wed, 22 Apr 2026 16:00:10 +0530
Message-ID: <20260422103018.123608-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 9555b2c62d..7edfbf8f8a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -147,7 +147,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -196,7 +196,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.53.0


