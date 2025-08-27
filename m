Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0035CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDzv-0001aI-1S; Wed, 27 Aug 2025 07:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzr-0001Yf-Tc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:21 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzo-0006yw-St
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756292837; x=1787828837;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4U5OeUvIdROunZSNQlkDnJLKIciVWGWto9Mc0xPwA6M=;
 b=aZZEtSFd9GMFcw9kFSJ5ZdpNtoMOKQ+ZjqNWIq57V2xetxbdc0WWfWva
 alNiRluhkXoJ6m9P8xtEgeg1ZTMzp9XLzlGz7NC2eCpa5r9C3dUJU8Y5v
 Ed4AHsEDNmFFURMoT9oVHpcRYVycceZr+3vOQ6vyx9ncG+TDp4SxWvZgK
 pXZjwhfwyXm6g7AlxhTO7q4+wHLqrmK1eLg4ylbN4glCn+pKsFtw7LTaA
 6ZkhBWECtZLokIulGZ8EuLtjxwJrFLB1m6U3Y4pMyfoPKUjzNr8Lol4c/
 X4B0m5/AMprZAYHpBr+8njzyB77xjcwXrk1JnPge98YeoEUQbKw6NGDxN A==;
X-CSE-ConnectionGUID: LkTcb9LuScep7IKRcK4/Ew==
X-CSE-MsgGUID: 5TB0fM7PSgqsrKdo1Q5N7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58692872"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58692872"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:10 -0700
X-CSE-ConnectionGUID: Av/fGHfuQzCZO2HZXEP3/w==
X-CSE-MsgGUID: inhoBj8OSvylrQ80A979Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="206985221"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:07:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.62)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wURBOuQCi/Yhw9F1RL5ig2O7iD49ypYlpbzNtcD2UtkQdSzPA2ybz5xhq1O80Tyr2125iLuN+raNSZkHoB4ODQ0gF/xr/rkXm5u2lATHSOfhiF5DtlDKDTwAntwhHD6FyJZ7/gTByi2BldTSSNJ7UeMM0DVtncKCnhv2iQUqRhun5Kq16GyN2XZ+u/PX9P+e9fL0F/VtDLLltmA725LOx/U/zVJQ5u0W9maZC4EU65ZIc7yERoNLl3acVTWwnrU7pO8aUVdOfbmd3Ncc3zANrDXcvtCVW4pCSM0ZdI5vhk2RojXrJIbyLpKXCnrWyclPoOmDDUhhXCriCazihXF93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7msfmWkbatRw+/jBVsgjnnkuq5yshhscr8zfi+wHMZQ=;
 b=V1wzOp+9rTXecipuRhKUQe5pXPCkxQWvaU6xBhKp/hoPqDAgSR7MqfNQ2aKrmTsVtpKglOgxxuaeq3RAh3Mf+XQf1tSjSPDYX79CZLZ8wJu86n4mqEOzjEdxHBEUBq11JJWkrL/koPTwbVtXwU/Tx8p1tj4f063cywlydTbn7gDG2pFQsvEXfceplzUqRX544PUJoXS/TpwlgzXm46GzH215ymqdKU/KnR5mnI/4EfiWa+Y4AYrs4LR6QeQOKGXd66SZhVuSmEftcbSj7IL5+5DBfwKmazy5L/cnytIuybnP1oNdQdvyq6c8UTk4Uxt/1nXPLo1uGX/tTWjp4Zquvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:07:06 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:07:05 +0000
Message-ID: <278c6fe2-9d7d-4695-b837-8cde2c8223d6@intel.com>
Date: Wed, 27 Aug 2025 19:13:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 563e23f7-8a89-4a5f-805a-08dde559db8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjBlRUQ0cHhZaENRd3pqaUU5cWtGREhIcEI1ZnJjclpHTEptMHE0M2IvN3hu?=
 =?utf-8?B?TitCUTNoVjZiQ1ZoWmpQclVpQW95ejZLMmFqUDNLbFJUd0NKTnNnczUwZEtT?=
 =?utf-8?B?Tk0vZitXa3UybllCRC80U0xQWGhSWTlaU01VT0FmajY5NEtVWkg1ZEx1aWpV?=
 =?utf-8?B?SC9wd1FTaDQ0WlBZWFFzTjNoRXJXMXJOSnNqclJjbWVBd2RvMDE4SktEVTRB?=
 =?utf-8?B?T3NRbEE0NDRrU0htTVNvS2Q1MXRWMXBIWjRhT05UcW8vUzBTTDRMWkFkOFlB?=
 =?utf-8?B?N1pYNDZreVJpU3g3dFltUGlRNmUxUittZHVFcHA5ekpkYldhQVBCd2xiNjVx?=
 =?utf-8?B?dDE3VnNaV1hOZTRFdmtGdWNLMUs5ZG1sY1pSdDgzbzZjVmsyV1lES1NpYmg5?=
 =?utf-8?B?WmNCUnBDV3paa1REZVQvQWl2V2YyYmNTc3piV0xYdXlrVmJ3OUp3UXd4dXBt?=
 =?utf-8?B?QVhvbGc2dTljUHBOQXBIdFhjVTUwWmhLU2RQUmpRRW9vV0haSGFIYWpZd2Ex?=
 =?utf-8?B?eUlqdXhBRzdFVC9kMWF0R1E1VURhOVJFaXAxaXlkSCtaOEJueTF6SmNJcWYz?=
 =?utf-8?B?ZkFUZEYvWG4yNWxXNFpOWmRENEd2S29uem5uV1BrMXZQQkJTTHUrSkxmME9q?=
 =?utf-8?B?WmZXcFk5WWQ3TDNzVStOeHlVbThDdjFsU3lSTDNNVWo5cWNzTXNVVlg0Ym01?=
 =?utf-8?B?dzZHVnhHcU9HNGNrdHRCZks1dlFlK2RBMzV6ZTRBVlkxUnVleGEwK2Y3cXds?=
 =?utf-8?B?N285TllBajNVa1VFT2NOcXd5QTRpTjZhOERoMDZVZXc1ek5DR2VmTzl3ZGZx?=
 =?utf-8?B?ek83d1MwcmxTYThGNnozbE45MHE1d2lIbGo5SjV3Vys2L2E0c2NUcE5reVZn?=
 =?utf-8?B?YU1kMlhOU3paVnk0QTE4ZUkzL3JFK1AyRGpzWS9jMnhDeWRSSzZFbGE4cE9X?=
 =?utf-8?B?c3hSTEZWcTBQdCtQWUNOSmtBdjcxUXdrWFVsM2twOTZsRkRRa25jMTY2WEs1?=
 =?utf-8?B?azRVU0p1TnFURXo4Qm5EMnR6bFRCMjBEVit6U3I4NitHeTVRbmtUbEo2WEZL?=
 =?utf-8?B?VnMveEpwaXBjdHh0cUZvZFlHQjdhNnlEZU9oZDlGQUZLNzJ0RTVsR2pMaVhJ?=
 =?utf-8?B?czRCeWNUQTFaYThIa3B4OWU4Q1BIY25ZT3p0OEQ0TnIzOXpuYldoeG1wSTBO?=
 =?utf-8?B?ZnM2WjAxdjJ0TGtzcVhBSTdjazhkTWFpcWhGRitndElTOWg4TTR3UzJRMzI0?=
 =?utf-8?B?Nnp1aUVFM083YTgzWHBoMDJRazhESTBMZ1FMVmliNzhXbldBZ2tFeXlXSDhL?=
 =?utf-8?B?QjRIVk1idzE2Y1kwNlMrZEFkUk1vRkk0ME1nK2ZobGsvQlM1VEtFMG9BbnN0?=
 =?utf-8?B?VTZDRFFsb2tSNFRKU2prSlJSdXpUcEVQT0NydXN0Y2lKdjE5RzdpVVZoQWpq?=
 =?utf-8?B?bHRCWU1wWW80R3dFejBTTXFYN0RSUUtJa01YUlBKaDJOZEtJM3BNaGNLTUJr?=
 =?utf-8?B?NFVPWXAvelZnWjhoQzRsMlhuKytjZUFHZDF3YUlPb0ZlK1lRVjJWN1lVbmJy?=
 =?utf-8?B?OHd3ODNXL3p1Mk14SlloV0dDRVpLRExQRDVWcGdjMUJLaGZlcy9nT1lqdGha?=
 =?utf-8?B?NFptS0JpU1lUbUNCZ082RXNIVnlOUzFWUjNtTVNKcGVnZVF3V3VLMWdjMHI1?=
 =?utf-8?B?ZlhSNFhQb3h4TmxNRHFFeDNMaEthbnRQS2ZtTmxQMTg3NHdWNk9MTDFzOGE3?=
 =?utf-8?B?V05GaFlXQ0N0N2ZUWWUyN21ZQzBRODl4UTlHTm9weHM2K2ZSMHM5dkhGWUZX?=
 =?utf-8?B?SVBGTnVJbnM1eXBTMjI0YVo0dGlteVNGd1o1VC9zeFY3OHdWN1I3L0NFeEpi?=
 =?utf-8?B?OVBTMkxIT2Rqb2pVbk5oNDNFZjV5YTBrbnRsWG92cUVHNHI0QzZuQnBRekdX?=
 =?utf-8?Q?pFgb2K5AOcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhmMEs2eW9TTnIwclA2Z09RZ3E5clR4S0VwOHJsWDh1amJ1ODc3ZVVkd1Rv?=
 =?utf-8?B?V3hOS0xxVFdVZnJ6cHRrU2xkZGdLTFFnQVdTS0hHQkt0QkRQb3NPSTk2M1Zz?=
 =?utf-8?B?Uk1SZU1UcVFCRXg3bHdGb01LRGRBNG8za2VzRUVqandCQ09uU2hNRG1vNjdR?=
 =?utf-8?B?NThkSEkvY0ZZWFcyLzJRcDdQSmNBaUEwSW0xQUlMVHZReDYxQzBJSWJjOWZO?=
 =?utf-8?B?N1JSbGZQRUZmd21kSHplTjRYcWo0USswSlVTUVNPcmFIbkhlcUxkaDR2a0pt?=
 =?utf-8?B?enlzQUtCcGZ4VVVnUHhPOTNBekNkVW5KR3QrNjJIT0JJck9TaEhZQU5mcnVs?=
 =?utf-8?B?ODNYajNFRUwvOGQySzBMQ3hsdGRacTduT0lqT0tSbC9UTHhxbkRwbmF5bnJE?=
 =?utf-8?B?SmFPSEUycllNck5KZ2s5eGt5cE14Z0hQNlVydUd0QUl1U0FITThaUytNcEFB?=
 =?utf-8?B?ZFNweTlkSnhYRnowVko3WGFBN1BSZXQ5K3N5T0lSUjJwZ2V5OStYbDhFSFFo?=
 =?utf-8?B?eVAzVTI1TGxpMTM4ODVJVFFkc3poMFRvaVZsRHgvZVVSYUhZRWtPS3R1cW5S?=
 =?utf-8?B?VHYrUVZ0ZVpTVEQxUzVWRXBNck5rWXh6K0ZReUFRUUptVnRmQTNCMnBxTkMz?=
 =?utf-8?B?NFhBTXM0S0wwRW9mcW9GZFMxZURReWlvdEZQMld5R0RrQis4dmIyRmZ2TWlT?=
 =?utf-8?B?T1JCMnl0blJ4cUIzVEJyUGVmMkx6cUJvTkxHWi9xQjBQL1BQZmplcEVXSEM1?=
 =?utf-8?B?YXZUbHV6dStEQ0hkSTJWTmR6OU90NXlQZENNZDZ1Z3Rwa0NPWDl3dFRxbGRF?=
 =?utf-8?B?WDhHdkl0NjdTalBlMXVQSWo0d3hNQW9mZ0tuaHlvVzIvQlZjdEwxR0hrSWR6?=
 =?utf-8?B?RGMzYzZqWTN4ekMyOXF3UWMzOEk3Sjd1b1JudkNmczVtQnN0a3AzQzFUTFdN?=
 =?utf-8?B?akNCbldZS2VuWXRseVdYN3llbHhsdlZremhHdHoxQVQwNnlhMk1hbk5Pekpa?=
 =?utf-8?B?eXRSM2o0UHR3aTFOTWhZcTlXbi9lS3lNRTMyN1dXWVg0Tm5yaTk2UUZISXdy?=
 =?utf-8?B?THRPQlovckRZL05tYXhvajVWcndiMEFaRVVlV29OaC9HVlhvSkdjQlNQd2to?=
 =?utf-8?B?U2hFdDVUZzVTRjZ3aHAyaXJvenVrLzArQnczSXhJUU04WlA5UEZwMU9TTmdC?=
 =?utf-8?B?Vk8xMHlFOGo1TU4vMmlpMHBMQThoQ0ZDVGgzYXJNT01GT0pKSG9vZGRwYmxE?=
 =?utf-8?B?SVU5RzZGQk9yVFhrZlEveWJrL1plcGVKSU4xQkhDdEoyQ1ppYnZjeXUzSkMz?=
 =?utf-8?B?akIwREtpL2F0L2pmdU5FUzBsaStoQ3BjeHZZNlM2eEtYU2kvektlQ0d1RkFa?=
 =?utf-8?B?SCsrU2ZuN1JENkZEaDBPOVRRN2trWUZuc3lEd1JMeUxwRTdEM2phbFN3eUZU?=
 =?utf-8?B?aWtLOEVjSUxXZWhsYWlhV1Zmblp0YzF4anM2d3JCa2pTQTlQeG9hUWg0bkJs?=
 =?utf-8?B?SHpZYVdnZHhrUDhWTDBmRFNsMmNEUGlocURaZy9SR2l2bjVRWmZUK21uL1ZM?=
 =?utf-8?B?NXpqdzNiVURxMGd3YlNqbFJnRVg3Vkh0bUQwdVd6aDFRaFZMNVA3NEdQcUVC?=
 =?utf-8?B?Y1RxV05nc0VCSGVEUzhhM0Q3d0lnbXJXdVhBd3BVRCtVOXg0YmJvNkZqd3NC?=
 =?utf-8?B?S0h2NkRDUEVpOTVUNStIRnR4bnpSUXZlcGlRTXU2U2RkcHJybkwwcytQU25O?=
 =?utf-8?B?ZFM2cVN5SWFjQzI0MDhRc1ZYWk4vVXVYc3d6Vm5QYkFZVWVoTFkreHZEMDlu?=
 =?utf-8?B?ZkhPMGtVWDdZWjZGTnN5VGlXVFdCdXByKy9WQUFjK3c1KytXNmxiTDB1NStQ?=
 =?utf-8?B?NFlFZFZRQ2JhL2pGU056SlFLSWFxSC9rZGJwNHdVcXpyRHgwdFp3N1BYVDBp?=
 =?utf-8?B?ZVZleThwY0NsRFRoTldYaUVYVTN5Q3A5Tk1BTGx2Wi84RUw1V2M2L2xiT2dZ?=
 =?utf-8?B?ZnlxcGVBV0trdFBjU2FTcXBTaUl4cHVldUVWbzIrbDFZUU1UcUttbE5id0pu?=
 =?utf-8?B?L3ZDUU1DTTVRVWdJK3BqNnRUd0JLRnNCYlFvemF4d2N4b2hWZDJOV0JreHNC?=
 =?utf-8?Q?8fFF4E4jdtxZn/Soe6K1jAMif?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 563e23f7-8a89-4a5f-805a-08dde559db8f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:07:05.8403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYXtewsxRY1tQdyWi4/HHxJupw9TdQkDjcxJEjyTmNUwgEqPbDPKfogu/CBHJkRSID3Ngn160blF23C4RUicKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Hi,
> 
> For passthrough device with intel_iommu.x-flts=on, we don't do shadowing of
> guest page table for passthrough device but pass stage-1 page table to host
> side to construct a nested domain. There was some effort to enable this feature
> in old days, see [1] for details.
> 
> The key design is to utilize the dual-stage IOMMU translation (also known as
> IOMMU nested translation) capability in host IOMMU. As the below diagram shows,
> guest I/O page table pointer in GPA (guest physical address) is passed to host
> and be used to perform the stage-1 address translation. Along with it,
> modifications to present mappings in the guest I/O page table should be followed
> with an IOTLB invalidation.
> 
>          .-------------.  .---------------------------.
>          |   vIOMMU    |  | Guest I/O page table      |
>          |             |  '---------------------------'
>          .----------------/
>          | PASID Entry |--- PASID cache flush --+
>          '-------------'                        |
>          |             |                        V
>          |             |           I/O page table pointer in GPA
>          '-------------'
>      Guest
>      ------| Shadow |---------------------------|--------
>            v        v                           v
>      Host
>          .-------------.  .------------------------.
>          |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
>          |             |  '------------------------'
>          .----------------/  |
>          | PASID Entry |     V (Nested xlate)
>          '----------------\.--------------------------------------.
>          |             |   | Stage2 for GPA->HPA, unmanaged domain|
>          |             |   '--------------------------------------'
>          '-------------'
> For history reason, there are different namings in different VTD spec rev,
> Where:
>   - Stage1 = First stage = First level = flts
>   - Stage2 = Second stage = Second level = slts
> <Intel VT-d Nested translation>
> 
> This series reuse VFIO device's default hwpt as nested parent instead of
> creating new one. This way avoids duplicate code of a new memory listener,
> all existing feature from VFIO listener can be shared, e.g., ram discard,
> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
> under a PCI bridge with emulated device, because emulated device wants
> IOMMU AS and VFIO device stick to system AS;

should we document it somewhere?

> 2) not supporting kexec or
> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off", because
> VFIO device's default hwpt is created with NEST_PARENT flag, kernel
> inhibit RO mappings when switch to shadow mode.

how does guest know this limitation and hold on such attempts?

> 
> This series is also a prerequisite work for vSVA, i.e. Sharing guest
> application address space with passthrough devices.
> 
> There are some interactions between VFIO and vIOMMU
> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>    instance to vIOMMU at vfio device realize stage.
> * vIOMMU registers PCIIOMMUOps get_viommu_cap to PCI subsystem.
>    VFIO calls it to get vIOMMU exposed capabilities.
> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>    to bind/unbind device to IOMMUFD backed domains, either nested
>    domain or not.
> 
> See below diagram:
> 
>          VFIO Device                                 Intel IOMMU
>      .-----------------.                         .-------------------.
>      |                 |                         |                   |
>      |       .---------|PCIIOMMUOps              |.-------------.    |
>      |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |    |
>      |       | Device  |------------------------>|| Device list |    |
>      |       .---------|(get_viommu_cap)         |.-------------.    |
>      |                 |                         |       |           |
>      |                 |                         |       V           |
>      |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>      |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>      |       | link    |<------------------------|  |   Device    |  |
>      |       .---------|            (detach_hwpt)|  .-------------.  |
>      |                 |                         |       |           |
>      |                 |                         |       ...         |
>      .-----------------.                         .-------------------.
> 
> Below is an example to enable stage-1 translation for passthrough device:
> 
>      -M q35,...
>      -device intel-iommu,x-scalable-mode=on,x-flts=on...
>      -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
> 
> Test done:
> - VFIO devices hotplug/unplug
> - different VFIO devices linked to different iommufds
> - vhost net device ping test
> 
> PATCH1-7:  Some preparing work
> PATCH8-9:  Compatibility check between vIOMMU and Host IOMMU
> PATCH10-18:Implement stage-1 page table for passthrough device
> PATCH19-20:Workaround for ERRATA_772415_SPR17
> PATCH21:   Enable stage-1 translation for passthrough device
> 
> Qemu code can be found at [2]
> 
> Fault report isn't supported in this series, we presume guest kernel always
> construct correct stage1 page table for passthrough device. For emulated
> devices, the emulation code already provided stage1 fault injection.

just call out this series is only limited to gIOVA usage so far. vSVA is
later. :)

Regards,
Yi Liu

