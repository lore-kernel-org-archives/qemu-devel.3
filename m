Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWe-0003Et-HU; Tue, 20 May 2025 11:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWb-0003Dh-Vj
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWZ-0002Sd-3v
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:01 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCDUcx008785;
 Tue, 20 May 2025 08:04:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jAwuoWw+9SzG2piLB93WarEaEC1vEoduf8gYAZHPF
 gc=; b=EXt9r22xjZaz7zBuIzEVsem0sjxS693qJvHhjE7BxkbSB9VyaoiBQvj+b
 SN4/y1D4zS3YcwX33WQakK2yLhkb+P262lHJIyi6Rh35dp4CY76nTy1bBzAo099q
 y6NLC9iw/JgWJ4gKz1JyvMs6l3o3sfVrKKTzi84+WEuG2Rcqm5bhf0LHROA4+Q+K
 cdNT9WJj7HZCGRTNoh18hJ8h2fnvHQyor7bMNy24JPh8O5JmdvCQeRpN1+MN57PS
 I6aY/LafGQzloPpkl/BYvoznD4geXLLQ0dtmb+oKdYQDKOlZmxTjy1xQ/Lr3HpPM
 OuSkX8XaO6sg05UYQfoo1OcG5VjQA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46ppsuehgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgOveasY7U9ScSjb5+7jvz+h/TA/jfqSPtCybD+t3YF+5a/dIrusEEi/XFhrI2zmgFrxakUVfwbYeBPga/z8y5JnhoCCgPRO157VEziy9yQTvS5O0HgKPdoQdZbfwueJhdaz8TfGQZvC9fWmlsF97t2HV8BM/xfVRwX5xtKywZaSNVlcDmveamZnxdmyJc1ER1pqJpy/dc7ZZz7MgnL9bnxCbHrbKTxHpuZkCDOmKGWwpAB9bNc8hiKal6T5IjMv1UB8SKC5BVkokJVwURXU4cot+GHA4OC6Wue0luqlz/DilrO9R1Y+8jVv6z7Hf2QQ+96YoUii3vMVB73BVhSabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAwuoWw+9SzG2piLB93WarEaEC1vEoduf8gYAZHPFgc=;
 b=jVkozMBSEWwAfKV8DgcsVyXvLRBHRwNZYiXjjzapppDx/H2RCf1OdLGib8tAVyqppm6JVgx+flKU2VTf3BpRZdw1e2rZg8jFYeumCr3gLU32TNgZP94G1O98hnjix45jBlmcYXE4rbGkSyYtQDGJv4mEI+tzaIRLUA5e3cTSVim0Uij1nVIbKj9Om0uXNRpv8pkdkIS72G3UDTtV7QnbDgqQRNGcP3IB+v5nl+0dcg6tmVdnB9D0ebazBmKbLrz6Hs/+4O5W/c4SnOZxH97AiAusoqtE70qk7QElKfasYgDGbjpPMY2jwSH4WLBcihZlxDZUiep9CLA3fWbc5NHiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAwuoWw+9SzG2piLB93WarEaEC1vEoduf8gYAZHPFgc=;
 b=O9srAsu9DGiBw37JG7chrOOiRh0LxXFAP4mtLt2i/Tb0xJ9nLMaE9tKkHeo2Qif/txvOosW8RJzHHZxQFgvkmXIzcmPRQxmKUFwHeiQSh3edNYeshHUTgn+aURMeNJni1Sb/ickqcN5tfuURYYwDEMMfHZ8cGxG2oj6si5+McvEIlvSOW7ag7BohDwWYF9Y0ySD/KHkAPlpN+mIenVyNPP3arEsBSG9Ja3+CYc6dI4mZ4h4s9wlFv6N11m93Pqe0hjE/OAqO+1rQZ0vDUSADHQO1bkLfz3VfIRaZi39sDGLsWNV9lyq3wPODo5klOiFUQ5QpcWmavSJGsgdoyY4OgQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:54 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 12/29] vfio-user: add vfio-user class and container
Date: Tue, 20 May 2025 16:04:01 +0100
Message-ID: <20250520150419.2172078-13-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e5fae5-65e7-4e97-6f8a-08dd97afad57
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlpnQWpNUWVLdlFoMk5NMy8xRHZ6VHNycVVPQjJsZnJJVVJqeW5HOWZCVStq?=
 =?utf-8?B?QzVCV1NCYXMxSE1SS1FCRW4wZWtnQWp0QWZvNmQ2UzdCNE8xblZzbm4wNFB5?=
 =?utf-8?B?SmpvS3dmZFBnWlIwNHNEUmI1Vmx6Rmk0RFRZRUsyaWk2RnFXMDZWVjZ1UklP?=
 =?utf-8?B?eHYybUVWZ0s1TUJMY29ZUzQ5elorRXZjYmFGYmxINHF3VmNPelh5S05nRWlp?=
 =?utf-8?B?WkdoUmpWSW56VC9IN241cDc2cWtVcjhoY2dUc0F2ODEwZ3paQWRSUHNRbW9G?=
 =?utf-8?B?bnl3UlBoNnYyWHpzK0NDN3JUSlNYMmZqenVGd2lCejZUVkVscCtkeHk3RCtq?=
 =?utf-8?B?OWkyWmUwRzRkcFB1eG5JczcyVzdmV05nc2EyaWlRelZzcnAwWXIzMGYrSWly?=
 =?utf-8?B?VmhtOEdXaFF0SVNhcEtucUc1cHFoRDNFSmovL3ViN1NFNXgvYUc4MGNrWVht?=
 =?utf-8?B?TzBudzBOZkd6TSsxKytHNWdzams3YWdsQ0hYS1BnQ0txalRnaXZzK3dvNkNF?=
 =?utf-8?B?RzMyQ1gySENIR1NSQ240Q3RleWFwWVhzUUpTSHg3VTVwOVNSMFArWmlscWwx?=
 =?utf-8?B?cnlMMjJaaDZsSzliVVNVa0F3S1dLMXNhMXVBaEs1UUlHLzZGWEZqVEdHMVRD?=
 =?utf-8?B?NHFONkdnQTFtOWtZbXlVZ0pGSkFSNVRqaGFZUXZ5RXRqUkl5VjFab3dLRldr?=
 =?utf-8?B?WUpxVnNSK1ZmYVNraG5Zb1pLdFFJWEZPczBZaCtSTEVvZ2d3V3JvcWRTZ2Rs?=
 =?utf-8?B?ZVNSVUExaldCeXVVd2d6Nnc1SS9xQWp5Z0c2L0pRZVFPeTg1cGJKMmhESlVi?=
 =?utf-8?B?TWM2QVJETkgxQTRsUExGL2NlakJlQ3B3bXduZHo1bHp2YURVWHF6R2c5WVg2?=
 =?utf-8?B?Nmk1ekhJTWRFNXR3bmc2OS8vM21ZY1g0UmU1RnJmSTZKNmx2SEdvZmRGcC9C?=
 =?utf-8?B?d1d0UkdWR0h4SUY3RUdKVTlEdU1lbUFiUGhpdmNGcjFZYWt2YjE4UXd2WmZo?=
 =?utf-8?B?VER3LzY4c0VDTEwvcUYwaFZVaGx4L2dSeFlMWlF6aGd6K3owc25vZkNnbGtE?=
 =?utf-8?B?emZ6eERiVWh2Q3huZGZwUmpjZE5JTmZ6WTVxbE1LNmQweE1yYVE0K1ZmK0I5?=
 =?utf-8?B?WnY3YldHZFE0ME9HeXB6bC9XUUphS1BKcUdxN3k3ODZsTlN0QTRpVVc4Uk1q?=
 =?utf-8?B?VFl6QXFpOVNOZmQraERXS1BEL1Z3bXlFOXY2dXc5K2ZWOVJJaFNTNWU0ZFBn?=
 =?utf-8?B?SUpPMTFpbkRNMk5kZDZMQ3R6Z2VKVUdNT2hTUUxmVjI5NFZHOGdQVUpSY050?=
 =?utf-8?B?KzA0YmVOV0toZGxlbm9rbldwN3pXd0Vnb1JuSG9XeFRldW9GSEJzV0dOeGhW?=
 =?utf-8?B?RFJneTFxbTRSV29BUlRDc1BKRE14Z2JZNmFRMThLTGE0MU95R2JIYzB1aHA3?=
 =?utf-8?B?NUFGK0ZmTVdTN2NxYlpucG9yYzRHVFFHWW0yUXZDZlNnTVN2R1hYS0VkNkdR?=
 =?utf-8?B?VTFWakhVc0t4cEZsUnRoa2Fubk1OY1dwVCtza0xiU2YxeHpVLzVYemh5QXk4?=
 =?utf-8?B?OVUrZGFSR1RHeWNteGRtc2gzV3ZIQmF1Vlp6U3dick10SHdyNGFsWFVJL0U1?=
 =?utf-8?B?c3lzaUxMMzUreVVVNm1lWjdyc0l3OFRlZXVFUjFWQlZ3N0NjTDZTekhLMWxS?=
 =?utf-8?B?eWxsUXlTY3FtT052bkhUVExzNk1vRkczSWs1TS9TajRNTnFJWEpRMTk5dXJ5?=
 =?utf-8?B?MzJpSmJXODdadkdNQTg0dHhiY09WYlp6VEtkaHExZkp1OUoyVlV4c3AxaS95?=
 =?utf-8?B?bFV4WFJMVXhyMHM2RENWLzE1bXRZYzhSUm5ubUZ3bktoeFpuZzNpc3hNYzJx?=
 =?utf-8?B?akNpN2U4WjJ4bDdRcEtrcmZZc0crRHRmTmlzeXVnQ1AxL1NxcFI2NkpwN3Vi?=
 =?utf-8?Q?ialH5WvX/iE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlaZmRGdGN3ZXhYdjlZSDdZTGVuT2dXRGdPRFRkajRvTnJaaEIwUmo0dis1?=
 =?utf-8?B?ZHBXalhlMmFzUEVWOXBpcHY3WkxJdkwvT05heU5XRUFqNThMVVRYYlBpQ1lR?=
 =?utf-8?B?blZQeEwvbEdxMHJmak9icUpWQ3RWMU5XUGJrQ1MwQklnK3U4RDRJQlRoUGJH?=
 =?utf-8?B?YmJtNEY4d05FSW9ZK2oxa2U0N2V2VzNLU1M1ckpxT1laWjNydVRnc0ViZHd6?=
 =?utf-8?B?NlRJVHFiYnAxSVpqODE5UVExOUdMT1d4OUIvSFZoNUdNWXBDY2FWUTlvNnJW?=
 =?utf-8?B?UW1DdGczL09rbEUwSUpleTlPRUVnekQ2K3RjZWU4TzFRUnZ3enBGM2VtVXZX?=
 =?utf-8?B?M0Q5NHRZWGwzQWNOUko4WHI0ZFNIcGIvS1JTZU9McGdFeS81V3crcGgxQmlD?=
 =?utf-8?B?ODRnY015Skp6ZnpmZ0tzOGhNYkJyZVNrZFhwQTgrU2cxOVJpQk9uT2c0UVdu?=
 =?utf-8?B?Wnd2QmF0MTNBKzRpam4raUNYV0ZmS2JMOW9lSjdpUlRwSFdjQy9PSjRQYVV1?=
 =?utf-8?B?dHBPMVRkT0VaSjQyc0FJUGg3Tkc5dVFRY3h1cVdoZ2VzYnRPU2ZxelhZVCtL?=
 =?utf-8?B?NVVteWFwalhNcnY0Q2VSektzbnIzT3M1NFI5akxzSVJlbmdQUTlUdEtEcG1S?=
 =?utf-8?B?YVdxREk5UkNEZSttcUwvREJLWFJKV3NkZmhjaW1VVGJMOWZVeUJVYmxNYnp2?=
 =?utf-8?B?NWlpc095SGxtYjkzWEtCZzhIdEJYRytEVXZGeVZxQzZ2R08zRVEvQ1h0YU41?=
 =?utf-8?B?YWlJZjdvcHlHRVptNUlQS09KaFYvZDd0THJZOHV3U2RraVNGeW1iNEVsOXBC?=
 =?utf-8?B?cHJPU0Fya1N5YUhnQUZjdkMxUFV2Q2VjekVuN3RzTlhOV2lrckh1MlBlNUZG?=
 =?utf-8?B?MnF2NzhmM2YvVEtRcnozeGdhTWdhV1gvamw0aUt2N1prR0pGWDZKenYvZTB2?=
 =?utf-8?B?a1JhV21DejNDUEFKblU5RFBic3ZUNXhrMGJIWXlNUjRoOEJNOERGWStHKzJq?=
 =?utf-8?B?UTVDbno5TzVCd3I0Zk5QSEZNRFdUQzJoNzZpakI0SkllVkNhZFdROS9IRGFV?=
 =?utf-8?B?L09kM05WSDhJaGt0MVJVWldEQ3hpWm5mbVl5RWxpR25iOWFWbFcwZ0V6dzZu?=
 =?utf-8?B?cTVCOWhYWUdkSkpiTk5jUG83ZU9rVFNJanA3dHpWWUpJY010VW5rcmhhVnk0?=
 =?utf-8?B?ZmVXREkwQVhIS2pJV1A4YVV6MlYvdTloT2F6cTg2NzBkU2t4bHFOL3JnZ1Fk?=
 =?utf-8?B?YzhmVThUOTR3QTVMUzdjUitCSGZKUE1Nd3RoVFcvVlk4QVR5SmNBR2N4cWZG?=
 =?utf-8?B?U1FQL2hSK1NuYko4YXJLVUhwemswOG1zYnRnaU5MZG5Mdm1ZbEdVWkxpNmFB?=
 =?utf-8?B?bCtnUStYbGRZZGhncDlKWTJPMlo5bVdZZmNvSWFqMkZSeW1abnppN2RTK25x?=
 =?utf-8?B?UHY1cDJ4cU1YRTZWLy9XdXpwQy9sdDBQMFIrcW0yOENFNi9UNjdkOGpKVTJE?=
 =?utf-8?B?b0ZBL2hMOGo0WGhWaEpBdWR3Q0tueTZFdnpUajI3VHhHcG9CN1daUlFMYVp1?=
 =?utf-8?B?UnYvbmVmR1NnVDlsdG0vYnVkZm5FcmNxYmdEejY5RUZ6OGtBUy9JL1lxOGxw?=
 =?utf-8?B?Z2VOQmJHTUI0SmppZERIZU5RTzNneklNL1FvMEpWM1ozWXIvTEttbXZYMERS?=
 =?utf-8?B?bG1oaWpTMFpOb0ZnY3hEc3VqemcyZHZmQ2JNZ1pjQTNrY1JDNFhlTXhlejI3?=
 =?utf-8?B?eWdxc1hnQVc5M2UyN1k3anJXcmM0dVZhUFY5clhRRW5WRGY1Qy9EaU55dG1o?=
 =?utf-8?B?TXEyZk9jZmdQelNIRHMrVXlVVEI0QnZlZEtFSjJvUytnNUJYbnp0MEc3Mmoy?=
 =?utf-8?B?ZmVyTm5VQnVDbmlJSWN3eUszUjc1bG9MZ21SMi9MTWpsMzVmSlArN1drTGlp?=
 =?utf-8?B?M3VkNTEzOHB4bjhObmVrN3ZUYVYrcGR1L3NKMDFtdHpNdjArYzRuRnJXWU5o?=
 =?utf-8?B?WGhzQmU2bjhnQjIyZFVENXN0QVdnblRIUStKdHZHMUlZWkNCOTgwVHhkQnpR?=
 =?utf-8?B?TVUzaDlhWS9VUHdMSmcyUEtmRkw5ZG52MmMvdnk4cERXZGJnTXpvM0w4dVk1?=
 =?utf-8?Q?PfzcZlKkvwfPrN7kmGV7JfS4y?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e5fae5-65e7-4e97-6f8a-08dd97afad57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:54.1757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/xBoYshoJ0+MJxZkkIDF7QbvEL924Np/dfb1HmHKKQIbvY+tc1fBngy7QYQ0Hrvt88EVKl61tcWMGyADutcXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-ORIG-GUID: J9ib4PbxqzgFb9rrtIuxkUR1SOC1TgSz
X-Authority-Analysis: v=2.4 cv=Y9v4sgeN c=1 sm=1 tr=0 ts=682c9a18 cx=c_pps
 a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8
 a=Zlyvcu6OI-jkaoIL6xgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J9ib4PbxqzgFb9rrtIuxkUR1SOC1TgSz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX3rr8vOm79pEa
 x+gmRF9oNfEy73zaT6GyIwwwxmW70oEP4m4XG2xB2FUOkPyNbRxChW72eBdciw/i8EkBmTpEzgn
 e+X1RbThyySDbS0DVjuZNi+/dUGmloTTAAqQ9l6dis1Kl2f3T7rWVXJo4izYvURM4vrbMw8q2S4
 ZzfQCrm+J6qbuNjg1HCAM/G4BWyOuG+aIKEb5U8qhQG29uINIZ497HbA0G/knt+bHeVdtoQxt0b
 5PbTE1ctyZ/WQx+xcJbOgfIdMrOYmQOtYLjDySTuilueuYaXCKPb9FnBKwV8KaYwTAkiXpy8pQA
 wiFF8tVubo4Q2BX2Nxs9uRp2pAay8UfShdBLLHW1tqgjDhx+Y/9HfmlMZEKj7CjfUvQM3Yi/RuN
 a+me7E1PI5yY6G4DAgXa0Xf7+FS/9P6U9psPPz3NourdedeoNX7Tr8ZxlKb2MsZ9AFfRf3uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Introduce basic plumbing for vfio-user behind a new
--enable-vfio-user-client option.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   2 +
 hw/vfio-user/container.h              |  25 +++
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 212 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 146 ++++++++++++++++++
 hw/meson.build                        |   1 +
 hw/vfio-user/meson.build              |   9 ++
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 9 files changed, 402 insertions(+)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 71a7819448..c3d224e54c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4229,6 +4229,8 @@ M: John Levon <john.levon@nutanix.com>
 M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Supported
 F: docs/devel/vfio-user.rst
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
 
 EBPF:
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000..3cd3303e68
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,25 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c18986a621..c854f902ed 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000..2892845b4f
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,212 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000..181fe0f02e
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,146 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_pci_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe0..791ce21ab4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000..f1fee70c85
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+if get_option('vfio_user_client').enabled()
+  specific_ss.add_all(vfio_user_ss)
+endif
diff --git a/meson_options.txt b/meson_options.txt
index a442be2995..97d3db44cd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index f09ef9604f..2c5673769a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -201,6 +201,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -529,6 +531,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.43.0


