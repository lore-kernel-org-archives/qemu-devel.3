Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A3C67861
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 01:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtHcb-0006YP-88; Sat, 06 Apr 2024 21:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rtHcY-0006Xx-SP
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 21:46:59 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rtHcV-0007UT-Mi
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 21:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712454415; x=1743990415;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hWnBmIyIPWl45Aan9erKIEDoM7y6a0ApK5KlDyO0sdU=;
 b=VRVnA1D7oC4BDKdjlWIS3quq3agtdj7npvYvgI4JzKB/AX23NXIOXqMN
 Q+vS2oqTBiQC2+5qHP8fmQ9lKuMmWSbuDzLRSvhrZjpMRJE7PZqecedTD
 sW6k2CAiKuOx63jsBU+HjgqpSN2KQ/qQ+aR4zAV6edrO+Se3Uy5nj5g8W
 AAu+XceoO1NUeUoaQ08lRALeZ14OyGFrgLQ9kwJx0DQg8mBrmtCiLtv9x
 CfqfHxp39RqKgQuvNGl8tBIjw6mc1v/WMNU2H5/FzIvNyz3Uu/evTC3Ia
 yxMZwhRu4yC1zTr8LnyAWrqu8d5FpV1ClxUDy1rnZcUQsGukBI8l0+wtB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="116145843"
X-IronPort-AV: E=Sophos;i="6.07,184,1708354800"; d="scan'208";a="116145843"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2024 10:46:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKbpAB2tIp9UaWw2POwkSUUvP87OIL/xvwsKkaca9ZlNfiur402yCudyAALdppXvftAzXzPkz0ZXoOd3oFVa9vFaU826Nqu0qPchzcBIyVjTFttOmJwqol6o6kPh1fVZF+PlhBoPMA486IH5SEqFgACJrehkk6XeM5k7nJHv5RTjOeYUjyQRS42htilpVijaWfPZdQAsZEfH2LT9XVDY8saHeCiPG9ZB2Qj/iEgd8DLrJAfUAhcpAB7FmSd4XVw3eXL/qSRfuSj4UlBsNoQ1D5sGJ8y00qleH2tjL4eWchAyKG0g//yslqyu/Z5F3Jy8l+YKcx8KO2Z83xqd2BjyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLs+wITHKpQ2k+szBjfYE3h2fBNQEQc61ukeEjkOLEw=;
 b=CuTPwnfv4JzNxy6HMSf3wZVtWFT8QGDx7xCJaCNXdknraSskqnDGd+dtIlta0Xyn2LNSeuCE3cocvxQkMGT2foFdDyBKCLS2ab2frR8aMcPZyWZsseXkRw4mM0oxK7XxbwDx5qv7OJhBPUuWPdebubwe9Ohy4ee4ZoLcnDBlGBA13XWuKncXekaRFi/AStxIbI0UTNI1fO2lw5tuMFG7zTw6fXP4oc9Jem6OZ5SnDv6Lab4Q0s+Fy+6NwfNSty/9zoWnin6wPOZXZXjYHENjRDyoJQbk/B5/lUYdzjYzrXKjc0U7TH2TGwQerD3vExDO7nLocKGGNOH4wUPkaRtIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB8741.jpnprd01.prod.outlook.com (2603:1096:400:16c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 01:46:44 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 01:46:44 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jonathan Cameron via
 <qemu-devel@nongnu.org>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "Quanquan Cao (Fujitsu)"
 <caoqq@fujitsu.com>
Subject: RE: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Thread-Topic: [PATCH] mem/cxl_type3: fix hpa to dpa logic
Thread-Index: AQHaf+jv8Of5xYfdY0OlS5LMTSu6ObFLlWsAgAEVArCABvFJAIAGVd8AgAIpKvA=
Date: Sun, 7 Apr 2024 01:46:44 +0000
Message-ID: <OSZPR01MB6453ED7531E9722339CF67EE8D012@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240327014653.26623-1-yaoxt.fnst@fujitsu.com>
 <20240327132814.000057c7@Huawei.com>
 <OSZPR01MB64531A2AA07AF4C7C8C800F68D3B2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <20240401170050.00004867@Huawei.com> <20240405174544.0000167d@Huawei.com>
In-Reply-To: <20240405174544.0000167d@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=7be2a26a-5436-4c79-a40e-9d18ec246f1d;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-07T01:45:42Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB8741:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hR3v42XxmFyXKVMrJYbJBcoZLhzO4EdVICuWw2noSl/dGxOwTpHmi1JoAII0A0cScCFOoLW7qNjAEQD3FlluKLEIq+JOObR4qHD9Njmh7WRB5+SiJIk5Ot9pXttaPUCPq4fVCIX1hILzU7abKvBIKpKnezLIqGacbwmQDFurd2+dDXpMc7n6jfjTjBQuWJp8KAr5mawzdLX4dsNPE+LW5hY3ULGTsCK0tYY/PXtBnB5RKbhB8R7Do/kALvtHSl00zGhjyywAZaN7HkqfwYxX2u/bUSDzkWokebCB0eYuF+cMgdr02naN3CUTStNGJHw8ZrRoRCu5cVx7VnfJ5WOOaRAToW80dGQjMzsQCGVfh+Se3Pu/rgk+cuzeVDbEkAbbaF6Hd99TPiQtR9H1Jr8jPp6KICz97MUl3TnfVnx/KHazGwmWMMKE1pB97I4ELyhBC6p9gG4C5VewDZL3KPuLCh5XpCrrleydrj2I1lEV66RzRhSkQ20rucp/XwE1ELOKsj2xpHRXACBhgCVg17/adeojdE/KKRFyRAkWq5C4YNYMfTwf9lwRPF55ruTljCrVAm7i7QLE8g0hioCdVS3X8vgxNmb5LTtYmSPA7LthMB/D9gbyFlmVlOvBre7g8xG2lAwq+tgv4F8UsoIdZuoHnsEpBAyZaUksQ79ZEs+mb2s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(1580799018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eWp1TDJucXNuNTRjZGZ3UEE2K1J6Tlk2amtFK2JVT09SMTJlRmRjWjZX?=
 =?iso-2022-jp?B?MS8wTk1HMUZDc1hzT0xxWEFSZGVjUzBKVGdOc3ovd1VGQXdNZkhTSk12?=
 =?iso-2022-jp?B?NGNRMmRXVENmY0dVQjZVTklEd3FPVUdpMS9HcW8zUHBENTVXV0hlU3pG?=
 =?iso-2022-jp?B?OG1JZ0tBZk1sVnNUYW9jRFFycGhic2psb3locTQ5Tkd5YjNPV2xpNDNk?=
 =?iso-2022-jp?B?L2FvWGxqSnJ2YWRESWJLek5USW0yb0pQN29uMkV5eFd5bmFlbTVRWXFU?=
 =?iso-2022-jp?B?Y0UvdWIzTWNwdXZEOEhGekRvTW1Cc0EwQ1VjTloraC82dVJzWVpJQkZB?=
 =?iso-2022-jp?B?UnlSaUxTL2hhOXBjWG9PeDZsb2tQbktaN3ZNOUhMNXlEZC9Od05BOVJZ?=
 =?iso-2022-jp?B?cXUxSVh3UWh2STJwaGVlTk43NlRWRGdVay9JY2xPbS81T0ovRk1sRzNr?=
 =?iso-2022-jp?B?cXFUTlpYQlFEbHhNNkplMHJBTVY4WkhNK1ExbFo3WTh5ZUZkOVFVQ1lT?=
 =?iso-2022-jp?B?MWtwVnJZRlUwcGQ4VHN5cUhQbkRIQlA5Qm5SVCtva1VKZHhmb1ZnaGd6?=
 =?iso-2022-jp?B?dTNYYzJsWlVSaVVoVDlSeE0wNE9UVThwd2VvdzgxLzZXbENIYmEzVHg2?=
 =?iso-2022-jp?B?VElHaDFObTdTc1hRWCtWUC9YR3Bnd3UwN0lFUEFzSDVnVldqSGtwbEI1?=
 =?iso-2022-jp?B?UU5FdU5vaFBJcFc5TysvY0VKODVoN0dtMW50VzZlOEVWZ2Q3YTFIdGpP?=
 =?iso-2022-jp?B?WWJFeUtBZG81SnRMcERxU0hNUHcrdjR6bUFQMk12OTNnc0srZEpqQlBv?=
 =?iso-2022-jp?B?RG1YVjJzRXl4NjExdG1nbHo1NkNtWmJvNHVsY1pDd1NVWk1qVTJQMU1r?=
 =?iso-2022-jp?B?TFhtekFnbENObFppczRPcWYweEdZUFZIQ1lUekV5aHdpRXk5RFFlQkVB?=
 =?iso-2022-jp?B?cUFRYzI5eGdZbFo2VGFtc3dFTWZjOWswOUgwbGVqV0FCQ1plQS8vanov?=
 =?iso-2022-jp?B?RGplWlZXWmJ5bXJBRFcxcTVydDd6QkpFUTFwU2lKLzNWVGxqYWVnbUp3?=
 =?iso-2022-jp?B?WU5kcVVVbTFzOVhMVnI0b3pIM1NnblJpRlBUdkV4dU1oVFZ2SnluY0ox?=
 =?iso-2022-jp?B?MFlMVkc5TDJYc0lzaEFsczZ3YnduNVBEUUtvMEQ0OXNNWVFhOGJjbm1t?=
 =?iso-2022-jp?B?RUpOSzVxY2l6eFQrd3RwS0Erd2FuUTVudVJ2Q2hNdWRkcFFZNEVyYjV5?=
 =?iso-2022-jp?B?cFlldW5SQXpla2IwSnEvRHdZc2NmdzNqUDc2SUNURUxybW9nOHVpWm0v?=
 =?iso-2022-jp?B?cEhBeFRtQ2I5Z1hHMUFUaWZQZUJNY1kzOTlCSlhlcWdvVFJiU2JTQWNX?=
 =?iso-2022-jp?B?dGtadG93U2UrQ05MNlowV0FXdDhNK1Irb0JxUktrYWsrSkRNdWFmVGlY?=
 =?iso-2022-jp?B?N3ovYjgxUDZYTWtyUHAzQTBnSWdQWjR1WHFnaTc2YlYrbkt3N1hNbS9z?=
 =?iso-2022-jp?B?T2ZHZHhPY1NlcnRxWVhQODA3N3VmWVYvdkdNTjVxaVMxVzlueHlOKzRu?=
 =?iso-2022-jp?B?dVNmclJIMEppVnVGdEE1aFJwUXRyQXZIQm1tWTA4L2JFQ2xwQ2pKUDlU?=
 =?iso-2022-jp?B?ZzhwZ2tKRjVzUGNTU2hXMkl1eXU4SVNEMkJkTzltdnEvMkZWM01RNnNk?=
 =?iso-2022-jp?B?M3hqNEZOSHJzSjl3NGcwMHkrNTZJZ3ZrU3VaL0pMbmVxbHpWUE5MZFll?=
 =?iso-2022-jp?B?aTE0SVFVOWNaL0xnWEhCVno0VDNiY2o0SnVVZHh2UlJhRGhpUU9QZlBL?=
 =?iso-2022-jp?B?RE9HRHpkajRnSnFuQXlCUGlSVE5xSnhsdE5YelRoMlEvcUhlS0xHU0tx?=
 =?iso-2022-jp?B?N3FLVWVIZDhnTi90YzB6R0cyaXJmOU5vQWZSQ1NsMGtSVmJXMVcyZ05Q?=
 =?iso-2022-jp?B?eUNJclZHSFpwZHRLR2puSzBucjh2bmp3TkxMV2ErVjVYdFlrRDVlVHlz?=
 =?iso-2022-jp?B?c3gyMnVqZ09aUDB1clo4c1pvbWxmRVBBK3BBZU15aWUxOEVaL0gyY0Fp?=
 =?iso-2022-jp?B?aG9aTDEweGQyemlza0h6NllWczRPbVYyazI3YXR1TE1zYTNjK3dXbnVr?=
 =?iso-2022-jp?B?YTBkazRvRmZ6bGRrRmppNmo3NTN6TDBwQ3NXdEh3Y2QvRUs2aGs0dzdS?=
 =?iso-2022-jp?B?dXFuRC92bEI5bUdncXdSRFpIYnk5clZzbzI4UllLMURZQm41aWNUOHpP?=
 =?iso-2022-jp?B?MGVnaWVQSXpPcGgweHBNYlJpNGoxVFhSMk5hc2pWdkVidWJ0ekpLdnJu?=
 =?iso-2022-jp?B?Yk1Rcg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SqzQQPVlbrpzj9sU/CO0jze0vYBJh18d0ZtSAH7YjO36Zlr108ZcKUcG0NJzB7+J/uhOlzFmVw4M+qTHIIl8DndmHgPoceWdChiol8wHDaSMGLX9oHrKLfbu4jmhX6scRMQoCmQGXCDYBcETaOmiaQ4rvD1b8JuMHO8HMz95azhzbZDKuV5yYuV3yGNzL035spfAX0TPz3o+/kg1T0ylSXD8zU6/JkLAoh3Jq1/rzArlF6Yh0gbqhwCxT+2dPRcVfmYkIFyIaLbWi/5iZRni+eqHSXxkSIN9p2Lxu+1V0ypEtqkh+7XfX4Aa+JxUi6UkRvTSZsxnYqR/3pLrNkSrwyJ9QhkIwVs7k8AoY3ke+kuumsvTIrp/e1qmAzMlhGXBl06IRWwbKhjR0nsty5/0e3Cf8AaOofKxOqBVW53Uq+ks370lOfK40oXXh1xKXVJiBECRnHQKJgDAeiyASfL8hYZH95sWpTMBmWoWolbMSPUAOohy+S9HzAkCkSYOglrobeqPuIXmeZYVM0oitVOLkWasWzUTdLEt/YTMAtmwcjvUfYyRY0nn/Gvf9xmesAoih1n5cy5lRpENJ/qLl/dL/9Oa9DChNvCPXJPxBI1olzr2UYne6a2KiyNIyarsFzbO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd6a912-da2b-466b-cabf-08dc56a49450
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 01:46:44.2328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4GFnTZjT+4C0LFUcLtlz/ItTyMdR53qkY8Slgsptx5hMwftTzL5vyuSm5YdeshWZ47LlIE1O7+NpZA3iXSn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8741
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



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Saturday, April 6, 2024 12:46 AM
> To: Jonathan Cameron via <qemu-devel@nongnu.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>; Yao, Xingtao/=1B$BU-=
=1B(B =1B$B9,Es=1B(B
> <yaoxt.fnst@fujitsu.com>; fan.ni@samsung.com; Cao, Quanquan/=1B$BAb=1B(B =
=1B$BA4A4=1B(B
> <caoqq@fujitsu.com>
> Subject: Re: [PATCH] mem/cxl_type3: fix hpa to dpa logic
>=20
> On Mon, 1 Apr 2024 17:00:50 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>=20
> > On Thu, 28 Mar 2024 06:24:24 +0000
> > "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:
> >
> > > Jonathan
> > >
> > > thanks for your reply!
> > >
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > > Sent: Wednesday, March 27, 2024 9:28 PM
> > > > To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.co=
m>
> > > > Cc: fan.ni@samsung.com; qemu-devel@nongnu.org; Cao, Quanquan/=1B$BA=
b=1B(B =1B$BA4=1B(B
> =1B$BA4=1B(B
> > > > <caoqq@fujitsu.com>
> > > > Subject: Re: [PATCH] mem/cxl_type3: fix hpa to dpa logic
> > > >
> > > > On Tue, 26 Mar 2024 21:46:53 -0400
> > > > Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:
> > > >
> > > > > In 3, 6, 12 interleave ways, we could not access cxl memory prope=
rly,
> > > > > and when the process is running on it, a 'segmentation fault' err=
or will
> > > > > occur.
> > > > >
> > > > > According to the CXL specification '8.2.4.20.13 Decoder Protectio=
n',
> > > > > there are two branches to convert HPA to DPA:
> > > > > b1: Decoder[m].IW < 8 (for 1, 2, 4, 8, 16 interleave ways)
> > > > > b2: Decoder[m].IW >=3D 8 (for 3, 6, 12 interleave ways)
> > > > >
> > > > > but only b1 has been implemented.
> > > > >
> > > > > To solve this issue, we should implement b2:
> > > > >   DPAOffset[51:IG+8]=3DHPAOffset[51:IG+IW] / 3
> > > > >   DPAOffset[IG+7:0]=3DHPAOffset[IG+7:0]
> > > > >   DPA=3DDPAOffset + Decoder[n].DPABase
> > > > >
> > > > > Links:
> > > >
> https://lore.kernel.org/linux-cxl/3e84b919-7631-d1db-3e1d-33000f3f3868@fu=
jits
> > > > u.com/
> > > > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > >
> > > > Not implementing this was intentional (shouldn't seg fault obviousl=
y) but
> > > > I thought we were not advertising EP support for 3, 6, 12?  The HDM=
 Decoder
> > > > configuration checking is currently terrible so we don't prevent
> > > > the bits being set (adding device side sanity checks for those deco=
ders
> > > > has been on the todo list for a long time).  There are a lot of way=
s of
> > > > programming those that will blow up.
> > > >
> > > > Can you confirm that the emulation reports they are supported.
> > > >
> https://elixir.bootlin.com/qemu/v9.0.0-rc1/source/hw/cxl/cxl-component-ut=
ils.c
> > > > #L246
> > > > implies it shouldn't and so any software using them is broken.
> > > yes, the feature is not supported by QEMU, but I can still create a
> 6-interleave-ways region on kernel layer.
> > >
> > > I checked the source code of kernel, and found that the kernel did no=
t check
> this bit when committing decoder.
> > > we may add some check on kernel side.
> >
> > ouch.  We definitely want that check!  The decoder commit will fail
> > anyway (which QEMU doesn't yet because we don't do all the sanity check=
s
> > we should). However failing on commit is nasty as the reason should hav=
e
> > been detected earlier.
> >
> > >
> > > >
> > > > The non power of 2 decodes always made me nervous as the maths is m=
ore
> > > > complex and any changes to that decode will need careful checking.
> > > > For the power of 2 cases it was a bunch of writes to edge condition=
s etc
> > > > and checking the right data landed in the backing stores.
> > > after applying this modification, I tested some command by using thes=
e
> memory, like 'ls', 'top'..
> > > and they can be executed normally, maybe there are some other problem=
s I
> haven't met yet.
> >
> > I usually run a bunch of manual tests with devmem2 to ensure the edge c=
ases are
> handled
> > correctly, but I've not really seen any errors that didn't also show up=
 in running
> > stressors (e.g. stressng) or just memhog on the memory.
>=20
>=20
> Hi Yao,
>=20
> If you have time, please spin a v2 that also sets the relevant
> flag to say the QEMU emulation supports this interleave.
OK, I will.
>=20
> Whilst we test the kernel fixes, we can just drop that patch but longer t=
erm I'm
> find with having this support in general in the QEMU emulation - so I won=
't queue
> it up as a fix, but instead as a feature.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > Jonathan
> >
> > >
> > > >
> > > > Joanthan
> > > >
> > > >
> > > > > ---
> > > > >  hw/mem/cxl_type3.c | 15 +++++++++++----
> > > > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > > index b0a7e9f11b..2c1218fb12 100644
> > > > > --- a/hw/mem/cxl_type3.c
> > > > > +++ b/hw/mem/cxl_type3.c
> > > > > @@ -805,10 +805,17 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d=
,
> hwaddr
> > > > host_addr, uint64_t *dpa)
> > > > >              continue;
> > > > >          }
> > > > >
> > > > > -        *dpa =3D dpa_base +
> > > > > -            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > -             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) &
> hpa_offset)
> > > > > -              >> iw));
> > > > > +        if (iw < 8) {
> > > > > +            *dpa =3D dpa_base +
> > > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > +                 ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw=
) &
> > > > hpa_offset)
> > > > > +                  >> iw));
> > > > > +        } else {
> > > > > +            *dpa =3D dpa_base +
> > > > > +                ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> > > > > +                 ((((MAKE_64BIT_MASK(ig + iw, 64 - ig - iw) &
> hpa_offset)
> > > > > +                   >> (ig + iw)) / 3) << (ig + 8)));
> > > > > +        }
> > > > >
> > > > >          return true;
> > > > >      }
> > >
> >
> >


