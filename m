Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 15:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seGJV-0002yO-Md; Wed, 14 Aug 2024 11:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1seEjJ-00041v-Fs; Wed, 14 Aug 2024 10:12:02 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]
 helo=mx0b-001ae601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5956f96c7e=ian.brockbank@cirrus.com>)
 id 1seEjH-0001UP-7r; Wed, 14 Aug 2024 10:12:01 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E5j9sj020215;
 Wed, 14 Aug 2024 09:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=0xhPdHmXZmdAvWdp2m+ftoiBi0ikUjdHs7gqbB1tYLo=; b=
 jZKWn6FgxLStzJbBK+XsafvQw1DliLs5pbtqFgk1hwEIcVBBq9kLmUhGQaQt9Dmh
 m74k9r7+U91omFCwfqg/SuCAT8RD5Ran8E4/GnI2/u6auVek8ufoRcdbAhVBIXJl
 Lz/eWfVLKEC1tK+Q0CYUYX45CPRpO+f6EFmQLxo5nIAhqnakPvYbIUC0Gducyum8
 nC8u9DB3YjVarZmWqRvVh30qANJIhfWIVJQNItDau5+2Dls1iyNyJrDBzhpgfrt/
 Vng0EqYf8D6fPKId6PtMHRKmW3KPzuNamNV0DVt89tAS0d3ND4voNGfB9cm89QuV
 0HUT/1z4KW0Sh3JKwib9KQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40x5kwmnxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2024 09:11:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrS0gmsezEolbrcoAfcTNjbJWWBbHnGn4Ls4eKZhvKLjk/tEjOO5rUwkwAMUYoT1lReCfTeKRpa6yYe3xFJgTwN/zdIW2DuHNr0dP4BNuI+K0OBsmi0VP5Tr+On1TeMo2cupoYWMUJVARZrutByIQde21yeQ4j5Al72hn1xsCGXXtfHlL9d188m32XO6Ow7LGCNmITZOCQ95idSLQa9Vq7R7s9D3CBCtLakUhcLw9KgTYKaxriAlMl8XBoBh1DIkLn84SBqOOgRv/22f7JJ24+7ZLGBX9xHdIfGKFa113SlhAuO52Q+bT9DSywhZU1gPSepuiQzLBwpEwWNEtCXY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xhPdHmXZmdAvWdp2m+ftoiBi0ikUjdHs7gqbB1tYLo=;
 b=ZyV8aK/zdnE5wG0GPYzpoe9OwvSfR1NstNOkEmTdrQwyTWJnL4Q1oAJ4rYIPZ/0hTfrEm1SMCzXRm81Xbz4aKgAKKrymP3MW62gdwPDFlKYD1XYUPswwSkcbMbTUz5VtyvJPPYIqhvhQ0ADkV4bVDwRbAvW3SuJuJWEPZSTSG3fugOY8beUbRCVPIuf5ILIBAIuXcbCMhTzy8aRWsDlT3KqnJXxBfsJCveujoPsd7Zac+OhIkjsUN2hfCIp6knAb+VwZrh0wxl9hdOnHf9pAiKumO15D2FoFVtXD8phhQZywkktszwm3Yu/iSDtlzoTcXx18TnxA1He2sFX5Wfv2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xhPdHmXZmdAvWdp2m+ftoiBi0ikUjdHs7gqbB1tYLo=;
 b=bAGDd7zTzeKR7/Pln6aVJgMQJ0U1XTHnNJd+8fMNqFg40CdMbcJ34bLFRfSVKTY3Ng5G4Jue6Utg+3968RBGEOoQq74svzdpgKfumOMK6V+DTPRAFcZ4q1UmBtMboBtJE+IF4WHhgAG4X0KbEjQX4lLggQoJ5idhxz06iageAh4=
Received: from PH0PR19MB5193.namprd19.prod.outlook.com (2603:10b6:510:96::22)
 by DS7PR19MB5951.namprd19.prod.outlook.com (2603:10b6:8:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 14:11:42 +0000
Received: from PH0PR19MB5193.namprd19.prod.outlook.com
 ([fe80::7e57:c9bd:575b:48cf]) by PH0PR19MB5193.namprd19.prod.outlook.com
 ([fe80::7e57:c9bd:575b:48cf%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 14:11:42 +0000
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: Ian Brockbank <Ian.Brockbank@cirrus.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH 00/11] RISC-V: support CLIC v0.9 specification
Thread-Topic: [PATCH 00/11] RISC-V: support CLIC v0.9 specification
Thread-Index: AQHa7iVkq0n+hCrii0a0WDxdf/aSZLImywcw
Date: Wed, 14 Aug 2024 14:11:41 +0000
Message-ID: <PH0PR19MB5193D8D5C670FA4C11DB684780872@PH0PR19MB5193.namprd19.prod.outlook.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240814083836.12256-1-Ian.Brockbank@cirrus.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR19MB5193:EE_|DS7PR19MB5951:EE_
x-ms-office365-filtering-correlation-id: a7d36d33-7875-4d4d-f2db-08dcbc6b057f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?62Is0Rr1fFONVepzgtW4Kf8e7oYZth4Cv61JOElrdvYDn1dPIOheHG6m7UGE?=
 =?us-ascii?Q?Yxu1RWKwgaSmJsvDyr31RPeU1DaqnKHdx//1TIVhUdc7MxspkKdTK4zS+XO3?=
 =?us-ascii?Q?sqVpXB2mGrODLfRkBExTBWHczOfd8YpFhBrVKtT773GL2bQhZDhi7LToTIYw?=
 =?us-ascii?Q?R5Ld5Z+VKYDpCvFdQ9VMQ7tnPYEh0aDJzWbOIrGWdqIqJGxvlYZMFKiIU5zz?=
 =?us-ascii?Q?MXGaw+9HHvUl9GnEvvXS+8MzMJplfQ7H7qNgpCfRtdQDGwSRfcsevkp+MLJC?=
 =?us-ascii?Q?OJNhNoshFa+DigWnQatfek+knp+pkEEVniUlSufje1hR9bF227Z4y32j6ObG?=
 =?us-ascii?Q?WIxYlvOa9v1WDvhE29ZPXaWxg0VroVDqIn5cpxlApmGgAlf6ySsqX3rFyOHx?=
 =?us-ascii?Q?MS2grHos2py3n5UO9TgImYyyHFKsrCmN49VJ2WiAZ15YAXfQziE0FRXmNuj/?=
 =?us-ascii?Q?7Dhjct1JbXmqEoYO4aq9cOrL8bwHqHD4xe5SFoVP/c1MfX8UOHfeUtuUDLOy?=
 =?us-ascii?Q?0I+fK51ydb3AXrLyZJahOVbbj2L93FnOEyV81FcbJ7M+p/ghRal8fEo+5Ybl?=
 =?us-ascii?Q?CpjG97pxjEYvKmTf1W7DkKGwju9E3kNHrZmjzRPzW0L/wIEf932jt4Q3WaBb?=
 =?us-ascii?Q?vIv5W3XTn0lbvmX5Lvf+kGcRCXzm9XU2L97SIfETSbGxpo/NdyPjHXpRbflW?=
 =?us-ascii?Q?eATo0wEgC8CLqZFDqyCywyuHy247jQyK1bnG4XbesRCRtt8Z5Ah8dfapUWdB?=
 =?us-ascii?Q?KXc93k/60zE5v2YYZ+agEkAntMTBLJ4HzVL43fvCeuT/b4TrFlAsOaQ/p46q?=
 =?us-ascii?Q?Syu18h8uLpArY/1SVD7mWH0oR+KAFflUfYkFIuxGahBCRsix92msrwQCGHkB?=
 =?us-ascii?Q?J+sR82yA1sUMvbxs/Y9le4cXe0oJm+NT8s4GLH3Dq850qdiwq2xePvdxEN6Q?=
 =?us-ascii?Q?Sy/6GApZsYohIBsNjhojoWz43EeTNIgP0wBfuquCakUOwmEq8f63P7BiBWeA?=
 =?us-ascii?Q?V2KDqEmwqH9d+1UKlCBefcdUnPfVA5kSTWGtu3GJrroarSBS6l01d6yHzkf8?=
 =?us-ascii?Q?0lTPTbd+ITFiHUGKwS5aTeNkbR4NG1fthsGKjGYacaWQst19YASVKSqrPJol?=
 =?us-ascii?Q?h9YxY9OU6CZBsSduuFKEI00imvCVy5kjr4O/d1Uki9OX33xwMUQdTfG+ulRX?=
 =?us-ascii?Q?6QddR18vyeLocSWhga5fdih58LVsPq8nS9H1I7uCHC1in9tygQRPU4/0dqOv?=
 =?us-ascii?Q?Wcb6TAf4CQiZMbhRu3aJvxnKZolmBxH+r0UHJ/dyWNbAbLfYhrU8beTA6gWN?=
 =?us-ascii?Q?NU0yjYH8ipMVfavAObl7wGNBKJo97ljW1k9U5IcAt5CGy8f96rCxJtZSf/x7?=
 =?us-ascii?Q?6ZTuMss=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR19MB5193.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MRIal/3vmbFWJlbHZIL+BV3kfuwuYnnGhJg6NjD3NJ6qvZ+jJBjg3do0tVWC?=
 =?us-ascii?Q?iBZcnvDoZS+7FotCus2Z0MEm3uKnZVMToEZ/YUzxHhmC6BEaDvflxjXSwynU?=
 =?us-ascii?Q?kmRY/fHzxxzn7Kw/jnCP+rXTGwbSLuUYdIJ9WiFYiyM6c4vGcYIQ1WrGrTj1?=
 =?us-ascii?Q?A4I+0s0j5Tf3oD9p5jWHdn9IKJ1JIr29TSzi7hl6Y3PFcx45V594/Eonz4Bt?=
 =?us-ascii?Q?VZi4Eg2DuzeI6X3NJnyffDDjQ6LaJXqeDRDofotgn4nEuSx/ABVyt8uRQeIU?=
 =?us-ascii?Q?cHjgDvAIMXqkwGOQ/kX7LI5lkdqj31YZfBGSUQsa0W7OuQDqXHRd0xGzsRL/?=
 =?us-ascii?Q?U+i9LSLAPPG25X0+C09h8y5NgWwoS9tLQJs1x2/mcVxhlPHkxPpNz/JZOyri?=
 =?us-ascii?Q?ehQyM0nTyyLjw6qjkEHvu3C8saAcmxA6HbaSkvuFqD66vsJQ/2FBdI6l233v?=
 =?us-ascii?Q?W/BYdHrlM0tMEeEqXKWZbocQvcck8OowCOSk+Tam4dVEC0F6zE9iAAqiiWIS?=
 =?us-ascii?Q?N4YvhmEJbXspCQB1BupU8tWo9ILDeZlZtwma0P5cssfdQyoSkCgAkI8wTute?=
 =?us-ascii?Q?sQ0C253WJoegujwGBRm6uPaQcTNb5wExwEiDxzeNU4ZfeaQORjwIXCEq59XV?=
 =?us-ascii?Q?B94CQEQdW04kA+IQyapNaDvycPkNPxMnrX2gNgt/S+ftIzQSBRH4FwfL155n?=
 =?us-ascii?Q?CWO2qAThOxFThAGYikAOqtontfdXeItQBdvXnUXu1WVvo/Regm5JuCKjS42i?=
 =?us-ascii?Q?Z6Yld2YmjFXIYW8VCxK1siPQ2saJHM9duOIcYf58NRvmikk7GcmaZCaTCYeP?=
 =?us-ascii?Q?4qn+D7q10Pru0qnXEe8HMMC2JchRQ+/a+iMo7FMYOxHYxmXVjdb1blj4M3/f?=
 =?us-ascii?Q?9+c8SwfhtGTJqRJsteB5n2FYrsjzEYMD3JxabV9mEzmYfdUg0PX7uo0ervWV?=
 =?us-ascii?Q?jBEco5TAuCApOVFE0Fohtzvu4juBMBZZPgSp3im6kPPubb15qwyPbUFPSu0C?=
 =?us-ascii?Q?gBaI0+L/mB0Vgn82gGjT0+L38u3o4T/N5e5ru+cX/IJoG4T8cniqQ+w4wzfe?=
 =?us-ascii?Q?t3uopl0hPZP/Nb3S8tEqK+j0+EATd6Laic2OOvoCri0D7fwMvi7enyCZ4EB7?=
 =?us-ascii?Q?qaYjg0N2viDld7zMnNFmdojd/iNhtxrgack9DH9XzLSvqgMLAI3I3CqZuu1D?=
 =?us-ascii?Q?To076M1KYIBJ6s67BVz4c36av2pmmMZZdp+sD740q6TqIKM9bTrFlwKYIWka?=
 =?us-ascii?Q?6v0jX4lNxtxmp5oKlshRIiiDCBdA+2C4fYLHMAnTHGsJgpdeyPIv1Pxsf0ga?=
 =?us-ascii?Q?mOoHSWXpKy2HMR7C4psXkH7ihuaF84M9cZFxxETpAP6n59mt3rr2rbr5gyJO?=
 =?us-ascii?Q?LV/PO/poKtRxOSCZ2tZ1Vd4snc1jID4ZTN8alTCORYID58uV2SV1MwV3Cgek?=
 =?us-ascii?Q?xiWBmzsJNZKoEy5hS9JNgt0vm7xxVw6g4il5XvxNMbMdh0rK+gnBlrrnvUe1?=
 =?us-ascii?Q?Ik6Cy7pr4v2twrlJacRD/41KLXAi4b+P46j5yJ/jofIZsJZvX2DifGcqelvk?=
 =?us-ascii?Q?JPlb8LueRqp1d8gAt4gqM1TwnkjW7kbVveOfNPIf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB5193.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d36d33-7875-4d4d-f2db-08dcbc6b057f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 14:11:41.9348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPtBip9uRZSRVrk4CjtfHdROp262YPG00GUA10TMtpR5JxNXnYpQHfJ+HRuoA94jJ65cwQLZGI7f4K/4Q/iSUK7ScnFm1EOkD4BAO1/3muI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5951
X-Proofpoint-ORIG-GUID: kz-WcyeHZjX9KMAzdARnkUt0aOuE-FSj
X-Proofpoint-GUID: kz-WcyeHZjX9KMAzdARnkUt0aOuE-FSj
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=67.231.149.25;
 envelope-from=prvs=5956f96c7e=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Aug 2024 11:53:28 -0400
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

Apologies. Please ignore this patchset.

Something seems to have gone wrong during the preparation and merge to curr=
ent; I am working on a replacement, and will send v2 once I am happy with i=
t.

Ian Brockbank C.Eng.
Senior Staff Software Engineer
Cirrus Logic | cirrus.com | t: +44 131 272 7145 | m: +44 7554 008061 |@badg=
ertaming


> -----Original Message-----
> From: Ian Brockbank <Ian.Brockbank@cirrus.com>
> Sent: Wednesday, August 14, 2024 9:27 AM
> To: qemu-devel@nongnu.org; qemu-riscv@nongnu.org
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Alistair Francis
> <alistair.francis@wdc.com>; Bin Meng <bmeng.cn@gmail.com>; Weiwei Li
> <liwei1518@gmail.com>; Daniel Henrique Barboza
> <dbarboza@ventanamicro.com>; Liu Zhiwei <zhiwei_liu@linux.alibaba.com>;
> Ian Brockbank <Ian.Brockbank@cirrus.com>
> Subject: [PATCH 00/11] RISC-V: support CLIC v0.9 specification
>
> [Resending to include qemu-devel and add numbers to the patches]
>
> This patch set gives an implementation of "RISC-V Core-Local Interrupt
> Controller(CLIC) Version 0.9-draft-20210217". It comes from [1], where
> you can find the pdf format or the source code.
>
> This is based on the implementation from 2021 by Liu Zhiwei [3], who took
> over the job from Michael Clark, who gave the first implementation of
> clic-v0.7 specification [2]. I believe this implementation addresses all
> the comments in Liu Zhiwei's RFC patch thread.
>
> This implementation follows the CLIC 0.9-stable draft at 14 March 2024,
> with the following exceptions and implementation details:
>  - the CLIC control registers are memory-mapped as per earlier drafts (in
>    particular version 0.9-draft, 20 June 2023)
>  - the indirect CSR control in 0.9-stable is not implemented
>  - the vector table can be either handler addresses (as per the spec)
>    or a jump table where each entry is processed as an instruction,
>    selectable with version number v0.9-jmp
>  - each hart is assigned its own CLIC block
>  - if PRV_S and/or PRV_M are supported, they are currently assumed to
> follow
>    the PRV_M registers; a subsequent update will address this
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation
>  - PRV_S and PRV_U registers are currently separate from PRV_M; a
> subsequent
>    update will turn them into filtered views onto the PRV_M registers
>  - each hart is assigned its own CLIC block
>  - support for PRV_S and PRV_M is selectable at CLIC instantiation by
>    passing in a base address for the given modes; a base address of 0 is
>    treated as not supported
>  - PRV_S and PRV_U registers are mapped  onto the PRV_M controls with
>    appropriate filtering for the access mode
>  - the RISCV virt machine has been updated to allow CLIC emulation by
>    passing "machine=3Dvirt,clic=3Don" on the command line; various other
>    parameters have been added to allow finer control of the CLIC behavior
>
> The implementation (in jump-table mode) has been verified to match the
> Cirrus Logic silicon (PRV_M only), which is based upon the Pulp
> implementation [4] as of June 2023.
>
> The implementation also includes a selection of qtests designed to verify
> operation in all possible combinations of PRV_M, PRV_S and PRV_U.
>
> [1] specification website: https://github.com/riscv/riscv-fast-interrupt.
> [2] Michael Clark origin work:
> https://github.com/sifive/riscv-qemu/tree/sifive-clic.
> [3] RFC Patch submission by Liu Zhiwei:
> https://lists.gnu.org/archive/html/qemu-devel/2021-04/msg01417.html
> [4] Pulp implementation of CLIC: https://github.com/pulp-platform/clic
>
> Ian Brockbank (11):
>     target/riscv: Add CLIC CSR mintstatus
>     target/riscv: Update CSR xintthresh in CLIC mode
>     hw/intc: Add CLIC device
>     target/riscv: Update CSR xie in CLIC mode
>     target/riscv: Update CSR xip in CLIC mode
>     target/riscv: Update CSR xtvec in CLIC mode
>     target/riscv: Update CSR xnxti in CLIC mode
>     target/riscv: Update interrupt handling in CLIC mode
>     target/riscv: Update interrupt return in CLIC mode
>     hw/riscv: add CLIC into virt machine
>     tests: add riscv clic qtest case and a function in qtest

This message may contain privileged and/or confidential information. If it =
appears you received this message in error, please notify us by reply email=
 and then delete the message. Thank you.

Cirrus Logic International (UK) Ltd and Cirrus Logic International Semicond=
uctor Ltd are companies registered in Scotland, with registered numbers SC0=
89839 and SC495735 respectively. Our registered office is at 7B Nightingale=
 Way, Quartermile, Edinburgh, EH3 9EG, UK.

