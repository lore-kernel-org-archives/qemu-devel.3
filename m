Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D51FE6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXz02-0001ay-LJ; Tue, 23 Dec 2025 04:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXz00-0001ZR-Il; Tue, 23 Dec 2025 04:48:12 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXyzz-00026J-3I; Tue, 23 Dec 2025 04:48:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHAfEkCrLZGaHuKb9cQib3iZrAIdzm9yOq7GVPEqI01bU8tJmLOxcSQRoHCFh+wwsjeFKnMg0216g38oUWILXGUZH6lJXEngJ0r0xFovbn5Pp1pba42raEav8OGxYiX/gJ25eD1HMfBVZPh5zv8DlRR8b/aMbobelwCOVjWLH6Pk5CCE1LZq+F7gvLIn9z6nCmaa/jFFrZ1vj3qPLigZoo5AwUwIXQFE9brsVd47mnBtHw9aye3VBwnHaGYIQb+ZAJfcm8CvltcK/w6KC/fGfbjInwqPCRilubI3NftC50wrwl81eDHMdfJ4OHlDo82qPn+6lvt5mLMPAxvL35p/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8n1ZbnO02t1jEsrArcDIIwuDeoA9QMDDbowT9dIrlQ=;
 b=md1nRTvb8bT9VfTMtIwVFbXiE2RsL8gegy855dhY4pp3SfcsD+ObvUq89y4abXecAeD3QpaRaMAK0KuV6IApvgp0fTPIZB/nv5LceucbNqXebxhdpy7W+AdGspCpR38tHXgnBz7/DzQpU2pDZ8p6+uq9RwZby3sxKIRkmmCIud0OjrsgX8Xb+NoCPU3Ynbfh9PBApo9fJtnGEKVwAdwTxmdCffYGQx59ULTtMaM0ChGsIUJWIxvNdCFPmaXwX/5P3Mm2KwS/JEIylKhUIZIK5QlweVL5dV9In/WTvQCZXP44T9RIPTvZAuCccuB8r19PUNgK3loxq1XS1z2wGPluBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8n1ZbnO02t1jEsrArcDIIwuDeoA9QMDDbowT9dIrlQ=;
 b=X61l5p9Li0Vr78z23t0wOS6g6Z4gAXfJlczcBwu884RXZUKpsC0AZOWz13mFG+oJVhBWH/wo+agXo4GQfltoXI3Z+6ZgZYR2gP4OjeHULCjPvuB1aolJ7hVyqcgvM0MXuxOPg51fZlAEq/YXEGXOcB3GN0REsgKHXFCL3YD6WrkH/T7F8s6+df4HQQiAB8VC4T2Qxjn6GxiSlIyg1P5eL7swiEQLOf8y/9xGJDDzTZeU7STyTfr3zxf3qgpZzg/S0OdbMJ/0t2biVQFhMQmV+wROlzTiQNmg6rzlTvYdfXjFSIc1ZVETbCeTemaArec0Urh8/nskwyD4+uBxJaIxjQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:59 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v15 11/12] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v15 11/12] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcc/E3IOuFza/cR0uZ3Zp2wF61vA==
Date: Tue, 23 Dec 2025 09:47:56 +0000
Message-ID: <20251223094739.1983381-12-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: cee922e0-c77c-4052-9461-08de42085b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zTMakm33zwz7dhy+ycAJCpQM+kvkGU7E8XYhxtU0cjVPo+LtOrR7N/hJmW?=
 =?iso-8859-1?Q?Kh9cySpjUTtJVBbxtnMZsWyFr+WXrt35svV4y4n6bcwdLykEMHUHkJFq0B?=
 =?iso-8859-1?Q?EQcaKZvsm8tfEdtCGcqAY4MUd0DiyDWmbdcEab7kfYh8M2sVr4vOWQaoci?=
 =?iso-8859-1?Q?LpFSiwX48i0S9YiP1hj1qz4H+3PmIoWD8DhXf7IaGbEoX761qMwGkeKISg?=
 =?iso-8859-1?Q?wrgpW9bW2pwumQM77ML18u4OtPzgOArNkua7lUUUi6lJjV6XBRrSCs42z6?=
 =?iso-8859-1?Q?kVnFWhLTPmP5IXpM35SFDWuXtKhaRWbFiELlP4nQxmKNUBC3ecFfraNpcm?=
 =?iso-8859-1?Q?obzt83R9F8mxpLnSPevpqLHzePY7J0yR3dXV6iHGa4ysWTbGo5sEjrloPY?=
 =?iso-8859-1?Q?xwgp8/u/F/wgWPvABSsU3kLQ+vJ1+1SVUBfUpvydOOOFA7r9B0RSeRTt2f?=
 =?iso-8859-1?Q?AU5c+QB4o6XprLDDlfgY00VqKwI2cLvwFiBvG9gAcJJWesb1PUgiLPQd4+?=
 =?iso-8859-1?Q?lzXZ/9+yqMj7yxFM+HfKi0+ZYhXIdALlYobWctS3T57qJTH21LiOXzXIP+?=
 =?iso-8859-1?Q?bX+PQADudKdEtQ0D1xlf4usnb3E1Bbh2aB3wqLjr6cHNXHKG57yi852D1e?=
 =?iso-8859-1?Q?mlQZa7CwSLCRhJYshjUrQJpZSff5QN24Xdkwtnfdtssw/UET2BIY3ZQpFX?=
 =?iso-8859-1?Q?9mWBFV39y82ot+/E0rpfZbatT//B88t1c4BNmWZTZFN3SKpuUETLcXTdqr?=
 =?iso-8859-1?Q?wXY3LgSFQxm+l6Ukpq0O3dsNuVlAqNB+E/Hl54AzyqDI7G2KZ7ISh4vJ6A?=
 =?iso-8859-1?Q?1W38rgGplE9phnC4+Z4kYR9P/YAYLKo/eKoUHbIDv+HbB3ALK0JFxyWIyC?=
 =?iso-8859-1?Q?eHLf661WwugXxa8pP62TCgoKZBaaqLJZnuqCQJeTaFWgWhnYO+67pySavK?=
 =?iso-8859-1?Q?775MGl+hTvrRl4M26UYE+cjF9uTpndWoJ85/1y86/YSSrfwoU51NU9vhf3?=
 =?iso-8859-1?Q?s3I+/zHU3Emtp2AfD/RIP8+EYKYDATyUAoLMEI/D4j8yRSL/GV9w81UyUb?=
 =?iso-8859-1?Q?loltaNrR/TAU64gfyX03hRysVDnRKWhJvVHDKGLfxbylkjM52elebxc4oW?=
 =?iso-8859-1?Q?lNbkgDC65d1jUjgs8rOyZCc5TiN5bQPi8z9IpCBfxcn01HJw/woas4Bj+8?=
 =?iso-8859-1?Q?vXU4DBbwf2g6noiBvQN2+ARPqSLb+YcQQoO1oh4JXGT+GLTlqF6aBjGdBG?=
 =?iso-8859-1?Q?eftD10Kx+aN7RpRGl91RkIc0H5Nlned7meIGEbRgHiZN/hByGnAjfJ+UuF?=
 =?iso-8859-1?Q?lJZAvlAWI5rn4B1wLz5OI092gtyz42XNLKCCsxqNMYlX/0UlxA9HI1EIug?=
 =?iso-8859-1?Q?NosrZEIUnwy8omZYQgiBtEAISmH3C4kvFr5IgeypA82JRimZiMFaLIAFQE?=
 =?iso-8859-1?Q?xCmVVdg0TwiwCa0kzzkXqtz2eOAWwdNGiXMSCiZU2jdcSvDRu+JZGoKElm?=
 =?iso-8859-1?Q?kHEX9mVPO84647Dwu6PKE2M4VnA/Iy2N6OqJMO6AtA68/QGMULUbpMr5qd?=
 =?iso-8859-1?Q?k2fJu5VirdpAt/ecVr/TZptLt48m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yB9ztUSeLEtE831vYUaR0Hy+UPWSy4yFh3wNfyozjfASenqW3pTphrB2fl?=
 =?iso-8859-1?Q?hYf4sip69I5rKSCKHKZL0RBfr87S/dEYmvII9908/EZ3aXA4LeoR0t/7TF?=
 =?iso-8859-1?Q?zAX8j0Ccd9kcISKxBqpMDjYCIhw/YU5Tej6TEekzs4bpM37b6OYIP3Mfq3?=
 =?iso-8859-1?Q?9rhGRSEfRsWh8Z3u5VRjITSLOgPSUzRsnGOo5FvSpILeB7kGG/D5pDEZFq?=
 =?iso-8859-1?Q?hj+OCfdVz8Afq0sE6okW0OrHot+j3P1CU/R8r4rjP0iaKNgdmuz+wRFcPO?=
 =?iso-8859-1?Q?Ch6e37ghaUzRuxZTIOWDMX9myV49Er5/f7+PVJGvBQWdT/AKku/Q6CkQQj?=
 =?iso-8859-1?Q?YzHpTB/+8USjGPnp0bC1IiYCIvPFHuXaW5YwCELO1TdJqCWDmg+djzd/S4?=
 =?iso-8859-1?Q?XQoHOu8OGuNWcGK6jgxcDlUArfF3aG3LquRLffz4K5gzJ3Za8hJZSrpqbR?=
 =?iso-8859-1?Q?eBIPCXb68QfceIoSxvFo7LjWa7EIeaeJkZwnSpEtFYZ+5yL6QlE8bdsV45?=
 =?iso-8859-1?Q?LDxldQlFbwOZAO30NS+kj2ubdkH8NYaGitzfV7DhADTOPj1RCJX9qOKSjp?=
 =?iso-8859-1?Q?dEj01Z3n6IJgwm0Z4ut5iuc/UHl1KtEICoPDz6Fch9pNbMNhO9e0jkkWuG?=
 =?iso-8859-1?Q?Z+b/VUgNcemrdaK2yNEKa1QMPCR7A+xzW7Du+QSbRty6+GwIIEklI4kXwS?=
 =?iso-8859-1?Q?4+ufFNuWGkc1NfZ/c+LepoZQuRo4jl8ZONB4upUrtuVGLXCGbwvcKWxDOv?=
 =?iso-8859-1?Q?7oD2rqnk7fXVBYDeIX2YQm4PYxjF/eJOHYyXLZh5t7h0e+xbII9fJfvlUM?=
 =?iso-8859-1?Q?Zetv21CyunpCdV8AMurwOUDJ8y21Bg41vbg7AE859lmcmqrP41cEEG2p2k?=
 =?iso-8859-1?Q?HorBy6sLKBRkS+cHswDav3CDRCpfDzvnZiCV7EJ0kaspC3cincgyCeU0uf?=
 =?iso-8859-1?Q?VIIHo1wUtlpB3tuc3bifYOKb2YMY/JVhg4RqAgx+o5zT0HmtyOBkVRu0w4?=
 =?iso-8859-1?Q?IJXSJ1XPj6lwOniUN9qx4KpStkcEuH8oJV9eUK7Ej1cdQbczv8odYefoAP?=
 =?iso-8859-1?Q?eZZZzqO4GEvwEdpA7DhHUnohPLrCb6s/tPkOkKSyZ3vjA6KXEgYZzNpsdi?=
 =?iso-8859-1?Q?SyKjY0axe6jeSJt3EA/vW9/Pz+I4QdLxvHOmjCn8WeaL258aPhocZnegMI?=
 =?iso-8859-1?Q?HATBt6NGuKP+TUGCjhfYsVUrgSBDHYtfNi2WGqh/MwEWpNNqXStzlzYMyF?=
 =?iso-8859-1?Q?fF9dBfIbOJJkJYKgsIzjyAEbQzEV9mmYb7xEC4lUYK1mw1THa/2e7sNywm?=
 =?iso-8859-1?Q?8QXFXa/kklxLkOjderEv036yAYdh3yweGGBxf3My+/z1dfupfJBrKnFtin?=
 =?iso-8859-1?Q?cy2IGzMQQpSh3yh2YBznBrkepsmJOmlmWb2UidXR13L5gs0rv0etdfsdfG?=
 =?iso-8859-1?Q?jcXaRFzMxVv3+75Bm6HR+EfJl11P7RokLsZe0WSU0nwDUSK6Jkd8Jzpkjw?=
 =?iso-8859-1?Q?ilOIbs/pdKEjwOygo1Mndk0uK/p5mg3SPzimX4Alb70zh0EykcCc/GTeGG?=
 =?iso-8859-1?Q?dqfZM9xkC1CWeyYZuZCMDpk73EjviPNfewwGM+DCnpP1o62ze7NT8ObaIJ?=
 =?iso-8859-1?Q?jBOUv18xxiUvi+6iSnOWHZAV1N0v4oaCXxUhyx1RKitaZqAPoMw4qDBd4u?=
 =?iso-8859-1?Q?pde3uisSdLLcx/uR5HJB6fx7k91OsvRU4HSj0GMOwnRfDmFl23LAY51hf4?=
 =?iso-8859-1?Q?w4TuGdX/WYfEGTfa8b8bUV3Kfjn/Hh1uRmMCsREoIzd0BmK+aEz7abTDzP?=
 =?iso-8859-1?Q?akjvfqwXl0KqVPZnN+0tXDu6ACjYCg1lHnnLpiriQX5YCECGT+m2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee922e0-c77c-4052-9461-08de42085b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:56.5219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mkv+u68StHUvwi3RaSywjWCSnvnIIq+8cLWuqYP5l8yetj4mNuk+gY4ZGf3O8LoIRbI4JC2IlG9mNgsVX2j5EVRY2qCGxZSj1wiHLa8CySA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7cf58d83d3..00e75b2926 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB, NULL);
--=20
2.34.1

