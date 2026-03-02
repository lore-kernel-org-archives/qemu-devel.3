Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990FBD58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyt9-0001hV-Vg; Mon, 02 Mar 2026 03:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt8-0001db-0P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyt3-0001X5-Sp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HQjBhjFRxNhvZlXQXmp7fDntSaNFvRiU453Z3afMd0=;
 b=WWbiioHWzIi2b9vQctp5gV7H07MDRJ7i1tnR+wQdZdocElp2HzG8IjLXimbKwgdNYxH1RL
 7j435SI/6WhFtdM/C/ZRHFORZogHISCLgdbBCE6c3V+PRtuxsw5G8Y//DcWCYrhNuD0VA/
 WJ98Gt1ChFNPadiLqrDyNcADU0UQxMs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wV6ni-wkMf2iLMRc1115oA-1; Mon, 02 Mar 2026 03:44:16 -0500
X-MC-Unique: wV6ni-wkMf2iLMRc1115oA-1
X-Mimecast-MFC-AGG-ID: wV6ni-wkMf2iLMRc1115oA_1772441055
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso32789075e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441054; x=1773045854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/HQjBhjFRxNhvZlXQXmp7fDntSaNFvRiU453Z3afMd0=;
 b=YWLbUWqvgtJYyjxV5eZGEFAhpudXpl9mFT5/9gdZ6Al8N0Ilgbxm7Tk4Tp3n20jJnU
 BBJXtr5iiJuMG8/Qgqq5C2hJ0PSZtvicgFRjFM2ltI7hPVk2HKV8JAnS/GFrnrnpbEWw
 /QTbto4Dg2NPh3B1pwosMZckA5iEAaZHjv4rC6GE/NTIuxLACkfZVajgaSVuptdHjw1r
 /HwblO5BSAH/QRl/N1orCvNWB7Rjrr2r61+HqlwR+ylReoQPKBCZsfswBW5uroJDoNhg
 sw84s4er5xhjjCIJJHvEiHyO5f9EYh7U4SoP4/vL5vdS0j6ypFpLdh7ywpYB59heBA4P
 kwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441054; x=1773045854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/HQjBhjFRxNhvZlXQXmp7fDntSaNFvRiU453Z3afMd0=;
 b=ZKkvPhBK3l/TO6iXzM0tNSXxQhB0QbZG/Z23t408rgMCMkbzU8iZtue+Q4rWre0B+c
 u+kKi/guuuyIRrlO46GYORXYzvn0i1mP1CRSqV9FuGS8y5OV9xZdmhCpOzUkWzXebTlu
 /v2SoyLyOztu/GAyyIOKEyYfqaB5UXVmi5skMC704/NH2G/7hTDpE9uT+H7Mr40rQkTV
 G1EvGuXemdf6SVJg44msV/VYVMp4m2TLOcdVpFHYhtkF1bdksi+2llfWmkNYeTWGyyB0
 jHKH+YZrdMJxN2fL+rf5N2BM3A8LtIgApI9+Iw0O3T1ZS35RUsZoaNYVd5Usk/bdvdwl
 zi1g==
X-Gm-Message-State: AOJu0Yxkkx43yYGxpkznWy5jUdE1JN0TuithVfDYSwkp1you77Pt+2AV
 Ibs/hfGZgk4kUdpgw5InAA4tQMvhCCcGchAH1r8IODxn2D6ligqICEgWFj3XYD0PLnubh7K2rg8
 dkBMhEEbkh9QyS0XmkaZbwfeEF+dtBwZutFEQ08aTKdeyGoEy0cb5vHh7ufiFSmZSR5+KPyPhXI
 RblHDWb65u1s9B7PmmzkKzasZXiDPEqtOEvxmBJ8T8
X-Gm-Gg: ATEYQzzXTW0TxVACnNRU76HvWRE8sSJIMv851IOYxEt0cUiOtoabFjdjusdQJPuS0vP
 JPIQNdgFmGdwN978FR4o//Jn3X1z2TzEue+vcH3TVGyjaz3ba15bhxVa4fubG3i8Yxf0/IL7Gvo
 j5TYWQsBynyTPBJ38LZ3cUPJsxDC8X2Vy1cmnB/n2+UddDMXyYTctyXmxJaqpHEZpIdlScmrKT7
 FlEHCEI/+W4v5CgTuth7e4MClWA4q8qpQqCGSnPw+pM5Bzq07eSRWf/wAyJcsxZ9Jb6lF8fqguz
 NvfwTjEob+qnjxJsjKtRrIFkTX5YTHN/1WXigAr0YuI97M/V+BtlAWwRFKEcbjv4bZHP8ouXpT2
 BxCvYG6f9xB8b4Tlr/+KGwj30rbU+16QLWEE8IW+hxzZzZYgL4vv2sokAij2a8A7QMIe97ujGoA
 4dDyWhRc0Hr6lBT/sc9+X64D00I94=
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211384465e9.2.1772441053638; 
 Mon, 02 Mar 2026 00:44:13 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211384025e9.2.1772441053151; 
 Mon, 02 Mar 2026 00:44:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b485a0b6sm9624965f8f.39.2026.03.02.00.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 012/102] whpx: i386: flags conversion for target/i386/emulate
 internal state
Date: Mon,  2 Mar 2026 09:42:07 +0100
Message-ID: <20260302084338.473368-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-12-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index eb6076d2f49..05248850530 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -412,6 +412,7 @@ void whpx_set_registers(CPUState *cpu, int level)
     vcxt.values[idx++].Reg64 = env->eip;
 
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
+    lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
@@ -637,6 +638,7 @@ void whpx_get_registers(CPUState *cpu)
     env->eip = vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     env->eflags = vcxt.values[idx++].Reg64;
+    rflags_to_lflags(env);
 
     /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-- 
2.53.0


