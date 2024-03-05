Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54567C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 00:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhIXj-0001OL-30; Mon, 04 Mar 2024 19:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=879467bc0b=liuxu@meta.com>)
 id 1rhIXg-0001Nc-5W; Mon, 04 Mar 2024 19:20:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=879467bc0b=liuxu@meta.com>)
 id 1rhIXd-0007Iy-WB; Mon, 04 Mar 2024 19:20:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 424N3UdY014836;
 Mon, 4 Mar 2024 16:20:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=s2048-2021-q4;
 bh=HkSfipkXK8j/5lX2dfqEbi3IKb2AZjoTL4qrc8wTxow=;
 b=hbIeaCsdMD8q4CfhiA1hpRpY4HOp3/8dUZLw/hzed4hGt7PBps7ZZbCtgIvL9boH0kwY
 Cq5ZEJUvweDu8cMvN5q2RRz49VHYivcyeqhxcFl/SNaqsJMeaC06TVZ2LQ9ybtOqMa+Y
 di73c/fV7ZeP/Z73kzVdaVd9VLzsJM4fPduB8n2aZY59rvAsjZmyGKYPGU+hWI4hvA7p
 zmPQZwkWatlq4I+01E3AsH9MTe/aE69+AO7oQ2SopD1/81WrWk3/ClaeYW7bcyXb3ujw
 +0LSA03E4j/L4WWzY+m2JNW+pvi2Nrv183sQrKB1hMEmAmjIP90BXLplJqroONLNrfy5 dg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by m0001303.ppops.net (PPS) with ESMTPS id 3wndewvrku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Mar 2024 16:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFGJYof1YRcvj7jC0asa0kxQ5vzy+9Ct/atoghjkHuBidfeV6Hgc9W98dkm7FcPa4QAcrvmH2UorsxvW6uZoA4YlHmqyYk1PolC8LltCwnW9seLE4aNX/vGuAS2+57lvVpeJOG1PLiCPybmdhXSqE3Yrbz+gEBLkrSAir8J6cKM8SWCFp3exUFif3W+HJBQkY2EWTO8mydzjEh99R8ifhTzxQxHXmGRYXLsMGNWbNrNgAKOM2h7zixmn6jauvsg7BJUZrGj0lDhn4kYGAInWyztvRGAkpxWPewm7U8aDU/hQ1Cw0CyQjDiYZw6y7k0JGBnxLmpWYm/IREdv6O+FAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbcJtQwN4GVlWDlnnwIkJ4j5VuSFV6F2EDwBi25u17k=;
 b=Zvv2JRf3e3n+5M42VS1msWg+KVW/uxQV2PCXHPu5aLIFam3XNx3/dGt3YkuHHmV0QtxApJ1k9/c8NLPOClz6j/rS1iaD1e1gsA4EoHELfBI7n/RjUH6AvAyL9nbZmV4r4kV9+piYYLdaMlcy8c7a3UPftsB+F6lNVoBeefMvS88SfgvHKK9xHodzCn93wJ8oNCb788z6sB5+ARynNkm5+P8tqNV7CKERIJmkyVMZCxhf9j/zl/JfIDNRVK4C09RuqfCmmt3CC75NN/AzX+zxKuOQas27Yyaw4Fp172g0tmtZvsHoeyJPIR1hr38Ps9IPKLQS7V9v/UiU/9nMJGTuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV2PR15MB5381.namprd15.prod.outlook.com (2603:10b6:408:17b::19)
 by CH3PR15MB6020.namprd15.prod.outlook.com (2603:10b6:610:156::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 00:20:17 +0000
Received: from LV2PR15MB5381.namprd15.prod.outlook.com
 ([fe80::37d6:5fd8:7aab:f754]) by LV2PR15MB5381.namprd15.prod.outlook.com
 ([fe80::37d6:5fd8:7aab:f754%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 00:20:17 +0000
From: Xu Liu <liuxu@meta.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Xu Liu <liuxu@meta.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org"
 <qemu-discuss@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: Why does the vmovdqu works for passthrough device but crashes for
 emulated device with "illegal operand" error (in x86_64 QEMU,
 -accel = kvm) ?
Thread-Topic: Why does the vmovdqu works for passthrough device but crashes
 for emulated device with "illegal operand" error (in x86_64 QEMU, -accel =
 kvm) ?
Thread-Index: AQHabo04wRtF8dyeXkm8NyRZGDdmMbEoSKaA
Date: Tue, 5 Mar 2024 00:20:17 +0000
Message-ID: <08DC9779-75C2-4A0B-BA0D-21235F2A4AA4@fb.com>
References: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
 <20240304145932.4e685a38.alex.williamson@redhat.com>
 <51e57a7c-c8a1-4a18-a08b-d2c8fd5b35b3@redhat.com>
In-Reply-To: <51e57a7c-c8a1-4a18-a08b-d2c8fd5b35b3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR15MB5381:EE_|CH3PR15MB6020:EE_
x-ms-office365-filtering-correlation-id: c3d8603a-808b-4ac4-a588-08dc3caa095a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6MN77bm5d/81z0ZcAKzerEsVvuW+cG7Rxef9fCExOv/E5iNaukiS2oxZ96JKmLgKuammUgUa4YcVP+a7asAxrtMAdrDj/mTOUCMZTgwWKISjQzhl8db/ZlCUq4LcS9ohovGMEmcPAThwqR80WwQH19cJ10yNd5N3EZrFv0wUBa9diGY3fmnG7Z8tr/bPWXBzLFVFhM0lkXNT1dhO+i6aoTrTS5oU8BXIcBSYsCqBY1Daln3qy5ElqTGe2KSki4OR9DdONFEyZzqp28fuexyp2vNCsGQlrWlSWwIPexXtvoRftLxfzCofPUJcj3/IRdjLxSMYyZR6a8dfCOA5qnRTpV8PwZ0tdRuTP1PXIR3e9ZCE6U25wgPt/xwaa/md87oT1XnCoqzl1DNVJAi0Re5tXm+kpmjMrFIprunnpWvXK+b5LqdQ8xXPWnL+EDHUbP2GdKiaKIUa7FRQ0rRtVRs5KuU67dneF5CN+4T66ZV7vJDCA25kkV0xcA4argEKxuKmUefU75rCHwXqeYf3axIdBxgWJXdf33NFjb8EF/xkZt9etyVxMU7HF4eKrp+7uxdC5CxOa/dQCYGX9hm7ca4nR3tBVeG1EjZ7aMTUu4t9OpzSpq+sls8eLCgtPZZ/Zd+tjQJDMvgzti/sO/oXdSyNP6Cyw00JE8WiHLWD2BTlJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR15MB5381.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUNJc21XazNDMXpwcXRDRi82TFhJUWFZblpmeXQ2S1VHaVVuVVJQcGlkSzI0?=
 =?utf-8?B?MzdWdE9ab2dSeWE4N2xaVWpkb3BQOWNnaFQwY2crK3NSaExNSDV5V1EwOXBU?=
 =?utf-8?B?RnBWZTRieFR1amNhT2lFN1BQb2s5KzFnSlZKSVJvQzY3czlFaGRCWjZMTTJW?=
 =?utf-8?B?bUE4bnJ0dDdWS3VoWFZodUM3MXVCcVV1cVpYckcxR3J6ZlhrOFZNb1VMT0lL?=
 =?utf-8?B?ci9FZXBnNFc2Ni9XRXMwWmUyWm8rTUtIMHJERnJZZEtzSnNENDNsbGxYcTJK?=
 =?utf-8?B?VlNDcmtuOU9QaGp1ZU5zNmhnVnVSZExCOVY2Vm81T2VVUEc4RU1KUDIxbDYw?=
 =?utf-8?B?MHkwVzJQZFgyb1p0NDF2bm1kcXg1Y1FTK3UveDE4cUZ4U0lKSkhEUGM1ZXdz?=
 =?utf-8?B?NHd5V09xRzJhbVJUeUMvVTlEWnJxTGZqQUdNU2t1YkY0K3lhMnBEc29xTWVR?=
 =?utf-8?B?L3NpaUQ2a2hoRTZvUkVINWp5aWcvWXEzMGJTSWRRcTRudFg0QnhCWlJOZzVX?=
 =?utf-8?B?bzBkVks0b1RKYXR4cFNuZ0k0dFI2UW5BOHFSOHNTTWM2ZmhEMlN2UnY4ZVky?=
 =?utf-8?B?VHk3Kzl1Q2xDNHJZdlVQSmNFL3Z6UTJXWE8rY2cyYytNS2FQU2dWN1p6UDRo?=
 =?utf-8?B?UkJkUkpGdmV2bkZGUXpMb2NxNDRYZG4rV3BoTG5MWnNOVVZlZGh0SHFialhh?=
 =?utf-8?B?VXRCLzVkWmZHM1V1aURMR2NVVVhSTzFkWEZPNnoxYmpsMzAvV2I3Wlh1VlZW?=
 =?utf-8?B?VDVxRGxoa2lwNjFmZFkwTHhRWjhVVnNsTjBxWksrN1Z4dC9IUmkxOTU5eEdR?=
 =?utf-8?B?TXVNZXdIQndBeERlMnhuTXdOWFphY0k1ME5XT2c4K0hIcm9WQlhmVm15WUxM?=
 =?utf-8?B?VWhZOEVlOGNaL0tjcno0SjU5U0dpQVdPa1V1dkdiNTVTeXpTR2ZPNEZobis4?=
 =?utf-8?B?ZXpEZUtmTHduR2Q2ZWRpaTlyd2hPQUNxeFpWWTRmbE9rSkxyQ2tOdDdBVFNu?=
 =?utf-8?B?MXFhVHlhejBHSHE3c09RNithUDNiUU9GakQ3T3R2MURwcTA5TllhaytTUm5W?=
 =?utf-8?B?ZElHRkVzZ3NpWnVJOCt0ci9CK3IyamFMMGlzaERFanF1TGtTZkx6aFFDT0Ro?=
 =?utf-8?B?dlpBWHRyTVBHelREQzhibXczRmNBYyt6djJ4eTlkYXN6ODY5MTA3RDdKQ2Ra?=
 =?utf-8?B?QmZyOFhiUkdQazVBWlJ3Q0Q1QjNxemkyOFN1MXdHTlRLa2l3TmY3YnNhUi9s?=
 =?utf-8?B?ZDc2TVZhLy9TMUJpQXFRU01rL3Z4V0NURU9YR0NwWUwwZEtJU1hJRTQxUk15?=
 =?utf-8?B?dlJNQWVNWFNSbWhNVVdaYjJBaHFmU04zRmUyV2lkZVZuSUJBRjRnY0hFckEv?=
 =?utf-8?B?WkNFblpHTm4wbWsxZytlbmh0ZHJMeUl1Y2pjTU5oK1FOeksvNk9jZkhKR2JU?=
 =?utf-8?B?WEd5U1lxcVhTbm9od3dtemhmNTdvRHU2a01CcVc5Vm1vdDlZSW5lYmJQaTlS?=
 =?utf-8?B?NGlsSFZyaVhFOGpvNUh4NFhmN2NaL2JHZGFyS1kzWVhUUUZSUXhyT2RTS3NH?=
 =?utf-8?B?d3pabGdaY1Nta0VmaGswTFEyRHJocmZ0TjVCY0o4SUNaVHlJc0xjWm50U2NI?=
 =?utf-8?B?ZU5lYm1NSEYrM1ptV3pvbk9KYldqUVhlRm9XSEFDdkx2c1UxV2kxeGYzeEpF?=
 =?utf-8?B?OGRPbzU4TGY3N3l5WEp1S2tkZHprbVhudVBYYWNGM3MvUzVPVm9xWVJEQzdS?=
 =?utf-8?B?R3VKS2NKOHp6Y1JKVWo1SzYyNVhrK2hXNjZvLzI4bUFxYjU5RkFtS05waU1R?=
 =?utf-8?B?VE5NSVRMNUtyNjJlUjhUSEdvSndpV0tZTXhPL3RING4wYXZwNmlJa2IvSDE1?=
 =?utf-8?B?MzRUbmtYWlRHS1VuaEQ3NkZYN0RVUytoa3MvU09ERmcram12Z0w5eVY4RHVY?=
 =?utf-8?B?NHlHL2NuUVBjZ2lNRUwzdTloR0J4SSsxWmUyUnpWeGJXd0FDbE8yN21yZjhv?=
 =?utf-8?B?SERFeE13d3E1WE94c09EemVMRFphTUlGeTFCQ1lkemd1djJ5YVY1T1UwUXMz?=
 =?utf-8?B?bGJLbGZFZG9VMHF2ZXgvSGZXSS9yd0ZldTg2K0xRN2p4KzB4TkN2U2dLNjd1?=
 =?utf-8?B?dU9HWTFzSkJiWGE1M2RINlVPRlhxR0JjelY3dTc3c3gyQlZZUytRMVhSMyt2?=
 =?utf-8?B?anc9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_08DC977975C24A0BBA0D21235F2A4AA4fbcom_"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR15MB5381.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d8603a-808b-4ac4-a588-08dc3caa095a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 00:20:17.8727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VduajVe+J9X4FFH2Kfm4zm0aNvO7BL5XZie4XGZZcbzGe92c5qiYW4/B9ym4al4F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6020
X-Proofpoint-ORIG-GUID: Kvt5p6lNd4nFNXKEJYBHnkl_mQFhXWpH
X-Proofpoint-GUID: Kvt5p6lNd4nFNXKEJYBHnkl_mQFhXWpH
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=879467bc0b=liuxu@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_08DC977975C24A0BBA0D21235F2A4AA4fbcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGV5IFBhb2xvLA0KVGhhbmtzIGZvciBjb25maXJtaW5nIHRoYXQgdGhlIEFWWCBpcyBub3Qgc3Vw
cG9ydGVkIGZvciBNTUlPIHNwYWNlLg0KDQpTbyBmb3IgdGhlIGVtdWxhdGVkIGRldmljZSwgIGJh
c2ljYWxseSBJIGhhdmUgdG8gZm9yY2UgdGhlIGNvbXBpbGVyIGF2b2lkIHVzaW5nIHZtb3ZkcXUg
Lg0KDQpJIGFtIGN1cmlvdXMgYWJvdXQgaG93IGt2bSBlbXVsYXRlcyB0aG9zZSBpbnN0cnVjdGlv
bnMuIERvIHlvdSBtaW5kIHNoYXJpbmcgc29tZSByZWxhdGVkIGNvZGUgcG9pbnRlciA/DQoNClRo
YW5rcywNClh1DQoNCk9uIE1hciA0LCAyMDI0LCBhdCA2OjM54oCvUE0sIFBhb2xvIEJvbnppbmkg
PHBib256aW5pQHJlZGhhdC5jb20+IHdyb3RlOg0KDQohLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNClRoaXMgTWVzc2Fn
ZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KDQp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCg0KT24gMy80LzI0
IDIyOjU5LCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6DQpTaW5jZSB5b3UncmUgbm90IHNlZWluZyBh
IEtWTV9FWElUX01NSU8gSSdkIGd1ZXNzIHRoaXMgaXMgbW9yZSBvZiBhIEtWTQ0KaXNzdWUgdGhh
biBRRU1VIChDYyBrdm0gbGlzdCkuICBQb3NzaWJseSBLVk0gZG9lc24ndCBlbXVsYXRlIHZtb3Zk
cXUNCnJlbGF0aXZlIHRvIGFuIE1NSU8gYWNjZXNzLCBidXQgaG9uZXN0bHkgSSdtIG5vdCBwb3Np
dGl2ZSB0aGF0IEFWWA0KaW5zdHJ1Y3Rpb25zIGFyZSBtZWFudCB0byB3b3JrIG9uIE1NSU8gc3Bh
Y2UuICBJJ2xsIGxldCB4ODYgS1ZNIGV4cGVydHMNCm1vcmUgZmFtaWxpYXIgd2l0aCBzcGVjaWZp
YyBvcGNvZGUgc2VtYW50aWNzIHdlaWdoIGluIG9uIHRoYXQuDQoNCkluZGVlZCwgS1ZNJ3MgaW5z
dHJ1Y3Rpb24gZW11bGF0b3Igc3VwcG9ydHMgc29tZSBTU0UgTU9WIGluc3RydWN0aW9ucyBidXQg
bm90IHRoZSBjb3JyZXNwb25kaW5nIEFWWCBpbnN0cnVjdGlvbnMuDQoNClZlY3RvciBpbnN0cnVj
dGlvbnMgaG93ZXZlciBkbyB3b3JrIG9uIE1NSU8gc3BhY2UsIGFuZCB0aGV5IGFyZSB1c2VkIG9j
Y2FzaW9uYWxseSBlc3BlY2lhbGx5IGluIGNvbWJpbmF0aW9uIHdpdGggd3JpdGUtY29tYmluaW5n
IG1lbW9yeS4gIFNTRSBzdXBwb3J0IHdhcyBhZGRlZCB0byBLVk0gYmVjYXVzZSBzb21lIG9wZXJh
dGluZyBzeXN0ZW1zIHVzZWQgU1NFIGluc3RydWN0aW9ucyB0byByZWFkIGFuZCB3cml0ZSB0byBW
UkFNLiAgSG93ZXZlciwgc28gZmFyIHdlJ3ZlIG5ldmVyIHJlY2VpdmVkIGFueSByZXBvcnRzIG9m
IE9TZXMgdXNpbmcgQVZYIGluc3RydWN0aW9ucyBvbiBkZXZpY2VzIHRoYXQgUUVNVSBjYW4gZW11
bGF0ZSAoYXMgb3Bwb3NlZCB0bywgZm9yIGV4YW1wbGUsIEdQVSBWUkFNIHRoYXQgaXMgcGFzc2Vk
IHRocm91Z2gpLg0KDQpUaGFua3MsDQoNClBhb2xvDQoNCklzIHlvdXIgInByb2dyYW0iIGp1c3Qg
ZG9pbmcgYSBtZW1jcHkoKSB3aXRoIGFuIG1tYXAoKSBvZiB0aGUgUENJIEJBUg0KYWNxdWlyZWQg
dGhyb3VnaCBwY2ktc3lzZnMgb3IgYSB1c2Vyc3BhY2UgdmZpby1wY2kgZHJpdmVyIHdpdGhpbiB0
aGUNCmd1ZXN0Pw0KSW4gUUVNVSA0YTJlMjQyYmJiMzAgKCJtZW1vcnk6IERvbid0IHVzZSBtZW1j
cHkgZm9yIHJhbV9kZXZpY2UNCnJlZ2lvbnMiKSB3ZSByZXNvbHZlZCBhbiBpc3N1ZVsxXSB3aGVy
ZSBRRU1VIGl0c2VsZiB3YXMgZG9pbmcgYSBtZW1jcHkoKQ0KdG8gYXNzaWduZWQgZGV2aWNlIE1N
SU8gc3BhY2UgcmVzdWx0aW5nIGluIGJyZWFraW5nIGZ1bmN0aW9uYWxpdHkgb2YNCnRoZSBkZXZp
Y2UuICBJSVJDIG1lbWNweSgpIHdhcyB1c2luZyBhbiBTU0UgaW5zdHJ1Y3Rpb24gdGhhdCBkaWRu
J3QNCmZhdWx0LCBidXQgZGlkbid0IHdvcmsgY29ycmVjdGx5IHJlbGF0aXZlIHRvIE1NSU8gc3Bh
Y2UgZWl0aGVyLg0KU28gSSBhbHNvIHdvdWxkbid0IHJ1bGUgb3V0IHRoYXQgdGhlIHByb2dyYW0g
aXNuJ3QgaW5oZXJlbnRseQ0KbWlzYmVoYXZpbmcgYnkgdXNpbmcgbWVtY3B5KCkgYW5kIHRoZXJl
YnkgaWdub3JpbmcgdGhlIG5hdHVyZSBvZiB0aGUNCmRldmljZSBNTUlPIGFjY2VzcyBzZW1hbnRp
Y3MuICBUaGFua3MsDQpBbGV4DQpbMV1odHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11Lyti
dWcvMTM4NDg5Mg0KDQoNCg==

--_000_08DC977975C24A0BBA0D21235F2A4AA4fbcom_
Content-ID: <C438BA894B25FF438B3C888C47888879@namprd15.prod.outlook.com>
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJvdmVyZmxv
dy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQpIZXkgUGFvbG8sDQo8ZGl2PlRoYW5rcyBmb3IgY29uZmly
bWluZyB0aGF0IHRoZSBBVlggaXMgbm90IHN1cHBvcnRlZCBmb3IgTU1JTyBzcGFjZS48L2Rpdj4N
CjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PlNvIGZvciB0aGUgZW11bGF0ZWQgZGV2aWNlLCAmbmJz
cDtiYXNpY2FsbHkgSSBoYXZlIHRvIGZvcmNlIHRoZSBjb21waWxlciBhdm9pZCB1c2luZw0KPGI+
dm1vdmRxdSAuPC9iPjwvZGl2Pg0KPGRpdj48Yj48YnI+DQo8L2I+PC9kaXY+DQo8ZGl2PkkgYW0g
Y3VyaW91cyBhYm91dCBob3cga3ZtIGVtdWxhdGVzIHRob3NlIGluc3RydWN0aW9ucy4gRG8geW91
IG1pbmQgc2hhcmluZyBzb21lIHJlbGF0ZWQgY29kZSBwb2ludGVyID88L2Rpdj4NCjxkaXY+PGJy
Pg0KPC9kaXY+DQo8ZGl2PlRoYW5rcyw8L2Rpdj4NCjxkaXY+WHU8YnIgaWQ9ImxpbmVCcmVha0F0
QmVnaW5uaW5nT2ZNZXNzYWdlIj4NCjxkaXY+PGJyPg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
DQo8ZGl2Pk9uIE1hciA0LCAyMDI0LCBhdCA2OjM54oCvUE0sIFBhb2xvIEJvbnppbmkgJmx0O3Bi
b256aW5pQHJlZGhhdC5jb20mZ3Q7IHdyb3RlOjwvZGl2Pg0KPGJyIGNsYXNzPSJBcHBsZS1pbnRl
cmNoYW5nZS1uZXdsaW5lIj4NCjxkaXY+DQo8ZGl2PiEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfDxicj4NClRoaXMgTWVz
c2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcjxicj4NCjxicj4NCnwtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tITxi
cj4NCjxicj4NCk9uIDMvNC8yNCAyMjo1OSwgQWxleCBXaWxsaWFtc29uIHdyb3RlOjxicj4NCjxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiPlNpbmNlIHlvdSdyZSBub3Qgc2VlaW5nIGEgS1ZNX0VYSVRf
TU1JTyBJJ2QgZ3Vlc3MgdGhpcyBpcyBtb3JlIG9mIGEgS1ZNPGJyPg0KaXNzdWUgdGhhbiBRRU1V
IChDYyBrdm0gbGlzdCkuICZuYnNwO1Bvc3NpYmx5IEtWTSBkb2Vzbid0IGVtdWxhdGUgdm1vdmRx
dTxicj4NCnJlbGF0aXZlIHRvIGFuIE1NSU8gYWNjZXNzLCBidXQgaG9uZXN0bHkgSSdtIG5vdCBw
b3NpdGl2ZSB0aGF0IEFWWDxicj4NCmluc3RydWN0aW9ucyBhcmUgbWVhbnQgdG8gd29yayBvbiBN
TUlPIHNwYWNlLiAmbmJzcDtJJ2xsIGxldCB4ODYgS1ZNIGV4cGVydHM8YnI+DQptb3JlIGZhbWls
aWFyIHdpdGggc3BlY2lmaWMgb3Bjb2RlIHNlbWFudGljcyB3ZWlnaCBpbiBvbiB0aGF0Ljxicj4N
CjwvYmxvY2txdW90ZT4NCjxicj4NCkluZGVlZCwgS1ZNJ3MgaW5zdHJ1Y3Rpb24gZW11bGF0b3Ig
c3VwcG9ydHMgc29tZSBTU0UgTU9WIGluc3RydWN0aW9ucyBidXQgbm90IHRoZSBjb3JyZXNwb25k
aW5nIEFWWCBpbnN0cnVjdGlvbnMuPGJyPg0KPGJyPg0KVmVjdG9yIGluc3RydWN0aW9ucyBob3dl
dmVyIGRvIHdvcmsgb24gTU1JTyBzcGFjZSwgYW5kIHRoZXkgYXJlIHVzZWQgb2NjYXNpb25hbGx5
IGVzcGVjaWFsbHkgaW4gY29tYmluYXRpb24gd2l0aCB3cml0ZS1jb21iaW5pbmcgbWVtb3J5LiAm
bmJzcDtTU0Ugc3VwcG9ydCB3YXMgYWRkZWQgdG8gS1ZNIGJlY2F1c2Ugc29tZSBvcGVyYXRpbmcg
c3lzdGVtcyB1c2VkIFNTRSBpbnN0cnVjdGlvbnMgdG8gcmVhZCBhbmQgd3JpdGUgdG8gVlJBTS4g
Jm5ic3A7SG93ZXZlciwNCiBzbyBmYXIgd2UndmUgbmV2ZXIgcmVjZWl2ZWQgYW55IHJlcG9ydHMg
b2YgT1NlcyB1c2luZyBBVlggaW5zdHJ1Y3Rpb25zIG9uIGRldmljZXMgdGhhdCBRRU1VIGNhbiBl
bXVsYXRlIChhcyBvcHBvc2VkIHRvLCBmb3IgZXhhbXBsZSwgR1BVIFZSQU0gdGhhdCBpcyBwYXNz
ZWQgdGhyb3VnaCkuPGJyPg0KPGJyPg0KVGhhbmtzLDxicj4NCjxicj4NClBhb2xvPGJyPg0KPGJy
Pg0KPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+SXMgeW91ciAmcXVvdDtwcm9ncmFtJnF1b3Q7IGp1
c3QgZG9pbmcgYSBtZW1jcHkoKSB3aXRoIGFuIG1tYXAoKSBvZiB0aGUgUENJIEJBUjxicj4NCmFj
cXVpcmVkIHRocm91Z2ggcGNpLXN5c2ZzIG9yIGEgdXNlcnNwYWNlIHZmaW8tcGNpIGRyaXZlciB3
aXRoaW4gdGhlPGJyPg0KZ3Vlc3Q/PGJyPg0KSW4gUUVNVSA0YTJlMjQyYmJiMzAgKCZxdW90O21l
bW9yeTogRG9uJ3QgdXNlIG1lbWNweSBmb3IgcmFtX2RldmljZTxicj4NCnJlZ2lvbnMmcXVvdDsp
IHdlIHJlc29sdmVkIGFuIGlzc3VlWzFdIHdoZXJlIFFFTVUgaXRzZWxmIHdhcyBkb2luZyBhIG1l
bWNweSgpPGJyPg0KdG8gYXNzaWduZWQgZGV2aWNlIE1NSU8gc3BhY2UgcmVzdWx0aW5nIGluIGJy
ZWFraW5nIGZ1bmN0aW9uYWxpdHkgb2Y8YnI+DQp0aGUgZGV2aWNlLiAmbmJzcDtJSVJDIG1lbWNw
eSgpIHdhcyB1c2luZyBhbiBTU0UgaW5zdHJ1Y3Rpb24gdGhhdCBkaWRuJ3Q8YnI+DQpmYXVsdCwg
YnV0IGRpZG4ndCB3b3JrIGNvcnJlY3RseSByZWxhdGl2ZSB0byBNTUlPIHNwYWNlIGVpdGhlci48
YnI+DQpTbyBJIGFsc28gd291bGRuJ3QgcnVsZSBvdXQgdGhhdCB0aGUgcHJvZ3JhbSBpc24ndCBp
bmhlcmVudGx5PGJyPg0KbWlzYmVoYXZpbmcgYnkgdXNpbmcgbWVtY3B5KCkgYW5kIHRoZXJlYnkg
aWdub3JpbmcgdGhlIG5hdHVyZSBvZiB0aGU8YnI+DQpkZXZpY2UgTU1JTyBhY2Nlc3Mgc2VtYW50
aWNzLiAmbmJzcDtUaGFua3MsPGJyPg0KQWxleDxicj4NClsxXWh0dHBzOi8vYnVncy5sYXVuY2hw
YWQubmV0L3FlbXUvK2J1Zy8xMzg0ODkyDQo8YnI+DQo8L2Jsb2NrcXVvdGU+DQo8YnI+DQo8L2Rp
dj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8YnI+DQo8L2Rpdj4NCjwvYm9keT4N
CjwvaHRtbD4NCg==

--_000_08DC977975C24A0BBA0D21235F2A4AA4fbcom_--

