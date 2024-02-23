Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92A4C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXcG-0002Xg-IJ; Fri, 23 Feb 2024 10:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQd-0007KO-Nr
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:35 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQZ-000320-2B
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:35 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41N71Pdr007010; Fri, 23 Feb 2024 07:25:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=sotQX8HIWYl
 a3sYynVfGHEEQ0jAbT8vv6en/DsMX7sU=; b=Fv/Q/txXqeu05P0IM/RVXhUS1Vt
 kb0eYlmjyD12qJIIX5yr0YMVR+HE+A5KTuQWwOLxsQC77/BrcHTnLfzFUS97hdb4
 nhoNTACRVbhrqnpnUQv9Gd1X+obYf9PxfIxd66fPBhr+SKKL99FvvPIsV5ziJS/B
 5yLeIo+lzaowVanGX8PkPqlR3CvgYnXqMo12m40Zz0ZCG++cHn+8NNeNPNt+y3FR
 l/BXE4P6eM3DbT7wXHmiSIxDf0nf2Bf8WwyqOYQGGkecIjVy3pSzLkYORm2+BdoI
 a79l48FjfZQx26Vwp2d6Br/5/Dx+WONpALPh8YSW3Z7HdoZI8fCWaIkqgzA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd21882g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 07:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwSmonYoEl5RLDQAbcJUKi5g2YKitdPFijBNnfp/ldUkrVzjpXmhxOlINBKlLXev7U18vWodyPIei6nFb1SoTZSd3j2c0j0g3GJ7OK8NZLsBFi263zFpjESOT8de63DGQueTGdL9UC1efOS/9sNVYjSNsiQa74lTR5iglgzvI+HzLxqG2qCuFJTqGBaxaXYzYRauckIPvudWBlIF8HvmCP4NCdMkHmWV1h5Ixsbbn2+ALj96uazq/qk+r1tuw3svmRL8KletFJ3yDEc/XuPGcElrOWEOkmTPYKuZo56fZGxWRa1Q4NJAfYGJ0Js422lt0z4wCBWO6yRVltWKPcOTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sotQX8HIWYla3sYynVfGHEEQ0jAbT8vv6en/DsMX7sU=;
 b=Ot3bC5I58+EPxnh0c5eBfTfj6rNAccfY88EJTkE2peLO3Ga0jfj2NbElSRaUlylS+h98ivFvGwZRsGNEp9IPBCdeWRh+DzjCaivA7O2CR3reCCYzRB1tIFQBDVxkCbykCkQyM92O3gi9pJCTsTd/3DhAqY+9oIPl+0RfGAKhVLKCgl5X2L2ZP0/U88x6rRuRYk7Zyh2OcSiIN0uFbZcDwgbqF+DEW4CEEw6kK8vSGQYQn58QcRP/BrQr1WB6zdshKqFIkDyBOqfshmjv/fSMHHOZAfE2EOMpzPdUTJzRzDDEMJu82oolp+JWwlWPc2P31Eh8OAKy/GchYCg+veuLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sotQX8HIWYla3sYynVfGHEEQ0jAbT8vv6en/DsMX7sU=;
 b=Vv4nKC20dbboczXx0ES8G4uFcJqJWqYhHPtEgobLYGtqRnXiBZHuuCHpd3VQIEDqiXVUXHbhJV3B37Q7Fmj56+v4z6YmtgyZqAFg57hfhKMF3fkFaHAAHmoNiKKTO2Wxn+CVZQnBSi2Xjfl1qS6JYd03XwXH4UPm3wRxcoulNFqokiGYlhd7UNFz4XT6bQNKGtaWyu17JJcuXDCNjLfZtDFaGLoXYGc1zqay5lgZEWDLrNoTjMe05for+PLLbbyMt12bkGBA4YqjmZtzqWnco/J+L3gugd7pycBUAfLBWs0uizFK94nW9lQj/C5l7YDMauAzJeVTmhfzhR5nuy3wkA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 15:25:22 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:25:22 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 0/3] qtest: migration: Add tests for introducing 'channels'
 argument in migrate QAPIs
Date: Fri, 23 Feb 2024 15:25:14 +0000
Message-Id: <20240223152517.7834-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d4aaf1-6818-4216-7ff0-08dc3483a6ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1jRrA2AtBAHR2w3muW66LQkBh8QysumleGHYp4scVKeoBe6aNxrmsnb1R5YRcwLOxZSGLXOV04k6A5Ur6Dphap6VblPOXIf3CbjNxOkKXZk73TqR8p2pKKeJugW16dUa4KzjG4aGP8NAohyiSlwITc3ex8huB1/lcs9x42oRFJ1m/uhd5COZT2L17kB6h+LtK5d1vgTwyxk+XmWchmtlLvMCRQohHmlIPSCas98wslkS/rCke/xI/rMv2ipKUqoznUYs1w//Rxlv8DwNSRAa6t1oU0L8vXQr2Xt9nxqUR/ZotGvpvPg42u+xM210U+N8d+P98AZCFiMEPSl43ExPjKizG6vJYBcNeaCQ71OW57gr0GfzJUhqS9je6nEbRsAUcpl60Ctgbr4brqV+9rBPBgY104uozd0jlsSK5Rzvu1bLS/KWAyNz8uBFKy+f/Yh8RnwNuRFNTaYZFetRh479X7BaWv3j2LydmOeeaFbqiFvYL8mH1UWljJXkJt+TWgZf1misx2IdHankjQ0aVovERj4D2sv1yLtzVUowNY6AjIhRqgP2+EaC84tI8eZVi+izKoPTdVqe6J7EWQ7UVV1+I1gakCffRLpHrtWHZgrEMDE+09wIBpEFMgZhkcEtCZO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6fVZ+n+iOYaW0+Htonawx965Z4mB+77OzxGklvetPrj5Oyqm88tO4qvkLRA?=
 =?us-ascii?Q?TM8Mp+OeKCCud+OS3L/LxhJkCvDWR6YV3nnrAGcGzaWYzmGXMCPtzhELgDD/?=
 =?us-ascii?Q?/NgESOsmCa6p8NExuXrVj4jijCfAFVH8lMh4MPpu2CWYvirv18sNT1eWuhD/?=
 =?us-ascii?Q?t0U3vI6nuR0T+er4JOFLrhx5/7ZYqJ4CF8cKFhk8ZX5Nd00UM9blq6N/xB4u?=
 =?us-ascii?Q?0vsONtQLCdCeI6FFFER4nakJGx/arV4SKJVP69vziIayJtSn4UcTv/CPbEV+?=
 =?us-ascii?Q?pSJsTjfjwvnA8fCEr/Bgp5ie78AbWYub2xtWycqX8zJcdoTEV1/LaAbdwlxM?=
 =?us-ascii?Q?99aBOW+UY/p4VPVdt0Qj99e1eojXFAV0SJSvnDr4c+YH9czizwYbGHW3admK?=
 =?us-ascii?Q?D9BDyk1GakuF5bKoL/RAh7N8KjcuQJkpXfC6+GiBvnL3myZ7MIZ6YHKqAhyF?=
 =?us-ascii?Q?mrbSog+eHiyucqTBlutDvl0RvaXwiew5S0SLWXW6H1XBfvcTOtIpBrbeYQr/?=
 =?us-ascii?Q?BroqJnqyvIlVe3C2qTpXckshVmqeYq8LL4xTj4y+nvkixqbERTlSWUQqS/+l?=
 =?us-ascii?Q?hk9vQ1+53ihidn16A0vzjKYoGz23r1yCtcvr6rzPpg4db3F4mdjWQ3LMdo2H?=
 =?us-ascii?Q?L7Y4dDJtWtSpcpQpfsjUyrKETLSRy7aDG5qoGhxLj9mtLU5SgLHQSARsvGgo?=
 =?us-ascii?Q?aPz63dnwORYt0sao5drgD65C/rxBM9ntoPGsw6BSQWGI8/ZCqrWTSlaRSPHT?=
 =?us-ascii?Q?PFOj6ZHwaS41ClDZBuUDZ6ExKxH+rek3pxOxysiUWb1c0AKtqIURacihq28e?=
 =?us-ascii?Q?33j2F9Z1QWtUQaRJgaGmzB1BlEa8Fg7GoSsaRtClh/l3jjun1I0jdzgFJh/E?=
 =?us-ascii?Q?jYHvJ2NPZqVX3IbktEBx4k7p84QEhLWhH/slGQHhrrLGBE67a5ABBrhLBHpS?=
 =?us-ascii?Q?3hIq4oeRsWeltprs9f/vhSuz2YtE54ujsOpkPv3zA/OX45rjov9v4eHTOVZ1?=
 =?us-ascii?Q?FYc2rq/17ohD2JUWnWPJt8oQsCxuNtz9e6SlmObH5+fqVrioCGLBMneJDIog?=
 =?us-ascii?Q?qp1yb1Mr1pXNR6NWhntsg+Ed+U9wYDvd/DJQYABX+00ujf3YeDQAcCBdF36l?=
 =?us-ascii?Q?5zZXKphKOZ/sSvdjCyK1cneSGT0hgcUjem24ctXBqFvg7Sgvc5KoJzLf20QG?=
 =?us-ascii?Q?UAJ8SLFoErO7ZpxC1s9bUXydX2Z3hHkJI9oqQ0OfGuWkNRU3+Ih6SAxUv81Q?=
 =?us-ascii?Q?LMgPKBbJ9G5LnHCOeVLw67Psylp+mGic0OV7DVdfslFOOrATK+HzEAdJmx2e?=
 =?us-ascii?Q?3WX3pKx0vIPmzSiqRLdQeibAAtFyhG38+auKvy9xs4B4Yh+6M0HMdDji65kD?=
 =?us-ascii?Q?qMm1JvhX3hCyOrph+faXPWq0hlFdeu7v/P+sJpjhNNauCRCYjcX2RNxuC56J?=
 =?us-ascii?Q?MntxHmCz7rA23cpeL4RQ0Kc843o85TKFR1csDbA8YmADsA9HYRWUb3ZfCC4B?=
 =?us-ascii?Q?2tpy95L4S75MFX83lEMwH4I/JZh8aMLBU01UTvE14gIk88LEM+4Ep8cwN69V?=
 =?us-ascii?Q?tT5bYWMQ02nHXj5nYRIEzir6HMJ6VIYhCgizg2pv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d4aaf1-6818-4216-7ff0-08dc3483a6ec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:25:22.6800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pepxx0A17kG2DxcxoMjptGzZuAoJ8BeoEIoPJvV+J9GztOAHdj/DNfvNvMeZ7Slx4GeggQ9Leli3u01f58C2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Proofpoint-ORIG-GUID: iCH-U-gu8ITZqolZAmSWtlMx3NsHku7t
X-Proofpoint-GUID: iCH-U-gu8ITZqolZAmSWtlMx3NsHku7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With recent migrate QAPI changes, enabling the direct use of the
'channels' argument to avoid redundant URI string parsing is achieved.

To ensure backward compatibility, both 'uri' and 'channels' are kept as
optional parameters in migration QMP commands. However, they are mutually
exclusive, requiring at least one for a successful migration connection.
This patchset adds qtests to validate 'uri' and 'channels' arguments'
mututally exhaustive behaviour.

Additionally, all migration qtests fail to employ 'channel' as the primary
method for validating migration QAPIs. This patchset also adds validation
test to enforce only use of 'channel' argument as the initial entry point
for migration QAPIs.

Patch Summary:
-------------
1. Introduce migrate_qmp(), migrate_qmp_fail() and migrate_incoming_qmp()
   with 'channels' arguments and a conversion function from
   MigrationChannelList to QList.
2. Add a new bool filed - connect_channels and add two negative validation
   tests to confirm QAPI arguments' mutually exhaustive behaviour
3. Include negative validation tests to disallow both arguments in migration
   QAPIs.

v1->v2 Changelog:
-----------------
1. Introduce 'channels' to migrate_incoming_qmp() too.
2. Squash definition of connect_channels and negative test cases together
3. Add one more negative test case where both 'uri' and 'channels' are not
   passed simulatneously to migrate QAPI.
4. The common function do_test_validate_uri_channel() is modified, similar
   to test_baddest() - causing thefunction to always fail.
5. Add a new positive qtest to start migration qmp command with 'channels'
   argument in place of 'uri' argument.

Het Gala (3):
  qtest: migration: Enhance qtest migration functions to support
    'channels' argument
  qtest: migration: Add negative validation tests for 'uri' and
    'channels'
  qtest: migration: Start migration with 'channels' argument

 tests/qtest/dbus-vmstate-test.c   |   2 +-
 tests/qtest/migration-helpers.c   |  78 ++++++++++++--
 tests/qtest/migration-helpers.h   |  15 +--
 tests/qtest/migration-test.c      | 164 +++++++++++++++++++++++++-----
 tests/qtest/virtio-net-failover.c |   8 +-
 5 files changed, 223 insertions(+), 44 deletions(-)

-- 
2.22.3


