Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36961C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQTD-0004KK-Iu; Thu, 16 Jan 2025 09:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYQT2-0004IU-1k
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:31 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYQSz-0008BI-1d
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kfz/t/H0vrCPNearb0ZL87O6Nl+p8Kr51/xvrkTk6NQ=; b=Pej2dyL97bmwOGLtS4whFKYG3r
 KkZybTvvwCDhsEJZLX/mbGRs6hKBtTWBWF2Mqg8OnqlT16x0nD+mS3PJUvxJZ+yvtuHSFRV9Nmep+
 AKUmP+iLz6KXC4jb71gek1Wq3HsgdogzpdXx5eq9nd3DyxluV3o8AsW7dnX3wLRHmgDafKS4hAHjo
 GEzqiLvSkyFE0cltfFnlqV7C+pBkwelTk9NhxOojiwoQ85xu7Fad59URFCtQ15J3T9KFUG1dJKPNX
 x3FhWMbuQKIt8PBlB6T2DHXzR4BAFhWl4m595fbrpampydyJ5/RICtzrLV7KJhQmADsvJRC+eBB0A
 JsuXNVzg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYQSr-0000000BFGg-3GVT; Thu, 16 Jan 2025 14:03:19 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYQSq-0000000AJgs-1chn; Thu, 16 Jan 2025 14:03:16 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cornelia Huck <cohuck@redhat.com>,
 Peter Hilber <quic_philber@quicinc.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v7 1/3] linux-headers: Add vmclock-abi.h
Date: Thu, 16 Jan 2025 13:59:41 +0000
Message-ID: <20250116140315.2455143-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116140315.2455143-1-dwmw2@infradead.org>
References: <20250116140315.2455143-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+b63efa7a8ebec188a7bb+7816+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

This isn't a Linux-specific ABI but Linux does export the header file
with its definition, so import it from there instead of creating our own.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 99a8d9fa4c..8913e4fb99 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -258,6 +258,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
+         "$hdrdir/include/linux/vmclock-abi.h" \
          "$hdrdir/include/linux/sysinfo.h"; do
     cp_portable "$i" "$output/include/standard-headers/linux"
 done
-- 
2.47.0


