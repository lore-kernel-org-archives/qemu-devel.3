Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D3C44502
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 09:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viUmp-0005e0-Hc; Wed, 21 Jan 2026 04:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1viUmR-0005XZ-Op; Wed, 21 Jan 2026 04:45:49 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1viUmN-0003ic-IX; Wed, 21 Jan 2026 04:45:37 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L2oXsg897528; Wed, 21 Jan 2026 01:45:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YUFPRS9tKc0zCCTcFcES0v9PWDr4UwxkZ2B9A/tmV
 UA=; b=07A9GjLubXNyhiqtiNA2oOoLC9p/iAlRxGHPh8m6hUVlKs0UpY6Hrtvzr
 fZey/JaYMYikYLQBLeFlcO1UXcQ3MBkQBBHEugdtGk5yjPPXZ5s0sZ4USA6g5Psj
 ZdIUBYEEYz5JTfJCRGgCfjSuh33Pl6eHgf1xcpN9MospiN44KmaQXkKB3QFvF35L
 kaDXslbvovaw7EvjMcquL1q+tZB3ZiqYQzWFWVWGC9SuPqaQaOJNqPt+CJseOZsP
 twIPXu002vFZexDIqndEGQe2hqFkP9ZNl92b4FDO4YJDd0F37i3Xa0hU4Mzaf0PQ
 6LprdW771Gzfu+uzx832OZ2Y20XDA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020096.outbound.protection.outlook.com [52.101.46.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4btdde27gv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 01:45:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QduKCzcazLkLywZghY3HRAAVh/e9s4NIT7WlEu/WphnHUEg8z7ZELNPMJ8dv5fxafrmc9HtQxT9nWa/aEmTnwYA8vqDo0/E99jnTi8Xf/ca2GLoAM3DEAZ2+YugfK6uyic6gQtTJdDZnKSAml44xXyheYlukP68kZLDalfEGmspB4+8f+2aVLrl+Oh8iVV3MJW07q5lM8eCfEFL4a5DWDZBBnl5bciIcCXq30Kbw1zixVwzC9zw+iemGdYnyukq9kxdVStA+y4rjam/nBW1YM4DxFYIjRU+eDwXNUoAlSEOoiEMuOvxqFYnCkmN6dsulB7CKvVOWoLCPjM/Hlswv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUFPRS9tKc0zCCTcFcES0v9PWDr4UwxkZ2B9A/tmVUA=;
 b=QnhQji0JM2cDnOV8cpcOIH+gUsbxz/PDQto2XKMCExuQuutnnhGzmQQyhi5BB2+Zgq69VXBw73BliYYYPeX2pmZUkITIFWh2SiioNXeXr+eWYGD4Ee3UnO4gwvuPK601yQswopUrhqlATAsel9QsAsDNKy/MCJ14h1L/Q2AvWB0Q/31+YR6bfW/XRu6xKnPKDUcQjhMBGVtx4eJQkbrqwsaCVVtaYhFYD8sw2xlBGYx1hzbxycAU0uicfCbCaZNQNrajxrAsERyo25i/6+RPUk9W4PgkLWbMAWc0SnOu1RL8U6XfuktFpO1SpIZdN4D6bGyQUaQst6Cfs/0Vbip0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUFPRS9tKc0zCCTcFcES0v9PWDr4UwxkZ2B9A/tmVUA=;
 b=PjdLXZz3F7KCvI5Y0MuiHIMisegaoM7frbIJ2XST/gLAf4HypY757bhwhRX1NmGmKxSJpi3Kv0f+ytuoePOMJZghq4C6nOCUKh7rR13icKuIS5P3zL+cspZ+l7vWJztkguGMqPbfgHZ/lYrUpX5/v0Y6ZbhaUPlJeihUrxSn0d/bbMG+lsMKow3cg/MEmlnxU4zcV+y+dxlGp3uEDPzz1K7AJ5F/G9Y6jurmcawpFGlGHXyP9M7BSzDfC7J/RhaQLWI5ZrdcCSK+p7TORaIZffwPVlvl4B1LiZbNC3fUYFFmbaha9SfXPoBnBx7CiE+mCVqtH2t6/2gfnrE/I0BiLw==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by BL3PR02MB9034.namprd02.prod.outlook.com (2603:10b6:208:3bd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 09:45:24 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 09:45:24 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: Kevin Wolf <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, John Levon <levon@movementarian.org>
Subject: Re: Deadlock with SATA CD I/O and eject
Thread-Topic: Deadlock with SATA CD I/O and eject
Thread-Index: AQHcirqqWwWXewfoL0yePE/IVKfopg==
Date: Wed, 21 Jan 2026 09:45:24 +0000
Message-ID: <EA024563-627F-4E9A-A051-AAE9A4645AB2@nutanix.com>
References: <ZQiIxERjYmZb0v4l@movementarian.org>
In-Reply-To: <ZQiIxERjYmZb0v4l@movementarian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|BL3PR02MB9034:EE_
x-ms-office365-filtering-correlation-id: 68bbc336-0f80-478e-f15a-08de58d1cce7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RDJYOWVyYWk2QkhWckVaU0N4eVNhckhUSVc4bkxYRG9kU0Y5bG5Jdm9PVGsz?=
 =?utf-8?B?VzRTRXdNVWFRSHc4Qk50YlROejNSQ0tDaEI3em9XRW9xNytMWkdpQjhoMmh5?=
 =?utf-8?B?RmRBc0czdldBa0o4V3lCdC81MEFDS2NVSk5HQ21QZGlXK2dyMHJ4QlhZVlMr?=
 =?utf-8?B?Ui92SHZjT1E4RVZzOEpBNmhOUW1tbk9sMmNPY2FIMHFoUVhzL3J5NnNBejRQ?=
 =?utf-8?B?RXcrcDZPenR2N1NTWHdiZXFlM2FnUnlnUm56c3BlMk9mRndYRzEyeUF5WjhH?=
 =?utf-8?B?VnRBRkZ6L3B3UEMyck9WS3BEOVNaOG1iK0RuZ04zVmZUNWo3VWVHc0hJZGFj?=
 =?utf-8?B?UU5XWmlyTGFpZE9yWUF3SEpYTmgxcDZjNVE0RXZYNmt6K2lsRGV2b0ZtYTMv?=
 =?utf-8?B?SEJnWndULzFycjdybS85UDZ6Wi9qUkE0dzFqSEJDcVhMM2lnYWNuTE5KMWVx?=
 =?utf-8?B?NGRmSFN1K2drMHBxTU41ZWNnV3psb1Q4dDFmdlRncGtwOWMzQVRCcVpvM01w?=
 =?utf-8?B?T0wwZkZydmZoK29ZRERWYVY4UUQ4WXRlR240ZGdRb1Y2UnFlRnlkR1c1Wits?=
 =?utf-8?B?dU1qZGpaOTg4TkdNcXFFQVpnRktPSkhvVStKU3RUaDlvem80Q0RQeVBCVzJP?=
 =?utf-8?B?RWhvWW4vOUtyK0hnUlE3QjBzRCsvaTZvb0Vid1FzcmJ1SktjYm1rVGYvdEVE?=
 =?utf-8?B?M2Z3NnFlbi9xL0VvSk5jYTJmTjUva1dRcUdBRllvSDZ2UC9YMUF3RXNybTNW?=
 =?utf-8?B?YlBFRU1Od3krZGk4VzFJalZwdy82M0htTThlOGoyVWNYSjVMTGROVFpFZ0VR?=
 =?utf-8?B?blpTbk1JTkU2eXlydlBKby8zc3dYUzI5QnUrekZBMTFSZmdscElvdlNGRDhx?=
 =?utf-8?B?cUE1SUlOUzdBQ1RvajBURE0xK1dhTnB2cERSMlZ4VWVRM0RURVlvOXFRbE4x?=
 =?utf-8?B?MDFJbGlsMi84NktmaXQyNDRtOHF3MG9EQXJkLzJFcFVwYkhOdjdUbVF2YUxG?=
 =?utf-8?B?aktrRmdvTnVXVzFsUmx5aVVXRmMrcXYvQVUrRWJmUG5PZTB1NWlFVDZVYm1l?=
 =?utf-8?B?bFRsTmYzQ21Qc3g4V3M1OGwzT2QyTlFMeFZ6Skg3NjNQam8yTTd2QTJzZUpp?=
 =?utf-8?B?T1N0ZG9VaEQ5NWRMRmxLTTBqTVk0VDBjZUFsNC9pU1QzL3NQQzRJOHVZSEJs?=
 =?utf-8?B?MEU2bkh6ZmpjSDFMMDJ2OE9Ka0cxV0ZXZTYxbVBsa1hVWHhCRG9Hdzg2ZEwy?=
 =?utf-8?B?ZUJGVFExQmdaQWNUN3JCdXFaOElMb3dPbCsvV2hNYitpcVFoUldVeFY3VWJ0?=
 =?utf-8?B?cFlzTGV3dmlCd1hZVE5yb0F0Mnl3L0Fhb3R2MzNkSzlNWVhTS3BJQXBiQlJ4?=
 =?utf-8?B?MzYwQlpzZkVTTG9OdGRFTkhMc0R0TitIVDNwZWVWaXZ6MlFUR1dVN2xtUUlt?=
 =?utf-8?B?blZscjVUaUdXdXhUclRhSm1WVjhEOWR3VXJ4bGdZOUFHT1M5cm1lRnkrMCt2?=
 =?utf-8?B?ZXZjQ2tQcGpEcDFsVFBwUDZNaldGUFVQOVlNU2FHSURHWGloRHJ1Zm1LNWhs?=
 =?utf-8?B?QlRIMk5HSzh4T1VBRzFtVExTYnBRN3k3OVhTV2Jidk82NjgzQzVIdVVMZTdz?=
 =?utf-8?B?ZEhicWdteVVLSHB1Wm44czFIdlluWGxEOVc0TFpFcTM4WWZja2VhMy9vZXhL?=
 =?utf-8?B?NGttUURIMjlMNlR5WW5Fc3ZoOTlEQnJMUUNJQTh6bHpyZHY3bElJTHZqbWlZ?=
 =?utf-8?B?dzJSZGJCaFhFM05icEVVSnJYM21VbnRJU2xReUp4SjJCNnlFenI5aWExS1J0?=
 =?utf-8?B?TUJNckdaUURhQ2JndTJzaW14Nkk1MlY4TFVGUlhobTUwd2doR3Q5Q2c0VnZp?=
 =?utf-8?B?T1V1d0pRZ2d1ZTM0UFdYd2JydGxwYnJ0aFlKSFBzVUcxUE9BRnJnelJoNFlw?=
 =?utf-8?B?U1h0NUhxeUZ4OXp1RFk5UmNiMjhybW0veTNCSFNESTV5VFJ1ZlZaUGhId0ZR?=
 =?utf-8?B?ZUdNVU1LWlo1WmFSOHZUSVM5MVQvQVBLdHhEdVhrejVQR1djT0FqMncvSmVI?=
 =?utf-8?B?TDhhUVVURUxvYWJReVYzVngyVlE5Y0RmQlJGNFVwUFJ6aVdUbFBaVldrVVFa?=
 =?utf-8?B?ZTJwUmZjSEoweVBZcDRZMnNMNUdPU1NjRHk4TWtxOFNkL3loL3RQWkZjRkVD?=
 =?utf-8?Q?TNRAxWFhmxUHbTm8JM5yfGw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTg0M3BRMUN4ZkZiM0FaK0t2NkdMeHE2U29wcUFDeVp3TnZ5bzRzdUw0V3F0?=
 =?utf-8?B?MXFkZ1RhVjZFK0Y3ZVhvTzdVZTEvQzlUTnRZYWVtR2FVVVBsSENDY0tyU0pT?=
 =?utf-8?B?UXU5MkV1Z0ZGY1M0RjhBSTZYcE05b01BdS82OGI0eXJWcW54VC96VGdKd3NN?=
 =?utf-8?B?YVJVcnd2ZUZnSWJlNzNiNUtzSk15aWV3Vm5velZCSCtkTnlOUWtpaEN4ZzRU?=
 =?utf-8?B?Rm9Dby9GTFZOSzFkWktOS2ljS0ZOOXk5M2hmN2xlUHRPSVJvWTUzeWhzOXhJ?=
 =?utf-8?B?UGllVUNkYkppdS9qUmNacW1tcFJQTXhrZ2lJemN1R3ZPRU0rT0VMQTJma3ZF?=
 =?utf-8?B?dEwwR2dYY3FwSFplZnJkTy80aEhiSGtxbWZVNnZJN0swdGoxR3NtRE9kVWQ5?=
 =?utf-8?B?TEtRMm5yekVmWmlKRklJRkMyL2J0Wllxcnc0KzlYbkFzVkVqSVlWbjN6MkJU?=
 =?utf-8?B?VkFHVW40YkFVVkxlcTNScHByZm9NOUNtUTNuZHZXRkQyb3BRV3NtdTJSb2pU?=
 =?utf-8?B?TkdkTmJVNUs1S21VSlZsNGd6REJvbVNlVDA3U1hCMll0bnByWDFIZVV1TThu?=
 =?utf-8?B?SHdjZDhRSXBXMkhVUnZCN0hIUU8rK1IyakVnWHkvVWMwZXVST1RhdVZONDY3?=
 =?utf-8?B?V1BVL0I5YUdKZUZ0a1JGOFdQWjB4VXRNQ1dPWlczWkRrNHJxQ1dkMksyY3Mv?=
 =?utf-8?B?TGRuK1F2YjJjemJreWRXT0RVRzJWbTJQQndjNzluNkVRcHdZOGQ5emJ5eWk2?=
 =?utf-8?B?YlFmc3VLZnAzV0x4Vm1hL2k1RS9YNldnbVU1OUVtZzh3ZklNcU1Eb2ZvR0Qy?=
 =?utf-8?B?ZXhwN3pmUVFwYXdnb2JLRkxUV25QUFR0N3VSUHBRazZwYjhLak5mVHI4Y2cr?=
 =?utf-8?B?dXRVUytMZi9MejFpZEtMTE5HbzNMS0JsbE1GUXIwQS96c1UweFFBZmJMNGpQ?=
 =?utf-8?B?dnZxZXlnbk1KYmxVaUs5MTd5UDRaaFozNmtNcFZDYTNSNWlkeXhFak0wTWl6?=
 =?utf-8?B?Z2JQME12dTBLWStYVkx0NzRjVVRSd0RsUXY4aXo1TGFWb0hGbnJKOEV4b2Va?=
 =?utf-8?B?eE16MENDaStnUGcrWk01dUgzNjlFRXFLVVpucjRqS0l0K2x6VzR5WXF5bnI1?=
 =?utf-8?B?eThYT1krWEFCT2xaSEp6NmUxU0hJL21jRGplK2NmVGhlTTRZSWZtV1pnM1NJ?=
 =?utf-8?B?dU1OMXJvWjdHYmNSNU91aFVoMmRrMTZ2RlptME0vWHIvMFBRLzlRY2xET0Nw?=
 =?utf-8?B?TjlQdVlCVGlwYTdOS3RJWHBEc0twOTdQbXViR2xjck80SUJwVFA1N0hRNEpx?=
 =?utf-8?B?enYvM0p6TDBaZmVlVS9UYUNBc2dUVXVKRVQyRzVjWTlmblF4Mm5ERWVob3k5?=
 =?utf-8?B?TVRHc0VRUEViemlURzBIck53WFRTM2c3QjFzOVMzVjhxZ2t4VDliVG1xTWVU?=
 =?utf-8?B?NkI4K21XVWJCQXBvS01vZzhGenBHNFlFUkFnMG9KUUZnWml1TEFjVXZlRG9X?=
 =?utf-8?B?RUI5VFJoQUN1VkhpOVpQTFE1ODBDUStzZmN0SmpncXlKSEdtTjNGSmlvMkdz?=
 =?utf-8?B?d21mZXJhTXR4MHE0eHp6M21RQ29qSllZbUc1S3ZpRStSVHZXM0M2NHQ1S2lt?=
 =?utf-8?B?MVVxdFd4YzN0K3dlRTZkc3FuYmVqeHdDQXc1NGVkc0o0OW1VV1QvZXpMM2Nw?=
 =?utf-8?B?by9aMmtRYzJycURuMTRVVTMyYStpZG1qOVZiT0NBdGg5QnRkM3hmakxNMjUy?=
 =?utf-8?B?cWhPMGdSUHlwYVVwbUY4alFNU2hBYXpzNXdYMkh6c3ByZG5RYkdaNExYM1NR?=
 =?utf-8?B?bEZCQUxlekhia1IvV3h1M1E5RmRxdFNENFFaWGxtWEwyNFhuMUlGQklIV240?=
 =?utf-8?B?TGY2M1VkaEdyZTFLYUVnUGk5OWp1T2RxSThyb1drR2pYWURrY0s0VVdJbmNK?=
 =?utf-8?B?M0l2WThZKzJiU2F6a2RPNjdVMWdFOVB2eXFaR1V1TmRjaSsvbmFjeGpyLy9I?=
 =?utf-8?B?Z3Q5NjBReHBsMWNGNjdvd2EyaitNMUVkblA1aHkxaUVCSWJvVUtIQ0xwYzVZ?=
 =?utf-8?B?UXdTcjUraWVBaGM1V3FJNHExUnVjdFZuTnAvSXpaYko3TmJ0ci9CMXJjcS9J?=
 =?utf-8?B?TmZRTjBjQUh0dkhZWW9pZ09qbXE4MmREaGdWNllxYVdmd3orQWR6WndrZW1P?=
 =?utf-8?B?MzlESm5pbjl0WjFsRkpUeUF2VHBQUDNWMXU2eFQ2dGlUNWxtRnJBaVZsbmll?=
 =?utf-8?B?UjZ2Kyt6K080MEhCdm5VYlZaKzFEc1RVY01xck5pVUF1NkxwNTVwR0FWcXB6?=
 =?utf-8?B?T0tabGcwMW5TMVpqOVU1VGZZQWVOclN2V0RZSm9GQk5nYlMvVEtxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C523CF42BC7CF4B91880C30D526750B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bbc336-0f80-478e-f15a-08de58d1cce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 09:45:24.2106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vq+3dhgrqhzA7P2yXcB14l+mUqDm/84UWiSi4SArybxVWUfuofF1FrqLlAPvO/pyj1Y3BTkTBSXa0M3ri2uJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB9034
X-Proofpoint-ORIG-GUID: H3C8mBfCCoF5iXIAShaho2tEGm912Aps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MSBTYWx0ZWRfX+tk84HQCMfjU
 fxKCvufEp4gDLtmG02Xuew/NLvbHYGWh/ZO6EUHZpIPdLOwxruGqnXzyWAGkt5TkRD9u60SudiJ
 +9tKhiawDvNKIw1AjcHWH0WI8ZLg8vA7JB4i/2jjQKjHtl2jyg9f6AHL/P9JIoBZOVMMZqzt/hq
 cyfkJHuzTY1ismY2r5TxDgB1thV6VbU4l3bMuOy233PXvFIKLiMc9WF2Mg5egPPZI/T24xnHXD7
 EtC0mDx3eqCX6hEC+qhqA12B9XzGqSv79C2jfpgV2FXnSBdv12jHigveJS6FC50vyspN+TgXU4Q
 OYZFr6PQQL1nc5EzzcZQNraw3WF/azCGXSaYiZ7A5nDBnEjeEBLYmGqRvixFFXOHTBkhKVhqdQ4
 o4he5+tgC3ExEZwStELQome+qwDMiDtsMtAG0LOt4ajP+8VaZalkiFhGrwrwSSZdZPqNwm1uzJD
 1ZGmfF5Tzpklo0w83Yw==
X-Proofpoint-GUID: H3C8mBfCCoF5iXIAShaho2tEGm912Aps
X-Authority-Analysis: v=2.4 cv=Oe2VzxTY c=1 sm=1 tr=0 ts=6970a037 cx=c_pps
 a=Xk0cAt2nCKMrkR9Vo+L1ow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RQZ_2NmkAAAA:8 a=qm3nO7GJCEGBN0PxYqMA:9 a=QEXdDO2ut3YA:10
 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gT24gMTggU2VwIDIwMjMsIGF0IDEwOjU44oCvUE0sIEpvaG4gTGV2b24gPGxldm9uQG1v
dmVtZW50YXJpYW4ub3JnPiB3cm90ZToNCj4gDQo+IA0KPiBPYnNlcnZlZCB3aXRoIGJhc2Ugb2Yg
cWVtdSA2LjIuMCwgYnV0IGZyb20gY29kZSBpbnNwZWN0aW9uIGl0IGxvb2tzIHRvIG1lIGxpa2UN
Cj4gaXQncyBzdGlsbCBjdXJyZW50IGluIHVwc3RyZWFtIG1hc3Rlci4gQXBvbG9naWVzIGlmIEkg
aGF2ZSBtaXNzZWQgYSBmaXggaW4gdGhpcw0KPiBhcmVhLg0KPiANCj4gU3ltcHRvbTogcnVuIGEg
VUVGSS1ib290ZWQgU0FUQSBDRCBXaW5kb3dzIGluc3RhbGxlci4gV2hlbiBpdCBoaXRzICJMb2Fk
aW5nDQo+IGZpbGVzLi4iIHNjcmVlbiwgcnVuIGFuIGVqZWN0IGUuZy4NCj4gDQo+IHZpcnNoIHFl
bXUtbW9uaXRvci1jb21tYW5kIDY0YzZlMTkwLWVhN2YtNDllMi1iMmQ1LTZiYTE4MTRiMDBhZSAn
eyJleGVjdXRlIjoiZWplY3QiLCAiYXJndW1lbnRzIjogeyAiaWQiOiAic2F0YTAtMC0wIiB9IH0n
DQo+IA0KPiBxZW11IHdpbGwgZ2V0IHN0dWNrIGxpa2Ugc286DQo+IA0KPiBnZGIpIGJ0DQo+ICMw
ICAweDAwMDA3ZjhiYTRiMTYwMzYgaW4gcHBvbGwgKCkgZnJvbSAvbGliNjQvbGliYy5zby42DQo+
ICMxICAweDAwMDA1NjE4MTNjNDhlZDUgaW4gcHBvbGwgKF9fc3M9MHgwLCBfX3RpbWVvdXQ9MHg3
ZmZjYmQ5ODFhNzAsIF9fbmZkcz08b3B0aW1pemVkIG91dD4sIF9fZmRzPTxvcHRpbWl6ZWQgb3V0
PikgYXQgL3Vzci9pbmNsdWRlL2JpdHMvcG9sbDIuaDo2Mg0KPiAjMiAgcWVtdV9wb2xsX25zIChm
ZHM9PG9wdGltaXplZCBvdXQ+LCBuZmRzPTxvcHRpbWl6ZWQgb3V0PiwgdGltZW91dD10aW1lb3V0
QGVudHJ5PTk5OTg5NjEyOCkgYXQgLi4vdXRpbC9xZW11LXRpbWVyLmM6MzQ4DQo+ICMzICAweDAw
MDA1NjE4MTNjMjliZTkgaW4gZmRtb25fcG9sbF93YWl0IChjdHg9MHg1NjE4MTUxNmUwNzAsIHJl
YWR5X2xpc3Q9MHg3ZmZjYmQ5ODFhZjAsIHRpbWVvdXQ9OTk5ODk2MTI4KSBhdCAuLi91dGlsL2Zk
bW9uLXBvbGwuYzo4MA0KPiAjNCAgMHgwMDAwNTYxODEzYzI5N2UxIGluIGFpb19wb2xsIChjdHg9
Y3R4QGVudHJ5PTB4NTYxODE1MTZlMDcwLCBibG9ja2luZz1ibG9ja2luZ0BlbnRyeT10cnVlKSBh
dCAuLi91dGlsL2Fpby1wb3NpeC5jOjYwNw0KPiAjNSAgMHgwMDAwNTYxODEzYWUyZmFkIGluIGJk
cnZfZG9fZHJhaW5lZF9iZWdpbiAocG9sbD10cnVlLCBpZ25vcmVfYmRzX3BhcmVudHM9ZmFsc2Us
IHBhcmVudD0weDAsIHJlY3Vyc2l2ZT1mYWxzZSwgYnM9MHg1NjE4MTUzM2ZjYzApIGF0IC4uL2Js
b2NrL2lvLmM6NDgzDQo+ICM2ICBiZHJ2X2RvX2RyYWluZWRfYmVnaW4gKGJzPTB4NTYxODE1MzNm
Y2MwLCByZWN1cnNpdmU9PG9wdGltaXplZCBvdXQ+LCBwYXJlbnQ9MHgwLCBpZ25vcmVfYmRzX3Bh
cmVudHM9PG9wdGltaXplZCBvdXQ+LCBwb2xsPTxvcHRpbWl6ZWQgb3V0PikgYXQgLi4vYmxvY2sv
aW8uYzo0NDYNCj4gIzcgIDB4MDAwMDU2MTgxM2FkOTk4MiBpbiBibGtfZHJhaW4gKGJsaz0weDU2
MTgxNjFjMWYxMCkgYXQgLi4vYmxvY2svYmxvY2stYmFja2VuZC5jOjE3NDENCj4gIzggIDB4MDAw
MDU2MTgxM2FkOWI4YyBpbiBibGtfcmVtb3ZlX2JzIChibGs9YmxrQGVudHJ5PTB4NTYxODE2MWMx
ZjEwKSBhdCAuLi9ibG9jay9ibG9jay1iYWNrZW5kLmM6ODUyDQo+ICM5ICAweDAwMDA1NjE4MTM4
MmI4YWIgaW4gYmxvY2tkZXZfcmVtb3ZlX21lZGl1bSAoaGFzX2RldmljZT08b3B0aW1pemVkIG91
dD4sIGRldmljZT08b3B0aW1pemVkIG91dD4sIGhhc19pZD08b3B0aW1pemVkIG91dD4sIGlkPTxv
cHRpbWl6ZWQgb3V0PiwgZXJycD0weDdmZmNiZDk4MWM3OCkgYXQgLi4vYmxvY2svcWFwaS1zeXNl
bXUuYzoyMzINCj4gIzEwIDB4MDAwMDU2MTgxMzgyYmZiMSBpbiBxbXBfZWplY3QgKGhhc19kZXZp
Y2U9PG9wdGltaXplZCBvdXQ+LCBkZXZpY2U9MHgwLCBoYXNfaWQ9PG9wdGltaXplZCBvdXQ+LCBp
ZD0weDU2MTgxNWU2ZWZlMCAic2F0YTAtMC0wIiwgaGFzX2ZvcmNlPTxvcHRpbWl6ZWQgb3V0Piwg
Zm9yY2U9PG9wdGltaXplZCBvdXQ+LCBlcnJwPTB4N2ZmY2JkOTgxYzc4KSBhdCAuLi9ibG9jay9x
YXBpLXN5c2VtdS5jOjQ1DQo+IA0KPiBXZSBhcmUgc3R1Y2sgZm9yZXZlciBoZXJlOg0KPiANCj4g
MzUxIHN0YXRpYyB2b2lkIGJkcnZfZG9fZHJhaW5lZF9iZWdpbihCbG9ja0RyaXZlclN0YXRlICpi
cywgQmRydkNoaWxkICpwYXJlbnQsDQo+IDM1MiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBwb2xsKQ0KPiAuLi4NCj4gMzgwICAgICBpZiAocG9sbCkgew0KPiAzODEgICAg
ICAgICBCRFJWX1BPTExfV0hJTEUoYnMsIGJkcnZfZHJhaW5fcG9sbF90b3BfbGV2ZWwoYnMsIHBh
cmVudCkpOw0KPiAzODIgICAgIH0NCj4gDQo+IEJlY2F1c2UgdGhlIGJsayByb290J3MgLT5pbl9m
bGlnaHQgaXMgMSwgYXMgdGVzdGVkIGJ5IHRoZSBjb25kaXRpb24NCj4gYmxrX3Jvb3RfZHJhaW5l
ZF9wb2xsKCkuDQo+IA0KPiANCj4gT3VyIGJsay0+aW5fZmxpZ2h0IHVzZXIgaXMgc3R1Y2sgaGVy
ZToNCj4gDQo+IDEyOTggc3RhdGljIHZvaWQgY29yb3V0aW5lX2ZuIGJsa193YWl0X3doaWxlX2Ry
YWluZWQoQmxvY2tCYWNrZW5kICpibGspDQo+IC4uLg0KPiAxMzEwICAgICAgICAgYmxrX2RlY19p
bl9mbGlnaHQoYmxrKTsNCj4gMTMxMSAgICAgICAgIHFlbXVfY29fcXVldWVfd2FpdCgmYmxrLT5x
dWV1ZWRfcmVxdWVzdHMsICZibGstPnF1ZXVlZF9yZXF1ZXN0c19sb2NrKTsNCj4gMTMxMiAgICAg
ICAgIGJsa19pbmNfaW5fZmxpZ2h0KGJsayk7DQo+IA0KPiBOb3RlIHRoYXQgYmVmb3JlIGVudGVy
aW5nIHRoaXMgc3RhbnphLCBibGstPmluX2ZsaWdodCB3YXMgMi4gVGhpcyB0dXJucyBvdXQgdG8N
Cj4gYmUgZHVlIHRvIHRoZSBpZGUgYXRhcGkgY29kZS4gSW4gcGFydGljdWxhciwgdGhlIGd1ZXN0
IFZNIGlzIGdlbmVyYXRpbmcgbG90cyBvZg0KPiByZWFkIEkvTy4gVGhlICJmaXJzdCBJTyIgYXJy
aXZlcyBpbnRvIGJsayB2aWE6DQo+IA0KPiBjZF9yZWFkX3NlY3RvcigpLT5pZGVfYnVmZmVyZWRf
cmVhZHYoKS0+YmxrX2Fpb19wcmVhZHYoKQ0KPiANCj4gVGhpcyBpbml0aWFsIElPIGNvbXBsZXRl
czoNCj4gDQo+IGJsa19haW9fcmVhZF9lbnRyeSgpLT5ibGtfYWlvX2NvbXBsZXRlKCkNCj4gDQo+
IDE1NjAgc3RhdGljIHZvaWQgYmxrX2Fpb19jb21wbGV0ZShCbGtBaW9FbUFJT0NCICphY2IpDQo+
IDE1NjEgew0KPiAxNTYyICAgICBpZiAoYWNiLT5oYXNfcmV0dXJuZWQpIHsNCj4gMTU2MyAgICAg
ICAgIGFjYi0+Y29tbW9uLmNiKGFjYi0+Y29tbW9uLm9wYXF1ZSwgYWNiLT5yd2NvLnJldCk7DQo+
IDE1NjQgICAgICAgICBibGtfZGVjX2luX2ZsaWdodChhY2ItPnJ3Y28uYmxrKTsNCj4gMTU2NSAg
ICAgICAgIHFlbXVfYWlvX3VucmVmKGFjYik7DQo+IDE1NjYgICAgIH0NCj4gMTU2NyB9DQo+IA0K
PiBMaW5lIDE1NjQgaXMgd2hhdCB3ZSBuZWVkIHRvIG1vdmUgYmxrLT5pbl9mbGlnaHQgZG93biB0
byB6ZXJvLCBidXQgdGhhdCBpcyBuZXZlcg0KPiByZWFjaGVkISBUaGlzIGlzIGJlY2F1c2Ugb2Yg
d2hhdCBoYXBwZW5zIGF0IDoxNTYzDQo+IA0KPiBhY20tPmNvbW1vbi5jYigpLT5jZF9yZWFkX3Nl
Y3Rvcl9jYigpLT5pZGVfYXRhcGlfY21kX3JlcGx5X2VuZCgpLT5jZF9yZWFkX3NlY3Rvcl9zeW5j
KCktPmJsa19wcmVhZCgpDQo+IA0KPiBUaGF0IGlzLCB0aGUgSU8gY2FsbGJhY2sgaW4gdGhlIGF0
YXBpIGNvZGUgaXRzZWxmIHRyaWdnZXJzIG1vcmUgLSBzeW5jaHJvbm91cyAtIElPLg0KPiANCj4g
SW4gdGhlIG1lYW50aW1lLCB3ZSBzdGFydCBwcm9jZXNzaW5nIHRoZSBibGtfZHJhaW4oKSBjb2Rl
LCBzbyBieSB0aGUgdGltZSB0aGlzDQo+IGJsa19wcmVhZCgpIGFjdHVhbGx5IGdldHMgaGFuZGxl
ZCwgcXVpZXNjZSBpcyBzZXQsIGFuZCB3ZSBnZXQgc3R1Y2sgaW4gdGhlDQo+IGJsa193YWl0X3do
aWxlX2RyYWluZWQoKS4NCj4gDQo+IEkgZG9uJ3Qga25vdyB0aGUgcWVtdSBibG9jayBzdGFjayB3
ZWxsIGVub3VnaCB0byBwcm9wb3NlIGFuIGFjdHVhbCBmaXguDQo+IA0KPiBFeHBlcmltZW50YWxs
eSwgd2FpdGluZyBmb3IgLT5pbl9mbGlnaHQgdG8gZHJvcCB0byB6ZXJvICpiZWZvcmUqIHdlIHF1
aWVzY2UgaW4NCj4gYmxrX3JlbW92ZV9icygpIHZpYSBhbiBBSU9fV0FJVF9XSElMRSgpIGF2b2lk
cyB0aGUgc3ltcHRvbSwgYnV0IEknbSBwcmV0dHkgc3VyZQ0KPiB0aGF0J3MganVzdCBhIGJhbmQt
YWlkIGluc3RlYWQgb2YgZml4aW5nIHRoZSBkZWFkbG9jay4NCj4gDQo+IEFueSBzdWdnZXN0aW9u
cy9jbHVlcy90aG91Z2h0cz8NCj4gDQo+IHRoYW5rcw0KPiBqb2huDQo+IA0KPiANCg0KSGkgS2V2
aW4sIEhhbm5hLiANCg0KRGlkIHdlIGV2ZXIgZW5kIHVwIGZpeGluZyB0aGlzPyBJIGFtIHNlZWlu
ZyBhIHNpbWlsYXIgZGVhZGxvY2ssIG9uIFFFTVUgOS4xLjAsIHdoZW4gbWlncmF0aW5nIHRoZSBz
YW1lIGtpbmQgb2YgVk0gZGVzY3JpYmVkIG9yaWdpbmFsbHkuIER1ZSB0byB0aGUgZGVhZGxvY2ss
IHRoZSBWTSBvbiB0aGUgc291cmNlIGdvZXMgaW50byBhIHBhdXNlZCBzdGF0ZSwgYW5kIHN0YXlz
IHRoZXJlIGluZGVmaW5pdGVseS4NCg0KUUVNVSBiYWNrdHJhY2U6DQpUaHJlYWQgMTQgKFRocmVh
ZCAweDdmYzA3ZTdkNzY0MCAoTFdQIDY5Mzc0NykgIm1pZy9zcmMvbWFpbiIpOg0KIzAgIDB4MDAw
MDdmYzA4NzMwMWZjZSBpbiBwcG9sbCAoKSBmcm9tIHRhcmdldDovbGliLy4uL2xpYjY0L2xpYmMu
c28uNg0KIzEgIDB4MDAwMDU2MjRjMDdlY2I2MyBpbiBxZW11X3BvbGxfbnMgKGZkcz0weDdmYmU0
NDExOGY5MCwgdGltZW91dD08b3B0aW1pemVkIG91dD4sIG5mZHM9PG9wdGltaXplZCBvdXQ+KSBh
dCAuLi91dGlsL3FlbXUtdGltZXIuYzozMzkNCiMyICBmZG1vbl9wb2xsX3dhaXQgKGN0eD0weDU2
MjRkN2ZlYTkwMCwgcmVhZHlfbGlzdD0weDdmYzA4NDA0N2Y3OCwgdGltZW91dD08b3B0aW1pemVk
IG91dD4pIGF0IC4uL3V0aWwvZmRtb24tcG9sbC5jOjc5DQojMyAgMHgwMDAwNTYyNGMwN2ViZGI3
IGluIGFpb19wb2xsIChjdHg9MHg1NjI0ZDdmZWE5MDAsIGJsb2NraW5nPTxvcHRpbWl6ZWQgb3V0
PikgYXQgLi4vdXRpbC9haW8tcG9zaXguYzo2NzANCiM0ICAweDAwMDA1NjI0YzA0ZjViMDMgaW4g
YmRydl9kcmFpbl9hbGxfYmVnaW4gKCkgYXQgLi4vYmxvY2svaW8uYzo1MzENCiM1ICAweDAwMDA1
NjI0YzAxM2Y3YWIgaW4gYmRydl9kcmFpbl9hbGwgKCkgYXQgLi4vYmxvY2svaW8uYzo1NzYNCiM2
ICBkb192bV9zdG9wIChzdGF0ZT08b3B0aW1pemVkIG91dD4sIHNlbmRfc3RvcD10cnVlKSBhdCAu
Li9zeXN0ZW0vY3B1cy5jOjMwOA0KIzcgIDB4MDAwMDU2MjRjMDE0MGViZCBpbiB2bV9zdG9wIChz
dGF0ZT08b3B0aW1pemVkIG91dD4pIGF0IC4uL3N5c3RlbS9jcHVzLmM6NzE1DQojOCAgdm1fc3Rv
cF9mb3JjZV9zdGF0ZSAoc3RhdGU9PG9wdGltaXplZCBvdXQ+KSBhdCAuLi9zeXN0ZW0vY3B1cy5j
Ojc4NA0KIzkgIDB4MDAwMDU2MjRjMDE4N2U4ZSBpbiBtaWdyYXRpb25fc3RvcF92bSAocz0weDU2
MjRkN2ZjNjQ5MCwgc3RhdGU9UlVOX1NUQVRFX0ZJTklTSF9NSUdSQVRFKSBhdCAuLi9taWdyYXRp
b24vbWlncmF0aW9uLmM6MjQzDQojMTAgbWlncmF0aW9uX2NvbXBsZXRpb25fcHJlY29weSAocz0w
eDU2MjRkN2ZjNjQ5MCwgY3VycmVudF9hY3RpdmVfc3RhdGU9PG9wdGltaXplZCBvdXQ+KSBhdCAu
Li9taWdyYXRpb24vbWlncmF0aW9uLmM6Mjc0Nw0KIzExIG1pZ3JhdGlvbl9jb21wbGV0aW9uIChz
PTB4NTYyNGQ3ZmM2NDkwKSBhdCAuLi9taWdyYXRpb24vbWlncmF0aW9uLmM6MjgwMQ0KIzEyIG1p
Z3JhdGlvbl9pdGVyYXRpb25fcnVuIChzPTB4NTYyNGQ3ZmM2NDkwKSBhdCAuLi9taWdyYXRpb24v
bWlncmF0aW9uLmM6MzI0Ng0KIzEzIG1pZ3JhdGlvbl90aHJlYWQgKG9wYXF1ZT0weDU2MjRkN2Zj
NjQ5MCkgYXQgLi4vbWlncmF0aW9uL21pZ3JhdGlvbi5jOjM1MTcNCiMxNCAweDAwMDA1NjI0YzA3
ZjBiYWEgaW4gcWVtdV90aHJlYWRfc3RhcnQgKGFyZ3M9MHg1NjI0ZDgyZDdiYzApIGF0IC4uL3V0
aWwvcWVtdS10aHJlYWQtcG9zaXguYzo1NDMNCiMxNSAweDAwMDA3ZmMwODcyOGExOWEgaW4gc3Rh
cnRfdGhyZWFkICgpIGZyb20gdGFyZ2V0Oi9saWIvLi4vbGliNjQvbGliYy5zby42DQojMTYgMHgw
MDAwN2ZjMDg3MzBlM2Y0IGluIGNsb25lICgpIGZyb20gdGFyZ2V0Oi9saWIvLi4vbGliNjQvbGli
Yy5zby42DQoNClRoZSByZXN0IG9mIHRoZSBzeW1wdG9tcyBhcmUgcHJldHR5IG11Y2ggc2FtZSBh
cyB0aGUgb3JpZ2luYWwgdGhyZWFkLiBUaGUgb25seSBkaWZmZXJlbmNlIHRoaXMgdGltZSBiZWlu
ZyB0aGUgZmFjdCB0aGF0IHRoZSBkZWFkbG9jayBoaXR0aW5nIGluIHRoZSBtaWdyYXRpb24gdXNl
LWNhc2UuDQoNCkkgd2FzIHdvbmRlcmluZyBpZiBpdHMgZmVhc2libGUgdG8gaW50cm9kdWNlIGEg
d29ya2Fyb3VuZCBsaWtlIHRoaXM/IEVzc2VudGlhbGx5LCB3YWl0aW5nIGZvciBhbGwgaW4tZmxp
Z2h0IElPcyB0byBmaW5pc2ggKmp1c3QqIGJlZm9yZSB3ZSBlbmFibGUgcXVpZXNjaW5nLiBTb21l
dGhpbmcgbGlrZTogDQoNCmRpZmYgLS1naXQgYS9ibG9jay9ibG9jay1iYWNrZW5kLmMgYi9ibG9j
ay9ibG9jay1iYWNrZW5kLmMNCmluZGV4IGJhN2RjNDQ5OTguLjQ1OTliZDQ4ZjIgMTAwNjQ0DQot
LS0gYS9ibG9jay9ibG9jay1iYWNrZW5kLmMNCisrKyBiL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYw0K
QEAgLTI4MjIsNiArMjgyMiw5IEBAIHN0YXRpYyB2b2lkIGJsa19yb290X2RyYWluZWRfYmVnaW4o
QmRydkNoaWxkICpjaGlsZCkNCiAgICAgQmxvY2tCYWNrZW5kICpibGsgPSBjaGlsZC0+b3BhcXVl
Ow0KICAgICBUaHJvdHRsZUdyb3VwTWVtYmVyICp0Z20gPSAmYmxrLT5wdWJsaWMudGhyb3R0bGVf
Z3JvdXBfbWVtYmVyOw0KKyAgICBBSU9fV0FJVF9XSElMRShibGtfZ2V0X2Fpb19jb250ZXh0KGJs
ayksDQorICAgICAgICAgICAgICAgICAgIHFhdG9taWNfbG9hZF9hY3F1aXJlKCZibGstPmluX2Zs
aWdodCkgPiAwKTsNCisNCiAgICAgaWYgKHFhdG9taWNfZmV0Y2hfaW5jKCZibGstPnF1aWVzY2Vf
Y291bnRlcikgPT0gMCkgew0KICAgICAgICAgaWYgKGJsay0+ZGV2X29wcyAmJiBibGstPmRldl9v
cHMtPmRyYWluZWRfYmVnaW4pIHsNCiAgICAgICAgICAgICBibGstPmRldl9vcHMtPmRyYWluZWRf
YmVnaW4oYmxrLT5kZXZfb3BhcXVlKTsgDQoNClRob3VnaHRzPyANCg0KDQpSZWdhcmRzLA0KVGVq
dXMNCg0K

