Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13735C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAnQw-0004o2-UH; Sun, 27 Sep 2026 07:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xAmhL-0004u3-OQ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 07:05:35 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xAmhJ-0002zm-44
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 07:05:35 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so10699235e9.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790507131; x=1791111931; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GyxGnznNeFi9JzzBcR4PevkkkuHGTwhJ6Osb7/3gz34=;
 b=B59HFS8yejtf/KXkAc6VQ/4LxIAV4tRTWT1f1xPIaNp7KDLURqAOQ7pjrKpPcJ9ts1
 TIVYx6xyl4roNrsTl/F58qBATyV/kXgTaL9cAIIgI6HN2BS6DQHJggujPRlkeUInkDTQ
 CweIzkwy1LWeE/zIpvUlRcbr4BQb8ZZ1LFHLhub1YLBCX45f8nFBzaQye2N7+DwtPzWQ
 hnpqspZmyXcDRXBQ2ZIxmhL1JaVUJKDS0ln5ifRDsZ+AnF3IgROxorSG6UaJwMKQh7Q5
 uiLZGno9kKMIBgZH3tDN8ZDs+3R/WcWjQc+Zmj5z2hs0kpdxJltQfTBhumAObwXnBkb3
 m5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790507131; x=1791111931;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GyxGnznNeFi9JzzBcR4PevkkkuHGTwhJ6Osb7/3gz34=;
 b=knPN5vui3l1Jfj5dkxGB/CZ5NYFwzSU5T57CetalPuizmBaWfqVvzyS+s6fKiJjOPz
 9li6jZhzXmZNcKYrtxEteF6Co5Mtx7SeVh17sZAhYEyFoIwTy16c5/wSCIQV0ryUZ5hc
 mwJfLQo1hppeitZAZ9OMsKweMyBZT1LJXn24i+byRBnpZ0MjuXviYOR77Cm8wPLFNcQI
 W9obVclktSLEi7Kdh0FUIG70oi69pPgS/no+adjHZZXuOzEgMsEFJsWYZvzBX0fXWlUi
 fPhM2ynDBmememGFAI1jYsF7cqc8zv9T0LDi4WtvkjbG3Qf1QD0jXMvsaRHizWMDq8Z5
 2AWQ==
X-Gm-Message-State: AFuF++kz90927T7+V9cDe98O3iqBasT8hsGdo+pb96uPqm6TceT8N8W7
 hNN8HdXnMNvmbOoo/G2Xmj+hMurU5H3uTdjVqyA9AKQ8RZVfvmwwy7M1XSm3fYWRVi0xfg==
X-Gm-Gg: AYBFou1/R/pdZWK5SEQ2cKPU9qw9N6ss695INs5i/Jk+ddTqZAdcIobe74cHcrRH60d
 V1hb4PGotumbWLxnjG0laSSjVc4BrsfLvLfzl8N1eRfa7Vs0CTNOk1QEhfJbY/4LUxYJ8h5qgsN
 Ox99rTkr1NuVAdtsKI6mXsO8/V5YV0rEXr10SD+NH5vnmzpNy5hCns/zHe3vltTTS30ksUPBLpX
 YI5mt0Bktt1q1k3QFIrpQNJ2YQc5zlQqX5q/iwC56ld3r4XizxaYApUUzjT3nAA0akoFAlf61lJ
 tAikmedwOciKjQGF41oz48LGf79uaEGJIgVeNxcGBsmvUVhrv5EfhWNaXPdx3PAQlyvaFbFuoCz
 SfdWRhFDk8Uylxs9/c4cCwmr7gtASZfvjuzSdbrmvQ+ybKTRD3BnuHAgrI7O5rb2XaBn3JajVQP
 RH3PWB9R1jWhCO4SvmpnSDXXE3t5xqLOU52pffCrm7Q7qAkg2eBqYDaBmeKWDsj8Q4RIdYgYfgD
 HsFhBSZVvSznpk4EJGXaGhSqL+2SPD74ImWLChJLNqVi9CPSaize1J+ZWmAJceiedlIu6vCDWeL
 YSWrpX59TKmdVwuqSeH9z8b6uXhuQxMAVWLMToUb0e3q4ys2AAlA0Os=
X-Received: by 2002:a05:600c:5488:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a0005b7e33mr27795195e9.21.1790507130983; 
 Sun, 27 Sep 2026 04:05:30 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa
 (dynamic-2a02-3100-6329-9000-ec02-636e-4a38-e62a.310.pool.telefonica.de.
 [2a02:3100:6329:9000:ec02:636e:4a38:e62a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001904513sm71803135e9.10.2026.09.27.04.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 04:05:30 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Sun, 27 Sep 2026 13:04:44 +0200
Subject: [PATCH] net/vmnet: Add host address options for vmnet-host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-vmnet-host-address-v1-1-6feb74f727c5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB2woSp6leIiyUzqFIwlk0pBv
 HtTXb7F/zsoJ2GFsdoh8SYqayy41RX42cYno1AxmMZ0zWB63JbIGedVM1qixKp470NoabDknYM
 SvhMH+Z7Tx3RZP+7FPv9PcBw/3sfuP3YAAAA=
X-Change-ID: 20260927-vmnet-host-address-47ff5d9adcbb
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=timpambor@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 27 Sep 2026 07:52:41 -0400
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

When a vmnet-host interface is added to an isolated network via
'net-uuid', vmnet does not provide DHCP and the host side of the
bridge gets no address, so the host cannot talk to guests on that
network without manually assigning an IP address to the bridge
interface after QEMU has started.

vmnet provides the vmnet_host_ip_address_key,
vmnet_host_subnet_mask_key and vmnet_host_ipv6_address_key
properties to assign addresses to the host interface in this case.
Expose them as the 'host-ip-address', 'host-subnet-mask' and
'host-ipv6-address' options of the vmnet-host backend.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 net/vmnet-host.c | 35 +++++++++++++++++++++++++++++++++++
 qapi/net.json    | 15 ++++++++++++++-
 qemu-options.hx  |  6 +++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/vmnet-host.c b/net/vmnet-host.c
index 49fb25c224..8ed7ee9d41 100644
--- a/net/vmnet-host.c
+++ b/net/vmnet-host.c
@@ -41,6 +41,26 @@ static bool validate_options(const Netdev *netdev, Error **errp)
         return false;
     }
 
+    if ((options->host_ip_address || options->host_subnet_mask) &&
+        !(options->host_ip_address && options->host_subnet_mask)) {
+        error_setg(errp,
+                   "'host-ip-address' and 'host-subnet-mask' "
+                   "should be provided together");
+        return false;
+    }
+
+    if (options->host_ip_address && !options->net_uuid) {
+        error_setg(errp,
+                   "'host-ip-address' requires 'net-uuid' to be specified");
+        return false;
+    }
+
+    if (options->host_ipv6_address && !options->net_uuid) {
+        error_setg(errp,
+                   "'host-ipv6-address' requires 'net-uuid' to be specified");
+        return false;
+    }
+
     return true;
 }
 
@@ -77,6 +97,21 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                   options->subnet_mask);
     }
 
+    if (options->host_ip_address) {
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_ip_address_key,
+                                  options->host_ip_address);
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_subnet_mask_key,
+                                  options->host_subnet_mask);
+    }
+
+    if (options->host_ipv6_address) {
+        xpc_dictionary_set_string(if_desc,
+                                  vmnet_host_ipv6_address_key,
+                                  options->host_ipv6_address);
+    }
+
     return if_desc;
 }
 
diff --git a/qapi/net.json b/qapi/net.json
index b46af1fdc9..38b43d20ed 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -795,6 +795,16 @@
 #     is allowed only with other interfaces added to this network
 #     identified by the UUID.  Requires at least macOS Big Sur 11.0.
 #
+# @host-ip-address: The IPv4 address to set on the host side of the
+#     interface.  Only applicable when @net-uuid is also specified.
+#     Must be specified along with @host-subnet-mask.
+#
+# @host-subnet-mask: The IPv4 subnet mask to set on the host side of
+#     the interface.  Must be specified along with @host-ip-address.
+#
+# @host-ipv6-address: The IPv6 address to set on the host side of the
+#     interface.  Only applicable when @net-uuid is also specified.
+#
 # Since: 7.1
 ##
 { 'struct': 'NetdevVmnetHostOptions',
@@ -803,7 +813,10 @@
     '*end-address':   'str',
     '*subnet-mask':   'str',
     '*isolated':      'bool',
-    '*net-uuid':      'str' },
+    '*net-uuid':      'str',
+    '*host-ip-address': 'str',
+    '*host-subnet-mask': 'str',
+    '*host-ipv6-address': 'str' },
   'if': 'CONFIG_VMNET' }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b..9e250ad196 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3137,11 +3137,15 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_VMNET
     "-netdev vmnet-host,id=str[,isolated=on|off][,net-uuid=uuid]\n"
     "         [,start-address=addr,end-address=addr,subnet-mask=mask]\n"
+    "         [,host-ip-address=addr,host-subnet-mask=mask][,host-ipv6-address=addr]\n"
     "                configure a vmnet network backend in host mode with ID 'str',\n"
     "                isolate this interface from others with 'isolated',\n"
     "                configure the address range and choose a subnet mask,\n"
     "                specify network UUID 'uuid' to disable DHCP and interact with\n"
-    "                vmnet-host interfaces within this isolated network\n"
+    "                vmnet-host interfaces within this isolated network,\n"
+    "                set the host-side IPv4 address and subnet mask on an\n"
+    "                isolated network with 'host-ip-address' and 'host-subnet-mask',\n"
+    "                set the host-side IPv6 address with 'host-ipv6-address'\n"
     "-netdev vmnet-shared,id=str[,isolated=on|off][,nat66-prefix=addr]\n"
     "         [,start-address=addr,end-address=addr,subnet-mask=mask]\n"
     "                configure a vmnet network backend in shared mode with ID 'str',\n"

---
base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457
change-id: 20260927-vmnet-host-address-47ff5d9adcbb

Best regards,
--  
Tim Pambor <timpambor@gmail.com>


