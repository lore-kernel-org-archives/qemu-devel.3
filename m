Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7959ECC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOP2-0001U1-EH; Thu, 15 Oct 2026 12:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHOOz-0001Tm-Rl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:33:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHOOy-0001Ur-2h
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:33:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so3315425f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792082034; x=1792686834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=idh+qDMpz8gw8Z2xNyv3VkwIH/aLIMopmU/32yT1TlI=;
 b=tAeWjLkJFDsdMbl07oV0P6kyLgUmM6o5JFYExpURxxYPYmj3IkabNoCGQrJTjrYybX
 KyEA2SWB0vUV8p0i6FZGrxjLOvrnmAY2Ta/XH8I94BI0jnOkPAfyabHEzWstMslFfLOf
 jNA7Kpn34ka5/TsSduuVLjqIvvmmLWs6M3Nrm0cnutosYGciLZYamWIUMbnYSroZTLXq
 0oJlE+Dc8x/wRUYhv4D17m36Ns2Vjk+eId+ST75OdPQlfrCx2YXgK09TqiKpavFjCIk3
 deeovrMktfUBuqGMEsp7zYscjHIuwBBZ/Ztm0PBGyYgEvAdvXmhX7SwAu6sGR2kkrJQI
 t7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792082034; x=1792686834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=idh+qDMpz8gw8Z2xNyv3VkwIH/aLIMopmU/32yT1TlI=;
 b=0jGzvMVnpJ5LgpzY1A5zJ1iT8LXP1wGIRhTv2NTo2qicm+BFSGqnxV2+f29EfQZpWo
 oC4pVEf9GxP08nD5q1zOifjm2+7i7PIZYKeC0t1ufFVtu/uo+JehqzgTHZY0YrEAR2+a
 SEyWOntigABdwNuhYHi57OXy3ejoLygyAMrGPuWDYXsdTJJ7i/kgNYQ35tj2b8UNPemn
 TWjV9afsoieKH9XsWJM8mTt+iaQYroUsqm89IT3s4p7q+L2mN+xkI3+f0iTuTQYVjgl8
 CQFXWBpAgkyMOtupgS7UA1TmvPbxuYX6wIURL9to+tR1xzY8+vNJQRkF2RTkCgAdCfDy
 a2XA==
X-Gm-Message-State: AFq9FYIRHAMpSx3QV61M+bIaR/UORfauEEFvmFOujD3cgojMu99RNI6R
 NyuZCB9WBLhhKc4asK+eWoDJMGQ4vuBB0tqPQbJ1j8voUkWIho+dmO6oS5+qhc06kbJJPVoQjVd
 2stcdA/0=
X-Gm-Gg: AYBFou0sXUm2N3+nMeEIiSsbAYZUCzX8faFHXgHA4Y3HdnkRysAN4eE2M7xjjZO3lnz
 sRFDO0vfAluVJuVECCtm/I6DwqoJv66kSQO8dWCeIYztPrAMi0WXNg3msp9GJVzJ4cNvvzAoqUg
 OV6wkRzst3EbMJgeubVDGi75R6UO1IqsmBlV0be8eeeLAjQ3WjlCxdeF+1EMES3ckfBGayod52q
 F18fGxxyBFsH3dbT51/UEvU8lgEU34NBOfbu6ppspq4hSa1c5ff0P2RXc1iu6Rik2t2Y7l4RsOR
 q6/HFoQ5LHS+NduXZ4FURGjjLDn1+sK4K4txW3rQ3Mu2/3/3bwySNl71Ysg5uLYR06LZGaVIwQB
 VV0P3d36gEiELPk8imUcHQmNsqN9HIkoUzKRZ1yDFRxOHC12ODYrzjhRbUIg5UwCBEupJkc6fZ3
 B/TwfAe4MG8LaUGUhn+wZcUWCSBKNfV0+JLDIrKFyh67VulTsRQnqcVTGokhLoPD2cfmyu5HViO
 bYSnR8SFaKUn1b4IeJtFpHWrQIVUyHqxoCCkILAcnoSeuFVCUmBeZuUJ8mmmZWZ/9ha4tRQwn9X
 rhA=
X-Received: by 2002:a05:6000:2611:b0:48d:ecba:3cf8 with SMTP id
 ffacd0b85a97d-48decba3dd6mr11265415f8f.43.1792082034146; 
 Thu, 15 Oct 2026 09:33:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm5076118f8f.59.2026.10.15.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 09:33:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
Date: Thu, 15 Oct 2026 17:33:52 +0100
Message-ID: <20261015163352.1751191-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

The documentation for device_class_set_parent_realize() suggests that
the parent realize function pointer is "usually in the instance
structure".  This is definitely wrong, because the function pointer
is a class thing, and should live in a class struct, not an instance
struct.  Update the documentation to correct this, instead
recommending that it should be placed in the class struct for the
child class.

At time of writing, of the 75 or so uses of this function, about 50
put the parent_realize pointer in the child class struct, and about
25 in the parent class struct.  We recommend the former both because
it is the more common choice, and also because it makes more logical
sense: it's the child that knows (a) that it exists at all and that
(b) it wants to have a realize method that will mean it needs to
chain back to the parent, and we shouldn't need to edit the parent's
class struct because we want to add a child class that chains to its
realize method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/qdev.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 8e91e2fcb08..1330e0153d4 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -953,9 +953,18 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
  *
  * This is intended to be used when the new realize function will
  * eventually call its parent realization function during creation.
- * This requires storing the function call somewhere (usually in the
- * instance structure) so you can eventually call
- * dc->parent_realize(dev, errp)
+ * @parent_realize should be where you want to save the pointer to
+ * the parent class realize function; the recommended location is a
+ * field named "parent_realize" in your class's class struct.
+ * (Some existing code puts the field in the parent class's class
+ * struct; this will work but is not the preferred thing for new code.)
+ *
+ * In your realize function you should chain to your parent's
+ * realize function using something like::
+ *
+ *    MyThingClass *mc = MY_THING_GET_CLASS(dev);
+ *    (do your child class realize actions here)
+ *    mc->parent_realize(dev, errp);
  */
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
-- 
2.43.0


