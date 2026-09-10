Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB0FC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4leS-0008Ij-Sy; Thu, 10 Sep 2026 16:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lGW-00016T-QG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lG9-0007uy-4P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=D9OGcfJkqhmtZw49eCTDV01NmzCdqdkd5HHYNijLBSa2S5BMvygZpjOLi7+3IV3vc29cl3
 eHbixVkPeqwy2aItoZIid0lrWeg0T2/RWRCR5FgCPy5ls6W55LVAIIcspRZjf93b/4sU1j
 MkvfjBj+ZXwVE3yh7x2HeiXkW/mf25Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-yl0y02OMOJ6-cV-pyfbLYQ-1; Thu, 10 Sep 2026 16:13:12 -0400
X-MC-Unique: yl0y02OMOJ6-cV-pyfbLYQ-1
X-Mimecast-MFC-AGG-ID: yl0y02OMOJ6-cV-pyfbLYQ_1789071192
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso1734105e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071191; x=1789675991; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=OQG6JbxmYUkHuMmNAsYrN6WIHo3okb/wu86fYon0ty9IGGAb4Cv06pQqo2aoGlbntA
 S1KuDzP6IflC0ioPcyG+oH9NQANoVJMj1Bt6h2YSS8qxUy+Ix2AMbeIyu2uzWElwdsNP
 qBcHt0gATWbLdSdoE+8kzjupmlYb8gRG6c3z6x22t49+ohX+NT1zyO1FiKiwdoEUfMfO
 0gmLOVaof/bT/zh7afZEpCPBy+2/Hh1Q3BwyHohsmsBgaCP3Ms43QJLlAeV/zeAG6H8E
 aEpDJMqHnUKMwEqpADzD5dkT9eDBIMzphqnFZRDVax0ukZPXcRtMxAWmXw+rMMse+kd9
 KSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071191; x=1789675991;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkq+2WPt2mey0qAVGmB0E6fFgehzww9kQ8e4JC/K6q4=;
 b=NAHCw5cRkEaYGaG9iT9+VA+M8APKXLiRYxlkvUUSQKWMj1/GlMJLks3vQPRgxJRYcf
 bmw7l64MIwImPLdnQlvaO/vm6eAkf0BqmWmJRyVE9/RyovfGAR+x+vbdGvIb/Ue5j7IU
 4uJosDjCZgcRGIBRGJ7+9YGFAWqDlFIQHUrbrfk0UttlmT+af4S9Jc7LWIDwGVM1Nigi
 hZ33Vl0CS8AyE443t0TApBxXYv3sxRs3YT/WDtpJfAYmRx6eNTgqPjglHl2GVRexGv3Z
 is7f5VvAfaGnQRumRpJTbvnsg6WO/pZTJi7WNynb77xfkgZgQ9dzhFHI7qrl6QpDni3H
 wAqg==
X-Gm-Message-State: AFuF++lgvQCOryrCeQymmkz7q3FdykmbNvWBFaNVEPtkLffc7KOripH7
 5dpdG7DyKZlIuylgC8ziPFppPLvHdb6ytla8wBCNNEzE/kvJN6Rhz1aoHMePk/vIOLEIiN10njt
 ovrIsvMbZPmPvEV5QCTwvsXTxCAinZCAXN92kD/Fqf2uR1borjHjXsxWTNYBfEtjor6mzW+KTSf
 eIyBMBlju4lZDLbwWyLPWx0OFbEFn0h8Obwg==
X-Gm-Gg: AYBFou11ZkCQS0eSwpdQakoXQJ133EY6jr4C5PbAlbU9PcF2esv0r7TVZibZvbuVyMW
 JmILeoDk811jJ6+csiz5qzozmVrlZXtGhkXmuGLHmwBrXpT9y7TQSBlpAQ8R8mUaNW4+e+T5UTF
 fENjZMza2it7VzwouDjoxkAUMlXe59lthsSpVARebvuwRVMcvynuc32kusg5PcgESWsNLBgysIe
 NTK9mdfcQ7tvti51X2adlVSZXkjSpHH27gKY1p/EDqs9X7f6gQ0RNxtcZo2HsOIN5TH79y+QJtn
 2eQ4ZapRC/qiu0wjiEGq3NiUuw6h7xamg9dYSmI4RnGPiT528OEauMNI9KcWuRpTKB5SPh3GziV
 TuejbCY72HEV+8tB4ZmQh5Ag=
X-Received: by 2002:a05:600c:3b11:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49e61645c2fmr13901405e9.0.1789071191363; 
 Thu, 10 Sep 2026 13:13:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3b11:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49e61645c2fmr13900805e9.0.1789071190809; 
 Thu, 10 Sep 2026 13:13:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e35sm94063665e9.2.2026.09.10.13.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 41/90] tests/acpi/cxl: Update CEDT.cxl for the default CFMW
 restrictions
Message-ID: <2591d8008c932c507f076b635d4071c58e723f5d.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


