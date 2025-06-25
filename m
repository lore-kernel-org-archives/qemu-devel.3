Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9CBC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQxO-00071V-Ty; Wed, 25 Jun 2025 10:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxM-000706-KJ; Wed, 25 Jun 2025 10:18:32 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uUQxK-00048d-8D; Wed, 25 Jun 2025 10:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhOEuP85ff51AqbsirsoUI11TZDZOlB5FPoeJsAkkSeihIk/dlh78Q13RXtt7okTZSk5EhboUfX77e5haETk1azGxEZUc34DNq+ihxeuo1h7FaaWdxFqEPqmF/iNLDsYh6TsXKauK9wX5eAx2MXopd92qb7hYa8eON0NV/OMBFXi1ezSbRa3ARpoyihtHU8/CzJ1qBizE2+GbSfKa5jjEw8K5oW3nQLgBUkqfHMkZ7OFzh1Ttavw76patY8syfV2I/veKIq7DF0N3tS1dkwTU4PHw5ECrcGANkWiVPr32m7Sq0bCVUxGWQUL58JAbWEP42caea87DtdPFACWlrctSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF0qkCg6BinODd08u9YpoWVun1muktcNPdrwvPOk4UM=;
 b=pT6NGezKl5l7HSuar06+0gdEO3OpfvG+YWZBww+GUGCbBxVZLvhAxmrwE9PsBQHZr44vRKoZmaSyWpuYvxPrYnRtSsprjy65FYKiGKgHcOa8NEoGjdA5/ACr+g3JtjvhJaqGr8/1RFRekGC9IEnstyKiswVBXIme9FHASSq4ax6s+FqSmw/hlkJnwOZ/i0IOn0/EtcFttlOzDcQ9BPm/GDM2CvtRMJz8jYndurlSkKf8np5W15/HEtQCQxrnCLrIKm/HDJyMcqPiGTzsLUiMyf9P0m2PEj2KXm7mEhkJPp9iBeIKc5T0DOcFIt8XEa/tJ7qSLvssaUMfQ+V9fiSe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF0qkCg6BinODd08u9YpoWVun1muktcNPdrwvPOk4UM=;
 b=dGXRzD+ABTpKdJZJPrt1WnWFNorEmvWN7lDm4HTpfsoCDSJcpk2jY1vl6gS9znGFFx6Y0mRy6ZfkeT6hl6aUL1DwcBZVgGyGwnqxVFqNl3d/mqHG72GMhrtsQFcxOpYekHcrEQBrsXW01YPTxNLHRx00t0IyjOogH7FSB3+Q537uyGBp17mU2K/ADFB/2vYOBh7I6l0OdMjnrOU+90iDUQWK7jQZAltHdvORw3XtrJ1ZCTS1upbQd2ZI56trkyv6fsXXWPu7F8mzF2LhH/gPhFbxTW87pPTtDsvj0zXt8EXDLxQNIj+M/OGEdZBBXmq2ieL4cizSVcwsayJEcnWJ+g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM0PR09MB3665.eurprd09.prod.outlook.com (2603:10a6:208:182::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:18:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 14:18:19 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 04/11] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v4 04/11] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHb5dv/N8i4iNywa0u053s6BoJFKA==
Date: Wed, 25 Jun 2025 14:18:18 +0000
Message-ID: <20250625141732.59084-5-djordje.todorovic@htecgroup.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM0PR09MB3665:EE_
x-ms-office365-filtering-correlation-id: b01a7711-8ffc-458f-8512-08ddb3f32256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SDUSeJQQpGZg0Vnljd3rn+MNmJ4o6IUIynrmY0Ntlhx/lAmr7sE+OvmIuS?=
 =?iso-8859-1?Q?Ks8gJTx2TUh8Ki6uYgQU9PZHmix8wXPo52as57CF5/vAaQhLYQU/LE4b7w?=
 =?iso-8859-1?Q?IzAnolIKKkFuC9SNSJiFIu0axkf4SImfUOiE5cCaPKsR3FfQj1E4podkGq?=
 =?iso-8859-1?Q?3nVejrz1uTVSUNJcJUbY7m5drHTiW09oC1j1gkYEbzMtoUnk86Musw1dJx?=
 =?iso-8859-1?Q?1jSsyxYrLms5s+tqLwH8CSSus8fk0W9WnHgBjWuUs+7VoSi0cl9VwpyzTW?=
 =?iso-8859-1?Q?iaZesavkEE/X5UI4fv+sLuWrYEh39UWH72P9SxYWd+HHFzMbWN8d1LCuFR?=
 =?iso-8859-1?Q?5o7zDIsfZHHPbMQg4Tb+h5/fGv33XPpbLROP7wyMJ4L1KYGePXSHgzeDrm?=
 =?iso-8859-1?Q?VEzsxAVX6iAJ5nu+OEDww1myt8wI8Z7cyFCpRMux/cGHVmlAy8T73mC3g0?=
 =?iso-8859-1?Q?4W3fJxKHKKZatAoCnmve5B3bOsw18MMs2SDoGSwx0u09rg0whpaS9LaDWm?=
 =?iso-8859-1?Q?ZW15M1kuoyTVhmli87S3fVq53R2sf3Akg2hQO3F1gshtTOB4nuBlZV9QEV?=
 =?iso-8859-1?Q?fx6W4LgKUnZtb9BCv+cGBTLbZoPTvbBRb5sDGHL8KKtOD8tQjaZ+4WSAWP?=
 =?iso-8859-1?Q?F7tXuOu9YAo6HNt9Paer5ynC2OvTiH1ytQJCdcw65WIJLNJbUDDbU3i5E9?=
 =?iso-8859-1?Q?KdOqOpHDsrKjsoRTMeTD7VWc5Zapm1I0XvQrxKub+dJfoYT4V1VWsrXWDW?=
 =?iso-8859-1?Q?v7U3bp1NLLi0jbqPssdsvjwf7TFcWjd3I5bxyHavwKPF9U2jfKH7vf5mEx?=
 =?iso-8859-1?Q?ZiJYav/klHA14VnF20gfkd6D38vnYgv6kr1ArR+hqyw6/zGsL1QliHkyxX?=
 =?iso-8859-1?Q?cIr6lAqzxzsx4YJ2NT+hzfFSRq7june6kkYQxT1v4kJgePYDlXSEE0wBtD?=
 =?iso-8859-1?Q?uJ11ldPQlUx1TLi1Y8LE6roIVHAI7tQGk+wmOfD5Fsw9C1pGQbjPNpDiY2?=
 =?iso-8859-1?Q?ef4wOpoBwy7P3vtw1UEKuSpLxBcP2+Sc/IDujplCZ/PirLke+dGGGOakz4?=
 =?iso-8859-1?Q?WFaE+mtrhP0V3ggV03oegK4KapmGkI/I1WlImOwolrIXw6rnHP6po5WWni?=
 =?iso-8859-1?Q?b9/FL68bKMjexreoaaPpSFUV6ZpmUPsh6re029bUW0dy3JnhIHBzJb+eER?=
 =?iso-8859-1?Q?e0flvpxV3m3ZnlnMnpqOWdfPjVusVvgvSAs0u3cuSSEML3ZkWeqeb+qWSu?=
 =?iso-8859-1?Q?9Vb9/h42QNJ89eBiW58kkyIxB81bY86rHV8vxsoPg21uxtWAAg2WaOqt2V?=
 =?iso-8859-1?Q?1AzyiTVC/jamDgI4lpHBIQrDH1G/gfPATnPBLQpxk3r+uT+u7NP1XSdnr7?=
 =?iso-8859-1?Q?vY2DzhOU1MjlHU44c/nP2eKsK5TYlaMUAYNyYXuxEroRbIVC0rWmQ7W91r?=
 =?iso-8859-1?Q?vz8eCVmd/G8aZrMblNLFQ62THFa+PBWSVyS3223MIwnvOrJuIAMZs7Y7OS?=
 =?iso-8859-1?Q?z/Y//FvaTNDtFF+LOGXOVCfQGXSiCPqO1EIEV+UtTAAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z2QgbMtZTfw/XB6Rl3lHUu/+D9gohOAnb/jjIRvKtVQq34O/n3Ez6uHzAS?=
 =?iso-8859-1?Q?5wcTO9KoiL1Z9bujo+v7OJEW9suZquSTn0lzF339Fr1yGCquQH0HLOqMln?=
 =?iso-8859-1?Q?2NM+Y/Bzsn7imgNT+F98WUrkZJieS5EI4YdIgz9E7pPcftqaL8tVg1p996?=
 =?iso-8859-1?Q?FoSE207w5OLz3/KDYpAOqFgs1Itfd9OlAUenl4QWWmYMO4hOErAUCMCbVi?=
 =?iso-8859-1?Q?ZB91jSvkIhkU6p7bbuxOCLiTEc3CKcUdqoyPWvu0YTUGwZAJx3Pa93JkFA?=
 =?iso-8859-1?Q?aNalvia5EEZ+xxHFmsoFCVOzMfzXrsN0MWFHpugtuJKP6Mi/fc3fFN7mll?=
 =?iso-8859-1?Q?AWmT0J/AdnJzBU5nnc5sfy9G1xX/I09ZOuJpL7tSptbfINrK6YXwFU7lVU?=
 =?iso-8859-1?Q?BqUgnXOwc7N56uqp645o3nZ1asm2/0Nf0YeBsBsNEl3FK1afy1ZgUc70CZ?=
 =?iso-8859-1?Q?O5Yzy6VAIr+AYCz9KLm1RJZMvyTzdQ7h28YkMF8NS+SNH6MERmAgfub4jE?=
 =?iso-8859-1?Q?bLj+Fu3j7U3TVdp96AeT0ERHrYxYWG3jxCQ1Zo0sbleiratYvHKmk+9jhf?=
 =?iso-8859-1?Q?WrrSWBWzxZgb4ytkqR3oXvTHCNjqGvTsW69LDwOmD+5GDEmqDaAW6SI33M?=
 =?iso-8859-1?Q?1aRUKwA6cA3L0CYg68wxRImAwXeBeBbhoL/v5TXuSixTbT/HS9cQ2bq87p?=
 =?iso-8859-1?Q?y2fI9PnRZtJT4VkqPr/LCgYe1sS8zBplgvHP16FegEMfATLVoUsZgi/Pcd?=
 =?iso-8859-1?Q?ygSJxUTxvLIb3zPzUMF7p2MAkTtvcsIhL6Up5S9KdqPnjFoUxtii1TqMEM?=
 =?iso-8859-1?Q?MkpAe6LHetay+n6OOACqE9usAAPs94Oj4DjvBV10N2AtQOVeOslDzJx1lf?=
 =?iso-8859-1?Q?Pmpo6DnbV/VkL4zAz9/E/SYSwydrmvK44wI7rPXYeD8f7KWfLwPOy6r/Bz?=
 =?iso-8859-1?Q?Y5D8zqaU26eglleweecNEu02scFoYoWcgu3+nfU5fH5fhq1HbezMNvUSLZ?=
 =?iso-8859-1?Q?z+ZJx7oOnpqW7Wjd6Gv9e0Gc6n2Ycvr0uJcbyMDtwJPAqeohSN37618phk?=
 =?iso-8859-1?Q?LotNB6pQQSI76CQwpNZ8FQQFS0QnyngebpQL5oIORuCLIL30P2aROLLXrS?=
 =?iso-8859-1?Q?FmW6fKDirUGPUKEDuqA+dJxfI47waV1UOPXhzYW9TO1j1M/8V/oQrQCbFr?=
 =?iso-8859-1?Q?I3uyc4c76JwNvuPQbRsrqBh4snj8Eg+Po5hdJ1duLKU2lgaJrNItOytv+r?=
 =?iso-8859-1?Q?gXCuJ4OQiJsV+yOoXB1IjLKBZAA6HNDjdZhHO6Wxr8HUgwofsZPE1dBXWq?=
 =?iso-8859-1?Q?bQ2/89ZGt26g42z6Pe2KxT/f+ndg8Y32V3OrUfRITRpgE62qeuhW1tiiF4?=
 =?iso-8859-1?Q?2yImIxIauuiUoVAG9xgsCE1jtltIyyElLxNqRvFEzabibBPb2n5GQUJfzG?=
 =?iso-8859-1?Q?1FHDs2yjrWjg2UM8pPwVqj4KevF1XXVHxd3ZFqrPuHb/PMv5k/oF4QrMBk?=
 =?iso-8859-1?Q?W1DXjCn8u90/efHOAzSGjTsAgjhO2PJHIYQ9xcYNY2TQMCEsMHTsUCKAwT?=
 =?iso-8859-1?Q?zWoienMmmt4xzyOfAKa0n3xpG5S84LRMTtk2+aQwkKC/RP0zNYIfq2XzY6?=
 =?iso-8859-1?Q?Oy9U/T6xnv04I8giz7IcbUR+LAaPBUmLM2FbUJT47Qk2p4U+2WDcsRyMOe?=
 =?iso-8859-1?Q?nEJbOTjhfdtcj0R4aJI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01a7711-8ffc-458f-8512-08ddb3f32256
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 14:18:19.0235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwsPkzvdvBlhbZJuE1FAys4qco9g0toiJFc5sEWs1sz6HKPVz1I/ERKeJevApaVDbT5O55cwusSwCfSvUS1mm8d4b8XwYzOBgJQdygMLhcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3665
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 226 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 672e30378e..9a11a994c4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3180,6 +3180,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fba0b0506b..ed10709a65 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -972,5 +972,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index a4bd61e52a..fbb6c8fb45 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -32,6 +32,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..759d5e6a67
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,226 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
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
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

