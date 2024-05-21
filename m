Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A335C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIC-0000MF-UQ; Tue, 21 May 2024 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHd-0007mg-2c
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:02 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHa-0001co-6l
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297118; x=1747833118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gOL1Z/9VTnohgeJlr7Aoab7lzDrd5FOG5MHKFkUZjKc=;
 b=pnx5gT3TGQ5rNEtDhJxQ3MveUljbp2owHSV17EuPNIoFZHCFieJ2/g9G
 QB2qgKV2pAeb8AsmRZY+PnsuZys1gXoik+bB+kw4Oc49yEgdhyRAO40OF
 kb0Q1uiRtiqg4b6jEexy8yKWjcHdKvFnUGSaWxe+EAKq0gq40UFgpr+vq
 z3vU1HnYugWsYNZVEfIoRHQVr75StqBZtyy8s8oGL6OTBbiQfyX0YrUCs
 aScS1qUyR0moSNX6zqAVtylxJgrOU6l7IkoUKHSsVnsj8seMhFjogx++5
 tuPxRBQfHN1Gep5yJnZ9xKoFr8L/Iqmsdxlp4NJt9quOrHFOy/m4bF4fO Q==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13011546"
X-MGA-submission: =?us-ascii?q?MDEsXXfpqCkV6Bs636Xm3BSa0iLQrFgKudtVVn?=
 =?us-ascii?q?UfKmt3yrCKOSuXqOL4fa4YSeILtk1b7H4Te6GDRHr9MxNTVFEkkjSJmc?=
 =?us-ascii?q?d4opj+R0FbzcikEeMXeE157qJe5H2KWk+pz+isu02a0OEMIFKsRYjsWq?=
 =?us-ascii?q?+CF67joztEkYYMtaH1pq1Znw=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO0bfDfYq/kNQWZwbLqOdDWEyAls5gC+6c0fRJUOMo6aP6EgjCWABEebBWQ30UVTWEfhqIZS9MzaoT9RnDaUF3MbonH1iVDqjDuSC6Xyavn/i5rzWdKsutkSEnOZ0wHbZahtTiD2BUuo38jc4QxETaIMou5Ap3utbo8V288yhqPdggqaBa6+ZMu+PLTlpbA8LCZxXiHPTxVSkhLXWhxHJ7O79ouk4RPvmM2OT9x6up6VuU1aUzWbRwzJqq8KkATyXngfVFwS6DTfCexzn869wwumKt4wPknjyDbNsO5cxYR0s2BwbX1d9FFHqvu8+KU9XXbz/Ru79r1dZwVBplu5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOL1Z/9VTnohgeJlr7Aoab7lzDrd5FOG5MHKFkUZjKc=;
 b=lhufddWhhXhq/6q8OIDbXtH8NvLt2Y8un8fRmiYtLXMkfg6xpaeijGt3A0iQwyHvcMNjWGRgNqkPrKWDpjVSYEBCFNOzNhFE77SVSgLHISHjGkkS7N60UXroaYUUcPiPlOl9vPN72OIjV8AsrMHw8dQMVc9OhDTOV+ZhNeTtWbQAeQZbDXCYEvpSVN77k2tgRgxNRw9Xj5/kyld0yeGU3WdrAsCGKMZo3IYHcF86sojX4zuynvmOt8nFFxlCGOoPxPzeBcszfEGk6cyXS2O589YL5v9QP9ZGOuajXknHi0/KOzAPOK+Y7y0Z97g4BZNE2A3Ezs8QRc9FmYqeao+dKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 22/22] intel_iommu: add support for ATS
Thread-Topic: [PATCH ats_vtd 22/22] intel_iommu: add support for ATS
Thread-Index: AQHaq4Bzxu50+1LF9ECmS9tKvgO8/A==
Date: Tue, 21 May 2024 13:11:54 +0000
Message-ID: <20240521130946.117849-23-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: fa369c92-c842-41dd-5263-08dc7997960f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WTUxREQySTFWdlpoZjNJN2kxSUhoNEVlM3E5bTFvQ3JkOFBnTm1LRTVwRWZC?=
 =?utf-8?B?VnRxaStLZk8vVnJHTWZhbzJkNzI3bzVaN0l6VHdVOFh1V29IZWdmeFhWUXVJ?=
 =?utf-8?B?QWhQSnU4dWJFNncxdThwd0NBajQ2Z1pneW5Gb2dSMFlTbklPNEx3QllYSCtH?=
 =?utf-8?B?bzdHTkliOEFkTk5zNzdyVTgwbkN2YjJvZEIvbVRvRkk0ZW1pYTcxa3FsNDY5?=
 =?utf-8?B?dUVRTWU3RHQwbU4vVTlxK1pBVExvNW1yU0N0eTNkWTFtR1VBc3NFY2tYWjJy?=
 =?utf-8?B?M3VacXluVjNITkFGc0JpRkJLL25aQVovVE1IL3oya2dHVXVJOTZnQTZ0TkdL?=
 =?utf-8?B?MlhMcjNXRzA2ZzNEYThEeTlUVG9yRDNVTTN2UE1IdlNDWFdLVlpvZDZmSlpQ?=
 =?utf-8?B?VDlRNmFYNHQ4b1hiYzdUL3hodWFETkRTZ0trS3QvYkJKdzRKWElmYUJTNktx?=
 =?utf-8?B?SzZkNGZSWjdWZGFoc08rWkFPQ0plM3RkNzBjcXlzQVF5UDJCaXFIc1ovOGVE?=
 =?utf-8?B?eWI5UlA1d3AzZVYrTjh4WWIvbG1ERW5LQ0llYzN4ckIxd05tZ0RyYWNpWG1y?=
 =?utf-8?B?VHBtZndPeWV3TkhOcGZMaDRDelMvSnhMTmx2Slh1LzBUNHJPTUp5VjA3TE0y?=
 =?utf-8?B?OTZZa2xDZDBMb0M3azN4b2FINUhBdysrdU42U1FIWXNSTnhmbzRoNTFncDdX?=
 =?utf-8?B?dXNFQ2dYZHdXTlZYaXpCYnVkdCsyQytNMnM0aFNwY2l1eUFiN014bEJRUDc4?=
 =?utf-8?B?UzRJWkVDaVE4aVBUZU1FcG5OUFU0NlNCc2dybUpiZ3hZTXQ2SXZLUFhQeTdG?=
 =?utf-8?B?aW55dEFBZ3A4a2dablRrZVZhZGhTMzJMVnk3cXdmWGVXWUlKSDY1dFc5c3JS?=
 =?utf-8?B?NmZMTkcyRTJQem1rdFE4eWRLRzBBU2oxNkhRLzJVOXoxb0pCYlhUeDdTVkEz?=
 =?utf-8?B?MnV3NUJmeCs2S2RTSmdFUFhIcFNQR1RnRU1DN3RZMGxYZTJkMXQyalFtM3NM?=
 =?utf-8?B?OVhSUjE0V1kxK3MyYzZwYkVRRGxTU0NXUU1TRFEyMFRrMWNkVUNBNjBBMlRT?=
 =?utf-8?B?RkplUTBFcENrdytodlUwTE5jcTBqSGQ4amh1N004Wmd4VllyMEhoa0tTY3p3?=
 =?utf-8?B?RnpmM0JOaHRHZHZiTHpqb215WTk0MitNSzlUbUswOWE3S0RBdTQ5ZGM5MCs3?=
 =?utf-8?B?d2NDZjU1UXp5Z1BCMUtQdDhXRmY3L00rY3I2ZlZ6OXFRZTRSSVJHYkVueWU0?=
 =?utf-8?B?V2dDM2JOQ3kvN0JLY2U2YkdIRDAwVDI1UHN0K1FXVnJTdTdpUUFUblRCNXB6?=
 =?utf-8?B?bXdvWElVMFcxSVRWYVArWFNxSElralFGUkZ1YUJZT24rWE1wMVhTaEw5bnF0?=
 =?utf-8?B?bVFienhWWllLYTFRWCtWSVo1S2oxR1Z6U3cwY0U2RlBLcjVkQTQrMVl1Qm1k?=
 =?utf-8?B?NGlLcUdENUw2bHNpOXIvT2FsWHRudDJrUkpqWEhVbzVxNHJFRkZLSmJKd1N5?=
 =?utf-8?B?V1FhZXNFNWtKckdtT0ZhM0ZjbGxnaHlObHJUSFdQeS9GYm9penRuOWV2MGpE?=
 =?utf-8?B?cW9LVmJkaDhSckpPMXNmMHFFR2lwbTNQNGJ4L0E3M3NQblA2cWtGYS9VZmJG?=
 =?utf-8?B?YmM0TVU2NTFuSUtUdnFBVE82WTZPcWptd09Ua09USUhKMHh3SDU0ZkQyRmUy?=
 =?utf-8?B?bUcvZk5IeGxHayttcUNTcVJUbElKbjJnbFBaekpsbDV3bzM5K2x6K0syWDIy?=
 =?utf-8?B?WXNhZ2Y0RXNwTlJJU2RBZDFpR2NZcmxnQ1AzUWp0TlNmK0hLMnFnbVoyaWw4?=
 =?utf-8?B?WHIzWE1RdkVXSzNwaG1pUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVNmcHdQUmVjRGMxSTZXNzZ5QW1mdDZZcGU0bVF1aDIrd3dSdFg2emx1KzV0?=
 =?utf-8?B?d1l6UWtpVDVkbkVadzRtcGl5U1pRMlZtU2N4RTZyb29GWXpDRTM1TTBKd0Vr?=
 =?utf-8?B?UFl5c1JaeTI5MkErK1cvZnlXdENjTlNiWGpLaFJNQnNrdDRCakYzY1F4OXJT?=
 =?utf-8?B?aHJMVk84SWZHNkc4SHg4czA5akQvM2xMTzF2WW1sQlNtNXg4SlhPV2Jpc21j?=
 =?utf-8?B?MjR6RWptcVlDKzZNQWtIMGtoSlBDdHFxdmQ4dXozSm5VWUhGR1pXV2tKaC80?=
 =?utf-8?B?a0w2djRJYkkwZURVR0JUYzhweE9TZDVFNkFiTFo1VnduVlFwcGhpbHFXdGJR?=
 =?utf-8?B?Y1NuUE1WUzdXZ3FTWWdERWlBY2ZJTUxUblJQYjdJUGpmZTQzMHdvMXY2bDRw?=
 =?utf-8?B?ZDRyZ3JjVWQxZDc4eEl2TlREbjltUlErZnZ6d3p3ZjJFWmk4QktYbXNyYVBH?=
 =?utf-8?B?Y3RBLzduY0V0N3lYc0llcFEvb3c1QlFRRHBoTkNZS3BCRVNHZ1EzbXBmWm01?=
 =?utf-8?B?dGFQY3BSeU9LVC8zMitpbjl1b3AzV2VYZjJuS01GTmdLUTdsNVRxa1RyZVJF?=
 =?utf-8?B?RndKV0YranhDQ1VueHBybzMzUmlCck1IZ2RXbVVQaDV4ZE4yWFZCamFjclJS?=
 =?utf-8?B?bktDUWIvZFJGU2YwNEJLTEM0YlBaeS9PL2hkSW9zUXdibFQ0VHkzSW5sRE1q?=
 =?utf-8?B?Vlo1RXYxZ28reFdid1phSWYxYWdoaFZzN1Y0azhIcDRHYkdVd2V5NnZqdVY4?=
 =?utf-8?B?OWdOQ1NtelpmZkRvekp1N3dhcnlKQlVyZ3JRQXNoZDRvVGtUZGtqTVUyM0Rz?=
 =?utf-8?B?Mis2SlNpbGMzQnkwdDFFN29mOUdKb2RDTXc5dURnLzROT2paVUVOMmduck1v?=
 =?utf-8?B?eXhCUlZkSVZvY3RUcHdZWTNMRkIyd0N4cWM2YVUwZnQ3aGNTZnZMNkd2OTY0?=
 =?utf-8?B?OEVzaWc0bXVVclZJQlowR0hpbUdVQ2ZKeDJoV3ZPODJxUWIzNlZhZ082ZFFt?=
 =?utf-8?B?cDFXWFUyNjhQTkFRQnd2Ums1dlgvL1FtdFFHRDFCMzM1dkhUWmF4VGMxYVRl?=
 =?utf-8?B?d2t6cENhclFBRlN0SkRvYmFLMDhQSDQwbGFNdkFqTXlCYXdMd2FGejN1N2ZC?=
 =?utf-8?B?UFllRFQrR20xOEcvN3NiMlRiMXdEZm4rVXNBM2l0MWo5OWVFSU9WZUFzdWo5?=
 =?utf-8?B?UDlNQ0pHcHpERUx1V1RkeEN5UUxxbnJIbXFLd0pqQ1dWL1J2emVnbUJPZnlQ?=
 =?utf-8?B?Ujd4cncxUWZTazdUQUcyQlNGSkFaOThKSDZ1dmt6QlZFSHFHWndPN2RvTEVN?=
 =?utf-8?B?cldEOXE3Zkk5TUZnZ3VtU0M3YTZpV3J1YkJ3dWs3UUt1MGJra01xb3hpYklC?=
 =?utf-8?B?SVo1Vk5WalMzSnVGQWt2ZmJEZ0ZrcGRCZGVXME12U2dVUVNub2hNSGd4NGFy?=
 =?utf-8?B?NGl4LzhTY1NoSTB6K3V4c2tvS0x5RXlmZzNnRDl0eUhEK0xjbDUrQU1qR01M?=
 =?utf-8?B?R21RR3o1UDVWMEpEamxKdmtyeWdGcUwvcFNBNExIRjdKTnMwaXZZa0VOV0tM?=
 =?utf-8?B?Tkt4QnVDVy9tL1JNMnZtcEtpS0JtRkI3M2RvWkZJWXJwTndXcHRFOWVrNWpZ?=
 =?utf-8?B?SklYb3FKWVd1ZzJJZXYzelR5aWo0bFpwNnJuNU9jZkxFZXlSRk9HYzRXek4z?=
 =?utf-8?B?VGZoOFl2YUxuSUp6bW5tT2tBVmhBNExwTkRFYXJiWmlvM0lpZjdnWGEycUFy?=
 =?utf-8?B?RUIwNEZocklkaFlYY25ZYUU0Y01vNmtvMnkwVnMxeDRuK1doRytlYzFPaDB6?=
 =?utf-8?B?eTFQLzdJL0hIQnpRTEFrMndvazBMVXVVT1RiMm0yRUQ5Y25rSmJOcU5mL0pJ?=
 =?utf-8?B?L1lxWkEvb1FFNjhsZkZoeWVVY24zeXlxL1dURDMrYTZoYWZoMEdyZVd6aGpJ?=
 =?utf-8?B?aU40ZHZIUmswL3JKTzRmYkZVUjJuVWpJUzNoV2h1RHE1U3hxVnZJbWV1T1oy?=
 =?utf-8?B?aGErTnZJVTZWNzhSSjBHeWF5Z28zdVUrdEY2cE92d1M0c0gwMjBmVDVLSEZ2?=
 =?utf-8?B?eklPYmRwMFJjanE5VTkzQytFK21TL1Z6TThkT1E2T05Lb0Y4L2NnUkwwTU5J?=
 =?utf-8?B?VXFPRmNVcTZ0OUI0RHpSU2thSlF4UkJ5aGtQMDRlRURXUS84RTFXa2duaUJP?=
 =?utf-8?Q?tyYlwJuweBbA1jrCmtp8s2Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8819F41F246B241ADF517B5B0D27918@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa369c92-c842-41dd-5263-08dc7997960f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:54.4017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92L/N0jEPxcPOEqzBWr9FusqqwsU2CuQPYdzjpwb6IRnJ6+XcXtoz2UxJe0u6EZg1U66nJldLqHXUjkanUxLbok/uwby85mMmJ9CGKoK1FwMzONAJwSiSjW0R/TH6zTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNDk2YmVkOTQ0Ny4uMmU3OGViZTZkMiAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtNTM4MSwxMiArNTM4MSwxMCBAQCBzdGF0aWMgdm9pZCB2dGRfcmVwb3J0X2lyX2lsbGVn
YWxfYWNjZXNzKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLA0KICAgICBib29sIGlzX2ZwZF9zZXQg
PSBmYWxzZTsNCiAgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KIA0KLSAgICBhc3NlcnQodnRkX2Fz
LT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQpOw0KLQ0KICAgICAvKiBUcnkgb3V0IGJlc3QgdG8gZmV0
Y2ggRlBELCB3ZSBjYW4ndCBkbyBhbnl0aGluZyBtb3JlICovDQogICAgIGlmICh2dGRfZGV2X3Rv
X2NvbnRleHRfZW50cnkocywgYnVzX24sIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgPT0gMCkgew0KICAg
ICAgICAgaXNfZnBkX3NldCA9IGNlLmxvICYgVlREX0NPTlRFWFRfRU5UUllfRlBEOw0KLSAgICAg
ICAgaWYgKCFpc19mcGRfc2V0ICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsNCisgICAgICAgIGlmICgh
aXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlICYmIHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05P
X1BBU0lEKSB7DQogICAgICAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9mcGQocywgJmNlLCAmaXNf
ZnBkX3NldCwgdnRkX2FzLT5wYXNpZCk7DQogICAgICAgICB9DQogICAgIH0NCkBAIC02MDA0LDYg
KzYwMDIsNzUgQEAgc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICp2dGRfZ2V0X21lbW9yeV9yZWdp
b25fcGFzaWQoUENJQnVzICpidXMsDQogICAgIHJldHVybiAmdnRkX2FzLT5pb21tdTsNCiB9DQog
DQorc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoSU9NTVVN
ZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGh3YWRkciBhZGRyLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxhZ3MsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGlvbW11X2lkeCkNCit7DQor
ICAgIElPTU1VVExCRW50cnkgZW50cnk7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0g
Y29udGFpbmVyX29mKGlvbW11LCBWVERBZGRyZXNzU3BhY2UsIGlvbW11KTsNCisNCisgICAgaWYg
KHZ0ZF9pc19pbnRlcnJ1cHRfYWRkcihhZGRyKSkgew0KKyAgICAgICAgdnRkX3JlcG9ydF9pcl9p
bGxlZ2FsX2FjY2Vzcyh2dGRfYXMsIGFkZHIsIGZsYWdzICYgSU9NTVVfV08pOw0KKyAgICAgICAg
ZW50cnkuaW92YSA9IDA7DQorICAgICAgICBlbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KKyAg
ICAgICAgZW50cnkuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQorICAgICAgICBlbnRy
eS5wZXJtID0gSU9NTVVfTk9ORTsNCisgICAgICAgIGVudHJ5LnBhc2lkID0gUENJX05PX1BBU0lE
Ow0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgZW50cnkgPSB2dGRfaW9tbXVfdHJhbnNsYXRlKGlv
bW11LCBhZGRyLCBmbGFncywgaW9tbXVfaWR4KTsNCisgICAgfQ0KKyAgICByZXR1cm4gZW50cnk7
DQorfQ0KKw0KK3N0YXRpYyBzc2l6ZV90IHZ0ZF9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRy
LCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3Ro
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisgICAgSU9NTVVBY2Nlc3NGbGFncyBmbGFncyA9IElPTU1V
X0FDQ0VTU19GTEFHX0ZVTEwodHJ1ZSwgIW5vX3dyaXRlLCBleGVjX3JlcSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpdl9yZXEsIGZhbHNl
LCBmYWxzZSk7DQorICAgIHNzaXplX3QgcmVzX2luZGV4ID0gMDsNCisgICAgaHdhZGRyIHRhcmdl
dF9hZGRyZXNzID0gYWRkciArIGxlbmd0aDsNCisgICAgSU9NTVVUTEJFbnRyeSBlbnRyeTsNCisN
CisgICAgKmVycl9jb3VudCA9IDA7DQorDQorICAgIHdoaWxlICgoYWRkciA8IHRhcmdldF9hZGRy
ZXNzKSAmJiAocmVzX2luZGV4IDwgcmVzdWx0X2xlbmd0aCkpIHsNCisgICAgICAgIGVudHJ5ID0g
dnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoaW9tbXUsIGFkZHIsIGZsYWdzLCAwKTsNCisgICAg
ICAgIGlmICghSU9NTVVfVExCX0VOVFJZX1RSQU5TTEFUSU9OX0VSUk9SKCZlbnRyeSkpIHsgLyog
VHJhbnNsYXRpb24gZG9uZSAqLw0KKyAgICAgICAgICAgIGlmIChub193cml0ZSkgew0KKyAgICAg
ICAgICAgICAgICAvKiBUaGUgZGV2aWNlIHNob3VsZCBub3QgdXNlIHRoaXMgZW50cnkgZm9yIGEg
d3JpdGUgYWNjZXNzICovDQorICAgICAgICAgICAgICAgIGVudHJ5LnBlcm0gJj0gfklPTU1VX1dP
Ow0KKyAgICAgICAgICAgIH0NCisgICAgICAgICAgICAvKg0KKyAgICAgICAgICAgICAqIDQuMS4y
IDogR2xvYmFsIE1hcHBpbmcgKEcpIDogUmVtYXBwaW5nIGhhcmR3YXJlIHByb3ZpZGVzIGEgdmFs
dWUNCisgICAgICAgICAgICAgKiBvZiAwIGluIHRoaXMgZmllbGQNCisgICAgICAgICAgICAgKi8N
CisgICAgICAgICAgICBlbnRyeS5wZXJtICY9IH5JT01NVV9HTE9CQUw7DQorICAgICAgICB9IGVs
c2Ugew0KKyAgICAgICAgICAgICplcnJfY291bnQgKz0gMTsNCisgICAgICAgIH0NCisgICAgICAg
IHJlc3VsdFtyZXNfaW5kZXhdID0gZW50cnk7DQorICAgICAgICByZXNfaW5kZXggKz0gMTsNCisg
ICAgICAgIGFkZHIgPSAoYWRkciAmICh+ZW50cnkuYWRkcl9tYXNrKSkgKyAoZW50cnkuYWRkcl9t
YXNrICsgMSk7DQorICAgIH0NCisNCisgICAgLyogQnVmZmVyIHRvbyBzbWFsbCAqLw0KKyAgICBp
ZiAoYWRkciA8IHRhcmdldF9hZGRyZXNzKSB7DQorICAgICAgICByZXR1cm4gLUVOT01FTTsNCisg
ICAgfQ0KKyAgICByZXR1cm4gcmVzX2luZGV4Ow0KK30NCisNCitzdGF0aWMgdWludDY0X3QgdnRk
X2dldF9taW5fcGFnZV9zaXplKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSkNCit7DQorICAgIHJl
dHVybiBWVERfUEFHRV9TSVpFOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMgdnRkX2lvbW11
X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lvbW11LA0K
ICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQs
DQpAQCAtNjIxMCw2ICs2Mjc3LDggQEAgc3RhdGljIHZvaWQgdnRkX2lvbW11X21lbW9yeV9yZWdp
b25fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQogICAgIGltcmMtPnRyYW5zbGF0ZSA9
IHZ0ZF9pb21tdV90cmFuc2xhdGU7DQogICAgIGltcmMtPm5vdGlmeV9mbGFnX2NoYW5nZWQgPSB2
dGRfaW9tbXVfbm90aWZ5X2ZsYWdfY2hhbmdlZDsNCiAgICAgaW1yYy0+cmVwbGF5ID0gdnRkX2lv
bW11X3JlcGxheTsNCisgICAgaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gPSB2
dGRfaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb247DQorICAgIGltcmMtPmdldF9taW5fcGFn
ZV9zaXplID0gdnRkX2dldF9taW5fcGFnZV9zaXplOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgVHlw
ZUluZm8gdnRkX2lvbW11X21lbW9yeV9yZWdpb25faW5mbyA9IHsNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCmluZGV4IDFiMGQ4OTU4YWQuLjQ2MTE1OGY1ODggMTAwNjQ0DQotLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KQEAgLTE5NCw2ICsxOTQsNyBAQA0KICNkZWZpbmUgVlREX0VDQVBfTUhNViAgICAgICAgICAg
ICAgICgxNVVMTCA8PCAyMCkNCiAjZGVmaW5lIFZURF9FQ0FQX05FU1QgICAgICAgICAgICAgICAo
MVVMTCA8PCAyNikNCiAjZGVmaW5lIFZURF9FQ0FQX1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8
PCAzMSkNCisjZGVmaW5lIFZURF9FQ0FQX05XRlMgICAgICAgICAgICAgICAoMVVMTCA8PCAzMykN
CiAjZGVmaW5lIFZURF9FQ0FQX1BTUyAgICAgICAgICAgICAgICAoMTlVTEwgPDwgMzUpDQogI2Rl
ZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQogI2RlZmluZSBW
VERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQotLSANCjIuNDQuMA0K

