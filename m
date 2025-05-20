Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCEC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOX0-0003QW-9S; Tue, 20 May 2025 11:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWy-0003QB-Bc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWw-0002jZ-8v
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:23 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6iN7A005330;
 Tue, 20 May 2025 08:05:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4CMzSSI+hUGYckKf05soalatZipwzS2I/sHGueW06
 8M=; b=CSlj3w5iiFhQU+MuYbt4Ry31uXmGmQjWatiI1tDL8i9L3oUvYD5xOnkQw
 UQi6lT4nY0CmMDA+pQKWrwtPlL+UniWbenUm7oFTtaVr/qbthVCPm99wTsILMzeZ
 J6QDVWbJZyO0cH4OednCq2OzXRKGEDKHedA9CUH25yBxnRh3wxxZmWat5svLyBA/
 8Ldv/csvW9Bbgy8bjy84XSJhJmHf/xf0vbovKVKmrMRS7O/JI2Bcb6JJ7ImlSSfn
 pOgrADX0N6VFxcHDBe5ZZ4k0Isfg1OZkJHuI7kP/ozrr8KW9KrdY78TrcZayNPPn
 Ciy9hKcYXNdGj5GRnQa1LFezbRyRA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46qhuncujw-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhP50sn52GsQ1rILPaWjjrIwqXZPEbnrDlmFsSjteeBNAPdpbTQnVxVEv/sgyM/jqGkR+KspdUY9SOfhSrW3Q7ipxtBIYjY0VmVZsJhx6ob7u7/T5WuyeEUGsU1DZ5QycaQOf/gnxNmZNDdJEcUkjHCbozVv5zeVf0XLXS07q6x+B/jToxt0CVSkGcExhcjxkGi+5PTIgEh89yEI9C/5UDxZtpDDuj22hxtttAeUZKx2+gip2j47hPT93vQdi0oObpZlcgh5gmMvbrG1Lszm3IGL0GggNjeP3QjLpUJqgapcFP7dlRpYW5m97/zVVf6wFGpiikl7y6G+fyvEZDjRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CMzSSI+hUGYckKf05soalatZipwzS2I/sHGueW068M=;
 b=GX+tJ7ypg8ZF+V4yx4oQYhMKJbL1gt16Bcoiga43jbpd+8HlVGJUDQBNBXsgiqzoc6Nkh4vJaq0izqK1mRQhoeZueR794qkdOwnt6CoqO4OoVNmIRVVZfjKgHNJI1OIkP11BJjmO5ByBnMNum8gRpFLr9KHSgTpHs7O5c1lmH0ge0OjHvq5TeS97Jv1CpVV/jByvyoARcouBM7btIGEgXaQpkU1i7ItHXwDYvt7o61TjAtuPivQlOQomFFHQ2OHDggdYnUwV1BH52/0KX8U28jnLDazqln9nukwkDCPR0nDLI8WlH8rGwlgJHbXmmf5zKC1lIT0+MXxF9w1eFd6mVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CMzSSI+hUGYckKf05soalatZipwzS2I/sHGueW068M=;
 b=CiQ0lMzMZJ7hdhiXFXW4qBvqUWadSoCIMk3eNJ/1uWwUVh6HkRw/hOGck4yT11rbzX/1kgh7DvDhbHaJVQfhXxCBtCdqsKuzIlmKec7V2kVhMt75kovQVC2pmmZ4UlOyUZrEMl26V9k4NTqBrmDELwBCPcii8PfGHEZxEbM4i7rj0HP/oOWdjx93xk13yEmC8h29B8q4VglXl2BKFsQR3MWoSLgUi2F1xmQxFBTJGcUYr6bD673WwftkOkKs3FP+VcwXJopSDNqAZDRwR1p2nWHmIx4ERinCRZAdwG6DYjqyCaZJqZ1Ne2I070hsg1NsnEViNyzRf+ck90aeaVao3A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:18 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:18 +0000
Date: Tue, 20 May 2025 16:05:14 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 00/27] vfio-user client
Message-ID: <aCyaKn4vxa_P8lFi@lent>
References: <20250515154413.210315-1-john.levon@nutanix.com>
 <6cc53fff-9583-48cc-a5e3-3dadf1dd215c@redhat.com>
 <aCsyUnQj33YEtAjb@lent>
 <047d7d93-3fa5-41db-bdbf-3c14c8b47455@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <047d7d93-3fa5-41db-bdbf-3c14c8b47455@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::29) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 90791676-7dcb-4fb0-fdc8-08dd97afbbbd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2Q0RmRQZXJLc2NCaFJ5RnJuNGNZTzFGdldVM0NueFU1aGZHZVNjUGdta0I3?=
 =?utf-8?B?SlNqbEd0QUMxVDYzbHRvU0xCN2NoTm9YWnBHTVBoTVU0SEJHdXROU3NlRlhK?=
 =?utf-8?B?KzZYajNmY01XT2tNb01MQU5KMm9RU0VCdzJHVmwvTWFMRGp3ZzI4NWxtZ2Ft?=
 =?utf-8?B?VTVPVWUyYXpEYkxCT1IvRFMwdXFVTXFSTEdLQzg3c2U0d2w2VUVGR2JCaWJk?=
 =?utf-8?B?SnFEY3JMcnVwNTFKY29URC9uUTdyak14czRaSHVudWJseU95eWJLT09CRFdC?=
 =?utf-8?B?dlN1dy9OSEcxaktJamZ6R3ZuV1Q1bGthRWlDbXg1aXBqeU82QUVVeDAxalhM?=
 =?utf-8?B?cC80VDk3ZVNMK0Zxa0tTUVdaTUFHSDlRNVBFdnhGRXRDK3R3cmJkWWRNTjdZ?=
 =?utf-8?B?UERIdkNRRGg0aUgvWWo5Y2hWdTNYUFZxRk1Cek9LQzZEN2tpUTlBSUkwMFI1?=
 =?utf-8?B?UWlWSnJMVzBzNktSRTJvN1BwbnBxR1RsZmV6N2RtZFlRb0JhaE5mQTZoVUsw?=
 =?utf-8?B?TUZrZytFeVNMaUROY3NuaEFiWGNRV3Z3NkJqTXc4Y0hrWm4zbnB4NUE0eklh?=
 =?utf-8?B?ZEVXMnAveDB2cG1KVndUelRCUDQxS1A4UFFlaWg1Y3F0TmZEYWk2RFFBWEgw?=
 =?utf-8?B?TldocVJaeUx5TmNyRldJMjRRTDFPajc1R1QwWEZXc0VOSHV2VENiUk1yNENL?=
 =?utf-8?B?RGt1aVhEN1RUY1lCTHNwVXBsdjN3TzA3U2dRWWVsS2w5WXkzV2FKdEtwcEdP?=
 =?utf-8?B?QlVscWNNcG1XeDdpOW1aMzZyZ2tvRUsyMG5xZmJLcDVxQXVwUGxJOU1nalJU?=
 =?utf-8?B?SHJQaGZiNGNnKzI1ZTYzQmdyTmpnbk5yMXU5STVQazM5cDlqUVBhdW1FS1k2?=
 =?utf-8?B?eUtqL3ZxVmlHcVdRVDdjOEJJVFg5Z29aaXhyeFZyQmFyN3hRSU1MTDU4REZo?=
 =?utf-8?B?L2h2WGkvOER5TEI2ZTFEK3FGVktVUmM1WWc0c3g3bFVPWUJScVVxd0RpUUxi?=
 =?utf-8?B?SW5yMEtGczlzaXZXcVhJNVB5VFpIZlpQblpaeXljUkJFYmw4cVp4eWtQODJF?=
 =?utf-8?B?Sk9NNVpMVXRtTlZxSHVuVmlFMC96WWZRZHkrRThuemxqUjE4Y0JScGRCd3Bh?=
 =?utf-8?B?QTk2K1MrRG81VzBGMjdWMmZVVVlpbVpCTzhRRlR5eHdkRUFLb1VqTjNMSmhH?=
 =?utf-8?B?Uno2Q3g3RjhSbGRXR2pmWUdiQkNNRVBCWi92TExvcTFaSU9TdXFVYitsTEY0?=
 =?utf-8?B?UUJtRE5Ra2lzdkt5MVEyVk04d2ZlQ2lkMzhnRnBkejU2QTdGSEg2b3hacWc1?=
 =?utf-8?B?L2FwWERaV3BscE1nT1RUODhON3RKcDhhM0QxQW9nb1pJZW53RnA3SlhIVytl?=
 =?utf-8?B?ZEVmdzlWaHJwbkIwMEtMZ09sV0lHSXRueVdmTVZIanpZSXcxelVKbStTZnhx?=
 =?utf-8?B?WDlhN2YrRWtQbHFWVzFzaE9MV1RsY0pVS01UaGcvS3BSUWQ3QUVZR3JqNkdw?=
 =?utf-8?B?SnFQTUJKU1lHWlltL2ZXSVpiOXNScUdPR3VCVFgzQ01HeHhyeWdsTG10TFUz?=
 =?utf-8?B?WndmdEFod0lCOTkyMzFaM1V5cW9yK0NWb1RBUER1a04xRlFEY1laTFlOLzds?=
 =?utf-8?B?WXh1S2R3dkZCeEE1K0pEYWIwK1NFYUlPREJ4V2tHU29rOVlsWHp2alRvWXhj?=
 =?utf-8?B?bUpUSEt5S0FHRDY0MXMyWHp2UFprU1pEeWJBeXBOaktFd0VoN2pKMWlDUTJr?=
 =?utf-8?B?b004RUUwVlozbFBZNU9nME1JcXgwb09taCtXK3RiL3ZSeFpLaGtVYjBiNk5K?=
 =?utf-8?B?U2lHSllQeVhzT0dVdDJDQ1A0MU5VZm1XOFM5RXZ2TjMvOEFVT056ZDZNREJG?=
 =?utf-8?B?WTlxN1dmQVZMS3VzRlB4a2diaS9PTXp0c09HekVwS1JFbGV2UzJqTFdEZE1s?=
 =?utf-8?Q?zwzfRpsO70E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RvU0dKdDJsVnUzR3cvaGxBMlZ6ZU1iNXU3Q2FFTVcwTWpMVVBtWXR5Sy9k?=
 =?utf-8?B?SWxkdmIxYTBuUnZCZnFVcEZtUEYrSUMvK2hBK1pMNFZwbWRYQ1FabTZQUk5J?=
 =?utf-8?B?NVFaWHYxSWxPbDVzRVZjUTkrN2Z2ZlBZaUMrRDNqQXFaSkQzY1YrU3JDODZr?=
 =?utf-8?B?S0JUdDVvcW5UMjZWN2xXd09YTlFMWmRjK2xycjZ0OFZFUHJEL21kZEdzektl?=
 =?utf-8?B?M0pZd1MxNkVxR0lmWVNPdW9XclhoL0xwZWJTT0tPdEdMNytVcHk1Ykp5MEFK?=
 =?utf-8?B?TkEzcTlxVERIaFMrY1hHL3FxR21vbS83RFR2a0xaZ0ZrNWRPZEZJSmcyM0Rh?=
 =?utf-8?B?bDJBMFhjRlpXaXozY1R0Mm9jRFpVY3FWWHlmaXNSUUxGWXltSjAzb25abmtY?=
 =?utf-8?B?bDZiclAyb0FyU3padFRwdWNGZmZuM01iRDROUytVeEUwNTFkWnd6L0MxWTI2?=
 =?utf-8?B?NHU5eFRuMkFJSmdCc0Q4dTJFeFExMmJHTm8rZ2dmWk9OdzJ0RG1JM0s4Ym9h?=
 =?utf-8?B?ci90Y0pLTHJNSGFXTkpncjNkU2RycHo0ekIwUXJGdGhEUEsrazl3MUpwem5i?=
 =?utf-8?B?WmJVMnlIK0YvVkxEa2tvZkhzcW9UaUhUOUJjZUJmUGtia0ttWWM3ajA4MjZ2?=
 =?utf-8?B?b3RycjEzV0pvZStmSEI0Qnk4WFhmR2VnRkZUWWVBZDMwTHFvbkN3eXJsayto?=
 =?utf-8?B?bVkyQ3l4c1NlVFp5TjFHamhFTEw0Ulo2SjVCbXhlOERQSHBnbitnMVVCb3Ft?=
 =?utf-8?B?bGVud0tqWWlyZVJVSUpva3V1RlRObHo5MUVYcE1qZDdkU2U5WUFpNGJkOG5h?=
 =?utf-8?B?akR1MWwrWWd0NmFpckV2MjN3SHRVL1pEdzlEajk2N2lXbHZEU25mMVNXYmhp?=
 =?utf-8?B?TG1VYjB2bjBCc2JuSFFYUkhVZUtKTDVqT2lQNjZ1eXhIWVBXNmxwQmttU0Yx?=
 =?utf-8?B?L1NrNlZ0TGl2aUJlRWRadWtvNHBEQU9YSFpSeWErNHZLNVozK0JOZVd3WXIx?=
 =?utf-8?B?SHZCaDdHblh1dGlzTFFyMXRmMXgrcUNHblowTnRuRmR5Rmp1Nis5cEw5bFdM?=
 =?utf-8?B?ZlFRYkI4T2pNTWtHUG56SG1zWExnMmNWMFpoaEJucWJSeVhxZUJSY3ZISmFQ?=
 =?utf-8?B?NmZFbDRhNVJFUFhENjRvdXR4aFBRWENwZ3Qxek5hN2RUQlM3VURKVnhSaTQw?=
 =?utf-8?B?MytMdENkYWduTVhsSm5ENUJ3cVFOMnpRWUJsY2JFNVFxSmFUUWN5bFVRK01Z?=
 =?utf-8?B?M0k3K2ZhOG1sbE9vU0w1eHNGejdkMDZWeUZPVVFqM2FCd0RRdGhDRG1MQ29l?=
 =?utf-8?B?d2tzZW0wSWRyaTZ1S3dENmVjNEtRRlBNYnNKd25NUm83R0tEd1dCWFJ3a3Fv?=
 =?utf-8?B?S2pObnlDM1dKWTVwMXFMR1VzajV5K1dQMWhsK09IbWJqVGJVdHVmd0JyN2tI?=
 =?utf-8?B?VkQvSkZBaWVUZ0NqSjIyVkg0WWVIK1FyVVczL255V0YvbFB6amZXMnJjM1JP?=
 =?utf-8?B?WDJBUmI2OTdoU214VWRQWWc1Nkl3SlA1c01ydDJ3dGt5QmkyT2dONGRaUkJI?=
 =?utf-8?B?NE9JaWtNbnZ6ZUgxbVM1NjczSkNoanZpK2hidm1TT3ZpOUZvbnhtQ0J5dWho?=
 =?utf-8?B?T3BtRVIzUUd4OVg5SkpIQU5kZnRNYmtOVmNmSkRiWFYvcStER29jbzRpaTVz?=
 =?utf-8?B?WXVZSk9Uc255RHE5WE5tZjZ3U3U3Y1U1REdObUc4YkltcVkyUzRZTEhqaWdI?=
 =?utf-8?B?bzI5MmxCQlZIdlBscVJvRVFRY2RZYW4zVVk1SFJwNmEzdnVjdE82MWV2VE9O?=
 =?utf-8?B?ZC9BM2Z6cklRUWlkWFNWdWRPZ2kzMDZ6RFJ2YTJuL2xBN1BrUHYxczdWUXY0?=
 =?utf-8?B?aHpVYWV6bFdPd3lqUWpGQ2xmMmxlOVMwYldsVHJlV3BPVGxnTS9tdmRnUnFq?=
 =?utf-8?B?NDdCTmcxRU02M0FzQ0daaUZuS0J1OFllMCtiSWhreGtHeGNRUmg4VXJSbC9h?=
 =?utf-8?B?V1dFS0hFZWl1bkhSUEVKRkVPWGZaeWZxeGZoZmd3QUwwRUg1Qm1KSFlxUHo4?=
 =?utf-8?B?KytqVWZoSXRNRXhITHNOUU8wdEZ4dU9KaWN3Vkt6ZmhXNHJ6VC95YzBjQmxh?=
 =?utf-8?Q?gAx19lno0MVWS7Dl9AKtU6cMB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90791676-7dcb-4fb0-fdc8-08dd97afbbbd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:18.2990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obYLAJE4ZSZdQmOcazb3/YxVjYDyIkH1YM5CP88KXw70WYJDLO+CvLnmaPtKD7L3xk6NU6euw2RSvijDXfavRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-ORIG-GUID: cTtr6FgRFH2sGS5QGVLua4yD3RFfYsKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX++raOEeJB0Xe
 h9on4uElXSWMTNZ4xn7r6pi6hKMF4B0G7bu9ANOWyYNy/dA5CjQhU8n/oBDqGInW1LXNntD39eF
 yh6tRqdPWHupmorM+mxq6QA+ikxpjOFvn7G6xM77m8OvNMc1NGXy4Tjk7PXyfx2PP2iZojpfXn6
 TASdRpscDsKCaBnz0ICcqgMsZAHZcxN6zJds6KyQORbCwh6WwuUm+ckCL0nU7Akvy+NJSn37k7c
 TvOOmgkuoM1gNbVNsfZui6FZ1Zjga7zKFwHinHI2o5n0QhUKJ8Pi+0TVgHE8o6So0YkZ2QC9Hqt
 VmCt0PTGp93tpUPxVjpqT8G6BSkAA9LAbBANVgEHIsf1M4SbHO28AoYyNsNV1ulmT0Lwj4195sj
 LVrJwdlP8vDB5nPiRWEuKqlcvbEekiqkfXnA8wFNM/yd9biPAcJ3xOBrgS48X4OrV4HyBkL9
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=682c9a30 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=6ssw0hLnppJHr6MsX2oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cTtr6FgRFH2sGS5QGVLua4yD3RFfYsKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Tue, May 20, 2025 at 07:59:13AM +0200, Cédric Le Goater wrote:

> > > Would it be complex to propose a functional test for it ?
> > 
> > We have a libvfio-user we can use, but this would be a problem:
> > 
> >   487   │ 2025-05-19 14:19:20,304: modprobe gpio-pci-idio-16
> >   488   │ 2025-05-19 14:19:20,306: modprobe: FATAL: Module gpio-pci-idio-16 not found in directory /lib/modules/5.3.7-301.fc31.x86_64
> > 
> > If somebody can help with how to get a suitable test initrd with this module
> > available, we could at least do basic testing (although no DMA).
> 
> Can't we update the asset and use newer images ? It's also possible
> to use a custom build, buildroot images for instance.

Mark is going to help me out with this, stay tuned.

In the meantime I sent out a v2 of the series, as there's a couple of additional
generic vfio patches you might want to review.

thanks
john

