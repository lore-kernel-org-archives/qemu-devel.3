Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346E6CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXM-00083W-QP; Thu, 28 Aug 2025 07:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXI-0007zb-OW
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXG-00051i-K8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S5H04m016745; Thu, 28 Aug 2025 04:11:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=F4DC5jXTS8ERZceIX85OY3SMMmuQe/FLHPVXAK9qJ
 Fw=; b=QmZa9bDtzy2o4K0AZdnUg48Zbr/iNMafE2Rlc5EgKmVAiTgQj1UgZtXy3
 UpTM/7Ka2fzdZtvlBWkR+0B9SiqSvSDgeqTgjeG3yWfjOVOBg8GlkJxBZSpEMU3x
 jAtU8ALYAbxmTC78vI5BC6PB/wm14ilXKpJn5WS4mnTz1a2yNeC7XPxGq27kAghm
 9MDq7450lAhkgFBBOaEHGOliOXVVrUSSwyycGJv7ZrwVeyjnFhBYXivKCT1xcyNS
 ss+CPIJY8QZWDoiLjPTHPWZ4hwAFGH4zqOjp7ib8VMq/7p/f1HRPZV/6ggAvE6OX
 RsmHrLg9gCUJfnLYUeBQEKz8Rkd8Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2112.outbound.protection.outlook.com [40.107.92.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48tgu2rr8x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtKsqguCKTKJX6Z7Hn0aXOTl/KhrfRhQ0VB/VpWi4m8USf7n+kslqctjau4uu95pBgRpmwodK/ICXHcoyFN/mMRwHlP2omq3TAYYoR4hvS8Jnt0pyYRM0RpkFFij8eICYKdsxQHq2RQLc0xOF81x6MFLcxuJITovIJUokpYdTbsjXw3MQyucXOUtrzdpNdRhyCsHbU1775C3EKzlo/C3fXQh8FCzlkdVJeG40HumvZ2MjdL33gNF420eTQDvdrV4i2JWEuLeL9vowqe5wb/682o25Yh0qIWWu+7GXiXiZH1NmISF5lir1694RX6jbFjRERK4N8t5Ruj7f1RY9tI7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4DC5jXTS8ERZceIX85OY3SMMmuQe/FLHPVXAK9qJFw=;
 b=sK7EvFA/B8ighhkey+aWXJVnY5onAT8bjDDGCgMBIvQN/5twC19NKtLYvok95klOJ6PoL4rE2zUKb56dAHC3e2ehwH/miSyp5UZKNbsM7/X9pxPTZaNcRYzSHkpP7KzGvDfLattA+yorkhEsTLZqV2kSGoCZjMgvN5OQWOB4lh1vtAY7Nnfn/i9xKU6B2mCPfcx3jRHfXcrTT00BPi7engdh6s6cwMzv7QV6eEjho8l+g5JrQPHimzMWWjI/2JXZGAw1ect0YkEDn5UUeRtWiUWTRKZ8347eCx2lXaGOKxcFVZhto0iVp+w8ueY6uQq9FpPCHQcPppRbTBl/CDDbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4DC5jXTS8ERZceIX85OY3SMMmuQe/FLHPVXAK9qJFw=;
 b=kEpHYsV7C54QRsv/27iLlkZ63DqzkWwgBbrXPlXakQYqeyPThLLDUZcEZ7cWhbHeFEw+/7QSq3lNtO0DQgN1s5fWCCbG9KAx5TDdSFPVkNc3wksDqxaKhupRan2q2RiGgDO3q0bZ/juKQffovUp2JtIZutf2Nr3IcOIqGEupTCBDAP7Hqx0nIhLWWNTVURXX85W8fswQ3qSYabDEfvJGD6OVJTFqM5RTcFHiadvuvzzNzcI6hYoG8OXgag1/vlBOM/3v29pz9bF+UWPfKUxyB3AFZgjDjov+vCjt2kRhHTpmmf3AvOSaICdPVbs+jyGEBNg9d99HfTw08+2HQbmlJg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8891.namprd02.prod.outlook.com (2603:10b6:208:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 11:11:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 02/19] hw/i386/pc_piix.c: restrict isapc machine to 3.5G
 memory
Date: Thu, 28 Aug 2025 12:09:45 +0100
Message-ID: <20250828111057.468712-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0009.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ac8ac1-f5c6-498e-384f-08dde62395fc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hXr8Gz5todXDJ43K6VuO5j0lE4btBD18eQ4gvxl2gpvY8H4TndsmNZ3vyj/P?=
 =?us-ascii?Q?mtBH4DYSu3W6gxGcD2X5SmoH1Zo24tZ/0NwO3zbXtvWvjPt+Xv+Q+nAi94hh?=
 =?us-ascii?Q?bPGAgW3S5pVQH2YFDcatsu8ehkUmlxZMb5oDTDq9egqqytxT5D65w0ic+L3T?=
 =?us-ascii?Q?jmPxfmhe6Yn7S1FbwraexoSLQHJVfkQT2w1BDBDgB6KiwvZdp6TbHVLvpY2h?=
 =?us-ascii?Q?GNjB36Hmsv+isMg268tY1IpbdyTiGUTbS0I8WTsL/IZQoFgsp9TgJrJGtpca?=
 =?us-ascii?Q?izsp26dKI9vR3a69WmNGs2Lgd6UAhChIGSWEJ+Xj3W94Rv2xi5Ii12Il8IUN?=
 =?us-ascii?Q?Uq5bM7Vw//OAns9UKzj/S7F5zMhRJGHVxmFaPNeXYBaOIcia3tawQxr/aiir?=
 =?us-ascii?Q?mzQYG1sgDFybiyonC5TMSRGwueWwQILLyKm0Fwpb2IV/MLosMlY6BDgpbc5h?=
 =?us-ascii?Q?xH9eNaw+4LbLaWxHL+lACKxkR7RxRp+zdvK7psfQy+ng2HMSKafga99SlBwz?=
 =?us-ascii?Q?xXb8qiHOuQNyMb+F4TPlCxK9RSQcBFHQbi/6773ngGeR3LoyYQcVDziAle2V?=
 =?us-ascii?Q?7vq80sD0yltwymL238UprF4j3vZEIsXvNX5luwdH5JSAmfZKcLmLQWumW3Ib?=
 =?us-ascii?Q?ph6p2/A70IipOdEpwLWNxDHxn9grxR0rFUalMHrSysDQ2WCBjrwqzdcIw3Xh?=
 =?us-ascii?Q?2Id+NQL1A5oXRcQF5VhlxHAFy5n8NQTN1TDHwghctxso+dqdrkzlMRldMOOE?=
 =?us-ascii?Q?GcDD/FWxaDoIgC+2pqU0aNSU31K8LKcKCBIhpN1/SXT1NxW33vviYT3L+7Wn?=
 =?us-ascii?Q?15Q00NdGU7fyED3RtKcn8fI1b3KSzDiGRRr0MQy1wKLOGXRWuiD+/WcccJNg?=
 =?us-ascii?Q?HSwTRAwY4oISaSo4E6IERLIruGDUnEcFx2mf2YQ7rv69bx14iQQOV69AmXSn?=
 =?us-ascii?Q?7xjrvRw9iHlqj7HASVturocFckGw25hXXbVlzm7r/z0XwGx2wJ2dGYFdtt1o?=
 =?us-ascii?Q?NyElY4rd5bA89ShGFhyeXS9tBf/RQqWMpuKQ1hE90liPCZZfwhbg4qYGL9nC?=
 =?us-ascii?Q?GW/Tq0OlJI2FesI0b/ySvjgIBSonVcB2MsO1aOYYNjK3fTdlWzerhqTzCkmO?=
 =?us-ascii?Q?rRQIh+PA9C0RB11ijEFQhOdexTBm5IfMMPcUMVjHCo7GgM36KHt79VIj0VU7?=
 =?us-ascii?Q?6KPQf64l4meaymx43PKKs9cUIG8HIbqxf2M4c/Q6CJxroq6ltfE/yGh58Z9k?=
 =?us-ascii?Q?HbMuvKaSr4tCNpiz+Q98GgQaiJpa80dwmuXlznPD1XQcWoeRY9lU+QWqOe5F?=
 =?us-ascii?Q?NrMOkGiJUP8CAjhMJR9WVhZjIKyEnD86l7dUlgfWTN/ox39v9oUIP+1KqlkV?=
 =?us-ascii?Q?XhapE/Qq3SZ36pOiirAUvOeioqIyg1KcKTj1kbau6Nb362tP0mqjRe08ejwm?=
 =?us-ascii?Q?/8tt/lJAER0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hmTNSY3R79HlMk+koeyuEu7+QvSOPpQcRDivmjow3DOdY8MLrjc8JzmbKMCE?=
 =?us-ascii?Q?dG70idmxNlIs9KiIvObVJS+8dnrmdjKyvreliTo9rvTVEURvFxqGzAMuCjr5?=
 =?us-ascii?Q?zJOGT83rtPvqu9q/LPZg2oR5aq0hb7lGdmfyJ5xbyCHUUzk2ER3VZzHLudU0?=
 =?us-ascii?Q?aqYjSsIYEg/3nRpz2axhfr1iFCCupsEnLOMoGpkbjhC8EQCC0rVXWBUtvbWr?=
 =?us-ascii?Q?Mdj//r5TAaNyMESBu6yG3zZBXlM0Cb4W6VZ6KRaN86UYmWiCnMvyOYhPAiMZ?=
 =?us-ascii?Q?ISjq7uMYjaDAK3LeXB4uZP7PgZ8XMAg4unVgx/O6h/WX1KaCaBedefZKPYA4?=
 =?us-ascii?Q?hVKMryiISyKd9q5amIL1i+KtWoSKBdHKjqn015XC3TfsZU7wN+YlB3D/2eAu?=
 =?us-ascii?Q?b/sdgr1EdjwU035Un9FJtTJaxlhONLBvYBOrjoEkQxWriY2ERCmM6d4J1fwb?=
 =?us-ascii?Q?foCL/ZBKEfDl1kwj8FwWhWE3ZvPcm+pflrwCmCX3O/aKqrq9gKG5HzSQ/Dsk?=
 =?us-ascii?Q?QXhjUJ3kuHX5uezPgoGQoU3ld1bujznyMpo9B8tD77pSG0W3uFnN4tfsZh3M?=
 =?us-ascii?Q?Lwb00K3RIkDhtW83OfBb8g8vGl0N9yoQwOLq+Nyrj90sIPOPTB5I4Wjnc9nC?=
 =?us-ascii?Q?2hpaOWrJg8QPW8ziT5qeTfzCraoiBq9QZdlcsvrPZ0bYtktqv+vncPhQhqge?=
 =?us-ascii?Q?59tSL8OsaF7s7JjwVUpJI9n6rvLxpvMcptMwfQWAnk9SiiBNQwCnb5oGdN4Y?=
 =?us-ascii?Q?3evKGa3daKY21EBl6d8q8Wp3THodz562VFsacsMojDvsQ/lR0sz9hCx6DrBy?=
 =?us-ascii?Q?d2ky2FIwhsjffZqhig7WP/+GLtyUna5s2xuw7gUHTndYi3LKLJ1OBbr+wY0I?=
 =?us-ascii?Q?9r4dSBZ5O+0f92CVWM6wMDott2RRITgXbNDznvIAnjQ+aROpSw4g2AVXDNTQ?=
 =?us-ascii?Q?z74+NsAgmJ5RxWzzurHbi5MuUwzGcJl0X/12gWYBXN0VRp2TVH92kBau4Ef5?=
 =?us-ascii?Q?1PVlv0x9JwbRHENhRUWE6Dp0knT7veCOk7DTsR4soON9mtAUhaTZKcdniUYn?=
 =?us-ascii?Q?TyjrM/a0ohSlsWSAcJvJeAz6bNUyGJNrtOYWYa/o4NepmhBn2nSWJN8rPyDn?=
 =?us-ascii?Q?WsamDqqHdG6MNNaG3I2jJ1LrULbC2kz5KSv2NlWJhi427B6/i/tUdK3JbJTa?=
 =?us-ascii?Q?20kPib3SBLYRx4ooB9DpmL3rwH+8c8t3j1Rff0iQvaFbsigt2GXbFhSXLb93?=
 =?us-ascii?Q?ai2GaiKk3NJcQTLQmpdeOKZz7Qw3XXJNlg57eyj0Q+pLDPjuxTfH4z9EWw/b?=
 =?us-ascii?Q?wWH8479p8xn7heZN1aRhejndvs8nyJgM1XQmIzM66LjtAIhWuTctpJjofxbX?=
 =?us-ascii?Q?TvoAntEGe+Qeram8ikyGx2Pn+Y6dxsi+yfsDlYHl2CmAdnUDmmNmsOm7PqXZ?=
 =?us-ascii?Q?ecckicd5YVDse/zEkgmEBvjcr+YY8kApLOehybbAryamcnjeYse/3xmv5/YD?=
 =?us-ascii?Q?W6mMp9fQopweoCPG4PxKolCZxyavzpd0xJj5VlymMET/+G6af7WLaDVenFoN?=
 =?us-ascii?Q?nuRot/NokDjK5th11n0RSxy0lpL002PyNYxxSjJgrAcnVmQn/Tkk+x4puisG?=
 =?us-ascii?Q?Xd/1BgMrRy5HsHDeABxcxdjZEKw8tZ0w32LULf4kHz4CtEDe33rk+/JAMw2p?=
 =?us-ascii?Q?/sXVkA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ac8ac1-f5c6-498e-384f-08dde62395fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:07.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCxpY2IiICYFCr2OZUj8H0GiQjFCmbe8TW4V6oOVRiE9l8WqBCXqE6VXeVh7o24fYMckwxis9ejspqLgO68qS25YP5IuOQNzY8s4Ow2vkqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8891
X-Proofpoint-GUID: -V2ifCBHiOvUKMwqyhPNozbjwO-31lL9
X-Proofpoint-ORIG-GUID: -V2ifCBHiOvUKMwqyhPNozbjwO-31lL9
X-Authority-Analysis: v=2.4 cv=ANL1oDcN c=1 sm=1 tr=0 ts=68b03953 cx=c_pps
 a=OoAjNmQ5oDU3bam8S/baIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-_9pao_q6fl1E6OtMoIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX1s/YKmsMlyGm
 l41SQhczennoph3oiMZc5ZWoWCMeC8NIRmSgjwyMiL4IMEaCIvOxOr0kKDpexO4AMKEmYm6eSXW
 qk/A1dL5Ml51XHXanMEzfkznOeicZME1MUnB5WQ6gBT75zCjylEpalzzvTcrMg8D8+R87/9+SA/
 +f9YoI8c7xo6oDTI0Tpg9/oMLmy1SzordYnr3LZMWVjttAAucNPzhJwFBN0RdqL/NExJ62I3oG7
 Sy2VjuNDO0XKr4LKO4LwlVtiJRBM7/Dxfpe6VdZ8j41UWD4qji7Nbq5Od27wYQogGO7hmFRkJtt
 vsTceOehKN5VVWTApIXwvWPgSJnZpeZnczHN1aOU1xbMnq7rxkg+KMqzmLRwIA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
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

Since the isapc machine is now limited to using 32-bit CPUs, add a hard restriction
so that the machine cannot be started with more than 3.5G memory. This matches the
default value for max_ram_below_4g if not specified and provides consistent
behaviour betweem TCG and KVM accelerators.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8f5fb3cf90..9a3b5d88f0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -461,6 +461,12 @@ static void pc_init_isa(MachineState *machine)
         warn_report("-cpu host is invalid for isapc machine, using pentium3");
     }
 
+    if (machine->ram_size > 3.5 * GiB) {
+        error_report("Too much memory for this machine: %" PRId64 " MiB, "
+                     "maximum 3584 MiB", machine->ram_size / MiB);
+        exit(1);
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
-- 
2.43.0


