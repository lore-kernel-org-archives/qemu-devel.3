Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4797DCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 09:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZ4K-0000Rn-EE; Thu, 28 Aug 2025 05:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urZ4E-0000RB-6v
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:37:14 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urZ4B-00081V-26
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 05:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756373831; x=1787909831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=810W9SNkfnJlIAJefeFRPzuSFAHW/RpkK69Sj1t0zIc=;
 b=knela8PkZz8kexX35ycyj0xhzr8ahQpwsumqxz8KKPw84OGNxYRifhwW
 xXfEV/md53KA19aFZEHTCosQnP+HBIL+tpKc/3YM2r6ATSdJu1xTFQ4Ad
 y403eZGvTQDl3YzEVB+Xb2XC9nWLF2gjLobxNpa6dd8w9EuK0jad0N4kb
 Fd1eobheyDj++VjOHQopss+2Di2say51Mvmeq0euQjs4AOyr+UK9HCtEU
 aAs7xtG8ypLOi7Lx7f53Xq/8b7h4FwXWKdp43Em4M2VlhWFqPT0d93Wi7
 3s3wq/J5ihYofDGh8gnTDYHodbX2eaPvRLqkLRDD0Crg5dEsgl6LRV/xZ A==;
X-CSE-ConnectionGUID: JJz1B5dgQBCl4ma51Vuhkw==
X-CSE-MsgGUID: mIgn9bLHS8SpZjSPYrRAFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="68910747"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="68910747"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:37:08 -0700
X-CSE-ConnectionGUID: FIEkZjgFToeYd/nKYyVmSg==
X-CSE-MsgGUID: esBf5A+QSnyhW2Kt2Z9ARQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175361513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 02:37:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:37:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 02:37:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 02:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efRsbtDuXt4AC+A9exhbFNWUDAYhzPzNjdFh+JOkW4wITTfn7Co5TyUIBq3HkOCmOueAOOpRyAPmsid+2EP1iEImSothi4eHY1Ixz5TNaaFjUwslVgEPRcJt5fk09/L3U+9d1YZQIowTUAjSxcwb7o/Qxq3yAAxKFFE6rUVIWCdqHJMbinLH4ZfymBotPrNICC/6XcHB+GKWK6uXI+H3/VuX35W/731U5oERJv1cnijeXBoCAtdPMl3j4kmBjSG+rCIuBWFRqie0Y0yGqQzjBFgOoGhUmvpE5xwlg5BGm9+DI7m5E9MOZJKZ47xTyoFLOAnaaZQeKmEIdqz9T0RG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=810W9SNkfnJlIAJefeFRPzuSFAHW/RpkK69Sj1t0zIc=;
 b=TmOGkpj54iOU0yrxMwrBo+6XwD0aKbApQdCKjnycYEALTQT4pF/M8726PyIeOcpgUjple1TyF+tk/XwD/yDfTW8yUDJP+AnjpcQyI50Uibf+sltw25BB21YwEflOdK3eatVpfzG/dUSI3spO/2uGmgicv2ZFi/VjzyN1/ZIV1V726ox64p5HgIq/fHU2np3wxG2Vvvcm5KtwK6AccAK6PnPzqO4ZLRtquxI9mwN0kiAnf4aySfiXMsISP2VqUCYMt2q8FIA8XCqJbmuOrQAwIcPWTj1DRM34dEJCQLxWNraePVx4tbHC0BQ34VOiDEDF53j5psusEkI3vt5GRUcA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 09:37:02 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 09:37:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 08/21] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v5 08/21] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHcEy/i6bGqJrN+7EaTZS8dJ2YP17R2aNuAgAFqxpA=
Date: Thu, 28 Aug 2025 09:37:02 +0000
Message-ID: <IA3PR11MB913635BD9F899CDE0D8F225F923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-9-zhenzhong.duan@intel.com>
 <ce1f61db-5746-4ae4-837f-237e9aa5de1c@intel.com>
In-Reply-To: <ce1f61db-5746-4ae4-837f-237e9aa5de1c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5084:EE_
x-ms-office365-filtering-correlation-id: fd5bd5ba-2a24-4e28-4d70-08dde6167173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YjN0T295ZkVJaVczbng5N3A3cWpkaSs1ZjU5V1FZZ3pKSEh5Rlo3TE1CTGZs?=
 =?utf-8?B?SklZMHFsVjZhM0c3cVRsVEdjNjh1c0tSYUpTL1lqSEEvZU9UNzBZYXBtblBj?=
 =?utf-8?B?eS9MTS9XUjltd21Db29WMzdUMWluTEw1MjRPN1pvaUJhMVk4cXEwUWtjdUhR?=
 =?utf-8?B?Nkwzc2psZEV2Q3ZoWTRKZzJhWld5MDRpNFdXemF4MGVPNmVlTjNzTS9ITTdG?=
 =?utf-8?B?U1ZjaUZISTFKYkNOUnRucWZqMVNwakhmRVdXOENGS0t3ZUNnRkhxYUkzZm9m?=
 =?utf-8?B?V3o5UUpPL0gzcENjL0V1dUtQSTlmZmZ6bTB3S1JMTGQrUFpWQjIxS2hLOUhW?=
 =?utf-8?B?N0pBQU1WLzFVRXYwSFpIdmx6QmdHTSswbDg0SGx1dVV4ZHljSjlHMlpIa0Z0?=
 =?utf-8?B?UkxqTThVajVwL284bi9KeGR6YjV1WTYwTWl4MWhvbElnMkVFVys3SGJ6OE1p?=
 =?utf-8?B?R25rbDJGRjlabXRERk1FRlYzckJRcnNHSjZVdmYwVTJIdTM0ZUtzaUs1MDg3?=
 =?utf-8?B?WGcvQVU0R05VUVNXZGNKL3diRDdzNGIwTk9pK1RRcytkQ0YyMnh2dC9WTHA4?=
 =?utf-8?B?bmtWUGNsek5NSUpId0p4dTVCSmp2QUl4SGtERmFmRzJSVkRtRTJaTEZvd2x1?=
 =?utf-8?B?UzlkOSswdWRzWGlHRGo0d1psZmt4aWNuYmJJeXFIUGo0eEloQ3Y3S2JPQy82?=
 =?utf-8?B?Umk0dEhrM0hTTWhiQkJ4MXhTSTVzcm9NQjhJUkxwTU5NY2laTjdHZlhNckJF?=
 =?utf-8?B?Z1RVTkptT0JuRFErbllvaS9uclZGYnJUblAxR2FxblJCMHQwR0RsK1FXd1h6?=
 =?utf-8?B?cXlWUzNqUzI2Wm1pczIwM2tiTW1FcU1WRGdjaC9XbnlLc3E4T282L1dJb2Y4?=
 =?utf-8?B?QTRwcFhxZHUyaSs2YzNDVERCSzhDczNjV1V1cDdtSmRXd21UMmoxZUpNSThO?=
 =?utf-8?B?Q21Bb3BOSVY5RG9mVkhnL0pvTys4WnJZSjNWelVxREpsL1VCeExyc1BEbExy?=
 =?utf-8?B?Z1VUbUZmdkllMFZhdzRGcnlHVFFOV2VMR3ZjSTNGdDFGTk13SlFib2FKRUk2?=
 =?utf-8?B?dXBiWnpVZExWamVHTkhaVTNQbzZtNXgwaTRWdW92dTFuQzYza2JzOTkxU0U3?=
 =?utf-8?B?VWxiUmNlczlmRXVrWURGV2xpZEVKSU53VUh0emJmVjl3N0hWMDU0M3pKRlNP?=
 =?utf-8?B?bk1KNGs0aDZZK0xsR2JNVGs3b3UybmhCejRwZ2w1QmNCSXVOK2hBU0c5NHdw?=
 =?utf-8?B?enhLYkl6V00ySVVkM1QwMEEzbXJTcVNJNmdNeGNMR01lelUrRjJyZmhHSHc4?=
 =?utf-8?B?dW9wcy9VeTcyNzNPWHJMSFV0K0VVcjR3MEFURk9VUWxFTm5pV29vdWp6NS9v?=
 =?utf-8?B?SXgxdVNydWFSbU0zVUtyd28wbDdKbTVxK3VPSjVPa2ZNU3AreG8xbENpMW44?=
 =?utf-8?B?VkcvWFdVcmdBeDhPRDRhNlBZMDhyMWxENEFpKzFXYm1JQTBFR3ZPdnJKMTdE?=
 =?utf-8?B?eTJsd253eitvQnhvUmt3RWhCektmR09UeU1KOFJyWlFVYVIveTU0d21YQk5l?=
 =?utf-8?B?QVlWeGdJTVF5SnFNdUErVnBYV1VkcWxTd1dLamdIMlA3Z01LNFArYlpxU3BG?=
 =?utf-8?B?dloyK3BibzJhR25jdUhCNTdKSHZ6VHljZ1FPSHFqQU8xYThnMFdubk9pdkNy?=
 =?utf-8?B?eU9NaE9reFBPdG9vZEJUYzJ5OExqZVFDaUJtbzRZRFBaTHZjdWc4Z2szWUx0?=
 =?utf-8?B?aXdOOHNXcnRQSFdzMTZGT3UwRXdZMWdoc0xKbEhXK0tmejk3RURZYXF6OGI2?=
 =?utf-8?B?aFVVeE9FbGo2NEtabEdiTE9QbUt5RE1MRjNsdjY5V3VPQVRYZnlKWWRxYmRw?=
 =?utf-8?B?QWpiY3V0Z21SaFA1OWtsL2VXa3owbWNXRWc5alIrU0hFZDEwc3FyU2VZdUV4?=
 =?utf-8?B?YUZabDhjRlNXS0FwMEsvTFk3ZVNQa2JJN01GWFBja2loOHdpRXMzNno1SnZC?=
 =?utf-8?Q?JNw/j4zwrm9sb9seW6tWlNYdI+CPeA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUpqZVVCYlRwZkFMeVd6M2lHbUdJQW42T2xQUFJNV0FYNGR0NGptMVR0Wkxx?=
 =?utf-8?B?SXhrM0RtRmg2SnV2c3VEQ1A5cGdmM1RDbFI3M0tDZ1F4Ylcwakd0b0RzNGZ1?=
 =?utf-8?B?Qm1BWE56OGprcXRWZWR6YU1CL1RhK3NlWlMxcVVaMm1ReVFNSmZUL3BqY1B2?=
 =?utf-8?B?V1V2RWhFanY2czZ1emk3dkxFSythdWtvNzV4c0RHV09yQkVQck8wakZzUUdk?=
 =?utf-8?B?L2RMMWpkRldsVXlScnZvc0tMQ21BenE2QURYUjZxVEk1Vmt2VDFDb2ZzKzd5?=
 =?utf-8?B?T2xidCsvV0RWV1FaRi9NNE5uTzZGUnpIVytjQ3BPUmg2cE5VYnF4bTQ4NDRa?=
 =?utf-8?B?citmeWhWRjd3S1BoRkUrTk9CTmppT3JnTnJkU0FhL3AxWnNveFJtMkExYWlS?=
 =?utf-8?B?UnNocEZnOWUwTHVLU3JqdkozWTZkNEhKTGNma2tzVFhGdlFxTDlZRWpyNjl5?=
 =?utf-8?B?TGt2RTh6VGp0NjZwQjBmRlRJb2RWVGxUTEV4TnNLcmVHQmxnVUlvSVBEbUJ3?=
 =?utf-8?B?d3ZxY0tWWkdOYkRuQ2xUUmJ3Zk1sT2UyVFdJWDBuNEcyOXU1R0U5RXdkMHhJ?=
 =?utf-8?B?WllBdXJ4clpHeFJac1c2TWh4VDZlZHpPa29ZUzJHMkhRNmpOL3doWU02VElF?=
 =?utf-8?B?YVorYVY3WEwwWFI2d0U5RnJBenk3TXROZ0x3d25VMnBWVjN6OEZGbmZVaGIz?=
 =?utf-8?B?Q1U4OFh1b3pOdEpiNkZkcWV3ejlCdCtTTGpvbzdjN1IxRnorRlg2MlQvZTRX?=
 =?utf-8?B?UnBCWWJmVzBTNURyT2ZQbWx2YlEwMTZVdTdFMDJ0cXl3YVhCR2VodmlrdmQ0?=
 =?utf-8?B?VHcvVEJqVlA1U25IRzMrUHRUbUlCWkYxYlk5dTRRemRxVDAwb2pQY2xBakhB?=
 =?utf-8?B?T3grb3FsWG1YT081dS85MDRNOU0xUFpIUk5iWTZIZVJMZmhETXlCdWo0VnZ1?=
 =?utf-8?B?cW55TFd1UlRlS3JZcDc3eENnM3BnTWhzQmlweDVIc3dDaTlkdEV5MVprZWNY?=
 =?utf-8?B?WFV6M3FSdmkwVEtSSkNQMWY4Smt2eUE1b2NYSW5iZVJCdHZRN1JXVGdIajBO?=
 =?utf-8?B?bExPYnNpZ3gvUHhONVhIUXB2MExvdk5wNS9IRjRERTVCNFdWV0drRmtLcmdQ?=
 =?utf-8?B?VUMvSDZCMlFpaElwcUJHb3RkSjc0TmhnNUk5Nm5PVnAydThucWw5TFZpbnRx?=
 =?utf-8?B?MEkrdjZKNWI0UVVwRGRWeEd5dFhVcjl2WDdUNDVDcUVMUmNlbVNVSVNmWSs2?=
 =?utf-8?B?QzBDMzFTRmp2eHNEZnJtT0loYmExdXJuR1hvODl2YW8veWFGSVRzVWR4M0Vh?=
 =?utf-8?B?aElSK2NjYkJHbHB3QlVOUEUvdlMwY2k5V3U1TWtIK0xlTFZIV3R1cXFBcWlZ?=
 =?utf-8?B?QitxLzBucmJvY0ZtZURqaE9RRlhyckZKcW80MWF4cVFDZHRhUXJIYzdwQUVM?=
 =?utf-8?B?bkRSWHRkQ0RCV0VwNE15aWZwZ1dpL0hFRzhaVVlyd0h0Z0pqbVJXcHo5eDRW?=
 =?utf-8?B?UHhGQi91bzdVMzZudDhGcFhXcmpTeUxremJUVWdMV2cyQXpBaU1CNTVUSzhW?=
 =?utf-8?B?eG1GUG55YjBSazdEYU1lblJHRGtzNWczRG1mY0lhbm9pZUI5OHVxMG5yMUZW?=
 =?utf-8?B?WlQ5QmlUakIzK01WcnJJM3dqdm1KMUdJOThPOXNsQ1FvV0NKTmJBcWtVQ3dF?=
 =?utf-8?B?U1ZMSUJtTHg1bzFFUTdBK0pHeG5vWjZqUWxnTURPS2NZK0V4WjFWaGZpb1Yr?=
 =?utf-8?B?RXpVQVlENURlbGFhQVhsMDZ1WGdkSVZuUUs3ditMRWVRSlRNeGcwNjJXTkRp?=
 =?utf-8?B?QzJ2RHRwN3V5UjZDVHNGUXVIM1hRK0tCNDFBM1RJV2o4MW11M0tDMkxYK0xJ?=
 =?utf-8?B?dkxJVkhQRFhHTXBXbndsc0JCdXlNT3A2S2JUc2d0aXdkb3JLaFBRTWw3QVZ1?=
 =?utf-8?B?Lzh4TkxENkZrMEdxSFl1bHJYcVA0dDBWSmxtL1o4S3dwOVFNblB6b0VSam55?=
 =?utf-8?B?TlBIOXBDcU53OGxja0t6WTVrNG1JTDVSbjB3MXRWbkdkUWxDc0tPcmhiSWlk?=
 =?utf-8?B?bVBmZXJLMHgxd29mM1ZmS3F5UU5WUXBUb3R6Q3U3UUZXRFNwNDdmV2ZHYzBW?=
 =?utf-8?Q?zNmTNSxAdH5A6Nn8F4MetFVML?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5bd5ba-2a24-4e28-4d70-08dde6167173
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 09:37:02.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKKYMOyHWWbYP3yhrscn6dFWC2WbPAZ54RbpAvpb5khPke2Unj/DhMpiepeCA9khLuyuiy8OWtAS7awHzFwi2jjN42SRg+Pf9CJuvBKmN5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDgvMjFdIGludGVsX2lvbW11
OiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eSB3aXRoDQo+SU9NTVVGRCBiYWNrZWQgZGV2aWNlIHdo
ZW4geC1mbHRzPW9uDQo+DQo+T24gMjAyNS84LzIyIDE0OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IFdoZW4gdklPTU1VIGlzIGNvbmZpZ3VyZWQgeC1mbHRzPW9uIGluIHNjYWxhYmxlIG1v
ZGUsIHN0YWdlLTEgcGFnZSB0YWJsZQ0KPj4gaXMgcGFzc2VkIHRvIGhvc3QgdG8gY29uc3RydWN0
IG5lc3RlZCBwYWdlIHRhYmxlLg0KPg0KPmZvciBwYXNzdGhyb3VnaCBkZXZpY2VzIDopDQoNCk9L
Lg0KDQo+DQo+PiBXZSBuZWVkIHRvIGNoZWNrDQo+PiBjb21wYXRpYmlsaXR5IG9mIHNvbWUgY3Jp
dGljYWwgSU9NTVUgY2FwYWJpbGl0aWVzIGJldHdlZW4gdklPTU1VIGFuZA0KPj4gaG9zdCBJT01N
VSB0byBlbnN1cmUgZ3Vlc3Qgc3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIGJlIHVzZWQgYnkgaG9z
dC4NCj4+DQo+PiBGb3IgaW5zdGFuY2UsIHZJT01NVSBzdXBwb3J0cyBzdGFnZS0xIDFHQiBodWdl
IHBhZ2UgbWFwcGluZywgYnV0IGhvc3QNCj4+IGRvZXMgbm90LCB0aGVuIHRoaXMgSU9NTVVGRCBi
YWNrZWQgZGV2aWNlIHNob3VsZCBmYWlsLg0KPg0KPmRvIHlvdSBoYXZlIGEgbGlzdCBvZiB3aGF0
IGNhcHMgc2hvdWxkIGJlIGNoZWNrZWQgdG8gZW5zdXJlIGd1ZXN0DQo+c3RhZ2UtMSBwYWdlIHRh
YmxlIHdvcmsgb24gaHc/IEkgY2FuIHNlZSBFQUZTLiBCdXQgaXQgaXMgbm90IHlldCBleHBvc2Vk
DQo+dG8gZ3Vlc3QsIHNvIG5vIG5lZWQgdG8gY2hlY2sgaXQgZm9yIG5vdy4NCg0KQ3VycmVudGx5
IEkgb25seSBzZWUgRlMxR1AsIEFUUywgUFJRIGFuZCBQQVNJRCBpc24ndCBzdXBwb3J0ZWQgeWV0
LiB2SU9NTVUgb25seSBlbmFibGVzIGEgc21hbGwgc2V0IG9mIGNhcGFiaWxpdGllcyB3aGVuIHgt
Zmx0cz1vbi4NCg0KPg0KPj4NCj4+IEV2ZW4gb2YgdGhlIGNoZWNrcyBwYXNzLCBmb3Igbm93IHdl
IHdpbGxpbmdseSByZWplY3QgdGhlIGFzc29jaWF0aW9uDQo+PiBiZWNhdXNlIGFsbCB0aGUgYml0
cyBhcmUgbm90IHRoZXJlIHlldC4NCj4NCj5iZXR0ZXIgY2FsbCBvdXQgaXQgd291bGQgYmUgcmVs
YXhlZCBpbiB0aGUgZW5kIG9mIHRoaXMgc2VyaWVzLiBPdGhlcndpc2UNCj5pdCdzIGEgbGl0dGxl
IGNvbmZ1c2VkLiA6KQ0KDQpUaGlzIGNvbW1lbnQgaXMgcGVyIEVyaWMncyBzdWdnZXN0aW9uLCBJ
J2xsIGNvbWJpbmUgeW91cnMgd2l0aCBoaXMsIGxpa2U6DQoNCiJFdmVuIG9mIHRoZSBjaGVja3Mg
cGFzcywgZm9yIG5vdyB3ZSB3aWxsaW5nbHkgcmVqZWN0IHRoZSBhc3NvY2lhdGlvbg0KYmVjYXVz
ZSBhbGwgdGhlIGJpdHMgYXJlIG5vdCB0aGVyZSB5ZXQsIGl0IHdpbGwgYmUgcmVsYXhlZCBpbiB0
aGUgZW5kIG9mIHRoaXMgc2VyaWVzLiINCg0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAgMSArDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAg
ICB8IDMwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPj4gaW5kZXggYzcwNDZlYjRlMi4uZjc1MTA4NjFkMSAxMDA2NDQNCj4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtMTkyLDYgKzE5Miw3IEBADQo+PiAgICNkZWZpbmUg
VlREX0VDQVBfUFQgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYpDQo+PiAgICNkZWZpbmUgVlRE
X0VDQVBfU0MgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQo+PiAgICNkZWZpbmUgVlREX0VD
QVBfTUhNViAgICAgICAgICAgICAgICgxNVVMTCA8PCAyMCkNCj4+ICsjZGVmaW5lIFZURF9FQ0FQ
X05FU1QgICAgICAgICAgICAgICAoMVVMTCA8PCAyNikNCj4+ICAgI2RlZmluZSBWVERfRUNBUF9T
UlMgICAgICAgICAgICAgICAgKDFVTEwgPDwgMzEpDQo+PiAgICNkZWZpbmUgVlREX0VDQVBfUFNT
ICAgICAgICAgICAgICAgICg3VUxMIDw8IDM1KSAvKiBsaW1pdDoNCj5NZW1UeEF0dHJzOjpwaWQg
Ki8NCj4+ICAgI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDAp
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiBpbmRleCA1MTJjYTRmZGM1Li5kYTM1NWJkYTc5IDEwMDY0NA0KPj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
IEBAIC00MCw2ICs0MCw3IEBADQo+PiAgICNpbmNsdWRlICJrdm0va3ZtX2kzODYuaCINCj4+ICAg
I2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+PiAgICNpbmNsdWRlICJ0cmFjZS5oIg0K
Pj4gKyNpbmNsdWRlICJzeXN0ZW0vaW9tbXVmZC5oIg0KPj4NCj4+ICAgLyogY29udGV4dCBlbnRy
eSBvcGVyYXRpb25zICovDQo+PiAgICNkZWZpbmUgVlREX0NFX0dFVF9SSUQyUEFTSUQoY2UpIFwN
Cj4+IEBAIC00MzY2LDcgKzQzNjcsMzQgQEAgc3RhdGljIGJvb2wgdnRkX2NoZWNrX2hpb2QoSW50
ZWxJT01NVVN0YXRlICpzLA0KPkhvc3RJT01NVURldmljZSAqaGlvZCwNCj4+ICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4+ICAgICAgIH0NCj4+DQo+PiAtICAgIGVycm9yX3NldGcoZXJycCwgImhv
c3QgZGV2aWNlIGlzIHVuY29tcGF0aWJsZSB3aXRoIHN0YWdlLTENCj50cmFuc2xhdGlvbiIpOw0K
Pj4gKyNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4gKyAgICBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNl
Q2FwcyAqY2FwcyA9ICZoaW9kLT5jYXBzOw0KPj4gKyAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192
dGQgKnZ0ZCA9ICZjYXBzLT52ZW5kb3JfY2Fwcy52dGQ7DQo+PiArDQo+PiArICAgIC8qIFJlbWFp
bmluZyBjaGVja3MgYXJlIGFsbCBzdGFnZS0xIHRyYW5zbGF0aW9uIHNwZWNpZmljICovDQo+PiAr
ICAgIGlmICghb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoaGlvZCksDQo+VFlQRV9IT1NUX0lP
TU1VX0RFVklDRV9JT01NVUZEKSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVl
ZCBJT01NVUZEIGJhY2tlbmQgd2hlbiB4LWZsdHM9b24iKTsNCj4+ICsgICAgICAgIHJldHVybiBm
YWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAoY2Fwcy0+dHlwZSAhPSBJT01NVV9I
V19JTkZPX1RZUEVfSU5URUxfVlREKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJJ
bmNvbXBhdGlibGUgaG9zdCBwbGF0Zm9ybSBJT01NVSB0eXBlICVkIiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgY2Fwcy0+dHlwZSk7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAg
IH0NCj4+ICsNCj4+ICsgICAgaWYgKCEodnRkLT5lY2FwX3JlZyAmIFZURF9FQ0FQX05FU1QpKSB7
DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJIb3N0IElPTU1VIGRvZXNuJ3Qgc3VwcG9y
dCBuZXN0ZWQNCj50cmFuc2xhdGlvbiIpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4g
KyAgICB9DQo+DQo+dGhpcyBjaGVjayBtYXkgYmUgYWxyZWFkeSBiZWVuIGNvdmVyZWQgYnkgdGhl
IHN5bmMgaW4gcGF0Y2ggMDUgYXMNCj50aGUgc2V0X2lvbW11X2RldmljZSBvcCBpcyBjYWxsZWQg
YWZ0ZXIgYXR0YWNoX2RldmljZS4gSWYgbm8gTkVTVEVEIGNhcCwNCj5hbGxvY2F0aW5nIG5lc3Rl
ZCBod3B0IHdvdWxkIGJlIGZhaWxlZC4NCg0KSW5kZWVkLCB3aWxsIGRyb3AgdGhlIGNoZWNrLg0K
DQo+DQo+PiArDQo+PiArICAgIGlmIChzLT5mczFncCAmJiAhKHZ0ZC0+Y2FwX3JlZyAmIFZURF9D
QVBfRlMxR1ApKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTdGFnZS0xIDFHQiBo
dWdlIHBhZ2UgaXMgdW5zdXBwb3J0ZWQgYnkgaG9zdA0KPklPTU1VIik7DQo+DQo+cy9odWdlIHBh
Z2UvbGFyZ2UgcGFnZS8gYXMgVlQtZCBzcGVjIHVzZSBsYXJnZSBwYWdlLg0KDQpXaWxsIGRvLg0K
DQo+DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsjZW5kaWYgPiAr
DQo+PiArICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgSU9NTVUgaXMgaW5jb21wYXRpYmxlIHdp
dGggc3RhZ2UtMQ0KPnRyYW5zbGF0aW9uIik7DQo+DQo+cy9zdGFnZS0xIHRyYW5zbGF0aW9uL2d1
ZXN0IHN0YWdlLTEgdHJhbnNsYXRpb24vDQoNCldpbGwgZG8NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg0KPg0KPj4gICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICB9DQo+Pg0KPg0KPndpdGggYWJvdmUg
bWlub3Igbml0cyBkb25lLCB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4gSGVuY2UsDQo+DQo+
UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0K

