Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24091EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvG-0005jm-89; Thu, 12 Feb 2026 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXuz-0005O5-FJ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXum-000651-4Y
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMvh1T7VSlWdNvOAnSK+e5XNAASrexQ0cLNtJxfMpMI=;
 b=AC7c7RvP+uFL3XB4N5gx+42vHBJQVr9NfaFUCS7zq1Q9QsFoXm7zy52jDjPQ2/mt7Qo/bk
 yj4EAevj4RW+yEa7SxBG/suTQlRS48isHCcAB/1JjjGkdWb19GEPI4+JIF154TSxKcPNBh
 4APLf2DrUOxyM7fp14hC7Jp2E6QQux8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-PHNLb-qYPbyf94BUN4bywA-1; Thu, 12 Feb 2026 09:43:29 -0500
X-MC-Unique: PHNLb-qYPbyf94BUN4bywA-1
X-Mimecast-MFC-AGG-ID: PHNLb-qYPbyf94BUN4bywA_1770907408
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836b7fbf4fso5777185e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907407; x=1771512207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMvh1T7VSlWdNvOAnSK+e5XNAASrexQ0cLNtJxfMpMI=;
 b=PU5gYeC9X3107F2S11cHQP65nXQMqct+6ypm4RwHhnQ9/3POTgX/TWE1cszqcFuvUm
 j/Sbsh58oR3rmx9aQDJ1bmnkgMW/7exQz+NVZ6xFPCoGY7ISOntav3AH3N51z93KIM+D
 oTAUmJZmph0HEeDzZacWnI9+N0pv+9DB6O3tSM84KTxkVLPplCu8fHWpnVMtVJQKTz1k
 DL7de6QabJADAnlM7LIJ19OYYcruPK+i64tkHT2ywk9fER6sEb/8xUr4pIrWZo+s6h1i
 Ds434ZQsSLv4iZt+b6Fu1+rs4JnUppoxHt0zAUZ3cmJZqNss8FVyLdv0FpVEpGVivgPM
 kaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907407; x=1771512207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VMvh1T7VSlWdNvOAnSK+e5XNAASrexQ0cLNtJxfMpMI=;
 b=rt3IvVOjAifg4Cl8I1dtTrJeyXfPVd3Qz2eLtKHWuYgF63sMqhd8TevDJE1YnO60rF
 C7HE6vo3sH+irva+Pgs5DaD3uyGNjL0/Y8Fv7WL3My13W5qM9vk1/QuEpr+uPi2oE7mH
 jiFz1xcEKC2WfznAQjKJYlCGqt9X5kCkSmz0tHr/CkVfgmS1sTnGnZTAZJALOA560ITt
 FhcnAgEfyoduV9uUZtIb2TFv9Lab99riZT8TXuvYrLkzVLkIGFyhDI9MGf8FGOeYWn2S
 f0A+qqWsF1n08iyuM5Nt87r/bmXh31TEaX3XV6m4JE8Bqj5rAeYUxBRlwgDDckFNdMP0
 a7nQ==
X-Gm-Message-State: AOJu0YwjQp+Q6z3T6H/qEW8NlPOMdtH1B3aYPm9aN8MdtVRriHr5tj56
 CE8xzJ0afRiH1Ibxxwese0gMHeydalbQph3ZKEM9f1c/2dx5KNFy4dptRnqd6PEpg7a5/8c5oEE
 LJLjZCl+w1oLTYFkjAtEKq+gJ9ttF0s+RyVsEQVxlAf+Df2f1dvJZY3LwcOEGxZvSpAq1ZyqYDN
 5MwJDP7iUXKYwllg3/9GkzZsEh9mOBa1yHTFkpAt/p
X-Gm-Gg: AZuq6aIbqNlqo6dFxv4P+P+uKeNgiILRY3Uzf3nv/MWXBcyxZynQHAdYWj6oNCEPWUD
 pdCKAOH3q/9h4PdK3UVMaob6OHDmH/dqLwbMumZ2n31q1d4nWyRGFegUREJS/QLOj1UI6nvZv57
 82S31FlBh73Kw/RncDp5z0ZyRYtWiElOJ46EVViu8bOic/beQm/SkhcOfGs1tb3qcVJxSBMkmDT
 5MeMznmFKwDnIzGHHttPqH2hRqagy4EYk2ptIf4+Wo1fEcEm0ktQayblzWcJNFR+E9NVaxN7oTJ
 KEoVUatdUYDhy6lfVv5N7UPv+fCEsv3T1PSa3ZYLSo+5TCh/NhcwDh4uUeZ13I6e/WHKbUSwfbm
 7VH6Z27S/t1xtOQCBqFTMfwuJG9xoGdrdHxrbDES3sIBTudoCH0IDobOooHqWtAOi0zJPo3uUSO
 2SN2aQvi+eQnngT9W3pxWdsUG5RpFmiHxk6xxocUyTKKTOTUJiIfQ=
X-Received: by 2002:a05:600c:6095:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-483656cb1b1mr39478525e9.14.1770907406995; 
 Thu, 12 Feb 2026 06:43:26 -0800 (PST)
X-Received: by 2002:a05:600c:6095:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-483656cb1b1mr39477915e9.14.1770907406494; 
 Thu, 12 Feb 2026 06:43:26 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm125281235e9.14.2026.02.12.06.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/41] hw/intc/apic: Remove APICCommonState::legacy_instance_id
 field
Date: Thu, 12 Feb 2026 15:42:20 +0100
Message-ID: <20260212144244.22579-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The APICCommonState::legacy_instance_id boolean was only set
in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
property. We removed all machines using that array, lets remove
that property, simplifying apic_common_realize().

Because instance_id is initialized as initial_apic_id, we can
not register vmstate_apic_common directly via dc->vmsd.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260108033051.777361-18-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/apic_internal.h | 1 -
 hw/intc/apic_common.c           | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4e..0cb06bbc76c 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -187,7 +187,6 @@ struct APICCommonState {
     uint32_t vapic_control;
     DeviceState *vapic;
     hwaddr vapic_paddr; /* note: persistence via kvmvapic */
-    bool legacy_instance_id;
     uint32_t extended_log_dest;
 };
 
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 4e9e3089945..bf4abc21d7b 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -276,9 +276,6 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
         info->enable_tpr_reporting(s, true);
     }
 
-    if (s->legacy_instance_id) {
-        instance_id = VMSTATE_INSTANCE_ID_ANY;
-    }
     vmstate_register_with_alias_id(NULL, instance_id, &vmstate_apic_common,
                                    s, -1, 0, NULL);
 
@@ -395,8 +392,6 @@ static const Property apic_properties_common[] = {
     DEFINE_PROP_UINT8("version", APICCommonState, version, 0x14),
     DEFINE_PROP_BIT("vapic", APICCommonState, vapic_control, VAPIC_ENABLE_BIT,
                     true),
-    DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_instance_id,
-                     false),
 };
 
 static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
-- 
2.52.0


