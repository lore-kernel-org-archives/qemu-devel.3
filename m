Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE75CC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzark-0002hv-Sw; Thu, 27 Aug 2026 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarj-0002hj-TO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzarf-0005mr-Um
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efH+CJ6lSj9Pg1zbktMwmOBeFLxVyCzz6CdqwEfipkE=;
 b=IwLC7fWRM0doQkexDarBhQ38BCST6+xaXmRz7JlZm09FXrEmdiI+WVS0LTQ8AqpyA92QPS
 APlo2IFQkveRyQmPrqV7Mr+VRkUP9xIOOvU79Z77R9t4jGTF1XcJEQTmUNbJp56Orn6L78
 bckedaksE3xMNbBTP3DK42kHPp8wYQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-nX9r4fH4M_uCs5PPrJFmpg-1; Thu, 27 Aug 2026 10:13:53 -0400
X-MC-Unique: nX9r4fH4M_uCs5PPrJFmpg-1
X-Mimecast-MFC-AGG-ID: nX9r4fH4M_uCs5PPrJFmpg_1787840032
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so14158765e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840032; x=1788444832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=efH+CJ6lSj9Pg1zbktMwmOBeFLxVyCzz6CdqwEfipkE=;
 b=sxdjBsLDZpU1p3BirPQBCaspc+ENA2OwfZdZVIUnD6wJaQ4XPGToHi8zkRGIX2CMXs
 h+pNf+gfzYwRf+vX7fNPzZRRGcBmdyjfz1N9Vcne9YC6MnyfwHP9u3l5HRgPlOUWKp8c
 TN5a4y5bkHPtgOgcdNbOYaMoB7p3JRcbX3Dq6Yvct2Hxrcm7q6HTOtRabd3CQ00IeFgT
 mp/VnG6KUC0dCaUPbIgwAbs4AHEaLUx3GDIF/Z+6HodssBvQy16u82QmS4XlVNHe4rtM
 NhIhcv018T3hkWlCDbe0ilLHRJrg08wmN324QRdKcpRGOqkNaq/W2GqH5R5Md/9Ti6jU
 qsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840032; x=1788444832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=efH+CJ6lSj9Pg1zbktMwmOBeFLxVyCzz6CdqwEfipkE=;
 b=IVle0B/22Ou9oD6zpEzJ4c+mUmOFDhMHv0GMM10e9b/zqgaq2QFrR5CI0SlVfD3RPX
 6s6p7RV35Vek0ShbrCR7qWbraKCbhdG0vwkAAqNuvbvhOtkBZq5hsCYEBA3WcUn4zRb8
 lkpKDDH+5WR3VozTWb095A46wRfYokfsLIPtu/36Ud6ZbAJ8OWIZwk7IIl01+zJS4pWX
 6CZuBbIRx5D0pQXbOQFnk0/TGAKQ5l6Fa8Bj3BUtJDmIsBxmiv9sf1vsCGw0Su9fJB9+
 mSzyrOzr6dd/sgN33hc5VEUKcMKPipM7ereaI3v/bFKeOf+6Mkan3/WDwaRTGer6WjBq
 kz9w==
X-Gm-Message-State: AFuF++nGX7XaJbB6rqC/jpY3aQKKN1+UnhI1NznFvxzSDLITlfsRHDXH
 0Js6uf6FB4u1mXU+646HQSDqnZfDTNJLvh2pdZIFXSSxlITzsaWuUMfXFD83GQLl1DYYZHTUPqj
 7M15pWtrewwwEgShCPsjirt6nMWkzv8n1say5J11LeEarteWV4Qr3KBnOUg/vx8owq4T3e3rV8h
 +QEjLIHOVp56qnfSjI5nJWs5MZz1JLqmqFt3YYPr2e
X-Gm-Gg: AR+sD12FvzBNhqAIuYUjdcnwTK8PezyEq2t0Y0yzZjchRQd9WfUjruom3h+U/uxFalh
 BDMtTXUkopsjrFQNsO2TuNYFx301zyGpVIPNsulikA8YOcM3ykprU66ML1wNJI80+hk3DFIDo2h
 C4x8p7n/eAoPp7wo6TvyAWkfdAxDbuL3xPk7lUgAjyMnv6oG+TEoKS3QULqlzN82wjab5DYqKpQ
 2+3qh2h4F8o2T72dzOmysQuGwMd4wKVgJ/D0aVCY/u0B3LyGuKp2C8OLEqmtDUp2fHjy1ukk5ai
 r9tOnsubICs3GJ0wg7UjjysFCKqL7yhBx1bT7UrzHyZeu/u2BgsQ3EOnqwry7cgHKpMGyvK8ajW
 FGgWd1zzFw5qN1K0RSN7oA2i1EBf3KQWlGL8w9jEqkOHP/zzLdV2RXj+236jFKh080iuDA3pJtW
 BnjEI=
X-Received: by 2002:a05:600c:45c4:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499dc8230e3mr181462055e9.12.1787840032312; 
 Thu, 27 Aug 2026 07:13:52 -0700 (PDT)
X-Received: by 2002:a05:600c:45c4:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499dc8230e3mr181461325e9.12.1787840031901; 
 Thu, 27 Aug 2026 07:13:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b0d263dd5sm45626505e9.1.2026.08.27.07.13.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:13:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/23] scripts/feature_to_c: avoid SyntaxWarning
Date: Thu, 27 Aug 2026 16:13:00 +0200
Message-ID: <20260827141314.1099352-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

The backslash must be escaped.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/feature_to_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index a52cd2e9ec6..4275b758172 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -25,7 +25,7 @@ def writeliteral(indent, bytes):
         elif c >= 32 and c < 127:
             sys.stdout.write(c.to_bytes(1, 'big').decode())
         else:
-            sys.stdout.write(f'\{c:03o}')
+            sys.stdout.write(f'\\{c:03o}')
 
     if quoted:
         sys.stdout.write('"')
-- 
2.55.0


