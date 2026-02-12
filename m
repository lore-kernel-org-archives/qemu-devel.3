Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C0AEE3688
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXNt-0000hD-Ni; Thu, 12 Feb 2026 09:09:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNm-0000fw-6S
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqXNj-0006Pt-BO
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:09:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso30010775e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770905362; x=1771510162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/c4UhHWbCQRd4FJDg3uOEjFMuAnPkaZruMWzUtSXGU=;
 b=lMqRprPcCVcRvDP9x8ucLSh6a6213H1EpsQUCLiSyeWTcRPUR0Oem2aa6/WtdSLDgn
 BS55wmL6dOaN2Ugedc+XWcm6Vg29cG1kCBdO8gc0eKesAukPyhjKR0HnMVKShu8yc0V5
 QxBYGrYKcJv/RpntPHy7kBq65y1lCKu0+Jndg0H08BQlryOoCkFM0FmdZL36IfBXL72X
 wfmy0qn14gMTrXrvoSYog7kFCnrW/znSSruoxB4N+BZqog93qS4i0fD4mnRCkcgEyq4h
 YDBBUU9jcMSTOYNWPU0fd9MlCLqVpcIJ8cJiV+gs6nlZn927lsWX+A85z5fQZXcCLEMD
 2FEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770905362; x=1771510162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/c4UhHWbCQRd4FJDg3uOEjFMuAnPkaZruMWzUtSXGU=;
 b=sUxIWbvlisolpmBgElGCenq5NUIFwUMTVFWuOS0S8DKkdOA9sk4OvtZ1NGJGT6oNd3
 ZK8dBkAQXD6h2cRVnNHUEZLbymOZjzMn/RI4XJwK73mXCDIlBOSCpb/tFTb40l295+Ob
 /jrqRuhcjKLOxQTMm/+hJTkxnmGzN2Rtk/P2JCBuHfnAjTXHkJWTI3PSrOomm+ocXzz7
 +g6/ODaScSawXMG+ogKy1ZPmlOfRuMg9thxx/kP7kjVTcNz0dVp4er2TUJ7/A370zADp
 HKSTgPeSvkNOOyOS1qQqIPObF6aebhvrKGj1PwW46ktjTEquo/XvTS+ejP5CowN5V5rz
 AYQw==
X-Gm-Message-State: AOJu0YxgWHmlILo4/r8CLfeDU7yMvQSP6Y3Jf4WvRiSAN5pVK+W7+uIC
 LXwG4ZKZ6KeKPK+Vw+vqDgcfz4Lp5zgxPQ65q7G+zCtaMbb//KnfX0W61FC7Ij0jKjKqY98mPKm
 B5m5F
X-Gm-Gg: AZuq6aJ6/Kpc3cq81wkALJa3LPxZhM2IkVFJLWl6T1q8mhq5Pq1VL9XYcxt7Lh2365A
 RgQCKnQrDljcyw8EXNKSH08t3gDFgLeuMr41oy53+hwO/HPMnssrNDNdQ+auog0NdxEYlz7DZfA
 6RCWDuQZzQ6xBXdkXo3i+SU5qgGgI8jN1Jyqrd6vVjd595ZrdChGYbZ1hgzaQ7oV7umOOG2Wbd5
 X9ZQnxD6VhaGrFV72+CzCxr+sfcN826Q1EZZdAS23L153OnVJLnn3nks8fcZVB5m2ODg9KUvswZ
 CFTdh6WP3csZtDKaL4YOzbpR0weiDX+2fJljr7hH3LGpwwNgb4sjraaoole/iMdYsklUWPTbqiM
 fX5ahbPzdKFMsuFQvuxsKSVtsgBvry8pEemeYIFjZusWgga8UHQePH2SP4AHEArBv1+XZfUlKkl
 /CttAsr2a92+E+r8W8EpQELyE/gHO8rJEdctrwOnSZUd+YaenR9eaDcKvbfQ841SZFxcZiUSbSK
 rg85Jy2IMXaRhDfnu4O4y7EP3IQ+2A=
X-Received: by 2002:a05:600c:4f41:b0:483:6f7c:19f4 with SMTP id
 5b1f17b1804b1-4836f7c1ab9mr7020955e9.30.1770905361788; 
 Thu, 12 Feb 2026 06:09:21 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm123266885e9.14.2026.02.12.06.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:09:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 1/5] hw/net/rocker: Don't keep pointer to h_proto as uint16_t*
 in OfDpaFlowPktFields
Date: Thu, 12 Feb 2026 14:09:13 +0000
Message-ID: <20260212140917.1443253-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In rocker_of_dpa.c we assume that the h_proto field in an eth_header
struct is aligned, and we copy its address into a uint16_t* in the
OfDpaFlowPktFields struct which we then dereference later.  This
isn't a safe assumption; it will also result in compilation failures
with gcc if we mark the eth_header struct as QEMU_PACKED because gcc
will not let you take the address of an unaligned struct field.

Make the h_proto field in OfDpaFlowPktFields a void*, and make all
the places where we previously read through that pointer instead use
a new accessor function which allows for the possible lack of
alignment.

(Compare commit 5814c084679
"hw/net/virtio-net.c: Don't assume IP length field is aligned"
which fixed a similar problem elsewhere for an ip_header field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 16b9bc7a4b..814f19afc5 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -143,7 +143,7 @@ typedef struct of_dpa_flow {
 typedef struct of_dpa_flow_pkt_fields {
     uint32_t tunnel_id;
     struct eth_header *ethhdr;
-    uint16_t *h_proto;
+    void *h_proto; /* pointer to unaligned uint16_t data */
     struct vlan_header *vlanhdr;
     struct ip_header *ipv4hdr;
     struct ip6_header *ipv6hdr;
@@ -196,6 +196,11 @@ typedef struct of_dpa_group {
     };
 } OfDpaGroup;
 
+static uint16_t of_dpa_flow_pkt_h_proto(const OfDpaFlowPktFields *fields)
+{
+    return lduw_he_p(fields->h_proto);
+}
+
 static int of_dpa_mask2prefix(uint32_t mask)
 {
     return 32 - ctz32(ntohl(mask));
@@ -395,7 +400,7 @@ static void of_dpa_flow_pkt_parse(OfDpaFlowContext *fc,
     fields->ethhdr = iov->iov_base;
     fields->h_proto = &fields->ethhdr->h_proto;
 
-    if (ntohs(*fields->h_proto) == ETH_P_VLAN) {
+    if (ntohs(of_dpa_flow_pkt_h_proto(fields) == ETH_P_VLAN)) {
         sofar += sizeof(struct vlan_header);
         if (iov->iov_len < sofar) {
             DPRINTF("flow_pkt_parse underrun on vlan_header\n");
@@ -405,7 +410,7 @@ static void of_dpa_flow_pkt_parse(OfDpaFlowContext *fc,
         fields->h_proto = &fields->vlanhdr->h_proto;
     }
 
-    switch (ntohs(*fields->h_proto)) {
+    switch (ntohs(of_dpa_flow_pkt_h_proto(fields))) {
     case ETH_P_IP:
         sofar += sizeof(struct ip_header);
         if (iov->iov_len < sofar) {
@@ -547,7 +552,7 @@ static void of_dpa_term_mac_build_match(OfDpaFlowContext *fc,
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_TERMINATION_MAC;
     match->value.in_pport = fc->in_pport;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     memcpy(match->value.eth.dst.a, fc->fields.ethhdr->h_dest,
            sizeof(match->value.eth.dst.a));
@@ -643,7 +648,7 @@ static void of_dpa_unicast_routing_build_match(OfDpaFlowContext *fc,
                                                OfDpaFlowMatch *match)
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_UNICAST_ROUTING;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     if (fc->fields.ipv4hdr) {
         match->value.ipv4.addr.dst = fc->fields.ipv4hdr->ip_dst;
     }
@@ -672,7 +677,7 @@ of_dpa_multicast_routing_build_match(OfDpaFlowContext *fc,
                                      OfDpaFlowMatch *match)
 {
     match->value.tbl_id = ROCKER_OF_DPA_TABLE_ID_MULTICAST_ROUTING;
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     if (fc->fields.ipv4hdr) {
         match->value.ipv4.addr.src = fc->fields.ipv4hdr->ip_src;
@@ -713,7 +718,7 @@ static void of_dpa_acl_build_match(OfDpaFlowContext *fc,
            sizeof(match->value.eth.src.a));
     memcpy(match->value.eth.dst.a, fc->fields.ethhdr->h_dest,
            sizeof(match->value.eth.dst.a));
-    match->value.eth.type = *fc->fields.h_proto;
+    match->value.eth.type = of_dpa_flow_pkt_h_proto(&fc->fields);
     match->value.eth.vlan_id = fc->fields.vlanhdr->h_tci;
     match->value.width = FLOW_KEY_WIDTH(eth.type);
     if (fc->fields.ipv4hdr) {
-- 
2.43.0


