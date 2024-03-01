Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56442C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6xz-0005Ng-Cj; Fri, 01 Mar 2024 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xx-0005LB-Sg
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:37 -0500
Received: from kudu.cherry.relay.mailchannels.net ([23.83.223.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rg6xw-0000YM-1A
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:46:37 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id AE8FF4C27CA
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:34 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id D18834C23BC
 for <qemu-devel@nongnu.org>; Fri,  1 Mar 2024 17:46:33 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709315194; a=rsa-sha256;
 cv=pass;
 b=gD38D4j5V6gJCxe8cYB7p2EGUZLaa8dkdKh1SIymGM+vbReIy86lD6AXuraFk+6HFR/SSh
 bNrYBciTRu+bbeWA8YYmkOag48plgOxpxiYbBkua2YC+L/b7R3uc0I9wTAsyAftzT3eXG8
 vF65S8FDRmpj9KnB4TsHzEIG5YLa0iAygwjoOCaLqzCN65wRXUbZnaMv6+++wfqgUPr5lW
 ZoiThGCES3+G2eZJSjMi/W4veVu9RpT52ZzWL9C32sgptfu+VazPDTsosHUzK02YuZrU3F
 Jznz91pdX4Q9p/HLV5Ja/6DDd1raFzDMTX9kNDc1th86uDvU1rW01XXe6yj5xg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709315194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=EDGjLGC6+iggpwOGgPEUhv6ALw0cm2bykCS2uoNYmHU=;
 b=+QTlKeOis9RR8vuxXqTD7RKY2Xo0i4SFLoKvOKlsXtyRNSMV7acpuiQAQKdYZ8eMMO1Kz/
 bTsdfufiwHa3hzF5jwq/Ur3ex95gJaRZ6OhetPrOzQK5qqo4JRkzVvV6/0puWqS7SWQQhx
 cV4bE9rZUS5vJ5TDpPdyzbMJc4CSRm3bCHEZXuybww/RoFCBFi4Thu6+fTI5OkYb+8WtTq
 img/KvzWspwxLZlq6Fs2olqTUrN/RKz1T1RtTERglDTjYkuTJOiZ6hc9wDL62YY99ZsaWX
 7GcnIaTGezLNKT1sfgqyzSQlFDQu87RfDpjCtfAuA1K+7hLg45x+L6uncd5B+A==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-jmwb2;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Left-Imminent: 508425fb36bac44e_1709315194353_855391027
X-MC-Loop-Signature: 1709315194351:1609689411
X-MC-Ingress-Time: 1709315194350
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.114.53.127 (trex/6.9.2); Fri, 01 Mar 2024 17:46:34 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709315167; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=HfpUlDhMTJ3jVEYdTW6wcjDJBBAe5iCbwwF80RAhM2IwkNmWe1bMRmVSNiwAIecNnBaZaGLNf5cvp
 iYt7Hi+zg/7kIGnKk88PAIDy4wkfU4BPfQmnmGoATO9oV8QZDxL8LVBt/oE2UzUL51/TcxmRdtbUM+
 6ddL+MWvOOfgtYGN07bgEi7+UqtgumRKPe9m3WuqguYRqLim0e+4PEVFmHla1o/f8wFIO31XSYa7HL
 foO6uAnf54UCL5zMSrLF3DppFVk0p3lyft36BilVHmLRJ+GZWKnI21ngk/91INi8Txq9xjGn3yRq3q
 O/CX+dUWFqT5BVD9D4SAvOUggY1bb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=EDGjLGC6+iggpwOGgPEUhv6ALw0cm2bykCS2uoNYmHU=;
 b=v3Z8KAxS6cyvF/UgX97Wqz6le8ud7yppyvBaBBhOh8sD2T/jjTmIl5Yvs+g5P7YwituhIAXEAzl0t
 ejbAhvcZlby6cYlZcLmCRbI4e8xgVjq2249cltHkf2JiLBl2y8SF9B9c1sWAYandloVQ4Yimnh84gv
 s97KHbRkjLudBEMnCua3HiaMLxyYBM59g7Qm45dKYCaygYT/2892NZkPU7/I1Fm7PqW8fPEe8IPDHF
 IG9Gtl+YsU8qmkrOlMsO5zW5wR4HyKX6nQzpRqq6b24Tc2DyEceIt9MRteOAqOjJ03g247f3UUSPY0
 VVYboHWZsVfhPXvqKNokZFVY8DAALfw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=eC6ZbTx5; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=EDGjLGC6+iggpwOGgPEUhv6ALw0cm2bykCS2uoNYmHU=;
 b=nj/hjMpNGo8BkFHMiv7Vm4V6u9E+Neqkm9D8X3+/oR0oj+KgK85+E3Erm7O6PnfRMcYI3NOgg+lfG
 jUNxLVYwyF6TBfUZvnkw1X6ad1e5ivgxDAMm1pbzmB3qkDR5ZbKGRP6NaVdN/FUhWcUJGsPEwPW1/F
 DpHhUlNRCh/kkX9Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=EDGjLGC6+iggpwOGgPEUhv6ALw0cm2bykCS2uoNYmHU=;
 b=UX5k5V7JU+IS1NqwBfv4JhlJcERPlqIIbZeMRApKdmbnqkAwieRZsX108mszuWk4ltdC7I/wtJ9Iq
 ld22cEc7sRbKbUpWKxF/bXIRnwCEk9H5DC/KFezo2FE0q0krOSXjbCWZ7cj6hG3lOKm2905R7U/USZ
 0hLNu9EOrsD6MKgAG1rPHOYLzgI4ugEqd+yltaim+McKCaHP5RlWDH5oMMsdormWlNh2SrIRgZ86Iu
 LEVmst76ODN/8nhWYulO6nutrYcYM58fY1zkSHO6tHZKg/PWWj1pLx8aXD3USkSTNTDtcSX2CrhlXd
 ZHIdLu1RVKG03NUr+moURddwp5S6fPA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 91a9270a-d7f3-11ee-afda-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 91a9270a-d7f3-11ee-afda-eda7e384987e;
 Fri, 01 Mar 2024 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EDGjLGC6+iggpwOGgPEUhv6ALw0cm2bykCS2uoNYmHU=; b=eC6ZbTx5wPLgqg7EsnpLkqxazW
 PX+hz7hxgCWCqyzNE3OYNjJzuKCUC63a3duf/qb1fvLxOWvod8VRhhs+FP91L081CQki2j6II/COb
 n/53dMzHDcI3seK1F0V/Jy4vZ6cGXU35CtOpQbxOtuuZHG8dczzX4RQGcLDN3+5+bhelXtTZFDNqo
 ucHxdKbupx/OESMD37MWQUIwFCDU6r/N1/GtqQwjrfyAtyX0GVkGir6IlOlLBXsfOr7Lcl2liDFFK
 SEZtixnxWGU/5jedUXQ/cjEzAmPtoAkTmweyTmHN2Z4Cj2PJzSup9bygrLWi0V/8k3CunoK3lXgSM
 XKrnPw7g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rg6xl-000bs2-2d;
 Fri, 01 Mar 2024 18:46:25 +0100
From: Sven Schnelle <svens@stackframe.org>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v3 07/12] util/range: make range_list_from_string() accept a
 single number
Date: Fri,  1 Mar 2024 18:46:04 +0100
Message-ID: <20240301174609.1964379-8-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301174609.1964379-1-svens@stackframe.org>
References: <20240301174609.1964379-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.97; envelope-from=svens@stackframe.org;
 helo=kudu.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To use range_list_from_string() as a replacement in the execlog
plugin, make it accept single numbers instead of a range. This
might also be useful for the already present debug_ranges filtering.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 util/range.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/util/range.c b/util/range.c
index 8c463995e7..7784c21b12 100644
--- a/util/range.c
+++ b/util/range.c
@@ -154,6 +154,11 @@ static int parse_single_range(const char *r, Error **errp,
 
     range_op = split_single_range(r, &r2);
     if (!range_op) {
+        if (!qemu_strtou64(r, &e, 0, &r1val) && *e == '\0') {
+            *lob = r1val;
+            *upb = r1val;
+            return 0;
+        }
         error_setg(errp, "Bad range specifier");
         return 1;
     }
-- 
2.43.2


