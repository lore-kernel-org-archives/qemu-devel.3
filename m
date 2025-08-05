Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F99C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 13:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujHjJ-0004II-KF; Tue, 05 Aug 2025 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1ujHhi-0001lZ-CY
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:27:46 -0400
Received: from
 mail-switzerlandnorthazon11022085.outbound.protection.outlook.com
 ([40.107.168.85] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1ujHhf-0006aK-8S
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 09:27:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXKpWCKjju1CAWhr7/LntIDs2LW0tMrV89faVVUpDWbr3jATWPWsIKtKccoo6D9bE75s85JMYKdE96in+iSOyCeJUqW9REyw1NPvNhSqG0n2v4I9maKATKhFITHRe+2gjWPv1zlstm1HwmY1PE9dyCYV2r9T+9mSOHsC26xLZmcGytjdtnv9fSR23XBXyMoFD4fa16N6eZxJI8rVRr5e+RpJ+QPLEMcAttuYkoqYC+e1sJrHr5YSyEB8ZHM4EfqrV/TNcmFFDHoRH8fPRxBNinlmHQiT1YzSylr80/0/bnRXi9H2xClTV4GMYKa7KEMmmZ6YQM82U9sgNA5pwDlEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIpJ+BscY56+rmDVBnhiigtX8ljHkvUNr03o5rw+N7g=;
 b=XwY7aNGUEn3aRmnEkev/VKZNMYH+IiPEqr8qfmGag7JVPITeM0a5DXalOoxe84RpwR9Sp1jXwrstiXKYcb2NIP1cczAVU39zu7RruKWtsSAYFejjVRcX+wSI3ghBczGb0Z7V9gmPUgFbYEjcneSgNYNyjlmbiou2du/mzC9eeP/rmaJiffVYIfaA2E2aV0YoWAHem2VCDsYfwAVZeBt9Sw63g9JJOeovlLooENUC5gUlAxwFqg7T1ZbF3itG0at9jfJaJgeGqHwKj/iGiD3wr7B6ElQPur4In79D7piemUqW4iPzEmGwu9S8b6rJ4reER90I/eXfrzF6lxfrOuKGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIpJ+BscY56+rmDVBnhiigtX8ljHkvUNr03o5rw+N7g=;
 b=QMocHYJdAyFl0ocCiTAGDkZD2nUeW9R4yE/oFFmJyjsAq1hOkaycjWsaF4+yqmFLQvKfGpA3BP4tKrkZEo9j8dvwrQ0feidDjh47x9FH4Rk/CZMYwOE/yvd3A4OsPH9c4JAWq5mzGKz5oMwBJTeOv63waoqV/eDG6z0kVb5ekFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV1PPFE907C6019.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::230) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 13:22:36 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f%5]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 13:22:36 +0000
Message-ID: <1016eeb7-57d8-4d80-ba25-42cda2d63b0f@epfl.ch>
Date: Tue, 5 Aug 2025 15:22:35 +0200
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@linaro.org
References: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
 <87tt2n5az1.fsf@draig.linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Subject: Re: New capabilities for plugins
In-Reply-To: <87tt2n5az1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::13) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV1PPFE907C6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a75dc2e-3fa4-426c-3c08-08ddd42324ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|19092799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUJmMUVyaTMxNENjVG56bFp0RFFVRXVqelgybEFaU3BjWXBlYzNqTmprYzR3?=
 =?utf-8?B?TjRjSUQ1bUE4K1JES05Jd0VzYVBwYjhBRmltc05JT0FaOFliS09aNlk0NEQr?=
 =?utf-8?B?eUZMRGtEM3FDYVFxdjQxNUVJajgrbEVSWWdnVXRJemJ4akREelVJUDZ5SjRF?=
 =?utf-8?B?RjNSbzhUYVlyUTRBUk5OUm5YeG9pQTNRcFN2S3NtUVJad0ZsWjUzZUMrSFNZ?=
 =?utf-8?B?THdNN1QxTDVNbGIwb0xweUpENHNoWHdwcmRza1hyV1V4OTY0TmdlN3dUQXVT?=
 =?utf-8?B?NmhUYWJoMjlXcFREbjMwOUZZbUplZHR2czd1b0RnYVc1aVNEYWlCa0MrME5X?=
 =?utf-8?B?ZzdqQzROQm5sREZCN1BOUXZvSU84eXZPMERMYmJQakJ0UWRyZWQvdmxZWkZ1?=
 =?utf-8?B?bllIdVBuWGJlR0hXSlk3NmYxemtvYWdWUE1rRUx4RGZBUTh6V1BNNWJvcUpr?=
 =?utf-8?B?SS91VndOS1p1dnVsUGpJaXJ2eGlTUWJaclRqUHFiL05vN2tlaUdtNFdlNHNx?=
 =?utf-8?B?WEJWeU9NTTBsWThtSFVTRUY2TGllYnIzWmhTQTlBOTRxamZNTU5LRDVHUFc3?=
 =?utf-8?B?N1NpMlQrcHc1M081WjYxak5VV0JqT3RGV1llQW8vN3hoaHNPMFVPTGdqMzAw?=
 =?utf-8?B?ZytiaG9NcDdONEluT2x6TDc0M01RenFmUDNDamh1VUpGbXpkR3FYbTB6T1pQ?=
 =?utf-8?B?RUdaZTVITjh6ZVlvYnlWTVl5YWlRUjNBa3o1eDZpd1BKK1NRZTMrUnFNQlYv?=
 =?utf-8?B?eEhVeWZZZXdmdkQreERLbUFsVHA3aGxuMmI3ZTRqdURYbjhwZmpRV3dwOUZx?=
 =?utf-8?B?RFUvRCtSd2VhQWtDMEVoZkdaSnp3QjkwcWRvWHowVHZDN08rK0QrZlA3Ny9m?=
 =?utf-8?B?cWF0OUNXOTFtQmx5WEsxbitDN085R1NWcEpDcmphNGhSeVlESVY1Mm83U2Vq?=
 =?utf-8?B?TEZzYS94cjVWU1ltNVFnOVNzL2cxa0pnQi8vS09TUVpSZ1M4eTZOSXFMN20z?=
 =?utf-8?B?ZlpYVlJNVU9GOWZrZExSTm83MS9ZM0JpS0dHK1ZrbW9WUmZoaGsxV0gzVEhn?=
 =?utf-8?B?UWNlVE9kQm9BTlBWNUpUSnJSckRIUW5obHlDYWN5UkhBMTNLUzJldXAvakNM?=
 =?utf-8?B?bWtnam5JRUZjK0NCdk1uUHZRWFFMa3VNdlNEdHRTaFdoc1hkNTgzVHc2M0Rl?=
 =?utf-8?B?enZ1WklIajFsOExVcUl1ZFVDUG9SMFFmdHVXTmxFb2s1YlB1MUNhRU1HUjlR?=
 =?utf-8?B?SHZRZDU4VDRuRU5HR2hqN1M1YmFkUXg4a1dGb3Y2Sy9tVVY3dVJVNG54c21k?=
 =?utf-8?B?U0JRSmN6b05pN3N5cS9QbkMxeVJBSzFXL1ZhMGhrRTlkUithVlpqeEtUNTVv?=
 =?utf-8?B?VHZLalBIODJqVUxHQ0xDaDVHcGt0NFM2RWRCakUzVWpmOFFyRUNhanlOanRm?=
 =?utf-8?B?WkpuWitpRDByb3hxcUI3MktlVmdQNllOSUlQUUxVRTlJUUpoaU5GNlhOV3dy?=
 =?utf-8?B?ZEl1dGIvbnhrY3RXUGppTkJOL2dyWkkvY0RKa00wVnRSWGZyYnJYREhyamU0?=
 =?utf-8?B?N3R6YlgxekU2SHpNMElKLys0K2h4RDNLM3prMGJabFA4VENZMFRBRFd4S2tP?=
 =?utf-8?B?QVN1UldSSjVVR3NIYUdzZ2kxMFRiYUl4WjU5OEg5SGdVNWRkekpybWFLUmdO?=
 =?utf-8?B?QjJEeks0aGRVeDVuSnJhZkpzTGJYN3VmSXNUY2R1Rjl1NURqR0wrc3hsaWxJ?=
 =?utf-8?B?a1hMWUZsWWo4Sytqd0xXSEpFZGNYZUlKcVJyNTIwbkZieE9aaTMrYU1VdURx?=
 =?utf-8?B?OFNWVjV2NDhZeThMa3MrZ3F3MjZ4MGNZbTdEU1cwVTBTWlQwMEZTMnY0Mlls?=
 =?utf-8?B?SVgwQjJVMVhpNkx0LzFVVThLOTFJRml5ZDJPMVk0VFc4Q21oa09FOWRHSVZU?=
 =?utf-8?Q?eheguDnkx3c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29lQitVVTVnSHF0NHNPSHVrZzJrMTQ2d0syYXY1SktFYW1JT0R3alFhNjNx?=
 =?utf-8?B?WlVodUp4Z3hDWDRDMExmTzFBNndLMWZhL1JMM3VGYm9zV3ZEQmkwaWpic1Fa?=
 =?utf-8?B?SHJwcFFDUURIWjNDcTZrN3lOOGlxeVpacVNOZUUyUmQ1akxhTVJOc2Q1Slk1?=
 =?utf-8?B?RW10WFoyNVNDem1TdEd2WXdETU1IYWlQQ0kyOHNCbnFHelJ6V1NwdytWYWF1?=
 =?utf-8?B?Y0xhVnV5ZDRDV1RCWFAwMFpCUkx0WTBZZnd4RmxxazVKOTZ6VDdIaVBqc1NC?=
 =?utf-8?B?bDhFeGhLeTJPZlp0SFM2cFJydkY0ZjlDM3V6RDdGd21GR2xHUmtVSDZTbWlw?=
 =?utf-8?B?clM5R0dIelRpa3VUME8rNmRxWUMxQmprTFVHRjRlaS9MTHhoZHpQNUhvQzVi?=
 =?utf-8?B?RE5zTDBFZllrM0J6V0xlY3RKeXlDWVEyNGNxUkUzdUg3dlJtdnoxRnBoQ0hH?=
 =?utf-8?B?UFk4Q0tvTTJHbmtxL1VDUGt6U05aNEI1Qm5QZWZCSDhaeXUvMFMwR1ErQnpE?=
 =?utf-8?B?TWR4OGVHc2R0OXVOMXhqUmNpMmJTZlZnbUt0SUYyeHR0UkVnYTY4d3NiaDRk?=
 =?utf-8?B?UTBsOW50M0FPNGw1TUMwbVkralVQNFVNN0dZemxzQVQ1Vkl5Y0k4K2p6OTJw?=
 =?utf-8?B?WSs5c21MRnZaZ2dNU1g5UnEwZEgwUmQ4WTRKYm0rYmFDdFVIVFFuVXllaGFD?=
 =?utf-8?B?R1M4VG1MUU1nYlpEK1FEWktOVU9aR1N0cmRKNVhpQlFzeXJ5WkQwTWFsQmts?=
 =?utf-8?B?N1IrNlkrdlBsR1RsK2Q4bUtRbHAwQjBSbFVxNnRCSys5TEM4NDNQQXZrdTRI?=
 =?utf-8?B?emlLRTYzWHlpQXZaaXlQZFhPUlJrUFZmclZZczh6QUxkbmNqcW9XQlhxSU1N?=
 =?utf-8?B?SHZZdytoOGVXU3JzTmlhRE0rY3daakhMTXVMT3JLcFNtdElSR29PVFhaN1Qy?=
 =?utf-8?B?bVRHMHN2VFVIZTZXaHlZVmd4emlvekZJVTF0Z3FGUDdQN1k3M3I1eEN1a0dE?=
 =?utf-8?B?NC9jZzkxcFgwMktLVUdLRFFVVWJKRzVvc3RUOG1mckpkT3N1aVZNWWo4cVRs?=
 =?utf-8?B?Tm45ZWc2U2M4MTJ5MHhLSDhGaHZFU2Y1cndSY0xKNTlIbU44ZEhuK25iL0hU?=
 =?utf-8?B?RmxpdXJJaThKdG16MkxxZXNKaVJUbDRJaEY5bVRMWFBENEYrNHl4YWhkYk4x?=
 =?utf-8?B?NG5HQU55L3UrMGdlbnR5dENsSGRqZ2FvOTl2UlhQZ1hMN0lpVWxHZVI5eDF5?=
 =?utf-8?B?SUlHTTNWT1IzOEYxT2pqdnhzR095eTFoOUlpZ0xzKyt5dHdETnpSa01Fdmtx?=
 =?utf-8?B?M1VPYmJSWXZNNk9JS2tkay82MjJJdVBwN25WS1JjL1BNcHZZOTF1akNsMGc1?=
 =?utf-8?B?SFVlMWRkVVVRcFNOMWtZN1VqL2dGOHNLMXFpSVhLZ1VzenBSbVJDai9FbmdP?=
 =?utf-8?B?Qkp1eWxuRUNGZkNodGs1c2RIcklOa2pacDQ3aVZqWFNOSG1oTllkcVBtSjJG?=
 =?utf-8?B?WlpEMU1BU0ZHVjh2TmQzdEozaWhBeloycVFjNWlFZHhZQk5BdWkxOVRxMUxG?=
 =?utf-8?B?UHhyQ1pnNGozTlZXUFhoRlZNVmNWQkVMaXovaXIyT0xtSXNUWTV2MkdFUE9R?=
 =?utf-8?B?Rkd5U2hwM0FRM2M0dUFDL1lybXI4V09NSEZMb3I5ZWhhMlErUytncjVzOFFw?=
 =?utf-8?B?cTBGQWZvcnpyaDNOYXkzMWRBTW91LzVualpSQ0dWM2JMU1J3b0NTOEk4cUJw?=
 =?utf-8?B?c0xlZGlINHBlOWxsME9TNXJic0NtOUNKcStURy9wY2tESFJmZzRVM1YzZmRP?=
 =?utf-8?B?RlZCWXJWZTJrclI3V2gvdm8xZ2JDSDZzRUdwa1ltY1prS21oSHhtb0NPTzA5?=
 =?utf-8?B?ZVp1VXYrTzNTZy9oaGVCTkJJV1lpOFJPaWVOeDd0V3ptSklMVk1PQUl2N2xX?=
 =?utf-8?B?b3F3VEhZQk16OTlVQ3VJWWVxZGtVckVmN3hqMHc3RDZacW84aU94cTQ3SXZa?=
 =?utf-8?B?d2VrWnhlSVpEMGg5d1AxbDNucUpvTnFTZ0QvclB5Qmx6L1ZmSGhtWDY5cytH?=
 =?utf-8?B?TVFkcjFwdFBIWDZtY2Y2WGkycmE5aXdac3lkVU5pcXlDUXNQWVBUbXpmTmJ2?=
 =?utf-8?B?R3l1S1pDaWFNdXg1OEdtSHNTSDRSbFhrY0JHS1J0elYrMkNORUpqWmt4TUh1?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a75dc2e-3fa4-426c-3c08-08ddd42324ea
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 13:22:36.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqRfbWCYNwYHrt3jT/PvkLEU+iEoyhgMRDl3uawCRPpnipNsCFgqwZC9QwTO3FqJC4CLQ8rwqxy+3Pw4YHwrKh4+U83HuV11fopyHvW+qoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPFE907C6019
Received-SPF: pass client-ip=40.107.168.85;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Alex, hi Pierrick,

I'm taking the freedom to reply to both of you at the same time, I hope 
you don't mind :)

On 04/08/2025 18:05, Alex Bennée wrote:
 >> I was wondering whether the QEMU community would be open to extending
 >> the plugin API so that a plugin can fully emulate a syscall without
 >> the original syscall being executed by QEMU.
 >
 > I will defer to the *-user maintainers here. One thing we are keen to
 > avoid is plugins being used as a mechanism to work around the GPL
 > requirements of QEMU itself. It would be useful if you could outline
 > the use case for a plugin doing the emulation itself?

On 04/08/2025 19:01, Pierrick Bouvier wrote:
 > Before talking about the how and what, it could be useful to explain
 > why it's needed to replace syscalls.

I'm using QEMU as a tool for security research in the context of my 
studies. I'm analyzing black-box binaries, i.e., I don't have source 
code access and ideally don't want to spend much time statically reverse 
engineering the binaries (there might be complex logic, code 
obfuscation, etc. at play). Emulating syscalls myself instead of passing 
them through to the host OS has two advantages:

1. I can sandbox the (untrusted) binaries.
2. I can make the binaries execute more of their code by simulating an 
environment different to the one they're actually running in (e.g., by 
returning values from syscalls that are required to pass certain 
conditional checks in the code).

Both could in theory also be achieved by using utilities like seccomp 
filters or eBPF programs. However, I'd like to have arbitrarily complex 
logic to determine the outcome of a syscall, which quickly reaches its 
limits with the aforementioned approaches, in addition to the overhead 
of switching into and out of the kernel (negligible for a single 
execution but quickly adds up if we're talking about automated 
analyses). Further, I'd like my code to be able to profit from future 
improvements to QEMU and therefore implement it as a plugin (which is 
likely more portable than constantly forward-porting patches from a 
custom QEMU fork, as the majority of security research is doing it 
currently).
As a contrived example, I might want to inspect the arguments to a read 
syscall and return data accordingly. Say, I know from a previous open 
syscall that a file descriptor refers to /dev/random, I might want to 
return exactly the (arguably non-random) bytes required to pass a 
certain condition when a read syscall on that file descriptor is issued.

 > Another option would be to have a set_pc function that would restart
 > the execution at new PC. Then the vcpu_syscall_cb callback could set
 > the PC to post the syscall with whatever state it wants to set up.

Such a set_pc functionality is already covered with the register write 
API, as long as I have a handle to the PC register, right? Please do 
correct me if I'm misunderstanding something here!

Thanks for your input,
Florian

