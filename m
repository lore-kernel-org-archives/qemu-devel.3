Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD8C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwr5N-00080V-ST; Wed, 19 Aug 2026 20:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwr5L-0007zk-4h
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:56:47 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwr5J-0008Jb-CV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcAC0sfjzHz3VtnrP35xVoTsx8UHnWZdVk+wWlypVaN2HcMz4zwh+mCVr/9qdYRr+3Qg4K3oOUWSUYhF8Bu843pnRkjeuS9oOoT0aTrNsBCCm4xedjkTPfmsIYuzDBZGDWrde7hfWibdIHpz3ZlCeKn1y7M5PFPhQ4+xwnuAGQHWkrnkYW8L5MT9PlchpNSjPJavjJSzG6ujfMdx9UXeMZZ/uj8Bl/Yc4StGe+6zM4h2XbrXtSVVLrarAUHvtIkStvXW0Z+DtqdkRTRtdo86yc+x+q0F8YfmjvTD5YGkMF83iydpVeOBFwLCO7AMCt+DzU9NXwz6Ff7bB2Q10ROhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSejDC+G/FijuUhrhbH72e3pxJbH/J+kgiPc0nGFP6Q=;
 b=Wpt3X+AfLBOas9PvgwuPU5tQTLji5mahnNEuJGR5vvFSDmLUJ9o1BHRtS+Ofdzvtdll9XvzGN0Lu+ZWzx/D2U3GBf7WK/f9vxGGIP4Z/sRuEtZ/Iow07oZEju9Q4b1/Hcy1UkI1URKbb8iCcp5cGS83fxQ73ZEgbOEHY553y7N+PPSs19aLeomkL401vgs+Xxf8mb6Gp2Ufq6AbufaPaay+jMfRpvvNL9efWQ78POihoVePkxAkN2kkyxZUf0VpSBXu+GYSXm1n86z24zd/sIZqG/9kNumIFoz119UhZSDruxJ0bVcGRsQJ02X6La1H5jTU1nbG0sfLe4lxjipcUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSejDC+G/FijuUhrhbH72e3pxJbH/J+kgiPc0nGFP6Q=;
 b=CLIs8zqDcy5BbOCnGAr4kmed7k3Gk+9bAdRBUnvRyw9fQr5oxGKwvdxhgkMlMRZ89iCRg1j+oGAQRXJw44FBh+PlcZ8Tss+9W37mebKiHUw5qL8+0y83CLz/VmrdSfqBTwg9w/aYbZBeXQG25qchTVkZGFfkvxhziwf1RXezN1w=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV2PR21MB6647.namprd21.prod.outlook.com (2603:10b6:408:34e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.1; Thu, 20 Aug
 2026 00:56:42 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:56:41 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH] target/i386/whpx: whpx_get_xsave_state error handling
Thread-Topic: [PATCH] target/i386/whpx: whpx_get_xsave_state error handling
Thread-Index: Ad0wPrCEeThZXHc5RguJWiiCua38jQ==
Date: Thu, 20 Aug 2026 00:56:41 +0000
Message-ID: <LVXPR21MB70090CD62E78CC3BA2EB7E52ADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=423ac2f2-cd90-4c08-bcc8-783ecd2251ca;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:56:09Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV2PR21MB6647:EE_
x-ms-office365-filtering-correlation-id: 971f5527-9cda-4a21-2a3e-08defe55e60d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|38070700021|10067099003|18002099003|7146999003|11063799006|56012099006;
x-microsoft-antispam-message-info: xsfk/qFb60yTx479RjAanslj3qYKTRDAFeDvKXw8Jrp5grphzAxGYSlrE8rEBMnvLhKR/m8pnaIdsAq9yXBu6hu/EKaUgVKo2gQr/aaFYjtf0xYTQJziPIzIEq1qGRPGvlu+JK0I/A5Y9ZcWOYZhnt9lePqu+n4rKeQEKUIZ3RMUH2U8j6ewHDdUeU/+VlKXoi3pXBGzf7cO1QBdjjLt4pmLyBMeRUwnDgMQ1wPvO1a5KJA740D6ZGJyTx5VMt076wAT75GhVAbRTIkyh0AMfbr0W+CZFrpq0Satc30gzaDWHm1FBY332MFULyK4oHFsd/AXxfMP6NYh+eDYHs6+EMpmTEZRR8sa/fDZPZ8lwvg32Qb065stnTBO+NvXg1NMk0sP5Vts3omBHzNzOcj4L43B/CpehBjBTfIQEXKjbVtrDThNaeZ0BvxTVBcrsHwLVS9iymxE2qXd7VdsCODMZtmy8c5olSuYUa63wvcBf1nKV4NtYRelCeLLjmrzv6p9O21t9w22KNh5S4jqJPK09SJbLCJyKKM+X4FhCSRoRDNNS4X51aNA/Xx4NAHvd/dhGL/ZixMssZ2HhIZyab4QE4/vhFCiwUeFMANlM2/giMX0SRm3PeFOTTkGQoEiP3b+8bEbAu2YzfsXD+JRYUyg0IeX1ONPjTmCl49hFFu6Szsc2DW1UxBthAHTREYlXWGrqKyIxyf+8/NE/IHYqdy/2uPD1UZso8BNr5TTc9UZzpg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(38070700021)(10067099003)(18002099003)(7146999003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AU2AFQ1qtagrN8IUzmZh++roDW2j7ve0ON/xUCNx9rLMUaFeeF1DYe3eNtcc?=
 =?us-ascii?Q?EfxBFjMyL3ASj46tQY5LQIVfXwjdGd5eUZ4n4QqqA7lKk2rqXFecaUqyrAy6?=
 =?us-ascii?Q?2z7gSeR0mucDwQls6cu/MDczTowk4HwerTQeH+8Q1sHnBKOlbz4Qkwr0M2ES?=
 =?us-ascii?Q?eKEZHw/t3NRspPJjcp+KM+8Xjl57Zxvn42MmeTBmAsl6Z3mLZirlCbAsjm7C?=
 =?us-ascii?Q?enzw/07xnVoTcRM1Y2l6+Nr4el8js2649Xqsk+qAVcgd2FWbPCU0J9uNFkTC?=
 =?us-ascii?Q?hG7iBknKqJWtKHfhzS7OCnHDRg8JGChBoBc62VDGqALguU53av5sFKXlsKiZ?=
 =?us-ascii?Q?iTRcEivaZwYirl6sjmVegHqcizgiWrB/6BA4Z2CHhAym5eWGhuMwvFrzzC5R?=
 =?us-ascii?Q?cOmh0mXe2uasJQVulhg0DoMnOOnQXeelmIzGOGiTl9dE2YjcLYYqQORZwlq0?=
 =?us-ascii?Q?U840EDIX8kuZXm/qL4LRKxjj/W8yVcQotY0107Gv7UOz555QBmVv73zh5xOZ?=
 =?us-ascii?Q?EHMePO99La4TtDUQWxNDG3Lr927jaQdZe57TrV5eY9lryZqorqywnLHTSxI4?=
 =?us-ascii?Q?yii3qQ9BhHqmnu3sgqihlyZ0TsGeJyEPo2f/CsyOUTUtDw45TJuyutcJ+sPu?=
 =?us-ascii?Q?d5Ey3rthF08UVzNKwEziqvJHh/Hc4YTjCpQMvxpPLDkzjIb3108HtsusPPAg?=
 =?us-ascii?Q?Z/7yyXNclQyKyp9FXvZGhMSF9ukGJ2RnEREu8eQQwVcYrJsEHTp2a2C3z9Vo?=
 =?us-ascii?Q?5XEOAyznuUQX2Rn6imQ8ZYyy1nt3LFFfVpt2qYYhuIIhIuuP2vVIsDGNUalT?=
 =?us-ascii?Q?h7emD5JztHMlVF1hrnzzW0J5j+Gf86gSZ/xENI8W75bTvkrdfXPKhGHxTb6m?=
 =?us-ascii?Q?ONPoyFBp3WGm/OdWSjsIIzdkWmsnlf3TmjO5HQV0lWNv9vopbepOLr+EuvVG?=
 =?us-ascii?Q?qjtDVALPhmUioHWXKyvDHRNNdgnT5uyfALU7MBqZXD2GeN/c8kC9qmVuA1Bj?=
 =?us-ascii?Q?ntBtLM/lE/8A3WmVnArutvaSB/5oAutpxW04UaCRFNKftqrQdB8noFNxr4uC?=
 =?us-ascii?Q?71/tm2+IIYUQzv2PfBqqnqIyWrHmM56oyelcMysBhu2G2UpdFmQJDZvu2jZ3?=
 =?us-ascii?Q?XmISG9vZKuWF/KIBF+cP9WH49ZZsBTNgT88JFMj2u2yBHRDKZqj4HFmeew9A?=
 =?us-ascii?Q?3cxT1pYTJU5sSL4UUDSz9oQ4YYgxwn61uD7ak8yvzaLNHE1Aar3d13EYbEPu?=
 =?us-ascii?Q?p6VSrwCdefL9uyAv4MrMF5WLHoC9ZPopUJVV8RmjQ3SqInVB5jbP5fdVaSjs?=
 =?us-ascii?Q?SDDS5gcLz7VwRICTXZ/urBjXj7TOGctTjVpM7n4uk3Dnsp+YIt2+JFssLn0j?=
 =?us-ascii?Q?OSUfbw7bixuTRDf+dRwr2DD78QEog6pqTEMDCqugDgjvwEq4JJLWtBZitjSC?=
 =?us-ascii?Q?pyBweCvWsK99AeXyiZQvgMCK+TOcMyuvBxkVDnipMPj9SqSUMhUvXz2uLGkb?=
 =?us-ascii?Q?AGESgH45He3I2gW4Lp6cRIL8IiDf+7i5FWBnzBeA6aeTxUb7m8pGJMdojCE1?=
 =?us-ascii?Q?rDPiL3ukWdyGjtfHWDwfF3crwh4PeQJKJGhYGPGSpJRwh5F+//vFjhb0MaYU?=
 =?us-ascii?Q?U3pi4fEBHw9PRAjsLlqv2LJ86/EwIv0rZHXRa/QaFeFGUoLYZWzKCL/2tRsf?=
 =?us-ascii?Q?8a4PKsilPtao88CZVor6mlyA5azaHjcZ9hQypVI6/0kXF/kc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971f5527-9cda-4a21-2a3e-08defe55e60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:56:41.7867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97bn1rztYkE+V6UH3IzLjteqRspPmJMOdtIs+YE0ongX6lHvwEeXj8roxovSdObilmndQ7Mf0ieUyu866EOl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB6647
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=dcook@microsoft.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Several problems with error handling in whpx_get_xsave_state:

- Does not handle WHV_E_INSUFFICIENT_BUFFER, which occurs frequently
  in practice for XSAVE state.
- Does not free xsavec_buf when an error occurs.
- Error message and return code use errno where they should use hr.

Fixes: cfaa3b6c9597 ("whpx: xsave support")

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 include/system/whpx-internal.h |  5 ++-
 target/i386/whpx/whpx-all.c    | 73 +++++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.=
h
index c295c5a529..b15f3d8faf 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -58,8 +58,9 @@ void whpx_apic_get(APICCommonState *s);
=20
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
=20
-/* This should eventually come from the Windows SDK */
-#define WHV_E_UNKNOWN_PROPERTY 0x80370302
+/* These should eventually come from the Windows SDK */
+#define WHV_E_INSUFFICIENT_BUFFER 0x80370301L
+#define WHV_E_UNKNOWN_PROPERTY 0x80370302L
=20
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* =
CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeIn=
Bytes)) \
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d542821..682c85cef1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -442,8 +442,8 @@ static int whpx_set_xsave_state(const CPUState *cpu)
=20
     qemu_vfree(xsavec_buf);
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get virtual processor context, hr=3D=
%08lx",
-                     hr);
+        error_report("WHPX: Failed to set xsave state, hr=3D%08lx", hr);
+        return -EIO;
     }
=20
     return 0;
@@ -810,9 +810,28 @@ static void whpx_get_legacy_fp_registers(CPUState *cpu=
, WHPXStateLevel level)
     idx +=3D 1;
 }
=20
-static int whpx_get_xsave_state(CPUState *cpu)
+static HRESULT whpx_get_xsave_state_buffer(const CPUState *cpu, void *buf,
+                                           size_t buf_len,
+                                           UINT32 *bytes_written)
 {
     struct whpx_state *whpx =3D &whpx_global;
+
+    if (!whpx_is_legacy_os()) {
+        return whp_dispatch.WHvGetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            buf,
+            buf_len, bytes_written);
+    } else {
+        return whp_dispatch.WHvGetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            buf,
+            buf_len, bytes_written);
+    }
+}
+
+static int whpx_get_xsave_state(CPUState *cpu)
+{
     X86CPU *x86cpu =3D X86_CPU(cpu);
     CPUX86State *env =3D &x86cpu->env;
     int ret;
@@ -825,27 +844,43 @@ static int whpx_get_xsave_state(CPUState *cpu)
     xsavec_buf =3D qemu_memalign(page, xsavec_buf_len);
     memset(xsavec_buf, 0, xsavec_buf_len);
=20
-    if (!whpx_is_legacy_os()) {
-        hr =3D whp_dispatch.WHvGetVirtualProcessorState(
-            whpx->partition, cpu->cpu_index,
-            WHvVirtualProcessorStateTypeXsaveState,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
-    } else {
-        hr =3D whp_dispatch.WHvGetVirtualProcessorXsaveState(
-            whpx->partition, cpu->cpu_index,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
+    bytes_written =3D 0;
+    hr =3D whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len,
+                                     &bytes_written);
+
+    /*
+     * whpx_get_xsave_max_len() returns the size of user state components
+     * enabled in XCR0. The hypervisor returns an XSAVES image, which also
+     * contains the supervisor state, so the whpx_get_xsave_max_len() size
+     * may be too small.
+     */
+    if (hr =3D=3D WHV_E_INSUFFICIENT_BUFFER && bytes_written > xsavec_buf_=
len) {
+        qemu_vfree(xsavec_buf);
+        xsavec_buf_len =3D bytes_written;
+        xsavec_buf =3D qemu_memalign(page, xsavec_buf_len);
+        memset(xsavec_buf, 0, xsavec_buf_len);
+
+        bytes_written =3D 0;
+        hr =3D whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len=
,
+                                         &bytes_written);
     }
-    if (FAILED(hr) || bytes_written =3D=3D 0) {
-        error_report("failed to get xsave state: %s", strerror(errno));
-        return -errno;
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get xsave state, hr=3D%08lx", hr);
+        qemu_vfree(xsavec_buf);
+        return -EIO;
+    }
+
+    if (bytes_written =3D=3D 0) {
+        error_report("WHPX: Failed to get xsave state, no data returned");
+        qemu_vfree(xsavec_buf);
+        return -EIO;
     }
=20
-    ret =3D decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    ret =3D decompact_xsave_area(xsavec_buf, bytes_written, env);
     qemu_vfree(xsavec_buf);
     if (ret < 0) {
-        error_report("failed to decompact xsave area");
+        error_report("WHPX: Failed to decompact xsave area");
         return ret;
     }
     x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
--=20
2.55.0.vfs.0.3

