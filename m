Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40408C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmuk-0007UW-Ni; Fri, 02 May 2025 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmui-0007UJ-6j
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:42:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmuc-0003TI-V2
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:42:35 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541LMLZj025080;
 Fri, 2 May 2025 02:42:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pW74R6yhtGxrit0MRlp9kQrnvU3NT6NAD+/agUQ9h
 6k=; b=MiTZKzE9hDYecawqo/8SPpB/M0gONnk5aXfy61C9rQVDCTfjMYfxlgsKs
 wjIE3vzQvas0SZdn4e6esjkU4XJ9yr0eKRv83fDgTnfCRF08wVWDznHyeKniJErC
 LTcIFHVeiws21jpCTgk87aq8PoNNY1+wLS46guQLzOuikw+eg9OxRDFSCnyrDCxj
 DpU7/tiyOl2GFMUnJV9rPFUhu2BssVXMFAkCZYmeQ2xG64IwSUPXUWUiK22uZfhg
 k92WipVzuXGVHGKMUC5KUUjJ1xCRnR1xHn063m1wp4v+LgE+Lb4//sYL3VcCpJ0k
 Kz5pIwHg+sAqX5I8vK8SMrFAw2GXQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46b4m1pswv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtn6/pbxg9K2GFU50cYcrUj49u3dgHanmsOxfx/p2xVeZeZKCG//TNQxtE4Nswzh4yg5WQIy4vFxBAtbARiohkeWmTosPM2JwtN21Gnt4Jxe8J6IxUpeIdnHhneVJEO2ilYr6gUe9zfOyg3r3su7Je7r9Iyylml23kF+fIOuXuIPSvomOpYEnm3ody9m1CTkdsXZjgbrD3MO+20fu1D6vbJf22QrfjhlsBaKuHrigPJgvHaoX6GxqBPLP8hGb18aZv840BiosCNpcrBBD65kcbA7AYYvQE/u3dy4H5xazkP6jomtAnWkWLR1Owsx9gxLKOjBWT8jnGHg2kchVZRwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW74R6yhtGxrit0MRlp9kQrnvU3NT6NAD+/agUQ9h6k=;
 b=ZlmNTjjswJyivQEmnorJPLU6MwiD7g5zYnQaIMHDD+39xcwrXMH7Ja9bfswYwLG0Fcidgh5BCIQtc0jkzjMldTR/3BOgiuxCxcqky7psxVeW2a4hq+9Fl81FBT6ql6ipr+orYoPc0xX1ikT/47ENIwz0RKbVKAdDror+WW17YM8otHFYAN9hcMY+8iqTdX2IV2PjzZPbENYOLFrXE5PWI9uBUdC//3fH+XzMd77UbQ8KcbCtSCumExcS5yPAm1a6inFVlGJ+vx9WHc38y7mU/HFCSqelFhhwFXMYmjELJ4m89f4tg+R6SvcU5TNMZZurbT/Sctpuvy6p1ADztcx+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW74R6yhtGxrit0MRlp9kQrnvU3NT6NAD+/agUQ9h6k=;
 b=rqSnyw80pULUk6h6B0BrYYeaqjGG3SitQO57XoOqOfdAMTFou9DxSZMbiivccKkSIsBidXKbaRM4qv97v/Ndh1lBIM6njdof4LtKMBgPJOU0Htwpd4i3GH7FA/UG+z5AV6mGZM+qyZ+XR6y7i7QZAWbA22Rx0J2OMLO1erU8ZTFrl4mxa5uxUr22zNh+3WBzcQ/8kAdTfrGXJ5g3dMIcqawBuu9MeKYltAEkIENo9oI5q1FgsDAu7Wxy0dFwkPaNo7rIITNzof3BA4aTHTPGRqIbKWHrVLEaPm/71fMTSraSglkVC/EETsiMaEu7xj2qhgHFSsN39LPIJjH/2YwvAg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB8656.namprd02.prod.outlook.com (2603:10b6:806:1ff::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Fri, 2 May 2025 09:41:58 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:41:58 +0000
Message-ID: <c0543716-30e1-4251-9e24-2e9f331ff08d@nutanix.com>
Date: Fri, 2 May 2025 10:41:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] hw/char/virtio-serial: Do not expose the
 'emergency-write' property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-16-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aacc57-9985-4d4a-e78c-08dd895d94ce
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnJZcEQ3SDQwRkRiNm9aMU5vNFVyUnFFSVBiUmtzaENLeHR2US9hN0h1eUd5?=
 =?utf-8?B?T0d3RVY4SlFOMnZJZlZncUU4SjQwK2JINjlkV3RxY1hDZkU1MzhLZjlpVG5F?=
 =?utf-8?B?VUVPdzc3bXpodnR2NFpUN0I0SW1wdzFNTncvZEMrVUp6eFhiekprcFA0V0t3?=
 =?utf-8?B?bXBCbHVVRnZOLzVIeTZ1M1M1bzZ4M1NrQ0lVY0tqN1M5NlY4MFplajZCbEZN?=
 =?utf-8?B?dnFUOTdMY24wQjhWQytoY1B4aTlaN0pieW9rZ2RQTWFBOEthaEtGWnNJNUdk?=
 =?utf-8?B?UUNJalBHdU5MdTRla3FRT0UxNFJGQkpwZ3BIUzYvZlVtOHRPQWhFVnRPOGNS?=
 =?utf-8?B?elVTYWVsRWRqL2dxZVZra3o0cXV1eUV0andKbGVsY2hHRXEwZVJ2RWhIaDI3?=
 =?utf-8?B?M0tnZFFVTngvNzNyTitVQ2Z5Q3V0SHk4SVpQbEtzRGhiS0VIRklpVng5SDF1?=
 =?utf-8?B?TGcxQ2dvMjYzdjdkMU5Ia1B1SUIzd3VFKzZGVzhVUC9vQ1hxaGZEL1MxaE04?=
 =?utf-8?B?MHBINXFrQTBSTEEzWHpYSHM1KzVwYVdWRCtrTTNLYlhhVlV0cW1jTGhGbDZP?=
 =?utf-8?B?QzdLdndnK0trRkVMSXMzaWc5KzMwN0trS3I5VHpnVCs1Z2N5d0ljTGlYYVlu?=
 =?utf-8?B?TEFzOCsrNmxIOVJwVjA3VjdTMnRpcUNaRVh1bzZXSXU1dnBOZWE2b21ZMVBy?=
 =?utf-8?B?Q1JFcUVQa1lQZlRnMWNuWFdCTFdJRUtxMGZmbDBuWVlkbFgzblloaHVvZ2Zz?=
 =?utf-8?B?ZHFtdXBVS291YU00cWFCM243cFE3c1c1UHlueldZdHB6R2dqVll4QmxtWjlP?=
 =?utf-8?B?SUZJbzZWTUc1TE1WN04xOFhVSmE4WXo4Q09Hamx0L2E2Ty8rM2J2T1BHK3VZ?=
 =?utf-8?B?ZURQQ2pwMUlNT1EwdnVlRWpvbGtZbEYvSVdRVDVxNGY2VjVCTUFacTMrdjNO?=
 =?utf-8?B?RmhuQ25OU1RIR3NCVitTQTR5VHBjb25FWU9aelV2WlFPZDg3STc0c2k1RlJX?=
 =?utf-8?B?bmV6RnlZb3hvVUFNV3RNWU93WHB2WVk1TTJRQWNWU1JPYUc2My9hTWpTclQ3?=
 =?utf-8?B?blRMcFRKMGVSak5hckNldk1KdkpJdEc5V0hzRVFsM2gyUDNwb0J6WDVxeFFz?=
 =?utf-8?B?bWdvQ2FDb2NvZDNVNTVyT3FwMWRlQUNwQVhXWHpiYWZpUnJSK2VHWGhSSld0?=
 =?utf-8?B?d2kzeXpTcDJ4R1BGWEZrbENHMnRLbjA2c0pQbHJZTjNERU5LSU9IRi9BbWF2?=
 =?utf-8?B?RXpzNWE1aStkS1JvWUpPUWdxbTFPemdOaS9hck90d0o4L2hQM0MzVUNuMzJH?=
 =?utf-8?B?MHk2aHVjdlJjVC9UTTFOdSszZUJMQTkxTUM3Y0tic2ZTaURMUDlVbDZKR1Vn?=
 =?utf-8?B?RnovYys0djlDU1JJWW9meDdTZjNPY1BZeEZnV3duc1hENTdpQ2pzQ0dXcmZ2?=
 =?utf-8?B?Mk5iUmMxZWp4VjFaVE5IdjdIdndIZlVvclppVklZVXQvTHBLQXE4TTRjYzBF?=
 =?utf-8?B?OFNaVEszTVBuZ0hqdzI1ajRDd2hHRmc0dkNRV1JUMk0wc2hFcGFEZ2x4ZkhV?=
 =?utf-8?B?bHozU3dSSlM3VXFmR3dEOWtIRDZFKzBhckExOWdiNzNubTJUb2RNKy9hRFpo?=
 =?utf-8?B?YTFEdjdWaVRXRlhoWDVhNmNDUy9lS0ZDTUdwVC8ySzQ0ell3M2ZwbDRZYkx0?=
 =?utf-8?B?aFRWYmc1T1UzVHk5YlVOUDlpT0Zwa1daSTAzUTJQek85aVVqSy90MEpnMVUw?=
 =?utf-8?B?Z2UvWmgrUWJzTFpCTGZIb21nYmRRYzNxZlM5K25sSVdmWkJYRXQzRjJJenpz?=
 =?utf-8?B?SEl4L0tUWFRDSHBEaXBOSnExTXFNb1VaV0JONW9haTgwS0tSUG13YTRsbVBZ?=
 =?utf-8?B?d09ocm5RK0t2WEdteGVDZ2dVTkVzU3NrNWdndXl0bWNESW9qZGMxeHZYMWdw?=
 =?utf-8?Q?HvUfm1KoHCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDFCZXZGcm44ZzBjaG5qM0dEa240eGdudThPeDB6aW1hcjF1STNqdHFwdGNq?=
 =?utf-8?B?dEprRTRUdUFvMVBIOGdsNjFhSzJ3bkFnZkFlVjA2eEp2TkU4OVMzMEhyaEJ4?=
 =?utf-8?B?THY1RnU3V21WVmovVHBpQnJ4R0k1cmlEWGV4aERDWjBpcUpLNmVOTjhrOGc0?=
 =?utf-8?B?eG1CQVVGYUR4K3J1YjcyTkVYSVQvMERUL1dHN3BSQktGbGtJT0l6ZTFqclRM?=
 =?utf-8?B?SDZ1T2dzc0hkazlpOG5xWTZwT1lvRzdwSi95QVozZFRXR1RvTzN0aWcyNWZQ?=
 =?utf-8?B?ejZaeXdjWXhFRFVSU0M3enltdm94Nm1sbEZMQWdsekdZZk5wc01XMVU1djhG?=
 =?utf-8?B?Ykd2dmxhc1R4RDRQOXZWSm15MzV2WWFBeUdmSHpjVHhDdGtTZ3oyNzNuSUZR?=
 =?utf-8?B?SFVhREdEQVVGUDV2T01IZDFOemxEWWRGTi9hN0pVZU9pTXFocDRjYVZJbTVM?=
 =?utf-8?B?NkVDTFpCaXBiRGh2RDRSbitsZmtYRXpUS3JZUVB1YjZMdnh6VmVxK0ZFK2p0?=
 =?utf-8?B?QUZUSS9RUWhzd1BPaVdubWNXZUhDL055MjR0VzFVdmdDRlg0L3g5c3JWeXJ6?=
 =?utf-8?B?aHBCZUVEVDVwd2djR1JTNU9lNHUvdGlEYzVHcHpVSVpaaUNJbzcyWExhWmsx?=
 =?utf-8?B?SW1RUksrQ1JKWm5QKzNBdVRWUU5aM3F6eHY1NTNxa2tzNnBlN0NwUXI0NEtT?=
 =?utf-8?B?aHhIWWoxSTNkcy93M3NJVjJzM01uSHhvUW4zZ280UkpPTnp2dCs2OVU2UmxS?=
 =?utf-8?B?L0x1d0p2bGgrSjNSbFJOU3Vmc3JEQUFaY0dNZms1YWJya2I1Unl3RjBBbVRI?=
 =?utf-8?B?alRXMzlkL1crN2xid3RoaVBlN2xOR2VWM2VTdmNBU3o2VjFFQy93NXZEWS83?=
 =?utf-8?B?MSt4TXUvOUh2ZEZZYmxOZy82anlxekR3WVZydWtCMUFUdnl4bkVrRFpqSHNs?=
 =?utf-8?B?MC9qbDFqM2FkQXFMbkt1S0R6TDRXNFRIam0yWkxDTkwzV0JwcEY2YXdyeXhn?=
 =?utf-8?B?WWNqQit4bi9hNTcvQUFEdnlkNkpJcGxqdXZubG9xbU9TcnlMQWx1a1Z6TkpS?=
 =?utf-8?B?S3d0dHVldVN1bDZQM0JWVSt6MnZtdENHYzlDQzlHWWsxT1ZBdUZhbDUvT3VJ?=
 =?utf-8?B?TkVlZ21nNElMUDNVam9nUGFnalFUak51SEtLSWhWTmxSOEtQK0ZiVEpMOUlR?=
 =?utf-8?B?NFRxd1FqZ0Vta2h0M3g2ZjNsRzFvVTgwRkFjRHFqa1V6dm1wZTZnQXlSQkMz?=
 =?utf-8?B?aWhLeGpuVUhxaFUzazQrYS94K1JuWlRuclBmQzF2dmtTRlJySU16d1I1MzlQ?=
 =?utf-8?B?UndEbUlINUpaUEJabUovcnNPOWt4eGpRcVN2MjhrelIveFhJa1VFUVpsaHhu?=
 =?utf-8?B?S05IYUphV3Vmb2Q4U0JVN0tzRHhmQXk0OGkvM2l6cS9LcDB4YkVlZ3JiQlIr?=
 =?utf-8?B?UG9hK2hnVDRGNWVremRxaFM0bEs1WUJaTkdSTFRLb2JjdkRZYkg5Q3RGNytW?=
 =?utf-8?B?ZUU5WjBZeVJ3MzFzSHdZN3NvVldKSlhtaTN3enlQTDVMeWc4eFBFeU1SUTRZ?=
 =?utf-8?B?SDBKcnRoOXdHb1pTRVNmeVg0NGhqNDRwQmFVeU9qWWhNMmwvdnJSQ3NGRDh5?=
 =?utf-8?B?eUMvZWFsY20xcmJjN1F3azZteW1JSHlCRHkrL05uYUc5c1FUdFk5U2wzOEpy?=
 =?utf-8?B?V2lTOU5uT1h0VHhLc1hrWHV0bXVvVU9mZzVkSEd3UEJqYlZ2WlZEbE5HckY3?=
 =?utf-8?B?TVlHcW5icTVZNWNwYjhpU0ZaelNRbURMZXJrK25QTEVXN2tOK1lOZHJOUTVi?=
 =?utf-8?B?allPL3hpbjgyQ3YxZlBQWjVGdXROTzl0bGVla1BMbElSdUE0NDIyMEU5Zk5T?=
 =?utf-8?B?TCtSZG1ZS1pTVEZmRjRpL3BqZWpVc3JVdVQ0TEltUWRLeWpPemNLN2ZaZkpv?=
 =?utf-8?B?UVErSXhsNmVYTUMyK3YzYWlZVHNleGxxcG9zUFBUdmpodlpUUmU0VFprdnl3?=
 =?utf-8?B?ZnVTNk9TUG5teGpEN0hDdFRJUjJaRDVFRVRHOW9zeHYzQ1BqM1Fidk1VcGVU?=
 =?utf-8?B?VHA1VWhDUE84dHZlY3N2MkIyT0xRVDZtR2VIdWU3SkM3ZmFKQnE0d3BNdTB4?=
 =?utf-8?B?a2IyZUZpaFRocWZyaW50NzBYQ2gvUmpzQlF6OUZNNUlON0lieWFEb2JZVjRv?=
 =?utf-8?B?VkVjYUQ2Q0NKZ3E3eGVWaXhqUDQxR094MThRQmcyK1dKWWhud0lBY2xWWVVy?=
 =?utf-8?B?aVkxZzZMaUxZam1DNm5QSFhpZWlBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aacc57-9985-4d4a-e78c-08dd895d94ce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:41:58.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1KzovcNqxXLLsf2ub+8vqhkVB0RCpnVXWucFpmO4ZLnbpggNQx3Wvgs3+fx7hA7Tnj1GfcI4Z8GCw416COxaGvCIVfZsmwq5NkTzgha2Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8656
X-Authority-Analysis: v=2.4 cv=Y9n4sgeN c=1 sm=1 tr=0 ts=68149374 cx=c_pps
 a=+hq7TYb7Jqj0EztKBnUMzg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=S1zwB1wpBPZXZ1_GQq0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mGyZmUhFYe1IeZo0JXVYDQNnUQoOHycJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3NiBTYWx0ZWRfX+ka2+XhGvit6
 jQq0dpyGq5m1TYX7tuKvi61GZqUQOFaZcGn+PQ9aKwq+UCZDgQDGvgmujGIG0WTN1ejy7vaIjc1
 cWKi9Ozwpk1VJvzrjXreMIOEgc3ToD7pPpLN9WmRct8bk11Bk5iOBZH6EyDcXBiPEQDOBGLR1J1
 fbgBCV+10FiRim7eOGWL1JhSwQQdt9CHmrUJ1mQMdsebMpAVXNt0BwnLr41ztrwfnbXRTTUt9Cf
 YPkMNrSuVc1Nzb13AYsMkG3tF6EgIIzbD+psklaliTK/pTitW1F9AS812jN8oGAZjV87o262cvE
 73wqn3tyIdBeLRcb9P4EW6/wyIqg0shTY8rO+TbOIWU38F7FvHlCqyf58aEQI0N87UIPZRxQ8NH
 uYdUudKWQQelSxZeIsw43PbUrehL2Igh/vCAKWiF3/lanu3AIwKW7k9e4J/I9QF+Bg6Z+hv9
X-Proofpoint-ORIG-GUID: mGyZmUhFYe1IeZo0JXVYDQNnUQoOHycJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The VIRTIO_CONSOLE_F_EMERG_WRITE feature bit was only set
> in the hw_compat_2_7[] array, via the 'emergency-write=off'
> property. We removed all machines using that array, lets remove
> that property. All instances have this feature bit set and
> it can not be disabled.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/virtio-serial-bus.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index eb79f5258b6..31bd1b7535d 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1019,6 +1019,13 @@ static void virtser_port_device_unrealize(DeviceState *dev)
>       }
>   }
>   
> +static void virtio_serial_instance_init(Object *obj)
> +{
> +    VirtIOSerial *vser = VIRTIO_SERIAL(obj);
> +
> +    vser->host_features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
> +}
> +
>   static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
>   {
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1155,8 +1162,6 @@ static const VMStateDescription vmstate_virtio_console = {
>   static const Property virtio_serial_properties[] = {
>       DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
>                                                     31),
> -    DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
> -                      VIRTIO_CONSOLE_F_EMERG_WRITE, true),
>   };
>   
>   static void virtio_serial_class_init(ObjectClass *klass, const void *data)
> @@ -1186,6 +1191,7 @@ static void virtio_serial_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo virtio_device_info = {
>       .name = TYPE_VIRTIO_SERIAL,
>       .parent = TYPE_VIRTIO_DEVICE,
> +    .instance_init = virtio_serial_instance_init,
>       .instance_size = sizeof(VirtIOSerial),
>       .class_init = virtio_serial_class_init,
>       .interfaces = (const InterfaceInfo[]) {

You could also consider removing vser->host_features completely, since 
it is always ORd into the host_features list in get_features(), plus all 
remaining mentions are of the form:

if (virtio_has_feature(vser->host_features,
         VIRTIO_CONSOLE_F_EMERG_WRITE)) { ... }


ATB,

Mark.


