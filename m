Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F127EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXwC-0007jX-ES; Thu, 12 Feb 2026 09:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvg-0006rS-Kx
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvd-0006JU-BH
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib0hoRv9v6QkqLlSYdriLq1dMc7eH7520dLic6nJ728=;
 b=dRiK87sBXFytobK8DGfPrKw5jVG2MW4pWX2Uksxw5EPHI9LOL/xNEkm3R0p35TE8++3B4S
 s93Eiyh+55LOHjPoRXHbXy5VGV1C6sA8ZB3pgLTn3g5p1CcflgyHw+hegjQk8EjES4ka6G
 WA1GSmBafdBGnbN1DsOx96HgD6xATCo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Bhr6la28P3y6ggH3ryAiPw-1; Thu, 12 Feb 2026 09:44:23 -0500
X-MC-Unique: Bhr6la28P3y6ggH3ryAiPw-1
X-Mimecast-MFC-AGG-ID: Bhr6la28P3y6ggH3ryAiPw_1770907462
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7fbf4fso5784805e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907460; x=1771512260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ib0hoRv9v6QkqLlSYdriLq1dMc7eH7520dLic6nJ728=;
 b=fQzPg9LE+Svfo5XtRL8/EHV7tKpzgjHXiu7kSPPDtaK0Gx9aoTZ+4dADpvQDSTUA3u
 2OyFdOlSghVz52aNQ+kdDWU+GKu0Fp7OYs3Bv9gKyHwbXA/uId2XcNrEZboEd291KkgP
 eu8fgq4H6nQHyp3N4F6nTMTrNe6hWATFJOWdqm6NfJIjWV1DJ5j4eNurXuT9ulz0nUNr
 NC3FUoyXYbUNLUCuwxbUkdMVkO83myJ9C6ph0gpQqDaMmhlv/oGTmp4tsH+WW32NJBKL
 TPVWde9PjSO/Y9Du3yGP/WB1BpSBoEqkOZc3g8xHid3qrJPoZ/Do0+jLBq2n2W76KNGq
 Pz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907460; x=1771512260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ib0hoRv9v6QkqLlSYdriLq1dMc7eH7520dLic6nJ728=;
 b=NW+OuLP8a1RzpOj4pAt2ydhNKXzLEW2ksmvDBms4XgI2BBwGALK4A/GuEknUylht15
 0bVi3z6nOUW4f/WC8t8lNXWe7kifKIYTrdJD6Q9pCRc3bhsYRPXxWH3t4TkhxzWTUYZM
 g+CfrHku51+fGt3waCDGN40w656h5i8Zae6sSj81RtmXCoX0UbWZINIIH6fD+FJ6fmIF
 tdXGT7Y0TnWDkWVVZbl0NjC/Qy0m+XlPrI/wjkzkI4nWLnDQoaS836kEybFS7EsMf8eU
 itNZZuMuqoC5acQT7LAv6fz5N1GNmERMhzlgOMVmSjw8Ti6tFaOH5WF1kcfSEWaXTLVf
 mWZA==
X-Gm-Message-State: AOJu0Yw7kVXxo2FmCl3YH7l++hEWtdWU8QBBpgagL1XxnelrKyNkGBhR
 lB/sbNkBLuqK0XpYW2gcB1KPJIqU+cFH2k+YMzfdxAKhMlh3KyMLpMw/i/6+3uYOqnGzGxBm046
 bLArSfQam0WNCWdlYqDeIo+RJh5JKgoAf8cv5mjvD44+GBME14Gk2pXurZ+oYN2fivsFousiy5B
 l3IA2E8kElnA00KjLZCMo5/y27I1xMEtWv7nnkcK5h
X-Gm-Gg: AZuq6aLpBvoGCFl0rA7M8m2TZKecmFWEU+DIDIvaetAzVNWAc4iba6wgB7q6fKRTjdw
 DCotMZkT26dRJXHn2ikV4Q36JJoTirnWn1/3h1Y/KuI4w1W94WAcguLnV358jRN8SV91ME9qlWh
 H8oqh4vqhZSAQ/dFBHJS34Ze8jqJ1zptFmvvm0R2nFpay3UZ34KVdqcZaiLHY34btPtEA8yXGY+
 bGnvBsOt0TR2dim+rmmLlGfUDwbrydDRYZXPjLHLQIX+yqDVW2YpV1T2tVl8TeZjWQysKfF224u
 ouHsLSBL0mzyWcdlh7wHDyKw6TFjahJF7Tx2vP/wn7WfTwL8pVVNdPdX6sd/Mq1M1sOg4TdDNR9
 e1pqCKsmPfBju089cgwgoKvaWs+ImT6hWF/El2FYLxBRQuUoSFaGChgofwTuiuvnl0rISyYU8/F
 w01rML32+rpRddQoOgPaDDDeZ6kJLcs7gJbmEF84x+3sLrVKyex1k=
X-Received: by 2002:a05:600c:4584:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483656b08cdmr46720905e9.5.1770907460467; 
 Thu, 12 Feb 2026 06:44:20 -0800 (PST)
X-Received: by 2002:a05:600c:4584:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483656b08cdmr46720315e9.5.1770907459856; 
 Thu, 12 Feb 2026 06:44:19 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d994670sm101584295e9.4.2026.02.12.06.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PULL 41/41] target/i386/mshv: remove unused optimization of gva=>gpa
 translation
Date: Thu, 12 Feb 2026 15:42:43 +0100
Message-ID: <20260212144244.22579-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The removed parameters are remnants of a prior attempt to optimize
gva=>gpa translation. Currently there is only one call site and it's
not using it. So we can remove it as dead code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20251125120852.250149-1-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index f5c388eb87c..f190e83bd15 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1336,23 +1336,19 @@ static int read_memory(const CPUState *cpu, uint64_t initial_gva,
     return 0;
 }
 
-static int write_memory(const CPUState *cpu, uint64_t initial_gva,
-                        uint64_t initial_gpa, uint64_t gva, const uint8_t *data,
+static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
                         size_t len)
 {
     int ret;
     uint64_t gpa, flags;
 
-    if (gva == initial_gva) {
-        gpa = initial_gpa;
-    } else {
-        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-        ret = translate_gva(cpu, gva, &gpa, flags);
-        if (ret < 0) {
-            error_report("failed to translate gva to gpa");
-            return -1;
-        }
+    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+    ret = translate_gva(cpu, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
     }
+
     ret = mshv_guest_mem_write(gpa, data, len, false);
     if (ret != MEMTX_OK) {
         error_report("failed to write to mmio");
@@ -1407,7 +1403,7 @@ static int handle_pio_str_read(CPUState *cpu,
     for (size_t i = 0; i < repeat; i++) {
         pio_read(port, data, len, false);
 
-        ret = write_memory(cpu, 0, 0, dst, data, len);
+        ret = write_memory(cpu, dst, data, len);
         if (ret < 0) {
             error_report("Failed to write memory");
             return -1;
-- 
2.52.0


