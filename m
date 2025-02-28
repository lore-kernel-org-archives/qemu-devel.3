Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D039AC282C1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 05:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnt6X-000404-Ke; Fri, 28 Feb 2025 00:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnt6S-0003vP-CW; Fri, 28 Feb 2025 00:40:05 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnt6P-0007ci-9T; Fri, 28 Feb 2025 00:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740721201; x=1772257201;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GUe6Rb89HfwE0igToOkxChdXkMAZGmfdtRzvxLmYQY0=;
 b=VdWQrMarwLXjRGlUd0lJfwv5ZUq2PMHrsJte38OjKb90A2FMp4wOtYvb
 PQmHT3bnnaxFqddvjuqxrIXJksot9HGjhBUi9poPE/dmORrst9Uso6gW8
 LV5VEB8RDJaWkrjSLP6B7OBzr5jeHBn8pV1Ke31UOEQAvDgSMwVOUJKSp
 tWvPH9vEtSsWUWmIgguDv8OPEeS76hO/J7BwqryEvYRNBFm9eq5QOj1nQ
 umlhG7ich0rz8nPR057nPsHQFvYrc7qs0zDIBlwTh61HCtAWyuiTnUdX5
 g0I4QLQ9N5yfBC6pUpO2UHUAw55Ao+CufMm3Ra0esvoEGW7AnZFBlkSSf Q==;
X-CSE-ConnectionGUID: R65YMtDzQxiyzLNhbigFTg==
X-CSE-MsgGUID: d3x4msqSQW2ZOnQu1F+QXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52275729"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="52275729"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 21:39:54 -0800
X-CSE-ConnectionGUID: 02YYbVkDRNCAxr3oX3o1Xw==
X-CSE-MsgGUID: ZYzK9Dh5SuWesRCj+jnliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="148057804"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Feb 2025 21:39:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 21:39:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 21:39:51 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 21:39:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ9eNgw6HzaFe2BOfDXIw91dXoF+HFfd1j8gKHa8hscgB9vUIPF3O9zi21uduHlN/q939o4ftp6EdL5NogK95W/i0CPgDFKaMQp3MNO19b2JfVm+Br5ip8aPKbyVEZJjf8Z4frMrloSiqAzT0xrsw74Iz9Ugxzgmf4muJ3nOV8r9F/U0U7tx1V2eEWyUsQUeZoKZ74MdkoG7VqSHu0wRvbSvtpxWPYLU2l5kDllMIyroIh8kZtTQfzkLAW0V0CXNWYB96Axc92TCffHbPvR0OgeOpL8tiypRgmwNSymjbXqToassxtAPA9RKjJK6bS1zqu4rStfwWgqgLGsnYAbkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVfPCETbkXEMP1BrQ0lO9tGRw2ehPGjqdqOM+c9nUMI=;
 b=gDon6yJCVqxXTH2NrNKgZBu39nNVjA6btdSqKIMOcD4kbjuv3hQprxQDAR7TyiGLTo5dnpO/eZIUEEFfJ7Y+7+y+Wj7Nujge/JinBCBlHVZApxYAREhIyHFClK97fa+PUDgZ3q3YVq2CBVVyD8G4Zo+iMAsSLvDxPTrWgFl9USTJ7T+0JUKBBjcZfOXXz/m3s+mGcUfYbCTL48+iyTql5bpNmJFKrKAshcxzuCGDe7rBEJhNM0TDp+yeTgUgDY1xngZre+E9o9006/qclxGhdMvTmDaFWwiy5WjDCSq5BHy1BdZSnbl6ERRIehjGktqp+FPQyq4Mfvy7BChIHDnvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Fri, 28 Feb 2025 05:39:20 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:39:20 +0000
Message-ID: <ecddfde2-3bf0-44d5-93d6-051535010ae2@intel.com>
Date: Fri, 28 Feb 2025 13:39:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, Alexey Kardashevskiy
 <aik@amd.com>, Gao Chao <chao.gao@intel.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
 <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
 <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
 <b0e11469-775e-45e3-bbcb-319557c20a47@intel.com>
 <39155512-8d71-412e-aa5c-591d7317d210@intel.com>
 <812768d7-a02d-4b29-95f3-fb7a125cf54e@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <812768d7-a02d-4b29-95f3-fb7a125cf54e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 670e1142-d20d-42f2-bc74-08dd57ba3f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3NnL3BhVUdEZzJFY3doa1lINEFIaUFDYlRZS25UdzZvYWhxRkJKcUhlS3Zw?=
 =?utf-8?B?dVloVVBFVjVKQ1Q0blBGYkNjTHk1ekhhM0cvbW5QNEJJM1FjZnZjZjc2WTBw?=
 =?utf-8?B?bTZVS3UzV2NCOEdNUFZHV0dJVTJFY0JzalBkcE1OV2FvYUsvY2VnTzZHbzNJ?=
 =?utf-8?B?UnBTVncvVDJIMER0S00vemxDZGtTaENHZHRJK3RsUHJ3c2NVeHBZaWF6WDNu?=
 =?utf-8?B?Q0ZIbHByZTBQUVA4d21FQ0tRU2Nkd2lUMm02bG9oMnpYRmlWblNIYlE2NUZy?=
 =?utf-8?B?RDA5OTVCTEJMaWRvYnpQR0ZPZDFHRFZYZUF3SlhzK2xITHFvenhIR0JFQXJo?=
 =?utf-8?B?WTRQbVR6SFh6NDdHaWQ2aVFnQUR4YmV1cXlhM2xOVFRjSzBsL3pFTzBLL0dp?=
 =?utf-8?B?WldHVHVRT2dwbUhweTFBd2hTVnFoQW5mK01xUFJMTnNMbkpGS1drQ1drTU14?=
 =?utf-8?B?YWJYWVo4cWEyYUZNSDBhSXVjVXlQdm82NE9wc2R3Z3JjSmZEOElhVDJTSlJS?=
 =?utf-8?B?eE5pSElJMlZiUHYybUFGNFBZeUhTbHlxL0xJdHZzQkVSOURWRUQyM3U5L3l6?=
 =?utf-8?B?NGJUWHMrWitVSjJWYXhxQnBxYVNOTzFaelNza2FXMjN0SXF4dmlJaDAxMHor?=
 =?utf-8?B?NnVqM2hvRWI4VUFhcVlqc0p5NUZYc2I5U3hIUXhLeWZOL09nOFFYRFdTekl1?=
 =?utf-8?B?dy9rQ1VqcVh6NStWMElRdnZ1M0Y0anBWWWFoMlE5UEJYMDhzL1I0ZjhzR3Nv?=
 =?utf-8?B?WXdEWm9rclZSVitLVENNMzI0OW5CZU1pdGUxWGVaRVlaOTQ4a2EvY3RQVUhr?=
 =?utf-8?B?bGpiNWhOeHhKNnZubTdRS0hYamVSbmlvaWorMzNsNWt0WG9XZUcvSnIveGUy?=
 =?utf-8?B?U3hZSDB2WXpxcllyZE1GMU9NTExsSzcrY05Za1hwSUltYUNRUW1GZnlRWGI0?=
 =?utf-8?B?aytzN21BRndSazNZalk4YjN6Q2tUNUFudFZnSGF2czV3QVl1dlMzUFpPNEw1?=
 =?utf-8?B?ZkNKTFZIU014ZHZLUWd6TjlEckZQOVBXUGl4UjhCNzZBeStlZXlEZ2gxRXho?=
 =?utf-8?B?YWh0bW5ESGxCOUpQRWM4MlZIS2R6c0dxWVc2Tjd1NlJnaWVaNnRqekgyZU54?=
 =?utf-8?B?UEhINm56ckRiNVhma01pcW9Pekt3dE9CNHBiODVrTEpjSmJQeklzMXhZWk1P?=
 =?utf-8?B?L0lpMXZBeUJJUXFmU3A0Wk9FRlJvVVA3MnF6S2M0T0IvOXByM0ZOWG0wOEl3?=
 =?utf-8?B?TjdaWUJSWC8yVEEzTWFuYjd6SmdjV0I5WGtSMW9jekRjQUFjZ0Y2VmEzWHMv?=
 =?utf-8?B?OGxpL2NwNkpNbWk4cWJxTFhab0VuaE1WT2ZEK0I4TVNON0VPaG54MGNtQ0FB?=
 =?utf-8?B?NDVvUHI5ZTV4cW5RcC85UDN5ZjdaVW82MTJrU2VsaWFHVGwyT2hZa0YyVTZz?=
 =?utf-8?B?SVMxRFNBRUhVdGdsVWZuUVdVOUJuTkhiME5MQXVOY21wb2ZqSkxIRlNHSHZq?=
 =?utf-8?B?MkVUR0UzK0IyYjlRaWYvaG51bGxaaUZHOGV6dysxZCtRenhkVVpzZ05UOW00?=
 =?utf-8?B?TXJDYXo2NlN6bmk1T3J5aDRwQzNrdWpIZUpQYkRyTk5zQm41ZGNBbWh3SmY2?=
 =?utf-8?B?TE5tYzlxeFlNeW5HektzTzhjZnFkZ01XT2djNUMyNlhBT0I4UGJqbmUwaXcx?=
 =?utf-8?B?eVJDRVlwZE9yWkd4Vzd4Q0hRc0pGeGRUS1YzREhyUVI5YmhMV3RXNkFuZjc5?=
 =?utf-8?B?SGcyZlRsNTF0ZnhRT1lwMm5QNVJJT2JNcDVLd0FJQlVHRTRwS3VTUnVHM1h2?=
 =?utf-8?B?alhrNFp3dm1nZWR0VG5xR3dGanRnNkd1ZXBQWVR3Y3hCek5BVTM2QVRHVk5i?=
 =?utf-8?Q?xAk9Yd9SEGa6I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVNrb29BaEJ1M3MreVU2TEM3Y2FtVS9TVDduWlJLd3hjcXc5ZWRMVHRlbE8y?=
 =?utf-8?B?S0ExeVpKanpQQmhDSEg2b3pmbDJFWm5tNGZ0d3JPTDFYUS93SVhKcVV6ZXRj?=
 =?utf-8?B?cEl5K1EyVGM3WjZSTFIyTWRWc0pONXV1WnNyTVFSUUQwTXlEZnNFRklUZ21Z?=
 =?utf-8?B?ZWkyYXBvK1ZwWEJuK3VGcTFJcDJWSzdoWWdDd2VJKzJKNzkwL0ptbWx6aElR?=
 =?utf-8?B?cjZBcHBVMkRQMUZsTDZneXZGTkMwUWwzUG9WTkFvREMyVHJPck1mS1VTcExv?=
 =?utf-8?B?M3hodkV2Y1RMOFl4S2JTbHh4ajRRRU9INGI5bDc5cnNkVWd0VXRkUnhhelhK?=
 =?utf-8?B?dEJUSGdYcHhnRGRRanozU3hwWU9qbmNPVFZ6Z3J5SkUvaVdHZFN3YUw4NStY?=
 =?utf-8?B?dWNqWEJGZWRZemVHbWczWGRkUGNKUHAvdnEzb1M5a0VDaTYyZVhHb09VVnhZ?=
 =?utf-8?B?WGVTVVl3UnZMdDJyVkovL1NUcWdybENXVzQ1QzVUcW9jaXFJcEpyVHVNUFUx?=
 =?utf-8?B?cVdGRU5FckpSc01yNEJwc25LV1lmNkI1cmZQN1NmZWlYQ2NHQUp1cXBUZFpl?=
 =?utf-8?B?VHdVVWo3NjFHQlJLODZwYnV0WTl6VjlRdTRqUi9YSGRKaGRHZ0sxdzZqcWJJ?=
 =?utf-8?B?OVp2d3pvaGpqSk1zWEFESlFMYVlqTFRQb09QaE5aSjY4ZlpiYk5SNzhpdHJP?=
 =?utf-8?B?aWFDYVBsWGxOYzZsbi9yTGhYTjQ2Vnc5U2oyT3dHb2d5TEM1VEQxbksxMWVm?=
 =?utf-8?B?ZEorMzNYZEZEMjdib0ZkbkRVNTNYVGcvMFZhcCtXSXNodDFGYlZiRVJrcjRj?=
 =?utf-8?B?a2xTUEFzZDlSd2czZVorSmlBOEsrRGNTN3N5a3grVWpXQ3l1Tk1TU1FmejFr?=
 =?utf-8?B?ZzdkSktXdmhYL1N2dEdJTGNwSDI1UmpOUVVNQmY1a1hjVVZHRjdkc3RWa293?=
 =?utf-8?B?UHdldUxTSDhOQTM5QTBLM1pFNkg3eWRvZFBBYUtEcUl0VHRXbWFkcXhOVXdQ?=
 =?utf-8?B?SG90Z01RUk5pL1h3NnJYaU1qRWJISEtLMnk5cWQxUzZzSkpYYlhKZ2F3Z21E?=
 =?utf-8?B?YkgwZEpZU0RBK1BSSHBJR3N2TjlNeXhiYWs5RTFXSllWZXlFZCt3a3VBWG1l?=
 =?utf-8?B?UDNBdTRCSk5rVHFKSWpUNlJGUW5kay82dWVqNU8raGt0UUw4cnNxQWg3TFJT?=
 =?utf-8?B?OUFwWVk0YzdzTTRiMDVnL3grSElDY05oVjRoeGc1VTJ2ZjBtUFlFZjFWMGEy?=
 =?utf-8?B?a3BOSzNDOXdLM2w2bXdqdElPakViVEMrd2piWkRWSUpJZ3V3bHp0a0NMKzRQ?=
 =?utf-8?B?c0tKRVQwOW5jTUtUZklGanNVUHlmTzZ2cUZVbHlIWDZ6RTFWVkwvM2VZZXdE?=
 =?utf-8?B?UWJoT0NmK3QvWWk5ZldjWEdLT0Q1K2lMT0pqNXVwTFg0T0pWd2FmREEra0lp?=
 =?utf-8?B?czYwTmRZN2JmVmFxeCtxR2YxTnVrTW9WN0hVTlRIdDJCUnZpcm1RWisvWmFF?=
 =?utf-8?B?eEpjeEZndGx3TmU0TURMWHk1TlFzTG9XeEdUTzJrUDEvY3ROcm9JbnFaUy9D?=
 =?utf-8?B?Tm1sYXpIY2R5MVJranJsVXZvZHBMTmFGR3UyVVYzMlhLcExodnRUamIxN21L?=
 =?utf-8?B?QTlNOVFwa3Q3S3BOV2V3ZjFBMWE0WEpDTkZrTFNueXRDdmNXU292R0JuOHp5?=
 =?utf-8?B?RlpsYldLTmw4NE4zMVlTUXcySmF0Z2QwQklsamZXN1FFTUJGWENoelBJV081?=
 =?utf-8?B?YkRjZ1ZmVnU5QXVLYXIvcmpLQUFVY04vK3V5Z3o0aHorbkY2d3hCSjZJaE5U?=
 =?utf-8?B?VWtUTVhRZjlQdW9xZE96ZFU0bWhoREZsMFFlMk5FbUR4eGdVVVo1Y0xnQWpK?=
 =?utf-8?B?STF5a0xveHl1cEU5eUdhcjBPWWxzQnJERDZCWk01SXMvaEVjNVFoN0hwOGl3?=
 =?utf-8?B?OWRXMFM5TWFPSU41OHlPWUprSWRMbGtNVnFDNnNWQ0FuVU9lNWlaMWZpa1Jm?=
 =?utf-8?B?SGowQ3k2ZThSejlNRHZWeHZ0Q2Y4eWFhZ3RoUThnQmdISGxJcDRISGtOdHpr?=
 =?utf-8?B?b3loZllDbVp5bzU5MU0xZGhtZ2JMMllTSkZrNWNmbFpCSUw1RW9rdTV4Vklv?=
 =?utf-8?B?RSt4K2dlK3lmSVBKTGg5Rmx0MU1ZUncyRFUxY1A5SkdFMGlHb0pjQVcvUXlt?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 670e1142-d20d-42f2-bc74-08dd57ba3f7d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:39:20.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGbCWhXdwGKS4nhb30kjDy0tGpTpdCi+YqB0cWlUXwbS7fDMNZJao0jCBdMSFfgzwIHaeHhr5A3uH9Mp7C1v0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 2/27/2025 7:27 PM, David Hildenbrand wrote:
> On 27.02.25 04:26, Chenyi Qiang wrote:
>>
>>
>> On 2/26/2025 8:43 PM, Chenyi Qiang wrote:
>>>
>>>
>>> On 2/25/2025 5:41 PM, David Hildenbrand wrote:
>>>> On 25.02.25 03:00, Chenyi Qiang wrote:
>>>>>
>>>>>
>>>>> On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>>>>>>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>>>>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>>>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call
>>>>>>>>>> the
>>>>>>>>>> IOMMU
>>>>>>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>>>>>>> notifier isn't sufficient for CCA because the DMA addresses
>>>>>>>>>> need a
>>>>>>>>>> translation (even without vIOMMU).
>>>>>>>>>>
>>>>>>>>>> At the moment:
>>>>>>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>>>>>>> * the populate notifier() calls IOMMU notifiers
>>>>>>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get
>>>>>>>>>> a VA
>>>>>>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>>>>>>
>>>>>>>>>> guest_memfd_state_change() only changes the section's state after
>>>>>>>>>> calling the populate() notifier. We can't easily invert the
>>>>>>>>>> order of
>>>>>>>>>> operation because it uses the old state bitmap to know which
>>>>>>>>>> pages need
>>>>>>>>>> the populate() notifier.
>>>>>>>>>
>>>>>>>>> I assume we talk about this code: [1]
>>>>>>>>>
>>>>>>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>>>>>>> chenyi.qiang@intel.com
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> +static int memory_attribute_state_change(MemoryAttributeManager
>>>>>>>>> *mgr,
>>>>>>>>> uint64_t offset,
>>>>>>>>> +                                         uint64_t size, bool
>>>>>>>>> shared_to_private)
>>>>>>>>> +{
>>>>>>>>> +    int block_size =
>>>>>>>>> memory_attribute_manager_get_block_size(mgr);
>>>>>>>>> +    int ret = 0;
>>>>>>>>> +
>>>>>>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>>>>>>> +        error_report("%s, invalid range: offset 0x%lx, size
>>>>>>>>> 0x%lx",
>>>>>>>>> +                     __func__, offset, size);
>>>>>>>>> +        return -1;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if ((shared_to_private &&
>>>>>>>>> memory_attribute_is_range_discarded(mgr,
>>>>>>>>> offset, size)) ||
>>>>>>>>> +        (!shared_to_private &&
>>>>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>>>>> offset, size))) {
>>>>>>>>> +        return 0;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (shared_to_private) {
>>>>>>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>>>>>>> +    } else {
>>>>>>>>> +        ret = memory_attribute_notify_populate(mgr, offset,
>>>>>>>>> size);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    if (!ret) {
>>>>>>>>> +        unsigned long first_bit = offset / block_size;
>>>>>>>>> +        unsigned long nbits = size / block_size;
>>>>>>>>> +
>>>>>>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>>>>>>> +
>>>>>>>>> +        if (shared_to_private) {
>>>>>>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>>>>>>> +        } else {
>>>>>>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        return 0;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>>
>>>>>>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap
>>>>>>>>> again.
>>>>>>>>>
>>>>>>>>> Why?
>>>>>>>>>
>>>>>>>>> We just checked that it's all in the expected state, no?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> virtio-mem doesn't handle it that way, so I'm curious why we would
>>>>>>>>> have
>>>>>>>>> to do it here?
>>>>>>>>
>>>>>>>> I was concerned about the case where the guest issues a request
>>>>>>>> that
>>>>>>>> only partial of the range is in the desired state.
>>>>>>>> I think the main problem is the policy for the guest conversion
>>>>>>>> request.
>>>>>>>> My current handling is:
>>>>>>>>
>>>>>>>> 1. When a conversion request is made for a range already in the
>>>>>>>> desired
>>>>>>>>      state, the helper simply returns success.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>> 2. For requests involving a range partially in the desired
>>>>>>>> state, only
>>>>>>>>      the necessary segments are converted, ensuring the entire
>>>>>>>> range
>>>>>>>>      complies with the request efficiently.
>>>>>>>
>>>>>>>
>>>>>>> Ah, now I get:
>>>>>>>
>>>>>>> +    if ((shared_to_private &&
>>>>>>> memory_attribute_is_range_discarded(mgr,
>>>>>>> offset, size)) ||
>>>>>>> +        (!shared_to_private &&
>>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>>> offset, size))) {
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>>
>>>>>>> We're not failing if it might already partially be in the other
>>>>>>> state.
>>>>>>>
>>>>>>>> 3. In scenarios where a conversion request is declined by other
>>>>>>>> systems,
>>>>>>>>      such as a failure from VFIO during notify_populate(), the
>>>>>>>> helper will
>>>>>>>>      roll back the request, maintaining consistency.
>>>>>>>>
>>>>>>>> And the policy of virtio-mem is to refuse the state change if
>>>>>>>> not all
>>>>>>>> blocks are in the opposite state.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>>
>>>>>>>> Actually, this part is still a uncertain to me.
>>>>>>>>
>>>>>>>
>>>>>>> IIUC, the problem does not exist if we only convert a single page
>>>>>>> at a
>>>>>>> time.
>>>>>>>
>>>>>>> Is there a known use case where such partial conversions could
>>>>>>> happen?
>>>>>>
>>>>>> I don't see such case yet. Actually, I'm trying to follow the
>>>>>> behavior
>>>>>> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
>>>>>> doesn't reject the request if the whole range isn't in the opposite
>>>>>> state. It just uses xa_store() to update it. Also, I don't see the
>>>>>> spec
>>>>>> says how to handle such case. To be robust, I just allow this special
>>>>>> case.
>>>>>>
>>>>>>>
>>>>>>>> BTW, per the status/bitmap track, the virtio-mem also changes the
>>>>>>>> bitmap
>>>>>>>> after the plug/unplug notifier. This is the same, correct?
>>>>>>> Right. But because we reject these partial requests, we don't
>>>>>>> have to
>>>>>>> traverse the bitmap and could just adjust the bitmap operations.
>>>>>>
>>>>>> Yes, If we treat it as a guest error/bug, we can adjust it.
>>>>>
>>>>> Hi David, do you think which option is better? If prefer to reject the
>>>>> partial requests, I'll change it in my next version.
>>>>
>>>> Hi,
>>>>
>>>> still scratching my head. Having to work around it as in this patch
>>>> here is
>>>> suboptimal.
>>>>
>>>> Could we simplify the whole thing while still allowing for (unexpected)
>>>> partial
>>>> conversions?
>>>>
>>>> Essentially: If states are mixed, fallback to a "1 block at a time"
>>>> handling.
>>>>
>>>> The only problem is: what to do if we fail halfway through? Well, we
>>>> can
>>>> only have
>>>> such partial completions for "populate", not for discard.
>>>>
>>>> Option a) Just leave it as "partially completed populate" and return
>>>> the
>>>> error. The
>>>> bitmap and the notifiers are consistent.
>>>>
>>>> Option b) Just discard everything: someone tried to convert something
>>>> "partial
>>>> shared" to "shared". So maybe, if anything goes wrong, we can just have
>>>> "all private".
>>>>
>>>> The question is also, what the expectation from the caller is: can the
>>>> caller
>>>> even make progress on failure or do we have to retry until it works?
>>>
>>> Yes, That's the key problem.
>>>
>>> For core mm side conversion, The caller (guest) handles three case:
>>> success, failure and retry. guest can continue on failure but will keep
>>> the memory in its original attribute and trigger some calltrace. While
>>> in QEMU side, it would cause VM stop if kvm_set_memory_attributes()
>>> failed.
>>>
>>> As for the VFIO conversion, at present, we allow it to fail and don't
>>> return error code to guest as long as we undo the conversion. It only
>>> causes the device not work in guest.
>>>
>>> I think if we view the attribute mismatch between core mm and IOMMU as a
>>> fatal error, we can call VM stop or let guest retry until it converts
>>> successfully.
>>>
>>
>> Just think more about the options for the failure case handling
>> theoretically as we haven't hit such state_change() failure:
>>
>> 1. Undo + return invalid error
>> Pros: The guest can make progress
>> Cons: Complicated undo operations: Option a) is not appliable, because
>> it leaves it as partial completed populate, but the guest thinks the
>> operation has failed.
>> Also need to add the undo for set_memory_attribute() after
>> state_change() failed. Maybe also apply the attribute bitmap to
>> set_memory_attribute() operation to handle the mixed request case
>>
>> 2. Undo in VFIO and no undo for set_memory_attribute() + return success
>> (Current approach in my series)
>> Pros: The guest can make progress although device doesn't work.
>> Cons: the attribute bitmap only tracks the status in iommu.
> 
> Right, we should avoid that. Bitmap + notifiers should stay in sync.
> 
>>
>> 3. No undo + return retry
>> Pros: It keeps the attribute bitmap aligned in core mm and iommu.
>> Cons: The guest doesn't know how to handle the retry. It would cause
>> infinite loop.
>>
>> 4. No undo + no return. Just VM stop.
>> Pros: simple
>> Cons: maybe overkill.
>>
>> Maybe option 1 or 4 is better?
> 
> Well, we can proper undo working using a temporary bitmap when
> converting to shared and we run into this "mixed" scenario.
> 
> Something like this on top of your work:

LGTM. I'll choose option 1 and add the change in my next version. Thanks
a lot!


