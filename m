Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4DC54F30
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 02:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJNd8-0007ri-Cf; Sun, 25 May 2025 22:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJNd4-0007r7-RM
 for qemu-devel@nongnu.org; Sun, 25 May 2025 22:31:55 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJNd2-0006AT-Aa
 for qemu-devel@nongnu.org; Sun, 25 May 2025 22:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748226713; x=1779762713;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Uz/RzYOoRk4Apz36Bcg4NwZPLmm4uk2PCsTnCITkmLw=;
 b=Cl3cFSxTOn0GxWHgleNXgj/Pvv/xDGk9ZXHAYagmmHH7eM4fM1fKkDJM
 521+8anbABHJKvkFnqTPEIWYuVsNnLSH/iDX+bbVmYTKIsuoCBfZxaHhc
 U0oWwjfruV6rzGWsoxLcw5NgrouQShhuYvFqNCuG2PtgljuRM5RXWCQhl
 /2T/nG19Afzxn0ByLHj7+6357y8YeFESzSY9CqU5wdq+8wioogiPSmMb4
 xrjU2aZT9WiEacWOCVBjjw4LYAQahABdbmuS438NaGrpwTgszSGePFFRN
 mBwIPWhCANYGoR6wbhP+XHGgQAdEtsDwEvSmweF5FUXm7P2a48KVYz2TB Q==;
X-CSE-ConnectionGUID: BEYXn9C7RTuweCyIUvrdag==
X-CSE-MsgGUID: zg5AbZ2xROaWCyd9ChY+5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50352481"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="50352481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 19:31:48 -0700
X-CSE-ConnectionGUID: +wogM3GiQ96ZbWXZCGJtLA==
X-CSE-MsgGUID: hhmDYgiTTAibnOmSYuuHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="147373139"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 19:31:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 19:31:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 19:31:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.45)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 19:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP6RVBV/igjx/sfLSNj5lQgg2lYEHi1ugS6DPS+roIL6bVzr8dWydQqqubhAQp4HVlmEahpvLgBNTifnxhEWRxyqGAu9Wq6xOortelH7Thfp2l649HJV/P9JTQOGWoNajmX19Vl6EbHDJ+B4o3STJDtS78KD8go3T9uiMHC/qe+GTQrAqN7Z3MVCsroFVcjM9Fbd8cBPLCDSlcc1fmuEdXKaE0Fjmg3IkurYVBo7WYmJUtsF4kcb9LDg0iWtE8kf1dE98mMCKDcCiiFlVdd3hbqCyekyIr8haJUieIqzBgmzJ6JPNxpf1yh/OsgOHOKcMto6z/Wf0KAt9GtlY56GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz/RzYOoRk4Apz36Bcg4NwZPLmm4uk2PCsTnCITkmLw=;
 b=rwUAsQV+6DwumSHa0FrsIvPeA33M9D8NbF+OCkYBPfzRK8gup12RFwCqSjrlrief6m+/fNyYRxPC6JcTSc2YOAGAE37cZJXcqQoVTSV/Cw8UHVbQ8iiP/0Z78et9LDh8y9D+Qa8LJNovnkJdxTj7uJ0FaGqqQujfPpOHXJh/ToUqC0GYKZtM0E1FJT8HRYdWANKOxY0nVGGPxqacbM5nC7hTPsllTfhSQLlSW3GvdZk2DDEAvrkHsCwW6z3bgeVSedWy5sMmks9Onk+YIS7OptbLKpF5ZL93pPuw1svXxTCedupcOrO/h42Wd+3wKx4CoYxPN+Y1VVPiXRc24q46bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 26 May
 2025 02:31:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 02:31:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flwgAUvL4CAAdBwAIAAb8tQgAC02wCAAOjXUIABMliAgADDF3CAAGaDAIAASWmAgAObTBA=
Date: Mon, 26 May 2025 02:31:42 +0000
Message-ID: <SJ0PR11MB6744A8D64A7392EA16C51D1E9265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
 <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <4ef5640b-17af-4692-91ce-529735a21474@oracle.com>
 <e94d85b9-00a0-455c-8645-c439d90c5a55@oracle.com>
In-Reply-To: <e94d85b9-00a0-455c-8645-c439d90c5a55@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7097:EE_
x-ms-office365-filtering-correlation-id: ff9f2726-efe3-466a-c243-08dd9bfd73ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RG5EdGRkTlpTMW03dm1BZTF3bkxERmEzdDZwd3BROE51a1RJVlBtKzdrdVlT?=
 =?utf-8?B?dUYrNmZtVXYwZnlTMXZyVk41c2NQMEZMc0pDTGtEd3pnL2wrdklOU2lCQXpQ?=
 =?utf-8?B?cDcxL3JNU2hQSXREcTcvY0ZxcjhRRkxTc2MwejMrdWlZUkQ5bms0dWJ0aE5z?=
 =?utf-8?B?bGUvUEkxM2YybGdBR3c3L0dKTEs3Wm01d3JtOGRaQTlJUS9FNU9qNjMrUEY4?=
 =?utf-8?B?aG52alZVa2U0NXZUU0wzemZ5RlhGSzRvN29aQkVOOHBKdlFRYlVkbmorZ0di?=
 =?utf-8?B?MGVFUkcyOHIxY3ZwOHN1M0tMekQyL2Q2bFhwejJBNFJ2MXd1cVRhZm1vdVdo?=
 =?utf-8?B?YU9wY1h3VUVscXlCNVBKRkVhQWFvQjVzMzNKaHR0TXZjTlZGV2l0ODl0S0Nl?=
 =?utf-8?B?K0Flb3NFdU1zSmFMTWlzSWZlZWhFcnhtQjE5M2pYWitmUndPQ09Edi9sa0Rn?=
 =?utf-8?B?QUQ2UjhoU2lsYlhXdlpsbzNKeUxVZk9TZ3VVdEpkbnJaSkJhMERnVmp0eVgz?=
 =?utf-8?B?REVkVUVpMHl4dUxBL2ljcXJjN2xNbUxIVG84WjlNV3pOUWdkdHZHSjBYQnl2?=
 =?utf-8?B?YUljNER0R0pOcHlLWUYreGI0RjF2b2p5OXM3Nmw4d1BXRWhkM1ZhcGtRWDlI?=
 =?utf-8?B?Z0c0d2ZkK3RtZUw5Z2lUUjkycG03YjZxZUNKeHBTNjhtcVZpc2ozamVPV3RH?=
 =?utf-8?B?b2lFSlo1UmNRTFdza3lYSVJTL3ZlZ2V6S3JxN1U2N0YxUnY4cTdvSExQZ2ll?=
 =?utf-8?B?VmVMbmZYdDMvNzdJRkNSbWVpTlNtdjM2M0NneFFPWVFOV1c3enNPbE1JY29m?=
 =?utf-8?B?Q2Jsa2w0aDlWZjVIem1MaFJUR1g4OTdSRDBseTFZZEhwTXF3L3VHa3dpSnpi?=
 =?utf-8?B?bWphZkFJNURIbVJoWkdMVU1mZHB1U3pEc2Z6U1g0QkJNMFl6eVdJZXlDeUhT?=
 =?utf-8?B?eE5BY09od3NZbUp6QjdiRlIxY0N4b2FWeTNQVlZtY2I3bmF2SHIwOTBmbFo5?=
 =?utf-8?B?L2EvUytSS29BZlAycjlvdmpmVUVPRlc1UWJvMHN6dXJ0MDBHY0FFMmJXUEtU?=
 =?utf-8?B?WXlNSVBoV0dJSFlpV1ZTYkdxSWhRb01pRnlCVU5wdmNzZVFDTXZlK1phYVRT?=
 =?utf-8?B?YWZ5ZlphQzRYTmNpM3paL2NpUG1iejlkclVuRzZpbGYyMDJBQnpRcm9leHVl?=
 =?utf-8?B?SEZ3L0duclR5VnFtdTludHlvRUJnRFJ6enVCdm1nQXZvY2JCSHdMQ2x5SzZi?=
 =?utf-8?B?akd6NytJTER6UU90VkkvUW9FTFhYOHdIbk9lcDhqeHBvdmNqTzYyaWpPc1ln?=
 =?utf-8?B?M0lsTTdEQUhmZk4wa1d2eXNGVVk3dXg3VUlETmVkQVdPb094S0JKK014Vk4r?=
 =?utf-8?B?STh0aXpnVXNPdEFhRTZxNFI3bGJhdEsvTi9PY3hmdnNTNThocDZSWXFWc2xy?=
 =?utf-8?B?aTJldDFDNnlPRTdtZ1BTejROcFJyWXBLb3phdG93bTMzWWgrU3l3bE9ZeW5r?=
 =?utf-8?B?a3diSkJQVWdmbkg2NFVpeWlsVU5oaWNaVW8zOVNKT2tFV1B4QkhsTmxsc2VN?=
 =?utf-8?B?OEpXam5LM3hOVjc2Tmx3R3ZNWDFDdy9MeFNDazdlZ3p4NGNhTTFOM1hveGdN?=
 =?utf-8?B?VE9IYXdPT1ljWjR2dnFUeVlNbE5GYVlzYm9zMU9wM2hmUmw4R1NXNzVMbXVG?=
 =?utf-8?B?OGl1Q3FvOCtBeWluSlo5UkhGYzliWjdrMTVucmhDaHZpa01oY0pJN1NBMGFE?=
 =?utf-8?B?b1NKMWRDV1FrTGZkdmJ3R25lbUQ1YUp1TEEzS3dPQyszZjQrTk4xN1JkYTdX?=
 =?utf-8?B?MVdtcm1MaEhNNHlUN3lrMUd3bVZaS3V3WFFYNUl3bmd5cFVqdm5FZ2JNbUpL?=
 =?utf-8?B?czQvSU9ZelNFL1crcE1kOVRPaEE5c2VHTjJleUJHS0wrS05HY0l4bGM2b2t5?=
 =?utf-8?B?LzNya2dEbW93Tnc3YmU5QTVVRDNHL3E0a0RhVnZvZ3BQN1RoZm4vMUdGK3Jj?=
 =?utf-8?Q?R/fmkEMcJQqRlq4UTg3+DA1APxSwqw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHF5TFBSOEVXYXZvRVo4ekNWbEg5V3cyRnI2ZFB6RitRdGpzTXZnc0MvaENz?=
 =?utf-8?B?ZnF0eFdxaWFVN2hYSWhWQjY1aGNGam5xb1BJR2ZBUld5d0VJR0tSa2d0VlpZ?=
 =?utf-8?B?MW9lcWhmMFp6SWxycEd3bDgvelNac3FlUDdkYjhnMFFqN3FKQ1ZaZWFpUmRm?=
 =?utf-8?B?U0J4eDd1TnFJYUdsUlVFL01WcmlhamtmUXg3eno4L2ZPS0FIQVBYYUZnbEZK?=
 =?utf-8?B?Qkl1Zm4wQTU0YzBVd2hNajF2QUJuU2prZ3FqUWxlTEhrUE1RRzdoK3ZGTi9s?=
 =?utf-8?B?cFp2ZTJMRnJndGZyQUlTR25CaGMyUkhrMmtINkN6aFRtUVNNbHRnZ0FWRmZL?=
 =?utf-8?B?M1h3SGJmYlFBaFpSb01iZk5rRHV6Wjl3Rnl4S29IRXNJNzhpQVkzYkFZNUh2?=
 =?utf-8?B?cFVWNjA1UERqYzBSSHhFcDdXd2V4aHRFakd5UEtaSWtVaWgrdXRVNTBRZS9T?=
 =?utf-8?B?ZUhrY1o1T2RMcGd1ZTF1elgvcnZvWDlkanA5eVRTcmlHUnBNb0R2T2taSGZT?=
 =?utf-8?B?L29ramdXdzJWRjF4YlRtVnZDZkt2VFZaU2hMVGZORTNMWlljWWhzNXdUN3FD?=
 =?utf-8?B?bHBXQWVrTWhXUFRKbGF2ZnA3ck1La0c1TTF6UkxHZzQxTTUzMlRTZktQZzYw?=
 =?utf-8?B?Q0hqckxxT04yeGl4S1pHK2l6aU1ad3dDVjMxTkV6alZDMjdOYzRHbWt2NzFp?=
 =?utf-8?B?aUNDM2pJTDRvOTBxV2o0WUVHaUthVHBVWDUxcURVMWovcXYweElxeDBybys0?=
 =?utf-8?B?c2VRcU5QZmhmSEpHYW1kYlAyS3hST2RZeFYxaTQ4ZTFxZ3g3bjhhbGp1YTU2?=
 =?utf-8?B?RFpYeVJoQlN4ajBoQm4vZWFXdmQzdHhvNit6OFBCTlphNFh3dDYwVURWL3N0?=
 =?utf-8?B?bnVQT1ZZMFhIS0h2K3d0Rnk4V05TMFhURFhDU0NmbnJBOERyYkZzRWd5Qy90?=
 =?utf-8?B?U243emJKdEErb1AySFZxK2lwcmd2Q2V5KzJxWGJFUUhJZEpZbWo3RG43anl0?=
 =?utf-8?B?ZzBCR3RrZEllT0NUM3lnbjNuVWE1WDBEQndNV2hOZGpmcmUzU24xRkhvSExY?=
 =?utf-8?B?UXF2Z1Q0OXN1MFE0bEpVT3B6U0phdmxJOXYxRDFUKzZpOUJOcmZPMmZEd0xL?=
 =?utf-8?B?VE5YSG9laG9CcU1McEgxZmhJa1ZQb0RaUzdWbHRKbE9PRjlrVHNtUEgyZmQ2?=
 =?utf-8?B?RTVVd2dvMGxBVEUyaWF2TUp4VUF3aEFmV1hBcDhmTnh3eXc2UklEcFhkWU5q?=
 =?utf-8?B?bmlxamh0amk3N1FPb2pxdFV0ZkMzRU4wT3J2Wm0xb0tQWlhySnIySmhtUDMz?=
 =?utf-8?B?aWNTVDd1dmJ5dzlmeXZIRXNMSU1tNFU4MUFBU0Myamo3Ynhwa2dSK3YvU3ZG?=
 =?utf-8?B?MjYyblRYYklyQVRsbHZvVGIzT3BaUGorRGh2S1VIMlR3bXl0TmFNK2VxSERs?=
 =?utf-8?B?VVAzSGY0eHN1UDRSVUgwUHA1SlJBbkJUNG9xN0ppT1RlbWFKSUdkc1hHZXFG?=
 =?utf-8?B?cGtseGRXSllIYzVOTDk2ZHlLdWk4SjlWaGhYNmZMUUxmM2J2LzNTZ21Ma0s0?=
 =?utf-8?B?dVVmSzhaVXJ0OTNrZ2F6SThNWmxDbUcrRWhhc0RhYit1QWpFaFVHUjYwMWE4?=
 =?utf-8?B?ZDJNY2xIbEExem11cjFrY0hhRGFnVjE2L254OE5HU2Jad3ErQVlNeW1ESEdZ?=
 =?utf-8?B?RW5mdWl1WElLNHdsdlY3WGVKdWZPNC9ZeG1YMHBKcmVZai96WTRNY2dYdkFi?=
 =?utf-8?B?ekVSbHF5VGZGT1FkZEVod3NEQzd1ait1d2JFY2x3aXhyTlAxQStpbTFTKytv?=
 =?utf-8?B?Q21zWEpidi9OOWpXN0VGY09MR0luZ1dqNWFQVG5TbnN5c0Rxd25McmxZQnMy?=
 =?utf-8?B?b3ExMVBjYjdVWm1JSVZQZ05YdmExWHJNNDQ0VVYzN25oeXcwQ0N3aUFhaSs5?=
 =?utf-8?B?N0o3b1VBRlBGNlk1Sm5DM29RRzdJbFU0UUlETFFBWGZNTjMzWUNTd0JGSlhQ?=
 =?utf-8?B?WlVSQlNjR21kN2NsU0ZxUUdoN1gvcmx5ZDZmUFVsUDdURW5MeUtKMXBrT2NT?=
 =?utf-8?B?RDVNT2RRbmdhVHhueTFLWU9ZOW9zblo2enlqMWFPSXJmYm1WU3krdEZEaW1q?=
 =?utf-8?Q?J+bJeLGB+O7hvEeT1d3twcZZf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9f2726-efe3-466a-c243-08dd9bfd73ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 02:31:42.7810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZFULLvhRqXUHt71rneBnoBD5sFNoitVsmMdtgFjucV3ZmFM2q2b6RmSe+rISppcvPz9xQa3COxSlx2LO1/FOGbZb/huJ2j/HurNFJPVfWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJd
IGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+DQo+T24gNS8yMy8yMDI1
IDEwOjU2IEFNLCBTdGV2ZW4gU2lzdGFyZSB3cm90ZToNCj4+IE9uIDUvMjMvMjAyNSA0OjU2IEFN
LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4+IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0K
Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDI5LzQyXSBiYWNrZW5kcy9pb21tdWZkOiBjaGFu
Z2UgcHJvY2VzcyBpb2N0bA0KPj4+Pg0KPj4+PiBPbiA1LzIxLzIwMjUgMTE6MTkgUE0sIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+
Pj4+IEZyb206IFN0ZXZlbiBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPj4+
Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJdIGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5n
ZSBwcm9jZXNzIGlvY3RsDQo+Pj4+Pj4NCj4+Pj4+PiBPbiA1LzIwLzIwMjUgMTE6MTEgUE0sIER1
YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4+Pj4+PiBGcm9tOiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNv
bT4NCj4+Pj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMjkvNDJdIGJhY2tlbmRzL2lvbW11
ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gT24gNS8xOS8yMDI1
IDExOjUxIEFNLCBTdGV2ZW4gU2lzdGFyZSB3cm90ZToNCj4+Pj4+Pj4+PiBPbiA1LzE2LzIwMjUg
NDo0MiBBTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+Pj4+Pj4+Pj4+IEZyb206IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5z
aXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4+Pj4+Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggVjMgMjkvNDJd
IGJhY2tlbmRzL2lvbW11ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+Pj4+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4+Pj4gRGVmaW5lIHRoZSBjaGFuZ2UgcHJvY2VzcyBpb2N0bA0KPj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9y
YWNsZS5jb20+DQo+Pj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+Pj4+IGJhY2tlbmRzL2lvbW11ZmQu
Y8KgwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+Pj4+PiBiYWNr
ZW5kcy90cmFjZS1ldmVudHPCoMKgwqAgfMKgIDEgKw0KPj4+Pj4+Pj4+Pj4gaW5jbHVkZS9zeXN0
ZW0vaW9tbXVmZC5oIHzCoCAyICsrDQo+Pj4+Pj4+Pj4+PiAzIGZpbGVzIGNoYW5nZWQsIDIzIGlu
c2VydGlvbnMoKykNCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvYmFja2Vu
ZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+Pj4+Pj4+PiBpbmRleCA1YzE5
NThmLi42ZmVkMWMxIDEwMDY0NA0KPj4+Pj4+Pj4+Pj4gLS0tIGEvYmFja2VuZHMvaW9tbXVmZC5j
DQo+Pj4+Pj4+Pj4+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+Pj4+Pj4+Pj4+IEBAIC03
Myw2ICs3MywyNiBAQCBzdGF0aWMgdm9pZA0KPj4+Pj4+IGlvbW11ZmRfYmFja2VuZF9jbGFzc19p
bml0KE9iamVjdENsYXNzDQo+Pj4+Pj4+PiAqb2MsDQo+Pj4+Pj4+Pj4+PiBjb25zdCB2b2lkICpk
YXRhKQ0KPj4+Pj4+Pj4+Pj4gwqDCoCDCoMKgwqDCoCBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRk
X3N0cihvYywgImZkIiwgTlVMTCwNCj4+Pj4+PiBpb21tdWZkX2JhY2tlbmRfc2V0X2ZkKTsNCj4+
Pj4+Pj4+Pj4+IH0NCj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiArYm9vbCBpb21tdWZkX2NoYW5n
ZV9wcm9jZXNzX2NhcGFibGUoSU9NTVVGREJhY2tlbmQgKmJlKQ0KPj4+Pj4+Pj4+Pj4gK3sNCj4+
Pj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlvbW11X2lvYXNfY2hhbmdlX3Byb2Nlc3MgYXJncyA9
IHsuc2l6ZSA9IHNpemVvZihhcmdzKX07DQo+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+PiArwqDC
oMKgIHJldHVybiAhaW9jdGwoYmUtPmZkLCBJT01NVV9JT0FTX0NIQU5HRV9QUk9DRVNTLCAmYXJn
cyk7DQo+Pj4+Pj4+Pj4+PiArfQ0KPj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4gK2Jvb2wgaW9t
bXVmZF9jaGFuZ2VfcHJvY2VzcyhJT01NVUZEQmFja2VuZCAqYmUsIEVycm9yDQo+KiplcnJwKQ0K
Pj4+Pj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlvbW11X2lvYXNfY2hh
bmdlX3Byb2Nlc3MgYXJncyA9IHsuc2l6ZSA9IHNpemVvZihhcmdzKX07DQo+Pj4+Pj4+Pj4+PiAr
wqDCoMKgIGJvb2wgcmV0ID0gIWlvY3RsKGJlLT5mZCwgSU9NTVVfSU9BU19DSEFOR0VfUFJPQ0VT
UywNCj4mYXJncyk7DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IFRoaXMgaXMgc2FtZSBpb2N0bCBh
cyBhYm92ZSBjaGVjaywgY291bGQgaXQgYmUgY2FsbGVkIG1vcmUgdGhhbiBvbmNlDQo+Zm9yDQo+
Pj4+Pj4gc2FtZQ0KPj4+Pj4+Pj4gcHJvY2Vzcz8NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFllcywg
YW5kIGl0IGlzIGEgbm8tb3AgaWYgdGhlIHByb2Nlc3MgaGFzIG5vdCBjaGFuZ2VkIHNpbmNlIHRo
ZSBsYXN0IHRpbWUNCj4+Pj4gRE1BDQo+Pj4+Pj4+Pj4gd2FzIG1hcHBlZC4NCj4+Pj4+Pj4+DQo+
Pj4+Pj4+PiBNb3JlIHF1ZXN0aW9ucz8NCj4+Pj4+Pj4NCj4+Pj4+Pj4gTG9va3MgYSBiaXQgcmVk
dW5kYW50IGZvciBtZSwgbWVhbndoaWxlIGlmDQo+Pj4+IGlvbW11ZmRfY2hhbmdlX3Byb2Nlc3Nf
Y2FwYWJsZSgpDQo+Pj4+Pj4gaXMgY2FsbGVkIG9uIHRhcmdldCBxZW11LCBtYXkgaXQgZG8gYm90
aCBjaGVja2luZyBhbmQgY2hhbmdlPw0KPj4+Pj4+Pg0KPj4+Pj4+PiBJIHdvdWxkIHN1Z2dlc3Qg
dG8gZGVmaW5lIG9ubHkgaW9tbXVmZF9jaGFuZ2VfcHJvY2VzcygpIGFuZCBjb21tZW50DQo+dGhh
dA0KPj4+Pj4+IGl0J3Mgbm8tb3AgaWYgcHJvY2VzcyBub3QgY2hhbmdlZC4uLg0KPj4+Pj4+DQo+
Pj4+Pj4gV2UgbmVlZCB0byBjaGVjayBpZiBJT01NVV9JT0FTX0NIQU5HRV9QUk9DRVNTIGlzIGFs
bG93ZWQgYmVmb3JlDQo+Pj4+Pj4gcGVyZm9ybWluZw0KPj4+Pj4+IGxpdmUgdXBkYXRlIHNvIHdl
IGNhbiBhZGQgYSBibG9ja2VyIGFuZCBwcmV2ZW50IGxpdmUgdXBkYXRlIGNsZWFubHk6DQo+Pj4+
Pj4NCj4+Pj4+PiB2ZmlvX2lvbW11ZmRfY3ByX3JlZ2lzdGVyX2NvbnRhaW5lcg0KPj4+Pj4+IMKg
wqDCoMKgwqAgaWYgIXZmaW9fY3ByX3N1cHBvcnRlZCgpwqDCoMKgwqDCoMKgwqAgLy8gY2FsbHMg
aW9tbXVmZF9jaGFuZ2VfcHJvY2Vzc19jYXBhYmxlDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
IG1pZ3JhdGVfYWRkX2Jsb2NrZXJfbW9kZXMoKQ0KPj4+Pj4NCj4+Pj4+IFRoaXMgcmVtaW5kcyBt
ZSBvZiBvdGhlciBxdWVzdGlvbnMsIGlzIHRoaXMgaW9jdGwoKSBzdWl0YWJsZSBmb3IgY2hlY2tp
bmcgaWYgY3ByLQ0KPj4+PiB0cmFuc2ZlciBzdXBwb3J0ZWQ/DQo+Pj4+PiBJZiB0aGVyZSBpcyB2
SU9NTVUsIHRoZXJlIGNhbiBiZSBubyBtYXBwaW5nIGFuZCBwcm9jZXNzX2NhcGFibGUoKSBjaGVj
aw0KPndpbGwNCj4+Pj4gcGFzcywNCj4+Pj4+IGJ1dCBpZiBtZW1vcnkgaXMgbm90IGZpbGUgYmFj
a2VkLi4uDQo+Pj4+PiBEb2VzIGNwci10cmFuc2ZlciBzdXBwb3J0IHZJT01NVSBvciBub3Q/DQo+
Pj4+DQo+Pj4+IEkgZG9uJ3Qga25vdywgSSBoYXZlIG5vdCB0cmllZCB5b3VyIHNhbXBsZSBhcmdz
IHlldCwgYnV0IEkgd2lsbC4NCj4+Pj4gV2l0aCB2SU9NTVUsIHdoYXQgZW50aXR5L2ludGVyZmFj
ZSBwaW5zIG1lbW9yeSBmb3IgdGhlIHZmaW8gZGV2aWNlPw0KPj4+DQo+Pj4gT2gsIEkgZG9uJ3Qg
bWVhbiB2aXJ0aW8taW9tbXUsIGl0IGNhbiBiZSBpbnRlbC1pb21tdSBvciB2aXJ0aW8taW9tbXUg
Zm9yIHRoaXMNCj5pc3N1ZS4NCj4+PiBJIG1lYW4gd2hlbiBndWVzdCBhdHRhY2ggZGV2aWNlIHRv
IGEgRE1BIGRvbWFpbiwgdGhlcmUgY2FuIGJlIG5vIG1hcHBpbmcNCj5pbiB0aGF0IGRvbWFpbiBp
bml0aWFsbHkuDQo+Pj4NCj4+Pj4NCj4+Pj4+IFFFTVUga25vd3MgZGV0YWlscyBvZiBhbGwgbWVt
b3J5IGJhY2tlbmRzLCB3aHkgbm90IGNoZWNraW5nIG1lbW9yeQ0KPj4+PiBiYWNrZW5kcyBkaXJl
Y3RseSBpbnN0ZWFkIG9mIGEgc3lzdGVtIGNhbGw/DQo+Pj4+DQo+Pj4+IElPTU1VX0lPQVNfQ0hB
TkdFX1BST0NFU1MgaXMgcmVsYXRpdmVseSBuZXcuIFRoZSBpb2N0bCB2ZXJpZmllcyB0aGF0IHRo
ZQ0KPj4+PiBrZXJuZWwNCj4+Pj4gc3VwcG9ydHMgaXQuwqAgQW5kIGlmIHN1cHBvcnRlZCwgaXQg
YWxzbyB2ZXJpZmllcyB0aGF0IGFsbCBkbWEgbWFwcGluZ3MgYXJlDQo+Pj4+IG9mIHRoZSBmaWxl
IHR5cGUuDQo+Pj4NCj4+PiBCdXQgdGhlIGRtYSBtYXBwaW5ncyBhcmUgZHluYW1pYyBpZiB0aGVy
ZSBpcyB2SU9NTVUsIHNvIGNoZWNraW5nIGRtYQ0KPm1hcHBpbmdzIGFyZSBjaGVja2luZyBub3Ro
aW5nIGlmIHRoZXJlIGlzIG5vIG1hcHBpbmcgaW4gdGhlIERNQSBkb21haW4uDQo+Pg0KPj4gWWVz
LCBzbyB0aGVyZSBhcmUgMiBjaGVja3M6DQo+PiAgwqAgKiBhdCByZWFsaXplIC0+IGNwciByZWdp
c3RlciB0aW1lLsKgIGlmIGNwciBjYW4gbmV2ZXIgd29yayBiZWNhdXNlDQo+PiAgwqDCoMKgIElP
TU1VX0lPQVNfQ0hBTkdFX1BST0NFU1MgaXMgbm90IHN1cHBvcnRlZCwgdGhlbiBhZGRzIGEgYmxv
Y2tlci4NCj4+DQo+PiAgwqAgKiBhdCBjcHIgdGltZSwgaW4gdmZpb19jb250YWluZXJfcHJlX3Nh
dmUuwqAgcmVmdXNlcyB0byBwcm9jZWVkIGlmDQo+PiAgwqDCoMKgIGlvbW11ZmRfY2hhbmdlX3By
b2Nlc3MoKSBmYWlscyBiZWNhdXNlIG5vbi1maWxlIG1hcHBpbmdzIGFyZSBwcmVzZW50Lg0KPj4g
IMKgwqDCoCBBbGxvd3MgY3ByIGlmIHRoZXJlIGFyZSBubyBtYXBwaW5ncyBwcmVzZW50Lg0KDQpM
ZXQgbWUgZXhwbGFpbiBmdXJ0aGVyLg0KDQpUaGVyZSBpcyBhIGNvcm5lciBjYXNlIHRoYXQgY291
bGQgYnlwYXNzIGFib3ZlIGNoZWNrcy4gU291cmNlIHFlbXUgc3RhcnRzIHdpdGgNCnZJT01NVSBh
bmQgbm9uLWZpbGUgbWVtb3J5IGJhY2tlbmQsIHRoZW4gaG90cGx1ZyBWRklPIGRldmljZSwgaWYg
Z3Vlc3QNCmRyaXZlciBkb2Vzbid0IHNldHVwIGFueSBtYXBwaW5nIG9yIG5vIGd1ZXN0IGRyaXZl
ciBhdHRhY2hlZCwgdGhlIG1hcHBpbmcgb24NCmhvc3Qgc2lkZSBjYW4gYmUgZW1wdHksIHRoZW4g
YWJvdmUgY2hlY2tzIHdpbGwgYm90aCBwYXNzLg0KDQpJJ20gbm90IHN1cmUgaWYgdGhhdCdzIGEg
Y2FzZSB3ZSBuZWVkIHRvIHN1cHBvcnQuIElmIG5vdCwgZmVlbCBmcmVlIHRvIGFkZCBteSBSQi4N
Cg0KPj4NCj4NCj5JZiBteSBleHBsYW5hdGlvbiBtYWtlcyBzZW5zZSwgYW55IGNoYW5jZSBvZiBn
ZXR0aW5nIGFuIFJCIGZvciB0aGlzIGFuZCB0aGUNCj5yZWxhdGVkIHBhdGNoPw0KPiAgIGJhY2tl
bmRzL2lvbW11ZmQ6IGNoYW5nZSBwcm9jZXNzIGlvY3RsDQo+ICAgdmZpby9pb21tdWZkOiBjaGFu
Z2UgcHJvY2Vzcw0KPg0KPlRoZXkgYXJlIG5vdCBhZmZlY3RlZCBieSB0aGUgb3RoZXIgY2hhbmdl
cyB3ZSBoYXZlIGRpc2N1c3NlZC4NCj4NCj4tIFN0ZXZlDQo+DQo+Pj4+Pj4gSG93IGFib3V0IEkg
anVzdCBhZGQgYSBjb21tZW50Og0KPj4+Pj4+DQo+Pj4+Pj4gYm9vbCBpb21tdWZkX2NoYW5nZV9w
cm9jZXNzX2NhcGFibGUoSU9NTVVGREJhY2tlbmQgKmJlKQ0KPj4+Pj4+IHsNCj4+Pj4+PiDCoMKg
wqDCoMKgIC8qDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgICogQ2FsbCBJT01NVV9JT0FTX0NIQU5HRV9Q
Uk9DRVNTIHRvIHZlcmlmeSBpdCBpcyBhIHJlY29nbml6ZWQNCj5pb2N0bC4NCj4+Pj4+PiDCoMKg
wqDCoMKgwqAgKiBUaGlzIGlzIGEgbm8tb3AgaWYgdGhlIHByb2Nlc3MgaGFzIG5vdCBjaGFuZ2Vk
IHNpbmNlIERNQSB3YXMNCj5tYXBwZWQuDQo+Pj4+Pj4gwqDCoMKgwqDCoMKgICovDQo+Pj4+Pj4N
Cj4+Pj4+PiAtIFN0ZXZlDQo+Pj4+Pg0KPj4+DQo+Pg0KDQo=

