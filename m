Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC395C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarB-0002af-3W; Thu, 27 Aug 2026 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarA-0002aV-Dw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzar8-0005d6-CU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdLY95Xun6dvh+tc87rHUYgX1iSVHtyCBLbdItu37no=;
 b=PFWf59fNlVa9QQ9d25dBw3seMwXIjVdIu+5K39H9TMxId+HcjJykWi/dN07WRHNoU/cpRm
 r21ET3HBublONafISXoYfPAsDH1asiUrBpFZ2DvWecPFbGQpLCeSwsoRD7jZzHQlpVewR9
 +5nkaBvCi1ZAfQgcF0cKFfy5ubWMeHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-6OG0rO9yMaSCWaJ5Xi9OJw-1; Thu, 27 Aug 2026 10:13:21 -0400
X-MC-Unique: 6OG0rO9yMaSCWaJ5Xi9OJw-1
X-Mimecast-MFC-AGG-ID: 6OG0rO9yMaSCWaJ5Xi9OJw_1787840000
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49808ea1b64so8626995e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840000; x=1788444800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SdLY95Xun6dvh+tc87rHUYgX1iSVHtyCBLbdItu37no=;
 b=lpti3ipD9V1YVGJi8stxSQ+7S2oD0+C0jNKgF+hDG3LQztm138ivunuyDhh21eI/MU
 SbamLKQbPBWHCRl+ipoCTdcMYiaE4Y8gIi5pwIXJ0v34iV1j/n6cLcaPPwC8js9kH7wp
 KA7cor5H8CD5pXs/EA3hH3NBx2p7b7vkxtsADctrYH2cPHF1jZQTzXtu4m+L3/EUeZOM
 XcyX+d/8OzryX2aXas5oYqBsFuyn/k0ySuGmpSdX14jBnJh2XXmeByTuIQdJxwy34amn
 jiCiG+TlSnq8xbrMktR1oA3KEKlZ72TYl/qbBQUsfv+Q8esWGgfqF8m2Sr6AWkKOpvku
 Gf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840000; x=1788444800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SdLY95Xun6dvh+tc87rHUYgX1iSVHtyCBLbdItu37no=;
 b=lMroN0rPQQ7iXt2JhPodl3xQ/F+Dc/7H1y14hJbBwYBekzudRv3bm/43T65v+65Pk1
 3KsqF59V5mrNRpI+IA5LV+mNJHvIyTSKKPXfqZfoX8n0nNYqHpoKrqR0BIaKFHIdcezo
 Df7r1kWDZNagUGDWaWbLwL9/fxxZgrLo1NUKYy4eLYkGLbIfBkz8KzO4Ukm15D4HmCmp
 a29r1Ldg4cGDYE4bBc6BegFWTs/DqkPwCJTy+EBNkrODDt/vBFYJ06FLnd4rr51VjMDC
 ksS6PgrKjEeMuFa4hFrCbd+5BX/rBdpautVc7KSShBvz7ctKSQb0XbaskmdRulFGiuEY
 VRTg==
X-Gm-Message-State: AFuF++mxV4b/fpjVkqsguxx0MPyv5cExpEIV2SZRi7AUZN7WaMvY3RrU
 1IePfFCYlZCkoVWpjD5BDeYajopsQY5SgqhR9D8D8HQinfofL7SDeLOHATZNqyCPZLmHyb8WF7e
 5xmuOQ25ASso1zA60th4fYpIkak5p7frZPuMLnwTp26O/FkcZZenGO3n7Jv105xdOp6XUS5d8kl
 4r15ipe2xIveBavxE+Ih70TduCMhKxpj0LosqMJ6U1
X-Gm-Gg: AR+sD13seXaQnxZCqgG4S8NpwnJOkAakxz0VwA6Vf/NhEvbFEysa29mC5Z/DbBrboPT
 zySHt5Dma6dD7UDTPjfQPJW24HWxIR/iCXnq6I/59Lu5GbLc+9xQQPsOQy06L463VUHECpxABBz
 4ggPMxs6pEvDf7NhQXQ8YBmxWmsQtiPja09Vxn1yywZjHes8Hv8nOoJOHQsdKcWycxqgFX2HqhX
 tZqfFL8UMOVGt7S0zIu2FWMneQmDdDla6Q45DPICu/mqzhxZo2mRC8Jv3rW7XfuyvdDUBo55qCO
 VLLK0vTbhFx7iFBvR5w82lb2BAl0f1eTNn9//1F93mN/pxCvuglzoaItHIVYXhHiTK1akKgwmYb
 WiRuyNtvWihufjE9iaigjTwMBexod42C3xwJiME9Gl5C1RDqhG9iCOLsWZHhIfZ/5RaLHNrapiT
 pXa7Y=
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr95420325e9.7.1787839999853; 
 Thu, 27 Aug 2026 07:13:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8e:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49b0dfd7d2cmr95419595e9.7.1787839999444; 
 Thu, 27 Aug 2026 07:13:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b494228bfsm53563795e9.2.2026.08.27.07.13.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/23] scripts: remove dead variable assignments
Date: Thu, 27 Aug 2026 16:12:49 +0200
Message-ID: <20260827141314.1099352-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
 scripts/get-wraps-from-cargo-registry.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 78b6f1f7ae2..3820d121183 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -113,9 +113,6 @@ def update_subproject(self, wrap_file: str, registry_namever: str) -> None:
             print(f"Installing {orig_dir} from registry.")
         else:
             print(f"Replacing {orig_dir} with {registry_namever}.")
-            patch_dir = config["wrap-file"]["patch_directory"]
-            patch_dir = os.path.join("packagefiles", patch_dir)
-            _, ver = registry_namever.rsplit("-", 1)
 
         subprocess.run(
             ["meson", "subprojects", "download", wrap_name],
-- 
2.55.0


