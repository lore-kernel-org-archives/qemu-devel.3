Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F690CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoD3-0006Ru-Rv; Wed, 30 Sep 2026 02:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCs-0006Q6-Fz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBoCq-0005Kd-QL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790751260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oirolLFQi6i7+NVtqgU+mqpX5mzUbu/0fQhDgOzoV3E=;
 b=Nr7Phqwtfh4TCUaXT2JPCUIlfUPc8H5F+kiipnuPAKYIvw1Cagb7Dl7GUQDku0sTlaYbCj
 9xLuRGD2indVb7CJw6f/UYxbwU/KjP77eT5NfOOWyN6Is51xYGVS/uKeacO3Bf45mHeHnY
 70ZEbOfX/gd9g9XRA2vZNwqLxeiVwI8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-TqLjmIJoNqqNUWD00zY1oA-1; Wed, 30 Sep 2026 02:54:18 -0400
X-MC-Unique: TqLjmIJoNqqNUWD00zY1oA-1
X-Mimecast-MFC-AGG-ID: TqLjmIJoNqqNUWD00zY1oA_1790751257
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4888382a9e9so3069679f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790751257; x=1791356057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oirolLFQi6i7+NVtqgU+mqpX5mzUbu/0fQhDgOzoV3E=;
 b=E6Uw29yvkQV0GSN9+zd24QiSKVtDwU7Xy3J3YYv8lTjn5YMQzkxIyqc3XTAKjhOtWP
 xJM+dRnJ0tavaqmR2HjpWLBePMEeVh/DutOfOjkOJ2J/QBUHRnTAo39lL/OL8HzxDOgu
 ZBPcMWLMW+1OrjlnaOvHhPjVH0TYLBhRTOzwccpeBGHJcsgzRBLGP8wdrAjfUHTe81Z8
 e/FQyL9PvQKriwM7xfW4D0LtMZBi2Y5CSE3XD79pnNTIkwRMVHNjJhJ7Uq6713VnX7p9
 8/JfEZVCqmSFr10mTMEed3V/hnkKwjUonnMSZ9Frwa3p9lIk+/hvUaVxZ+4F4/eKDZ/k
 atEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751257; x=1791356057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oirolLFQi6i7+NVtqgU+mqpX5mzUbu/0fQhDgOzoV3E=;
 b=wImX/xvajiKhIWfyaRv2rxKUpsa4MVWStYRB9q+R7EOkuSHXxhNrndjmqPSep8Bt9f
 v4KoVMaJubwOajz5o2ihuq19gRIh+LNLUcQCcNMWxUtc0qLJiuC53WGKxjVS/oWoJPnY
 M5SvrQoV7rkM7xGWKQ2qgpJPv1mBnUqscx/ahlmYEojm+x+A0yiPYjlFN0AwQrrMCSgg
 Bt0kSndAMwDb/UqwhD79CRpLKS7kaahpyXuDA6mSdmabVhDKx6egrhanpxOZe4E1fkgk
 RCJODAmG9HTRWCy/BqFh+McfF2Vc8erera6LgI2MZsM0/tjOdRPnlzpHj6Nh96jif2jt
 6NGw==
X-Gm-Message-State: AFq9FYL9qwptwtCiPpTMCWrL4p2wOm0+MkLRJK0MF6UndyNAC5UN8XeA
 hfTdMp55QBf3Iqh4+wJSKyZAbLSj97PQ2e1wxkujqvVIQBSzfvRFiPEBJeCGMthCELsFdZZbPAC
 uA2PLJYnXQdOoCy6n/ZD+oZhAYaZ+pI6dyTESfcz2YGjrdHmaRMkT0ZTWdJO1sHRtKhK30Fvjgh
 0TqBlI5fST0Kde/eTtnkWGPQ/bi6kGsBfk5LOYEOfG
X-Gm-Gg: AYBFou1r3zzrM7fLxO1em4rznNudgafH/I0Aj+lqQhSUHrZJUBbRl5+N2qUCmSeR1Ma
 eDzXe3+Ze9dVZIEx4ldnoCFuZHF+nvWEB74FXaTUzrFtV7g3pM90GB+cMIg1JAmyecV+jtR4Y9X
 pVBNXoULO/DT1LR3FKSf6z8aoQTpNRIpxuJf3F28WarZqLTf7zohbJzYgRWDIfIrUYpQk+UjsOX
 eNTEO+/Mmpvx0DDoW/cG26079L35oiqS+8JplDoTE9WlQZcXnP2L/+uww5UaZ+t/BYRCFgYIcYU
 saPR/w/1X0eIiNughdFv0qMOuNUaf8SQZq0MpiB/WeEoq+45s2qrSGvQsx56ytvM8y/Pe67EyTs
 wIdHyz+Uau8uSNsmH1PJY/yyol2qgdp/3CLvzjQxDK5A2/Z6mHnSicY00hSSvq2fy5QVbiZ8hQD
 IoTTBC
X-Received: by 2002:a05:6000:188e:b0:488:7f8b:b4b with SMTP id
 ffacd0b85a97d-48b02505662mr881970f8f.26.1790751257481; 
 Tue, 29 Sep 2026 23:54:17 -0700 (PDT)
X-Received: by 2002:a05:6000:188e:b0:488:7f8b:b4b with SMTP id
 ffacd0b85a97d-48b02505662mr881936f8f.26.1790751257101; 
 Tue, 29 Sep 2026 23:54:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bef64sm1437827f8f.10.2026.09.29.23.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:54:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Andrey Polivoda <apolivodaa433@gmail.com>
Subject: [PATCH 3/3] target/i386/tcg: clarify return value of decode_insn
Date: Wed, 30 Sep 2026 08:54:06 +0200
Message-ID: <20260930065406.738374-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930065406.738374-1-pbonzini@redhat.com>
References: <20260930065406.738374-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

It is clearer if decode_insn() returns whether a generator exists;
if it does not, the entry is empty and all other checks such as
validate_sse_prefix() or has_cpuid_feature() are moot.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5212a24e470..4e1cf0a8297 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2478,7 +2478,7 @@ static bool decode_insn(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_
         e->decode(s, env, e, &decode->b);
     }
 
-    return validate_sse_prefix(s, e);
+    return !!decode.e.gen;
 }
 
 static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodeFunc decode_func,
@@ -2984,12 +2984,11 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
     decode.cc_op = -1;
     decode.b = b;
     if (!decode_insn(s, env, decode_func, &decode)) {
-        goto illegal_op;
-    }
-    if (!decode.e.gen) {
         goto unknown_op;
     }
-
+    if (!validate_sse_prefix(s, &decode.e)) {
+        goto illegal_op;
+    }
     if (!has_cpuid_feature(s, decode.e.cpuid)) {
         goto illegal_op;
     }
-- 
2.55.0


