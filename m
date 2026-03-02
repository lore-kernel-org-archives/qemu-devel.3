Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B83DD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzC-0004nD-Dq; Mon, 02 Mar 2026 03:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxd-0003VZ-2T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxb-0002Ho-ED
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEBmrugjpeYCeKqtbHbuxdvpok1uoogmrN/ghtLcbsU=;
 b=g9Zknl3HpQgL5R+uYrOJFo8NNGI4feHPzB5PlhNkX/iT5Citc0uruG5O4c79MyfFsWUK5O
 0dh0tjo/WiJT7Nwn7Eqwa7LdMv/hd2f9jCatQlB9KtkQuZkgmspCboR0BTMk7GAXIN6avW
 vp4j2iwJ0DH2CaISGZqCaOiPw/FGMC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-XEHwJzIcPGi9RCaYgxQ23A-1; Mon, 02 Mar 2026 03:49:01 -0500
X-MC-Unique: XEHwJzIcPGi9RCaYgxQ23A-1
X-Mimecast-MFC-AGG-ID: XEHwJzIcPGi9RCaYgxQ23A_1772441341
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837cee2e9bso33470075e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441340; x=1773046140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEBmrugjpeYCeKqtbHbuxdvpok1uoogmrN/ghtLcbsU=;
 b=Cmhtn3mjaJwOS9v4IE8dFDhQG6Z2v+es/F3e2uJMMhg7JXLZXhgITD/9yXcDxxb8+0
 VLeUwPmG/KQex4kyYT3dyMAqQUaiZvH6307WtNEvj9hR/3FdyU1te7JjXpvc9KrMWk+1
 UhCGIToBtwvIIfX0+P+jiGixPvgjHYH84umg2OkHO1CmBlOuMT3bIrR0vSn/XsyNLzWo
 zQvu1zXGtTdFx9ubgmy8IIrEyl3UewsOgcaWx6kfDNYtvo2Zo5HZmZBfrq3AD9d3UTpq
 kEMpoyPLEgjQATzlntdQL9apL/WTEovSga9rlzvIdQuU6heO0UuSbZ6YPZu2IfOGUBC9
 kuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441340; x=1773046140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TEBmrugjpeYCeKqtbHbuxdvpok1uoogmrN/ghtLcbsU=;
 b=jp/U2ib09gEpDUlTKvJpaCQ+LEViSQX99CZJLme2C6Gd3Fxm6b4lEkNG/Tcb89NgNx
 7bAOMlic/RObhRKVT9dx2J2ahfoAquIhW9vEzYR+1wOmYY0vVmhBEjizAs+CMQB6gyZ1
 feA/5FhKBI+C46jfYBKQYkuzDZ6WKQoXk5xN+dlDLbEO3jMXVzB9kcfd2NlD6n+ud0Ax
 G6CKGnpG8H4a24k0ElA+P6iSE4fX2o9Uq7463mSV26psCbQS+vdNX1DKbGhjvFqeIItt
 hZW/D1TCXZqENjVIQd0bw+tRwbVnBUSwyAvRyM/JI2Frxbv3rHiirpVEKp7lt1cFSWIq
 qJQQ==
X-Gm-Message-State: AOJu0YwR4WUYeXL2GA3mYTNBWyde2MPlNeOvRaFHvLBTjPSAOoCi0R/g
 7its7iT00WgT5CurFJXOreGJ1ccU+XVpbpfgOcZfxKFIB5CDF+nlXpS1boF6KU8RN2hKH8C7PrY
 iwRE+U1aqqvxHPcr9qldaQJgtI9y4hnWvMs+ySUSH7hQ6hEjLjSsBJcUyeXFW1VmxdzL4f2hPqd
 9U1lOpvx2I4WuHjp7D6FKLMsOnT9A6jMKzfBuubbVz
X-Gm-Gg: ATEYQzwR9pfk1s/BQNelXjtfe+lAcvqSV0L8OzIjj05kmY3IvH4N2SaRvaSDF7Ggi8v
 OFSnUOfSMcqUTJH9eBAwLt4vX75XXekw95NX0Uv1zxcCZByH7ukWY4YTT0Sj9gvVdJG9wUzJDxU
 lhEQJant+89AG4AaIfW0+1rLktm8/tiAaE4LXmpUXDNKEYj4mB6rOsj5jyjt5YYndZoX+Il5nqH
 uN6Dlk8exLGjcV/dp2CJjSexHmgQuf9gnjffRFRazsinNwRa6kvjwA3fnDt753dZwoi6Ps42YQN
 vm8qOOt5OnG4h2lppgJTlAAD9CD8/GZmG670Dqrit8CV1tf/kaKxG/UkVUTTj0ZbA5SycKreG7t
 nQpni8Uz69DWBxulEjPGcL+rBsk0W7CF/pX7h25ymFc4hGRGnuPjOoCtBaa+idIEv2w2wxNFk0w
 xRjWCyVCEf5SJIqCqH2jRZ3gAJOwI=
X-Received: by 2002:a05:600c:46c4:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-483c9c0f20dmr196013775e9.23.1772441339887; 
 Mon, 02 Mar 2026 00:48:59 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-483c9c0f20dmr196013365e9.23.1772441339407; 
 Mon, 02 Mar 2026 00:48:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbd781sm233713285e9.8.2026.03.02.00.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 094/102] target/i386: introduce ClearwaterForest-v3 to expose
 ITS_NO
Date: Mon,  2 Mar 2026 09:47:40 +0100
Message-ID: <20260302084749.474955-28-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Expose ITS_NO by default, as users using Clearwater Forest and higher
CPU models would not be able to live migrate to lower CPU hosts due to
missing features. In that case, they would not be vulnerable to ITS.

its-no was originally added on [1], but needs to be exposed on the
individual CPU models for the guests to see by default.

Note: Version 1 already exposes ARCH_CAP_BHI_NO, which would already
mark the CPU as invulnerable to ITS (at least in Linux); however,
expose ITS_NO for completeness.

[1] 74978391b2da ("target/i386: Make ITS_NO available to guests")

Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251106174626.49930-6-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2a869f5b739..01b64940b17 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5964,6 +5964,14 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ },
                 }
             },
+            {
+                .version = 3,
+                .note = "with cet-ss, cet-ibt, ITS_NO",
+                .props = (PropValue[]) {
+                    { "its-no", "on" },
+                    { /* end of list */ },
+                }
+            },
             { /* end of list */ },
         },
     },
-- 
2.53.0


