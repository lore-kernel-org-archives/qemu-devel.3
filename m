Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038D0C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzarF-0002bN-VH; Thu, 27 Aug 2026 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarF-0002bE-1n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzar8-0005dR-TI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=BnOqAFlsk2m6MIip8Wa5xc2iQbZXVUxzkL4RglfBvhMBzBOlmrOCrIuht4mrEZy+SHNXHl
 ND4w9HB3/w0eGHAsqyOELVgHs6B5tPK7TOKra9SsdOZPFU1U8NamvI3bRUDlzL+3SNp4AN
 gbZ6uICv0Zlb9NjPmHwmNBlt9M35v5Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Ww9a8nJvOCqf29u4hjbhnA-1; Thu, 27 Aug 2026 10:13:24 -0400
X-MC-Unique: Ww9a8nJvOCqf29u4hjbhnA-1
X-Mimecast-MFC-AGG-ID: Ww9a8nJvOCqf29u4hjbhnA_1787840002
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so476843f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840002; x=1788444802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=iNPOXT2L0O2NicDUE44wUmEkoTDyzkUkeRA79qCEMiXfl2iegNYCv0MKUGh57ZlnqC
 pMBD6p2F1Q4Tipzzsa2c2I/1hXNLAxE3DE/JmN/OumSIFNoaHpluBKXDVnqNrNc1heo1
 27StdGsDUH6exB/GTep3GtvpIklVsjIpDx+PFDsNZ1cNPwPMEbvbN/sQb/jmNHhI4wOC
 AlY4abVM05hd6/g+m90NJbdMKcDFaN3f+LzbGUwB1J4k7JxJ9B9SHRohmtVpAr8Yu78j
 pLTe9fYb7M4VE9sHn0ul7O3Z+CyLCOPeHtfM6HmlecpjoDcAxROxRyh5AbsXb4pYUAvn
 xXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840002; x=1788444802;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hjxLnAVY/DURtZa77LbXggflUPsLfOq7SYe7f/Hv64=;
 b=h7pvjtTbM94o4MMIHs3hYsVv8d1+KGBbUeTps7Nii7rXp2ZnSitfnBmz6co6bFuZx9
 yF0AemP+M55LeMWdu+huMV0jlbw0NCZW8VT+kYjGUGsFp26KSSTQvl/gNtOAgCcg4zU6
 6s0BjbZfKchTV9lANPjvdW2rPj6syU2foQB+POO6sr5u6HwSarYJCueQZrP+O5turY9z
 ZPM7P5PXTQauu8FS1VcLYzlxa2+vN6tPcL5uO7tX86LVQZTh6OeJ58Dw1j8PscVVt/w8
 vGHPyKf3bWD6uhogAyIcytWTYpFMwft+NZcZa/iLgGr129q95/pzDzOGm4gGylVgXDnm
 Lkxg==
X-Gm-Message-State: AFuF++mWKnQBB0jQcqgHILzvhCAWEBpskSpefeVGGCjnltB3wdr4VAk4
 LfsdoOlsUo7oWRD4F3d870gqTfEgMIBRk6ePuhA3OAq8Qo9499mV582mg0b+vgKWyqbSgQlsQm5
 +KFd/nI99WTwc3qeXROmdYK0nnok7ceSsOXX+fwt96YBDBwE8Lt9jr0f4BSjK9wn5A+Mkvu93Y2
 juRYG4niwAW+Uyt+maN99E2ts8gXp0iV9Fm88KQlNH
X-Gm-Gg: AR+sD10wtl6aTFCSaQN+TbGBkHQ9jE58w+m+D9LYZAL7Q8TsAt6Tfj+Uc7JsX969xVY
 uz3JbgR1c7i+aHrM+VFdUBATxmhcamFRUYivLCMhT/2N49Fi6AR8vtTpijzhIAy7IyRUirgRUyx
 xUFpUgLKjn+l4vceT/GS78ni2UWyswOhMCmA1PwUVYs+utYnxwhnvGIZlGMM0m/n6ltaL3UTp/x
 x1qKeU+QGW87Fgt7/+y6f37j4QS+SuCtQ2KHt4QOeRE9rwUW3cztopYyshVWiKFwhIUJoKvVIyL
 e4uFpCdSoohI9Glwrzio7nJ4fFcBoYumAybCyki0AFlY0Pil1KZMGs3FO+RQMwXTqapY1IT9Y2H
 ZQkhpv7MWsxDPe2twJUjmnGWpvbry72lSJS9D8bsuDEBiIMslCS0RPNXcu8w9e60fALB+aFAh6x
 UcLgs=
X-Received: by 2002:a5d:5f50:0:b0:482:f0dc:e647 with SMTP id
 ffacd0b85a97d-482f0dce707mr8539332f8f.21.1787840002216; 
 Thu, 27 Aug 2026 07:13:22 -0700 (PDT)
X-Received: by 2002:a5d:5f50:0:b0:482:f0dc:e647 with SMTP id
 ffacd0b85a97d-482f0dce707mr8539206f8f.21.1787840001581; 
 Thu, 27 Aug 2026 07:13:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm8975014f8f.35.2026.08.27.07.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] scripts: print build.rs diff
Date: Thu, 27 Aug 2026 16:12:50 +0200
Message-ID: <20260827141314.1099352-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 scripts/get-wraps-from-cargo-registry.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/get-wraps-from-cargo-registry.py b/scripts/get-wraps-from-cargo-registry.py
index 3820d121183..84c652127f9 100755
--- a/scripts/get-wraps-from-cargo-registry.py
+++ b/scripts/get-wraps-from-cargo-registry.py
@@ -59,8 +59,10 @@ def compare_build_rs(self, orig_dir: str, registry_namever: str) -> None:
             if os.path.isfile(new_build_rs):
                 msg = f"build.rs added in {registry_namever}"
 
-        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs):
+        elif os.path.isfile(orig_build_rs) and not filecmp.cmp(orig_build_rs, new_build_rs, shallow=False):
             msg = f"build.rs changed from {orig_dir} to {registry_namever}"
+            # diff exits non-zero when the files differ, which is expected here
+            subprocess.run(["diff", "-u", orig_build_rs, new_build_rs])
 
         if msg:
             print(f"⚠️  Warning: {msg}")
-- 
2.55.0


