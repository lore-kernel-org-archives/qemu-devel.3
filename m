Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CBFC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzlSn-0006AB-F6; Thu, 27 Aug 2026 21:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlSl-00069r-PA; Thu, 27 Aug 2026 21:33:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6935b7a9c=Alistair.Francis@wdc.com>)
 id 1wzlSk-0002ek-0k; Thu, 27 Aug 2026 21:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787880777; x=1819416777;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=uYtSKEDpWL8tls61Spzj+SQu0lSXYB9V0svoLJkHjPs=;
 b=q6R5ongdgLsKN2HTWX4MNNDZEwW7GuG78dIqCsY3VpQYaR/BIgeFKBYz
 fIwr6O9AaKuBxrKF4O3DTJUHlg144cZHn+E9LXJxq8s7yTGm/Tf0DcPJd
 dUOJOwAumKAwZdZC8CQPYL9EmpB2LtP7rfSlYRhRJ3p4N3G6g1+dQrtTi
 i+IfzMKTlDqjEKCmPKs+K/rXxHI9BGAoXDTIxBPGosgjYOh8DPS8U5Ucs
 pkQ0Sr/svGUVfHKefqK3epsdUr9io6kd632ScmQvxUeVWe0cGCk0cdWzx
 EeCJc89bPttXC8ewDw2axIx9+zGidMrAzwvcKYq/jVfk1Gz9ABxgcmOjQ Q==;
X-CSE-ConnectionGUID: H6t7rv6sQTq6fGe2XPOKgg==
X-CSE-MsgGUID: vJTQolOCQQ2u5sftQMTkvg==
X-IronPort-AV: E=Sophos;i="6.25,247,1779120000"; d="scan'208";a="153468635"
Received: from mail-westus3azon11011000.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.0])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Aug 2026 09:32:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9OwZho84zgOigdClQTgs+VRuXCE7rI2/NAWtfBf2mZBKHKIJkVDY+9l2sV28E1ToG2HakPcUzpiCE4gf1HOtmP5KddzERo+sW7lyTycduqclPDCNpPkEWO0vQgiD8nXx0th36zEFW909JDJSTJmtckupEvNEc4swHKJeW3Gwgycx/mD7hBHT6I1k4wfSsIZ+ldLMkpVRdcloaWlEDCLPDXjC9BptF+QDQSszTxMRNCn6osfx1oidE+MwUb66NLyeC4Yt+APACd/roe/T39ItLRAIOhPNP8a4115D8NqHgekwLXLNeEpw0odqMUK1dGuGoXyiwuk+RM+5HCfkz/OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYtSKEDpWL8tls61Spzj+SQu0lSXYB9V0svoLJkHjPs=;
 b=hF1hoA69U9ezg+lST+Ct7n4OVXR45OfAkeh3s6C8aP5tmTYRdm5H3r4mJg0xTiyyEG9EihpYHaFnkCsLjXXX/U2+a8NbpBSFQJzbj5gGsOILuLpu4PDDQ9vYDe/eQ7sq/LfeGgk5Z/QIVjx+4mbPdYBeazNJCTZAC6obzSFwskUW5R2HgyMxMtmxqnuU2qWwfZaapdkHrfuzC8N/3/krEfR//uZsAQamKOjFlsLgCl720dMd3ECyAG7OTXxpC7iD6a9yrYiq42E4vbX2nDg0YSKY+jpEmCU3wv+8ENwF8t02Wxh4VRAGdJHFVrLL8hYm+sCNBzr6HKPBKuCAVX9ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYtSKEDpWL8tls61Spzj+SQu0lSXYB9V0svoLJkHjPs=;
 b=jfvM8Pf+j7U1jDeNJzjJMQHMtAu9igkxWsIa4X7kEuE3toTjvE7+gYVFTspJeNcQAudztlEY0/4uTHz5rL0VGy4rM0Lr9VhiGjnZtZHvdmexKgObPun8YNIJx4JGNARMkpxpxNggPPcoJinbu8DnZrzeSf4yMhD4hpvhxjNeDEc=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BN8PR04MB6307.namprd04.prod.outlook.com (2603:10b6:408:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 28 Aug
 2026 01:32:53 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:32:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "xb@ultrarisc.com" <xb@ultrarisc.com>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
Thread-Topic: [PATCH v11 0/2] target/riscv: Fix riscv64 KVM migration
Thread-Index: AQHdJzTKnXWNXBjrB0eNTYcYF1SO57aucSiAgARatwA=
Date: Fri, 28 Aug 2026 01:32:52 +0000
Message-ID: <c48ce6b9562eb4a1a759c845adfb5c2fbd21057f.camel@wdc.com>
References: <20260808125157.1220511-1-xb@ultrarisc.com>
 <20260825070309.1086125-1-xb@ultrarisc.com>
In-Reply-To: <20260825070309.1086125-1-xb@ultrarisc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BN8PR04MB6307:EE_
x-ms-office365-filtering-correlation-id: e06c1be7-f5f5-41bc-ad5b-08df04a4476b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: ualSaveOJYH1JIPhRaocXXUW17zWj9yHKLMnQV85bBWb32cbOJnbz6bVqoQ+2pdcd/iOAo9pyPYJs/QjbvzJMOzJO6ACeqiy2EDUBooRSQHPqM+tMDbRgHmjaUzHSgjLBNlF3LqI3I+XXDAuqV0gPSJwwpvyILPmNmkVJ2syoalDEQZD7SBY9O0uh54qpODMSBCutD4okyLOJ59iSVkHyZ0Gt6BwFPv441RMU+c9dt1llaGwLT63PwLXHMrrPR9uHuc+RNyyuFhdTc/iGH/dt2JrDxWFtqfE2TB2+XboXOuu6LhSz8ST0ShKnE5Z6gqDgu7rQKrcVCSNDdBgF6YlwQerlPYMGtnQmBn0HVat+RlYWqD878X9wlXInWObBwIsWM3RqLjYzZp+jhixw9GsCsfVjdbEoYWM10A7x9YTjf9KCuK83WLcP3eOLd+/+OWsb8+uU8qwsgn8YvFtZAhjmB1q/BsDhdd7SQg3/AkGA+faFUir8SIWpKs/6XFX8mYIhTFmpP5BECQs0CO1u9LZtsSZmh0nuAUEBseVQo4YXhlPX5+1NXhA7OHd7+IL6gH3nkKEfwUarrAwcrQUj3bQ1VNKMwS7XkTngrOPV7bowYx9xgyqtqyNmYAbUWlTVxvhXgCgqXWaJBmTolLQIqSSU3R5keWH0Vq1Jo2xViZ5EQcHj+yjRK/2IxEHTBBZxTny8VDX1x4UzoXXAwUI55iOhe9XVITiMEBdYjJPOj6TKko=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkExRDB0NDJKbVBNaTJ6bzgvR1ovZEdxRWIwVkpyUUNYVWpPcEhaV0xTdjJx?=
 =?utf-8?B?N2lYSERXaVB6akNWTVM3T2tHM3VBaXJ5WHRlUGVPRlE5ZytaQjV2YXhjR2g0?=
 =?utf-8?B?NFAyMk1yZUNYZ2I5YW1qZElkYStMa25rUnltZ01Ta0RqVzlPSE1POUdZUXdv?=
 =?utf-8?B?TEVTZi8zdHJma0JLTWNpbzB6U0tzT0pVdHQwVDJFTExxaDYwdDN0WktPckJN?=
 =?utf-8?B?OGVLNmU1eXFGT3ZyMWRNb0NSU1FwMnVLT0FvSS9SclRrNTNzeDJmL3FVUUN6?=
 =?utf-8?B?bXkvTXpLRVh6dStZV1ZTUnBiSkxaTVdLdEduS2d5UUxOamQxckFSTUhncFlu?=
 =?utf-8?B?WTNoa21zSnA3SmtrV0VNTlRNZFBQTXpvdEY1cDhveTdKUDNETGN3UWdGNXpT?=
 =?utf-8?B?SmhFU2d0N1JodDltWmphM25NTFYyT0dxbU1tdmhzSytsL04zckVKbXBsbWlI?=
 =?utf-8?B?dkRsYU9yaTQvQUxIRG9jcTZVNTN6RnNLUUY4SFBhN3ArTTA4YlFEV3I3Z1lF?=
 =?utf-8?B?ZjZIaEs0bUF1T0czUFE0QnA4bEVVb0VCMEZRWXhTekx5WmlERXJSY25HZ2dT?=
 =?utf-8?B?bWpCK2hkcjBhYi85Wi9VTFpHaG5La1RXT2ZFcitVaWZ4ZzVScVdnSVdPZFNo?=
 =?utf-8?B?Uit4V0JRMldQdXp2Nkc3ZFJ5VVAxTWswOXhHNEtneXRZNzNhUzFBUUUycW1X?=
 =?utf-8?B?RW00Qk5sbnlUVzdJeXptNEdxWUhVSjEyRjRLL2dXMUdBSEFDNTc5UkRKeERS?=
 =?utf-8?B?YVgxSlNGdEFxazlOcGhtVFJSV0NlYVB2dWE2c0NZS1Ywd0JGbURQcENzMWRI?=
 =?utf-8?B?Y1kyTjV0STk3Q0NDTnZIT2VuSmtEam1ITDVaYWFGNm1DU1I3N2pNb095SkUy?=
 =?utf-8?B?cnZTUGsyRDNZOU5CKzdNUCs0ZHk1Nnk5b2MrY01TdGlGa3pzN2h5SEV0blh4?=
 =?utf-8?B?QlAxemt2YUg3WVUrM2lBYjdzbys4SXdoVU8rRDNSWEZ1V3B3YVF5V1BoUFFi?=
 =?utf-8?B?NFVOeWtBRWtRbWRDc1F4NTlvbHg4Y1BBZE9LVUYzY0hJRjlWeGl4NzlyTUZ4?=
 =?utf-8?B?TXlncU9HZjRiRG1NeVhRNzVJRDVTOCtYdTZPMmI4V0x5Uzh4MmF1bVR5bGFH?=
 =?utf-8?B?cEU5Y3dSdzJqdlVNOHF3bUpheFdPeWVJdlF4Skd0emo5SFB5L0tpeTVpVi9W?=
 =?utf-8?B?VVZoQ2NBdnFzc3FqOTVBaVd4RExMSGFWVGZXUWhMSjhuWFJLdjgzNG1BbTdn?=
 =?utf-8?B?VTlhNUZiUHhpMWp3RHpCRWZPNUc0cGZPUVRPcS9pZ3JtWjRGaVZBMXBqTit2?=
 =?utf-8?B?R2FnaVNlV0ljaHdzWE5EZjB5SXZmbDVsbjEra2ptdUlPNWtvQ3VxSndzd2xR?=
 =?utf-8?B?TCtDa1BKN01ZbTdCU2NCdlRQZlhsUnVRa04wZHRMRzVwVkJBVStDZmd4Z2Rn?=
 =?utf-8?B?L3FrNFRaQ0daY241eUI3VzJCMVdiSGxzWmlXM1c0cmE0ZEo5anl5R0I4SHpB?=
 =?utf-8?B?dm9Pd2pyeklzUmVzSHpXeGpycXRWMlJpUGdLaDhyamswbmJZOGgvT0daWXFX?=
 =?utf-8?B?MXVOZFpHOXFFRWxJNEZHaVRDMkhvUmI5aExNTlJpQi9sNXRrcFQ1WWtPWTJz?=
 =?utf-8?B?MFNRbWkyNUlmMjR6Z2VrTWxqQXhDczJvcW55blE0UEdMaG1pUmpEN24vdWlI?=
 =?utf-8?B?dHk5c0pzdTlVS21RY3YrT2xIc1Jjc0loTzdrTjFRNXFnZGQzZk55WmV5UnZs?=
 =?utf-8?B?TXo4eEU3b2FQZnRBRm1ibFR1a0U1TmMzVHVxTlNaM3VIaUI0bHpvdDg1WllO?=
 =?utf-8?B?blNVeTFvck9KdHc4TUl4dWpwUWRKUTl3aWxOcU1yaklNMUxNcld5TS80eHQ5?=
 =?utf-8?B?eDMrN0RxaDdQNmhzOHgyNnFIRDBLZFFQMyszRkxIS3lQb2tVTmVLckR3eUM4?=
 =?utf-8?B?bVplcVhzbWF6a2NtdWVhU1liTkg3VmgxZG9PZjdETlpKM0ozSStXdnVZSU9P?=
 =?utf-8?B?UGFMWTY2QnUvZWx6QXBocExtbFVsNkEzUlBlVWt0Wkk1ZGNFOUFmKzVMS3l1?=
 =?utf-8?B?eGJGQkJqeDc4ajJjZXkrZjJ6ZWZCTVQ1NUFzWXNQRkhibFZCVVhpVTRFOXd3?=
 =?utf-8?B?ZXVnVksyRXBOREhHN3JrS0p1a3dST0t1bDEvSlhmaXNGZUU4M2x0dzR0WkhH?=
 =?utf-8?B?dStHQ29KMDN1R2xFai9iK0VwRTlwbE5nZ2prVGdjVW5PVzdJQ1orYmkwck44?=
 =?utf-8?B?TVNMMVlwTk5ZQm83ZVY1bnd1UTU3YUpKanlPZUhoTWhBTGZEaGNRdllsR2VU?=
 =?utf-8?B?VGFSd1VsUFIvcVBxeFRSNmFGS3RQRGxUL2d5WnpKSkFYMU1KbHFhUmZWeCty?=
 =?utf-8?Q?xjykD5E1rp49z7PWUi6vee5K+tiaArbAdw9ZpvZ0xbmh7?=
x-ms-exchange-antispam-messagedata-1: B51advD9lo6c4jBy8k3BTPkg56jMUYH+SUw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <755E0C42127B0140AAAC657B62CFE7DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yQ9M0L+i00wMQ72xBj6R8yXZslEvJTa+SVo0LecR5k4xKh0fCrCD32Sx3XME1Y3ntNHnm+IiDNzkVV1VMZGpPrWW3HT+XS/x3LMo5JE9/m3b+1GCEHN6Z8tHQz8G5iJLft+vmSSLiy07wuOSEWNy3WJc4kulOuuUWXDKThRstvBAFRSMeA7BMJ+OlA5jhPYvgZf92L61Um4On/fityDHJn86TcbnpKl6yc3t9DHXkcK8m5ruVHjT4InTVDJAyhhquzBNq7qD+e9d0iYlGSgdWi+a9XalCK1OE7DALzOh9W4XlxagP9uKlrgNoVaUa+0nLq0YLHEj8rKB/6Gcc8I3Wg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QsS+lVy7f5k54xTTTRNXSazpgrmSxaxhpJ28r22SBy8f9/s1PvaKugYOgzkk1qak11G10qbiMFUTubZDYl2VVHfpf806WFcBVa3SOrWcAL39OcTIQb4K1b1sysXHBRwQlX/vq0kYbEfKedRrqGZ88RQldeZ3U7Y2nH6YoLjfZgbItKtvbbKjrKFT3xYuChjlT5mz86B9plsT8l1j5mYV7PFoi39hJJVUGb+FOusMdDuVgXnhqD21grBLCDhPed/GOFMpMMyUxgVYYHoOr7DGBwyRnsZpNwGRaLMQIyO8Gj7KJ0JIPPRxwbF585coUQH9diayiBTQj0W0HraRE7qLqXcDW8e9Dj/9OX9+bW1onvNuMUZJU0ZvC24GWcvZUgKOvHhPZPPhkXtCg/JFOYF0D26mVy/2j9yNlI3E9cQuTGzpN6GFa4uTGkzagq+p7rsU2QkCWrG8NRYIn9AqNINPOtZxJvm8FETPIZnCOASTfZumCa4Tji2/LU+bprAWylSbFY8uZeDbK+O0n1KmT5IsmTxrta4s3vSLapGHF+s48rtl4rYFb2Ga0vXU6iDRgqTmhITjrdheB+LmpYxw2wU7o52THAjQ3qjM5xnkGNYEDMGY/03J1h3qg2L+K5qNWoSx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06c1be7-f5f5-41bc-ad5b-08df04a4476b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 01:32:52.9200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mh4YenS9glLY8tDBvdfMMy1bGBUkex3++q6812PShqeGmAnmxtrPhCCuDaA1Ql8m3qQ+NRIU26PC6J2RlsPeB094j2cbaOWQKvSscPc9uPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6307
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6935b7a9c=Alistair.Francis@wdc.com;
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

T24gVHVlLCAyMDI2LTA4LTI1IGF0IDE1OjAzICswODAwLCBYaWUgQm8gd3JvdGU6DQo+IEhpLA0K
PiANCj4gTm93IHRoYXQgdGhpcyBzZXJpZXMgaXMgaW4gbWFzdGVyLCBjb3VsZCBpdCBhbHNvIGJl
IGNvbnNpZGVyZWQgZm9yDQo+IHN0YWJsZS0xMS4xPw0KPiANCg0KV2hlbiBzZW5kaW5nIHBhdGNo
ZXMgdGhhdCBzaG91bGQgYmUgYmFja3BvcnRlZCBwbGVhc2UgaW5jbHVkZQ0KDQoiIiINCkNjOiBx
ZW11LXN0YWJsZUBub25nbnUub3JnDQoiIiINCg0KaW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBUaGVu
IGl0IHdvdWxkIGhhdmUgYmVlbiBwaWNrZWQgdXANCg0KQWxpc3RhaXINCg0KPiBCb3RoIGNvbW1p
dHMgYXJlIG5lZWRlZCB0b2dldGhlcjoNCj4gDQo+IDdkZjlhYTUgdGFyZ2V0L3Jpc2N2L2t2bTog
U3luY2hyb25pemUgcHJpdmlsZWdlIG1vZGUNCj4gZGRhYzdjZiB0YXJnZXQvcmlzY3Yva3ZtOiBQ
cmVzZXJ2ZSBNUCBzdGF0ZSBhY3Jvc3MgbWlncmF0aW9uDQo+IA0KPiBUaGV5IGZpeCBSSVNDLVYg
S1ZNIGxpdmUgbWlncmF0aW9uIHdpdGggbXVsdGlwbGUgdkNQVXMuIFdpdGhvdXQgdGhlDQo+IHNl
Y29uZCBmaXgsIHNlY29uZGFyeSB2Q1BVcyBjYW4gcmVtYWluIHN0b3BwZWQgYWZ0ZXIgbWlncmF0
aW9uOw0KPiB3aXRob3V0DQo+IHRoZSBmaXJzdCwgdGhlIHZDUFUgcHJpdmlsZWdlIG1vZGUgbWF5
IGJlIHJlc3RvcmVkIGluY29ycmVjdGx5Lg0KPiANCj4gSSB0ZXN0ZWQgdGhlIHNlcmllcyBvbiBu
YXRpdmUgcmlzY3Y2NCBoYXJkd2FyZSB3aXRoIEtWTSBlbmFibGVkLA0KPiBpbmNsdWRpbmcgbXVs
dGktdkNQVSBsaXZlIG1pZ3JhdGlvbiwgYSAyNC1ob3VyIHBvc3QtbWlncmF0aW9uIHJ1biwNCj4g
YW5kDQo+IG11bHRpcGxlIHJlcGVhdGVkIG1pZ3JhdGlvbnMgYWNyb3NzIHR3byBndWVzdHMuIEkg
ZGlkIG5vdCBvYnNlcnZlDQo+IGd1ZXN0DQo+IGhhbmdzIG9yIHNvZnQgbG9ja3Vwcy4NCj4gDQo+
IFRoYW5rcywNCj4gWGllIEJvDQo+IA0K

