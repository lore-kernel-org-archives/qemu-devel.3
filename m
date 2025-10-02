Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3094FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 12:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4I81-00051Q-Mp; Thu, 02 Oct 2025 08:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4I7v-00050u-QD; Thu, 02 Oct 2025 08:09:40 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v4I7j-0006uk-6H; Thu, 02 Oct 2025 08:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahCaxOJAdBrrhLii5dAi9lgiM8GJt4zHrnC24navq5oM53vLgIaZe0NR982UqAHYD8AJKcaFVmdxBzpVY3O6TJR8Z9ds9stJbed/GTRrNSdXV36RhdHX3tZs0vUer1h5Rkr0SKExq3Yme1AR/3wCDYQI0hqQI2SaJ9CP/OuXZrKg4ssyrWuXedLcPyRKgOIUasHKbWYpAgWsmPaC4eHRelUml/OsPtZqnmk+1luJHZYU8RzjTDQpePb+aFhfcBxzncp5Pi5NxR+gq+ScOlAIXxf+8hBms0cjSpDx3AhcCJpei+nRrNLXcMDwFDMj7xLmMsEpxIgoTt6yY5RjkYolTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TarRkEAvFeHuPGutYEpH+1vAjQxguzrwWY5NdptlARQ=;
 b=YYRvd9/nIKLXXx4xwrEIK62imyyrTjsEM+IcreqacwyceVZ/6+d6bye3enOOtHg1XuNCYGF8aOEAsaZTnKNzzNYQklgiE3yh+r0RnSUzMBQKVWQJpGc+Ko6cG1rCAMY4l7JFmorNEjQvzMQaFBz8fiqDtUObfSMDvuKC1dwyJSgbx56wueFv1lSwW0WFdQ7GU0POI96Bheafn9T/efh7hH+uePnv1IAkPHX/d7Ui5tr9DVNKZ6WPuvIbvf/qcGdNb/kqU5Sqo5cPp23n2mcFpGaEovg9rDR/RiFfh0YpqVDqEtunbSa4Um0Zd1mX76eAKD2FIlZlFOerpteNI1NDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TarRkEAvFeHuPGutYEpH+1vAjQxguzrwWY5NdptlARQ=;
 b=Fn4rvlBeTPqiqjvdiI34u4DdmWpZT1vA6Yqi2xm0dXKt9gx1m8EaChrfvfzQOiPaiN9cRqYEfKyEJm55x4urEGAWH0shceTHMSb/WGp99mrKzriBSlSZWLB8lN+r2ANC6WryVmBFr3rWxyX8qd+gxv9jwcp2FCLrXluZ5haeYDqgWYUda2Y7pj1KvRVK8wORyvwtvHckaLPA88lPu/BaOoHyJfm07D+B6QldpILYkCD7RgPWPPuFWo6tQpWMQERL5CXcD/cSgD01K9NiMotIOEzNo6kZhTmn609pcTKtqdQ63DGCr2BkWctNZIzpLQR7SjC19BcwI7YTQU3MzlFCHg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 12:08:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 12:08:56 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 09/27] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Thread-Topic: [PATCH v4 09/27] hw/arm/smmuv3-accel: Support nested STE
 install/uninstall support
Thread-Index: AQHcM4P7su0iWwPWUE6u3P9HWxWGdLSuvkMg
Date: Thu, 2 Oct 2025 12:08:56 +0000
Message-ID: <CH3PR12MB7548BF0AE78D2DE5FA0E3102ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-10-skolothumtho@nvidia.com>
 <a0a149c6-e05a-40b1-87dc-c4a9470a85ed@redhat.com>
In-Reply-To: <a0a149c6-e05a-40b1-87dc-c4a9470a85ed@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH1PR12MB9623:EE_
x-ms-office365-filtering-correlation-id: b7901fc8-c5c0-4ab6-43c2-08de01ac7663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?L3pzdU9QcExvaGFJM2Y3OGhqSHFTTUVtQllBNzUxdm81eEFqUDUwZ1hSQUVW?=
 =?utf-8?B?MXVBMWlxTXl0ZnVQNFZHKzUyMU01QmZXUDBvSTVXYjA2NngyYkEvdC9DMTlU?=
 =?utf-8?B?M0N1QjNrY0g4RE1rSFBjVi9VYUlYb2g3VTlQZGdQcVYzSkJXRXU4NWdjeDVi?=
 =?utf-8?B?bklXZFEweUZlMUxWMHRxSlFSYWNQRjZUMlF5NGxDSk5welN0WjZINXZ3OStD?=
 =?utf-8?B?blYyOE5KK3dpVnNQTmYxdmxyRXZKczVOOEk2RVNkc2ZPckxKNXlHV3JJb1R5?=
 =?utf-8?B?OGtsdmd3S2cxUTIzbTE4Sm54ZWNsV0FpOFk5NGNTM05GN0VkTmRTR0NReEpi?=
 =?utf-8?B?REdhZ2lOZGJPUWFBMWhEdzY3UnZ5cWpjd3E3Q3R2N3lSaVVsR0xLcjQyMEtE?=
 =?utf-8?B?YVhqZ2hMTVJUUTQvVTRNd2tUb09Ob2wzdW1wMWMwSXNSZXV4RzdGcmhZYjBt?=
 =?utf-8?B?WHdpQk1SNklzSGtkK1dzRThjUEZTZHE2QW9iaWtJZ2dSSm5sWU5HZnVMYnB2?=
 =?utf-8?B?aGJJdlB3Mm9DbURCdTdkcGNiNWEyQlZLclRTcm9vakxPM1VPVEJ3cm5sQ3Q1?=
 =?utf-8?B?UFZrY0xJb3NDWkY4emhnS0dUOHJKaHJuRUJlSXJURDZPNjMvUDNZTmpvZnhv?=
 =?utf-8?B?WHB4MlpEZG90eTJuYkFFSXRNdHVwczJQanFrSkdWNGQxMk9pbXdKV0dvWHRy?=
 =?utf-8?B?ZXRPaTZ0ZTZCUW81NkVoZ1hkMWlKQ21sOVRmaUtZbDVubGJRdWdHc3NiQnRy?=
 =?utf-8?B?ZWE4K204T1lEbUY1bnRLbnQwYW1VWWNoeDNpamZCcTdsRG5UcWhPdlZvMXdl?=
 =?utf-8?B?bmdZLzQxYXlkQ08zT1lxdUt5V3hGZ3BGbzZ1UHFVc1BNZXZ4ampMcHJ0WUNn?=
 =?utf-8?B?MzZVSHVDczVOSk9sb3J0U2ZJaEYxZ0o0T0xBdDFGaEVHbmFldVBhS1hwM2RI?=
 =?utf-8?B?TWladGx5WXdzZGxwdEdwZkw1YzV1S3hqanluclYxWWZwNnpxd0hqV1BKM2x6?=
 =?utf-8?B?TFhtNGVoYXllQmF3SFJaTHlaMENFVW4xZTNOSHM1cnM2cEpULzQxK1YvaVY5?=
 =?utf-8?B?cjRDNVh0SDlaUE5YTkg5UGgwM3IwQXAvYWJ1b2pzMnJaZ0xqSlV1UmovOHJa?=
 =?utf-8?B?TUY1R1hJMzhGcW40OExOdGlUS3pHSkVFbnc1OUtmYWZOT0hKdTRiS3lmbnI5?=
 =?utf-8?B?QnhTWW55UkJzSlkrN2ZqVTNoZUpWb1k2UjVYNGc4TDIyUFpERmI5Slpndkk2?=
 =?utf-8?B?SE55YUJPdlBaZHZVUk9CbXgwN2luTGVtU25yTisxT0JMb0cwSmE1SVVMQk5P?=
 =?utf-8?B?N2RmalBIUkpUV1hOeVlxSElMWi9QSGU5UllsK1ppUGd0ZFRMZHhFcHhCZXFL?=
 =?utf-8?B?V2xGbERkNysvVzNya05vZFR6OEM5bDlXRmF3Y1BsM0RHSFVLanRnZTduenNO?=
 =?utf-8?B?NEgvd0xzd1hyek1CVWZ0a3JrdU9FZ2JORUJ2MzZ5bS9xZjFCcnZ0RFljNmFq?=
 =?utf-8?B?Unk4MnlnTStHTDBDUlZqRmNiZ0x3RHRLL2FYaHZ2SUhMZ2tzQmZHUjlZVHZu?=
 =?utf-8?B?dnBsMkF0Y3Q1RVJTb2NJSklvNEVRYk5UMkNhUy9tYUVLK2pwM25VQlMxVUFt?=
 =?utf-8?B?R0pmb0NyUWZVSFRuL0VQRERpMHNBeWN1OHE1VWMwTnlZcmZnWmQ2c0VmOGov?=
 =?utf-8?B?WVZRSkhVb3FYaGxodEp3MEJHNzFrRGtoZnIvM01jUHZpUzlGbUluSG01NHpr?=
 =?utf-8?B?Unk3dytxM2JncGk2RUt2eWdKdGwrUkp5dTR0bmVTRVB6bDkyRTJZdWtpUks5?=
 =?utf-8?B?MkYvdzJhOFpjYlJyL3R6My96OTMyZVorR1ptSGNNdzhmVHNxZFZFdVpyOVQw?=
 =?utf-8?B?TmFpUklUVk9zcFJwUGNIRjBxd2Zlc2J6eEhIaGs1aU9vdnRySWVlRk9Ud2Rx?=
 =?utf-8?B?aWVuU3pqTnVHMzl2bmlzdWFrNE9OVWEvWTFPeUpaRHlPbHBJd1RCZitKOG9j?=
 =?utf-8?B?dzh0YzNjMHY3cHpmWFVVMGxobVZYdkJ0U3FCR0NlZWhBVVd2aE1VK1RBL3Mr?=
 =?utf-8?Q?darLam?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEFTSUordW9hWEIwL1EzU3k2VFM2akVjZ3dBc3BMSS94NytnamEvV3lzTVJL?=
 =?utf-8?B?eHQvRTNjUXpINExKelJIelV0azU3R1ExTFY1VVlDc2lSeCs5TnY1QmcreldP?=
 =?utf-8?B?Z25WUXFXZTlFaTN1MW8vLzlnaDJ1UWV6RTZ2Yks1T1oxR091b2tXN1N3K3Nu?=
 =?utf-8?B?c0VLNkkvK3Q3Y0NvTzZSck5CMWRZMVhZdkp0b0R0MEFZY2UyazJ6RkEwZTly?=
 =?utf-8?B?K0VpMGFPdlZMUXFEcG5UV2ZLTTNSVVVFSVIvWXd1MWlpY3M0bWphdXVrV1ZR?=
 =?utf-8?B?aTgxTzhXZjd0U2lZUGlNYmFoS2t0Wk52OERsM2YrVUJoangvdUNOdVRETlF6?=
 =?utf-8?B?STFzZnZyRWkyNjdBS05pVzZWQkpyVjZKckgvU3lxQm5ING9EaUo2ODF0WVdB?=
 =?utf-8?B?bzlCZU5GR0VSTkU4VXpYVmNiWXpnWGtLSE1JTmpQT0NyYjJiNFZENFBKRTlI?=
 =?utf-8?B?bDZUZ3ZRV0pVemdXYkhJbG5KTCsyNHJydG0rRjlQRWtUcmhBMUhSUzl4cHZL?=
 =?utf-8?B?VnBlS3FNT1pKd0dOMjJPU1JJUXc3RXJkTzZEcVJuamFWV1BpRFVPVkVSYlBs?=
 =?utf-8?B?a3N6MEVyMC9BTkU3SGhKa1lZT0RudE1vbEhneFRNUlpYT2lxNDdSSCtSSUZk?=
 =?utf-8?B?VzJLMlV0VUM1V2VpdVF4M2hycm9xSHQ2SzlHc2hJNFhjWXBnb0t3YzV0Q3E5?=
 =?utf-8?B?U3RyVzhSRHZUYzlPdUZ4NGlOQ2NvN3hwb3ptQ0dtaFVTMEx3THpONlhYODNt?=
 =?utf-8?B?Y0JWc09ndDJ2QitVWHV5Y003YXRMSFl6bEgvK1ZCTjdqOFpKYTlkMWhuc050?=
 =?utf-8?B?YXJBVXQwREZKR3cxYjNDclB4aVh2VDJhZEhiWnRFakh3OTFTKzZGaG4yNmp5?=
 =?utf-8?B?U3diMU5uVFh0b0VHZDBvWlNYcmRhZUxkTE5FdlJYZENzWkJEU0M1YXNZaXdp?=
 =?utf-8?B?ZnNjRFlnOHZBeW9RRnVBTlduQXVGUDNKb2V5Z0Vaa2ZwN3d6cVhsK2RhcjlX?=
 =?utf-8?B?SHR1ZWg4SU54aElvWk1QaFJvWk1qeGJkcnZhZW5uZ05uM0NnS1M4blZnSXoy?=
 =?utf-8?B?Q1h3MDFvUVdDb1FXUlFBMGFSUWg2b2xsZlZreU83b3BCYm1mZS9QOEVPak9B?=
 =?utf-8?B?cXo1Yis3MzVGVVN1a1UyL2xqQXV3S2NPQ05yckJmcndDUlBZZlpRWnZhQm9O?=
 =?utf-8?B?aGxWNWNoRERpaXJZQm41VTRzRlNqNHl1ZHkvL3J4eW5mWTBtYTd1Z0MybEFF?=
 =?utf-8?B?dnR2K3lxb2Z4Ujk3aGs1VlBGZUhwN2M4QVVZaml0MGEzbnpISkJ1YlYxbUpu?=
 =?utf-8?B?ams2dkhpMkhwcHNXOW14Nkx0c3dCWktad2dsVHVWL3ZHekxNcFVXMHJtU2NH?=
 =?utf-8?B?eDZSYjdWQ3ZQV3Z0bHZVZzBITmUyWVNLSnB5ZzZaNlVFMmVua1lqbmxhTHVr?=
 =?utf-8?B?YUQvM3pCTUV0NU0xaVVrTUtieldTbDlvZjl0MGwyOGtnK25PcjhFTWY3TUdo?=
 =?utf-8?B?anc4MURpWlBEZ25CelZPc1VmdGNwN1kreTlTbWFDWFowUzBSVWRBNnhXWjhR?=
 =?utf-8?B?ekdMQ0gyOEM2U1IrRi9sRWowV2xXS1dpdUVpaGdQVkM1djdEaVpiSFRBL0R6?=
 =?utf-8?B?aGZ3d0VmSVZneGhQVTV6ME0wZkRYQmQxa1FqY2xJdm12YXJPSm12UHlKSXp0?=
 =?utf-8?B?czNDUTZDY21MTnh4YWJibzFmWUxiUmVjakdPa1FHZzNZL0szRGNEajhyeExE?=
 =?utf-8?B?dEl1WVhsclIyamNScWlYVk5jbkhUN3BJbTRNY1RqalFUQzZaRXdFNDNBc0dv?=
 =?utf-8?B?T3EyRk5FdGdndUQ0ZWRyZVN2WnNMTEt0T1kwYU0xeDFyVy93dnpZZlhkZ0ps?=
 =?utf-8?B?ci9ZMWUya1Q5NGF4bTk5eVMyM1RHc2FhTmJHY1R2QTQxc3cxVDlDSFhJdE95?=
 =?utf-8?B?R3JEUGpYWEpoTzVyQXJsNHBvREpWZFJNTFNGWkVuSVRVcE1PWTN4cGtJU2U3?=
 =?utf-8?B?UmVnYjN0N3hGenVwQklYVW9MYjhjVWJBVzhkMjJ0UlQweHFnOXdzNVVNOSs1?=
 =?utf-8?B?VGprRVlDL1RWYmNIMSt6VHZqZkJnd1FoYjdjc1pVR3J3cm5XemY0QXEveWlw?=
 =?utf-8?Q?HMkBI7D/wNeSS/CraRrXwFity?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7901fc8-c5c0-4ab6-43c2-08de01ac7663
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 12:08:56.5254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZE0I1csNZUa6XIYHqbzRB1QYhrdeQlpzduNXoSBbAwBBLl6X7nDd8S9wHxRI45XFhhseYEw4BCQN8cpG4hg0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMiBPY3RvYmVyIDIwMjUgMTE6MDUNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbg0KPiBD
aGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
IDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhp
c2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFtZWVya29sb3RodW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDkvMjddIGh3L2FybS9zbW11djMtYWNjZWw6IFN1
cHBvcnQgbmVzdGVkIFNURQ0KPiBpbnN0YWxsL3VuaW5zdGFsbCBzdXBwb3J0DQo+IA0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA5LzI5LzI1IDM6MzYgUE0sIFNoYW1lZXIgS29s
b3RodW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29t
Pg0KPiA+DQo+ID4gQWxsb2NhdGVzIGEgczEgSFdQVCBmb3IgdGhlIEd1ZXN0IHMxIHN0YWdlIGFu
ZCBhdHRhY2hlcyB0aGF0IHRvIHRoZQ0KPiA+IHBhc3MtdGhyb3VnaCB2ZmlvIGRldmljZS4gVGhp
cyB3aWxsIGJlIGludm9rZWQgd2hlbiBHdWVzdCBpc3N1ZXMNCj4gPiBTTU1VX0NNRF9DRkdJX1NU
RS9TVEVfUkFOR0UuDQo+IE9OIHNldCBib3RoIGFsbG9jICsgYXR0YWNobWVudCBhcmUgZG9uZS4g
T24gdW5zZXQgeW91IHNoYWxsIGV4cGxhaW4gdGhlDQo+IGd5bSByZWxhdGVkIHRvIGNvbmZpZy9h
Ym9ydCBod3B0LiBUaG9zZSBhcmUgUzEgaHdwdCwgcmlnaHQ/IEkgdGhpbmsgdGhpcw0KPiBzaGFs
bCBiZSByZWZsZWN0ZWQgaW4gdGhlIG5hbWUgdG8gbWFrZSBpdCBjbGVhcmVyPyBJbiB0aGUgcHJl
dmlvdXMgcGF0Y2gNCj4gSSBkaWRuJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhhdC4NCg0KT2suIFRo
ZXJlIGFyZSB0aHJlZSBIV1BUcyBpbiBwbGF5IGhlcmUuDQoNCkJZUEFTUyBIV1BUDQpBQk9SVCBI
V1BUDQpTMSBIV1BUIC0tPiBUaGlzIGlzIHdoZW4gR3Vlc3QgaGFzIGEgdmFsaWQgUzEgKFNURV9W
QUxJRCAmJiBTVEVfQ0ZHX1MxX0VOQUJMRUQpDQoNCkluIHByZXZpb3VzIHBhdGNoIHdlIGFsbG9j
YXRlIGEgY29tbW9uIEJZUEFTUyBhbmQgQUJPUlQgSFdQVCBmb3IgYWxsIGRldmljZXMNCmluIGEg
dklPTU1VLiBXZSByZXVzZSB0aGF0IGhlcmUgaW4gdGhpcyBwYXRjaCBhbmQgYXR0YWNoIGlmIEd1
ZXN0IHJlcXVlc3QgYSBTMQ0KYnlwYXNzIG9yIGFib3J0IGNhc2UuDQoNClRoZSBTMSBIV1BUIGlz
IGFsbG9jYXRlZCBhcyBhbmQgd2hlbiB0aGUgR3Vlc3QgaGFzIGEgdmFsaWQgU1RFIHdpdGggY29u
dGV4dA0KZGVzY3JpcHRvciBhbmQgdXNlIHRoYXQgZm9yIGF0dGFjaG1lbnQuDQoNCldoZXRoZXIg
d2UgY2FuIGNhbGwgdGhlbSBTMSBIV1BUIG9ubHksIEkgYW0gbm90IHN1cmUuIEJlY2F1c2UsIEkg
dGhpbmssDQpkdXJpbmcgYWxsb2MoKSBjYWxsIHRoZSBrZXJuZWwgYWxsb2NhdGVzIGEgTmVzdGVk
IEhXUFQoSU9NTVVfRE9NQUlOX05FU1RFRCkNCndoaWNoIHVzZXMgYSBHdWVzdCBTMSBuZXN0ZWQg
b24gYSBTMiBIV1BULg0KDQpBbnl3YXksIEkgd2lsbCByZXBocmFzZSB0aGUgY29tbWVudHMgYW5k
IHZhcmlhYmxlIG5hbWVzIHRvIG1ha2UgaXQgY2xlYXIuDQoNClRoYW5rcywNClNoYW1lZXINCg==

