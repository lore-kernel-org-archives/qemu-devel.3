Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DBCC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7I-0004Fg-4D; Tue, 22 Sep 2026 06:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7F-0004FG-SV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7E-0004Vs-5k
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:49 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M04DsQ2681308
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sFwUabCrNCOLo9i/2U6KjguqRRjZa94LLLqou5Jc7
 BM=; b=DjaTe34N5Xut3HXG8W7SGmn8kl+0ArOo3vgP1tFEYN2flgQeHHKvWrVpJ
 uYQhXmXPiBSIkKMXqxNj9HVQNcWa20MWeOwI4u+Iaw5Hi/3qYjm4uPOl2/gbORbz
 4w8wAzzd0ct0B+wHm9FXqX+5ggTgCrXUowElaz1Dug9xNY1S1QAjRa/zXDWGy4Rn
 20kV+QfsLnoHfMGAt2nNTfphfkj1nblVlu7iE5wfa1j+td2dC++p1iYmdyAYK0fw
 qaJrTEVg+l3swOR5HagQCDpmNYt4oAYbuls8EHDyHRhkb+9NMAfDWCZKq+3OZ6rf
 qVjk4aqlc0FeBqXtRoUDDWb67w1QA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022089.outbound.protection.outlook.com [40.107.209.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gssxwp8g8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWjf/PBzDP2n0h+GR8K3D8JvcFWx6hGf7hSfvLMJblPwynxdKEdnZDU63eM8xz/0o33AXg0H7XDQLaQHrdQmNhvMWjywk1q7bhWm/c7GltDkSZLO7IMd84SUF64idJswqj9tTPf2/VH8IplOAE7auVZpWnf8RsL4DoeLJ5ldulEsBmw75Qa7Qcsu4wBjJEZ+7l8OQ51JT+PlgeTuXcc70FKIWlRv5Ljh+hKk3q6o8uHsH2HZjq27BzaPkKhGdCxHfbfjBmjl04n2MeWfKWOQOpXarKlvGfqwOOAvaQ6YixmF2OEM60RqGts7bmj3Y3xwSk/1pqxTujAp/EuFOClnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFwUabCrNCOLo9i/2U6KjguqRRjZa94LLLqou5Jc7BM=;
 b=d3/PSOp9eDeQfqbPe2M7n9JM026tb/VrGIhWkeZVlJz5voFlO10PydudhJKCHE0JNZw1WDqkbVP/D9D3Xn6dWeWcAe0F0Jf5dzNhhYuX53ILK5o6TmEv+TIvznhDJ/cjEnc/K0pQxM+q3R8+LPeVJPKK+V+LjtrDMUb9HKWxckA/x0MqPO7ZReKGIBgvv90HE9uDUEfDbIHRaIqVf1U4/A3CdG5J6Twb42z1+1wEp+ZjAWAhIKV0SEKY+3wU+ME09+LMKamfD6qcWVijpRN6bNlL2oL9kZP6/yOf9m2aYVJRNGqdEE0D+5hCeSwRFacbeRDtbp633Sy/PjgCOeixlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFwUabCrNCOLo9i/2U6KjguqRRjZa94LLLqou5Jc7BM=;
 b=aUGOnqeNr7cocjX4B8DFmLDwyiWcznK2mLCQPOKr1zEf+IkVZua4btXo+HAes9mTn/UR0ggC874SmsuBzDvw+H1fx7oDtpZFiho8yXOAs+kji/MDgtVsn1NVzGPz9eQAOHoIj/yEiV/k5dsoj5uxIfgRP9ql3rKu71zHWSQEzNg7pbIoI7aI0b46h89oGt1adQovx8IGr3xxuQTNVBsCQ+UlO34NnfV4wvdRGJU1tTm3gEpgZZEXyCMpGiTu0Y7VtdUD8Q14nTZGe/LEPHgu2DghiSM0dNTAoN6Mc6gfp1Rz4ZAJ4dl6a3ryYkHe7ynOKr9UaGFoRRqPHwlkqvRsbg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] qom/object.c: introduce object_property_set_alias()
 function
Date: Tue, 22 Sep 2026 11:51:33 +0100
Message-ID: <20260922105223.1607725-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 295e82dd-8730-415c-cfc4-08df1897a1f9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: frJNeglQ/4Sb9WVfq9iPB8qQ+IAUsPD9f0u8NY6gcu9QxxjHxp6m8w9WFKoblkjtLYyfUmDAFWT/+lTrhVlfph1sHK1lq1hn07aau0rm47drZKjHKm4TwAwsmhb7lAcKmgkH79waU2Gbme6FiWcxWgiHcpMamZqVbTTc/eMENMo86rvSwvznp4rzyCmMhN3c+cY34vny7AwMQr3FDNCXFiTOSE3wgRhPOhfQK8xmxRWoTvwIAEc+E4EWBYMU6tw4AczfDyZUT5qHnWO1qAfC7w29h/Q9t3hJtcKcuc/W9rMtkhYi/Kea7mk70euXT1qZGF82CJ6prxcO7t8zIBEeWX6/AV6rJLZ3bI1dPC+r/AwvEwpCPRDtboONBAb1yCK+VaK25+dMcS9eCThhc6SIib92CaBF6EpMtRGTM4Loi29hoksPRwXeRMgr+MXfxg/S+lt0ShyYD9hEgOJEtS4pl6KS7dBsgMkfTyi6ICVKWht1tGluscr1Mwwy/jElu3dvPezw7UNcFy02GYPrYE3nL+TwXo/Z+teEc0KRcfHbV6yTziQRkwHXXkzSj0wcb7jydRkr1Ok1OdQ75Ta+9ZL170oEn35zfjmuFzccmjoTfYlP26TpOBiwVar9Xbruj7mHEZccGGyLKsOsVLlboA3S2ZL4mNG+p5sS6jgZse+VqEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RmbzIzRHl1b3E5N05EWUo1VjBzRGpvWHd2L0V4M0ZOK240TEloL2FJaUk1?=
 =?utf-8?B?NllPY0V3Zk1kbVYweTJTYVFVWjhWWm9VNHJXWU0xYmlITGs0clJYb1ZwdEFk?=
 =?utf-8?B?b2tUYTg2b2praCtaUUU0UmFDUXJlMEFCMkJQRGRYTndRdGZkNXoxU3ZOT0kv?=
 =?utf-8?B?TWE3eGtoUWlzMDNGbHRUNXdCUVI4dUFqdGpGRVc2V0lrUDhiQlhaYXR6T01u?=
 =?utf-8?B?cU1iQ1pYa3Z3b1JQYVZkWTdYNUo1R3dCV0w4MHJ3bmhRY0lzV1BwVjlmSWh3?=
 =?utf-8?B?SjcyS01EL2RYcEVKenhJd3hySmpDcUxCYkZJMHZtV3BNOEU4RGVkeWg1UnNX?=
 =?utf-8?B?T1ZiaUt5UmNWclVicVpWb0RkRzEzVDExSUJmeEtIVUJsaHllWGk3RndXUS9Y?=
 =?utf-8?B?YWpZSFpsb0ZYN2MwdE5Vbzc4WjNmMFM1UUljcEpFTWhkK2ZOQm92MkRaNDRO?=
 =?utf-8?B?eVdlRWh0Y3BNU2dMU0drRHRVdTZMclhFNkMxb0xITUVEZEE1aHRNRFBzdTY1?=
 =?utf-8?B?b1lZblorbjhQbEEvYnBHZnVIVHh6dFVmRmV3aStRc3BSUnVqcEhRd1orYURj?=
 =?utf-8?B?ekZhLzd4ZGhOY1kxalRDKzZES1JmRkY2TzJFb1lScmp5bGQ0V2l5VyticG9X?=
 =?utf-8?B?RGRUWmdvL1o1ZDRQNlZlam01eWp6M0xPUXQ2ZzlpTHBIanFaL0dnS3pkWHRW?=
 =?utf-8?B?QnVBVGJ3VVVNZDVXMFRxZjZTeFVZbmFPY0QxOWZEMnBYSmtyVnZPRmlKdXJK?=
 =?utf-8?B?eHhIZCt3ZGloUGFKcXg4eHN3eVE5M3hPWEpUTmRqWEcxanpXWFI2NVNRWnU5?=
 =?utf-8?B?RmJkeTBEd1lxV2ZuVGQxZEMxdXhKd25tcUY5KzdEVlFCYU94aExLUm9URW5X?=
 =?utf-8?B?Zm1yZlEva0p3OWMxUVJOUXQ1TndKV05vUk51TDRTc0JWZEZGUjZhdHpLV0NH?=
 =?utf-8?B?WGJLc3dLY1kwWU9jZVBZelJhTzlzM0Z5MW1OYWRCR3VlS3JvMjI1VzZKdU51?=
 =?utf-8?B?eitjWlRyeW1nZzVQTEllbFJjeXE1ZTNYNngvSzdVaWJRb3RiVm9oSHorelRn?=
 =?utf-8?B?WUNxSVdSaTllNE1NVjZJZWJ1dGg1TjFIY1phRHI4aGJJVlF2R3lxek82WEd2?=
 =?utf-8?B?YU50L1ZKYVRyV1N6K05qMUtuRFJ6NW90MmQvTHJZTkh6Q2NUclhsYmlRTlcv?=
 =?utf-8?B?MWZHNEx3L3VuT1FxNzNzUisyc1Y4cENmNUNpazNXVHpZck1ETWlmUnFrdHRm?=
 =?utf-8?B?MFFoYjNsVkpjeE9Sc0F6bERQTlZHV25acTA2cG53TCtBSElEdzVSZ0tWb1ZZ?=
 =?utf-8?B?dUMzMTAxeW1NRHV6WVA2NzF6Q2RPN0xnYU55VURMSWVrQmVhNnVSYXRRYXpt?=
 =?utf-8?B?cWtEbmoyRHppNWl3RllKeUl2dE0rakF6VlJZNmxPMC9IUkJ6SUROK0lHSDhp?=
 =?utf-8?B?K1RMOEFwVjYrRkxPT2pYMVRJb05nUVlvWVdMaUU1R2ROSFVMMjRTRWYyNW54?=
 =?utf-8?B?aDFHSDJ2b29FU1YwMStveHpHZ0JiVktYditLQUZTVVROWUpLM051djZOdjlO?=
 =?utf-8?B?Y0M3M2pOYjNveFNJNHZMbXcrdW52V0xNa0pmNVJpOTRXaFVJNks2R1M2R1Zi?=
 =?utf-8?B?eU5EUWZvbWZuUnBFOWZUeUpFN1lpdFdNQmh2VlgvOXQ1bGthK0lydVNNWTc2?=
 =?utf-8?B?TUE1a3dZK0VSR2ZzT0Q3TXExNitCTm52T2pDemcyTnpzRUF2TC9kWTZjUnkx?=
 =?utf-8?B?ZDlmYVVxRHBNaWFpcVRLWlh6QU5TeElPY3RPYmw4SXdhNXU0bTJNWjM3TFQz?=
 =?utf-8?B?cHZxejAvMVNwYzN3R0M0Zk9wVStLMFBESGhTdlJLTmpUdW0xTEFjUXVpL05V?=
 =?utf-8?B?QXdHNUk4bEphemQ5Wm1Kd0QzcmtPR1k2ZUJ2c21aSmFSYVBFWlpsbUxpck1r?=
 =?utf-8?B?M0tnUktpSUY4RjBTSmxsdUFNUnpwM0o5em1PRVFoUm90YmV3SG9GUXNqcE1k?=
 =?utf-8?B?eE90YWxxQW5tVWZ6OWRBYlNtNlhEVUZhcnRudGp5SDd3cDVJcFpQUld4aXh3?=
 =?utf-8?B?ZlJ3V1I5T2tRRFMxSUFCVnMyV2lTdWNCZlg1TE9JMGZMRHlxS295dERwdmQr?=
 =?utf-8?B?ZXdoUmZvSjBMVTkvcHg3ZFVtckQrV1hORDljS2pPSnE2akxVdGllZ1Nib1lK?=
 =?utf-8?B?MG5oREdxSHBsalJoRkNvZ2tGK01LYnVXVnV6bWFraUtIYlJSMWhQMHBNVElR?=
 =?utf-8?B?eHI5Q3AweGxrQ1NvditxNzN3U1VMZGcyMGV2YllFV2tSUGl2L0xHT3MxQ1JD?=
 =?utf-8?B?RU56Nzd3Q3AvWXBNVmwxcDRWa3pjcnFvWENnMmJadWRFK0ZJWnZJNGovNzFL?=
 =?utf-8?Q?+7vW3iv06MWBGcTc=3D?=
X-Exchange-RoutingPolicyChecked: ab/aef3iN19mI5Vp1huyLDRjjHnwaJwEoSA3NVsQEn8DhheNGS0SxqN51/TVhat67IerCiusLue6rT5YcSSCimbs3REb9o2oz9S6MJ4y2XByS1EwB88JPsv3tkG2x+NUxhxsbZ9rAxp5uVvOYjpj8lOqxX0QxlJPjowJv3BQQShBOks0pugNgW0izkebYf2G5oftvGvnnDeYUUaRp4+1tZT2dd8c3z0ZjRaUb34hNYFdo8DdE91/5h71uQcr80w6QNdiwzcuuhJphZQSzE6FNI2NSH48F1MBai3Puvb0rNalteo//fP6IIxZ9E2imX2PYiNBQwKaxt8ZVUK1eQ05RA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295e82dd-8730-415c-cfc4-08df1897a1f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:44.9825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VOjhPafi7flt7hMm/W6FY38QL/WvwBZl+HUKKQ+LEov6MuJzPe4XoMaCdsh0YnGQT4giL4eSphcNc/IYPHojoENmh4cJDFoUpBIkxMMbKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX3OAxfPf2uFyE
 ATW8DS0CrO18XAx7UBxKJg2hutR0wdy4H1MNTQIMzMdDWZgl4nV9Hx6Y/2qbfffrEixRVrdCDxH
 JO/ZJPQ3hghwXoEc4jYbTAtpZybzacw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX3anmKNfpZGaV
 9Pxq1pPWMk3wai5UD8vYcaeAyeIES1fEwNK+wO9V5Ph5smTsyvWpILXwhU1leSY402ohrQXIFQn
 EFevcCNtbek0cF9dumu8xjaHCgwB9PXXyT8UYjihppHV2CssfZniqsPQMIdEQNUeJqUxuG/SJDU
 GUnCQTn3IzaxUXb+xh41V1acMcDXcxwUGUj7eAk9+C5u6hDPgEu9OCTtxeCsBOwaSyV1vhYKHvX
 igu4Iln0aII/O5YWoeGRhODn09lkFXNwAD5JGq2yyYiDXijkHP+/zb2Lla0+aBkrvpb3+1fsj6r
 d+Jg5Rz15vuwo926ZZykVm313OqsdoJV9IlnoCN52RcU76hsHKeEnNrm/Gke357CDDBS8ePU0EK
 m/E1wzHbx7/0r2Og9evVccdy2S7dlFp5UKK17I8craNFINmsFkYOSbPkMf3apeQFwFKEPC9Hl9s
 hOliFGiZQGa6/St4nMA==
X-Proofpoint-ORIG-GUID: yFhYJscX21X1JRa7gXP8gRGqh38wYKzn
X-Proofpoint-GUID: yFhYJscX21X1JRa7gXP8gRGqh38wYKzn
X-Authority-Analysis: v=2.4 cv=fphJ914f c=1 sm=1 tr=0 ts=6ab25dfe cx=c_pps
 a=kIIydkLLkU7OvItTzr+vAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=cNtrz4puXHHLzHPMHtoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This will be used to set the class alias property for a specific object. Note
that this function is only required for class properties, and will assert at
runtime if an attempt is made to use it on an object alias property.

Update the existing property_release_alias() function to reflect the documented
refcount behaviour.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260921113559.1299740-5-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 17 +++++++++++++++++
 qom/object.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 73d72619b8..4c0645817a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2324,6 +2324,23 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                 const char *target_type,
                                 const char *target_name);
 
+/**
+ * object_property_set_alias:
+ * @obj: the object upon which to set the alias property
+ * @name: the name of the alias property
+ * @target_obj: the object to forward property access to
+ *
+ * Set an alias property on an object to point to @target_obj.  This is only
+ * required for class properties, and will assert at runtime if used on an
+ * object property.
+ *
+ * This function ensures that @target_obj stays alive as long as @obj exists
+ * by taking a reference if @target_obj is not a child object or an alias on
+ * the same object.
+ */
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index e4e8dc6886..96498f3d00 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3126,6 +3126,18 @@ static void property_release_alias(Object *obj, const char *name, void *opaque)
     if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
         g_free(prop->target_name);
         g_free(prop);
+    } else {
+        Object **target_obj = object_alias_get_targetp(obj, prop);
+
+        if (*target_obj) {
+            ObjectProperty *target_prop = object_property_find_err(*target_obj,
+                                                           prop->target_name,
+                                                           &error_abort);
+            if (*target_obj != obj &&
+                !object_property_is_child(target_prop)) {
+                    object_unref(*target_obj);
+            }
+        }
     }
 }
 
@@ -3212,6 +3224,35 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     return op;
 }
 
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj)
+{
+    AliasProperty *prop;
+    ObjectProperty *op, *target_prop;
+    Object **target_objp;
+
+    op = object_property_find_err(obj, name, &error_abort);
+    prop = op->opaque;
+    assert(prop->flags & OBJ_PROP_ALIAS_CLASS);
+
+    target_objp = object_alias_get_targetp(obj, prop);
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_unref(*target_objp);
+        }
+    }
+    *target_objp = target_obj;
+    if (*target_objp) {
+        target_prop = object_property_find_err(*target_objp, prop->target_name,
+                                               &error_abort);
+        if (*target_objp != obj && !object_property_is_child(target_prop)) {
+            object_ref(*target_objp);
+        }
+    }
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


