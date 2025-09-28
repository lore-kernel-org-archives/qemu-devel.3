Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F9FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2mZK-0007Lz-DL; Sun, 28 Sep 2025 04:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mZ0-0007LN-4i
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:15:22 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2mYs-0002dH-50
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759047314; x=1790583314;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jBuX2jW75URDoO5H1W8TCE+kL9ac/z820zeRhW3XN/Y=;
 b=nxluRmQunEtV4sP+VS/PAswx+7N/sWnk8YXJ4TEMno5Jc5mNcFw+/EQj
 T+MhMs38+3D+CxdtO4fgHmaaLU16PQsfCOP3n3djsSFvD+wxTgMjZ7WDy
 R6rlFRFi76UzsXvvX4fgW4C1QTWmFuErQrIuybYT6yWDXi0HVpYpKsCy9
 jVRX886vWhprAvmqivjeUNiu1yIqLH/xut49cg7rjg2s6n186cVrbb5xs
 Jrwe01PV0B8pwev4PJLZ3TKdih9GjBRLLz5mSd2V0jbImkw9uAXKqs6zL
 F4og8c7SNm16rPbcqq+gF4jfh7zSfKxXNYUjpWG+j7YPfxqzUA+S7BLSy w==;
X-CSE-ConnectionGUID: 2+UVU7xGRj6tCvgXmOeZUA==
X-CSE-MsgGUID: ycZMM2GpS1el45dsOvr+bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61232225"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61232225"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:15:08 -0700
X-CSE-ConnectionGUID: +O5ps/7UQMOB+bBqK+V0cw==
X-CSE-MsgGUID: VNLpI0OCTQCCv3ETv5Gmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="183140113"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:15:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:15:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 01:15:08 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V50VPkvWtQ8qszMr/Va7sYUXPFC3Er+ZPm6g2vVj1Ffe3Mph2SHgMhzx0ntkN8c6ul5F4XMVbJ86J1Km1Saw58dtk43+DqNwHlBzcJFoiQYvBR+G/amCEOVqUOHLZzMfWiSbg4D9IcFKea8L9fDCErDwiEMDUIEVlKUs5UeGi2u+NI8KK9NUQjrPQKMxhyPD4GLkxNb+tj/ixfkAuauslC8x8fNiw5Vd1CaFkkLUiGn//hdqKIskTQ8rEk8GD05GkZfEXk3MOaogMcgtPOLjYnIjVs/1wUnQNSLH5UpucLYGLi506hd1e36R3vx2MZR57kwCYiidUe2Ks8drWAY1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBuX2jW75URDoO5H1W8TCE+kL9ac/z820zeRhW3XN/Y=;
 b=xowzC0UBfC6PlyJdko2Gv6x6DdqzR0f/FG6auxMVEDG5hyVDqpDJLrrXmubu5rMWBYjImOdCRIHp1Y8mKWO7QzyKaune93g7GLXKjNj/ZFaYeF6uxYO4fba/EAy1u+ruskDB7E94pf70UGVUmHi3Zk5nSH8Rg7jIEKskl/FuFYu8h9c2+fy6APHJ1WMcxbikyZSyM6/XbEEG34Yu0qGOwfGdMqsY0LZt0HcXTdEGW9fzcSeNf5v+T/M/PTHjjSSZ+x/Ez6UqZkeUjZgJRpQtgh1FIsxgH7BNnUn6mH5vbpul96B6yGAIuwHA6Ro/kVY1ECvWRYeeS35mPokWYw7mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 08:15:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Sun, 28 Sep 2025
 08:15:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>
Subject: RE: [PATCH 0/5] VFIO: cpr-transfer fixes
Thread-Topic: [PATCH 0/5] VFIO: cpr-transfer fixes
Thread-Index: AQHcLoyikoijH6ltWEWj353Z8xQlMrSnNRiAgAENTxA=
Date: Sun, 28 Sep 2025 08:15:05 +0000
Message-ID: <IA3PR11MB9136564E71445F0004D4F7449218A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
 <f6cf4662-20ef-4740-9881-1441e1be16c9@redhat.com>
In-Reply-To: <f6cf4662-20ef-4740-9881-1441e1be16c9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7207:EE_
x-ms-office365-filtering-correlation-id: 2d984d85-5c00-4e8c-5df3-08ddfe67217d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VlpGU3VZQklGK0RSY3ltbDdTSytjUEx4NjRCUHZ1VGhrUExtc292ZzNWMDA1?=
 =?utf-8?B?dDRuMDl2S0lJWi9aaWhhMDdNakJSZHRJSlp0aWdUWGdlWkJiVzNGdXlDZCtl?=
 =?utf-8?B?bGdVNW5VaUNDWm55Q2tibzhCMDRndGZmdUZvSTdQdjNQVlRDWVZTMGlOSUky?=
 =?utf-8?B?Rkl3dVY1UVlwbDByM0g0OGZCK21UbERmMzV0K0ZNOTdsUG9mZ3NQY2UvTktn?=
 =?utf-8?B?eXpubWZVREF6VnlZSHNKcHJhMzUrYTQ3TThhOHZ4WTZHaTFTS1kxQkhHYTQv?=
 =?utf-8?B?Q1VPRW9XVzlwaW1NRjNyYUNxZFg1akpDY0o0Y2k4S2Y2Nnh4R3BQQzZaOWpn?=
 =?utf-8?B?V01JTVJRN0RwUWZMN09SQ25pcy95WU5MMngrWEJVKzdpSWswSmJKN0dsRFZm?=
 =?utf-8?B?NW1ETFNjYzR6cFJvc1VQQVE2T1RXZG5ia1JkY0EvZDRwMlg0clFKdDhJckhN?=
 =?utf-8?B?T0crRzVaUDc0TGtKWW1Nc3Mva3ZkVFJLbHEyUVFQTlNaVHMvNXdSWHcrVnVC?=
 =?utf-8?B?aDMrR3hxL0FQNjdEY3JPc0wzU1BMbkpqU3Zkdit1TUdQSUpmOU9OT2tpRDZ3?=
 =?utf-8?B?QUVGd0FUMzBkU3p3dUhiUEJicWI4UU9WcWRWVjdTYmJSVVJXSnJucWxoSjVW?=
 =?utf-8?B?NWI2SmVvMS9iQTg5OVNHK1R4ejJsRUI0a0diS0kzNEcvVk5QTXpYR0FCcVNZ?=
 =?utf-8?B?aElJZ1RFNFBndFpFNVZra2lrMWNWME43RE9ENndVcHhrTmZUVXVyMGN5VGF3?=
 =?utf-8?B?bzBVbUdWQXl0WDdraHRjL2RDbjNWemZiTHpnQ204U0tXbU9ZUWRQUXFNNHYz?=
 =?utf-8?B?UUI3MGxOUXJ6N1JHd1R0bjNBUk82dkVPbHZrMGRaUU93M0dzK1dFdU9JNndU?=
 =?utf-8?B?cEY0OXdxTytEZTZUQkUrczllc0V6UDlUbGk2S2NLRlBUb1RsNzU2VVhQMDBy?=
 =?utf-8?B?eU5zNU5uS01KVUR3TC9aKzUxR0FzZSs5WWJjSURyczE1MVB4NGxxUjJ0c2Zq?=
 =?utf-8?B?RTE5Mzd0NHhZR0NkSUIzdmFXOG4zNTZUcjV5cysra1IxSXllazhpdnV2WDBW?=
 =?utf-8?B?RVVIV002L2FpYnA2dzZuSjFhMEtEZk01RWRRUTRRSUFHcmFCQkZXcGpBN1V3?=
 =?utf-8?B?NXc1QnhJajRkelpzdGdrQ0Z6NE1lWWhRdCtVMHBFNEpjRTduMTRVMGZIcEFB?=
 =?utf-8?B?Y0oxUTYxdnRHVmUzb3lDUkc0QzlXT1oxMWx1d1FTcy9aeWdHa3lGVDc4SEJC?=
 =?utf-8?B?TGhHNnBqdHlGSDRyVEFyNkNPelgzbTJkMElQb25iOWNoKytZbVpSVE1TZzNv?=
 =?utf-8?B?aURrRTYxNHk4cU45NFV5VlR4TzRTN21jVnF4MjlZSFo1ckloY0xlUmJJeURO?=
 =?utf-8?B?Ny9IV3AxcEJkak8zQnBxSUpnbk1lVnhQOTl1MDFUREtTMFhQT2ZWRCtnZFNY?=
 =?utf-8?B?bnpaOEVQUmNDN3p0TWJIbFNPdnl4WWhReEFmbWpGRE5vSkIrOGREWUVSVkh1?=
 =?utf-8?B?NTE5THd4amkzTTZhZ25SbThvTk1haXdJWGFydnFGV1pWdzFYcThreFNKV0Rh?=
 =?utf-8?B?M2g1YVNLOVMzS1hWcGVpbjVoM2xzRE95WExjUU9SNy9SUWVCQ2lhaDVtdStm?=
 =?utf-8?B?VmFvOElkaEJhcXpSb1puaUpYN25HdDREUEJtR2trSmwxQTBUMmRadlVNcDNZ?=
 =?utf-8?B?U3Z6NXIvU3dSTjZBY0tQNVIwdllqYXZQbCtNRGp0VklpRzJzbmkrSjBzVDNw?=
 =?utf-8?B?b003RkErQWdGeGo1NmJNY3Z6dkFCQ0d2ZnRKRElnY0JOMXRKaTB0b0RkUVF4?=
 =?utf-8?B?eHZDV2ZPRmtGYkkwRmh1eFkvL1FpK21POVdIYXpvVmNJUHBxT05qN0RRZDU2?=
 =?utf-8?B?akM1Z0M0REViVThHS3N2WGhkcWVOTWk0QTNjVnowZ0tmUGx0aXhCLzU3M0NV?=
 =?utf-8?B?b1lyeVFaZkZxeklybXEwdyt0dWU4cXhHZEZOSWd0NXhpMUpQQkVTQ1YzK0JO?=
 =?utf-8?B?bXBkcXdFdSsyeklEVmJRR2ZEVHJBYllKRWNQam0wK1RDUG43c1M5NnNFNStX?=
 =?utf-8?Q?7aFie7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmJGTXFLMjhrZmpUcWlSL3lGWHVxNW1xOTkvdjJZVHdORWNpVStaSGdlUnkw?=
 =?utf-8?B?VVV6SnlERW5pb0NtQWpWcHRBUUNmaUwvUDk5M0QzeDlDenhSVWVNcEtHblNw?=
 =?utf-8?B?QjliK0NMdzMydXljNThlUWRqY2VEd3hXYmluaUhBdW4zSnRIeFd4L25mR0Vo?=
 =?utf-8?B?cWxvOVNBS0cvazVVZiswUHJOWFBKc2RNa3JPZTA1MnNGMitWSTVoTUl4NDdY?=
 =?utf-8?B?eVAyY01RRWtKYk41RzRTOXNWeG94NDhUaTBQVmRlVzRpdlUyUUVhNm8zbEZw?=
 =?utf-8?B?YUJLbVpBcjFSc1NPSFpnZ1RRL2Z2a2ZKcWFpS3RPNXorK202STd4VUY0SS9M?=
 =?utf-8?B?aGVkSHY1S3F0djdmODdlelhTZVkrNDZrTTJzVGtIRVZMUW5rQ2wwSlFGazM1?=
 =?utf-8?B?a1lLb2NMQjBNdFFYdUZnam1sTGtXblM4NDdpcHVIV0lWTCtZS0lMMjU2QVhD?=
 =?utf-8?B?MVhtQTFHRnc4Q3dTYmNHbnhtSEx5M3hsYW44Ynh6dXpiN0pZRzFSSDdQS2hE?=
 =?utf-8?B?TUZEUEpXU3J5ZzcyNGpUV3BuMDRFMjdiM2dxbHgwZ1lkQW5RR0YvVTFEVXhM?=
 =?utf-8?B?b1FQbkM3UXM5SER2enROQUhkZmJOOFFOZDQybElGZGR2ZnIxSkQ2OFlObGtH?=
 =?utf-8?B?Ly8weGNIYkVjc09QVW0rYmk5d29zbytaaVlWUzg4c3VQVTlXNVJkWmRHYUtK?=
 =?utf-8?B?RTh3aVhmRWJ4SzQyc0pMUnpHaXhpd3JuSE9QS3BBM1dTWEVVc0d2K0VMclJY?=
 =?utf-8?B?ZTNHeWt5SFBxQXBocVRSaE1UakJnM2lJZ0ZaNUQxaitBVVVpTE43bk1tVWZG?=
 =?utf-8?B?b1d6NlU2Ri9IZkNGby9KeTArMTBZallGMC9qVVY1YjJ4R0tzS2hiTVNOclJT?=
 =?utf-8?B?UGZ5cXNpVy9nM21sc3FGUXAvd1pRaVJmOFV0T0VsZjB4Qm5kTUoxQjMvMzgy?=
 =?utf-8?B?T2gyc2JPTUgwejlKMnMweEErVDRwbnJHNFpKOTQ3ZUhtc3NjMk03VUJXaGVN?=
 =?utf-8?B?TlByOUpBWmt3WXhSc21WSkhIUXFUNEhMalhqMDRVSDltbHNvSnByclVBbUhI?=
 =?utf-8?B?NWJzLzZSQm5DbVVGTjlVZFB3YnRzdnJ3WGhCSUhEc0pBOW5oZXI1RnFhYXdM?=
 =?utf-8?B?eWtXakhlb3VJMzdxb2lScjFKZEZUUFZNOE5YbkMvRjFWblVGVTlScFBvUDNo?=
 =?utf-8?B?dzlyS3lMY3lxL29LLzhHbmZ6cHNrTkJ6Mi83N3hLSDBkbFFrRnBoKzZlZTBm?=
 =?utf-8?B?LzRYcjl0Q0Q2MWJUREV0U2w0L0NvdTQ0ZXVzODZEV2hjTlBNeUtlbzUzTjhD?=
 =?utf-8?B?Qmp6d1RrOG03WlVXbC9QTmhMS2EwUjg4Wmk5Y1ZMeElnWVlmRkVIa00yVzYy?=
 =?utf-8?B?VkU4b1J2OEFBcmdCaGRwcGJtNEVpZlhGazNQS0FVR3pwMndEeHV0R3UreXJB?=
 =?utf-8?B?di9LVWRPd0o5OG95eXNZRFE3d2xMRnNQM0xleFBRRGdvY0J1VUdDZ2RGZVBG?=
 =?utf-8?B?SEJjY0pubGtEMjZ4M3RvUUxPUXllQTlXWkFXVloyUjY3WEFnRnM2WWZ6dTFp?=
 =?utf-8?B?OUsyNHR2K09EODY2ZlZJOFNFS0hOSERCTkxYQStLOWR6OXpVUFlmR0pEejJo?=
 =?utf-8?B?TmhzdElCcTVOUndlSGxXcDROc296NnJxcHJnQzFkWHUxTE94M045MmYwRjVh?=
 =?utf-8?B?TjZMTk4ycEJjSU5ZZ3BHRjdYZ3JwM21RNmlsMGEya2R1MzVac0ZlNWRtejNI?=
 =?utf-8?B?TkZvS0Y0dXlSM2U5SWFKSDdLS1h2dlFDK29udVMweS9NWkMxTXVBb2kvYXp4?=
 =?utf-8?B?eW4zUlNjZTZSZUN3RHptS09YNXR1U1lvUFlyT2pCNiswZWY5eGcvNm1RVW5O?=
 =?utf-8?B?akVwOUl0TU1jWm9Icm9Uc2Q3RUMzZlZrY1RWaTdwc2NaM05uN3psTjlGcUtJ?=
 =?utf-8?B?eFhteExFNDVRU3lmVi9tcjN4V0FFMWxYajNCVW9TTWJNRU9HTTVDa2RJR1pu?=
 =?utf-8?B?SGYwbzRwK0pSK2kxaERWNlQ2ZmtRbTB3aHgyUUJFSVVveWlpZ2xmUEdWTXlE?=
 =?utf-8?B?SWwrZUJMQjN0elU3dEtXL2IybXhYL3AwMWo1K3B6VlRMcFllN3F6Z1l2M3Vt?=
 =?utf-8?Q?ZALn6KY4+yqQoAWvMxwiXearB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d984d85-5c00-4e8c-5df3-08ddfe67217d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 08:15:05.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfWdaFtob4wS0H0S0By3aDUiaGMsUTIm1souU0A39bbJqvhpzkGLF0b8apfL3llU7OEGBYaz44ryArsbF/YYr8V8ZcReOQGoHeYIT86G77c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDAvNV0gVkZJTzogY3ByLXRy
YW5zZmVyIGZpeGVzDQo+DQo+SGVsbG8gWmhlbnpob25nDQo+DQo+T24gOS8yNi8yNSAwNDoyMywg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBQYXRjaDE6IGZpeGVkIGFuIGVy
cm9yIHJlc3RvcmUgcGF0aCB3aGVuIHZpcnRpby1tZW0gaXMgY29uZmlndXJlZC4NCj4+IFBhdGNo
MjogZml4ZWQgYXNzZXJ0IGZhaWx1cmUgb24gZXJyb3IgcmVzdG9yZSBwYXRoLCB0aGlzIGlzc3Vl
IGhhcHBlbnMNCj4+IG5vIG1hdHRlciBpZiB2aXJ0aW8tbWVtIGlzIGNvbmZpZ3VyZWQuDQo+PiBT
b21lIHRyaWNrIGlzIHBsYXllZCB0byB0cmlnZ2VyIHRoZSBlcnJvciBwYXRoLA0KPj4gc2VlDQo+
aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC80OTRkMTllN2Y3MjQyZGJj
NDdkN2YyMzY5MzcNCj5jZGUwYzM5NmE0YTdjDQo+Pg0KPj4gUGF0Y2gzLTQ6IGlzc3VlIG9ubHkg
aGFwcGVucyB3aXRoIHR3byBvciBtb3JlIFZGSU8gZGV2aWNlcywgbm8gaXNzdWUNCj4+IGlmIG9u
bHkgb25lIFZGSU8gZGV2aWNlLg0KPj4NCj4+IFBhdGNoNTogU0lHU0VHViBpZiBJIHNlbmQgInF1
ZXJ5LWJhbGxvb24iIHRvIHNvdXJjZSBxbXAgbW9uaXRvciwNCj4+IEknbSBub3QgcXVpdGUgc3Vy
ZSBpZiBpdCdzIGRlc2VydmVkIHRvIGJlIGZpeGVkLCBhcyBndWVzdCBoYXMgYmVlbg0KPj4gbWln
cmF0ZWQgdG8gZGVzdGluYXRpb24sIGl0J3Mgbm90IGEgYmlnIGlzc3VlIGZvciBzb3VyY2UgcWVt
dSB0bw0KPj4gU0lHU0VHVj8NCj4NCj5BIGxhcmdlIHNlcmllcyByZW5hbWluZyBmaWxlcywgc3Ry
dWN0cywgZXRjLiBmcm9tIE1hcmsgaGFzIGp1c3QgYmVlbg0KPm1lcmdlZC4gQ291bGQgeW91IHBs
ZWFzZSByZWJhc2UgYW5kIHJlc2VuZCA/IFNvcnJ5IGFib3V0IHRoYXQsIEkgd2FudGVkDQo+dG8g
Z2V0IE1hcmsncyBjaGFuZ2VzIGluIGFzYXAuDQoNClN1cmUsIHdpbGwgZG8uDQoNCj4NCj5BbHNv
IHBhdGNoIDUvNSBzZWVtcyBkaXNjb25uZWN0ZWQgZnJvbSB0aGUgZW1haWwgdGhyZWFkLg0KDQpP
aCwgbWF5YmUgYW4gb2NjYXNpb25hbCBmYWlsdXJlIHdpdGggbXkgbWFpbGJveC4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg==

