Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF34C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeRF-0000xP-KG; Mon, 23 Jun 2025 06:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeRA-0000wu-RC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:30:06 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeR7-0001ES-HN
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674602; x=1782210602;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eL9ZhjTEWU0NpT2C7sdtQUtFwiMKa9AVVZPJPWOvQJ0=;
 b=gBvxEKFkKtQvd/ijQDM9k0E2hPMO3kTMSxymzu7kZA8T6ecHs9D4QQeu
 iwmBohEZsPrMzP5Hy7LA4eVqTwOxbiSnaNPOA7W/G5YXOslaQORhhec/p
 M0meYRke8vQDRdwLONVV9Vi7UyBtnEXdKe22EVrlDQdNdd2y0xVB2vco1
 Yx5ipvpUlxjSVyImTz7c9XgYglt2Ftm14Myo+ToJCbW2MOPquWwOrxzOk
 IZ8rfydo0sJTCj5BZDFYPD+ThgrpXHbyGXufXQJRW3V1t3tqgc0K4x5C1
 T5vYSFS8g41KpBOLcPCK9p2/cMXfOF4eRs4a8B+5uqv5lkHJRZwT15gOn A==;
X-CSE-ConnectionGUID: 7ImuuvX8RL2Ko4HfWcUDng==
X-CSE-MsgGUID: BYNixaBgSGWJ+b5OwaZF/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="70300327"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="70300327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:29:59 -0700
X-CSE-ConnectionGUID: yaIZFCGAQ7iWaEliVm4LlQ==
X-CSE-MsgGUID: lLnKIFDCTAOlS06TudPkGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="152078166"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:29:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:29:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 03:29:58 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:29:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fuk1VKO1Uxy1LHDXhFhnmHi6vpE1o5126ERQz75iCccoCc017I8WrmbxkJoggpzMPv01xKHnlTmOl86GLn81QScn7owvTjTngWxOasrHrQn1lucWMxGT6s1ZezMVTFdt6D/ke/xsb81EWXlVwi7lL+9xiPgs6U0+ZHOBhqJKOvhBWrLZNw/BaZtvXmgS5FTXtxT6gHs6VEn+iRk8EnZj4kAatX1S3StE1is6qocupL2NWxEL4UvYUDU1bQEqUsTzKMqUUxqLYUqh7ASmmA89Vr1wTHjPWGwa8UU3RRmefPV4y/qFlDd8yRJj8kkklv9JaYD8tufQzxt2zbaD40IVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL9ZhjTEWU0NpT2C7sdtQUtFwiMKa9AVVZPJPWOvQJ0=;
 b=frmqY15zZSozkyndfVShHI8ViG3eC341n+qEJkVdOc2hiJHmJPPXRUIxrlehWDTWwn2MkdjJCeFYG5Vti1eeO1rFoYBmeBubZdaOMB81nUKGK2IsvJXn4kJN763+CxzLlg7PII+5ahXZiKzBJpVOLHen29CIiTJNYjzwctScWHB/Jya8vLbvKFscyhWYvpj0WDzyZv3NoT6GF2vcscdq0okqKhnVJ3FS5Gj8i/j6+jW120GjTHTV5chMc7LHqy7BznbZlO7bKOfuXjGIkhbuSklRmMXP6Vg6KdF8T7vZ1FTPa2/BwOLrOn4JqLUVm6XgweFwW/cQxp7X2cBT0u8PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 10:29:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 10:29:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 28/38] vfio/iommufd: device name blocker
Thread-Topic: [PATCH V5 28/38] vfio/iommufd: device name blocker
Thread-Index: AQHb2h4JCdJBWMtX6E64cE2TcsE137QQnyhw
Date: Mon, 23 Jun 2025 10:29:42 +0000
Message-ID: <IA3PR11MB91368951FE11380ACE0D6F849279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-29-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-29-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: dea3c9a0-308d-4137-1ff1-08ddb240ddcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?o4aV9PrfdXcT28yI+nlLAB2pqkaNn/4KjdRYeyCwBQknluUBfcAV+oeUUQi3?=
 =?us-ascii?Q?+OFjl0X/DDKOoLalvokkpQ9c8pjgO4IVyQnwZDf9u93RHKU9leJXsP9usaSj?=
 =?us-ascii?Q?UE0Q3o/afCcOpl28cOa9l0CHVfHJV+0kG9fD/PJSFOMsOsG9Bb5CkJVtyOO3?=
 =?us-ascii?Q?6YOyEhUinjOsD/263OUfphkDZA+zcBeaPbkNj0lR5YzDWuICudJMfj8zk28Y?=
 =?us-ascii?Q?VSaGMfpPxqK3xaOqHLDeK78nqFDB4U5BV+GicC8JIGdFXtOV9SNX6mhWEpHu?=
 =?us-ascii?Q?L2UQKVBiQns34TTNIwcl1rpGQSBuKi7oguEknB5in4b1QPBA44PubW14PPze?=
 =?us-ascii?Q?qfOXJNAy5ujtEgBhCgX31W3s/bMWrA0n60kZ1YL0nDOyg4fKvhe23EHLW84s?=
 =?us-ascii?Q?+ms+AWk79V+0Btp0AgSk45/K7/gCRkHk6Jt9dHIEgQnYpKDj2EBL4i8J7/zD?=
 =?us-ascii?Q?B1FB7iS/OQ0gavNEW3JqW3Hwuigv0OoFp0vRxsK0QtODT70B5asQf/2s8GRw?=
 =?us-ascii?Q?sh5vggB89JFkAwAwc/eBBpZzgXhP/OyZ0XmaMjHlirZDpkYyCkYYLGvLSH6D?=
 =?us-ascii?Q?kUV6fPT2fQZQadl0xWBBhUbW2tiZ6zn3u2JzoPug6VGtjilJa+khvCfH+6sy?=
 =?us-ascii?Q?V+2drqmVMT6E/YJzznmyGJ2okM0B+aH7cSZCaQg37WofUOEdeOQvgc8TSCaa?=
 =?us-ascii?Q?RoWrNpKHHKX6IG+apuDGEaJBXYCzi25CxFpBgT35pqK5a6NEOdZiGqQG78sy?=
 =?us-ascii?Q?6Z3xkZdlC4Y0/tTheCNKyGlMUr+5pWLmufHATbP9YJdaminKQowbBB89qupD?=
 =?us-ascii?Q?JL3gaCGof0UDtL78696hnZ41AlPAOkPQbFPAK8NJgDACUETzFoD8LH7OBCUT?=
 =?us-ascii?Q?iUQG3zwAfBHvlFg+D9HfzQcCbcYrH+YYrlELRAQfw1sWbDJN1En+atDDa26G?=
 =?us-ascii?Q?1dbc4BEndpiiNVLXVbLglpA6U/VFnvqugYjYfAcB9Sb3dmqYCnJ5Wxg0CCqD?=
 =?us-ascii?Q?GS4zILsT/M4cqxWu7kJJix8ogZdZw4R2EbVDaH/WdSGLUi/2oEnoxvcdhW8b?=
 =?us-ascii?Q?5xsdZjQ/H9pMT9sjATI9xhHoMou8ZdgCLK4gH5LipFmpu7eGj2Asn9EMmsLb?=
 =?us-ascii?Q?3d07jtJYHDnOsCK2h4s7nsmgvQEeOxwm1aD6DEQ1eyyJ05Ri8o8c6yXbk8rj?=
 =?us-ascii?Q?dFzGf9tCVo7+wb4OHd6bGM7uTopQKXlfiK2CAu48GuiIyNi7Bd2ysnttzElD?=
 =?us-ascii?Q?jadbt6g+2XVeWw7Pvq9pYG7VrSpYoleNiltX6FqbyyeDBL/yhigiZxZviMiE?=
 =?us-ascii?Q?ieoFGiPtPHM2qvoR+3HjZwqc/BY1rTQfTVMEV4zKDUxrSN996esVDjQOlUU9?=
 =?us-ascii?Q?+NYK0vvFyjpgsTfleVJbvkRkzFOg27CmGagTVaP2zIKWF0/rlOG7P8C+cncJ?=
 =?us-ascii?Q?R69E+XqRxO0M3yrpcFRUURhxZHgQeefr8mNqBguRRe8MyaTPvbjPu3O0mfqO?=
 =?us-ascii?Q?dDFCO/F6Tyvf3nU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qN/F1I3IeFKgS0X0FPCr3c4Ntd+wqvxfFsoFXdJa8eV/JmsfgFTZM4uCXUow?=
 =?us-ascii?Q?DU1frudWCbf9zDkRLhFSF2tfU9sV+UhNJonPoC/v8s4JUtdCxTwRgoRVZmbG?=
 =?us-ascii?Q?7HnkZ6bWkas6KunsoIPfWBHRJQi0WYNg06nJ387dsVay9cXfiflcIc5gXOE5?=
 =?us-ascii?Q?nxavsY0sedCsfc0jWUuo4bT8kqFOUopJRcYsdoVLNHgqnrla+2XtZMUEZkAI?=
 =?us-ascii?Q?HuGNnN5mcoreL7PjTz/M01BPS8aR4x8F80wIfAJPyv00uGoVS4Fcygn41oTq?=
 =?us-ascii?Q?jLZV6ajLVHk4QAc9vQsNycZXmBduV/7A6DOcJCOXF1S64apfphIKSQIy63mG?=
 =?us-ascii?Q?sOp9TBif8WUzX9D5/gYZtcB8eRtKMBPf4C2jPOxQPhsRlK5LlebFv8BahztD?=
 =?us-ascii?Q?UOJ9DsSCSVCStb0vPp7pXNxKO6yVdNFJQzTwVU6ZwxTkMA0yFEh1OrxKYZ1Q?=
 =?us-ascii?Q?RgtnhGGPBeF/8baGNZc3jwnv18pHRa3yiIuVtlVlkOmCf73XHw+98ZASoWAy?=
 =?us-ascii?Q?2lVtGP5uBfqU3kRTIYPgbBQU6TZDnaSojG5O9mZu29FPrX2q1HLMTpS9pRMK?=
 =?us-ascii?Q?yPp50tzSt1JC/aITFqNHWM34ahemDQMS/VufBoFdfzrCviEbbsd7OZACFq8G?=
 =?us-ascii?Q?DMhnUrbOhpdjPuiKiMGgly2QaFsSaFPaxBh4Y/ooifpeIzIqDWuQkVpJoyyW?=
 =?us-ascii?Q?W1NkWulxwdijQKTAl7+iqbbUDrshEtZ+7ACW3II23mp755r2gVHEmYdpyvBl?=
 =?us-ascii?Q?3MawjrDYyqO9s50pNmjt6r2kES8mEGKkLJS1f2D06wWjt7DGSNfx6xbGbFDL?=
 =?us-ascii?Q?TqwgQdta+YrdDFTAezqbP1XvqXc8BK+DudFpruzyvn05GyQZd+vONX+jySG6?=
 =?us-ascii?Q?iJlYgSnpHieiglz3YMMUqDhuY4zwJtyMWmuSnQns35yAhE6paPzrk2F/rJLx?=
 =?us-ascii?Q?gV3sSV7ko/tf5JuIQ+bFQe5nSKwGuUHcdhbYsHIUYOSsZ66q40WRbdmHnHD8?=
 =?us-ascii?Q?ow7GGOdkxz7WDonts9TfvMugnLk7NYEdKa6wtN8OaK1m7mQURsIRIVa1c1VW?=
 =?us-ascii?Q?jLY3oFwtAWqU8NtVq8OupXimjCQ45OKD8p1sAOesqOzg+rDPqiY+l7Bnodxj?=
 =?us-ascii?Q?qmH2Dzfjh2cf3QdxM/SMtQjyfJXgljfrhbSlPRnMMezvtQDgkSg+I5rWL/Oi?=
 =?us-ascii?Q?Uu/ktCYO53PUlQSaL6x+rMsLrbsIl5X59uNl3tYs+qqpgdlCKDZxEbqNNRa/?=
 =?us-ascii?Q?aNIGDkzN1phAexNuzbNV3TErobHgJ3qaJY6BHHd5y4ufXBRdLjUCg/KB8xPV?=
 =?us-ascii?Q?Nfr2vHYQXmGkY6s2cEvMeSCw0EmqBaFynjXeJGelavWIMBdJ+TohXnW65Rnw?=
 =?us-ascii?Q?6yILSVQ63WLaEJ1GvWCiMgZNu6AkKX3ITSpPVXKDl0gW9+jAhTR3OIDa4tTs?=
 =?us-ascii?Q?RA+3pAdt48z/Lw2rGycuVSsYNLJbdMuzAaedF7q2zsf+Zii0K+ZlbNmO+47j?=
 =?us-ascii?Q?pCC+hYlS/aIYkgmYJHgwUhYXEWXfMbNkC9k17r7d+0HXj0b0PN654eSExMU0?=
 =?us-ascii?Q?o/Bv7DyRDkvBgZlFkW+LnRWln6GNYyFmWWJ+7kKrNu9czDWuPBALayVKXKS1?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea3c9a0-308d-4137-1ff1-08ddb240ddcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 10:29:42.4790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HOW4uHy4xex4dtmcWoX86iB+O/wHIr94FAOi8RybW0CiCNI+LluOY2NjwywniJ6U6J8sHZf58BZx8i+eb33emPvByTF56J5HKbIIBe87ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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



>-----Original Message-----
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 28/38] vfio/iommufd: device name blocker
>
>If an invariant device name cannot be created, block CPR.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

