Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4055BCEFC33
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 16:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syDMi-0003BY-5H; Tue, 08 Oct 2024 12:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMg-0003A2-68
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:14 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syDMd-00038M-QK
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 12:47:13 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so4109328f8f.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728406030; x=1729010830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy11i6KMMYbTDLbggIWsMEmjce0qeq1GCqydkwW53Z4=;
 b=z1nij1Xk4OWcHCA2SIBISZmZ4YTQRM8qKQPRmMN+KgmAp8Qrye7DbpTXluhZv04g4a
 PlSIjVyprQfcTeZYKTiQZNmaEEhVHKcDHV2p3aYDT0D5zCpBh+lNTpht7xVcsr8erhlG
 XYmaPsSF2D/KrHJJbN2In7z2cVL4w2HhiEVumOoPSTkf6xuXFh4bT85SmDaF/Ydu6chJ
 7MTULk8giPDSf8cesjGzLpkWWwkybA2h0lVORKEf7i7s3+u2hiyan/cWvZSlR+7L56tL
 Oik2DZuSEDk7YsMdxSLv9rEeeAaOz5r6Q0dIks+M/VxfxT3Y48+27lKILTYPNUHGZp9H
 3LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728406030; x=1729010830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oy11i6KMMYbTDLbggIWsMEmjce0qeq1GCqydkwW53Z4=;
 b=SQGNn883Tq6M0XhkEmMof5mZeC5YcuFbLmIwoa3Ii0A24xJZt6DhLnJtdyyEwXpI72
 JQW5c/1DAOsKVVIfhA2VFkeGZDDGxcPQLvssDjCacabRqAe7IjQlw/266Bcti6TijYMf
 /gYLGk+n3AmJKdIo1SkcXAd0V9sTJiLpoYhTTYJxGGzMx+tyk0Q00W0SYnZQM3yXROI1
 yl11mXbrlfY3x11NMnfK4+CUdxTlb6fuT6hFAbWVNEsl0e6EoP5T934dsSZ0w++fKNYN
 nMCLV6t/0cC/YiPDmHYPwMJEVM9UYbv7z5vuHRX2kC4Tm7ERU3ulhUYN+QRyr4D6+NcM
 O0PA==
X-Gm-Message-State: AOJu0YxZnxmcqgVqdb/t+CYrPUyXB5wBx9tzw3XqDoTydm8xhM3oeep+
 4Y1YJ7qpjIwJJxm7XqUh587Jxmq/uv+K36nMThNeUUVLN3d4ZtJpTUFinPpKGOPWoaBMw9il2sm
 F
X-Google-Smtp-Source: AGHT+IELvK4ZPsLHN9kYlBsYp2uIE3s0agHJbIzujDkzW7K7al85HyLfFq0oD4zaEJc5OXLZCr52uQ==
X-Received: by 2002:a05:6000:186f:b0:371:8eb3:603a with SMTP id
 ffacd0b85a97d-37d0e77a468mr12517212f8f.27.1728406030292; 
 Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d32ea1d98sm1490936f8f.68.2024.10.08.09.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 09:47:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v2 1/4] block/gluster: Use g_autofree for string in
 qemu_gluster_parse_json()
Date: Tue,  8 Oct 2024 17:47:05 +0100
Message-Id: <20241008164708.2966400-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008164708.2966400-1-peter.maydell@linaro.org>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v1->v2: wrap overlong line
---
 block/gluster.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index f03d05251ef..e9c038042b3 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -514,7 +514,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     SocketAddressList **tail;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
-    char *str = NULL;
     const char *ptr;
     int i, type, num_servers;
 
@@ -547,7 +546,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
     tail = &gconf->server;
 
     for (i = 0; i < num_servers; i++) {
-        str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.", i);
+        g_autofree char *str = g_strdup_printf(GLUSTER_OPT_SERVER_PATTERN"%d.",
+                                               i);
         qdict_extract_subqdict(options, &backing_options, str);
 
         /* create opts info from runtime_type_opts list */
@@ -658,8 +658,6 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         qobject_unref(backing_options);
         backing_options = NULL;
-        g_free(str);
-        str = NULL;
     }
 
     return 0;
@@ -668,7 +666,6 @@ out:
     error_propagate(errp, local_err);
     qapi_free_SocketAddress(gsconf);
     qemu_opts_del(opts);
-    g_free(str);
     qobject_unref(backing_options);
     errno = EINVAL;
     return -errno;
-- 
2.34.1


