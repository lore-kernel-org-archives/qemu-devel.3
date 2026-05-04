Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BC7FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxK2-000811-PM; Mon, 04 May 2026 13:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJz-00080k-Eb
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxJx-0007ez-KQ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=LOhh9TaNywbFktvZaNA44p8bRWeERD/raE/bSlSiiGYgFDBbXSgKVeat46WpOMatgUvFUZ
 G0jVMlyDZMzA3jbzv1fJ2p1sEE+EdorfVPPNPJya+AfT2EA2bybMAx/fP4TQcqHhdPnJEp
 L1hDCvgNAs9l8g61Rv6/qkilm001p1w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-cBdb0BFnMTGbxqR3rdtB2A-1; Mon, 04 May 2026 13:43:02 -0400
X-MC-Unique: cBdb0BFnMTGbxqR3rdtB2A-1
X-Mimecast-MFC-AGG-ID: cBdb0BFnMTGbxqR3rdtB2A_1777916582
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36514eb1194so4041803a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916581; x=1778521381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=b5iKkGAycVESmU2XdBbwc0p/iSH6HjtjXF99me4p8FURoo3VNo+lCv7juJzmrKxIhE
 XlCAZ3TZWghHyAizLr8uxb0SBni8XLwbATwJpjU377+zx60G99rd6Q+w3xEPUMQ5GE+u
 iSgFaEyakcN5cKfWKpBGQru0nn7GwmYLS/IIXOveIlLlmiGnni7dLlRoBvulOIye2VEU
 +mHL4/COlMfJ8/xv4w9s7pc68TjntwnMQlmUsYIqxiz/oaAmS3EoDJjSTuzvx3XtE8Mt
 2JFn05YJP6jRnKEv/H36cwE0r0vu98aXefVeBJqotjaPRk+bXiWY+BJBGwvCE3A1vFBR
 6a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916581; x=1778521381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrFde0CzVFJL6FQDSYJhldHvMPOSgrKBQeMX0L6Tpo4=;
 b=Sm565ouKY4Kwd2x63zicOiuYS8ixm3Gr/m5qLhrup97awoINAQuWsI921Y0s81AwP3
 aV/uVl9aa4YHnNhvfsMs//0ue4LDagUsJnqWHgov3pf9k3BPytXmmYNd4sbuQmlhrPw2
 /S3ArVBB7ADHU5r+16EOqOhPWHdjp8BjouB9bMyLk4YcPnFEFrt6d0bRUZe5eVs3h7Cc
 NApK8wdL34VeAA9gyQDr3ftY4tsoazLRoVSbK4kIhFSNCSNJxmQPRK7aFE/3dTesJ4C+
 ZGFZmNv9tTj8jjAjqQ103H2yb/y/VjltakfsZTSYO5EX2ts+XEiFJudsIAM/fB6xUB43
 Gsfg==
X-Gm-Message-State: AOJu0Ywiaso4/yfRBTVqDcaiTylD7WStzjYyVVRGzHxDOB3t7kTai2v5
 jQLsUSXDp82bogbYtw2usyjjEJOCxZvmYaLf5tK2TtDcsTD0yja3socjaZ1Kn93MTRF5zPlfSYs
 J1XUh06Mgr8JK41qT3jz3fmYrTw12xpT7to3tCrsYpk4o9xa0K47pbP3BMRnMiVVykrDJf170ht
 6e52WggwGakluNV4qEj8RscwHMCQ23AE9YqaCxEvg=
X-Gm-Gg: AeBDieujXLI5NDNWWS6r8AjRIFNCPgw5nXqPJwFoDGJWUuDSjbjnwzij89vwJj30RuD
 xKsQZAJtZP/TJV4wwePJgDZfLWxY30uxTIX5x5EhjYpRb3rwcYhZzVwOXXc0ZbhPpHLwnIR6cES
 FVVqw/jCYTBm5/toiJn5J6TnwuK8+paZRR/dHTLzv6BSfOVr9OmKophHd+i2eT6z+fbFcKFtI/z
 hueZ5IdgOSoeHmadF++4DzX4FhwnbNSWYDDNefyAYqIn41xLT56dBNHvhOK4gCXfXC/qHBVG5Fe
 6RCkVQ8pNn9xu4EyfAJCWiz4DcsyvDIlXj3/QNflIr5bSpDptPYiZDXSq/ron3KZMCvEeppiQw4
 hZICJVc70gNZlTi6W2UXXS5erT/v6Vv08unMSevGsWpgyAFL8gyOklWGwUO7Dv7IlZYE/QBJK
X-Received: by 2002:a17:90b:4ec5:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-3650ce8ef90mr10698447a91.14.1777916580827; 
 Mon, 04 May 2026 10:43:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-3650ce8ef90mr10698411a91.14.1777916580365; 
 Mon, 04 May 2026 10:43:00 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:42:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 2/6] hw/tpm: Refactor CRB_CTRL_START register access
Date: Mon,  4 May 2026 23:12:30 +0530
Message-ID: <20260504174234.13556-3-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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


