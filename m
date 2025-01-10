Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF68E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu1-0004kU-6f; Fri, 10 Jan 2025 08:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtp-0004eT-U3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEto-0004jE-1J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so15510845e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515082; x=1737119882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAvmjsWUf84o/4mAuJRMLKYHL08GWgnacPxf3n35oVQ=;
 b=PAyC/iBdauCqGe6nPXWjERSIFxeNxQZ8zmx+8vtzkJfT7yphqHm5FRRxLOUT6RZJE6
 aJ65FcktEuUg7j2FTe6pnSnbY03eY0vzXKjTXEUeV6W1pwCX6JtpLjX+gzNZV78Bl+WQ
 E658D8yG9v04FxN5aIQXpYFBuzRv5eiy+AITQAuPcXOpsGru9DaUJbYgm/xsza4T8JYX
 3MHllk4DNvI7oiPvV35QvaKlYF+B1R7PUTF3maxjm/O4gwa6Ze+hDFQfIldAikSsMg6u
 6IeMSDxFAj7GiDscjxlswmZj93NgrEXI2TjTBHQH3Mcvh/k0q3PEMiHTGx0EtRGJbWw8
 67vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515082; x=1737119882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAvmjsWUf84o/4mAuJRMLKYHL08GWgnacPxf3n35oVQ=;
 b=Gvoelf6VOhktvFvG6nMnQpk4i+rbGvrwAMJpccVyWuTwhttsxRUR99j3GVgneeltqf
 b3LulUcgnoFtSkrGkQFy8VSecH1iH1tHMPJxKGWDpnPnqXb6DDAEXrLhlEgUfmmhb3bu
 zX0iOPBaI2z5Bi9HzpTJkOCc03mNlsGGm0d5aFBWGoWeVP1rMS9d5y2hLMKgZxDzU4K3
 eU5RucGFILZNdUo2NhIRsz/mwgOPcdQlZnjdXeiI4cWiwseCelN6DoOg4WeMCJNHPX3M
 d46pMt7T8YpaflmAKWzfBC415qx7pfTbsRdE4baFz5naLdVScuohslAzfoTczaMzo9wr
 5Y0A==
X-Gm-Message-State: AOJu0Yx8JE7gj/wiqyEDBjEWKDYbF9Pfs/Xm6zDBpKnD2VU0b46CHnTE
 NkM+Vbmg2WxfVoqRqzVw0oxwnEOkYnDGW9ed5/wKk0AxF09KFuaz+d3ntY+anlY=
X-Gm-Gg: ASbGncttV220iHW79vyVcMVJgPX4gC0WwNa5XU5CsSzpRyyonoHw8UeNjG9m/lKtdjj
 BnptgVynsdpQ0biHKDQNQ3+RhlQ0khKp+okCfYn5thoNANpx3ROBIkigS+l2WbjPEfAfZxiW34/
 w4RSd+SoSIVh/o44V1wjJfD5uFP3HBavLu/vEjVmMgaTtjxAUaRiTkcH/w4ZkuiGrzoPPgG9FSN
 PLYCADJfkKJD/QQAmfdhDpD2NGEhCCuaFKJbGrdKem9o62id7jdEdk=
X-Google-Smtp-Source: AGHT+IH/sw/DW/fcMNR81L9MLc5Q+eL5yHC0nxm02COX11tRTWmHkW/BT1mADBWFXvMdXYeTvumcxg==
X-Received: by 2002:a05:600c:26d3:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-436ed504fc6mr51193145e9.10.1736515082471; 
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37c17sm51794795e9.27.2025.01.10.05.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3054160132;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 Virtio-ccw)
Subject: [PULL 12/32] tests/functional: update the s390x tuxrun tests
Date: Fri, 10 Jan 2025 13:17:34 +0000
Message-Id: <20250110131754.2769814-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-13-alex.bennee@linaro.org>

diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/test_s390x_tuxrun.py
index dcab17c68b..a7db4bfd84 100755
--- a/tests/functional/test_s390x_tuxrun.py
+++ b/tests/functional/test_s390x_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/s390/bzImage',
-        '0414e98dd1c3dafff8496c9cd9c28a5f8d04553bb5ba37e906a812b48d442ef0')
+        'https://storage.tuxboot.com/buildroot/20241119/s390/bzImage',
+        'ee67e91db52a2aed104a7c72b2a08987c678f8179c029626789c35d6dd0fedf1')
     ASSET_S390X_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/s390/rootfs.ext4.zst',
-        '88c37c32276677f873a25ab9ec6247895b8e3e6f8259134de2a616080b8ab3fc')
+        'https://storage.tuxboot.com/buildroot/20241119/s390/rootfs.ext4.zst',
+        'bff7971fc2fef56372d98afe4557b82fd0a785a241e44c29b058e577ad1bbb44')
 
     def test_s390(self):
         self.wait_for_shutdown=False
-- 
2.39.5


