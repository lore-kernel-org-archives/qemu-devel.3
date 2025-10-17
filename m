Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C08ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXp-0008UR-97; Fri, 17 Oct 2025 09:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXZ-0008Ry-Hd
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXO-0007vy-QS
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso917752f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707820; x=1761312620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A78zNbnMmecNZ6Tf/K0Gio4uGTZm2OiwrEyaD1kmTEc=;
 b=FppZNboQgEN3bEqc9q4b5jxE1pIQ31Trl3cwDt3ar1c8E4KkmGb0fRn8ZVJXEq8fLQ
 wn90sQIN8iYrVMpW1mOE5R/huv4EdRPi0q/iUGN3WDIWYZBXLGdA5Vb1lXofLu9VPfo/
 6Tf81MxoUYRVesceRU3aXT1bwwcpNQMcMiefYJFENrYTrJGlDbbjReaCJF2ykrh40/Xt
 ugRD7D8EIrOwqliYn3/fvQOpRnckigrWb26oeU4qR1QFkXTioQVF3WFo6CaptD3Fv2yu
 vxLP8nsv0cT4s5xSAUGmbAtftFwCPvRd79bc9NqUwWE4tOKLd3YprrsdhSYh0UklPQk9
 I6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707820; x=1761312620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A78zNbnMmecNZ6Tf/K0Gio4uGTZm2OiwrEyaD1kmTEc=;
 b=N4j2L+p0ir9N9Q+d3UNGtxs/14DfoI7B4HaQ/xAJlhu8IF3i1CVC5aMKbWdv8TcDbO
 MpTpvxW3wK5bLptd/DSFNvuizvCWRDUBD7JU+W0Z7+2SqH9E8d2zpM+N1pprDaSSRl+b
 jV6UpMMxU59BIvWQvw5Csg7I82rkPpJLGnWvvrHoPk4C1R/KA70ts98BGY+AGLbPeoc/
 jbEvRAfOQ3EM8gV89OgleVoiN7FAvYU/zAzgUMtF6+9AGmv3FdsS2KC1Chqos89vjnOL
 +8RqFAXoQ+56JwyNdF4J0/bXliDY6xzIpeIy2GvC3XG1gO1e+SvR2kvC1EcDV0dGSGHp
 2IUw==
X-Gm-Message-State: AOJu0YzCw/dFmUqdhwvKebssrTP0WCsI7ZThqiEeHYiGHVYz9RuovoAI
 4CQfhBbjfhtRpUy1gq1g13lUObMuMun2zbHDLND3rgBpY+NSSOxxOax7xO7eqdJ2OOWJd77daWa
 W9U1pmW4=
X-Gm-Gg: ASbGncs0BdHh4e/wyGPojbE/3GGxWFoWRtEI8xhTA5ofuZd3DxEDi0Bsghhr0XMgAYu
 PnuLfS4oeR6Ae02F5GyWaVs835CAdZ+XgbVnOHiZ7c/Q/dadE5lLVMQEjUZMfFSkcQXdbC+CXM/
 2g/aKRedTcoU+d76Wu0TDuUoeXIh4pc698JajLn2es5ucLS6O0Le8m4Y1W/GnHr7N06L1W8Cocc
 JtJGEaL00/N2BxncCVqRoT+wiDww+C7XeVsu8nEuSjR2M1dV2vBXaYOu+VKpe6O5mJsQ1/7XDt/
 7pG+t3UdMB40CKEtJJkfNo1UK13QBG3UMLtcj4vbp+ouwas6m7wVesB0ycWQEm2t0gVsCY73J40
 cE2/CE+x3ju2eJVBtqspjNpqjofWgOVtimSJyuMeCkQyNmtSxhly94G687vncD5eR+4/9FmKrmn
 h1Dv4fdQNCwWWcyCis8H1ildlX5zdXcyWLaR5a6uMt3SUIlm6OsWdoEIqujHly
X-Google-Smtp-Source: AGHT+IH6NEb92+04ReM37pymEPXcRn/KBwk6INmqVbgmpoOtMmeZpdxMFKvLu9A1Q1OO7uW7F44Hug==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id
 ffacd0b85a97d-42704bc0d07mr3064974f8f.18.1760707820465; 
 Fri, 17 Oct 2025 06:30:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e1024sm40420867f8f.42.2025.10.17.06.30.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.0
 machine
Date: Fri, 17 Oct 2025 15:29:52 +0200
Message-ID: <20251017133002.61410-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 64b81345f1e..e1868eb7cc8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1133,18 +1133,6 @@ static void ccw_machine_5_1_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(5, 1);
 
-static void ccw_machine_5_0_instance_options(MachineState *machine)
-{
-    ccw_machine_5_1_instance_options(machine);
-}
-
-static void ccw_machine_5_0_class_options(MachineClass *mc)
-{
-    ccw_machine_5_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
-}
-DEFINE_CCW_MACHINE(5, 0);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


