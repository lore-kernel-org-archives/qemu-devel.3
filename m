Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950CC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9Y-00037U-SF; Fri, 11 Sep 2026 05:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9S-0002nG-3j
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9Q-0008Ak-9P
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=GKdMwjToQZKc2+6/0TDt09yNChbVdWBna57EAWiPsUNLxxJfKwmuCK1J+5t71lsMp4Lt7h
 TrMWNpoUWI/GPu1vjgj6Jcyv9TgPgWKq4/FNxf7RJ4CNfC1zhw03rm3QcfqhaFmuJFhVyn
 8IT4yx/8W55kGQRJyz37vykr+iFD16o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-w2HWd2HkM7SFQsFAQ18d7A-1; Fri, 11 Sep 2026 05:02:25 -0400
X-MC-Unique: w2HWd2HkM7SFQsFAQ18d7A-1
X-Mimecast-MFC-AGG-ID: w2HWd2HkM7SFQsFAQ18d7A_1789117345
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b0e6638e3so4914675e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117344; x=1789722144; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=TlcU14J83Gyb2l2It3vgMIrnCp/PzgqAIgmup3MpYCkD54wM1Vo2Bk7RMjnCVd/F3i
 WV9qjGgnRtxyYP01qQ9QKhO2Mm5QjDA6GcXn9aQTz7Mg8eNDjocz0TVCuch8MqptFJcn
 A2t1PtuixMbLARr4K+qmQTUZCCYChFbhiZB9uAen0ODtjtC7BHKK/EDzmuVlWNhxn4EQ
 gphCLP1Mo1i/8PG1+zA+tX4g6zTNEJytx+0qrcwX/s5/jUdU2/heudLfrqC6o0LhLyxP
 C1U3m+N0VXfXb2jk2+5YGjhtvFiPESGIf+lgxSFdL1YnxyuOtGlbzPAJo9/a4DtZMopz
 OXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117344; x=1789722144;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=PJUUUz7y/IeFZtT9pjOAN261TIMw7V1w8Q/wtEHqlRMZhqlYMhGdqDDIvpa6AjHaBM
 mszBUUQgv8MH1Mp2WqLxqg6ZyegFy6bKlk4Y/B+6M+rilTAluyULUzueQDKqlZwl6+qc
 uhTIlW20005BNDcMKZsvvwKbt901NlixqHfxTMq7HW13sFvq3oTURtSQsFCoBpKGI1hH
 2Nn800r3tBuwtPvY03BiQ9Wwu0Wa4LrM6pC+MaQ30UBnziC6pPMF+PZ6eqCOwy/teUVC
 YG3xPBsS/k7gqML/6j+JSwkAtJX5Fep1gGADgtohqxi1e5S5hLGS/muChc6UZUMbArvk
 rUfA==
X-Gm-Message-State: AFuF++k8u2SJTSKesW8upZP0/E1P6+D6xM9Y5ZQmmDXCRyqVTTLvubfA
 RWL1T2dkSUkH8jnaVy7tnwqfL8YswjjrIdDBYRKooNHlOZontDm4SLwItvlgJwbR+9yw4oJZxIF
 r5RHc+aIcomEYZjCgVf8JLdKzQCuChFDZPf4VKNF+rBC2e+oaG3IobrcygwuW64KxXTHDVHgQYt
 sOC8HMFWvmq5BgQAQ5jIyVoTPY4HVkpykoQw==
X-Gm-Gg: AYBFou3X5zJ6HlM9EuZieexdGrf00R33qoMfb+9gjdeCNhtz/zmfu9I66XZVv1gq8ni
 x9op0GnltA+VMIBFV/lZxOta0TeOS/ZpdZpgWpRgTRrP4lsIWpDV7PmYhRtn+uTUWEEy67EHW/E
 GI4Vg/h/hV68B0oI0nBF2aH+Cl/pY26IZ8NbW2nyl0UgK/0YuhSyGkNinnNNOES8gOsv/VGNY32
 bdN4/gCndPjJBuJKa+0v2C35+uj8CJpCatSSPK3/cOYUGhb/a2568ef2Pjzaqq2X7wHS0dZD9uU
 KNNTnarFCWLa1tSn+MYSXR0EufHT27cGgS5Ce1iD0Y2JdBUmGKzSXRzXXkvGrxYX7qNIbJ8WE8S
 b8Q9PbD3JZyy6JYf8vF/IUd4=
X-Received: by 2002:a05:600c:3e12:b0:49d:260c:a422 with SMTP id
 5b1f17b1804b1-49e619ce817mr32326705e9.25.1789117344232; 
 Fri, 11 Sep 2026 02:02:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3e12:b0:49d:260c:a422 with SMTP id
 5b1f17b1804b1-49e619ce817mr32325775e9.25.1789117343605; 
 Fri, 11 Sep 2026 02:02:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62232cb7sm35577375e9.4.2026.09.11.02.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:23 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 27/75] tests/acpi/cxl: Update CEDT.cxl for the default CFMW
 restrictions
Message-ID: <b7d4282ef014d3de1a113343f6688392348364ce.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Davidlohr Bueso <dave@stgolabs.net>

With the default CXL Fixed Memory Window restrictions changed to drop
Back-Invalidate (keeping device-coherent and host-only), update the
expected CEDT to advertise 0x0f instead of 0x2f.

[064h 0100 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[065h 0101 001h]                    Reserved : 00
[066h 0102 002h]                      Length : 0028
[068h 0104 004h]                    Reserved : 00000000
[06Ch 0108 008h]         Window base address : 0000000110000000
[074h 0116 008h]                 Window size : 0000000100000000
[07Ch 0124 001h]          Interleave Members : 00
[07Dh 0125 001h]       Interleave Arithmetic : 00
[07Eh 0126 002h]                    Reserved : 0000
[080h 0128 004h]                 Granularity : 00000005
[084h 0132 002h]                Restrictions : 000F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-4-dave@stgolabs.net>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b4646b5b31..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/CEDT.cxl",
diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index c35f3882eee67aa5613af427234d1ccd196aa249..ff8203af070241bd23dd0eb8a51460692bb7d229 100644
GIT binary patch
delta 36
scmdnNxPy_)+0`Xv2Ll5G<Hw0yRgC--Th)2^85kIN7#JAtF)%Oy0IW3!t^fc4

delta 36
scmdnNxPy_)+0`Xv2Ll5G<Hm_xRgC%*Th)2=85kIN7#JAtF)%Oy0IF37t^fc4

-- 
MST


