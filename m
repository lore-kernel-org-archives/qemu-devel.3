Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E1CCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqBp-0001D7-GM; Wed, 14 Oct 2026 00:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGqBi-0001CB-NR; Wed, 14 Oct 2026 00:01:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=740cf4029=Alistair.Francis@wdc.com>)
 id 1xGqBg-0003mi-Qh; Wed, 14 Oct 2026 00:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1791950523; x=1823486523;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=81QJ/QDF/MKuTz4lxEd8LGExbKWAvDyEFGaG4xjO76o=;
 b=FnHBDa3L3X5cFYt9KcROWPl7+mfZUO1tlZNy070I1J/qQbIHJr5UYJ6/
 0JZCiyQ+1yGmb9QRb05D/kie4Rwek3uUns7V8scKO4QbKAN247O0X7Ghy
 VkLEHCcRf76TyP9AD8tALam6IIAqff46ekSF9EdIolJstTok8wkFKmH/H
 B9brMki9JmcqRC3ZqxWEnSqs/bzoHZ6VYAO/0CkOSF8sVsMnuHk0+nf2c
 hOPzsanqHBXgEe0EXFAy/uBJVLRH4BXfRO00WPgfgSiOifZVK/Bs4TKVT
 7ghBbdKJs7paNsP0/7hkMtp2y8UuoRWWiFKprRwV/PAbhWN25Swt05puy g==;
X-CSE-ConnectionGUID: OFgys8w8Q+af5vHuyoCdlw==
X-CSE-MsgGUID: Fbvu+1X1QPqEPGJ3fjrvNQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1786982400"; d="scan'208";a="158046768"
Received: from mail-northcentralusazon11010032.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.32])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Oct 2026 12:01:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiUPo3iEWiEKjbKkX4GkUI/VnTthPuZhZYz3EF5KBlH7P6xIASKsKJ1e4pExGJu0TYWADgtVPvqFgrYfZPjRZcFVlPTXCiDFFl8xU7Ega09b9wYVM+KbknDzUrsMHVwSb8ldE1EjyAj0XvfEI/JZZGvQB9QLWzQrQ+j58OYWKMmZZytpsTIxXTpo098zrDAEuyDllPTNUAfNsmfBjcPaO0Wm4OxMRVZriUVGVbIGpuPmJf5Z5WQEAtF4pJ7SP9miiBOdgcNogdI8fLLwAiacjQGyjOmBT3SEyIjvnsatH3nwczHsQ1UVTayszqcNS9qaSSNajbVBbaRAtgAW/bjRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81QJ/QDF/MKuTz4lxEd8LGExbKWAvDyEFGaG4xjO76o=;
 b=OOMWWgK+8xzW55LuBgQM0wJsj7ngdwiRiiZppyc+Qha+BM+R9dovWLbdzuE4R8+EnXiCF0e962fUmgxI4mtp5ca5LzZuaQseP4l9zSqEBsnGWOArvCOux0hfhAiiKh9WMfI2nsRZt58QOxDHYlBMuoR6cV0rQN5z7nYUFK46jOAohr88rIO55sMhmvp6G3bYMWoHEKz6Vr1U1VZok9CM5ZwodrOKvVfXPn/RyEWSqzgVA9u3KxhukWcSVkzZ4DkRIF1dSuQr96yBEtrBTA8EBhZwspWxv1iUD5iVNlSUcWtqMMfudH/p4RDbLOcqk/Sn+w8zMQ5XBVtqffXijN/jDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81QJ/QDF/MKuTz4lxEd8LGExbKWAvDyEFGaG4xjO76o=;
 b=wezB4u9uQXv98VHqhpbal/qoFKLgSFg74pp8OS+O8tVTPOWhEJC/WDvNJJEH8OK3aQ6l2avklvOoMyKv5RG2IXva8Byi5XmonNyCBQGeckSYDeFPuI9xrgeYIGZwM2lgLwwv28wJg4zuuZGjZJ3dIoq91+GbVMiTDyHn9Q68t+I=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SJ0PR04MB7533.namprd04.prod.outlook.com (2603:10b6:a03:31a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 04:01:47 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 04:01:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/3] docs/atlantis: Update Atlantis UART documentation
Thread-Topic: [PATCH v4 3/3] docs/atlantis: Update Atlantis UART documentation
Thread-Index: AQHdW4uN1o0Tn/+Kjk+1p7WGCxIzxrb8al+A
Date: Wed, 14 Oct 2026 04:01:47 +0000
Message-ID: <577bc3ce9967ecea384817602844feb5a49ef614.camel@wdc.com>
References: <20261014032346.732257-1-portias@oss.tenstorrent.com>
 <20261014032346.732257-4-portias@oss.tenstorrent.com>
In-Reply-To: <20261014032346.732257-4-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SJ0PR04MB7533:EE_
x-ms-office365-filtering-correlation-id: 21a8e375-dba3-4d22-4c0a-08df29a7de79
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|366016|1800799024|7416014|10070799003|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: S++RAQV6RODCia+ZphNTmhPtk+RoohXeJS+p7CYkqevO1dcTKqjI3K9CXEQHyROlOP7qcoUaSJ/EHw9Bi2Ni5LAk6PRiAm0IIAjfckF3g9PZawp5AKmymYNeCIp9y3BEYfF4TeC/gdHS552zNvUjyh3MY3Vh+mpjAXUdJ24HPYZ0+n8pkv5kfJuMQDhqhl+o7XPNVmEalDRkYMiKEq4VFGIN1P7iBvbAMyNo1cSRX4zdW6V40Z8hV/UJKd2xQNSHXJHzJqs1yMDbY4MUejlC5nqPshUYXuS6+wGylLcYZmV/MxgDOMH7eV8Ob25I0mTfYJHTy1P7Gwe8koj0TPhWaJEBgdy/XCYEslnezeBm3VQXq4tSQFpt7pI857PWfWSbSJrpXJXfWF99vJoaWTJZkpsfzVSEbRp7kCrEl5jz4UN7CxDpL2Astvte/2QYmGCrqP3eBM1tq2lLdr1C8bcbkt3Q1N9SfF+3ynXgTzbOSZZkv55ni+hfnn362mzOsEnGCAOFWvHFeIIHg2s9dz0XuZBOdIwZG9mDCNAREYDv/fmvX+p4m453K3adKF8TDiiZLia3K00MZbifeouKWz2+kD3/kuiBj5onWTJBjeveTlI9CSZnId/9fCoVoK/aZX1bh85FpeQ7n1ENpTSstP79mwUKXqNLs57TrLtjvlL0d7VG7d3H5Iotvhke/WxPPyv3E47FcpR7T+07bA7F4A6IQ5PsnJ4UumZEv9OjmuNYUWc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(366016)(1800799024)(7416014)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RytYbzFqTjZQNjF0V00rRmE2c0RKc3RoZFdxZjZRUU9wb3B6SFE2a1YwdUgy?=
 =?utf-8?B?RnNPMmp6ZFJ1aENVSzh2Y0tZWDhYYjVVOVZqZ1hnVjRnbnRnVTlvdW9MTFJL?=
 =?utf-8?B?OWQ1RjhIWW9hWmZYejdhck5MUldOeWhZRURqUytnd1R4c3lha0J5TE9QbE45?=
 =?utf-8?B?ejIvYkFHKzM1OFFMT1V3SHRWL01YbHVHYk85QnMwNk9LaG4zb09UYzZLUFNL?=
 =?utf-8?B?cGhvdUtrSVYzRXhIemdZMWZKcXpxS2V3bWYyMkRvNkhUb0pFZkxraDNNWG5B?=
 =?utf-8?B?djNHazA2UXBybWp0dFZGTWZpc0Y0RG5mcWFRcXJBZjV2SW5QRjdVZ0JVUE93?=
 =?utf-8?B?YWhKa1dteWxXSGkrU2E2MVZ3K3Y5eVVlK2Z2NTJDTFd1U2JMc3VWTjY2VXJQ?=
 =?utf-8?B?eXkzenQ3T1o3ZzJsUnl5RHk4Zm4zVE9xZ0Q0N1VNMzdKbnlsWE9QUDBuWHNq?=
 =?utf-8?B?WDJEaEtHNHhQVkNEdUZ6Rzc1RWRoUFI5bGloWUpwaFlrajdyY3BWSEZjaUpL?=
 =?utf-8?B?WjJNUFBDQUJRUVFOZHBDUDZHL3gvZHRWL29GdENrQm1nR3ZYYWVhTzFoS3RW?=
 =?utf-8?B?bndFVXB1a0ZOaHk2S3pDZi91enVjSnBqYXgwekVFd3dGckhiV1VpaXFhQUxu?=
 =?utf-8?B?RVpBN2JrUG42N1RRZGRWaFY0WWRUb3drZ2ZuRVhGRlJaSVd2eDJKcE0wUVVK?=
 =?utf-8?B?TDFRT1M4TDNZYmttRzdERkFnTTdIQ2VPVTU4L3VPZWc0TzN0NWlYOFFNemJX?=
 =?utf-8?B?aW44KzRtcmE4elpnb1dIdndsZ09ZRzVlL1VxOXMrV3VqVE1PY1NaR002T05V?=
 =?utf-8?B?ZEhmc1lNVlZKQy80T0R1SVc5MzhtaEU1WWVZS2NtcUFzSEhGQUpFSEFyQ2Ra?=
 =?utf-8?B?cFc1NTEwRGpBNy9Pb243L1hHa3pJVHJVdEpyb3UwWXlyUFY4RHFtSlQxSmR4?=
 =?utf-8?B?RXJPQmtLYkhVRTlBaHRzUlFBUXk1VzBZUWJKVXl4dTVoVzdhRithWmNpSHNC?=
 =?utf-8?B?YzA1Y2lza1JGVk1HNWNkNWVYU01paW1DaHpLQWpXNnlUVHljWjdubEJFQUZF?=
 =?utf-8?B?UTRTVUNWdDd5MXpONWd4eFRoNTdZRkhQUjJiTjMvNW9KSzNsUzFNdDJVSVdD?=
 =?utf-8?B?TFVjU3ZIaTloejZ3NytqdFFrYnhwNXN2M3ArVy8xMU9IaEk5YlZ0RWg3WWZH?=
 =?utf-8?B?NHlSS0xTdmZ1ekdNdTZiUzBzUUV5K2dGWTRJOHY1dTlKcFNqN1JabWN2eExC?=
 =?utf-8?B?a3c4b1lpS0llMEpHbmdYRjdmMTdmVzFsdUNlbDh2MG45Zng3WkJ2bi9pRUE1?=
 =?utf-8?B?MVhWYUVVL1hXbEp4VklLNWQ5UHRqRUNGQW1PRFpleXE0OHovU2ViWXhyUFBo?=
 =?utf-8?B?c1IzUlVYV2N4MTVUMmVsZlgwWnVONDdyaWM0TFFtUXF3alQ0UERPOUd4bGNa?=
 =?utf-8?B?V2ZLZjBycW5VQWVKeEtHcDJDZngyaStyTyt0WUJVbldSaG93SjJtZXlidU1F?=
 =?utf-8?B?bFFWVXptZGdaOWpkTFl2YTcrUklBUithNHhZS2dMbEc2MVQ0a05LdjhqRDdC?=
 =?utf-8?B?UVkzVERZR1crSXhzTmgwcnB4Q1BnQ1ZWcTdXUFJsVTd4Vi9kS3g2UFl2SGxX?=
 =?utf-8?B?N0ZPYXVXa1E1QjFZa21jaTFlemo3bERiZUlMRkEwRE41L1d6UWg0Zitrdk1I?=
 =?utf-8?B?RUo3RzZVSFc4Z1p0dS81RHNKZmxOQjdmSjNwQ0poa0wvME1TdWV2QmM0YnB4?=
 =?utf-8?B?cHZrblhSMncrMVZ4MjFVc2NlbEc3SkQyRmJraGVhNXVnWDJvSG5meFc5NFly?=
 =?utf-8?B?a1JXdUJweDQwY3ptSnhIV3NXU3JTKzJIMEg5S1ZvWVp2R3BMa2VVSjBvWCsw?=
 =?utf-8?B?TUFPNm5NUk5rL3pKcC9ZSUdlK1lRaWZqd2NjK2xMUDUvNUF6OTZJZyt5cEFP?=
 =?utf-8?B?TXdVWDZETFZrb3dnTklNMDZidmphbk5xTDhIeU5UeXhKLzIyYWFCZUJMOXdZ?=
 =?utf-8?B?QUxzODVJVW5kaG9wb1B0QUR5ckpsRmVqTEU5Z3QwclI3SFZ3ZGlTaTVWcWFy?=
 =?utf-8?B?bjhhSmYxbm1XZUZoYm1PcFNBTmI1VWNqdmRxWlgyT1ZhVHZEYjZSMWlDUFNL?=
 =?utf-8?B?MzVYc1hwZU9jVzZYd0lKdDZOMVVmSjJRMmIzeHdsOE1jTlAyMVFBR2NIVU00?=
 =?utf-8?B?Y2crbnZPV1REQ3BNS0ljNFRGTFJSdk1Xd1ZBSHYwWTlWZ1pEb2N4MEErWm1I?=
 =?utf-8?B?YytBNTJlOFpxWmNqcTR0a2RQMXhZaVhaOTYrVzJuWEEreFo4QUpjZmc4WnV4?=
 =?utf-8?B?dkMxUTFPQS9WR3I5b3pXUFBiMzNETXJScW93T3lBSllWckJtMWUvbWFjanZD?=
 =?utf-8?Q?1NjvPI4TWFn9cPtZal/13m2PR9Yd9Y83itEkYues+umYY?=
x-ms-exchange-antispam-messagedata-1: k2hIeTmix9z3K7skiYqiGCbusLELk77rdw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18D74BAF596D2D4E80AADE583C6758A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: unLmHWF1ROzqL7atg73JxjqFNNX3sqz2PkTenpM7Rkizrkx5f2GlBrIBNw8x0ipbOBYLMZ/IY/wVlt0SPNWo35WdItqQtArV2vfGUUNHUylj+6VwsgKGAyzy0AogSyNW+/epq9IzQCWBCI6v/IO45I6oWYznePgLIF/GQ+G/wfaspRhNZqxm6L9le20rZlya7uvZNypoprYn4WoTLd2mhhtShu4cvP5+Yr4O5W/1t8VupVP51hXOrOF1hMEghxTCroa5GbGSvjqNmHZz3FIgnD+5YiRXXNXy8OBgBsmiMmVD+qqjk1Jd90mimAeEoKVxxPYbauHGbtNGIpRMm9g7Wg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vztOdPA2q+FdJXRpuUZeKNkADVH0eAN0X3IrjdTo0cHkxtEKhE21vNBxG+TXwAawBPORyIWnV9nFqfJeX/6NOUY1WNn30+k4p5NMPeCWWOU2+JDRh79VZ25dZdFoNW/yFKY46dHATajg9LkMeaUR/A2GfqZW0nuat7lqNgIukP1k0GjFlAw56co3ISyMqMyi+mCiLI1HNmIeEpT79YuZNpyszrA/W1J1c9xCa/OmgLvDDbxKn/D0Q9MqZbTUjAGeTuaskav+zGsKf63FM840FUpQUxQZgn4ONthU6nQYUD5sGpJt8vWK00H/IpTzPRnDjssF9t3mT/k9f+y+bd6LQJZZ3FeXdNFv6dhnUv8iO+P00xUj20yhPFYzV2s6IRMnOajvqnCX5TNOqoJnY7rMWzFPJT2E4y9NDKvBxiZZXeb+2ABF5fAPH9B6FZmMko8Z6rKS1fPgTKS3L2IKeV3tPTki5xNtMPWu9z69ba7vMDVLbOb37NrK66OYCvkyBRdWH3NxkG4I+K3wCMzwrgs0oq0ek3xmqtx+OztBo1DnzqTK2kHf8j3xXmTHDvORVH2kUIhl9Ax5sfH9kjPxLMqTz6dDAczx/Fn4AM+KaoEw0VZJwYDVXbo4YZtB2Z8QPwQH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a8e375-dba3-4d22-4c0a-08df29a7de79
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 04:01:47.8249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ue0HlrIzg5mi1AqunZSzQGFj/QFEnYv7cPxbSJzawftHtlgohNYhlZmlmt5zprKJXhLwN9RjyYg4cC4VQ2e785QnN50rlxqIobjdfhpfRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7533
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=740cf4029=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDEzOjIzICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFVwZGF0ZSBBdGxhbnRpcyBkb2N1bWVudGF0aW9uIHRvIGRlc2NyaWJlIHRoZSBEZXNpZ25X
YXJlIFVBUlQgdXNlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9y
dGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGRv
Y3Mvc3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdCB8IDcgKysrLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZG9jcy9zeXN0ZW0vcmlzY3YvdHRfYXRsYW50aXMucnN0DQo+IGIvZG9jcy9zeXN0ZW0vcmlz
Y3YvdHRfYXRsYW50aXMucnN0DQo+IGluZGV4IDFmMjg4MGQ2MTcuLjAxNTAxNDBhMzkgMTAwNjQ0
DQo+IC0tLSBhL2RvY3Mvc3lzdGVtL3Jpc2N2L3R0X2F0bGFudGlzLnJzdA0KPiArKysgYi9kb2Nz
L3N5c3RlbS9yaXNjdi90dF9hdGxhbnRpcy5yc3QNCj4gQEAgLTEzLDcgKzEzLDcgQEAgdHQtYXRs
YW50aXMgUUVNVSBtb2RlbCBmZWF0dXJlcw0KPiDCoA0KPiDCoCogOC1jb3JlIEFzY2Fsb24tWCBD
UFUgQ2x1c3Rlcg0KPiDCoCogUklTQy1WIGNvbXBsaWFudCBBZHZhbmNlZCBJbnRlcnJ1cHQgQXJj
aGl0ZWN0dXJlDQo+IC0qIDE2NTUwQSBjb21wYXRpYmxlIFVBUlQNCj4gKyogRFc4MjUwIGNvbXBh
dGlibGUgVUFSVCB4NQ0KPiDCoA0KPiDCoEtub3duIGxpbWl0YXRpb25zDQo+IMKgLS0tLS0tLS0t
LS0tLS0tLS0NCj4gQEAgLTI0LDkgKzI0LDggQEAgcmVhbCBwbGF0Zm9ybS4gTm90YWJseToNCj4g
wqAqIFRoZXJlIGlzIG5vIFBDSSBob3N0IGJyaWRnZSwgc28gdmlydGlvLXBjaSBkZXZpY2VzIGNh
bm5vdCBiZQ0KPiDCoMKgIGF0dGFjaGVkLiBCb290cyB0aGF0IG5lZWQgYmxvY2sgc3RvcmFnZSBt
dXN0IHVzZSBgYC1pbml0cmRgYCB3aXRoDQo+IMKgwqAgYW4gaW5pdHJhbWZzLg0KPiAtKiBUaGUg
RGVzaWduV2FyZSBVQVJUIGlzIG1vZGVsbGVkIHdpdGggUUVNVSdzIG5zMTY1NTAtY29tcGF0aWJs
ZQ0KPiAtwqAgYGBzZXJpYWxfbW1gYCBkZXZpY2U7IERlc2lnbldhcmUtc3BlY2lmaWMgcmVnaXN0
ZXJzIGJleW9uZCB0aGF0DQo+IC3CoCBzZXQgcmV0dXJuIDAuDQo+ICsqIFRoZSBBdGxhbnRpcyBw
bGF0Zm9ybSBoYXMgNSBVQVJUcyBidXQgb25seSBgYFVBUlQxYGAgaXMgY3VycmVudGx5DQo+IGV4
cG9zZWQNCj4gK8KgIG9uIHRoZSBjb21tYW5kIGxpbmUgc2VyaWFsIGludGVyZmFjZS4gYGBVQVJU
MWBgIGlzIHRoZSBBc2NhbG9uDQo+IGNvbnNvbGUuDQo+IMKgDQo+IMKgU3VwcG9ydGVkIHNvZnR3
YXJlDQo+IMKgLS0tLS0tLS0tLS0tLS0tLS0tDQo=

