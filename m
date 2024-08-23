Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA84C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 16:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shX5q-00080b-Jv; Fri, 23 Aug 2024 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX5o-0007qU-Cv; Fri, 23 Aug 2024 12:24:52 -0400
Received: from mail-mw2nam12on20602.outbound.protection.outlook.com
 ([2a01:111:f403:200a::602]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shX5m-00060y-Cb; Fri, 23 Aug 2024 12:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqSviI+iPW7Spp6KBqZLd3gq03zL1wMsWmWFVaiC1HyA64WAhfs5EfDnaNFruhivs/L6sNCCpIp2RRpzEhwwODj9EGnUAYZXCE00UFNqiZauh6A/9TJ9CnlervG+fjxtoiHUUmP8zsumw6CCHW25H9S6F/4uS4FXC/aUlAnOIlaf62oWEHHkGvyncxzPkE7ODqhh6UbDG9BL3Ixi7Y1UZig5jqz9DixsA/4BX6pQEQxrq7ol034s28iUDhiwN9QTxCWZJD9YQ5V5jKidJp1H+cWiMdfJNlk99BnlqPVIhDzWewWbuOSi+JHYDQ5a4ZI59NYZVsILhrXyTYQ0tILw0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6n6xI7D7UctGVsEMgKr1S7iWJMSLF0IJdTRjUy59GY=;
 b=oPWqguKSPYyv5ybsloqdvkhcnJKpQnaTM1dTENG4NsP6rQ/eah2xBYihbBmTXI0/xmo88jy2G6okEyKPPH+zZroDGAzY9Ffwv8tj6XnfIOHqQ2Tb0a8cGN2e2ZpUhl80F4q6ucxNXQw/ICax6KX2foSChZoOD37YKvlzHQb/yyPQJTitIgk6p+/7t6IN88LcHzWImjOWN3tzzL1ZoXm6SHDEE1vRgzbf2z/uZSoCvsHEjGomuvM3O9JZylvZBXFWPoYuwwVImECEi+c/Og5zHIlWE8QcaCzcGG+mHhcweNf8cKuhXn25bySmftACLeiy9e87TJ2IchkX7nQHROmc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6n6xI7D7UctGVsEMgKr1S7iWJMSLF0IJdTRjUy59GY=;
 b=zJ7hQsbvTjF0UWCv/4U9n0te9POjsCF9IgtgSrfLnaMpGjVt//wMcHpRSXwhXSXOYQARPz6TWleYJEscgRmZQkVHZVLCQS8i8nh2sLpkHFxekc3pmZRPQuxsZetQ9qgoeRwxfV5rWDw6DBlKTjCNrvhZ35GN5GqrVFvQNmwkTf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 16:24:44 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:24:44 +0000
Date: Fri, 23 Aug 2024 18:24:37 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 5/6] hw/misc/xlnx-versal-trng: Call
 register_finalize_block
Message-ID: <Zsi3xZ5oibns6MXN@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-6-peter.maydell@linaro.org>
X-ClientProxiedBy: FR2P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: d622d938-dea5-4ce5-1d04-08dcc39018da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUJDMlpTcmdiazQ4Yy85V08wV0NWRjdxMi93cm1qa1hJZGRRSmJBSnpoc0dp?=
 =?utf-8?B?aklPNFJKbTY1VUlyQ0VVck14ZGp0MjB2bGtrc3o0aUVYZ054dlQ2ZjJhZ0FK?=
 =?utf-8?B?KzlTa3NFdWlJNXlqRWhlOWZycis1N0ROeDUvblI0ckpRYmtMd0pBelpuV2hU?=
 =?utf-8?B?RUkwUGtKNUJmZkpCZG9oMzJ6aFZyRWg5VnROSVRHaVNvRUtBU2xyWnJGaDM4?=
 =?utf-8?B?TTU0Vyt6UlJQTVRnVmZremJqK3NyYm1iQnBmYmQ5MGFuMEpoZjhEcVNsU0NI?=
 =?utf-8?B?azdJcDRCeDExcENrTjZjM3M2Szd5bFFwZ0NnSWcyTUlJa2NoNnVJYW01blJQ?=
 =?utf-8?B?bXAxTUxHV3pXQ002MVFMN1laWm9TekNRekpob3BFTS9FeG90eElNbEsyZ3BZ?=
 =?utf-8?B?ZEhCd2ZtNDA4dVN5T0hrWWo5WEUrZmh5dnZWZy9IYVpEOVQrYmdVelBKUksy?=
 =?utf-8?B?dEpWTDkzaFZYcUZYdXZCSlRmdU5OdEZVRW84TU8xb2xIMGhxZFpINU1zczFr?=
 =?utf-8?B?QnpvazErY011VU11TjNYcGszcmRkd2ZOOERIb1k4WEpQcCsydEpYN1dISlg0?=
 =?utf-8?B?ZEoydldJakRhMkZmUFBmV1NWOFcwSlVPSHc2VDcrSjRmWUFIMUZPMnVOT3BS?=
 =?utf-8?B?V05QMmhmM1pZR2wzUk1ubnU2SWtTOFEzMjgzWkp0K1BSRjlkeW1UYXRSRjdw?=
 =?utf-8?B?UE5Zcm45UzNXOE0yYk01SjZwTGhYcGtmb09KUStLazEwK01sM0VIMWNBY25N?=
 =?utf-8?B?ckM3YVZuZVNuSDF6R05lVUROd2tkSWhxMDVVeE02RU0yWjMxZm00RW82T3Zz?=
 =?utf-8?B?a0F2QUVBMFFHR091Nnphd1ViK1E0bkpwUTBUWmU5Q2ZYSXN6ME4yNVNUTTB1?=
 =?utf-8?B?RmIvMituNmN4b1ZtK0IwdldZSUVCTkZFcmFWbTlSNW1OVFBqSnRjQnFScGdo?=
 =?utf-8?B?YzFLaWthK012MHAyVEo1RXVIb0FHb08wRk12enlYc1NNMnpjWDdFRCs2VXlB?=
 =?utf-8?B?MEpUeFdmK282VmlMenEzd0pubTFwN3BKN0gzMDQwNU9kVEV5Uk1Da0N6ZjNE?=
 =?utf-8?B?QTJEVUpBZHpiUnR6UTJpQWhzTjJrU3ZZYzc2Tk5lR1J4dXdibUNzWWplR2VL?=
 =?utf-8?B?M1JKcFdzaTZCZkM1WU9hbFJyZnVvM1VaaER1VTVMaFk4NTg1K1VCUTZZTWlk?=
 =?utf-8?B?M2RTWHdNRmt5TzBQa0ErbXRxNGw2T0lPcEo1UFdSa2lPcnFiczBuc0pheFhV?=
 =?utf-8?B?aDhqU280TFBXY1NSeVZVT0g4aERaZ1hKQWI3cE1FVzVjVXpuSlMyMWlsT1E2?=
 =?utf-8?B?MTN3QjJLZStBSitjRHRHakhXOXVGZVRNblB6by92YXBCZyt3c1ZsUTVZL2Nl?=
 =?utf-8?B?V2dZZXFyRGtzVFhiUjROUnRGajJ4WFBaeUw2YUxHN3JnRDJOc0cvMkpEQmRl?=
 =?utf-8?B?cWZJaTFCZlNJL2hlK1ZWUkpXQ0FyTmJ5a3RMcVNQVEhLdkJnVnFTcUFPQVcw?=
 =?utf-8?B?aHcxdWtNMFgrdVlVaVlKTmgzVHVBY3RBMTNBa2xWR05GZGFQTk5aa3dERkhq?=
 =?utf-8?B?eGFKZmdnbGRFVXFFa1ovTGsrT1Q0djU3RFF5TDBpcjcyeHY2OUJkaklPL3VH?=
 =?utf-8?B?a044ckdDNUkxTHNxRnZqR09OWVFQTVZrTStXOFFHRGwzZjRkQ09nS2RIYXNu?=
 =?utf-8?B?VHRkNVJKeVFnemphMjJlTjlOREhYMVM0WEZjdWlPZlNTUVUvTnpCZllqUWdr?=
 =?utf-8?B?UitlUnc5bHVMLzlhelRGNjJaelBiTXFCakMvV3E2ZW5majB2ckVVdjNYYUVu?=
 =?utf-8?B?cTV6N29aZ1c0enkwRzh2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STQyVEovYXFQeXZJaGhDUzh3aVYyWG55ZklSMHdYSnRyUTIvRkhCYVBCRmFk?=
 =?utf-8?B?b1pyQ1o3aVJZdEtZVEl2T2VLd2xSK3JDOHExL2s4NU5UUTdQNEFKWXZPcmJv?=
 =?utf-8?B?T0J2MWJwc3l5ajdwUENsMjlpT0VUclZnV0xQNVVqNVorM2Yyb3BxajZsVkEv?=
 =?utf-8?B?UXB4MnZFUTVseU5vckp1QmFEREVVRklmRDZIVjBZQ0VZZjZFdFYyWFUwbFBS?=
 =?utf-8?B?RlR4c1NoZHB6RFJzTGRFRnJWNVZpK1pMM2xoZjBkYnE4Q09BajhsMmpvYlpj?=
 =?utf-8?B?blJnSDV1bTdwZFlCcGNCdFA1WUZScmp2WC9QWjBVWC9zUS9GcFpycE9EMy9l?=
 =?utf-8?B?Yll4Yy9rTCtRYXlBUEZCN1hVNmx1cjcvODdzVTNjdmdEU1BzWktKNnFHUnF5?=
 =?utf-8?B?MU9OSmxwLzJXOGNDZUJCTjFYTEhBbW9RdmNMZm1hVk5Md1o4WjVYYnd1SDBJ?=
 =?utf-8?B?MTI1cnVTOXNidjZJWDhkOGs5T0ZvL0paOVpCd3MxYWVtdUhiSlIwb0pVdTZp?=
 =?utf-8?B?T2RIVWxwVGJFdG1YdkRHT3EzMlpTaXEzOEJYY09VN0pCVEVpVzhUa1BRRUVq?=
 =?utf-8?B?QU13TThNUDQ5WlFFMUQzS0hOb3FFS01KeWtoNENqL2RiZ20xZlp0MEdBbCtK?=
 =?utf-8?B?MnR1SGYvZS9nZWZoRS93c09NSGNjT0FmQXJTREVaVEVWNnE1NWIvakRtZGxF?=
 =?utf-8?B?NW1Rc0hnY3FWZFBFWkpCY0J0R3F0VWlaTnlTUUZHSGl2MlpvZnRpR2hlWDVM?=
 =?utf-8?B?QXdjK0xZNG5lajMzMk1IK3g0V0dXNERLVW0zUGZRWlA1UDRmcUpMcWc0RnB0?=
 =?utf-8?B?SHV2RkMrV05GdC9uTjNBcGVKYndnUjdtK1F2eGZHY1BnOGJIZWI3dGRXU3Vu?=
 =?utf-8?B?ZXEyYm5OUjI1eVFEdFBOaVJhampWVmV5a29tSk9wWFZSMTVXdy9vZjFRaHN2?=
 =?utf-8?B?clRoaFlZNjZIVnZ0elVpblROVEU0N3ZBWEwxNW9IZi9mOW5xeDFLZld2OVpO?=
 =?utf-8?B?Z0VDK2xiMTVhdXZ5dkIxdEpDdFlkNHVlWjhXMVo3L09tQnMzVnlrK3dtSkxF?=
 =?utf-8?B?UFJHYis0Nlp3bmpmSnA5YmhVOUEyYVhJZm9WQ2FNeE1IeFd4dXBiQWE3L0w4?=
 =?utf-8?B?bVJGVXNqRkwzRHVxZ3pGM29FTlFzaEVvZElXRk5QcnMxM1NjNG5KQTZjT0dK?=
 =?utf-8?B?bWsvRjd6M0REY2FSVFU0a3J1Z0x0WDlkNUhHendsRXJxT1phSEZzWE9abUNy?=
 =?utf-8?B?Ti8wUkFmbUlhNkhMZHdHNENRUHUzSmxIZTcxdng4TWNtWG5XdmpGWDh3bnhT?=
 =?utf-8?B?U0JxV2RMdVZ5MmNiRE9xcVZUNTkvNCtNNEJEOUE5eTRGM1IzeE1lbVVzT0Vi?=
 =?utf-8?B?UEpXS0VXdyt3bVZVMG11RUdibmVoVU1NRDNYdk5ndUEzU0YvT3pFT1JtSm1G?=
 =?utf-8?B?UWEzb0YwZFhQaG50VjVsTHAvSWFkekpGeXN6Uy9TSXp3ZHQ1eHVLekp5VWFJ?=
 =?utf-8?B?TFVtRGJ6OUxnWFh5RVkwaDNDL294VGYrVklXQnFURk00cFhFMjQ3NEJQdnVv?=
 =?utf-8?B?Y2I5dGxiKzBiRlFPa1Y0cStuSE9xekZROWdTOTNLak0zekdBbVppdnZBRnFS?=
 =?utf-8?B?Mm1Zc2JYcFZjL01BbC9menJES0t0T094RGZldHgxZ3lEd05PbkZVbGc4SC9I?=
 =?utf-8?B?cUFZV0E4VHJ0WE5wajZSbDNFNnllOVppOERUbllDMHNXT3drYjd0ckp6cXpm?=
 =?utf-8?B?bVRQczRyTnRENHRNS21RZ3FkYzBuMlZSa2RBejFraWtwTCt3OVBtcmV0N1Vw?=
 =?utf-8?B?dVVUWE1FMjl3aW5WTUhVRlBTQmNpazJERTBXTDIySW5ZUWZNTngyMFdoR293?=
 =?utf-8?B?cWZDQXpyWDN2cGRxc0RJVnZMUW1zNEl1bXBFK3N6UVM4Ym4yZzZoSjdoZ1c0?=
 =?utf-8?B?RzVBdlNrL1g0NU9sYVdRcVd0aFc3UkgzbThLUHgyYzFNNk1BczRSWjd1aDNX?=
 =?utf-8?B?UFZnaDFHNVg5YWYvRkk3ZWNZbWhITGhMdVIyd0lwNzZ1d1ZNSWpIWUNHZWFi?=
 =?utf-8?B?T0Izb0cyUklhSzFkaks3M0RldThDRmY3Q1ZOMm9VZW9KNE1ZQTlmWTBqQnZa?=
 =?utf-8?Q?bP3RYmYUugLlRokG8oQOCRLJT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d622d938-dea5-4ce5-1d04-08dcc39018da
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:24:44.1682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4glxoYnTnPZkR5o0sVLoy1RmYSwTp+JTOeHEH4LrBYEngLkdjQwE2ThAL9buDQKAa33L4XpPbqUXbERsTuKx2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
Received-SPF: permerror client-ip=2a01:111:f403:200a::602;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Thu, Aug 22, 2024 at 05:21:26PM +0100, Peter Maydell wrote:
> The TYPE_XLNX_VERSAL_TRNG device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
> 
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55842ec799d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 47496e53f3e779f1c7e9b82cbea07407152b498b)
>     #1 0x7fe793c75c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
>     #2 0x55842f0aec5d in register_init_block hw/core/register.c:248:34
>     #3 0x55842f0af6be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55842f801588 in trng_init hw/misc/xlnx-versal-trng.c:614:9
>     #5 0x558431c411a1 in object_init_with_type qom/object.c:420:9
>     #6 0x558431c2847b in object_initialize_with_type qom/object.c:562:5
>     #7 0x558431c29d1d in object_new_with_type qom/object.c:782:5
>     #8 0x558431c29df1 in object_new qom/object.c:797:12
>     #9 0x558432427c1d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/misc/xlnx-versal-trng.h | 1 +
>  hw/misc/xlnx-versal-trng.c         | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
> index 0bcef8a6132..d96f8f9eff3 100644
> --- a/include/hw/misc/xlnx-versal-trng.h
> +++ b/include/hw/misc/xlnx-versal-trng.h
> @@ -50,6 +50,7 @@ typedef struct XlnxVersalTRng {
>      uint64_t forced_prng_count;
>      uint64_t tst_seed[2];
>  
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[RMAX_XLNX_VERSAL_TRNG];
>      RegisterInfo regs_info[RMAX_XLNX_VERSAL_TRNG];
>  } XlnxVersalTRng;
> diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
> index c0d1dde8708..86905479b8f 100644
> --- a/hw/misc/xlnx-versal-trng.c
> +++ b/hw/misc/xlnx-versal-trng.c
> @@ -608,9 +608,8 @@ static void trng_init(Object *obj)
>  {
>      XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>  
> -    reg_array =
> +    s->reg_array =
>          register_init_block32(DEVICE(obj), trng_regs_info,
>                                ARRAY_SIZE(trng_regs_info),
>                                s->regs_info, s->regs,
> @@ -618,7 +617,7 @@ static void trng_init(Object *obj)
>                                XLNX_VERSAL_TRNG_ERR_DEBUG,
>                                R_MAX * 4);
>  
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq);
>  
>      s->prng = g_rand_new();
> @@ -628,6 +627,7 @@ static void trng_finalize(Object *obj)
>  {
>      XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
>  
> +    register_finalize_block(s->reg_array);
>      g_rand_free(s->prng);
>      s->prng = NULL;
>  }
> -- 
> 2.34.1
> 

