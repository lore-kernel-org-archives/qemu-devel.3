Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE63D6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfj-00081m-Gb; Fri, 29 Nov 2024 02:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfg-00080X-Ac
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:13 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfe-0002nM-Jw
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866250; x=1764402250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vYT7O3CmbHBot/TrWbgm+CGz6yYH2nqqj0xRWpdTDT0=;
 b=xJbU31GgV03COYoYanORSYPh8xOVZXFvCKse670MbwA1T3auf6ea3uR/
 b/DcsDYFQ997B/qMzU0Kee3OpN/s6xzhXTXVxZSlC+w3QlIT+PYIo28zG
 22itXrJdMjDOqp9BN7gP0oSOj6z3bBlwu0kCxn2HqoMtBhQwGOKxyO+pq
 19Lbzfwt/CjcaomAEV1cvmNXp6Y6olNIFnOxg6QHGATXm++/75Ukdn31Z
 npaT1LbAkVQwFNHkGaJFGI4gSCyZ3i4CbRm2fLJQM0JgaoS++hFHFL59P
 fm/9oD5dNVctGB9lQrsKDbKGrDhx92vncOIzgz87t+xDBF5qGHC9CCzn5 g==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670816"
X-MGA-submission: =?us-ascii?q?MDGDX/2qiBNAz8q3yiCuhFN6bRlJlS7XeZ2irm?=
 =?us-ascii?q?1R0QKfiyvycmwWdxaQuwSQFjuYxPzVabHSgQ5fOpSnvBVytxTB7RXEfx?=
 =?us-ascii?q?WFqkmZ8LmIMP1TX5GO1G1O6fYyoSDvl5M1RZoQ+YhKIl9Gag1eH8rQTn?=
 =?us-ascii?q?eja1oPiUwKsnD1RjerehBTew=3D=3D?=
Received: from mail-norwayeastazlp17013077.outbound.protection.outlook.com
 (HELO OSPPR02CU001.outbound.protection.outlook.com) ([40.93.81.77])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:44:04 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWOhvSugvkNgGBn9utqFZ4H+bsHoyiBW85jFA/sShUMFIFBFpDn1+R+bmITsFWPKZDpkoXufclPmDjRrcF9chW91g70mRi4oQvHAywTx37JWoKvxwzzGx+wcCN4M6CEN7hZl63KkgQkaH4wTbdOeGZvbdCSKTCgHw/w2X8jfW3YVemDn8PmLtvBZ6twoRakg29fTI6ucLV3purD7WTVvem3txHkudyfdHTr4E9KJUIvXpL8tWrr9WoX3XdYbncfb/ym5l5YBgmdcLU9nyvNK1M/6+z/wTYWZDyMvDlBhJlaoj8Wqfi9M1udIxKlAGQJJ3QP/dxTFT4qf0aPJXHWyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYT7O3CmbHBot/TrWbgm+CGz6yYH2nqqj0xRWpdTDT0=;
 b=LKwSBt/9/ZqB1oIpxHc+7OG21eUC+FOBmyJ3+kqL85k7CEZNfSMUiXgank3940vwfWeL4aPGR1IOE1As1hbLgHupLSg2l48WukNcwN51PFgOmIX4hGRfgEWvw+ULm65ZnJWe9ol7qwt9H48izg41Qi0Ph4O1pFDatU2/ICyvVWWmQQ3i6W5YXGNui9Ecz3uRZb9hDtVnV1+3RsQtgxxCv4h0qDx+hF422DsYXwwNze9GQ80e/NTOhe9u3kGt/kSoRxw99KaroSY57Eptc5liNbY3OXj0IWB5/fP2hzeU+oNnXPgvN+9ZLB/stt5uvZ0X/v/IEYfRWkJ2ebCrkXYPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYT7O3CmbHBot/TrWbgm+CGz6yYH2nqqj0xRWpdTDT0=;
 b=ZN95RiaF9h8jwHjlHQdQvBDWV6lByFg0fS9LCg4XU/NT+zyvPxNeEQs49h0u+LxL5U2Wg3dzBvQ8VoKcSyXDpl8Hxw6dtx3hLG5s6uk0Wmua/kRRwwq+MJm406XSLSshbKxB3zlDfeSTvoMlb1+drpv15qvyaUltW+CISFt/iRNJp3sb6jekglsQNXC00jD3crzBSnmM2UiplU9LF7lfVbfJPHQluy+tE5MalPZeal9J65z4/4dHpwrFiIflNH0xnMoAxlV2E6o+1Q3YtNzAoeghBeVmJsduGHxUUA/e+JOeA3dsDrlIN5VnkXc+S33y5rSh1mBn3JRvYPcc2zz59Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6414.eurprd07.prod.outlook.com (2603:10a6:800:139::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:44:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:44:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 16/19] pci: Add a pci-level API for ATS
Thread-Topic: [PATCH v1 16/19] pci: Add a pci-level API for ATS
Thread-Index: AQHbQjJ0APXgNcpLuE6g4EiGuYqvbg==
Date: Fri, 29 Nov 2024 07:44:01 +0000
Message-ID: <20241129074332.87535-17-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6414:EE_
x-ms-office365-filtering-correlation-id: 341eb73c-8094-41a2-0617-08dd10499751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|4022899009|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?akthZW9TcElQNXlqTDljc1gyYTdIRDQySjhWalRXcTB6eE1nVUg3UUpTZzdS?=
 =?utf-8?B?MjVhZ3RwTG40R09DLzNiakMrZHl4dmltZkZ0TkFxNDllY2JFUHByaFhUZnRo?=
 =?utf-8?B?MGlFdXFOckN5eVhPRmRIekxyTG5tblBpU1ozdDhqZkhSNWorSmErcUU4Mmx2?=
 =?utf-8?B?MEgvZlpEMmlDUWVKMEJZWHdzckMva0ZBUEhJWmE1UkQ0Yi9QQVhKS25FVCtX?=
 =?utf-8?B?bEphekhadnFRdXlrZFR1eEdJcndha0szaEE5VmhZbW93eVAyeW9EUXN4VlB1?=
 =?utf-8?B?QjU0Nml4aU9zYS9INm00NXlweldwWjJicFN4VU1QbUN3d3J3RmhFVDJHK1Bk?=
 =?utf-8?B?RnNIY0xHVFR6eU51Yjg0Vi9iR04wMHlnUTdwOE4rUXZDbERYMWNIYXB2Ty8y?=
 =?utf-8?B?Q3NKUGNtRjY2WExoWVBVTUFEajQwbUtvWFhLQ2tnSytDdzYrNDdFaE9pMHVh?=
 =?utf-8?B?TVJQdTJSRWpDSTJhZ3AxNDFneUkzVDduWFZSV3dSQUFjYkYrTVhzSWdWLytq?=
 =?utf-8?B?ZUZEd3lCMWxUUDRnLzhPd3JRTlM4amVqRm9kZE9MYXV2K1VIaUNPUTVqSEZl?=
 =?utf-8?B?SWZBclBKd0RhWm9zU29zcXpsU0FZNU9vQVAxb1dTVHVWVXNiL2RTemRraHpS?=
 =?utf-8?B?U0d4UzZSUEd4THBTeC84N2V6cEF1Wm15Nmc0dG5kTnUvRE5oMEtrdU1oRk9s?=
 =?utf-8?B?b0FJbktPOU4zNm5rY2lXTHlXbWJ5Zm44dHZ0dkRPZVpHcjk0Tjd2R2hqOXYw?=
 =?utf-8?B?SnhOa3p1Q1Y3amNWZFVCNS9xOHVNK2NzdTJOMmlUU0lMckFuVVFrbFNCeGNH?=
 =?utf-8?B?MHNsR29PYml5aXBVeU8vcnRjd05JVXRCcTdVZTJxYzF3R01wWjZ4TUJPRHB3?=
 =?utf-8?B?Y2RuKzFXVW1ib051Q1J5V2h0aThWVDc4OWRsaC9UbmI0azN1S2lHUkpvV29Y?=
 =?utf-8?B?dmVkeUdDaTJEa1pKSmRCeExrdWxCZGZJSGhMZ2FML29iMHl5TVpTbGZCOEhm?=
 =?utf-8?B?SXJSQ3FrSEswcmVldUVFTHppL2FGNXVPWW0xR2txRGpjdXNKbk9oNTFJVitq?=
 =?utf-8?B?WVNmTFIzT3lyZ0lmQWVIc1E0S0hSWkVISjh3QjYrVVVrTlcyc1Y5QkZBdkRo?=
 =?utf-8?B?YUZtTVNHbkIyNFY3RHBQaW9mUGI3c3hWZGFmLytDQm9wN0NjTVAxODZpeDlM?=
 =?utf-8?B?RkhCeDY3aS9Kcm1rWmVieGpRYUUyQUFLTGhuKzFGYm5Dc040WWgzVFhqUXBK?=
 =?utf-8?B?SFVXRVNMQVg5SU80bWNSMUI0c1hOdjVvU2hEc1UyWVp0SExucGVHTnF4SlhQ?=
 =?utf-8?B?SjlPWHlBQmlNY1MvZFo3bUNQQXo3MFBkTGpmcDNHOUdvMGsyVjdBdEFxanhN?=
 =?utf-8?B?eUl1dHJNdmlScnpHUGdFMWFmWHgrdmdRQWVubEx5L21MbE05aUs5TFJGcmV0?=
 =?utf-8?B?dzl2Y25VOEpxYkJpVWRxcXlwTEhwVnIrZ0J4c2g3QVRLMnpFd25uK1hpT1pv?=
 =?utf-8?B?WmZ4OGE1OC96dkdOeng2aWhHcmFmNnJaWk9FQUczNmZITnpNVzNkT0s1TG1Q?=
 =?utf-8?B?MkdnOG9VK0lQaUttdHNvaGEwNURHdUJLbGd2Y0l6QXhXbjVPRkpDQy84Z3Nr?=
 =?utf-8?B?MTFZdHJjaVNsNnRJaXFDcXN5RUM0TFM4YUZ4K0VxSnJ2a01pU0x2aUtRZ2VX?=
 =?utf-8?B?WWtMcTVEVys0TS94RGJ6R250N0FFRVg2TXBON3VkRlNwZTR2MWsrL2crZ0FU?=
 =?utf-8?B?NWpmdEtubzZISlNzaUN6ZHZEZTBxeDgyRzhQWVRWeXZCVDlSOGhZMVNEQU0y?=
 =?utf-8?B?RU1pZnA5MjVKQ0hkcFFWUjlRVEFRb3J1OFpTV25WU1Z2YnB2aUJJbkNzVUVC?=
 =?utf-8?B?cmpLdGlVN1d2YWk5cm1OeDNZRHVyYy8ybkNhYmFxTGdvb3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(4022899009)(366016)(376014)(7416014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEYwR2xsYjJXUFZmd0MxOERGSVcrcWZOM3dzK3Z2bUVjRXVXM3R0by93aFFY?=
 =?utf-8?B?UGUyenNqeUd6YkU5OHZIRSsyVktlbC92ZXAwT2cvQlJJckFUT09xQitXUUJ0?=
 =?utf-8?B?c0I3cjQrd2ZoQnk2clhvcXVsbi9PMEJQc2xycjJYVzg0Nmt1bFpzU0RQOHhN?=
 =?utf-8?B?VzFhVmVHa2pxL3VLaVp0b3ZHZHdaaFFzOWpxb3hhdEVDY2Z5WndwYkt4eCs2?=
 =?utf-8?B?YjNPWU5tWGIwWXEvaVEwZWNzR2dUWUxmdzJkUHpwUm9OK2gzc0hwbXBNMGdV?=
 =?utf-8?B?YXFuMkZYQmdxMGdLeFN4TlF1MnVSNlhHL1p2REhOK1F1bmwwYjBBYzAzekpB?=
 =?utf-8?B?eTU4Qnh4aW1DUEltNDkxc2NmemhaN2R6M083L2V0Z05BNHZjS0xFeHdJeDVj?=
 =?utf-8?B?MjFCbGJNbWV2eWJSWXdyVnRUaDVWZFE2NGxud3NYbVQvMzRrU014NDNOTW1h?=
 =?utf-8?B?MEhnUUxMbFFNdlk1czdaV1o1M0Vjc0VHb1YrekF3b2pEWGNpeHpseUdlRElk?=
 =?utf-8?B?U1hyTElmL0Vtc0dKSk9pSE15V0NUZUtreGV0eDdaMjM4UEFJUUNiTUNJekxT?=
 =?utf-8?B?Q0hsRzlsdWkvSXZUV1pNdTAxSEQ2bmlNai9xRFhiU1RIbmFyRDU1cHJqYllW?=
 =?utf-8?B?NzdwUklVb0gxVWdMb2pKVVlhTzgxdlFhVVo0NUdKbHpEbzdpbDcyTnBDQTg1?=
 =?utf-8?B?ZHNxSDBKanF0aWlhaGNpamM4eFJrWmdqOU1RWmlySlNYaTV0cHg5OXo2a0l2?=
 =?utf-8?B?YmpFYnZmcVRYeHR2NEdPd2hSUzUrSk03OUo2R1ZsKzhYTG03MlVEVlhtekph?=
 =?utf-8?B?UGorQkVzR3ZZUnNVeGFRNzlSVHF2TEw5Q3J3LzMwNFM5RjZZWXYzYnhUay82?=
 =?utf-8?B?dlFJM1lrdFN3Tk15ak5adTErV3pnMjhNeDVHSWkzVGExQkF0cFc1R1lqOGlW?=
 =?utf-8?B?UE1yeEtzbDdLNjJUc3NJMUpZc1JoWEpiZGtoeEMzU1dGVkVVOE9mTVorL2xO?=
 =?utf-8?B?dU13WUliVXRsMEc4Z3lzdWdoQmVNck5naHRjTHJGQlFmemJNSTJMTVlMY1V6?=
 =?utf-8?B?NjcvQU5JeHQ5bnlwY0JoNG1KSkNSV1NySjdiWC91NjRablNxTy85TW1JMmpS?=
 =?utf-8?B?WmFYZUgxMzZxRlh4WmNtaXU2a3dSOXB6dWhHRDBzL3BhSUIzc0Z3WGh3eE9D?=
 =?utf-8?B?YmlGNDlZWUdiUExPbDAwb1d5NlNzT2FhK0NyRVVRSUtZaFRuaVpNdTVaUXJq?=
 =?utf-8?B?cmFVcU9ZdnhwcGVIeTRIMFZ5ellkcnRBRmJrRXhJVWFiSC95bDhlT0xubHEx?=
 =?utf-8?B?Smc1K2RkcC8rRmVzZ3F2eGFYUVEyQ0xXYWJmdm93ZVVGKzJEdHJ6Mzk3aWZM?=
 =?utf-8?B?MmxVY0dnYitEbjF5akhidDNDTDBwM1RYQ3B6V2JDMmNrbzVMTXFLTzdrdkZk?=
 =?utf-8?B?Z2RuLzBIWnFpN3EwL0hoYldORmtKZlBOVUpSS3lDWDcwWXpRVWpTU0ZvamYr?=
 =?utf-8?B?bGdMSm5HUEJ3L3ROdm9qTGRPSllNMjZ1S1dLV0xwaUNhbGhHVDRKZlJDQmFG?=
 =?utf-8?B?d2taWU1BZU44TVJzT1pzbzlIb2JCV3hMWjBrc2RnSXUzK0dmenpZdzkwcGlo?=
 =?utf-8?B?R2hPaW9DZFp1UEhXdmdXZmtBOXpNSDFCbmtyK05wRVg0TUdzd28vV25kUStl?=
 =?utf-8?B?UVYzc1BrT3AwZXlvUEdEODM5ZkJQRy92TnRKR2J6YjdnMUk3NzNENy9rV1Bz?=
 =?utf-8?B?NTNldHhrR1NOUEpDWk9Nemt2QkJIV0FPRnp4OG5nV0JiaWh2OVFxU2FYUHZI?=
 =?utf-8?B?RCt4QTd3eHdKV28rbW14R3NGZFBCZks3Uy9WTFg1K0RvTWJUeTVrVk5MUW5h?=
 =?utf-8?B?eCtCNlBxSkZNcnMveCtVU3FFUnVleVZ6c1Jub2VwRC9SbnJIaCtPTzJmNkZZ?=
 =?utf-8?B?SEh3ZjBPTFVRUTZKUGpsVmVRakkzV1ROVmlMU2htMG5qUTIwVk1UMEFvcGRk?=
 =?utf-8?B?Ri8raUI2UE90SXlRSi9BeUViUjc1MnloVkVDdk9qMU1vRm5jRlZUdldLQ1pK?=
 =?utf-8?B?K3kyQlM0QU1uL0o4QjhGK1VtbVdRY05sS2c0bmxsNERhUkxNZzFENk5jQTVT?=
 =?utf-8?B?QVZtR1JHSXgzcUw1REhVdTgreFo3R2lyc3drYmtZdlk2dmd0alFtcmpQRjM3?=
 =?utf-8?Q?VCXtjzHjbWEUxrbPPZyrKFw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <632A854F651E234F8932097EAEA280BD@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341eb73c-8094-41a2-0617-08dd10499751
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:44:01.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /kz1UkzW2ysIpqRbr1DGctv/C39obcgdUasmVqkuewAa2uwtfXuP4iwHBKS4Ztlohv9RdrqIKwWB5VX+ynqjt4oiYmdeYf9JIelhxLxQBv/ir+OWMzC+zjhlmw8eZVsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6414
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCkRldmljZXMgaW1wbGVtZW50aW5nIEFUUyBjYW4gc2VuZCB0cmFuc2xhdGlvbiBy
ZXF1ZXN0cyB1c2luZw0KcGNpX2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uX3Bhc2lkLg0KDQpUaGUg
aW52YWxpZGF0aW9uIGV2ZW50cyBhcmUgc2VudCBiYWNrIHRvIHRoZSBkZXZpY2UgdXNpbmcgdGhl
IGlvbW11DQpub3RpZmllciBtYW5hZ2VkIHdpdGggcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVu
dF9ub3RpZmllciBhbmQNCnBjaV91bnJlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcg0K
DQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUt
LWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgIHwgNDYgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmgg
fCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmls
ZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5j
IGIvaHcvcGNpL3BjaS5jDQppbmRleCA0MzVmY2I2Yzc4Li43MjQ1MDg5MDExIDEwMDY0NA0KLS0t
IGEvaHcvcGNpL3BjaS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0yODQ0LDYgKzI4NDQsNTIg
QEAgdm9pZCBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShQQ0lEZXZpY2UgKmRldikNCiAg
ICAgfQ0KIH0NCiANCitzc2l6ZV90IHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQ
Q0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxl
bmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5v
X3dyaXRlLCBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAg
IElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciA9IHBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3Jl
Z2lvbl9wYXNpZChkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGFzaWQpOw0KKw0KKyAgICBhc3NlcnQo
cmVzdWx0X2xlbmd0aCk7DQorDQorICAgIGlmICghaW9tbXVfbXIgfHwgIXBjaWVfYXRzX2VuYWJs
ZWQoZGV2KSkgew0KKyAgICAgICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICByZXR1cm4g
bWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJp
dl9yZXEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGV4ZWNfcmVxLCBhZGRyLCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vX3dyaXRlLCByZXN1bHQsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlc3VsdF9s
ZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVycl9jb3VudCk7DQorfQ0KKw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9tbXVfdGxiX2V2
ZW50X25vdGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKQ0KK3sNCisg
ICAgSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlf
cmVnaW9uX3Bhc2lkKGRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9t
bXVfbXIpIHsNCisgICAgICAgIHJldHVybiAtRVBFUk07DQorICAgIH0NCisgICAgcmV0dXJuIG1l
bW9yeV9yZWdpb25fcmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9t
ciksIG4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZlcnJvcl9mYXRhbCk7DQorfQ0KKw0KK2ludCBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZl
bnRfbm90aWZpZXIoUENJRGV2aWNlICpkZXYsIHVpbnQzMl90IHBhc2lkLA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pDQorew0K
KyAgICBJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIgPSBwY2lfZGV2aWNlX2lvbW11X21lbW9y
eV9yZWdpb25fcGFzaWQoZGV2LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhc2lkKTsNCisgICAgaWYgKCFp
b21tdV9tcikgew0KKyAgICAgICAgcmV0dXJuIC1FUEVSTTsNCisgICAgfQ0KKyAgICBtZW1vcnlf
cmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTUVNT1JZX1JFR0lPTihpb21tdV9tciks
IG4pOw0KKyAgICByZXR1cm4gMDsNCit9DQorDQogdm9pZCBwY2lfc2V0dXBfaW9tbXUoUENJQnVz
ICpidXMsIGNvbnN0IFBDSUlPTU1VT3BzICpvcHMsIHZvaWQgKm9wYXF1ZSkNCiB7DQogICAgIC8q
DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2ku
aA0KaW5kZXggYjIxNDQ4YmMyYS4uZjE0MmUxN2EyZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcv
cGNpL3BjaS5oDQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KQEAgLTQ1OCw2ICs0NTgsNTgg
QEAgYm9vbCBwY2lfaW9tbXVfaW5pdF9pb3RsYl9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWlu
dDMyX3QgcGFzaWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5v
dGlmaWVyICpuLCBJT01NVU5vdGlmeSBmbiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZvaWQgKm9wYXF1ZSk7DQogDQorLyoqDQorICogcGNpX2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uX3Bhc2lkOiBwZXJmb3JtIGFuIEFUUyByZXF1ZXN0DQorICoNCisgKiBSZXR1cm4gdGhl
IG51bWJlciBvZiB0cmFuc2xhdGlvbnMgc3RvcmVkIGluIEByZXN1bHQgaW4gY2FzZSBvZiBzdWNj
ZXNzLA0KKyAqIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQorICogLUVOT01FTSBp
cyByZXR1cm5lZCB3aGVuIHRoZSByZXN1bHQgYnVmZmVyIGlzIG5vdCBsYXJnZSBlbm91Z2ggdG8g
c3RvcmUNCisgKiBhbGwgdGhlIHRyYW5zbGF0aW9ucw0KKyAqDQorICogQGRldjogdGhlIEFUUy1j
YXBhYmxlIFBDSSBkZXZpY2UNCisgKiBAcGFzaWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBz
cGFjZSBpbiB3aGljaCB0aGUgdHJhbnNsYXRpb24gd2lsbCBiZSBtYWRlDQorICogQHByaXZfcmVx
OiBwcml2aWxlZ2VkIG1vZGUgYml0IChQQVNJRCBUTFApDQorICogQGV4ZWNfcmVxOiBleGVjdXRl
IHJlcXVlc3QgYml0IChQQVNJRCBUTFApDQorICogQGFkZHI6IHN0YXJ0IGFkZHJlc3Mgb2YgdGhl
IG1lbW9yeSByYW5nZSB0byBiZSB0cmFuc2xhdGVkDQorICogQGxlbmd0aDogbGVuZ3RoIG9mIHRo
ZSBtZW1vcnkgcmFuZ2UgaW4gYnl0ZXMNCisgKiBAbm9fd3JpdGU6IHJlcXVlc3QgYSByZWFkLW9u
bHkgYWNjZXNzIHRyYW5zbGF0aW9uIChpZiBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VKQ0KKyAqIEBy
ZXN1bHQ6IGJ1ZmZlciBpbiB3aGljaCB0aGUgVExCIGVudHJpZXMgd2lsbCBiZSBzdG9yZWQNCisg
KiBAcmVzdWx0X2xlbmd0aDogcmVzdWx0IGJ1ZmZlciBsZW5ndGgNCisgKiBAZXJyX2NvdW50OiBu
dW1iZXIgb2YgdW50cmFuc2xhdGVkIHN1YnJlZ2lvbnMNCisgKi8NCitzc2l6ZV90IHBjaV9hdHNf
cmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZChQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3Jl
cSwgYm9vbCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dyaXRlLCBJT01NVVRMQkVudHJ5ICpyZXN1bHQs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHJlc3Vs
dF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3QgKmVycl9jb3VudCk7DQorDQorLyoqDQorICogcGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9l
dmVudF9ub3RpZmllcjogcmVnaXN0ZXIgYSBub3RpZmllciBmb3IgY2hhbmdlcyB0bw0KKyAqIElP
TU1VIHRyYW5zbGF0aW9uIGVudHJpZXMgaW4gYSBzcGVjaWZpYyBhZGRyZXNzIHNwYWNlLg0KKyAq
DQorICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNl
Lg0KKyAqDQorICogQGRldjogdGhlIGRldmljZSB0aGF0IHdhbnRzIHRvIGdldCBub3RpZmllZA0K
KyAqIEBwYXNpZDogdGhlIHBhc2lkIG9mIHRoZSBhZGRyZXNzIHNwYWNlIHRvIHRyYWNrDQorICog
QG46IHRoZSBub3RpZmllciB0byByZWdpc3Rlcg0KKyAqLw0KK2ludCBwY2lfcmVnaXN0ZXJfaW9t
bXVfdGxiX2V2ZW50X25vdGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpu
KTsNCisNCisvKioNCisgKiBwY2lfdW5yZWdpc3Rlcl9pb21tdV90bGJfZXZlbnRfbm90aWZpZXI6
IHVucmVnaXN0ZXIgYSBub3RpZmllciB0aGF0IGhhcyBiZWVuDQorICogcmVnaXN0ZXJkIHdpdGgg
cGNpX3JlZ2lzdGVyX2lvbW11X3RsYl9ldmVudF9ub3RpZmllcg0KKyAqDQorICogUmV0dXJucyAw
IG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8gb3RoZXJ3aXNlLg0KKyAqDQorICogQGRl
djogdGhlIGRldmljZSB0aGF0IHdhbnRzIHRvIHVuc3Vic2NyaWJlDQorICogQHBhc2lkOiB0aGUg
cGFzaWQgb2YgdGhlIGFkZHJlc3Mgc3BhY2UgdG8gYmUgdW50cmFja2VkDQorICogQG46IHRoZSBu
b3RpZmllciB0byB1bnJlZ2lzdGVyDQorICovDQoraW50IHBjaV91bnJlZ2lzdGVyX2lvbW11X3Rs
Yl9ldmVudF9ub3RpZmllcihQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QgcGFzaWQsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVU5vdGlmaWVyICpuKTsN
CisNCiAvKioNCiAgKiBwY2lfc2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUg
aGFuZGxlcnMgZm9yIGEgUENJQnVzDQogICoNCi0tIA0KMi40Ny4wDQo=

