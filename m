Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EADC54E6A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymg-0003gf-VP; Sun, 17 Mar 2024 18:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymQ-0003dC-AT
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:58 -0400
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymG-0005lP-LA
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:57 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id F3B58761E77
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5BC1E761E4A
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:46 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713686; a=rsa-sha256;
 cv=pass;
 b=0VM0dIhrsRFpgvQu6yW7jTwNCMvI4AKVSBq3whbBPBlSwqAoo4xivDvagnOv5cpmo/7Hlg
 U5AzuR63RiJQ0bzHcJ79tWmkT97vRMBwPefWEeFhIMGkgS9rQh8SiW+dY1fmmq56StNtx+
 QEIKzrWoAu5E/fL2Oiy7IETWLo1xNYePfcfwE9woL8iCH63b91jxaCf0p1gBUKsDxlFMLr
 DPCc86O/MxydJAeSXuRoWMvz7rkLOPPSJfSk2VcknKlVaXoHxMIGZ8RwSiWsKCM9w6d1wF
 co8ECHveGGFCi2Xkmgj/6oALicOe6q5dcxOOcyjENz7VR7OUb/4dUwzjhMiJaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+0y/IAZ6c4dKro475ZEMQZ7X/H4z5Je9zSU3bsCWN8Y=;
 b=dFwmL6+4cL3j8KYN/g7INJN6vheC1U1P9RGyGFTJNkEZv9sxpmouyhx0GNZzmCXNqDIATc
 R5FfbXFVfdnKoG/oId/Io1r6YnBRyOa1MwgT9tJhJVYbycnD/Njxrv1+ZDaZjHeKfD4/E9
 EX+BLOngTmWAq1pWd46/YxgIH7SKhd6j+K4ZqhMlSpP2XGahj1gsPgCRDKoQH+ac+GFIHe
 j7ssbVqLdH5s59OtPQthRGsU3x9R/eBhPefV9bP2NZRmpCGdHejD/0xalUjKnJ1btQert5
 Py1/c2BZmRgtBQ1LYDnXu2mujBIwJ0jz6ES8tH2z1bqVB85OW+bHhQrM6dDIdw==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-sx7pk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Shrill-Turn: 17943eb63547c9b2_1710713686866_2144782116
X-MC-Loop-Signature: 1710713686866:3139319556
X-MC-Ingress-Time: 1710713686866
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Sun, 17 Mar 2024 22:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713650; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=M8SnVcdiOOUoszdAzBkUFQs3HEWCiTIUwoiSR6y67vsQdZ9vjEAqv7IzDq3qFHh2jfVkhSCRT4ndk
 q9PRObaW5FPMXs3n/HGEgDMp+pwZ34X3jq+MfA42OMwQ53ido82YEllsQ1AAAzIfMyxNyTuX/wRYFB
 0OIc3oyUtQ1A8xg2j49Pf+ZOa5tTglHkjCVSkOzm/gD5MXlxWFmfYqfdZqsWkl+QkHNQ5SrqHyriDu
 QggnWBQxzJFxEZH5qrdTwyMurjHpjJ8m5V9n9QWy7dBkxY4FVIyoHOe+O4N+wkS7nugTouKaBfo6ft
 RV7SfGy2TZGRhOBtG1BS/GszGtB4wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+0y/IAZ6c4dKro475ZEMQZ7X/H4z5Je9zSU3bsCWN8Y=;
 b=Y+6DloYqIcWGu0wjuTEGf/9pArTX8e5WVwwAjnpSpTYwK2QXhS1xyjEtvewyj9Y+DJZ7vMjz2jpXM
 C33nPgaNdOwkNCoPwm/e18f0TkmP4uHCKNFUDieSnXTJk7gAvYFSFr2Mydhrk2HX5ZOImo6pxSQbPX
 qzZkFMNZQhjKrU4PQ02SZIfoI578XzdCPFim10iJNB1nFR2xmux+z+NQbK7/Y3eQqEhjrDtc28tNch
 hpK8A+KRWBL/Ci+4vopi+4SiiOUKNvj8FvrYh5SlQRj1fzYpO0PKh3b3m8MsxJjlDafpksgI91LwI0
 VdnJT2GTE7Wl+kMLJ5DH9iRAFxkIPRg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=gA9bXiLm; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+0y/IAZ6c4dKro475ZEMQZ7X/H4z5Je9zSU3bsCWN8Y=;
 b=kJejgOlgowX+akysg6t17OlB1Xplyh49HsNsCLtbEnUJPnYPgy/D3ryFzxGyt+pIRaZiBfUULBT+Z
 yKdNjN+iaYEkKFeSSqNpPnqbARSB60c4DcGFAAX0Dfy0IiqB/+H40AV6kd2i5euOKW2JqC87bYD6L6
 0e9g6q5Aux293mbY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=+0y/IAZ6c4dKro475ZEMQZ7X/H4z5Je9zSU3bsCWN8Y=;
 b=ZcazcdijO+K0PF6y606sDlXKhMuHhnW+EB8OhmddUr8VxHiCDIBqeE2lTs1pcNPofPIW4AXNMMNlJ
 yQCzsPuQOmdlHlciXfg54XpzWn4g0rbfhI57lff/R+HpzXcQf6EO1zPusDOFCzFFfxCw7Y7IfFzWQZ
 24C3thb015MNq4hJv75qNJK4iZ9ByBGTN9ZAWHloStiY3+Xa7hy8DzM+TdXcVGywrRNTyDc8GMXm0E
 Mn3kdKF10wOtxgaHk6VY/JAMDsPyl3YfF0fLDEnh9nStRf0IZmTnaLyA9SNBQ3f7aRErVmgaHfhQXS
 qwVCUNtbXDPhyFNsKd7p6rMGZs1izCA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: abfaec1f-e4ab-11ee-b1ba-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id abfaec1f-e4ab-11ee-b1ba-eda7e384987e;
 Sun, 17 Mar 2024 22:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+0y/IAZ6c4dKro475ZEMQZ7X/H4z5Je9zSU3bsCWN8Y=; b=gA9bXiLmj3diV4nHEWrVeGXnec
 dRfLrGfpoHrzvGDHnJI7O43Kf+WauQlWBBPNeRfnZFMN92oAjy0KC+RCOs2koCyMauWLMK4UCyg9C
 STyoje6zLf0MSztRjy5yK7EosIU8DgyN6Uaei5N7knIg6wGV5JU97zbRgTNHf88u9UaGDGG9oNjEm
 St4UUS/S0gy0LRs1vZ3YV+aZxxqIMsJRbapFrzNkZQLaFeuTkOoEC0JgiaxwLavDxD4X9dqkftwjG
 cNKK38N2g5gKuYwFX4PEv5SzBta/7QQZkwsmtRxuE3YH4M4TESVqjKATlufEceVxiDLS6qg2FASED
 oHgggjcg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym7-004C3C-0f;
 Sun, 17 Mar 2024 23:14:39 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 7/7] target/hppa: fix do_stdby_e()
Date: Sun, 17 Mar 2024 23:14:31 +0100
Message-ID: <20240317221431.251515-8-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240317221431.251515-1-svens@stackframe.org>
References: <20240317221431.251515-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

stdby,e,m was writing data from the wrong half of the register
into memory for cases 0-3.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/op_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 480fe80844..6cf49f33b7 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -281,17 +281,17 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
+            atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
-            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
-        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
         break;
     default:
         /* Nothing is stored, but protection is checked and the
-- 
2.43.2


