Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73DCC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzHn-0006yo-BR; Tue, 25 Feb 2025 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tmzHH-0006qC-AN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:03:37 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tmzHD-0001hk-VY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740506608; x=1772042608;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=QA5zgludLWdMDb1QtTM+ZLe0M4okfFmqHj0ZpSgIAaw=;
 b=jJ8WgAhJM+NZFbQZYDRMNAaZjwzYsYXcrLT9Iy9VdHCRYn6WiHHq/K+o
 4Ij/rvrZY2ucxIaTCxHVx1zZ61vSbkgxdwCXBwDH6adSE6BH/QDd7tWD6
 mj6he5fR0WrRikzfitC3O0JAzCo2z/5TVTKWjqGgFo8CSLsV5rEJLZR5j
 clGOo0Pea7F4Iu+qBOA0c/cr4qJdcF037VM8Do/v7U27Mg5VxJDeIUQSa
 U5TWe/bgIUmlutuJn669+VQDNOZjimUedJT21PDQ8So9ViwrVIpus9+5s
 9XmU5XszZ7/kAk+UDXNTeaCgsT3O0H2nbGEhJ7koUVghEXdhBVeaMQ5Ew A==;
X-CSE-ConnectionGUID: aNBpdE9VTaKcaivEmu16vg==
X-CSE-MsgGUID: a7rKLONcTnKeVkOTZxTE/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41531683"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41531683"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 10:03:22 -0800
X-CSE-ConnectionGUID: JfqZyUZJTLmOLg4bMV4hTg==
X-CSE-MsgGUID: mobA9UgLTeSUVcp4dHsrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="153637621"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 10:03:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 10:03:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 10:03:21 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 10:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssu/xwDZecGTxvwYBQjY1rKdp1Iz5ttIttHgsBBWR+Pxv9jLdjFlBc3hPH9MMF0Maq3NUoYXCUrIcUjE0QvzezFM2pqzjKvQK+lA/L/bIScM7f4/diPLeCpxGp2/dfF7L/iECdSJnjnDGQPTPngT2FQiXB6p1wxdKjif5gE+sqLTQUbP/leOtpoLjjKj1KoZu3ajgVyAiPL+j0m9vAf7+SsQ4GFxImKB+ytZzuVZTtn2CHoj/lU8zat3+uw0R2c5z/pY6aWgOjKVt7PIlgGTouSfzyP7l+hYDw8xVEPQy3Lh0wn8OOkzaRSVnp5GAHleAZArxjQo3oyW1SaZTy8nQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwBbszmp+QPtfUZNqer5LbcfDxAHoQ2uhc5Ysm4rS34=;
 b=bIsH94vsIGxfFxrbdsEtijGFZoy5DoRYDJDEP0jh70Jf8UOz93L4C67OopwEqOZV6AHGi/l1IfQElpMMwk5IzvbdezbPmwWmj/0aryITrPGJ1/jQ692du7pT+6cO3JDrKyvL9SRq2Ag1l97Bm+9VvSKtg64i7HB5vorrDPZ5YEaeu7+wIXDjqVxtqA51gkJUyzzPB0OwOzWRYkQ2qcaz9EPiXvcAGKpj4QmUXKMYuQKJZfYecEskyBrvWHJXRhrw7Sk8Rh98zCkVjqLvYkdapgGY1YwsydOYvoCRf7GD3p0Im3HKSWBMg4raQ1PtH+hLLfr22durQCPtE/NuZTQYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 18:03:18 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 18:03:18 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: hikalium <hikalium@hikalium.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Some regression due to "ui/gtk: Fix mouse/motion event scaling issue
 with GTK display backend"
Thread-Topic: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
Thread-Index: AduHr3IQUyMyDh5wS+uW6ITUR0kANA==
Date: Tue, 25 Feb 2025 18:03:18 +0000
Message-ID: <PH8PR11MB6879500CDBB703E22EC3D6F0FAC32@PH8PR11MB6879.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|MW4PR11MB5870:EE_
x-ms-office365-filtering-correlation-id: 6ceb7668-97d9-4d5e-03c6-08dd55c6aed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TOqbFECBUEiyXw+9rfOFaefWjTLaioxm+UWejPYWbBmVOitPN0wrT8h6Am?=
 =?iso-8859-1?Q?hfd10+GnyAhh2lHdlDMglf1zYX4K4LhjkVJfK1T7cd0mP/gZEDLtkBm6Ns?=
 =?iso-8859-1?Q?7ZEDd82cw3h90SAA5G3vcFqdLaZ2xnDubGVGPABJO14c/dsgE0LsBU9D0I?=
 =?iso-8859-1?Q?iDKzbrJ1YAHy0ur73A//WBSk78VhgOK93Q0RG23cLERpCsI2lFhsMF73vw?=
 =?iso-8859-1?Q?Ua2+2jYhYMgTn3PnUUzCryhjHOM9Y4vmJbJ3q1mmR5WtZd6ylCbVtlrS+z?=
 =?iso-8859-1?Q?i7u9wolEyNngTJ1mSkD9GfmRHYWR+FwmH8dhcWEygcMJRZluYuW5TOE3vo?=
 =?iso-8859-1?Q?9bx8EOCGANpaC00prziXhrpQyT4yXjgtlojp5fIAdwJIaHfFTfAdJsJqI6?=
 =?iso-8859-1?Q?HIk66KKGln59uknmBOFov9WkLKd5OJEIPpdyAKv5sGJv0Mv41+cV9PY+gt?=
 =?iso-8859-1?Q?eLJAAnro0xnOiC5Jq5yR20nPZ0lijRZpKqpdQj5ksqN3ZdP3PwPfqMlp+x?=
 =?iso-8859-1?Q?rFW1ql9bBBKJt4yFZCAklPQzXU22ACUx8j0Edvd5fS79SPKF2MYlGW1x6S?=
 =?iso-8859-1?Q?X1vl/s+7PhuhYIY+3r4993k8y2kdw6CURQLOK4e8jTN8u+jASmQ3AHkqEe?=
 =?iso-8859-1?Q?E8uo+W8Y/pjRagh5WfVfH1ZAM/MXJf2yPhwe9cDwqMpoMWmt3VeOp9ACWZ?=
 =?iso-8859-1?Q?/v2WZjyxI0bK/5zCY65VeHKZVfxN0UTcjBNfwmH0MUqWK6owUdkLYJnrel?=
 =?iso-8859-1?Q?bBDQAaKXmEwwmhqOO8JKxes54+ZQ4HZKUW3G8dmTMRDJqhLIu0RRNSlDaA?=
 =?iso-8859-1?Q?M369sVT4K6CxVbe/AYdJdVNFo2pjgso5Le2ky97aeqo5PiIgaQjcgmKs9u?=
 =?iso-8859-1?Q?3QeqphkRP6OIUfXxmVz5slTPQy9QHHM8D51EHIm8daqWL4K6O4+GIgxlzY?=
 =?iso-8859-1?Q?aGCf93oEbh6TsTzHGV+cBo3Vu1z0bUPUVDhF+LFvByMLUeJruhiY1CuApI?=
 =?iso-8859-1?Q?6pYn5Xr6MLsoGshf8Y6rzwuhLIuYANQ0hsqK6Z2vnqSbJp+7Vd6hRBEKdx?=
 =?iso-8859-1?Q?/M2kkTh60anV8wo9uN/MQxRdrFXKKBzVt5vJr8dfey/JXVYuhbORIlc7Sz?=
 =?iso-8859-1?Q?Q5Y1pYTlgu7FTHG4dOfoQ+RCsrOx0+5P3cgqT5DtSLdWN4mRd+32jYUjI5?=
 =?iso-8859-1?Q?+nu08OOwy2k31NbRYHbhsDmus2m7YWi9C3HHIaTQalJ9OtyZzpURUYeWkI?=
 =?iso-8859-1?Q?PavW3a64hv+FG6QFLyYw06+Y4d1AtGURXzs9qipXwv//cipU7YNWsqebkw?=
 =?iso-8859-1?Q?SQxA3v5hWqadXEi74gs4CR/7+bWRkwFVpU8ueDAbNlBUF7Rfok8ZQpG4pM?=
 =?iso-8859-1?Q?gSE6ov/6yhDHnuXhics8ZlCwFIahxYms9FywpKuT0HLcN7tMRdBTzMuvVD?=
 =?iso-8859-1?Q?2fgaSgDtA23C1IYS8tKuOpiHa+8K4bdn0XxWi/4o+Ewjs/PPnB77ZE3Kni?=
 =?iso-8859-1?Q?6S5ZlME6Ude2jTZ00+ZUUk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yZ+KMDJfG8n9h2SWkGgoV8z08R7R4PjNrvtS8xROtj57e2X0hzVj2b+tWx?=
 =?iso-8859-1?Q?kHjnNnLnzV7QLiVJi4OVVwc4zXnSqsnGDuTurmfqc3tnBdZid/NKxqTaF0?=
 =?iso-8859-1?Q?mVE9+nx5JsErVLYkLiPP1YCCu14kfnxRjn1TVWM7jpeVgyNdXlqkuHREtR?=
 =?iso-8859-1?Q?T2QGxxldv7JTkXseG5lQeZ20WGve0hETmVgfRY5aqkU2mEa3Uv69Rg20O0?=
 =?iso-8859-1?Q?juIYxXSwg4ysCXHs1n+iePIeTFQ1T10/Oz2MNMeHZSI7pbRJHOWqmCtGlX?=
 =?iso-8859-1?Q?08xl6lkHzYrl/AdHhozb2xqCCZSA/ZgjkjG50DnplWrcFK0o0nLQACxgkD?=
 =?iso-8859-1?Q?z6jbQLaV10E8MVexqCu8h+FYkU/sh27siNX/B+sypMzuCa8+CvAn98sih6?=
 =?iso-8859-1?Q?EEzZY8xJTIQxmr1Z9YVJhT5nYTh3dzBmVwZhzRUdu+XlZn28zNLNJqiuFh?=
 =?iso-8859-1?Q?W4qrzgD25BJYihg5pKcBpmC3sHTUzc/UknlVwntC0GeSOu4/rqcPW+9vy8?=
 =?iso-8859-1?Q?IH2Jx3p1diSj+0XVaVvAZ2tJrxdqwwUCrg66Rct3FbLnnRRGJ02cYhRGRE?=
 =?iso-8859-1?Q?yPWbbQ/SSNBeNGPOM33YGBfs4JdwMw/rtb1NTyvBSFGfFtGOTrbc3ok+H4?=
 =?iso-8859-1?Q?3SO7g2hxgKTzCW247YH4vcaFsPlAhw8WCzafDgHhq8xtOKuyYq/52lmijw?=
 =?iso-8859-1?Q?uitRcn6LFQo8Pa5vd+iGFeMdzDybmSFZDceob+WHa1MWQEuJPY0zFccPYl?=
 =?iso-8859-1?Q?w6F6g4859v6EYXYq7bL15MWqikOMBdBVXRb+rHb1n35z7eojtsH6bJNrh6?=
 =?iso-8859-1?Q?5EtmG7RFN4T/wRBi3DEp5oZeMP78wNlDolJNwVOGPR2WRbAxE1B5aeeaIY?=
 =?iso-8859-1?Q?XsB9fM6UHkEM7CszuacbRiRS3Fi9n5WXnD5d0hpl9/W5YefyjBFYJpCtm5?=
 =?iso-8859-1?Q?cRh4v1dVasV38yqiVCog9Ci2Kk92N/NN/N2pBtKz8Eydlc1mtZSPgdUVfl?=
 =?iso-8859-1?Q?i6JE6pxQPbSqok9BnS8uff4x9d+xHvERoZ6oU+PUHloCpKlTL6eW6C94cs?=
 =?iso-8859-1?Q?H9b/eWP15g7yAoqrpPNcZrJb9Jgh/XbBpIoHKWgZinSlIlaOKPSeFZTlq8?=
 =?iso-8859-1?Q?Be+PO9AlslSCxdcE2CytZoXPeSkNxmWaV+7wccH9Cf2dzLgunBIYVkMSbp?=
 =?iso-8859-1?Q?jYO2InBV++J7rArTtkoD1dXxhSsXvPk37OjL+ay6r+UGC1o0muknfEyDr9?=
 =?iso-8859-1?Q?53Cc5UVgDXWNn0Swt6Pra1VgZpvidQbmfA3NnIdd393nqRMtEIklOJ6XQe?=
 =?iso-8859-1?Q?h/gJStsVE+y/790LwltFXWuENA5lkLj8VdDcZrVDxrlrcbNAwDQqUZi3SH?=
 =?iso-8859-1?Q?jX+nnB9uE4XmapKvQ3s3Yu0fAbCuIJpE0J2Ty28MkHGFi5x9nbkfCmAGSA?=
 =?iso-8859-1?Q?PxDE3qpcAGCZ2OYIVhJNGJLp3vlEx608S4t7GXjoaVa2/pLlv1Dwx9EorW?=
 =?iso-8859-1?Q?D5kSByRiESKGa6zSJWS7S3hLQHsF2gGIyAyHkUrhYHZgi1YCgUzHYABoIG?=
 =?iso-8859-1?Q?PeYPJ+rjOrgQLaM00tzhr6FXz1DP3aUpFytst5d/C/OquA//4tFMi3x5CW?=
 =?iso-8859-1?Q?jQsLbT9rvrxv2sWITjQI4UL6T0n3Obe+Jp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ceb7668-97d9-4d5e-03c6-08dd55c6aed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 18:03:18.1630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrKpJn58+o4JOJJXnIu8qS6mwbSW5z9VeEMEuEFNUNcROpTqcT4bV1HK+xEgjsojMiRHYDh5y6YIfdXSPxvKSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Hi hikalium,

This commit actually breaks one of our use cases with Ubuntu host when the =
display scaling factor is
set to 200%. It seems like gtk_widget_get_scale_factor is only way to get t=
hat DPI scaling factor
and without this, mouse movement on the guest wouldn't be able to go across=
 certain boundary
as the coordinate will be halved (in case DPI scaling factor is 200%).

commit 37e91415018db3656b46cdea8f9e4d47b3ff130d
Author: hikalium <hikalium@hikalium.com>
Date:   Sun May 12 20:14:35 2024 +0900

    ui/gtk: Fix mouse/motion event scaling issue with GTK display backend


