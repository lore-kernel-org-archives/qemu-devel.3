Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6249AC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1z79-0001NH-4T; Thu, 03 Sep 2026 00:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1z77-0001Mf-9f; Thu, 03 Sep 2026 00:31:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1z75-0004Yp-K8; Thu, 03 Sep 2026 00:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788409911; x=1819945911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VuMbFWTsJsnup+4vIKcTgK70bjIaF8Ykw3leIyU5Vuw=;
 b=McnWp77V8hrTy2F0s0uiVoPa1h1kuVGDahKoF/6ub9TDHW3ucIPy3rYb
 SZ+BbW4OlDgg+z/iqWKaTgonySj6ir/5kSWAtmJKFfP6CROdjZRDUh0TC
 l2ToLpXkHnTYFugiasKL/K68LTpuEeaaAKQy7PWDYLNzZ/WgjBGEgNBiU
 gAYuAgYuWwY1T0Rmcm2zea1AQu6pJ+8y4H5lPPVJSVHGwp+W75Q5Mjsez
 E6eZY+HbXv+sd+IcCx2L2EzjKTcf0ix2QuYnKmQ1KZgrICir5rhLQNCuD
 sdFtIGFAUXlV8g4rvI/KG7P3muxh8JzUMaRQO1vHOfW+Rb/cJOm5ZlwnB Q==;
X-CSE-ConnectionGUID: kj4iQchqQQGVJ0mkd/6Wnw==
X-CSE-MsgGUID: HMJ8UMmWTeKwjcSiqmHNwQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153884457"
Received: from mail-westusazon11010043.outbound.protection.outlook.com (HELO
 BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 12:31:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXJUYbnAGOPfVCRxxzstKtZrOg3w9iSUd38qDzzMvA7DG/DpH4nEi9ZkUUV826pg7EAo+NdqpTWQOO0eoRKUWa/NJ1ef4W9OU7K/DuDiy1sqTDddKeEQf4LLVwQknY+KkX4YCg1yKztK/ad2TNRzvfufz1FS8QRbvyRIam/Le6URIp7LISYt03jAibrnBIC42LCT7+O/ZgHKL0cWCRi3Y8Vr4xROXJwvuEO/pTVxAIce/0DV73sv++SJPJtBaPGJuRPlOXSBUYD4li8dR5Q0QqLFvJyp18+K7StYrq5zmVk5PUblE91wrSlofMvwAaiwBlxdEp2fVA0HivDb928dBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuMbFWTsJsnup+4vIKcTgK70bjIaF8Ykw3leIyU5Vuw=;
 b=h6vE+IdazaxOLP+tITMebzC3RcMWAJxRm0tiOpx5J2Zbr0yB+7y+dw93vb9s3Xx1hyRwVgo/guyxbSvHYhXumDuyJRJCZo3goj0Z2cQjCBiCwkolLso4fW2owzubeTxwc14XuToNRmSEenRmXxLmhyOjOmcIVkXjxVE9d7wlTqk0F/13WnHlrCqTVL0gOsTN/RVdczSRlue4XsP1LOlxkHlI9oVfullMN9eyk0c1Oh5/AwE6o46eoktJNp9yPFRT+wgk9MWBNCqWydPT8Nd4Jlz4/BXRoLZT4BmTUMQlBbPMNwO5AzyWsiAZrmBj42mJDCtmhY6wTCtEzca654BlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuMbFWTsJsnup+4vIKcTgK70bjIaF8Ykw3leIyU5Vuw=;
 b=p45waQV0yOs+v4/TqfoZkwdMCxtiORx7ZQxuYWJJx3iL0U3WB97vdFHS1+zpFkjepZZc6N7Oj7B4bTq9f8ynV4Jk6vtr5a/73ufDOd4aS3DtXRW7HSpoVKs7T0u7eTQOdzm5WakaxadBUo1aXBYji2SxxXOZSAJWC6qE0mCjGjM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB6921.namprd04.prod.outlook.com (2603:10b6:5:244::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 04:31:42 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 04:31:42 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "314abh@gmail.com" <314abh@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: prevent abrupt abortion on unassigned value
 write to tdata
Thread-Topic: [PATCH] target/riscv: prevent abrupt abortion on unassigned
 value write to tdata
Thread-Index: AQHdH64Z9nhdGcBW9ki+Gqkpk8rXe7a8et+A
Date: Thu, 3 Sep 2026 04:31:42 +0000
Message-ID: <a01a324d4fe5be25d0359cc0cb44d5a8ad66bd8a.camel@wdc.com>
References: <20260729230028.1797355-1-314abh@gmail.com>
In-Reply-To: <20260729230028.1797355-1-314abh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB6921:EE_
x-ms-office365-filtering-correlation-id: 00d3bb48-0591-4934-3e82-08df09744123
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|19092799006|23010399003|376014|10086099003|6133799003|22082099003|18092099006|18002099003|56012099006|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info: PsekwWM6R7mz/AjK6FaDJ1bG+QJBojFGtPX/4CyulVG1GJ3a7P/SeTAZkuTeJE1aSoh/xm3FTkkvaygc3NpNCJZAZ3lUfLwwV0MrBpvJU+U/3BMqJA2fGhMOxlnm4BGrr6j9Z8a3AHt2n33lvjuo7bdJnjOaSDSI4q/+13meiVG6PLSfwL8LeQ7ZNLPDKyG86FAhERVgk0rS1op42iiV7zXo4AceLz3lGFQwmiyypAyAE9RJM+NQdHoKXgyaeU7IxfOfTGx6kvt0cINsfkW50Hp0mWap211U+OuvCeMItXMh8j156Xc6+LRKdzwDTEYDepB4laOCog86QayhHmzZJlkgxzPMo3mTeECvT0hbeGFLf4FyZB40jti5l4gij4RzAl8xf1OBvIUzAGRtCKJ1kuXT0dVfcuXifJCKN9YLK4hG9KMYBltt5e/f0fnsv1ty7FnX481vBKI5JDMsO2tmkgS+dQyPZt7BDP7ycer2KgW8XtxpJQG+ptWrGDIUQ1h+0UtYZzz2OL62Y5KAJgZioMoX4cuIn1dcuyfzoyGf4EEk5Y0YWbEH29ui48WH7xdJRlahNNz9XXnLPKdWzi+Ti/8xBQuq9nZN4o0YhuUe3PwHg+alnl97C1cl7hixWdjw+lOUvMZWs7cGYpewfAJCPJWv24ykDO7RWxznw7WLQ3MQhRwO364PcQvCxnXhb8NE6n5otg0F0o0fg3QkEIXVIkPa2kaw2EBL46acj+nAXro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(376014)(10086099003)(6133799003)(22082099003)(18092099006)(18002099003)(56012099006)(38070700021)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dStjRFpZL1FMaytPUGg2Yk92MDEyR1dKdU1kaFdDWFFleUVkYURScnBGcUNp?=
 =?utf-8?B?a2JMU1UyMml4b1RNMDNVaGpxclRzNWRrTzJCZlpRTFUxMTgvWGtFaWFvcWZq?=
 =?utf-8?B?VUxKdjBvOEt6cG5Ib1BvMFFCR1hZRHRTR1Bkdi9hcGs0akFBcExIWERmL3BW?=
 =?utf-8?B?TEdxTmpjWnBPRmMrRWllb2dXNU9vYStNMHpmRjNTY3lhMlFXT1UrWVdXTkRi?=
 =?utf-8?B?aXRRSVFNQlhTNmQ2alZhakt6eHBoZWxTVTBHQ3cxc0VxcVZHQjY1ZWRscm5r?=
 =?utf-8?B?S25qelB1bW4xSXc2NEpvT0dERm54bFlGSWJTOEhJb0k0OGZrbEhML3BDeUE4?=
 =?utf-8?B?eXREWmlWYlpYamxJaHFKV1JLT3JqREhDbFYyUVNjZzVNZEtmMFNnLzU2ZHIw?=
 =?utf-8?B?Q2dXelBGYlppenZ0NFI0cWhCZVdCdkhUT2x5SUVsVFBBTU0xcWw0d1dXYnNq?=
 =?utf-8?B?d0laT1dSbXQ1NVBVcEFXbXFaRTFrZi9HVVRuckdYeFA1ekMxdmVzcUgrMk8v?=
 =?utf-8?B?Ym9HQ01yekV2M3hoaG9qbllXYktIYUZmWkRVS2JBdUdCUEVEK2h4eGRNakda?=
 =?utf-8?B?c0NiMDNwNGl5WEFXTHJsWCtXUEF2ZHJ5ZnJ2OWFaeXR4YkpibnhRcXVsUnNM?=
 =?utf-8?B?Qk5NU0gxMFdiQ3g3dXNmM3U5TXFDNG1xUTJ3ZVJKRUJrUmRhUnV3bmdxOUZj?=
 =?utf-8?B?V2Rya2xTRWE1eGYrQW5MandwTFVjRWFxUGNGbnQ1Wm5oK1JkN2V3eXBhUVky?=
 =?utf-8?B?OFV0K2xiT2ZBWEx1R2RNdnlzUXBBN0IrN0d1eUptRTlFeGFQTUxkQ2p6Rm54?=
 =?utf-8?B?OExXc3l5dGNOYnVMUFJnNnoxejQ0Vy8vVFZ2QU1xdU5ZMytPWnVrZEVuTWxo?=
 =?utf-8?B?Vk1BdXZ4YTd6MXVMZHIyNGVMS2FDSXRzOEI5WFFQejFmb0JKWENlb0tsemdv?=
 =?utf-8?B?MHhtYmo1aHd4R2FZL0dJQ2V1d1dRbHkyWlpQbXJpdmZPMm5HRE1rejlQSzBZ?=
 =?utf-8?B?OXUxV1ZGb3pVdGk2dEpGb2NsVEdrYlcvZHRKNjB0U2VUazhCR3pidlVLa0RF?=
 =?utf-8?B?bDF5UHkyUzNyMFVpOWttSkRnS2VhR1lFZ2Y5clVOa3ZlUXZTNTBxTm9iS1k4?=
 =?utf-8?B?TlI2K3hIQjNnY2FaMDZnUHhhWDhRMmU0S2JLUlNpajdtVGU4Q3FZZHVkYkti?=
 =?utf-8?B?ZXZ3bzRpWGFtTnUvWmJnd2QrbW1SbkdPaVRSVitRaGlkTFB0SkxReDlCOEtl?=
 =?utf-8?B?MHdUMi9RSkExZWNodnAvbVZ0Z3JGTS93OHpNYTZ5YXdmNzE3cktCRFk0SXcv?=
 =?utf-8?B?dVJKZDVUdUhiT1NqeVAyamdONGVLUC9ESjQ2cXVZZThIQ3llOFJhNmxYL0lD?=
 =?utf-8?B?NEFZbHc5R3orYkJsRTFBM1NDVmlzb1UrblpTbWs5RG1ENkdwUDZjRzFidU5u?=
 =?utf-8?B?NFZGVmxTamhrb1AxN0xYVGxKdDZ2VWlRZlJRNXRtei90ZkMvdmswTWZNRzNE?=
 =?utf-8?B?K3RaNlE3VkxXL05KQkdMM20xTTFzV1VNWU9hQkRFbkcwUTBGZXpMYW50WG03?=
 =?utf-8?B?bkM0aEZ4KzByTnFxV055eWJER0ZkUzJva1pPV1NsQTRYejJnbUFHY1IzbzFE?=
 =?utf-8?B?cEh0azllTFpyYkhhZVFJajErRDEyRnRONmRDSXFBa1Q4eHkzVWlmYktyQkJs?=
 =?utf-8?B?c0pFZkFJSjg3d1cwV09OMEdNNWxzc0RURzBYSno4OXJIKzJvcndoZlNSRVda?=
 =?utf-8?B?bXZUdzZ1RDh6cUlEaUIzWXBmcWhWeVlHZTREOWlKTjgrSElHemhRN25JQS96?=
 =?utf-8?B?b0xrY0RwSG5aQThWSUp0OU5kUDMvSDdCa3UvMkdwSnY3RjdndWU2SENoeTZ6?=
 =?utf-8?B?RVR6NTZ5c2xCVGRVeWdUM09ZemxUbnlYYmREZWJHY0pWOFVoQSt2a2V3c1B2?=
 =?utf-8?B?d25oWVMwODhTU0M3ZmQzREtvclVBK1B6VlVQc3lFM3p1NFhsUVkyRHQrSU1O?=
 =?utf-8?B?ZUZXeEVmQUszN0t4QWM1OHhDcnBLNGxZMGFYQnZhZ3BuSHU4TXlCa2NUOFFm?=
 =?utf-8?B?NEwyc3lmNEpVYmlKWjZNYTl5R2VLOGdqM2lDdUFkTmJwbDBLdGhiYVYvRWJx?=
 =?utf-8?B?TjI0TVF6VHNVaEptMDJ2RmRHUURtT2I2MFZ3NWY1T1VoL0Yzd1Fjak00YmF0?=
 =?utf-8?B?bngwYm9YYjh1MndER25iK2ZoYktpQWZ0Qy9tdEQwZEFCQmY1anRUL2M4MDRI?=
 =?utf-8?B?MUpYaWs4K2cvRi9oWU9IWFI0b21NQkg4d1YxOHc2ckdqRkF5R3JtYkFDUnBY?=
 =?utf-8?B?ZmtQQXlFT21LSlFFL2J3Q2NrSmtoVzI1eDMwUTZhVTM0Uko2NmRvMS8zMC9X?=
 =?utf-8?Q?+eCJToOSZlpZQvOrQAmGY/JU6+HSXguSQTQXfaUSncUHy?=
x-ms-exchange-antispam-messagedata-1: r59bJPs+UAormUIlYMHgSx4mmXN7NsmYKSI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC6049B2C343D342AE162AD8E9543C23@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MCXnr6jefOE3nhSTq3/Laa8cDy40Wl0gkk74yXxMvHac94vFMadaH6H/LynxjEmI0CQL3yLTDGOYoRWUHp991awjmDqjrVF8j1sMgLRlMjPH4Rd9PzhA73IwtH8otJhsn935dV0ifkECaxHdCRyfyNKY+CyX/VgMdDbi770m1Pvl9H55qfdgYv1evP33ObR7Esc8u8MBJYzmNf66cPCbigqt8HzU/BwtnW5ULRl+2TKbngnn11vWcwuALFK3isfo7yIKkGMgdOfDDUwGHqC3oa5J/YZViPonGSGUqvPRVEeUnEAUS+kTM6c95vvnB6Gp/pt+ZJquBmv9tqepXn3QvQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HH9Z0SFYCc28LTM1Qxhx+/8b+YnnGrUxmj5Vuf8pO12zwBCVuIcTV5ZYvjrd3GooObRMkVksJEI6RJcbt8mXny9n1VElmn5lgZ9ZajGfk2uWe90KCDzcsH6uB9zdQHcydjzMYMUT4C78gQt9R/yuO6AcksA+O/ufWSasj+Jx76ii8OkA1StfEJxwjBFel6ppdps6ilP+ID+7bUZ/H+/Q494xp7W4q9xnyzORl0ecagBCJuD3csXVts9LyPn9HWydlkC30FehHwF8ZEaPX5tKsGtTn4MGMgmbEdGMbWjpaaSYFeM8MaAZHniheQeqxipqM+vanGfV6prCL1PGk3WBLl4lbjpDT5ZNVctfeFbc+3vGiwEwI3fYcH0v3i2ebHwcVNoZkxcmwk5b3+3mtnHs5VcwacGRmUNWDT0aAsRy16WUkGGjCBmVWfdrQfikCqrxCwTzKT4EB2IB0qyp4mWd79JTvdFiHh7+5BmCWo28fZhmNIT/GUz5xUKqrMEYmsFOxxB1mm1yd0nF3tByQggE8pVGV6KFYb5XzKAlc8nBHsRuAUNjRP6KaglQLc/6KOkq0edtjc5bRdIJg08s6uwOH/s6JybEw3u1Fc0lvK9fJuGh06lb7iiq0+hn/H9rPO21
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d3bb48-0591-4934-3e82-08df09744123
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 04:31:42.3119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kf6ccQWMbAmio3kTNVPcDS+EK0oSWGXLnxYuN9Gf/ICTu1A5jlRlaTMTFuz72yRy3zxLbM+uNJhk72+vpaMW94KRAb7TZNL3p8agKqox59E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6921
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
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

T24gVGh1LCAyMDI2LTA3LTMwIGF0IDA0OjMwICswNTMwLCBBYmhpZ3lhbiBLdW1hciB3cm90ZToN
Cj4gdGRhdGFfY3NyX3dyaXRlIGlzIGFwcHJvYWNoYWJsZSBieSBndWVzdCBwcm9ncmFtcy4gSW4g
Y2FzZSBvZg0KPiB1bmFzc2lnbmVkDQo+IHZhbHVlcyB3cml0dGVuIHRvIGEgdGRhdGEgQ1NSIGlu
IGRlYnVnIG1vZGUsIHRoZSBzd2l0Y2gtY2FzZSBmYWxscw0KPiB0aHJvdWdoIHN0cmFpZ2h0IHRv
IGRlZmF1bHQgY2F1c2luZyBhbiBpbW1lZGlhdGUgYWJvcnQuIFRoZSByaXNjLXYNCj4gc3BlYw0K
PiBzYXlzOg0KPiANCj4gwqDCoMKgIEFsbCB0ZGF0YSByZWdpc3RlcnMgZm9sbG93IHdyaXRlLWFu
eS1yZWFkLWxlZ2FsIHNlbWFudGljcy4gSWYgYQ0KPiBkZWJ1Z2dlcg0KPiDCoMKgwqAgd3JpdGVz
IGFuIHVuc3VwcG9ydGVkIGNvbmZpZ3VyYXRpb24sIHRoZSByZWdpc3RlciB3aWxsIHJlYWQgYmFj
aw0KPiBhIHZhbHVlDQo+IMKgwqDCoCB0aGF0IGlzIHN1cHBvcnRlZCAod2hpY2ggbWF5IHNpbXBs
eSBiZSBhIGRpc2FibGVkIHRyaWdnZXIpLiBUaGlzDQo+IG1lYW5zDQo+IMKgwqDCoCB0aGF0IGEg
ZGVidWdnZXIgbXVzdCBhbHdheXMgcmVhZCBiYWNrIHZhbHVlcyBpdCB3cml0ZXMgdG8gdGRhdGEN
Cj4gwqDCoMKgIHJlZ2lzdGVycywgdW5sZXNzIGl0IGFscmVhZHkga25vd3Mgd2hhdCBpcyBzdXBw
b3J0ZWQuDQo+IA0KPiBUaGlzIGZpeCBjb3JyZWN0bHkgZW5zdXJlcyB0aGF0IHRoZSBXQVJMIGJl
aGF2aW91ciBvZiB0ZGF0YSBDU1JzLg0KPiANCj4gRml4ZXM6IGE0MmJkMDAxICgidGFyZ2V0L3Jp
c2N2OiBkZWJ1ZzogRGV0ZXJtaW5lIHRoZSB0cmlnZ2VyIHR5cGUNCj4gZnJvbQ0KPiB0ZGF0YTEu
dHlwZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEFiaGlneWFuIEt1bWFyIDwzMTRhYmhAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMu
Y29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvZGVidWcuYyB8
IDMgKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYyBiL3RhcmdldC9y
aXNjdi90Y2cvZGVidWcuYw0KPiBpbmRleCAzYzBmZTcwMTAuLmFlNDkzMjM1ZCAxMDA2NDQNCj4g
LS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cv
ZGVidWcuYw0KPiBAQCAtOTEzLDcgKzkxMyw4IEBAIHZvaWQgdGRhdGFfY3NyX3dyaXRlKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50DQo+IHRkYXRhX2luZGV4LCB0YXJnZXRfdWxvbmcgdmFsKQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmlnZ2VyX3R5cGUp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiDCoMKgwqDCoCBkZWZhdWx0Og0KPiAtwqDC
oMKgwqDCoMKgwqAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHFl
bXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAidHJpZ2dlciB0eXBlOiAlZCBpcw0KPiB1bmFz
c2lnbmVkXG4iLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyaWdnZXJfdHlw
ZSk7DQo+IMKgwqDCoMKgIH0NCj4gwqB9DQo+IMKgDQo=

