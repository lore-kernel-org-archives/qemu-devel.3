Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A350C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9x9A-00087O-OY; Fri, 25 Sep 2026 00:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x99-00087B-TQ; Fri, 25 Sep 2026 00:02:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x97-0007SD-Oy; Fri, 25 Sep 2026 00:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790308969; x=1821844969;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=I4MD+MaLKEp/cTu8dIQ8N5XGUoF2xIlu+o8UnH6cJnY=;
 b=rFMNR93cOUqrOT141JMCMJUGJZYQOKweQAP2qo/146bzuONuTMEm6OkJ
 lsfseSr513kOXcMyK/4iWdFMdJBX/RCv6Q4Q+XZNVKMJKmk2PqdcztGYo
 CiQX40ZvokJcprqtysXGlqKo9u9X3M9iwAcIfx7J54J9BqJbQAheyoE2S
 9ogR2BqzcBrxJr0HTGTeUhiA0NVXegR7srTDixVI8KhQ53p+rQc6yMabF
 FrwTpisZB5j/KhX6fKUxRBmt7zsWs0gF4VVPOujyVGMnho9lp9ltPuw1P
 VtcCbzNk+7d4Xwr3TP3YdqX2eHcDsNQKHp2dCGIvYjKE+PmEhXevEdnlz g==;
X-CSE-ConnectionGUID: yEU8Pt1+QzGOtJL22LBiyw==
X-CSE-MsgGUID: Rv0SUXBFTza5o+uBKI7s+w==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; d="scan'208";a="157452439"
Received: from mail-westus3azon11012068.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.68])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2026 12:02:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tnj1ZPKWKXNriUMPLUFQ3rYEabWxivgIHUy8aS7NIcxJ0Hxk0/lId1y4wZrcCbWX6FgS/cG3U2CkVI3GGCN7OCLuz1QWBFzU6LXjq2zzCLaqUcJbAB4rc3BiaD0hZ3Dqd4tDkKKXBFDzsVfMrE2vbsVSJ1jwcxvD7kTWw8+ViJ46uspVB/UK5CxjVoR9aG6DuDJtiZRjzunD5HdeuJwRmWrCbHV4NxsZs6HyiMVhO/dM0yukC+2TrOM+B2Vgc2QbK9VCwL9ltgX0XIOCO4NxArS2fHFuPIErAw9hGDOQLJRENliHw06lVbk/Cscug4tDRG1lRVp+AbwndWAjB0P75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4MD+MaLKEp/cTu8dIQ8N5XGUoF2xIlu+o8UnH6cJnY=;
 b=Ky1cNRciokqfuL446gvc2rSjGVulp1cRrZVcRg1ECXYfwuwUo66SIKArXpWUwXGrxDuVwxiCjoxZ2OUsTsiZmUbDxtDWIUlcQvGq7DMPKFdBvy6MQjIx9J6qi9tSvgoBBfUS5GLP0fVVyayJSD2NK0qLweFjmj5XLPUmo15e4pHkexTMhWqFQ9IUvTEMqAJFayvLe+ubJBKB4RENadSGegRPcEOR1WF0c4mjCd8Tz8uk0vh7+q/lEmLaleyivxbjfd4Ei7+13HLgUZAG9WBXKkyxywZoQqnXct7liIeaaAgQZgooCeE2xwWwE+cNG9dwP75O+1jj1lyPGEwQQ/PkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4MD+MaLKEp/cTu8dIQ8N5XGUoF2xIlu+o8UnH6cJnY=;
 b=paTCHujgG5k2r6q7R4E4cPavL3pWH7sG/kCzUB3AqonCVizJCZSR90OXIArYRRZijfIJSIWtCKMXEIolcL/0G3dlkq+vwHYqnC/d/BvA0HWN/KrpON3NkPZCflAzRs/ewXupDF5P/toZJ2apLg4d+fR7LUPoW+Jz2bxorQqndvI=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH0PR04MB8194.namprd04.prod.outlook.com (2603:10b6:610:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 04:02:45 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 04:02:45 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "almer@dabbelt.com" <almer@dabbelt.com>, 
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 6/7] tests/functional/riscv64: Add boot test for Milk-V
 Duo board
Thread-Topic: [PATCH v4 6/7] tests/functional/riscv64: Add boot test for
 Milk-V Duo board
Thread-Index: AQHdTKK4Ja00+m42YECT5LFtFb8lSA==
Date: Fri, 25 Sep 2026 04:02:45 +0000
Message-ID: <66512e37ad227defe5d5512b2694ea0fe5f0a21a.camel@wdc.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
 <20260822194315.2550260-7-visitorckw@gmail.com>
In-Reply-To: <20260822194315.2550260-7-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH0PR04MB8194:EE_
x-ms-office365-filtering-correlation-id: 3e17c6a2-4158-41ae-ecc7-08df1ab9dad8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|7416014|23010399003|366016|10070799003|22082099003|18002099003|13003099007|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info: IZSD/3IcOiWMwUWv4iQ7N1HuXkyeJS16glisj2htMHG5JNeCRYaPC6G5EIxmJGhuW65vMN2EXNOkSo/yB+VgHDbk1bhXmGY1qrevoHw19uzrBiM6ZNMo3HmvDeTpfmbM3JL0bmVG/z/BCL3oIO+t7UH6C+ha80UGqu13XZDvmQ1Mgvz8E2K0El03GKHXWc39L68gM3Ok1mghePk4ndblqOwOpbOIt2eiCFfot3W7A7KquBH9CVLXef+KGD+DKjHCtieWOXbzLDIXxVlZRidtiug+mcKdL/vTivgJck87QfTPUd8R0bemZq8XY4Z3gerMqH3QprvEC3XljKDNTCt1VNgL0rIrdHzrcy4JbDJCtkkdRjYTgG1l9E64peN0F5uXEwJ66+ZhncRM3H9Snmin4o5Qa3MKr4Xxjm9iRR0vUpJYZdOYxCK8VRBk2gPN1R0LxcY5+FBIyouMp2dcKGUxYZIWCFKxV9aUQX92E2WfIC9jxMNcDhkIcXSgEV6GE29Fcw/+oFswvOU4Q/uE5DbCdLDQNLgGQJUG3w0VwrpFUFytVcGd8+TskhU0xQH8JD6fxw0VFPqOwo57kcE32kbx9YmtV06zWmfQycskQJi1LpzI4sO2RcmGYg46Vnksyey1zlO7s8GJqqGq8PUpHkqwoj64Mlt293GrlOe13FuNjN6ATI6yE8+FoETrWkc14wuCC8f6IUwK0aX8dZJyFrPpCp2OjLhPqv96k1jeAB4lfvo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(18002099003)(13003099007)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M05NditJOHZMbk1HVEpYRjZSTk1CZmNwK1JoZDUxcWZ4S0NKdTdMWGo5QlJo?=
 =?utf-8?B?RVRNc3FxVFJjYzkwb2NudjZlZDluSElRZjFsRG5PM3pBOUV1dlNncjJ4UVcx?=
 =?utf-8?B?S015bGI1dWpjdTZRaERHVlYxc0JjYnBlNlM0cWxOQys0ZnNRVTdUcE5OekUy?=
 =?utf-8?B?MVZpa3BpVFY1clRLa3ZsQTFCSlJIbWdHRGt2UVg4SWNpL1lheUc1elJ2eEFp?=
 =?utf-8?B?WlJDV3lvVlZIUnZEaVNKOFF6Tmd0Z1p0eTEwQTVWWGlUcWlnMkIxMktxZDJV?=
 =?utf-8?B?R1lIcS9FalRLczBCOXd2bWxua2liWk1mZ0QxdUszRW1qeFhsK0loQ0hKL0FI?=
 =?utf-8?B?empsYi9LSzk2dmxhWVZBMjViK0dpdXVvYVFUeVRzSWJCNExFMTFYVlpHU1RW?=
 =?utf-8?B?VVRWZjVtRWxRc0Q3WnQ0R2FIcExvaVNmMHFPbUxRUzNGbkxDYnM4bkR3V05Z?=
 =?utf-8?B?aFdQcm9oeFh1b0Y3bkJFQytsTzNQbjZlY0g1cnFDcE9GQzU5TEU3YzgzS2ZG?=
 =?utf-8?B?NkNtUEJLUWhmT29sVWZrRWNoN2Q3dVpvOGpiQ2xBVUZBWG1ZU1d3NWdpd0lt?=
 =?utf-8?B?U3Erc2hnSUFzaEhCSFRQNm43WWtJaHJlM1l2bzU1UldSVklMc2UzaUluUEtX?=
 =?utf-8?B?Q2VUZmIwTk1tdGJJUUExRHpPVGphb09vM2YwTndhdG9PRUJGUGtsYkI0aUNZ?=
 =?utf-8?B?bGhKbTZrOGE2TXpXMmxTWmxLbVRKM1BmdWhYSENXMDlobkJ6RUxaSllHVUtN?=
 =?utf-8?B?aXBvbll5c3h4a1l3QjY3bjFXQWdCOGsrMmpxRzBpY0hzeGVKanpqdjNFanhs?=
 =?utf-8?B?clZqc1lBOWZxTDhPaVFFUXZZa2hUQzl3TGFBd3hYaHNQcjJpbWc4aHJMTzhn?=
 =?utf-8?B?NnNpbDA4eVl0QTNoMjM2eFhrN0lVZENlU2hZM1NLVmU4YVRnb2pYU0c2bHd0?=
 =?utf-8?B?cmlwWmhnY2JIcWVDQUh5TzJXNFFwczdkNzNQQWxYYmF5cnVZSm1qTGxxNjd3?=
 =?utf-8?B?bE4vd1BCWStXa1JGeGt1SDU4YU16ZWIwZDNmYU5Pd0FIdUZ6cVorc0VRbjU2?=
 =?utf-8?B?Ty9EN2FIUFM0V3lpNjFsMUR3T1RSU2dTV0tMeGMyamFza0ZFbGJuVnB3bm9N?=
 =?utf-8?B?cUgwRXJENVB1eFFBQTRxSVpiNlEvQmlSMHlGQXM1RC9BRkdpZzJnS0pxTFdB?=
 =?utf-8?B?aVd1U2crT2lRa3kzZjZIQkFaYWExWm0zT1dGNFdWR2dZcmV1c21WeW92UGZn?=
 =?utf-8?B?RlBqNlpObHlKQmpEWlNkcUplQlVMaEF3VWtwY0Y1eGpKdm1uNkV4SVBOc04v?=
 =?utf-8?B?dE14dlE4OWJMMysybVF6aDcvdVc2RTdKRTlRUmQ4ZS9HaWZsa1hFK0ZleDhh?=
 =?utf-8?B?NDJUU3JITFZHTXVydGRZQThzZFhmcjRhOTE2c2wyTWNmRE9xMUZscjZNVmdI?=
 =?utf-8?B?MFV5OS9xakRHQjVQaVBrYnIxOWUxNVdJUXhad3JBRUFUbVh2MGpDZk9VY0I4?=
 =?utf-8?B?RExwSVF4S1NmODIyTWJqa1lrdmRBWXNFdk8yclRZRHNWNDlFYUVHQzY4TllT?=
 =?utf-8?B?ZkNTYVZla3RMQnBuaG5GbTdLV0EybTNvcHhPaXYvZVFSem13c2tDSE9xZ2k4?=
 =?utf-8?B?MXpNekxTWFRtWERFRzYxeXhUKzF3b1JmNi9qTGZBL2EyVmhmOUZGTGU0SkJY?=
 =?utf-8?B?M1Y1bUxxU2xObytwNTgwTlVRWHlmcXM0b01FZkwrRmtCQ2w2RTQwTktmanhT?=
 =?utf-8?B?TlhpMkV4M29ReHpKczhhbDdIYXZuY3VQWHMwbk16SjRwYUxiS2lSMG1uM2Q3?=
 =?utf-8?B?bFF4N3RDTnVUUW1qczhkOWs3S3dobFJMOFBSdjVIQnpyWnl1MldKSTlOZk5V?=
 =?utf-8?B?TFhwNWp2K2lxbEhML3ZMZjBIMDA0eEFYOXNzWkIzRjcvbU9pRVBtOW9IeUt2?=
 =?utf-8?B?aU4yTkVMTGVLRHZrWEdCUFZQdXcrLzQwbHpSYmVvclJrZVJzSVhBeDJ6YWpm?=
 =?utf-8?B?MXNUdktyY1VlWS82bDI3T200V3dHY3BTeGNjUzFuU0g3YUpNZU5wVWpKK3RE?=
 =?utf-8?B?dDYrS051S3NkL2krcTZvQ3BZMS9oZzd5MUtpeDh5OGlEQlpMTEtrc1lqWVZr?=
 =?utf-8?B?UW9xVGhJN29LbmtScUhWdWwwQ3RuQnI0QW5zcVM4bENlRXhieldqajdZTytC?=
 =?utf-8?B?UzZBR2xIWkZCMDRXdHQwRjk2SkZJbFhGVFpkd24vOEYzbVAzSFNyc2gySE51?=
 =?utf-8?B?RDdIYlQ0a2NrZUQ2S2FXVEg4NEhpREcyRWVwMDJRWmQ3N2xnWEtEY09RTlBr?=
 =?utf-8?B?Q09tRkVIcXI4dDNuWUVRTTZDL1U0WVlUb1RWRy9VMGdUOUZGakQ5Z0YvZlNS?=
 =?utf-8?Q?tjjEIVfp0mYi4jo+x8V/rxnd2hl0RV9v4ukUyABixKwWo?=
x-ms-exchange-antispam-messagedata-1: xxw1/OgJEKYu7lVOv65AtQs87Wm9q1DBJDo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B463921FECB70449B56B402CC734E75C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0cxTfrtuxC0iojYnnDpWqewe4MXKqLQfZiE7/8Xxv3g3ZJDF6eb5sSSTgPvKMU9o4zeM9z7io0LA6RT4p8uL4LGPV65eR+fe1+/F54nIrR9lI0k2phI8Loa4djMvJ7H2QLQfmgHGTUfdoYElShjBTOKVtHExns/jJDS6/0VZ/5nJOmOo0gdagtBCZZQTrGJFd7DrGsHYLgFS2/sPwnKpuXeYBIvnLqRYD8bSF1ymNa09JrHtfdDVty4DktrthdQGyXnAzQMsVV8fgfifvlmptMOyuW1n7hbEpWWLngeecsqDxqYu+ZpokoJnHkfgggJtoilk42Kt2maTzXBBq6Z/Ng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ECVx5dTkvFNlgfKiLa04Y2OpKlTxh1elnU1boe175peRJiKc84hXw4kWupkJ+UAeifPyJz6jshMulA7zxw/+Jw5Ns317nO40CG2z1dlnve4BByBYMj+mKxzp+EDG95mutkAGKfbbQd1wOBCklFFQeEsZnl9pRp8Ru9dGnBVKRvuRyszOA4j/SIEU3Q3gAmoWRBPOgU+rLq/319/VqPWDo5OyrhCx4kEfDRf2hQeBPvWXje/bvsbMOO86MLyGH/OriPEOypscujm07MHhV4DXNAAXsNlForrpJ1Bto9mDaKqMFUpCg2Du/enbyjkVwLdKUyL6g65HzeaeuOhPbZ1aXg0uG7ViM2fq5KQyM87oKDfrP4gw8wmK9HLIj1SfcN//AsxfgiELkj+TSxMu/ekz+lkZ46jt7WvLi7nTYIBr/IgjkqU6KsimZAbD8iIhpq2QDAoRioa7RRsHDHnF8tzOSG/BK/nITI/A3s1bpLRu2JLjHq+vW8c5czaP8AluV4pmM5udiB/rwFLk8twGJdJ4YPhcDB3IxWOSyKwSNvZaEwS057wKAdeTzEazKrA8H6S1wx1WPSdKYWHQCW3sV64cJ8IgQ0JU5mcZgOTFEU96Hy+vNie3kKrSBLRBAFwTYGNN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e17c6a2-4158-41ae-ecc7-08df1ab9dad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 04:02:45.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEcW3LL7NaMtK8BizLzqa7LRbhy3LhA47tX5/TZ/1GHjCrX4wse1oiIdwkVD8cmX7rv8SaTsgQJKaYCt1J/QjjEm9s37wPgdLAKwKnYFdyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8194
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=721c190f3=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gU2F0LCAyMDI2LTA4LTIyIGF0IDE5OjQzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgYSBmdW5jdGlvbmFsIGJvb3QgdGVzdCBmb3IgdGhlIE1pbGstViBEdW8gYm9hcmQgdG8g
dmFsaWRhdGUgdGhlDQo+IGVuZC10by1lbmQgYm9vdCBmbG93Lg0KPiANCj4gJCAuL2J1aWxkL3J1
biAuL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pbGt2X2R1by5weQ0KPiBUQVAgdmVy
c2lvbiAxMw0KPiBvayAxIHRlc3RfbWlsa3ZfZHVvLk1pbGt2RHVvTWFjaGluZS50ZXN0X3Jpc2N2
NjRfbWlsa3ZfZHVvDQo+IDEuLjENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1YW4tV2VpIENoaXUg
PHZpc2l0b3Jja3dAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4gwqB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqAg
fMKgIDEgKw0KPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pbGt2X2R1by5weSB8
IDUwDQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDUyIGlu
c2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9N
QUlOVEFJTkVSUw0KPiBpbmRleCAyNDVlYjdiYjU4Li4zZjc5MzM0YzU5IDEwMDY0NA0KPiAtLS0g
YS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTg2MSw2ICsxODYxLDcg
QEAgRjogaHcvcmlzY3YvbWlsa3ZfZHVvLmMNCj4gwqBGOiBpbmNsdWRlL2h3L2NoYXIvZHc4MjUw
LmgNCj4gwqBGOiBpbmNsdWRlL2h3L21pc2MvY3YxODAwYl9jbGsuaA0KPiDCoEY6IGluY2x1ZGUv
aHcvcmlzY3YvY3YxODAwYi5oDQo+ICtGOiB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9t
aWxrdl9kdW8ucHkNCj4gwqBGOiB0ZXN0cy9xdGVzdC9taWxrdi1kdW8tdGVzdC5jDQo+IMKgDQo+
IMKgUlggTWFjaGluZXMNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9t
ZXNvbi5idWlsZA0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KPiBp
bmRleCBkMWEzZTZjMmJmLi44YTRmMWQwMGY5IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9mdW5jdGlv
bmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCj4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0
L21lc29uLmJ1aWxkDQo+IEBAIC0xOCw0ICsxOCw1IEBAIHRlc3RzX3Jpc2N2NjRfc3lzdGVtX3Ro
b3JvdWdoID0gWw0KPiDCoMKgICdzaWZpdmVfdScsDQo+IMKgwqAgJ3R0X2F0bGFudGlzJywNCj4g
wqDCoCAndHV4cnVuJywNCj4gK8KgICdtaWxrdl9kdW8nLA0KPiDCoF0NCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pbGt2X2R1by5weQ0KPiBiL3Rlc3RzL2Z1
bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X21pbGt2X2R1by5weQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1
NQ0KPiBpbmRleCAwMDAwMDAwMDAwLi5hZmYyNDdlNjFmDQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IEBAIC0wLDAg
KzEsNTAgQEANCj4gKyMhL3Vzci9iaW4vZW52IHB5dGhvbjMNCj4gKyMNCj4gKyMgRnVuY3Rpb25h
bCB0ZXN0IHRoYXQgYm9vdHMgYSBMaW51eCBrZXJuZWwgb24gYSBNaWxrLVYgRHVvIG1hY2hpbmUN
Cj4gKyMNCj4gKyMgQ29weXJpZ2h0IChjKSAyMDI2IEt1YW4tV2VpIENoaXUgPHZpc2l0b3Jja3dA
Z21haWwuY29tPg0KPiArIw0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcg0KPiArDQo+ICtmcm9tIHFlbXVfdGVzdCBpbXBvcnQgTGludXhLZXJuZWxUZXN0LCBB
c3NldA0KPiArZnJvbSBxZW11X3Rlc3QgaW1wb3J0IHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybg0K
PiArDQo+ICtjbGFzcyBNaWxrdkR1b01hY2hpbmUoTGludXhLZXJuZWxUZXN0KToNCj4gKw0KPiAr
wqDCoMKgIHRpbWVvdXQgPSAxMjANCj4gKw0KPiArwqDCoMKgIEFTU0VUX0tFUk5FTCA9IEFzc2V0
KA0KPiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS92aXNpdG9yY2t3L21p
bGt2LWR1by1xZW11LWFzc2V0cy9yZWxlYXNlcy9kb3dubG9hDQo+IGQvdjEuMC9JbWFnZScsDQo+
ICvCoMKgwqDCoMKgwqDCoA0KPiAnM2YxNTdlY2ZjYjg2ZDI4YmZjZmY5ZmQzYzFhNDNmNjBhODUx
M2IxOTE5NzM5ZmRjOWE0ZDk0NmFiYTM1YjJhZicNCj4gK8KgwqDCoCApDQo+ICvCoMKgwqAgQVNT
RVRfRFRCID0gQXNzZXQoDQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnaHR0cHM6Ly9naXRodWIuY29t
L3Zpc2l0b3Jja3cvbWlsa3YtZHVvLXFlbXUtYXNzZXRzL3JlbGVhc2VzL2Rvd25sb2ENCj4gZC92
MS4wL2N2MTgwMGItbWlsa3YtZHVvLmR0YicsDQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnMmE1ZDE2
NWY2NGM0YjJkNTViYmEyODJiMjk3NDk0MWFiMjIzZjZmNTIyMGMyZTc3MjFlMzVhYjgxMzExYzA5
OCcNCj4gK8KgwqDCoCApDQo+ICvCoMKgwqAgQVNTRVRfUk9PVEZTID0gQXNzZXQoDQo+ICvCoMKg
wqDCoMKgwqDCoA0KPiAnaHR0cHM6Ly9naXRodWIuY29tL3Zpc2l0b3Jja3cvbWlsa3YtZHVvLXFl
bXUtYXNzZXRzL3JlbGVhc2VzL2Rvd25sb2ENCj4gZC92MS4wL3Jvb3Rmcy5leHQ0JywNCj4gK8Kg
wqDCoMKgwqDCoMKgDQo+ICc5ZTdkZTkyMjJhYjRhNzlkMTI5MTg2NjQ1M2FhNDdjZDY3YTU0MzIx
NmRmNjE1OWJmOWI0MmQwNTUyNDBhNjc2Jw0KPiArwqDCoMKgICkNCg0KSXMgdGhlcmUgYSBtb3Jl
IG9mZmljaWFsIHNvdXJjZSB3ZSBjb3VsZCB1c2U/DQoNCkFsaXN0YWlyDQoNCj4gKw0KPiArwqDC
oMKgIGRlZiB0ZXN0X3Jpc2N2NjRfbWlsa3ZfZHVvKHNlbGYpOg0KPiArwqDCoMKgwqDCoMKgwqAg
c2VsZi5zZXRfbWFjaGluZSgnbWlsa3YtZHVvJykNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqAga2Vy
bmVsX3BhdGggPSBzZWxmLkFTU0VUX0tFUk5FTC5mZXRjaCgpDQo+ICvCoMKgwqDCoMKgwqDCoCBk
dGJfcGF0aCA9IHNlbGYuQVNTRVRfRFRCLmZldGNoKCkNCj4gK8KgwqDCoMKgwqDCoMKgIHJvb3Rm
c19wYXRoID0gc2VsZi5BU1NFVF9ST09URlMuZmV0Y2goKQ0KPiArDQo+ICvCoMKgwqDCoMKgwqDC
oCBzZWxmLnZtLnNldF9jb25zb2xlKCkNCj4gK8KgwqDCoMKgwqDCoMKgIHNlbGYudm0uYWRkX2Fy
Z3MoJy1iaW9zJywgJ2RlZmF1bHQnLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICcta2VybmVsJywga2VybmVsX3BhdGgsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJy1kdGInLCBkdGJfcGF0aCwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAnLWRy
aXZlJywNCj4gZidmaWxlPXtyb290ZnNfcGF0aH0sZm9ybWF0PXJhdyxpZD1zZC1jYXJkLHNuYXBz
aG90PW9uJywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAnLWRldmljZScsICdzZC1jYXJkLGRyaXZlPXNkLWNhcmQnLA0KPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctYXBwZW5kJywgJ2NvbnNvbGU9
dHR5UzAsMTE1MjAwDQo+IHJvb3Q9L2Rldi9tbWNibGswIHJvb3R3YWl0IGVhcmx5Y29uJykNCj4g
Kw0KPiArwqDCoMKgwqDCoMKgwqAgc2VsZi52bS5sYXVuY2goKQ0KPiArDQo+ICvCoMKgwqDCoMKg
wqDCoCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ0Jvb3RpbmcgTGludXggb24gaGFy
dGlkJykNCj4gK8KgwqDCoMKgwqDCoMKgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihzZWxmLCAn
UnVuIC9zYmluL2luaXQgYXMgaW5pdA0KPiBwcm9jZXNzJykNCj4gKw0KPiAraWYgX19uYW1lX18g
PT0gJ19fbWFpbl9fJzoNCj4gK8KgwqDCoCBMaW51eEtlcm5lbFRlc3QubWFpbigpDQo=

