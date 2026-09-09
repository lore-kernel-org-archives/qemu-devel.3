Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E45C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JW6-0000Gd-28; Wed, 09 Sep 2026 10:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW4-0000Fz-OC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW2-0005fv-HJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788964989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wa+ZIKa32ONbC8JYjuP/+EOTZoP9I76CXnFoa7ddgXo=;
 b=RZ+3VQ0nNUSxpSUpZfq5QbDBvqlNT3F15ulKjhMsgAxh+BvRl8wLjRHiWwOlf0peuOwyjW
 qNav0AIa5EBsSzeb+9idRA+2oK3NFGPnKx2abzlK/4BEJ0qmcIphcPJwvceSwTPldlNCeS
 fXqO29Srq2C+libUnT6+j1gS+HjnTHs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-jgw1gMW2MDiNPdZy5Wl1Mw-1; Wed, 09 Sep 2026 10:42:05 -0400
X-MC-Unique: jgw1gMW2MDiNPdZy5Wl1Mw-1
X-Mimecast-MFC-AGG-ID: jgw1gMW2MDiNPdZy5Wl1Mw_1788964924
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48439ef42d8so4917279f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788964924; x=1789569724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wa+ZIKa32ONbC8JYjuP/+EOTZoP9I76CXnFoa7ddgXo=;
 b=fsMn32mowAvE9+1rY2nYK2Hv9xqlbkd9RZgCQCh59KP5wykJbc1cUHGG0XacI3128m
 MIgIpw+YmqQRBGvyIYPn57yPUBTeoCjbmaqza5ltZoK7tXYzeGHKSnn/6rrCZV14Pg/X
 PW2ZnpXwkrr0lx8OgS0CyVvH9lAYXieHuMAfzzMoeV48pHvJLD47A/vASqmLg0Qv9pRD
 uQVopIn5CXpPc2XFt1LTiBz/6w+YO8A3zYh4K3zvmjlMII5h58b34sMB06jsMbihQ0QO
 0Vs5hxCJwG4hIw1SKCwKWQQ3Qt4DQabl+D7oyXt2AfQK5AcejYqw+7zH98+3uYp60h7H
 lAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964924; x=1789569724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wa+ZIKa32ONbC8JYjuP/+EOTZoP9I76CXnFoa7ddgXo=;
 b=rpcpMb9DNmbqEis1GTKKiL+Ve1Mv+yFwi0FUJKPf4zVQ5QXxgdDPDF901VYLEYyXkk
 LoJXuXcuzc9WPp0cD+1UR64Px8S9Lks4w6ZKTnjG/neHCzkqS6KTBApB0nTOL/6ylEG1
 prWdYYKfHNUlQIKuCcwxmlyzhWL1Ih7hkWVDsJgMd/7ZMDP64TOvd5pj450/VkmVfm2n
 Fq2fn8eIZCcUruWD0bg3lsAGpcTr4ybBQIw2qUyxDzxhvy5jZpLT0QPgF2k167FYai5a
 9moxcabWUt366VshF1WlF4JkKtnPN05FsENC1+17beof4M9FZ/jDh5KRreRuuN2ognPC
 PdCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXgrVu7ug2sKDylT9I0FVn2K3ZVuCvEQh6dWq9784654YkHzh9Gy8Y/e3rNZqK5gHBwNR7mFQjIPNR@nongnu.org
X-Gm-Message-State: AFuF++ntOEZ6iXSuSlpU+2Mhi8ET+xg9F7yxPK1QQVLbmaD1cuUhzqTI
 45d8vZzri7koA0aNS72z4FvaupzwUs9y4NpeK9OhGPnXb/WDFCAv0JSQHqaR+xmV3MLzjtPps2S
 ldWC44+ZVukyAseY2OzTAS1Ld6fAjcRtZBu9N80BzQcfJhTqXkhQQejXoSuP4hgx2
X-Gm-Gg: AYBFou0K+WFmwMQXWEsAOeVdk8q6AeMdbE1I6oYaHSjuMx6FInNBKx4E0Vj5r95NLOX
 C0/AN33Ug7GV28idW0XiicHoGxDTIPRAL4R5//8UQgwsi9Ea5QtjgDji4qGpEfyZPJlFRHq8dtn
 lxZclhRY4u3ckbHyai5ZTs4bgqqejmZpyrVI65t2sCty7aDwZ8KMbslpn+ZN34xE9Buxkk+QsHQ
 ED4FT6f9gbRRovB2auYaHHfFyo227pV3avutGKIjCtpOT4Xjv+TwTHEjFZxGhwzi9xC3eofMTbZ
 5dDGgG9GvJaUaY8w1Os/0RXqcHYuUgF6PThMb4ElMIrpEiOX8wKBPlBVDIlsUWyiRtKRBtaGgJd
 Kv0efmLwXVceuqNfG2sllROtAQIbGBNurQFPbjixpc6d/S9fWuGlKYfiqkwNCk7u1nw==
X-Received: by 2002:a5d:6f10:0:b0:485:8a46:7061 with SMTP id
 ffacd0b85a97d-4858a467296mr33247748f8f.51.1788964924419; 
 Wed, 09 Sep 2026 07:42:04 -0700 (PDT)
X-Received: by 2002:a5d:6f10:0:b0:485:8a46:7061 with SMTP id
 ffacd0b85a97d-4858a467296mr33247719f8f.51.1788964924005; 
 Wed, 09 Sep 2026 07:42:04 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af0e1b00fa6b14698c8a91c3.dip0.t-ipconnect.de.
 [2003:f6:af0e:1b00:fa6b:1469:8c8a:91c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm32933395f8f.37.2026.09.09.07.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:42:02 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Wed,  9 Sep 2026 16:41:51 +0200
Message-ID: <20260909144151.26803-4-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909144151.26803-1-sebott@redhat.com>
References: <20260909144151.26803-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

We now have the infrastructure in place to handle demuxed ID registers
from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd8..1230acaff0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+
+/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define CSSELR_MAX 14
+
+static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
+                                  ARMIDRegisterIdx index, int subindex)
+{
+
+    struct kvm_one_reg one_reg = {
+        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
+    };
+
+    switch (index) {
+    case CCSIDR_EL1_IDX:
+        if (subindex >= CSSELR_MAX) {
+            return -EINVAL;
+        }
+        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
+        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
+}
+
 static uint32_t kvm_arm_sve_get_vls(int fd)
 {
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
@@ -454,6 +481,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+        /* Grab demuxed registers. */
+        for (int i = 0; i < CSSELR_MAX; i++) {
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.55.0


