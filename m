Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCE4CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8gT-0002WK-B2; Thu, 01 Oct 2026 00:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8gJ-0002UV-Mp; Thu, 01 Oct 2026 00:46:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC8gH-0006EY-6l; Thu, 01 Oct 2026 00:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790829965; x=1822365965;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Yoah/ayX7/FPe/5O4AvnUJR+uAvCtWU444jJ35DnVv8=;
 b=h2Tx2wSe2WySgcBh1rXbt03CwOwp4yjJi81LeyacCOJbf0bgHieAB1lP
 SiSO4fhMVA4glsIskfTiuPRg1CtUlOyMdCoUC7F7I4N2CpJL0ozTzy6qU
 Ek2Pl4qj/t5o6GPIP8xJyFq3fEepB+KlrE3mAm+adCVntHKgWwXwaOy8e
 ADoil5evc6rVy8UdZusgyDA3UAwrEaGwDmg9+2DPCS3x96vY5BaYFmhf4
 Qg0dDG6ad+SzKfJwov+JxIWhuyJJfvnMdpHCTqJxW4cWLAXNa4y4DrYH8
 I1A7EWEUe57wtO8b9vPYnWVLQtmBJdJrbWABd4hv4x4Im69it6W7VMBWu g==;
X-CSE-ConnectionGUID: OvIpsI8XSB+/wZBQE8JYOQ==
X-CSE-MsgGUID: 8PwEJjQCSCGXt6CRoP/0sg==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="152783666"
Received: from mail-eastus2azon11011042.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 12:46:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+iPS/q/DmZ/9M1/e0BIe5zkkiAIMq4XPATDsJuJ5WaFbzSSF5PWizeacv99lcfUuFPgzW722BIwn9s+QMcQEs2Bb4xRPDTtdU6vaVhzgzzajtQ3vHxfDG9CBgxu6Qji+zZuTBC+s06IHHyFbIKM+WoX4/1hF6UTfCFP2aW+nXE4Zjgcn5nBilxARYdxIcMdt6+gTNF9AqRHr2OTgcZ0oQF1vGSZfnfuzcBKSt1m+doioKqZV9Vm1d7q0QVxoB44EIYLtXZP4Mp3TD0/tISU49NHDjQsihqMLP7pErRfBFQmRiWc0ddpRpB0YUwVcjecSktJLtlnSmmZmSiAJLQqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yoah/ayX7/FPe/5O4AvnUJR+uAvCtWU444jJ35DnVv8=;
 b=rsDXa204fh2OHVXgo5PZS7aFajIudDnOsn4TKvLoNWjhXVyheTItmlz6GM9FcSSG2gijljylC9prqHOrJsT4pljeooY+oQK8mIQ/84IQIVsi8QrGjNv586P+gOkMIeVtaTMQitnIY0iCQ8n7qnuHHSCeEeAbPAqgtpLvggUEfz4SRxRuCLQEDnWag7oVVmwIggamLpsPEeLiOYM4PiFQlUJWyRkysOyeeC7OGkg+gfGFsRCFcDFvH6+Ja5pfQ0VwMub5S3DAG2X9tKhfB7e0g5GQ39sxm2D7y++lL9kapzsMOyeW6FB4At4rdpuY/dqoLbfw2oHX3abnXYp1EkNyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoah/ayX7/FPe/5O4AvnUJR+uAvCtWU444jJ35DnVv8=;
 b=M8xAAQEc/7E7X5KvKqpfFA9MhAWGwq9ZQLx/WfmsAw32n2NNvY+CTGwLX6cP6nWqrTaFw82yUufpOls4LdLQtXp9JRSJ4rd4LktlwGCug9O+qunvbyWQeO4y+Z33co5u8QBZnN0cQ13h/X3ZKy0qRTZ+daVx0K749FFsqfX43mY=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH0PR04MB8129.namprd04.prod.outlook.com (2603:10b6:610:f5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 04:45:59 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 04:45:59 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "tangtao1634@phytium.com.cn"
 <tangtao1634@phytium.com.cn>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v10 2/7] target/riscv: add sdext Debug Mode helpers
Thread-Topic: [PATCH v10 2/7] target/riscv: add sdext Debug Mode helpers
Thread-Index: AQHdT4PdkwBjPJLhSUKbuaNsav4IqrboIHgA
Date: Thu, 1 Oct 2026 04:45:59 +0000
Message-ID: <e03baa39b49cf7c1716589311e57e9e305bfa057.camel@wdc.com>
References: <20260928195902.2045235-1-daniel.barboza@oss.qualcomm.com>
 <20260928195902.2045235-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260928195902.2045235-3-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH0PR04MB8129:EE_
x-ms-office365-filtering-correlation-id: b89597a8-f7d3-486d-b195-08df1f76e398
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|23010399003|376014|10070799003|38070700021|4143699003|10067099003|11063799006|56012099006|22082099003|18092099006|10086099003|18002099003|6133799003;
x-microsoft-antispam-message-info: FjzgXleiORVEyu78E/8gSX8mQ1DT37NfDB3njlbL6RNTEa89KM50Ev7PT/WSglItfJrpZyTJe+OBS4w5gIOFHV2/EUhWUagf9+71O1yO3iJSAtuClyVl69YmUAzbdvqg3CK9GH8VvEcSXzbdShlyPNpCjb/+aldFRuwToEinZsfMCAw+VmyZbFZNnYIOpiPWdmbVDCm76QGniyLtXlUsIr5FLyTTbLrVY29/Ego54J4d9fbIBcHgatf3T3DTJi5+OW52l3vib/aiJGo/cdo5rRJCT39/6Q37rkzPzvJ0QC+abAH5LrwQlgDObuOuHrZ7VmNPfMXFKOV4VBc3U6MzkTRBA4eZcNWdtGMWQZapI+fAb0ClJUXySJzQrOqIbICr1sQCfbuUOrJfWg9ekKQeA+OTsN8dUYWvzd9sLcsllTZ71yoWNy1MgbWogB2k81mKWRiXcYbS44BaNoTCEZulvfSaZwCKNr1nShTi2Z1xinrxYQ+1toiAKIYCr8ZSKcK/CJaPECJBdRpXkA/YmQBuoBqcs09161tceysN7izEjQk8NPnuQWmHKh2WiFi6GB7LayZpU8lEiapZISbiNMZ1LGD3j2XIgyRYkZusGrSsmM/EmEVIjcaO6lvNaApRq6vd4mMRbyAZIdM/uZl5+DEyivu6MDMRLodsmc8eweZ0ujmwcREoqjRhRFgQSbz4gR5DCrF4RW/AKTb3qQgSWDvRmhqsmKTQlqmWiK7EVwbsL5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(10070799003)(38070700021)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18092099006)(10086099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enRWOFl5S3RFTjRXeTRaZ1FhT3hoK28xNHU5bTZFZ25PRFphM2QyQXF0Tnl6?=
 =?utf-8?B?Y1pnY2JLYnlwdXdRbnhTbzVINXFiOHE3bUduV3hZTmZTSG93VVMwb05PZktq?=
 =?utf-8?B?UmE4d3JsMmlvN1grQ3JXcU1pTnF0RjE4cGR6eWRxT2RWbkI0N3FGN0hpK1gz?=
 =?utf-8?B?eXNNbUEvYWpTSE54SlBmM29iRno0Qm5heGhkOVlIWVRmaE56cWo4K0Y3VXo5?=
 =?utf-8?B?VHMyeHJvSENjUHFTUEIxUDQwZW53SVhXbkpja0U2aDdYaW5QUUFCZUFock1p?=
 =?utf-8?B?dU5PdmlQbnY5VU5nUVdwNUw4M0JUSHRSdi9XQnRUd2taUzBHOEQxZWZwVjk4?=
 =?utf-8?B?YU1qRmlERXNsK00zK3EvTVQ5bzFDbEdDQTlQOGpRemp1RXIrRC9saFprS09x?=
 =?utf-8?B?Titzc3BSZWIyMjhGcDdLY1JvZVg2SHA1Z3ZObThuL3ZYTEU1Vm5rTGEzN0dN?=
 =?utf-8?B?MXZ2R2hBckRIdks2dEgvYklaTzg3RjdmekhFRzluNG9uTmprK0txNnpvSVdo?=
 =?utf-8?B?VVUvRnR5NzJwK0JuRUJhd0Q3ZE1rWXVOdmhZRzBIZGRvRVpySENzREhTb25D?=
 =?utf-8?B?TnNIdzlvU0QwbllUZ2pxNHcwK2NyZXkvK0FxYURXbDdJUnBLeVJNbm9LeHpQ?=
 =?utf-8?B?cVNNSDd3UmhKcUcvdGdFSHBTQStmTlU1SEQvYk81RU4xSkZRbjIyRDV2bjZH?=
 =?utf-8?B?WGVHdUYwV3hjbFg5YUV5N2Z3eG9CSERBdjUxTVQwNEI5OGp2WlMzaFBKZ1hJ?=
 =?utf-8?B?UVBxa28rSVZBbUptSkVoWGw1VThIb3JnazBNanVoem5sbVdjRFRma0tkaHdq?=
 =?utf-8?B?L1lMa2NwYVc0QlI1TE0xdUo4eXloYVBWT2lwQ3VzR2txRS8vcWFLdE41b1VQ?=
 =?utf-8?B?Vjc5Qk01dkhjR1hrY3NLdjcvMFppVkphQi96YkpjNk1Lc3ZoTHNCZE5lRDIz?=
 =?utf-8?B?OFQwOThvcHhSbEFKbFNBMStiWFM3MktyejlwRkhxSEtBMXpmMlN6R2FUNGFM?=
 =?utf-8?B?NHpPR2hpWDZBMDZ6WDF3czhHaVQ1eEY4ck0zRGlodmJsVDB4U2RzeWdOS1NH?=
 =?utf-8?B?dUxrSnVRbll5WkFKMkRzOVJMOG1SaGRxNFZsY3dleGFmT2JtNTY5ditIRFEv?=
 =?utf-8?B?bGhwaWJYNmQ1RG9FWVQ1UzNjREFLNHNaUy9RRCtYa1ZvekhjeXE5V2hEUjVH?=
 =?utf-8?B?djhEYUZ3WWlNcS9EYnlIRi9lYlk0WGZFY0pKcGNOSExPZWVrR1J6cWZiL2Zv?=
 =?utf-8?B?bTdja2src3JCUkxCd2tsQmpvSXFueGtIcWdMeHNtMi9XWDZCcE5qM3VvZ1Rk?=
 =?utf-8?B?cG8xTVhDbmR4UkRUTFpwczFzbGRaUUpHWkIraEZBTkdXcks5NmdjZFVZQWxp?=
 =?utf-8?B?aFc3VGxuT2NPeXREZEl4bG5UTVNhTWlmaG4xclpFTXYwOFR1RjN3T0lIUzhY?=
 =?utf-8?B?TUErVFY1b2FKWDZKREFLSllLbmd4UFp4anl2cXRNQlhyWHBhUDVXbm9nR0cw?=
 =?utf-8?B?UXR3VHltWlhQZGZsOEpXc0ZJODRaaTcwek9WMlpKQzVCcG1uZUhMcXIxem9z?=
 =?utf-8?B?Mi8yRDZ4SXFRem9KKzcydEJpa1ZiRkxrcDVKcmNUSGx6RWlOL2J4WnQ0dFRT?=
 =?utf-8?B?WnF0RjBPV0xBVjJreWNnVVZnSUJGVll1Z0txWlFmQ3Z1OC9QcEx6a1RyR1RW?=
 =?utf-8?B?cXpBNUNuTUVVeXpOS3dNZVBwZmZJakRMa1hMUXVpTURoM0xPVXNoSnh0clNG?=
 =?utf-8?B?MnYxWUNYVVZqNTMrMGpMWmp0VWIva0RGT2JZK2xrb2cwczVnOWtpU2Zua3NW?=
 =?utf-8?B?SUVSNUQ1TG4xZ0N4RkdraXhVc0NyNjZUZWxiSkhwcTVIak9mZVlKQ1c5dDF4?=
 =?utf-8?B?Vy85TzNHWVp0eHJLcG5CY0pYMVMwbUpUVWYxNnVaK2lMenROZGJIMXFNMnE5?=
 =?utf-8?B?Z28zR3Q0M09wN0VvTHRuZXV2cVd5OEF1QXlTU2crN1RTTEZyQ2VlVjRkN2FB?=
 =?utf-8?B?ZmQ1bDZLNkVFVHRUMjArTjdxYW5OOEEwbWpkcEZic1JENG83NEhreFhacTdo?=
 =?utf-8?B?eW1rWGc3bEp2d1hYT0g4OU8yMFh3ZEVLaG9UR095YlM4MmR5REZCN2g5Mkdv?=
 =?utf-8?B?YWtlKytFWWd2akNPb21wTHVhV2xubjVYTWp1SUFIdUorbU9Dc1VWLzNNTFRz?=
 =?utf-8?B?RE1WWkNCRURTYzhXVVpqQnVkT2JYZEN3QTRWU2NYbGZyR2c4RWdxdXdlODlF?=
 =?utf-8?B?SzE3WmlMVWtiRlpMY0l3d0FJRWhiakl2Z2ZGdi90QTQ3Q05HVHQrZ0VnWStl?=
 =?utf-8?B?UkdUbExyZzVTMmkwMnlNaUU1aUUrS1F1NHJLYnl3QUxvSnphTkZLcVNQTFRS?=
 =?utf-8?Q?VVV7RWPy7UiWsbLjJZbOIuilaElisaFZQZ1wYVDSaL5Dj?=
x-ms-exchange-antispam-messagedata-1: K4/WlEPa0kjZZP0XpfvFe+ABi05HyYyM0Fc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C73FFC45A87BAC438461057D5FB08420@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UjmmBho6wEJsEWeV1NCOsOw7AkroWz7Zx2bbMPo/vOSb+/vHqxldl5ZcLAO60sJnxXOO91MFmtvOxnrtjTGLqcQ5BDpIO6tQUm9/B9Y0zu1/3nLD/yFF4BBb7tgqcjXR8+9HU2zfzGoJZCV/BqgwrYuWkXB90U2AMhackyhGYzaTS5MXd+kbWkUCtUhIttwyhCTP4WCu2fenD2JCkAu8Q+qxiqlkCrH0ftm5vYlcSpU7q0Bc35+PnNPysy5kdzTZHZHeVvv3u9DmQFtemu2zB0ztUrWA8hzIA3Dn5xl+aJY3BWrLB3JRXAXj43e1XtexIWUqUuGoyvyV6ZKOV3EA0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qnkGZZhdvZarWDfqItkDC9N5zOw17gQpark/cvdkJuMQJET9RsTS4VT+XvBAWJsOqxaYClGPJ+D9nb1Wzl8+ntsBOZ+wBxWfojdLaY9W32ZghcMAKdINwVH6AqV9+NTPEFqj79kV3iHd3aYrLbOEMGtnnfhwpLlDCvL8iLrK7l3nskqtMwp/ZBOlTvlN8lsh9R16pC1HLGXMpTKc5qGr2pONnY71Mg9RbKeuhycPyY9KibjbgifoDvl+w7Xn6wnEn5irysmOVOGDQw0DyZ1dkynDqJSizcxNCpc8aJAkcvJW/hr56MS4HBr7Q/LEPlFcsV9ErsdwT64/GdmL3Dn8/8/QlSNKfTKmdlPfGSdQ4B77FPZ2zj1vk6ZNIkwlHQ7Axqful4pclRXGWxQ19k/z7FhrKxFxpksaP/IRycHdWxBYry7CsmovAYIlXKJgBZ2Cyc4QT/qG26UUDRSp/PSVoz2HSf3q8rEfQPULb4F1L5Eu1PSaO+NP8Zc9RTubjLh12M18TlwK1jGJGwG4JBo36RY9tvRTOoUen05uImX3AXF5uAdsOzzAD+/DkRn/pdqpsVMFKh9kNxtaBVQdwHzJFO1OBF3f7Au0MV1PAXpIxe0pT+cxh2KHjxhKVo5UMU2E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89597a8-f7d3-486d-b195-08df1f76e398
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 04:45:59.4545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a257qVGuDOfTExOJSu22C2V+lKng3a8Tl2/V4Sme3ZRwuf3H/yjvtl67Wtp/3GjU1+CmgoJ6r7/50wUvj5SGrpqTkpUI2LD4XDCTJTeQezU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8129
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE2OjU4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRnJvbTogQ2hhbyBMaXUgPGNoYW8ubGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+
IA0KPiBSSVNDLVYgRGVidWcgU3BlY2lmaWNhdGlvbjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3Jp
c2N2L3Jpc2N2LWRlYnVnLXNwZWMvcmVsZWFzZXMvdGFnLzEuMA0KPiANCj4gQWRkIGhlbHBlcnMg
dG8gZW50ZXIvbGVhdmUgRGVidWcgTW9kZSBhbmQgdG8gdXBkYXRlIGRwYy9kY3NyLg0KPiBNb2Rl
bCByZXN1bWUgd2l0aG91dCBhIERlYnVnIE1vZHVsZSBieSBsZWF2aW5nIERlYnVnIE1vZGUgYXQN
Cj4gY3B1X2V4ZWNfZW50ZXIgYW5kIGNvbnRpbnVpbmcgZnJvbSBkcGMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFvIExpdSA8Y2hhby5saXUuemV2b3JuQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNv
bW0uY29tPg0KPiBUZXN0ZWQtYnk6IFRhbyBUYW5nIDx0YW5ndGFvMTYzNEBwaHl0aXVtLmNvbS5j
bj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5i
YXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysNCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2NwdV9o
ZWxwZXIuYyB8IDg4DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jwqDCoMKgwqDCoCB8wqAgNSArKw0KPiDCoHRhcmdldC9y
aXNjdi90Y2cvdGNnLWNwdS5jwqDCoMKgIHwgMTQgKysrKysrDQo+IMKgNCBmaWxlcyBjaGFuZ2Vk
LCAxMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUu
aCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiBpbmRleCA1ZGU4YjJjZWI0Li5mYTI1M2IzMmQwIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2Nw
dS5oDQo+IEBAIC02NzgsNiArNjc4LDkgQEAgYm9vbCByaXNjdl9jcHVfdGxiX2ZpbGwoQ1BVU3Rh
dGUgKmNzLCB2YWRkcg0KPiBhZGRyZXNzLCBpbnQgc2l6ZSwNCj4gwqBjaGFyICpyaXNjdl9pc2Ff
c3RyaW5nKFJJU0NWQ1BVICpjcHUpOw0KPiDCoGludCByaXNjdl9jcHVfbWF4X3hsZW4oUklTQ1ZD
UFVDbGFzcyAqbWNjKTsNCj4gwqBib29sIHJpc2N2X2NwdV9vcHRpb25fc2V0KFJJU0NWQ1BVICpj
cHUsIGNvbnN0IGNoYXIgKm9wdG5hbWUpOw0KPiArdm9pZCByaXNjdl9jcHVfZW50ZXJfZGVidWdf
bW9kZShDUFVSSVNDVlN0YXRlICplbnYsIHRhcmdldF91bG9uZyBwYywNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQz
Ml90IGNhdXNlKTsNCj4gK3ZvaWQgcmlzY3ZfY3B1X2xlYXZlX2RlYnVnX21vZGUoQ1BVUklTQ1ZT
dGF0ZSAqZW52KTsNCj4gwqANCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gwqB2b2lk
IHJpc2N2X2NwdV9kb19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNwdSk7DQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiBiL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hl
bHBlci5jDQo+IGluZGV4IGU3OGFjZjM3ZGMuLmI2YjhjMjUxOGIgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1
X2hlbHBlci5jDQo+IEBAIC0xMzIsNiArMTMyLDk0IEBAIGJvb2wNCj4gcmlzY3ZfZW52X3Ntb2Rl
X2RibHRycF9lbmFibGVkKENQVVJJU0NWU3RhdGUgKmVudiwgYm9vbCB2aXJ0KQ0KPiDCoCNlbmRp
Zg0KPiDCoH0NCj4gwqANCj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiArc3RhdGljIGJv
b2wgcmlzY3Zfc2RleHRfZW5hYmxlZChDUFVSSVNDVlN0YXRlICplbnYpDQo+ICt7DQo+ICvCoMKg
wqAgcmV0dXJuIHJpc2N2X2NwdV9jZmcoZW52KS0+ZXh0X3NkZXh0Ow0KPiArfQ0KPiArI2VuZGlm
DQo+ICsNCj4gK3ZvaWQgcmlzY3ZfY3B1X2VudGVyX2RlYnVnX21vZGUoQ1BVUklTQ1ZTdGF0ZSAq
ZW52LCB0YXJnZXRfdWxvbmcgcGMsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBjYXVzZSkNCj4gK3sNCj4g
KyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiArwqDCoMKgIGlmICghcmlzY3Zfc2RleHRfZW5h
YmxlZChlbnYpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ICvCoMKgwqAgfQ0KPiAr
DQo+ICvCoMKgwqAgZW52LT5kZWJ1Z19tb2RlID0gdHJ1ZTsNCj4gK8KgwqDCoCBlbnYtPmRwYyA9
IHBjICYgZ2V0X3hlcGNfbWFzayhlbnYpOw0KPiArwqDCoMKgIGVudi0+ZGNzciAmPSB+KERDU1Jf
Q0FVU0VfTUFTSyB8IERDU1JfUFJWX01BU0sgfCBEQ1NSX1YpOw0KPiArwqDCoMKgIGVudi0+ZGNz
ciB8PSAoY2F1c2UgJiAweDcpIDw8IERDU1JfQ0FVU0VfU0hJRlQ7DQo+ICvCoMKgwqAgZW52LT5k
Y3NyIHw9IGVudi0+cHJpdiAmIERDU1JfUFJWX01BU0s7DQo+ICvCoMKgwqAgaWYgKGVudi0+dmly
dF9lbmFibGVkICYmIHJpc2N2X2hhc19leHQoZW52LCBSVkgpKSB7DQo+ICvCoMKgwqDCoMKgwqDC
oCBlbnYtPmRjc3IgfD0gRENTUl9WOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChl
bnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2ZpbHApIHsNCj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChlbnYtPmVscCkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPmRjc3IgfD0gRENT
Ul9QRUxQOw0KPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZW52LT5kY3NyICY9IH5EQ1NSX1BFTFA7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+ICvC
oMKgwqDCoMKgwqDCoCBlbnYtPmVscCA9IGZhbHNlOw0KPiArwqDCoMKgIH0NCj4gKyNlbmRpZg0K
PiArfQ0KPiArDQo+ICt2b2lkIHJpc2N2X2NwdV9sZWF2ZV9kZWJ1Z19tb2RlKENQVVJJU0NWU3Rh
dGUgKmVudikNCj4gK3sNCj4gKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiArwqDCoMKgIHVp
bnQzMl90IG5ld19wcml2Ow0KPiArwqDCoMKgIGJvb2wgbmV3X3ZpcnQ7DQo+ICsNCj4gK8KgwqDC
oCBpZiAoIXJpc2N2X3NkZXh0X2VuYWJsZWQoZW52KSkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIG5ld19wcml2ID0gZW52LT5kY3NyICYg
RENTUl9QUlZfTUFTSzsNCj4gK8KgwqDCoCBuZXdfdmlydCA9IHJpc2N2X2hhc19leHQoZW52LCBS
VkgpICYmIChlbnYtPmRjc3IgJiBEQ1NSX1YpOw0KPiArDQo+ICvCoMKgwqAgaWYgKG5ld19wcml2
ID4gUFJWX00pIHsNCj4gK8KgwqDCoMKgwqDCoMKgIG5ld19wcml2ID0gUFJWX007DQo+ICvCoMKg
wqAgfQ0KDQpEQ1NSX1BSVl9NQVNLIGlzIDB4Mywgc28gdGhpcyBjYW4gbmV2ZXIgYmUgdHJ1ZQ0K
DQo+ICvCoMKgwqAgaWYgKG5ld19wcml2ID09IFBSVl9NKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBu
ZXdfdmlydCA9IGZhbHNlOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChuZXdfcHJp
diA9PSBQUlZfUyAmJiAhcmlzY3ZfaGFzX2V4dChlbnYsIFJWUykpIHsNCj4gK8KgwqDCoMKgwqDC
oMKgIG5ld19wcml2ID0gUFJWX007DQo+ICvCoMKgwqDCoMKgwqDCoCBuZXdfdmlydCA9IGZhbHNl
Ow0KPiArwqDCoMKgIH0gZWxzZSBpZiAobmV3X3ByaXYgPT0gUFJWX1UgJiYgIXJpc2N2X2hhc19l
eHQoZW52LCBSVlUpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBuZXdfcHJpdiA9IHJpc2N2X2hhc19l
eHQoZW52LCBSVlMpID8gUFJWX1MgOiBQUlZfTTsNCj4gK8KgwqDCoMKgwqDCoMKgIG5ld192aXJ0
ID0gZmFsc2U7DQo+ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgZW52LT5kZWJ1Z19tb2RlID0g
ZmFsc2U7DQo+ICvCoMKgwqAgcmlzY3ZfY3B1X3NldF9tb2RlKGVudiwgbmV3X3ByaXYsIG5ld192
aXJ0KTsNCj4gKw0KPiArwqDCoMKgIGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcuZXh0X3ppY2Zp
bHApIHsNCj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+ZWxwID0gY3B1X2dldF9mY2ZpZW4oZW52KSAm
JiAoZW52LT5kY3NyICYgRENTUl9QRUxQKTsNCj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+ZGNzciAm
PSB+RENTUl9QRUxQOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChuZXdfcHJpdiAh
PSBQUlZfTSkgew0KPiArwqDCoMKgwqDCoMKgwqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxkKGVu
di0+bXN0YXR1cywgTVNUQVRVU19NUFJWLCAwKTsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDC
oCBpZiAoZW52X2FyY2hjcHUoZW52KS0+Y2ZnLmV4dF9zbWRibHRycCAmJiBuZXdfcHJpdiAhPSBQ
UlZfTSkgew0KPiArwqDCoMKgwqDCoMKgwqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxkKGVudi0+
bXN0YXR1cywgTVNUQVRVU19NRFQsIDApOw0KPiArwqDCoMKgIH0NCj4gK8KgwqDCoCBpZiAoZW52
X2FyY2hjcHUoZW52KS0+Y2ZnLmV4dF9zc2RibHRycCAmJiAobmV3X3ByaXYgPT0gUFJWX1UgfHwN
Cj4gbmV3X3ZpcnQpKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmll
bGQoZW52LT5tc3RhdHVzLCBNU1RBVFVTX1NEVCwgMCk7DQo+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
bmV3X3ZpcnQgJiYgbmV3X3ByaXYgPT0gUFJWX1UpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZW52LT52c3N0YXR1cyA9IHNldF9maWVsZChlbnYtPnZzc3RhdHVzLCBNU1RBVFVTX1NEVCwN
Cj4gMCk7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+ICvCoMKgwqAgfQ0KPiArI2VuZGlmDQo+ICt9
DQo+ICsNCj4gKw0KPiDCoC8qDQo+IMKgICogUmV0dXJucyB0aGUgZWZmZWN0aXZlIFBNTSBmaWVs
ZC4NCj4gwqAgKg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jIGIvdGFy
Z2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+IGluZGV4IGU0ZDcxOWExZGEuLjI1Mzc1MTVmNTQgMTAw
NjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiArKysgYi90YXJnZXQvcmlz
Y3YvdGNnL2RlYnVnLmMNCj4gQEAgLTk3Myw2ICs5NzMsMTEgQEAgdm9pZCByaXNjdl9jcHVfZGVi
dWdfZXhjcF9oYW5kbGVyKENQVVN0YXRlICpjcykNCj4gwqDCoMKgwqAgUklTQ1ZDUFUgKmNwdSA9
IFJJU0NWX0NQVShjcyk7DQo+IMKgwqDCoMKgIENQVVJJU0NWU3RhdGUgKmVudiA9ICZjcHUtPmVu
djsNCj4gwqANCj4gK8KgwqDCoCAvKiBUcmlnZ2VycyBtdXN0IG5vdCBtYXRjaCBvciBmaXJlIHdo
aWxlIGluIERlYnVnIE1vZGUuICovDQo+ICvCoMKgwqAgaWYgKGVudi0+ZGVidWdfbW9kZSkgew0K
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBp
ZiAoY3MtPndhdGNocG9pbnRfaGl0KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNzLT53YXRj
aHBvaW50X2hpdC0+ZmxhZ3MgJiBCUF9DUFUpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRvX3RyaWdnZXJfYWN0aW9uKGVudiwgREJHX0FDVElPTl9CUCk7DQo+IGRpZmYgLS1naXQgYS90
YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYyBiL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jDQo+
IGluZGV4IGI2ODE2MGFmODMuLjk1OWExZTg5YzggMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNj
di90Y2cvdGNnLWNwdS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jDQo+IEBA
IC0yNjksNiArMjY5LDE5IEBAIHN0YXRpYyB2YWRkciByaXNjdl9wb2ludGVyX3dyYXAoQ1BVU3Rh
dGUgKmNzLA0KPiBpbnQgbW11X2lkeCwNCj4gwqDCoMKgwqAgfQ0KPiDCoMKgwqDCoCByZXR1cm4g
ZXh0cmFjdDY0KHJlc3VsdCwgMCwgNjQgLSBwbV9sZW4pOw0KPiDCoH0NCj4gKw0KPiArc3RhdGlj
IHZvaWQgcmlzY3ZfY3B1X2V4ZWNfZW50ZXIoQ1BVU3RhdGUgKmNzKQ0KPiArew0KPiArwqDCoMKg
IFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoY3MpOw0KPiArwqDCoMKgIENQVVJJU0NWU3RhdGUg
KmVudiA9ICZjcHUtPmVudjsNCj4gKw0KPiArwqDCoMKgIGlmICghY3B1LT5jZmcuZXh0X3NkZXh0
IHx8ICFlbnYtPmRlYnVnX21vZGUpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gK8Kg
wqDCoCB9DQo+ICvCoMKgwqAgdGFyZ2V0X3Vsb25nIHBjID0gZW52LT5kcGM7DQoNClNob3VsZCBi
ZSBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbg0KDQpPdGhlcndpc2U6DQoNClJldmlld2VkLWJ5
OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWly
DQoNCj4gK8KgwqDCoCByaXNjdl9jcHVfbGVhdmVfZGVidWdfbW9kZShlbnYpOw0KPiArwqDCoMKg
IGVudi0+cGMgPSBwYzsNCj4gK30NCj4gwqAjZW5kaWYNCj4gwqANCj4gwqBjb25zdCBUQ0dDUFVP
cHMgcmlzY3ZfdGNnX29wcyA9IHsNCj4gQEAgLTI4NSw2ICsyOTgsNyBAQCBjb25zdCBUQ0dDUFVP
cHMgcmlzY3ZfdGNnX29wcyA9IHsNCj4gwqAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gwqDC
oMKgwqAgLnRsYl9maWxsID0gcmlzY3ZfY3B1X3RsYl9maWxsLA0KPiDCoMKgwqDCoCAucG9pbnRl
cl93cmFwID0gcmlzY3ZfcG9pbnRlcl93cmFwLA0KPiArwqDCoMKgIC5jcHVfZXhlY19lbnRlciA9
IHJpc2N2X2NwdV9leGVjX2VudGVyLA0KPiDCoMKgwqDCoCAuY3B1X2V4ZWNfaW50ZXJydXB0ID0g
cmlzY3ZfY3B1X2V4ZWNfaW50ZXJydXB0LA0KPiDCoMKgwqDCoCAuY3B1X2V4ZWNfaGFsdCA9IHJp
c2N2X2NwdV9oYXNfd29yaywNCj4gwqDCoMKgwqAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0
LA0K

