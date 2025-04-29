Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A6C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hpG-0001GZ-9Q; Tue, 29 Apr 2025 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hpD-0001FO-5A
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:04:27 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9hpB-0003Ct-AD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 06:04:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so6581632f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745921063; x=1746525863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2V4O8/0fPWhcbQ6zUapi9RTc8zQmqLeDGVXB3sb17zU=;
 b=SA4fZA1qFt/enKANWYs7Um+WHIdXYm2GeZw/wD3BOYSDvkOFSn5DnfF0DYzGo3TGj7
 JJYNdj+X2bZMAKU1DmhetDbaixhz+Y+5t+giwzD9GPZo5gK7pTiOCbqK9nm6WHFHXqKs
 bWcA9O7Cwpdl7RNRIvxiZ1Z9b6tcoFZArYIwS9+apePYOwlnh9VDxVzz0Qh/aO8u0Njs
 sLLAde+YD3gqMzkaDiE3xxTSm9Gwf2ZHsIlLtpiXh2BtPUx1WWb+rBQwNTopbg4pgwlK
 NnDl/HYneGX7wxlAfQaVimq3PzCNdQ4lhQM9mCzFMIqkz4oeZrjqD6I3AZ/a0CgEZYzq
 nwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921063; x=1746525863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2V4O8/0fPWhcbQ6zUapi9RTc8zQmqLeDGVXB3sb17zU=;
 b=qP8iML/C1VoBd7b6OtY7/yik/Zlgvd2gxh0SokFBcXBhbe2akg8d185pwNCYZFt88o
 3ohkNxFAktlQqvTVaGRh5dxMd4ll6YFrcvUvuDGxfc0rVln1uDfQfF+ayoKtWQp01x0t
 673XuiN5OLybIQxGFgbA1M87P+oCVZW0QiKEvgpSLXSttk+hadYtYLoEqR9zNwcByQwI
 bW4Ma9M6pChvIqkq1nAV+GiZBs7alL9565eAgIgVX/1SM6PeQC7MpY/G+8WrD++WJGQ6
 sdEbZ7O2Z3/LUdDB+M6pbdFdYIBcuy4L6tHeZs/bmR4RHH/j/KQCy3uMkRg2LaenmNvY
 fqSA==
X-Gm-Message-State: AOJu0YzwozfnJPsArMwEfVYWhjzvKP5bSsySwklgt9V5MGEF5TsbfnhC
 wG/RCrR86dLsOfpgyrba+ZWfiRzWr+SI/fzJgVuE1tcN5EH6hsm5ifLW6lYx2iPOujirHVOFpbZ
 0
X-Gm-Gg: ASbGnctkqHA0Wsfe7vX2aQklVDslYw58b/nZvXw6OKhBDOPlYTee9negIncF2LP92OR
 8gQrGxU/nZXzs4rNqJdFxH8wI+9hkr3AAYm1yj3sp/B/zDpNjLVPigiVCKqx6B9IdPlMnEaBdWy
 HzPSinYmhWcTbuGt0A5iXXYOBH9IguttaY8rqmYDgFLIelCqpAjLsUey7EaN9J1xoP/Jm5NqM7p
 UWIRKx609O5fLcO1RgEB5/Z7uWJbJVLzt+RwUX6cf3h3lYeL5+0WnUBTsHX06QkzW4ZLiBHR/ph
 RFzNZIB4krdnyZPb+yllKdgTxnOZulnSJdo8UQWQIYIdJEl2xRUl0qCSM1UkLsnlBCrBGdRShUS
 qaBVCbUVSKo64SqpqYGNq
X-Google-Smtp-Source: AGHT+IE7EjFdlrrViuZWJOb3ue4B/61CskRccHmZahUHDtOaRfdfbefu7VdkS+AvEbi4BUpkBnCobw==
X-Received: by 2002:a05:6000:1845:b0:39c:30fc:20 with SMTP id
 ffacd0b85a97d-3a0894a7f46mr2426384f8f.37.1745921062671; 
 Tue, 29 Apr 2025 03:04:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46a25sm13659812f8f.69.2025.04.29.03.04.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 03:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
Date: Tue, 29 Apr 2025 12:04:19 +0200
Message-ID: <20250429100419.20427-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

We'd like to have some unified QAPI schema. Having a structure field
conditional to a target being built in is not very practical.

While @deprecated-props is only used by s390x target, it is generic
enough and could be used by other targets (assuming we expand
CpuModelExpansionType enum values).

Let's always include this field, regardless of the target, but
make it optional.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine-target.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 541f93eeb78..3b109b4af87 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -244,19 +244,18 @@
 #
 # @model: the expanded CpuModelInfo.
 #
-# @deprecated-props: a list of properties that are flagged as
+# @deprecated-props: an optional list of properties that are flagged as
 #     deprecated by the CPU vendor.  The list depends on the
 #     CpuModelExpansionType: "static" properties are a subset of the
 #     enabled-properties for the expanded model; "full" properties are
 #     a set of properties that are deprecated across all models for
-#     the architecture.  (since: 9.1).
+#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
 #
 # Since: 2.8
 ##
 { 'struct': 'CpuModelExpansionInfo',
   'data': { 'model': 'CpuModelInfo',
-            'deprecated-props' : { 'type': ['str'],
-                                   'if': 'TARGET_S390X' } },
+            '*deprecated-props' : { 'type': ['str'] } },
   'if': { 'any': [ 'TARGET_S390X',
                    'TARGET_I386',
                    'TARGET_ARM',
-- 
2.47.1


