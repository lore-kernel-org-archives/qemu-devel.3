Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E80CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjz8f-0004LA-7B; Fri, 30 Aug 2024 06:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sjz8b-0004KV-59
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:45:54 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sjz8X-00038E-A9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1725014749; x=1756550749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2qhw7SpukM2ZrM975zf5RNmUYw0vycNDIqq38+Pexeg=;
 b=ZmwtGKW7M7Ltta1ueOOPaPmxQ4+21I3lNlIjlLbxWbtF1AMcFOVDuMbK
 CmO06VQF0ACOslOgLftB8S18KhFgIaw/vuIwvHis9Ft5i9hNbdK4QCC5U
 H4k+u8TmEvmKmBsCVFZJdgmlC8D7NNEj4wYHeVrZ7NKO+cMjyAwfcp82j
 6o4zh3V/mlCKF3pjAw844aC+TTNurUU96t0Pr9ldVZjBiKJF0EeSajN0I
 VdLrdgWplXr7yQxqu4ziF8eoUkSHHAvUvFskiImvXgb/f1cugfrGPFiBG
 gUcmk2fjOgbdWEVJ5n6s00BlntqA0oc4a5DFKSOXHOzJoLFCMc9h7JhuS A==;
X-CSE-ConnectionGUID: wW64GmxvQzmNlmOIl4NGlg==
X-CSE-MsgGUID: aIWkuoxAQSi/fyvkTOZgvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="129816394"
X-IronPort-AV: E=Sophos;i="6.10,188,1719846000"; d="scan'208";a="129816394"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2024 19:45:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qST5dmTWrDKdxz85/8oGreKSI55tgVQ3+oafyie/p2Yj4OTDdQzs6uZ1phavuT4a2ehzEsXDJ1v6A0oTLbQcgCp7YBc3aY2vJflk967Ir4Ov4hg1rbDdJqu0uWx/yfPwKoT2Q59FQ0a/tiXwUN75waRf4AXhxLdtX3bDeZsp5idbu4u97+oR4wT8oKaqjlZcb9MfZtmvPrKWFeE3Pj+8q9x96hwz02GX4OUNh8Be07tj688riNXTuvTMhOt4GAeVbdxPrt2lFWftd1G1q18/PtrAP2tz6XuxCcu3lvsO/dDsG791jv3inkVC0Qd+th0SBpK9VWn+VUVdH6do2VWvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkgZFmEZzq9wjL+D3JO2nrRqC8FpmY5bY0MeIPnpUMk=;
 b=Bzf9hVGJDUmUrnLLjtuP13WYumnUjV3dIVMbk39nGee392aJxmR3RvWtkfOpF0fe2NHPv6V58JBrmqGsm5cc2RO9uLZuKbRVg3bN+qpMuz5krs4bBtVpp7j1CMdy7CjWIpZOqHAOUm5nwGM8bjZDSUwVCzFYoDLKoxlUm378TTB60ka1jcKV9IBHp81QauO2qldAV/b1El21YmtI7MU/OpX0B99qp6X3z9ZHoeIHBNoWVEPyS0wyrk0yff4oOMbsrJe1Vrox0K0W2oF4cEIdsTfxAS/P7wLhWqP5rHOmLMYZ95DL8pe6K2eUdbvM6xg5DTjJC2JOBWNxsYW6XDFXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB10542.jpnprd01.prod.outlook.com (2603:1096:400:303::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 10:45:39 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%5]) with mapi id 15.20.7918.020; Fri, 30 Aug 2024
 10:45:39 +0000
To: Gao Shiyuan <gaoshiyuan@baidu.com>, Paolo Bonzini <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/1] platform-bus: fix refcount leak
Thread-Topic: [PATCH 1/1] platform-bus: fix refcount leak
Thread-Index: AQHa+hTue7hHfS8SREGlaTlc5bFRWrI/ni+A
Date: Fri, 30 Aug 2024 10:45:39 +0000
Message-ID: <OSZPR01MB6453339D5F1BB3283E08B7328D972@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240829131005.9196-1-gaoshiyuan@baidu.com>
In-Reply-To: <20240829131005.9196-1-gaoshiyuan@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=51d43678-052b-4e29-8366-d4205f970c28;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-30T10:44:28Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB10542:EE_
x-ms-office365-filtering-correlation-id: 4a01cb7a-9df5-4f2b-c1fe-08dcc8e0e363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?RlN5ZFk5WVZsTEJlMmFmZUZjWG1mL3BidTdxUE50U3QyTGlUQ2lySmlh?=
 =?iso-2022-jp?B?bmpmWjdESHFzVHhwb0QyKzNqMGJjbVE3cnFQNm5yMGFpa21HYlVYT2d6?=
 =?iso-2022-jp?B?c0QyWWRlK0czYzNUenZGdWhCV0JCZ2MvOU1BUENHNXhpSHJxZWwxc0dv?=
 =?iso-2022-jp?B?cC9XN3pqK2RVQ2UrQ1NkcjdGQndDMTEybGFqRlpSRWpsMitQUTEwUmR6?=
 =?iso-2022-jp?B?azVlcDdhdjVILzlPeld3N2JtbkNiN0ZIdy9GdWljUkZvKzcyZFhiRTZL?=
 =?iso-2022-jp?B?bGhNUDR4QVFMbGQxQ1NZbXdTNWJQTkNMWHVUN1NhR1czQ0JBbWQzWkp3?=
 =?iso-2022-jp?B?ZDVpQjY5elZVUW1vb2Juclp2K1JNK0xmdFJkNnJqbit2ODRHWEVDZU43?=
 =?iso-2022-jp?B?aFlXNXVITCtrbGRnTFRncGo5NnRXd2FobHpUaGJZZXNPU01nK2VkdFQ1?=
 =?iso-2022-jp?B?bFBEK1hPSkRiUnJRRTR0NldFOXp4d2dSWVJiN0l4WWdYdE9yMzR1ajI2?=
 =?iso-2022-jp?B?aG1VQnJzUHlHNlladkxXSkFCSDBJN1IrbE5UTG1DTkw0RzkxMG9aRjFk?=
 =?iso-2022-jp?B?MEVXMEdrU2g2ZTJwSWpHdi9sbVY0TCtna0F1WDc5L0pLODFqK0hGaGdD?=
 =?iso-2022-jp?B?NWc1UGlvMkkwMkpJOGJuWEs5OGJxeXRqdnBocTRRakRXamhUamdkWkJ5?=
 =?iso-2022-jp?B?ODBRQkk1RUxpUjdoRGloeGtzaFhJQ0JuS1pRTlVKRzkrWW5sa1d3M241?=
 =?iso-2022-jp?B?VVJ0YjV6ZEd6WlFENkR3Z21BWm1rODVhU01tbjgyR3phaVF3aDk3RzJY?=
 =?iso-2022-jp?B?MFB2OEtpZ0xrcFJHb0VKM3lPMXNpWjBjcERLeDh6M3gvSWlXN1JkWjBa?=
 =?iso-2022-jp?B?WWVUQStyMldiNkhMSGF6bFovNk9FRnVXM2lobDh1TG80SVY0MDhBZ3dB?=
 =?iso-2022-jp?B?ei9yVDV3NzIxU1NCeEp5dHNyUDVxc0V6YlBiVG5tYlVocTZMVmVKc2cz?=
 =?iso-2022-jp?B?cElkaFFodzlYQklKdHZzd0hUbE1MNVpwSGVkNDMrUnF4bGxHVGhXTnNi?=
 =?iso-2022-jp?B?bDF3RDR2Rm94Z05qVlpKK3k4NzAzcUVhcjFzbWlQNHV6ZHRmazlOWlht?=
 =?iso-2022-jp?B?bDNtVFpIdkRodWUwZzQ5M2s2ZSsyMjhTZ21JZ28rd2ZocnFNa1J1TlpQ?=
 =?iso-2022-jp?B?U3RzdDBoSmFqRUk1c3l5b1BLQXNyRWFBODBmMmt0aW43NW5GYWYvRlcy?=
 =?iso-2022-jp?B?NTVRanJkSzZEQnAwOUJReWp6b2pkTVNsaEJ2TTY5d3ljeGdtRkxXZndO?=
 =?iso-2022-jp?B?cE04aEN3RmJRNmw1VXlJbnhsWkxDWGZwV3NKUnF4Q1ZHNVp1UjZiYmJQ?=
 =?iso-2022-jp?B?SkZRRndnaEltbC96YkJnS1VmV05iRlJmakZEdHNPaFFsSm8xUUVwWmtB?=
 =?iso-2022-jp?B?SFdabWdHTU1EMmJqUGh6ZDRqUk5zUEJqTkpSem5IVDhDTHlvU2lOcEFz?=
 =?iso-2022-jp?B?SlRiTEkwTEg0SXk5K3h3RU5ydWlDazNzME9EakdoQ0liTzFEUzBFR0x1?=
 =?iso-2022-jp?B?WGV2dW1hMlA4OGhzSXNTSGhvVlc3QVJMS3JxbzUybTJxSGhLKzQ0YkZu?=
 =?iso-2022-jp?B?Q2wxYnhkckZtdWlycC85cnU5QmtiNWR1RXg4RjlTZEtQenBjd245L2ph?=
 =?iso-2022-jp?B?cTZ2enRvRWpSalhNN1FUbkFhTEkwRVVnV2NkVmk3Ymh1LzJRZmNHYkVq?=
 =?iso-2022-jp?B?VndyTmozT0FKeFFoWW9PNzVxYmZEMUc0Z1BOUjdzRG51SHI3MGJCbEh1?=
 =?iso-2022-jp?B?TXdlemRWVFBXQS9yV2xubjFVSUxOWGdINnluQXNVNGZyNHZ3K2JyMUFC?=
 =?iso-2022-jp?B?M1BCQkdLZy9rUXp1cllxa1BoVzYraDNXR04xTHQwM0FXcHlGaU1Bak0r?=
 =?iso-2022-jp?B?ZVNsYkxvY2Ftb2ZsdkJndWNiaFZybkIyYUpuS2RTWlpBMWV5R0xjSzVV?=
 =?iso-2022-jp?B?b2JuQnFVR21MdmNHZFpzNFY0VE1WQzZGMTJ1NFRmaXJnRndpb2pDL0NN?=
 =?iso-2022-jp?B?UjZuNVZQY1JONlltSFFpa3c1dmxCNVk9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bDVrQ055cmpLZ21zeGFRRXR2ekFSM1ArRkZGV0NmQi91WEVaYlhPeDlL?=
 =?iso-2022-jp?B?ZzF5dzEwM3NHWHc0Z0xMSTNHR2wxY1FXUmpLaGc4SHJ3RkpjUVdhUFZT?=
 =?iso-2022-jp?B?ellBZkZrNGtKZzlWMWdhaGh6YjlVeG1GTXpPYk80MTdBZE8ycGxKRWVN?=
 =?iso-2022-jp?B?U1pod0hCd0JWL0cvQzhWeW9zZFJ1Z1BaSWJoeGt2TkczQUkrWHowcXpx?=
 =?iso-2022-jp?B?SHpoQkgrR05LbUlwZ0J6WFhiRktuVXM5YlNvQnBiY0g4M0ZwcGJocHly?=
 =?iso-2022-jp?B?dDRNWGJ0MjZmR21EWkdvK3B2eWk3eFVJVTFJODQvZzF3bmtQOWo0OTV1?=
 =?iso-2022-jp?B?UVFVMFZTbGYrSHBaYnJRTW1xWE0yQWRMQVg2WitZTlR1QUN3N0ZGaFY2?=
 =?iso-2022-jp?B?ZnMyaStQUzFpRGh4bTV4SmdYaWI5MlJraWlVbUF2VUFTSDhxUlZpb2xn?=
 =?iso-2022-jp?B?d3hIM2Y0UjVqTHYyS2dudWlXU0dNWFNqVVc3SmZWU2huaDEzMzMxeXlm?=
 =?iso-2022-jp?B?U2hOaWVId3VCd2lrY3NzU3l1WGQ4NWI3Rk5xbFFwM3cxRDZXNm1Za3Vq?=
 =?iso-2022-jp?B?dExEZmhLZ1RwL3dKeWlSQng3VmRNc3FqYkRlcHpuaDYzUW9SOCtWK3lD?=
 =?iso-2022-jp?B?OUlENFhZb3N0T3o3MGNtYTQzRmNPZEx1VUxlTXNBSENhcU1Rdk5KcWYx?=
 =?iso-2022-jp?B?UFI3cEFXSmpFVjJPNzAxdUZJQkJtbFFLcm5iemF4eDJhcmE0ZmwrbjJK?=
 =?iso-2022-jp?B?Tmd6V3hpdHJuQkZKWHdCbTU5am1TeHNhZjVjaWhpUEtpeGZhMTlIUCt6?=
 =?iso-2022-jp?B?YlBreXI5eFVGeXhPQ1dYQzBHRnFIZXZDK0kwM29aZUJCbXFBWERPbC9X?=
 =?iso-2022-jp?B?VVV0UjNLTlFma05UTjcraUZIZ3R5bmRwa21JaDEvS3M5aTYrN1A5QTBN?=
 =?iso-2022-jp?B?bEk1a1IyMjZsQzd0Si9LU1Y0YXlPRjZTR1I0UGtzb3JtaVcyaE5iVVJJ?=
 =?iso-2022-jp?B?eXEzWEh5YjRpWHJIMnlHMllxMnlPc05nY3JmVjJEc2RTSjVDTVpWcXBx?=
 =?iso-2022-jp?B?eDRIa0poUFNVT3dKLzFrdWxmT2FqQXo4UDNUa2pLREZGVUNRbHJSaVAw?=
 =?iso-2022-jp?B?NXVPeFBCWEk2MWo4S3lNRDJLR2FmRzJ4VGFlbW5UNzAzTENVZ3dwR3BK?=
 =?iso-2022-jp?B?TDJJZHhNVmFFeDhtemEvYm4xdjEwQXQzdk1OMGF0MFdyS2N4L0ROSnlQ?=
 =?iso-2022-jp?B?RG9JSmp5TGxUSlVVUDNzR3dOUlkzdHBoK2VTVEk2Q1lyUEtSeUhOcE1v?=
 =?iso-2022-jp?B?MjNZS2kwYXJsbi9xUEowYlVRM2VRU2V3ZncwVStOd2xvczJlbmNJYzRF?=
 =?iso-2022-jp?B?YkViMDZRNlkwZ2NiWkl1WEdYWGUvVnN5My9LZVZBbTF1T1R6c21rWDZM?=
 =?iso-2022-jp?B?YW9sTnplbE9COTk0T0l6UUx0VklhalF4aDNJVlVTL0gyclA0KzYxVVhk?=
 =?iso-2022-jp?B?REk0MDdMS0VPTDZhVEJ1b21kSkI4OXhBMVJyb3VLcDlDMTF0b3hLMnlz?=
 =?iso-2022-jp?B?SWhVdWhJWks4dUh3cU9uaDFCanFJMmlhN0tFMnFnU2l0ZlQrZnhhWjlS?=
 =?iso-2022-jp?B?K0xoakpHMDQyd0lVaGkrT0wwZGdxQ2ZNY2xXdmQzVlJsREdna011VDNR?=
 =?iso-2022-jp?B?L1BybU9Qb0l2aWhmYlZPVkxtdGE4anAvRmVWT0FSakhFMFF4dUEyYVEy?=
 =?iso-2022-jp?B?QXI2NjdkVWZ4eWxyN0NYTVpSd01PUEhFdGhMelFnUFMwTEN1OGg4QlBS?=
 =?iso-2022-jp?B?ZUV1N21Cdm1WM3I2ZjlPbE85Y1pCZ2VhZU9LODBEUzc4Ylg3YUdkVmto?=
 =?iso-2022-jp?B?ekpkUHhSbEVTWjFKcVRLS3hVd1FmK2hvRldPNytHSVRxWlhsQ1ZVbmRN?=
 =?iso-2022-jp?B?OG1uWFlzR0pnSTErUUU0TkFnUUwrNTR6ZVlwVEdkQlhZdEZOTVh4ak1Y?=
 =?iso-2022-jp?B?VjhmUmJVR3VtV0N5bkFpOUUvb1Flc3F6TWJUTVViSkpMOWpnamZoMmFI?=
 =?iso-2022-jp?B?bkorKzhvbmZHZC80ZEwvclpPby9CL1l4QXI3c2w3MkFGL3FzRUwvKzZv?=
 =?iso-2022-jp?B?aFp1LytFOGJ5WndlTk5SQy81MmlRK2cwRFhsbzdPQmo4RmdBUGZ3aVlt?=
 =?iso-2022-jp?B?dzBvckZIR0xOMHJHTzFvcnU0ZWxrdkhmM1FScXlGM1FOQVNmeVFGZFUr?=
 =?iso-2022-jp?B?QndCN1RodDdRc0w5dFFnRUhLWXp6UzFSRTBJV3FDcTNGeDVqZmUxTk8x?=
 =?iso-2022-jp?B?RzlIKw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zGJA0we0ODyFU8WvtQ1UjiWl0kHQZykt/TNh7z8TIg61/hgBrgQDhTHE5zAr6pIaewZ/XmBejsFUXb4XPSXe44BD3OA+9nIRkORWOSSWKhFOPMrZ7fDZiLK76vISImdG31GJNOLcDfZlVbiyKaaebGHtpUGrl2T1DX9Mjub88KI4H6VGxuKHw4UohSxW3tPk4PUtxHvGN9+NehUbWIAo6VLjJ2o32bbBtjhiBI5cfDhktKy55KfvSemogG6NDU+MhgZ8NXURZbD+TI+PopeoVCLL6/m9NDbOHBV/f/dn+V6r/ET1VpeDCJVBPfhmqMauKj4UVFpghdJz2HYQyVchUa2uA6M2f4hnW5SsRpxGgqAmFNt8XkjxJQmleEwyfJrGgFGt9u1YhJ1qSMwOCcOXnfsBkDmorvhdGKUUV2KZmUWFk1QcWIzK3nmWk1YCpCayLjNafjJ2zAaGedXiGzLSuFBs+Tst77lOjELrhurejlN7S8pcDAwdGuhBUBm6c3r0IGu76ng5GI9vZgKTognGiQHChzGGcG+2Q52GwpJb7Aq6iWSjQGnPn//dubQP3rTyvIiiJYf3yqsvmewW5sjDb/+0NI2xYqVfCZTetnmMTUqZ02uRTqWspeyTqE1tCcwJ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01cb7a-9df5-4f2b-c1fe-08dcc8e0e363
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 10:45:39.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19fBirzFeh7bLZRS8DzScA2VlDuVcrGdIlqATEgSY8CTGuUG8Kv5X6ES1/s9oII2dQzuEfgKQaIlZhq+J+I4nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10542
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Gao
> Shiyuan via
> Sent: Thursday, August 29, 2024 9:10 PM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-devel@nongnu.org; gaoshiyuan@baidu.com
> Subject: [PATCH 1/1] platform-bus: fix refcount leak
>=20
> Temporary object causes reference count leakage.
>=20
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> ---
>  hw/core/platform-bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> index b8487b26b6..dc58bf505a 100644
> --- a/hw/core/platform-bus.c
> +++ b/hw/core/platform-bus.c
> @@ -145,9 +145,12 @@ static void platform_bus_map_mmio(PlatformBusDevice
> *pbus, SysBusDevice *sbdev,
>       * the target device's memory region
>       */
>      for (off =3D 0; off < pbus->mmio_size; off +=3D alignment) {
> -        if (!memory_region_find(&pbus->mmio, off, size).mr) {
> +        MemoryRegion *mr =3D memory_region_find(&pbus->mmio, off, size).=
mr;
> +        if (!mr) {
>              found_region =3D true;
>              break;
> +        } else {
> +            memory_region_unref(mr);
>          }
LGTM, but if the empty region is not found, the process will stop running, =
so I think this bug may be not
serious.

>      }
>=20
> --
> 2.39.3 (Apple Git-146)
>=20


