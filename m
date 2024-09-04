Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5A2CD4F4C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 23:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slzVF-0002nJ-QO; Wed, 04 Sep 2024 19:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1slzVE-0002mY-4X
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:33:32 -0400
Received: from mail-mw2nam04on20616.outbound.protection.outlook.com
 ([2a01:111:f403:240a::616]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1slzVB-0007Op-AD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:33:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqY7EtxtBwzM7VRXoMceIhUmdWOAC47XoK1r7yJKnwv93E4H3u283LOe64WHSx9OAGMEsjjF6Hnd8vn1UZkkBGi+h4V67vremRHQzr77ByKf9G3OzEh0I/5CIbtms4jubtiO1kXk9AAE3OYExYg5ffdHC7oaF/U2Szw0eQtzNlrKMig24V2dV9j6u4MRXUKhnRPFCe8t89SXRbsZmfNGxLZBUvv/rhAfACsDXL84F6UIchCWK+96Cwa6mkxHK/0ydBHw97sdsYiSqTSRhroqFuPBDD5aA5iIGgOfKuQ3Q+CQCeUBdAXcvD5VJ4LN8gdfbOE5uVf1Luue94wHaHqAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gl7HjP9x2x2Gp8V/TjnD9C81vadpJ5CDLuNY5oj6dc=;
 b=ZPmdwAMDEFGpO1rcqXPneK4R9aJk86yqN6eSyS/tz/XccL1GDhPWXtEo2apE21aDBBCO9737bJGgiA5zstagJfNYomWx+K0b/EUGoDXe+reqZW9UZALnVzMYHKqKOPeFyqxBswiYMlN/k+RZRNeU/WzWuIMLSuUJn94q3m/6/BZdBqlTey4y/8+OX20rk4OVGvUxZaZavh0AqsZKCRhm4lip7Fdwkp6yF05mh1xqFrrHIfb/xXh8U8b+2Zk/ZXULm9gQfMRP1PldVMM7hvOMc86cn+zcixjb+UgyZBSoKeKZ15/C2PS5jUcAKzAkWGil0RZf9tfPpr2hl9mh6+NdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gl7HjP9x2x2Gp8V/TjnD9C81vadpJ5CDLuNY5oj6dc=;
 b=dzPw63v0Jo9xFs7txM00oDTYJBmN54P8GqOOuUjy518e1mtEtfT3so4EAw0r7h9yRLq/C/0s+Tslm6oUu4lxvHHA5/PJFvhi8gNlU/uOU5mohNWTAOPiMSvxcstFPbsiocuaUzsa3H7fXBMrtNGvRQ1X+vbZsvg1/yB5I6KJJKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 23:33:24 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 23:33:23 +0000
Date: Thu, 5 Sep 2024 01:33:11 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Doug Brown <doug@schmorgal.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <bonzini@gnu.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] hw/net/can/xlnx-versal-canfd: Simplify DLC
 conversions
Message-ID: <ZtjuN8mKuZMgBFJg@xse-figlesia-l2.amd.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-7-doug@schmorgal.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827034927.66659-7-doug@schmorgal.com>
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f406b06-d18c-4e3a-160f-08dccd39f7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmFKbSszaWM0ZmczS2d5ejB6clR1cERmckxJMnJUZklVUC9XWCt5b0dQOTNU?=
 =?utf-8?B?S1pacnhrd3pLMExMeW1DWEcyTDdhWXp5UHVnSXVGWUFMUXBGU1BESXBBS1ZK?=
 =?utf-8?B?TzRoTG9kMXB0OTdoN3lIU0NBb0czem8vVU9PWWFldUxWd3pkajRPdlgzUm9V?=
 =?utf-8?B?UzdlWHI5VnJRRFBDdnRYeDQ5VmxLQnlMUzhQdnpHaEJEWXpyNTRJckR6eE9i?=
 =?utf-8?B?UnZCcnoxWGg1M1BLak9SeTNNWHc0VW13WWVDd0FpeVhhOFBHN0JZWVphaWwx?=
 =?utf-8?B?Z2Z3UHRTSzdHRUdtRkhZMUlVRGtMMnJ2aEhlSFZGUFNCUDhkWDZNWnJ5eWEy?=
 =?utf-8?B?dlRvVzlYckVVTWlUdUh2MDRJcmlzQ2FXMHhlL2Q1STU1VHAzcFdmZ1RvNmx5?=
 =?utf-8?B?VDV0bEtXbCsyKzdBaXRDZU9WS0N0UlBHb29kY1VKRkpKMzlhcVBOeTVpVmJw?=
 =?utf-8?B?a2FwVlJpUk9DODdRcHFPL1pwdXRtZmp3OElLTy9RZkNyQ3RBSkZSMi94bTl6?=
 =?utf-8?B?SFlMbjVSU1JkZktRcFVhMWFaTE5CcTBHRGxuZjltQ3F2TFNIR21TTlptSm1O?=
 =?utf-8?B?K21qVVBrbHJwR2NEZWdGTUE4Z00wY2VqQVd2S2oxbmVQRFhOVldqaVo0WC9a?=
 =?utf-8?B?eW5mbEx1Z3VEN3BPajRYcEtSQkQxSlZjM0ovKzFTUXJhdWI2cXNFelk3NlBv?=
 =?utf-8?B?K2N2ZEdidlBDVkc4SEptOCtXZXg4V2tWN1orQ2FkelRodGRGS05GWnBRN1Q5?=
 =?utf-8?B?eVBEYVdlMENCMGZBVGJqbWE5eGlhbG9Od0FaOTROZXVWUGVtSkRrUXJzcmZt?=
 =?utf-8?B?QjN6cUl6ZHp5K0Fjc3hxeFdpZjYzR2FBV3Vrc3pWSTBPR3UyN2wrVzhiT0xT?=
 =?utf-8?B?aThRTW5ObTJ0ZE5CaWF2MGFuMzRiV2FvbjQvMlJBL2I5S0lFUmlnUWhmdFBa?=
 =?utf-8?B?bUlvWTlJbmQrbWNoeEFxd3RXVmRSQkk3emxlMEVEZEU0NHd0eG8rOEdoNE5p?=
 =?utf-8?B?VVplWnhRQ2Rmb2o4RFVFUlUrU2RGd081ZEJQTFZ1aW9QSS9XempyYVU5dC9X?=
 =?utf-8?B?K0dRSEtMQklZWDFCS0FIdVg5YU8rV3R3K20wUEJPYmhGUUZxZGJsMnUrdmtR?=
 =?utf-8?B?WFE2RFNTajFrVzdVM1BwaXlERjZEOWZBN3Nkd0FoSnRvNDBYTmpsaU9IRlBQ?=
 =?utf-8?B?b2NNelVESWg4V0NnL01MWTcyTWRoOHZaYVdaWGt3RElya1dkSk5CNnVHSVlD?=
 =?utf-8?B?SCt6dmpUNHVBbU93STdkdzNPNGRuMHNpdkdBRUJIbjZ5N0Vld0NZM2RkdVp1?=
 =?utf-8?B?SjB3NDZqS2FYVUNITUtwVnlGazI4K1NmcGw5dTdkcVh1QXNDL0cxbENiaTVs?=
 =?utf-8?B?QS8vaVhyNWZyTHM2Y1FTNHIvcWt0NFN5NVgvU3oxd2hvL0lFWkswVnpXeXdm?=
 =?utf-8?B?ejBDU0hxK01Va3JlMnNENFJrSzZ6OC9MQk5LanhiODd3YWRiYyt5UW1STHlG?=
 =?utf-8?B?cHdXMXhJTEt0SCtVMUszdzU1ZE9JaHZKMU1qWktabHFYTHZpbWlsVW9yV3lO?=
 =?utf-8?B?K1IwN1FIRndyS1I3TndSTnFkRzFXY0IyMDlkaENhZDFTTTFlQVB1SFlmQ09R?=
 =?utf-8?B?R0lYdTVFNHNpcXhvdERsRHRVT0wwaC9PSWpiemF4Yk45SGhqUDZhWGhZV00v?=
 =?utf-8?B?SWdGQTQ5VmRScDZXbHdTZEpDeG1MVitwSXhSb3NGMEQyUlUxZnNZUkpLeUg5?=
 =?utf-8?B?cHlOQ0RBUVZMc29MaG1wV09icnEwZGJZRENpQXdtZ3VoTTlpWDMvREZKNmN5?=
 =?utf-8?B?aUEyUFpGVkV5RlF2MWplQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVwMTRhNHVocmFpM2doN0c3Mk9YdUlvYWJhMmtCSmxyRStveUhQd0JLajdi?=
 =?utf-8?B?a09jYWNrcENPWUxTbGs4eURyUWlETVFYOUVsc25BQis1U3dDRUtEWFpQejA2?=
 =?utf-8?B?dlJabXhGVnBGRGVIZVRoT2RkbEk1U1dUUXhTZ29OYUVBNGxSMzFnRGFWbTRN?=
 =?utf-8?B?R25OcFI5TU5pRE1pK2xrUUR3NzdUVTl1ZVkvaUZzMmJ6dGFtM0V4ZnFWaVlr?=
 =?utf-8?B?UGgzZ1Bpb1lWbGZpR2NJQkNMVEJXdlEyMVlacnkyNTlEZUcwMmpsVVEzTmxh?=
 =?utf-8?B?c0l0RWR2WHl6aXJqYTRpR3RZdkxIT3EvSjJXSy90TjNoQ1ArSzcrN1FDZ2Zz?=
 =?utf-8?B?bmRMUW4zbWNteHBjbkNaZXMvY2o3R1pKOUJuNkhMbTN4REVZTm9PRVoxOENC?=
 =?utf-8?B?UjRlUWNJMmZZd3crcXN4YjdSQmRaR0pjTURCaXdjbFZFRll5dHlVWmMyeUVE?=
 =?utf-8?B?UDllVTJxRVB4aVVibStveE1MbkRjc2pIcFZwVFB1UE1HSlBQSGVEUG11d1F6?=
 =?utf-8?B?REVHTExCSzI3ZTNncUZWWFlUanpJNXZZTjVkWVZYRGJpdGZYd3B2RXYxR3Rs?=
 =?utf-8?B?Vitldk1SditsZG9PWmEyZlh1SFY1Nnkyalc5UUppWjNSSWdIZTNMRE9sZjVW?=
 =?utf-8?B?emcyWC90TzNZcmprRHhzSHNiUjZBN0lGemlVcDFDb1pNQU5tREN3cmJ2T1dp?=
 =?utf-8?B?QVZoN2dvaVF6UHRncnM3TEpMUzI5K0E3U2NsQ1daemVEVnRkMEJyRXd1cFBw?=
 =?utf-8?B?cGQzbnkrNDNtOUplN1RsOHRpNmpBRS9nSEVqUE9UWTVhb2M5dEdYQVJjZkNv?=
 =?utf-8?B?NmFoZWlFMDRaOTZHcUxyMCthb0xnM1drRHZiRUJPc1lNT2hHREM3bWNucktS?=
 =?utf-8?B?UkpPWmo0NzdNSHEyNURFSzVxNlpQYXNKYk9VNnpnVUx2TjBmV2VUZXhVRkFw?=
 =?utf-8?B?aVdZaXl4WERySFRIeVcvdWVxZ29pWDFmWWpTM2NPNzR2RGNzOGYxVXZ1aHp0?=
 =?utf-8?B?YkNTeUdrVTI4aWFwVUxUUTJvclF4WXFOTUQ0NlJDR2tjcU5TNXFYNUZCQkVH?=
 =?utf-8?B?eG1OdWR3Vm9kVnFGd3dvanh5V2xwVkZ6QTZibnArTVd5bVZMRkdta2VCaEFx?=
 =?utf-8?B?dmdMd0hBamJXVytiUVJKU2s1WllrZEVKbFBJM2ZqNmsxNTZ5SC8xTGRrc1po?=
 =?utf-8?B?bTdYS01zeVhWUVhVSzhHQ3Q3dG5hb2hYbFJWV0tKYjM5RVM2WUhISzFpNEox?=
 =?utf-8?B?b1RyeWhEYVU5TzJxU0hmT1QvMVNZTDBjc3lHWnpVTVc0ZHZsc1RIUm5aSU94?=
 =?utf-8?B?K3d0QUJrV2NGUjFiL0hsSjkrRGdyN1ZhemNoTloxRXZCTzFpeUhpbWMzcUo3?=
 =?utf-8?B?aHl5Q1ZTNTU3dmhpSW1OcVZPUThuSlFOVHU0dnJFclZEOUVITE9uMFEwRit0?=
 =?utf-8?B?UDZsK2RPNUFoTzgvMVgvejdQTGpvT2paWFdXTGlyT2h3S0E0amE3QnRFcHpo?=
 =?utf-8?B?c3FNMUpZLytzdXNFRnlqQnBvV3N4ZUM5VmxlaWR0dXFINTFuVGYrUkVJNWR5?=
 =?utf-8?B?OWpxVXYrZmpJSnN6UlVSTXF0d1htWU1zWCtVMkFscUd6bjNSWHZER3krc1Ar?=
 =?utf-8?B?R1R2RTRYOVJNSkV1bFA4SmVPVzdiUll5dEVQalRGUEFkNi8veXFlWW01bmxq?=
 =?utf-8?B?ZllmY1lZQ1NGMXRMNFR1bmVxTmVDdXJrSHFCOFdxTGV6WStEbzZBL1VjWjEw?=
 =?utf-8?B?N2FrN0FDczkvbTJJeEszRkhEZm8zSDVLNVhmQUhUZHBSd3JlbjdpZUNSUHZU?=
 =?utf-8?B?QVhDRFZYTlR0SUx1QjF6aXF2Q2pYUlFXKzBZOUg5eUhUYlNrRDBuUGJ2YU1m?=
 =?utf-8?B?SUsvdGQ3bWtYcngrS1gzSk1kajhyNlEreVVZTnowS2NsZ1ZMS2xwTEQ0ZnA3?=
 =?utf-8?B?MUhQK2pEdDNXUTN2Q2xlQmtEYUwwV2Y4TkJWNEJ4emFaNzZCeXpDblIrYVZi?=
 =?utf-8?B?VGVRNFNOdkhYWDhnSTRTSzNORkV2bnFJOUhlTlJDWWFzZEZ1OU9RMVZSSGhj?=
 =?utf-8?B?d01qUVRvMGhTa3RyV0p4dUJOTkdWeUwrTGNBRTI0VmwwYWdLdTVvcTVCOE9Q?=
 =?utf-8?Q?E4nFLZZGHTgyGPegoHWy8Z96G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f406b06-d18c-4e3a-160f-08dccd39f7dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:33:23.8062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8srBzJE3iOMdpeZzG8sYZ0JIEM711yLNZXrSiUkRRjVXfJPrKo/lSU95Pt2s3NCkTo0rlJiihiU+QzsFtJxcMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
Received-SPF: permerror client-ip=2a01:111:f403:240a::616;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Mon, Aug 26, 2024 at 08:49:26PM -0700, Doug Brown wrote:
> Use QEMU's helper functions can_dlc2len() and can_len2dlc() for
> translating between the raw DLC value and the SocketCAN length value.
> This also has the side effect of correctly handling received CAN FD
> frames with a DLC of 0-8, which was broken previously.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-versal-canfd.c | 67 ++--------------------------------
>  1 file changed, 4 insertions(+), 63 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 5d7adf8740..589c21db69 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -678,8 +678,6 @@ REG32(RB_DW15_REGISTER_1, 0x4144)
>      FIELD(RB_DW15_REGISTER_1, DATA_BYTES62, 8, 8)
>      FIELD(RB_DW15_REGISTER_1, DATA_BYTES63, 0, 8)
>  
> -static uint8_t canfd_dlc_array[8] = {8, 12, 16, 20, 24, 32, 48, 64};
> -
>  static void canfd_update_irq(XlnxVersalCANFDState *s)
>  {
>      const bool irq = (s->regs[R_INTERRUPT_STATUS_REGISTER] &
> @@ -897,59 +895,19 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
>      }
>  
>      if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, FDF)) {
> -        /*
> -         * CANFD frame.
> -         * Converting dlc(0 to 15) 4 Byte data to plain length(i.e. 0 to 64)
> -         * 1 Byte data. This is done to make it work with SocketCAN.
> -         * On actual CANFD frame, this value can't be more than 0xF.
> -         * Conversion table for DLC to plain length:
> -         *
> -         *  DLC                        Plain Length
> -         *  0 - 8                      0 - 8
> -         *  9                          9 - 12
> -         *  10                         13 - 16
> -         *  11                         17 - 20
> -         *  12                         21 - 24
> -         *  13                         25 - 32
> -         *  14                         33 - 48
> -         *  15                         49 - 64
> -         */
> -
>          frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
>  
> -        if (dlc_value < 8) {
> -            frame->can_dlc = dlc_value;
> -        } else {
> -            assert((dlc_value - 8) < ARRAY_SIZE(canfd_dlc_array));
> -            frame->can_dlc = canfd_dlc_array[dlc_value - 8];
> -        }
> -
>          if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, BRS)) {
>              frame->flags |= QEMU_CAN_FRMF_BRS;
>          }
>      } else {
> -        /*
> -         * FD Format bit not set that means it is a CAN Frame.
> -         * Conversion table for classic CAN:
> -         *
> -         *  DLC                        Plain Length
> -         *  0 - 7                      0 - 7
> -         *  8 - 15                     8
> -         */
> -
> -        if (dlc_value > 8) {
> -            frame->can_dlc = 8;
> -            qemu_log_mask(LOG_GUEST_ERROR, "Maximum DLC value for Classic CAN"
> -                          " frame is 8. Only 8 byte data will be sent.\n");
> -        } else {
> -            frame->can_dlc = dlc_value;
> -        }
> -
>          if (is_rtr) {
>              frame->can_id |= QEMU_CAN_RTR_FLAG;
>          }
>      }
>  
> +    frame->can_dlc = can_dlc2len(dlc_value);
> +
>      for (j = 0; j < frame->can_dlc; j++) {
>          val = 8 * (3 - i);
>  
> @@ -1007,7 +965,6 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>                                  bool rx_fifo_id, uint8_t filter_index)
>  {
>      int i;
> -    bool is_canfd_frame;
>      uint8_t dlc = frame->can_dlc;
>      uint8_t rx_reg_num = 0;
>      uint32_t dlc_reg_val = 0;
> @@ -1053,17 +1010,10 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>  
>          s->regs[store_location] = frame_to_reg_id(frame);
>  
> -        dlc = frame->can_dlc;
> +        dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, can_len2dlc(dlc));
>  
>          if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
> -            is_canfd_frame = true;
> -
> -            /* Store dlc value in Xilinx specific format. */
> -            for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
> -                if (canfd_dlc_array[i] == frame->can_dlc) {
> -                    dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
> -                }
> -            }
> +            dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, FDF, 1);
>  
>              if (frame->flags & QEMU_CAN_FRMF_BRS) {
>                  dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, BRS, 1);
> @@ -1071,17 +1021,8 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
>              if (frame->flags & QEMU_CAN_FRMF_ESI) {
>                  dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, ESI, 1);
>              }
> -        } else {
> -            is_canfd_frame = false;
> -
> -            if (frame->can_dlc > 8) {
> -                dlc = 8;
> -            }
> -
> -            dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, dlc);
>          }
>  
> -        dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, FDF, is_canfd_frame);
>          dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, TIMESTAMP, rx_timestamp);
>          dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, MATCHED_FILTER_INDEX,
>                                    filter_index);
> -- 
> 2.34.1
> 

