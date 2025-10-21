Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7E9CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF3L-0007Op-Fy; Tue, 21 Oct 2025 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vBF2p-0006tW-Sx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vBF2i-00021G-Js
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:17:07 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59LEqq4H1324130; Tue, 21 Oct 2025 09:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Xco6K8RsAYFqZcDBbh+Bu7RVjeUJUpgN1Zcwhe6e5
 kE=; b=GNf9Lf69lhfwq9vyVqIg39OTpYyDJ8XiZOVwLiA3kkdqhaXFnj8k2f5T7
 3VoxuVdOmZy7dnjQMh7nFRXQyHvb2xQTn2VqKi5Gtx7/Y8RTdjS5sRMPPPzZEWZO
 V8ahHSsgH1sNZzIiAelyXoABizQVCIbVUAkj8JMQHyDuSm739Le23ShZsHG5ZfRD
 pImykDAxOZUsiPLddhCvZVx3xkR3Jl6wPNouvHM1E2Ny6QdhYasgcSa9fgGWT8aN
 2l36QBZL0JcZRADZWasA6lW1A2WgMAU0en9AErGaYJoZE4Jm5oLxwpmRW+9HqCsF
 kojzH1qCCEnkI3nt3m5qdMsvPlRSg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021141.outbound.protection.outlook.com [40.107.208.141])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49v77s61wp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 09:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7a8OsPYBgKxk5vrQ2IF2o9pWyRD5kCmm7v0J1MFh+yhxvI92jnUFly+f4JMdTAz8OjppaD5pfjR41WL+AJofy2DitCi30mDjncsj+muYxH/A698bQ8D16HVp3M+QwByVFHmqSkfB0EzR7njuufWXkLXWtNN9Mr0GVuRWiJVSk7HLWQmsfVAOvWtkqdn/d/Nh2prFlNLx5ffX88m6xNs0KZK87ZlD08mvVYdnmrCoNRHtoJWxHrwphqOCtFo55zFuAarcVq2BLBVrqavyxSIZl0gprzYsCLjYrQj1npYOeOjH3lbmIo8rQKJuQu+kGpVOGkwMBwJ4b7QkMfCvlLFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xco6K8RsAYFqZcDBbh+Bu7RVjeUJUpgN1Zcwhe6e5kE=;
 b=LvhscYrYfr9z2hkYmrsiLx8ZKE+SOD9LjGl39JFm/6HkAjMruSNgE/7+PI4ar8mDIplCAvQbzu6E/ccMNBTWck6SSo7cuTik7lMDh0708uoqCi7oKrPXEfhvROvaO+mPQlN2UOG+S6bA5DT6s76iKhp+qdSixXv+liWMx+gJKcOqBdTYevZy3Y/W7gm0BabngLqt+1TnncLuvaBYPw6J7AmP6YH9Kd7O27f6O9oRmpMG9EqVUFCqXPRGJMdVglVjcBYBLPXCFI+VTXkNgwx3eVCtEHZxVDrNBZO9RBjhCGLIpbAIlj3Bf/YMsBL0Fqo+jpbLm3hOdxS5GDfF1amcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xco6K8RsAYFqZcDBbh+Bu7RVjeUJUpgN1Zcwhe6e5kE=;
 b=xtpmyTbjsXh2oow+Ey+MH6QOYZ+LGzMIXSzzJZn2T0gE4u9eo4JBYEVLwsZpwMYbM7CD1LhXXqkei75jgO9DNkVrA1Evuvi9CJSFgy17oc27lIHs5EfTlLGFEilZLq+nVXQLHgoRVBOZQk4HTfZZIyQLWh1X3En9tMJU0TaRuVdhy81QmKoDybKAH8vdJHtZM17BfiG3MmajLCrJkWuISAFaiXVpRHKXCZfVpq/Cwrnj6SmaTbop5Us+BtMQv0GPig4mJbOAXAAGpidYY/FNnOr2iwZ6wooOTEmmy2VG6irlc1S8RWVdADanxdaxXUOsJYFLOQP0Qn+VJVeYKGQ0Vw==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by PH7PR02MB9968.namprd02.prod.outlook.com (2603:10b6:510:2f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 16:16:48 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::135b:f187:c695:7c90%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:16:48 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Manish Mishra
 <manish.mishra@nutanix.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Topic: [PATCH v6 2/2] QIOChannelSocket: flush zerocopy socket error
 queue on sendmsg failure due to ENOBUF
Thread-Index: AQHcPCLQIrO+EaLeX0uyMT4Fy7m+a7S/0e+AgA0B8YA=
Date: Tue, 21 Oct 2025 16:16:48 +0000
Message-ID: <2183D087-3126-4928-9DBE-750E641B519B@nutanix.com>
References: <20251013092126.3480671-1-tejus.gk@nutanix.com>
 <20251013092126.3480671-3-tejus.gk@nutanix.com> <aOzIiVdUCoNKoWb5@redhat.com>
In-Reply-To: <aOzIiVdUCoNKoWb5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|PH7PR02MB9968:EE_
x-ms-office365-filtering-correlation-id: 6f22b23a-b301-462d-5381-08de10bd3c69
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eFhWejA1dFh5WmlaakY3TWhSWkFCZTltKzkxNGl6NThra3JmaXV1RlpWNnZp?=
 =?utf-8?B?ay9QVjNnNUVnNXpKdVMzNjZPQlNJK0lDd0JQcSswOFZUYk9XbXpKSnVSN2p6?=
 =?utf-8?B?R2ROSDBMRVF2WWtqT2dHdzh5ODlOYmFITDFJSFhXb0JDMjFTN255N3o2SFBG?=
 =?utf-8?B?Tng4eExYR0hpK0p5ZnYwblRZTWVYdXNRbWJId2hCeXlFbG5IOGkzVDRZNEJu?=
 =?utf-8?B?SWJsb0Q0L2QzMzgzVnorODJVU2dhblZTMkdtUmsxMTE1TGFsWGo1SDZwMlFV?=
 =?utf-8?B?aUhMMytST0g2RG9EZmVwZmN3aldNb1JabDVRR0tEczFyNWN1WDVmTlNLYmtq?=
 =?utf-8?B?ZVNaa016M0VYSmRGcjRKMTh4bTNpNlJTK3orRVFYVWRQMFFDN2YzY2lmRURO?=
 =?utf-8?B?OUFyTXpNRzZJTUs4SmhRbWJ6VHdGd01iTlA4WXR1ODJwRlI2dDhHR2drMEJt?=
 =?utf-8?B?SklHWGl3dWNlT1lIcDlrWTBPUlhjUVdWb25nTCtPdDcwZDFIU1hVajVPWlFZ?=
 =?utf-8?B?YVJqZUJGbm5JMFFISTBYNTZIbVBJSTIxWmZvVWlKY0hLNjJPeVM4T3RuWUlr?=
 =?utf-8?B?R2lkb3BkbWhkd0RXN2FZSnBLdk15b3Z4aGtYMXRBako2SkNqV1NXM2tBZ2pW?=
 =?utf-8?B?eEdKWi9nZ2crU2pjS1c4eGVOeDVqYUtmM0NYcklQWGNLcWZFS3VJTWlFYlBy?=
 =?utf-8?B?L0VHTHN2TUZpOXF2RmpWcWxNTXZTMEM4WG9jZmgvdSsrempOUWVIK084bnU1?=
 =?utf-8?B?ZDd1Q3pRaGtGQ1VUSVA2SXhTVHhUeXpwa2Y0YXRGYmVyVzF3aENtc0p4YU1E?=
 =?utf-8?B?SFhIYVRJTFJybElIcGJtbURFcE1IZmtUdS9Ldnd1N2pTcGxKeHpUcituOXdL?=
 =?utf-8?B?SUdCVHpTMDdrdG5SVzBEQnpKb05tL3lzenM5a2lBcGNWN3ZreU9HU2dCRUtI?=
 =?utf-8?B?RWpZSTNvaEVJMVlEVUl5bXhkWEZINUhxUTBURUZzZ21BSVg2K2FLeHhNMi9m?=
 =?utf-8?B?eFk5RWkrUVJnOFp6VUR1Y2ozTUFYdHpSVlJOenYyWGtzSzhVU0syZExaZVJx?=
 =?utf-8?B?TDlrR3hMVk1TcTBEN2ZQeExPMFN1T3VQVlIwOEFzTkV3UHRlS3h1aUk0R1Rj?=
 =?utf-8?B?ZW5JM2RxbU5BMW1ka1BaN3pnNjFzdUVmcUFoeHpFR1Qrbml3eTdISno4Z3Vx?=
 =?utf-8?B?RFA1ZlNZektMczJtUnNSbER0ZUNhWXpUTmhibVNZMnJhUEhrYWlPbkxIejhO?=
 =?utf-8?B?UjZWTTdRUEN6U05yWmxFZ21ENnBrMDFnOXNBMTYvM3ZHZ2hJbmUyeGVNUU5x?=
 =?utf-8?B?amtsWnlhV0kxcFQxZTB4Y3lrZTZoV1pSMTdIb2ZxbWg3RnFaUlNPS2hUMDFp?=
 =?utf-8?B?SjFmZUNpWkhhTHVtT3RKUllnM25uK2tQOUpsOWZpKzc2K2I1Nnh2OW5BdzZP?=
 =?utf-8?B?TE4yNzFTOXE5T2dMMHBkZUxFcmlrT1AzRkxQdm8wUXdQQzJzKzl0b0VEZkJI?=
 =?utf-8?B?U3hYbHU4azhLcVIySDJYU2tPZnhwNGxsOUhsMnNkTkRKZWJaTTB6NXY0STdi?=
 =?utf-8?B?SzI1UVpJblFadjNadXdtcmJKem1hYlhabkU2dFc3cktNUXRNYk1PbExMZHEx?=
 =?utf-8?B?dE9NaVdFMkdUUWE3YTVnTXhabUtlZng1dE5uUFJuK3Z5TUFuMUZXZnlnRWdH?=
 =?utf-8?B?ekk3bU5NZFlmeDQvdm5vc0lPbURKZk5tQTgzU3Nub1M2WE92djgrc3c5anE4?=
 =?utf-8?B?eFpiQjNZeTNqd3k4bzR0cGkwT0xQbWZGTFZMOFdGMktXa0RJT0doR1FGb3Za?=
 =?utf-8?B?VDhnTzRUYkRkb2RvNWF2a0lWWGVQSnhGdDhLWEJhTExyY2tPS3htR3orQXRN?=
 =?utf-8?B?bGQ5K09aYnRPQ3oxZHVUd0RrMEwwT2Vmc2RyN0JpamRvYVVqZUNKQXpxcERW?=
 =?utf-8?B?d041dm5WVGM1S2JMWUxFZm01V3BBYUxvbXJ0bHB4TDREaHNlbVVjVzdWN2FQ?=
 =?utf-8?B?Ykl0Titpa0NyRVJYekp0UVRkK0NWKzZRWFNJUzZ6d2tyOWZLOHNmZE95VHRt?=
 =?utf-8?Q?htjRn0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3ozVkFqV2NVV1dVSERoY2hLejdaUy9PUFRLckpUd3p1SkVERmRjeWJkaHhl?=
 =?utf-8?B?d3ZDa1VaUUxsbThCWGhCVVpTa0lkRU5jYlRkRUJhbS8wcEFVY1Rwcnpza3Fa?=
 =?utf-8?B?VHNSWDRWbGtSazZRZW5aVklGdkFEbWZsdzlkbWIvM1lObzB6SGt1U1plNVVX?=
 =?utf-8?B?RXd4MFdiY1I2QXV1Y2FneVBJdlk3Wm9PV1N4UURNd3FqUVNQZjNYVWRxMHdm?=
 =?utf-8?B?QlR6V281MjRKeEZDWm1DUDVIUUlGYTgxQTRDM0NoTjEzd25zUTZhK1lXbjJZ?=
 =?utf-8?B?TEMvbTRDRmJEL3k0Y25oWnBzZmtHWkhUcnZFeThRdWhURk90Z1hOTjlXcDZ5?=
 =?utf-8?B?Zyt3cjlNWVVrbG5IOHR6TWR2V29sdzlXSzdkQWwrc3QzdEZERXY0cHFiTTZu?=
 =?utf-8?B?U2RzN2tsc3g3QXJ4Y1JMbUJEWnZnTTdwRU9KWllTZHlFSHpHOSs3UFg3YWo5?=
 =?utf-8?B?UStjNitFYjVvWFZaT1BwVjhuVlA1OEpiaEZQRVYrbGpIN1J1OE1QUXFnaDhp?=
 =?utf-8?B?akRFRFVyVHJmYWlEK0MzQ3I0amlyTjBvMEdlbzVUL0FjMG9wTHUwcDA5dVI3?=
 =?utf-8?B?WEV3UllybXRaZHhnQ25uaWZVMGYvMlVybk0yM0xPNGF5emJ3MmEvbE9VbFdN?=
 =?utf-8?B?NXVRQzJ0UVYwRGZKdGJsR2tHekpUTTNuZFp2MXpqc1Q1TTlBVnVLNEJrdmNJ?=
 =?utf-8?B?OXNDVGpyakZzaG9Qck9qWUtTTURLU0hibWhEVDR2S0tjaTBCUlNmS2phdFdv?=
 =?utf-8?B?bTNHWUVGR3JsOUlNNFNBYXBsVG4zTjlZMEZTYzVEMDZEWCtmT1FORnNxMENx?=
 =?utf-8?B?bDZyVnNTNkdzamZJSlpGM1d5RjI1UmtmVEJsdXVwd2NRSUtvL3QyS3pKbGR2?=
 =?utf-8?B?My9PL0MwMWh3aERLM3BCTnJyUXVQVnhsR0ovQWt1dzNXcmZ4aU1lVktKRzY2?=
 =?utf-8?B?UGgyRnBuMlJrOVdLcHRRUGdpSUlPL1l5T3V1aEFYUm4xL2xaNDR1VWVSWHY0?=
 =?utf-8?B?MDNkKzJqVytGQjFMUitpbk9QZ1ljQ2VSbWd0VHlyZldDNGFkbGxZYVVhR2kv?=
 =?utf-8?B?UnRLaU9LanhPSXlnSEwrMUpRUGVuMVJwRWJSWlc4OXdkb3ZQS1BzZ3FXeGg2?=
 =?utf-8?B?LzRpdkVNTFhmTTF6d0I2YmoyOEFqWndWUDR4L2FXSUZnTDQ5RTllVm42V2dw?=
 =?utf-8?B?WnFBWkNBN0t3cXorR216VFQ0Vmkyb3dNc2RvZ2kwUUNXekJnb25DTlBaa1pC?=
 =?utf-8?B?Y1lsR1RzYmxDeW1GdktuU0trbSs2K2N5R1dVVm0zY0kzQS9vRUJxdDZNbFlj?=
 =?utf-8?B?ZndGbnBOMmdyY256dXJFYnR2SFB3dGpWWHpEdWVQT0RKc3AvZGpCSW9YR3ln?=
 =?utf-8?B?ajZoNEZ3elpwaEJodVpsaHpRVUJIYkZ0eUVuN3g0eGM2NmpOZll5dWpnbVMr?=
 =?utf-8?B?UzRsQjhheldGYTk3RjUycG5WVFVTbDZlMkQ5aktGSVg3U3ZLcEtLdlhqZTFD?=
 =?utf-8?B?dmE5c1J2aWJJK0hFTytZOUpIN1h0QjZpeHFJby9WMjJGRDMxUk5CZ0hTZWdD?=
 =?utf-8?B?SmFrLzRXbnJLeWdTcEg3NHNwanJ0OEdsaGpEb3hGMlZMQ1JOREI1SWNVYXVm?=
 =?utf-8?B?UUd6Smc0cHVWbGJkWlU1WnY5YUcyZENRelBzTWJnL1d2ZGlTUk41Y293ZE9C?=
 =?utf-8?B?SEpPTklhM1hPdVlRejJzWnVLbU9HRDNXa0kyMzh4Mk1YT1hmbnVtdkc0V1J3?=
 =?utf-8?B?VVZsRWJzNS92WlU2OExwK2xPdEoyc3N4WGZGWWZHMmFCR2tjNTNpSlpkSm9N?=
 =?utf-8?B?emlQV284bWI4ZTRTV0dGMjVRRXlNYzRwNnA4aWN2SmZEa0dWSjFuWTRMMEt6?=
 =?utf-8?B?NHZhVUwweUN0cFR0RlcwK2h0SmJoVnpTRXEwRWlqcC9XS0N6Z0YyV0t2Y0Ey?=
 =?utf-8?B?aVNWM2FPZVc2WlNUV2dRc2pUZzdwak1Oa0VHcWp1MWduYnhqVEJWZVNMNkFl?=
 =?utf-8?B?MG5BYXJJczY4dWVLenVHK3lhc3NVeXFDT2F0emU5YVY2cjBHNVdiUGYxT2s3?=
 =?utf-8?B?SmpwajFLNlRWQyt4aDlsU1dmamRBRHNQTlJSVkpGVUVMOUgvU0ZURnQwYXBv?=
 =?utf-8?B?aHFYMWpFTGcrNGtzU3dsV0lBNnM2ZEcrMyt6ZTg5YmNJVTJTTHFqQzZDTi90?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8770DA66D862544C823579B55DFA3A6A@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f22b23a-b301-462d-5381-08de10bd3c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 16:16:48.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4Swkk88E+XIGkKNTxK3CX1DLmOaVv0yjzVZc/s0x7tbb4gvXOHFtlHwUII6Or5OKvJrk9o49slzlXdysaeN4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9968
X-Proofpoint-ORIG-GUID: FiC8PESEnkrEHkwp2_iX9ZALc2DNPkFx
X-Proofpoint-GUID: FiC8PESEnkrEHkwp2_iX9ZALc2DNPkFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEyOSBTYWx0ZWRfX/rFnRGmCJezY
 3RgHp56kUdyX/0NqmIyMSIc3Zt5tnSsmjctrd07qQZKRHzZKAOVMEotXiQT4EDpBTnvU61bCFuM
 oj1pwYPcm/MDxZZ6puFyXXCV4SmtZLgzl3npmxeRrd2hJ6HG9Ij4RYkIk7LeFIZ6XqQXZQSplE+
 bjUWA4rVDZK/UL9IEmU+m2MkDBvuobgZOT94/NKjHyVU7AX1b9TGcsUCcx4ibxJuMgZiykf9oUs
 LnzuJDKVUvlHDWW0mr7vv6cGCGlC82Q/+u0ZU88Quhs7uQXvsGhSbzbYW8Y7DcVhKs4ibWo0XG5
 Xcls3+NSS4hKeQqJyQNDLW5eWbCa4bDqbsX9fVAJzXclnJRY9XS0XU5+mUmx10KPheLiamXP9B0
 bu7JX/o6iqatT94dcknqMEHg5iwR5w==
X-Authority-Analysis: v=2.4 cv=FrYIPmrq c=1 sm=1 tr=0 ts=68f7b1f5 cx=c_pps
 a=azlkv/KBQR0ub+Yip4pvTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=5X21UdQq0W6vczluSfAA:9
 a=QEXdDO2ut3YA:10 a=pRRNJOJqb3sA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

DQoNCj4gT24gMTMgT2N0IDIwMjUsIGF0IDM6MDjigK9QTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIE1vbiwgT2N0
IDEzLCAyMDI1IGF0IDA5OjIxOjIyQU0gKzAwMDAsIFRlanVzIEdLIHdyb3RlOg0KPj4gRnJvbTog
TWFuaXNoIE1pc2hyYSA8bWFuaXNoLm1pc2hyYUBudXRhbml4LmNvbT4NCj4+IA0KPj4gVGhlIGtl
cm5lbCBhbGxvY2F0ZXMgZXh0cmEgbWV0YWRhdGEgU0tCcyBpbiBjYXNlIG9mIGEgemVyb2NvcHkg
c2VuZCwNCj4+IGV2ZW50dWFsbHkgdXNlZCBmb3IgemVyb2NvcHkncyBub3RpZmljYXRpb24gbWVj
aGFuaXNtLiBUaGlzIG1ldGFkYXRhDQo+PiBtZW1vcnkgaXMgYWNjb3VudGVkIGZvciBpbiB0aGUg
T1BUTUVNIGxpbWl0LiBUaGUga2VybmVsIHF1ZXVlcw0KPj4gY29tcGxldGlvbiBub3RpZmljYXRp
b25zIG9uIHRoZSBzb2NrZXQgZXJyb3IgcXVldWUgYW5kIHRoaXMgZXJyb3IgcXVldWUNCj4+IGlz
IGZyZWVkIHdoZW4gdXNlcnNwYWNlIHJlYWRzIGl0Lg0KPj4gDQo+PiBVc3VhbGx5LCBpbiB0aGUg
Y2FzZSBvZiBpbi1vcmRlciBwcm9jZXNzaW5nLCB0aGUga2VybmVsIHdpbGwgYmF0Y2ggdGhlDQo+
PiBub3RpZmljYXRpb25zIGFuZCBtZXJnZSB0aGUgbWV0YWRhdGEgaW50byBhIHNpbmdsZSBTS0Ig
YW5kIGZyZWUgdGhlDQo+PiByZXN0LiBBcyBhIHJlc3VsdCwgaXQgbmV2ZXIgZXhjZWVkcyB0aGUg
T1BUTUVNIGxpbWl0LiBIb3dldmVyLCBpZiB0aGVyZQ0KPj4gaXMgYW55IG91dC1vZi1vcmRlciBw
cm9jZXNzaW5nIG9yIGludGVybWl0dGVudCB6ZXJvY29weSBmYWlsdXJlcywgdGhpcw0KPj4gZXJy
b3IgY2hhaW4gY2FuIGdyb3cgc2lnbmlmaWNhbnRseSwgZXhoYXVzdGluZyB0aGUgT1BUTUVNIGxp
bWl0LiBBcyBhDQo+PiByZXN1bHQsIGFsbCBuZXcgc2VuZG1zZyByZXF1ZXN0cyBmYWlsIHRvIGFs
bG9jYXRlIGFueSBuZXcgU0tCLCBsZWFkaW5nDQo+PiB0byBhbiBFTk9CVUYgZXJyb3IuIERlcGVu
ZGluZyBvbiB0aGUgYW1vdW50IG9mIGRhdGEgcXVldWVkIGJlZm9yZSB0aGUNCj4+IGZsdXNoIChp
LmUuLCBsYXJnZSBsaXZlIG1pZ3JhdGlvbiBpdGVyYXRpb25zKSwgZXZlbiBsYXJnZSBPUFRNRU0g
bGltaXRzDQo+PiBhcmUgcHJvbmUgdG8gZmFpbHVyZS4NCj4+IA0KPj4gVG8gd29yayBhcm91bmQg
dGhpcywgaWYgd2UgZW5jb3VudGVyIGFuIEVOT0JVRiBlcnJvciB3aXRoIGEgemVyb2NvcHkNCj4+
IHNlbmRtc2csIGZsdXNoIHRoZSBlcnJvciBxdWV1ZSBhbmQgcmV0cnkgb25jZSBtb3JlLg0KPj4g
DQo+PiBDby1hdXRob3JlZC1ieTogTWFuaXNoIE1pc2hyYSA8bWFuaXNoLm1pc2hyYUBudXRhbml4
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFRlanVzIEdLIDx0ZWp1cy5na0BudXRhbml4LmNvbT4N
Cj4+IC0tLQ0KPj4gaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oIHwgIDUgKysrDQo+PiBpby9j
aGFubmVsLXNvY2tldC5jICAgICAgICAgfCA3NSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+PiAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0
aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5o
IGIvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oDQo+PiBpbmRleCAyNjMxOWZhOThiLi5mY2Zk
NDg5YzZjIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9pby9jaGFubmVsLXNvY2tldC5oDQo+PiAr
KysgYi9pbmNsdWRlL2lvL2NoYW5uZWwtc29ja2V0LmgNCj4+IEBAIC01MCw2ICs1MCwxMSBAQCBz
dHJ1Y3QgUUlPQ2hhbm5lbFNvY2tldCB7DQo+PiAgICAgc3NpemVfdCB6ZXJvX2NvcHlfcXVldWVk
Ow0KPj4gICAgIHNzaXplX3QgemVyb19jb3B5X3NlbnQ7DQo+PiAgICAgYm9vbCBibG9ja2luZzsN
Cj4+ICsgICAgLyoqDQo+PiArICAgICAqIFRoaXMgZmxhZyBpbmRpY2F0ZXMgd2hldGhlciBhbnkg
bmV3IGRhdGEgd2FzIHN1Y2Nlc3NmdWxseSBzZW50IHdpdGgNCj4+ICsgICAgICogemVyb2NvcHkg
c2luY2UgdGhlIGxhc3QgcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNoKCkgY2FsbC4NCj4+ICsgICAg
ICovDQo+PiArICAgIGJvb2wgbmV3X3plcm9fY29weV9zZW50X3N1Y2Nlc3M7DQo+PiB9Ow0KPj4g
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9pby9jaGFubmVsLXNvY2tldC5jIGIvaW8vY2hhbm5lbC1z
b2NrZXQuYw0KPj4gaW5kZXggOGIzMGQ1YjdmNy4uN2NkOWYzNjY2ZCAxMDA2NDQNCj4+IC0tLSBh
L2lvL2NoYW5uZWwtc29ja2V0LmMNCj4+ICsrKyBiL2lvL2NoYW5uZWwtc29ja2V0LmMNCj4+IEBA
IC0zNyw2ICszNywxMiBAQA0KPj4gDQo+PiAjZGVmaW5lIFNPQ0tFVF9NQVhfRkRTIDE2DQo+PiAN
Cj4+ICsjaWZkZWYgUUVNVV9NU0dfWkVST0NPUFkNCj4+ICtzdGF0aWMgaW50IHFpb19jaGFubmVs
X3NvY2tldF9mbHVzaF9pbnRlcm5hbChRSU9DaGFubmVsICppb2MsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBibG9jaywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4g
KyNlbmRpZg0KPj4gKw0KPj4gU29ja2V0QWRkcmVzcyAqDQo+PiBxaW9fY2hhbm5lbF9zb2NrZXRf
Z2V0X2xvY2FsX2FkZHJlc3MoUUlPQ2hhbm5lbFNvY2tldCAqaW9jLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+IEBAIC02Niw2ICs3Miw3
IEBAIHFpb19jaGFubmVsX3NvY2tldF9uZXcodm9pZCkNCj4+ICAgICBzaW9jLT56ZXJvX2NvcHlf
cXVldWVkID0gMDsNCj4+ICAgICBzaW9jLT56ZXJvX2NvcHlfc2VudCA9IDA7DQo+PiAgICAgc2lv
Yy0+YmxvY2tpbmcgPSBmYWxzZTsNCj4+ICsgICAgc2lvYy0+bmV3X3plcm9fY29weV9zZW50X3N1
Y2Nlc3MgPSBGQUxTRTsNCj4+IA0KPj4gICAgIGlvYyA9IFFJT19DSEFOTkVMKHNpb2MpOw0KPj4g
ICAgIHFpb19jaGFubmVsX3NldF9mZWF0dXJlKGlvYywgUUlPX0NIQU5ORUxfRkVBVFVSRV9TSFVU
RE9XTik7DQo+PiBAQCAtNjE4LDYgKzYyNSw4IEBAIHN0YXRpYyBzc2l6ZV90IHFpb19jaGFubmVs
X3NvY2tldF93cml0ZXYoUUlPQ2hhbm5lbCAqaW9jLA0KPj4gICAgIHNpemVfdCBmZHNpemUgPSBz
aXplb2YoaW50KSAqIG5mZHM7DQo+PiAgICAgc3RydWN0IGNtc2doZHIgKmNtc2c7DQo+PiAgICAg
aW50IHNmbGFncyA9IDA7DQo+PiArICAgIGJvb2wgYmxvY2tpbmcgPSBzaW9jLT5ibG9ja2luZzsN
Cj4+ICsgICAgYm9vbCB6ZXJvY29weV9mbHVzaGVkX29uY2UgPSBmYWxzZTsNCj4+IA0KPj4gICAg
IG1lbXNldChjb250cm9sLCAwLCBDTVNHX1NQQUNFKHNpemVvZihpbnQpICogU09DS0VUX01BWF9G
RFMpKTsNCj4+IA0KPj4gQEAgLTY2NCw5ICs2NzMsMjQgQEAgc3RhdGljIHNzaXplX3QgcWlvX2No
YW5uZWxfc29ja2V0X3dyaXRldihRSU9DaGFubmVsICppb2MsDQo+PiAgICAgICAgICAgICBnb3Rv
IHJldHJ5Ow0KPj4gICAgICAgICBjYXNlIEVOT0JVRlM6DQo+PiAgICAgICAgICAgICBpZiAoZmxh
Z3MgJiBRSU9fQ0hBTk5FTF9XUklURV9GTEFHX1pFUk9fQ09QWSkgew0KPj4gLSAgICAgICAgICAg
ICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLA0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICJQcm9jZXNzIGNhbid0IGxvY2sgZW5vdWdoIG1lbW9yeSBmb3IgdXNp
bmcgTVNHX1pFUk9DT1BZIik7DQo+PiAtICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4+ICsg
ICAgICAgICAgICAgICAgLyoqDQo+PiArICAgICAgICAgICAgICAgICAqIFNvY2tldCBlcnJvciBx
dWV1ZWluZyBtYXkgZXhoYXVzdCB0aGUgT1BUTUVNIGxpbWl0LiBUcnkNCj4+ICsgICAgICAgICAg
ICAgICAgICogZmx1c2hpbmcgdGhlIGVycm9yIHF1ZXVlIG9uY2UuDQo+PiArICAgICAgICAgICAg
ICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICBpZiAoIXplcm9jb3B5X2ZsdXNoZWRfb25jZSkg
ew0KPj4gKyAgICAgICAgICAgICAgICAgICAgcmV0ID0gcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNo
X2ludGVybmFsKGlvYywgYmxvY2tpbmcsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCk7DQo+PiArICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtMTsNCj4+ICsgICAgICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAgICAgICAg
IHplcm9jb3B5X2ZsdXNoZWRfb25jZSA9IFRSVUU7DQo+PiArICAgICAgICAgICAgICAgICAgICBn
b3RvIHJldHJ5Ow0KPj4gKyAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIlByb2Nlc3MgY2FuJ3QgbG9jayBlbm91Z2ggbWVtb3J5
IGZvciAiDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ1c2luZyBN
U0dfWkVST0NPUFkiKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4+ICsg
ICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgYnJlYWs7
DQo+PiAgICAgICAgIH0NCj4+IEBAIC03NzcsOCArODAxLDkgQEAgc3RhdGljIHNzaXplX3QgcWlv
X2NoYW5uZWxfc29ja2V0X3dyaXRldihRSU9DaGFubmVsICppb2MsDQo+PiANCj4+IA0KPj4gI2lm
ZGVmIFFFTVVfTVNHX1pFUk9DT1BZDQo+PiAtc3RhdGljIGludCBxaW9fY2hhbm5lbF9zb2NrZXRf
Zmx1c2goUUlPQ2hhbm5lbCAqaW9jLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEVycm9yICoqZXJycCkNCj4+ICtzdGF0aWMgaW50IHFpb19jaGFubmVsX3NvY2tldF9m
bHVzaF9pbnRlcm5hbChRSU9DaGFubmVsICppb2MsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBibG9jaywNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiB7DQo+PiAgICAg
UUlPQ2hhbm5lbFNvY2tldCAqc2lvYyA9IFFJT19DSEFOTkVMX1NPQ0tFVChpb2MpOw0KPj4gICAg
IHN0cnVjdCBtc2doZHIgbXNnID0ge307DQo+PiBAQCAtNzg2LDcgKzgxMSw2IEBAIHN0YXRpYyBp
bnQgcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNoKFFJT0NoYW5uZWwgKmlvYywNCj4+ICAgICBzdHJ1
Y3QgY21zZ2hkciAqY207DQo+PiAgICAgY2hhciBjb250cm9sW0NNU0dfU1BBQ0Uoc2l6ZW9mKCpz
ZXJyKSldOw0KPj4gICAgIGludCByZWNlaXZlZDsNCj4+IC0gICAgaW50IHJldDsNCj4+IA0KPj4g
ICAgIGlmIChzaW9jLT56ZXJvX2NvcHlfcXVldWVkID09IHNpb2MtPnplcm9fY29weV9zZW50KSB7
DQo+PiAgICAgICAgIHJldHVybiAwOw0KPj4gQEAgLTc5NiwxNiArODIwLDIwIEBAIHN0YXRpYyBp
bnQgcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNoKFFJT0NoYW5uZWwgKmlvYywNCj4+ICAgICBtc2cu
bXNnX2NvbnRyb2xsZW4gPSBzaXplb2YoY29udHJvbCk7DQo+PiAgICAgbWVtc2V0KGNvbnRyb2ws
IDAsIHNpemVvZihjb250cm9sKSk7DQo+PiANCj4+IC0gICAgcmV0ID0gMTsNCj4+IC0NCj4+ICAg
ICB3aGlsZSAoc2lvYy0+emVyb19jb3B5X3NlbnQgPCBzaW9jLT56ZXJvX2NvcHlfcXVldWVkKSB7
DQo+PiAgICAgICAgIHJlY2VpdmVkID0gcmVjdm1zZyhzaW9jLT5mZCwgJm1zZywgTVNHX0VSUlFV
RVVFKTsNCj4+ICAgICAgICAgaWYgKHJlY2VpdmVkIDwgMCkgew0KPj4gICAgICAgICAgICAgc3dp
dGNoIChlcnJubykgew0KPj4gICAgICAgICAgICAgY2FzZSBFQUdBSU46DQo+PiAtICAgICAgICAg
ICAgICAgIC8qIE5vdGhpbmcgb24gZXJycXVldWUsIHdhaXQgdW50aWwgc29tZXRoaW5nIGlzIGF2
YWlsYWJsZSAqLw0KPj4gLSAgICAgICAgICAgICAgICBxaW9fY2hhbm5lbF93YWl0KGlvYywgR19J
T19FUlIpOw0KPj4gLSAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAgICAgICAgICAg
ICAgaWYgKGJsb2NrKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICogTm90aGluZyBvbiBlcnJxdWV1ZSwgd2FpdCB1bnRpbCBzb21ldGhpbmcg
aXMNCj4+ICsgICAgICAgICAgICAgICAgICAgICAqIGF2YWlsYWJsZS4NCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAqLw0KPj4gKyAgICAgICAgICAgICAgICAgICAgcWlvX2NoYW5uZWxfd2FpdChp
b2MsIEdfSU9fRVJSKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiANCj4g
V2h5IEdfSU9fRVJSID8gIElmIHdlJ3JlIHdhaXRpbmcgZm9yIHJlY3Ztc2coKSB0byBiZWNvbWUg
cmVhZHksIHRoZW4NCj4gaXQgd291bGQgbmVlZCB0byBiZSBHX0lPX0lOIHdlJ3JlIHdhaXRpbmcg
Zm9yLg0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBQbGVhc2UgY29ycmVj
dCBtZSBpZiBJIGFtIHdyb25nLCANCmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL25ldHdvcmtpbmcv
bXNnX3plcm9jb3B5Lmh0bWwjbm90aWZpY2F0aW9uLXJlY2VwdGlvbg0KbWVudGlvbnMsIHRoYXQg
aW4gb3JkZXIgdG8gcG9sbCBmb3Igbm90aWZpY2F0aW9ucyBvbiB0aGUgc29ja2V0IGVycm9yIHF1
ZXVlLCBvbmUgbmVlZCBub3Qgc2V0IGFueSBmbGFnIGluIHRoZSBldmVudHMgZmllbGQsIGFuZCB0
aGUga2VybmVsIGluIHJldHVybiB3b3VsZCBzZXQgUE9MTEVSUiBpbiB0aGUgb3V0cHV0LCB3aGVu
IHRoZXJl4oCZcyBldmVudHVhbGx5IGEgbWVzc2FnZSBpbiB0aGUgbm90aWZpY2F0aW9uIHF1ZXVl
Lg0KRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCwgdGhlIGdsaWIgZXF1aXZhbGVudCBmb3IgUE9MTEVS
UiwgaXMgR19JT19FUlIsIHdoaWNoIG1lYW5zIHdl4oCZZCBiZSB3YWl0aW5nIG9uIHRoZSBzb2Nr
ZXQgZXJyb3IgcXVldWUgdW50aWwgYSBub3RpZmljYXRpb24gY29tZXMgdXAuDQoNCnJlZ2FyZHMs
DQpUZWp1cw0KDQoNCg0K

