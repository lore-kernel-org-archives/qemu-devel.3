Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05B2C54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkbft-0002Jw-26; Wed, 13 Mar 2024 23:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rkbfr-0002Jh-4n
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:22:31 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1rkbfo-00056y-GL
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710386548; x=1741922548;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oGUxH7FTlCEr3E4SGWGc0+/SNvN1LnQJLSyeRrE1Ofo=;
 b=jPXUBLMc6Cc6ZrnCY4hkwgvJmlMh1mNDJbjufEYT5fbOy4qTvPAwc/of
 mzf/GG4Cfe+Mt0j4AVM9zk9DzJN+c1dJfQbGtLeJZ3FL+ex1PfnWcvwS7
 Udsq4DS3CJIsFXnS8iRDG/9cnyKMp79JCwUvY4YW7+TCKMYtqHN0xBq2y
 gcU2QubNotopMT3YLhCEyNYfw0DqasawTSET8lQGnQztuM0FhFCSEhMM3
 arjof25xa7fn2vCLMKW14isXX12i0AvFEwQm/vhNL06iLwt6BLQAx+WYw
 0pNPe/QRJmnMBRXaaneMdSUB2+b6blOfo2FeAbgZEh9tG9+ObZ0R3LkUY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8966343"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="8966343"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2024 20:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; d="scan'208";a="12164101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Mar 2024 20:22:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 20:22:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 20:22:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 20:22:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 20:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kucd+Qut6heQwNls6N99fv2/IYgGRRX8qVK/jo881WlJ1d4QnEwjgujLSzhFzIBM+46m/ENhBkB89i60huKTJqvPHopz2RtK1cb98REEDUZQOGbXZc58wTZCz6a77yl7saOBAS643TGro83dZHx28W4ykDX867G+wlSnmW4XosrsiKarqE9VvfqqWAxVxGDxlqLDVIB5FiVNvrnJxJbKvNfIfK/oif/zX7AdMa1HfgGfOd1DOzi+lXwQOJ/44PU483nl44phaioeQFzGQHSOinwcwYhe1uJIlt2e5nfWBAPyg54Xe7TlbzC2sSMBg4ZCZtwOQ1B/KbTtoWc9U4cP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+pWw4ERtXPbjm98aWEAf6TP8WiDG41hu0KNxouZ/SY=;
 b=nZ7zU/f77Ml/Fw1W5qNfNHDnCZbQZLLUPtiIIpDFaDjUrI03dOihIniC0pg0wvRWz8eI7Tey9LRyadOys+e3V3mQJuDaadQuSLoX2go0vOxyiCTH7Npd1WHuZ6dCXRfFvzZcm/NBw/0wqpsaEGjrH/BbAejs853Owb9OKNgiTUokM5CJtamO2XagDbUuxHYgL0WzoKwq9hRBRv1oc3vP0p3W9RqksmxO8kqLxE98+frwi0d4aMtju/dN283pJtYFEYP2He4K+Mt1yGOajJMDxUBnbGUCWaqrA7jYgcHtga+sX6UB0AhCGx4/f6aOR7tRS8rUCIV/ELIvzIDOcuuA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Thu, 14 Mar
 2024 03:22:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7386.015; Thu, 14 Mar 2024
 03:22:21 +0000
Message-ID: <a947bfd9-4670-476e-b90b-cac03632ad3b@intel.com>
Date: Thu, 14 Mar 2024 11:25:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Fix memory leak
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240313210628.786224-1-clg@redhat.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240313210628.786224-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1a5d25-ecbc-4eff-041c-08dc43d5f587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ybnopo5Qi3mNj0ZUgub++Wv5z3TQgNF3Yn5PZGIQjOeytfnUChvmU63MyQoPTy2JoyAA5EFHN9+PehVtcYK8nIkJqZq9uJgup+HYj7xFKkh8lePfQVvX7zqgzBRABuk8OtfGjCJKL1Uu+74IPa3A3OyXHraJrmI3jSg32zUbAoWPrjf9MRxQV2fSTXjDoZ0I1rZ142MXEL+lnFDV2Qubw5XgtSmw4qcRe6nVcYwbPKbH0+XXHv4oqJf6yZ0y+gFPV0tMzzb82S3Q+qYCzpmvWPTzqdVPBTia1W1BQMsHMVpjf9ZhQ7po74akhCr7lPA6j65y7dwY6QuvFPX0fUs0SV/eihYt+cNWrgGuUoZRd4V+ngFxFVjwCxYwmFUVzOoom6tYAYsHZzRz1c9zPPOPUAau0b+Creekh0AJ/NJwG4WtPpvm44OVaLZ5IP/wBCyVVtf/0Kcg29XSDJYTKumDpF/YvJGQZw3tm9BBhpXP0BxAEh9sKCMj/OJlXahs4z60rYZSiN2hvJR1v6PNCUD4iknunNFQdlnpVSDVkEMnyoSaG7R0WQh+2BbpyQtUSvOcg7SCW7scWqgg8ttSt+rYUhD90pZS8q0hoxTD2vlu9oKL2lUi8nYko2iNtBdNO/BLaR1wfugB8J5MxCtMgYvFZN1aWIPR6cT2+BRs5dNshHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJJWXY5dmZ0QmpVWDM4cllBb2FScXNWS3QzdDNaSHh5R1dnUzl3UXRpeG45?=
 =?utf-8?B?OEtQSHY4Rjc0SnIxMWh5ajAvRGl3cStPbjh2aXJhNnIyTnNObHVHWm1iZmYw?=
 =?utf-8?B?NlIzQlN6dEJPYUF3NUV5MVd4TlhSWDdFdEJDd2t6ZU94Z3BVTWVEeU9WVm9W?=
 =?utf-8?B?OXJaNjBBZ0gwNWNuVkNYQWx6Q3REOERIZ0pvenRLY01CdUJKMWdFZ3ZQWnE2?=
 =?utf-8?B?dE1RNXlrUUtqd0VqM0hSa3k0TXA2SUNGK1lZUExCMnppR2NDMytUb00rNmM1?=
 =?utf-8?B?bVVmRG1Dbmlld0dGTDhNUXNKL1lYb21ONHVDd0ZTMXdJdzBIS1MzM0hIZW1m?=
 =?utf-8?B?VzV0UEFKc2s4OWtnRjlwNVZlMUgzaU1EeFBBVEU1OGVVUU5ZWEgwNUZrd3hY?=
 =?utf-8?B?NWpuZXA2WFdLcVhxWGgwNXE5R0lSQ1FwNmFmK1htaXR4K21iNGIvSURnenlM?=
 =?utf-8?B?eGFIVWZZOTNDMXFiYXpnKzZaNjBpZ2swQjZhTGd5M1Z6VmtIenNsejdEOG4w?=
 =?utf-8?B?Uk80K2prdWk4NVNDVmhnNVIvNGZiQlY4SWlVaEZHdWlmd3VjTHR2eFVXZUF1?=
 =?utf-8?B?NlphMTVHTEdJL0MzQVVFZTFxQVdiNC82UldTRjRURmx0NkZXdU01akpNaEsr?=
 =?utf-8?B?Z1pnUmNIUWZwZHYvak9YbXlrMVlISndudllNUENEYTBONVVsa2IzSDlYWVB1?=
 =?utf-8?B?dmFMS1BtVjVGOU8xdTd5ck92Sm9CbXp1Z2xURHVtMktsU2p5ZXpEbkpTT1I3?=
 =?utf-8?B?VGdSRHVvTjhkN3FVdVoxTk9ReEJkS0RjSG1YZy9KUmRyVUZQVnphYTJFQmw5?=
 =?utf-8?B?Z24xSE5tQ1djN3l0WkZmdlUyQ0xnYzIrWWh5ZVA3czd4SUUzUXJSRkZLZTgz?=
 =?utf-8?B?MCtrUElyR0RtOFF6cGtGV29PQXJCeW54N0I4ck01MHlGT3RqdE9GUHA5UlA0?=
 =?utf-8?B?QlJ4VEQyV3R6NFpFbWhUd0M4cEl1aXdibnFwVEdDSGtvN3hpbGZPMWZ3RW1Q?=
 =?utf-8?B?TFBpV2VkQmpNRHpRWG5zeHBJZzRMaFE5UG92Q3l3UmwxVHR2eFNxSklFWi94?=
 =?utf-8?B?cWZ1SkF3OE0yVGxUbjhvYWVnTG1EOTczUDVnd2pwWVBaMGpHV0RhdURXZFBJ?=
 =?utf-8?B?QWNNdHFhcmk3VkxLQ2FhK0xtcEpWS3YrYXZNTCsxTUFlbk0yNTdLeEhZUHZF?=
 =?utf-8?B?VklBL1Z0Ky9vSVd6K0dsazZINjRwcWdodStGL25pT3pqbFhnWW9aTWRTYitk?=
 =?utf-8?B?MzcrZS9OYVdzQW5HbUtOMi9nTW9ZQnBFU3dXUFRFN204L3lIN1dqc05mSXVp?=
 =?utf-8?B?YkRLTnFQYWVBQ0NsNVVaUXk3eUdKRTY0S0FsaDhncnJHZHdJek5tbFAvQis3?=
 =?utf-8?B?OEJ5cHZ4REt0UTEyYXJVbEFBdEFPbE9RRnd1VlVFKzNWZEtsbGhENThpcGQv?=
 =?utf-8?B?THhxZkhKQVJGSjRHK3VXVElxeG1GQXd3NEFyS0lpL0QvVUVLZUl6eXBxRVVR?=
 =?utf-8?B?UHRuVXNmMEdaRVBSYkU5R2lHRHI3Wk45cGxaNTZ1dkxLUDIrdndvU0RNVzl5?=
 =?utf-8?B?M3duZjNoUEs0SFBCNFF2akgzMUQySnhBTmgrZUR3T2V5Z1Bpd0h4aFBTckNJ?=
 =?utf-8?B?akJYcXhHck5kQXAvWWorUDhiM1B5S0lWcUpsWEZQYkEzQmkrczBHQ21hTkRs?=
 =?utf-8?B?NUx2elhTTW5iaWVlUWZWQlVlbG95Z2FKeW1jazdnaEt6WUloNlArZjIyVUpO?=
 =?utf-8?B?R3RBL1dPMlc4M1ZPYXdZNDA2VkprWGNZelMyd2Z1T056S0tkWXJpdVJWYXZR?=
 =?utf-8?B?ZnQrblgwaHlLZHd6M3VxWCtDQ0lYcmUzd1pIT1RJejdueGJjZ2lFTzBlemNB?=
 =?utf-8?B?RXVuU0Y0Mk9ZZjBwMnVkNk8zcXd6V3o4K3pmbWk5SjFTRFpFRFY3RlhqaDFj?=
 =?utf-8?B?TXIwZ3FCdEZMVCtDdThVemdjS0NMRzNqRkFqQ1ZJQ2dhRG1pM2FwQTU3UTdm?=
 =?utf-8?B?Z09sVUE0aUtjRlF5SDlWUkpYMkVWWEZHb0s5R3VGdmpzdmt0dEVsVkFNeVlN?=
 =?utf-8?B?c2laSm9YQmNYNStrRjhpVlg2VTVIdnRJckExM2hlYWtBVFltNTVQV1ZXVytC?=
 =?utf-8?Q?3lmkIsBEwiVVEChGHQSmqnsKf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1a5d25-ecbc-4eff-041c-08dc43d5f587
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:22:20.9303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bz052m1BgfAXVIII89HWOraZVJZ2/62q46UVagYpIFM+R+Z1DyR/R0v6bqhqos9B9wLbAXP2uZsV8WrjNJVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/3/14 05:06, Cédric Le Goater wrote:
> Make sure variable contents is freed if scanf fails.
> 
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Fixes: CID 1540007
> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/iommufd.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index a75a785e90c64cdcc4d10c88d217801b3f536cdb..cd549e0ee8573e75772c51cc96153762a6bc8550 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -152,9 +152,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   
>       if (sscanf(contents, "%d:%d", &major, &minor) != 2) {
>           error_setg(errp, "failed to get major:minor for \"%s\"", vfio_dev_path);
> -        goto out_free_dev_path;
> +        goto out_free_contents;
>       }
> -    g_free(contents);
>       vfio_devt = makedev(major, minor);
>   
>       vfio_path = g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
> @@ -166,6 +165,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>       trace_iommufd_cdev_getfd(vfio_path, ret);
>       g_free(vfio_path);
>   
> +out_free_contents:
> +    g_free(contents);
>   out_free_dev_path:
>       g_free(vfio_dev_path);
>   out_close_dir:

good catch.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

