Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52676C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 22:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rguCP-0004Bq-O0; Sun, 03 Mar 2024 17:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8792812522=liuxu@meta.com>)
 id 1rguCN-0004BE-Dn; Sun, 03 Mar 2024 17:20:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=8792812522=liuxu@meta.com>)
 id 1rguCG-0003g7-HW; Sun, 03 Mar 2024 17:20:46 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 423Kg7Xs032414;
 Sun, 3 Mar 2024 14:20:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=from : to : subject :
 date : message-id : content-type : mime-version; s=s2048-2021-q4;
 bh=DOPw2eWJulTORA+hZySmHnFBfNIxOtiyZZYy5bSeteY=;
 b=cHTyBRCk0SQtV0BcvnYRuj+I0K6Ew2v6amKq9rajP8RSfh5H40jeIQFyNc46CKXe3KGn
 dTmBEk2qdDqE/h3aGgFUULJYl21gRa2P1yuVLat0dN5yK+F/fUkwPHnrc1enUQCkCiBH
 mWxEs8kvrukiRtsoWJCJMxU0gvy7nh7u/vK1bVrxYGBsX2JLZl4Nc/3ht9OVLE+Ymsn/
 WjptsfCjvWrVUG+ikX165+usl36xFgRWz6XwO7KHxAyOEewX47y27qQLVJ3ZuROVFepk
 j9wgTr3A/VPA8H0V+0zOOXyht5uuaNyQf0JWiRW1ZZtgG48bisG7BY0sycE603JbT1Nm oA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by m0089730.ppops.net (PPS) with ESMTPS id 3wm0gf4t04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 Mar 2024 14:20:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrNnm2PBG1j37dpOCfdoZqr6tIcEKbGQyWeHthCsCRAIdo21vYWcMrANNDqHiQOy58ik9r3+xJcL6WiA/NveMsxdpFXa/2sfdlKgdO4xZixl1KxgHEWAPrGnRVRrJvC5TW22jF2eOrMV8PfABu0IsjwXl8PWlr48T369P8j5DZPqdHTVgq4gWxq0/vFLbxLdvq5EUcgaeRtwfeBTZlXFymAYWUfsQ34dGDudrxxTZoPmXBDwJQ9RFKeyOgZwWCD/zC1gSIqMVxsmL7HMkNBU9eGpiCAUeROOIpy7WT5szx11zk77l9vFzUXgnmWivcqqC3jFWjOWsRnpGldhgENACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOPw2eWJulTORA+hZySmHnFBfNIxOtiyZZYy5bSeteY=;
 b=NjxxVP2ghiKBHQOQrltl91yGQUOG4wT85kTy395nlihxQbtmsoCLL2O7xda1VMTuWDbYt8lEHE0UdyorvBAzwSg0dFZfjN9gd/eNuT/dmL8jTZtN15vXoqBHCaaPo2chjYKz62OElFPWgg2lDbuueNsRbfgh8qp6282j3O+cNayP+i+gNjhA9t0kuLJv3917bjO/ImIV7vpWyDRt07HyXwb5LhmT7lDBrhdvwPaT+Rs8dZHWG4xE8CrJJWh338wGJdqm9sOYVaziGKmnANUBs2KHlIB66FVsJxsLXOUbttrI0dXC7tgCaHXf+ytkf6qbYdJbcc9pFLyKNGDVcrwxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV2PR15MB5381.namprd15.prod.outlook.com (2603:10b6:408:17b::19)
 by CO1PR15MB4875.namprd15.prod.outlook.com (2603:10b6:303:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Sun, 3 Mar
 2024 22:20:34 +0000
Received: from LV2PR15MB5381.namprd15.prod.outlook.com
 ([fe80::37d6:5fd8:7aab:f754]) by LV2PR15MB5381.namprd15.prod.outlook.com
 ([fe80::37d6:5fd8:7aab:f754%5]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 22:20:33 +0000
From: Xu Liu <liuxu@meta.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org"
 <qemu-discuss@nongnu.org>
Subject: Why does the vmovdqu works for passthrough device but crashes for
 emulated device  with "illegal operand" error (in x86_64 QEMU, -accel = kvm)
 ?
Thread-Topic: Why does the vmovdqu works for passthrough device but crashes
 for emulated device  with "illegal operand" error (in x86_64 QEMU,  -accel =
 kvm) ?
Thread-Index: AQHabbkCGtVFr819K0iEqdQd63+zVw==
Date: Sun, 3 Mar 2024 22:20:33 +0000
Message-ID: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR15MB5381:EE_|CO1PR15MB4875:EE_
x-ms-office365-filtering-correlation-id: 371e2d14-66a3-4139-300a-08dc3bd024dc
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YYCA5NEMIv0X6XUppcJSWRsvG/Es26hCx9TXg0vRqiU8uVNBxShL/Ia2b07hKqqcUw6DwND2iK1uUqzEhnMqozYLL5onRLvkpUXEAjdX7K7o0PkvacFvCbggoh6wdqbRydRGC1BESqctlS21rsYPbC86MeNzHB4SkfuA1GjrXPE4Yr+CbIqvhR8ab+DMuw3KUpr/8CHRWT9YBxMi1qACBdu2HXYAy5dk7Dpn3l88skrxNmFchPI3huaKX5rsNtIP4j6atHus6qIiuNcRGUrtHLoGK7rDnOw/aowNhkT4LxlIURu52y67a+Xjj+D48OWxP7ef7QPTXVZB5xzEuUReMw0PDA0qBOkTSWiDcyG7BgdsEU1ITR92GjYQ62vEjPhCpi8iMzHamj86KFHCnJVdqe8c6fAYhc0AafHOBf/5EqO/dSjihJLv7E9nSIjgMBzpWb5N9wxTtGKXW4sOCWq1Z+qBoVGji0OwnvtV1Tc1vZpsP1AzQkERwbdYKY+ipPfNDMEOewPBL7J7XED/O3HqvVpXdGhLpZgtnZM86IKBs3Hmn3EGBW/2Z7NRhvD6DVqZmPiqXYT1KmhfVmnt8wH5mP0b+EAA3FFcrdw4Qr6Qcd5C/fAEJbqthE1DhCfxN1S/5JKsxWP8czKSFDa17GgCBmtIKbJaL4YsxspKG5UFGEXy/mSy08k4/uX4EA2QQDPe4ALHRtSVZ/ONFPNsuc3lGLMK0mYVTkeroe6PsDkIeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR15MB5381.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRIc1haTEorVGVoUEJiYi96MEhIeXNNRnZ2bi90ejNHVFQ0ZU9SaWJoaXlR?=
 =?utf-8?B?NjdZZHJlRmZEUmtWZlp2dlJ2TTJxdlA4di91YTNoUGlyNjNWK0twNGlFdUFq?=
 =?utf-8?B?TnJ5ZWxOeXdnc25nMUNyYUFQcklpMTFBdk1yTDh4WWRZbkNzLzN4OXZqTHBE?=
 =?utf-8?B?blYvbDVsZjZNaEptTmFua29ndVgzM3BtMHRuZm9WQ0RvZ0xjSnpvL2ZJcjNW?=
 =?utf-8?B?VGhnc1VBQUVpTDVrcm9CT1JSWFB6ZWZHZDk2cit1MGg2cnl1eTZGdTRnekNt?=
 =?utf-8?B?cnVKOUhoKzRKb1M2b01rS2xoYVRaUVZxMXpaVThObUZ3Yzl0YkxkVEdhenVC?=
 =?utf-8?B?b2lPZlNNTnd1aVI3NGJuREZMZEs2QnQ2ZWF4Y3NMQ3gvaWxRdVVOSThyTG1R?=
 =?utf-8?B?R2lKRTVncmVUT0RIZzJ1czRQRFN5aTYvRUtCOUZGbVRRYU45VVBLV2xGOFVU?=
 =?utf-8?B?L1ZSTlpNREV6K21qdUpnWDZKS3ZWUFRLTnIySkI3UWdWUzFCZVVSbmdkZ3cy?=
 =?utf-8?B?dkZ3YkNha0lsUDFyd25ZNGRwVEM4VWFwbnVvejg5T2FOVWg4YTEvT1JEcTlu?=
 =?utf-8?B?YU1VdE1IRFE4elVyN3NaQ2JSTnBJMFVsKzB1NXNhOHZ2YlVEYXk5bGhYSTJF?=
 =?utf-8?B?VnBxSFRsbVJmRTJXalE3eFNMUkZKeWFlcGRidG1zS2duRWkrTWRXckFQd3lC?=
 =?utf-8?B?Qit1K21aeGZSQXVOMHBUVlBHb1oybithOXpFeHluYjZTbDg1ajJENFRQdEZa?=
 =?utf-8?B?eUppNnA5ODByNXdoRmd0MzdFMUU2RUJDY09oTUg0V09Sc3ZqdzJVdW8zTDRN?=
 =?utf-8?B?NkRsbGNVZXBTRktRU1JwblhVMGhyamNiVlBTc2JWaGdybytzNTRhbmtZOGlj?=
 =?utf-8?B?b0JzWTRCeFE0ME5aZklGVkdTUm9ORExpaC9DWEE5eG5lcHJ4UEViV3hNdHkw?=
 =?utf-8?B?L0ZsWko4UEZVT3ptY3VzTHhBMU82Nk9mWlhrTGZReC9DZitrRWFvVlJjWlVv?=
 =?utf-8?B?U3g5SVB4MnppcDlpU09PdTR3NXM0YytkakdwMVorUExlQXhMdHZidjk4NFFz?=
 =?utf-8?B?Z1BUREZRbUFqVTJpWkpjUklxdGErdVJ1ZmI1MStTeldWL2QrdW9MaFNJLzky?=
 =?utf-8?B?R1VubjZvWk9nRzc5blhoK3lxTDdZK2NxSGl4WTdhTFNCcEZnZFJzQWUvdDVk?=
 =?utf-8?B?MGwvZnNpS21rV01RQ1FTdkZ5cURYR0U4M2FMc1ZjWGhEQ2V1aXQvM1pIYmxU?=
 =?utf-8?B?NDNSYWFmQ3lRMHFMaWMzaFpYeXl1MEpYazBWQjJTdm55N3VNYXhmZVpCd1M2?=
 =?utf-8?B?K1dzck5kYWZ2NUo2VHJzVHo3SkU4TWkrV0F5OUFnTHN5TUsyYVRhSTRhMjFC?=
 =?utf-8?B?eUV3bmhkNUtZclQ4SlIyd1RmVUhvdFRST3p4NlJCS0JtZDl5amJtSGNmSm9H?=
 =?utf-8?B?Ti9Ra3dUdG1BUTYwVk1uaE9lblpvRFk3YjlEUS9KeEVnOGZMa0YvYUZzSnda?=
 =?utf-8?B?ZUZxVTFXUUUwdUl2YkFsRStNa2RPeENGaXREWWlaZnNBaVFjWG96UmJnRHRq?=
 =?utf-8?B?bjk5M0VFS0thaUxhY09KM2MxYzErRVNFa3N1TEFZcUVLSEdoMzRodVF6TXpy?=
 =?utf-8?B?YXRYU1BMZ2ZSWXNIVG9xTjdZZWJTbkQzOFFnTzF4RW9HaUJPdVpVbENWc25G?=
 =?utf-8?B?bklVdzdXRlhVQzUvcnNxRmcvMC9HUVY4VEFqblhJQTJYbGFWSFF5Y2dXdFE3?=
 =?utf-8?B?c2FCcWdLTTRMWkYrUGlFcERpQ1llWFExWTFsdW5MWVFKVUN1RnRIRmJQUCtG?=
 =?utf-8?B?Y0ZZaHppQ0kxdzM1TDdWMjU2bW4xY25uQUhaUXA5MGdNbzcwUjRsYXpITXlD?=
 =?utf-8?B?c0hpME5sWUdwZ3QxNmd3c2xkQUxWT2Nna25neUtBeDdieWNnU0N2NEMvSWdU?=
 =?utf-8?B?OGM2SzdvQWU5anVaamV5ZHQvS2UrdzdXQ3lYRE8vTUYvL2NHRkN3KzNFRkkz?=
 =?utf-8?B?T1pRRDZPQnFNTmttZjA2QndQNVFGY1c4QmM0UGZNbUlQZlluQ0RXbmt1SERw?=
 =?utf-8?B?TDZ0L1NtWS85ViszODZKWmpHWjcxSk1NRUc4ZlhWTFNtMG9WWmJVUnJmcmM3?=
 =?utf-8?B?TG84MUFRYzh4SUNMK3YzNWhtWHFncmhCL0ZJSTZyL21HVjdwNlVNaG80ejQv?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_39E9DB135FA34D1AA5737D58BA83B35Cfbcom_"
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR15MB5381.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371e2d14-66a3-4139-300a-08dc3bd024dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 22:20:33.6991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBSY7hRkyNo4ToWQ01+Yy9YuK0vqEs784BrY+HXmvNVKxsIw1Lb4pilTQ+fTqRFc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4875
X-Proofpoint-ORIG-GUID: TFzULSOlsXXeAPYFJu1te-HrtmOkg4Kh
X-Proofpoint-GUID: TFzULSOlsXXeAPYFJu1te-HrtmOkg4Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-03_12,2024-03-01_03,2023-05-22_02
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=8792812522=liuxu@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--_000_39E9DB135FA34D1AA5737D58BA83B35Cfbcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNClJlY2VudGx5IEkgYW0gcnVubmluZyBteSBwcm9ncmFtcyBpbiBRRU1VICh4ODZf
NjQpIHdpdGgg4oCcLWFjY2VsPWt2beKAnS4gIFRoZSBRRU1VIHZlcnNpb24gaXMgNi4wLjAuDQoN
CkkgcnVuIG15IHByb2dyYW1zIGluIHR3byB3YXlzOg0KDQoxLiAgIEkgcGFzcyB0aHJvdWdoIG15
IGRldmljZSB0aHJvdWdoIHZmaW8tcGNpICB0byBRRU1VLCAgdGhpcyB3YXkgd29ya3Mgd2VsbC4N
Cg0KMi4gIEkgd3JpdGUgYW4gZW11bGF0ZWQgUENJIGRldmljZSBmb3IgUUVNVSwgYW5kIHJ1biBt
eSBwcm9ncmFtcyBvbiB0aGUgZW11bGF0ZWQgUENJIGRldmljZS4NCiAgICAgVGhpcyBjcmFzaGVz
IHdoZW4gIHRoZSBjb2RlIHRyeSB0byBkbyBtZW1vcnkgY29weSB0byBQQ0kgZGV2aWNlIHdoZW4g
dGhlIGRhdGEgbGVuZ3RoIGlzIGxvbmdlciB0aGFuIDE2IGJ5dGVzLg0KICAgICBXaGlsZSB0aGUg
IHBhc3N0aHJvdWdoIGRldmljZSB3b3JrcyB3ZWxsIGZvciB0aGUgc2FtZSBzaXR1YXRpb24uDQoN
Cg0KQWZ0ZXIgIGR1bXAgdGhlIGFzc2VtYmx5IGNvZGUuICBJIG5vdGljZWQgd2hlbiB0aGUgZGF0
YSBpcyA8PSAxNiBieXRlcywgIHRoZSBtb3YgYXNzZW1ibHkgY29kZSBpcyBjaG9zZW4sIGFuZCBp
dCB3b3JrcyB3ZWxsLg0KDQpXaGVuIHRoZSBkYXRhIGlzID4gMTYgYnl0ZXMsICB0aGUgdm1vdmRx
dSAgYXNzZW1ibHkgY29kZSBpcyBjaG9zZW4sIGFuZCBpdCBjcmFzaGVzIHdpdGgg4oCcaWxsZWdh
bCBvcGVyYW5k4oCdLg0KDQpHaXZlbiB0aGUgY29kZSBhbmQgZGF0YSBhcmUgZXhhY3RseSBzYW1l
IGZvciBib3RoIHBhc3N0aHJvdWdoIGRldmljZSBhbmQgZW11bGF0ZWQgZGV2aWNlLiAgSSBhbSBj
dXJpb3VzIGFib3V0IHdoeSB0aGlzIGhhcHBlbnMuDQoNCkFmdGVyIHR1cm4gb24gIGtlcm5lbCB0
cmFjZSBmb3Iga3ZtIGJ5ICAgZWNobyBrdm06KiAgIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcv
c2V0X2V2ZW50DQpBbmQgcmVydW4gdGhlIFFFTVUgYW5kIG15IGNvZGUgZm9yIGJvdGggcGFzc3Ro
cm91Z2ggZGV2aWNlIGFuZCBlbXVsYXRlZCBkZXZpY2UsIEkgbm90aWNlZCB0aGF0Og0KDQoxKSBm
b3IgcGFzc3Rocm91Z2ggZGV2aWNlLCAgSSBkaWRu4oCZdCBzZWUgIGFueSB0cmFjZSBldmVudHMg
cmVsYXRlZCB0byBteSAgZ3ZhIGFuZCBncGEuICBUaGlzIG1ha2VzIG1lIHRoaW5rIHRoYXQgdGhl
IG1lbW9yeSBjb3B5IHRvIFBDSSBkZXZpY2Ugd2VudCB0aHJvdWdoIGRpZmZlcmVudCBjb2RlIHBh
dGggLiBJdCBpcyBoYW5kbGVkIGJ5IHRoZSBndWVzdCBPUyB3aXRob3V0IGV4aXQgdG8gVk1YLg0K
DQoyKSBmb3IgZW11bGF0ZWQgZGV2aWNlLCBpZiBJIHVzZSAgIGNvbXBpbGVyIGZsYWcgIHRhcmdl
dC1mZWF0dXJlPS1hdngsLWF2eDIgdG8gZm9yY2UgY29tcGlsZXIgdXNlICBtb3YgYXNzZW1ibHkg
Y29kZSwgIEkgY2FuIHNlZSB0aGUgbWVtb3J5IGNvcHkgZ29lcyB0aHJvdWdoIHRoZSBLVk1fRVhJ
VF9NTUlPLCBhbmQgZXZlcnl0aGluZyB3b3JrcyB3ZWxsLg0KICAgIGlmIEkgZG9u4oCZdCBmb3Jj
ZSB0aGUgY29tcGlsZXIgdXNlIG1vdiAsICB0aGUgY29tcGlsZXIganVzdCBjaG9vc2VzIHRoZSB2
bW92ZHF1ICwgIHdoaWNoIGp1c3QgY3Jhc2ggdGhlIHByb2dyYW1zLCBhbmQgbm8gS1ZNX0VYSVRf
TU1JTyByZWxhdGVkIHRvIG15IG1lbW9yeSBjb3B5IGFwcGVhcnMgaW4gdGhlIHRyYWNlIGV2ZW50
cy4gTG9va3MgbGlrZSB0aGUgZ3Vlc3QgT1MgaGFuZGxlcyB0aGUgY3Jhc2guDQoNCg0KQW55IGNs
dWUgYWJvdXQgd2h5IHRoZSB2bW92ZHF1IHdvcmtzIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UgYnV0
IG5vdCB3b3JrIGZvciBlbXVsYXRlZCBkZXZpY2UuDQoNClRoYW5rcw0KDQo=

--_000_39E9DB135FA34D1AA5737D58BA83B35Cfbcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <5EACA0FD9F7B614CB051256130FC294D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHN0eWxlPSJvdmVyZmxv
dy13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6
IGFmdGVyLXdoaXRlLXNwYWNlOyI+DQpIZWxsbywNCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PlJl
Y2VudGx5IEkgYW0gcnVubmluZyBteSBwcm9ncmFtcyBpbiBRRU1VICh4ODZfNjQpIHdpdGgg4oCc
LWFjY2VsPWt2beKAnS4gJm5ic3A7VGhlIFFFTVUgdmVyc2lvbiBpcyA2LjAuMC48L2Rpdj4NCjxk
aXY+PGJyPg0KPC9kaXY+DQo8ZGl2PkkgcnVuIG15IHByb2dyYW1zIGluIHR3byB3YXlzOjwvZGl2
Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+MS4gJm5ic3A7IEkgcGFzcyB0aHJvdWdoIG15IGRl
dmljZSB0aHJvdWdoIHZmaW8tcGNpICZuYnNwO3RvIFFFTVUsICZuYnNwO3RoaXMgd2F5IHdvcmtz
IHdlbGwuPC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRpdj4yLiAmbmJzcDtJIHdyaXRlIGFu
IGVtdWxhdGVkIFBDSSBkZXZpY2UgZm9yIFFFTVUsIGFuZCBydW4gbXkgcHJvZ3JhbXMgb24gdGhl
IGVtdWxhdGVkIFBDSSBkZXZpY2UuICZuYnNwOzwvZGl2Pg0KPGRpdj4mbmJzcDsgJm5ic3A7ICZu
YnNwO1RoaXMgY3Jhc2hlcyB3aGVuICZuYnNwO3RoZSBjb2RlIHRyeSB0byBkbyBtZW1vcnkgY29w
eSB0byBQQ0kgZGV2aWNlIHdoZW4gdGhlIGRhdGEgbGVuZ3RoIGlzIGxvbmdlciB0aGFuIDE2IGJ5
dGVzLjwvZGl2Pg0KPGRpdj4mbmJzcDsgJm5ic3A7ICZuYnNwO1doaWxlIHRoZSAmbmJzcDtwYXNz
dGhyb3VnaCBkZXZpY2Ugd29ya3Mgd2VsbCBmb3IgdGhlIHNhbWUgc2l0dWF0aW9uLjwvZGl2Pg0K
PGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PkFmdGVyICZuYnNwO2R1
bXAgdGhlIGFzc2VtYmx5IGNvZGUuICZuYnNwO0kgbm90aWNlZCB3aGVuIHRoZSBkYXRhIGlzICZs
dDs9IDE2IGJ5dGVzLCAmbmJzcDt0aGUNCjxiPm1vdjwvYj4mbmJzcDthc3NlbWJseSBjb2RlIGlz
IGNob3NlbiwgYW5kIGl0IHdvcmtzIHdlbGwuPC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGRp
dj5XaGVuIHRoZSBkYXRhIGlzICZndDsgMTYgYnl0ZXMsICZuYnNwO3RoZTxiPiZuYnNwO3Ztb3Zk
cXUgJm5ic3A7PC9iPmFzc2VtYmx5IGNvZGUgaXMgY2hvc2VuLCBhbmQgaXQgY3Jhc2hlcyB3aXRo
IOKAnGlsbGVnYWwgb3BlcmFuZOKAnS48L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2Pkdp
dmVuIHRoZSBjb2RlIGFuZCBkYXRhIGFyZSBleGFjdGx5IHNhbWUgZm9yIGJvdGggcGFzc3Rocm91
Z2ggZGV2aWNlIGFuZCBlbXVsYXRlZCBkZXZpY2UuICZuYnNwO0kgYW0gY3VyaW91cyBhYm91dCB3
aHkgdGhpcyBoYXBwZW5zLjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+QWZ0ZXIgdHVy
biBvbiAmbmJzcDtrZXJuZWwgdHJhY2UgZm9yIGt2bSBieSAmbmJzcDsmbmJzcDs8Yj5lY2hvIGt2
bToqICZuYnNwOyAvc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nL3NldF9ldmVudDwvYj48L2Rpdj4N
CjxkaXY+QW5kIHJlcnVuIHRoZSBRRU1VIGFuZCBteSBjb2RlIGZvciBib3RoIHBhc3N0aHJvdWdo
IGRldmljZSBhbmQgZW11bGF0ZWQgZGV2aWNlLCBJIG5vdGljZWQgdGhhdDo8L2Rpdj4NCjxkaXY+
PGJyPg0KPC9kaXY+DQo8ZGl2PjEpIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UsICZuYnNwO0kgZGlk
buKAmXQgc2VlICZuYnNwO2FueSB0cmFjZSBldmVudHMgcmVsYXRlZCB0byBteSAmbmJzcDtndmEg
YW5kIGdwYS4gJm5ic3A7VGhpcyBtYWtlcyBtZSB0aGluayB0aGF0IHRoZSBtZW1vcnkgY29weSB0
byBQQ0kgZGV2aWNlIHdlbnQgdGhyb3VnaCBkaWZmZXJlbnQgY29kZSBwYXRoIC4gSXQgaXMgaGFu
ZGxlZCBieSB0aGUgZ3Vlc3QgT1Mgd2l0aG91dCBleGl0IHRvIFZNWC48L2Rpdj4NCjxkaXY+PGJy
Pg0KPC9kaXY+DQo8ZGl2PjIpIGZvciBlbXVsYXRlZCBkZXZpY2UsIGlmIEkgdXNlICZuYnNwOyBj
b21waWxlciBmbGFnICZuYnNwO3RhcmdldC1mZWF0dXJlPS1hdngsLWF2eDIgdG8gZm9yY2UgY29t
cGlsZXIgdXNlDQo8Yj4mbmJzcDttb3Y8L2I+IGFzc2VtYmx5IGNvZGUsICZuYnNwO0kgY2FuIHNl
ZSB0aGUgbWVtb3J5IGNvcHkgZ29lcyB0aHJvdWdoIHRoZSBLVk1fRVhJVF9NTUlPLCBhbmQgZXZl
cnl0aGluZyB3b3JrcyB3ZWxsLjwvZGl2Pg0KPGRpdj4mbmJzcDsgJm5ic3A7IGlmIEkgZG9u4oCZ
dCBmb3JjZSB0aGUgY29tcGlsZXIgdXNlIDxiPm1vdiAsICZuYnNwOzwvYj50aGUgY29tcGlsZXIg
anVzdCBjaG9vc2VzIHRoZQ0KPGI+dm1vdmRxdSAsIDwvYj4mbmJzcDt3aGljaCBqdXN0IGNyYXNo
IHRoZSBwcm9ncmFtcywgYW5kIG5vIEtWTV9FWElUX01NSU8gcmVsYXRlZCB0byBteSBtZW1vcnkg
Y29weSBhcHBlYXJzIGluIHRoZSB0cmFjZSBldmVudHMuIExvb2tzIGxpa2UgdGhlIGd1ZXN0IE9T
IGhhbmRsZXMgdGhlIGNyYXNoLjwvZGl2Pg0KPGRpdj48YnI+DQo8L2Rpdj4NCjxkaXY+PGJyPg0K
PC9kaXY+DQo8ZGl2PkFueSBjbHVlIGFib3V0IHdoeSB0aGU8Yj4gdm1vdmRxdSA8L2I+d29ya3Mg
Zm9yIHBhc3N0aHJvdWdoIGRldmljZSBidXQgbm90IHdvcmsgZm9yIGVtdWxhdGVkIGRldmljZS48
L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PlRoYW5rczwvZGl2Pg0KPGRpdj48YnI+DQo8
L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_39E9DB135FA34D1AA5737D58BA83B35Cfbcom_--

