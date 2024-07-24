Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3480EC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 08:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWXTJ-0002Rr-58; Wed, 24 Jul 2024 04:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWXT9-0002R0-EI
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:35:31 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWXT6-0005jM-H9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 04:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721810128; x=1753346128;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=p0XR6bY8184BkCmZ2932Crw9+YM1MbfILQtceVc1Lfs=;
 b=Nub3L2xj+xyxesaR3xMHA4d7r8PZ5zqPkoEcnspa2JmygrrEu+VogUlB
 PwIGrZMCh9ztXe2YXalT7ZgmyqEIesaxSwjsNDTzgaD/SG0i5jDuec/Yz
 Nj/18lUNkB+G7Ouv9wJdPlVmpBJzVersyE5qRmODeOA3BDCBVBjhsQDqo
 HqhOfyreBig/POJ1E6O7qK3rFP1GaT1AQ00tAg+bl8Yzi7F943Gk8ZA8y
 t3a/cD+eqsGheg4xaMTVGOtJ0EZ2M3lh5oUHR+O1VfeTOJd2mS2/osqC1
 vdI8l70YVIaCPwPYjan6ww3KfOziai19q/o3kBStmTjcEeSQHbEISX4W7 Q==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17234719"
X-MGA-submission: =?us-ascii?q?MDF8OO4NOYoihXBqPWmxFwAYJYbh4ne2toELnw?=
 =?us-ascii?q?46aZoisJAFC2ZJi/syx3lPULNYz2hR04P+QzBvQMxlQnP+5Kb4zgokM0?=
 =?us-ascii?q?IfPf/JKLRgSU5cox/0qgJ2UTB8jB7q3cg5Z9gT03gq30U09LBRhUMV4h?=
 =?us-ascii?q?c41+R/bKUxUJ1Ln9p930FWrA=3D=3D?=
Received: from mail-dbaeur03lp2168.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.168])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 10:35:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSebB9AtMazyiVfY8rZlrSFTxAPsxC9XP7n2ZuYPtt61yqXxreaBr0EFBWBYomCLwm/2nRnQ4yeKW8wndZRRkoIdtphdSjG8o3qScfFIijo/LH0Spxs7Z7DJGELlJcVw1T+jirANoTl6N2TE0AgvBku/KqmIl6c8eYaqVdmlDuA5lPgoHS9XENQs4uRlcpUkzeswFsNPFfUWxD2PiXLybqrUKgkhgDYKox8sT1nq9fmF15Ll+q2n8ipI3OWxXNoT/D/QuMl3h5MyryB/pu6z0DT8dDRuOFPymq9u3+t+lI9XPanPGjZEdOVGchibuAoZpKU6DeUw6G+RaZnFaNdmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0XR6bY8184BkCmZ2932Crw9+YM1MbfILQtceVc1Lfs=;
 b=e7K+zuwCb92pBgehthU6LhY/iwZ/WlFCHfkdn6xsMmXHaaIT9UhUOAnRlVdQ5EDcvgjXFbhHGE/aJtMD1Ljyd8Lli2qBueV5b+BGqm70r5Pq4eLoI3EDLmUnumgmtp0a/Q+zve2SYbyTaE2Idu/FqD58aN1Us1vBIOxncbUydgqt1ot05Z7tqh4QHwRoFzHG84/+OBQ+bZB+2tCzbiGaDKrnOI0gTwPdF1jlmBXaFXnWj3N+WIJINTmn1Cld2+VXc0SuAQT3vvAWqT+B3xzobU6O+o7XV3UKpa5P58Sno+DPRDDUxQcxGSTMq8hkhOOJd8o5LSQV1UrCnXrNkyIObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0XR6bY8184BkCmZ2932Crw9+YM1MbfILQtceVc1Lfs=;
 b=pOJbeOwxWsGm1GMJgzt/mql6eu96laWkhdleuor1vZyOzWFTfBS1fCQbHuO8auQtts9tJeMJ+iWOLQobS8RBYfqlJPbuopQBa0Ac19QtJWQ1VQpZvUg7/fewKghfQs9yDlg2dBxbQCkFQSfsfgTaCCGhyo60MYULIDUlbeHHvBsAGGQagSU9WXIHfg3p7OBuw0EsuyG4EL6oAY1eE3DSbcJtluf9TnYnhipGVXLwlPQQwIvp79SKlUlqNlgyF7Y8gul4rkXDTqMWgBecHdO6SFq0mdO1/N6wpM7slUAkCpII2R3bvJLflvzVSF95Xe4wB4gXanCbHn5h3YV6LRmpGQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DUZPR07MB10079.eurprd07.prod.outlook.com (2603:10a6:10:4da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 08:35:21 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 08:35:21 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 11/17] intel_iommu: Extract device IOTLB invalidation
 logic
Thread-Topic: [PATCH v1 11/17] intel_iommu: Extract device IOTLB invalidation
 logic
Thread-Index: AQHa2OtPZYFtg4q91EON/pSMcYh3z7IFlvaA
Date: Wed, 24 Jul 2024 08:35:21 +0000
Message-ID: <b8e4b976-2c78-4fe1-b095-c5f64db28223@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-12-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-12-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DUZPR07MB10079:EE_
x-ms-office365-filtering-correlation-id: 64a0ca58-ce1d-4046-41e9-08dcabbb8e5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SGUweE40cFk5bEYyOTNHRWh0cFRQSWVNVWZmVEI0WnNQZTU2VEtrNHZXM2pr?=
 =?utf-8?B?TzhiT3pUdm1EZ09ndXZyOHh3SU9Ja0xRVUFSbkkrNkhSbzNrcTRlS1gyUTBY?=
 =?utf-8?B?ODFia1M2aTNHWFhaRis2bFhTUlNxYUtHNmkvQ0RUMTkyd3k5L3JyeXI3NFpv?=
 =?utf-8?B?UDVKQjBmdS9lMW9obVBBTWxpY29NaGZEcmdOWU1lZDBodjhma0d1UllMcWdY?=
 =?utf-8?B?aHphWnc1bzZzTDBhT2tVQXllYUlzZFE4aUFFcHlwRUt2akpuSTI3RnhhS0dU?=
 =?utf-8?B?cHFCM0syUnhUVUM4cGR0OVZ2ZGh4OFduTUswT2hKWnJiQWRvQmZyTWwvTGlV?=
 =?utf-8?B?eDU2dkVyM0ViZlZhT1gxY2VZOUZ0dXNMZW43ajJ5MWNQQytIai9QK3MvUWdL?=
 =?utf-8?B?c2t1TnJlU0ZsOXpCRlZFa0tpVjFMNGhXYU1ZdThucVNBZ29QQVYxRDNybEFL?=
 =?utf-8?B?SlgxUitPSGJ6WHVrcm85YWluUDI4ZndIbnVBTW5CTHFsejJERFdpb216NlNT?=
 =?utf-8?B?dU9EZUZ0VzZPQjlxTUVUMFJpUUVMSXNNS29MZlYrcWwzRzJiVUlGU3JwbEVS?=
 =?utf-8?B?YmhvQVdjWWVDRHRLdExYcjVucFg4b1F1NUM4TWR1eTloMyt2Qk5aQklZVFRN?=
 =?utf-8?B?UFpmcmVnRGNKVkY3dDg4M0lkbWhPUFpKbHNpbVB5b3g5K001UGZhdjFSUHd4?=
 =?utf-8?B?a1hHMjZ2V2VQTnJRS0FndUF4Uit3ZlVIQVAvdy9XMmlXMGRiUURxNE5qdDdv?=
 =?utf-8?B?bkdpQjdWczVERFhYaEtVUk9jekI4eHJXbC84VVdFREd2OGNidXNXUUc5VWF4?=
 =?utf-8?B?Y3E4aFRwRGR0ZEZuY0VDZGhON0Rxd0lEMWNZYWNrTnh2OHpicWsyMTA2WVQr?=
 =?utf-8?B?T3ZlcXFvaFE3S0JBUmtqQnEyUlJTN2s5L3c3cTdmb0NWL1hFNjhwOHQ1Z2k0?=
 =?utf-8?B?VzVmYlRRQjZFdVFXQXhnY2tFdmgyU29OYUovbzJ4WXpMNEZYblJJYXlYdEdZ?=
 =?utf-8?B?U2FpZDkyT2FkQUxjTU4yY2s0OUdqQU4xZENudE5udyszZEhIZlFFUUdxMzU2?=
 =?utf-8?B?Y3YyM3dpUC9XSDMxdE5NUlc5bnk5OUhtclVvOHNLY08wckh5UnMvME5SNEQ3?=
 =?utf-8?B?WmhLdGZPL3dTZi9JN28vbVRoemJrNi9KKy9mQmxsL2xCdUxveE9aeXN3aDJp?=
 =?utf-8?B?dUIyZlNSdW80eWNkcXJDY2F5R091NXRaamsrbWtSUmVySVhIakV5WStBdFVO?=
 =?utf-8?B?YUdsdkVYbk1ud0QxWkRVOHpYS3UzblFRRVNkWXoxNmI2N2dXTVQxTDRTQUc0?=
 =?utf-8?B?OUNOd0Q5YmsvOXR5Q0JJUFFHa1ltU1ExRzluSGpsV2JJb0N0bndNbXVubmMy?=
 =?utf-8?B?TXpEUlVrMVZwTUUyOGRuVlZ6K2x2Ykl6U3ZLbFZyRHNpOGl0UlFDbzBIM09a?=
 =?utf-8?B?TlBnQTdRK0p4QnZNcXBON2VMOWxneENxUEw2VlQrbTg3dWluN29SVDdPQmF6?=
 =?utf-8?B?QnFGbjlnNEVkdGl1MnN1QVVjNVV0S0JCYUZKeFF3UHlvUW41NzVRNVVPU3lO?=
 =?utf-8?B?aGVzS0EvTkNkWUZkeE9Qa3pkaGQ5QVd6YndEeUJ3TityZUNHSzRlU0tyakxT?=
 =?utf-8?B?ckxObUNyazE4ckhVSFowVXpFcmIveE92RVlWWW04NjMzTTBKSlhpSkoxVTVH?=
 =?utf-8?B?aDEwSjZVYzhNV25WNkhsK0hhY2lxM2FhMVV0clpId3A4WWpQc3pIdHQwZ2hv?=
 =?utf-8?B?SEdEUFdrQXNvSFFzaUt2eHl2Q293ai9qNW12NHgrcm5sZHhhYzBkNU1kOWFs?=
 =?utf-8?Q?dkxWN7Tf86xUiGiJmpvBKwcxoiUtukjKC9+Jk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29lRll1ODQvNzFUNXQwb21LdG9lME1iM0NrMVZ2ME0zbWJ6bXZvOGExREJa?=
 =?utf-8?B?dlRjd203QUt0NUVocmczbSt4Y1VBYTV2SmRFcGdQb1lubVlDVG1XUmhoMzBL?=
 =?utf-8?B?cjFHSVdXWlJ1UWdjcUptaXpLckh2RGx1VGxxN25ycSs3Smt6KzVNVHMvZWxk?=
 =?utf-8?B?VzVrdTNyL3pyUTlSZFNsaXJVc0t3MnVBekVwU015a2tlZEtaT3ExNDFKaEFY?=
 =?utf-8?B?bFo2QXB1TUs2aG9uUWVoajNDbkdFTHA3TXFkNWt3VTVjZW5RUFFld1VHTGhP?=
 =?utf-8?B?c2xxOGljK25uVE5UNk5iSU9Dci9rdk9KLytnT3NrdmpJZWNxZzFZM3pIWlM5?=
 =?utf-8?B?bXZvSUduZmpCSlIzYnJpaHVpT1JIdCtvdk9jVWFPTnk5M1ZKb2FDcHpWSStv?=
 =?utf-8?B?NlhrdGtMczhnVGQvZnRuRnBwdktqYWhRTmVIWS9RZjRMSnNYTUFVTGZVNjk1?=
 =?utf-8?B?OGtrZWJSUVh1SjZSNWdZdU5yaGhnWDdqUVo1TmxhNHp6WTNSTTRYRVNackdV?=
 =?utf-8?B?VGdwWW9OWXpMZTFOWlN1REpEdzBDdmVNd2JMMVBkZmY4WWk3ckZxUWVlRU5H?=
 =?utf-8?B?Y2hpU29wTklJaHJ2bDUvWmlhVktiZTltSERHTFFkeFhhMm5hcjRQWmFPdE9P?=
 =?utf-8?B?Qk5iYXFqYjlBdTJTMkpYYXJOckpwM3ZkbGd3RG1BT1Z6R0xPa3hHRkFyeCs5?=
 =?utf-8?B?OXRpSnp1Wkc0cmtLSkdKYjZNZkg5Rm50czB5aXdQcnd2bXBUS1hnaWp4UFNV?=
 =?utf-8?B?THdVR0NWRERhd2UyU0cyek9CMnRhUDE3WjYzN1lpVE4yZE0zQWloMWpCVHlH?=
 =?utf-8?B?VTlSZWxmY09wVE5xWDlkU29NM3hvNXFlQzBENFJ5cWNvRGE4d0V6UStHeC9k?=
 =?utf-8?B?ODFyaDdtN1Z2MWkxeENPRXM1OGF0bFZPcG4xUG9WZzh2ZUgwaFJxWENTTlgr?=
 =?utf-8?B?ZnF3RFAyNm1lNUQ5S3lFUmNIb09TWHhXWWFOZXVwR0xYeC9JUnBsYlpTN1M5?=
 =?utf-8?B?b3pqZXh1OHg3N1pKc0dkbzV4dnhxMTZqL0I0Q3VLZVVnU09qQ0hXODBzTzJh?=
 =?utf-8?B?Y0wrOVlLdG11dXBZenIxKzRMdzF3aEZRVjgwZXhrK0hwOGc3RnV4a3d6MjU0?=
 =?utf-8?B?eHM3MWlSTDI1eStwb29kNk43N2UrejVVOGQ2aysxQlJTdFJjWWJpalVQdk00?=
 =?utf-8?B?RUZ1ZjVzNG9KNnNJWXVOZVFDZVZLZUNDOEZienJwejBncjlWdUdIY05pc0lv?=
 =?utf-8?B?V2xkelJUNlNBUStQSFBOOWxSMlNiTS9TRGx5MldEd3ovTnBYSTQxcnRlWWxK?=
 =?utf-8?B?S0phamJUMUJjbG5JNVNIYndRS0NLeDNCWTJSNk4ySUpFSDFnT0Z0R2pYUkVB?=
 =?utf-8?B?MDV1OVN3R3doZHhqRUxLU0RQUDJRVXF0bFdra1pCS0JmeVoxaGh2NUVqZVhX?=
 =?utf-8?B?dkZDdUViaURoUkp6dGJnaUsvZi9DeDNKam9kNklYcW1tWnRESVJleXZjTEJK?=
 =?utf-8?B?blRuTWwwbjc3aDEra3MveEVOdStTb081Z2tYNUQrY0RTcWtmclVpZHRVdDJ3?=
 =?utf-8?B?UHQ4QzZKMGtxb2hwNVV3aWEwd0FoTEJVNzY2Z1hjK29VVWNvVkloWlh1NFUr?=
 =?utf-8?B?bnA4aDV5N0NSc2NlS3dUdVo1WlpmbklkY2V3eDM3Y2xNM2RnVUQwZG94STBm?=
 =?utf-8?B?OVZ6Z0NISkdBSEtjK1BCL0F6THVWZ1NZS3R3clFBbjE4ZGRZSDh3ZWtlbnhM?=
 =?utf-8?B?akl1R255YlpUeEdRckE0WjlVSUVGWGkxcGxQSm1vOWJFaUNCZCtMb09rR2hh?=
 =?utf-8?B?cHZPc3IvNnRTaTVZWEVIeEZUejZROG4vV1VlVzcvWE44aHRLU09BditUZHZQ?=
 =?utf-8?B?MXhLZFFNdFNMTjZ6dXJtRVRvbFdXc1dqS1AxbWVGVXFxcGJDVVp3Y0VxekRW?=
 =?utf-8?B?Z3hOMGRLM3RlQWpIV2gvREF0aVJGdGh1NTVURS9wSVkyQkJGcm9SVllFQlBE?=
 =?utf-8?B?VTZiVnZsWjQ0Wmh5U0dOQTgxRHhpbzE2MGhTMXo1cjJyRTJLZEpnUnpjcisy?=
 =?utf-8?B?bVhBTnBKZTRDY2xxaEZ4Q1pUOTEwdUtESGJqa1AvV01rbTEwT2dWZFZNRjhU?=
 =?utf-8?B?ZHpOZnppOUFCam4zQWwwMVFRejVzV2tzbU9RNjEzTGtIUWdUMFo4dDRDYjFX?=
 =?utf-8?Q?Y/p2stsF/zRBLuy1V1qZOQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <839437802123B14CB94F8A6AF3A512B5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a0ca58-ce1d-4046-41e9-08dcabbb8e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 08:35:21.5382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLzIeoB2+n8w4eZF5fHVg1f46n92P/vb9JUT9TNgCQ4I0UTZYKgdl3qjGWzLaImjip+ze6r5NsS0oLgVF/48breGiFXzvAPBLz7WpRK1I7KbZG8WKzNNS6PFolZXc7xb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10079
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

SGkgWmhlbnpob25nLA0KDQpUaGlzIHBhdGNoIGhhcyBiZWVuIG1lcmdlZCBpbnRvIHN0YWdpbmcg
dGhpcyBtb3JuaW5nLCBiZSBjYXJlZnVsIHdoZW4gDQpyZS1zZW5kaW5nIHlvdXIgc2VyaWVzLg0K
SGVyZSBpcyB0aGUgbGluayA6IA0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQv
NjQxMGY4NzdmNWVkNTM1YWNkMDFiYmZhYTRiYWVjMzc5ZTQ0ZDBlZiNkaWZmLWMxOWFkYmY1MThm
NjQ0ZTliNjUxYjY3MjY2ODAyZTE0Nzg3MjkyYWI5ZDZjZDQyMTBiNGY5NzQ1ODViZTYwMDkNCg0K
ID5jbWQNCg0KT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+IENh
dXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBs
aW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gRnJvbTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+DQo+IFRoaXMgcGll
Y2Ugb2YgY29kZSBjYW4gYmUgc2hhcmVkIGJ5IGJvdGggSU9UTEIgaW52YWxpZGF0aW9uIGFuZA0K
PiBQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCj4NCj4gTm8gZnVuY3Rpb25hbCBjaGFu
Z2VzIGludGVuZGVkLg0KPg0KPiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kg
PHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1E
cmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gLS0tDQo+ICAgaHcv
aTM4Ni9pbnRlbF9pb21tdS5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyNCBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPiBpbmRleCA4ZWJiNmRiZDdkLi40ZDVhNDU3ZjkyIDEwMDY0NA0K
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+IEBAIC0yOTc1LDEzICsyOTc1LDQzIEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2lu
dl9pZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiAg
IH0NCj4NCj4gK3N0YXRpYyB2b2lkIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9kZXZfYXMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYm9vbCBzaXplLCBod2FkZHIgYWRkcikNCj4gK3sNCj4gKyAgICAvKg0KPiArICAgICAqIEFj
Y29yZGluZyB0byBBVFMgc3BlYyB0YWJsZSAyLjQ6DQo+ICsgICAgICogUyA9IDAsIGJpdHMgMTU6
MTIgPSB4eHh4ICAgICByYW5nZSBzaXplOiA0Sw0KPiArICAgICAqIFMgPSAxLCBiaXRzIDE1OjEy
ID0geHh4MCAgICAgcmFuZ2Ugc2l6ZTogOEsNCj4gKyAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9
IHh4MDEgICAgIHJhbmdlIHNpemU6IDE2Sw0KPiArICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0g
eDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQo+ICsgICAgICogUyA9IDEsIGJpdHMgMTU6MTIgPSAw
MTExICAgICByYW5nZSBzaXplOiA2NEsNCj4gKyAgICAgKiAuLi4NCj4gKyAgICAgKi8NCj4gKw0K
PiArICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+ICsgICAgdWludDY0X3Qgc3o7DQo+ICsNCj4g
KyAgICBpZiAoc2l6ZSkgew0KPiArICAgICAgICBzeiA9IChWVERfUEFHRV9TSVpFICogMikgPDwg
Y3RvNjQoYWRkciA+PiBWVERfUEFHRV9TSElGVCk7DQo+ICsgICAgICAgIGFkZHIgJj0gfihzeiAt
IDEpOw0KPiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIHN6ID0gVlREX1BBR0VfU0laRTsNCj4g
KyAgICB9DQo+ICsNCj4gKyAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfREVWSU9UTEJf
VU5NQVA7DQo+ICsgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJnZ0ZF9kZXZfYXMtPmFzOw0K
PiArICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9IHN6IC0gMTsNCj4gKyAgICBldmVudC5lbnRy
eS5pb3ZhID0gYWRkcjsNCj4gKyAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4g
KyAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPiArICAgIG1lbW9yeV9yZWdp
b25fbm90aWZ5X2lvbW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPiArfQ0KPiAr
DQo+ICAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfZGV2aWNlX2lvdGxiX2Rlc2MoSW50ZWxJT01N
VVN0YXRlICpzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZUREludkRlc2MgKmludl9kZXNjKQ0KPiAgIHsNCj4gICAgICAgVlREQWRkcmVzc1NwYWNlICp2
dGRfZGV2X2FzOw0KPiAtICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+ICAgICAgIGh3YWRkciBh
ZGRyOw0KPiAtICAgIHVpbnQ2NF90IHN6Ow0KPiAgICAgICB1aW50MTZfdCBzaWQ7DQo+ICAgICAg
IGJvb2wgc2l6ZTsNCj4NCj4gQEAgLTMwMDYsMjggKzMwMzYsNyBAQCBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc19kZXZpY2VfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAg
ICBnb3RvIGRvbmU7DQo+ICAgICAgIH0NCj4NCj4gLSAgICAvKiBBY2NvcmRpbmcgdG8gQVRTIHNw
ZWMgdGFibGUgMi40Og0KPiAtICAgICAqIFMgPSAwLCBiaXRzIDE1OjEyID0geHh4eCAgICAgcmFu
Z2Ugc2l6ZTogNEsNCj4gLSAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdl
IHNpemU6IDhLDQo+IC0gICAgICogUyA9IDEsIGJpdHMgMTU6MTIgPSB4eDAxICAgICByYW5nZSBz
aXplOiAxNksNCj4gLSAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHgwMTEgICAgIHJhbmdlIHNp
emU6IDMySw0KPiAtICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6
ZTogNjRLDQo+IC0gICAgICogLi4uDQo+IC0gICAgICovDQo+IC0gICAgaWYgKHNpemUpIHsNCj4g
LSAgICAgICAgc3ogPSAoVlREX1BBR0VfU0laRSAqIDIpIDw8IGN0bzY0KGFkZHIgPj4gVlREX1BB
R0VfU0hJRlQpOw0KPiAtICAgICAgICBhZGRyICY9IH4oc3ogLSAxKTsNCj4gLSAgICB9IGVsc2Ug
ew0KPiAtICAgICAgICBzeiA9IFZURF9QQUdFX1NJWkU7DQo+IC0gICAgfQ0KPiAtDQo+IC0gICAg
ZXZlbnQudHlwZSA9IElPTU1VX05PVElGSUVSX0RFVklPVExCX1VOTUFQOw0KPiAtICAgIGV2ZW50
LmVudHJ5LnRhcmdldF9hcyA9ICZ2dGRfZGV2X2FzLT5hczsNCj4gLSAgICBldmVudC5lbnRyeS5h
ZGRyX21hc2sgPSBzeiAtIDE7DQo+IC0gICAgZXZlbnQuZW50cnkuaW92YSA9IGFkZHI7DQo+IC0g
ICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+IC0gICAgZXZlbnQuZW50cnkudHJh
bnNsYXRlZF9hZGRyID0gMDsNCj4gLSAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRk
X2Rldl9hcy0+aW9tbXUsIDAsIGV2ZW50KTsNCj4gKyAgICBkb19pbnZhbGlkYXRlX2RldmljZV90
bGIodnRkX2Rldl9hcywgc2l6ZSwgYWRkcik7DQo+DQo+ICAgZG9uZToNCj4gICAgICAgcmV0dXJu
IHRydWU7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K

