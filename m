Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCD3D11705
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSyK-0007va-UW; Tue, 02 Dec 2025 11:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw6-0004we-AW
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vQSw3-00006k-R9
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764691742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=EJNLQ7t/HC9pHk3ZOegIXaOE0LBqz7z9JhyvjOF66wtwuqaYMiDH4u7MnxayNaMvDs5YJp
 OqZS3sxCTRFZ0fEDp08M+Md+C8x+ye7mk8Un8rM5K56ErOGc/YAf+bvnY0RfGhFzLdvheu
 6Ow51DwFplUTPZ5WPNXHIj9w9IcMVFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Wl7PHFT5OhmXKOIh4HOrzw-1; Tue, 02 Dec 2025 11:09:00 -0500
X-MC-Unique: Wl7PHFT5OhmXKOIh4HOrzw-1
X-Mimecast-MFC-AGG-ID: Wl7PHFT5OhmXKOIh4HOrzw_1764691740
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso55261905e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 08:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764691739; x=1765296539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=diSGS01l3ewsqkQ7ruX73RAXoAM2rW4fS6HBobI5KmXLAtF/JVj+akxvXvKqesTtHc
 i1Dum2Bb67h19xiChi7yF6FwED6VIHzIHWpy7SXCqC0G6UdcBUDv6oWVpObTjxUVd8zT
 4Owdf4FSmvwbSsjzagYbUlfCp/ZmJqICsYW79jhgBt6pk3EyDgv8dMBZSJfTQ7vdXiWm
 FN8bTsZ7EijszGngAy5FVZLcgeVZ8KTdsVIpcgiDNAALJ54OtgxJg4wIn/pYP5g59yiO
 u8Uwqe7pM0gtx2oal1VWeu3qqv+mdyAyWbGWkp3YjFmpsO+PxitnfLadHKz21JjAvuZ8
 e07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764691739; x=1765296539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7+Ad1DQku/KL3b7bCdX4+uTWQCvm0tEszy834Ayws4=;
 b=KCVpTpesYVuDTsxJmZmbN8DQgClof4tTSI7GFo4PRr86dMosIWwZqjEPVORkjysQTe
 n5S3p4dekSdA5typpo+O2Nt7ywfRRIGI33CUw+if5xSCbAOaeQvGep27xtkMZgpflFRY
 sr9pEst2q3TOlqcs8JlVnZXr1iEAalGxOhNFQRyfa6Wo1yZv2BCKzJsiWZpAgdVucsIq
 qxt5klzEi/hydWP+NGAKuljTvl8gHZi1VT1z2Wh0isz1eu3nQGmbeEoigVW/zqG9MHLo
 Ruqgbc0mykkble8Yw8mDbaTj06fcSz8lYlG2MrbmJuKzNn+pdaSBe5NMeNHCGInYj3r1
 ANxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVovTioYWOSr4et9TH/9FYGWtOaTorfb5b48TuKe0zDtH5IPGDStkehrCZjvRxKTLLIZEVYATnWIVTS@nongnu.org
X-Gm-Message-State: AOJu0YwZ5H35hzF+Q64qWZUJcGD7HALDJunpw/Bk+ZdLowF9tKNxGkjz
 ZKgLnJAdexAGpsciJWP7unn0IL1+vpg9VVY9NNFbr3XS82XtptO1e6TSmshEwbT92czX32rgqrD
 5I3H2ubUsO9lc+ctOktamfMFfvyJr32b71fRkXTI9CPrcDV+i9RgfdknH
X-Gm-Gg: ASbGncvs/oxkEt9fG+UOtVrAWpdH1evIb603B2+POhIXWmg6hhOjo39s9uWZ990ikj1
 IWt5YDMTo9Z1Av5a1ej5K47pToKqlLWWGphlCKBJmMEAPguWRujk0wiutVQB1jq+QgrKlgJVaVg
 yn7EYaIw0rjV62GBzcUmkNwDG/hW9cpj9EASVtULeiFziXIkVYANK4eU+P/gG2bapHEMbnPBXdf
 DjoAsEulI/PceB28bAi96FKjpVLs7GqgUN2CgIm4pcU2BG4be3qnyGYJDkH9b9bJRMZT4F+uQFN
 DJkjxyhrSRtvSt1Xo1bA5qe72NGgpkE354D9bkHw90nWtsViLgcFyh6GH0te5TfFmggR2Do1Ek2
 CS1zFTF+DeTz2y+y0ZKuNOYiRvD32oCD2rH7nzE0Fc0yUcX8jMj7HfFJnLtOyG9uHPqL0Lf+Q
X-Received: by 2002:a05:600c:1c8a:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-477c01ff636mr474350565e9.32.1764691739639; 
 Tue, 02 Dec 2025 08:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCJcOKBkToQRQqCimSXYNAuCA53uuEuTDBUZ/jgsC1gwfTGJxcvlPlmY/zYIMOG9XF+jmUlA==
X-Received: by 2002:a05:600c:1c8a:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-477c01ff636mr474350245e9.32.1764691739282; 
 Tue, 02 Dec 2025 08:08:59 -0800 (PST)
Received: from rh.redhat.com
 (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa767dsm34300899f8f.38.2025.12.02.08.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 08:08:58 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 1/2] target/arm/kvm: add constants for new PSCI versions
Date: Tue,  2 Dec 2025 17:08:52 +0100
Message-ID: <20251202160853.22560-2-sebott@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251202160853.22560-1-sebott@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


