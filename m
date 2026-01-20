Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22192CA5FA0
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 16:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viEEe-0001gl-Rc; Tue, 20 Jan 2026 11:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1viEEJ-0001YT-W8
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:05:26 -0500
Received: from mail-northcentralusazon11013037.outbound.protection.outlook.com
 ([40.107.201.37] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Manojlo.Pekovic@amd.com>)
 id 1viEEE-0005jF-9f
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERdrbFa4jNsvcnnepATx6Z/dYkFctUDznmxW6caGRlFZLe7b8UNi0fK6UdtQQXCKSPWgv1KTmKt9pPdH26mZJFwlYddP1hcepAguXhHwLLooo5jo4V6YP/jU4a+ReIS6k5qNX/kKlNbms5u0HiLdP32Okpc8GAWRFLbfWScFwr5wd+ub10rP5oHfzE6jHvCFJFvqsZiPZjocDhTTqcDa5KYx/xbPxTIQLuMlhohjBoT8CokvK620otp9NFBn42LN6tphC1QIP6FZWG0WmffXuxoDrMaMxDAV3/MgOC+qOvdorcD93FwhdgazOoVkdVRcJOMxUG9DF5dW1uSfaiIw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK2HQz92J3OJID8DiCXmFVqqxLyXGFJsX1PolIeByNs=;
 b=D4XxJvhzpjuLMYtJVsZztkWsDIjpmSMDXADsQqeUH4HIvEoU+y2MwE5O9HXuAjGIgzhw8gONOeUTm8p/tkm2UIuXHdzXEitKQeQ686/C1+n4OgP72FASHn5Ad+JqxukwL4KmDPRN2iDtWosq1qEGXyuLsBPKfjhwosLonS93vphUoqLWGQwRK/oweJhuouNcplgePsOTuKrHuwoWXJGDilz1qLuqqVaU/6AShpyR2ldI3WOP1blp14vCaMjeQ9egB+RCI6yP6CZBX/dKLBEmTPYIeLQmw9vGGpxFW8gaIhaj7yG5q8nFtPV4RgWT1nal8NjFBtt7uz1LmkLWyXOtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK2HQz92J3OJID8DiCXmFVqqxLyXGFJsX1PolIeByNs=;
 b=WcnpgZyQpocdK/Uj/g680dJCGwSZwXnMQp6uwGEI/4J0D0NTx1S+TKnCTUGYmTuDyRUNNoYlk59nKkN2Jb7CmfzM1rhj6csJO8e8lkWJ4bNKyEC3qcUeDlkS3gL4APeVYcpyahCLSfi6SNhkFiIASJEqO5Qp9Sn7OK1ZijcXhgs=
Received: from CH0PR12MB5283.namprd12.prod.outlook.com (2603:10b6:610:d6::12)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:00:05 +0000
Received: from CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d]) by CH0PR12MB5283.namprd12.prod.outlook.com
 ([fe80::23f7:7362:bc2f:507d%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 16:00:05 +0000
From: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
To: Alex Williamson <alex@shazbot.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Prica, Nikola" <Nikola.Prica@amd.com>, "Andjelkovic, Dejan"
 <Dejan.Andjelkovic@amd.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Topic: [PATCH] vfio/pci: Enable atomic ops for multifunction devices
Thread-Index: AQHcaRi2j570A1RdCkK75QZWVlfQIbVO63qAgAyNN7CAAACt0A==
Date: Tue, 20 Jan 2026 16:00:05 +0000
Message-ID: <CH0PR12MB52830768E66CE6734381065EFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20251209143250.714546-1-manojlo.pekovic@amd.com>
 <20260112091641.4d86d8e5@shazbot.org>
 <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5283B2F97D090DA29776370FFA89A@CH0PR12MB5283.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH0PR12MB5283:EE_|PH8PR12MB7352:EE_
x-ms-office365-filtering-correlation-id: acaf4646-a4f6-4fd6-1a69-08de583cfa54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PAQwZ7lO6zPOJNsq336DJ5kkkQaOU9tu48Xq5ciWCdAQxJiKtc9IIFt2zO?=
 =?iso-8859-1?Q?BpAG2FQoDBCIgKC2nHu+P8UK2+3eGOC/8F3/oexzWmcJ4ZKzPkZXj6fkyd?=
 =?iso-8859-1?Q?Rbx/8C3rKD41vFWgFuvZqhEwKPyy2AjoT9IKEidZcbLQ7Q65GMdmj9ppvl?=
 =?iso-8859-1?Q?qOIV6fSnbQSo1rloQ/nTQiAaLzR4rAqRHXe7d1GCNnT0x65yc8B48fFohh?=
 =?iso-8859-1?Q?Hhc5P7ub1FcHPfSHcEUzmPy7YF3GoLfbTtZvXpB3RX7MxxpUKJTM5JUbnr?=
 =?iso-8859-1?Q?4D//EmvX53xLtW9cc28HlW1mI+h9pIJFIadp/cccuhN4iJf/yJ6t4bfwrq?=
 =?iso-8859-1?Q?oZkP9cC6+aZaA2eZ0Km2zryB/87ZVkRT0FVEli/39hehuSPd8IlXg6+KbT?=
 =?iso-8859-1?Q?3dSPl8/sXo9XFH39TKCyFAXK0bG95xAwmFFT+R3/HYdHYoZACktGuF8cZY?=
 =?iso-8859-1?Q?OTTB8W9v9wCTNqSh9Jj0GtccqoEbce/drffbPGv3MFOuff6o/sIHfzuRpt?=
 =?iso-8859-1?Q?obg3F9OXKnAsPaZy/GfIwv9kfashV2P+2Uk8n2ISvrtdlnzOgAxnWZ3dE6?=
 =?iso-8859-1?Q?lvLJTxr07ky4TC+vEYZK4FjBZDMQKUnqIjSKTQ8GayKkBOVU6ZyG7osxce?=
 =?iso-8859-1?Q?rC/KEy4CG9N5Yxc08DujGtqk1FkXx2A5kj3j5YmI6DSRLw4ATYTK5pL9DY?=
 =?iso-8859-1?Q?fO2uCDEJCwkzO2/IE2P/MjiVJf9Ocz8GwIWunf7Vs9HU26DCMI/HboxYH0?=
 =?iso-8859-1?Q?zdLYv1TS7RVsUAfU6bTh1K3cB679vsykkg/7R7dg6O4Rej1wKKNJvzRR2J?=
 =?iso-8859-1?Q?890KCScxRyVBC8aDmvfXYk+GZ8vA02htuRggU3U79YPU9L67GA7Nr1pD6u?=
 =?iso-8859-1?Q?9JVjf1/rpiSkqnJLrI3Cq3M4P2l2DcYZFtv00itUX4ifdQoQJKnuEBd/0z?=
 =?iso-8859-1?Q?KtJpV+jP4FJs9n9COA9Oi4zlAJj3GBPzCvEkJHgcBZtchqkIPn0z1Kuytf?=
 =?iso-8859-1?Q?+OCOcANbGL16cz4zSzSUjMajbhtcU8Pz5qkplRpACe6I2cLavyjD5vaG2X?=
 =?iso-8859-1?Q?xsxD06/Z2ipg5jogKBKKTGQa3GWmKlrc8aGZm7m5FaclN6MDs7robvrqnr?=
 =?iso-8859-1?Q?XsBCXO8ECYsIbntPJnkbv0nYHbvnv9jht+cNWzIPgW2iEaHbBAu6HtUwwM?=
 =?iso-8859-1?Q?8eAQjxbWHGkBQP8EvbFC8BGmti9219lKh+5t6a+f26QdHsJ96TwyP2M7sX?=
 =?iso-8859-1?Q?Aimyhw5zty9McK45B4v2iQBBp35gbMWZD4hPAqpajYcDFc0HA58tW89Owi?=
 =?iso-8859-1?Q?O2x0OgsAV3CEBT7756fbuIbSuhUdkrbB1tAULAC65h9MIxGQU8qBU33kvT?=
 =?iso-8859-1?Q?WYwv0dCD7jOaHU2SCDNodaSFla2bjc0YactyCtRw52M3yYVGMwj2AJwPDC?=
 =?iso-8859-1?Q?Ju84idiFDukENr/wX0j8ls2ZLpJ/NJKZ/xhJTEThMYDMobOsmdqLlbtZgN?=
 =?iso-8859-1?Q?qoSqOti+ZoUk/qQkZJOTez0UHkbxVL5tLRre6AWns/OxLTXyErVHDJKjkt?=
 =?iso-8859-1?Q?fFuO0B0hk52EDHCAb/2cAaNEe98LN6yPSpzghpiGiYseB6bnA9QBhJOk3g?=
 =?iso-8859-1?Q?6MrVpPK6aec9VCHeaL/gvJC9FhSAWIEN8IKzwHT4TKt1/Wa0mN10y6RBiw?=
 =?iso-8859-1?Q?YRitacFs+ZVFCqBJVlQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i1bZAvWjdlxrJMmodiImzFJmw5kh+0caA5nexGfddC51p24uRPdxupw2SM?=
 =?iso-8859-1?Q?VCWxF44pWrSutkNufKgwN2HjMIWmqQIRr3GG5QmHx+i/3ijF+dBm5Co2r0?=
 =?iso-8859-1?Q?cDpxEN9JYXT7kHH2egpFhCV5oLSA74xgTRp0KxQg7Ggm9czOeSGiN0UI0G?=
 =?iso-8859-1?Q?eVfV+qnZ8DBT9rnqIbr1uLoPsuuCG1pbjVMDOafWuAybb+LpQ2RRlyDPnU?=
 =?iso-8859-1?Q?TgbIxry5hrcX5a7doukllTUX4Xder0Atjehyu57g7Spuk2S++1Wi1vVnum?=
 =?iso-8859-1?Q?PPrnivm23LxjvpvYyTg32rgrSEkantbF++Fbkn61M9Sk7nZYSd6OtDyvPK?=
 =?iso-8859-1?Q?Q1/0lcHAuAQhpBSHnhGqym8lmveCJNVFjZwnhoFVkSNmrwVDt98at562GI?=
 =?iso-8859-1?Q?rBzfxR2lL5UNTOyN1OI29rRpZY0lx6MHw7e7sV6cKEV6g118fYRveF4XyP?=
 =?iso-8859-1?Q?ikO+xpH/9uIdsm6wTdWpg0TVrRqJWuJ7EznmumtMSzja03GLEGW7ehZgba?=
 =?iso-8859-1?Q?igePDJaAdsUKD3O8q9aHwBjJ30KWpRPL+pTu7UPF+WMRjfz/6JCsg7Dax/?=
 =?iso-8859-1?Q?TVsy8njL2OykaeAslYtbS8OmhOKwr5oUctBtx5XgA9r/a78Oa1NiFxTJwU?=
 =?iso-8859-1?Q?A/+EvsAL4idClpxDOMK4fjTxiXexyHQVYbyHa5wncjuCXIdaZT+EMW+ogQ?=
 =?iso-8859-1?Q?Idjtmy35NkmpW+S5x3rrZn5sgkuiw9qxq0H/YWSqwIRobNJeasEItu/Pih?=
 =?iso-8859-1?Q?q2KuCmwB0ZdxO1a7oIK7FlIUkwer0eiy6FGCbrmmJn4zT01wWhINtn6iCd?=
 =?iso-8859-1?Q?+5egC6eOgy+h3XaKtx9s9Wr+UW6NN42ncS568zuodNQsLPhLLhd7dsLCiw?=
 =?iso-8859-1?Q?krJ9AlQkSVxiif9THP7ZouzHmBX96wJ/CLSnKY6CpYPzSMXIOGrCReEXhc?=
 =?iso-8859-1?Q?ugec+WUyLFnAdFQuKe00t6zhsVkzmXPwOG7R7pNO7N5oSwhTkPNNxerL1+?=
 =?iso-8859-1?Q?sLYtL3eQbO+hIayZCRsjrb7c/IOrtEmmOSC1trZV5oLkQKWEYjISEhCFnO?=
 =?iso-8859-1?Q?Y3DMIQHoQ7MANiQJ6FY8yj7SH1wsEYbpy2E+kbUJx7DLc/sIzUHM8EE3GA?=
 =?iso-8859-1?Q?Ax/dYTr1w633/MURySSHUc5Om9THZ174tHOiLOzWR9VP6gnJxie/lsE2wh?=
 =?iso-8859-1?Q?IRESKjr8vlk/bnJ/b2Z2cl9/KQ5sUtMv4j9niCshQXqqxPf0Qj9HQFbKoC?=
 =?iso-8859-1?Q?LYszkKocZcIfOD4pKmlYAUQ9LTD4riyVEVtCGEM5gooFt96eMdT+TIJZGB?=
 =?iso-8859-1?Q?AbXuiuR4dJe3evop/r+1xFIvbatiF2h+24q+T8bS1PFdvuSWCz4ORGbBIo?=
 =?iso-8859-1?Q?zHNfXGE0GtUAMKhRHUJziJ7y594OO5feNM5dZTi7I3/RvYvSvib+DpHloG?=
 =?iso-8859-1?Q?ij3KRXFcF5Eq4QuCCI8HTFXL5WNoU9XZ5ORb/IYokxlPZzMiTUHMPd5iT7?=
 =?iso-8859-1?Q?RslKJ/+M/4atXDJrw/uN8fptUE/INYOIIePixHXeyXxyIl/6U8bmVKXYGg?=
 =?iso-8859-1?Q?77EpLA5CJuJdAXUaP8nXFBNEn3sU6hnb2v+UwOz7Kt5KriLiFQ1/LO3Ie8?=
 =?iso-8859-1?Q?l8Saqc6E+263xrQchyUi36HKE2GjClK8uG3aZ1ZZcTfQS0I4lUnBZuFzkh?=
 =?iso-8859-1?Q?c1K0XtEmKv7QQAVGO5qk8SwloLXRbqx19Qc7Mnuamgk1FfHSYfQoww3vyH?=
 =?iso-8859-1?Q?MujuZOBeQTFvKe5oBgUujEws80An4iWA5uVVkVNINl6q6R?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf4646-a4f6-4fd6-1a69-08de583cfa54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 16:00:05.3127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efLn2JBntatsQx8g1KyaobB0JPhNILoKmKvqW3xItpwJ5aIZPseRoAEzl9wmzpttkpxhGuCr05tT/saeMfconA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352
Received-SPF: permerror client-ip=40.107.201.37;
 envelope-from=Manojlo.Pekovic@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


