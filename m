Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E636CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJ1-0003g6-Da; Fri, 03 Oct 2025 06:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIx-0003ej-5e; Fri, 03 Oct 2025 06:46:28 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIp-0007NV-67; Fri, 03 Oct 2025 06:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D30ZrppCwTMOc89stGfT5N/bq5rfSv+KP1KKHwcncjqjAOj62/5ujnId7cGxZQKk6lfGaCoBmHwEZA8AylknlkN1k1NCL9SWjc0imubmuJDsSFGbgNaheLHrmMHrQalkZdO0tr67DYPZQJcM4NuNWBQTCftA8azHiDcTDe6W2N4T2Bt1zA77ElQ68o9aJHfQ7IbuwCxuC3r0qSJfAZ1k0Ke2zmFg6CMjmpbka8M6Es6CL9HD+g5/ERESNVOVC7T/KGmUCF5OmfZY4zOZRO0eLCad4jLijU9VjEoljDLzFQ6xuEwAMAIKZWfQDHiFmui2L15Vx5DuKOJt1X6RjD4s/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv6qRkxIpSccT7pe8kMFRi3d/R9YvqAVAvCexWx9Cvo=;
 b=GbiTWwuJehNQ7cK15iV7WDx51G7hNVwsjRDHduHNkEnwpdX7BXTa+c0x/ZmZznS2NzW4PP42upi9t8Z9d2cU6ArZUcfQu6aracolSAUzRaNlxa3V25i9NCsszbzuUd5cvSOutJhww53fPfmi94fNIxxRKfIF1GNdrsu+SeyRJnOom9fVI7x2NElefeJhxOs/oEE4vL79XNaCdzsgum17lWWlht0N01M4ac9fXzxGK124lQHfVZugff0t7mFo+wruYNDThbrPztmbS4Y2+QSWMEDX5MxEUcKfmn6zUa1AVebyyp/zngqbFYMCneXU8AHaXZ+i28VqpcG8HVVlrDRJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv6qRkxIpSccT7pe8kMFRi3d/R9YvqAVAvCexWx9Cvo=;
 b=FdvTyuF3gfeNXeU8Ht7uIRNiSAaM1H2uJr8EdOHDg5TY5+MAysuAREVsV5auql9xMoe1MlhKndldDiNrPPOmgba3En1+Fcs4xdXyUnSi8Max44V2LPsX1c3sK/TFO5OGvcgAnJaVdqfxfbXEYEJ4hszHgTVZ1PR0y3hSSpTE53dAojLOuQTv6ljtioaE+lgoZvTV27NC0eG5EcJx8GjuiaSENARd9vLKmqqgc7xYcnQSElJpnims8eUsosTyTsj8agr5hb72z96h1xI8X5Tc1kteWnQI1oD0RzMf5wuTXjPbiDK1B69DwBG8DQ5Ll+Sb+pzHjYRmhlOnUh/VKlLxRQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:21 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v10 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v10 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcNFLQ6ifzXoIEK06Qsg+bPHh6Vg==
Date: Fri, 3 Oct 2025 10:45:20 +0000
Message-ID: <20251003104443.51501-5-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 97fc2971-8f1f-48ac-24e4-08de0269f34c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8ue/2UWl6ZfTtHffnbqTW8jirw8IxjyGKOBBqx2H34w5NTQmIcv+55RzQB?=
 =?iso-8859-1?Q?2MugKwr83ESouckXam+xrEEfXGY+O/A4xe3zMCo0bPRibi2sPR1r9nz8Ux?=
 =?iso-8859-1?Q?7DF8UdzZdrHhtTdXBKz6m7ckdY7IZkTiIVIR0C/bCAusJm3lcbRP7vXI9D?=
 =?iso-8859-1?Q?F5oQMubtEW/tofMEPtjLGmYsUwD6uw5kVbEHVNOZ4RqHPMoeictWHsGAdr?=
 =?iso-8859-1?Q?Qb1RSJNTUPuvfEPnlP2BNeQGa4KA83i+rr9fTxTsuQt3MvnqBTwnJVGHKo?=
 =?iso-8859-1?Q?Qdn56UhSFNOAvX98J1HIBsEFwBbmaxNLK8g+okOgf0kiy3Mz/4j9N1A82d?=
 =?iso-8859-1?Q?Q+Fjx72eyUpcQVlv1XRK+dUW4a2uXagB22PJvYThiPRrlNgngWgcuR8utv?=
 =?iso-8859-1?Q?MUxw7ibl5gQ9MA2hOJRdhVZ/6ukUtmqZbJWq2Wtd+ARMJZuEEZvm85xTaC?=
 =?iso-8859-1?Q?MfD61iyS/fMTewZL1K/AG7aBPOvJiBGwtq+uc7jSIaUmhmzp4l9dkoirgW?=
 =?iso-8859-1?Q?kB/+eyHBo4RRxSoo22b9ocu3QHG6qlxItH3wOykfbiVqgSy7jIFUJCvBXd?=
 =?iso-8859-1?Q?D4zI02QFhxxrFTu2kSXUFHRTKwnePLU+0bJmsiHO/ckyo2bl7fn3TqSe1i?=
 =?iso-8859-1?Q?soGZDLMepFxHBvWDH8lKRoSE9RMrRYNTX715KodLkX0mD7gWsNiShdZmJN?=
 =?iso-8859-1?Q?0rPvoKTq95yyVycKx+wV+8F7Q6cBX6u7kEY/fsOh8lZvK5Nhfn6n6XeGgr?=
 =?iso-8859-1?Q?hW1j4rs+mFaVRdhnC7FCDbGcU4K52TZENckxA94ZMkEmMsncr/uqm1tO3F?=
 =?iso-8859-1?Q?I4PGwE6I1/rXtWAXIOnVqne2U4NLke7di4iSeyVU3AeZbd2G0Gc0RWBXtN?=
 =?iso-8859-1?Q?OFRZjJ5A2+VZk2AyTqk+FabOTADtPRTqL4/iDa3/0iDLyGUvbXZCu586P1?=
 =?iso-8859-1?Q?PdyMs03MF4BP90+Qd8uGZ4xcPUcfgb9DBmwy15kYfI0kli/1Tr//vQDE4B?=
 =?iso-8859-1?Q?G1bxUYrfzbwmHRh8qBj3eaEEgCtiuB/nPjrInzr5c0CScTtI0vMTLUhsdi?=
 =?iso-8859-1?Q?RpOj+Zeuc6Mq8L0vg18mmG/9Yjlbk48obzkFKmfdezFmStjVMECqkX0o+B?=
 =?iso-8859-1?Q?CjyGeF+VfTz6HLGLpGM/cAzLFJBfBrDJb+ZkejEpLr1Ki7eQaoeDp+b7FH?=
 =?iso-8859-1?Q?1ymEAzb+LBOmPSPWLY6+gu2iGBRgVukFz0Xy/egFA2wy3H3O7VqSjYmXof?=
 =?iso-8859-1?Q?n4AEohaUApOnOxp2d5g500k9zD5Ij5K8l96+QADS8RaoO63uQoq7rmVIwV?=
 =?iso-8859-1?Q?fUSfNMcbBNCSrEeQs16hmuI0QiuIRZPJhF0Eomvpdao3YEdxHa5WN9pYh8?=
 =?iso-8859-1?Q?I75ORDhUbjx93lfbggEk5s8nUR/q5dfwP0yeWCm7TnRUWguPfovkMJkDMB?=
 =?iso-8859-1?Q?XfXrsxsMulvzhXmrwx5DYCsDzOg+Xn2d2JrtHxsiOavc7pMrTF9lUWKPzH?=
 =?iso-8859-1?Q?U1IemHazbtBK/r9fPq3M+YwmkLw+KDguthF1l1WN07LHXfJkXQeRmGdwRh?=
 =?iso-8859-1?Q?muXsrSRnm0Y5uNgcieTHpgedJ77V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z76s+vuuMQa+BFr/8/AuYa/zd1HSEgVIqu9l6mLzPWe2EAZm//3UVbAXh3?=
 =?iso-8859-1?Q?RzcZiRu68aovWlHNjWIH5KkpRcJU0jKHfVV8J4uGhYCX0f/JbXI/wJNz6D?=
 =?iso-8859-1?Q?HDdSLHt/WZYoC+8Bp1i39y+YnOn17hGr64Ak8G8SVvLx/VL6gLTG+WCQ19?=
 =?iso-8859-1?Q?jzmQ1kFCfiRrHlne/WdC3jlBSBIlIqNK8Vbr/4wi8az2d2GVcjHfyYqZpx?=
 =?iso-8859-1?Q?jpjeCk9JcN0NrW2HkNVDnNCt6RAzQvxVWhSYVQhEjDYw70KIYoQdcvQs2P?=
 =?iso-8859-1?Q?U2yZTN3Iq0C9g6QT6TsDa8eZj/7kDw0Vd1MN/5mReMP3qncuxvyl0PP/Kd?=
 =?iso-8859-1?Q?Vz1WU+Vyn7Wh9nmSnrKA35/0yhaxaVsY44DGwBOPlptGqripHaPEzcw5uE?=
 =?iso-8859-1?Q?lSN3df8S9159o18DuD2PW1Dj3skUf1CJswYyTfXFqsKExSIfXShHfeEzJ6?=
 =?iso-8859-1?Q?tFgOO6FIGD9dAwxF94+MIRgafVdcP/nY8zGGvDhHdIbR3eDckoeWADGS51?=
 =?iso-8859-1?Q?Ct0sd52nBsPtzkRHY8uIClb3umKOjsvAWT/QmvDXv1fLW5jcHSbsAkFvr5?=
 =?iso-8859-1?Q?WMT6YIByjDNFtbWNDu5Yvg3AjWeQ8fsCL/HGA+3xhuflmgwBrAOZnF7N3K?=
 =?iso-8859-1?Q?ypRRi77Ue+qnF8MKG2kozaLPzNXjbOMRq6QHkJ8n2E55noZyxkmFJl1W/F?=
 =?iso-8859-1?Q?iN57C8FM4E2cpSHQiRPgBB4gI2q/RRiVRvcE6ewOKNbg5TeSp6SGMvYIN1?=
 =?iso-8859-1?Q?acxIibhkwC74s51E3Sm+XXNevVeZlB5bfSRSDofny1ihvEpjUFzY+N3dMh?=
 =?iso-8859-1?Q?DJVYvd7Z6aqqQlKULe2ae7aCM1jKkTXE8jCU4XiSeyAG4kVhbgRZx8pWsC?=
 =?iso-8859-1?Q?MRYrYq/2mYmAAFcUYbUZlu4No024jhvh9H7HD2AYyzlasjVhequ8CqVyyr?=
 =?iso-8859-1?Q?PAWjFGfstA9nNZDIPPkdNk19jj0t1dO+3oewr0cP/YfG/sPOQJJE62yvH8?=
 =?iso-8859-1?Q?guP9fNzCGERfi7Xp5gYDc495nsS3c8fKBLQOtBq2sOZuj30HJkePRDdd8N?=
 =?iso-8859-1?Q?UJebFrdfBcDlubAjrP3IeyrMj5I3yOnJoBrIkkbwmkFE8Qp0BTgc695QNW?=
 =?iso-8859-1?Q?ei5E6zb3/0hmBD+VVs4zUosr9kJA6UV9SHuMqQtfl46+/Qy5Ifoq9uc0/u?=
 =?iso-8859-1?Q?IFRPkgEtq+NgmQfrv8NogmrLKBwb6jFO07S8Uqo1RSKDJLyd8v5DOv3Ac7?=
 =?iso-8859-1?Q?Xt6FnfxCfadM4aEzeHz901mDWZGtKAlWTQ68/2ATO9ncFtjknawNDywDSx?=
 =?iso-8859-1?Q?ieoHr5AG32YXUgaxI/cnn9LOmS0HcpDv8a7sPCECyO5CmPWTT/ei4QcQUL?=
 =?iso-8859-1?Q?w9BcPDDMA9W7kvRuuuyunqdF8sHSpZJN2hI0GA8F0cp3n3oSulzN+xVoEY?=
 =?iso-8859-1?Q?Kzsp+BuO6bPGnjjYbG6Fm4htzl4fgyhPZ3cteKbh8Xca0n0Xjdzag3uvS1?=
 =?iso-8859-1?Q?9790Bm2J6gSJtBH/2UoTDj2E226K5A1HDnvqI1gXRFBPT+yMqNvIdlhsbV?=
 =?iso-8859-1?Q?VbUUNUj77BEwycQlRlWHNPmW82hKg+hdUB3MTwS9PTJBRS1V/33z/ifAXA?=
 =?iso-8859-1?Q?ZZzQIrhDzNn8Lq4YcJ9NiPWeaPg444+9FJivt5c5weuIMx++v10y5WvyC5?=
 =?iso-8859-1?Q?q1V+/OQyqZhmTGk7X6w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fc2971-8f1f-48ac-24e4-08de0269f34c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:20.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FE/XA3FNhwrMpFCWDvOFwrjcC7P37+vUzKB+JiUdrG5AbYypGvrY/ESDzyBawtVr/dYE5tp4p9mBkqwwUBUpvYXG1jiQDUKJmToBwCQjwSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bf1b9e33be..a7501dc77b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3296,6 +3296,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
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
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
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
+    uint64_t pmacfg[16];
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

