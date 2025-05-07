Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46752C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgZn-0004V7-7o; Wed, 07 May 2025 11:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZl-0004TX-Dn; Wed, 07 May 2025 11:20:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgZi-0005nt-3c; Wed, 07 May 2025 11:20:49 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5477Oke8027452;
 Wed, 7 May 2025 08:20:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Oa9BFh76+yEg5khiGIfhsAsefdqevbups4EvGK0SQ
 8I=; b=0r3UEQnvTMDrJb1Q4IHN4lHmx1cCmHYFLRPn8b8Up8n0NXsNHgWVt/xwd
 Jtb/XttpsUq2nNYjiQ0HgbWtOqaXP3sNoG5WWGr2gTUqBN58d7rg8LHLtOIzXVoe
 L5ktCSXpQSQw9luFb5b4QLmy8f9pJbt0yFdh5mMn3JIW3i7L6sCrXmkB4WsxGVRy
 QssSkqTxEoRFw6aSYx4M9G0V2+ohuBeS7jZi2VTAf085ccHECqsU9RiLCcWTKaqU
 jP73jReWoht/8vM/bqxjww5fM8B6LtyKENzt7WyxlibKqMcQ4tznURA8KQZmeaf2
 GgLwU0JpZVAQbh09g+ckLk1SWtU6A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46djfc9bum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgOT43SXyKW+uBaFWu23YfUBIxEVa4u6NJ1Me6LtSUrlAiF+C0d7bSNXUBmJZR/Ot6MxCe+Wcr9wVQtNzutU3GWI/GR0PxQzh13hdwgaSOnU2XZ7D94QJgrkzFYS7t/bK3WSoLJ4reZjNgXtyH/T3RzgYKptY6VhIyMdV8uJ1erMF5757wttzA532tr6EbwWlZKMpiU2hw80NIEPGxJ5+OvY1OCe3jKmAU2eLFySIEDeQXK9bx33vknDUeI0UWLskz3iZw3VlMLu4Fepka1N3a7w4NE4/fEmORQ3UTlGFOUz8C3XX8mC5NwND+sdcZjPfG1BSQAvhrHmx0i4GQ8usQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa9BFh76+yEg5khiGIfhsAsefdqevbups4EvGK0SQ8I=;
 b=OABJCL+a/wr3ymlpvaLS3qPVsAaziJJQNJszuEp3B8wSIPya+1KUaCR8G02irO/Qw1xmNFduP+7s1IpN8ESwom0VgHOiIIPaV6gCUqeJHA6D+QrWMsyfXG4CrGfd6S2VFxvv9RAYt+J4OJzwbD63DsE28lEs9h9x1r4tlTk2UcGpFXGGN5Xk3D5QVj1od5iDhBHd8CtRY2ODfztTX6GUj5XqVB7udAsMO9/V/AItML5Qpr6SOQAwN11BBQKa5xrIRydF4m80nCkaeJX76SJofdKPbY8CRnJhPMfk1n9PA2XFZ4noKKhqc/0RJwvqFuO2sBhdtucpbc8U91EL+nId8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa9BFh76+yEg5khiGIfhsAsefdqevbups4EvGK0SQ8I=;
 b=AInGJyxI6dVcQbAzE8RJtN2RX+aJQCF5Y/y5qN3Mi1eRYD5SUPBupF91BECMo8UsR8heY3fMmzlxr9qTg3c8v9pQtHSdB2DNno4PDFi9KspzHGVTQaP9nT1WGhRUVVve78mCH7r8a77miICXcCsCFCQvI1YPASeeqTPUjI/pzYZaTwBqoAh+OB9ef/xHj8fprptNjWWvWDAFj7keMCCvuR8s765ajlNsmoWXqbf6PW3WZT7lvpDDNAu6NRVywSVQAsvL1EN5QqJSnf1k7KB6AhCwGGO2F7ET+8adIIKkCmNrxapvZFyk2A0J/rtMp3Ly4RELq9+xgQAdmGI7jCjiOA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB7970.namprd02.prod.outlook.com (2603:10b6:208:355::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:20:30 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:30 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 01/15] vfio: add vfio_device_prepare()
Date: Wed,  7 May 2025 16:20:06 +0100
Message-ID: <20250507152020.1254632-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a04a15-5e68-4a42-dcc9-08dd8d7ab3d1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkNnTlhyOFB3RFlVT3krKytHQTBTc0NSRW1nMnQwTzFMcWljNU5IMWg2dU1x?=
 =?utf-8?B?MzRpNEp0VW1aQngvTURjSWh4M1FRVXV6aCtWTUxQUENlTEJINTV5TVVJTXlT?=
 =?utf-8?B?amxnQkVSSlJ1eTJteTA1ZGFMclQ5OUt2T3dWRXE1d0xpeHMxLzVlbVlUcDZt?=
 =?utf-8?B?VTdqQmVxaDYvOUI0ekZHNnhpeVpLZFBqbEFid3I1bnltbVhWV3p0aFN5NWhi?=
 =?utf-8?B?QUhSY2Jzd2tmeDZQY1ZJdkc3dFNkNW5hSHlRZFYxV0o1TDJEdDVWelBuNG90?=
 =?utf-8?B?Q1liUUFDUmk2RHl4REdNU085M3FkV1E2OWFiREJIV29idXNQR1BPWEUyK0hK?=
 =?utf-8?B?S29YcWNhcGJGSVJjNlhCMG5VeWEvdGpXNlNTWi8wTFNwMnkvb2lsdTN6eDFP?=
 =?utf-8?B?TzhjRlhjMExpZ2JOSXhTNTRrbmxzR2hSVjA0WExsbTZuU0VuSnViUXZmYU5x?=
 =?utf-8?B?eWVON0xPZVpqeC9RZkxqbXBsM0w4alBaRUtvWElHdnpnSzVNWWx1T3RiNTFz?=
 =?utf-8?B?aEpFVVU0MVZhRGdhaTlqN2szSXlQRVpHTFJEWDA2STgxOGNjOHRSdzdKcmpM?=
 =?utf-8?B?TnNZZ1h6RC9zdDltSG4yRDAvRU1zWUVwWVZ1RnlZdmVMaGR4ci9VU2toalIy?=
 =?utf-8?B?cXErVnpXWVVTZU9NNS9DMnFhcmI4MUt6Vmg2VVZyNWVWS0lUSlhyd0JYaFBW?=
 =?utf-8?B?RTdaeENPckhLT0xxU2RGN0ZGWjNzZXNGN1ZRR1RmMVk0NFNhZlJkNzVTaGRB?=
 =?utf-8?B?V2hvV1NRMVNiTE84R250czZRVVR2QkFXdUhWbmNzaWNiSlNOMmtiT3VLbmc3?=
 =?utf-8?B?VXFsQlNWRjJCMlJSbFdjTmltRW5OWHFZZXRsdXN2WUdLbHhQeW5sbkFVcGUx?=
 =?utf-8?B?VjcvQm4vQXZMMkRQNmxwb3RiVzhKTG5NZlFxS0J4K2NybUdHakRNT2FPVzU3?=
 =?utf-8?B?RDhBNnhoN1ZwU3pJVUR0T05NNTBySy9vRW5UN3FObW50K2M3S3hUckgvRlJI?=
 =?utf-8?B?bi9sTGE5b3c1c2liaWpWREUyaG5SRDJ3Tkg1Rld2a2dSWWpHRlFqOHBSWnRU?=
 =?utf-8?B?UVAvQ2UvUlRpeXhuZDk1MHhUalo1ZGZJcWtXYzRrMGdXN2haVEFFNi83ZlU3?=
 =?utf-8?B?c0w1YVhDRnlqNWExdTA4amRtM2FxSTRKUmY3WEZHT2xGaVdnampQQTNYNEJj?=
 =?utf-8?B?dTNoMkhjSXU0dElzYkNpeEtkbU1YUm9XZ0NQRXpXaUJ1azd0UEdYVWlJVmVy?=
 =?utf-8?B?ZnR0MnpTOGVSOWtLRzZhOTdMWHNhOTJVQ1lmek1oWVliREUzNkpPM3NuZy9Z?=
 =?utf-8?B?NFBPWUdjTzBDNG42VTMxeGY0TnJpam5vcU9TSjdiSEhxcjNCMlZ0a2w0eTFa?=
 =?utf-8?B?akpwOVV1Zm5ENWg2UUJlc0FUZjRYbSsxWlJsbHZXVEc1bGxLbGxYTkdVRll2?=
 =?utf-8?B?eVBrWlJqTjdzRi9VNkswYjNzcVlUQjMvOVI0RnI0NzRUY3c5Vzh3amtmc0pZ?=
 =?utf-8?B?NGg1TTl5M25YdkZoN2J0MnFab2UxVXl1b3BsaFRHckVHc3BIU1FnaUY4UWI1?=
 =?utf-8?B?cUJmM0orV3p6VHZCblIxMDNwOEZxcThtVSs0MU9NaHN5Ry9iZzdZMnJrQThN?=
 =?utf-8?B?UG52Lzhwd2pnYjRzUUdlUlJobitPN2F5WW5IZ20yaEcybnFONFJTUC9lTUZo?=
 =?utf-8?B?UmJWMnA0Wm5BbnVxa3RkRGttaER0b1IyMjRSYWVVMVIwZmxXRS93QnczY2cx?=
 =?utf-8?B?MWpKSGFwUGQwRmpVZ3I2cnRhWU50V1RsZkJVaGNORHE1Y3VPdDJoaFlBUUt0?=
 =?utf-8?B?S3ZEN3FjS1o4d0kxRjhsZms4bWlta3ZsMHhMV0VBaFpjUkM0eUFqUXR3bHFs?=
 =?utf-8?B?VDRMV0Q4NWdnQzBENTQ3VnQrVlRqeVlWbUlLWEI4bm9FUktqZC9TS0puZzcx?=
 =?utf-8?Q?iH44TzfCZ5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBBVkhKcWpOZE5KbE9sQk9meGJsZGg1UkpsQTkyVE8vWU5YbXo4b3VZRlNT?=
 =?utf-8?B?SWVpekRsbHIrbEhNRWdVTVZXaGhLWE56YmRnb2dyVThXNGhPMVB3SkcvM3Rw?=
 =?utf-8?B?b3diejQ0dGNEVFhKTVVrNUhvK0ltNjFhSFpqcGtzL2taWXdyY1d5d3lEMTBm?=
 =?utf-8?B?eGRjVUxEYjFjUERNMVMxVWozQkNwVlpsR1pSNnlEQ0RwNEE2OG9tZDIwUU1J?=
 =?utf-8?B?R21mcUwvc1VBWHA2aW1GeEIweDZHU3N1dkh2S3cvY0l2MDZXTFBnYlZJNkZS?=
 =?utf-8?B?MDdZMGFsYXpraS9OcWR0Q0ltTDg2WXMwZldaTzByQkc2Ulc3aHJRTVc1WExB?=
 =?utf-8?B?UWZnNmdJeXJHelpNdlNEMUR2eHVXY0JzYnRPVnNwb2hvZ1RYSEpKQW9YT0h4?=
 =?utf-8?B?NG1DY1RIYzhtRlJONWtieUF5VW9Ra2QvKzZBckhvT3JLNlBPL21MWnhoeWpL?=
 =?utf-8?B?Y045TDJOcVZ6OU9PaElZeGRtZDFESWY1Q0N5VndIK2h4TVVkTUx3a04vTEF3?=
 =?utf-8?B?NitJR25YSE04Sk5sK3Nra0JPYUxJeTVNcjNTaDU4Y3g3cWNVajFyek8wZEFl?=
 =?utf-8?B?NVlUOXQ0MHFIT01MMVlOb1hwRWF0dElzSGZKeU5VUlVEM0xjcEp2K1EwRURG?=
 =?utf-8?B?dFpKa3c0eCs4dndHckdCZ2N5UFAzUVcrRDVHSTBDR1IycTFQeTE1VC85VXg0?=
 =?utf-8?B?ai9zUFI5UUI3QjRaYTE0V0E2Nzk0Z0t1cVdFcnI1Nzk1clM2YVVTOGpkMjVk?=
 =?utf-8?B?SmxOa1VlaVhPOUxKVlFmbGRwTXAyRGVPY1lMTXgxai9rSFZqYWh4dzRmSlpl?=
 =?utf-8?B?UE9ucWpyZTVwQVB6YTU3Y2UxTjZJWlhab0ZXa0lTZ1paS3l5VUlremhndkpk?=
 =?utf-8?B?MUZ4aWZTTnBzRG90QlFEMEpoazkvSGtWemZnWkV3MmdEL0NJTWc2ZEcrcDhq?=
 =?utf-8?B?NVppdnAyY1F2RDhZaDVRR0pPTnQzZU44L3F1RExjb280cE9zOWdoZlRxTHlN?=
 =?utf-8?B?a09rNjBhZFd4WlhKUmt3cE5uZkc4UkFkRGoxT2Z3aG1WQjBkeUVRVEduaEZs?=
 =?utf-8?B?VkRtT3JUeUhscXVsdFY1OVd3T2R2YmpzSGhZQ2grNmFjdnVqVFVWNXhjVVB3?=
 =?utf-8?B?VUtGMjIwOHVBRkxmYytkbWlTYUJDL0xQVko2N2pHNGU0UTJpZVQrRUczOXd0?=
 =?utf-8?B?T1BoVzdFSTdTVE05UTB0TTRwUldWVWRJTHdJdi9xUVNUM1BnaEVSeCtGKy81?=
 =?utf-8?B?WVIzcjV5czk1OExNakN0UGpoRmZ1dXZXVXRoNWExVkloQlJETFNZWkVWSmJO?=
 =?utf-8?B?TGVzaTBkZlNoaTBJamRPR3hBbVRBb1Q3ZkxEcC9FbXZQUys3aGliRW9BNVlo?=
 =?utf-8?B?K1k5VjQvWHF5RzVwSXAySEtCV0FSTTVXSUdnTFBvUUQzNjRQeHJtNWZyQS90?=
 =?utf-8?B?Q21FL3E1SFk1NHd3dzNRVldrWDJsTFFhYUo4Mk1GblplaEUxUEZzcHd0RmUr?=
 =?utf-8?B?WEFWMTlYNVJTWDBBcWZlRW00aHlMY1pkQmc0a3hReUVIcjZMeWxwZjVOSktW?=
 =?utf-8?B?bFQyQ05lN0dLVVYzblR6dUgydWJqRml0elJVcGE3NFE2dVkxNUZGL2x3V2o3?=
 =?utf-8?B?UjA4VDBBanBub3NYUTJjM094VWpqd0ZWTllsL2tZSEI1enQ4eEFYZFZDRk1k?=
 =?utf-8?B?WlNBSEc1aEd3ZFAvSVIwcUVPd2hwVkxUckZVd21aTkpNRGdjeWlyVGFENWJF?=
 =?utf-8?B?aldWQWNlUGsxSzlhUkdudFQwcU0zdytsUkRMKytscmxzeEd0eFJRMG5FV1A0?=
 =?utf-8?B?dGlnWHhKTWJmZ2NKSWtwbU1DY0NScjM1RGh3M3hGZWIyNExnVGFscDRCcUt5?=
 =?utf-8?B?djkvVnZMcWNKUWZDdjFVc1c3WTVOazBnd2wxdkdwVVRqVXl5OUdTS3NzbGdl?=
 =?utf-8?B?aTRFNkNHYVZHR3I0K1FEamtZcEpPV0RRaXlKSStOaG5pb1NqZVJuNDJMU2xB?=
 =?utf-8?B?UEs4UEwxUXJUbmU3cy9rN2xPaHpIdlRUajV1K1Q4blovMFV1bW9LRWNmMTRW?=
 =?utf-8?B?MzhSU2ppcHBtM1VBYXUrWUtnMUszWmJpQnhiM2xsYmx2dWFHaWg3RkZNYlcv?=
 =?utf-8?Q?4MliP35SS5gS4wizgcq5wTxTE?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a04a15-5e68-4a42-dcc9-08dd8d7ab3d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:30.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3xFSmpO+QhroNLGwgnJfDrMTzTLRzpgq35H8AMTM6g6zT3ZWf5arGWUbccaISiBalmwx4rUC3rxzkpIkTV5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7970
X-Proofpoint-ORIG-GUID: D52-auDBIjPX7yQ6ZaaSZkHD1x2-WaKT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfXyTHCd0WvZrwF
 e78cThQIqiL3JpHFTHXsyM10/KMdednreFRwfXntVasB63iDSTaAhXaoIePoQOCecZLagOUILb8
 A3/YeH7xa/dxBN82rYoKsHSg2AoDH/PUwX1ur2eDKU2a5FUE31bNjLsuy+ye8BQJhP1oOMbUz6r
 v/TuDRlmT1kd0QhNjEjaI/bBxzncMSZhXGG76dtYFuzkg2bgUBlmt9DPxaEi9WwPrg+Na5ocgMf
 hQaeIHQz+RtgRKdpFSsbEOUQjuwX/hYWMKZlGZXIH7liz1lJ2lnEJvTlmhWc/TJTnr22o8JnMOw
 R8HDzHszQ1HiqS+fywbCFBxmykqFrE3hTKZeEq294/aoC2ErxGXRlhvMfSPBdxoFVZWag6ojF1w
 Z/mB/NVrLYDS+5ilpYsJC9y6+pLiuoUb9SXgGFTjM+fH6fYRdYKA7/O5c2QlI0o1PiY2JhCI
X-Authority-Analysis: v=2.4 cv=Bu6dwZX5 c=1 sm=1 tr=0 ts=681b7a47 cx=c_pps
 a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=PEtKgAuwMexoxjSetS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D52-auDBIjPX7yQ6ZaaSZkHD1x2-WaKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/container.c           | 14 ++------------
 hw/vfio/device.c              | 14 ++++++++++++++
 hw/vfio/iommufd.c             |  9 +--------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 81c95bb51e..081929ca4b 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -134,6 +134,9 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a761f0958b..d30c1a141d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -826,18 +826,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
+    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+
     vbasedev->fd = fd;
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
-
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -890,7 +886,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -919,11 +914,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 
 device_put_exit:
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index d625a7c4db..f3b9902d21 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -398,3 +398,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
     }
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
+
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info)
+{
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 232c06dd15..83033c352a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -588,14 +588,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_device_prepare(vbasedev, bcontainer, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
-- 
2.43.0


