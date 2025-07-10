Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8399C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn2W-0008Dk-Kb; Thu, 10 Jul 2025 04:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2V-00088r-3B
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn2T-0003ZS-4b
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:58 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7dB2e009292;
 Thu, 10 Jul 2025 01:53:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9/FOzg2CRIyaEtPC9hpMYUEYWDyQ7Jwfx8nvvv/xM
 8s=; b=OzfmBwOUqWsqj1uk2JMKCz3/euS6Yxw7UEEoy4WBCNbfp666+EOu3N4EW
 fhG6jvdrlyAZ4z6XuYvE1awhdCOX3JEWyVl3iajH6NftPfFSN3J9DQIsjCI0EzGi
 QwH2IQFEIv4+ro1KqMZ/p1ki6sIcI8AO4NOHOYrkiC2JMAdDm1In90UG1fOO2HRW
 wm7Tad7Ss7Pa0N3A7cZsLlSc1NWrL0ChCabwHWJUs4fLYOtByec9UtRSxFEoc5uK
 dzalUTmLXJQz+wfwuEv1T4+LBCBYZhRZifNf2WjOsCHP2BZqK2RIa+XZgah5EX7p
 Ozxv2huhpxF52hHu+OLQXh/wo+C4Q==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020089.outbound.protection.outlook.com
 [40.93.198.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47rkc5s3g6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz2XnnvBBmc3N4226xBjxMy1iBzsvx64NeE2+sBW/7OSTTn2IMqxU6qVZcM8ZZmsy9Rxa0Mx7uwvgM+PnoNPpr11E4ha7QI1ZIz3+TEY5YTgPMS2EnLz4R4U6MnwfCIsar0kxsIvnOjrg0Zq+egjXR8rD7j30U6hyOVIxHZ1YLYdp1SE623djsTORaaHXTmAmEfVgZfM0VqvRsAP7Oz8ykjrp+gGBrY+OXJjoXKBaQf59WIHr/wSvOCmoNFp0INoc0Z6tOksj/7LMC0c7mmi2LPCAy3bxVWz+f9jO4av13eTIFetpThVPSbxE9IQpezI0KyNiqUlvjLo+Mxr/lESMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/FOzg2CRIyaEtPC9hpMYUEYWDyQ7Jwfx8nvvv/xM8s=;
 b=rOwm0cv1t14tPjoywPvtlU7ea/xcRcHhtQeFo14Bed6WsH6A++qmL9uVgr+WxegOEDQfnO0WP4LjQhLJSbrQBa15+yBRzTb6KziAyqcpofYdUbu1nS26eF34YX7Zz7VippZyFGOMljsDLJ/05Ne8SNpGLkouBxc2kzCUxjx0McwSOk474ga6KTRcuwX/Z08cwzLyfp9B0iIBRXmJAW1SqkptPb5L7l0UF/MGjBb6XZMMYFEeWoF6IPxAogi6oqILmJxeS6FebwgXVchIWpLURbmrw9nBkM9GCVAeT9TlCZrPBv8yW3IJ5EJDB78bFR4qywSoQXlfS+z8YSrKT475xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/FOzg2CRIyaEtPC9hpMYUEYWDyQ7Jwfx8nvvv/xM8s=;
 b=MuThLO8TN/7t+vlCEQ2epvIzkLp2P1zoNq5P1VcopbbIsgEeQXibdot4wYUdNF1Nm9ZTZZ40S21o5HYUU7U0uamzfhwPf8MHPsYs6XtTM8YZHgQiB/Taq23Mxg1GiV5Uy5U+EEUtwlwBnmyIxNoDrvvbW+WJOHbmbhiqn7qzvDtfIPs42hLUQriu1d2aOp83/Ip4bFsIQryzBy9TMqv6ELmfwpCRScvHR81P4dOfn85clvFBMJbZXX+izfDK9YcjScDNrUmp+FZbOsUbKHC+M9SYqMPQlLmpT+1kT88JLGuDyspPTa+302kyyE0Zmg+/5oN0W/YeTG0ZfpitIaJCvQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8048.namprd02.prod.outlook.com (2603:10b6:408:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 08:53:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:52 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] hw/i386/pc_piix.c: always initialise ISA IDE drives
 in pc_init_isa()
Date: Thu, 10 Jul 2025 09:52:26 +0100
Message-ID: <20250710085308.420774-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710085308.420774-1-mark.caveayland@nutanix.com>
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0178.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: b47359f0-808c-4205-3a1b-08ddbf8f4b53
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c21SSzd3NEhFNmNoTUxGbEVMSFhkUXFvMjdSa3FSQlh6N1k0bGpMbXJwZXNO?=
 =?utf-8?B?QjRnNWhSTnoxMHNsMGhHRDQyV1pxTVYwUkNhaWxobkRyQWhIejZnMjdOaldv?=
 =?utf-8?B?a0Jra1Bxd05PM1hDL0h2M1RKM2xWbGYxc3JxbWdpQW9JK3ViTWNyUEgxczZl?=
 =?utf-8?B?YU5jNXRSdWF4SmtsVWUvbFJCUkRCK3ZWTmMzV2p1NDV3WlV1di9janhDWmk4?=
 =?utf-8?B?YUNzZEFldjl3eUJTV21yTnQ3eE55eTMybFJ0ZFpocW9mUk1QeGRkYmF1NUU5?=
 =?utf-8?B?V21YOXJQSGpCdEdkaGMxQ2lMdWs3aFdLc21LTGlGVUlYc1pMVnZKOEFxS3JR?=
 =?utf-8?B?aUJLRXNBNnUvM3NYUGk2STYwOHdnSW1ZUkRKVVlSNXVxRGZxeEVKeC91bzll?=
 =?utf-8?B?YXRhYjRwTy83VVBXUjhTY2o2alJsd21heVBSZFZ5V2NGMWM3QUdHaGdIZVBq?=
 =?utf-8?B?clNJUXhQV1IvZHlJVHhzYlRsQ2VGREV0SzJ6em80NDM4MnROeTZoemRpemFq?=
 =?utf-8?B?SEtkdm83RE80UHloeDMxVnY3K21WUGVuVzh2QU51QTJuQVNSelUySy82b2Z2?=
 =?utf-8?B?TXV3QU5vWDJnSkpvSmIvaVRCQkJXWDNzaGprQnJyMHE5YjFJN2pTRXNsQzdK?=
 =?utf-8?B?dEM4VGorY3VYdFAvVHFYY0tUYTFmTm1Gd0FhVVhBcEt0NzZxd2N2LzMwc1V0?=
 =?utf-8?B?b1pUTDhjWFpLTHBaWXd6SzRHUWdKM0x2THo1TU1mV2NXSVhNZjhvYWU0cTJr?=
 =?utf-8?B?QjZKSDZiYzdXSm5jcis3eWVqY0dEV2ZuZThhSzhhOUFnZGVLNVlPNC84azM3?=
 =?utf-8?B?R0RoZTZMOTZlYnVRMjhiUnFDcUw2UkY2c1dJZmMvaXVDTHR0WG04bkNHK2F0?=
 =?utf-8?B?clJ3cVFrZ01IQ2dOL1JkaXdaRE1icldPMjA2SXBZaC9lSmdzU2I3eFdaTzBY?=
 =?utf-8?B?ZmE1QXVqRytUS2piNEZjVHlyeUJQYTBncUQxQUNESzluM0txUEtybzJPRDBu?=
 =?utf-8?B?TmNabFhKemZnL04vTFdEd3Q3a2tCbG1tR01BZmNjZ2g3TnAzMkpOUTk0VVNL?=
 =?utf-8?B?NFVoSndWNEFaeE9LVkhUTDR0QlQ1SDlISTdMS3ZYcENRZEo3K012eWlLb0t2?=
 =?utf-8?B?bVhVY0FVWDdKYWlLdjFzMUQyV1pCUnNabHlpb1lNTXJpT1hEV2ZJSlU0VEM1?=
 =?utf-8?B?THdoSlIwRG9CcGNSL0NEZVUvWHBOUkNNNkZVd3RuUVNIdVF5MUF3M0JTQklo?=
 =?utf-8?B?SXZ5ajZ2cVFiejJvRE5rSzlCNUJraEpETlIzenNXYXZGNXNLa0owejhmV2xh?=
 =?utf-8?B?OGhQUkxiSGZnY0txWnZPODZsQjBYanppU1pGUWk0bEdEbzJQbEdnRFBxWnh1?=
 =?utf-8?B?YnZNZ3M3clRxbkRpWm5Vc1d3WUpndWN3akF4UG84Q3ZMMm1JK255ZkZyMHBD?=
 =?utf-8?B?TFhCWWVFbFA5Mnd6QUhIcDdLTUcvQmdYdS9yTUhhTE9VUE4wR0pZcXZyRGxk?=
 =?utf-8?B?Qm9XZlpNbm5aQ2ZvWW83R0tSSWZEaEZSWlVpL1FTQmxlWkI1V0twd3RobjVD?=
 =?utf-8?B?RjVUSVhxZHZVSDRvaWo0ZEptOURsUFBmWUMxSU9HM0pnRVZWdWRwTWtTVlVQ?=
 =?utf-8?B?cFBFSmEzMDJBQkJDMEI4cDFVdmpNRjhrdnQ2a3pjY1FYZkxteHBmOWdFWDJj?=
 =?utf-8?B?Zi96bEpOUGcvdHhhUGM4ZkFnWmlMK3dtWWpXdXFRbWYwNkRXakJya01XWnRD?=
 =?utf-8?B?QkNpbU9RcENJNG9PT0l4ak1kYXNaYWs4eGordFNxeHBUQ0ZwTjhWU2h5REpX?=
 =?utf-8?B?OENJMDQrRXdSbTJFRHVoT0x1YXdkVVArOVp2d21tcXJoUnZGQks1Q1ZUczY4?=
 =?utf-8?B?ZTVpNTMrdXVqOXlyWUw3MHNUOWlTVWdQeHFmTkRqVG5leUlOTndJSVpqc0xp?=
 =?utf-8?Q?PcRbqVv+2jU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxPRHNVNFBlOTVOOC9neWh2TVRmMW9LWEJPVS9oVVFlWjJBTmw3UktyOFZy?=
 =?utf-8?B?REg1N3lOaG1SN09jQS9DS2d2bnhPQ3djdnA4L2NQZ21GR2E1UytRV2FmYUlv?=
 =?utf-8?B?dVlraHpJQU5tQWNKREdtdWRWc1ZacThvenVVVVRyWWdYRElZSkNwNDRXWkFk?=
 =?utf-8?B?MVo3cnB3MEdLYU1UdHFRNmlDNSswTG5Ga0dIZG1TSVFhQTVETDFEbGs5VGFB?=
 =?utf-8?B?amZOZWw3aUdhUXVnbGtKL1E5bnhGZ0czWW5tU2JpVFdlQzd3VCtKcUxIK3Uv?=
 =?utf-8?B?U3BxMzA3ODNsekJRb0lyLzRjQWdKRHFFemxPaTVzTitLQ01BK3hQNm91TVRO?=
 =?utf-8?B?T1k3SU5tNzJ4OW1mU3hLQlE3WmI3N2xsd0FpQ3FDU01YdWZTWXZ1eG8xQjFh?=
 =?utf-8?B?TDBiS3hBbzFwb0dFSXpZcExMSnI1WFVkY0J6djR6VXgvTzZqUWZDTTRxcURk?=
 =?utf-8?B?NWQ3SUozUkYxYzJwd3Vka29TTmoya205OUgvUjFQbm40dzRNM2w3dnhZMVlU?=
 =?utf-8?B?dHBVOGkxMDhQSnJvOXZwZmRKZCtmdnNRZkdGd0tKNXl2L010VFJLUGQwcmxU?=
 =?utf-8?B?djU2ODAxbW9GYjZaY0xWeHhiV3dqSzZNcEFOeUNFZmxQcWdXUmliWng2RWpl?=
 =?utf-8?B?WlpQSDRxby9MSUpjcUhsazk1MDB6OG9XOGlpamtrYzFRT1FwMXpqampENU90?=
 =?utf-8?B?SWtSeUxWY3Y1WjZQZnIrbWkwNjlYZ1hXNnkvcVZCMER1QXNWdGJWNlZWVGdM?=
 =?utf-8?B?UGVmOTl3M2M2bStENXFJTmVzeExiT3QxK05WZGJPejZRblFxeGRxRk1nbVI3?=
 =?utf-8?B?UjlRaEQrTit2WUxYd21qcWZZYnY4Wmt6ZURiQU9rbzBoUlBIU2RWUTBWeU9y?=
 =?utf-8?B?YTJKNE9xOHRwc3JMS0JjcUZScWtMaGtYdXNObDE5eEJrUElINEdBaEtHbk9Q?=
 =?utf-8?B?aXN2NDRIUWRjSlQrSUZXbGxEejNFS1RHa2RRUVR3WStkdExhNWdRZGFMRE5Q?=
 =?utf-8?B?YmxaK21YNDB5TkhqNUpTaURuaWZzYzR1aG9nMXI3QTBXR0hGUVdvMjdSNWZy?=
 =?utf-8?B?QW1iaGg5RHdKRXdBb1lLNlA5UkRkWVF6cFI4dWZoUnFSS21iaFU4aUROdnIy?=
 =?utf-8?B?bkM4eFVmc1c1cGVCMitwMmdwQlVMb2RlRi85WDJGUTZaTG5hNUhlWGRGK3FU?=
 =?utf-8?B?eTlpNVZCWnAwYjBJYURoZUYxSFZDTThnSE84ZFB4UTZTQVZvbDlrSGtXOEM1?=
 =?utf-8?B?aE5kKzV2bnQ4QmlDWmplQng5bVFMZ3BoL1o2dkI2K2lLb3ovdENJcEUrSFZN?=
 =?utf-8?B?MEcyYVFvaTJRTVRBWUxqQm96ZTlmZlhNZFRtS3dEZFh1K3NubXJ4ZFlXNmor?=
 =?utf-8?B?b3ZhRFBHQnE4aHRiVkRObTA2b0NkTkh5aDllWE1BZktSazU1blh0YnJXWnQ4?=
 =?utf-8?B?YWZsd1EvK2hoalBZeCtwcWN1dFBXTzJDNEZVTzgvdG8yVy9qQ2E4cVY0aGxX?=
 =?utf-8?B?bXVTTHhrWGc1ZURlcnNRVTJSdW1HMUxHZ3VHaWhvejRDTndpbHNtaGdiZU9M?=
 =?utf-8?B?NitGaks3d1NJUUkvZkRzY25iTHlmM0dNZGtGQlA1STdpMnB6ejBjQnBYeE9U?=
 =?utf-8?B?VUVjMUlsaG1BcVJQdjBUSnpmT1JibWdEb2dSMERma0Z0WWtWL1l4WlpzRUts?=
 =?utf-8?B?L0Z1cXQ5YVAyTXBPeVdpTnA5MTNTZERXN3V6dVFSRTBYem5MOHVWM0pBNlF4?=
 =?utf-8?B?emtwYm52eWRJWTVDWE52NUJPcnRnYVM2R2szTWludHh2VHZYS21GYTY0TG1i?=
 =?utf-8?B?SGZPYjJVYnlIeEZ6ZjNHUDRVakNPSUVsL1JrUkxWR01VQXl1aHN1bm03d3JV?=
 =?utf-8?B?VUljUDI1dVRnY2MyS0VtR3FQeVpZWUtqZlNPRjMwK3Mwdi9tZ0Z6azNLc1FF?=
 =?utf-8?B?VEhyM1NGQWxVWGViMUtmak9TRUFkSGxtb2ZxNzNvcHhVck1laUFnWXJxd2xS?=
 =?utf-8?B?MlB4emxuOTMrK1hSekJsK2FlcG1sYkVjUXpBYW1xM2g2bGxuQ0ZhT1ZTTFd4?=
 =?utf-8?B?cDN5aitjVU5BQk1BRkRCdUlGNXJoTTJGeW5KOXRNZEU2d3orNmhHcVNZVnpa?=
 =?utf-8?B?OFA3ajJnbU1vWkM5aDJ6OGVkMjNmME5nMnpuaTdKR0ZwUW5vdnBxRUdqa3JS?=
 =?utf-8?B?cS9GZDJBMUR4cnBZb0JHZk5FdWFpVk84Z2hnZWh0TjBidEVEWGttclNQTzIw?=
 =?utf-8?B?STJ2N2ZRd3VHWTc4Vi9iOXM0UU53PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47359f0-808c-4205-3a1b-08ddbf8f4b53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:52.2514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ClHDQALiO95jYb3qIw3CpQ7HaHNkSOBzLL+F+ggzsZ+ZynBp71kL+Is4Ljwnor1Ms5zVwl7opTNkvCDrqb03YN1pHoxoZf10yV/pI+R7gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8048
X-Proofpoint-GUID: Eg5xFZJcIxoHxokzovdeGJp_tzrC-vra
X-Authority-Analysis: v=2.4 cv=EdbIQOmC c=1 sm=1 tr=0 ts=686f7fa1 cx=c_pps
 a=Im6zT5tXWloa+1LbjvLQdw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=qN5ve3sCTOSH2ZO3jx4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfXxQyOuyRQ1kAg
 OOfIiMzw4Bg0HmxSKDa04KVQN8A8RjrlOvbjt8HRCjiP7DWCBPGLWET4uDqnXI6ueAYUj5bkLEv
 h25lsOtSBYFthE4RmG2oQYIAq16/3jBCBnJmxFs+lmT+b95XlMCQIV1gPRFEeShnQoI4l2mbnWY
 aMgKKJMisgngzYI/b3pNfaMp7uNNEuylojT9ZPfOGnrf+4137aUVX4zgy5jVjQui9gKzWGQ7/4A
 2A3iFkXVcFs9hy7gNVlAaGe1IqjA/rHU76H8aet/8EYWTI8XenqigK9vWVzs76zGvHNGramvFkS
 3IQL9aaaPI1SUhFh5JLdjM379qwY4CTp4exbEOEzEV8n1oMfiJQ2Qog2igy/rp0uhL29dTMXaMH
 79FZk/bcC+R20A/nAvTABe4VeShBoFI/hXQjqRo8HmTaVaz9wHfye/CCjdRiAi2Yp166BisF
X-Proofpoint-ORIG-GUID: Eg5xFZJcIxoHxokzovdeGJp_tzrC-vra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f09ec48c0c..9832b5d6c4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,6 +426,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -500,27 +502,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


