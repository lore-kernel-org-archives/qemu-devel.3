Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C04C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85zx-0003D8-EZ; Thu, 24 Apr 2025 19:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zs-0003BR-DY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zq-00087z-NK
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1511835b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537325; x=1746142125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SiYnJ44kk9NCrgcaAGeA1Z13fMIq5NQl+K06XxiBL1A=;
 b=B8MPjdhcS0IbsDW9r9FPFdCnzGqK6nWq09SvZgAHrU7KctMi3mhV2WdsDuMnqIDl+e
 9pfj3uJENky+7hAPuYgAnQEsPzECk9J3MGGjOaQ0rRZKLvzLj2yPrD43O89+icSqOkje
 omh8wB4izHKxifSFK+WXCCeH0LfvFPE2aP76wv8FQN6g3Bvx4yQpEEA6gcwQKuAuQV8F
 5djgGhurG7h37fJ7m/mY0Vz7PaACYmp5tvgmsSIUtDYYo9fotnL88Px2AU9kwH8aj6vC
 1IWvAibkjXksgviGFQLQAMBLHDwwId+XzhuTXahZnamUEdl/7pRV4GYkYw+UZgojfQbO
 4Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537325; x=1746142125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SiYnJ44kk9NCrgcaAGeA1Z13fMIq5NQl+K06XxiBL1A=;
 b=M9ZYVfoKqSBPVExlYTiU5HuP2HEviGpEGnizHTKVh0CwGQ0h/UwfGYRaLFXYPRrdzV
 RnNnmLITY6UJBfbX4HnImvaBh9/fPwe6OUGPXF2hXgPpm+4GmdhgNznVoB1f83bzqUid
 VIIXuTxmh6A+szqtS890oU16cdMmoNR5uyXriktgMv8PbNKaEnDkUXl30GFqJ0iy8FUp
 3r2JGnC3g9HgoENZPICXX/7MCVWtfOkSuoQH2jUlbmmyN5OZr9Pt18/KaSKvRx8LT1Wo
 d2nW0icnE7TDagkcnc8eE2wIAube9Af5NjxsE/qrqyV8Yx9WeEnvmSELbkWKeK4QXTtC
 RK+g==
X-Gm-Message-State: AOJu0YxDpTDh8xwaUk6Jew+BLOJBwLi1YtAVEbMpvtLmNR+cCvb5jqX0
 giOAbiuNSBu3N7+IY/+D3riH2JxE1rpezJlcM8AWsP5tQn8ib8yoG7gKZt1gGJciL/1cquFAUa0
 hmhw=
X-Gm-Gg: ASbGnctgSiXUk6xKIQnQXl39okXWgTY2Mc6l903OdZh0mA7iotcgrUM9H/fttoK9Lo9
 m0PMOGzM2B967ts7av51m3Rne1dwW6LkfoF6WskPr6SGb9dyNf44ouBRmXMpnIOaJbWI3rnHz3Z
 LOR7PiL8YH3R/QhSzjPIiPswcXhNSdNj0XhzsZ+c8oZIuE1Ue8Wu1UfpRECjQ6GrcwAk6vVOfC7
 iM9ULk+99IebpyfqW6QFNTD7ghO3SBg9TKlKJhRpkOgX89i/Hipb1Gt1J9KPvsPvQHvE5mEvLcZ
 uYFsqCCbV54IaQ71403K0crxIkUO317MeKlaMxQh
X-Google-Smtp-Source: AGHT+IFxSHqiCOGNaPFpL5Pz9zgvzRwj53s2AvZo4vsG82hlX+g5LdHj7uN9QSJDob8FWejArOc0/A==
X-Received: by 2002:a05:6a00:21c6:b0:73e:359:acf4 with SMTP id
 d2e1a72fcca58-73fc7866454mr191129b3a.0.1745537325420; 
 Thu, 24 Apr 2025 16:28:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 8/8] hw/hyperv/hyperv: common compilation unit
Date: Thu, 24 Apr 2025 16:28:29 -0700
Message-Id: <20250424232829.141163-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/hyperv.c    | 3 ++-
 hw/hyperv/meson.build | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8f193fd0bdf..1197a403efc 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,6 +13,8 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
+#include "exec/target_page.h"
+#include "linux/kvm.h"
 #include "system/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -23,7 +25,6 @@
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
-#include "target/i386/cpu.h"
 #include "exec/target_page.h"
 
 struct SynICState {
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index ef5a596c8ab..d1cf781f049 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,4 +1,4 @@
-specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
+system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-- 
2.39.5


