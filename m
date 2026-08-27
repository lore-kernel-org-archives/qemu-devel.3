Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA13C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarf-0002gA-Jv; Thu, 27 Aug 2026 10:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarc-0002fa-Cg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarS-0005iP-5R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=X3RV+VNNluIRRLi/ijP749vUZlCDrqE+xULz2Eh1bi7e7d3bYyNAaWSzhSlEg9TwWSheyK
 RXyUAED37lupSuHDZauwWMY7LYvMt2HVjyYRrL+bi003r95o638SyaFWNwO+jbKxSiRYxv
 IOO7eXg0ytY5ZjM4FF57NPYbiILaPgA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-LuL3_zdwOQCLKzHo8U2FnQ-1; Thu, 27 Aug 2026 10:13:42 -0400
X-MC-Unique: LuL3_zdwOQCLKzHo8U2FnQ-1
X-Mimecast-MFC-AGG-ID: LuL3_zdwOQCLKzHo8U2FnQ_1787840022
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a5d682e372so973979a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840021; x=1788444821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=Gz6yQID/wsk3x7kZvCIc/YFpdj97yzW9LleegiJeE676K7eUf+uFgZkaybcMHttNXp
 5Gcb/ZkwqXzWFTxpp/cRLHSBOgUTqVFcm49L3J5MT3RscSEmNQjNtkTuAOvGQvBUfMvv
 J71ozJssjaOZBSyVsf2uRO666Sx1iGEMIHhVAx3RX+7pw+dWec3bzDbqJqSXIxWawa4f
 R3LENoihf9QqPBOfxGnDxzaspXfC7bMerPcs7ymAju65EQRu0FTC/wjLmPl9cjaNgOwX
 ugBx7GR5up539oM+C+gT8usoCrMNmnm59fI6UuS9O9VeDeUAbudasXXLbXYnYY6hLTx1
 geYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840021; x=1788444821;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jEkhhmfARJthnU2Ad+S3BEdQZlV4xabCHmVmi7VfYGk=;
 b=efULpZx5N8Bgj3ZHLXnZ3Y9XnbuEQCEGoaWWvAZYHKyGUHhOKY1QRpTvnUVAIQXadM
 MiwC4OwwUXmiu1lgpMrBnm1Z3VA7mBhoTjI+KodCmqJ1517ZuVa1udw3synI87pIZiHb
 ttw4UCfvW0G3PymJQzvqEauKeJjfHmfxQ5gER1b0deoNvGhSzbPFZX8DGMFvnpA9isTM
 6NiKqHxMyECVsi4oEWDYsY4kzfcLQiKtdBtNVWhirV6aF73Y1tsk06AOKsucyNGO/HvQ
 FDb5/FXly0oI+9SaOttkHrSILra0Wh2L/KEjqivlmaWLMmkeQqxpP1+ZKcuAN96hlipT
 8Onw==
X-Gm-Message-State: AFuF++ltPhhDqSRl9H2vQ2TpmWUGgP6qyMuPtPoozpXOI2dDVb0aoWDB
 szVPl6fWHIe+5ZJIPLKoQPZQpENGYV9ah57aBxw9gT+5IcPtepz6DLFWdx5ZB5W2I1b8ktLiWjr
 ADv7YqlCKug1WJ8XntO8/VkuscDk94oaKRRxuUxMqLADelWSsUIxrzwUjZq6D3I3nR7BW887EcY
 TRKNlvYaU0mBWe5EFfH/S+Cnae6Y5lsPCXXWsQaEZm
X-Gm-Gg: AR+sD10dfbgmu6UulPhNIW5m35YonMCuaiKIukamOdAnuSXY7bjS+JLcNEqYSPW9ToY
 bUfXneGvHbTsSsasFWpOso/ww8Cd5ViOG6wCqunsoum7uUZeUcWBUUhlFbmPz5u8gYwpRA9IPcB
 2fSVYCFwHXgtKjDECTQ3F8BqSLMqdQuZD6ufzfoc8g5+QK2iidF1Lh09fSBk+X3fI4Cl/XTUsd9
 INts8igAZp+BCpM7QVrR3Q69ITldFFdvelYd4jlXrc37sJXHOOmfJk5Rfd/01CzmRnVCjWvfB2N
 PSMHj9fQucyl26u+lOrDncRx23oRdy/Isa/DmhBVZNIuH7n9bMmlpPJ1cMHVqcnsHMZPTY1MlQ8
 m81k7qPrn3A0+q5tEoY+z1PfLMcDZsXBc/S0RmvxlKk43UIYQFM8VWqE4nmxu9MT4Blj1Jy5CGm
 Dtf1I=
X-Received: by 2002:a05:6402:4545:b0:69e:2ca5:53bb with SMTP id
 4fb4d7f45d1cf-6a5f4e646edmr4827009a12.0.1787840021539; 
 Thu, 27 Aug 2026 07:13:41 -0700 (PDT)
X-Received: by 2002:a05:6402:4545:b0:69e:2ca5:53bb with SMTP id
 4fb4d7f45d1cf-6a5f4e646edmr4826968a12.0.1787840020934; 
 Thu, 27 Aug 2026 07:13:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de5f7bb8sm6543615a12.0.2026.08.27.07.13.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] scripts: add the possibility of a quick update of the
 pacakge
Date: Thu, 27 Aug 2026 16:12:56 +0200
Message-ID: <20260827141314.1099352-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get-wraps-from-cargo-registry.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index b3ae5a2c284..a26fe135eb9 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -166,10 +166,13 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         orig_dir = section["directory"]
 
         if self.dry_run:
-            if orig_dir == source_namever:
-                print(f"Will install {orig_dir} from registry.")
-            else:
+            if orig_dir != source_namever:
                 print(f"Will replace {orig_dir} with {source_namever}.")
+            elif not os.path.exists(orig_dir) or self.cargo_registry:
+                print(f"Will install {orig_dir} from {self.source.origin}.")
+            else:
+                print(f"Will update {orig_dir} from cache.")
+                return
             self.changes += 1
             return
 
@@ -181,10 +184,19 @@ def update_subproject(self, wrap_file: str, source_namever: str) -> None:
         with open(wrap_file, "w") as f:
             config.write(f)
 
-        if orig_dir == source_namever:
+        if orig_dir != source_namever:
+            print(f"👉 Replacing {orig_dir} with {source_namever}.")
+        elif not os.path.exists(orig_dir) or self.cargo_registry:
             print(f"👉 Installing {orig_dir} from {self.source.origin}.")
         else:
-            print(f"👉 Replacing {orig_dir} with {source_namever}.")
+            print(f"👉 Updating {orig_dir} from cache.")
+            subprocess.run(
+                ["meson", "subprojects", "update", "--reset", wrap_name],
+                cwd=self.top_srcdir,
+                env=env,
+                check=True,
+            )
+            return
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
-- 
2.55.0


