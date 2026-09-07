Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C97C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 04:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3RP9-0001C7-2L; Mon, 07 Sep 2026 00:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=703660e7d=Alistair.Francis@wdc.com>)
 id 1x3RP5-0001BF-Ly; Mon, 07 Sep 2026 00:56:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=703660e7d=Alistair.Francis@wdc.com>)
 id 1x3RP2-0004gM-BJ; Mon, 07 Sep 2026 00:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788756980; x=1820292980;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=llpWYHDGXHnfzxat+RP02Aeup/38HbZGTVE/g1VzB9Y=;
 b=R74DBeznIvPYh0RvZrHIhWRdBW18fGnWOFoaYLUssQ3QivgBKskuW8Da
 /u1o7l/qrfOGllkR+miqfKeQ6AaHAcqUnxI+B1WnNStqm1AfDVMXVQaDW
 ert7922VsqM+aHlS8KCk66KzotMwiDKyHcHSpBScMqWdbDdjSJwgqdGbw
 osO6/6/751tTqatCbZNx8MVa+T69CAKNkLx6e1nYLoNxEXOE+FoOsaZX7
 d5kMFwUNJKEbGy1gw9j2/hADc97lCusWBoediszKABIxCu1YaXNT2sDhU
 mASdcBCfRBULvL0jEMTbCmq6UHuWsnGfehSjRgPIh5oFmd5SN64a/bgco Q==;
X-CSE-ConnectionGUID: uTlrpMcBTTivj48vtQSgtQ==
X-CSE-MsgGUID: r3grvvjfTG2iNYmdG9yH7A==
X-IronPort-AV: E=Sophos;i="6.25,266,1779120000"; d="scan'208";a="154135854"
Received: from mail-northcentralusazon11010048.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Sep 2026 12:56:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTy0TDbiBR8vi7vagi6WNf864XKIuwzQZletdEzJrg/aC34t3OmcWol7UZ1eVB/FJq2DInATbx0A8tPbN4I+wtcqpucRGjnVIK4UhKH9cn9Ib6mYY5Edwopf4mn7OKKCDxlJ71NsOUYpfParT/QWs3+e0KbQ892kTZYm3XVY0zN0CPQdXVyvGVaygIaq4OzjISdIQaXcubdGbC4rTtmxFkaMh2HX0qzde7xwl3Ip495/Jumx3kja3K9zgT+yb+vTzoBvlCW1i+5cvi+fex6/K7WFWuwVUMpyFjZoALztgCgPc4NJFgP+PFTmCeFIa+LBe7oYntN2D2VF3LdvB7wojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llpWYHDGXHnfzxat+RP02Aeup/38HbZGTVE/g1VzB9Y=;
 b=qVtl1TByJ1h++xH3H1tE3e6NGpAiQoFkBWIlGriYtnQFwqTAgnKx2cHbprKlxKfKVRQuCGEz5/UGxZ/OepbUyTZTW6whCGHAF7FiDih6+6snkbVQY0kZIbkPb+cLKh3SgqiEMhlfqYq+isJIXIRd1w9gUNFOEV5hjdxwFm7HAsv/XntYFwxEF1NPf4rfHLgcGydLPYXlLgGLa8i6TNK5MOy6062qKzt2DCqnwkI/ohECGlFhbBikwPbQki2Vt9GhrA2U7FTRCI+E/2NShYtzgmHIlwbkh1p9YGhOYoURIlouCZgcVB7Ftu33ql+H+7SExYQsi2SHsjJPahYkegrTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llpWYHDGXHnfzxat+RP02Aeup/38HbZGTVE/g1VzB9Y=;
 b=jun8oKgqT6QCgOoqkpSrkj3Qc3lxz9j4MuqDONxFSeqEZpIESo5IbgWO/Z8rBkWcJomzrwrDJ0orHwYWi7InGTFisIvVRENgp0MF0xOrrwAI1gOZ9PLMmd02briMYWYqaRh9DcMivZoPc1rus4VeLHfOW31yXZq05YzbJNGFkZM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MW4PR04MB7457.namprd04.prod.outlook.com (2603:10b6:303:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 04:56:13 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 04:56:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "imaginos32@gmail.com" <imaginos32@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
CC: "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Thread-Topic: [PATCH v2] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Thread-Index: AQHdDIdajV4aiA/i+0yvLJG7BgoQ6LbC8VkA
Date: Mon, 7 Sep 2026 04:56:13 +0000
Message-ID: <7dd470a56106f46676a7f9b04993bcf40800f988.camel@wdc.com>
References: <v1-Message-ID> <20260705140508.17692-1-imaginos32@gmail.com>
In-Reply-To: <20260705140508.17692-1-imaginos32@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MW4PR04MB7457:EE_
x-ms-office365-filtering-correlation-id: 681b686f-04ac-4ad3-7ce2-08df0c9c576b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|19092799006|366016|10070799003|38070700021|6133799003|3023799007|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: JQqT/SMDofYKBhADeOYuTeKhbInefMGrl4C8mbnDe0PtSflExtKbOQ+TtMO97HFdpcBZaRtlMIePX/MiSwlw5sXvvytEC9fNxgVEibMyV+dPNg8RUZBYNhEvvKrkXR9umZYg++VlDT5agOHjqR+7yOPKzbdWX47jthLB5NrHFd36ONnO7+aA2uYt3HDPsMaH9Vt6WXVgkLAJSXKfAQJ+7FaiMnhNqCcpifJGi7gc95xUIlT9gqk27Bwk6JVrTUkKY6pX87AKsWFUcdfteuhBwBSWRrjEve+veYMBUtyqwmI8fT5Gd66t7zvHL0ox4pq95fp+THaqg6tQLCITT49RYzVwEzNs9EjEESh1n0J48HaGY6m9hVInvvV4S3KmMa83/69vT0g/bWZRVL+OyLZYXMFMOs1WFu4T0k4Y4mDG51mLaxtMEWXrP/9KEK1v0/ExXHi+CYkCq+KPZYyG1YYinU3hTHKSACuTU3NsJagS3UGBctw4p44qoI/priTGAW/gVFcSn7cWo+lzy/5xB5SZ74wyMTlGMVIyosinhyVF+i7BQgmcwe8EgyHsn6i3qPxpq++HjHH3QXCBOgxEL+wi24ybx/Ufh4Ns3U3dO/o0+WGCy89zC2CK+rIEtpThNj9msvh6pz3qPPAfJ/Xd7dmR8Hn1II1hIJWu9Xxxv4u7YAY721HjsNeISDgJSYn2miA0U9A7/MvBBnF234RzZ05WOVBzDz2UtncfzKVC9y61zLs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(10070799003)(38070700021)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNQS2JDQ2diQnBpSUJXVUQrZnV3OW8rVUx4ZE8yWjFQTzdnNXIvdk5hWVJO?=
 =?utf-8?B?VXI5USs5eDVGb2U5UTdxY1c3S2ppVHYrRkhuZXUyRW1nZlYwK2d4L3N6RmJH?=
 =?utf-8?B?UDEwR2lHYWR4V1k4cUY5emFHTjJYYzhuS2xSQVkyZ1dzMnlsalNxZktFdEFX?=
 =?utf-8?B?a1Rkc0VJYTBpYzNWNWJPai8xWVZQSWx3R1BYSHBZUGRVZzYvRjdtV3puZzNv?=
 =?utf-8?B?eklNT1h0NnRqZE9UTDVUNG1PMkM0WVd2UVBCVUlYcVRzNjBMRlQwOFBXeFV4?=
 =?utf-8?B?dXJzdFlPdnlyN1c2R2pqZFltOUdhSGhhZW1nSDQxNWc4MCtoRGhmMThuMG42?=
 =?utf-8?B?cytSYmljNGNUNTg3N3pmdFo0eHJYem5peVY0SjdwS2ZxWWpGdzA5M05sQnNz?=
 =?utf-8?B?bnlZLzFpcUpCZTBVUVJzbjJSb3Z3ZGZHYjB4Njg4ZDRKMUZxdUQ3RWZRR3dq?=
 =?utf-8?B?NnM4dWtLRml3MzF5VW93QVh3RUVwbFVTT1cwN2tLRmpoMXRoNzZ5MDZhS0dv?=
 =?utf-8?B?REdyNm9zTFpOZzZsK29KY280NHVzWDI1TlhjUTJoK3N4ZjhIRFgzcVF4OUxQ?=
 =?utf-8?B?aW5Jc01iazlFUjl6NG4vUFF4b0JDdDZGRFJHREMzTGROQ3dsa3lmUGpDR1NZ?=
 =?utf-8?B?ZWtiTmRrVzROVEdRREFVSzAxaGdBL0lYK25wSy9uNTBxZFQrSmpTekVTaFJB?=
 =?utf-8?B?L3U5UkdQbmpkckpjVGFPeFdHdkZFekt6RFBrYm55YjFGUEt2cCs5cmgvczBK?=
 =?utf-8?B?S2VRdzV5Z0Q3Q1FXYml0bFRmYnAxQ3A1c0JYQ29lM0cwbnA2cFpyRjZqL0Y3?=
 =?utf-8?B?QUhpei9nMkdwMEFtTFlDSXgzalAyR0hDOU53YmNhR3ZKOUpBZEs4Z3V4ajZE?=
 =?utf-8?B?WWhTcWxmQ0RpMFNWR1NORHlYMkZSR1JBRFpwZFVwNTk5a0tOQ2NnYjc3MDFx?=
 =?utf-8?B?ekpxSDVqSitqVHpsemExdStiTXMyUWZRK3o4TmhScDlsQ2loUmpDYTg4UVJP?=
 =?utf-8?B?ZmEvdVIyVjhoR0tHWloweXNqVjgyMG5ickFxZW4wS0tvTlN5ZjRkWnh2T3l6?=
 =?utf-8?B?eE5ydjgvV25TemN5THVSak5GSlVTejdvbWVUZ3ZwWHdEWWJUREU3MUM1bmxU?=
 =?utf-8?B?aGlWL1o5c2dXL3JzOWVXQm81WDNWcC9FakV2R3d5UzhEMnhyLzVyVUFMNk1Q?=
 =?utf-8?B?YXZGTFJwMG9iaVViZHkwTGtkMjlUdWsvV0RoMExXTWV5cjlZSHJucmFleFBK?=
 =?utf-8?B?VElYSzVDODFuL2NNLzMrVzdIcW82Z1BXWk01SUxRdlpzSEFNbTBVSUU4YWZr?=
 =?utf-8?B?Tk0zcWNqN3ZvMmdJYndrNWNGUktLcVVDQlp3T3JWS3BMbEgzTVM3S1JoVE9p?=
 =?utf-8?B?V3hLa3hoOUk3R0laOFhhQjNMNWE0MTIrVXdYZ3JqT2lPc2tKczdDeDhjQWhM?=
 =?utf-8?B?d2F0clVZeTJ3VllEczZmVHkweGEwWVNWYXhtL3lJR045amxUZ2RMNjlua0JL?=
 =?utf-8?B?b09MSUQ4ZUhlRTBKWmRsckRZaTlXaTFzWWtMbjZmUmNFSzNJOXRZVUlyK3hV?=
 =?utf-8?B?cDNZVDU4RmRIVDJEb1oyekhnN0hRMW85Y0s4dHNoTEFUaklIUEVxOUpQUitt?=
 =?utf-8?B?Z1dNT01sZ1JqMDFBN1BHRWt1SnpIcStQQjMwNUVDNWhQMWRtS3N4SnBLRkdE?=
 =?utf-8?B?YzFkMFo3WDZHZGRmM1FFb2VKNHUzaElyOHFaMXNQQ1ZMbktKTXZtZXNBNExs?=
 =?utf-8?B?RXkzV3FyeFlJU3hCaWNTNmt0dndzYjNtbEhtdkJyWDlURFRzcDB1WEQ2azJ3?=
 =?utf-8?B?Y1ZmRWRFeEZ6a2VaZkJKaUQ3a2h6c3dIMitVRkdMOUtoQklqd2JMNExlYTNy?=
 =?utf-8?B?Yk41Nno3NHV5YytUc3U1Ulc0dURwSWI1QXdaWHR2SEFxeWUvUjJvcS91Z3Ju?=
 =?utf-8?B?TEtZUTdLWlZ5U3dpWTFmUHhCNnk1YlhmMUhrSGV3T3VmaXhyeitGbzNkdzdj?=
 =?utf-8?B?OHlVTjBLRkkvUUZwWEF2aHcxY1dsVGJnT3Jsd3BIQnZySUtxVVF0SURyVXBj?=
 =?utf-8?B?aDNyWVNCakp4M3M5MU9yNXk4Z0hOWlVyYk9tL1p3VnhEUWNlWHpKWDBBSkpJ?=
 =?utf-8?B?aUVxLzlCb0s3SWhXVzlLeDBzVllFTnRIMFdSRlN0YWN5SG5uTjJhUkM0WEdG?=
 =?utf-8?B?ak84OEU0R0dKT2dDSWNuVjlQSWRLK1dxVlI0YXVwL3B3YXFzazZWamExZm44?=
 =?utf-8?B?SVJ6UC90ZUVRT1k2ZzBWb0R4OEtIZUpHV1ZWL1ZYUDZnWEN3RitWR3pxSlhw?=
 =?utf-8?B?VXgyb2ZpVmZQR1ZNcmhra0JaNFJFem1jRkFuSnFWaEVFTkxQVktKaFY5dWc4?=
 =?utf-8?Q?Ts+ZgKM3Z6ASPXoaLHp1mkBrIpWMWNCmUWAahAjYJc+//?=
x-ms-exchange-antispam-messagedata-1: JgZmZOw89F7HfPAG9cjJxwn5E8QSfod0WbY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09291D1DA16F8B41A424E3D6FF8501D4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e5gIihUSNAxvYHDPu/tOy1WZetPIfeMnhOM4RvIaJypFb7MQOHDlgh2zL647gi8JW3M/VlewdxkmKTXn6ZccUc9rBOfiMZHY/k6u8Jwq81jlXVFeqErHyjq+D5iuD3uWm6CSTjdwY0s4z2i1S6ayqhaWV/YEIk8MZMxsMpKaqugghDMFV0ffxescuqO1RmycrsQ/PkgZJuVWxbeE5AXVyh9mpMjbTdgw0+w/Z2ELpjzIj1RX3LOezKS3rf3Wmj77NSO/loVOm0l9yLJS1mpNb97ZIIFQqcTL9K0nudS/iZJtwoJhf6HsnvOPGzt+FK6KFoytlNbXUoMANkOLNQg5vw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Wh8nGRWyLtuOZQecLeP90zCw/yYPfKSnQYxto9UtngqQCoBA4npDbbq4JQlUhR9hISjDDhQ+qwjFs0zGkjuvx4+weaxiCNuDrpOJffayz6kvVFlYBVb/ziL3JljKk/iBJw0FU0/8Ca7UTCYWS0oL7vUrJ0DkI06odJjvZfC+H2RW/a3rqIPd7Y0Gm5NwAqPQpL//jZlVIodNHwGvvfIkk7gQ0DoCDs2Lxc8yQAQnn7bTCJXPxZrYDFe44/iBk/P69XemrJSbYVOWnIlACvGosmE//k7++MhEVvJ9gm69AdWb64Sudl48tm5r1mGEo+e1+JAlM5gY63+o5zjfW5lh5nsW0vUf0JuNVPzcITHabVw1v1ohLy5zzB50jomxoDwzEcHWJl4k25tr4D+M98/RFedOyZKyfQ3U8UmkYRHxxQRmk/76sCjuYORg2k1gxzbHz6CsQqK+8LikXLsd4qbBi8jPCkkIfAoG1xLxQRrKyMr0kCdJW5awlY+O7LwCSoNrzVvOpwcfp1moTapeFHPgday4tYurQr0vKIRyQ9Ips7Ei+9bv6qOQAqOJddfF9rCjiiLTUX7l3G0CBFg7dM91tKnNGiFB2wiQqgSbvft+dgQfgLF0DB/obicn9SLvXp4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b686f-04ac-4ad3-7ce2-08df0c9c576b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 04:56:13.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UhL97ApINON+i+zEqjn5Bl1deEUimmTfdb5rmJryZPS6RKmA76MfV0xlspkTU2uF+y2Q+QOyv0cnXx+KEhsCge6jyX689QZz+oAlVtKLjoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7457
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=703660e7d=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA3LTA1IGF0IDE2OjAyICswMjAwLCBpbWFnaW5vcyB3cm90ZToKPiBEdXJp
bmcgYSB0d28tc3RhZ2UgKFZTLXN0YWdlICsgRy1zdGFnZSkgcGFnZS10YWJsZSB3YWxrIHdpdGgg
aGFyZHdhcmUKPiBBL0QgdXBkYXRpbmcgZW5hYmxlZCAoU3ZhZHUgLyBtZW52Y2ZnLkFEVUUpLCBh
IHN0b3JlIHRoYXQgcmVhY2hlcyBhCj4gVlMtc3RhZ2UgbGVhZiBQVEUgd2hvc2UgYWNjZXNzZWQg
b3IgZGlydHkgYml0IGlzIGNsZWFyIHRyaWdnZXJzIGEKPiBoYXJkd2FyZSB3cml0ZS1iYWNrIG9m
IHRob3NlIGJpdHMgaW50byB0aGUgUFRFLiBUaGF0IHdyaXRlLWJhY2sgaXMgYW4KPiBpbXBsaWNp
dCBzdG9yZSB0byB0aGUgUFRFJ3MgZ3Vlc3QtcGh5c2ljYWwgYWRkcmVzcywgc28gaXQgbXVzdCBi
ZQo+IHBlcm1pdHRlZCBieSBHLXN0YWdlLgo+IAo+IEZpeCB0aGlzIGJ5IHJlLXJ1bm5pbmcgdGhl
IEctc3RhZ2UgdHJhbnNsYXRpb24gb2YgdGhlIGd1ZXN0IFBURSdzCj4gYWRkcmVzcyB3aXRoIHN0
b3JlIHNlbWFudGljcy4gZ2V0X3BoeXNpY2FsX2FkZHJlc3MoKSB0aGVuIGFsc28gY2hlY2tzCj4g
dGhhdCBHLXN0YWdlIHBlcm1pdHMgdGhlIGd1ZXN0IFBURSB0byBiZSB3cml0dGVuLCBhbmQgcmFp
c2VzIGEKPiBndWVzdC1wYWdlIHN0b3JlIGZhdWx0IHdoZW4gaXQgZG9lcyBub3QuCj4gCj4gUmVz
b2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
MzQyNgo+IFNpZ25lZC1vZmYtYnk6IGltYWdpbm9zIDxpbWFnaW5vczMyQGdtYWlsLmNvbT4KClRo
YW5rcyEKCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dAoKQWxpc3RhaXIKCj4gLS0tCj4g
wqB0YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPiAKPiDCoHYyOgo+IMKg
wqAgUmV3b3JkIGFuIGluY29tcGxldGUgc2VudGVuY2UgaW4gdGhlIGNvZGUgY29tbWVudC4KPiAK
PiDCoFZlcmlmaWVkIGFnYWluc3QgU3Bpa2UsIHdpdGggdGhpcyBwYXRjaCBRRU1VJ3MKPiDCoHJl
cG9ydGVkIHZhbHVlcyBtYXRjaCBTcGlrZS4KPiAKPiDCoFNwaWtlIChyZWZlcmVuY2UpOsKgwqDC
oMKgwqDCoMKgIFFFTVUsIGJlZm9yZSB0aGlzIHBhdGNoOgo+IMKgwqDCoCBtY2F1c2UgMHgxN8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWNhdXNlIDB4MTcKPiDCoMKgwqAgbXR2YWzCoCAw
eDgwMDAwMDAwwqDCoMKgwqDCoMKgwqDCoCBtdHZhbMKgIDB4ODAwMDAwMDAKPiDCoMKgwqAgbXR2
YWwyIDB4MjAwMDEwMDTCoMKgwqDCoMKgwqDCoMKgIG10dmFsMiAweDIwMDAwMDAwCj4gwqDCoMKg
IG10aW5zdCAweDMwMjDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXRpbnN0IDB4NmE3MDQwNzMK
PiAKPiDCoElmIEkndmUgbWlzcmVhZCBhbnkgb2YgdGhlIEEvRC11cGRhdGUgc2VtYW50aWNzIGhl
cmUsIEknZCBhcHByZWNpYXRlCj4gdGhlCj4gwqBjb3JyZWN0aW9uLgo+IAo+IGRpZmYgLS1naXQg
YS90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIGIvdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYwo+
IGluZGV4IDJkYjA3ZjVkZmIuLmViMzRiYTE5ZTEgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2
L2NwdV9oZWxwZXIuYwo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMKPiBAQCAtMTM3
MCw2ICsxMzcwLDcgQEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRkcmVzcyhDUFVSSVNDVlN0
YXRlCj4gKmVudiwgaHdhZGRyICpwaHlzaWNhbCwKPiDCoMKgwqDCoCBpbnQgcHRzaGlmdDsKPiDC
oMKgwqDCoCB0YXJnZXRfdWxvbmcgcHRlOwo+IMKgwqDCoMKgIGh3YWRkciBwdGVfYWRkcjsKPiAr
wqDCoMKgIGh3YWRkciBwdGVfZ3BhID0gMDsKPiDCoMKgwqDCoCBjb25zdCBod2FkZHIgYmFzZV9y
b290ID0gYmFzZTsKPiDCoMKgwqDCoCBjb25zdCBib29sIGJlID0gbW9fZW5kaWFuX2VudihlbnYp
ID09IE1PX0JFOwo+IMKgwqDCoMKgIGludCBpOwo+IEBAIC0xNDA3LDYgKzE0MDgsNyBAQCBzdGF0
aWMgaW50IGdldF9waHlzaWNhbF9hZGRyZXNzKENQVVJJU0NWU3RhdGUKPiAqZW52LCBod2FkZHIg
KnBoeXNpY2FsLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqAKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHRlX2FkZHIgPSB2YmFzZSArIGlkeCAqIHB0ZXNpemU7Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcHRlX2dwYSA9IGJhc2UgKyBpZHggKiBwdGVzaXplOwo+IMKgwqDC
oMKgwqDCoMKgwqAgfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRlX2FkZHIg
PSBiYXNlICsgaWR4ICogcHRlc2l6ZTsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiBAQCAtMTY2MSw2
ICsxNjYzLDI4IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0
ZQo+ICplbnYsIGh3YWRkciAqcGh5c2ljYWwsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBUUkFOU0xBVEVfRkFJTDsKPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiDCoAo+ICvCoMKgwqDC
oMKgwqDCoCAvKgo+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIGltcGxpY2l0IHN0b3JlIHRoYXQg
d3JpdGVzIHVwZGF0ZWQgQS9EIGJpdHMgYmFjayB0byBhCj4gVlMtc3RhZ2UKPiArwqDCoMKgwqDC
oMKgwqDCoCAqIChmaXJzdC1zdGFnZSkgUFRFIG11c3QgaXRzZWxmIGJlIHBlcm1pdHRlZCBieSBH
LXN0YWdlLgo+IFJlLXJ1biB0aGUKPiArwqDCoMKgwqDCoMKgwqDCoCAqIHNlY29uZC1zdGFnZSB0
cmFuc2xhdGlvbiBvZiB0aGUgUFRFJ3MgZ3Vlc3QtcGh5c2ljYWwKPiBhZGRyZXNzIHdpdGgKPiAr
wqDCoMKgwqDCoMKgwqDCoCAqIHN0b3JlIHNlbWFudGljcy4gSWYgRy1zdGFnZSBkZW5pZXMgd3Jp
dGUsIHJhaXNlIEctc3RhZ2UKPiBzdG9yZSBmYXVsdAo+ICvCoMKgwqDCoMKgwqDCoMKgICogYWdh
aW5zdCB0aGUgUFRFIGFkZHJlc3MuCj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDC
oMKgwqAgaWYgKHR3b19zdGFnZSAmJiBmaXJzdF9zdGFnZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGludCBncGFfcHJvdDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2FkZHIgZ3Bh
X3BhZGRyOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBncGFfcmV0ID0gZ2V0X3BoeXNp
Y2FsX2FkZHJlc3MoZW52LCAmZ3BhX3BhZGRyLAo+ICZncGFfcHJvdCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHRlX2dwYSwgTlVMTCwKPiBNTVVfREFUQV9TVE9SRSwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTU1VSWR4X1UsIGZhbHNlLAo+
IHRydWUsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlzX2RlYnVnLCBm
YWxzZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGdwYV9yZXQgIT0gVFJBTlNMQVRF
X1NVQ0NFU1MpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChmYXVsdF9w
dGVfYWRkcikgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZmF1
bHRfcHRlX2FkZHIgPSBwdGVfZ3BhID4+IDI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gVFJBTlNMQVRF
X0dfU1RBR0VfRkFJTDsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDC
oMKgIH0KPiArCj4gwqDCoMKgwqDCoMKgwqDCoCBwbXBfcmV0ID0gZ2V0X3BoeXNpY2FsX2FkZHJl
c3NfcG1wKGVudiwgJnBtcF9wcm90LCBwdGVfYWRkciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzeGxlbl9ieXRlcywKPiBNTVVfREFUQV9TVE9SRSwgUFJWX1MpOwo+IMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHBtcF9yZXQgIT0gVFJBTlNMQVRFX1NVQ0NFU1MpIHsKPiBAQCAtMjM0NSw2
ICsyMzY5LDEwIEBAIHZvaWQgcmlzY3ZfY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3MpCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRvaW5nIFZTLXN0YWdlIHBhZ2Ug
dGFibGUgd2Fsay4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGluc3QgPSAocmlzY3ZfY3B1X3hsZW4oZW52
KSA9PSAzMikgPyAweDAwMDAyMDAwIDoKPiAweDAwMDAzMDAwOwo+ICsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChjYXVzZSA9PQo+IFJJU0NWX0VYQ1BfU1RPUkVfR1VFU1Rf
QU1PX0FDQ0VTU19GQVVMVCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0aW5zdCB8PSAweDIwOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRo
ZSAiQWRkci4gT2Zmc2V0IiBmaWVsZCBpbiB0cmFuc2Zvcm1lZAo+IGluc3RydWN0aW9uIGlzCg==

