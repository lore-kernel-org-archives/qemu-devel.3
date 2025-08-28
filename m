Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A470CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXJ-0007ze-4g; Thu, 28 Aug 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXD-0007vH-Oa
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXB-0004z6-C1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:15 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S6aJVI2725983; Thu, 28 Aug 2025 04:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=cn5GzoaGB+CMWRd6KFx+uxroBQLEoM1HgPQQHj8Kb
 3Y=; b=EfJyKIvc6daZcgJcNNnHkL2U4aHgc9fbQdBA0LrmGwGQQEbfrH2JwdOZJ
 CxpRajLO7Cls+aEnDa+3D7/tYXkSuFssqflbYviOjpUbrtJxi2anfxrDT1P8BjCl
 9/JGMWevXeSVLDEB6Is+5Lxn8+40iR7FkbN3qotwL27I7E73dnQveo5bqkGsm+3V
 MPRiTckDi0b7kfWFp1nbq5bux8da7Q/IUxsAfDZE62gHg6N+XrsJap53a9LvY9hN
 06KnSlD/M0sGO2pr2MO97/3H7kMr84tb8rZ1VUhG4ZLztYWZN0a7Vg0PGh00+byR
 sld3s1uA0VyVADR+gUefMDSKwvDcA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjswff-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQxJ2ka1U8jriZtOs7CcRY3FTHEDeKhJlX+yVtyZztugJYxcHE16nsKY/Ny/+8jKxnbb0mcZXl4o9O7bqXCYzSFx2x6K29zfV6bbtNbcDi0uVwdtvyIKguM8Snz2j88gfn67l2q8oYQqBJoAk25exEN4C/O8bPLq9E1DebvXxTZoVoZft2WUhydwRE1N+VrJn9tQ5U7rX6+DshM/AZFjd9Bo4ZGBmb1jP4VjpewMRJ/YZV/aXhtm7GtA2A9WKbcLRwXINekNHTJrg35NJBhBdC2cnkfl+HmEzcQSDf+s5dUbXiqE+07SJXsHlP3Sc+ynXbsDhDRqiWVUcbCCdsqIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn5GzoaGB+CMWRd6KFx+uxroBQLEoM1HgPQQHj8Kb3Y=;
 b=O8vyg5FM5evZ/2yJuOIz8EqNeyA1RbyHEjWJPiqJgtqYjkMpG4qnDNtsdMozEd9TzpGULWjiJq5DMc4Rb3L9xdMirhZiDnbJKK5IkGm8tCz+SJrR1/651HKcWL8tDPHrA/KOmZBw3/eCotziwvsRd/KG6P0CuH5D7Zl6Ec98RpQjLGTyJiPA8thAEX9Wfci1U8pU6dOdURj2wSAGwHLiA0tAwcI7A/A9kuTIL52PFfjrpSHQbgcae9XXLHTeakHclOTjsw7ZDNHjQdDld39zXr6mjHqDqDaxonND7YceD/oDrPE0UsM8gY88GUwK7IDygKJSyOIfvnBAaD70VtbTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn5GzoaGB+CMWRd6KFx+uxroBQLEoM1HgPQQHj8Kb3Y=;
 b=RO4/zvIZ691VMp5XVSPshL/DOk/9/SzT+K4qmGIdbZ+bTpBlyioicCaezvO3k4PM/7xojFcjCQn8OCkKA06rR9JhM+t+Qcsx+0Zu/PhEntY9jDX27gLm/Hi0Ht5xLG9nWxSfNmlZ4IWt1eRSYrQIXwxRnibUCo8u5ZMfing17PX9FJofshNYUZfuytGZXT1ulDg4JpPcmA5M06CKsNznlFkmXIThAOzfTQgPgKWcLDdXWmaQzSKfxck5sEi34CL7fqSC6xCmZgq+sI9rD15dhA44LlrdlTDq8otR4A13Z9VBikaeN3aQBX3BXBys/woj2GH6Dwq1DT6pzHkU9suq3A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8891.namprd02.prod.outlook.com (2603:10b6:208:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 11:11:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 01/19] hw/i386/pc_piix.c: restrict isapc machine to 32-bit
 CPUs
Date: Thu, 28 Aug 2025 12:09:44 +0100
Message-ID: <20250828111057.468712-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dac7b57-6f9c-487c-8b3e-08dde623939a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0dxVWpETGpmQTIxaEJieXU1Mzdsc1JMUWVadGpab0syY1RNUytHVmlWNXhl?=
 =?utf-8?B?WGJpMjBoQ3ZzbmFGUTRCTTgyNEpwdWdFNERkNXFrT0plWGNLRUduZDBQOUU3?=
 =?utf-8?B?R283L2l6OStsUVZCODFrQmFjTHVudUZkSnlhSnpCQ0N0OGdQb3BNVE9DRWZO?=
 =?utf-8?B?ZXNuNGFTK2VXdy9tbGdRWnUxK28rV1pMUWtqUzcwYTRiZm5UeEJ4Wlc0MFcz?=
 =?utf-8?B?N3B4aENRRDFXSUN2YWRxMDJiNy92Q1dJdUoxRWdha3ZTcmIwQTQ2QnUycG4x?=
 =?utf-8?B?YlRLclNTY1hWWFpXMkFOK2xZTTE3MCtVT2UrTHlGTHZQalNZUUs0L0dReUFx?=
 =?utf-8?B?UWR0T2pLbE45OGMrVzcrMnN4OFQ5THNLL0N0YjFJVitVVFBXMzFxMVdIRWwx?=
 =?utf-8?B?RFI0TWdnMTR2Z1IvSVVPcUZqUUZaenV6bk5ubHQ0NG1CVWM5RFQ5SGpBMTBw?=
 =?utf-8?B?SXJ5ZGlZMC9ONlVOTTNOM1hpRXBDVlFuOGJ6Qm9LcEFPbFRXTWJQbGZGWHhE?=
 =?utf-8?B?MnZ2b0t3RnpEMExmYmkyNEp5VmJ2MnZ1c29Nd0NlbmRZL3RKa204RzRrRVA4?=
 =?utf-8?B?NFBIZ0V4Z2VUUkZOYUUxN0hzZi9lbFZlK3MxT0FHWHlCQnZRNkY0S3RuUHVs?=
 =?utf-8?B?UVlsVVdxNGNjR2d1aFcyeVJKaDhLNFErL1RVZkF2emdNTWRDYUo4djlkK256?=
 =?utf-8?B?REVnRlRiblNWZ0ZyVkJxVXJ1YW5rZEpLNVRnM1ZkbVZIZ1ZEN2ZOQUw5U0lv?=
 =?utf-8?B?cU51bGUvcUlrRHNKYnZ5RU5KRzlJajczYmV0VE4rbUU4VU5SMk5wdk1Mankz?=
 =?utf-8?B?UElwOWZUcTA5bVBpU1B0dnFhWjlIRTEzQ1RPVUNZa2I2ODA1blduVjFlREkv?=
 =?utf-8?B?dmovT1daVE10dk5rNUJZUUl5R3BDQTdZMUsrbEhHeHZDcVRaT0FvU0N6Sm9Z?=
 =?utf-8?B?bFg1VTF3UUV5bC9mMUVKK2RKc2JZNGUvYmdwU1NUV0FqbmFPUlUxN1JOVUlV?=
 =?utf-8?B?eHV4ZFQ5UXBmTVFiT3liQmM1RmZKdE52TlJlZVNxZGwvWTBMWGdSS1kxbE5j?=
 =?utf-8?B?bStmL2hVYU5Cb1lzdXlpTlBnTjl5c3BNZnY0SklvU29GT3ppMkNlUFBLa0RQ?=
 =?utf-8?B?c2x6OWRpTnNSZUpsK1BZelhZWVhpVnZiZlNsVEc3TTNpNmg3TDM4UjArWG5B?=
 =?utf-8?B?aVBzcUw5ZmYvenlQV2l4THdMWFJ0NXNMZXBpcU5mY3ErNHBUYmpBNmwvSVQ0?=
 =?utf-8?B?czlEd0R3UUpaWWRtVm9laURUM3VhbFluR2lmK0pxMU5RcXV1N3F4NERmYUZW?=
 =?utf-8?B?ZW12am9HMG5MMGJPaTVUZnJIRVBGenU0YkhqZnlCNnhFM3hNUFptV0dBWWVm?=
 =?utf-8?B?ZXQ0RDdGeFJpVGx3eUxiM2JlQ1Z1dUZJYlZNV1YySVR4dUwzWUZ4Ull5NG1Q?=
 =?utf-8?B?Z1RFd2lpS1VHV2Z2azBTLzl4UWRaS29oblNHNUxCS0tNeUE3S2VzdUE0VXpx?=
 =?utf-8?B?YkR5RDNqVFg5cTY2OXdaMSt3clZlY1NZNCtjSVJUTTJaampjc0VQcWppYUVK?=
 =?utf-8?B?OUM0Qkc0U0tGSXVRWEs5SUNWSzZBREladzF2Nnd0MGFrNWc1UGcrVVpxeXFh?=
 =?utf-8?B?cXRMZUk3QnJLRDZyVkw4N25ZT3J3K2xWZ0p0M1l2THo1NFhTUFZBWEVOd3Jn?=
 =?utf-8?B?a3dUdlZHZUFRQnJGd1dSemZhdkpQV2NwWXEySG1Db0VoUHFGVXk1KzljdUtD?=
 =?utf-8?B?WDlKd2NxNVIxR1dWZ3d2Q1g3cExyYmNmcW4va1VSZHJZaHAxTG45STl5d3hC?=
 =?utf-8?B?cVpoa1Y2TlZxdDY1N3JPTjNkT0pTc1crSzlweWl2dXpiSzM4UU44ZndwK2ph?=
 =?utf-8?B?K1lqSFZhMWNzRC8wNnptdlRxZmNxNFphaGh0TWsxMmxEWDJ1TmNlZ0R4aUNr?=
 =?utf-8?Q?nmnUPwbiJzk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enEyNkhiKzMyMktCbFZ4bWdDWkFyd2NPYjIvSXhPbENyZUFrL0VmWXVGTXFr?=
 =?utf-8?B?dFMwZnIzeXFLYmlRWnM0VjVjSklLeTU1V1R5K3E0eVcrZ0s1dFhtUXF4KzZ0?=
 =?utf-8?B?cHdIQ3FWcmJ1UjFzREtCRnRCN3hZcTRWNDNVTTdJMUlRbVZjWFprY0NMYTJV?=
 =?utf-8?B?eHhmZVNoZFljNkF3UkcrcWJmcDdlQWtVMDJxK3VRbnFSV0NXTzJFeGlVY3Q0?=
 =?utf-8?B?TmoxT09jSEdXNDZwM1JPWjRjN2Q4RE1lb1AvT3BtNHd3ZEZaaFdRNUlXamM5?=
 =?utf-8?B?Z0FhdW4xZmtrTUNqenNwRW9uUWZIcmVZNExNL1I2djRzTTZXM3NDNVVETWhu?=
 =?utf-8?B?VndvaThHQWE1VTJ1YVd5Nk12ZFpadE5IRVRVZzVQWWI3Nkc5cGF6Y2U5TGJa?=
 =?utf-8?B?bzNzYkY0UDBjWVhranFERnBXdzF5bUpvbEVHUWp3YzVBaTRwbzdpVi9wSHNW?=
 =?utf-8?B?STFlSXpHZ0g0cnpETXpIN3BFalRMWjZWSE9SSmhZOWxrRTN5anh4dVI4bFFt?=
 =?utf-8?B?R1BWQkdhMVF2YUQyaEVrTUdIdUNKZXZJWGhWMG9oNEZOUXBSZ0p6K3pxZUE0?=
 =?utf-8?B?RnUzZ0I1VytQUEJkQzdHei8vbEp0QitJWSt2ZXQwN1VmbEFDWDN2dzFHMkJx?=
 =?utf-8?B?VXVtRkVENXhoRXBZVTFETjFvUjZUaVh0dkVtQTFiaHptZ2M5c2pDSnhPRm5s?=
 =?utf-8?B?Rmwvb0pXakpzODZuZHdYbHJTTUkvbjJrMFFVTWc4cG1BWkJxVGhIN01ySHJG?=
 =?utf-8?B?eXJTUWI3V04ybGYzS0ViUGljeitCdlFmZ3AwQlhXRnRZamhPdVMzN2hMblJY?=
 =?utf-8?B?MGdZR0pJZGtmV3lnc3RNbDA5ejNhdm5jSUFxdWhzYjhNM25XY1JYa1g1VTJa?=
 =?utf-8?B?Mzg4clRvY2kvdU1QK2w1Vi82azczTjREYkxUZUxGUkhmcG1JQkJkMWcrWmJ1?=
 =?utf-8?B?QTl6WjkrclpHdm9WTTFLZlQyT0liOWVrSjI2akhMRW9VeEY5UHBSdTlLK3hI?=
 =?utf-8?B?dVh5bk9wb1VHaU9TZTY3allFeTlGVHlsNnpGMndsV1hscWFWV0MxTE5MRXQw?=
 =?utf-8?B?WlYra3FmTXZpQk1sYXNUbjV1T2puVVM2SjdhYU1DRlluajZHZ0srdkZqTGdn?=
 =?utf-8?B?RnVUeDJid1hHblNLRkdyejU0bXRxZUxmMXFBamRtTmxyUkVsNDNmNTFWekQz?=
 =?utf-8?B?cy9DUW8xdkwzUmRxRjJtN1l6cXZ0MndVZW1pdExzYjNvSlBzNEVRN0hreEVR?=
 =?utf-8?B?bGJYdmd1MXQ2MU5NYjduaTNEemM2MzdYakhraXUxK1ZoSU9NS1lZTFpiTVM4?=
 =?utf-8?B?Q0NtcjNsT09ZRXdhVldlQmo3enVQNUtxZXV0aFpScStHL2NWTG54endRN05x?=
 =?utf-8?B?elY3cGEzN0ZKakt2Z002bW9obGVWeGhuVVFzVitXTCtQa3BOcnBUYzJkVjJP?=
 =?utf-8?B?K2dnWFdQUkJDYnlwVmY5KzVMNTYzNkJ4OFVvMkxieGNFTml2STdoVFMzbkhy?=
 =?utf-8?B?KzJFcEhJOW9NcnpsQXE2ZU45eTZiajk5aGhOa1lZQmlVTU5qVVJNT2trUUhW?=
 =?utf-8?B?VWMvbVczR3RvYWdVSTN3VnU5UEdZUFhRRnFheFhjblFwRWozYllMVXF3NXpG?=
 =?utf-8?B?Um9KL0NRV0JERFZPVjBVK0RoK08vRVNwcHdUTHJ4UEk2MXRSekE0ZEY3NDE2?=
 =?utf-8?B?YkFWTGF4QWNwczJ6LzJBbXFtSlJ6TTVtRlgxYTJOZGg5RmxFUFNveHBwSFlM?=
 =?utf-8?B?SVlnMDNnN0thVkVXTGhOaEhIUk1nbUcyWlZabytkVjlYN0RjR3diejdMQmwx?=
 =?utf-8?B?bWlvME5qVElXYmlxSXFuekZ5aGtFQ05QR0RKeGRhNkw5S25yamxNaUhmcTNv?=
 =?utf-8?B?Rkphd3Frd2trSWRoRnBGVE5sdnVvbnpDSERaczQySnk3a2FWRCtXNXZZTW5R?=
 =?utf-8?B?eDFQR2NxOGdsN01iYWYrU3h1M3Jib3p2bzc1VkpMZVpjdmVWb3QwVTF3eC9W?=
 =?utf-8?B?S2ZNbjl5VHhPaVQzd2FNNFBMMEIvNytiU25IcjFoV04wZ0o5L0tNZFpJaHUx?=
 =?utf-8?B?ME1oTmF3YUtOZkRhQXN3NGNwMXlYa1BlZnB4YXBLYUVkUTMzU3lCNHFnTHd4?=
 =?utf-8?B?UFlaY3JRTWQ5czltU0lJOTVicHhhOUY4VGNyM1VZMEcwK1Z3VU1sRU1uemhV?=
 =?utf-8?B?aUhzdC9UVkg1c2JPYUNwU1BBUTZocG9wd3hUY0gybU1YTXc0TkcwMzd6TmFH?=
 =?utf-8?B?RXFUaSs2WXo2TWUxeDVMKzV2WEtnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dac7b57-6f9c-487c-8b3e-08dde623939a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:03.3834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1RtsSZG/352wLVZl6RLLqoRi4qdA1nds07MervLsbOmlf9+uhM+7ixd4B+2sZBescqVrc/bCWXxG9BQivltQPQDBHl7TGnXTNL8l0Tl69c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8891
X-Proofpoint-GUID: WBLYTkIvo5JmX7qx8FP08C-MZ-objjJz
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b0394d cx=c_pps
 a=c0qqeiFHmtsfDSKKRmqUVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=9Z-VKcTvWNG3FDJRCYcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WBLYTkIvo5JmX7qx8FP08C-MZ-objjJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX5dYi5/jtasjc
 bw4QU0/5yMHXIZ1W9WcYI7mBDlTatkfp6DYKMesc3fjBl7+l8o154HlUxuEiV2egxC8FDfKfhnM
 kajJ0GtouJzUPCJ6A/zyikaRVWGQeWYdIVTpkFawZwf8AZeXckm8+DgQJ+a4fiY55mlcnHx/LZd
 i345f6VWsUJ0eEN0SP9Yl2CUQbFNn3DyldCWlB74qwnPVRrg801XRrS5gMkxz3i7vxk0SsMr7Gk
 h0EL8/ilmrxiEseNNoucyAnhjdDwei1K+1LP1oOFvp0IbAGt+9CD6p9Hqi1SHK6QEmuCFccUnT0
 5ny+w6L/SCdhYZBQz2KWeyjHejY81jsSmvPXZRu0iYMgHfqaFQhdoF7d/eVo6k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses either -cpu max or
-cpu host then the "best" 32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d165ac72ed..8f5fb3cf90 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,6 +436,31 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -815,7 +840,20 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -828,6 +866,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


