Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34BAFF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV6H-0004iu-Fe; Thu, 30 Apr 2026 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6G-0004iG-8u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV6E-0004Ka-S9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwLn/+Fz+FAvY2AzGsxOyV0kt7HIqXuwdyCpv9bLPMs=;
 b=gGdqpXDAAWFjmeFOxs1nx9a+xRmq979I3Hjc7jqkxdYt1wW3N+PNTomYY+kgAiAPs3zBbA
 6bG4ArQl2eoCwb17soVC0xPkDZLn8BO2udNnx7osLN3blqMqj8d+b4HGs2up76lMM5PQo0
 Kdee3YnSAK4LgcVOY+1W+qPRywhnRaU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--cUGn9F3Py6YZzNZdM4q7g-1; Thu, 30 Apr 2026 13:22:52 -0400
X-MC-Unique: -cUGn9F3Py6YZzNZdM4q7g-1
X-Mimecast-MFC-AGG-ID: -cUGn9F3Py6YZzNZdM4q7g_1777569772
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8ee9a11aa75so257973685a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569771; x=1778174571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwLn/+Fz+FAvY2AzGsxOyV0kt7HIqXuwdyCpv9bLPMs=;
 b=PGaFscp+oAi5yhUyPgO0TmoHhx5bW541/eDDFRQ2Ptog0gNpyoJRO3gtOr9+mPxPuy
 8TYaOQ3p+K2IVcXtuAk0tq5uZLGK10tuM6H8dI6SNiqNTPRgu2EbLBtFwxyevLyGsw76
 XWkJYQb5Hyl3G44MNwf8VnPHjoliQ0MszQXfYUks0yCtBFL4bYQCGiBQ/ofAocB2fNr5
 3/ZgxFKqDsOmcnGgUvz7K+/bCu3bY5S2BVyYenMcSc68845ikQqGPIArHYkjtiFCVJp3
 8AfKtVDDHZSsTH7i0GBwjV5Z9wUT49YopCcw20eX5FejevPJZhuVReWFpBiur3+VZRcK
 mIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569771; x=1778174571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwLn/+Fz+FAvY2AzGsxOyV0kt7HIqXuwdyCpv9bLPMs=;
 b=DOAo70nTJ8Eg8lTcL6J3/zcV9PcqzV5Gk5V7Zxnrgg0h7TxPzgpWrb28L9pnLUWQAu
 +YeuEc+NUOWvzYCif8YSrcKjXf+DBGOpRoBQqF+bqISIuz+W1ZYKfzE5g9o6ifXrgNQ9
 CeQvhbQTMn1y4Egd7PPY+kckwPHCMQiLKu6JkB6MMpR/m9PprDLvMSF06ygivylIASIS
 NvyS5KxZMSvLsrcUwjBzghPITVqnmJRYcFjHqHA5ZrCEBYOh6UwPQOgKB+MoF78IXAz6
 E0O99qgR3ODWn/TO8oyYWJ5HDLtX8flfqjFPbzEDgJMxsrnqP6tOcD3U3dNA+bHPKHQ0
 pv2A==
X-Gm-Message-State: AOJu0YyyjVcOzgUGAM+0oFzRMOW/C8WAXibgXaVADC+JuA9cC0gakNDv
 kAEjXGSRdUMPZ6YJub3c6fvZgrHDPUIqq7L9Yoe9yV6a7eX8Q0KbfBe6ef0vRjWIUudOj54wal5
 UMhaS1b4dg89gqje6w3Bt+AHCRVh8NzMDQq791/4TqAZumcKm2OiucxGeAWIhPKRRg0v95DVHhh
 svGz0D/iOYGhiqeCQfWJmg5hAQ6BG7RPbSrYeowLhw
X-Gm-Gg: AeBDietNdCp5gFpamL5olEi8O2XubS/OUsJPMCLbhiCDbH43D2Vo4suVpMu0Zs2+6mv
 UHRjL8DtQ3VYGGSwCGQ/zJGK4n3pzHhbd1Y1z+fq65roN4CpN3nvdRUjyzTvtTgMHkUkeUa0BIs
 wi3OrEUJ0qhF9/ZxUtEBaUdoybmcWK5yaPsw3fxwoV6u7+4tLhENTjtm/m1d4vGU4DZ2EW9Q8x9
 bt0Es9WgxjvTdgqWW3U3E0Fr5O3Vh8ntNC31qN5cfr60NkrX7XUkuMKJbLGRG1g4v5cUlYz5JfJ
 hmgI8uRVs+0IyFLJo3ZAMTlrP5toxQtWQy0LhUQnv0hYlbhN+DIjsVIhZ+x5sd3QDWJnyYPnG+1
 LoNsda8cvncoj7Y60MIWFZVoGBCxsrN3YXKUmv/VTS1icPgghnNqW7guSVKldUZxEvhBX5kpL+X
 waEPE46V7xUJ0woEW9BIlm7opNctG+xIoGBNs=
X-Received: by 2002:a05:620a:4043:b0:8cd:92c5:b3e7 with SMTP id
 af79cd13be357-8faafc0feb6mr537708985a.18.1777569771501; 
 Thu, 30 Apr 2026 10:22:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4043:b0:8cd:92c5:b3e7 with SMTP id
 af79cd13be357-8faafc0feb6mr537702285a.18.1777569770873; 
 Thu, 30 Apr 2026 10:22:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb3e2b668sm22286585a.35.2026.04.30.10.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 13/58] minikconf: use .items()
Date: Thu, 30 Apr 2026 19:21:19 +0200
Message-ID: <20260430172204.1006673-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index c46c73f82d9..7f0b64b1e08 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -246,8 +246,8 @@ def compute_config(self):
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


