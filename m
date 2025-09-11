Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2425CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwicJ-0001C3-Bi; Thu, 11 Sep 2025 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwicG-0001B6-IU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1uwicC-0004IT-Ut
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757602176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0a4n2ZzYOr7lU8ApVVE4XfictzucsNLVIeb31abwSM=;
 b=MDs/29C3LGS8NpDgrYn+ncba6sg9SRHRzEYALHqyOCWZrm+xWwdl0gbNfeGVBHRLsNfeRo
 i0zgjbUizGCrstCPealqmXTIiwAEsIO2N6fFH8risF8HvpXQ3xNuI5kRkN64rbEmcA3uT6
 td/EZAB/fdWGHsIDRl7LPOn28mVibZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vTnwuHjxNsesqL5bEDCmeA-1; Thu, 11 Sep 2025 10:49:32 -0400
X-MC-Unique: vTnwuHjxNsesqL5bEDCmeA-1
X-Mimecast-MFC-AGG-ID: vTnwuHjxNsesqL5bEDCmeA_1757602171
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45deddf34b9so11885975e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757602171; x=1758206971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0a4n2ZzYOr7lU8ApVVE4XfictzucsNLVIeb31abwSM=;
 b=f9f6uKDJUUbTkx7JJLKtgM9VqwWvPwnfCyAhULOQwvXPXbvUnVh8s0M/iKL1KBQsCn
 bT2vVqtScED8y084nEwrZALxxSrGtPAHHMc1aWem3clfi/c72X7PgkoGcZ7j6LSyJOr0
 86ifTU3SLmmtRvg0iwcAG91SYj2v/98xnnpD+tMkA770E7kZunRXxMsyRtGKVet0FLzO
 245evbB7KFdHCLfvu5P60B1ZvXDqHqwtt6D2B+MMnMTW8AQpw2F8A4j3vsWoAIMS6NSM
 3akeUB3Rp3w86BQy5izd5/gDaeUvpZyRDMqi84l+9iV0sIAwbyDjv5r2oRza9YqaEv68
 w0sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl+bHL/SDz436R+nBaXEdCRWKEHJmp7dTJwHM4X1P084xZd2s20v0RygRwwwEv6LBQNdEPw+R+wRK4@nongnu.org
X-Gm-Message-State: AOJu0YzMMybEkEM8nz/o2swuXSSMqDcQtEONJ/v/4M7Pata6EOQDqkkg
 UKN3YUIgKBvLzaygN6IqJqywHGSVI6UPdm0eQ5Keh0W/KeBupSdsvJihh2KEn68IttYSLimTlR8
 tAfFyZOgwURMqCDWBEPX5QjGzUHTCiWyqJzDcSqY7crn5XFJePTiWFgmL
X-Gm-Gg: ASbGncuGRokk3VbvOCPX7pNc0rYZVXbNC53TKmE1yE1aVsA7pAE3jL6XFKPs9wlYVAb
 UfV8zjmOU0tI64pAkn8nBljMkAvFqo24uL+numbWuPFjRocrcr/0d1LUWDaQfgYNQHcmSyuk0Rk
 QLNKPWhU8+4t9x809PWMIEgcy4f+8gK9wUUNKPx0XXJ4DY1uFKHO63gZY5uBU6X2wxtvaO8xZRK
 RyUGmjG7R/8fO+UfcblgIWko8sJqb944EKgN09zL57md8lkvJj5CAi92yjA6iyvAYYUFPIjfHVb
 XRX+QEZ0+FetxbVzUKrgUnmxfTFkpRvWIpW/LWvfnBC+UyBOogEmrOtTlR1Xvp1/zS+7R1tNcIx
 qDnOhkI27zPy/cpxfUnQPwsC/MDRT
X-Received: by 2002:a5d:5885:0:b0:3e0:63dc:913c with SMTP id
 ffacd0b85a97d-3e75e0f0321mr3085767f8f.3.1757602171248; 
 Thu, 11 Sep 2025 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw1IcstkmaYZN9of6DaQnGTrA008KACS07maSaSJLOzYY0ys0I9zEDtisEheF3g2dnd82HYQ==
X-Received: by 2002:a5d:5885:0:b0:3e0:63dc:913c with SMTP id
 ffacd0b85a97d-3e75e0f0321mr3085750f8f.3.1757602170839; 
 Thu, 11 Sep 2025 07:49:30 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0159c27csm14941575e9.8.2025.09.11.07.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 07:49:30 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH 1/2] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 11 Sep 2025 16:49:22 +0200
Message-ID: <20250911144923.24259-2-sebott@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911144923.24259-1-sebott@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe7..239a8801df 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.42.0


