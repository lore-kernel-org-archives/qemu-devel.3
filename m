Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1446BC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 05:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWUoh-0000L7-JQ; Wed, 24 Jul 2024 01:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWUoe-0000K6-Nx
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:45:33 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWUob-0007NI-Qc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 01:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721799930; x=1753335930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b9rZW6I1Xy8L/4ihf9kUFTUz0ruewiBn/3Ke/SJr2Tw=;
 b=LpOERmMKXcknlw0YasNA7I9P2ICahOKusVKMoVvLzD71tjvkhYjAfC8d
 S0V1E+pDkxX1VwxNian0FZ0MzGZfRjyDdZa4omuCss/du3hMHfcHex7qq
 1gex80jfOXr2OAY7Up00Ql3F+jlCiyfDPYSVM8KLQJ/RW6y9FsOmRo+bE
 PjogzaTBCzIwjSoOkG5JYKG8DnV2LjK7N/ocHOFKUJLh9ABA/SN7r3c51
 2jZuSFBExEqbguC0I7ZKQFdpoorWV/ZQRBrrkrKtt/56MWAnOIXN1c5dd
 1RvBzvF2VBerjPLYYhm29ksnm3G0XcEhwR4p7M2uDuMBdTxBe2xV4ejyI A==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17220622"
X-MGA-submission: =?us-ascii?q?MDE6Cie4LF0SCWmS//uiG1gTTzWdVuO7xJ/TZl?=
 =?us-ascii?q?kHGJZ7F7kwwG9RI9XTs0P63BoTps2emXrmTkCqRLPRMlATrVpVFE783r?=
 =?us-ascii?q?TqmUiv5qC67kzCVLlno/xYodAWEuTfJo7gyUJjh5Tw0aJGPkO5ICSAC/?=
 =?us-ascii?q?6ERZxNUvyxpVtWr2mVXCXdcw=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:45:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtewSb/Rf6xMfXd2NBlpZitNpjBiNYMdw9hqdhQhsgddciVt5OxM16xf3acYlkNgYGVgWbgzXvvOzbMCQs5Q6EA/qGDWFWuZGNNXHXvnXofOQmjjBB2K087NIk+eRdet2jD06K2DX5/hEV+BWhEG+OnpnQAa02ektB2G5J7BFce+TOZsBWkETn6GEGN3Z28IgJP+g4oOq/EYX46v5JWAuUWwCelFKOzd+oqwrSnNENMLKOjFT7+VmQYbpbjq/Qc6D4K1iFIcF3ZAEyXehuBAOBWeh5EQ7Ubh/wJFqDiARguAooqWvvXSktDwadgXx0IHYb/ekBkzCWFqPA+v+p0M/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9rZW6I1Xy8L/4ihf9kUFTUz0ruewiBn/3Ke/SJr2Tw=;
 b=mFMLNU95mwTA1txVLe+9dQuMczoKWRQRVDGghOJGaofLczjJODb3nWjfEBuYoJ2S8WIHkPypgsAaQxUexkKDljgOe8mvk6UVorakJj/X0+/+TBy0BjIorWpEwvyswAK3s2Mh0bcXavx6an8Y0T7Od6ZY4dr55GRoZ0h537YHvvZGydJKvdQBXjb+8sorDzuDB64RMjBBy2Nb9n1rV3EIDPLUAmbPT8yGUJFXzu7zdCXKmkbAOal9KtzyiMlIpk1WzSu+nT1COdSy4OXDcEcBJQAAW8KZgsUGzsDYvgnZum+P8bkI/El+Y/Cb1Zd7gMRdHnXt+/3OY8AbXVs2+EsUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9rZW6I1Xy8L/4ihf9kUFTUz0ruewiBn/3Ke/SJr2Tw=;
 b=aWOFMGMJIEmz6jRmEvaQQqTpVNPswmfvgJmnjQh0ibwcJMbrqb4dJtOlNNajhCCDe9z0pk7TEMAMRMVF7GBBrR5n6DVoF9h+92niXuBIKdbtCEfSmMlp3BcLnicjlBLKBl/xXng0n1UKaBLN88Rym6Ae3jZObISRgv4H5FK0F6jtW9hIT5xxlf+O9plUdh1frHXkwMzZq85ssBciPTQ7vCXPsDDZC8nZfVnN6hKiNPTlVoxq5D9P0IbgQcmTy8Yt3sDuYHyOBkp9uRA5RcPo8lr8BdjejI12QaiklcFelGn9kjFtrYrOnUrSuN8fD4ESkZz2KKTj9Mm8z5MgdIIBIQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB6763.eurprd07.prod.outlook.com (2603:10a6:102:74::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 05:45:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 05:45:23 +0000
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
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa2OtXvGur8faoMEeNH+HzRNGOm7IFZ3mA
Date: Wed, 24 Jul 2024 05:45:23 +0000
Message-ID: <700f34b1-d020-4a1f-86d0-878a0628cc5e@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-15-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-15-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB6763:EE_
x-ms-office365-filtering-correlation-id: 85d8f1be-6f60-41f4-1078-08dcaba3cfc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cnhNMzF5NHNmL3VqL2RTU0JiU0xSM003bS9XZGtWUjZNN1ovRVpTbVpVK2pr?=
 =?utf-8?B?N09HRS9USnk1dEFFZ0Z6TkJFeW9ZRWJTR3lRU1ZZMEJHMWlVR0V3bnBOWkhs?=
 =?utf-8?B?U2Nkcy9SNFJwc3RSa0xRTFBuUi9MWTZ4TmYxVHVYZ0E0WnJKdW5YTzZsRnc0?=
 =?utf-8?B?Z3orSGJnRitybVBLSnN1YXFLNTZUczdBZDhXWHRRSTA3YzBsMGduVkNyeHFk?=
 =?utf-8?B?ZzljN1ZkNHhHTHU5b3lIa3lSYTFhTU51TGcyV2lsamR4T2VWS1BQRklpbDh2?=
 =?utf-8?B?MG5GUnpVeTYrZjYvcldYRnQ3VXAwR1BITzJkTzk3U08wQ1JJWDkyZzFJSG1s?=
 =?utf-8?B?YnB4VGNHNUVuTHFTQnJYeVpGTEdFYm54YnlNcDQ4MS9LVGJwMXJqTEpvOE9T?=
 =?utf-8?B?ZVNrZUY4MlpFSUlrOUowbUdGWFVRYXZhQXhxMytxdWhaOEMyZU1Ba2lTSDJr?=
 =?utf-8?B?Y2k1dnYzQ0R5TVBpaUdPZUlacGliYjh0YWUwcmNEcDlqNi9GaXV1aytYanFx?=
 =?utf-8?B?NEZMRjJ1VXB5d2wzNllqZUMzSG5nQnhjcDQ2YkFYcG5LeUg0SHF0TWE4TDla?=
 =?utf-8?B?QURsV2xIekI1Q2RGcEVGN1NpWGpkaWIzQzhsdWlUQk9LSnhhM3o0SEhYa3RP?=
 =?utf-8?B?ei92Y0MyS0xVTUJkQ0owbzE3RTd6Vy9wejNQZ0RqeS96SjdONWtxV3NwTk5D?=
 =?utf-8?B?NEsydDVEUGllQmlwTmJlRnVJWHVTRkZJOEpSTUFQbVZmOUp3bzJtZUFpWEE0?=
 =?utf-8?B?Wi9xWDhzL21lWHgwbXRMKzBXZ29JQk5MUGFFTUZrK0l1SzJlakVpNEJadHdo?=
 =?utf-8?B?RUwrUXcrb3B0TEZhSmxiSWREYVdSTHpiZHFpZzFLdE5ldzZ4NXZBL0RocDlP?=
 =?utf-8?B?d3p3STA5bW1zSkQ0Ry90RGNaRG9nNXZweWIzSEE0dmVLQ2p4ZUhuenZkdXZu?=
 =?utf-8?B?b1BVQnl6aEF6eVllQXk4NUZJZndoTU5HOGR0SFJVbmx0R0hoRHRiYVQyZi9a?=
 =?utf-8?B?NDF0M3NTcldrTXQ3N1FiOUVMTXk1WnJRNk1lcm9rSTRNejc1VTFRZ0pNZlhU?=
 =?utf-8?B?N05ZWUNhT2FCT2syVUtjNmJKbFloY051aTB6OWw5VCtCenI2ckpSdlNNOElP?=
 =?utf-8?B?VmdraGZoc3VXUEx4UkYxaWVZVzlLMTBJaHRLSEc5QXRDRm1PalIwTWtTYlkx?=
 =?utf-8?B?OTVxSUlIR3dva3gwZ2gvQno4SXB2L0NiNHJFT3lVVE44SVppUlZnT3FzQjB5?=
 =?utf-8?B?czcxMExmWkx1UHVta1RGb2o4ZjYwaUZvMGh3WE5Va1hDQWxMOHVWcU1sWDNQ?=
 =?utf-8?B?MEp2YmtuZ2hZU3NUODhPbU9IY2M0Z1VCalZlRkwyMjBqeitrOTZvS1grZk9j?=
 =?utf-8?B?Wmd4S21UcUNWYTR6Vy9jd2tTWG9EQ2t1VGpxSHdKdFNBV01xdmY4N29VRkRk?=
 =?utf-8?B?UlNYa2Q0R0ViRmcrd21POGVaM2pDVG1QYW1WNEJSUGJTbUI0NXhUck9DTFFE?=
 =?utf-8?B?dFNLTVJZZ2ZlMHRjeWlkd2FMUC9IZFZhbk13eFJnNXcwVHpSTDg0V2t6aER5?=
 =?utf-8?B?M3FsVDVPaEY0aWdCTUs4RitGODZIdnV0TlhYclZGVE5kK0sxQkhMdGFVM3Uv?=
 =?utf-8?B?YThVdDRtTjZBcHRvVXl1RW9RenI1MjJZY0duWDRmRXdEZ0lLTzQxQ2Y4ZWZY?=
 =?utf-8?B?bVRJVDM5dXY2aDZhMCtMNGdlenlETXlERjh1RmxIWG1aaG13Wjh5cnJYZ2Fp?=
 =?utf-8?B?Um9xbCtYOWorNUlzNXhGNXhJSm1MSE1qKzQ4RzVvYm8vWXpwMXFsTWRkeEE3?=
 =?utf-8?B?UEJHK0IrK2F4bmFPMFM4UGJEbDRRb2dmSy9RaG5nY1FlVlpqYXJVKytWdE5v?=
 =?utf-8?B?Z2hSUVl3a20xcjMwODIwWTBNanoxbTM2cVYzNjNsSWZOaXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVc3dGNnRXlFSmpyb0lZL1B4Z1piMnVaK1k3ZHJoNTNOcEpadU1kcXZodE9k?=
 =?utf-8?B?NG1KWUQ3TGhLOWVKSzNlZEdpTEhWYXhCd1Z2enpWazM2TWc5N3kxME9TM3FE?=
 =?utf-8?B?YTFIdXpVY2s1VzNvQ0RrMWZaNW5vaG0wbjQzS1FSYzNYM3c3ZkJsVXQ4N3VS?=
 =?utf-8?B?bVhYKzZxSFhkZWlmRmhoSFRrQnY0TFdORUNwTkZUMTBBRjNWdEh5TndkRnN5?=
 =?utf-8?B?ZWJVdlhPRUpjTUhxNVpQbVV3aDJqTjJVMFNWcFhhVmJEZGhxMUI3aUg4UVdo?=
 =?utf-8?B?enVSUnllMHlQSVFCaTkyQXJ1R2NDdTZ6dXpBcVFMbStjL0Y2ekpBaXhrZGpO?=
 =?utf-8?B?Y3JyUGtCcW5Ramdlb3gwVW16SEFqa0xwNHVsQmpOanFEZDBxYVowMU45RFV1?=
 =?utf-8?B?WHo1N1MrWlV6ZkJwbGx5RWFQRncvOHlXTmNvU3I2ZE1tSkprR0RQaW1CMVRT?=
 =?utf-8?B?L2dBbjJ1NktGdnhZd0pPYng1cm9id09JclNYeUw1S2pJN2lPeWhuTUtOajBy?=
 =?utf-8?B?QUpFcndWbVZrUEhmT2ZMSXd2a0V5Z3B3TWx6MFA3TFZRelFia3dMRVlFY3k1?=
 =?utf-8?B?UHVaY1h4NXpzWDl2a3RKaGhuWXE0cURNaWI4TGlaRUk2STZFU3F4QStMVFVZ?=
 =?utf-8?B?SmppdUprSDFpUnBva3ZRVW5acUVNN1lweGhLOEoweTVRcEduOEhNcTNjeFZo?=
 =?utf-8?B?TXpuSHA4UDNkZmdpWWx4NUNxczFacGZPZHVPVGtQbWUrQ2h1Y25kMnlRYStx?=
 =?utf-8?B?MFE4eGJqVmxMMks4Q3dlZzJONWZwR0dRQ0t2NmswTUxpa09RdVNxNndPM3hT?=
 =?utf-8?B?cW5UM3NTZXp5S25qWTNld25xcGl3ZXdZdTNoeXpKK2VIOHR2ZkdEeC9qSURE?=
 =?utf-8?B?ell5Ty9UVFN2Z1VsQXZsdXhMTjlta2gzRTFoRk5aaER2YnJyaTlsWXUrZVRj?=
 =?utf-8?B?dWlPMUwwTDE3Q2lPM0VsSlFhNmY4cVhnWkwwVnA4TG5OalBrWHVidkp0d3hT?=
 =?utf-8?B?VEtsN0NOYUMrb1oxZ1ZXUVFDNnpicEc5ZmFBWmRJRk9VVU84NnlHQnV1a3hZ?=
 =?utf-8?B?RHlBM0JPU05jelpIQVV6T2dlcVk3bU5CMVU0OGNOdjhHWHdQQk9COXFMbW5Y?=
 =?utf-8?B?dWhqT0RDMEdKUm9ueUlWWkdlNHZ1M3NnZ2hKUWNRVlVndStjaVMwMC80R1h2?=
 =?utf-8?B?QVZHUWEvOVRES255Z0ZUMzZ5NS9kUlBOMjdZaUpQbEdMS3ltYnJZb1I1b1pF?=
 =?utf-8?B?dHNUWExuQXJ3Nnh3RmFrUGxsTXRmU0c2SXpuSWIweDJjdGs0cHA1aUVES2Jm?=
 =?utf-8?B?d051TENBb005VVV5TFFBZzJLSWlVbmRrWURNbzR5RGpQQTJxMloyRUZmMUJI?=
 =?utf-8?B?SzZEb2EwSGt2RFJRd1hWN1lMMmR0U2hWUVVYOCs0RThYbEt6TXBlQ3RmVHJs?=
 =?utf-8?B?QTVVYmxHMXlkQ2IyN3pJVy84QTZOS0RiMGIrWGZaWnhYdXUwSngwZkZQWXZr?=
 =?utf-8?B?WTZQelU2eng5Z3VzQjd4MzdIQUJwaDlaZDRzYnBkOFpoQVJBUXRHNE5Bc2Fn?=
 =?utf-8?B?R0ZrZFRVdnNpUWhzUFBkeDhSZmNOVjM1TXpMNFUvNEdKR09tOTBTWmxta3E0?=
 =?utf-8?B?bHF2WitwYnhDZDZjYkFCdFluSG9aVW9MZGwveVYvcmdWc2hENVhLR1FVOFlH?=
 =?utf-8?B?NGZ1Z3FWdG9OLzRkd3o4d3crYUxmQm94L0FoL2tVRWJDeEpOQ0QvUUJXUi9a?=
 =?utf-8?B?UUkxb1prcEg2YlBKcE5peWRFUE5XWUVkRXpibmV0QXRjMWR1ZWNoWkw3QVdy?=
 =?utf-8?B?VGt1N3IrWGRqZXl1L1RKQ0huTWgwVWtPOUErcDM0K3I5RG5iOExCbW9GZHdy?=
 =?utf-8?B?Z3c0TmNNUWJjbWh0VEpHVHFucjVDV3VoMGQ4RWN4cmR4cU5DSGw1UmhCbTlT?=
 =?utf-8?B?eFpGY2tPSm5rVk0zakZLaHg1d3lSMUZOaWp4L01CZnB2dzdLWlZmYjMweVZG?=
 =?utf-8?B?SzlVYzl3ZVhnczdNZ2NpUmQ0N2ZCbVk0THhsZVlKOE9ZWHJqVnlKbHRrR21H?=
 =?utf-8?B?Qk9WbHRvTmQxcDJSRkk2R0EySUVrM3ZXQmdRbkJVZnFibm9nbjZ0Y1NMcXRZ?=
 =?utf-8?B?RVR6bEs2eVlqUWY4RWNxOWNITmFWVVB4ZTVnOFZBNGxEVGxLZnB5bndoN21I?=
 =?utf-8?Q?Lfu8ewul+wM++BOQsQRcFk0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9729E20DFEAD654187F03C8ADE7B1088@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d8f1be-6f60-41f4-1078-08dcaba3cfc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 05:45:23.3701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaKe+XpzdC+ffnhuHKQkpgxWnnNQoOetJH3PJiSeM6D6CqsBMqHb6u9uk9QM6p2vFyCHTjmMAbgrn6KF3UKBF4dFr6RiYPy4ATUrRjtcfMkf/jUXRN2ukpLZJ9C6HZQo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6763
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

TWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGJ1dCB3aHkgZG8gd2UgaW52YWxpZGF0ZSBkZXZp
Y2UgSU9UTEINCnVwb24gcGlvdGxiIHJlY2VpcHQgb2YgYSByZWd1bGFyIElPVExCIGludiBkZXNj
Pw0KSSBkb24ndCBnZXQgd2h5IHdlIGRvbid0IHdhaXQgZm9yIGEgZGV2aWNlIElPVExCIGludiBk
ZXNjPw0KDQpPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBUaGlzIGlzIHVzZWQgYnkgc29tZSBl
bXVsYXRlZCBkZXZpY2VzIHdoaWNoIGNhY2hlcyBhZGRyZXNzDQo+IHRyYW5zbGF0aW9uIHJlc3Vs
dC4gV2hlbiBwaW90bGIgaW52YWxpZGF0aW9uIGlzc3VlZCBpbiBndWVzdCwNCj4gdGhvc2UgY2Fj
aGVzIHNob3VsZCBiZSByZWZyZXNoZWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWku
eS5zdW5AbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPiAtLS0NCj4gICBody9pMzg2L2ludGVsX2lvbW11
LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXgg
OGI2NmQ2Y2ZhNS4uYzAxMTY0OTdiMSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtMjkxMCw3ICsyOTEwLDcg
QEAgc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYXNpZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4gICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgfQ0K
Pg0KPiAtICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAgICAg
ICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuIHx8ICF2dGRfYXNfaGFzX21hcF9ub3RpZmllcih2
dGRfYXMpKSB7DQo+ICAgICAgICAgICAgICAgICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3N5bmModnRk
X2FzKTsNCj4gICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICB9DQo+IEBAIC0yOTIyLDYgKzI5
MjIsOSBAQCBzdGF0aWMgdm9pZCB2dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1V
U3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9pZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIGloKQ0KPiAgIHsNCj4gICAgICAgVlRESU9UTEJQYWdlSW52
SW5mbyBpbmZvOw0KPiArICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPiArICAgIFZURENv
bnRleHRFbnRyeSBjZTsNCj4gKyAgICBod2FkZHIgc2l6ZSA9ICgxIDw8IGFtKSAqIFZURF9QQUdF
X1NJWkU7DQo+DQo+ICAgICAgIGluZm8uZG9tYWluX2lkID0gZG9tYWluX2lkOw0KPiAgICAgICBp
bmZvLnBhc2lkID0gcGFzaWQ7DQo+IEBAIC0yOTMyLDYgKzI5MzUsMzYgQEAgc3RhdGljIHZvaWQg
dnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBk
b21haW5faWQsDQo+ICAgICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9oYXNoX3JlbW92ZV9ieV9w
YWdlX3Bpb3RsYiwgJmluZm8pOw0KPiAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPiArDQo+
ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRfYXNfd2l0aF9ub3RpZmllcnMsIG5l
eHQpIHsNCj4gKyAgICAgICAgaWYgKCF2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1
c19udW0odnRkX2FzLT5idXMpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfYXMtPmRldmZuLCAmY2UpICYmDQo+ICsgICAgICAgICAgICBkb21haW5faWQgPT0g
dnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRfYXMtPnBhc2lkKSkgew0KPiArICAgICAgICAg
ICAgdWludDMyX3QgcmlkMnBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4gKyAg
ICAgICAgICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+ICsNCj4gKyAgICAgICAgICAgIGlmICgo
dnRkX2FzLT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQgfHwgcGFzaWQgIT0gcmlkMnBhc2lkKSAmJg0K
PiArICAgICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4gKyAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAg
LyoNCj4gKyAgICAgICAgICAgICAqIFBhZ2UtU2VsZWN0aXZlLXdpdGhpbi1QQVNJRCBQQVNJRC1i
YXNlZC1JT1RMQiBJbnZhbGlkYXRpb24NCj4gKyAgICAgICAgICAgICAqIGRvZXMgbm90IGZsdXNo
IHN0YWdlLTIgZW50cmllcy4gU2VlIHNwZWMgc2VjdGlvbiA2LjUuMi40DQo+ICsgICAgICAgICAg
ICAgKi8NCj4gKyAgICAgICAgICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+ICsgICAg
ICAgICAgICAgICAgY29udGludWU7DQo+ICsgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAg
ICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4gKyAgICAgICAgICAgIGV2
ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4gKyAgICAgICAg
ICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KPiArICAgICAgICAgICAgZXZlbnQuZW50cnku
cGVybSA9IElPTU1VX05PTkU7DQo+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sg
PSBzaXplIC0gMTsNCj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9
IDA7DQo+ICsgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdSgmdnRkX2FzLT5p
b21tdSwgMCwgZXZlbnQpOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiAgIH0NCj4NCj4gICBz
dGF0aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+
IC0tDQo+IDIuMzQuMQ0KPg0K

