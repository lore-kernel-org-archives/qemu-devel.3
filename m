Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741AEC02182
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 02:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb9gQ-00055H-MG; Thu, 23 Jan 2025 21:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tb9gP-000550-65
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 21:44:33 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tb9gK-0005YF-Uh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 21:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737686669; x=1769222669;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U6ZTxRuKmwV2M119nadNq1Bmx/ogFIGkA9+sm67qAzw=;
 b=HIbVmjSe9qVrtTQMzd5qNmB5CepCkapb+hMPi1lqzjNbFdKN/LLm4jt+
 n2X5Q54XhviOpeE1A7MTBkhdaHHpI1uJR3mrLE++SrSwjMwLsT8mpmTwD
 neTRCA4WdKtACTiyimaSufKY+qW1NcbxF/Jmqsh1nAylKwfSuSa+PcXsa
 6+M1qebgJYx3zpmJ+a89twKsJ+cA0J30Z6qSjAUzjNphKExkZCXyX/BJj
 Szn3zNOQJoYona0vsfcJRgvPyy2ud3RcCGVrtLg2AlbEJITt7FapB42lZ
 /Z3e8V/9qFn0wIxQI5CuYiQpYagOS4tENxf3R28W7RqWaiv00R55U6YGJ A==;
X-CSE-ConnectionGUID: qrwA052jTIKD/AFbZX4k1g==
X-CSE-MsgGUID: nP2VCCMhTdOC2pMtQyEt5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38128076"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="38128076"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 18:44:25 -0800
X-CSE-ConnectionGUID: O4AwimfSRuux5CDhx+0IiA==
X-CSE-MsgGUID: uXc7qeF+TlC6To6KTYRa6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="108076773"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2025 18:44:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 18:44:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 18:44:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 18:44:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5RAPV7+31S7PmE6ZEZ/exnj+yHftrX/uKyNNP/qB/cUSlfmcNsUjRz9tkEGodWrSN5XW72qOFaunTdpV5VhL34GOepxhC8XiGQvjm47GVf2wcf6eOWvBIRJ4FzvhIS0A7lHRN8zvb4SU/2V3LzpRUo6hHDg3EMGAXOnVHxFOzUNbypxkow6YQ1t16/qI1Nl4rwtXkCRS8TEx7O2BussM3iSDMi2ir4NBN3lrlUqfFtU85A4P8QrI5j0HqP5dbkjVWlkCVHwWHw77pDZDz53oQkcSpkNgm7V1nBSqacRGllSRMaaKmpjIxZCrq5MFg/vmQnW8FqlM28PX2tsFqG1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6ZTxRuKmwV2M119nadNq1Bmx/ogFIGkA9+sm67qAzw=;
 b=N/Ixkk8qHTPvbd6mDYvv7hI7r2TvYMNntoxcrTGVAAyzIDrlWUUJlVaXNVg/kn57AETm+QTkDXZb2dkCGT+8T/BqYjjivH8QUh1obE2wkBXvi90jJFZjvOa/YPnOUp2X5g3oaHw+FkJXjyH0wTJg9WQhcDvfcqVQ55hd2Qe9HVUis1pTsBfryy4Bl9FaDQAO6zLGk3evEh2eUiJd5anM1IPbWpbyDTOj7/U76paG0qN1Oc6UDn/0VDGUyn0v1I44jpzJhqKhpXDc/gNyBr1ZG+VcboLm5DhQBPY5Lj8aV5PnoeXjp5wR6542zuqtbQy3iDy7DIoHPApUCJhdYlAonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 02:44:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 02:44:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Wang
 <jasowang@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMgkh0AgADZNgCAAPlEgIAACqIAgAEnzgCAAHSwAIABLIng
Date: Fri, 24 Jan 2025 02:44:20 +0000
Message-ID: <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
In-Reply-To: <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: c0bf47dc-5d83-4194-c655-08dd3c210147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ekRPNGw5STVreW9CRlRETEozM3YzUGN3NkQ1Q1BZU2kvWkhmSmw2TjNmK0w4?=
 =?utf-8?B?Nnh5cWtMYnpnUlU5MXh2RkZVVzZFa0lUemVTajBpNzZEaG8vd2E2MkRLQmFL?=
 =?utf-8?B?UUM3RjBMbzVTNWN0TkVCOFhTVnZ4VjBPTWEzU1BXL2FSdGdYVGxVT0l5MytM?=
 =?utf-8?B?UlBybjBlNVVvZTJiVGlUTTJCVHVOUk4yOGVtNXdqWkJ1c082ZXoxNVV0b25K?=
 =?utf-8?B?dlkvdVVRdisvUDM1VWpnYVhNVkhqQUxvL25FNk81dWVydURsaFd2QThyVEcy?=
 =?utf-8?B?Q1ZIdi9yUE5QdTlGZHArMkhqZ0VwM1hvcTh6VWpZc0ZqZFpYVWtxcGNvVEhQ?=
 =?utf-8?B?Mk5YNnZRS2F2VkZPRi9BVUlVTjJ3c2FYTUNybVErdkRnMW8vZWNPbDJncHgy?=
 =?utf-8?B?bjNGMGljMjJOZU9ZQTBhRXpqWFJNblc1dDU5dzJwdk1NT1J1TEZpQ0xzZWRR?=
 =?utf-8?B?YXk4M01RSFlUaGkvbDRqSUR4R3ltdXRqMmRMajFzSnBKUDdIclVTbGU0V0Zn?=
 =?utf-8?B?SndOUkg3WkxoNG9weXk5cVhjcllUM0JVOFpibFBia3FGaEtJdk93N3UwYTZk?=
 =?utf-8?B?OUpIaXQxdmltcjljM3B3dnV5RG1ReVc3Y3A1RlE0VXF4OTRkZy82Ui90Wi9v?=
 =?utf-8?B?b1JES1RBZnFyR2swWklta09Kb1A2Z2pkVnQ0SlFiVFBjWjVuMUhOOWZ2RU9w?=
 =?utf-8?B?N0Fvd0VnYTVhM1gyVkRORU9OakNhbWozYmxDdnZKUVZrTXhoZDRiV2V6Q1NJ?=
 =?utf-8?B?NnBwcVREc2dtdE5lallxTmZOaGpOdlRqNTl6QXpqV3JEMVBtNk1nKy9nZGNt?=
 =?utf-8?B?anZzS2hhQmpYekJoUFMzeUZQd0FtYkZqR2poTkt3T0FOUXNLNEtXWlVQRlRr?=
 =?utf-8?B?dW5vQ3pjRHhKMEFaSEVSdUFBN29KMXY2QXlQd1AraTFQczU4b2I4OHU5ZUo3?=
 =?utf-8?B?SjkzOTVObW9tdHlPdXh4ZDhsSXp2Ym5ySFhDOFE0Q3h1WGRiaVZPNkZFYktk?=
 =?utf-8?B?bTMvM1NrVy9IZWZQa0NnT1VvNjZQZTRBNE5MMjNab25waENVbE95MXM1QnRt?=
 =?utf-8?B?RGhqNU8zeHF6UFJRZi9TcEJaWmp3Q2Q0NmxHSU4yT1MrR0lncTl3Q3hkczAv?=
 =?utf-8?B?dFhWVkY0QWZvS2xtTkp6eVhNOWpyaDdQQU5EZkJlZHZnaUtnZVphVDdXU2Vz?=
 =?utf-8?B?VldCczFZT2dXS3BGdm9GbzJrUUxzanFpMzU3OXZxS2toS1BYWGVuamhsM2hh?=
 =?utf-8?B?d2c4NkV6SWhQblN3MXJCNVRxZEF5RHByRHZHSjFWZUpWbmptV0gxelJGbUt1?=
 =?utf-8?B?UVAxNllKTm14T1J5S3F2Z3ovM0U2V0l1RGlKYWVUMFRaS1NrVTFrMG5qS2hx?=
 =?utf-8?B?OUJyUDFIVHF6MFMxTjA1NnhoWTI3emxzV0laSXdnMUZGbm5qWGNzYWxvYzhV?=
 =?utf-8?B?Wm1zTHhDSmFKMnVqbEtyTVA3dmQ1TTliTlZmZkErZXhpWmY4OHRzOThxRmUy?=
 =?utf-8?B?ZWpIamhzMVJwOHM0SFF0M0JDUG9ndkNWTGl0ZXU2TGFqUzU3ZDZaN3hNQkZV?=
 =?utf-8?B?ZG4wdWJ1WFZlUlpucDZyZ0JjRmx1YnkrT1ptU1pSMjVHcENVQkFBR3hMTjFI?=
 =?utf-8?B?MnhjQXhJV0VtVXhWYWlMVlNjSFEyUFk0dlVwUUhZY0xHZjQzM3BpZnB2cytq?=
 =?utf-8?B?WEZXc2tpOGNyRDFCQytYd2Eya1ZsMlYraGJqR3NpejFvbVZBR25QRlo2bXdK?=
 =?utf-8?B?bmZFWk9WZVNFellOMlMzL0NTcEZ6YnZQSXNIWkNaK0VYWWFCWElKU0lGSlBh?=
 =?utf-8?B?bXJIUVZBaXYzUUVSMjh1Y2FGY2t4TEVMR21Cd3Y3NjFqdVZQVXZkM3FqVVM1?=
 =?utf-8?B?NG9TT0ZTOFFPVTJBZXdIRmNJRGhlVTVsT3lLeUFITWRFanc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGUvM0xaWWZ6Ym5FcWw2OEtrci9SV2NZQ1VwSElhNlc5ejFDNzBLVEVGUnY1?=
 =?utf-8?B?akFJQW5TdnhkZHF6cW5LZE1JNmpsemxTVDdwQkRjU0lNcmtRbDhiVDdlZ1R5?=
 =?utf-8?B?aUdsamV1YXJVVi9aSFlqSDlkekEvbFZJbzNCOW8zYS9zK1gzMUErNWdWd2sw?=
 =?utf-8?B?TVlrdUFaSmQyd0VUMnQzdExFMXdhZ3pqRDBaN1MyejFSbjdTcVlhMjVFbHlT?=
 =?utf-8?B?UElMVFZMYnljeFd0akNubko2L0w2Y05Icm9yK0lQMDNPRC9sQU1QQzFNQXNq?=
 =?utf-8?B?Y0s1eTlXYXpMeFM1OVU5dGhpa093MTVsUjFoL01lbStkcERKRUJJR2NWNExC?=
 =?utf-8?B?RlpRYUZDaHdzMXh5YWtROFk0eTFpUW5rTDVwT1V1eEhma1l0a2pUQW1URDFG?=
 =?utf-8?B?dzRpNktIczVJWFA4N2Qxd1krNE5vblJ1Q01ZclFkNStJWml2MjdhK0ltVnd6?=
 =?utf-8?B?bXljblg5NjdqNW5sWFlvQXV3bXFWQzFHZFk1RXJQZGZnMDVzU2d0YUNVTWdm?=
 =?utf-8?B?M1pGVUNQYkJ5MWVDU0lsRjNUbjRELzVtc21NSld4VXpQUWpCK2ZhTVJQTVFv?=
 =?utf-8?B?dU9WYTZyaldXVkRmL0dIMm5ZbHhWOUhkUmJzRE5ocG9mSW9jL0xTZnoyV3lB?=
 =?utf-8?B?bEdacXNmL3ZrU09ybjFhK0RNVGtyaFVSNC9rVEFuTGZOd1p0bkJMU21EbEdC?=
 =?utf-8?B?dEptbnFNL3h4UmJneFdNWlFTRCs2ay9ScmQ3YzBCMjYxUktBc2Rha0FFNVBO?=
 =?utf-8?B?aTVYKzdnOGJrZy9ZTGZSQXJ5VVRXQ091YlVBRDFDck5seENqVlFsN2JMeG1p?=
 =?utf-8?B?dFpLY3pkZW5mMGR3SVZlZVhWQ0c5UXlMRGJxWlBlQ0RYcVhETXF0S2hEL2ov?=
 =?utf-8?B?UzB6RlpWb2VFZG5xWUNJamhDeGtaTjdFMGh5anZMaDBqK1NJS2k1b2c2clRp?=
 =?utf-8?B?Y21IYS81VTNJbmhGNit6YkN6ZjU3SXUwWHpHejl2U3lJaDhLTFRKenJYeUlH?=
 =?utf-8?B?bjZsRGl0T2hoRkRxNGtIdWdpUTNGaC95MnN2RlpXa2dTKzgwVUN4UlAvRVhX?=
 =?utf-8?B?UkQ4OHNOejZ3K2t5YXZuMGxGM3E5eFA1NmdhSXJtSUl1enVQS2NmNkpVMjd2?=
 =?utf-8?B?RTY2cEQzYmJuZ2tiUDc4SnpmV1A3MGNzd3N1S0lkc0h1WG5yR0VxQ3VvY1l1?=
 =?utf-8?B?aDdPTW04SmhVWngwK29uSnZISlhxUE16Q3l4L2ZHQmtCaFpnWFBJK0drMmdT?=
 =?utf-8?B?MFdMbjNSbDk3ckltU0RDM29qOGIzVWhqYUJaSUpwMFFPTWdZVmtWNzEyMXdZ?=
 =?utf-8?B?cHNmS3lxR25WcFlSRFpZNGF2Y2ovZ0JBWEdiZDNBaWxGQW1EdUR2U2Ixd1Vu?=
 =?utf-8?B?eUtkTnBxR0M0cDJFTitvNXhtNkhlUlhmQTZZeStqMmU3Ung2MTdtem1rVmkx?=
 =?utf-8?B?MUpuK3A1SEVjZHQ1dWU2d1BRbFdJZ01nV25vNHdqT3c5R1NteGJJb3gyQVRq?=
 =?utf-8?B?VkcwYVZJaDhtNHFUSm1KSGJoeEJoM003aEJWM3cvaUVTTklYYnNoRU03a0pi?=
 =?utf-8?B?eHZBNzJKS2RHajJrN1J5dzBwbG41QmlyOFRBdXpkdzJMd2Jxd0RuZHpac0hr?=
 =?utf-8?B?QzZJN2w0ZlNuTUFpUXVnUzNlY2pYTUFXNGYrMStkQVYwL0xyWFNoQnhmOXA5?=
 =?utf-8?B?L3d3Nm94aDJ2OUlWdmxFSkV1a3orMitKVTZ4anZOZnJmMzNMNWZmaHRodHV4?=
 =?utf-8?B?K29tVHJHczZHb2VvQVRGMitvbFB1VTN3TVd4cGpjbUlIYmsySW5EYWxGYk5y?=
 =?utf-8?B?UzFiSWtVRnlkL0p6QkVzWVorZS9DTjVTb3FHWmNPV2IxN3Z3enRsVS9yWml4?=
 =?utf-8?B?VmR6c2cvbHU1TzlPU3MrZzAra3BYSWVTL3lKNUtwckY1clJWNUlWYXozN2Vr?=
 =?utf-8?B?bWdqbXhKdE1ZSTQveFJLN0lxOU9UYjBWQUo2Q3ZOQlU4WncwU2FCVFVVZCtv?=
 =?utf-8?B?MUNwTmhja21CejIrbmU4QWRheWIxS1c4aHJiTDRCT2dwS0oyMWRaZzlYeXor?=
 =?utf-8?B?dTlndzFiNVc1amNsZHlyWkM2ZHJUbW16WWQzSnZBYWk4TG9qNmo2VENSQnFy?=
 =?utf-8?Q?1UJ2XHw4Tyz+w1uoL/32bOSq5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bf47dc-5d83-4194-c655-08dd3c210147
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 02:44:20.9160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJw5r7kJ9Tb2Qkk1BWFCAlo3YiXNJEIkgokcmc3SmoGUKQeF5YRMdpOYUn0lMgn+yCM9T9dgtI9Ysi+z5YRTt6Fhw0h6yIYX119zQgjy5Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBody92aXJ0aW8vdmhvc3Q6
IERpc2FibGUgSU9UTEIgY2FsbGJhY2tzIHdoZW4gSU9NTVUgZ2V0cw0KPmRpc2FibGVkDQo+DQo+
SGkgSmFzb24sDQo+DQo+DQo+T24gMS8yMy8yNSAyOjM0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOg0K
Pj4gT24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgMzo1NeKAr1BNIEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4gSGkgSmFzb24sDQo+Pj4NCj4+Pg0KPj4+IE9uIDEv
MjIvMjUgODoxNyBBTSwgSmFzb24gV2FuZyB3cm90ZToNCj4+Pj4gT24gV2VkLCBKYW4gMjIsIDIw
MjUgYXQgMTI6MjXigK9BTSBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+d3Jv
dGU6DQo+Pj4+PiBIaSBKYXNvbiwNCj4+Pj4+DQo+Pj4+PiBPbiAxLzIxLzI1IDQ6MjcgQU0sIEph
c29uIFdhbmcgd3JvdGU6DQo+Pj4+Pj4gT24gVHVlLCBKYW4gMjEsIDIwMjUgYXQgMTozM+KAr0FN
IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj53cm90ZToNCj4+Pj4+Pj4gV2hl
biBhIGd1ZXN0IGV4cG9zZWQgd2l0aCBhIHZob3N0IGRldmljZSBhbmQgcHJvdGVjdGVkIGJ5IGFu
DQo+Pj4+Pj4+IGludGVsIElPTU1VIGdldHMgcmVib290ZWQsIHdlIHNvbWV0aW1lcyBvYnNlcnZl
IGEgc3B1cmlvdXMgd2FybmluZzoNCj4+Pj4+Pj4NCj4+Pj4+Pj4gRmFpbCB0byBsb29rdXAgdGhl
IHRyYW5zbGF0ZWQgYWRkcmVzcyBmZmZmZTAwMA0KPj4+Pj4+Pg0KPj4+Pj4+PiBXZSBvYnNlcnZl
IHRoYXQgdGhlIElPTU1VIGdldHMgZGlzYWJsZWQgdGhyb3VnaCBhIHdyaXRlIHRvIHRoZSBnbG9i
YWwNCj4+Pj4+Pj4gY29tbWFuZCByZWdpc3RlciAoQ01BUl9HQ01ELlRFKSBiZWZvcmUgdGhlIHZo
b3N0IGRldmljZSBnZXRzDQo+c3RvcHBlZC4NCj4+Pj4+Pj4gV2hlbiB0aGlzIHdhcm5pbmcgaGFw
cGVucyBpdCBjYW4gYmUgb2JzZXJ2ZWQgYW4gaW5mbGlnaHQgSU9UTEINCj4+Pj4+Pj4gbWlzcyBv
Y2N1cnMgYWZ0ZXIgdGhlIElPTU1VIGRpc2FibGUgYW5kIGJlZm9yZSB0aGUgdmhvc3Qgc3RvcC4g
SW4NCj4+Pj4+Pj4gdGhhdCBjYXNlIGEgZmxhdCB0cmFuc2xhdGlvbiBvY2N1cnMgYW5kIHRoZSBj
aGVjayBpbg0KPj4+Pj4+PiB2aG9zdF9tZW1vcnlfcmVnaW9uX2xvb2t1cCgpIGZhaWxzLg0KPj4+
Pj4+Pg0KPj4+Pj4+PiBMZXQncyBkaXNhYmxlIHRoZSBJT1RMQiBjYWxsYmFja3Mgd2hlbiBhbGwg
SU9NTVUgTVJzIGhhdmUgYmVlbg0KPj4+Pj4+PiB1bnJlZ2lzdGVyZWQuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+
Pj4+Pj4gLS0tDQo+Pj4+Pj4+ICBody92aXJ0aW8vdmhvc3QuYyB8IDQgKysrKw0KPj4+Pj4+PiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+Pg0KPj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvaHcvdmlydGlvL3Zob3N0LmMgYi9ody92aXJ0aW8vdmhvc3QuYw0KPj4+Pj4+PiBpbmRl
eCA2YWE3MmZkNDM0Li4xMjhjMmFiMDk0IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9ody92aXJ0aW8v
dmhvc3QuYw0KPj4+Pj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3QuYw0KPj4+Pj4+PiBAQCAtOTMx
LDYgKzkzMSwxMCBAQCBzdGF0aWMgdm9pZA0KPnZob3N0X2lvbW11X3JlZ2lvbl9kZWwoTWVtb3J5
TGlzdGVuZXIgKmxpc3RlbmVyLA0KPj4+Pj4+PiAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4+Pj4+
ICAgICAgICAgIH0NCj4+Pj4+Pj4gICAgICB9DQo+Pj4+Pj4+ICsgICAgaWYgKFFMSVNUX0VNUFRZ
KCZkZXYtPmlvbW11X2xpc3QpICYmDQo+Pj4+Pj4+ICsgICAgICAgIGRldi0+dmhvc3Rfb3BzLT52
aG9zdF9zZXRfaW90bGJfY2FsbGJhY2spIHsNCj4+Pj4+Pj4gKyAgICAgICAgZGV2LT52aG9zdF9v
cHMtPnZob3N0X3NldF9pb3RsYl9jYWxsYmFjayhkZXYsIGZhbHNlKTsNCj4+Pj4+Pj4gKyAgICB9
DQo+Pj4+Pj4gU28gdGhlIGN1cnJlbnQgY29kZSBhc3N1bWVzOg0KPj4+Pj4+DQo+Pj4+Pj4gMSkg
SU9NTVUgaXMgZW5hYmxlZCBiZWZvcmUgdmhvc3Qgc3RhcnRzDQo+Pj4+Pj4gMikgSU9NTVUgaXMg
ZGlzYWJsZWQgYWZ0ZXIgdmhvc3Qgc3RvcHMNCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgcGF0Y2ggc2Vl
bXMgdG8gZml4IDIpIGJ1dCBub3QgMSkuIERvIHdlIG5lZWQgdG8gZGVhbCB3aXRoIHRoZQ0KPj4+
Pj4+IElPTU1VIGVuYWJsZWQgYWZ0ZXIgdmhvc3Qgc3RhcnRzPw0KPj4+Pj4gc29ycnkgSSBpbml0
aWFsbHkgbWlzdW5kZXJzdG9vZCB0aGUgYWJvdmUgY29tbWVudC4gSW5kZWVkIGluIHRoZSByZWJv
b3QNCj4+Pj4+IGNhc2UgYXNzdW1wdGlvbiAyKSBoYXBwZW5zIHRvIGJlIHdyb25nLiBIb3dldmVy
IHdoYXQgSSBjdXJyZW50bHkgZG8gaXM6DQo+Pj4+PiBzdG9wIGxpc3RlbmluZyB0byBpb3RsYiBt
aXNzIHJlcXVlc3RzIGZyb20gdGhlIGtlcm5lbCBiZWNhdXNlIG15DQo+Pj4+PiB1bmRlcnN0YW5k
aW5nIGlzIHRob3NlIHJlcXVlc3RzIGFyZSBqdXN0IHNwdXJpb3VzIG9uZXMsIGdlbmVyYXRlDQo+
Pj4+PiB3YXJuaW5ncyBhbmQgd2UgZG8gbm90IGNhcmUgc2luY2Ugd2UgYXJlIHJlYm9vdGluZyB0
aGUgc3lzdGVtLg0KPj4+Pj4NCj4+Pj4+IEhvd2V2ZXIgSSBkbyBub3QgY2xhaW0gdGhpcyBjb3Vs
ZCBoYW5kbGUgdGhlIGNhc2Ugd2hlcmUgdGhlIElPTU1VIE1SDQo+Pj4+PiB3b3VsZCBiZSB0dXJu
ZWQgb2ZmIGFuZCB0aGVuIHR1cm5lZCBvbi4gSSB0aGluayBpbiB0aGF0IGNhc2Ugd2Ugc2hvdWxk
DQo+Pj4+PiBhbHNvIGZsdXNoIHRoZSBrZXJuZWwgSU9UTEIgYW5kIHRoaXMgaXMgbm90IHRha2Vu
IGNhcmUgb2YgaW4gdGhpcyBwYXRjaC4NCj4+Pj4+IElzIGl0IGEgcmVsZXZhbnQgdXNlIGNhc2U/
DQo+Pj4+IE5vdCBzdXJlLg0KPj4+Pg0KPj4+Pj4gd3J0IHJlbW92aW5nIGFzc3VtcHRpb24gMSkg
YW5kIGFsbG93IElPTU1VIGVuYWJsZWQgYWZ0ZXIgdmhvc3Qgc3RhcnQuIElzDQo+Pj4+PiB0aGF0
IGEgdmFsaWQgdXNlIGNhc2UgYXMgdGhlIHZpcnRpbyBkcml2ZXIgaXMgdXNpbmcgdGhlIGRtYSBh
cGk/DQo+Pj4+IEl0IHNob3VsZCBub3QgYmUgYnV0IHdlIGNhbid0IGFzc3VtZSB0aGUgYmVoYXZp
b3VyIG9mIHRoZSBndWVzdC4gSXQNCj4+Pj4gY291bGQgYmUgYnVnZ3kgb3IgZXZlbiBtYWxpY2lv
dXMuDQo+Pj4gYWdyZWVkDQo+Pj4+IEJ0dywgd2UgaGFkIHRoZSBmb2xsb3dpbmcgY29kZXMgd2hp
bGUgaGFuZGxpbmcgdGU6DQo+Pj4+DQo+Pj4+IC8qIEhhbmRsZSBUcmFuc2xhdGlvbiBFbmFibGUv
RGlzYWJsZSAqLw0KPj4+PiBzdGF0aWMgdm9pZCB2dGRfaGFuZGxlX2djbWRfdGUoSW50ZWxJT01N
VVN0YXRlICpzLCBib29sIGVuKQ0KPj4+PiB7DQo+Pj4+ICAgICBpZiAocy0+ZG1hcl9lbmFibGVk
ID09IGVuKSB7DQo+Pj4+ICAgICAgICAgcmV0dXJuOw0KPj4+PiAgICAgfQ0KPj4+Pg0KPj4+PiAg
ICAgdHJhY2VfdnRkX2RtYXJfZW5hYmxlKGVuKTsNCj4+Pj4NCj4+Pj4gLi4uDQo+Pj4+DQo+Pj4+
ICAgICB2dGRfcmVzZXRfY2FjaGVzKHMpOw0KPj4+PiAgICAgdnRkX2FkZHJlc3Nfc3BhY2VfcmVm
cmVzaF9hbGwocyk7DQo+Pj4+IH0NCj4+Pj4NCj4+Pj4gdnRkX2FkZHJlc3Nfc3BhY2VfcmVmcmVz
aF9hbGwoKSB3aWxsIGJhc2ljYWxseSBkaXNhYmxlIHRoZSBpb21tdQ0KPj4+PiBtZW1vcnkgcmVn
aW9uLiBJdCBsb29rcyBub3Qgc3VmZmljaWVudCB0byB0cmlnZ2VyIHRoZSByZWdpb25fZGVsDQo+
Pj4+IGNhbGxiYWNrLCBtYXliZSB3ZSBzaG91bGQgZGVsZXRlIHRoZSByZWdpb24gb3IgaW50cm9k
dWNlIGxpc3RlbmVyDQo+Pj4+IGNhbGxiYWNrPw0KPj4+IFRoaXMgaXMgZXhhY3RseSB0aGUgY29k
ZSBwYXRoIHdoaWNoIGlzIGVudGVyZWQgaW4gbXkgdXNlIGNhc2UuDQo+Pj4NCj4+PiB2dGRfYWRk
cmVzc19zcGFjZV9yZWZyZXNoX2FsbChzKSBpbmR1Y2VzIHRoZSB2aG9zdF9pb21tdV9yZWdpb25f
ZGVsLiBCdXQNCj5naXZlbiB0aGUgY3VycmVudCBpbXBsZW1lbnQgb2YgdGhpcyBsYXR0ZXIgdGhl
IElPVExCIGNhbGxiYWNrIGlzIG5vdCB1bnNldCBhbmQgdGhlDQo+a2VybmVsIElPVExCIGlzIG5v
dCByZWZyZXNoZWQuIEFsc28gYXMgSSBwb2ludGVkIG91dCB0aGUgIGhkZXYtPm1lbS0+cmVnaW9u
cyBhcmUNCj5ub3QgdXBkYXRlZD8gc2hvdWxkbid0IHRoZXkuIENhbiB5b3UgZXhwbGFpbiB3aGF0
IHRoZXkgY29ycmVzcG9uZCB0bz8NCj4+IEFkZGluZyBQZXRlciBmb3IgbW9yZSBpZGVhcy4NCj4+
DQo+PiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGZpbmQgYSB3YXkgdG8gdHJpZ2dlciB0aGUgbGlz
dGVuZXIgaGVyZSwgcHJvYmFibHk6DQo+Pg0KPj4gMSkgYWRkL2RlbGV0ZSB0aGUgbWVtb3J5IHJl
Z2lvbnMgaW5zdGVhZCBvZiBlbmFibGUvZGlzYWJsZQ0KPnNvcnJ5IEkgZG9uJ3QgdW5kZXJzdGFu
ZCB3aGF0IHlvdSBtZWFuLiBUaGUgdmhvc3RfaW9tbXVfcmVnaW9uX2RlbCBjYWxsDQo+c3RhY2sg
aXMgcHJvdmlkZWQgYmVsb3cgWzFdLiBXcml0ZSB0byB0aGUgaW50ZWwgaW9tbXUgR0NNRCBURSBi
aXQNCj5pbmR1Y2VzIGEgY2FsbCB0byB2aG9zdF9pb21tdV9yZWdpb25fZGVsLiBUaGlzIGhhcHBl
bnMgYmVmb3JlIHRoZQ0KPnZob3N0X2Rldl9zdG9wIHdob3NlIGNhbGwgc3RhY2sgaXMgcHJvdmlk
ZWQgYmVsb3cgWzJdIGFuZCBvcmlnaW5hdGVzDQo+ZnJvbSBhIGJ1cyByZXNldC4NCj4NCj5XZSBt
YXkgaGF2ZSBpbmZsaWdodCBJT1RMQiBtaXNzIHJlcXVlc3RzIGhhcHBlbmluZyBiZXR3ZWVuIGJv
dGguDQo+DQo+SWYgdGhpcyBoYXBwZW5zLCB2aG9zdF9kZXZpY2VfaW90bGJfbWlzcygpIGZhaWxz
IGJlY2F1c2UgdGhlIElPVkEgaXMgbm90DQo+dHJhbnNsYXRlZCBhbnltb3JlIGJ5IHRoZSBJT01N
VSBhbmQgdGhlIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciByZXR1cm5lZA0KPmJ5IGFkZHJlc3Nfc3Bh
Y2VfZ2V0X2lvdGxiX2VudHJ5KCkgaXMgbm90IHdpdGhpbiB0aGUgcmVnaXN0ZXJlZA0KPnZob3N0
X21lbW9yeV9yZWdpb25zIGxvb2tlZCB1cCBpbiB2aG9zdF9tZW1vcnlfcmVnaW9uX2xvb2t1cCgp
LCBoZW5jZQ0KPnRoZSAiRmFpbCB0byBsb29rdXAgdGhlIHRyYW5zbGF0ZWQgYWRkcmVzcyIgbWVz
c2FnZS4NCj4NCj5JdCBzb3VuZHMgd3JvbmcgdGhhdCB2aG9zdCBrZWVwcyBvbiB1c2luZyBJT1ZB
cyB0aGF0IGFyZSBub3QgdHJhbnNsYXRlZA0KPmFueW1vcmUuIEl0IGxvb2tzIHdlIGhhdmUgYSBy
ZXNldCBvcmRlcmluZyBpc3N1ZSBhbmQgdGhpcyBwYXRjaCBpcyBqdXN0DQo+cmVtb3ZpbmcgdGhl
IHN5bXB0b24gYW5kIG5vdCB0aGUgY2F1c2UuDQo+DQo+QXQgdGhlIG1vbWVudCBJIGRvbid0IHJl
YWxseSBnZXQgd2hhdCBpcyBpbml0aWF0aW5nIHRoZSBpbnRlbCBpb21tdSBURQ0KPmJpdCB3cml0
ZS4gVGhpcyBpcyBhIGd1ZXN0IGFjdGlvbiBidXQgaXMgaXQgaW5pdGlhdGVkIGZyb20gYSBtaXNv
cmRlcmVkDQo+cWVtdSBldmVudD8NCg0KRHVyaW5nIHJlYm9vdCwgbmF0aXZlX21hY2hpbmVfc2h1
dGRvd24oKSBjYWxscyB4ODZfcGxhdGZvcm0uaW9tbXVfc2h1dGRvd24oKQ0KdG8gZGlzYWJsZSBp
b21tdSBiZWZvcmUgcmVzZXQuIFNvIFBldGVyJ3MgcGF0Y2ggd2lsbCBub3QgYWRkcmVzcyB5b3Vy
IGlzc3VlLg0KDQpCZWZvcmUgaW9tbXUgc2h1dGRvd24sIGRldmljZV9zaHV0ZG93bigpIGlzIGNh
bGxlZCB0byBzaHV0ZG93biBhbGwgZGV2aWNlcy4NCk5vdCBjbGVhciB3aHkgdmhvc3QgaXMgc3Rp
bGwgYWN0aXZlLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+SXQgY291bGQgYWxzbyByZWxh
dGUgdG8NCj5bUEFUQ0ggMC80XSBpbnRlbF9pb21tdTogUmVzZXQgdklPTU1VIGFmdGVyIGFsbCB0
aGUgcmVzdCBvZiBkZXZpY2VzDQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLz9xPXMlM0Fp
bnRlbF9pb21tdSUzQStSZXNldCt2SU9NTVUrYWZ0ZXIrYWxsKw0KPnRoZStyZXN0K29mK2Rldmlj
ZXMNCg0K

