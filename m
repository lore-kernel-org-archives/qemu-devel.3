Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD5FCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3f4-0003Yd-MS; Fri, 26 Jun 2026 06:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f3-0003Rq-7L
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3f1-0005SI-F1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h42x0Bdf/i8YC+kFDGxCSDxey27JESfBshEXAUKWWpA=;
 b=WMw+Qt81oArV9XbfpoFbu0gz0L0IoO471y31/mFSnUjGvM7h8dX0DfVIjroM1MB2shfZUr
 9QZWCDwMHVhqAGTIdX1kY3y1Isad1VbmrgbtgFm5YHHVU728p3trWSjljDPm6uUaibaD2b
 AVa/ILgYYMS5iW4fX6A+edtVjRcXQdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-tAV4qKoCOcyA_HrqSu66sA-1; Fri, 26 Jun 2026 06:19:45 -0400
X-MC-Unique: tAV4qKoCOcyA_HrqSu66sA-1
X-Mimecast-MFC-AGG-ID: tAV4qKoCOcyA_HrqSu66sA_1782469184
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-463aaa77ffeso442030f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469184; x=1783073984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h42x0Bdf/i8YC+kFDGxCSDxey27JESfBshEXAUKWWpA=;
 b=OoDk3tp9DJyjC1sSibtq2J0xQf0JrjwjtMfVquffFrYFp9WFDfS2+800ho3GMbs7mW
 j6GegXGqK2DrMK+j46E55OhY7B+qQm/WVmq7mEABREo69yf998LXXkf/9AhgUrcEblId
 P/1U2l5ejSSqjrm0ic8aqrcleJCg7aBavtpOo0pchvORt4HQGBMpQy7leln7hoZqrhHO
 snM4CtOzJUQ3ixsDOQY9nKpHUbNYSRrKcjlwspdVUgWqbHGicVT5YgLGe3SMJLKRj4x+
 kEbwa64GcON/wl3k3M0g1v/c0Tbi4Hi4080ffqEUUhYjQYoChI5NZ1FyR3+jJqwKdu3F
 iXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469184; x=1783073984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h42x0Bdf/i8YC+kFDGxCSDxey27JESfBshEXAUKWWpA=;
 b=OEiQ0er8pnLvAuexB8F8fB0acizVGo6i1qaqEodkJbbgow/D9yafqz6bisCmoI2Dt9
 Ph2iT6wU9WuGimScg3Y8zWtT75GCkPdUEk1p8sjuZtzraSqlziIurR8ds+SRjH/uwVlQ
 Z28EZ01fbWyIg4VCGn/Z2RZj0QakgGo/g48UdWMnya3wtlR31yFQzfCQAttW2ZE2TV8S
 zfiZ03nIus/fJZXqTN+lEBlhs43fOkAhbHo3s7kSkEWjFxi0i5a4CO72EaOaAKzZP2GO
 3NC+ddCZjWdW2vHQwoHlI+h75hDol7ZEqtBtcy7gR197cWIbQhLIcYxtP8Xq7lk/G2rU
 yPzQ==
X-Gm-Message-State: AOJu0YyJejST51Qpov/QbxL4Z9amCUf8cUkG0twAtOIIvW1cw3SMtvw4
 Mq9TUFLgVhAkclOyuez4WiABcqkEMUHVACp5dBiChdNS5Jeacb0bYi4yvjTGUb2dkz9r2zWO0m+
 u/jZ0lXSRsU65EJXyZBQzJnfE18/H+hzmtqmkMx8FXynf4yAjxZYm++xSvZ5/c+qyN2hmCt0NXi
 VGfH5zqLCZ5tl2pVld8QUQLIdLF21LOI1lq1n3o3XC
X-Gm-Gg: AfdE7cnh61nMNtIuswu/x3x8WBdmAwRKUGaY4LXkq7jNS+5OnBf3zQu+4Kiitbjcy1P
 ni0h5F+ALtk5kE6P67b28pZQ10b0y98fIVC+P0aql0HhZRWK5+EyedfgVbSvt/D1+ZA2kgJvYNz
 sbRHiSJILUb+04Fc+FHfQOLuLQV2qY3RN8FJQ1MmLZzsDXBAdJy/394kLMsSV3BEVSyKlrkfXvn
 nJVpX2VB+x6EjonJg7Ocu70xb91PsRC2Mi6cdaGGu//7UFzvatKlqbSs2qVN7TnMjok6zE5nbWC
 /J5S1YZbDwgpSVrKQAAjHq0RexxkL6wRLL+SnQCjBCxXPu2JNkY6RL0DgqausyCkowMeybVe4SD
 CUwVT9gkNpT70O4MvrBS2YfgPH3CwNlAExUnWO6y1eE46M/cPH62pP07uBoSE5WQysZRW6LiM+c
 C0++UCH6IcZiTrtgr8
X-Received: by 2002:a05:6000:2c0e:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-46dbed35f0amr10059228f8f.4.1782469184120; 
 Fri, 26 Jun 2026 03:19:44 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0e:b0:43f:e2b7:7160 with SMTP id
 ffacd0b85a97d-46dbed35f0amr10059181f8f.4.1782469183685; 
 Fri, 26 Jun 2026 03:19:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46e3d6ba143sm10723272f8f.33.2026.06.26.03.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 42/45] machine: Deprecate memory-encryption
Date: Fri, 26 Jun 2026 12:17:45 +0200
Message-ID: <20260626101748.1728079-43-pbonzini@redhat.com>
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

We've had 'confidential-guest-support' for long enough that no one should
be using 'memory-encryption' anymore.

Deprecate 'memory-encryption' by adding notes in docs/about/deprecated.rst
and print a warning when 'memory-encryptio' is used.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/qemu-devel/aMPYkUsytGxLPIM7@redhat.com/
Link: https://lore.kernel.org/r/20260512084458.622465-6-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst | 7 +++++++
 hw/core/machine.c         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 97750f5edc9..cf3e1a007c7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -249,6 +249,13 @@ The RISC-V ``shakti_c`` machine hasn't had meaningful contributions since 2021
 and is currently unmaintained. The machine is scheduled to be removed as it
 appears to have no users.
 
+``memory-encryption`` machine property (since 11.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use ``confidential-guest-support`` instead. The ``memory-encryption`` object
+was an early implementation of memory encryption support in QEMU, but it has
+been superseded by the more comprehensive ``confidential-guest-support``
+object.
 
 Backend options
 ---------------
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9a10e45aabd..5b97df6db96 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -497,6 +497,8 @@ static void machine_set_memory_encryption(Object *obj, const char *value,
     Object *cgs =
         object_resolve_path_component(object_get_objects_root(), value);
 
+    warn_report("memory-encryption is deprecated, use confidential-guest-support instead");
+
     if (!cgs) {
         error_setg(errp, "No such memory encryption object '%s'", value);
         return;
-- 
2.54.0


