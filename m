Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC886C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 00:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQcOK-00016J-Jp; Sun, 07 Jul 2024 20:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sQcOI-00014x-JR
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 20:38:02 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sQcOB-0006Ty-I4
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 20:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720399076; x=1751935076;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8/i9oAg1CwmKPaYndxMGWONW/lSDgfTHU7jkUPhvL5s=;
 b=kF8lQHNx0TadkfwIsifYj5bF/7rErM/SzrSqqJ0/qbffdnVzroc2yD7v
 L3yidKpe9IKjKBXkDhJz3QAc/q5lXtYPXVw4lPAJLh9fUDSLxv+9noHz7
 NzDoBVIbgP/zGWxFYIzxTyw1LFqay41vp03CeqZKW/uRZM48e2eRgHEKh
 uVXrThy3bj0WeJdjeK4GFaBt6KRQyKaFV2oqlSOYrpRnXBnGKetPXvDC2
 sIgvbwvaqucTRTE5hABJhMJdYBU+RTCFdPjLKQy4DzX8MtyLut3epkufC
 stMN+0BEh4CF7i1DlMRGhpG1uql33lWZcqEUr/kGkhv+jSMYjwLh3LINy Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="124431462"
X-IronPort-AV: E=Sophos;i="6.09,191,1716217200"; d="scan'208";a="124431462"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 09:37:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/EcHy4+6loJNe2dr6si16yL5LYxylseTX5XgBIuHfqf4bowYbns8spXITB8ABg4U7g5+IhcIt9C7XPZfq1Is2bXLMRx8wNzjmKVvZWpL+iCfCN9TJ1qLggyv1QTmF5B9gAAIikiOB1Xlyr04dF6rLQROsL6AxSQOZNh8un5pOyI3r81J1Qf3WmNbJt2FSbZYXCYjsafyvIUDoNVbGjn72NLnA1not9SofWzxOhEecsxBq53jt+YBSqbKNxDHOIdZNwOT4ifX/Sk+0qqkXpYLbQQknqKz2loKIpJvpsYPNLAvCLOzuAwPFjbmSMP45YUXjsw9p599ty5XJJO0C/+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geRHMgZNln1Yq2MjaBa9F6HHGnbdvBBnMcV4TJELyhA=;
 b=hhwO2moo59Wfu9FNb1nxISFznzw5NNamKSsInPwygkvQUEWTirZYq3C7bLBcEV91H067Co+3cYMypyxjPDOz3hu9oVXZ20P/gDukKHEne4VHdqmCkUYM/tQGa5LwL3YZIWZfsc0p3Ir3rnYqGIllhtMoOio/xcc8G9QHosxzaDJ9ugNx3S3zOFqjWGJ8uSobHHgpXDX3LgXsQCyi63EzOgc15ly0VJNmJhvLv08+tdSutdK4gBHqGFk0FIFFarug4rAlC2RHgh9Em0QIt4wvVN+ldEhxEAzbVKnip1O4yKdVSfLZmKt8HRLPBxviAAifZx+TQF7XEwa0heh7nxW5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB8348.jpnprd01.prod.outlook.com (2603:1096:400:177::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 00:37:25 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 00:37:25 +0000
To: Gregor Haas <gregorhaas1997@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "berrange@redhat.com" <berrange@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "mjt@tls.msk.ru" <mjt@tls.msk.ru>,
 "vsementsov@yandex-team.ru" <vsementsov@yandex-team.ru>
Subject: RE: [PATCH v4] hw/core/loader: allow loading larger ROMs
Thread-Topic: [PATCH v4] hw/core/loader: allow loading larger ROMs
Thread-Index: AQHayYjjkxndsxJzzkuX/wPwTJkpcrHsCXQQ
Date: Mon, 8 Jul 2024 00:37:24 +0000
Message-ID: <OSZPR01MB6453CDFF90A38F1BBA3D092C8DDA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240628182706.99525-1-gregorhaas1997@gmail.com>
In-Reply-To: <20240628182706.99525-1-gregorhaas1997@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ecc93db9-950e-44ba-960e-f8648055a352;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-08T00:32:13Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB8348:EE_
x-ms-office365-filtering-correlation-id: 9ee837cf-761c-453a-f013-08dc9ee6232c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?NHh0NWkvYW83ZnN2QTNCS0dGT2phWW5UTkVUU2xINTFSTTdTRUp6WDhJ?=
 =?iso-2022-jp?B?M0hKeVdreVF2UzhsbG1RLzcybEJmeWlkekxrc1dZMkNnLzFuZDBXa2Q3?=
 =?iso-2022-jp?B?OVlUb1p4QmorZHdYS0ptcTVWbWdCWmpDREVURW04UXhHZG80QS9zT0U5?=
 =?iso-2022-jp?B?QUFPT0RJTHZScmlXRyt4QUV5L1J1TmtyaTdrMzRTWG9Ha2NrZjlzOXVo?=
 =?iso-2022-jp?B?b3lzTk0yS2pseERiRkFnQ2VIY2FYM2hQVHJHWkhkK2N3aEdNMHBDNWtx?=
 =?iso-2022-jp?B?MjNyRGtUQWlxZEUwYURBNTUxS2Q4d2N5YlpYd2pOK0FqSVV1ZEFsOStP?=
 =?iso-2022-jp?B?RStTN2ovdi85YUZZNlNROXhxTFVMOWJTUmxkaUlPajRSSWNtWHlRMEU3?=
 =?iso-2022-jp?B?dXRDWXRJZDQ4bHA2QWh2dEp4UW5BRlFrVWNiRzVnVkVvaFVrZXZpUGFQ?=
 =?iso-2022-jp?B?UE8ycXo5UG1IYWJZeHYxSk1uRE1WRi81TkJLTXZpZjZiVDU0UlpaZE9R?=
 =?iso-2022-jp?B?ZmFzSGttUXVIS081d1MrMWgrWEVmMVdtdzR0NWJnbG95djk0bDAzYTlw?=
 =?iso-2022-jp?B?UEkxazZrbjhEZEs1aUlqT3VVWUt1M1RQUnlVUWZUdFlrREI2NGYvSkZw?=
 =?iso-2022-jp?B?TktzQk5udVQ3QWpGOWdxdE9udjNwME9UZVdPZTR6Q1NVSkJmWDNUYmF1?=
 =?iso-2022-jp?B?ZUtOWmY1M0FyVXlFR0hEcjNNZW5STGJPcXpVbXV1UjBIUUlMMkNiRS9t?=
 =?iso-2022-jp?B?Tk9XZDRpK3FuVEIyNmtHS2cxQ1BhMmlmY1RkWG1DMFprdnc5bnZnV0Rj?=
 =?iso-2022-jp?B?UkZKVkFSUDVCL25YRUdXOXhTUTNteDBicjI3V2ZmMnVQcVJldy92WUdI?=
 =?iso-2022-jp?B?UEZaemhEdFN0anZQaGw3S242b2EvbVlBR0lUYVh1RjMvV1pEZTZENHNw?=
 =?iso-2022-jp?B?cVFCVU9Sa3IxL2FJQzBkOU0xVnZ4UGt6Z2N5K2RDTVJjbHo3ZTYxTVpt?=
 =?iso-2022-jp?B?NEVaRTJqWTJjcU03eng1QWNpN0M1Zlo4dENxdDBhZUpGdkdITnIxRUxp?=
 =?iso-2022-jp?B?elhVaGVNWEdRM3F3d3EwVlpNM20yRE1yd1pnZmhJNER4UlpIZ2htY1hy?=
 =?iso-2022-jp?B?dnc3SWxRVms2bGhLRnJoRUZQeXBVdGJ2bU5VWTFFazQ5MmFPSEdQeGVi?=
 =?iso-2022-jp?B?c29taVFXZWRtK0ZPbERUZExMbUNBMU1zb2k0U000bWgrRTJKdnZoRGhh?=
 =?iso-2022-jp?B?T1NkWkRuaVFvOGlPTmxHYkdadVh1TU1zMHFOK1NSN0xYMXVUWFZJYWlY?=
 =?iso-2022-jp?B?RC9sM293Q0pHOEpuZnUwZjBKQUJ4KzdOMkFGcjYzR0IvNFBmVzdHTk9J?=
 =?iso-2022-jp?B?bEtHUUpXRGl2YWx2bnFvNUdycDZDOEEyVi92K3k5VXQrTE9PZ1M3WldI?=
 =?iso-2022-jp?B?cDI3UDZISDBRVjQ0aFJjdmRGYW9BVzVTTEF3V1NTaG94a0JVV3QwaEdX?=
 =?iso-2022-jp?B?aGVuWVZGR1VkbkEvd3lLQUN6RWhIVWxXeTc1SEtuMHFoYms0Q2VlYlhy?=
 =?iso-2022-jp?B?azQ0aWlqaTNnRTdlQ1ZJMFl5K0Jaa2t4SUFSd2VoNkxEREdZK3pzaVNX?=
 =?iso-2022-jp?B?VEhJS2JUUDVrUDFSWUovVTRTM0hDdkIyNENIcWhnbmFIdFVvYlVjWUgw?=
 =?iso-2022-jp?B?TGYrUFhRSGJPUEkzY21HNlFIVWFBNzN1UnlibW9xcWlyeXZpVVdjS3dx?=
 =?iso-2022-jp?B?bzZ6WGJEa0FvcWx3NjhPNnUxTkJHVURsSHB2NFJqOGRjUEZ2bFg4dFZQ?=
 =?iso-2022-jp?B?YWR2bDRjMC83dm53THdpMlhrK3JnZnVza1Focis1ekgzUUVSTGJOTCtO?=
 =?iso-2022-jp?B?VCs1dHUzU0lCTjFoeHQ0UHQxNzhwY3BuSSt3V1I3Z3laWXNvbU9EeVVm?=
 =?iso-2022-jp?B?OVJKby9sblpxRnhLL1ZqaXJJaXpJM3ZadXRTRWt6ZzNwTE1XVUpBcWNP?=
 =?iso-2022-jp?B?TUd6bkhYbVZYc0huOEVHdUZPY2NqWHRoVTZnU05pUUJRR1lGVUVMV1p6?=
 =?iso-2022-jp?B?alVBWlZ1cExLMjVQVXNENlhXRVp5SDA9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bzBvaXFQOUtkMS9UVE9TMVlWVUJQaHdSRXRMVm8yU0FNSVVMUVJuRHF5?=
 =?iso-2022-jp?B?aS9RRFl6a3VzamZ2ancyN2E1TC9ZNmtpTjNDYmJ4TElXOUFSRFFHQ3ZV?=
 =?iso-2022-jp?B?MUdmQVpzN1hkZXlXWUo2M2hkVWtJUjZhNXhudHRIZGhFMTUvamVlY01R?=
 =?iso-2022-jp?B?a1Vzalhlbk90emI5QlV1OXhSQlE1U1VFMGtHS0RkbDZmUnoyTlpDMnl6?=
 =?iso-2022-jp?B?TlNMWktSbE9lQWR5bDE2RWZCeDQzeXh0Y2RkdzhIeEd2K3YyYjY1NTRp?=
 =?iso-2022-jp?B?d08yS1RIY2l6R3NJejNpMVBlTlViNFE2T29jdndFTXlkL1RhY203cGdy?=
 =?iso-2022-jp?B?Yk5NMU5ObW16a3V5T3ZXVGJHcE82UDhGMXRWUzZ3b0dBUERueTg5emJw?=
 =?iso-2022-jp?B?ZTM2NVdTanVFSTM1cVhYbEVrZloyZ3lEOFhJdW4xZmxFdXRTR0JJK3Bi?=
 =?iso-2022-jp?B?TFI5bFppcXhmRDZzMWJHZS9PUnhwblltcUNnbkt6aU16OTY4amxwV2Y5?=
 =?iso-2022-jp?B?ZHpTcUozcnlVaVo5QlQ1VEU0MEdpRk5BMDZ4czR0dEtjRHR3Vnk4WXo4?=
 =?iso-2022-jp?B?KzJMUW5RQnJVSFE1WFh5TzJ6a3p4SG5OSWZmTFVObm5lTmFDRVYxZUNX?=
 =?iso-2022-jp?B?ei9xenk5by9seUlZT0VpU0lRcklrN3FUa3d6NmljazJhWm9LOWp6dnU4?=
 =?iso-2022-jp?B?TDNTUDNaZXdURXpoVEVqUlFrYUl2M28vYnByeSs1aUxvZUxnSzZJb2Vx?=
 =?iso-2022-jp?B?NFlueTUwSlVmU1BKbUNuVGhWKzk4ZzgzY3VLK2JTL285djhnRS9jcGUz?=
 =?iso-2022-jp?B?SWcydWRJRzhmNExOeDNwS3RRcG40VVlzMHlKV1hsZStJV3FEanVCRzlP?=
 =?iso-2022-jp?B?UlZmTTFJQ2JxZWpwNzczWUdhQ1BRc2pzNkNIdGR4ekZSTFRhZFdaTGJE?=
 =?iso-2022-jp?B?cW83b2ljdDVFbzBxc3p1bEZ0NWVpUzdIUTQ0NGtSWlk1dDR6cjdjSUNx?=
 =?iso-2022-jp?B?VVpVTlZ5dS9mME43RzVDcDZSenFTczlZa3VkZWMvV0ZYaFNjZXhnU3hU?=
 =?iso-2022-jp?B?TlpPRmZYZUpSSkpLTlN6R0VqZ0hLZWFaS09qeklmUnpPSjRUNnkrNEpV?=
 =?iso-2022-jp?B?WkNXTi9nTnV2a0FrUUFZejIwTERDSG81eGoxbTJxL0s0V1hDVU5JQVcy?=
 =?iso-2022-jp?B?eERnMWZxRGVWbXFob0xidXFEVXBDbnR2eGsrV3lIZWFma2FsV0VGSHJh?=
 =?iso-2022-jp?B?a0lhNWttZ0VEcWlBU2hVNk5FZWQ1QWxtc3lGVnd4U1YxVGlieGZSTXJ3?=
 =?iso-2022-jp?B?dkphZGNWRnYrbHJFQ0w0Q2p2T1RjTmxGQUVvZXh3blR1RkVWbnJPRUxz?=
 =?iso-2022-jp?B?MGUyWjgvNksvTm9PSEJxeFoyVHNiWVEwUVRsSE51bEhlVTZ3YzRnMjU1?=
 =?iso-2022-jp?B?ZnJaY3JpajRMMkE0VHk1WFd5aGVXRHhpVUFONktwK3U3RE1xeWJSa0lm?=
 =?iso-2022-jp?B?R0pXcG14ejgxeHV4NU4wakFONVFoUzFHRDVhNThaMEJxMDRUSEpLamhY?=
 =?iso-2022-jp?B?SmorSjJDNmVtWmY3dXZSMEJHVkxMcUJlOEpOVUNoUEZ2WnVUN21DbjVh?=
 =?iso-2022-jp?B?c3hJZGxvamFtSFVvZnJCekFJYnZNdGlnakxjcG9YczhVY0NFZnovZHFk?=
 =?iso-2022-jp?B?ZGdFMDAxcWdkbDhtbE8rRGlCQkVxSTltcHdNVlUvazB1Rlp0K3ExeC9k?=
 =?iso-2022-jp?B?WS92R0hyU2dBSjlrV0JDSlNGZDlJUHpaVk5KNlI4aWVYaVA4cFhKbHNR?=
 =?iso-2022-jp?B?TEVFMU9oZW1BRFVnRmVCaUhZNkpkR2JyQm9rQVJGS0dxSU5mbzNabE5P?=
 =?iso-2022-jp?B?ZnliTENQSnhVWTZWM0lxMzc3ODhPejMxQzBvd0tDbWlFZW8xY002dUZV?=
 =?iso-2022-jp?B?dXdoMzUvOE5JcjVKMU1BQWVUZE51c0dEZFFLZkZnVTAySlVmOU5tVmoy?=
 =?iso-2022-jp?B?QUhzV1hEWFZTNXNFQ2ZWZFM2UkR6SndvM1FrN2ZHTTZqMm9pc1F4Nmdp?=
 =?iso-2022-jp?B?eU9XbEtCQnhNbExkNUJ4WUltZGloY01xU1hYR3F1OVJUS1hSTkd6Sytz?=
 =?iso-2022-jp?B?RFJ0aWErRlNjR0lGWnVxNUtSTjhJYi9zNGRLK1N4U1k1NG5NNUpkQWpy?=
 =?iso-2022-jp?B?NmoxODJuSExiaGpwZVNPT09IdXN6cTVlOXZMZG9OeVl2VWhQN1JDNVpt?=
 =?iso-2022-jp?B?bzA3TmhJK0Q4bDlmd3gxNXJRMTJjRVhWUW5mcTFxcVNuMWFUeTA2dVpq?=
 =?iso-2022-jp?B?dDBkWg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nz+nv/eZuAIeHT/CVa9+OKgUD/kF87I2s90AEbuijbeT17+9EqwZ7uX5wAOpwb5sDTZuC/gNuq/TXosNGk9Io/LRL5S7d5F/3u0Y0VkK9kSK7sC3/5uAqx3gbOVc6mg7HyK49NhswwQaY2ITnJbazn7t8s3cNIyJRIrsNl31+yGFenHZKuR6JAyraeBQeEsNJOcI58ts+i6caJaGJkhvcbdcPqxi8TjmONSK1Wj3gZ8SmX7ON6OdK738UqhudTTBlywkruaPzcSJddGD7kkRwA3IubNqnNdj158HsK6bMrb/cP5qLFW1l9K4bofPa83vhDSCtCZvPPQ4/sHNKn4hxdgyrWPyjRWBwksRQoW0NcIz1zpU9Dc3Su9qiFFe1dOpC9ZjOd9pV5QDCZQA7nnRfBMqJFJAWLPAJBLexa33qHIWV1xa7zTx4luYPs4EmFrYIbS4jwJclphtdipRKbACw+e88pJW3jGyvIvjdkDeHNBjip4eenTjJNpCaitwwjB4bqRXEbgt9oVSBU7O5FIsGQ1zFvBEqmL1eNrVt1PjVijhrwtQsQIqbIV3a0/TkMT/WegCitNyb9mO1ea0RWdfSDzSta0gzsP0sucQMC+BjEvuhLo/8NrAg5dr15D3ONgE
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee837cf-761c-453a-f013-08dc9ee6232c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 00:37:24.9155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kU4/vcCIP838h0w0aJV0J7u3G/6i7+YX7IyalZhxsPZB7/nr+HcUdjYxtJIdAKh+CscfpwDr6fT+WmHAWE/CNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8348
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
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

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>

> -----Original Message-----
> From: Gregor Haas <gregorhaas1997@gmail.com>
> Sent: Saturday, June 29, 2024 2:27 AM
> To: qemu-devel@nongnu.org
> Cc: berrange@redhat.com; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.=
fnst@fujitsu.com>;
> Gregor Haas <gregorhaas1997@gmail.com>
> Subject: [PATCH v4] hw/core/loader: allow loading larger ROMs
>=20
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into accou=
nt,
> instead failing if all bytes are not read at once. This change loads the =
ROM
> using g_file_get_contents() instead, which correctly reads all data using
> multiple calls to read() while also returning the loaded ROM size.
>=20
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---
>  hw/core/loader.c | 30 +++++-------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 2f8105d7de..44444a5714 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1075,8 +1075,7 @@ ssize_t rom_add_file(const char *file, const char *=
fw_dir,
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>      Rom *rom;
> -    ssize_t rc;
> -    int fd =3D -1;
> +    g_autoptr(GError) gerr =3D NULL;
>      char devpath[100];
>=20
>      if (as && mr) {
> @@ -1094,35 +1093,19 @@ ssize_t rom_add_file(const char *file, const char
> *fw_dir,
>          rom->path =3D g_strdup(file);
>      }
>=20
> -    fd =3D open(rom->path, O_RDONLY | O_BINARY);
> -    if (fd =3D=3D -1) {
> -        fprintf(stderr, "Could not open option rom '%s': %s\n",
> -                rom->path, strerror(errno));
> -        goto err;
> -    }
> -
>      if (fw_dir) {
>          rom->fw_dir  =3D g_strdup(fw_dir);
>          rom->fw_file =3D g_strdup(file);
>      }
>      rom->addr     =3D addr;
> -    rom->romsize  =3D lseek(fd, 0, SEEK_END);
> -    if (rom->romsize =3D=3D -1) {
> -        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
> -                rom->name, strerror(errno));
> +    if (!g_file_get_contents(rom->path, (gchar **) &rom->data,
> +                             &rom->romsize, &gerr)) {
> +        fprintf(stderr, "rom: file %-20s: error %s\n",
> +                rom->name, gerr->message);
>          goto err;
>      }
>=20
>      rom->datasize =3D rom->romsize;
> -    rom->data     =3D g_malloc0(rom->datasize);
> -    lseek(fd, 0, SEEK_SET);
> -    rc =3D read(fd, rom->data, rom->datasize);
> -    if (rc !=3D rom->datasize) {
> -        fprintf(stderr, "rom: file %-20s: read error: rc=3D%zd (expected=
 %zd)\n",
> -                rom->name, rc, rom->datasize);
> -        goto err;
> -    }
> -    close(fd);
>      rom_insert(rom);
>      if (rom->fw_file && fw_cfg) {
>          const char *basename;
> @@ -1159,9 +1142,6 @@ ssize_t rom_add_file(const char *file, const char *=
fw_dir,
>      return 0;
>=20
>  err:
> -    if (fd !=3D -1)
> -        close(fd);
> -
>      rom_free(rom);
>      return -1;
>  }
> --
> 2.45.2


