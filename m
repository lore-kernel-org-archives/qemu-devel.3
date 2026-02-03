Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0553AE87846
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJ13-0000gM-Ri; Tue, 03 Feb 2026 11:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJ12-0000fm-RC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:12:36 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJ11-0004Vd-8F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:12:36 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613DYSHN1458945; Tue, 3 Feb 2026 08:12:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4J+E6VdhFs/WhzX08FvQp0544vFn00tXUZBThyJL6
 s4=; b=byspn5Hv+0KefzhyQimsJpIlQBAYzKZ1naiWMX48jvTs9iSsPxldE+vpk
 kVozm29EhCRhcous5PHLaVbWmOWkCMquFB71fHjqaFfyN26/fihx/+5AYvBMnMV1
 kuZzyT+XwBR8jMPddoOxEum4WNKR2GpDuaWhaxTqbOROqPNmJO3xvVqr9hXvx4MM
 Y64ZifeTwGcEFqcMEcu7ST4xlfbGtE81uP1JBHhjTE8culsI1BfosHlbbYqWhmDQ
 QYpOor8kj0GZdiPyLcuhz41ql8d3C4lagdNxkLBbb8gmBIqAYEi4PHFoVDrdSTDL
 Vj1ye55wIhDcVI3XQpFr+59t0MBGw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023098.outbound.protection.outlook.com
 [40.107.201.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3b029fe8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:12:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POLobUNtHUAPj2WwZSn7Q3uVwl/45zxkKBh7UdQea8qji8VzJv1T+bwaT340MzUCE1NzCm/9HTPPDHi3dwfq4wD5YRj1iDChf9f/5YjvOenBPXEjqUz7sVeFEIYUwZdZpmjQqw29LtWVKlTUEsISCvAre6ASxFY2vzfriWSxW4bCn5eG0L2xuQRQzqPUMDw7U23dIm87Wztybq9P4Ub9Fm/2ZXpShRfvCkboJTeGKV7rbSJsgDLIH+DQNa4KOQMa4RNQboGLz4yVaf+cUXgJH0WWw01PBk7Qi+lzb7+cy3J909mYUbsXL5NMy7SMvQYFNm+j0xKPThn5+ZBp/xupDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J+E6VdhFs/WhzX08FvQp0544vFn00tXUZBThyJL6s4=;
 b=gfxXUOyJlBb+kPcMKo+af5iyxZdfzaaqn8pUQ3Pjen4edF3isk84IQd1B+YwzB3uDUyb0C7dma2MBxgukL2Ydramc2iI16tFpcLC+M60YOdyXTpCS6aK5BI+FjEHKy7H0AepQJvtwEId71zOKzNX1H/zPzvau1E1LR5PISj77UQYPKbEgf0Z6BWQVmiCki922Nh3TQRzIX4QRxFzvRKBzcxTB4k90ZG4CUQ6c7ThjCv/deF6K2iSmydTldLn5Vw2sFba6IpTM6fPTdMFdvLtwPq1pka/Uitq+/thCj9xXGVhrhb6jesWisWclfxr7PeEGnkK2dGNY4dTT8oziHfh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J+E6VdhFs/WhzX08FvQp0544vFn00tXUZBThyJL6s4=;
 b=eRj4e+DSR6NwZ00YA1rdUZO8xR0fUiLKWYqYo381nS5obt2anStukK7QdxO2lO2Xcwvm53jE5CQnaNKFEtACb3+gGCp8NbV+YxnLiCnt44vR+/4h9Qm3DyI4EvOCfFhpFda7Wxa7+MRDNgVmwzDourIUaskR4x05ToYA/mL4AAi5jQ0XwCSNGMGvpp0V9TYh4EWKTrX3yQEdNf211nPWRobwkKsSLXHU5BFWXHNHbPHx5LfSbqs9o+dM5hEWDVtoQHDy2ciSGe4pq2cggYMxCydUzFdkKwEu+APlOapkCwww4d8XRqtxoksjPdW/Yb18dS0thyHSMdk6tzKv64KnpA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9669.namprd02.prod.outlook.com (2603:10b6:303:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:12:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:12:28 +0000
Message-ID: <0becd0c1-d36e-47d7-b139-e1075e15bd6e@nutanix.com>
Date: Tue, 3 Feb 2026 16:12:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/37] scripts/modinfo: use argparse
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-14-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0190.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: fc94e85b-6db4-4c59-37fc-08de633f0720
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWptVTFpSVVzS2xwNnFub2Y0YmFoK0JDcCtPSGhIYm82QlNlUk1ZRWpSSW82?=
 =?utf-8?B?K1l6ZFFyQWdkUU1FdkNaRG1JanUwcXhQTkp2TUlKMEdWQTVFSnFJcjgvSmZX?=
 =?utf-8?B?MWRNR3cyTUFvUExuUkozY0hXdVNoaFFzQ0g0Q0E3b1FHU2U4cVJWNHY4aWMr?=
 =?utf-8?B?Z09zL2dNeE12SXhKUHI1dThHVnBiVFZtbWhEZ3plbXJXZTlOTmhiZzJJVXlh?=
 =?utf-8?B?TnJiK0FHZGhrUHBsbVBVVnFOL2ZPVFlwTVNzQ2lOVTdreWVzL2xVTStqSitU?=
 =?utf-8?B?QXRhQWh3ckJ1d0ZWcWdEcFU3YWhsaTdTaEdpUkx6Z1NkSnRkT01rb0NZK05N?=
 =?utf-8?B?K3l2elZXRmpMc2h1dDJraU51eERidzRNUHJTWEhkdzFkMW5SS1Ewdi9RY3Vr?=
 =?utf-8?B?LzlmSk1HTFdwUEVGMVVHSm5sWkhKcmNDN3JGUk4vOGVJaXlXOXZwVHkwQU1u?=
 =?utf-8?B?YmdBei9oK0U3MkNMcFI4bTFiMTl1YXpBWElXUFVtaklWVDlhdkJPcEorUUw3?=
 =?utf-8?B?a0pvNkYxdlB3QmltU1BnTG4rMzltcXg1QmtGQ3UyK2syRlRmRG8xUVhBd0NI?=
 =?utf-8?B?ZlZ4MEg5US91d0hmbGJVU1V1T1RZMWtuWURkdHJMdXlYK2VDQmgzeVZ0c29S?=
 =?utf-8?B?MllPTGZpMnJSSHpmbm1IWEw5aWYva2h6b2I0ZC82V0dmWllWK1RIcGxLKzNa?=
 =?utf-8?B?am9KM1p1czYveHhFck85N2g2WHJMa3FHVWpmZUp3bHNaclFiSXVRSjF1Vk1v?=
 =?utf-8?B?NE8yaDM0dVFpUGNKZFZ5THJlVHRZV1ZPT05aTTVlbXJtdVVmVVJSbU1iY0kr?=
 =?utf-8?B?Y2xLNmgxQVJxZVRwVTdCMUp0TDRlTG5HUno0d1NlWVJwUmgvWEVnQjB0MDhy?=
 =?utf-8?B?a2hYbGh2YXBBNnlqNDFGRHQrOTJDaHBJQVdydDg3L3I0QURTTVVmN2pVUThT?=
 =?utf-8?B?ZnlrR0ZrR1JHWlllc1FmbEUyMUdKNVNsNlpjSkhha1NBcW0zY3hDSXlTelBp?=
 =?utf-8?B?UTFsbDJxWFdYS3B2b2hZWGdpUW1ZcklBYzQ0N2JONVZPWVNBcGNLL3JlV0hl?=
 =?utf-8?B?VGk2anhNaXQzNDR0b1JkQ1Y5K1Mxc21RYnloazhUWHJuYkc2NjZRcnRuWXdl?=
 =?utf-8?B?UlVwbUhxR2dVMk13VFBQbmI2bkFSWGZwNURwZ3VINXlqU1BITVVESkVBbGFr?=
 =?utf-8?B?MlRmUEp3SHAvUjU2Ujh0UDFINkI1VVZvd1ZLS3NuOTJ6alNiT1lYcWt1TVNi?=
 =?utf-8?B?bTNjOThKc3laTzQ5cmVxQnU1SkRrZ3lEOXYxeWgyOS91Qi80OEszc1l5bytE?=
 =?utf-8?B?U0dNY2NxdnNWNUkrQWhQRjBsL1pCK09qWUpJNmpGK1ZXWVV1a08ycEk4cXJu?=
 =?utf-8?B?bDYxOTZzdng2ZVdWbm9mMzJUYUVZa0JCdEVDYTZZdmcwakdrcEplNzh3azAw?=
 =?utf-8?B?d3hEWGpBRC9DWEhCeVVaWUh3TVJacVFQVVBkdzhCMFVQaTZqaXJvNzFtc0k4?=
 =?utf-8?B?QTlBaWl6cFlwcDZwUCtKSTlwc0FPSEM5ZlZIWTIvNU11R3hETGppYXNxZUVH?=
 =?utf-8?B?UHF3WWhjb0x0REZtVkpCRExJTmNBY1p2NTZ0YVJ2MTFBQU9Vc3NLZ2c3YW1I?=
 =?utf-8?B?dEV1MzdvdUVvbXNlTW9YVk5nVjU3dDVGME0wVjBOdnZjdnhkS0dadlNKWFdP?=
 =?utf-8?B?K3YyVGNnME8yZ3UxM3pVSGdvWkE3N1ArT2VsRVc4cENuc2Y3N2FhY2lRZ0tP?=
 =?utf-8?B?RHdaYkQ2ejRCM1VVVGZtOEU2ZDV0RHphekorNTc5UEIwMVJMSHo3Wmg0MWtC?=
 =?utf-8?B?cWNmeTJlSk9iaGQxQ3NBZ0ZLcSt6YloyOTZLbVR0bzc5SzV5aDBuUzBHNWxl?=
 =?utf-8?B?ZkZmNGVodjQ3MlNnQ2JzRTFHbDdSMVlqVmNZK3RnSE9nUnVvakZodytwL1VW?=
 =?utf-8?B?RllOR2ZuNWR1T0t5ZWpZdkU5TzQ4WXFBNVNkWk45VXZqM0Radmo4cTRDVE1R?=
 =?utf-8?B?MmUzcTc0SE9HZnpueEl1T2FiTVJqS0w1WEF3N1U0ZDgzTkoxUHJ5ZEhNNS8y?=
 =?utf-8?B?KzAydVlibjZ3MWVsbE5CZmdFVFpOSEdmeHQ3N3g1TnQ0TWpybW9wTWI1LzNE?=
 =?utf-8?Q?55Tg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGl0MVpiaFVFZUUrakVTQ0dSVUwxR0FGWG9XVGV3Y0VlWlJRTlBKd0tFMVRs?=
 =?utf-8?B?WUNENWY4Y0hkd0tWRERKb0VudklmaHcwbndyL090K2VpMzE0QmlpREdTNDlh?=
 =?utf-8?B?ODBVZHpYUTRNQUo5M0R5cklGUlpieFlzZHN5UUo0b3Z6MEZ5YmhhNTJGeTZy?=
 =?utf-8?B?Rmp5MnNveUJKM2dGYjd5dllMY3BtWWVZOEtUem8zY0Fjbk5tNlJ6V3dabkp1?=
 =?utf-8?B?SVNrT2JIV3ovRFArZnZQNXNVdHlYb1p6ckN4ZkkwTnZNNk5FZjhtNG1DajhU?=
 =?utf-8?B?am1UM1EzaUV4RlNHa2ZwTmRaZHA4aDdEVnlsQU1URW5DeEFLT3RudmJzMDhv?=
 =?utf-8?B?WFhLMHFMTE9NUHk4ZFEySVpUZk45ME9jajVoS2NsQ0grTVU3RFl0MVhmQVUy?=
 =?utf-8?B?RFNOaWNWUzhPSHpDaGNBemJYQ1pCaXdyNlJ0bnZnNWVwYmZrSjJ4c2FsNnZB?=
 =?utf-8?B?aDI3WlZzSUVWZkYzSGcxMkh6MDlnbVIvY1ZHZzdpZWpLNW9ITmNhUTNNYm9s?=
 =?utf-8?B?Z3cvY1RSMEN1Z1luc001QjhBMllyYUl0Zlh1d2txNmdRUU5UUDIrZWlVRHdZ?=
 =?utf-8?B?aUkxZXVwSDBtZWZ2UjJ2RXBLTXhmSDQrMXBYck0vc1BCcy9zWE1zUk9rQjRm?=
 =?utf-8?B?R0w1R2xWTXp3QjJPbXY3N3Jnbk9rS0NwdVI3QVFYUGxucTV1aGh4ZXJ5U2ty?=
 =?utf-8?B?UHVJS3pWcXh3ME8rbDZaWXBET1RYcTVWOHBJTk1sTnBWcVd5L08wVUZyUTdL?=
 =?utf-8?B?Q2hEZ2Y5TkJRK2FSSWE5TjNmMVZLU1NPNDB6aVNLUUxWcHJlOUJUUEtBVTk4?=
 =?utf-8?B?ZU9yRllqVUNld1IvbkJSNld4N0EzR1ViMXhCWFhicXFRQWZvTWphTERHeEJp?=
 =?utf-8?B?dzB3VG1zMnhsMUcyNUo5TldSMkRKaXdEZlpJTE1Xcmc2WWRTbGR3NDdTVXJo?=
 =?utf-8?B?S01zblF2YU1sS2doamZiM1htSTViMGhxRkZueW1ZMXZqVThVVVBkWkFtUjBJ?=
 =?utf-8?B?OXF5VVdWMGNxZ2lwaHdCeDJ6SkpXSFJDay9pREg5MzRCMWhvek1OL2ZiaXp3?=
 =?utf-8?B?aTBydHVzUE54aTQxZVRiZUF2Vkd0R3o0c3ErM3JyTjY2UTRvSEp4WDRsbmlt?=
 =?utf-8?B?aU1GNXo3dStUTHQ1WU04cnhTQzIvbWFFaFJEVXM1bEpkYzk0c3JBM2VyU081?=
 =?utf-8?B?VXdCakVFYkJwMlB2b09jYVdxczBNNDFRV3JlandGczUySERmSzgwN0R4ZHJx?=
 =?utf-8?B?bWM5N1QzYkMvREx0RUYxZjFwd2Q5ZzYwdjFyRFRXNkVTdWNGeWRrLzBNU2Q5?=
 =?utf-8?B?WmVLNlU0VlFWYWlseW9uRFhKc2FaV3NsaWNWQ1hSUlJkOVlsa3FjZU90VXc4?=
 =?utf-8?B?S0pxSTNlcEFrb0tKQ1B1cWF5L29EQnpUSEtFN2tUQ1lWMnRMSWdkU0FSenM2?=
 =?utf-8?B?cnNPYjNMN2RpeUN4YXpJTkRod3o4ZWJmUTZrQlZqc1ZrS2liUGJyOG1CaklT?=
 =?utf-8?B?THhOOVk5T2ttYWJSdC9GNDJpVyswZUcvMCs2QitiNm4zQm1XcURkVnV4ZGo0?=
 =?utf-8?B?cnlvY2JXaE1YK2pqL0NWYVBXZE51UVBIWWJoREZZMytuMEhoOUFsb0xFWWg4?=
 =?utf-8?B?Z1NXdk1MaUdlVUdIcmNPMGxhb0NlR2ZTNXUyTEVkNmFxYmdoVy9JRCtEU1lU?=
 =?utf-8?B?WElNdGpLTWRXdDdGMVFsWWZnU3FSNktCZldjNlcvREp2ZDZOcUVpQlV1T2Er?=
 =?utf-8?B?R2pmT1BXSXNvN1lnbDY1NS9hUVlIRlJwTCtYMFkvUTZSakJ0aE9CK1Jwazdy?=
 =?utf-8?B?M214VE5MSVpFTHpqcWtUWkJDV29KQkR3MmdPZFQ5MjBkbnJGM2FhQ3o3YlE4?=
 =?utf-8?B?QTRoeFVjdUxYTE9lRmdIbHhkSlB4aEFEdFR2YlNQb2R6OU5HdkFSSlFJMktz?=
 =?utf-8?B?bUFiMXBISUIzZU1wcjlmVW5PRWhibFl1NDhIOHNodHpUdmhJYmRtV2xqTEM5?=
 =?utf-8?B?dVM5b1J1ZU9iNEhUcEZ1NVg1SlhKNVlZUkwrMGprdnhrUXJ1ODFOZ1VCMDVw?=
 =?utf-8?B?cTU2d2VVckRnc1F1MXkyMTZrU05FZ2p0eFNaWlFxTHhaUVQ2SDZ1RkZ6Vm1z?=
 =?utf-8?B?amw3enc4aG1iVC9rNmN0OFhZYUxJYXhSallFaUhvWTdyYW9wbG1JdEoxT2gv?=
 =?utf-8?B?RlBvZGFmY013QWRLRDVpSDRSZkI0bEd5TnJDMjJzZ25BTFN1Tm5xRnhnYnRS?=
 =?utf-8?B?RG1lb2hOaXFJc2FHM3JqSlUxcm43SlpvK0FSRkp3eXdZSnBnSk1MaTdsdnNN?=
 =?utf-8?B?Q0JmVFhpZjBrL2F6VXZRVlpDQW12eVp5dHg1SEhXRnJjM053dUkzQ29sUDRK?=
 =?utf-8?Q?gIoqXqy/wH7GYl/0=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc94e85b-6db4-4c59-37fc-08de633f0720
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:12:28.8014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VwWwstxQsNLFxTSAWN1E9QMO2FXP2Q0fViGpLvcbMM7XwoswoSu0SXuCOMjVpoZGJ3HZXkHAG4E4kJF/cqVuUFFDkCU+FcDlBNI4G3iTtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9669
X-Proofpoint-ORIG-GUID: 49ItQiXp8HDnIDyx3wey-q2vOse7DP-y
X-Authority-Analysis: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=69821e70 cx=c_pps
 a=V8sk9zoYrmkDfwrbWP/JzA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=dw8D7jiHbLOMPIDYODUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 49ItQiXp8HDnIDyx3wey-q2vOse7DP-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOSBTYWx0ZWRfX9jg5M71eHEFL
 Ai1EFn7h3ZcmPJk8qBkp67VXdyLbyPf3mlJV4IhvUVkgI7aCp35zcppkzHrVr9g9X3uHBONHT1B
 Rw2i20T4XQ5pRGxUeAoes/4b06VhSO8Ln3OcIbyeDvuqHHgD/VWWJEg0S10IUzx515sHR2Hd6IE
 hJcGyWjYzOzKa3HZE8iUnr3Xt0rZWfXswocEj/q1XdEOCt2KTaKi7ZsRKKp3KJhXOcmdsAdY3hT
 FAeb6g71dVC5VXEVF7dXH79OH1DJSPGZhHwwJlDag/GNumc/+7h89j+VjP82U+LkOEm/rbi5i65
 OCkZvB5xL32IR0bRfLiAeAp1XGIxliaJIxRMRaX7bZPZ9pYvLVAlhEP/JGrfLaHwe9TTo/s9mPO
 hiuZQZEvGmxiEb17G+UOqmz3RbEhIVAJ6hsfBUZ4yQPDmhyes6GZVDpWqYG5UL2RDl6l29HkbFo
 oRO1xWDsH8RCDAWSFEg==
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
> This will allow to tweak argument handling more easily next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index 8011c842caf..777d419aa33 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -1,5 +1,6 @@
>   #!/usr/bin/env python3
>   
> +import argparse
>   import os
>   import sys
>   from typing import Optional
> @@ -79,24 +80,28 @@ def print_post() -> None:
>       print("    /* end of list */")
>       print("}};")
>   
> -def main(args: list[str]) -> None:
> -    if len(args) < 3 or args[0] != '--devices':
> -        print('Expected: modinfo-generate.py --devices '
> -              'config-device.mak [modinfo files]', file=sys.stderr)
> -        exit(1)
> +def main() -> None:
> +    parser = argparse.ArgumentParser(
> +        description='Generate C code for QEMU module info'
> +    )
> +    parser.add_argument('--devices', required=True,
> +                        help='path to config-device.mak')
> +    parser.add_argument('modinfo', nargs='+',
> +                        help='modinfo files to process')
> +    args = parser.parse_args()
>   
>       # get all devices enabled in kconfig, from *-config-device.mak
>       enabled = set()
> -    with open(args[1]) as file:
> +    with open(args.devices) as file:
>           for line in file.readlines():
>               config = line.split('=')
>               if config[1].rstrip() == 'y':
> -                enabled.add(config[0][7:]) # remove CONFIG_
> +                enabled.add(config[0][7:])  # remove CONFIG_
>   
>       deps = set()
>       modules = set()
>       print_pre()
> -    for modinfo in args[2:]:
> +    for modinfo in args.modinfo:
>           with open(modinfo) as f:
>               lines = f.readlines()
>           print(f"    /* {modinfo} */")
> @@ -116,4 +121,4 @@ def main(args: list[str]) -> None:
>           exit(1)
>   
>   if __name__ == "__main__":
> -    main(sys.argv[1:])
> +    main()

Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


