Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B5FEA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAz-0002hd-4H; Wed, 04 Feb 2026 14:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAu-0002Jd-La
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAt-00089K-2g
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=03AkzHRloJMk9ZlcKj4KKHLNBGVRlt5Fh/16c/Y11xM=;
 b=Zwwy/lQOQvbe0Rnve848+LowkH49Outg0/vpsQD/51XQ9IOdavKACMlf+H2JuR4tPWQMTU
 oI4+pCj/iSuoIXLXAlhZeNEwna4/5jIdih7/ZXIB53MTxnKW48rpP/ParUSNnHzE2nvb8w
 tcyFz3lAQbre8tCV3+Xv+0xJPKHeUMs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-wMU2un5hNEmHSOvxLxHNig-1; Wed, 04 Feb 2026 14:04:25 -0500
X-MC-Unique: wMU2un5hNEmHSOvxLxHNig-1
X-Mimecast-MFC-AGG-ID: wMU2un5hNEmHSOvxLxHNig_1770231864
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso145234f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231863; x=1770836663; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03AkzHRloJMk9ZlcKj4KKHLNBGVRlt5Fh/16c/Y11xM=;
 b=BWiyFx7GL3d3fI2lM3Vo4ratpt3sIbuZq9W6fgmuqEYAZwAAKkeftXJD1+KOOBSXx3
 Hc2HAJWbw5b4u9LoCg2a/uLS/uM7L4e+D9fyrTMrd2VaQbbDq5m5FxrnA0j1HNMO2Z0q
 SNgzDC34Zho7ccQx89AA9Qaldb7nWM+0macP7eppw/yBJRr7ic9wZDJkEjRPDIDp5/oX
 VvlmTv1nfBDbEH0SnnlltKCrA52x+bhN6ZWlcma4rxvWbBauAxXeusLH5D8IEsePGxVK
 6zbjH8cELVSj8cjE29utCRumjwdQVqnUTapJbSBkAsp9wZJXIkK+Hq/aX9iVPm1YduaX
 dWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231863; x=1770836663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03AkzHRloJMk9ZlcKj4KKHLNBGVRlt5Fh/16c/Y11xM=;
 b=IdzHrU52866xXRPPnXinjT5R8z7mq1ePAzYOzaxVi+CZbIVmCCYt3k7mDrgmgXxndJ
 2D1RIrnDPlRxD2cSt9vrLTdlc2hMGGtwQqEf/HD1ctF4kaZhz8G9ZqyIUKbGYj59cxId
 S6TNe0PvtxyhC4ktXuMRZjIebxq3gsluQA3MI5FUs1AyQQkLkW489wdIueqo2uS32+R8
 Q3PvQssWdCTnzKFx+AAi9wvSq4/8mvuMu0mmEuyq30vSN16OHTgi4tVNBnJjTi4M2H4a
 VaaLAg2xeom5F3tcezCz28E6AK5Ph0Wkj+g0Ntc8Gdw1dik5EEGdWuuPCKCZHcUY2cVT
 Z1Yg==
X-Gm-Message-State: AOJu0YzEy4ZTBRNKr7Rd90DppSzuKGrsdCc7K8JqEQ5g1DOL4lQCUgti
 DevBmu5RL6nlfvXhBfQATO5IWYbIMIQgmFRZc3vK0uRz5OCNBmPJHVs/y5DWjJdeVDq+jTstq1H
 zx0xSskgxwYTR/TN0Jqvupb9cwixMSy2moAnOJsbn66BpwT9aFmzo/ODHH0IcvbjA1wduY6Vb/0
 3O+Ujpw2QcFE23KE0appnoE8gUbC33UMmwVQ==
X-Gm-Gg: AZuq6aL1QF9S1fqXxjldJkR7C7HgvvPAlqsoyTccV/sd1yWg2J0TQcQ7SaJusoY86oe
 QJT6GZ1PgWazqfBA03u9NEwCpm3yibOOOmEy0iWc6v5N9qpPsMN68GzZIzsFuE5MI/N6lMQbBfy
 +fVpQx6mQWTTCq/am6a5ESvOqs1kPjpmi0B5TvdiBtkdaYbwAMaPxNADVuuCZLvHE/Bk98djpMf
 Z2QyhIbYPxeBmS8rO77eznqzbAOqlpnPuWc8Y54SzVl7K/goTAgsc4j3ZcZQ6iZRjAPcGI/F/E6
 Tk/mnO93+AIZkTN89vPmCt9DsHuBk2p++4coS14gXn7d49k6O9j91RAHrUXtyfsw2dSq/Ve97X1
 cxzDGLBsp9NCZqaHdCvihcom4p0yyMKAA/Q==
X-Received: by 2002:a05:6000:200e:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-4361805558bmr5462829f8f.32.1770231863501; 
 Wed, 04 Feb 2026 11:04:23 -0800 (PST)
X-Received: by 2002:a05:6000:200e:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-4361805558bmr5462767f8f.32.1770231862964; 
 Wed, 04 Feb 2026 11:04:22 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805813asm7970389f8f.27.2026.02.04.11.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:22 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 40/51] MAINTAINERS: Update VIOT maintainer
Message-ID: <ddf1de5c2e1fa83d273f00461cc7d3a0fc798899.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Unfortunately I can't contribute to QEMU for the time being, but Eric
has offered to take on maintainership of the ACPI VIOT. Thank you!

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251230154844.325364-2-jean-philippe@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d049270777..ebd27cd7f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2197,7 +2197,7 @@ S: Maintained
 F: hw/riscv/virt-acpi-build.c
 
 ACPI/VIOT
-M: Jean-Philippe Brucker <jean-philippe@linaro.org>
+M: Eric Auger <eric.auger@redhat.com>
 S: Supported
 F: hw/acpi/viot.c
 F: hw/acpi/viot.h
-- 
MST


