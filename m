Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF951C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKyB-00018Y-7S; Mon, 03 Jun 2024 23:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sEKy8-00017q-ON
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:36:16 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com
 ([40.107.94.46] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1sEKy5-0008HJ-V9
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:36:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7KLJ8Yww18VBdw9t71Wyjuds/0QmNaj4RDz2TVq6pM/meGYqEKf5SPmlrkwWGgz8Naacd0c4UIKyo2LuaAPCA86SZfxy0AIP6OjRGq5tJl89ey4q9vUd1ulAPziE5BLKLsJ04W4CuRvcTdlDe4Npoq3Z01oOVHjkkiwpqBDNJVdjhDrMpupog8qUw5+wXyrLxmg4VkkMIzhzLFG4JrEeuNT6mLWQzCw47QOu4e5OgpiCyKKwQeZkymo6k6YtgvIvfcoreEhvQj8rb2AgAR1oRdLdrKSKY+qzTto/ccM3FSwILTqwT3HZss269VxS1QTGxN2QvgBgRoXZ6GgnjXQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABfM+brxYxRP13NILigrHE8iUivEHafb0GW4xoFtzso=;
 b=VdqENVjafUsZrEyZqWA+JsZSI+VA0L1Y98DDN13WETDA1i0g/8pVyVDy+ym4MtMujhE26GllfhEZn5KFuMeq2G1AuZA4aU4TGPovLkO9g0/5/bAcmcad2sNrj7bi2Lfc/68EQmPI4QOsIhILYRh53gpnU5WO8fKGLQ9Tu8EQjkX139lYcbO0cwoFiXYWI7kzQC8jnOQGgQvPnUoBsZxuBFOxO+IEWbS/mWHq7hnNLfDOp2WoRMPYMYhdyggrxZm/eaiDizZwa6jpHyuIb5mrtvsg+V9g8L28fsHCZvoXVa6aIWaLQfjTWOhElwKMQZ0rFVGqAeribovChqp2oIKfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABfM+brxYxRP13NILigrHE8iUivEHafb0GW4xoFtzso=;
 b=T2kVdHjMHI4QqhUhQBc2x30R6QEtaMZEMSg4ErOzAOSZAdwam151oGK43ZKLhIqYTlWCXmksJww1aaYn2ap03gR61MR8TXzKa9gHUYKc473Trio0CXVPBdZmRm2WRHZaIFFEttyeCY6Gyejo5FBxQ5R1+qboXgGmOGxB18dgcfM=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 03:31:06 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:31:05 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v10 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [PATCH v10 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHappqCdpwDHs/xKU2pmg78YSphtrG0plWAgALvs4A=
Date: Tue, 4 Jun 2024 03:31:05 +0000
Message-ID: <BL1PR12MB58490B1ED4D61888A223A060E7F82@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240515073526.17297-1-Jiqian.Chen@amd.com>
 <20240515073526.17297-3-Jiqian.Chen@amd.com>
 <20240602103033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240602103033-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.7633.017)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SN7PR12MB7347:EE_
x-ms-office365-filtering-correlation-id: 9247d95f-fe01-417d-a76f-08dc8446c484
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SzJ1REtKYmh1SjcyYnEwZVVLK1BJZmNhTTNDdmcrUUhYWGgzTVZiNG9LWWVa?=
 =?utf-8?B?QlJRSnMxUldKWGJHekVkck8xcysxQ0pWc2RkY1NZRExCVTBRakZBWFVnTTht?=
 =?utf-8?B?d05mK1NTcmFCejhRdGNUeGZvSjIxQ3FsclpndVRxV3dSQ2NncWNpWUo1WGd1?=
 =?utf-8?B?T2ErSy9hQkpUK3pMYTFtM25JZ1BKTytvaVEvMHQwNFBpZFdzNS9DL3dLM1NU?=
 =?utf-8?B?R0FEaHU4RmpNRm1MMFUzMTBFRHBIZUpPTURYd05KUXdKYktJaWRLa1Y5MEt4?=
 =?utf-8?B?UEh4ZXR6aGQ5bllvOWFMUXREc1IrZnJOU1Vhakx3SXhtRlpqK2dRU2thQVdO?=
 =?utf-8?B?UHdvTTVjWnNKVXFYaElubzlPdVdtOWFEcTFYN1hNZjhOKzh0UzBmcmlLZ3hR?=
 =?utf-8?B?RFIxSGZFMUpjS3hnRlRFcmxhNVFVMHhXdFdWTmZLZm1URmEyN1UyamhKT1NC?=
 =?utf-8?B?WEdvSFNaeVNnSUF0OGxDV01MWXdwNCtCZUNocTBxTkh2S1F1R1RSMFoyRWFp?=
 =?utf-8?B?SlRFL2kwbWtCemxjeHBDQUV4VjhpVXFMNFdVU1FqS0xOYmVDeTczdDNRdDRj?=
 =?utf-8?B?SXhvSjVEOXdMcHJ6TlBBWFZIQ1ErQllvWE9lS3J2RmJVRnpDN295UUYrYnFr?=
 =?utf-8?B?T0hyY0NxMDJKa0JJRkQxSVF0djJsbWZrMVEwaW9zVUhmdU41c3gzZnArWnp2?=
 =?utf-8?B?SHpzSUwwNjV3R2c2RjMxWkczMHJGZ0M0QmJPN2liV1dxKzM1VHNJdXBSdEQ2?=
 =?utf-8?B?ZkxJWDdWMVZ5dGx1RUxWUlpkdUxLWElQU3MzZHBHMTVaOWNaOFV2ZXFZZ3VF?=
 =?utf-8?B?WGtQcjBJOHJvdVBmYVJ6SGNVdWI0Und2UjVORmx6L0tHZW51TlBpalNDVGlh?=
 =?utf-8?B?Zk05Q1RtNGhrazNLY2I5ekJ6eWhGVEIyTzVJMmlreFlHZVJkUUppb2NOYjdn?=
 =?utf-8?B?dTdxb0xRUWFTdGFnLzJqRWxOaTQxK1ZRN3JLd0laUTV5TW5OSlAzeDBsNHNF?=
 =?utf-8?B?VnRKajFHQWZJRmxEb3I4bDh2UytJWG00OGgwRnpKWGNaVjUraGp3L3ZJSXZF?=
 =?utf-8?B?RWFpRmlMelFvVnMrMC9VVktIQTY3S05VMXpnV0xiNTkxNlliRkQxc0N4TWZW?=
 =?utf-8?B?aWdSWGsxckZ6NHovam1vNXNWaTR6UjBsYVNiYnpJazhBVk1rbXVPOE1uUlJx?=
 =?utf-8?B?a0JSMUN3L3BzT0l4SlBFKzlyZTR3bk9qMmdsRmlyUTZEVGxUUERRdG9EYkpu?=
 =?utf-8?B?Z2o1clBPRmV0Z0V4YjdvRzdxZGNqNTNOQkZhOEtxKzNJZFJGUjhxTXp6bWYy?=
 =?utf-8?B?emxNdGx6TGVsNGQzd0owQk9rbkE1ZkRvSW5QZ0RCY1RPakxNUHlYUEFoMmdG?=
 =?utf-8?B?aVRqYzlNTHNKTVZ4VFNKNW5OMTVYbm5Fd2xGaTgvUGEzalRMNnJkOU5QamVr?=
 =?utf-8?B?enBGQmJKZjByd1VPclA4ZkVKOWpGS2xaNGp4RVYrSzYwSzhCemozRGZPTWdw?=
 =?utf-8?B?QXZOUENjQkNlWnhWQkdsY0JFU0lpbTAvT3JNcEF2czQ2ZnZkRDZJWEZocXNi?=
 =?utf-8?B?amRUWjRyVER3bHZsWk1rT2t4Y1VzdWxaOHh3S1hoYTZEQnFxRVlJeG41YVRQ?=
 =?utf-8?B?enlxNlZCUWtoVUlrUEg0L1JKNXEvRVIyTXhrL096TmZuTlNYTytVUUUrYVND?=
 =?utf-8?B?ejRqNjhJNjZlYjNVYVZkRGVtYnR6ZGVlWEZ3d244alBDd3JPeGJndjA5bk16?=
 =?utf-8?B?Y1NVSE11VjZKUGp6T3l0S1VtSDUwTnVvaER0WHVHZm8relExNFVLaXk1R3Vh?=
 =?utf-8?B?M2Y1VVV5Y0JZWVhDYlpXZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2QrSU91eTdXUWIrSkxPaDNJWjF2YmRBbjFDNzB5M3F5YTh1dWQrVVVkTDdH?=
 =?utf-8?B?ZW0rNEIySkUvRE55RDNRM3NiOHBNVCtWTm1zWnZud2MxM1JZbWRkYnFxK0dv?=
 =?utf-8?B?N0NyRi9vT1EwSzE1RkkvcCtvZTFWVGlCZlZCOS9SMzlTanNxYmx0SkNvMVZy?=
 =?utf-8?B?eStTKzh2MWk2aUhaUzRjVnNxRzFJeG1xSUxTaUlvZGIzSlVGbUduN3duZmhj?=
 =?utf-8?B?S01WYXhURzVLR05NU25zTTJaZTgvOC9oSDFQMGRaMnZlSjBTaVhJTUFoWW5a?=
 =?utf-8?B?L2lsbU1WUnREUWV2Z09HMnpnS3R4cnRHREk5N2RLQUlvbGVHS2lScWJvRjhr?=
 =?utf-8?B?UFVUS2FMUVBPUncxT1A3QmJ4SG9IaGthMmYwekMwVlA4ajMvdXd0aFAybVIr?=
 =?utf-8?B?ZEVWQ2pIdU5SVmk1VWtkOGwxekticFdCR3BkbGdPWTNodVNITWpTenl0STQ2?=
 =?utf-8?B?dGRSc2pBU2ZPU1R2UTluOTJKbld3Y1RrQWFBakd4NXc4YkRVc05FcDhrS1l2?=
 =?utf-8?B?OVFId1RsMDAxUXI0dWZ0R1lCeGUxanF3NGx5SDg5QzloSWUzeDNxZjdLYnYw?=
 =?utf-8?B?bjdMZTVEQ0ovYStCbFl5UmZiTTNwV0t1QVF2UmZJL3ZSYU96VzJOUGwzSWxW?=
 =?utf-8?B?TE5LZkROVUlkRzFGYTZVYm9ZZWJobDBwelJYdDh0Tnh4QlBudnBybTVaMklw?=
 =?utf-8?B?aGJPeEVSQnNOR1BYWGRsWFEraXVTNXBHTDNuTnlleU80bi9obDJXU2p2ejhS?=
 =?utf-8?B?MnBvV044eDdodnZoS0FXR01HQlJFT0FGQktjdjl3cEo5cHVFRjRrZzhpRC9O?=
 =?utf-8?B?RDloOCt2NXZPck4yRkROMFVadzNsTlZBbmZ2cS8ydEc1cHp2b1NwU0RvaDRZ?=
 =?utf-8?B?ak9paEV4UHR1NzRhQStRelB5NHV5UTdiYS9zdHBQd1E1WGUyVGcreTFYQ01S?=
 =?utf-8?B?V09FUmpqY2V5c2JyQjBsT1o5cjJ1ZXZ2eDJxaXBVa3lralYwNCtPNlV4Mm9U?=
 =?utf-8?B?c1V3bHZaM1ZEdUdEVFlLQ09WV1VMZ240eitySTJsWnozeEJDL2lyWEw4MHdz?=
 =?utf-8?B?Y0svWFlJcHdyMnBYUUhkVERXUDFyTnpBcHBPVDhubWpCMjV6RjRpNURsbVQ0?=
 =?utf-8?B?Y1Q3ZE1kMm9YbmJHQmxJU0lHWjdyT092WUUzWjFrc1UyNTlnWTd2bEZaL1Fl?=
 =?utf-8?B?U3V2OHI4eGdJRHNQTit6aFBkMW9wbS8xWUo4bDVlamhac0t4czVMSHBNVHlt?=
 =?utf-8?B?VmxybzExVTR5eFp5cXZGanRZaWxaQ2dRbDUvZkVFdk9oelZFZ3FzYVFMa250?=
 =?utf-8?B?OGNxVEx6NENVQVV4VU5HQXRCT0xkUTdQbzNmeWxSRFFndGJ2ZTVTOEZSc0Jh?=
 =?utf-8?B?VjVlSHNsQkZLd2x1OHpGaGQ4RG4ycm00ckZORVVFSFA2QzlkRVV1UU1ud3g3?=
 =?utf-8?B?MGRia3BtV0VFZ2YwRlhpVC9IL05lVzVUdzN2V2puV3Y3Wi83UDlCaXdSODc5?=
 =?utf-8?B?TFpGWThFYzdkYWhLTXFJVnJ1MW9BY2hyQngxeUxnVEQxRS8ybnc4dWQvVlQ2?=
 =?utf-8?B?OFQvTVdoQW5SV1A5ak0zbWtKNnZRMTd0VnRQdU9UQ2ppK0lzOGxFdm9XYUw5?=
 =?utf-8?B?VVhTMFBTU3ZKRDMwNE1vSWl2d0gwaWN0aXY3VTFaclZZVGxoeTBSNllFeWRS?=
 =?utf-8?B?dUlxY0lONjMyYXNPTm5YdVpsL1NiT05JTlJKOW05RnEyeWhUNnBlcGp6QUty?=
 =?utf-8?B?dGg5SGM5MzZsdXFob3ppcENYNjQ3MTNaaFJCT0JRNlRxajRJeXA4V1czbnhN?=
 =?utf-8?B?V2VtQlNsc2xtbjBiNkRxaGJhTDRYQTBvQWRpanplL3QrR0dxU0Vwc3pNTTd0?=
 =?utf-8?B?bzBxL1ZZU0NiMFdXNW9RTjQrTWNjQ0Vpd01MSDNEbEFtRFFUTXh0SnpuWWt0?=
 =?utf-8?B?a2U4ZTczLzdOT2FQUzU4ZE1ZWDdzWlFXL2dTWVU1VFRtN2RkdERhREdQZ0g1?=
 =?utf-8?B?UmhlMmVabFllMXhQcDRGUE01ai8rK2NFWjlvUzM3Rm8rbVlZNVNSc1dLSVFO?=
 =?utf-8?B?b0lVVXJ1OVl1eHU5OHhFWkh3WFN0R1Znc2VBUEpvU0JHMnhhbFdTVXpLNTFh?=
 =?utf-8?Q?n/Ig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <384DAF35BF9CC7448AC1FC2F2BA655C4@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9247d95f-fe01-417d-a76f-08dc8446c484
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:31:05.9054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nsRSv4KRjVqPP0Mcm8RUvnXGnjqlomF9zxzFCI1wlHGNJehuagSAi+FiG1TBywDrUJ+T0wlrqI9xQTaLKsgiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
Received-SPF: permerror client-ip=40.107.94.46;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gMjAyNC82LzIgMjI6MzMsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMTUsIDIwMjQgYXQgMDM6MzU6MjZQTSArMDgwMCwgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBJ
biBjdXJyZW50IGNvZGUsIHdoZW4gZ3Vlc3QgZG9lcyBTMywgdmlydGlvLWdwdSBhcmUgcmVzZXQg
ZHVlIHRvIHRoZQ0KPj4gYml0IE5vX1NvZnRfUmVzZXQgaXMgbm90IHNldC4gQWZ0ZXIgcmVzZXR0
aW5nLCB0aGUgZGlzcGxheSByZXNvdXJjZXMNCj4+IG9mIHZpcnRpby1ncHUgYXJlIGRlc3Ryb3ll
ZCwgdGhlbiB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5kIG9ubHkNCj4+IHNob3cgYmxh
bmsgYWZ0ZXIgcmVzdW1pbmcuDQo+Pg0KPj4gSW1wbGVtZW50IE5vX1NvZnRfUmVzZXQgYml0IG9m
IFBDSV9QTV9DVFJMIHJlZ2lzdGVyLCB0aGVuIGd1ZXN0IGNhbiBjaGVjaw0KPj4gdGhpcyBiaXQs
IGlmIHRoaXMgYml0IGlzIHNldCwgdGhlIGRldmljZXMgcmVzZXR0aW5nIHdpbGwgbm90IGJlIGRv
bmUsIGFuZA0KPj4gdGhlbiB0aGUgZGlzcGxheSBjYW4gd29yayBhZnRlciByZXN1bWluZy4NCj4+
DQo+PiBOb19Tb2Z0X1Jlc2V0IGJpdCBpcyBpbXBsZW1lbnRlZCBmb3IgYWxsIHZpcnRpbyBkZXZp
Y2VzLCBhbmQgd2FzIHRlc3RlZA0KPj4gb25seSBvbiB2aXJ0aW8tZ3B1IGRldmljZS4gU2V0IGl0
IGZhbHNlIGJ5IGRlZmF1bHQgZm9yIHNhZmV0eS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKaXFp
YW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L3ZpcnRpby92aXJ0
aW8tcGNpLmMgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4+ICBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmggfCAgNSArKysrKw0KPj4gIDIgZmls
ZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92aXJ0
aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4gaW5kZXggMWI2M2Jj
YjNmMTVjLi4zMDUyNTI4YzA3MzAgMTAwNjQ0DQo+PiAtLS0gYS9ody92aXJ0aW8vdmlydGlvLXBj
aS5jDQo+PiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+PiBAQCAtMjIzMCw2ICsyMjMw
LDExIEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYs
IEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICAgICBwY2llX2NhcF9sbmtjdGxfaW5pdChwY2lf
ZGV2KTsNCj4+ICAgICAgICAgIH0NCj4+ICANCj4+ICsgICAgICAgIGlmIChwcm94eS0+ZmxhZ3Mg
JiBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9SRVNFVCkgew0KPj4gKyAgICAgICAgICAgIHBj
aV9zZXRfd29yZChwY2lfZGV2LT5jb25maWcgKyBwb3MgKyBQQ0lfUE1fQ1RSTCwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgUENJX1BNX0NUUkxfTk9fU09GVF9SRVNFVCk7DQo+PiArICAg
ICAgICB9DQo+PiArDQo+PiAgICAgICAgICBpZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9G
TEFHX0lOSVRfUE0pIHsNCj4+ICAgICAgICAgICAgICAvKiBJbml0IFBvd2VyIE1hbmFnZW1lbnQg
Q29udHJvbCBSZWdpc3RlciAqLw0KPj4gICAgICAgICAgICAgIHBjaV9zZXRfd29yZChwY2lfZGV2
LT53bWFzayArIHBvcyArIFBDSV9QTV9DVFJMLA0KPj4gQEAgLTIyOTIsMTEgKzIyOTcsMzcgQEAg
c3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZXNldChEZXZpY2VTdGF0ZSAqcWRldikNCj4+ICAgICAg
fQ0KPj4gIH0NCj4+ICANCj4+ICtzdGF0aWMgYm9vbCB2aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQo
UENJRGV2aWNlICpkZXYpDQo+PiArew0KPj4gKyAgICB1aW50MTZfdCBwbWNzcjsNCj4+ICsNCj4+
ICsgICAgaWYgKCFwY2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYtPmV4cC5wbV9jYXApIHsNCj4+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBwbWNzciA9
IHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIGRldi0+ZXhwLnBtX2NhcCArIFBDSV9QTV9DVFJM
KTsNCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICogV2hlbiBOb19Tb2Z0X1Jlc2V0IGJpdCBp
cyBzZXQgYW5kIHRoZSBkZXZpY2UNCj4+ICsgICAgICogaXMgaW4gRDNob3Qgc3RhdGUsIGRvbid0
IHJlc2V0IGRldmljZQ0KPj4gKyAgICAgKi8NCj4+ICsgICAgcmV0dXJuIChwbWNzciAmIFBDSV9Q
TV9DVFJMX05PX1NPRlRfUkVTRVQpICYmDQo+PiArICAgICAgICAgICAocG1jc3IgJiBQQ0lfUE1f
Q1RSTF9TVEFURV9NQVNLKSA9PSAzOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgdm9pZCB2aXJ0
aW9fcGNpX2J1c19yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkNCj4+ICB7
DQo+PiAgICAgIFBDSURldmljZSAqZGV2ID0gUENJX0RFVklDRShvYmopOw0KPj4gICAgICBEZXZp
Y2VTdGF0ZSAqcWRldiA9IERFVklDRShvYmopOw0KPj4gIA0KPj4gKyAgICAvKg0KPj4gKyAgICAg
KiBOb3RlIHRoYXQ6IGEgcHJvcG9zYWwgdG8gYWRkIFNVU1BFTkQgYml0IGlzIGJlaW5nIGRpc2N1
c3NlZCwNCj4+ICsgICAgICogbWF5IG5lZWQgdG8gY29uc2lkZXIgdGhlIHN0YXRlIG9mIFNVU1BF
TkQgYml0IGluIGZ1dHVyZQ0KPj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKHZpcnRpb19wY2lfbm9f
c29mdF9yZXNldChkZXYpKSB7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2KTsNCj4+ICANCj4+ICAgICAgaWYgKHBjaV9p
c19leHByZXNzKGRldikpIHsNCj4+IEBAIC0yMzM2LDYgKzIzNjcsMTIgQEAgc3RhdGljIFByb3Bl
cnR5IHZpcnRpb19wY2lfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAgICAg
VklSVElPX1BDSV9GTEFHX0lOSVRfTE5LQ1RMX0JJVCwgdHJ1ZSksDQo+PiAgICAgIERFRklORV9Q
Uk9QX0JJVCgieC1wY2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAg
ICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQsIHRydWUpLA0KPj4g
KyAgICAvKg0KPj4gKyAgICAgKiBGb3Igc2FmZXR5LCBzZXQgdGhpcyBmYWxzZSBieSBkZWZhdWx0
LCBpZiBjaGFuZ2UgaXQgdG8gdHJ1ZSwNCj4+ICsgICAgICogbmVlZCB0byBjb25zaWRlciBjb21w
YXRpYmxlIGZvciBvbGQgbWFjaGluZQ0KPj4gKyAgICAgKi8NCj4gDQo+IEkgdGhpbmsgeW91IHNo
b3VsZCBkbyBleGFjdGx5IHRoYXQsIGFuZCBtYWtlIHRoZSBuYW1lIHN0YXJ0IHdpdGgNCj4gIngt
Ii4gSXQncyBub3QgcmVhc29uYWJsZSB0byB0ZWxsIHVzZXJzICJzZXQgaXQgdG8gdHJ1ZSwgY29u
ZHVjdCB5b3VyIG93biBRRSANCj4gdGVzdGluZyIuIE5laXRoZXIgZG8gd2Ugd2FudCB0byBkb3Vi
bGUgdGhlIGFtb3VudCBvZiBRRSB3b3JrIHdpdGgNCj4gZWFjaCBidWdmaXguDQpPSywgc28geW91
IHN0aWxsIGluc2lzdCBvbiBuZWVkaW5nIHRvIGNvbnNpZGVyIHRoZSBjb21wYXRpYmlsaXR5IGZv
ciBvbGQgbWFjaGluZS4NCkNhbiB5b3UgZ2l2ZSBtZSBzb21lIHRpcHMgb24gd2hpY2ggb2xkIG1h
Y2hpbmVzIGRvIG5vdCByZXF1aXJlIHRoaXMgZmVhdHVyZShOb19Tb2Z0X1Jlc2V0IGJpdCk/IFRo
YXQgd2lsbCBiZSBoZWxwZnVsLg0KDQo+IA0KPiBJZiBmb3Igc29tZSByZWFzb24geW91IHdhbnQg
dGhpcyB0cnVlIG9ubHkgZm9yIHRoZSBncHUsIHlvdSBjYW4gZG8gdGhhdCB0b28uDQo+IA0KPiAN
Cj4+ICsgICAgREVGSU5FX1BST1BfQklUKCJwY2llLXBtLW5vLXNvZnQtcmVzZXQiLCBWaXJ0SU9Q
Q0lQcm94eSwgZmxhZ3MsDQo+PiArICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdf
UE1fTk9fU09GVF9SRVNFVF9CSVQsIGZhbHNlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4
LXBjaWUtZmxyLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9GTFJfQklULCB0cnVlKSwNCj4+ICAgICAgREVG
SU5FX1BST1BfQklUKCJhZXIiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmly
dGlvLXBjaS5oDQo+PiBpbmRleCA1OWQ4ODAxOGMxNmEuLjllNjdiYTM4Yzc0OCAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9o
dy92aXJ0aW8vdmlydGlvLXBjaS5oDQo+PiBAQCAtNDMsNiArNDMsNyBAQCBlbnVtIHsNCj4+ICAg
ICAgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSX0JJVCwNCj4+ICAgICAgVklSVElPX1BDSV9GTEFH
X0FFUl9CSVQsDQo+PiAgICAgIFZJUlRJT19QQ0lfRkxBR19BVFNfUEFHRV9BTElHTkVEX0JJVCwN
Cj4+ICsgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULA0KPj4gIH07DQo+
PiAgDQo+PiAgLyogTmVlZCB0byBhY3RpdmF0ZSB3b3JrLWFyb3VuZHMgZm9yIGJ1Z2d5IGd1ZXN0
cyBhdCB2bXN0YXRlIGxvYWQuICovDQo+PiBAQCAtNzksNiArODAsMTAgQEAgZW51bSB7DQo+PiAg
LyogSW5pdCBQb3dlciBNYW5hZ2VtZW50ICovDQo+PiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdf
SU5JVF9QTSAoMSA8PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQpDQo+PiAgDQo+PiArLyog
SW5pdCBUaGUgTm9fU29mdF9SZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPj4gKyNk
ZWZpbmUgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVQgXA0KPj4gKyAgKDEgPDwgVklS
VElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklUKQ0KPj4gKw0KPj4gIC8qIEluaXQgRnVu
Y3Rpb24gTGV2ZWwgUmVzZXQgY2FwYWJpbGl0eSAqLw0KPj4gICNkZWZpbmUgVklSVElPX1BDSV9G
TEFHX0lOSVRfRkxSICgxIDw8IFZJUlRJT19QQ0lfRkxBR19JTklUX0ZMUl9CSVQpDQo+PiAgDQo+
PiAtLSANCj4+IDIuMzQuMQ0KPiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4N
Cg==

