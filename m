Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42BDC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8dF-00013g-79; Thu, 25 Jul 2024 20:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sX8dD-0000wh-F4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 20:16:23 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sX8dB-00009L-6J
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 20:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721952981; x=1753488981;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bdJDqlHl98GmdGtfe63a8dl7CIBm9cd1vhI6+X6kC9U=;
 b=wFDhv6aBKbKnKZhZ6oNkLToOeKkODce9aj1DYZ2RzZflXNKBd0vQRw6g
 +PN5GjivIn09danV9ynBVhnX7m8NbQsE3Y6nDwPoxfMfpKa/uGvviA0Dk
 zA38TPcadiJlhgk1Q7F2enNPbZ1iEPN4fHiOziq1IK0tC6KYfl3NU3KQ+
 jFyGz9LnOotrK8LkEcRvXh38eGd//9OP5Zy0xePRghtA1FZ7cAthGtWmw
 1M5fgPRxxnMeErj7aEWmppeb7aNrnXwdtk/7MkOhZwmlA5rM5nll1Zs8R
 EYazUU9EdbJub5yoSCw5u7Po38Hc6JD8CxJvoq7U4com1FRnlwa+Z4lzT A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="126177168"
X-IronPort-AV: E=Sophos;i="6.09,237,1716217200"; d="scan'208";a="126177168"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2024 09:16:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/msRtNH3MKuWiyHNbHxe+lmgwwG+rB8JRUcWWpFbfNyiQoTgmffdFxjDMJ+vDNWSuUy3VDRRDo1RNBjBdkSDVv9FqFQR+PEJCIpA6h4jZBuTO69nrULdCtQhOB7gj4o4aw4J6hTWBIAkqEoraNaeR+y06t15sLPrx7dTlVwAHqG7UjthWtrErOPHpRxvgD4mSMEkw+o7ElPIK8HV14h8A1X8isNyp0mA6HTDu6g4CL9LOD/qqHL/INZKOomU9epYcFzd5MAlXYSUrbFtBaQhfEVbTXUnB5q60xPuC9Ysxl2a/XlO5IN6xigNHX7YYpYRgvR8bx4ID9H8KKGwIYliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdJDqlHl98GmdGtfe63a8dl7CIBm9cd1vhI6+X6kC9U=;
 b=sCif1SPhm9drEoQXooXx/SfUw65RNsLC/78EqzM6f+6VKO0UuYky3yLwx4cadOrFKdmtu6zRtz3WNOueRATT2Cya6ETYLmUQVuKztulBTSfmMjLEedHft4SXQzlZzK/M2Xg6DnRMoCgbldkasCFqCbG8BrbGxdAk31H149FG24SL+8No7+WqYqTUJUOOeAN2irsc4opAdn1rCqnp0NqNPh9YDqf8/HJNwDCNXhwxWHlodBy7xZP72bPiqhqK2ou8fp8M+k2KflNBcn0nP2Qe1SaU0UTCe4eNwWlVvzY4aW7AI9d/LLlabRxq593K1ZNezHy4UvXYBENCFBYgnVTbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSZPR01MB8012.jpnprd01.prod.outlook.com (2603:1096:604:1bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 00:16:01 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 00:16:01 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/13] make range overlap check more readable
Thread-Topic: [PATCH 00/13] make range overlap check more readable
Thread-Index: AQHa2+y+M3hJ4iUEQk2slUBuC3LfYrICTOWAgAAAX9CABUVbgIAAkTsw
Date: Fri, 26 Jul 2024 00:16:01 +0000
Message-ID: <OSZPR01MB645328F814AD0BC9629BF2A18DB42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <CAFEAcA_rBrA=Fy_m+U_OZaznbBn3wykTCyUf3S5aMA36YHXNkg@mail.gmail.com>
In-Reply-To: <CAFEAcA_rBrA=Fy_m+U_OZaznbBn3wykTCyUf3S5aMA36YHXNkg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YTVkOTIyNDItNTBlZS00MTBjLWIyNTYtNTZmOWM3OTU5?=
 =?utf-8?B?ZGM1O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTI2VDAwOjA2OjA3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSZPR01MB8012:EE_
x-ms-office365-filtering-correlation-id: 02c9b459-dce5-43b8-c14f-08dcad08216c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?NVVBczNYejBDLzd6WWF0c1pYbGx2R1liK3FlTk1aa0tlM2V6K1lWNWZLSmJu?=
 =?utf-8?B?QUREL1VWL0tkZGo1RmNBVk9uVzk5Z2ZEZE5RNW9SVWR4K1d4a09YeHJqN2Ns?=
 =?utf-8?B?R2E5TENTQU9nNGlHZTVRV3ZNVGlNbnJmNXBVK09XR2xSYmxkQWhoZFlKaDlp?=
 =?utf-8?B?T1M5WVBjK0FwbjhCU1hwVUFxVm1nRXBYSlU0Z1BjQmJMOVNxdXBWYjBRMnQr?=
 =?utf-8?B?OFpESjdCOVBMTVBSWDlCYU9sbEhtVnUrRXh0RzlHMGpWV2dkenU1WDF4Qmta?=
 =?utf-8?B?SGJPTzlRNGdlWkFvS2tKcS9xcHdvK3pPTlprdTVHdTNoOGI4a1JhaG1MNUZG?=
 =?utf-8?B?aGZwUFN6TFBrSTk3S3IzZTlRczBNeGtjaUE5dlNzNFh0VUVVVG1jT001cG0x?=
 =?utf-8?B?NkRiSWwzRjlNTnpPdEU1bG0rTkxUSHBNYXpCVlNSMW9sOTRFSHNkYXZIRnQz?=
 =?utf-8?B?UzZSZURSR2Nqa1RLUk9oSHZrOVBsVll1UldJS1JlYVZKRHBtUnlZdFBUeDBt?=
 =?utf-8?B?UWhVYmQ0alBNYkQ1dkxWTm5XaHdvbVQzVThHYzVvS2JyM29YVzRlRnNMZnF4?=
 =?utf-8?B?YVNQMHU0OXF0NzFXSkZLdEhiWWtxWTBWSWlxZ25reXJweGNKQWVsdHBWVkcv?=
 =?utf-8?B?Wk1wQ254Z3k5UkY1NHR0ZjJ6dUFyTEIzamgzbzZFL1pPT1FaV1dqbFRpendY?=
 =?utf-8?B?YmlWYWY1SW50SVFXajZPa0ttZzFsU2F2ek1MeUlrT3NEWW52cUpma3BYSlpj?=
 =?utf-8?B?RTVSeGkxcERRZVhSQXNOUXRoV1l6VkN1SnJkRS9mSlJ0bmhSanJrWExaU0N2?=
 =?utf-8?B?VHdnR3BwNFJnOGlkYU1CSmJERG0reGlXZnl6YXk1REhWa3FhOUo2K0RsL0VE?=
 =?utf-8?B?ZkZRdDM5dSthUkIyUTB6bk4vUFdpNU90TjBqMkhTUHpqV0h2YWphWFZGVGha?=
 =?utf-8?B?M05LSEdnVGsxaXR5aEw2emdYMzNKQjFtTUxVbjluNVkyd3psRzdHWEk3dFg0?=
 =?utf-8?B?WEdSU2JyZ0N0QjZDLzE4a1ltcm1GMEVxWU5VYXF3L2dPYzRrV3QvUU9GK2dv?=
 =?utf-8?B?elVxazFmZDlkQUxodXpWbWszR21BVVRNTWpzamJLdGpzS0lYejhGQklnM1Ra?=
 =?utf-8?B?Qklmbm1FSEtocTd0ODY2YzFFRjIyR1k1a1pPMVJxSS9mdUlsQUJiNlo4SmFl?=
 =?utf-8?B?alJZQTlzdVBqMDB3ZUJsOUNMck9OUGtRZHAxZitmOVRzQzVaWmwyWUlQcUUy?=
 =?utf-8?B?MGUvazkvV1dVR2JQSUdvMVIzMmd5WHoveThFOTY4WUVzRmpzQ1FKdDNlbVc4?=
 =?utf-8?B?b05qY09QTVh6TE5uOVR1WjN4VHZuTUJ5UDFRV1VJdEFDUzYyUjNHS3VXK3h2?=
 =?utf-8?B?ekdpSjlsM1NBZmdPNnF5dWtrbTlGbk96V2lON0Y2WFlDSUFUY295QkxLdWZO?=
 =?utf-8?B?QmhFaGtZUk53SzhWZHBhNzh3bHROZFlnQ29Lcmd2TEZJbTFhZVF2V28wTUZm?=
 =?utf-8?B?eUs0T05pQy9KeFhBN2c4L01IMS9PUEhQNXRBdnRSOWhLS2hPdURuNlVCc0ty?=
 =?utf-8?B?VFJKRkFjUllSSkNLWWRTdUthTzlaVlZiaUladkhKTk9haytwZ1I3Z3pxR3o2?=
 =?utf-8?B?c216MmlvUHNQNmtDWEMxTzJsZmRQQ3NYY21TekM2TThHYkcrWDA5YUtJcUJQ?=
 =?utf-8?B?SEc1VDFaNThUdnYrdFphL3FFbEJTNk44aUxrUzljRWpNeGMxK05ON0FHbjgz?=
 =?utf-8?B?a0NLbHRDRnRKZVlKRWpUK0ZVcXZpYyt2Vkgwdm1NblBubU1uUlBUc1dpS0M2?=
 =?utf-8?B?ZEJiYnhvMkFBTmd2ZDE1Tmx5QVhFNU90QU5sS1BqeEd4dEkrK1hXOVFXd3Zv?=
 =?utf-8?B?TWhBdGRVazZJSHNjVCtxR0EwcEt1bVdTTzBzVXBVdUdXcXM4MVNtM2IvMEJa?=
 =?utf-8?Q?Q7lzu4dqlCA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxDbWpDbzF3czFRdzFzb08wSEhoNW5rajdvSUNlNms5MzhjMENpdFo4Tnda?=
 =?utf-8?B?Q21WcnN4UENFYy9pZXNKaFJ5NU1TN1dGUXZEaFRaeFJRSXAycWpESmorV3Ru?=
 =?utf-8?B?MVpBc1B5YWlCVWRJeWhjcVBpWGlGQWhWbUlUY0VobTJsbldwOU1PQW1CV3h5?=
 =?utf-8?B?S2U5UVZVWGxvMVA3eFVXUG90R0dHS3owU0hwWU5xU2UweHVDUUc2eFdBYm5F?=
 =?utf-8?B?cDlkcnlSbHBEb0ZzSXZHSjd6LytVeXIvTWhrbnh1a1ZZNlE2RUhrTDYxMjhL?=
 =?utf-8?B?MnRRNWVyRjdUTGtIVmJ3UUpYRVBDY2NaZWxLOEZBQzhyanFYNnRFMnhhSW9H?=
 =?utf-8?B?ajVZbXk3dHp4cm8wVEVWamY0WXRjSmRSMk5EVUlDemVGN2R4YXgzTWcyR3hH?=
 =?utf-8?B?ZkYzM3MzM0JJODRoV01yRGRRY21YYXNpZlllMUcvVHF5NE9ybE5HWmtPVW1i?=
 =?utf-8?B?MmNhR0lqd0JDUzdlb08xQmlIaVZrVVRtSW0wcmdhSmhqaUd5ekY1WEdwN3VE?=
 =?utf-8?B?ME1Wb1RDTE9VRVk0QmNkc0kycFFRSmdCQklMMXBJNHVtR1ZITGN4c0JnK3ZT?=
 =?utf-8?B?ZWhLZVRwSlJhdkYyM01qTkxZc1VLYnFoTkovUmFZOHhqOTJibFpxcm4vdGh2?=
 =?utf-8?B?a21PMjBaU0d1eVlkOHRXRHBjV1NRa0ZteEFKenROTGRMWFVYRXVscGg0ci8x?=
 =?utf-8?B?Q2FRa2NDaDgvSWNVK0tzTkVwN1NNTEx6SmY4ZXpOeXY4K1dTald3K3c5dmZt?=
 =?utf-8?B?WTduZ214T0RydTFEQTAvNzA4ZG0yLzVtNjRjLzk0Z1B4VTkxR1lhNVBpOXVN?=
 =?utf-8?B?V0djS0VDSmdBdHg5ZFdhS0pnMGFYWUxjSzBZb0ZKMkQ5TVRwMTk0TFZiTExD?=
 =?utf-8?B?ZlVIakxhOWZ2Y0tVQVRrK1RvOU93SnY5TmtuVEJkSUJGTjhXNCtTZmFvUmZo?=
 =?utf-8?B?amZTOW5WTnpQMkJUb0FIM2NIajd5S0U1RXlxZERRQVJhbEZGakJ4MXVMU1dv?=
 =?utf-8?B?UlA5WHZVSzJzQ3k3ak1mS0lXZS9WRnYzVlNmMytrT3UySW15Qis5VDdHbWlj?=
 =?utf-8?B?NjRGNS8zSWRPdGlJanA2Q0hVS3lTYmpDbHNIYWEvelZrWkxRS3UyU1VSWmd3?=
 =?utf-8?B?WFZCelNKcjdDbndCL0hQY3VoWGFlZFpaT1hxS1pQa20yZFZOVzVqdmNWNm15?=
 =?utf-8?B?ejYrUnEzQ1VpcUNJV0dhbzc4ZzNYYjNCTTBMRlBrUVNrcUZ5QWZ3S2ttdm4w?=
 =?utf-8?B?V1BXazZzT0QrTnorT2ZneDh4WklJKzY1TXlnWjFyM0tMQVJacUdNaXpwRktQ?=
 =?utf-8?B?eGpQQkptTFNuWlAwbWNVNGo4dTdhUFFMQmtwcjBrZnFRWHBSVmVuWjNpOVhJ?=
 =?utf-8?B?TDhRdkI3Qk9hZUF6d05VUlgzRnJSVGRFc2VzSFdFeGpmM0FBZFdrWUtuK2hw?=
 =?utf-8?B?dmVycVMzSXBOUXhFUTVBN0JwdjVxVnUwdDJwTThObkN2NWRJdFpFdkh1bDNV?=
 =?utf-8?B?cmp0Zit5Wm9DcG80SmN1cVk1YlV2L3p0bVlTak45eXhJVkFUR0dOZy9QMFhR?=
 =?utf-8?B?dzc3L0RGSmpONENVVmhzUnhqQ2V1V1dJbUNuSFRiZlQ1MEVJWXpiZVR3V215?=
 =?utf-8?B?N2JmY1pxcXFKZWF1a2ZPbktKNUorcW9Fc1JPakg2VmJyYlMwRDhqTERGSHBI?=
 =?utf-8?B?TjlYZmR6MHRaK29MeStpKzB3Yy80YWthemcxYnV3SEZ6a1o1VTdLOTZTQzli?=
 =?utf-8?B?SUdGUjZhRzdzVTBQdC8xbW5tOFY2SHhVN3NBZTVuelh6Qmw1RFhjbkZzRXdJ?=
 =?utf-8?B?cmRJb0w4QnJqK0xaelBQanpwRFZwMFhYcy9SQkhLRmZmRmd0L09kZlR4SXp2?=
 =?utf-8?B?VjhDTzI2Zm5UZFVhdkg0UWdZL1ZRc2FjbGUwZGVoczZibVN3aEpUVzVJaTVi?=
 =?utf-8?B?QlFYdXd5U0pHRG5oTXdKNlVoNjlTek5HVERMZlcxRHB0Y295cTh4ekwrd3Rq?=
 =?utf-8?B?L3lPUGE1VzByeTF4ajBxeWNHUEhFeTFtNUJMNFU5UzBQS1BXUDZLVURCWTF3?=
 =?utf-8?B?Wlo3c0F2WEhtNTdvUHplWHRQQnNkc1JaYkJZZE1oNDIxRDVlbXB6QjVsRzl1?=
 =?utf-8?Q?+hKNjVUIF/3Zg8PB2720ofzKs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5VaFa5vP45+/6GaImQl8JptF+zmNNED3tOT8V6IdMXf5pLOTAQFpwsUO523zxayNW9rIAgxgBHeQWhFuu5VzYH1MNXDfE74GuQnMLrEmiIbDELgBGw7gEInRULwZh9qWRJ4p3Yz/98aPfC3+ZDXP9ezVwT5HRqYn17v/7tHph5vE7Mil79qmygtM/6M6nGKIHE54OJmN7ouYS4trNMgDmp1jVwC0wNXdz8I3G3c4b5puisIriM2JhQBzoo2nCiKgl2emXhEusNb7v3wUxKuYz8KGvXspxKFEyYmBMgcBbu9xIUlvhDMsVfhIP3Shz8bE/c4hPXfUhYbpDNo/fcnfHZfer3ANTelBViJGY4xEL20jDXvUMM15SsqvZmpIEn9bntJmDRj8Ma/GGfE75tr7wyndjvhIZVUFNZMabn/cGMG6dVTEejs8ddx9NmBSznSkbkhyvdneSlSz8r+ndP0YdV/e7tNdc68xDlhdk0peVY1YhSoPNOE2VxoP7iAnF3DZRcCgPGHm7sF03LH56uwFWcb/BTFt1CO4USpXnKFwy2+ecgtT2+n17I5IEKX9pZd1ifZ1VlZotnfp/mSFITJu08bXYj1sDTU5ZKtf+uMmFayKQsRv4l0POiAZjE2PiYRQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c9b459-dce5-43b8-c14f-08dcad08216c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 00:16:01.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlqSw25yYnhMU+7bpekLqdoix8WXURLAK5BQMzD1xTrvH3GdEQYekkzOSvMVfbxlsG5cuEK8KHBKt6JJdIktIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8012
Received-SPF: pass client-ip=216.71.158.34;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNSwgMjAy
NCAxMToxNCBQTQ0KPiBUbzogWWFvLCBYaW5ndGFvL+WnmiDlubjmtpsgPHlhb3h0LmZuc3RAZnVq
aXRzdS5jb20+DQo+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xM10g
bWFrZSByYW5nZSBvdmVybGFwIGNoZWNrIG1vcmUgcmVhZGFibGUNCj4gDQo+IE9uIE1vbiwgMjIg
SnVsIDIwMjQgYXQgMDg6MDAsIFhpbmd0YW8gWWFvIChGdWppdHN1KSB2aWENCj4gPHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZz4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogTW9uZGF5LCBKdWx5IDIyLCAyMDI0IDI6NDMgUE0N
Cj4gPiA+IFRvOiBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2myA8eWFveHQuZm5zdEBmdWppdHN1LmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8x
M10gbWFrZSByYW5nZSBvdmVybGFwIGNoZWNrIG1vcmUgcmVhZGFibGUNCj4gPiA+DQo+ID4gPiBI
aSBZYW8sDQo+ID4gPg0KPiA+ID4gT24gMjIvNy8yNCAwNjowNywgWWFvIFhpbmd0YW8gdmlhIHdy
b3RlOg0KPiA+ID4gPiBDdXJyZW50bHksIHNvbWUgY29tcG9uZW50cyBzdGlsbCBvcGVuLWNvZGlu
ZyB0aGUgcmFuZ2Ugb3ZlcmxhcCBjaGVjay4NCj4gPiA+ID4gU29tZXRpbWVzIHRoaXMgY2hlY2sg
bWF5IGJlIGZhaWwgYmVjYXVzZSBzb21lIHBhdHRlcm5zIGFyZSBtaXNzZWQuDQo+ID4gPg0KPiA+
ID4gSG93IGRpZCB5b3UgY2F0Y2ggYWxsIHRoZXNlIHVzZSBjYXNlcz8NCj4gPiBJIHVzZWQgdGhl
IENvY2NpbmVsbGUgdG8gbWF0Y2ggdGhlc2UgdXNlIGNhc2VzLCB0aGUgcGF0dGVybiBpcyBiZWxv
dw0KPiA+IHJhbmdlX292ZXJsYXAuY29jY2k6DQo+ID4NCj4gPiAvLyB1c2UgcmFuZ2VzX292ZXJs
YXAoKSBpbnN0ZWFkIG9mIG9wZW4tY29kaW5nIHRoZSBvdmVybGFwIGNoZWNrDQo+ID4gQEANCj4g
PiBleHByZXNzaW9uIEUxLCBFMiwgRTMsIEU0Ow0KPiA+IEBADQo+ID4gKA0KPiA+IC0gRTIgPD0g
RTMgfHwgRTEgPj0gRTQNCj4gPiArICFyYW5nZXNfb3ZlcmxhcChFMSwgRTIsIEUzLCBFNCkNCj4g
PiB8DQo+IA0KPiBNYXliZSBJJ20gbWlzdW5kZXJzdGFuZGluZyB0aGUgY29jY2luZWxsZSBwYXRj
aCBoZXJlLCBidXQNCj4gSSBkb24ndCBzZWUgaG93IGl0IHByb2R1Y2VzIHRoZSByZXN1bHRzIGlu
IHRoZSBwYXRjaHNldC4NCj4gcmFuZ2VzX292ZXJsYXAoKSB0YWtlcyBhcmd1bWVudHMgKHN0YXJ0
MSwgbGVuMSwgc3RhcnQyLCBsZW4yKSwNCj4gYnV0IGFuIGV4cHJlc3Npb24gbGlrZSAiRTIgPD0g
RTMgfHwgRTEgPj0gRTQiIGlzIHdvcmtpbmcNCj4gd2l0aCBzdGFydCxlbmQgcGFpcnMgdG8gaW5k
aWNhdGUgdGhlIHJhbmdlcy4gQW5kIGxvb2tpbmcNCj4gYXQgZS5nLiBwYXRjaCA5Og0KPiANCj4g
LSBpZiAoY3VyLT5waHlzX2FkZHIgPj0gYmVnaW4gKyBsZW5ndGggfHwNCj4gLSBjdXItPnBoeXNf
YWRkciArIGN1ci0+bGVuZ3RoIDw9IGJlZ2luKSB7DQo+ICsgaWYgKCFyYW5nZXNfb3ZlcmxhcChj
dXItPnBoeXNfYWRkciwgY3VyLT5sZW5ndGgsIGJlZ2luLCBsZW5ndGgpKSB7DQo+IA0KPiB0aGUg
a2luZCBvZiBpZigpIGNoZWNrIHlvdSBnZXQgZm9yIHN0YXJ0LCBsZW5ndGggcGFpcnMNCj4gaGFz
IGFuIGFkZGl0aW9uIGluIGl0LCB3aGljaCBJIGRvbid0IHNlZSBpbiBhbnkgb2YgdGhlc2UNCj4g
Y29jY2luZWxsZSBzY3JpcHQgZnJhZ21lbnRzLg0KSSB1bmRlcnN0YW5kIHlvdXIgY29uZnVzaW9u
LCBidXQgaXQgaXMgZGlmZmljdWx0IHRvIG1hdGNoIHRoZSByZWdpb24gb3ZlcmxhcCBjaGVjayBi
ZWNhdXNlDQppdCBoYXMgbWFueSB2YXJpYXRpb25zLCBsaWtlIGJlbG93Og0KY2FzZTE6DQpzdGFy
dCA+PSBvbGRfc3RhcnQgK29sZF9sZW4gfHwgc3RhcnQgKyBsZW4gPD0gb2xkX3N0YXJ0DQoNCmNh
c2UyOg0Kc3RhcnQgPj0gb2xkX2VuZCB8fCBlbmQgPD0gb2xkX3N0YXJ0DQoNCmNhc2UzOg0KY3Vy
LT5waHlzX2FkZHIgPj0gYmVnaW4gKyBsZW5ndGggfHwgY3VyLT5waHlzX2FkZHIgKyBjdXItPmxl
bmd0aCA8PSBiZWdpbg0KDQpjYXNlNDoNCm5ldy0+YmFzZSA+PSBvbGQuYmFzZSArb2xkLnNpemUg
fHwgbmV3LT5iYXNlICsgbmV3LT5zaXplIDw9IG9sZC5iYXNlDQouLi4uLi4NCmFuZCBzb21ldGlt
ZXMgdGhlIGxlbmd0aCBvciBlbmQgbWF5IGJlIGFsc28gYW4gZXhwcmVzc2lvbiwgSSBjYW4gbm90
IGZpbmQgYSB3YXkgdG8NCmhhbmRsZSBhbGwgdGhlIHZhcmlhbnRzLg0KDQpTbyBJIGRlY2lkZWQg
dG8gdXNlIHRoZSBhYm92ZSBwYXR0ZXJuIHRvIGZpbmQgb3V0IHRoZSByZWdpb24gb3ZlcmxhcCBj
aGVja3MgYXMgbXVjaCBhcyBwb3NzaWJsZSwNCnRoZW4gbWFudWFsbHkgZHJvcCB0aGUgY2FzZXMg
dGhhdCBkb2VzIG5vdCBtZWV0IHRoZSByZXF1aXJlbWVudHMsIGFuZCB0aGVuIG1hbnVhbGx5IG1v
ZGlmeSANCnRoZSBjYXNlcyB0aGF0IG1lZXRzIHRoZSByZXF1aXJlbWVudHMuDQoNCiANCj4gdGhh
bmtzDQo+IC0tIFBNTQ0K

