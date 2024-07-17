Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855D3C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0bH-0003Bw-Jp; Wed, 17 Jul 2024 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0bF-0002p5-Ee
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:05:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU0ao-0005zO-Md
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:05:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H8p0Hc020535;
 Wed, 17 Jul 2024 09:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=PvKwV3lY7dU7HL9HC9lmXbkwdPMEaFxmS9kmO07XsJ4=; b=
 no1fA5GurLmuIeOWj6+UrJoo5Su47KKXPdkbUGMR03r6exiT1ROu9C6UJ8/WCzI6
 1QMy4UJ3nWTJQURyEAUDlPf64pI0BKD+4jKb+U3LcQtmFszx6B1KatOrvp2Y5EIs
 kuPuR4skaZAy3ERqJLj1llgU5qCWKqWyzzoT22Q2akZ3QDMdO6/ryDKM/Y8UnOxA
 Ss0I5VNv1FQ8vwn9EYxyNqyzzEbhF48Nv+DcRg4AO4Azz9VsAgnn+xbvKMEJw23u
 tLzz0pIRdWUQ/fdHGLKTZOKVYCq+h+ZUliffh7/08RveMGSVjnCmCXuSuMvTvUVX
 Q9lpi+SQNkq0Szxmaxdkww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40eat00100-26
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:04:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H87K74003961; Wed, 17 Jul 2024 08:55:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexsnvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 08:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMfIuuFCwbK93KDdL83EBKd12tGkmN8fWIM9sJq7zpBr7B0DB3IfjfPiQ8DMLoKxG/0anOUMRW58tB4wxbjX+mS5r1+jPLD6NaklJv5WzQLpfdJD3QvZnUBVOskTIjM+zv+pwv+HgWgELenh5AveGrAK33HapyWXahcLOey/D+rfLiPanFEsuXirS9whwupbXH3gceBIZPld8jz/EXwaDqlGoGSuMk6FXMnixMde0SRWlCi6Cb22EO722bMpSjXFoZhq2WAF2a0O9zUPGrXH9PCa7dLrxO4Vn5Zuaorh5++xqmrRDV+XUnp/Ps/6yHdLjfLCUuGcoHzvdLcCcIPBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvKwV3lY7dU7HL9HC9lmXbkwdPMEaFxmS9kmO07XsJ4=;
 b=rANvBvnVvAXF4Vd2Mq/+KODVRF1CVU/nS3/hjAugy5UN93Il0DJEn/4exBA3/WTIG0UUbdhscgHdAYV3XrpRZfJl9ic/nt1SAcUndSzWW5cCUS1qe4Chk6OICHzBySDlWor/Lxuaksqc1/SPealDtr75FQn1rsHb3WT1cWhf0Yo0O5K1TAXOAobaMIqakvacuFBbLBdGOIdNE1HdNqmlyAzwmp2pf1RY/4SGYd5BJg06HMnBa0uN9SjXBepW4qt6MZnLFy0xYyJfEX1sw0R52gZdRuIwAmwcPkcWrgUcgN6Odom6Oz0M6uHKBNsDPsUKR0ZlL9nnLgywcM1ra5FDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvKwV3lY7dU7HL9HC9lmXbkwdPMEaFxmS9kmO07XsJ4=;
 b=s7CgZTCmg46MMV3blA1AdpUCM7mngez3Y27zI2uNuFgIf152nnamiek72+FVbPVDi+JJylOnHOrHBAbEUwt0AX2Ce8UYaqrBa/m28jwxJPbpVi9+5kbyqrDP6UA1zUpuillODqRkCHEBpY7ReSbOiFP5q342+2VPIVM8eElel+U=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by IA1PR10MB7387.namprd10.prod.outlook.com (2603:10b6:208:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:55:49 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 08:55:49 +0000
Message-ID: <c0880ba7-e74a-4120-9f29-2eb7426afff7@oracle.com>
Date: Wed, 17 Jul 2024 09:55:42 +0100
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
 <SJ0PR11MB6744FCF630DDF790C832363F92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744FCF630DDF790C832363F92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0590.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|IA1PR10MB7387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3497257d-e77b-41d9-633d-08dca63e4165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTh3cVJDZEpwZWhEc3JSYTBTWEVrc3d3Ym9KMkxFV1RzT000Z3l2eEo3cWQv?=
 =?utf-8?B?blQ3MlV3dk1QdklhQ3RJUU1vdmJRellOVlZ2SmdWUnRYMEgyVFJkOGtROVp5?=
 =?utf-8?B?SUlnMTJvZjZwVW1RYnloUWFiQi9kVWF1NmxpTnhKLzZMYVhYRG15Mkx6VGhj?=
 =?utf-8?B?eHhINmJyaUh1ZUdFeEc5TzFMT2czazdmMXdBNktyVG9UMzZBVmVLcG5LUWxW?=
 =?utf-8?B?WFBQNTNJS3hKWHo0aHJzRG40M3R4S3QxVjhGMTNwWnhheTlVS3Rqb3VnbzJa?=
 =?utf-8?B?UngyTXVidHEyeGFNcUlJZU5FeXZ4WDRJdDRqcTkvT0pNQUdWRlRiSmpVeGww?=
 =?utf-8?B?TjQ2YTVRZG1Bc2c0OFpyeFk4Y1FXU1JQU2xqQkQ0T0VSb1lldzR5Y3hVczlL?=
 =?utf-8?B?V0NaWlhTbTAvQWVFUHM5NWlibFRuOSs1V1NZcnFqdEtxMWxiVmdPU0lmbGd1?=
 =?utf-8?B?dzJMOFdvNmxTbEJJK0lDV1RUNVNXZVZZV0xXYW44cC9KL1NQaTBhczZra0pr?=
 =?utf-8?B?cWo5N3lVVkhLclRCZUZ2bjdqRkJpV3hBZEQ4TGZMenMxNGtRQ2hRcklTMDk2?=
 =?utf-8?B?SEpEZEwzVHZGa1RNZjRRYVNuZFlkMUhwRHUya21ZWm9kU09zNGpqS3dGZ3NB?=
 =?utf-8?B?TUgySVBsZXgzRzV6cm9jaHJxWmdweDdOY1FZVEZMMDdYdXROSURjZjB5aFgr?=
 =?utf-8?B?UFE4YkJPcm9KMlJoVjFYbXpjSitiRUpyVnhVNDJIYjNMY25hbUEva1pEbU16?=
 =?utf-8?B?emR2R0JvK3lDb21lMXUveEFoR0o4azhId2ZJNy90ZkhUSmF6VU14dlBjTVpV?=
 =?utf-8?B?TXVpdUt6KzFremlVTEJmWmRKV0FWT3JXUHpSOWp5aFlzeDVnS1UyN0NqVUVx?=
 =?utf-8?B?WDFhVWlVbldhUE1xbnIrbjA2L1dzbG5tWDB6b2VCcVQ4QXloc1lQK0d3L1Z6?=
 =?utf-8?B?ZnEwQU95NldSMHMwNGlaZ0ZvVzdnL0o0elp5WjZzeURDNlpLWEdpSlBTR1pQ?=
 =?utf-8?B?djVwOGdKTTNjODNOKzJQVWpZajNUdUNoUTU2emhDNEJnTkM1RFBWMWZyeW4w?=
 =?utf-8?B?dEhzRytFTVNhRWdLZG14SE9jUGNleFg5WU0zTk9uTVVQZXlFMmVGcEpJeUFo?=
 =?utf-8?B?VjNCVmJ0L0k2V2lNakhRY0tZdjRnQloyZHJkc2NEZ2tGdXA0R2dqUTBOV090?=
 =?utf-8?B?a2hTN2xwdWlYS3dnMUFwU1FRZ3k4TjJSbUU1cU4ydGQ5ejVYSU1GMGdxTUho?=
 =?utf-8?B?TGo4Mnp0QjV5R0wwR0ltWXRNQ1lzYXM1dTNYVXRwZTdjYzJvbkF3MEg5clNi?=
 =?utf-8?B?bE1nQ05SQWx6cXFVYnpBYjZaOXdUS3dFWC9GNVJRRXoxUTRpOGlBVE1qTE84?=
 =?utf-8?B?SXhKeFc5VXlQM0FhS08xUWZCU0I0Ukk2RUszZ1U3WTZ3bDRrVjNGTm81dGM1?=
 =?utf-8?B?dnpTelgvbngrclh5dmZzWkY4YzZ5Z25aZFhYcCt1WExYVjVwcFRXZDEzYmh5?=
 =?utf-8?B?ZWZJWjJ5cXNFTlJWbm1rdnlKQTdVc2dOS0d1RnlYYkxQUWN1OWl0N0RpMjVn?=
 =?utf-8?B?M250aUFZZEI2TG1BQ1NvYUlvYnlseGUxWVVKWGtRQXd2RHM2NHFrSE1HVXhB?=
 =?utf-8?B?bHkveTBhcTVjMVNJUXFyY251SStLZGYzTitNL3hvV0ZaSk14b1NXVCtoemt6?=
 =?utf-8?B?SEg0T2VnVVZDNGJxRE4vSG9vRnlqWkh4YTJSeUlFZHdDWGJiMERWRzQvK2Rv?=
 =?utf-8?B?STNNYjY0b2FOS1hqNkRlZmhJdThoZkpNWU01VHhBOUtXN2VHeFg4OVd5U1Jm?=
 =?utf-8?B?aDQ1aWJuVllESzh1OU5Wdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThzMlVxQjRRNHpRcmtvc0ZqeVIwckhYOGNBY3dpNEcyY2pnRlc2eE9RNjIr?=
 =?utf-8?B?b3QxOVBDajlSZEJPTnp3RHRaVzQ2QWJ5UEI1SzF0OUpDUDAzSTNzbVVJSnI0?=
 =?utf-8?B?OXZoTWV4d25xSm0ybkRNcWRDKzR6RkFhMmZYZTBnaVVqNEIydDVQWVo5ODY0?=
 =?utf-8?B?NDF0RHBqaG9qVHBEY29HdlhJSDhqMUVhdHBWNzNVRWk1SEk4WDJHSWNlUWhm?=
 =?utf-8?B?YlBEdGViU0RxYisxTVhHRUhWdTJ5ZkNtbDdwQjVFZjczeTVHbHBCV0VSY3Yv?=
 =?utf-8?B?NnVyWnZOZmVMWHdyZExxOVFtd1Z5QzhrRjZ3bXlIbE50aWcxUE1Jd3JvS1pL?=
 =?utf-8?B?R0ZpSHJ1VlpSeFlnbFltSER3MFJ1REl0MUtxYWsyM1RrUkdzcHVydkdyc2Vr?=
 =?utf-8?B?WDRRZlFjVE1RWVpZY2FzV3VuVVVTNnBiVDNTTXgrS2U3RmFHdytDWUZrSDJR?=
 =?utf-8?B?V3FFZldiOHZZNHZFQU9ydDY1MERZN21YL0Z6bGdWZEdHV2wwRElEMVRqVS8v?=
 =?utf-8?B?emN1dGYzTkhoUVNSUkF6Q0JWUTB1cllXenNPMDlyZ0UwOFh1d1VUOGtnQVBD?=
 =?utf-8?B?TE03YlR4TWtmcEJWYmZIL2taZjk3TU83b1BLWGIxNjF5Y3JmdkpkeDVGbVg1?=
 =?utf-8?B?dFlqUXFUaGlEb2kzbmVSbndWQmI3MkRXTDl1M0tXSXVjKzI0VXFKNFNMUGhx?=
 =?utf-8?B?S3l6aVRjQ2NNV2ZFN3N3a1ZGbWM1NWV1RVdRakRsdHZWMFo2azJmbzMzekd4?=
 =?utf-8?B?cWVMV3JTOWRWeWZ4VUxtaUxCRkxHMnhxaFYrZjBlcTI1OWh6TWloQmhOdjRI?=
 =?utf-8?B?VnJVZnByMkViN2VYRGRLQUMyeFpGMnY0ai91VXJPaGRvdHkwdURtMmhCMk5U?=
 =?utf-8?B?YXpIRHUyWnh6RFhBN2lDV0RlVmZhZ2ExY2Z2blZtVWNhSGRxTEE1MUIxSkVG?=
 =?utf-8?B?Z0QweXE4TWlGR1hsSy90cGhHdWJCeTY4dk9NdmlFQWxBNkYvdmdUSG9KdXRo?=
 =?utf-8?B?QU10SklSbEZwU1pDaVRRaFdOaWcvQ0ZDYVFFV0puWVNSUmFocjVPbVhjNktl?=
 =?utf-8?B?ek9GY2RXQVdZOVF2UFZaV0hUdGhZTDR1SnJRRFQ0RkhoeloxS0NMZ3MwMml0?=
 =?utf-8?B?Y0pHOTdiWDE3OWlNdGxPTC8zU2hQREF5MXpPbUtLVTdidHFYKzlrd3Z4QlB2?=
 =?utf-8?B?d1k1bkRIc3ZKckEyZ2FMY2NVTGFtVmI5bW51VlN0TGRkaitkVTFWQlIxb2hk?=
 =?utf-8?B?OEhhY3Qwb1ZYdmhVbWVJalJERGhiS0poZVRQRWFrVldqYytlLytwUFBmQ3Bv?=
 =?utf-8?B?SHVzclhxb1pnZWRUYUNMOXc3YkF1dFBQbzEyYWVVbDFHZmIxbG9iMm11Z1VE?=
 =?utf-8?B?MnlPN3VZVWZxSGorcC9YaU9GT1A2TkxUOC9USnBhaFowZGJCai9WMHZJMjND?=
 =?utf-8?B?eDJqbGNRMnlER3o1V2Urb205eWV5VmpGbWFJMUl0NnZwOG05VlNLdkJCVm9K?=
 =?utf-8?B?R0lnditlMnZJTjdXTnRyNFUzcEhJeDhlZlZiMGN3NmpjTGFqUFhwWFZQa1FE?=
 =?utf-8?B?M0d3ajk0QXVpeGRyOGJZYTJjcFIvTkFpK2phWGU3V0dYSXlXdXAxSXp3eTFN?=
 =?utf-8?B?ckoxRTlLZ0w5V2VtTWh4WC9JdThlUzhEb2RsR2ROZXIreXRpNFU3RDl2WjRk?=
 =?utf-8?B?clBveTQra1IwQUhPaUFMQm41akVrYzBmQ0ZQSEllYWRuYjVDR1NHeWRRSi9P?=
 =?utf-8?B?bVNIcmZNdnBpNVF2TjVIRHhqMGJtMTI1ZjhueWppNnk3SCt1bWFVYWdIby9y?=
 =?utf-8?B?cXFkYkV1WXRXNWIvR2MwalZFeFRBbk0xc0JiZFRDRlAwd25jQ1ArTmdKWUZP?=
 =?utf-8?B?RU9Va2tzUXpaNytsZTNpRWxsWmc4MlNRa0JwU1NLUDUvMVFXVVhpU3hhdzc2?=
 =?utf-8?B?NWZ1NXhYdkszbFB2c1lmdVV5Qkt5OUloejdLclVLbDRtSU5sMGFYR1pYMXlI?=
 =?utf-8?B?RmVvOUJPR21Ic2JRczZ3KzJZaER0WjFtZGMyb1gzc2o3KzFLQ0xNeXdPQm1h?=
 =?utf-8?B?N0owMldEUWlsbFllUDdKTnhvYVFCSkJiVjBVS3N6VFYycm5DeFg3ZzlUeFR6?=
 =?utf-8?B?eVRRcjBCTEdETmVYQzZBQ2svMEVPV09BNWhsWHlxbEhXVTU2NWJqMVh0a21l?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PxrGdGRyb7osntXGg5YchoHwDaC6m00PGOjTyJxNeskaZMagM4RdxpI1QviiQKsrl/jwfyv40TCG5o9+etknjSUIZu6N28sXSv5bJWZNNKQzpj7kXnlRn+WMNOc9eB2l9+jWFMHOj/CMnYiJPqGZwCHVkSpiIi1+zZbBhA6izARZ4gQ8ZpDRf8usJQ8BwcyRgrsrqCS8Zc/lMIcaV2EgCCROgDnnqVnkm4WeYyFdPV8cjves42r5wfhbUn92iQBrHMbur0yS7hlg279hwcUJ42HnhB9euefXVrmNVzfvYwA44GIp0RwtXwO4P31oe1jtOWBiS0y0KL8fSXeCTJN7q7H2GHyT+7cud97fTJwJvaqvcmOJPfclWrKYhaoFWjx3ZchEuwNJZ+7zS3cO+0xo075VfzApCxVIpYDlpGtQc/obfposrqLiBgF4Tum6FO3wnQPfkII1PYUbEeGZmISIby+pK6FL2/gOmfqSsJQyW0Xu+kSWyQS//Ug40Y/8JN6x7YynUwHaPLo3LzHHcAps1Xi3StlGlaaZQUvEJMy3uy9vw3/v8OctMzItGECaiupQmfn3uJxcvgWWkYXo9NefPZvK6oFPbp7A0e0g+HQkSsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3497257d-e77b-41d9-633d-08dca63e4165
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:55:49.7102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbPnffb5EwIzJvptpD6YYQb4ylp10jEWFk8Tteb43dgrsQKwGgDXdSuqKN0NA/GTdd0GJPOEmzsMHCUcGgcH04OMjY+ME+DmLvaU1iXQmo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7387
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_05,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170067
X-Proofpoint-ORIG-GUID: 86-eTL0LMZubxyztiiP3YsClv1XC_twb
X-Proofpoint-GUID: 86-eTL0LMZubxyztiiP3YsClv1XC_twb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 17/07/2024 03:05, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
>> HostIOMMUDeviceCaps during attach_device()
>>
>> Fetch IOMMU hw raw caps behind the device and thus move the
>> HostIOMMUDevice::realize() to be done during the attach of the device. It
>> allows it to cache the information obtained from IOMMU_GET_HW_INFO
>> from
>> iommufd early on. However, while legacy HostIOMMUDevice caps
>> always return true and doesn't have dependency on other things, the
>> IOMMUFD
>> backend requires the iommufd FD to be connected and having a devid to be
>> able to query capabilities. Hence when exactly is HostIOMMUDevice
>> initialized inside backend ::attach_device() implementation is backend
>> specific.
>>
>> This is in preparation to fetch parse hw capabilities and understand if
>> dirty tracking is supported by device backing IOMMU without necessarily
>> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/sysemu/host_iommu_device.h |  1 +
>> hw/vfio/common.c                   | 16 ++++++----------
>> hw/vfio/container.c                |  6 ++++++
>> hw/vfio/iommufd.c                  |  7 +++++++
>> 4 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index 20e77cf54568..b1e5f4b8ac3e 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -24,6 +24,7 @@
>>  */
>> typedef struct HostIOMMUDeviceCaps {
>>     uint32_t type;
>> +    uint64_t hw_caps;
>> } HostIOMMUDeviceCaps;
>>
>> #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b0beed44116e..cc14f0e3fe24 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice
>> *vbasedev,
>> {
>>     const VFIOIOMMUClass *ops =
>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> -    HostIOMMUDevice *hiod;
>> +    HostIOMMUDevice *hiod = NULL;
> 
> No need to NULL it?
> 
/me nods

>>
>>     if (vbasedev->iommufd) {
>>         ops =
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUF
>> D));
>> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name,
>> VFIODevice *vbasedev,
>>
>>     assert(ops);
>>
>> -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        return false;
>> -    }
>>
>> -    if (vbasedev->mdev) {
>> -        return true;
>> +    if (!vbasedev->mdev) {
>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> +        vbasedev->hiod = hiod;
>>     }
>>
>> -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>> errp)) {
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>         object_unref(hiod);
>> -        ops->detach_device(vbasedev);
>> +        vbasedev->hiod = NULL;
>>         return false;
>>     }
>> -    vbasedev->hiod = hiod;
>>
>>     return true;
>> }
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index c27f448ba26e..29da261bbf3e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char
>> *name, VFIODevice *vbasedev,
>>                                       AddressSpace *as, Error **errp)
>> {
>>     int groupid = vfio_device_groupid(vbasedev, errp);
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
> 
> Hiod is used only once in this func, may be use vbasedev->hiod directly?
> 

The problem is more of how the line below (...)
> 
>>     VFIODevice *vbasedev_iter;
>>     VFIOGroup *group;
>>     VFIOContainerBase *bcontainer;
>> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char
>> *name, VFIODevice *vbasedev,
>>
>>     trace_vfio_attach_device(vbasedev->name, groupid);
>>
>> +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>> errp)) {
>> +        return false;
>> +    }
>> +

(...) would look like like really long. And I would end up deref-ing 3 times.

But with the helper function that Cedric suggests might easy to accomodate your
comment.

>>     group = vfio_get_group(groupid, as, errp);
>>     if (!group) {
>>         return false;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 873c919e319c..d34dc88231ec 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>     Error *err = NULL;
>>     const VFIOIOMMUClass *iommufd_vioc =
>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUF
>> D));
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
> 
> Same here.
> 
>>
>>     if (vbasedev->fd < 0) {
>>         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char
>> *name, VFIODevice *vbasedev,
>>
>>     space = vfio_get_address_space(as);
>>
>> +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>> errp)) {
>> +        return false;
>> +    }
>> +
>>     /* try to attach to an existing container in this space */
>>     QLIST_FOREACH(bcontainer, &space->containers, next) {
>>         container = container_of(bcontainer, VFIOIOMMUFDContainer,
>> bcontainer);
>> @@ -722,6 +728,7 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>
>>     hiod->name = g_strdup(vdev->name);
>>     caps->type = type;
>> +    caps->hw_caps = hw_caps;
>>
>>     return true;
>> }
>> --
>> 2.17.2
> 


