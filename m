Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A421DC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i7-0002Bg-9I; Tue, 12 Mar 2024 16:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i4-0002A9-Rn
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003AF-5d
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CHa6DV029332; Tue, 12 Mar 2024 13:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=C/JqRmNobknr4/8eTSDAHylm2OtQcsJk1rp1PiS5iAA=; b=h2pb1OfOZMd9
 mlFpddhwCD8f674lXqGYz3K5vAKmv2VM3MxpP5aRXWf5kdMxCI2EyTLhG3ABCtLd
 OaC/WHk8vsuWz0yKA5Kzai9PzClCEpJwJIpKm8ExTNd3FW/As2Y0NbeiSrorcXeP
 T8Ar7qdMFwU9n2M1ifT8ovV9idN4uxpcuN4TmOswCtDZ8/I/k0h/3c2PCLe7DeSV
 3lDpgOfxCDMksMN4IrHHcji2NGKn/uhB1GGyA3tE7GpWKL9VOtZJgGnWTTE87OyP
 xr9y8jznIz3dN8NjlyKupR07HDC61v7QDu0O2giV/6idK4XqyjzYL8UABmX5OFnr
 VgXFgP/Umg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqqhpvh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE2TxA5tcavnFut65p685sIzje5+pwX811L4mLM9K11nFqStBrBWR3lGjWpAMSad5plyA8Vvogt6sDupxDL14K812d6OEQFX7oCHgaCDMonA+lJvXzS82RaiDQV64aMjsC/Bo0T2WXozp++WukBodylC0OmrhoiPyZvs70FvNgNFZOslg9kN0nOyLRYRSx72BBfZtisqb/g/X/B2kTZXhURePTr8+PCJh0+R7wV5y++MO1OENe0GO2u28VTnASQFHiVxHCCezZpTXgbhFzk//iqhLE+10gF/oKyuKqPW13QgwiSHYu04w+7pBlvqRWyb91jB4GPZJL9jRyIkNT/kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/JqRmNobknr4/8eTSDAHylm2OtQcsJk1rp1PiS5iAA=;
 b=WwAK1lmcLUw/UJsr4JnqMNU31XQSWbH4iEZwzkhPQdm4pjNUeM/BeZp0QlZGarxFTXlqVOa0Ur2gqqslSZQuZsu5/OU63zbEfu+wSBfqMIgeBRmyVF9usncmhUW+wyJzo1eJ5T0M7dtqcORM63hLkfZuxVcfyVAHWxwoAANnTr7Z5Oo+dAfKtl4S/Ixua+f4kZ4SMXAbypJV8bfccoaarcSySO4p37st3NIYayO39e0h6sbsYSG/2aF8gVwcNyy6KquktS0PLkMFt3ynxHGTuxA6iOkU+E0KF0U772WTAVQctxB9sZp2gHfhEKE2bEYLyB/+5DmDLMYifxmuGJ7eaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/JqRmNobknr4/8eTSDAHylm2OtQcsJk1rp1PiS5iAA=;
 b=S2mTiJgS3LCeLwu88oR4/abNTu8BXcTLZO5DNIlsQ1BWKOuGfwxfh9VfEblG8apDvKlVoRyJItAj4dM1Gb092WaRKzdlqSSjbWYXDBP/F9IUEU/zFk36TnrtYaCM4ahVuSGuOgfia2LlPIvwvnJ08pdAeyqVyn/0SYBAZimjPUcvxKgrH3tKIAFa8ZSHoSQh90jbATfE+RhA1LsbT+pQmsGJ6QkrlfrVxoOVLYhgETFSw+7GPLD6HRvvtu0VcidGXIdnzoBN09PL1vrCBgW5438NooeUSOLqncKBoiByXI8z0meuJ8HBTaMwqbMzozGR+Kqs5pHYoQRAAcEuJ+oz/g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6613.namprd02.prod.outlook.com (2603:10b6:610:79::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:37 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:36 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 0/8] tests/qtest/migration: Add tests for introducing
 'channels' argument in migrate QAPIs
Date: Tue, 12 Mar 2024 20:26:26 +0000
Message-Id: <20240312202634.63349-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: f0785525-cd3e-445a-3bcc-08dc42d2b734
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQ7AoS+63VbGOrSCkdL+XWkslYkI+pzVpj81JSarckPS7ilNBb/gfaOxsZ4OPI57z9t0Fqrk6AC5Gz13Y2lE4hjkbN6xjiX0doUBbQkLLpzsWWets+nxgRNBKdoZQB+mfHeBzn6twXKlBIOS0PSfc+yyNtkAXv3awGR6bsz+kYWC/0/8o6PffuMP/Uo1B22m1j2AMXcmzt7p+Q8pAUjuvxVb3bQh0OySP8F1pSR7auRR7bQP9vXzQcsDWvhgQ601/Vkaz8KEmCr0e05MTV+zRfsNCoNUVhfhF28Gj5pDcWcf1nZlJIB169x8/kPm9YLpjx+2vMm6FW0BEW6AbvXWFBx3QZqmdvZOQAQgNfgv5Yd+il+lqJb/qUYGlM20/M4bQpeLIh/VQv8luyU9qqaNXyEAERR2pwi6TFGHbwOsj330cW+e3BYLiiTdJ0eZF7OcNSbH7GXGfPLGdB+yemciwUm+vIjtWQebJkahwYyTgqnYZJmtGoEMEgh9cfaDiY1Urni2Ja+czfB6PZP1VWH0iR3MdzhF+vcpabEWrRqpjxvUqJB9QMWA2h1mVOW4SybX6E5O7YE4p+qSdjo0c1QNjFmhnUPfL0kcEZ6JVs6GxlsBT/3E6vKBL8iqVsSXznBDBrFQnlnfH74CV1q0in281nSBP7EkVsONmYl1uQeL7t9B2MEXdhGZB5QT7lhbV0fGFvjOX/9rE4xL6dApTBtNNGk+UI7pQUc/4T88f/LgTCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pmY1ZnD7zRnlro3yTq8+m7RSBbO5lM+aE5Ty3ZI9PH23djioEccXjYjJDV7T?=
 =?us-ascii?Q?yx2kZQmotE5v5PLN91aYUEm9WneUvFgHKhXtDuWerDlBLe8f2p6Sz0+fsmjR?=
 =?us-ascii?Q?uNwppeSlfcBkoxrApdB8ug3KfSHoSUk+Q/bXFuM/8vl8wmcSkiSn/Z+U94jV?=
 =?us-ascii?Q?23iTGxWqE7J9oQFyhdomAqbO8H/jgxinTSwhiCSYStwe6oQJuqpdOUn7LmdN?=
 =?us-ascii?Q?liFI5rmQ+ATLgfI8qPdvoHaiVN2bLCD1PDYhqUmD8Q1K2gRbB5t52lzF2y8p?=
 =?us-ascii?Q?/tjIp4e6cqQa9Sz4zmaPEYtedkFRjQHZsINLkDe/hjsN3TEAP/ffCZnxvnUy?=
 =?us-ascii?Q?8XhGSDiZKZXL40kDEbSiWawVojHHe82NDuwkU3K6b+5jiZN0CxQA9HjydqQo?=
 =?us-ascii?Q?Ey4Qwf7S2fEaHt0+S1HnhynO9vqnz3d/NK7lGCwpgrSuiQVXlbaNdKlwpGRQ?=
 =?us-ascii?Q?Lo/dAtM4RSE27KMAHhxSJI3KM2JX2N8Ts52uftdIvchPqtS0q4mqLFI5/nFl?=
 =?us-ascii?Q?GhAb+kjSJ2LVKPdgV9Dqd+0ME9RQUAfcxl1zLwliIskLElygiLhXcs7UfWEu?=
 =?us-ascii?Q?J6LnDUf6vG7Nswcm7bgj3BLAh4lHU1l3xMOSZY7K1fJRpNxu2GfuGs/NGwis?=
 =?us-ascii?Q?UoYNiHfp/jNNmtnx/cZGoP9Q+LG30rDrQIahgXmzRHtnDZTszxXoGvMd36gl?=
 =?us-ascii?Q?DqJS//Tf1u1piM/8A1vX0D4k/qIBdoKOIPB+oaX4OI3ASNlmLI12aLQrIZit?=
 =?us-ascii?Q?N+ky/nH6pwpDt8YRv8ukqkRX2wEmK9E23WNXl1wf6Nul88MEw4feSYvu3Jal?=
 =?us-ascii?Q?kn1ImMUY1F320+yn5gJD0EVCaK4gme9OzvrjGrEBi8JIW3U3DzxZiWLCSQ0E?=
 =?us-ascii?Q?5aYiHqXHni1ErZTq3vMznVd+ghK15PagnwhJpf5EMHQOk+FrCI6hRinr8rAO?=
 =?us-ascii?Q?K0fssb/yOKJcUC0LNk1vcemSqIMD+rIPxveFhnwDRnhc0DqkZHbToYVN7XuJ?=
 =?us-ascii?Q?ESdHGZxchUWZkrWYXqV1mpqCwrWTl0WVeK4CcLT/5+LyC0GtqTbEVnxjYEQf?=
 =?us-ascii?Q?6HLRXwPnp4u7AM5TIdad9WKnllB8JmhA4YwIMGbAqAi3Nz0BV2Di+vgUfzRR?=
 =?us-ascii?Q?ioOv0+df0M7JPcq5ZfuzNHHFnrhKpyh+Aw3CB+s5cmPF8ak8nCEQR+flElE3?=
 =?us-ascii?Q?vvpyLd0UCBUr+qQweKdOfEzffCo/TRnDJiAmnMxMUby85dstk10gejtFBKn3?=
 =?us-ascii?Q?/qqhmITdKFI14aJpmILdWzpp3k5aY/2A1E8ktFae/hEiILegyZlk1dCAscUM?=
 =?us-ascii?Q?ycVi78aJC0Sr+A64XKpINy9Vht9UqTSdGORr5kplW0RRzRGPFQ36ocVCG3hr?=
 =?us-ascii?Q?mcFu/eEUhh2FQHGrpMSf9uq5v5SPsBN5reTDZDv1NyNUvrUfbDsO9tq2zk91?=
 =?us-ascii?Q?NnY3gEd3aXkKLm88stKoQ7OsJ0hG2Oe2wDnERZrshA/S5olcTOtglLDdChS6?=
 =?us-ascii?Q?kBq98qCuP9eM8DocDdbDsIRZBvy2AXpShe1+SphyNQ3ElW2mH42le3dPyCbG?=
 =?us-ascii?Q?ZgU8d+gZbnrm+p1SvlV6EKzU+WpB7DuRlX233Ycb+RShYGqSRtKP70lcrqBV?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0785525-cd3e-445a-3bcc-08dc42d2b734
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:36.5155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A280hmA9bjy16dYHimSimRXzAK2KlUgj/i6MVhHtRslpqKjHWoouyKM6CxozsdE2T2Vx818DRXMADliTu/iQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6613
X-Proofpoint-ORIG-GUID: 67VOT6xF5DeZGoqNTaK-lHOqQmAjDE8z
X-Proofpoint-GUID: 67VOT6xF5DeZGoqNTaK-lHOqQmAjDE8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
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


v6->v7 Changelog:
----------------
1. Rebased the series withthe latest master
2. Added "tests/qtest/migration" prefix in all patches.

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
  tests/qtest/migration: Add 'to' object into migrate_qmp()
  tests/qtest/migration: Replace connect_uri and move
    migrate_get_socket_address inside migrate_qmp
  tests/qtest/migration: Replace migrate_get_connect_uri inplace of
    migrate_get_socket_address
  tests/qtest/migration: Add channels parameter in migrate_qmp_fail
  tests/qtest/migration: Add migrate_set_ports into migrate_qmp to
    update migration port value
  tests/qtest/migration: Add channels parameter in migrate_qmp
  tests/qtest/migration: Add multifd_tcp_plain test using list of
    channels instead of uri
  tests/qtest/migration: Add negative tests to validate migration QAPIs

 tests/qtest/migration-helpers.c | 158 +++++++++++++++++++++++++++-
 tests/qtest/migration-helpers.h |  10 +-
 tests/qtest/migration-test.c    | 180 +++++++++++++++++---------------
 3 files changed, 257 insertions(+), 91 deletions(-)

-- 
2.22.3


