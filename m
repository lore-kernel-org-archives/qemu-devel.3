Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB961C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2IY-0001uc-4T; Sat, 09 Mar 2024 14:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IW-0001tb-WD
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:57 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2IU-0002fj-IB
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:23:56 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a45c006ab82so385732766b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012233; x=1710617033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qhkX9N0f7mv4U6Enm7PREVuXkmrXKzBrsiRapOf0sE=;
 b=D45f31p6YZNSPGyEI0JMwiP7W9vLR7q+9eAsn+HmAteLYhMy49YrwCppbmSS+Ik4kb
 Xq9enhSzrG7H5a1LfkOA5r0oW5dNhXOYwO1bGjkSu3ScXXkFWjdr2bntvDHhqTGobGlI
 N5eTJ4f49MJ2l2BKEkI2sN3FmoV2XN2cvOwWdvtnT0/hnLpReLwK0JBLsBKyHPS6floa
 dnYHW5JJKP2XoPR4pJ6DwtAdU1mmRi75oMhpxwxpkSepGw45x9GQthFbf9lBCLMAxHIT
 18T8/IYJy8Nh8q5pjZbY5OWgHqSRMv5TpdDb9GI8vloYRI7hQhTtFDFtKq5EUKg5KDE+
 9KWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012233; x=1710617033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qhkX9N0f7mv4U6Enm7PREVuXkmrXKzBrsiRapOf0sE=;
 b=twUggYnfnQHZFBSOQSi8z74EOZTpEQ/VkzmAbzh5edU8YT0ZEKikZVvWxVDdapX/kU
 8dSrr8TT0nf5nIKyypKCfHiT7hB9ah0qfENGS0oETf9w1sK1wrDgGmHCfne6htRWvesI
 XLvjoFWXqB2KN7gPvd8u903/OHECsq7GMaOjhqG0KMmvvfMGYIcuJTu+7DzVP/3zLtf6
 m50tQXuYY35Y/dn4l6mB/c0Bd3xT3EVX/pfSyHtQGa5BlKOX2W/pEMRDIEY81NKavyoK
 EoIHd91M/gdiPvbXBkVnOxvgmRuMWiqtyV21LHwVkIEXbN6nHHUWq9E5e1PIWFqkqxVR
 ugLw==
X-Gm-Message-State: AOJu0Yy6yaZqpAjlY7CnJYI7TjS5VevLiDg2ku5InZD3JxMBoPqK+AIw
 EKTB4DGEyYcRxkx5QfNkTokMibXRXQf7ASzNVOdQqChmCKmg4b00fSime/+FCNKZpkgby20P+6g
 P
X-Google-Smtp-Source: AGHT+IE0pC1PtPPUFeJGmL9nn03Tms40CF9fkNhPdedtB8UjjmtZf/tpA8FjVipfHktzZdaLWkMqpQ==
X-Received: by 2002:a17:907:c28a:b0:a43:900a:31c5 with SMTP id
 tk10-20020a170907c28a00b00a43900a31c5mr1698253ejc.4.1710012232757; 
 Sat, 09 Mar 2024 11:23:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170906578500b00a449ebf3d58sm1178448ejq.85.2024.03.09.11.23.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org
Subject: [PULL 16/43] hw/net/xen_nic: Fix missing ERRP_GUARD() for
 error_prepend()
Date: Sat,  9 Mar 2024 20:21:43 +0100
Message-ID: <20240309192213.23420-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

The xen_netdev_connect() passes @errp to error_prepend(), and its @errp
parameter is from xen_device_frontend_changed().

Though its @errp points to @local_err of xen_device_frontend_changed(),
to follow the requirement of @errp, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240229143914.1977550-3-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xen_nic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 453fdb9819..89487b49ba 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -351,6 +351,7 @@ static bool net_event(void *_xendev)
 
 static bool xen_netdev_connect(XenDevice *xendev, Error **errp)
 {
+    ERRP_GUARD();
     XenNetDev *netdev = XEN_NET_DEVICE(xendev);
     unsigned int port, rx_copy;
 
-- 
2.41.0


