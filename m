Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF2F9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKm-00012q-OS; Thu, 23 Apr 2026 06:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJW-0000Wr-6Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJU-0005Ic-5N
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEvldXsvdFOl0SSzAqnBPPCDIN4gE9YKYHWFJZ424fA=;
 b=CkmlXbDzI1HfKRYkd7on54zPJVcSfpwocIpTcX6xVhdxx1rNMhCEn6lfDEXiCEtIDhDvUB
 Vj5oE5Cicmyhimc48fGhJpO7cRTRUrzjLc0VToRYpq/Td3i0p0yV5uea55qIg6EbhqAe1J
 XbbVfK7uslm3gMDho5Lwb8F2GJgh+mw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-bKlyIBj8NI-mR3gpmbzMNw-1; Thu, 23 Apr 2026 06:29:38 -0400
X-MC-Unique: bKlyIBj8NI-mR3gpmbzMNw-1
X-Mimecast-MFC-AGG-ID: bKlyIBj8NI-mR3gpmbzMNw_1776940177
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so63244275e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940176; x=1777544976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEvldXsvdFOl0SSzAqnBPPCDIN4gE9YKYHWFJZ424fA=;
 b=m5hCN+htbt7L6mbY8IVjQNhKDtEvMB1756fZdM185iUWzMez46pRpRWDpk79r1Ku3/
 fXNVT+dRbv29fpMXg2FEZOmUfDXjwAYvd9+st1C5RJ32NI5+xhaWuAjyVNQplkpRUS5b
 4NAjlXQOzRwq2mzJeUW3JrvWHgmoJTg2E14RFg2yz77itOArNh3umLaAF1xF5aFcTC6q
 AdSqi1j6aIErLATFA0iqQKP/NTGPtgwykhKiFNPwM/OgN84z+NUmTZY5qjYcp38KcfIA
 hZVTKH4fTQPnPSsQXV5bCxVlauLB0rWRUSYKWxNkcJI8kLzrhSoZoN/w65EjU4koTbC1
 8Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940176; x=1777544976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GEvldXsvdFOl0SSzAqnBPPCDIN4gE9YKYHWFJZ424fA=;
 b=k/8yPWngxnLXon6K0ecXPWHNiV5zzsMdir6VofiIsXUkecwytdqqZNsO8SQ6ErO70w
 GQtO0Pfd9bBJH6MerAYIlvcD91vSL/qbs/agm62vIS6X9ptqPPq6z0pqAoonEW/QKBbb
 Tp65bwp9FWwnMW5degxAI/ijPPEjhXkxfuM2rDeQren5uWcJrgXFp9ct8ylLI6ldQ44Q
 XIR4tybASZisUgsadUsx3tkJtdIgE9XJ10fnSqqJbSgjett+e23ji9I9BQhoORvhGB31
 UKUuOPlb8kIrhHLPrPrmDFbFsqp3K0cZ5f01ZqC/dCVp97uTJAQEeLs+9SrgWcyEOwl7
 DQ7A==
X-Gm-Message-State: AOJu0Yz5ockENeSYOlzkhn9Ho91HXV09SyHSKRr7AoDKQYGSWuVgjUBJ
 5KiKFAHCUSSZML+FSp0z1Aytjp0XvtfDR7GW3fhtdFzwb6TT/Fq43VKQw/iiMNMAYoN/GsxGepX
 07JLcZP+kplNHDkNUHwNPdVX4v0xX3aHw4KCdhn3sjvCrtTKqNbK1fYMpPqp/LiqD0Hpj9BsvrF
 9ZCWcCCJCdAx2r4g1vUcYH1fPSpyYIW2TZxyv9mnKI
X-Gm-Gg: AeBDieue2lfvZuaVGtXPlbIb5BuSSeb+aaiBB3Kpm0SoLRXomJHGQdw0j+lDniaP31F
 Zd9HsiSphE8n1V3YP/WsB+NxmsXKDpMcBgx3RCGEo6PIanp7fXn5LtKMd7MIKSrdTlP97Ta3VPJ
 KwUG6Sy4CZpUP5qrV6oPAmBsFtUzt6vfZIyQRVs2NKH89zQnnWv6yHP/xDwYUi/Y2WZklk8+P5g
 t03TplWi0u7btzqTHXi1lisDohRxjTaat+KK2+Ee0arYROO/pWWAz3b1rcmrTCRdQzrTuxVlrSU
 muMrIy+ueE7JV5kGifUeBz4/3g0utdLUGrhx1a0pXZ0dVmaL59E/kh6+IYxaHeH9pX1ZEB1XeuR
 zUpMbI3ZD8jHjXMct/E41D6JqqcaH1RrwHw/wtrAPYyFvfR+Jx1fryjQAy+m0V+Eec1yQPr0B0s
 6ywDxnroeZYO9bXTbjfh6i87WoVqF0F84g0Rw=
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr398924715e9.3.1776940176157; 
 Thu, 23 Apr 2026 03:29:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488fb73cf74mr398924315e9.3.1776940175655; 
 Thu, 23 Apr 2026 03:29:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm56819161f8f.24.2026.04.23.03.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/25] qom: Use g_ascii_strcasecmp instead of strcasecmp
Date: Thu, 23 Apr 2026 12:29:02 +0200
Message-ID: <20260423102922.443639-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here
 (2) we want the comparison on class names to be a plain ASCII
     one, not to do weird things with "I" in Turkish locales,
     so g_ascii_strcasecmp() is better as it's explicit about that

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260327134401.270186-3-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index ff8ede8a328..e5c0c2f53ed 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1193,8 +1193,8 @@ GSList *object_class_get_list(const char *implements_type,
 
 static gint object_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
-    return strcasecmp(object_class_get_name((ObjectClass *)a),
-                      object_class_get_name((ObjectClass *)b));
+    return g_ascii_strcasecmp(object_class_get_name((ObjectClass *)a),
+                              object_class_get_name((ObjectClass *)b));
 }
 
 GSList *object_class_get_list_sorted(const char *implements_type,
-- 
2.53.0


