Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2523CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ev-0002t5-2R; Fri, 26 Jun 2026 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eu-0002pL-0Z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3es-0005Q2-GV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aIFFStwIQPyPGGFFcCuo9KULlPMnEEdzY+2iD1/Z4E=;
 b=OnZ/b1rHJQc5KKvIdLuHS2fd9nNiKsqtIuW46WzVdv4TneccakHAjHDyIQJVrSN+/XjL9n
 EgNEs4E7nTfJeMtR50JTAa5tzGmFNdUoMzDvtlFmubEBaKTR/B3T1MCw+FDDsoIwZV26K+
 7b/TkD8QIg2I4RBhSe2vg2EV0P2OxsA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-869twCt8OC2_TGV14TglXQ-1; Fri, 26 Jun 2026 06:19:36 -0400
X-MC-Unique: 869twCt8OC2_TGV14TglXQ-1
X-Mimecast-MFC-AGG-ID: 869twCt8OC2_TGV14TglXQ_1782469175
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4924a7ae480so6774655e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469175; x=1783073975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aIFFStwIQPyPGGFFcCuo9KULlPMnEEdzY+2iD1/Z4E=;
 b=W6LeiXI9NaHNLtMNywOfRDaLAMX27Jd9nM+UVjY7T/T/Po2hD+hx40iSCJr3jFSsLt
 67vBylBLL2++CO0bBTzF0ALHFoq8mwjDQAeKJVpaBckA+tnv4QY7m26vvSr5zP4SUWh5
 Bl9SokblUBBawyUUKgSvpLrzSQKZbtq6f76IDnr1yR5Oxxi3mYLN4F931RTo0KBhxpWj
 hbXQADnJlIgaQOFqjtoOW5+uKK0V3bm6i9RDIk8L9aQ7sHPnjFYIcVha38vfsaZhKwRV
 wnZp2mtg4bWP4jgz6MfFpk21QQlG2+NOIVuU7VGgbFic2rqTUle1dfGNZgoZSvqkB+zz
 aonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469175; x=1783073975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8aIFFStwIQPyPGGFFcCuo9KULlPMnEEdzY+2iD1/Z4E=;
 b=Wb/y3OxWhJwinqXQhby41+TQ1mR/apIYlOV2dASg5i6co5DqUZvtbxCIASeodzFIS0
 IwOKn3v3ntdTv0FLTbxQhDa8Zd0A0U6bYsKUkhfnh5rrTIPlAE3jw4sq4/PZxVeDVJWs
 7vVyuSPiGYxJSXhWiwgTS5YjZCQobK4uCCRryGl8JszlWrEoxJKLahRwLl2MB7H0eePL
 j4Dtlh9lt9IZNhpucl+BOvDlbwnJQv8uWfxywk3tu3PvYrlaARX1Ulh/kgVlZW4faCWc
 pc8k9IrVhSB70gaXKQ2IUmnKTy5oACU2BN12vGYPQLEwPtsp5XnS/0zO7BKQQlacVXbS
 8g0A==
X-Gm-Message-State: AOJu0YxOH5ydD0tsdSviYFXULVZRE/6svJI8M33XoCsXqgNC302u63dT
 Sw6Y4HSKlJ6T2fKiy47Wg0ebcy3QNN9DW85h74ijH6WTfFKduJ5hdq3Wo96JrECS2ov+AAchLaQ
 /S8kmx5IpmBvfD+uy2KWJQImKlCr0duKMGvF8TqloJrJAM/Cd6XCqNJrBOvz0AWI+vnLtzJJllK
 W0qIkWsINztocUracO7Mvckriu0gbIpbODrardB+B4
X-Gm-Gg: AfdE7clz+JBIwiEkHpQATsDHJlrwywjI9H1PsH+CuyH4UH3F6+RTnba5Be/5SNDL/Fx
 UIy1hMVUaq02FifCG9HohEkxqrLuZ+8th5i4EBaii1WUw45Q5ZO/zOU6BHEFr7OP2SiXMSnOo1J
 vZ5pJQCeFkNEkeuh8+auaij4eFW8K6rm9VK1XwCVoiqAtVabCYIqVXnAfKl9CQYPWe4koAIn0l7
 DVnuumazTI/VFWCaFmQO3P3Hx+FDoSXkIoEgNwLDu3d0nEpc1pbYjDy7LuUoN+VX8V6PN/7ArVb
 IM3Ac6jEVp05z3s5owgt9ZqFY1MHBPUM+zkCudPL0zzyy/6TJzM7YdndqlEug5jWmg/AABKScg1
 BBtVa/E8RWSAksgZbrE500T9ayMNwsOIgjIeX7iGlHde2Ih0iyRCQx7HWyyClJ5qHHrljVbXZwM
 4FWmk8aD9enbGSi0eI
X-Received: by 2002:a05:600d:8443:10b0:490:d32b:39c3 with SMTP id
 5b1f17b1804b1-4926685feb6mr71609875e9.6.1782469175336; 
 Fri, 26 Jun 2026 03:19:35 -0700 (PDT)
X-Received: by 2002:a05:600d:8443:10b0:490:d32b:39c3 with SMTP id
 5b1f17b1804b1-4926685feb6mr71609425e9.6.1782469174890; 
 Fri, 26 Jun 2026 03:19:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269020266sm65401815e9.15.2026.06.26.03.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 39/45] qemu-options: Change memory-encryption to
 confidential-guest-support in the example
Date: Fri, 26 Jun 2026 12:17:42 +0200
Message-ID: <20260626101748.1728079-40-pbonzini@redhat.com>
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

"confidential-guest-support" is the recommended property instead of
"memory-encryption". Switch to "confidential-guest-support" in the
example of sev-guest.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20260512084458.622465-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index c799286153f..03456527910 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6364,7 +6364,7 @@ SRST
              # |qemu_system_x86| \\
                  ...... \\
                  -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1 \\
-                 -machine ...,memory-encryption=sev0 \\
+                 -machine ...,confidential-guest-support=sev0 \\
                  .....
 
     ``-object igvm-cfg,file=file``
-- 
2.54.0


