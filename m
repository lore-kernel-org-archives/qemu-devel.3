Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D321C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 09:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwTd-000135-CX; Fri, 30 May 2025 05:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwTZ-00012l-Tw
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:56:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwTW-000893-EI
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748598990; x=1780134990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GNvnQwj5znvGR2QdjLnCEGkxFGmP/XD8iyL3ZXsV49c=;
 b=AI4Pb+ADWbjbke/6IvjOnIlkWLgnL8Uo1i3ivicq3S4qvLzX7gLp9tE/
 zYCwd2fzpnSOBIr8vChoONSRjWLq1ub3cXoICJnVmva5elLrbNiZvFZKG
 o5dZrl0X49jwq2/j4LONqRYYRrgyS7mKQz3F82g4CIfU7sbDcHZvWdQoX
 rFv+N/QdJrPSepIm7VjThxX6xbaz1UfYSkR9sTWfCYofqPOicKtHMNN+6
 jA/aLIpruJg2cDBhXrqSUL5qWRdtlaZyGPQxifo2+/7AHzF0ZuI+ugnts
 mHSK2aUFxk7JQO1gfkq8mFa/D4rNt7/rr4Ts2cG66ZsA+BkNo+ictTTtY Q==;
X-CSE-ConnectionGUID: Pj7E/SGPTPG1M6O85qkiSQ==
X-CSE-MsgGUID: 2jFHTuUHTQCfffOacw3jBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="73220698"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="73220698"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:56:22 -0700
X-CSE-ConnectionGUID: vEF7XxxiRoSgfZr4NX/BMg==
X-CSE-MsgGUID: qDaDht0gRfmVnAMwNRSA7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="144302811"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:56:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 02:56:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 02:56:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.43)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 02:56:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtFWgatlsNoVxTKI+Xr8LIp4Am1gJBG1Ej0gS2ZogrpPsby4uHfdATHKFWDGuWXzKtP5ktcJWxF1krTsWoKEXHSUL7OumcUkGaw/z1mxaBWX8TIy5FwFIDEstlHUUcWdTZBL01YUMUMqOGOJf4vYjT2cxWHcvo1sHbigU5e27jh7jUuRYJOoC3XbdvAxGOs91o01dPq311NCyFkzukd4OxLwt72pdN3mM4c3pB+BwlSjpTQYRYHhW7XSyee2KYrEZuWzjT/KWyT58I1OHQYJFtMQ2UeEcwEw9j9Wp/52VIMagULpsfiJk21lLsREZ2+z7471M5vgA1dvgv63pnHjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNvnQwj5znvGR2QdjLnCEGkxFGmP/XD8iyL3ZXsV49c=;
 b=EL/JKlwzgt00E3HhfciTZ8gv+ms0tXrChbzGm7qCFjrBqlsFwanol3oaazd2cSk/T80d6yLgAMsX27GF+GgnPdWpx5oge7CppvEEcCeCFpJGMmU7hD+CL76tVD4eszApwvUjxrzIlTYoUTP64TSc6WwSRzBTotw9FcepCbFiW6QF8VfCwKx9w/476oMQaaHhr6xZeQBpHKzuyd6o5RQqMOw8b2v0L7L+ZwES3WytEPxwEf2R/XZg9kOdlGWYSwLyXpQfFOijfzFarltM9bHWWsqQH74QdqRETw048CczTzAIApneWdauYZHhc7aTCio3YdK4hYDXOwBuqQjwNns7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SN7PR11MB7591.namprd11.prod.outlook.com (2603:10b6:806:32b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 09:56:19 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::9136:e302:ad5f:b522%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 09:56:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flwgAUvL4CAAdBwAIAAb8tQgAC02wCAAOjXUIABMliAgADDF3CAAGaDAIAASWmAgAObTBCAA98xAIAC5wcw
Date: Fri, 30 May 2025 09:56:19 +0000
Message-ID: <PH7PR11MB6722E1F66CDA0BB9DD3238029261A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
 <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <4ef5640b-17af-4692-91ce-529735a21474@oracle.com>
 <e94d85b9-00a0-455c-8645-c439d90c5a55@oracle.com>
 <SJ0PR11MB6744A8D64A7392EA16C51D1E9265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7ff17616-c813-49cb-9074-2a2fd592c13a@oracle.com>
In-Reply-To: <7ff17616-c813-49cb-9074-2a2fd592c13a@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SN7PR11MB7591:EE_
x-ms-office365-filtering-correlation-id: aabe93f8-2a28-4d02-87af-08dd9f6039e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UEtYbklxek1zOGVsWmh3QkdxdnR5SDJidTFPVHlQdThkQTk5Nm0rZjBqZ0gz?=
 =?utf-8?B?TXdQY0VqM3FwdDFuK2dqcU5RenRUUmV3a3RUcUdRMlpqaC9IcFY1Q2dFYWVl?=
 =?utf-8?B?aEpWbGZ3STBuWHBMOFpDNG8yK3J6R1VvWUt3NU8zemNzbU54LzhhRHdNUDVZ?=
 =?utf-8?B?VXo3Y2txMUhwN3BMZTlpS2hLbXZCbjc2REx3SFhjTTZMWXgrMXBQQjJMaFcx?=
 =?utf-8?B?ODZvemxoV2Faa2oxSDVkNUNlUzVkeVUvWEY1aHFyUGoxZVVKazBlcWRLWWxn?=
 =?utf-8?B?amkzYmx1WHNQQ3FZSVQ3YkhvMzlQaGVINjJqOGFzdTZwdjNHWGh5OXBHYnJz?=
 =?utf-8?B?V01MMmF6OSs4eWNVNjNrYmVZYkdJNVVYN3RhaEMrVjBqLy9WcDIvbndqZm1I?=
 =?utf-8?B?NWg4QVpaZ3JQeWlEeEZuNjV6Sm5aOEh0ZUpicXhDMWxhSnl5Nm40WEJaU1N4?=
 =?utf-8?B?M1JjTmVJM0FCeWVyM1d6d09nVlEzMEhkZklPN1RxbjNPempiZlhzOWo4dEhK?=
 =?utf-8?B?aFNIWU1qSkhCN29xait4cEd2REcyYTd0T1A0Zkl4bmswZTlWOVhKdXo5MDJO?=
 =?utf-8?B?OUdNNzdtOEQ5UCsxRGE2amplRE1LK0N2TVllU3hGV0t1OUJLazhBQU5pMDRu?=
 =?utf-8?B?UHROUi9SWTh2QUsxQjFuclFiUDhqeS9paHlhR1ZVazhuRmIzaUZXOW9XSDl1?=
 =?utf-8?B?VjYwdEZpVE8wZWNpY2Fuay9IZkxwZjBFVjZETFdZNjNNUFYvYXpCZWRRam90?=
 =?utf-8?B?c2JFLzZsR2pEL3I4a0JhVzZmaU9SUWNwTGowbGdnTUpzeWk4Y1FhWkdwOXFa?=
 =?utf-8?B?Ymk1c1l6NHEvKzVQVVZVZHFmK2U1c0JMUGpUbDBUcTFJd3g1NE9tcU5kNW1u?=
 =?utf-8?B?ODNOeDNqL0dmOXRCSkFlUW9GWWRQSGVqdHErYzlIYXZ1YVgvdnFpM2p2bVQ1?=
 =?utf-8?B?ZUgreEthVmpXS1IxM2ZNNHlXUGZPM1lEWG52N25wb3FzdUtkWEVDV3NxUHp6?=
 =?utf-8?B?WGh0eWx5MHNqVVpFa0RXRjYwOGJYeGZXZG5TaFdmdmxwQWo0cUs5dlQrdFgr?=
 =?utf-8?B?Y1BEZ0wzUWJZWEg2U2xVSTZUaXBRc3h5VVNvcmFIb1d3UDZIVWEyZmYrSnBP?=
 =?utf-8?B?Mjc0RHljKzFaOGMyUnlqYm53Y2ppSktURXgxemxGTXM2UmJZSSticHFqSW1v?=
 =?utf-8?B?RUF5aWQ4M2k2NWFVRCsyWUc1OTBIdXhrNmlGNHJiZzNnS29nZStBQmNnNWE0?=
 =?utf-8?B?YTB3WUZqbWZIdTFuMjhtL0pxS2h5SzhiYzE1bDljZms4WGlTQlJ3QTRqQ00v?=
 =?utf-8?B?d2wxS3d1dFFuZ1BkMzlZKzBvWXNBZ2UzT080SEthNWVQYnlWbmJ2NElqNWJ0?=
 =?utf-8?B?Qkh3RTRDNFlUYmhndjh0YTZIMlY4RkhSK20reUUxM2xnT290anJEOHFDRGJh?=
 =?utf-8?B?S3ZycjBBS2RaQm0zak0xV01NQ1FpNVB1Qm1BUGdQUmpuUGtyTW1hWnhNR1RW?=
 =?utf-8?B?NHhmMnJmL0JySFZ0d3pYNit1QTQwSjFNOXorUmljaEFJbGxWOEljZ3M0MDBQ?=
 =?utf-8?B?anE1dER1ZXdxNStidmY3aElQZkg4SnNBQ3RtbWpEQkRtZHdWeVN3T2VDZmR6?=
 =?utf-8?B?c21yUDZsSVBYVjV5a2RhcTYraEl0L1NVcytqMW4xd2dEdlFIbjFiVlNnbWlx?=
 =?utf-8?B?aEdFSGxUTnNUWTB3UE9KWk5yS3pBZnVKSFltS01UcDdsS0o4L2dqMk1aTFBn?=
 =?utf-8?B?c0JUbk5QalpLVFNvWUlqclJHc2NJcFR1emp4Tk1MQjdCQ2M3WXh3WmFHQ2p0?=
 =?utf-8?B?RlpiQ2MrTmZCVDlSU2ZVSjVHRzlpeFoxT2IrRlM4TkJTbFZzUWJJZ3FlZFpU?=
 =?utf-8?B?S2FTTmJJVU5jcUNTbFY3VURCVE9VcnczZXRMSGlMSThGUkNFb2lhNHNBMkpi?=
 =?utf-8?B?R1Q2STUzU2xZMUdFdmV0VnJoYkd0VVBIemQ1NDVvcjNxeGtOSGZrR1d2alRV?=
 =?utf-8?Q?Ilr9XfXbrGD7up9mb21upsjiTM+aE4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW1hL2pZNG5FSEw5dFBUUlpGNFBBRFRkSEl4dDVnaFVTeWNidVlWT0FESTFC?=
 =?utf-8?B?NXpUN0xUSzRlS0FRcklLUFpLeXV2SGtYOGdUT2xpVUQxdTdJSHFsM09TSHFO?=
 =?utf-8?B?WkFmTXNmNVJIdEdoam02QUFKT0o2d0FGL1QyL0dVT0lSUjJ6OW9Cb1J6c2Zh?=
 =?utf-8?B?c2pwL3g3YklNMkM2QkdVZXduTXRKek9wRU5CVkNGWTBsVldjNmw4OElLeDly?=
 =?utf-8?B?cUhWKzVCbWplWUxqTTRzZlhpNWZlRDIzc2pJWWJqZ2hDa2d0SGw0MG9RMHhw?=
 =?utf-8?B?dHBvZkZLMGtFNlZvODdKbWZmY0hZaGx2RHNHcFFkcU0yejJvQmx3WGdTTk4z?=
 =?utf-8?B?UXRXdEw0OEVvTVRGZTdKR0JCTW1DVEM1c09Yd2toWnNZd1NRQUp5KzNjVm8w?=
 =?utf-8?B?anhGWjZiSUZEajhNdTltNXFWKzc1UEtiTWhQRkpWUTduT0ZLaGEwNHNjK09R?=
 =?utf-8?B?Y1JYRkI1WDZCSzNpS3k5NXdwbVp6THpCUHNHZUhLY3UwSzkwVlNMTmNySzhw?=
 =?utf-8?B?b21qY25MbzNLK01sTTQrdjYyenNGcS9TTVE1ZEk4aUkvU2lxcFlTUHVBTEo5?=
 =?utf-8?B?NmxhYitja2tZbEJOd1JWTlkwa2tHeGNDODJKSVRvcWgyUCtSdG5BcDM5RGIz?=
 =?utf-8?B?MThYTHArY0E4cmoxcE90YkJtNXVQRURKaUxmU3BGd1NOM3B5VmNyZ3hVc3Vz?=
 =?utf-8?B?Rml2WG80WVJOUTdSSnZQN2xSWXdHREEvMU5GZUN5VEl1alRmTEpVdmdDaFZW?=
 =?utf-8?B?VE9OYmlGNkw3ZWcyYWpYRDBXaEMvbGpzQVZvZjM5UXdZVUlIV3c5Wk5hQzZk?=
 =?utf-8?B?R0xJNkV0bGR1NGgvTzlwbXBpdTNJMEZqd2J6SEIrMWpjSVhYekZEMksxRzJ0?=
 =?utf-8?B?ZDF6bzNwNnVEOHJuL1lXSVBrNUFqWjRremp1Q3NvZWdIb0FLeWJYclhJMlZ6?=
 =?utf-8?B?VXpKYXZ3MG1nMEszalpmeWR2MEVWQ2xaYzBwTWFGMmtoZExyN3pkdkdndW9t?=
 =?utf-8?B?YzY5aktsTkhyRXVyNHdESGZ4NDlFWVZrS0tPazZhWjhaTVJpaUVDckFXbWhG?=
 =?utf-8?B?TG0xVlEzNkNjY3F3N2tKUldOUGh1Rm1XTHB5QnhkQVQ1STZjRnM3NjdoMk95?=
 =?utf-8?B?SmdtaTBNZ0FCWmhYNGJKelQyemlYTDRhR2NOQjZmaDhOU3RldmJweDU1MjFG?=
 =?utf-8?B?NExmbHR1a2EzOGxhSkdHb1g0enR5OVV5TndNNDBWVWFLTVkyVytwRTR1QkFM?=
 =?utf-8?B?UVhtTEtucDNkUHBGNFZZVGcvSFFNY3lxRy9jNDA2UGtZMSt2NFJhOHc2dmd0?=
 =?utf-8?B?QXBwUkZ4WVpzT1FTTE5HbER2bUFyNDAxU1RZT01taXRITDdzUXZOaWNIQ0Fy?=
 =?utf-8?B?ak5FdmdCcFhOY2RKeTNnRGNDZEhHUnJlQ0xzazZ5TW1kNUtxZTRpVFhLR0I1?=
 =?utf-8?B?Kzlldng5cnBaYXY2dU9VT0ZwL3BBY1VUN09RUUoydXdDdTMxb0U4NmhpRkl5?=
 =?utf-8?B?T1puaWZDbXJJeTlRbGJUY1lQK0oyeWFKRVBSVUtYVDhYU1ZqMEVyaVA3bGRy?=
 =?utf-8?B?ZHNjaXplUEhNdkZqSzJNRXAzaXdiQTZhMERKcW5vVUV6WUR2WFBCSGFxaG0z?=
 =?utf-8?B?ZytlRDNrcHNncFRlMUJ2MzdVZnI2QTFoYVI1cFhXVVdZdTRSbzdOSTczVTMy?=
 =?utf-8?B?dlpYalBKN3hDbHZYbmtqbzNqcXZNOFlWQ2RrUDZwZ05EMU1yNDdGOTZBSzcv?=
 =?utf-8?B?U3lrRW5ocitBRWxBZjI5T2Nzd2ZvWDVuVzZiTFRtbXVrWGdzcXBqWHdoT05i?=
 =?utf-8?B?TFM3akVkRzdNbi9iWHU1a3k4dzRPVHNWRnZYRmtteGp2MkdMMy9wNDJyUW91?=
 =?utf-8?B?dEdjb3RNcG9uTGNLMThzQXFyZ2EvQzlnVE1vMXN3cnp3OUp2ODQxS1NnV3ZE?=
 =?utf-8?B?Y3M5cnl3SW9jTWFtVUk5SEd2UHFjOXU5VjRSdENONjhqdmtORC9TNHUrYmdW?=
 =?utf-8?B?QlhQUGx6Y0g0T1RzcGdkSHl3UVh1Q05SMzBJSUROR21JWHBEZ3hPbzVEbWJE?=
 =?utf-8?B?WHNIbkVzQ0U1QVRJdy9uRTJrTlJsbEwrRmprL3Q0R0pTdnhhTUZ6VUJFUzJM?=
 =?utf-8?Q?U+Cl+2wKuEdcvQT3p1QKrSdoM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabe93f8-2a28-4d02-87af-08dd9f6039e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 09:56:19.2952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrsglUAd3wv7b8bpbQbyHbrEWkyjnIFLbfrNw34GWuKj1759QlNSF1pFAed+buteeqa3h+X2R1REW6Zofz+VzSB4YU/1LLn5zc/H0dAtBdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7591
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJd
IGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+DQo+T24gNS8yNS8yMDI1
IDEwOjMxIFBNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xl
LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDI5LzQyXSBiYWNrZW5kcy9pb21tdWZk
OiBjaGFuZ2UgcHJvY2VzcyBpb2N0bA0KPj4+DQo+Pj4gT24gNS8yMy8yMDI1IDEwOjU2IEFNLCBT
dGV2ZW4gU2lzdGFyZSB3cm90ZToNCj4+Pj4gT24gNS8yMy8yMDI1IDQ6NTYgQU0sIER1YW4sIFpo
ZW56aG9uZyB3cm90ZToNCj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+
IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJdIGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBw
cm9jZXNzIGlvY3RsDQo+Pj4+Pj4NCj4+Pj4+PiBPbiA1LzIxLzIwMjUgMTE6MTkgUE0sIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
Pj4+Pj4+PiBGcm9tOiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4N
Cj4+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJdIGJhY2tlbmRzL2lvbW11ZmQ6
IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gT24gNS8yMC8yMDI1IDEx
OjExIFBNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+Pj4+Pj4+Pj4+IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lz
dGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDI5LzQy
XSBiYWNrZW5kcy9pb21tdWZkOiBjaGFuZ2UgcHJvY2Vzcw0KPmlvY3RsDQo+Pj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+IE9uIDUvMTkvMjAyNSAxMTo1MSBBTSwgU3RldmVuIFNpc3RhcmUgd3JvdGU6DQo+
Pj4+Pj4+Pj4+PiBPbiA1LzE2LzIwMjUgNDo0MiBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0K
Pj4+Pj4+Pj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4+Pj4+Pj4+PiBG
cm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4+Pj4+
Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggVjMgMjkvNDJdIGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBw
cm9jZXNzDQo+aW9jdGwNCj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+Pj4gRGVmaW5lIHRoZSBj
aGFuZ2UgcHJvY2VzcyBpb2N0bA0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+Pj4+
Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+Pj4+Pj4gYmFja2VuZHMvaW9tbXVmZC5jwqDCoMKgwqDCoMKg
IHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4+Pj4+Pj4+Pj4+Pj4gYmFja2VuZHMvdHJhY2Ut
ZXZlbnRzwqDCoMKgIHzCoCAxICsNCj4+Pj4+Pj4+Pj4+Pj4gaW5jbHVkZS9zeXN0ZW0vaW9tbXVm
ZC5oIHzCoCAyICsrDQo+Pj4+Pj4+Pj4+Pj4+IDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKQ0KPj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMv
aW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+Pj4+Pj4+Pj4+IGluZGV4IDVjMTk1
OGYuLjZmZWQxYzEgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4+IC0tLSBhL2JhY2tlbmRzL2lvbW11ZmQu
Yw0KPj4+Pj4+Pj4+Pj4+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+Pj4+Pj4+Pj4+Pj4g
QEAgLTczLDYgKzczLDI2IEBAIHN0YXRpYyB2b2lkDQo+Pj4+Pj4+PiBpb21tdWZkX2JhY2tlbmRf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcw0KPj4+Pj4+Pj4+PiAqb2MsDQo+Pj4+Pj4+Pj4+Pj4+IGNv
bnN0IHZvaWQgKmRhdGEpDQo+Pj4+Pj4+Pj4+Pj4+ICDCoMKgIMKgwqDCoMKgIG9iamVjdF9jbGFz
c19wcm9wZXJ0eV9hZGRfc3RyKG9jLCAiZmQiLCBOVUxMLA0KPj4+Pj4+Pj4gaW9tbXVmZF9iYWNr
ZW5kX3NldF9mZCk7DQo+Pj4+Pj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+
Pj4gK2Jvb2wgaW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBhYmxlKElPTU1VRkRCYWNrZW5kICpi
ZSkNCj4+Pj4+Pj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgaW9tbXVf
aW9hc19jaGFuZ2VfcHJvY2VzcyBhcmdzID0gey5zaXplID0NCj5zaXplb2YoYXJncyl9Ow0KPj4+
Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJuICFpb2N0bChiZS0+ZmQs
IElPTU1VX0lPQVNfQ0hBTkdFX1BST0NFU1MsICZhcmdzKTsNCj4+Pj4+Pj4+Pj4+Pj4gK30NCj4+
Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiArYm9vbCBpb21tdWZkX2NoYW5nZV9wcm9jZXNz
KElPTU1VRkRCYWNrZW5kICpiZSwgRXJyb3INCj4+PiAqKmVycnApDQo+Pj4+Pj4+Pj4+Pj4+ICt7
DQo+Pj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlvbW11X2lvYXNfY2hhbmdlX3Byb2Nlc3Mg
YXJncyA9IHsuc2l6ZSA9DQo+c2l6ZW9mKGFyZ3MpfTsNCj4+Pj4+Pj4+Pj4+Pj4gK8KgwqDCoCBi
b29sIHJldCA9ICFpb2N0bChiZS0+ZmQsIElPTU1VX0lPQVNfQ0hBTkdFX1BST0NFU1MsDQo+Pj4g
JmFyZ3MpOw0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4gVGhpcyBpcyBzYW1lIGlvY3RsIGFz
IGFib3ZlIGNoZWNrLCBjb3VsZCBpdCBiZSBjYWxsZWQgbW9yZSB0aGFuIG9uY2UNCj4+PiBmb3IN
Cj4+Pj4+Pj4+IHNhbWUNCj4+Pj4+Pj4+Pj4gcHJvY2Vzcz8NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+
Pj4+PiBZZXMsIGFuZCBpdCBpcyBhIG5vLW9wIGlmIHRoZSBwcm9jZXNzIGhhcyBub3QgY2hhbmdl
ZCBzaW5jZSB0aGUgbGFzdA0KPnRpbWUNCj4+Pj4+PiBETUENCj4+Pj4+Pj4+Pj4+IHdhcyBtYXBw
ZWQuDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IE1vcmUgcXVlc3Rpb25zPw0KPj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4gTG9va3MgYSBiaXQgcmVkdW5kYW50IGZvciBtZSwgbWVhbndoaWxlIGlmDQo+Pj4+
Pj4gaW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBhYmxlKCkNCj4+Pj4+Pj4+IGlzIGNhbGxlZCBv
biB0YXJnZXQgcWVtdSwgbWF5IGl0IGRvIGJvdGggY2hlY2tpbmcgYW5kIGNoYW5nZT8NCj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+IEkgd291bGQgc3VnZ2VzdCB0byBkZWZpbmUgb25seSBpb21tdWZkX2No
YW5nZV9wcm9jZXNzKCkgYW5kDQo+Y29tbWVudA0KPj4+IHRoYXQNCj4+Pj4+Pj4+IGl0J3Mgbm8t
b3AgaWYgcHJvY2VzcyBub3QgY2hhbmdlZC4uLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IFdlIG5lZWQg
dG8gY2hlY2sgaWYgSU9NTVVfSU9BU19DSEFOR0VfUFJPQ0VTUyBpcyBhbGxvd2VkIGJlZm9yZQ0K
Pj4+Pj4+Pj4gcGVyZm9ybWluZw0KPj4+Pj4+Pj4gbGl2ZSB1cGRhdGUgc28gd2UgY2FuIGFkZCBh
IGJsb2NrZXIgYW5kIHByZXZlbnQgbGl2ZSB1cGRhdGUgY2xlYW5seToNCj4+Pj4+Pj4+DQo+Pj4+
Pj4+PiB2ZmlvX2lvbW11ZmRfY3ByX3JlZ2lzdGVyX2NvbnRhaW5lcg0KPj4+Pj4+Pj4gIMKgwqDC
oMKgwqAgaWYgIXZmaW9fY3ByX3N1cHBvcnRlZCgpwqDCoMKgwqDCoMKgwqAgLy8gY2FsbHMNCj5p
b21tdWZkX2NoYW5nZV9wcm9jZXNzX2NhcGFibGUNCj4+Pj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqAgbWlncmF0ZV9hZGRfYmxvY2tlcl9tb2RlcygpDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoaXMgcmVt
aW5kcyBtZSBvZiBvdGhlciBxdWVzdGlvbnMsIGlzIHRoaXMgaW9jdGwoKSBzdWl0YWJsZSBmb3Ig
Y2hlY2tpbmcgaWYNCj5jcHItDQo+Pj4+Pj4gdHJhbnNmZXIgc3VwcG9ydGVkPw0KPj4+Pj4+PiBJ
ZiB0aGVyZSBpcyB2SU9NTVUsIHRoZXJlIGNhbiBiZSBubyBtYXBwaW5nIGFuZCBwcm9jZXNzX2Nh
cGFibGUoKQ0KPmNoZWNrDQo+Pj4gd2lsbA0KPj4+Pj4+IHBhc3MsDQo+Pj4+Pj4+IGJ1dCBpZiBt
ZW1vcnkgaXMgbm90IGZpbGUgYmFja2VkLi4uDQo+Pj4+Pj4+IERvZXMgY3ByLXRyYW5zZmVyIHN1
cHBvcnQgdklPTU1VIG9yIG5vdD8NCj4+Pj4+Pg0KPj4+Pj4+IEkgZG9uJ3Qga25vdywgSSBoYXZl
IG5vdCB0cmllZCB5b3VyIHNhbXBsZSBhcmdzIHlldCwgYnV0IEkgd2lsbC4NCj4+Pj4+PiBXaXRo
IHZJT01NVSwgd2hhdCBlbnRpdHkvaW50ZXJmYWNlIHBpbnMgbWVtb3J5IGZvciB0aGUgdmZpbyBk
ZXZpY2U/DQo+Pj4+Pg0KPj4+Pj4gT2gsIEkgZG9uJ3QgbWVhbiB2aXJ0aW8taW9tbXUsIGl0IGNh
biBiZSBpbnRlbC1pb21tdSBvciB2aXJ0aW8taW9tbXUgZm9yDQo+dGhpcw0KPj4+IGlzc3VlLg0K
Pj4+Pj4gSSBtZWFuIHdoZW4gZ3Vlc3QgYXR0YWNoIGRldmljZSB0byBhIERNQSBkb21haW4sIHRo
ZXJlIGNhbiBiZSBubw0KPm1hcHBpbmcNCj4+PiBpbiB0aGF0IGRvbWFpbiBpbml0aWFsbHkuDQo+
Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4+IFFFTVUga25vd3MgZGV0YWlscyBvZiBhbGwgbWVtb3J5IGJh
Y2tlbmRzLCB3aHkgbm90IGNoZWNraW5nIG1lbW9yeQ0KPj4+Pj4+IGJhY2tlbmRzIGRpcmVjdGx5
IGluc3RlYWQgb2YgYSBzeXN0ZW0gY2FsbD8NCj4+Pj4+Pg0KPj4+Pj4+IElPTU1VX0lPQVNfQ0hB
TkdFX1BST0NFU1MgaXMgcmVsYXRpdmVseSBuZXcuIFRoZSBpb2N0bCB2ZXJpZmllcyB0aGF0DQo+
dGhlDQo+Pj4+Pj4ga2VybmVsDQo+Pj4+Pj4gc3VwcG9ydHMgaXQuwqAgQW5kIGlmIHN1cHBvcnRl
ZCwgaXQgYWxzbyB2ZXJpZmllcyB0aGF0IGFsbCBkbWEgbWFwcGluZ3MgYXJlDQo+Pj4+Pj4gb2Yg
dGhlIGZpbGUgdHlwZS4NCj4+Pj4+DQo+Pj4+PiBCdXQgdGhlIGRtYSBtYXBwaW5ncyBhcmUgZHlu
YW1pYyBpZiB0aGVyZSBpcyB2SU9NTVUsIHNvIGNoZWNraW5nIGRtYQ0KPj4+IG1hcHBpbmdzIGFy
ZSBjaGVja2luZyBub3RoaW5nIGlmIHRoZXJlIGlzIG5vIG1hcHBpbmcgaW4gdGhlIERNQSBkb21h
aW4uDQo+Pj4+DQo+Pj4+IFllcywgc28gdGhlcmUgYXJlIDIgY2hlY2tzOg0KPj4+PiAgIMKgICog
YXQgcmVhbGl6ZSAtPiBjcHIgcmVnaXN0ZXIgdGltZS7CoCBpZiBjcHIgY2FuIG5ldmVyIHdvcmsg
YmVjYXVzZQ0KPj4+PiAgIMKgwqDCoCBJT01NVV9JT0FTX0NIQU5HRV9QUk9DRVNTIGlzIG5vdCBz
dXBwb3J0ZWQsIHRoZW4gYWRkcyBhIGJsb2NrZXIuDQo+Pj4+DQo+Pj4+ICAgwqAgKiBhdCBjcHIg
dGltZSwgaW4gdmZpb19jb250YWluZXJfcHJlX3NhdmUuwqAgcmVmdXNlcyB0byBwcm9jZWVkIGlm
DQo+Pj4+ICAgwqDCoMKgIGlvbW11ZmRfY2hhbmdlX3Byb2Nlc3MoKSBmYWlscyBiZWNhdXNlIG5v
bi1maWxlIG1hcHBpbmdzIGFyZSBwcmVzZW50Lg0KPj4+PiAgIMKgwqDCoCBBbGxvd3MgY3ByIGlm
IHRoZXJlIGFyZSBubyBtYXBwaW5ncyBwcmVzZW50Lg0KPj4NCj4+IExldCBtZSBleHBsYWluIGZ1
cnRoZXIuDQo+Pg0KPj4gVGhlcmUgaXMgYSBjb3JuZXIgY2FzZSB0aGF0IGNvdWxkIGJ5cGFzcyBh
Ym92ZSBjaGVja3MuIFNvdXJjZSBxZW11IHN0YXJ0cyB3aXRoDQo+PiB2SU9NTVUgYW5kIG5vbi1m
aWxlIG1lbW9yeSBiYWNrZW5kLCB0aGVuIGhvdHBsdWcgVkZJTyBkZXZpY2UsIGlmIGd1ZXN0DQo+
PiBkcml2ZXIgZG9lc24ndCBzZXR1cCBhbnkgbWFwcGluZyBvciBubyBndWVzdCBkcml2ZXIgYXR0
YWNoZWQsIHRoZSBtYXBwaW5nIG9uDQo+PiBob3N0IHNpZGUgY2FuIGJlIGVtcHR5LCB0aGVuIGFi
b3ZlIGNoZWNrcyB3aWxsIGJvdGggcGFzcy4NCj4NCj5UaGF0IGlzIE9LLiAgQ1BSIGlzIGFsbG93
ZWQgaW4gdGhhdCBjYXNlIGFuZCBzdWNjZWVkcyBiZWNhdXNlDQo+aW9tbXVmZF9jaGFuZ2VfcHJv
Y2Vzcw0KPmhhcyBub3RoaW5nIHRvIGRvLg0KPg0KPkhvd2V2ZXIsIGFmdGVyIENQUiwgaWYgbm9u
LWZpbGUgbWFwcGluZ3MgYXJlIGFkZGVkLCB0aGVuIHRoZSBuZXh0IENQUiBvcGVyYXRpb24NCj53
b3VsZCBiZSBibG9ja2VkLg0KDQpDbGVhciwgbm8gcHJvYmxlbS4gVGhhbmtzIGZvciB5b3VyIGV4
cGxhbmF0aW9uLg0KDQpaaGVuemhvbmcNCg==

