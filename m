Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9A2C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhvHc-0004Di-UN; Wed, 06 Mar 2024 12:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Terry.bowman@amd.com>)
 id 1rhvHa-0004DM-W4
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:42:23 -0500
Received: from mail-dm6nam10on20603.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::603]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Terry.bowman@amd.com>)
 id 1rhvHY-00013e-Ts
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:42:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AC/ztYEHBBVFHtE0S3Ds3kXzmMAQ8F9QcA9cnd4RVfQHxCEiQC2JA41Ux4iTu8xKsYMesQv5veTiwbF91Bs3xIKerwsuKNYVvqAaTW4CkdWImU3YRGc5b4ZnNTJIzSEDOOz3FVmYUDkT15msVhT1kESlCpx/oy9u0yChdEjamfuX14whLZhdcal2td77xozWjAmswNTSYFpEr3O+UTtYJrm9QNuULGrzU84lur1YYJ/hwT74D8fNGHpUH1ZjCsV/ZjqGMRKlhdU/rl+Nsl5whFlK7PUV/Ea/jCH2bgN7hETOti526zazOO4xk1ITKywY6pCkuUwXatpAQ8/cDRbFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMHC4l527MMTPItKzdiKmhB/jCNxjNiGHfAm+vKLPUs=;
 b=lUCM89GHaTX5mYiukPHTNJeNhY4oSLH+HOzCNJWqeOiQSI7zYInLC8qm7aBb/5GlZOzc8pHGP2hDiN17Ie+PXX3euxKE8ocL7DtOB9+ZSCYjf5z+zntmHVfo9RL4wiSw25fXUzfTriqPul2BHKIaVXrLSbaj03C2BmUHM1TCk9/KbMQCAwWPV/PbHh46JeiKSQAxbISA+WYPfuG8hffrkcFinnbpiOZFHP/FcnKlCju6OXrnO/B0dwszTZ66LXzOdSOgPw1ZuKpPi3pk37Zstc65HGJ8p88Qmze/X3z8cf6h15vRjLy0nbS0yvIMBiqxORpahCbp2qycfgncqPvEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMHC4l527MMTPItKzdiKmhB/jCNxjNiGHfAm+vKLPUs=;
 b=USMnZhiswai8Rzh3D3F0O593F/0xtKSZjvqTFMFxD65lnf7Xuyo1y86EQB0CGMcf+48JlZfyble+i9RPACsjlMTTF9ac3e7oUM/q+Y+u3GJsj2372bkN5fKJ6lHvlj/iCoukxgAlyFhhroCriGsWvL5JQIHTLTikvNNnk1a8JNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 17:42:14 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::662f:e554:5359:bfdb%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:42:14 +0000
Message-ID: <9c0ef3d3-d7a1-4dda-a625-adb4dfb70b61@amd.com>
Date: Wed, 6 Mar 2024 11:42:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Robert Richter <rrichter@amd.com>, dan.williams@intel.com, ming4.li@intel.com
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
 <20240306132359.00001956@Huawei.com>
 <65e8a4d74a411_1ecd294f@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <65e8a4d74a411_1ecd294f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 552c2c0a-06cf-4ad0-7a7e-08dc3e04c288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E774Af1l635cPKn3IIsyYmCFKJPl1EclLKgpsdpwOYju3bS5em8v0WBbEYnAv2M5vwpcsQvxzM6RPy04pn8lDzySguw5wknJTsnw8Wp8tOuShETYETDSR9/xYu6AqOrKprWAyX6qH6ljThk6YJWSSPImhlKSRlEusOGneNrAqCaz39qsAJmQPsohXIxW0vOsU9ODgcCHME0Y0QZyxQykg5IWaWL+u+/vbIL6imI4n+YpBAMG7OBFv+DzdMetoXdFkKe1Aj7w5rANPUgiDh9HGDpjJmWRdogN8csTBN0lVxHtrQpE3aWRX0VyNcEthyzPWjaueeCAWG7iriUfbrvX1NJ0jscKLG9xRa0jUdLAwqaTBERSrSjRa6PtihakzEs8+MMKe9VYwRQdpuiVZ/GesDM5rSNfR+DY/YwID5f/ZZcDW25nsGGq4S0QRr8GxPwUmGATytVylwNjSQJ+V74854JusMulrHFAcw9LUn78PWRr7QCLVew1v1EA7fvvoMgwcF/IaEVjPGxGkbulEo0uCkvUj+M45W2T6tZIB5HXidsjKjdLwcJ+KRhHAMTlisKhSF/KahPOo62ZpqZIEewxYXU9p2gdj/+efmpKHRYdABtWviY+nS4EgYQksri8YDTBWxkZYxhFrS2t1KiFCP2/gj2ZsS7FIfJkwUTpHww0UYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHV6NjNseXZJTkRhWnBKMTZrS0dQdlRiTEN3eFBaQnNtSFpVYmdCd2NkNE9G?=
 =?utf-8?B?cURzUmdBSENoQkFoUk4xWGY2WE5iUm8rdUdlck9FT2t6d0I4SnJ5bWNhVC9k?=
 =?utf-8?B?Y1R2VTVFWUtGOStDeGk4emRTWkhyS2RiS1dkaUJsaFBta0l3RWw5Z2I2ckJW?=
 =?utf-8?B?MmNyWUVSYUR4SGdVRy91MU45S05LbXJqTFBqWml3MU5yeHlTQVhYaDZpNjNZ?=
 =?utf-8?B?VG1hNDMzdklEbGwrSlpwZHZqbW1KWmd1S3Y3RzhsUEVOSzR1akpwQkpYVEQ3?=
 =?utf-8?B?c3VaeEN3TnMxWjJDdU9VRFlhV0wyaWtCRm9Nb2s1VEdUL2pwQWJ1V21WYkxI?=
 =?utf-8?B?NDd4TlhNYWZTZG5obldHMEhwWXA2dWV3YVVuMjZ0ZzdXYUJFNFVhRlJpZFJT?=
 =?utf-8?B?YnRNMjJBaW9nYkdBMXhONmk5OWhaVEhleGx1MHQvck9wQW5WeC9waU9Wamxv?=
 =?utf-8?B?T3lDL3BvcElTTnRnU0dLdzJ4OTNaNTRTN1hYYmU1UlVnU1U0Z2VTeWlxOSs1?=
 =?utf-8?B?aUtHZkswcXBacWVzbmlsSHNpN1A4c2g1bWN5dG40blJSZm1sY2J6ZU5aS3A3?=
 =?utf-8?B?UVJWRncrR2pIdERIRW5UQWFsWFVyQ20zQkE1aW1udThDYlNWKzFROUY3OXV0?=
 =?utf-8?B?c2NhQ0cvY2owMktlUW9WaVdvQlU3bWh3Ti9idjM5eEpRMGphbW5sR1U5S1Qx?=
 =?utf-8?B?ZW9hSlFnSGd5TXZ0WkRZRU1VcCtHR3JJK2pxcWhMVGIrR0hmNDZCMHB4KzJw?=
 =?utf-8?B?VzdsOFRpZ3dkYW5iWXBrbkRKUnh0MSt6Tzg4Tkp1WDVObmN6U0VHUWdRS2s2?=
 =?utf-8?B?UmhpRDh2d25aTDNxckIvQ0pybVByUFdPNkVwbjE2MDFNNVl5MW1HOUZ3aS9w?=
 =?utf-8?B?YWlSdWNxdmVRTk1ZN3dqNUVqS0poVFNpbVRHODNLaXVSYzRscC9VZWUzOStu?=
 =?utf-8?B?d3ZJRUNvTXl0VWZqdmlTcmE1TVJuYXNRWVI4a3hHQ0w1MFNjaU9NNU9QVGlG?=
 =?utf-8?B?dEh6a3d4MENvVnBvUHRRbzJVcTE5emczcXpTTFoyS3ozRDB1SmhMRDlNa1RS?=
 =?utf-8?B?OUNUeXh1cDRyUFdkSEt5ZGJGdjlIdTY5WWlCZkQvcVB3c1JPZ2lkMm9Ec0Zv?=
 =?utf-8?B?UFR5Y0Q2K0doN084aDgwVXhobGdyaHNaUHBWOHRkZkhIRnZjMUp0R3Z0MXE1?=
 =?utf-8?B?MkxGK3ZVVUpyMmo3cS9ReVhnMzhnWDM2TG5VejZkTHVnRnc2MlZ3R3REM0s5?=
 =?utf-8?B?aGsvSzluckdVQmR6STkwazlHZmdZQ0RmMUxtTlY2QjJHZUVRU3grUi9vb1Z4?=
 =?utf-8?B?d1V0c2xibXQxelFhTm4rVTk0UW1hRDVLRm5iWC85ZW5iSFpwSGt6aFZld0RL?=
 =?utf-8?B?c0dqRGU2MHErRVlNbU01c0NJZDR1UmhLOC9ibEF4UXNJZERock53VEIzb0J3?=
 =?utf-8?B?WUpETHhtYTlpb1c5NW53Zk0yN2pQUytLVWN0a25sM1ZzeUxva2pYUkZRbXg1?=
 =?utf-8?B?eXRqcHNDZ0xGaXZId0dUWmJlVnZ6UjA3UDlZaWNPdG9jeFp6cTFlK1NzVnFL?=
 =?utf-8?B?aDFxM1Evc0c1NHBvMTVLQmZlWHZkbzQ3MUpKeTl5Z290d1dMRVVyNlAzd2JV?=
 =?utf-8?B?cXdOSU5GeTUxeHhSaFFJYjlKamZmRmRlQVo1Q1BaWXVvNFh6MFl2aENrRzZV?=
 =?utf-8?B?MHRjcTZPT3c2YlpFRnBSVGRDVnc3dmJvSEpzbGZweVF6Y2VRcUdhRXFudm85?=
 =?utf-8?B?Y3ZTblBqMGJHcXRTVWJqREMxbXFFNVVybnBaM3Z0YUpUZDBqTm94Q2Z2MEdm?=
 =?utf-8?B?Vm5JNWx4OE90K3VDTHBzTlhDZGNobTNjT2pjdjFGWkVhc0NaQk84ZSsvdkgz?=
 =?utf-8?B?Q3dycm9GVm9SbzMycWZ1UTl3NGJ5NWtqYU5ydXJTcHBFR2R6eGFZQmRCbWlS?=
 =?utf-8?B?YWwrVWpnQmtJWXF0ZFBtRm0yZEorTGtWSEdKTkwzWW5jQkRoV2JjV0VZbFFx?=
 =?utf-8?B?ZWk1SHV1MzhUR1U0aVNrcmx1MnQ0clZJYy9OVGtFK3k3SXVJTGFybEJjOXA5?=
 =?utf-8?B?VDRQWlpiSktEcFhVamhNRCt1N0tNQVRaR3V2YlBDNVI1RCsvblQwZkFrRXJF?=
 =?utf-8?Q?Lh8iFiNjGldEhJJKaRJJLiuFD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552c2c0a-06cf-4ad0-7a7e-08dc3e04c288
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:42:14.5491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QLTedHWlSgiReqy1IS+7y51o0LRrpgLFJJwh2eWaPc7Z8nctprNZoilnNERqNh64gJPz1RoKwSPocSV0i9ulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
Received-SPF: permerror client-ip=2a01:111:f400:7e88::603;
 envelope-from=Terry.bowman@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi Jon,

This appears to partially address the same problem myself and Robert are working on. We 
are working to add support for CXL port devices to include root ports, RCECs, USPs, 
and DSPs. This was covered with LPC presentation and discussion.

We did not originally include RCEC error handling support because the same is needed 
for all CXL port devices. Also, we wanted to avoid adding more CXL specifics to aer.c and 
were looking for a more general solution. This led to the discussion about changes to 
the PCIe port bus driver.

Regards,
Terry

On 3/6/24 11:16, Dan Williams wrote:
> [ add Li Ming ]
> 
> Jonathan Cameron wrote:
> [..]
>> Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
>> some discussion on walking out on VH as well to enable this, but seems it
>> never happened. Can you remember why?  Just kicked back for a future occasion?
>>
> 
> Li Ming has this patch below waiting in wings. Li Ming, this patch is
> timely for this dicussion, care to send out the full series? I expect it
> needs to be an RFC given concerns with integrating with the pending port
> switch error handling work.
> 
> -- 8< --
> From: Li Ming <ming4.li@intel.com>
> Subject: [PATCH RFC v3 3/6] PCI/AER: Enable RCEC to report internal error for CXL root port
> Date: Thu, 1 Feb 2024 05:58:08 +0000
> 
> Per CXL r3.1 section 12.2.2, RCEC is possible to log the CXL.cachemem
> protocol errors detected by CXL root port as PCI_ERR_UNC_INTN or
> PCI_ERR_COR_INTERNAL in AER Capability. So unmask PCI_ERR_UNC_INTN and
> PCI_ERR_COR_INTERNAL for that case.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/pcie/aer.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 42a3bd35a3e1..ef8fd77cb920 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> -	return (pcie_ports_native || host->native_aer);
> +	return (pcie_ports_native || host->native_aer) && host->is_cxl;
>  }
>  
>  static bool is_internal_error(struct aer_err_info *info)
> @@ -1041,8 +1041,14 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>  {
>  	bool *handles_cxl = data;
>  
> -	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +	if (!*handles_cxl) {
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
> +		    is_cxl_mem_dev(dev) && cxl_error_is_native(dev))
> +			*handles_cxl = true;
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +		    cxl_error_is_native(dev))
> +			*handles_cxl = true;
> +	}
>  
>  	/* Non-zero terminates iteration */
>  	return *handles_cxl;
> @@ -1054,13 +1060,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>  
>  	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>  	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;
>  }
>  
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +static void cxl_enable_rcec(struct pci_dev *rcec)
>  {
> +	/*
> +	 * Enable RCEC's internal error report for two cases:
> +	 * 1. RCiEP detected CXL.cachemem protocol errors
> +	 * 2. CXL root port detected CXL.cachemem protocol errors.
> +	 */
>  	if (!handles_cxl_errors(rcec))
>  		return;
>  
> @@ -1069,7 +1080,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  }
>  
>  #else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> +static inline void cxl_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
>  #endif
> @@ -1494,7 +1505,7 @@ static int aer_probe(struct pcie_device *dev)
>  		return status;
>  	}
>  
> -	cxl_rch_enable_rcec(port);
> +	cxl_enable_rcec(port);
>  	aer_enable_rootport(rpc);
>  	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>  	return 0;

