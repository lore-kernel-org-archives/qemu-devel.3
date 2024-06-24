Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1144DC27C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 00:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLXBH-000582-EO; Sun, 23 Jun 2024 20:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sLXBG-00057q-51
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 20:03:34 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sLXBD-00089J-Cr
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 20:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719187412; x=1750723412;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AETVYDM0oSEY8CEXQu3iUypbz038ElFhpxesYzMLu0A=;
 b=hdFB9yZ7gDYgR0EON11iveq/5DBcbeWlbP7dHSp3P9ETPRnIEa8gtlf0
 51MFzRF1EmQe5a2O/EkVRms6r/O8uhxrWC87eyj1KeeEgLzocfGHxbixn
 ZXzZ6V9oVgB7Hj2dzCI9kDSRq+6zu17Uqc3+DR9U0dTts8G8wiVcGa/Ta
 2XJZuKiEy2VbnTG1a9Qs7UCPHfkI7+ZG8nryBku38MYk0TJou0gMspJFO
 KSBVbayTRiOfk3OhLnTOthUfrU3K5pez18u88EAww4Jf7b77DzXdTg0Z1
 oP7vOUWbf10BlvtNJjGby9+/IscGMN3Y3wGjiVTDwc22io8cGp7cEHqFd Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="122665867"
X-IronPort-AV: E=Sophos;i="6.08,261,1712588400"; d="scan'208";a="122665867"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2024 09:03:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuPMgcSqfyZGqT8WpPEgkkkL/B6NYjbkNMPh8DSHk3fkZrPj+LfA9EEvAQzfRWeOq4ZiGimJ7jmtwU5wUeUzrxvOZDU+w6PD25vw0olh+616MFb0N/i/1mYGH4htIBXjfLSLwVGvkuwStoIrpBKbrDkkQ6wRU5YH/h+OMJYqmTZWcyEuHkVNHOWHCXks7/uP0OYLm9jcY8sGcm8b/HHMsigRJKbqttrQ3VgVTsdNP1xjX+b3X6PUy2yb4A6LoPOZVf+0ozFdQo8AeNcEyuGXSlBT23m9NFAZlCKY0+UHCNnbeBBmJGuD4L/yXEod5Z4TYXhlseJ5/MKRHv+n/LbGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUn+DF8oo6Vy4yNNhS2/kLV1mL/RIceoqsM9bqR5NtQ=;
 b=d8cuMOzyb+xdm3HJOQ5vsjF2JYtYNQuz497vSYO6RKYC0oefwW5HXNdVi2b76M2VgMsJN0Qmk929Qv+wqblk7nnASoG3+Zy4d8Xh8D7IuMVDMiQDEu/tSlApKb9/+qXQexpjnbVD1l5cITWXQBruCogvcmI3Ml4tWSY90GgbDYc8GxT5K8dkke4lsCPYdc/7lb+lRcacaRupPcSJBJGh9jSKrlPcQThHv3wJySaosfoKD1tuyH4FglW6TJSYSzUEuQKgMB6ulZl/JtT9R5B44HlGSU8OhDL5/meso0ohMK+oghyV1IYegfNRGxtp+kUew1sLzDg2qqEhKfw385cpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB5677.jpnprd01.prod.outlook.com (2603:1096:400:45::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 00:03:11 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 00:03:11 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Topic: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave ways
Thread-Index: AQHaoOInstysbz+9jUG5HE3z+Vg/FrGmOFTwgBRW0sCAGAb1gIADu3cg
Date: Mon, 24 Jun 2024 00:03:11 +0000
Message-ID: <OSZPR01MB645310228E3D311C971EAE728DD42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240508005323.28811-1-yaoxt.fnst@fujitsu.com>
 <OSZPR01MB6453BEE69D709FAD5F5431228DF52@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <OSZPR01MB6453195EADF10E5D7EB35B4B8DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <20240621160147.0000633e@Huawei.com>
In-Reply-To: <20240621160147.0000633e@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9488e62c-7db3-442a-9050-844bf5694c60;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-06-24T00:01:31Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB5677:EE_
x-ms-office365-filtering-correlation-id: 2ce53c36-6517-4f87-7fe1-08dc93e1097a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230037|366013|376011|1800799021|38070700015|1580799024; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?ajRBb1NMV1doRXpaSk1JMUMvMlkvL0RWdnNuaC9ha2JxNWgwRmp5eXhz?=
 =?iso-2022-jp?B?ZmNteS9DUVJ3dEU2cmFZaVg0bSt6a1NaWGNERnE4QkJYZThqR05XSzJ2?=
 =?iso-2022-jp?B?SXUrZE0waEx3OU5KTTZrdDRWSTNndW1FNFpUb2FhWUFvUldZMFFSY1FN?=
 =?iso-2022-jp?B?aEM3Z2NjbHF4VWVLekFudGpqTEYrT1hQMDlLbnhiTHJBV21KcXYrYVQ1?=
 =?iso-2022-jp?B?OGwxSmN3TkhyQVlnLzF3RlJvL29nL3VoRlVHWU83OHpvaXlMaWQ4eXpt?=
 =?iso-2022-jp?B?WjZPS01lRU9LditqeVR4OHB0ODNkYXpBWmlJMHJ4ZzdlZytrajYvMWgr?=
 =?iso-2022-jp?B?U3Ftd0JIa2VjTjJ3SUNnMmNBOWdJU09zV1VmbVVKNTdVNkU4UlRXOHJK?=
 =?iso-2022-jp?B?ZGVJUW9VUTZkYzhlLzJkWUxXejNTOHlwMENsemNCWFlTTnh2eXlCTHJM?=
 =?iso-2022-jp?B?WmZHcE5DUkJjSzZVeE9xS0tYOTNPR1ViRFBoeEpMZWlHMHlUR2czdzl3?=
 =?iso-2022-jp?B?ZXE5UUo3YmRMWkw5NWZsRW0zRk9TcU8xbytKM3RQR1NEVSt3d2FjV09E?=
 =?iso-2022-jp?B?R3lCZnhiREZOYklOL1Bqb1plNkRnT3pXTk8xTktTalRvMDUxQzFQdnQ2?=
 =?iso-2022-jp?B?QTBhZW9CazdsdEg2bGtxVEw3RjNQUzVkdjgrekt1L2pHaldCeUpMNmJR?=
 =?iso-2022-jp?B?U1QzU2VwaGhWekUwQTAzOWViMzVWWUZic0xtN1I4Vm82UkZHdHFjZnc4?=
 =?iso-2022-jp?B?Rmd2NUVMclMrSEpmczV4SytvWTZ6cmtHWlFram9SU3B6eUJIWThTaDNx?=
 =?iso-2022-jp?B?KzBsUHZxYncyTTZ5bTZnY0phQUJHUWVtbmRpb21ORTYwbnZ6NWNqR3lh?=
 =?iso-2022-jp?B?OVk2ZWtndGJzNE9Ndmsya0NRb2hleGtKaHplRmJUdnRQaEFYRndWSXFj?=
 =?iso-2022-jp?B?ZHJBUjlBM0RZcVRldUlSc3o0UjIyTUNzQUR3NW9zYnhHMXpEVTBBNlJq?=
 =?iso-2022-jp?B?VVlNd0JFV29XY080SzBLRWZjdjhDTGU4UlVGZjc1aXpuQjBwZ3hRZXVq?=
 =?iso-2022-jp?B?aStGemNiM1RYUUV2M2JkVzJMZWd1bC9xUWgzYWt3ZkYzbTltWUVBM2RY?=
 =?iso-2022-jp?B?NlJhZnZDSGhOa1VTbmlyTXdJOGkvR1J6TFN6SDk5aTdLZFFSaWZwSldm?=
 =?iso-2022-jp?B?blZUQisrbjNhMll5eXVZbmlyNDRiZ21HT0V3Y1BYOExJbFpzNzAydnZM?=
 =?iso-2022-jp?B?WmlxeEFGUEl1SjlQbWpoY1hqRm9MYUlINkhXQWRpc1M5SGljTnhnYUNR?=
 =?iso-2022-jp?B?VU9WeDRhMnFSenlOK0o5clBNQ0I0dC9Rc0Q4OGg5YnFFYWVMQkZ3ak9M?=
 =?iso-2022-jp?B?R0ZwNW1vOU1TNkxpVzlPWmlSM3ZJcWFsb05vZUs5MXRRZXd6VDZVdjg3?=
 =?iso-2022-jp?B?UjJqSFBkV0E3Rkw4bWhuSDRJaUxlejdldDVVbUZVT2lkVlhkcG9PbU5u?=
 =?iso-2022-jp?B?MTRwaWZJU3dDUGthUUhTZ1FFRGtIa1U0SWtKOTFBeFZ6SjBsQnBWdnJr?=
 =?iso-2022-jp?B?YjNLQmlIdDZOTEdrYVEvay9LcXgzNDJYM3VqaENWWE93TGliVVYxR3Vh?=
 =?iso-2022-jp?B?b2xISWgvWlkvNWtuM1pBelQyb0JKOUkvbVI4NWZCTmNTU2lTS0Zha2Er?=
 =?iso-2022-jp?B?Q2U0Zm9pR3NScjdIdjBLRndUMzJYZ2hReTRTaHVGRHoxMUlOTlNuclpL?=
 =?iso-2022-jp?B?eDZFd0R5QmhwNzF6U04zN1pzekZKTTdoaTdLOFJSN1RDMk5VVzdCRGpZ?=
 =?iso-2022-jp?B?TXE5V3lzR3g1R1gwMERlSjFORGlQdnlSNmNkcis2RHhZTW12YUlSSjNC?=
 =?iso-2022-jp?B?M3FtR3lmY1lXVWc1L2FVYmdsOG9penJrVi90YkEwd0dtWVR6Ty9ZVEhJ?=
 =?iso-2022-jp?B?ZTI0eDVUV0g3YnZQajF2N3B5RURjUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230037)(366013)(376011)(1800799021)(38070700015)(1580799024);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?NHVPamlKWklmZkVuZGh3VUFzTkthVmhGN0kyNk1PejFrQjkvUHBJWU5z?=
 =?iso-2022-jp?B?dWxjaGNUaW90SVpHajh4Q1kwSmNrOGhVUnN1aEFhdEkrbzlzc2tCSFBZ?=
 =?iso-2022-jp?B?YS9qRmFJZ0VGU0tGaW95ZWExNFMxcnBwSjh3L29qT1VDOERxanhYRFlh?=
 =?iso-2022-jp?B?SUpiTDFVdmhqRWt1T1lhbDQyN2VGbnNOcEhKd1JsNHN4ME1vdll4aDRX?=
 =?iso-2022-jp?B?OVQrYzBNMUl2Y2xhYXlNN2lrQlZ3WEVVNVpNNkRXMitnc0RMQUdMOHJW?=
 =?iso-2022-jp?B?bnA5MW5XcU90TWpLbEF4TDZPSzZvVjNJNmZxa3dTZWRZaXFEYTRIc05W?=
 =?iso-2022-jp?B?T1NlajlSTnkyREhiMk5JKzh5aERiWFU5TkMyRW54NjJ4ek1GWXo3L0l3?=
 =?iso-2022-jp?B?Q2xmUkVQZmI1c21CWHd0US9ycmowZi9TQUVTM0JkOENOQmtHY05Nckx2?=
 =?iso-2022-jp?B?cmQ3cHZEdTA0Y2JDRTgxZjVEOWJFSnVIa3BUdm5zMlRSMHNVVkVmZ2pB?=
 =?iso-2022-jp?B?UWcySDhCVFlMSXZnQUY4UDVQbkZRMFJGaXdCbkdGYnBxaThnRFZwME8z?=
 =?iso-2022-jp?B?WmpDVzFFZWJkd3h6MXkzWFNzKzdGc3dFUlZFRURRZldsNEhxYlNpb1Z2?=
 =?iso-2022-jp?B?cDdmWkk2R1RIWTNTZHNHNytXYmVTcWc4MlVCM1duZ2RMajdFaDczdDk2?=
 =?iso-2022-jp?B?TVBrRnJrZmxlbllrTjNwcEdsb2VIMFQ5VFBPNE1zWnRlRXVjaXdla0Vj?=
 =?iso-2022-jp?B?MEFoTWMzcG9hZE9FRTNPVHNZd2grM0RaMzlHSDh4R3BkelJZU2Urd0VE?=
 =?iso-2022-jp?B?VUxzbkFRQklKVXpXS3RtVlpDNTVDejJZVFBBbVE2VjRXVzFvT3pLdXBp?=
 =?iso-2022-jp?B?aXUvbkQ1eUJYa0dsWFUvZTA3ZVZaTVNFKzlEQmVEcUpuMm9kWXZ5Wk95?=
 =?iso-2022-jp?B?eVVaUjduaHkycENLeU1BbUZzU1NBNFl1V3F1enpNRkV5c0pmNDU2eGJq?=
 =?iso-2022-jp?B?UG5DTjZKd3JYRWluMldtK1NZT1FHQkdWbVgzS0tUSDYrcTcyQjFDTzIz?=
 =?iso-2022-jp?B?TithL3FOK1hRdW03RkhoOXdFcXNqMXNMQXQyazROL0k1TGcyUnU2R2Fj?=
 =?iso-2022-jp?B?MVB2ODFvbVJIY3BKM1hBUEJiNklLODA3dDg3Z1dkNzVjbVUvZi9ua05M?=
 =?iso-2022-jp?B?UTZtbFJ0UTRKUUpqNFprb1VyQk13QUlxYUZmS3dFRGMyMjZwM2lJNklG?=
 =?iso-2022-jp?B?cStSM3NGdXlpc01OZUxCTzRUcGtyLy9qc3MvWEFucUVsYXhrNVI3alpp?=
 =?iso-2022-jp?B?aEZxWVltKys5UzIwWU4rZGVVdVhkS0o2dHdyMUQvNERSc1QrcWhhZE5K?=
 =?iso-2022-jp?B?NWlUc25oaUZhY1BhUWNnWWd0bjNvV0NBSjRzTGl1alArS3d2MlEvTGhj?=
 =?iso-2022-jp?B?eXFBN3ZOS2FPblFuZVNSN1Q4UkJNM1pKcnU5M1dXRjFwNzdMbXFYYko4?=
 =?iso-2022-jp?B?RWFPMTFDdkNrc09McmJHRDc2djZSbnljR1l4K2xaU3pvR1c3ak9rSTNn?=
 =?iso-2022-jp?B?TWU5SEUxcGM5VHNNR2JmU3FLeGk4TTFxaGR5TkpIS2lER0d0YmZZTzBr?=
 =?iso-2022-jp?B?RjczZG1SOHU0bjNldTY0MWZWc3FBVU1LTnkvbDlxWUt2Y1dZN084eTVL?=
 =?iso-2022-jp?B?SU1LbU5wM254dUF4Sy8waTRpS1hjSEJBdmZDYnZ5dnp0NzZLelZXbnp2?=
 =?iso-2022-jp?B?ZG9MejMyTkVueGVZb3Q4bERjd2t6OHZYdHY0VjZLNHF5eXNSMkNLZ2hl?=
 =?iso-2022-jp?B?a01kVENqVzVUWU53RVBHallWOW9ESGVtL2k3dnJQWGRoTVlzUjdIY0o2?=
 =?iso-2022-jp?B?OVBkUGJ5UjNFRzdYWm9hclBvSUNETU5LcHhJK3E5aDRDaEVGSERUUWtL?=
 =?iso-2022-jp?B?b1l5bDJuV3lZMU5qR2VTUzZzczRXa3B0ZWIrb1FsVWtHbXl0OUJwOThL?=
 =?iso-2022-jp?B?cDJUcjNjaWFYSzl5UHlNV3Zpd1N4QTJtWWRIRlJ3SUc3MHE5ck85b05G?=
 =?iso-2022-jp?B?MWs5elVUSmgyQVM4aTRoa0hQSld1R0d5TURyMDJ2VlNoMHJ4RlJYVVJR?=
 =?iso-2022-jp?B?bUFIWUcxejk1amtsZGFMU1o2cTkzcXhxcEdaaTlCYllUTncyVlByQmRE?=
 =?iso-2022-jp?B?eXlaRk1HUnFJQit1QUxFdVR3d0dJS2xHcGZjY1BHaGZBSFNza3VualJk?=
 =?iso-2022-jp?B?QVRjbnZsRjZlN2tBeDVXMmhaUjI1cCszaFVUY05zZGtnZXFXT0ZxMnZh?=
 =?iso-2022-jp?B?ajRiUQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JgIH8yAkmGaV2Dqn1iK5bq/rdCaUK+m3xXbhUt4KB+bQd9RhtC1fabsJ6vXsRAmrnI9J7kRVq0naNW4jOG8Jo8ccry/mPgrCjmf1NZ1Jceap8BMUtjbjJebVQNOQHdd6hSEZeNN+R2JdIXeCsRcHfpvGPjMBKzAKCZlJthY/XPk+9c/kgSRDwTagvt4XETHXAaA+ulCAQ9GiTjLeFP2vlmSEEVjMPulGbQ7ejOgWkDuJjRkx6fW8BnleaExXNtfaOk7tZPW1T+uVyu+LZF9D8fMJ6t0x5mYltaAFDHegu8qsU/gQ2SIZ7OnxvE9z7tfyTkPVWBlCT6TnMuC8vFoqvgpmlnEBGWrvLqJMHUP5DOB0g9EfwWT+I5xtWAvk0dhmzYKs3Eb++QcLqzGU4FdumiPvvgru8buvrhiw86Z3sRt50cmcL/HuyLLOiSHlvrjhEiSQJJMkpzhGrvLh3CRUXVU56Gbwtn+omUepw23GWGqJNdfegcZ99FDsfNl3PneW/2ZwsLpdDkGcry96zkdsP6Bk2oyjF3XaGZidYsrmW3agO9oevGIWTwmsXyi7VktnxfTJK6XLmtuugM5GO8EPaW69Vkom2KlfS1xjie06VFf6964ozzrnIIAxR+auQ9lQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce53c36-6517-4f87-7fe1-08dc93e1097a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 00:03:11.5483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtPAOVVdakV/Sa+ncQQ6aNm5FpyU30Bphv3pLv9IZmuIbKQr6xftfrIFyfBrOzFsZ+KLe0fifi86NHTAztqOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5677
Received-SPF: pass client-ip=68.232.156.96;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, June 21, 2024 11:02 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: fan.ni@samsung.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interleave=
 ways
>=20
> On Thu, 6 Jun 2024 08:07:27 +0000
> "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:
>=20
> > ping again.
>=20
> Sorry for delay - I was waiting for some of the tree I'm carrying
> to get picked up before applying anything new.
>=20
> I haven't yet tested this as fully as I'd like for upstreaming, but
> with that in mind applied to my cxl staging tree.
many thanks, I can do some test if you need.

>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > > -----Original Message-----
> > > From: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.co=
m>
> > > Sent: Friday, May 24, 2024 5:31 PM
> > > To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>=
;
> > > jonathan.cameron@huawei.com; fan.ni@samsung.com
> > > Cc: qemu-devel@nongnu.org
> > > Subject: RE: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interl=
eave
> ways
> > >
> > > ping.
> > >
> > > > -----Original Message-----
> > > > From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > > Sent: Wednesday, May 8, 2024 8:53 AM
> > > > To: jonathan.cameron@huawei.com; fan.ni@samsung.com
> > > > Cc: qemu-devel@nongnu.org; Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B
> <yaoxt.fnst@fujitsu.com>
> > > > Subject: [PATCH v3] mem/cxl_type3: support 3, 6, 12 and 16 interlea=
ve ways
> > > >
> > > > Since the kernel does not check the interleave capability, a
> > > > 3-way, 6-way, 12-way or 16-way region can be create normally.
> > > >
> > > > Applications can access the memory of 16-way region normally becaus=
e
> > > > qemu can convert hpa to dpa correctly for the power of 2 interleave
> > > > ways, after kernel implementing the check, this kind of region will
> > > > not be created any more.
> > > >
> > > > For non power of 2 interleave ways, applications could not access t=
he
> > > > memory normally and may occur some unexpected behaviors, such as
> > > > segmentation fault.
> > > >
> > > > So implements this feature is needed.
> > > >
> > > > Link:
> > > >
> > >
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> > > > u.com/
> > > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > > ---
> > > >  hw/cxl/cxl-component-utils.c |  9 +++++++--
> > > >  hw/mem/cxl_type3.c           | 15 +++++++++++----
> > > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-ut=
ils.c
> > > > index cd116c0401..473895948b 100644
> > > > --- a/hw/cxl/cxl-component-utils.c
> > > > +++ b/hw/cxl/cxl-component-utils.c
> > > > @@ -243,8 +243,13 @@ static void hdm_init_common(uint32_t *reg_stat=
e,
> > > > uint32_t *write_msk,
> > > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > > INTERLEAVE_4K, 1);
> > > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > >                       POISON_ON_ERR_CAP, 0);
> > > > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > > 3_6_12_WAY, 0);
> > > > -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > 16_WAY,
> > > > 0);
> > > > +    if (type =3D=3D CXL2_TYPE3_DEVICE) {
> > > > +        ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > 3_6_12_WAY, 1);
> > > > +        ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > 16_WAY, 1);
> > > > +    } else {
> > > > +        ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > 3_6_12_WAY, 0);
> > > > +        ARRAY_FIELD_DP32(reg_state,
> CXL_HDM_DECODER_CAPABILITY,
> > > > 16_WAY, 0);
> > > > +    }
> > > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> UIO,
> > > 0);
> > > >      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> > > >                       UIO_DECODER_COUNT, 0);
> > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > index 3e42490b6c..b755318838 100644
> > > > --- a/hw/mem/cxl_type3.c
> > > > +++ b/hw/mem/cxl_type3.c
> > > > @@ -804,10 +804,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d,
> hwaddr
> > > > host_addr, uint64_t *dpa)
> > > >              continue;
> > > >          }
> > > >
> > > > -        *dpa =3D dpa_base +
> > > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > > > -              >> iw));
> > > > +        if (iw < 8) {
> > > > +            *dpa =3D dpa_base +
> > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) =
&
> > > hpa_offset)
> > > > +                  >> iw));
> > > > +        } else {
> > > > +            *dpa =3D dpa_base +
> > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) &
> hpa_offset)
> > > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > > +        }
> > > >
> > > >          return true;
> > > >      }
> > > > --
> > > > 2.37.3
> >
> >


