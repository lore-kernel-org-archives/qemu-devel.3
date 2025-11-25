Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05568CFD374
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 02:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNitK-0001Yx-87; Mon, 24 Nov 2025 21:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNitI-0001Xu-Eg
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 21:34:52 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <PengJu.Zhou@amd.com>)
 id 1vNitF-0000tm-1Y
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 21:34:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3Attp0hZFl9ThzZrcqr5YUgnUfOQ34FpFER1B3HHzMG5FF0/B5mTsA6h/y6jMjEYZoLWF/ZzISUlv3/Zs5wPebGpDIbhnvLuWPiawy3ZLqGVN8akGbr03Bf6EHrQq4h9JKwlvHWI8POl8gc54u2lwmUMxV13rDgR022fNCHKlj6LyB4+qmu8OfRpqwGEyORFrvcqM4X8FoaNvvhrBlVZWStoQjCSBfvTl1qX8ASUEKdhCA7s5RvVyVxzJAYsVjIactTgL+r6/V6gfpT/zWAEHuueNc9nI/XOzXRD6NuQy24dHqJLklKMLJKOV1u1y4Ijdt5W71mT+qtW/rouJS3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9b/1JtGGYmQHnuXtrrCiHlDa0tDq1+AD3Q2tnqNcl0=;
 b=YmBxlqrvqD4JQ+YTxLXGfWPJz1A+aJI64VZ+1pQ+EYLDIe+GLMraR9T4P4PxEZ5vKDFkBJ5UxkWpZFF/LTNF3ekTLH8iDGWj0GPh4/bC0qKxVLM3MyBdmQbpZC9vfWy7vT8zfYjK3fkLGlrzhELLfAu0gkYtLn8kZSZaNYvfYBVogsRkKwqI51Rcdg2VfZuxKXWZcK7KEhnfEOazdj5FmXDk6ARbvWLmgx9vai9lsDGKKEAp88+gfY640YtAAIbEpSy85k4o956C4mzdc3yWxmYW/1FUqpA5eAMaxRI2M/fcNqZw2De4KRVNNLDarlTYLfoQLdn8qCKM4vRpJ8vOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9b/1JtGGYmQHnuXtrrCiHlDa0tDq1+AD3Q2tnqNcl0=;
 b=VQxCCsUqGmAlG5tkpzx2xxYj7KCXNpVQqX63DekDzBwDZ++RY2H76QS/q8ommoaza3Lz5aaw7is5zcA77mLHS/0qIZJBPRvaCSMCWOLpebpFou51s9VkUW7IUlK0g86Z0XhBOlwvKQskW74pFPz3O7nzD/uu6rOKuv7TR5apl/o=
Received: from PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 by PH0PR12MB5680.namprd12.prod.outlook.com (2603:10b6:510:146::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:34:41 +0000
Received: from PH7PR12MB8595.namprd12.prod.outlook.com
 ([fe80::1394:cd7f:c01f:9bf8]) by PH7PR12MB8595.namprd12.prod.outlook.com
 ([fe80::1394:cd7f:c01f:9bf8%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:34:41 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Ma, Qing (Mark)"
 <Qing.Ma@amd.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Topic: [PATCH] hw/i386/kvm: Prevent guest monotonic clock jump after
 live migration
Thread-Index: AQHcWfouWB64eMRQxket8nQadjUeibUBb7iAgAE7HqA=
Date: Tue, 25 Nov 2025 02:34:41 +0000
Message-ID: <PH7PR12MB85950C4310D80D0EE4DC9894F8D1A@PH7PR12MB8595.namprd12.prod.outlook.com>
References: <20251120084428.3320758-1-PengJu.Zhou@amd.com>
 <e44d1f5a-9e0d-4b0f-97bc-6ece9a36c5f5@oracle.com>
In-Reply-To: <e44d1f5a-9e0d-4b0f-97bc-6ece9a36c5f5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=429f7198-876e-4eec-8194-65d73916d25c;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2025-11-25T02:23:41Z;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8595:EE_|PH0PR12MB5680:EE_
x-ms-office365-filtering-correlation-id: fe3d7443-e920-4c3a-2426-08de2bcb2ff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ajRUYkkrWmsrNXk0ZGh0MEFtUXY5YkI0bGdsbDU1TmxKZHVLejU3SklyeXlF?=
 =?utf-8?B?VjZySXQ2cEg4VndNWVVmV2JNd0NwRjVENDc5dmFxaVpobXhURk9nNXdqTXZ6?=
 =?utf-8?B?ZitJOS9ZU1dtd21Hbzk4WGR3d0tKd2REY21pRzRyL0RUNVdTcVQxNXRGbjlV?=
 =?utf-8?B?QWV5N09ScXF3NkYxa1hneDNwbjFtM3VKWTZZZlk3YnRQNE1MWU1MV0tLMmlK?=
 =?utf-8?B?K0VabGJkWUQ1SERBL1lMb2d3UEg3VXJwVzRBQnB1UlE2cVZtcjlvVzhmYXQ0?=
 =?utf-8?B?ME9mbnU0MThsS3BKRFVVOHMzeE5iVFFEWVNPSE1STCt5T2VObFpvOUxKb2kz?=
 =?utf-8?B?S2ZmSEN0emZLRU9JMld2SmhlV212ZTJreE1nTmxFdHRGbzFGV1BjY28rVVBj?=
 =?utf-8?B?d2p5S2M2NmxvaFNrQkNLZjhQUnFsbkludGVYS3lLOUpia2hqZUVPenRsU0Rl?=
 =?utf-8?B?TEFhRTkxV2FYeWVrbktPK1dkUHBuZS9EY01QTFhnN1Z5MTgxMjF2K0paWWhl?=
 =?utf-8?B?SmdLTXJTejhESnJTWVlzcXpWUytWSkVyWENudi9QOG9ZaVEwTTAvTHFla1Na?=
 =?utf-8?B?WXRLQjVIZHRIL3IvY3pnTmNNZnpOelozK3dtbDdrcUN0RFl2S094UUhpTlZW?=
 =?utf-8?B?Uno1S0QwL0txc3RoRTc4djlqRktpQ3JhcmY5VzNsMEM0MVVUdWZQeXJzTmZx?=
 =?utf-8?B?QmxGOFJGd2oySE1ZN3hpRmtIQTdHOVVaRzlCQVE3b3k2cmI1Mm51QmJNa25z?=
 =?utf-8?B?N3NiSEh2Szcrbm9nYWlnOGJtVDNWeWl4Um5yZTJxY3AwWHdiUmoydHFsd1p1?=
 =?utf-8?B?S1h4dUNKUXZuK3ZSVHpBdzB2MGFTaHl3QXYvWUt6SjZCRjdUMGpmZ1k3azQr?=
 =?utf-8?B?SjhVTFNUUTFvTHdYd3BIWE9xYm5FNGE3cWk1dTUxSmk3UFl4dTY2ZjYxUWpq?=
 =?utf-8?B?dDhTSTUvcmFLdkN5Z3pZekowYWtNNEpyVFR4NHdMelp4Vng5cWpPa2ozZ2tO?=
 =?utf-8?B?QUZSc2JQWDBDVVdYL2hvNzJIcUVNVzdvYi9wM2o2U1JpQjdoMnYxbVRrQWpL?=
 =?utf-8?B?d3RkRkwxV3c1bFV5TnUwbDI1TTMrMC82M2VydjhoVUFYZGdhZjhybFh2RVUy?=
 =?utf-8?B?Q2prWG1WaHBXSlRBUVYxeFVsUU9Qajh1Z1RYbjBzRFRWeFJwVWVlZ1U4bDFC?=
 =?utf-8?B?cFVEa3BvcVdWRmJydXQ4bHdXNHk0bjJkZWVkeVovaWNqYXVlZTE1a3BoM3ZH?=
 =?utf-8?B?K1EvMlBGSmdIMkVtdnM1MWlvWDdEbmVjRUozeXNJWUE3dy8yZU0rdDZ3dDZn?=
 =?utf-8?B?UFBrZmw4czQrRGhRSHVRS3B1ckMyVmVKNk93VWM1Z3F5bFpRTHNFbCtBUTZ2?=
 =?utf-8?B?Tk8wMFZTNnBDcndhQ1dXbGFyVDdXMGQ5RmV5Yklnak5MMTc3WE85SzYwcWM0?=
 =?utf-8?B?b2wrVnF2VmF6SksvU1dDTU5OcGZYeWNxWGtlRDMzWlJONHhZNkp1UXEyVGZs?=
 =?utf-8?B?Tkd5L21HWjFWVVNBZU8zWFJyK2JDUmFDWGVPMkREZHdUZWEyUTUyVnl0TEpV?=
 =?utf-8?B?QlJjMHNKaW9aNzY4SmtYTG15TkdEU3dRRDAxaDVyZXUzNnhDVDRWRHRsN0FE?=
 =?utf-8?B?VVJjS2k5cG54NlRwdkE1OGN3MTF3VWZteno4aTBmSnFMVjFTQ0krOXA2NnJE?=
 =?utf-8?B?OTFLdTREYjUrMEdZMUxBZW9TUjMyQldpNnE3WUJ4clVnVk5Vc3dHNGhXV3gr?=
 =?utf-8?B?eW9tZm8yVXRZcXFRMHdzL0QyaXhkaEVvWjl3ZHYzaUltbCtBMVJobFJ3OW5N?=
 =?utf-8?B?blBPQzNIVFJQb3JTU2lyUWMxYzFSZW54UWJvb1FtRVp3bmo1OTRqT2RDbHVI?=
 =?utf-8?B?OVhDL3lCNDJ2Lyt2NXpJWXVBYlUxZElIM3JhbVlIbWEvUzJMMU53OVlndW5T?=
 =?utf-8?B?YTNtN2xxK1J1UEJMc3JvdDdvMWRlRENBSjVxaksyMDgxWjhydyt5V2FyTnYx?=
 =?utf-8?B?RGdoMWcvd200SEpoMXUvSVAvRng1a1R3RjZzYmhFeGsvWlJycVpYUHVxN29G?=
 =?utf-8?B?VkI4Nnc2WlFjcnBKamxUZUJRWXMxdmtvbVk4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3pLcjEyZkVmSUlaUkduWTFzMmFNL2VTM2U0MGtnSVdiK3E1Q3ZzSmY0OFhF?=
 =?utf-8?B?cko5bmtjMS81NllqS2tWV095b3ZyZEk0RW9DbUF4aW1ZRFdrS2pQVTgvRDBn?=
 =?utf-8?B?dXJ6dXdpRXgvbFp6aW53aUpQb1o1YWpIR2Y5UDdWUVdLVGkwdHloMlhKMDVM?=
 =?utf-8?B?WmZkSEFzTnNrbjNQS0FZVjRLWnlCL2YyNzY2Y0R0V0pqcysxejB3d01FbXYz?=
 =?utf-8?B?cHZ1RDRpcThGRjhyVGQ2QVMwNEk5WWdmcTRmbGZFNWZ0Q3diKzNsMWM5elVv?=
 =?utf-8?B?UGppeHBhNWxCUWllVjBWbERITGkxSDZSUmp1a3c4Z0ovL1VubmlnZ01UNDgv?=
 =?utf-8?B?L2tyQmI2aFBMN3NJQ3BRZUhrRTZuR2JFY1hjZzZ3aU1mSkhaUEdjRXdWWGpR?=
 =?utf-8?B?YWtseWRyM2dXZWprSkY5NU5wV0YzbkdPRWp4aXFXTWJIZVo3dnFwRjZZeno0?=
 =?utf-8?B?SjR4L0tpbWVtL2tyeGhmaWxDZXR3aHZCMXlBQnp1M1RGUmF1aWFPREF5TUt2?=
 =?utf-8?B?eVRtOWFSZ0hBL3MzTnZBaDhnQTc3aTNpZlRWTEpTd1NCU1ZtZEYwRWRncE5U?=
 =?utf-8?B?RHphQm4yOGxFbWNlYlRWMDFkc1Iwb1F0UmY0STA5akdqbjRqNHp2UGdsTWhY?=
 =?utf-8?B?c0NCbnJlb1VWeWV2Vi9NdDgyMkY4SDBHMG5QcWZTQ1Z1RzRObXFVdUNTT3hL?=
 =?utf-8?B?QzFMY05LYVpFWU9SWWdEeHNrVk16bXFtVG5jcCtuT0VmT1hGRWZoLzNIbFRN?=
 =?utf-8?B?bUtYbm5XMFRWZzNlVHdXV2NEeG1YWUlrREdFZHFUMWVJTmtlOGJ3eGg0ZXhN?=
 =?utf-8?B?S1gzdFpXZFdxNStYV1Y0YlphTVlwNElXQW1YR0JuaDFCZmtjMEpVRDVGSVM3?=
 =?utf-8?B?N0V2Q2dFVzNRcjlOSzI1YkRHUmlDOVJLUlhCRDVGMjI4eVZjeEdlbEtGV3U5?=
 =?utf-8?B?MnRoa29QNXZxVGVkaW9uZjIvWmY0MElESkNJVTVxczRYSnd6ZlNDQ3IrVDJl?=
 =?utf-8?B?WnRXQjZmb3RMVWZZdEgySDJ6cFF4Yk90dEZ0SU1tNk5Tc1E5VTVCZ3dUMThQ?=
 =?utf-8?B?d1N2THVGZ29nYzBscWpNY3JFWVVaRzF4SStVRkx4VWx0VVkvOEtlVFRQNUcy?=
 =?utf-8?B?WTFORHJlZzVIRklGaktoMjRWMTBoME1qZHRySVQ4R1ozbG4zZTVXWllEanor?=
 =?utf-8?B?ajlPcktoZHh3dFVMR2NwUEFsTnFCMVhJbnVpa3hDY29aMGpRSHVscGpqYTBY?=
 =?utf-8?B?aGF6NTBRVGk2QzFrSDNtdk4rdy9hWmFWK29ZMHM5VVNlL29oeTNHMmFGdUdm?=
 =?utf-8?B?ZkFtT0F4Vm1OOGI5d0x1WS9nUFRMeXhSMGRVUUtRNkxEQi96bnphWGorN1hq?=
 =?utf-8?B?Qy8yVXFySkNwYmlSNWNYSG1SRlBtZWtIekVweWRJMXl6VWt2SmNldzk1a3hG?=
 =?utf-8?B?UlJad2xHaDh4ZWs5cGk3c0xnalF5THVvd25QclRiUGEzOUovdExxTGZ3V2k1?=
 =?utf-8?B?MmxtTWtZTDI5SlhBTmJwZ05hVmJET1BneXVGTWFOdGtPVGYyWUltYjdaREQ2?=
 =?utf-8?B?NHhPcUFIaXpXUStWS1dRenRZNTVQTWZ4aGw1clZJNjR2Vm01WlZ2SEhWOUp2?=
 =?utf-8?B?b1ZUUDZyUGxaVUpUb3ZJM0xuN0lwU2NDdXpuSWpVTmVQcXYzQU9oRnZtZkZN?=
 =?utf-8?B?a3hYT0pMRjVESmFGbytqUkVvMWFHVnl2MmVZMlczYXhVNVNqa2FaMDdCb0JE?=
 =?utf-8?B?dEF2YVlsWFY3c1VFemdoVWlmU3owbVplYjZFOE9rU1hWczlPZzhGWVhJakhP?=
 =?utf-8?B?Yldad0ZqbWpucDRpbGgxLzZNdTB0dTlKSCtNbk11aUdZdTdLUWw2OWFpTEJo?=
 =?utf-8?B?V1pXMitpK3U5aStneFNXMUJFTkcyb2NLRU40YnZqWEdicFgweTBGVExUeEpW?=
 =?utf-8?B?Vm5uMjhXZzZvZEpuMytUOThoZ1c3djVoUTFjZmk4RGQzemU2VnRsbXkrMkE3?=
 =?utf-8?B?a0FtUTZja2pSL0hQeXJPOERSblNyVDBsdzBSdkxvcnpEdlhrY2Q2aXlWcks5?=
 =?utf-8?B?RGkwVmVZNW1oRXFJMkpLbVRPS0FIOFpHaU9pM2J6OUZtU3J2UmcwZ1dRVEdK?=
 =?utf-8?Q?MS7s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3d7443-e920-4c3a-2426-08de2bcb2ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 02:34:41.5337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyo8F7pecllV8AsoyHBLNVn3+LamFAUMymBPohZGjoG6fu77xkxG613ZsttGhbH+uM7sPJ++iz+3qlQDCjG5pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5680
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=PengJu.Zhou@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgRG9uZ2xpLA0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpBcyB5b3Ugc2FpZCBpbiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUxMDA5MDk1ODMxLjQ2Mjk3LTEtZG9u
Z2xpLnpoYW5nQG9yYWNsZS5jb20vDQp0aW1lb3V0IG9jY3VycmVkIGluIGd1ZXN0IGFmdGVyIGxp
dmUgbWlncmF0aW9uIGR1ZSB0byB0aGUgbW9ub3RvbmljIHRpbWUganVtcCBhaGVhZC4NCg0KSGkg
UWVtdSB0ZWFtDQpDb3VsZCB5b3UgaGVscCB0byBjaGVjayB0aGUgcGF0Y2ggYWdhaW4/IA0KKEkg
dGhpbmsgRG9uZ2xpJ3MgcGF0Y2ggaXMgYmV0dGVyIHRoYW4gbWluZS4pDQoNClRpbWVvdXQgY2Fu
IGJlIG9jY3VycmVkIGluIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQoxLiBTZW5kIGEgam9iIHRv
IEhXIGFuZCBzdGFydCBhIHRpbWVyDQoyLiBIVyByZXNwb25zZSBhbiBpbnRlcnJ1cHQgKHdoaWNo
IG1lYW5zIEhXIGZpbmlzaGVzIHRoZSB3b3JrKSBhbmQgVk0gc3VzcGVuZGVkIHdpdGhvdXQgcHJv
Y2VzcyB0aGUgaW50ZXJydXB0IA0KMy4gUmVzdW1lIHRoZSBWTSBhZnRlciBsaXZlIG1pZ3JhdGlv
biB3aXRoIGEgbG9uZyBkb3dudGltZSAobWF5IGJlIDIwcykuDQo0LiBUaW1lciB0aW1lb3V0DQoN
ClRoYW5rcyBpbiBhZHZhbmNlLg0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gDQpCVw0KUGVuZ2p1IFpob3UN
Cg0KDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERvbmdsaSBa
aGFuZyA8ZG9uZ2xpLnpoYW5nQG9yYWNsZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
MjQsIDIwMjUgMzoxNCBQTQ0KPiBUbzogWmhvdSwgUGVuZyBKdSA8UGVuZ0p1Llpob3VAYW1kLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQ2hhbmcsIEhhaUp1biA8SGFpSnVuLkNo
YW5nQGFtZC5jb20+OyBNYSwgUWluZyAoTWFyaykNCj4gPFFpbmcuTWFAYW1kLmNvbT47IG1hcmNl
bC5hcGZlbGJhdW1AZ21haWwuY29tOw0KPiByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBl
ZHVhcmRvQGhhYmtvc3QubmV0OyBwYm9uemluaUByZWRoYXQuY29tOw0KPiBtc3RAcmVkaGF0LmNv
bQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBody9pMzg2L2t2bTogUHJldmVudCBndWVzdCBtb25v
dG9uaWMgY2xvY2sganVtcCBhZnRlciBsaXZlDQo+IG1pZ3JhdGlvbg0KPiANCj4gSGkgUGVuZyBK
dSwNCj4gDQo+IE9uIDExLzIwLzI1IDEyOjQ0IEFNLCBQZW5nIEp1IFpob3Ugd3JvdGU6DQo+ID4g
UHJvYmxlbQ0KPiA+IEFmdGVyIGxpdmUgbWlncmF0aW9uLCB0aGUgZ3Vlc3QgbW9ub3RvbmljIGNs
b2NrIG1heSBqdW1wIGZvcndhcmQgb24gdGhlIHRhcmdldC4NCj4gPg0KPiA+IENhdXNlDQo+ID4g
a3ZtY2xvY2sgKHRoZSBndWVzdOKAmXMgdGltZSBiYXNlKSBpcyBkZXJpdmVkIGZyb20gaG9zdCB3
YWxsIHRpbWUgYW5kDQo+ID4ga2VlcHMgYWR2YW5jaW5nIHdoaWxlIHRoZSBWTSBpcyBwYXVzZWQu
IER1cmluZyBTVE9QX0NPUFksIFFFTVUgcmVhZHMNCj4ga3ZtY2xvY2sgdHdpY2U6DQo+ID4gMSkg
aW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIFZNIGlzIHBhdXNlZCwgYW5kDQo+ID4gMikgd2hlbiBmaW5h
bCBDUFUgc3RhdGUgaXMgY29sbGVjdGVkLg0KPiA+IE9ubHkgdGhlIHNlY29uZCAobGF0ZXIpIHZh
bHVlIGlzIG1pZ3JhdGVkLiBUaGUgZ2FwIGJldHdlZW4gdGhlIHR3bw0KPiA+IHJlYWRzIGlzIHJv
dWdobHkgdGhlIGRvd250aW1lLCBzbyB0aGUgdGFyZ2V0IHJlc3RvcmVzIGZyb20gYSBsYXRlcg0K
PiA+IHRpbWUgYW5kIHRoZSBndWVzdCBtb25vdG9uaWMgY2xvY2sganVtcHMgYWhlYWQuDQo+IA0K
PiBBY2NvcmRpbmcgdG8gcHJpb3IgZGlzY3Vzc2lvbiwgaXQgaXMgZXhwZWN0ZWQgdG8gYWNjb3Vu
dCBsaXZlIG1pZ3JhdGlvbiBkb3dudGltZS4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtDQo+IGRldmVsL2MxY2VhYTRlNjhiOTI2NGZjMWM4MTFjMWFkMGI2MDYyOGQ3ZmQ5Y2Qu
Y2FtZWxAaW5mcmFkZWFkLm9yZy8NCj4gDQo+IA0KPiBUaGF0IGlzLCB0aGUganVtcCBmb3J3YXJk
IGlzIGV4cGVjdGVkIGR1cmluZyBsaXZlIG1pZ3JhdGlvbi4NCj4gDQo+IA0KPiBJIHVzZWQgdG8g
c2VuZCBhIFFFTVUgcGF0Y2ggdG8gYWNjb3VudCBsaXZlIG1pZ3JhdGlvbiBkb3dudGltZS4NCj4g
DQo+IFtQQVRDSCAxLzFdIHRhcmdldC9pMzg2L2t2bTogYWNjb3VudCBibGFja291dCBkb3dudGlt
ZSBmb3Iga3ZtLWNsb2NrIGFuZCBndWVzdA0KPiBUU0MgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI1MTAwOTA5NTgzMS40NjI5Ny0xLQ0KPiBkb25nbGkuemhhbmdAb3JhY2xl
LmNvbS8NCj4gDQo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ghDQo+IA0KPiBEb25nbGkgWmhhbmcNCj4g
DQo+ID4NCj4gPiBGaXgNCj4gPiBNaWdyYXRlIHRoZSBrdm1jbG9jayB2YWx1ZSBjYXB0dXJlZCBh
dCBwYXVzZSB0aW1lICh0aGUgZmlyc3QgcmVhZCkgc28NCj4gPiB0aGUgdGFyZ2V0IHJlc3RvcmVz
IGZyb20gdGhlIGFjdHVhbCBwYXVzZSBwb2ludC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgSnUgWmhvdSA8UGVuZ0p1Llpob3VAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvaTM4Ni9r
dm0vY2xvY2suYyB8IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYva3ZtL2Ns
b2NrLmMgYi9ody9pMzg2L2t2bS9jbG9jay5jIGluZGV4DQo+ID4gNDBhYTlhMzJjMy4uY2Q2Zjdl
MTMxNSAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMzg2L2t2bS9jbG9jay5jDQo+ID4gKysrIGIvaHcv
aTM4Ni9rdm0vY2xvY2suYw0KPiA+IEBAIC00Myw2ICs0Myw3IEBAIHN0cnVjdCBLVk1DbG9ja1N0
YXRlIHsNCj4gPg0KPiA+ICAgICAgLyogd2hldGhlciB0aGUgJ2Nsb2NrJyB2YWx1ZSB3YXMgb2J0
YWluZWQgaW4gdGhlICdwYXVzZWQnIHN0YXRlICovDQo+ID4gICAgICBib29sIHJ1bnN0YXRlX3Bh
dXNlZDsNCj4gPiArICAgIFJ1blN0YXRlIHN0YXRlOw0KPiA+DQo+ID4gICAgICAvKiB3aGV0aGVy
IG1hY2hpbmUgdHlwZSBzdXBwb3J0cyByZWxpYWJsZSBLVk1fR0VUX0NMT0NLICovDQo+ID4gICAg
ICBib29sIG1hY2hfdXNlX3JlbGlhYmxlX2dldF9jbG9jazsgQEAgLTEwOCw3ICsxMDksMTAgQEAg
c3RhdGljDQo+ID4gdm9pZCBrdm1fdXBkYXRlX2Nsb2NrKEtWTUNsb2NrU3RhdGUgKnMpDQo+ID4g
ICAgICAgICAgZnByaW50ZihzdGRlcnIsICJLVk1fR0VUX0NMT0NLIGZhaWxlZDogJXNcbiIsIHN0
cmVycm9yKC1yZXQpKTsNCj4gPiAgICAgICAgICAgICAgICAgIGFib3J0KCk7DQo+ID4gICAgICB9
DQo+ID4gLSAgICBzLT5jbG9jayA9IGRhdGEuY2xvY2s7DQo+ID4gKw0KPiA+ICsgICAgaWYgKHMt
PnN0YXRlICE9IFJVTl9TVEFURV9GSU5JU0hfTUlHUkFURSkgew0KPiA+ICsgICAgICAgIHMtPmNs
b2NrID0gZGF0YS5jbG9jazsNCj4gPiArICAgIH0NCj4gPg0KPiA+ICAgICAgLyogSWYga3ZtX2hh
c19hZGp1c3RfY2xvY2tfc3RhYmxlKCkgaXMgZmFsc2UsIEtWTV9HRVRfQ0xPQ0sgcmV0dXJucw0K
PiA+ICAgICAgICogZXNzZW50aWFsbHkgQ0xPQ0tfTU9OT1RPTklDIHBsdXMgYSBndWVzdC1zcGVj
aWZpYyBhZGp1c3RtZW50Lg0KPiA+IFRoaXMgQEAgLTIxNyw2ICsyMjEsOCBAQCBzdGF0aWMgdm9p
ZCBrdm1jbG9ja192bV9zdGF0ZV9jaGFuZ2Uodm9pZA0KPiAqb3BhcXVlLCBib29sIHJ1bm5pbmcs
DQo+ID4gICAgICAgICAgICovDQo+ID4gICAgICAgICAgcy0+Y2xvY2tfdmFsaWQgPSB0cnVlOw0K
PiA+ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgIHMtPnN0YXRlID0gc3RhdGU7DQo+ID4gIH0NCj4g
Pg0KPiA+ICBzdGF0aWMgdm9pZCBrdm1jbG9ja19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yICoqZXJycCkNCg0K

