Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAA1C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauBA-00026C-Eg; Fri, 16 Feb 2024 04:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB8-00025L-KI
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:42 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB6-0003sQ-6I
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:42 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41FNH0YQ003311; Fri, 16 Feb 2024 01:06:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=UF7QnU5bp0I
 LPfdpoAAO6GFrCUCesrtnHnvYNNQQuig=; b=ESCsqzhN6wmnfdZDssfaMLaABJy
 IDUHhFnUv96urLOT5L8qIDsXrEvM9Mhgskhj3MPGMme5bSa9JFrQQTO2qs8tdEcZ
 e0EJaZpbYdkfBQjuiWnD1FS4wNTZbdbv92fXfVq/wRBXYbKh8IfzJ1TiKUuK8+FF
 yuDuek+WAuU0GVM0CPedNMMk5m3IB5wZon8uidUA8UiBkeVDFgwvPeXgTScsG76N
 +3Fbiah2e7+lhNx1TxyE9KV8EEwVqXcyzTW6mcb0126mtduhAI71I6wotsiyecrk
 EL2Z3g58qYsthhujzfj7yUX2LQFxs4H/Ik74B+5FHRRurYyKVIwzKwRKJ1g==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3w69bg4q5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 01:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi5lSgki5Y2zSy9zqYUdtKPPy2Z+tPS0jonKU272RJW284fdxMD7Kp7L5UfUhW3j3blauEMufMaO80RLGp2EgZawj6HzMeQGGG1MIzgkgtCck4xrdfKYdehaakRXu6Ro8GhMk7CBzXoGHyy/2wmGFj8AfE1APfe/cGcdoc86esS0eht4PWnEVRxl/KGgj17sDXObsIqCWcVnR6ZXKAySSgCb8SrzO/OTZotVlslSpc59U2atVMHMHpTWIUILBX6pnbZQXQxBA0uAQRSIRM9DlCLz/ZjETMlAGJmYvZJB3oMSul+QB9W1uQxfFwvP0r5AIOIJwTpW8wKQ5Jw7TxOepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF7QnU5bp0ILPfdpoAAO6GFrCUCesrtnHnvYNNQQuig=;
 b=QNDBkEw9EpyzSt1K1biBo1OeurrvkyuE7gLZJX3+CO7qfbAba9EVecGfO7MLtqpyjjMgtjB93ocOigjpQJgWqpbUUrV/emkxsuxKWLTH+7oFJBYxOuZpqhJGiD7KEO9hwCmMEHtggWypAy+5++6tbH8zsSC0zBHh/iMEesR2p39ZMgj9hFOMb/n6e7YgOL3RRWBiCAuCoWVZvQFetKS+ppAtnI0nxgNiP1SePeveESGcTMt4BRXwTfN1dfFM0spvYqlp+CWeWU+MkXR7EksclNYrWBHeGsYoSCNE3s7XYOVUhXWes3eNiSOsHaBGYbwi0N4pLd+VsMIGDJNwktq7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF7QnU5bp0ILPfdpoAAO6GFrCUCesrtnHnvYNNQQuig=;
 b=MmkthTvyvVpqIh6p/o47zrroXAyNdmlj9Ny+ahddJ6wnPooK1T+YJbhq5G1pOKWiGXZSDzcWGepLdfmxRDrCYNE4cO7IjsvS/HzeRmjvcz5PQuc1pdor7zaj7ECgI778qN3a/nm/gYgtUPScdfAxmuk9P3QQKrY1SFbkXASaNsZ56OMl6Al/zaAcKb4Kg24xojmGOyZukIxl1B+apFTEI203P2OmZSvVulC/xq8bh6ccR5vg0HB6Gent8OTFZ3W6Qy8Chb3fvatFdB5twBvNslyo8erowcP+ut+qXoa6+X9EGHIZzgbykjLrXhTCA3BWhMIg9Hg7EAxPEAz3ulrdjA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 09:06:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 09:06:32 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 0/3] qtest: migration: Add validation tests for 'channels'
 argument in migrate QAPIs
Date: Fri, 16 Feb 2024 09:06:21 +0000
Message-Id: <20240216090624.75445-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:510:23c::10) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO1PR02MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd22c37-8a9b-49ec-6e43-08dc2ece91dc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKW2SyvQMvsROZ9m1KX5JQ828+PpN+lsjkuANTBTIrCjjNjE7ervXhmCNx4PCJPSkUnQ8neAErCsL217oqyAC9LcOrBImpIJwBt98LxfBYsKjmk0wRHZxJCpRXBJD1G8Fcf5JIo0HG7kPzqHYmgj56SocTJIQODh7uZumNf/CESL+0/OS7XYjGlGSCpSYzFb8sNRcbl/mrLYNg6efKqbJx0Du28GTEpnURyoT1WZ6PozdQK3gcLvd9HfI8ooOm9ESo5tI+y00QrsU3Rot8DWzpAorw2V5LwZqU3FLG6HLejMc8+cz0nejOzbDYFGgoURHTj9zJRgRILzkjIO3xUyIJbLgvWHfG2/w/naPboJRVZ1vOTIYfIWhThTMSqc6sMLA3dPx/CmlcAxtfpX49+IXIZOSbftsFwR+1m+pwEzF6LNh+DEIlCw7ca93dLifPqAsHGXta9O4YdqIqTcFxEWKJ1zRDZV2qp64i05h0jevuf1xehX+QWuRga8YbueUdMjUsqYBvy3ttrgpnHNMOV2A/yxMdie1ANJJE0T8cadZZIOKAigzYUVYjmVSzlcbz/eTAX4vU8DcTopQkBWiyNBwA/7yB+YWKGoiU+USo0B2MLnCvnuIeedJC2WujjyYeYy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(44832011)(66476007)(2906002)(8676002)(5660300002)(4326008)(8936002)(6916009)(66556008)(6666004)(26005)(83380400001)(38100700002)(107886003)(1076003)(36756003)(41300700001)(38350700005)(86362001)(316002)(2616005)(52116002)(6486002)(6512007)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8k2FGd/EurnBM7h43qWxLrj/tB7PiqfPGVuefZyXjbohgtzS9t+fNJUpwMZ6?=
 =?us-ascii?Q?+wKv8GqeV0WUm2JMvz8XRhnBCHuekErd+KSv7Xvwrc5uv/0vJa+IP2I617vR?=
 =?us-ascii?Q?bijW92eZ2KiBaTkzpXt6hxYVVmRpmOdZWdLm2YsVj4BcLM/0QT36MrUl3olx?=
 =?us-ascii?Q?7FhLD4f3ZkiOq1Y8Wwlo5MRg9phN2Bs5uZH1LpypJtgUW/JSv9gCN3z/+rf7?=
 =?us-ascii?Q?tTyw6Ovxc+jUF9ueBoYmqE0LWCrsjsrZYzOEr3bldrvisa9d2z8KO0R+BQYh?=
 =?us-ascii?Q?GOjftb09x+7WTfdBXe4HUFO+NtOxuyAzGYvBEW1C816zaKh/MICuwn1d4i2+?=
 =?us-ascii?Q?5wvLlaZMR2If+3kY5oSXWJyWFpbjCRjuaed+CiGZAx5+wQv0xc2UlJ4ZpTWu?=
 =?us-ascii?Q?Rde35ap+tsI6RW7ZUkHq9TTYy6AYEyWntU8xNmPv52veFxdkW2S8gbwoK59V?=
 =?us-ascii?Q?i4XpuTDcTHAfrZzHH3LtNsAW2nC3FAGSy2nYhzkbRL9thx88BUIAoK+aWNRH?=
 =?us-ascii?Q?dwKcYuSfZitAXkcbl0ag6lU/ZzIbZXPh5RnVTT/BpeHC3FkpKk5ivn2oxQKQ?=
 =?us-ascii?Q?dbcRxied1u/oKVuBKxGNbXcokg7Vs7+MerQs7Zp89pJqIIcAd3DaLsQe96Dp?=
 =?us-ascii?Q?XrK+M8T8ebDeYvB7KiHGggnDIqeZ+MVZvpni4jdq0vByweMPTw6+NoQsUZoI?=
 =?us-ascii?Q?jCdYo/Q5+1m+1VFb8k9Hc40RXNLgt6ZutoRdsMRcw6Xp6rn9+pRg8KV5HjLV?=
 =?us-ascii?Q?cEvDjoHSMRsNtOw9avFnHOe23W4+bWuP75aCvdYb/qBdWb/fN7e49bSBvfSw?=
 =?us-ascii?Q?Di8SjV5LTyyefz/4lgGTBFnfACk73GvTJqwQvjr/H7zJUThH/eOWg+Sl5k0B?=
 =?us-ascii?Q?NyHfpSvHM/9ulH31ibTOm4BVoaFtx4xZf7S/3WMspRCKhprJ76VzhVYZuI76?=
 =?us-ascii?Q?cgDyr5HJkVPfTpQYGbyEK6q4U49ghs879dCEgCjjzBq6pnt+RoyVfokJr4lK?=
 =?us-ascii?Q?CFHMqvQSVAemPa4VFEwhzSuOyMv64TAC6zo/K9wd+fLRQtPdBMCn7EQLLjna?=
 =?us-ascii?Q?4/V2Y81+0Yk1D0GNJmkESIKBcRdPy1GNppaiA45I22ktDefPS83hNsNDYQGB?=
 =?us-ascii?Q?Y+HQxqasY6AQlXFp3KcBD4qrTHGaVj2rDuy1rHCAlPGsCqXqExcptP2NZR5l?=
 =?us-ascii?Q?Cm0gbXVW1hrJyzAEtm368zXxij0iMgptabHLm7UyjQrAoAl0FPscG6V3L/+l?=
 =?us-ascii?Q?2UQrHsUjuTEY7i3ZMiZCgSnm3GjUHM87IHugGQKJoSFZ2I6V078jwzPkG1te?=
 =?us-ascii?Q?AGWmKC3uLRqWOmNvednkTXQmCLb4wVUUQv7YddHa8PNR0EhT9L7hvUn9EZgv?=
 =?us-ascii?Q?m7y15NoApWBT2r+mGRGvMxO0EUf61NkR4HvAf3f4Pri0vOsgAY02rUpfcWB/?=
 =?us-ascii?Q?9QgEb15y779wGge9GifrfVUfaRMN/zfAY9MB/eEeoJojCV8LpBJQHzNhcqoz?=
 =?us-ascii?Q?BhuWtgb5Z7FQQnhmYfJuznAHaYRvopCl1nTDUyq4UfD6QPAp+rSF5C8vpO6U?=
 =?us-ascii?Q?ll4Q0COeLli2Pe6y9N/Qko6US7BCJHsKd8nc1hMS?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd22c37-8a9b-49ec-6e43-08dc2ece91dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:06:32.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AceF+4/Rb2ylpp+Pxr9XqxajUqeqweFDAXJ37AzF6HoguGWCUx/tJFKdVKqP5onNqWe1KDZR2Rg7Wm+RCNRUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Proofpoint-GUID: dNmuuKQcU3oCZOupO7-kluMOFkx8z-cs
X-Proofpoint-ORIG-GUID: dNmuuKQcU3oCZOupO7-kluMOFkx8z-cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_07,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

With recent migrate QAPI changes enabling direct use of the 'channels'
argument, avoiding redundant string parsing of the URI is achieved.

To ensure backward compatibility, both 'uri' and 'channels' arguments are
now optional in migration QMP commands. However, they are mutually exclusive,
requiring at least one for a successful migration connection.

Hence, validating 'uri' and 'channels' becomes crucial to prevent their
simultaneous presence in migrate QAPIs.

Patch Summary:
1. Introduce migrate_qmp() and migrate_qmp_fail() with 'channels' arguments
   and a conversion function from MigrationChannelList to QList.
2. Add a new field in the MigrateCommon struct to support the 'channels'
   argument during migration.
3. Include negative validation tests to disallow both arguments in migration
   QAPIs.

Het Gala (3):
  qtest: migration: Enhance qtest migration functions to support
    'channels' argument
  qtest: migration: Introduce 'connect_channels' in MigrateCommon struct
  qtest: migration: Add negative validation test for 'uri' and
    'channels' both set

 tests/qtest/dbus-vmstate-test.c |   2 +-
 tests/qtest/migration-helpers.c |  93 ++++++++++++++++++++++--
 tests/qtest/migration-helpers.h |  11 +--
 tests/qtest/migration-test.c    | 123 +++++++++++++++++++++++++++-----
 4 files changed, 202 insertions(+), 27 deletions(-)

-- 
2.22.3


