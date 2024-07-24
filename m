Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C9C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbH2-0007F4-H5; Wed, 24 Jul 2024 08:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWbH1-0007Ds-07
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:39:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sWbGx-0006P2-Gw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:39:13 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O0x2tx030558;
 Wed, 24 Jul 2024 05:39:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wJA998esEaijhE7a+pn7D7HmqVwGuUzrgLvp+yRKO
 7Q=; b=TBwX4IXwUvu9JOdD9EOOzMTeSuxDVHmpWqOUVh4nAOfWFiuHbuQmzNvxr
 mQBOUAEzS1NFpyGjZ+t3ZpYuf0vLeP9mVrTbeqa+JEOMDJW8IkCWB64M107h/K9g
 XWvMX+267PacMCbJtGnw/2KQ2waoq1iSlsbhbhDdCEF0peRhDVMJCz4gQLUfUvwJ
 HSgD6CsEfTzwh1NNWyFIWTNWVbz3xzkqo16TntG99Axo/jinhgpXQoOWxCjSfhmy
 uDPTtbhr1gTem8XZypqCwIzs/eEGUQkjeWuztCz8pV1DCEWH0CGiQ73muU6LtcpC
 DHkYakXJ6lmX0JTgeS8mv8LEkSdKA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40gcsv860p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 05:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqgsehAGCHzgQDO85ywhYgH+J8dcIeM9eU5G51oLmYcSd4MtRiJCMy70OvYoSsJmvHDWgQ/vWlAoXpda6rNpnVpJoCRHTzHcGj+Yntbteug/Xjce98/1AnK+l6hRs6yZfZyzkouaHqF0nzykLH05a2t+H3fo5snRg8WdNTDdxeFbJAeXuisAkAe5n9om9T42z4KWitmBAwQ/Cz2xI1jiZDPb4hS8zIEApYRTL3qGZeBID+yyPZcZY23QN2QUKX0dtQqhi+7ODDHxStAblhhElejOzNtRtsgk4hjTw9CdPyaIwR5/rzae4xZYeZdOmo+uRu2L87Ycpo8VZtELV/2tIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJA998esEaijhE7a+pn7D7HmqVwGuUzrgLvp+yRKO7Q=;
 b=N/tzh0V2+j7dOe/b8Zvpvr2tMhFGfr057izlD1TLqzziil50/bkJvoP/m8rANytWmp84KpX62V/nx0t4z8Eh9FxvKROqNaTrJqmEvvLCsJDX+En3ITf9qBTZPdCr0HomCKvVqa/DTwN7YQ6KSffM1GPAJyy+8M9sZTvRgexMUdvodDpuPR8wko6XTSWUb0P3wmOBvudqwkXpXitt4Hv3iMUWdfFTGsIzgHAkDbQFqHsbxDAAPgWaDv29KWQGR+CgSkYP2bBASopOJ5qayEc2PShTFOZpZthPlyYVUl6TyNEGzSyOTvwFZT1hcgedhV9drr10OVq90bKp7cPXkgTM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJA998esEaijhE7a+pn7D7HmqVwGuUzrgLvp+yRKO7Q=;
 b=MARvPKpY2pirhkSHpNT9CgTjv/TMhdf8daxb4oQfkVCrYgUDNj+UYGn27dp/a9hfxbuYUOakK4y6N5zvLS9x/P81nWxbZcJLmLSumegZg9AQ2j37XKiwMLXWSzv76BXz5bfWce2L4u+ir+JzqGwD0zRSDTTFCpznrU7SERDq1wR+I0/LiSZ92Z3/Ecnpm30J2lr4069ERx0B4cG6HMz8vx+Yfqewkpyd0kZ2e6uY/wLJ/QIn5R0Q9fkioevFk8GhDnwNoSxEc3tD9kvwCmeZSPRyjOb9b+IBW/O80JCRRtStpRHNtXZBBfzVOuFi1N9lnj5y8piXeANNnzZGodVuMw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by CY5PR02MB8966.namprd02.prod.outlook.com (2603:10b6:930:39::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 12:39:04 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 12:39:03 +0000
Message-ID: <fa1c53b3-963d-4093-83d9-566d16c1beaf@nutanix.com>
Date: Wed, 24 Jul 2024 18:08:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: John Levon <john.levon@nutanix.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com> <ZqDh2NIE2ELRcwq6@lent>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <ZqDh2NIE2ELRcwq6@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::15) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|CY5PR02MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afc360a-142f-4b42-24e0-08dcabdd99a0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|52116014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bktmclhJTnplWkpzMGxvS2VOQkxRT09NanRQMDlyc1NON1Z5Q3dZenNCLzlJ?=
 =?utf-8?B?Mzc5TlN1Wm51T2pqMUE2R1h5bTZTWjZHWlc5NzNINlh6OW1rOU1GSEJRMzlJ?=
 =?utf-8?B?MVozU0RNNUI4cE9CZmg2WlFIaFUzOGRIVHN4R1hpTUdkYWtUZ2dFRmpXNU9L?=
 =?utf-8?B?SVRjd24rb05yMmFzM3A4MEZPcGlhdkpaOUdHcnlOaTRJbjhtL2x4UWJNMlFs?=
 =?utf-8?B?NzBKeW1ZeUpWQzc2MGVuT2wvcDZvSDBudHFsL213UTRpVkNIZWpVM0FHSW5H?=
 =?utf-8?B?VFdpMUxya0VjbUxHZ3JUbVdTSlIxeUI3Y1ptY2VHUDB5Y0ZUcnltQWRKSGI2?=
 =?utf-8?B?RDByQUh5b1BjNE1uazRLRmlUUWFTTDcraWgvOUMvcFNiSllTaklKUUl5Rm5o?=
 =?utf-8?B?U3VpMVozYWlWRnA3TUErZ3h4R2c2SmJoMlBNYjJOdDJLV0lpY3Z4RHUxY2Zx?=
 =?utf-8?B?WmhsOUc5RjRKbFllSlpnc2VWekZQeWU0d2NxU3lNMW9DQkUzMHJ6YzFDby9T?=
 =?utf-8?B?b2MwMzJ2NEtsZDJXYzQva3hEbGdPckIvN0pzNzhER0pRb0U0cGNwTWRIT2RH?=
 =?utf-8?B?Mkl2enpiQkVXVXBOMnlIMEpnVWFrZG5WL25ERTBYM3JPU2IvQlVZRTNSdnVE?=
 =?utf-8?B?cWs0blRZYlZUSVhRUHIrV3FKVStCZHpLZ3lTNTkyVlFlTmNhMGNuTUVZZTdO?=
 =?utf-8?B?RkI2Z3V0Um4zWEIya05ySkdXN1pHSEdTeGdRV2x5cENUaWxtbXdoMDJRbWdj?=
 =?utf-8?B?SnJlMk1aQmlKWUhJeXYzWjArWFFSRVVrLzZORlU5ZEdUdTEwWmNKdDliYUVj?=
 =?utf-8?B?ZmpZejlKUWJpSjRUdFBGU1JUenl0dkM1RDlxOHRPeTZxb2ErRmNSVzhmbVg2?=
 =?utf-8?B?WkxyOGdSZFQyVTVIclNsTXVudlJqd1ZLUy9EVTBYbm1YVXhZR0R4Z3YyU0kz?=
 =?utf-8?B?a0pvdXBJNzE5ckxVdUhWOHIxRmJIZTZadk1SUGt2aUR6QTJseTB5WWIwTDhW?=
 =?utf-8?B?dUt4UVVrVDR3Y010bFVsZEhRc0dxWFRVdElEVEhDeS9zR0QzQUdjZ1NENkdI?=
 =?utf-8?B?WW81MnowcmE4M1dzM2ozL0xCMSt5dVRTTlFHaWNwRWJVUHQ2NGpkQ2dYakpl?=
 =?utf-8?B?RDhRVU85KzdVZDA4U1R3MUxKVi9TUm9hZnpjZHY2WGVYMFZLcGlSRE1JL0xj?=
 =?utf-8?B?bmx3eEFBN21zMEJUemd0V25EODY3VElRaVg3dTAwMDhJajN2bDhpUjBoMEJ4?=
 =?utf-8?B?NWZVMUNNMjkrUWxydUJ0UE5XeEhYMUJjOHlrdENNR1RYSldtQyt0akZIcnNo?=
 =?utf-8?B?L01mYUdNNitGZ2R4dVNaemswbmlWV3c5UWNaWjYxS2hmWExFMXJwQ3RxWWV4?=
 =?utf-8?B?NzBjTVJBT3Y4Uy9KUEJ1YXE4MStYaGJQL0h1ZnM0N21jdmY2TmxJSmNPdmZU?=
 =?utf-8?B?SGFsZ0ZUR2JQalZzS09PQWRTb2s5T01JcWwxNFFyVTdqZ1RCU0kxWWJxYlo0?=
 =?utf-8?B?VXRBMjZhWGUxanpES3JMeU5uQnBNdE5pYXl4dnpES0NIUDAzYXk2SlFGalhv?=
 =?utf-8?B?YVdmbmNndVV6MkRUUWlVRFVTY1dsQjdrRmQ1MFZoVzBJWnI3aG9LVzZyTWJn?=
 =?utf-8?B?VmZwUnBlUDBZZFJ6dFFSN09QQURhdTh5YmdzNWNxaHBVdDdwaWo5WHZtL0M4?=
 =?utf-8?B?a1lPemNQNlVKVG1pQVJCYjdHdFJOb2Y5MWlmbHVvdTI0VmtQVVJOK3hCd0Ix?=
 =?utf-8?B?b2NJREhYclcxaXhjNnljZXhCcFlib3YzQ0dDcEU4RS81Q0g3a3AvQ2Q4VEdG?=
 =?utf-8?B?YXplNTFOTENrcGhWU3VTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJ6OUZibzNZSDRvUmNzNFlSTVpQVzZKVUIyRUJtQnZRZzlyRmZPSXpOQTJN?=
 =?utf-8?B?YUR4MUFlMjU2a0NXMVFaWXdjeWlEOHdNTXFmWlNDcGpKdW1heHQvS2RlakxE?=
 =?utf-8?B?OVhQd1A4QTJ2b1RyYU84UjUzTHlPUjdIUTFKSGdSOEhBRmEzbnV2WVJwQUtU?=
 =?utf-8?B?TVFFbjFvTTRvcDhTUFd4ay9IelB4YVhiRzIwSGJwZUxkRm5hcHQ4MmdWZUVB?=
 =?utf-8?B?aUNzckNHWHFFQTBkQnd2ejcwY0hTTERIdDJ6MW9hbmJLcE1idVU3Z2sxNXNy?=
 =?utf-8?B?TENoS1ozM25MRW9oaXVnZFEzc3F6T1J5MlVSMk4xclN3UUY2RmQ4M3Evc3ZX?=
 =?utf-8?B?ZVJPNStSRENBSEZLeTJOUUZ2eXJaU2c0S3RDRExkWmw2OGttWkU4TGpZNEV2?=
 =?utf-8?B?UXR0RDkyZTVPSzFvMUpQc0NnQWdXWnljUmdmeThZS2xjanVuRHppU0VwNE9n?=
 =?utf-8?B?L291VlUxZDQzSXdHdkx4eGw0Rm1jaFlIVitVV1JQQnZIbGUrdnFwaEhMVXZI?=
 =?utf-8?B?S1QxQTFUaEtyNzNDN2xvS2VNdDNLZ3FYOFBFbjIyU2lJZ0NIVXJqd3VZcmwv?=
 =?utf-8?B?TUFHVzZ1TEtJMCtVanlPWjh1QXFrbkNXQzRRamNtYjN6aHBVbTRxc1g2Njc1?=
 =?utf-8?B?bHZqdjJCQVRFLzg5cUhIc0JWeVdLSk1kRXhLOUY5MEhaR05yb2QzYzcxcVhp?=
 =?utf-8?B?YVh1RlkyUXgwY2lDUERsQi9lclhOYWJzU1BiOHN1OWZ4cjBhU1g4VVZ4SzFZ?=
 =?utf-8?B?SmpUR04wS2l4T0pIQTB2aG9DenBQcTN4dkUyc0tlTjYrNlNweUc0NzhmeUJU?=
 =?utf-8?B?MXBXamxkaUlpZ2kwWXY3ZEcwNlB6NjVTKzZ0OEpQZkM1dC9Cc2xXR1F0SnpZ?=
 =?utf-8?B?dXk0WFNDUzROMXZzSXBHWjJpMW1kWm42dk0wUkt6a0NlVi9adjc1V3N4Vmpu?=
 =?utf-8?B?QWsvbFFkL1FpdTJZWXREV2kwTFBWWjVSbll2TzdheGJlcXNudlV4aXptM1RH?=
 =?utf-8?B?SGM5ZnMwOUFkL2VmZ0RrZzV3T3g3bG5Wcm14bWFwem04QitSQzduTzd3anBX?=
 =?utf-8?B?VHhod1BBV2dSeUJIUmJRUmVGVHZGOEU2RkFmTVdoQ0JuWFdEa2tkSDE2NzVL?=
 =?utf-8?B?aHhoNW1RVFVxU0ZrYTlJUFdxNENmelJNbWNSSy9rZlZDK3hmYUJYSkJTR05R?=
 =?utf-8?B?RjVEVmJoaTRPR0VwVGxXbW1Rbm5LOFBBR2xGSkJOY1E4WTRUQlZEZklzdHpa?=
 =?utf-8?B?Z0JsQm95ZWhnaVlmTDVtTTFiZGpqWHowN3JRWmp3ejFidjVKdkdYWm84enNM?=
 =?utf-8?B?eThxQU9SMmJ2bjE0WW9NM3lMejRHQ1ByK1hZZlIvSXlIU0JGVWw1Z2xjOG11?=
 =?utf-8?B?bzFwYSsraUhOVFdRL1NRNzMzcUtQVW45T2JhNEd2WUk0QnU3WWJPRUpCNTlT?=
 =?utf-8?B?dHpOT2FjRWNER2syZjRkNlNHVnFwRTEycUw4b2lKYlFzNWsvMURoYmJFbW5h?=
 =?utf-8?B?OFgvVURkSE4rQlA4ejR4Rnh0WWtJZ0FkMVducXhzRjBDWTlDS2RKSlcxU2Rw?=
 =?utf-8?B?R0liKzhCVlZjanE4TzdQNDMzTFViVW8yeiswVVVjMThFYU1LT2ZYOXlEdkFh?=
 =?utf-8?B?RTdURUhaS0RGcHNIWityQm5jT3dyUEsvNXp6RjEzZWxldlJFV0dNTG5Lb0pU?=
 =?utf-8?B?LzBjSUxMc05UTkowTnNDVWVVUk9jSU9TbjdnWDNRcE1oSGRzcVI5T09FdTZS?=
 =?utf-8?B?VlBNQlhLaDZlNXVsdXNka01kYTN5ZTR2N0FNU1prdC8rZ1lVTEFmMkhIWEc0?=
 =?utf-8?B?eTFNZ0VVcnh5a09JSHVqenpxQUp6NWgvUkR1dDZyS05VK2RSK0loc3ovWkEv?=
 =?utf-8?B?YU5kNktLSnQrU2EyRkdPZnIzR2liSUM1L2ptL0QxbVJkaXYzSWdaM3JHbUFn?=
 =?utf-8?B?OXRjeDBGcTlRNFBBSTdTOWFCQ2ZaREkzMjRlZHg1cVNmVG4zNm1DMjFTY0Nh?=
 =?utf-8?B?bUg4ZU9IMzJZMitBbnU3WStROS9Hc1RGWGpDSjE1dENtcFVHcFM5ZENSbEtm?=
 =?utf-8?B?ejZUckV4T1NrMUl6SEVNcXN0d3loVGErejBPUnVMbzZ6a3BFSlJyVHZPQzN4?=
 =?utf-8?B?WkU3d1J2UkVmMWtHeHhWcGtjQldXQWtRUU9scnIzVk1aSUhOSFltcDQ5QTBY?=
 =?utf-8?B?cDZVQ3NaOTR2cjAxclNzN3JXUGltWXJRTnN5SUJMQkpoY2ZIcnZmUDIxdW51?=
 =?utf-8?B?Zit0U1I5Ryt2L2hnUEFFTGcrd1VnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afc360a-142f-4b42-24e0-08dcabdd99a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 12:39:03.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FXfbnCkJMNBTiFmpzOtKY9qLVLAiKphuoHGwL3vL8m721BAl9KfDfx0A8t+eibV6pLXTGxG89Ur2NAfU0Y3d89orwzXg2Q3PteKfyrScwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8966
X-Proofpoint-ORIG-GUID: 7KqO5ae9YXmceAtXEDMX4KeLL5SuR7s8
X-Proofpoint-GUID: 7KqO5ae9YXmceAtXEDMX4KeLL5SuR7s8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_10,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 24/07/24 4:43 pm, John Levon wrote:
> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
>
>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>>> to 0xb by default and workaround windows issue.>
>>>> This change adds a
>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>>> case extended CPU topology is not configured and behave as before otherwise.
>>> repeating question
>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
>>> that supposed to have it?
>> As i mentioned in earlier response. "Windows expects it only when we have
>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
>> to 0x20, so we starting seeing it with SapphireRapids."
>>
>> Windows does not expect 0x1f to be present for any CPU model. But if it is
>> exposed to the guest, it expects non-zero values.
> I think Igor is suggesting:
>
>   - leave x86_cpu_expand_features() alone completely
>
>   - change the 0x1f handling to always report topology i.e. never report all
>     zeroes
>
> Yes, that would mean that if something requests 0x1f leaf even though the max
> leaf is lower, they'd get data back, but it's not clear why that'd be an issue?
>
> regards
> john


Thanks John,

I believe making such changes without any user or machine-type control 
can be risky for live migrations?


Thanks

Manish Mishra


