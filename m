Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C19C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWXu-0005ON-KV; Mon, 24 Aug 2026 11:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXt-0005I6-3b
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWXq-0007B2-FA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:25:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso6169585a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585105; x=1788189905; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hI/4kRcuHe18/qYKP2hOGxNnKh8pw1N2QjNp4C1E0DY=;
 b=eF4XRC5hQXjuXVosXxgCc4iJg9LohwVTdoZdLeTmAXihJsbP6OCYOQW9KKLM5cINBy
 a8+5hB7/qA0TxDb949hCncgtXbFqsadOwUbU5EVPQw6s7c5PbnLrn2QPlVIywYl7vVok
 IEr8Y8dhQS27QHf2lGyj1KStFYFV7wBWmx8BhO/nwW9xX9CcBs+0gw/cNqPV7Bq36Iug
 DUnZ+T+fhcej4RqHkbF99XrPI/NIKdpVrofSoeiW7QEyF2IEEIifdMpvJBLfYUN4FhyO
 fq0HRZ9O6yy/4EH85iOcZTUeZr9GiWUFyJ5kXmQ8+rwD/hKVbe7zZbrg3WPDgsmiWB/t
 tSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585105; x=1788189905;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hI/4kRcuHe18/qYKP2hOGxNnKh8pw1N2QjNp4C1E0DY=;
 b=deYvvC4AVPCs4lCvvQlQORCx4TSCgZXouFMiqwsekCDOmEEXPOB42bZ7hlrhkWwgtM
 g0FGhDpTkyweq5bUXfCb8VrCLv4rOGaTwq3JNFdrXzmtmzlgytuK0G04Dl39ZlHwx+RM
 sFuuqhgbWabEGBjRpJYz19fQIA12EqlA3xbGQvjcOj82CiARmbh6OKOSDs4fMpc/Qtd6
 6R2hGER1kZx2Zyh85zuwXB/Z6erSD3UQv9CyW/Ix04Z4B9kAUP6ubHvGp2fXJvPbNVzE
 0FwA1C8ZxiqRTTNczsJ8wzG1Oz5eZFOveDWIoEwaSXLI2z2PQ2CSZgB7VRGPk4QDzqZ8
 rkuA==
X-Gm-Message-State: AFuF++nh//o9mM/XCwq73nFxFf334SVueJlQZx6JWcUwy7l+A8zxJ1l1
 f9UkUEONvvIcPeowc+NrAvTarQgcoj0K+AkdY8vqgN1trzsJSYvZL5+xzmESSdjMl5Q=
X-Gm-Gg: AR+sD10WbFpCG4iPLxnod3Q5wYHEuPd7S2lbvpFqGpQ4m+6MAxfx12x7OD1HLGEOxfd
 uoqsbiOqzSfwV+3DedsgdbYrLtt9uaDUr/dIX2eoih16RILwJtY2PwP/u4rRBMYcjJEbDTAQe1R
 doJ/p9siqkFm2YcTxR23+53L/0ET2lWHOSIYb3e4Y3PNFRkRUIOgNd3iFM5IU47ZZcjzh/sq6nW
 bEKP2BpsqqAwX3ccmN2FtzPSr3VokG130hmGGr6Vv1ajfmrIWmZCvM4TMIeSMhHO9JayOWc8Apy
 dMATGfOi0zgXB419NnTToF686W57TJEjzAJRr8qVJh531V29eFhfOp2rJTJbDHT5HS7OcRT2t56
 0T1UhksDtsso5AlwEzeOuf8rdUf4Zts3ChxBlCvQoWgMazKxrE9aSWEhbB8cDfOQXdX/8NUnj3W
 Dcp+qSWAaVrMxaIfFk7Am+JrhOYsAjNn8/SWdBDAZuCAcBTzyr5bIGHaXJ59Sq
X-Received: by 2002:a05:6402:501f:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a582b5f1a2mr23050271a12.10.1787585104864; 
 Mon, 24 Aug 2026 08:25:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1d7399sm13500683a12.26.2026.08.24.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:25:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DD405F8BB;
 Mon, 24 Aug 2026 16:25:02 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 24 Aug 2026 16:24:48 +0100
Subject: [PATCH v2 1/8] gitlab: use .base_meson_job_template for macOS jobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260824-fixes-for-11-2-v2-1-352c6b890402@linaro.org>
References: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
In-Reply-To: <20260824-fixes-for-11-2-v2-0-352c6b890402@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=alex.bennee@linaro.org; 
 h=from:subject:message-id;
 bh=oLQW1QjvvZodHpTsPvGLeM5B3yePRIAQ/JBnkvtdcNQ=; 
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqjGJN3qf7wX053m0Vgz8GcZ4A0nHYUnlzOdQa5
 ZawJlGLedOJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoxiTQAKCRD70NsJWp4q
 RAulB/wOK/vInJTDlmAf73QpENyVwLMabK2Y4tqkw9Y5nrDa99Lvloe7cSUcJSkQ8NqSlnLmzV3
 UWmJLJAsdS83UWIdLbyaBF41rKEI7/bdlkiUAaYqb/6k+03oM/XKgbEBucCraRgcjGHzalOz0x4
 5mdgFZ6TuCEmV4p9Lxs2Rr/tv4UKNMTdNHt6049JYpgf7/HjI+OlwMebd4lu18V+3xfXD4N+1ZM
 WnInEaiIdzXrKvOAG/INgqRPhFhw0PIyKBCsmXwjdXAYl1VCaYnxeYP8yOlUOg7N+Qcz5DSA3el
 RZQEZcvDdrCPVATOSkXT4akAEDijBf1DxMMJMB9CiN/ATYuV
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This way we'll get more environmental information which will help with
debugging.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260723200904.224413-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 641a48b3832..bdb3eae18f0 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -1,5 +1,5 @@
 .macos_job_template:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   tags:
     - saas-macos-large-m2pro

-- 
2.47.3


