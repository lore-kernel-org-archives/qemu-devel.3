Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B826BCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9S-0004vQ-WA; Wed, 06 May 2026 03:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9R-0004ud-M3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9Q-0000cc-86
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=Bzccnmz0kdT+xxEsAlAjYrsHs29fkyFJ60PLy4DGiX9nvRXbG20ziNIsV3F9HZmjNQE9eW
 YjPj/UiHmnsIpCtfAdgS1oOWSmSEdx7DyH36mn64YgvEOcp+SX+SIKd5tYw3oRT4VhiFOD
 RADktV1PqWAWgHMQ1/I2aJCzp8eKRZo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Ty5X4LtMMJuhiS8eEyEw8A-1; Wed, 06 May 2026 03:58:34 -0400
X-MC-Unique: Ty5X4LtMMJuhiS8eEyEw8A-1
X-Mimecast-MFC-AGG-ID: Ty5X4LtMMJuhiS8eEyEw8A_1778054313
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9b8137828so55822375ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054313; x=1778659113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=lWzGVpiAHLxeNV3g5l2n2Cy/lIEg7pXRpRX4Xx2X9dkRCp236B6i1Czyw+jNARXShr
 WKbhlWdAzijVlCoProshoocEdaytj1tMWImlP2fO5oGCdbVkoX5wfcCBXEv3rXe3ljcm
 FfMiBdGBo5AEvlh4OpTGmAFEykQVceUAHChxNNURByZXFyO3mYFHM9nmFItoCfJq9y8I
 A5Jj2YGE+NCbu0+CYYrBKmxDSgPKauCIdAVGvT1Nhw+fAQSWbEdkA56Dk2MjejO4Saip
 rl5BovyvkNPoTQKVyPx5cqB/VE0JJFcPkEEjIg/LwIprbEpYt5etAjK61cVLZkwjTuwv
 x9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054313; x=1778659113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=aS+OZVDWhOomKXOrlJWl61zfReo/uXsggJERaqQNVheY49/tqWrnig63cWB2rUIITS
 lR91fn+wOobVdFE3pZD99h9kW6D7V896X9Vj/cyLzxxEO2BLgeQTJxWjs2wJo67TwUEG
 no0yIkA7bYp6uS7DHP5VBD0GX5Qtwm564OA8veJJCpHUjP6mvXhbQ/U0Alt55joZ1hRN
 +RtsQOQNJIBb5gzMsY8sWRC3QOWFEMBykeOTk/bC905qcjnxqx853RGpNF9veAyXI4dN
 /sE2FHdx7thXpRpPW1rruruk8VucnJlrixTbl+rghwqfXJsn6UyUoX5Pvz3ORy8Q+GHV
 omyQ==
X-Gm-Message-State: AOJu0YxkqsMsn6MP9Hw4FPAV2rQAkYb/6hm+Kuy0G5Y2rp+EAQjRHV9s
 RuAX46MyadjfDiSn6KRoRKQokqp66AsbhLEn58ZRTQL7R5xYvg57aQu2Dm9Fv+1TS5HBDCKeW9H
 Fj1fQAxzQd2jbFHGR1vRLauTln6akFOepQo98FWX9kAg8py3Sru+3Igio10HOqVdvT7OznDKaU9
 XEohL/E88MdXs0iQOvhL72Pux8PKSQTJ8o+W2fJME=
X-Gm-Gg: AeBDiev0STUinJULuEbYvRzL4oomUF3IFdxWbQYhW3DpboXBpF7At5eZ4kgmf+iEUJ3
 ddhFPYsHQVMFsGS6rdQYbLwM2XVFuOxfg1OH6C8E4jg3LvDH5+73S/luGeHmBSatuyUJx+W7olv
 HE/FBb2NiAH1X+efJg944oM4/D75nFS3i7G6a2adjRU1UgoPJ29IhHMM3nEe+V3my559+yqL1r9
 z6YcZdy3I/knwgVKUhEEJmenJOg5m8kVMpw4QIx5SsOqongr+IStFbvbHMFX8B1A0uieKTlzLSn
 joopq8ed8mYdM199ZLVAa61Xwp8GIggPXsTm7SzyNvUEnSB95/G7A4mfPO/ViBzjBQ15wM+EoMy
 sB8RFNjJT3DyHu0MaJHX4E2paR01NNNy7SzioRs6Sqh4zgY4b8Q8KLY7dHPHFigPwD19u6b8d
X-Received: by 2002:a17:902:c40a:b0:2ba:13d8:d503 with SMTP id
 d9443c01a7336-2ba78b3fcfdmr23743755ad.8.1778054313172; 
 Wed, 06 May 2026 00:58:33 -0700 (PDT)
X-Received: by 2002:a17:902:c40a:b0:2ba:13d8:d503 with SMTP id
 d9443c01a7336-2ba78b3fcfdmr23743365ad.8.1778054312559; 
 Wed, 06 May 2026 00:58:32 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:31 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 2/6] hw/tpm: Refactor CRB_CTRL_START register access
Date: Wed,  6 May 2026 13:28:09 +0530
Message-ID: <20260506075813.120781-3-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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
index bfa09c04cf..a0f472652e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -146,7 +146,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -195,7 +195,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.54.0


