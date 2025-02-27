Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43DC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhGe-0005SD-1c; Thu, 27 Feb 2025 12:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnhFo-0004tN-2M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:20 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnhFi-0002Fo-Mt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:00:55 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RBvmEY032632;
 Thu, 27 Feb 2025 09:00:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=bPSYVuAP3tgIr89
 z6KpEdO3T54hw5CcJ3UVeMp3hRJc=; b=YkcPMylgzoSOM1pAhAjeUo9VSEecj2C
 wpUrpMU3cTqZYHleI0UtlCIuXJB4/X9snimNt7fdgqaolER22FSyMuf0FyLchdZu
 NjIIGb91WY1tDXWB916qj8LSnNTdZnEOeywPR7FsDXmmgniClCP1nhyQMJTxGevU
 lTBeTjwppCK3cMmLRAhb8i2IXARyNhxkHtoSMTdQnyF0E5srCrM95Opxs4oVPYcy
 3Il+5ZrgAQav5qenudvHqrpLs1mDWOYnyp3Fex5D/ou8wt2CzOEX/pMuGteOAPX4
 AevDCFYsg4benrzBVYn3MvugERsijkZ/uE6NiV3P0l9i5oTTFPDalzw==
Received: from bl0pr05cu006.outbound.protection.outlook.com
 (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.9])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44ybcd69vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 09:00:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2132wdqK/59N+P7sPP9BEN64iKzpI+S2HlKtrrOpqhS5n9eosnm975RwAbJvSSkW1qcQvX6K84lNHE05D4x9ufCUYnGOmxoMbl/+GAOPkhgWzXcLuavQYkuCk5GQN+68HY+P14cffpG5oU30bbbivGANJf8opCZc8uWZhEY33cdt2/YXESf+ZRC3sgS1WM3sTIDQsmhOSO+5u5mJWsqK79Azw2oWlI3Cw/T2pfZ7YOBOHX/i2Sxw9RMbp1jVjF9679SYUTzDrzGWVVrZaDd8i6eYVtekNmJz50RROZb3oECEW8NaccJLsJzCwbIOxlGcgD9591aoqHaylNATFp0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPSYVuAP3tgIr89z6KpEdO3T54hw5CcJ3UVeMp3hRJc=;
 b=mxn0X9a+3/u3P2bnZPV0vfbo1kpdFa5v1ihbftQf+qRGl4W7RGLEJPQDfHrlHGHu1v/cEvaGE6/p8s7oU5AmVFiSR6E+ppJJj2er7AkweV6GseOL9H5c1IrpE5RVOiyiQt6QhRtBG/Opw8Ccixhbt1hSSfGmaNFz0gwWUboSunyHhvJT7uk+QApLpLS/MyR3H+c30olA2rh/nGHEG50myrUgT8hfZgS9MV2COL0gdj7bdicyGzJ6RqMy5B1mvYwz3ALg18j1P4vvBUA9Ufa27AaPGPO+LVOOS6MidZ+BZtleVYPSSI7USpWwy/DZ8TBiSv3kqZbRJD5V9S38xnPZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPSYVuAP3tgIr89z6KpEdO3T54hw5CcJ3UVeMp3hRJc=;
 b=EhwRHQmJsv20CXNfHm9A3Wc9uMT0qZwrxLqFnG7jEJqxN8MOEvdvo+YvvpKaHwJD0S68GWDxTJUL4zTq5XDxGVh0bt3LxvTcwO4VN1MU7SfIj8Rm3Aygz2ZQvpylSm06WscF+YO7OQF1/qMpJgc/xqIsvu7poytaOfeiQVULolFeXcmpydRZsS4lqmrWQdTIJj8D3yAWJHwmLwGRn3OZJ9DO+oW/rsWOEQdEhx2pnTPCChrU4V/6+3CrgQLhDnJtD9VOt18i16TFjGEGbtwxl4R7iNwA+5u5e6DzfujnstD6nuD7cs8L2Fe15YrI23Xve/eUz16UrrqS73zDNb5Yxw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SJ0PR02MB8717.namprd02.prod.outlook.com (2603:10b6:a03:3d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 17:00:43 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 17:00:43 +0000
Content-Type: multipart/alternative;
 boundary="------------4sX0kmzLa0f4BjHO0AEO5ppB"
Message-ID: <d87fa87c-46c0-4620-9741-fafb3b522e67@nutanix.com>
Date: Thu, 27 Feb 2025 22:30:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Content-Language: en-GB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, peterx@redhat.com
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
 <Z72ITCJlkz9711bU@redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z72ITCJlkz9711bU@redhat.com>
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|SJ0PR02MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 169612ca-de43-4bd8-787d-08dd5750455a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|10070799003|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUdyZ2p2S2NrZy9lZE1MQlFqSll1MkV6c1Z2eWZMUDV4OUhxMnNlQ0EzS3hm?=
 =?utf-8?B?VWdqQ3NGbDRVZE0yenB2c0VTUFYrWWJXZTUydHI5c2FpdVkrSm5jaEJBL2VX?=
 =?utf-8?B?a3hKemFzdHB4ek1nRkRpNXVCREh3REI5c1dkbEN3MU1LejdVWVAzb3ZUeGNi?=
 =?utf-8?B?VzUvMkpPQURCM1lZQzhyQnpuTmVwejFiR25wdHR1MDJqSm5IbFB3R3VJYk1X?=
 =?utf-8?B?d0V4bmZsdkhpYjlwZFFZREoxS3VLK3V2YU1hMWY2OTBlWTU1dWQ3WDJiWUEw?=
 =?utf-8?B?ajNNUlVoUmdaRnJlT1lWbFNXQXUwZWVYM2xpdDJtMHlCQndoNlZWVC9iK0gz?=
 =?utf-8?B?MERUZ2VyYnRJT3FXc3ZnMHByVFg0WlhuZkU3MGp6cjRYMElrWEM1ODhqdFY3?=
 =?utf-8?B?bytndDdHbHRJcWFBamZ1K2VuS1d2Tm9oTzRPekEwUEp1VUVJeEkwNllYSUYv?=
 =?utf-8?B?bTJvNGJub01ObkFBeEZQSUFRbUFPYTFCOTl1TE9ac2tkZUdaZEp1Z1hZWU9B?=
 =?utf-8?B?VDFuRGVCNUNnWDNQWVdENmNoUlNhaGVJOFVUV0I1TGQ1T0h4UnFEN0hCdXli?=
 =?utf-8?B?ejZvL3JaMnJKaWdKeEhLTUFoTDB2RlRvZkU3VUtxVFFsRjhkYWcreHg1clov?=
 =?utf-8?B?a2NOMW1GWEF2Zi9TQ1o3MnlrUXJIK3hra2V0ajl6TUVYckJoZXovVWI0eGh6?=
 =?utf-8?B?UmI5UzRZVjFXelI2S0x5N25uTDBCV3VhM1RLUnYyeTBkdnJZQmhHR2RPQURp?=
 =?utf-8?B?dEpRR0ptQVk1OUhZOU1odXFwbHEzVzZFeU95QWExT2dZNENOQjRBSWRVaURJ?=
 =?utf-8?B?dGo0cWl2TkpZK0hSeXh2NkNXWU9ISjBqOUN1eUZCRU50eUcwalduVE0zVExM?=
 =?utf-8?B?b2pLTklGNTdWV29RbjFISnpJY3NJSjVhUVQzckMrV2t4aHpUMmhVTGRGcnlO?=
 =?utf-8?B?MCtLQXBUNXN2MmtHMjB4eGRDTlI1KzJPYlYvWXpCS3J3VTk5NmxsNFd1Wk43?=
 =?utf-8?B?QktHT0l2UHVLc0pCa3FVSTRSSFFQckYydmY5UGdFUFlsOUV1eVZDZG51WkhJ?=
 =?utf-8?B?em9aaEFQK1BEUUlQZkNheHNUSGlqY2VOZ2tVbXBlb3ZDNEJaOUNmd2UrZytF?=
 =?utf-8?B?aEp3djlwbXpJc3BhL1J6WTJjWW1GRWtCZ1VzekJFV3JuSGphMHhiNnVvYURG?=
 =?utf-8?B?aGgvZGt0V0ZMVlQ5QU1qRm1iR3dSS0toTHh6UTlMU2Nrb0xpbVBlVUlJMXNC?=
 =?utf-8?B?YXl2SE44MDNVVDB3T1krRWMyUVMrb3Q5cG9paGJ2UXcvSmJDVDEyNTV5S2Rz?=
 =?utf-8?B?R0J5cXNpUlBvY2FYVkdlVVZHU2pGQ1VTNE00K2FsUmZydU9PR1REbW14NzRY?=
 =?utf-8?B?SHRMVlhIcHlwcTZxQUMrS1NEQlVaUUwrc1RVZVZqcDdMaDR4V2RSMHp2Vmx5?=
 =?utf-8?B?WVdZTHdWUmRkZEJlYnVwbXpuQjdPZlh0M1hGZzMzQ0J1eHhNQzU0aVdJeUUx?=
 =?utf-8?B?cU1TM05Bb1h0K3EwQ25BdkF5NzRJQ3huaUtlNERwSzZ3b3JJdmtiaytMOVcv?=
 =?utf-8?B?anJtOTM5N1Z2ek5uTGpRNmJ6OFUyS2dQcUpmNGw2bjM2dDNuNVhDT0pPam8z?=
 =?utf-8?B?NUdOV0lnSUhTSGVzWjhLTHA5WW9TQjdjSVNUN01YRUhiaGs3UnVpS2t2UXJu?=
 =?utf-8?B?c29QWnFreXAwaE8wZ1lyTDAxQmRGL1NBQkdYK1h1TXhCV2xEZkNzaHFHTlpY?=
 =?utf-8?B?Y3pmODJIaFVZTVhUUTVkZ0ZvcGpDQlhXaHBqTzFCQWF4emNNdDY2LzJoQTZm?=
 =?utf-8?B?bU5WM1ZZYytKblVHaTIvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(8096899003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5NUXJuN0twUlVTYUhYdVJOSXBlb04xUGFkbHh2aE5RWWc0M3VBMEcrcWd1?=
 =?utf-8?B?SkF1NEhJU3hyeURpUTNoSXlIeVJzYXRPZ0RBcWxKKzdwQ0dTdUd5d2dQQTBS?=
 =?utf-8?B?anc3QmxmeFY0eFFHTlQwRnd3YmFyejEyRVkrUzV3ZWRrcHpPbGN2bEFQNmhp?=
 =?utf-8?B?STNWeE1yU0FpQ0dkTS91T2dsbW9Hd3Y3cHJWcUpVWXc5Q2dlLy9HY3FEdVdw?=
 =?utf-8?B?QUczY1VHUHN3b2tValpjR3lQc25WU3I5NUJRNVlibzByUVRUT2IxSmRsSk5N?=
 =?utf-8?B?enJiR0gxWlk2YXhxQTNxNHN1NkMzbDJhNFlkMDMvUnR5dWxjbG1sd0VrOGJy?=
 =?utf-8?B?N0xMNGRiR0NsRDBQeW1DMHFxd05uYkVtcnN6QTFzS1hJWk8rL0pGbDI4aWY3?=
 =?utf-8?B?NVYyS3NlNDNGR3hsZkY4dUR1U1Bqaml0b05EZDdtNEdtaGtMOEZXWGpwN00y?=
 =?utf-8?B?T3N5ckRDbk9KMTdYdzVGeDNiOE96SXRrL0F2RWo0U0liQ0NmWko1UjB1Z0VF?=
 =?utf-8?B?R3dIbmkwTm5LRm9vRWZvK3F2Y0hiUHdsbmlqNlN1L1BURmM4N3h5em9LSnp3?=
 =?utf-8?B?WWM2eUdlUUpQVnRGTzFLekhjTVNhS0dPMHlUNG53NFozSUNjNmdteVBvK2NT?=
 =?utf-8?B?NDNwNE96Y2VWYlZOTmxXbVZXMENibjV4WVA4N28xMWtmTWhhb3loYU5SVlVI?=
 =?utf-8?B?ejdWNkNIRk5qUGcxS2t0NG5sK3ZHUTllT2F0ZE4vVTlpZVB3WU5sd3NTNXdL?=
 =?utf-8?B?czBlKzczbmJEQW5jVnpHSS9CWjJ6L1V1dkNkMjlOdTQ0K0d4UTNCaVJCUktD?=
 =?utf-8?B?ZWNlakxURlVncXhFWG9JQW10UVo4TnhJZFFCQ2xWWUVTTE04Tk8rcTVrdlp0?=
 =?utf-8?B?QmFhRUxVV3JGVXY1NmtBZVY3ODF2c0xvemxXaTE0MWMvQitxNTNtS3NtcnZW?=
 =?utf-8?B?blI0SUtaeTg3SVdESGkvTWtvWGxuRjZtMldHWTFmUnhSS2VyOHZGWVZWc1Vx?=
 =?utf-8?B?VzJJVXhKU1VYWEtvazhDWjdOYk9TelFhbkJLUldkajZqVmJCU1d3aVRvMWpo?=
 =?utf-8?B?VUhoKy9NM2FJNUh4RW16MkMrSkhnOVcrZWZPU3F0L2VXVXQ0ZzV2WlNQUlB5?=
 =?utf-8?B?SzAzQlFlL1NQR3ZMWE1hK0NCUFRTQTFPaXpwZHlKZXh1NVk3VWx4N1U5eG1T?=
 =?utf-8?B?S0JzemZwVHlQbnVYMDk1RzhUTEF1Q21FZXlrOXFHNXhyOW5mNEtJZGxNMW9B?=
 =?utf-8?B?S0VHQlZ0NW1uQ1lLRjJENEJXRjUzQkowMHRDejUzc1p1NjlURTYxMVR4aWd2?=
 =?utf-8?B?L283Mjk2dmo0UnpYWWVXeHhsR3lYdDhuYzcrc3EvSnRDbHVsZFdoOGZ4ZCtD?=
 =?utf-8?B?ZlpYMUUrbkJBekVFekxlbHNIUkd6c29FVThSZFRoNWtVWDFyak9qeEFLNnNu?=
 =?utf-8?B?YnZBdWxIbmlIcXhweXRVL05tNmhza3IwNDNSaU5YeU0waUdsaUZlc1RELzM5?=
 =?utf-8?B?ZEhnbFdRbWhXa1RBR0hraWpqMGVNWHVsaHNvc0ZZd3BTM3BPYUsxcTEzTzFt?=
 =?utf-8?B?ZllkTnlPaVlEVGlxUnBPNWt2MHFsaFJkNWRnb0wwY2NKL2NJTXFOUEFoUmtx?=
 =?utf-8?B?Z3FITHdNMFdCNHZzQUx1b3dydGlnZ1U3T2JIeEJSTWdvc05aVnFMMUp0SnJv?=
 =?utf-8?B?cU9tQ0JoaGw1alI4MjVkaGlJUllidWJtc1ovQ3RZL3IxNC9xZ3o4cGxCcHQ3?=
 =?utf-8?B?aVllZCs2dWtyWnhaQmhRdkhZd0Y4d2hjUmlCdHo2V2dDemsvWlVmVUJOaTNl?=
 =?utf-8?B?SDc4TnppZTRaR3BXUm4zREp6bk90YllQVXMzYmYxakR3bWU4TVBWN25qYXNx?=
 =?utf-8?B?TWdpaVMwdlVHcEhjaWU5bXNOS21MUHFtaDIwS2lkU1Y4bm8yRDhnNGVReXps?=
 =?utf-8?B?bHIyTnRYMjNvc0hWSHIzODVPV2RmaktIcU5BcDEvU3lLTVZ6YWl4ZHFQSHMy?=
 =?utf-8?B?RzIzTXhXZGs3dlhnZ3czTkZRMWIyTThKVUUrUlhGRjNNTm1MamF0bjZGOTNE?=
 =?utf-8?B?T01Zb1VMK3poMDNDbWdUMEt0QmlYeGhYWE1rbzMvZUQ1aDROVUJ2WXpNVHdi?=
 =?utf-8?B?ZFlQTnoxdmt5NGJhU2NtS0lRTjdZa3o1eFdtWHBEelovZjdEa2xsejNxQ2N1?=
 =?utf-8?B?ZXZiRmI3ZFlPclRaak81dFRUU0lXdDVHZFo2ZnVCbjBnSk1ONjNqbUJjZjN4?=
 =?utf-8?B?cTc5UjFJZFNuaTNMU0dtWmRvSC93PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169612ca-de43-4bd8-787d-08dd5750455a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:00:43.2676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZRHilWxZB30g8p+9IMgHFsqlz3aHZkzlD2Y6azTQkC33S0ei0OWbi6XZ0gKA2KAN8q8oq9oLm7EMYpZJCgYc8IakwAnUKzoTgunm/XJeME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8717
X-Proofpoint-ORIG-GUID: 7OmJpSH8k2yhVLNuOrpuj0MlczxlzdYW
X-Authority-Analysis: v=2.4 cv=cpFhk04i c=1 sm=1 tr=0 ts=67c09a3e cx=c_pps
 a=yfQ+ne3pfVgCfke9fm/9IQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=q1aaYWqR5AX_KREM78kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=20KFwNOVAAAA:8 a=499DZ6xLUlyf1koZHXEA:9 a=SnASeSX98d_8lnQk:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=xjj0GC5SL0ELW4ibpBgG:22
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: 7OmJpSH8k2yhVLNuOrpuj0MlczxlzdYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

--------------4sX0kmzLa0f4BjHO0AEO5ppB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Again really sorry, missed this due to some issue with my mail filters 
and came to know about it via qemu-devel weblink. :)

On 25/02/25 2:37 pm, Daniel P. Berrangé wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
>> We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
>> is accounted for in the OPTMEM limit. If there is any error with sending
>> zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
>> socket error queue. This error queue is freed when userspace reads it.
>>
>> Usually, if there are continuous failures, we merge the metadata into a single
>> SKB and free another one. However, if there is any out-of-order processing or
>> an intermittent zerocopy failures, this error chain can grow significantly,
>> exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
>> allocate any new SKB, leading to an ENOBUF error.
> IIUC, you are effectively saying that the migration code is calling
> qio_channel_write() too many times, before it calls qio_channel_flush(.)
>
> Can you clarify what yu mean by the "OPTMEM limit" here ? I'm wondering
> if this is potentially triggered by suboptimal tuning of the deployment
> environment or we need to document tuning better.


I replied it on other thread. Posting it again.

We allocate some memory for zerocopy metadata, this is not accounted in
tcp_send_queue but it is accounted in optmem_limit.

https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607

Also when the zerocopy data is sent and acked, we try to free this
allocated skb as we can see in below code.

https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751

In case, we get __msg_zerocopy_callback() on continous ranges and
skb_zerocopy_notify_extend() passes, we merge the ranges and free up the
current skb. But if that is not the case, we insert that skb in error
queue and it won't be freed until we do error flush from userspace. This
is possible when either zerocopy packets are skipped in between or it is
always skipped but we get out of order acks on packets. As a result this
error chain keeps growing, exhausthing the optmem_limit. As a result
when new zerocopy sendmsg request comes, it won't be able to allocate
the metadata and returns with ENOBUF.

I understand there is another bug of why zerocopy pakcets are getting
skipped and which could be our deployment specific. But anyway live
migrations should not fail, it is fine to mark zerocopy skipped but not
fail?


>> To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>> we flush the error queue and retry once more.
>>
>> Signed-off-by: Manish Mishra<manish.mishra@nutanix.com>
>> ---
>>   include/io/channel-socket.h |  1 +
>>   io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>> index ab15577d38..6cfc66eb5b 100644
>> --- a/include/io/channel-socket.h
>> +++ b/include/io/channel-socket.h
>> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>>       socklen_t remoteAddrLen;
>>       ssize_t zero_copy_queued;
>>       ssize_t zero_copy_sent;
>> +    bool new_zero_copy_sent_success;
>>   };
>>   
>>   
>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>> index 608bcf066e..c7f576290f 100644
>> --- a/io/channel-socket.c
>> +++ b/io/channel-socket.c
>> @@ -37,6 +37,11 @@
>>   
>>   #define SOCKET_MAX_FDS 16
>>   
>> +#ifdef QEMU_MSG_ZEROCOPY
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             Error **errp);
>> +#endif
>> +
>>   SocketAddress *
>>   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>                                        Error **errp)
>> @@ -65,6 +70,7 @@ qio_channel_socket_new(void)
>>       sioc->fd = -1;
>>       sioc->zero_copy_queued = 0;
>>       sioc->zero_copy_sent = 0;
>> +    sioc->new_zero_copy_sent_success = FALSE;
>>   
>>       ioc = QIO_CHANNEL(sioc);
>>       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>> @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>       size_t fdsize = sizeof(int) * nfds;
>>       struct cmsghdr *cmsg;
>>       int sflags = 0;
>> +    bool zero_copy_flush_pending = TRUE;
>>   
>>       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>   
>> @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>               goto retry;
>>           case ENOBUFS:
>>               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>> -                error_setg_errno(errp, errno,
>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>> -                return -1;
>> +                if (zero_copy_flush_pending) {
>> +                    ret = qio_channel_socket_flush_internal(ioc, errp);
> Calling this is problematic, because qio_channel_socket_flush is
> designed to block execution until all buffers are flushed. When
> ioc is in non-blocking mode, this breaks the required semantics
> of qio_channel_socket_writev which must return EAGAIN and not
> block.
>
> IOW, if we need to be able to flush at this point, we must be
> able to do a partial flush, rather than blocking on a full
> flush

sure

>> +                    if (ret < 0) {
>> +                        error_setg_errno(errp, errno,
>> +                                         "Zerocopy flush failed");
>> +                        return -1;
>> +                    }
>> +                    zero_copy_flush_pending = FALSE;
>> +                    goto retry;
>> +                } else {
>> +                    error_setg_errno(errp, errno,
>> +                                     "Process can't lock enough memory for "
>> +                                     "using MSG_ZEROCOPY");
>> +                    return -1;
>> +                }
>>               }
>>               break;
>>           }
>> @@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>   
>>   
>>   #ifdef QEMU_MSG_ZEROCOPY
>> -static int qio_channel_socket_flush(QIOChannel *ioc,
>> -                                    Error **errp)
>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>> +                                             Error **errp)
>>   {
>>       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>       struct msghdr msg = {};
>> @@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>           /* No errors, count successfully finished sendmsg()*/
>>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>>   
>> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
>> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>>           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
>> -            ret = 0;
>> +            sioc->new_zero_copy_sent_success = TRUE;
>>           }
>>       }
>>   
>>       return ret;
>>   }
>>   
>> +static int qio_channel_socket_flush(QIOChannel *ioc,
>> +                                    Error **errp)
>> +{
>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>> +    int ret;
>> +
>> +    ret = qio_channel_socket_flush_internal(ioc, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (sioc->new_zero_copy_sent_success) {
>> +        sioc->new_zero_copy_sent_success = FALSE;
>> +        ret = 0;
>> +    }
>> +
>> +    return ret;
>> +}
> I don't see the point in these changes adding new_zero_copy_sent_success.
>
> IIUC, you seem to be trying to make it so that qio_channel_socket_flush
> will return 0, if  qio_channel_socket_writev had called
> qio_channel_socket_flush_internal behind the scenes.
> That should already be working though, as the first thing we do in flush
> is to check if anything was pending and, if not, then return zero:
>
>      if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>          return 0;
>      }
>      ....do the real flush logic....
>
>
> With regards,
> Daniel


yes but current logic is, if there was any successful zerocopy send in 
the iteration, return 0. I did not want to change the behavior. Now 
qio_channel_socket_flush_internal() can be called at any point of time 
and as many times depending on when the optmem_limit is full. So we may 
or may not have any data to process when actual 
qio_channel_socket_flush() comes.

Thanks

Manish Mishra

--------------4sX0kmzLa0f4BjHO0AEO5ppB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Again really sorry, missed this due to some issue with my mail
      filters and came to know about it via qemu-devel weblink. :)<br>
    </p>
    <div class="moz-cite-prefix">On 25/02/25 2:37 pm, Daniel P. Berrangé
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Z72ITCJlkz9711bU@redhat.com">
      <pre wrap="" class="moz-quote-pre">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
is accounted for in the OPTMEM limit. If there is any error with sending
zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
socket error queue. This error queue is freed when userspace reads it.

Usually, if there are continuous failures, we merge the metadata into a single
SKB and free another one. However, if there is any out-of-order processing or
an intermittent zerocopy failures, this error chain can grow significantly,
exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
allocate any new SKB, leading to an ENOBUF error.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
IIUC, you are effectively saying that the migration code is calling
qio_channel_write() too many times, before it calls qio_channel_flush(.)

Can you clarify what yu mean by the &quot;OPTMEM limit&quot; here ? I'm wondering
if this is potentially triggered by suboptimal tuning of the deployment
environment or we need to document tuning better. 
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>I replied it on other thread. Posting it again.</p>
    <p><span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">We
        allocate some memory for zerocopy metadata, this is not
        accounted in<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">tcp_send_queue
        but it is accounted in optmem_limit.</span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <a href="https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607" title="https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607" data-outlook-id="301810c9-c795-401b-a3e0-3811fcf8f867" style="color: rgb(0, 120, 215); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext">https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1607</a><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">Also
        when the zerocopy data is sent and acked, we try to free this<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">allocated
        skb as we can see in below code.</span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <a href="https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751" title="https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751" data-outlook-id="0de96f2b-3759-4680-b102-6025b27fad22" style="color: rgb(0, 120, 215); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext">https://github.com/torvalds/linux/blob/dd83757f6e686a2188997cb58b5975f744bb7786/net/core/skbuff.c#L1751</a><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">In
        case, we get __msg_zerocopy_callback() on continous ranges and<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">skb_zerocopy_notify_extend()
        passes, we merge the ranges and free up the<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">current
        skb. But if that is not the case, we insert that skb in error<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">queue
        and it won't be freed until we do error flush from userspace.
        This<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">is
        possible when either zerocopy packets are skipped in between or
        it is<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">always
        skipped but we get out of order acks on packets. As a result
        this<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">error
        chain keeps growing, exhausthing the optmem_limit. As a result<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">when
        new zerocopy sendmsg request comes, it won't be able to allocate<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">the
        metadata and returns with ENOBUF.</span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">I
        understand there is another bug of why zerocopy pakcets are
        getting<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">skipped
        and which could be our deployment specific. But anyway live<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">migrations
        should not fail, it is fine to mark zerocopy skipped but not<span class="Apple-converted-space">&nbsp;</span></span><br style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;">
      <span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;">fail?</span></p>
    <p><span style="caret-color: rgb(33, 33, 33); color: rgb(33, 33, 33); font-family: Aptos; font-size: 14.666667px; font-style: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; display: inline !important; float: none;"><br>
      </span></p>
    <blockquote type="cite" cite="mid:Z72ITCJlkz9711bU@redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
we flush the error queue and retry once more.

Signed-off-by: Manish Mishra <a class="moz-txt-link-rfc2396E" href="mailto:manish.mishra@nutanix.com">&lt;manish.mishra@nutanix.com&gt;</a>
---
 include/io/channel-socket.h |  1 +
 io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index ab15577d38..6cfc66eb5b 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -49,6 +49,7 @@ struct QIOChannelSocket {
     socklen_t remoteAddrLen;
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
+    bool new_zero_copy_sent_success;
 };
 
 
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 608bcf066e..c7f576290f 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -37,6 +37,11 @@
 
 #define SOCKET_MAX_FDS 16
 
+#ifdef QEMU_MSG_ZEROCOPY
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             Error **errp);
+#endif
+
 SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
@@ -65,6 +70,7 @@ qio_channel_socket_new(void)
     sioc-&gt;fd = -1;
     sioc-&gt;zero_copy_queued = 0;
     sioc-&gt;zero_copy_sent = 0;
+    sioc-&gt;new_zero_copy_sent_success = FALSE;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
     size_t fdsize = sizeof(int) * nfds;
     struct cmsghdr *cmsg;
     int sflags = 0;
+    bool zero_copy_flush_pending = TRUE;
 
     memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
 
@@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
             goto retry;
         case ENOBUFS:
             if (flags &amp; QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
-                error_setg_errno(errp, errno,
-                                 &quot;Process can't lock enough memory for using MSG_ZEROCOPY&quot;);
-                return -1;
+                if (zero_copy_flush_pending) {
+                    ret = qio_channel_socket_flush_internal(ioc, errp);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Calling this is problematic, because qio_channel_socket_flush is
designed to block execution until all buffers are flushed. When
ioc is in non-blocking mode, this breaks the required semantics
of qio_channel_socket_writev which must return EAGAIN and not
block.

IOW, if we need to be able to flush at this point, we must be
able to do a partial flush, rather than blocking on a full
flush
</pre>
    </blockquote>
    <p>sure<br>
    </p>
    <blockquote type="cite" cite="mid:Z72ITCJlkz9711bU@redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+                    if (ret &lt; 0) {
+                        error_setg_errno(errp, errno,
+                                         &quot;Zerocopy flush failed&quot;);
+                        return -1;
+                    }
+                    zero_copy_flush_pending = FALSE;
+                    goto retry;
+                } else {
+                    error_setg_errno(errp, errno,
+                                     &quot;Process can't lock enough memory for &quot;
+                                     &quot;using MSG_ZEROCOPY&quot;);
+                    return -1;
+                }
             }
             break;
         }
@@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
 
 
 #ifdef QEMU_MSG_ZEROCOPY
-static int qio_channel_socket_flush(QIOChannel *ioc,
-                                    Error **errp)
+static int qio_channel_socket_flush_internal(QIOChannel *ioc,
+                                             Error **errp)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
     struct msghdr msg = {};
@@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         /* No errors, count successfully finished sendmsg()*/
         sioc-&gt;zero_copy_sent += serr-&gt;ee_data - serr-&gt;ee_info + 1;
 
-        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
+        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
         if (serr-&gt;ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            ret = 0;
+            sioc-&gt;new_zero_copy_sent_success = TRUE;
         }
     }
 
     return ret;
 }
 
+static int qio_channel_socket_flush(QIOChannel *ioc,
+                                    Error **errp)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
+    int ret;
+
+    ret = qio_channel_socket_flush_internal(ioc, errp);
+    if (ret &lt; 0) {
+        return ret;
+    }
+
+    if (sioc-&gt;new_zero_copy_sent_success) {
+        sioc-&gt;new_zero_copy_sent_success = FALSE;
+        ret = 0;
+    }
+
+    return ret;
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I don't see the point in these changes adding new_zero_copy_sent_success.

IIUC, you seem to be trying to make it so that qio_channel_socket_flush
will return 0, if  qio_channel_socket_writev had called
qio_channel_socket_flush_internal behind the scenes.
That should already be working though, as the first thing we do in flush
is to check if anything was pending and, if not, then return zero:

    if (sioc-&gt;zero_copy_queued == sioc-&gt;zero_copy_sent) {
        return 0;
    }
    ....do the real flush logic....


With regards,
Daniel
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>yes but current logic is, if there was any successful zerocopy
      send in the iteration, return 0. I did not want to change the
      behavior. Now <span style="white-space: pre-wrap">qio_channel_socket_flush_internal() can be called at any point of time and as many times depending on when the optmem_limit is full. So we may or may not have any data to process when actual </span><span style="white-space: pre-wrap">qio_channel_socket_flush() comes.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Thanks</span></p>
    <p><span style="white-space: pre-wrap">Manish Mishra
</span></p>
  </body>
</html>

--------------4sX0kmzLa0f4BjHO0AEO5ppB--

