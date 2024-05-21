Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C64C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIE-0000Tq-7k; Tue, 21 May 2024 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHZ-0007kT-GX
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:58 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0001an-HI
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297114; x=1747833114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=F9597oN4TImrsU5O420IR4+7xZpXTaUNA2KVmchYngs=;
 b=GUr+7l3HIkFKwoAa1OjYF8Ezs14F6OVIOpkeLEJvdQD9qJyXMHFGI9kb
 ucewf97aJ8IMGYj2kgrcTSiP9HeItOk/cY+9oSoHzwfo6ra05zvzSQTpI
 Z2z03HvaXcaA8f8O6n8xaPr4FFoP3IaCrzT1uxpbvhe2SvDE8TTFRlNF+
 QJOwt+dWdSr7PqFwEPK35ZrYc2slCiPMXINEdVRUSuOCgGIJ86a2Apayk
 JOMeM280ySLYAmxLelI2NUBcIUmPN+HtQuS6sQbPftzVl45h0L2o1OU4Y
 MIJxmh1FdMokwQI69E1yay+Cnsf6MGDm/Vc6rIEM6OJT3ruEKY06DFHA5 w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061511"
X-MGA-submission: =?us-ascii?q?MDHgTBEcqe9PCFFeD7O+RCuGI/MhRbsSodYDDE?=
 =?us-ascii?q?Pfm+Xbt8xtA6pspqnXJt1s2j7dSb8bBS42m6BkAwGrDZhGDczf3KRdzw?=
 =?us-ascii?q?z3qRTZUGljqD/ERg5ygW/REjZ2HV71eTOGgTa/UqzeWg24FvkGYVy6oj?=
 =?us-ascii?q?N+sGsYnzlVTVXj/MeZctvpQg=3D=3D?=
Received: from mail-dbaeur03lp2168.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.168])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBY4kLXqi2x1kwk0PWr7Zdga7gGtTXx+6ve8+Z60JVf+7hE/uYjsOo7O5mCXeugjBiHwZIHrddOr8/B6R1772GsCVjUaAgFCReXWxgtrb4N0gC9hpMw3qIqZemY5yENaIOFPNWgtk0OftvqKxE0e5F4O0+0zj7IekxEZFtDzzYhf9RFEgVOzBeVn350BUzoC9zJoBrQJs6YQT5Fh0rcZIDBITmTGfn4+0Bl6cD0Ddbs4dSrTKDGMC/s91B0Rb0gHcmd9SZIuAxsZp5YJdtIdPzdFXa4ldMu9ezrNUSWQI+zT/mDCXrUPqztQ+GuzpnC6ryHALpYp+VB+8omVlSFM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9597oN4TImrsU5O420IR4+7xZpXTaUNA2KVmchYngs=;
 b=ZIHIlT/UTmq72PnO2P15Iof4OtcKdZ/KCFCaCPu5ue9CD1+1jYL3zdKKESwfEGt4o4vbIGCgnbrsrYy2J1/OE70iG6J5+ZB1IZg2rgkbDMbWICCveoj9sKNQlU4LE7u45mwi7eb6BbVm3frpru7zTmt9xAFoUq+I9xYjeZpyJoD2qonbPA99/hhz/L6+P4KjpxKIgdDA60O6UNX3kKqLULoR+3CAW/bPaKl3Xd1ZOr/r5tkOASFmwJ4d7BLIr54FfnRSOqkmnpUBxALsLAL2hrFn/fFO1h5YRtDr8GEq6Cyze1+kSA94klRhdb8/e6uGuNYR4K97DO24gzVa6njXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 16/22] intel_iommu: fill the PASID field when creating
 an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd 16/22] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHaq4BwdWnqJ2m6gkm86Rsix4ClAA==
Date: Tue, 21 May 2024 13:11:49 +0000
Message-ID: <20240521130946.117849-17-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: 90b40d72-9a25-4326-7053-08dc79979314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WU5qVTJ1aEpmT1czemRDZ3d0VHllVk9McjJTSTYwTm4xN2pNU0VOL3FYQTAx?=
 =?utf-8?B?OC9rMkpVY214VkdiYWxCQ2NXZVk3SnR5Kzh0R0E0dTZPOWc5MnNsS2c4dUsy?=
 =?utf-8?B?dWE1a1BvMytRZlJka1dsMFNva3ZJQWIyZWMrM2RFRnBESUZibnpIbGN1NFZa?=
 =?utf-8?B?aHVmTFNqOU9QMzdjVFREWU82UzYvbXA4L2ROOTRPZEhlcnVYR1NjVDB1Vnoy?=
 =?utf-8?B?cjFuenFXWlcrUHdGMjNsdGZwbjNjcm5VcXZoYzAxTWMxVUZGL1NtaG1MWWtj?=
 =?utf-8?B?TDZ5VEliVENNY2grbGhNN3k0dXVERlgrRzQvMG9INWdUVkI5Rm1oL3JTZ25M?=
 =?utf-8?B?V1plMFFEdk43VVREOCtDSkcwRFVISm9rK1ZyTExNOWRCN3AvdjZLSTliVExy?=
 =?utf-8?B?MUIxL3UrTE5wT0QzTnBkb1BlMWVudUFVVm9VWVJRdmZqdnhWUktrMUtjNzZ6?=
 =?utf-8?B?UGR2ZGdxTjJRVFFEdDF0TU9IQ25PZGhEUE5HcjEwbTRiMjJUUStIRzU1NkF4?=
 =?utf-8?B?a2dicnQ2cy9HeTBjUFp1UkNjU2hlNEVxYVVGRXc1bHQva250WG1YZzZ2R29E?=
 =?utf-8?B?QXJTTHo5TkE3K2ZBbThmbW15TUhHWHE1U0pkVHdDV0h0RVV4SnBFK3EwL2F6?=
 =?utf-8?B?T2ZCYytMRU5CYTl6QkFmS04rVHNmZ3FFanB2U3c2Rm1uOTh4YkxuT3kxWDZn?=
 =?utf-8?B?T3Z0SExxNzI5eTNEMWdLYjBrTHlhQUhYWTVRVmdYSkJFZWV0dk1FNDdtSXdY?=
 =?utf-8?B?NGFnc2NzQzQwNTJsd3FZQkNZNXNuMG1Xc0VpSWtucEpjSDZvdkJ3MitlMk5K?=
 =?utf-8?B?eTY4SkFYNnRPWTBHL3FKTWUvYTBUU2NiNkMvNkNtWEtMV0VQWHYzY2wzRHQ3?=
 =?utf-8?B?ZUVQZWZ6WTVXMFI3cmw1Tmp2elVYWGtrQVFtcVgrbUFCUm04WVhXRjJWMWRT?=
 =?utf-8?B?RXUzWlU5dGVpZStIelg0NGU5WXhFaEtlMXYxMXRYazMxak8wRm54NzVIV29R?=
 =?utf-8?B?ODNaRFdPbUROUmRIbThuYkkweUc2enZnQ3QxeVg1bXJYbTRrdUFCNktZSElo?=
 =?utf-8?B?eTJTNFpyanRCMzdFLzBUSkhJS2tVRkx1cHdGdHAxeGhVZ2hMSGJ3dllXWUV0?=
 =?utf-8?B?T2djQ29kK0tsRWNZSFVleS92SU10ejRTMXdYUnJtTEEwNlVtYzhKWVVWYmZ6?=
 =?utf-8?B?YVZrOXpLNjh0djMxMjZxVkdKRmJzcHNsWnd1RmdEcTR4anE5am93YWdJbC9Q?=
 =?utf-8?B?WTYvN1M4MnhZaHZlRy91dTlnU20wbU9Pb3hnSk9WZGJHelNNa3YxYnZpRitQ?=
 =?utf-8?B?NytiMWVYRmxqVFlGUmZKSFRZdGJtODlmbElKTGN5L0ZidXZ3d2xjVW1FeWY0?=
 =?utf-8?B?cDVFdStzNVFvLzRSQVJCeGhtcUxUZUhpYTRiRysxZTNhTlNvWGp5azJ0N1BE?=
 =?utf-8?B?ck0zbnpoblhtcEFCcE5ZV09JTnZRY3BjVzZQMmc0b0pvaGh6bmd0cEdBdEF1?=
 =?utf-8?B?MU5yZ1g4UXdlSXdEckswL3hMTGlsaVFMRk41NEtpQncySDFZYU9NZ3ZsUXBH?=
 =?utf-8?B?UytMbHYzUDlpOFpSUi8vRjd0ZmVjUElWWEdrYUpJV01BWkNXZDZqVTFzVS9o?=
 =?utf-8?B?QUJwYkdVOEp1NG1xbFJvelN0dXh5dVJXMFpWSlIyL1JWWGFSeHg1NHRlcW5H?=
 =?utf-8?B?aHVxZGxqWnJraHQyd0V6RmlNZTNBOTJacVlFeFhFSXpaNGZpaHZXS2FVTkVs?=
 =?utf-8?B?Vk1DNDFLZGRVWlAwUFFZYW8yNnJVY21TUXBoWmdIT0NhWWpMUGU5SDhXcGQz?=
 =?utf-8?B?OWZORjdkZEs0TjNubWZhZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlhqZHVjSk9sNElsMkJ1UVZQSEs1SUZmS2t2U0YvdmNKNEV0VFhjMGRmUXFq?=
 =?utf-8?B?WGNzcnhoQUJ0TlpYeHFUSHVTVkRYRUhMcmxMeVdzR0hLRXlsQzhrd1R2Z0p0?=
 =?utf-8?B?bmE1d0NWVXczYmVKWGdJaGg1akc1dDBFbzlyd1lYSTVobXQ0dmRWeU1CWkdH?=
 =?utf-8?B?Q3NqL2dyOTRudDQxSlAxS3c0MWV3bHVQYTB0bUhCZWFyenVSaE1IUWo5VGNm?=
 =?utf-8?B?c1NNQm5NZ2FqSXNlNG1ueHJla3B6bVVtSnlEZjFBcUh0bExzVGFPbTNhYXFZ?=
 =?utf-8?B?aTlwclU2NzIxSkVyQkx5L29WR3k3ZzdhdlRQNkxOdjdZNVRhT2c4K1VFOThG?=
 =?utf-8?B?aWVpajQyVTdQekZ1dTNhMzhXR0xOK2g2K0FaSitBenlvTXRFM1B6M0Vrd20w?=
 =?utf-8?B?VzVlb2hFLzVYNitkaWs4N3VIdEVQRWtoRGJ5ZnFKS3d4WERleUtqRUduR2NY?=
 =?utf-8?B?NGxYY0UwWFZKQm45c0k5bENoeklMUnNHU25RN1RNRXpiZDdJR29yK2hIcFR0?=
 =?utf-8?B?NS94Z0tTaml5dU5MSDlMbUhaTnNVNEpkaDZacDNqZ0RzSmxJTFFlUWxDSmEr?=
 =?utf-8?B?bXRwRmNFNDk4NjlSaWd5b1ZLMmJKR3R6NzNlLzQwUlM1S0dlL3ZYZ3RaTUlZ?=
 =?utf-8?B?cnBtVVVFMnVEcFZDaC9aOTdaNWR0WnE2MW1pQ2I0VFRHN2VOc1dnZU9tY0Nj?=
 =?utf-8?B?dTEyZU1FZEdKS1ZldVlUNlpnUjdHOXQwaFY5MjdiU3hjYzhTaHZmMXM1YnAv?=
 =?utf-8?B?Vk1jZ0E4UVJoTFhxN0dZOW1paGtXdkZOaTcydEZ6eCthY29RU1ZmeDR6bXg0?=
 =?utf-8?B?QTh6NTV4blNzVEZQZ0NLa0wyWk9xK2JpL044NHRDZk55RHVmWU14bzk2ZU5o?=
 =?utf-8?B?REQ5Qm94VWdZUHg4aVBDVUxwL3ZlOG5ZU0UvNUZTUkZ0SDZDbmFvT053OFpv?=
 =?utf-8?B?RXBKTm1HSllVNjdaUHlxbHlWdkJKTFRGVExmVXAxWTNWbXgxQUtKUGJYckZq?=
 =?utf-8?B?RThHL3kxcnd3cTRPb3QrcVU2YmFzUWxmVTFLeEFpSHlabFJnTnhkOFdBTG9E?=
 =?utf-8?B?QXRQMml4eDQ0UFdtN3YzYUVDeGlrbjliNFZVTm01R29rRTZQUzFDTlZvdGFT?=
 =?utf-8?B?Z29kZ0VQd3ZrdGI3WUpFbmh2aFZtWnZjYUQ2anJjTTEyNXAvVnNYc3BPMDBX?=
 =?utf-8?B?YzFQVXcrWTNwcjBrbmtyb1B1VzJOZGV3N2IwbW9qQ1c0TE5sZEs4WVpDcTRC?=
 =?utf-8?B?MFp0SzNvYjVFMmdINVJmQXZMZ1I0R2hacEkvOGlNTVpXZEw3ZlphcnpJdWxH?=
 =?utf-8?B?VTEyaEhjSHhwL0s1cGJ3K3dqOVU5VEg5dGNtNUNtU1R1Vks4clRXQW1QSjNR?=
 =?utf-8?B?aDN2cnM0b1hWb2JJUDZBdWtDelJZS0JwZGxSYTJDVFk5RFVXdldrQXJyU1k2?=
 =?utf-8?B?Y016R08xTUFEMUZuRW9DRXlzdjg2VHpiWTdsUWU5TnNBRkRWa2NVMi9zNGN3?=
 =?utf-8?B?RUpURjRoTm5HaUJtd0lJZVlVWDRVbVJOYVRLMURzUzF2cWZCeXBGWHZoWDh1?=
 =?utf-8?B?WUpTUWhvQ01wd3dNbGFMQlQ2NG9kd1EwcmUwcHhEWGZTd2Z5WUZzNzVmWi9P?=
 =?utf-8?B?cmhHSFcyN1RvTlBSRjduekxBWmlrUjNHSVY4RDJmZjg4TVRnYXZ1SHpxQlFG?=
 =?utf-8?B?anAwaWFsWlhvMWVRZ3E5STM3d29UMVZNVHhRMEFlTURxTzVLanVrS1RmYjF6?=
 =?utf-8?B?cWZpaHpBNWtpR2NyUjVRQVdxcDBmRy9wanNoZTJOMVZHWHlEcVRIS1RNazJH?=
 =?utf-8?B?WTI3WkVTQ3J4akg2ZU5IRGJGYnRFb3Q1MTBsT3BvZjVjWU1ZMG1PTkdPRUIw?=
 =?utf-8?B?ZFI4OEZqOWVPczMrcEZjYkVUN3FLZWI2TWJ2QlE1dUkyaHBhK0hWMGthNk90?=
 =?utf-8?B?QU9PM3h5Z1hGT29uZnFWam4zc1FkQlArZ1VUYWljOHpTdTJVL3lHWkV3RjBG?=
 =?utf-8?B?ZDBNenYvWlJNK2x2ZEpsUy96RVVHZ1RzQnpUMXcxVCtxTzlDSEs0YzloWm43?=
 =?utf-8?B?cUVkUFY3RTRtRWNHeVZMOXFKb2ZaZFkwTFExN3ZBbC8xMlB0RXVoOUhRcEph?=
 =?utf-8?B?TEp3a1NaeVJ1WmUrT291L0VwQ3ZnMkRmYWZ6dHl5eS9SY0xaNkxVUjNhUFJz?=
 =?utf-8?Q?2Sz5vfPyFDOnlDUgzrrLiYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D940B8BED9454AA5FAC6F3C26FA2BE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b40d72-9a25-4326-7053-08dc79979314
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:49.4174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny3WKEyqcowag4vLq5X2BSYhBS39ZI65jiPi0CCFlb5ZwLRWuxZ//l9RctFjIZNh91cMIRL2ycoanOzrsWGnE5kcIoAKmP0XY4PyRlGni9EENI4tyzD2Dr2qpmXc0Vet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA5ICsrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggYTQyOTM4YWFj
ZC4uZjA4YzNlOGYwMCAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtMjE4Nyw2ICsyMTg3LDkgQEAgc3RhdGljIGJvb2wg
dnRkX2RvX2lvbW11X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpi
dXMsDQogDQogICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KIA0KKyAgICAvKiBmaWxsIHRoZSBwYXNp
ZCBiZWZvcmUgZ2V0dGluZyByaWQycGFzaWQgKi8NCisgICAgZW50cnktPnBhc2lkID0gcGFzaWQ7
DQorDQogICAgIGNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRyeTsNCiANCiAg
ICAgLyogVHJ5IHRvIGZldGNoIHB0ZSBmb3JtIElPVExCLCB3ZSBkb24ndCBuZWVkIFJJRDJQQVNJ
RCBsb2dpYyAqLw0KQEAgLTIzMDQsNiArMjMwNyw3IEBAIG91dDoNCiAgICAgZW50cnktPnRyYW5z
bGF0ZWRfYWRkciA9IHZ0ZF9nZXRfcHRlX2FkZHIocHRlLCBzLT5hd19iaXRzKSAmIHBhZ2VfbWFz
azsNCiAgICAgZW50cnktPmFkZHJfbWFzayA9IH5wYWdlX21hc2s7DQogICAgIGVudHJ5LT5wZXJt
ID0gYWNjZXNzX2ZsYWdzOw0KKyAgICAvKiBwYXNpZCBhbHJlYWR5IHNldCAqLw0KICAgICByZXR1
cm4gdHJ1ZTsNCiANCiBlcnJvcjoNCkBAIC0yMzEyLDYgKzIzMTYsNyBAQCBlcnJvcjoNCiAgICAg
ZW50cnktPnRyYW5zbGF0ZWRfYWRkciA9IDA7DQogICAgIGVudHJ5LT5hZGRyX21hc2sgPSAwOw0K
ICAgICBlbnRyeS0+cGVybSA9IElPTU1VX05PTkU7DQorICAgIGVudHJ5LT5wYXNpZCA9IFBDSV9O
T19QQVNJRDsNCiAgICAgcmV0dXJuIGZhbHNlOw0KIH0NCiANCkBAIC0zNjczLDYgKzM2NzgsNyBA
QCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUg
KnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCiAgICAgICAgICAgICBldmVudC5lbnRyeS50YXJnZXRf
YXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQogICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92
YSA9IGFkZHI7DQogICAgICAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQor
ICAgICAgICAgICAgZXZlbnQuZW50cnkucGFzaWQgPSBwYXNpZDsNCiAgICAgICAgICAgICBldmVu
dC5lbnRyeS5hZGRyX21hc2sgPSBzaXplIC0gMTsNCiAgICAgICAgICAgICBldmVudC5lbnRyeS50
cmFuc2xhdGVkX2FkZHIgPSAwOw0KICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lv
bW11KCZ2dGRfYXMtPmlvbW11LCAwLCBldmVudCk7DQpAQCAtNDMyMCw2ICs0MzI2LDcgQEAgc3Rh
dGljIHZvaWQgZG9faW52YWxpZGF0ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rl
dl9hcywNCiAgICAgZXZlbnQuZW50cnkuaW92YSA9IGFkZHI7DQogICAgIGV2ZW50LmVudHJ5LnBl
cm0gPSBJT01NVV9OT05FOw0KICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0K
KyAgICBldmVudC5lbnRyeS5wYXNpZCA9IHZ0ZF9kZXZfYXMtPnBhc2lkOw0KICAgICBtZW1vcnlf
cmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCiB9DQog
DQpAQCAtNDg5Niw2ICs0OTAzLDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X3Ry
YW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KICAgICBJT01N
VVRMQkVudHJ5IGlvdGxiID0gew0KICAgICAgICAgLyogV2UnbGwgZmlsbCBpbiB0aGUgcmVzdCBs
YXRlci4gKi8NCiAgICAgICAgIC50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnksDQor
ICAgICAgICAucGFzaWQgPSB2dGRfYXMtPnBhc2lkLA0KICAgICB9Ow0KICAgICBib29sIHN1Y2Nl
c3M7DQogDQpAQCAtNDkwOCw2ICs0OTE2LDcgQEAgc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lv
bW11X3RyYW5zbGF0ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsIGh3YWRkciBhZGRyLA0KICAg
ICAgICAgaW90bGIudHJhbnNsYXRlZF9hZGRyID0gYWRkciAmIFZURF9QQUdFX01BU0tfNEs7DQog
ICAgICAgICBpb3RsYi5hZGRyX21hc2sgPSB+VlREX1BBR0VfTUFTS180SzsNCiAgICAgICAgIGlv
dGxiLnBlcm0gPSBJT01NVV9SVzsNCisgICAgICAgIGlvdGxiLnBhc2lkID0gUENJX05PX1BBU0lE
Ow0KICAgICAgICAgc3VjY2VzcyA9IHRydWU7DQogICAgIH0NCiANCi0tIA0KMi40NC4wDQo=

