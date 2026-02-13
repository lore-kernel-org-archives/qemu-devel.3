Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4311EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvVY-000653-Bl; Fri, 13 Feb 2026 10:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvVX-00061Y-2c
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:55:03 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvVU-0000cA-PF
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:55:02 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DD5KN4070776; Fri, 13 Feb 2026 07:54:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FsCvJiRMSL7aOvGmXkY3vgmIwpx6QHeN/PRukCQQk
 SU=; b=bfzc62H9PgNjVCvCt6QknWaFaQKtfYNoVXXa4MDjyEtfdsAjlj+cmx0Dl
 ONvNMiW5uPbnk80c5s32/TO5ieI2eJyn00Np5RgwEgsQ7l+UcTyKDe9ky1j7LdoR
 JRJwNhXEovE4x7R0T+thX0IeYGqSB2Qxi1/KHcfim3hEbZ/QxpIZ8JagBmnjfhVk
 cLmWpDFP8uaSr8cZgHv24+zKMgP1JVPQ0LLu0erdDS9ys5Ud5QBCPy/FKRExAVCf
 /tPyJLgI/bc4aPSiyd0xZZaXQz7bxbEmeFDUAJ2PG8p3Pt2gwwzIMwWVZvyrBqqo
 /mIc6tgLcReGW/rJpJ8dFHPH15UvQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022095.outbound.protection.outlook.com
 [40.107.200.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9u9f9r4k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:54:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gE/Iu958cO2GLFiu2J3oGLGK+/LW7h7YesVTDeQwzseLsvlra5VPZkf2mGOFZ9UvQj265WszX0oeA+NcIIHS70uvG2omKoyXWI9tW4l9Cukz85z/YnnCQZWGNF8ZS0ESUDyFm1wsW1/Dd0+VH9vji+6owmR9O1NRTWHynM4icZvA8PJoURKnJmI9DTZVr3Mex3krz6Te8BupPjj25LK851WY4lwRQ9s/PDpwo3vE5055q5lP4WZnTlzcweE+SkitjB3JH0o/KHrcGbV2anm21i2W33N9kw+7YAum07ieMcK5cl4XzoKIAfF0IESAcfozmb/Bz2oJmcNNQ6Aw59tWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsCvJiRMSL7aOvGmXkY3vgmIwpx6QHeN/PRukCQQkSU=;
 b=Fh5mRHw4Hd6jxI0npMvLCb6EqmEBPgq9R8dmZCr0wa4XLOoQQWqWT39rIJF37o65bZJOL7qE5mIcHYgfcoASgyW0y244rljdtzeIVoFSw/TAQ/rmupzISD7xjoP1QaBiRUIWZ5pVwE9UaWqoCjGnQPixnllFOJuJHYRzQyJUDVi4xYr+BFofQNk//xtWTpIMhiI4W6YN6Ici+vu20SHGPr+GerqvPqIZlwZE+4/MEgveDFpfaEwxBMiPlEFt7LFtcSWWFje8PbSQov1qd7DqrvSufne2k5xZ+aWv3C0PrnLI3hjyVUxRQKBWVtAP5A9bq4tkeNtsNfBIOCx8x9k29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsCvJiRMSL7aOvGmXkY3vgmIwpx6QHeN/PRukCQQkSU=;
 b=eWbDDWHsY26bu3fNsOMvzVLTkM1D19Tgq1mf1yp6t6BALX/6a6Vt83nXWwmfjvI+ntR0R6+k7GbtTvWrAbZH55LuOxMs+1ksdCCZgtcoa8VRehR9D5PqQUtsuxYX/thk3g2TQb0FdJQFaDLiegPSCpB8+PM+Lzacpm4sCqC8yUrS0BrcKGDEwd72S04n4dIuF23gP1f2n6qu+ToSOj8djW/yLfcYGORZ69Qh1do2TqGu4rSKUyAMLG2ypoJJVLPgUu5n93X8ThkkAk8fwgmQw5ysG6P5Akp+1/CqJbzV8cJhHLHJdrvMj1D4+nH4p22X14aJR02TvOKRwEqk/Nhn6Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7866.namprd02.prod.outlook.com (2603:10b6:610:ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 15:54:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:54:54 +0000
Message-ID: <8ed99f99-5ade-44d2-9179-d54a0b304073@nutanix.com>
Date: Fri, 13 Feb 2026 15:54:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/43] audio: replace DEBUG_OUT with traces
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-37-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-37-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:5a::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b520479-3800-4ee5-d4c5-08de6b183a7b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1VnaVhpcVUrSS9kUThFWkZXeWpVaW4rcWxvV2JQRzNPRkwxSnAzQXZWVTk2?=
 =?utf-8?B?SDRDTzh1TG0rd2puZVBEZURORXdZakVVZVhuSDBwMFArL3pSMjhPbW42eDgx?=
 =?utf-8?B?L1hRSmF6bXN0ZzVQWEllTkQ2Q2h3elIxaFhXVUJORytmMFlBeDhkaHhudExD?=
 =?utf-8?B?cEFqd0ZsaU5ZRGlSZUkrUUEyMmVQcEtBWFF3NTc5b2FycEd0WEZoZ0lIREhP?=
 =?utf-8?B?SmZZVVJYeFEyUjBHOHZRTk5QZHp5TkllaHNiUCt3b3FoMFAzSktlTGwxSlRO?=
 =?utf-8?B?dmU4M085OHRENkcwZEs4dlBwTEJWaVpzcmFnZzE0SytwbGhXS0RyeS9HL3BI?=
 =?utf-8?B?M3hycG1mYTd3SUZORmJnS0F3MjU0UjlHK2ZNZjZHVE15NWZjVFdmd3dJMnpi?=
 =?utf-8?B?ekNmdmhUWFoyYm1zV2FoYm5Qc3c4Y2I3U3NnYW9RZjRMd0NLc0xqYTVtZW9B?=
 =?utf-8?B?c2NaTkRmbkp3ODNHMGltcG1ZQVRPYStWallxSm95aWIrd2dvYnFvYTRVcDRF?=
 =?utf-8?B?TW8xbDNrS0FaRjREVWlITXRtWmcxMmYyd3VzMkRjL1dtc1p3d1krTEhBZUdv?=
 =?utf-8?B?RXZLc0hJUDlrRVovNUdGdmMxckpYK2wxbFFtckdOM2Z4d2dXOEVQUXJkQ2d2?=
 =?utf-8?B?WXVBZ1Vva2dPcDkxL01teXRvVnNxZDJEUXoyejFQc21tcjVLTEk0d2xMYUJ2?=
 =?utf-8?B?akNrZks0WFBBSDkyLzhTOHNKeFB4NFJJZEFyaHhXVEJKMGUvT2tneTJtVmRu?=
 =?utf-8?B?cStqbTMyNVRYR3JIK0dlMDJuM2xPZjdVV1ZiQnpLRlVNMkpOZGt4Zzh4Nith?=
 =?utf-8?B?K2RxbU0yK3R0RmJyRjR0cnJVSWJMa1MrMlZ6bjkxcXE4UG1sNTdmMDFZZmF4?=
 =?utf-8?B?UUU5QTJqRHE3Y2xZWWtFWUkzSlhlcUJGL085bmExSmhHVjd2YmdSdWtBOHhy?=
 =?utf-8?B?SFR0YXBYczZaelNiZjc3UHhSbXNyN0JBTVRsYXhFeTF6Uk1sTWhoNStzR0Np?=
 =?utf-8?B?dkIyaWhhTXp0aUtvL0RWNUp5anhMRC9zNGJuOFE2Z2RnNlNaUkN1R2hLUXVE?=
 =?utf-8?B?azM5SlNvMytVR2VKNmt4RlBLVFVtcHNEZEY3Nkw0akpkT2cwSjhRdTVtRXJo?=
 =?utf-8?B?VktmQVVXajlTNWhLd0gwMkFVZHpsUGZyK29BNlhpM3JMUHlSQ21tdjFENTBJ?=
 =?utf-8?B?YkV0T0FFeS9jUW1xT0NoN1gzakRTbitxS3lhYUtRRE1pWlZHNEtMWGFTb0hJ?=
 =?utf-8?B?ZkNIZzZPTlRwUW5DYWxIN3RvYmoxSnYvdnRhYURCTkxIaVZ3WVZmREVPQ3F2?=
 =?utf-8?B?bGZyLzNRTHJNM3lGbzMwVHlDTXVaVC9JTE1xUDhMNnQ3ekNPTHFrTzY5OE1a?=
 =?utf-8?B?b3V3WkExd1RZTXZ5YWFRYlRDQXhFQWVSRGxDZHBYT3J3SS9qUU9kbU1zbVIv?=
 =?utf-8?B?bzVzOXB2MUt5WjQzSDRIUFJIa1JZVUp4V2ZXRW9KNlpFakl3ZElqNEJSSnRO?=
 =?utf-8?B?NDBFQXFyYkVoVjd5WGtLd29BdURjK0pOMnQwZ0t1NUpwSU8yNnp1TlZMZEtP?=
 =?utf-8?B?QndVYWUvU2hLeFVLbGpWd3RiOFQ4aDFsbnIvL2lRZGp4NkVXVXJCMUtQNFRz?=
 =?utf-8?B?NGc4UEdncU9Edm5UQ2p3d2J5NWJlSno0ZVcyR2g3N0taRnN3K25MOHBBMXN2?=
 =?utf-8?B?RGc0dVc1TDlpQytTVTBJTGVqN0ZGWEIyamYrN2VYRzJtaXhVTHMwMHBDcnZr?=
 =?utf-8?B?YkhDOVZPSnFGdk8xZ2hMcytBSUVwa2NzVGx2Vjk3cmtJb3I5bEdRU1lEdmtl?=
 =?utf-8?B?L0JKb2VVLzQyK2QrNjJNY3U0bmVxNHc4a2dmUWpGdittVkJDb2hzMjI4MCtT?=
 =?utf-8?B?ZnE5S1kxUkpENGdySnFKb29yOS8vcktKNC9uQXhWZnB1S2JBR0pXVUR4NWdv?=
 =?utf-8?B?alZjZkg0b1hya3UwMTRMZjUrQmlHeVFiazMvWk8wR3I3MlQ2MDJjYnZwQnds?=
 =?utf-8?B?L2p5N09QbEhlWDVZOVNvNm1ON25UMUdFVkkrRUpLSGpmeE1NSFd0TlNEeXRQ?=
 =?utf-8?B?NFRPSFhrUTRvQ2JKSitSZCs0SWxGaHI1M0ZhYWt3OFFUNk9QQlgwNU1EQyts?=
 =?utf-8?Q?C45Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFR2Wk5NZEJpRFBObkFSc0plMEtzUUFKVTZKTS9yMGc3bTNYa2Q4UW90SG5y?=
 =?utf-8?B?eGtpYmd2VThjSVN2RlVVeXA0QlgrM3B1NngxTW9LWEhzM1FxaUx3ZXlIMEFW?=
 =?utf-8?B?KzQxOWZlMWlTcUZyb25ld3oxc3p0RzUyN1Zncmx2ckpHV0Z1RHNjS2dzNUxH?=
 =?utf-8?B?VGRFNjMydEdNSGFhUHNHM3F3VEhEbkwySzJVdUJ2YTI0VFVjeEZzT0QrakJP?=
 =?utf-8?B?UFh6di9KOWpVZnlGREJsY2FKbEZRdnBDbmlXYmRtc1VTUll1NjNGdXVOS2Ro?=
 =?utf-8?B?YkFtcG1GeWJDZ0l2MXQyRjFhVVJsYmg2bWNseWNjKy9JMFAyYzk5cGIwOUIx?=
 =?utf-8?B?Umg3K09zQ0lQQUJRMlNqZXdjOTV3b055L29Pd1dHTUUvN2hvdWVVSHV4REh5?=
 =?utf-8?B?SXRIQllKamJXajREWlZBYVJYSTRnaGlOTmNsNW9WSlpYazQ2eGF0czZMSGk2?=
 =?utf-8?B?YlFtaGZHaTBtZ0oxZ3ZNSVRqRURGNkh2R0QyVG8yMWFYay81cjIyY3BtcTBW?=
 =?utf-8?B?bEcyZ09BbUFyMExRcDdGczJwdkJNSE1QckRzdGtId3g2UWVYVGNLYmRWaHp3?=
 =?utf-8?B?YmtUTXhIbmNxdVJLTEN0N0pIbnhuUlJGQjR3eXFPVmhtTXl3UEJFVStKdFFY?=
 =?utf-8?B?VWRCTU41UEpGUkpHVFd2YUVhbHlFdW1UTHN4T1cxU2VqcXowbnFJcXltRm4z?=
 =?utf-8?B?V1hCL2dhZ2hHMkY2U0tXMkdZcTR6T0VzaDcvOHlZbFhTaitUQXo5eDd0OGZa?=
 =?utf-8?B?b3dGKzYxNWdXMlZIVnpIU21lVFd1ckptQWMxK3lEWW1uaW5wblIyOW51UjlH?=
 =?utf-8?B?emk0KzVkNEZDa2N1YVVoR0QrY3puMWFOeS9CTHJYVHA2YWNCR05MMVA1SmN2?=
 =?utf-8?B?S0Q2ZVpBd3o5d1k5RVZQYmM2eWk0VFVHR3lvaTJzcVovNUJKOXhGSVZBTlla?=
 =?utf-8?B?TWhWbXh1bWI4Zk52cWZQMmdoSEFaYWdVUGRCY0M0Q1FDTUlpYk9zVXUrejg0?=
 =?utf-8?B?K01ISmJxRXVHdTRLVGtVM2lUeU1SM0FxUmJxMEtNUDVSa285eDc0WWl5d2c1?=
 =?utf-8?B?VFJrWVlVN08vSDZvcDQvS1RrT1RHOU1ZRVVvamhwWFcvOEQvM29CaDd4STBE?=
 =?utf-8?B?a2M1M3hrUkJEU2lzUjhNMHBJRjRadnZaSkhSKzcwK0F1YkFrN1RrNXZRNGtn?=
 =?utf-8?B?M0hBNXM1TEoyaFZxa1AydHhJSDFGekdRWHdVZ1puLzhCWjE2RkJEbTVHMW0r?=
 =?utf-8?B?d0wvZFMxaFZ0Q2ZoOCtqdVIvbGl6ZXFHNjlpV2ZLWUhYUldKRUVlaS9oemRm?=
 =?utf-8?B?SHdCbmdrYUJxWGNIWXZNQVhIOUVSY2U1ZGxzaVJOOGRtVTdQYUMrZEJoclZ2?=
 =?utf-8?B?WEQ2M1d1ZmNHKzFwV0toV3FGWVFPYkduMi9JMk1jdDVxM0dCN3RXaVhmczVo?=
 =?utf-8?B?YURHK3dMUTJwUm1BTU9WSEdUdDI0TU1iazBRb3VUSEZmUm1yUFVHMHVZN2hr?=
 =?utf-8?B?UmJtanVVaFRtS28xbXkrRnBQVUdMTmpBbzJtenh2ZnVVWEY5Q2tGa1hRN3FK?=
 =?utf-8?B?L0NwNXl1bXpXMkhDemtVZzV2YVAzY0xxVFZwVS9lc1JpKzRjSWRBYVZzcjJZ?=
 =?utf-8?B?YVhLZWkrWWtSRHFVMFFsVVBCRXlZNzUyeHU0R2pjUWtmRnlrZGpKOFVtQytC?=
 =?utf-8?B?bmtZTHdsb0dyTDNkd1YrSHRkZDc4VHpDbW1rNnB1RWJMaVlOMU5zdERSeFZR?=
 =?utf-8?B?QWppSVFhdzJWVEdwZW4vUU43YkYzWHNISk1TaXVSNXJMSFE2RURIRTNNcHg2?=
 =?utf-8?B?MG03dG9xRjIzaXdnK2VKSXNTS1A2L040UEZkT2YvQUZ4ZjdyOFJsTDdUYzVr?=
 =?utf-8?B?cHVLNGhYU3diM0RiY3V1TWJwL1piOG00NHp2Tm1Bd01yQ05aYlhDRjcrVVFx?=
 =?utf-8?B?RlZibjBycHRNZ2hvNktXMlBGckY1S3FxYnpKaU9nSGt6N3hTZUNlckNQRkNs?=
 =?utf-8?B?VkxHNmJBSCtqQTM5YUZvczZ6dzVQYzdaTEJURTdKRU9yTGdEbytFVE1vbU1w?=
 =?utf-8?B?OTEva3NYc01JM3N6WkRxTjBlZXY3L2lvVDg3UHVmTlJxUUZZTmhEL1ZNUDZu?=
 =?utf-8?B?aUI0RVpIUDMrR0hXVzN6WnNlWGdtUzhkSVFZZTRYM1R6ekU0OXFBcDZ6ZnFj?=
 =?utf-8?B?cit3U0YvUHkvUDdkVEYwMFRndktYUG4rNjgyenZEa2RFWlplZ2tYZk9zalBE?=
 =?utf-8?B?VzdGeHBHZlpzK2ErOGltNW8xUXhqcFJ4Zkk3SXhidzVmY2xsWDdMWFVyR0g5?=
 =?utf-8?B?U29Sa01uSzNtWXNsRmV2Z0ZCYmlSVHRHTkprOEsvUXVzODFHU3VvZzBmMU9G?=
 =?utf-8?Q?hLm68cb6dxG8ZpvE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b520479-3800-4ee5-d4c5-08de6b183a7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:54:53.9164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWO7O2CQzeag6VElIs+riAyqz1/1YAEjwrmaGO1mAM7BUV911GCJNJJC+Bv9NfP7JJGUgmTUwzh9YDcnksm1wOSBnoqz7KQgOPie7mMdHRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7866
X-Authority-Analysis: v=2.4 cv=OuBCCi/t c=1 sm=1 tr=0 ts=698f4951 cx=c_pps
 a=jEVDRQfOmVlFoCNyrWPCQg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=Dk-NcpEWct7uX16xWwEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IICTaxgakUSuEjy686MmOattpjEeh0-_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMiBTYWx0ZWRfX03akH5zmhPyB
 jQJ70UJk9zs5BLMy3XmbLCPetKptSCpT6Xmn04YOAx5UlmAV2bEA/7OMe5Cak8gbxb28fm45vzS
 4JuEy/pDLzvb2N4vcNIs3jNF4nS/+g6wupTrwYhNHyYy2+aQTZnBTVGP7TZF5ImBtXfq5NCRsE8
 5AwgdPKfcojevUVQZGCST19kydKHMk5Ze64nYAfeS8aMF9sZqZvgO7CvwUuE2BqPycISeyYe5Qg
 Ek+2ZXYzrwdDvqbjmb7UdB+I0qm12xnXbWMRLjV0Mti5Y7STPXnw5JfjvVFxq9F+Rcvb+Z+C+cy
 ASrnE+Gq4NhgffpmpOs76XXdnM8FpOGGReezjZNGg1cMVJMfvpg7fyYuFrOooowXm1j19m6VVdW
 FB4EpNKHhJ4lKLnX85tb6xVJta1xU4isjJT4+/aBWUSYE1l0fIrdvQbzZo2J+t5wjnSasyZ69gG
 ILPSU718mPFDy2qFWdA==
X-Proofpoint-ORIG-GUID: IICTaxgakUSuEjy686MmOattpjEeh0-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-mixeng-be.c | 32 ++++++++------------------------
>   audio/trace-events      |  5 +++++
>   2 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index c3234aafb1b..5303c08a285 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -29,8 +29,6 @@
>   #define AUDIO_CAP "audio"
>   #include "audio_int.h"
>   
> -/* #define DEBUG_OUT */
> -
>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>   
>   const struct mixeng_volume nominal_volume = {
> @@ -568,9 +566,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>       }
>   
>       if (live == hw->mix_buf.size) {
> -#ifdef DEBUG_OUT
> -        dolog ("%s is full %zu\n", sw->name, live);
> -#endif
> +        trace_audio_out_full(sw->name, live);
>           return 0;
>       }
>   
> @@ -618,15 +614,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>           sw->resample_buf.pos = 0;
>       }
>   
> -#ifdef DEBUG_OUT
> -    dolog (
> -        "%s: write size %zu written %zu total mixed %zu\n",
> -        SW_NAME(sw),
> -        buf_len / sw->info.bytes_per_frame,
> -        total_in,
> -        sw->total_hw_samples_mixed
> -        );
> -#endif
> +    trace_audio_sw_write(SW_NAME(sw), buf_len / sw->info.bytes_per_frame,
> +                         total_in, sw->total_hw_samples_mixed);
>   
>       return total_in * sw->info.bytes_per_frame;
>   }
> @@ -900,10 +889,8 @@ static size_t audio_get_free(SWVoiceOut *sw)
>   
>       dead = sw->hw->mix_buf.size - live;
>   
> -#ifdef DEBUG_OUT
> -    dolog("%s: get_free live %zu dead %zu frontend frames %u\n",
> -          SW_NAME(sw), live, dead, st_rate_frames_in(sw->rate, dead));
> -#endif
> +    trace_audio_get_free(SW_NAME(sw), live, dead,
> +                         st_rate_frames_in(sw->rate, dead));
>   
>       return dead;
>   }
> @@ -1058,9 +1045,8 @@ static void audio_run_out(AudioMixengBackend *s)
>   
>           if (hw->pending_disable && !nb_live) {
>               SWVoiceCap *sc;
> -#ifdef DEBUG_OUT
> -            dolog ("Disabling voice\n");
> -#endif
> +
> +            trace_audio_out_disable();
>               hw->enabled = false;
>               hw->pending_disable = false;
>               if (k->enable_out) {
> @@ -1089,9 +1075,7 @@ static void audio_run_out(AudioMixengBackend *s)
>               hw->mix_buf.pos = 0;
>           }
>   
> -#ifdef DEBUG_OUT
> -        dolog("played=%zu\n", played);
> -#endif
> +        trace_audio_out_played(played);
>   
>           if (played) {
>               audio_capture_mix_and_clear (hw, prev_rpos, played);
> diff --git a/audio/trace-events b/audio/trace-events
> index 3f8ebf9c6cb..7a73d6eb84f 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -65,6 +65,11 @@ audio_capture_attach(const char *name, bool active) "capture %s active=%d"
>   audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
>   audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
>   audio_capture_free_sw(const char *name) "freeing %s"
> +audio_out_full(const char *name, size_t live) "%s is full %zu"
> +audio_sw_write(const char *name, size_t size, size_t written, size_t total_mixed) "%s: write size %zu written %zu total mixed %zu"
> +audio_get_free(const char *name, size_t live, size_t dead, uint32_t frontend_frames) "%s: get_free live %zu dead %zu frontend frames %u"
> +audio_out_disable(void) "Disabling voice"
> +audio_out_played(size_t played) "played=%zu"
>   
>   # audio_template.h
>   audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


