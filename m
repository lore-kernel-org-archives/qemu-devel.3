Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AD0CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQen-0001XU-Db; Fri, 22 Aug 2025 08:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeb-0001WC-E0
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:13:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQeY-0000dv-Cx
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:13:57 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7VuoR668429; Fri, 22 Aug 2025 05:13:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Ui1kLEz4fakmz
 Rn+Y1/LrF4ekQ59K/px4QfQxQRvao4=; b=UwMYPxbUI+XeZndWcvyktrogoXFV+
 Kyu4A5YXSzYaooZfx4b6aVyioQv4PcXPVNdPnPY2zCxcC89Ufw6s3RAZu/fhy+ak
 HeP1pG2YVkaMY5LTwDosJ6jaz87AKikXa6isCC0Nw5lopSXh3XGk0MsWpyyzAaoJ
 dVg+R1zxAvakVifYGa+1qfHLPekzmUQ1Puau8YPHeM68ytTWdsFEcqs54+hC/CzJ
 w51yeRy+0bkxVIoBDxzisauPP/wGvTZZ4tQ7tsEYHPuY5zELyDQ2rFAo2fRf6JEZ
 aQ9+0Psdgcp3aVScPY7vZD1PIVgreeDxMgsZyXa6JTo4kNBRsiOhDj7/Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2133.outbound.protection.outlook.com [40.107.101.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye8qdv6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORMpZNpcq5ramFUkep7qJ4NQ6xC+l/HMD/g0udF9jiOELLe8tMNKlGWoiEe2OtHMgbJhg4ddJH4Dl8yJXB90BiuWqOl4FEFAE+UcR6YsjzGskyCwOi7IJ+Hi3VLb28z8vrztjAoMI/qWsQlXyyZeRcPQlzzV0FqtKYBeZusypmqT/Vh955/GjpxVK3fP5cf4LNFnZbxrCKSiSSdOMp+Neh7rpPAr5NO/J26wTniijqHUXfH7q9xBCXr4DkNMoDRkqilabvc4Cnbloo5kvx6zZLww1611Q+R065RuGl/GLxKsFtTwuldZ+5YUY6aPNBOYPmL78yacD0FH4/7OciQZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui1kLEz4fakmzRn+Y1/LrF4ekQ59K/px4QfQxQRvao4=;
 b=qCrCBMmUSyq8aQW/sae4cgKMaa7el5YBx9IK/3vE3BKLZUc1QUEcniRxPtluWSKGt5jNZiUd6sGd4tr9+KNf1NUBn2yrHw1RKiXTuNs/l5bDJ9vB0eJt1axW4n9hn2NfnN8DPjiIlk5TDIBySODL0FSXTReZSy+XLMA30vhOkmpy1a/7sgZo+8r3ph1yRD8htryx1/khg1xoqayLs5rAOX6fh1UWLSXfUL7ZS0qcGHk4WdNRTy9Hb7hJYmxuGU2pOSEXQzhzH9yzumy6R3MOvJKXo32EHFXowFiecHYDn8Ivu8V0V3YzBxNxxtP7O7ZirZ21s5hfQY3HHkJ0DmF6nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui1kLEz4fakmzRn+Y1/LrF4ekQ59K/px4QfQxQRvao4=;
 b=DT64H5yFJlxUa+NoCqXS8/yTypk+Wc5sV5w65hyBSq1IuZTjyKdQ3ihxfRdGDz9hoz5MopfCZ1oFjU7UEaVrjZ3ia7e3/T8168O/kPaOGJkHq2SUitpElqDE6O9AfbKKbgGgYGORKgHjpfV4etxX5sdgxa4L+twvCcYm1fhrREZjOQ2buYyJsBczM+/xAZN11dvjssx62Z4VaZAdrBSNK8jXdyYiYa/BHvYG2fJh1GZtGnkGWHQ+kyD1FRh9/B+nmrH1US7w3idbcLp8eq+s9sj8hETCaBu83TTPuhgG40DvNedIkWbYhrBz1q3U15ZCcqfdJrWdFageRWlXILJGEQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6505.namprd02.prod.outlook.com (2603:10b6:610:34::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 22 Aug
 2025 12:13:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:13:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 00/19] hw/i386: separate isapc out from pc_piix
Date: Fri, 22 Aug 2025 13:11:46 +0100
Message-ID: <20250822121342.894223-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0061.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 384bf5ee-107e-4fb9-d99d-08dde17557bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0g4ZzQ0ZVMwdUhYdUlaY1Vpbi9NYmhlZTh5Z3hQcDJDS0tYcmVyTXZXbHVP?=
 =?utf-8?B?V0RjYmRramNrdHV0ckkvb0xQamNuczJWZFJ2Y0IzQy8zT2lPdFViNFozS1do?=
 =?utf-8?B?OVhFNjR3UW5PS05pSG1LR0FENDBvMUdzc3hzQnMyK3RhNURYTjNWRG1nRkNi?=
 =?utf-8?B?UEVZWUM0d0hEOUltSjAxOEFNYVdheXB0VlFya0dvcFg2YTllbDJHVmxBNlNZ?=
 =?utf-8?B?QkU4dmk4OUh2aXZYU3EwUE9oRGFMdjdWRHcvdnJ0VndFSHpTeW0xbUVXaGY0?=
 =?utf-8?B?RkVxSWUvNE4zdGhGNVVzcGtrU1U2SjRTWWNOS2FWaVJsNWVOalYxK2tuVUcr?=
 =?utf-8?B?eitmQlVsYTNXK09ieUloTmpVZlp3WlpHN2FIUTVHdlBHOUN5bTc4RmFmaktl?=
 =?utf-8?B?amQ0aXZMQ3g3elNWSnhaT1l3WXluN3AxOXpaNmhLQ0NhWUxYUjZmdVQvZjd1?=
 =?utf-8?B?cWRvQmdUNkxZeFNlTGdhYnpEWk9nWW83NTNiN1JEaENOM0ZVWjFleGV4TEpQ?=
 =?utf-8?B?dWlIRmJnQmlDWmpId1hCMENOZjh1aTBaSXcyTnJBRStudGl0dmRzNEtCNEJu?=
 =?utf-8?B?ZmJiNWViMHozeDhaQ1BvWmljVFhqbDFqNFVxUWg0RUw0SFNWNUc2eGFsM0NJ?=
 =?utf-8?B?NFFReWZQSXJJM1ZHZmszeE9TVFg2UkRJaUVEQUtTSjdQVGlHVmFoK0szM3Ba?=
 =?utf-8?B?TWgyQ3YrL3J1UTZlZG50WDJ2cFhpek8zbkZuT1lFMUJ0a3pLQjJxMUhuN2h1?=
 =?utf-8?B?VTkxb2ZaTUsxcUJ2TFl3bno5Y0g4aXJwWXhjcVFkeG56UzRxVC9IV1c5VjVG?=
 =?utf-8?B?RHRVV2VGTWZ4bU5pMlJmajZNMk45aVFNbkJsaVBjbXc1ZDRYaDFKa3FnNWxm?=
 =?utf-8?B?UFJvWkhjdFdCT0Fud21oa2xwTjRCUW94cUlPdDNyMytFQi9pcVArQ2hxYjFz?=
 =?utf-8?B?NDZ6OGZqYmVBS1FtSUw0MjY5bEdnWk5lSlEybmtHeFc5eS9QaDY4YXN4QVV3?=
 =?utf-8?B?MjZIcWNUcTVWbW1lRXhCN29HVDI5YitwdTliaXBqMHJZSUh1NitKcEdVejRo?=
 =?utf-8?B?ZWR6bG5NQjY2eFNHQkwvQlZYc0RCZVdKNmVMSXNveHJnVGhXZVYydEJnMEJ4?=
 =?utf-8?B?K3lYOHlIZCtBS3p3eTdVSWQ3M3VqZUcrRzJ6RmtRUGFMdk5zcUNmVVoxRnNT?=
 =?utf-8?B?K3dndm9FS3VDNDhUZW83Wi9xM21yeXVEZDZHaVhFMDE1MDdQM3ZMNlViOHNL?=
 =?utf-8?B?N1BNU1VJZEcvWXN0RDh4VFpoV2lsUU4vMU4xWTZiWVlTSm0vSy8vbXZZd0Ft?=
 =?utf-8?B?TnJlbEpURnROQ1BobHc5Z1ZxSkxxNWlrNjdXR3V2T2lNT0FOOUNPZ01JTith?=
 =?utf-8?B?cHQySFRBcEl2eUdCQ3RXWHpXSFROYkpzUmZETWVQYmlhNFlpZWVTUVVkbE9m?=
 =?utf-8?B?MHZ6MGxmOU5xY0NEUTJQY1AzRG1YZU4yZXI2cnhKZ1VmT3Q0Y1JMbzZKY09M?=
 =?utf-8?B?cHVQT25zbFZkRmY3bDNnQWdyR2VZdmgrL29ZR3dIbEtQMVlvRVQxMnQ0SlB4?=
 =?utf-8?B?bGM0Z0djOC9pNjg3NlNmYmhITU5SWFVOcUt2RHdLb00vRE5oVlkxUk1LYjB4?=
 =?utf-8?B?c1ZwS1lrYk9mZjI1OWpVdk1DUXh4QW9EMGZ4YitNVHRqdmJiM2E0WmkwWXJ6?=
 =?utf-8?B?d1Q4dG9sWmM4S2tjWUJCRmhnN2Uyb2M1emhLZVJlS1RWdVkzYXdIaG9tSG5o?=
 =?utf-8?B?YlpKYmMwTGdoRHhiUXdpZFVKRGJRS1B0ZWp2b0FKaHNSc0o2SUxrRnF2YWpr?=
 =?utf-8?B?ZDhKNE45TGE3MzEwVXp6VU1TVkJJdTh4NFQzR2ZEMGZ0bGpDL3pZMDB6WjRP?=
 =?utf-8?B?Mzcva3lhcGFBNkdvNUtyeWg2ek1tR3p4MVdNeDk4S1Z1bVl0aHhlanMxa3V1?=
 =?utf-8?Q?UoY4+b5i4+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzk0dE5oNnY0Yy92eTFDUW4zcVcrN045NmJPcHRDbHRZeTdBOU5rdWlKak1W?=
 =?utf-8?B?MXRwUFdBOWkzWS9lSytLOUtiUENWU2hqckp6NHBpZ0ExTXFYMFBQNTcxQjl3?=
 =?utf-8?B?aWkyTW5iZnRhbERvQm95N2wwWVNia09rMlZYN0M2UHJVNEs4K00vZnZUZlY5?=
 =?utf-8?B?L0VtQ0lQNW5kbXlwUkhpWmI2ZmZZbUNJVm5KOXVKTWVrN1ZjV3ptclZieHhZ?=
 =?utf-8?B?TTdhSVFPR3RMZDlZanlxUGh1TnhnVFNtU1V4bkxsRXByQURUeU9ES2NXVXFr?=
 =?utf-8?B?U1I4ZlRwSGxJVUZjQzRmYjhydlV0WFN0UHZkSHRVd2Q1emJKbDdpaDJWYXZl?=
 =?utf-8?B?NWUrOFVlTDlrK01kcVl0T3krVmEvbkpkSTFtMTdxSm11OG9BMHF1YUdEdkRo?=
 =?utf-8?B?S1hGcWxJamFGZ0Z0YzNkN2ZlR0I3K3Q2dUY1S1IzWmNCOHE0R29pdFZacVpp?=
 =?utf-8?B?N2tHQURBZXkrbkVJM091RXdhZjAyejVxb3pwOXhicER3Z2tqRHF4Z3F0c1Zr?=
 =?utf-8?B?ODRUK1EvY2V3eGgxelgzeSt1dVY3bEd4WHk1UG9rZ2RqbHY1Tkp2UXZMWDhX?=
 =?utf-8?B?dTNIWDBiVTRSSG9hV21YQlpnL2RxeDY0WEoydkkwZ1JHSnd3ai9PdmJUY1A1?=
 =?utf-8?B?YnNWdEljenpPdVZ2bjFXR3RiNW04bFdhTHNoL0pYcEdGd3l4WFJzTm4yWE1U?=
 =?utf-8?B?b241K1B0allXUkF6blM2YllBTUJLWndsRnBPNkpYbU5QS0xzRUpTWWRqRHBK?=
 =?utf-8?B?NDVZOVJYZnhvUVB1UlZ2ZGZuQ2Y0OVkxb2Z2aExCOWt2cGJxQjNodEI2ZjFi?=
 =?utf-8?B?WmErMlQxQ01uTlEvRE1sdGhxMTMxeFZRakc0QWhDZTF3eXF4d3BRTHRVVWcv?=
 =?utf-8?B?amxBSVRPOUxmU2dXN1BtUnBFeUlEWjd0M3M5WGdYdnRSb1JBbktWNHRCWHJJ?=
 =?utf-8?B?MkppeExpMDdHNFhNN1dRbVFTelpsUFNSVm9lbjl1Y3A0K2plWVdFWWF5MjRF?=
 =?utf-8?B?WDZjbFg3dHVKblgzYzFjOGhLYUxDQlBWUFptVTgwekZxMTFhM2Y0ZUtiMER4?=
 =?utf-8?B?NmVldDVQSG16OU1FdlBjSGdWZVY0ZlRFN3VaYTFDTzBFU0FVNFgvd25tYzhm?=
 =?utf-8?B?a1RTMHhpRG95S2tkYVRKS296THRDby90a1lQbC9OTFBuVnpzVWpWNEJ2a2gv?=
 =?utf-8?B?M1lOT2g3ZFVyOHo3TCttcURNd3FvenYxT1RFdU1BdkFSUHBIQVhWa2M0MmxM?=
 =?utf-8?B?eDVRK1FlRXBGR3BjcjRaVlU0Y2tCcm5TWUFacHB1ZlVsa1Rwcm9RK1pWQkZV?=
 =?utf-8?B?YzlMNHlRZkh0NGZDOE5rdlZ5bnBzWlZSdkkzNGNqUE5CbUxpUFBJOHFXWWFs?=
 =?utf-8?B?NURTYkRjZ3MwZkVIZzBCWjlNUk5YNDBXYXhpWHR5WktsZExvaFZvUmpFUTgx?=
 =?utf-8?B?eVlrQmV0ak9zN0sxeE0va3IrNFpZcG9UMTYrVUFVaEFJOXFwYkFuN0t4MlE0?=
 =?utf-8?B?eXV3TTZ3N2ZIWFJrUDdMeWxtNzVpaDFSZjFiOGozdUhiY3JEdkFZVWdHb0w2?=
 =?utf-8?B?Ujd6U3hwQ1dnS2xMTTNia0s1RFZwSXBoMDk0NHFCekxibTdGM3BZSUhjYzN6?=
 =?utf-8?B?RkZPWGJqTDV3b3VLRmlZeVIzOGQ5ZlNtbkNvR3RQblJMRHZSVWp1UzVYejkz?=
 =?utf-8?B?Q3RldFZxc0RmNUFVdEhlZHNKLzYxdG9lYWhwSXlKNCs0dFdNUU5iaytkOXgr?=
 =?utf-8?B?eE0vVW90U2hxZDlTTWQ1czB1ZjNCSkM1M2l1T3RRSlY2bkhwUHVoMXhNcE1H?=
 =?utf-8?B?eGhnOTZzeUlxNEdYTWxRSkw5NGFCTGtaYlF0bTZxVWt6NjhuS2czbDdvV3Ja?=
 =?utf-8?B?QUxqWk1KTjBTb3YyNDczNnkzd0o0S1ovZE4wWnVKajhSWHJoaW8yd0l1VStk?=
 =?utf-8?B?V3ZkcnZqYzNRMEV0c094QmhDdUx5Rno3M3pmN1VEVlE2dktXL2JjRUw1MStr?=
 =?utf-8?B?bHRMKzhMeHRQSWt5WUovQTJOYlJnN2c4U1dxSXV6ZkpIaWEwK2t0Z1FKSTFV?=
 =?utf-8?B?VWJKaWZtNDFKdHp4ejVKd3lmaTZpL1p0TUV5SUhjZ3E2YjZoSkJNNURibG15?=
 =?utf-8?B?Y0RjdXJlUEpHUnNvQXg4NTZWcWh2am01dUl1akV3eFBaVmk0MjFBTGtWRVl3?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384bf5ee-107e-4fb9-d99d-08dde17557bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:13:45.8093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocoPYfBitnZcLf8/e1dRXSJafz7eYMgzS0FoeueeudwSx5emUed5/BYNmrTLAQZLuruUuYordS7BkE5R5VtYEEP9ppqlwns3SLc2Uss5FJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6505
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX1fke5hs8oB6r
 hGE/xKTAvdnvbLU9C4yolWctItAxhNWrlH20gNAdSMO2SPdURnr+4D2tnxn4Gszqo18Lp7ZY9YQ
 Bx7em38KF+6nghzLtTkdrbPY+KAF/Q3Y9embUOagM0jx4RdFlfKzlJWrADhh+FIlMY0c9VBfjye
 sUaasejYkCjbijBdbna3MWqi9BDc1F/YX/4klnW/l0WZkdPwDxHnf6u/j4RKpu6gyJ7+BpK4MwM
 UceO6Q0lF7R/HH1UZqBV6hQj3XJYNjfEyXIGY3R6+FJdEQsLuiORxV9VXHLeCX2otfL/tYuka+a
 AovRsz0nWY4uuk5FHH+5GFgS3cHlc1GBRVhQH02qmj2Y5MtZ00zxei7yHh3jhfmbpJEHHEXh4bX
 vDAekJGM3iu/E1gbfdf3H/AHvP1Cjw==
X-Proofpoint-GUID: m9oOGBmqp1fpdhTgpaPucZ5KjuaAcRPv
X-Proofpoint-ORIG-GUID: m9oOGBmqp1fpdhTgpaPucZ5KjuaAcRPv
X-Authority-Analysis: v=2.4 cv=A7Y1/6WG c=1 sm=1 tr=0 ts=68a85efb cx=c_pps
 a=dwieEWGYNhQf9SbSAXxshQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=HUHtNuVqNzIun27e13kA:9 a=QEXdDO2ut3YA:10
 a=Y4I1g1QRc_YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html

(Patches still needing review: 9)

v6:
- Rebase onto master
- Add R-B/S-o-B tags from Phil
- Specify isapc max_ram_below_4g as 4GB as suggested by Phil

v5:
- Add warn_report() to patch 1 as requested by Phil
- Add patch 3 to inline pc_xen_hvm_init_pci() as suggested by Phil
- Add R-B tags from Phil

v4:
- Rebase onto master
- Add patch 2 to remove unused loader.h header as suggested by Bernhard
- Add patches 16-18 to tidy up the pc_piix headers and the pc_piix/isapc
  rom_memory variable after the isapc split also suggested by Bernhard

v3:
- Rebase onto master
- Add patch 1 to restrict isapc machine to 32-bit x86 CPUs as suggested by
  Philippe
- Include logic in patch 1 to handle the case if an isapc machine is
  launched with -cpu max as suggested by Daniel
- Add patch 13 to tidy-up pc_init1() for the i440fx-pc machine in the same
  way as patch 11 does for the isapc machine as suggested by Bernhard

v2:
- Rebase onto master to account for the fix in commit 0b006153b7
  ("hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine")
- Replace verbatim MIT licence text with SPDX identifier as discussed
  with Daniel


Mark Cave-Ayland (19):
  hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
  hw/i386/pc_piix.c: remove include for loader.h
  hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into pc_xen_hvm_init()
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in
    pc_init1()
  hw/i386: move isapc machine to separate isapc.c file
  hw/i386/pc_piix.c: remove unused headers after isapc machine split
  hw/i386/pc_piix.c: replace rom_memory with pci_memory
  hw/i386/isapc.c: replace rom_memory with system_memory

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 170 ++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 250 ++++++++++++++------------------------------
 4 files changed, 251 insertions(+), 173 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


