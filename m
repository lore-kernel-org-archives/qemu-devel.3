Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48161CDD1AF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAzA-0005N6-TH; Fri, 27 Sep 2024 09:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9gW-0002AV-Lw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:02:56 -0400
Received: from mail-vi1eur02on20725.outbound.protection.outlook.com
 ([2a01:111:f403:2607::725]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9gU-0000A0-Vk
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:02:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk2RUzhHYuCUQolFCvSZFldJCxaMFG5Vd3tHPhKbhl85FEUNewDe+ZhZkKsBfHLPDWHs/qGrXsseQGooVlKi8SJ8wQcCN3QBnM1P2O89xzjhZtZ328S5hjVwecrtLzTlsS4vyH+XmZJN5fkU3mYXXLwq/a+V+4ysW9R6fQmvFDblTV0/GH8Yc48ANt1TIdgmsRslC2NFXu5pvd1wGn9wGl7Q1ojQRzSCZ7a+Pz7kMpvdr5drrW9XseBwCc0/2T83ZfATUdMdW2zTg8b5Xswko3LX+7ucTHRNzLvl4g9JCOSbPRf/BqPxozwt0k1OigVYLkNGWrXK8jpEqRBQ28fCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdIa/WoedWE4JbUHb3jfXxRJ62eL+5ERmsJzGJJ0FTI=;
 b=lX/cYqQyHPGIUMzqX2+t46emriwQZps/W2G7C2TBfHEcdnElHtgcMXybHm2icZ+51w8fqj99yqAFB2S4fG2soEoYv+YijEMuCJ4zKd9yKjUvm4vZzEq5n7whsmBzl2KKA3a1EhY9YhyYrmljzKUmQcIm27lDUpFy18cswjvEA5jXy48aWjoxAmKgHq1z/4o3/AtrWkLJ0zPZEXUkKwHOcSJvhcaECGjNyIHYAv673RO/al96SsboXjtB1nM5w5FB1gHz46McVqXfM9sgr7j3o2NQIPSm6TXD+SW3S3kunlKIkp6BzV9SYt+1vH36R/WsFikdEoA6hciZlxOAQ01Xuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdIa/WoedWE4JbUHb3jfXxRJ62eL+5ERmsJzGJJ0FTI=;
 b=AwKPOudvODuc/GtG1pUjkyZXGBAhOjklCujrtzVsL3X9sy1BSBzL37MbgcnHEhcYbvz+sE+CYD+VaVF5x3YGA2t4lrHFXs5kn4WHldPJkGwFeNEp7/WrYZdWxiuE9xlzUFFu+tk4dIvAtJj4XaKuWv8wx6V1DBocmd4kKwOi6AqHyaoYn1fEbxIP04CkPeZ74QIMlMhU4Er5Tt1kKeYvnyGzdpHROfma7seP5sG1RMRhgLhKcP0+ix8iPvR7kAChJmtmx1cpQpdjYmVSyvuFWorfdnoYN2NnxssRtILvci94YFl9BGZk5DNwZOB0H3tkhobjVN0DVg47cX80loio5Q==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by DU0PR09MB5522.eurprd09.prod.outlook.com (2603:10a6:10:342::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 12:02:48 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:02:48 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 3/8] GTM19-448: Fix script to work without realpath
Thread-Topic: [PATCH 3/8] GTM19-448: Fix script to work without realpath
Thread-Index: AQHbENQjc+PTju1sVE6vowqY+CTjcA==
Date: Fri, 27 Sep 2024 12:02:48 +0000
Message-ID: <PA4PR09MB4864148D80DAFFF5698F1A40846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|DU0PR09MB5522:EE_
x-ms-office365-filtering-correlation-id: a23e4b0d-b981-4d83-0bdc-08dcdeec4e20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BokJ+BZ9+QtBqH/yloxr+3UmvnhImpV0KJXatduivQzlOrahiaZqi0ry9A?=
 =?iso-8859-1?Q?8+Uc3eQb7Icq9ShbQuYtP7vd9X40CoLx9wcCG6/62TPxox6Cmoi7NxKr2z?=
 =?iso-8859-1?Q?o683SDrIKQca7dVIofma3tRn3Fc7CJYBDqbsJ7OrQnM6PQA6ORmAwaZHl8?=
 =?iso-8859-1?Q?Zc+qnD5n++pCdVaMjqG3JGPXaW8k+tAEVayNYd+rQ4CBMeH2XVkVnK/jYP?=
 =?iso-8859-1?Q?pw7zFnQcvngGLb6Ft8ew9lGT44L09g5E/p9CMNB/ksj+Vjj1tRuEi9vFoG?=
 =?iso-8859-1?Q?1oftLZwuyK4Hc1Vm7pL3ljJbkL9gBRyIJrNIX5yZegUyTMQJ4xp4PcLCiP?=
 =?iso-8859-1?Q?JU0okL2PtlWJ9TGQz9Dui0ZvBec3D8zA7mZ1RloqjtSZIQTqFvodmMuir7?=
 =?iso-8859-1?Q?zE66ASV803xeO6YLymIBizTECLq8sWsbyAiBDGjkwu1hvJjhsQBTYHOV09?=
 =?iso-8859-1?Q?44ho5fy266Bne4Kr7xtgbG7REs0ZRalSLbuC8CtWZuF4RJjW6/xJX18Jim?=
 =?iso-8859-1?Q?VhzmEWerB9dyfP+Y9hExTm7e1GsFICGB8MulUjZf8zN32qpFybFhT4cymO?=
 =?iso-8859-1?Q?W1gJmtOorAB7vrWB3ClhiMW4QdJE+I6LcMDCIU6trZTu53BwlOdWEU4lNg?=
 =?iso-8859-1?Q?bCEd0BUJsnix8144GxeVfA6DT2ws4d33mrTJp//UzyvUY+vGdluDlUhvo+?=
 =?iso-8859-1?Q?Oxy70TWfg+MkjuYK+6Q5UFAMqbR7zUgVEyZIIEsD7+HwkGM6e6MX/4lPOi?=
 =?iso-8859-1?Q?IP89j+X8zhGLkPSE2lai4pjQdkR6cDVKm+DFZEt1pQ9WkVWgCaNTVe0MoW?=
 =?iso-8859-1?Q?7NfyXsVdVPUmZgQJxqKM6SgOeeCrkeqjFo3UxlO5aVjfmbiU6FqIfGU9K7?=
 =?iso-8859-1?Q?DVXtfoYOL4zY4c+6h7bYm+K25TyES9gCycRa2pG51iE/8hbTeEImkYS71L?=
 =?iso-8859-1?Q?kJkkd6z0w/kQvybt/LSCPIOHNv3qKqqFDcrxYvFtJ/Y7fRLzHAP1+XiCe1?=
 =?iso-8859-1?Q?Fl6eKEmTxpBNb/xRuGJO+18F6Ej6Y9esJ9aJ7BueiO7LPBQU4v5DeJiqEt?=
 =?iso-8859-1?Q?GVYIq9eOUvwH/48j8U6/C8zh3n86tIIcX3RAmIGZ5X+ziHlJqQkhjhlCjy?=
 =?iso-8859-1?Q?5gsXkshM1W9ZEjOEAjcKEk6BZLEKHk/3PC6DaMYSVCap4OJs3Puxt1w2s8?=
 =?iso-8859-1?Q?J/4/04yG737IZLS/3kscSwv3LJXMSckAAPxp+4DS64MLnQS+ZexwNwbjMj?=
 =?iso-8859-1?Q?fPLWsaksWjpToObIsf5UjQxHdiNl175G3aL4SvVmw94f+uUhfj7qR6lazt?=
 =?iso-8859-1?Q?rOdF881AnfxUFn3tqLR/rDcEeiUMOnvvu1hNAXiCHWZJTaev8mhln0QkHf?=
 =?iso-8859-1?Q?bXc6DPp4Jk+E5w0trtqBCT7Jqi0WxV6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yIJ8AQIueREmsNNGtVeqoddfZ9QoFUAyJFrV9cCyztXk2kvTJVa1T0ve1T?=
 =?iso-8859-1?Q?Ug+uGatOkOwfrIcKA1ay/Z+JNrdaRnXmqb/9ecy4fRj/VDM+JkKkoXpdbX?=
 =?iso-8859-1?Q?XbTZKNoiIu7W1MX4j7fN49QnCay7cwLHvmP4c8GQtVoV3kRt5qA6I7/ncF?=
 =?iso-8859-1?Q?v8yulV3GxgTEF62tlVNYoL07PIITXzR9yuy9+vgJvVfoHl746w8roB97ym?=
 =?iso-8859-1?Q?rsE9TQ5l+DsHpEoRZOMLyJexAWilHomm634BVSOB/5OTDhbo3aVUR5uxhY?=
 =?iso-8859-1?Q?JqIV9Adr7JQ/WPULsyvY2c9O9Es7ogDj72eUB6o2EvmZst4vTtfh4GJz5K?=
 =?iso-8859-1?Q?crwhHyjDR/0aFXCafGM+N3rWOFIzzJpCoZBhPNGbH0vUoppSR1Td+Tt+px?=
 =?iso-8859-1?Q?u9A5rda2Y8MvUUR7y5NCYBkTM/uNTwsAkEbDD8pxM4Yv/xAFrmAxkqyiUr?=
 =?iso-8859-1?Q?JtdtfIxGysKp1ghHHuDT+CBEyP2D61nBD20mCWxpgaG8tOz/xp+TUR041y?=
 =?iso-8859-1?Q?+z8GaUh5R831UU3CRiOJYH0i3zWgD7ZRQKWjBzXh3s9o3QzQLd18cuau48?=
 =?iso-8859-1?Q?qkHjc+M0AayBKQ51I2JESV/w3JdhcSa0BbrDPibwJmL/oH2zgmAEqwpoIj?=
 =?iso-8859-1?Q?W+GBCaKYvsfAQhbhPmlpnwZkZzahHEHVIRyBdR6yle68lqyhh13/ENYmJO?=
 =?iso-8859-1?Q?nDWCSlBMARHdK6IEu/b37bcIxGp1hWoyWaBE07RkDjpHD2tqH5biQH+FMR?=
 =?iso-8859-1?Q?dt5hHW7G4AkOemSKxNEAB0FbO4tWHEMjM2+BX3apaGTbSuGLyDDoN19uCy?=
 =?iso-8859-1?Q?JVoVa0VPkS9EldRkPwOqcGcZP0NE0nMhAMRLF3orh3wF/m/nc7Jtm0kCpY?=
 =?iso-8859-1?Q?JjCwtZNdvz0WBAeoPPIalE9hY3ypBbLtwm+qB6sNTpmDsVfYEKp8YFQ2RG?=
 =?iso-8859-1?Q?zczESgqVeu5HWHMuOflX2RRLNSHIrwSVU4m2Udk67ndc1L2IkfyhiWML+y?=
 =?iso-8859-1?Q?piSaFXVkFIedfoeqJem2wDy08ILTemLcx627dtjUWH8+2DoS/EQeMDqQNo?=
 =?iso-8859-1?Q?bjCVzTDMvFeH/QFlCP8xUBFFAzGuRddXQOSpkJB9gmJUK8BTStAWvL8WzX?=
 =?iso-8859-1?Q?RWwVzv4TsyazsS5UXIXhVuee4c28C9IvnZKwl2bfnTdoh9ZrnuHtt+9L7E?=
 =?iso-8859-1?Q?qp4rmQJKYK+qkqK7DEkK+wuXavJzE8Rkj6DHCSCdgRIacPgC+zhu6101Qg?=
 =?iso-8859-1?Q?X3M7++5nFkGQi0KfScYwAliE+K6aQQLG25v/x4aQPMslKPLRKC/Uk7atcO?=
 =?iso-8859-1?Q?N5k9hni9ztPcsndyfgnRyzCVvvWwTtYDkkV19bvql1mPNQzC4RutmU+7k2?=
 =?iso-8859-1?Q?XWyQmMC4rOi3kwN31CunLEawxvMN0xd0cbEIODJnzbCAG41bIH5njDtVIx?=
 =?iso-8859-1?Q?Ip1oW5yBsmt/8pXBYyhyGvQOmHJ2m6gycju0lJCcYVBhVdgP8Lb3tklcip?=
 =?iso-8859-1?Q?XOIzV6Zjtleoby5tXESQWUSO437e7gZgzgSoTwCc3mTNDAozXZ2iLc4IWm?=
 =?iso-8859-1?Q?N5Y40fXxDeWfrMPFWeNilFdH04SSXhsvZFp/fthWoCQW2wdskpJCQ3myG+?=
 =?iso-8859-1?Q?jnG5kMpuB47GII8iyOoG2wafVgVodNJKiiFlrOZraFBzIJqOo84MP9YQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23e4b0d-b981-4d83-0bdc-08dcdeec4e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:02:48.3932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1f4AtSYb1TfTi7XhfPRFR9isoopLg+gtOuGOycmfr0kH1dAhpcHkOYef/hOfEcqSi/AEpzxVIgbCnirwU6CABKrzrrpeP2Qbj+GRsh3O2DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5522
Received-SPF: pass client-ip=2a01:111:f403:2607::725;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

The archive-source.sh script depends on realpath command, which was=0A=
introduced in coreutils-8.15. CentOS-6 build systems use coreutils-4.7,=0A=
which does not have realpath, so fix the script to use 'readlink -e' to=0A=
perform the same action.=0A=
=0A=
Cherry-picked 5d1d5766f0219ce2bec4e41c2467317df920ec0a=0A=
and 8003ab4032772a0e5b46e5983fe06268d3469289=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Chao-ying Fu <cfu@mips.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 scripts/archive-source.sh | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh=0A=
index 65af8063e4..7f16803772 100755=0A=
--- a/scripts/archive-source.sh=0A=
+++ b/scripts/archive-source.sh=0A=
@@ -18,7 +18,13 @@ if test $# -lt 1; then=0A=
     error "Usage: $0 <output tarball>"=0A=
 fi=0A=
 =0A=
-tar_file=3D$(realpath "$1")=0A=
+which realpath=0A=
+if [ $? -eq 0 ]; then=0A=
+    tar_file=3D$(realpath -s "$1")=0A=
+else=0A=
+    d=3D$(dirname "$1")=0A=
+    tar_file=3D$(readlink -e "$d")"/"$(basename "$1")=0A=
+fi=0A=
 sub_tdir=3D$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")=0A=
 sub_file=3D"${sub_tdir}/submodule.tar"=0A=
 =0A=
-- =0A=
2.34.1=0A=

