Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C9CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBb-0005VL-AZ; Tue, 19 Mar 2024 12:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBa-0005UJ-04
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:34 -0400
Received: from ivory.cherry.relay.mailchannels.net ([23.83.223.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBX-00049c-W9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:33 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A0EF5543570
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:30 +0000 (UTC)
Received: from outbound5g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id F0A0154359B
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:29 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865170; a=rsa-sha256;
 cv=pass;
 b=ST6VlGT6nm6hnTC8uXbvHarwI79QIKEW+h6qScekvgLZWpeyTn0Cdn8Dn+/0tVrzUQdjzv
 XyK+bIePB4K2RHYoNnRUkNPD71ibUk1BJMQV//I7AnwKK4jGckxgM/AiFY1tYPTy/pg2hP
 tZdFINrYhIjLdZ8aB5nTp7SKBxeWAmTnJb+R8tGiY1DR9mPdMDGyX8AIJl5bnhr2rFmXSR
 Dp44dCcl4xAmh5yD8oUWsj4Pc+d3/zUFWHEmJMP0m+d7gGWAsrMiLQURKCIdY1DLaFawlc
 8ksQ6U8jENqErVMtNZQY6F9jHmz2uUTxysGiyoUmMdVN5ZceBmuL1085aRUx7A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=W2vqwFH7m336Hnj/3dBURO4h8IegB6+STihKWyQqSts=;
 b=Ix2/ItY0gx0UnPAW3bRJM3LfYm84NeflYcKA6JmUIE3kjqHBU2uAbOosq1n/MXQZbJgUSh
 nXU+Qhvd8/8gZDv0Tc9zL67K3z6SF1o5if+LY7FnKTz5sK46YPNS8gryUsE0hcW0U7tsEb
 5JiGPmoP5jnxxG2pHv3DFr21pgX8zHjTr8RCwjNlAr0SrrMkPNOU42zxPMpqZJQf4QLS+J
 CssJctFrG7W5TBk8j3/1rvPVNc/j4Jc4hHtJNsHPJcPLq67ozeE6uIUtbnBmDkl5iLgC7D
 24diy7pN4Oj2gr1Yb2qbXoD5LWtigzmksCx4+/tXybu2elkiEabeXJAME1JpZg==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-r2xsf;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Wipe-Scare: 31ba2b0b53322233_1710865170523_4189028083
X-MC-Loop-Signature: 1710865170523:3569400075
X-MC-Ingress-Time: 1710865170522
Received: from outbound5g.eu.mailhop.org (outbound5g.eu.mailhop.org
 [18.156.67.42]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.159.228 (trex/6.9.2); Tue, 19 Mar 2024 16:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865056; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Y4d4ys51KcaBKbOWghKyrAZLpAl6P79TG5JrOq3OGMT/ROukhc7kNpZpPA5cXBc3nSdhmo6q7OP8C
 1ztoQ71Oo/hioTh0j6pLU1OKAJjClE+TqB4dRFqqkUEqICnzdZhxwFR03XN0y6jsB6TgQwMuWvUeR2
 fqMh2ze1/mIgH/bv3qAQtBGeKzAklDXwxLoBj38kCON0vUqrWSPXWvAltjTjJRx+L0N3TMLk1v8LQL
 E2kMkkdSVRNs6KrdtcnLwgoK/SISrCUx8AMxIryRzZHbuwL1q+WPVqDdf7Qs2Mn0ua1okf3ZiIHIye
 EI+NMvakrL28TE5ih102ILC+dJoTxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=W2vqwFH7m336Hnj/3dBURO4h8IegB6+STihKWyQqSts=;
 b=TsbzLkkdmwlGtnylHuCoTO1PXxl5ePiQT4TZPxzi4Zm5czUdxI8ay7ayiv6xAzzrPQt4waBSdMbE1
 7W+KBauOknVjxl3l9KFiuImkLov8xWkoiCza7mfKuuDzyfyT8hlxjsIuonRCLxIueVEH9cuDuHAYmY
 FHpX6tTfmkHVGx286Azd8tksHDHqctFvPvwubljTRfYsoNTAzP0YGjx3mKqrY1MgyKld6UpmQ70OEJ
 7g6EVP16ACkYhiGqW5Oeel+M5+6AEv/xli6vpNlj5IKNlZmHq/PUNi2ANXBf+o2WwyNTgg2zuMyPqU
 4VHcIXKpQUApo7hkgxmXB7kHWiDCIyg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=CYFbepqS; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=W2vqwFH7m336Hnj/3dBURO4h8IegB6+STihKWyQqSts=;
 b=rS2vYnQlEKa7yXNaQ7lQ9FCqbvgAQycD1XuGKSlNmqEP8S17KQk2dVDTl9GUUokfOafyvqLKr0yRL
 8J4g7d0dNZiTeizX4Pce2vycKFmkSYqAOuxRFZrhAWpyJylFrqUPZMHUZ9uT4ugmTsDn8N+F6n7uGt
 aGwXaiLTA97WgRL0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=W2vqwFH7m336Hnj/3dBURO4h8IegB6+STihKWyQqSts=;
 b=AmrWBmKNPKOWFnDCIo48tPo4k9J8N/fQTxaiBZMn3eYczZYiPZ6lI0C8pJ3qmpZjEbQVtV34UvEx5
 ZcZrQcGncvlQceLx9HrsYJwUXiIqR1B5BUBBasRY5esjCFadF15lm4tGND11/hWW4e/FSubLxSTSw0
 ULPRvUi4sKeA1NL0JnVqR9Vb+qJqHo54AHPi9ZozPWHzUsGr//EYcTHF2+xl3gwEZKFAQdlBtk1zyP
 ruyo2TMPkIWsqhTTYDo9NnUFoshJFYXlS1e35F5CTKXRpQFRrpCNf3mfXXxB9bwX0jkHGfdbs+0Thh
 wjmEf603S6hm9KG1ejobk21QkzicxYw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 30c8150d-e60c-11ee-b7d4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 30c8150d-e60c-11ee-b7d4-9b9d9be6ef2c;
 Tue, 19 Mar 2024 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W2vqwFH7m336Hnj/3dBURO4h8IegB6+STihKWyQqSts=; b=CYFbepqScxDBuHxlpQJEX59nY3
 rp0jFSfK7+4upQl9YAeLzp7H2n8zUmKTkqSlSPIY/ijKSyK9T/8meLl8Kf5URj7vYfocm+nEBio1J
 8iX8we7Hsb5oA4lLmPLpkuxO3e07A9BAQvdnmC+vDjJ1vbEnht2gCBwc6EhP73DKsxvhEnm7Dg8ct
 vvSMfvgvpBDxBuIvhPG8xZaIM2GOWpTrtdwkRWeot/AtmHSG13m7xN2HrcAMihGzjho6Z7cWSZODW
 Qm2cj6wIAbGiq/ZGjGYjAYZqN2n08+dRjLSWz+qoI37iqCiBJFM7fe+SjONspY/hfBvGswL6fhn2v
 v/ioKkww==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBP-004VVI-2o;
 Tue, 19 Mar 2024 17:19:23 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 1/6] target/hppa: ldcw,s uses static shift of 3
Date: Tue, 19 Mar 2024 17:19:16 +0100
Message-ID: <20240319161921.487080-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.94; envelope-from=svens@stackframe.org;
 helo=ivory.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: 96d6407f363 ("target-hppa: Implement loads and stores")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index eb2046c5ad..6a513d7d5c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3085,7 +3085,7 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
         dest = dest_gpr(ctx, a->t);
     }
 
-    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
+    form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? 3 : 0,
              a->disp, a->sp, a->m, MMU_DISABLED(ctx));
 
     /*
-- 
2.43.2


