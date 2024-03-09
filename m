Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E0EC54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Ie-0002DI-6b; Sat, 09 Mar 2024 14:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Ic-0002Ba-Re
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:02 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Ia-0002gp-HN
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:02 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5684f95cc9bso25879a12.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012238; x=1710617038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUfL1w5ZY8ZGsSxKnH4ewPtSTSCallxtJeVJzhKEKHw=;
 b=phxrHw2BBwh2uFzWHY3uVG2xMA2LfJche52MECwKCXkFyzZZjOGMreejZ3ItqQxILI
 4THaEuD/VGoiG+UbSgBcvh9t3H/lv3wYUMLlc+Ajg1XZDLt+XZfBHAwOfnPPffIA8fi+
 s8405NdGqj3dF/hnV9qxuGdFKrSPl3FhsNKt6xbeneVHv/ii6yyt137JOC4XjKRcwCP0
 L5d5M4hFiyk4VXWZWLKWzyvpDhKr5D83hnWj0DFzqSL1lUqXy4sDE5fghG+36PKakcq0
 YiQsxsmg7eWHf+m/ihCmBm537rq3f73VRWAAAbZdJ5CX/kJSlXp5pW0KDnpuaKPQNKRl
 oCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012238; x=1710617038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUfL1w5ZY8ZGsSxKnH4ewPtSTSCallxtJeVJzhKEKHw=;
 b=cZw12KB2Dk0Va041J+yhGhODXp74iOj3XsklwyX0levlDCacL8Se18UO7PpKdWiYQz
 9H1FqKIAlCPp9SkdV50oa2Ff4vUDi/1Jcu7PzIoMJI7Rgg99MIKPX15rrFulLTKBjpkO
 oY9IhCbFQ+9tsVOASMbwVPApwyAs5HIk3ek4QkwFJtis4Dx+TEOGkMJnxMtkvirvNNgv
 eGBsEMr+BdCHOmXASticgGrQe7xR4vR9FARPAqvguQSrztixf7cu2OXwbV2sxxr5eJVV
 PwkxCTjzdAE5obx7uDINLBeMLeoRnaZCzYfjSJcF/d1ofcrKYlfj7C/UCOu3n0KA+YQO
 PJVA==
X-Gm-Message-State: AOJu0Yw72CvWtI6+UjeiTzPX3/UoOIa3I8cingQzTyCtdq5PBFKCD/Hx
 N+pf+3ocYovxgCH+dzXrBdXM7UeJ84AOmo4ey4eFM7RbhaYdPO3K/E2oSHkMdvZL0sCvrbOmjRF
 4
X-Google-Smtp-Source: AGHT+IFy8vQdWfIK3ozhS/fRZLOXohhmDLYe56O/gPHcpUJVtjcAsYxvO1Dhp7P3a/T5pumkkZy5uA==
X-Received: by 2002:a50:8ad9:0:b0:566:1952:afc4 with SMTP id
 k25-20020a508ad9000000b005661952afc4mr3675368edk.6.1710012238657; 
 Sat, 09 Mar 2024 11:23:58 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 et8-20020a056402378800b00566a4dec01fsm1154716edb.11.2024.03.09.11.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:23:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/43] hw/remote/remote-obj: hw/misc/ivshmem: Fix missing
 ERRP_GUARD() for error_prepend()
Date: Sat,  9 Mar 2024 20:21:44 +0100
Message-ID: <20240309192213.23420-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is the pointer of
error_fatal, the user can't see this additional information, because
exit() happens in error_setg earlier than information is added [1].

The remote_object_set_fd() passes @errp to error_prepend(), and as a
PropertyInfo.set method, its @errp is so widely sourced that it is
necessary to protect it with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240229143914.1977550-4-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/remote/remote-obj.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 65b6f7cc86..dc27cc8da1 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -49,6 +49,7 @@ struct RemoteObject {
 
 static void remote_object_set_fd(Object *obj, const char *str, Error **errp)
 {
+    ERRP_GUARD();
     RemoteObject *o = REMOTE_OBJECT(obj);
     int fd = -1;
 
-- 
2.41.0


