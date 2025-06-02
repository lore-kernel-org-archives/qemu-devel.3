Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733A2C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yA-00086g-BW; Mon, 02 Jun 2025 09:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y5-0007zy-4u; Mon, 02 Jun 2025 09:12:45 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y3-00029D-0j; Mon, 02 Jun 2025 09:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br5LdRi/0fYfzQR4rRvTsLBOl6biLGSf80OF8LLLLqJF8sJg6H75XNM1QObA/Hpbv+ZbIAry8oDtn20hZTNUfRDUOZ4gcLqzrzDJbRaziZ68BN0cBXQ6MYVQkYhNp0HktF17u85NV8b2zXDeSI2Ai2HrnUA+0Df2gC0OzgJNqaIBXTZZWviQuZ/61/v214gZGAfYGzvKp2Ryx61pLq2g4mDM29cK4UOOnJctEqS1sApDi9sYZPXDy+uGaVWnZEgvKe5Z1wGP3d/fvXmpVUnGEIPh2AE9qDglWHTJMjl2j5Ph3jQeSh5frIlHWVs78va3rD3eu6B0I0JJLFCJdMGQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBwGThf34AgmXotOiz8MiOQh1hnzcVQHBA/ZV1xER70=;
 b=Mki2DKsSRt5c7bMzNhpzj5t++603ANn9hfWp6QRYnYL55CbSJbT4zv2hEOt/ZSO+xTVtedLxw/MueCs0kqrjSpYhFzCR/J04/q2f/l0geKUmM4anWhyqV3zQLuh2MDnLwHFEQUJ4S31dVBYoFJS2r/h9yridzZkfFvfu4Bfzzw/7KS/7UUbcc+wDBd+iPw434H5H9q8Mx0IxQbP605dIs3Hq1xjF2SOC4Yc5vRErLiv8x4J9WM1deoYihMOKojrhFCIsdqxI35itR7eZ6dp4fyb6xuOJUKCIW6qKim0V/PS0cEINn1fj1nC4jfhCtQDNjLKxuLFJPfOgpOXBB75Krw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBwGThf34AgmXotOiz8MiOQh1hnzcVQHBA/ZV1xER70=;
 b=IinxHF4YshLSHKGhGUNDWJ8ifXZXViI1AFmCt3h11iUQmlU4lN848ovTZ7tvaLcTG4xhGMk8h+Ig+mQkNdcCOO5IsHLEsIfo8D2Fd53HVWmmfcPx13gW4IRhwjDdJCxnJihIjITV9lTvWh3IbNAIW7IE7RUCPryNI2pPWcQuh6XZhiMcGvu9vdQc/BX8xXfxY6BMQsnDtyKo+hyys2l8PBCispiGz+iHDv/T5RU5w33xLQY+icV23dIRHwCPSxFmzd97z4SpLaBwKS7lomwu5iS38z/JXt2NRn/IJDH3ezF9nMsnP/AYZDUZjUcMLEB8wes8hGCoqQUkcm4+7ZgGCw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:35 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:35 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 1/9] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v2 1/9] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb08ABPHR9vHZGW0yKLO8lTfD9Ew==
Date: Mon, 2 Jun 2025 13:12:34 +0000
Message-ID: <20250602131226.1137281-2-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: 75f20baf-6619-4a29-db2e-08dda1d723f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VqGEUTqr3I4HGOAd9YetYtCLSQDhfRUWjWdUxoif2MR0nJCOl34AeNxN//?=
 =?iso-8859-1?Q?iMIY+UR6AwfsSmXmU/6SI8ClZIFhKC7R24ZHfxOmnnzeh36FPyAZFveU22?=
 =?iso-8859-1?Q?DWFFVrFqtOuKNDvQiEfX8SSGYVYjg8Nanx3wn1EwOOznJIaYwjL1ehFeCh?=
 =?iso-8859-1?Q?XwFF758axKbmHDDQnJbeWZ8l5lSdatT2blj0hgQyPvae+fJDyixpKqxUUd?=
 =?iso-8859-1?Q?I4aJJHHerzBXKY8Np/ZiHMZ9aLkCby4QpnSUMOv4L3R3yzjzq3s8aDx7G9?=
 =?iso-8859-1?Q?Y0IpjOr6/yJ3L6/0IU+fnmh9Ysa7QR0csaT8COyHRVfSyhVoLSZeejpUSD?=
 =?iso-8859-1?Q?mkpX3kxLK6KSMRVBbXcK2c1RmpqcRueCtsoSiu6iQHfTPaYTpxB2OAc88H?=
 =?iso-8859-1?Q?o0tgtvjAsDtQoSzGFb/diBokxV4w8u25eez0s3qPpA34R9zPekkH3ZriD5?=
 =?iso-8859-1?Q?Nk/0Y3wH8sNkicPi2muGJRsMkiza/ri8i+j7oKAAip/N4mJ++y0YwV6knF?=
 =?iso-8859-1?Q?YYnzGJNP6Km9ShPL450v42rgLWdYgG+rJInhpra+qvtcYNPXJ+hA+0SqDX?=
 =?iso-8859-1?Q?g7HP3EhMUSXHnf087X2vivUfjHzsJsaljtUYnRELM7OqmRdT8/zT50kifG?=
 =?iso-8859-1?Q?ZcJJhmwsAp9gtEgMta5terqPQRtBFBFyfJKnoOb171/yCenOtmwEMmnQ78?=
 =?iso-8859-1?Q?caoc9BIRjUTsZhk/jDCFfR7c+HJCfNa2OgUsLHnd1+7yG2tW5rUHkSJSX8?=
 =?iso-8859-1?Q?bHxian5Hr0YEC3HthtxcWZuuMWWH8VpwfrAGM9U8bcsz09v8TwzHOY4UIx?=
 =?iso-8859-1?Q?yBn6M1IPYLGjMfJxATZrr6Ie84/nZ6YiEAnTwBYfQhxp2r+Jy8CXXtdPd7?=
 =?iso-8859-1?Q?xlnTes4WkP4gnarKBnArDNNR4BEBlYWNivEp6/OX7ODjz1nqbE0sh2RGHG?=
 =?iso-8859-1?Q?2y0P7+zUzkaomuX/n7AF2i1RkYFK9G6lPEHvzN5Qb9KEwXwU8HxGTTHb+0?=
 =?iso-8859-1?Q?q3fCn3hxpLekr711q7ZikkqXmu3rBugIRo7paYdMQid6Lza7Qh969LsW/0?=
 =?iso-8859-1?Q?AJrkM5+/3XDdgB202WMda8KoeBdbyPWrLlizBcTwCqKDVMmLKaubN+l3AH?=
 =?iso-8859-1?Q?qqNbXh6Vr11JDj9I/BwRv1Ann7mATC8LqVkeLqygrx9R7DZk3RruhrdJYD?=
 =?iso-8859-1?Q?sP6fuoC9UN8dnvScXozSOAruqGVj3LLi8m9jPEFwoAS4pE3hXcYWuEVk/6?=
 =?iso-8859-1?Q?78TjGkHBgWCJL8XpXW6dAl8boqyjfyUdHQay89FBeRJTyfoYVSSdIejKoX?=
 =?iso-8859-1?Q?wPUso3hq0lANHmkEik2Ad6I7+ncYN4iSgUeNnZutVidPjmnE+JxUl429Kk?=
 =?iso-8859-1?Q?05axEBgxg6TN0U9+uhAgy2bpjKoZTh6ZRAInzZwhVdg8Plbuz5JpQro5EQ?=
 =?iso-8859-1?Q?2QS3lDfNbDWXaTM2zwCSPQ9VcnrAZl6mcvwE/YvR90TJbMlMpo87lZ50u0?=
 =?iso-8859-1?Q?9nxAV3qeQ35GHOK0525mbmMSg5VOljc0wGBaTBEI6yBaabGA15CCTiUWOm?=
 =?iso-8859-1?Q?B1cacgg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gnfYoJb23NCl6jm/4FzKPNEwSbrSjlNmnwajI5+zksklcU+Xf8XNgz2J/x?=
 =?iso-8859-1?Q?O9UtVFSfFD7PHx+HND/57ODt+kVpCzq1bYZIydnKnCi0bnXrBQfxkOtsw1?=
 =?iso-8859-1?Q?rmkZxXffeDnlAOqlTdkVWvjrFWT2u3ntDZMnJChTLA4Ubg8etH/H4TJfrx?=
 =?iso-8859-1?Q?JN7/NR2qB1jZ86iKliNZY1oGBTrTIz/akDqETJzETgAGN+Z/IVNez7YtDv?=
 =?iso-8859-1?Q?ZauB5FQv5Ux+Fc12wbQ923xvkNFotd9ORUB6POwQTqVb/XvED1j/EDCuSI?=
 =?iso-8859-1?Q?Pe89fUVAGG0G1bCIdSqlSUCLWpzg2yCycVwukGBwHAcTco5e3drXamqars?=
 =?iso-8859-1?Q?UrjjRZHp5wAem7K119ca/TrHpBGUF7wprxZm66bV7+cHjtpM9Mj6gWBz28?=
 =?iso-8859-1?Q?8kv6f9Lr1Qii3B0KjuXA7eZ2A76VqoGZKPcwNeeONlTzd33dSB5sphwDYR?=
 =?iso-8859-1?Q?bJlTquGCaZalctXIdWBcpfK4ikq0+fichYvxMRh5iDNPvB26gooJZZHLBE?=
 =?iso-8859-1?Q?vLymjFWrJx5jMGK4CvSIFzqzGBTn/tNXXNN8AtaVSSOUYFdpUMOgPN8T8Y?=
 =?iso-8859-1?Q?OPya3/gRQVqSHAKj1CNr3p4HBb4eR3KDPRVLz0ftnRb5om9GR/P6r13QKr?=
 =?iso-8859-1?Q?PD8MGRbRSC2cuCTspEgP5BE5z/aZmbBHJkRFbhTJajP4OAlzZFvGP3OJ9x?=
 =?iso-8859-1?Q?eSyji9sI8YixgM4oK0a/P8lnFDNzkrSckognm49IobqVIoWXS5txngR9L0?=
 =?iso-8859-1?Q?hGuKYjAk5zOXjrN+mNSzzBy7H5itMYfWW/5UF5jmhEMfGzfsGP1CiUHSJy?=
 =?iso-8859-1?Q?lMQIpNAIY38eepZC/I4LeuiJAnNWeqh0HLv90SG9AUCm06vQjofek6nlFT?=
 =?iso-8859-1?Q?v7QzK0RcZary9JRzPjgiWVCB1N8ume7vyFJ5rSXHv2OtToigCwS5GKIP2G?=
 =?iso-8859-1?Q?4/Rt4XJJap/qcFRhBmjTxtz3S9VpWJY7b8eaZRNlRHo4LVDLmnhHuwWTId?=
 =?iso-8859-1?Q?EJ0hxdeD3zbuUvCWWsm3ER326za0/XUi3yzrdr3/k8Vjd/zQH38jdb0+1j?=
 =?iso-8859-1?Q?ayXUQB/IF9fstR3tfpe3zF/8g6vF5ywNOZ/AqHCW6FOK+tALEuzPxSkIvJ?=
 =?iso-8859-1?Q?j0gdx2Sv6TcF7bDIHxmGVoe2x+aQb/Uch0LQhc25gyHf7hocug0pS4AXhf?=
 =?iso-8859-1?Q?WbdZlXeE8zKfksri7C4f7glLziVE+wbFYR693rqfAiS+PXLl1Wp0cib5Za?=
 =?iso-8859-1?Q?VnM64uUjXihiaok8UyceNu9JbXlRPWRKOpIC6E2gg7SdVnaBIe07ldpOjx?=
 =?iso-8859-1?Q?rhCl6pxd31UeQYjyFZI94tib3EHf3SW7fGciHoV6iLgZzqasRpAPX3mfv/?=
 =?iso-8859-1?Q?jCSte4souX41DNPmY87eQQQIvRmebXlezYpvMPzf+YfmL9/QQgt36TOgfd?=
 =?iso-8859-1?Q?3W3yTzqGLHFNykkJTqFoppjI7q4tT8gqqpMSVgaIiiTCMQ4k/WuLa7GISo?=
 =?iso-8859-1?Q?C5DZzTUOLkc6cXTMjIcAh0RFm6hUeXIL/zBwpgG4e1T2gAQ6U1Nil01rtM?=
 =?iso-8859-1?Q?jjLOGPFW1KZDTGJHr1LX72f6YVInqx6Awai9q6kTSwRr6NmQkYLke09UTc?=
 =?iso-8859-1?Q?+n7bJOCk1SAMipp47NlEr27lugksgUTzTPbGmnPfh1fv3u0gfaW07HIO9J?=
 =?iso-8859-1?Q?HplM2uw2FHU1Hhb+St8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f20baf-6619-4a29-db2e-08dda1d723f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:34.6696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDkKijRAgJmR+ahRQrnxD1Mcr6wv9WbPvgbeAcdyf7HiBZUQN2HicH2ln2duT8fOGLIj+T0IAM/fDuZFkLB+zkIsrS499Mj1tK7xG4H+mgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

This is needed for riscv based CPUs by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 33 +++++++++++++++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 10 +++++++---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..5bda02a179 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -131,6 +131,9 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, =
hwaddr addr,
         size_t hartid =3D mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return 0;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -174,6 +177,9 @@ static void riscv_aclint_mtimer_write(void *opaque, hwa=
ddr addr,
         size_t hartid =3D mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -233,6 +239,9 @@ static void riscv_aclint_mtimer_write(void *opaque, hwa=
ddr addr,
         /* Check if timer interrupt is triggered for each hart. */
         for (i =3D 0; i < mtimer->num_harts; i++) {
             CPUState *cpu =3D cpu_by_arch_id(mtimer->hartid_base + i);
+            if (cpu =3D=3D NULL) {
+                continue;
+            }
             CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
             if (!env) {
                 continue;
@@ -292,7 +301,11 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(s->hartid_base + i);
+        if (temp =3D=3D NULL) {
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -373,6 +386,9 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hw=
addr size,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         riscv_aclint_mtimer_callback *cb =3D
@@ -408,6 +424,9 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwa=
ddr addr,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return 0;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -431,6 +450,9 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr=
 addr, uint64_t value,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid =3D swi->hartid_base + (addr >> 2);
         CPUState *cpu =3D cpu_by_arch_id(hartid);
+        if (cpu =3D=3D NULL) {
+            return;
+        }
         CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -481,7 +503,11 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *temp =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (temp =3D=3D NULL) {
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(temp);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +571,9 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint3=
2_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..360a3dc117 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1078,8 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL)
+                    continue;
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

