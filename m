Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D405CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEXKL-00046e-V6; Thu, 30 Oct 2025 14:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vEXKJ-00045c-6T
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:24:48 -0400
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vEXK8-0002CL-R5
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:24:46 -0400
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
 by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59UFhaw11121407; Thu, 30 Oct 2025 18:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=KhN7ecFHPKh6K/FUSMz/th2ZzPBSr6FHCiy90FjYekI=; b=
 LzA9qQj4WLM6BX1FF4lhd9lz7nGfTRGB3eBdEdmhRNbY/8unKOQ82dokb0wNHLHl
 iK4n6thSMWo3vZ+fAmxp8T2pU9We2dFSdpoP2HhBA53Sa1BW7VPZPJ3atSWVRdgg
 MGvBSDKn0Fwis6Ts7+oGnfqGFgcoND8VQZfCQtvsDb84OlpW9sH5BfEiZtHOMY0C
 RrmqujrqAm0D9DeI/l1o5Q/Y8t/rnjBp855NRz1eyEyDtORCsOx8eDKLqfb9gd1U
 FgYrueI0QWsjrqz+xDnMlBhARGG4mar27H2ia4rdYNNfc/1LwrR4469xLErEuSnZ
 bc8u4EJpGfo4gegmK5xZXQ==
Received: from prod-mail-ppoint8
 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be
 forged))
 by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4a333ax3qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 18:24:26 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
 by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 59UFiQ3l024122; Thu, 30 Oct 2025 14:24:26 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4a34nxqvb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 14:24:26 -0400
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 11:24:25 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 13:24:25 -0500
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 13:24:25 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by DS0PR17MB6151.namprd17.prod.outlook.com (2603:10b6:8:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 18:24:23 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 18:24:23 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Mark Kanda <mark.kanda@oracle.com>
CC: Peter Xu <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "hamza.khan@nutanix.com" <hamza.khan@nutanix.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max"
 <mtottenh@akamai.com>
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
Thread-Topic: [RFC V2 0/8] Live update: tap and vhost
Thread-Index: AQHcB8z3dyfk8nOAyE6nLPSm3VGdwbTba4aAgAAEWYD//9JNgA==
Date: Thu, 30 Oct 2025 18:24:23 +0000
Message-ID: <B36A26A8-0BFB-4AED-A2B1-A604ADF9297E@akamai.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <20251030165223.508678-1-bchaney@akamai.com> <aQObbaloT8oW3YsR@x1.local>
In-Reply-To: <aQObbaloT8oW3YsR@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|DS0PR17MB6151:EE_
x-ms-office365-filtering-correlation-id: 8a15c778-d11b-417d-97a7-08de17e18d10
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?a0F6a1RNTEk4Uk5yZ2N3KytCVGZ5Qm1rUFFkaW4yYkc2bG9mZlg5UTV6dHNz?=
 =?utf-8?B?KzhheU8xcXRpeGFObDhvTVVpTlhUcFVvYzN2dEc5SGxudUhuUnFwTmlJVkYv?=
 =?utf-8?B?WjdMV0tTZ0l6bFNETFlwNkVTcU1DRlczV2VFMjl3dmlDc1I5OVRPbmdiVjBF?=
 =?utf-8?B?UUVVZFFWemFuNXVkMTk3Tmxrc1BlMVlBM1lZOTNrak0za1lpdy84U0cwQkJJ?=
 =?utf-8?B?b1RGRFZWR2IyeCtYRk83Sml2c2VLRElLdmJSWGNSd0hUVWVUZGduSE80bjdR?=
 =?utf-8?B?RXU3enQzNVZCZHM3SEU1Q1NNd2lHdCswWVRBd0JvN25ZN3YrQStOV2JnaU53?=
 =?utf-8?B?cS9VQXl1NlNqUFVOMzNjMTRKMzhWM2MxSWw2T1VsejJTcE1SS2h3bVZuaVNK?=
 =?utf-8?B?em8vVTV5MXQrZFl5WHFORkFFTUJJUldObkYzWWhsTE1NYlVZbWhZTHB5OHcv?=
 =?utf-8?B?aGFzekJoY0J1QUtEN3djcklJaGdsaUJjTkVDdXlrSlFHT0hZMXFkdHFtQ1RD?=
 =?utf-8?B?ZUo5Uk5PU2Q3NXZlYUhkYjVzTW9Od0I3SmlESGMyV0RySDJzZlhBOXZFdWdu?=
 =?utf-8?B?N0tCVWxhdVVUUTJTeGtkTUZjUXdXb3ovWlUxN3BKNFJDMEJsOXlncDQ2TDJm?=
 =?utf-8?B?N3duU3NWSGNwTUt6aGM2OTRLUXRyQ0t5bldpY3Blc0Z2Z2RuRnJLMlpCWi9a?=
 =?utf-8?B?YnphVGNDSWtDMDM5bnJJRzg5TStNWS9HVkFHRm9ST0hjQXFEc2NwNDMyY1NV?=
 =?utf-8?B?dGhqU3U2VjJTY3lIeExjOUxSY2YvUWJmaU9kemZpVG5WMzQ0TjNZWDhZZEly?=
 =?utf-8?B?d2I1R2RHZXVsUEltUnBPY2FYdUJvOFVwMENpVE9iTnM5cFpJbDBaY1E4dS9l?=
 =?utf-8?B?TmJrVFIwckhEa2JpcndzTjk5OTVjOHRpVkZuUWRLK05GeGREN1FreUJML0VQ?=
 =?utf-8?B?MkxqRlQzdHhVYTdPbUNIOGcyZjhQSnhiSFFhT0J5Uy9hcFYxMndPUmpEcU5Z?=
 =?utf-8?B?dk9lUFlRY0lXTTluSXc2K09oeGpJemwvNEhJRVByQVdtWjYwUE43dzFhYSs3?=
 =?utf-8?B?Z3NwTDlPTzRvcHovUW5VanoxMlBnRjNpWk15WnNrQmlBbEprNU1KYTV4b05J?=
 =?utf-8?B?ZWQ0d21yU0U0bFRmUVdjb1lCQ0JpdEZTK0h2dlM2Y0dvNjFqVHFGUTZjdzF1?=
 =?utf-8?B?aUQ5d0JjV2hOYnNtUVlDYld4dHl5QW1wYlVpYWxaaFZpY3pWaTBWVHN6aDln?=
 =?utf-8?B?YnVNUkVFQUltTGFHSDZBNFZhYkVPN2t0dlk0Ym5KR0MvQjhXa2tpWE9hTTh5?=
 =?utf-8?B?ODArczJiTGUrSzFpMXBDbzl6b2krb01VOTY1WSthNXI3eU9sVmNGSXRMNnRB?=
 =?utf-8?B?MGIybGZvREh6dFc5cjdhaHBCek14SHloNjdVVjhQanhwdE5GL2FSVzZHS3gw?=
 =?utf-8?B?OHhLU1ZOdE5HRktDTVd4cTBENEJLSDVqQ0JSZEtZcmE0azBodktTMUNZY2wx?=
 =?utf-8?B?YW9EUEFGSzBHREZMTHJVT3BYZTgwTGV6V25CRVdGclR4eWgrUlIvYjA4NFFJ?=
 =?utf-8?B?d2JCMDBEK1hyOUVGWlVWcjRzYkpPYmFwYWI3SFNzMTg5TE5RMTZvbzc0ZnZ3?=
 =?utf-8?B?SVoranE2ZHExQmZTelZ4Qnh1QzVSWktCKytoOW4wT0xiOHpUNmRybXRwSTE3?=
 =?utf-8?B?ajE3TGlVZXJqZ1gzMVNwaFRwRGRqdVBZUmpnci9hR1R5blVFUE5nbjMzV3RW?=
 =?utf-8?B?bWsxZ05sbU9XKy9FRHdvSGNRcHNCWnk5THAyemJXdjIwSVQwR0tWZ0dYaXZs?=
 =?utf-8?B?d2s0dGFUNmtyN3oxZXVJQ2o3c29yREhMMzkyWFhaKzE0Q2tZYkxWZHFmSDh0?=
 =?utf-8?B?S2pGc1lKOU83cmx6eVp1NDlHUnlONklWbjdmc3FJNGpxRy8xVHB4NVM4VVRv?=
 =?utf-8?B?OWJJbVEwYWdFRTl6TDI3R1JZOVlwODJ3SVNyL0JXS3pqZmFiQkV6NDFIdG1o?=
 =?utf-8?B?ZU45ZER6ODRDalBDcUtwcktsM3VCQ0l4Yld5OU1jcndFODBEM0JSZmw0VzlY?=
 =?utf-8?Q?KgnX+b?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytpajY1V05VVGhlQjkzcUpwMTd5ek1NUnRxSVBDcmVkMmFvRjRwZUJWRklZ?=
 =?utf-8?B?VE5ZUXRCZUcxVmVTQ0JtTW0ralBYQmxHWkd1M0J1dVgrbXZkbGJCZTdCRmc5?=
 =?utf-8?B?aXorSXFKMnF2RzdyKzNta0lEalhsa3RJaDhsUWFVWGx5SjRDYjhtUkQ1U1ZL?=
 =?utf-8?B?dStWWWxucE95UHM2QWxDVFZzVEdDazltNVB3c0dxeTVVUW84SkJmM1pJM0Fl?=
 =?utf-8?B?Z0NuMVBQMnpUMStyQlFTYXE5Wk9LSTlPSGNTVkJOZXl6Wjl1TDZJSGN4Z25J?=
 =?utf-8?B?WnQzMGplVCt5aVBtL3ZSV3pZWi8ySHNZcFUxZy8wRk41T3pGeEkxc0piS2ta?=
 =?utf-8?B?WVBMajMxeW9pTlJJSXFSMmpPYXJNcGxYUmd5VjZyNWdHK0ZYdHFYeVpxcGY4?=
 =?utf-8?B?eXFnWXRhUGVybFNHZ0dvbmZRK0VreTVQcVRMZlR0anBXKytkS3c1dTBvTUtV?=
 =?utf-8?B?S2NVd3dDUXZhdHFnbFB2eUZnNnZjOXpFUjdzUi9KbERjR0xEVndUS1ZGR0ow?=
 =?utf-8?B?WXBBZWZmVDlxOHdPSE5iS3J4cmtpSDIzZnlxMnJ0TnNiSGFRQ1U4U0tNUHlC?=
 =?utf-8?B?dlErTzdrQ3VSSlVZbmREMzJ4ZDJTcXZnNk0vYkpLbUg3WDRjZEVvWTR3WGd5?=
 =?utf-8?B?d3ZCQ0NQSmpFcmJzMncvOWEyZCs1Y29zR2s0d0FWY2wwN0lZNk5sZkoxSGds?=
 =?utf-8?B?d1RpY0hlSytkZGRvZ0RqZXBKZlBCN0VLUXRpcDhjTVN0ZFVGbzFmaXlOVGRS?=
 =?utf-8?B?M0c0djBhRDBXZkJWSW9hTm8zald1RDJkS0lPc2JxNElNM1d4TEZzZ0daR2Iw?=
 =?utf-8?B?N2htNEVNbFBueElMWDFCQkxEb0M4MUNKYWppb0w1dmNqWkVtbkpDUTJzNWdP?=
 =?utf-8?B?L1hYNkYydkEwQWF2dmI5dHEzUTFjMG9ReWFUckxJc2VtU0ZmbkE2Z3JESG0r?=
 =?utf-8?B?dkVkZnBRMkZVeFdYeUpSU3dSNXdtZFIyUDVTTlpUWGFuNDd4K3k3WkMxZnlp?=
 =?utf-8?B?RVdDcEw5bmlmdkFXaGxBYzZybXpTeU5jWXk2OVNXSmhlL3plMUlyMnY4aGl2?=
 =?utf-8?B?RkpMSTh4ZmRzY1ZIb01QdWg1UjlQMWNGSmhyUFNTYzZGb1lETlc0ZlZ6YXR1?=
 =?utf-8?B?ekJ1NnJpTEdoakU4eGRTREovOGlJK2lFbm1KaUVRY1NIQUdMZXprWmNGM3ky?=
 =?utf-8?B?a2J2dDQzZ0ttNlRXYmM4TnJGMHFmT21mbklhd0RFRUwvWm1TNy9UTDZwdDh5?=
 =?utf-8?B?eTMzTmpObDdNSzY1QUdsSkFRQUlUOTlpMVVnZ2JWTWp4bks0UUhQbXN3cUpM?=
 =?utf-8?B?Y0ZZY29BVWJWcVFUbHZHbE1KUjRrV1VnNjdlenBMbDdNREVSNlQyRk1IUVFJ?=
 =?utf-8?B?NUZIeTBDWGVHcDNra0NhWmRvNzE3WEJQMkc5cWJXbUl1OEdJYitRVjFta0NN?=
 =?utf-8?B?YzJjek00d2xSN0JoeWRUYXQvcDZhditBYzQ4MXY2N0wvZ2ljc2tOVTQ2NkRE?=
 =?utf-8?B?bWZMVXk3aDBJclp3VDdrZVdFQllNQzY0S1BqMXNGaUNCYnpSYmcvcjBJVUV0?=
 =?utf-8?B?cTdpQWNSbUVQM0FkeDA3S3hubGU3bUt6Tm0yZFptazhsTGJaYUpZK0FGTGlG?=
 =?utf-8?B?c2dyZVgzU0NMdGlDYXB6QVkyaDNxZDVKdVY3SjVFZ1k1eC82WmVnN2dZeEdE?=
 =?utf-8?B?RmFKRDZlRDhCTzZzOVpJVVhhZjlHQWU1YmFxekxLQWt0N2tIVFNROTV2S1hw?=
 =?utf-8?B?MWZNa3VQREtsV2R3SVNXV0tuelRQT05rVVluRzI5bnFxQzJMcGJUMkh5M3Nt?=
 =?utf-8?B?c2tCTzJBdEtQOUlmWDdvYVNzb1FXR2JGVGx4eis4RVE0MDVzaThCOFNtTzQ4?=
 =?utf-8?B?QjJyK2tjeGdDSlJYUHVhTXNhRVMrQVkzVHhYejVNWWFIM0JFU1NmOGluVlJy?=
 =?utf-8?B?eUFmSmRIT0xJVFhEaWxEeHNENC9ja3cwR3daeWJNdXFKa2pCTDhYRWljbzNK?=
 =?utf-8?B?a2xBYk1BdzlGaEM2SFBwQjVsczdPOVVSdnBtTzZXUHI5SGRESm9DNzdsanlt?=
 =?utf-8?B?ZEJRYnV5Vmwvc3dCZ2J0cjZxVW92cThoRU15RHh2K3lZeW1PRFZzSVgzSjlO?=
 =?utf-8?B?d2c2Yll1QmZrbnhmZHVtOUFSUTRsQlFKb0EvU0c0dkxwSGVXMEFDTkYxNWxT?=
 =?utf-8?B?V2lvMktUTXhMb1Vrd3ZmaDRyREEzb3pTcmNFSDMrMG8wakR5MkJsMi9jT1Vl?=
 =?utf-8?B?c1k1YTVzSXNnYW91ZUl4ODdGWjRnPT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUHr/2kWuZroe9lf9ka7Q/XGzODIPI3ZTonEqIpWduiai/F8T92j3KRR7ifQsxWBrbG4jJGZ6LaIUU6piFPR4S5Ufp93RfUuTc2OHJxjgtWE//4c7W/74C8zCB0AIcxeNZ+q0gHBmRwhzCRKJcV8Hw97J0ivS793w4ngZLp7Yb22o8X1DCe/nEjccuNDXYOw6xqKW9SFjj/xIoW6llkDpHY1nlODjzeWivsMuOMAUeY0FUy9ua9VemhJxvFJCjPhsZj9UY064GuhiobVkqxiMPz/Qrq1hRmGU3DK2qLlwnOc0+cYkefcIOQ7SzibkUArXPe06OqACcB/jQSDG4dyng==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjUaE9YmopH72K1+3b7ycdX2NcZkNdxnVK9F9vT3ZYE=;
 b=K0LMm+MUPWgeSJRJWFUNPZi0/J5N2H5ZFYFxjA50+d+VFn3+fmqlXv0qxOcmU0dFOVNIvE7S7YQw9GUuFP7cBwIrjnTwwQQrG1FJu8rlmzR2ASRl8AIKaenK4vcQWqSqgAprsbgZPPtfBIpS73a2dV4Ho0n5fSbJPHT4F9m+Y2ed8Dv1IvTDeg+NoXFKYZfmh7/WV5dvk6ZlSfPNNQ8v53B1ZtZxGBlP+LHpP1mQU1JmU3ThcCykDk+fDLHbfOId83jJZjPLAB0KVpR3oTrWimGU2outEHzlaoC9gQi7eiYuWy8qJPPI4ofhpACovbXXPfMpssPRGYr6tXNFmMDydw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjUaE9YmopH72K1+3b7ycdX2NcZkNdxnVK9F9vT3ZYE=;
 b=iW8PwuhIA3x64Isg9a4YrtXIg+btTOeeOMBL8vMaxWgQ2uv/CZQUtemGT6DkXajhwlDQBcklYD6mbrAQi4+OaklW/7b5jUGD/ImW+AIUbK60+IEj+JfcT/yRDihShiwpIUNGHHCgxMrB2Zwqu8fvRR5UyRVYYSNmB4q9Q4hJTyY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8a15c778-d11b-417d-97a7-08de17e18d10
x-ms-exchange-crosstenant-originalarrivaltime: 30 Oct 2025 18:24:23.4361 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: RTmENttqCrti7mgunVz2OrQtO/Yq7PjRFujWJlzYm3NIzWHqj0BZtP8x9QyQpP1YxQeWU0BU4XEKAISY4inSkg==
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR17MB6151
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE9DD8E3DC1A774AA82C59182BFCAB67@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300152
X-Authority-Analysis: v=2.4 cv=Dcwaa/tW c=1 sm=1 tr=0 ts=6903ad5b cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Q-KdDnlkBDlWWgDAfXkA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MyBTYWx0ZWRfX4zpIOcC2kc+F
 9xh7uqN8Swb5tYzEbxwxcvPs7L4jzy3e0h0bkga2mY06sTCRUbkQ5LB0+oZMTpDg1k7gczscOU/
 x5Uqip+0oO/CIBqyrAhqLO1Cvw5Gpo8uAkIbfA4KC42bNKEPN2r+IKaJ7RVtGS7lXfiNlkdyhiI
 8xGCpDgfy3zZa0QxWmNlZVclMWV+fK7w9zfec98+tXfI1EjWQR1iD5XUo9rFmshmGf2JAxlKf45
 V25uPmJrP5gDq/D2EeVvj1VG3et6ZEIozOt8+q8ggtmdlYWp+R0EJiM9V8t/iwSJA+Lo11cip9/
 vQIESBDW1exBhA9oPnFlYzzE4qso7C+d5oY4n6iHALnGEb9f37oFMxX0J0IwRcmUx9pAriMOAwl
 X4Ch9QNPwgsQWlMhXtH+Laxaj8FoUA==
X-Proofpoint-GUID: VmigHWLKwHrYtTi3KQkm-inwv3MQ2IBE
X-Proofpoint-ORIG-GUID: VmigHWLKwHrYtTi3KQkm-inwv3MQ2IBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300153
Received-SPF: pass client-ip=2620:100:9005:57f::1;
 envelope-from=bchaney@akamai.com; helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

PiA+IEkgdGVzdGVkIHRoaXMgcGF0Y2ggc2V0LiBXaXRoIHRoZSB0d28gZml4ZXMuIGl0IGlzIHdv
cmtpbmcNCj4gYXMgZXhwZWN0ZWQuIEFyZSB0aGVyZSBwbGFucyBmb3IgYSB2MyBvZiB0aGlzIHBh
dGNoIHNldD8NCj4NCj4gU3RldmUgaGFzIHJldGlyZWQuDQo+DQo+IENvcHkgTWFyayBLYW5kYSA8
bWFyay5rYW5kYUBvcmFjbGUuY29tIDxtYWlsdG86bWFyay5rYW5kYUBvcmFjbGUuY29tPj4uDQoN
CkhpIE1hcmssDQoNCiAgICAgICAgTmljZSB0byBtZWV0IHlvdSEgRG8geW91IGhhdmUgYW55IHBs
YW5zIHRvIGNvbnRpbnVlIHdvcmsgb24gdGhpcyBwYXRjaCBzZXQ/DQoNCiAgICAgICAgV2UgaGF2
ZSBoYWQgc3VjY2VzcyB3aXRoIGl0IGFuZCBhcmUgaG9wZWZ1bCB0byBzZWUgaXQgbWVyZ2VkLg0K
DQpUaGFua3MsDQogICAgICAgIEJlbg0KDQo=

