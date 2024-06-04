Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898CAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEN1R-00011S-BW; Tue, 04 Jun 2024 01:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEN0S-0007Ui-TZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:46:53 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEN0Q-0000eg-7D
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717480006; x=1749016006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=npHYBmZtu7jvfeByNClrSKMteI9OXw0PDc7LJyjYJG8=;
 b=P+9+j5kcja0t/UwJnvpA47NoWK5K0oF2zCqWhoP6zeDHglppn/F03NTe
 uC2pnBH/VzYqYcvy1/XWaV0wmkpUUtsgOkIQJJ88d9eoFcUBs0w0oLXk2
 Y3b9eUVZuWlbzxv+8OF7zinE068SUOnNLRq8CoYzG2UlBY0NhIw0OAnU+
 oO7RB1w+1rNSVoKr9ORIDcMORZDbIzHFtFmTZsFWoVOfwg4G4Udt+HNFI
 Vw4drns7OPHWIrRZJuqJErB73nBh9xjfrpz8xjxRYdZZ/QsPyFFCPEJyO
 AsPoA/1g29XT+dNGKZ4+/OEPkCMu4+YrHZI7OecWVx/GFR8lYg7lQfsCP Q==;
X-CSE-ConnectionGUID: znt32PxwQL+oLF3dv8w0TQ==
X-CSE-MsgGUID: y6sT//gtR3qngfXWGPyBtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13877971"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13877971"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 22:46:43 -0700
X-CSE-ConnectionGUID: u8owA+05R2Go8eqB42mP4g==
X-CSE-MsgGUID: 81Bf7NlMS2297H8sr2g5lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37230880"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 22:46:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 22:46:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 22:46:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLbMlBU7F+o2EDlNufoW7pFGHRgjVXmPyVITkP0qsSmXkyhtSGQIilYMejmXhz4vxgKULefGO/n/qouYNIesbT5QCHXK0buK7X/qBvQLNqyCXjicXOAEzeLrD1VLZzc0PDI4oLyVFz2nFK/73/gboK9BGtkdCam671NDABRY+21yt7IW9k+31qX4gzmp5xJYDC1rQGIOqYLUm0IjMuVaVdXsDxU6W+BiBDIchhu1rkbWwTo1Kwjqy1uIzR2oJGLXNmfX6Bu45NZ1EQ38UOT3hKyXDj/br5P11/k5/pns9QUIyBjFA8ffkCr63d51K9HlXR0M+IXCwriG2o++bRf7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npHYBmZtu7jvfeByNClrSKMteI9OXw0PDc7LJyjYJG8=;
 b=VeofU5wkoMkE5LM4P5lgaVBVLZsRSfAfWiWXk6RlOuQRkGUpOd08yodLI2rQd6MrcOFMSutSM4rq+Jz1TkQhkLrcwwZ4n6wfK4046DwN1UBqtZhSqxrInYACDZS6P9l8ncWYfMnW4pzOKrkMGNzCFZ7lq4zBuQ8W6r0GK3hjhNjQFDgjgX3oQRGF3oTSM4I0UFiz1tvf4OZ/1MTUcJvBsmh4eU80qOEvpSvPxhsenfQkD+jnuRxidHJ1I2DNY+CTrHIB1UPZPQqFFJJKxjAZSqv1I5i2QupY6wrJjbwiGKfgJB3cZoIqGvTYP1RD4fODdnlwaY8f/jTKvsBUY9airQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 05:46:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 05:46:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G2HucAgAD5pQA=
Date: Tue, 4 Jun 2024 05:46:34 +0000
Message-ID: <SJ0PR11MB67441662E0FD34AE114217AF92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <fcec6a43-3ac1-46fd-aca2-96097b85175a@redhat.com>
In-Reply-To: <fcec6a43-3ac1-46fd-aca2-96097b85175a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5257:EE_
x-ms-office365-filtering-correlation-id: 4af065df-8659-4279-8507-08dc8459b1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?RVFIcTJWb2YyUmpqaGxDQmpHVG8yTUJ1OG8xZWRNYW5MSjRQeTdkYmRmYTls?=
 =?utf-8?B?enhORVhQUHphcWlWY0RUZWtKcG9rVmNEUzhmQVVRQXo4b0FwOCsyanRyQ25p?=
 =?utf-8?B?Zm5YOUk5bEVYa0hFNmdvLzg0ak5hQjhrNmdFTHVkTjA2VzR4UjlDY3QrT25m?=
 =?utf-8?B?T0NaV0NUVVMyKzZxbkJHZ0hlMmZQWkZyWTUxRHo2YTJsM1VOa1pHOWtpdEpt?=
 =?utf-8?B?SVdzV083cncxR00yNUpFaUhLcnR2V3Y5c1pOMGlsZkVJbHZpWmdCNGpLa0Jr?=
 =?utf-8?B?bDdVZWg0YlJFZC9iQkJkdGszMTQ4TkM5QzdrVEhaMjYzQ2JhVkZPZVlydTBB?=
 =?utf-8?B?OTZuYVBjc0RuS0xaQUNXWHhCcW5PVHpwdVlRYjhxQUoxdG13MXhUTUQ1QzhJ?=
 =?utf-8?B?dXlyaVJHTjBTSVlodlFkSmtPUk5EQk45QVpHdWFwRng5bi9pcnAwNEtsV0pH?=
 =?utf-8?B?Q2FoZ01FVGRyd3QxaitrZnRwQzdlNm11N2cxaHBEU1FJVzVFaDZhQTRQemZF?=
 =?utf-8?B?aHpIOXlrSkhFNmZoWjFjR1ZtVmI1Qk1rb0xzOGxrWEFxWGoveGFVRnJML1Zw?=
 =?utf-8?B?Z2dVMnZMM0xQSTlUVHl4S1JQWTlmT0ZlZ0RaVjQ5WEtSOFAxcmZ6WFk3UFNK?=
 =?utf-8?B?U20yN1VNL1NVVTNvQkRpSzhtOURVNC9sWDR3akl4R0xrbE5EM3lNbERHOXh2?=
 =?utf-8?B?RUxGazZnWWo2SkdMUTBIK1BXcVBabmkxYTVNN25CRVVPem5FSkVoTVZnWFJU?=
 =?utf-8?B?UXEyeDJsTXBHY3h0WStoQlJNOGxySzZsbWZQK0VtL3d6YUZVTjNSbXUwbEZD?=
 =?utf-8?B?UUpiQUVuR09SRUNyN3dkRGpSS292b3JPUXozYVcwWVltSGU4TURjNFlFbWdW?=
 =?utf-8?B?bWFCV2NqeForT0hTcUJrb2JjUEQrazhwVU9JSVNWL0s3UjFBZXRldFhxL09s?=
 =?utf-8?B?OTlxRWpLSm14Ums1SWtFTHNnTUFSWW1yRFRKcmw4d1ltU2VHdTVlZXRPdGNI?=
 =?utf-8?B?cDIrRXRWRCsvODcvdHlkZ1VIQ1JNVW40VmlYRU9RVjdRRkZoRGVobmNNRVVO?=
 =?utf-8?B?by91ZmdHYU1BbWdwVWI0c0gxdUtHT2wyUkJsYkFPdDk2a2M5ZlhKcVVLL3JW?=
 =?utf-8?B?WjJDQk9WRGlDT09nZDJOdENvN21QWE1nSkxWRzFuQjNIaEliVWZZdFcraDlo?=
 =?utf-8?B?SVNJYmN1d29qMFdWSjZEMTZCbUxNYU0rblA5ZGVGS09lRm1RNCtoNDBSaG94?=
 =?utf-8?B?c0ZHVzZwaTF5dXV5b1RrSlAyUDlKM01EdTlwc29QTklPRG5VMERFcm1qa3Z1?=
 =?utf-8?B?cWw1M2hXaE9LcnRiVEliSnhBZHFXdFIwWDZMZ24xV3ZtRTBOay8zWkVsaFl6?=
 =?utf-8?B?ZVdHaXpPVW1Bc0s0T3BRRDNGMWNNZktvMktLM3l3M0JKc05xS1ZyQ1ZlekpY?=
 =?utf-8?B?RkUwZHN6OURwMWJMaS9NRUtmYkh6NVB2VHFvVnBrSXgrY2hHNkZjQWJZVFMw?=
 =?utf-8?B?Y3Z6bW1obm5qcCs0SGk5emsxa2xObnZsbTdRQWk3eHVtb1NrR3ZQU2JwbTJp?=
 =?utf-8?B?WnFLTzZ6TzNtS085Zi94blBFNlh0dEd5aGkwWUpmVlRsaU1CdWliU2tZcU1O?=
 =?utf-8?B?K2FHcmhvUU1xcDZ4NkFLckVmdFIwQTV3NlRTeFMxMWdRcEZmbUxQakR0bzVw?=
 =?utf-8?B?Nys0VWlqN2c0bTdFV1lBTGJjS05KbTdRWjBDZVBHTnZ4WW9GTTVtS2JxOU9B?=
 =?utf-8?B?WjRYNjE1Qkh1LzJnMnh5RUsvekZYQ2I5WVMzMlR6aGU0ZG0zcWJ3TTltZXVS?=
 =?utf-8?B?bUVtOXhQVGUvbkdzZjhldz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJJMkpLTDBYWC80bDM4L0drc29DaG8ySEttbHdyUENMZENoMm80YlBScmFh?=
 =?utf-8?B?cGdndUp4VnZrTEpnN0tXa3R4V3hWY3l1WnJwZFkzSlVEREN4dlV3SEQ1WVIr?=
 =?utf-8?B?YnlUYndIclJERWZzTjk0c2pGZGdLUldvc3BxNXY2aU5UcHZwcE5tVGdVM3BU?=
 =?utf-8?B?SlM5V1YwOXlkSUg4NWtxRVBCa0lpNlBNSEtjbDJyd1FWNFZZWE1iNnhnUmtI?=
 =?utf-8?B?bXJQQlA3QW1FVHNrS1BvVXViaG9IRThMYVZXQmxpVWVqTXhtUVphNHFGbzVX?=
 =?utf-8?B?T2VtaUJjdDRLOHVCMDIvQ2RjRDZIUTlFTFBXL3Z1VE4wVUNZRlV4L2Z6U2lq?=
 =?utf-8?B?MVFkWWo4K2p2THFJblI1djlFdThUcUo3ZnBFUSt0VlpxMThPZlFFNkExNXly?=
 =?utf-8?B?UUp5a0F2VXdPTVp0V0Q4TGhUcXdhQmlqMklOSWhFS3Q4RFNUbDdETURaTDhV?=
 =?utf-8?B?Q0lURXJsbytZVjJNdndTS0V2aWZueXVMbW5PMHJQV3pWcE1Ncmd4Y0hGNmg5?=
 =?utf-8?B?dk0veXpySVRyTHBqYXYxZlJNQkdnQWJrUWsrWU9aUFVDLzNSSHpCd0pQQjJI?=
 =?utf-8?B?Q3poMHJPNnZxK3JIS0wrMGZSdG5STldLSXdxWmJMb1dtSElGTDlOK0drV25u?=
 =?utf-8?B?NENaU3hIWTRCM2hJWHdvWGhEd3V6RDhOOXJBZWgzKy9WbGV3VWtwSWc3RjBs?=
 =?utf-8?B?YWVadk1YbDBxWjJTd3B1V25FKzMwbHFJNjhvQmJwRjQ2YVJaeWFqSEdTMGZz?=
 =?utf-8?B?bFNlM1p6WjRLTW5wVjNsVmYwcTJlR0RGdzBsOVFHdGNXdEw2eWZEdmpuSk0x?=
 =?utf-8?B?MHdIOWlQYVhWSlEwbUcySG00V043ZWhwZjBsQmVPM3RwM3hUYmt1VXg2WWxH?=
 =?utf-8?B?L284bTRsMUwvQXF2ckNIUDlhZStEZHRNNGxhMHJ4SW9TYXRrdU5KZWlLYlNY?=
 =?utf-8?B?WlVvUFpZdWRWS3E5RVhvMWI3MEdkQWM4NHJidzd5OUpCUUZuYWs1NDN1eEgw?=
 =?utf-8?B?TUNZdlZiTmRPZ29EU1NlbTlvSG1iT1VYOVpzOWQvWEt1NEZBdytOZHdhc1Zy?=
 =?utf-8?B?UzlqRlRMZWtmbDFsTHAybUFzUmJYUGlYL1NqczZuaVAxa0MxMjV3bTY0MDhs?=
 =?utf-8?B?QVFXd3dMc3FJdldZSVExT2hvbS9DQStSU2JqMkxxcFdXbnY2UXlaWng5VjRP?=
 =?utf-8?B?Qy9ldnZ4T0hzOVRrdDVXTUI1dDlrOXFTMFQwSWVUSVdmaVNhTEJhRG1oNUdP?=
 =?utf-8?B?M09NTHZUelZyTHN3V01yQnBRcExRcGdwcm1ZUFJUazJXT09paEI0S3Z3TTNP?=
 =?utf-8?B?RURBVk9yeEpsZ0VwOFpGT2hEdk9JU0ZKenQ3cEQwejh1Z2p4Y2I0RTdoUkxj?=
 =?utf-8?B?S0NMMnV4eG54SVllQ1laa0JNaXhDZ0VIaS9mSjBNWVJ6MVFWd1pHdk4rT1k2?=
 =?utf-8?B?dUpYdGh2bUxOQTlaQnltWHROY0QrUDNxczZOODNZeThvUmxLUFJwYjlHYTNF?=
 =?utf-8?B?SXdtTmxJQzRkVFprdFcydG1RQTdxSHlXTk5Pa01oV21WYUg4SG1ONmUrdE9Q?=
 =?utf-8?B?NGxMaUkyMTBxMkozbmlrRkpBNnVZWXY3aExndUtJcUh0RHBYMVltWWVUNklp?=
 =?utf-8?B?NUd1RmhES2xRamUrTGN0TTJsOWtYVzhLeXpsZithencreGNkRXcwRHoxdENV?=
 =?utf-8?B?OExBR0hzbnRoMVVabXlEL1NKdnZNWGsrblc4ekJLWkNEcHF6YXk2RDh4Qzdz?=
 =?utf-8?B?bmZsZTlvbEpzL0lFbmUyb2xkakprWE9ST3FodFdzdmRnWEI3dWhobU55dEdl?=
 =?utf-8?B?VEZxQkJnanVKc2FCTHB5N1JFQ0xuUDByNG9tY3BBSStwbDFXVDVkOUx2dmhS?=
 =?utf-8?B?WUVYQWFwQlZBWjZnMm1qcnZGSGl6aHNEYnd3Z0JqU0dGVEh0QkszVU1zZFcw?=
 =?utf-8?B?aWRQQVp5Q1BjNUJMTHBnMjZNdm1zTDNqMEZDY09HYUlBOEJuQWFXbnBZbGhY?=
 =?utf-8?B?N3NuMC9ORTByMkZMVFBUZnMwUVlVN09jWllPektaaWlkY2xEVnRmdEl1Y29F?=
 =?utf-8?B?TzBQTHJXZWNxc000cy9xakxRM09UZDljeGJmdkpaOWhaTXpFSVAvb1VidmFE?=
 =?utf-8?Q?1x+n/Aj3QGEziowSJvFB0tqxe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af065df-8659-4279-8507-08dc8459b1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 05:46:34.8893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REPo0IRNNRxS2GxwLUvhCKpqkP11YFSsLvp1Lvxvhz7o2iPTMIuw8sWV0JCSxgbVuHb5rG92KD9gwzDDAhuIS7jfgxDd0ipjE7tLVPEyh9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDE4LzE5XSBpbnRlbF9p
b21tdTogSW1wbGVtZW50DQo+W3NldHx1bnNldF1faW9tbXVfZGV2aWNlKCkgY2FsbGJhY2tzDQo+
DQo+DQo+DQo+T24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZyb206
IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IEltcGxlbWVudCBbc2V0fHVuc2V0
XV9pb21tdV9kZXZpY2UoKSBjYWxsYmFja3MgaW4gSW50ZWwgdklPTU1VLg0KPj4gSW4gc2V0IGNh
bGwsIGEgbmV3IHN0cnVjdHVyZSBWVERIb3N0SU9NTVVEZXZpY2Ugd2hpY2ggaG9sZHMNCj4+IGEg
cmVmZXJlbmNlIHRvIEhvc3RJT01NVURldmljZSBpcyBzdG9yZWQgaW4gaGFzaCB0YWJsZQ0KPj4g
aW5kZXhlZCBieSBQQ0kgQkRGLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5p
bnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
IHwgIDkgKysrKw0KPj4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8ICAyICsNCj4+
ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3Ng0KPisrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGY4Y2Y5OWJkZGYuLmI4MDBk
NjJjYTAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTI4LDYgKzI4LDcg
QEANCj4+ICAjaWZuZGVmIEhXX0kzODZfSU5URUxfSU9NTVVfSU5URVJOQUxfSA0KPj4gICNkZWZp
bmUgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5BTF9IDQo+PiAgI2luY2x1ZGUgImh3L2kzODYv
aW50ZWxfaW9tbXUuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgi
DQo+Pg0KPj4gIC8qDQo+PiAgICogSW50ZWwgSU9NTVUgcmVnaXN0ZXIgc3BlY2lmaWNhdGlvbg0K
Pj4gQEAgLTUzNyw0ICs1MzgsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUm9vdEVudHJ5IFZURFJv
b3RFbnRyeTsNCj4+ICAjZGVmaW5lIFZURF9TTF9JR05fQ09NICAgICAgICAgICAgICAweGJmZjAw
MDAwMDAwMDAwMDBVTEwNCj4+ICAjZGVmaW5lIFZURF9TTF9UTSAgICAgICAgICAgICAgICAgICAo
MVVMTCA8PCA2MikNCj4+DQo+PiArDQo+PiArdHlwZWRlZiBzdHJ1Y3QgVlRESG9zdElPTU1VRGV2
aWNlIHsNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICppb21tdV9zdGF0ZTsNCj4+ICsgICAgUENJ
QnVzICpidXM7DQo+PiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+PiArICAgIEhvc3RJT01NVURldmlj
ZSAqZGV2Ow0KPj4gKyAgICBRTElTVF9FTlRSWShWVERIb3N0SU9NTVVEZXZpY2UpIG5leHQ7DQo+
PiArfSBWVERIb3N0SU9NTVVEZXZpY2U7DQo+PiAgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+PiBpbmRleCA3ZDY5NGIwODEzLi4yYmJkZTQxZTQ1IDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+PiBAQCAtMjkzLDYgKzI5Myw4IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUg
ew0KPj4gICAgICAvKiBsaXN0IG9mIHJlZ2lzdGVyZWQgbm90aWZpZXJzICovDQo+PiAgICAgIFFM
SVNUX0hFQUQoLCBWVERBZGRyZXNzU3BhY2UpIHZ0ZF9hc193aXRoX25vdGlmaWVyczsNCj4+DQo+
PiArICAgIEdIYXNoVGFibGUgKnZ0ZF9ob3N0X2lvbW11X2RldjsgICAgICAgICAgICAgLyogVlRE
SG9zdElPTU1VRGV2aWNlDQo+Ki8NCj4+ICsNCj4+ICAgICAgLyogaW50ZXJydXB0IHJlbWFwcGlu
ZyAqLw0KPj4gICAgICBib29sIGludHJfZW5hYmxlZDsgICAgICAgICAgICAgIC8qIFdoZXRoZXIg
Z3Vlc3QgZW5hYmxlZCBJUiAqLw0KPj4gICAgICBkbWFfYWRkcl90IGludHJfcm9vdDsgICAgICAg
ICAgIC8qIEludGVycnVwdCByZW1hcHBpbmcgdGFibGUgcG9pbnRlciAqLw0KPj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5k
ZXggNTE5MDYzYzhmOC4uNzQ3Yzk4OGJjNCAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMjM3LDYgKzIz
NywxMyBAQCBzdGF0aWMgZ2Jvb2xlYW4gdnRkX2FzX2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsDQo+
Z2NvbnN0cG9pbnRlciB2MikNCj4+ICAgICAgICAgICAgIChrZXkxLT5wYXNpZCA9PSBrZXkyLT5w
YXNpZCk7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgZ2Jvb2xlYW4gdnRkX2FzX2lkZXZfZXF1YWwo
Z2NvbnN0cG9pbnRlciB2MSwgZ2NvbnN0cG9pbnRlciB2MikNCj4+ICt7DQo+PiArICAgIGNvbnN0
IHN0cnVjdCB2dGRfYXNfa2V5ICprZXkxID0gdjE7DQo+PiArICAgIGNvbnN0IHN0cnVjdCB2dGRf
YXNfa2V5ICprZXkyID0gdjI7DQo+PiArDQo+PiArICAgIHJldHVybiAoa2V5MS0+YnVzID09IGtl
eTItPmJ1cykgJiYgKGtleTEtPmRldmZuID09IGtleTItPmRldmZuKTsNCj4+ICt9DQo+PiAgLyoN
Cj4+ICAgKiBOb3RlIHRoYXQgd2UgdXNlIHBvaW50ZXIgdG8gUENJQnVzIGFzIHRoZSBrZXksIHNv
IGhhc2hpbmcvc2hpZnRpbmcNCj4+ICAgKiBiYXNlZCBvbiB0aGUgcG9pbnRlciB2YWx1ZSBpcyBp
bnRlbmRlZC4gTm90ZSB0aGF0IHdlIGRlYWwgd2l0aA0KPj4gQEAgLTM4MTIsNiArMzgxOSw3MCBA
QCBWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywg
UENJQnVzICpidXMsDQo+PiAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4gIH0NCj4+DQo+PiAr
c3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludA0KPmRldmZuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAg
IEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNl
ICp2dGRfaGRldjsNCj4+ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4gKyAgICAg
ICAgLmJ1cyA9IGJ1cywNCj4+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAgICB9Ow0K
Pj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tleSAqbmV3X2tleTsNCj4+ICsNCj4+ICsgICAgYXNzZXJ0
KGhpb2QpOw0KPj4gKw0KPj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsNCj4+ICsgICAg
dnRkX2hkZXYgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtl
eSk7DQo+PiArDQo+PiArICAgIGlmICh2dGRfaGRldikgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0
ZyhlcnJwLCAiSU9NTVVGRCBkZXZpY2UgYWxyZWFkeSBleGlzdCIpOw0KPj4gKyAgICAgICAgdnRk
X2lvbW11X3VubG9jayhzKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0K
Pj4gKw0KPj4gKyAgICB2dGRfaGRldiA9IGdfbWFsbG9jMChzaXplb2YoVlRESG9zdElPTU1VRGV2
aWNlKSk7DQo+PiArICAgIHZ0ZF9oZGV2LT5idXMgPSBidXM7DQo+PiArICAgIHZ0ZF9oZGV2LT5k
ZXZmbiA9ICh1aW50OF90KWRldmZuOw0KPj4gKyAgICB2dGRfaGRldi0+aW9tbXVfc3RhdGUgPSBz
Ow0KPj4gKyAgICB2dGRfaGRldi0+ZGV2ID0gaGlvZDsNCj5JIGFtIHN0aWxsIG5vdCB0b3RhbGx5
IGNsZWFyIGFib3V0IHdoeSB3ZSBjb3VsZG4ndCByZXVzZSBWVERBZGRyZXNzU3BhY2UNCj5pbnN0
YW5jZSBmb3IgdGhpcyBidXMvZGV2aWQuIElzIGl0IGEgbWF0dGVyIG9mIGFsaWFzZWQgdmVyc3Vz
IG5vbg0KPmFsaWFzZWQgYnVzL2RldmZuLCBvciBhIG1hdHRlciBvZiBwYXNpZCBkaWZmLiBBbiBB
ZGRyZXNzU3BhY2UgY291bGQgYmFjaw0KPmFuIGFzc2lnbmVkIGRldmljZSBpbiB3aGljaCBjYXNl
IGEgSG9zdElPTU1VRGV2aWNlIGNvdWxkIGJlIGFkZGVkIHRvDQo+dGhpcyBsYXR0ZXIuIEkgdGhp
bmsgdGhpcyBzaG91bGQgYmUgZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbXNnDQoNClllcywgYXMg
eW91IHNhaWQsIGl0J3MgYSBtYXR0ZXIgb2YgYWxpYXNlZCB2cyBub24gYWxpYXNlZCBCREYuDQoN
ClZUREFkZHJlc3NTcGFjZSBpcyBwZXIgYWxpYXNlZCBCREYgd2hpbGUgVlRESG9zdElPTU1VRGV2
aWNlIGlzIHBlciBub24gYWxpYXNlZCBCREYuDQpUaGVyZSBjYW4gYmUgbXVsdGlwbGUgYXNzaWdu
ZWQgZGV2aWNlcyB1bmRlciBzYW1lIHZpcnR1YWwgaW9tbXUgZ3JvdXAgYW5kIHNoYXJlIHNhbWUg
DQpWVERBZGRyZXNzU3BhY2UsIGJ1dCB0aGV5IGhhdmUgdGhlaXIgb3duIFZUREhvc3RJT01NVURl
dmljZS4NCg0KV2lsbCByZWZpbmUgY29tbWl0IG1zZy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K
Pg0KPkVyaWMNCj4+ICsNCj4+ICsgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tl
eSkpOw0KPj4gKyAgICBuZXdfa2V5LT5idXMgPSBidXM7DQo+PiArICAgIG5ld19rZXktPmRldmZu
ID0gZGV2Zm47DQo+PiArDQo+PiArICAgIG9iamVjdF9yZWYoaGlvZCk7DQo+PiArICAgIGdfaGFz
aF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCBuZXdfa2V5LCB2dGRfaGRldik7
DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArDQo+PiArICAgIHJldHVy
biB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfZGV2X3Vuc2V0X2lvbW11
X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj5kZXZmbikNCj4+ICt7DQo+
PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1V
RGV2aWNlICp2dGRfaGRldjsNCj4+ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4g
KyAgICAgICAgLmJ1cyA9IGJ1cywNCj4+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAg
ICB9Ow0KPj4gKw0KPj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsNCj4+ICsgICAgdnRk
X2hkZXYgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSk7
DQo+PiArICAgIGlmICghdnRkX2hkZXYpIHsNCj4+ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2so
cyk7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZ19oYXNo
X3RhYmxlX3JlbW92ZShzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkpOw0KPj4gKyAgICBvYmpl
Y3RfdW5yZWYodnRkX2hkZXYtPmRldik7DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV91bmxvY2so
cyk7DQo+PiArfQ0KPj4gKw0KPj4gIC8qIFVubWFwIHRoZSB3aG9sZSByYW5nZSBpbiB0aGUgbm90
aWZpZXIncyBzY29wZS4gKi8NCj4+ICBzdGF0aWMgdm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1h
cChWVERBZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1VTm90aWZpZXIgKm4pDQo+PiAgew0KPj4gQEAg
LTQxMTYsNiArNDE4Nyw4IEBAIHN0YXRpYyBBZGRyZXNzU3BhY2UNCj4qdnRkX2hvc3RfZG1hX2lv
bW11KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbikNCj4+DQo+PiAgc3RhdGlj
IFBDSUlPTU1VT3BzIHZ0ZF9pb21tdV9vcHMgPSB7DQo+PiAgICAgIC5nZXRfYWRkcmVzc19zcGFj
ZSA9IHZ0ZF9ob3N0X2RtYV9pb21tdSwNCj4+ICsgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRf
ZGV2X3NldF9pb21tdV9kZXZpY2UsDQo+PiArICAgIC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRf
ZGV2X3Vuc2V0X2lvbW11X2RldmljZSwNCj4+ICB9Ow0KPj4NCj4+ICBzdGF0aWMgYm9vbCB2dGRf
ZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4+IEBAIC00
MjM1LDYgKzQzMDgsOSBAQCBzdGF0aWMgdm9pZCB2dGRfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2
LCBFcnJvcg0KPioqZXJycCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4gICAgICBzLT52dGRfYWRkcmVzc19zcGFjZXMgPSBnX2hh
c2hfdGFibGVfbmV3X2Z1bGwodnRkX2FzX2hhc2gsDQo+dnRkX2FzX2VxdWFsLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4gKyAg
ICBzLT52dGRfaG9zdF9pb21tdV9kZXYgPSBnX2hhc2hfdGFibGVfbmV3X2Z1bGwodnRkX2FzX2hh
c2gsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2dGRfYXNfaWRldl9lcXVhbCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdfZnJlZSwgZ19mcmVlKTsNCj4+ICAgICAgdnRkX2luaXQocyk7
DQo+PiAgICAgIHBjaV9zZXR1cF9pb21tdShidXMsICZ2dGRfaW9tbXVfb3BzLCBkZXYpOw0KPj4g
ICAgICAvKiBQc2V1ZG8gYWRkcmVzcyBzcGFjZSB1bmRlciByb290IFBDSSBidXMuICovDQoNCg==

