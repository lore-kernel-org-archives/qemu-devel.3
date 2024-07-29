Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44C6C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 06:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYKD6-00005G-5j; Mon, 29 Jul 2024 02:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sYKD4-0008WI-T7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:50:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sYKD2-0007bE-8u
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:50:18 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SCv7dN006143;
 Sun, 28 Jul 2024 23:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DPJUJx6rbrsGLPbo5QypryW2xuVXxrnp4GFG5uz9H
 8s=; b=EOFLOnvP3I1S1FJOrkUy3s5bwB3ek69fYswDzSziu1LVYJ7oN5ZN5B7R7
 VVNiV6zeP2MKdVdiFww2kuytkoA31Bxeeq8GDjZCqeFkmtXEOWaPiN96OKWny2rX
 5JYJp6PgVqb4TfDyWOeWTzF+XqM7A/4VKErH66eqfZEqZ/OHrxDXxf4GSv0OspmZ
 Z8EeVmn29UxYRlG0wb6XCHFfkTpGrHriQRBFIGO8x3LMGCIlOUJSfTdivpfN2B6w
 wWW3QgmqFaznOnePZPtSspaiXMOjmM+KaQKqSjffcN66DdmdqBMD+nQtcMvgR1A+
 h9GnlW06KIcK4IWSURZqpgE8gZllQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010000.outbound.protection.outlook.com [40.93.11.0])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40n0evadm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Jul 2024 23:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T68aVKeeEqc4mGfNoC5nk+wiem6wuOhc0T7WDLvhWe4RStzfYqejw03XnUiwJrwbCMx19gnDNC8BjjNOvDGu+sglx1MmHx7NjTjTNAZk+tPyqFCI2hlXpIBv0d+cA8GE+pvPGpGRdw3zHOf2PNM3wJ71K4XTzr0EqqVTs9yjULqEnzp//UBQX8iY/g1/8SmL+3DQ69ZIN3QkN/cOm0JFMs87cuvNpUj2b0I+gL4CyZPTF5Pr4YcFLRBXuf00ek6j+bBh/0YqdTHS8CyjNXDRF1WK/JtPonfhNkXAicAlnhGxV5H22AVGwzEazeB4BkN/eiQAVp+c1zjmPWmfrqX9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPJUJx6rbrsGLPbo5QypryW2xuVXxrnp4GFG5uz9H8s=;
 b=NNtq0yzkIjUjAJ5gX7iDtmib0JAKqk+5pzjhPAw5Xm3My7YsosjdO9a7kK3u+F5OnpjZQ4dvLbyFjMAWHSPKY69Yg++rL+3TCHxEhg2C27U4dIGl3Tf65C4ArqSWX4gh2bK5oZp1vX+dK18REp2hpnDTAkXnS+zuMtn14p6GjD7RKx6qh5Qmo6baq97szCJ9PZjqWh2ucMYyfINtZLrrKp4qj64impVoeEYUysnLPnrWdoIQigeuvxJCsvShI0MfQzsFKjPEBtEHdxSO2AltXOKyepmmHuevIHXdbI8fKq3n3+NLpFX0Bdwi7HAXMStQV26+kQDeHdRtRUNyCoveTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPJUJx6rbrsGLPbo5QypryW2xuVXxrnp4GFG5uz9H8s=;
 b=baH3okMHE8c/phWryNnpFXjxZ1jRy8hGml4vUoQEkQ8lXfhCA+6kQxojk4p34xa/xq5BSufzO8NtpQt79bps9vcQThPKOhfXD9vQwZ/q/hRTgfw93yif4DLwY2Z7tdQoiz8JJ7AyeiQ6z5ZMqQLpRxoKjuCzc/3zf4CKUxOWEtzIQEzmGRT2jU2ufWBJHHuH6mQ0DsydmQ43xm+jqx1H+RQm8/EMIluLo8WxdkO/K6baaEzPhltbK8Z6LzL7/Fb2/0UY7dHW3TwOYd2/EDJWkGu84osjtC+WDQq6/WikRlUT+Mecfv14jiQVRoue7FzJNWehMZIT3Y3c/ni+lmpeAA==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by MW4PR02MB7443.namprd02.prod.outlook.com (2603:10b6:303:66::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 06:50:00 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 06:50:00 +0000
Message-ID: <beba2597-f5f2-4cc6-b246-edd34c73d6a7@nutanix.com>
Date: Mon, 29 Jul 2024 13:49:49 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, bob.ball@nutanix.com,
 prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com> <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <ZqEW/TIZAqLN3CKI@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:802:18::13) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|MW4PR02MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: caeb4108-5a02-4cde-12f5-08dcaf9aaaa1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTBLTlBZUlRDZUFxUHJnZEo2Sll2a1pNNGNWZWNmd25oOUV6Q0xlTVhjUXVz?=
 =?utf-8?B?a1hkbzdyMXF1a3VxbzQ5VUZDKzVLM2NuREg0Vmd1TS94VG1GaTVSSjhDay9v?=
 =?utf-8?B?WTAyQWM1R0NHVms2Ry9CdHI4b0dtV25EQTdhVkQ0UHB3TlJzTjVOc095T05Q?=
 =?utf-8?B?K3VudjZmdU5zenR5YzNJSHhIU2JuRmFBOFgrTGdXb3RZRXErcFJObC91OUZZ?=
 =?utf-8?B?TjdWL3ltWFRRZDRYV0RlVXNSZkZlb21taDV2VVorWFFycXF4YjR6VWMxb1U3?=
 =?utf-8?B?WWhGSHljS042Q25JaCszOEJUQ2o5c2dqZm1TMjN5V094SU82YVgrUitTY2Nw?=
 =?utf-8?B?RnBObU1vZ3RCSHpCZlRXZlBWRm9WT0xkdjAyeWR5dWxmdTFoZjNWTmJkOWFZ?=
 =?utf-8?B?OTlnQ2lrYkZuazJTclhDWHpEendXY1N0dVVkWlA1MlN2Si9rcVRtMnFBOG5m?=
 =?utf-8?B?SDBxbWRVYldQVUlHVFRYU0piZUY0L000OE1zMUpqT2pzRk4yaHE1QVhTSDNW?=
 =?utf-8?B?Q2xIQ0R5akh3T1cwUnFrSExjamV6YXdpT1UwYUdhcmcwT3dGZUpUMy9NUjg2?=
 =?utf-8?B?RGJPYks1TUdBM0lZWmQwZURFVXRDSXUrUnJ6V3I4eUhUU0lWSHhqWkxSeklM?=
 =?utf-8?B?MEVBcUxkbE1LWm9OYnpCMk80Z1ZwYU5USUo0TzhrbEZWcVpUNXJTbUptdmly?=
 =?utf-8?B?Y1hYNDd5RFA3THZJelpULzlvYm1TQnJ5Q21kUEJ4Y1dQNGhjM1d2d09Kakd1?=
 =?utf-8?B?aVdrZmM1RDIxTlp2UHlwZWFqMyttamwyYjFRYjZlVkM5YmkwSUhmNU1IQmF3?=
 =?utf-8?B?UW90V0k5bDVNV3VMZm1OcXdWVXRvWEdEK0ZiZURpRTBLYnFjNllpWkRmNW5q?=
 =?utf-8?B?bGxQSFVlbTFuTVcveHNLc0w4SkdydmFxZjY1bEl2Tks4TlhMeXdQN2FEZFRB?=
 =?utf-8?B?UEQ3aFI3K2RsaGJjbHBTSGFHTHJWMDhxYXd1U0pZRmdUYklYSmtOclZ1Zk1B?=
 =?utf-8?B?WXpnNlFvc2RBRi9HbWtqQmI4OUd5eTM4Q2hObE1ISHFjQXNxKzhHY0dvOXZV?=
 =?utf-8?B?eGdTNmhBY0pVQlBkUjNvMzZoMVU4VDcwaDg3dTNrdHZEcVZoQ2hFZmZNa2tu?=
 =?utf-8?B?TkVJSkZ1SXVmN3NIQTdpVFRvanZGdzFGeWxTdlhuMWVHTThzb25va24yYllx?=
 =?utf-8?B?bEdpWUpSWTlWOFJpWmF1eGlKNEFaMndxaGdWZktZZlM1NHZ4Mnl1UFloTFJF?=
 =?utf-8?B?NThrdCthcW92M1FrdnRvU3ZGN2hDYlJKNzBWVkFMbVdtMWVYc3k1bCtVYVQz?=
 =?utf-8?B?cllWZnpJUWxEdGRGNGFyb0ZETDNkUCsvWU04cHlSK1RjNkNUSUlPMXl2ZURJ?=
 =?utf-8?B?YUJLazlORzB1UDBuU1R5QXZBQXZ4NitlajFLdHo3cjZkK3VjdmpVVDV6TmJ4?=
 =?utf-8?B?UmZHZ0F4MXpxWm12Y3N1MkZ2anhEc0luWkI0OXpTVFBMakRLMkxtREd3RUNR?=
 =?utf-8?B?V1oxdXV6V0lSVmZZWXppMWlqOCtsUE8zMzNTTE5mM3VEYWEwb1RoUzM0ME9V?=
 =?utf-8?B?L293TUg5ZitCTWpsUlBFQWRocmg1cnBRZXQ1T1YxZG40a1V4Q1ZjOUd6K203?=
 =?utf-8?B?U1FoQVd4VzRlQldsTW5VRzNGeUpVbXErdlJhUjVVanRIeFYyZGNTa29mdm1G?=
 =?utf-8?B?N2JCSGZhTVhXUDVtYS9PZ0hDZVk2ZWdwT3ZjQ0xyUG1YNUJ0K2hGT0VqZS91?=
 =?utf-8?B?TlZkNEdwYmtDRDZHL0l2U3pxK2R0dG5wVXIvRkRieUdoN0M3RUUrRmloWUQ2?=
 =?utf-8?B?M0tLcDBoakxaM1RvcWwxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJHYy9pNUdLUmtVYjEyUTNuZ0hZS3NMdm5yQVYzUzl0ekFTQlRRZENlN1Va?=
 =?utf-8?B?V0l6ZCthM0xzemtvdk5yUEN2dWlraWtjckk1MHZFd2xqMVoyTU5zWE5mWWw0?=
 =?utf-8?B?L21HUlVaWEVLY0ZqVm8wb1JkTGVzUWY2WGhZS0FxUlRMcDNObU1aNzBTUEd4?=
 =?utf-8?B?WTdYMFkxb0JKYy9yK011VkhJa0xPZi9rejFtNjFiVU9XMWhabkhPZEp1OGdt?=
 =?utf-8?B?Ui9NaXdDNlBmVkM1eGlyQUVlTVFvUDlFMGJMN3d4RDQ3WTcrajl3eGlkWXVS?=
 =?utf-8?B?am00alZlWktNVW5RUmg2eXJPVmQvMnpPTnJNVEhLbHJLM2VzSkZEUFlIU2Zo?=
 =?utf-8?B?TGdBOEI4OE1TMmZkUGtuUTJRa0hwM2U2cEhGQUFLbDgvTm8rTi9aV0srQ0hv?=
 =?utf-8?B?NFBYSXUydzZ5RFZSY3c5ZGRMRkxjVXp0ZER3Mmw3Z3lxSnlBbC85NzZaVVQ2?=
 =?utf-8?B?M0xpanM0QU96VFI1dFR5NFNMS3BsYmJBYTEyeGFGemFiUUY4Q014N3NoNlBB?=
 =?utf-8?B?RmN1cVdCVXlObW01YjdwTEV0UjQ3RjloOVQvU3pxNHhTOEwrTDg0Z1lGZXJF?=
 =?utf-8?B?TzR5SE1pVnVOV20zRWhOT0JEdlNwejE2b0wzdmRJOGZqV0ZBSWhWSmExMU9I?=
 =?utf-8?B?UUx0VkdRVVJmaGRNQ2dJT0xiUUMyUXRQWXg3WGZUdXVvOGU4UTlOVmVBQjVy?=
 =?utf-8?B?S0lpU3ZZZFp1TDc3cGw1ZGtnQTFvQUxzaXRxMGlxaTdxUHdSYjJIL0NYUkFu?=
 =?utf-8?B?VHdSQmNKTThFK3ViZDRWaktubzhSRUE4a0VFaWdjd3hESUdOaWZrTm9LaFM4?=
 =?utf-8?B?S2hIVUFkbkcwYTNlQm1QZXQybmdNcXduQXZLeEtGck5lV1psaHFlNk53YUVU?=
 =?utf-8?B?N0w0eEJoVkh4bEs3cHBUV1ZadUphU2FsNmxpRS81bHhkOTdHNjJHNzZ2RHVG?=
 =?utf-8?B?RnU3ZkI4MXo5ZWNWeWJEZTlQZkRSYUl0bVJlMEFaYTNLS01OM3VUQnRzemNl?=
 =?utf-8?B?L2ZSSEEzMWExdndIM1V6Z3dMaFQ4dy9iVU4xdy9Md0FRUEZkcVQ0T1BHZ1k1?=
 =?utf-8?B?Vk54N0swWTFEVTNPeE9FTU5KVjNoQzgwMzl6Qy9CVHZjYlVrdU1PdWJjVm5u?=
 =?utf-8?B?Yll6Zk1YSkgvQUtmMDZLaDFscFErUjA3RjNNWitYZWE2NU9pdmtLVGV0bU1y?=
 =?utf-8?B?ak9XbDI3UDhqTXlZWVFUODIwejlYamtXTXdFSG1wdkFWdUQvZEd3VzNYaEd5?=
 =?utf-8?B?eVhVcE1MQmorQnZROE9pVEFLQVhveXpyREhRdDhjNHVEdThhRU9KNHdUSExo?=
 =?utf-8?B?RFVFamx2N0N0MXhqdU4xbkh5dUN0NzlLQUg5d1BRL2h2Qlk1UXhoQ0NZTDlC?=
 =?utf-8?B?UXpVUTEzUlE4b1NpNTJOcEF6SnI0aE5Ka0w5OTZPa24yTTNic01xS1ovZFdn?=
 =?utf-8?B?bGp3Q0ZkRlR0UUluc0F4a01lTE5DdUtvQWFxQVV5cGhNMGRjYmFZWjhWanJk?=
 =?utf-8?B?bU9IbGdOM0N4ZFBidmZvRDh1cm9lQ1greXljaG5zZFlqbzNDREZ4Snc5V0Fs?=
 =?utf-8?B?Y0pTd1Rsd2ZNR3JkaDJ0WjZBR2dQTVdWYTZmTWlQRlV5MVEvQ1oyemVEZkdt?=
 =?utf-8?B?L0VMNHVORHVxU0xsdmJzS0JnYzNjZWZKOS9aSHdUMlJHY3hZQlp5cGZMK2Ja?=
 =?utf-8?B?RjJiS2pNSDBHQ2hwNXZPWitTT2p1S0lEaE0vdmp0ZWVPTkRJWWt3R1JZNzBE?=
 =?utf-8?B?K3RYeEw2WGUvT084YXBIbldJOXhRNU1BMmtOYnFJcW1WcjJYSXBLaHRzbEhN?=
 =?utf-8?B?UDVxZEUrajRhVjd0L2pvL1phdGlGY3gyRUx0L3dnZ0JHOUxQRFp4dGptb0lV?=
 =?utf-8?B?eDh6VXpNcmcyTUFqL0E2TFczK0xUQkg3Q3BDN2t1cENwWDkzSU1pOUtuVjVJ?=
 =?utf-8?B?R0xGZGh5OFNoYWVJOEg4cWhaTVBmZERqNjc2bmoxemo2ZVU3ckFwK2NrMDRs?=
 =?utf-8?B?dzJwQzdGUVRTTG4zWmxZVmhMWE16K3lIdU9sSEZJL1grNGMwa1RNaXE3WFow?=
 =?utf-8?B?MldUOGxIbUo4Sk9UMUVzdDRvMFdHYzNCZE1md3EyenVoYlJjMjVHRkhYSWZy?=
 =?utf-8?B?TTJGTzJ1alNGSFpZY1lZMnFEQVpteGs5Y1RKelVuNXBHdDlUdUo1OVZOLy9Z?=
 =?utf-8?B?RHlWa3VtREJ4Rk1HclNJcmxhRnpPclJvWGQyVVNlYlNyTHlUZ3lHV0IySkdF?=
 =?utf-8?B?Qi9TeFJNR1NoUzRHaGg2MUdUU3lBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb4108-5a02-4cde-12f5-08dcaf9aaaa1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 06:50:00.3425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58rUuI/YL3rjTDNmNjYX/+Teq5E42uRWya2poXQSiKcNRSkM3rsztT11fvb5hkedQH9IMfARkemeV+16FFuqu+G5HA5qM89V3HwE5e1grWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7443
X-Proofpoint-GUID: rNt7CQWmg93ZZ-qoCWXDv1ux7JvGCeEX
X-Proofpoint-ORIG-GUID: rNt7CQWmg93ZZ-qoCWXDv1ux7JvGCeEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

Hi Igor, Anything further on this?

Thanks

Manish Mishra


On 24/07/24 8:30 pm, Zhao Liu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Hi Igor,
>
> On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:
>> Date: Wed, 24 Jul 2024 14:54:32 +0200
>> From: Igor Mammedov <imammedo@redhat.com>
>> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
>> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
>>
>> On Wed, 24 Jul 2024 12:13:28 +0100
>> John Levon <john.levon@nutanix.com> wrote:
>>
>>> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
>>>
>>>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
>>>>>> to 0xb by default and workaround windows issue.>
>>>>>> This change adds a
>>>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
>>>>>> case extended CPU topology is not configured and behave as before otherwise.
>>>>> repeating question
>>>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
>>>>> that supposed to have it?
>>>> As i mentioned in earlier response. "Windows expects it only when we have
>>>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
>>>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
>>>> to 0x20, so we starting seeing it with SapphireRapids."
>>>>
>>>> Windows does not expect 0x1f to be present for any CPU model. But if it is
>>>> exposed to the guest, it expects non-zero values.
>>> I think Igor is suggesting:
>>>
>>>   - leave x86_cpu_expand_features() alone completely
>> yep, drop that if possible
>>
>>   
>>>   - change the 0x1f handling to always report topology i.e. never report all
>>>     zeroes
>> Do this but only for CPU models that have this leaf per spec,
>> to avoid live migration issues create a new version of CPU model,
>> so it would apply only for new version. This way older versions
>> and migration won't be affected.
> So that in the future every new Intel CPU model will need to always
> enable 0x1f. Sounds like an endless game. So my question is: at what
> point is it ok to consider defaulting to always enable 0x1f and just
> disable it for the old CPU model?
>
> Thanks,
> Zhao
>

