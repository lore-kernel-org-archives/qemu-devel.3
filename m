Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CEBC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoqq-000625-Ik; Wed, 06 Mar 2024 05:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqp-00061p-HA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:19 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqi-0008Rd-Lr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:19 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42602MYL007375; Wed, 6 Mar 2024 02:50:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=zH+lDpqsVWy
 iolSuxhzr3qaS9fJij0CWwRw0pTnYeyM=; b=tqALB4iAa+aW+90pfnXmb+6dqjF
 W3qyZReUyGbhAdDASG75bE/77zq8vymCKEnRkZKXLTvQSPG5hrC8VrXq+xoACTua
 wtWoSNTPMAgFSSIR+QRx0KuwmXO34+k87broIh++x7H/ZDCUZnFdVXa+ZBaHdMC+
 DKhVZBnJpuCUwSjAAor1/tdxRIokispH8OgnaMtS21Q4bUQOBlCOu74B6ESznEJF
 +v1ku9sIeGTiKfTuo2lC2SNMeWKeaxD3OT5uwXJ1ALRZTQHMduaAYIUdMnZlN8Wa
 TSImeohysiYltJjz0U+R8zr3yN6Qbx5KFNy7T0gaW1hUzx8kb1lW0N+9xBQ==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hgg5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZRPnj0Q+WWeqQDL4TuANFWmUo51ysY5zIkNx63o/KtV/RG+/taE4UlvDmptptvGiEnU1xkB30McIt3WGcwEbRCy4Io89CMReqTKmGlCexov/sE7e4LKGa5RHDAQQdz04EcCNMFSmHpkQf3Wy2IdHglTZCqyfcBWpIddAgESAo9GVLd3Qq7afSsDnYSn6itKsuaAx9DSfAXXxYHcZs3yrQYvEsSa4EYszT1S7ck6yo4rW1+0aUGkgG+YFZm80Pt+BHWGRVstpS9GPCfeiWZtJHOTQdZLLyOsVGiKJm5GVTFiLuLW9hmPygBGpFhD/y8LqP0nSAhXw5vUiuV4Zz02sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH+lDpqsVWyiolSuxhzr3qaS9fJij0CWwRw0pTnYeyM=;
 b=OLjpwzMMOyE48Deq5qIo9RZiWJxZd0j/R8cL0DwW19DiF5Mj0GUsKKOypz/bAbiGVNYfZSqwhobqIp4opDKgeueBiv4p2QelrV6XLsSalJ8SPDUMajLvAAU3QiLcyd/U28j8yvMPF1gSxP4VFzxLQuXMxp4jzLydvoGMYnWFcv4BfZs3+cPX+b3LCBJ4T1iMvNBAjL9PzD2HESkDJEVgyOkQQfnA8QmJ+bCuovd/O8+BZrF63ToTvhno8dxuXku2rOfNK3xs/0IPY+NxsJ2kuYptctuVy2NXEpVuNnfgp04XwoQS2gwEV2BJEYBOGhJcohgEM4oCmeXBfttXMD0x/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH+lDpqsVWyiolSuxhzr3qaS9fJij0CWwRw0pTnYeyM=;
 b=UZajKsPjyKuCQBv97GZNH0FB0Zv6Bg+DVwOjSVruY9A307dHQStpVvdDOcnn4h4mvx/DAOWWvtKQwqNdAWViKWkmsAwrgnJzQaxov/MljpZYbDNtAmRfybp1VVph8UzVCHqq1Rz3LJnGzd3rmCRjxVmSdngC2ySSWAX520QbGQAuwq+IBZzh2TSK5TayS3DVy15TsPSQPGgKXq1i7UiyQoUKmKMRf2svz4k0FOTCiKy2Hh/0auYEdcSv2lc9ikH+j0613IwmUXjPuSfWTmXYzDYmzKwIp/hMtaifSeLsjC02fXwggf272O4LjyDxnQYXgHLpsSCgPGjNUL/myrweUg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9594.namprd02.prod.outlook.com (2603:10b6:930:79::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 10:50:06 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:05 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 0/7] qtest: migration: Add tests for introducing 'channels'
 argument in migrate QAPIs
Date: Wed,  6 Mar 2024 10:49:51 +0000
Message-Id: <20240306104958.39857-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ec9e14-e6e4-4f89-7d2c-08dc3dcb2eda
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcgfaezJd6HguIL8euXuJwBUPCUjRvoCbYxudvuvbEQzrl442VQUcvQdJoB/oSXu/eIhKHjx0Wym4ritl0W7kL+qUfNJuvX2QR5503SGiK4yXhJqVlcGU9STF9d2u9CQbmcHLFyQS4+M0vtqs0MlJ/10f+rD5bRo5i/ZWvViWxwFM2kEnIvnY690r5Taa7oWOK+occ1lyycuvJciN1l3yl1RbUDTbKWTeWIuHTRhs5fhnJVgug+OOukW2MOAVBzdd4gkVMyDu+13om+EnVes/kZOGfu19IX4v0dCmTHbFvv3xcO5uWhcxfTbzUw0kpO04oq4jmsvkuf2/DhkQ3vtrv5sJ2YbLnDMsc/s+xhu9st39zDAt4IE4P1kzP9r0Zv/aiICsM23ZErX4xBRKDagUeneLSVxIq5XVMhukHQE8tlG0gLoWXGT0pJFVX7Eok2ViJ/tFoWANc0Xy//luATBvqfeWzU783HFcc5j+5I+DTBq7jpme+HNR1nE8Ftxr3JEBfEPXbiRH9vQUx7qdLw/2h0RqydnTbOtTIZTEozy+sZ2AlFotdnksxxp6km8GHLbwiCvn/MyTfSHeOLPJFMY9GOdfF12572PPPDlEb7ZDshxBNR9RsxsxpzorthhxabGuieBFZlWDcUFFYhsf12y1WwnMTcSNBendLnTrNVBA2KiIB7wPbgsezoICqYHE6fgOcMtim0lUSISCB3gpFs+Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjOZOP3uf1DdGxoi7t506RFrP1MtHoTbyoV+PmcmYAV9sxH3Bi/19CtVLnNS?=
 =?us-ascii?Q?Rn3l7Me8nQZp7nJlnl+NTxkYrFmgkSoce/WN9tpNLU69Lx3U7rPNaTNs7l/U?=
 =?us-ascii?Q?sZDgx6eEAF6KuM5AiHBy/OG081EatcamrsrXoc6VfcBW2J19nEkrL8iSW+Kl?=
 =?us-ascii?Q?pHgtlxI32AHsf1WzgwTHMpH/7Xp2u0yjZxgHoN9QFi04hkqETcf32kb4b7Bi?=
 =?us-ascii?Q?+STqzePvYWjlo35CkQ4EROrUETyzvSl4p1pXQgrbVXPcdtgRjk50gRjUrJJP?=
 =?us-ascii?Q?KCKXKszggzbx642tofHhlN/a7Mv49EfQ8+DlsIOVVy0MT+riZGJYjPFn5xXu?=
 =?us-ascii?Q?yqNwVrWo+CDKVpVpPW4CK0N+WneNHYNuyTWYqAGjuznhxVktUPR+cooOaI3x?=
 =?us-ascii?Q?rPe92UrYa/gfGS9fRTDE9xsq8S5MPj6dBTI21ZHtdGC5WsHhvCgLeR/V9Ya/?=
 =?us-ascii?Q?nY91vpWmIphkIwlKtknycY23xH1SrR5nUodYU4XsQy0nSFofHeSTOJxnbuiX?=
 =?us-ascii?Q?dk5sOGe2WjvXf2t91Suz58WMI27qZoGnd+KJqWRVmUj5sgJTHuNKWigVCwCJ?=
 =?us-ascii?Q?3ezl0tkGG1jB8cpkZLJp1XBbsEE0OdrgtSObLdshzolu63IeT20wbin+SPpv?=
 =?us-ascii?Q?wfpWWReSxSr9AAdR2pGnZjvwba7xokKqyGQasCUDlGzck5pEig1/+XOtQNsy?=
 =?us-ascii?Q?3I4sRSAdXq0WnwDlyQZEdTuqJK75gCCUBC8PMLlZ90/kBcuXX1Qy8HlmHxPr?=
 =?us-ascii?Q?AEnJe9d1DQU+pVoi+dNM3UaH6/FTSJ0tMS/9KyQEZ6dWuE/PyG2oVpfJJ0pb?=
 =?us-ascii?Q?cTKvrIroJEx8LIXVA7K8fbYGBf4f2VaQMToUWkMpq5D+6ml9ZSKA75plpNEt?=
 =?us-ascii?Q?b4Yt7G4C+CFqD5hCbSvcV2qeUzG8d0eZ2Y4q+rnPjoRABxeX6+9Mkhb1VR3E?=
 =?us-ascii?Q?W2m0nFlra5Oc2zFHn2EbgwhD4BPHCoo1Ue/MWeu5rgNphWEADrZgNG4d95Og?=
 =?us-ascii?Q?O5xuyDP7q1y31KXQaoWP43wY/0ReaKjSxDBG1sqIamWzmFDCV9+LhaD+jVi2?=
 =?us-ascii?Q?5NC/u87P1gY4XlRYXTvHnnnoMBXAjzSkhr2rymlCUhW/8OruUCbbyxQjH2o0?=
 =?us-ascii?Q?EWCTwY3xmCZ/TWKaiRYnvj+4WRTtvJHy25aIskbp6A4FgIBm6drB/ABn9gSf?=
 =?us-ascii?Q?IOHAMdW5kFtKAxuWen3KwYdNdBofAVMbBbWS5j1OcThO7om4xLj2FbGjeGFt?=
 =?us-ascii?Q?ITcCSwqXHYMXrFPJj5yksWhh/jDW1yUvcyaWFz5qgyMZH+Po176T7v6W3VIz?=
 =?us-ascii?Q?Yh+y1nfBtgNJ+4HGBIPAvH6x5XNoaLlFIaIYKXVtLmWB4ZxUwW/+ZMEVhNQV?=
 =?us-ascii?Q?BMwraNT2M46mBQXczW6HxHbhhUeOxy3lxxZCHpWG1WN+tduDhqPlsrem+njX?=
 =?us-ascii?Q?4K1zZzvCudTbR11+uFyQxtzjtK0rCNv6MAjrKbugMFK6W8ehSAiedX3wL3PH?=
 =?us-ascii?Q?zXcvfkN01+bNie3qf32RJPI2EXQmeml8M+2SaYxm9mURTCPxa6esfiaWc15v?=
 =?us-ascii?Q?OEcPImCKnKnaR6CxkIpaOsi6o9a6Be3hTCpMYI/d?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec9e14-e6e4-4f89-7d2c-08dc3dcb2eda
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:05.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmOfHFGyANIFHkvcOOtdV53529tim7pl6+JbpKJGG18Ggg1VP4EGRfhzwLc8FzO1uWzHOtp0y+3hAisaJ3YoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9594
X-Proofpoint-ORIG-GUID: 5MLP6fzf5TAGSD8mFLXtM-duvnmwIBJQ
X-Proofpoint-GUID: 5MLP6fzf5TAGSD8mFLXtM-duvnmwIBJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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

Patch 3-5:
---------
Add channels argument to allow both migration QAPI arguments independently
into migrate_qmp and migrate_qmp_fail. migrate_qmp requires the port value to
be changed from 0 to port value coming from migrate_get_socket_address. Add
migrate_set_ports to address this change of port value.

Patch 6-7:
---------
Add 2 negative tests to validate mutually exhaustive behaviour of migration
QAPIs. Add a positive multifd_tcp_plain qtest with only channels as the
initial entry point for migration QAPIs.

v2->v3 Changelog:
-----------------
1. 'channels' introduction is not required now for migrate_qmp_incoming
2. Refactor the code into 7 different patches
3. 'channels' introduction is not required now for migrate_qmp_incoming
4. Remove custom function for converting string to MigrationChannelList
5. move calls for migrate_get_socket_address inside migrate_qmp so that
   migrate_set_ports can replace the QAPI's port with correct value.

Het Gala (7):
  Add 'to' object into migrate_qmp()
  Replace connect_uri and move migrate_get_socket_address inside
    migrate_qmp
  Add channels parameter in migrate_qmp_fail
  Add migrate_set_ports into migrate_qmp to change migration port number
  Add channels parameter in migrate_qmp
  Add multifd_tcp_plain test using list of channels instead of uri
  Add negative tests to validate migration QAPIs

 tests/qtest/migration-helpers.c | 109 +++++++++++++++++++-
 tests/qtest/migration-helpers.h |  10 +-
 tests/qtest/migration-test.c    | 176 ++++++++++++++++++--------------
 3 files changed, 208 insertions(+), 87 deletions(-)

-- 
2.22.3


