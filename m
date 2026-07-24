Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E5C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFWP-0002dA-Qn; Fri, 24 Jul 2026 09:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWN-0002YR-6q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wnFWL-0002ig-Ha
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50gT1BbEkOffJdXKR8tsxDkoo+2x5EtDK0ypy8SAMVQ=;
 b=fXsu/dCaZ3TudKOQOI/Bq4ilWZkmuEZoQRrKGnKOPS57psCKR5HDNtrhPfqKJ2ASkUJL+I
 HAFWP/f+rWlILBfvmIfwY98cFrOliCzzB1r/dBDghgWC4Wyd+LygH2KVl4DzI+48WO6zkt
 Y5ikZVtjbrLD/C/gUmz7HAO53BwYhrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Ql5UdiykOFqKEhbslUX9Gw-1; Fri, 24 Jul 2026 09:00:55 -0400
X-MC-Unique: Ql5UdiykOFqKEhbslUX9Gw-1
X-Mimecast-MFC-AGG-ID: Ql5UdiykOFqKEhbslUX9Gw_1784898054
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496b370b089so185965e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784898054; x=1785502854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=50gT1BbEkOffJdXKR8tsxDkoo+2x5EtDK0ypy8SAMVQ=;
 b=k6lFyoct0UCnHYO0cjENgMxTQaNV6hyiu5jC30679r7/iN/WopaNsHCR6pQeYzYExv
 fVS+LEFqk8eGij5cP6HN+p7LY2sANbn79O7JkmS2x5vMjHnmmMGApPLe9868P9yBKZ9L
 LllWmiXPaZpinslRZavtYZ3X6WKXrpIQF295FEpMn1AgWvKYHFWZSDdwjn4q0ZzgAMKL
 5g6UztezYo8kn5kmr6Na+Tpqrd6RVHeGG9vm5M6C+4wnqdr5JhGrB4cnZrW0Mao0xWBZ
 J4tcwrzCZ47gMGnc0sVCuxKG3h7l2Ro0zphe+3Mt50D+2m+0CWMQlcrvmpc05k3d/Rrv
 nhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784898054; x=1785502854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=50gT1BbEkOffJdXKR8tsxDkoo+2x5EtDK0ypy8SAMVQ=;
 b=JyzuDk/IYPHVZ2/DfdVEGL8FKLTpJWgkdpknhGQmrB+h7vgCgZph9xwQzJDyenS6no
 dZUtKWA6mnQGz2A1wA4MgF/lqXRTqJM0b9BUi43NjtHn8vfHWT8wqiUj4fLV3MHVQ2fT
 A25kyadZ0nB5C8DvNwC4gUnFaN6tLHCeicVjJx1E5Rvzxt7be55r5MQbvwrVnL7XsQh1
 g5YCQ87zcVImPHIgy40M8l8V5twCiaZqHyOlm4zs+Itk5oiUQAdePbsx8odfS6EWKOsr
 cuDEhdcIf/aEPB4tzRiCCNe1IVJvGpAKiN0yeqrbQdZIWN/+TDOSD4Gdhn0/MceQZkuB
 s/2Q==
X-Gm-Message-State: AOJu0Yzjj8Slp+eSSuEKc6cX7cRDKqGahJWqJxnTni4MBOHrhy4czG1T
 HHu5PyMWkaE9tJu/IysLpyiBr7zkxkhBUHHIfFgmz0nv+YxzV58SwWRzVBGPYD05sC1s8hmn3oC
 d8dqQ36CXIvChjr77RD5ooNbt2z0Het8vxDGN1kY2k3z2SjlaHHGxMZSrK4hHBiT5XDgik82RmK
 6WuJZGVzoF6I6d4W8+Ot2/yNJOnAFpTgItvuQjQjFR
X-Gm-Gg: AR+sD11ufWyYi6+3kqrjA00JjREkP5AwATzOr2ZQmYiH/sqvHx34yAypGiQ1rHsZuH3
 hrLO/vIUV3wyWVJ4p7uIg7NgtR1wnJ2HZqVNrVDuRQHbg+mNMJBT7GLKvzUaO5U5Twil7gZLQ+7
 MqjHrLy/2hUHTYBBL6wx1Z3DcnDF0RDhbsouInYCRIfD54Mj7aGPHlKRluXsv+F6TDXEcUJkDGr
 Ewdi9PU0qhNsmtDhlZHU7bZdji6oNs1KEIn1jT8/QuNXCFFN5mBSk35wFny+mFAg7Oohuw6j7f0
 FS5B50f68W8NkT4Lo98++9tift8K0jym7q/5Xk5uVf8I574zEx1ydt+NrhDql93YRAB2+OsuLnn
 ONVcW5TukvNgMpspZaY+pnRYYEhvOCiYM1YUocWQG1n2tOwNxwI+r3Ux3ne3smmghI+qb8ryAWg
 hGqaEr
X-Received: by 2002:a05:600c:8714:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-496997235cemr6082645e9.7.1784898053950; 
 Fri, 24 Jul 2026 06:00:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8714:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-496997235cemr6082065e9.7.1784898053448; 
 Fri, 24 Jul 2026 06:00:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afac1cbsm64499025e9.10.2026.07.24.06.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:00:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 3/3] scripts/qapi: pull c_name and lstrip from camel_to_upper
 to caller
Date: Fri, 24 Jul 2026 15:00:43 +0200
Message-ID: <20260724130044.1369843-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724130044.1369843-1-pbonzini@redhat.com>
References: <20260724130044.1369843-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Allow using camel_to_upper for other languages too.

In particular, the lstrip() is needed to avoid reserved C identifiers,
for example:

    typedef enum __org_qemu_x_Enum {
        __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
        __ORG_QEMU_X_ENUM__MAX,
    } __org_qemu_x_Enum;

Insulate Rust from this, since underscores have a different meaning
in Rust (though only for the sake of warnings).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..43a0be5f97f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -61,7 +61,7 @@ def camel_to_upper(value: str) -> str:
         ret += ch
         upc = ch.isupper()
 
-    return c_name(ret.upper()).lstrip('_')
+    return ret.upper()
 
 
 def c_enum_const(type_name: str,
@@ -75,7 +75,7 @@ def c_enum_const(type_name: str,
     :param prefix: Optional, prefix that overrides the type_name.
     """
     if prefix is None:
-        prefix = camel_to_upper(type_name)
+        prefix = c_name(camel_to_upper(type_name)).lstrip('_')
     return prefix + '_' + c_name(const_name, False).upper()
 
 
-- 
2.55.0


