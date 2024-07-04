Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0BAC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNkh-0003P4-8C; Thu, 04 Jul 2024 10:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNke-0003OL-MJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:00 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNkd-0003KV-1N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720104479; x=1751640479;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=SQiMwa9CJetiQJHx35LmIpI3/UCo1yz3IC6lLqlpfXAAKBW5rXYXriZa
 YUnAveKnyEp/t97hEj4LeCfg3RJr1XzK9nz0EY44h/ob/FmFUkqhR0q7a
 Sg+CSyz6Uls1/KebJtabPpp66bzK3PWJwYpXeIlHhTHmoTxwSwBoW3JuR
 bmqZn1UqjH+ZaKrJJE/ST+FZEC47fDN2cvvqF0DvvQx2mfBiDWOzGH/q9
 TGGumM6RUxOnlbVjguyLh7Oe2QAEU5Eyw+YECtPpNPh6T6FmQboZpfFdl
 KMsy54f/hZwRUJRStRNj0rSVwmON9sDbWqDl+9eZzo6T5EgywYDZqLtPZ Q==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="16005881"
X-MGA-submission: =?us-ascii?q?MDHHAwn0dQXRYrONlGIN7dz8bDAZUDLaNcZp05?=
 =?us-ascii?q?xRK5Gh0+ZB+1vv+5iA8Z7VMQuTaIPdOGFHQrafqH9OKSb+y6wl+sl+Nq?=
 =?us-ascii?q?rNBrwZLK7hF7JZF+wzN0zb2yrwr0mD5zv+SJkss+GcfHCA0ArWJ8ONap?=
 =?us-ascii?q?guxzXcPQfXL5xZu3xoBZaB4w=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 16:47:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISlvHX5/kGRuV6A22897bc4xHpGOzZFlUWvAtdudBwZf/OiThodjeT093YQuVUs4BxJdGKZSRsLmYdRwkZMA/4CoPFD1imk/oO6qV5gu5N+OIJ1+OGcLhffSdVATTWj6adVUj6rrSIvkuFNSfoVrJQcguWY1dannCZEh2mzfRznAT+bttT/l4xds/9MDHTkLUVgInFhzU1yUrK3avJmlQKy3NfKiMQQWbw3SY3JwpHR/yk9pb3TZERQtd6ZzGjFegTpDwt3tZEaOYyReP1Ek37bpGFiE9YPnaaUAolXBLJ+vSsGuxkGynHTUqwAqIgQ0kCJ5V+gabAOFvQXZCiZ1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=jxnWGYZ8jFioIfrWEBfD7/qL7y/bvOhpKylGzGcMzui+sRTmHWU//5j617L8f91zKxbfYlZJWQzqijbSje9YG8lTlZA6rBsvtgt+q1eRNdd12gkGV5WTAZunOaclhqkzTO8kgWBMe9TWfpsMErezclE6jwJ4MPTVGA2lcq/+KKYrhmvhcgyL9eVBqw7whmL07aTGjdMxPi42h/2ErA5kdXFC5fk+A5l2ded9ZSCPkuZ3lgt1Cg/9f5yJsUunIomFA+xg5SzoSK70TWQr2snK49DXLjcPvjTXjUhccCtSQPnDsDp35uN3OZTC994GXfE83LK/pRiEkqu3KKv0xA6w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=OwD1SzdyrFiW0gtV8ks48F3EjsOovFUC7uqdFT3Ai+4HIY3zcdS0uyB4LSuoH+4NUcWpvdybXqj0EFFbepI/sDPsPpM2QfmLSwnD5zOszckOir+9FoV6+ljnPKRPkmSda6eN1zf47b2SRxaL0IZ24g4OF5g/NEr7t+zIRWdJsLmsWQBkEVM8nxTDvIL9M/goRSX4ogkJ1d2PF94MxKS/v0FSuwivdbp1UoPZord1ulpDLNOFmMKHo8lRsFTnAL2InGgwpyhuUYHTqQwhOOGoyEFh9Ld0lYEr4CWTDMZmBAAbYUrJ1Q+QnJqCpbCFRRst5rrhZ4vuYPdu0wUYyh32vg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB9499.eurprd07.prod.outlook.com (2603:10a6:800:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 4 Jul
 2024 14:47:55 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:47:55 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v1 1/3] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH  v1 1/3] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHaziEntPU4BZdwwkqAjCf6BiuOgQ==
Date: Thu, 4 Jul 2024 14:47:55 +0000
Message-ID: <20240704144737.996889-2-clement.mathieu--drif@eviden.com>
References: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704144737.996889-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB9499:EE_
x-ms-office365-filtering-correlation-id: 3a3d150f-c827-4e6a-55d2-08dc9c384a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?elNPMkRMMHJSRHpoM3RORFRoTkhwcndlZzlLVFVUL0xlUkNkbFlFeWNPaVZn?=
 =?utf-8?B?VDRmdDhkcy8ySldnejl0SWJMeitEamczcjcrVHkwekd2d2poSXh5Y2JLSlVx?=
 =?utf-8?B?MWlXWWRaS3IvRHJuK3VJeENZT2VSVUZvZ3JLR0tTSzgvcC9zR0w1M1JLSG5K?=
 =?utf-8?B?THVZcHhscEFISnh4b3lFS3FzblVWZlRIZ0FiTkJ4Nk5haEorOUpvZ3h3Z25y?=
 =?utf-8?B?SEthTzYzenp0VnNaV1hzTTBOL3F5VlZRRTJwVEJmT1ovTGZBNUhvdzYyMjg1?=
 =?utf-8?B?Snp6Ykw4cUlvWnh0U0xUaTdaTWM1UUhlVTVpT0dyYytXd1hDWDMxejNzK3VS?=
 =?utf-8?B?c2diL040WjZlSlhvMmZnbm9vdXE5RWpUZkx1eFFlWWVEcDhuaFdzcE45NlRG?=
 =?utf-8?B?SzBQcldNVmZtcWlYSUFhNy9aZEhldTJJdXo1VGJMT2JwVWlUdThkMW0rdjVJ?=
 =?utf-8?B?MjNHaFRpOHZIeTdObXYyRGxvbWxwYkxpMUFnZDQ5NURIRld5NnhZZE9Bb0pa?=
 =?utf-8?B?dTYvbjFRS21iQnMzUzJ6cWJrRnVLbnZnZGJHV0ZXSGkrRGxoY0RPUHlsQU8y?=
 =?utf-8?B?Y2kwWFI4ZzJLL2E0aExyR0g3STdRQkFQelVYdVNqc1pXUDJSTlJxSzNXTWN6?=
 =?utf-8?B?WmRKSWtoSlZKdmE1MHptaE1ITjh0Rm9xMnk3ODB6NGVsNG50MVI1V1lSMG81?=
 =?utf-8?B?R0Z4aFM3ejNidXZ5d29NR090QkZqTTZHL3dTaXhaYU5yc2VQenZSYXN0OUli?=
 =?utf-8?B?SUFlWHRoaS9rQ1o1dHpCKzV0WnBwRU1ndkw0WTMxbE1PTkdtYWg3Mkx4VWs1?=
 =?utf-8?B?dzdyNlJXSUtoQVVvNUdwV3hnRmZSR2U5cDdPcTJxQ05LczRkZHcvT0UyN3dt?=
 =?utf-8?B?OG5EYXV3OGRZS01mT3NDVTQrRDNVRlNvUVlNak14a2RVOW9mZ3VyTTBZYnNj?=
 =?utf-8?B?b3E3Q3BWUkYxb2UwK2VmWTlVcTJXcTNjTzNyenk5b0RsZElEM0twU3pPZk1B?=
 =?utf-8?B?enhBQTAza1E0T2FBdFR5c0V2dk1yS3hHTXU1SHo0UUc2ZDU1MHV5N0lzRmRZ?=
 =?utf-8?B?UVo4ckdEcXpKcXhvemZEdWg4dUY0dnhEcDlzdFV6dUFuRkR3eFhTbnMwYnJl?=
 =?utf-8?B?V2IxVlYvei9rNGIramlFaHFSWGNlbms4aUpIN09WMXduQXgwMnhCQlU3Wkx2?=
 =?utf-8?B?RzduOXR4UmlUbHZoWjI4Ni84RjlITXhmYUF0ck9uWkZiSHRYVGVVTzZ1RCtV?=
 =?utf-8?B?WFlkam5iNDdnMmwvNVE5S0xVZVFrRkVTZGpsQnN6RzFCYXhBYk5aTlN6L2lz?=
 =?utf-8?B?RlZwRFZRYU5zWlQrWTFmQ0hBTEs5SUtacHpiYlVUcjlRZ1F0eEJWd2k1LzVo?=
 =?utf-8?B?N25peE1nbXNSUEJJdmxJV1duNDVGckVjNEgxZGdTa3hETGVUb2Qwd0lZQkdM?=
 =?utf-8?B?ZEI3NVpDWkcyVmdGb1MvSFEwbmowYmNxUFNFWjRaZG12OVFCNm5hd0crUjNT?=
 =?utf-8?B?WkpOc21DKzVnbU1obHlGQUJ6SXpvWk1STDlRY056SHlNWXlGL3RFSDlGb0VS?=
 =?utf-8?B?c0JkZlRzZzZZcFp1WWtNUXUyY2VHeVJWY0RVUng2eG54WmZheitGRnlrSis4?=
 =?utf-8?B?U1lRUzduU2ExOXVkYnVDY1VJY3hiMGpVZjdKblFqVWwzdk9CYUxQR0JHbFQw?=
 =?utf-8?B?cm1xSElxUnNpNjBXM2dOdXgrNmJaOFhIdVRqSlRGWktCZ3VNTEU5eUUveGZD?=
 =?utf-8?B?eTJ2MmVKVFN3MEFCU0c5R0RIQ1VRQVFKZW43VWxJWUtSb21iVyt1UE50ZFQx?=
 =?utf-8?B?NzJlcDB2cG4vdHFpdElvV1BYSHhGamtKYytFcStyRlV6Z2kzUDFRR25UZUQ5?=
 =?utf-8?B?NGVBOEYyTlpFQ3lBbnZWbGcrNXNONUxHaFJHbURXalJsZFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjdZQ25TYlpQRFVzNWEvcEozSDEzYXFQR3BzemhpRU1TV0pOUEZtYi9NSUVF?=
 =?utf-8?B?bWtaVVhkR1dnVmxTQ2FmbjMrN0hYV0M4Q0xjY1JZWnc0ZWdNcTRXeVhOOVYr?=
 =?utf-8?B?UmJ3QThoNXltTjBtekFXd2NRRWhCYzhEZGZ3YW1hZ2NCZi85ZkV6SUp2Ym9L?=
 =?utf-8?B?OVpwYzl2Y1RPUzNWK242Ly9MeHZHTldYSSs3TXgrbFFwSXBSM0VITnlMaUVx?=
 =?utf-8?B?c3pvakxVS1BNc0JVN25IanNEWTluNks2QUY2T0oxdTNHYzZ2Sklxd3VYbHo3?=
 =?utf-8?B?blFqaUZibEhYdGpVUHY5ZzlCRUtCajFBVHRBNDlQaEpSQzRMcTI1Q1IvUURY?=
 =?utf-8?B?NU9nNXlqY1E1U2N3NVJPczZacXJFVkx5NVdtRmVpYnBqNFRuTTdjQlc2eEda?=
 =?utf-8?B?c3poSFo2bjZtcWxTaVZtQ1BtNDdwcmRqVGtDY29WMnJLWjBBQmF6ZE9UcE52?=
 =?utf-8?B?QW4yQVBQcHB1MDgyc0JGbVVGWkhBTTJpWmF0OWNwdC92TktoZTRTRzI2NHRo?=
 =?utf-8?B?a1Flam00eFd2NG4yVFhMVzVzcjc3Yys1aXR1K2Z0QzZGRnI0OXF4Rm1VS2Vo?=
 =?utf-8?B?cHpmZFVMb2UwbEF6bnZjMTBNdGd1czFHbm4yZDRIOWVZbERvUEhKMUt5Ym0v?=
 =?utf-8?B?dTR5QmNsbVRrb2JYaXNKdm9wZDZEYXN1M3QycGlXK3RkOHd1QnNLTFp1aEgx?=
 =?utf-8?B?MXAvN0RFQkdCN2lueWR0ZDh6bGxJVFhDU281ZWVYaUVZSkY2K1g2NS90RjBr?=
 =?utf-8?B?dk9qMzgvNkZ3SjB2N2RyRTlvOW5sT0NJcnZlbjVGbFdyWWZJWlhRVkREczJX?=
 =?utf-8?B?TG5uMkVseVVyZyt0TWo1T1FFTDdNdGd0STFrRkpaOWVBeXBpbElSWlhuTEg1?=
 =?utf-8?B?NVFidEpZenhZWVdtV1FmZjNIREx5SkZGWEMzc3BmQjlLZkM2eVNDUzQ4R0hN?=
 =?utf-8?B?b3hNVFlvUGlxK05CajhyVzltVDFaQUNvSkp6c2pGQXVWRi9mbVlFd3o5VTFU?=
 =?utf-8?B?VFJBWkQ5dW9zUzdSSGtjcWF6YklZNjlDQUU5dEdQbTNGR0N2VE1LeUsybGdH?=
 =?utf-8?B?dWM1NVNiNFpCaFpLbWlIVG1BYmlmd05kVm1reWVBdHFGUmhUVjNUZmxRS1NW?=
 =?utf-8?B?eWNqM0xUU0lnTWplZTFRQk56bHpGVjY3WDlHdGJ4QThwMS9LRktFemRLSG0y?=
 =?utf-8?B?b0NwRHE5L3JyWXBSTHUvUk9LcWQxU2FRalJDRDlVQW84TmNyYzZ0ZDB2dExZ?=
 =?utf-8?B?KytQYk0xT1YyZndJc09lbFh4NHFobHBGSXowZklTL202aFBtMnhnRmVJSkZI?=
 =?utf-8?B?WEdwOGUySkJIaHpaL3hoSTBvQ3NMMStlZlBETlpXSWV6bytKMUs4azFMOHlh?=
 =?utf-8?B?cFVCZ2l1UVRUbFlCMjNRaW1kMExkaUR6NDlGRnBUb3AwUmpCcFhpUFJJZ1Z5?=
 =?utf-8?B?Vm9ZbjVBdTZXZmNVWWhpUHRPTEZjRWZiMVVTd0MwaU1aQjlzWmgyVTJQT2xB?=
 =?utf-8?B?MFk3Wk83RXJ1ZVdsbitkLzZPVXkwRng5TjJCZXRrb2wrVjh1R0F4MEMxNFdN?=
 =?utf-8?B?QlhJdmd1ajJXdnk5VitJK1FqWWIwSjRiVDRuQ21ta2IxdTJsZ2NlUTNSYi9t?=
 =?utf-8?B?bFVUSnVQU1lSbGNCOEZMWFJhU0NvWFVxYWNnZmhsbGo2ZEw0cVRSUmJOTGM0?=
 =?utf-8?B?K2VmZmsraGMwLzEzZG1hUE5LcVBiMmxodEhxdjd5SVJveDFiM3V2NU9hYXoy?=
 =?utf-8?B?YkFsNC9IdHVFNWMwcDhvYlBDSHFSSzhIQTBqQzdLQ05vdzF2OFoxa0ttMXJm?=
 =?utf-8?B?dEl6MmNvcU52RnJNOFpBd0F6ZmJjUFl1RVQzMzhVWElWYzdBZndFMFh0V0tu?=
 =?utf-8?B?bHNUZUcrVDFoa25LU1dJRmRXWVUvMmhPdUNjbnRKTnpRZlBIa2N1WDYvQm1v?=
 =?utf-8?B?eklVWUVhK1dFSFQyVlFteVIzN2Vmb3czV1ZyWFJNU2ZqYjN4QS9IQWdNcEJH?=
 =?utf-8?B?ekJwakFrb2FNNEFNejEycGhyeVUrSzBsek9hOUxGTmpaVWlzTGsvaFpUS08x?=
 =?utf-8?B?RWFyZTlrZXB5RkxxNjM5SzN6b0JLOVh0VVpuTnZobGVNem93Njdhd2w1Yi9J?=
 =?utf-8?B?MUgra1M4QWQ2RWlRallZRUY5MVo2L0xvMmxxNTVXSXp1ajRuMGpXNkFtRTVy?=
 =?utf-8?Q?kb0O8lwNo2VBK/HyYUMRTTo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA7308ED3FFD840B6469C049AB0A810@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3d150f-c827-4e6a-55d2-08dc9c384a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:47:55.6102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Wx/DDKasGc7ODiYT5h4lElaJLdAgUPaSQZ1QawZj8kl53Hgl9Bv3RPzplSZyFfplFh7f8pQQiQ7O02UJR5lo2o/9bKQ2zWWJdNfVak/1CylsPEW+QRA1plQQOu0uVyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9499
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50DQoNCkZpeGVzOiAxYjJiMTIzNzZjICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1cHBv
cnQiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1h
dGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NClJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0IG9m
IDEyOC1iaXQgKi8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4w
eGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZm
ZmZVTEwpIDw8IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAm
IDB4MSkgPDwgMzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwpICYg
MHgxVUxMKSA8PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkg
JiAweGZmZmZVTEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9u
cyAqLw0KLS0gDQoyLjQ1LjINCg==

