Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1FA1093163
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3OV0-0000pg-Pf; Thu, 19 Mar 2026 21:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w3OUx-0000pR-Fh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:18:00 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w3OUu-0002ci-Os
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 21:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773969477; x=1805505477;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cl89w8GWw5IxJ3n/9Qr8k5Pbcl95ja6TeW+yAx7BSAc=;
 b=LgIdiudTVOlIkkK7mdCmXiH6M7yCLZgg6lCfxjNn5yr+cev9SXbEGl2h
 zb7PF1Sk3PwkCCCjlGkMDYqwAGnuFpm1CAFbhij2hlEvsQ29IKDvmKYiM
 AlHw1rUu4pB+75fC+AjnSY+SMHDAGKkbmP+5SfAyQYrsjw5cpKkbhoFR+
 c7J02E/Uras93ro6slyTujp/5hmXCsdIC4Ausu5Gp4dHmAF+c8oYIidIw
 0lFDTqHnjIoft7Azqhoj8kS1yfBCd1iPtfN9tgGFwo6xWgseq2EKhkgo+
 O+1/pLDrZMseDq7rZY6GeNMjEuzbpsioRLqHwxtIpNerBw+E9cbJZQWFP w==;
X-CSE-ConnectionGUID: 47jBdCTPSlSmBEcKvfISCw==
X-CSE-MsgGUID: j83FCuMiT1ygp67CUDSFNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75086512"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75086512"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 18:17:54 -0700
X-CSE-ConnectionGUID: 4GNX9nVTTjqP+VGtT0IAEw==
X-CSE-MsgGUID: GpvjvDwzSa2CwvUFDxDF4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="225087567"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 18:17:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 18:17:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 18:17:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 18:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5+/6pij3ZVlOwx2s3xcJ5CZfAzreXM1ynnSDWca9zu/LHHv2UfWMw6nfObFLKgrCpYx6AX+EaK/SPzt9zvM59LpsVCBOD3cNceuMAC5R2ofOqG6FBqEIjiYEqOWH42IZBt2ejQOrNn6pMrKfxILJl3GRqtNMvDrYCy6crWALVYFkiFHQFm16eXLfL6ChcwKta9cu7dw8abRRyePBezGTy45ktzybg/gA0ArQuimf8TtAye6DZL1uH1C4HbUZARWdENPeMlC0cW/aTDtfXOzM19ORQCpQSmke3w3JZCpU0ypR/XqyfONkyJZeEciNQOx229ltzTdYMa3ZLtrQYw7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cl89w8GWw5IxJ3n/9Qr8k5Pbcl95ja6TeW+yAx7BSAc=;
 b=FABiXNpkG+KXGUjBoxFb56zvO++HZGKUFlpt/ukVBGjGLMHZqMyR0jS97vd+vsDyhLxSHjTJ+lu/elzPSIFlLlP2feYDs09MH3K8UhhDOtJQOpf4EY454YSMT+wIrrTihGYkQhEHu/8nQHcKojePwFoMnWhrBcTsnxt/DErwWYfqId5jYfBA78hshsl0Y1HF89NzAOqCZ8HJ+k5M0MVeb1jrTUfx/EgyYugAeUwWfqgDUV1g2PD0ttWw412z+vbv238bzxuZzFxzGPKGqxnTDgOhyQOkJjjNUCAuGEFgwhEM4tBEwPXxp2BRcBIsRPPu9FghzfK2zZtaDIIzA2Ognw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 01:17:47 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 20 Mar 2026
 01:17:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Alex Williamson
 <alex@shazbot.org>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH v3 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
Thread-Topic: [PATCH v3 1/2] backends/iommufd.c: report error when /dev/iommu
 is not available
Thread-Index: AQHct+NrLiMobwf4M0GfZ0PLeiaRYrW2nqWA
Date: Fri, 20 Mar 2026 01:17:47 +0000
Message-ID: <IA3PR11MB913625D0F65CFD195678EAFF924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260319205942.367705-1-pierrick.bouvier@linaro.org>
 <20260319205942.367705-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20260319205942.367705-2-pierrick.bouvier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BN9PR11MB5307:EE_
x-ms-office365-filtering-correlation-id: 481c3532-917d-4414-6119-08de861e7f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ByCh8ylCb+x4uJjreQko2A8M/byEsqpeD8mwH0fywHqsoka8T2pPNuZRa/8g82Ve18kLfesN1Bc+tQJ4FS+PwQPRHf9zIA6jbQUkZmw0sNDdWePHOZqNs2lEueUIqIe39Btl7nB16+PFTU5iYTQiE0eEQyXZElOl9TMiAlHrtNrNPxsZeoZyKcngwYNGfVpTuAgBzmokpf9bNv4SsMFmMYoRuLQ0TDWpLjsb3YtUHDIJtvl2HZfCanff4ROqZahRjiw3RYb7QIqouHe0MtknKqNsWZEv5s90ZaHFwAeyiOM5pv4KMzfEFJWayG+5t2beFxMZ/yCQ1UBnMFrNPS/YhVijV9jUh2wHZIrEZ6Wyjh+7TSVxmZ96vh2LQVC+yzhQa0rRxdZ9jpYN3HJWwnTAPLHL60Vwe1FKQdVZxkhvJjkO5/8cF/M0SSU0MOCt+j0qka9vQM1VqwyR6V7Z+6LDbSeodBz8PjDlE+YGQiFSy3UjX8WWeKLddm5a3RaOs1B9DzZJjfL2xEXtGocHnvAjLxS+EkkMyVR/osUk0OwJ/W2Bk1OodrYPT8OULXoa6iozSZUE3RrwEUwrZyoJr1SwEDSgfzJPwwXUNRv5wMe315ro/ov5Go+0KGf1fSh07HVUFEWysuoHfhEa1nnsKanUaRhjTuhx6D5wnezojUNBljCk0QugMd6hhEcokCn74L4WfngbIrohdwMNpouYS33eOdeqq8ZVgqXVV1QjtyhokuECzSupZyenqkQGNzbDCUH3dTQRK8miZWVzPjY0uops2BgUlXS90UqoZZdmyq81j4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Skc4V2c2MlZHc2RxTmUyS3pWYmdFSWMxSDJDZUxsWmdjTmV4U3piWExMT3pV?=
 =?utf-8?B?UXRuU2dreWl2TXJ2cFJvZFM5Nnc5eWx5akdrUDhxbUZXakJ2d0Z0NWFTUkE0?=
 =?utf-8?B?TU42NmdoOXRiWG1QdGVVWmJMWnZCRkhEanhGWUJ3QjNNSlFtU04zNVphck9n?=
 =?utf-8?B?a1RJUTY0RkZwS1BTaVUrMnBlWnd6R0ZHMEVtcUZaQ2hjQlpVa1NCMWxTY0Ri?=
 =?utf-8?B?cVg4VmZzTnBLL3lvSHY5S2ZodkE2bjB2QTRGN3IvSkZGZ1Nha295c00vQlBs?=
 =?utf-8?B?TXExay9WMjhpZkdjZkQxcDhsV0FtQ1FDMmhPcXVzSXdUUDJDYXhwdkhUM1cz?=
 =?utf-8?B?Q1ZZa2VUNlhvSzdXVlFvWU5JRGJMdUV2Q3dVSTEzc0JrVGU5TldpRFRhb051?=
 =?utf-8?B?aXprTkNucWJ3M081dXpHZVBxRGZybDFZOGNaVTBQN1NQMkRYVm41QWRhazJL?=
 =?utf-8?B?NE8wN1YrZStBajVhUnJJM01PcG1SNk1Nd0RxT21CNDBZeG9oeE45dlh2cmlN?=
 =?utf-8?B?YWtpcmxnMy9NZXh1amgzTmM3Q2ZyMzRVYTBVRU5leGN5MHBYU25jcUFLdUF4?=
 =?utf-8?B?VUFLTjZZNi9kQUl2d0lOTDh5ZG05ZThGWkllWlpEWUNFQ0hNYmV0Q2tlYVR0?=
 =?utf-8?B?aVdCaEhBK0ZpQlErYlVuUFl3aUkrd3E1d1l4d1Q3YzBUMkNRUVdFcVFodjFw?=
 =?utf-8?B?dk9xVlN0OGVGMlBkalhPMFZ0UGxGTHNONUdIMXNVN3Rqc0cyVVMrOUM1dzhK?=
 =?utf-8?B?ZGRHM0wwVStwY3BsRnVDNkdJc3JJWStiTDVYVDFDR1RSNmp5T1pPMzRmbjJ4?=
 =?utf-8?B?dkpsVWJNVFc1bXRydk1EUUE4eEpqZEgwMHp2NFA4a2Y1RytJcGszUDR3MHZp?=
 =?utf-8?B?WXZLREtXU2ZtMW9lZFZoZC9YSlNaM2xNanlwOVREZkY3QnV0TWtYM0F1QzR6?=
 =?utf-8?B?d3VlSWx0OEpOVGtFREFTY2ltR1BtNC81a2MydlFHWUZrcWQzTTBNVDh0QnU1?=
 =?utf-8?B?b0JHSjhJV2h0MkluS00wT3ZUZXhkaUl1TTcxYU92M2IwbENsb2dTTng5U3B0?=
 =?utf-8?B?dVZMYmFaMnladEJIRmZVSEV3czlZVllsMnBNUzFoc1B5WFNmWUU5bkkxRk11?=
 =?utf-8?B?MlNJWjgyNFNWdlBlaGJxcDJjUy9jcnl5YTM1RDhUQklCYWN6SThORkQ5Z0JO?=
 =?utf-8?B?N0FsZlFnZ3ZBY2JVNUp6a2FmYUlOd0orQ3hHR0I4TDdCVWZabittL3JQUS9a?=
 =?utf-8?B?Nmhybm9xVFI2aXpqZDlLYkIweVg3cWcvV1dXMHEyTGQ2VGRuc3preS9kT1da?=
 =?utf-8?B?UzVPRGtTOWQ3ektKbGZaeXRUR1NMMkRVRDh6WldIaGMrYTRsd3dFNkN0ajVm?=
 =?utf-8?B?b0o5S08yb1N1MDdmbGg3Um93UDVQdkhoUy9wZTNsRlpKbkRtd05FLzJhK3FL?=
 =?utf-8?B?bFNjN3hFdEtYbEs1Q0hPem1jeUYrS2x6OGZaVHNoQkU1VFlzVmx6aEZXQUIx?=
 =?utf-8?B?V3ZVakdkWWVxMDJDZytHTkpiekdQU2lUQ0VKOEo2cmFlemZuVG13SEtJWkpT?=
 =?utf-8?B?L2x5MGQ4d1VwTk9ldjJIb05JSUlUK1lZUEZLMVVHOTJhYXlIWHpkVFZ2Z2JB?=
 =?utf-8?B?cVFGU1c5dDB3L0F0dEcvbnZsZnREQWpidzk2Y0VpWUdvdzhER3p1d0VvT0xT?=
 =?utf-8?B?QVNvQ3hzWnIwdTYwcDRnckIyVHFGR0dwWFA2RnNkTEFZck8wOG5wVUEybWpz?=
 =?utf-8?B?dG4yaTJkY1hJekxaM2x5TGR2cExkRUtKT21FNVExdXFCbGFaSVA1RTZoS2Fr?=
 =?utf-8?B?dmNKdGxpcm1QVkVwQ01ubDhGaTlqMEtYUDFBNVlUU3VYTXJBQUV6S2xqRnJB?=
 =?utf-8?B?U0xIT1ZzR1kzckRnWDlwK2tvMTA0Wlo1b2hiTndpcExQNEQ5d1ZoZXc3SkJR?=
 =?utf-8?B?M3NuSUN5eXc1T210WU5ERkZjZVljZGxxSVdWTm11cTY3SFNRQll2MVEvb2dw?=
 =?utf-8?B?SWliYzdPZnlSNWs4SEZNVjlubWlMeVdqWE5lM1dpYmtoYVgrUCtTV3dDMWUx?=
 =?utf-8?B?SXYxbFFISmg1NXFqR09CN2dNMUlKQWZmZTYzbWFJOEJxenV6OVpuNTVhMVht?=
 =?utf-8?B?Zm84MVppOThpaVd2c1EvcmxQaU1SZTZUYmtXVHRjV2dmNTFZNHBxOEJia2NK?=
 =?utf-8?B?N2NLM0pmVmorQ25MdlRBa1ByOHU5ZHRIYlo0V1loMStZckJoTSs1a3Ivd3ZI?=
 =?utf-8?B?WitqQzNmK2EvaDJ4WVFqdXJ4aXIxcFJhZm9ielJaZHI5M0FqbUgydVh2Yytk?=
 =?utf-8?B?M0tvUDQ2U25IY2Z4WnJxNlk1b3dnek9GOTZ1K3lsb1dlUDAxZlZxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cAwkLXHzvrOBMkHZqa8MUHBNFfzEUm4juhNZ8ef2dXpIxjC31RovOOdOTPSR3v162d8aEnuBoE4QijiP2livjqLVfwd4a0aWWa++kFBBANe9W50ZSu5DY0s+B+/SXhSWNpXaM87yYthMoMikNKGGGx5rygxf3PDosU1E+qI+qL9HDWtljpROlQ6+fxsRVE+d7Y1MvqJO1lxkcolysgkeOUykYAHscQf1APIfRTs9l1G1/XI4820TdZKAtsWMNurH0z5yzBIUjY9X38QK7kG6+gM6QD0st5Hx6nfV68g36LaOqvikn3v34B2b6LuUKNSrA0GGBMpYkS94jr4h6sE7tA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481c3532-917d-4414-6119-08de861e7f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 01:17:47.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jk/JLpi/oGjjEzxqIfTvYJh37iaqFCOg0h9GAlridEmqxK+nqoMcQ22WdIGc8G8+CWzOscMzI0BhpjTWJcSq7c94N3mhG+wy+w6pcYF+q2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBbUEFUQ0ggdjMgMS8yXSBi
YWNrZW5kcy9pb21tdWZkLmM6IHJlcG9ydCBlcnJvciB3aGVuIC9kZXYvaW9tbXUgaXMNCj5ub3Qg
YXZhaWxhYmxlDQo+DQo+SW4gY2FzZSBjdXJyZW50IGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IC9k
ZXYvaW9tbXUsIHFlbXUgd2lsbCBwcm9iYWJseQ0KPmZhaWwgZmlyc3QgYmVjYXVzZSAvc3lzL2J1
cy9wY2kvZGV2aWNlcy8qL3ZmaW8tZGV2LyBpcyBub3QgcHJlc2VudCwNCj5zaW5jZSBRRU1VIG9w
ZW5zIGl0IGJlZm9yZSAvZGV2L2lvbW11Lg0KPg0KPkluc3RlYWQsIHJlcG9ydCBhbiBlcnJvciBk
aXJlY3RseSB3aGVuIGNvbXBsZXRpbmcgYW4gaW9tbXVmZCBvYmplY3QsIHRvDQo+aW5mb3JtIHVz
ZXIgdGhhdCBrZXJuZWwgZG9lcyBub3Qgc3VwcG9ydCBpdCwgd2l0aCBhIGhpbnQgYWJvdXQgbWlz
c2luZw0KPkNPTkZJR19JT01NVUZELiBXZSBjYW4ndCBkbyB0aGlzIGZyb20gaW5pdGlhbGl6ZSBh
cyB0aGVyZSBpcyBubyB3YXkgdG8NCj5yZXR1cm4gYW4gZXJyb3IsIGFuZCB3ZSBkb24ndCB3YW50
IHRvIGFib3J0IGF0IHRoaXMgc3RlcC4NCj4NCj5SZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+U2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8
cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KWmhlbnpob25nDQo=

