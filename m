Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18249C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxm6-00063e-To; Wed, 02 Jul 2025 09:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxlm-0005v2-Sm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:45:04 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWxli-0001tM-O2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751463898; x=1782999898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vj9Nra7fQ2/ZUp1KTP4pzr549hYNHAeriW+KJ19MrwE=;
 b=iAmXx7PvshO+l8k52Xgi+MyAUThoqVGV9/feMMGluA7NZtqVIXoT0nmY
 29MExOkaZiVUtITGChGvWk7Mqo7E9/2fA1Ihse1zS7sRLREZKsSKvJP+U
 SB8lP9bqoc9qddOn+XAb8ym+sPHelYMGNBLdv2FOR2SlcE7arzuxxszQw
 8V7fCzKa2Z2B2Q93hRH6UhpbRuDoS9MlP33Hwx01u1YHKjgYeVG+1YI8B
 ecFXXU1EZdvBFS6CgDYsFtMJM278EhlP5PLHNnM5lQe+ON8kzNlqZmi5w
 yI4WFor/RtNWUsvM2qQXwJ16ap8eQtz0yoFKZIqbqxy7h1Uyehb0RRB/K g==;
X-CSE-ConnectionGUID: ziU4TF9KTomp2b1GJo3a5Q==
X-CSE-MsgGUID: JcbRhRw6QGWem2NxRf6bFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53853777"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53853777"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:44:53 -0700
X-CSE-ConnectionGUID: M6qcCO8JRm2oIpa/7aS+NQ==
X-CSE-MsgGUID: upkBBpNRRDWS30UYRNbhJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153854074"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 06:44:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:44:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 06:44:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 06:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8uyWkZn/ltdaYWerbepL+C6jzvJYhdh5s9te/iSmilw5zovq/pjAX7nDPb3k/zzXeQPkVYPQzzHWRBcaUcb/4pVwWwxwWlNMw6yZWPpoCaZCsHyXpdYhGhbozYoSf7+L5yZtzeIUsZ2T8nvR7dNgnSvQC0Wz8DuiKFht8H1oZTYEbgNnzMYpuw5fv1d2lR8RWY+Tj+/BN/M35MS5kS76RlmJMiWfJS61+xWNd39fVYLGrxLrNsZCoS8w2C3T2Bf8lUN1wJaDBXMwgmprEz/JP6abjdeQr35BikJN5mBd/8rOujDpIKY7vz3YQPuRS5bkuMFD+tT0MxCDn1u4EtJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj9Nra7fQ2/ZUp1KTP4pzr549hYNHAeriW+KJ19MrwE=;
 b=AfXxKwkof+e+4Bg1ciWYpqh73GxG4BhXShU9LOkcxXuIbP8WOcNK/amTAcB7QPRVOsGwzGIBtc4HnQzf7DbAMD/5alY1wsqBi5EQogDCsER5m4xGFdKobWdYKxjiPWihoCyEPg+PhiKbQ7qmXejlGs8OCH7bD2lCxbNBclI5iJcbfyR4ALOhBnGFROe46NUfiu9yvyAo6lCQ7sl0PeQKMQ03ioTaIup+yuWhotyhx0bTVJmqKvRW3bx9m/jEqpHPY4OXaVBeuZ2fZJ+hy6HMUfo24Q8ayL1XbYOMZKgTYh1Hd6gWxx0STyL4QiIrC4nEv4C8W0hCUt2IXBzvFSvqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Wed, 2 Jul
 2025 13:44:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 13:44:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 31/38] vfio/iommufd: cpr state
Thread-Topic: [PATCH V5 31/38] vfio/iommufd: cpr state
Thread-Index: AQHb2h4NVeUNEp49j0+Outy3gmpN/7QQozaAgAzQzYCAAYYIMA==
Date: Wed, 2 Jul 2025 13:44:21 +0000
Message-ID: <IA3PR11MB91364F73B7BD388270D55D849240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-32-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913698E6A59B6531BEF5F60E9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <08778487-e070-49e2-8f77-a072c2ec8ddc@oracle.com>
In-Reply-To: <08778487-e070-49e2-8f77-a072c2ec8ddc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: 1dcd792d-5634-43a7-3e1f-08ddb96e8cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QUFiT3dDNUh3UW9OdXhSOGZkd1J0dFZ2TGVxN2tKbnR1dHJReUFIeE9hZ2Uz?=
 =?utf-8?B?RW1weFNseXJSbTRwSG9XL0JRak1vRXFiTlp4SXJqSVpMWXh6Zm00OTNwT0lR?=
 =?utf-8?B?TGpwVzhyczBlLzJ0eGNwT05INW0vUmw5bmE3NXRKK0hFcmlJVnRHeklISXVG?=
 =?utf-8?B?RTg5ZGFVcTlkMmxVd24yMllWL0xCbGtVdWxWOEgyUzRzSi85dVpZR25ieWFx?=
 =?utf-8?B?ZFdSUnU1NEF2MDhpa1RkTE9xRDVsM3Bja3lGZUlrZDJxN1o3dmN1S1BETWtE?=
 =?utf-8?B?MUpNdGI3eHlSRE1oNVJ1VDNDTzM1K3pyYkVPRko1MU14aVVVUjd2TFVHeWRu?=
 =?utf-8?B?NkFwL2ZIdUgwL3RuMjNHSDBkb0ZTbUgzQlNHcU9tSmU0S3R4V0dRL2NZZzJt?=
 =?utf-8?B?NndHN0FkM0Zxdkc3eHlaWGEzWExkMWpwVHFpVWZsQ1JBRWFGRjZpZElCRnBL?=
 =?utf-8?B?bDlsU2tvekJOUEd6OUFHc0hGb0RNMXVvamxybWEyRDllQ0FWSGlvTCtQckF5?=
 =?utf-8?B?MHU5MmRHSTJYdjJsL1RJYUg4VzlKLzhKOEdvS0JJV2pYYWdkay9CMVE5L29L?=
 =?utf-8?B?Z2NOaDIyUjllREFIZVdHd0NreTh6NnRLb3pySFh5aUsxbWo2WCtRZng3ZXZk?=
 =?utf-8?B?RXFxU3RFRlpqZFViZmY5Z0tXakZTc3UxazJGVUlXSndkamswN0UvbU5JSkhM?=
 =?utf-8?B?MU15QWdzU0Vtd2wvMWUvT3RyRjBPVFczS04zcjl5eGxlYlZEZ2M3bE1XYUhs?=
 =?utf-8?B?MTNoZWxYQTB6MytnN2NabTUzTDZjZlhFUm1EaC9XWWtGekx5T1VoNC9EQmZO?=
 =?utf-8?B?bWdTNE1qZkdqWndGZFdJM1lmcDZnWFFYZUFKMmozTUxib2ZmYXorZ2N2UitE?=
 =?utf-8?B?R2JWQkdScmRaMnFuQlE5c3FXNUptOSt5akl0WFRTdk45ZlNJR1huL3hsN1dM?=
 =?utf-8?B?QVZvSEJ3YjRDSzdMRlcxY3A4czFCOTNqQVFaWE5DYXBPSDRzdjRxMmZFMDY2?=
 =?utf-8?B?MjFESTdBbSttWTlVS3E2WW13RXFjdGU5cGZPc2h4ekFPckdLaDF5WDlnU3RW?=
 =?utf-8?B?VkNUdjJtRWdCc3JlNHI2U1BkR3lUZUx6UGw5K3gvMnM4UXpHUTc0K1ZPK24v?=
 =?utf-8?B?aXNBUFJlbHVLQVNERlBWQ080VG14UXdMUTlDNXdmcERxVHZ6VkZwWUFiMmt4?=
 =?utf-8?B?S2xlVFQ0NWVId0hlWGplWHc4NUp1Mm5EUlhSUUkxbEtteGlNbUdXYjV1QzV5?=
 =?utf-8?B?MVJHaXdhRUIweGlxZDFxQUMwR0FrVE5kbndPT3BqdEVtREVYTGRRbWRxUXRr?=
 =?utf-8?B?cmxQYzd6Uk5zVHNaVS95dGVvVUxXZVRwR29OSWtSemxVNGo1bjRhODNGQjE5?=
 =?utf-8?B?MjRNRGJ0SXFta3U5UkhFbnd3YmZkZldIM21BL0M1akRsYTRDZk9LbGhsYnQ3?=
 =?utf-8?B?ek9lUzR3WTFhM0I4SVNpbTVlNngrRVhMdWFJazhQUTZCZFl0Q25hQUVDUndh?=
 =?utf-8?B?QnNyVk1iR3hIWU5FaUtEaXZCT25uczBObGRvM21VM1NKdW9GZW4xaUMyWUdl?=
 =?utf-8?B?a2pNb2tuOVhQcHFpaWRGUDQ0RklVaGNPY2l2OWRnQ054dXFHclRkODY4a1Rh?=
 =?utf-8?B?RlpUckpiM1ROZTFDT1RWMUZ1RnRaWXpCWkF4c1FLeW5Nc3pvVXRwQzhQVFZm?=
 =?utf-8?B?RGtrSEV1SncybWFFUTVpMk1iV0tVQ2xyamN2NGsxaWhaV1ExY0ZhLzd4S3hD?=
 =?utf-8?B?d3lZWDJsQTFkak1rVUJ5b1duYmRVdmkwVG1ETDhERXhvRFVtam5DNDlMMTFw?=
 =?utf-8?B?N2dwdG0yOFJtWkRvdjZkcVEzemhCOUZGcW4xZjc1V05GQXRlbUlSdklHUkpI?=
 =?utf-8?B?cFA5VG1yWnFObzZlUUVCSFZkeklENWNvZmZFZER1YW5wSVN1RWpwYkdyNDJD?=
 =?utf-8?B?eFRFNkxjOXl4disrMWNQSXM0RXNqWVJEMXpqbmFHbm8rckdiSmFuSnN3QXIw?=
 =?utf-8?Q?gvgUr9wUseEiNA2pRbSiZRuV6PEXBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUYydUZaMFZQZlB5bXo1MTVLL3VsbEQxUC8rUHRxYnVvNUZEYnh2cWNqa2NR?=
 =?utf-8?B?ZmNCaVN1eFJ0TjBJUDlhM0VvQnQyZksrK1F6VEliWXFiRFhZOVhtSmdwMVRq?=
 =?utf-8?B?b1JCY3pXZjlqaXN5aEtrYVQ2RmtkUG02aS9HcHdzcVpqZDNKbEtFVWVxRmt4?=
 =?utf-8?B?dEdEN1FQQS9udzNUaWlYdnd5QmRQYWxRa1Z1WlB6aTQ0TDFkcy9RZzQ3eHFZ?=
 =?utf-8?B?NmlQaTdFTXJ1SCtNdnFYM2xQaHlLTjNXcXRvSmhCOFBQeXVSQ2VMVWlKaDJE?=
 =?utf-8?B?SysyN2U1RGNnTm4yUFl3MGNNNUx3OE13OUw5WktkY3VKNWpSRUsveFhWNlZM?=
 =?utf-8?B?eXdiMHAyQzRWT1NYUGRRZE0rVVV1T2VrdmZEL0lhd2V3eUdOZUdkNUYzZ2hv?=
 =?utf-8?B?b1VDbTJCQ3lQT1Z1Y04vTVdaRHRTODNHdzdia1p4bDRiRitRSkhmc2xkYWpZ?=
 =?utf-8?B?ZWNNSnp0UGJsU0FJVGxkdDdOOGMzR01MQmxXdGY5cC9MbHlYU0VoRjdDWEYy?=
 =?utf-8?B?YngwYXc2Z0w4QmhndDBValY3ckpCYzhvaXJtUnpHV0lrU3l3aHpGL25PcFVG?=
 =?utf-8?B?ODRYeTBHZ1hEOHpZTS9VMWVreTlNTmVmdVZmZFBSQmlvZVQ5UkJ2emFMUlQ2?=
 =?utf-8?B?TVBZcDRQdmJ5N0Ywb3NNcFdpTWJTQnJBcktHVFVHRmNvN1d6bVV5WTZhMHJK?=
 =?utf-8?B?NWY0WHZtYzhVcUhWTVl5Y1REeUlHbEMwOEJEYWNpSVNPd1orK3RDVmM5SC85?=
 =?utf-8?B?M3BWT01DZnJBdmV0OVpObUM4YnNiaEdUQVBqNEFaa2RWKzFjRnpvYU1WZ0oy?=
 =?utf-8?B?YzBjWGhwUHlPcVkyYTltUjRUa0tzZTVaWjBWQUprOERIRFdaR3R5ZzhVMlZo?=
 =?utf-8?B?REZ1d3lQcFYyVndkc1h4NFVlVjlQUUd0UUZBN3BBRTYrRGYrcldwQ05IUTBS?=
 =?utf-8?B?VGY1VnR4ODlCbUE0cTNvRUNlK2JIcHh6cndWZXNvZHNSMVVDSy9BYUhObmRD?=
 =?utf-8?B?YzFhSkcyeGJjUkJMSnlOYWJiaHlLWmtHWmE3NUprUGFFaC9qZVRZZndhUVZ2?=
 =?utf-8?B?aDF5d2duOGludEZmMnlNa1c5ZG1WQWJ4YmtwMFhKY2lvQWVHNFFTU3U0R244?=
 =?utf-8?B?a1ZiaHJ2V1dGUG80VmFlRjU1UEhNMzA1NWNTWU5DVlhNbnRtY2d0eGpVcHYv?=
 =?utf-8?B?VU9vS3AzczA0cFVjL2FSTmg3K0FESDUyMldKbTJZWTVreUZEakt4bWZ0OGlZ?=
 =?utf-8?B?M2JSR1VDMHhNWDlrV2RQZnpLZHRVL1RhL0VTZEdnQnhvZFFIOWg3NU5xa3Vw?=
 =?utf-8?B?TEw0d2g0NzZtcXRjUnFCZHJERWFYZFNhRTJlMElmOHNLNWlTU1JMclBqam51?=
 =?utf-8?B?QmxNWjAzS2FMcUIzWHF2bjA2cUtteWpQNUZ5T01PNTJFaVNIdXQwcEovRUNQ?=
 =?utf-8?B?OWRDTVVnWU43SC9jWVpPR003TXB3Ukx4RkpmR2kyQUlQeGxMWWFrWlI3SlJy?=
 =?utf-8?B?VXIvOE5zS3F3QTJVNjEzWFY2eGpoVnNxRUo4TzJLTTcvSElXc2NzcGNGd1NT?=
 =?utf-8?B?cDZaeWtCRmJUandVWkRPRndlNlNxeGRtZ25sSEYwWU1iYmxNSnR4bXVIdkIx?=
 =?utf-8?B?YlM4dlBtT1Raa3RCK3N1NWkzWlI0UWdaWW1UQm5ZdXQ1RFhIaUpUUXNJNitE?=
 =?utf-8?B?TDhSUVQxYVBtQXFZVldGZVprT1paeGNWM0E2RnZ4T2FucTdHSEQ0YTVmakR3?=
 =?utf-8?B?ZCtHQU9za2pCNnNoaGNURWZVQ3B0eGhiVHV5VlBlR05VU3U0TmdjRnhXR1lT?=
 =?utf-8?B?WGdzQjArWWd6d2dpczNKK0VzbUlzbmowSW1KZmVuSkFYTXIzWUgva25PZi84?=
 =?utf-8?B?RjZ6YXRqWHo3alBXM2l0QVFSdmV2TW5tNDZjWFdHNjRLYXVEaWVEN1A4QklH?=
 =?utf-8?B?RjVIZkZlMnJjY3V4bHByU0wwZjJZT1hnZHNMOVFLa2RtL0FjYlJ2SU55ckN1?=
 =?utf-8?B?VHMweTlzcENHekNadHZSbUt2VG5WRmFOSitHTkRoNWI5Risxb3l6L3J4dXcv?=
 =?utf-8?B?UXlGZ0JLOWNMRHlwbHcrL0lQNitNU1lqQmhoaXdRZWR6Y2FGc0tmLyszUjJY?=
 =?utf-8?Q?hgE50VF/5hHRhZaArZJ9gvFoV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcd792d-5634-43a7-3e1f-08ddb96e8cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 13:44:21.3940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2hAK3BdrtAwXXsbmJmuJ7qJ5dTmhZ19AoqLDmHGvuBCJr2n/6gslC7Cgxeg14+Fbs0HtouH+s6AhgbxqPfFfymd/5h11EmMweW9vzZS83k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMzEvMzhd
IHZmaW8vaW9tbXVmZDogY3ByIHN0YXRlDQo+DQo+T24gNi8yMy8yMDI1IDY6NDUgQU0sIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZy
b206IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4gU3ViamVj
dDogW1BBVENIIFY1IDMxLzM4XSB2ZmlvL2lvbW11ZmQ6IGNwciBzdGF0ZQ0KPj4+DQo+Pj4gVkZJ
TyBpb21tdWZkIGRldmljZXMgd2lsbCBuZWVkIGFjY2VzcyB0byBpb2FzX2lkLCBkZXZpZCwgYW5k
IGh3cHRfaWQgaW4NCj4+PiBuZXcgUUVNVSBhdCByZWFsaXplIHRpbWUsIHNvIGFkZCB0aGVtIHRv
IENQUiBzdGF0ZS4gIERlZmluZQ0KPkNwclZGSU9EZXZpY2UNCj4+PiBhcyB0aGUgb2JqZWN0IHdo
aWNoIGhvbGRzIHRoZSBzdGF0ZSBhbmQgaXMgc2VyaWFsaXplZCB0byB0aGUgdm1zdGF0ZSBmaWxl
Lg0KPj4+IERlZmluZSBhY2Nlc3NvcnMgdG8gY29weSBzdGF0ZSBiZXR3ZWVuIFZGSU9EZXZpY2Ug
YW5kIENwclZGSU9EZXZpY2UuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJl
IDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGluY2x1ZGUvaHcvdmZp
by92ZmlvLWNwci5oIHwgIDMgKysNCj4+PiBody92ZmlvL2Nwci1pb21tdWZkLmMgICAgICB8IDk2
DQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+
IGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgIHwgIDIgKw0KPj4+IDMgZmlsZXMgY2hhbmdlZCwg
MTAwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jcHIuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oDQo+
Pj4gaW5kZXggNjE5YWYwNy4uZjg4ZTRiYSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2h3L3Zm
aW8vdmZpby1jcHIuaA0KPj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oDQo+Pj4g
QEAgLTMzLDYgKzMzLDggQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0NvbnRhaW5lckNQUiB7DQo+Pj4g
dHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZUNQUiB7DQo+Pj4gICAgICBFcnJvciAqbWRldl9ibG9j
a2VyOw0KPj4+ICAgICAgRXJyb3IgKmlkX2Jsb2NrZXI7DQo+Pj4gKyAgICB1aW50MzJfdCBod3B0
X2lkOw0KPj4+ICsgICAgdWludDMyX3QgaW9hc19pZDsNCj4+PiB9IFZGSU9EZXZpY2VDUFI7DQo+
Pj4NCj4+PiBib29sIHZmaW9fbGVnYWN5X2Nwcl9yZWdpc3Rlcl9jb250YWluZXIoc3RydWN0IFZG
SU9Db250YWluZXIgKmNvbnRhaW5lciwNCj4+PiBAQCAtNTQsNiArNTYsNyBAQCBib29sIHZmaW9f
aW9tbXVmZF9jcHJfcmVnaXN0ZXJfaW9tbXVmZChzdHJ1Y3QNCj4+PiBJT01NVUZEQmFja2VuZCAq
YmUsIEVycm9yICoqZXJycCk7DQo+Pj4gdm9pZCB2ZmlvX2lvbW11ZmRfY3ByX3VucmVnaXN0ZXJf
aW9tbXVmZChzdHJ1Y3QgSU9NTVVGREJhY2tlbmQNCj4qYmUpOw0KPj4+IHZvaWQgdmZpb19pb21t
dWZkX2Nwcl9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+
PiB2b2lkIHZmaW9faW9tbXVmZF9jcHJfdW5yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IFZGSU9EZXZp
Y2UgKnZiYXNlZGV2KTsNCj4+PiArdm9pZCB2ZmlvX2Nwcl9sb2FkX2RldmljZShzdHJ1Y3QgVkZJ
T0RldmljZSAqdmJhc2VkZXYpOw0KPj4+DQo+Pj4gaW50IHZmaW9fY3ByX2dyb3VwX2dldF9kZXZp
Y2VfZmQoaW50IGQsIGNvbnN0IGNoYXIgKm5hbWUpOw0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vY3ByLWlvbW11ZmQuYyBiL2h3L3ZmaW8vY3ByLWlvbW11ZmQuYw0KPj4+IGluZGV4IDNl
NzgyNjUuLjJlY2E4YTYgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9jcHItaW9tbXVmZC5jDQo+
Pj4gKysrIGIvaHcvdmZpby9jcHItaW9tbXVmZC5jDQo+Pj4gQEAgLTcsNiArNyw3IEBADQo+Pj4g
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+PiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4+
ICNpbmNsdWRlICJody92ZmlvL3ZmaW8tY3ByLmgiDQo+Pj4gKyNpbmNsdWRlICJody92ZmlvL3Zm
aW8tZGV2aWNlLmgiDQo+Pj4gI2luY2x1ZGUgIm1pZ3JhdGlvbi9ibG9ja2VyLmgiDQo+Pj4gI2lu
Y2x1ZGUgIm1pZ3JhdGlvbi9jcHIuaCINCj4+PiAjaW5jbHVkZSAibWlncmF0aW9uL21pZ3JhdGlv
bi5oIg0KPj4+IEBAIC0xNCw3ICsxNSw4OCBAQA0KPj4+ICNpbmNsdWRlICJzeXN0ZW0vaW9tbXVm
ZC5oIg0KPj4+ICNpbmNsdWRlICJ2ZmlvLWlvbW11ZmQuaCINCj4+Pg0KPj4+IC1jb25zdCBWTVN0
YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9jcHJfdmZpb19kZXZpY2VzOyAgLyogVEJEIGluIGEgbGF0
ZXINCj5wYXRjaCAqLw0KPj4+ICt0eXBlZGVmIHN0cnVjdCBDcHJWRklPRGV2aWNlIHsNCj4+PiAr
ICAgIGNoYXIgKm5hbWU7DQo+Pj4gKyAgICB1bnNpZ25lZCBpbnQgbmFtZWxlbjsNCj4+PiArICAg
IHVpbnQzMl90IGlvYXNfaWQ7DQo+Pj4gKyAgICBpbnQgZGV2aWQ7DQo+Pj4gKyAgICB1aW50MzJf
dCBod3B0X2lkOw0KPj4+ICsgICAgUUxJU1RfRU5UUlkoQ3ByVkZJT0RldmljZSkgbmV4dDsNCj4+
PiArfSBDcHJWRklPRGV2aWNlOw0KPj4+ICsNCj4+PiArc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNj
cmlwdGlvbiB2bXN0YXRlX2Nwcl92ZmlvX2RldmljZSA9IHsNCj4+PiArICAgIC5uYW1lID0gImNw
ciB2ZmlvIGRldmljZSIsDQo+Pj4gKyAgICAudmVyc2lvbl9pZCA9IDEsDQo+Pj4gKyAgICAubWlu
aW11bV92ZXJzaW9uX2lkID0gMSwNCj4+PiArICAgIC5maWVsZHMgPSAoVk1TdGF0ZUZpZWxkW10p
IHsNCj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQzMihuYW1lbGVuLCBDcHJWRklPRGV2aWNlKSwN
Cj4+PiArICAgICAgICBWTVNUQVRFX1ZCVUZGRVJfQUxMT0NfVUlOVDMyKG5hbWUsIENwclZGSU9E
ZXZpY2UsIDAsDQo+TlVMTCwNCj4+PiBuYW1lbGVuKSwNCj4+PiArICAgICAgICBWTVNUQVRFX0lO
VDMyKGRldmlkLCBDcHJWRklPRGV2aWNlKSwNCj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQzMihp
b2FzX2lkLCBDcHJWRklPRGV2aWNlKSwNCj4+PiArICAgICAgICBWTVNUQVRFX1VJTlQzMihod3B0
X2lkLCBDcHJWRklPRGV2aWNlKSwNCj4+PiArICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkN
Cj4+PiArICAgIH0NCj4+PiArfTsNCj4+PiArDQo+Pj4gK2NvbnN0IFZNU3RhdGVEZXNjcmlwdGlv
biB2bXN0YXRlX2Nwcl92ZmlvX2RldmljZXMgPSB7DQo+Pj4gKyAgICAubmFtZSA9IENQUl9TVEFU
RSAiL3ZmaW8gZGV2aWNlcyIsDQo+Pj4gKyAgICAudmVyc2lvbl9pZCA9IDEsDQo+Pj4gKyAgICAu
bWluaW11bV92ZXJzaW9uX2lkID0gMSwNCj4+PiArICAgIC5maWVsZHMgPSAoY29uc3QgVk1TdGF0
ZUZpZWxkW10pew0KPj4+ICsgICAgICAgIFZNU1RBVEVfUUxJU1RfVih2ZmlvX2RldmljZXMsIENw
clN0YXRlLCAxLA0KPnZtc3RhdGVfY3ByX3ZmaW9fZGV2aWNlLA0KPj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBDcHJWRklPRGV2aWNlLCBuZXh0KSwNCj4+PiArICAgICAgICBWTVNUQVRFX0VO
RF9PRl9MSVNUKCkNCj4+PiArICAgIH0NCj4+PiArfTsNCj4+PiArDQo+Pj4gK3N0YXRpYyB2b2lk
IHZmaW9fY3ByX3NhdmVfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4+ICt7DQo+Pj4g
KyAgICBDcHJWRklPRGV2aWNlICplbGVtID0gZ19uZXcwKENwclZGSU9EZXZpY2UsIDEpOw0KPj4+
ICsNCj4+PiArICAgIGVsZW0tPm5hbWUgPSBnX3N0cmR1cCh2YmFzZWRldi0+bmFtZSk7DQo+Pj4g
KyAgICBlbGVtLT5uYW1lbGVuID0gc3RybGVuKHZiYXNlZGV2LT5uYW1lKSArIDE7DQo+Pj4gKyAg
ICBlbGVtLT5pb2FzX2lkID0gdmJhc2VkZXYtPmNwci5pb2FzX2lkOw0KPj4+ICsgICAgZWxlbS0+
ZGV2aWQgPSB2YmFzZWRldi0+ZGV2aWQ7DQo+Pj4gKyAgICBlbGVtLT5od3B0X2lkID0gdmJhc2Vk
ZXYtPmNwci5od3B0X2lkOw0KPj4+ICsgICAgUUxJU1RfSU5TRVJUX0hFQUQoJmNwcl9zdGF0ZS52
ZmlvX2RldmljZXMsIGVsZW0sIG5leHQpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgQ3By
VkZJT0RldmljZSAqZmluZF9kZXZpY2UoY29uc3QgY2hhciAqbmFtZSkNCj4+PiArew0KPj4+ICsg
ICAgQ3ByVkZJT0RldmljZUxpc3QgKmhlYWQgPSAmY3ByX3N0YXRlLnZmaW9fZGV2aWNlczsNCj4+
PiArICAgIENwclZGSU9EZXZpY2UgKmVsZW07DQo+Pj4gKw0KPj4+ICsgICAgUUxJU1RfRk9SRUFD
SChlbGVtLCBoZWFkLCBuZXh0KSB7DQo+Pj4gKyAgICAgICAgaWYgKCFzdHJjbXAoZWxlbS0+bmFt
ZSwgbmFtZSkpIHsNCj4+PiArICAgICAgICAgICAgcmV0dXJuIGVsZW07DQo+Pj4gKyAgICAgICAg
fQ0KPj4+ICsgICAgfQ0KPj4+ICsgICAgcmV0dXJuIE5VTEw7DQo+Pj4gK30NCj4+PiArDQo+Pj4g
K3N0YXRpYyB2b2lkIHZmaW9fY3ByX2RlbGV0ZV9kZXZpY2UoY29uc3QgY2hhciAqbmFtZSkNCj4+
PiArew0KPj4+ICsgICAgQ3ByVkZJT0RldmljZSAqZWxlbSA9IGZpbmRfZGV2aWNlKG5hbWUpOw0K
Pj4+ICsNCj4+PiArICAgIGlmIChlbGVtKSB7DQo+Pj4gKyAgICAgICAgUUxJU1RfUkVNT1ZFKGVs
ZW0sIG5leHQpOw0KPj4+ICsgICAgICAgIGdfZnJlZShlbGVtLT5uYW1lKTsNCj4+PiArICAgICAg
ICBnX2ZyZWUoZWxlbSk7DQo+Pj4gKyAgICB9DQo+Pj4gK30NCj4+PiArDQo+Pj4gK3N0YXRpYyBi
b29sIHZmaW9fY3ByX2ZpbmRfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4NCj4+IEJl
dHRlciB0byByZW5hbWUgYXMgdmZpb19jcHJfbG9hZF9kZXZpY2UNCj4NCj5UaGlzIGlzIGFscmVh
ZHkgY2FsbGVkIGJ5IGEgZnVuY3Rpb24gbmFtZWQgdmZpb19jcHJfbG9hZF9kZXZpY2UuDQo+VGhl
IHVzYWdlIGlzIHRoZSBzYW1lIGFzIGNwcl9maW5kX2ZkLCBzbyAiZmluZCIgaXMgYSBjb25zaXN0
ZW50IG5hbWUuDQoNCkkgdGhvdWdodCB0aGlzIGlzIGZpbmQgYW5kIGxvYWQuIFRoaXMgaXMgdHJp
dmFsLCBJJ20gb2sgd2l0aCBjdXJyZW50IGNoYW5nZS4NCj4NCj4+PiArew0KPj4+ICsgICAgQ3By
VkZJT0RldmljZSAqZWxlbSA9IGZpbmRfZGV2aWNlKHZiYXNlZGV2LT5uYW1lKTsNCj4+PiArDQo+
Pj4gKyAgICBpZiAoZWxlbSkgew0KPj4+ICsgICAgICAgIHZiYXNlZGV2LT5jcHIuaW9hc19pZCA9
IGVsZW0tPmlvYXNfaWQ7DQo+Pj4gKyAgICAgICAgdmJhc2VkZXYtPmRldmlkID0gZWxlbS0+ZGV2
aWQ7DQo+Pj4gKyAgICAgICAgdmJhc2VkZXYtPmNwci5od3B0X2lkID0gZWxlbS0+aHdwdF9pZDsN
Cj4+PiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+PiArICAgIH0NCj4+PiArICAgIHJldHVybiBm
YWxzZTsNCj4+PiArfQ0KPj4+DQo+Pj4gc3RhdGljIGJvb2wgdmZpb19jcHJfc3VwcG9ydGVkKElP
TU1VRkRCYWNrZW5kICpiZSwgRXJyb3IgKiplcnJwKQ0KPj4+IHsNCj4+PiBAQCAtNzksOCArMTYx
LDIwIEBAIHZvaWQNCj4+PiB2ZmlvX2lvbW11ZmRfY3ByX3VucmVnaXN0ZXJfY29udGFpbmVyKFZG
SU9JT01NVUZEQ29udGFpbmVyDQo+KmNvbnRhaW5lcikNCj4+Pg0KPj4+IHZvaWQgdmZpb19pb21t
dWZkX2Nwcl9yZWdpc3Rlcl9kZXZpY2UoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+Pj4gew0KPj4+
ICsgICAgaWYgKCFjcHJfaXNfaW5jb21pbmcoKSkgew0KPj4+ICsgICAgICAgIHZmaW9fY3ByX3Nh
dmVfZGV2aWNlKHZiYXNlZGV2KTsNCj4+PiArICAgIH0NCj4+PiB9DQo+Pj4NCj4+PiB2b2lkIHZm
aW9faW9tbXVmZF9jcHJfdW5yZWdpc3Rlcl9kZXZpY2UoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+
Pj4gew0KPj4+ICsgICAgdmZpb19jcHJfZGVsZXRlX2RldmljZSh2YmFzZWRldi0+bmFtZSk7DQo+
Pj4gK30NCj4+PiArDQo+Pj4gK3ZvaWQgdmZpb19jcHJfbG9hZF9kZXZpY2UoVkZJT0RldmljZSAq
dmJhc2VkZXYpDQo+Pj4gK3sNCj4+PiArICAgIGlmIChjcHJfaXNfaW5jb21pbmcoKSkgew0KPj4+
ICsgICAgICAgIGJvb2wgcmV0ID0gdmZpb19jcHJfZmluZF9kZXZpY2UodmJhc2VkZXYpOw0KPj4+
ICsgICAgICAgIGdfYXNzZXJ0KHJldCk7DQo+Pj4gKyAgICB9DQo+Pj4gfQ0KPj4+IGRpZmYgLS1n
aXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gaW5kZXggZmYy
OTFiZS4uZjBkNTdlYSAxMDA2NDQNCj4+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4+ICsr
KyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gQEAgLTUxNSw2ICs1MTUsOCBAQCBzdGF0aWMgYm9v
bCBpb21tdWZkX2NkZXZfYXR0YWNoKGNvbnN0IGNoYXINCj4qbmFtZSwNCj4+PiBWRklPRGV2aWNl
ICp2YmFzZWRldiwNCj4+PiAgICAgIGNvbnN0IFZGSU9JT01NVUNsYXNzICppb21tdWZkX3Zpb2Mg
PQ0KPj4+DQo+Pj4NCj5WRklPX0lPTU1VX0NMQVNTKG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVf
VkZJT19JT01NVV9JT01NVUZEDQo+KSk7DQo+Pj4NCj4+PiArICAgIHZmaW9fY3ByX2xvYWRfZGV2
aWNlKHZiYXNlZGV2KTsNCj4+DQo+PiBUaGlzIGNhbiBiZSBvcGVuIGNvZGVkLg0KPg0KPnZmaW9f
Y3ByX2xvYWRfZGV2aWNlIGdyb3dzIGluIHBhdGNoICJwcmVzZXJ2ZSBkZXNjcmlwdG9ycyIsIHNv
IEkgd291bGQNCj5yYXRoZXIga2VlcCBpdCBjbG9zZWQuDQo+DQo+LSBTdGV2ZQ0KPg0KPj4+ICsN
Cj4+PiAgICAgIGlmICh2YmFzZWRldi0+ZmQgPCAwKSB7DQo+Pj4gICAgICAgICAgZGV2ZmQgPSBp
b21tdWZkX2NkZXZfZ2V0ZmQodmJhc2VkZXYtPnN5c2ZzZGV2LCBlcnJwKTsNCj4+PiAgICAgICAg
ICBpZiAoZGV2ZmQgPCAwKSB7DQo+Pj4gLS0NCj4+PiAxLjguMy4xDQo+Pg0KDQpPSy4NCg0KUmV2
aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

