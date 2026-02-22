Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB656C6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASP-0008Bc-5u; Sun, 22 Feb 2026 09:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASK-00089J-Fr
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASJ-0006or-2e
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDeoaasGwmmImpda4GgNNJiqYPXvoxtfs4CRNeFN19M=;
 b=GKbS2P0lNdZ7otjGlNJf32ELZGwbhCJ8c2r/6hgBMaWf4JohupfA6vTmmk4vD7/uaELEf+
 MAIHOVRAkDG5tEWQO9HwKMMEjtFNM63B2WQBU9vCl44q9gW3ouY51+Pdfh87oAfqq7X4uk
 uX3w0xIIvqDAH+sPG/xi2VUXRN3nzC0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-0tjHwVCKNIOH1GJEy1hIaQ-1; Sun, 22 Feb 2026 09:29:04 -0500
X-MC-Unique: 0tjHwVCKNIOH1GJEy1hIaQ-1
X-Mimecast-MFC-AGG-ID: 0tjHwVCKNIOH1GJEy1hIaQ_1771770543
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so38838755e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770543; x=1772375343; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wDeoaasGwmmImpda4GgNNJiqYPXvoxtfs4CRNeFN19M=;
 b=qm7IEJ4hNBR28QLyvewWJe/nKSpM4TyPeUmk9tlkIxierm6WL+247wu6YImI8R3yt/
 BPv05jMHjDf0gy1xgpYa6tlO2dBTg06dzYYmaHHmYisKcVeoyCDZeX5WSYkTRBql4Jll
 wRQO2ebkHsA3lFAsVygbtt0a5Knep+O69EG88GN5f4SOfzvfGA53xBHdDOfBIUEr7Brc
 3gaMc+k8dAfMINbcoQt75pqh6aTMbdSe2LFZUhUAwtfZQI0blr7juJ95e53yr/viGPwj
 ko75Ki9jofU+dspzVPvu/CQ4jIwmkRQd61HJXcrFoWAHKooP+Jto7m+evboOHdxHEC+w
 ea3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770543; x=1772375343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDeoaasGwmmImpda4GgNNJiqYPXvoxtfs4CRNeFN19M=;
 b=PL9THQcWgr6zt0ZkFQFv1PlCcCHGuApN0T4CI2sfp8mYHmFeMP0MNiTl1Hw5ZkWJpC
 0ffA4jp3p47ep/QSoSEBm01h4qIAAKDikpNG7YDVZo/yRavZ0LBoZ+Vgnu6wKF/YNBic
 Y+UpdCpjNIgyK3q4GB03t9eX15FxsaGXWxB5damngtLr9TKRkT8BOneiSUEYBoVRHdp0
 j07gIZV2swExildvQb1ejeD9eqNbcZxjfXqyWELZIqr3QWGVk97R4QbpP09oks/ttq3s
 l1rmjtXLNVWiWPFywBGmIpZRVLN1SlI4tqdyVXPLJQwML2bSrU0Ah15ur3imGEhkmiBD
 4/iQ==
X-Gm-Message-State: AOJu0Yz5vv+681AEZxkxP/HWU/CLalX5foA/zdQIgokCyDI7t31WqigN
 S8xvRdWE8wvPKH0uwZ0slcMmJ+L8oa+bnMD0eOBTd5aVfGIDN9gyu8rPkmcgsYabLl1OA4DBrsx
 QBxKJJkJtp1JXuz3gytF/nb5JRzidTF18dhBYdOuN1XkoFnG2QlZzmCS6QiHvS2zlNoS8oOU4tN
 kXqsT0qTjcs5AEy4OIbJ7VTVLL4wRTM0X1uA==
X-Gm-Gg: AZuq6aI7760OL7Rq7soT5U9Ws0bd76S/5oLkHLyfJSDK0BJCsA6wOJ0G6hoPP4Hjgn2
 Y0dAH14ZvwxwhGifJ7yuzHLHGhb0MPu9ZKJbbOwh3XxWqXccTZtLq8oWVeP1qlIK7umhNt5yHV4
 2Nw8+RoMwdiu0D7vJCnj4HzkSRRTCIJwaF3MDKJ4Kp2VuAXz/5NmAgKOA53nYfTGTEyUJYC3oV1
 MBWFuioUrEBparMfT9i7syqReWl3FFUX8Jcw3XdVNVbjgsTrYbYkTpjVgMirjLfrdveAtt1P4oT
 BqUKMWTxpQNiNcfip3+rD+IOxIFQUuriW8vmhYp8Tpbijylfpys9vA1SD2ixWz3cNFv3YPI16KJ
 0UNEJYaYgWC/b6nkMoN35JWKNqVoTAQUl6v6TiwYSrdSEwg==
X-Received: by 2002:a05:600c:6298:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483a95fc1b2mr94599295e9.12.1771770543162; 
 Sun, 22 Feb 2026 06:29:03 -0800 (PST)
X-Received: by 2002:a05:600c:6298:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-483a95fc1b2mr94598835e9.12.1771770542624; 
 Sun, 22 Feb 2026 06:29:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a4e8d392sm164527995e9.2.2026.02.22.06.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:02 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 19/33] tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
Message-ID: <26cd3f8d96630d5735277a7fd5d5bc80fc8bb714.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

With the addition of back invalidate support in the CXL emulation relax
the restriction on the CXL Fixed Memory Window Structures so all
advertised ranges continue to support being used with all features that
QEMU emulates.

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
[084h 0132 002h]                Restrictions : 002F # Changed from 000F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204170936.43959-6-Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index ff8203af070241bd23dd0eb8a51460692bb7d229..c35f3882eee67aa5613af427234d1ccd196aa249 100644
GIT binary patch
delta 36
scmdnNxPy_)+0`Xv2Ll5G<Hm_xRgC%*Th)2=85kIN7#JAtF)%Oy0IF37t^fc4

delta 36
scmdnNxPy_)+0`Xv2Ll5G<Hw0yRgC--Th)2^85kIN7#JAtF)%Oy0IW3!t^fc4

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b4646b5b31..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
MST


