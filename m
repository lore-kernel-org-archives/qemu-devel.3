Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8BED5AE5A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 03:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8tTw-00009I-6n; Wed, 06 Nov 2024 22:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t8tTr-000085-5j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 22:46:47 -0500
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com
 ([40.107.237.80] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1t8tTo-00079G-0S
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 22:46:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNgE/7Q0EyWcKAu73Sai2xgchnzKsKwrufOT9Ywq+jW7kz6mdEe+gHSPmlTX4hHwF6WM0DD1XMsBUzVDwE8nNgkoYr53x0tsNR1KfUppiZpFZW7MD4VHZ1c5jMG9ivV8Vo0QQKwfAobpOYvUfUbBrE5D1Ll4jYQRq77IXqvJ7W8temyImmurQOs48y/GjbcAphs6KUhgquDH9DRXD40kymwYN4aTFy07z2Ma/oRQUKbgj8Z5jGqklbv0fNdX6R6hfLhB/amjfSlV7A+nyjGRCt5sFqrjc+x+7Qj4r2iBsk7q+02bp9lsrNdTGEJhY846PeDt+QolTl8FT/V2SDmv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rS/MHskpIUPVqYQsAtKUAFv7nVDcS+rek8gL2g6lzg=;
 b=zFHdgj+OOdF90QCxcwujIP4+HQQTOGi8a9c2W3njU2UoSb7SgvHpx9rRozZuEDGKAHM7XA1m2pRtjaMxhbMNSgP5hFzkGmJwDVyvTbAamyAe+kp78WME7WJoInZuS+fn8u09IwRYBw0EDWCuQys/I8bK0GzbQxauCD5DgYNyZOODeTW50IwTWbcPyNOo3XXJDkIdpj9HuwmyLUvs+cjuM0a/PWOzqrgEopnURxJOn2iklLS7nLLjoWqq8AlOOHDkH5HmutoNJBzY+E0eDMxLVwH+ZmPNh1GyXHzS6/BWjPGPdHjdvj6+AcB1iFqn0gmXpNpVE804JgLGU3TvVQ2ydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rS/MHskpIUPVqYQsAtKUAFv7nVDcS+rek8gL2g6lzg=;
 b=EGQnxcSqVDhelP9vPXjiJArgqnG2Svbl5Gl7bBWZ99SCu4Yj/ZOQyP49yypgb/FrGWOxx11Shnv9LRVv7gc56V2zF0HSXghCK9fFX+Vh0qylTEt3U1qO4lHp/+obTkbfJ42mxfEfDQ5xH6aVqMawHc57IxBWIi1tbVAy4p+FxhM=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 03:41:36 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:41:35 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Iglesias, Francisco" <francisco.iglesias@amd.com>
Subject: OOO for first half
Thread-Topic: OOO for first half
Thread-Index: Adswxs2cMFT857SoTlSPVU3F2QImqA==
Date: Thu, 7 Nov 2024 03:41:35 +0000
Message-ID: <DS7PR12MB57412DA29A4AE1BDF73EE7BEB65C2@DS7PR12MB5741.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|SA3PR12MB8437:EE_
x-ms-office365-filtering-correlation-id: 8e63ffbb-02eb-42d3-80cf-08dcfede146a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5oGrYsPqi++urDPFLtmDYIgvIhuGYUeC5N71DqjyW6c0F4QXSEahxtGlagm+?=
 =?us-ascii?Q?MY9VBloa0ANbs66SJrrY0IIRZY+6IK48YnRanOewxIcV2mSXHu5olBrEWAGP?=
 =?us-ascii?Q?fy28GRPCnIjlmknWclv59Q5KqhvP9VK+Dn0UTTX76VNAvKalLq6d3k/vcpjF?=
 =?us-ascii?Q?m9vvdGjxJqJoUSSRFf0cwG2AwZB//zddS4HA7wf3j4MJixQOHDBxngHjjKDf?=
 =?us-ascii?Q?LMHKvB9U0Uwdiv5SD6zEPNhKTPMfsvzG+fPsvY1nMmBJIcJZevkdwfTQwk3W?=
 =?us-ascii?Q?ON/Y43cA75se8HFXryAwQc+fJnyTwz53Z7t5pDkCAZ3ZffTN1gx5DvYwDZ6J?=
 =?us-ascii?Q?WbbBZMyM4oaCggQErJvrG0pT4+YoYigd217Pj2OtV1xqhn3FYX9Zizbc1jId?=
 =?us-ascii?Q?I9uAjCo5TSPo7INetsQB6tCaE8uYQ3KBQpSweMC7t0sNgURoVVLL1kxiygSQ?=
 =?us-ascii?Q?DIuzUkx8cNc08mZt8T8GkCCTGAcx3k9rb1VU5U3nhO0AspNXftHlGNvpECbL?=
 =?us-ascii?Q?yEZuXIdpJpzrS+Rbu0yAKSh7pE0FjW0K+jvdbkV7xxq72f8N3rRa7jwM/vwR?=
 =?us-ascii?Q?eYdM4dqj1Rx20gcMzmBOsR82uzXxS+bYzUI3UcjLc0CXVK2YXh/gOUEuQD3W?=
 =?us-ascii?Q?14C096AbRoY+q1KSOMgkeiMd6LeLOtxP6VBBFWyScadObkO7CAK159mrF0Uz?=
 =?us-ascii?Q?Avxkb1D9V6lZsRSx65OGYejC8djhUeu2umeDt4boniRw4eQNxtFrAgAsAvUu?=
 =?us-ascii?Q?QlIRjdRs/KOrHAthRTG31EG0TzMtcBD1Ut6vvRtXDsNGTBcvkdAuYz/dxOkv?=
 =?us-ascii?Q?tGn0a/OurEQHyJiHBw16tVJNNkmNcKzH+ThJ6sosvURHl7udjAuWeJe3XNZm?=
 =?us-ascii?Q?A54BnU+Q5OGKb59B/ggFmye26LGsHKAAu4cTHw9AEVG5mFlscgIWirTx+q4f?=
 =?us-ascii?Q?7KE/ue1zWcX4y538jgqP9xOT8ZWSZPHgdpsQQKO2ubEY07ZA3sWi3ODFIDOi?=
 =?us-ascii?Q?IT1Dns1wz+CmFBZtVFTHOgMFUq9GyqJ/NNEGn92RV0amZ04eGJA/Sq/WHBld?=
 =?us-ascii?Q?m3PVZJMeybTHNPlmL4H6bUUOzUtlMVk/z7TaYUr1aYIMr23kHV9SNbqIrzVF?=
 =?us-ascii?Q?o+aS6f2H4oHch7cIJshl8na18w7hN0euz1q5MvyLs3f8bc/pN/DGXzzGn30B?=
 =?us-ascii?Q?7kVsl2YpY62zGZ1dcIKmWDkg4AoAobcgXUFWZOrSRPmZh6Gg4+hjgd20suPa?=
 =?us-ascii?Q?8rEMh2AsdbY8Eg1IluACu4UNvvMmkGFEtc9wZA7brtutRDd6es7jmxk6TAc2?=
 =?us-ascii?Q?o0M5ACDhsqPx4iFeCAvHyRYUCrEBUC4F9afPi028Yafe0HyvCkHLc36cKtfY?=
 =?us-ascii?Q?piaiImw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2guWgFA751qyfXKEB/lpMprz1CU0BnCcRDqV0A4hD31fvGwwFSLISJMwm+5E?=
 =?us-ascii?Q?EHhJO9Al3OO7Iie8CJp8txInoeMQ8PuKW569VwrCdhGJFT2JVBYPAztb6vIc?=
 =?us-ascii?Q?oXyac7xtI+WfQYLlbErTf61HJtAansMjNIgYxARFJOqAE1GR7eLZOC3VYYtn?=
 =?us-ascii?Q?dTSp/+8wwxvGp/VNTGWlnCDf4jz3iRZRK5WnJZmVOotpJmz27FYXV/0Iz06I?=
 =?us-ascii?Q?gDfR6AB0HuGICTJAOKZ2VAScw/Jh6Jjg4U9dRr0TDAiGRezYDZRqEPPanQ+r?=
 =?us-ascii?Q?3umDUBYj0YTbtABR4q/RsnETVpOXLacnQrnsIRQxdZgVCzF9ezQHu7yAa5fy?=
 =?us-ascii?Q?ecFW5gSJq+ifF+s+YTD651bgY3j2mdHhN43PgPZuN33jCJPGeUzAPxGWDvBi?=
 =?us-ascii?Q?s4Qw4jX6LIuSUrbtDjMEoZ0BosW3YOOHiXSKP7QFrS+CzQ25SP8buH2NW7aJ?=
 =?us-ascii?Q?IrIOxpkfE+DQ8G69xDJHcWxF/Q4n5yAG/+Hrl6Zne3Zwd/fOqvo8nT+zqsDW?=
 =?us-ascii?Q?x/Wj9e/fndfio+bpHYCB6Ghh5ES1uQiWik4MTaAuYJtphRQl8pwZ5nOWHv0L?=
 =?us-ascii?Q?b7rTSNCk1QdSpKwhcjFnGuF1Hp3sHzmU+Ydcb15+mZfW2uNwqXyktv2KsZS8?=
 =?us-ascii?Q?W7jI6+W9WmclrzmKuoVaIL5tf++Z+QkwNDhh5JJNbEjjj+LbAOSvxgQyQuam?=
 =?us-ascii?Q?lF5qimkBuFC88pRTYWo5PKpvt2LPSERApNiqOPa7WwQV72VfcMqZobFFq0E6?=
 =?us-ascii?Q?traJFyzzyrei1v2utbPOY340+X9uf2gIuGNpS8s0fVD7uxphUJZzVdAukbVf?=
 =?us-ascii?Q?YTSInNSzsxhk1Rm7+FyDwVNwzzHsCE+4QQ9Itfgi8CuxW7iUnDAGKFwkpN0s?=
 =?us-ascii?Q?grvWxAQOAQmgEHUMQ//Uo8EIYF6Z8plx7ePzJG+EENHu3gZKPFuSoyulmtc8?=
 =?us-ascii?Q?puhvTCngQJE1VJfo4Nh/mJ2SP75RvcIOGpWzZGTzSKjAjbZl+QbKemR1CnVK?=
 =?us-ascii?Q?u61LvLulG5yEfowV5spw2Diia85By1zjRb+CjztF08QCW0/Q+IixQ/gOzFcT?=
 =?us-ascii?Q?yN3kcPt0nLvMxGzlGQ16w40aL9APfi72a0y5THPg1mbMMJ6heqoaCZm/eBdL?=
 =?us-ascii?Q?Xgyx2J3FwLozcjV+7IRDduB/FvWAtkfcDyUsZrSUQ1VMcSCve0kFyQjxjwdq?=
 =?us-ascii?Q?jq8T2wVojAbP+7fdvWyCf1bi6ZzTKkdAKWrIY0BweYOu0isiRzPEsN0LDlwz?=
 =?us-ascii?Q?jq9MOfElVDNvh2dGq2WnHfeiGF3EvjlFGpgbZcL03a0zvjQIi0w9sqnDhpig?=
 =?us-ascii?Q?ust60mFTsLii4+0BHzy8ZsPVGiNqYf8MVyBHlJ3fAJHEj0UDt8/58tQfLTX7?=
 =?us-ascii?Q?jsHZsmdQXWvSS8yDGfm4PSUPOt8QGzHEkPRse14lKHuLYGZLZ3MTLoFCpUbm?=
 =?us-ascii?Q?aO1IEnVGnEjDWxcMG0pNm0l4agV37kS31WSmEApDOPcfwgbSdgC1llknZyxk?=
 =?us-ascii?Q?dHUc+X2XlVsj7z73S9CoGsbEsYQYPoHiJN0FZkr2E8eCod+8Q1iOvqLPgzWz?=
 =?us-ascii?Q?WnC4UvRDM0Xl20C6kwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e63ffbb-02eb-42d3-80cf-08dcfede146a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 03:41:35.8042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxmO+xrkcqXiWLDBVUwfJjtMRwZxqvA05H1XhqfUCIGN5lYqTlfPPZEd1EMcOnJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
Received-SPF: permerror client-ip=40.107.237.80;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

I would be out of office first half, will connect online post lunch.

Regards,
Sai Pavan


