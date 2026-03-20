Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D24A108B8E7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WkK-000232-Dh; Fri, 20 Mar 2026 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3WkE-00021L-Lq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:06:20 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3WkB-0003l3-IE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774001176; x=1805537176;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pTymYP6RdldMJCYkedJresa/DhPovophzyzuCW+5BuY=;
 b=mngbfME2or3NryxZKR5+hLjb+zh18+WHOZsUwYFVYUlFFZWlM3EatGSP
 aICLKHEvP3fwvjZK7NjvgGIGrYKJMDCDjb0IyjeRwcGpxt6sfYOpRJkGI
 myI8sclO/sR7u3vSmPD6NdNilmpadlxJSxOpysY/cWB+n5wQhc54n4jS/
 s0k8wMA3L+oytifonwQ19EeroUgasZpznySNxTPvhCPbtZpqNeynjMfZz
 blQ9Ccm0sKYtq5R3Fd1lVua2NXYC5EHZwYjlsDCAWFQy7N40gJyUuRmLV
 3eOm52Ms5RXXd5Ge3HRakHsog6clfxxdJuQN/2hj2/rzxXoGy+iS8VZ/E w==;
X-CSE-ConnectionGUID: qy22caIiRtGl2ScmAF8M5Q==
X-CSE-MsgGUID: gIXKKh+lTpubkKIhpstoeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74992511"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74992511"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:06:13 -0700
X-CSE-ConnectionGUID: 6FyWGC9cQZeN6H8055zUhA==
X-CSE-MsgGUID: k2l4pof0TJWtabWjqU+oxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227717135"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:06:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:06:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 03:06:11 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fnfe4IgcP0ayXyw5WivZG7c0OrdPU+dIVNYFepdiZDQ/lK13XolcPp1AbdqRPfe0TxJMJiuFHlQWK9HrnD+vX6tTBsOlGGD5hokCFTcRncx8clECGpwLJpETunFSGyFT4I9OXPjc01JLG+1VYaoWsj7yIP97hBB+x3vhsMVVOujT+lMvl7yfAS3EA1DJHkKMp+ZuA3yfWM/g7fFLbLU9Zx3BDIGB/RilzOMHtodpAGky0WmrCF3RmSKKO8GxsYyYq3PQDPl7VYtjbQ+aSBTnhpwt62B10QOfTWXBdgmV/Tm/1RyF/YB9Si9rkCR9DHWKtfhufOXvWYRmH9rNL5M5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM9sM28SOWXAVxi515YhYv8i03sebkOchbRdgfQTMfo=;
 b=dhIToe/YrQrn3vytQrVbVZyVG11ritDXYD3lAJ+VtVVVOqCmrfL45MwHTFVMXWL4LE347TiZ6KeT5gxzs8YVPz3te4a8HvRJ1+nyGsn9KiHwfjo/Etqf7Nbd1UoW7WZmnQWTf5kOn8QHM08TF4DGgxoaC9Ucr8TCW6asghOTdvThi/kr8XQZh5Ea5KjOcYzo8BMXKAKu/xZ+gdB9VTON3Lq9+UevJ8Ktjc6zkfpc1eelqToMT1U63GVS/KfBS1bMBbMJ3yBPUwSnK9k90aCbkISKZ/Da8VHDQpmJG/6FtGsDhGVrf0nLQ1PHyWNylPSn/aMQKGO3jexr/s4OREmr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 10:06:05 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:06:05 +0000
Message-ID: <9d6ef338-48b8-4724-8a5c-fe610a98620e@intel.com>
Date: Fri, 20 Mar 2026 18:13:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
 <e8843f0e-61ec-4425-ba25-62b85b0e5371@intel.com>
 <IA3PR11MB913681B1F3E8A68B3049D0F0924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913681B1F3E8A68B3049D0F0924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ff416-8b31-4d1e-2272-08de86684c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|366016|3613699012|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: SZSWVC2NA8LISlrVDhqAOt3esbzKmnhn+IfcLF9WP+A2YOO4tgn7pf0QVy/bVZn2Pr7Es04AXUsbsm2kq7FKgUhMPfhoPH5dPkobk3TJrfaEy+xtCiKoTKbjsMddtVaJBxGQzPzSvNrcq6Bq72Ohqs90glka8jdhloTmoT1KubrzpuyahChYq59va7N7b6lXjzJkVewp0ntc3WI9b2WugimD0joAvs8TNGir4mHFOl3xREa/EnSEnI6Fz8pFh8jhpJ6iV8wH+TlmKf3cKGeE2ChtKaal/8p7qbGXktt9i0Fa7BHrbQaxifPwrAHKpEaCS3DtvDHmRtrM5fOXV0Xn1BjLCo5+eCwN+Fo3WX3PO5cJqtst4OvLLSTydsEkNBJO51ZXZnsqANEPgIpihAKNDGcxCRa61oUW9maBBQOaKC5/+WsENTTJx3qq6ug59KBaIcge69IBLd/WiJVWX25DwyFC5agzXVCmqESegFNZKg2nZPsLYCOJGYC74MM3/Kwyjktg1TfedhGc6z6NaJkSHRQllCQVZ6fMvNLtOJ2bHQxSfCsqgkU8LeYr2TEaTQyItEkuYXzsGsv6BgXYo0pYlFiQBRK5s6IDN1kGe7H6VaZGRGpfvzJHzOaBmQWQ+8CrtovZTVR65ZKkAGDOClZjOKMVDm/qDoCvxh5sMvUS6qytlGFlzBzEpDECE/1lERdEkIcomUfg+Nm2SW8LeyVWcK+y55U1eX2DnyyB0AVEkPsId5gLVMY975z5ZYFy3HcbDtkGREkby1926KVZ7Lpnct4+1M19URbPOELPx1US2RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016)(3613699012)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjluSElISFBMNERGYS9XM1hjZzQ0QWpYelc1SDlWOXRsREoyejhBNXRXSFZa?=
 =?utf-8?B?Qlp0a3JEUnZYZllTUzdvVFB0dWl5V1NSWGhIaEVPd3hFSEJ6MDBOb0VMTVB0?=
 =?utf-8?B?TTVISGxYVjJLQVpXNE9xQVByOTF3Wmc3TDQwS0lGV0hyMFozdTd4UDhJL1Ba?=
 =?utf-8?B?dzlmVWJNTWpWdzNHUFpleS8wR2QzZmtZOHNBMDEzRGo2WUJuK0JTc0RSdFpH?=
 =?utf-8?B?U2s1MS8wZVUrNk0xV3owNnhqbUwwc0RzUitDWG55RWpMN3kyOWlrbENQT2lO?=
 =?utf-8?B?VXFZK0MrWEVxL3NkTGVqS3BLYzJ0UTZHVFZyS1RMUGJ4K2tYUnJaMnFZNjBS?=
 =?utf-8?B?K2x6bHVSR3ltZWhqN1hhci9ZU1dPSmxwZ3BlMWpJMkk2ZFhCSlJ1ejh3WXAr?=
 =?utf-8?B?RkREYjFvdEtaVm1meFF6NDBxcS9qNzZYTWpFTnAzOWRMNis3ZWxaWEtxVGRQ?=
 =?utf-8?B?eXZReG1Ba0tmV1BpbTZHc1JvN1hQY25LcVpqZytBNFI4b0NIa2hxVzdkQWwr?=
 =?utf-8?B?SU5pSk5YTHpmWjk5eWd2UC8zT01pNUsrN3hibm10dE9XSVdKTFFQRDllbitq?=
 =?utf-8?B?bSt1TVRlbXR0blYyaTJxelEwM0Z0RmwwUUtqYVhtdEU2M1oyanp2alpnY3lX?=
 =?utf-8?B?T0lYd2xyd0pmK1pwWG9yK3VZbzJobklLTWFNTlB6Y1FCSkQrQU0yS0t5ellG?=
 =?utf-8?B?MVJHbFVOeDNESlJuUUkxcDE0eXNDYm91QWpoM05vK2wxMHpIcUlSYS84WjdS?=
 =?utf-8?B?Yi8xOXNwL3U2YlJXa3F3bE5yd0RHN3MwWUhJek53MnhOYmFqcFZyLzNLL2pP?=
 =?utf-8?B?QXRtcWwwREhORHkrOEJSWHc3Tjd0WVZsVmNWNmRRVmdQdklUVDlKOHQ0QlBz?=
 =?utf-8?B?d0hOTFhiRThOR09wWnRYZmpHZzVVMW9SakM2SllZKzlsbkZCUy9Zcmc5WW8v?=
 =?utf-8?B?dzNDR1FRMk5GZVZoc3RzQmJDTnRmaHBNRm82WHdGWS9MNXZlL1pMcEwvVzZV?=
 =?utf-8?B?b21weUo5VDF3ZHNWaFZzVWhJV3doOTBtWHI4REdxeGE0MGJvb0ZGeFljZW9o?=
 =?utf-8?B?R25FN3BUQUdBMHdOOGZydWpRQlhuelFsa0ozSFZUbWgvT0xvM0dscjhqK2hx?=
 =?utf-8?B?djkzdlZmbFNqZjdrMVAyL0lueTlZTmtjanRUZHZ1cEdUR2ovcVc4QTlNYWxL?=
 =?utf-8?B?cmszMi96TXh2SUlKWWQvZFBZTEZzL25CSDdJMlBEVjhSNjlGYkgzdHd1Yzg2?=
 =?utf-8?B?UDZ0Wk1QbUxjUVBaWEt3UmVVSTQ5ay9MaXU1Q3d4YjF4dzNDeTVvQ2I1QUo0?=
 =?utf-8?B?L28rc1RBdUswRThNQ1dKUWdWVkprM0pPemxERERUVTFrWDFkV1pHRHFHNStL?=
 =?utf-8?B?WFFpN3c0S1VSeStyMUhWM1RJT0FNaGtxT3QvcHF2bmRweVFPWFp1bHFSWEJV?=
 =?utf-8?B?UTJjQjJGa29wNVptVjIwZkZ1NzlPczlBRVM4TnUraEJ4WUhSc0dwYkNaRzlF?=
 =?utf-8?B?Qy90RVBYbENVVmZia1J3SG1RY2dGU0dUa3dSOG9zalQxSENYalBGQWpiTVdI?=
 =?utf-8?B?V2dDRnd4U2xGQmpOZHFVeGY3QUpKNGZoTGk5QnA1U0lEOHArbGZIR3BrRk9y?=
 =?utf-8?B?REZ3bzFCYjVoWUlDN2ZMZU9oZmV1K0xtNTdlV2pwNU52VXkza05nRmltOUZi?=
 =?utf-8?B?eFN4bjhnR2hVTHV1SThMVmZNVDVmOVI3ZXFSRVZqSnBXalJaeVhWV2JNSm9S?=
 =?utf-8?B?aEt0U1N6MXZaOTIzYzJpeEprT1NqOXlzUmVuZ2IwQzVFWXdxTXlxdmJJdkVk?=
 =?utf-8?B?b0FPTHE2Tk14b3B2UTg4Z1FCNUNZV0ttV1FUajdaU2FXcEJWZUo4RnRSVnl2?=
 =?utf-8?B?SC9LcHRrSlFPTjNjYmJFZmRic2VGRVNpZGdIdXZaMW5lT3d3THB2K1V0cjFv?=
 =?utf-8?B?VTBYOUhjbk5XVGoxTFhjSGp2TC8zMDc0UUpZK3ZwcW9jNFM5WGFpaXJvR0px?=
 =?utf-8?B?S0ZNVndsaEhHTkdFVFdvK3gvajN6REEyTXA1RkZTOE96b2RZWlRVUUZxUVor?=
 =?utf-8?B?QmtEOXFML3lwMStGUy8vMFZPWm5jakEyRjBwQVR1cFgrcklubWkwWkMrSzl6?=
 =?utf-8?B?MHdzRkd3R0NDdXo1NEVKUG9DQU8zcWpRNHQ4RkM2RDE2aTJBWWFKYTJpN2ZW?=
 =?utf-8?B?L3F4UzhuK3FyT1RZcjg1ZlkycnRHRmhabWZWWGxtS3M0Z2NCWFVwdGdpZlJv?=
 =?utf-8?B?OG53VXNBZE96VWgxN2dkS3dWSk40SWw5dmxVQzBSWFh2S1RYOGdmMlVCRVZ5?=
 =?utf-8?B?QWpZZFhXYnE5dnpYLzNMZ2loV1VwZWFXekozNUxmcTRrNFI5MFZHQT09?=
X-Exchange-RoutingPolicyChecked: dCHFoTnkAhgHAePEAM2q0v7YT936VlO6h0hmhOVeUc8TM066/DvS7VboTDJPEcq6eqp2ZQpmUsp4L3xMqBxGshR2UlCw9/7hpQz+9IloxlIfIHWS/6e26KVT9IfjKHmy5y4mYlNUZ739uKuFPIhcHakXiYHUmixFF56v9H9iHvPN80hesYnzFFi8nL3irtSuw9t/lnTUuPj5hYapdW+7dU8qY2ulUZh3hP2DdAUU/EBlM19T8heGliKIPEdyPX+w0YR0JiMX0+6klV70wqhh9RBctor9qrb50p04ftmUtrAUWBN4+JSvj+OKWhhWW0MBm1sHUw4JQF4TzrgkSg6EFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ff416-8b31-4d1e-2272-08de86684c67
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:06:05.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyGPlJ57L98YrAAO3DSiE2mRf9xm7pQmKspRc9Yo3xfZKthRIs7xLCY9ALGHim3eLbGs9csptZ5ocjzGxpxxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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



On 3/19/26 16:26, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
>> pc_inv_dsc request
>>
>> On 3/6/26 11:44, Zhenzhong Duan wrote:
>>> Structure VTDAddressSpace includes some elements suitable for emulated
>>> device and passthrough device without PASID, e.g., address space,
>>> different memory regions, etc, it is also protected by vtd iommu lock,
>>> all these are useless and become a burden for passthrough device with
>>> PASID.
>>>
>>> When there are lots of PASIDs used in one device, the AS and MRs are
>>> all registered to memory core and impact the whole system performance.
>>>
>>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>>> of a passthrough device, we define a light weight structure
>>> VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
>>> will use this struct as a parameter to conduct binding/unbinding to
>>> nested hwpt and to record the current binded nested hwpt. It's also
>>> designed to support PASID_0.
>>
>> PASID_0 of passthrough device still need to register MRs in case guest
>> does not operate in scalable mode. So for PASID_0, you will have both
>> VTDAPASIDCacheEntry and VTDACCELPASIDCacheEntry. Is it?
> 
> Exactly!

better to note it somewhere (commit message, code comment). It would be
a good hint for future maintenance. e.g. it is easy to forget this fact. :)

>>
>>> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
>>> (pasid cache invalidation) request, walk through each pasid in each
>>> passthrough device for valid pasid entries, create a new
>>> VTDACCELPASIDCacheEntry if not existing yet.
>>
>> I think this idea is ok, but we need to be clear about the
>> boundary between the usages of the two pasid cache structures.
> 
> Yes, the principle here is VTDACCELPASIDCacheEntry is only used in intel_iommu_accel.c, VTDPASIDCacheEntry is only used in hw/i386/intel_iommu.c

just mark it in commit message as well.

>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.h    |  13 +++
>>>    hw/i386/intel_iommu_internal.h |   8 ++
>>>    hw/i386/intel_iommu.c          |   3 +
>>>    hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>>>    4 files changed, 194 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
>>> index e5f0b077b4..a77fd06fe0 100644
>>> --- a/hw/i386/intel_iommu_accel.h
>>> +++ b/hw/i386/intel_iommu_accel.h
>>> @@ -12,6 +12,13 @@
>>>    #define HW_I386_INTEL_IOMMU_ACCEL_H
>>>    #include CONFIG_DEVICES
>>>
>>> +typedef struct VTDACCELPASIDCacheEntry {
>>> +    VTDHostIOMMUDevice *vtd_hiod;
>>> +    VTDPASIDEntry pe;
>>
>> let's use pasid_entry here as we already used it in the
>> VTDPASIDCacheEntry. Sometimees, it may help when for searching related
>> code.
> 
> Good suggestion, will do.
> 
> Thanks
> Zhenzhong
> 


