Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8A3C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 03:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMfDs-0001JL-1o; Tue, 03 Jun 2025 23:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMfDq-0001JA-Bc
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:55:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMfDn-0007fS-V1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749009324; x=1780545324;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FS/kZPCejNjQy3irgZZwO+dFrfh13idTsNGpdjkqFA8=;
 b=GdkaQyAgSQvBwxqOH4TSMvIjZqJQ8tmDwkFq0mnKyYnfYI9o4pT8wJoU
 7Ziebl1jYiGw7KJDbYPfgY6UGCukG2kPH1EK5DxMAJc/Tz7nqTZTpjMYI
 0pffeImYmw4nrPvI0xWlfTA19pXozJBhdilhuYl1k8lfTrpzbxH2gFLw7
 svdu1xP7Yz8Qa/EckLa1DCJoy6SgahgqGF2+96Xp1UQJqzYaXh6wU6+Bt
 KdohcbuhsuhII9tb7BbVeQJZA9EF8E5U85qwlM5VkUfXOLTDKcsWyLVVg
 OSHPdN3klcjQC17XcMhRTzzMyEyu+wLjLcLUnPyBNbb3H3+NlwtzC7KNX w==;
X-CSE-ConnectionGUID: vnGWjYrLR/afcvPfXCQzDA==
X-CSE-MsgGUID: 91oA/wrrSyiRw8R6w3e1lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="50986889"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="50986889"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 20:55:20 -0700
X-CSE-ConnectionGUID: Q0miegrUTSSQutr/TzJ8KA==
X-CSE-MsgGUID: JTtn2njzTTec+k2ofw929w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145665398"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 20:55:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 20:55:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 20:55:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 20:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO9omLV4NmoP8AOfHy6Bww6/NEP7AYHYe9y6nj+rQLnbo6H3X0E3AJfJenLj8VWet0UguBbjZ6H6EY+ymLP0dOCtW4adESCF3jFHtjYDOGfAGT2Qf779GAmxgPU+pnDu1ioFh/VdyPdPHFOdnetFvh/phkTo5ZHtz/txVtwDbuFlOCZ/hcxU33L8QWGzxBzD6wIL33DuG4RX1dC7BZTY50ZENf2/WeZV4zfHAF03QUUqpASqnY+IRoJC1jbmbGWVtjFPWq5SM0FE2nhmEUKkek8FPU9yWk3m3smHuo2Vmb5ogIU0wzDVSX0H6UXIfqcXrhF18Gu3BYlggKotJN+2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/kZPCejNjQy3irgZZwO+dFrfh13idTsNGpdjkqFA8=;
 b=ZzFaQjwLXZZW+y+eW2Vbyll+/uwCojZ9+dJNP2H5PVVk1igt7tgtLFfE/GMdEmpg/spu1dx1YpXw8Z/ptIhTqrn/SjYr40EG1gOgF2IMKZKae7G+3WT28TnSb7hCqPbBScNdFLkEqAc3eyxNVYTS/0YGQiVpHg5fsaRcA6Zad1ijJMXSbmvPetDXne3lxE/nAzwybAj65ks5d2jGUsQdKg1S5DaHuLjka+ugDE7S4wmlsTnN1EOOUADK6ws+pzst+8HQ1o8M3/bbEbKa3bHoSXl/HApvQcwvh/5GBR3sL47duvA26HU0sGlUt+ZpZQALDtLq/qEVe9yoeF0eG86WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB7149.namprd11.prod.outlook.com (2603:10b6:303:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 03:55:10 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 03:55:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Topic: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Index: AQHb0M9ffeBve8sbTkmcsVPSqsxgBbPxRJcggAA8BYCAAOO3kA==
Date: Wed, 4 Jun 2025 03:55:10 +0000
Message-ID: <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
In-Reply-To: <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB7149:EE_
x-ms-office365-filtering-correlation-id: 6a9d7e04-6cdb-4ca0-3052-08dda31b9a2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWJvUnNWay9PNXZTR3Z3SEZmbSs0Y24wUEtpK2xxLzFkUE44dGdUSUd3a3Nk?=
 =?utf-8?B?czhLWnh3T2paYml1QmNpRlB0dFFCU1BiWklDUjlWSHBYcHkvSkIyaVNsa082?=
 =?utf-8?B?VHVIb2FhQ1lUSUpnMng2OStwL2xWb0dtY3YvY0N3TytybGtLMnIxVkpMM2t4?=
 =?utf-8?B?MjJWTHh6WGxGQmRFT1BsR2pqMVVndUNISk9oalhEcTNwdDhIYk5qMnlJQ2cz?=
 =?utf-8?B?M3BTYmZHRW1waXVQektON1Y5UzJROG9CeGswR0lrTmF5NUdhRTMzdVRIRmZ3?=
 =?utf-8?B?UndzYWpBTFkva29MdEo1U1VobXpIeUt4ZTBaakN5dHpTRjdRY1JHWjcyUFpD?=
 =?utf-8?B?dlpna21GK1h1dmF4bmRSNWtkbkJRRVZIR0VMQzhSODZMNmorZE93OEhwUjZz?=
 =?utf-8?B?VW9NV25XQkhFeWYvWW5oYzVoWVpqL0xFejVtYXRzbFliendHeFNvSEpKUkRY?=
 =?utf-8?B?VVpaYXNxSDVCZjkyMzk5SGdydE01cHdQK3dwZjhhNHREa3FzSE5XZnVRZis1?=
 =?utf-8?B?S3ZCeW9PN2JTYjhUTkI5VUsxRnJXVEVMVExTckJnSStFNTVuZUFBQW1nV2NR?=
 =?utf-8?B?b3NoS2dLTU9rRWVBUThBVTZWZDRsMDBEMmJkTU44YlBtZFVwaHNHSFZ0N0hp?=
 =?utf-8?B?UU8wU1pLZnpMT01iSWZxQnFvWFJIM2czd0NoOUFkek5uTEU0LzJoaGdYYjJH?=
 =?utf-8?B?YmE3Yno0b0FXQ2U5M3NENEg5UDNqbFpBU0F5K1lKaGhQZC9vcVhIUlp2d3Bn?=
 =?utf-8?B?b0ZwWjZkTWozTUhPbkQrdlhSc1dIMllhT215cENEdEtiMzNLdzY3bVpXMlRy?=
 =?utf-8?B?eGFsNFhJYWFlVnFVQ01QNUhRdURrT2FRRVI5NXp0Mjlkc2syUVFHem5IWGVL?=
 =?utf-8?B?NDdkemdtdHNObXZjY28rOHZJNlhDZ1Jwb0N4ZGRRTWRjK0JmQ3pwU3JlM09J?=
 =?utf-8?B?QjBvZXBRc1JDeTkyQm1HWnAwNWJJeVZJbW5jaXVNRTVpTndVbFcwa1dlNE14?=
 =?utf-8?B?QW5KWSt4ZVBEbUtpOEtTc1pleVdnclVBQzFsNVdtZGR1RDNDNXpGTWszdWJY?=
 =?utf-8?B?OU5QRHR5ek5mOUN1WjdMcG1IdEFNWGRmbExTVVV3S05lZGsyUEo2NjhmTlNs?=
 =?utf-8?B?WG9YZmpqeGxqOGFxaElXc2xSa2MxQmZkQ29mMzBSRDFSSXZOUlF5Z3FzMmxi?=
 =?utf-8?B?dDZFM1RKWENVK0I2UXB1Z3packNrQ254YUJ3a3BGM0ZhY3o5M2VHU29Wc3F5?=
 =?utf-8?B?SllJdGx3MEtmVDlDaW4wa3BzVWtEek9qMk5Jb2JnWGN5SEtEZklrcEJlS2Rs?=
 =?utf-8?B?TGQvTFUxUFVheVM0TEZyTUk0dE43TlRQUUYxSHMyS0VjaFVPWDM2ZitxcWxQ?=
 =?utf-8?B?OXJDSEl4a1QySlNzZC82NDJDWmkyOStDUUh5Zjl3SXpJM0xxejdIeEpzbms4?=
 =?utf-8?B?amZwM1VFVk5KR3NjWnQxcVA1RGtKanpIdC9QQTBlbUhEMmhFQU1idWlhVUxo?=
 =?utf-8?B?S2RsOE52a3dKSWpaemkyakorVVJNQnR2K0I2eHRqdHFramVxbFRZNFBjMFJl?=
 =?utf-8?B?aHJxbWdiNE45a1ZqcWcweTZROXc2Tkg3NkV5NTdRSWhKclEySUVDbE9uRUJL?=
 =?utf-8?B?c3hzbk81bFVDcEdZTnY0TUlLZ3JMeEErbzRwRnpVcHZ5bXM0dTFWMUdKWWs1?=
 =?utf-8?B?WURoNXR6MmM2VUlnNnpicmd4SEd5U0ptWkRPWkpMVGNaUi9XL3ZzdS9MeUx4?=
 =?utf-8?B?aE5yZ0NMZ2toOS9hSWpVMys2YVRDMnRFWHBoY0pZSk9uTDhlKzdhWE1OSWZX?=
 =?utf-8?B?bHdITGRWV0dUVkNmdGNjZXQvN01ZTCtDSy9pbEtFemI0TktHMGlWWTc5MmJr?=
 =?utf-8?B?cnNNMWVQZDZ0bFhWSE5yTVVweU1wQ0J5cThzeko5RlJNQWZYV21XOFBFcUhR?=
 =?utf-8?B?R3J4Sk5mSUtNcytaem0ybGpJVjBTT3lKdTBWaFZvRUg0QTJ1U1FiSm9Ncmcy?=
 =?utf-8?Q?9diD5q4bzBHhGMO+4IUb5u3bt42nWc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFRcFV6L1pjbzcxa05QMXZNNWZvV2h1bTlTSHNUdnRNamN0d3dveHdHNkFQ?=
 =?utf-8?B?ZnJqSklHakpKd0R0ZmJhTENZVzBuUlFCM2NaS21lZTFYNEpIWE1VeGlWdDBG?=
 =?utf-8?B?L01laU1nS0c5aUNmQnhJOHhwa2VmUHdGYWhVY3pOckE2eXBTOU9ON3dYTHNh?=
 =?utf-8?B?L2dPRDNzNE0yN3hickFkcnhkRXdxY09Rd1BHdkhNR3RYVkFzdzJrTVNjTWJm?=
 =?utf-8?B?OWtWSkpMRVRjRjR0aGZJNnV3UWpoQWJ5WXpZdHI2UDNVSGlaelJLcjZXbVRL?=
 =?utf-8?B?UmoyMUZ5dWtocEJ5MzZDV3ViQzY3b0lMWVFuRFNVek0yaS9lT1Jhb3RWcGpJ?=
 =?utf-8?B?RTNaWEFrSmxPc1lvSlpKMnl1ZVV2L2ZJWjhtQWplcWJsN0xHb2k0VXNubmUy?=
 =?utf-8?B?T3dhS0tvYm1GV3JoTGhOS1ViWXVYRlVwTnJDOGZqOWZScTd4aUxDakEvWUZ1?=
 =?utf-8?B?ZFlnQUlJSi80RkUxVUEyb2ZqczJCa2RWdGk3MkFXSkNyUFNKc1RnUGQ0cHRY?=
 =?utf-8?B?ejVBZ0Ixckx2ZDZsL3JEaUtzNG9KVE9lRjdScG12UGUyY05BMy80dDg5Sm5j?=
 =?utf-8?B?UXBiVTdDV3hvODNscGJwcGV2ZEN0Q2d2VC9RQjhLUkZ1RjQ2NThYNUtIaVdR?=
 =?utf-8?B?Mkc2MGVWTXIyUnB6VVNyZTdlV0NiUUk3U2ZvamM0TGlhbkp6UGprWVhZb0hH?=
 =?utf-8?B?eVMvaE9MS3MxV3psdG4vbGw0bStpbG9CRzdmZlNBSHBPWlpkSlh6ZXllWEM5?=
 =?utf-8?B?OEJpNVZKTHBXK3VrTHBvWlFYY1F5enVjYUI5YUxkVW5pcEtrR0dXU1V3R3pl?=
 =?utf-8?B?Qnk0OGlrUXV6akVXWDBkbEhPdHQ4eld3WjNvMURsNnoyTG1NNGhqbkhKTDIr?=
 =?utf-8?B?THljVnA0dnBwN05BcjNQbjRBMnZTcG9NcUxGOFd0eVhHMXMrZ2xiczRlUEJ5?=
 =?utf-8?B?Rkd6UzB6QUI3ajBnbUpneVc0KzhvditaMXJMZkZhK0RkNUorc3VqYTNMUW8x?=
 =?utf-8?B?bjNIeFpvZEJSSEZLbmdVSTBDR2RTOVVFVlJLbnpidVg0TUIrRWF6VWFFamFE?=
 =?utf-8?B?YldyTmNyRVFBMnIxbFNzVHQ5RC9QaFkxMzFuRE4vZ0Q4aDk2cVhHMk00Q3BT?=
 =?utf-8?B?VG9XcVhwZEl4VEhwWjExN2JTTjdLMFBuSENMcTgvcEY0dGcxaEhnY2RJS3Jp?=
 =?utf-8?B?NFdDa040SWltVjRDcTgraEdubHhHY09FSExkS2dudW5OcXZPQXIrL0ZNQmZq?=
 =?utf-8?B?aHBYVUxhQ3NWeGNWQURiNSs0OERrenBwbTVyZFNZTFFIVk1ZY0JIK2VlSTgy?=
 =?utf-8?B?TmlZZ2dTS0FsZWwwd2FNWUsweWhOK0ZveTNmOTMrSHNNbzFpcTRDWHRDbk83?=
 =?utf-8?B?cDZYSXc2MFd0dlg3ZHBHaGFXbnVkMGU0VlcrdTQrVjVMQlV1MjIrNWc3YW1S?=
 =?utf-8?B?aEZ5N2tvV1g4cVpqUHBreVdHRWNYZ3diTFlxWElWZU1ETW5wZk5pdi9EZzh3?=
 =?utf-8?B?YmZJcE9TMjJSVUNBc3cweHdLaXIzcC9VamYrNDVoOXRSSkRyeEg4aWlRU1ox?=
 =?utf-8?B?VFg0Q3FhdVgrVE5qbExwcUZZamdqcUo0Sk5aYUFlU3licTVzWGEveTJia0p4?=
 =?utf-8?B?OE5PSDhRWDBhT1BvV0dpdDJWR3kxTFUwVjBpM2NjVE1PMHdWMGVudnFKWlh1?=
 =?utf-8?B?ci9oODIwQWJQOERhYXE3MTJzdGxKK2t5MzdOVTgyckNMUmVSQjU4TWN6OCty?=
 =?utf-8?B?eWVaYVBoeVlkUUFPaWYwSmVHL2RvQnU0bitBdWhNUjczRHAxVEZoWStOMTJ6?=
 =?utf-8?B?VVNMR2x4OUc2cktWUEtXM2Y1NFgxU2c2MjhBLzE0K3JTRGJya2NrNUp1bzRl?=
 =?utf-8?B?ZzhIeFJjbWI1azN4akJVUGhMY3psaGYxRm9VQnZ3T0Z6Qk84dWRLam9zSXpR?=
 =?utf-8?B?dDl2OGMvUTcrdE5Va0RIUzlqSFVOVVRic0dMb0FEQkNiV1AwSGpnRHFHT29x?=
 =?utf-8?B?TnBsRmRoVXF4VFBCWnVINU9UUUVkbDNHU0JYWGdXZ2p5MCs1WkUzZGtReVp6?=
 =?utf-8?B?dG1VUE9TY1RUcnFGc25xMlZPVnd5M2E0NElEZFNPUDB4WFlQT1IvVnVEQkYw?=
 =?utf-8?Q?3U4jAv+sHbSZM+bjeskm35Hd3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9d7e04-6cdb-4ca0-3052-08dda31b9a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 03:55:10.2381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OPJ7dk0D1yw5IpyEnQ36grV49Q0z+Yi/Ii7R1wEUUb8A/bdnDfa4q/yGmMWcC9G6fb88y+yeAB/0wCbVqP7b4AS4LWZ8xHkJVg+Qob5sw8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7149
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMDQvNDNd
IHZmaW8vcGNpOiB2ZmlvX3BjaV9wdXRfZGV2aWNlIG9uIGZhaWx1cmUNCj4NCj5PbiA2LzMvMjAy
NSA2OjQwIEFNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCBWNCAwNC80M10gdmZpby9wY2k6IHZmaW9fcGNpX3B1
dF9kZXZpY2Ugb24gZmFpbHVyZQ0KPj4+DQo+Pj4gSWYgdmZpb19yZWFsaXplIGZhaWxzIGFmdGVy
IHZmaW9fZGV2aWNlX2F0dGFjaCwgaXQgc2hvdWxkIGNhbGwNCj4+PiB2ZmlvX2RldmljZV9kZXRh
Y2ggZHVyaW5nIGVycm9yIHJlY292ZXJ5LiAgSWYgaXQgZmFpbHMgYWZ0ZXINCj4+PiB2ZmlvX2Rl
dmljZV9nZXRfbmFtZSwgaXQgc2hvdWxkIGZyZWUgdmJhc2VkZXYtPm5hbWUuICBJZiBpdCBmYWls
cw0KPj4+IGFmdGVyIHZmaW9fcGNpX2NvbmZpZ19zZXR1cCwgaXQgc2hvdWxkIGZyZWUgdmRldi0+
bXNpeC4NCj4+Pg0KPj4+IFRvIGZpeCBhbGwsIGNhbGwgdmZpb19wY2lfcHV0X2RldmljZSgpLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3Jh
Y2xlLmNvbT4NCj4+PiAtLS0NCj4+PiBody92ZmlvL3BjaS5jIHwgMSArDQo+Pj4gMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2ku
YyBiL2h3L3ZmaW8vcGNpLmMNCj4+PiBpbmRleCBhMWJmZGZlLi43ZDNiOWZmIDEwMDY0NA0KPj4+
IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+PiArKysgYi9ody92ZmlvL3BjaS5jDQo+Pj4gQEAgLTMy
OTYsNiArMzI5Niw3IEBAIG91dF90ZWFyZG93bjoNCj4+PiAgICAgIHZmaW9fYmFyc19leGl0KHZk
ZXYpOw0KPj4+IGVycm9yOg0KPj4+ICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCBWRklPX01TR19Q
UkVGSVgsIHZiYXNlZGV2LT5uYW1lKTsNCj4+PiArICAgIHZmaW9fcGNpX3B1dF9kZXZpY2UodmRl
dik7DQo+Pg0KPj4gRG91YmxlIGZyZWUsIHZmaW9fcGNpX3B1dF9kZXZpY2UoKSBpcyBhbHNvIGNh
bGxlZCBpbiB2ZmlvX2luc3RhbmNlX2ZpbmFsaXplKCkuDQo+DQo+SWYgdmZpb19yZWFsaXplIGZh
aWxzIHdpdGggYW4gZXJyb3IsIHZmaW9faW5zdGFuY2VfZmluYWxpemUgaXMgbm90IGNhbGxlZC4N
Cj5JIHRlc3RlZCB0aGF0Lg0KDQpIYXZlIHlvdSB0cmllZCB3aXRoIGhvdCBwbHVnZ2VkIGRldmlj
ZT8NCg0KPg0KPj4gRWFybHkgZnJlZSBvZiB2ZGV2LT52YmFzZWRldi5uYW1lIHdpbGwgYWxzbyBi
cmVhayBzb21ldGhpbmcsIGUuZy4sDQo+dHJhY2VfdmZpb19yZWdpb25fZmluYWxpemUocmVnaW9u
LT52YmFzZWRldi0+bmFtZSwgcmVnaW9uLT5ucik7DQo+DQo+QWxsIHVud2luZGluZyBhbmQgY2Fs
bGluZyBmdW5jdGlvbnMgdGhhdCBtaWdodCB1c2UgdGhlIG5hbWUgaXMgZG9uZSBpbiB0aGUNCj52
ZmlvX3JlYWxpemUNCj5mYWlsdXJlIHBhdGgsIGFuZCB0aGUgdmVyeSBsYXN0IG9wZXJhdGlvbiBp
cyB2ZmlvX3BjaV9wdXRfZGV2aWNlLCBhbmQgdGhlIGxhc3QNCj5vcGVyYXRpb24NCj5vZiB0aGF0
IGZ1bmN0aW9uIGlzIGZyZWVpbmcgdGhlIG5hbWUgc3RyaW5nLg0KPg0KPi0gU3RldmUNCj4NCj4+
PiBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNlX2ZpbmFsaXplKE9iamVjdCAqb2JqKQ0KPj4+IC0t
DQo+Pj4gMS44LjMuMQ0KPj4NCg0K

