Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B11C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vDl-0000kE-3u; Mon, 06 May 2024 06:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3vDg-0000jq-If
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:05:16 -0400
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com
 ([40.107.223.85] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3vDW-0005Gi-7j
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGZKyTWMfms8sKqcujhAJJS5AlNbIgYnsoRMj1NJsHlSlpITOVWfwGJYejB5McDSqrRA43iuX/k4/XYKykSDKtzTBASQaaFMcrQ3gxoJyxsAp38OepIAAzvA9OyfTiIPbMekcEpxxuwZ8w0NmZpkAIQIkbZHSdOw27L5RwY1CXVv6ybks8IMA0WzE4PogtUHut7Uihz/2cZ3TOFomaYdBuw9ymND84cMB4ZyZHO/5Yg91nqdt7QeUrqwxDf7HJgvZ/9jsM1IfO+F5PDEuzZwGGI2523/VGrnzqJTJVm3j6lMXyx8cU5c90fHh54Tah9326or6Mha6QupV9yFbtAGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynmHdYPSyc8z+mZjX/f2izudT6JCtb8/VIzd+bS2C/c=;
 b=gHCSuDr/WRNJ0Hz9ShyKbxe92PsqVChLYLlCoYfIVq3m9oPK3Fbnz/YFMJCoGiN37V0OD36JUQJVXHTQMniUJW50o+AYXG64RCH9gGhPBNi0ncbT1wo0j/k5Fe1Qe94RqZleeeAB65yJzO1JTb9Tli8BETDDuNP+TWiNFstdBMiaRByGWfWFttj5fAV/asDj7M2BYNptWUwvMdPrzNRGR3yhSOf23CNbIBPcx1G9oP3J2dh+wtagkrurXbm+iQeKXRbCPx5hfeYUwnyDC3emMp+tT3J4rKuwVhP7bv5YuBaid4DHokWRS2V+MifNCAa9Fjx7YmvnvUr1vBbmz/+cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynmHdYPSyc8z+mZjX/f2izudT6JCtb8/VIzd+bS2C/c=;
 b=K5mzDGlUI/KG3SGgGjD+SLt2RDuSIw/cUgEZKGRzHLeloHcnj7HUq4lpfpN6rcK8ryZTaq0Buo35FxuWvSQULAQOUp5wqN0h1T2inlZsHaE6UCTlvrc9YMvdHhNX3Yk+XZXYPEPkhudubyLlN9oNZVa1Vt1fF1UlrwuQNa51iw2cO9R9tHV6dKiwtYB+sf5L+o7CJWuQb0XKAxPFYruKfm2o49DtJ2/+oXWMlxRzdMx9MpcFEqBdB5+1tB1rRW3VptpDhd50ok4WBZlBOIA/Sxj0QvyEmFnoV2f46d+EVPi3i4NfFpnr75cVPVwJo0IYEceJr1ijXk5GTivODB9T/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 09:59:56 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 09:59:56 +0000
Message-ID: <aeac0202-c474-4276-97d1-8329f357b6fd@nvidia.com>
Date: Mon, 6 May 2024 12:59:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com> <87msp88nrg.fsf@pond.sub.org>
 <3d6438e0-550e-4f66-8932-45191ff64b8b@nvidia.com>
 <871q6ftv5w.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <871q6ftv5w.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: c507b524-ea02-43fe-8608-08dc6db347dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXF4YVB6aU16alV6ZUkvUlFKYkduYWJ2cDRoSFp1YnltbFpZYjVLTWxlTTRq?=
 =?utf-8?B?NlovQS8vNkt4aUpRZkUxOHZJWHhpNEF1RWh3OWt2NnM3R3dzUG8zNmM5UFJE?=
 =?utf-8?B?SXNaT3JzdWJCZy9JNlNra2ttdzF2cmk0d2d1SzdDekRiVlp0YWQ2amsyS3J1?=
 =?utf-8?B?d0EraWk1d0hVODkrQjZjSEVRZTdySEtLSFoxUlp3Z3JtSVlHTDd3MzliTndI?=
 =?utf-8?B?MGJUU3JjcGQ4YnRaRGJXSWltdkVSc0lsVk44bEZmTVdjNE01aTBoV2J4bzJC?=
 =?utf-8?B?dkFiMXVVY2dhTnRlYkhBREhqVEMwYVk5UG0zRWYzRWprM053TnJ4RkZiVWRv?=
 =?utf-8?B?d1gvbUNGU2NwdjgyNjNaRWJsUkN4dlc2Mmo2dngyMXVpNjBNVG5nRDkyc0Rq?=
 =?utf-8?B?SkZFeXlYaDdrd1B2T1VTUHhCODYwbDBRdUp0MWNjSGlHaXBNTkVNU3ArODZK?=
 =?utf-8?B?MDZVQXZNVGRoZWhQQlBmWndlN2Q2ZFJyUUlsemZ6TGpXQ2pOQ0k1TGw2K3Iz?=
 =?utf-8?B?VEpseGsvSUxTclBDalNPQTcwVWFSZDVjOFpkN2t2M2ZCeWJIOXB5TWszaStV?=
 =?utf-8?B?Z3JRbUpQRzFnaWFxbFdlMy93Tlord0RCbzNubmhHdkZLMnN5bGVXaUhBWXJO?=
 =?utf-8?B?Q2ZtS1RzNHJVbThtbXJJZEdmSmpRYVdOQkZQUlU1MXF5THlaVUw4OFRXS1hJ?=
 =?utf-8?B?TkFaVWRXYkczcFo2eTJZYnVtWk1hN1dWenpEbHRGRTBSZkJmL01Ud0ZmR0w3?=
 =?utf-8?B?dUp6UnZSR2dWV2t4azV0VTVEbXVlMEQ1R3ljQWFSaEZMYVhQajFPckxUSUd3?=
 =?utf-8?B?MGdFUUNmakFCQzRjbnkvaURMRHRTSi82QlJxWTNHcHlRdTlPTU4zcVNESWpj?=
 =?utf-8?B?YXkwazRneUZmcWQ4UWdwdWxwQjlJMkI4TGxmTWt0MmhHdlBDNFZYSUhqUzBB?=
 =?utf-8?B?MXNmOVlhUUxpek52ZDVpMWNKN1N0MERwZ0pyWkpOdEhid0pNN2I5VEsxeGlE?=
 =?utf-8?B?MUE1dXdPUHhhN2w5Vml0SnBNNE83YzFONTdaK3lmRjBhNStWbVg1MUVzRnlE?=
 =?utf-8?B?TTNrOXRBeExvY1lxempEZFlwUmdQTjBsazBxNlNYWUw5aHMwNnF3R1IvYjIy?=
 =?utf-8?B?NEphei9hSVdjZGU5N1d3Ykc2VmZHaGY1dnIrQis5Y1B3aURxSVViOTl4bDNi?=
 =?utf-8?B?cGhKYU0vNE5kM0ZEL1FSRlJrK3BrRExGUHFmYnJOajdOT2VCczcxV0JIZ29o?=
 =?utf-8?B?NWErOUllSTB6Nkw5TXFRNHlQdjJvN3VQZlN2Q3h0OWV6d2w2WkFqZVVyM000?=
 =?utf-8?B?VEN3RVJURDhTYXZDREZhQ3krQzJoUGk2RVVDb3BVOUhJVk5STEZ2OWhXQWlz?=
 =?utf-8?B?RmNDOGxpbDhuR3VlZ1dEc1BXem1Yc05BUjNoeExFQlVLdDdocS9PcGtMR2ND?=
 =?utf-8?B?NWRDOG82VTJLWkdvNkJXQXFhVzJLdEg1Umg0aWNVUDhCRlFYZ1pnZWN1OVRt?=
 =?utf-8?B?anFzQktKSHQ1M1Ird2dHYWI3NlhkREVvSjE5SFlyRllkYy9Db2RGYmR5STEx?=
 =?utf-8?B?M2lhaTEvYzRaTGNrZkh4UnZzM3JSMlVnUEp0aE00YjhHQmsrQUNCZmRGWGsv?=
 =?utf-8?B?K04zNGxUSUw4eXFxeVk2WDFITWZpS1pBK3poQ2pITDZzVE5XSDE0Q2FpUHN5?=
 =?utf-8?B?b2RidHRSVCtHanluVnBIQWJCajg2OTNtL2dnaFdic2I5Vmx2QXZFVHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRDZndOazJXSys0dlBZV2FvcUtDUEJXQ0p6NlZvSS9lYVJBMW44NlpxN3By?=
 =?utf-8?B?emNiTGpDNXo5UzF4Wm9rbXdQWmlVaHpESjkxSDd6VklaTGlDSmpyZ3kvdThk?=
 =?utf-8?B?R2tEK3NhWDhJZ29PNE9jd1ZzUCthVDhHMTZxRUxHTEF0MS9OVkoxNklwSVNU?=
 =?utf-8?B?VWhZQldDc0p3YW1KMGNRdXprVU9GQlFCWW9pRWx5UmljWUhuZ1FES2pOaVIx?=
 =?utf-8?B?SFA2eWVYZCszcnc1bXJYUXNocTBHZVZQZ21BbkdzZ0dQZWROejZqNDNmM1kz?=
 =?utf-8?B?VVhLL3cxbFRTSFU5QWJlWmdQMUxDeFNQVTVyNVUzYjBrNEJ6NnNBYk9Ub1k3?=
 =?utf-8?B?VSszdXBzeENIVytieTcvWVcyMTNTdGtXWTdicTRzMkZ0QTdGdUR0WlJDVyth?=
 =?utf-8?B?NzdkSDBrT0tUNFExcFVZQml4ZzhJTUc4VzY1NUxNZ2w1REQ3UmlhQ0wyWmdK?=
 =?utf-8?B?MTJhS3VvcWJoWWtQM2NUUkJYc0puZEEzZDJ1VmRKY0FqZktsZWRVYVdndjNY?=
 =?utf-8?B?a1orMkNXY2VzMGo3aFhoSUY1d1lHY2N6bENJNDhXajgxWnhYeS9jc1VQN2I5?=
 =?utf-8?B?NkVFTXQ0V0NXaGVuTmNSaFBua3FkK1ErOW9HYzE4OXc4T2VVRG5ZOVJBYWM5?=
 =?utf-8?B?bmxFREZhY2o1NjAvaHJyQ093c1RER0VNcURzQUdrN2lFWFBOTzdSRXBqL1Ri?=
 =?utf-8?B?N2VmVks5U09TNmY5amtiV0g4ZTZuSk5NNGxYcnhta01KZnZKc2dYMGJXbmlx?=
 =?utf-8?B?UmFyeW9vdldaUkJPNDhmamtaWDRodUlGNys1eEtFYnRDUVJpeWZrSk5hNjhv?=
 =?utf-8?B?dXNpVzhPMXZGVVdiK01HM0hOZXMrcjN6bnNJODU3U3V1ekpKa1JZb2xqVzdL?=
 =?utf-8?B?VlpJRllENjlrRytwdmdKVUREdlJ6RkM2TG16NDFKOXBrdW10eGdZdzFSdWcz?=
 =?utf-8?B?LzgwTHQzb04zbVNaTjVUa3pES3YzcC9sbmpGQ1Yxb1phT2o3S1FwVmhaTHNv?=
 =?utf-8?B?WG1Fc2E5Mko2c1l2OFdDVHJTcGFycldyRDFDVzVuSytCYVEzRE1PM3Mvc1FQ?=
 =?utf-8?B?b0huZ0svRnRQZmZ4T2xCemE0ODhSZXAvOUgyOGhIakRCM0pZTzJnVklqZEZa?=
 =?utf-8?B?c244MnNWQXdIbVlOYW04anNBRlZVNitDTHJENGZzVFJmTE9PQnlqR1IzMVNt?=
 =?utf-8?B?V0J3dGZUMmtDakFFMFRCUFd6WitWYUpjNzRCdkpRZk9rcTJFYVpXemFOVEg2?=
 =?utf-8?B?aFkybFJDL1dBU1JpcXBGWGdsbmVISDkzUmRnMmlCdTh6SEhPaTNOOFg2UEtx?=
 =?utf-8?B?d1lPd0F2dXdjOUlXUURDak1uYXdjVmdzOW45U282M1VTdUxCSFhYVU9RbUEr?=
 =?utf-8?B?MXF0RmxqSUhtbTdpZWZCNXBxRXNFcHZoNlgxdDVwbFBLQy8vK2VtSWZVbS82?=
 =?utf-8?B?MURxc1JtVzhUZFpjMEFGb285MHRpV3pRT2RJQXA3Y2ZiSnhqdWpLbFU3TjJz?=
 =?utf-8?B?T2lGbkl3OVljaEtWTWRIWTVFZzhDZkRlWlpMWGJ4U3JOay9OWE9sSndSajFI?=
 =?utf-8?B?YXhNT2xCc0xPWnV5aXgveFR4STRXbm1wRmJKTC96bDlub0hyb2U2cUtFMDlv?=
 =?utf-8?B?TTZEZUxRdU9lZDd6S1BSYVpzcVBwSmdEb3BqL1pmeFdqV2dZdFNIVWNhVWU3?=
 =?utf-8?B?c0xFMjd2MlBBeFpOcjluaWhoNWtTaWlyZ0R5cFZPVFNycFpVS2tsbElFV3I0?=
 =?utf-8?B?WWYzQ3E2VFZDNDZaYTRvSDh1YkczVDRYU1FiVk1aQThQQ3dnSUZzMmpVeFdi?=
 =?utf-8?B?dk9NbFBwcjE0K05MdkJqZlpRaHZkbkh6U3hrTTBUaks5SDhPcVdOR2Y5KzNq?=
 =?utf-8?B?bWpMTVlFQWhmU1Joa0t1M3BFSmFJRjRCSEpzaG9iVDQ5L0d6dS9RREV4S3I2?=
 =?utf-8?B?UjVsdWV2THBlOVdwOUFYN2ROcDZjMENmcDYvM2hLNjh1azlpZG4zVXcwSUw5?=
 =?utf-8?B?RzBKS3Y4ZTFmMTJ5Q01QaW96VTBQbUszNkVrV2VRZlpCWmk5bGZQd0lhMWVD?=
 =?utf-8?B?d0krSDl5VFc5YktCK2JBUkpEZGZqM3dzRjJPZEpEUlJLbis0UmY3d3BHdFpn?=
 =?utf-8?Q?HsJKM0NAM6KMrnQf1hSPnqfmy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507b524-ea02-43fe-8608-08dc6db347dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:59:55.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Mouwyy2GBVCqN8seuYRVYU1zSsHV6fzFyMv41VO6zaknnx5byaC+b6BmdJyLo/0UPW3I2vQlLKEQQnavMpajg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
Received-SPF: softfail client-ip=40.107.223.85;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 06/05/2024 7:35, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 02/05/2024 14:19, Markus Armbruster wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> Add a new QAPI event for VFIO device migration state change. This event
>>>> will be emitted when a VFIO device changes its migration state, for
>>>> example, during migration or when stopping/starting the guest.
>>>>
>>>> This event can be used by management applications to get updates on the
>>>> current state of the VFIO device for their own purposes.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Can you explain briefly why this event makes sense only for VFIO devices?
>> VFIO devices have their own protocol for migration and a unique set of migration states.
>> This event holds info about these VFIO migration states, which I think cannot be described in the same accuracy by other events such as run state or migration states.
> Would it make sense to work this into the commit message?

Sure, it wouldn't hurt. I will add it.


