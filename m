Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBD2CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsP-0006Ij-7n; Wed, 27 Aug 2025 14:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqr-0004x1-1s
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqi-0005q0-38
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILPyBa3EPQaepgfQdajd38RHPy3999CejRPB38Iy0R0=;
 b=DN5XDGZEhq5ZpMZqom8i/bXBx+OpjnkXIuImSWEG6S4o1qqZIQcwWRECQw5LnVbZGXhSt2
 V30Z7s/YvWfoI3P7qoynf7MMvDiodSSWDdo7477J2xRRjcK8m87SFFcWq8XSLjRbVh5KqQ
 frmMfQYYtBnTMrdaev75bOhX668K9iE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-CY0_4ObRPjyRZMwjMMERFw-1; Wed, 27 Aug 2025 14:26:12 -0400
X-MC-Unique: CY0_4ObRPjyRZMwjMMERFw-1
X-Mimecast-MFC-AGG-ID: CY0_4ObRPjyRZMwjMMERFw_1756319171
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b6490ea91so473525e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319171; x=1756923971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ILPyBa3EPQaepgfQdajd38RHPy3999CejRPB38Iy0R0=;
 b=i2vQ5bOMaAC/bVRY1zWeTc1WgwDNYWF01jZuVzVN+RUM8IWa/tCohsRg72qHPzGZlu
 YWCt+lE07Ke35L45HG4JZIpUsu99eT+bDqyj7KIIw/8IXeL/pvOIKSqNHlCDP2iz784n
 /NoHrouMmTI4wAryLSzMwZwLdNlQjWXQigTOvgRMVEJoYIip0w1rJaBpBNwgC/6J2zWc
 dspVjDppfIKwTVdm1oH6MVXV5y5+R4Gg16heUM6MOhTPks4HDS/i6MagoaAvhhLV28wH
 XiAE29SF/e/XRzH7FoAxIGqmAHwILSVs+7P5Ad9V3ouizw2Yp/tsTezXB1yDNxQ/oTs+
 ZwRQ==
X-Gm-Message-State: AOJu0YxAx45BlP7GLl6UmL5EoUrXS6h+jGY03qm9ZlxBkv0FA0Ts1ZNn
 /r30Vv8vsD9ND/DGvUskR1GjnbCnRRx06m138ohOPqWLXrf0cXBNDta69fvDfA4jOMAUeWMWXz/
 y6ifMl/a5zyKgNOVLuAjs8JTksW6Gp66iZKGcTevSGlAsAg1vnK8tS/XSXet90Av/j9rgBi/74o
 s4Bnir0sdRtTx31rOzqRUJMGFlA+1QelqS1m1AFQe0
X-Gm-Gg: ASbGnctKJv1OvUL4Xjl6kR2x79ZBGQ9/SlrdUUwAWu8JUCwvRBD8KLnOUR9QIO2wx4M
 ZrpVlBki/YwbMMOfDdbiLMpcP7XviVDFos1lY3dwevLIS7k4OUpA9A4FRDc1/xb74nZUTvrYEAd
 ExIuW1wnu88/S6q+v6nRgx8Vas431hbk75BmdlTJyxVoVwSvWgEtGYKNCIJj9ylz1Wduor8b3T/
 ldKVy0d9yXc9sZ6W2eQjfCr/wb5VPorrPlGnXxO/Vw1MgH6OD3cCS6+c/JQZNdbh3vikyAeqRIe
 6MvO0hMlQS51/fR2aOBVY+zzv6HsOUdl8sSSdgUJ2Rr/gR327t4jwKCE61JTjCN8Z3bnalALsfW
 VUQpfVKvqO3xzHzKeqOPcfRO0u+vll9j5SJUEDyK/L9M=
X-Received: by 2002:a05:600c:3b18:b0:45b:43cc:e559 with SMTP id
 5b1f17b1804b1-45b517cc0eemr175185615e9.36.1756319170861; 
 Wed, 27 Aug 2025 11:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFibySzjW08izRS99mXY79FL8mTf+OuG7nsiwtRyufJK/IQrREmqG+8w3B07x33hIfFjF3aUw==
X-Received: by 2002:a05:600c:3b18:b0:45b:43cc:e559 with SMTP id
 5b1f17b1804b1-45b517cc0eemr175185455e9.36.1756319170412; 
 Wed, 27 Aug 2025 11:26:10 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cb901975adsm7643845f8f.8.2025.08.27.11.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zero Tang <zero.tangptr@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 07/14] i386/tcg/svm: fix incorrect canonicalization
Date: Wed, 27 Aug 2025 20:25:25 +0200
Message-ID: <20250827182533.854476-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Zero Tang <zero.tangptr@gmail.com>

For all 32-bit systems and 64-bit Windows systems, "long" is 4 bytes long.
Due to using "long" for a linear address, svm_canonicalization would
set all high bits to 1 when (assuming 48-bit linear address) the segment
base is bigger than 0x7FFF.

This fixes booting guests under TCG when the guest IDT and GDT bases are
above 0x7FFF, thereby resulting in incorrect bases. When an interrupt
arrives, it would trigger a #PF exception; the #PF would trigger again,
resulting in a #DF exception; the #PF would trigger for the third time,
resulting in triple-fault, and eventually causes a shutdown VM-Exit to
the hypervisor right after guest boot.

Cc: qemu-stable@nongnu.org
Signed-off-by: Zero Tang <zero.tangptr@gmail.com>
---
 target/i386/tcg/system/svm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index b27049b9ed1..dea039b87a6 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
 static inline void svm_canonicalization(CPUX86State *env, target_ulong *seg_base)
 {
     uint16_t shift_amt = 64 - cpu_x86_virtual_addr_width(env);
-    *seg_base = ((((long) *seg_base) << shift_amt) >> shift_amt);
+    *seg_base = (((int64_t) *seg_base) << shift_amt) >> shift_amt;
 }
 
 static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr,
-- 
2.51.0


