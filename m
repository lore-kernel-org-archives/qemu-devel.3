Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411C4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGjg-0002VG-Cb; Mon, 15 Jul 2024 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjd-0002SS-Cs; Mon, 15 Jul 2024 04:07:01 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGja-00047o-QE; Mon, 15 Jul 2024 04:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030819; x=1752566819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cr4JZh2ySHCLoxlwCyTJncZxcFpDBYjniajzxyU5f7w=;
 b=X65XGRPwa3e72+NIh9GKlcmQ1Nt04zWpRH/ZdS0pDvytslJaS0yJwUo3
 Rqq82GPwVzLJ8fZ570WYOlzudSDibomrKVUVI27HtEvnh+zkVmfh20AkP
 fYZrfQH5AdXj97FiMNTyPAnfER+n55OV8C39avBKaxBcHW6sJ3AVu/gso
 P3r/zTkBuiqs4Eee1s6OG45truttfAXBgvNOqKmIzpScv35LieG8TRaEW
 7eqQS341CfNb0R7G7IFds7SC1wMk13Zg+Rhs4yQwrepvoy3fG4C89tFpG
 AudTGtB9ijSIp6u/2XTV6he3GqCvXbjEFfj/L3K+6Hm+VRhUlDpAU35GS A==;
X-CSE-ConnectionGUID: 3pRdSiAuQr2tHeqKj2Ei/w==
X-CSE-MsgGUID: EZ+sMNkDTqSzMK6Ec+EpZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935645"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935645"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:36 -0700
X-CSE-ConnectionGUID: 98Xu5bW2SkmFPUCdK1+h/w==
X-CSE-MsgGUID: aO1aHOwzTyKIcfBKFXYx6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512580"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:33 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/7] hw/usb/host-libusb: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:50 +0800
Message-Id: <20240715082155.28771-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/usb/host-libusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 80122b41259a..691bc881fbcd 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1212,9 +1212,8 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
     if (s->hostdevice) {
         int fd;
         s->needs_autoscan = false;
-        fd = qemu_open_old(s->hostdevice, O_RDWR);
+        fd = qemu_open(s->hostdevice, O_RDWR, errp);
         if (fd < 0) {
-            error_setg_errno(errp, errno, "failed to open %s", s->hostdevice);
             return;
         }
         rc = usb_host_open(s, NULL, fd);
-- 
2.34.1


