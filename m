Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE42CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3et-0002iI-27; Fri, 26 Jun 2026 06:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3er-0002am-Mg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eq-0005Pk-3V
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9KU7ssH9wWsLEPGIbswP0xc8v660m5Ls1IHSY4SE5E=;
 b=fufBEBhLkxnByp+xXm7CkTvtT1qJGgjzwFEuzfhqvxQXsWS23Yr2NW1AyxYiwGZyLOuJat
 IWfGnv5HEmBrfgqnxo29IAMidvJf7sTC+Dltt0tTUn9YuQCRuOgCiSjCQsJTHrxaVZ9ZYG
 y89z+pMozEhlp3fDO2lYk7crM+5uqIU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-vfqNIp_gOT6t0j1DiRzZew-1; Fri, 26 Jun 2026 06:19:34 -0400
X-MC-Unique: vfqNIp_gOT6t0j1DiRzZew-1
X-Mimecast-MFC-AGG-ID: vfqNIp_gOT6t0j1DiRzZew_1782469173
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-469675e37e8so448152f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469173; x=1783073973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9KU7ssH9wWsLEPGIbswP0xc8v660m5Ls1IHSY4SE5E=;
 b=oTZjM/wC/zrgREvHPQukFaMBvbR0z/UMUzcQkaXARse6dXHpH7Y5VYHWuUhYV4rEW1
 Ohng+BbUqJQxM83EDZqZZMbmToWjOScWA+4/6zGMxO+tS4m4O5YXnCZwdfe7HgEqXp78
 xqkqkSldcG+kaFROuHjNuQQzYadjxsUQonL/lyw/rTe4QNa32Aeqx4CykkSJdwTCBUDf
 OVvIMRBtvCEfo+qRwqjZkBuFXWJh0mj/zhgHa19JZjxMoMcybjSMaSRunKVBot29896R
 TyL6pEmXwzNHXYQoenytwbbVfyKJaGVziwtip3jWl0kV0CKLNnfZEtX2L+N5rvnVsmOg
 bXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469173; x=1783073973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E9KU7ssH9wWsLEPGIbswP0xc8v660m5Ls1IHSY4SE5E=;
 b=oeEfVhYN0P+u+vsk9bMv3LPtzwolQa5rmEYo4zjbjeOmKwj7z9PRP6j9l0ysq422aD
 MtyVfbCvXjbvarIYud0nou16uU4sTgW8haoX8+1kleOE20brv037AR18lIgma1UjrK3n
 KWHCmhe9GJse9JRYJI0nd78bCFMBjm95QbZYeljwirtBz/3INZBbsSkBfmURw/pIV8Yk
 s89qiysFMPntpPEHiKxrEYCzRRxnOXQpoxbHoQw8+NxsskdCPTwPoug5jVIwgwHSuVE7
 Nx4oyKsMcaPwUg59G5UOkreyD9OtXNbt+OieMb0z1lmMpF2Yj4lSwdK3jrgfJoVOvexk
 utPw==
X-Gm-Message-State: AOJu0YxAh0iTSYE9IKRegdtzEMIs3e8fxOxTo0L7+8hrHUBfvmLrTtz3
 YC5W+zG0t0QUQNl2qOkXMw0wVdVkGcijltEo/e05rGffx/EADNccu2gS4Oly8QZyrbIA+tdGbxx
 tmnMggX4lbUg6ZSpl/sQry9smp/acKa9VFHSRQtd9/oNqCKAoJj+W1nHjVDga+4+ceZsN5lgynu
 BcSnlsNmpXqJb6pJDib6m9j2JGZmp/lSZav7g3ld3+
X-Gm-Gg: AfdE7clWYo523/qM/XXF44swb+cIS6KxmpXdwsuqfcXiBc++cpKX+sbKeDUOw+oeAxB
 nqyMjFitxrbV6uoeYxyVTabJzqr1XG5xAVJnnP09/PMNSWBXs/MvS3nYVZAnrjFYK33U7HEYzxj
 1V0qkhqDngRNm7ESSO3AXZvXRRPpBicEYHjumbQQypm2x1dYyQy3ZzyQZoXQ0L38lcZ/gCT5o6R
 QEghmagaPZfaHbamH3/rY0oGlRRKEjuVs0Iqmf7A56cTmHaKV8rnNbPp5aGZT3j00bffrE2HVZQ
 zd5N1Dv5XYs3rBi/R31EMtPJKguPK22+63e7mo9bDmvmT3ajOtnDANJDZwGV0GQfVuCuFGu7Xof
 lGKw7vNfeiNlDilbfzC4YWYPHThwZHkxy1QT3lOiAQDm0NAVXb3l1SfkXcZthATpaSC9GWCXZHE
 yUWbtSgIQS9FGxy4ss
X-Received: by 2002:a05:6000:4012:b0:46f:558:a429 with SMTP id
 ffacd0b85a97d-46f0558a957mr3101747f8f.11.1782469172838; 
 Fri, 26 Jun 2026 03:19:32 -0700 (PDT)
X-Received: by 2002:a05:6000:4012:b0:46f:558:a429 with SMTP id
 ffacd0b85a97d-46f0558a957mr3101684f8f.11.1782469172306; 
 Fri, 26 Jun 2026 03:19:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dd5f9da4fsm14912211f8f.23.2026.06.26.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 38/45] i386/sev: Remove the example that references
 memory-encryption
Date: Fri, 26 Jun 2026 12:17:41 +0200
Message-ID: <20260626101748.1728079-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

"confidential-guest-support" is the recommended property to configure
sev for the machine, and amd-memory-encryption.rst has already switched
to use "confidential-guest-support" in the example.

Instead of changing "memory-encryption" to "confidential-guest-support"
in the comment of struct SevGuestState, just drop the example for
simplicity.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20260512084458.622465-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 99cf30806be..debe6344ab4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -160,10 +160,6 @@ struct SevCommonStateClass {
  *
  * The SevGuestState object is used for creating and managing a SEV
  * guest.
- *
- * # $QEMU \
- *         -object sev-guest,id=sev0 \
- *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
     SevCommonState parent_obj;
-- 
2.54.0


