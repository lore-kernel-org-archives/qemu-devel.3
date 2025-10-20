Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88575CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp8z-0008A2-QP; Mon, 20 Oct 2025 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp8w-00089L-TS
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp8p-0000es-JI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963855; x=1792499855;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5M6ZTKgmCnzEUGLAzbttMt3/1iOoXSb6qVyXA0wtSFQ=;
 b=aVgTlxDjKX35OO29QWUH3nyT8e0XsJFc54GQtqortJ7EGUIjJd7w3lwu
 v/ulCi+obu8jythsv5RAimp87EDTo4ctqZE+wpc0fl7ENRsP2Y0NVSoE3
 SDFwOL1qUBwUjTCFNRU5gastDsATZs80yzfaQHof/mi0d/1jADKC2JxmE
 /RVbEk8+OWRcLZu/06v62FxObf/IrChxIF1xvUwEeXOmw03RSRG9ksjLF
 wtkCe+TvKdMmJJ8IDygFaEMJIO0E5ajVxMh2IdpAxLY8LPmCDrt2uILU5
 2eZ1X6bA5vJvf+NsKHtTATzBV73ldWEu5aVTwqCbxZr8sUFBzMTr8F9lw Q==;
X-CSE-ConnectionGUID: kjWgrqWjS8+8VpDYjeZyQQ==
X-CSE-MsgGUID: Cfrs1GK4Q9WOwC4f3vXP7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74421184"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="74421184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:31 -0700
X-CSE-ConnectionGUID: Z6H42z/DSjCbVTIYTaeRSA==
X-CSE-MsgGUID: JRXHLTUGTbWpTbGkqC9ATw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183264962"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:37:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyEqgEiOicjhxzmZ+MOdeZv1fhsITqhijNVya7Tx0/m862zidIs36rC4XtkzKJZQh2T0z0whdnvGNT02F6Gjau3Li0/VN4mzFW2JbUSg/TYAJCW0qDRIp+sWHCGhHE+dAX7L/wkuCzFPAkLyM4Q51aAbTjS2TqaXhsKYRjFthL5fMTIcdTYiQ86amK79T2BRXHZ9y7E3iqVdBNyBbRgkUduk7DDilC/f88nTf2TOeJGMYfLt63vtkUZGXbupmTt5z1HqMLKo3/IiSwTMz/dQ0/Ztl+v1nSpk2Da5buZRCEhHl8+7aPO9Z1ZSCAX626VPXv5SLbvVQrFOm06yvSDMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyuGuvRchuinUNrzQkg8wqkRmr5oUHCKWcatO5H8Eds=;
 b=qqJADIJkH6T52smblgZa2wZjTNvVGLcGiT9MTSC6YCE7k1Q9oyzVgo85LFiMWX5hCPBDz1QaDLqbMPgdFMDZ9WOUrw8WWN0pSbcPh1tWjLiC2siZujErrJ+ivs+Pp/gIJzHCP9M0ZUu4npAyRrYpCKLrHG5ERC6mgmH01DxIAqNxP8KWLPEDGBNRl3T1/5baSdo/KWS0I2owX04dJ70nPGNFa8yBSCYKlEjM2f+mAfLnbHxOoOexON/EmdVq/dncw7PMLzqNv+qWfudZRKQRmpblmBkpGxSvq2eZB2ixjtPye1wKo8IHxajQGYHkti7KBwit6fOFtrqgvPBSTf3RGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:37:27 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:37:27 +0000
Message-ID: <e624b75b-df65-4232-a3b9-00f6347c064c@intel.com>
Date: Mon, 20 Oct 2025 20:44:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cd2b94-c1fe-47e6-ba3f-08de0fd56d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlkzMThHNVBhSTF6WXRHdWJXNHdWV3E2a0gvSmpiNCtlUjNxZ0xsdDQ4VzVr?=
 =?utf-8?B?bjRQdHoreFNHd01RRG5lYkx2WHZXazkyN1dETEtZdWozbVBtOHcvYnM0WUE1?=
 =?utf-8?B?QURVZUR5c1NneXdLRUh1YTU3a0dMVlJqTndod2hpbC9IOUU0UXJaMDFUc1pM?=
 =?utf-8?B?ZUY1czNtSVBWOVhaNWIwOXU2T0VZakJaQWtzS1ZNSVhIMlBjTE1id3VUYkk3?=
 =?utf-8?B?MjZoekVlNnpKellwQ0c3YlFSN05BVnl6ZGJYWUJmMDBiWGR4YmNIUzhXYWdi?=
 =?utf-8?B?SzRmTVBYUHExQXB5KzZlSFFHZE5pL3I1d0hMTkk3NE1KYWhzL1JoaUNNb0dv?=
 =?utf-8?B?M2tnc2loWXh6VWFSalpZYXMvakdySmRac3lZVkZjVUNnZjcrLy9mcjJVRjQ2?=
 =?utf-8?B?cG5NYk5aMXh4MGwvVjNoV2FJcExyeE5NbTJlRnVIcklVMCt2ODlINi95Yk1U?=
 =?utf-8?B?Sk9OTENCeC9mOTVsYUpPZit5cEF6cGJQdHFUc0tHNW5rWWVFcHJzSlRJZ1di?=
 =?utf-8?B?dFpMaVRjWjNYalBKNkN1aGYrSzFLTHF2UWlhNVByMTNDVVViaFl3ekVrK3J3?=
 =?utf-8?B?RS9yZHdVUk4yYnFJeEJVd1V5Z21vWHFUSm1GWWJpc1lXbU4wdno0T2xmNVVW?=
 =?utf-8?B?eUJNWGFXZ2pWcVJuOFUwNGxuWE5uL1FTQWRoOWxNcmxMK3lzL3YwbVNQZmxm?=
 =?utf-8?B?M3dKUzdRN2NkbDZCUmdrZ2wwb2tYWmVWQ3dwOGJUZHY2T1l4dHNOSXQwWW9Y?=
 =?utf-8?B?SDZDOWduSFVlL3MvR1ZsTTMxckZJdUVVb09JenFBZHorc0h1T1d5SWxtY1NS?=
 =?utf-8?B?d1hTSUp6bWtHMEMwN3VsTERwQ0k0L3FLMzJDQ29nUThhTlNWMUJSdTBDNVVj?=
 =?utf-8?B?OXFpZnl5TjVTTVE0djdpWHNlWmZBUGZMdEQ3d2F6N05PWExMd05YcU9yeG91?=
 =?utf-8?B?aUIveStzRlRQL0loUld0QktRMktGUmUvMVVzUmN0V01iRng1aHNXVE1jVHh6?=
 =?utf-8?B?VHA5VnJXSWJxYytxbmdITGtVc292ZlNyb21GNzZvODJvZ0RUdjdJZnBIZ1Vy?=
 =?utf-8?B?Z25oZ1QvbnlvYnRlcWFRcndlb0pCSmtHWU15WW1UUkRZcjZTZ1RXd1BpdFAx?=
 =?utf-8?B?U0w4OUgxZU12eEZncVIxODZXaURQSG9mbGJ4MXdQcnprTWFzQ1kzTWp0M0xC?=
 =?utf-8?B?ZEdjNHp0M3MwMmhKZ2RTVWVJTWczN2dCblM0OGZEODFweWllMUYwcDBKQ2xQ?=
 =?utf-8?B?MzB4OTU0eHl5cTd3eDlFMlMwQWRtTG5oTjNqejNmM3A4TUFkMjE5Zk5tZnFN?=
 =?utf-8?B?c3hzZVRWUjZWN2tnQzVXM1F0ZTFTY2g4Uy9xUHFWeXFBNWZPRUpubnk0akZ2?=
 =?utf-8?B?QTh4ZTg4bTRpeDVSVnBUOFBFMjNPL0ZoRUxtaGhOYSs3L05LR1BjdytwMk1t?=
 =?utf-8?B?bm0zWUVwbVpVQnJJZDVnVjlaMDF3cGh6TExpS0FnamVVbEFvZnA0bzQ0YzQ0?=
 =?utf-8?B?dnhxU3U2bjJiZE9pajUvelVrVjJocmtWT1dzem1VcUJKUDJtenh6cDdKTDgr?=
 =?utf-8?B?UlJSQ0FnZ1k1Yno0VGdqMDF5cE1ubU9ZQ0RHY2t2M0ExYkdodm9zT2pTZHhX?=
 =?utf-8?B?YmdQNE9XTHFjUk80a04wVFA0dyt6NlFjQ2Rpa0M0NDdoQmh5NzB2Ymh1bjJq?=
 =?utf-8?B?VWVWc1c4cWN5Z2JaOHUwT0tjdS96ODNUbVREK1hmZ2l1cStxY29hWlNiSzZY?=
 =?utf-8?B?SjJUSzdITmJGOURnblZyYTA0U05SWDFOQzExMm1XOWZjR2JIR2RYYWMzU0JC?=
 =?utf-8?B?dzQ3ZnlPdnhQd0tVTk1MYi9nZU1tUy9YRGFmaUhLOGZyUGxRU21TazZrMS8z?=
 =?utf-8?B?NnM1RU9NMk9UZjZLUUVUaVZ4dzZRVTNuM1MwTkJjYVFidFBoOFNXS0dEZStw?=
 =?utf-8?Q?MpbzFyFPVuNeZL5noE+Xqff1OFfOoSk5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUVtbmdpUjZjNUhZNk5SQjJaU0JnVkpFK1Zjcnp3NWFzU0JiSG9sQTNGWjhS?=
 =?utf-8?B?ZVd3aXFxYVZBRkZXdG9reWh0Ti9wRWFFMThzQjFTdThIU1BCb25sRUtwY1JB?=
 =?utf-8?B?aCtNeFluWVZodVJLc1o0RnZBdkJTU0JlUXo3czNaR1lYU1FmSkNJRUVNNUdr?=
 =?utf-8?B?UmxVbUtmeGRadk5CRGhkVjVXUEoxcUpvc2oyOWtrMEU1NTdoVHNNdHpCU2Fm?=
 =?utf-8?B?Y1RnQmhxZVdqQWQ2YU9jeXZpemRXVjk0L0VXRHhrdXkwVjkwSnlaN1J1WGdU?=
 =?utf-8?B?M2YxZm1KNmI1cERiL2FjRUp2a0x6OEZ1UVB3K2Y0YVBMSlpaM041OHlmSlZv?=
 =?utf-8?B?VTU5QXVZZWNHVFJIdHJTNEU2c1I2RktyZGMyTHQ4TUcyUGtHSjBud3JjaUVy?=
 =?utf-8?B?Y25rVVdLaDgzMUZlNFlvQWNVanFEclZuam5PWm9TU0ROOHVNYkRYS1RPRXI3?=
 =?utf-8?B?TEhmVUtVbUdQSS82S2VkdGxId1ZLeEd5TGUvdTBONVh0STVZM0VVc0hUaFE3?=
 =?utf-8?B?dGxSK2FldGZGdlgwSUl3ZkxrbVN6WE9NbzAvS3V3dW91VlhkWXdFMTArUGRt?=
 =?utf-8?B?azljUk9ub1V0c2p2MjB0V29pR29KTUh2MUdPenBmeVhKSkM4RDNRbFBzWHZm?=
 =?utf-8?B?bS9tMmQzQlppVmh5RjFaUzVUaWlMQmJrUkNJdHpxWXhtalBGSXlTaXpLOWg3?=
 =?utf-8?B?OUhnZi9EWDFnNnVKODhaRHFEUnZvak9lTVpKcDc0NHo2SjZlb1BLOGZQVW9R?=
 =?utf-8?B?SHFsZ0FTTVhQelJMS3JkZ3N0U3VrbmhSd1lmMXRHNXJZcW10bXJTRWV2cXl2?=
 =?utf-8?B?YVJmS29RVHZPQUJLeDhmRG1uZ0QzQk5hU2Z1Uko0ZWJjMVpVRDM2blQzQUZ2?=
 =?utf-8?B?Z3dXSEs1aEJia2lVcUUwQ3g3dFhvZ2ZEQkM2Y2VFZGc3Z0xjMVZYUHZlN1di?=
 =?utf-8?B?aVNWWmhOSUtyMVpGUldlc0JqSmdmaEJaekgrRmU5ME40b0w2VVd3VGtzZHpO?=
 =?utf-8?B?dHVQRzBIN3RxL2NoQTlHc3NwaVZlcEtGZWpBd2t3dFpkcDNabFJIa1dwM0lR?=
 =?utf-8?B?RFd4UGk3QWNRYmdOcHgrY2JRN3gvVFNyelROVHY4ZTN6bkFVTll5aExweW1p?=
 =?utf-8?B?U3NnQjd1cnlHTGd1a1c5T3JDRmNwTVZ0enFYNzZGeWoyR3licnR6VnBsd2ZD?=
 =?utf-8?B?TFBRUXU2cmFablVNRlY0K1pjdmpXdEw1NGRsUWdhaUdOaXljWmNhQSszc3E3?=
 =?utf-8?B?c3JjNU1UL0xRdk5TU3J3Qmo4eFNMd292b3RGMzFLY2lWOGZMazdyRzVPc1Zr?=
 =?utf-8?B?YVd2b0hDMkhmWjY2K0ZHU1RkMjdWanp6TDBzbGdWVGc2VDdCd1JCbGhCSDNK?=
 =?utf-8?B?dGtrOW9kSFdzU2tDd21TYmZ1N2VURmhSam5IOFovRkEwU1dyaWhzUFNmRTgz?=
 =?utf-8?B?OTZMczFZMnplQ1czdVFPRW1tUFY5NkIvZk5CZ3JUVHI2ZnppVE5pZTFLSDRX?=
 =?utf-8?B?QXNIZEJUdGVpam5DcFd6U0tEQWtRS1BmRUJ4TmxTUndwTkxxSi8vMStnWWZT?=
 =?utf-8?B?TG5nMHZrUEFYd1BYdWU5a2RiVkRZUTMydy9ZaEtqOXBnSU52QnpFR2tkaVV0?=
 =?utf-8?B?UlhMbUg3M2dyWld3RVd3TTNIY2x4RkR2cllwdmtNZ01USmtFSmkxQW1Wc1U5?=
 =?utf-8?B?M29HV1lUUFBrQ3pkYTQzeFd0b1lyN0NLai9kR0EvS0pvQ3hvYy9UbS9xTUhr?=
 =?utf-8?B?bUlWaXN2VHJIU3JleWphVTRNZ0dQMUlWMGxCblJkVjdRNDVLTG1wVjVyWGJp?=
 =?utf-8?B?eWRraHpBYjhJVEV5MHRpMktKS1ZJVUVYMzJHWlB4ZUx0RFhNYitsMWhRNENK?=
 =?utf-8?B?VmloTjFJQzJKT3YxUWlsVDRlb0FjY2ZGblg3aWJIREZ2bnY1cm5JQWxYMEJH?=
 =?utf-8?B?QzZwQXgvN3NrTUNkS2hCRWRNSEFoaWN0aG1Nd2tnQmQ2cHpVRnVHNkdMTEor?=
 =?utf-8?B?QjVYOFBKTUdvNElWZ3NMTzA0eGJMbC9waU05SzBQbGhyWG4weElnMU5VVUhk?=
 =?utf-8?B?OUFKdU91UkhiVkEvb2IyeVVHd3ZuT3d4VkJpZ01vYmxuZzJGbFZSTWFKZUV6?=
 =?utf-8?Q?4SFYgJ3m/AsNKCnGcnT0kuHA+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd2b94-c1fe-47e6-ba3f-08de0fd56d2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:37:27.1377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y480DiWOkrDkbjk4PjAgJmlIl0Cv0H0Oq9FVpPWqY01vYeVmkXuvjxQJtlVm7U20nH2sgnYi+ywiC21os64jmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> When a existing mapping is unmapped, there could already be dirty bits
> which need to be recorded before unmap.

s/a/an/

> If query dirty bitmap fails, we still need to do unmapping or else there
> is stale mapping and it's risky to guest.
> 
> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/iommufd.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 976c0a8814..404e6249ca 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            /* TODO: query dirty bitmap before DMA unmap */
> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                    iotlb->translated_addr,
> +                                                    &local_err);
> +            if (ret) {
> +                error_report_err(local_err);
> +            }
> +            /* Unmap stale mapping even if query dirty bitmap fails */
>               return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
>           }
>   

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

