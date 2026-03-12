Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A44103E304
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 02:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Vqn-0005zH-HI; Wed, 11 Mar 2026 22:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Vqj-0005z0-EA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:32:33 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w0Vqd-0000u9-US
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 22:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773282748; x=1804818748;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3ZZdBXJMuh5++8k6OC2NPxDU3t6SCTC38u84ht9K0zg=;
 b=NJxdh2MuoE8cQcWwgTrtyq4rfFeaNVkR52v/hQhTtbbAcIakTo6g8wfT
 mGT00OCTOV/j7HAVauWS1ghfR5zXomCGpAkHZMByoTcRrayznZaVTprdA
 2csWQaCSFJYXax7kyFzS3+NXKUoYkdLWj6WyWw+YhGQlP0/+DqmKQgTKo
 +NrOAALlDHgM7lb094iHtpHrl/6uaqN/KbmCpgfeO+UFIcnB/UMIdCVow
 iZjpkVGJcVljPE7r0AKm1DAJwZVOk0MwKZvz5MO3aNGctp8aMVO5iseaM
 TPpdy/Ir7Rk5d+yvQZ7vTBicYAF1jveazZPKOmq5hWl4+jjL4RXyurYAU Q==;
X-CSE-ConnectionGUID: /guSvpB+SICXAZW/7R3lFw==
X-CSE-MsgGUID: 3Nhz688QQ9aUuarVKs764g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74259434"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="74259434"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 19:32:23 -0700
X-CSE-ConnectionGUID: OxfHMPtdQxC+s/zYXqczgg==
X-CSE-MsgGUID: 0sH1zRqNSjCw/FZV8fgOoA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 19:32:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:32:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 19:32:21 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 19:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFAKb4sVXsAE5uPzR/kR+3HwI3SFPEdMYlgE1U7RPYnmchIVGnK9xwZmk5zpYmt5EOF/aW03wns3Ajjk2KVZheRYXaMKHLx1AB19lbPui5r9mY2mjvS5S2IrYvPHIwRv7agCIQdNbj+rDVFiPGLbdsRkgZiYc+2XYuFeNg8gXnKjyfdxIkdjOq6/+KcNQlUcw9qmNIgezDfSfPgbOPywOrcmvhID0YYrRQGNdcH9NRvr8YfIj4DHr6R0XqhSNp2RZSnE9L9ykZb5zlQCWtayviXMFWvWCPO2gMc26ZlBtmihuhhVLdWohn2TKseGe8gQDh/4LuAuzYFd2XdOxGLaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc12G/AQ+9fc40HAc4bjwkudyQVYJH6oUK6nCk5pRUk=;
 b=t5m6LSlQXeI7L5BP0iswJqxJkZtjm8+/cbPtGRK3BT3g24eWxDxzV5RncAX3gnrgJPhmr2qPQlyvULIsIftjWgym97KzBdrZD6efPDSAlXPrImnwBk4XMDjNLCjnIiScoCskXcqG9kfmPb/npuoWefsNct8tic1BKb42/J00M61gEx0ZsWrEmNBPEm4p8TQTG+kUY/1w16M5QOwHHNzga+qFGLzokhWNcsSMdVuWbbAYPoxPCK/aVvVexC9WtxfNgCMttreyd8RLh8QY4RITWdRwmLsVdjgU2tTQU7GbBDhM2l5skCEJIfBQRcINRTmPsP963tmaAc2zutpkMUpmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB8574.namprd11.prod.outlook.com (2603:10b6:806:3b1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 02:32:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:32:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Topic: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
Thread-Index: AQHcsFskubOEgFc8HEeHP9N2sSLBHrWqLM6w
Date: Thu, 12 Mar 2026 02:32:17 +0000
Message-ID: <IA3PR11MB9136EE8388C75D6E22427DBA9244A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB8574:EE_
x-ms-office365-filtering-correlation-id: 7866b46e-8c03-4ada-9816-08de7fdf9462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: gO7DuBa+m8Rn7Sjoue53Ye/MgSofqEvfDMb5PPvLoXlYlK5gDZEMsAbM5d0cP99mH/8l2AnbQH3bJqmOEA7ybkUE982I6OCuKE7vQ/UH3CpyL9oZS3LzZ5x75EO1p2UY3M8b8FgY90ztMQmhYQvXExCh7HuZEk5vchd4QOFRnV+P4VFhwjkdTx7Hka7BTJwn+D7aICFsLeBwKo3qJS5HOBoSzj+OO+T6q9zl2WtIst4Km97UWnQioEgktgd1nJ2QsWKCCiMgaDGj9lCQbdq8dAQVEUNb9V8L5EFfHJOdyBqKgGRdQmPcmeQJqOm+Gy1yfmmZyHF75MTtebDoJUz0sBNkAdtuHyqbX5aHEW19f0bRzKySq2ePD5+ppirgbKOvc3E8nv26RPkvvdbEd1t39icXXcTYJeHMuFBmW7IX8yS0qFKZQkoOiKKbZZTXog/ixMkSn233V92mM9gQiXFkxM/VD1VZdlnmwm0Wfve/pPuvw1t/KTwiOmtDJEdWxIzuBApNDfA8V++2rHRycOoQklNkSvXm3t52Txo+6VFJYxHyewplUe/RDJS0H/yO1B2Mr5p/VtNmxpoWxR+4+B8sURnZyxMxS245mIKYS8RhO2fBREU3dGOBtJhEW0NTz3nzEhGgJaXPq8GcpcQiOpS9zgt8By9CJ/sF+PzROKnyOj72YxwGAUCdfaZX6/p0nh//TVwMYRPcQMKpuhUk1z0u+vPC3Oztjv9Qk94Qnm0nDEJnWV8h8u6Gnon44/eRcmELUg5pAvB4KFCtClKfjvGEteAPPIOaR9h3duRb1tvSAuk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOnRgL5cNyHIIq2zVHbKXbYpJq0LqGpcP1gvSNwtK/596S0qvVgJjhmp4ZJH?=
 =?us-ascii?Q?xEBoC0pQ0g/pGpOgXxPUPf+eRh/V8Z3yTG6jO3Z+agbvVAjStADJcwJzi2tM?=
 =?us-ascii?Q?MCz0B+Kmohf5caxCYPIYt6tbOjMiaSPnXdlwWvGA5cfwmp45ii6fN4INu9GZ?=
 =?us-ascii?Q?oop2yMHQKekN6j/tAX/uii0HrbKCp0MTu5WG9j+tl0kmTOfe+ZWRczf4P9If?=
 =?us-ascii?Q?tGbxYl8kyK6v1ZTaFy+zGUoqZSIGhIWlySfREAy8q/d6frx3L/tzQ2rnlNTe?=
 =?us-ascii?Q?tL1JC7RtdkJWJBFnRQLMv+NaBSyICkE/6YabRtbzrzdUnZnAW02KD8VPp4Qm?=
 =?us-ascii?Q?o785VFdeu4SCk3NrX4dSu5QocWTNMrYjANUxm+23TUQBSOp+MKMZ9gJqish/?=
 =?us-ascii?Q?cYPbx9ERfI0MDCKmRjN+oHCl1x+o1OqVs1LjYu83QA+rOMhGhD600ZrRKvXM?=
 =?us-ascii?Q?qERkeB49nteipPgKdEeNR4Ecdp87blxg2CDmJ+EYS7uNlSO7bvEb/DvDJbRb?=
 =?us-ascii?Q?e/UZvG0o46xtjiSsVOIMUxOdi5kJj4vTvnxJi/BaDNcAytE16aVxvryqNHS9?=
 =?us-ascii?Q?N5VifJdDXAz1h8smNNEfDmPGMhYF59LvaJAwyiEP08//9NERLAWFlU6wkvJi?=
 =?us-ascii?Q?ufn6z2jZrDd0KQOksoGEGSuYeTmdOGmHZbOprxhJ0pEsX+hzhVdJfmdSnHb8?=
 =?us-ascii?Q?twK+5IoVa8ivl2sJARGFLJp78G6Ftdg//TvTwZtm0g4n2xoE1jQL5EZlO+IK?=
 =?us-ascii?Q?x0NIxX+PycSQcVgmbMCQNZhooNuMmainHVfRI6ux7RXkHmmTMUOEG9pVyUyB?=
 =?us-ascii?Q?SFfb1nhhxoAxgSfTK6l7MM4ndt/l3K8SYmhCRijxqoFmc2KMRACex5aN5bP6?=
 =?us-ascii?Q?+2B69tLLTS9hK/2FwZGXZCc5OdiToJd/OfiGuKp7iFNNsewd14oKcUv1RqlE?=
 =?us-ascii?Q?7UDvVBsCNgEsPWenl3MD/wLnlW2sgKfOeZ14y/HNlzqoPuAcUqFfAkn+aOMz?=
 =?us-ascii?Q?8VkP1UFv7YXNsiR/eCR9Ww+K/EALO/UcphyElR75JCQdud9V1jL/bobvkTro?=
 =?us-ascii?Q?OQXcGkTT4osCwwlvNtUDtFrOzxIi1R+04YJtW3k3QCDV5IczJzw7zB1HoVZc?=
 =?us-ascii?Q?60jRsuYVbIi0tnYwM1tiPnx8KsUZX6GUum2tviS2+bm0JmrPjH8dN/Qd5gUG?=
 =?us-ascii?Q?loRMQsivpKw5az8xDhHDiFJ/RfoogjTGw1UeHkNus0bTnmnd0NNg2K2J/sts?=
 =?us-ascii?Q?Glq3tODKqsCqPO/g/sCc9lLgPlYiEcOI7TECEARqu9QlIsWkQEuGfaKrg+US?=
 =?us-ascii?Q?GTAxpBEdSH490PGyPUd5uy78muYobHEHvMOw0/U3HwxNCDu4i/E+43tZnJdr?=
 =?us-ascii?Q?1CVbZZx34OtnsEZbt/WoMj5H1FtIdsmhbFEiCYWakEQWaMLkX/7PMXq6MR1/?=
 =?us-ascii?Q?2VmM/7FidNxy865jLhuBwpRgOtV6PQD+idkXRIUQc4U96GwZVBoU/Q8fmwsH?=
 =?us-ascii?Q?6gd6tB5uDzWeV5CwJW0ViVWd3NDBvZotl96nxj2bdXnZ73e1VD0y3TNSS6da?=
 =?us-ascii?Q?DP9zC8/u+X5Nrm0e+KyyHmPOMWs1167Zsk3IXka8fp1A0wYp3/HxG0MNV3mn?=
 =?us-ascii?Q?iGdtfvfKE4msRGWhdNunyTvndV9IP/dksDW/f6f1pTu3QLGwkrTqx2aVmGsI?=
 =?us-ascii?Q?hnV7S2jtKRqE1rA+R32cRMQ+CMlRA/wfgcISLzpbdnQ/0MPB5BTOsN2m8VfJ?=
 =?us-ascii?Q?HK5jY2Io1A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ds+31QhkeAbEZiycMZraxMJY5xmK4sVsGCAovzsl76tv14O4MKfGQ0TAGsC2QhQDTtWhBB3lG/9uZ37mxNPyTANCFo0g/NtTPiNeVjjMOKtLUQsr6jkvPXtpJAtcfd0CCDy3tOPtkzf6Br1Ue7QV8c9apeDon3DBVBUBeWx9iuKIc02c3OO23qAdja/KmVl5rrxBA1m6WCqvewSi8EgPtW7rHdIJ2Z7foXQaoXmqDmIocQCYPqUOnEle+74TkzsnU0vk+a+kQj9nzn7kzSOfaYUA/CjIObqAaw52FAmKpy/Ubb6hzoFp/ZZ3B3fl+YV5maCBt9uq/558Lw/KQE05XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7866b46e-8c03-4ada-9816-08de7fdf9462
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 02:32:17.6791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H002lfIjBKuZFJILKYO1KjaF0/rDYy9smpwzXz9zFNi335BlxRaALjFNYua5Ab1ny6HZsY205rV/FXPursMpAcBP9xRCztR0F+k7CekS4mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8574
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Clement,

>-----Original Message-----
>From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>Subject: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes writ=
e
>permission
>
>Avoid unintentionally flagging the entry as a shadow stack entry.

Not sure if shadow stack here is what I understand about it, which holds re=
turn addresses.
What's the relationship between fspte entry and shadow stack entry which ho=
lds return address?

>In the current implementation, the dirty bit is always set in the pte.
>Hence, an ATS device requesting an RW translation for a copy-on-write
>page is likely to trigger a PRI request for a region that has just been
>marked as dirty by the IOMMU. However, CPUs that support shadow stacks
>give special meaning to PTEs reporting W=3D0 and D=3D1. Setting these valu=
es

Could you share a bit more details about the special meaning?

Thanks
Zhenzhong

>can cause PRI requests to complete successfully without granting the
>expected write permission, which leads the device to enter an infinite
>loop of ATS/PRI requests.
>
>Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stag=
e-1
>translation")
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>---
> hw/i386/intel_iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index d24ba989bf..56146aafc1 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -2066,7 +2066,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s,
>VTDContextEntry *ce,
>             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
>         }
>
>-        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
>+        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) =
{
>             flag_ad |=3D VTD_FS_D;
>         }
>
>--
>2.53.0

