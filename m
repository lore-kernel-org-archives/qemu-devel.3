Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwm9-0004cz-Do; Thu, 21 May 2026 02:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPwm7-0004cU-2G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:20:55 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPwm5-0002XC-0G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779344453; x=1810880453;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nqRfD2OjxSKX3SFpeDLZvHUptfxo4MDmKFuR6BEOKrM=;
 b=iIlvasLMYi9wGyGQPBzhjLKitXDTDIbbWMMrtIibPzRQjUffdoZJaWEy
 U8NW2NvHgRZk56Mkh1NCulCsl1/rPrIJbM2xNkBPPhZxkjJzLiZYbn0X+
 zhkj21d7TPhTP/cJvOidT4D1ybnbhYf7rWHOpX8DRGvne5PelmOLyT3By
 27Z178tnwGNpmXy+OK21ZXUWxgOA5TtVR0wPpl7dHFekt3Zu48bcSlTwy
 HI679COmxXjqD2F0GBy+4sHkiL7y4uUMjaG0QadlCDPOFH/GgX20O+0C8
 3GlDYTh85pSZXHE2W36PXDHY6mQZ9F/GOUearaJOX8O2ndab0hbZZ9azX Q==;
X-CSE-ConnectionGUID: FgdqDrSZT8iUyGt4DzyFhA==
X-CSE-MsgGUID: TbaZVF5LRSOQdcKZCydD+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="67784215"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="67784215"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 23:20:49 -0700
X-CSE-ConnectionGUID: 4NZTzrCDSqu6qY6nikLOzA==
X-CSE-MsgGUID: kmYk2kHeQ+W7DWzL2Z/A8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="244737954"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 23:20:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 23:20:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 23:20:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 23:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3sCBCKFoBLUWuX6qEdTGpd/5GvpLn5NQZBHO1awlrSnurdgQhY7UYwPZzPkVSzA6IKCVCtT2FSjsz6BLzs1TSRyoQn3yrdRlAYxZeCi9h/r/EXEabx+1bIJ22qNjalzI19XTZ0iABF9WXhRVi7q9rg9a3cFe63qR4OZw0hxUHM2n/Az4QVoMsnKNhHygp4LuxfXHnAxA9N+LR/vs0uN3M3M/vA+e16YQeP9p83DEJHVd5NlFq6Ry29JH5inkoMSN76+cjZKwB0I9ukvRcuymstd9kgIUoRWjCi6MPqzG67VHlAz67UG1ePnqBrZ9NpKS4gn9Ijwui+lajP1Ku+OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9+SQP94smZTejmsSt7XG90TfpV8zBUshJyYdr7YfsM=;
 b=fOBrZfopXxkdmwOWx1JzYMXTm1XaMOVKcPlJFWtgWZbGxg3b2d1d9T8oLkgcJBrUuiJmYcopFzbi/1hsY/AUYU6vvmfX3MPm0bKcMNdmUPvEz7632gp9Mmlm4SwTvj+Km6qk6uekof2Z90rpEjydYicFATF9Rip9FmIx6cPFP7Z9hNQI6VJ6NGXP2ttZu6mpaBFIqM+Cd9xiT0NfG7CRFWAXvJfrPpRMIOJNbcHJMCj1LHFBYZBmeVVOUaRP/NtwrfFpGEY6f4UXpV2Q3aFjaeLdd+Kea24YQAksBm+P+sE+IqNMdmTlsaOfbRUgFaB3KSsNFZl1mtZng/Yd2j80SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by MW4PR11MB6619.namprd11.prod.outlook.com (2603:10b6:303:1eb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:20:44 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:20:44 +0000
Message-ID: <16d2698f-7fb1-4718-8e90-7979a3e8d0b2@intel.com>
Date: Thu, 21 May 2026 14:28:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-15-zhenzhong.duan@intel.com>
 <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
 <IA3PR11MB9136F28FF99D26A8BDA1E2B692012@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136F28FF99D26A8BDA1E2B692012@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|MW4PR11MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ead190-dc49-4fdb-9862-08deb70116d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|366016|4143699003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: XUU905tg90z6c0N2h28ok8ZAglK6AUAAyEgdh0ewz92tYeiozn/rjG/AY0EdvG0Kl+h4GBeubbm6I1J58nEU5x75RskS8QKiXqTXNisPEyyXKE2jOKaoyFtI60qLLbvltywLErRS/FnFwCs/fzIwXOeneBno5yZxOXi7a6ut86EQPtNS9ly+gkVJyinVV3UBoE2Ljvnz2yCMA2AR2XpWaYAINcaqTfg75rCZRc9Vqr6Y+mj4ioLf3uBZYucvwkzk6Ojm0KKXGWPyuY/FnZ7ovnxrPGD/xWHv0f9iS2GoSnnSeMkNyFOYDkkvbXSPb3BV/nYbEujpJab7+QGrkCt55s1mUaW0Ngnklql73tpAZPPfj9A7pVyWPWF0mEP2Ng9Gjz/1JNG+2sv7PnrV8cTTvtpJyhUg2lOz9gfU11iMohjyreAYHREXcpbG1erK3D1mw31+HVbet8BxLDWzzry9keM5m5ClemzPTpbcbdAr+7oQbHYPXBU5uYmixopIdDHC/BY4RZyuxSjQ2z1VKLCKUXgU4MvU7txGvHSmCL8mtR2vkxsbGOv1WFG3sx3kjRG3cZORgVS5IILgxcnjuOruBh7890MjZTmMYNXJ7xKuR8QKlrBf430DtICytgbkGWklh/Lq5YomQ4eiEEsQsbj3BT6Qj7kV25DU6ok6IzvDJZ0Vy1D80s9DyJeegJW9GvZj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZrMXM3dkszWWd6eENXZGxxd1JNbzFnMGZWM1VBd0hRS1NHZ1R5ekovZzhI?=
 =?utf-8?B?ZmFTVWxLQytkYW9CV0ptS05CMHJFM0VibUVIVUYrMkxqN1FrRlhkVkRqdDZO?=
 =?utf-8?B?MnBjd1BibkZIbCtlaHdCMjZqeUlPQ2xmUDhrd2lOTDFLVVp5RzhBMkNYaytU?=
 =?utf-8?B?eWY5R2VBZ0thY1BHTVp5cjhTK0p5cDhqVnVmOVhKdVZOdml1QWlqTWtMWU5x?=
 =?utf-8?B?YVBzdSt0RldsajF3dWV0N3VoQXl1dkE4Szh3aTFpTFdqSG01Nkt2a2duYXVV?=
 =?utf-8?B?QUgreFFBZTUvOGlTUFpUeWliODlsbjZqd0NjdGNyN085UEErVVNhQVQxWktL?=
 =?utf-8?B?K0dnUURMeXkwZGlpcWhCSElHTkN3Yzc3Z0dWSGVsQzZYWFVpUDB3LzVwbGp6?=
 =?utf-8?B?VkdhSGdUSmxVU0orOGFPQjV6dXpSNS9UdTAwZFdCemlPTXlBdnZyL1hMMXBF?=
 =?utf-8?B?N0UvMzFZaklCY0hvb3VEVGs0SHZHYmJzZFNyd0pSYnROVzJCSEFqd0ZpdkN0?=
 =?utf-8?B?VWE5Lzc3cnl4U2pZbUFtdnk4Zm0vd090NUJpYW43OXVSdmV2aDlvZ09LK0hk?=
 =?utf-8?B?cUtYSUtOLzVoMDRtVmFINlROVWMreDNsTjJyV3VOVVFCVklTU2ovK1FIRUd3?=
 =?utf-8?B?N25tdS9FU1NiM3lWMDF3aEEzalVKK1FGV3dqWE41NWYxQVFLV3dseSt6ZVNZ?=
 =?utf-8?B?YW51RUR6WEJkekhTRU4yQW1kbU1HeFZSejE3YmxHdkhxMmRVclJjOTF2T3d0?=
 =?utf-8?B?a2dIQjBGR1FRMXUxTkNqaG5UZTZGL1V2L1MxWU40dVhSV1VBV1c1bk5XcXJi?=
 =?utf-8?B?MEEvdjAzM2JCWmRrVWdQeVA1cXJUUTJUYVpTQWdUbURKQllpcDhiQ21zL1hO?=
 =?utf-8?B?dG56a0V5UHh2Z00zdS8rK1YrV0tnVjljbzdPR3I5SzR0dHRjamRNUkZLVWtB?=
 =?utf-8?B?bWNHNEhuckR5dnJRY2NqR1VjbGhZMjZPTVcwc2lIWHhYUHU0K1p4WVZjSmdR?=
 =?utf-8?B?dFNQbUlGK212am1zaE10akdQNWI1Sms0WU0zaUUxajUrcXpJTWZXbDFNb3Vl?=
 =?utf-8?B?WEpjOUpRSHZMYlFaaG1qVDJWNklxcTk1dkZ2Tjg1REZXY3dJVDREUzB3ZFlp?=
 =?utf-8?B?empWVEFVRFYxbEUvMjlpMDNESFdJL21FQmM5c1duMXc5Ris3TXpaWkJ0eFZw?=
 =?utf-8?B?YmI3UWdMeFZ0TW9Sdjh2ZGVaTkt4SFU4T21uSTRLdnZXZFg3WEllRjIvUGlr?=
 =?utf-8?B?MWxjVGFHbjRhckd2L3B4SUUxdlUvOXZkNkUvT1YvMndZNVJPR2o1UXZ0NkF0?=
 =?utf-8?B?UkNqOW9oVGUxaEY0U0FJbEpBd3IyQlpnbXhlTjQ4aVFSWHA5Q21vNFJvcjhS?=
 =?utf-8?B?V3BDaU5TWklpU0MxSFgzNldPVmZiV0RVMVhldEQzQ0hiU01OdVI4Qk5lKzJi?=
 =?utf-8?B?bXJFT25LMnFyVlpQR2xOelY2Vm1Gdi83UzRmNDRwQ2lScjBnVVZTNDdlN3c3?=
 =?utf-8?B?ekxJZWZNY014Z0UxWnlwRGVENmYvdUsyMTFJTXlHL01kSnplZnE3bkhkLzF1?=
 =?utf-8?B?VTRDNlFsR2l0WURkcDV0c0FOMnQ1Z21BNTdTVi9YWkdQbnhyTUh0eThpRi9R?=
 =?utf-8?B?bGxtVlJQTEVwYzFUSElaNzBLNHB6YnAydkpwQjQ0bWNMS3picjBmMmkxMlZa?=
 =?utf-8?B?Y05tQkVKbTk3eHFkdTN3ZjFMNkZUd3ZDeWZZYVdMK0MyZGZXOCt4eS9NbTBo?=
 =?utf-8?B?Mll5d0RpS1FQM0FTUkxmUDNYNmVpdStNR201Uzl5QmdyMWY5K2JBQ1pidVJY?=
 =?utf-8?B?R1hGYkJVYStTdDRGNEtraE0yMlpSL2Z6cGprOElrdEtGZVpZVTRRQ2d1YUQy?=
 =?utf-8?B?ZHVWSkVGOU9ZYkZFVGRFTythK0dMOUd3aE9vUmRkNDB4UlpMRmVoZGNpTDU4?=
 =?utf-8?B?aTNYTzhHdTdkODB2R1gxbVk5L0lsV0NKYmdNSDk4MlhqNmRWbU56ZEk3TjM2?=
 =?utf-8?B?aDdLUW5ubk5XOE5Gb3lJcjArYzdvRGNJd1JmcmQ0RXRpTDAzbFRyNktNYm0x?=
 =?utf-8?B?emZuSElyY0dpS1ZrUnJYa2NiRmZWWlhFb2tWekVKek1RbVlKWDAzNEN5V0Vo?=
 =?utf-8?B?dXk0SmVMczNvZEZ0ZldrUlVLYVJnak1sdlV0M1R2OHBsaFVoZlpvSmlvVXU1?=
 =?utf-8?B?THkxZXNZcTg1K2c3S1U1cEh2eGNRVlJTZW9sekVxcWJrUmtrR0tMNDEwdndS?=
 =?utf-8?B?dXpjcGMwWFYrcEl0N0NLalBWMmNDNDQyM0dLdi9kWStlWTV1T0VGZ2JuNURq?=
 =?utf-8?B?dTJuUzk4MEtvSEhWV2xDYmlza3d6LzNFYisxYjZHVEJ2YlJUVDRxdz09?=
X-Exchange-RoutingPolicyChecked: EJ60AmzesghJh+MOKqKHC1TaVRS38NYlQhpGSghdYq8P4bAtDonttasWOsaHM9j2BOmDBskHmc/EG1G2r5idIAFt8qqgFbh6Avh4/wdXgCEFNvivZ0iQ/zq8p6IKSoEGqoLrprtymREzcZXAviOHHFXDCCNefAiD4Zb2D8xzvvlwwWpk4l4YWMxcbvH3h8r9LXo0optV9YZsA2USHPfmCTtIB1aimW7X3UE1bbXejSMeAf+EyhsXxeHHs+OQpkQAsHM65tTXra9q7gkG2Xz1YXlCJ3qfmtnRQsYcM+zKvZf/fVGowLKw2pSfleZgd06lg3bzDCn8ICfyp4VTQlpjMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ead190-dc49-4fdb-9862-08deb70116d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:20:44.5461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSLTyMH4wUzp9WYnCTtq63Ox+ViLDSJoxIKbXmPUVHGaIgWS1ssl5+9URxDaz7AT6OjV0Ih3Q6MqVYgKSGgZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 5/20/26 18:38, Duan, Zhenzhong wrote:
> Hi
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
>>
>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>> If pasid bits size is bigger than host side, host could fail to emulate
>>> all bindings in guest. Add a check to fail device plug early.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h | 1 +
>>>    hw/i386/intel_iommu_accel.c    | 8 ++++++++
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 2c716c5297..519af3fa90 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -196,6 +196,7 @@
>>>    #define VTD_ECAP_SRS                (1ULL << 31)
>>>    #define VTD_ECAP_NWFS               (1ULL << 33)
>>>    #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
>>> +#define VTD_ECAP_GET_PSS(ecap)      extract64(ecap, 35, 5)
>>>    #define VTD_ECAP_PASID              (1ULL << 40)
>>>    #define VTD_ECAP_PDS                (1ULL << 42)
>>>    #define VTD_ECAP_SMTS               (1ULL << 43)
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index 4ddf66262c..a0dd6b0ee0 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>> VTDHostIOMMUDevice *vtd_hiod,
>>>        HostIOMMUDevice *hiod = vtd_hiod->hiod;
>>>        struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>        struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>>> +    uint8_t hpasid = VTD_ECAP_GET_PSS(vtd->ecap_reg) + 1;
>>>        PCIBus *bus = vtd_hiod->bus;
>>>        PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
>>>
>>> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>> VTDHostIOMMUDevice *vtd_hiod,
>>>            return false;
>>>        }
>>>
>>> +    /* Only do the check when host device support PASIDs */
>>> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {
>>
>> the second comparison looks strange. hpasid is derived from ecap_reg,
>> while ecap_reg is from s->pasid... is there any place that changes
>> the pss filed of ecap_reg afterward? I think this check should be
>> against caps->max_pasid_log2 as this is the value from hardware. right?
> 
> ecap_reg is from ioctl(IOMMU_GET_HW_INFO), it's not ecap register in vIOMMU.

I see. I misunderstood that the hpasid is got from the vIOMMU ecap
register.

> My understanding is that guest kernel will pick the min(caps->max_pasid_log2, s->pasid), so checking the two doesn't make sense?

I think the caps->max_pasid_log2 should be the same with hpasid since
both are from host. Also, I didn't see the logic to pick the 
min(caps->max_pasid_log2, s->pasid). This is not expected just like the 
aw bits.
We fail if aw-bits > host aw-bits.


