Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FEBD43374
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 16:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t94yc-0008CA-11; Thu, 07 Nov 2024 11:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t94yX-0008Bj-PY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:03:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t94yT-0007Tm-02
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 11:03:11 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DKCjo019968;
 Thu, 7 Nov 2024 16:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=XOYBfzbd3mFSOrBgzFpNk0fWygtxYvy0+jRuaVYDll0=; b=
 eiCnrmhPKEAAq41WrFf/uj6uMTkC5D2h56B6xD1Pe/qtQ+tRTRCdOkyp5XV586RF
 h0t1VgFXddCtoIRJazEb4/AKIEq0T3scFQYgTnmqlGuSWiidGpTBpej1/XRIU6D2
 lZ0aTh6AOY/o8LzfOwlKv03Mm3urwMjQQfXdZMgSJCVv+gf3THMT66bi9qJkZM5R
 WZpXJu1cu8SJO6zDD4f8mReqeH414wrzo4Ugpu2IJITPw70EAMF4PEHnGI+7pzYf
 QVwFA+hqUBNLSAPynqeDX9pj59cLLEw7/YeLnzpMbrAsAmn1ftfzcK6YvKrVJ0xR
 cWC2BfxQWqXYG6RsdgVu5g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmtav5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 16:03:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A7Ehf64031416; Thu, 7 Nov 2024 16:03:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42nah9x6pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Nov 2024 16:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2+hePcH1btfaDvwT7ruCAWNtgSEb2jICM0VhMBGrso7uKj18FssdDOGDyWrmySfe1YWdWrY6/AEBW8Jr5v9t4myIHUgSa/tnNyH4SDTObux/yhaP+yLQIY1UDpHH9JY6r1AgF3pKhT7R330DhfnxO72eWlZOrTiJrz7p8GXpvBtRHJ051p5PfaUSlnEoqmeMBeDH4azmuYDk5Gx8ptfahdjr8gW8szxlSVolt9okWJ5hC43o9PZloTtDSINMthpEf9NgQh8T7CQHpi1J3Dw9kNfkITIpagRrIuFOeg9UItw9R/PGfuKugt0lZzO2hmIVnUJC46WRuCf/OStRvVJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOYBfzbd3mFSOrBgzFpNk0fWygtxYvy0+jRuaVYDll0=;
 b=UG4Xi+49qJ3Y6e1ZOb2BAF6KCreZsZC6oFdQ8DRWll4TUV4BoLFJIobnCPU7VWVCNZKQF9gGvnAeM1bxN2uxCI00Ac+GaOa9BN88HOrEuaFkjWo0Ef6/hJi9i8Zm1e0Z4DTh0w0Y+DhOJC7Xjhx4iXVba1s9Bu/sMexLNL6LM47KxvPoPhLHwH7aHFCbP1LYaI10FqjFazXJumEVQHPxdK7HKyCYUfuKri0c8AKHEEQWLwQbTHRCZn6BmWHAChfQoZhK4BdRHTFkNsyFNjdZx+H0twfJjcDkGix2AdxBvoAKpkoJ9BUfZrr1+E00K9cYO1y3mg1CUFM1h9RtXyl16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOYBfzbd3mFSOrBgzFpNk0fWygtxYvy0+jRuaVYDll0=;
 b=r1hLuRRVB0oE2H+XKuoP7sVMpbDslHjELtb5MNNS5NGygT/egZ2lHsxZYW6A9Rj8nljakIPvY0BqkN2GG+DuzOgxXf57RMpJppM+X19gPHiKdO3NjgMJe0JDCPHYFyGYJzkqwV0wKBCY18gNZQxYsRsUkhQsqlmCTVbejRPRfX8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 16:02:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:02:59 +0000
Message-ID: <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
Date: Thu, 7 Nov 2024 11:02:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0600.namprd03.prod.outlook.com
 (2603:10b6:408:10d::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1213fcff-5b9d-43c4-0330-08dcff45a67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDZGYzJYRndTc1VUa3YrVlZRTEZYVEorOEpTcC9TUkt5YXJscTNFVXFJZlBz?=
 =?utf-8?B?djA5WldLOWpNRjNKdDN1ZkVrSTd1TlJFMHlUZEQ5SUNnVmhoTmlFQzFvU2xB?=
 =?utf-8?B?N0prNm5vajk5MUFwWXZCUE5xK0J3WWdmUmRCS0svdm8rY0VkWHVGQU1iRzN5?=
 =?utf-8?B?WFVISUF0anRwZVNmMEw1RFp0VTlNZnVVWlIwRGU3NlpVaWVFVTl5RjZnSWJW?=
 =?utf-8?B?dnpNOU5JZnJVaGJSOVZzMHhCL3NyQnBuVVhKRVpTUGFOZStNNktSK082RHY3?=
 =?utf-8?B?ZnlUckVIQk5ybEc2WE1rUjR5WWN0YlQ2eEhqckJxckkveDM5VHE2YmJFQ3d5?=
 =?utf-8?B?T005N1dIUWJUeDhDT256eGVjRTRnYkZPK1A4Wmg3ZUNXNk04bFI2cWl4Z2Vu?=
 =?utf-8?B?Z0REMk5VRGxpWXdISWQxOFFydGNnSFM3ZFFDS0FjT0l3T3lQYjFHcFQxWTYv?=
 =?utf-8?B?aHJMLy82NUk2UFNPS1pDY2hDWlJTMnZ1ZW1wVGhvQ0ovNHo5TmNwRDdGK1pm?=
 =?utf-8?B?dkFRQmFxTDJZRE5OUXVORWIxUFVDYUU3MzlZL081UndYbzc1WVZCdmJYbi9X?=
 =?utf-8?B?RC9iYVArSW9UL0dBTjZxVzZ6LzBBaU4vd0xsd3hRN1NFZE9NV2VsNlE2ZEIr?=
 =?utf-8?B?eE93V0dKYUdXdGlTaXRuRFJwUW9kNnI5YUIzVmtKUmlMYzFLek00cjlkNmox?=
 =?utf-8?B?NGFnK1l2aWdSdWhWZ2N1dkRDOGN3YlRKY1RhVWdPUi9MRmFiczRlcDloZ1Nn?=
 =?utf-8?B?Umw2dUNTUFRmRVliRmpjd0djWE9lclIxUERVK0NsWmttSUptd3MrNFRjVzlm?=
 =?utf-8?B?RUtic1RONkcxTTJ5RVdEUzJrejhlYnU1ZnhaTVg5c2NPY2hTWEpXNFNsNC9N?=
 =?utf-8?B?cXV1VXhMd1BxTUpDem9BYlZ6U0lFcDdTMXE2R0NCYXZzcElDV2x1Zmtxbkdm?=
 =?utf-8?B?bzZaaThrMkVBRFF2UVhwelc3OWNaVjQxdmRUY0ZhUWEybzVXdkxuM2FtNlB1?=
 =?utf-8?B?NnNtK0pXaGs2bnNRUXBhSG1RaFB0Y1l6aER1d2pWR0QzaW9WNy96THVkK1ZD?=
 =?utf-8?B?WnJ0U2FjdlVJL0M0VHhLRy9SYWRnQzUrdERZYmhpNDU3VnFZMkx2SDhZKzd5?=
 =?utf-8?B?Y2xLRVlMOWFLaUNLS1RpL3hMT2FsOElFYUR0bitpakYxTmRhdkR6L2FGd2ZS?=
 =?utf-8?B?Z1QzMzZhT2ppUGVxUVFnQSsrZzh5em55WHNzSXhERFZSVU9PTVFZTWhEUW0r?=
 =?utf-8?B?Y28vY2FReENua1htYnIyS1dTTUNuQVE3QXdWQ3Y3M240M3lJZkRXQUFxamt0?=
 =?utf-8?B?THVGK2QzNXo3V2VIT3ZXZ0toWGxsNUY2R0cyU1B2ZFZvMTVLU0FBYWVjdlpv?=
 =?utf-8?B?V2hZRlVuUndoSlRTbVluWHV6UW9WcjBYT2N4N1dvcDhUQm9TY3loNmZkSjFY?=
 =?utf-8?B?WC9JME85dng5L0x4L0wxUkMvckNDYVd4WWt1cUlMZ3lOZWxweFY0clBrODJu?=
 =?utf-8?B?NUtxbk5lbml4a1pxOXJDWVcvRXdWQ3ZDUDZBMEFrWVpKblJJMWQxRjRFUnpi?=
 =?utf-8?B?QTBGNm1PelNrQ2dWV3UwMVdxRkd4UWI0SVlZYjdaNlRLbUhKMHR3S0JQSk85?=
 =?utf-8?B?Ujd5Zmh2WGVrcWErMVVyd09pY1I5QVNMcFJuV0dLZU9PaE9McmxqZzFlbFVS?=
 =?utf-8?B?blVXT3JYYkYzZnVWVXpqaE1pZEM1OGZDekFPQVRtUjUwemtqRnNLUlhoc1FQ?=
 =?utf-8?Q?hiyViNVqLxSj7O8SIbNt5f8WnOhBq822btpciA2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFIejY5WGVWNDE4MkhSdXQzTStDc1dHbHg3czB3OExteE1Kd085WGg2NlR2?=
 =?utf-8?B?M1dSVFV1L1d0UEl1M25DekdxS2tId1EwQ0lDcjU2Y2IxWnpqQlFGOWdTMVpr?=
 =?utf-8?B?L1d1dk9ZYUo4T2QxNkhCODB0TmRLSTRNOW10cS84d2tQNjJ5ZHJJREdCRCsr?=
 =?utf-8?B?QmNOVXBSdW1vbmgyeGJTUWVabmtKS0JCcHdjU3N1azVLVXZlTy91YnNuSnpM?=
 =?utf-8?B?RzlXdFkrYk1qRzBZNGI3aldmeHMzdXdheW1Ja2NEMldoNlEyelVXejNzNnQ4?=
 =?utf-8?B?RDZxT1ZDd1RFS1preVRvNDFwY2tZdGxWRysxNW4wSUlEcnc3N21lSEdHMXF2?=
 =?utf-8?B?bVRyam91TUNyOG9jYVNGWE9ZamhNMTdpa2NaSmZvMkd6enZyUFpLTFZWVEhL?=
 =?utf-8?B?ZENqUGhFNVBxc2ZOOUc2T0dkUVFYcGZkT1VqQlo3d1RWMGhzZWR3M1FYRnZV?=
 =?utf-8?B?UmtRdk1hS2JlQit3LzdmOFp1T2ZkOWJYTHp3U1MxS3RLYVRQZlVUaWE5VlRw?=
 =?utf-8?B?SGxoRVRsMTNEekkzYzdjWW5oUy9nRFJBeDVZQVo1UVg2UDZiTlpnUnZuYmd3?=
 =?utf-8?B?MjlhbVNUMjNvM28rMTFOclFzcmY2azhJKzVranU0TFVleVlVbktNSDJHNnJ6?=
 =?utf-8?B?bjh4WStlQkVSd2Y1MFVtOVlpaWlLellZazAzdzlwRUxKSWQzK25IdTA3M2V3?=
 =?utf-8?B?TGg2T2FBa216TnNjOUFGSHF6b0NLL2VNU3YrOExCVUhpWHBrQXg5YUZYOXVx?=
 =?utf-8?B?K0hNVHdLOUE1S1ZqeDVGZnBSdFdwU1htTGRQSmVPUkFZSzl4alJ5Y1FtM3Ex?=
 =?utf-8?B?Y3lwNjRBc2pRd2cxZ1A2aVhOVEFLZWJRcVBST05hZnhzNERUTU1UTi9yS29V?=
 =?utf-8?B?Z1lDendYeXFVVlFYSGNTNVBFb2hUWGxjSzNTWUVSUE9Ba2N1ZFVudTVmbVRY?=
 =?utf-8?B?REtyZXY4S1JJSkswblpSek5oNnBOOEwzbzFSS0Y0NXVWdlhWc3FMNnFHUGph?=
 =?utf-8?B?SHNYRXRZRFM1YjlNUTYzc3AyNEhjbnIyM2Q2dnEwelczQ3M0VHZxdkdJdTMw?=
 =?utf-8?B?ZlorMktoK3NGREFJc0E2UnU3cmdUbXNmRGRGK2RNdFg3SzNKblRvc3hNZHV3?=
 =?utf-8?B?blR3akJHaVdHaTVLSGhGTlg0ZEx1ZnlkY0lXcldPSVJ4b1UyUE5mUUFRVXJp?=
 =?utf-8?B?cTdZaGZGRzVkYzA4NHpPSnQ3c0Z2Zks2VDZBMXU4RjVLOVN4YWFKMmhxNlB1?=
 =?utf-8?B?dzNOa0VzQzA2dGllOXk2eG03cHZ3cGxBS0UrbW9GdjZlN2dnSzh3WU03WTNx?=
 =?utf-8?B?OE1BMjRqeDFJZklwVGZOQzVIQVZXV04zUWNER3pRUmJBaHpoMWJMVWk5VHkw?=
 =?utf-8?B?V1d6Zi9MZ3dzRzhnTWpTY1FlVFA0TnQ4WHhpUzZYcmZWU2E3S3ZWZXpwazVx?=
 =?utf-8?B?clZGNlhxTVI1bnJSbUlMcnk0Nk5DTFhyaldxNG9tMEVwYzRrbklkaDBlTHV1?=
 =?utf-8?B?MjRxYkg5cUxjaHBlRDJFb1cvaHdDK2YrQ0kxTzhZaGpHeWdWenpqMVcvMFVE?=
 =?utf-8?B?YzQ1SGQwYVlHdVVYUHJvcFpzK01FdVdPTUp6RFRaY2F2ZkZUS2ZqRkFEZEJK?=
 =?utf-8?B?VWxraWtlNWM5VnR0RnFMN3ZaSnAyTzZFeVFQQU5TTUszVHJnbjRnZ0F4TmJt?=
 =?utf-8?B?MnZvN3VMMlI2d0tRRU9QLy9WTjdreVo2QVFqZ201cXF5V3Z1Q1RHMDFXVGdh?=
 =?utf-8?B?RHpsWlJGSGcrZmF5NjhSUk5rWG9xNnRyd0MvZzVZSnhOUStCd016U3pQRmhx?=
 =?utf-8?B?UmFBemNpZkQ5dytJdUhvSzRSQkRDV2VoekVrT0toOU1KdENOdkVLZ3RSVE1X?=
 =?utf-8?B?NnJuVXpHSjdDL3IzOGtLQlcveDlYaDNVd1BHaVlkYnVkY3ZWQ2dXaTZwNkgy?=
 =?utf-8?B?U3VFL3ZjWG42dWZ6aWVvRHpGT2VRWVVYWmZCSnIzVVFKanFieHdUWUlCM0l1?=
 =?utf-8?B?TGJWMjF5YnJseWFGS1VUWDVzYXAvamU1SjVoNWNGVHc0bFRMam9EbHN0eHd4?=
 =?utf-8?B?dkJpWHlxSzBySU5vVGFRMmlCYWFuSHdzNnVzdWJ6eHQvQVp0cVB3dStzVGNZ?=
 =?utf-8?B?ajhqcTByK29lMDBRWmhLOWpWTC95c1hwSXVWUUQrc3pSSTZ3UVltVE05dnlv?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VZ+CkGQBdBB4qXlkQqOgL45f6lapN8TI2BDTPOvKio8f/B/jGKCRRWdplNUuJKHDjjGUBVmQewiXLg1emdYO9Byw8vb7mT2MLCnNzavDzCm4NCcU/r0SLiI2CPKgZ0xsfj9WiOqUq4I/kNXToqjfd8m/rONgcc9ty6qX64p/iZtG6oXABX6wLsivtF5sr3gVCmjI1LnAc2ZEO3Su5JqdZLcOPc7n8qCuDJbku4g6Q5u0S4zOgs6RaGtkJyiztxjUO1YNQ8dwx2tga2eNZOH37Rxq9oA8z4K78YdwJPn6fpp8dm9O9UgpSTG7KcJcSzRCTNm5ON1zojA9ZQLy0ZawKHgOwGlddWktUE1k6MKnwRUv6bKXN+5qDEeMSMFaXKllXRDZjuaT2QYwB2jeMPwP4vqA9a1ED5mvURTejxfDFablettHvb7LryURLq7vaG6EGhEjaPWTZzDRX6gz55vEhfdhUuVrcNuWVV72H5yVF5HaFtrbPNJPsja5Dicd/5THaboutPabr7Gi9ng5eCWRlanre9s5d4BGOfvfyb9+/CV24ykWipQaLjO3e9ZZZPuioxMViTtMcbCv5zZGEF68UVGLKhmla6U6MuyTY4npRp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1213fcff-5b9d-43c4-0330-08dcff45a67d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:02:59.2321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6X70BnZ6CAgLc7sTGQyKSMThRVikPboxzGjiza7CbPqXeBd4o867OgKrfHdtBjjuFpTKv/irqjmUXs9HyCaUZ/qAgYbx9TWcwmtwGKiIZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_06,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070124
X-Proofpoint-GUID: m1rSK0lCvMHuhma7a7izPgE9RmUKFGI6
X-Proofpoint-ORIG-GUID: m1rSK0lCvMHuhma7a7izPgE9RmUKFGI6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/7/2024 8:23 AM, David Hildenbrand wrote:
> On 06.11.24 21:12, Steven Sistare wrote:
>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>
>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>
>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>
>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>> details. See below.
>>>>>>>
>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>
>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>
>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>> on the "machine toggle" as part of this series.
>>>>>>
>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>
>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>
>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>
>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>
>>> Yes.
>>>
>>>>
>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>> if memory-backend-ram has hogged all the memory.
>>>>
>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>
>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>> -- memfd if available and fallback to shm_open.
>>>
>>> Yes.
>>>
>>>>
>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>
>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>
>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>
>>>>> Thoughts?
>>>>
>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>> of options and words to describe them.
>>>
>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>
>> Hi David and Peter,
>>
>> I have implemented and tested the following, for both qemu_memfd_create
>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>> for simplicity.
>>
>> Any comments before I submit a complete patch?
>>
>> ----
>> qemu-options.hx:
>>       ``aux-ram-share=on|off``
>>           Allocate auxiliary guest RAM as an anonymous file that is
>>           shareable with an external process.  This option applies to
>>           memory allocated as a side effect of creating various devices.
>>           It does not apply to memory-backend-objects, whether explicitly
>>           specified on the command line, or implicitly created by the -m
>>           command line option.
>>
>>           Some migration modes require aux-ram-share=on.
>>
>> qapi/migration.json:
>>       @cpr-transfer:
>>            ...
>>            Memory-backend objects must have the share=on attribute, but
>>            memory-backend-epc is not supported.  The VM must be started
>>            with the '-machine aux-ram-share=on' option.
>>
>> Define RAM_PRIVATE
>>
>> Define qemu_shm_alloc(), from David's tmp patch
>>
>> ram_backend_memory_alloc()
>>       ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>       memory_region_init_ram_flags_nomigrate(ram_flags)
>>
>> qemu_ram_alloc_internal()
>>       ...
>>       if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>           new_block->flags |= RAM_SHARED;
>>
>>       if (!host && (new_block->flags & RAM_SHARED)) {
>>           qemu_ram_alloc_shared(new_block);
>>       } else
>>           new_block->fd = -1;
>>           new_block->host = host;
>>       }
>>       ram_block_add(new_block);
>>
>> qemu_ram_alloc_shared()
>>       if qemu_memfd_check()
>>           new_block->fd = qemu_memfd_create()
>>       else
>>           new_block->fd = qemu_shm_alloc()
> 
> Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
> 
> memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
> 
> MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
> 
> So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
> 
> 
> We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
> 
> So maybe something like
> 
> qemu_ram_alloc_shared()
>      fd = -1;
> 
>      if (qemu_memfd_avilable()) {
>          fd = qemu_memfd_create();
>          if (fd < 0)
>              ... error
>      } else if (qemu_shm_available())
>          fd = qemu_shm_alloc();
>          if (fd < 0)
>              ... error
>      } else {
>          /*
>           * Old behavior: try fd-less shared memory. We might
>           * just end up with non-shared memory on Windows, but
>           * nobody can make sure of this shared memory either way
>           * ... should we just use non-shared memory? Or should
>           * we simply bail out? But then, if there is no shared
>           * memory nobody could possible use it.
>           */
>          qemu_anon_ram_alloc(share=true)
>      }

Good catch.  We need that fallback for backwards compatibility.  Even with
no use case for memory-backend-ram,share=on since the demise of rdma, users
may specify it on windows, for no particular reason, but it works, and should
continue to work after this series.  CPR would be blocked.

More generally for backwards compatibility for share=on for no particular reason,
should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
options and more than half of ram is requested, it will fail, whereas current qemu
succeeds using MAP_SHARED|MAP_ANON.

- Steve




