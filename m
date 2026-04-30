Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D781BCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIMqk-0001dx-9A; Thu, 30 Apr 2026 04:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIMqi-0001dh-GE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIMqg-0002oz-Ly
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777538056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MUtA+uumBY+qTwr3NGmqhzZXW+/h+VjWRsJLvXv5SW4=;
 b=aY2D0Woei9XUAZh5uEmrEmxZofRr60XiqYudICoTBQv1NAJAdTGBsyanBPngvIYcftmQeS
 fLFCdjeVC22sIhimDrI8JFfdZQmIHLxSObrR6ScrgjsrMakZ4ixRCIP4ES4I7twBmkGuIH
 p3YdAs0xwoRUL2dSoB1i9eJaDjntdTk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-i0hX56LMPfyHmRY-yz3DvQ-1; Thu, 30 Apr 2026 04:34:15 -0400
X-MC-Unique: i0hX56LMPfyHmRY-yz3DvQ-1
X-Mimecast-MFC-AGG-ID: i0hX56LMPfyHmRY-yz3DvQ_1777538054
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-447f2ce5556so387570f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777538054; x=1778142854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MUtA+uumBY+qTwr3NGmqhzZXW+/h+VjWRsJLvXv5SW4=;
 b=jTF8zFX/EowBt4h+eginAVIVZ25x/cFxC8+MqDNbq3X0guv4kiKdFe69fh8Gr96grq
 AedzQBVXiUWKsZv+quIWDl027KdfZ+Y9YqobEFpolokCKaJbgmTS52lPeAg/xgnFR890
 NRU9JbNfUa1TkWP9Q9mafMgyYuLQ5/UyuJwHxLa9xQZ6CwMmSE4n+aEp01V1xHFm4Tbl
 I/5FHSBcX484sj9RIHA5/o979ff9WdUaO+VF1JiDAgObcberxO614vEndQRFITVWJ7j8
 zTEDY/G30X69rgSDSZnn+QEKGX6HC+GZ5Z4jRFglCTWB5+6YQ5S6TUPwkjG48NJVGqzI
 rlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777538054; x=1778142854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUtA+uumBY+qTwr3NGmqhzZXW+/h+VjWRsJLvXv5SW4=;
 b=g+5zBzTs4CZGsGhzXzhx1s4lOO7B0131KZe/PizCZVicoxURvhtUr/z3Fn4U6/EuDY
 rxzaqcJzg1vfY0J3Sc8i4lwGoyzie8p83XOHVPdxfEsaKaavYtmL4QgtWLOdmMG+PUmg
 BlHEDSNY4oXCOufxHXjMZW6SE4H1IKBdAAI9Oe7M/UH6JtOuM4XDelEdilxyPfm9TZ2a
 R2aP4Lf/pYNuimz4n/rWoMZryPwnG/69ihR2UHRYYwtUbxVhJNj4/JWVmr3Wbd/X3gI4
 orZ7k2W2u8K5yez1P3/HT1Vu7XWghtVT28yuvSrIJ0hhRMHMcUobXTZxFC33CcU9Ttkz
 vsNw==
X-Gm-Message-State: AOJu0Yy4LHD1EZ76NZfdxRCo8UA8B6ts0KI/3LK3V0eFOtJkH6aN9K2/
 XjiChoHHzA0NPsoPCJNg7LGeXdOxDjTo9fqW5zPQHQhBQvOJamB505/SBavL+nbR1nPqglJ6z60
 XR0ai8hozCDULxqfihE+o8y475h1oCeQv0CBGZrnpOC4sbvd21R2XOaqahysug6HWa2wcv7kTRu
 Vme3dE7Q0j6ISL9dwwrMaqts8KYacqF1X+9ZcSFUHC
X-Gm-Gg: AeBDieuxUiHkHnri1M3cFLY7pvunNG9EgeYpgi8wF/zp6kbz/byw4v83x2qnk8usXLB
 CbfPjmUlDCW3PhOxSLbSzKXIyBPeAFYy0HL0jIfq5tkfnS16xC8Y8ElbBS8Sz9SradoxpGcUQws
 N2LpWhslMesjPmpFWmu4Tp7ynBQdVyiHQsN7EmYa0ZqX8OaWdFGeMj1li3F/56UWvWFNDpop7ib
 EX8QMnqSN9+r9DR9LSOS8SsIpD50AxrsJF6xIRj81wpNvNvAzZUICzkkrVgxaOhCTCwvkSYZNja
 nKExVvWVs8Af/Z1iC7U5AOeXiE/IWAojFIicQnKj7n3z/eds4nC3Sk6OYuVn/DjJUfp9gAHl4tJ
 QfV7DVA6+6n2I0i7EvqG01ifanF0LIjfujkZ5Vo4vYyMkTNOOdTeuK/9gmF0qdDRtXxNfb2N+7e
 FrJalVbgRUMsZQ5Cd/jZ6jmHIOloyXLp6l0e0=
X-Received: by 2002:a05:6000:4284:b0:43d:7e34:889c with SMTP id
 ffacd0b85a97d-4493f522a94mr3120623f8f.39.1777538053781; 
 Thu, 30 Apr 2026 01:34:13 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:43d:7e34:889c with SMTP id
 ffacd0b85a97d-4493f522a94mr3120542f8f.39.1777538053188; 
 Thu, 30 Apr 2026 01:34:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca664csm12028263f8f.35.2026.04.30.01.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:34:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] pythondeps: require Meson 1.11.x for Rust support
Date: Thu, 30 Apr 2026 10:34:11 +0200
Message-ID: <20260430083411.807762-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This fixes plugin and module support, thanks to improved support for
passing linker arguments via rustc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pythondeps.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index d0e86425313..47d4caefa90 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,7 +24,7 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.10.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.11.0", installed = "1.11.1", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-- 
2.54.0


