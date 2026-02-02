Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A39E7314C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 09:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmq30-0008Eg-1b; Mon, 02 Feb 2026 04:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vmq2w-0008EL-SK
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:16:38 -0500
Received: from mail-eastus2azon11010058.outbound.protection.outlook.com
 ([52.101.56.58] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1vmq2u-000384-6Q
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 04:16:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6aA0ChUPla7hXDMDyNhQcsuStTAUsR1gRsSHkSjJqEkRwMD6kYU2v8TgaHo5m83UnyQPiqBn8oyNb04ZkDiJguMt0a6xphUQGDGql5MC1D6nV6v9LG8jZRRbY01VuvPX8gGHZxI9vpCSrB9roHv1FS6VSHrxgRwHFyRZFWShxNmvvG7AAjXiUN5WZFiV9WLkUCyV1r7cHcJCaOSdsc6+Zzra76M1ja2OML+8CTUVjaa3L7yCDUbWMhHPjZyj42bq5IXTTDMkPN6XsDEQExILxln4XctSymKKlWDRTBT/z8UITkJ030h8ruAMYpvqMz0sPDvxEVUR/CNqRj6zPYEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc/d7Zh5X6dwQY/cMfPDk3ScT66aedDlOvLsVpRoueU=;
 b=gXlR5iGYb+Y285/GzDbI9d5DNWEna9ysM2iolX+pzzAylwBFe6ZRoEs+zGmlzY1J1nemE8LMQLgXni496FtmRix8m4/U8bKfLMfJvy5PxWvF+rfmtYzibhYB7sZrlp0bALj33zen/hNKmHdBFtYXZid7zZF1zQN7nq+Op3154sLFnhgQ8R009soR13QiEfevOyt1q5JzUImWpLXHfPaQ4QwyVbKrtJOFemMEya6vuETgAEv6WHG1xnuELmT5jP/voPETrggiDIYyA7ioT5J91U6Q8ftDLCZm+ba2Tidh92mSr7cBE8Fjft+QfJANAZ42B+oBvjaflEkKuZNxGgxboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc/d7Zh5X6dwQY/cMfPDk3ScT66aedDlOvLsVpRoueU=;
 b=DiMXB2NmScXA8nQaoJQth8vHqoiWN0aPDJpxwTiFgpjqatKfux09XdJz1CKJKq+CbHP6MTqYKmuFeI8t3JKchiXkJlKoEUp5mbdVJv+0sDpfjKH8NFo7Xk8H8hKAnFDCa1jKgy1pQnrkjRMrTwesva7OEzkWLdVtuonFhnkkGjY=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:11:29 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 09:11:29 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: Alex Williamson <alex@shazbot.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Prica, Nikola" <Nikola.Prica@amd.com>, "Andjelkovic, Dejan"
 <Dejan.Andjelkovic@amd.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Topic: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Index: AQHcaRi2j570A1RdCkK75QZWVlfQIbVO63qAgAyNN7CAAACt0IAAACSggBP72cA=
Date: Mon, 2 Feb 2026 09:11:28 +0000
Message-ID: <CH0PR12MB5283A1315E28D8A347AF222EFA9AA@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <20260112091641.4d86d8e5@shazbot.org>
 <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
 <CH0PR12MB52839D25259B76151B3002ABFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB52839D25259B76151B3002ABFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T15:57:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|MN0PR12MB6319:EE_
x-ms-office365-filtering-correlation-id: 1d4de20f-c9af-4010-67be-08de623b0ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JzeCUP0c7hgMSw17pHtzwv9sTH3xGqqeN37Ugpy+RFzXdU48ANevpvYPo5?=
 =?iso-8859-1?Q?uDdvVJAwlS0lNHBn7D2vCU/ySm3IDWiUhVjhgbN0nqO2lSd7r0X7gLaP7+?=
 =?iso-8859-1?Q?JUKDpkhPecNiuitMhqCdyHFUo+HWW7TFznULxoVsL8gZA6jkxul2gzddTG?=
 =?iso-8859-1?Q?y9QlIi5B7l9Si+RO/KiKIGCIYtz2b2UdAThv72pZNyqwqHFt7vQTrXpRRi?=
 =?iso-8859-1?Q?zrBu/aneOJ2WnHIe05nxg0nkoK7uLf7AtqeNRURZHofQqGG9PavTipq92f?=
 =?iso-8859-1?Q?HbXvHaFYUQhGv3zPU0Lt4Fo0NEqFELO2cWnFBKmeBtl6KDsZKPWQB9FiDn?=
 =?iso-8859-1?Q?+hPrp9VIp60OpemzKhpTN5n6J4dyrD0qGxdGkD2Z6POVrbfwj08MT7OFEa?=
 =?iso-8859-1?Q?OB7NOwf4OflHO4z82PCIomKN2ojk0sZO224CCjcyPXpxWB7nA4Mf9HrR9N?=
 =?iso-8859-1?Q?QoVSIHOxcCLFN7wabZUuiy9NztyeAoYafRNIQ2tJFMicoL7d7RnIh/bwWe?=
 =?iso-8859-1?Q?w2htYzRlCSyMaWZO7E0vWIn9sFhqHkvDCNcJpCc0SVDfYM6Acmm+fjph3D?=
 =?iso-8859-1?Q?H4XtSC2ZJfd+FFoeZjX5XhByv6pzM/MK7AjlRAvUNOt7F4P/fNmnaqaZqV?=
 =?iso-8859-1?Q?W0lIX1Ly89UKxS5gZRROkNjJKLUN10ewBnLuUtQ85nRuOXaQr8DLtKlosw?=
 =?iso-8859-1?Q?Xb922LWFc4ap0L+8k131pasVKJ8XMHoSCjagyzBMcJVcsmAsfk0hTGg8lX?=
 =?iso-8859-1?Q?pzovGL8KwnFeyML8VbzmQo5KIhnU+tQZifGLZ3MGd88Dp+15Ga0um17Psf?=
 =?iso-8859-1?Q?vfr4QIxFDE0AkGJUOoxJubJ58jJXpVJCg7AuIyuzhWPdv6CyjqJVS8E9k3?=
 =?iso-8859-1?Q?px2OXoW9Ee+2RPq8TKqEz0a9hOFL3RKV+5YK/NrHUFsX76vz3Oi1bLeIip?=
 =?iso-8859-1?Q?xSZixZBc62oud5nrThHcj/47pexSvd28QiMOAehWmWgPIQdRcrornE3tci?=
 =?iso-8859-1?Q?wJlJapBe+wIpipu8sX86NAxo5N0bXLSgvsBdm5GOjf3mvcb+01KHBlM8zI?=
 =?iso-8859-1?Q?u+Bxwy6zPiH0PpEe2v6NeLxfIIahnI7dIIQhVFVz4A+0pGGSsQNhk8G89k?=
 =?iso-8859-1?Q?vdboxFp+rOqsPbANBGzIp5s6/NFWX7NhQobWetyd9EYgwtuSGUPrZDqdu3?=
 =?iso-8859-1?Q?EPWb5Qw3Wi8SBQQb3NMdM9acwLFVJD9onrZVp+UFScD+eneo4RodvUhDaj?=
 =?iso-8859-1?Q?vGj4vfCGC0ZxWreGL+MCeOfEg8R7Jl4js4ZItSicSSSOta7xRvjFMYpYK6?=
 =?iso-8859-1?Q?YYY3ZGEc0v9p9AWDNUEqzzuQBWfNqNMDpleNrOohKw3nsZKeH2Xz2MoVMK?=
 =?iso-8859-1?Q?ERohu3DWhhOF3FcWGKHdd3iutPs1zGy4/gYdZHuiK/xpK4rYvB9aClFzah?=
 =?iso-8859-1?Q?jfIauLnOcxz6FgQ8n8zBXySFvHqDYz33rZ/rxuZVDA8OxwWgeFBpfv7P7n?=
 =?iso-8859-1?Q?YXsAIVdA4POmW8Kqu6DpQTFiOQ3xIu9yBMUe128+vt6RALGC5bVOldbUli?=
 =?iso-8859-1?Q?QpL3PCUMYMGtUDu1wGvKoOw3vipZK7W1KAtXhsCszq98a17Lf7vii8gcsg?=
 =?iso-8859-1?Q?jj6b6B67YB4Fo4gwXptAbMSdMo2l4KxqwdYn0RHFY6Hnv75Zae3Uh7+9Fh?=
 =?iso-8859-1?Q?mU2l0pZQDcVJL7kRP00=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nC7DUQJIkTG6Z9SIz8Ltqc/Toc4ffpCHsYJ0SN9ezLivxv4rmSDjbk0A19?=
 =?iso-8859-1?Q?mgjglrotnAnw9USUT7QdDtW9CrfnPSvbWkqckLqrw3+3/moHGQI4ZClcdc?=
 =?iso-8859-1?Q?z3bah6myF1u6nSbfsyaU7uaYOfONW527tALiUE1OgOMvqSOmiQYKbKmJYa?=
 =?iso-8859-1?Q?rwl/NFCgpdIfOTcuS/FesDiElU6QGLWiYK0MyczpWbAlAiwx+7235tQE4c?=
 =?iso-8859-1?Q?lpyaaw2Cwp0D6kCygLgsBPJ7Qzxhcw0anAyXh2Xj9yG1NzbH0s2SKW5ogu?=
 =?iso-8859-1?Q?WsULKttFNQCjRJK2CG6l025nf7vAdfqY6O5d6GTzP0AQKBzFWNl0BHFf1k?=
 =?iso-8859-1?Q?+/86qItJCdHk7UmIznuiVnFzsxWtj7MPfeeTdtMMBhuBm7gkgbKRBafvl3?=
 =?iso-8859-1?Q?cyzIE95WbDEzs4SnsDzcA8H5o9Q+If/VWV0428RSmT6NDSjzyLgWks1pdt?=
 =?iso-8859-1?Q?HlPNCx+dHfxLuaGVGFcMJEyBftz9mGopOF1eywViBrRU3mbz5l+r5zktZc?=
 =?iso-8859-1?Q?TYWc9jOYADWdUkZFEWpJb5f78MgM9gQjIbVV+NL1ODbWPDuGN2e9pyOJj+?=
 =?iso-8859-1?Q?8K8rWE689B05SzP6qCFUCIR/3ZB2WqPDT9jNyfAf7vMuJah6MJ0TEqAlj1?=
 =?iso-8859-1?Q?CxcdppCz/QNwRJM1JLCQbKCeldKloCOnKU9wXAgmOVUn5WTVe2vmt1UU5w?=
 =?iso-8859-1?Q?jqYjs8i4jiD8be/vdL5L7GrfU08yL4aJj3YkQNjtMBKcq3NTdeIdAZI8xW?=
 =?iso-8859-1?Q?tfjt9MNtaluXAFUnegbo3tpx2gflUmNekZNIeU0dh8+8abgkA8MD6G77+0?=
 =?iso-8859-1?Q?KjbKwWRbtl2Vi/AfWMVrt2U05RdU1vUrzvYgA1ysIlvvHuIRzaIgycUabk?=
 =?iso-8859-1?Q?IeK9GRAXRBjJvU+aoBG7IIeKKizw5f1Wb/yMtKYTy9t5eoUSP6vhIXxaDV?=
 =?iso-8859-1?Q?kb2ilubMUaVsJQNiOqTp9dIVLhjr7Bk+FYhNA9JkXSzjY4NkY6PUFZQwq1?=
 =?iso-8859-1?Q?0502+gc9O5jjzxXW/gkKfs2DUAB06kkD+bI4Ckt+hgWSlXqmxpSi/5mT1f?=
 =?iso-8859-1?Q?urXQ1xoUx2YUcbhe9IY/QTwCLog8r3QrrZC7EPmvIa4x84/u7Tqy03rEWz?=
 =?iso-8859-1?Q?x9So4Mh9lGDaHzaUfroqnnFMJl46XwfdhJ43ZuBlnCVfMThs1goo8K8Yp2?=
 =?iso-8859-1?Q?xP6FngLhlVPzVvt7a7070rtwmoexRrN2iZvP5Ja79Mt/Gs8fdlNhvbPbgp?=
 =?iso-8859-1?Q?WpgxJ/yHmsQSD4kh4Mchg6x70dedQnfaGRVQPQmeUsYzvq91s4D6eNNwPJ?=
 =?iso-8859-1?Q?ME81p6gcX5NXjZI0TD1S/0AEiDHQOiTdt5zWyIwJbQ+INOsHWreDyLQW+z?=
 =?iso-8859-1?Q?Zjf5TpBfN8A+uETr7clOAAU1+CpcY0hCR01r5bURF+wIw8Wa1yyn6qJWNo?=
 =?iso-8859-1?Q?M/gfpGgGdpiRF13pNGU0fR3CrOv22sQkypTesgQSoH7IKHhn+1iN3Mr2TT?=
 =?iso-8859-1?Q?DLNOWCa4/TJfFRvOcoPX444u9+PNMV5wNZ6U4J++s0baTExcTuWd/g+WX7?=
 =?iso-8859-1?Q?a5bc4N1oa4+z8c8iUZ30hxA7BVYSsvssnOma1drprN8y0LD9DCXYzby8a+?=
 =?iso-8859-1?Q?n4/8NHkFiST2stF39vElWssyauk6Kt35USW3dp89cZjD/ZSe4F/OsFfK1U?=
 =?iso-8859-1?Q?M73t+GorJDWda7Btplk5Y+IwofVQc/m0/MEQo2KHN9H4jHpOK90Bu+Dw/a?=
 =?iso-8859-1?Q?IcCO/+Hy1muvpJS8JO0GgOI6VSOGLHY+nuJHxpmX4ArJBA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4de20f-c9af-4010-67be-08de623b0ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 09:11:29.0300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aNHIaSD3pFxCO9HxX1JSO5Ey60d3a+u0s22HnD084ROgdeDFLQBbL/Qot/rl9kudDtGr4sHBcRcre4Chhm+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
Received-SPF: permerror client-ip=52.101.56.58;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Alex,

Is there any new info on this issue?

Thanks in advance,
Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Pekovic, Manojlo
Sent: Tuesday, January 20, 2026 5:01 PM
To: 'Alex Williamson' <alex@shazbot.org>; 'qemu-devel@nongnu.org' <qemu-dev=
el@nongnu.org>
Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelk=
ovic@amd.com>; 'C=E9dric Le Goater' <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

Hi Alex,

Here is the second part of the patch.
I didn't take into consideration the non-vfio-device in my first patch.
I fixed it by using standard that I saw in the code for getting vdev in thi=
s scenario, hope that it is satisfactory now

Previously, PCIe Atomic Ops support was only enabled for single function de=
vices due to potential conflicting capabilities between functions.
This patch enables atomic ops for multifunction devices by finding the comm=
on subset of atomic capabilities supported by all functions.

The implementation checks all functions on the same slot and advertises onl=
y the atomic operations supported by all of them, ensuring compatibility ac=
ross the multifunction device.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 6a6c8f1807..a6723063ab 100=
644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1931,6 +1931,34 @@ static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *v=
dev)
     return mask;
 }

+/* Returns biggest subset of supported atomic ops of multifunction
+device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevice =
*vdev,
+                                                    PCIBus *bus) {
+    PCIDevice *func_dev;
+    VFIOPCIDevice *func_vdev;
+    int slot =3D PCI_SLOT(vdev->pdev.devfn);
+    int target_devfn;
+    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+
+    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
+        target_devfn =3D PCI_DEVFN(slot, fn);
+        func_dev =3D pci_find_device(bus, pci_bus_num(bus),
+ target_devfn);
+
+        if (!func_dev) {
+            continue;
+        }
+
+        func_vdev =3D VFIO_PCI(func_dev);
+
+        common_mask &=3D vfio_get_atomic_cap(func_vdev);;
+    }
+
+    return common_mask;
+}
+
 static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)  {
     PCIBus *bus =3D pci_get_bus(&vdev->pdev); @@ -1941,15 +1969,12 @@ stat=
ic void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     /*
      * PCIe Atomic Ops completer support is only added automatically for s=
ingle
      * function devices downstream of a root port supporting DEVCAP2.  Sup=
port
-     * is added during realize and, if added, removed during device exit. =
 The
-     * single function requirement avoids conflicting requirements should =
a
-     * slot be composed of multiple devices with differing capabilities.
+     * is added during realize and, if added, removed during device exit.
      */
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        vdev->pdev.devfn) {
         return;
     }

@@ -1961,8 +1986,18 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice=
 *vdev)
                              PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
         return;
     }
+

-    mask =3D vfio_get_atomic_cap(vdev);
+    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        /*
+         * Only process the through the root function
+         * We get through here only on function 0,
+         * through check vdev->pdev.devfn
+         */
+        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
+    } else {
+        mask =3D vfio_get_atomic_cap(vdev);
+    }

     if (!mask) {
         return;
--
2.43.0


Thanks and Best Regards,
Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Pekovic, Manojlo
Sent: Tuesday, January 20, 2026 5:00 PM
To: 'Alex Williamson' <alex@shazbot.org>; qemu-devel@nongnu.org
Cc: Prica, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelk=
ovic@amd.com>; C=E9dric Le Goater <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

+ others, on accident


Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Pekovic, Manojlo
Sent: Tuesday, January 20, 2026 4:59 PM
To: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

Hi Alex,
Hope you are good. Sorry for such a late response.

Appreciate the comments

I have split up the fix into two patches as you said, and will be sending t=
hem into two emails so it's easier for you to check them In this mail, I am=
 sending the helper patch and in the next one the multifunction

Extract the code that reads and converts VFIO atomic capabilities into a se=
parate helper function. This is a preparatory refactor with no functional c=
hange, making the code easier to extend for multifunction device support.

Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
---
 hw/vfio/pci.c | 53 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index 14bcc725c3..6a6c8f1807 100=
644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1900,13 +1900,41 @@ static void vfio_add_emulated_long(VFIOPCIDevice *v=
dev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);  }

-static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
 {
     struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info =3D NULL;
+    struct vfio_info_cap_header *hdr;
+    uint32_t mask =3D 0;
+
+    info =3D vfio_get_device_info(vdev->vbasedev.fd);
+    if (!info) {
+        return mask;
+    }
+
+    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC=
_COMP);
+    if (!hdr) {
+        return mask;
+    }
+
+    cap =3D (void *)hdr;
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
+        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    }
+
+    return mask;
+}
+
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
     PCIBus *bus =3D pci_get_bus(&vdev->pdev);
     PCIDevice *parent =3D bus->parent_dev;
-    struct vfio_info_cap_header *hdr;
     uint32_t mask =3D 0;
     uint8_t *pos;

@@ -1934,26 +1962,7 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice=
 *vdev)
         return;
     }

-    info =3D vfio_get_device_info(vdev->vbasedev.fd);
-    if (!info) {
-        return;
-    }
-
-    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC=
_COMP);
-    if (!hdr) {
-        return;
-    }
-
-    cap =3D (void *)hdr;
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
-    }
-    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
-        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
-    }
+    mask =3D vfio_get_atomic_cap(vdev);

     if (!mask) {
         return;
--
2.43.0



Manojlo Pekovic
Software Development Engineer 2
Cloud Software Team



-----Original Message-----
From: Alex Williamson <alex@shazbot.org>
Sent: Monday, January 12, 2026 5:17 PM
To: Pekovic, Manojlo <Manojlo.Pekovic@amd.com>
Cc: qemu-devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com; Pric=
a, Nikola <Nikola.Prica@amd.com>; Andjelkovic, Dejan <Dejan.Andjelkovic@amd=
.com>
Subject: Re: [PATCH] vfio/pci: Enable atomic ops for multifunction devices

On Tue, 9 Dec 2025 14:32:50 +0000
Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:

> Previously, PCIe Atomic Ops support was only enabled for single
> function devices due to potential conflicting capabilities between
> functions. This patch enables atomic ops for multifunction devices by
> finding the common subset of atomic capabilities supported by all
> functions.
>
> The implementation checks all functions on the same slot and
> advertises only the atomic operations supported by all of them,
> ensuring compatibility across the multifunction device.
>
> Signed-off-by: Manojlo Pekovic <manojlo.pekovic@amd.com>
> ---
>  hw/vfio/pci.c | 104
> +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 77 insertions(+), 27 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> 14bcc725c3..9d1faeabff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1900,28 +1900,88 @@ static void vfio_add_emulated_long(VFIOPCIDevice =
*vdev, int pos,
>      vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
> }
>
> -static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
> +static uint32_t vfio_get_atomic_cap(VFIOPCIDevice *vdev)
>  {
> -    struct vfio_device_info_cap_pci_atomic_comp *cap;
>      g_autofree struct vfio_device_info *info =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_device_info_cap_pci_atomic_comp *cap;
> +    uint32_t mask =3D 0;
> +
> +    info =3D vfio_get_device_info(vdev->vbasedev.fd);
> +    if (!info) {
> +        return mask;
> +    }
> +
> +    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOM=
IC_COMP);
> +    if (!hdr) {
> +        return mask;
> +    }
> +
> +    cap =3D (void *)hdr;
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> +    }
> +    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> +        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +    }
> +
> +    return mask;
> +}
> +
> +/* Returns biggest subset of supported atomic ops of multifunction
> +device */ static uint32_t vfio_get_multifunction_atomic_cap(VFIOPCIDevic=
e *vdev,
> +                                                    PCIBus *bus) {
> +    PCIDevice *func_dev;
> +    VFIOPCIDevice *func_vdev;
> +    int slot =3D PCI_SLOT(vdev->pdev.devfn);
> +    int target_devfn;
> +    uint32_t common_mask =3D PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +                           PCI_EXP_DEVCAP2_ATOMIC_COMP128;
> +
> +    for (int fn =3D 0; fn < PCI_FUNC_MAX; fn++) {
> +        target_devfn =3D PCI_DEVFN(slot, fn);
> +        func_dev =3D pci_find_device(bus, pci_bus_num(bus), target_devfn=
);
> +        uint32_t func_mask =3D 0;
> +
> +        if (!func_dev) {
> +            continue;
> +        }
> +
> +        func_vdev =3D (VFIOPCIDevice *)object_dynamic_cast(OBJECT(func_d=
ev),
> +                                                            TYPE_VFIO_PC=
I);
> +        if (!func_vdev) {
> +            continue;
> +        }

Why is it justified to continue here?  It at least seems worthy of a commen=
t why we can ignore non-vfio-pci devices relative to the advertised atomic =
op support.

> +
> +        func_mask =3D vfio_get_atomic_cap(func_vdev);
> +
> +        common_mask &=3D func_mask;

Factor out func_mask.

> +    }
> +
> +    return common_mask;
> +}
> +
> +static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev) {
>      PCIBus *bus =3D pci_get_bus(&vdev->pdev);
>      PCIDevice *parent =3D bus->parent_dev;
> -    struct vfio_info_cap_header *hdr;
>      uint32_t mask =3D 0;
>      uint8_t *pos;
>
>      /*
>       * PCIe Atomic Ops completer support is only added automatically for=
 single
>       * function devices downstream of a root port supporting DEVCAP2.  S=
upport
> -     * is added during realize and, if added, removed during device exit=
.  The
> -     * single function requirement avoids conflicting requirements shoul=
d a
> -     * slot be composed of multiple devices with differing capabilities.
> +     * is added during realize and, if added, removed during device exit=
.
>       */
>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>          pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
>          pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
> -        vdev->pdev.devfn ||
> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        vdev->pdev.devfn) {
>          return;
>      }
>
> @@ -1934,25 +1994,15 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDev=
ice *vdev)
>          return;
>      }
>
> -    info =3D vfio_get_device_info(vdev->vbasedev.fd);
> -    if (!info) {
> -        return;
> -    }
> -
> -    hdr =3D vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOM=
IC_COMP);
> -    if (!hdr) {
> -        return;
> -    }
> -
> -    cap =3D (void *)hdr;
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP32;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP64;
> -    }
> -    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
> -        mask |=3D PCI_EXP_DEVCAP2_ATOMIC_COMP128;

Nit, it would have been cleaner to factor out this helper as a precursor to=
 multifunction support.  Thanks,

Alex

> +    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
> +        /*
> +         * Only process the through the root function
> +         * We get through here only on function 0,
> +         * through check vdev->pdev.devfn
> +         */
> +        mask =3D vfio_get_multifunction_atomic_cap(vdev, bus);
> +    } else {
> +        mask =3D vfio_get_atomic_cap(vdev);
>      }
>
>      if (!mask) {


