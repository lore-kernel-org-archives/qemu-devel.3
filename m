Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E90D44163
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8g-0005vX-FG; Tue, 19 Nov 2024 09:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Z-0005pc-QX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8X-0006CJ-JS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:27 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso899235f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026204; x=1732631004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HY8iA1JcrinboJKdqzd9q3NbVD25Sy0Ej7yrNivMt5k=;
 b=HHMfho9esUe8CT0+P19NuGahjWwMZEgi6NHoJYyl/SVTguS0w1ulQIOLQAf0GI1Z7w
 FRdkclvJs4QJoz1Ax/7K4AoGwWErRYZPdrZIWll4Oq3CIJ2kLp2mrsjkqICQAp1mjHZr
 0WlvczHRU/U0M3Z/WY6Ou2wUv0+9a3PI0z8kX3xlaJy3Zx+bSLr4SfnNTFHgJmfIrN0O
 U2F6Feq6xbvHPV3o9lqNAh9ZTuD+cHohF0qOpsZ2qQ5DEcigGgwQQrnR26xRAEYtHkRC
 H/rubweyJ+27SGziYj/kWIxmEVwpBQpjy8I+a8rH3T8X7zkphqtCh9AQNLECtUQYCOFf
 EwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026204; x=1732631004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HY8iA1JcrinboJKdqzd9q3NbVD25Sy0Ej7yrNivMt5k=;
 b=sAeZenrdGytl3LJOm0W7nx052QGPjytNf8cqjXH0LqQsOpK9SNVD4g+y0++80uZEGc
 eP0Bif9mtqaQAAt3rVNcqmwDVc5BU/NQghWnFLxlbpCBk4URIueq+qwMIATvA8fH1rjq
 B1SNthu5QCcsDQe25+xcpFANBXkqEWHH3FQq82s/pdaEubfYrFL63zaawhSvbhQ8ZKBM
 iQ2MXPDrCPeGpx2XlXPAIluLW3dMgonLEUOckR0hi+xWho64DDESXjVIBsAK5AyHDO6j
 oNxGFI1BY+AwlbaHN1J9o+ifonczlr2M5aQCByGkVst8P6aL/d6+0UbtOVVPODB0F/eW
 l/xg==
X-Gm-Message-State: AOJu0Yzh6Db/RXC1+zcQJmcOLiMBSdtApq9FWg4mAae0YzSnxJRrDf0J
 J3WBWcATEYk1rwMrtTk7c/GfP1U6d6Cvp+gV1+BUiQVcoFuIhAJbnnCdpcVPN8ZDvWFsX9hreh+
 M
X-Google-Smtp-Source: AGHT+IHqlwZ02qKumhmUI2qgE8+bDP9/6ebFr+VPui01Go7nsTUvsDRBtYHtsxKluPtTXx7DMR5BFA==
X-Received: by 2002:a05:6000:381:b0:382:4f4e:1cb6 with SMTP id
 ffacd0b85a97d-3824f4e21c2mr1626634f8f.28.1732026203921; 
 Tue, 19 Nov 2024 06:23:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] hw/net/rocker/rocker_of_dpa.c: Remove superfluous error
 check
Date: Tue, 19 Nov 2024 14:23:08 +0000
Message-Id: <20241119142321.1853732-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Rodrigo Dias Correa <r@drigo.nl>

of_dpa_cmd_add_acl_ip() is called from a single place, and despite the
fact that it always returns ROCKER_OK, its return value is still checked
by the caller.

Change of_dpa_cmd_add_acl_ip() to return void and remove the superfluous
check from of_dpa_cmd_add_acl().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2471
Signed-off-by: Rodrigo Dias Correa <r@drigo.nl>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Message-id: 20241114075051.404284-1-r@drigo.nl
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 5e16056be66..3378f63110b 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -1635,8 +1635,8 @@ static int of_dpa_cmd_add_multicast_routing(OfDpaFlow *flow,
     return ROCKER_OK;
 }
 
-static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
-                                 RockerTlv **flow_tlvs)
+static void of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
+                                  RockerTlv **flow_tlvs)
 {
     key->width = FLOW_KEY_WIDTH(ip.tos);
 
@@ -1669,8 +1669,6 @@ static int of_dpa_cmd_add_acl_ip(OfDpaFlowKey *key, OfDpaFlowKey *mask,
         mask->ip.tos |=
             rocker_tlv_get_u8(flow_tlvs[ROCKER_TLV_OF_DPA_IP_ECN_MASK]) << 6;
     }
-
-    return ROCKER_OK;
 }
 
 static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
@@ -1689,7 +1687,6 @@ static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
         ACL_MODE_ANY_VLAN,
         ACL_MODE_ANY_TENANT,
     } mode = ACL_MODE_UNKNOWN;
-    int err = ROCKER_OK;
 
     if (!flow_tlvs[ROCKER_TLV_OF_DPA_IN_PPORT] ||
         !flow_tlvs[ROCKER_TLV_OF_DPA_ETHERTYPE]) {
@@ -1776,14 +1773,10 @@ static int of_dpa_cmd_add_acl(OfDpaFlow *flow, RockerTlv **flow_tlvs)
     switch (ntohs(key->eth.type)) {
     case 0x0800:
     case 0x86dd:
-        err = of_dpa_cmd_add_acl_ip(key, mask, flow_tlvs);
+        of_dpa_cmd_add_acl_ip(key, mask, flow_tlvs);
         break;
     }
 
-    if (err) {
-        return err;
-    }
-
     if (flow_tlvs[ROCKER_TLV_OF_DPA_GROUP_ID]) {
         action->write.group_id =
             rocker_tlv_get_le32(flow_tlvs[ROCKER_TLV_OF_DPA_GROUP_ID]);
-- 
2.34.1


