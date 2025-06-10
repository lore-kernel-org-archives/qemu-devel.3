Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E82EC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Kc-0000uI-91; Tue, 10 Jun 2025 13:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2KL-0000TG-Ox
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:59:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uP2KJ-0002sM-Sb
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:59:57 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEA33D002722;
 Tue, 10 Jun 2025 09:59:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WpOtjfWGEveaez4rKlD8ErxDTLQWuWO3UTa5FKpwX
 64=; b=0xYye6gmRr5VlubO8Q5qMLTlwp4EFOwFfVhu8s+LiPEq+EUwjEWDNOdZt
 DWnj8PFaAzGpnko3QIPdtCpxvdpdYhrD/F3Q9kZTsLQ/ayiPnsEoUaW18SdilTV5
 760icJ/K4xTfTPkcyyg5V+Y7EAUSSAi9DIsLhuhdR3kBEmBbakbbD5VunRfhMnQJ
 ZLQaeK9MUuO0nCMy1ba0+OzLItNaUVymuG1Jk2wMVWza0hpNK1IKN+IB3mF5MH2Q
 +Sk/cH8Cxkr2dqTqC5/SdpcVQsAuQdozb0KWRl4shkKTpTPD+Xp2Oyy4+WQEQXrM
 VWYn3brOkabyHs4755zGjdytDJTxQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2101.outbound.protection.outlook.com [40.107.244.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 474khjeurg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 09:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lESX+/rCGkBReLexUshq6JkCxHak3yPE9R6/2w3WTtnj5yZ9/iY2r1wj7d0mtaB8NMNI0vr1X5dLyDF2C6/FnisoJH5s5JnZ0jFEglNkkmJgtRcVo73UeMYV9/zvuYVX068dRhK+bvf4uGT0p/djHuBhcTkPRG+jaXJyKr1n4pBpZX0vi4aD/5BcZOgP5o55un5VgJjo1KX0fH3MaGLkr5sSZ8hdMBw53o/pZgdl3luG4m0k6AkkvTVa+zHUdnb9EZBkQXUBiW8es2/YDCGaMadFkMS8YKVFCbakiG94h7Co8wO1BmAqRh6ckTfJjfFlC0Ie5e90A/MKxPkgI4poDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaCeumNagYP3poowHZtToIhEJPkUPoZnbnh5GhtUaHU=;
 b=cciquWYtIWbpA1S0M6mblW+HCSf2FGHVCK8IX33lm1G75/VfoRsdGiJNVZ2wrgDsH5OmdN7z3vbwFLIp+3O2g8TNntPSDvfIf6zwME0rUsBwLyQYOa+Tl+blGfseveUlVw+UUVdv153YiVtXpa5q5/6k99h6uQ3bfL8zVupaXOG57nqvnvqB/u7GuQ2iGbU1aB9teWT2FwFlBA8VFHGolJ6/5HqybtdaO+SMrxA+YfJiL12sR+qGDS7dZCa2L+pwZndsomzlQgsU3lxiEbtWN9P2oAR9V5iDubkLGsGrt+XCQ6AGjSARyprG8NFtmYRnddVWb0lNzmwExZxs/Es0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaCeumNagYP3poowHZtToIhEJPkUPoZnbnh5GhtUaHU=;
 b=LT1io7UOsPNvi51w+lQSzqcsJrW3JymKEpjzrth1ua/M5qV2DLrtCazlkQ5Xhtk+kKekGT2xZFd0kzCZIs5/FgMzjENWjJZGoaSP3NReJo8O2ZUY3jOhx9NiBH4gXIqjgAg+Rr7/ge+1896QKVNzvF1By4gXI1vXoaanUFGJxKcuZPnNL7C5VO24bDUfQHIXYPxOepl2WRA4HRpD3A0cNuX5xbJGSMuqXFCHK7YRZT0rzt4pAFBeCwGxNAfnQLV06E7HBhrPl9AikwhviXoyVqmsJVHL3GsrYVE1l7NO5FvZjrWuOB3PJSg8AtbV/bLugtOOppVK9ekZVESmxunwyw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10129.namprd02.prod.outlook.com (2603:10b6:610:1a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 10 Jun
 2025 16:59:48 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 16:59:48 +0000
Date: Tue, 10 Jun 2025 09:59:44 -0700
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 03/23] vfio: add per-region fd support
Message-ID: <aEhkgAY1SUsxQ2Z9@lent>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-4-john.levon@nutanix.com>
 <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44882230-0e48-4232-9549-9c24c09d3749@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0122.eurprd04.prod.outlook.com
 (2603:10a6:208:55::27) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10129:EE_
X-MS-Office365-Filtering-Correlation-Id: d669d4cd-9151-49ca-0c9f-08dda840350e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kzr1wdTRIWLXKK1/6YKbOVdeNBP+Nq1DhhJaJS5de6ecPXTmwCMigpXpwi?=
 =?iso-8859-1?Q?XSWeZ0Qv/M5z/QNmiCCuTVcZCLYyME3I0NECFh5wmEKrG5DIL+BEjK9cE4?=
 =?iso-8859-1?Q?0F9fEqfTgT+mAiBeuWM0EPz/kMngYw4RKRpfx61Eba5AtV1n2LMe+tbfeD?=
 =?iso-8859-1?Q?MGVouvI955WqLQ57ddbjTyRIPGTtnGCuswqAilhNFRNxVYaz7UZ3kSXEqq?=
 =?iso-8859-1?Q?O1zk03FL5nQGNk0pif5UG6O7WbFQAnvmMMwmtEiDD1CWgJLEJrkrAyzC3M?=
 =?iso-8859-1?Q?P/T3TNeTUxivNBHtKhIkch38iWMFAXX+xCA1unFLGARHhrdT92npz5TfxJ?=
 =?iso-8859-1?Q?a9yp4HQIGvxRjVJCsWQJMD1DjLw1ntSEU+3BSqcuQl5h65uY6sWzSvO6xY?=
 =?iso-8859-1?Q?O/kO6HewXnqniMC3ctMeHFv4YXU6LYTtFBM7Z4dMCz3u3kpxTbg9tFGjtM?=
 =?iso-8859-1?Q?aOtHaogJxRbLYG7JgWcBMAX3mtkbHPqKhMlgM5fyrtF5Py4VIcvB4qHaAi?=
 =?iso-8859-1?Q?3xfnjVrNPKg1A2r1TgbthfblgeXqugwOEb1i/lggH8uNUlDD7ppGCbgJ3P?=
 =?iso-8859-1?Q?FM7ls92lMxEr8fxZ3DWPhO7QsoeXc0KqIwWpffPgmSo8NLIwWdHX6v8n6T?=
 =?iso-8859-1?Q?a0YPFNUXWL4iXQoYnIIKtTXQqYXOmDrdUfpZ9h3Ixe0qoHGulkXbo3cNNV?=
 =?iso-8859-1?Q?fmnvHMiEehZN5eTcXYlujSXsR5yYncE83enVxfhzKobRKLXWacJXoMtTcg?=
 =?iso-8859-1?Q?/oX7kiw3LUDZlw+ZeU1pcIp3vO4AbKoJMfjS2YOt4PxsuiAQNci82O5n7v?=
 =?iso-8859-1?Q?8M6whUYg7ewF+XozhD3FRYJg4IK3PKcwhlAYHZHUwt8ymfJdiRquzPELWX?=
 =?iso-8859-1?Q?bgfTW0bjWb93MUDEH+87yNMrC36WQ5eD1XAFcGAM4CbtG6HOpQcMh/Sqh7?=
 =?iso-8859-1?Q?unPylct/mBqS08TQjH6U0ueCTgC62O7dkXq1f9Joi854ZoM/VzVbOI/JMy?=
 =?iso-8859-1?Q?awZuuDHcFgzCLgGE4Fa0ANBiLyn7bN0BaM55hhIwpHKEp8X5sUwxfapgc4?=
 =?iso-8859-1?Q?caiCAO3EmJ8fNcu8qcMu7b0b7oWbayf3bheuB9OtJZWZX22G/qRM23eRmc?=
 =?iso-8859-1?Q?nAXzR1OXkIXxkfsDueW+UsmJJsMWs0a/haudU7tx8FjiU5i8seXa+6csq2?=
 =?iso-8859-1?Q?FkEAeZOAG45EYqMuZNeLlGvE98gpNFHOuu/7ApaDyvc28GBGmalGpkJ/9p?=
 =?iso-8859-1?Q?tAUJkVBzDAWVvPzflPRuvzPc1z8PfgZIF9Jsa3BYGB6ZVzO5xyGxCc1uub?=
 =?iso-8859-1?Q?5nJhviT8i+rtqa7+WgnfiK4Mzoup9Jf7MIA2d04j/3RaOqkqBCSfKdYAg6?=
 =?iso-8859-1?Q?rC71IYGluBbldFVoTTwbUkEwz6VLF8wMrSd0Q/VuY/cohQ5R2ua4h/DsMO?=
 =?iso-8859-1?Q?+Rdjt5Lun6VlotRoqOSXkyll4RjyRfcl7zmKn84QA7kUljKhY+j5Q7ZqmI?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WHEzn4mZtjP1vrePoHJ/XTQlJAZ5s6nyuqlE/t+7K48pxpXMEEyvu6QhPg?=
 =?iso-8859-1?Q?YqAobfyvA6XwNOTQYNOPBttz3wOJZQjwuOCRDkSTAcP+ZsXCy/Y3Rod+Ra?=
 =?iso-8859-1?Q?mYRuAdvLlXv55UVY2yohX4TYfewNtFUrIpEaUhjNWkp8unkWUQapdTg/KZ?=
 =?iso-8859-1?Q?AnKI4AXX+se10LwtdgANr5KMy5hiTJGGj+2OToLgqGdSTDYivqoxMSkp7X?=
 =?iso-8859-1?Q?KerhdKXu6TXNN9qmWbN1C31kTZEx1KHqh/0L4ByxdilmWxRG1rlDV2esP+?=
 =?iso-8859-1?Q?omFQHYtnVt9idH2Jeh5wXqSkcS46YC0mYLVEyH7s+TZ5oziStR/xHT+zZz?=
 =?iso-8859-1?Q?hWK2yFaqbVj0tK+FwYpk1WJY0NgxuQqZsvsr9vX9VvwCYSLQ/dffGGAM8r?=
 =?iso-8859-1?Q?QG4CUqHEEcvu1Oqek6KEiVrp2+aFfynbnzuHEOySB0YmxK+xeq9veIC3G9?=
 =?iso-8859-1?Q?LBbZLi0LDwv6hfd50pRJmsphHGMKLT3KQV4/Wwv3Ers9Wkw6MFssKnKJX6?=
 =?iso-8859-1?Q?N0rZ+pRG9RGNyTf6MBBRIvYrmDcE6u6avnqj1xs0Rz1OJvO5/hCY9aXdU/?=
 =?iso-8859-1?Q?GO98DM+nVOnZPat4+r5mmQ0zb+kvLmpva7NEUvCZB71RgMgZIe2atSessQ?=
 =?iso-8859-1?Q?rxoNRWmPGv5k7gBGev7Rc0Oaj7KVKSg0Uya3+NJvzoJH5mDw79xkBnecZi?=
 =?iso-8859-1?Q?XAwJ5y3GR0X4ZSXYt0rRBBQLIcwke4wQhLbA/7q/l6hesV8Twchp5nb3FU?=
 =?iso-8859-1?Q?FMdEEYYZiCU2GtRFooThZVvoO0y6tzpKcLnqYQP4SEGl3VFPs7o9jMaB7E?=
 =?iso-8859-1?Q?CRvLnL2z8UhQleFRWNnbg7JvLZAhUHoTa1dkQVHavjOGi1n96uwHq5W3n7?=
 =?iso-8859-1?Q?SdmTqMZTmLnJsbExyhSd/u4kI1KEt8gSj4v6tRoOLQFBvRPpqmu5RHtYmi?=
 =?iso-8859-1?Q?UpzpIFYwXtmsxq0zbcoede3ImDQiMWMqAT/eroMGU24tRyNtVVhhi3SnL3?=
 =?iso-8859-1?Q?uuAdS0em8MGyP1awQPMdQ8zkLmdBnBUmAR3YmTGRqqsxyVqh0GJXBapf4t?=
 =?iso-8859-1?Q?G0EWZqlz4KC9iyNz4ZtMt8Kb7O/LwWhfS0+DiaKOOnbC4K83z5GVemslAx?=
 =?iso-8859-1?Q?kNTNVzT6TFFqKbTJRllqo2YUHNcLDIF7Lh6u4Io9FbxOx19gNn+hcx6RBt?=
 =?iso-8859-1?Q?IlC2m6WpAUOwh2xShj+6O7E7cW1vVFyUPhYT2zxIFkH5YvJPgKQjGy3l+P?=
 =?iso-8859-1?Q?qyV/uxdb5R8GdhFhetR17oChsQ77WQsQirTj/rwYv5NoggbMoM1wgV2umP?=
 =?iso-8859-1?Q?1GrCQNLru3H8lmdqPRn9fSIejMRMG0xfiYQhM1ulPxpuiXO9Svfm+zQ+Me?=
 =?iso-8859-1?Q?VeFNLMm0uALZ6TfRtTvKGeJ5qhFfTnDiezj7RfGVqaqJXYsisttJElwwWR?=
 =?iso-8859-1?Q?Fa0m4XwsCn1wG/kbXa3luiueM2+gl226wfZJ0vboN5pTSN0qsi81uU58Vu?=
 =?iso-8859-1?Q?katOcyQqMMa1VrHizPlnEU7u+OXWMBkQvZihmFgZiVtkSOp2SEbDdsaHCR?=
 =?iso-8859-1?Q?REd0Hp0OL//RAOMC9PwpQgdlBDefxy32TrAqYOLcCs/3QzJiaBSFYeq3lP?=
 =?iso-8859-1?Q?qNIFus8MD6VoctZjVFQ7iw6RHIYARdIRlz?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d669d4cd-9151-49ca-0c9f-08dda840350e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:59:47.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rqdmfytzZL4R12TO1DXukdsbf6D3FGoBISLLBxl3LkwHw+8Xno5lwrk2eoYiItq/tGQmnyOOtpNNm/c4ij0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzNyBTYWx0ZWRfX0T2IpCs7UkBy
 OtFLDoDsGrfH7y0YkO/gxQaYpZ8C9PxE5THNhuAtNiGuNye5WEM4tN7oTbXlTSbWmopwxr1aOmF
 AEdpjlFmVjA2C3vIyoi3UdAJzpfu8UgNeOo+avkj8hUrmxarGgThOmpOrhGwDve37SyqLTxnRzC
 z8+MsG662noqT4RE2Ogn9F2b6EX3bz7WGlXeN0iZtcUqF6stCdNw/f9HNRd+OVuJhAqRQkJIO9q
 hifwz2YULFrRz+5mqlsuKmJqkt2pPAgW27KrBvBtqH2HgFSL45nFKZlvaDeOq+EGh9o6oHLqxJd
 pWcURoheA5xJu9eU2w9dV1MMOqgsZwnN4kS3VNiu/eot9jwRkDSR8cupPn4yR+7Ma9bw9/lCDF4
 3tFNCm2rWRjRGWWBCqFKmz+/F5zcXrs0mAL7LZF+wVzF5QKrY0Px9D+M+bSTYqJZHq7n/oDR
X-Authority-Analysis: v=2.4 cv=KOtaDEFo c=1 sm=1 tr=0 ts=68486488 cx=c_pps
 a=VQV0i9s3/jMECRWyVTU93Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=UF_GpJYHLsthOnA7oYEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 3t1z8D3396xH9XdyREq_E3F14FBJ_NxO
X-Proofpoint-ORIG-GUID: 3t1z8D3396xH9XdyREq_E3F14FBJ_NxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 10, 2025 at 09:42:41AM +0200, Cédric Le Goater wrote:

> > @@ -478,9 +491,14 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
> >       for (i = 0; i < vbasedev->num_regions; i++) {
> >           g_free(vbasedev->reginfo[i]);
> > +        if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
> > +            close(vbasedev->region_fds[i]);
> > +        }
> > +
> 
> Adding a small helper to retrieve the region fd from the cache,
> would hide some of the implementation details here and below in
> vfio_region_mmap()

I can add a region_get_fd() helper, but I can't use it here - we should only
close the fd if it's a per-region fd. I'll make this call a region_cleanup() or
similar.

regards
john

