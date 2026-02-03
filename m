Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75509E87843
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIky-0002Oh-O1; Tue, 03 Feb 2026 10:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIku-0002OI-T6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:55:57 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIks-0006Tw-GQ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:55:56 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613C1NRw2642842; Tue, 3 Feb 2026 07:55:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zuNG8vNuIPmbJregvXXgxVYO5aDn4lbAowFaVGilS
 Ys=; b=Hrgn8hUHGobBaHbzJyuXzRUAA4Wo/B+hQ+73kFa8DwAQyyr4vsuu7csqY
 3cBZI+3B3i/wE9PGYLRJQ4ROjsOw3fBPdvPkIoiuvXt/ChS3wGxdNiz93Jo6E+wo
 XV6xAVTml1Pvlk9HDRG5zMfJYyS7JqtAxFWuZMJkvpPv7ZPg1kd1LF8NQLz4DXKW
 Sau5KvxP4XTM0o3qH5YfifGDubXY5NQDBaehctxSGT+hBTeWvr6NDvS5stnwpbZw
 es0c3MNtEFYtY2+6L3EuHx7/1qewtrd8eBXn8oxVWJGk1Zoq7sZWhRZk93L9Zutb
 tQS8SOGQwBBaomjGJ8yF6J+6KVWsg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023108.outbound.protection.outlook.com
 [40.107.201.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c2ymptwrv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYUlloPB3MxfOzVVh3255uDeaV9l8CBGI2FtGXB0Ei2i5zscZD14Jmcjgk2uPySWpvVAXYGhIYEwn6mod6pzyvVbh2utJg4lw3eYqoJlQMgVoCjJbHb9TcEc8nFmndRyTx/AlBPWtQKoNqgasnZyVuLb4bNkmKJaOPT5VlHYQBUsMqn/wGlVuIw6qIptvTvA6RFhpfPrh+pTbmrESrGgVjmn9U1D3t4IB1zorp2GU1vlrEIhk+lWeIaAE4f+U2RXxBpjlIMja7f/jxaV+ZQ1Zqs0o/op35rTthSuDVAGEsOftaQmshx2AQHpsvWThehGgQpLxr1NRSsViNHG3tzqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuNG8vNuIPmbJregvXXgxVYO5aDn4lbAowFaVGilSYs=;
 b=h3isxSrXF/98iHTXmnTIU1wNRiBkIYpVHRuJ2oZpFosfItTQC+b1weIa5SFcGNmfgim1zECSO9cTxmy7MohBj2l1Uf6PqYwvHj0a8pK1HYNEeRg9RNHetpKl9EzwYKTHSiM1WQaBsKMDPPRNSsRN+7+5gHtVGF7JrYiLWPcwCTIAYAy/uTWCWomAXerrA+pe2CT9phXN7r35GMEnT5epfGnJtpk/M9Ts7tpa0DR9d13vytKa401RqqzAgZ8ZRA9gMPGFUKriliDJnIyCxIPcN47uF/ApFAwa/iwHSVumdYXnbnnY+Knb5vKRCvIKvdLC5UabLfYciVgokh35h3K8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuNG8vNuIPmbJregvXXgxVYO5aDn4lbAowFaVGilSYs=;
 b=lOdsZH8p0hPM494iGeSTMeV7kkPDpYWBGK9MBYpEfmQOSoqW/Yjg2wjy9T+qqeaL1mSNT9nuSYdSmeamc0BhnkrcoJ7MjMfy5hOJ/pUuz50CiLhEBN3Ko1gYZkKS74SjIRif/nuZpyN1PHqU/L7JPAS95meuqZ/M/ftxA1Se7EzZDUx6wpfrClNFO6HK208zL0SLuY+8rNou/RC1M7ywjukHfnxs9I8NbxJlS4J4xzvTVNH7ifAoSTI5rVR98FXnjxGR+mgmyZ1oCJJXRzFAToHQari8TxShJRohVE67XKBBIuOrxHw9wrnR2aPKcCr30CN/59FKv/1QB3DcQwutGg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6994.namprd02.prod.outlook.com (2603:10b6:a03:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:55:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:55:46 +0000
Message-ID: <8afb8605-57b2-4146-a523-061908cc0c59@nutanix.com>
Date: Tue, 3 Feb 2026 15:55:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/37] build-sys: create a libaudio
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-9-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:806:120::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f85139-55a2-4845-098f-08de633cb193
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1hMNGptRjc0WExSUXl2ZjdwemJQOGYveG5YbncvRTVURkxjWjVtbGpZbnFC?=
 =?utf-8?B?YXVWM0lXd2h2TmhRNU5nSy9DWEJNNitheFhlWE11Rkd6NWVIVFFCV2p1Wkow?=
 =?utf-8?B?U0Rwb2xCNUU5YXpsTGIrZWJmdGpES0FUZVV0UXdOajRGNU5McE1LZXFvV3d3?=
 =?utf-8?B?VGlKVlViRFRhOGlCYVVkMjJ6RDFIRUxnNk5nQUU4a1Zra3ladHJMSzhseXVD?=
 =?utf-8?B?T2tFRUZKSEJJNHBaWVZvUGtRN3UyamdJUzBOMUt2UnBmQzZQQXUyZTROekVi?=
 =?utf-8?B?TkhtOGdxc2p2MWZodlNtZUp4aDF6VXZvN0JGUGJ3NkNFblBYWFpZOTUvd2pm?=
 =?utf-8?B?MUp1VThYZDBYMEV5T2xiR1NKSVRBL0dPM25aQUlmWjNYTmVxTTN4RExxWFI1?=
 =?utf-8?B?aEUySnNaUCthNTMxY2RERngzWmpjandHb0JnbW5iSmNWUXJrOU5CYS9tSjdT?=
 =?utf-8?B?SWN5MnpSTmZLOW1qMFF0djhna0FTeHU4a1BUR1kyR0RRN1FPYXVwN3B3dDhY?=
 =?utf-8?B?SndlaUFOK0RCRjh1eDUvT0VLVExINEJyOTBodnRscThQK3kreW1xMEVMalJl?=
 =?utf-8?B?MG5lbkNHblRBYnloc3ptUStIc05HN3dVNlBTTXFqQnpaR2U2d2JDdlF3Y0Nn?=
 =?utf-8?B?WE90MGo5eXQ4M1FtT1pnK0ZNWXppaGRMSlZIUkRxN01VUGFlQ2tmUCtTcVlG?=
 =?utf-8?B?TGE5NGo1Mk9WVElwVmkveVFoT1UwSys0ZzViK294WHdwRHowZEpVTk1rWkdM?=
 =?utf-8?B?TTh5bjFZRytpeTJ4NU5mNll4MWNpenNRRVQ1Z3l0bEVOQWdvZktZWEZJL1BZ?=
 =?utf-8?B?SXorVStLUER4Tmd0YlBtQUphRTZHay96aGNIbXk5MXBaMGxOekhGRkQwTXQ3?=
 =?utf-8?B?UGs3eDgvejZGaGV3NDY4SWcza2NvSzQ1ZnRPZ3M4ZkQ4WU42SXFVeUpOa3hL?=
 =?utf-8?B?WjZQcTR1WkZTNU5aR0xVRGlHOXAwUnNsUzA4a2V0cGgzQkJVRjNXeTJxUWU5?=
 =?utf-8?B?WE4xVE01cHFLZkFnSXlEVTJTTlVzRC9CYmJMTXhLSTRyVlFWMGtTT1kwVyt5?=
 =?utf-8?B?RUwzd0pzYUhTRnhIN1pjWFM4dXRsVEJoNTZ2TlRWbFhxeGZmcXQybWJGUzVO?=
 =?utf-8?B?ZzBtRlIrQ253N0xYMC83dVlwTmdBb2o1aDVCT3NaQzR5Vm9MYzNEcXd1aU96?=
 =?utf-8?B?T25UOTV0QTdLajNKU3pOLzVsT2daNUIybjNOZ0k1RERDaTRjeGJYSXBpN1lS?=
 =?utf-8?B?d3IydlhrUVNjOVlmMDJFRjNuMllpZU5BUmZiSm1UZ1E5Qmo3ZzlJMW02Q3JX?=
 =?utf-8?B?NWJCRkFRZndNY3lBaUY5WEthSWJJL20xZ0VzV2d3YnZjSzBlbXA5M1FpY2FP?=
 =?utf-8?B?MEtwQ1lzQUo3RFYzRlZWcVozRmZxYXBCZjFwbW5icnVzL001aGx4VTRoa3Ji?=
 =?utf-8?B?SmdNMEtXZ2pPb3VxZnF1ZlEvR0RKOTAzOVhsU1NaOGl4bGliaUhTb3RqZktP?=
 =?utf-8?B?WGZha3lPQXpFeFdybTBNc0NubmxjSnhhSnUvbitEaE1QVFRmVEcxaHhmcnN3?=
 =?utf-8?B?MDFCMFhPbktKVEVKeG8wNTFQVGE2Qi9MUFZ4ZWJKL0IweW1qYTNndVhXMHZH?=
 =?utf-8?B?VTVpazlpWmptN0pMRVY1WFh5TGdjMjZDOGg4OFNZTzRoMUtRSXNkU0xyb09U?=
 =?utf-8?B?TmZwcHFVVE1qdXExUlFnZHpZbTdQQ2RKL1haVVZDZHpsQXpNc21aWWNHeXpl?=
 =?utf-8?B?dWZtK25uRXNkakp0YmZrRHZIVUJIMzdsOVhqdmdCQlN4QVNleW4xYzI2L1RC?=
 =?utf-8?B?dm9oWVFIdEZISFNkNEpNbE5rMVdUa2JSbWo5aDBReS9nNmtWWDZNeGxEQlJN?=
 =?utf-8?B?cUxCREFqR2RHZ3hudERVR2J4VFpqczRPcjFjV1NmbmgxWmJoYXZnd21GQkkv?=
 =?utf-8?B?bFNOWEFrZTh5clc5UlJHcTlqRmVTTURNSkllNGVrKzNncFBNa2QvYlVkZkow?=
 =?utf-8?B?TjJkcjROSFI3cytJMVNNTGVrOTFiKzUzMWRrZXNLeEs1dGl2MStZWFFlYnpa?=
 =?utf-8?B?ZGlWS25yM3VLU3dGUFZ1cFh3UU1xV0hNZG5SOE5HL3Ivalc5VXBOVXBDS3o0?=
 =?utf-8?Q?6nUc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTUvU3hHd0J3bkMzbkptUlAzblFBVlE4cmFTVWFkZUd6OXI2YTFvQ2owbDVo?=
 =?utf-8?B?elN5S01WZ3NFUVE3SFlSSVc0WEZvUE40T1B4dTdjdlVNbVY0Qk14ZjIxY0gx?=
 =?utf-8?B?KzFMMGV2OExRbXh3SDFQR2VwcDQraEdlbEZNOUxMK2E2bEFnaFhLUm1ZNzU3?=
 =?utf-8?B?dVEvaDJoNko4clJwck5XVS9hc0JWWjUzYWtRTUdGWXhRem52TFB4OEw3RUMy?=
 =?utf-8?B?dHRXNk9JTVBMckprQytreHFNWlVOa2tSTDhPOHkzSlh1Q3MxQ3FHb0JHL2lk?=
 =?utf-8?B?RWRoSDUya1J4REVKUUhFakFwQ3YyZTJISU9WelgxVUt1cjhFdHQyYWRmU2NB?=
 =?utf-8?B?L2VKODRRMTBRd1I5SkU5clVTYWdqY1BGZEs4ZFJBQ3ZUOHN6Ui9yTTd5TzJY?=
 =?utf-8?B?R0o1ZUhkK0JjMUxSakJSVERha3FROWxCN1Z3K1lGTWM5Y05sSGJvd1FsQ0l0?=
 =?utf-8?B?WU9DMWRveFdza1hQTU9xVUE3dnMxb2VvTTdRQVJ1NUVyendCMXhDVk03a05t?=
 =?utf-8?B?ZWVJWnNEQzZnczUvUmFHSk1wOUFmdklObWlrbHVacHNYb0p5RWo0R0V4NVgy?=
 =?utf-8?B?L2NJeFJZaHZjWEM5QWV3Rk13Mi9CYUJFOG9UUHlkWlpyUlFtOTJwMUxSQUhi?=
 =?utf-8?B?Q3pTSDBReXlpdENGeFI3a1U1bm9YUnNKenlzcUdjazVia1lIMWw3U01IRzlR?=
 =?utf-8?B?UmtJZU92Z2VIaXNVdnEzSlJZRmJSaldlOE53Z0kxczVNRTJqeEgxUjhINENW?=
 =?utf-8?B?dzRRVTVyUEJNVXFIRk5od3d4WngxT090aThiblg0MU5xVGFnb0gxQ2ZFR29Z?=
 =?utf-8?B?RVdGS1UvYUxLSHM1M1RxaDNPVTdrOXBWZUdocmUrLzQ3RDIzWHE5RU1vdUtk?=
 =?utf-8?B?aEc0ZVFQR3RaOW5iOUQwOVBuM0JjZ3BpQWN5SFhTUDlhY0VPM0ZtbTlLYXVp?=
 =?utf-8?B?b0Irdk5MS21yMHVlcjNiUW9FZk1kcVlwc2k1L1Q5eXdpWXR6VTVzZ1hYRGE5?=
 =?utf-8?B?Q2tUZEY5bDk3YUo1R05OVnN6Q2VpNlVrcnlYcTdPMXozSW9XNEthRWlvTS9a?=
 =?utf-8?B?VE9XN1RVNkJQVTJqM0VhUWdKZWVxNnUycEkvK3hJbHBZVmluNUJGb1hvaGk1?=
 =?utf-8?B?K25OZWZCSHFrWXpEWUFBcGNudUJYK09yR0JmRi9rMVh3dkVMeHFZRkpiblNm?=
 =?utf-8?B?c01ydzlUSk84alVmUXN2K0tQMGJsK2RWMFUxWGVNTFB1N01UK1JjNUNoSHhR?=
 =?utf-8?B?QklIajNLUVdVYkk1ZVo4OXRPT1pPVEZIVStxMDZsSDJFTFNYWnpUekdySXd6?=
 =?utf-8?B?SXNZdkM0NFlvQy90YnY0OXdDU3ljVDh5b25YdGZLNlNuSFB2TUV1MG5tdWhD?=
 =?utf-8?B?Q3d1UmJyemlrcW52dUNuQzFJK1poVXJXeWN0dnpxeUxjS2Y4MU5kZXEwOFA0?=
 =?utf-8?B?VzBVaEtkYkxWMU9HbTFmMlBFdWlVVGJKN1A5U0tRbk9SUXZIS1kzMjFDenRj?=
 =?utf-8?B?SzBCczQ4QmpGYVg1YVRJQVdLVHQ5VlYwazk5bFVWNHhsL2lhQ1NiUFdZYlg3?=
 =?utf-8?B?QjZHMTNiQ3FWTVN2aXM1UXpOTFFGUVkwMURZVWJ6UGVJUkc4dlJUYjdSOXNy?=
 =?utf-8?B?Wm1xRVdUZ29xTGpSQURrenBiQWlaYW5OL1lOc2Q1cC9LUVFmREFSWVlEZGUv?=
 =?utf-8?B?cm9mSGxaOTYvajh3WTh4QnVmYUJocGxZRWxJUDVOaWxxOTdEN3dyUWpLRmdq?=
 =?utf-8?B?VkNhVXdGd1ExUm9GWCt1anhNUUN5RlZlbEJkY3dMNW9PdlBnZzZSRTltOGN6?=
 =?utf-8?B?Q0Rlb2pHQk5HWFVnaTRtNmh1bnFnSFU5TUI3NTdHV1dXYS9HcGE4K256dVJQ?=
 =?utf-8?B?bS9ZcVd0dnJPdG1HTXlldlJoODJaRStrRFUwM2ZKTHJxRVBSY1MrUmlVRENS?=
 =?utf-8?B?eFU0aksrMFliTXY0RjRzVkIrVFJURm5FaHJsbHFERjlmMmFTdEdwYnM0SGlv?=
 =?utf-8?B?ckpZRUZkVDRLSU5FdStUNHYvdlRPYk5vSmYzWjNYR0Z4QmVMZUF4cUJyMHFo?=
 =?utf-8?B?aUdhYWs3RmNiajRlR0ovOWtLWmZTRXJKaGlsRzBFUENZaUh2RUJpOGNZY3du?=
 =?utf-8?B?UjAzRjZRVVdBdCsvbkxjdWNsVE94T0FmbVlGT2xXZHZPMHU0akVneHRBTTMw?=
 =?utf-8?B?SExHaS8rT2RhTkhrSHZ2aFFGNVZmWlV6a2syQmliWTFVZnBabnZpSFBzc3o2?=
 =?utf-8?B?QTFSY0ticlJRMUs3bWJLVGJMelJnRnJOaFhhNyt4bWRLNDZZU1NTcGFiTUtO?=
 =?utf-8?B?QjFMU0RFL1N2d3d3WFliVzJlUlhSYS9mcWxZQmNMa0Vnd0JsMjRLeVY1d05H?=
 =?utf-8?Q?MdrJvT5huambti6w=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f85139-55a2-4845-098f-08de633cb193
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:55:46.3058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: he+c9j/A1pzKXeCeA3TSeJrZCOuL3F96RI4XWivAEUrESD3e7BwsXMlKRTiJoGxjWJx5ZX2Ccei5/+EyyBdMvbJSFrNFdpTnJGobaPTfD3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6994
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNyBTYWx0ZWRfX0uhs3ky/JXs9
 ifJf+/QMiQQeMotKuiUztQNCyFxDah8RtlceDPj2WBBDKBLH2P12PhaDOwB5bURtVV1tW0iN7ik
 nyhqlin/ZvwYq8rqdDykdR6dYUhFTks1VLG6ZZPhcqe0p3QnOFJ8cKgQzKkR0ZPr2dD1p5q1z7M
 6x3RVXlb1EfuYpYgcvSB31Dsi/OxN1NNtzwx3DYpr7+B5IoEaRdIzaqwwR61RHWeYhRKRfoXSxw
 bjphLenEFkVUuZZTfVNhgw/UdRRK3Vtq7hETLqYe1ghOPoyNFNzpZXBdioaXhW1pZVKMp0owgeW
 mXD18KE4eOJ6P/9UQytxGvTZrSWSCMzyzojdJ3ZzisscNjmfKQsbegTRrB3FoBsq2smTfpT6q/Q
 OImswdHcxzoUq1gidw42a7p1N8KDiWToVM/AfeboNaZQqbQnKD1QnE8Sh+AgaAj8KqwlQpjXpdp
 N7Mlh4YwRLcR5Ke/8lA==
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=69821a87 cx=c_pps
 a=ZLXFQchnQ28/TEUTaBYKyg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=LlKmKV7zBt6WEjHUk2oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Z4JCGTpQFHeu_liqqSDuLfqfgrr1DSDz
X-Proofpoint-ORIG-GUID: Z4JCGTpQFHeu_liqqSDuLfqfgrr1DSDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This can help create tests, for example.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build       | 10 +++++++++-
>   audio/meson.build |  3 ++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a84f14258b0..d9e2834f6e8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4059,11 +4059,19 @@ libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
>   hwcore = declare_dependency(objects: libhwcore.extract_all_objects(recursive: false))
>   common_ss.add(hwcore)
>   
> +audio_ss = audio_ss.apply({})
> +libaudio = static_library('qemuaudio', audio_ss.sources() + genh,
> +                          dependencies: [audio_ss.dependencies()],
> +                          build_by_default: false)
> +
> +audio = declare_dependency(objects: libaudio.extract_all_objects(recursive: false),
> +                           dependencies: [audio_ss.dependencies(), qom])
> +
>   ###########
>   # Targets #
>   ###########
>   
> -system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
> +system_ss.add(authz, blockdev, chardev, crypto, io, qmp, audio)
>   common_ss.add(qom, qemuutil)
>   
>   libuser = static_library('user',
> diff --git a/audio/meson.build b/audio/meson.build
> index 23fb66d571f..a5fec14fb3a 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -1,4 +1,5 @@
> -system_ss.add(files(
> +audio_ss = ss.source_set()
> +audio_ss.add(files(
>     'audio.c',
>     'mixeng.c',
>     'noaudio.c',

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


