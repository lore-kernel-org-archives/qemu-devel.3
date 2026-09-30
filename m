Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ADCCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSi-0001Qa-54; Wed, 30 Sep 2026 12:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSL-00018o-2l
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:57 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSI-000328-Gg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:46:55 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so52386245e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786813; x=1791391613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hAo0Hho+maQkvebwGWazKA+nTqRTbj+QViTrc1OXNY0=;
 b=QIGknHhXSlpSOEd1o6duq22QLgwOVIylsjQX+t2SUsMao06HWNjiHHYiDfafdB2Kps
 ZA2uuHvLWxJUSdQeZXMsiCqtyWaJITKqI/N/Ph9/EofC3EU6O5juVecTr39OrUkhtH+o
 /ZrpePrnRueckKteZJX0CKPG/fkg/PUVNIl0k1IRi6bzAheTua2/x+Zycv1iJfiSMv/H
 fhLXl2bCVq473DrPh0H6dWppKjJnr7gImqu+MoWiIE/peixiVSui+bM7hDomuPTGd4gq
 wlRhBvzBcyDEFouUn9M2ooSwWiEyH/eQyKZjvHV0dlhPuPx77fRDrfqlog6hgtzekMeY
 3KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786813; x=1791391613;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hAo0Hho+maQkvebwGWazKA+nTqRTbj+QViTrc1OXNY0=;
 b=eoEWSF3jeqGk5ZaWgr8VMwL4mk6mkQk3H6d0RuubSVhBdaNRgoBE6N/d2CqvJV3Ewr
 FxrSeJIC4caqIwiFnOQyX3JPfwvjjC1sbBB/hgt1J0dwU4dc2XM5h+c3XTzj3MWh8nnE
 pxX5ItcKHAOTZXTh56ymHsaqwDAnjuKAaWyG0hZtSZss84pFmgR1L8EDfIDZJgtccmwy
 qVyenzBi0cyioVJlcFlYmvt/f4l2gmiZEzCfO3UdaSFpoWolqiIWPtTWqpJMBLzZ9tG8
 esV4m4J/cvU+2dkWPUGHXB++472g33zqcuUm1afXGlNlQAHJ8KVJ+UVFm/QRiuR8AVe2
 0SEA==
X-Gm-Message-State: AFuF++mIsLKrs4rNfHvrpYa4NmHSiQ9tm2p1krFbfalyBRKDsvfCVM6d
 4D8UWwuPEvyoA22c/yLiAuB7/SlyDqbeMsU2jaipQpTz8SU+8s3MuG1gTzP1gtwySOo=
X-Gm-Gg: AYBFou2PezqjQUKT5PWtDiWqiN9M0QPdMz46jbOfjOeIFAtFOTarYBI504fbPxcAxyB
 i6RUixSqhEicyUIClNkOnZdxTGZz+FKbwzlwrNK/fGFKcJHGzs+TcD73FL2XjfR4LXHt+06Z/30
 mPqNSdJwFN+QVo/+F7HymXD28ldtLZQ2HTNMY0f8wCvU8RvjKinB3PKAJRgM9qGSGBE1khc6Ui6
 wetX0xcT28fD+o2VHWCH26+A9Y+0tcIWhEAlAtxNwCMK5gdflzQNyUKCrOBWFNwhKabWd2qnUtf
 FRGh6lFw/boEHJGpafQoGphZ4ZDk2GjaIdDgLpeZOb+gfkXwxgZtJtvopPwPGh+lOmdT37aSsb7
 PCLt4T36PG1OUWjy9KVjHj6kMQg48h0gre4y3AiPES1GtHx5AhCrS0AyDF0tBsXiIFwdgpAOzt1
 aSdbETe2N1VcjcvPsDl/q0MMsdY1mPb5xjARoQTudm1vnR8DXUsA7zYjJ65yvS+5+fwGkcog==
X-Received: by 2002:a05:600c:46cf:b0:4a0:151e:f744 with SMTP id
 5b1f17b1804b1-4a01b01bb16mr35802825e9.22.1790786813054; 
 Wed, 30 Sep 2026 09:46:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb717acsm3662795e9.8.2026.09.30.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFEEB5F8FE;
 Wed, 30 Sep 2026 17:46:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/13] tests/functional: test_acpi_bits requires TCG
Date: Wed, 30 Sep 2026 17:46:37 +0100
Message-ID: <20260930164649.433573-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Running a full thorough test suite on a KVM-only build fails due to
acpi bits needing icount, therefor tcg. Declare the restriction so the
test harness can skip it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_acpi_bits.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
index ec716d643bf..62c57d23f6c 100755
--- a/tests/functional/x86_64/test_acpi_bits.py
+++ b/tests/functional/x86_64/test_acpi_bits.py
@@ -303,6 +303,8 @@ def test_acpi_smbios_bits(self):
         """The main test case implementation."""
 
         self.set_machine('pc')
+        self.require_accelerator('tcg')
+
         iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
 
         self.assertTrue(os.access(iso_file, os.R_OK))
-- 
2.47.3


