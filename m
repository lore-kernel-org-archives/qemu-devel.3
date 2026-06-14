Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6C7CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhmB-0002VJ-V2; Sun, 14 Jun 2026 06:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm8-0002Ut-Jh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm7-0005cD-5D
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so21919335e9.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781431745; x=1782036545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thcwyP2EZxvPKCOKXUWJouAC+M8HXFANTt4YeT6lY+g=;
 b=VgLSgxaPR4nA8GNpX18XzUkyD1rv6aBhQ7YYuUL6giO0iHow0zDh3SlxpQM9QZOU+u
 9JGzMcda7OzMk7at5tYcYHqgpfeNU5zP+Ts2Ikiinn4FPiFvpfx0qTvshe0HlK0YD2gD
 l9CtidXo2lF3etmy75MihkzXC60UvsP7dGAAYvnAWDUqa1RQpKEuoNVkTUAWUqjCCZJa
 T5G4HJyI2ZZ+GDpgIj48jYsDynKu0IAdXK8o7CHQScsa1A38kUW0hAVCMGmI1j5Q4HGk
 u7n37kmKUkboMBmf3FsiEUSFBlLxk4n5aLi+IXuGg0bfyVomAJSoC3GWVd7OR6wsPCl0
 VteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431745; x=1782036545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=thcwyP2EZxvPKCOKXUWJouAC+M8HXFANTt4YeT6lY+g=;
 b=UK1XF1Oat66uvtgnQ2ztdTEhjH6vvCAoRxDYB+gqvmojYYqRWnVx3Y8K5XDpao5z1A
 JWKrkpc0ZQgGYS1fC9LUwTjz37fc3+M12j3itbaglEXR16Ni3vGWxLgMpzf3awAY74zU
 36SQhaR2VS+DJnVVCUUwBzyhx+K7WiltlVsrKUd2Nzb6k32vRMScL0wP9QgiRlgBpXbi
 fSwuuHfdp0gNjNj71scnchwLjX/4pObB+RKUU56QkuOmIP+OBTf7KlhEomHbDoACRfjO
 +goXuHoE+qjfqae/E1yToZagXB6d5h8PHZqIoxmaWFZ7YNWMEqwvCdeZeTsdJZDwYPhN
 5XpQ==
X-Gm-Message-State: AOJu0YyvBgjFU43svyPzDzLKY66+1D6gsiCczhMtlDzZPDH1U745Uu8L
 BKzrMOCw+w68pjqDQ/pwLx1Xfk+WSkdizVRPy0zHFwoIKZ7JHc0R7IgpRtYR9y0A/9Y=
X-Gm-Gg: Acq92OGquaAvr3T8TdRC6u+eWT1HTTTtVdBibQyGfx1SqzdOM4OBYuVxe2k3U6G8GR3
 6TRma2jUfg3FcKx/6ini8Bn+twTPwDUN8YnzlYKfBSUcjroEW+k3mI8uYADTF1CuDFiHHIOpvuw
 L0vYIjAsyQJaCDAkrlqpLyVR8B8/IM+KoDsW2e+t6sPSOm3N6uHB30j9mjFHrz9ADEWsPMSA5S8
 hdZSKeklgb73FlcCwtWTOUa+zYDIClr1KTOcumiB/gsv0TG2Jh29nqVOI1uDW3HHUtsl5SsH63G
 0YZeqlbTL3RCOdhG/z81+tgmFdbo//qbEmCWcKrdLTANdCFmpHUJRB0CxQUvtwXRA1V56/JV3Y1
 zvPUeTVKjfjv6bIIA5vhob+cB6DM2AamgO6Q9ZYfvLBF9B/SFMaEnOME4jxxG5IO1V7aFG57Lcb
 eu6hct5+q5UN7pkuf1aOb9N6A=
X-Received: by 2002:a05:600c:64c8:b0:492:1e36:552b with SMTP id
 5b1f17b1804b1-4921e36557dmr91169585e9.36.1781431745600; 
 Sun, 14 Jun 2026 03:09:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922037ba81sm151547325e9.15.2026.06.14.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:09:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31FBD5FADF;
 Sun, 14 Jun 2026 11:09:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] tests/functional: tell pylint not to check c-modules
Date: Sun, 14 Jun 2026 11:09:02 +0100
Message-ID: <20260614100902.885698-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260614100902.885698-1-alex.bennee@linaro.org>
References: <20260614100902.885698-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions. Rather than allowing pylint to introspect lets just
tell it to skip c modules.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260612140531.3530387-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/pylintrc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..949bea611fe 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -58,6 +58,7 @@ confidence=HIGH,
 # no Warning level messages displayed, use "--disable=all --enable=classes
 # --disable=W".
 disable=bad-inline-option,
+        c-extension-no-member,
         consider-using-f-string,
         file-ignored,
         fixme,
-- 
2.47.3


