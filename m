Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B83CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 03:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v73zR-0006vB-Rn; Thu, 09 Oct 2025 23:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v73zL-0006ul-Af
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:40:16 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v73zC-0004uC-5O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 23:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760067606; x=1791603606;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HQAsbuvg9VmAao25pFkoypfyAFRGy7LDKKPMnu7OGIg=;
 b=h7yjjrrfRHNv6kHXxq4LlQFTPknpRf+6tsCpGhf6ixE2tgX4yVsncvFn
 ThkAksUmlxygsOPfke8TXcQywRjGnuorZDwHWNNH8f/gvcN1rPAcASSvg
 GQ2jO9xGN+pqbK0zm6lOz+vGzGriLl+1QEqH/2V3HwHjYe15IliPbxO5T
 9p4GeTEkouTf6BpyOkslLb3AIMWNjpF7qANsmaHGUJo1jia6JL0AbTVGW
 4dcxSHQ8rug1HJWXOE+Hp3z6hFZhyB3a3CBwNh2r0Ow8fBhj2kmH6VBjv
 SzZVALh9bfMKgiU2oDbrO1seoeCz8yPUgWKr61GuvDDbFhwBbI5a3Uhzr w==;
X-CSE-ConnectionGUID: 3AYi40HvTGOY2qxcmVwKYw==
X-CSE-MsgGUID: kYpoxOh9QPy1/Qmnx76Jog==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72900547"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="72900547"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:39:55 -0700
X-CSE-ConnectionGUID: DOqN+rOBR8aClsuRT+3+Sg==
X-CSE-MsgGUID: YZlEQPW2TzaMdOKzRb56pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; d="scan'208";a="186136878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 20:39:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:39:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 20:39:53 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 20:39:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf+T4I3DraYG32AiNfjcesMwQc3yxgehYrGTYcq8tgEo3odrYJ9V/Dbqu/6NVCWjBuObqpZUZ7tWb92QYVMNbXrD0ETonD9UFiXuL81zoTfMxe3eKBxBWJdelq3BeM+YbveIuoxNSquWSAmbFCGVBX1bEi7nwoMvsbF74pQC0SkJjkKP4EBxG8Fh0Dk6VwD8ZrL4Bg3UyOC9pxeXfKPv0WrGnnvlbcFwBcTBg45H9b5msmqC9TB5lWLnBGelvOM08tH2Kvpxxc6rOzumretgJcfz+2LMYB4HPeMmtJD6UjQ05mT3+02c2b3gnE0vV2U8iXvrR2pJsj9q1b0XHYL1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz2p40zrKZirw9z1KC8w/yj6ksIN545MN65NEO/CumI=;
 b=VoRAlZi+IT8wL1GRHYL9mn3PhiP1l3lT1aa3yQwJcGeSN6l+GRyrGzVN7Fvi6cfR3OKMsj2y7ylG1aDfbMc8wqZAlibF2DbhnTAzKjFA6IzH6nrbCJRl48agMQ8zVRkWycmg/LTpWZjn57KurgB1XUzVq2v0XsAaep2Xl71xXJ/Wo6BrskCATbAXbaoO+oB/m2jE2cPM6x6uzScBx2J2zB08RYgNwzKczwxV/zEljA9d5QtclAVsjF9W+grlSXwWLVHy0INjPA354OncIKQgRsWdlxU0VKxgY0j84lzN9UFtGdldMPXI9D7NfohvIEOqEtnAETSA+/f/5nwHWVHbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 03:39:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 10 Oct 2025
 03:39:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Topic: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Thread-Index: AQHcMFWngtFRdKHVOkWcXMje/gJxi7SqMJYAgADkn4CAAJxjAIAHrvKAgAaL8oCAAOC1QA==
Date: Fri, 10 Oct 2025 03:39:44 +0000
Message-ID: <IA3PR11MB913681216249C2C6EDD7F86F92EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
 <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
In-Reply-To: <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7670:EE_
x-ms-office365-filtering-correlation-id: e32893ba-232e-4992-58ea-08de07aea768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?S8xivm2tVFxkdrxJPaKk+FvBIOrNV3Z1uov/QXlDGsKAyQuqhhhiAG5VOcz8?=
 =?us-ascii?Q?1UQxN4XZfVhZraswAUMPkChLcbUcdgf2LG6cKMOfM2aDdJBm+h5U5wdCX0Vb?=
 =?us-ascii?Q?2wTTE8WihCYwX31z4/qzxVjWWd97CEtvUfDp+TxICNI8F7hzgNNT+idGqClg?=
 =?us-ascii?Q?Qb9f+YlQg2WzAGS/FOUWtzdm6mr/+B0NSYpBdm60h5VXSHcWFtRk2XKnrkJb?=
 =?us-ascii?Q?GGrCprln9EmdJVRN9vQSenmwiHtacsC7lOufciStSwhG8rCkG7wd6HkcuN0x?=
 =?us-ascii?Q?K/O4drD8ij5B9NfNPh+Bn52JRKJVR7qq/RSBdMkVNywk1FYlBFxqmslgM6n1?=
 =?us-ascii?Q?o/WfVGecIXqokGAwMNCAQwbotzoQGJblQrGluhe6BdQTe/WmJFg7kn+dttNa?=
 =?us-ascii?Q?RzFqUfpGnxrA7Wb3dGohpdGXgkrcPnhs1CQoMoTDM5MQZghwf+47zuGV55Uq?=
 =?us-ascii?Q?X6GQd+95ITThPNkULTRbdFSQ0T7e4dTrPrBjmLgOj00aD5kFqJITFF/yfaSY?=
 =?us-ascii?Q?vum/n3ci6jOvl1B3RbabNV265COEgnbzhRKyU5G3djbOXcTVBxFxMmug9/ex?=
 =?us-ascii?Q?2XXU/FGg1ybF9dm2tdGsn5WsPwZHD7Ge067LZM5wX65aqOXJgebjGXO6272J?=
 =?us-ascii?Q?His7+kDrZJbQ9gSAibeD3ZzNO3Bv/MfS+o4isuYcAWv+fSdBth2t/frDzu35?=
 =?us-ascii?Q?sHkoJlbknHPni6Ffib1hdB2ew1RDLpAFHtLecksNPu9QVSvppRQzWTwTRTcJ?=
 =?us-ascii?Q?hErnfXVwLu+TT78yUfxqJU3M94XyHgCJm+wldbT87hh5PnUv5muWYfBNJOFx?=
 =?us-ascii?Q?8jKtzPNwnnDVxi8YYBiYD3AehgqAY2V8bhVxyYf7kzHMyZSjFSlQ5er6Fabr?=
 =?us-ascii?Q?CMjaVAIrKIoGk1ZFqEY+oaDlMr7sJgfCDQ6pQ30S/XH65PaDNyS/whEpSO91?=
 =?us-ascii?Q?V5PKxKGQy3l1JPsTw98Zv0OGsf5J1MMf+3bgtonxTMklGpq/oPoTSsN5r/6b?=
 =?us-ascii?Q?OxkqDxekjbE2/zXlG1/embzHazNFGfvtNDO1nFrT3PDOVNf/jq977e6iNR/F?=
 =?us-ascii?Q?AJnVT32O4Mf7bOAABoCnefzuQ0ku6h9UnSMKfKPpEe+sdZ5rQKhXxSlgEA9Y?=
 =?us-ascii?Q?dP/Xq3953apDYK6DOTVQE5gfr4+7ZmFd/gL7rfdgKPsMpBFrwD016SfXCIOh?=
 =?us-ascii?Q?dsIHPOmaCfZDke+alyrliBnZxMOhmwfu2rD7bkM1qHJXeW9/XGZetb6rJjqA?=
 =?us-ascii?Q?rrxku00/9nLjyM51i3elnKXfC9x6F0Yla1ZBn3YT1yAB7ZEhEa5BmNBRkV7i?=
 =?us-ascii?Q?nIRDpZ5aLh4NOeiJwwh9mJIKYp99gHUP+rWoyjarwn6F+U/aaxcNxatMY29F?=
 =?us-ascii?Q?/pcXpj6rnd06Y4XgrSMEw6paj3OtviVST8lUACL/myaASxo5gUJYXBUOBDhA?=
 =?us-ascii?Q?7BQVVTO0Eec02mApWd1zJLeSTdf1fwwo4KoA2qz0/0hHWIjJt7Or6i3oSdLT?=
 =?us-ascii?Q?oBxBaSB/wvWOaBVqkcWTzIys71EU8F0PYAcu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z1VqpbybnrQKb/jjBYj6H/MkzjJyWDTnasljphawIFcl/paqyr6sAj6UTJWe?=
 =?us-ascii?Q?BSaATGrWTOzCnkwgFCro+LIOdjfqOsE5lxkoXKXctZuNIHh34ZCumvEFrUAd?=
 =?us-ascii?Q?fVGBcIrIKcr5EXS9wqL/TBB/KsxEPx2nB4kK2eIPMzqA4dnP2hyCG91gXG0i?=
 =?us-ascii?Q?vqaChpJLM2fQuV42O6HbV9obXV/B3MNBBearoZldorsiEVLa7XGXy8ZF6PRR?=
 =?us-ascii?Q?Ufkpfzm54ukWDBh938ER3qGTxFzHhYl0/V3nChccUD76rZh+g8W2RbZ6D3vX?=
 =?us-ascii?Q?/WDRRSBM82fQCzfOtg9RbbbJXhvif7IC9Fr6U+4tHl6MOgNB1dFzftIbXFWn?=
 =?us-ascii?Q?KYY0XvhwwSFc5HMAmD5zkDC66qD/koz4IpJewIfUF6ro6CtNp6TKtG0sDLDs?=
 =?us-ascii?Q?EES/LWdEZ50EsF+lWheDqMmWCNXgYG5Gv1Zfc2lat8nkLkg2oxpJjnGMBvR9?=
 =?us-ascii?Q?gq3BEruRiRvBE/f8yFK7CP6YpewryEAtV/UGqvV3dXYd8nM0brSl6x3tWvOQ?=
 =?us-ascii?Q?mGabS5jrhvmDfdOoEyowaXXHANd4UqlaXnVLjL84egoZU91IZ40Ph56BFD4n?=
 =?us-ascii?Q?qScEJA+gqLruX0JvHkvWXeqZHDqsgPXe0xHIKZbA4dhwU9zezwqm9VzhROfJ?=
 =?us-ascii?Q?jODMG+vbu1bIRY4pGIbQg7VziDLbMvbgq2GnvMehPeB19R4CEXykb+g1GhEz?=
 =?us-ascii?Q?wO4pkdz27ioRxF/13xmtLN8rVK/MJMKOWot72bUdwiJoWlOdne/h4qR2FRNn?=
 =?us-ascii?Q?RGLn+ORTwUj/bkg3NvuD87dAgKxESgRaFNgA4HllpR9N5GUTP8xll3aIV6Se?=
 =?us-ascii?Q?LindNgnu4oBIl0NiQuElMmFSl5cC+CjoMWLfVTp0sO5PDeONXimyqAzc/UIX?=
 =?us-ascii?Q?ErI3KAMaZCRQxxqyXQzXJ4i7biYGVTmE/YSglNC4RDK7bTEw40qEXqbn9zVl?=
 =?us-ascii?Q?r8neAmLMVJN4fwnvJTiBY+wl8bUhozvT5OwsHmzxi0FiVHZrOzuUdm4HXN7D?=
 =?us-ascii?Q?r1nS/ZvcRY2G7EfH67wHeGsjECgttZ8y8bob/34WnWSE9HbO5VfVaXXazhTY?=
 =?us-ascii?Q?Fd2OF0SetEt3Pvj8S1OvZB1pOVXan33yHFTHToGPIo9QQheWR6y+3QxKvvKN?=
 =?us-ascii?Q?NU59PrRiwZhAPIdrSWfL7qce4acAk1ZZBwKzAXiAAwPaP+Dg4PsPua/tOASQ?=
 =?us-ascii?Q?1ZcTELbHg7g3fTQNUc4mekmsia5F89RQzAqv5DkOciJn982nRLfmHerEr8XP?=
 =?us-ascii?Q?MzlbzN8OYKdck94ZyFpPLoVrG76p1dbcFIiZ2H6Yi3u2apK1YPklt/N25HlW?=
 =?us-ascii?Q?seqA9X6o9wWHsca27rNLCK+BFGPqCoGaNB0qfApzKRb4sn0/BSQ+wqryB4vg?=
 =?us-ascii?Q?BXk7mZVmMUUJ4dM9i6srLNKTh/RM7V7QVxj7wigc5yqT+St9Ayd7aZXVfY2z?=
 =?us-ascii?Q?iNx+4ytAfTlnkUoV5zNt+dpBJfGxwTA1cIdpHBJiZkMtTvqoo7blTVfm9r73?=
 =?us-ascii?Q?BtB9fxbzyvrCuA9tDZNKcS5lBST1L5tlJpBis/ISpUMaZ66rfS/FjU6ofvLh?=
 =?us-ascii?Q?NFKsuquRK/HQKjA875wBMYRQCLoWlnUBZ7FG8yS2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32893ba-232e-4992-58ea-08de07aea768
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 03:39:44.6966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5oehQe7K9J1gSOwNQE2XW2qHjfdXWx8BLPY1ACSZ8kWiLoDHXDV7MutwH7qgy2qbHOKKu8xWL/p1HA7XZxy+fHq5sTDCMdj9YK/euiqO/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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



>-----Original Message-----
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>"query-balloon" after CPR transfer
>
>On 10/8/2025 6:22 AM, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>> "query-balloon" after CPR transfer
>>>
>>> On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
>>>>> "query-balloon" after CPR transfer
>>>>>
>>>>> On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
>>>>>> After CPR transfer, source QEMU closes kvm fd and sets kvm_state to
>>>>> NULL,
>>>>>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>>> pointer
>>>>>> reference.
>>>>>>
>>>>>> We don't need to NULL kvm_state as all states in kvm_state aren't
>>> released
>>>>>> actually. Just closing kvm fd is enough so we could still query stat=
es
>>>>>> through "query_*" qmp command.
>>>>>
>>>>> IMO this does not make sense.  Much of the state in kvm_state was
>>> derived
>>>> >from ioctl's on the descriptors, and closing them invalidates it.  As=
king
>>>>> historical questions about what used to be makes no sense.
>>>>
>>>> You also have your valid point.
>>>>
>>>>>
>>>>> Clearing kvm_state and setting kvm_allowed=3Dfalse would be a safer f=
ix.
>>>
>>> Setting kvm_allowed=3Dfalse causes kvm_enabled() to return false which
>should
>>> prevent kvm_state from being dereferenced anywhere:
>>>
>>>      #define kvm_enabled()           (kvm_allowed)
>>>
>>>    Eg for the balloon:
>>>
>>>      static bool have_balloon(Error **errp)
>>>      {
>>>          if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>
>> OK, will do, clearing kvm_allowed is a good idea.
>>
>> Currently there are two qmp commands "query-balloon" and
>"query-cpu-definitions"
>> causing SIGSEGV after CPR-transfer, clearing kvm_allowed helps for both.
>> But clearing both kvm_allowed and kvm_state cause SIGSEGV on
>"query-cpu-definitions".
>>
>> I'll send a patch to clearing only kvm_allowed if you are fine with it.
>
>I still don't love the idea.  kvm_state is no longer valid.

OK, what about another idea to not call vfio_cpr_kvm_close_notifier() for c=
pr-transfer, like below:

--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -197,7 +197,7 @@ void vfio_cpr_add_kvm_notifier(void)
     if (!kvm_close_notifier.notify) {
         migration_add_notifier_modes(&kvm_close_notifier,
                                      vfio_cpr_kvm_close_notifier,
-                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_E=
XEC,
+                                     MIG_MODE_CPR_EXEC,
                                      -1);
     }
 }

The close_kvm_after_cpr is only for cpr-exec, with this change, we are in s=
ame situation as live migration and can run all qmp commands same as after =
live migration.

>
>It sounds like "query-cpu-definitions" is missing a check for kvm_enabled(=
).

Yes.

Thanks
Zhenzhong

