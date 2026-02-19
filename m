Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42A0E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5ML-00042i-Ka; Thu, 19 Feb 2026 09:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Ly-0003lu-2f
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:15 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lr-000848-Ae
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43767807da6so805149f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512587; x=1772117387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=WtKD0ekRZQLHMFlwR9KPvCHCcmfkXeGS4o1PmU8xf/lS4Ax6B+cDfTh7J7Z6wIbn5d
 RXadJ9CwHfPM4wUUeOYw+Oh25FpginJjMzr8k7YFB/HRkZOnBWDOZ2j7fmUaRDLkWiHl
 nTQEg21s2giuU0bSwySHd2z0jRE4Vng4Joo1awuNwBO0eqrSYAAfwMbCnO++cI57HZGk
 g2HF64+WHq03bflfV2BrmtyEMhIZDyRQxk16SN+6loKwprz9geAsiaHB9MxCC4U5Xe7O
 43l60KmDh0eMl9Gmr5Jo+ss8SJ20svhUx5GwTisNNtShvgD6feNC/EQlclP7hDBJWLSk
 mkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512587; x=1772117387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XtZvlcq7y9dCibk7QnCziTNJJ4JB6d6R3IFkPvUGo4=;
 b=DI5MR0ETzTXlR/pQJUnbwCqHIP0zYptL2TOEcecSlYTFUw/gxW4DhwlMzDaG1FXXyy
 ZRgfPAZuHDhNwYzBoB84rosClBEeLrf7j5Q81t1g8LY97Q78YC0MODYpUorN1L8cu3AI
 dcTs43HQLwbHroTZnu5xGcvdyX7WfOQlJoEI4xe3HIUcRIK+KedUbEndVgaayhq6W0gI
 g4lBzyRQ8NNbZZxSxb6SU/z/RmB+1bIJliRuViaRhQcuMOUmqbMDVpNDFjQct+aWKXYm
 QZ5iS9tStEc4BG7QHaH6hcCpDuht7pbFSy4IVfhSqFXS/LngNXN0DMQK+av6sEe32uJX
 gnRA==
X-Gm-Message-State: AOJu0Yyn1wxogGufP6R/S08BuMb73dcbxLMrX4abRxfQ6catNUIwngRp
 /xxcJcxpV557uv0sUuZfgvYrNxJNua6u889+LHp5500BjKJHf8s7RnLg6f/BZdCJ
X-Gm-Gg: AZuq6aIX0rWDeMAgIDJBcMF7q8WR7axK712tyAQrQl05OYpGBSRv6uvfYHfNLPmFOpu
 WtTeAHwmZ9+BgxTHhKgGzVLbEyMq+2EcEqCjoPWTSUX0hcnxWbNm1DyDMs/3EQUKGu+6vN+I0+8
 yGQIIep0G9q28CJGV0wUSjc864zTQfVXmZaKENlllttvR/R1EIIXQ8rWmILqJbx+0ZkUQxf5ZjZ
 Su6NwiCDNMEbiUfYIg9DyCDHrgnaCKnHxRQ4/enu732BBum7I4bckrZLPR3ETm3I7eUQnHbeC+e
 mAMHisJYWrnmVmBAe+RAAzofYI0GeB1VJhcY51XrNrXrh+nZ3TitdDmL0iEWmBc5cPr4SEZN6d2
 HUFR8cCh62wCX87E8WDw2ruVnstEiC4nrWsntEnFXh1QT1SAJGDTOwMnfsvuKlKwkwDC29O9MH/
 cEmtfuR7lpk+B6B20cNNqfVK6fCJ3poYZgko10q3ruYnez/8JXQScvMm0PwAa7MRpyE7om
X-Received: by 2002:a05:6000:22c5:b0:435:e47b:e746 with SMTP id
 ffacd0b85a97d-43958e3beb0mr9871788f8f.36.1771512587046; 
 Thu, 19 Feb 2026 06:49:47 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:46 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 24/33] qom/object: export object_resolve_link()
Date: Thu, 19 Feb 2026 15:48:52 +0100
Message-ID: <20260219144901.3317747-6-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Export `object_resovle_link()` for use by other
subsystems.

This allow callers to resolve object path and verify
type contrains of a link property.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/qom/object.h | 12 ++++++++++++
 qom/object.c         |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b9..1573d41d4f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2034,6 +2034,18 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *object_property_add_new_container(Object *obj, const char *name);
 
+/*
+ * object_resolve_link:
+ *
+ * Lookup an object and ensure its type matches the link property type.  This
+ * is similar to object_resolve_path() except type verification against the
+ * link property is performed.
+ *
+ * Returns: The matched object or NULL on path lookup failures.
+ */
+Object *object_resolve_link(Object *obj, const char *name,
+    const char *path, Error **errp);
+
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a32..7e16765cb4 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1904,7 +1904,7 @@ static void object_get_link_property(Object *obj, Visitor *v,
  *
  * Returns: The matched object or NULL on path lookup failures.
  */
-static Object *object_resolve_link(Object *obj, const char *name,
+Object *object_resolve_link(Object *obj, const char *name,
                                    const char *path, Error **errp)
 {
     const char *type;
-- 
2.43.0


