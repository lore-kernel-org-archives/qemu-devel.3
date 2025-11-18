Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ECBCED24E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIyD-0006UO-Qz; Tue, 18 Nov 2025 05:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIyC-0006U1-2I
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIyA-000325-L1
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763461793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQ7WlbbczLeQ5KuYJAuJ0aNx+FvO46piSKGnfzlbuF0=;
 b=HCtvUKxdgf15MzYTXh3lDq6xHABGboHNW6NIyY2rYxX7xiFjAH7j4hlaZnXEBGXfi1mZ+j
 1Wp2Ua9iMOy9TOzQr8vcIOfgUyXpy2d9/sbK+Hw0SthyFrBz8yE8TAtLd4YuUjNpu/jrJh
 L++kZ9tiuGn4OAGs1qmy8pRTAPH2a84=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-KJn2PZ18N5OEzt2k_M66JA-1; Tue, 18 Nov 2025 05:29:52 -0500
X-MC-Unique: KJn2PZ18N5OEzt2k_M66JA-1
X-Mimecast-MFC-AGG-ID: KJn2PZ18N5OEzt2k_M66JA_1763461791
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso9516325e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763461790; x=1764066590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ7WlbbczLeQ5KuYJAuJ0aNx+FvO46piSKGnfzlbuF0=;
 b=APzYpzgwGBw3Q462Hjen6O/nhjomOjbZuce+nKFVckw0NnCDidpXiXT/01CbXoqdxR
 p+P7EOGDsPTwQ7X1k7n/vsutSSNwTXasgtrUzAUxljE/mPKSOtP2Mi2v0X8zVaQjzW4d
 tT+/szPl9j/4vVIn1+ibV6I4aQGdLpb6Un4f6YAWbRIYA39kwXoxSK/fXy399OXLtEKD
 F/8MJLO6Wg6FPNUUy/ajStNtI4yqlx1wh8UmknwSRgPWwZ1PV7xEvu042RrL8XSVk56n
 +ZpCEePs32MqGfjcUfJeNmXow/+Gvt0Vg9q1f4f45mfBJBoQfWVYglNHb1Pz7Wdsqgcq
 jZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763461790; x=1764066590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JQ7WlbbczLeQ5KuYJAuJ0aNx+FvO46piSKGnfzlbuF0=;
 b=KBeeHQm8uIXBYWqIAuLz5DTEm7ADLe1xtWhKvd/xZJjase8WtI5196AWX9bmxOgBdz
 IKjQxv6mG5/OOevyMJqf4kY1I1Y2UGEcOEtwWj0v+48uUS5XVjj6BXTY0GjgeGCTvDyv
 oD+z/0efnokluKqZi2LBlcEPNZ6atJzJIlf6Ct3gM5Hc/2NQf0p1eHE1UpcQl/OBsYA9
 IbS7eCzcv8uKZvQGDfq+UJFjKXEWOmmjKM+Il7SOR8JEFuezwYameXLINaaPmZa3rEI+
 DYv51CY2L2LgB4C94U7DXHE6Psqn+PMeW5FT2+ytN3lleXQ9zzAdAcoOaPY/0MgwGx8O
 j59w==
X-Gm-Message-State: AOJu0YyQXkGhjmHPJNV3SqpuHW4awxZ9PVUfvgIGJY7kHYLdBDbvr8Pg
 rOu3vowY2T1rTLPCBUw4IonqWd6/tnxHTZgMO8RfqJjf11DvtPJLtIm539vlByH3vbgjmLJxD02
 AJsIvtvObMe5XneuShSvgQPFXjDkm8V8kSeGd05sWtMZQSc/eiM1W7NN0+yThuaa7IXbchzZ5DR
 W+R9idw2W7//Ex5Yjei0G/jE39CFyKY9sdGLua4yM+
X-Gm-Gg: ASbGncsnGpq6JE5mEDhlGfqvPtN5aj/uj29YYkCOp9HiZPojriC7y0mabs8ZoK6Xzt1
 DMi7B36WsOc90iptUvEF47+Fy+kiAgh1R5eNqFfClcfXmCJeTbgd/GCfLTBZKd1MkyHAhADssJn
 A4NrQcPAs6dhYc6vrn71u4Jq6+6i52PpRwzeS/9lcfzXTdsV20ou5KN0Kw9McgIDK7wSjmjvcKg
 p36E9RaN7HbDp/G/J1cwJQCc1FnhxLD+23koqJCFFkBNnAdU/YzLO0p32P5ykfPUWo1bA5N7+u+
 gNGe/WQL0T4ek2lQIJg9HIrh1j2J0abSj2Cz44BuiyUst56JeTOLxdaOM5RMzOzEuGQR5ej2nan
 P6ahDHD3zJjxUxgCczk1pz/huqIRRBGTISm1jx32icNNYywyGBLGwesBCMLz4A3KpT421XQ5RPy
 xpr/aQXGvCAclwsDQ=
X-Received: by 2002:a05:600c:c1c8:20b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-477a94acee9mr18386175e9.3.1763461790138; 
 Tue, 18 Nov 2025 02:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfm2L9Ud2ilQ45jMnPd163w8ihZ929wj9MA9oF/Qj6Qa+pcNRKVvMsR925j9Vfk97ksQzNMw==
X-Received: by 2002:a05:600c:c1c8:20b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-477a94acee9mr18386005e9.3.1763461789725; 
 Tue, 18 Nov 2025 02:29:49 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477975022ecsm195096735e9.4.2025.11.18.02.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:29:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 2/3] mtest2make: add dependencies to the "speed-qualified"
 suite
Date: Tue, 18 Nov 2025 11:29:41 +0100
Message-ID: <20251118102942.551194-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118102942.551194-1-pbonzini@redhat.com>
References: <20251118102942.551194-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thorough tests may have more dependencies than faster ones.
Dependencies are now looked up based on the suites being
executed, not on the suites passed as goals to the makefile.
Therefore, it is possible to limit dependencies to the
speeds that need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 891037e1d66..692e4867ec7 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -59,13 +59,13 @@ def process_tests(test, targets, suites):
             s = s.split(':')[1]
             if s == 'slow' or s == 'thorough':
                 continue
+        suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
             suites[s].speeds.append('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
             suites[s].speeds.append('thorough')
-        suites[s].deps.update(deps)
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


