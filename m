Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDEDC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmXE-0006vh-6I; Fri, 02 May 2025 05:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmXC-0006vH-EN
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:18:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmXA-0002Tm-Gv
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:18:18 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541MZQaj018501;
 Fri, 2 May 2025 02:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VjkTbKtga3Qq6UeoV85ND1NX1tx8U6VUiFYNkWnJ2
 +M=; b=Hlj3EL+79HxqdGsBj2h46SgFxH8m0oFWNmUFo46Zc0B2I0fQJnWQtm3xE
 65p9hKKbbYNYt3cf1/7nGxPIsvh3x/5Xoy9+Zj75ZmiV7hw72U4HfMAwV4FgICyN
 R45iNmVeQhLNUI7WhLLwZLBI0a5MGie/cNUYcPjj0+qppcMEjrd5XuMiOR+GB+dN
 kpyk0MoG73LSG86lxPl7DdiOmjh/EOKlxlcmFnETaPOxT5XreEMqwvU1DMS26nS1
 XKJa7M+HIbt5Z5f+S1UJ7HR9j4lxCELbOSdgNy2jFoKozaqZ9DOwUriBpU5kQ5SD
 oOtkwws5Zhrscr8sPYbHKwywyFK1A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjk59jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYl/Su+WUQV4+ZaxSJVEmAimBxPtqRRYRGP9CPX9DxF4yQEvlT8NuHthNBcIw0W5W5B9ScegsT+xywYPZomH0edWGPoMSJqAKfZunKIjWHJo5spmZbcXONM1Rg0emiALSNaNlLpRpzOAy9/9ePP0ESYbkVhPa++Y8fXHi9uHOsoF5WsY3ohk2pA2Esd3h3ICmRI94wldygf2vrXAAWzsrNFNHx0aYTovapPqSA/j8QU/g2nh4V4DNE+Dot53IO1PKKrclW5b+LW1MM0avLsKWJKrUnE47vv8CyGSRoRpm4/nk0Nm0eaAPLtjTfsM37W7GhxJkQphmiWIduqFvWirQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjkTbKtga3Qq6UeoV85ND1NX1tx8U6VUiFYNkWnJ2+M=;
 b=tqO23Q1fI/tq5jmShxCo7hJEPvMC5Mthem/gR6bokCpaMx2GFGWTr47u8N1fkxJ1O2Vxfg7tqw/MhACJVtSYlWXkHWZ7+22YhI1qzSza6D6+xxu4gt1F89ZZua+mvjI2JXbw9MVEWMSv0vnNJuXAGcoy4K77Bg3RtDBH/Ll1Hk6DHbX6smpY4a+eBuA1OK0NSJsWp4mn+e1UXLxdGKEFUroSrpv7KTnaz0wNrXs00j1B3s5dRcH9Bps0jKdbR/OfD5XRMpgxo7AZGJS3/CJwx7SFpwSlJL7P2cF4Hx8WNBZo7GgTN4DHt6DJuR84bRxORz1wUQWCH8A4uRx61hoOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjkTbKtga3Qq6UeoV85ND1NX1tx8U6VUiFYNkWnJ2+M=;
 b=CoFnTm8PAv4gdyLNpP0vkh7ith4yGkSomI6zoktiWSmvDN6X59Y+2YhrCBGaBQor4mWy05kk3ViXzI07Lz0QzCa7mnTiASeUIHbTP5dX8nchN+n9Qn1SuZx+qp3GtVxUWoBtf94mHSHrTyc9tLD0rsZb3bgpIJi3oERYJpXQa9gC3tJ6DrQxSU8V6z5iepXg461sYUeuKYJUiDf1Gds0DFyE4p8i/YRgnRUr0uZQQjNBYmv9WcOtQBU92QZzPmIxc/PbI/G6xyNf1ypILlvg4yNn/8pa0CkLJMqDC+7+0sefZA1D1h9y40YCoFyXNKscVC/1kovSdj17EbOGErjQpQ==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:17:59 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:17:59 +0000
Message-ID: <2e602264-174b-4424-b6e9-cffabbe670b7@nutanix.com>
Date: Fri, 2 May 2025 10:17:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/virtio/virtio-mmio: Remove
 VirtIOMMIOProxy::format_transport_address field
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
 <20250501183628.87479-8-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef13748-36aa-48c1-cfee-08dd895a3b7b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVhoZ05BczZyNHU2V2loZHp0L21GdE4zWVVZdDJNQkJ4TWRHVjE1eHdXbVVi?=
 =?utf-8?B?L2d4djlUS1g2bUErWFRINU8yVTJ1aEJKTngrNUhla2d6c1RyRlNkS2xaWitJ?=
 =?utf-8?B?bElhUmNTNjNNRTlPTXRDekYwYnBNTndvUHowUEp0MnJPZXNHbjR3RTZKOUla?=
 =?utf-8?B?TWQzUkNJL0FhZUdMWFlyOVZIZURKQVlvVy9WYmlQTTJWYlQ0TnJoUGU3cGJn?=
 =?utf-8?B?MkNqbVI2cS9hdUx1UHpZSFVaclBhV1l6STJISjhyYVIySjliRWZRZEVkQ1Nu?=
 =?utf-8?B?dGRENUp0Z1hpeUpMYTRPMVo5R0I5V3E0dzB1TjY5dXNyZzBCRHF4TGw4cng0?=
 =?utf-8?B?Nld4YWRld29HLzdnUGFLODk1Wmg4dW9IaVRkVnd0ZWcwQlBta3ZEQkdabW4y?=
 =?utf-8?B?aXEwWFg0UU5OM0tWNkFtSlArc3paWXIwcm1xMmlzUTArdDljR1ROaUhIdjh1?=
 =?utf-8?B?OHEzZEdNbFJsNTRpRXVJRXZmU0JqOEFVZ0ZHQ3U1aW1QT3k0Z21OU2FQUDh3?=
 =?utf-8?B?d0FlUDd6VUl3NXFqUTZCbmJxUXVzMEdYRlp5aDZJNTZIWUNkSXBmVlBVUXN1?=
 =?utf-8?B?VW9NalBaeWRZb29sWGZOR1pBKzhLdXRrRlhxTnBnQ25yRWhGWXZWR3c3TGZp?=
 =?utf-8?B?bzFuRmlta1VRUWZsWVZVRFNoRU1OcmVvZ1g4YWhpeEVSNjF3YjcwU0trbCtL?=
 =?utf-8?B?WEl2cS9YVE5XK0tuaFc4Vm11bnNoMXo0UzlxM2YzZjVmWkdPVVIxSi9KamFU?=
 =?utf-8?B?OGxWTjNZVmpMYUw2UzRCUEZOWEN2Q1RaK285L3dCUjlXdTNpUVl0R0JVMndq?=
 =?utf-8?B?K3JmSHh3RExPandMS0s0aVpqUTBnMDJraDdrUWVtdktGclJVR0JpRWs4TURr?=
 =?utf-8?B?aDlDemNWRUxTZHNTeE9kK1NhdUpVRmVwd3M0Q3NHZ2tqNUxSNml0clVBZHA2?=
 =?utf-8?B?SElOQXMzNm1sU0JEYUlsZkNITEdiK0thc3U5NG0yMzk4NWdrZlcvS0tyY1Zr?=
 =?utf-8?B?ZDVHTDFselBRTWpyOFBpSVpkMkxRWmlmWVpNQVFJTlRiY2w4cHZWWlhyTm5q?=
 =?utf-8?B?NElSbXdYb29tc0U1Ti85R3Ezc0xjaHpSWTR3UGR4MUQ5dFBtbXJTaWI2blBY?=
 =?utf-8?B?OEVvRHJLcEdTcU9sWUxqTWNOOXBpWDQ5YThwL3lVSms5cm5QaTh6cm1sTlc0?=
 =?utf-8?B?Tyt6SDBPWHFESnNqYnNjUXNrTmZpUjRHUlJxUUNGc0J0NUZyVVpGREFZK0lj?=
 =?utf-8?B?Z3M3Vm9HdUNnYTc2Qm96am9NYXJxVEMrQ2JrWjZBV2RBYzFSdUd1endrbmZX?=
 =?utf-8?B?YllMMm5rMGJzeFdOeU56YVpVMTh1bVNucnAzZlQyYWRrZ3hOejVsSHRmdmo3?=
 =?utf-8?B?ZWFQM01LaVdQWWVZVVgrbFBjRjFRcDZDNUZOTnhvMjByR09nUWF3aVpTQVlT?=
 =?utf-8?B?MEwrWGRXNWM0czZaT0hpUFRCaTdNNzBsQ09xQ3dUTldwWU5Ua2o2MnZtbkpK?=
 =?utf-8?B?eTZuR1Z6LzdYTWx6eUZQMEh4QVRFZis1WGdpKzkyOWRKZ2g1VTdBZk9LTnFC?=
 =?utf-8?B?V005Q0hQQTAxS3U3N3ptT3kxOTJsU1dvWkJUQU5vYlVIdlRDNDdBaWNyRk1U?=
 =?utf-8?B?RngvWERvVUdZM2UvbFg0NkVkRXFLb1BjVkpsZGVTelJlT2RSNTlGQUdlMzNp?=
 =?utf-8?B?K0ZTQWZrbjZrRWR0T2Z6cHdvWERreE9Ecm5MQnQvVUtZbTNlTUpJSTFxSExs?=
 =?utf-8?B?RHpQZEJSMHBPY2NlSkdTOEdzRkdpbW9kYllEK1Fja0dybWJKb3N6dUlydk1Z?=
 =?utf-8?B?ZUpSQi93bm9HMHZ6NEYzTlYvYXRYSWMwUjVaNk5OSVZmMUJsRGFBK0VwWXZZ?=
 =?utf-8?B?eE05RTBlK3ZZaFA0RjkxYmZQRWtTUUJ6UlpDZFZ6S0VTelE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGp4OUkwSlB4YVJYQXZyUUx6eUZOL2hMYXVtQXJaQlVOcWhVd2dFL3FUV1py?=
 =?utf-8?B?N3RBSCt2bWZsRTE0dlVTcHFudUIvZEhXN1ZZa2VaVHBIWlFrWjZuQVQrK0hN?=
 =?utf-8?B?M3VkM1ZzZ1F3SlVTNjhnVFZwdU9QbEphYmpZTldTQU9JYm96b29xVitOdmg2?=
 =?utf-8?B?eXg0QWxMeGVYRWhtRTlhRkVFcHJ5aFF2dzZQRnRMdkR4QXBycjJlcGx3WjZK?=
 =?utf-8?B?a2R1dXRPeHZLT1JxRXg3WnlJbGZMSnllcjZLalJpK2ZUYmpHQlRPVUZIWFhE?=
 =?utf-8?B?OEl0YzZhL2FicFVtNTVGcVBPdjkyOTJIK3MzZ2lZYUc4SE5NZEkwN04xSlBB?=
 =?utf-8?B?QkthNUd1VFFRanlnYWM3REhFa3I5WmFpaENGSnUxSEdPb2NFVXUwSEZyaFJS?=
 =?utf-8?B?ME5mbkNUQ21rUmozZC9TMHY5TnpjOWpWcHZlaER1MkRIK0hXNlh4YXRpZ0VY?=
 =?utf-8?B?VklHeEw4ZW1DMUVHY3hXMUxSTGx5RWE1aHRtK29nbFRQcUFlODd6elJvYVlP?=
 =?utf-8?B?ZGpleW1SNGFPNW9kRHpUaXJRY0Q1Vlo3Q0ErRVd4djZsQVdtN011c0pWNWRV?=
 =?utf-8?B?bVlLUGI2cHJGR3pzdHlwMkc0VkEwc0k3bkcydDZhYVpuQlhkNEttWXBTbmh2?=
 =?utf-8?B?N3drc1RpVTZyVTZFdE9CTW94aEJnUmdKcHYyNzQzei9PekVpTGdhK3l0S2w4?=
 =?utf-8?B?a3BSbXdFRlhuazZDdFIwcDJVQkdGV1VHNGtlWFNBcFh5SUtsU1g0bzQyZHRu?=
 =?utf-8?B?L0kyVTV5M3MvUHBsbVhtZ1NNL2x6akEvYXVIVWVaRXd1MGIrRU5HNkJqQWtV?=
 =?utf-8?B?V1hLcmN2L1VmcWJaeHRMcUM1QXNHV0tEcUpIdW1yK1VrNERxUW5XMlViQis0?=
 =?utf-8?B?RmFsWitUcEEzeVdvaTJ6M3dhUkJmYysydFhXYnJHaGU3SmdvdmhweWcvSlk1?=
 =?utf-8?B?d0ZRbTFBZzRKTnFibmJ3eWJTS3dZVTByNnJqNXNiaDRvdWRMWDF6a2FPQUg3?=
 =?utf-8?B?WWh5V1JwR0NQR0Ewb2NNc3FRbDhkcUtKa2UxRSthYUdPNE1TWVhvNHNoMXNY?=
 =?utf-8?B?Q0F3NUpSZmgwVXhOUFA2Qnh5aHNkRjB2ckRhWXVSZVBHZEVqMGE2Tjl1TlJ6?=
 =?utf-8?B?MFB2QkcrMU1BWCtjU2Z4MVo5TDNheWFOOE9MV1VReWlYRmd3SG9yRkdKNUFn?=
 =?utf-8?B?SzM1UkhSOFpSdk93RTMzU01uQkZIL216SU5WRjdtVnlOeXZvSnRabFRuVnky?=
 =?utf-8?B?K29VMW9SeGdjUzdZTGFxaGRyQkFudUtlYlI5NHY1bWRVQ1h0UGtZM0FhREJY?=
 =?utf-8?B?a0RKaWVQMzRUeTd0aDAvMUo5K0FiQUp2cWVxbnFMcENPSVRQQVN2RUlMS0Js?=
 =?utf-8?B?WjIrdENNMDA1a090eFNHVUNxTi96ZDZJYUxKUkZ1TVVsVFNyZVllMCtRZFVW?=
 =?utf-8?B?QWwxMGxuUERnVWErYnNZTkVjNlJGMncrcDRONGs0SnV1NkV5RVl6WUtSWmth?=
 =?utf-8?B?Q0xOVlhRcTdPckZiTjZheXlIcnlobVd4SEM1eFNzQURMaU5CQm00WjBpRjFm?=
 =?utf-8?B?V1luQlh1NlQwUVlHNE04YVRqTWM3Q2ZLaWY1SUZuTHY3N2pkWm9UNHJQOWNq?=
 =?utf-8?B?WWdwNGlLNDc1Q3ppT2xpalMyR05VYWJOeGMvUGJCYS9iWmpiSVVOMzdMbDMz?=
 =?utf-8?B?NGpVcnIvVVJod0M4alo3RjQ5VWJJQ2tuMFlmVTcvSFdMdWpqeXQ4RnlnUnpx?=
 =?utf-8?B?aVUrc3Y4VG16VFQwV0FVWitOYUtBdngyek56endYSTNaRHA0UjNtVmJMZEVk?=
 =?utf-8?B?TVkrTXRMVFVRdlNEejVqQ0tyTDJCMERIaWh1SEc3Q1BGb2YwcjljUlNqK05W?=
 =?utf-8?B?VmxxK3lPZFp4RXh6T1pBczFHcmd5aVJGMVlWTlNTWnF5ejRUUkNkNFFUcTVp?=
 =?utf-8?B?cVpNcTR2QitQS0hDcUtURDNVQkVOdDc5Q0VpRWpnaE9JZmk1UVBSd2djU2Mv?=
 =?utf-8?B?Z0F0VHBWNDRKWUNhODFVY0FuNmhheFJCK014TE9Vd280endrZStsTG1NakYr?=
 =?utf-8?B?UmpLVm9USzRJRmM0S2MwYWYxRHYwK2hSNXpFc3cxK3JKb2JCYkszMGdXS1pT?=
 =?utf-8?B?SGdERjUvbXU0b0Z4aVlaL3NTdEE1YW52VHZ1ZEM0SkJIM25HeEdPallyVlpP?=
 =?utf-8?B?NkY3c2F5RTdDMGhWeEMvUHgybVdsZ1lVWlF0K3IwbnhXS2pRVWZTbGYwU09y?=
 =?utf-8?B?WlRTVlU3WnhZOHFkWmNoekdRSUlBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef13748-36aa-48c1-cfee-08dd895a3b7b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:17:59.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhARayUTavjuao95XWMLLyikxcvvNe9BvEc/fsXMqNFkwj2fXgOKRQ/cWOcj5k31pWS6zzNr824Rbeekvy9LliVF7FiRTapHMq5uWzIqEBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Proofpoint-GUID: gwCGnemWFo05CSQtSGSE0ml8z40q1HH0
X-Proofpoint-ORIG-GUID: gwCGnemWFo05CSQtSGSE0ml8z40q1HH0
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=68148dc9 cx=c_pps
 a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=4KL2aqsibfhyKmtQu1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MiBTYWx0ZWRfXzjbk9aEroLD+
 QO0shL3mdWBBQj02nso9xFCZ4XTZp9/sIQPGh+xurPaXIFk3gSLSjqxecac42wBhKnaGJl6wFdR
 RWGx9aReNaUS8UOUIIqzT8Cva4U8Eu8hPvQzIUdy3FB1tWrLMYy1lDbULJ1crHvuQIUEoJ/VqRz
 AHzi1+lfKX/aof/scTR/NmDV9892pEdICIOnEbqN9U/RrHdDo2jHsoXZ+SdBHy6LAFPxpZe13Si
 NY7Pv+AGTE2yc17ZA3vmfB/2XjPuUOMS/gv2afZOlTCyu/gmetfJx1DnMySWWS4qM4RIgE8NiAo
 S6d6XQdcgr942EeJebdkEpH/YM7oSfj9nLP50nrnij7Xq92/j0Laemui9VTWZLP/22Y4Jrg2lmw
 kcbrW3dI61VfPlw+6xIcvpvEqBrPai0xzR66BM2OUpjhrem/pKEHNYlU98FbLdFrMBrWrciB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

> The VirtIOMMIOProxy::format_transport_address boolean was only set
> in the hw_compat_2_6[] array, via the 'format_transport_address=off'
> property. We removed all machines using that array, lets remove
> that property, simplifying virtio_mmio_bus_get_dev_path().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-mmio.h |  1 -
>   hw/virtio/virtio-mmio.c         | 15 ---------------
>   2 files changed, 16 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
> index aa492620228..8b19ec2291a 100644
> --- a/include/hw/virtio/virtio-mmio.h
> +++ b/include/hw/virtio/virtio-mmio.h
> @@ -66,7 +66,6 @@ struct VirtIOMMIOProxy {
>       uint32_t guest_page_shift;
>       /* virtio-bus */
>       VirtioBusState bus;
> -    bool format_transport_address;
>       /* Fields only used for non-legacy (v2) devices */
>       uint32_t guest_features[2];
>       VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 532c67107ba..b7ee115b990 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -752,8 +752,6 @@ static void virtio_mmio_pre_plugged(DeviceState *d, Error **errp)
>   /* virtio-mmio device */
>   
>   static const Property virtio_mmio_properties[] = {
> -    DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
> -                     format_transport_address, true),
>       DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
>       DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
>                       VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
> @@ -815,19 +813,6 @@ static char *virtio_mmio_bus_get_dev_path(DeviceState *dev)
>       virtio_mmio_proxy = VIRTIO_MMIO(virtio_mmio_bus->parent);
>       proxy_path = qdev_get_dev_path(DEVICE(virtio_mmio_proxy));
>   
> -    /*
> -     * If @format_transport_address is false, then we just perform the same as
> -     * virtio_bus_get_dev_path(): we delegate the address formatting for the
> -     * device on the virtio-mmio bus to the bus that the virtio-mmio proxy
> -     * (i.e., the device that implements the virtio-mmio bus) resides on. In
> -     * this case the base address of the virtio-mmio transport will be
> -     * invisible.
> -     */
> -    if (!virtio_mmio_proxy->format_transport_address) {
> -        return proxy_path;
> -    }
> -
> -    /* Otherwise, we append the base address of the transport. */
>       section = memory_region_find(&virtio_mmio_proxy->iomem, 0, 0x200);
>       assert(section.mr);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


