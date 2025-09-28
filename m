Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31D2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2mQI-0001hS-0b; Sun, 28 Sep 2025 04:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mQG-0001gZ-Dv
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:06:20 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mQ3-0000d1-Bo
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759046767; x=1790582767;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9zMGMyUY6yNobRwCAPWoS5sklIR2IMyXHVR3SrAu7fM=;
 b=lNHZVj/9UI1LeAnTEyNPKZKMcdaWwOvv+viqllVwgcj6bOmnWULOu3Pp
 Apqg4gZkGL/ucbvoA+XeeeOu7ig9VCvuP722zaZba6uwgjYIS0cCPctTc
 otjuprDw3BaV0OPsEhNhzD5UIucj9zecpj/87DahVJDmjrmAcJmwlfRa5
 20v+T51HnNy2xUlK9RBMUgkSc0Kfy+QJwHXOpxDm1rw+EN0rJHpsiR7R8
 TEGHBKWEQlo56ds8ax+0G4PaRco7F0C9b2SSHSqDqKnh8PlNKGlpbhSB1
 CFGeXC2eRNvsE6P3bc0SFfLbgrbKCQdfbsFre4/Jl9ahlwh/UVliCcDp0 g==;
X-CSE-ConnectionGUID: r83x1Em7RZmnsPOngaKR+g==
X-CSE-MsgGUID: XB+kNutcQt2oaycPtdkcMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="78962291"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="78962291"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:05:55 -0700
X-CSE-ConnectionGUID: tugkmbO/Q5u1+IY8zfOivA==
X-CSE-MsgGUID: 9jRRjUcXQ1eFHjQgmp870A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="182381402"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:05:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:05:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 01:05:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:05:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STEW+tvZilniNqlhy0cHscZ1OeOqvd2nxFUErjchBt5NdeFbbr+N/YhTB71hUWWPGltMFSRQBvS2XY92KpBE4uAKNBMU3RSCbFEQZuMMpW3X/mb71ZRdcp6QhOYpkBvgWSk5gZrKzBxKuW2XGh8vYXDPKa73MCWPweIY0hSplLjIfDdd188bBQ29A88Bqzg6wjevKtciBl6IerI9HT/YY8v8Enk7BEBPoPA+KGnIqTRc+uBbZMpBOkd+/YuPZfQDqTFqIULQ+9Iqv5AlR7UkStupP/AtoX8NTo33hsRm8AulZQ848Sy6rbJAvcLAF8pPvNBCh1Pu01BX+PZIBQBtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zMGMyUY6yNobRwCAPWoS5sklIR2IMyXHVR3SrAu7fM=;
 b=uUOnlharRQVbu59U8ryTAD3EmAI5uFRn+ESoQP5ZCcTXrWIsxmR8cMJ2xrdmdgGHBNRavoacykEvEdsWBUM+ayUxrf9NqUVhU90zgL5qF0TWMKceXhkCcxSzewYvBV5hVf4zMh/lU9eQ9yFGLmYu4kpL4b+8qws7N6Wdz586TANKQd6HPo6xz/g75oKK7rGW6732Xa8GWQCp3hWQ2/c1ub7o2dLCAeKMp907ZhigkuxFXT4bcb4wRZNR3vA/xoCDze82Y6dEGzNNllUKjKUzzsp7xZNU3rvby0DY8zcgVfX3GKkYOfxND3Rp/WnxpiCeZzUJOVNrwrAqfW2twZ1GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 08:05:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Sun, 28 Sep 2025
 08:05:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] vfio: Remove workaround for kernel DMA unmap overflow bug
Thread-Topic: [PATCH] vfio: Remove workaround for kernel DMA unmap overflow bug
Thread-Index: AQHcLsN8ZxIpqORPhkCy75Jq2QPyX7SoPzNw
Date: Sun, 28 Sep 2025 08:05:50 +0000
Message-ID: <IA3PR11MB9136A9DC4F5C6AD4746D8C409218A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250926085423.375547-1-clg@redhat.com>
 <24530964-0b37-4e44-84dc-172596e9ef44@redhat.com>
In-Reply-To: <24530964-0b37-4e44-84dc-172596e9ef44@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7207:EE_
x-ms-office365-filtering-correlation-id: a013f53a-7796-4efa-ab04-08ddfe65d71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aTJNSWxCSmR4NHJFcW4yTnhsM2Q5djVBUmRVdXdJTFFHUzlzUmQwaGtNVkJa?=
 =?utf-8?B?YjUvbndCMFlSKzVyUER1ZGVoanh3YmZoQ1U1c1AwTUNXeXQ2Ly94L0xBRXZs?=
 =?utf-8?B?bUllRXlIM0YxUnZEUmNva2pjaXJwbk42VG5qczJNZk5RT3ZwZlhDVWhkRDQ4?=
 =?utf-8?B?UlBwbWh5Q3FyUFFaTjdmeDdVUGlzWXplcnVRMWE3ZDlVM1hSS0dpMUtmbUUz?=
 =?utf-8?B?OFhkQ3hLRVJmSk9sd1lJSDNQZTU0OTI5M2NaNkJKblBnQ1lGQ2tiQ3l3ZTJ0?=
 =?utf-8?B?T0lncXhLdjBOL2dWYTZ5NExlSUpGVVVDcmNFa1hWRkMzb2wxYmRGVTdYa2gv?=
 =?utf-8?B?Mi82L2U5VzN2aFowT242MmJnRXorMTU5cG4vTktOWnR4QklrNGN5UG5USGVJ?=
 =?utf-8?B?cmt4N0o5b09IOUE3VzV2amwrd3UxYzc1TVVuSjk0NFNwV1J1Q2RoRHRUNWJN?=
 =?utf-8?B?YW9jZWFtYzc0Y0ErVm1uakxWK2EybzRDOTJ0aEVWVkJ5M0FwaXNyTFZNMURy?=
 =?utf-8?B?Y0xtOHRpVFU1K2dFcGNTQmE1ZVVrQTU5MlRGdWk3NUhUenFSTGpwYTJ6T3Nw?=
 =?utf-8?B?eHNaalM5TWJwaUptdFFOZnBIUXlEMGMrMFpBMVQ4Z0FDUVdmUXMxVDhUSUwr?=
 =?utf-8?B?MmozUDM1aFZhMDZJZG1KaHR5SS9SUmw0UEVrNWFiNmYvcTRnK2xFeXFUUTN5?=
 =?utf-8?B?MXZsdnBBSjFuamxqbUFNdlg3aisyNXQwUldqVG9jOVg5c2FZOUhNa2U0REVK?=
 =?utf-8?B?REZidnJuVHY3aXhnT2FXMWprNjRYeldaMU9vcmd1VnNCaTNDWDlqVjFjNjN1?=
 =?utf-8?B?Ui8zazVFbmp5MUFrRUJpenpvRTZIQzg4VElkdGRtYkhSMS94eTRJZzQzQXE4?=
 =?utf-8?B?bUxNSmJOQUQwTnJvamlTemV4aWJZSDBEODl2WE9hZnRZT0ZzeFZ1ZjBvUkh0?=
 =?utf-8?B?dGhKVHpsYW9sL3Z1eGRIZWFFcEtLMG01aFdVbkl1MGdrSXpsUUtwWXVzYVU1?=
 =?utf-8?B?WG90UW5CQjlITVJYNmdzOVdtZ0liRXBjbHVNYzhZTU96SzQwbFZGSFdaNjBP?=
 =?utf-8?B?UjNqUHM0S1Mzdko0QWRNbTB6OEhlbU5iaFVaWm8zUjVjQWVsZjZyVFZrNHBs?=
 =?utf-8?B?dWdiSVQ1dXcrbXkzUThHYk1iek5NNk1lU1ZXYWpiN3M0dnFnUDl5TjE5a3Bs?=
 =?utf-8?B?TmM1WlVEY29nOG9zclBvSFgvOWdJMnRCemhMQ3N4bkZwRTZ0VXVtdWl3S3pZ?=
 =?utf-8?B?bjJIKzMzQ3pUYk1xcThUK01USFNxYVpZUS9ZVCtWNzlHenZiOUdVOVNlSnZR?=
 =?utf-8?B?eUE1QlRVQWErMmlRQWlXVlNBWnNQMVJRSWtzY2xGOERHekF2aVNGRm15V1BK?=
 =?utf-8?B?aDlJQXlNT1ZrYTFKSGVrSTVpNkF6eVl2ZDlQN0xQdTlTOTc2YjJwWm1hcU5u?=
 =?utf-8?B?R05xd21wZXNpeDFPb015MnRQUmNVb1NoMDdpQXE2Y1NYaHloZzNyYUpscmx0?=
 =?utf-8?B?M055UERwOGFVVWNVS2dWb29WZ0JHSjJNdVQ5SkhWSVkzWEZ6aDNPTDRlSnhY?=
 =?utf-8?B?NUxuVUVtL01DVnBMWlhYNGdzTnhjN2tFVElWQzBzdys5Nnc4SXdrSXFLSTZ4?=
 =?utf-8?B?UlgzdGtMRFd2eVRzTisxSHZiUmRmZmFxODhCVmtLeTZKei9ISnh0SzQwTDRQ?=
 =?utf-8?B?MG00cW93MXJhSno4ZCs0SUhaTW1YaFliMmE3cFFlaFk5NkRlemlKN0JMenR4?=
 =?utf-8?B?ZWp6eUoxbEZ2eFVMZjBlZW5CNlQ3K290OGkvNW5lZGFieTVoZDREVHZ1b3Jq?=
 =?utf-8?B?NzhFbkpvSm1YOFRINllSYk1jTWVIWFJHbW5FY2RMeng4bzF3ZWJaV3RXcU1k?=
 =?utf-8?B?dWI5c01XR1pNS2VGRXpvWU1Semc0bDY1UzdMVVRWaDBzRHNDbUR6RzlUSVB0?=
 =?utf-8?B?RkhpNVJld0JNbjZ6WXpFU1l3dHJzYXowMEpKM2cvVUx1NEFNcjQ2S2pWK2M2?=
 =?utf-8?B?TEJ2RUtFOTdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K09EbzdDd1FJVURoUkhGenVNcHRZNm5ITWZLMEh0TVBLbkwzSU5lMFVkT3lP?=
 =?utf-8?B?Mzh1U3pVY1JRQWlwSVZSQm0vQkljVGZKTnc1U3BIZnJMWFNzbWhYanpoYzlo?=
 =?utf-8?B?MndzOGtINTZ1VkwxYlRHQ3NzTUFBYXZDOTBXWUpNZUxOVUZPQlh0L2lOclVz?=
 =?utf-8?B?MUVsZHZNemYwRVZIZ1NSZUlyWHNpL0dWVUkvdG5mVmZUUDlxU05wNU5lNml2?=
 =?utf-8?B?eHJjeFJYRnZLQVo1dURKb3JPbjhHeGhXY3duZ3MrSXk1OGJSYVZlMjNtRVI0?=
 =?utf-8?B?VEpqbnNTeFpxMURpVG55USt1TjZZN2hHRC9iNmRmZjRJdlN0aFVEcjhYM2Vo?=
 =?utf-8?B?OHJoS0sxS3ZaM1V3WHdqLzVWZ0JDUmc0OWlGWnZkdXZOY09WY1Zwc040d1Bm?=
 =?utf-8?B?clh1ZElEWnhYQm53UjhMSkZ0YkIvMDJXQXlWVnlkQ3c1ODlyY0ZLMFNGK0FE?=
 =?utf-8?B?aWF0cVV3bnBpd1NvYS94TFJ2R1hLeS9JUVoybDMyOEk3UnpmWVVXUWdpYzFs?=
 =?utf-8?B?K1NzUjAzOGl0dm95YTFEOWtHR3FaNTlYdW9qT0tuK2hzdFEyUDJsekQ4SVlT?=
 =?utf-8?B?KzN3Q3RLVlFFZXdwRElXaFZ5SEJtVlhtYTVLMEJ1R2FJZ3NSQXFWWHo3dUJv?=
 =?utf-8?B?clN6R0hUZjJWbUxsQ1BmaU4xYkI0c2JhaVNYNFd0NjFFRHBQcDBtcHhWZmZV?=
 =?utf-8?B?Y3FjUndPUmwzRUU2aml6WmcxalZDRnBjRnFqeUVaRFBjTFZFVExRc2NacU5M?=
 =?utf-8?B?dnlIdDN0dEg4Ym1JaGphdDAzY2QwSTJwbXoweXowQ2V3eW5xTE9IdVVzcUxP?=
 =?utf-8?B?dU9EK0k2ZFdjZCsyZEtoT004bXZPeThlNkZySjc3alQ1a01obWJTb29neEVC?=
 =?utf-8?B?WEdiREtxcSs2QjFId2JLOGxzWmpBK3R3ZDIrSFRxZjUvRDlVdmdXUUV2M2h1?=
 =?utf-8?B?R2hXcnMrN0gvWUdLUmpmbmNXemN0S0lDUkQvVXNhUHdlYlQ1cTczTTA4MnNO?=
 =?utf-8?B?d2RPT0dndDZ1OEhqdUhRRDl2ZWhZbGdFMUFvUWRCWTZUcFpLc1lYR2lZd09W?=
 =?utf-8?B?SnFxVWIvVEtDejNGRWs5c3hhVFV4NnR6Y0JQY215SXU2VCs1NkUyN0I5eVZq?=
 =?utf-8?B?cG9JQ1djWFpHdGw0YmZEMXJORXlGRktyRzlDbmJ3NXNKckhSSmhkY1dhODlE?=
 =?utf-8?B?Q1pRcUZCeTZqYTBiMkFIQk1zZEpmTTAvWHlrODhjZzJXQkZoQ2d3N0xzODJV?=
 =?utf-8?B?YUhnUUFYcEUwOHNWR24wYjJtM29vSzFjMWdiRE8zUnVYUE1scHdGc3ducDhF?=
 =?utf-8?B?REtLekFwbnRlOXBvWmNwUjJXTUxITE1HelpZS0JlQ1V0aEZ6RGltcHRxbVVn?=
 =?utf-8?B?emlSdVNGdnhQVkJlWlU3L0JZeGdLRVRabHcvSExxZUZuREJ0dENibTE0UG4x?=
 =?utf-8?B?SWROdzEwdmtWTVRqRjA5bzFVZHRJT2J6VEsyRThYKzgrN0xiUkovNCtKaGdR?=
 =?utf-8?B?aGJmckFwendIVkoxb0hVb1dJQlRVbDJqbWRLMklXSVR2MDRyUDRPWHBGYVR2?=
 =?utf-8?B?ZThQdmh2V1J0N0NHa1hJVUsxSlZrSHM1amtFM3A0OXVPbFd0SVN5Q2JuRWtt?=
 =?utf-8?B?a29HZ1dQZVlWazdNY2YzTlNPQnNrZ0ZvanJnMDlmQU1oT28vU2VDeEd0OHpz?=
 =?utf-8?B?MEY0TXBCKzhUQnJnc2tDVGtkNytKejZUYmhNTGtMeDlTd0VkQ3lxYTYrd2tV?=
 =?utf-8?B?KzVEelB4WjZBczhLYzVnYmUzMTZVaGJ5cGdMVStrNDV5UVBjVklrSS9HSW1k?=
 =?utf-8?B?b0kyd01Ta2p1WkNQVnhvTkVyRGl5OG9UWmc3akUrZC80c0NjbU5Ic0hrY09o?=
 =?utf-8?B?ajFpWk53YlJUU0d0YnFZdjIrTTNXQmlXbm9uelNFWisrbGgvV2pOTUhUSkM3?=
 =?utf-8?B?NEdJQ1JLMi8yUllnSmltNnNjYndwa3dmYVU0ekFGOFdENVBsdnEzcGFpVHV2?=
 =?utf-8?B?ZkxtWHZJaXlQNEkrbE9zcWoyblM5dWxMTVZ4TVJ6UTdQSXkxTlVjb1BGcUxS?=
 =?utf-8?B?MEdkOEpvWTRJMy9HaGFuRDJnRGVZWHZIbVBFYXBHbldOTC95Y0lYYmZHcjFW?=
 =?utf-8?Q?az9z1xgVClryR+YWNspc911rQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a013f53a-7796-4efa-ab04-08ddfe65d71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 08:05:51.0253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpxOoOh3oj+y6jsKkUonkxGcsc+JEPkMPnuD10o+XgcPDsuz/AfG7/5q0TR/DCo+9+ByIGYkryt1QlG6ndVEDbPy50oIN9SS/m4ucKjl9O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvOiBSZW1vdmUgd29y
a2Fyb3VuZCBmb3Iga2VybmVsIERNQSB1bm1hcA0KPm92ZXJmbG93IGJ1Zw0KPg0KPisgWmhlbnpo
b25nDQo+DQo+T24gOS8yNi8yNSAxMDo1NCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+PiBB
IGtlcm5lbCBidWcgd2FzIGludHJvZHVjZWQgaW4gTGludXggdjQuMTUgdmlhIGNvbW1pdCA3MWE3
ZDNkNzhlM2MNCj4+ICgidmZpby90eXBlMTogQ2hlY2sgZm9yIGFkZHJlc3Mgc3BhY2Ugd3JhcC1h
cm91bmQgb24gdW5tYXAiKSwgd2hpY2gNCj4+IGFkZGVkIGEgdGVzdCBmb3IgYWRkcmVzcyBzcGFj
ZSB3cmFwLWFyb3VuZCBpbiB0aGUgdmZpbyBETUEgdW5tYXAgcGF0aC4NCj4+IFVuZm9ydHVuYXRl
bHksIGR1ZSB0byBhbiBpbnRlZ2VyIG92ZXJmbG93LCB0aGUga2VybmVsIHdvdWxkDQo+PiBpbmNv
cnJlY3RseSBkZXRlY3QgYW4gdW5tYXAgb2YgdGhlIGxhc3QgcGFnZSBpbiB0aGUgNjQtYml0IGFk
ZHJlc3MNCj4+IHNwYWNlIGFzIGEgd3JhcC1hcm91bmQsIGNhdXNpbmcgdGhlIHVubWFwIHRvIGZh
aWwgd2l0aCAtRUlOVkFMLg0KPj4NCj4+IEEgUUVNVSB3b3JrYXJvdW5kIHdhcyBpbnRyb2R1Y2Vk
IGluIGNvbW1pdCA1NjdkN2QzZTZiZTUNCj4oInZmaW8vY29tbW9uOg0KPj4gV29yayBhcm91bmQg
a2VybmVsIG92ZXJmbG93IGJ1ZyBpbiBETUEgdW5tYXAiKSB0byByZXRyeSB0aGUgdW5tYXAsDQo+
PiBleGNsdWRpbmcgdGhlIGZpbmFsIHBhZ2Ugb2YgdGhlIHJhbmdlLg0KPj4NCj4+IFRoZSBrZXJu
ZWwgYnVnIHdhcyB0aGVuIGZpeGVkIGluIExpbnV4IHY1LjAgdmlhIGNvbW1pdCA1OGZlYzgzMGZj
MTkNCj4+ICgidmZpby90eXBlMTogRml4IGRtYV91bm1hcCB3cmFwLWFyb3VuZCBjaGVjayIpLiBT
aW5jZSB0aGUgb2xkZXN0DQo+PiBzdXBwb3J0ZWQgTFRTIGtlcm5lbCBpcyBub3cgdjUuNCwga2Vy
bmVscyBhZmZlY3RlZCBieSB0aGlzIGJ1ZyBhcmUNCj4+IGNvbnNpZGVyZWQgZGVwcmVjYXRlZCwg
YW5kIHRoZSB3b3JrYXJvdW5kIGlzIG5vIGxvbmdlciBuZWNlc3NhcnkuDQo+Pg0KPj4gVGhpcyBj
aGFuZ2UgcmV2ZXJ0cyA1NjdkN2QzZTZiZTUsIHJlbW92aW5nIHRoZSB3b3JrYXJvdW5kLg0KPj4N
Cj4+IExpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY2
MjI5MQ0KPj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29t
Pg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

