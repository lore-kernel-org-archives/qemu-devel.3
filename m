Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1D6109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RLw-0004n7-8v; Wed, 25 Mar 2026 12:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLu-0004ls-TG
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLs-0004Tl-CN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5fb9/cmDwJkn7K10LCL+lrCPa12NqyLNGdwwl5js44=;
 b=DrWtnHDAyzWqED2GAARVSxjPMNvp16jsNy8QDqSr7bKhh+dtzKE/EhlbWNsdni46QOaFK1
 w5ATNPKnt2o3kChoEJHV0Qv0Vttq5KKz6Yv4YmTpN8COcv1Hn/Y4/LdI3ITQzUvKbcQgWp
 VQ/0MhezEhGNXjy7HfG4svk//B5lMp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-8NyrhWJaPJ2jie9HJ83ohA-1; Wed, 25 Mar 2026 12:45:01 -0400
X-MC-Unique: 8NyrhWJaPJ2jie9HJ83ohA-1
X-Mimecast-MFC-AGG-ID: 8NyrhWJaPJ2jie9HJ83ohA_1774457100
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-486ff4498b2so3455965e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457100; x=1775061900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5fb9/cmDwJkn7K10LCL+lrCPa12NqyLNGdwwl5js44=;
 b=J1LqJ/SZT6gCeCVv54fBOVWoY+XJFNJQESxHSRobpxsr4qhd6sg94Cydrx8EOz/Qvx
 mfTnABIK/ek2aPb5SMisCwArY5mfsAH1/uwbFUtwf4DDtLGA6COttxU+QW7oOllOSKWQ
 5HMeAeZYGWicRj8oVSTSWKRkRqHeUHUKNrYwT2mSzvnAb4x4FJt5FPGJaNEkEoYei4qE
 Fimx2Bo/G9lpjhd2MJYjJVGN/A4uJ+tZKG1dDIoJ5wf7zIObWw1vGyBcqH0da96RFDLJ
 s7pzqx8/DTPRthIZrm17JREzskcibZhVcBmZUs7e3PuyK0hcSyx8XLBpzkOUCN3L8GmI
 GvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457100; x=1775061900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5fb9/cmDwJkn7K10LCL+lrCPa12NqyLNGdwwl5js44=;
 b=tD2EMhRK2raKg7UVFizuX+H3RCVk6oDICP8fRqrEZQ7mMU06vd2oCfJP6c961AOaRf
 CFYhmbtu3E7rXHdNrEZeqqGj3B5sMW4Aj9GO1NsAegQRgl7qNmcKHYVhUWIo+2LJcuV6
 UbiXgoyZYro27hv1re26xiUAMbq+39aJ3cPryB9ghWUApGuSjLGFTYVGOBEG4EUZaoKH
 1KoJJmN5fDsKXe4F1ZV2/fmbQH016sfyYjHnMicbsdqG40mL3IqK2OLvkBfWtKnA0yw4
 Cq6GzQ3iIE9w3YWOSkKb+mgdH3EbOM+jaiu15u80DNVSGRewCTfAmdJRQj6qj+eCezvf
 XhUw==
X-Gm-Message-State: AOJu0YxBHJ1PA33/H6m1DpefLcozvyudtuepBGDnpS9HhR7714UJwakb
 zkiRSClT/ewHTyuXvidc3JhI7hjtIhBp4HlaNty6VpGgeV1nlHsc18Rx0b7I/pbgEU3hFr0l9Zz
 elgXrxN2rPMaOVNa7FE/JES/aties0zKsvlKLFStiyz9EzygRhFcc4KF88jkF6anchpDj1c4yTg
 CRnQ9Y8qn4lLMb2d6EPTjZ41qgq+lUf6rT4i6Qxa6B
X-Gm-Gg: ATEYQzzknwkVrTrS3sIjQCK0wWfmSFkkCYYgV1mobcJ8Qk/27rePROn9iX9o/NnmUJD
 XI1BbCzi3GoDXY7JmjNpBqBGgD0U32HiSFAs3pUL4+xSRtX8cAazDl/YCPwg4Skd05aPqbKug9J
 lCAuThzoE3PAXLGDh9GaDms0WJV5PK1wcd7ZBsb2oR1ffHZuIXb4OLhEmCqUDqwU0iHQkL3vEub
 IB85X6cG2SDcaK4X5AXnRZap9rZjHrtFxG/Gg9NJyT5RbAdp0k6+NFYky8wfgQmv1d3T3mnegdK
 +WNMSxP6ZRRd2Hj7W6y2ovEJRbV0FxUpI6L3rIWANMHHfsWvq8jAmW+E2ztygJD2ngcKBgfXyo+
 Qy24Zv9rxWvTEH1tDwHLspQRApH2GVUb9v+yzC1bGGgt5Yx77D3g390iYwf4z3hV9aZYocxPeYL
 hJifL2SETtfKmumJEE5DatKS13
X-Received: by 2002:a05:600c:350f:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-487160afca2mr60589245e9.32.1774457099771; 
 Wed, 25 Mar 2026 09:44:59 -0700 (PDT)
X-Received: by 2002:a05:600c:350f:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-487160afca2mr60588475e9.32.1774457099040; 
 Wed, 25 Mar 2026 09:44:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b91943312sm1151883f8f.12.2026.03.25.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:44:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
	qemu-stable@nongnu.org
Subject: [PULL 02/19] tdx: fix use-after-free in tdx_fetch_cpuid
Date: Wed, 25 Mar 2026 17:44:36 +0100
Message-ID: <20260325164453.72127-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is mostly harmless right now because the "if" is never
hit, but the code as written makes no sense.

Reported-by: Stefan Weil <sw@weilnetz.de>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4cae99c281a..4714c9d514e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -848,7 +848,7 @@ static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
         r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
         if (r == -E2BIG) {
             g_free(fetch_cpuid);
-            size = fetch_cpuid->nent;
+            size *= 2;
         }
     } while (r == -E2BIG);
 
-- 
2.53.0


