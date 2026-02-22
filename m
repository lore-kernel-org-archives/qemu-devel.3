Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78902C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAT7-0001DG-L2; Sun, 22 Feb 2026 09:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASi-0008OA-16
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASf-0006we-4l
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMGbJNVQmmXj2XYsxDUgnIqhPUEYPSlhqr1KI3l+La8=;
 b=G9vXIFc6FQjjjnnPiSuAjzkqRPBD3hXVp8s/KM9jR21cKdRxE+rCRogcA4vM0R7hnzOUu6
 FCaM9ge/Sn2TKygv2sMMt4+l0oJ430yYM871TTDoelxsc5hc8n2ijiKTjxvjbmd9dtIfEI
 If4djqEu3P1WejOMGS5a387Wk2zcsXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-5kloRLARMJajr_XJhIloYg-1; Sun, 22 Feb 2026 09:29:22 -0500
X-MC-Unique: 5kloRLARMJajr_XJhIloYg-1
X-Mimecast-MFC-AGG-ID: 5kloRLARMJajr_XJhIloYg_1771770561
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso37566925e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770561; x=1772375361; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pMGbJNVQmmXj2XYsxDUgnIqhPUEYPSlhqr1KI3l+La8=;
 b=LyUy9ZAabcpK15aGItakzqSJemdzrsvcz0WvH212d1LHpDfwjc/+mPPOSGwuc35PBy
 km+BZ16/6M5WMFJEpcpBGh8Dwbr/kK8dVGGyJbaeInUjZeEAiBIgg+d+8hpSB8RIDB78
 Oa585A7ynElUi3LCE6zHsNDE3NiUhLSz4b8QoYnt2RCTBXcWO4zE6jTKh2nu5/HysJJN
 lvAnQh8nxdKnXE88MrjcA1m/GSSlg/8TCqAiIXI4KGFvKUNDjk94EaRu5MXx9OnHc0fF
 ak7bVnJUpPpQLDC4bbd/6DTKJeujIck0bTw0/edPvm4xG2u0BU2/ZyWCHs9wJhHrcmA9
 b3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770561; x=1772375361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMGbJNVQmmXj2XYsxDUgnIqhPUEYPSlhqr1KI3l+La8=;
 b=v0+gKyfWeLMjIYDDHrTSIL+/pqWvApXJkI1XMrHCSLQ7h9dMQZ2dJ7b+vQgdPjVTId
 4BnkO3b6hDlUcaIvzkIqK/+KKD+Gqq3DV1RQNTyvTNI/Xy4zCn8mpPcoME9TJX9EaStZ
 xe6PvpYnZQooUkj+9ALFxLzFMR+Ldg8xeCSXySpQQMiMftqhkpXLIMRbN9bEhZuJ6hI5
 ZjqzrXwgJbc6aRTh5MnLA0cs8REqZ8Oz9KVE33nS1J+A1XRTX+v66KKRBjPABMk4Br/k
 /LKt4XrnZKvj+CGyeJl2ykZBabPabQ+OvN/AtZDOMMCQW/4n0jMo7Kzms6qbSMaOTc+7
 bj/Q==
X-Gm-Message-State: AOJu0YwuWSC0OL5jmyZIINKsfLp9M6whVecc9eyod9y6LX3V8j43U8F+
 5czS8SE3n7LzuWtomSasLDZD+hngaqyt2CCmiem1pmVDg6GoLLl+UWcPHqL61oNVXiNntp41/Ir
 bVKB9YaqIQE2gGNwQ+e9lg/crIGUrK8pyBjpvpGnQUOuXMOag5CjLbnCB5BeO+1TOBYdpn0qY5T
 0QGazTfQgML9B1czLJNlXlIY9Jx4aeRJiY3Q==
X-Gm-Gg: AZuq6aItlZPD/9FgdQHQThNPa6Tj27zXu1rI1X0n6V9nC853T81137iKB1RM10uiuH5
 t1Bd7UYwHUUtrH++VVLwqd6PxFZLpZoSD4QCI07x24gj6bLJNyJK+TzBvWt9KqwizChnhsEkcmx
 m9tHUflDnN5Gpp5ZQ6RgVhDtOfecRHFIAoRfBl+0A9bnAlc0hSsvAQbGrx7JrsphxitF+vFGyf6
 UXEu9P+6QzQFu/iEwP2qiFi1aOVVgOL8/6k9iTQlV/0ifg53kk8Mn3/Af9ZVUsdfE+L0gNlZ2kr
 92dT5RSw6FzVqvZI+GUWXG4jk2tyaWgX57vP58QyFatBGfm6n7SaH2mnK9mBnfsbhz6VJvCKzrU
 OXZW7MeSraVLznshH87QlYPht2ChtE5AHpuaLgETBzz4U6A==
X-Received: by 2002:a05:600c:3b18:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-483a95e6b80mr82756985e9.26.1771770561057; 
 Sun, 22 Feb 2026 06:29:21 -0800 (PST)
X-Received: by 2002:a05:600c:3b18:b0:483:64b4:79da with SMTP id
 5b1f17b1804b1-483a95e6b80mr82756595e9.26.1771770560413; 
 Sun, 22 Feb 2026 06:29:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42effe3sm90117165e9.8.2026.02.22.06.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:19 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 26/33] hw/cxl: Get Physical Port State - update for PCIe flit
 mode
Message-ID: <be7ce15d350bad8ca636921448807b562bfa47c0.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Recent support for 256B flits, was not accounted for in this FMAPI command
that should be retrieving the current status of Physical Switch Ports.

Note x-flit-mode control is via the downstream devices, so for USPs the
property must be checked to establish support, but for DSPs this mode is
always supported (control is with the next port downstream, typically the
end point.  All cases the linksta2 register may be queried to obtain
current status.  Note the PCI spec is a little confusing as it refers to
this bit only being non 0 if Device Readiness Status (DRS) is in particular
states (basically link trained) but Flit mode is a separate feature and DRS
may not be present. It is not yet emulated in QEMU. So assume that we
should reflect what states DRS would be reporting if it were actually
present.

One small thing to note is that the current link width for a port with
nothing connected reports the same as the capability. This is odd but valid
because the value under these circumstances is undefined (PCIe r6.2 table
7-26 Link Status Register - field Current Link Speed.)

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204173223.44122-3-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1c8cbe0f68..b6ac987ee0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -627,9 +627,26 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->config_state = CXL_PORT_CONFIG_STATE_DSP;
             if (ds_dev) {
                 if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
+                    uint16_t lnksta2;
+
+                    if (!port_dev->exp.exp_cap) {
+                        return CXL_MBOX_INTERNAL_ERROR;
+                    }
+
+                    lnksta2 = port_dev->config_read(port_dev,
+                                  port_dev->exp.exp_cap + PCI_EXP_LNKSTA2,
+                                  sizeof(lnksta2));
+
                     /* Assume MLD for now */
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_3_MLD;
+                    if (lnksta2 & PCI_EXP_LNKSTA2_FLIT) {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_256B;
+                    } else {
+                        port->connected_device_mode =
+                            CXL_PORT_CONNECTED_DEV_MODE_68B_VH;
+                    }
                 } else {
                     port->connected_device_type =
                         CXL_PORT_CONNECTED_DEV_TYPE_PCIE;
@@ -642,12 +659,17 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
                 port->connected_device_mode =
                     CXL_PORT_CONNECTED_DEV_MODE_NOT_CXL_OR_DISCONN;
             }
+            /* DSP currently always support modes implemented in QEMU */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                CXL_PORT_SUPPORTS_256B;
             port->supported_ld_count = 3;
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
             port->config_state = CXL_PORT_CONFIG_STATE_USP;
             port->connected_device_type = 0; /* Reserved for USP */
             port->connected_device_mode = 0; /* Reserved for USP */
+            port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
+                (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -676,8 +698,6 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         /* TODO: Track down if we can get the rest of the info */
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
-        port->link_state = 0;
-        port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
-- 
MST


