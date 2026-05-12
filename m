Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1A9CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGq-0004AZ-Du; Tue, 12 May 2026 17:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEQ-0007HD-Bk; Tue, 12 May 2026 17:01:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuEN-0006dB-33; Tue, 12 May 2026 17:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=Q5smFhmGfV1eJoYo0hYO8uCEZYCYBG7+b+hXPxKbpaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=me3rDllJbGCQ++8eJivwE3ORwROdjVJQ6HRIYqjaxR4aBWYvJMT0DK7dJrG2RBMJM
 RyJqvsFtMH42Q70BpyntJd4aqggQjIj6Qo/7tuMvTcDNfHc2JWTiVsUtmpv129pf1m
 QoNfWsq0Z+m/QxxH/gTyJY+hBer64Nr3dIE4ZPzm/9CMHif6/CsYin9wi9B3sNkTxD
 JoUDe2vxRAbUcmFKfgCFN2MxIzSiSV5zz3DXvFeFhnaVxrAcpo4ukH63ZAcwSZpTwG
 ZqSp6oLGcMkWM4VPPf/gX58wVPQJMnLTwu0Vd6druzLVLqc43ky9eUf+RE+bskriOR
 AHDt1xRYF4HHQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0BA4A1AA312;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 14C2D3ABC83;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yixin Wei <easonwei1998@gmail.com>,
 Yixin Wei <yixinwei@meta.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 070/107] linux-user: fix off-by-one in
 host_to_target_for_each_rtattr()
Date: Tue, 12 May 2026 23:53:57 +0300
Message-ID: <20260512205437.360850-70-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Yixin Wei <easonwei1998@gmail.com>

host_to_target_for_each_rtattr() uses "len > sizeof(struct rtattr)"
as its loop condition. When the last rtattr in a netlink message has
exactly sizeof(struct rtattr) (4) bytes remaining, the loop exits
without byte-swapping its rta_len and rta_type. A big-endian guest
then reads rta_len in the wrong byte order and fails validation.

The companion function target_to_host_for_each_rtattr() correctly
uses ">=" (added in commit fa2229dbf8). The kernel's RTA_OK macro
also uses ">=". Fix the host_to_target direction to match.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2485
Signed-off-by: Yixin Wei <yixinwei@meta.com>
Fixes: 6c5b5645ae0 ("linux-user: add rtnetlink(7) support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: qemu-stable@nongnu.org
(cherry picked from commit 029f10e852780da846d3e7f1691c495474683b73)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index f83d1f79d5..1045ae7b1a 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -482,7 +482,7 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
     unsigned short aligned_rta_len;
     abi_long ret;
 
-    while (len > sizeof(struct rtattr)) {
+    while (len >= sizeof(struct rtattr)) {
         rta_len = rtattr->rta_len;
         if (rta_len < sizeof(struct rtattr) ||
             rta_len > len) {
-- 
2.47.3


