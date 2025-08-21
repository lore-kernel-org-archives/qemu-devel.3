Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7971CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0sm-00013f-At; Thu, 21 Aug 2025 04:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1up0sk-00013F-E3
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:42:50 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1up0sf-0000dR-PQ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755765766; x=1787301766;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xYjSf7a49wGgF9/GPGvaLC17CpSsH7tTajZbSQViKjs=;
 b=TnH2tOCewUdJ9XNzLE9cg9qsD5g6RQR5t9Sea9ISbgSjaeXyEnPjMk/V
 /JvoK+QAWsv7zGN4fkAZ+NfjCjPmRjWJcN7dkS1zYzBoeWCcI2IqoipXr
 2KnSXNGwBeUJwPTCytyIWEtJHya8GiBKykUbXAyhBj5fQzB4sZ8zEqSWT
 4kyK3NKWeWE8gVnnkVy2s+mUIehbQInO0inL8Mg8LbF7jWvtmjSKSS4ZJ
 EERGlG44cYAs6hHHBsqOB4l9MAxY0sDU6vXpX29p6UukgJZwUmhyXdN5S
 4CvEA8fSOu/OwjD8W+WhtxptaTVymLw+f9uMzgxqohr/nqS+PwiS2IyGN g==;
X-CSE-ConnectionGUID: wdchmIzjSCmImSF7sx3i7w==
X-CSE-MsgGUID: FTDJ/QyIRuGKLnxRTzkXjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69489058"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="69489058"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:42:35 -0700
X-CSE-ConnectionGUID: ezrQcR1YR3GZfEISE1xiKA==
X-CSE-MsgGUID: DgBsA9H2TLmcfZcBw+3mjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="167583456"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:42:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:42:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:42:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:42:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1uvKnSwQsSVb9MvNKOzymZyFkWuGJjrwbpbqJLaPdYgq2HCX4YMA2riM+nieCWKD+kFHJ1KvEAzffHMILwoRl3SVcGs7WdB0tz/UNhFRjk7qhcytDDjEEDU7QvrkM8oLQnHxzHt/JLjET+y0nil6jYOJuHxccGy9il8WhELV/OB8s18pe0J4+v1UzHpU6udoAt1QwSaWIwfJsW5n9i7tOUVaKqbb+b4sw8JE01o6qDVl9622bXqCeg26HBqjUUxBRFOqm0yhSy+c7ttzIDU6LcJ0/YdNUYio0TFz18OxYZpTXfxW4WcO9yy/jEKciSOlK0P404AyTkUJdsT+KWKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8zwNd4emqjsgsxiOlF98vWBUPOK+IDRzs8XSsWcndE=;
 b=Zf024Lsm97scnJfgcc3lNUQgiE4rptQ5UhrIVHKdIiaqCF5XWZz08+kU/4tWzd8v6jFdd3a8gD+4ThvFEiGVVY5+znfs59kWjH9vhW/0tbIK9/PZUO+p0HKw5TNNJWegW0t+eqddwXLzryWKg9VWLguYIOx+ISYm3p8or05qagaA8PFrUYdS6TJlAEKnWxLfDb9YCNCfTDQS6jyKPMxLFOXFuo+fsiZMczulhQiHRLICcEFXN4LLrqXAr+kKHKQlxhcscu83IwjRW4zGchWjweBccrtA9mL7nMwUnwi0Rp0Cylr4UMdnpOAD5Sano8stnR0FF5ZRHmdzvU2/z/Wjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:42:31 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 08:42:31 +0000
Message-ID: <c70bd3a7-62bb-478c-ab30-7f96159f6f12@intel.com>
Date: Thu, 21 Aug 2025 16:49:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
To: Alex Williamson <alex.williamson@redhat.com>
CC: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
References: <20250814153419.1643897-1-clg@redhat.com>
 <70d6d913-239d-42a4-8a88-a492bf5e569f@intel.com>
 <20250815082009.2ed1d2a0.alex.williamson@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250815082009.2ed1d2a0.alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 441de0bc-9f34-47ae-5308-08dde08eaac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjdDZ0hTZUJnaGZWRGxwR1oxZU1DcitTTkZPdjI5cHgxSGk2bngvN3k2eEhN?=
 =?utf-8?B?R08wN1FDRi9hRlA4Rm9iRmJIN04zbTNyUFNqS2h0YUI5Y1RxalRLbS95SUF5?=
 =?utf-8?B?S294VXVjZU40SWE4aU5LWkdvbTlvYllOSTBGb0dIeTlnZXR5THdQeEpaVEM5?=
 =?utf-8?B?dEdFWm1NV3o2a2RDOFUvd05NVnV0dTNaMjVEVkt1K1hFQmwyeXQ4bjViOTFm?=
 =?utf-8?B?WEV6Z294QVdZQUdlS3l0UisvRVNwNlZlSDlEd3NpbVp2Mit3QnRidU9LcGxi?=
 =?utf-8?B?VkJnU2xQc0g5K3BRbGtTY0E0WlVYcGlPTUw3ZUdaZW12T3BJOU5HVUFIbFBX?=
 =?utf-8?B?K0hUeVBtYWF2T3ZTSklwTWhOK3NxOSt0Y3kzdDdUSVAraDR4bEk4MFRVR3Jz?=
 =?utf-8?B?Tmx4VzM5RytLSTFWdElKZTJLdThNRDVzZlFaNkVpcURtaTZxMDZYUC9Yd2Jx?=
 =?utf-8?B?ME52M3NaRUwxcmVZd1dtMllUcThpWnRVUTZDWk1YNFpaejNGanhIOEMxYWxw?=
 =?utf-8?B?d2RzVWdTMWhNNFo0dHNtRDZmTzJySUxPMFVscVU2LzNyNEJDRkJmSG02ZUpn?=
 =?utf-8?B?NzNlMGhOc3BlWWY4aUxNaFhTTVhrQmtjUXhTVkdDWkVGNG1WN3hQaHFjUHJF?=
 =?utf-8?B?alFOYWxIOHk0QnhyalcrbTRFOTFnbUpWUjJObE51c0pYaUxqbHJtVkt4Mktw?=
 =?utf-8?B?SUZCLzdFNVFFRU9oTmQ5amRyTWlGeFNmWjh5WCs0N2dTalQ2WjAxNkp5aFJl?=
 =?utf-8?B?VXNsZXltQjdVeHdwMlFSazZqTmZydDgyWjRjczV0VWJRa01iZXpLYUFTczUw?=
 =?utf-8?B?ZW41bisyeFNZV0JLcGVTRXh6Yks4Ty9keE5yVk5tdzFiTVBGSjNWbWJtK2h5?=
 =?utf-8?B?eE1YYlEzdWUralp1UnNQZ0Jabm5tbVdQWXh4c0QyNmlidlY0UEhDTVZaTjhX?=
 =?utf-8?B?ZTZ6Kzh2amhLNlcxb1FyZXpnNHBqKzgzQzNmZFR5bURXMEg1TzlzRVBwa29L?=
 =?utf-8?B?Y3VWd3VZZzg2bTVZQ0hRNlZrK2xBbmJ6OE1BT1dOMDI3a3lSN0NUVFB0YnRY?=
 =?utf-8?B?Zm5LSGVYQ3EwdnpkWm43b29DMW5LK0R1Vm5FRXJtNVBianl3aVBmcWx6SFZi?=
 =?utf-8?B?dFhEeXNxOWJFc0FOem4yQk9VMjJOdVRmbXovYlMvRWp5UWtBb3N2VTVwRXJI?=
 =?utf-8?B?RXFyZFUza3o1TG84VzBwZDlCRFEyMEZkZVgweE5ndWNiczBIYVRJOFk2TDNO?=
 =?utf-8?B?ZUplNDRXWnI2Z3AvVG5XOG8yN3hyUzhwZHc4NDRoL3lTNUZEa01OdW9SSkZj?=
 =?utf-8?B?RWZRVlN3aVVzMUZFdkhEczBDTGZFZ0Z6bkMwTGEzSnZ4RjdPemQyWGhtc0pt?=
 =?utf-8?B?TVNZVkU5QXFYVnRmWS9aeG9hNzRUYXNXYXppQlU2cHhUVmNnbkMycVArRXE2?=
 =?utf-8?B?TmFZTzlpQ3Jqc09iSlN4d2poVFNYbmh4bEdFOHBlTVlKcGR5VGdWWjNKMTcr?=
 =?utf-8?B?dm1TcEJPUTlrTWJJN2hvMCtPcWpCa080YzdFQ20xZ2J4aEJTL2Z6dFFMV3Fw?=
 =?utf-8?B?czU1cStRY3F1bGM4TFN6R1UvdHFBckhxU2x5RTl3Rit0Z3N1c2puLzNLcStZ?=
 =?utf-8?B?aDI0L2x0eHJqKzIzbXA5UGVXZEFxWjE4dlMySVN1MmdrT096NDFSN3BxUStI?=
 =?utf-8?B?V3NaZTVKa2pmNTBlZUFmenRiUjRBakUxTjBRQVFJYlR3UG1ISDR4cWFuTHNP?=
 =?utf-8?B?RlFHdmRpN296Yll0emEvVXV4VGxMYzlLMmYyaExnU3doN05kTGNmMEpMeXlC?=
 =?utf-8?B?MVo5L05NMFF1WXpselZnWkczMjRzdzFtdUI5YXltREEvNEcwWXpvUXpVVTdk?=
 =?utf-8?B?VkpZcTJqem1raDU0UXlXd2s1MmJIc2hxcTF4MDd1b2ZnL1YxNUFXVDdVeFM3?=
 =?utf-8?Q?M4vgII/VJd0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3l3T3NJbVVSQmd6ZzNuTVFBZXZmZDkzUXN5aUNEM2xvcUFxMVVtQkt1S1oz?=
 =?utf-8?B?ZmYvWjNFQ3FiSEhCSk9uczRUMWlIOXo3Q2ZkU1ZhTXN2d1JYUmc0UUFTUU10?=
 =?utf-8?B?cG96ZzBwNHd0YXhoWWo2MGFFdllhTGV0U1ZSRHJZdlp4RVZYYW5YZnFyM29I?=
 =?utf-8?B?dFp1YjB1bDg4MDJxUzhhWXJYcDZTTWtPMm1DR050ajVDcnNtNm9sbndnVkF4?=
 =?utf-8?B?Mk5jTlh3QkRsZ2JkTXl4SjZ6TENmQjN3UTNwcndHOVVpc0c3WkV3L2cwWUpB?=
 =?utf-8?B?UVcySUZuNjBzUkJzczl6VS9sVkc3TEpPcVpJNkhrZGNheU1rbWt5QnlUaU9p?=
 =?utf-8?B?VXc0VXY3V2h0MlJIVG55NmQ2RHZwSXN3Q1R0MmVuaXdMTGY3VlMzUmcxbU1V?=
 =?utf-8?B?N1N1TCtRMXdOYVBlSng2OEhndzRRZVcxTjkzaDNKTi9ZRWhhbWQ1RWNHRHAw?=
 =?utf-8?B?VDAxYy9ZL3JJa28wV1ZqSVdoTi85MTk0OTZGQ0g5V2FZQjFhUFBSYlppWFov?=
 =?utf-8?B?MGFmNWY3Mjd3ai9YUUhNYmVmeWNpTGE5bmREaFM1aE9Eb2J4cXA1elduQk95?=
 =?utf-8?B?ZW1zamFBcDBNQjlQQjgwUXpOQ2hqWGlXZTNVWU1lWi9xVmRMczd3bWVQdjdN?=
 =?utf-8?B?NzhsWGlwVnJhMENWSkcrQitxaldVb2ZiWVhZeERFK3ZRYmRob3c0RXoxbm5L?=
 =?utf-8?B?eDNLOXl6YjJpeTJSZG5OeWVhUlRwZmFsL2hvaE1BUGNMVjhJLzV2NG9LTjZa?=
 =?utf-8?B?dWVjZ3dMbm02YmtyWjB2azZydkM5dXc5QXBhNkJZR0RyZ1VSR1FqaEpkTXZk?=
 =?utf-8?B?eEpUNTdEWDAyRHl1SUszWFFmL0lad0FWWVF6S3NsZExTd2lBL0FLVHpCbDM2?=
 =?utf-8?B?cmMxOTZDMmFnOWlEZ3pQKyt6ZE14eVk3NStJTlQrWEF6L243dWVMZVcxM3dn?=
 =?utf-8?B?MVR5QVhydDUzKzh5STN6UFAvMFp0RXkxM2VrdVNvdThrMFp4Y0kyaW9rWDhr?=
 =?utf-8?B?NGFIbWx0eTFRa3VZNnc5ZmJDM0FaSnhEbGVYZ3pvdlJ1L1dpRU1HejZXalN4?=
 =?utf-8?B?WDVQcTVoLzdpOE1GbXAzYVhjbWQvS3NDNnJEM084SGxlV3UyRndLYmEyU2I0?=
 =?utf-8?B?K1JVWGViOS9URmZHZXRweFlOQkIyd3l2SzdybXYzMGg0eEl2Um1uZklpQVVa?=
 =?utf-8?B?dWQ0dW1ZTkkraEJScml6VENPWnVvS0VwODZLZHcvU3duc1B5cmE2aGZGOU1E?=
 =?utf-8?B?MmxMdlNLUUg4UmJZZzFyNW5ablhWSitUTXBTYmRGdy8rdG5EV1QxRGx4MTNE?=
 =?utf-8?B?QnRFbEJTVWJUZzNaL2liZC9TSW1Wc1FRZVFsMWwvalU1RnVPRW9zU255aGlN?=
 =?utf-8?B?L29jL1JRL3l3VDMrcUx1OHpjdUFXVllRVldqamIvT0F6NldBcXZjZ2VUbGZI?=
 =?utf-8?B?S0xtUXJjV2ZveVdpZDlOMi8zOXZ2VHFPeG5rd2Q0OXJDY09vS3o3b3NMVkR3?=
 =?utf-8?B?VXVOT01mYjBUdUJvTEFRbllWdHE0ODg1b1JkYi9Mdkc4NmdMR2NNM0w3eU53?=
 =?utf-8?B?MUt0ZXhBb25GQS8wNXgwSzluUXZhQWIwN09NbDhFQWZUQjdRcElENE5ZM210?=
 =?utf-8?B?Vk14M3pZL1pLQWMyQzI3VE9uRm01bFAzNEF1bUlQZVRmTUJBKzZ4VUJjZmJx?=
 =?utf-8?B?NE1hd2VMbjFuYUJjSW1rYWNoQitPQlhsVWIremptTWgrQzI2Ri92cDBqcmI5?=
 =?utf-8?B?c2FKVFU0OHlheVBlekszaGxSK2l3aGkwL2xjT0ZMeVBlNEk5dW1MZG9ZamlG?=
 =?utf-8?B?QUh2aHd1ak5NcVozdE5lWlc3K013am0rWURFVytWcFlaRFlTalQ4RXd0eUR3?=
 =?utf-8?B?TENybnJtMTVkeVVlcmRnaXM5RHlkM01KTFg1NUY2Q2lFK041d3I0d0k5cHJK?=
 =?utf-8?B?MUlKMmtaZlJMNk5KRzhCdTJxOEczNkRZSytpcDRQR2FUWENOZk9TWllXcW9y?=
 =?utf-8?B?RFJFOHcyUVphYi9rYk5Vem9BTjZHQVV1bktGNStZQjdSNDhBZGN0Q0lObTdj?=
 =?utf-8?B?Z1dWbmc3ZWlod3haK2cxNVY0U1lOTVNEQ1BpY2lheVptQ2Njb2RDaXZnc05M?=
 =?utf-8?Q?7y9Vrfht7UICXrKzfmEzNRQye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 441de0bc-9f34-47ae-5308-08dde08eaac5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:42:31.4418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+vVGLHMSTxSaXQqQ5OMhcKuLQoYwnPxZ3yDdxAkt5SzAFNCfCiemNx5CQitkKgzwRNYCTzwzQCT00bpcP09mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/8/15 22:20, Alex Williamson wrote:
> On Fri, 15 Aug 2025 18:49:22 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 2025/8/14 23:34, Cédric Le Goater wrote:
>>> The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
>>> limit of 65535, which is configurable via the 'dma_max_mappings'
>>
>> @Alex, I've a long standing question, could you share why 65535 is the
>> magic number? :)
> 
> 640^Hk is enough for anyone, right? ;)
> 
> We added this in response to a security issue where a user could
> allocate an unlimited number of vfio_dma objects and, iirc, the thought
> was that 64k entries was an absurdly high number for all typical cases
> where we're making relatively few, relatively static DMA mappings,
> which is effectively what the type1 interface is designed for.  It
> would be insanely inefficient to map the entire VM with 4K pages with
> type1, right?!  Enter confidential device assignment...

yes. I remember there were some NIC passthrough scenarios hit the 65535
limit in the before and passed after opt a larger dma_max_mappings value.

> It's still a bad idea to use type1 this way, I'm just waiting for the
> reports of slow VM startup with large memory VMs, however we might be
> able to mitigate the security issue if we allocated the vfio_dma
> objects with GFP_KERNEL_ACCOUNT.  However, I think we also compounded
> the problem in QEMU when looking for the number of available mapping
> entries it assumes 64k if the limit capability isn't found, rather than
> unlimited.

yeah, admin can program a smaller dma_max_mappings value on an eld
kernel (a version before dma_avail cap is reported). If so, existing
QEMU may hit the dma_max_mapping limit while it believes it has not yet.

> So to unwind ourselves out of this jam, we might choose to
> report UINT32_MAX and some additional mechanism to report unlimited, or
> let QEMU fix itself, or we just advise that type1 is a bad interface
> for this and needing to adjust the limit is an indication or that and
> such use cases should migrate to better interfaces in IOMMUFD.  Thanks,

thanks for the the explanation. :)

Regards,
Yi Liu

