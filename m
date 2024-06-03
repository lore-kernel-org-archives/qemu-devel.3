Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA000C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jm-0006oV-Oo; Mon, 03 Jun 2024 02:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0je-0006gB-5p
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:58 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jc-00072M-6L
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394396; x=1748930396;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3iGn8iTNBgQPofEUaGJboBsdoJafrIzD0MJJvX9ZvNk=;
 b=jvGMQsa072dGf2LQOUtoyh9n0IRX0MY/CqBJksFor2+SDVxoeyuns5bY
 dZILWau2ZxL0qBVUiJdJlgbFgvUgfNKu2WrrG6yHfuq9v2XbbaELD5YoN
 eDTi9urBa6jd9xoFAE8tB5Mv1qa6ay+vg+favYSLHxKcdDAWCpY9wETvq
 uSYOhz7cTrtifP6Ye8j+/0DXRV9W8uvc1u8jr+QzDpd+iWWqh1a7YxBOu
 gFCdoYu+6hv3xLhmv5NYhN4sjG2r8ig5ZU/tuQIAjp6gMQy+XhYYEaiSY
 MvTyINKAR2wVdwiKEbAeO9Ri/AvhYJE+Hj69E9I6lttmZW+3u9/JVCPX5 Q==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763247"
X-MGA-submission: =?us-ascii?q?MDGKF2e07mPGcTeH995K0EDXBeG5TS+uvNrQv4?=
 =?us-ascii?q?gEJbQZctbhJgnT6zdAdoslSNR21fpvMsa5fAaOM/jRz3dmTw3TopwqHb?=
 =?us-ascii?q?NzFCfFrl212+B+jA/krVtGXINjbOqzhkXZZIxboPnrJCTP1YEWyMxeig?=
 =?us-ascii?q?/ySoJ4YzcIFdv/0K0cFJydBA=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQvut47cWXXHlJUP1FR6d7m6TI+UqefBobnlz53wfVQREZAWfse+KU+eunVW1oALOUKD/7J4W2aZj337hgZJ4EQQlET2A9UUte9h/QC9T4gm6Y0LDLm1xOWzsTptd6BWPrD1Y0SWSB+BIx+C1pzuLmekK7wZUbaoTl/Zu6EZLJf8Md1eUa2F6rQ/pBWl50vUO5+GxUWiJRuhtwrq+UTpPnldNhKEHvlZgoyr0ZPyBPML1HLTtGQsc5yzT96VwZSCY1ExsC1nHu7NRO1jDmmsV0/1YaBO2j3hI6TU0wCBtitiD0spXP16mHJ3pPiJlBX0oUQKzIln/2KaE/fPH/C0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iGn8iTNBgQPofEUaGJboBsdoJafrIzD0MJJvX9ZvNk=;
 b=WBYV69HMqPL93JhI5fvq8PyBXeJF7EqSlBPqC2vnPPXTbtvVbTx2iTVrnkPbIDc8QNg9ZUUdMCnNaTSnPXOmLR5Rdg8+lXHreEHlObAArGSOa+FFIXqXnLwym7kaQIoYkDPxpjmXFShjePG2KFgOXp1tJDOMtLOZgMM23AD6+Y33uNRcE9nYo2KsGRvyDlj0YxPXprybcWtUOmMOxUsHy+FvqQZMWfIGvmyutGR+HHfqpLUsaXUWjOH7/NMflH17k7kaK/OAimYvWLrb8QQo+i/wSle91ucM4jEp2LX9YezzlBFxXSvp/MiGe/LntGy8vl9AQO7XA+0krczGE77BOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iGn8iTNBgQPofEUaGJboBsdoJafrIzD0MJJvX9ZvNk=;
 b=B8YyyqlgZo1UJFQYkd5k1jQT2RNBhEWPzLPysUSvOEX9hYjOHURI7hgdW4HnK0lkfX9GA8E8xRJxUKB6SWhKqpstlreSNiCv7z3/lMxj/LyVjW7PhN3pI5C1L3iLlQTEyJXTv3aCfeBZkshIiAFaIaT2jol6rUXL5+QAXaXqYK2gNReJCW2UlNLXyQkMuK/Lx4e0UnpE9eIcdH9hNG/XXTSkmaSLzuSOyOBEBEgGW9w3HcMiSeUpbdrVbNkBttEvn4eUUZ+YfS6DyNDlMzMLfucAtXabLTudvGegVEnpI9Ou2jR8KOVThXExPlBKd86iTOGpuwBjuuPELhhrCNsTeg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 12/22] pci: add a pci-level initialization function
 for iommu notifiers
Thread-Topic: [PATCH ats_vtd v5 12/22] pci: add a pci-level initialization
 function for iommu notifiers
Thread-Index: AQHatXs9hOklV2j/n0yx4sycS/sVhQ==
Date: Mon, 3 Jun 2024 05:59:48 +0000
Message-ID: <20240603055917.18735-13-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: bcfc999d-997e-4c64-daa7-08dc8392605b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dzVBMG4rV1dhRFlTYzRiWEJyYmppQkZsclhtMXNoV1JTRXRHUWY5NGdKWU9U?=
 =?utf-8?B?dDJaTnpyM1E1MkdFV2pTQmNrb0xvdktkVThZYURMM1dNa1lpRXc1aFhYYzRk?=
 =?utf-8?B?NGMrR1FNY01DckdiVGtndjRJYXcrSXNDeVUxYzQ2Tnl5RmJ1U0tCT1Q3cW8z?=
 =?utf-8?B?Wkx5R05CNURic0VhOGdzWDlzZzVubCt4TTIvM3hodlI3VENUVE1pUGgydzJ0?=
 =?utf-8?B?NndJeGluVWtVcVA2SWVNTVpHb3hSQkZVSDRrQXc0SmQ1elpqazRYM1ZVY00y?=
 =?utf-8?B?YVp6NTZOd2VQeFEyaVpIbk1rRXhuRnUxYlV1Y1luVHFocnQrMC9BUnVaakxq?=
 =?utf-8?B?MVVqZGk3NjZkTGlHck1hNmQ1R21kVk5aaUk0dGc5djlISHlJdENRSHNrM0Vh?=
 =?utf-8?B?VWVmWGVUTkNDZE1ua01vN25oZWxtNlJhQXNmenlPQVFncXFMNTZJK3l5N3hK?=
 =?utf-8?B?MVR1ZitxSjdnWTdrL0FZWmx6aHN6ZkJPWnlDVjFsNGIwMXZmRzdOckE5c2Vm?=
 =?utf-8?B?L1dsOURncHJuUUp5WEJMOVYvdW8wajRTVGZreUpDNjhKSUZyQklBUmExaS93?=
 =?utf-8?B?anNoeXZXOGpCdTN2UlVRV1UzdFZTWFVlbStkMUs3U2d4Q1kvK3gxemYySzh1?=
 =?utf-8?B?SVVTMTNMeUl3VVJDRE93SnFsbXBOaWpWNVJHUk1tdDRuOG92ZTRyMDE3NERO?=
 =?utf-8?B?RVByWEl6VzAzQUF5YkxmYnRiTytwd1hSUktKZ1BxMnAwK2IzdEthbTBIK3dD?=
 =?utf-8?B?VDhSaDFVUm55YUhNQTNVRTNXeXFJMGdEdjlZUHRVYjd4SVpqbi9sOVlPTkRt?=
 =?utf-8?B?WHNnbHpBUWYybTUvSVBMRjlReE5qMEVYa0kwc3d0VDBIeDFtTGdGU1lwcHZX?=
 =?utf-8?B?UWpoODAzbWtPWkFDK2pXLzBDYzN6RmtENTlBaXJ5WjFJQmIvb3cwcU9YWE4x?=
 =?utf-8?B?eFlHRkRPRGNCQmExMGFsNmlQdVJmQWxtZ3hUZS9KSWYvSWNVN0lxTXBybG1P?=
 =?utf-8?B?eGJrOXhBd3NiYnFKTjZBNC9HY2VzVFdFK1g0L0UxU3J1VFc1dzRUalEwc1V3?=
 =?utf-8?B?Q28yMVVRTFpCcE9FTFFrRCtRcDZDeUhOUXV2bE94djdlV1lWMFpwdXhoMit3?=
 =?utf-8?B?b25yZVo0ZXlOTHplcjNXQXpRSDdCNC80NmpRV0tqTmlJMWZYR0lPUVQ2WGZS?=
 =?utf-8?B?UUgrOGpGdjUvUEY5WHJnZ2hLUnJxYzVPMEswZ1pwWU5EVWE0dmlsanhxUzZy?=
 =?utf-8?B?a0R3Mnl4ekRESitTVHdxeHBLc1JQeHdxMmY4RDFsYWJvL0wycHF6aWhNaW50?=
 =?utf-8?B?L3ZsWWFKbGJEVENkbmtmRFJUZlg0VFdhbCtrQXhDL3ZaNG5FWDRGTmRjdmZR?=
 =?utf-8?B?eXpWVXc2cGRsTzVGQ3djRWpZd2liSURlS1VucWRVQXB5a3U3cWdqZWROdEpB?=
 =?utf-8?B?Q1BWS09QeUVNUG5OeGx3WGxNTFUrYTdsYlhsZUIycU1UNkdhR20rMjRYa0VT?=
 =?utf-8?B?VUd3aFR5TGE0bm41aFVxZ2VCMEhpd0lIZlFTb0EySGtLZ2E2OGNTVzlLbGJj?=
 =?utf-8?B?ODdlRmdiTExuajUrTVdNcUZCcEdsWkkzWUh6bVh2a3VwYU10MkFHVHFtZWps?=
 =?utf-8?B?Q1laemVPSGR0Uk45SnJibFVrTEVUY0lTdjNJbXA5b29XSUV5alQzZnUza3g1?=
 =?utf-8?B?VVNyR2g2SXpTYmpFMjdzbHRGOG93ZHMvb3o5T3g4UHJUYzFjSDRsanJKcS9P?=
 =?utf-8?B?bVVVbzByd3NYcUVFYytWOTM5ZWc0ZzZwNjZOSjNkVkZiczZ5RkhkS2lZTjVz?=
 =?utf-8?B?YTJkN2dKNUtOVmpUSm1JZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFBCWmQrZFBERGcyYiszS3lDNXhVRVJSakRhbEJNaUZUREpHTGFoVVhkR1Uw?=
 =?utf-8?B?S01mTWkzZXVaV0k5THpYN3cvMnYwTGhzNnpzeWt4RXpuNkNxcmdYSXNDTjBD?=
 =?utf-8?B?dE5RMnU3VVdOb0pPSDZKaXBJdS92TXBmalFTUDNQd0g2S2hUSTlHV2lOWE41?=
 =?utf-8?B?SWNGT1R5czIrNnhqR3hXcmtKYmtza1pZKy85TjZkR01UQlpodFRkdFhTZkFy?=
 =?utf-8?B?R1lVSUQyYm9WVTlCZkN3RTcyOC8xNVBYVDdvdlZNTDdXamlRTFFDN1cvN0xO?=
 =?utf-8?B?RVIyN1RDbkJXb3JLemZCY3k1cnRHbU54Q3laaWpzbm5QQWdkRHo2c296bFFi?=
 =?utf-8?B?R01oWUUzaDVYdDBoa3ZhZmRNQW1MVm1LbnhkMUZ1cXRRM3JqcEdmaWdQcFZE?=
 =?utf-8?B?UGltV0xFajdKRXpMK0ZRMHN3Y1QzWEFwTW12dDVTdkZiSHdCNmN6ZEw5blRW?=
 =?utf-8?B?Njg2cEJsOHBRc1EzdWNFUG1vaVNmSWpJdFNxSG1SWml5KzVVZGJsTkJUMzV5?=
 =?utf-8?B?RklxVC9hNWhzWUdCMmxkc3ZJczgwalExblliWFNHRndPL0ZBai85dzZjWG9a?=
 =?utf-8?B?R1NmYTRKMWZsYzlyNDN3anA2V2tWQjgvd1NGaGdqRTBEdVd3MnVleHBqN1dt?=
 =?utf-8?B?ejU0czFJV1BmaU1MVUZKSndlczBOTXYrUHQ5ZG1xcUNHUFJLN05Sc3d6OUtH?=
 =?utf-8?B?cnRmeW43bDJZMDhrUStnWjVFZjlkZzdoanRMaG5ka09RRktCT01FSGtiWWY4?=
 =?utf-8?B?cXluMytUVlFPWThURWpKS2wzR3BmdTI1eHJvZkJSdnU2L0EzOXZUZHlSa3pB?=
 =?utf-8?B?TmhaM1lOWTd1WkNyT3J6ZzF3QXpxNlIrRUdZTC8yWTRyWENnRzc4aEJwSHhr?=
 =?utf-8?B?dnRvTm5ZbWYyMERpd2VUek0yOHRpZXpPMjJiZjdNNEU5blc2b29PQ2pabXRp?=
 =?utf-8?B?eWtzV3ZuRzhaYXFJdWRYYjBGbWVGUmNtZGlCcEkxRDFxem16N1RUWEw4cXFi?=
 =?utf-8?B?aHNTRFN5ZHF3WndYNExxSUxHMXlSZHRqcUQ3RGl1MFRhQWpWck1lYzdpY292?=
 =?utf-8?B?Vlh5K3ZJb3RoaWgrd2luRVRycndLYTVDRlFQSEIwQXdFRi8yeUN4ZmJGOW5F?=
 =?utf-8?B?KzBheFJWTjVjeEpzYnNCVGczdG1MUC9WV0oxWDNEUVlENk85MkR2ZTFLTTNN?=
 =?utf-8?B?V2FBWkdaeGd5aExCcUl2YytWRkZTT3ZKcmd3MUFldUNRUnhWZE1ZZGFJUXRY?=
 =?utf-8?B?SlhiblcrbVNJMVV2UnQxVW03eVMzcEhaRUJWYXJDb2RUVzRnVkJYc3gvNWcy?=
 =?utf-8?B?dVBoSUpxUHg0cEtoMWFsaENFM3hPK0VxdGFPemhjdWo4MnVlS2dZZnY3Q1hE?=
 =?utf-8?B?eEN2R1JKcDc4N0s3L1pMY2JMdDZ1YlJGck8vQ3dJZkFHYXNuVHY0cDhINGFV?=
 =?utf-8?B?UCsweWRqZVFhUWQ1WUoyOUhORnFwZlNKL3h6VEFJTVYvN29nMFVIalVvUU82?=
 =?utf-8?B?VW95S1ZnYldULzA1SjRaVmxVRS9vb2x2b1ZqcEplQTE1d0J3TnF0SmV1enVt?=
 =?utf-8?B?ZDlBTkRJazdqVk16WE5WMzA5NjJ6TllseTNnelJTYUQ5bFFsdkxMU25iVHk5?=
 =?utf-8?B?MFdRWjBjaUxKK0xwb0k2QzI0UXRLYjU3QVJ3VUFWZFhoWGlRcVBldmtNTU1s?=
 =?utf-8?B?ZTMzaEo0UTVUWndoeXBaTTY3NE5RdFN0b1JIdTRuVGhGdWtPS0xlWjMwUElz?=
 =?utf-8?B?M2U2Z2poaUxBOFJKVHgzcUh0eW0rVEFLUGRVQzMvSkNxVUJHYk9GVWo2b1Nj?=
 =?utf-8?B?VWlxU0h3RGFNc0ZTeTRienlPWUErWTBtRWpNTkg3VldiQmRmczdPQUtCRzRy?=
 =?utf-8?B?YnVldTRJcWkxbWlmUm9XKzJrdk5lRDdLU1NETWJjZ3huZFZiY3ZxL2c2K21D?=
 =?utf-8?B?b2hxdUxaQTY5K3dwRDZObm5Nd045MHEya0plY25ZWUlpNytMZEQwc3Q3M215?=
 =?utf-8?B?YXg2YVI5KzFNMkxMTWxwTHhKMXExY0dEcWhTRmFWdTNrSkRFZHB3L3BPVkU2?=
 =?utf-8?B?NGo4cXo3UnhSQkEydityUmN6aEhpSmZJNEMxblJSa3lpaGNoeGYzU3l1ZUxU?=
 =?utf-8?B?WVV1TlFLQ01mNlkxSzg1YmkrYit3UXE4dGdxWkI0WXlhempKalZvdnphRFZ0?=
 =?utf-8?Q?AMHZg068lOaFqiRGQP5vdHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA5EFDC58048A46BFECDF1F9ABB0802@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfc999d-997e-4c64-daa7-08dc8392605b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:48.4400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ujNv+q6SuZMFmReHHzb8cBuuEzNgfQV+UQ/9t9oh6gbzzKZXoWM/FnNCniefq6UK8NskL2ZEZ636tdMaK6r9kGE9uWHwEbkcQZ6RLiCYPIBwbow+fETXdsrMUHAVoTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bi5jb20+DQoNCldlIGFkZCBhIGNvbnZlbmllbnQgd2F5IHRvIGluaXRpYWxpemUgYW4gZGV2aWNl
LWlvdGxiIG5vdGlmaWVyLg0KVGhpcyBpcyBtZWFudCB0byBiZSB1c2VkIGJ5IEFUUy1jYXBhYmxl
IGRldmljZXMuDQoNCnBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZCBpcyBpbnRy
b2R1Y2VzIGluIHRoaXMgY29tbWl0IGFuZA0Kd2lsbCBiZSB1c2VkIGluIHNldmVyYWwgb3RoZXIg
U1ZNLXJlbGF0ZWQgZnVuY3Rpb25zIGV4cG9zZWQgaW4NCnRoZSBQQ0kgQVBJLg0KDQpTaWduZWQt
b2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oIHwgMTUgKysr
KysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4IDNmZTQ3ZDQwMDIuLjBl
MTRlZjRhYjIgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBiL2h3L3BjaS9wY2kuYw0K
QEAgLTI3NDcsNiArMjc0Nyw0NiBAQCBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRk
cmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZhZGRyZXNzX3NwYWNlX21l
bW9yeTsNCiB9DQogDQorc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICpwY2lfZGV2aWNlX2lvbW11
X21lbW9yeV9yZWdpb25fcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFz
aWQpDQorew0KKyAgICBQQ0lCdXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAg
IGludCBkZXZmbjsNCisNCisgICAgLyoNCisgICAgICogVGhpcyBmdW5jdGlvbiBpcyBmb3IgaW50
ZXJuYWwgdXNlIGluIHRoZSBtb2R1bGUsDQorICAgICAqIHdlIGNhbiBjYWxsIGl0IHdpdGggUENJ
X05PX1BBU0lEDQorICAgICAqLw0KKyAgICBpZiAoIWRldi0+aXNfbWFzdGVyIHx8DQorICAgICAg
ICAgICAgKChwYXNpZCAhPSBQQ0lfTk9fUEFTSUQpICYmICFwY2llX3Bhc2lkX2VuYWJsZWQoZGV2
KSkpIHsNCisgICAgICAgIHJldHVybiBOVUxMOw0KKyAgICB9DQorDQorICAgIHBjaV9kZXZpY2Vf
Z2V0X2lvbW11X2J1c19kZXZmbihkZXYsICZidXMsICZpb21tdV9idXMsICZkZXZmbik7DQorICAg
IGlmIChpb21tdV9idXMgJiYgaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1vcnlfcmVnaW9u
X3Bhc2lkKSB7DQorICAgICAgICByZXR1cm4gaW9tbXVfYnVzLT5pb21tdV9vcHMtPmdldF9tZW1v
cnlfcmVnaW9uX3Bhc2lkKGJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
b21tdV9idXMtPmlvbW11X29wYXF1ZSwgZGV2Zm4sIHBhc2lkKTsNCisgICAgfQ0KKyAgICByZXR1
cm4gTlVMTDsNCit9DQorDQorYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lE
ZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZvaWQqIG9wYXF1ZSkNCit7DQorICAgIElPTU1VTWVtb3J5
UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3JlZ2lvbl9wYXNpZChk
ZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKyAgICBpZiAoIWlvbW11X21yKSB7DQorICAg
ICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisgICAgaW9tbXVfbm90aWZpZXJfaW5pdChuLCBm
biwgSU9NTVVfTk9USUZJRVJfREVWSU9UTEJfRVZFTlRTLCAwLCBIV0FERFJfTUFYLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgIG1lbW9yeV9yZWdpb25faW9tbXVfYXR0cnNfdG9faW5kZXgoaW9t
bXVfbXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpKTsNCisgICAgbi0+b3BhcXVlID0gb3BhcXVl
Ow0KKyAgICByZXR1cm4gdHJ1ZTsNCit9DQorDQogQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lv
bW11X2FkZHJlc3Nfc3BhY2VfcGFzaWQoUENJRGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQogew0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgN
CmluZGV4IDZjNjBmN2E3YzUuLjIxNDc5ODE0MjMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3Bj
aS9wY2kuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC00NTgsNiArNDU4LDIxIEBA
IGJvb2wgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9N
TVVEZXZpY2UgKmhpb2QsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKTsNCiB2b2lkIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAq
ZGV2KTsNCiANCisvKioNCisgKiBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcjogaW5pdGlh
bGl6ZSBhbiBJT01NVSBub3RpZmllcg0KKyAqDQorICogVGhpcyBmdW5jdGlvbiBpcyB1c2VkIGJ5
IGRldmljZXMgYmVmb3JlIHJlZ2lzdGVyaW5nIGFuIElPVExCIG5vdGlmaWVyDQorICoNCisgKiBA
ZGV2OiB0aGUgZGV2aWNlDQorICogQHBhc2lkOiB0aGUgcGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3Bh
Y2UgdG8gd2F0Y2gNCisgKiBAbjogdGhlIG5vdGlmaWVyIHRvIGluaXRpYWxpemUNCisgKiBAZm46
IHRoZSBjYWxsYmFjayB0byBiZSBpbnN0YWxsZWQNCisgKiBAb3BhcXVlOiB1c2VyIHBvaW50ZXIg
dGhhdCBjYW4gYmUgdXNlZCB0byBzdG9yZSBhIHN0YXRlDQorICovDQorYm9vbCBwY2lfaW9tbXVf
aW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuLCBJT01NVU5v
dGlmeSBmbiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQqIG9wYXF1
ZSk7DQorDQogLyoqDQogICogcGNpX3NldHVwX2lvbW11OiBJbml0aWFsaXplIHNwZWNpZmljIElP
TU1VIGhhbmRsZXJzIGZvciBhIFBDSUJ1cw0KICAqDQotLSANCjIuNDUuMQ0K

