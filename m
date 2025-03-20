Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C57FC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7r-0003rX-Cz; Thu, 20 Mar 2025 11:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7I-0003Qm-Jd
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7G-0007nZ-SR
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso567891f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485649; x=1743090449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiZgm8pqiIPSqZSnhTLPdWvEW87iUNjwb11DtO5aXf4=;
 b=BjWjj6QVdYsWWyPqNTkP34NN0hE6wyq+pBBUglXXe9wbyfga+J87e8WUcvILQDVfgp
 8k7PmY4r2IwtKd0uLp24JV/NTX0ZibwqO+mXqQrr+ttj+LxjLC3iGYiOZwFtNI+H2b2a
 j4NJhZoMgQGVm11o+A/zhtF8xNj5S4UrqIBi34X3XqHkNMLRtvC8TZcKiFidI2WP1jqU
 0EMZ9gSCOF1ShBMC1m5a53DzjrnCBAFOynSx/q6m/ylIcwp2i0y64sEyIhMq6fK2pYk9
 bmW3916rbkptR6fAiGQqhXdBZ1y0R8xO8Re7SHidyg7n221skOfZ37BKkZOwUYxyV0lf
 2mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485649; x=1743090449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiZgm8pqiIPSqZSnhTLPdWvEW87iUNjwb11DtO5aXf4=;
 b=tt6fyXGFT5CBKm623HcR0UUO3yeh+a6B2Bt9Q6h489WT/MdPz+x7OWJ863FQ2atpDV
 WBNp46DBnZD9NGK3gADCSyvEUCqY8nkCfdVUPFr+/4mqQf5qmozgW98C/MTn0PrRgSSt
 IgnYpqwYFVEVb84soWKRulrlljYEUjFOh8if68PmuuqTPNYLhZCIoUDSEcrm3MLALeYc
 fm02TOXktYEKe7uxGJ5cc/No/CJxSoKUeH3rpcxMVRRgsOOvF+BIEdmXhWnVPcQf1e+V
 cHIPF6MakbSQFaKGY3ntGPanDZIjqCTkP8cKojQuve987dFq2+c4D01M3Ru8s79+xAzQ
 0fhw==
X-Gm-Message-State: AOJu0Yxusqso36oFdUzzt/1MTw3xIfUemoHm6Z/JwW/Ea+TAwLi0g1tn
 SXYvKClEf2bgzXsBUNArnnDt8vQcxBiv1nwwwGzy494IO+yiwgStIXH4CDrtSPCanuKDjzC02+4
 Q
X-Gm-Gg: ASbGncvzeqz+PyGOLaPRQj0tpG0FDSCHUf8F/K9CqJSa24/UEQsyRnT142iIKsEs8mC
 BdKieXARztrLjlMSaNiPXK2XCcRrRA14zYwU2OuxE68viYYXQXB6/JebQELLRc4S+aiGIH7auMR
 8cWNmyjGeLIC0jy4R6QnmKccmyaMQw26hMjLVW+HDHh527LQp36Jcyd1+yCRQdDVbyquCFI93fg
 +eMJZScAlDLyZ+d95HJhWsaVICU0HpBABRv3Hinb4As2VxHOiU8+gh6BVRiraSHufFZ7hpYtgo9
 JQZuxVHiWKCnY+5qQcgMQilj3fRMaGEJB7KqwmVnmVgg7lUmiDm0BiYUniudbHWtpuOQMNMIZ7S
 jpm2KjhXxmrUJNu0yAAroYPU9ME+iscHjrAk=
X-Google-Smtp-Source: AGHT+IEh4xmDb9UgaCiygGaku4fMnhFOdzN8ff7lw6Srk6HHkWH0iX1liYFja2LuiUOwAMDh1/US6w==
X-Received: by 2002:a05:6000:178b:b0:390:f9e0:f0d0 with SMTP id
 ffacd0b85a97d-3997f8f751bmr13487f8f.6.1742485648791; 
 Thu, 20 Mar 2025 08:47:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318acfsm24566973f8f.70.2025.03.20.08.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/6] qom: Factor
 object_class_dynamic_cast_ambiguous() out
Date: Thu, 20 Mar 2025 16:47:17 +0100
Message-ID: <20250320154722.27349-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

In order to allow matching ambiguous types in the next commit,
factor object_class_dynamic_cast_ambiguous() out of
object_class_dynamic_cast().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/object.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 01618d06bd8..1620a87ef44 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -940,8 +940,9 @@ out:
     return obj;
 }
 
-ObjectClass *object_class_dynamic_cast(ObjectClass *class,
-                                       const char *typename)
+static ObjectClass *object_class_dynamic_cast_ambiguous(ObjectClass *class,
+                                                        const char *typename,
+                                                        bool *ambiguous)
 {
     ObjectClass *ret = NULL;
     TypeImpl *target_type;
@@ -977,6 +978,9 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
             }
          }
 
+        if (ambiguous) {
+            *ambiguous = found > 0;
+        }
         /* The match was ambiguous, don't allow a cast */
         if (found > 1) {
             ret = NULL;
@@ -988,6 +992,12 @@ ObjectClass *object_class_dynamic_cast(ObjectClass *class,
     return ret;
 }
 
+ObjectClass *object_class_dynamic_cast(ObjectClass *class,
+                                       const char *typename)
+{
+    return object_class_dynamic_cast_ambiguous(class, typename, NULL);
+}
+
 ObjectClass *object_class_dynamic_cast_assert(ObjectClass *class,
                                               const char *typename,
                                               const char *file, int line,
-- 
2.47.1


