Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9D2FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLR-00080o-9Z; Thu, 30 Apr 2026 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLM-0007zT-NE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLL-000398-1g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxQj7dwEKsTzDxDCaWO3n7Zs1ZcbChEssKhrGqpOOhI=;
 b=LE/jCjcDaBQFCD7KH8ePX+1rtbyaMBawBM17JjEiDmLufFo4ohjRmaiPBiBFnHr4TG45FH
 /cEx7iHo90MggDZGn+T4YlcY1NB09w4J3TGQ7Pcyrmh/bzCy+QoRK/oy1yl5VMQpwavl42
 7vlNZknJpBVydfIKh7bWKI1SiGTdqV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-YYPbdiF-MZm9UprYY9oA-A-1; Thu, 30 Apr 2026 05:05:55 -0400
X-MC-Unique: YYPbdiF-MZm9UprYY9oA-A-1
X-Mimecast-MFC-AGG-ID: YYPbdiF-MZm9UprYY9oA-A_1777539954
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so7706765e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539954; x=1778144754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RxQj7dwEKsTzDxDCaWO3n7Zs1ZcbChEssKhrGqpOOhI=;
 b=NX7+RyUs32CEXwHoplDQqT+595f3qU4epPEz6Kz1T3ko7LZp58BsEQnHTlRoOpqNAC
 +WrRMFbenTKukQeOxz6ruwlglvcZO6fIsdM8BeiTDGrLSaBmG2IY0rG3FsJ8UN6v97wi
 GXDpsZ5S/8G00AcdsyXdRKPskATg2kLHcT7IKftJ1hElkVHkaXA0Q7e5Sg/lZocFiAhk
 toB23+TD5QtkjB0xV3TUaIOgIiRpgT2p8mzLopoSYg5MN1YuJwaHpGarmZ56rFi00IG5
 G0jw2SMOjBk/qCcEATFN+h1qIM8Y3GtppmiPU460hGP801BolexXClXDOMtbXcDHhbye
 OEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539954; x=1778144754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RxQj7dwEKsTzDxDCaWO3n7Zs1ZcbChEssKhrGqpOOhI=;
 b=sJ758ICH5eIs9UTEc5hLYTZ1qbblydy5Wr+1rax+VHaBJFWccuaHJnSRDX8ywtf8jf
 RcP9VY6lIo+AKo/hdI3j65ZvERKPzoC2S3nlv1sE0eWAc/oDgLKd57NVC5WCQ00fkiCg
 onuWf4s1LaTRezVCxwBkvSu1ZetioJySvRT8ZWiyvjpociM1HJMumeWR2MGMSIqXRF2D
 hqfLX4g05+rZcfUWncmeURX9cKBNLqu9MjgFcoAGBU7TgekdXbRGGCeEqWMPtYIXyLud
 fP2yRKIsOvV1T9Rn2w0GUchwzSbF8NhJqLeEVjs6lH+GP4oUhO6wBCF5vhMsy5ZXsMdd
 urJQ==
X-Gm-Message-State: AOJu0YypmciW9m9+WirJJmvl1OR4Z6W++PW+lOol5JEKGgTpZNTKit6K
 wqaiGzCh02mts7xWsNmy9UMimmlCPA/j0emjaDabj5lsv9Nqi8o/pK++0OtwAL69+b6idWUCxcy
 x3DfmonciEOmvBpji7HHqYKXs0ZpdCMcsVJuQUtih5lyazBB7EXO261wGgety5J4mm7nbeolaXw
 YAxmyr3u2MQCpebZBBn4Zke2bmz1wwwoTLhZcVSMSG
X-Gm-Gg: AeBDievyoTUto5ekx8HuGdCZMpJ3/JXxdQrYMe61F3d8W8dQWmTyOR/pAtRKwrCSUro
 eO9SF3dyJB+3YU1J8kA6Rj+8mqzWDjWBtj03e1bL+E5ETBF3+4qC13RhK5kXxO2y/+3lDoQZSXq
 2r8SCwIi51JC1tWc683W+7PJB50sdFbJ/QgfHrabKZEbKfsOfjRmoMkeHBOmDwN2FKxERIhFc8h
 5cUAveknncqdI9eeaAIV+0XBGSQkIK6zqeNgeKjxt7eEd4sVTt2liLLRyUbezljOzrSm8qwPnYU
 Xotf3o+liTQKpIk6QDwtv6nMa8ZXg8nG2ubpDekytfg0NJRIuyZtld+3DKMfELcAGknl7d9Y6X6
 C+xZ1YXOTYsIvw2LWv8uwuRhz/oE4CkUlUy0AfkUkwfIEqYkremxus4zlJ/zsEQzUZtahtaQ5yq
 6Vf+UDa4QGOj60Eg8zzsnJXTN7q5NGj29Gb2A=
X-Received: by 2002:a05:600c:1987:b0:48a:568f:ae82 with SMTP id
 5b1f17b1804b1-48a844415a9mr34928965e9.10.1777539953794; 
 Thu, 30 Apr 2026 02:05:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1987:b0:48a:568f:ae82 with SMTP id
 5b1f17b1804b1-48a844415a9mr34928505e9.10.1777539953223; 
 Thu, 30 Apr 2026 02:05:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm47131345e9.0.2026.04.30.02.05.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/13] minikconf: use .items()
Date: Thu, 30 Apr 2026 11:05:30 +0200
Message-ID: <20260430090534.841894-10-pbonzini@redhat.com>
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
 scripts/minikconf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 07a5152ef54..0806a92c14d 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -244,8 +244,8 @@ def compute_config(self):
             debug_print(clause)
 
         debug_print("\nDependency graph:")
-        for i in self.referenced_vars:
-            debug_print(i, "->", [str(x) for x in self.referenced_vars[i].outgoing])
+        for source, edges in self.referenced_vars.items():
+            debug_print(source, "->", [str(x) for x in edges.outgoing])
 
         # The reverse of the depth-first order is the topological sort
         dfo = dict()
-- 
2.54.0


