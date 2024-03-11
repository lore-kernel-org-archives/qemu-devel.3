Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnba-0002vY-Jo; Mon, 11 Mar 2024 17:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbQ-0002tk-Bf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbN-0003Bu-9f
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:36 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGo009722; Mon, 11 Mar 2024 14:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=+GDOf+Zj8cPgxJrXPP8e+h2BTn7UN8YWwQItOxAbcTw=; b=wZYPFEkvYIiT
 VL1MceR8VjFNEiGARu1QKAnhSGM+j99Wv7WuQTXv55mIaZkBdsJLLzwM9BK6LyK1
 DB4RD6iF3sebPZyhKP6PTIbgVzqPrDFAbfVQaax962djQdu+ivoinFlNpmd4IdIm
 /AU07ucT+0Fk02c8L9eRsBV3LqcC5ylPO31hMoTJLSufd4Uk1vU3Tal9rBITCFNo
 w1DFthrnm1KFGOew/Glw6XbErLC1Rzqdac5w29ym10oPTdiLWHS7GKdQX5GB79YB
 vnifh+J0LjHotlzLWF2/TZZ7NaqZXlg8Db/39YTmyOyWuM0pfaFfGT1APUGKSRzV
 rxDmeyIAoA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdOiJ1i9RhDK1SySv8QvfizvE56vXmvlNg094wRpuY1wzO+kqfKQyBs7UotxNozR/LSxJd+T/74rgobUWEnBMODzTqTrmwxg83WIZxZbJLrtBAMRt9+Vzp29GEsTUXz9M6HW/cYA56Lssz3ClRlMEe65TARnBWnbNrBCW2SvwHgtt1PFTidckqJYkJIjbm07a0hitjiMrEe20xD/pWl3t+3KaO6xy2YzR7ta3DEIgoNaFfr3FbuSmy8FStLtmnCDYYX9x5IoBEm7c91MTf67IqOCefdjMUYBToNJHgLsuCFeIjoNPfvhojryrXXchJF2sG96+ZmVFCMnJ+I75TVcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GDOf+Zj8cPgxJrXPP8e+h2BTn7UN8YWwQItOxAbcTw=;
 b=EIVjJUgNZe6ay3N1+VNSmV8VDd6Pd4R8SxXBH472jqKPDQAAL5I0Mv5koqKe2NwwA3l9Oj3P5zpcl6muCmDbQH6sLcp5VzQMelto/kLHGvoWvhcErhtZdXo+E7El49DyLP9XoAioO6nrDx70DLD1fjxLbLblCf4FClW7iE/Oysu1x5sq4dnkrG0KsJRZKzuwokmxmc4qIM20/NJieWERd4JRsWhCLp2Aq5ZoTOPvdeRLmKEsLeKbAFkhWl9IukVfBJeWLNaVB7udi0e1EHb1jmYxM8lmbSp5dIMbN4dC2/ESRrejMn602L4qxEQJVi1rlGJ/HZCXAnsxRsDB3r7W0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GDOf+Zj8cPgxJrXPP8e+h2BTn7UN8YWwQItOxAbcTw=;
 b=km3MjHajwrbg4KgrIg5BpLOSye8JlVRiJwzIhbi0FJ4YjzPruARAn+0ddnwktTD+maD8pFy127mVnevxKT3vL9ZaMxvrpwhfqEc4XkaedbYaU9sukETFlV6v9vXKW2Lnnbjsvb76ueP29n8/iXLuo7TG+L6qMQD0Irf3DSbFPBYYGJUi78KKfWCR6fMGY/hQlho2q6wjxRFFCwTga3aowZ/YjKXcTNlsgUviHsMEv5uwvjtlKAOZk3/m17gf5Ox/iVLD0lHjJ1c0Yo77naDemV4/Xdwyd0bNOCoU4HmJLnNWuBaYYV9vSn3taSXLpcPm8TB+ZhlXSmoR+f7VRQnWxQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:24 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 0/8] qtest: migration: Add tests for introducing 'channels'
 argument in migrate QAPIs
Date: Mon, 11 Mar 2024 21:53:50 +0000
Message-Id: <20240311215358.27476-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 42efbb3c-4d7a-4085-985d-08dc4215c544
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEc5HYr6/Uf+2M9l46dVFTOXpnBRCAKC7/nBI5ZSxd9xi+FnKMpJZCcFn3KdzCNFNJrZ0fTuROXsPm97Z9dPgwv2n39ua1/wu8kq5ToeD1llARr6ujnl7nnYKoKjTqDQMkw9tafujBCGGTBK0ryfGY42c1Fh1qPqMuTBoAHvGXV2WUcMeOpNB3jBne8g9oR2Amt3gEuNSubJJB5yjSchGIEhTrBxDWyxBgzSGEdbxwB4VLKbQ0Rj0FN5PTMnwBdV2F3hFHtOXQqI2xIKGZK2FAOfKOkjcTt48hws1fkvhapMvUvP7SFYbGV18KE1qwCQ2albV9gW3eYZdzlqqPbRlAIocs5tZEru0RQsSh6QHWs7UYcvZvfzTS/xnVihgLXlBtGZSWwLnByHae8bs0COqhhsZOCOnLp4c/Ds9fSA10tH3ONgaX2FetHlz2oWK7lvCeayN7cGER0KvNezMo0481DTiVMsOkV83mjT0uu8sUlmxymdB0U2xHTpawfeZfxCKVzex20i33z6hXxYewKAs8TYtE+KTWhPySDqKabnl1RpEE2y4+nIdLUBd7HDAeNkGg4wqsYgJZhwuEg0jRPPMbFMDY8W3ahJsJwHN6BobeQIvs+Te5TQztwu6I7YV0EAzexe3G7uygkA2Su95klqCX6hsnJqLRThQ9ZuAlV1qt2hlQl042V6ktBFE9eCmR0w+PLCJttO/75bCoCUO7xFiChCLk3nh4PB+ax0scWf/gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcFZuO0nMXSTKewDR6yF5PcLSZd3k3LJLBhwKEepxdQGjXwNTX8w3Bz6fO7E?=
 =?us-ascii?Q?gchbgdiZct77PdHygTZVxGtmdnivVh46v7rk/ltShZ1DqM7WvpuDvbaENXOu?=
 =?us-ascii?Q?/d9zypb6LsnQBaS9Dp/2YfU4eCD2rm3NUPaj5nMfKXs8Cc3SaLoyFnb20lKQ?=
 =?us-ascii?Q?pWHsy+89XMICuudrJlAxnX1hpF7OPU5oPR060e1gM8w6WI1xY/tmftxzTi6j?=
 =?us-ascii?Q?4T3l0rx9akHCBS2zCZk/dFlNiAyTeBtR8Cp7oVGwRsIymgnMW9nAV1uQMMrZ?=
 =?us-ascii?Q?6m8IkQt+5FLu2De4vgqLdBaeQqa7S35gPiLZP7s40HyW3CtEeodmVATyJLQ9?=
 =?us-ascii?Q?9awjyOmm7sLIdRJpAhLnF8ulJ7VaP3SVC58LUjYm8rymaq8Hj7eXPm30qjXH?=
 =?us-ascii?Q?rYZ2TIza/0mmLUUlbIeFSJrISY/rAlocQk/S0FfMhwp2pVetsQJrEcUhSkRl?=
 =?us-ascii?Q?i1YUF/L5Zy46Vo3xi/sQnWZ8dyUBoZ6cbeQtzEZQr/EB5brJZu6RnKryKw8e?=
 =?us-ascii?Q?plYurt3ZxSIx98suxCKF9aSle2+AMWQDTy7JdjUyjpd2KTtOLtLF1KYiGIWk?=
 =?us-ascii?Q?ssCvmBtJnecbsYyUh8iaAn2hJJzRFqSosN/rbPJuLKls7Dv67xDW+o7KMXe/?=
 =?us-ascii?Q?XO3wbjS9hZE/htf0booJHsJ7Cn/sxm4PwgnZopNYHsSAS14I4f6FgxIpcVGa?=
 =?us-ascii?Q?BqO/uEdCus4JMqvs9v0ZkCKswyYaAwSlJapKOyEq86Tt08TC5FWNWCT1VV68?=
 =?us-ascii?Q?DbS8JEsAr29XVbhV0jZ3De+/hYS/fLmMzFh/b/KqcoPqpg69bWh+cp1UTDxS?=
 =?us-ascii?Q?HNMNByx/FclNHNROuZgmG4jHe+znMjACXVRoVjlhqLAZOr1W88gVP2m6Z4rI?=
 =?us-ascii?Q?45NeYmyY2gzHyIffrYFjdURA3+5U06P1aCGhgVzRvC65JsX4IDuSIhe9JItV?=
 =?us-ascii?Q?V0JKLj8K6GQIIUFDWEVjntoy9SZl9fXtWDiMX0L8H/qNy8MczaCNJqN8YC5N?=
 =?us-ascii?Q?+6EVAPS6vN5CumNDe1S4wcRTNaKnSnnKaqFR2oeKWZXzZKxzrjJOcHtZuD2T?=
 =?us-ascii?Q?GS7PyFA5EUvrOIjyVk4kc2GFMgnY+QSq2lstAIB9AI7Wfo2jzm9YEiYbmdNQ?=
 =?us-ascii?Q?2cLNp0DRDelp/I4myJQ/7c98uGDKIL5JLqDT/dNW+47KloEH/3sLzy6Gs9vv?=
 =?us-ascii?Q?Hoa0qbtwN/KABzETZXGDqaDn3Thyu1VqM/6s3y91Zl8N4OEewJfP1aXKYjXj?=
 =?us-ascii?Q?0xUFWSi2KhUognm5oT0+jau8LtTwOuUuDSzAqFaFtiROxIz5+hoqJp4+Q3Sg?=
 =?us-ascii?Q?d6kEXxclf5VY6bgwmEXFRnv7iiXG9t+RegiHUScjDfHNoBdmp4gSnAL9oXnn?=
 =?us-ascii?Q?jTqEnUDwvUAnRTk4Di9Kp02MwmRCc3ds9xNeRNWbA8OOoh5Psks/ZkmuPpCP?=
 =?us-ascii?Q?4VHtn6Lxek/e70rtv45Gy1Lsa280QNeyoG2baAmLsxe05LPoFG8NyYi4byBG?=
 =?us-ascii?Q?v2koCe5JIUamaO8UB9+ELD2vjwkXR/eJqRALXQceYBWkA0PAnCQ9QWIGBrDe?=
 =?us-ascii?Q?Nvpb+RenMa0J3xttGp9yvwtGWBr1wzFk4yqjcyBb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42efbb3c-4d7a-4085-985d-08dc4215c544
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:05.2176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWMvL0Y+/34HY0zYbMxkh7gYZzI2RgDa2Fen4jVNQoZzr3hu+olPmnSgmbVXfh1+AN9ufgoReF0SObVvvlCMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: NLe5AcF6UBuUcFo0nijO0gfeoGhn7YvX
X-Proofpoint-GUID: NLe5AcF6UBuUcFo0nijO0gfeoGhn7YvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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


