Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC47C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 03:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj8YH-0004h3-Dn; Mon, 04 Aug 2025 23:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uj8YB-0004e2-SO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 23:41:20 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uj8Y8-0001K0-KA
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 23:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754365277; x=1785901277;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Y4eHPT9XUwdRg8a0kS9L9IuFMLaSo3kuhOb3qa6pWiQ=;
 b=b9PmrdrJgf0nfXVBwEl7ZGJZw7jMdBz+h8mb/R8cjaTH0GBjTs8tLe17
 ItXP/ZLUu4lbyWviN+XgzglM7TlqpV8cBZGDB2TJK/vaBGBmenZe25LHl
 GTzavERnwlb21xtE284V4PofOV+jlGFADEjdjm2F3phD25WD5T+tZ8+F4
 SVuXMXCcEhhG6rFeE/GbK0PqL7LA6YOm19ZOINihLq99p+0057xssMH+J
 mMbHc60oXkPjn+F59kikivr8UTZ4JFh68WMjrGKou4EJeM7PLXCiFwqlR
 3ejjn92ve3A1wY7dDormvulr6KtfSO/RpyBPOeXAETWhkeCAtw6ZQVV4I g==;
X-CSE-ConnectionGUID: UlSgYMbzRoizWpJdfd+mBw==
X-CSE-MsgGUID: JWZCgfTBRBu939d7cGGJsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="79198145"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="79198145"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2025 20:41:12 -0700
X-CSE-ConnectionGUID: emj0mNCnSTipodJMcX/bgw==
X-CSE-MsgGUID: XSTXDy9uSoyOzBOB9czgng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; d="scan'208";a="164255456"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2025 20:41:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 20:41:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 20:41:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.51)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 Aug 2025 20:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAPviaoFszSVvyHS8QWdkm7UZYDskjmLH6fpDRUawDxpYdiTWmh43mFH8Qff+SeIkMUDfVMyOe147xXHzQIdsN6G9X54beqk6G4m05F4HHoL/WnYr6kkXeqjgn0G0b+lq2vuufMERQlUaJwKDDRSjEcPygwbx/0iPUmwVuVD+UE0/1ALSfCTOIVeXdSal2rdLAmomHBgkRp1I4cqOhV7FJZmzcnPfzBGET47oQiCXIt1vWQM/LmULL42AKFhp2Z9iurX3vPhPsx7miKlWCbjVfRONOlbQTkFfo9jbq+osaYRU+lv2PzVSckTX3f7NtHCVuwQbnkf25JmAooXoABevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4eHPT9XUwdRg8a0kS9L9IuFMLaSo3kuhOb3qa6pWiQ=;
 b=nMf8m0UN5HPZu40vb7DBVBfxaQc+zSZCo7Gq8REh8K2mZODQR99z5FBb+5wa5HVLyrw0G/luCRm5l0akRo7ulwSUyLKPbNmcviH/uIp8Yb1+wAVIX6Q1V/USIZFV5ZGIQVxx18CvP4g8GAPIFEWpOso4MJoxmGNUhMosQ7HvtVh8eXZFpXN0U3Pzh1MzX8Pl8+llhmv3xm0TRf0sNQf9dgT3RPvPijBJtyI4sbJpZ2+s5V+HuDpd5QgJLbxEC+1/CFo85nNzyiDLb9wLNa4kI1tOIIX77hKvlVe9M87Fg6fL7fZv78O3w+e+75BlPeRG6DdIR17F4ru8+iucHiSnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by CH3PR11MB7370.namprd11.prod.outlook.com
 (2603:10b6:610:14e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 03:41:08 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 03:41:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Cedric Le Goater <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Topic: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Index: AQHb9nxa2lXNdDeN/UCbI5NjRCQA1LQ1mmWwgAKOUACABEUyoIAWOISAgADhSbA=
Date: Tue, 5 Aug 2025 03:41:08 +0000
Message-ID: <DS4PPF93A1BBECD8850C07ED843524819959222A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
 <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e822b87b-d8cd-440d-b398-d20759f07f31@oracle.com>
In-Reply-To: <e822b87b-d8cd-440d-b398-d20759f07f31@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|CH3PR11MB7370:EE_
x-ms-office365-filtering-correlation-id: 3d31e71e-f984-46f4-be68-08ddd3d1e9e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmpWbGNjOHc0RjU5QnQxclF5STc3NmJVUmZWVHVtaXh6VzVmWXd3RFBWa3J1?=
 =?utf-8?B?SVU2UC84dEo0a0JJTFc4b0ZOckxVQ2pUV0lTU2U0UFJBbUwvTDh4QkRIajlq?=
 =?utf-8?B?eDFSTTA2RlhkSFI3dFB2czVvMFBwcGlHQmxQK2VqcnB3dXUrMVhBTXQ5K2Ex?=
 =?utf-8?B?N1JpMWtjRWhDUm5vR2QzV1VicGJ0UlFjV3krcnI3MWNLQ1gyQ1NrOUZEeDZv?=
 =?utf-8?B?SEkxS0h4S0lWd0MwVzZ4OEFDT0I5MUlPQlFmc2QrTWMxZEluL2ZFVkFsMm9V?=
 =?utf-8?B?eUFXTHo3SkIwU2tlOGJmQS81UXAxRlpieFJJNDRzdzV1SXMrOWNqdERtTkda?=
 =?utf-8?B?WnNmSVVDQzZiK0UzQzVoVVF5eDcrNFRXaDVZMS92V1VPRFJpYXhrMjVJd1dw?=
 =?utf-8?B?UEpyelI2STVXZEQ1MzFyRzdCSVRXWlVNUFZXem1GZjczeWUvOTZrTHJkZHd1?=
 =?utf-8?B?SHQvalpaNWEyTENrOEpUcG9aNXNhQ2IydmlXa2IvMXdQNXZvMHBqc21xK2tF?=
 =?utf-8?B?Ujg0TUJLS1dOK0V3cVN4VzY0YWU4M09nN1dQb3Q5UEZCM3dYYVNZbFB2VzRm?=
 =?utf-8?B?R1VmaFZUOU9lQjlwb0k3VlBoYStyNWxybHZFSytmNVY5alNEeU53eDZtTERt?=
 =?utf-8?B?eksyRnduSDJORjN6ZnE0eHV0YjVvb0ZGSzNScldxWDZTaUM2MFNieDM2QzJv?=
 =?utf-8?B?QjhOWE5XR3Fnb2x3ZE1jSlBHMVFQejdoZVpOcVR2ZklpVGhSUmlhbDVxbDVz?=
 =?utf-8?B?K291T1BJVE91RmIyaW16WkdhSUN4Z1BmNTkyc0t6WEl0VXVDTDQ2UTB3Tyto?=
 =?utf-8?B?OVVqcW5pR2g4aURPUnc0MlFHZmR5OFdLUVZJaElyeVUvRGxtUFBCc3FmOWN5?=
 =?utf-8?B?OUpNbDRod1J4eUpSU1hWdjg3MVBnb0FFTUNyQXo5L2h5MjBJVXpTc3lkZjN4?=
 =?utf-8?B?VVpkQS80YVE2UmpQNlUvVm1acW9GUDQzTVZYekpKd2lZWTBoTFpuZmk1bXQ1?=
 =?utf-8?B?WGp4dE54QzRzeUxseHJrcS9JMlhMS3JGd2ZsVGlwd3Q0cy9yOEJXNHhETlRi?=
 =?utf-8?B?QVRzSlZ6cHo0NTl5bTJ1aUJpSjRGaHdvS2FidE8vSkZaR2pLOG90d0JINjYx?=
 =?utf-8?B?aEdTQmVpdDFlSEFqbnc2VEVRRnhPREhuZ3NsMVpoNjI5NnFNSEhUMHczUE0z?=
 =?utf-8?B?VWhxRFo2SlV3ZnFHdHhSZXUvV3ZBUURDR3F5R25xL2ZsWHV1OVFiQnk5aXE4?=
 =?utf-8?B?MmUwV2x4Qm1WNjdKbXNIakpsU2RlNi9ua0JxU1lyWmtydzBvOFNCaGg3Zkpq?=
 =?utf-8?B?V1ROVTdrSFZEOExyNlNBaUZEK0J0RTZ5ZzczUWpzcVNXWG8yMnQrRVN5QjNX?=
 =?utf-8?B?RTA2NFBWeFd5ck8xUTgxZnZxSG5zeW9EVVBQYzR0bDhLcVdUZUlPMG4zUkVP?=
 =?utf-8?B?YWdoQUtPc05PSE55V0NHSVY1dkJ0UzhBVmkrcStVZ01Va0ZONE5GcEFkSHIy?=
 =?utf-8?B?c3FHS3JMYXRHV2gwMDVOeGZOV2pyUTJicG54NlRITG80d0ZwTitwRDMzc3pv?=
 =?utf-8?B?cUU0NlVIbDhkUWIva0xORFk4Z29WTCs0eGNneWlNTjgrTDRKRUhzWTZKQ01V?=
 =?utf-8?B?NDFEdGRBZFkvYTNIOEdNa1lpNEhOREUrMTd6TzcrT1lxMnQyVlgzY3FJWmp6?=
 =?utf-8?B?Qmg5U2RabEprZjgwSTVuQkMyemV5ZjhIWE54UlFPTXo2RzliMEY1UEhpcHN3?=
 =?utf-8?B?ak03bWRYajdLN0pCeTd6TzVISmdvTHE5Q1hrZkh2dUtPbkVKTTFwSFVRZE5v?=
 =?utf-8?B?Um1EZllteWVYcGtzdkJOeEx0aWdYbDlZVjVPcWZPQXQ4Z0dTdytNZW5BLzND?=
 =?utf-8?B?c3NHZFdyKy91aHFoVTB2SVJuckFGbUZvbUF4SVRubjQyNmViQUJnVE5PRTFF?=
 =?utf-8?B?M200VWFXNURyMXY4WGNvc2tMUVhoWGh3R1RWazRYbWwrWFJkaUJ0K2h3WVpa?=
 =?utf-8?Q?KozSxJ7U1gM+ykgWmwXTG5VGBbaZzA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q25DY09pWmFvaTY4WFI1R00rdTlRZGN3VksrK0VIT0hJOHc5RUx3aVNLb2Np?=
 =?utf-8?B?Ujl6b29PdGVNMVl1TXdnRmk5ekluNnI3aU4vQWNSLzcwV0VJcVlVblY4MnU0?=
 =?utf-8?B?bys3cWNTM2pVblRtNk5DNlF0RVhNTW4xd08zcXhKODUvNWVkQzFubm0zanlx?=
 =?utf-8?B?T2l5VFU1eFlrQXo1VlVGLzdtTXQvbkZneHV4MlRHamY3czFkYUpwNUx4VG9S?=
 =?utf-8?B?QWEvMDJFUWw1T29WU3ZQR2l1TFlaRFZUbW9LTGlJa05WRThEZ0JaRnAxQkYr?=
 =?utf-8?B?TllGNEljOEU0NGpzUTEyZlp0bE8vSXoydzVmNys1ZkI3azVXOEFGajloZGc0?=
 =?utf-8?B?NlF0WEhCWVRTWDJSSkxqeU5CeVpYN0hUL2xqK3dybERmbFFkUGUySTkxdHJw?=
 =?utf-8?B?cTl4UzF5blI2QzMzak4vbHNYVS9vVnBpZjFhODlNNk1OSHlVdVlhMEhROTVw?=
 =?utf-8?B?a1VvZklkbytjUkZ0NEhmMXYwYngvb1NFNmo1ejhUcWdIRDRHbGU4NG9na3lE?=
 =?utf-8?B?ZTl3UlFud2d6VkFYWDhRV1NNdTBQdTRZYnZ5dEZ1dnUwZVB0Y0tDTzdWMVZX?=
 =?utf-8?B?YmNUQURaMDZKWU5YMHd3R2pWR3ViV3U5eGZTRVRsTWxhUGI4OElBNXdqNDlw?=
 =?utf-8?B?aVJ2VnBncDY0cFVKcUhJcitlaTQ3RVU3Z1NsVEFoVXM2b0EvQWpUWTZkRkxu?=
 =?utf-8?B?dVBua2gzaGIrRGZFVzcyT2Nsd3FETXd3ZkU0d3liOENZWDhKaHVuUmt1VlJJ?=
 =?utf-8?B?T2s4NDZycmRRaTBFL3J4SXJOOGl4YnNiZmEyZkdBNTBmdDBDaVVYUEpwVGFP?=
 =?utf-8?B?RGVRaGltcEg4WVNLaG5UQ2RRUTYxSEEyRy9MSnhTTmNTOWQ1ZHJ3N3FaMGtH?=
 =?utf-8?B?dzVQY1plYVpQb2hER3B5WXdYK3JQb2UzdkJMK1lGUTVHVTdsaHdnblNISHBU?=
 =?utf-8?B?THJYZUhvSHVDMXB5a25TNytreElSRnkySVBGenZoSVRwMy9yYWp0UWk2Ym5I?=
 =?utf-8?B?eG92dGJGMkMwUGw3RE5LK3ZXZlZER25jaUFlUTlqL1hkeGI5SmoxZGJhMXI2?=
 =?utf-8?B?SFBSQWl1eDYwamZqMnFWVk9uTnRsWWVMR0J4Ykp0UmRPQUhPSkZnbmZvOHQ1?=
 =?utf-8?B?MGlRdTE0MDRreDJLTFNOVVIzTDdicHBCbWpwbkZMaFBVaGY2TldIUnIxUHk5?=
 =?utf-8?B?OGRUNXMrRmh2WUloZGJFL0dMYk9yTXhTV1B4REQyWE5lT090ZlB2eVBrTFJa?=
 =?utf-8?B?ckdEbThWalIrL2xsb3J4S1dmV3dpbkROS0dUdjJrY1AyWFlaa2dwUkw5MGU2?=
 =?utf-8?B?S3R2OERsWnVDNTkrVllIc09CN05JSkthLzlvUzE2VXIyNERueUliWDREWTlG?=
 =?utf-8?B?eXc4NTdmSWdjVktWM255L1BOaHhCQVNyQ1hBYzd0R252RnlHYXloenNSWTBk?=
 =?utf-8?B?WmF1dUtwZERBNGVkNk1vWnQ2d09mZkFyUUM0NHNTRzBiWitZM3VVMUx5OFhs?=
 =?utf-8?B?VXVRVFhRcFhCOVRCMmNsZ3p0ZFgyaUNQajNKYkR1eDhQbnkvMndEYVp4Ryt4?=
 =?utf-8?B?UEw1L0I3SzlVNUhKa0dOb3B2SElOR1RjRkY4NUhLR2Y5Z1c2Z3BjRTU3MzAy?=
 =?utf-8?B?RkdyZnlzUysrd2JMazgrZ3hXdDhROS93d3laWmU4MmVMZUZJMjc5V2I5SCta?=
 =?utf-8?B?N1hjRzBIcXlmM1liVlpaMEVXeEtlL3FqdEZnMXkvRDdkdlNibnJwVVZwczNW?=
 =?utf-8?B?c2dCanQzMHNSaGY5M3BhaWU0dW9pMllBU0RaWlFpMFlHNU5KRTFsY2lKRnp1?=
 =?utf-8?B?Y0w1ODlQc0ljYUJYVWY0aXBsakZVeklYcU94cjAyaHRtR2VmTGEyMTdMems5?=
 =?utf-8?B?Nm8wenRRTGVXaFovRDVOUlF4aWQ2cVhRczN3VkJvQVlHRTFXb1RaSzNGcEp5?=
 =?utf-8?B?VXFGbnFNbHpYNUZWQ1FrcjIvNFgwNDd0NDdiZGtCU1BWNzNkaDZ4bHJVb0V5?=
 =?utf-8?B?MDhSZUhTZytqR3ZSYjlmZUJ2ZU9VTytrc0hOYzZjVFMvcENZL0o0RjRLWU9X?=
 =?utf-8?B?NE9NVXhSdWcySGgwOHdPY2lXc3M0S2tBZ0RTV0QvN1J1ek93SE1aM0tWQmZW?=
 =?utf-8?Q?yqYLT7EJ4xKJX0CzwLu5JdX/Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d31e71e-f984-46f4-be68-08ddd3d1e9e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 03:41:08.1449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMiLKEByoLcgUHUYF6PgQiBiZx3/4AtjmxHUCpId2Zj6kMyHm5jZEs8bqXlS/WxoVGMGAH20+44zgIPy4x+gSSYGTHhcQ9Zal9Nh54joBII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSB2
ZmlvL3BjaTogcHJlc2VydmUgcGVuZGluZyBpbnRlcnJ1cHRzDQo+DQo+T24gNy8yMS8yMDI1IDc6
MTggQU0sIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29t
Pg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSB2ZmlvL3BjaTogcHJlc2VydmUgcGVu
ZGluZyBpbnRlcnJ1cHRzDQo+Pj4NCj4+PiBPbiA3LzE2LzIwMjUgMTA6NDMgUE0sIER1YW4sIFpo
ZW56aG9uZyB3cm90ZToNCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBG
cm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4gU3Vi
amVjdDogW1BBVENIIFYyIDIvMl0gdmZpby9wY2k6IHByZXNlcnZlIHBlbmRpbmcgaW50ZXJydXB0
cw0KPj4+Pj4NCj4+Pj4+IGNwci10cmFuc2ZlciBtYXkgbG9zZSBhIFZGSU8gaW50ZXJydXB0IGJl
Y2F1c2UgdGhlIEtWTSBpbnN0YW5jZSBpcw0KPj4+Pj4gZGVzdHJveWVkIGFuZCByZWNyZWF0ZWQu
ICBJZiBhbiBpbnRlcnJ1cHQgYXJyaXZlcyBpbiB0aGUgbWlkZGxlLCBpdCBpcw0KPj4+Pj4gZHJv
cHBlZC4gIFRvIGZpeCwgc3RvcCBwZW5kaW5nIG5ldyBpbnRlcnJ1cHRzIGR1cmluZyBjcHIgc2F2
ZSwgYW5kIHBpY2sNCj4+Pj4+IHVwIHRoZSBwaWVjZXMuICBJbiBtb3JlIGRldGFpbDoNCj4+Pj4+
DQo+Pj4+PiBTdG9wIHRoZSBWQ1BVcy4gQ2FsbCBrdm1faXJxY2hpcF9yZW1vdmVfaXJxZmRfbm90
aWZpZXJfZ3NpIC0tPg0KPj4+IEtWTV9JUlFGRA0KPj4+Pj4gdG8NCj4+Pj4+IGRlYXNzaWduIHRo
ZSBpcnFmZCBnc2kgdGhhdCByb3V0ZXMgaW50ZXJydXB0cyBkaXJlY3RseSB0byB0aGUgVkNQVSBh
bmQNCj5LVk0uDQo+Pj4+PiBBZnRlciB0aGlzIGNhbGwsIGludGVycnVwdHMgZmFsbCBiYWNrIHRv
IHRoZSBrZXJuZWwgdmZpb19tc2loYW5kbGVyLCB3aGljaA0KPj4+Pj4gd3JpdGVzIHRvIFFFTVUn
cyBrdm1faW50ZXJydXB0IGV2ZW50ZmQuICBDUFIgYWxyZWFkeSBwcmVzZXJ2ZXMgdGhhdA0KPj4+
Pj4gZXZlbnRmZC4gIFdoZW4gdGhlIHJvdXRlIGlzIHJlLWVzdGFibGlzaGVkIGluIG5ldyBRRU1V
LCB0aGUga2VybmVsDQo+dGVzdHMNCj4+Pj4+IHRoZSBldmVudGZkIGFuZCBpbmplY3RzIGFuIGlu
dGVycnVwdCB0byBLVk0gaWYgbmVjZXNzYXJ5Lg0KPj4+Pg0KPj4+PiBXaXRoIHRoaXMgcGF0Y2gs
IHByb2R1Y2VyIGlzIGRldGFjaGVkIGZyb20gdGhlIGt2bSBjb25zdW1lciwgZG8gd2Ugc3RpbGwN
Cj4+PiBuZWVkIHRvIGNsb3NlIGt2bSBmZCBvbiBzb3VyY2UgUUVNVT8NCj4+Pg0KPj4+IEdvb2Qg
b2JzZXJ2YXRpb24hICBJIHRlc3RlZCB3aXRoIHRoaXMgcGF0Y2gsIHdpdGhvdXQgdGhlIGt2bSBj
bG9zZSBwYXRjaCwNCj4+PiBhbmQgaW5kZWVkIGl0IHdvcmtzLg0KPj4NCj4+IFRoYW5rcyBmb3Ig
Y29uZmlybWluZy4NCj4+DQo+Pj4gSG93ZXZlciwgSSB3b3VsZCBsaWtlIHRvIGtlZXAgdGhlIGt2
bSBjbG9zZSBwYXRjaCwgYmVjYXVzZSBpdCBoYXMgYW5vdGhlcg0KPj4+IGJlbmVmaXQ6DQo+Pj4g
aXQgbWFrZXMgY3ByLWV4ZWMgbW9kZSBmYXN0ZXIuICBJbiB0aGF0IG1vZGUsIG9sZCBRRU1VIGRp
cmVjdGx5IGV4ZWMncw0KPm5ldw0KPj4+IFFFTVUsDQo+Pj4gYW5kIGl0IGlzIGZhc3RlciBiZWNh
dXNlIHRoZSBrZXJuZWwgZXhlYyBjb2RlIGRvZXMgbm90IGhhdmUgdG8gdHJhdmVyc2UgYW5kDQo+
Pj4gZXhhbWluZQ0KPj4+IGt2bSBwYWdlIG1hcHBpbmdzLiAgVGhhdCBjb3N0IGlzIGxpbmVhciB3
aXRoIGFkZHJlc3Mgc3BhY2Ugc2l6ZS4gIEkgdXNlDQo+Pj4gY3ByLWV4ZWMNCj4+PiBtb2RlIGF0
IE9yYWNsZSwgYW5kIEkgcGxhbiB0byBzdWJtaXQgaXQgZm9yIGNvbnNpZGVyYXRpb24gaW4gUUVN
VSAxMC4yLg0KPj4NCj4+IFN1cmUsIGJ1dCBJJ2QgbGlrZSB0byBnZXQgY2xlYXIgb24gdGhlIHJl
YXNvbi4NCj4+IFdoYXQga3ZtIHBhZ2UgZG8geW91IG1lYW4sIGd1ZXN0IG1lbW9yeSBwYWdlcz8N
Cj4NCj5LVk0gaGFzIGEgc2xvdHMgZGF0YSBzdHJ1Y3R1cmUgdGhhdCBpdCB1c2VzIHRvIHRyYWNr
IGd1ZXN0IG1lbW9yeSBwYWdlcy4NCj5EdXJpbmcgZXhlYywgc2xvdHMgaXMgY2xlYXJlZCBwYWdl
LWJ5LXBhZ2UgaW4gdGhlIHBhdGgNCj4gICBjb3B5X3BhZ2VfcmFuZ2UgLT4gbW11X25vdGlmaWVy
X2ludmFsaWRhdGVfcmFuZ2Vfc3RhcnQgLT4NCj5rdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVf
cmFuZ2Vfc3RhcnQNCg0KVW5kZXJzdG9vZCwgeW91IHdhbnQgdG8gYXZvaWQgemFwcGluZyBFUFQg
YnkgY2xvc2luZyBrdm0gZmQuDQoNCj4NCj4+IFdoZW4gZXhlYywgb2xkIGt2bV9mZCBpcyBjbG9z
ZWQgd2l0aCBjbG9zZV9ub19leGVjIGltcGxpY2l0bHksIEkgZG9uJ3QNCj51bmRlcnN0YW5kDQo+
PiB3aHkgZmFzdGVyIGlmIGt2bV9mZCBpcyBjbG9zZWQgZXhwbGljaXRseS4NCj4NCj5UaGUga2Vy
bmVsIGNsb3NlcyBjbG9zZS1vbi1leGVjIGZkJ3MgYWZ0ZXIgY29weV9wYWdlX3JhbmdlLCBhZnRl
ciB0aGUgbW11DQo+bm90aWZpZXINCj5oYXMgZG9uZSBhbGwgdGhlIHBlci1wYWdlIHdvcmsuDQoN
CkNsZWFyLCBmb3IgdGhlIHdob2xlIHNlcmllczoNCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

