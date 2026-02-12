Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0876AEDF05A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 08:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqS8v-0006DD-I9; Thu, 12 Feb 2026 03:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqS8p-0006Ce-Gj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:33:40 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqS8l-0005lW-7c
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770885215; x=1802421215;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sLjGHtIvdKZSqXaxmJnl7P841/2YHNzuqkZdEksFh0A=;
 b=cQN0Y5ND0spLfST1yTRc4KvqcT2iM6q798nheifXLtFUmxGAVy7NAMeK
 mfian48uAw+fKWqhPStuE827eCDaukpll7DvaU33K+rCeFkw+APvz4MTY
 PLiCYZI9VA6rLCCCBD8NWZqBQB3OqyoRFs9ju+FZlyshte4GSSF1yRy6z
 GYWkOD4i4EEgY/XMqffSktK52+UEy8EfbeNSVfSZZc9oEJWVMQWEDJRe9
 QNJFEHq0MrZTTnFHnFHQPe6o9jMMqYjcT0Vxx6Ipc1k+4d0Y2fGrFZZQe
 Mhun3kEtw5S4mPX059rYHHXzfTAZj3Q/ep+COaKanI4YYy5YQtSeRJiLa A==;
X-CSE-ConnectionGUID: EWP/WgG3TBKz88oedPiVbw==
X-CSE-MsgGUID: HlaYRvH6R7WhSUsuX/6U4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72097443"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="72097443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:33:32 -0800
X-CSE-ConnectionGUID: 32vWyEq4S3OKyZEwxim+aw==
X-CSE-MsgGUID: jI/qznOjTBitXDCyc3WlEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211807829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 00:33:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:33:31 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 00:33:31 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 00:33:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEfecmHeP/nnfkYp0ahhjeUVLwIsZFIsXgXQxzFeXSjBNOhVTZ+3khLMIHPwTXMQzwIcFLF44dZPBGtvp+RYBCg+6M21aKJuFShF3LvrJbKWO7cDKpQ0goJ19j/wRy3y/qqmbM+FxWNlTIhKJn/D6lpL5x/ssuHSVnoh10cD/PHBST1XAfseYDuiluyU4xoub9SgfcGfwTl/+warqiL38t4SHuWIVE8uci08hxI116dFT54wKzz7m303gK3yZwOI3aMRn+/EKxqWEW3XbEHDvpH+Xt35iLp59iX+xj2xKFQBF//t3zoZyX6QEXDBqzM3H9EhnjqrJJvNhE3V4ZReLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLjGHtIvdKZSqXaxmJnl7P841/2YHNzuqkZdEksFh0A=;
 b=K2W2I/Iv/K9ZnSpltnVMwU2gOAAeg8ZfVFkj5gZXmfy6ULg47kRLabSQpq0uO5wJxQ6/8Uxb99WBU6RtZMPy/kfb0LWfi/Y0VMnDFTjjAcOlz1rqMhOKl70rcxEnPZYFnMvXi0xeIJScJmTS7h9vkDLxpHsqWl487ZwEYaomt5mEiZhNRZ6PJ6Cz0np5sl7f58hOjlhJ3ShXgEBldb+rteOu1ae0GJqPRDcUB7bbcAND+KSFc3OgnTeo6IxiAs/ydHCz6SNG7NjO9h2gOHwXp94eTJASo7s6/yxjSL+FfpOdwC8YIJ6ugIY9NvAbJPXRvYffmUpRBlsumXuYTXeRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 08:33:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:33:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [RFC PATCH 04/14] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHclk1KHH5kYVg1aEmUtDze8YGGYLV+uf2AgAAL8wA=
Date: Thu, 12 Feb 2026 08:33:23 +0000
Message-ID: <IA3PR11MB9136CD500D64456273F3202B9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-5-zhenzhong.duan@intel.com>
 <669e9b9b6fe10f797d8d9571c7327c8a5617ae3f.camel@eviden.com>
In-Reply-To: <669e9b9b6fe10f797d8d9571c7327c8a5617ae3f.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB6935:EE_
x-ms-office365-filtering-correlation-id: 18a8b4a9-6f8d-4def-e9cf-08de6a1162a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Y2JNZVJLZXBlRjFPb2hWdFc2aU1xazVZSVlJS1FWaCswUUUrWm9JRmJlNm5w?=
 =?utf-8?B?UjhWbkR0YWxLejdUTUlMZngvZUdQNktPWU4ybUJCb0t0ZGN5SHBJckpFVXZR?=
 =?utf-8?B?dCtHWjdMZTl5aDk5RXliUncydURyR2N0M25vU1A1Qy9uSE9WY0JIRktJT0dH?=
 =?utf-8?B?dGd4REtFcFU1MTdTZTI5aVI0ay9OdGlPZkhNU2c5OS9DcG4rTWZBNFJqZXhk?=
 =?utf-8?B?OTdESFhzdktvLysxNzNnMG5YcWkyWm5YNnRUbHVlTXVxRXl2NnRYTzk0RHQz?=
 =?utf-8?B?NWFsSDBGOWkzVjl3WVk5VHYxVkxWREZQYmRDUmxZSGJaWEREOHYwYlQ5UXlF?=
 =?utf-8?B?YWxDbnVMVVBqZElMTVNZSkV3ZEJPY0RtRy9nZ09KeGdOaWMvdHdWNkNWZkV1?=
 =?utf-8?B?M210NDNQbTFhSXAzQ0ZNblpWS1VxVE5TVXFDRGw2VWhlK3NxMjNQY0dNUVRT?=
 =?utf-8?B?c0hoem14aXZsL3dRQytHSmNiZXJtNGgzaGYvOEFUT24vYThpNkdmVW5UZlVF?=
 =?utf-8?B?VER4UDZzSmErZzZhWWtZU2F6UEo2a1haQlBlblo0WEI1aWMyRDJoWGJ6L2RY?=
 =?utf-8?B?YnhnNE5wNkR6bEJ6MVphTUNBV3hJWFVFcFBiV3FaV3NqT05VL2tud0laUjBY?=
 =?utf-8?B?dEN6WFNrOEVNZmFlanJ2aE1tcG0wL2lmZ0hFeGdSTk02Y05uaXRWRVh0TWRw?=
 =?utf-8?B?TXg5Q250THhIU0lCOGV3dm5yc2dmbmJxc1U1aml5RjNWaHZGSXRZSjBsTVJv?=
 =?utf-8?B?ZWRTRHRQdmRBZ3B4R3B0ZEFmVDhxamJsUkp5SytsT0JpcmJxYlhveGVZT3Y0?=
 =?utf-8?B?VEVCNVhZSllXblZMN2JvZTU2QnJPTjBMSXNGaUJIL2hGaTlRMzJtZnhuRHVz?=
 =?utf-8?B?N2tPNGMxdnIzQVBRd2J3UlNoMi80aGY1L05uanlNNzNWUVJNeFE2TTAyaEEv?=
 =?utf-8?B?QUxrRFFMb0pBcmRGLy9rV3JVY3VUY2FxOXFxRWEvVm9zaEdlL2YydHVlbG1o?=
 =?utf-8?B?NTBqNEtLWDdpaWRwS2t1UG0yaXAzNDlsKzY1cXpUcUthWk80bU9IcXZWdC90?=
 =?utf-8?B?aFhLeHVOajEwSkxnWFFMZ3Rpd1RZSDFGRmZhY29ybExxbTJKUEpmaGVsL2s0?=
 =?utf-8?B?b2lhbU5MbElYRElDckx5aUVJenZRMWlPdUc2WGFWRGYrcjd6VEl3bjhMVmQw?=
 =?utf-8?B?WVJuOVB1QlJHQXhBS2ZQc1ZVSVl2cDIxb2ZHTDQrWDdoc0pJcmMvVzIyZTBT?=
 =?utf-8?B?SXJnSmtpL0hhOGkvN28vQlA2cFZsTUdBSWlueGM1ZmlpT1dhSkFHdzI2MU9t?=
 =?utf-8?B?MExjSE5pWnpkK3NlWmRDVWZTQ0lZZmNDeEYrY2ViNlhEZHU2S25NSHBXTnBw?=
 =?utf-8?B?bnZIYjZBTDdYa3pMRnRZc0F3Z0IwYWljT0hhN1Vnb09ZSDJGNGptUGpOaG5L?=
 =?utf-8?B?SVRzRDdEZFJ1Y0xmdk9ndEdtNWQ3UFhDSVBFRHNHeWVlbHdZWVdPbnk1eFZl?=
 =?utf-8?B?WGxQY0RtTVJRRm05WFI3bXl2TG5yQ1ZPR0wzYnBTTGRvSzZ2cWZEbDJ6ZTAw?=
 =?utf-8?B?Mi8yaUhnVGt0bDZnREE3U2pCa0dVdVJGZTVUWWd0azArMVg5MFZhMjcrUmFv?=
 =?utf-8?B?ek56U1k1dFdERXVaN3VmTGlRYVBGUzNEc1QwcUx0bDFEcWJoZ2FjRDA5bzJK?=
 =?utf-8?B?R2M4NkNibHJXaTBiMUtGWWt3c2Y1WThmaHJwZm12aE9RTCs0MGJXOG1XK0wr?=
 =?utf-8?B?R3lFVnFFZE5IVWhRYlhIaGthc3ZtUExPR3hndHlGN3lvajNocUNSaXRDR21W?=
 =?utf-8?B?UVlER1drYXcvc2NEc3Jna2ZWZjZCcWE2YnUzL1cya25hV3hoZ3o2MTJtdERo?=
 =?utf-8?B?TlMvSmJ6ZEFBNzI5elZsWTh1M0V3UHkxd3cwOTNoU1pvYUZ5MGo4UVdJYU5Z?=
 =?utf-8?B?SVhrbyt3SklyV0N1d3lLeklHd1ZDUzVKSFRySEJOYVhBdXptbWpIN2JuNUhl?=
 =?utf-8?B?NFR2U0ZjN2Nzd2Y3bm91c2FvcllVdlRxWWxCZ1BEaDJkOXhlTXZEa09KR1JY?=
 =?utf-8?B?bUpwNFkrUWN3eUN0YVpubXFDSHFudTRTN2VxeG92UHgveEl0c2xtSytPeFF2?=
 =?utf-8?B?NFRsaldDR1cyN0pWYTUzR3IyNFlvV3RoMGtpUGROUXMyVXpReHA1TU85ZFRL?=
 =?utf-8?Q?a4N3D81b5rN9ZnOcZWlpuY8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3pjMFV0a3BWN1hWRHkxTEJPSElOTUVGOHhEek9YMFkxNG9SdEQ1OXArUEZv?=
 =?utf-8?B?NzllYXFBa1lkaERabTBQU2NJUHJUZXdQZ0s5SFkyNzNDOTY3bUxieDJaR0RL?=
 =?utf-8?B?L0M0VStqUEVndjhPbVVJcERYWldFOXlaZHVyYUE3TXd6L2RtQXZGYVVzVi84?=
 =?utf-8?B?SkI5VW9mVGxkcFpzSklzbzljTFcxL0N6SkVuR1ZJWFQxVFZRNWhDZy9tRlpU?=
 =?utf-8?B?VkRRcnBaaEtTS3VzaTFVSjhUQWVmS21nRDJ5VkVRbWpzY3ZqaUdveWtxVEtz?=
 =?utf-8?B?REpJazNxZEhOWEtyZ29qdC9PbTF4S3ZtckFvN1dXYkV6ZWEzSEZDSkFFVUx1?=
 =?utf-8?B?TzJUSXpsc3B3VE15RXowTWdPY2xKVTF5R1djdnBScTVZaUt3eEp1M09LOUZk?=
 =?utf-8?B?cS91VDdQbXJaVS9DSTBnTDAxUFVDL3lURjM5T3VhVWgvMC9yVEFic2hrN3hE?=
 =?utf-8?B?U1IybFN0Z0Q1dUNHVmZnU1lYMlpvSjJwVXJ6YWY3UlZHYnJGdjRjWEVsRko3?=
 =?utf-8?B?c3oxbkRvSTBCK3ZHTDY0OCs5Z1BPVlpQWEFsdFNVeklHeTZNOXZWN21ybWVR?=
 =?utf-8?B?N2ZrTC8xeGJialo0SGxndUpRSlhiVlhudnluQi9Lb1Z5QzNOVmd3MmFPV2No?=
 =?utf-8?B?QWJ4aGI4anNJYUNiMHNxajM4QUlZVU8zbDgzeUIyNFZXQys1VHNZb05jYWli?=
 =?utf-8?B?ZEg4MlJTclhXL0JUc0xUb0xYcUVYTm1GbkJUN0RMd1U1eHdQUFJCOWQybWJq?=
 =?utf-8?B?ZFdBcWplR1VsMFdYbjVUK3p3RkFyVFV5MCtKclJNeXNYV3hsRFcwTmZCdEtr?=
 =?utf-8?B?SHVtLzNmelJ1cEZsbVVmU2xyNGR4UXcxd2lJQ0pDd3QzSk9CS3JWZXVUQ05E?=
 =?utf-8?B?SnRvTHNlSXlhVExYUlZ5cUppOER1b3BkSnVZcXlkTnpTL2RWR3VWNFVJMEox?=
 =?utf-8?B?SVZSZ0ZsNVpEc25EeE5Wb3BOeDZheGg3Nk1EN3FFaFdGZ3I1dFVQazVQYXZw?=
 =?utf-8?B?TkhmK3RYU3duSEo0MWZzWU15SmVkYm5OTGdEZUtZcXU3OWdHNHB5cW1pSlJj?=
 =?utf-8?B?VWxzdnoreHM5S3ArSVc5WFJzS0l4MXErL0Q1b2F1ZlZoSFJ6blJwc0JVdHhP?=
 =?utf-8?B?TllLNWRWbTZzNFV5WktnZlcwU2RvWnZYTk5Yc3FFck1sZU1ock8xWk51M0xv?=
 =?utf-8?B?R0xicDhXcmdMRGc4cDh3bksrdkMvVGI5TzltZ3JKWUNMelpsSzBqSEt2VGIz?=
 =?utf-8?B?MWxrTUV4UEpVRi9OaFVTbGpRWlM5cXduaHJRWW1qWEhaZGxtdnowcHNReXFE?=
 =?utf-8?B?b0Z4bXNpbVUvM0dUWmh0dzJsdUl3b3dxdnN6Nkd1RDVLZXZFU2Z2Y1M3dksw?=
 =?utf-8?B?VmlzTk1GVmRmRjNNZVZXV3ZzWW9NekFROFRKbUp1RlNNM0hhVmw0OEFKVXA2?=
 =?utf-8?B?cmtHcEVWWDB4RnM2UkUzZ1lKd2RwUnIzZkRrcVJIMitpdjhkT1U1MGV6aE15?=
 =?utf-8?B?U29uallRV1RwNXljTGoxOXJsQ1Z2Vlk4KzFkTzREV21ub2FHOFVESEI3TkJm?=
 =?utf-8?B?YVJWYWFXWWJ3emhFRzh5aGt2bXNMRkZvbVJhMmVzTFNLdkJ4R1dPb0doMVVy?=
 =?utf-8?B?YzFWenluMjU2Y2FER1pUTGxYWUJmNGllL3NOQUNweEcxUWpxeDNRc3AyUTJQ?=
 =?utf-8?B?NUxoWGs2cmFEM0R4ZzRNekFDMEwrZUhVRHhVeGZNMkhUYUpzWno5QjNQdVBv?=
 =?utf-8?B?NWVaSzE5N2hNUEhabzg5S05HTW96OVl5ZFRGQ1RWYWgyblhlaFoyam8zZklv?=
 =?utf-8?B?NC9QVDFVSE5tcExYaDBzclZ5VmsvLzc3Wmdqd2dtOE9sbCtUcUJDL1k4WTFU?=
 =?utf-8?B?b0k5M2lPWnBiOXFyUVN2NTZWWlJhWUtxQzdPNmtaWm9CMFNRYkF1cllRWU1W?=
 =?utf-8?B?dXZ2N1BUOHNmSzlrUG91RXBQbkVaUkthQktUa1ZiWmgwcjUycU4vZHlvejAw?=
 =?utf-8?B?N1grTnJQWTJkQlB2bVFtVWhEZjEwdlBpYWxKNlpwUjJnZHZOMmtKcXNiRTc4?=
 =?utf-8?B?Y2JHUlp1NVNKdDVadXRXWWJHdnRLR1RiTklobUlYWDlzQTBPU2RUbXlDRzYx?=
 =?utf-8?B?ay8vSkZKVFdnM2NQcnQ4RUxPdko2aGxqRWZUeWlOMThBem1rWERweTI0czlt?=
 =?utf-8?B?ZUlnU2pZRUtnRHZTZHcxQ21mTXlzVXRoSHNhU1RnMXVBVGZOamdFaWFIOGlG?=
 =?utf-8?B?RlA1dmU1ZGJhVHVvUkNEL0xRRW5HR0tKUkswUlgwTG9RWEFXZ0tKSExmYjZu?=
 =?utf-8?B?b0ZnMlE2TDByVkRzWkdzS2xaZkRDNHg3RTVUZTFKdkVWQmlQd3N4UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8b4a9-6f8d-4def-e9cf-08de6a1162a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 08:33:23.4261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ot3bTACMhDY8f4JdKexN1/tahub/FDg2F0lUfy/1WtgXWpFmI4KYw0z/nTZeK6BDiu6CJiZo6ww4Ig1QLk6kDRNmMIAcnj1JIgn5EUkeND4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsZW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMDQvMTRdIGludGVsX2lvbW11OiBDcmVhdGUgdGhlIG5lc3RlZCBod3B0IHdpdGgN
Cj5JT01NVV9IV1BUX0FMTE9DX1BBU0lEIGZsYWcNCj4NCj4NCj5PbiBXZWQsIDIwMjYtMDItMDQg
YXQgMjI6MTEgLTA1MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBwYXNpZCBpcyBl
bmFibGVkLCBhbnkgaHdwdCBhdHRhY2hlZCB0byBub24tUEFTSUQgb3IgUEFTSUQgc2hvdWxkIGJl
DQo+PiBJT01NVV9IV1BUX0FMTE9DX1BBU0lEIGZsYWdnZWQsIG9yIGVsc2UgYXR0YWNobWVudCBm
YWlscy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25n
LmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IC0t
LQ0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCAxMCArKysrKystLS0tDQo+PiDC
oDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfYWNjZWwuYw0KPj4gaW5kZXggNjdkNTQ4NDlmMi4uZDYxY2ZlYzFlNiAxMDA2NDQNCj4+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtNjksMTEgKzY5LDEzIEBAIFZUREhvc3RJT01NVURldmlj
ZQ0KPip2dGRfZmluZF9oaW9kX2lvbW11ZmQoVlREQWRkcmVzc1NwYWNlICphcykNCj4+IMKgwqDC
oMKgIHJldHVybiBOVUxMOw0KPj4gwqB9DQo+Pg0KPj4gLXN0YXRpYyBib29sIHZ0ZF9jcmVhdGVf
ZnNfaHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0KPj4gK3N0YXRpYyBib29sIHZ0
ZF9jcmVhdGVfZnNfaHdwdChWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KPg0KPkRvZXMg
dGhpcyBjaGFuZ2UgYnJlYWsgbmFtaW5nIGNvbnNpc3RlbmN5Pw0KDQpZZXMsIGJlY2F1c2Ugd2Ug
bmVlZCB0byBjaGVjayB2dGRfaGlvZC0+aW9tbXVfc3RhdGUtPnBhc2lkIGluIHZ0ZF9jcmVhdGVf
ZnNfaHdwdCgpIGJ1dCBub3QgaW4gdnRkX2Rlc3Ryb3lfb2xkX2ZzX2h3cHQoKS4NCg0KV2UgY2Fu
IGNoYW5nZSB2dGRfZGVzdHJveV9vbGRfZnNfaHdwdCgpIHRvIGFsc28gcGFzcyB2dGRfaGlvZCBv
ciBhZGQgYSBuZXcNCnBhcmFtZXRlciAnaW9tbXVfc3RhdGUgKnMnIHRvIHZ0ZF9jcmVhdGVfZnNf
aHdwdCgpLg0KDQo+DQo+T3RoZXIgZnVuY3Rpb25zIHVzZSB1c2UgaWRldiBmb3IgSG9zdElPTU1V
RGV2aWNlSU9NTVVGRCBzdHJ1Y3R1cmVzDQoNCkRvIHlvdSBzZWUgb3RoZXJzIGV4Y2VwdCB2dGRf
ZGVzdHJveV9vbGRfZnNfaHdwdCgpPw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBWVERQQVNJREVudHJ5ICpwZSwgdWludDMyX3QgKmZzX2h3cHRfaWQsDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJv
ciAqKmVycnApDQo+PiDCoHsNCj4+ICvCoMKgwqAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRl
diA9DQo+SE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlvZC0+aGlvZCk7DQo+PiDCoMKg
wqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF92dGRfczEgdnRkID0ge307DQo+PiArwqDCoMKgIHVpbnQz
Ml90IGZsYWdzID0gdnRkX2hpb2QtPmlvbW11X3N0YXRlLT5wYXNpZCA/DQo+SU9NTVVfSFdQVF9B
TExPQ19QQVNJRCA6IDA7DQo+Pg0KPj4gwqDCoMKgwqAgdnRkLmZsYWdzID0gKFZURF9TTV9QQVNJ
RF9FTlRSWV9TUkUocGUpID8gSU9NTVVfVlREX1MxX1NSRSA6IDApIHwNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIChWVERfU01fUEFTSURfRU5UUllfV1BFKHBlKSA/IElPTU1V
X1ZURF9TMV9XUEUgOiAwKSB8DQo+PiBAQCAtODIsOCArODQsOCBAQCBzdGF0aWMgYm9vbA0KPnZ0
ZF9jcmVhdGVfZnNfaHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0KPj4gwqDCoMKg
wqAgdnRkLnBndGJsX2FkZHIgPSAodWludDY0X3QpdnRkX3BlX2dldF9mc3B0X2Jhc2UocGUpOw0K
Pj4NCj4+IMKgwqDCoMKgIHJldHVybiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpZGV2LT5p
b21tdWZkLCBpZGV2LT5kZXZpZCwgaWRldi0NCj4+aHdwdF9pZCwNCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwLCBJT01NVV9IV1BUX0RBVEFfVlREX1MxLCBzaXplb2YodnRkKSwNCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmdnRkLCBmc19od3B0X2lkLCBlcnJwKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmbGFncywgSU9NTVVfSFdQVF9EQVRBX1ZURF9TMSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
aXplb2YodnRkKSwgJnZ0ZCwgZnNfaHdwdF9pZCwgZXJycCk7DQo+PiDCoH0NCj4+DQo+PiDCoHN0
YXRpYyB2b2lkIHZ0ZF9kZXN0cm95X29sZF9mc19od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQg
KmlkZXYsDQo+PiBAQCAtMTE2LDcgKzExOCw3IEBAIHN0YXRpYyBib29sDQo+dnRkX2RldmljZV9h
dHRhY2hfaW9tbXVmZChWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KPj4gwqDCoMKgwqAg
fQ0KPj4NCj4+IMKgwqDCoMKgIGlmICh2dGRfcGVfcGd0dF9pc19mc3QocGUpKSB7DQo+PiAtwqDC
oMKgwqDCoMKgwqAgaWYgKCF2dGRfY3JlYXRlX2ZzX2h3cHQoaWRldiwgcGUsICZod3B0X2lkLCBl
cnJwKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghdnRkX2NyZWF0ZV9mc19od3B0KHZ0ZF9o
aW9kLCBwZSwgJmh3cHRfaWQsIGVycnApKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGZhbHNlOw0KPj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoCB9DQo=

