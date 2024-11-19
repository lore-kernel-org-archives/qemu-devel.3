Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E3D6C29F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVyY-0002V0-7f; Tue, 19 Nov 2024 16:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDVyV-0002UH-Tc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:41:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tDVyT-0006iI-Oy
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:41:31 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJLYk2H026184;
 Tue, 19 Nov 2024 21:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=tq+SZe+KNxolQMAbFeQT1ZzUgcxBGh6bEgp3TURcFH4=; b=
 O21fYt+LNWQ0KyrjF06UVGaL9pGAk14j0eZdPLF20+7wQfprFh7H+bC78o0Tm+/4
 iKCY/E8YY2bX/dp2FuE3VwFpGpLiBq/J6l/QoIDXZBGHb89WOncw1TZ/ftAr4w39
 U1IJDTxY6xLXVioBCvSpNfEG9/GvmpHs6DG863Sutoi8j4/Z9N67XRD32eNq0f9F
 /+n3/4f+Axn+enUNm+dZV6+yAiJyo2hbdLrMuJ0SCN6e9Rmi6zABjqdfXrnpd2gZ
 rMgZyVXqub6AxF5Fi0zrjo7k5SYKn9i8F/tlZqQjZgnoSkdl7VXzteIHFbqLPPXM
 OxCzNAdJy8tnOl/fKM8s0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sp3j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:41:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AJKw5Jc037105; Tue, 19 Nov 2024 21:41:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42xhu972e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSvD4WMbhRqTsPfEQ5WCJFUafwCGik+BmeRyXZ9yh+dsur0KJvmGkxPDYejVAo4ENAjBIVTldd+AfJKhy946HrV70bqRHrXoU6tbDfyIXzpp3K/Ck2a3PMTed7Nv60QKIOgbu3LnFH61+iqqx5lgxfDrNzEqh/MzhWjRtvY6UZ5UPHgRIo3ZPJ9W3sk52sfarMhuCBwaYhAGxfC5+J5PZA3vTyrcsgY3Z1sjwbryynEsIiDskMcbgqi+3hy3KIHtMqHdetiunU97ayCziGB4dn35tJRQRKiW3E++GWNMU3ecmeHcjAQceqSC6EODR2TUldM2WlLT7hhgLqQKkc7XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq+SZe+KNxolQMAbFeQT1ZzUgcxBGh6bEgp3TURcFH4=;
 b=eTFK410x3rQArxCp6ntiu6IggnTkWfL0kW9FL/S3Qp9RdY10TE34D76UqhTcq2wYeiViVcoz2avY7BfNmUcMmmc8U23u+aq4KpUoTQhExSVtnyMdj4v39RPvf8US4usf2gin78S2FQrrSFLQ4b1v8cfLUG1I1Wy/m9lnm9f/G7mE43qOKGOD+bQ3LosQDJOUCQEqQGXyyIL/Lagt/zmHdqyP8HtLiHtKNqPzmeVSj+qB8SHwFXmhN+HEHHpEw9eSvCPuO6qnngZAlAGQ7ylUyzTJOyXXXIQZXNIKnSoW+ALGeIJbU5yO62MJ6kfcHr8VYDFGTAu0XYCxFFZFQfR4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq+SZe+KNxolQMAbFeQT1ZzUgcxBGh6bEgp3TURcFH4=;
 b=HGpaohu+2DqO3NFTPk/vHoloJPDRfUi2RdSF2M4UcE0X4eFvkfFJF+/wIj3ngTfoQ5QbtigFqJ7iN6rR/I4vHmYKZH985nVfW/lzs+PpV9vnaxjOM5ze9Gkm79xjuowuhT2Gtb1/2awQplyTwloGIqXHXU1Alb7fhuqUuHiCrUA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 21:41:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 21:41:16 +0000
Message-ID: <5860c0d6-98d2-4f52-8a0a-e161a6205ba7@oracle.com>
Date: Tue, 19 Nov 2024 16:41:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n> <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n> <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n> <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zzz6NVoJss4JdEHh@x1n> <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com>
 <Zz0DJ3RB-bVofkmo@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Zz0DJ3RB-bVofkmo@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: e659cffb-7265-45f2-fc57-08dd08e2e5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTFyeUVPdVdmUUl5SUJiRlFpamRBWlNhWW5FTHZ2eUVHN01qbTZmWDdUclJy?=
 =?utf-8?B?QW96NXZ3WWg3YlNUMUlicEVjUERKQkNtTGNZMFdaaTR0bHRack5lbWx3K2wx?=
 =?utf-8?B?cUNRblk4NzR1Q3p0TGVUUXVNR0lFbEE1ay8yalRxaDhqcHhqQ2FUWWcxZkZy?=
 =?utf-8?B?ZFFCR2dZcTMwMG5OT1k1Nm9xZEd6SEsvbk4vcnNURjZIU3pkSmFTMGZXR3lW?=
 =?utf-8?B?dEloZTBNcTNnNmMzK2JUYllobEpZNnFENXdJUWJvZ01yMGN5b25uaURmRElC?=
 =?utf-8?B?SW80czU3Q21YTTAreFZXS2I2S0J3Y2tpZy9OUHdoaWZHdE85WDh4L2lLdWw3?=
 =?utf-8?B?VGxZL01WWisxWFY1UnRHcE02Z1pkMHlZcWlwZzdWRkZkdFlGTnFaTC9XQ2dB?=
 =?utf-8?B?bzM3S0lOQ2sxcVY3NGFSZVorbWErbncxNnl0THpJRkRBK21xUWxGUWsreks4?=
 =?utf-8?B?L2JPOUNNcDNIUUc1NDdMcStJVEVLSmV5emR3OTIyMWFrZU5wOFN2dDVMWUlB?=
 =?utf-8?B?Z3hmV3ZIUG83MUFIcWlhcWVLQSs3L1d2TmdiampnNWg1LzdiVmRIZHRlWTFk?=
 =?utf-8?B?YXJSR2dkNzZFK1B3TjRld0JLNWlrVWxGU3huZHp6MC9HZWtvQzlOVGE0N2p2?=
 =?utf-8?B?cWNOeldRelpSSFY5dzQzeTJtSUR4emkzN2NnZnllZnF1ZENBSjgyNlVuTXI0?=
 =?utf-8?B?Z0NqTzhVTGFacHRIbU5ab2xxaEhyUTVxbm45clAweklONUxKaGJ3U0tpd0Zx?=
 =?utf-8?B?bjVSeWtNZ3RIWFAyaEdFcnFRNnRLcGhydW1vcHJrMzVTTCtkUTBSTisycUFV?=
 =?utf-8?B?MWtHY3F3OEl6cXhzSXdrMTQ5ZmN3dEFNS0ZoSERQb3p5U2J1eTAvbXFvR0xU?=
 =?utf-8?B?cFprODJ0SUJEZXRkV3h2OS9iaSsvcFp1YW9paGFyQWJxYWNwQXovc0tMaTRs?=
 =?utf-8?B?cE9ZMGFURU1qWVRHTm1OOVlCMWpyZ2FqR09DRHo0S3VLRkp2RDgzdk1FdnhX?=
 =?utf-8?B?Nlc2aHU2OVZaUWxqcnJuaWs2bVpwODVPNEYzMGpHK0RIaTRYSCt3MEJGN2sv?=
 =?utf-8?B?SGxiL29wZFhwYk9SMERxVEVQTnUvMW9oVjAwZTdoRkV4TGJxbVF6Y09xYm1v?=
 =?utf-8?B?bzVMVHdyZmpMWW91cmhHYkNLSHZEbjYrQmYyVXJCV2dYYmlSNC9SVjZxKzdn?=
 =?utf-8?B?dkRxMG1Vc0wvNEFmczRPTnFsY2hISE9wN2RuVXBmNUg3OHZSUTQwQUVzd0hx?=
 =?utf-8?B?cHhLeUY5SEg0eHVHNThqMEU5cGgvYlk3RU1oYmpyNmZzRCtxa1ZZMlgvSi8x?=
 =?utf-8?B?Ykc2NFdLZThmYzhhUXlOTkRidHpDUmozaXpTZW10Q3l5RmJCd29vVzNpUHBu?=
 =?utf-8?B?SENXNDcxa1RvaXBYb25HMDRDdURxakhYSmNaRVFwaW5ZV01SU3VPVUFHelNu?=
 =?utf-8?B?ekpEbno3dkw5SURzdm5Qa1lGeVJKSnF4dnRaYThoY0ZQaklSWGlvOTFMSnRS?=
 =?utf-8?B?anh2ZWt3ZTcvbEhhS0h3bHZCQkJqZ0VKd0dETnVqdzhkZ0d1cU53M1hScG5N?=
 =?utf-8?B?Z1J3cFNoM24vRXo3R0c5N0ZOUUFQUUtvbVB3OERXY05ESmhJRWRGWEN3Q2VH?=
 =?utf-8?B?QTh1T3BEZDlmeUFvY0JRVCt3ZEFjdVRhRUI5OSt3MDAwb1BWRUVKbytIbXRJ?=
 =?utf-8?B?QTdBb0NNaTdQNGRFS3Eyd0xWei90cUlhbnFPeXExMjVNZVlBbDBmMjBMWHdQ?=
 =?utf-8?Q?WplhLZBfgDFcrpxF89FvjoteMUMlNc7yEqaFEP+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFJalVGWXp6NjVGOEwwektEK2dIc0Z2WjgwblJqcnc4d3JsM20xeWpORmRo?=
 =?utf-8?B?NVpDNWFtNjVobHg4Z01RNGxCZW1VTTJ5UVB6Z2lJRHUvQzhPckJ3T2JTL0l1?=
 =?utf-8?B?ditoMGRoeG5EOHVLczlRRXFUbHJtZVhCc0RVc3FWOFFOR1V3QW85bTA2Mmlt?=
 =?utf-8?B?RE11Mks0cHdyZ2tKK1AxM1RGWWNGcGpLcmFQTUU3TGhBcWVsRCt1OHdodnNT?=
 =?utf-8?B?TzY1bng0aTFBUVVNWGJVVFYyWWJjSTZmdEU3SFlnUHZFMjNkOVRXYlhtN09P?=
 =?utf-8?B?Z1NqWGlzZUg5bGFFdGRjdDB5T1p3Rll0NFFJUnEvcDk3T3UwMi9DbXNaRjNE?=
 =?utf-8?B?QTBUdnhSUzg5VURMTEJyVnlKd3oxQ016bTEyZ1NMZEFsYlJWcTlsdVdVUXRk?=
 =?utf-8?B?dzRmd3RpMytwUlQ0eFJJZE1tUGIzc0tETnB2UURUZ1JpRytsOU5jdm03ZGdJ?=
 =?utf-8?B?RjZBNU04VXF0Qmk4cExLWUR5ZGRndzBSTWFYWkR2NW55V2tnRXMwL283WGlh?=
 =?utf-8?B?VWtnV2R0bzNmeWZxOG8xMzJHY0VhLzB2NUhlNGRRZ0FVelBBbGpmRGZUaStD?=
 =?utf-8?B?aldGMGd2S1FNYU5uMnh3WTZNcGU5MnhOUmxSeW8yS0Q0VDBZWGRGZCtUV2pL?=
 =?utf-8?B?Vk84K2lSOVpvSmpTYzRzdE5WSGVvN0JteXhEbll6a0lCMzdnYXRubGhYYlpt?=
 =?utf-8?B?RWVJSlVaV0ZDNmJGcjJ1VGpId3V2NHJGbDR1eE5JSmV2Uko2ZFBidXFTcnBh?=
 =?utf-8?B?RmdOaXVJbDlWRkt6amY1R2xlaEVJYi8xOFB4Q2pLVG9RK29SS2NEeDlxclR2?=
 =?utf-8?B?aSt2b1hxRWhYLzZ3UVY2ZDFmcE9qYWtUZGxmUmMzeWIwS0xLeFg5U0ZveDBK?=
 =?utf-8?B?NFV2ZUVESjdJTlRIMnl2Ykl3TjVGbVQrR1M2OXc2RGdaS29JVWoxdlNBMmkv?=
 =?utf-8?B?ZkxEWjZ5WkN5Z2NXTUJ4NEtOSDhBeXgwYjNqTG5RdWorT1F0QUVCVGExbkNr?=
 =?utf-8?B?TVdSb2IzalJpaTkzeDlGM25tSEsyaFpSeDQ0ZC9oZkVvNHd2Y3ZDbXlHelNj?=
 =?utf-8?B?Tm14ZGd2VXhEMW52LzBUejV6K3o1dVVBb05xZUxOa1pmYXFnQ3lTR1Q3YU56?=
 =?utf-8?B?aHNadVVBdEhqODRkcUhLSklqSmo5V2Q2dm9ibG4zSmN5T2VTRUx5ellZYkdC?=
 =?utf-8?B?Y1lxU1NmVGQ0cCt5YUNDQ3lSdHFVcEdZSFRyWmthem50OFhYcGIwUlpHWUNp?=
 =?utf-8?B?Mis5c2RweGx6R2xGeHFrWVcrL2ZnVnBMUWNlYUtINFoyVUxaOGxFQVFnd1l3?=
 =?utf-8?B?TzBiQ0MvQkh1OWFRMmhZQnZPd24yVmR3N0lpN3NCcGt5dkdNTURZS2R5SVIr?=
 =?utf-8?B?YkkxcVRWSmpLc3NMSWFEZnYwRGtwMGkwTWliR01IZUlRR3VJWEorZ0xCdW5K?=
 =?utf-8?B?MW1IUGtXWDgvSjlmK211VldVMzQxWllsUzJ6WEhIUExpUWRxSk5pdzZySTlM?=
 =?utf-8?B?cHVndFljWVF0Yk04ZHRMcVlNL1lKMk4wc05xMk9sS1V0aXhZNXI4T1l0eWI5?=
 =?utf-8?B?NTl1azZsTk9McS9lUTVYbEp3cVNDL1FSeFI5UXNyVWJvZEhGY2pXdkExcHhS?=
 =?utf-8?B?QjR1cEgyZHdmZlEwN0R1YzhXRHMrNldDRjBLV0FMTVpwUmNFS1BkbS9kK2NS?=
 =?utf-8?B?UDZMcHVDbElMTTF3THhkOW9LQTVBaUJ3MUU3S2JJT1NjTGRhdHZWRGZyWFpZ?=
 =?utf-8?B?N3hlYzZqUy9SNEFHNW9YVVJ0ZGNzeGVwUnkva1FWRmlZbUlRQ2FNWUxKakw1?=
 =?utf-8?B?MTJyY2RMdXgzaHZuYVVzamQ3aUZYT3JDREdSd3U5Rk53bit2QkN1QTVpSHla?=
 =?utf-8?B?RHlvOUNDS0xadmloRG1LcWR1b1RxRlg3TG1pZkZMcVZNTkYvai81bGo5OGVB?=
 =?utf-8?B?SWtJZlV1emZDNVVuTUZhZmVWdnNlQ1QveUZJRE81UEk2d1RWTnlRc0diM2t5?=
 =?utf-8?B?ZGNFL1RQb1pMRmZITFcwOVNvLytreXRjR2RSSW1JMkIvd1FJRldBeEVNS3ZM?=
 =?utf-8?B?MkRHNkw1aGJFMnk3aEtuamlwQWxyNzRCRmoyNDQrRE4wTGtTVjM2KzJqMXJN?=
 =?utf-8?B?RW02eVRlVDJCaSswaTBpMkdNcnpNaFgyRGJtUmZqSk1IeUVDMXllMGk1Y2Z4?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sP1xDhhWPQcQl4pRysY/30Z5BVSMmi0dFrENLOSzLy4yZT4+epGI36UNkXuI4ce18698jmu6UiRKeIuqVdva8iC948pbG6+1W3Ab+d53v4hdaKj9vrAb157RM/mU+T8AFdIkNRtyc6+7j9xHCDicjGbb4Hq0tM+aFaRx/TBkOiWsLeULQCpOxNJd985KcKrMs0oJp911rGlq9k4HqfiuiARMdx3bZ9Yi5GZHwfpGfAR2QjcWKAvx0134CbTzMIvgGsin/Rpdsk7XK019xzHCulGRXLqFIsVvSU+GjXxljvfBJ/EsL2taOTfDm05v1v6KhT2bdIy0NeTh2L8dgEVhF+m4fKKFjcD4sm8qaPfZKgTu3B8ZQypJ4hBo4pA9tYbUmNT6WScZ00KYIovqDbGd//nXLpXhv12F4j5W6L9IK7hHoznzlsQ4/Y93xMap9TOUlTJathZOmZUtBuOVygs5s9OqoKRiRlRIlgylClicuTUSSu1J1IIizQQEx/lqhkx6SX6/s1OYZXlECq1vus6DEH8ZibgjbTqPKvsH+Ndt7f/aRMzvHYg8QKPVrOkfIGWEhYkF1aBwI021EE/xPzQo8a5CxKItONaBFdu0qI32cPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e659cffb-7265-45f2-fc57-08dd08e2e5af
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 21:41:16.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLyiwFulApFhNffRypwJqwHBDGyYL7xna9mgtY1mJtB8kUho7KLhqeBQvbhemnciJfW1t2dmCsjmXEFhja6h4P43O339KUC4PdOM2Af8y8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190156
X-Proofpoint-ORIG-GUID: njtwsdv4fRfmDfZ-GBYgchvP4qR3SDiZ
X-Proofpoint-GUID: njtwsdv4fRfmDfZ-GBYgchvP4qR3SDiZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/19/2024 4:29 PM, Peter Xu wrote:
> On Tue, Nov 19, 2024 at 04:03:08PM -0500, Steven Sistare wrote:
>> On 11/19/2024 3:51 PM, Peter Xu wrote:
>>> On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
>>>> This begs the question, should we allow channels to be specified in hmp migrate
>>>> commands and for -incoming, in a very simple way?  Like with a prefix naming
>>>> the channel.  And eliminate the -cpr-uri argument. Examples:
>>>>
>>>> (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
>>>>
>>>> qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
>>>> qemu -incoming main:defer,cpr:unix:cpr.sock
>>>
>>> IMHO keeping the old syntax working would still be nice to not break
>>> scripts.
>>
>> The channel tag would be optional, so backwards compatible.  Its unambiguous
>> as long as the channel names are not also protocol names.
> 
> Ah that's ok then.  Or maybe use "="?
> 
>    "main=XXX,cpr=XXX"
> 
> Then if no "=" it's the old?

Sure, that works.

>>> I was thinking we could simply add one more parameter for taking
>>> cpr uri, like:
>>>
>>>       {
>>>           .name       = "migrate",
>>>           .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
>>>           .params     = "[-d] [-r] uri [cpr_uri]",
>>>           .help       = "migrate to URI (using -d to not wait for completion)"
>>> 		      "\n\t\t\t -r to resume a paused postcopy migration",
>>> 		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
>>>           .cmd        = hmp_migrate,
>>>       },
>>
>> That's fine.
>>
>> I do like the incoming syntax, though, instead of -cpr-uri.  What do you think?
> 
> That'll definitely be lovely if possible, though would any monitor be alive
> at all before taking a cpr stream, with this series alone?  I thought you
> dropped the precreate, then QEMU isn't able to run the monitor loop until
> cpr-uri is loaded.

No monitor or precreate changes.  I would parse -incoming, extract and use the cpr
channel early, and use the main channel later as usual.  It's just a different way of
specifying cpr-uri.  I like it because the specification language is more consistent,
referring to a "cpr channel" both on the outgoing and incoming side:

   This mode requires a second migration channel named "cpr", included in
   the channel arguments of the migrate command on the outgoing side, and
   in the QEMU -incoming parameter on the incoming side.  The channel must
   be a type, such as unix socket, that supports SCM_RIGHTS.

- Steve





