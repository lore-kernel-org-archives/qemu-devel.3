Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E413C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71C-0003Uy-Oe; Tue, 12 Mar 2024 14:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk712-0003Pc-6q
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70w-0000cF-JZ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41324a16c9eso2033875e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268693; x=1710873493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=leIb44YVt2ONZNF3/nNgR8JxpEyw4LXHpjhhtBaqKe0=;
 b=v9dHZnYRG7+oD5nMa8uuk9IwitY1efDwuWbM5SA3lQhK7HhNONltNzbAQf3PnQjPE/
 OLwk47u69wteLpQP1RREDM17Kbak1zNCNFgTtDVLGuLSaZquB8mkp/fwXRC3Mg4F/ts+
 NAlp9Io5yvkUDGbtudnCJlDi0feaBPw5Dz9b25nyyv0wMqm32DW7TjYt7DoWlEM0UniY
 f93J1LDVxJPateL7RFswqhdhswjWxvn2YMsrHBs+nnsj+aPhHkg9v+jig4E6/aDOP5zY
 +myhKsz/2N2ViK63app6y6auw6vRYbl02BaWrZZYrz9JmH9TIlkhVcqoSacDAn69nH4J
 NQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268693; x=1710873493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leIb44YVt2ONZNF3/nNgR8JxpEyw4LXHpjhhtBaqKe0=;
 b=HvICX1pCawcgO62K8IZqoz7uExj9odJ+C6SuTgmiCMcfZ2iSyF0u3eG6CsGxhsayIz
 PZO+/Xsc9Nd5Moy/WnBFYfnXMBjyBxcP+3/tRLPhtRqTD7lBwqxPw2tiueI/C+UQpzbD
 6fR8qmDCnXRRDVjMNj7M+3Gvid4HidFfAuaQ06zFycHa6Fw/SLHcl2oO0hp/a/yu9wIc
 xR5l3SmAg7r38eNXd+Y4Mmpcde0sr+sFc3Xu//046lBG8JyJKfe089njfe+nszyiGzLt
 CTFeb+HDcoBGncf81BO1MpA/4FaihZhhkG8xnK9wT3+udaUeBHz3DKjZ8UnqmaCilx7Q
 3B5Q==
X-Gm-Message-State: AOJu0Yz/DL321qG0SzpyosTB8h7xPPN4+OUxne/YgmWy6BW1MtUDllnk
 +xduo2YkoxShTNGWbgP3HOelZ81TeXojY1nB6ycbU6FTwSwXV+U7zX7/bgEY1WotPEx1XK6erQE
 +
X-Google-Smtp-Source: AGHT+IFMXZxlZWD6xdAgsWjbQGHi6yO2Ush7GT29bYIqI3BHAedvH0BvRkjENbC2sTq2Mp4HqNH6Xw==
X-Received: by 2002:a05:600c:45cf:b0:413:e4cf:109d with SMTP id
 s15-20020a05600c45cf00b00413e4cf109dmr846067wmo.1.1710268692868; 
 Tue, 12 Mar 2024 11:38:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] net/af-xdp.c: Don't leak sock_fds array in
 net_init_af_xdp()
Date: Tue, 12 Mar 2024 18:38:06 +0000
Message-Id: <20240312183810.557768-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In net_init_af_xdp() we parse the arguments and allocate
a buffer of ints into sock_fds. However, although we
free this in the error exit path, we don't ever free it
in the successful return path. Coverity spots this leak.

Switch to g_autofree so we don't need to manually free the
array.

Resolves: Coverity CID 1534906
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/af-xdp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 38e600703a3..01c5fb914ec 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -446,7 +446,7 @@ int net_init_af_xdp(const Netdev *netdev,
     NetClientState *nc, *nc0 = NULL;
     unsigned int ifindex;
     uint32_t prog_id = 0;
-    int *sock_fds = NULL;
+    g_autofree int *sock_fds = NULL;
     int64_t i, queues;
     Error *err = NULL;
     AFXDPState *s;
@@ -516,7 +516,6 @@ int net_init_af_xdp(const Netdev *netdev,
     return 0;
 
 err:
-    g_free(sock_fds);
     if (nc0) {
         qemu_del_net_client(nc0);
     }
-- 
2.34.1


