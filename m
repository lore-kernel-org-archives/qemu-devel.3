Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDACC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTu-0001my-N8; Thu, 06 Mar 2025 10:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSq-0008Ml-AS
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSn-0006K7-F6
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso5443335e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276122; x=1741880922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7QzO70em+SWmM19nvv4jHPXxR+fFgMfgrFERsTk++Jo=;
 b=yqrL/7Z9snFzaCSXokImEDrhgDirVkNjSFVFQckkiJ/IK0ZBU99wEjo7z+hCThumQ2
 gxPCRAOjYH39uvztIxFcp7Z/GgfQ0tWdIIdUyAmHWrZakPE4uf3n7SBybXYJpqmOWaRP
 8mYB3D38F073221M5ONJV4pen1UE2W4m4clOVfiiiO6HG3YXe51X0+KgGW4axDU5tes+
 thi5bgXIWgxrJWhqBbolYJixZXza4O3isJgaAhI6pTsJQdrmds8Nh0M4a+ZzKr3jMjIq
 8pW+ULHKnKsUgu99TuInwnMxk3yuF8oz3Aa1i9IM2uWDrinhWamd8vI71KOLXmJW0/lF
 nnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276122; x=1741880922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QzO70em+SWmM19nvv4jHPXxR+fFgMfgrFERsTk++Jo=;
 b=tp2o3BjW2RlPfdjpOoU1OTBSRYAqvF47tTDdCpM98xjUxlzmgpa9U8o9b/Ibej8+Gm
 Zbfq/cav+m/efQ/IQhjxDIqIAk+7NcDnM717o4W4723AEFDT4MWjTZPHGm9ZdlBv/d4h
 10HTGs3qp2KXlNhCFJqNKaFfe1fVe26Yh0oteqWu242rOm1XKuyJtICvEdbk/dUINHFv
 UOTViDYtawhqh2jXEKsFVxTaO7z2d3B7WFrZ9ACzAwdb0OLeHSqFIS44XQFmzh09i5Qs
 2MCGpMDxvlsO1/P6h7xiqHxefRFo7fJaCEpxrzU1IrYwGdbIiQXXyvEISOK8tr58ql/V
 9aQg==
X-Gm-Message-State: AOJu0YxAXnDn02W4gYcG2EPm7Yi5IP+XlKsQJlKIKQ60cBAttWP8j21S
 84UlsK30ZL69nhC/O/wh8euh3Z9cL5ccRLB0kuUidexK9l7Cvj7vAR3jcNuFrM5D+JdF2uni0Yh
 Mw+s=
X-Gm-Gg: ASbGncuA/Hh6a3vkvv0zjop5Lcb33HbCrDfv0ATzMTq0tDL7+jbZesNY1Azh2iFexrX
 hJ+qetCl3XNwcw5S6gjD9g5wQCDyr77CxkNoeHWlhXnfOSww6mTHOnjOV1y8Ui54S/CWnfcC1Ks
 4fdluyAxgwIMlH5uOFPkF43i1ul0kz7GEem1Gd9cLSWIbpOn581h9Z7l7uxmZrzm3ml1I3qgSiA
 aHpSy6Il1vFR8ONyW8d6dauQqHxURve241X1yYY/hAIxM9Yy/2o56FOReGZYp305/EpjcyGvm41
 EXCdxUce16Gj39D1xgNBCA0kBMO+chXc7/3YHkEBkCXz0tHvq381Mit5luLxDPnT7V2LPjp9t8k
 ob1T2HJDPw1lUtRrUyFU=
X-Google-Smtp-Source: AGHT+IHZ2nZlSE4bY+DeORQ5OW6UXqIttaYmBhHVuYgUVLXZg01srZq6yjNacWpp4viSD0SrKlEUDg==
X-Received: by 2002:a5d:5983:0:b0:391:10c5:d1a8 with SMTP id
 ffacd0b85a97d-3911f726338mr6635902f8f.6.1741276122183; 
 Thu, 06 Mar 2025 07:48:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4353003sm56112775e9.28.2025.03.06.07.48.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/54] accel/accel-cpu-target.h: Include missing 'cpu.h' header
Date: Thu,  6 Mar 2025 16:46:56 +0100
Message-ID: <20250306154737.70886-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

CPU_RESOLVING_TYPE is declared per target in "cpu.h". Include
it (along with "qom/object.h") to avoid when moving code around:

  include/accel/accel-cpu-target.h:26:50: error: expected ')'
     26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
        |                                                  ^
  include/accel/accel-cpu-target.h:23:33: note: expanded from macro 'TYPE_ACCEL_CPU'
     23 | #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
        |                                 ^
  include/accel/accel-cpu-target.h:26:1: note: to match this '('
     26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
        | ^
  include/qom/object.h:196:14: note: expanded from macro 'DECLARE_CLASS_CHECKERS'
    196 |     { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
        |              ^
  include/qom/object.h:558:5: note: expanded from macro 'OBJECT_GET_CLASS'
    558 |     OBJECT_CLASS_CHECK(class, object_get_class(OBJECT(obj)), name)
        |     ^
  include/qom/object.h:544:74: note: expanded from macro 'OBJECT_CLASS_CHECK'
    544 |     ((class_type *)object_class_dynamic_cast_assert(OBJECT_CLASS(class), (name), \
        |                                                                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-13-philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 0a8e518600d..37dde7fae3e 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -20,6 +20,9 @@
  * subclasses in target/, or the accel implementation itself in accel/
  */
 
+#include "qom/object.h"
+#include "cpu.h"
+
 #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
 #define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
 typedef struct AccelCPUClass AccelCPUClass;
-- 
2.47.1


