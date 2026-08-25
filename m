Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7809C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynES-0005jb-16; Tue, 25 Aug 2026 05:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wynEO-0005j7-Rp; Tue, 25 Aug 2026 05:14:09 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1wynEN-0005X4-1e; Tue, 25 Aug 2026 05:14:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/ZFKgMiTUh009jdqzH1ym4VzWmxHbszgyOi03zM89npS3TJJySXGSNJlKtpnCnMKLVwlddzwNoRZDUzfbCUe7i4HxBUnPeRnVKkESmsKODk0rOsqqslSM1tyBWKzIIOD7QkYZdqrfg2SEVBFKRn5s/1mPVFXr9N5MCCA7jJprkxHasLf0Ix1qi2XMRt4DYifOguK6XCGR77R/fVG1evOAnOOczaQXXqx4wUC8BTBBWQnJjlm2PehqDd5esvAfhp0y214zrww/1s54QsTxYACfKx7i/j+OxoG06goey2kE4zhDOuyAmWkPRpoIyAUZNBE1mnHK7u13cbIj5JPGZ/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8o3UsK5p4kAncOpSlmz8SJlAFleX8+H4gYKuouKcJ8=;
 b=h3826yK61xq4OcNrYlL5itSoxzvnLufEDmk68gVxv0rsIpNffqjI29ZQ5qmLR9ahGN/3CAbF4jsdml9y4zSUd27QlLOmFrRlyWRzTgOBbF4ArA/jFZYwmp3+koovm/vEVFC/SV2jDqv1A4exJwE1Os2jnBnSdisiyYfPiUwYlxzXy5Z6PNBy1DnrM5s/GTnY3PsF+u+lQbZySL8zjhrfR+XEL3CdTLcGU0DMCorARITkcE/dT2Ft6m69krBD7us8LIxQzzv2apWbH14i2rF++B/9ee5loJlsAkrHRfFLd1+2QZHuULelagjk/1iPmyAAwmpejdEh43xddoRExfsXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8o3UsK5p4kAncOpSlmz8SJlAFleX8+H4gYKuouKcJ8=;
 b=paFlhUU8BcWkpdhT1pwP2Av7di5EGFkRMnWDpcewZqUkAo16BYm1wd7wA88qdfcnL3Abpp+pato/dD9SgO/D7Zcn0Xfzky2Rw4iqE2s0q0mevPdTmk214NkxmLIVNXXPNdEaHnh74D0Wjzdc8sliRvg5/tqvzqhQheOn5nIcWwRjrZtVqt4ZpY0TXn6NChlQW0EEFx6K+/zvpVCjkr/Odbz9x7zKnuAKj3tNr6Q929CFKX+/vTxiiZNOCnxH9vS9CnG8+yVfzPOecPTfHgfZto3PlHoLJOMWg9y3D5eXDMi1a/q3TkVuTCvz7GqxaLrmgOIO5tFVZE/15ZQZmCbbWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by CO6PR18MB4385.namprd18.prod.outlook.com (2603:10b6:5:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 09:14:02 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 09:14:02 +0000
Message-ID: <0c46e698-a668-4d49-b991-0a131d1ab956@axiado.com>
Date: Tue, 25 Aug 2026 17:13:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] hw/arm: Add Axiado Ax3005 EVB
To: Jack Wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20260825021155.2475879-6-kchiu@axiado.com>
 <0A3F8951-FEC0-448F-B2B0-44AF0AE9777F@gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <0A3F8951-FEC0-448F-B2B0-44AF0AE9777F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|CO6PR18MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: 422b9451-1e4a-4277-68e3-08df028933e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|6133799003|18002099003|22082099003|18056099003|4143699003;
X-Microsoft-Antispam-Message-Info: 8d/9Vnt4J1j1Si2xCaQQYvXp1rpw6946D1HVDwZZQ1h+gU2g7dTfrKvT9FcaUPddf0qaCXYw2/5CmeZI6yv2w6Duz1rxMJ7GsimbWl+JpLpQgEk3Kb0zR4NRq4RN503WXigI7lw7MPiQn8kkayqc0ORDrE4Noe0Q29qDprKOs6szBB93SpZOYgaryLy0fbBPC58c+ouVCpOfhJp9CU5Tn/gedJvE/4RKCGlnKoqjhRlA1g8Rf5scFFW6hXfHy1cda4WS4dCxlZQExiD2hSvQ9WU+HQogScBYhMs/u2BjLiN4bRkaQgHhrhqVBGfOMlyjsPVM72pkBC+Ga6qx0BrrUSQV3E98la4FP4ofcmMhhx+A5MIjMjeLOzngvCIjTzcK+JTaFe+OWNpq2x3Nnav2vjfhM3AwxRVvdK6V1pWsJGO4hBmvYLkgM0WjC4NURzBgY+JxOLMUNH/gN3KM8wysWL3Tg7J0GghRL9qP/JB9cdUlEw7SyiOocRzcAZZLkYyNK8ozqf3iVy7Iv6MhJjTf9sP5Ru2T3MDj9HLbjAlHZUgMVKGvwqM6AUsX+hQl1DvGLqKMYh4iuSu1HG5bZYIghejkgmIHzWVH9wX+QWFpg4pfC9FsjqbLgd6xSkSJPXvO5Ih21krtwzIW6U3ZIlLWHCBRm5jLvacNztuVbvjvKKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(18056099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVXR1VlOEhraHZucm5lSWxiK3FiQjJXQk4rT0huTkczWHJYWXhldDV6ZTI5?=
 =?utf-8?B?czZoMEVSYXhNbTdVU25ZUnZOT3o4NUtsN3IrM05oOWZlV0VqUHJwdWxrNkRp?=
 =?utf-8?B?dEp2TzRsMUt1c1VQSzRMU1oyc2tzSkRGUU4wR0dTbFBiZDRiQkdyODVsNXNy?=
 =?utf-8?B?ejNTQUxTK3RER1N0OG1ISEgwaVRYVkY0NnhYTWx4Sk4ra3o1QitsRDFsSWlw?=
 =?utf-8?B?SzErUzNDRWtGZTgwTWFPanVuTzVQbFhYRi9kUG1wVmVIT0duOHIzSXBpRkJE?=
 =?utf-8?B?a1BrRUkxM3lrb0lRRlJGMUkyQ0FZNlVTWnJLVkh0anNKaW45dlZmV2Rld3JB?=
 =?utf-8?B?NnJZck5oSElwREtDeFl0R1N2amcwbW5Jc3ExT1Jhc0R4VzZ6TVp2TmIrMHZu?=
 =?utf-8?B?bUwvTUxNOG0xVzcwRFpiUEpzWUlmNVlOaFVNS2hranF5bXcvelVGT0Q1NE1a?=
 =?utf-8?B?VEJCTjJobXl1Kzd0SUVJM1lZS084a2ttV2V0QStFakZxb2k4ZXRGbG9ZWVZT?=
 =?utf-8?B?MCtlZjM0aWE2K3Z4V1YwN2t4d3A3Kys3d0NDKzVUMHZKMHdhUjZZbjI2UVVP?=
 =?utf-8?B?WGFhMUtWQWZZZFJnREo2ZmUwT2FhNTlUczcvQmdJUlJlTE5LMFhzdk9jdWFr?=
 =?utf-8?B?czAxSkVJMmdGQnJOcW8yOEIxMlZHQW9WTXFURG1mRitMVXdycTRNNDVrcmtz?=
 =?utf-8?B?cDRvbEpNOHQzd29kY1pZLytSMU5mYllFSHJRZDAwbzFXVFBGNnkyQzA2ZC9w?=
 =?utf-8?B?VTlpeEtzeTVDaGcydi9wcGhFdTJPc1BBMktGaGVuU0wxcDFFNHRhSGpQZXlx?=
 =?utf-8?B?LzdhL0JBYzF3bk5qOWF6RUNEZC80QnQrM3VJR2tzWGlzT25maEg1V3JOUC90?=
 =?utf-8?B?V2wycEFOQVFMNkpyNHdPMGVySVoxaWVpNStqaVJDUzd4NEhQcEw5d3h5cG5I?=
 =?utf-8?B?dzdwbG85QjBHdUxXTUsweFlYVWo3WngyVStGR0F1bGNhZ2tlb3JBUk1icXp5?=
 =?utf-8?B?Z1BJVDRERGJUVUgrR0hoOXVyU2hBL3VTWFNVa1kvbDFUMis4ZVozdHdWSkpK?=
 =?utf-8?B?VWxoRjhVVExYZVlEclJNUFVuU3kxUXh6WW9JNW9aWndnL1lwWUowNFdvc1B0?=
 =?utf-8?B?ajRsOG1IVkszZnlib0wwT3hEZjdwT2FRenVHSCs4UURZUFNRUzNTVWpvNFV1?=
 =?utf-8?B?VHBaNWYyUUlGV2k0RS83Sk9VUjd4L3ZRVjNsZ3ZRQnFtN0N3akREM3VBNE5O?=
 =?utf-8?B?T0dNdjlXZlFFaW5wc00ya2JzZTRpZWxIcko3YXRmL0VUWjkzTmNxVFVPMzhI?=
 =?utf-8?B?QXNXTDdhMkRhcSs3U0JLejhsUnVNcDNJOFdpd0l2TFJIZ0JXdEVqQ2FwWXdC?=
 =?utf-8?B?RTZNdnliSmczdTAwQklvWlFTMmRJc085eUd2QVlmMVhjaEJ6aXphdG1MaDJo?=
 =?utf-8?B?ejBIZk5xcUQ0eXVxK0dsMjlSTEZDRlQ3ZFptOHQ4ZFplVVFkV3c5dTVIMzRH?=
 =?utf-8?B?VSs2bjdnWEVYTEp1cjZhQWRab25Yakl4YjNPaWJpL3NOdkR5cnlYRThPSS9D?=
 =?utf-8?B?SDcxYU9PTkFDRHczNU1GQmtaY3lUZGExTjUzM1lMSmhaTklOV1hmL2tRdFBP?=
 =?utf-8?B?Zm1wbUFhbUFXYWZINm12eHU3MnR3YzhidU1lelJnOTB0Nzc4REVoZjMyVm9n?=
 =?utf-8?B?RjBXSFE5emI0VER3RHp0c3E0R3hmOGx4SXFFbUhYYkZBZlViRnNWZzRtT21v?=
 =?utf-8?B?aCtrZXQ4T2k1TnpKb2VqOW9BaXFwQkpvUkNSZnFqOTNhWEVIcEZuWnQ0UVVU?=
 =?utf-8?B?ZEVsSEdqOGpNTmJGeDVsc1NwNW1vZGV5aGVTSVlsRUpYQzhxMWhZUXdaL1JW?=
 =?utf-8?B?VW9LdFllM3h4S0NDSWk4TVFlOHlTdUkxdGFhcjVLQ2FhakcwSEZRVHpWa2Uw?=
 =?utf-8?B?aTdKeWRXYWQ1QTJWRTIySWxvWnU4YThRSXk3VW5tUVM4SWtxRW1QRnBrUEVO?=
 =?utf-8?B?N3ZqQXFPU2RXakpmbUhDL2l2ZnVMK01zWmNaMDdCbWJ4RkF3U2FQN2xXQ0VO?=
 =?utf-8?B?SHZlbkgrdHNtVkVBekhJb1Y5eDM5ejJHcUY4Q2xvMnRrY0M5c2NkMlVhNU1E?=
 =?utf-8?B?MmkrWlJ1SEZhSTVTbXpDM05LS2t1cExhOXp6eDVtNnYzRFRsZXZFMDVHTUQz?=
 =?utf-8?B?eDU5MExseFRWbk0zOFJvWDhBR3M3WWV2ZHdIT3BEVzh4d0RWZzVEa0lwTjd0?=
 =?utf-8?B?Q29kdWw1cDVYQ0lSQVdOQTZIbSsvZHdzSVlxcU9KQWNvWGY1ekpSbCs4ZTE0?=
 =?utf-8?B?d293eFVncVVvZllKQm5GNFZHdGJCNW1udkJTbzhzeHBCY0h2WGp4dz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422b9451-1e4a-4277-68e3-08df028933e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 09:14:02.3057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGlmuqrFTvhoBnVQr7FX8SdRiDooybM7TUN8UqRS4XVHDrW0r3JPxoI4eYP6Tq3IAqyY/SMjEVyJNyziTAxO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4385
Received-SPF: pass client-ip=2a01:111:f403:c107::9;
 envelope-from=kchiu@axiado.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jack

Jack Wang 於 2026/8/25 下午 03:25 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Hi Kuan-Jui
>
> In patch 4, the AX3005 DRAM MemoryRegion is created with a fixed size of 2 GiB, as defined by AX3005_DRAM_SIZE. However, this patch passes machine->ram_size to the kernel loader:
>
>> +    ax3005_binfo.ram_size = machine->ram_size;
> This allows the value supplied through the -m option to differ from the size of the actual DRAM MemoryRegion.
>
> I am not sure whether the machine is intended to support configurable RAM or only a fixed 2 GiB configuration, but the current implementation makes the machine configuration and the physical memory map
> inconsistent.

The 2 GiB is on-chip RAM, so I would like to fix the value with 2 GiB.

For the inconsistent size issue in QMP, I would like to add a guard in 
board level to fix the memory size like

  if (machine->ram_size != AX3005_DRAM_SIZE) {
      g_autofree char *size_str = size_to_str(AX3005_DRAM_SIZE);
      error_report("Invalid RAM size, should be %s", size_str);
      exit(1);

  }

and assign default_ram_size of MachineClass like

mc->default_ram_size = AX3005_DRAM_SIZE;


Is it acceptable?

>
> I checked the configured memory size with:
>
> for ram in 1G 3G; do echo "QMP case: -m $ram"; printf '%s\n' '{"execute":"qmp_capabilities"}' '{"execute":"query-memory-size-summary"}' '{"execute":"quit"}' | "$QEMU_BIN" -M ax3005-evb -m "$ram" -display none -serial none -qmp stdio -S | rg 'base-memory'; done
>
> I then checked the actual memory map with:
>
> for ram in 1G 3G; do echo "MemoryRegion case: -m $ram"; printf 'info mtree -f\nquit\n' | "$QEMU_BIN" -M ax3005-evb -m "$ram" -display none -serial none -monitor stdio -S | rg '\(prio 0, ram\): dram'; done
>
> Therefore, the actual DRAM remains fixed at 2 GiB, while machine->ram_size and the value passed to arm_load_kernel() can report 1 GiB or 3 GiB.(QEMU_BIN points to the newly built qemu-system-aarch64 binary.)
>
> Best regards : )
> JW..

