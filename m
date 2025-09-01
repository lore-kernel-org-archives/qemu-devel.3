Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9F7CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszxz-0004Fv-4S; Mon, 01 Sep 2025 04:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uszxs-00043D-4Y
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:32:38 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uszxl-0003iG-Sm
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756715549; x=1788251549;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UjXVFSpyIRpNsybfGIe84q3/YQu5vvqfIh5L56E6Jtg=;
 b=c6jGXQ8AYWr7+H463X9V/D2xp+Et7DTJCWODRvEyjJ9SjkIWJ+crRubf
 tnnVvtLEhBtIeCVAleScRXofEazYRefiNAzFhze2jdJPlPyk5m4V3iHzL
 IoiBgIOE56ZOsSwUwtH4cSWyoXHa9QAV86hQRJVareiqVx+zqHZYiOoaK
 VtesrPiAKTxcRrTI5e71EyV5N+h/oOdWkO68wA9qSsmsp4PhsjXdKGBOb
 82La4NP4tOaJKIBrQelQFjL/y+fk74zIVfTCFqb/JbZI7gvYqZfpOaGYM
 Dz+QfPzt+bP9X3FX08uU1agvdMotce1sRnNSmWUMKY4NoVP8T2FLAEtd0 Q==;
X-CSE-ConnectionGUID: eAgNH7wsR5aXIuQMNJf34w==
X-CSE-MsgGUID: 3jPWxIlAT1yp21GxuggHQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62797851"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62797851"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 01:32:22 -0700
X-CSE-ConnectionGUID: Y/yA1cWjRsWXrqjoLV2xgg==
X-CSE-MsgGUID: pYrQnveITxmgSgUos9jtnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="208155802"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 01:32:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 01:32:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 01:32:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.75) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 01:32:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ+yxAeCAfqFGfsiKqdksTGwNjllyxXUaRg53HKQ6eDkXv87w+y4lSQy4mSl9BfGvTKOkpu+hO86hsj9NfXLqfGeC/Kgaj3NuB5BRGS7NQhYDP2552ijqrnhHscMZNxF7mJ0OKphFMLPQdMEe8MqXX81HExRCLOxU+W0flhW26qHwStIjvr7g9ok1qIfJZq68V8eXPO7xfMtvoQcVtJdsAJV2DrbzKW+PR5oDSqWRYcOmNX7OUu7OuwbOtiDo3UQCbHs6EP+35GtIsI7YuEr5xOSV2w5XWBxleUjitKaaPNiczsoSlHXbzwk7lv1cU/TOMfgqsh/r3xq7VcdYAuOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjXVFSpyIRpNsybfGIe84q3/YQu5vvqfIh5L56E6Jtg=;
 b=ZbjcPG0edb6vsxGxG11yhBfqFUjoSjzwlStISqheyCh6CItonut/sK/tE31jcUHJOIiDpBVNxz3maHSbKiXAGaD/V+HNYqPdZSDpnyjRZtgYz1HkIN7Hm4Q0EcKAFnqT0IEzDbhN0WuP4rW5D+JNMuVyXbJEofkPMfgrKruQKwwEJnYnANoeQMfoCZI/7aMTu9s4Bh+2w4I5d17ssyJcoufp6cZAsyoSw2VQcwO5VT8hPhMT8+IuzIgkArqSd3jvmq0Hn3FjIaM9MYamfL2ZW4BiG5XBAkicpcNPG3KvLDB8+VGwTNV+zeSK/tdQHfYJEbGDAMFtPkU3M2sT+oC4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB9010.namprd11.prod.outlook.com (2603:10b6:208:564::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 08:32:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:32:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 17/21] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Topic: [PATCH v5 17/21] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Index: AQHcEy/2tnuVJ+VASEKLzn68yNLdALR33skAgAYrxUA=
Date: Mon, 1 Sep 2025 08:32:19 +0000
Message-ID: <IA3PR11MB913615C411CA017AB4259F919207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-18-zhenzhong.duan@intel.com>
 <7d979fe7-95ba-4216-8cb9-05a047673e35@redhat.com>
In-Reply-To: <7d979fe7-95ba-4216-8cb9-05a047673e35@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB9010:EE_
x-ms-office365-filtering-correlation-id: bb3562e8-6140-4580-f8d1-08dde93210b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eW0yYTNRMnhIYmlMUUVPMWhQNnEvZWRUd09uRWJtOGNTSEt0MEZYelppbW5o?=
 =?utf-8?B?QXBpaG1oSnc2QzJUU2FxN0JVbXhWVVNYcDNzZUtHQkoxakJQUHRZTmtXLzRT?=
 =?utf-8?B?TFpORlFySk1iTktpZ0xzUVc0TjhocVMvWUxiMjJ6QUpQVkJDeE44dFYrVFhm?=
 =?utf-8?B?b1kxK0xGWldQRDJUNjZKaFZ4SWE1cVB5Mm10eXgxNFZXcS9zRVV0empaTGg3?=
 =?utf-8?B?OTUrS2FlaDY2ZWJaeHRMdDBXSElGTjk5U0l3TVkwbnQ3anJUbjYzSWlEakFM?=
 =?utf-8?B?NW82alQ3QnNpTGJCQVMrL0VKbEFVQ0M3VU1qMEZuUkdjcmo5TVU1RkU3alpV?=
 =?utf-8?B?NVRkYTVzWXU5VzdnSnN5eWdKMllRQ2xnVmZybEhmdWNMTmxySGp6b0RtMDRI?=
 =?utf-8?B?QkJicGNoZU41N3V2QkZMOC9NQ1pwMzNKcDBFLzd3Z1pzRWZtN2F2cGZtaUx4?=
 =?utf-8?B?bWFhZitDWkxUY3lOdnN5bVNhVnJwQ3RrMldjRUxiNk9mMDFMUjFtYTFZVmhi?=
 =?utf-8?B?TDJqaC9Wb050Q2JyZW9GUmRmdjFoaG1NbkJaamxKOUU4dG80anYrZE4wY0Zi?=
 =?utf-8?B?STJQaXpnUnp0dWVFbHc2NEZvZWJYZEZ2WHpjWWFnRVpqU2V3WEZPUmY0aTI5?=
 =?utf-8?B?NHVXN1UxN3ZPUUtQVzVMMzNUTnE0WjNuMWdvRlZSRlNEdXlhYWFya0dJN0pE?=
 =?utf-8?B?R29qN3RER3lSY3hZMkVWeGg4amNmc21WRDBTRWFESlZnK0ZrUHdsVDRiM1di?=
 =?utf-8?B?ekZuSHhnMVF0M09LZ3FKQWw2WGw1RHFLYlVMZlBmNkp5a2I2dU5GWjB6RzMr?=
 =?utf-8?B?WDVHRWZuSFR3MjgwdTJIV0pFRkx3WkppV3Vpa05jbFpRV1FoaGw0SE0vVStS?=
 =?utf-8?B?dXJjSVZXdTNXcmJFMUtxekdMUzBEbXA3bGtzUFlLamQ5TDcyZ3JlNWs0eDlx?=
 =?utf-8?B?V3d3NEVNb0VlTmQyVURGdFJXM2k3Zld3ZGFYcnBxOEIzZ3N0ZnVtRThoMHBn?=
 =?utf-8?B?WWhQUVZKZGp0YUtOUkFtbE9SYWF0VHRjL0E4WmxnMlJSczdROXBPN0dnYkR5?=
 =?utf-8?B?MHQ4bXlBOWRpTmx6ZVhjUkNPOUlsNGpmMWhxRnNKV3FOdVhJNDBSbi9OcHhq?=
 =?utf-8?B?MVFlN3k4djdPSTljUlhKVHJ3WkRjMEhhWitTVURmVVJvQ0xQT2Qzck5GZjJ4?=
 =?utf-8?B?dkZHTmVIbXZhdXpFM1RQaFdjZTNVWE1DRUNBU2VZVjVDWFVLQm5aOHpWOHBO?=
 =?utf-8?B?clZ5ZmxST1o4MzVPdnZ3WHJVeWRZcXlRSUNPSGxPYlVLM3NDUjNXcjN5Szk0?=
 =?utf-8?B?VDJPRW9qU2s0TDVSemNKSUtUejc1bzkrTC93clk4YjN6RVAxTlArMUlZSFAy?=
 =?utf-8?B?Z1Q5L093VXIvUnJxSTJ1SFhITEo1QytPUlk4SnpmNGxSWnFDdElaWmJKblVz?=
 =?utf-8?B?YWVGa1M3REJiaU00Q05IZStaMXEvTVhKZGNOV2lyalVYVDZ4WmVlZk1jODlD?=
 =?utf-8?B?VG93YmlMcUlqWDNTaVNFMlRjei9XSSttbm1LYmNJY0FoNzJtY2ZVbEZhdkxl?=
 =?utf-8?B?QVJQTm9DKzduQ3k2dkt6T1ltbFgwcmV2djQ2WGlGT0ptU3ZEMEh5WTZiNzVF?=
 =?utf-8?B?aWZNbHlsS3hiQlZIelBGWXREeFdPVWtTUEFhSW11SDNBc3IwQnFhVTRjZ2p6?=
 =?utf-8?B?Q3ZtY2NUS3JyRWlsQnA0eWR1M3NSMHQ5YTlTR0IxNTlKUGh4dmdRL2Rrci9H?=
 =?utf-8?B?S1RQNUg5Mm0rTks2K3FVZUU1OHp4blgrMDZRTmJHczZMWnM4Ui9qSUo4SytR?=
 =?utf-8?B?RCt3SVdRQ1EvRmRkRGFZNHVxUmpkVWZGU0tkNk1MNHhsam1mRUlWQlBheE1Z?=
 =?utf-8?B?RFZlVjZtRHFLNHgydXhnSk9OTkpBSWlHYXE5WWFUa0szQ1ZnZm1JU0QvenJK?=
 =?utf-8?B?RUJobU9weVMzUTRtSUF6MzVhWUkrc3NtZ1BiSGxySGpBK0I0aEdKUkZ0N1g3?=
 =?utf-8?B?eURRMERTbUR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFZ6WWtnK1dNaGNvV1hGYng5VGdId2pIZ0NEMTlGaXZpektRUVFqTm5EcWpW?=
 =?utf-8?B?UHREUFlXcUM0eS9WeU5abURkNTlZMVFVbGhWenVkSmJBbVRBbDQ3UDVKbUxK?=
 =?utf-8?B?WkdGUHBYS3ErLzd4NnFkOHh3TmMrYTVFNHBDb0Z5WmRtNHVrUlRkQzB0MkxN?=
 =?utf-8?B?VmRlQkhXbkMyYUduZjM1SUNXQUtLU01KWjVaeDNycjREK1RpeUtoQzNXbGpG?=
 =?utf-8?B?WnFxSnBwSFBiYVFZYWNXU3pXYStaeVZ3N1ZGWGNNcERuaFBYREp0SEFuRHlr?=
 =?utf-8?B?WnZmTnhKNjl0V2VzcngybEVYcGE5N2t0ZUJTeGlyNS9zZHcydjZWT1hwSmhY?=
 =?utf-8?B?dDdmZTB5elJ3N0tBczZnWEJnQlBBcUpvZEhRYUpsT3NkRndZQ0Q1enJZcFNw?=
 =?utf-8?B?TWM0TTk4RUpKZVh6MVIwSFEzNTNFS2NrZW55YkUzRjlUek9Pb3N4S1VnbG5r?=
 =?utf-8?B?SWhQUmVQcVlFTlZyN08vQ3BNTVZITmxQZlBOZG5PWSt2NEhpK3JwNUkvQ2pE?=
 =?utf-8?B?d1RuejE5ZWdBai94VEJYdHZkZVNrQmxzL0JTc3I5cm9zc0tpWm5yTEVqNTRC?=
 =?utf-8?B?bTQ2RE55YXZFa256Y3pDTkloWDhUWHlybXlTeTBYbXNFQ0VhVUVuNWFSZ2M1?=
 =?utf-8?B?V3ozSVhTK1M0NTlTNVVwbEFCYzRBM01zQ3JoVWgyQVNSb2xuZjBDV0xPbW1N?=
 =?utf-8?B?MjVLVk9KelA1c1MvS3RsNWpVNGwxNS9MMFl2cHhtc2hrYm1UUkJuTEtCZGdq?=
 =?utf-8?B?RUhDS2xjSHVZNzQwN25yMWJPS3E0N0JKcEZzSG5nMGlFWExzVEFlMzB4VzVJ?=
 =?utf-8?B?UGR4b2RxZHVaUkhRTGwyUTY0cjAzYlc4bGd5T1M4R1luc3JzMHN5cU1kTGNk?=
 =?utf-8?B?M3FjQWdCZDc5TnI3eFR1Z0tHTGtDbkY0L3YyNDI2ZGpqVk9ENUI2ZzdKSVhv?=
 =?utf-8?B?UkJWVjY4UnhPamlqY2xXYksvT0IxT1NwWm9paTQ5UzhURlJIZE9CbGxwYTVE?=
 =?utf-8?B?eHRFRmpiVlVibE9hSjdGOXV1eDgzd2FPUmJyNnR2a21qWVI5cmVLaTVaTWI5?=
 =?utf-8?B?TkpjemxweEhTRkVQQ2kxLzFlRUUyeE5SdEJ2TERRUTh5NERKdDMzNkJONWFL?=
 =?utf-8?B?dDA3TDJUZWNyN2JYbkpaTjNVR2tpeG11akYrQ242UEY0MGswSytselo5ZWlZ?=
 =?utf-8?B?emhkc1FDeDh3NFpOdzRtenIyVmQrSUYxY1M5ZmRDVGY4RkRPb1NJeWpJOGhn?=
 =?utf-8?B?SmFwSmd4bENzbE56c25oY29NYy80dzlzTmhGeGh6RDN3T1V3VGpvSTUxdDZ3?=
 =?utf-8?B?Rmk4SjFQTERlQ09hbnVFSDJOQTRPc3lyL1JsbHpabStKQlhWTTBCWDhCM3I3?=
 =?utf-8?B?WHhnNjVsY2QxZllQK2FKdU9SYkJYbVM4QjN6VlBtanR2S0RqU1V1RzlEMmFm?=
 =?utf-8?B?S3VZdjBWTllwMVlxVXpqZGkrUnBjTFAyazZCK0szdlpJUG1lMG1NclBwRDk3?=
 =?utf-8?B?algwdlA2Y0s5MnBkNllndW9ZKzhuZitVak5ySE03MGRlTUlQL2g1MU9YK2s4?=
 =?utf-8?B?TmlZdlNSdTZ3MjlmTHNyU0NCenNUcWVvR2ZQRUZEcEhacWQ3RURaVDNhQXg5?=
 =?utf-8?B?Y0NXSUxkMGl3M0p0YnZwODdqTi93S0wxb3p3OE12T0RaQ2lWeTd3UXRuNitU?=
 =?utf-8?B?ZEFUOGN2Q1BGVDlTQ1JFSWpmQWk2TUpJZUROZ1BWbFlPaUF0amlldktSZWEr?=
 =?utf-8?B?M0dwT2cyZ25TODFLOGk3Ky8xSUtodStCZ21iUnFlS0NtSkI3aEF4N1JRUllx?=
 =?utf-8?B?Rmw1bDFHVGszeWsxbHJyT2hwSEZxOXlsNFhJMDF0RHhMcW5iY3N6ckNvK3pG?=
 =?utf-8?B?dysreHhlMy9CM2hRL2ljZ1k4NUE2MUh3UkJFZG1VR0NONGtDNmtzTmZnMmR5?=
 =?utf-8?B?OFRrVDI2d2pSbmFBcVhIWGxCN3gzWVMzZmFPR3RHVHJWRUZTRUdVUm9EV3Jn?=
 =?utf-8?B?QkxVVisvL3o3SGQ2SjZnQ3R6cWRUNUZHNGVRNWpHKzlneDNRcWdqZnc3ME9C?=
 =?utf-8?B?U292SVJNVVJiRStjdGdrd3l5U0dYQ1V4ZlV6MEs4cFBsZTJxL0JDTkFCdTM4?=
 =?utf-8?Q?90K07Nr1H/v8F6DtnhacEahIW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3562e8-6140-4580-f8d1-08dde93210b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:32:19.3853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqvQ4lno+l/5ts4Ah+oSrIgMKiC//ljDrUwh1JE2GvWFis3vFDA6fv75CWm/gSCqD1zTFeUPFuEWO7c14Nx4XGw9qbhjK8IA3KBiceHoIP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9010
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDE3LzIxXSBpbnRlbF9p
b21tdTogUHJvcGFnYXRlIFBBU0lELWJhc2VkIGlvdGxiDQo+aW52YWxpZGF0aW9uIHRvIGhvc3QN
Cj4NCj4NCj4NCj5PbiA4LzIyLzI1IDg6NDAgQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
RnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4gVGhpcyB0cmFwcyB0aGUg
Z3Vlc3QgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHJlcXVlc3QgYW5kIHByb3BhZ2F0
ZSBpdA0KPj4gdG8gaG9zdC4NCj4+DQo+PiBJbnRlbCBWVC1kIDMuMCBzdXBwb3J0cyBuZXN0ZWQg
dHJhbnNsYXRpb24gaW4gUEFTSUQgZ3JhbnVsYXJpdHkuIEd1ZXN0IFNWQQ0KPj4gc3VwcG9ydCBj
b3VsZCBiZSBpbXBsZW1lbnRlZCBieSBjb25maWd1cmluZyBuZXN0ZWQgdHJhbnNsYXRpb24gb24g
c3BlY2lmaWMNCj4+IHBhc2lkLiBUaGlzIGlzIGFsc28ga25vd24gYXMgZHVhbCBzdGFnZSBETUEg
dHJhbnNsYXRpb24uDQo+Pg0KPj4gVW5kZXIgc3VjaCBjb25maWd1cmF0aW9uLCBndWVzdCBvd25z
IHRoZSBHVkEtPkdQQSB0cmFuc2xhdGlvbiB3aGljaCBpcw0KPj4gY29uZmlndXJlZCBhcyBzdGFn
ZS0xIHBhZ2UgdGFibGUgb24gaG9zdCBzaWRlIGZvciBhIHNwZWNpZmljIHBhc2lkLCBhbmQgaG9z
dA0KPj4gb3ducyBHUEEtPkhQQSB0cmFuc2xhdGlvbi4gQXMgZ3Vlc3Qgb3ducyBzdGFnZS0xIHRy
YW5zbGF0aW9uIHRhYmxlLCBwaW90bGINCj4+IGludmFsaWRhdGlvbiBzaG91bGQgYmUgcHJvcGFn
YXRlZCB0byBob3N0IHNpbmNlIGhvc3QgSU9NTVUgd2lsbCBjYWNoZSBmaXJzdA0KPj4gbGV2ZWwg
cGFnZSB0YWJsZSByZWxhdGVkIG1hcHBpbmdzIGR1cmluZyBETUEgYWRkcmVzcyB0cmFuc2xhdGlv
bi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+
IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA2ICsrKw0KPj4gIGh3
L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDk1DQo+KysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRl
cm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IDhhZjEw
MDQ4ODguLmMxYTkyNjM2NTEgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAg
LTU5Niw2ICs1OTYsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSURDYWNoZUluZm8gew0KPj4g
ICAgICB1aW50MTZfdCBkZXZmbjsNCj4+ICB9IFZURFBBU0lEQ2FjaGVJbmZvOw0KPj4NCj4+ICt0
eXBlZGVmIHN0cnVjdCBWVERQSU9UTEJJbnZJbmZvIHsNCj4+ICsgICAgdWludDE2X3QgZG9tYWlu
X2lkOw0KPj4gKyAgICB1aW50MzJfdCBwYXNpZDsNCj4+ICsgICAgc3RydWN0IGlvbW11X2h3cHRf
dnRkX3MxX2ludmFsaWRhdGUgKmludl9kYXRhOw0KPj4gK30gVlREUElPVExCSW52SW5mbzsNCj4+
ICsNCj4+ICAvKiBQQVNJRCBUYWJsZSBSZWxhdGVkIERlZmluaXRpb25zICovDQo+PiAgI2RlZmlu
ZSBWVERfUEFTSURfRElSX0JBU0VfQUREUl9NQVNLICAofjB4ZmZmVUxMKQ0KPj4gICNkZWZpbmUg
VlREX1BBU0lEX1RBQkxFX0JBU0VfQUREUl9NQVNLICh+MHhmZmZVTEwpDQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRl
eCA2YzBlNTAyZDFjLi43ZWZhMjJmNGVjIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yNjExLDEyICsy
NjExLDk5IEBAIHN0YXRpYyBpbnQNCj52dGRfYmluZF9ndWVzdF9wYXNpZChWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9hcywgVlREUEFTSURPcCBvcCwNCj4+DQo+PiAgICAgIHJldHVybiByZXQ7DQo+PiAg
fQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkDQo+PiArdnRkX2ludmFsaWRhdGVfcGlvdGxiX2xvY2tl
ZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBpb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlDQo+KmNhY2hlKQ0KPj4gK3sN
Cj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzID0gdnRkX2FzLT5pb21tdV9zdGF0ZTsNCj4+ICsg
ICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCA9IHZ0ZF9maW5kX2hpb2RfaW9tbXVmZChz
LA0KPnZ0ZF9hcyk7DQo+PiArICAgIEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXY7DQo+PiAr
ICAgIHVpbnQzMl90IGVudHJ5X251bSA9IDE7IC8qIE9ubHkgaW1wbGVtZW50IG9uZSByZXF1ZXN0
IGZvciBzaW1wbGljaXR5DQo+Ki8NCj5jYW4geW91IHJlbWluZCBtZSB3aGF0IGl0IGlzIHVzZWQg
Zm9yLiBXaGF0IDE/DQoNCkkgc2VlIFlpIGhhcyBhbnN3ZXJlZCB0aGlzIHF1ZXN0aW9uLg0KDQo+
PiArICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4gKw0KPj4gKyAgICBpZiAoIXZ0ZF9o
aW9kIHx8ICF2dGRfYXMtPnMxX2h3cHQpIHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAg
fQ0KPj4gKyAgICBpZGV2ID0gSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlvZC0+aGlv
ZCk7DQo+PiArDQo+PiArICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2ludmFsaWRhdGVfY2FjaGUo
aWRldi0+aW9tbXVmZCwNCj52dGRfYXMtPnMxX2h3cHQsDQo+PiArDQo+SU9NTVVfSFdQVF9JTlZB
TElEQVRFX0RBVEFfVlREX1MxLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZigqY2FjaGUpLA0KPiZlbnRyeV9udW0sIGNhY2hlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZsb2NhbF9lcnIpKSB7DQo+PiAr
ICAgICAgICAvKiBTb21ldGhpbmcgd3JvbmcgaW4ga2VybmVsLCBidXQgdHJ5aW5nIHRvIGNvbnRp
bnVlICovDQo+PiArICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vycik7DQo+PiArICAg
IH0NCj4+ICt9DQo+PiArDQo+PiArLyoNCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIGlzIGEgbG9vcCBm
dW5jdGlvbiBmb3IgdGhlIHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcw0KPj4gKyAqIGxpc3Qgd2l0aCBW
VERQSU9UTEJJbnZJbmZvIGFzIGV4ZWN1dGlvbiBmaWx0ZXIuIEl0IHByb3BhZ2F0ZXMNCj4+ICsg
KiB0aGUgcGlvdGxiIGludmFsaWRhdGlvbiB0byBob3N0Lg0KPj4gKyAqLw0KPj4gK3N0YXRpYyB2
b2lkIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9sb2NrZWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2
YWx1ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2lu
dGVyIHVzZXJfZGF0YSkNCj4+ICt7DQo+PiArICAgIFZURFBJT1RMQkludkluZm8gKnBpb3RsYl9p
bmZvID0gdXNlcl9kYXRhOw0KPj4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcyA9IHZhbHVl
Ow0KPj4gKyAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0gJnZ0ZF9hcy0+cGFzaWRf
Y2FjaGVfZW50cnk7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkOw0KPj4gKyAgICB1aW50MTZfdCBk
aWQ7DQo+PiArDQo+PiArICAgIC8qIFJlcGxheSBvbmx5IGZpbGxzIHBhc2lkIGVudHJ5IGNhY2hl
IGZvciBwYXNzdGhyb3VnaCBkZXZpY2UgKi8NCj4+ICsgICAgaWYgKCFwY19lbnRyeS0+dmFsaWQg
fHwNCj4+ICsgICAgICAgICF2dGRfcGVfcGd0dF9pc19mbHQoJnBjX2VudHJ5LT5wYXNpZF9lbnRy
eSkpIHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAo
dnRkX2FzX3RvX2lvbW11X3Bhc2lkX2xvY2tlZCh2dGRfYXMsICZwYXNpZCkpIHsNCj4+ICsgICAg
ICAgIHJldHVybjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBkaWQgPSBWVERfU01fUEFTSURf
RU5UUllfRElEKCZwY19lbnRyeS0+cGFzaWRfZW50cnkpOw0KPj4gKw0KPj4gKyAgICBpZiAocGlv
dGxiX2luZm8tPmRvbWFpbl9pZCA9PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lkID09IHBhc2lk
KSB7DQo+PiArICAgICAgICB2dGRfaW52YWxpZGF0ZV9waW90bGJfbG9ja2VkKHZ0ZF9hcywgcGlv
dGxiX2luZm8tPmludl9kYXRhKTsNCj4+ICsgICAgfQ0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
dm9pZA0KPj4gK3Z0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVsSU9NTVVTdGF0
ZSAqcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBkb21h
aW5faWQsIHVpbnQzMl90DQo+cGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IG5wYWdlcywNCj5ib29sIGloKQ0KPj4gK3sNCj4+
ICsgICAgc3RydWN0IGlvbW11X2h3cHRfdnRkX3MxX2ludmFsaWRhdGUgY2FjaGVfaW5mbyA9IHsg
MCB9Ow0KPj4gKyAgICBWVERQSU9UTEJJbnZJbmZvIHBpb3RsYl9pbmZvOw0KPj4gKw0KPj4gKyAg
ICBjYWNoZV9pbmZvLmFkZHIgPSBhZGRyOw0KPj4gKyAgICBjYWNoZV9pbmZvLm5wYWdlcyA9IG5w
YWdlczsNCj4+ICsgICAgY2FjaGVfaW5mby5mbGFncyA9IGloID8gSU9NTVVfVlREX0lOVl9GTEFH
U19MRUFGIDogMDsNCj4+ICsNCj4+ICsgICAgcGlvdGxiX2luZm8uZG9tYWluX2lkID0gZG9tYWlu
X2lkOw0KPj4gKyAgICBwaW90bGJfaW5mby5wYXNpZCA9IHBhc2lkOw0KPj4gKyAgICBwaW90bGJf
aW5mby5pbnZfZGF0YSA9ICZjYWNoZV9pbmZvOw0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAg
KiBHbyB0aHJvdWdoIGVhY2ggdnRkX2FzIGluc3RhbmNlIGluIHMtPnZ0ZF9hZGRyZXNzX3NwYWNl
cywgZmluZA0KPm91dA0KPj4gKyAgICAgKiB0aGUgYWZmZWN0ZWQgaG9zdCBkZXZpY2Ugd2hpY2gg
bmVlZCBob3N0IHBpb3RsYiBpbnZhbGlkYXRpb24uIFBpb3RsYg0KPkFyZSB5b3UgbGlrZWx5IHRv
IGZpbmQgc2V2ZXJhbCB2dHNfYXMgdGhhdCBtYXRjaCBpbnZhbGlkYXRpb24gcGFyYW1zPw0KDQpU
aGlzIGlzIHBvc3NpYmxlLCBpdCBkZXBlbmRzIG9uIGd1ZXN0IGtlcm5lbCBpbXBsZW1lbnRhdGlv
bi4gVGhlcmUgY2FuIGJlIE4gZGV2aWNlcw0KYXR0YWNoZWQgdG8gb25lIGRvbWFpbiBpbiBndWVz
dCwgdGhlbiBpbiBxZW11LCBOIG5lc3RlZCBIV1BUcyBjcmVhdGVkIGFuZCBhdHRhY2hlZCB0byBO
IGRldmljZXMgb24gaG9zdCBzaWRlLg0KDQo+PiArICAgICAqIGludmFsaWRhdGlvbiBzaG91bGQg
Y2hlY2sgcGFzaWQgY2FjaGUgcGVyIGFyY2hpdGVjdHVyZSBwb2ludCBvZg0KPnZpZXcuDQo+PiAr
ICAgICAqLw0KPj4gKyAgICBnX2hhc2hfdGFibGVfZm9yZWFjaChzLT52dGRfYWRkcmVzc19zcGFj
ZXMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9s
b2NrZWQsDQo+JnBpb3RsYl9pbmZvKTsNCj4+ICt9DQo+PiAgI2Vsc2UNCj4+ICBzdGF0aWMgaW50
IHZ0ZF9iaW5kX2d1ZXN0X3Bhc2lkKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBWVERQQVNJRE9w
DQo+b3AsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnAp
DQo+PiAgew0KPj4gICAgICByZXR1cm4gMDsNCj4+ICB9DQo+PiArDQo+PiArc3RhdGljIHZvaWQN
Cj4+ICt2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMs
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgZG9tYWluX2lk
LCB1aW50MzJfdA0KPnBhc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGh3YWRkciBhZGRyLCB1aW50NjRfdCBucGFnZXMsDQo+Ym9vbCBpaCkNCj4+ICt7DQo+PiArfQ0K
Pj4gICNlbmRpZg0KPkNhbid0IHlvdSBwdXQgdGhvc2Ugc3R1YiBzdHVmZiBpbiBhIHNwZWNpZmlj
IGhlYWRlciBhcyBpdCBpcyB1c3VhbGx5IGRvbmU/DQoNClRoYXQncyB1c3VhbGx5IHRydWUgZm9y
IHB1YmxpYyBmdW5jdGlvbnMsIGJ1dCB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZCgp
IGlzIGEgc3RhdGljIGZ1bmN0aW9uLCBkbyB3ZSByZWFsbHkgd2FudCB0byBwdXQgaW4gaGVhZGVy
IGFuZCBleHBvc2UgaXQgdG8gb3RoZXIgYyBmaWxlcyB1bm5lY2Vzc2FyaWx5Pw0KDQpUaGFua3MN
ClpoZW56aG9uZw0K

