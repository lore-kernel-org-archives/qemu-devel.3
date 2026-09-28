Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB27CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHbO-0008O6-H8; Mon, 28 Sep 2026 16:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1xBHbH-0008Mt-Pg
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:05:27 -0400
Received: from mail-eastusazon11021118.outbound.protection.outlook.com
 ([52.101.52.118] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1xBHbG-0007iR-1A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:05:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Da4QsykygTCOLu6AVvmPmNJP9Q0kUbQ10EDI+33c3ejKcL1OXNnRtvY4WLyk2Jsmn+PGe3czPQ2PHbT+SkvwTi3BCnuvxgFUSWeuHhRWJSGttMnal5a4Zzup6lSYaY4yM79RhjCpONppXdIiQw0YJhG8covx84wy9bsVV9HQnY0opO0QNatY66p/zKW8eyd5f07OEaXBs8koBjk7QGtXKDYdCO1YNpqYg8Nuko9IzU+a+FYJqHC9AwL7/wQv+bKlCJFCP6Xl2QwZcovQ5tZzfIucV4lXIoTLw2td4M3ZGQlKXgDUVtbImbtJX5WAbEleKS+nMqGSXOGPQTOz77wVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKscV1pzcAdpzr5EyL1FJ5xOSEXdPXqKB0HU/lf16Ks=;
 b=RUafFfcxpYuGebtH9Tb03HsvpWFlHm0HOOrp1DKVyxTNXDQqZi4nlUkgZothDcYuBhcz3UjbY6Ka0ePlPyV/6YweXSoGrafUFH5f+KvAIWIkRi52lRvLb/DWNw6uLeIfrsOQ4SpaahgG/m24pnPQwd39/f56bNaxANVUzi+1a9MwKXjyUUKraRORdZ/7OLo3ISrxXek4LZU1eSSHO7BH8PPruDj7ifhEmf5dBVdqItDtXrYQMkjxccQGgL7w+cZHoyG36/vFyQUpP2g4FUee0X2ttPB9NhMgOwqmhEIpyoZXm+R9SoMKBVbxJCKYXJomZAo1PrvIu53ITBXMI/HGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKscV1pzcAdpzr5EyL1FJ5xOSEXdPXqKB0HU/lf16Ks=;
 b=dB8kXNbqoJOYmtkC1UYROMzpgZ+Hn2RfXFufiI9XifpH90B6VjEUvZ5vkV1ReFpYbJtfw0yE+mZKRfiGJx1VlND5TkcOSevWBCa+lTD7UqA4EFydmK84R0VFd+M6EKLX4F4ZeLsYbMffSjNevvI7FSlYRdObCfCqhTOLxEu8HCU=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV0PR21MB6832.namprd21.prod.outlook.com (2603:10b6:408:32f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.7; Mon, 28 Sep
 2026 20:00:16 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%5]) with mapi id 15.21.0496.006; Mon, 28 Sep 2026
 20:00:11 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH] target/i386/whpx: fix VMX capability MSR values
Thread-Topic: [PATCH] target/i386/whpx: fix VMX capability MSR values
Thread-Index: Ad1Pg9DvQy3twICnQ9WEDhtMZr13fQ==
Date: Mon, 28 Sep 2026 20:00:10 +0000
Message-ID: <LVXPR21MB7009E7B7DB875353A715A0A6AD8D2@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=30128016-6f7a-4408-ab83-26123841c1f1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-28T19:59:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV0PR21MB6832:EE_
x-ms-office365-filtering-correlation-id: cc008b3c-0495-4865-8302-08df1d9b1a67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|7146999003|10067099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info: DwZnqi1gYWz7geIoFsO1B5B91OcRkDE12hkWoQtiRHWje8FP9eropsgYbDx3H7x+LJyVlkJHK8ivfIfmHFRQh2CRFNbUYf1dpW7BQSH5wDtX2ZymZ/7gt4WX5ztz8dmgu+FoG+6AvlxRwfxMV+cNxyE06LYaAw/QM7RvxGS3Cu8Qz/Gxc7iNjX3snCNOUeHKtS7kRRD4O/JxXxAbJk1OV1m//CGTH5JOM0U4ZiZRFoKP5l1t5o0IBQLbvpX26iF9rwKb37ePW6vk9csoqarj4u4rLJqOxXUZm89C2a5CS9fl43AeuvfUZ5aAup6mV4FuAht1iQ344bNg+U/gwIIdV13/ytQmyhpMOE1cdo6eX+Ha8QjwmjNAqUjkR11P5xJ6hGqqHwMOqn3wZOCorZizL38AqrhRQBlbAcn/G+ZMNiQPP0aphVE56PVQV3QH3zaUNmC9cI+E0LpiL6uDyLhvu2je8FEgiJHxnJFm6Uc6JSWrwJm97ki40eCul5UbOkJWtuNK5mIVdPxQfWWAHmuONrv9IuAFAyw3icffhQ6GBeNEtrpcv2NZgFJZzcbJRvC5ZGGh1Bc7D7tLsSiiakD+pJZUh6xiV4LUgcEZSe3Wou+2Orepo0MnakyUaFby/6MhO24TjqcXuB1CHvjpLnNIIROGWnXsnH3S1XGZlLR89IdK7pbn06DVfWhtEXXvJgODpkJcvS7t5ehcHx21m5VUHq60FR3cNauIdGAaGtZZgLg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(7146999003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwrEBOYml32wNuS2B3l6RZ8B50Ph7/iEpKcVAmqrz2elxgVF+CIuHZfmxyQo?=
 =?us-ascii?Q?qOzjmEoOO5k8K5sVNd0efLkx+8hRxpj3Kjcwyd0TTiXQmzkqs68eTfcj+cOp?=
 =?us-ascii?Q?xitV8bWJfR2vdtgn81uLpWpuUPkfv4yEVpJfiPIocL9ZR1EajOsUs92qWsV6?=
 =?us-ascii?Q?R4ZRDx+hIFLhsvSa81Zis9KZ2bNpa9Hr0LFnn3SccFl04W1mO8bOzMi88RjS?=
 =?us-ascii?Q?5cDhS1nIsIUcUxh9efQbrnnALmF0aUdhoknhzu7QiNhXCb2XLVAy60XBgSYA?=
 =?us-ascii?Q?KPdoKkTHgjLvAg9s8vv5fmXAkZfW/AdvNu+BsLOs1fOCNM3Rm801y/vN6JVB?=
 =?us-ascii?Q?htO2+Pv21xSOeDSqZrEGU97dlQc0mAmDHADBe8FsFE5vxzcaDCXeO8B4BEGd?=
 =?us-ascii?Q?5wbjXA6QEDWBiQdbRbUvj/Gv3W/9ivrvYyBpS8kcPLLJakn5Ia+7Oc4TfCGK?=
 =?us-ascii?Q?3cP/UDVr5BXaaiaeuXCnoGbOWZ3yItqxK7cO7t7Neqrq69Pk0zSohxVl9ALb?=
 =?us-ascii?Q?gP3pB6CNBCs9kY7TWCJ320doNHDq7kJFniAQeAwc7MbBV85KK1DAsBnpEGfU?=
 =?us-ascii?Q?UD/I3EmnrFGy8lvwAyKFctvefvZ3woL3BA951TOEd6p3m1TTTonmoER8SP2O?=
 =?us-ascii?Q?B7b7DlvW7PkfLkq7wxzT5xy1SXym7U1+Sq2nHJz3y3ro5T3rWz86pnqAP/Hq?=
 =?us-ascii?Q?FKkmzayYaEnaJfx4XML9i2RJQCTglc07gaklWuMKmqfjB8w+kH+sX2CwtOyl?=
 =?us-ascii?Q?NsEheKYLRUAVeZa1tIYW7j7g/1fuuiIjChfE3j4WRMdeJDaQ+dNXH10lrtdT?=
 =?us-ascii?Q?1WvjGXZEeWZvvKy47UJAEMdbSZGJChPZin/vRsPIAdUBh5R79UauEVth/yOp?=
 =?us-ascii?Q?atDfFM6kFl+68GPfgIs/o2fsUTHxpkN6ddnwUt7nfNqg/P/me+dbYrN/RDdM?=
 =?us-ascii?Q?HOb5RRFmqQ9EvKVQcpzdAaDwC/iJI83dJur7EsScJQe3lpWU02C9cKmwxcGC?=
 =?us-ascii?Q?+HYJ7U+Ge+NZDZAoFDvnH5OfZLuxkAgupbo1Rg/74wXZq2jkBVeSAjC5XTJW?=
 =?us-ascii?Q?w2pUbRizlbHOB5GRIR77KwlK5tYdv+lk2IPLj2zfGV8neq+8sZAgmG9tKJUT?=
 =?us-ascii?Q?k3T9hoXHvtYW3yDX4DSwOw+WRLI8LjUYSXI/cR8cwC2/3EfgQik0ZMK4tZZG?=
 =?us-ascii?Q?u0tNYnHZqaOYvLOybp4LKz5yeu7bPpnapy6dBRknNk+bu2GQgLOVzkZtE2dM?=
 =?us-ascii?Q?w4LNryUIgVV1gJsPX+ADQU14hTQzOK3eb1w6txZT6PkblP/twMivF96UACHR?=
 =?us-ascii?Q?aTbpxgHrDdfUapy8s6sfXDuitTMmRgfZt++td9wDb3SRtFRqMn71pmkakfMN?=
 =?us-ascii?Q?KShW8W/YcIefu0u7VxIAWE/6FmFEsFdbCJIFiz5xJmqRHzbDZOfNEpZ6YX3R?=
 =?us-ascii?Q?pX5Zgwp2QmlPO76DRFeldr6d8sfGaVZi1Acpc7Qau0FTEBAfwjfjm3HQQgpA?=
 =?us-ascii?Q?IXI/aHBaGA+SdKJqMVa9Po3I1/gr5nyhw0YdyjC3Rx3I3d80d2ePZ3xAWeGL?=
 =?us-ascii?Q?HtY9f70CWbPGxqMaptNNFgvqQHblhr01GEgCREu41ESmdB2DzOUqSJPq91vN?=
 =?us-ascii?Q?JEzmkpCjoVg3SGIFOc4LSoIqBWGIoGsxCf33tqeLcLMuwIT+P19K4jkrU2/Z?=
 =?us-ascii?Q?Rj/6C2MKNVgcUXfvvbkm8bd1t4GguB3JAtlbynl8ySTWBKhU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc008b3c-0495-4865-8302-08df1d9b1a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 20:00:10.9750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcQJYmVbQHl2Qp0X3YePFpm2hpUyYHppagJs5Yo2/eK/O0cog+zTk8v32XehVnJhEgAeUtucf9jWNG8ZPh0Qgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB6832
Received-SPF: pass client-ip=52.101.52.118; envelope-from=dcook@microsoft.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Doug Cook <dcook@microsoft.com>

whpx_get_supported_msr_feature() had two bugs in how it reports the
VMX control MSRs:

- MSR_IA32_VMX_TRUE_PINBASED_CTLS and MSR_IA32_VMX_TRUE_PROCBASED_CTLS
  were queried using the non-TRUE capability codes
  (WHvCapabilityCodeVmxPinbasedCtls and WHvCapabilityCodeVmxProcbasedCtls).

- For PROCBASED_CTLS2 and the four TRUE_* control MSRs, the raw
  allowed-0/allowed-1 pair was returned. The feature-word code expects
  only the bits that may be 1 but are not required to be 1. Apply the
  same transformation as kvm_arch_get_supported_msr_feature();
  make_vmx_msr_value() adds the must-be-one bits back afterwards.

As a result, with +vmx QEMU treated many VMX features the host does
support (secondary controls, EPT, VPID, MSR bitmaps, ...) as missing,
warned about each of them, and dropped them from the CPU model. The
guest itself reads the VMX MSRs from the hypervisor, not from QEMU,
so this did not change what the guest saw.

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bc6c1e00a2..8fd6b3ce2b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1516,10 +1516,10 @@ uint64_t whpx_get_supported_msr_feature(uint32_t in=
dex)
         cap =3D WHvCapabilityCodeVmxEptVpidCap;
         break;
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
-        cap =3D WHvCapabilityCodeVmxPinbasedCtls;
+        cap =3D WHvCapabilityCodeVmxTruePinbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
-        cap =3D WHvCapabilityCodeVmxProcbasedCtls;
+        cap =3D WHvCapabilityCodeVmxTrueProcbasedCtls;
         break;
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
         cap =3D WHvCapabilityCodeVmxTrueEntryCtls;
@@ -1538,6 +1538,31 @@ uint64_t whpx_get_supported_msr_feature(uint32_t ind=
ex)
         if (FAILED(hr)) {
             return 0;
         }
+
+        switch (index) {
+        case MSR_IA32_VMX_PROCBASED_CTLS2:
+        case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
+        case MSR_IA32_VMX_TRUE_EXIT_CTLS: {
+            /*
+             * These MSRs hold the allowed-0 settings in the low half and =
the
+             * allowed-1 settings in the high half.  QEMU's feature words =
want
+             * only the bits that can be one but do not have to be one, so
+             * apply the same transformation as
+             * kvm_arch_get_supported_msr_feature(); make_vmx_msr_value()
+             * restores the must-be-one bits later.
+             */
+            uint32_t must_be_one =3D (uint32_t)val;
+            uint32_t can_be_one =3D (uint32_t)(val >> 32);
+
+            val =3D can_be_one & ~must_be_one;
+            break;
+        }
+        default:
+            break;
+        }
+
         return val;
     }
     return 0;
--=20
2.55.0.vfs.0.8

