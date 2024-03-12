Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB0AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rn-0003IL-Jg; Tue, 12 Mar 2024 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rm-0003Hp-6a
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rh-0000iD-Sg
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:37 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C8DDCU008399; Tue, 12 Mar 2024 09:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=CrtXx/4M2UghY85puObmOHvBiX4AAy4PiECX1DDjzCo=; b=sCNc3yeplau8
 +V5z2NEj+Q9C9mNVJIgO9wm41M4QjcQd0yiwBXcv3DROnbNdDKj7XXHvfwEMXN+C
 NONT/h2LWProaxznveP3MvJW6q2ApsT6T3lMMsJ+BI22oVAhOx+paPOMYvx5zT27
 Q4k6+L3JslSBHJKkrjx/4XtYs88DSIvGtFLfq+stBSnaAidb2CRZbc28XtbUDkgL
 YmrLlOYwjA5XEZf0LDCryKH3DM11zoKkZRyhCotBUNz8TdXG2IVwZU39QOxjVVb+
 3q5RkZyCO6kLSvgzg6PYrtW+XG5qttV/rbsQ9aIOQaM44ocGqGCLpqCzXon5uwZb
 Mo02h/LZDA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmyw6h14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=no1FSrd+sBWxyBM/mXhLiiqfYRr/fuElKCO8XY8reSBY2GNWtdEa6ThfoWA9Qh69xjp2N7VqoXUNl9INIZsmpjsmbs+74HHYuf1hKgO9a4IYKTCk+ge0FppYSjujbrNMy6WQs5lxknGjW+Zt2DCr3yfcTLu1WCkdv8LVI4iC89Pg2YHAq4dkNa17VqCp/FIuztalN7TWJY+TAlwm18ZQwy9i6+LPqXIe36AM0ji8COb+YYws0ZQPD2G8TlHC9bYBM9/Z82BvlPQj5lSWKWtJpTt7ZcueajQeRdv4p+B22TkUDJ+dtuDrxGBGDRZWSUj5DBJKtOLsM1ul4g8y7XQgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrtXx/4M2UghY85puObmOHvBiX4AAy4PiECX1DDjzCo=;
 b=NxrN/0HLASau84Ao9i/uYW2/QNGaHakVwqEeJ2I4JMqMSQus7Ht51ZHoWMkw/BEZw2i2mFzH5hM8S5px6MAnXxRY7mx7Tap5Kweax/zdnIMjWTIzXIxoFw/qNGqsvYgl8APig1IeOnrCftzWhxEoCa02ruNlgnOPywalnP4Rak1iv00+Xvwb1n1PcgG2Ll+A5tm9Tn65DtlkrR2MIv7ykiV+0JDF3zojgy43rDo4Zefa0NT4xv79+sXw5wYLFStaZjJ1PCsUL3IOxmg0qiCb7sqLPavE+5Eqg/Dxkxc3WczISraQ6/TwFPKbXEuuGMB1LkLJ/CTPI8Ijl+nrgW2E2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrtXx/4M2UghY85puObmOHvBiX4AAy4PiECX1DDjzCo=;
 b=D4HH3Is3IncGfV/0y0jcoAL1qDyG6f26iSpGv7gN0alNxli1fmCGtu5Pb3gJdRVSwXufcLTDb8adFhPuFvjYa/uHy/2JOouOQg7COyvZ9Wj2n8nUAwBxQqnF6a3qvZvAYX9pda9ozVf5IJo7VsEb4gEbBV1eiU6zFg4M7sPOvSbfTrOMN7d0DR9YjJufdwDltun9usw0EYC5MCCqtNIOj71aJQNHHfPGmJRvBPvv3CZY4Crv7iot5GhXb/ti02RhaoHX/6+xeV1VVi2haTaDGrLkb7vprVGypL1zJCHaI1EgOVP2Vph4DU25c0lFPFtTnJfm8nb3zWfpLe4+F03EwQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYXPR02MB10225.namprd02.prod.outlook.com (2603:10b6:930:d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:29 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:28 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 0/8] qtest: migration: Add tests for introducing 'channels'
 argument in migrate QAPIs
Date: Tue, 12 Mar 2024 16:20:17 +0000
Message-Id: <20240312162025.44212-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYXPR02MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: c940d823-df1b-4239-7866-08dc42b054fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNYk/REfcU1xdhdFt5C49gk2AqDI8Xd0WcRcKF0udnfTmvzrZMYVASrIhZqf9prgh30AGS6qnbR9c5u45yRvp/e284bFYvxAu/jbb9iM2RLqU1qG3x1WYwRd1zaBW6Sw+p5i+hPJ6xmi+GcRSRB5gdvrv0cgdHaDPN7HWPDHX5vfGTPl1SXVGz/xUcNpVqWR+yFG09Hzg7ZA4H0OiOn6VRSixzHXAq3UjQxP6SalxMh5Zp5lDEJK7YG8Z1eVE7an3D87VpiwitZ8D73G/QR/oqmo9EsyuSDuSBUkXKDIaxfVLmsKWJSnzsodSA9q63Y516H/FgExL9LtFmjIKyWy/Fq+EG0VrFK8bIL5MhpIu/l8kmz2P046JK5NbBITz+7ik5yYZl+g8SYKtYbrk1cAM802HFqL7tg6LGOOPQpkN2ygtU/9gDZpFdAANxC9lAwKfx203FxPvaqWwsXYmJcMLCKzpDSfT/uDJ2dGRC0SpkPAXklukHcaEGeGmGKP3LrfNnD1Xiem6h3+Kp7EH7DViypmgVvN9NuDegERu8ulqwyUMEpmCiLk+geWvXZczLqkQtUvfmoPwPY5fxelf/a1h7eDuLRRjnYRmX/VkfO6X6GcXYS92SvxncsOXtM6E824ZqPzSh0tlH5T1h2B7irAt12Rf6V+GzvG//QDzll5BbELGmcvzJQc3Mh7XqDiZTQD7OZkAI9ZcqT45libu/l+ZmJ13erQ2wPSrksmyE7Otik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qbefD1vW3FNnbrKgMaidO7e/3LHewCseuKZxxZ4PSinzrGn52IBRvEV7NKqT?=
 =?us-ascii?Q?xS+ojYPD5vyr/n+zJjBpIslzrZWZLcTrbT+ZEMBPKGpE1kTBudUsY9aAy0t9?=
 =?us-ascii?Q?6jjruCIYqX4dh6UJJdtNAGgrWHdbRf3ni79hp2PYRLG/E8nwAisZ7gV7f/XI?=
 =?us-ascii?Q?SuquMCFMahpBoGi6TFIhzr89vDfQUG0LeLQZ1tGLJoywUsFQPpsy8+nQvswc?=
 =?us-ascii?Q?Q9dcQenagH/QhGHmbiluRmow8kPGqF6HNvGt/n/BbI/6qsuWceA3lsGVv5/F?=
 =?us-ascii?Q?3ZKLyYcI4iXeBnfbp2JqFPjxcQoV08JcIhimR7Ko1uUKs8mK8yJw37byo4vh?=
 =?us-ascii?Q?7SzAGzPYjvQrDOhicHB+tlrrtBHeL/z22QCfjGjTYP1f4GDxWxIbC/ZVygyT?=
 =?us-ascii?Q?S2Dp7WNb8e6kcOWU8ZR5MFKrTTYUl4FJS0KtgVM3/cG2hNaqKmfs9Arm4ZnH?=
 =?us-ascii?Q?Af3o5eHWM+93A1olfY2VQly6A3+Oz8BLVG8XolPxOkov3WYbc78ecK1QvN4b?=
 =?us-ascii?Q?OuRijpSpCh+LVl3JXo3PUCFDRTTUxRFT9YyvTZtGXN5hrIM6J8iyhBLU36fQ?=
 =?us-ascii?Q?rwNC8Aua963+R6qRo6TTU3+kIiiwFSbw/IrA9M6vzoxthczrethbTFezxbTS?=
 =?us-ascii?Q?7xJZzFNrCA3YM2iZFCkzApIUxVAHVeajGxFKzcsmnlrZviqpdPc9sQBJRSSW?=
 =?us-ascii?Q?fXF+oNP/yyDO/VdnLU88Ggh8nFej9Hu0D5VxNiT6UOY9FQxBHDfqK/YtXDOB?=
 =?us-ascii?Q?aypjohBQ3yF2wwdmmN7fwKPR5DPaoPcLP6dJhhSNyJ+j5PjWsHMCcZdegKAB?=
 =?us-ascii?Q?26Qz++dR3QaxjUXhM2UqYwaI+yEqSBEGfGZnb6wQBfiqUNP1RQ3G1DPrfCOB?=
 =?us-ascii?Q?9RzogJIOWZJK0THReSPNdJX+v/OuhBjhLmfqVHl4rnTJXDBasfh+C6SV1R3g?=
 =?us-ascii?Q?yGLIsbQAn8pqNm9HYQpxKGStMdPRtd4X6tOBs+8l1DV/HkLNgtTICpXTzbvb?=
 =?us-ascii?Q?QcwUzYY30z5Zq5WlqjYLGWwfySKmwBStoSHLDlXnDobDGGUmM0EtGkuyFVcp?=
 =?us-ascii?Q?ov4z6xM2zectPY+EjFV3iELjmi3N7+KaY4iDcO0S0oLM5JTTkBS0ZLyXHvNb?=
 =?us-ascii?Q?cttwa7nEgWiKdsZflQ8Avt66TEIAyOw22ic7dgDD0xIwd7/f97GomYkfgPfx?=
 =?us-ascii?Q?4p22xiuJbQaLND1v+bkx2b3jGsHGlu/FbNzCoOPWhUibzJazFWDNk2dyE1fp?=
 =?us-ascii?Q?7/KqogvTiqlWdPDEFXXpyAVJUN/yeKdySVeX6AtRmcPh29/QGK8lrh5bs8Lu?=
 =?us-ascii?Q?gMqQYyRIZE+O5PVLHNV/SKNsk6y/uoiUQnsQvJqjnNTNXpQhetSloqME0Mvq?=
 =?us-ascii?Q?Eq6Px6jQNApnRefK4ky83u7FeZCzfBprCLNV30byZ29B8ITWewFD9BeGiedk?=
 =?us-ascii?Q?0nE993EqZ39Jx8g9jGAQXZfO6dt4aDSlJT7B3V7Yyg5oFxakAc/WcIKeiefh?=
 =?us-ascii?Q?RINS5b/z8vsrgk0oNxB0UGml/rsQcye64Oe2S0RjkoCYcuMJbHGA9GKnTHIQ?=
 =?us-ascii?Q?w64lI6ro5MwyWKGB7JRUhxP1QIj8FL1rSjpH7l+yiNY/rTeM03xZVGogWwX9?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c940d823-df1b-4239-7866-08dc42b054fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:28.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSupCRxHG89LQTpuzBmFT7+ISX/V5U6W7YFGLLOlzNqRpNMjLDEtNWtRWSL6y2UWvN00MrqbEbzEI1+S/qwO4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10225
X-Proofpoint-GUID: TGiSJoWh66_XEYTP8S-EZHDb3Xj9-Qos
X-Proofpoint-ORIG-GUID: TGiSJoWh66_XEYTP8S-EZHDb3Xj9-Qos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
exhaustive, requiring at least one for a successful migration connection.
This patchset adds qtests to validate 'uri' and 'channels' arguments'
mututally exhaustive behaviour.

Additionally, all migration qtests fail to employ 'channel' as the primary
method for validating migration QAPIs. This patchset also adds test to
enforce only use of 'channel' argument as the initial entry point for
migration QAPIs.

Patch Summary:
-------------
Patch 1-2:
---------
Introduce 'to' object inside migrate_qmp() so and move the calls to
migrate_get_socket_address() inside migrate_qmp. Also, replace connect_uri
with args->connect_uri everywhere.

Patch 3-6:
---------
Add channels argument to allow both migration QAPI arguments independently
into migrate_qmp and migrate_qmp_fail. migrate_qmp requires the port value to
be changed from 0 to port value coming from migrate_get_socket_address. Add
migrate_set_ports to address this change of port value.

Patch 7-8:
---------
Add 2 negative tests to validate mutually exhaustive behaviour of migration
QAPIs. Add a positive multifd_tcp_plain qtest with only channels as the
initial entry point for migration QAPIs.


v5->v6 Changelog:
----------------
1. Pass args->connect_channels variable instead of NULL while calling
   migrate_qmp for .../multifd/channels/plain/none test. Passing NULL
   beats the whole purpose of the test. 

v4->v5 Changelog:
----------------
1. Remove redundant imports from migration-test.c after moving helper
   functions to migration-helpers.c
2. call migrate_get_socket_address(to) and internally let qdict_get() call
   “socket-address” parameter to make more sense to the reader.
3. qdict needs to be freed, other small fixups.

v3->v4 Changelog:
----------------
1. introduced migrate_get_connect_uri and migrate_get_connect_qdict to
   both used migrate_get_socket_address to get dest uri in socket-
   address, and then use SokcketAddress_to_qdict to convert it into qdict.
2. Misc code changes.

v2->v3 Changelog:
-----------------
1. 'channels' introduction is not required now for migrate_qmp_incoming
2. Refactor the code into 7 different patches
3. 'channels' introduction is not required now for migrate_qmp_incoming
4. Remove custom function for converting string to MigrationChannelList
5. move calls for migrate_get_socket_address inside migrate_qmp so that
   migrate_set_ports can replace the QAPI's port with correct value.

Het Gala (8):
  Add 'to' object into migrate_qmp()
  Replace connect_uri and move migrate_get_socket_address inside
    migrate_qmp
  Replace migrate_get_connect_uri inplace of migrate_get_socket_address
  Add channels parameter in migrate_qmp_fail
  Add migrate_set_ports into migrate_qmp to update migration port value
  Add channels parameter in migrate_qmp
  Add multifd_tcp_plain test using list of channels instead of uri
  Add negative tests to validate migration QAPIs

 tests/qtest/migration-helpers.c | 158 +++++++++++++++++++++++++++-
 tests/qtest/migration-helpers.h |  10 +-
 tests/qtest/migration-test.c    | 180 +++++++++++++++++---------------
 3 files changed, 257 insertions(+), 91 deletions(-)

-- 
2.22.3


