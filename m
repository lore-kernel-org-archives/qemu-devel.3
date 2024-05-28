Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F76CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByT7-0007XM-7v; Tue, 28 May 2024 11:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sByT1-0007WM-S8
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBySx-0000H4-Kb
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SBoxo9001944; Tue, 28 May 2024 15:10:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DrvMtKCCqkFEu59Ej3BamvmYaHf5Ff/oilImPASIB4I4=3D;_b?=
 =?UTF-8?Q?=3DXnz8jM33tpqfDYSLwGyx6+LCSk5bkfqWC+d37rergX3zCS5Rsd4bx0jpKEsk?=
 =?UTF-8?Q?e8FLpZ92_ng8if0mWR7Mse8cm/q+u054EoY2LFiEei3zW79vxAarwnZy1R8hLG9?=
 =?UTF-8?Q?gNSEuX7tOuBajK_BVrKXW1GnuTc7iiSnIYAIm5zO7GhhPgcnqaJHAcVN/5AFeZO?=
 =?UTF-8?Q?Zo7DbpJO4oIi/aEUI2eu_tnpsMnsWE+TJGhlsI/tU2ZEGOE7MTZvhfkA5xS3FJr?=
 =?UTF-8?Q?OysYsgyiEXISja7z2xS4GZ/mQk_/Ubbzu1rwGPChV9CEZjsrDfgW1MPIPfx5zOA?=
 =?UTF-8?Q?sQ9ahhhsrAF6GCOfgxlQYLQoe3yf4SJ1_gw=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g44ng4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:11 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44SEG01W025725; Tue, 28 May 2024 15:10:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50q07g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIMVggPsxNItbgkgqNStqMgSwVoQJPxSOTSLHyTec1XOh0I67dXcZBKOHZlHt0E9W78Jp7XxeaJ2mIc11/KGSge8tkG8F+ipwmfSAFnk6NcSlRRkQ8cWYmajhvxdareiGBaUxmlKbUjoebKDTlsUCtRGnshbLC+itXZvRfPdFJgPiL5MLMAofvpCVbnmVuGRRdBBfVXb1TqWKGuBbyFKBEeWpzTQSXUWZ6hGZtrh2B9hSAy83yyaOfDSPlP9z8Btd2mXiFlvvJbkI2Jq/htdpeDuWpGy7DeM/5bVcJt7dft4+/s2GeZce1L7KXNeHwo6kcLzwd22m6vcrdfJCoMpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvMtKCCqkFEu59Ej3BamvmYaHf5Ff/oilImPASIB4I4=;
 b=kPsl6X6LkHlRRZ0FG+eXGh8xr1y2LfTqX7JCDIIDJ13pMyPg5mgA9z6gA/PEYE8NU4qP1VgHz4YUPoxjL98ScgwnnEB74geBr9wHlk5S1JIGEIbRl2wUZf456Sy4Au023Nd3F7K/8Y9ZUrDpL4opKANedADTHnOLcmOZA/ni5tJ7p5vMgIH/6KnGKXOpsZXGAU0L/WSXxvIybSy9dQenPSm0KcbnNh+FDuLp/c57aSyHjr+onG5/RYHiE64OAVAWIR/esoUQGcl8r3UYnqLJa+ueHZIYL1cH+VF28P8Jys4aNFk6/UoiZd7ysZSRW8KHCzqN0Kj87ZHhaF5ZPTUAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvMtKCCqkFEu59Ej3BamvmYaHf5Ff/oilImPASIB4I4=;
 b=pRcnoP3eIAkIWiNhKkGAt5vuuL8ogMDIcNURgz+a2+jWFW1UFva1v1jA+LXsqJwz/1yiHrqU7DVg8cWvfGLTYGOdme3Jdb0uII4rgE/NyymFhOCawO4WkSeAdJx3/+l1Q3BXyb11qV/Hj32z3DTcycliCjq/O3dYyNsswV0J/7Y=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:10:08 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:10:08 +0000
Message-ID: <7119f070-57ea-4495-bd8a-1337555fac22@oracle.com>
Date: Tue, 28 May 2024 11:10:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 07/26] migration: VMStateId
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-8-git-send-email-steven.sistare@oracle.com>
 <ZlTO9fVYG50r3XL9@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlTO9fVYG50r3XL9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: a728844b-f0a8-432e-f8e1-08dc7f28434d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3gzK1NzOVQ3YWJmZ2d2WWNTbUl6TlhnUWxFaW9zSkVHZ09uZEExK05UTCtB?=
 =?utf-8?B?ZzVuTWo3VkNaMVdRNTI4M1FBMTBrQ1FsSlZicnU5RHh5eCtQV2ZnbEN4a0oz?=
 =?utf-8?B?a0ZOSE4vMVNxMjRBN2VaamR0aWREaWx6a2g0OGw0M0JnZXJJTkJVd1RwVFNF?=
 =?utf-8?B?YXdiWUpOYzBUTlR6K01NeWdMdGVRem1yb2ZHczV6TWFZc0tLVXFHVXJ2Y2Ni?=
 =?utf-8?B?cjBXZGxCMTlHUG1aaE5GVS9sUHREc3M4Nm9QVnBtb2syeHdmUUtkSzUzMGNT?=
 =?utf-8?B?U1IzemdEVzJmSzlNTlJwekpITVhCZTBsQ0RPOGdHeDdPSjNTMmF5c2hzRzdK?=
 =?utf-8?B?NlorV0k0eDB2Ukt4cVRGUTJ5WGxLdmxEdFZ1aVlsdnBGODE3S2VyMGM2VVZh?=
 =?utf-8?B?UCtLVXBYWnhZYkJMZUNscmdRUDdlblBIQjlIeGwySUMyNElmdGFhbzcwMEVw?=
 =?utf-8?B?Yk45T3kyQWNXY1ZGYmhwaDlWRnBUaEZyejFFckc1bEEzVkV0c0VQenRlWEFG?=
 =?utf-8?B?WlJYTmEvMG9EVld5R1ZsRnBMQzQrWVphTW5kbnJSZk1YSE51NkphaU9td0Ev?=
 =?utf-8?B?OXVOMlEvcEFyOUp2ZjQwRHlkTFN4dkFWZDhxZHdsb1hpUHMvMC8ybEplMWlH?=
 =?utf-8?B?NEdCaHVCS2tKYlJSVitBeS9JdndubGxmN2kxN3V5R0pVUHpkeUlpazQ3YnVr?=
 =?utf-8?B?cmlZc2VpZnFuRk9ZYUJPUC84U2tCbGJTc2E3V0dUa2JUclJHUUQySTJHNUZr?=
 =?utf-8?B?MngrZFNuY1hjKzkxR1l3RUsyblRCbFg4ZTJiY1Y5anVXVXZZdXhmTitMUjZo?=
 =?utf-8?B?Qko4YXpuSURzSEFIby8yYnY0cUVvVVpMN0VRckd5eDJKaHJyeWdyY0VuRm8x?=
 =?utf-8?B?bStZalZRS3RWblh3a1NJZEJEbXkzTXh4azFrYUw5aWZJQnIvYms3Wk02THA0?=
 =?utf-8?B?QTVMaDZIM3RNRXQyL1hrbVZxNk9UalNzNW1xTDluaVk2cU1DT1hRUHZiM1Q1?=
 =?utf-8?B?YjZLdnlzaThEWVN6ZVNyUHhWNCszZXNsdUpFWFAvMFFKeGRXNUxLVkpndnFK?=
 =?utf-8?B?UHNhTk5UZ3pXOXJTTDNDRys1UzJlNFBTYzRsQm5uNzdPL2xLWC9JZE1DNHBG?=
 =?utf-8?B?OE1UNWlCM2Y0bkxvQlNVR1p4SjV4UXUwYnF4ODAyN3BSalducjJENlhycXht?=
 =?utf-8?B?ai8zWWlKQnlnQk5IcE1yMlF4amxlOVJ4ZXdWWVduNUFMNzFOYkV2U3MwZDJL?=
 =?utf-8?B?Q3NCbDhleWdDOTV0dHhKUW5xemZCYWJGM1ZoM2lZYUl3Y2VuN1NiS1Q2cEg1?=
 =?utf-8?B?TTR2YURPV3ZKNEdDTmVCSVVNWW5sWFUydHVqRDluOEFxQTZnRERwQ2ZnNktq?=
 =?utf-8?B?UG90VXhNWklqdC95S291alhCWS9uRlNFSFJrVWcyeFRQNVRwbG9VVE91aitL?=
 =?utf-8?B?MjRjSVpCVGhKbTd6U01ZWVhoenNWeURtZDJRT0xBTDVVMUZKNDI4NE1Vd1d3?=
 =?utf-8?B?aWREZHYwQml6UWg2RW1NWkZqSmpmblZ4OVFlaHpoYjRDdVhEcW5rSFhXdEFt?=
 =?utf-8?B?S0JjMEZyLzJ6TFpRT0pkQ1g1UWxma2NYV1hjRHZIV01sTURCWklSbnNyZlVr?=
 =?utf-8?B?Q1puYUw4aTF6YmFVV1BBV0xIYnhZTUhOM3U1U3JKMUdsOFZyaHNIOWtNQ3FU?=
 =?utf-8?B?dW0yOEFnQlVmUUFPRnYyMm1rUUdJZVN4U1pzTlBtRXVISlpRTGwrYlZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU4yQ2FwekgxNUxNYit4UktJMzdxU3QrOTZmdmNxaVduc29uczVqcFRnbVpw?=
 =?utf-8?B?d1pCYUI4ZVh1SFZyT2gwSThTM1dldElvNldiNnlIUEdsbUJxYXdHMnNNTFlQ?=
 =?utf-8?B?TUNDOTVOUHBRZXpKQUQwZ2hFTUtSeWVhU0lleWs3amlIaS9mak5WZUE2ay9R?=
 =?utf-8?B?ck1HeUdNUnE4WWJabUt0OUdhRjJGRjA5Tlh1a0R2eXhpT1JYZm5jMXhOWUpC?=
 =?utf-8?B?cm91THNXMFdLV1VVbEN3M3FuUUduNkZOUzNSWnVzUHZ3VVM4ZmI4ZWhTRHVU?=
 =?utf-8?B?cWl4eUp3aVptNUNuV1NxZHROY00xK1JJbHgrb0RFSEFraEVUTXhrL05nV1g1?=
 =?utf-8?B?M2V1Y1J2aWpTcUk4SmxtYXJLc1B6NEN5NUtGQmttejRLeTVDMVJoNTBjRkpv?=
 =?utf-8?B?NHV2MXEzV3NTQysrVUs4SmNRL1RpODlKMHdVem1Cc05YdytuUlFDM0FSTHN5?=
 =?utf-8?B?NUt5SUhkakxISWpNa0t5bUE5U1FKOXNKR0EwWmpzUS9sa0FUZnpCWFdjUlM2?=
 =?utf-8?B?eGgwUkNJNklRZmQ5dzZ4VGxhZFUrajc1VmU4UERyKzVrTHlvNXJvdjJ6Z2Vy?=
 =?utf-8?B?NTVROVAzME5nZ1pRSWhiUUxKTUNleFVaSEpJbjVaM2VtR0tSbGhDMXhQeGEz?=
 =?utf-8?B?MmlMMkczd3gybjY4K1ViRTFrcjN6UWJwNkRzS0lmRTJ2RWVCMm13SUNzNVhy?=
 =?utf-8?B?ckx4bFVhd2kyQ1FEWHVURlFBUVphL2k3SzM0L0VMQjRPM280YkFOYXNQTmdp?=
 =?utf-8?B?L3ZWNnBHczhyYVdIWFU1b3JDV3BSTWxZNFBUUC9FdFF3c3c5QTJ1M0c4VEhj?=
 =?utf-8?B?TEVCWWlKaUtKN204T2w3anFpNk0zQWUyeWh2eVdPdndZSmZ5RVErSzB4Z2xH?=
 =?utf-8?B?Z1FUVmh4blNvQWNraVRXOVYvU3A3UUtUZ1pyTDhFKzJOb2RzNjNHOTVCNXIr?=
 =?utf-8?B?bUkvZEpha1ZlMFBSN0Evbk1pNkFNMXZ4RTVCaFJIbUYyQ1NmaVJ2MzJoK2ls?=
 =?utf-8?B?YTBqSXo0OUhMWGlHN29BaGo2TlgzMnZlTWFmQUlHeEZaWHp6OU1VRDRwZE5y?=
 =?utf-8?B?a2ZYOGtDVndnVmpCYWhKWGI3TlJHb0dnRUN5dEFZSzJkYWl2YjNsRTJ2R0N2?=
 =?utf-8?B?ZW5yUU1xQjNGQXlXM0M2b1VXUkVlSEhFUVM4Vk1tTm9WcHYvbUpPK21KV2Vm?=
 =?utf-8?B?K0Fkd0IxTmJlZ2Yvd1pIY09uaVBuTWxrS1JzSVp4dDhSamlCVlFEWFcrTXVU?=
 =?utf-8?B?c0FRZ0pjMkVCVmdHUnBieU44dVo4bXFNWjVPRzRpTy9NeXBxLzFFTG9kVXpv?=
 =?utf-8?B?bGQ1VGpNcEErTm51QlZ6QUNmOVcydUd3VE1vYWVMLzFaOGtJZlYyY2x2LzNU?=
 =?utf-8?B?NGN1dkpWc2t6Nm5iMUdRWGRnWWIrdHNWR281NFpPNXJJMWdCdnhMbCtmTXNK?=
 =?utf-8?B?QUFQMUJMd1ZXQXRhSTlFU0NjdFBFWDhRQ0dURDdKNGRGdFNPVDRnYkxmNlRV?=
 =?utf-8?B?MTBhTVA4ZHpiNTNRdHVQUUZnbElEMjdMOWFXNjFGUjhSdXN2U3MveWdiOFR0?=
 =?utf-8?B?UnExcGQ3SmtxeW9zOFZUaFE2cy83cWtMSDJ4dzdWMkhPTjhUQXI3Yy9aZXJP?=
 =?utf-8?B?VzM1VjcyOWdqakZUMWkxempUNENUZ2lpUGFKR2hVN1hYdGxZY0dwcERjY0Qw?=
 =?utf-8?B?NXRxd0xuZ3lldG52ZUlhQVdtd2dMeFM4eWdVWmlKS29OZnBPWk9xcUtScGRD?=
 =?utf-8?B?U0w3cFpGeVJ6Yk5OcHJTYUdFRmRFWnlPRnFDSlR0MUZtdytpaHZneDhvVmpz?=
 =?utf-8?B?MHlvOGxSb1JoTFcxZ1c1VXpBdVNVUGF2c1hGdlRQUjQxUUlkVlE4SjN6U0d5?=
 =?utf-8?B?UXBSbzZINUtJZklleVM1amFleHMrSkU1cEpBY3YyWWZXcmlnVHZqZHVwSmQ0?=
 =?utf-8?B?NVpnNGJGb0tzQ2hDK2ZEK29rZDVOZDArTGdaVi9GZjk3aEk4Mkx0OVd2UUNo?=
 =?utf-8?B?R0k5dDZVcjZ2Nk1nM2pjTlo1VDNqNDRhWDRmUng2R2luVUF4M2YycXhvTGU0?=
 =?utf-8?B?YkNkcFJQcGdUMUpvNFpQOGJhbzd2OExXRWF4V0JtQmY2K0QwM2x3Rk43VmR5?=
 =?utf-8?B?Uks1K0pKaGZBRjZNdVVmWmN0ekZjV0drZXl2YUovMWI4VE5YNEd0aGxGM2ow?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ldONn1pCuPTd721xc8Se1qK6mqeu97HQoBavbNtednVLL3odRuUHMV7gBkba2Kh7tqUj277cZnud9k0VDeclWt9DlC2+PPYr4WMU1dln0YUEL/hL3v/a77tQmpqSpe3fl6YJa3YxMP4hnvRJOqNobB4NKtXPMxtOvrT7ZjCDd5qsYK+dOUEiXfc4tb/5NTUq1m/8DMJ+hugQlGCc3dp0JpFWB30YYNIrznb3cqvXIgGckboxekHFLMKVjhTxNb9sDdfra5qLIrGbfoQ/+AcaPjYx9DWrG8sM3Rnl7BMzCBsIgeh1UW1a5CHQpoGV2ST010n2q4muxjExC2el3UjVWhV7aBtjFgjYtuQHYfnqeYICLwwN66RaGwqpM7ipYrO8Zg11OgmLQWPT+LGUqSnEkZOHMKrM/DpbWmytf0Yitf0D66+zujQ75wItGUYw9MxqAtbQJEpRbGpnPuseDjRmoYon0iFK3L/HKmxJNPLW65H5TnSsrwGNLzn3k+uEKYnXs/isjQ034hv4x7LC72vxGT3RNuqG9Q3+5/PjRrzHONYWeBpJYbg5STP86r1PxPV5ZbOsfeNWrpl02oz8/I7Mq/z92yq6wU8ekP47kMRrkv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a728844b-f0a8-432e-f8e1-08dc7f28434d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:10:08.5488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9zYXfV2ePwsULpBeHaTfmR0zYpYo9TgXwUj2ZRKjZ1ZJd+qsMx+Y0fcb8owuMtd5Fk0tlsoG1OFS4xbi+h+7Iu2wcIzTHVq6av+VJ30PJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280113
X-Proofpoint-GUID: BtR3ChtYfU2ZLRxFrH2dHLhCdifs5Pz2
X-Proofpoint-ORIG-GUID: BtR3ChtYfU2ZLRxFrH2dHLhCdifs5Pz2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/27/2024 2:20 PM, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 08:55:16AM -0700, Steve Sistare wrote:
>> Define a type for the 256 byte id string to guarantee the same length is
>> used and enforced everywhere.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/exec/ramblock.h     | 3 ++-
>>   include/migration/vmstate.h | 2 ++
>>   migration/savevm.c          | 8 ++++----
>>   migration/vmstate.c         | 3 ++-
>>   4 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 0babd10..61deefe 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -23,6 +23,7 @@
>>   #include "cpu-common.h"
>>   #include "qemu/rcu.h"
>>   #include "exec/ramlist.h"
>> +#include "migration/vmstate.h"
>>   
>>   struct RAMBlock {
>>       struct rcu_head rcu;
>> @@ -35,7 +36,7 @@ struct RAMBlock {
>>       void (*resized)(const char*, uint64_t length, void *host);
>>       uint32_t flags;
>>       /* Protected by the BQL.  */
>> -    char idstr[256];
>> +    VMStateId idstr;
>>       /* RCU-enabled, writes protected by the ramlist lock */
>>       QLIST_ENTRY(RAMBlock) next;
>>       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> 
> Hmm.. Don't look like a good idea to include a migration header in
> ramblock.h?  Is this ramblock change needed for this work?

Well, entities that are migrated include migration headers, and now that
includes RAMBlock.  There is precedent:

0 include/exec/ramblock.h   26 #include "migration/vmstate.h"
1 include/hw/acpi/ich9_tco. 14 #include "migration/vmstate.h"
2 include/hw/display/ramfb.  4 #include "migration/vmstate.h"
3 include/hw/hyperv/vmbus.h 16 #include "migration/vmstate.h"
4 include/hw/input/pl050.h  14 #include "migration/vmstate.h"
5 include/hw/pci/shpc.h      7 #include "migration/vmstate.h"
6 include/hw/virtio/virtio. 20 #include "migration/vmstate.h"
7 include/migration/cpu.h    8 #include "migration/vmstate.h"

Granted, only some of the C files that include ramblock.h need all of vmstate.h.
I could define VMStateId in a smaller file such as migration/misc.h, or a
new file migration/vmstateid.h, and include that in ramblock.h.
Any preference?

- Steve

