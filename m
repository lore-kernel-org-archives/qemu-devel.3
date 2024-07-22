Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7879C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgm2-0005jp-GH; Sun, 21 Jul 2024 20:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVglE-0001p6-AA
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:43 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVgl9-0005uh-Sh
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721607515; x=1753143515;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u9J9WTCt+t57ptzKZI0QPfoUpnL8omwiAsrB/M1x9YU=;
 b=QV72lFnsi6eH/MOPFhk7j25/zMoj5hsDJEnlbugxFX/XE7n8aqJkBgui
 v+Smy3zv7vYW6AUNL0Os5PHyNi+7+xdfGMbm8H5dlqsmw2X/hmQShPzuU
 4QhW3ON/cS7wzpc+aKBcAYVMnTNhp8R/FswRx8UYD7phyuP+ED4dTUgEQ
 rsLh/smi3YAmrKhH+j2I+A0zpF9wboWBotX36jm2FpZ4rwtc/S4K77ldn
 95c5n2Zv5xsck9Qs8OQAp+U9imNo29gmIE+EVRRU5xiTQOTxkx3ZqiLV8
 gHTlydSB+oc/NcXfAPvaORQjp6ZpOKCa7ryi7m3EuXXv8jY0A+8eqfxBr Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="38763558"
X-IronPort-AV: E=Sophos;i="6.09,225,1716217200"; d="scan'208";a="38763558"
Received: from mail-japaneastazlp17011027.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.27])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 09:18:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNzU53uExonlYkp8w3S12L7HHgwDXd/OR8bqRFI7M5sK5hpWFSQFCadxIupmQeg7l4p/hk2JyFIjtmX8aOsMRdOtv4M+8Hgbt5E4Pq/hM0TkLhSkDYrY6xFfV+y+iqB8q9rfeAvFo8s2/SYa2w/PqpASgNNtlLp8bkooP4spznqI5PvkfxRXPLYpmi2eEyLPNNJ8hATt8sHn0u3tAluyPiWJJ7XLKSR/Ku5ZxB0jv6xzc5+JjPXuJ7gurQdFJYVlOlbpQGdvv5uQpZbf2nbeP4tJD5K7RgWvGPqkskasZ0LcwfYm2cwcJpFOjxU3MsxRq6yoT2D+2AqfKqkr8LGiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpBZLNWXm5yujSvVRl0LJGBdzjXMghva97ROimRB5sI=;
 b=djrGAekVHQfIjcjaBiTz5SycjwKE6U3dmo/IMn7P7mmsS2mwkQd8zf+BWDOz0e0a8XfD2glC2xJww3Ru8LANwNgGUB5UByur7v2Huo90bAMFn1GfMMP4aR7ozqF1O81QkFw1yihOqdxPGzQZpqoGK6Ok/fDA+Cz1OjEV0wysPIR2AZFUUaPM+gaV336T8j5O2wOn9GBWi5BlqYLmQXVP33xNgmZgQq9rsmGGm3NXrEvxTby/iMUQPANFS23PShDQR3N18mdmP94uz8HmW5T4W7ikO3CIfAMHpfSmxhww5TdystFD3d50BtsBmI4G9oBdKig37zGF7oFoDXzxK8L6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB7137.jpnprd01.prod.outlook.com (2603:1096:400:c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 00:18:26 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 00:18:26 +0000
To: Vivian Wang <uwu@dram.page>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
Subject: RE: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
Thread-Topic: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
Thread-Index: AQHa23ExAgtTxYSHz0SeV+prn1lU5LIB4KsQ
Date: Mon, 22 Jul 2024 00:18:25 +0000
Message-ID: <OSZPR01MB6453807448D47F3EFA427C878DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240721090817.120888-1-uwu@dram.page>
 <20240721090817.120888-2-uwu@dram.page>
In-Reply-To: <20240721090817.120888-2-uwu@dram.page>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=33624ca8-a54b-4351-b000-0fe684aab910;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-22T00:12:09Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB7137:EE_
x-ms-office365-filtering-correlation-id: 181b4262-cb34-4d5b-b66e-08dca9e3ce18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?NVhKZldsd0tIZm81UTQ0UFZMQ0lKWGtaRHBBaTJ3Sm4xQ3JHS0UxWlVk?=
 =?iso-2022-jp?B?cWZDWGpaelN6VEVBSUNNT0d2a2hmMzUxcjR3MGJFbWJsZ1pxaEtFazEw?=
 =?iso-2022-jp?B?QTBDZTNMZTl6LzBIUnl6WTM5S0dxeHhXVVM4L0ZiU2ZLY1M1T1dsa2hS?=
 =?iso-2022-jp?B?KzE5dStNSGd5L2VDQ0dvY2ZtcEswSEkxUkE3L3Z1dWl3VDlhd3J3WndD?=
 =?iso-2022-jp?B?T1FWZm1IS2pPSFREWFJwZzAxYmNSZFV5Ylg1dG02ZmRhZzNmVVY1RC82?=
 =?iso-2022-jp?B?bFpYRE0xSmdKUVhVdFc0V3hQY3Q4a2QxVWJEUmk4QUVKR2M3aEdMTGNk?=
 =?iso-2022-jp?B?N2h2a29BOUZPMnB0VmFsdnNld2RIbHFZT0dNMjQ2d2c1T01GMytPcDg3?=
 =?iso-2022-jp?B?L0NDaGlkOWlZVndmbU5qbzdQUFZ0RmRXc0tCbXRCZEtwWmpQTkt5OGVt?=
 =?iso-2022-jp?B?K1B4MkdYU09Td3lwRjI4UzJwZHNJZzNYTmtuTVpsWGcxSzhrQ244MU85?=
 =?iso-2022-jp?B?ay9IOHFtU3VSM1ZZcmNtclJWOW5mOWhhdnYyU082TUpZV3pzSHB1MTFN?=
 =?iso-2022-jp?B?bGpUM1UyeEJRdDFrQklCZHFxUTJoSjN5R2dCaHBidzZQSmQwUjBFOURY?=
 =?iso-2022-jp?B?VmJVeW12OWh1QWNhNTloU3VjYXluOTBQL3NTcHpkTlVDME1LcnNGRlc4?=
 =?iso-2022-jp?B?a2VUYm05UDNEQUJUTi9jN0U5eTdyRnF6cVIrMXhlaTN2T0MwQy9BMEJX?=
 =?iso-2022-jp?B?Q3lYcnErYzNBYTZHY0FNOWZuSjIwc0Y0a0E5VGdTeFlTdHlZUFFWbzZS?=
 =?iso-2022-jp?B?bm1yOENCdndoNlNyTWpCRlN1QWpSQW1zYkduMW1mZ0FjMExnR1cwdVJU?=
 =?iso-2022-jp?B?MEgwMG1vNGJKWnA0dmhMQi9RV09KbSsxWHo1elcrTVE2dVJsVGZ4ZlRa?=
 =?iso-2022-jp?B?RHQxMCt1UWpvNVIwV0VCMERWQ1pWM3MxMFovWG84L204UUE2bHVZVjNs?=
 =?iso-2022-jp?B?VXJObDNCcWh4M1U2bDJCZFY4YWwxeE1lTkk3blN0bkxzTFAvZnlzNFE4?=
 =?iso-2022-jp?B?VU5qYVRyU2tEallXblUvbWVWc1NsSXFaQXlrYmYrY0hBTjRTejc3dGRR?=
 =?iso-2022-jp?B?S0Q5Zmg1dS9qblhDU3pockUvUHM3QmtNWFV3K21uZ3JES1lITDl0dzZr?=
 =?iso-2022-jp?B?R0lhckZYVmdBWGhjR3plc3lMaHpDYzRqWURac1ZRVHNzZHZPNE5DRWtR?=
 =?iso-2022-jp?B?M2NTSks5U2Y0RjhYMHpMdlhlaDNxQUtDa05qaGxsMng0eVJFRVF1RjRJ?=
 =?iso-2022-jp?B?Y2pWSmpUNXdyeFJra25tS0VQYi9oRUIyUzhodkFWa2tmT2dlUnVmQlps?=
 =?iso-2022-jp?B?Nk4rbytvKzczT2h6S0RZSkQrRVlJb01MY2Z5ZHRFVTVFL1RvSW5yMFRS?=
 =?iso-2022-jp?B?cncwajJKQTd3QXBjbXdFMjlQRFNWd1hiaGFtSVk2UGZvdWtWbzFiOVc2?=
 =?iso-2022-jp?B?VENoZzRoNTRQVXhJL1ZQcHovS1VMS1hQcXRaTWNMS2JzdFRyeStzT1F5?=
 =?iso-2022-jp?B?c0tWSnRoWnZCb0x3MzZTa3FmWG9vNEw5YVR6R3IrQ0h3UVA2cHdnMTRI?=
 =?iso-2022-jp?B?ZGhQNGdpd2cxcGEwdG9SOEh6YzVJNDFsd3N2c2xFQVhZZnhWdVhFQm9o?=
 =?iso-2022-jp?B?U25zcmhqWHNJV1l4UlU4OWI2bU9ROEdnc0tuTlV1dzY5UzBhbWQ2Ykt5?=
 =?iso-2022-jp?B?MnNqVEZ4YXRXRm9pa3p2U1p5NEtrYU05T1lGMFJyOURzb2wxWXVMSFh1?=
 =?iso-2022-jp?B?VEUrbjBOSklaL0RqTnVxRXUreEFnWDNTR0lnQUFKMGZ0OGNuUzVQT2gy?=
 =?iso-2022-jp?B?b0lYY29nL1ZHc3l3Nmx2MzlmelF5UGJmUGpid2pVWVRFZWFCRDY5bVQv?=
 =?iso-2022-jp?B?ZHBtRzZ6NWltZFJudWJ4QnRLbjhYRGl4ejZzRXp6Rk5GTk1hVVg4cVFW?=
 =?iso-2022-jp?B?M3IzclNwbGxHaW9qZjgwSzQ3QjZwNTZiSTk3aElyVmI3amNVcDVsNGhV?=
 =?iso-2022-jp?B?Zlo0S1E4KzhYSFpmQ2U3QU5BMWQxSW89?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ajNPUjdRMTFXbXJBbEZVRm5xVE0wMUlPZnRCL3dJQ3c5YTZnT1FGemkz?=
 =?iso-2022-jp?B?a3czc0V3U1ltY3ExK2k1KzY1QVdueGlIZTcxN1FyekZibCs1Z3FJMEU0?=
 =?iso-2022-jp?B?TCt4OVF6UVF0QWliOVUvQjFZVXorL213ZHQxMm5UdUc4WHI4QkEvQXdv?=
 =?iso-2022-jp?B?WHA3ckR3UHdqQ0tRRXFYeVI4ais4U09oeFByUDVLS3BDeTZYVVFweWp0?=
 =?iso-2022-jp?B?MnBCRHRxU1Z4QXJrQUgxZkFYYk5GZ3dVVnNLS3dXMUNBRFRUV2szbXJM?=
 =?iso-2022-jp?B?SUJzYys5SkZGUmxBYkFVUkNhRlYxN3laazN0ZVMrb0pUUDQwanBNWkJU?=
 =?iso-2022-jp?B?c0E3L0s5WkYyUFlBSVNRTGI4QVJ6T2JBN0tQd3plMEcxNS9xRE1uTHFL?=
 =?iso-2022-jp?B?a0hCSjBNaXFPaTZxbnNqMVVYajNQbklFdU8rVmQyVnlnYXFvTlk5bC9E?=
 =?iso-2022-jp?B?RHFuTGtFeGRnaHJXaGd6RW9LUjJtUlI2bzBZQnRHV05ETGRha3Jia0xh?=
 =?iso-2022-jp?B?L0dhVlBOVmZZM3Q1MGhIcExsQ2VZQmxpWkkwMW1SWjJiNW5Ra0xrdHln?=
 =?iso-2022-jp?B?QStOQU5qdDBpeWhXRlVZbXo1d0Q0SGZZK0NRVHAzUHFOVUJxYWRSMWhX?=
 =?iso-2022-jp?B?djlvamgrdldQa0c3eFNuWFRSY0lESnVUUkJaR0xTUjBNb2lVK0lHVi9Y?=
 =?iso-2022-jp?B?NkZGUkJ6a3VGamVBQit1WVk1cW9PblNjRGVMaldhbjVGUkd1M2dqUGYv?=
 =?iso-2022-jp?B?SVhrZFR3amt4TG1DN0Y0WjhyOGxZOWhlNmo3R3Q3MGVmdUdocFY0bFBo?=
 =?iso-2022-jp?B?WmRxdG9UbVhYSlpmZU5OWDNveHhLNmxFUUtKdVVlclpVRnorRUhmZVda?=
 =?iso-2022-jp?B?MGZwbFRoYlZZOER1SGNoYS9IVWZucUNzbjlXd3dYcmdSKzllODl5Y1BF?=
 =?iso-2022-jp?B?MWdTRWF2RHdBVDdJWmlUd1hyc1BKQkQxOEcrdkdOTEVKaXM3cU92RUI1?=
 =?iso-2022-jp?B?YzJLdmdnczNuODRrdFFwYzFnOHNnd01EcjVDME85NHpqTTEvaHNGTTdO?=
 =?iso-2022-jp?B?WEVqOU9vVVZoZlRieXFQanN4dWUzdWtwRHN2L0VDcjkrUTArZ3ZSWE03?=
 =?iso-2022-jp?B?RkpkRmFDaU5WRGxXMjlnRFRHaWNJUXp4OGtKcG1OMytwZVBoOVNxM29G?=
 =?iso-2022-jp?B?VWJyVHpNNUFtcUs2Y1pENEtQb1FFbG1zOEFGSGczYnNuYXR4MWdQVzFr?=
 =?iso-2022-jp?B?TWp0bnRaaFBZeW8wWTMycU0rNVlrZkhqcnRPN1BzbGNQZ25CQ2NYUzZR?=
 =?iso-2022-jp?B?a2N6Z2o2bVZtV2E2SXpoMTEvc2FhVXNhcU40RDh4MWxXVG5Mb3NOc3Ex?=
 =?iso-2022-jp?B?UTZIQTQ3bno0YUJKNVpyQXBpcDBjM2dzZk12ZDIrY0xVYndnZ3VzR0VU?=
 =?iso-2022-jp?B?OXJ1ZlF3aWNLZzN5U3dUcEttWHp4OSttWm00ZGE5K1d3Q25NUXgzeFF4?=
 =?iso-2022-jp?B?RnJSQkp0NE1YL2RZcVlMajBPNVhLY1l5Uzh6bW1ucmFUTVZGNmtNbVhk?=
 =?iso-2022-jp?B?MFo5ZzJYWWlBeDV3RDgyT091ZzhvZmJLOUtSSU1uSVAvSVByb1JtSEFV?=
 =?iso-2022-jp?B?R09YMWd6dHdoeUp3Tkl2NUxlamdmNkp2L1kvbTdiakhweFpreFAzd0ZU?=
 =?iso-2022-jp?B?RlV5L05HcVNWaGl0cWtZcXd6eDZXUHhTU3lZSDNIY3BwYi9aYlFwd25v?=
 =?iso-2022-jp?B?LzZJbFNFbzVsVmdUMCtBYkRPTmFnb21PdXFwZ0Z6K0FJL1RSY0F4ZXp1?=
 =?iso-2022-jp?B?WGlnc1gzTndNZmVwVzRmbTQwQndJaXJBZi95VFhDNjByR2JNK3A4d2Zn?=
 =?iso-2022-jp?B?OXZaSjhPMWhGdFhTNENCVW8rekFULytrT21XeFc4dXFWblp1TCtXcHVw?=
 =?iso-2022-jp?B?czdTYmxiVURDUDlhZzRyL3RpMDN4YnhXNW5jVG4raExoL0RQOHE0NCs5?=
 =?iso-2022-jp?B?TXMvb01PeTJFTU93ejcyM2hYMXJ0V2xMK1hGUy9UWXF5WkZ4cnErN0Uz?=
 =?iso-2022-jp?B?WTJXeGpxalFuN1JKdUZscEZGMm1VTENFRTFIZ0syM3JzUjI0dTlkMVlB?=
 =?iso-2022-jp?B?VW90eGd3aEh5TTJ4b0UyWmRrZFVtTm5rUSsyZU1CN1BOVlNYTUk3clRD?=
 =?iso-2022-jp?B?ZzgvcTkzdlJncjVyQi9yYmExaDhSayttMzhIWHJWbG8wYitJdSszcnBz?=
 =?iso-2022-jp?B?ektmMEZOTzNUcTJQZlNIRWlqOFprNG1BTXl0eGNrVFFNU2trTTVqUVRr?=
 =?iso-2022-jp?B?ZWpMeg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +pIml/30LGbm8Ia+XmSjF9LmtNlDCukT+MO4RPtfVDIAGcSUdeZd/65eoGWaocmg92EMzzHBCUrTF4GWHdzOCSus41H0F1tsCtrXLEWhMTiyS7mDqQduUa6EXtt2lONGuw7Pmg3hM5I1uzS/ZeeKjUQNKsjmw3uBYYZrPlGEQmyMVSdIOiSyx6WcWnN5432I9I3Glku57RJrlJtLYlAcsdKGoRIHYdDfq3j6vPw/DBGJr8zcJVggRGUQy88odNmsBw4wvBjizCWRHsHvMe+m0C+7//DFIQ9p9UwcQWl0w1qSA0Qb1ONk5b7BVVg3/2woDpPaTW4nyQBp5RWB5UZ2TPgpWaYViM09prtXky71okxHANDorpTnHmKy5rkg9cCfmiuC6DiGb4SvZ4V9+ciuur6jTvpvRSWaE/Q0NK/q484PqzPtKYtqf24oitlQY05WKejOfSur6eleMbwpwOGRwsA+zvvPrthIoBkW6hkUjfODKTXerA4Dn8PU6zBshmBlAj3Pq85gROrA7K5fmywVd3laVteP5yqdam74s58zv8j29x7x1YDjY2nbJQWpvw/STFQe3Owa3fLXOVum614jZSX6pmahmXhKhzZdG4weqUA5tkUbxgUk67wzKMBcU6AN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181b4262-cb34-4d5b-b66e-08dca9e3ce18
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 00:18:25.9916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sth9CdkNBgFGlm3OX2yBEznqfk3r3CC82cqaBJzd6YBnSW1ktcSQn/hA8faOoYNS27dxO6v1PNnNDacBWHCDxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7137
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
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
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Viv=
ian
> Wang
> Sent: Sunday, July 21, 2024 5:08 PM
> To: qemu-devel@nongnu.org
> Cc: Vivian Wang <uwu@dram.page>; Richard Henderson <rth@twiddle.net>;
> Laurent Vivier <laurent@vivier.eu>
> Subject: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
>=20
> Sometimes zero is a valid value for getauxval (e.g. AT_EXECFD). Make
> sure that we can distinguish between a valid zero value and a not found
> entry by setting errno.
>=20
> Ignore getauxval from sys/auxv.h on glibc < 2.19 because it does not set
> errno.
>=20
> Signed-off-by: Vivian Wang <uwu@dram.page>
> ---
>  util/getauxval.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/getauxval.c b/util/getauxval.c
> index b124107d61..f1008bdc59 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -24,7 +24,13 @@
>=20
>  #include "qemu/osdep.h"
>=20
> -#ifdef CONFIG_GETAUXVAL
> +/* If glibc < 2.19, getauxval can't be used because it does not set errn=
o if
> +   entry is not found. */
> +#if defined(CONFIG_GETAUXVAL) && \
> +    (!defined(__GLIBC__) \
> +        || __GLIBC__ > 2 \
> +        || (__GLIBC__ =3D=3D 2 && __GLIBC_MINOR__ >=3D 19))
you can use GLIB_CHECK_VERSION(2, 19, 0) instead

> +
>  /* Don't inline this in qemu/osdep.h, because pulling in <sys/auxv.h> fo=
r
>     the system declaration of getauxval pulls in the system <elf.h>, whic=
h
>     conflicts with qemu's version.  */
> @@ -95,6 +101,7 @@ unsigned long qemu_getauxval(unsigned long type)
>          }
>      }
>=20
> +    errno =3D ENOENT;
>      return 0;
>  }
>=20
> @@ -104,7 +111,9 @@ unsigned long qemu_getauxval(unsigned long type)
>  unsigned long qemu_getauxval(unsigned long type)
>  {
>      unsigned long aux =3D 0;
> -    elf_aux_info(type, &aux, sizeof(aux));
> +    int ret =3D elf_aux_info(type, &aux, sizeof(aux));
> +    if (ret !=3D 0)
> +        errno =3D ret;
>      return aux;
>  }
>=20
> @@ -112,6 +121,7 @@ unsigned long qemu_getauxval(unsigned long type)
>=20
>  unsigned long qemu_getauxval(unsigned long type)
>  {
> +    errno =3D ENOSYS;
>      return 0;
>  }
>=20
> --
> 2.45.1
>=20


