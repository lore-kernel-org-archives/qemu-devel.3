Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811E4CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLA-0007tw-8o; Thu, 30 Apr 2026 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL7-0007rB-KD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINL5-00032v-Ak
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfcyTqIaypT6u/cAzOJ2kWQ6yhou6GkVVh5K6/RaBgQ=;
 b=eBiK5+4aib6UT0kSfNJn/NSP0r5xSzZZii6qjuNtc+skm0jmLDKae8qcRzBBnoihlqEDDt
 GiWszIBLVKJkwJ4XvUZUfrWLfMiY+R38xGnqAIiSKQBFWZCQOMSKTG/BFLtcraOf3vacyu
 F7eIHGmsIkNcmA7jO4O3eMUWR/yogY4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-MuaE6Zd6MziTRZc1NfFI9Q-1; Thu, 30 Apr 2026 05:05:40 -0400
X-MC-Unique: MuaE6Zd6MziTRZc1NfFI9Q-1
X-Mimecast-MFC-AGG-ID: MuaE6Zd6MziTRZc1NfFI9Q_1777539939
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488e097a270so4675645e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539938; x=1778144738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfcyTqIaypT6u/cAzOJ2kWQ6yhou6GkVVh5K6/RaBgQ=;
 b=LRXc2EL9ap2GEwV/OUwfoYxRdzeFupF92/+6iJ2j3YE2RsWwciWO1B10rlOtbPYkRg
 +acnIhD0xen+AQ6svykXnZ5kKqy6mJDFw6MaxqETv6CAwwd5eto/aHtx6TtOCnhqCHME
 X+lwOcl+r1JNrZPlvfW1/NBz91253VBC+o/jIkdcGaZaX2VRHAz62EMVEzr1g9nt3rW0
 GmiD/yUI71w+V//9U2icSIS1FKIfhRYDmkkCoAmI3xnTbunLeTnNLWslyYuFT0isVR3X
 ODgxBSuhfL5FYxa6OJ7eP2uqNIb2Sd3xcW07U3+fI6yLu+pCiRaLbMyDxscfCR6qMWgX
 urlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539938; x=1778144738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yfcyTqIaypT6u/cAzOJ2kWQ6yhou6GkVVh5K6/RaBgQ=;
 b=KuF4+kcq4kxBDfi3U9KVQs9eM7W8WXOO10QBqybZI/LV56eq4v09sRd7eQNzDii047
 1sEVfCo0xlqS2A9AkJkFp2jmpWMUSQ6DURJb/XHik80NoowFA84X627SWD5g/GMZpKuN
 ap1ISGewua/OW1Rg9giHWNAHCUXZvEBvNrOPipuk4WRanOi6cwBo4TCAaC+UtIPjJ8TG
 vU5EY+Qu25ORxNTuHYFhLtpe4LDuLtRQvo8TKvfyFztMQ/OXtgTyNRSVJRT+35ejYeNS
 CwtZjeXNtyjnWoZPtAkOgDtyjDYQDHafYvRZdXYTZIE7gHyt3ZQKyf98oYhQxFqxKL3/
 ZSEg==
X-Gm-Message-State: AOJu0YySh8R8Ka7NPlUAO53mdiX+/Nyytco5dbjermznywWikApcwwLY
 mrSwnz2YndcTKsuU/3bI/sJt40Hc3f+44qGJzA2JTPcpguK+rJSXDZnLsDgRbyUKC2k0Cww3+3F
 F7UU2nmYt7PcJgLx/t54Itbyfp9fGqtz7H0NW14fA84knqkqfQDugv7ZtKjTVf/HlZ48iGgKDkc
 OKG8jMTD0GcmjmYp0vqHfFPpQsJ9bxs6f8on8OO5GM
X-Gm-Gg: AeBDietdPy8W4q8UIVGXUrJECxe4US9wwQlsO/Gj9tPAHtk7sVlksgWfed2KPbvqxRz
 by8k2UoGLQt+gD6CrHfBbm9hoI6156NeP5HDi93Azldpq7ycHwJvv8Iz++GFDC9MqEaaCuwRILi
 OplfQxUtsUwDXfDpkVz/NXTRfqIA3EqiOGWbot7/ZwxuTDgafngpStpChD1067SnrjAOv8CFi+3
 lDL1hDFw+rNTJHYfC24rtEnqWk9f+P+RuBzF0UASdOg0/PPF87MjnN8KU5NWVxmkov682aWn8N7
 VPIEBdwgrWgrRSjexT0EltAC8TbxjZLRnom076Sncv228KpGLoPUXD++nwo8Bcr3Gk5BNznVypI
 H4aWiX7kL8xj//oDsqte6OVNi5dInXAwp/LD6KqtVpLNB/3jvNMoFLuq+bygN8D3H3lTxYWyytk
 tHv4+o4TEwF5MuxbZygBD0K4W9PhjHZmWoKJY=
X-Received: by 2002:a05:600c:1e8b:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-48a83e721d1mr34860075e9.10.1777539938290; 
 Thu, 30 Apr 2026 02:05:38 -0700 (PDT)
X-Received: by 2002:a05:600c:1e8b:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-48a83e721d1mr34859215e9.10.1777539937673; 
 Thu, 30 Apr 2026 02:05:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c3058f6sm37268795e9.17.2026.04.30.02.05.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] kconfig: remove duplicate declaration of CONFIG_CXL
Date: Thu, 30 Apr 2026 11:05:22 +0200
Message-ID: <20260430090534.841894-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Kconfig     | 1 -
 hw/cxl/Kconfig | 3 ---
 2 files changed, 4 deletions(-)
 delete mode 100644 hw/cxl/Kconfig

diff --git a/hw/Kconfig b/hw/Kconfig
index b3ed092f7a8..c109f5537b2 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -6,7 +6,6 @@ source audio/Kconfig
 source block/Kconfig
 source char/Kconfig
 source core/Kconfig
-source cxl/Kconfig
 source display/Kconfig
 source dma/Kconfig
 source fsi/Kconfig
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
deleted file mode 100644
index 8e67519b161..00000000000
--- a/hw/cxl/Kconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-config CXL
-    bool
-    default y if PCI_EXPRESS
-- 
2.54.0


