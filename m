Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9444AE8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnMu1-0001Vn-97; Tue, 03 Feb 2026 15:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMtv-0001Vb-Tb
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:21:32 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vnMtu-0004pr-1x
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:21:31 -0500
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 613C0EAg1803201; Tue, 3 Feb 2026 20:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=JqXVpPMvTnyKFFxa1gNwSXiVWQXjTB9D0HuvNkRsfxw=; b=
 nI4YDfKG92JszF5whFUriB7qQFbvFHeaU3bv7i2zLtnvD0i8k3tbZHifqA2ZrTQ8
 RJPPLIp8wCKs2anMW38v/jHp5Y7p70WTP8OGg6RvTEHm25j/JFaxxZwQwXEFrwOb
 genzs9Zy4M5UIw+7GkUd7ZuREcQxShBISeUhOYsU4OMNhThnVmWdTeA5Q+2nK9Q/
 8ZIMJjEa8k9q0XhuMoO1IGD0kmMx4oJMiCSpnpGHvfAwWHzBUnL44HyiqzLNwbHA
 Wnn3V5dq+0uejxXJ9G8yWTZ33WtxM0/lT0p9OMcHSmw+YLR5FIhjro/6dhfdBjFX
 IdWKTOx2c/FvSHZf281SqQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4c1whbvjm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 20:21:28 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 613FjMot014098; Tue, 3 Feb 2026 12:21:27 -0800
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTPS id 4c1gkfcbbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 12:21:27 -0800
Received: from usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 12:21:27 -0800
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Feb 2026 15:21:26 -0500
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft
 SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 3 Feb 2026 15:21:26 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by PH0PR17MB5549.namprd17.prod.outlook.com (2603:10b6:510:b1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 20:21:25 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 20:21:25 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Ilya Maximets <i.maximets@ovn.org>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, "jasowang@redhat.com" <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, "d-tatianin@yandex-team.ru"
 <d-tatianin@yandex-team.ru>, "davydov-max@yandex-team.ru"
 <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v2 01/12] net/af-xdp: fix type overflow
Thread-Topic: [PATCH v2 01/12] net/af-xdp: fix type overflow
Thread-Index: AQHckWbHveaYtIEw2UqC/eBUKtwEnLVxCwCAgABlWID//65eAA==
Date: Tue, 3 Feb 2026 20:21:25 +0000
Message-ID: <F3E91DE0-38ED-493E-ADB3-9FF7139AA6A2@akamai.com>
References: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
 <20260129213215.1405459-2-vsementsov@yandex-team.ru>
 <E43BA2A0-02D1-416A-BE1A-0942D337ACC3@akamai.com>
 <3fd2475e-f070-4255-a716-8d06cb888981@ovn.org>
In-Reply-To: <3fd2475e-f070-4255-a716-8d06cb888981@ovn.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|PH0PR17MB5549:EE_
x-ms-office365-filtering-correlation-id: 48044ec5-96dc-467a-242f-08de6361ce10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZUF5dDA3TWd1UVNYL1ZhaGowbEg2Y00rVWEyazQremwwZmFYRE1YQ015Q3RC?=
 =?utf-8?B?dTUrTWp1aExSUE1lNDl5UHdlaFZmaG1zZmNjcFdhdVhsb2IzMGFpYTJ4TXRk?=
 =?utf-8?B?WDdEWDFoelZCU1VMTzMxQXZ1QkNNVmpIU2VObnRSckVVcGZKSHUxTkRUMG5v?=
 =?utf-8?B?dm5JSmMyNnJTZ2NsSDhGODNyR29TVlFpYjNNbngveS8vWndSY0RTbGJVbU9j?=
 =?utf-8?B?VXo5TFdzU1EzbU1PVlU5RFNoUEtQWTV5QXQ4RTBYTlNrMDFuTzVwelVWUnda?=
 =?utf-8?B?RjBTMDN5cW1kMDlycWlFdlBVeTVFaEZmVVFOVFR4QkYrRnNHbHpMUUR2OUVz?=
 =?utf-8?B?R2VRdDlmM0w1TGx5MXhpMDRKYVVnMTFNOEhhSTRkVUpMUnhQZStmQ0pNNk8x?=
 =?utf-8?B?U25QWTV0TjZJUjluSkw5MDdBcjVydXN1SXlmYkQyV2o0OU9kMHlVQUwyUFZB?=
 =?utf-8?B?M2VrQkRnT250MEJuTUtJdjByaXhsSmlKU2JoZi9keGNySTNIMmkycUFwZUl5?=
 =?utf-8?B?N2xqUjRMWEZ1blJoSHVSYTlCamZGTGJsRFZyWnl3a1hwUnlhUEh2TTRWUGxB?=
 =?utf-8?B?eSs2ajlYRkE2bFpnK2hMdzlyNmVVaUxwWUNCQ3lkazFPUGJoanQ0dUppa0tO?=
 =?utf-8?B?SlJlZC9HZlM3RmhrbTdic3p3VWl6MVRTM0tBTVA0Q1pyTk15TXF4Q0RQdEM4?=
 =?utf-8?B?NjUyR1NDbDg4MFVaR0Z2WXhFSWloUjAvdk90aXlOTzBjNGo3bXU0UTFXNDYv?=
 =?utf-8?B?UVBEZnYwQncvNWhkL24yYTNjRG1PK1oxZWxhWHhWWkhJSG5yNmo3Zkk2Um1k?=
 =?utf-8?B?RG1YUzl1cEVUYndGeFM2ZkJUbldZNmcvamxMcFphNW81Wms5VkxiVkc2SHh3?=
 =?utf-8?B?ME1mZ1E1Y1BTMHNZeWxqeDIxcHBSSFlPR090anZlT2hJODJNYjhDRHpYcm1s?=
 =?utf-8?B?TEN6M3E5TXlsUVA2Z21ZSU5BcFBhKzh5R2ZYUHVLSStEUDFwSTk4MyszaG9x?=
 =?utf-8?B?cWtWaHV2NkZkRkR1amEyVEFDcyswemFJaWtiYm8wMGU4UEg3bHhqK3JKb1Nk?=
 =?utf-8?B?S3pTeEJWR01nTlpXSjdhWUFqcVBMSlNqUFFaQUJlQWc0eHZybjZSczFUMWJ0?=
 =?utf-8?B?SFI2NUpTcnI3YmtxZUt2VFcwbjFBNkZEbThJRzRHU2xuYU1ZK21ZblRXSSsw?=
 =?utf-8?B?ZndGZm5Td3psYUpqZFlOMkppdDVmUWN1bjN1bFZDZDRNMHZBS1pLV3phajRq?=
 =?utf-8?B?eXZxMFpOdk9zaVIvOUV3UjVMUDF2bkNsUk13OUt4Zm9nTkpZRm1hRCs5c25p?=
 =?utf-8?B?TWpwdVYwL09SMkpMdiswL3B6d0s0aFBWSlNxdDJvZ1BvaHBsdlNBK2dNQWRk?=
 =?utf-8?B?YnlJK2NZK2pCRnNyZFczNGRUMU9YYmFtK0VtUlVxaDRFOUg0OVhZSkduRjRM?=
 =?utf-8?B?RW1NZytobE1CMTRVVHBpazNpb1hzL1JmZERad1R3VTVLek11ZkJWVTZZdmc4?=
 =?utf-8?B?WFhwcFpmUTVRKzhuU0RvVFRvZTlNbS9TMExMU2VUR3hCajRsa0toemE4bWZ6?=
 =?utf-8?B?bm9QUUZrbDY4cCtYWnpucE1tYnE2Z01WalhuWm1YeEcrZmJQRGZMNkFHV1lF?=
 =?utf-8?B?OWFkOVY0RHJ6ZXFxUEpwRzB4YndHQ0ZHWUhnb3ZvbHp1K0xBNWdZNkF6MnZB?=
 =?utf-8?B?MlNjY01pWG1tSW9EMjJMZzRPMFZMdkxodDlsT3AyeEpYcjhRM29OT25wSUUr?=
 =?utf-8?B?QnJEREZBNm14dERzSGVqUm12cXA3NW5jdG9LSWlaWEZuZDJKeFA4OTQreHYr?=
 =?utf-8?B?T2xQdnNQYmltRHpEK2FYdXJTNmVZcnJZWUNLdnN2cTZQb3Z1cEorbDBta1F5?=
 =?utf-8?B?dVVVbXh1MFNZTlFOS21hTjdTYXZNbkxMS1hnbWdacjlRNmRHbjJNbG9JWnB6?=
 =?utf-8?B?ZHladGFoakFrTU5aNktYWVp3dkxlc2R6MGxJcmlZemIzMkphWkM5RlB5aUM3?=
 =?utf-8?B?ZTVzWkdQVWZOOEtXRHVtVlZqZnkrTUpxYWVFelNxY1VPeXJEMHBGeEVnWWNT?=
 =?utf-8?B?R2hDQ3VJZjdzMVZTV3N4WjNYRTBsaVcvdGpsd25NWUxjcW5YUGVjeVpPVWhX?=
 =?utf-8?B?UUt1SG41TDE0QTRaby9RUDBYa3VIMi9aVVoxbXJBcDB3d3lNamdWWGFwempL?=
 =?utf-8?Q?Ga5wicMcThT+4wPR2vCJ79o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U093V0FIK1pLOW56anV3bmJsTkFmN1RuNHFIZ1pXMlVSUCttVm5ldkY3dWZp?=
 =?utf-8?B?UytwS1J1a09tYUsycEM0MFp6UVFQbnNyNXhFNWhCaVJIOU5ycDVLZW9xait5?=
 =?utf-8?B?Y0VWTEpCK2xFK0EwbUFrNERZNkRITlNkRW04UHRTbjZhM3dmeHh4em9OK0RZ?=
 =?utf-8?B?S2Q5aUdNQ0lNODNHamxkdmdoSGxuUVdJRzBmODFRMEZUZXpHY1V5QldEVHNl?=
 =?utf-8?B?OWkvRGpzbHJ1ODVpU1M2TExUVmpVY2FOQ0I1V3RtaU80amY1a2kxK3p3WmVE?=
 =?utf-8?B?dFJSRFVnNFgzcmhvengrU2FQN0Vad1dxbnJsUVlnU1JCaFE0dkhVK3JDSk5j?=
 =?utf-8?B?T21ncDNpNzhvVVJqaElEUmNnSE5sYi95V1A4bHBtcVBhVm5uYUVZWkp0QWpm?=
 =?utf-8?B?aXM3a3Y5NEZPUnZZNG5hM0dHWjVQRld5QmtOZW4xQjNMc0pJbjYxMlBiN0xw?=
 =?utf-8?B?RHpxZ3IzYXhpTjR6K0FhcFNTdTYxcVppRTBmMis4Yk9hckVSTEI4eGcrWU5n?=
 =?utf-8?B?d05VMmxHbEFoNEFnQktIQ3VRaGU0Z0ptUk9DcStOU04zOExYU1F4a1pmM1N0?=
 =?utf-8?B?djM4VGF2elJCVmJydzl4amY3QXNxT1JkRGVPQzJleHdPeWhKME9YTGhXTnRL?=
 =?utf-8?B?VmdzN1pYajlmVUg5V1VLWjZ3cTBlOXE1cjYxdytLYXlCa013MFRWcEJ5YXZL?=
 =?utf-8?B?TmpvQ1FJb0pFZjVEYlV2cXZDVWFFblhPU3ZtU05ERTJlOG1sS0JTL0Q5TTdJ?=
 =?utf-8?B?c1VzZ3JBRi9wM0MwTGdMK1hwNm5NMk9vdncvbDdPSERyZWlZS2trMnBFMHVW?=
 =?utf-8?B?Y3BrUDBKUG9xbHphT1ovQ0JPSlE5akNXazdCenJwSnp4SE9lcEVaUS9jeUZ1?=
 =?utf-8?B?OTZJN1FrZ1ZKc1YxdE14R0kzT25zVHE4cHJMdnhCSWxVK3hCNDRDMmhUOVB2?=
 =?utf-8?B?UCsycWZYblUyUGcrTHdmWUhmRlllcHRlejFOekNWSWdHVnEyVnlYRFdTS2Zi?=
 =?utf-8?B?R1g3eWdRREgyR213Rk93bXFnbjl3NnBTWmJXb3d6OWNQK0VpSUFkeklmNTZ4?=
 =?utf-8?B?cXZGMmpsYVp6SmpvK1ErWkdGTE1WQ0djZDVZSk1mOVp2VnJqRVIxYUlnaDV1?=
 =?utf-8?B?UkZTRHg1NU9XTkF1VExMTEg1Mko3bDVRaWYvTHZtaWkyWDdlRzZtVCttL1Vj?=
 =?utf-8?B?OHJ1NyswalAzMUs2UDE5SjhUbWlTcDRwYWY1MGNKSHV5dHg5UVhvaDFCeDlM?=
 =?utf-8?B?QXc3QmY5SlR5SDlvQkUzS0ZUaWVKanA3M0huMU5CblRIUm1LQy9PUUw4WXNW?=
 =?utf-8?B?eEpnYXc1Y05BVldGWElJWXp4UDFrTjBrNndRZVhwZEZmZDJRQi9QY1FJRWFw?=
 =?utf-8?B?UmwzZVVGTlFLZnVWZ29VZjJOck8reDdNdXJ4RE9UQW9RakJSeWJXbmdrckxz?=
 =?utf-8?B?dG1PSW9MS2JaRU9ZM0hDMU5jUDI1c0l1cngvcklXa0NwZXZlblhmMUhzek1Y?=
 =?utf-8?B?ZDhJM0J4N1F4R2cvS3U1REJFeHJhRGIwNVM3MUVSdGIzc1NwZXdiQnJIZW5W?=
 =?utf-8?B?UXVMQnRPeGUxQmFNVWVVZGQvTlNzVDZZZ3hIVlB0US8yU1I1M0dSSVNYVkdF?=
 =?utf-8?B?eVQrUFVKTDJvU2tqZ2JwUUFaSTRqa0Z4ZHFCK1lCNVJGOWxNcWdjMWFBVy9X?=
 =?utf-8?B?UW5GNTBMWEVvTG9WYmxKZ2lUU2UyTDczcGhienJZSG1NVDcwL05ESUpQNjFa?=
 =?utf-8?B?NVR6ZVVDNjJ5RjhqUDYvUkxSVVdabktDbjFSNDNpT1FmSUo3Ymp5bDVQUlIv?=
 =?utf-8?B?VC8rZ1lrTWovcXRVQlBLdTlYMjJLUk9ad05BU1d1RUx2NUhRMk1UNkdOSHhY?=
 =?utf-8?B?YUFUVjVGSTRwa25wamI3eVFqVW8rd2xkYW1Dbkl5djRmYkNyYkF4UVk4Qm5Y?=
 =?utf-8?B?VjA3a0Z5Y2xaNDNRTEhzZ3VRRnZPanQ5eXo2bFpXOU56b3I1WUdTK0M0YXZI?=
 =?utf-8?B?WjRVR0JWUmhVYmFRNXFwdEtnVmtzdVo5NGdmSEdVQVJ0ZTVHZE5Ncmt0NU9k?=
 =?utf-8?B?V2tseE5jN0cwMktJQ2MyOWExVXE5OWRCc0UxY0t1RmlDcTNxb1hNSGhhSFcz?=
 =?utf-8?B?UEY0SnJka1JLZjhkbmhDd0RMM2Z4aGI4NE9yWEhzaDVEMnI0VlIzNGN0a1lQ?=
 =?utf-8?B?d210VFdRN0I3dDltWXB2ZU9BNlhKQ3o2UFU1S0toTUtKTFNHVXRha3ZhM0U3?=
 =?utf-8?B?T0d0bmxUN0EvRlE0R0c4N1FyUlpaTDE3QldYL1B2VDdLWDlLbWpBb09ZeENO?=
 =?utf-8?B?STA5bm5tK3grL05pWGNSUkRYU1ZSRERFNFhBQkozRmdxeWI0MEsrVlliTlBR?=
 =?utf-8?Q?vZAptNfQxmC2ZpFu5StI71Pky+Cxy/fZ6FaNf65BnIWDP?=
x-ms-exchange-antispam-messagedata-1: P31hkaAxXSRnDg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XF2EOS0Kj1qiR5Zqm+V9adfxufjYizoLfW05nJoZTRCJeo54zBfp48p1q3bjKL0KBvDN1lZ8U+kaUL3CaHrw1qaBFD0CTA9wxxbq+Lzp1MbbkcDY1soCRJnB/wV8zM6eyqGSJlvdROC8jGKFn61W0w6tLfYSUkQrGMtIuNV05k5QLJZUi0GChHcXluhpFKe/DxL/IiQ3CRe3+kIwinL6/qI3RQQw+GLFumqjj9SYUXvjcrPnHaS/SHA2OtLxK0AwOusJ9aa19UANPrM9LNSI3zwM6HxqZpiEHmPrjtsdUzqjmxXdv1fIPayivsowMsOvGIKiy7sG3oS9uzhFs9oT+g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB/y+VvbB8vQa9BpB3am7KgMZSw46D84aJnCz7HbDCs=;
 b=qwK/Tq/a09lJzK4CKDctDpX2N0hqDmwc1xDr5gPkNWp7UMXzr46hBwz19ce6Ex2IfTTLzRhGUY8oGuhwk7VNFWUpG2RXBKece3YFHnoYVre2Ruua0pn8iqAlErQIwgv5GdzuX8yZeXmCliF5W0yrM5E7RdDH4mG3SRo12yTTrgQumddo+d/kjl9QVUR7sAueVDa/gJJWfoOBJjNkvCfuDaoOqveNxDQdX9EFa9KiqEtSW54/cPoeKbUQERiH7kbLbvwIgRM+DALtIeahlvttn8qy+zadr/P/G/Voy9QzgcIGC9UJyD20akHULVEzlL+LkxUFLVSQZ/P6AmtHgDsq4w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RB/y+VvbB8vQa9BpB3am7KgMZSw46D84aJnCz7HbDCs=;
 b=RDiSllrWLBeTLYRUaCvSLfzcNB+SfeFDPu/oFnX5F8tu9nsupJi2dPYuOAENw3JCFama1bQDuBauo/8CKUlllrrwEen+N85ZHFL3SoR9Njgg9vAMAElLoSN9XmXDtJ7E6uQ0+hA7RtKUIrsA4ApMEVlCSWDnYX0UjYM/dl7Uxs4=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 48044ec5-96dc-467a-242f-08de6361ce10
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2026 20:21:25.2866 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: IR8CVWWcp8nqDP/qDKUAvXkxpE3SE7bQwI2OZMKUmbqh9/+ZpXVwq8hwKbGvS3qJdz0W9u7bsqATU/v/QTdlTQ==
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR17MB5549
Content-Type: text/plain; charset="utf-8"
Content-ID: <C40686408063B14985EA6AA530B3082E@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=739 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030161
X-Proofpoint-GUID: kHUTgc4jUKePtZDAgXy2_w1AeYJyGPwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE2MSBTYWx0ZWRfX2e0bJ8UZRLdN
 TTkJ9/grYXC1bKqVb2TxqloQ5n2H/lWoBmDamYj96uqxS4Y8fXT5mYZNPPOadRGJI/Hv+LBKfmP
 wRZwvuQSt3dXjXICQm5Uw8wuFGrJO1Eycust6CEwd5bJMSMcHA6nzUFN5X5VJImvKL1ZbP7XV8F
 bUeZJEZq4RjZ9n/AGvbVz5Z3bLwbluxkGCn9WRYjCTqqQ1vta3DNDFZnBTQyBxOYvkIOQA5is8e
 jYk3XVzzVfBb3kcIJ5DpdMkyIBAYScfl36hkOHTkFjFG4ABwX3ZtlsaemSTMcO67ax51CwJUolR
 d88Yz5/JIonOI5c0bJVUQP2OmCHsyMFzWs7XY+T+ri0zZM6F6QtzLAQQSJl6HnagOpeuStWewx6
 PaoK+XBm+HyiD+RhOv1G8+UPpL0DIzQLHhIqpRDjDn3Z428/I6OE5C4skJmn5GcqqKqg1FKTJue
 tMo1b9++jvruFeHhB0Q==
X-Authority-Analysis: v=2.4 cv=fN80HJae c=1 sm=1 tr=0 ts=698258c8 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=aTUxMAYOms4m9jHcsigA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kHUTgc4jUKePtZDAgXy2_w1AeYJyGPwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030161
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiA+DQo+ID4gUGVyaGFwcyB0aGUgY29uZGl0aW9uIGhlcmUgc2hvdWxkIGJlIG9wdHMtPnF1ZXVl
cyA+IE1BWF9UQVBfUVVFVUVTDQo+ID4gaW5zdGVhZCBvZiBVSU5UX01BWA0KDQoNCj4gSSB3b25k
ZXIgd2h5IHdvdWxkIHdlIHVzZSBNQVhfVEFQX1FVRVVFUyBmb3Igc29tZXRoaW5nIHRoYXQgaXNu
J3QNCj4gYSB0YXAgaW50ZXJmYWNlPyBJdCdzIGFsc28gbm90IGRlZmluZWQgaGVyZSwgd291bGQg
YmUgYSBiaXQgYXdrd2FyZA0KPiB0byBleHBvcnQuDQoNCkZhaXIgcG9pbnQuIEl0IGxvb2tzIGxp
a2UgSSBnb3QgbXkgd2lyZXMgY3Jvc3NlZCBhIGJpdCBoZXJlLiAoQW5kIGFsc28gaW4gbXkNCmNv
bW1lbnQgdG8gdGhlIG90aGVyIHBhdGNoKS4gV291bGQgaXQgYmUgcG9zc2libGUgdG8gaGF2ZSBk
aWZmZXJlbnQNCk1BWF9YWVpfUVVFVUVTIGZvciBvdGhlciBkZXZpY2UgdHlwZXM/DQoNClRoYW5r
cywNCiAgICAgICAgQmVuDQoNCg0KDQo=

