Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983A6CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEi2c-0005Lj-LW; Thu, 08 Oct 2026 02:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xEi2R-0005L5-38
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:55:37 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xEi2N-0003u7-RV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:55:34 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984C2I52707096; Wed, 7 Oct 2026 23:55:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=U+YlEXrbcYA4AZ+6u3z6CQZqKLTNww0zdnkYyA8x9
 d8=; b=gx0D7HZdjkQXxG+kAuGB/WvH1jSXbsoim87f6oGPi2XwXXULJblcCMCh0
 54uGirh+2/2vra1TeqvsqjudKc/Kp7cfGeuQzhvU7PE+ijGCMXdRAMqyUSfjFgNN
 DI8LmBD4jXnxuTHRMWAxOkvIBb2FexwkKbsTQ6vxuKzgnKk2rgaLFxDSu+88+hNr
 432i8iZqpnlJs+/rFpSmnCuWNxIdxYangXEXOzejd7KdbmQMpPjiYT7MIR++mx3f
 18WP5/ZXebnrBlpS9AoNKLDROLj7V/IKI4MW4JpFDXpy9criiucJbqA4CHCRIiI1
 KhpetolcrgTFudUddGB2T9DamrXbg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4h5xe6gw6v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 23:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn+U9RUThwaukxhi9kyhsysJOqHPXSi5grwYg35cpLmTH1hUNoWaPMSrz/BoOjx+3195AxFN7RxLxR316GdleIoDVJkoWJLQrNf0tO41fKV8m3U8/2BqHCfVBs/rsZZ8+7uRwhpZuhJ2qj/IvfoF2esdV7Qn7q4c4SCIl/4cn78KUgqj7C3XAQ5garJiW28FpJf6GcqbPvMQpIlW1qTb0LHFWhgAE7hn4MIybmaF36HcMUr35TPRlAb3v5v7K6ufUmYh9h9d0W18WPVs6oj4iE7HpDXwGswLBBfHgf/78jSzZMQf6xDBspNmwQAmDpElLP7DBZf4jOzBuwEuYISRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+YlEXrbcYA4AZ+6u3z6CQZqKLTNww0zdnkYyA8x9d8=;
 b=gr5pjrU8XlrUwbPllWA/i+WAS4UX99N6DhrWA/ENg+ZjS8i9Bxop2Ii8WDfeQIpVm7hYbEVcwJCXx4dn3hJ6bH1Fx0MBXcgcpa1Danh5V6SW9N96K1QBX6CzWvVckckAmjUke9umN/luSbtASeg1Ng36VbrsoknXWalEptWImxBHwB5U64xB5FVQ3BF5eJEqz020afzTXg9ukap+HUPDVNxeG9YsxBd7N0gjG6cjpwrKAdxY/aqp+ohnk5gvwEw385KJmhip4PkxAfI55bfAXbcQuoYj7KOdw/MBJvUayzbiTAUuBNBegeizUq5lPrsm30WeQn4CuntAt9R6Bf4ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+YlEXrbcYA4AZ+6u3z6CQZqKLTNww0zdnkYyA8x9d8=;
 b=nm2Fg/aQkZkO3u0kuxi7S6pOuMx5rWwZi6NkuoqJL8ISNt4nFxWTCGkDzeNKuD/H4i5r+LS+Yuky9FxmgGc3pNuEmamQCtdqG5rAaj1R7ir+0flEPUOY/hNglrKtFE8ILGfa2Pg3iWGTohjMqgdZlKi6hENqo/lGtETQ5bhF3qlaIrSgUwrc5iyFIbh2Y/TMfIZZzUP5K7glYkUwDBRAU+2i6caZ/C/w7ER+REsm2ttH9YaEcW1cKcQ0A1cxf24Zx/tXY8fJ58/04/1k3cr6CYG+Cwr+6uFOFjtH9Plqw4Ub95niOdVGA0Puw2hak7rAecd/azpA9tnuMgeI98A8cw==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PHXPR02MB11342.namprd02.prod.outlook.com (2603:10b6:510:3cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 06:55:23 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 06:55:23 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Naman Gulati <namangulati@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Alex Williamson <alex@shazbot.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Matt Evans <matt@ozlabs.org>
Subject: RE: [PATCH v3 RESEND 1/4] vfio-user: add multi-fd region mmap
 capability
Thread-Topic: [PATCH v3 RESEND 1/4] vfio-user: add multi-fd region mmap
 capability
Thread-Index: AQHdVfACl3nCs3953kackZ5RCgjQ2bbzNWQA
Date: Thu, 8 Oct 2026 06:55:22 +0000
Message-ID: <IA0PR02MB9462CAC33AB6756C6FC85D448B932@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20261007000833.2445641-1-namangulati@google.com>
 <20261007000833.2445641-2-namangulati@google.com>
In-Reply-To: <20261007000833.2445641-2-namangulati@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PHXPR02MB11342:EE_
x-ms-office365-filtering-correlation-id: 796200fa-dad6-4058-f7cb-08df25091fe4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|56012099006|10067099003|4143699003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: +fPpOlB0g1vkSDP+JtQygTgV2UTJ0jCCnCyI2x/tudggycfySzHkRG13FYE7rRJnVA83AJPjoUubLxVtakVZWx6iPW8cSI0GDOJVB5+sPaZ4hOObFos8P73dCG5Sj7zz9dFk/qBuLzF3pEw6dhE6ztj/R4mCwpNbLipNXut/puyArhMY/uqzKNtUasJHL7mQurNGC/qm1Gp98cmuZP7jIvtMtKGMgsK5CBiGwuW1TEFDlM1sf5P/GYoz1HJkpjJz8QlIAFWzC5kxd0DgnjNHoMMUW4EtyP/EE3Seg+yeEliXVxrpxTSHuf95L3YdzN00pJhre0XF6xm+r4/S2mnqaTSyVw3MSbsWunq2N2cPks0zeFb9MlO6nUEkPJekHVgi4BgirVvE/TDCl9/Qv9tSKkRgGpLm0k8hht8IKnpmByzD8ktnBqidgjLnRhMmvlBW3OufbI1Uj7OVmIK1FqoU3mt7PypfumLAZCGaxpswGgNukgc+BzWTgYhXPwUufbyWbN2xcAQErnih0v+NQiPxrnf/Ke+I9yRXurZ6vDSNWMWz1v8gC4oOvA+5ITSwNnxmRlViIknfprduwtEDSj91hZ+KhYYZI4d5RP8Ta/zEir8jkVLZHFkJpP7VU/KH5oPssWc3BrMDGvxfawtlW0rZ3SM57BZKkQGdMq63iWvGYGshJz/1do+3WMTHUCmqzu5iPr+jcBWY/JZA9PVxWfTB8liw8AfBNYXKRo0XiohjdJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUtWd2pJN1g1MHJIdVFCRnd5NjdwSFVkaWl3L1JzRVVDZ0lYSmgyUVJBQWpo?=
 =?utf-8?B?QTc2V3FSU1pJQUpHN09aNVV1c0xIdTdmSGd3YmNJVjQ5bzVKWjdjTXk2NWN4?=
 =?utf-8?B?Z3RIUkZpTm9hNEtpMEl0ZEhvRDN2ZVl5RTBYVmVKWCtDNldYdDVtaWhNakJ5?=
 =?utf-8?B?NjdSN2lLKzBoK3B5V2JITkNqOUp6V0Jnek9Jd2JTU3VnaTYwMzZmR3hzZXhY?=
 =?utf-8?B?dE1kV0V6Q3dveEEwOUZOeEN1VWJ6MkV4dE5CRWh3cHgrNEQ5a2t0dG9JUVNF?=
 =?utf-8?B?RDFOZGRDT25yZEI3OEw4cy8vcnYza2Y2NnBLc3hDRmJicTVMNmtQcEUxejJz?=
 =?utf-8?B?SVE0WTZPRXYzcWgyZEtCQXV2T24wdWhvNExCWXlSdnhTSnZ5eVVJdVlWVFRH?=
 =?utf-8?B?T2tDU3RzNDRpU3FzTlBNM3BJRVBScmdqU0pXRmwyNzRVV1lXZjV6c1BtVTY1?=
 =?utf-8?B?VXRMbDFNNVRRQ3pWVHlKd0FFQ2lBVXRtbjA1VGVxYUZOSzZsQkVZWnBtajVa?=
 =?utf-8?B?c1VQNWdCeUtuMC9heEl3aitrbGtHc1pHUjJ6eVZicUE1Tk5Ka1ZUSis0aFhG?=
 =?utf-8?B?RVVpQ09hZjhNU25mNzFWa08ybzFWUm9vRFVBS2RsU0VlWHhGQlE1UWdUemVM?=
 =?utf-8?B?b242VnZCQmdLWURSdU5zVUhMU2kvYnVwTk5xeUdMenFPdzBQYS9nMVVScWd6?=
 =?utf-8?B?L1hENWo4dWg1bkd1ZWRveSt1MlZUWVJjZG8yRHlrUWU1MW55TWNRUDRSdCs4?=
 =?utf-8?B?cmFxbEtRdFJQZ2w0NFZBYW5qaU1FUk1xUERZdDJSSjVlWWo1bFhKaitsVDha?=
 =?utf-8?B?OTBnd25YUWU1QjloL3ZHUGlIUFdrU0VFZlo0NjEzbkFLSmRGL3ZjWDVwV2k1?=
 =?utf-8?B?Ukh3WVUxSWt3OXNtQWtnblhtTE55ZkhFOHRJZWdYbEhXQzI4bXJvKzk4ZVVC?=
 =?utf-8?B?Y1BvZ0JGakNlam1BRDd6YVhmdWZ6Y0lhVXZtRlU4OUhXSVM2TFExZ2JBWTFS?=
 =?utf-8?B?ZEpTUk9wTnVyd0Erd3ZrNkp3amQycjIyUUpQeFA1bHlRbjQyYWQzWkZlYm4v?=
 =?utf-8?B?TnhFK0dFMENhd1FQRG9NZURSaUVpUFJmS0VqeU1CY2pyNXp1U1Q0aTEwVHMw?=
 =?utf-8?B?VUxtMHZpNEVkSHpuN3BOaFFPNzg4YmVKRSt2dmtwaXZ5M3FoRGExMnQ3djhR?=
 =?utf-8?B?MGZqT0ZGL0lvOHoyZElpZk0wOVlRMXZKVUFmckJvSDBJWlJzODI2djJuclQ2?=
 =?utf-8?B?NzFJckgrcEZWd0xEbzBUaWY1TmdSME50dDQwMGNlR0ovMFBneWg2eVN1bndw?=
 =?utf-8?B?Y1E3QUN2OGlOZGRQV25iUmxOZEpxWmdHUmRyeXh3UzQva2R6cG5DSDN0RHpx?=
 =?utf-8?B?MmxZN2xnTk5NRC90MG9uVnZXYzR5Y3NtOFZZMGF6eTBlZWc2cW5yUElHT2JK?=
 =?utf-8?B?aThQM1lVSk5wL05hemdueXhLT3laWUtsWWxGbjM0cnUrZFh3M3lyUTh1SmZU?=
 =?utf-8?B?L0Z5MTNYd2ZwWldUTmZIeEZDcENoRGwxdGlWMmxNSG10dWw0R2tOUTlJUHVK?=
 =?utf-8?B?bkl5YlVDMGcwQUtpaXlxakJSQWtXSXI1c3ArNitSTGtiYmhsRktWaEYzWVJS?=
 =?utf-8?B?OE94MnkyZVlYbW9ZbDJUSzRvSktpVytKYjZaS2JMUDNGdVl4cjJUZ0RMM0JN?=
 =?utf-8?B?SzluSDBZQjlhbTN1eldEVDMxZ2ZKTFI2dVp2ay9tejhpVDlEY3FqU25kQlZV?=
 =?utf-8?B?RkZTUWthOWlwWlErZkhPeS9QbnRTMlNQRzEvVXZqOCtzdU5YWmY2bW1DbjBK?=
 =?utf-8?B?T1NqUEo3VEV0djA2V2RTSFpERXloWU1KLzh4Lytna3cwYll6RVR1Nlc0Z1ZN?=
 =?utf-8?B?RzBQalIySzZZelZxdzlybVc1RE1hU2E5STNrOFJ4TFZNSlVDOHU4bHJtaHZq?=
 =?utf-8?B?S0xDRWJlNE1kTXVZSXRBMHF6QXpZWmxNWDA3bVVJZFVBNEdhdjNWQnYzVVhD?=
 =?utf-8?B?aTd6aHJPVlNFem0xei9aRjZWcjhuM3ZPdDJBK2pHRnZ6a21CeTI2ZFlpT2hv?=
 =?utf-8?B?STZ3SVlXZ2VPMk9xSEE0bVZwbktKUmpYamcrQjVsakVRR2ZtOG9QdW9KSlR5?=
 =?utf-8?B?MWlVdVRPQXlWeUlJbzB3K2h3ejV3QTk2VUU2aFpXYWR2dHRzcDVmU0NyVVZX?=
 =?utf-8?B?ZDBnV3RMQUlJRlhjODh1NmZWb2kveWNQeURCazJBU0haZnFrWXk2bjFqanVW?=
 =?utf-8?B?RFIxU0pLVDlzcnEvdjFkekhiV3gyaHZ5TnUyVi9HanpDZFhXS215M3BTbkxN?=
 =?utf-8?B?WW1Lak9ITUx5bVprZzNyWUNxYU9pZUpZQm1vN0h5RHhTcW83WWZlUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IEeCZDoMB+sWiu4gLfoFTJxx/hC4txYp4elNqrTqb/ukHszc0bdXPBllGYkD+pNQ3Qy2HJy3YB8eEnXYbZbkJyomvm/FUJGpv2dXjOk6igVCKBnk1qahHgqd3wczMbVQqbcaw9DLVZybTQNL7yK1JADOSmoIqUyvgJFkgsPgHF64k3nVJTvtG5a/nifdn8JMEXru+6BgVkp+VD/HIBryoyNRmv9L5iyKrec9F5kVLC7SFPiWhkVnEl7gDoTMsy4RMamuiuIbzS5U/xtBKrIKtCySDekycS8anV1MIiTJPc22t0aDiwFOfPKfJc15qTf4nnYk3yN/0z4+qDMWQQdE4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796200fa-dad6-4058-f7cb-08df25091fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 06:55:22.9754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LEzynHFWzBjXOhQ+Oi/ziT8Qa/mVrKrcVSTUlOU+JGvWTDNpzQ4XhUyOTSxOTWBhaAa/JowHE3hL3JxjwP8TZdfedD01I+mncO6ou9CSLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11342
X-Proofpoint-ORIG-GUID: 4iuqE0rHnc-eA3oX0pf1LPfPCe-2g-F2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNyBTYWx0ZWRfX8cqPbQTXwY4w
 L9jkNv/SmWbxIXnXfYRXZEpj5oJV+LZeZ5R1qWGMBuDhdrPAGJk8hcvRz1vJIv9itdlcKaJm4r0
 38UTnVqESc6INbSwWI0qTCRkTGBiJhq4p3xUF1GrgcgzIM8JhCT3oItHeWp4ImopGNGw/dnpoYd
 MIUUfXXlJb3r646Oy+zCoIA7hsebh6ziSOTR6OEkrsVmilcdiDQoPuONsGr6FgOvtYVUCOoewKP
 zxvjLp1Qx4N7yiioitUmrHnwQaS2rtiRp1SN0lpO5U8nja3VWfbf1l2c9K1aVoc1MJhmoTLQunY
 yBMeHxZEdmEserBs6ztqr8TF/FhDg1RlY6cLwYdOgCl3gsVF7zRw9j6nNs+AhKrnbt4djjV3l1C
 crsFb/BqJ4Mh44omLo9cSJQW/HaxW4/uDPYhtp+s1PJpi41sAoP5Vz+Y/990zQhvF5sucgD34LQ
 7Q+FgN4pqNymWX1J9Mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNyBTYWx0ZWRfX6Rul24bcXmf+
 2rl3TBH6QfEun8C/cDoY7meBG3vQFe4YalPpDr6SRnx3znwoOJwSAvaXq59bXoFiLLtb4/CAQHe
 gAYvRr0JZpIH6p3E1gNqnYt1kaT2gjc=
X-Proofpoint-GUID: 4iuqE0rHnc-eA3oX0pf1LPfPCe-2g-F2
X-Authority-Analysis: v=2.4 cv=NZZzRGD4 c=1 sm=1 tr=0 ts=6ac73e5d cx=c_pps
 a=Q5kcJUpSFGSGPQA8zxlsBw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=1XWaLZrsAAAA:8
 a=69wJf7TsAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=r1p2_3pzAAAA:8
 a=EUspDBNiAAAA:8 a=voM4FWlXAAAA:8 a=vuge53RzWUqkyK6zmlAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=r_pkcD-q9-ctt7trBg_g:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1hbiBHdWxhdGkgPG5hbWFu
Z3VsYXRpQGdvb2dsZS5jb20+DQo+IFNlbnQ6IDA3IE9jdG9iZXIgMjAyNiAwMTowOQ0KPiBUbzog
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBKb2huIExldm9uIDxqb2huLmxldm9uQG51dGFu
aXguY29tPjsgVGhhbm9zIE1ha2F0b3MNCj4gPHRoYW5vcy5tYWthdG9zQG51dGFuaXguY29tPjsg
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPjsgQWxleA0KPiBXaWxsaWFtc29uIDxh
bGV4QHNoYXpib3Qub3JnPjsgUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPjsgTWF0dCBFdmFucyA8bWF0dEBvemxhYnMub3JnPjsNCj4gTmFtYW4g
R3VsYXRpIDxuYW1hbmd1bGF0aUBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgUkVT
RU5EIDEvNF0gdmZpby11c2VyOiBhZGQgbXVsdGktZmQgcmVnaW9uIG1tYXANCj4gY2FwYWJpbGl0
eQ0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+
IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tIQ0KPiANCj4gRXh0ZW5kIHRoZSB2ZmlvLXVzZXIgcHJvdG9jb2wgc3BlY2lm
aWNhdGlvbiB0byBhbGxvdyBzZXJ2ZXJzIHRvIHBhc3MNCj4gbXVsdGlwbGUgZmlsZSBkZXNjcmlw
dG9ycyBmb3IgZGlmZmVyZW50IHNwYXJzZSBtZW1vcnkgYXJlYXMgd2l0aGluIGENCj4gc2luZ2xl
IGRldmljZSByZWdpb24gd2l0aCBjYXBhYmlsaXR5DQo+IFZGSU9fUkVHSU9OX0lORk9fQ0FQX1NQ
QVJTRV9NTUFQX0ZEUy4NCj4gDQo+IFZGSU9fUkVHSU9OX0lORk9fQ0FQX1NQQVJTRV9NTUFQX0ZE
UyBkZWZpbmVzIGFuIGFycmF5IG9mIHNwYXJzZQ0KPiBtbWFwDQo+IGFyZWFzIHdoZXJlIGVhY2gg
YXJlYSBjb250YWluczoNCj4gLSBvZmZzZXQ6IFN0YXJ0IG9mIHRoZSBhcmVhIHdpdGhpbiB0aGUg
ZGV2aWNlIHJlZ2lvbiAoQkFSKS4NCj4gLSBmZF9vZmZzZXQ6IFN0YXJ0IG9mIHRoZSBtYXBwaW5n
IHdpdGhpbiB0aGUgYmFja2luZyBmaWxlIGRlc2NyaXB0b3IuDQo+IC0gc2l6ZTogU2l6ZSBvZiB0
aGUgbWFwcGFibGUgYXJlYS4NCj4gLSBmZF9pbmRleDogWmVyby1iYXNlZCBpbmRleCBpbnRvIHRo
ZSBhcnJheSBvZiBmaWxlIGRlc2NyaXB0b3JzDQo+ICAgcmVjZWl2ZWQgaW4gdGhlIFNDTV9SSUdI
VFMgYW5jaWxsYXJ5IGRhdGEgb2YgdGhlDQo+ICAgVkZJT19VU0VSX0RFVklDRV9HRVRfUkVHSU9O
X0lORk8gcmVwbHkgbWVzc2FnZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5hbWFuIEd1bGF0aSA8
bmFtYW5ndWxhdGlAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkb2NzL2ludGVyb3AvdmZpby11c2Vy
LnJzdCB8IDcxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kb2NzL2ludGVyb3AvdmZpby11c2VyLnJzdCBiL2RvY3MvaW50ZXJvcC92Zmlv
LXVzZXIucnN0DQo+IGluZGV4IDFjOTJmNDQyZDIuLjU3NDRmNThlMzEgMTAwNjQ0DQo+IC0tLSBh
L2RvY3MvaW50ZXJvcC92ZmlvLXVzZXIucnN0DQo+ICsrKyBiL2RvY3MvaW50ZXJvcC92ZmlvLXVz
ZXIucnN0DQo+IEBAIC0xMjUsNyArMTI1LDEwIEBAIFNwYXJzZSBSZWdpb25zDQo+ICBBIHJlZ2lv
biBjYW4gYmUgbWVtb3J5LW1hcHBhYmxlIGluIHdob2xlIG9yIGluIHBhcnQuIFdoZW4gb25seSBh
IHN1YnNldCBvZg0KPiBhDQo+ICByZWdpb24gY2FuIGJlIG1hcHBlZCBieSB0aGUgY2xpZW50LCBh
DQo+IGBgVkZJT19SRUdJT05fSU5GT19DQVBfU1BBUlNFX01NQVBgYA0KPiAgY2FwYWJpbGl0eSBp
cyBpbmNsdWRlZCBpbiB0aGUgcmVnaW9uIGluZm8gcmVwbHkuIFRoaXMgY2FwYWJpbGl0eSBkZXNj
cmliZXMNCj4gLXdoaWNoIHBvcnRpb25zIGNhbiBiZSBtYXBwZWQgYnkgdGhlIGNsaWVudC4NCj4g
K3doaWNoIHBvcnRpb25zIGNhbiBiZSBtYXBwZWQgYnkgdGhlIGNsaWVudC4gV2hlbiBzcGFyc2Ug
bW1hcCBhcmVhcyBhcmUNCj4gYmFja2VkDQo+ICtieSBtdWx0aXBsZSBkaXN0aW5jdCBmaWxlIGRl
c2NyaXB0b3JzLCBhDQo+ICtgYFZGSU9fUkVHSU9OX0lORk9fQ0FQX1NQQVJTRV9NTUFQX0ZEU2Bg
IGNhcGFiaWxpdHkgaXMgaW5jbHVkZWQgaW4NCj4gdGhlIHJlZ2lvbg0KPiAraW5mbyByZXBseSBp
bnN0ZWFkLg0KPiANCj4gIC4uIE5vdGU6Og0KPiAgICAgRm9yIGV4YW1wbGUsIGluIGEgdmlydHVh
bCBOVk1lIGNvbnRyb2xsZXIsIHNwYXJzZSByZWdpb25zIGNhbiBiZSB1c2VkIHNvDQo+IEBAIC04
NTksOSArODYyLDkgQEAgUmVwbHkNCj4gICAgKiBgYFZGSU9fUkVHSU9OX0lORk9fRkxBR19SRUFE
YGAgYWxsb3dzIGNsaWVudCByZWFkIGFjY2VzcyB0byB0aGUgcmVnaW9uLg0KPiAgICAqIGBgVkZJ
T19SRUdJT05fSU5GT19GTEFHX1dSSVRFYGAgYWxsb3dzIGNsaWVudCB3cml0ZSBhY2Nlc3MgdG8g
dGhlDQo+IHJlZ2lvbi4NCj4gICAgKiBgYFZGSU9fUkVHSU9OX0lORk9fRkxBR19NTUFQYGAgc3Bl
Y2lmaWVzIHRoZSBjbGllbnQgY2FuIG1tYXAoKSB0aGUNCj4gcmVnaW9uLg0KPiAtICAgIFdoZW4g
dGhpcyBmbGFnIGlzIHNldCwgdGhlIHJlcGx5IHdpbGwgaW5jbHVkZSBhIGZpbGUgZGVzY3JpcHRv
ciBpbiBpdHMNCj4gLSAgICBtZXRhLWRhdGEuIE9uIGBgQUZfVU5JWGBgIHNvY2tldHMsIHRoZSBm
aWxlIGRlc2NyaXB0b3JzIHdpbGwgYmUgcGFzc2VkIGFzDQo+IC0gICAgYGBTQ01fUklHSFRTYGAg
dHlwZSBhbmNpbGxhcnkgZGF0YS4NCj4gKyAgICBXaGVuIHRoaXMgZmxhZyBpcyBzZXQsIHRoZSBy
ZXBseSB3aWxsIGluY2x1ZGUgb25lIG9yIG1vcmUgZmlsZSBkZXNjcmlwdG9ycw0KPiArICAgIGlu
IGl0cyBtZXRhLWRhdGEuIE9uIGBgQUZfVU5JWGBgIHNvY2tldHMsIHRoZSBmaWxlIGRlc2NyaXB0
b3JzIHdpbGwgYmUgcGFzc2VkDQo+ICsgICAgYXMgYGBTQ01fUklHSFRTYGAgdHlwZSBhbmNpbGxh
cnkgZGF0YS4NCj4gICAgKiBgYFZGSU9fUkVHSU9OX0lORk9fRkxBR19DQVBTYGAgaW5kaWNhdGVz
IGFkZGl0aW9uYWwgY2FwYWJpbGl0aWVzIGZvdW5kDQo+IGluIHRoZQ0KPiAgICAgIHJlcGx5Lg0K
PiANCj4gQEAgLTk1MCw2ICs5NTMsNjYgQEAgVGhlIFZGSU8gc3BhcnNlIG1tYXAgYXJlYSBpcyBk
ZWZpbmVkIGluDQo+IGBgPGxpbnV4L3ZmaW8uaD5gYCAoYGBzdHJ1Y3QNCj4gIHZmaW9fcmVnaW9u
X2luZm9fY2FwX3NwYXJzZV9tbWFwYGApLg0KPiANCj4gDQo+ICtWRklPIHNwYXJzZSBtbWFwIGZk
cyBjYXAgaGVhZGVyDQo+ICsiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiDQo+ICsNCj4g
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKw0KPiArfCBOYW1lICAgICAgICAgICAgICAgICB8IFZhbHVlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ICsrPT09PT09PT09PT09PT09PT09PT09PSs9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PSsNCj4gK3wgaWQgICAgICAgICAgICAgICAgICAg
fCBWRklPX1JFR0lPTl9JTkZPX0NBUF9TUEFSU0VfTU1BUF9GRFMgfA0KPiArKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ICt8
IHZlcnNpb24gICAgICAgICAgICAgIHwgMHgxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwNCj4gKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKw0KPiArfCBuZXh0ICAgICAgICAgICAgICAgICB8IDxuZXh0PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gK3wgc3BhcnNlIG1tYXAg
ZmRzIGluZm8gfCBWRklPIHJlZ2lvbiBpbmZvIHNwYXJzZSBtbWFwIGZkcyAgICAgfA0KPiArKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rDQo+ICsNCj4gK1RoaXMgY2FwYWJpbGl0eSBpcyBkZWZpbmVkIHdoZW4gYSByZWdpb24gc3Vw
cG9ydHMgZGlyZWN0IGFjY2VzcyBieSB0aGUgY2xpZW50DQo+ICt2aWEgbW1hcCgpIHdoZXJlIGRp
ZmZlcmVudCBzcGFyc2UgbW1hcCBhcmVhcyBhcmUgYmFja2VkIGJ5IGRpc3RpbmN0IGZpbGUNCj4g
K2Rlc2NyaXB0b3JzIGluIHRoZSBgYFNDTV9SSUdIVFNgYCBhbmNpbGxhcnkgZGF0YSBhcnJheS4g
Q2FwYWJpbGl0eSBJRA0KPiArYGBWRklPX1JFR0lPTl9JTkZPX0NBUF9TUEFSU0VfTU1BUF9GRFNg
YCBpcyBkZWZpbmVkIGFzIDE2ICgweDEwKSB0bw0KPiBhdm9pZA0KPiArY2xhc2hpbmcgd2l0aCBr
ZXJuZWwgVkZJTyBjYXBhYmlsaXRpZXMuDQo+ICsNCj4gK1ZGSU8gcmVnaW9uIGluZm8gY2FwIHNw
YXJzZSBtbWFwIGZkcw0KPiArIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiDQo+
ICsNCj4gKystLS0tLS0tLS0tLSstLS0tLS0tLSstLS0tLS0rDQo+ICt8IE5hbWUgICAgICB8IE9m
ZnNldCB8IFNpemUgfA0KPiArKz09PT09PT09PT09Kz09PT09PT09Kz09PT09PSsNCj4gK3wgbnJf
YXJlYXMgIHwgMCAgICAgIHwgNCAgICB8DQo+ICsrLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0t
Kw0KPiArfCByZXNlcnZlZCAgfCA0ICAgICAgfCA0ICAgIHwNCj4gKystLS0tLS0tLS0tLSstLS0t
LS0tLSstLS0tLS0rDQo+ICt8IG9mZnNldCAgICB8IDggICAgICB8IDggICAgfA0KPiArKy0tLS0t
LS0tLS0tKy0tLS0tLS0tKy0tLS0tLSsNCj4gK3wgZmRfb2Zmc2V0IHwgMTYgICAgIHwgOCAgICB8
DQo+ICsrLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tKw0KPiArfCBzaXplICAgICAgfCAyNCAg
ICAgfCA4ICAgIHwNCj4gKystLS0tLS0tLS0tLSstLS0tLS0tLSstLS0tLS0rDQo+ICt8IGZkX2lu
ZGV4ICB8IDMyICAgICB8IDQgICAgfA0KPiArKy0tLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLSsN
Cj4gK3wgcGFkICAgICAgIHwgMzYgICAgIHwgNCAgICB8DQo+ICsrLS0tLS0tLS0tLS0rLS0tLS0t
LS0rLS0tLS0tKw0KPiArfCAuLi4gICAgICAgfCAgICAgICAgfCAgICAgIHwNCj4gKystLS0tLS0t
LS0tLSstLS0tLS0tLSstLS0tLS0rDQo+ICsNCj4gKyogKm5yX2FyZWFzKiBpcyB0aGUgbnVtYmVy
IG9mIHNwYXJzZSBtbWFwIGFyZWFzIGluIHRoZSByZWdpb24uDQo+ICsqICpvZmZzZXQqLCAqZmRf
b2Zmc2V0KiwgKnNpemUqLCBhbmQgKmZkX2luZGV4KiBkZXNjcmliZSBhIHNpbmdsZSBhcmVhIHRo
YXQgY2FuDQo+IGJlDQo+ICsgIG1hcHBlZCBieSB0aGUgY2xpZW50LiBUaGVyZSB3aWxsIGJlICpu
cl9hcmVhcyogdHVwbGVzIG9mIG9mZnNldCwgZmRfb2Zmc2V0LA0KPiBzaXplLA0KPiArICBmZF9p
bmRleCwgYW5kIHBhZC4NCj4gKyogKm9mZnNldCogc3BlY2lmaWVzIHRoZSBzdGFydCBvZiB0aGUg
YXJlYSB3aXRoaW4gdGhlIGRldmljZSByZWdpb24gKEJBUikuDQo+ICsqICpmZF9vZmZzZXQqIHNw
ZWNpZmllcyB0aGUgc3RhcnQgb2YgdGhlIG1hcHBpbmcgd2l0aGluIHRoZSBiYWNraW5nIGZpbGUN
Cj4gZGVzY3JpcHRvcg0KPiArICByZWZlcmVuY2VkIGJ5ICpmZF9pbmRleCouDQo+ICsqICpmZF9p
bmRleCogaXMgdGhlIHplcm8tYmFzZWQgaW5kZXggaW50byB0aGUgYXJyYXkgb2YgZmlsZSBkZXNj
cmlwdG9ycw0KPiArICByZWNlaXZlZCBpbiB0aGUgYGBTQ01fUklHSFRTYGAgYW5jaWxsYXJ5IGRh
dGEgb2YgdGhlDQo+ICsgIGBgVkZJT19VU0VSX0RFVklDRV9HRVRfUkVHSU9OX0lORk9gYCByZXBs
eSBtZXNzYWdlLg0KPiArDQo+ICtJZiBhbGwgc3BhcnNlIG1tYXAgYXJlYXMgYXJlIGJhY2tlZCBi
eSBhIHNpbmdsZSBmaWxlIGRlc2NyaXB0b3IsIHRoZSBzZXJ2ZXINCj4gK21heSBpbnN0ZWFkIHNl
bmQgYGBWRklPX1JFR0lPTl9JTkZPX0NBUF9TUEFSU0VfTU1BUGBgIGFuZCBleGFjdGx5DQo+IG9u
ZSBmaWxlDQo+ICtkZXNjcmlwdG9yIGluIGBgU0NNX1JJR0hUU2BgIGZvciBjb21wYXRpYmlsaXR5
IHdpdGggb2xkZXIgY2xpZW50cy4NCj4gKw0KPiArDQo+ICBgYFZGSU9fVVNFUl9ERVZJQ0VfR0VU
X1JFR0lPTl9JT19GRFNgYA0KPiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gDQo+IC0tDQo+IDIuNTYuMC5yYzEuMzE1LmdjNmVkOTkzNGI3LWdvb2cNCg0KVGhpcyBs
b29rcyBzZW5zaWJsZSB0byBtZSwgSSdsbCB0YWtlIGEgY2xvc2VyIGxvb2sgYW5kIGZvbGxvdyB1
cCBvbiB0aGlzIGFzIHdlbGwgYXMgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoZXMuDQo=

