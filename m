Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05AECA5FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 01:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDu2i-0003eB-A1; Mon, 05 Oct 2026 21:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2e-0003da-04
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:28 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu2a-0008CY-Qg
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX4aVkXcoJSH462ngJoRXQ/yC2pE+lyhnmM9WxvygoHK0n1RbUoQsSIyVUdvWTmvRjt59MgCpjUYfIZCLHHx1wifmvXQ4KIZZ0v19dWVrNZopvhLqqb6MyygzbZ6frE23xSU6NngZ3700IohUrQ/ufrOXlOIo5EHgoTz+Gaxt26XnGmd2NeETacKAGV6zYAzDb2V8aL5zL2jvM98TrlinoNkUOS+q96M60RZq6Cx0t+NXRQKvuulIS7Bg+8+xD0S/YLZg8vJS9uZ+pGW22F2itKw+AzctaSapMb2S36wpErOZmJB/ITXTVxnxYA+82b4iVJcpRTf9MtzZXEIJP69nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG/HyVNs0G6I/1reDOQXAHgfAzEdmErQTj9QzyokSCg=;
 b=T1jjhFi/aVj3vZyGM91b1IFr+buVEM9uxQ+/pf5fzzN+ABsgp22SBpfbEGlsOda8yX6w4WjKTnxfKPodXyeP3rfXgA3yDtQfuGMmuZvEHdXfDd4YrAvC/91tQcRiVmXUqebelSDDRbpmKFseuexOwX+33vjoz9TQh43UDZJ3aPyUdMmbb90zpgAfbGqz+/eO4VdzaQKDKhqH/pSav7JhUPYn9W5mUOU57beb4q1Jaui1f8ni3DYkwxGVPxMc5cVvKqRILzb7qnWdvd6u1Zd/peCvPXiD0EkJHK57zlobOgKGf7Yvut43ROkyIhegiLgKHiYq4Y/3B7uC6mqQbW+1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG/HyVNs0G6I/1reDOQXAHgfAzEdmErQTj9QzyokSCg=;
 b=B4qc7bM+p1Ie8q6E1T6UcPWTKi3M+gS8fNwglU4ViPpJtSdspCECYxy2dr6ARlg9j08rqq9xbzBkuCqUNn/7gyBGjY2s92fuyqlM96l82cKYGxDSsobEvt7wD7RyH/LB5r68NjY8KLMbUMtMUkqIQ53ZGdFLd45G7RJGfbkU86oXPtyMrs+KoOmtpl7nyIAXGySPTPfsp0XkfTSpadOf/ttO9mEy9qgMpgdm+ujDX2ndnTEeC9V+Wwt0R6XMeF2meYbZPsrd6jHejrJe1/W7Tj4JBo4Amh+ru6XwAsQm/RsXM5tBQc3gX8KDJJbT3M5f2ZQu3+7X+iKYk4PCe4cBGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY0PR12MB154213.namprd12.prod.outlook.com
 (2603:10b6:930:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:31:45 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:31:45 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH v2 2/3] hw/pci: Expose ACS ctrl on Guest as configured by the
 hypervisor
Date: Mon,  5 Oct 2026 20:31:32 -0500
Message-Id: <20261006013133.3457555-3-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006013133.3457555-1-tdave@nvidia.com>
References: <20261006013133.3457555-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY0PR12MB154213:EE_
X-MS-Office365-Filtering-Correlation-Id: dc134a65-67f7-4291-7d4c-08df23499561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: O4z5qTDRtUep0T9g/G6Vt8PTs2Urv++yibepNY7YzQH2zzjvc4rVqnxyMRIckiI/X7D00rIv9MrVpzagKa/Au5VXITJMMhUEmccwZEpqih89fr+vA2+6IlctomJjwdFdN9rZqQbLiJtmBRBOlC75Wsm8G9p4+ra51iRJ3Tms63ZhESMRj1UglNm3yqCW/tfWoyOX1N3RCmZNHEflIbjw4t8Ct70qQUJbfzBNdbMR/dm7lVCs+Auh77V99oDA95+W0nJOAHge5RZWRea8NtfGKzveHIp+oKvBKT74ohsk7iHswGaklQuAz2z+16OYpdGS07CfHl0Qe7u9Cuf54rjgBfl5cL8dnPVeGMPk9jIAzSC0qHqP7Mh4d6YB6LPhHRjpjEANM0YrPKWyaKLLEXNgRJd3Kv8iYAsVgQffBsgm76Z8+nWWsaTSSnhiQdmwOYEBbwrCTQkT58TYkU4O0YaAJ0PPMdn5R2+YxMtAFNChiakzG1E7QrHCzTMcodtMKMNW5KWpO17nPb6tiSmF2HQmbZ6oRbqaL28LpPP7Ggy1JQQfmD7SyfNu7ELkhG/bzDXFNr5PncX6dBGsADe7nUWhLn5y/KYdsChDWEu3NBZVqNqDtBx5InZLJD6c+CqJrLs4Gq0uwdIWOHWIq73FazTrSKfR+unGCAZYyB3ucy3lK40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0vliz89zXNIMIdY/O5bG+V9esaLt1McwRAefa1T4R/MvqEMf230Pi4Hibfs?=
 =?us-ascii?Q?a5HtXh1s7GDl+DWEOsdcRKn5wiPM0NRMMGvRS9yAHD0lrpirnZh8yhDX6vNC?=
 =?us-ascii?Q?VxbefiCXNPkqgIPOkoDYVP9Aj1QH0fewWyLVGV6ZsDvqJgN7nDttFJmwYqF3?=
 =?us-ascii?Q?U5O4ZK3laOh1ekRKQChbLxcWNDrcOvnB5gGQ54rbILZ/JrSwRMBOStiUhsC6?=
 =?us-ascii?Q?V163oFzDI2koGkZDYy0LKCZLi2v4yN5G4oeuwdN3hVjbuM0M7lxSKEtJpKAb?=
 =?us-ascii?Q?WhwhRPLVzBhg88AekAtmc/dvz/kIaJPbotjcHSHABETBoPAuvCw7ybZW9FV3?=
 =?us-ascii?Q?rnfcKQxjYCKk7UJo41XdXmmQ2LZdGu2Mkpkks4KkBCzz4Z6WHR0dULZHZNtD?=
 =?us-ascii?Q?SSKO9DmJwItVGM1FgSRSRJ5gGRr6YLrjizoeGf93WezMzl4MfCtdLQsRYuBV?=
 =?us-ascii?Q?T12GeT1GhiCjgrhhiSBqYWmYOV9miZCc+h/dqSc3rb60Jx9dJOt67GwCMvO4?=
 =?us-ascii?Q?JSKL5Z02LMlyCOmnLovA5j3qP+TDmitvSZfQOtPePQh5hGpqQFjYXsPbba4+?=
 =?us-ascii?Q?herftHQUJ3osLRjxeu7vIZT6IbC/Its3sTTfwkabB2hKl99DLwBI2bauWQI1?=
 =?us-ascii?Q?zXljPigLLkFS22BkpadBZRdACHEn/zAKGsvI7ahdOr84T2P/Sxu5Lmm2ZLLC?=
 =?us-ascii?Q?E20yddbCCaoH1PaIuC8TYFYMkaHhZWcCQFU0skf1iOwzTcnIIYdBll+JeZqx?=
 =?us-ascii?Q?MncodXpPu1jNH1UObKIBqAALLMmvx0O9kfl8cdbmL7jrw2KyfSQEZ+QEtrmU?=
 =?us-ascii?Q?pZ/nEBwdJW5/oqMn8W7suu1RKUorfkXfnE3kgLW16QpJSIzM36LQI4QbbMUd?=
 =?us-ascii?Q?GAYLmVW1sGk470rj2rbcjNWZRr9yMli3iGPumfWBIm35DasQkKn5hmx6rEtV?=
 =?us-ascii?Q?tD5GXfEVB7nSn7L46+kEJ+ZyiLcmqZbH6HOJtCyKBbupzWLmWeo1fYCCSHrj?=
 =?us-ascii?Q?kz1A5GFDYlJLajA0UHoBdaiM5d4YblsBC6n3fIcSHYhMHDAJPb1L+E3ZmmgX?=
 =?us-ascii?Q?+y5p0SRqsl33UIzeTpNMhiaq2Zkw8mLqpQof7Epe9C7l0syrlXRLnp0Pla0h?=
 =?us-ascii?Q?+2Odee6j5NMIW0fWSUorySulwqli6ZOYX+VVxJjVHrfQxn+11wCmnRx7L5fJ?=
 =?us-ascii?Q?lGaugD5Zv+RXCQNOTsPAIQOH8373+YcPD9liEWYlzA/XspVU9el3mLUCVtq9?=
 =?us-ascii?Q?/Gf9GyjeUJr641zZ/zvAgOi3JLGQWKRPjnQ9mLmlN1spjIHmGAJ5pumFXoSU?=
 =?us-ascii?Q?HmHKRrTUTsmmTdHa2G7GLvSw/ewH9BVBFBAj0SI06V5xf5/glCTHtmN8ubj+?=
 =?us-ascii?Q?w4WAGE1Pq58lAvFLd1r0IqpmG+7WwQEm58lnkzdTJBKmF1rAoQOQmMPCdUlI?=
 =?us-ascii?Q?RQtsc6gKwcqXlJZ5H3URzjoM2t0oM2hmjqHjchfIDAmwJ/PCJ5QewAllIN3F?=
 =?us-ascii?Q?sXqMQfEFHAggLojKSfpd4Z7zxjdnnJ50QvsKw2fp97N9wXRyrvTtQIqB0i7Y?=
 =?us-ascii?Q?AbQWI0xlBiUYLv2xqKrgLD+KE+rkBOdteOEguw5NdJPecQyo19rP8WbhDjg5?=
 =?us-ascii?Q?QnfpC1uc5dme/CfvHBY9UMg50ygY6C8uTHzeaXIOfegBSoGHSjX/DOLsC5gm?=
 =?us-ascii?Q?iQAspHk8sJungBi3vEHgXCi8ye0IOofby3Anl83g4bo9BzCh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc134a65-67f7-4291-7d4c-08df23499561
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 01:31:45.6317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4HkY+Ay4uTr5PXck4rsHRaRRQQy6MzJJFI0Eu3sMOnNU8Xlb9QBDKvNfailq2dKMOxfkWDLoAz2Rc+5srp+rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB154213
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=tdave@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Yishai Hadas <yishaih@nvidia.com>

To support P2P on Guest we must expose to the guest OS the actual
PCIe topology and configuration as set by the hypervisor. The ACS
control must be set accordingly to have functional P2P. A mismatch
between the hypervisor's ACS configuration and the guest-visible ACS
Control register can prevent P2P between devices from working as
expected.

Extend both root port and downstream port to accept ACS Control bits
that match the hypervisor configuration and expose them to the guest.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Co-developed-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci-bridge/pcie_root_port.c     | 13 +++++++++++--
 hw/pci-bridge/xio3130_downstream.c | 13 +++++++++++--
 hw/pci/pcie.c                      | 17 ++++++++++++++---
 include/hw/pci/pcie.h              |  5 +++--
 include/hw/pci/pcie_port.h         |  1 +
 5 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 7c3e78010b..e7cce8c0ee 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -46,6 +46,7 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
 static void rp_reset_hold(Object *obj, ResetType type)
 {
     PCIDevice *d = PCI_DEVICE(obj);
+    PCIEPort *p = PCIE_PORT(d);
     DeviceState *qdev = DEVICE(obj);
 
     rp_aer_vector_update(d);
@@ -53,7 +54,7 @@ static void rp_reset_hold(Object *obj, ResetType type)
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pcie_acs_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pcie_aer_root_reset(d);
     pci_bridge_reset(qdev);
     pci_bridge_disable_base_limit(d);
@@ -118,11 +119,18 @@ static void rp_realize(PCIDevice *d, Error **errp)
     rp_aer_vector_update(d);
 
     if (rpc->acs_offset) {
-        pcie_acs_init(d, rpc->acs_offset);
+        rc = pcie_acs_init(d, rpc->acs_offset, p->acs_ctrl, errp);
+        if (rc < 0) {
+            goto err;
+        }
+    } else if (p->acs_ctrl) {
+        error_setg(errp, "acs-ctrl is not supported by this root port");
+        goto err;
     }
     return;
 
 err:
+    pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
 err_pcie_cap:
     pcie_cap_exit(d);
@@ -151,6 +159,7 @@ static void rp_exit(PCIDevice *d)
 static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 6a9df5c174..e243dfdf7d 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -58,11 +58,12 @@ static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
 static void xio3130_downstream_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
+    PCIEPort *p = PCIE_PORT(d);
 
     pcie_cap_deverr_reset(d);
     pcie_cap_slot_reset(d);
     pcie_cap_arifwd_reset(d);
-    pcie_acs_reset(d);
+    pcie_acs_reset(d, p->acs_ctrl);
     pci_bridge_reset(qdev);
 }
 
@@ -115,12 +116,19 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     }
 
     if (d->cap_present & QEMU_PCIE_CAP_ACS) {
-        pcie_acs_init(d, XIO3130_ACS_OFFSET);
+        rc = pcie_acs_init(d, XIO3130_ACS_OFFSET, p->acs_ctrl, errp);
+        if (rc < 0) {
+            goto err;
+        }
+    } else if (p->acs_ctrl) {
+        error_setg(errp, "acs-ctrl requires x-pcie-acs to be on");
+        goto err;
     }
 
     return;
 
 err:
+    pcie_aer_exit(d);
     pcie_chassis_del_slot(s);
 err_pcie_cap:
     pcie_cap_exit(d);
@@ -146,6 +154,7 @@ static const Property xio3130_downstream_props[] = {
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-acs", PCIDevice, cap_present,
                     QEMU_PCIE_ACS_BITNR, true),
+    DEFINE_PROP_UINT16("acs-ctrl", PCIEPort, acs_ctrl, 0),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 42bcb9206d..af24ec7fd9 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1260,7 +1260,8 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned)
 }
 
 /* ACS (Access Control Services) */
-void pcie_acs_init(PCIDevice *dev, uint16_t offset)
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp)
 {
     bool is_downstream = pci_is_express_downstream_port(dev);
     uint16_t cap_bits = 0;
@@ -1284,16 +1285,26 @@ void pcie_acs_init(PCIDevice *dev, uint16_t offset)
          */
         cap_bits = PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
             PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT;
+
+        if (ctrl_bits & ~cap_bits) {
+            error_setg(errp,
+                       "acs-ctrl 0x%hx has bits not supported by this port "
+                       "(supported: 0x%hx)", ctrl_bits, cap_bits);
+            return -EINVAL;
+        }
     }
 
     pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
     pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
+    pci_set_word(dev->config + offset + PCI_ACS_CTRL, ctrl_bits);
+
+    return 0;
 }
 
-void pcie_acs_reset(PCIDevice *dev)
+void pcie_acs_reset(PCIDevice *dev, uint16_t val)
 {
     if (dev->exp.acs_cap) {
-        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
+        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, val);
     }
 }
 
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de..678ad73f7f 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -137,8 +137,9 @@ bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
                             uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
-void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-void pcie_acs_reset(PCIDevice *dev);
+int pcie_acs_init(PCIDevice *dev, uint16_t offset, uint16_t ctrl_bits,
+                  Error **errp);
+void pcie_acs_reset(PCIDevice *dev, uint16_t val);
 
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index b28af067a6..2ad9a563d9 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -36,6 +36,7 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+    uint16_t    acs_ctrl;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1


