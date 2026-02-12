Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE51AEDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQB9-0001Xo-K7; Thu, 12 Feb 2026 01:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAQ-0000Nh-03
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQAN-0005LW-SF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFtSZXlJPHuHUflcek1m2W3gH++5/UpYdLyjc7W8PbM=;
 b=hTit2pnKVT/HDYRSd6InyKEW8a5/z70XAVmhe/jWDNVq/hREJyCVwhWD2PwDWj9Y+FXhcj
 zppA+hAcE56PEJ3/GiN2mqh46mM5E/F8lNvp1yS7gpRk/kaJc/KyvW3wAHs0j8qHTzhYU1
 87UiL54UfGEFmrWbv22v++96UsZkRL4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-hsPXWwPqNP-mC77n9XSUig-1; Thu, 12 Feb 2026 01:27:05 -0500
X-MC-Unique: hsPXWwPqNP-mC77n9XSUig-1
X-Mimecast-MFC-AGG-ID: hsPXWwPqNP-mC77n9XSUig_1770877625
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad5fc5b2fso29418025ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877625; x=1771482425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFtSZXlJPHuHUflcek1m2W3gH++5/UpYdLyjc7W8PbM=;
 b=FC7wAprqoIXXFjnn5b/w7lARgSFxNaqjZoNgZItRpjIHhigBQKzuIVoGWBYtC0ws0Z
 tH/oCI/i5CPxpNjuWhRb3Vh+3iqG/er4tlKHxDSa/+JojQ+4RIy51Qm0BlV1m7PloWsh
 MoAeIU/1WRJlJ/MGEDJXhira8qJvCcktVzW3z9PL/Kz0aQ1CniI9cLfBCBPAqRzkEObU
 v8xDJhM0XE6j0nuqkz721n3wVQTv5ghnrZ9FVl/83tbDRdhrCmqCIYR9DlGEWpgj18cP
 MalDZVLLX3NRaH69lzrC1ekcsuoC6/J4ztNJiRkfC7irponUYa/aeh7pwzF+wPaSB0xb
 JAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877625; x=1771482425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFtSZXlJPHuHUflcek1m2W3gH++5/UpYdLyjc7W8PbM=;
 b=vLSOlYv2zbOkw21+7kW9QsZ8LV8FHdzozGbQ1WKprWz8W1i5SkuzIy8i6gc+nF4DkV
 jPoK2kfLU/YPQ0ybhiMqeab0aWC9RIp5mqo2LI7oiZHZ0OZd40tBiMkyp/zdto0rIpnI
 08TnNAJo4sjJNXYyMD70qCXF30SR3jFEz1S1GiMNzuI7r2m5lU/wwiefOY3rIJ9E2DDU
 onF9AgwoZLCYUb3tqvdtXWZ8DrPF8s5PQalvg80lkAymnu/4DaeUQHf9uTUzMFou35PL
 l4ubHkO4g84Wkr/4HWlpnsjH+SxiaVkfaBdr1czqusrCttNb/5P2+q3Q4Il2oC5sRMGZ
 dtVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGZlpPo5+J+KZMXoFWTz/Et8HgmkH8z7LXp/ZXK3aQHPfY/3BNbeMtUbzXpPHN64CljLR3iR2OXWLr@nongnu.org
X-Gm-Message-State: AOJu0YwlMmE4blckjD8lnrRCIp/3vZXS+8uvdNb4qI2TZ4KVnDHT6DlQ
 gN+JRuRdsmUMV3PGw12CpVDpfRBHjWJaaFxljxLa5Vq2XgS1UEdXKcbQQ7M5rhf9oo3ml5i6tSv
 /1MFqsj9KYu4yh+64Of30LcfFd5I1P8ntaT7PEDsZDgkatL9Qb0ULFXjo
X-Gm-Gg: AZuq6aI0SIuMZcbr8ESOvZAM1QgBaCni3e/h8K4s4vU7Zp+mODr/l3M5kCVh3F2heij
 La1lCvF3NlSWDJBaiK/cq0ZmD2qs1CQsbGyYMf4tpAtwbnOcxRGuvmlDXLUHQvI2c5iJDdRWGIw
 3pjsWsnw/gzw6SNBWRKsTLpYXCQ15bBLHSYADcB13umSxRY+gozrB2XOWQz36/6Vzfq0E7Gvk7G
 F/EQqUU7u+c7MRiqgaSbYlK1GD6eSr0CFoj8H4qepUqhTi6XH5JwJL+ngyVDPyzUekkPWBOmbv1
 0hyibuToLPhf4DinRPoRJJlG/t4aM2V8vFIAKTT1kA9mEr5xPUT7Z8pNxJUu6lfP4qPPHbM4naA
 Z7QpzSvMe314Bou7mKioEVWE8mLEZ0WtRwb/9K/hQlNYyxvwyjpulWmc=
X-Received: by 2002:a05:6a20:cf83:b0:38b:e750:bc27 with SMTP id
 adf61e73a8af0-3944cfb92abmr1329201637.58.1770877624791; 
 Wed, 11 Feb 2026 22:27:04 -0800 (PST)
X-Received: by 2002:a05:6a20:cf83:b0:38b:e750:bc27 with SMTP id
 adf61e73a8af0-3944cfb92abmr1329185637.58.1770877624461; 
 Wed, 11 Feb 2026 22:27:04 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:27:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 24/31] kvm/hyperv: add synic feature to CPU only if its not
 enabled
Date: Thu, 12 Feb 2026 11:55:08 +0530
Message-ID: <20260212062522.99565-25-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We need to make sure that synic CPU feature is not already enabled. If it is,
trying to enable it again will result in the following assertion:

Unexpected error in object_property_try_add() at ../qom/object.c:1268:
qemu-system-x86_64: attempt to add duplicate property 'synic' to object (type 'host-x86_64-cpu')

So enable synic only if its not enabled already.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index eec2f27a0f..a6b773db34 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1752,7 +1752,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!cpu->hyperv_synic_kvm_only) {
+        if (!cpu->hyperv_synic_kvm_only && !hyperv_is_synic_enabled()) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.42.0


