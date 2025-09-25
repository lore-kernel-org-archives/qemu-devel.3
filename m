Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E47CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kDI-0006RD-Bk; Thu, 25 Sep 2025 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDB-0006Qh-EK; Thu, 25 Sep 2025 07:32:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kD0-0008Hv-Jq; Thu, 25 Sep 2025 07:32:31 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P85VtC109125; Thu, 25 Sep 2025 04:32:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=d37vX/aJJeLQfXMbisynUBnrezCjqNsRqgb6iKkM6
 0M=; b=qbMg5cWrfnsYq1v+5KZYwaVWJ7HKvI81wqpzwAY7rOqmccjkh+S585RSe
 jnBysuwQ66wmbLrbrosbkfa7gAKJI0aWabG27rr9iIpY5pXFFYCaegDhv5DffjCb
 vElIb4wJzeKzhuUscq+7ge4ObaL4KLf1JN+XSNDG26G1eNZ4rWNx3O4fjgaYnf6s
 dWdSEARY2FM6rIeiWu9SiKAXZ7PjMdAuwZOBdzwKEhzKrOpuo2+okEUHm6sO2pGa
 rIQhkF6W6aeRx2pHP4xa7xpwsmX4EAHCjmu5moXE+jgxrSneqSoVDJ8E25EKk7KV
 7dx8RhNEoS9MqAMOR7W9IV+TIEPHA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022093.outbound.protection.outlook.com [40.107.209.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49d1x08dy2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGIGAdIq4Coqc0HkV7NFTcjCQw+YU+ARQS2mrDRa86pc9LvGSIGsdQaz4ntwB51ngdfSPcadBzBXydYRAsmMS+WVDVksFV+4yFL7AeQn4uxKIsHmOJoMdRoOVpvIca0+029VEJ4kxGdnVTG3PkzhDRK7xtR/YU89eWgDn5nkwpi4r5K12TIun4Sz37FrTWYiVEXU9ZLJC1Iq3mh3qbnN6oT2eyh1DdS8iqtOgu9fH1nOb07aCjNQ/WM/2cFIGoF+r81UnGqd/G3cik3FJMYBPztoocpNCR7JzgXpZ2RWz073ULeuJih2BFvTKGuIib0r1RUf4rIlUfw0yY7zp4x12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d37vX/aJJeLQfXMbisynUBnrezCjqNsRqgb6iKkM60M=;
 b=nGiJsrsMOh2xLNww2hJqsD1FkjM+Xzc4qMMyVf2psbBLsEl/0PzHtmErZDHFPJuiV+iLk5DtWN3HLxkWEuJ3qVwKblMJEVvvJ77dVoRcSH0VEPdMcGLjBWFCKQg9NnXNuNEnrDgBoSYzX+AzdVP9DNmRPvtNoH/o4X4evkixojZYjIK3AVWuZn5f1m7LkqELsZKp4Y/XV+wCeMFB4RUfT3HP+EW7VadXgJ1g/WlvbHZXICro9nbKkZrjsuLzy5A79r0C3E11LmgZQt29N2+CZG6J1EixdF0quV3BtQ++BhzwCCktLWI+v8WTg4JM5G4QQYtla+18jp7btKlX+suRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d37vX/aJJeLQfXMbisynUBnrezCjqNsRqgb6iKkM60M=;
 b=PR5rmiP3WrUSUGf8FSolnYglhkphShzS/EpDeMEtVqKked5gJDzm62P/w7vfRb/amaBR+oLaHO/c7TaBIWB0W6ckfGiZx8Ul8jZwN3+z9OLppvzscYASP8uGcuwLf3cvZFU65pr/X1Txp7Iknbq3md9vTBGMSBG9oMXNAK9sECRy31qN4MfYP+MUkSzjFppVwaSaoKXIsBDwqOfQHcqHLcXms0AP0mnGVvNXeK5gLcqLyhGLkBqW/ibVvaAPBD+oOfAyaFjwN32us7MpNXzZwj1gUyddY9lIkpxxz6KAf1dXa6tCsQpO8z0HvEyjarIf43w3ZHgit96QRX/EUkDVNw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9532.namprd02.prod.outlook.com (2603:10b6:208:40a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 11:32:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 01/28] include/hw/vfio/vfio-container.h: rename
 VFIOContainer to VFIOLegacyContainer
Date: Thu, 25 Sep 2025 12:31:09 +0100
Message-ID: <20250925113159.1760317-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0247.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 21104279-7627-46f9-0736-08ddfc2727d5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE9Hcmc2V3J5RUhRSU1PMHpHL0YyM1o0YTBDMGFNZHM1QzlxNXozNE9HbklZ?=
 =?utf-8?B?YitXci96cEg1MVY0NFc5cVE2a2NVaXV1aXhHdWFaSVRqNXhzSWIrazNRUDRY?=
 =?utf-8?B?RERKK2xXSzRxTG4zSUNCZ096T3VpWGhXLzk5WGZQR1NySWM3UXp6TEIzY3px?=
 =?utf-8?B?VUttTTI1VlFoMVhKVnZtdm1RZERXdU9nbkVQUnYzdG8zdmFqekoxeGI0WHBn?=
 =?utf-8?B?cWJqenNGZFF4TFd3UkdLR216SWFnWVpnZExOQzQ1WHdYRDNSOUlId0MvVFgv?=
 =?utf-8?B?NWsvNzZGa3FiWDF4QlRSU2E5MmFiYzRsb1RuYngvUndXdFY5UmQ5TGhYeUNN?=
 =?utf-8?B?c2NvYkthTU96NEI2bFR2cjZ1QTE3SmZpL1RBczR3bFFadGwwcTJUS2psb3BU?=
 =?utf-8?B?L2JwNmF2YTUvdUFFVnlkS2xBV2JlQjJsa3Qwd0xXRDlpb0o0OHdsVVJJV2dH?=
 =?utf-8?B?MGNSb2szSzdNU2krdnBtWGhRNWZabFdsODBTRUxETmZZUVJMQzgyRXpHaU9y?=
 =?utf-8?B?ZWUwdU1remVUcHQzRTFwZlViamdnc3djT2tEYTYxUEt0WmVQc2p1RzZKeWdL?=
 =?utf-8?B?UUxCR2FKK0h2VnM0TEVSeC9SZW1LN0lFSyt1ZlQyWFdLV0hSZU1zN3p3ZHNK?=
 =?utf-8?B?Y3ZvUVI3dk9ZN3drUnZ3aGc2OTg2Qk4zWkRuS0d3TGIvaW1wdm5ISUdObDVF?=
 =?utf-8?B?NjQzRkFDNXdWbTJobHlsRGVpSzduenE4OVJDeVk0ODZKTHNMWGJJbGNudDdP?=
 =?utf-8?B?bVZsb1pSNm5OTE45SUFzdGZsd01tTGhyTFZScmVHZHlxLzdGSWl1SEFqR3hX?=
 =?utf-8?B?RzNUMHZ1UlBqSXFLTlordlRRcTBrLzlEbks4dnN0NjB2dUpmdG1JL3BCNmdN?=
 =?utf-8?B?ZDJseWhrQ0pJZk1lSHphTjRidEhnQU1QTnUvOUp0STJnOVZnNTdzN2VjWldF?=
 =?utf-8?B?eXVhaTFiR3gzNEhLS0pkS255NlBUTkR6RldYMGpNZEg2ZmtQblNIbFFJSSs0?=
 =?utf-8?B?STN2b0JWUm1ZS3lRVjNpc0U1SDEveUdZUWtzd3BkNStYd2RMNFZmUUFPUVN5?=
 =?utf-8?B?TnNUM3JsenlYYTFncHVYcFBsSEpIUW9qQk1zdGV5NU5sWUVuN2c5cGNDdzVx?=
 =?utf-8?B?TExQb3RQY3pIdWhvUWs0OW1zTFZPbmo3azdOcmFQRWZ5Rnd6VGduOGhPWWln?=
 =?utf-8?B?cDByQmhEcExUU1JiVHN3eVdEYm9VSTZ0M0JEWFlqU3Vja3JXWGFNRUpZaGhK?=
 =?utf-8?B?TlRiQ0JSSTE1RC9Lc1R3NnV4Ykl6TlZiU1Y3U0lHUFpLa253RU0yNE5EcWJa?=
 =?utf-8?B?SVpjTkRKeFhkcnRWYlZZRENZclVCT003RWVwMCtJVW9hWFAxNHo3U3gweGts?=
 =?utf-8?B?d0ROTXZNNVhhVzI5U3ljbTVxTVV4NjNoVEpxMnBDSEZESktTUTNFSmlqMXVz?=
 =?utf-8?B?RUxJT0JoekszdmNMQms3TDduZkZxYlNaWVgrSDh4YUVXQVVaTG5WNGEvVjhw?=
 =?utf-8?B?SHc0bk1VU1FrRHMveFU3OHJnc0xJcGl1TjJzR2tCRWRFcURkYWhPMlJwT1BY?=
 =?utf-8?B?TU9hNjZ2eXJ5Nk5KcHdBblFDcy9MRitUdlR2NXRWcGxTTzJYTzJVV0I0MHdq?=
 =?utf-8?B?RUtQcGRRNTlDVmJBZWdCUXFCU3AyK2Qrc1lTNzJQVWZVTWh2M0JhYWJqVVFQ?=
 =?utf-8?B?ODZIclVwdEwrWVlZQllsUUlXbEVqUjltZGRacDhERDdRMnRVVXE3VWx0WDhN?=
 =?utf-8?B?RVBTdWNUQ0RDcFEyWU1nR1VXOUFKTnRqTW9scEU2S0MrSTZuc05QZEQ1dVdC?=
 =?utf-8?B?U1FOQlArMWV1OXpxNk8yVk9IV0JSQkwyYmh3a2hSR0tRT3hBcVhPK2Zicko4?=
 =?utf-8?B?QWRxZ1RLMU9XM0o1VEZ1Nnk0U1NWdTladzUvUDFuRmp4VWlsNEhlWEZLMHNL?=
 =?utf-8?Q?IFqA5VlYwwOH1ieh9PAE8EfkXiPwXU7G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTc5eVdzOFpXYXloTGM4MytzZmpkREFadG9qcndna3Y1OWErMmU1K1ZubW5K?=
 =?utf-8?B?bktWVDV4SnFLYVVLUTY3Q2hZZUh0cEYvY1BzWURJaVJoeVN2NTRYaG54akJS?=
 =?utf-8?B?bjVUckVJTnF2YS9TVzBnS1FsTzRtU1VvYkk2U0pTQjNvTUg1ZFdyMUFrdnd6?=
 =?utf-8?B?UEpBWVJrb3FSa2hOdm9EandlZHl1VGlhTlNjOXg2WktRWmRjTVBnbFJWamZY?=
 =?utf-8?B?MW5Pc0p6QzBza1htTCtQU0Q5YXkxdUtvcGNncnlKYlZVOEtxVE02RUpBWFZ3?=
 =?utf-8?B?bkZYbmh5bTczQStXODB1SFdwZXdoNUgwMndINGU0ZjV3SzlkcXl3SE9IV1Vl?=
 =?utf-8?B?aG13ZTZNY2lYQWRBUkJSVUt3a3B1c0E3TEF2ejB4RGx3QWpiT09FeHorUkFS?=
 =?utf-8?B?Tk82bS9SeFFNeXEva1hWMndyZVgzOXZ0bFlJK2pRdnVGSG80cjlSSWdWbGtS?=
 =?utf-8?B?M3VtN3plT2dZVXg1Z2wwOHBJaXFBVWlISXh3WVlFVktRMmh6aE9JNWdLbExu?=
 =?utf-8?B?S2tiTHBRc1drV0duNXBDeVpVZXZ3QUsvaGgzY09FM25OSXNNNXNkSWlBSzhP?=
 =?utf-8?B?RjZDdnNsMGk1RHBEcVc0Sm9FTWhianl4bjBLWDhkdU5iNGNoMGwvdkVZWnlE?=
 =?utf-8?B?eERwaWw1T2Q5eEQ4emd0K25zdmQ4azZzQlVBZENiMXZYQ0N1UGZvOHlOcnln?=
 =?utf-8?B?b0laMTBCazRaajZJUS93bll3QVpkZGdWcEFxanNLSFJxbDNLRzIyejBBRUZo?=
 =?utf-8?B?UXV1QzFlVGxPZnJUQW1vVWJ4c1N6YXlmNi9VNEtxc0RpbE9RMmEwbS9xbjd4?=
 =?utf-8?B?aDV2MHNmaHRCTDQ4eXZ6VVlQYjBESFZ6TFpJcmJYOTJPbWMraVR4dndOMkN6?=
 =?utf-8?B?UzF3TEJvN29ySHJrMUozQlFMa1BBc0J3M1JEVDB6UW5FVm1QaEQ4L2IyaG0w?=
 =?utf-8?B?NUsweTFENjJjQTdQSWpzdlkzeVFtM0x6YUpCQkxvdlBDZDRIb1U0VjI1Mjl4?=
 =?utf-8?B?VkxNVUtQRS9xZnlRYTN1Q3pub0dZOEdlU0RsN0NjUFZreXlocENiZ3RjVkxY?=
 =?utf-8?B?QThhS3hqWDc2cU5neFhBV1FNRHpROWVjLzlJclRlS255dEJ1NE41NnA1bkl4?=
 =?utf-8?B?N1ZWWkRUKzRmajNLVGJtdUpJVlJJTk9kOEpHWU9sVk1nazZBRE5ENE03aUdS?=
 =?utf-8?B?L2huU09WUUd2ZnFtQlhDbEhqeXF3WVJNK2RFNFBLQUZ5NVVIeEZ1MEtrZndo?=
 =?utf-8?B?L0lFbkk5dDVRMU5peUd6MkJ3ZDBGQWVHeDdabERzdFl3TThnY2NiZG53d2Iv?=
 =?utf-8?B?a2daMERNMEg0Wmg5YlNsT0wycjl6aVFwZG9peEVtYnFvYU5yeHk5bTh1N3RI?=
 =?utf-8?B?UElMWFp6Y2lkb1VudVVYTFcxMDlRWFhlNHQwK2J6YmNMZVFKTkpTKzMrM1NJ?=
 =?utf-8?B?aEd1dzY4Z2g2eFBKamNHMlZhUXpjMWJrcEVYUmlyVzZJU3pBbzJia3ZvWGFz?=
 =?utf-8?B?bE5DRzB4QzF1WFFLU0llc0I0dS9rM1J4d0sySFhkVkFjcjlwSzBmZjRJQTFs?=
 =?utf-8?B?NkZXVlJWZzNjdk1EMk9YSGZHMUZSSTBiLzZtYnduZDI4dmo1eTl0OStaOEV0?=
 =?utf-8?B?djlqckVzQ2JCQWVyOTBPYUhWSGEzYnMzUlRzV3VYdlkyaUM2ZWNoVWxnVUJt?=
 =?utf-8?B?NE43dEV6MjU0Q1E4Y1htR0VKeENIVVY5ZWl2QWx4WUM1TXF6ais2V2tXUlE0?=
 =?utf-8?B?dVZDQkNkQ1FQZFVCOWFDK1NIYklzdVI3Skk2U3pqTTN1UkQ4WnowU2JBV1lW?=
 =?utf-8?B?M0hEWWhud2t0bTNrQmQvWDFZUlNicEsvMUdQMkFzNnJUcnYzUVF5aDdRN0hS?=
 =?utf-8?B?Tkp6cWJ4eXRSOUpsYzYycVNVTDZsWFBsYTAxdzR1cis2SFA4NWhsZlFMc1Jt?=
 =?utf-8?B?Rm1NRUdCNCtLVGpzSnp0UFhqWGdzaC9KYklCcTNhWjVXem15TkR0LytRM3dV?=
 =?utf-8?B?RDhmOVBlc2ZWUlpTdFl0RkdUbUh1bU5iVWhHMmhCbUpYRjhmaTN2SWh4V0cx?=
 =?utf-8?B?VXNQdkRPb29EKzhvWnBpT2FoMjlHeVV2TmdUTmx0OHloLzFyMTR3VkRNaDhp?=
 =?utf-8?B?U3Q5NFpkbGpJaExZaUlMKzVyQms5THlub3RKMWhOY2h6NURlYW0wd1Z3dEt0?=
 =?utf-8?B?NldpRXk4dkUwaENzMkFRMjA0RExDR1JaUkFyMnd5cm1oeDZKVHpRaVhNRkxl?=
 =?utf-8?B?MHUweTlIVzlrbW45VWhsNWJYQVd3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21104279-7627-46f9-0736-08ddfc2727d5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:06.1450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv+wdQjK7mN0N+Unp4/9AXhq1HF50MEki+ztvLGAQRNLqhwRRksuK90FVbgYnEFtE2tzFPviX8XQ8yh480rwJuU+V0crLhO/b7q+5oKEtmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX7eqBl9ndlQkN
 WtllEGUQFzBT7UdFRDStA3beOblIUP4Y/IZcp0sNTyapz4IXrhTO63Y8qmBRmdhKMFm6lfd1DI1
 SRyo53+REhDn5UZj3wVODKOJkripBWYFueMubfvsuwG1cjRdCkoC+qxujz3bwejZC0wAlh6wnza
 315gDrrukGCZb0TaivEcCp8jnUVQwszn+iipoM3jPdFAywx6C0j4aIN/tCL7BAjWvVdmB11EMlh
 Zen86RpcazzOQA3pb7nFdtoIq9063ExpvL2SNTtDoHfEHRtBOyk4rS/kClYjUJEavOFR/zrEkRU
 3mcPVPp9FwRkmFnHva9YHCmY8w+bGX2foWlrByLb1CyBb0PKtI+hK8/sZrukEk=
X-Proofpoint-GUID: 4MxQb2Dn4cH2BOMCARywqgWAAwRdholR
X-Proofpoint-ORIG-GUID: 4MxQb2Dn4cH2BOMCARywqgWAAwRdholR
X-Authority-Analysis: v=2.4 cv=XvH6OUF9 c=1 sm=1 tr=0 ts=68d52837 cx=c_pps
 a=+aoWgcdf8QL7nCWWbKbTBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=BhsJi16HVY8kLVvTjTYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The VFIOContainer struct represents the legacy VFIO container even though the
name suggests it may be the common superclass of all VFIO containers. Rename it
to VFIOLegacyContainer to make this clearer, which is also a better match for
its VFIO_IOMMU_LEGACY QOM type name.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h |  8 +++---
 include/hw/vfio/vfio-cpr.h       |  9 ++++---
 hw/ppc/spapr_pci_vfio.c          | 10 ++++----
 hw/vfio/container.c              | 42 +++++++++++++++++---------------
 hw/vfio/cpr-legacy.c             | 27 +++++++++++---------
 hw/vfio/spapr.c                  | 18 +++++++-------
 6 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 240f566993..712a691400 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -12,20 +12,20 @@
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-cpr.h"
 
-typedef struct VFIOContainer VFIOContainer;
+typedef struct VFIOLegacyContainer VFIOLegacyContainer;
 typedef struct VFIODevice VFIODevice;
 
 typedef struct VFIOGroup {
     int fd;
     int groupid;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
     QLIST_ENTRY(VFIOGroup) container_next;
     bool ram_block_discard_allowed;
 } VFIOGroup;
 
-struct VFIOContainer {
+struct VFIOLegacyContainer {
     VFIOContainerBase parent_obj;
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -34,6 +34,6 @@ struct VFIOContainer {
     VFIOContainerCPR cpr;
 };
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOLegacyContainer, VFIO_IOMMU_LEGACY);
 
 #endif /* HW_VFIO_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d37daffbc5..04e9872587 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -12,7 +12,7 @@
 #include "migration/misc.h"
 #include "system/memory.h"
 
-struct VFIOContainer;
+struct VFIOLegacyContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 struct VFIODevice;
@@ -42,9 +42,10 @@ typedef struct VFIOPCICPR {
     NotifierWithReturn transfer_notifier;
 } VFIOPCICPR;
 
-bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
+bool vfio_legacy_cpr_register_container(struct VFIOLegacyContainer *container,
                                         Error **errp);
-void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
+void vfio_legacy_cpr_unregister_container(
+    struct VFIOLegacyContainer *container);
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -61,7 +62,7 @@ void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
-bool vfio_cpr_container_match(struct VFIOContainer *container,
+bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
                               struct VFIOGroup *group, int fd);
 
 void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 7e1c71ef59..faa3ab3fe1 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -32,7 +32,7 @@
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
 #ifdef CONFIG_VFIO_PCI
-static bool vfio_eeh_container_ok(VFIOContainer *container)
+static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
 {
     /*
      * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
@@ -60,7 +60,7 @@ static bool vfio_eeh_container_ok(VFIOContainer *container)
     return true;
 }
 
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
 {
     struct vfio_eeh_pe_op pe_op = {
         .argsz = sizeof(pe_op),
@@ -83,7 +83,7 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
     return ret;
 }
 
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
 {
     VFIOAddressSpace *space = vfio_address_space_get(as);
     VFIOContainerBase *bcontainer = NULL;
@@ -111,14 +111,14 @@ out:
 
 static bool vfio_eeh_as_ok(AddressSpace *as)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     return (container != NULL) && vfio_eeh_container_ok(container);
 }
 
 static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
 {
-    VFIOContainer *container = vfio_eeh_as_container(as);
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
 
     if (!container) {
         return -ENODEV;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 030c6d3f89..bdf415b3d6 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -44,7 +44,8 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 static VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 
-static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
+static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
+                                          bool state)
 {
     switch (container->iommu_type) {
     case VFIO_TYPE1v2_IOMMU:
@@ -67,7 +68,7 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
-static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
+static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
@@ -124,7 +125,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -212,7 +213,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -244,7 +245,7 @@ static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
                                     bool start, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -269,7 +270,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -413,12 +414,12 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
     return true;
 }
 
-static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
+static VFIOLegacyContainer *vfio_create_container(int fd, VFIOGroup *group,
                                             Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
 
     iommu_type = vfio_get_iommu_type(fd, errp);
     if (iommu_type < 0) {
@@ -442,7 +443,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
     return container;
 }
 
-static int vfio_get_iommu_info(VFIOContainer *container,
+static int vfio_get_iommu_info(VFIOLegacyContainer *container,
                                struct vfio_iommu_type1_info **info)
 {
 
@@ -486,7 +487,7 @@ vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
     return NULL;
 }
 
-static void vfio_get_iommu_info_migration(VFIOContainer *container,
+static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
                                           struct vfio_iommu_type1_info *info)
 {
     struct vfio_info_cap_header *hdr;
@@ -514,7 +515,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 
 static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
     int ret;
 
@@ -540,8 +541,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static bool vfio_container_attach_discard_disable(VFIOContainer *container,
-                                            VFIOGroup *group, Error **errp)
+static bool vfio_container_attach_discard_disable(
+    VFIOLegacyContainer *container, VFIOGroup *group, Error **errp)
 {
     int ret;
 
@@ -587,8 +588,8 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
-static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
-                                     Error **errp)
+static bool vfio_container_group_add(VFIOLegacyContainer *container,
+                                     VFIOGroup *group, Error **errp)
 {
     if (!vfio_container_attach_discard_disable(container, group, errp)) {
         return false;
@@ -604,7 +605,8 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     return true;
 }
 
-static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+static void vfio_container_group_del(VFIOLegacyContainer *container,
+                                     VFIOGroup *group)
 {
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -616,7 +618,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
-    VFIOContainer *container;
+    VFIOLegacyContainer *container;
     VFIOContainerBase *bcontainer;
     int ret, fd = -1;
     VFIOAddressSpace *space;
@@ -729,7 +731,7 @@ fail:
 
 static void vfio_container_disconnect(VFIOGroup *group)
 {
-    VFIOContainer *container = group->container;
+    VFIOLegacyContainer *container = group->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
@@ -1243,7 +1245,7 @@ hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
 
 static void vfio_iommu_legacy_instance_init(Object *obj)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(obj);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(obj);
 
     QLIST_INIT(&container->group_list);
 }
@@ -1263,7 +1265,7 @@ static const TypeInfo types[] = {
         .name = TYPE_VFIO_IOMMU_LEGACY,
         .parent = TYPE_VFIO_IOMMU,
         .instance_init = vfio_iommu_legacy_instance_init,
-        .instance_size = sizeof(VFIOContainer),
+        .instance_size = sizeof(VFIOLegacyContainer),
         .class_init = vfio_iommu_legacy_class_init,
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 8f437194fa..12bf920a7d 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -17,7 +17,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
-static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
+                                     Error **errp)
 {
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
@@ -41,7 +42,7 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
                                    hwaddr iova, ram_addr_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
-    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
 
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
@@ -63,12 +64,13 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
 static void vfio_region_remap(MemoryListener *listener,
                               MemoryRegionSection *section)
 {
-    VFIOContainer *container = container_of(listener, VFIOContainer,
-                                            cpr.remap_listener);
+    VFIOLegacyContainer *container = container_of(listener,
+                                                  VFIOLegacyContainer,
+                                                  cpr.remap_listener);
     vfio_container_region_add(VFIO_IOMMU(container), section, true);
 }
 
-static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
+static bool vfio_cpr_supported(VFIOLegacyContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
         error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
@@ -85,7 +87,7 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 
 static int vfio_container_pre_save(void *opaque)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     Error *local_err = NULL;
 
     if (!vfio_dma_unmap_vaddr_all(container, &local_err)) {
@@ -97,7 +99,7 @@ static int vfio_container_pre_save(void *opaque)
 
 static int vfio_container_post_load(void *opaque, int version_id)
 {
-    VFIOContainer *container = opaque;
+    VFIOLegacyContainer *container = opaque;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     dma_map_fn saved_dma_map = vioc->dma_map;
@@ -133,8 +135,8 @@ static const VMStateDescription vfio_container_vmstate = {
 static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                   MigrationEvent *e, Error **errp)
 {
-    VFIOContainer *container =
-        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOLegacyContainer *container =
+        container_of(notifier, VFIOLegacyContainer, cpr.transfer_notifier);
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     if (e->type != MIG_EVENT_PRECOPY_FAILED) {
@@ -165,7 +167,8 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
+bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
+                                        Error **errp)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
@@ -189,7 +192,7 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
     return true;
 }
 
-void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
+void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 {
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
@@ -263,7 +266,7 @@ static bool same_device(int fd1, int fd2)
     return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
 }
 
-bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
                               int fd)
 {
     if (container->fd == fd) {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c41e4588d6..b8bade90d7 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -31,7 +31,7 @@ typedef struct VFIOHostDMAWindow {
 } VFIOHostDMAWindow;
 
 typedef struct VFIOSpaprContainer {
-    VFIOContainer container;
+    VFIOLegacyContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     unsigned int levels;
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = &scontainer->container;
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -218,7 +218,7 @@ static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
     return hostwin_found ? hostwin : NULL;
 }
 
-static int vfio_spapr_remove_window(VFIOContainer *container,
+static int vfio_spapr_remove_window(VFIOLegacyContainer *container,
                                     hwaddr offset_within_address_space)
 {
     struct vfio_iommu_spapr_tce_remove remove = {
@@ -239,7 +239,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
     return 0;
 }
 
-static bool vfio_spapr_create_window(VFIOContainer *container,
+static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
                                     MemoryRegionSection *section,
                                     hwaddr *pgsize, Error **errp)
 {
@@ -352,7 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin;
@@ -442,7 +442,7 @@ static void
 vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
 
@@ -463,7 +463,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
 static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     VFIOHostDMAWindow *hostwin, *next;
@@ -481,7 +481,7 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
 static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                                        Error **errp)
 {
-    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
                                                   container);
     struct vfio_iommu_spapr_tce_info info;
-- 
2.43.0


