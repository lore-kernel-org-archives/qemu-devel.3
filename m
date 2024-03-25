Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244D7C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 03:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roaZl-0000DI-4R; Sun, 24 Mar 2024 23:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1roaZj-0000Cu-5H
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:00:39 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1roaZf-0001b6-Mj
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 23:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711335635; x=1742871635;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HBe7Zhc6oKZjyvNi334yJBaAF1oFB3TFEIHAZJ3yLZc=;
 b=N2ndigWytgcZn3LmSN3KV36LTQwEXBJueyQCPAyLvqi4Lxmv9Mmd8ZIv
 Z1n723zR9RL92UvWP5kJkMS7vEO+o88k9uzo/5momod5ETSPqNK6isxWT
 oK9PsLtm5jbeqZz6xx6v5wdxhAFw1DaOSz1IF34DtPjQANpzCvm92a5I2
 ewTOfDSLHq+hKPN7Gs7y/FKizanR2XRlce6JkglS3FLRoQCLO/6mipw0h
 NGngjFhnAIwf8CzDVA2aBfImBCVgxe7Dwj9CVfgR3a5jZ6J8sahMQopqw
 Zte+fGPWfLMup/fXy9yQSOYp0aRSG+xqbQQGyjokGlM3XPEPBzte6YUJX A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="27882111"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; d="scan'208";a="27882111"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 12:00:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ/T/WzEoToAhKq2tDP5MmZwbXLZoCb75ZdTNjXQtv4sjtcAOFtcqRSU8k3g4DHLmKKMaeo79KYKDo10lRPhAF8O/5L+dMpwB0J1qmaOfOySK1v0eZxju1ei2nCkTrbRSpamVgydpTK49EoKxCNgKXZurJBKpsZu38v3sxVE8r00/cue16VtYOmXz2kIT7Px8oH1ZNV2A6u1UOSgytbkOdVjIpf4874aPEx7qi0Ej9D4Ka1D6uOzyEPphgJ8d4q60afwwveBPD6fU2GxbCy2hMBize60/8LmBWauOC1hqWiq670uPDQI9unLJkB/Oqu3ENU1eMa1dTpmSTxjB+Z21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBe7Zhc6oKZjyvNi334yJBaAF1oFB3TFEIHAZJ3yLZc=;
 b=S6JeupfU07KFAvlQloB3jY0i8BaA1Rn8PD+FjI0+DbGhjOojYOHOoAtDMcE0Smk8qYYlOsp1wOoZPv0slhSX4zyfPfXdLrsr350ItKE/sJIVHThLjUmlEuCjdWHbmQWm8iyHdHux8PcZQA0uBos4b0FcmL4XEI8ne5/DB8gkWiwbLwDZMGSnADvFu6GG7ciJE3Xr536XNXA8ERGV2ic74/Guyow81lMm34OJC2uuKq2UUYU+orsbjRdl4eb0aIVTUM+JhbaUwxdV/bHKI9VvvUOq9Uw8IvSoUMoF2bodQcgrIZRLl4KKq7ztLDuyXUM5W7DiwCcLqXXw0UfLMUfIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB10348.jpnprd01.prod.outlook.com (2603:1096:400:240::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:00:24 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 03:00:24 +0000
To: Peter Maydell <peter.maydell@linaro.org>, "pierrick.bouvier@linaro.org"
 <pierrick.bouvier@linaro.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] contrib/plugins/execlog: Fix compiler warning
Thread-Topic: [PATCH] contrib/plugins/execlog: Fix compiler warning
Thread-Index: AQHaemrmPT2EHGnEyk2ga5p3A7g8V7FDqW4AgAQbN9A=
Date: Mon, 25 Mar 2024 03:00:24 +0000
Message-ID: <OSZPR01MB645321820A55828922270D5A8D362@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <CAFEAcA_7E62a4QJtQRk0AHw0hjNaReB1zyGXNjFM1EMAK-unOg@mail.gmail.com>
In-Reply-To: <CAFEAcA_7E62a4QJtQRk0AHw0hjNaReB1zyGXNjFM1EMAK-unOg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9M2U3MzU4ZDMtOWEyYy00ZjM3LThhYjYtNDU2MjUyYTkw?=
 =?utf-8?B?NjZjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAzLTI1VDAyOjU2OjAzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB10348:EE_
x-ms-office365-filtering-correlation-id: fe9c687f-1e26-4fe3-0c56-08dc4c77b7ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1sKeUvZEj5QTx7qvGKYuCvgrWCab6QxDwCxGbGqjdkvMyFxc9u8JNP85w/yV6y62krYXm53iRq3DPoOIppXi8RLX+JTBRgHzkZALBLEVRPnZS85qHjXvuCLPs0Pu66IGu5ivkypf5fmbXuri7i05lbFj7sWw29n0zksHQg4qPEACImyMl5nzSTNzaPASc1Fy8Xox/cCV3oecW825JhhBTeUD0QbfltTC1wdik+lEni6LPSfA+123C/qfem6MfQ2r3wNV+bo2Z+CeVKQzdwN0RR3vGmJtmYJT7wu+yMAHLkQD00sYcdFSCHfwzInvIR1uuJc78F24Vx+LJM6tiEmHRY3xNOtPX1AaWLgMWygTOh83gCFYio2q4BXbnIRhGrxVOxADd10f9IF1APYgyaq+fro+5pRioaJee0n6QA5dzhhucWnDkoZZQMjAHF/CX1JEpco7o6GsulJjp8RndkW13hKVi6j2PUTc3yC+SkTXHTTYPpaQOjuY2qprIkYbuo33mQDZ3U4IC98FatcZWRiOB+qtWzIq1Gp0R8+CLsliVaBr7Ou4t+i3HFm5iWQrHaGeFImbA9XoECgoo4xTeyW5RfpPD4mkt4rOe48mbDnR0ybuZTzoSyzxfRVtPSCMCEsXFWVF7t/Fz3QCrE7PNEfILUqVSMoTJiRYCUrA5o9jm1nGyiiV2Q+FpH+1s97z0m3q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtPU1RGSFE0d3psdXFuRG1ENmhrV29ZaGpNZHF3QldKZTZOZG5VVUM5YTdS?=
 =?utf-8?B?UytPUlVsSWdnSnZtWkp3SEVVMUhGd1pkLzZkSkQ0b2Q1cjlBWWZ6TllaTVRr?=
 =?utf-8?B?VlhIQTAyVEU0VHlyRWIyUjl3dUc4L09mWU1ZTkRYaVhhekpVdjg0eHgxSHNs?=
 =?utf-8?B?ZWc1a1FDakZnUDFmMHN4bklpSFpTZFdZNExpMDRMK2h3UXAwTzljTkV3RlI2?=
 =?utf-8?B?WlRPOTFLVWZzSTNkYlE4SzA1Mkl3SU85eTJmeldQUjZDSFBOa2NaSnpldk0v?=
 =?utf-8?B?d3V5a0krN0ltUXNkK1BKTlBMejRhQ0FOS1lCcXk3NGpSbFVQM3E2N2QvRlhV?=
 =?utf-8?B?SDJCL29OUnZnVXMvcTY0Rm1tUjlXTC9RampiNlUrMjVlUSs3U2hQelZDaVEz?=
 =?utf-8?B?c1lRQklUS1kyR2E0Q2pMUm1Ib0dtdEd2eVNRUnE0bGhlNEx1RCtDYjRqaWo3?=
 =?utf-8?B?NUhyTUEvZnRXVTlKWDJSS3hybjFaalJQSW51M1NxclhoR0svczVMcUVkTERZ?=
 =?utf-8?B?TFBqcEpNU2FxbENua3ZVRWpkQ2ZrSldOaHNOZDhKTUhjejB2UTRCRW9wdmVQ?=
 =?utf-8?B?NGFYcys2UlJQeHZUZnhqTXJaemkxMVcyOFdzb2JCOFdJWmdVWlIxR3d0WFhj?=
 =?utf-8?B?RDRiT2IxY2NGMHkzNFp0R2lhYllWOHNiSkNUMHlpS1QxTmVGS3JON25DQlZs?=
 =?utf-8?B?d2xzSmdUeko4MklmeUlEamFnSHhxbjlIaTJvWHE4QWc0QzJ6Mzk4T29BSUZj?=
 =?utf-8?B?VWlieVY0a0VmeGFaRHNnZ2ZveVpFTmsyaFUzSVI5dEg5VE1HNjhnOS8xaEpK?=
 =?utf-8?B?MVF4OUtRVWpiUmFoN1htTURzOGtRek5YTUp3ZytVRnRJWXdVVXNBVnZZWUx1?=
 =?utf-8?B?cjlIYkFGU21rbXZoeHJuKytzVVkwYmlKMDdidUFDRkhjd0ZaWjdIbGZQampB?=
 =?utf-8?B?M2FJalZrV0N3N1prR2ZScW9wWktNd1IyY2hkNncvS3EyV01naExPSkV4L1BE?=
 =?utf-8?B?M3F5WnJzTmE1ZjZ4NXJWKzlBNUNOZHhZazJnMzhUTS9tV2ZsZzFJM0kzQmFo?=
 =?utf-8?B?RGo5T3B1bGh0d0RybUt6OFFwYStqTGh0Q0hPUUR3VHJvbzE4SEVyRUZPTXBn?=
 =?utf-8?B?T1FOd3ZUUEZzZ040OHoxWXZIb3huSXcyTXQ5YmdKaUdHK2JvZlBrRm1vb29B?=
 =?utf-8?B?NC9zZWlmMGxUSStFR3hXa2xsZlJqeG0yL045TFZBSW1haW5JcEZ3SnhuTzBD?=
 =?utf-8?B?ZjdNMjJmVGFOTjJIS3lWY2RvbVdKSVNqbE04ZXJSdExGMGdvV0lGQitKMTNt?=
 =?utf-8?B?VmJaMm9hVDFEVWtObVFzR1p3MlJRN2VpcXEvMHpPVngvcTlub2ZQK0lvb1dt?=
 =?utf-8?B?aFF1MDF1UldhS1JZVGEyVDh2MWRENnFYbG5zUzVtMW5CU2tjMWtUcDZyVnBI?=
 =?utf-8?B?UHRYQTVRQS9FTzJVbk13T04xVlA2STlNU2JlRUw3OHI4ZUdQZnpzRUl6SWxk?=
 =?utf-8?B?eU8wTUN5Q2IraS8zdUVYVU1ETlR4RmlvTWVDRUhNY1lXdktMVjRVZmQvSk44?=
 =?utf-8?B?Y1ZJV2Y1MHhqTGQxR0ZTVlZFQ2l6YnRsRDJrMzZtQ2RadVhraFJVU1NQT3Fr?=
 =?utf-8?B?RWJjZXVlRVA1cmlTc09NUlFyZEJoOW5nTDM4T3dqNGMvOXY5QzZ3UHUveVU1?=
 =?utf-8?B?enZTOEgyZkorNitiNFlzb1NwU0VWZ2xJU3BNY2FRRFBjeUNmUXkyM0lGdGMr?=
 =?utf-8?B?YTk5eEQ0UzhCY2g1ZXpMNUt2R1BMM0k0ZXJWRUhJS3ZIRVJlbjN0Nyt0a0tU?=
 =?utf-8?B?Z1l1Umh5VUhBbmpOZlA5ekJHSmQ3Q2o1RThiR20yRnBtaTVPRzJUQXFxenNJ?=
 =?utf-8?B?elZCU0V1UUJsYitKbnNBUklTK1docWJIZTZGMHNJK2JHYjhPdmJpRWp1VE1o?=
 =?utf-8?B?MU9jbC9RcHZhWlBnWEtVU3B3aytBazVsNWs1YlFONmN4cEp4L0liQ2VhbzJF?=
 =?utf-8?B?YXpjSFBSanVVOVVQRSszem9iZVJpMys1bDB6RmRVaVVTM3A3N0hlQ1QrSjh0?=
 =?utf-8?B?YXp4UjN0aXlYRHA4OGxnM2Q1QXJ3dXhUY0dCSytqeTFXNC9aUEl1SFRSb2tR?=
 =?utf-8?Q?/ajSr9OFdl487yEWOBvucwasA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PhD2nYloZtL0dtJjZKBtl1qSFfje0MbDjWX2VP0j4p4vyDjmsEYVaVUWNAdTgRfai9uToMgypEqYKmYjHxHpD+xDKEbvhtt5qnWtWB65+G2xbe001IqD4gsE0Bg95BF1PJOlZH1UuQNyWqDdl323rMIJi5lqZwn/h0YheunfNUUZQi4Kch25wom51xXTEkK58AdlM9/x7sL/vMrS25/f3a9T4/iFToD/wUz5rLg/ptsRv0xY7+dnvjXqu8Zxu9llzXxk5aMlAC6WslrNcfvjkWxPjPJQf56RgXoBRrp2lMEfccy1kzNlQEGVZea46wZCU8/BqvDEkEdP1BtQ1eXOgbDSic4aS/VDizcydyYCnNP7zm4xxeyyl/bi8jgIRCLBvFF85Ga9kmywFCEXn0gqIKqm+4JRJ33gubUEiJxlxpShk+caxp8l016YetY18dZBBlOMpt+Kd8fzpJc6Xhp5WU6RWJdBJ927/JT9ce5v5kfHh82RmBAw2kE9aDdAPf7SnXnCYSCf1EVNchWBtS0TTP8YkgmEmyLemqutIB+BY2ewc5cMWyPmyCTNS67S6sn5yq+QL6qyRsPiOSCLES1y86EPLQINGKlRfiVooz8Sw4AsBn8uFIaAKIzy0PBNm7wg
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9c687f-1e26-4fe3-0c56-08dc4c77b7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 03:00:24.5818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3t1S2RdyOI7Nnh+pRlSVoEXCJY6iHthWUpnre7M/8GIIsoj0BOP9MBwwjQoAkXyChoAv450VKEkxGhAJCX+mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10348
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UGV0ZToNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpJIGFsc28gZmluZCBhIHNpbWlsYXIg
cGF0Y2ggd3JpdHRlbiBieSBQaWVycmljazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1k
ZXZlbC8yMDI0MDExODAzMjQwMC4zNzYyNjU4LTE1LXBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zy8NCmJ1dCBmb3Igc29tZSByZWFzb24sIHRoZSBwYXRjaCB3YXMgbm90IG1lcmdlZCB5ZXQuDQoN
CnNoYWxsIEkgbmVlZCB0byBjb250aW51ZSB0cmFja2luZyB0aGUgZml4ZXMgb2YgdGhpcyBidWc/
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDIyLCAyMDI0
IDc6NTAgUE0NCj4gVG86IFlhbywgWGluZ3Rhby/lp5og5bm45rabIDx5YW94dC5mbnN0QGZ1aml0
c3UuY29tPg0KPiBDYzogYWxleC5iZW5uZWVAbGluYXJvLm9yZzsgZXJkbmF4ZUBjcmFucy5vcmc7
IG1hLm1hbmRvdXJyQGdtYWlsLmNvbTsNCj4gcGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnOyBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY29udHJpYi9wbHVn
aW5zL2V4ZWNsb2c6IEZpeCBjb21waWxlciB3YXJuaW5nDQo+IA0KPiBPbiBXZWQsIDIwIE1hciAy
MDI0IGF0IDAyOjA1LCBZYW8gWGluZ3RhbyB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4g
d3JvdGU6DQo+ID4NCj4gPiAxLiBUaGUgZ19wYXR0ZXJuX21hdGNoX3N0cmluZygpIGlzIGRlcHJl
Y2F0ZWQgd2hlbiBnbGliMiB2ZXJzaW9uID49IDIuNzAuDQo+ID4gICAgVXNlIGdfcGF0dGVybl9z
cGVjX21hdGNoX3N0cmluZygpIGluc3RlYWQgdG8gYXZvaWQgdGhpcyBwcm9ibGVtLg0KPiA+DQo+
ID4gMi4gVGhlIHR5cGUgb2Ygc2Vjb25kIHBhcmFtZXRlciBpbiBnX3B0cl9hcnJheV9hZGQoKSBp
cw0KPiA+ICAgICdncG9pbnRlcicge2FrYSAndm9pZCAqJ30sIGJ1dCB0aGUgdHlwZSBvZiByZWct
Pm5hbWUgaXMgJ2NvbnN0IGNoYXIqJy4NCj4gPiAgICBDYXN0IHRoZSB0eXBlIG9mIHJlZy0+bmFt
ZSB0byAnZ3BvaW50ZXInIHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4NCj4gPg0KPiA+IGNvbXBpbGVy
IHdhcm5pbmcgbWVzc2FnZToNCj4gPiAvcm9vdC9xZW11L2NvbnRyaWIvcGx1Z2lucy9leGVjbG9n
LmM6MzMwOjE3OiB3YXJuaW5nOg0KPiDigJhnX3BhdHRlcm5fbWF0Y2hfc3RyaW5n4oCZDQo+ID4g
aXMgZGVwcmVjYXRlZDogVXNlICdnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmcnDQo+ID4gaW5z
dGVhZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10NCj4gPiAgIDMzMCB8ICAgICAgICAgICAg
ICAgICBpZiAoZ19wYXR0ZXJuX21hdGNoX3N0cmluZyhwYXQsIHJkLT5uYW1lKSB8fA0KPiA+ICAg
ICAgIHwgICAgICAgICAgICAgICAgIF5+DQo+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3Iv
aW5jbHVkZS9nbGliLTIuMC9nbGliLmg6NjcsDQo+ID4gICAgICAgICAgICAgICAgICBmcm9tIC9y
b290L3FlbXUvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYzo5Og0KPiA+IC91c3IvaW5jbHVkZS9n
bGliLTIuMC9nbGliL2dwYXR0ZXJuLmg6NTc6MTU6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gPiAg
ICA1NyB8IGdib29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVyblNw
ZWMgKnBzcGVjLA0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQo+ID4gL3Jvb3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzMToyMTogd2Fy
bmluZzoNCj4g4oCYZ19wYXR0ZXJuX21hdGNoX3N0cmluZ+KAmQ0KPiA+IGlzIGRlcHJlY2F0ZWQ6
IFVzZSAnZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nJw0KPiA+IGluc3RlYWQgWy1XZGVwcmVj
YXRlZC1kZWNsYXJhdGlvbnNdDQo+ID4gICAzMzEgfCAgICAgICAgICAgICAgICAgICAgIGdfcGF0
dGVybl9tYXRjaF9zdHJpbmcocGF0LCByZF9sb3dlcikpIHsNCj4gPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IC91c3IvaW5jbHVkZS9nbGli
LTIuMC9nbGliL2dwYXR0ZXJuLmg6NTc6MTU6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gPiAgICA1
NyB8IGdib29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVyblNwZWMg
KnBzcGVjLA0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ID4gL3Jvb3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzOTo2Mzogd2Fybmlu
ZzogcGFzc2luZyBhcmd1bWVudA0KPiA+IDIgb2Yg4oCYZ19wdHJfYXJyYXlfYWRk4oCZIGRpc2Nh
cmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0DQo+ID4gdHlwZSBb
LVdkaXNjYXJkZWQtcXVhbGlmaWVyc10NCj4gPiAgIDMzOSB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBnX3B0cl9hcnJheV9hZGQoYWxsX3JlZ19uYW1lcywNCj4gcmVnLT5uYW1lKTsNCj4g
PiAgICAgICB8DQo+IH5+fl5+fn5+fg0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2lu
Y2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjMzOg0KPiA+IC91c3IvaW5jbHVkZS9nbGliLTIuMC9nbGli
L2dhcnJheS5oOjE5ODo2Mjogbm90ZTogZXhwZWN0ZWQg4oCYZ3BvaW50ZXLigJkNCj4gPiB7YWth
IOKAmHZvaWQgKuKAmX0gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg4oCYY29uc3QgY2hhciAq4oCZ
DQo+ID4gICAxOTggfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z3BvaW50ZXINCj4gZGF0YSk7DQo+ID4gICAgICAgfA0KPiB+fn5+fn5+fn5+fn5+fn5+fn5efn5+
DQo+ID4NCj4gDQo+IEhpOyB0aGFua3MgZm9yIHRoaXMgcGF0Y2guDQo+IA0KPiBUaGlzIGZpeGVz
IGEgYnVnIHJlcG9ydGVkIGluIHRoZSBidWcgdHJhY2tlciBzbyB3ZSBzaG91bGQgcHV0DQo+IA0K
PiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVz
LzIyMTANCj4gDQo+IGluIHRoZSBjb21taXQgbWVzc2FnZSBqdXN0IGFib3ZlIHlvdXIgc2lnbmVk
LW9mZi1ieSB0YWcuDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW8gWGluZ3RhbyA8eWFv
eHQuZm5zdEBmdWppdHN1LmNvbT4NCkkgd2lsbCBpZiBuZWVkZWQuDQoNCj4gPiAtLS0NCj4gPiAg
Y29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyB8IDcgKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
Y29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyBiL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4g
PiBpbmRleCBhMWRmZDU5YWI3Li40MWY2Nzc0MTE2IDEwMDY0NA0KPiA+IC0tLSBhL2NvbnRyaWIv
cGx1Z2lucy9leGVjbG9nLmMNCj4gPiArKysgYi9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jDQo+
ID4gQEAgLTMyNyw4ICszMjcsMTMgQEAgc3RhdGljIEdQdHJBcnJheSAqcmVnaXN0ZXJzX2luaXQo
aW50IHZjcHVfaW5kZXgpDQo+ID4gICAgICAgICAgICAgIGZvciAoaW50IHAgPSAwOyBwIDwgcm1h
dGNoZXMtPmxlbjsgcCsrKSB7DQo+ID4gICAgICAgICAgICAgICAgICBnX2F1dG9wdHIoR1BhdHRl
cm5TcGVjKSBwYXQgPQ0KPiBnX3BhdHRlcm5fc3BlY19uZXcocm1hdGNoZXMtPnBkYXRhW3BdKTsN
Cj4gPiAgICAgICAgICAgICAgICAgIGdfYXV0b2ZyZWUgZ2NoYXIgKnJkX2xvd2VyID0gZ191dGY4
X3N0cmRvd24ocmQtPm5hbWUsDQo+ID4gLTEpOw0KPiA+ICsjaWYgR0xJQl9WRVJTSU9OX01BWF9B
TExPV0VEIDwgR19FTkNPREVfVkVSU0lPTigyLCA3MCkNCj4gDQo+IEVsc2V3aGVyZSB3ZSBkbyBn
bGliIHZlcnNpb24gY2hlY2tzIHdpdGgNCj4gDQo+ICNpZiBHTElCX0NIRUNLX1ZFUlNJT04oMiwg
NzAsIDApDQo+ICAgICBjb2RlIGZvciAyLjcwLjAgYW5kIHVwOw0KPiAjZWxzZQ0KPiAgICAgY29k
ZSBmb3Igb2xkZXIgdmVyc2lvbnMNCj4gI2VuZGlmDQo+IA0KPiBzbyBJIHRoaW5rIHdlIHNob3Vs
ZCBwcm9iYWJseSBkbyB0aGF0IGhlcmUgdG9vLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgIGlm
IChnX3BhdHRlcm5fbWF0Y2hfc3RyaW5nKHBhdCwgcmQtPm5hbWUpIHx8DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyhwYXQsIHJkX2xvd2VyKSkgew0KPiA+
ICsjZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICAgaWYgKGdfcGF0dGVybl9zcGVjX21hdGNoX3N0
cmluZyhwYXQsIHJkLT5uYW1lKSB8fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGdfcGF0dGVy
bl9zcGVjX21hdGNoX3N0cmluZyhwYXQsIHJkX2xvd2VyKSkgew0KPiA+ICsjZW5kaWYNCnRoYW5r
cywgSSBnb3QgaXQuDQoNCj4gDQo+IFJhdGhlciB0aGFuIHB1dHRpbmcgdGhpcyBpZmRlZiBpbiB0
aGUgbWlkZGxlIG9mIHRoaXMgZnVuY3Rpb24sIEkgdGhpbmsgaXQgd291bGQgYmUNCj4gZWFzaWVy
IHRvIHJlYWQgaWYgd2UgYWJzdHJhY3Qgb3V0IGEgZnVuY3Rpb24gd2hpY2ggZG9lcyB0aGUgcGF0
dGVybiBtYXRjaGluZw0KPiBhbmQgd2hvc2UgYm9keSBjYWxscyB0aGUgcmlnaHQgZ2xpYiBmdW5j
dGlvbiBkZXBlbmRpbmcgb24gZ2xpYiB2ZXJzaW9uLiBXZQ0KPiBnZW5lcmFsbHkgY2FsbCB0aGVz
ZSBmdW5jdGlvbnMgdGhlIHNhbWUgYXMgdGhlIGdsaWIgZnVuY3Rpb24gYnV0IHdpdGggYSBfcWVt
dQ0KPiBzdWZmaXggKGNvbXBhcmUgdGhlIG9uZXMgaW4gaW5jbHVkZS9nbGliLWNvbXBhdC5oKSwg
c28gaGVyZSB0aGF0IHdvdWxkIGJlDQo+IGdfcGF0dGVybl9zcGVjX21hdGNoX3N0cmluZ19xZW11
KCkuDQo+IA0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFJlZ2lzdGVyICpyZWcgPSBpbml0X3Zj
cHVfcmVnaXN0ZXIocmQpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgIGdfcHRyX2FycmF5X2Fk
ZChyZWdpc3RlcnMsIHJlZyk7DQo+ID4NCj4gPiBAQCAtMzM2LDcgKzM0MSw3IEBAIHN0YXRpYyBH
UHRyQXJyYXkgKnJlZ2lzdGVyc19pbml0KGludCB2Y3B1X2luZGV4KQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgIGlmIChkaXNhc19hc3Npc3QpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ19tdXRleF9sb2NrKCZhZGRfcmVnX25hbWVfbG9jayk7DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmICghZ19wdHJfYXJyYXlfZmluZChhbGxfcmVnX25hbWVzLCByZWctPm5hbWUs
DQo+IE5VTEwpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX3B0cl9hcnJh
eV9hZGQoYWxsX3JlZ19uYW1lcywgcmVnLT5uYW1lKTsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdfcHRyX2FycmF5X2FkZChhbGxfcmVnX25hbWVzLA0KPiA+ICsgKGdwb2ludGVy
KXJlZy0+bmFtZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgZ19tdXRleF91bmxvY2soJmFkZF9yZWdfbmFtZV9sb2NrKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICB9DQo+IA0KSSB0aGluayBpdCdzIG5vdCB3b3J0aCBhZGRp
bmcgdGhpcyB0byBnbGliLWNvbXBhdC5oIHRvby4NCg0KPiB0aGFua3MNCj4gLS0gUE1NDQoNCnRo
YW5rcw0KWGluZ3Rhbw0K

