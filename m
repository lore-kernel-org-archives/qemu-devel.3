Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B58C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDUO-0000vy-Q2; Tue, 07 Jul 2026 17:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.winiarski@intel.com>)
 id 1whCzI-0000Kt-MC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:05:55 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michal.winiarski@intel.com>)
 id 1whCzF-0007Pq-N7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783458350; x=1814994350;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=u5cbyKgPHlNyxZxiXwnD/3Cq7y89pcrMab00OYvZa3U=;
 b=Kaqo0pRtSnz9p2KWOX+PHM0G46mCkQNmzz43qsRUBldd7yF0iesIB4u1
 T3bxtU1NlJRsNh5ZL+NTF7ZbxiKLv5JKCwk+Ia9FRRdda7osWD22sK0x6
 GQ6OHZPqwuoTq3rX1PI4As5lPruk/HXkHyIf23dIiGVw9ARslrIpHOQv2
 6JFFkVN5N8oy23VeD/2O4VJGsk9pW7bVnjyv83C0StjesVGg5sMvCemng
 uxmu37JwLO+HvDJcUhdfIyR2feJ32a4ngn5vhPldpVO0VjwZKqGfS+gja
 8vltsAAvqs5cBjF3FIqUg1zXZqYNJDZxL5vA/ra9rs4UF7J7fxxBG5mo0 A==;
X-CSE-ConnectionGUID: sqsuE/zWRQq6zJL0v6Dhow==
X-CSE-MsgGUID: j0Ukk6FBTr2wH7lKlQ0F/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94470448"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="94470448"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 14:05:45 -0700
X-CSE-ConnectionGUID: nbf4yTl9TJ6NGbfRc2vWQg==
X-CSE-MsgGUID: 47gzJbS6QFCyxQrGZ0Zl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251436511"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 14:05:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 14:05:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 14:05:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 14:05:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0ed6o5q03SCcLVeZzrA9gOtMOWBsoUD5lgl1OLMFYNGyt23QF4iTYAbDupXEGDJPL6Sx1aW8VoCHtAfkNk4M6qC0KbnzqO0ZicCPDhm0/qOBXuUbSh1/wqa8pPoQpenM9UMvv7sv1+FLkdNYfsT/qqTSR/9BAXwNor8DysUOQPv1WUyUXdIanu3B3YB6xDAWOUa+pYe7Z6rqbE3qAqOxXHcqBKMPTZA3kFGOC2Ldfm5alo55WVTsZkUFaRsDM4jcveWIvBRjvdjL7biH6IlXLfa4NvI8yOrxf6dYV2jM+bJXWm5O8KFJAS6DcRv+0xFgHUQx5pjtdk8Qqqi7FWtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3x6RrDPcRPS9Xk3TCdrIgJz8DdFpFptTuc9RndYIz4=;
 b=x+fq6dbgAlUiTpOrj6B37mXJEmAULwqXPS9PyBgkKUh5sv0xgzfKkZasmKdWvNXihtSWpi5hB8LmsyxW6Zot1vPUv/5IAWssKnBxRJITjDPNY4Psqn7LS7lamZ9hVg6rHVpH8j6l40gTFHXRbq9n9ZpCGP6/OAhoTf3GYS/yU9lyGqE+TzAqW+vsPNJmYIlvm/h2dou2HyYuyW+lDiYsHsV0uD9gL0M5JddztcTvERe9AIYib0z2Zc/4hkr8M4UVsyVjBmhuyDaWP81FL0UbH73qL0yl6Y2sUllcQ0Kp6pcs8WUTkE8+PqMhDiXEXCyjU8BzwO5RPJyLgwOVnAO6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 21:05:36 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.21.0181.010; Tue, 7 Jul 2026
 21:05:36 +0000
Date: Tue, 7 Jul 2026 23:05:33 +0200
From: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>
CC: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <qemu-devel@nongnu.org>, Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [RFC 0/1] Forward AER errors to guest
Message-ID: <ak1oWDUvX49OfFmB@nostramo>
References: <20260703111357.3206071-3-satyanarayana.k.v.p@intel.com>
 <3500e357-1a3e-4325-9259-28c2023860a1@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3500e357-1a3e-4325-9259-28c2023860a1@app.fastmail.com>
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: f0abd2f3-8c7d-4a40-47d7-08dedc6b7dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: EAcNNGcJi8PSFmLElYCvocm2RSTHNw71AGXOe5XTV9VPwsgXzrW7yUxDt4mhwm7k8uf1fOqStlk7AeiLS837ZNtfiR/loZDkHbDMgKehhuQRO30D3H2pwajZ7J5XU6vhSx1lEQeVpUcqno32ka5OkpzKjtAG/zeQnqA6W17lw7BHxMwQa6T2RtWCVhnux3BMRodod678dbWOBHWZrrfPnfr9gNGlsnPX+p3Jc2QgvTugOa3m9z2GNVzSwAsNWxOE02psUeatq+HsiTUzlR/nhStCX1WdFjX3VY+OqJf3I3uMr/AwdDHFzC0DilUCZai6CM+k09JTrgVBDETboknEcqQGhP6c5Z0gqWDAYtV0P1pLrBYrcVRDDHZm2DjPKkSIXWLs9HqEr/mLu+Q7HH/g0dyMiCLtwdfzD6uz34XUu5EynWxSLbHFVjmgdp5TZLZpTx5K5GWBGVsgeM/51D8XV+NHHpblwPFdbsYIjTc8Lu5lJGZWHwpQr5q8B0+ZbPySIfGgjgUkjoVlxHrNE7xl2c6+kDrPV23FEzrS84H9mcsZ+1jG5xN1H7WR75oy8hPgSUcPte6rbgXdho1XqiPuWjOe80y5DwnOaqK8vInVJqoaHpoRtppw3SUNn4+nxZIf37+A39/FpI1d3dGALeepX3zdVoKcgTF5PxrCPB1urxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB8132.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNZNWtENkNSSEwvRitRNkNjMlYwb1Zoa3ZicGdFd2hEYjVvdGdmQkVweE5K?=
 =?utf-8?B?dFBGbGxaelZLVXpYQkNEZUtOK0lhQlVjOURxOG9EdnZXOEZRd3pORUljNkF2?=
 =?utf-8?B?ZG5ib0hZblA5Ynhnd1cwZlZDV1hMYll6TENEdktBSmZtZXVKWUIwM3VPcUNy?=
 =?utf-8?B?ZU1Tcm9sc3RqNGc2TE1ncHloUzVxM01Wa1hlV2dZK1psOHZML1pJNFVIKzNF?=
 =?utf-8?B?RVZXQkxxWWVKK1crdHcyRzVQaTV5amtHRmlQcDM3dFhiS0lqZnY1cDhvVG04?=
 =?utf-8?B?K2pWQzlvOHVPQ04zNEJYRnRIU2pZQzczWG9nUFlBRUF2eGxmVnVYNS9hSGdw?=
 =?utf-8?B?WGpyekh2SmI5T09jQk9JUkpXcU9KN0hJTGloNDBMWVV4OG9WZ0FxLzFkZjJO?=
 =?utf-8?B?alZZVUtNL1p5RGpTcmI3YU1VSVF2cDZBc2dBYUlFNTF0YlhpR2VXdFJnbFda?=
 =?utf-8?B?czF3ZjhXN29LTHhXdmNRSUZOK3d5Ny9PZlZlRG9YWWpFLzRWTG5NWjBlTGpP?=
 =?utf-8?B?Q2NDRldVM0dadytLeFJlbGdpZVNMRFIvRUhBUnBCa0RpMk9tN1lPYzBZS0h4?=
 =?utf-8?B?UUtScE5aanZZWXVTQjRDYVF2NWMvaUI3bml3dGRXZTdHcks0QXA5djI5SXZy?=
 =?utf-8?B?OXpsaEw5eFFKNTVGdS9BeVNOTVphcXUvNmNzQk9ETkhoRjVQbk9icm01YXJY?=
 =?utf-8?B?NjdmUFUwaTJWbWFFVHZvV0FwT2lEZTQrUGQyNDhvS3NDQkFVNUlJcktLSGJm?=
 =?utf-8?B?MVZxakhHWkc4LytLUUFUUCtjWnh6Z3RUdWdtSVBlQmNVc3lOWnM0Z3BBTVBi?=
 =?utf-8?B?dW9DRFVzd0swUWVFZEJ6MXJrUFVXRmNRT0w1Q3o5a2lBYkZ1L3NXcVhLN0lz?=
 =?utf-8?B?MU00QU1wTGFKV0FZN1poQXV3TW1SUy85SUYvaUNuOFp3NVArNlhBTlQ5THVV?=
 =?utf-8?B?MU83TDVzWk9WTmZpcVNWVU5nRnBvWXVJalVDTVNqMi9QQW8wNG00aGxqVUlT?=
 =?utf-8?B?OERJVFZjMkFPZmRDWTExYzZmUzh6VTR0WmJwa1Zpa2piZHg5VzlWZm5FbklX?=
 =?utf-8?B?VnlQTkJadjlFM3dFNGU2L01zTzAyZE1zN3NCRWpobzNUZFBsVERpZ3l5V3JF?=
 =?utf-8?B?c2ZRR2pTLzhjVkxndVVUdkZvMFlUYnREeW8vOUdmc2FmRGxady94ejNFWUQ4?=
 =?utf-8?B?L0dob05XVE1kdGZiVTM0ci9mZlpFL0NsWThycnBqZXo2c3VScnBWam8yZnky?=
 =?utf-8?B?bU95REl2anlZSFRIMXdVbXdjV2NENXd0dW9VeU1pQmV5aEhsNDZ4UG4vbWxR?=
 =?utf-8?B?SzhGMHNCL2tFT2RUaW1EeEV4dHhmenZpS1BBeUtnMmc1Rm13MXFzTVRmZHgz?=
 =?utf-8?B?azdCaWJmSEhON3dPTm5UajlGdjN3WWVrNThnVjdKSG1xdlhEdlF1eEh3ME00?=
 =?utf-8?B?MlN1N2RmRkRnVloyUHZhR2xabk82UUlxTlE2S004WjlQR3FkOFdpRzRHZnIw?=
 =?utf-8?B?UDF4YkxDbjkxdFBNWXZPUUdyVEFpWGliMXoxV3pxejZOTlJBUFlzV2JYVDFm?=
 =?utf-8?B?bFRuZlMrNkVpc0d4TVBCc2N5bmtoemVGRGtHNjUzV0hFS2JlaXZiSlFFbFVx?=
 =?utf-8?B?UDJUTkYzckdVT0lJRjBiSDNhdlA5cEcrMk5RVTgwVFJldE16VG9aMjRTNHBP?=
 =?utf-8?B?WmUzWTJDcDBHb1IvUmRhWG1NN0dQcGdKSlM0ZkU4bGZUN2lKemhKSGlnMHB1?=
 =?utf-8?B?UHYrMzIxbUQ4T0NTSS9CRjFVVDFobGw0NGNGM0xMaFhvTThJRjFEdUJJTnMw?=
 =?utf-8?B?T1Ivb0xGREFPUE5za1NLQU5uR3VPOE1MOE10RkRUeUFQZ01HUDJpb0M2b3VC?=
 =?utf-8?B?Q3ZSc3dGRWhtSWIxam9nWFIzYk8xcjZibW1wMUFKN2hPcm16OWcxZ296L1A3?=
 =?utf-8?B?LzN2Zy9NUHV6N2d0eVlvaGVKbGZCNkF2M0cwUVZDR1FKWFpidHppZGRHRVho?=
 =?utf-8?B?S2dKWUtPT1V3R3JJemxYN09JQ1dtTnhDRDlPVmdxQTNCQkxiNm1EaHcxWi8y?=
 =?utf-8?B?dFErOFRHWUsxbUhKTlcyNW1MeFBDUHhhUzNxcjgwSVZJM0V0eHpiZTRvM1Qy?=
 =?utf-8?B?L1VGenRDcHFMRk5tbU1VdXkwdzhESVdBOFVReFpVQjVsWUZ3Q0NQZWY3a1l5?=
 =?utf-8?B?RjBHN3JMUjJvMDJqb1BLOTVlNHJKeFFkdTdCZDdNcjdpbEd5WEppR2VFa0tx?=
 =?utf-8?B?VGhHeXNIT0JibEQxbkVIVm9MRnhBNXg0amFqVlU4YngzSHN6TUpDQUJKNmpm?=
 =?utf-8?B?UWVJalpMM0xFVklBZUhrVlRINXBXSmtYcVNpRm9QVERVK3pSQklpMGQ4QjAr?=
 =?utf-8?Q?/E1tvMRkBjN6gS04=3D?=
X-Exchange-RoutingPolicyChecked: lzcaqcaRREr+lnXqino+YA47CyuoeMn1JE+mlRHKxbmb6NqF4QfXPG5ILcJ8gJagFwxi2BwKTbNGr1mgJjNEOroTNTdm7uyZgIRWQH4B3/9/32n+mpvs0Ntpk/+GEVG8WNvhypiLKPla0zwD3fPefLo15UfrR59SJnAZu5NFgomIoX/xZMh624XOy33jzL5uR0aYx6r6orZ2TJfisue3px/X4igRu/SSRR7jlRU3BL/Mq1LUAD7o/t//2VbwNSLX3a0UP6MmGs5GraaTvq0h/HwHyYJH7qB83WCkJL5ns8+sumglnY58bOvNkfM3dulQDTykRmbDsTn8VIzOkjLzVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0abd2f3-8c7d-4a40-47d7-08dedc6b7dc6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 21:05:36.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kom+em2ve743p9jkMn5tVnOGOMviv1aldmvI6JhpGAgxkNvLUMWITLsT/w3XYbhcJA7SHo7U8y+RT8HKk6GSxLWhKIGYuHprUkzP3kwg1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=michal.winiarski@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jul 2026 17:37:59 -0400
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

On Fri, Jul 03, 2026 at 07:59:46AM -0600, Alex Williamson wrote:
> 
> 
> On Fri, Jul 3, 2026, at 5:13 AM, Satyanarayana K V P wrote:
> > Today, vfio-pci unconditionally stops the VM when any error event is
> > reported by device. This prevents guest-driven error handling and recovery
> > for platforms that support PCIe AER.
> >
> > This series adds an optional vfio-pci extension parameter,
> > "x-forward-aer=on", to forward AER errors to the guest instead of
> > forcing an immediate VM stop. If the endpoint supports AER, the error is
> > forwarded directly; otherwise, checks the upstream PCIe bridge and
> > forwards the error there when supported.If neither device nor PCIe bridge
> > supports AER, the VM is immediately stopped when the error is reported.
> 
> The error eventfd is signaled for err_detected in the host, this is the beginning of the host error handling and the point at which drivers should stop accessing the device until the resume callback.  Letting the VMM continue at this point does the opposite of that.  Thanks,
> 
> Alex

Hi,

Today - the default error handler used by VFIO is not implementing the
.resume() callback and just signals err_trigger and returns
PCI_ERS_RESULT_CAN_RECOVER as part of .error_detected().
Qemu registers a callback to be called upon err_trigger signal (using
one of the poll/select syscall variants), the callback calls
vm_stop(RUN_STATE_INTERNAL_ERROR) - this is a runstate that can't
continue, the VM is effectively killed (qemu needs to trigger VM reset
to recover).

The AER forward was proposed as a relatively simple opt-in mechanism to
avoid hitting RUN_STATE_INTERNAL_ERROR and be able to handle errors for
SR-IOV VFs using VFIO. For uncorrectable errors with SR-IOV, PF driver
can be the entity that handles the device recovery. The VF driver needs
to stop using the device until it is recovered by PF, and reinitialize
any state that was lost as part of the recovery action.
Forwarding AER would allow the VM to move forward without introducing
any new uAPI.

If we would want to build a generic error recovery mechanism, we would
need to duplicate more of the err_handler_t callbacks as VFIO uAPI.

If the recovery is handled by other entity running on the host (VFIO
variant? Or for SR-IOV, the PF driver), we could also go into a
different runstate (RUN_STATE_PAUSED? something that doesn't require
full VM reset) and add a VFIO uAPI that can propagate the .resume() into
userspace.

If we would want the SW running inside the VM to handle the recovery...
it becomes more involved, and it requires a more substantial solution
that wasn't meant to be addressed here.

So - we're letting the VMM continue but we're also informing it that
something went wrong with the device, so that the SW running inside the
VM can do its own action.
If it's a virtual function, the driver can potentially fully recover
after the host does its thing.
If it's a regular native function, it will probably need to go into
PCI_ERS_RESULT_DISCONNECT, which, for most usecases is still a better
scenario then having to reset the entire VM.

If we would want to absolutely make sure that the users are not able to
issue any IO across error recovery, we can probably unmap (or zero-map)
the BARs at VFIO driver level, similar to what's done during reset.

Thanks,
-Michał

