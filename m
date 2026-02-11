Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81148EA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCBJ-0007LG-Kv; Wed, 11 Feb 2026 10:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCBE-0007K2-8u
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqCBC-0008Ao-2o
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4uMBqfdZsQbe7YIFKz45QFjnUCRjbkXzgrDvDI+qPJ8=;
 b=ML4BygmdBp7iX8wOsQ3F6MHrutvG2CphHLe2TjV8hPJSLbGe7WfPx/A7mCaxndDREzpXyS
 QlSvB7a8kYq22wXXttK5583xlCc8O7nAnttxVwu/80KzOcpvg3QEtAuO8sGqVoD8JpXsM5
 n47FEw4UwUCSiPxaUR0nvIkLJdL3/PE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-KN8z6zOqO5afZSASDe-_xQ-1; Wed, 11 Feb 2026 10:31:00 -0500
X-MC-Unique: KN8z6zOqO5afZSASDe-_xQ-1
X-Mimecast-MFC-AGG-ID: KN8z6zOqO5afZSASDe-_xQ_1770823859
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so37767455e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770823859; x=1771428659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uMBqfdZsQbe7YIFKz45QFjnUCRjbkXzgrDvDI+qPJ8=;
 b=ng0p2PzXfd/P6mB5sjJBW7JDY4C3XrrjsUtAQjJHdJB9bLxnzkwk7t3LaK/S6Fm5ET
 0gI6rPW3EyHXKN6cAuIsHMYosmNtKDaj6bRcxVJjDl8tMFZn9j8AAeLmaEhkl1SJX72z
 A7MhI95cbjjHCC7n5W3tX3SmCrevslDMMIGU4Polcv85ZK4f4pMy4DPHpwgN4UVdxcQx
 QjUSemiGu40H4emln7j2dxsL9h8fA95xekl44CA6PTYpB2stZ/MPBldHYPWElG4RNg5J
 PV7ng8ETBy3DzpQDCRwpTYMH7gUl3CA6Jg7hzwQAmlNLVlrqAHyfHa9MIcpzMDcLljeL
 D7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770823859; x=1771428659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uMBqfdZsQbe7YIFKz45QFjnUCRjbkXzgrDvDI+qPJ8=;
 b=Fc59xV3Tnh+D9I1yyCXG3wO4c3CRiQLgGXhJrloTTy3lV9B526qUME7ohaTTEO+QQB
 uSPEhqPNUdJUrxwnj/u6VR4jx5PNa0mN3tX54oain7uINJrA98ADaqc1sq11XNCI9GwD
 4sB8mPgOimi4Qg75roDVgkmE9EkDksfqiUElBJEHd36TESPXV6NKOzR0anYk+MeUAoHH
 96F1+KJOPxmp9dAUX9TYtqboD0LqVvZRFaPXtIEcbIADBNpiSnotGrIIfeLYdjk7+4Nm
 wL+1/+Am9oYuFB0xevEHLrEzYfV2zLIBln2tLXWoMJ/wEBmxjaskMTfTwXux4v8uqezg
 GsBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbBJNHIi1pWNdN08ijOAd7qGQH6gvffT0MNGMorOrCdONx+GWnKCQWCR4upXgjPjsW/DsChdyBE0xD@nongnu.org
X-Gm-Message-State: AOJu0YwzPBlrEslOsTLMgBVCKpjhHZciL0yUHiPuhtY/meionkbg7CLy
 lol2If3MCfvDbLldJ131h4LyrLZGFSWiGC4tZDeZrBtWOdnf7eQUNI+vkvedVhm7ylUHO4PPtgD
 6zWC4h951et4ShLlQe8s5+w8yEK0leK9x7LHlbknLi0Mf8r2TVuHSZ3LX
X-Gm-Gg: AZuq6aJPXIPRqWDzZxspxBdTbE7fAXe4Xo7/qAkMdtLrUHigLVSrgAq1kr4qLUhk8Dc
 KStZl32SjadWXCf8nL4bNZUmx7tA3zhzEEO+qtu8ffvUth1162R0P11LqALH1KZtRUappkXIwQk
 oQylcuVT02eZIqRSTAAgSczYYMfew58mQ6ewU3u4gkAMQ19KzrW1xR57ovp3oVi54QEEYuNXc/C
 1jAaZtHrbf+ka1DIbhAqTCthuguc46QcsWEwElQtyN3wXGft4OSZ36CTmnrRtwggDYZ1ftFEyNe
 Wa3OwGiRqwp7/KDfGnkZxx2ZcYGCEYpvKJJRJXSF2T16hjcHnotb9UeUIpR4X/6FfdAKNjXJkeS
 1Ortnmum28pqCwuHvr/ZXViCJtQfRDTiIsqaS/w4aEwC9E3997ORcN4HtJPfpXFZ3CPQ3mGp/U6
 vwrKJOXP8w
X-Received: by 2002:a05:600c:46cb:b0:483:ea6:8767 with SMTP id
 5b1f17b1804b1-4835e2cd408mr35512085e9.36.1770823858850; 
 Wed, 11 Feb 2026 07:30:58 -0800 (PST)
X-Received: by 2002:a05:600c:46cb:b0:483:ea6:8767 with SMTP id
 5b1f17b1804b1-4835e2cd408mr35511455e9.36.1770823858114; 
 Wed, 11 Feb 2026 07:30:58 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm6448511f8f.6.2026.02.11.07.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 07:30:57 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Sebastian Ott <sebott@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 1/2] target/arm/kvm: add constants for new PSCI versions
Date: Wed, 11 Feb 2026 16:30:31 +0100
Message-ID: <20260211153032.19327-2-sebott@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211153032.19327-1-sebott@redhat.com>
References: <20260211153032.19327-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add constants for PSCI version 1_2 and 1_3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
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
2.52.0


