Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F87DFCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzee8-0002fn-KL; Mon, 09 Mar 2026 13:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee6-0002eK-IF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzee4-00026E-CE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=MzE4BhJM2ojQRepEL6wbfsCPVdNxsqlKby/AJr0UJbf8C5IPdw8m7jhJi/PKX6EfDLzkKx
 W+IXwgbqjQEUTTF3wADyzb1voCRQQVewdTv6hDhodxiUIbBhLhZ3ACrAHI7k3otNb2SGn9
 qHDb27yQ0k5xvCOKzaE1AXElheB0Fm4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WqmRSuojPqG17qrDyVQ9Hg-1; Mon, 09 Mar 2026 13:43:54 -0400
X-MC-Unique: WqmRSuojPqG17qrDyVQ9Hg-1
X-Mimecast-MFC-AGG-ID: WqmRSuojPqG17qrDyVQ9Hg_1773078233
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48378df3469so82847555e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078232; x=1773683032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=FVjpbHHaV2WDfV6s+dzOnaQ/6cojg+n/tBU1aLKZooZ6ZTi6/bG1GvJ4PHOwfCXcT9
 DqEtqi2fpLiwTtFoTensV1qs6dusuzKGaZSNjUMCQBzFJ7IEeE11/py3Qh6QO5XZ//AK
 kj7TEvio7FPiNcPJ8hIbAZQYR7J9s5QtXJ71v2GjiBVW/sOIA2kZ06arNIgQPYaniwF8
 unM4PV36XAQuUUfQPikLqIHjqfnS0iDQGtA9iAFbW0Ld0oF+Bd4fgy7mihKfxp9QuXi/
 JPPcl3AFy9FZ3fSr7JuV4SSC9BxuO+LtlfaxsXyOBA+OUV/ZMRoN3rrwrojLeXfgT08u
 Qh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078232; x=1773683032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=barQm0ytYadQlbHRY+PvBMzrx7IGIkBCbHT+M4DhJKE=;
 b=FVvOo3qz5kk8TZbcFRWK7Dq9QE9bRWCdDE5EIsFXI3KUz9qp0C4GVwOnjzMtPNl2gR
 COs9KFBYOG7cmygB80/2w/kHGsmWAcciuGazby405qAC9huvBRRJOEfNUS9cjaeH1rl4
 IZEJcV/uNJ5TXBd8Gi1d23pco1Pm4guFVVh+D8G228dS/RmAqdoaMN2wNvH3enAmmX/D
 DxMbpZ3oBsXwD/6O6MF9d7d28/dIsTRWIN8Ur2BVrB3GG1dHLUJYnutj39ioUyBS7Bsr
 sGq1oSWflmgg3N0EMKPBNbG/EFgEP5JrQL8B/DI1pLfouJBCVkX/J3l/EhFcINTBq0PH
 mUjQ==
X-Gm-Message-State: AOJu0Yx4LmHBVpJA2Mq000SVtH40gTaDZ/9FHcrznamSoWqyhIF/YpdZ
 hdwTPwJF/JqW1gFWJ0NZbw5mJ/T26vTT9EKiHSFU4cOQGD84U9/SquVqD+BimXWsawKgZl+h7jD
 FORiDwanpIKivEBzYo5dzoDDX7seTvkbMDicTWvi4+QTcOvdem5udjvJAs3kIqMqQ/fk4S6Kuv8
 B9yK4XYPEGsRkLf6lMTYs8NrdBdUL4hlGGprOibqx0
X-Gm-Gg: ATEYQzyYanTaYjWbASo3wa50LHYdR5jv6bvoe3xOhAID5VQAJboLwDR8YZwZksNJkhF
 U8m4Zkl+keY72i/gGrPuLTw/cYxrqvXAD7q4oLFoii9quLu5k+PKzre2O+8sntNbwAdOmVwwbuD
 cBIN73vDYyNnSGLjoPRZsX+dCXa1uUlocj6+JMvlhHpxxHM2vStnwdoDrV/PskSAvJ5+aWc3Uzp
 xKhyZ10fmywnKmCADP7orY/ZrYLoJZD14XE+lMdstG/L3h2sUJdmDb/i/wA0hYS69sk2RfRmS7X
 YPoV+KqNLXd2FjMPgpq6b3sNK1a6v14yHdokTdrJ1M/F8b6L9uRXSy0P3ldF8w10scMUgwSn20f
 sk7C09d/QlZ2bVo5wAOXW4vYzB1BLOJqjck25tpQnhdazRscfI4ZXommOMnWfsauMUjIjCiW5gF
 nYQWeOr+MqKkGgIBcERfjUUZMDA2U=
X-Received: by 2002:a05:600c:138e:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-485419d759amr8246875e9.9.1773078232338; 
 Mon, 09 Mar 2026 10:43:52 -0700 (PDT)
X-Received: by 2002:a05:600c:138e:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-485419d759amr8246405e9.9.1773078231809; 
 Mon, 09 Mar 2026 10:43:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm88598325e9.8.2026.03.09.10.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 05/10] whpx: i386: do not enable nested virt when
 kernel-irqchip=off
Date: Mon,  9 Mar 2026 18:43:35 +0100
Message-ID: <20260309174340.52174-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This combination is not allowed as of build 26300.7939 and results in:

qemu-system-x86_64.exe: WHPX: Failed to setup partition, hr=c0350005
qemu-system-x86_64.exe: failed to initialize whpx: Invalid argument

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c172e86886b..9c60295d553 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2160,7 +2160,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (processor_features.Bank1.NestedVirtSupport) {
+    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
         memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
         prop.NestedVirtualization = 1;
         hr = whp_dispatch.WHvSetPartitionProperty(
-- 
2.53.0


