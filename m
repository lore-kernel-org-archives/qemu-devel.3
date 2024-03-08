Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E87AC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKH-00040y-O9; Fri, 08 Mar 2024 16:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK5-0003zb-10
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:09 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK2-0001Ap-31
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:08 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4286mnl0030106; Fri, 8 Mar 2024 13:00:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=9S9jzppaWn1
 48cgcMJ3wlzVuzPUxQfGYQ8w5yJmU72o=; b=cwJfLmTkxtfis15cfJsO1N6QeWm
 qKBDKPGy632jCOk1F2U6BVx97MnmWzIvBiF8/nlW000+xe0NgrSRNFtjVkcNMpdH
 +VmBLy0x10EKBug3zHdpWtGwLK1YEAGAiCMG9WyfG+i5isqt3HL/d5+MKjg65ZY2
 PaCZ3VyUIvzUKvp8/cF+CoMGX7A57CwF+z65CS0UIRFJ9oLsYDzsMxMa0dHmKJvj
 Y7yQ8drixW0MNul88vqyNv6PSFCeDVl+ogybLUo6Q3s8TEPX80TF9LvabA1sGF9Q
 E3G6CE9K2a2LiKkjklXjUrwEPyQzkfpMQGbjC+zKcBqThXSaqB/acI0qO6w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4j0wynn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 12:59:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ET4ILcKeqfM63l+I5RCKLAWZlJD4jpfzNyLSPzUfAGlKdOrTzcGor4O4uUg6EYxX37e+ie7t7BWZ67quaKzClF83omtOHs6YKcB0o9WrtDbZpY5v6+S7bJ8Btoh2li603kGGfVST3jz1SK9fiArHtWLJvoE2ggEgO+rIRaG8pfrVn5lRzQefabGA4JiaVG855G9yUR/Wt2G8diBVrsQL17vwlVoOvEdA/7N6f1v5Gw73pKWYfikURa3/h/xQIoKghAPY5gpKrzn/zZQQ4Z8vsv0kS9+hcUR62iqlV8EkpZZRWzjBfSreWAWvXaDm9N9FIHEVuh/nAiTpMoe4X55UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S9jzppaWn148cgcMJ3wlzVuzPUxQfGYQ8w5yJmU72o=;
 b=b4cDSIkfo0ZgRDX7DWgZjEPp3l8Bh7MerBnuljVQ7Ob2IoL2Gqm5BaZJKOeTAd3tdgA1A3/dDYs7XzMeml5P4sQgOw1bh+sL+VOwEH7GlSYlFAIiF0zA5rfWrlRBfaqgY2GuhtPh1RwAwAc33yt+NKqndyhMmXHJSk5QXTb55dkqrAxUK4Kr4i8Z4UVtstjNpAnRC7fKYoOGXo6qMugolepxz9b2dz8/3EpGgm3bVlO/53CaLqw/Y+GXxpDqGut09uV65jKyC7O4Bptvz25thvdeEpJVFwsjRMJAzY+RsB5h/UxGqooU0hwn277SAI4xILp4Jxu8SDvosBI3zCP26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S9jzppaWn148cgcMJ3wlzVuzPUxQfGYQ8w5yJmU72o=;
 b=fgkex+GDRl8ddmaWq0GMrHjmE+szt9HowT8Sn8muYj11XqkKxdnmlNylowPE27KviguHAY7Bm8384kNquShT8Gy1nyg9hK2iLu/70EixUMY/fpmUJPBaoelGQx61glAQQbCXIMRD3CAUEIo9yVcxcNpNwPOMehjNDZcHdcdIe/OjL8O23NolLeoRMvdjd1NzEFolgtPs4CHaoXD+v6G13ljQvPEKhH7j+5WRl5K1c27+cG43aUxLxt0lwV0etIMsOVG3H0Vpo0dH3aGZcraCmhq5rKVYIOZ696BTODPDgeJrYFLBC6LubHrfFMFm2+x1GWg2m9aBKqN/4mYauqKyGw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by MN2PR02MB6702.namprd02.prod.outlook.com (2603:10b6:208:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 20:59:57 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 20:59:57 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v4 0/8] qtest: migration: Add tests for introducing 'channels'
 argument in migrate QAPIs
Date: Fri,  8 Mar 2024 20:59:43 +0000
Message-Id: <20240308205951.111747-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|MN2PR02MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9b30a9-0c24-4da8-36b5-08dc3fb2b5dd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWzA1cawSqZMWTfPRCU/WmZk8mY9AR7AXNSo+YH7wy9dlH04OD+hxCzoNAzrAN9m6b2IXQAduvTuoElS9geAPEuwlZp9jtiVcZJLFebB+vQ+9Vx7xD2UTAoLpm+ARxTinaJNdnL8Zvn3Su5HO9TfvagjuDNgU8C0UfagMIjxxGeoxBxdxwv3IjGH0PSK8cHGOQlpomZugoSlpppRVuZtWrd6m1jF9Y/cdiaA0eYv4Wu0BYJuDl5kVNAXfVieyRyWQqQ0qn9ItaaQeatnFrtU8oNxdf6M5x2KoUaQKZNU6Rp6lvX2Eo6thONnXk+dMHn1OYerI4opCtI0jaXtmToaYYLE5g+7TGqkqlLFS729Hc2UJ7q/NJc/k5tfXXxBZHT016XrxnUjsQu/YzWmq1K6T9Stg1bqKsCEmWE5wtlzrM5/0P48rcHIgSvVzVcAZQ/hujsgnK9DcYMQ+aMQWzmD/ENemb+SOs733huN9O9Cp97CkhhONOz5Fi6okkSMn/dTfmWwPL6HIA4HnfybQ8PDHc/mJUdZcFl2B9vIo9PBCl+yWbp/iwDymw72n+Gy+EcwLIuf8CrNt6epKuD3X2YTSVXMhtPxFZ1LtXfLqD8b2Crttcz3wI0aFfnw6BlOc5BTNs8bEF+DeJaI4NS1lpUIavMnlSGycAe7fCuh+kVCMiyW4hfvKWwkNNFVy7r+mud57xUTsj5dKKuTut02W2RlFJIWYl84O/efpm9paPKXEeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r80fGbpvb94YL7ZJ2qH0I4O2Jzbi4L43tqYWdd5tBJu/tK6iln2u4f3l5uRf?=
 =?us-ascii?Q?ZgSCOQM6nELOZLTd4RUupg91scEEhcTfjlPfuds7sm5rKW8kDQdhbBfTqgnW?=
 =?us-ascii?Q?obSnMhfOwfNABRZitztZXE3zFIxuy6NPQOuNBg+VIiOzSj8E2YWNBCKtaXNe?=
 =?us-ascii?Q?mUKduk9wHQQAHjwXFXGeg7aQK+lqyQp0QtnfW7XbP4LtmSmTHOvd4AvcvOkO?=
 =?us-ascii?Q?iJXrgYQu1DoaqchE1Isb+IrzJtqrbclGEewsBinMVK0nJe+LupU/VYH4e6R1?=
 =?us-ascii?Q?IjluE3pNIu1d94br4hUxASEa8rkXeh1rWTUHt5Hw1Xk3k24xhRSHyJY1lt6f?=
 =?us-ascii?Q?FOaKiuaf4TpdAlIxB/d8mwJtz/g2sA9/EgN0B+PLDRyum95qEZk16/dt/1o1?=
 =?us-ascii?Q?hXpEyl5UIs/37esyPAHZz0umIP30UqMOd/a8NRy4cm9Zdxm8HPm/v1b2Kmw/?=
 =?us-ascii?Q?rGxEWDHKNnLoSqVpy658gp3cFm0q7nynPUpuNHmBUqwSuP6x+KCGNWoZESYO?=
 =?us-ascii?Q?v8oYE6eyDFSfG3s1E79DPSkPXtEjf2lsSv8LFlCmc0eFaOB6IW5UCf/0xfvm?=
 =?us-ascii?Q?sLUyxFgGDF/rqGp/LlQI6eIfWxR34hkaqDbT0o4e5oIcD5/YS11HmFVZumaO?=
 =?us-ascii?Q?aL26a4pL+ydZydZhJh7j1yqIxaEO01x5Rahv+04Tu3ZtLQSqzFkqUEMsh+PU?=
 =?us-ascii?Q?eSk+9j5IvxkqbcDoXDhtSLhC1eQpO756Id/Ck6DzSBcLe24B/ssT1ulGEY9Q?=
 =?us-ascii?Q?PyFcZUAitFoWIUhaF/tWcSUjEjYKlcZSLomQtHriTiBjZsjGW6qiZfi+bgd6?=
 =?us-ascii?Q?oqZ4WXzUlaRXRXYCjAC6g91zAqSNrYJe0QGLlBZXAXrqY1wz6e6QlwJFhqsG?=
 =?us-ascii?Q?zsFDoY7fOI1hc4C9L7VT52Hf/E+vZPosd8BCFCXHe8fTZ7sIk9CkIp7+ygHs?=
 =?us-ascii?Q?8Jg3e3+tllj1HDKL3HUNP28tmZcBTQlRXS0gDUIJdVnHFhcgLaWrc58WEnXY?=
 =?us-ascii?Q?ZI0oS1g+YZmGedqzaMvowqTzADFys00qlq/dbTLbJ/4NcYVtI4mcYAexZNkJ?=
 =?us-ascii?Q?AUSS5/9lmIOQT1OMUFwudkWs49ioZL7nF7C4AyqYX1QFavhu46nwnMarvKvF?=
 =?us-ascii?Q?ymcq6n46U2KmEyVbactSKPMVf1ud40SPU+JVCMrer995YXAs6ZsYY9SbUUzA?=
 =?us-ascii?Q?LxETADdlDy4pBEQ2H2sXQ1fFD+VrFjWsSHu/P1oQHEdMZh6nrj4Xq+wHbxXC?=
 =?us-ascii?Q?6V+RR/6NUUVVV/Kd9JRqPDTeNo5Ezlh3qryta/s+5sjv22u7Kj4oeRkRyM8J?=
 =?us-ascii?Q?kcTymf2eEsTHnvqxKqQSQntp7/VyKaqnTWX8sehvV6B1Bvj2L0wVGJ27EMHn?=
 =?us-ascii?Q?XihlG0hLAt9iS3b0QY0tSK6LOzTFP5Oocg+xW0O1DHDpmVgLCxb5xvrJhhCy?=
 =?us-ascii?Q?NCvEbYzgwbjAaTtqR5BEcmHPii5bk9BuWum6jQRctv6k32OI/EnWc/oi+y6j?=
 =?us-ascii?Q?p5TdfjVAmZdjY1bAVkaRcdc+KkDcpJp9JiRRW25kCR8R1hp/1eHZaJ7brUN6?=
 =?us-ascii?Q?9qGRsEyfpDJDlTtBXcuzQAYpQhvFMDqXQnibCiPF?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9b30a9-0c24-4da8-36b5-08dc3fb2b5dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 20:59:56.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQXsTPRFbvumuO00wtXQF43QHwSrCq7oVfblExRehGWjM7/UuGfaufc5gmbR2ZnmZoz+VBtdnsGMIaVy6xYPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6702
X-Proofpoint-ORIG-GUID: 6dYqkW2E9Q5NdYJrT4Ow4DkXNSOnxtYR
X-Proofpoint-GUID: 6dYqkW2E9Q5NdYJrT4Ow4DkXNSOnxtYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
 tests/qtest/migration-test.c    | 177 ++++++++++++++++++--------------
 3 files changed, 258 insertions(+), 87 deletions(-)

-- 
2.22.3


