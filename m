Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D5C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARM-0004en-5B; Wed, 31 Jul 2024 10:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARE-0004RL-OF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:24 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARB-0002e0-Vf
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:24 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f0dfdc9e16so72382291fa.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436580; x=1723041380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9NCxU046H4u60QWd27C0lgNDdOg+T8nPmeaSWQBoJk=;
 b=eWBuF91+q3/Hdc1A0AbfvIbkP1yEJxVUxcokzQwVTRjXQE9T2Qj5UfIE3xApL1HFhQ
 O9+7XW4Lu7jDZ2bJGUZ07XE4VNvxnbQ2x74SfciOfD35IWjAOvSkukhfJs3+e+a7ML3+
 /NitxZjKb67vGL+l1IxE7vPquqjKQ9euT3Tnyj/ZcR/Lgb10n0Sw5QT4DE/14tOdkIaJ
 jC9HP8cOIMoQ70jMOG+R0RbxA7X1tOGo6UowcRWZQaA64uyFb+BT86wEYvBeLag34V4Q
 tDvjJlHKiWfSc5fW+j8Zwr6kaRCLwv4thhooFt7n/prgJZInqRCCf8O9qI3kjlQQaLI4
 SMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436580; x=1723041380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9NCxU046H4u60QWd27C0lgNDdOg+T8nPmeaSWQBoJk=;
 b=KlYhucBMZOd9aY9+BMrd48toRhxB3vWTewPpmtx8g7keCy9GC5vCiV9wX/egSA16GO
 ck4yySKlSADk2/hB1s4q/7IKECCOq0czMjX77bA7L5BuAAy47ZMlfLJ/aUVaiNA/rh/Q
 TUNKRFet210Mmdp1tK34G4mJQ7S9wht3XE9ABGbTw66fLTs2PcpUoC2rs8CyH3SgCPgh
 yoKQMmsyM54Yn0oc6iOHe+u7e/mh9HYX5lvwW/AIj4yOw6saZOSn0Uy0xSddynC1JgXn
 cikBxNyno+lxpbqGLCWT91SOSvQ+SSBFXV4d+P/sJ0RadMhSFS2gyYs/x0koFi1+4nBr
 tN/A==
X-Gm-Message-State: AOJu0YzPVYBJf5V11ZcJBu1cJBP7cryfzne1m5ZZo7RjiIJVccvIHny0
 kZO0V4Xgky1aAIxL6K2LvWcwsg0/FDYWha9w5vBrDxf7zpQuNuw/TR/BPlKKcic1LPOTC/Qca/4
 A
X-Google-Smtp-Source: AGHT+IEjLLHwwocLy5JAiC32Xksh6lxSbBuw//ampqQu+dvOQdVajcLE2WLnysPCF1hhV/DHQ+/i0w==
X-Received: by 2002:a2e:a615:0:b0:2ef:2c0f:2846 with SMTP id
 38308e7fff4ca-2f12ee05031mr92262471fa.17.1722436580097; 
 Wed, 31 Jul 2024 07:36:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 2/7] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
Date: Wed, 31 Jul 2024 15:36:12 +0100
Message-Id: <20240731143617.3391947-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

In the loop in qemu_gluster_parse_json() we do:

    char *str = NULL;
    for(...) {
        str = g_strdup_printf(...);
        ...
        if (various errors) {
            goto out;
        }
        ...
        g_free(str);
        str = NULL;
    }
    return 0;
out:
    various cleanups;
    g_free(str);
    ...
    return -errno;

Coverity correctly complains that the assignment "str = NULL" at the
end of the loop is unnecessary, because we will either go back to the
top of the loop and overwrite it, or else we will exit the loop and
then exit the function without ever reading str again. The assignment
is there as defensive coding to ensure that str is only non-NULL if
it's a live allocation, so this is intentional.

We can make Coverity happier and simplify the code here by using
g_autofree, since we never need 'str' outside the loop.

Resolves: Coverity CID 1527385
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/gluster.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index f8b415f3812..61ded95e660 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -514,7 +514,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     SocketAddressList **tail;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
-    char *str = NULL;
     const char *ptr;
     int i, type, num_servers;
 
@@ -547,7 +546,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     tail = &gconf->server;
 
     for (i = 0; i < num_servers; i++) {
-        str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
+        g_autofree char *str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
         qdict_extract_subqdict(options, &backing_options, str);
 
         /* create opts info from runtime_type_opts list */
@@ -658,8 +657,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         qobject_unref(backing_options);
         backing_options = NULL;
-        g_free(str);
-        str = NULL;
     }
 
     return 0;
@@ -668,7 +665,6 @@ out:
     error_propagate(errp, local_err);
     qapi_free_SocketAddress(gsconf);
     qemu_opts_del(opts);
-    g_free(str);
     qobject_unref(backing_options);
     errno = EINVAL;
     return -errno;
-- 
2.34.1


