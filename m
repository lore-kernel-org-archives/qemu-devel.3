Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA32CC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 04:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUfA2-000160-Gq; Fri, 19 Jul 2024 00:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUfA0-00015N-Sm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:24:00 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUf9y-0005Vy-QF
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 00:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721363039; x=1752899039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=I7L2QOMIQL4xJUZ7jn6Bo7UaYjYtlKmMoEuRBR8g06c=;
 b=C4iuOy4YRyZHVOdhFUuUVsz6OD+G+56aP0xZE9EO9Ib/iKhQdkSTbw+H
 0pCuTyHVc8XGKzDRgLjYmyWO3HIr1A+yHvUWfMQkCxSIUHYEPAjEL1wov
 AY1KnEwe3T2wLEQGWQnPLwN6I/QLiKEq425XvzAACoZZIifrun+lFA3th
 +hlWLRL/maIazhaXHuVIoqZ6gelIFGJVH+gknPHPMVur/wMm2tRF7p+m+
 bs8CPcvZmmION0Tv9l6X9n5OyYYILMOW1QZHzgIZLuvk4FXlj0ncq49Wy
 cYZ9qGPoa481zyo7Obeli3wHUFFMv7HhWudtTBE2wxiOZVA1QdDasdhyq w==;
X-IronPort-AV: E=Sophos;i="6.09,219,1716242400"; d="scan'208";a="16787874"
X-MGA-submission: =?us-ascii?q?MDGth3u8ey/zMAxaKug/ssTEQFLC3aWWan02ad?=
 =?us-ascii?q?uuV0yryPSO34oG6Oo7AJFRJXgzj09miqN+dD+VxTmdqs/KLpn8bXTGn8?=
 =?us-ascii?q?bOl0BE2dOaGlUCz1nrHxnA/hxiVz6qUZnkSrRhdAtolxe8ILjd+ujWVa?=
 =?us-ascii?q?vvRTfENyn3cBlnHmVs2cnPBA=3D=3D?=
Received: from mail-am7eur03lp2232.outbound.protection.outlook.com (HELO
 EUR03-AM7-obe.outbound.protection.outlook.com) ([104.47.51.232])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 06:23:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQjhLAz8r1sufdFGOzRCRFVU6P2lGuIa1NkBRUhLXguu2RQZ8iy4TFrppIsu+A41vJRSQh7gyLBhddSeIJrA//cka2MCGaMPHpaK91AcQLSbOb9Sf+HeyzI309PB8OrhaG9D5NWANQuSuLhyxdad0HjbmJiu5pHJ9QcPtO03LM8BSsHT8zwkLPNkqxCg2u2EMo5KIpFmMOygq6PsXSEPQzB+E908h6DHv2KhbYd2pQSk15AlwS7UakWBEx7fhIQyqdXiVsDNjiNdpsC7YuS2kuZ63Era+Yp/7bE5IhowbUDqf7olEvM8LtCsfTAgsaEuuhfk/No+w3Beri41eXCn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7L2QOMIQL4xJUZ7jn6Bo7UaYjYtlKmMoEuRBR8g06c=;
 b=XC2nZvIxAuGM5mBv73xkgy4KubzMxsFGzvY0DHm923dR1neOUmVKPRkKtjIsrjB+0KXdPeS/n57WYKdt+WukR8XBupu0cmFq6cTLwt8QejBUItPSoaobWndJTs8jO/g14HHgXOVwgx+biAxY7CMATbXKev0zE+XEArWd5Qk0QDKkHe8NbGZE2DF0WmdCjynu5IXCygN+QbJVw/GFqXkli7CMDbKymxFz9WwTtWVTRYm3X3V4Pug2Gy4BBurxnGSbVqS/9W6IhcOubWFlS/GBrcvPzr4/eRa9I3I2C1E2QS1amjVsg91hhVdrLY8mY8fNIt43R0LXDB1dzwTmjl7sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7L2QOMIQL4xJUZ7jn6Bo7UaYjYtlKmMoEuRBR8g06c=;
 b=WbueLfPjxLqJHne3BYZh5GpNkmhsX0l+1NbzWPJ2sh14Ki2+ojrTMgldKj2MSgNS7C0JoQc2eVGRIDgoQuzH2cC3RMAWWK89L8PgcQ3hFfmLOjxPu4ogjsDIq6YOacNJ5UfO4MM0t23/krIGeDyiO3f4J9UKlSI3asMvP+WsPYM7m6xznVU9uejBpQZniT7iLF0TiaSlIaAkZykV968Vad4oWQnpqs++R0vs5Ii8x0dhXmWYh9GMu7mvRddAbjdGmiwBQreKunEtqLA7NpQSmh9dfnFFL5jo7fIBtFUpz22JCEbKZXKQCw6iKALujtCjp65tbxYAQtt5hFDbi82lBA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA1PR07MB10161.eurprd07.prod.outlook.com (2603:10a6:102:480::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 04:23:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 04:23:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be string
 option
Thread-Topic: [PATCH v1 16/17] intel_iommu: Modify x-scalable-mode to be
 string option
Thread-Index: AQHa2Otd8x/JjCr9h06CPB+8aOnt57H8NuOAgAEk9ACAABk9AA==
Date: Fri, 19 Jul 2024 04:23:52 +0000
Message-ID: <0150960d-ac2f-4500-849e-22336a0cc6ef@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-17-zhenzhong.duan@intel.com>
 <ce514028-3ed6-4aba-bfb1-75f52dfc0934@eviden.com>
 <SJ0PR11MB6744FA9E7C8A6C5235E08B8292AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744FA9E7C8A6C5235E08B8292AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA1PR07MB10161:EE_
x-ms-office365-filtering-correlation-id: 1096a145-1e4c-4807-0fcc-08dca7aa989e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OGNyQW94WEZBbkt0Y3JBZytEcGVqbUNVZkVGY2dSRFhpcnRiSVhEMTlzSStB?=
 =?utf-8?B?bEhTOCtEbWk1MWJ5SHRIZVpGa3R6N01XSklWdkFSUVdDVklHOCs4RDE0MWNP?=
 =?utf-8?B?ZTNuRWxrc0srcVJtUTYxditCNGVGYkd1U2Fta3BzNU5CV3NkVmVmNk9uTnEz?=
 =?utf-8?B?dWlWY3ErWkhFYmdaZkdDS2dTR3V5VGFwVnA0bHdPcnljVmc1VkQzUUhoV3dY?=
 =?utf-8?B?SzM1c04rT2MwQk1GRU9jTkRrV1N3aVplWjRLTzQwazVleVMwUFFKcXlKVUJF?=
 =?utf-8?B?TmV0NUJ6MmpLa2F0Ykx3TFN1NDBiZnpjU3o0YXNkR3FRSDc3cDcrdDdvUkM4?=
 =?utf-8?B?aTMxek9WcDQ5SVVKTFB6Y2JKdnZ4V0l4cjVWdUl5d3R6SE1NM0crNjlaVlVW?=
 =?utf-8?B?SmRuTnBnbzZEbXZMc3dDV01kNWVhQzdKZTFTd2MySW1rZTBINTVuTUFHRW85?=
 =?utf-8?B?ZWRJbEtVSVdRa0dlZXNvbFh5cHgyUUZZbE0yZDNwTHFsam9Dd20xcXpla0Vi?=
 =?utf-8?B?c1ViRS9FL0NnVmZrNW9obDN2RGlScVRUUlZHaCs4eW15RndDcWJiV2lqZEVH?=
 =?utf-8?B?R1Nqay94Mm9vUGFQMUhzOU9TN0hBcW55OU1LcmFFQjZENEl4UVJ0RGtZMWRv?=
 =?utf-8?B?YURHVkcwNFJxN2dzRm1kaHMyOWxNV1d3RWZlVkwwWTVsMXNqMVR0ZjNOOHcw?=
 =?utf-8?B?T1l3TWhTeHNZaWNOdlp4b3VPTjJsa0Y5STlsVlo2dTlxNUs1cW5WUis3bUpI?=
 =?utf-8?B?VmJRWHdMbEZ3SFJNQUJBU0cxVzhIRnFxdWFJaFlkWDdSczFxam5DTmdGaDBi?=
 =?utf-8?B?SnZ4K3RWNzI5RjVvM1dyK1NQWjdvR29hZEh2YnVOYkU1WnNLNFRLL0w5em5S?=
 =?utf-8?B?K2VJV2FtTnFyaHRwaEx4WG8zT3dUeFI1cXozNmNYYm9VNjdhRXlqUmRwaTVu?=
 =?utf-8?B?KytCSGw5dTY3N0hpMFp4TkVBVkR4T2JHWnh6cXczYnhWQ25EUldycDhHYTcz?=
 =?utf-8?B?UWpSR0ZFNnNkalE0Zk8xQXBsV0NBNjFQMGhxK0dMNjc1UXpFaWtmOHd1Wm0z?=
 =?utf-8?B?Yk9XNG5TcFc2aGh2NkVqYUg5N1paNk9Yb3hGKzA4WUFLUWtuV3lNWEZCdE0z?=
 =?utf-8?B?S3YveG53L1RFZ3k1T3poYlR4TGhvRHU5Z0dxZlJnc3ZnWGEvNFRwTjFnS051?=
 =?utf-8?B?UmdaWjhSMXB6N1k3UWQxRVBZOWtISHJvNGNxMm9leU9zZ0t0dnBVUng3WGZh?=
 =?utf-8?B?TnRubDJkV2R1TjRKT3NjcE9Od3U1T2ZFVTlpQUYxWDVPQXNsMjVldmpLWWJU?=
 =?utf-8?B?Uk9qYkZoK3dtbDV3VEFZQndBK2ZRVjdUbVZrdnVUclNDTUorcXdhMWUwdXhD?=
 =?utf-8?B?QjBVZi9uaXpXNGxkd01JWlMyQmZPakxNTmpkMWtNb05MM3AvbFhWSnNyUmpF?=
 =?utf-8?B?aExpbW5NUXl0WGJkdldvcSszMWgwWkJpMXJORWhhTzMxMU9ZV25iZHUvdHhF?=
 =?utf-8?B?MGp6UWxabE93RmRKSFNhdFlNMENnRGxRVUlmT1VRZ2tqRmN4VmlkT1VqM2Zt?=
 =?utf-8?B?THRCVHZvYU0xcld6ZGthMmpzWis4bCsyU0loUUJCYXdnaCtuSEdEbU1ER2hY?=
 =?utf-8?B?NSsvUkdZQ3MyRExKY0tjSnpLbHk2WWM5bUtYWW92SXlneHA3ZGFWY21tQlNX?=
 =?utf-8?B?QzExMDlEcVFkak0vTnhvNnRYSW94S2lxUWwrd0ZCbng0aFgvUFBUOW8yWStP?=
 =?utf-8?B?eFcrZ2ZvVkpnMFZMVXNlUGFjZjdEQnpsVlVtSmtpUXlxY2pJZzMzSjdva09F?=
 =?utf-8?B?b3hSY2VvNENURHlveGt2aHVhV21VN3ZnT1RLcDgzYmg5Wnl1ZGJueEpwRFph?=
 =?utf-8?B?dWd2OFUvZEcwMVRpN0Mvck8zd2cvOWVTWWQrdUZ0cUNPaEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlBnV2cwVE84Nm1GRVBSaFNHYnp2RmRucW5EdXQ0TmJrMktBMktuSVZoNlM2?=
 =?utf-8?B?UlhuTmJtZjdtS0M4MUc4RS9oak55eHhjV0h2V1ljR2lLZXR1WS9SeDF1OTVu?=
 =?utf-8?B?VmVEenl2QVlvbVlBUkUrTkhqWHBHUHV3LzFmWEkwLzFEZGNGb25IUCt4Nmkz?=
 =?utf-8?B?c1BlQmRabzA2bVV2K0l0SkIyWnA4Tlp5blA3b0pEMWs2RlNHY2JSN0wxK2xo?=
 =?utf-8?B?U1BSODIwMldmbWVFREhMc1FnV3FSczVZR1ZPeFVkOHhmbTY0MS9UWDlzR3FV?=
 =?utf-8?B?ejJ5by94SDFQVzRvOEJtWFJMeVN5dU5SbW1GSXJZMlM3c3B5ZEVqSGlXR3RO?=
 =?utf-8?B?U2FDUVR1dklmb0pXTzVJYjRseFBrRkc4WnJkeDJaUzdCYU8ydkovZVhaVDBR?=
 =?utf-8?B?YTl4aGl1TGk0c0tDNzM3QnNPbHUwWENWU0tLRmRMUDYzMDdhVUFuKzlOWUlU?=
 =?utf-8?B?dHZFNjh4NHQ0Z3BBK2xVUVEzeUEvb3R0MFNKcmFJSElhcEk0dlJvWWRlYVNy?=
 =?utf-8?B?akdLSlBzb25xaHFvY3VDWFFKU2FzNEdGQU8wUHNPM1RZaVp6SUZhbXlXaDZ4?=
 =?utf-8?B?U29EZWMvcUNiM3E1aER2OU00SWRqeEZGWFhUMWh1UmJPZS9vNkF0SXpnM3lq?=
 =?utf-8?B?alJFVzAvTTROMmxDbHJsaks1UUhIZFRiM2JxeG5uUUh2Nm9nak1YUW5IN250?=
 =?utf-8?B?Vmo5QlNad1ZBZG9JL3lJTlk5ZTFoZnZaWkNHbUhwb2oreWlIY1VGNmVQY2FQ?=
 =?utf-8?B?TGlKdjBSV2Vhc2JJdkhGc2ZEY2pNTnhPQzJMYkJZV0RhWFYrU3N2UmxxOGhO?=
 =?utf-8?B?UTlrbUwxSHFSVnZleEtCWVYzbkt4QWtROFk4bkV1MXNpeTF6UCs2MEplUWhr?=
 =?utf-8?B?c3ZlUjQydzdjOEwxMnJGN1VxTGxoUjArSW5yL24rbUJQSHZyMTFqZmFnYkx5?=
 =?utf-8?B?ejVqb0Y2YUF1em02TnAwTWlieDJkRXZEUDZ2ditqNDdTdjdoSHJOdUZIZmFK?=
 =?utf-8?B?bnBFYUMvTDNqM3lLckNJK3FVVzBPRkF5MnlHdG5lUGRzQ2psaEtzeit1VlVX?=
 =?utf-8?B?dHY1cFUwcDBRa3IxTVQrRVlHVXV2SndqYkRMS2xVQXRlL3Vla1dVbWZycFI2?=
 =?utf-8?B?VUZYZjd5RHhVSGlVa1hlYVZrc3o3L3FnYVRWZjdNazJEQUI2MU5qY3UyNlVX?=
 =?utf-8?B?U1NnM2VIclk1WFo5OCtoVS9FV0lRaGlta3FFbjRlWXg0Z0hjL0tSSFgzT2Uy?=
 =?utf-8?B?amt4dmNxaG9NcThzMnVmU0pEMzN5S2t4VEo1VmxpNnBxc25mZ042eTN2Witn?=
 =?utf-8?B?ZE03YWpBSEY4WjU4UzRsMGNMYjZyYXAyQ2RtL2xYQ0RXTzkrVzdNUDVEVzBU?=
 =?utf-8?B?clUrbDlxRG1NUnhsNGJERmF2SVpGRy9SMXdncW0wazhaK0liSmhUeFMvKzZX?=
 =?utf-8?B?OEFkdTVrMTE0K2llWlN5a2pNTmhPUmJTZTBFSEhzVHltQmZnZzdzT1VBTXVW?=
 =?utf-8?B?a3lQMUZYcXRwRlBHVmlvOXVzMHd6bGFJWDRCZlhMWUFvOTBYZ25XRlZ2NnEv?=
 =?utf-8?B?Vkd1akhzWm1mK05EWm9YdEp3aVVnWHFGaVd2ZEQ1MnVNeXAwMDBYZllTclFJ?=
 =?utf-8?B?blJEV2F2WGEvdDV3UHlOVENJNTR4T25ueVJPZWQrc0FEY3RNdlZCQTMwVHNx?=
 =?utf-8?B?ZERtTlhTK25IdHc5S05sSWJiL3R3a1pYZzErMjljYnlLdzlFSWlDNmFnR0x0?=
 =?utf-8?B?RDRpRVg4OE5YUmUzR2dub1dFdENiRkJ0RHNINjlTMWcvZWIvaE9YMSs5RTFz?=
 =?utf-8?B?SmtvZHh3aGtZQkx1WG1JaVNvZ3V0WmJLeEw3UndWak9JZE9qSTY4ajFiS2pR?=
 =?utf-8?B?UnNpek9DcWpvc2trbi9UWEFpYlNMaWtCM29ydzdkeEw3S1hXTXYzMTZmSFp4?=
 =?utf-8?B?MnZHY0RJVHNUSU9GZjZ2bWRvN0tHQXFFQTZYeEVvUDJheng2Mkk4MjFaL3Br?=
 =?utf-8?B?amk5dXJXTzl0Z0RpWWhzM3d2aFVhUG1LZWdDNVZ1eWhoTXoyVkNQTDRCcEs2?=
 =?utf-8?B?SU1mYXBBOGZ6eUZzaEJselZjaVZNY2k3RzRJUHhRN25HVEVLUEdGdC84aWY1?=
 =?utf-8?B?bXk3L2wzTDF1VXBpUHlqc1djeWxqZi9HaXJCNk14ZUR4TUZUMC9zY1dGWTlN?=
 =?utf-8?Q?/n7ToVTEF2o11ctJr5LOy08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4177D60D311CE54087C5150464313D6E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1096a145-1e4c-4807-0fcc-08dca7aa989e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 04:23:52.6129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cq8NizsWsbXT9rkLwaWJNWw8u30kTjccr9qNShChxDu3gvM0x5/zqgQeldtvaVuvp+rzqqsCyoV2Wo3MiBf44lywPNnR4w+obK0NY+wqOr170k4CklXuHvwK0b2DFufD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10161
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

DQoNCk9uIDE5LzA3LzIwMjQgMDQ6NTMsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE2LzE3XSBpbnRlbF9pb21t
dTogTW9kaWZ5IHgtc2NhbGFibGUtbW9kZSB0byBiZQ0KPj4gc3RyaW5nIG9wdGlvbg0KPj4NCj4+
DQo+Pg0KPj4gT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4g
Q2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNr
IGxpbmtzLCB1bmxlc3MgdGhpcw0KPj4gZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBh
bmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pg0KPj4+IEZyb206IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4+DQo+Pj4gSW50ZWwgVlQtZCAzLjAgaW50cm9kdWNlcyBz
Y2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YgY2FwYWJpbGl0aWVzDQo+Pj4gcmVs
YXRlZCB0byBzY2FsYWJsZSBtb2RlIHRyYW5zbGF0aW9uLCB0aHVzIHRoZXJlIGFyZSBtdWx0aXBs
ZSBjb21iaW5hdGlvbnMuDQo+Pj4gV2hpbGUgdGhpcyB2SU9NTVUgaW1wbGVtZW50YXRpb24gd2Fu
dHMgdG8gc2ltcGxpZnkgaXQgZm9yIHVzZXIgYnkNCj4+IHByb3ZpZGluZw0KPj4+IHR5cGljYWwg
Y29tYmluYXRpb25zLiBVc2VyIGNvdWxkIGNvbmZpZyBpdCBieSAieC1zY2FsYWJsZS1tb2RlIiBv
cHRpb24uIFRoZQ0KPj4+IHVzYWdlIGlzIGFzIGJlbG93Og0KPj4+DQo+Pj4gIi1kZXZpY2UgaW50
ZWwtaW9tbXUseC1zY2FsYWJsZS1tb2RlPVsibGVnYWN5InwibW9kZXJuInwib2ZmIl0iDQo+Pj4N
Cj4+PiAgICAtICJsZWdhY3kiOiBnaXZlcyBzdXBwb3J0IGZvciBzdGFnZS0yIHBhZ2UgdGFibGUN
Cj4+PiAgICAtICJtb2Rlcm4iOiBnaXZlcyBzdXBwb3J0IGZvciBzdGFnZS0xIHBhZ2UgdGFibGUN
Cj4+PiAgICAtICJvZmYiOiBubyBzY2FsYWJsZSBtb2RlIHN1cHBvcnQNCj4+PiAgICAtICBpZiBu
b3QgY29uZmlndXJlZCwgbWVhbnMgbm8gc2NhbGFibGUgbW9kZSBzdXBwb3J0LCBpZiBub3QgcHJv
cGVyDQo+Pj4gICAgICAgY29uZmlndXJlZCwgd2lsbCB0aHJvdyBlcnJvcg0KPj4gcy9wcm9wZXIv
cHJvcGVybHkNCj4+IE1heWJlIHdlIGNvdWxkIHNwbGl0IGFuZCByZXBocmFzZSB0aGUgbGFzdCBi
dWxsZXQgcG9pbnQgdG8gbWFrZSBpdCBjbGVhcg0KPj4gdGhhdCAib2ZmIiBpcyBlcXVpdmFsZW50
IHRvIG5vdCB1c2luZyB0aGUgb3B0aW9uIGF0IGFsbA0KPiBZb3UgbWVhbiBzcGxpdCBsYXN0IGJ1
bGxldCBhcyBhIHNlcGFyYXRlIHBhcmFncmFwaD8NCj4gVGhlbiB3aGF0IGFib3V0IGJlbG93Og0K
Pg0KPiAgICAtICJsZWdhY3kiOiBnaXZlcyBzdXBwb3J0IGZvciBzdGFnZS0yIHBhZ2UgdGFibGUN
Cj4gICAgLSAibW9kZXJuIjogZ2l2ZXMgc3VwcG9ydCBmb3Igc3RhZ2UtMSBwYWdlIHRhYmxlDQo+
ICAgIC0gIm9mZiI6IG5vIHNjYWxhYmxlIG1vZGUgc3VwcG9ydA0KPiAgICAtICBhbnkgb3RoZXIg
c3RyaW5nLCB3aWxsIHRocm93IGVycm9yDQo+DQo+IElmIHgtc2NhbGFibGUtbW9kZSBpcyBub3Qg
Y29uZmlndXJlZCwgaXQgaXMgZXF1aXZhbGVudCB0byB4LXNjYWxhYmxlLW1vZGU9b2ZmLg0KWWVz
LCBsZ3RtDQo+DQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBZ
aSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlp
Lnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGluY2x1ZGUvaHcv
aTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAg
ICAgICAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4gICAgMiBmaWxlcyBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+IGIvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCj4+PiBpbmRleCA0ODEzNGJkYTExLi42NTA2NDE1NDRjIDEwMDY0NA0KPj4+
IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4gKysrIGIvaW5jbHVkZS9o
dy9pMzg2L2ludGVsX2lvbW11LmgNCj4+PiBAQCAtMjYzLDYgKzI2Myw3IEBAIHN0cnVjdCBJbnRl
bElPTU1VU3RhdGUgew0KPj4+DQo+Pj4gICAgICAgIGJvb2wgY2FjaGluZ19tb2RlOyAgICAgICAg
ICAgICAgLyogUk8gLSBpcyBjYXAgQ00gZW5hYmxlZD8gKi8NCj4+PiAgICAgICAgYm9vbCBzY2Fs
YWJsZV9tb2RlOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNjYWxhYmxlIE1vZGUgc3VwcG9ydGVk
PyAqLw0KPj4+ICsgICAgY2hhciAqc2NhbGFibGVfbW9kZV9zdHI7ICAgICAgICAvKiBSTyAtIGFk
bWluJ3MgU2NhbGFibGUgTW9kZSBjb25maWcgKi8NCj4+PiAgICAgICAgYm9vbCBzY2FsYWJsZV9t
b2Rlcm47ICAgICAgICAgICAvKiBSTyAtIGlzIG1vZGVybiBTTSBzdXBwb3J0ZWQ/ICovDQo+Pj4g
ICAgICAgIGJvb2wgc25vb3BfY29udHJvbDsgICAgICAgICAgICAgLyogUk8gLSBpcyBTTlAgZmls
ZWQgc3VwcG9ydGVkPyAqLw0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+IGluZGV4IDI4MDRjMzYyOGEuLjE0ZDA1
ZmNlMWQgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4gQEAgLTM3NzAsNyArMzc3MCw3IEBAIHN0YXRpYyBQ
cm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0gew0KPj4+ICAgICAgICBERUZJTkVfUFJPUF9VSU5U
OCgiYXctYml0cyIsIEludGVsSU9NTVVTdGF0ZSwgYXdfYml0cywNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgVlREX0hPU1RfQVdfQVVUTyksDQo+Pj4gICAgICAgIERFRklORV9QUk9QX0JP
T0woImNhY2hpbmctbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLA0KPj4gRkFM
U0UpLA0KPj4+IC0gICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJ
T01NVVN0YXRlLA0KPj4gc2NhbGFibGVfbW9kZSwgRkFMU0UpLA0KPj4+ICsgICAgREVGSU5FX1BS
T1BfU1RSSU5HKCJ4LXNjYWxhYmxlLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsDQo+PiBzY2FsYWJs
ZV9tb2RlX3N0ciksDQo+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wi
LCBJbnRlbElPTU1VU3RhdGUsDQo+PiBzbm9vcF9jb250cm9sLCBmYWxzZSksDQo+Pj4gICAgICAg
IERFRklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQs
IGZhbHNlKSwNCj4+PiAgICAgICAgREVGSU5FX1BST1BfQk9PTCgiZG1hLWRyYWluIiwgSW50ZWxJ
T01NVVN0YXRlLCBkbWFfZHJhaW4sIHRydWUpLA0KPj4+IEBAIC00Njg2LDYgKzQ2ODYsMjggQEAg
c3RhdGljIGJvb2wNCj4+IHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJy
b3IgKiplcnJwKQ0KPj4+ICAgICAgICAgICAgfQ0KPj4+ICAgICAgICB9DQo+Pj4NCj4+PiArICAg
IGlmIChzLT5zY2FsYWJsZV9tb2RlX3N0ciAmJg0KPj4+ICsgICAgICAgIChzdHJjbXAocy0+c2Nh
bGFibGVfbW9kZV9zdHIsICJvZmYiKSAmJg0KPj4+ICsgICAgICAgICBzdHJjbXAocy0+c2NhbGFi
bGVfbW9kZV9zdHIsICJtb2Rlcm4iKSAmJg0KPj4+ICsgICAgICAgICBzdHJjbXAocy0+c2NhbGFi
bGVfbW9kZV9zdHIsICJsZWdhY3kiKSkpIHsNCj4+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJJbnZhbGlkIHgtc2NhbGFibGUtbW9kZSBjb25maWcsIg0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIlBsZWFzZSB1c2UgXCJtb2Rlcm5cIiwgXCJsZWdhY3lcIiBvciBcIm9mZlwiIik7
DQo+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAg
IGlmIChzLT5zY2FsYWJsZV9tb2RlX3N0ciAmJg0KPj4+ICsgICAgICAgICFzdHJjbXAocy0+c2Nh
bGFibGVfbW9kZV9zdHIsICJsZWdhY3kiKSkgew0KPj4+ICsgICAgICAgIHMtPnNjYWxhYmxlX21v
ZGUgPSB0cnVlOw0KPj4+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGVybiA9IGZhbHNlOw0KPj4+
ICsgICAgfSBlbHNlIGlmIChzLT5zY2FsYWJsZV9tb2RlX3N0ciAmJg0KPj4+ICsgICAgICAgICFz
dHJjbXAocy0+c2NhbGFibGVfbW9kZV9zdHIsICJtb2Rlcm4iKSkgew0KPj4+ICsgICAgICAgIHMt
PnNjYWxhYmxlX21vZGUgPSB0cnVlOw0KPj4+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGVybiA9
IHRydWU7DQo+Pj4gKyAgICB9IGVsc2Ugew0KPj4+ICsgICAgICAgIHMtPnNjYWxhYmxlX21vZGUg
PSBmYWxzZTsNCj4+PiArICAgICAgICBzLT5zY2FsYWJsZV9tb2Rlcm4gPSBmYWxzZTsNCj4+PiAr
ICAgIH0NCj4+PiArDQo+Pj4gICAgICAgIGlmIChzLT5hd19iaXRzID09IFZURF9IT1NUX0FXX0FV
VE8pIHsNCj4+PiAgICAgICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiAgICAg
ICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQo+Pj4gLS0NCj4+PiAy
LjM0LjENCj4+Pg0KPj4gTEdUTQ0K

