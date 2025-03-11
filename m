Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC05BC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts188-0004Hr-Kb; Tue, 11 Mar 2025 11:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ts184-0004GL-Bx
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:02:48 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com
 ([40.107.93.79] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1ts180-0008Kz-82
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDUrYPQYecVHG1nhLSVi/y0p3FWOGLXtlVCdovNCKhvDzCVbIxZCuWKY+u4e5xace8JnzX/i7oqYFJdSXPMIYmVbAg+HafML5fAoSEX2dIm7WPnM1yR3QL8WDQ4IBdmgWaWQ2pTM3fgS84tOZc6H0chVE8OuWaLDk0gChuwgLb7m0d+jr7+cHU0AmdXgd3515avG4JII0TFjYny73GbbjDwy7EO6Q5pYZ4jYqp0nkK6qFQFK85y/d0qy/21EpZ0rezM9hl2g8NYP1nNkh1FyAGUG+PSpMZx1G4vSDtTY6CP4LgMgPRqfazUGYoJW/MIMdM692W5sSTRVHZOVO9VRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5j3F0yn0G6Oc0jts07QVccNShJWl1m+PjWdDiRCCEQ=;
 b=txA5TOsoSpRI8DgP0lf26ORHrhHFT7JSAWWq/jGShaavbeqcBOriNMaQvFDxhJEWZqNqcRdaVOAez+2lRrG0v4E1GhfQF4R81N4M2IhH06tjbDWtkU2gEnO8C4Yv4rU47DANaTl6VLBXXlMUugaaQZyDAL4RXxDyX2pO7o2ThePoNT48rDWEB67XtbxGwcJoC2svD/K81McncwxqQck9kAoohb7qip3WEx/mQnAemRDnhMwiFmpyqqkqg/56iIiGAMeOj9rmFRlYRWlRRPvlM20a5n76symq3yYxoV0fowoZsBKX5DcM4Pfr8ifmBsk3fUBKPK61ItkpTYzOPR9aIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5j3F0yn0G6Oc0jts07QVccNShJWl1m+PjWdDiRCCEQ=;
 b=cbvXqhKjZR8kFJClU4YSijLV6BxPjvcGzKW1N7RDj/IC1U8yUZG3xhYqGfzO5Hz/Y2zlll09dObknp4877AAyhOkWfPIicDy8vr9gl9ep3gk6elnwQFLTJ4zd8D91bfxx83Gzp/k6z06YmRmRTLtrOO5/N1uvgxvJ4OU1MuqfzlJTY8gyvhB0vyo1GB6bkJGuIPD70EWWX/yAeN+1OjMMXTNZwP3nRXQCc7bOxbt/AFCgtNmA1F1XCUF0V1n/l7ukx1YCV/hJ0zP3zbaF52QX/IccKHN30Qj8o/qaqxS2SL38H5Dce45feORxF6X6up8nfZG6fw6+7kJZrodm8VPuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:57:34 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:57:34 +0000
Message-ID: <bdd69682-3d0f-4687-a8a5-43a6cb4cecc3@nvidia.com>
Date: Tue, 11 Mar 2025 16:57:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
 <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
 <3826d47f-d79b-4db2-9719-35f48f582bf0@maciej.szmigiero.name>
 <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::11) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e984fcf-7827-441c-fc9d-08dd60ad025e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmdkRUxpSG0vak5CeFgvR0Y1eFFNQ21LdWpEbnUvbXMrRzdnQWJGZm1zK3RE?=
 =?utf-8?B?dGtWRlhmREo5cVlaRkh3d3dzcmVhSkJvaWtnTFJVQnhlc1BOaUo5a0QxdHYy?=
 =?utf-8?B?MFFMTkRoeko5bC9MTGVBWitYOG53RXk4NHlDUkFSZTBxNW1qQkdjSlhsQ0F0?=
 =?utf-8?B?Vlg5ZVUrS3pmbmdLb2ZkamZnWjBhMWFzMU90NW80VG84SFJNME9BVDRRcjNG?=
 =?utf-8?B?UEVDdXRHZmNhVzNISG1LRUJOUjFYSDdVK0xxd0o1bTBNN3A2bS9qREUvR0h2?=
 =?utf-8?B?QzZ2WC83Q20xNjE4MkJXL0JjRGcweHovc0lMMWpiamFWVmYxQmFoL0NHTGk1?=
 =?utf-8?B?WEtvUVl2SVZubDY0dEI4YzNmbm9JR2ZlTUFyVVd4VVNHUmlVVmt4UTl2U3dI?=
 =?utf-8?B?TUQ5eVZFZVVoOFhhbFNLZ05MN3RFd3ZvR0ZVbDVLZ2xzTSt1aS9aQVNLdlJU?=
 =?utf-8?B?OWlXRjFDeFBmdTVyRnZTcHhDdnNJc1RhQUlLNWF0OEYxRnVTK2RQaStseExP?=
 =?utf-8?B?NTgwakZBSFNnVndqZ0FWeGJrTFk2OHQ2RVduczhGOWd4TWUwbFg0VjdVK1l3?=
 =?utf-8?B?aFFKaEw4OVQzVVRiN0liVFpqc3RIMnZlT0UwVCtCSVpyN2NDOXRjN3NCNFd0?=
 =?utf-8?B?RENhakY3R2EzKythTHFMbWI4bmlUWUJDUnBPS1Z5NkFRYVFqYVMvTHBEbUJl?=
 =?utf-8?B?dU5LZlpwYXBSVnpPSGZCWGZ2TnAzeC9xVDNNR2FqT09QMmkzV0lWMkRmYXQw?=
 =?utf-8?B?VVJ2VkpJS3RTZUx1ZENqbXpKbnB1ODV0T0NJWjkrRkJZU1ZOS3pQUTJrbnQ0?=
 =?utf-8?B?bFRKYnJUS0JrNzFmVTVFVHFBQk00RjhKVEpyNjEraU1QcjJrRkM1d21SR2cr?=
 =?utf-8?B?aXNsMG5xZDhlcy9QdytXYW5RRzFpSnNzL3dhaEVKdXdSSURvemRmNGw4eElK?=
 =?utf-8?B?em8rTE8wTzdvTENtK0M1NzN3N0xxNk12TFB6NDhJbWwxMkhHZnJuNHVKUzI5?=
 =?utf-8?B?V2swTEoyOHNoVjRkTFFodVdsMTdEdkpzRjBOa3pDWjZOOFRkSDFqNnlFMUZB?=
 =?utf-8?B?SFBKYlpUZmxPc2s4SHo4SUxSUi9nWXI0TCtydERxWkpyK0VKNlpiQUdKRFor?=
 =?utf-8?B?NEZOMzZ6N2pPUXN1OXFFR1V3TUhQMHpYNTdTSnY5dHY0L3ZvTWNJUStwcGdP?=
 =?utf-8?B?U3ZyaUJTcFY3UTZWcUVqeFd1QjZlZ2VKN0FRTU5FZFdxblhoL3JYMFZLVnFh?=
 =?utf-8?B?OFpNeVpKY0hBVlk5bGlWWlBDMTY4cnFiR2xVczNLeVQ2bm9iR2FHbUErcmFY?=
 =?utf-8?B?WVY2b2NsK3ZBdEtCWmw2S21iNm5QN3RLTXRJa21vQVUwTzJ1NmRoT2NBcTBC?=
 =?utf-8?B?N0pQenZCV0dna3MzdlZQSklJNjh0NFB1bC9xYVQ4ZWxSTy8wRkl0Ky9jVjA4?=
 =?utf-8?B?QUNlSWdaeS9TemhLUFJBV3AwbkZGN0tvcG1RYnFhSnEvZW4rVGpMbG1GTUJ1?=
 =?utf-8?B?VGJuTE9xMEtKNzVidkFsbW1hcEhmUmxKL0hMWXFOQzdzdUFyR0VBN1FueWt6?=
 =?utf-8?B?anRkSVZRcVhWNGsvZXVqa2YwMlV6bERTZmRRWXZMUy9NQ3ZNUXVoaEI5UWNJ?=
 =?utf-8?B?NW9waDlCaWNOd0tJUng5WitZNmtSYmNrVk1ya0g3clFtVnVyRjZEejF1SnpY?=
 =?utf-8?B?dTJiQ1VPY1EwbUFYZ3ZMWXhjWGo5dFVZU1U0N3oyVWc5cFBxUUhHSlJaYU0x?=
 =?utf-8?B?VWlQNE9oQm1HY2hiN2hzRHV6alh2c096dXVCUTlVR29OWlQrR3NHNVR1YW5B?=
 =?utf-8?Q?JDG3DYj3GCR+EfaJOaCRZOT6muAurcB/amM0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3U1WUFzZis5TUFnTUxOb01VbExTV0J3WlcrNFNCd1doWTYxWnNvUUFxNUpY?=
 =?utf-8?B?d3l3VjA2VUZZMHM0Sk5YZ0tXYk9ML3JCUDJMRGRBU1ZXYXcraWhzdU1pUHhM?=
 =?utf-8?B?TktuMmwrZEJkeks0SFZPOXJub1FyYkxzN0tUS0NvOWNpcFk4NnE2QUF6WHAv?=
 =?utf-8?B?VUZPNElGcG45eHRGTG9WNXo5MlJ4eXArV2pPNUY4c0gvRW0wSWFMRUYvTzVE?=
 =?utf-8?B?MzdCQlNzOUEzVHBPVjI4cmIzRWFMa1Q0TENCTG1mWXhvUUtLS1M1M3lldms0?=
 =?utf-8?B?NkYxcCsrVFI0TS9zc1FkTER6OXk5ZFBpeXpaUlRaVVhnYXRJNnpVNnh5aHoz?=
 =?utf-8?B?V0ZyOGtsQTQ1OWdZSy9temhYMDYzUFNHalowWTNBc1NDN3c5eFV3TDM1T0dx?=
 =?utf-8?B?eklTNmdXWHY3Um9Dc3o3aWNFTEFySytZcXd2ZzgySUpEMFEyMXY1UGNkcGl5?=
 =?utf-8?B?cWZqOEp4NVVFNXVoektmdjM2QmtzSDZnK0ZpV0lwbXl5ZXFFN0JYV1hDalBM?=
 =?utf-8?B?eHVUY2UyYnluMGNvemFZN3pZbnI0bmJ4ME1mN20zWFlzQXNEbHVLQWE5MDlT?=
 =?utf-8?B?c3lsczdBREtyb3pBcDdHV0hFTzM0SGxhNFFKNDJXdTRvVzR0Wmg4Q2tkaEc5?=
 =?utf-8?B?dS93NWEvQUpxUlFLczI5SUx6em0rYjhnZUZ5WWV6T1FENFNhWHlOSGhvd1Vj?=
 =?utf-8?B?OUlsQ2s5bHd2RjNSMTgxS1FlbW9HL2RYdWQ2aGRQVDFhcmVIZUg1RTM1ZjB4?=
 =?utf-8?B?TUZXQ05CVDBJdStaeUpjeDRjSlkzUGkzQkMxK3VkOHBXK2Z0UUxSWEUvbHR0?=
 =?utf-8?B?YlNEWUIySUY5R1ZMcHRTTWpXbDFOQXY4OU5xMUg5VS92UVlBK3pZSmRmMk1N?=
 =?utf-8?B?T1R3R0hicWhmZ2crTnN1aVloMzZOZG9oTy9YWldsa3QvRVlETlA2R3JEckxV?=
 =?utf-8?B?QWg4VjZ5R0VxcGZLZVRpV0tXcm5zMmZEOS92d0Fjbm5FdTZ1SlJ2SFhNTTVt?=
 =?utf-8?B?dXNON090dmxJUThlU2g2OVRDeTh3QlNaMFcvbUJtdEU0V1RlQkR6OTNpZi9i?=
 =?utf-8?B?dG1nM0JaTGtoWDJHQ3RpaEFXYVpHZkpUbHNBSTI5Z1A0YitwaTBJclNsdC96?=
 =?utf-8?B?S2lpUXNORXRuaUdMSmFTVDhZL015TmFTNHAzek5OSTNqejd0RTE4T2RLcHB4?=
 =?utf-8?B?ajVyeFV5OEx5RHZycksrTFVJak16SVprMVFRanl4elVaTEtzS05HTXdKdmM2?=
 =?utf-8?B?WUJJVEhpcTlBMjJ2aXdBWTJkb20zMWh0N1dVWnA5TUdZVHc5NzA0SE1QQmxm?=
 =?utf-8?B?akh5NUU3L0xQQUZXMEcxeUtWcVN1SFlzWGxJcUdkNERyeUhtZURSTUw1RWtk?=
 =?utf-8?B?N3BEVlNpYnVjR1dpL0ZpNUdTL05xa3c3VmFlV3FHWVVrSFB0dlM2NEhELzAw?=
 =?utf-8?B?WjNoQUdTQUJ5S1J6RC9YZ25ocGI0azZWWnMyaXI1M0NlT0x4Z3pYblJSakVo?=
 =?utf-8?B?TkVrTG42bzF4OFJValo5dDdoeUtmbGdLRnYvWFB2c0dtT2FIZG84Z2tPRkRV?=
 =?utf-8?B?R2dPQXlqdUs3c3RqYVBKV2pEZGtNeFd1ZUdwQmlOKzl5NnlSQnZzamRsVzB2?=
 =?utf-8?B?L1BXeGJqaXNNclRLcVZiQkE3MjNkSDNLYllsWlNNemRGMnZsMk40d01veVRh?=
 =?utf-8?B?eGtaNXNMd3ArT0RWeE9BbGU5a1Vpb2p4bVEyWUY1dmtLRVlzQ2xCZ3hnUU1v?=
 =?utf-8?B?KzNpTHdzY0FVdjhHQkVVMU1wbVY0NUZFbEgraVJndWZhdXFtaHFqbWlZdXdO?=
 =?utf-8?B?TmRRTlFWWEgvalJrWUFJWEh0M0lWbWxINGgrMFVTckxiSEVTQVR0empXYzR3?=
 =?utf-8?B?cWFhZGRaZUt2UWRUcE04T3V3czFEd0VGVERXZnRlR1R4TFJzdDJhMFMrUWpq?=
 =?utf-8?B?Z1BDckdBN0txQlF4RWNuaWgrQXVHMVlKVzlRMk1qWStqdjdvTlNPQkJxdUdj?=
 =?utf-8?B?Z1VCQitKbXpuYk5zaThGNlRNZG9MTDE2cnpXaTE3ZEQ0SGVKMU5qdE5JUlU2?=
 =?utf-8?B?OERBc2Y4bkJNSUpaV3ZGQ2VyR20vaEFtWkJNTWdVbWZuOE1YZnU5ejJPNFZs?=
 =?utf-8?Q?+el77HLl696GYU+ivQY0SRdRJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e984fcf-7827-441c-fc9d-08dd60ad025e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:57:34.1958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v9ZZeytTDATivF4rHk3Y67p6TB9ObQvwop4HHi33ei66M2W0z/HFy8WlBX2LSMG/JLa1hvdSIeW/uVo6hFvAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
Received-SPF: softfail client-ip=40.107.93.79; envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


On 11/03/2025 15:04, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/7/25 14:45, Maciej S. Szmigiero wrote:
>> On 7.03.2025 13:03, Cédric Le Goater wrote:
>>> On 3/7/25 11:57, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> There's already a max in-flight VFIO device state buffers *count* 
>>>> limit,
>>>
>>> no. there isn't. Do we need both ?
>>
>> This is on a top of the remaining patches 
>> (x-migration-load-config-after-iter
>> and x-migration-max-queued-buffers) - I thought we were supposed to work
>> on these after the main series was merged as they are relatively 
>> non-critical.
>
> yes. we don't need both count and size limits though, a size limit is 
> enough.
>
>> I would also give x-migration-load-config-after-iter priority over
>> x-migration-max-queued-buffers{,-size} as the former is correctness fix
>> while the later are just additional functionalities.
>
> ok. I have kept both patches in my tree with the doc updates.
>
>> Also, if some setup is truly worried about these buffers consuming 
>> too much
>> memory then roughly the same thing could be achieved by (temporarily) 
>> putting
>> the target QEMU process in a memory-limited cgroup.
>
> yes.
>
> That said,
>
> since QEMU exchanges 1MB VFIODeviceStatePackets when using multifd and 
> that
> the overall device state is in the order of 100MB :
>
>   /*
>    * This is an arbitrary size based on migration of mlx5 devices, 
> where typically
>    * total device migration size is on the order of 100s of MB. 
> Testing with
>    * larger values, e.g. 128MB and 1GB, did not show a performance 
> improvement.
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>
>
> Could we define the limit to 1GB ?
>
> Avihai, would that make sense  ?
>
There can be many use cases, each one with its own requirements and 
constraints, so it's hard for me to think of a "good" default value.

IIUC this limit is mostly relevant for the extreme cases where devices 
have big state + writing the buffers to the device is slow.
So IMHO let's set it to unlimited by default and let the users decide if 
they want to set such limit and to what value. (Note also that even when 
unlimited, it is really limited to 2 * device_state_size).

Unless you have other reasons why 1GB or other value is preferable?

Thanks.

>
> Thanks,
>
> C.
>
>
>
>
>>
>> On the other hand, the network endianess patch is urgent since it 
>> affects
>> the bit stream.
>>
>>>> add also max queued buffers *size* limit.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   docs/devel/migration/vfio.rst |  8 +++++---
>>>>   hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
>>>>   hw/vfio/pci.c                 |  9 +++++++++
>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>   4 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/docs/devel/migration/vfio.rst 
>>>> b/docs/devel/migration/vfio.rst
>>>> index 7c9cb7bdbf87..127a1db35949 100644
>>>> --- a/docs/devel/migration/vfio.rst
>>>> +++ b/docs/devel/migration/vfio.rst
>>>> @@ -254,12 +254,14 @@ This means that a malicious QEMU source could 
>>>> theoretically cause the target
>>>>   QEMU to allocate unlimited amounts of memory for such 
>>>> buffers-in-flight.
>>>>   The "x-migration-max-queued-buffers" property allows capping the 
>>>> maximum count
>>>> -of these VFIO device state buffers queued at the destination.
>>>> +of these VFIO device state buffers queued at the destination while
>>>> +"x-migration-max-queued-buffers-size" property allows capping 
>>>> their total queued
>>>> +size.
>>>>   Because a malicious QEMU source causing OOM on the target is not 
>>>> expected to be
>>>>   a realistic threat in most of VFIO live migration use cases and 
>>>> the right value
>>>> -depends on the particular setup by default this queued buffers 
>>>> limit is
>>>> -disabled by setting it to UINT64_MAX.
>>>> +depends on the particular setup by default these queued buffers 
>>>> limits are
>>>> +disabled by setting them to UINT64_MAX.
>>>>   Some host platforms (like ARM64) require that VFIO device config 
>>>> is loaded only
>>>>   after all iterables were loaded.
>>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>>> index dccd763d7c39..a9d41b9f1cb1 100644
>>>> --- a/hw/vfio/migration-multifd.c
>>>> +++ b/hw/vfio/migration-multifd.c
>>>> @@ -83,6 +83,7 @@ typedef struct VFIOMultifd {
>>>>       uint32_t load_buf_idx;
>>>>       uint32_t load_buf_idx_last;
>>>>       uint32_t load_buf_queued_pending_buffers;
>>>
>>> 'load_buf_queued_pending_buffers' is not in mainline. Please rebase.
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>
>> Thanks,
>> Maciej
>>
>

