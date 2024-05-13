Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4392C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vwy-0000Co-PO; Mon, 13 May 2024 09:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vwu-0000C8-Hn
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:42:40 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vwr-0000U4-Jw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtSchbTdOVu/d0KbK8J26hnRaDVcark8CVDqki+k5XVCtdBGSLupw6RIVNt9mfx30L/mCcIci2jCXcR1E4fU9i2sIRSOB/FACkx0T1gMsRYxLiKd4kjkS+BQkbOuIgkvoeJyWjGvl2TAd0N8RUmeemmF0kM3gf4sdnE7KwHcpuPXK0X2/Sup/6YfjUS9Ien9FZCh+Zbnll6AD8pLHnDpRBMd9sZGHx9ZIfEkhAiTrp2oDq7msnu4JYJa79NAMHFmOTOCufoG0sMSp4JHdnUEJny+E7FGvS3VwYNYfcCB/LySDcsDPVTe/qDctwNzpu2DeA4dW2rpLVCAx3yi1S7RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaGt8pufxqdXJdcnR3NkwIs7R4aq6dvIWG6Ue4WhPQ4=;
 b=PoSd3heSqrDzD1TiL66siWzMIsuWQQZbGbQRlKXSVvdL3/4wpSQvNyeIq2sXJIjWpRSX4exT0/QMGNk+xowXkdTlyTl/Ms4/3Nm0xkqJ0oj17DzXwbeW7JB61qoamKnCgLtDngTGdm+GNnOzHv2GCtrW44kviYs7JhO/34eeeJxB4HxQsrQUocYJnCvNi5VZuX3Y5rXncAKAHyE9IXDj3wLjdISZzZ3zf79HwO383DskRarbZILxccLnFmO8u9+DZpyqiMi5T3LtvT2zGSh3KxcjNXIpMSyjzm6kTtsTueJGP92otZGp9QWBkvknmgPd/l9OcHBgoYoV9U30hPX4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaGt8pufxqdXJdcnR3NkwIs7R4aq6dvIWG6Ue4WhPQ4=;
 b=AnGWTzfoid4F0tu5rmK0I5EBvVVHuDUBJF0Nytifkf6ngYElWIl3JygUs8/eSDY1lzIw5Ia8VUTkTiBlt/Gn8IsIsemEPocOJzEynXV4tmZ4IcnqsbzxqVCFjHo8w4TSLnj/P6mg2xJmChCPTc6FzPsj1vBTm0q5guKAjPqyN1gHpSOELYVLueG8+g2TRONG8nTq1DRp20gUU2XKmofm2o2nfMKfcic7NIh9dlgR+gLoImCWaJCRRrf+6lD9tgKlrIwJlR5Juu9jrXbath8gmLEfev5R3Luwc7+PGggxcJ2FiVXTfOnUSVE1RBZep6vRgT5M5iZxHeFE3U1dKIhayw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:42:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:42:26 +0000
Message-ID: <12989e97-362b-4ef9-9b3d-1f5550e393ac@nvidia.com>
Date: Mon, 13 May 2024 16:42:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] vfio: Reverse test on vfio_get_dirty_bitmap()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-7-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::27) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d50bb9-cb92-40ac-4c7c-08dc735286d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3hoK3hlaExDbUMxY0kyZ3pIZzRBSjMyRXVqc0dmYWFraWd4cDV2U2ZkTUY3?=
 =?utf-8?B?ZUZ1L2FtWWR0YU42MTB5MUt6dk8rSXAvTVhlWjlFWlE2VmQ0bDV0YkpBTXpF?=
 =?utf-8?B?QTMwdi81L2R1OEpJTXcvNW0zNncyYnE0M3VvZXR0OTZLeVArZi9BeWJwVCtM?=
 =?utf-8?B?Uk00SGtsRVU4MWxqMDliNEJYd2N2QjVRN0xWR0JvUTh6TGR2ZjcvZlREWFZy?=
 =?utf-8?B?NTFINVg2bEFLSzN4Z3JwVjMvNzB1K2cyY0h0eGY3eVA4VzRGeldMSnk3eFpx?=
 =?utf-8?B?NjBUTCtERmN0djIwMDc3ZWdxK25wWE8yaHV1WDRCc25ERlduOFJkeittVjN6?=
 =?utf-8?B?WmlZeUV2SEFTa0loMjFwZC9uM1AxcFlyMmNBNjBJNTBpdHNFRGtPZ3R5Tlh3?=
 =?utf-8?B?QlgwaFR1ZFo4bHRBNHptcUtzV1FyemMrSXBwOGg5Z3hRTXBsaVZENEo0S2o0?=
 =?utf-8?B?S0ppU3lubHZJL1R6QjRPQWhraSt2UUJJMmwwckQzVXFGSnlROUYydi93UDZq?=
 =?utf-8?B?bWRTNUp2RWl4cGs2MEhnRjNVa0dCdEg5RmVLeEUwNzFVYkZaZ2tlWTFrSWNp?=
 =?utf-8?B?MFVwYmp5WW56dWUzOFhKN0pFRCtVSEJIa214d2oyd2o5b0hLSFAwenF0MHFr?=
 =?utf-8?B?UjhYb0ZIMCt4dVJVOHU4My9ZMjFoeTVrRkRaNXVTUmZ5a1Y2UjVXSEs0VFFU?=
 =?utf-8?B?QVBFZWd1Z2htTEtTeEJFSEJhYThDQU9jRGhDS2FpZmVFTVlnUmkybmM3RE1o?=
 =?utf-8?B?eUlycEJLU2o1MmdSL0pYWFhBd1JWZ2xneTNjelk3MGszNG5kSkgxdXFOVVB0?=
 =?utf-8?B?MWdrNndkUXh2NlRncjNCNi9HeTZ6UGdvWWc2R1ZVOEFwSzhlL2JWZ1pUaDA1?=
 =?utf-8?B?di9ScUNmOVVlT2tYaHhscHJTeU40Uno4ZGV2Tkt6WTBQZ1VtZzhYQjFrV0ZZ?=
 =?utf-8?B?YzA0Sng0U25OMjh2Uy90UFpOTU54N1NReVJicDJjQzNpNFpvL1pIQTkrcDkz?=
 =?utf-8?B?S2RCUDE0MGF3TGpXZERHRm8wU1JnWS9kUlFWZ1N5MnZRblZwOW1FQ01uREF6?=
 =?utf-8?B?bmthcjBZVkdXT2N6dXZCTWo3ODhHaWhNaVpVWUJtaHYxNTlRT2N2L2xTRGZQ?=
 =?utf-8?B?TTBVNklxYXg2anFsWlg0dHV4Ni9DYVpPUWpQRVd4MEFmblRUT3EvaEtwcmhT?=
 =?utf-8?B?MVNhcDlHM1ArbzNIZ1lxYlVOYjZOUmkyQlo5SXBReS9qc0FyMEJIczcwNk1Y?=
 =?utf-8?B?aEp2RFZtK1dyaThibzFJSXNDSVRiQklxNG5TMVdyd2h2eVRubFVGRXZWYk1y?=
 =?utf-8?B?OEhZY0lvV1QwTG5WRHM5N3BSU0JockhGVUp0NGoxZEkxaWZRSFMzV0lOTTJO?=
 =?utf-8?B?ZlE3dGlkQ01ZMmFtZDJLWXRYcTdEa2hIUUxJMVZ6aHp4NGlrYkhveG4wUy9I?=
 =?utf-8?B?M1ROaGlPOHJRWE5NanZtT2plQnpTOUVOSjJtZml0cVhoZVVLRG5POGJVQXZ3?=
 =?utf-8?B?TnJaVkdRNkJDTEl4R1E0ZDg0Y01BY3RBbkhXdUZaR0M0TmtvZnkwZGw3ek40?=
 =?utf-8?B?cHA2M210dkM0SXpRV3duOXRPa0JTcjhIaG56V2ZMU1h4SThFdVhSeUVkSy9T?=
 =?utf-8?B?MnAzclBIZ1RBbVJmZTdkYVRBRWxkeko1a08rQzF3MVN1WlBYM3k2dFRmcVZK?=
 =?utf-8?B?aTFWWjFTek1OZzVyaGRXbHg3enpjL1JWNXR6cGFrdVE2OFF6NE9Fa0hBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RMSEJQUm5OUXI0MFN4OHZLdnJqY0xBeHRIdkFoNmtaWGdmbWhwZmxkNVdG?=
 =?utf-8?B?S0JjakQ5ZXE2NUVLSzIwNCsxTWhlUERhYUxLMUk0dTl2Ym01WEdEMHMvNnNv?=
 =?utf-8?B?VmtrcnJ0NXdreGNzTUtLNFZBV1ZOcDl5aTFKRk1uT01IM3F0b3pDMEMwM1RO?=
 =?utf-8?B?cUh4VEhvSGtIZGZOdXNPeGhHNmtVTW55ZGkvNDNKQktNMzhpSWhWQWlZSndn?=
 =?utf-8?B?M2xXMm11cUpaSDcxdVI5aFVBdTMxWUZBNnd3NkNuU2YvaE56a0xPdWlmUFdw?=
 =?utf-8?B?ekxIbWxGTUZWS3lkMVcyUi95K2hvdnhoOXBFNkpGQ05DT0JqblBZeGp3ZFNP?=
 =?utf-8?B?a3pmb1FaNVpmRXFEdTlNcjhXeGcvNWc1WkMyeWxxaFh4akVQZXkyb1JwWEc3?=
 =?utf-8?B?VVFZTDN6VitmSmZhTlRoaWhVOXpCdlg5Vm11M0w5OHZ2ZjJjNmhGZGFySjBw?=
 =?utf-8?B?WHVtN3VwV3N3azNJd3B2Y1hyUmQzT3dORWNGaDRwYXdRM20yOGRkemxERy9p?=
 =?utf-8?B?K0d6ckFhajhxVVBVWkNRcWR5VXJrNitKRWJpVG9QU0Y3dHFBVTlFOUp1Ujgz?=
 =?utf-8?B?ejcvcjlwSnI5c0ROcy9wZnRBZ2tla212TkJNUDJUTHZRbklFQTZLY21hR0Np?=
 =?utf-8?B?RThLWm1DMkRyM3J2eFpEeFZLbTUzc2h6SENwOWhOZmljVEF3Ri80SFlSNmdl?=
 =?utf-8?B?akRIcTZ0NEpPdDhMNElZWG9sQTdqM3pyeGRKRnVvNnp6QzZhb2loYVpzbCtm?=
 =?utf-8?B?UHFJNG9kU21FYnZvQnI3ZDg3QWVORjN0dEEvbm5SbDdqa2ZPdkdOT0dVVnBu?=
 =?utf-8?B?RnlsckhUdFNCUTFyanJLVFdkYVFuSVBuaGF4TkR6K3hZMVBMZ3BOdGsydWFX?=
 =?utf-8?B?Zzc4Z2FZWHFQaDlKVFArOVlFaUswTnp1aHFDVWdlR1FNNHl3NGIxd1ZqS3Bv?=
 =?utf-8?B?bHZoSVVEaTZsc04wTUtVS21kR1V3d01FTThITDdwTWF6L1NFWnpXTG16ZkhQ?=
 =?utf-8?B?OEY2TFE4cjhTWUlaTi91VUVBbnRFY0JoVmtCaHJDVWpoMGs3K2hSaWdscEJL?=
 =?utf-8?B?K0ppWkRJWU8zcXV3RHdBQUMvRHBnSUpYaGx5MmFVcWxVL01jQjV4V2hTRGNX?=
 =?utf-8?B?U1psbkhpekpqQ0c0b0svSjU0UFpTRkRGTGpmY3BuekRJWDRrd2hhbDVkNlp2?=
 =?utf-8?B?eTFldlU2bENrY1dmcmJSWUZWT1ZLM1dnb1NpVTZhU1BSUTVPb2Z0aHVRT0Fs?=
 =?utf-8?B?YUtQbHZBWkU3R0M2Z01Kb0NOVENZVGxDeHFnWUlzMFhLeFc3ZjRKOFMrOU5D?=
 =?utf-8?B?THJFckxKRE1jU1BmMlZHbEhWVWZwcmxWckhnd0VoZlZoTk1DeEFMVmcrbVhm?=
 =?utf-8?B?S0hkVEZ5QVpjdXZJUEpKcUxReHlaa2dtMEl3QkhNWlN6UVdndnNHdU9TWm1i?=
 =?utf-8?B?cmE4Tk5qeis3RDNIbkt4WVl1a2o2MXBvaldlRmttRXFxZStwWXdNa3ErRTcr?=
 =?utf-8?B?SmFBWjBIK1N3Z3RuZTFiZmE3QkNPRFVGaWVIZjJNRGlFRlpuSFJmVGpUOUJS?=
 =?utf-8?B?QlZxK1ZqOTJ2aXZmOGIxNXBoMWgrMERDTFc3SUZWRjBIcFc3STRQM3p2K2di?=
 =?utf-8?B?QUF0OXE2a3paUEN0U3krcTJSR20zbXlNb3h1R0JmSDlyNCtIYU0wRWUwcFUr?=
 =?utf-8?B?TzNVTHdjcG9QbHhEcTdlMTNXS1VVYm5yNEx3cUluVEo0cmMzZUhQUkNkekVL?=
 =?utf-8?B?Ym51WE9INVR5MXhvT2ErcTZFcGpqMUNHeGQvY2YvaWlQU3VQaG9VVkdDUDhV?=
 =?utf-8?B?ZGFqQzRvMXR6RkZMaGVYRkl2eE5sc0ZqUnZCQUV3VHZoZkVhTjluRDlqdCtu?=
 =?utf-8?B?Nzk5YlpRbjZnWXF6Zjk2L21SWE81MTBMNU1sQmt5bGNPT3pCblFNdWdtdnZL?=
 =?utf-8?B?YTd5emx0RlhrVXpaVW5MSFRveUl2TGNPUGZDL1BPL2xhWGJUN0M1cCszaTZO?=
 =?utf-8?B?Q1d0bTBJeC9xelhCSEwza1FOMzMxb0VHNzdCNnMvUTFST01xWnhxajgrRjlS?=
 =?utf-8?B?TFo0a1hKbnNBYjZXaW96WDduZGE0UmZxelV3MDJIR0J3YXNvelRUUEI2SEtU?=
 =?utf-8?Q?m29WxqYC5oSpg9WfW7F+//gio?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d50bb9-cb92-40ac-4c7c-08dc735286d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:42:26.8662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZm463GdqZ0PNT2C+k/G2lKj08yWfr1aAzFxkgeJlyl4WPru8Ljws0XPFLSeqxWpbrO1CwfdwGadwGuh0xo9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
Received-SPF: softfail client-ip=2a01:111:f403:2416::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
Title should be: Reverse test on vfio_get_xlat_addr()?

> It will simplify the changes coming after.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/common.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ed5ee6349ced78b3bde68d2ee506f78ba1a9dd9c..b929bb0b7ac60dcef34c0d5a098d5d91f75501dd 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1224,16 +1224,20 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>
>       rcu_read_lock();
> -    if (vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> -                                    translated_addr);
> -        if (ret) {
> -            error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova, iotlb->addr_mask + 1, ret,
> -                         strerror(-ret));
> -        }
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +        goto out_lock;
>       }
> +
> +    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
> +                                translated_addr);
> +    if (ret) {
> +        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
> +                     "0x%"HWADDR_PRIx") = %d (%s)",
> +                     bcontainer, iova, iotlb->addr_mask + 1, ret,
> +                     strerror(-ret));
> +    }
> +
> +out_lock:

s/out_lock/out_unlock?

With the above,

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>       rcu_read_unlock();
>
>   out:
> --
> 2.45.0
>

