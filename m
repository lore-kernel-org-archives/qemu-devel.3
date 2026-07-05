Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2DDC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNx6-00089W-Oc; Sun, 05 Jul 2026 10:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx4-0007zI-Fq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNx2-0001UN-VN
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlTT0Zv6+Q1VR1ufK/CGHuyuiZoq5W+Y8sw9WEHE9hs=;
 b=I/pYRhjfsRvuj5Q4aY+cCDtawISEspDYe6ilR4spSyc3U9nU5XzYq/jpQtCtf2XQT3gMb1
 2BiwMDKgfSkh6YBp0OLgMvq+yRQM7vKOiZQgUgDa/LQDswUQ3qDZiaOQfmBYYneSt/TviA
 6057ydi//qzLe55tAubkeg/d6ia4K5E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-V5_COmPiOJe3yjG3umN4Iw-1; Sun, 05 Jul 2026 10:36:07 -0400
X-MC-Unique: V5_COmPiOJe3yjG3umN4Iw-1
X-Mimecast-MFC-AGG-ID: V5_COmPiOJe3yjG3umN4Iw_1783262166
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475b0b4e8d5so1525545f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262166; x=1783866966; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlTT0Zv6+Q1VR1ufK/CGHuyuiZoq5W+Y8sw9WEHE9hs=;
 b=aWhJFaoniXafjL7tYXU7zVzR3IunvtZNfgeXg4iSm9GHm18G1sSyyqU7/QpItawe7d
 j0vCx1gIjVfLS8QQOhfS20IBYFYkysH4Lol+1+7zkTUaoSTuOytZlMhxW33deSrVDp7h
 uQK0VPWZEVVLS3mFY/7JXJMSLfIJPn6tai3bPoxQjiS6L5rP663ah4/AGEaijegF7ECJ
 2p+XMDn8Hz/Qz5fh0VK6dLCy0dZFdAN0IBzQf88ZopK85t9FjT1gSKGRQ37zQ7P1Pf/j
 9KqJDaMX2iQks0awH4v980WoOWvzckO6Lrs+rF5DOQzp7Mc8TsMtYotgM81JNid8tt0N
 bg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262166; x=1783866966;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nlTT0Zv6+Q1VR1ufK/CGHuyuiZoq5W+Y8sw9WEHE9hs=;
 b=RVB3h+ZXEtEcCGXZtmxXESD2F/oljJPJx/IJ3nIM/hEiQr7e48UNZzXP0m0bOKqSuQ
 quCCGKBxQ5ppMBjDHpLskFK+qlHx0zFExJYHCmTNDYSM3D5Q5NfjVWoB1k7iiWNAsP2G
 lH+Bozl9NUA92btc2CHQtiTXp4qI6PF+X4PxpvP+wps5dumvtDZEjFIQdPhrf/4lREXr
 qX12u3yD+0nkSDnbYyygQSU4m4pNv3k7gXfXSRlsA0eof+0u/pyVQUcJwHcJ2HfNi9pt
 qls8TGttSTtf3wwb05iacI476bQgZHuYg8HZ412SCYhasWsCY8IEXYaeEyobToEndBCC
 023A==
X-Gm-Message-State: AOJu0YxTlLvw9H9cmBWZXRc1YbNf5obVewYdNof6BW7pQ/HMtKrmeG8v
 G6bVs85Sot7bY3oBP5+Gvz239oEuxW45JQALPNvVM1kJvJ7f8vI3rHCco50svRGzuMNqUnr2Lm9
 R/Lpld7v8dVO9UKrMZDGqs+s+pUgHTkBV6qn+z3eCSOAuJUKSby8AUGzscgY1Bf2yIsdQneIRog
 xZlb1Eh5zkyyLUWNY8qUy7GZ/DmUZ2CEWaSg==
X-Gm-Gg: AfdE7cklU40UjRjcKC5XkOPNzW4a4e5HE6JmG9P+ModzjmSTaia5pHCcq+6U1qB2Owf
 GIjsQ5pSnR/ahs7ttxPmPsuVkq9j4pudZcedusCEvjByz6IZCfEUvTD8dITph+7W01EKHd0ds5E
 PphUwEJtnS+J7YIXP0deENA9C7i79gFRTbAx1djqVny1uYLtGjktovE/pMME/cS3DIrBxa2pvtn
 mC1GnT+flMQuqtcJLC4bSR8PepuSQPuwtlHC75UNm0W8HN/dnGDaYw64SAcLB24cVbRbsAn6wPN
 tnS7XnPZFxO4kO6vv2WauHHNgtufbe1JoDr0sXLjOZ63O6zX+oRKko4BYUdPt8DqaB6Vb5OKJ1m
 mltCEMaksZwKN3sGCGh0+7nVMs2xFkzUH
X-Received: by 2002:a05:6000:46c4:b0:46d:8169:bb39 with SMTP id
 ffacd0b85a97d-47aad6436bdmr4685258f8f.37.1783262165792; 
 Sun, 05 Jul 2026 07:36:05 -0700 (PDT)
X-Received: by 2002:a05:6000:46c4:b0:46d:8169:bb39 with SMTP id
 ffacd0b85a97d-47aad6436bdmr4685230f8f.37.1783262165161; 
 Sun, 05 Jul 2026 07:36:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm17066425f8f.21.2026.07.05.07.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:04 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 34/44] tests: acpi: arm/virt: whitelist new WDAT table
Message-ID: <e9b2acec1de98cb9a71d85828c469757136a2691.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-9-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 tests/data/acpi/aarch64/virt/WDAT.wdat      | 0
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..135186b40b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/WDAT.wdat",
diff --git a/tests/data/acpi/aarch64/virt/WDAT.wdat b/tests/data/acpi/aarch64/virt/WDAT.wdat
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


