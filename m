Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39008C7115D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 12:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRrtX-00067T-Tu; Wed, 18 Jun 2025 08:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtV-00066S-Ri; Wed, 18 Jun 2025 08:27:57 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRrtT-0005VZ-KV; Wed, 18 Jun 2025 08:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEruhH9w+LHEhUyJzDCHeITnjS3H6JaXNB2l0QacMPW/aWL97tFKJAE2m8WjOdx2DYybve2SlJmEPfkyctlN7qg/YXuJyVBaSzfs4SQBUoYFBBonLIdl5QfK+ocztRlh9ZZEnNXW6vy4v8DIbBfUeKmPua7OTawGe8aBgeCeu282FPbocC19wBDYFe9wg5e3IUaGX1dmzB7vo1ETl+TTMbHY1dDT8fjJGeaEiHKo1jb1/o3nBTHuu6fr23zD/1zO/kAt39ju52SzKLJnGQfnf8glyLW9Xd4RcWGeESdgXI2Yt4kC5yifJo1O0KBlRSeshXNefRgZHJCn3PE1M2keDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecl6GWKcrKEOhaI8us0Jcrfe0o7iiuaYfdA0eckuJv8=;
 b=DzCBsnosA0ulp5yphtGlPES2DWsdI/NcmN7sttt9vf9FNS+EsGm0BAyD1FVByzbcDnKWJH/PrGHxyRs+fgd4TY7HeaetRB4iYUSPRn5btHI2A3dOg1WdOyUFo8jaOXekCUuNHUktSFw3vSdYHUdO5X0KDWt3uB8B0HSGS6dJ3Yqw+Nnppn0nui8mvWzCs2izIn+CovaU36OL+ccwl+ILimaAVNel/mdI4hlxGWNNGx66LsdZFv5YTgSHzPkfDUBryS/CGfiy7SJtvQLQB5bWXmzEUE/0cAMmoakIwIySD6oVGZU0U7HoyLjT/OzxO59MkFD2hHhjgki/J4VIuOmJhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecl6GWKcrKEOhaI8us0Jcrfe0o7iiuaYfdA0eckuJv8=;
 b=rYU6kiphpUg33z8tujX76feL4LWlnND5hKGKPGwH+Y/VnwFBY/a8fgLK646iXgJzcpEIPsmz9YLSn6J86EBgJgI6Z4N0lsC0+skaqQzkKGVk4SHD5PTUeTuYAFyBa0Ci87WXYlmwwYZpVVs8tJbVcuU/Z4iXN6UabHS52UL697k2sCjr2w6hMEBHhw8PlBv8h2oEwsdzrC/AAB2vJ2i2fo3MK62KnKcBzj/Nz3u3D4ZjV+LExllJ+5XfIofdq7uKMJI5SB4O7bG8/4jJ+NJg627N6aUhjhCVkhb6gtkrL7rdz2hTNS/36GwV1fsMBzMcieZgi1pkg1QRfoRRrfsxyg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB6509.eurprd09.prod.outlook.com (2603:10a6:20b:482::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Wed, 18 Jun
 2025 12:27:48 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 12:27:48 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 05/10] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v3 05/10] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHb4Exm4PvjbEhE6EK+pNrKoTqOeQ==
Date: Wed, 18 Jun 2025 12:27:48 +0000
Message-ID: <20250618122715.1929966-6-djordje.todorovic@htecgroup.com>
References: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250618122715.1929966-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB6509:EE_
x-ms-office365-filtering-correlation-id: 4c6b1c75-34bc-4f34-0dea-08ddae638918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Pb86gMxc8QaMf+gmD8sr2d2stjhQ0qup69/0ZcXUb7jmnW9WKoju8BdaBe?=
 =?iso-8859-1?Q?GrHw5JaW+8T+rnos17EJMxAmRb5BYQdLi3Ct2tSPj59hfKmBvlZS/KE3b9?=
 =?iso-8859-1?Q?BwCuichweUL+qUy0y5AWWMM8g4ff9hZkh9HpbXyDV28yJbAlSVO6SU5Szr?=
 =?iso-8859-1?Q?0xKBnz6InmiW3c21ZomXUxNpZ1UO1CyGCw+30zHMg360J5m73AR6Adh5s5?=
 =?iso-8859-1?Q?w/7l9zJw3wMBbNOPlqDmwiV5wovfQW35PgYEC4hqU4TWWWX23S1WttyBp6?=
 =?iso-8859-1?Q?7JMWBYGi6MIC0NrVuxMeFKSP+2Waxknjz5gShLoXKhbO6KslHb6j1bT68g?=
 =?iso-8859-1?Q?5hqansujLRk2ywHbfqI8XgeNAKS1TSNagOZVnzHICRQooZDQTdkjjCHLT3?=
 =?iso-8859-1?Q?q/aSjP6tYEMAtRXYt7pPqni6EGylZbAtFSD7QDqZysysY7PY3koC60UOSp?=
 =?iso-8859-1?Q?TKbFsonrOLGBTMF9zjMv8jckLx9WPVVJLHIuQGRGQmK6uxYs0zP8t/9u+r?=
 =?iso-8859-1?Q?nQhM+fWJDlXVZa5AoCeJ1ZtlNXRo7QLSKwM8N3FzC7gSBFQHNklfcQdN3E?=
 =?iso-8859-1?Q?8+a+cWn4Hp410chGz/BlzdWeBViJOiXfrArblIanh+EcqlpcSN/ecPv85Z?=
 =?iso-8859-1?Q?c1p3qRQTbWKy7Wz2HQGwtt1V7ffFi1ZEZEx98SrjAyVDGgFfdx7ffrUu+8?=
 =?iso-8859-1?Q?dq1vVs8flG2910UIYBgDfM2sUtR4Nw0cAdzSAdbkjj9/yShw0OQ16Va4lf?=
 =?iso-8859-1?Q?odEuvWilpK9FoobyGlmMNxPZliY5m2w67P/ypPFq6oAGTTtR6LXuPIgDPo?=
 =?iso-8859-1?Q?lYTfapE+tJ6cXJeEuv53dQxBnaVWDJWifDdwUY7kLX8PDUZgY9R6i40zxQ?=
 =?iso-8859-1?Q?on4Nkbz0lxnIirXnjFvFchVwDDAAooP81ZE/btOeDBRTBkEN5+2y0Lpo/0?=
 =?iso-8859-1?Q?XGX+knhKmBVS2vuldcVwm33q+X50Qs20hQsSQ5S2d5iBNAI30Xu0YQn53l?=
 =?iso-8859-1?Q?0h1VwGHvS573Yq+PT31ra8tdVfUa42d++1462ud7DHlhi9DezS9UHSSUh7?=
 =?iso-8859-1?Q?MrfUXv5/GEZFiFtVCfUG1GPF7P7aTGPXtKNsr32SZ3efXF/hI9Jds8cyj4?=
 =?iso-8859-1?Q?83ha4y3tU3JgbOQK8uYPaO90+2PgqPIQoq4KtjPkgcPbbifk/ZCe725DxK?=
 =?iso-8859-1?Q?67LI8bFyo4l0iGfB0Mmp8bMA+ne6cx7K6vxn4aXL3ls2VXr3TROrpbJBOw?=
 =?iso-8859-1?Q?ir5lhfBKbyXcAu82PVyCUc2FxZU02mtuH7WRi8jb5t1LHpGn043Pi37VC2?=
 =?iso-8859-1?Q?LaYhF7+m3WwZiVVC4vkZccjEIa8FDYxijei94282qRcfvgBmdPBS/GR6AC?=
 =?iso-8859-1?Q?4MrocVxiGqDa8scc0tYhJ5IbC9T8g16ripPxBvlybCm/ZQ16b2nBN5lQ6y?=
 =?iso-8859-1?Q?TJseavz46CZg7/D8fQWe0W0Bf/yAuiVrnhqQyedKWf2gUBhZqmH25Z8/U8?=
 =?iso-8859-1?Q?CCT9hGNi9uC6FkmohIcrRVDAIhKNFHPdkh/PrJDNGuCiqKk8IIr66vw4xd?=
 =?iso-8859-1?Q?ZjuTB5k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rw/xVCjLObPdWj/kK0yoP9bgwt5DAhN2uD/HaqM1ZGVPINmOrkSmmJ+eHj?=
 =?iso-8859-1?Q?U7ph3V/ci+0CQm5YxtOOpmfNnMA4155cIdKPY4PJB18jfHkH7gUE9DnYFr?=
 =?iso-8859-1?Q?AIIoeQxLs1xZeMSYIP6wbcctk1bl425UwsjMVGrK/YNYWrwq/8uw5SaycA?=
 =?iso-8859-1?Q?Zx32T0Sc8/oPGCx9Fo8xiJeKw79iTzWTnOQCzrxuJWd/cjwurh4Rs/3Zse?=
 =?iso-8859-1?Q?RxmqJMCb4i2scJOfLElUPGrMv+FkIRT84Xr+Z4/9X+eLjMB5nGQKcTdBz9?=
 =?iso-8859-1?Q?zq9wznBxPpDvq6VgGQmQSHAqJI/mNuQNd78fwrchmsvafUsJ9c4t6+wQd4?=
 =?iso-8859-1?Q?UZ9w6BzXciByDVdXnuLKnwWjfpTSPU/aQIhK0C0Stg7zrl+AGY+l6gdj8X?=
 =?iso-8859-1?Q?ePWFHAzlU6oyu3fzfGCoN5zptFkAjymt/HafXyM4/Gb2ybBNS5WaCLfLtd?=
 =?iso-8859-1?Q?SBkOdgVrdWNtcCKTpwUEVYlRSNf2/FHhdiW1fZRMq5+fZzbayM37+jgelN?=
 =?iso-8859-1?Q?6CZJF0kZULR5z6PSW1540Hx3Vf+hIouSP3hEk6+UDggC7GjrxBvgSJcbjv?=
 =?iso-8859-1?Q?/MxC1l9md6UCIsXwIXn993JJBBk0dRDrDMO/n2ZQcHIZrcylI8nI7JmIda?=
 =?iso-8859-1?Q?HJptU5eJBSWN7wTT98GOZVcrWIKN+tuSOjSamncqIJjB1NcxblHqjohrbn?=
 =?iso-8859-1?Q?EgwJWUJZ4GuC9PBJQqguobYpVhllTUErvNXTVBNiNCTM93wLoisfodZVwb?=
 =?iso-8859-1?Q?wChfoV+l2RzBHUkcoz7wGItxJJe0RrwRgNfIg342cJUeswlHrMHbMPZ9SV?=
 =?iso-8859-1?Q?V8S6FThdLK5IBSzVUHJBykQH0U3qiO0NeuCOLyEmZ7Kz2sJOcIYix/QAII?=
 =?iso-8859-1?Q?tqbZgZ4eaGgj+WBLoCFbl0Dcta67qOQL8lG/bFkCkWQdapiP112fRdC5vz?=
 =?iso-8859-1?Q?xNhu9ZOnwlacU7l2GHPIuLdAxI+u8lbJtp+BIr6ByKV0dPXGkRC60cA4Sv?=
 =?iso-8859-1?Q?4uk2n9q/H66sdR6aGEvwdR7SFz3DS558Xg4NQkr3n17Y93/3dRetye9hWc?=
 =?iso-8859-1?Q?yMeR5fFiFY5Ru/BBXuCqzNeTEI33lZnnPfEooPS6of5R+/MaBuMlhPnHeA?=
 =?iso-8859-1?Q?cDMBwqzy+cgmzyMvR3a5yj98EzHTE1ukL/CVSLONg9lCilX87HVkChL5pc?=
 =?iso-8859-1?Q?CkX89To2DlPrHPiwB2/8mI/+D3r6znIq7ILIiIJxq2NaXN2bsAMthOfbU5?=
 =?iso-8859-1?Q?iKU7ykZj9Svg0R18g8+FiLge3YTSENXQT3YJp5RPpgn+qClBEkd1rhbpB6?=
 =?iso-8859-1?Q?E8vRLhtGvMdBsUUxAfJFknLw1i2Qc89u8LxVy3gWM1IuytwO/9VpM319Sn?=
 =?iso-8859-1?Q?yY6ngHIP7TrEhHeKVmzEwYClKRcZnRFFOh1F/5BKtAWtQN6wUmRpNCJUqd?=
 =?iso-8859-1?Q?RhnvZCzdjyrOJMuyqa0Zi5CRNvNf8gT0hom5A5NHwT4kTxq7t6M+YClL5f?=
 =?iso-8859-1?Q?8sypMB2AKVu/iGF1NgDrlukSnnTphTIFtu9mq2SLUHxfN0aktKjWDnWuhX?=
 =?iso-8859-1?Q?qxzAAacoyMxbx2kYUW7Ew1gfVwyHpQybYt/UAcjQNoBvmt5O5cw3Fynmkr?=
 =?iso-8859-1?Q?uoMS+S8FtyBc3MqcIFzdSu5e1ZXrKuqH6m5BMbJ2bvONiLczQOeb5LF4Xp?=
 =?iso-8859-1?Q?wIOC+hmEi3kHKCV9Vjw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6b1c75-34bc-4f34-0dea-08ddae638918
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 12:27:48.0946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoQS2ISMkZzImmHK9h35nzwi0LkrgPMEa/zrNOMIlp7GRBUhZGy3Tu0ukvIqyN50LeNgKyir56wihlZ24ujPpUrO03PLIjTFY9OD90OdBr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB6509
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 42 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 ++++++
 7 files changed, 66 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1e85a16971..6ed767e922 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
 };
@@ -1360,6 +1361,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3178,6 +3180,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
 #ifndef CONFIG_USER_ONLY
         .custom_csrs =3D mips_csr_list,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 59f134a419..baedf0c466 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..269b1082a6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,42 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c3fbae7cfe..4841772522 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

