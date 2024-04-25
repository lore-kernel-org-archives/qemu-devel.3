Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWe-0002Mt-Ny; Thu, 25 Apr 2024 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWa-00026V-0m
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWW-0007EJ-Mx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34a4772d5easo741358f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041615; x=1714646415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IZveBcQ/I3Ep99MpkKq6qvJrHhr8FNS0mASz7sTHHrA=;
 b=CLAFJ662SqhQqARHFMWY5C8BzeVQ9FLTIKr1RGR3radWYd1NB3M085WAbArXU/80+F
 cGDA5yjIO8DaEglxtHf0a7PBz1uDB3ELOMPBirxftBLr4DAIM+FPnkBitPoojVF89Rd+
 EXhU3ENiucjuCP/Wt2nbcTl7jlO5bVHK48/Od6UxQqj4lVoXBpqPOnzErDt+s20WC9iY
 gzCycF+jsHw65oPXRHkEZcjqkCx7wOoTqiZD48ViwnosTYGgCVlmiEkV6buqhTJ9qnob
 p3LTUgRV8p+2DiEBl6UeMLL+GXBXEAjbCnXzmwQ71NfyZL2Dr3Qr+rEF96AoV7JnlfCo
 Mu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041615; x=1714646415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZveBcQ/I3Ep99MpkKq6qvJrHhr8FNS0mASz7sTHHrA=;
 b=JM+Ei237Oz/EnEChHJLHWjKlv2xL7ebv13rBq1um7eKzu1mrPHFiYTyxx+0qUEVY/i
 Hit9b/hXAW5FXtZqIv/yVwEIerdkL+0JjDLPEcgIp4guraJZZEOoQVC9ofnCs5NO8Ot1
 G3w/6v5MOpdsCeyb5BwOpqYQskKkQjytjoQTTjjjY7JMWOVXWZ/20j7aTd2Z7/G06L+B
 MqyN7mtpNtLPa6OaLyYdsBgcUvirGEFOny3EnPEdhV3CXCuEfp4fRmAFQL/5FHUF3XZJ
 Z7+s8GMxXhYQf0uhQiDruZBIttaY6T+1GS6xh6aBr8d+Q41+XQ1VaCjjK7K/Ccb8UFKW
 OKeg==
X-Gm-Message-State: AOJu0YwxP+TihJbdrZTUf1cRKCGl8c0BVn20Sc1xECk7Puo8lBr+/ADM
 BOm2kH/AWAf001NDux60nHKQ1GWyAKAxTmoK4/iXgxwSQwMoR+IWSjGL35Cly3qtdoWesBv9QQp
 m
X-Google-Smtp-Source: AGHT+IFJlr5Dzu3wMiMHn0mT3eYQrVzr0daLa+ORokaf1E6CrsWOmVbd4HAkeBO90iPrW8MRQTBa2w==
X-Received: by 2002:adf:e8c7:0:b0:343:c6d1:280d with SMTP id
 k7-20020adfe8c7000000b00343c6d1280dmr3560511wrn.21.1714041614901; 
 Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/37] scripts/coccinelle: New script to add ResetType to hold
 and exit phases
Date: Thu, 25 Apr 2024 11:39:50 +0100
Message-Id: <20240425103958.3237225-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

We pass a ResetType argument to the Resettable class enter phase
method, but we don't pass it to hold and exit, even though the
callsites have it readily available.  This means that if a device
cared about the ResetType it would need to record it in the enter
phase method to use later on.  We should pass the type to all three
of the phase methods to avoid having to do that.

This coccinelle script adds the ResetType argument to the hold and
exit phases of the Resettable interface.

The first part of the script (rules holdfn_assigned, holdfn_defined,
exitfn_assigned, exitfn_defined) update implementations of the
interface within device models, both to change the signature of their
method implementations and to pass on the reset type when they invoke
reset on some other device.

The second part of the script is various special cases:
 * method callsites in resettable_phase_hold(), resettable_phase_exit()
   and device_phases_reset()
 * updating the typedefs for the methods
 * isl_pmbus_vr.c has some code where one device's reset method directly
   calls the implementation of a different device's method

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-4-peter.maydell@linaro.org
---
 scripts/coccinelle/reset-type.cocci | 133 ++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 scripts/coccinelle/reset-type.cocci

diff --git a/scripts/coccinelle/reset-type.cocci b/scripts/coccinelle/reset-type.cocci
new file mode 100644
index 00000000000..14abdd7bd0c
--- /dev/null
+++ b/scripts/coccinelle/reset-type.cocci
@@ -0,0 +1,133 @@
+// Convert device code using three-phase reset to add a ResetType
+// argument to implementations of ResettableHoldPhase and
+// ResettableEnterPhase methods.
+//
+// Copyright Linaro Ltd 2024
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// for dir in include hw target; do \
+// spatch --macro-file scripts/cocci-macro-file.h \
+//        --sp-file scripts/coccinelle/reset-type.cocci \
+//        --keep-comments --smpl-spacing --in-place --include-headers \
+//        --dir $dir; done
+//
+// This coccinelle script aims to produce a complete change that needs
+// no human interaction, so as well as the generic "update device
+// implementations of the hold and exit phase methods" it includes
+// the special-case transformations needed for the core code and for
+// one device model that does something a bit nonstandard. Those
+// special cases are at the end of the file.
+
+// Look for where we use a function as a ResettableHoldPhase method,
+// either by directly assigning it to phases.hold or by calling
+// resettable_class_set_parent_phases, and remember the function name.
+@ holdfn_assigned @
+identifier enterfn, holdfn, exitfn;
+identifier rc;
+expression e;
+@@
+ResettableClass *rc;
+...
+(
+ rc->phases.hold = holdfn;
+|
+ resettable_class_set_parent_phases(rc, enterfn, holdfn, exitfn, e);
+)
+
+// Look for the definition of the function we found in holdfn_assigned,
+// and add the new argument. If the function calls a hold function
+// itself (probably chaining to the parent class reset) then add the
+// new argument there too.
+@ holdfn_defined @
+identifier holdfn_assigned.holdfn;
+typedef Object;
+identifier obj;
+expression parent;
+@@
+-holdfn(Object *obj)
++holdfn(Object *obj, ResetType type)
+{
+    <...
+-    parent.hold(obj)
++    parent.hold(obj, type)
+    ...>
+}
+
+// Similarly for ResettableExitPhase.
+@ exitfn_assigned @
+identifier enterfn, holdfn, exitfn;
+identifier rc;
+expression e;
+@@
+ResettableClass *rc;
+...
+(
+ rc->phases.exit = exitfn;
+|
+ resettable_class_set_parent_phases(rc, enterfn, holdfn, exitfn, e);
+)
+@ exitfn_defined @
+identifier exitfn_assigned.exitfn;
+typedef Object;
+identifier obj;
+expression parent;
+@@
+-exitfn(Object *obj)
++exitfn(Object *obj, ResetType type)
+{
+    <...
+-    parent.exit(obj)
++    parent.exit(obj, type)
+    ...>
+}
+
+// SPECIAL CASES ONLY BELOW HERE
+// We use a python scripted constraint on the position of the match
+// to ensure that they only match in a particular function. See
+// https://public-inbox.org/git/alpine.DEB.2.21.1808240652370.2344@hadrien/
+// which recommends this as the way to do "match only in this function".
+
+// Special case: isl_pmbus_vr.c has some reset methods calling others directly
+@ isl_pmbus_vr @
+identifier obj;
+@@
+- isl_pmbus_vr_exit_reset(obj);
++ isl_pmbus_vr_exit_reset(obj, type);
+
+// Special case: device_phases_reset() needs to pass RESET_TYPE_COLD
+@ device_phases_reset_hold @
+expression obj;
+identifier rc;
+identifier phase;
+position p : script:python() { p[0].current_element == "device_phases_reset" };
+@@
+- rc->phases.phase(obj)@p
++ rc->phases.phase(obj, RESET_TYPE_COLD)
+
+// Special case: in resettable_phase_hold() and resettable_phase_exit()
+// we need to pass through the ResetType argument to the method being called
+@ resettable_phase_hold @
+expression obj;
+identifier rc;
+position p : script:python() { p[0].current_element == "resettable_phase_hold" };
+@@
+- rc->phases.hold(obj)@p
++ rc->phases.hold(obj, type)
+@ resettable_phase_exit @
+expression obj;
+identifier rc;
+position p : script:python() { p[0].current_element == "resettable_phase_exit" };
+@@
+- rc->phases.exit(obj)@p
++ rc->phases.exit(obj, type)
+// Special case: the typedefs for the methods need to declare the new argument
+@ phase_typedef_hold @
+identifier obj;
+@@
+- typedef void (*ResettableHoldPhase)(Object *obj);
++ typedef void (*ResettableHoldPhase)(Object *obj, ResetType type);
+@ phase_typedef_exit @
+identifier obj;
+@@
+- typedef void (*ResettableExitPhase)(Object *obj);
++ typedef void (*ResettableExitPhase)(Object *obj, ResetType type);
-- 
2.34.1


