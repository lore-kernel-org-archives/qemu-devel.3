Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DA4E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGr-00045U-JK; Thu, 19 Dec 2024 11:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcg-0004mb-0K
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:34 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIce-0004Ua-8B
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:33 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436202dd730so7005455e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622770; x=1735227570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH+rg8jdfzKs8XOz5Rmt45E6mRet+pe4gCab1lfs0FM=;
 b=D7ZXeJZr5ofKw59jv923DLm0oi9TxTVRjwHOuUCuCd/YqgzIymoprjT5TVnDPbq+Wv
 RmI3mU3WVN1T8G24KwVcbzp6EfnWqFnmg+gDQfYS7DJDnI6A0Z/SEVEUk+4Dyzc+5lUK
 D0RZRNsLV3WjUA6HN0ZFT+ndzSV9cDPcSeYF6cRuYiW5hFCgr5tmGqQYlRhjCLJPXdke
 7Ywo1+hMvYJxLjxKHQjTdR15nPK8BCvQs1pMA/vMCL5xOy58D99M4rT6hH7wkc6h30Vu
 k1+zv7ooSz4RPtGFITrbMxQofG4eYwvDVjL2Y+UC+brgXTQuiHng0PyJQurypv+u2MT7
 pBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622770; x=1735227570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH+rg8jdfzKs8XOz5Rmt45E6mRet+pe4gCab1lfs0FM=;
 b=M0NFEJ9eWEFCrHkXq1Zso69xPEFlPdiVQ20sxOHsjz/GI61LA5/quXEckwUBijC2Fs
 HbO8Nx34IYbZoBPSn3cL7vA/ukwUSPxIZdWhsH9NY5JfNB+C+D9PavOFsiz2GMe3HPLK
 E0AuvmvOmP8B5MB2iEf0tSAVWAzMVgnytgjdLFT3IciNkgOGhX2r+MCbLor+sdWZuh0i
 1Z6uGwY4sz6/xKLfhrfPMfiG7GQNjDmODonFddQteeNfs+uF02A6cHxbcM/DM4qwleBp
 cpTIieYLHE9nPkTJAM86Z454IMAVhaJmha0rto7eAzUDk9+L+KPN8wPeBPKkT+fdP9o3
 jvhA==
X-Gm-Message-State: AOJu0YwywFCig8R9IbnNitZJqtbfkauk/RAfJl8tCMmrgkpE5d7rQOro
 bftSWp1NiF2q6e98AT3cchauSTUd52/FMxGMwCbMYVvyhAzlcPBB2z+X4hXmFRius7IB1QG6YOS
 x
X-Gm-Gg: ASbGnctPC/iVSRxoa9HjEA2MtLbCAyedA1sGl95QdvxyXhdesLKiIAM9HNVKPrS3cyc
 gQR2xsK3A7LWtYMjbXAOnHlk7wLNEVTwNRVYrEDWO2V7np511j0OKgb3qFRWVCxeMSW4en6g0y6
 8WUJzWhLiQGpcKf7iLAhUm82FyqlXlA1h/gOycsIsFDs0P/lC106P0hQOHjAWgVW1ujHqHeQ2nH
 xU7D1Rs/oR4XAIK1unG9UvY64BMRy1LY2IS6PCijPVAMiD9a1IEDZ+9ZDB+mbMO6vFRkf7zOYA3
 cCvu
X-Google-Smtp-Source: AGHT+IG1cGibHjPdP6W9bW+3KhIZBCePkeSAzYBfsPOjgibfVlHnS9VHv0awtKPj3xaf0XpdaTrpng==
X-Received: by 2002:a05:600c:468c:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-436553433ebmr67075135e9.5.1734622768851; 
 Thu, 19 Dec 2024 07:39:28 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm1844006f8f.81.2024.12.19.07.39.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 05/10] hw/misc/vmcoreinfo: Convert to three-phase reset
 interface
Date: Thu, 19 Dec 2024 16:38:52 +0100
Message-ID: <20241219153857.57450-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 9822615cfed..093bede655e 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -26,9 +26,9 @@ static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
         && s->vmcoreinfo.guest_format != FW_CFG_VMCOREINFO_FORMAT_NONE;
 }
 
-static void vmcoreinfo_reset(void *opaque)
+static void vmcoreinfo_reset_hold(Object *obj, ResetType type)
 {
-    VMCoreInfoState *s = opaque;
+    VMCoreInfoState *s = (VMCoreInfoState *)obj;
 
     s->has_vmcoreinfo = false;
     memset(&s->vmcoreinfo, 0, sizeof(s->vmcoreinfo));
@@ -66,7 +66,7 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      * This device requires to register a global reset because it is
      * not plugged to a bus (which, as its QOM parent, would reset it).
      */
-    qemu_register_reset(vmcoreinfo_reset, s);
+    qemu_register_resettable(OBJECT(s));
     vmcoreinfo_state = s;
 }
 
@@ -87,11 +87,13 @@ static const VMStateDescription vmstate_vmcoreinfo = {
 static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_vmcoreinfo;
     dc->realize = vmcoreinfo_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    rc->phases.hold = vmcoreinfo_reset_hold;
 }
 
 static const TypeInfo vmcoreinfo_types[] = {
-- 
2.47.1


