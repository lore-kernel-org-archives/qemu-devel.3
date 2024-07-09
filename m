Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F984C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBkc-0002Mn-4C; Tue, 09 Jul 2024 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBkW-0001v4-Sv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:23:22 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBkQ-000245-Vw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720534995; x=1752070995;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Gv24sQRRMWMHhDD95SunEH8P40dAV8zcXguy8m3Pal0=;
 b=Fy91JGdfLxgff30/GrBmFQzr9kMP96Xapq4tLrpf4MgZgMfygqn48O84
 JLhUz4KfCfnYOnW6HGSdVi6VgedmQeAFQr8O6Exz//ybBpPu3RpG70C3c
 I0WpG5Ki3JIcBmz3YCRCAe2tUHARdXwrMQZUbpI3mBhhswXNMMDrUQoLc
 8t++nKDSm99xeOJFNz83YffUhx3EYaxumoxMqRfHmSk1KxDsYD8+ufddS
 DqD421M0YNkS4nm/l1mi9IyyOMstyuiMUkogQBxPhRaroebCNfMJS1geF
 riA9bW5fVuYZYPdKyeTKBzmWEIkWpCucDihLyHh8aCd1ndBSP3Mh6ns8+ g==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172624"
X-MGA-submission: =?us-ascii?q?MDH/JkjqaJjgqKK5RXnBgbJBAMC7oC8MUIAuTN?=
 =?us-ascii?q?6W6KCW7DMZ3v0KsztQnbpVLf8Vjqg3LhGumjmzVcKWoQormYc+OrX6aa?=
 =?us-ascii?q?IP3aHxon6zQ2+HKUg3j6iP+AmPFzc8NmvvsQcR3piOpoFQSej/vR1Lge?=
 =?us-ascii?q?M+/UC7wls7XF+Lg3tLmL+xjw=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:23:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EowZqSc60yjS6XMFwHRr2GJCPUErqG8GdbkhdeNgye37/I1n/hA0Ta+1krHPfnZo0GATIUw6U09geeeWTFh+G0sc2lD0961WoHdkuR7NKWKa8aBQUKRCEPYeI/f4pxIgvI9EytWehLSTPFqOvGKF7tFaJumQeM42AzXyakn+yIZzlrx8kelsEr6YcMTQUVOzbcEpEX31l++8TyQGgs0H9hYu0j29VrbZ1WPBksyCCnWsPpTmfSXVYTbby+CEIMdgG7dpXmiSXJesQ5UtobacoO3djP2oD9rDRGgRLMqC1M8+NBgf4JgRD43uPkifBtWJYu50ezHu9XIb1Wse2LjPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gv24sQRRMWMHhDD95SunEH8P40dAV8zcXguy8m3Pal0=;
 b=pQqnoXy4cGOMq1usFhU8u5LY6Bu9BLNfFtEr1rLE/IlajKUbRAnRfiG9Zf55ynsEFXKxN7H5z3uo1DSob61LK+YwBY0n2ajjU5gFwMQEEgwynJcY6czphqwArdgd0uuSn3cPL3h37C8XzYJx8qU5yUj9ZFFSs2sDM/Ucd1bR12d21XJWMx2KXTtjsshRWoCRurK6f7eqFwOEdmaHI7ikpSJqptsnzmP9zzJGd8SvyRYKAd5kYC0L74cblTb5fVAYAGpE5SLQbqhGQxaGaT85jg+snPiAxt/LPoM3ziOKJcfcEvZqSCsl2gMhm3z+xVNOmHMdtlx6FH17pr3mMGXoRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gv24sQRRMWMHhDD95SunEH8P40dAV8zcXguy8m3Pal0=;
 b=icHX76FrMrAsULem2vPT5H9798MwtxFPtOjkUxIy91h0BEGrIifkV7VtSgUxF3V6LEJJ4AG3Mnuef1RhUtoHSR7EFtv3rfSDRpu1CaNkGdV7gzF+0va3iuZxSHYJSdRyGYO9OzllVp+kW0NDNAn6YrDttG198P85Ftqv7EEsfrkt9QbUoNIdorDGyhpM5EoX8SE4DbYjjE4krLaYxfHBt6ZO3GTloLSXMeAYqGrpTXvRbj0dyLGjIG4rHq4p/dRVG1bq+5mgx01pwdodW57UiOhxWYwt8JaVEJgTJisK2oQvp5Z6RgOVjBEDKAdeVicDV4U/2Ca5yafipuTLAfF9KA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6460.eurprd07.prod.outlook.com (2603:10a6:10:13b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18; Tue, 9 Jul
 2024 14:23:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:23:07 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Minwoo Im
 <minwoo.im@samsung.com>
Subject: Re: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH v6 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHa0cfEukGxrC/dLUmtiYAPj/jVW7HubVIAgAAGJ4A=
Date: Tue, 9 Jul 2024 14:23:07 +0000
Message-ID: <7e3f62b5-b203-4c7c-b166-215833cd34d7@eviden.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
 <20240709061756.56347-4-clement.mathieu--drif@eviden.com>
 <1d7c0f11-7aef-49fb-88ad-337df3081162@intel.com>
In-Reply-To: <1d7c0f11-7aef-49fb-88ad-337df3081162@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6460:EE_
x-ms-office365-filtering-correlation-id: e205c956-3909-4e3c-efcd-08dca022a782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Yit4UG9BSlpvT3QzWXl5S0R5YVJVQ3JPQzQvaTErR2JRY3A5YUJjMnZ3YWZQ?=
 =?utf-8?B?WGh6WmE5WFBvc1lLb2N0Yk9VTklITmthN3J1V2lhUkhmMndSbG14b01zUzFy?=
 =?utf-8?B?bCtOcHlKL3FMclB5K2l4dlpIb0tpVzlZT3NLRUJBOVoyL3MrdDdDYlFNWW9s?=
 =?utf-8?B?RHh1cGVQYldwYzRLWlVpcWFiRDF6Y3RiTUk5RlJRalFYZnRBRzJUZDlkZCts?=
 =?utf-8?B?QXlKblBzYjVjR1VnVjhycDNUSW02NnZqT1prMC9tRUlOK3hwd3phei9haTN4?=
 =?utf-8?B?cklHV1BFRjZ5S09vcDJsUkltSXhKdTFaYlhQS2VhbXZXbnUvamJxWnFFSysx?=
 =?utf-8?B?b3RVbTUvZDBpTFMxdU1UOEIwU0dUUHFiVjAzSDRNdHpnNU53QXJuMXhHU1JU?=
 =?utf-8?B?MXIzSVcvQ0FQKzFWc0VWTHB4V0YydEYya2NiMmhwK0pxcmtUcE1Mb2owYUtL?=
 =?utf-8?B?cE52Uk10MTJqNVNFSi95VW1FQm5xbk5HeUUyMEZpWjNaQ2VwM1F4SVFmcnJr?=
 =?utf-8?B?N2luK2dqTDVSalo3TGdkK2tGNWd5K2Z2SUx4RDZXNFRWb2VGS2NWK3RRdkxJ?=
 =?utf-8?B?M3RXNVVZSDhmSmNuQ2Y2QjZWamVlQ0RkM2s5SlJPaVoxc1JxcnllLzF6Z3Y1?=
 =?utf-8?B?SG55TDV0OWE0R1ptTTJ4eFZqZEtJV1FFQnVIVzdKdUgrME9TNXRwbWpxU3I1?=
 =?utf-8?B?OWVmdytaalZuWERlQlYvZDNmUzJDbkhSQ3F6RXgwK3g0OEljV01Za3gzU3Vo?=
 =?utf-8?B?SXdSalRCWDYyWGtGc3ZEbUF0TlZpYjIydEJmVHdTeVdoaTJ0MDM0NXJQTzh5?=
 =?utf-8?B?cHE3U1k5YXdUQngyYkxoWEtIbTVvdk91OE9QNFpNc2ZWR2Y1NVVPcUtDYTY0?=
 =?utf-8?B?Vko4L09pZy9RdnYvOU1tQXFCZW4xbUFxTzBtaWcwQjQzVlpBK3lZRlpCRXBF?=
 =?utf-8?B?NU8xeTdsTzB5MU12YjdRUW0yak5yclZFRTBNSFhaTjRlYlNpdmpFdnhrTC9B?=
 =?utf-8?B?b2U2d25YRmhHcURHME1pTWxiMCs1bUFBNlJDUVhIQ2dZdTZLK0ZxMkdIdWo3?=
 =?utf-8?B?dERaMW05RkIzTHNtTGlKMUd2dGRrYmV4NDJJUVZvamk4ci9aWXQ5eVN6bWNZ?=
 =?utf-8?B?Nk5LaVMvYVpkYjlUMG8vb1lJU1VCZjZpQnQvTXdjZmxTeU5YcEdsbFRKZmtw?=
 =?utf-8?B?QkVqQTZTelU3eXdiMStCblFaUE1FL014U2pGNERDTmgxMllUQlYybEZkbGhR?=
 =?utf-8?B?alk0TlE2dGw3ZUxEcFUvWG1CVm4xV081ZnQ3T0RxenkzZzhkVDl0bjFEa00z?=
 =?utf-8?B?RzhWd1FxNEV0bEFZbElzTWk5RmFTNldtZG5RejlPWUVkVkZwNzhST2FUM21l?=
 =?utf-8?B?KzI1dzlIQmVtQ09OVmFLWEZuQzBvQ21HVGlnckVrcEpmMGE3dzd6QU9PYjEx?=
 =?utf-8?B?Zk5xMEc4SU0wWlY2RHJQT21LWWlFOXQrbmNIeGtnVTFYN3BabTFlc2c2aVBi?=
 =?utf-8?B?aUpJQWJjcVlUNjJPaVQ2aGwvaXpENG5maUhJelk5bHl5STJUcW9SRHlHa0Rr?=
 =?utf-8?B?bWFwdENZdDhhY2o4NjNkWXJJV2g2Zk5pQURma1N0TzE2ektYMzh1UXpYaHIw?=
 =?utf-8?B?S2hIUGJIKytHOFFSNkoxRmNLM1NDU2xyRXd2NlhETVFudXlFRWJQZlFSenYw?=
 =?utf-8?B?U1Ywc3R4L3IxYjNmWGpwRDdFaktWemZZNkJ0akNvWVBEOVhzNTBPZ0JHeHJ1?=
 =?utf-8?B?dmZEZnZtNmhiOEViRnNpbHNWQ3pGSjgvTm5FNlhMZzIvZ3JMUkNPMEoxMGVz?=
 =?utf-8?B?WnNuK0RIYzdNZDgwOC8rOEhYSVNEZU8yNGxWUkkyNFFEc2xkZTNLS1ZtTExO?=
 =?utf-8?B?NjM0YStUUzhlazRMeVZsZENlekloRTR2RHJWQUN6bkxqOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTdYR1d1eHZzZmx5T0dqd2U2cUhGcWZyaHhPNWRKdHRIQnJUQlpFNno4RWRN?=
 =?utf-8?B?RFVPMWZBbFJIbE4zYXNSUEVTdGNuNXJKN3R3TzY0SkJxaXpmdjk2UEpnd0Jo?=
 =?utf-8?B?RlBObWluVjFmS1NmTVNhajd6V2VLRGh1K1lqSlNSSktYT3ViZHBNVGJ1ZzRN?=
 =?utf-8?B?NFc0bW84S1lZRjNsRWtMN3lUeXlXSFJmenVBR0xmdGlQbzB5dEE0UmpENGJ0?=
 =?utf-8?B?VXpZWnpLTVFseGwvMkhNYVY0VXNvTWk5ZEZQYkpiRFE5QUI2ODh4M1FrZGxz?=
 =?utf-8?B?V0JuTVgzaVU1OG9Cc2QwbUV3S3dYVjQ4bkpIc0pnOGdHbGJUNzF0MkYzTjRL?=
 =?utf-8?B?YTJ1RWdlMm8zc0RnQnF1dnBLU2RkN0pxbHpMYW5kU0Uyd0EzcC9ndjBqS25o?=
 =?utf-8?B?QWFsa1hQN0RTZzRhbDZ4TkxDMk9kNTZQdndVbXJpaVdTcDh4NFN3QVRqMUlK?=
 =?utf-8?B?VTdpS3FOcmlTRDdRRnZkU0ZZY1VDRTRod2NGWmpiUVFkWlJEamRVQ0hNZ1My?=
 =?utf-8?B?R01SY3g3NVA3YmFCVlZzRkdZeDFJYlJnR0ZOdkxzS0Z5TENZcTRsZHh6UTJw?=
 =?utf-8?B?a0MzSjhLWlcrMHRjeFZWdm90Nk1laGhpczZac1V2Qi8zbmJGNVp2ZGxoVVg4?=
 =?utf-8?B?SmtaMGZOVllEN2RFOFdhWEdrcGtrNHBGNFNlckVlc1E0QlVmNUd6NE52aldo?=
 =?utf-8?B?SnV5b1RiSm9hbUNDZFBWS0hVTlNJdERrZmJBRWlOcUtuc1BPMUZoQ28wMit3?=
 =?utf-8?B?d2pmaWNYOGJvTUxYR2p4S0NlMTIrWFAzYUJUZVNQemNHOUhhSUYyY0dEVnR5?=
 =?utf-8?B?bkk0dzNmSWc0WjZ3Zk9vUzAwK2VaWCs1dmxpSUhZVVNiQ0FRZ0NSaXFhM0ZB?=
 =?utf-8?B?L1BoNUpmZWxXUXo2QVI0cVpFZ0hMdWpsUDdFS1NRU3dvSVNOM3IyekJmQXJT?=
 =?utf-8?B?c0Zxa3VZamhacWFpcEdhNERwM0FGTmF1d04wWGVCK3BuSVljd3hneUc1RUxU?=
 =?utf-8?B?SGEyS25JblpVYmVYaWNXb1B4SlZia3lPRUNWWWpJMUFSV1Y3TE5MODcrU0lh?=
 =?utf-8?B?V3E4NVhTMGUvZk45NjJqVXAzSkJtaDd1VjJQa1RDR2VnMzdyK3ZGTDJrem1m?=
 =?utf-8?B?QWtSYWxHb0F1WmorZWo2a2FpMndxVWZzMzd5am51bmRtMUJremRCOWNCWDVi?=
 =?utf-8?B?SDBTWEZoT1BIZjR1T2g5UnlDbTVUKzlmUExLWVZmWi9oYnVMd0QwZVlGVTc5?=
 =?utf-8?B?ZFRaSnIzTEt5SW5JM0h5cUY3TnZyZjF1RUMyRXEwSXlZM0I5ZSt6djJXWEVn?=
 =?utf-8?B?WmdGZEtzU3NCamZtNzdJVDFOeGwyU21pb1VZVjdiejhHTURrM05EaGFrNzla?=
 =?utf-8?B?Y0Y3dlhWelFRa2NxM2Jtb2FSbkxmRnNMRTVBRjZaL0c0TFBGbWRUeHdWYXV6?=
 =?utf-8?B?d1BzbGF4YVJhNjEybERETDBBMHV2U29MNGMybWtJWTRCL2hLcGVHc0hGc1M1?=
 =?utf-8?B?dkxaUnUyQzErT291cDVoekx4aVNROHpLMWo1U1dxRGFSUVc1bWNPT1NSTWMz?=
 =?utf-8?B?VFNBZ0lrbnprc21jUXZPV1dGTG96Sk02UytEMFBoVkprZlFlYmFoV2xBaGtz?=
 =?utf-8?B?NjI5cHptOERrRzN1cVlVdDFJekhWN01EZ252c05uNWhIL2pqb24xVzVTcnh6?=
 =?utf-8?B?UDFCQno1eWhHblNBeVFtd1ZtSi9WbWRjU2daQzd1VFhBOFVJUm5iV2NHRTgr?=
 =?utf-8?B?N0d3TTNKTDhyMFFySE10U1ROcmJHb2xESHozV3U4UHdGL2lZQTc1UmJBTnhi?=
 =?utf-8?B?enRIL01KUzVkajJGb3B1NXVScmtUbllxeTZRaFEyMmNWK2gzWG9RODN4czVz?=
 =?utf-8?B?Q203eXhka1lXT0pXQjRGa0pFd0Jha2lEN1RkeEo5VDhFVjBrb0JBdUNYaHl6?=
 =?utf-8?B?WDIzc3BvOVBWcGxDdm1nRUpGSFVkd3ZMekhYNXo0c1QyYTA1NVFlZ0dXOGxt?=
 =?utf-8?B?U2FST1o4dmwxdVpZNGFTN3BHU1BQSkl5V0VjNkd2a01jc0JsYjVDeHhUU2Ji?=
 =?utf-8?B?UEg5WUp2cG1UR2xVd3pZbjh2RzQrTy9SR04xRGtNYVBCeWRPeFljcUZQYVhK?=
 =?utf-8?B?RXpoeXoxVEg0WjNncWFJYUQ0SFFHL1R1UFp3VU1VR2VNUmZtM3VXZHA5WmZO?=
 =?utf-8?Q?AJcqLjrjTZ+GA7FsmfQVWLc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CFC73E4D7AEBE47816D86E087F0B80E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e205c956-3909-4e3c-efcd-08dca022a782
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:23:07.9053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laAHONjVn5tqaIw6687wUD9wvgSgu2NxvecMyodTKEIISg9XYT0KPufnJ39px7mywQnepQsI1VqHkSYGVD6ywQySsHp8NQXTMyfcxHFAX6VcMv1QTkNAIO3dYnmqqyzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6460
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDA5LzA3LzIwMjQgMTY6MDEsIFlpIExpdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJu
YWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCANCj4gdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIwMjQvNy85IDE0OjE4LCBDTEVNRU5U
IE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+PiBGcm9tOiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+DQo+PiBUaGUgbWFzayB3ZSBhcmUg
dHJ5aW5nIHRvIHN0b3JlIGludG8gVlRESU9UTEJQYWdlSW52SW5mby5tYXNrIG1pZ2h0IG5vdA0K
Pj4gZml0IGluIGFuIHVpbnQ4X3QuIFVzZSB1aW50NjRfdCB0byBhdm9pZCBvdmVyZmxvd3MuDQo+
Pg0KPj4gUGVyIHRoZSBiZWxvdyBjb2RlLCBpdCBjYW4gb3ZlcmZsb3cgYXMgYW0gY2FuIGJlIGxh
cmdlciB0aGFuIDggYWNjb3JkaW5nDQo+PiB0byB0aGUgQ0ggNi41LjIuMyBJT1RMQiBJbnZhbGlk
YXRlLiBBbmQgeW91IG1heSB3YW50IGEgZml4IHRhZyBhcyB3ZWxsLg0KPg0KPiBubyBuZWVkIHRv
IHBhc3RlIHRoZSBjb21tZW50IGhlcmUuIEVzcGVjaWFsbHkgdGhlIGxhc3Qgc2VudGVuY2UuIDop
IEp1c3QNCj4gaGlnaGxpZ2h0IHRoYXQgb3ZlcmZsb3cgaXMgcG9zc2libGUuDQo+DQo+Pg0KPj4g
aW5mby5tYXNrID0gfigoMSA8PCBhbSkgLSAxKTsNCj4+DQo+PiBDSCA2LjUuMi4zIElPVExCIElu
dmFsaWRhdGUNCj4+DQo+PiBBZGRyZXNzIE1hc2sgKEFNKTogRm9yIHBhZ2Utc2VsZWN0aXZlLXdp
dGhpbi1kb21haW4gaW52YWxpZGF0aW9ucywNCj4+IHRoZSBBZGRyZXNzIE1hc2sgc3BlY2lmaWVz
IHRoZSBudW1iZXIgb2YgbG93IG9yZGVyIGJpdHMgb2YgdGhlIEFERFINCj4+IGZpZWxkIHRoYXQg
bXVzdCBiZSBtYXNrZWQgZm9yIHRoZSBpbnZhbGlkYXRpb24gb3BlcmF0aW9uLiBUaGlzIGZpZWxk
DQo+PiBlbmFibGVzIHNvZnR3YXJlIHRvIHJlcXVlc3QgaW52YWxpZGF0aW9uIG9mIGNvbnRpZ3Vv
dXMgbWFwcGluZ3MgZm9yDQo+PiBzaXplLWFsaWduZWQgcmVnaW9ucy4gUmVmZXIgdG8gVGFibGUg
MTkgZm9yIGVuY29kaW5ncyBvZiB0aGlzIGZpZWxkLg0KPj4gV2hlbiBpbnZhbGlkYXRpbmcgYSBs
YXJnZS1wYWdlIHRyYW5zbGF0aW9uLCBzb2Z0d2FyZSBtdXN0IHVzZSB0aGUNCj4+IGFwcHJvcHJp
YXRlIEFkZHJlc3MgTWFzayB2YWx1ZSAoMCBmb3IgNEtCeXRlIHBhZ2UsIDkgZm9yIDItTUJ5dGUg
cGFnZSwNCj4+IGFuZCAxOCBmb3IgMS1HQnl0ZSBwYWdlKS4gSGFyZHdhcmUgaW1wbGVtZW50YXRp
b25zIHJlcG9ydCB0aGUgbWF4aW11bQ0KPj4gc3VwcG9ydGVkIGFkZHJlc3MgbWFzayB2YWx1ZSB0
aHJvdWdoIHRoZSBDYXBhYmlsaXR5IHJlZ2lzdGVyLg0KPj4NCj4+IEZpeGVzOiBiNWEyODBjMDA4
NDAgKCJpbnRlbC1pb21tdTogYWRkIElPVExCIHVzaW5nIGhhc2ggdGFibGUiKQ0KPg0KPiBsb29r
cyBsaWtlIHRoaXMgaXMgYSB2ZXJ5IG9sZCBjb21taXQuIFRoZSBWVERfTUFNViBpcyBzZXQgYXMg
OSBhdCB0aGF0DQo+IHRpbWUuIElmIGd1ZXN0IHNldHMgYW09OSBpbiB0aGUgUFNJIGlvdGxiIGlu
dmFsaWRhdGlvbiwgdGhlcmUgaXMgDQo+IG92ZXJmbG93Lg0KPiBKdXN0IGN1cmlvdXMgd2h5IHRo
ZXJlIGlzIG5vIGJ1ZyByZXBvcnRlZCBoZXJlLiBIYXZlIHlvdSBlbmNvdW50ZXJlZCBhbnkNCj4g
aXNzdWUgYmVmb3JlIHRoaXMgY29tbWl0PyBBbnlob3csIGxvb2tzIGdvb2QgdG8gbWUuIFJlbWVt
YmVyIHRvIHJlZmluZQ0KPiB0aGUgY29tbWl0IG1lc3NhZ2UgYSBiaXQuDQpJIGRldGVjdGVkIHdl
aXJkIHZhbHVlcyBpbiBnZGIgd2hlbiBJIHN0YXJ0ZWQgdG8gaW1wbGVtZW50IHBhc2lkLWJhc2Vk
IA0KaW52YWxpZGF0aW9ucyBmb3IgU1ZNDQo+DQo+IFJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURy
aWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IE1p
bndvbyBJbSA8bWlud29vLmltQHNhbXN1bmcuY29tPg0KPj4gLS0tDQo+PiDCoCBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCAyICstDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIA0KPj4gYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+IGluZGV4IGZhZWEyM2U4ZDYuLjVmMzJjMzY5NDMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4gQEAgLTQzNiw3ICs0MzYsNyBAQCBzdHJ1Y3QgVlRESU9UTEJQYWdlSW52SW5m
byB7DQo+PiDCoMKgwqDCoMKgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+IMKgwqDCoMKgwqAgdWlu
dDMyX3QgcGFzaWQ7DQo+PiDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHI7DQo+PiAtwqDCoMKgIHVp
bnQ4X3QgbWFzazsNCj4+ICvCoMKgwqAgdWludDY0X3QgbWFzazsNCj4+IMKgIH07DQo+PiDCoCB0
eXBlZGVmIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIFZURElPVExCUGFnZUludkluZm87DQo+
Pg0KPg0KPiAtLSANCj4gUmVnYXJkcywNCj4gWWkgTGl1DQo=

