Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CF0C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulb-0004vZ-5D; Tue, 13 Aug 2024 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulZ-0004p4-AO
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulW-0001Bu-4T
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-369c609d0c7so3997175f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567977; x=1724172777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5khXz8nIOa0NpRClvdoX2r8/4f/59m4scjcy4bo663o=;
 b=zShRKooIWhMzaOkvvkQWO9Ng9dbt6dfGQSy54R+86/wMTyAfODMbTX0vHiStjL/KXq
 ajwQYbaQ6eQJ15FxEjQtvG+p6fpyQyhNzrdIisyZ504ArAJf50V820J2ptdzKoN492SR
 Gyms0NvsnYoKh73wHlmCyRhgt8H3vb9wKZK8GHbUPhVOacPZic7NxiRA69j8Y+HOmCF5
 24ugrHQhZF7lT9f0rMeqEII/hGONSb5TO/dPuI5xcW0OgQDtV5J22iNL9iNycwSTAcvf
 rryNIqqZF7IRW7u2GBV7fAJz3WGfJSWkQLJnNATVmhPEeMbA5sYxz1unJfgABdQ8JWpb
 bMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567977; x=1724172777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5khXz8nIOa0NpRClvdoX2r8/4f/59m4scjcy4bo663o=;
 b=Rwi+hYnzRuMsRpuQbmnMbNPiXBI43LHrUPrSx33jubuW6clvgzt7iyZ8hb1yv53sHy
 ymS+77nLWWofmEyjAnWUsjfPAD1W7lOLJCgzbFluA8+iVfYVkpcYn7K36xssF6zZe7DY
 hZhVQzZKNL4UnwfswKgSo7A2gbGc8OD8fCTZoIS93JZyD6aQeIsVPYs6b0zsHJvJjDRX
 kKw6K7OV9+/SOVj0vPQ/GOZt8u9AQ/S2R2VViGhgfxuFUP7o4a5V7QlsUfzH+HMPrtTH
 ZPmteN5VTarOH4H3v5OlOpt5Kaq6uZngiFSKoHTMpnBsMJg+vegpDvFsBg0Jg96MITwd
 xm0Q==
X-Gm-Message-State: AOJu0Yy3wP80iNvjuXpU0JGze0xy+i9CAT083MMoOtrDIdz+TydSHE/T
 pfiAydGgUZEfjQg79MsOMgwNaRmVON2+xoUCSs/REkeChNSCXGWjvKKmvnSNTuhlbbM5BvH+Wm/
 r
X-Google-Smtp-Source: AGHT+IHa4P2Rt/PwsLIXZVREVsrEgNR0O+p8fNKkO/2H6+JgcosPugYb6lHWbbYeCjAXw0HC22O0Ag==
X-Received: by 2002:a05:6000:1971:b0:368:7282:51d6 with SMTP id
 ffacd0b85a97d-3717775dddamr210728f8f.21.1723567976601; 
 Tue, 13 Aug 2024 09:52:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 06/10] hw/remote/message.c: Don't directly invoke
 DeviceClass:reset
Date: Tue, 13 Aug 2024 17:52:46 +0100
Message-Id: <20240813165250.2717650-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Directly invoking the DeviceClass::reset method is a bad idea,
because if the device is using three-phase reset then it relies on
transitional reset machinery which is likely to disappear at some
point.

Reset the device in the standard way, by calling device_cold_reset().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/remote/message.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/remote/message.c b/hw/remote/message.c
index 50f6bf2d495..38ae6c75b4e 100644
--- a/hw/remote/message.c
+++ b/hw/remote/message.c
@@ -215,13 +215,10 @@ fail:
 static void process_device_reset_msg(QIOChannel *ioc, PCIDevice *dev,
                                      Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     DeviceState *s = DEVICE(dev);
     MPQemuMsg ret = { 0 };
 
-    if (dc->reset) {
-        dc->reset(s);
-    }
+    device_cold_reset(s);
 
     ret.cmd = MPQEMU_CMD_RET;
 
-- 
2.34.1


