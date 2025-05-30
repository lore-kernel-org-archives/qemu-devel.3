Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0466AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvq-0000EZ-1T; Fri, 30 May 2025 03:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvm-0008Tc-5H
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvj-0006pq-WB
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhfwxdinJJdCY8Yy+StoCvJ5t74Fb+rUvLYPnVRdjZk=;
 b=TJzqvwgSilwvziP4xsOkWE+SQgAlC6ZcClXTgqAv3EypyDMkvcL6U3FpGQFSOsG/M2AHBr
 ncCO+7WQ97A4HWMCLWlF4YWbUjn25WQn+/Y6HJ2fqP4hdpkxIq3u9ZJT7wM1rjeae3tnGk
 4/9zLE2E2w0VxILmOwoyCnxFN0DmNY8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-UQIT1rUVND6WrPvO0sPBSg-1; Fri, 30 May 2025 03:13:25 -0400
X-MC-Unique: UQIT1rUVND6WrPvO0sPBSg-1
X-Mimecast-MFC-AGG-ID: UQIT1rUVND6WrPvO0sPBSg_1748589204
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-adb33457610so59442666b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589204; x=1749194004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhfwxdinJJdCY8Yy+StoCvJ5t74Fb+rUvLYPnVRdjZk=;
 b=bGpqc0aJf+JWIMvMUbWIOqfb5CrjK2ivvwrHE76Fc2l8hLAbwZ0yO0+MGEdzMFWuRp
 MR2liWd18lFVptQjdXnuHLNiQUd+EsHUByvfC5NGlwc4zyf5hah1i/JXEdQ4cZAY6FGA
 H5bbxsqUdI28+H/zrwOCRmC9QE3eI4qaOIup5Yd0xPmoRrH4mrLQjXSUI4US6b/IS4+r
 QbcxNncoGSB7VN8AmdOY4MMXgi6xHdUQnPm1eIkpxCMPITbcqL6sL++woyhQ0RNMmZDE
 ecgFDNmKPHSX1Fv/t/r5923cVACLSDNaTpTXS5RgQ1VZA87RhPiN/gm/54qks89wNBPO
 X4WQ==
X-Gm-Message-State: AOJu0YwVJs8DIzzYB4gsc7AZMDnBUoiNZFuNI9K0TFIQ5LvCla7PE2Ap
 femMujzLI8U8PLyHhKEe+3k23L5Y/DbyF6+RF6BBd44f6LvjvLrnPHjTlXVYtO3LqTuZycDYq5M
 5n0aTHSew6btVXXGYePZMC9msgW6GHHgVPnP+u/oC/KEbmV2SsC4odti1scfLotyVkEn2K538nT
 FKwVlgqTUVFrgGxrTnxUnZN2tuduXIUWwlqOAsM8Yu
X-Gm-Gg: ASbGnct0cHaTGk6Y9b0c+PTX0hhN0iOxHvTfFb+vH8N78NqO9K8qgzjHTi8+HEOSOZ4
 6vIHfIwwG20v/NkOT989PRJ4S5wOpMfurgKGFyb2c5peEqPfEoY6UTor+1CDzpeKpk7VD0w7xeL
 rbrCrBB5hVpZM/GeQYRrZGj5ex/grCm22PPUfzv9p6zI3ifl7MoVGm5ksjOzM8UQ+XmZem2vyr9
 AHc2AdmIM/DSXuNVOjfZL+eybOQwBTYjiL7cIX1f4lLttsbKiJK9jbLqeaMJcITPRT4cPhRN59/
 fz62ojginK/rKw==
X-Received: by 2002:a17:907:944d:b0:adb:2462:d921 with SMTP id
 a640c23a62f3a-adb322b3598mr219028966b.5.1748589203588; 
 Fri, 30 May 2025 00:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpEV8waias0nHPMABUee2GDULcgj7LSFT5OxJa3mnBIi0IAo9Ml3A05sz1O6NeKwvPJYr8hA==
X-Received: by 2002:a17:907:944d:b0:adb:2462:d921 with SMTP id
 a640c23a62f3a-adb322b3598mr219025666b.5.1748589203006; 
 Fri, 30 May 2025 00:13:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fec86sm276407466b.7.2025.05.30.00.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/77] rocker: do not pollute the namespace
Date: Fri, 30 May 2025 09:11:43 +0200
Message-ID: <20250530071250.2050910-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Do not leave the __le* macros defined, in fact do not use them at all.  Fixes a
build failure on Alpine with the TDX patches:

In file included from ../hw/net/rocker/rocker_of_dpa.c:25:
../hw/net/rocker/rocker_hw.h:14:16: error: conflicting types for 'uint64_t'; have '__u64' {aka 'long long unsigned int'}
   14 | #define __le64 uint64_t
      |                ^~~~~~~~
In file included from /usr/include/stdint.h:20,
                 from ../include/qemu/osdep.h:111,
                 from ../hw/net/rocker/rocker_of_dpa.c:17:
/usr/include/bits/alltypes.h:136:25: note: previous declaration of 'uint64_t' with type 'uint64_t' {aka 'long unsigned int'}
  136 | typedef unsigned _Int64 uint64_t;
      |                         ^~~~~~~~

because the Linux headers include a typedef of __leNN.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/rocker/rocker.h        | 14 +++---------
 hw/net/rocker/rocker_hw.h     | 20 +++++++-----------
 hw/net/rocker/rocker_of_dpa.c | 40 +++++++++++++++++------------------
 3 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/hw/net/rocker/rocker.h b/hw/net/rocker/rocker.h
index 6e0962f47a8..ae06c1c72af 100644
--- a/hw/net/rocker/rocker.h
+++ b/hw/net/rocker/rocker.h
@@ -36,15 +36,7 @@ static inline G_GNUC_PRINTF(1, 2) int DPRINTF(const char *fmt, ...)
 }
 #endif
 
-#define __le16 uint16_t
-#define __le32 uint32_t
-#define __le64 uint64_t
-
-#define __be16 uint16_t
-#define __be32 uint32_t
-#define __be64 uint64_t
-
-static inline bool ipv4_addr_is_multicast(__be32 addr)
+static inline bool ipv4_addr_is_multicast(uint32_t addr)
 {
     return (addr & htonl(0xf0000000)) == htonl(0xe0000000);
 }
@@ -52,8 +44,8 @@ static inline bool ipv4_addr_is_multicast(__be32 addr)
 typedef struct ipv6_addr {
     union {
         uint8_t addr8[16];
-        __be16 addr16[8];
-        __be32 addr32[4];
+        uint16_t addr16[8];
+        uint32_t addr32[4];
     };
 } Ipv6Addr;
 
diff --git a/hw/net/rocker/rocker_hw.h b/hw/net/rocker/rocker_hw.h
index 1786323fa4a..7ec6bfbcb92 100644
--- a/hw/net/rocker/rocker_hw.h
+++ b/hw/net/rocker/rocker_hw.h
@@ -9,10 +9,6 @@
 #ifndef ROCKER_HW_H
 #define ROCKER_HW_H
 
-#define __le16 uint16_t
-#define __le32 uint32_t
-#define __le64 uint64_t
-
 /*
  * Return codes
  */
@@ -124,12 +120,12 @@ enum {
  */
 
 typedef struct rocker_desc {
-    __le64 buf_addr;
+    uint64_t buf_addr;
     uint64_t cookie;
-    __le16 buf_size;
-    __le16 tlv_size;
-    __le16 rsvd[5];   /* pad to 32 bytes */
-    __le16 comp_err;
+    uint16_t buf_size;
+    uint16_t tlv_size;
+    uint16_t rsvd[5];   /* pad to 32 bytes */
+    uint16_t comp_err;
 } __attribute__((packed, aligned(8))) RockerDesc;
 
 /*
@@ -137,9 +133,9 @@ typedef struct rocker_desc {
  */
 
 typedef struct rocker_tlv {
-    __le32 type;
-    __le16 len;
-    __le16 rsvd;
+    uint32_t type;
+    uint16_t len;
+    uint16_t rsvd;
 } __attribute__((packed, aligned(8))) RockerTlv;
 
 /* cmd msg */
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 3378f63110b..4aed1787566 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -52,10 +52,10 @@ typedef struct of_dpa_flow_key {
     uint32_t tunnel_id;              /* overlay tunnel id */
     uint32_t tbl_id;                 /* table id */
     struct {
-        __be16 vlan_id;              /* 0 if no VLAN */
+        uint16_t vlan_id;              /* 0 if no VLAN */
         MACAddr src;                 /* ethernet source address */
         MACAddr dst;                 /* ethernet destination address */
-        __be16 type;                 /* ethernet frame type */
+        uint16_t type;                 /* ethernet frame type */
     } eth;
     struct {
         uint8_t proto;               /* IP protocol or ARP opcode */
@@ -66,14 +66,14 @@ typedef struct of_dpa_flow_key {
     union {
         struct {
             struct {
-                __be32 src;          /* IP source address */
-                __be32 dst;          /* IP destination address */
+                uint32_t src;          /* IP source address */
+                uint32_t dst;          /* IP destination address */
             } addr;
             union {
                 struct {
-                    __be16 src;      /* TCP/UDP/SCTP source port */
-                    __be16 dst;      /* TCP/UDP/SCTP destination port */
-                    __be16 flags;    /* TCP flags */
+                    uint16_t src;      /* TCP/UDP/SCTP source port */
+                    uint16_t dst;      /* TCP/UDP/SCTP destination port */
+                    uint16_t flags;    /* TCP flags */
                 } tp;
                 struct {
                     MACAddr sha;     /* ARP source hardware address */
@@ -86,11 +86,11 @@ typedef struct of_dpa_flow_key {
                 Ipv6Addr src;       /* IPv6 source address */
                 Ipv6Addr dst;       /* IPv6 destination address */
             } addr;
-            __be32 label;            /* IPv6 flow label */
+            uint32_t label;            /* IPv6 flow label */
             struct {
-                __be16 src;          /* TCP/UDP/SCTP source port */
-                __be16 dst;          /* TCP/UDP/SCTP destination port */
-                __be16 flags;        /* TCP flags */
+                uint16_t src;          /* TCP/UDP/SCTP source port */
+                uint16_t dst;          /* TCP/UDP/SCTP destination port */
+                uint16_t flags;        /* TCP flags */
             } tp;
             struct {
                 Ipv6Addr target;    /* ND target address */
@@ -112,13 +112,13 @@ typedef struct of_dpa_flow_action {
     struct {
         uint32_t group_id;
         uint32_t tun_log_lport;
-        __be16 vlan_id;
+        uint16_t vlan_id;
     } write;
     struct {
-        __be16 new_vlan_id;
+        uint16_t new_vlan_id;
         uint32_t out_pport;
         uint8_t copy_to_cpu;
-        __be16 vlan_id;
+        uint16_t vlan_id;
     } apply;
 } OfDpaFlowAction;
 
@@ -143,7 +143,7 @@ typedef struct of_dpa_flow {
 typedef struct of_dpa_flow_pkt_fields {
     uint32_t tunnel_id;
     struct eth_header *ethhdr;
-    __be16 *h_proto;
+    uint16_t *h_proto;
     struct vlan_header *vlanhdr;
     struct ip_header *ipv4hdr;
     struct ip6_header *ipv6hdr;
@@ -180,7 +180,7 @@ typedef struct of_dpa_group {
             uint32_t group_id;
             MACAddr src_mac;
             MACAddr dst_mac;
-            __be16 vlan_id;
+            uint16_t vlan_id;
         } l2_rewrite;
         struct {
             uint16_t group_count;
@@ -190,13 +190,13 @@ typedef struct of_dpa_group {
             uint32_t group_id;
             MACAddr src_mac;
             MACAddr dst_mac;
-            __be16 vlan_id;
+            uint16_t vlan_id;
             uint8_t ttl_check;
         } l3_unicast;
     };
 } OfDpaGroup;
 
-static int of_dpa_mask2prefix(__be32 mask)
+static int of_dpa_mask2prefix(uint32_t mask)
 {
     int i;
     int count = 32;
@@ -451,7 +451,7 @@ static void of_dpa_flow_pkt_parse(OfDpaFlowContext *fc,
     fc->iovcnt = iovcnt + 2;
 }
 
-static void of_dpa_flow_pkt_insert_vlan(OfDpaFlowContext *fc, __be16 vlan_id)
+static void of_dpa_flow_pkt_insert_vlan(OfDpaFlowContext *fc, uint16_t vlan_id)
 {
     OfDpaFlowPktFields *fields = &fc->fields;
     uint16_t h_proto = fields->ethhdr->h_proto;
@@ -486,7 +486,7 @@ static void of_dpa_flow_pkt_strip_vlan(OfDpaFlowContext *fc)
 
 static void of_dpa_flow_pkt_hdr_rewrite(OfDpaFlowContext *fc,
                                         uint8_t *src_mac, uint8_t *dst_mac,
-                                        __be16 vlan_id)
+                                        uint16_t vlan_id)
 {
     OfDpaFlowPktFields *fields = &fc->fields;
 
-- 
2.49.0


