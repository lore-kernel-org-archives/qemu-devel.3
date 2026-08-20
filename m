Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D389AC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqko-00049R-4B; Wed, 19 Aug 2026 20:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqkm-00048v-Pm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:35:32 -0400
Received: from mail-westcentralusazon11020079.outbound.protection.outlook.com
 ([40.93.198.79] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwqkl-0001rc-8y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEMohBvTh9ZCprSRCDYURWQYxtt2Vybd0PYN9/jHZ3/p4XvjoBE8ZgaNyADGQex6h0iWfEPpr3vBB4iK3+MGhdpRhx2heJHGH6fxKx1UOI3JtHgPQPpI3UXBT81iXocxrXkz+8XGJB6PaVq5jjpZ9FVOgS2RyiBTaCRnpj8hVQHmGYCMdkdRSqeE3QihML8svalO+Nf5oNhqSrGMzG9FotibrFTfgpnPWsch5112IwsSrMoc/BLk8kF7O6gjjaHk5JUN6BRZpsj41LfQFdbsV7QA0hLfdhQjB2DJ1umoJlk+nD6clalVA039uWLImiTcomktN+3BvfJ2KxeGxnc2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Unh5xtcGlbVgTnhNWQcka6QniS5DKbucun5OnRUPPwc=;
 b=Aid1Z5cGmXynF1nnMeLncYafs7Dp87pPpHngq9Mogd+srO95poVW9ArOAl/2iVg07+Jsm2QO9r1zLl9AgGl/wjghIDHdl93jWLz7WOWamaHhKidGRhtwBn0aJivk9S0sr9m51KC2rR8xqDnDYY9l0//MvhdQgFyEgsvRkM5yVSHbP76D2Mltkwz7rrackFlYefvcLFYzmImRgqr76IkwbYZKF/SIf3YSH4BpWzX3FKK8WT1NqMnhW6zxdNdtR56hRwV4HMzTlz0ivbhomCpq+HA2mAPigSoKdJyGYCih61mEYhp+/m42Uu/RnxGvHY9zlCnOxNM+bpliBqvJqk211A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Unh5xtcGlbVgTnhNWQcka6QniS5DKbucun5OnRUPPwc=;
 b=P7SWHtOdx7qOvfcRcy3utLqcro5eh0lKb80+tWrMIZgA3Yzqvoc4X/ru5wkWAayAIrt+m1PJ/XgRGFUZ3nZo3qYkVgOjZBRyvktg9vDGuzAn72g7B4ATIG7Ae9qgoKPM6eluvUhahtWj1X8Z/6fcEsHcJFcCRaF2qdNv3TlVOio=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB4995.namprd21.prod.outlook.com (2603:10b6:408:2fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Thu, 20 Aug
 2026 00:30:26 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 00:30:26 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH v2 0/3] target/arm/whpx: fix whpx-arm reset hang
Thread-Topic: [PATCH v2 0/3] target/arm/whpx: fix whpx-arm reset hang
Thread-Index: Ad0wOvXwv6Lfm1mySUOFQPolKMb85Q==
Date: Thu, 20 Aug 2026 00:30:26 +0000
Message-ID: <LVXPR21MB7009892597B7773332B656EFADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47d0cf41-9039-4654-9a40-42fc851af90d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T00:29:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB4995:EE_
x-ms-office365-filtering-correlation-id: b956a17a-fd14-4786-519e-08defe523ad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|7146999003|56012099006|11063799006|5023799004|18002099003;
x-microsoft-antispam-message-info: FyNCr0IfOfxw3ifq7qOHo951CkTmHkZLJoNq4BARSVbBqM7RP6tz4mmU0tYcR4LdlhlsH+15AaSylvmda2RtdapEUwepWiVxPUD3oMGGDjLaibRZ18z3YXLb2CRr8es89koLaZ1yYwJYJ1FSeLf416tfFvlJmh2rG1XN9nHccElhOgp1qSqU1XZYVdIhKHFaqprhfQ2eR+Qs5qpcYsZyQqgRsaoeHAER8vlGOaV9vvnpNKKDANbK7zWMwXzYJPuxK2noHbw7lyJomW1TCFfB9fhONXNOyE0OicSBtgabC+eV53+Qm/a55QNsGfZe4tYo3iEcldZwiZEc9uHl0qhwhMmY3mgefySLF7fUNncdH2cIXEYVNWigZFqROs4zCt7d6W5TrR0XRY6slJj3j2vnPM848WgSQEbQ5VrsRnbk/lbK13b85vEkhDh+sprhOoTm8nl9tSTCBK545K3R3onVEZQsb/AnQ0+aSmsaOOTVqlBNxuLw4tEB4R6sOsOG7lc7vfcdIJx/L14c/O7/mXMHgTGDnj9KIcuCU0G806/UW0e+mNaFmf1h/EyH66cDpyovhov5YA3g9wqWKhdfPN4HWAhWWJnOWS9m2YBZ70zIXgvFxLwWcUE5/KKaYNn9Fuv9bwreQNiWWxWsE7KM7EokW0fp52PT9dljtLCutkvXu01Gw4aw9M6VHrwFKs/MVMWxYcBwNcPHZGp5p0/3EsFcwjgAOfLH8aFrqhBwCVxZPDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oC0n7Vi+rFp8pP9ysX30KGoJ6MKSIAmTZpItHV3KAr7qnsMisPbjgf6Bg6O9?=
 =?us-ascii?Q?kSbeJynWvkIL6kn7UkE4pgOjI3RdCi9G4CFwfWxEwlvZl735xvfFWftgYsgY?=
 =?us-ascii?Q?5hT4BCTVAVnuiI+ncB8yPnusDbGQuC4qauaFKqugC/nSjbr68ZYoLMdofhIM?=
 =?us-ascii?Q?E9MpapPMxM1K83o1/JYt62AeVs+8l7Itbdti/M7e/dGgJDZpMXVAfoyS7UMf?=
 =?us-ascii?Q?UCHfIefcRi6x9X2/bwfQvCqzUlMjbf0K4DTWsJ62eBTldTIbrmXY53eDGL4E?=
 =?us-ascii?Q?BM6JFnr8Hrs20q9UOTxWU672AnzW+8eMrHzJqZgpcnqdcJzjEHExOJE0R5Sv?=
 =?us-ascii?Q?jdVsCV1ubbG0GZX298mPoDBDokHnz2ckas2RXYMdW9g8iGPdMjC01NxuV0ZE?=
 =?us-ascii?Q?2RiXNVyK20k/cU4GjSdfHJX9QlUIcnm+zoOgDnGCqMsIJErPWJNAOCFMRm6e?=
 =?us-ascii?Q?GI4fP0lCAJ1to9w21iQtkn//EnJvhlxFH5SLBXt9zppmmv0iqpgnY0BJLpkU?=
 =?us-ascii?Q?tcSkah4dK/cTm8R0tf5wVkAj1WWu6j9YaDKPx+aeB87hi79mjD1nbNuHbh6B?=
 =?us-ascii?Q?rOcUomL+BWw1hbZ+azhPRFAEXgx8kNQT9YrR72t824LR4pwNR40ZR15wnjLd?=
 =?us-ascii?Q?f8LKEr1Bw2kpNXlRvapX/W1Rq8sE8tCXLg8HthjpewGmk0sx4KvG3/OXvaYG?=
 =?us-ascii?Q?rC0wc+0sKat+ILoZAZZmf+JLyn8NY4E559FbFKHo27t4FJr+zZW060GU992Z?=
 =?us-ascii?Q?oHCfXqr9d7WDiAc1elOhNEcij5vbp5aNgQOYMgIiASjsCqiBQiBl+QbLb4W/?=
 =?us-ascii?Q?2gwzhyKM1c4Ir4Ks4x3uEqVs8OyVof+jL2kOKUvKTtHMbpYlbiYuaWaMZZ4w?=
 =?us-ascii?Q?SBq6/sVHig9vqTzVhqRi6IE2U74DXCDzBPgpInSB1jHkj+IEE7nM6dPM1d5r?=
 =?us-ascii?Q?RsFEzNIEPFw61ubm7gRrNh4CDnmw6aRN2IUYG1yJBoQ4/FW2fbEa2WB+QsOn?=
 =?us-ascii?Q?v2ZsucXkpnBQ4yY96xn53N7IPIyjcTzpd1HLNH3UZfESI/6MCkCAwxrUXqEB?=
 =?us-ascii?Q?LoGFILjRuzIOo0zFWWfsTwiNfLo8TW+wUvuhV+hVt4AYq/jBV5VWm2JsqXJm?=
 =?us-ascii?Q?KkUHwwZ7imBDQASPUn7ag81HLCThlXMCt4a+jZW3VVUQtrOeM7s6LEn60vIl?=
 =?us-ascii?Q?G6k31IYWto54brvrF7en+qKhgyde/fMmVxGI/xtoj4jb9WFTvh3a2hIabWJr?=
 =?us-ascii?Q?8THnDljmbriTilQ0uCnwNZVKnTyOR1PlKXNKujSKqZvZ3NkZG+3JKaOBpAN+?=
 =?us-ascii?Q?pbuqgqzVBSobCxUmUZp25ejKWxBLAIzLnij+A4ARniNhfZ1oMmpaAZ6xyYJN?=
 =?us-ascii?Q?SVYHC6WHbwutFauJAolmEVLQJKtDngfmkgXOTbfYPbjFuZrhbiyN6FM9ntKS?=
 =?us-ascii?Q?6uEWrdp5mi7jBgNOnziMw+yHstDTljVZOKdGtQ05EBMY9pl2s93VPJClDB7S?=
 =?us-ascii?Q?c822MD1yA/hKXTJCVUYrJzxpeC+YRCb1HttA4Yr4w9xnUmcqvbbNL1/mg5Uy?=
 =?us-ascii?Q?VTTJWXt+NP0G/gt7v1/dNhJlvMALZrkBNHDoc7L711btyzKMIzLkAsUqnC6+?=
 =?us-ascii?Q?V86U8J10A2n5bzKu6DDYE7LwMsiPUGxFmyHv7ZCpOWSBtmk1c7qcSV2mfJKN?=
 =?us-ascii?Q?3xOU71tGEln7yTozJ3ChS9Iry6BKikZfwy0nyHSN7P8nOF0f?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b956a17a-fd14-4786-519e-08defe523ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:30:26.0521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tw8p+DqlHd/Ko6PtMF4khj91xwnAp5wqpqX7gghhCocS9RjYrAJVfHYrRDqYr6zhsKR9pBRSY3YVBK88FEdyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4995
Received-SPF: pass client-ip=40.93.198.79; envelope-from=dcook@microsoft.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Under whpx, arm reset results in hangs and crashes.

- Arguments out of order in ENCODE_AA64_CP_REG, so get_arm_cp_reginfo()
  fails, whpx_set_registers does nothing for reset, and SCTLR_EL1 retains
  guest state with MMU enabled after reset, resulting in fault and hang.
  Fix via wrapper macro to retain existing ordering convention.
- Fixing the ENCODE_AA64_CP_REG issue results in assertions while trying
  to write to ARM_CP_CONST registers. Skip them.
- Correct four entries in the breakpoint/watchpoint index 1 block that
  named index 0 registers.
- CPUs that are idle at time of reset remain in suspend after reset.
- CPUs are not in the correct StartupSuspend state after reset.

After this change, I am able to repeatedly reset an arm64 guest, using
shutdown-reset, external reset, and watchdog reset.

Doug Cook (3):
  target/arm/whpx: Don't try to sync ARM_CP_CONST registers
  target/arm/whpx: incorrect ENCODE_AA64_CP_REG parameter order
  target/arm/whpx: fix whpx-arm post-reset CPU state

 target/arm/whpx/whpx-all.c | 290 +++++++++++++++++++++----------------
 1 file changed, 162 insertions(+), 128 deletions(-)

--=20
2.55.0.vfs.0.3

