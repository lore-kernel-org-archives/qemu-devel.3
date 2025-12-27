Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A71E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR1-0005VN-05; Sat, 27 Dec 2025 04:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQz-0005U5-L2
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQy-0003ag-52
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L11krJYxRksBQg3D1YvlTwwy3hlxeTdJtIaYO5UeY6I=;
 b=TpcGypjgM0sD2uGQAlk1eXwVv2FD//YHLyV5OoVq1Ep7/CXn75zRKiVS2ELln5KGWiqEdB
 e1PvdBUQlUfc3oExvraRUjCNgtQW2MI1rKPogIVNRsEC4WMtNP+4HrkWqnsnpySGeJWxBH
 pV2f7MzC5jWndTvIVKYTFCO4MVMmU58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-1tqQM5a2PB2iNs0_HPjqdw-1; Sat, 27 Dec 2025 04:17:57 -0500
X-MC-Unique: 1tqQM5a2PB2iNs0_HPjqdw-1
X-Mimecast-MFC-AGG-ID: 1tqQM5a2PB2iNs0_HPjqdw_1766827076
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso65463925e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827075; x=1767431875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L11krJYxRksBQg3D1YvlTwwy3hlxeTdJtIaYO5UeY6I=;
 b=TxZsYQNJHsQ9cE17VzUytRWDQyzAmvJUSXmPxKhA+DMNqccVoAwnheOP6VfrooHZrL
 Lr4Gz+fCvdkC7uvu2R2dOHS9fGwr5Pt0jnLn9EhmyTblck2kIVc9DTHJZEJyAIgHsw49
 le7ZPGtYFNo3xDLNS0MgUakZJSx7kJnctObvifkM5kOf+5J3kYYANHGRCpj9LddMLS/S
 QTVT85VgZ2JvYPpeLGmm0CkrTKJjTMf1xFLZbVi72D6TKccrLOy0eTORxLgUoQe47fr8
 yZioUXaoic1wMSs0+5vnayrAmBVPxDyfbL9cfSQzuYDm/ZeaSqsSD+GRyBz12lZsIZNa
 tXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827075; x=1767431875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L11krJYxRksBQg3D1YvlTwwy3hlxeTdJtIaYO5UeY6I=;
 b=HwxCBuEC85uRv/QFGQiMOOBjAxL2L4GTzM4hWXX8+/xjVVx9h/HGuyo+7NR02Ybt5/
 ZH0lR5ZUMk1sJAxKYvnoaRWXfonmZr7dy5TXmiEHb6Sjkg6s2lJat7bXtzE3NbzkKX16
 vCKjM7vflrMn+sAe2UOdIZQL1A2+2tnldVIxJjjhsP5667I87IkNcl1n+aOl2tMeb6KA
 /DwYtsX8q4AZjNZec5Wztccw4MbfMp9rXfQ5X9+l5du0TgyjQiZu++M5D9sqfwQeIXLX
 gyf/y76UNjJVnB/0GWJulK12DSjhf4MrlAyP/LA+4A01Mwtps+1G4hAgPUfsQvEwOk+t
 WhYg==
X-Gm-Message-State: AOJu0Yw27FwAC3LU6Humy87Vr3tm26ZovHLPmnWcdCo1kt4Xzozx7KPK
 xVhUMw3gi21nOKOUp2tdDMZbK0lxmYCIV8YgurPdR5ZHmOKajzIKp1314Kg3PzZtF8ptLSi7M2i
 kjgkMxoykHgS92A0kF6ghaaKGk5V0Y4TJZwqPAgZxGLUHExfEXOlUGK58nSl72zTyGPsyQ81ZzS
 bqPPX88bj1SvINkbKDWmMNhlN2yabyJsWDTP7HW2cO
X-Gm-Gg: AY/fxX5YeQoDvwyN4a74TITr5nwauazxru8Ux4XpVnJupA/IZmzdj3oE8weq0xM0Iox
 F8PuxM2Opl0/a7ybvVSXhxftNQKP1rzgEkixd0vzH+E3Ux9baEl2N7kdH/W4F28cmNABnU2joPN
 /y2QnFMNlFG3ODUm2/De4I/g25GLjC2yjPk93ky72WFov6pTfvdHADDog/Z/a7eflpEWLwOe6YQ
 ll/O9YJMdg0DOQDB9IPlaB23lIBvr5aUrfmfk4sm9AF0YNJLmVouD4s4hRThC2ommlSLNqT2ujK
 oZ8jLHmazG1gdmW267ZM5Ii/o5/jvfRdahxbXvUiXrBLBq382Chy8nhdeqeMW56MlGyDJpWnJW7
 PGlADbSL+rnD9KePdKr+b/S13rA2dTRwddM5paEwLiQyt/4wNDsx9EkOdno6f8K/cH83vNXQgHQ
 uB/PYXI+Dq7iKCi9g=
X-Received: by 2002:a05:600c:828c:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-47d19598e86mr220195585e9.36.1766827075411; 
 Sat, 27 Dec 2025 01:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9faMqUG7YfpBycBTmJ7aZzjfpOzMKiGs+1i7R9IBU7rOimRO7RqHvOV5P80WC1WfkdQRmvA==
X-Received: by 2002:a05:600c:828c:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-47d19598e86mr220195405e9.36.1766827074930; 
 Sat, 27 Dec 2025 01:17:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27c2260sm474525055e9.15.2025.12.27.01.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 048/153] rust/migration: Fix missing name in the VMSD of
 Migratable<>
Date: Sat, 27 Dec 2025 10:14:35 +0100
Message-ID: <20251227091622.20725-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The VMStateDescription of Migratable<T> missed the name field, and this
casused segmentation fault in vmstate_save_state_v() when it tries to
write name field by json_writer_str().

Due to the limitation of const, a custom name based on type would be
more difficult. Instead, a straightforward and simple approach is to
have all Migratable<T> instances use the same VMSD name -
"migratable-wrapper".

This is availiable because Migratable<T> is always a field within a
VMSD, and its parent VMSD should have a distinct name.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/migratable.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index 5700554f7eb..02efe31d72c 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -421,7 +421,11 @@ impl<T: 'static + ToMigrationStateShared> Migratable<T> {
         Migratable::<T>::FIELD
     };
 
+    // All Migratable<T> instances share the same name. This is fine because
+    // Migratable<T> is always a field within a VMSD. The parent VMSD has the
+    // different name to distinguish child Migratable<T>.
     const VMSD: &'static bindings::VMStateDescription = VMStateDescriptionBuilder::<Self>::new()
+        .name(c"migratable-wrapper")
         .version_id(1)
         .minimum_version_id(1)
         .pre_save(&Self::pre_save)
-- 
2.52.0


