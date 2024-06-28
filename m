Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2680C30653
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 02:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN17u-000067-1e; Thu, 27 Jun 2024 22:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sN17s-00005q-PO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 22:14:12 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sN17q-0004W3-0N
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 22:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719540850; x=1751076850;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=t8/p3fPnZlcj8MXmZCh8r+DKA+7/1pDLFH1EvMXJ5mE=;
 b=Z85rNP1BOAI5ejiVoiRey4wO4ftRngj1TfYYfbRKO+fmXncqdGWAA/IP
 jN3pG2LgX/rvpoBx2mPrJEAQZhgn9ewxh8FNEACily5J7ZC/4pMFjWax+
 9UPV4yl/MtQ9u/ndI9pcmP7c+nVSYBQKA1BzTB0OT2KHdlXnQ8p2UHVJo
 l282j15z7UdAlV4JeK3DHtl3woWxHAcSpb4dAS/GNp5ys33r7B+GF30td
 O/A1w6rUNEeIYxZKQxyrkIZQx8xBBL7R6dTEsjxdB68Ue0zHbe76QwwYY
 qDWbmoFqOlbn9lNsw/3Gz2oLVa0I4flIzjx/OE30UB7zt7oV+aYu5zO09 g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="123816548"
X-IronPort-AV: E=Sophos;i="6.09,167,1716217200"; d="scan'208";a="123816548"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2024 11:14:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndu0s1J+AyszwtDrFgXuCWgs96Fpn3m1+lrhL0tru3LS2x2zzOE6qvdiEo27xydb4HPEPZAK+dAls3alziqmbFUSLyZEJ2TGmIDKOJV9FjFflV9JBbeBB+8EiXuhnkrUrW+ipXJSltFemAK8tubBoVG09Zg8wQf0Pnn3OAPSF2+jW821QRCosOePwxM/5xkXOE3EUgK/71TNFnbNnOtypXX3PpDsEfqo3NG+qnoS7zpdtUo86lbVYWkRbVC6S5bN/0NhVcwUwRjVfJF79cMct2oGxmmJPcIXgkIiKLgfvL8+F3San68v/Ht+DXi6m6UdwC4oP5eB6o6WFyWdEocaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0bP3T/zoqkRpmM5Ppp3XHSsRGJHadxn96HfCNJwPc0=;
 b=lEeWufpy8i9tAe3hmI0g9KXRJkKKQ4H4B/TRgrlXEqOqPhQ1TljDd65q/QkfPTqqTMpXSy/iCurpl+DloUYjFjxsPb1sofwzem+dTJ97g31p0yxS9Jhq9uB4BTmO4wT4uOELg62HaS5xl7QJ08ny93/E/dw2/I4mOwX02arr3FAa9Yk+Zfr2x07WnV28s/qeCk09JvfsLeyUT7uCYSNATzBonz0dPqgkO/fiwCS4x/MFp3cpmmwSbk8V7Uf55gB4IUSGXjbBXA/a3KZpPb9M++pxdRF5Ik+Bb6qR4VeNiQebvceV75/A6ETiyQHQfv3bX9xb8bktXSqkpirhTcD79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB11173.jpnprd01.prod.outlook.com (2603:1096:400:3bf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 02:14:02 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 02:14:02 +0000
To: Gregor Haas <gregorhaas1997@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3] hw/core/loader: allow loading larger ROMs
Thread-Topic: [PATCH v3] hw/core/loader: allow loading larger ROMs
Thread-Index: AQHayP2mSGH2a++CU0K8DzJTQHZQb7HcblWA
Date: Fri, 28 Jun 2024 02:14:02 +0000
Message-ID: <OSZPR01MB64532A76A87E2BBE595FEB838DD02@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240628015036.1815838-1-gregorhaas1997@gmail.com>
In-Reply-To: <20240628015036.1815838-1-gregorhaas1997@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=0aa79047-7dec-4a7c-88e3-ef11738503b6;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-28T02:09:15Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB11173:EE_
x-ms-office365-filtering-correlation-id: 1eb6e113-28e3-4450-9e70-08dc9717fad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?YlJOQVQ3K0VWazRPaDduQTlKNGt5RkgzNGJ5bmlrQkljYXdRbU9HRWtl?=
 =?iso-2022-jp?B?dVVWOGJ2SFpQR3huQXBuRHR5VHVzbDBTWkZ4bTJkNVRJM3VwWGFlRzhx?=
 =?iso-2022-jp?B?WE40WEhsWUVqRWovQ1R1d2IyaVVHZnhhdkdIQmRyM0wvYjRZa2hFdHh0?=
 =?iso-2022-jp?B?UEwraUdTVFhTZFpzbGp5Z1E2K1IyK2tKK3c0ZmR2UFpKeXltTEkraFFu?=
 =?iso-2022-jp?B?WVNOMEFDR2czbFB4cmJlQmxnV0FXa1dhTVJ5NmllRHpHWlRrWHcxV2NL?=
 =?iso-2022-jp?B?Y1JJWGRSOExzZ3RHanpUemVwYUZ1Yms0bStzYzRLS1FvRUpLQklYZHVs?=
 =?iso-2022-jp?B?dGVuK2dSUHk3dDVacVBCRHpXU0NZbHJEV2k4Rk9XR21GRVBFTWE5a2t4?=
 =?iso-2022-jp?B?MEJGdjNXTjMzRmRmS1FUTXJmWngrTUhSbE1kWWh3akhndWMzeEFTcHA5?=
 =?iso-2022-jp?B?TGVHemUxcy9TWmx5bU55TStSQkhFbkhFb0U5N254MnlBa1k0R0ZOSFpw?=
 =?iso-2022-jp?B?SUNYcHZoS3RGdlRCU1FVdnM0djlXYW4rcmx0TlJ3d3B4T1hRQ3VYaVNL?=
 =?iso-2022-jp?B?WVpOZy9kNU5KeCtvT2RzTFJOZFd6WGNCakZacExYc2dNbkx4QzJmN2hi?=
 =?iso-2022-jp?B?Y0JNdjZvU09OSDV4cG5JazZCTzNvamZnRENRd0hzWFdVOVVyaERmaVVN?=
 =?iso-2022-jp?B?RUlMTEIxWC9ya0wyZkgwN0RGdUZNajloVnkrQXFVby9vQ0IvTkN3Z3dP?=
 =?iso-2022-jp?B?S3F6T0FWdEZ5Q3J1dnRlMGRUZTZiM3JCc0RYTC9JNGYzdnIxVUpMUGZT?=
 =?iso-2022-jp?B?UmJKem9ueE82djBVd1k4MFpJeU1kQXFUYnNaaHhIVmtxQTJ0cDEyaWhP?=
 =?iso-2022-jp?B?T3VVU21qekljQVZEMzNzVWVmOHRPbjJUN0htd3R1aVNjSEVBNmJoQytR?=
 =?iso-2022-jp?B?d3JTemJ3cnJFd1ZZZVpZa1k3Mld4NmtSU0VHMlFRTmVsUTI4Y3Ftd1Fv?=
 =?iso-2022-jp?B?cXc1Z25wSHBLV1RET3ViZSsyTXJ2dTNRTUJEZnJVaDBzK1o2TUx2Nmda?=
 =?iso-2022-jp?B?QWFjUFlqRmt0aWRGVGxjTWVFM1hlbm42VDhkQUFoVWoyT1c0U3NLUG10?=
 =?iso-2022-jp?B?L1JVcytCZWRsQUhycXo0NFNReFE5cEV2Qy9IUDd6aGo4aHZMMGJFTHhy?=
 =?iso-2022-jp?B?Qm8xcWxpbzFkZEtCc1RIVW1tQmlSZ2NFOGRqRyt2ODJEOVovSStUVWNV?=
 =?iso-2022-jp?B?MDdXZTYwQ2cwL2xlS3BHT1Nka2gvWHNJLzNORmNnTmcyaGVYek03RXNW?=
 =?iso-2022-jp?B?MkNkSkZPQUE3cFhXRnVaYUw4Wi8wK2NCWWhQWDJQZjZ0UDFIYm1ySWxE?=
 =?iso-2022-jp?B?M2JxaFExdVA5U1BaWCtJeWpVWCt2KzA0SXVVSHBCdEJrUVZqclBPbkox?=
 =?iso-2022-jp?B?U2R6R2tSZTBUbmhTRmtMWjMrTHU4ZUVHVkx5NTREU2dvZGE5QnhwV3lY?=
 =?iso-2022-jp?B?eThjWGJ4WkJ4NHZBMTBhei9ETWJPNTFNMDhLNkhnQjl0bkN2ZTh2SW9X?=
 =?iso-2022-jp?B?bzEyaWdOSFgwSXVHbTdIOWhoWCtydEhyVFZGTytZSzRzVTdsL1FrMkFy?=
 =?iso-2022-jp?B?em5VZjFjeWFIUWFuQXh3c2dPcnRnU3MrUExtdnRULzJKb2dOd1FiemRG?=
 =?iso-2022-jp?B?UHVJMDVTTVRNTTlEblFkNXRocXJzeVNJOE9FZVpXVjZlU0k3eGlndVNv?=
 =?iso-2022-jp?B?RnZrNE5hUVB0Y3VnREhmUkFGZW1QMkhBOS9qSGZwd2RMT2RQY29JTDJx?=
 =?iso-2022-jp?B?c2lDS2tGcWJ2ZlQvN21RQnFNdVJRRXl4c1F3L1BTRk1UTjdmMnl0eDJY?=
 =?iso-2022-jp?B?TkZYZU80QVkxZlZiV0ZrVkRBUjNsZStqYUoxbGpmc1ROUytaUWI1VFF4?=
 =?iso-2022-jp?B?d2dIUExpVHV5Njg4VFI4c3NBcnJJTWc5ejNTRWgwdVBLTytZamZSNmJp?=
 =?iso-2022-jp?B?akJMMmxvUnI2ZFQzZC83MlA4UWRtenhGOVd5R1g5NUhtTTc5VEFzRE14?=
 =?iso-2022-jp?B?ZG4vQUhETVFMNTZwUGsxdU9YTWdEc3c9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?L2o1TVVhUVI4V0pOeWpFR2cyZ0ZvZjE0bW9pdUhHazJzeDRqdXpFS0JE?=
 =?iso-2022-jp?B?ZHh2eXN6S2pmeVFzZ1poMHVGZ1Bla3ZNVXhYMC9RUmd0eGF6S0ZXQjhQ?=
 =?iso-2022-jp?B?bnRFZ05mb0MxY09qRHJzTlBvYlBTNW0zS0pLeTdsWmhoOGxyR1MzK1Vq?=
 =?iso-2022-jp?B?UkZEd1dtSmhsc1M1T2M1SVVnLzBWd2x1dktBZkZIOGdmTDBmT3I2a0Nt?=
 =?iso-2022-jp?B?WVdQdUYzQ0ZvVy82N2VQTEJOTVBjREJHeEk2TzJSaTQxVlBoaWZBV29F?=
 =?iso-2022-jp?B?SCs4S3ltcTIyYSt1dEpnV25hOE5zemVDbW52WDdaT1JLbGNDUVR1WmxS?=
 =?iso-2022-jp?B?eDhhSEZ1b2ZhMjJqeXJjalJSbXlKWEJzRVROWURsVTJVTy9lbzdEK1JY?=
 =?iso-2022-jp?B?T1JiSm9IVHhPZ0N4cUZrUTRGRU8xYUhKVk1ZeUJKREc5SURIZUdsNy9u?=
 =?iso-2022-jp?B?aGcySUlnTWloanN0ODRlVEU0Q0YzVEdXNm8wYmFnMExuMVdvZ3I0Ujh2?=
 =?iso-2022-jp?B?RGxnbjdhaU5qWkoxTmx1SmRJZno4Y21pSWtwbGlCYzBlU2l2azgzd0dr?=
 =?iso-2022-jp?B?QytwUXcvL01teDZmVEIxUUxldTgvTjFwbjJtLzRyLzI3YkxtaUNvdFlE?=
 =?iso-2022-jp?B?b3prMEtJRWlMRG1LcTl4NXJhRkc1MXJ1bXgrYkhaL3V2bnU2Y3VhYlJU?=
 =?iso-2022-jp?B?MDBuSGRvbnhCU3dGOUE4N0xvbFVXa09TQ3dpU08vb0tHZlYydnhOMXdj?=
 =?iso-2022-jp?B?Q3dsWEh4TEh6UTB0Y1c4Nmp6dVI5R0JjdXpraGYwS005YWJ4aUQzNVVv?=
 =?iso-2022-jp?B?L0RHQVRhNG1CTENudG85Z1FOclpiMi9BdEZId05xVWVveDVlaldTWXF2?=
 =?iso-2022-jp?B?MDY3Yms0aFBBNEQxbHNtcVRMblZNYWRJbjc0ei9XRzRHTzAyTW53M2FD?=
 =?iso-2022-jp?B?Y09SdzNpaHhHSUZTSE1BUUpTU0R6d2hkOVZMbHRaWXhiL0FDU0ZOdHJ4?=
 =?iso-2022-jp?B?a1Q1Q2JEWUo2MkFmWHZxdElUSElkOG9nakxiMHVycHlFREFHZjdPREhU?=
 =?iso-2022-jp?B?YmYyRnU0ZDhhbFBQVGcrTXdCMy9aVXZhTWVqblhrSGsvYTRJRkVSdHpq?=
 =?iso-2022-jp?B?R1QwNlJMWTlkQXBXYkZTcHJkT09QVUs4alErWkRHUElIVkNOVHREazZC?=
 =?iso-2022-jp?B?SDZUU1ZscDkrSTM3Qnl3ZkZyYjhHYkVUTVBON2J1NGRZZVpKdkUxSmVC?=
 =?iso-2022-jp?B?QStPZUdYWVMrRGhsTmtJQ1FrNlVlRVZIblJIaHlmVEZyMktGR0N0ejFF?=
 =?iso-2022-jp?B?djRUQlYyWk9JZ0tQL2pTSTZFSWNZZnBaSmVDSStaeDJsV0VNbFZRM0k4?=
 =?iso-2022-jp?B?RUVSdXNLanhRYnBEKzM2bWZaSWZoMDNTaWZvREc4SzltRFR0Y1JHM3hB?=
 =?iso-2022-jp?B?MmNmbHdvb0VSZG1ndHJES0s5aE5HWk5EektLNktSSXRaVDEwdG56L05C?=
 =?iso-2022-jp?B?QTdWdlRURU1VU1pXQUxQY3lCQVMvTm9oYUZ1UkxES1ljOHloam13NkMy?=
 =?iso-2022-jp?B?eE1xc3VkekFZU1ZyTklGek9oR2UxYXA1dHpDaFhGL29ncXczc1g2c1la?=
 =?iso-2022-jp?B?R0o2dnpDeWNTTENyTWVLMk5DWkI3UHlNeEExT3JuaXVxN2JJRzgxQ3Bi?=
 =?iso-2022-jp?B?VkVJT2JYZDNJd200ajFFWUJZSnNiRnhXU2FDeWQ4TkNqdGtWWVhtMk45?=
 =?iso-2022-jp?B?Tjk4UkVuK0Q5NHNQSEpTQU10cFhHNlVsZWV1czl4SzJWalR6bzVKa0dt?=
 =?iso-2022-jp?B?UDVROUZOUzhnbjJKNUdBcHZzOUdFWC82d3dGdkcrc3h3VEVYcG5KZ3Yv?=
 =?iso-2022-jp?B?eVBacVRPdkdZSU51c0lRem9OM1FxMFRYSlhRR2lNZkkvbWQzajByek00?=
 =?iso-2022-jp?B?clhsRFpZMTk3U2hoeHhUdVFtOFpPRm5OZUVLeGt4elZYR2x0YXJMTW9D?=
 =?iso-2022-jp?B?dzk1L1BSQk5hV3BFazluOHV5SjNOS3VNbzFEV3UwZ29iT3VSdnUxak5F?=
 =?iso-2022-jp?B?QVFnQmpIaFJ3d1lWeFJLeFFmY2tVeG0yRHJUYm9OT0FVRzBaRjdGVTJY?=
 =?iso-2022-jp?B?TmVLSnpOUElIckhXMFkzMHR4YmFVcWV4RlFHWHhsM2pOakpSZTNIWFVY?=
 =?iso-2022-jp?B?K0IrSmRMR2tFdTc3aHZNMFBUY2lFMFNGQmlheGJ5b1dwN3psNS9sUjhD?=
 =?iso-2022-jp?B?UjllT3J5U0E2Z0gwUnp1RWdGckZ3T3JuTmNZWGRGR1Qwa3FRbitzenZT?=
 =?iso-2022-jp?B?OXRtRw==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tI7rP54BBIyd4TtGvcmNACXZbfmjxJh22Hew43fdCN/HSWuCcmUt+VCa8N42yo/Yo2ozj4gmmJ2D14jRPBtpwMsWbt8rd0KEyShLmeU3oKLGUVuW/S5jOppbnooZ3IsqIqUrrWfX7R4zpGZnorFkrk9ezcpmjAAayMM9iKWyVRuVWtUaGbC/OMk6fBvFwalzfiSzbq0JyTr+3mQt3QuaSHfgKdfEF9FcRCGp09LIq+pKgTBR7X2Iu3w8HGF7kaEu34Y/LzVRKvlAcPj2AJ8/ENRCNeWF+EF4Z6z7pdsi3aCFZkegsF2d26DRO5+AszGduLU+THVJeM8QJxhpDhoPqXrigtfKICfwBbrBSNBWejW1quVTM+rZfjiBiH2h3pzLcoZAcH/j/xeZ5266SWjT3QcquZQnJ6vItb7F0g7eATc9tnMNMBrq8UiicL2BUfiNAcl1VynuLaSgESSHp7opfhYtaSBLThcpzHcQKF8Q3BPfo0JdbNCFn9iQ6pCT7QGstAcaJGNrXFaLdQi3ThsZzBaWuKIWzn9MtEd9/UGRec2dGwm/wr/3HGNrbW2S0EO2hpRRi9XUNMtjM9UcW/S/vqUxDTEBEZ8f3I2ZHQjF2gGIOYTeqGHFDqOLBwjD5yx7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb6e113-28e3-4450-9e70-08dc9717fad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 02:14:02.7831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzGIzil7HhRcXLjiXtQaE/Tk8G6X4hYXyqGf8XfDRMUeYMaa2+Bn3CoajbTuoVq6o/VIlDT03QEjInDxZ4AYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11173
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
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



> -----Original Message-----
> From: Gregor Haas <gregorhaas1997@gmail.com>
> Sent: Friday, June 28, 2024 9:51 AM
> To: qemu-devel@nongnu.org
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; Gr=
egor Haas
> <gregorhaas1997@gmail.com>
> Subject: [PATCH v3] hw/core/loader: allow loading larger ROMs
>=20
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into accou=
nt,
> instead failing if all bytes are not read at once. This change loads the =
ROM
> using load_image_size() instead, which correctly reads all data using
> multiple calls to read(). Also, the ROM size is now determined using the
> get_image_size() function rather than using manual lseek().
>=20
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---
>  hw/core/loader.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 2f8105d7de..c2c61158f1 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1076,7 +1076,6 @@ ssize_t rom_add_file(const char *file, const char *=
fw_dir,
>      MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>      Rom *rom;
>      ssize_t rc;
> -    int fd =3D -1;
>      char devpath[100];
>=20
>      if (as && mr) {
> @@ -1094,19 +1093,12 @@ ssize_t rom_add_file(const char *file, const char
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
> +    rom->romsize  =3D get_image_size(rom->path);
>      if (rom->romsize =3D=3D -1) {
>          fprintf(stderr, "rom: file %-20s: get size error: %s\n",
>                  rom->name, strerror(errno));
> @@ -1115,14 +1107,12 @@ ssize_t rom_add_file(const char *file, const char
> *fw_dir,
>=20
>      rom->datasize =3D rom->romsize;
>      rom->data     =3D g_malloc0(rom->datasize);
> -    lseek(fd, 0, SEEK_SET);
> -    rc =3D read(fd, rom->data, rom->datasize);
> +    rc =3D load_image_size(rom->path, rom->data, rom->datasize);
>      if (rc !=3D rom->datasize) {
>          fprintf(stderr, "rom: file %-20s: read error: rc=3D%zd (expected=
 %zd)\n",
>                  rom->name, rc, rom->datasize);
>          goto err;
>      }
> -    close(fd);
>      rom_insert(rom);
>      if (rom->fw_file && fw_cfg) {
>          const char *basename;
> @@ -1159,9 +1149,6 @@ ssize_t rom_add_file(const char *file, const char *=
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

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com >



