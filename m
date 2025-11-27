Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B03ECFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObt4-0005UY-6Y; Thu, 27 Nov 2025 08:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0002jx-RL
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqy-0001Iw-Tv
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrToXuxWMQX+VSlgPV4t+2UnY8wDDrkLi4Lyow0yjpk=;
 b=fxars/F5Rg7SFg8NTTYEiXCCbH1Yz7UeOvy6ElXjE9Q0I1s4K0MGq7jjAGSjcsLYN3owei
 SYRkGhJRzPmmpweX2AudEp6ZzCzO84xbOHj37IaPqLkzFSc5iFddl6C3COS9cL5Zwu5lOw
 A3RnvNGvYT12N5QtJIVp9WlEWHeUS7w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-YyZ5tEDqMCGvZQB6LLCpvw-1; Thu, 27 Nov 2025 08:16:05 -0500
X-MC-Unique: YyZ5tEDqMCGvZQB6LLCpvw-1
X-Mimecast-MFC-AGG-ID: YyZ5tEDqMCGvZQB6LLCpvw_1764249364
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b72a8546d73so103139966b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249363; x=1764854163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VrToXuxWMQX+VSlgPV4t+2UnY8wDDrkLi4Lyow0yjpk=;
 b=q0IUO1rHIgUe1eWpHcj7Dkx5NJrWZR2u2rOJkHekMrWEqcu0xWPeD43HQY0yDMDUEB
 zQdA4N1jB1a+Omcncmh8G4wABVyqy3Ntf63e1TGL3XMI5FEcXDZ+lQ7XxncwZ5kVjmS3
 83Uk8xfs+fe3NXnIhSlIAmooMKR1DarMexkgvC7GtiLWeiHW9MKNVjK/7qYy75t+6AVi
 DYW7Xk/BTlx85EE2NFzNLnXvBuNWIPwxQ9EoC6OTz9gCXG0F/Inb7VknazPXt9eK2asm
 OVqmA4rgPVSL+U0Cf777pAleIMr1nvRrplGflbfYZa3MtWJDzBIWWFAoOeDYZxS2qnqk
 6CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249363; x=1764854163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VrToXuxWMQX+VSlgPV4t+2UnY8wDDrkLi4Lyow0yjpk=;
 b=dkKNWsysbmG6SDfEU8A0YXkaW3LxX59y4QLOBHakMqGBktH6WmjyM216KZOuIdEIl1
 nRE8oEJLKE9Fb9OsW03KmZhzGK9LBWY+rajDyi86uGOd6G0w4iEs8M1AR7kwQuDJKo4z
 jGCG3UPe1VjpvatsTOzb5mYWqvL3QsGBOXA5vws5sHfL8+Vn1sFhOEqRxdjlYKR0OIUS
 iiOwmMqcTFnerhv1vTIExqQ1LuJPrhO1BXVcmJ2RlsCM+6clp0zd63uON14JasrEfnPk
 rIU+6dKeNH3gui+mHaZIsH43Tl/5jSn23H47FwgUeEAiKiPJSncjMryp79+0TneYyAnS
 QoXQ==
X-Gm-Message-State: AOJu0YyE6Sj4jFRQDIbLzPugXn2Evtdu30PF9+hULhXL1tCvWA7ZSsf2
 qKZtyH2KKlA4h1Q6PhudwO3cfOL8KlbmbDApCKgK8rFw810YYLRvUuZoMRo6MZjyFP+tKQIZxdt
 DTGQDynXMhqZ/LgA5fr0tzpR/GZUkMi2wppOxHOUAXHmCevZaiS6EfWHmsZ1Rw3cDkH5FEogk89
 146Gh6B4QwzTJGOs3dRguz81oR3AM4zXjxj8F8+I4/
X-Gm-Gg: ASbGncuABcmYJBhpT0yo9YcEtoyzAYH0bqrgQmWzB+KlacwQM6ymqjSvrhDOrhcpr48
 08sSH5NtS4RcefS1Bcp6NlxrVFHyrI3ABzzUfxq625sMlNvpAE+7abKAnkadCAVIcn2SYvX9n06
 i4UaPebErHqYX5GTii7Uet5PcdzZkAAX78HXIqzMfHl3SiWkFOxTEIytXYSJdW3uIMHmlKs/ZCn
 bfbgoeXcmF76vLRi+9NwDIo4P3RHj66b5yrAgBSJFpiF24w5o8c/uqUT/1DlXbbHIZy3CedhABs
 MjBUvrdKMr+6NsichOT18qb/chhtmLATeyHCr7Dn0xZo9TlUgjBYteIFRXd430M5GTTq4UHZ4/G
 fNdLv5nBVXs/U3Ok5qgiybpXgWRou27lLOQXCIfse+WWbRWr8y+3pNbo+JFfVmU+HQfy6ytP81V
 t9dnJl5XaDVJ/zmW8=
X-Received: by 2002:a17:907:968c:b0:b3c:8940:6239 with SMTP id
 a640c23a62f3a-b7671b12672mr2645630666b.52.1764249363399; 
 Thu, 27 Nov 2025 05:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR4zAUtB4DxYLxMVzjdn/2JS54LebqOs/4YoSUFB6HoNTN8BB+vMQ0qzr1abDd27DwPQ4zSg==
X-Received: by 2002:a17:907:968c:b0:b3c:8940:6239 with SMTP id
 a640c23a62f3a-b7671b12672mr2645625766b.52.1764249362929; 
 Thu, 27 Nov 2025 05:16:02 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a7b4bcsm153020266b.71.2025.11.27.05.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:16:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/28] include: move hw/vmstate-if.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:13 +0100
Message-ID: <20251127131516.80807-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        | 2 +-
 include/hw/{ => core}/vmstate-if.h | 0
 include/migration/register.h       | 2 +-
 include/migration/vmstate.h        | 2 +-
 hw/core/vmstate-if.c               | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/hw/{ => core}/vmstate-if.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72c70a46553..0a70bc03889 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3656,7 +3656,7 @@ M: Peter Xu <peterx@redhat.com>
 M: Fabiano Rosas <farosas@suse.de>
 S: Maintained
 F: hw/core/vmstate-if.c
-F: include/hw/vmstate-if.h
+F: include/hw/core/vmstate-if.h
 F: include/migration/
 F: include/qemu/userfaultfd.h
 F: migration/
diff --git a/include/hw/vmstate-if.h b/include/hw/core/vmstate-if.h
similarity index 100%
rename from include/hw/vmstate-if.h
rename to include/hw/core/vmstate-if.h
diff --git a/include/migration/register.h b/include/migration/register.h
index ae79794cdd4..d0f37f5f438 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -14,7 +14,7 @@
 #ifndef MIGRATION_REGISTER_H
 #define MIGRATION_REGISTER_H
 
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 /**
  * struct SaveVMHandlers: handler structure to finely control
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df57e6550a2..84775474277 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,7 +27,7 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateField VMStateField;
diff --git a/hw/core/vmstate-if.c b/hw/core/vmstate-if.c
index bf453620fed..c39631c7586 100644
--- a/hw/core/vmstate-if.c
+++ b/hw/core/vmstate-if.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/vmstate-if.h"
+#include "hw/core/vmstate-if.h"
 
 static const TypeInfo vmstate_if_info = {
     .name = TYPE_VMSTATE_IF,
-- 
2.51.1


