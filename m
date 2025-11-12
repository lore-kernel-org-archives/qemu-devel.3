Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A98CD343E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 18:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJFMV-0004W2-MJ; Wed, 12 Nov 2025 13:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFME-00039Q-BR
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vJFMB-0006nL-C7
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 13:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762971250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=F3X58444+vydgcbylzWQlATIdR1va4Vs7emMsR19yAD7gABg7RCCbT8wxEt9NL6s3VZp2+
 tFs0ITEN6WFOHGuNfg++325jMCHumDKJG2JpD+C68d4xbyps3jD+HQP7QQ1EPd8YW7nF5y
 R52s6Q4+k9+ygNE6/XTbr2zf/+NL060=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-GA-OkqQ_NM6UNVkFZtrD4Q-1; Wed, 12 Nov 2025 13:14:09 -0500
X-MC-Unique: GA-OkqQ_NM6UNVkFZtrD4Q-1
X-Mimecast-MFC-AGG-ID: GA-OkqQ_NM6UNVkFZtrD4Q_1762971248
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4777b03b90fso6714005e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762971248; x=1763576048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=CMxDqFQBNb/sHbOCOB9tCIp5CZDgJl0tBEjBQIJP3JtGHhdkuSO903BmQufFLnYxD4
 jtKStFUZ6eBjNKUX0Gda5q/F2wuHDdt29TPQniNA0rCYBDzyAeRH4t+X5/R5L/r+XxRA
 0nNAQR6jCQ+o4Ok8hue+cllb1tczhyWwOdGy/OZ7sUxk6bQuzl39kGc2tE+fO8fLl8Ia
 n0h2dRUyyziCraBfNOeHZngVo8Uk4Rb7KaRF3Y46KycLLoyCwmueK1AL/BFCoQfI3FBG
 PM2bIh+hhYl9PO+qvxbg56JS8xCHLryZ3o//qUUAZtqu/iLZWSSu6Jmw7smqeLY5aATY
 RHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762971248; x=1763576048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=beNxjjM3s5GHpd+qHWyIDMdEc4lmhRM/gmK3arQjhIB8UVv1pdhd5U8+rDDaKwxHwr
 XclGcxYzFKFDPgc+BBx5vXhuHbf9Z+Z5MSUt/eFdGuIlSd2Uxh3sBnYatoPyhgm2tVV6
 FGZ/WnO0XRNKJ1Svu3umOfkPm8Gatq36Z9WQtzklHeRsXmF1/MOVsMEmxlkGBaGbFcwV
 rn/uUR75NoRkkbSoesCAnZES7G/zJX3gGI0ThCnd2o1N3Fi4H++ux/RksPNWbsJ+oAH4
 ul25um3ONzM98QpHjxr+K3saImdDfxs6hYzCybUtHyykXtPHd7NZlqG54BMEQnTSS7yU
 6K4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfpb3fID3q4fMrU2MG3Tb+vcjX+5wQvh/Y73eL5kKjsHXH6xOrmP6ZcoOI+/QGIxkns4B3AcZynyTZ@nongnu.org
X-Gm-Message-State: AOJu0Yz0IKh3dkn1Al5/kxQl/tY1hNu7zv7V870kOc20MtjsG6jJEpPn
 XVTucwbG0OB0k9ARZeVx/TWomLQEBx0PmwHnJhx9XUfy2jo8x7SmzI3Yr293DKGEbveLq4YNKCQ
 tRGnmz1V66F2Xu0ZeZxCWddw3uawJ+yUmJi1PfY/TsrFqTka+NSFMU2cW
X-Gm-Gg: ASbGncuSMOXE0uwHFuCU6aETEQH4QATgCDFcJU46+DJujGFlz+Sr5rQE370CXTsGHG9
 TlVNpdaYB+7QlK92Cz5cuxoFuOTJZwi+WEXrGQWew/VTiiuumP3cRhNv6UipVc5ra/3pCV4fCEk
 iDot0bY/qe+opjxfqqPKq4DHLA6R3P/o9s/V7MM9BIABSogb0Y8WliW9OAXWMxywrCSqDeg7jsM
 nbAPg7e/IsRqiyZ+XokD5IbtM7tfAluwHFQ8jy8fLE5vVtAzNfq/XM9ypBi9qoe0ayNgeyKFtU0
 /E2OSvreCxYQ8tbx7/bewxflIKKqU329hvbvG7scnnbUjei84hCPhi5q93X6lloRRRq7WiFggN4
 N8Qerxyxd0uPEKpapK3fXmW5IHFk/cht8LTQs8A0iXbb58oGppfqany6xwZpBqw==
X-Received: by 2002:a05:600c:1d0f:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-4778706ea91mr33694035e9.13.1762971247839; 
 Wed, 12 Nov 2025 10:14:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExx7YrdQI+IydYpEMMuMdDOGxLo8j/rSItSIu9aQs64pFfJY+BoQHkmXgSTSSwlx02YpTuFw==
X-Received: by 2002:a05:600c:1d0f:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-4778706ea91mr33693785e9.13.1762971247394; 
 Wed, 12 Nov 2025 10:14:07 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e51e49sm46851355e9.7.2025.11.12.10.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 10:14:06 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 1/2] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 12 Nov 2025 19:13:56 +0100
Message-ID: <20251112181357.38999-2-sebott@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112181357.38999-1-sebott@redhat.com>
References: <20251112181357.38999-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
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


