Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8802BC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQKW-0008Ja-1D; Wed, 28 Feb 2024 15:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKR-0008IM-4k
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:15:00 -0500
Received: from catfish.pear.relay.mailchannels.net ([23.83.216.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfQKP-00043l-Bc
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 15:14:58 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 71F41102332
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:54 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2A11C103929
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:14:53 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709151293; a=rsa-sha256;
 cv=pass;
 b=4GY9VhxMnnkZeQvh38rMtcJUdd9iQaYFh88xx2iKKlljKd7XHIxNBMKX8FCNO2gTeRNDGM
 teueqmSkAqJ5igNpfPrAH+BAenvJP+UO+eucb6O/c5VqEZuSz81aKwxe5YX0jbMf57OmDw
 /3bvrCWEOinpZDGRtMbUo3F+FWyKZ5I2N5dYc1J8oBwOGPt5A1rHGdBN5pKHCa6FUAMkuX
 7u8HUBrQUdNzz3oby3OmT2GA+XVdA6Ijp9I3F7fizMJbumLHQu5z/AzFBvHVp5x0s7dcrF
 vuaDS7OUV+sGwhNWtmiu4UHDdGvErNWBJrklY222wtsyt28h7p1+Mes791sd7g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709151293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=3CP0t1jAVlJaaOZZCK2N/4bcEOd7i4ad9ifS1boh0DQ=;
 b=TKUVNnR6CspJ4WARZCa7+/SUKTxsrrjlaH/Zv3OoVPsN7M9QQlpQ/zTtSsv6i+bUwI97dj
 VhTK8jjygJrJGhURvCAqs/wGwrfMq7SY22zkvd+CwY7/q2IDuIiHbrT7m+p+0OJVvUCb/b
 VrVB/+pSoojG++HMo/s2ExGrKAP9wBuHj6x7w9FK8xPAXte8DOuzi9YuPAxNDuGEQLAnmF
 wV7eyTck3YmFthG8uu3m8Bk5dpJmign+HsUwmZ3pF0wmxYS8/KUb4iNo0lL+8LIdoaGSQh
 h+6f7wB15G/kaYx53dsgwP6lLzEEIEhmcByi61x2io3TGIdkQyqAHoRPtgKOXQ==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-9jm27;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Trade-Daffy: 72f2d43534c47cef_1709151293664_3455485355
X-MC-Loop-Signature: 1709151293663:2340965779
X-MC-Ingress-Time: 1709151293663
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.220.170 (trex/6.9.2); Wed, 28 Feb 2024 20:14:53 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709151260; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=vdSGX5ST1qyJ3eMYQ0ulK+lu9QrpW8Y1cozowTlcQbr6PukyLyA7Gwrte0Holy4E4ZV8LbG3skp6T
 qKZCNk3wj9LmO6cKkbkAi7J6QMDMtnlMSy824rCA0w4r3EzH+yC00Jvu6QIzlzNF4H6+fF2MRXFFY9
 CNjFbCJFIm/th3KB6Gw+xxl0X8s13VcjBVU5V2+H5AP9/s21IXAWbOH5ZoCv9hNC8fkpD/7u/A222p
 yNqyj7GNQ/9x33vZA6lUqSZc+BJNiS99Q+B3a6V0ZCzpkXIpkc374glFXp5b/GhuRUk1IchGGDrOVZ
 DQ8hMCQ6vep9BpVE2KDTGR6fdlIglkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=3CP0t1jAVlJaaOZZCK2N/4bcEOd7i4ad9ifS1boh0DQ=;
 b=Fta0ziPK0wTeQwmzIVvFhjsNQWuYUKLiOw7k46WtXdDsLM4xtKO7D/T0DA1xWcNJqCVx86aZ3ZDjB
 XGVVANB5twqjFdzN+bPCSHdnTKtDKeu1ygHDNOaYkN/7M+E9f6HU8t47rf1mpJX0zrK+YknTupeoHa
 6S8zZAaZzi174q4q8KQm+QlwBcOelhlMnUw1X9LXig8fcgnfS4yw/ARhDFOCB+5cvD1z6xblkiMhM9
 IBzpOOrKFw/6CA+8KMf7mB4gUMKDzf+SYVfbNEOVZqT8xHxl3RN1LMmm+X2uWJe17X0u2PNYv6OEbZ
 uwjPY2xB/O9/WozLo4C98W+58GRReqg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=agzFYBJh; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=3CP0t1jAVlJaaOZZCK2N/4bcEOd7i4ad9ifS1boh0DQ=;
 b=oOM5D8A+AuMJIpBeolL+ZpQLU30FFkf6y4VInYSt2hdbNNB6pg+MyGftjXqkYAhMkmLkviRsPi+sO
 BG43k6ljLkFo+3BEjN8zAgTHgQrR5kxSO2RURQPUbYi97o+qN4HjMyCce17+eHvMOXyRIQK3UrG4NV
 ETToNpSCITZetLaQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=3CP0t1jAVlJaaOZZCK2N/4bcEOd7i4ad9ifS1boh0DQ=;
 b=NpYaSbyPsJhSGaljMwBz9TSzrbUyxE/8Oxqj8lLdXfjh49PburElxbW3Emweke7B4cV15yYYKcM6N
 WI+M7xdWOk6fxHMrQlV9iQq+bdZkqBMWtjxh4LmF2xFbY/ly+TsiVYNLUu6SttKHrNsdwZtbXQIXLc
 AXhO2/WOkBtViMhmD+pBTOfVuAN0Hv+nYtgiSEdx66TUdzXtg0T1wXbaRa3YRLTHzHUWQd9qqnt4TI
 K5e8eXQKaSzpL6sqwkVlF4IhcQG7Rj822wACdC1BicH2J36DMSJJZFxozMaxEiu77hnIgsdQvpp6rE
 K5Bv+k0XK57njuBeFPCS57NKDJUYMVQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f375ea31-d675-11ee-af94-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f375ea31-d675-11ee-af94-eda7e384987e;
 Wed, 28 Feb 2024 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3CP0t1jAVlJaaOZZCK2N/4bcEOd7i4ad9ifS1boh0DQ=; b=agzFYBJh749KwH22QYkQATt3m8
 qB1mf0htxSnryFxfR4r1+vYWj5855JiaGJ7dmoKrdqXmC6TGxOrCpDr3XYeu3H00Na/oHD0EDF3MM
 t75FxtX2AyyFAmryiOb8CqY8c5BmlAQP0UsDyT0ec9csJLoytLNOTiKwmjYU5BErKxH+g0vUHxBhI
 amEwLm70JayzwJCeAEWQHgus55CSzysNnMlhJzRrKcOfFwWW23QWSbxOO1RJjggW3tZ/MLfNW+hO0
 Eaw+CrweNtojAXqm7o6xQeulX/do3reoBnOTseCFFNnnHbbaatQZwwckPTrTAZ2noGx3BosStiSks
 vWv0RgeA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfQK9-000Dka-1M;
 Wed, 28 Feb 2024 21:14:41 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,
	Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 3/3] target/hppa: mask CR_SAR register writes to 5/6 bit in
 gdbstub
Date: Wed, 28 Feb 2024 21:14:33 +0100
Message-ID: <20240228201434.1515893-4-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228201434.1515893-1-svens@stackframe.org>
References: <20240228201434.1515893-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.32; envelope-from=svens@stackframe.org;
 helo=catfish.pear.relay.mailchannels.net
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index a5b2c80c07..049b2d6381 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -184,7 +184,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gr[n] = val;
         break;
     case 32:
-        env->cr[CR_SAR] = val;
+        env->cr[CR_SAR] = val & (hppa_is_pa20(env) ? 63 : 31);
         break;
     case 33:
         env->iaoq_f = val;
-- 
2.43.2


