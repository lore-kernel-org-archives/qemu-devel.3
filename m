Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74435D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyym-0004J0-RH; Mon, 02 Mar 2026 03:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxU-0003RV-3N
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxS-0002HB-MT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfJw+zfaAr3zTPC2m8isA7MwFlzp1fxZBmdz0nr5xEw=;
 b=LA/cVHxcby6goGqEsABKxkL6jLXOm4iH99gNCW7mSDWmhYpI+W2Ujd9r27jFsD3vKz4gmb
 pV/PO+BqoXQpW+M3lCywiHF1xGJ+hrGGygsEps3JorMfX6GisxB0ezEsv3UEQ3DHL7FACR
 xL1zRl3FD8WerkUaA0UxD1e4LW3ofeM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-4Vkkrho1NCabAYCI_fB9iQ-1; Mon, 02 Mar 2026 03:48:52 -0500
X-MC-Unique: 4Vkkrho1NCabAYCI_fB9iQ-1
X-Mimecast-MFC-AGG-ID: 4Vkkrho1NCabAYCI_fB9iQ_1772441332
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48379489438so39520135e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441331; x=1773046131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfJw+zfaAr3zTPC2m8isA7MwFlzp1fxZBmdz0nr5xEw=;
 b=r3TRlQl2nMX7J5Ipap02JiyQxVtyLcURiLaUpJGUdQJhC84MByNFwXfzZKcFSL+5+9
 xXJ0QMvQEptM4J4LZ+Xjm64V3aYGw/RHxhXj3MAdBHiUWbCKqullcgYAt+225PN3S3Xh
 3fNGjRmuSAF3XZ+50T7Dv4e7mfVUutTGpZpYaRD2Bd9YILffoH4dsqWzKDb/GLA8MVI1
 TQGmuAOhva85H9T8Ze+7iMfHIC6Mf23GCbe0t6jcc8Ut2HKaUh8rrhyB/e5CzANXI2DI
 ZsckYGh6OSwdUz/Jjtmt+T7mSE2AtpsJdSzfT/qw2KLNATEEY9YuzggFikRyuOYx9WFU
 5klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441331; x=1773046131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EfJw+zfaAr3zTPC2m8isA7MwFlzp1fxZBmdz0nr5xEw=;
 b=dNgepYT2D2mRZTqZU10yhwD6liRFZPDfniIsZM/tvsTUzGWMHvKZar5/2LBIfCtvFg
 2yCGO8tlgQIfc1Ov0FF6pweLwBUtf7c/3J0bnIgz9NhIGnLCQoUrGzxRBXZK4SYjLbMf
 1kpC3CrrCbYBjIk4tbVH5dTO05fs/sQSmdAFbOpPFCWgM5cCXro7tvlV7wd+H47uWxZz
 IOUhMdyY+fvaQx6RyXFAAqsOGA5eTGLx49XLx+3k4a7v5akX6k61qm2cC1ZKspc2yQsm
 FFCmAmSS64191aCfE0Z4hSEpnEjV5ci2OMsxEklaMVJK3SzzHrra/xCNyKDLctbz6vZe
 DVpA==
X-Gm-Message-State: AOJu0YwGLYMIgiwXy8RWWBhU+KLGWHGxzMdtA2wsesx63CSihQrF9kyt
 ME1z8qq3EOGhZFFaPgipseRK/4MYZMp0ZdluFNh4DcfrtcjgWyLE1SyvIZdv94b8XeCIOejbAWC
 /C+F5Rq9xBZjO5ljWAH01Csuz78X6fkVw3PONrRSAWRmgzM7wvHH3To0Q2MLjJ07cI68GqVTpV/
 d/GYECeQILVzm/is8KJS3oIz2qI6WxxybYsy+osFnE
X-Gm-Gg: ATEYQzwYrfT3ebj77YZgWHQ08xkSctigJSIdxN77lWTKmW/0scSdMOqIzZX4ORFtp9z
 FBuis4BpdwLh3ZZP/whFO/6Rnv+WC3UmTIgWzJt9iRLnSUe65RZnP8q8V6LxqOCWox5FNezHctE
 r2EHJov06N8zL8goMVfOx+f28BuLF1LPv+XYGEwgYMk74Drpkn2jR3TXq/q5uXdmjnWpo4pBVYE
 6wUTxP7VMgOov6cTCsA/E7NNJk1VKab/HZofu5gv4+AiGtpjioKJoviRyn/tpDduC/CbOysGi9m
 brbpoLnaJrjR1fpkaJBv7QvlZgRh/nTAe56bAAE3H6X99lYLZS8O5BtirJzGet3S1JmUmTiHryp
 t65AertXbw/U/ZCjKjPeU5BgDbu77KH5ifjHsZUoe9IV1DpY7JR1c0XE6gaEhW20IMLMY0YcE38
 iLoYlvoealyr/mGFyR6lDiWBtK7GY=
X-Received: by 2002:a05:600c:b90:b0:483:456a:514b with SMTP id
 5b1f17b1804b1-483c9bb1fbfmr207701705e9.12.1772441330747; 
 Mon, 02 Mar 2026 00:48:50 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:483:456a:514b with SMTP id
 5b1f17b1804b1-483c9bb1fbfmr207701265e9.12.1772441330234; 
 Mon, 02 Mar 2026 00:48:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70ed47sm28531096f8f.11.2026.03.02.00.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 090/102] target/i386: Add MSR_IA32_ARCH_CAPABILITIES ITS_NO
Date: Mon,  2 Mar 2026 09:47:36 +0100
Message-ID: <20260302084749.474955-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Jon Kohler <jon@nutanix.com>

Add bit definition for Indirect Target Selection (ITS_NO) bit 62, to
allow ITS_NO to be added directly to a CPU model in the future.

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251106174626.49930-2-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c384302de32..f2679cc5b72 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1329,6 +1329,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
 #define MSR_ARCH_CAP_GDS_NO             (1U << 26)
 #define MSR_ARCH_CAP_RFDS_NO            (1U << 27)
+#define MSR_ARCH_CAP_ITS_NO             (1U << 62)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.53.0


