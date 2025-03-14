Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D066C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9rb-0000rb-Px; Fri, 14 Mar 2025 14:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1tt9rD-0000a5-TG
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:34:12 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1tt9rA-0007oE-Ne
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:34:07 -0400
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
 by m0409411.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 52EFbLB7015681; Fri, 14 Mar 2025 18:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=ivkNAhxJZ
 JIRra6MMclNVIVnQ0Z84qDMdeMWVajBgGs=; b=JfqzM5VhdpJQnf4W98El4oAhW
 6yejVbiePDoHHfQljvTDE6YNsT3sZbdR55dgx/cMY2MuxYrFQP0tMQk5cdDLHX1d
 xAYiqHHElqYPYIzJ3TSj4wfiww8jCuWZ7qbE5lU6WDYc5gVY9anEuz/iUPeQJjat
 yo3f8ZI5dZFZSHWsOW8oqlEqECXcoBH1wLrOy/edQs1cMlndZR1S/FrJ+nNb2pGo
 GK6aoAfioZxHj3uqjBU4n2pFGNosRNeD68YejKYDkRCP5agHlhPYys15Lq0fTuhg
 2+cQFZiqiI1vv4G3ZGuDbgDLKOdTo34rRKvZWMOfl1+Hj5x1mRd4qllNzQQ8w==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18]
 (may be forged))
 by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 45au4tbvf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 18:34:00 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 52EG5skb021827; Fri, 14 Mar 2025 14:33:59 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.206])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 45au4e2shb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Mar 2025 14:33:58 -0400
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 11:33:57 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 13:33:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 13:33:57 -0500
Received: from BN8PR17MB2755.namprd17.prod.outlook.com (2603:10b6:408:53::19)
 by DS0PR17MB6984.namprd17.prod.outlook.com (2603:10b6:8:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 18:33:55 +0000
Received: from BN8PR17MB2755.namprd17.prod.outlook.com
 ([fe80::7ac4:a8e9:d7c9:6016]) by BN8PR17MB2755.namprd17.prod.outlook.com
 ([fe80::7ac4:a8e9:d7c9:6016%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 18:33:55 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "armbru@redhat.com" <armbru@redhat.com>, "Glasgall, Anna"
 <aglasgal@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max"
 <mtottenh@akamai.com>
Subject: [BUG][RFC] CPR transfer Issues: Socket permissions and PID files
Thread-Topic: [BUG][RFC] CPR transfer Issues: Socket permissions and PID files
Thread-Index: AQHblQ+koYDHHa36dECBReju+gYnxg==
Date: Fri, 14 Mar 2025 18:33:55 +0000
Message-ID: <3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR17MB2755:EE_|DS0PR17MB6984:EE_
x-ms-office365-filtering-correlation-id: cf03f535-ffbd-46c6-3ea8-08dd6326c6cc
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0Q1alkxMzFxMlM5V1JIT1AzOUJ3V0VSaTFSMlYyZnVIWDk1bHRBTXc5T1J6?=
 =?utf-8?B?NWZIR25ONkpCV2F1aDFEVy9kMDZ0RldIM0UzSWpkSGZHVnVvWWRqbWNocDZL?=
 =?utf-8?B?ZmRHNGVTdU05SUFNUE9hNHh2TkRNTm1TZmZMeEd3L1ZqMXZaSlFZQXBYMXRQ?=
 =?utf-8?B?cDI0QStQUWtkRE5RU2pHUUI3ODNrcmdheThaUGdGMXFGMUZMaitxTjNtTWgr?=
 =?utf-8?B?MlhNZmU1RTBLaVFCZHNtcWR5QTZJaHF0LzQ2czRMWlRQL2RJd1RsOE1WbkEx?=
 =?utf-8?B?c1UyTVZrZ2FIQTNOSmtzb2QrYWpSSkNTTWwzRmtZSEJkK1JzTXMxNEF1cFRN?=
 =?utf-8?B?a1hpU2dWUnhYTzZNZnVlNUw3Ym5TOXJLYm5tWU5Ca2REOVRoTW5YWlVKUy96?=
 =?utf-8?B?ZTczd0dRMlMwd253VHlUdnJZTnNFL1Fna0lDYVcvcHUydVBaZkk4QzJTSGR2?=
 =?utf-8?B?cUh0V240ZjBMNGRmM2JyS05rc1FNSUdWT1hYbTR1ekM2b05rNjVaZzZyQ0N6?=
 =?utf-8?B?TXdxaktuZzFSWkpudmtHZDYwWGlQWEVLTEFSOUgwNXZyRWxXWlFtdEpKUTZr?=
 =?utf-8?B?Y04yOExiMTFvK011UWpyWFpXTG5JZFdBRzczR0RQZlpzK05iNytIOXU3Q0pO?=
 =?utf-8?B?aytGR1Irc0JVL1l3ZVpkZlpKbzBTUGd2THB0VERGaks4RWNiL2pnWHh6VXN5?=
 =?utf-8?B?MnJsYmsydFRCZkZrYUlGMTg0MURldWl5cGtDRUpoVExJVkhmaThnVUdOMGpE?=
 =?utf-8?B?NXVTWUJjNHVpQzRNL0J4VytENXlWTmo2a1pkTTZqdncxdVZoN2F6SjB4c29p?=
 =?utf-8?B?cDZtVEluR2l2RDE4SUxSeVpLMmc4VE1ld2s1YThpMmZXeVg3VXZRTUdKYURa?=
 =?utf-8?B?R05wd01RZEIzaHZNVFpPeDE4ajF1NUdJUVBSMnY4N0NqR3JiVlMyZ2JpSlhy?=
 =?utf-8?B?aXQ2OEQxYmlCdTdMNHVvVFhHT0JSbDRZUlNIdGhkbHh4ZHF4MzhMR0JTMjZ2?=
 =?utf-8?B?WjViR0RlV0thRkFvUlNPeWxIdnJ6djFLTXo4NmxLeS9MZzYyN0NsSVVLdXBr?=
 =?utf-8?B?a0dZYnMyVnBncURGdTdRd016VUV0MjNxY0Q2WW9DNENwa2NPRUVsUGJ3OWxY?=
 =?utf-8?B?SWh1ZEtXOVk3TDBPcS9XZWNXVGJ6MUVCYTR0OVJ6V0FuYzJHWUsvOWt6WC9k?=
 =?utf-8?B?QXFNOFJNQUpSc2pVRzQvdTN3a3JKbm96MGQybytvWW1Tb1A5Q3RFQkhJT2o0?=
 =?utf-8?B?eU5rb1VLT0c1OUROWVAyNUNtNURCVE1Kc2R2Rzc0V3RZL2FmV203Mi85dVRM?=
 =?utf-8?B?dk1wRDF0TDhvLzV2bmo4NEdzWHZERlFWYlU0YU1EMUJDM1VUQlBQbzJmb1ND?=
 =?utf-8?B?KzVKQVRiYi9MOVFaU2ozZVAwUTVrVFZtZWZYUGUwb3BuVVRaV1BaZkFhL3RH?=
 =?utf-8?B?RDBMaEVjaTRJNGhJZzNKZUwxeFBjajdKNmUxeVJXalU4T3hZWjV0OUoxVks5?=
 =?utf-8?B?VFQwQ2hCY3hVMi9NWWRZRUlHR1ZYTmM3N2krRnd6R2YrMXk1WFZZL3dKcHdm?=
 =?utf-8?B?TWVxdlk1dnFteHlXTjZEdjdCeXZPVVFmVnUwbFFEUnNkVmIxV2tZKy91R2pY?=
 =?utf-8?B?UnNaOEJxWmVRUWk5TEJzc0NWVFlNQjZHclBueU5QeWZVLzR5Qy9KZGMzYk5H?=
 =?utf-8?B?UDYxYWZLSC9pZnd2eVEzT3Z3RUFrNG95Mlh2UEwxZU9FdDBXS2FuYWt0VWtr?=
 =?utf-8?B?QkNxZko4TFV1TUpBeTNLMDYvSnpsWDdybFpoQnZmZXhkbHJxTFNvaDV4RW1w?=
 =?utf-8?B?K1R0VTFXRG9yMmovUXphN2FTcm83eDFNWERFUFk5eUZjZXZDTS9HbDJNSE1l?=
 =?utf-8?B?dWdERzZUcDNlMVRVS0xyWFRJcHRGMXB6YTdKamYzcUtzN3FOWkhjNFNxYUFS?=
 =?utf-8?Q?LzdE6O2oGA7leJHZ9dWMYS7JDJ2ue6DN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR17MB2755.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGw3VmR4WkMyZEhFV1ZBN2pOWWU3K0ZHWThzRVFBOU1jcnN4Unl0Y0pGNEds?=
 =?utf-8?B?M3I4VEJsdmdWa3pIdEZlR1ZhckJ0bjRGU1RlRVFVMjB2aWQ2R0txMkw4Q3RT?=
 =?utf-8?B?cEN6TldQK281ZC9KVkkydHRNS1NQVGdiMFgxQzNlak83Mkp4VTRvaUhxallP?=
 =?utf-8?B?S1RJdFlYV284alRCNk5rQjJ2WThLRklRRldBN3hhNTM0TU9hckJmY2gvNEt0?=
 =?utf-8?B?NjYwTWlibytFV3Z5UDZraDdjTnB2cnVIaDc1ODVZQld5dENZMHhZY1BwRjh1?=
 =?utf-8?B?WkN4dnYwOW9NMDVUcjlaVkQvalFPNTZHaDBRMFlqR1dpdnJ2VkRKZmVjOXVr?=
 =?utf-8?B?cUl6dVRlajZvNzgyY3YwSzM5NmJYZ21TZzRsd1Q0OGpFWG1HblRPTVFaOGRH?=
 =?utf-8?B?NkMvcm5yM2M0RnNLeGtLeW1IK2UxaHgxdUhjeUhTVlRYd2lqZDZQYlBKb2xl?=
 =?utf-8?B?OE9NM1YvZ1h2eEJQTVJiSHE2Y0dYYk5aTHJ3dUZ5OXVuMXpRR1pUS3oxRXUy?=
 =?utf-8?B?K1Q1aHl1cmllMENvK1UyemlFckwrUWxURUUwQUtWNnpEOEtKcXVhZ2VBVDBn?=
 =?utf-8?B?ZEZZZDRJTUlwREhxRFRDV2ovQnQzNDFROGZlN3dSVzhIdU5Qd2djWUJaRkcz?=
 =?utf-8?B?eE9ZenMwTWFNcWk1QVZDU3lMMU9tbDNpOVVpdHBWNzFtaGJhZUhOUUJBVGY4?=
 =?utf-8?B?S25zNzlVRVJEODMvczNTcGM2RVo1T2hqS0xiM2R4UmpSTDJ6ZFhSbSs2Wnd4?=
 =?utf-8?B?bXVSQ2JSVGlxWENESGNOZ2hwOVBQdkZjUGhib2dYRkczeXUrcVJsaXZvMGUr?=
 =?utf-8?B?Sm9jcGk5T3BKYW10UnNUbWFvbWdnVGo0aU4zYnZWRUxuYS8reEM1ZjlwQ2N1?=
 =?utf-8?B?dzRkZlUvRmJkTUlIa0svbFo1cllzdTNNL0c4WXhTdVUxTDVlc2tpam9DN0NX?=
 =?utf-8?B?MnBjWG9MWnlMZFpGSEFYWDVrQ2xPS3ZDVXhiMkFwendvVGs3bVRqd3lkc3NX?=
 =?utf-8?B?cFFITmRKeWpsak5RcEc5OTFVaWhtTnBHcjJLWDJrMWlkb1JSR3IvbWlSeHcz?=
 =?utf-8?B?U1lGQ0NVNGpPZ25NOG9RQVBOV09QaGpjUm5rYzdDM2RBSEVOZFJNSURLRWtP?=
 =?utf-8?B?UkxjZzVPSzZHQ1Q5bzVIeXFRcHpuUkpiL0FrVGN4RXdSL1RaZ0JuckMzSGpC?=
 =?utf-8?B?WHZwTWRnUjZTdFVhcytHbkw4L2hqVDFocmJLTnFsSVAvWWtPbWlra29mZ3Nz?=
 =?utf-8?B?TmwrUjJjK09QNytRMEhJTWNBUnhGT3c4ZG5tZ2hxUkg1T0xqMzF0czBTNUFx?=
 =?utf-8?B?S3l5clBRMnVMekFXdnVZVEVkZTdGaURGcHd2Wlp6bG5WeHFhNGNvWnhRbHda?=
 =?utf-8?B?MEpMSkh4MjhDbmlaUlpVSytva3Z2UW5CWEUyRFQ5Nm1iR05ZQ1ppOStvTURB?=
 =?utf-8?B?UDl0djFlQUxHUVlnRzJBR051LzRDQVRONDNkVCtSSEdjd0J6NTdJeEZ3TGQ4?=
 =?utf-8?B?L3BEeTFrK1ArMUJOOWNHdFpYZTJldSsyMGFCbDRVd0VOejlwUEErcytCN0lt?=
 =?utf-8?B?bmEvMzhNQ2lubWRiTXhmbDJLMENiaDlOUFBhR0taNVF5b2dWZWV3NERrWlFo?=
 =?utf-8?B?aUxGRGJUWFJMTTYyQktWMTZGRVdGZTVSamhIM2xuUlQ3OUVkSlByQ0dZRTVn?=
 =?utf-8?B?WWVtRjliZkMvcE81RFNtSGxJK2padFY2WmJzUlhQSWZzQityZ2xGeWl1eHUv?=
 =?utf-8?B?NXduYWlzSlZHOTVMUmJYd2pGK3V4UUFPZzRQMHYxS2hnZUwwYU94ZWhaRjFV?=
 =?utf-8?B?bVc5bEplWXEzS2tPckpCdm1jbWlUR0E1Vkw3aG93NjM2ZUVTMThzd1hiN2RS?=
 =?utf-8?B?TVNOTElmeTlKT2tBT0hoS1IzV0NWUHd0Z0EwWmNwRGNmWEkwb3B4NzVWT1ly?=
 =?utf-8?B?LzVvcnBiZUdSb0ZXRTNLUmQ0eUpmdjJIME95ZFFHeTNqQWpEa3REZS9haStU?=
 =?utf-8?B?cjBXVUpRNEY0SHZQc055S1FtbzB6QVJLdlZJNjRXTmxORVNacGRCaWZWTTZW?=
 =?utf-8?B?WFpkNXdBS3hLUXAwRVg2U095a25SMmgxcmEzUlNtQmIvWnhQb1pNNWx4bklZ?=
 =?utf-8?Q?oOLWfACDDyOTlYFRdd1SAJ5lU?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXmcIwELplWjsGlXZiFu228U9H/De50EsEUswBM4CttcjYyFHN36HGKQac09HEZoeaW2SrNhcmyW11y81XOpJITu2shSYxQLubCQkViwMI+02PkXxOudr1AlCWWsovjtBA7qHKFhLyH962AZd68IsnglfxD9Phcdh8adfuD8JbCRnoS9RPzJnDxhPGKquYkibcyq4xQ7TvvxwcAM7eekrkiks08Bq6NdUazRnmGN2zgkfL7svhfrMpdg5iD7dMXqVYBkOsSbjQfvXgI1P5aXb0gtcrd8cY3GkZYQvw/CjPZ+tQxZSwnMKQdPSO0SzI5dv3REo1pYij3eW4n6QaaKjw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y5ycm7asFW37Vyp8NAyAZQPxeHBh2cqIntDNrI2NnY=;
 b=g5rZ9jSPw+njg5amWplmEi9KOX8VcIlXwomAKoLAiXtar7Bd4/VNbyBhPIQDSpGhmQG3bFBrtkUpkcSXNchONcwWOK2K8G4jwJc/azvtpJ+z25SjUqR8ZuCJby1xlljgMThiZbN1sXW6ntaagIcuUQ8zvmzackHjm4euOG4LsYO6vNjMya3XLP3MYeQVITVhrvG8KiFIGLdyA6c3oT/AsoD+UVn2xQ65iUuAMRwqJ3wY4AZWDzO45LZE9Kzw3e2LxZ8EqvZvkM/d/fNdduv2rVnZS7sVF0zeF6XfZHxPs3gPM3i0hS/4vsusMKbhDtS8v21ftmlEXUwozdDGghKSwQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y5ycm7asFW37Vyp8NAyAZQPxeHBh2cqIntDNrI2NnY=;
 b=jeYz0Ig2I7fBvcbWuC8Gu9rlKKRikSmP38Kn4l/981s5wbG4WprjgUcG1Dbi8ZGuIEwrDvIdmfTWcoZqLfVlimj++HixLUzV4zLFamVKhvs5WUreAdLOT4yVCvK4p13eGp2kPBXElDbqt/GRwq3OHfdO5iyeGQuPik0flVL7sio=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN8PR17MB2755.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: cf03f535-ffbd-46c6-3ea8-08dd6326c6cc
x-ms-exchange-crosstenant-originalarrivaltime: 14 Mar 2025 18:33:55.1559 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ZO5AlS+avLUkpZ/8qZYdWko2sZQcyYE7OqNyShNsuTofg460gVC2mDUFi22yHtlHHAv911kmN023LSQyPeZE5Q==
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR17MB6984
Content-Type: text/plain; charset="utf-8"
Content-ID: <96121A493C23FA4A9B0B41DB1FA774A2@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140143
X-Proofpoint-ORIG-GUID: xn438jabMrfuCUclaKZYRYkaVnBtoZ0A
X-Authority-Analysis: v=2.4 cv=Pav/hjhd c=1 sm=1 tr=0 ts=67d47698 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=g1y_e2JewP0A:10 a=5u7KhYVwOYSIvCfEw0kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xn438jabMrfuCUclaKZYRYkaVnBtoZ0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140145
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGVsbG8sDQoNCldoaWxlIHRlc3RpbmcgQ1BSIHRyYW5zZmVyIEkgZW5jb3VudGVyZWQgdHdvIGlz
c3Vlcy4gVGhlIGZpcnN0IGlzIHRoYXQgdGhlIHRyYW5zZmVyIGZhaWxzIHdoZW4gcnVubmluZyB3
aXRoIHBpZGZpbGVzIGR1ZSB0byB0aGUgZGVzdGluYXRpb24gcWVtdSBwcm9jZXNzIGF0dGVtcHRp
bmcgdG8gY3JlYXRlIHRoZSBwaWRmaWxlIHdoaWxlIGl0IGlzIHN0aWxsIGxvY2tlZCBieSB0aGUg
c291cmNlIHByb2Nlc3MuIFRoZSBzZWNvbmQgaXMgdGhhdCB0aGUgdHJhbnNmZXIgZmFpbHMgd2hl
biBydW5uaW5nIHdpdGggdGhlIC1ydW4td2l0aCB1c2VyPSRVU0VSSUQgcGFyYW1ldGVyLiBUaGlz
IGlzIGJlY2F1c2UgdGhlIGRlc3RpbmF0aW9uIHFlbXUgcHJvY2VzcyBjcmVhdGVzIHRoZSBVTklY
IHNvY2tldHMgdXNlZCBmb3IgdGhlIENQUiB0cmFuc2ZlciBiZWZvcmUgZHJvcHBpbmcgdG8gdGhl
IGxvd2VyIHBlcm1pc3Npb25lZCB1c2VyLCB3aGljaCBjYXVzZXMgdGhlbSB0byBiZSBvd25lZCBi
eSB0aGUgb3JpZ2luYWwgdXNlci4gVGhlIHNvdXJjZSBxZW11IHByb2Nlc3MgdGhlbiBkb2VzIG5v
dCBoYXZlIHBlcm1pc3Npb24gdG8gY29ubmVjdCB0byBpdCBiZWNhdXNlIGl0IGlzIGFscmVhZHkg
cnVubmluZyBhcyB0aGUgbGVzc2VyIHBlcm1pc3Npb25lZCB1c2VyLg0KDQpSZXByb2R1Y2luZyB0
aGUgZmlyc3QgaXNzdWU6DQoNCkNyZWF0ZSBhIHNvdXJjZSBhbmQgZGVzdGluYXRpb24gcWVtdSBp
bnN0YW5jZSBhc3NvY2lhdGVkIHdpdGggdGhlIHNhbWUgVk0gd2hlcmUgYm90aCBwcm9jZXNzZXMg
aGF2ZSB0aGUgLXBpZGZpbGUgcGFyYW1ldGVyIHBhc3NlZCBvbiB0aGUgY29tbWFuZCBsaW5lLiBZ
b3Ugc2hvdWxkIHNlZSB0aGUgZm9sbG93aW5nIGVycm9yIG9uIHRoZSBjb21tYW5kIGxpbmUgb2Yg
dGhlIHNlY29uZCBwcm9jZXNzOg0KDQpxZW11LXN5c3RlbS14ODZfNjQ6IGNhbm5vdCBjcmVhdGUg
UElEIGZpbGU6IENhbm5vdCBsb2NrIHBpZCBmaWxlOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2
YWlsYWJsZQ0KDQpSZXByb2R1Y2luZyB0aGUgc2Vjb25kIGlzc3VlOg0KDQpDcmVhdGUgYSBzb3Vy
Y2UgYW5kIGRlc3RpbmF0aW9uIHFlbXUgaW5zdGFuY2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBzYW1l
IFZNIHdoZXJlIGJvdGggcHJvY2Vzc2VzIGhhdmUgLXJ1bi13aXRoIHVzZXI9JFVTRVJJRCBwYXNz
ZWQgb24gdGhlIGNvbW1hbmQgbGluZSwgd2hlcmUgJFVTRVJJRCBpcyBhIGRpZmZlcmVudCB1c2Vy
IGZyb20gdGhlIG9uZSBsYXVuY2hpbmcgdGhlIHByb2Nlc3Nlcy4gVGhlbiBhdHRlbXB0IGEgQ1BS
IHRyYW5zZmVyIHVzaW5nIFVOSVggc29ja2V0cyBmb3IgdGhlIG1haW4gYW5kIGNwciBzb2NrZXRz
LiBZb3Ugc2hvdWxkIHJlY2VpdmUgdGhlIGZvbGxvd2luZyBlcnJvciB2aWEgUU1QOg0KeyJlcnJv
ciI6IHsiY2xhc3MiOiAiR2VuZXJpY0Vycm9yIiwgImRlc2MiOiAiRmFpbGVkIHRvIGNvbm5lY3Qg
dG8gJ2Nwci5zb2NrJzogUGVybWlzc2lvbiBkZW5pZWQifX0NCg0KSSBwcm92aWRlZCBhIG1pbmlt
YWwgcGF0Y2ggdGhhdCB3b3JrcyBhcm91bmQgdGhlIHNlY29uZCBpc3N1ZS4NCg0KVGhhbmsgeW91
LA0KQmVuIENoYW5leQ0KDQotLS0NCmluY2x1ZGUvc3lzdGVtL29zLXBvc2l4LmggfCA0ICsrKysN
Cm9zLXBvc2l4LmMgfCA4IC0tLS0tLS0tDQp1dGlsL3FlbXUtc29ja2V0cy5jIHwgMjEgKysrKysr
KysrKysrKysrKysrKysrDQozIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c3RlbS9vcy1wb3NpeC5oIGIvaW5j
bHVkZS9zeXN0ZW0vb3MtcG9zaXguaA0KaW5kZXggY2U1YjNiY2NmOC4uMmE0MTRhOTE0YSAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvc3lzdGVtL29zLXBvc2l4LmgNCisrKyBiL2luY2x1ZGUvc3lzdGVt
L29zLXBvc2l4LmgNCkBAIC01NSw2ICs1NSwxMCBAQCB2b2lkIG9zX3NldHVwX2xpbWl0cyh2b2lk
KTsNCnZvaWQgb3Nfc2V0dXBfcG9zdCh2b2lkKTsNCmludCBvc19tbG9jayhib29sIG9uX2ZhdWx0
KTsNCg0KK2V4dGVybiBzdHJ1Y3QgcGFzc3dkICp1c2VyX3B3ZDsNCitleHRlcm4gdWlkX3QgdXNl
cl91aWQ7DQorZXh0ZXJuIGdpZF90IHVzZXJfZ2lkOw0KKw0KLyoqDQoqIHFlbXVfYWxsb2Nfc3Rh
Y2s6DQoqIEBzejogcG9pbnRlciB0byBhIHNpemVfdCBob2xkaW5nIHRoZSByZXF1ZXN0ZWQgdXNh
YmxlIHN0YWNrIHNpemUNCmRpZmYgLS1naXQgYS9vcy1wb3NpeC5jIGIvb3MtcG9zaXguYw0KaW5k
ZXggNTI5MjVjMjNkMy4uOTM2OWIzMTJhMCAxMDA2NDQNCi0tLSBhL29zLXBvc2l4LmMNCisrKyBi
L29zLXBvc2l4LmMNCkBAIC04NiwxNCArODYsNiBAQCB2b2lkIG9zX3NldF9wcm9jX25hbWUoY29u
c3QgY2hhciAqcykNCn0NCg0KDQotLyoNCi0gKiBNdXN0IHNldCBhbGwgdGhyZWUgb2YgdGhlc2Ug
YXQgb25jZS4NCi0gKiBMZWdhbCBjb21iaW5hdGlvbnMgYXJlIHVuc2V0IGJ5IG5hbWUgYnkgdWlk
DQotICovDQotc3RhdGljIHN0cnVjdCBwYXNzd2QgKnVzZXJfcHdkOyAvKiBOVUxMIG5vbi1OVUxM
IE5VTEwgKi8NCi1zdGF0aWMgdWlkX3QgdXNlcl91aWQgPSAodWlkX3QpLTE7IC8qIC0xIC0xID49
MCAqLw0KLXN0YXRpYyBnaWRfdCB1c2VyX2dpZCA9IChnaWRfdCktMTsgLyogLTEgLTEgPj0wICov
DQotDQovKg0KKiBQcmVwYXJlIHRvIGNoYW5nZSB1c2VyIElELiB1c2VyX2lkIGNhbiBiZSBvbmUg
b2YgMyBmb3JtczoNCiogLSBhIHVzZXJuYW1lLCBpbiB3aGljaCBjYXNlIHVzZXIgSUQgd2lsbCBi
ZSBjaGFuZ2VkIHRvIGl0cyB1aWQsDQpkaWZmIC0tZ2l0IGEvdXRpbC9xZW11LXNvY2tldHMuYyBi
L3V0aWwvcWVtdS1zb2NrZXRzLmMNCmluZGV4IDc3NDc3YzFjZDUuLjk4Nzk3N2VhZDkgMTAwNjQ0
DQotLS0gYS91dGlsL3FlbXUtc29ja2V0cy5jDQorKysgYi91dGlsL3FlbXUtc29ja2V0cy5jDQpA
QCAtODcxLDYgKzg3MSwxNCBAQCBzdGF0aWMgYm9vbCBzYWRkcl9pc190aWdodChVbml4U29ja2V0
QWRkcmVzcyAqc2FkZHIpDQojZW5kaWYNCn0NCg0KKy8qDQorICogTXVzdCBzZXQgYWxsIHRocmVl
IG9mIHRoZXNlIGF0IG9uY2UuDQorICogTGVnYWwgY29tYmluYXRpb25zIGFyZSB1bnNldCBieSBu
YW1lIGJ5IHVpZA0KKyAqLw0KK3N0cnVjdCBwYXNzd2QgKnVzZXJfcHdkOyAvKiBOVUxMIG5vbi1O
VUxMIE5VTEwgKi8NCit1aWRfdCB1c2VyX3VpZCA9ICh1aWRfdCktMTsgLyogLTEgLTEgPj0wICov
DQorZ2lkX3QgdXNlcl9naWQgPSAoZ2lkX3QpLTE7IC8qIC0xIC0xID49MCAqLw0KKw0Kc3RhdGlj
IGludCB1bml4X2xpc3Rlbl9zYWRkcihVbml4U29ja2V0QWRkcmVzcyAqc2FkZHIsDQppbnQgbnVt
LA0KRXJyb3IgKiplcnJwKQ0KQEAgLTk0Nyw2ICs5NTUsMTkgQEAgc3RhdGljIGludCB1bml4X2xp
c3Rlbl9zYWRkcihVbml4U29ja2V0QWRkcmVzcyAqc2FkZHIsDQplcnJvcl9zZXRnX2Vycm5vKGVy
cnAsIGVycm5vLCAiRmFpbGVkIHRvIGJpbmQgc29ja2V0IHRvICVzIiwgcGF0aCk7DQpnb3RvIGVy
cjsNCn0NCisgaWYgKHVzZXJfcHdkKSB7DQorIGlmIChjaG93bih1bi5zdW5fcGF0aCwgdXNlcl9w
d2QtPnB3X3VpZCwgdXNlcl9wd2QtPnB3X2dpZCkgPCAwKSB7DQorIGVycm9yX3NldGdfZXJybm8o
ZXJycCwgZXJybm8sICJGYWlsZWQgdG8gY2hhbmdlIHBlcm1pc3Npb25zIG9uIHNvY2tldCAlcyIs
IHBhdGgpOw0KKyBnb3RvIGVycjsNCisgfQ0KKyB9DQorIGVsc2UgaWYgKHVzZXJfdWlkICE9IC0x
ICYmIHVzZXJfZ2lkICE9IC0xKSB7DQorIGlmIChjaG93bih1bi5zdW5fcGF0aCwgdXNlcl91aWQs
IHVzZXJfZ2lkKSA8IDApIHsNCisgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIkZhaWxl
ZCB0byBjaGFuZ2UgcGVybWlzc2lvbnMgb24gc29ja2V0ICVzIiwgcGF0aCk7DQorIGdvdG8gZXJy
Ow0KKyB9DQorIH0NCisNCmlmIChsaXN0ZW4oc29jaywgbnVtKSA8IDApIHsNCmVycm9yX3NldGdf
ZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQgdG8gbGlzdGVuIG9uIHNvY2tldCIpOw0KZ290byBl
cnI7DQotLQ0KMi40MC4xDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCg==

