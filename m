Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727F5C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 00:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4UlM-0004CU-CG; Tue, 07 May 2024 20:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4UlK-0004Bx-A6
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:02:22 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4UlG-0006Lx-VJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 20:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715126539; x=1746662539;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=89nplJH3TD8AmnM4P0DPpyng+/ddTFVW4Q10hBd6TY4=;
 b=TL9gtVSnL2i4PNLtT5JokpH4z73D8Z5zgFD35vpJGS+WRz3vbxSaWtrA
 ND2xo8bozJQl057lZPIRNLxKA6EZqLsy0TI8GkU4hHnvdGeVVF6ezYw/1
 CzggVG3o7O4v1hdw82ji8e4eH41YbqerFyfwLTBS4yGN3DjVvykV2ihEo
 ATEjZ8SI4RdiLTNT+M3okIdTbMtvCmsP5X3vQ0I4jhIK2IWtPngWX95gr
 lrT+ccAw0gKQsV2XTD6JgVf2TTcOuiRsMJIN7YAXaOu7WkNU8UkhLNYqe
 iAPeysOMRvuMTezLUS4GDY7LSxYd1L5WYZePjY5OfXw5NjbwMVsUeb3jJ g==;
X-CSE-ConnectionGUID: R0NFOY7iS7CZ643G5Va5cA==
X-CSE-MsgGUID: pVRXnbD6R6iuesAdbhZ1jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10801383"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="10801383"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 17:02:16 -0700
X-CSE-ConnectionGUID: 70ts3woCQGWatcYpHKpGmA==
X-CSE-MsgGUID: WjUdEDwcQ7mDDI8vwEbigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="33512296"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 17:02:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:02:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:02:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 17:02:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:02:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7gWSuoG9isQaSZRGhOFNEjqGIhpdyqMWZ6PtK9zjUefj0BpBgZHvlSWH4o3zQ8afCGWeDfF0ObtMl7bbfq3y5tmsoW5nMiPd961jzKEH/n3+pWGrnTeKhkYfBk2YaGJQCLqvAHstnF4jQzd4gnOt/O31CTsZ4AaIIIF8EVhGq6cY12FJMcsAcR4jngpObk4mal4ryAGY91kYorMJRTVq9utqgWFbMjyvHOR/L9ZQVVgsYug6e8y//mR1tvL5J4CCNVgZVYMz/e7Sgvy7F3y//lFuHVson+IMoRHF0kVP3LvG9qpX1acD7ApFkXTYVP00EIfu3Z1q4mxFFbnxoR6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89nplJH3TD8AmnM4P0DPpyng+/ddTFVW4Q10hBd6TY4=;
 b=VO+d3vOh5HgHrVd7LkwRWLskygoyzBtm5GFB7Oq2ImLwdYg5gQwRcXS+Cx3WkOnA3ecn2UefWCSAYpV7rm6zne8P07V3k150akkdcRymzNLiXYQ3EEBMnI+Ue6yuZmm5tAKfrjRu6awQGtmFo5rZ7PQkpdd/6dyBpWmbQe332tGeZdVrtN8H46r7gHTh5EQwFJpRAHEEKe2pKMi8TQFu7sbfL06XlTBXGvMXqMACl1GXA15p8ILfCBHTC9BeD6ZrbfbJkFOYhV3VUnz8O1L0UeM6brCaNHUiQ8xi8GgAatc7aZi5MK2N0T/D6u25oZIzLot65LRRsNpEShu88dDoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 00:02:07 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7544.029; Wed, 8 May 2024
 00:02:07 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: RE: [PATCH] ui/gtk: Explicitly set the default size of new window
 when untabifying
Thread-Topic: [PATCH] ui/gtk: Explicitly set the default size of new window
 when untabifying
Thread-Index: AQHam3pZkemeOhX0gEqvV08Xr60niLGL6lkAgAANvCCAAISXkA==
Date: Wed, 8 May 2024 00:02:07 +0000
Message-ID: <PH8PR11MB6879F8708F95322D3FF23133FAE52@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240501034133.167321-1-dongwon.kim@intel.com>
 <CAJ+F1CKxB5CGkR=xvgR8X7sm2X+qW0sd3VE=uf01JRZcgOkyRg@mail.gmail.com>
 <PH8PR11MB6879CC01FED69C2965252F19FAE42@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6879CC01FED69C2965252F19FAE42@PH8PR11MB6879.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SA1PR11MB5945:EE_
x-ms-office365-filtering-correlation-id: b258666e-cb98-412a-dc54-08dc6ef219ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UzdkUTVpcVZ0alRSN0ZvRm9wN3hwTTZKREx2eENQZzhDL0JETWhFRnlyT3lP?=
 =?utf-8?B?cWlRZCt1RnBBQ0xadDFLNEg4MnR4VFpGYURLd0ZoSUlONU0yTVBuWUR6SnRj?=
 =?utf-8?B?c1VnNEkxbUk4WlZVTVQ4RUJ5cUxHSC9OQW11MXJDaVgrVzhocXJWWlBMK1Vo?=
 =?utf-8?B?MitWdC9ibUYvRnJNeVRRMnVjempSbGJvQkxOdGtsNHh6cnBmUkZLVVhVTnBv?=
 =?utf-8?B?NEhqZFBSWStIRGJ2aStLY3k1YjV6T1FpV3dlT1UxaVorMytvUGNiWjFMMUE5?=
 =?utf-8?B?NG1oUjZUSnUyN2ttTnJqamVVRWpmcVlTaVhsbWNnNktzUExqT3VJa3pyYktQ?=
 =?utf-8?B?YWk4eld3eUxvd3lLSDNiNFdoUmdqYitTd3VmWmZxSittclRiS2FvNzQ3SmZI?=
 =?utf-8?B?UjcrRndadVRQTUNrVzVZdDdrZkpsd25MRFJoUFNmVVNYdlg3TWVhc2JRa084?=
 =?utf-8?B?ektEaG1BeWM4bE03RkdlNjZ2Z0JkV0ZUb3J6V3N6T0dWMjBOUzQ5cU9QVXZO?=
 =?utf-8?B?aFM3SURMdkFGaUpCNWRQY1M3VGtPT05vcTZINStoRGFLOVlYYlc0N09UcWhK?=
 =?utf-8?B?L3IyMWhMZlpuVmNUaDkxTitYcG5DMEtxYWpqd0NsQjFQUUdrRm9FZGtKNzJt?=
 =?utf-8?B?RkM1UGI3aWwrVmpzZS9XeEZxU0tqdjYrVmlMQVdvMnEyV2IyMG85Mk1ISS9w?=
 =?utf-8?B?UXNzU05pOXRTckJRcHZjeXFwTVZxOHpnWTUvUjZLWVFYV1o1WDA4c2pNeWlD?=
 =?utf-8?B?SXVPdkQ3TlEwQVJoRWRhOXdOSXhDZjBKNXZPbkZ2TVVCUng5UlpERU9PaGdF?=
 =?utf-8?B?WlRIZVZaQXZHU0crTlRJM1hJcjBsbjBnUXJjdDYwRm1pMXlPNGR5bC9xdEpr?=
 =?utf-8?B?cVFqNWU2Y1d5ekdyQXJ4WXhvZ1RNQTJ5MFV5cWUveU5FTUJzcFgvV3lGUENT?=
 =?utf-8?B?U3lweU1rekZzTzlBTXI5NVlxdGZJM0NTKzFsanEvTEkzWGRYRTc3NURHaGl1?=
 =?utf-8?B?RDBING1uNTY1YkNIdmZadWZCbU10YktxQjdhK0p5MjZOUFZaeURheUNIUzF2?=
 =?utf-8?B?Wnk2Rll1TlBPNVU4ZURPOGwvTzdiVC9jT3NvQlpPdHBoSWczSXhQUTdiOGpZ?=
 =?utf-8?B?V0hHWlNlaEV4ZnhFM2UwMUtsZnlxbm1Wd1ZBT3ZzUzJhU2gwOVJ3SFpqY3hU?=
 =?utf-8?B?encxSkY5UThhWnNBYlNEellNeHVNbzFqbktOZllPWWI5dmpVK0dmRFZXYXk2?=
 =?utf-8?B?NmNndXUzKzVUaHBMQjdoR3UwS3l6YlI5Z3d1bWxIcndDVDllN1M0NVJrT2Jo?=
 =?utf-8?B?VzAwYXJUczZhUG90d1hUS1U2ZkYvQkJBUndEaWM0YWM2ZitsTm80aEtUdzdk?=
 =?utf-8?B?VzNHZUpqVW1wY2FiM3ZzdEU3SDhBWVRVVTYyZWVoZTc3THdqOTVBamRZUWd3?=
 =?utf-8?B?S1E0SWdUaExzbFBZM1A0VGhyS2NPUHQyOWZLc1FwZ01XcjZhZ01hRVVxN212?=
 =?utf-8?B?eFJ0bkRqYUUzdDNVOW5nNEd1TVBKU0JTUjR5QnByVjcxb2hFakxJL0VwaXZQ?=
 =?utf-8?B?VVZDNitQU3FPYm4xMTlOVUs1THp4MWtqbGRWOG5ENCs1bVJkVGYySHdOZE45?=
 =?utf-8?B?QXQxUXJOcGx0UHN6MHF1bGtGU24vdmFBU3FvbHFlYWZHeU1lalQ4eEk3TlRo?=
 =?utf-8?B?STVrcmZRNnNoMVFEejdQM2FUVTFnc1RXb0Y4elo4SnFyc2VRRW8yVHNDMVpR?=
 =?utf-8?B?eG1mRnZOWHFWcCt1OGx1Y2prcFVLV3RHSFB6QlNVcTRzK1RNaC9MRDdxOG1w?=
 =?utf-8?B?UUpGdjV2akpubUdMTEdUZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk5rbURyTi9qU0hGK3VzbVhKYVhwcHp1aGtQd2lWdE5rREgvZTF4akJ6bjFv?=
 =?utf-8?B?NHlQVXBhd2VlYnNsSGRyUnVMTTRpZk00KzJ1ZVVOTnJ0N0hpZUdYUThxMXFu?=
 =?utf-8?B?eXdLWGRYbXIrcFhRczFvazRXUjcvTStIWU9HcnlOTU9zc2thazFwR1NwL1lI?=
 =?utf-8?B?eHNKcXZ0NDgyVnMxSnUzMWZDeXhZMHFZcWVqMmZhRjAzSWRQc25pUTlwMmxD?=
 =?utf-8?B?ZnRmRzlaR3k0REVVQ2E3RlVUenNJUUdpQ04vTVJsdHZvOENhNHBMeFRxVGlP?=
 =?utf-8?B?emJxZ2VhZXdVcHdZZ1h5VkhBNTRrOTJjZjlreGRUWXpaT1B2YVN2L0RCL3pr?=
 =?utf-8?B?NlQ4bU8zTW9HT3lrL21ZOUkwdVhhNVE1SEJmY0J0S3Q4VTZvVVo5dWRVUUlB?=
 =?utf-8?B?amNvSGpscE5Sa2s0aHYrQW40dzQzOElHQ1pBOXI4MHF1TjJtd1dsMjErMXdm?=
 =?utf-8?B?cnZKQjNKV2krN3hWSzQ1U2NTczRRcjV6OUlnVmpMeGd1aEk3cy9xRlZGSnBI?=
 =?utf-8?B?VitPS3JYNEVncDQ3KzVqZU0wR1VZaWFYYVd0VFhXNXh1clgySDBFaGFuZ0dq?=
 =?utf-8?B?ZnlGMmJrdCtMNmdHSnV1cGtvVkVjVk9lZzd2dkd6ZVAwbXVFSU1kVW10Rm9x?=
 =?utf-8?B?VEVvWmJRTGY5QTRGMndxcVU0dTBLWUFXbTR6eE9xOFBYNmo0NEhkc2N1MzNK?=
 =?utf-8?B?ZExidUhTV01xRVhKTjhGTHNyaVpEaVd1Zm5DL2dJcmJkQ1dQZzRxOGNjRDUw?=
 =?utf-8?B?SDBvTUtGaVJJRmFKd2FhbmdwcktWd1J6dHp4eVkyYlBwanNUTDhNMnBaUVhT?=
 =?utf-8?B?TWQ1MEtJZGZBc1dBTUEzc2g1UmY5dktMMmc2bEtLUG82azZnMUN2Q2pjUzk1?=
 =?utf-8?B?S3ZNWGZBb1NmdW1HaUN0UG5KNHh0OTluSVFabE9pdmpKNElRamorZ3E4dVdK?=
 =?utf-8?B?VTNFYjVDWUVQU2xZaEp1ZTR0RWRvcXBTUjBWekEwWGhkUFNzWWpzcDJTM1FP?=
 =?utf-8?B?L0VXU1o0ZlhJWlI5RXU4SmpCSVdkRzhSL0IyZVBJUEFuckwrT0V2MnFXSU0z?=
 =?utf-8?B?dDFhczZSRnpRZmhKZ0NiYjQ5RWdVS0R6dmFRNnN0MnorLzAwVlJ5N09UZ0Zu?=
 =?utf-8?B?bWlCZEZpbFhhYy9EcDNOK3RKVThuVHdjUm5FTm9BZGdJdkk4ckptaHJjMWNP?=
 =?utf-8?B?SHpISUxWR2V5ZWlWTC9YY0xvcHJIeXZiMVdUdkFxeGd1WURRbUthOW5rUjlp?=
 =?utf-8?B?MDF4RG8yOXlnQ2NEeEVtTVBScWlDZWpULzRSaDc4STNHTzRueTg2SkkrZjVB?=
 =?utf-8?B?SWxiK2FsZUUyUkJ4MG5Wc2tKZFhIUk45Vlo4bTJGczc5M2VyQ3BrWDNBWENF?=
 =?utf-8?B?RzRkOVFZbkhYSDhXc1F2VFA2b2FPbXk2d1hCeWVTR3hsYy9WcDhwR1FKSHEx?=
 =?utf-8?B?YU1LU2F2aUpnREw5TVBLUUhxb1hCNnFZdzNidG0rZ0VRaEdmZXd0cjVvbDh1?=
 =?utf-8?B?Q1dMdm1OSmlUTEZnN05sU2R6dGxHeXY1QUF0TituQWs4d0VVY1RqRHJtUlEz?=
 =?utf-8?B?THRsSG9ZaGQ0MWlqaG5RVE5ML1BXL3lmNFdKMTlTdHpmRkIxYVo5YlN5MFN6?=
 =?utf-8?B?MGcyQTEzWnFINFZIZ0VIWktZSytDWkJwanpsK0J0bmRGOWdHaU92N1lTeGVG?=
 =?utf-8?B?YnQ4blhGMWEvMkxHNkhUT1UreVFTeUJkQWREVVIwb1l1eGc5bzY2alBTUklm?=
 =?utf-8?B?UjR6MUM3RlRYUVUvQVhLblgzak1zOEl2c01Ka2NVb3JzTE4xRjRNMTM2VVpi?=
 =?utf-8?B?NEVCaXlYS2ZaanQvc2NsbmJBb0JndmFIWEJzdGVRbUcyY2drTHl0NFd1V0xL?=
 =?utf-8?B?MVEzSkIvcjJIUTJDK3ZpNzFVOEJPR21ieXhnNUJMMFd6UStLdG1NZXZkQmRy?=
 =?utf-8?B?MUNHOGducDVVczlDNGc0ODhUWFNZR2FtaGRIUHRKdzBUUHgzVldJdy8yOWly?=
 =?utf-8?B?ZUNsYmsxcmphbm5PZFZFU0FldHlVZnFXVHJvZnZ4UktBUVdXN1NQWGV5dHhC?=
 =?utf-8?B?N3U0RjB5UHEraEs1U205NUhzOUFMa0FWRmFvVVNIencrdzgxRnZTUHVMcTIr?=
 =?utf-8?Q?LbnCC6sMTmLQkniqFjcZoEJFd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b258666e-cb98-412a-dc54-08dc6ef219ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 00:02:07.1395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXYbF1aoTFDj0dug++I+PrXOie4Kamck6IoxHpx+zhFnaGReJaW78jcRUINcZKaWsQ8Q6eDreOITtq3si8SV5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCkkgZm91bmQgdGhhdCB0aGUgcHJvYmxlbSBpcyBhY3R1YWxseSBk
dWUgdG8gc2NhbGluZyBmYWN0b3Igb2YgMC4yNSAoVkNfU0NBTEVfTUlOKS4NCg0Kc3RhdGljIHZv
aWQgZ2RfdXBkYXRlX2dlb21ldHJ5X2hpbnRzKFZpcnR1YWxDb25zb2xlICp2YykNCnsNCiAgICBH
dGtEaXNwbGF5U3RhdGUgKnMgPSB2Yy0+czsNCiAgICBHZGtXaW5kb3dIaW50cyBtYXNrID0gMDsN
CiAgICBHZGtHZW9tZXRyeSBnZW8gPSB7fTsNCiAgICBHdGtXaWRnZXQgKmdlb193aWRnZXQgPSBO
VUxMOw0KICAgIEd0a1dpbmRvdyAqZ2VvX3dpbmRvdzsNCg0KICAgIGlmICh2Yy0+dHlwZSA9PSBH
RF9WQ19HRlgpIHsNCiAgICAgICAgaWYgKCF2Yy0+Z2Z4LmRzKSB7DQogICAgICAgICAgICByZXR1
cm47DQogICAgICAgIH0NCiAgICAgICAgaWYgKHMtPmZyZWVfc2NhbGUpIHsNCiAgICAgICAgICAg
IGdlby5taW5fd2lkdGggID0gc3VyZmFjZV93aWR0aCh2Yy0+Z2Z4LmRzKSAqIFZDX1NDQUxFX01J
TjsNCiAgICAgICAgICAgIGdlby5taW5faGVpZ2h0ID0gc3VyZmFjZV9oZWlnaHQodmMtPmdmeC5k
cykgKiBWQ19TQ0FMRV9NSU47DQogICAgICAgICAgICBtYXNrIHw9IEdES19ISU5UX01JTl9TSVpF
Ow0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAgICAgZ2VvLm1pbl93aWR0aCAgPSBzdXJmYWNl
X3dpZHRoKHZjLT5nZnguZHMpICogdmMtPmdmeC5zY2FsZV94Ow0KICAgICAgICAgICAgZ2VvLm1p
bl9oZWlnaHQgPSBzdXJmYWNlX2hlaWdodCh2Yy0+Z2Z4LmRzKSAqIHZjLT5nZnguc2NhbGVfeTsN
CiAgICAgICAgICAgIG1hc2sgfD0gR0RLX0hJTlRfTUlOX1NJWkU7DQogICAgICAgIH0NCiAgICAg
ICAgZ2VvX3dpZGdldCA9IHZjLT5nZnguZHJhd2luZ19hcmVhOw0KICAgICAgICBndGtfd2lkZ2V0
X3NldF9zaXplX3JlcXVlc3QoZ2VvX3dpZGdldCwgZ2VvLm1pbl93aWR0aCwgZ2VvLm1pbl9oZWln
aHQpOw0KDQpzLT5mcmVlX3NjYWxlIGlzIHNldCB3aGVuICd6b29tX3RvX2ZpdCcgaXMgc2V0LiBU
aGlzICd6b29tX3RvX2ZpdCcgaXMgbm9ybWFsbHkgc2V0IHZpYSBwYXJhbSBidXQgaXQgaXMgdW5j
b25kaXRpb25hbGx5IHNldCB3aGVuDQp1aV9pbmZvIGlzIHN1cHBvcnRlZCBsaWtlIHdoZW4gc29t
ZSBkaXNwbGF5IGRldmljZSBpcyBlbmFibGVkIGxpa2UgdmlydGlvLXZnYS4NCg0KU28gaGVyZSBm
cmVlX3NjYWxlIGlzIHRydWUgc28gbWluX3dpZHRoIGFuZCBtaW5faGVpZ2h0IGFyZSBzZXQgdG8g
MS80IG9mIG9yaWdpbmFsIHdpZHRoL2hlaWdodCBvZiB0aGUgc3VyZmFjZSAoNjQweDQ4MCkuIFRo
YXQgaXMgdG90YWxseSBmaW5lLg0KQnV0IHRoZSByZWFsIHByb2JsZW0gaXMgYXQgDQoNCmd0a193
aWRnZXRfc2V0X3NpemVfcmVxdWVzdChnZW9fd2lkZ2V0LCBnZW8ubWluX3dpZHRoLCBnZW8ubWlu
X2hlaWdodCk7DQoNCkkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IHdlIGFyZSBtYWtpbmcgc2V0IHNp
emUgcmVxdWVzdCB3aXRoIHRoZXNlICJtaW4iIHZhbHVlcy4NCg0KVGhpcyBjb21taXQgZnJvbSBH
ZXJkIG9yaWdpbmFsbHkgaW50cm9kdWNlZCB0aGUgMC4yNSBzY2FsaW5nIGZhY3RvciBidXQgbm90
IHN1cmUgd2hhdCBpcyBpbnRlbnRpb24gdGhlcmUuDQooSSBob3BlIEdlcmQgY2FuIGNvbW1lbnQg
b24gdGhpcy4pDQoNCmNvbW1pdCA4MmZjMTgwOTlhYThlZTI1MzNhZGQ1MjNjYzAwNjlmMjZhODNl
N2I2DQpBdXRob3I6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KRGF0ZTogICBG
cmkgTWF5IDE2IDEyOjI2OjEyIDIwMTQgKzAyMDANCg0KICAgIGd0azogd2luZG93IHNpemluZyBv
dmVyaGF1bA0KDQogICAgTWFqb3Igb3ZlcmhhdWwgZm9yIHdpbmRvdyBzaXplIGhhbmRsaW5nLiAg
VGhpcyBiYXNpY2FsbHkgc3dpdGNoZXMgcWVtdQ0KICAgIG92ZXIgdG8gdXNlIGdlb21ldHJ5IGhp
bnRzIGZvciB0aGUgd2luZG93IG1hbmFnZXIgaW5zdGVhZCBvZiB0cnlpbmcgdG8NCiAgICBnZXQg
dGhlIGpvYiBkb25lIHdpdGggd2lkZ2V0IHJlc2l6ZSByZXF1ZXN0cy4gIFRoaXMgYWxsb3dzIHRv
IHNwZWNpZnkNCiAgICBiZXR0ZXIgd2hhdCB3ZSBuZWVkIGFuZCBhbHNvIGF2b2lkcyB3aW5kb3cg
cmVzaXplcy4NCg0KICAgIEZJWE1FOiBvbiBndGsyIHNvbWVvbmUgb3ZlcndyaXRlcyB0aGUgZ2Vv
bWV0cnkgaGludHMgOigNCg0KICAgIFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhl
bEByZWRoYXQuY29tPg0KDQpJIGFtIHdvbmRlcmluZyBpZiB3ZSBjb3VsZCBqdXN0IHNldCBnZW8u
YmFzZV93aWR0aCBhbmQgaGVpZ2h0IHRvIHRoZSBub3JtYWwgc2l6ZSB0aGVuIHVzZSB0aGVzZSBp
bnN0ZWFkIHdoZW4gbWFraW5nIHNpemUgcmVxdWVzdCB0aGVyZS4NCg0KQ2FuIHlvdSBzaGFyZSB5
b3VyIHRob3VnaHQ/DQoNClRoYW5rcywNCkRXDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3VuY2VzK2Rvbmd3b24ua2ltPWludGVsLmNvbUBub25n
bnUub3JnIDxxZW11LQ0KPiBkZXZlbC1ib3VuY2VzK2Rvbmd3b24ua2ltPWludGVsLmNvbUBub25n
bnUub3JnPiBPbiBCZWhhbGYgT2YgS2ltLA0KPiBEb25nd29uDQo+IFNlbnQ6IFR1ZXNkYXksIE1h
eSA3LCAyMDI0IDk6MDYgQU0NCj4gVG86IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUBnbWFpbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGtyYXhlbEByZWRo
YXQuY29tDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHVpL2d0azogRXhwbGljaXRseSBzZXQgdGhl
IGRlZmF1bHQgc2l6ZSBvZiBuZXcgd2luZG93IHdoZW4NCj4gdW50YWJpZnlpbmcNCj4gDQo+IEhp
IE1hcmMtQW5kcsOpLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUBnbWFpbC5jb20+DQo+ID4g
U2VudDogVHVlc2RheSwgTWF5IDcsIDIwMjQgODoxMCBBTQ0KPiA+IFRvOiBLaW0sIERvbmd3b24g
PGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBr
cmF4ZWxAcmVkaGF0LmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVpL2d0azogRXhwbGlj
aXRseSBzZXQgdGhlIGRlZmF1bHQgc2l6ZSBvZiBuZXcNCj4gPiB3aW5kb3cgd2hlbiB1bnRhYmlm
eWluZw0KPiA+DQo+ID4gSGkNCj4gPg0KPiA+IE9uIFdlZCwgTWF5IDEsIDIwMjQgYXQgNzo0N+KA
r0FNIDxkb25nd29uLmtpbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEZyb206IERv
bmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4gPg0KPiA+ID4gV2hlbiB1bnRh
YmlmeWluZywgdGhlIGRlZmF1bHQgc2l6ZSBvZiB0aGUgbmV3IHdpbmRvdyB3YXMNCj4gPiA+IGlu
YWR2ZXJ0ZW50bHkgc2V0IHRvIHRoZSBzaXplIHNtYWxsZXIgdGhhbiBxdWFydGVyIG9mIHRoZSBw
cmltYXJ5DQo+ID4gPiB3aW5kb3cgc2l6ZSBkdWUgdG8gbGFjayBvZiBleHBsaWNpdCBjb25maWd1
cmF0aW9uLiBUaGlzIGNvbW1pdA0KPiA+ID4gYWRkcmVzc2VzIHRoZSBpc3N1ZSBieSBlbnN1cmlu
ZyB0aGF0IHRoZSBzaXplIG9mIHVudGFiaWZpZWQgd2luZG93cw0KPiA+ID4gaXMgc2V0IHRvIG1h
dGNoIHRoZSBzdXJmYWNlIHNpemUuDQo+ID4NCj4gPiBGcm9tIGEgcXVpY2sgdGVzdCwgSSBkb24n
dCBzZWUgYSBkaWZmZXJlbmNlIG9mIGJlaGF2aW91ciBhZnRlciB0aGUNCj4gPiBwYXRjaC4gQ291
bGQgeW91IGhlbHAgbWUgcmVwcm9kdWNlIHRoZSBpc3N1ZT8NCj4gPg0KPiA+IEkgYWxzbyBkb24n
dCB0aGluayBpdCBpcyBjb3JyZWN0IGZvciB0d28gcmVhc29uczoNCj4gPiAtIHRoZSBpbm5lciBk
aXNwbGF5IHdpZGdldCBzaG91bGQgY2F1c2UgYSB3aW5kb3cgc2l6ZSByZWNvbmZpZ3VyYXRpb24N
Cj4gPiAtIHRoZSB3aW5kb3cgc2l6ZSAhPSBkaXNwbGF5IHNpemUNCj4gDQo+IFtLaW0sIERvbmd3
b25dIE9rLCBJIHNlZSB0aGlzIGlzIGhhcHBlbmluZyBvbmx5IHdoZW4gdmlydGlvLXZnYSBkZXZp
Y2UgaXMgdXNlZA0KPiBsaWtlDQo+IHFlbXUtc3lzdGVtLXg4Nl82NCAtbSAyMDQ4IC1lbmFibGUt
a3ZtIC1jcHUgaG9zdCAtc21wIGNvcmVzPTIgLWRyaXZlDQo+IGZpbGU9Li9PVk1GLmZkLGZvcm1h
dD1yYXcsaWY9cGZsYXNoIC1kZXZpY2UgdmlydGlvLXZnYSAtZGlzcGxheSBndGssZ2w9b24gTWF5
YmUNCj4gc29tZSBzZXR0aW5nIG9mIGRpbWVuc2lvbnMgaXMgbWlzc2luZyBpbiB0aGVyZT8gSSB3
aWxsIHRha2UgYSBsb29rLg0KPiANCj4gPg0KPiA+IHRoYW5rcw0KPiA+DQo+ID4gPiBDYzogR2Vy
ZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+ID4gPiBDYzogTWFyYy1BbmRyw6kgTHVy
ZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gPiBDYzogVml2ZWsgS2FzaXJl
ZGR5IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRG9u
Z3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIHVpL2d0
ay5jIHwgMyArKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3RrLmMNCj4gPiA+IGluZGV4IDgx
MGQ3ZmM3OTYuLjI2OWI4MjA3ZDcgMTAwNjQ0DQo+ID4gPiAtLS0gYS91aS9ndGsuYw0KPiA+ID4g
KysrIGIvdWkvZ3RrLmMNCj4gPiA+IEBAIC0xMzk1LDYgKzEzOTUsOSBAQCBzdGF0aWMgdm9pZCBn
ZF9tZW51X3VudGFiaWZ5KEd0a01lbnVJdGVtDQo+ID4gPiAqaXRlbSwNCj4gPiB2b2lkICpvcGFx
dWUpDQo+ID4gPiAgICAgIGlmICghdmMtPndpbmRvdykgew0KPiA+ID4gICAgICAgICAgZ3RrX3dp
ZGdldF9zZXRfc2Vuc2l0aXZlKHZjLT5tZW51X2l0ZW0sIGZhbHNlKTsNCj4gPiA+ICAgICAgICAg
IHZjLT53aW5kb3cgPSBndGtfd2luZG93X25ldyhHVEtfV0lORE9XX1RPUExFVkVMKTsNCj4gPiA+
ICsgICAgICAgIGd0a193aW5kb3dfc2V0X2RlZmF1bHRfc2l6ZShHVEtfV0lORE9XKHZjLT53aW5k
b3cpLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN1cmZhY2Vf
d2lkdGgodmMtPmdmeC5kcyksDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3VyZmFjZV9oZWlnaHQodmMtPmdmeC5kcykpOw0KPiA+ID4gICNpZiBkZWZpbmVkKENP
TkZJR19PUEVOR0wpDQo+ID4gPiAgICAgICAgICBpZiAodmMtPmdmeC5lc3VyZmFjZSkgew0KPiA+
ID4gICAgICAgICAgICAgIGVnbERlc3Ryb3lTdXJmYWNlKHFlbXVfZWdsX2Rpc3BsYXksIHZjLT5n
ZnguZXN1cmZhY2UpOw0KPiA+ID4gLS0NCj4gPiA+IDIuMzQuMQ0KPiA+ID4NCj4gPiA+DQo+ID4N
Cj4gPg0KPiA+IC0tDQo+ID4gTWFyYy1BbmRyw6kgTHVyZWF1DQo=

