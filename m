Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0174CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcxj-000422-RD; Sun, 18 Oct 2026 22:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcxc-00040m-2S; Sun, 18 Oct 2026 22:18:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIcxY-0000zY-JF; Sun, 18 Oct 2026 22:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376324; x=1823912324;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZglY0qaiSvWWdHrKuUG0v+vKu9THoEni6oH3D2wC1OU=;
 b=gVRNDglqE+3/CDCjbk6EBYgulw0osl8ECl8rSelE+7smAZ3NRS3kYM7S
 juTuAm0ZUTVkWpTuKMTCWkSATllmU/jk0fmAKk9Dp/SB/e6R1BtBEcGJX
 pQuPaFHSH3UgU6zuGWtwk/9fK0CgC68jH1uNnHgIroVTqjjk2pl82tZop
 sJYngO7AGgA0Jektex+/y7Lrezcu6t3+lmY05goJTXjYDrbFshDydAdqs
 4akEVWZIx+6+oVX9W50LuB+zWnbjGm79qk1rLisX3o4e4MpP0HsumJNrg
 Eh8lp5S/qLGcD9tHnTxMG3pwTUDpUOzQa6b1PH8N+NhXiZNsetIIueKu+ g==;
X-CSE-ConnectionGUID: oW0uVKJdS+CoSQVCh6ThOg==
X-CSE-MsgGUID: RB30DLy2TomxFeNov5ra7A==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="159363331"
Received: from mail-westus2azon11010069.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:18:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDcuIkB1jLwkErcSqVLfoKDVKA++saA7C+P2lWgW/hf5fiIByflEgPRIy1eH1bod/igAQyQKxoX9VaOe3ye3u4kGXO3rJSUveg+MC0GR+7wkw0or/NIEt6Aa40zJOgTudBwCKadiVm2VpB9E/MIHTh/gkgf/6PGgLArSDub9RRfCINTo7dEI9J8tGEBk8XKbRex6uiN1w9gA2ya8Xt8UCotRqU0K8HxdhiPJbYTgMjojr4Tdu7WiCzADLslJKrOY5TSwi3w7p8suHBsVX+QDkbx+M2Qrp7rEM2AJvE54qcS+tZUHkJ10sHiedHhnJWOK/7NS5DY7YsMyTEkksg0fRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZglY0qaiSvWWdHrKuUG0v+vKu9THoEni6oH3D2wC1OU=;
 b=RfiB0YrQ2m0EJsVq90hIrqs1+xn3JgeYizV7beOezDY5BLt4spb+TxUXPjN8q+Wq/Yl5/12QLmQw0+f+4fAvrqrO5/AMjiXIQVBZzzRgSyaKYNIx3C5ZrBfBabfw7qtV5059qTt9CRyDNXJk+/jAfvlF0myONPpkp78gfgoVt4qdVBAYh5JoppTwnRCD8a+W7Mf/cpMGSsWyvzSuQp4e4CoBO9dJx5mnzlXzEjIbWm0PFXqTf20w/3sxsxDDwIPrGY/dSQ2GScT7I1r2wlAkFhnR3l2K2YJ7Yo3bImIN2eO4xlLZhirENhOqyISRVQyUbmXXyo+6/mpIGy6goMklMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZglY0qaiSvWWdHrKuUG0v+vKu9THoEni6oH3D2wC1OU=;
 b=NjBVrJewgGLGw0WW5MRSZNWKXTS6PaoEPuxU8ApKTL+12I/erDLjwjBfrrx7rAszxVbIC89VOHTCJxRS7V9qljRvIlwQuzOc2VYCGh4B7cpehlIIphcsrXa1WaAuXZ+DoVKGHRfvaSfFVtB0tqoMFbnwgr+TvpVSL0YZbucwPXQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:18:40 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:18:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "phui@google.com"
 <phui@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 33/63] hw/char/ibex_uart: prevent division by zero on baud
 rate calculation
Thread-Topic: [PATCH 33/63] hw/char/ibex_uart: prevent division by zero on
 baud rate calculation
Thread-Index: AQHdU+q3f6oIuU5Ns0SNTJrEd9+o5LcEOHmA
Date: Mon, 19 Oct 2026 02:18:40 +0000
Message-ID: <cd54a6b958239d3a8585a84dd716674f66fa1670.camel@wdc.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-33-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-33-ccbef537cbeb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 66477071-65c2-4f65-62e3-08df2d874a58
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: Ct9DkmWTIifXpe49avDfZ7NPMfE1ZR0o7ljzAOha+3dzNLr1SB8185ENCdUZbIDKKQQ4L81GOBN1WdBijAn76AOBWx9rT50FblWh8sgv8mFU6anNN6RnPw0GL7kMlrqzyCDmd1P+ZbS1p4yKHMaOVVUTgmCvPwBWxGbKbtjXEXzWC1iC2LGTt8E+JZLulcKyM/37Dv84wY7/A1BV8uenYEqS7xs9+9g6JdKi9MT1mDO89eIc0pABb3aAcpSNUeMcGLsoHx/RGNqnxE328XQLb2qw1rcQWBuIhIjXTOrGenTR/y/++ml0n7XrfyZsgzpS5JZZxTI0uzL5xp82OaaEyh4ut3O4m6IAyBMKbtXGvQvynFiqFJAa1C+wiQkJm7ureb61VGNkDczKi96NxQ5i/MyIB5et69a9wgsE/T4REIUL/qho0OZlUvH803VXiYKmSXAfPlzYHb4sKhEeoNcY6MwdIIZY7mr+RdbKqOoO8/u8x8VW0NF1AD9UGTZ9So/2fF7hm1V2EjthytWpkxTJ+5jl5hsSxBvOcfXaorFZHRrVJcUXOY8DwK40evBFeQEpsE9hrYSsrkAdoPrbGnw8qjdYthQVgeIPTqAcUM8TjAMAF703r9oZ2Yn68b6lUWrC7Us9dix5QjEhLlIczgbEOirHZbPq+4wD2gXDYttCHJ3Q1m4GRy3pcVV9ptcILNXEZj/js9FWTKjcirQ9d62q0GKbZC9MKvNYF250SMXJf9Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0hKNjZxby9UWFZES05NVTZScytlckxSQVFDeEFENXB3MWdJbzRkdm5HMGdQ?=
 =?utf-8?B?L2liNkNtMEYybFVHT1djb3JRUVZGTStvczFTTWFKTW5JVXhCNTRXUloxbFdD?=
 =?utf-8?B?SVV5b3dCT0NCR3lqSGtURk9aVGQ2REorWkxlQjlvS1E3R2JOZWVQRkdBcHNE?=
 =?utf-8?B?bkdwVmw4L1JUQ0h2K0xqZVZORlJBWWFMVVJ4RW5tcHZ3VDAxYmRyQmd4d3VE?=
 =?utf-8?B?cmRYT1IzNUl3WVBkZjJyM2lOQVIyaUpmS3I1Zi9wZmdYQWJlek5JK2VUMkRq?=
 =?utf-8?B?N2ZvLzY2UThTMUcxNHNzM2pRaEtveDlHYlVmNjVDQzk1UEZVbG5NemEwS2R3?=
 =?utf-8?B?TkFzTzE0L3owUEJNZXNjZU8rOUN6SldjS2ZVOHRodG1aQ2M0K04rcjdLd3pX?=
 =?utf-8?B?QXVVaUlCdVNER3lnTFZQUHc4VXlCV3FMNm9pTktsMG9JK0tvVHBoak9MVndR?=
 =?utf-8?B?TE5EdFV6QzdWVC9zaG9JdkU4MndRUC9GeUwyVEF3Ym9FdzNta25lWWYxaUV1?=
 =?utf-8?B?ZFd2ZmJkeTlkUVhRYWpEeGpPNkkyQU8va3pKdGdZY1JNWndqRUlDLzhkZis0?=
 =?utf-8?B?R2psZTZuZlJHWWRQQS92L0lxbnVrNWZleXJTWXZNenlVcDR5REZaTG4wZ0F2?=
 =?utf-8?B?L0xnVlN1SUNVK3JpSmdockVoN3ovYllZa0xWMXVJN2FyY2JKS1dxNHNiUHpR?=
 =?utf-8?B?Yk55QnJ3Y2t2VVB4MFRicWZMejRvOThvQ2pCb2RNVWJUNm1EVUV2ejREd3NB?=
 =?utf-8?B?ZE5Xemh6VTVrcHNmSEtZMU1FcHVBSHVIMFcyQS80c0JWRlF0VzdwdEVMTFJh?=
 =?utf-8?B?R1RZZkNWMzA0OXNNaWpDNmhHL0dCU09jem1HZHJjd21SZGJhNTUzNU9MSmY3?=
 =?utf-8?B?YjN1cXBmYTVKN1hobEh3RlZTVkppdmFoRUFNTGloYld4dC9LM3BjNFNEelJ5?=
 =?utf-8?B?dGg4dTlqR2pSZG92M0o1Szk5Q0pBdkgzNUhrUnFhRlNkaDd1YWxnakdBaHBD?=
 =?utf-8?B?OEhSZGI1Qm5TcGp6UjlOU01Eam56Z3F6blM2UVg3NXFXM3p0K2wzM1Bjazl2?=
 =?utf-8?B?U2lybTdLQXhYdVpCQVZNQ3dMa3E3YXZvWnE2NW5wZ3JxdEI2VmpYU2lJWUE5?=
 =?utf-8?B?QVd2S2ZvN2RPV3ZkbVM1UThnN1lNYUFaZXhsSlU0V2Z2SStlR2VkTXFrNDM2?=
 =?utf-8?B?MXV3MjJseElFNzFDMG4rNGJvSHowY210STZTZGtzNVN0TTEwMWw1dDdVWmRp?=
 =?utf-8?B?eldFNm9nQjFNK0svWGFqSzBPV1NTQjR2TU0vNkhMdFFSSjZYYk1kSjJLa1Nq?=
 =?utf-8?B?cUFxZFZxZVhIT3ZJRGxpVFZmdElKazFWOFJCNWFMendwRUN4SmUxU3hVMTho?=
 =?utf-8?B?bmhNSU5XUW05ckZkSVFPeUpsVko1TThlNEoxbzJsbG43ekprRUdVMHRFcURJ?=
 =?utf-8?B?bTdmU2dkNk5SYnFFandOMDVUaXBWTlBwcWFIM3kyMVo0NFI1ZDJ3cVZwcWJw?=
 =?utf-8?B?VndYVkdSY0M2TXBISzRFTllQRnhhZ29ua1huVkJuWXFreHZNVVBhbFA0bERV?=
 =?utf-8?B?VDdkTXQvWE4xeG1oQVUvUVV3ald2SEVkTGwrdXJiV3ZOdkNGcUp5K0pTaTdj?=
 =?utf-8?B?a3NhMllnY2xac1hYZjl0cGV3UTF3MzZ1V3lzU2VHVEMvNmZhQllsWmpjS2Fy?=
 =?utf-8?B?MEJwZ3RaWml6dVdpSUs2TlduZFEybkVaeVBaN1Y5bDlYZGszUmMvR2xYM2ND?=
 =?utf-8?B?NFAxQUpFVVpJY3FNWXF3ZzJrRTJFTjlGN2lwcFgwS2Q4SVA4M0R2KzFsNVk4?=
 =?utf-8?B?VG13bEVXRzBQSGx6WWFiZUtiREUyUzlwTzFmL0pZWk1jY0lTM0ppOXl1dWxi?=
 =?utf-8?B?bHpSa2crbDRIelEzRmJsZDR5STdpdXBBdlpmeGVtUFR2T0JoTjNiS09FcEIw?=
 =?utf-8?B?amgwaFUwNW16dWEvSzIrQ3RBWHFaalV3UWhLeXhQSVlqOXhJMEVxM3kxbjZF?=
 =?utf-8?B?U1cvN05ybGFManNVSzVneDNJL1dwbjB6TTllbWI4Q3AzVlJRREJjVnBGYnVp?=
 =?utf-8?B?UllNOWFaTmlIWDZ3TUJGQlp4QWxJbzhsMENuSThDcnZ3M013VzY4ZHRsVGdJ?=
 =?utf-8?B?OTY4VEo1SDE3MFBkMFFEdDIrc0praXNGUGVacEVNY1FRMHlRZE4vaEdidXcr?=
 =?utf-8?B?Rkt5RTl5MmhrVVVkazZGV2ZGRFJEY0cwWlRVV0l6Nlk1dG92UGpyUVN3QUd0?=
 =?utf-8?B?cFQzZ1N6NkMxODZOMndsTFE1eksxMW9tZkp4WnMrUWpWTi9rQmdGM1pGSmhl?=
 =?utf-8?B?NXgwdFJTMElkQUtudlN2eDQ5L3AySEhHM1BxekxvQzlWT3NuY3F3cTBsbkJW?=
 =?utf-8?Q?nkmIMVpLLJ96ox+tEs/FsPyJDOgN+zYNJ1gdO+71fWCrt?=
x-ms-exchange-antispam-messagedata-1: x8eNelZTS0j+F+EV1ZsgxWkmAc6QRF9ED4o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB34945B370DDD41A21030F4C1328FB8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HlGS06/26QH+SfjXqcrT4c6XqChcXRxept2JDD/yG08CijWb42guP8fjAmSldS7Gg491OeuWQ8ioHeFzW2RSSbN9gJObPRyclM4SuKYa+g+esIMZ6gbobhuZqriAyuzXAcFdV6jTuakO2ZIID4Q+JVSvBuYVXGsE10vOL/Q6HQW3GyejIvu/jTlizQjDEPYwipmVoFWDGlolvQHYWFD3wnVlq6dT6I+tEuqMUDGVENcZxXwqreE76frw63JehLnseXlNHxDmTVDXlnod7dAu67ZyrEMg6qZG3wwusXhZMC5B7k5HAtzNZMSzMLdHdazVymZJDQgGwA6B4gXGwQz9kA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ytIK3DWPbEMG+S4v8rnpZYe4t5UfNn0y7zl1IbnrdFPJ/1bhzPfEG96QTVP/fc13HUz6CQ3/oyFuK1VvqLq7j5kzxwQ9TyYUzINhgVsb7xDv10R6BaWd7rK+HTiJd1EgyuzmebvbVClzOHbiUUr71h2vOGPn/CRgBYofX6A7gre3gzCz8jJFdZA+yv5WHuk6x6FVcwP9Oms8nLBOtPTY1xo/ER50IaoD+Ok/EW5gAX/kHDQA7meHlznZAj1jNWX6YydlM8qCveVR0R0DOSgDRqdPz6mK7vABZKgYRHskOYoI7PPyWeCRy7eS0hd9z5nIFR0zNZAVG5+HQGYb2npJhgrOhBimACpQpChfAgw4pwa3stCSfDwQPJmROJWrxMsJTo7Me/vGLUermXdMMX50knEHBMgo2Gk+NBcTGndziL8nzdzY7Jz66tnjyCiC3wneVRb2fdIau+zDXyuvFjzRO4Qr0wfda1/laTfJjLf+vTI7bJnPcS1vCEutbfQTx0MFLeXD3W7mpH42WeT4s2uYDdNRIUMOkBTspU82UExC+FZlodsmYkTD3bZvUC+kgaPIqL2AU6+rNbFj/dy3MUum5OXrxtfvINLm1wb4FuIZF3Zl28UdIQrCTtpv3+QY08oE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66477071-65c2-4f65-62e3-08df2d874a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:18:40.0465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H24BfFCJHL/veGiROek1HzTu+BGHpiSKpPsxH8GBlKKFaVDSDqGLUkYZJCjGnRvIRKkU/uzuyIjuizQcY8uDnevhIP6anQQhMrbwv58QoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTEwLTA0IGF0IDE0OjIzICswNDAwLCBNYXJjLUFuZHLDqSBMdXJlYXUgd3Jv
dGU6DQo+IEd1YXJkIE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQgLyBiYXVkIHdpdGggYSB6ZXJvIGNo
ZWNrLiBUaGUgYmF1ZCByYXRlDQo+IGNhbiBiZSB6ZXJvIHdoZW4gdGhlIE5DTyBmaWVsZCBpcyB6
ZXJvIG9yIHRoZSBpbnB1dCBjbG9jayBpcyBub3QgeWV0DQo+IGNvbmZpZ3VyZWQuDQo+IA0KPiBG
aXhlczogYTdkMmQ5OGM1OTQ0ICgiaHcvY2hhcjogSW5pdGlhbCBjb21taXQgb2YgSWJleCBVQVJU
IikNCj4gRml4ZXM6IDk0MGFhYmI5ZjQ3NyAoImh3L2NoYXI6IENvbnZlcnQgdGhlIEliZXggVUFS
VCB0byB1c2UgdGhlIHFkZXYNCj4gQ2xvY2sgbW9kZWwiKQ0KPiBSZXBvcnRlZC1ieTogUGF2ZWUg
SHVpIDxwaHVpQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVh
dSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIg
RnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0K
PiDCoGh3L2NoYXIvaWJleF91YXJ0LmMgfCA4ICsrKysrKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9j
aGFyL2liZXhfdWFydC5jIGIvaHcvY2hhci9pYmV4X3VhcnQuYw0KPiBpbmRleCAyNmVkMWFlYTE0
MGIuLjRjMjJmYjRmNThhOCAxMDA2NDQNCj4gLS0tIGEvaHcvY2hhci9pYmV4X3VhcnQuYw0KPiAr
KysgYi9ody9jaGFyL2liZXhfdWFydC5jDQo+IEBAIC0zOTUsNyArMzk1LDkgQEAgc3RhdGljIHZv
aWQgaWJleF91YXJ0X3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyDQo+IGFkZHIsDQo+IMKgwqDC
oMKgwqDCoMKgwqAgaWYgKHZhbHVlICYgUl9DVFJMX05DT19NQVNLKSB7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50NjRfdCBiYXVkID0gaWJleF91YXJ0X2dldF9iYXVkKHMpOw0KPiDC
oA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5jaGFyX3R4X3RpbWUgPSAoTkFOT1NFQ09O
RFNfUEVSX1NFQ09ORCAvIGJhdWQpICogMTA7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChiYXVkKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+Y2hhcl90eF90
aW1lID0gKE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQgLyBiYXVkKSAqDQo+IDEwOw0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOw0KPiDCoMKgwqDCoCBjYXNlIFJfU1RBVFVTOg0KPiBAQCAtNDU1LDcgKzQ1Nyw5
IEBAIHN0YXRpYyB2b2lkIGliZXhfdWFydF9jbGtfdXBkYXRlKHZvaWQgKm9wYXF1ZSwNCj4gQ2xv
Y2tFdmVudCBldmVudCkNCj4gwqDCoMKgwqAgLyogcmVjb21wdXRlIHVhcnQncyBzcGVlZCBvbiBj
bG9jayBjaGFuZ2UgKi8NCj4gwqDCoMKgwqAgdWludDY0X3QgYmF1ZCA9IGliZXhfdWFydF9nZXRf
YmF1ZChzKTsNCj4gwqANCj4gLcKgwqDCoCBzLT5jaGFyX3R4X3RpbWUgPSAoTkFOT1NFQ09ORFNf
UEVSX1NFQ09ORCAvIGJhdWQpICogMTA7DQo+ICvCoMKgwqAgaWYgKGJhdWQpIHsNCj4gK8KgwqDC
oMKgwqDCoMKgIHMtPmNoYXJfdHhfdGltZSA9IChOQU5PU0VDT05EU19QRVJfU0VDT05EIC8gYmF1
ZCkgKiAxMDsNCj4gK8KgwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIGZpZm9f
dHJpZ2dlcl91cGRhdGUodm9pZCAqb3BhcXVlKQ0K

