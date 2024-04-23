Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C572C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzAV7-0000SV-VA; Tue, 23 Apr 2024 03:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1rzAV5-0000SD-In
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:23:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1rzAV1-0003b7-Gz
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:23:35 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5YCmU009337;
 Tue, 23 Apr 2024 00:23:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=proofpoint20171006; bh=Bf7fskAyFM0
 TkeZH3yuF1qgRfDnS4YnOzhDsGsH6714=; b=qci8WSDDWy3s9gKe2FyyIW1kTjO
 J8RyExMVELdidgyCgj0SujtaQZ2sdHeRpIxjNmeDniZW88Nj/3Dnz2aXl86dk49M
 kxNKZU8wzeB3Xsy3Zf+U9/P0HJ6RynD2xMM8JMfO/l5HGf6VkGuHH+xPv8P0QD7q
 SMQvtG/XzTQXjaOkwigCZgaTEw/Kvhk5HhihYIQvtpFR9mf2RxWJVk4LDXyf6j3w
 t1CdwfzJLW1t1+NkRNUIk5Uhrr6ZBkOXFL4yV9V7dEN7uPthzEpPW01AzafEcbPE
 gSlRsdmfHHlwYQcaZl+6vPOIkvRq4vrE7cTVOyft0PMUeu7O5aG+OrgLOPg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xmb86n4mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 00:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh+q+Iwg7IgAtpJMCdDgizh8t3My9aopV76xPk0+jTPLDZWJzrPp4hgVILwjG0Jb+JKsH45hTf8O6mBD+v6AI79vUFDlf5hW9y2YQWpLkXdiUhXtouIC9l/HnGQOIZeSP+m4in2GNtdXdM48QO9lWEEbaQCkN9lz33XE0KXDdKF39IE+Ggv/rEaW/6a4oVbnnQlCt0ry3MJOXWqLkxuLBwPsv85/V11dkMXHA8THKPTVhI+uC1bwafVcohSlahv8+Eox+XglJ2+tF4epU3U/9kZfB6rQM9wMDYi0KkBtOf0AUOhlKg0m/xN9UKfh6BV2RnwPpCS0yS9/3Hnyz3d22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf7fskAyFM0TkeZH3yuF1qgRfDnS4YnOzhDsGsH6714=;
 b=PX9xFFjTS3NfSDQz++54+etR6EnoCWDY+jGCcSNaYfzuhytzsjDLRLB5ELl7RwZPJKjS1SPb76EKs7YSK5LYwpCEKYrbemrMZvnTv4WDeMioPxnjub8pM0nekm9qhjDak4Kn1BbehjggRgz+yi9oziS7YLpndFE5TMelE/+5lMcaC7EXFOHNvlbtwMdcAjUkPrlBvalaSXP9SdtFIkSKO5UHQ/2bLgkKTcFz/k24zm6Warjk1fgHd/RMcaq9NWcUqGnT8o5/UUybQwHQU4alfCfXBgu2RmIKfPjXDNAU0CwvuE/mx0jIT7vjVQt5DXh27QBGPriRessboWr9GUB9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf7fskAyFM0TkeZH3yuF1qgRfDnS4YnOzhDsGsH6714=;
 b=IBFwABpTXAawNdADRXJrUfhJg0v1EVEbUSsTMUZFeKnq+Ist56lYoWu5Fb88eggoKfr873n21osfWwYuX3Eoo3vccxeMsR0U5a5R3VHkCsfdyHezzK76nnewScVto7Zi7WjKxqlMJT2D4bS+ShENOb2yIiEN96gsIxTSaI9GySpV/j9yTMRARSb4NXFeqMr+Ghi763sj7fEW3MGUFjDgFRk6xiyRObLs2FHSKrXMOdOY7L0jo42gx5JFhFUOjTSuL1qvAJ8OD4IjByRAg4UIW4Y4HWD18k54BsivFih09Oy1xHBMd4holFPTGOsKBRVi8E7uq/C3dXbphpXgQlZnBQ==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by BN0PR02MB7998.namprd02.prod.outlook.com (2603:10b6:408:16b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:23:21 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:23:20 +0000
From: Manish Mishra <manish.mishra@nutanix.com>
To: "Wang, Lei" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "christopher.r.blevins@intel.com" <christopher.r.blevins@intel.com>,
 "robert.hu@linux.intel.com" <robert.hu@linux.intel.com>
Subject: Re: Missing features in QEMU SapphireRapid definition
Thread-Topic: Missing features in QEMU SapphireRapid definition
Thread-Index: AQHajvt7Oszp7Zi3CUut2jW9h6hLMbF1eJ0lgAAG7ICAAABqkQ==
Date: Tue, 23 Apr 2024 07:23:20 +0000
Message-ID: <PH0PR02MB73848DD662C5FAA19BB506BFF6112@PH0PR02MB7384.namprd02.prod.outlook.com>
References: <PH0PR02MB7384F448F73756EDE574A306F6092@PH0PR02MB7384.namprd02.prod.outlook.com>
 <PH0PR02MB738400F34A65A61D2D843F44F6112@PH0PR02MB7384.namprd02.prod.outlook.com>
 <23f16462-d461-4555-9043-56147ece42b1@intel.com>
In-Reply-To: <23f16462-d461-4555-9043-56147ece42b1@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7384:EE_|BN0PR02MB7998:EE_
x-ms-office365-filtering-correlation-id: 263c6abe-9fea-4da0-d62a-08dc636640e2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?dTZiSGdDUDNLRGNWS0NBcWlCdUlGQXpQQWJlcFRKSjFFeVBuNHRHY2hBWUZk?=
 =?utf-8?B?bkQwaVJ2YndqSmQ5Q3J6Z09rbmFGTHlrYnEvakxoRWJLTGJSZ0hPYStHdEs0?=
 =?utf-8?B?cEFxWFVFZ2Q0T0hiQkY1bU5EREpjUENhUUY3SUFHNE1KcUFQRmdRcU43dGpO?=
 =?utf-8?B?Sm9lZjNIdGNHOTRiZ3plVERyWld5aUVMb0ZoV2xuKzZSTUpLSFNOUXU1RXU5?=
 =?utf-8?B?dzd4a0plMU5pemhWSHJwenEyRFE5NlFzZUNFZHorZHJLSXFsQjN0elhTSmVk?=
 =?utf-8?B?dDI1SUdtNkt0eTVIZ0prZVpicXdUUGlGVmR2KzNXZ3JsZEhGV2M0MGM4NjRU?=
 =?utf-8?B?ck0wMEVLZlRuRDh5K3VkZnRGaVJ2ZmhVZll6V2FVenp3ZCt2NDFLbWx3ZzJB?=
 =?utf-8?B?aldxbEhDS2x3U3lzSzZYZFdVNkt5ck9GMG03OFdUUXNlQ0VaSml6S3kzVnJQ?=
 =?utf-8?B?a29TeUJhazdYejdlYkFna1F5UlVDYzBMcWsxNkJYM0F5eVdhVGZUaUxWcmZm?=
 =?utf-8?B?d0lWSmFla0hvTzdNSHZUN2FkaXo3anE2cXZJU0NmTEV4eWVwQzBGcDNpb2tK?=
 =?utf-8?B?RzRTdzNPaVplS2RIRHRlV05yL1RRRXJXa2QrWXZBc2RDL0xuZ2x5dm1acjA3?=
 =?utf-8?B?OUFxNzFGNTNxZkJjVE9VTnlFV05vVnZWYU1JOGxZNUVRZGxHQTdBZWVDMWEw?=
 =?utf-8?B?RDE5MW1tTm1NTGFuQlA1Q0JYa0dyck52VGNoRDhuakFBVi9EQlN0eDhNbXVv?=
 =?utf-8?B?UXZUdEV5YURVUmJXSk0ra09wS1lzT2xBYURGdFNCUzJqYWh1ZFFrbTEwZUgr?=
 =?utf-8?B?QkQvT3NzaGNpek0vWlNiTytuRkRlT2FwZnhWMHdNM3FDanRFM1p5SGNSTjlt?=
 =?utf-8?B?czZ0c01GMHArNCs2MG5naGd2TStiRCtYZ3lHZ29TVmZpMjFndFBwcjAwTTgv?=
 =?utf-8?B?OWQxSW5TeHdHK0pUcW13ODFOMDh3YVZFaXN0VDlJdlJ2eFVEUHIrRVhkY0Jp?=
 =?utf-8?B?YldyVjJSVWFkUDRxbkd5RUxLSkVoeXo5cDNaaUZJdytvQ1UzcmtheTFtZ3RX?=
 =?utf-8?B?dlU5NnJVOGRRcW13ZWRZMVM5KzhUQXU2Lys4MUJkcHR2Zzc5VmwycFdmUExG?=
 =?utf-8?B?OTJ0N01NekEvOWgxUzF2VDhQdXhncHgrTWdLQVNHcjNQUXNlN0JqdVVGNExq?=
 =?utf-8?B?SXFEKzZ0S0VKMzg3NjcxMUNOS3VXYlFtbXhMYTFIeGdWRERDUEE5WFFRa213?=
 =?utf-8?B?Z21hakdyczMxMlVPb2hIQlFpQUx0UitkUTA2ZWMyaFUvNllEa3pKUVNBcHkw?=
 =?utf-8?B?S04wdGVCMFA1K0hnWTAzaE1OamdrYmZNamx2MXdyZ0lSSHVxK3pvVldTV1Bv?=
 =?utf-8?B?dEtUK1BQcFdCVlZ5d0EvWTRYOTV5bER4Nyt1cjZHVTcyUmNPQ0E3UVlrMTBB?=
 =?utf-8?B?a1BLRUVXOXZQZUhzVDFxZVZhTnh0STZmV0JJdGJMdEwrT2hIMGpBZkZpeHpG?=
 =?utf-8?B?RDRYWnFVRzMrM3l1c1B1QTNTTmpyOWcvNWE5TjhRN3lMeXBmUENZelp1cjdQ?=
 =?utf-8?B?Z3ZUN2hVQ0tBRUJjNG9odnFBNDZlR0JFdjNjaG1ScnFjU3JDNG5WeWVFQVdy?=
 =?utf-8?B?U2ZyOE4yQXpzN3ZoTk5WNWhYTEQ2ZHJhSFliRmNxOVR2Wi9JTGhHWTVVblox?=
 =?utf-8?B?c28rTk04N094TGo2U3hpaTFFS1BCaFZQdm9Fb2J0TWdtRHEyaHFNdTdBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTY1UUcrdmlVd2htSlpYVlZtQ0JQUy9LZ1ZpZUtWazBWZGZGNmdrL2NTTFBH?=
 =?utf-8?B?bFBrVlEwdVk3VTBjbG9uWU01OW4xVjhsOWlON1dJUVlGbGY3akVzYjJwQ2tk?=
 =?utf-8?B?VS94bFVYbXVPeWJCK292Q29KQkVtTklUczBSMzJIVGo0RzdZaTFXUnV4ckQw?=
 =?utf-8?B?RXNuRWpRRXVVR3dNMisyUkZjSU1NeG9Gazd2NEs1MzhTc2Y1dit2UnpHaTJ6?=
 =?utf-8?B?THN1SGhXUE9OZlkrQXR1Vkd1eVFmN2R2U3dMZys5WnYxU0hKTnFZOFlSdjhE?=
 =?utf-8?B?bCtVUFNpL0ovaHVlMXI2OEpwTHRQTHlMWVpnZ01TSjg1VlM3bE9TTTgrME9u?=
 =?utf-8?B?Mi9SY1ZiT0E0WVJmaU5tbjMyK0lJYWloNm9OTmM3RFB4emdZa2JFdFowdGtT?=
 =?utf-8?B?K1ZXaVM4R2lJRFcwYkN5MVlPYk1PSmJPdVNsZ2RSMXNneHpQRUZtaFB3T3h0?=
 =?utf-8?B?a0RuU29mTVVFRlVTUS9HaUMvQjBnZjNUdGNobXp4aFZKcFR5NDlGWVI2eG9E?=
 =?utf-8?B?MUxxZUVtbFFxSkoxbjluUG10Vi9UdjBWckVjSkMvZ3Q4QUd3MVhsbkxtMEsr?=
 =?utf-8?B?SjVLdlpacklkWWVvbnhZU2c0VVh2YzlNYU9vazNxUDc0bk11dlJlR1h0MXdB?=
 =?utf-8?B?bTJRK1dUeFpYQWJwbmxCcW9KdGVRaDVmVVg1SC9PSkZseWlZcFJOcVo2SlZI?=
 =?utf-8?B?ajVLb0NkUEJnVmVKOWF6eVg2TWgwM0dHc2IwbHJvcjRWNVlacFVkRHgrcG1Q?=
 =?utf-8?B?L0Y3eFZpZzB1U0lXSkJ6cUxXTDQxME1mMTNuY1lORGVyemRZU3R6UFY1T0lV?=
 =?utf-8?B?ampYUnhmM2svYkxXRXdhYVJvN0pUM3JRcHpJVzhTam5lelIvYU05bkVjVUxE?=
 =?utf-8?B?V2tBaGpMOWdkTktYL2JxOVY5WUlZT3JxRzYxSDFTdFA2YnYyTWt4VllaM08w?=
 =?utf-8?B?Zk5nSWlZNGhRNXVIT21EczF0LzIwbTJBQkhJRmpGeXRnZ1d0NmhSUU1oUk9P?=
 =?utf-8?B?a29ZT3VMeW1pY3U0RDl4N0ZjVkRiOCtUSEZSQ21aaFBGUjRzR3RpTjZtNHh1?=
 =?utf-8?B?TEpMd05mWU1OVFJ5amE0cGdBcS9peVJOUk1udHRpMVRReTAxb3hndVFMS1Zw?=
 =?utf-8?B?Sm4xb01UVElwa2dTMjg0TnpMVW5wUGpNeTVpandPR2M3U1c2QnJWNHpLdXdP?=
 =?utf-8?B?dmQ5cUZxZzhackdlUGJGUHhtd09TUU5COFZCZ3hpV05acDBJS2hIb3dmS1BW?=
 =?utf-8?B?MnRYVlBWcFZibThiaTlXbzVPY1BFWUhnMXk1RHVUZXowVE5oU3lEOTdnYzFD?=
 =?utf-8?B?eFlLNDNiUzBHQUlLdXd5OXRwbmpmQzNSVWV1SUJkeURsNkl6MFdjZ0JHdmM0?=
 =?utf-8?B?eGU4NVRJK3krK1htamNqS0dGMXBYa1VHZWwyT3cxb1J0MVN0ZlRWRzJvSG4x?=
 =?utf-8?B?b09sR0lYTDBWMitPUjI5NHA1WEREeW1Sc1g1VW1zVDFCRXd2WW00RVJEVFo3?=
 =?utf-8?B?SnJFdDBpek5pM3JhRldCUWZ6SzQ2ZnVFaExxeUlNQ2UxNHcweFc4WFlNSDEr?=
 =?utf-8?B?VXY2QS9ZNHZBUzJnTFhmajRCa01EcjRnU3lKbEpHUEtBcG12Z3RQZElwdEFq?=
 =?utf-8?B?YWVkV25wdFNJZllKRVJGU1MrRG14SCtTVk5JbUIybG93ZE1GMXZjOE10S1hW?=
 =?utf-8?B?UmdvZTAwNWtvcXQ0RHdDN0trSWRMUHNLQTVpRVNGby84VERHbnpReDN4ZDJO?=
 =?utf-8?B?UjUzV1RhQ2FLbnh3UU1tYzkwMUF2RlpsLzFZQ29kNjRVNTNnc0oveHRHdnVU?=
 =?utf-8?B?Y2xrZXE2cHA0VzlWeWhYeGJKOXBPRFVGVTZWUTlsVTlnN1dRRm9xSG93aDRw?=
 =?utf-8?B?d0ZSUEVzbG5MMndONnZJNVF6Mm96L29SWlN2NEJzUTJvMzhjZ21zUTQrLzZN?=
 =?utf-8?B?ZHZ3MVUwK3hQUUM3RUxidVNLdUErVEVuM1NQRGExT3d2Zm1vZ0M2NVpNKzBU?=
 =?utf-8?B?cVU5RFRmbWdHa3IwUG1uMUFsMDRvd2ZsVktRaERzaCtyVXhPTmhCaFRSaWZx?=
 =?utf-8?B?bGpJeUVPd2FTck9TU1RMdUdHR2UrNDkyT2FHejhwWTVlV2NTc2IrdWV5WTBk?=
 =?utf-8?B?TlA4Q09kZnYzdUE4VUZ1WkFhMjk5TWRHK3BJUXhoZ2tBZTBGQWROdUtBbzZM?=
 =?utf-8?B?c08zMUUwSUt4cTREc1hadVpjajJvK2dwNHFmUWpYQ2tKK2R5eGF2WEI5dXZz?=
 =?utf-8?Q?5IY3tuANK9+hbEfl0SQnt7FsP9AVA7Ak2xrd/bZwqE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR02MB73848DD662C5FAA19BB506BFF6112PH0PR02MB7384namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263c6abe-9fea-4da0-d62a-08dc636640e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 07:23:20.6163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLLQqXbSFJC3jAmQ0qG5Xk1W71hpAk431yTOSvGFmQFd4yPMNAB5t9w5IWeQWsd9I7rpzAC0+/KYt9MLYl7yIx9Jc6LrWDq8Zu207rHob04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7998
X-Proofpoint-GUID: InjbM29f_jYuxMLej9VuvNYeEaOiut4w
X-Proofpoint-ORIG-GUID: InjbM29f_jYuxMLej9VuvNYeEaOiut4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--_000_PH0PR02MB73848DD662C5FAA19BB506BFF6112PH0PR02MB7384namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhhbmtzIFdhbmcgTGllLiBZZXMgc3VyZSB3aWxsIGRvIHNhbWUgdW50aWwgd2UgaGF2ZSBuZXcg
dmVyc2lvbi4NCg0KVGhhbmtzDQpNYW5pc2ggTWlzaHJhDQoNCkZyb206IFdhbmcsIExlaSA8bGVp
NC53YW5nQGludGVsLmNvbT4NCkRhdGU6IFR1ZXNkYXksIDIzIEFwcmlsIDIwMjQgYXQgMTI6NTAg
UE0NClRvOiBNYW5pc2ggTWlzaHJhIDxtYW5pc2gubWlzaHJhQG51dGFuaXguY29tPiwgcWVtdS1k
ZXZlbEBub25nbnUub3JnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpDYzogY2hyaXN0b3BoZXIu
ci5ibGV2aW5zQGludGVsLmNvbSA8Y2hyaXN0b3BoZXIuci5ibGV2aW5zQGludGVsLmNvbT4sIHJv
YmVydC5odUBsaW51eC5pbnRlbC5jb20gPHJvYmVydC5odUBsaW51eC5pbnRlbC5jb20+DQpTdWJq
ZWN0OiBSZTogTWlzc2luZyBmZWF0dXJlcyBpbiBRRU1VIFNhcHBoaXJlUmFwaWQgZGVmaW5pdGlv
bg0KIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS18DQogIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQoNCnwtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IQ0KDQpIaSBNYW5pc2gsDQoNClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uLiBJdCBzZWVtcyB0
aG9zZSAzIGZlYXR1cmVzIGFyZSBtaXNzaW5nIGluIHRoZSBTUFIgQ1BVDQpNb2RlbCBkZWZpbml0
aW9uLCB3ZSBhcmUgY3VycmVudGx5IHBvbGlzaGluZyBvdXIgbmV3IFNQUiBDUFUgTW9kZWwgdmVy
c2lvbiwgeW91DQpjYW4gbGF1bmNoIHRoZSBTUFIgQ1BVIE1vZGVsIHVzaW5nOg0KDQogICAgICAg
IC1jcHUgU2FwcGhpcmVSYXBpZHMsK2NsZGVtb3RlLCttb3ZkaXJpLCttb3ZkaXI2NGINCg0KYXMg
YSB3b3JrYXJvdW5kIGFuZCBzb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2U6KQ0KDQpUaGFua3Ms
DQpMZWkNCg0KT24gNC8yMy8yMDI0IDE0OjU3LCBNYW5pc2ggTWlzaHJhIHdyb3RlOg0KPiBIaSBF
dmVyeW9uZSwNCj4NCj4gV2Ugc2VlIGZldyBmZWF0dXJlcyBsaWtlIG1vdmRpcmksIG1vdmRpcmk2
NGIsIGNsZGVtb3RlIGFyZSBwcmVzZW50IG9uDQo+IFNhcHBoaXJlUmFwaWQgbm9kZXMgYW5kIGFy
ZSBhbHNvIG1lbnRpb25lZCBhcyBzdXBwb3J0ZWQgaW4gaW50ZWwgbWFudWFsLiAgQnV0DQo+IHRo
ZXNlIGFyZSBtaXNzaW5nIGZyb20gdGhlIFFFTVUgZGVmaW5pdGlvbiBvZiBTYXBwaGlyZVJhcGlk
IENQVXMNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19naXRodWIuY29tX3FlbXVfcWVtdV9jb21taXRfN2ViMDYxYjA2ZTk3YWY5YThkYTdmMzFi
ODM5ZDc4OTk3YWU3MzdmYyZkPUR3SURhUSZjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmcj1jNEtP
TjJEaU1kLXN6andqZ2dRY3VVdlRzUFdibHp0QUwwZ1Z6YUhuTm1jJm09cXNYc3ZBOVFvM01MM29D
Y2NIMHFTQTNCQnE0NTQ0QWNhTVhPZWFidmRlamUwSFFIMzJ0ZEpHUWJYWjZFWlBoWCZzPUhxdm9P
T0VUZGNSbDktS2k4UFdiLXBqckYwbEJNSW0xQ0RWOFQwZUp0OGcmZT0NCj4gPGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9xZW11
X3FlbXVfY29tbWl0XzdlYjA2MWIwNmU5N2FmOWE4ZGE3ZjMxYjgzOWQ3ODk5N2FlNzM3ZmMmZD1E
d0lEYVEmYz1zODgzR3BVQ09DaEtPSGlvY1l0R2NnJnI9YzRLT04yRGlNZC1zemp3amdnUWN1VXZU
c1BXYmx6dEFMMGdWemFIbk5tYyZtPXFzWHN2QTlRbzNNTDNvQ2NjSDBxU0EzQkJxNDU0NEFjYU1Y
T2VhYnZkZWplMEhRSDMydGRKR1FiWFo2RVpQaFgmcz1IcXZvT09FVGRjUmw5LUtpOFBXYi1wanJG
MGxCTUltMUNEVjhUMGVKdDhnJmU9ID4uDQo+IFRoZXJlIG1heSBiZSBvdGhlciBmZWF0dXJlcyB0
b28gbWlzc2luZyBidXQgd2Ugd2VyZSBwYXJ0aWN1bGFybHkgaW50ZXJlc3RlZCBpbg0KPiB0aGVz
ZSB0aHJlZS4gU28ganVzdCB3YW50ZWQgdG8gdW5kZXJzdGFuZCBpZiB0aGVyZSBpcyBhbnkgcmVh
c29uIGZvciB0aGlzLiAgQW55DQo+IGhlbHAgb24gdGhpcyB3aWxsIGJlIHJlYWxseSBhcHByZWNp
YXRlZC4g8J+Yig0KPg0KPiBUaGFua3MNCj4NCj4gTWFuaXNoIE1pc2hyYQ0KPg0KPg0KPg0K

--_000_PH0PR02MB73848DD662C5FAA19BB506BFF6112PH0PR02MB7384namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7DQoJcGFub3NlLTE6MiAx
MSAwIDQgMiAyIDIgMiAyIDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseToiQXBwbGUgQ29s
b3IgRW1vamkiOw0KCXBhbm9zZS0xOjAgMCAwIDAgMCAwIDAgMCAwIDA7fQ0KLyogU3R5bGUgRGVm
aW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3JtYWwNCgl7
bWFyZ2luOjBjbTsNCglmb250LXNpemU6MTIuMHB0Ow0KCWZvbnQtZmFtaWx5OiJBcHRvcyIsc2Fu
cy1zZXJpZjt9DQphOmxpbmssIHNwYW4uTXNvSHlwZXJsaW5rDQoJe21zby1zdHlsZS1wcmlvcml0
eTo5OTsNCgljb2xvcjpibHVlOw0KCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0Kc3Bhbi5F
bWFpbFN0eWxlMTkNCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7DQoJZm9udC1mYW1p
bHk6IkFwdG9zIixzYW5zLXNlcmlmOw0KCWNvbG9yOndpbmRvd3RleHQ7fQ0KLk1zb0NocERlZmF1
bHQNCgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9ubHk7DQoJZm9udC1zaXplOjEwLjBwdDsNCglt
c28tbGlnYXR1cmVzOm5vbmU7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6NjEyLjBwdCA3
OTIuMHB0Ow0KCW1hcmdpbjo3Mi4wcHQgNzIuMHB0IDcyLjBwdCA3Mi4wcHQ7fQ0KZGl2LldvcmRT
ZWN0aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPg0KPC9oZWFkPg0KPGJv
ZHkgbGFuZz0iRU4tSU4iIGxpbms9ImJsdWUiIHZsaW5rPSJwdXJwbGUiIHN0eWxlPSJ3b3JkLXdy
YXA6YnJlYWstd29yZCI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7bXNvLWZhcmVhc3QtbGFuZ3Vh
Z2U6RU4tVVMiPlRoYW5rcyBXYW5nIExpZS4gWWVzIHN1cmUgd2lsbCBkbyBzYW1lIHVudGlsIHdl
IGhhdmUgbmV3IHZlcnNpb24uPG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6
RU4tVVMiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O21zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVT
Ij5UaGFua3M8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjExLjBwdDttc28tZmFyZWFzdC1sYW5ndWFnZTpFTi1VUyI+TWFu
aXNoIE1pc2hyYTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0O21zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVTIj48
bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2IGlkPSJtYWlsLWVkaXRvci1yZWZlcmVu
Y2UtbWVzc2FnZS1jb250YWluZXIiPg0KPGRpdj4NCjxkaXYgc3R5bGU9ImJvcmRlcjpub25lO2Jv
cmRlci10b3A6c29saWQgI0I1QzRERiAxLjBwdDtwYWRkaW5nOjMuMHB0IDBjbSAwY20gMGNtIj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4tYm90dG9tOjEyLjBwdCI+PGI+PHNw
YW4gc3R5bGU9ImNvbG9yOmJsYWNrIj5Gcm9tOg0KPC9zcGFuPjwvYj48c3BhbiBzdHlsZT0iY29s
b3I6YmxhY2siPldhbmcsIExlaSAmbHQ7bGVpNC53YW5nQGludGVsLmNvbSZndDs8YnI+DQo8Yj5E
YXRlOiA8L2I+VHVlc2RheSwgMjMgQXByaWwgMjAyNCBhdCAxMjo1MCBQTTxicj4NCjxiPlRvOiA8
L2I+TWFuaXNoIE1pc2hyYSAmbHQ7bWFuaXNoLm1pc2hyYUBudXRhbml4LmNvbSZndDssIHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZyAmbHQ7cWVtdS1kZXZlbEBub25nbnUub3JnJmd0Ozxicj4NCjxiPkNj
OiA8L2I+Y2hyaXN0b3BoZXIuci5ibGV2aW5zQGludGVsLmNvbSAmbHQ7Y2hyaXN0b3BoZXIuci5i
bGV2aW5zQGludGVsLmNvbSZndDssIHJvYmVydC5odUBsaW51eC5pbnRlbC5jb20gJmx0O3JvYmVy
dC5odUBsaW51eC5pbnRlbC5jb20mZ3Q7PGJyPg0KPGI+U3ViamVjdDogPC9iPlJlOiBNaXNzaW5n
IGZlYXR1cmVzIGluIFFFTVUgU2FwcGhpcmVSYXBpZCBkZWZpbml0aW9uPG86cD48L286cD48L3Nw
YW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxMS4wcHQiPiEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfDxicj4NCiZuYnNwOyBDQVVUSU9OOiBFeHRl
cm5hbCBFbWFpbDxicj4NCjxicj4NCnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tITxicj4NCjxicj4NCkhpIE1hbmlzaCw8
YnI+DQo8YnI+DQpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbi4gSXQgc2VlbXMgdGhvc2UgMyBm
ZWF0dXJlcyBhcmUgbWlzc2luZyBpbiB0aGUgU1BSIENQVTxicj4NCk1vZGVsIGRlZmluaXRpb24s
IHdlIGFyZSBjdXJyZW50bHkgcG9saXNoaW5nIG91ciBuZXcgU1BSIENQVSBNb2RlbCB2ZXJzaW9u
LCB5b3U8YnI+DQpjYW4gbGF1bmNoIHRoZSBTUFIgQ1BVIE1vZGVsIHVzaW5nOjxicj4NCjxicj4N
CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAtY3B1IFNhcHBoaXJl
UmFwaWRzLCtjbGRlbW90ZSwrbW92ZGlyaSwrbW92ZGlyNjRiPGJyPg0KPGJyPg0KYXMgYSB3b3Jr
YXJvdW5kIGFuZCBzb3JyeSBmb3IgdGhlIGluY29udmVuaWVuY2U6KTxicj4NCjxicj4NClRoYW5r
cyw8YnI+DQpMZWk8YnI+DQo8YnI+DQpPbiA0LzIzLzIwMjQgMTQ6NTcsIE1hbmlzaCBNaXNocmEg
d3JvdGU6PGJyPg0KJmd0OyBIaSBFdmVyeW9uZSw8YnI+DQomZ3Q7IDxicj4NCiZndDsgV2Ugc2Vl
IGZldyBmZWF0dXJlcyBsaWtlIG1vdmRpcmksIG1vdmRpcmk2NGIsIGNsZGVtb3RlIGFyZSBwcmVz
ZW50IG9uPGJyPg0KJmd0OyBTYXBwaGlyZVJhcGlkIG5vZGVzIGFuZCBhcmUgYWxzbyBtZW50aW9u
ZWQgYXMgc3VwcG9ydGVkIGluIGludGVsIG1hbnVhbC4gJm5ic3A7QnV0PGJyPg0KJmd0OyB0aGVz
ZSBhcmUgbWlzc2luZyBmcm9tIHRoZSBRRU1VIGRlZmluaXRpb24gb2YgU2FwcGhpcmVSYXBpZCBD
UFVzPGJyPg0KJmd0OyA8YSBocmVmPSJodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX2dpdGh1Yi5jb21fcWVtdV9xZW11X2NvbW1pdF83ZWIwNjFiMDZl
OTdhZjlhOGRhN2YzMWI4MzlkNzg5OTdhZTczN2ZjJmFtcDtkPUR3SURhUSZhbXA7Yz1zODgzR3BV
Q09DaEtPSGlvY1l0R2NnJmFtcDtyPWM0S09OMkRpTWQtc3pqd2pnZ1FjdVV2VHNQV2JsenRBTDBn
VnphSG5ObWMmYW1wO209cXNYc3ZBOVFvM01MM29DY2NIMHFTQTNCQnE0NTQ0QWNhTVhPZWFidmRl
amUwSFFIMzJ0ZEpHUWJYWjZFWlBoWCZhbXA7cz1IcXZvT09FVGRjUmw5LUtpOFBXYi1wanJGMGxC
TUltMUNEVjhUMGVKdDhnJmFtcDtlPSI+DQpodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5j
b20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdGh1Yi5jb21fcWVtdV9xZW11X2NvbW1pdF83ZWIwNjFi
MDZlOTdhZjlhOGRhN2YzMWI4MzlkNzg5OTdhZTczN2ZjJmFtcDtkPUR3SURhUSZhbXA7Yz1zODgz
R3BVQ09DaEtPSGlvY1l0R2NnJmFtcDtyPWM0S09OMkRpTWQtc3pqd2pnZ1FjdVV2VHNQV2JsenRB
TDBnVnphSG5ObWMmYW1wO209cXNYc3ZBOVFvM01MM29DY2NIMHFTQTNCQnE0NTQ0QWNhTVhPZWFi
dmRlamUwSFFIMzJ0ZEpHUWJYWjZFWlBoWCZhbXA7cz1IcXZvT09FVGRjUmw5LUtpOFBXYi1wanJG
MGxCTUltMUNEVjhUMGVKdDhnJmFtcDtlPTwvYT4NCjxicj4NCiZndDsgJmx0O2h0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0aHViLmNvbV9xZW11
X3FlbXVfY29tbWl0XzdlYjA2MWIwNmU5N2FmOWE4ZGE3ZjMxYjgzOWQ3ODk5N2FlNzM3ZmMmYW1w
O2Q9RHdJRGFRJmFtcDtjPXM4ODNHcFVDT0NoS09IaW9jWXRHY2cmYW1wO3I9YzRLT04yRGlNZC1z
emp3amdnUWN1VXZUc1BXYmx6dEFMMGdWemFIbk5tYyZhbXA7bT1xc1hzdkE5UW8zTUwzb0NjY0gw
cVNBM0JCcTQ1NDRBY2FNWE9lYWJ2ZGVqZTBIUUgzMnRkSkdRYlhaNkVaUGhYJmFtcDtzPUhxdm9P
T0VUZGNSbDktS2k4UFdiLXBqckYwbEJNSW0xQ0RWOFQwZUp0OGcmYW1wO2U9DQogJmd0Oy48YnI+
DQomZ3Q7IFRoZXJlIG1heSBiZSBvdGhlciBmZWF0dXJlcyB0b28gbWlzc2luZyBidXQgd2Ugd2Vy
ZSBwYXJ0aWN1bGFybHkgaW50ZXJlc3RlZCBpbjxicj4NCiZndDsgdGhlc2UgdGhyZWUuIFNvIGp1
c3Qgd2FudGVkIHRvIHVuZGVyc3RhbmQgaWYgdGhlcmUgaXMgYW55IHJlYXNvbiBmb3IgdGhpcy4g
Jm5ic3A7QW55PGJyPg0KJmd0OyBoZWxwIG9uIHRoaXMgd2lsbCBiZSByZWFsbHkgYXBwcmVjaWF0
ZWQuIDwvc3Bhbj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExLjBwdDtmb250LWZhbWlseTomcXVv
dDtBcHBsZSBDb2xvciBFbW9qaSZxdW90OyI+JiMxMjg1MjI7PC9zcGFuPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTEuMHB0Ij48YnI+DQomZ3Q7IDxicj4NCiZndDsgVGhhbmtzPGJyPg0KJmd0OyA8
YnI+DQomZ3Q7IE1hbmlzaCBNaXNocmE8YnI+DQomZ3Q7IDxicj4NCiZndDsgJm5ic3A7PGJyPg0K
Jmd0OyA8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rp
dj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_PH0PR02MB73848DD662C5FAA19BB506BFF6112PH0PR02MB7384namp_--

