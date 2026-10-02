Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04032CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 04:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCUZn-0003Yc-5q; Fri, 02 Oct 2026 00:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=72899bf67=Alistair.Francis@wdc.com>)
 id 1xCUZe-0003YJ-Rw; Fri, 02 Oct 2026 00:08:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=72899bf67=Alistair.Francis@wdc.com>)
 id 1xCUZa-00011Y-Qi; Fri, 02 Oct 2026 00:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790914118; x=1822450118;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=xoexmPe+bYIn/0iS5uHAz2mVO3groIyyk6J/oWBhI/A=;
 b=ndc/TUxOMHOsVNYKKFDpL8NxXiLNKNbqqQU7WbxfJbgK5gnRmCbkQX77
 aZF1Wax3davyXQ81OkAV8qZrCfMo5LlDd3jBUBinJkatYvFe7DBG/PBAW
 EXkX5IxWhvJkD+UUA/pdH0FyO5zQ14I8NWNNkFYzE2SLlO1tcNsb2DaEB
 PQu2QoiMUFOtPVXTs8A3rkDZ7Gn8yRnVtD26usBdKg8SMQP+isz0vLxnG
 AMHv+jX0zeHhrdRg50dF7xD7tO/HBA/bPLf9XA/89zLn2JJ8vgapFahxs
 eEDVsWSxUaUe7pDWmRzzf90/P2zRfu+JEbeBsEfSykww00FdKWaazJJW+ A==;
X-CSE-ConnectionGUID: Vd3G4CCdSfCtvjSVBVRvdA==
X-CSE-MsgGUID: CaxIefzDS0yXduiwKVZwTA==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; d="scan'208";a="156954258"
Received: from mail-northcentralusazon11012039.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.39])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Oct 2026 12:08:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMQefRuLdy/xUf5bdMK16alHJDo3OBG7xoW0UBR85OGANtroqaEabpRDUnYV1Eyq4NAxmwD9c4M/94kwK5HBfDij2upQNRp+nR8owgd1zkGH6Tj5BZOvAfLWpV9UjhB/Q7va4pB7N5d/T1Iny3901Ws+nqzs4dNkLeUtpbWs6cyZo7XLEo/DV+cQVlpsVSiWtv49qnfC8fhrED2rp2wIutc9j1Oha38/gkg+D7YIH93J3BWVZaJoCsTc+r8i5pKP6b94pD6tkiIsD3h9wYYm+Ft2QuqhVCjFmBiZGqK6xRxH6tyAeOOx+1kQId3vvs1ebxy1TlVyMyG9NJsuTB5uYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoexmPe+bYIn/0iS5uHAz2mVO3groIyyk6J/oWBhI/A=;
 b=e0F740zz4lxNBjbRWU3ou9D46nMeAEd/wo3zaGfikULbpc1pnE8mmq9fSh2FadTV1dfRWqcTCLGC7Vxxhf+m3qgir9YY2/4byEYfrvsnjvUkHJkILkPlMstA9Jr9vT27YZ44O+y1Igb35g3Pq33y7Hxo2p6JVIJtpwSaSulq+glCaxK6SpOksYs8EBzXpLsTK2P1JdUSulrofZ/GNiQtx3Y2hsvd6LBPEWZ5+FNQ3wnFA8DeF+wgKWkYI5WY0COvKQcl1rBq6Hnah+c9rrlIZwRM8eAyEkyshwPYNy72UhamLQvJKGYVuwULDnbA75fHiJfo7jmyO85mg+UtPWQSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoexmPe+bYIn/0iS5uHAz2mVO3groIyyk6J/oWBhI/A=;
 b=aAHk/OJNHh/7PqoIc+tUkgEoEH0Zxzd2Bx6gkSRzfOxNAWe3lWxf1VlvU0BtqzE3ylTR0m+9aY1jfDsP+qK458CTgMHh1zOTZn8NLIqVR8dN1MWuIhNNSVieZjjz/atnx/An6Z9FNK6P65sY2/YvfxEC9BFpOXNNEl61hhMiCJo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY1PR04MB8749.namprd04.prod.outlook.com (2603:10b6:a03:532::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 04:08:28 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 04:08:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/4] hw/riscv/atlantis: Use dw8250 UART model
Thread-Topic: [PATCH v3 1/4] hw/riscv/atlantis: Use dw8250 UART model
Thread-Index: AQHdUf1PmwkcE3h7sEq7VefAKVL8Ubbpo1WA
Date: Fri, 2 Oct 2026 04:08:27 +0000
Message-ID: <56ca263d538041c17594abca51581bf6dce7f6a7.camel@wdc.com>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
 <20261001233324.2636629-2-portias@oss.tenstorrent.com>
In-Reply-To: <20261001233324.2636629-2-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY1PR04MB8749:EE_
x-ms-office365-filtering-correlation-id: 81d86dd9-8c2d-45df-ea3e-08df203acf8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|19092799006|376014|23010399003|366016|1800799024|10070799003|22082099003|18002099003|38070700021|3023799007|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: KZPPDePdW1WKb6yBeyO+zGPxewOt1uGsAqH5lQmXuZb6u3kial77F4PGhuBYw+Q7edsH4D1S7QUJ5nT2tUdHZrWvLNhWICIBiPfH0lZVMFFBQQo6g83R3takI8ZL5P3cQpc4I8crDq3a2qecg/ovJNkwId9vov92QggCe9ub5ULu1PW28KnRfcoZu+rmQV8Oe0PuHP2iZDmirgpAuUeR9K6ixZLjKiflmV8aqpgokyjOOhk+v3HKM7dGmUOPBhEbs3wsEHePh0c85/yBOAu5eIHs3toi5ts4Ak0mCJsOfNFI5fPiWueLtaxuVo8BV3MJqEXg2vR1U5xFxkvserXJSrrjzmRx91ijfQZZI+XE4vqcJC373uIzdC9/gFZvCCSTXXdJxlRKeBagJT7VWS8fLlLgkP0N2kbgbLAtZCMbCaaTVp6RrvX8YAFnp+THaHo4aWh2FI5Y2lqwlCdkiPoAVYYFL4NF6Jzw9cHVUzKa6J0zf5dZxICmIzgQ9M70kFpvisSdhXnPBr614xot16WXnoh6X6W1Xu0DHc8zyvmZ6rnamAabFlTusXxS7d3P9WFdlt51q4VNBSTM4VqYzpewicfSHJVK3ihRhoWQyPO0fkwSDhOeJjRGKE+qNatpnaINvqUiGhecl/cEdqJeib6qI7EbODISBQEp5OcXHI2PFeuXsN+LkXPYY7CG8Xnqm6JHb9q/iI4/uKymds/4d7XyfLlPoMXJNQY8QfImkUlOIXI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(19092799006)(376014)(23010399003)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(38070700021)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFp6Y2QzVFZvYnY0L0w4UW8yMDZteHNKdlZZeWZ3eTdKOU9zM3ZSRlgweVND?=
 =?utf-8?B?Mmk2Uml5dTgzcENDQW9RWTlRYXRFN1JGaEx5bGRJanVLcllIbEtjSXBRenRW?=
 =?utf-8?B?c0JSUE1teUJPLzgzOGRKSXlZL3d3ZlRiQlJCMkx3L2NBZFpsUk1KbnM4T3dF?=
 =?utf-8?B?WDFUUlZhRjRHd2p6cjd0b2FoVlNEUDQ1a2o1dE5ZQXFtdHlRSWQzanhTN3VM?=
 =?utf-8?B?ZzVYRkhTaSswd2QzeTFrNDhrbGdpVEM2N3RISWN6YktMNnFDWnN0RzlEMGk2?=
 =?utf-8?B?bEliM09Dei9JMFNHdnkrdlZRTnRSV29BY3BVMFlJTkU5VEQ4VlZoa0ZXR2tG?=
 =?utf-8?B?WlZWVnZIc0h3U3V5d1RldHA1dW5OUHZhU2JNRUduNUY4TjZIQkJ5QzlBenZo?=
 =?utf-8?B?Vmh3TlhvVGE5VHFVVElsMnJkSlVtVlNQUUNSWnFGUm1uV0lQTzNLM1hwbHJU?=
 =?utf-8?B?WXVBTjhWajdHUE5jV1lqcVJ5NFhJcFQ5ZmhMam9GVFJnd29NdmszMlZWVlNl?=
 =?utf-8?B?c3BFUVgzYUp1RkZYVHFKSlBRTmk3RDZoazRjelpSajNGc1dtY01rUW9ldXhl?=
 =?utf-8?B?b05GSlMrQ0tacElCOEx5VnRVTjJad2ZCYlJiUFF1dGlFZld3aG1YLzkvcE9n?=
 =?utf-8?B?ZjZ2UkhYSWdiK0JyTTY3eDVqV3ZTaG9wbjJMSDExUUdnYm5TN1Boc3BwRC9k?=
 =?utf-8?B?NUxlS09yQUh1SUtQVHB6YmxSZ1Nvamo0RFBObkd1WDYxMXZHTVA1blloR1dl?=
 =?utf-8?B?ZlBYMjRIaXV0cUlFNHZ3aERTRkVWVjdpczJMRktWV081aGozTHJTMzJkK3Ri?=
 =?utf-8?B?UHVOYW9YeTRHT0t4NEV3WG8wOHEvOTd0SGY5SjltSUhackIwd3p2U3E4OFh4?=
 =?utf-8?B?cGdac3ZidE9pbWVPNkVWMjlwTU50UEpPdDlGOVIxdVpRdmJndWZ2T2MwcEF0?=
 =?utf-8?B?MXJtY0pVa0t1Z0NMUW9zWEQyUTV1L0I3bnErVE9SUHRSWEluNzJFRTVyaXJS?=
 =?utf-8?B?azV3UG1sZjlrSkdiSEI4RlU0azRtenBZV2tlcWtZek5RTG5wWE9EY1MvYkU4?=
 =?utf-8?B?U1RoOWIvekljU1pTVW54U0I5QmRwNmhsaWVFOW8xOUU4eG5YNnI3RXMwQ2Fh?=
 =?utf-8?B?emdZR1RPc1lVNXBxVDlrVHZzWTBMak0xYS9qRVhGRG5QdkxlcGJEb2FSVzdv?=
 =?utf-8?B?N3Jra1hocFVkMkdiV1I2eGp6NXVFMWJEaFQwZHhjanBtdEM1cmlubUt0cTg2?=
 =?utf-8?B?MmRjaVREUDNuazBqYllXY25qakVrU0ZFTnJSREhRRDg3akE5REsvcmpJaEY5?=
 =?utf-8?B?YU5QMDYvK3ZPVXlSMm1hR0lhb0JlTGhXVTVRbW9TQnpCUlMrVUFtQ3NGekJB?=
 =?utf-8?B?U0pXSkIvRjAzcUtzdWM2MHlUeTAwTnNQYWxYUEIzVEFWOGpabGdYNElIODhK?=
 =?utf-8?B?VFZYd3hUNHV0MGcweFpXM285eDVZdmVrSFNIUGJhR0d3cE8xSU5YUkcrQTk3?=
 =?utf-8?B?Z3pUOXBiaXBpWW9oeDFsZTJ6aE1idEUzWDhJd0xiTFEvbzViNG9SOHRWdGFZ?=
 =?utf-8?B?ZXlCajlONHRrQnN2aXNnT2hCSlRacHA0RlEvWnNoMCtobGJQK1RhbkhVQmpC?=
 =?utf-8?B?U2x4bXM0SVcxR3R1K01lc3JpRkhEdDZaVTljbUJiWVlCd015NU1VVVROeGlU?=
 =?utf-8?B?b3RHdFlydmVoRXRXRXVDd3B0K2NqQnNSYnh1UXVtQ21WUXBpL05mQnc0RVpP?=
 =?utf-8?B?WmQ5Q1B3V2t5U3RtS25wd1NGeWFrUGhqSXUwK1NrYTFuYU1zYUt3R1cwWWxL?=
 =?utf-8?B?Q0RpUk9nbkk5SStDSmpTVVR3d09LSmJ4TCtzZzk1Rm9uZXlpYzZaU1M5U1VH?=
 =?utf-8?B?TGpkKzA2SEQ1MDdiYXFEaldERG9odTR6NGFyYUZGd2R3bmxWK2dUNkhwV3ZO?=
 =?utf-8?B?VTV6Zm1aWk1jVTEwY1pKdUNTOGNwVC9SV1c1TzNUKy9FeGVvekFtWnFYd05J?=
 =?utf-8?B?WFUwcWU4Rm9PSHpPZVF1cjVXcGdKQ0p1am4yWmlnZ2JNc2JhdVJsR1luaE9R?=
 =?utf-8?B?RHBudkdVUEVrSWNQVEhZUThGN2hwNS84T2JISGVVOGpCTWFhdmpiR0Q1NUxm?=
 =?utf-8?B?WnhpSmtzZ1ZOVWtUaFdhNVBWWHQwSndiNGI5Nnl0TU5CRXlNNmpzUC9qS2xn?=
 =?utf-8?B?TUJtbEl5U1hvL1Y0YXBIYmg1RTA2R2ZuNk1odTkybzMwVlc4d3hUd2k1eHNw?=
 =?utf-8?B?c3hjdksrVjhaUlA2aElQRi9aV3A0YW04YzJuU29Iakc4U3NxeCtJd0NnM1Q0?=
 =?utf-8?B?TGU5OEVCSDE3ekt0VDduWWdVNGlYcG10QzA0Q2FxUW9iWE40bmVsL1dxMEU5?=
 =?utf-8?Q?bGNSBF6hwjXfG65yxjg1Nk7FkccGqy0P0loKQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCF067B062FC564AB89B7744B02563DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rWCs7IENsqCXDkWC9eyXFGC6MWOefqI4uLN2mwC7qx5f8dyHGE/xQOcbK/2aBZq7Im1A6xcVDMhFlpvtDqTjrEPdquwz6UmricGchXcuRYzQICJFS5TBINRSEmt0So0kfFbtZeU1yvvgFxB4epUDjhyLl1ADkxSLIAnzIa2JLRdY4baXKICC7eop9biWyLBm5gkPcgYmRT37UR7kddiPoQnIQ8j9ewrKcUvDVfHh91v4NCJMa4Llea3JXC9aq9DR1csOzXFAcNT4OxJUeOY4TmiayIFeTH8nJduv4zg8Hok5+2YOA1T8yP1vGRWfZar5npbYHif84+h6ToofbfR0GA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n9co2woZq1y1sjcKjKoLkzvugnsBa/RxIHoOaQjgKgaCBPGwnNC2xR5QgmKuIoJAzgYDm+U1Rh5zDHHYwxL8DV0aRhdGWH+ecWuUt93wfxsmQ5tZ3zcWg4YDyq9n/VSddo26mgSKIAzzOFXIcjAwu3rLwG1TnPnrSFwwaqLoj/44cgFHWXyjwX25CBu67utEmwEdgqSS4ke9sANxYhvThO9zZOpNUALsudZ+nq8anRxcXrKLuZ7zY6vgVzM1R0OVfmhe8upsJPBnCDQJUCS7PuNsQBev8rKhslEZekchIvflFeelCfQuviJ3o6PKDo4vfsugy5+gv9koFyripuStHv3GlUbG7IH/cUTrPngSGdXaOMxYAg2z31hBcFbI/4y23W4VfIdIOZIof0zl5Sz9zCYhbQa4HKg4fYfbNIdvxxk0kLopK4mSgASNVsL88wUXV0BMW4rzg7rvZbOUdu71nOWmWAAIec5GSwJK83LxwNLa+kd+SJikyrfCcDYJrwyO+gxMIIjIEMrLEGKbm5PhjBkI8XagbhthI6SEB+GHdZQD7myT8YeRHF2Io4up9Xpg5gHBqdJK/1miPsxqVBWsdLzwVeWJT11/7nuFc0es9eQ+tFkCXe507psOrTQq0tGv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d86dd9-8c2d-45df-ea3e-08df203acf8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 04:08:27.2000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uN5epMmjE8EOVAlMnt5pdDlp1k8q4CFKdJhCe/PZx28bosqs0PCLQ2ATN9pfOtBogoKrvoFZSgHheT/yki8ruvXpShJQCVM0nAUjiZeqJKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8749
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=72899bf67=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDA5OjMzICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
Cj4gUmVwbGFjZSB0aGUgbnMxNjU1MCBVQVJUIHdpdGggYSBEZXNpZ253YXJlIFVBUlQgbm93IHRo
YXQgYSBtb2RlbCBpcwo+IGF2YWlsYWJsZS4gVGhlIGhhY2sgd2hpY2ggc2V0cyB0aGUgcmVzdCBv
ZiB0aGUgVUFSVCByZWdpc3RlciBzcGFjZSBhcwo+IHVuaW1wbGVtZW50ZWQgY2FuIGJlIHJlbW92
ZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogUG9ydGlhIFN0ZXBoZW5zIDxwb3J0aWFzQG9zcy50ZW5z
dG9ycmVudC5jb20+Cj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRh
bmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9y
aXNjdi9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+IMKgaHcv
cmlzY3YvdHRfYXRsYW50aXMuY8KgwqDCoMKgwqDCoMKgwqAgfCA0NSArKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLQo+IC0tCj4gwqBpbmNsdWRlL2h3L3Jpc2N2L3R0X2F0bGFudGlzLmgg
fMKgIDQgKy0tCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDM0IGRlbGV0
aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9LY29uZmlnIGIvaHcvcmlzY3YvS2Nv
bmZpZwo+IGluZGV4IGQwNmFjMjY2NDguLjVkMmFiZGJiNjcgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlz
Y3YvS2NvbmZpZwo+ICsrKyBiL2h3L3Jpc2N2L0tjb25maWcKPiBAQCAtMTI3LDcgKzEyNyw3IEBA
IGNvbmZpZyBURU5TVE9SUkVOVAo+IMKgwqDCoMKgIHNlbGVjdCBSSVNDVl9BQ0xJTlQKPiDCoMKg
wqDCoCBzZWxlY3QgUklTQ1ZfQVBMSUMKPiDCoMKgwqDCoCBzZWxlY3QgUklTQ1ZfSU1TSUMKPiAt
wqDCoMKgIHNlbGVjdCBTRVJJQUxfTU0KPiArwqDCoMKgIHNlbGVjdCBEVzgyNTAKPiDCoMKgwqDC
oCBzZWxlY3QgREVWSUNFX1RSRUUKPiDCoMKgwqDCoCBzZWxlY3QgREVTSUdOV0FSRV9JMkMKPiDC
oMKgwqDCoCBzZWxlY3QgRFMxMzM4Cj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3R0X2F0bGFudGlz
LmMgYi9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gaW5kZXggOGEyMTlhZmVmNy4uNzA4MTVlMTJl
ZiAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gKysrIGIvaHcvcmlzY3Yv
dHRfYXRsYW50aXMuYwo+IEBAIC0yNCw5ICsyNCw4IEBACj4gwqAjaW5jbHVkZSAiaHcvcmlzY3Yv
ZmR0LWNvbW1vbi5oIgo+IMKgI2luY2x1ZGUgImh3L3Jpc2N2L3Jpc2N2X2hhcnQuaCIKPiDCoAo+
IC0jaW5jbHVkZSAiaHcvY2hhci9zZXJpYWwtbW0uaCIKPiArI2luY2x1ZGUgImh3L2NoYXIvZHc4
MjUwLmgiCj4gwqAjaW5jbHVkZSAiaHcvaW50Yy9yaXNjdl9hY2xpbnQuaCIKPiAtI2luY2x1ZGUg
Imh3L21pc2MvdW5pbXAuaCIKPiDCoAo+IMKgI2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCIKPiDC
oCNpbmNsdWRlICJzeXN0ZW0vZGV2aWNlX3RyZWUuaCIKPiBAQCAtMjYyLDExICsyNjEsMTUgQEAg
c3RhdGljIHZvaWQgY3JlYXRlX2ZkdF9jcHUodm9pZCAqZmR0LAo+IFRUQXRsYW50aXNTb0NTdGF0
ZSAqcywKPiDCoHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfdWFydCh2b2lkICpmZHQsIGNvbnN0IE1l
bU1hcEVudHJ5ICptZW0sIGludAo+IGlycSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgaXJxY2hpcF9waGFuZGxlKQo+IMKgewo+
ICvCoMKgwqAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBjb21wYXRbMl0gPSB7Cj4gK8KgwqDC
oMKgwqDCoMKgICJzbnBzLGR3LWFwYi11YXJ0IiwgIm5zMTY1NTBhIgo+ICvCoMKgwqAgfTsKPiDC
oMKgwqDCoCBnX2F1dG9mcmVlIGNoYXIgKm5hbWUgPQo+IGdfc3RyZHVwX3ByaW50ZigiL3NvYy9z
ZXJpYWxAJSJIV0FERFJfUFJJWCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1l
bS0+YmFzZSk7Cj4gwqAKPiDCoMKgwqDCoCBxZW11X2ZkdF9hZGRfc3Vibm9kZShmZHQsIG5hbWUp
Owo+IC3CoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCBuYW1lLCAiY29tcGF0aWJs
ZSIsICJuczE2NTUwYSIpOwo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmdfYXJyYXko
ZmR0LCBuYW1lLCAiY29tcGF0aWJsZSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGNoYXIgKiopJmNvbXBhdCwKPiBB
UlJBWV9TSVpFKGNvbXBhdCkpOwo+IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc2l6ZWRfY2Vs
bHMoZmR0LCBuYW1lLCAicmVnIiwgMiwgbWVtLT5iYXNlLCAyLAo+IG1lbS0+c2l6ZSk7Cj4gwqDC
oMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgbmFtZSwgInJlZy1zaGlmdCIsIDIpOwo+
IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5hbWUsICJyZWctaW8td2lkdGgi
LCA0KTsKPiBAQCAtNDA5LDE3ICs0MTIsNiBAQCBzdGF0aWMgdm9pZCBsb2FkX2ZkdChUVEF0bGFu
dGlzU3RhdGUgKmFtcykKPiDCoMKgwqDCoCBjcmVhdGVfZmR0X21lbW9yeShtcy0+ZmR0LCAmYW1z
LT5zb2MpOwo+IMKgfQo+IMKgCj4gLXN0YXRpYyB2b2lkIG1taW9fbWFwX3VuaW1wbGVtZW50ZWQo
TWVtb3J5UmVnaW9uICptZW1vcnksCj4gU3lzQnVzRGV2aWNlICpkZXYsCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNvbnN0IGNoYXIgKm5hbWUsIGh3YWRkciBhZGRyLAo+IHVpbnQ2NF90IHNpemUpCj4gLXsKPiAt
wqDCoMKgIHFkZXZfcHJvcF9zZXRfc3RyaW5nKERFVklDRShkZXYpLCAibmFtZSIsIG5hbWUpOwo+
IC3CoMKgwqAgcWRldl9wcm9wX3NldF91aW50NjQoREVWSUNFKGRldiksICJzaXplIiwgc2l6ZSk7
Cj4gLcKgwqDCoCBzeXNidXNfcmVhbGl6ZShkZXYsICZlcnJvcl9hYm9ydCk7Cj4gLQo+IC3CoMKg
wqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJsYXAobWVtb3J5LCBhZGRyLAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihkZXYsCj4gMCksIC0x
MDAwKTsKPiAtfQo+IC0KPiDCoHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX21hY2hpbmVfZG9uZShO
b3RpZmllciAqbiwgdm9pZCAqZGF0YSkKPiDCoHsKPiDCoMKgwqDCoCBUVEF0bGFudGlzU3RhdGUg
KmFtcyA9IGNvbnRhaW5lcl9vZihuLCBUVEF0bGFudGlzU3RhdGUsCj4gbWFjaGluZV9kb25lKTsK
PiBAQCAtNDg4LDggKzQ4MCw3IEBAIHN0YXRpYyB2b2lkIHR0X2F0bGFudGlzX3NvY19pbml0KE9i
amVjdCAqb2JqKQo+IMKgCj4gwqDCoMKgwqAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAi
Y3B1cyIsICZzLT5jcHVzLAo+IFRZUEVfUklTQ1ZfSEFSVF9BUlJBWSk7Cj4gwqAKPiAtwqDCoMKg
IG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInVhcnQxIiwgJnMtPnVhcnQxLAo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFlQRV9V
TklNUExFTUVOVEVEX0RFVklDRSk7Cj4gK8KgwqDCoCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChv
YmosICJ1YXJ0MSIsICZzLT51YXJ0MSwgVFlQRV9EVzgyNTApOwo+IMKgCj4gwqDCoMKgwqAgZm9y
IChpbnQgaSA9IDA7IGkgPCBUVF9BVExfTlVNX0kyQzsgaSsrKSB7Cj4gwqDCoMKgwqDCoMKgwqDC
oCBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJpMmNbKl0iLCAmcy0+aTJjW2ldLAo+IEBA
IC01ODQsMjEgKzU3NSwxMyBAQCBzdGF0aWMgdm9pZCB0dF9hdGxhbnRpc19zb2NfcmVhbGl6ZShE
ZXZpY2VTdGF0ZQo+ICpkZXYsIEVycm9yICoqZXJycCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZzLT5ib290cm9tKTsK
PiDCoAo+IMKgwqDCoMKgIC8qIFVBUlQxLCB0aGUgc29jIGNvbnNvbGUgKFVBUlQwIGlzIGZvciB0
aGUgYm9vdAo+IG1pY3JvY29udHJvbGxlcikgKi8KPiAtwqDCoMKgIHNlcmlhbF9tbV9pbml0KHMt
Pm1lbW9yeSwgcy0+bWVtbWFwW1RUX0FUTF9VQVJUMV0uYmFzZSwgMiwKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFkZXZfZ2V0X2dwaW9faW4ocy0+aXJxY2hpcCwgVFRf
QVRMX1VBUlQxX0lSUSksCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAx
MTUyMDAsIHNlcmlhbF9oZCgwKSwgREVWSUNFX0xJVFRMRV9FTkRJQU4pOwo+IC3CoMKgwqAgLyoK
PiAtwqDCoMKgwqAgKiBBdGxhbnRpcyBjb250YWlucyBhIERlc2lnbldhcmUgdWFydCB3aGlsZSB0
aGUgUUVNVSBtYWNoaW5lCj4gLcKgwqDCoMKgICogdXNlcyB0aGUgc2VyaWFsX21tIG1vZGVsIHdp
dGggdGhlIGJhc2UgbnMxNjU1MCByZWdpc3RlciBzZXQuCj4gLcKgwqDCoMKgICogTGludXgncyBk
dyBkcml2ZXIgd3JpdGVzIG91dHNpZGUgb2Ygc2VyaWFsX21tJ3MgMHgyMCBzaXplZAo+IC3CoMKg
wqDCoCAqIG1hcHBpbmcgYW5kIGZhdWx0cy4KPiAtwqDCoMKgwqAgKgo+IC3CoMKgwqDCoCAqIENy
ZWF0ZSBhbiB1bmltcGxlbWVudGVkIGRldmljZSByZWdpb24gc28gd3JpdGVzIGRvbid0IGZhdWx0
Cj4gLcKgwqDCoMKgICogYW5kIHJlYWRzIHJldHVybiB6ZXJvLCB3aGljaCBrZWVwcyBMaW51eCBo
YXBweS4KPiAtwqDCoMKgwqAgKi8KPiAtwqDCoMKgIG1taW9fbWFwX3VuaW1wbGVtZW50ZWQocy0+
bWVtb3J5LCBTWVNfQlVTX0RFVklDRSgmcy0+dWFydDEpLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ0dC1hdGxhbnRpcy51YXJ0MSIsIHMt
Cj4gPm1lbW1hcFtUVF9BVExfVUFSVDFdLmJhc2UsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW1RUX0FUTF9VQVJUMV0uc2l6
ZSk7Cj4gK8KgwqDCoCBxZGV2X3Byb3Bfc2V0X2NocihERVZJQ0UoJnMtPnVhcnQxKSwgImNoYXJk
ZXYiLCBzZXJpYWxfaGQoMCkpOwo+ICvCoMKgwqAgc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJ
Q0UoJnMtPnVhcnQxKSwgJmVycm9yX2ZhdGFsKTsKPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRk
X3N1YnJlZ2lvbihzLT5tZW1vcnksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPm1lbW1hcFtUVF9BVExfVUFSVDFdLmJh
c2UsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgCj4gc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihTWVNfQlVTX0RFVklDRSgmcy0+
dWFydDEpLCAwKSk7Cj4gK8KgwqDCoCBzeXNidXNfY29ubmVjdF9pcnEoU1lTX0JVU19ERVZJQ0Uo
JnMtPnVhcnQxKSwgMCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcWRldl9nZXRfZ3Bpb19pbihzLT5pcnFjaGlwLAo+IFRUX0FUTF9VQVJUMV9JUlEpKTsK
PiDCoAo+IMKgwqDCoMKgIC8qIEkyQyAqLwo+IMKgwqDCoMKgIGZvciAoaW50IGkgPSAwOyBpIDwg
VFRfQVRMX05VTV9JMkM7IGkrKykgewo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3R0
X2F0bGFudGlzLmgKPiBiL2luY2x1ZGUvaHcvcmlzY3YvdHRfYXRsYW50aXMuaAo+IGluZGV4IDM5
MjMzMDhiN2MuLjAwMDk4OGMwMzcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9ody9yaXNjdi90dF9h
dGxhbnRpcy5oCj4gKysrIGIvaW5jbHVkZS9ody9yaXNjdi90dF9hdGxhbnRpcy5oCj4gQEAgLTEz
LDcgKzEzLDcgQEAKPiDCoCNpbmNsdWRlICJody9jb3JlL3N5c2J1cy5oIgo+IMKgI2luY2x1ZGUg
Imh3L2kyYy9kZXNpZ253YXJlX2kyYy5oIgo+IMKgI2luY2x1ZGUgImh3L2ludGMvcmlzY3ZfaW1z
aWMuaCIKPiAtI2luY2x1ZGUgImh3L21pc2MvdW5pbXAuaCIKPiArI2luY2x1ZGUgImh3L2NoYXIv
ZHc4MjUwLmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3YvcmlzY3ZfaGFydC5oIgo+IMKgCj4gwqAj
ZGVmaW5lIFRZUEVfVFRfQVRMQU5USVNfTUFDSElORSBNQUNISU5FX1RZUEVfTkFNRSgidHQtYXRs
YW50aXMiKQo+IEBAIC0zOSw3ICszOSw3IEBAIHN0cnVjdCBUVEF0bGFudGlzU29DU3RhdGUgewo+
IMKgwqDCoMKgIFJJU0NWSGFydEFycmF5U3RhdGUgY3B1czsKPiDCoMKgwqDCoCBEZXZpY2VTdGF0
ZSAqaXJxY2hpcDsKPiDCoMKgwqDCoCBEZXNpZ25XYXJlSTJDU3RhdGUgaTJjW1RUX0FUTF9OVU1f
STJDXTsKPiAtwqDCoMKgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSB1YXJ0MTsKPiArwqDCoMKg
IERXODI1MFN0YXRlIHVhcnQxOwo+IMKgwqDCoMKgIE1lbW9yeVJlZ2lvbiBib290cm9tOwo+IMKg
Cj4gwqDCoMKgwqAgdWludDMyX3QgbnVtX2hhcnRzOwo=

