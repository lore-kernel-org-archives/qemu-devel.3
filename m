Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BFCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFfS-00036q-JV; Mon, 30 Sep 2024 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1svFfP-00031x-Ny
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:38:19 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com
 ([40.107.94.53] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1svFf8-0004iI-Ga
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqq77k9wbVgrdRZ4Oz21I0Sm9fZhQY5D2cZ9KWwdPxZ26lzGlAl+F3e0AE8opsj5s/EejWaPifMxubEhwA3S5sQFb1OHedTamwcs152AdOOrNiY+Akxvxk7pNAS9OYQdZBnK5UULAsu+DbBFE8MCFdL6rUrbPH1xz6zrZBlisnZZJHsnh3yJ0CdsaZwuCMtSZ3lpkT4J2zzQL7kUJq4RaJcnSFO2hkQgp76KV8ZiUkqGM4VJ/z3SXmhUUTPg69fuMNi1pabAGlK6pBpW9NHvBjOapppImX85bcFAyaAMnw6ndur02u3+pRV58ZHcpiRTEd0acmyFfSJ3hnguiLijhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObeD7c73nt9/vOoGyZ7PPusoszERBoOG3tpGd8lIzNo=;
 b=nrGMIkJ4tFQIVDWJB8H5MBBiUdwP1myQuNSaVMHTWDn0v2rANFzrskxt4o5vHnoWMk+wghnwUe78WvLnB8gxiOxXAHIl+xx8Ao8lB8wUuVzINfHahTSKfbSgovCco7e7GXc6TaZnaxFzHuOLUGD1GJ3LkZh7oTMPVQn/LM9D4+GGxS8wIvTCYKPtAUJxeGFTly7fK6H1eVpqu4rKaXjBSG1dDNAApdXamj6qin9CjDC8qxHO1QniWz4iMP6DNnUGUMiF36KqXDvCOh2DV+bUDbuX+4TFNFR0zjd1s4y1sckZGF/cHKpZaHv9Cf/FPF+TlZ3aaG+ZalhF6IqO6/kpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObeD7c73nt9/vOoGyZ7PPusoszERBoOG3tpGd8lIzNo=;
 b=rct073u1pd0eY/oPCssphshwFBsIFJlGIkCNG+6jKRQDh94gItW4kKQZ0Yl/TA/lBf6LV4Iw6Pwq3GK76qBGHXqXMuI8I2FyLkCGDpYU4GYu2zEP/7vyBZuTUIokNi9oQGoIftVPeMFDF5CVNvziDFsFXHs92bNCEWGJozZkXzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:32:52 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:32:52 +0000
Date: Mon, 30 Sep 2024 14:32:46 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me, sai.pavan.boddu@amd.com
Subject: Re: [PATCH 1/1] hw/ssi/xilinx_spips: Fix flash earse assert in dual
 parallel configuration
Message-ID: <ZvqabpGOlBcQoZ1T@xse-figlesia-l2.amd.com>
References: <20240924112035.1320865-1-Shivasagar.Myana@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924112035.1320865-1-Shivasagar.Myana@amd.com>
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ec32ec-8721-4979-aa7d-08dce14c00b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEdCYUs0SDB6cnRPMkJaTFFZZlptMWl5ZG5ITjFVS1phOXJMNTZYMEVLZncz?=
 =?utf-8?B?cFVCVzMycWlvbkRkcGx5aTRqcDNzOU1zcTBjSWRWTUlzNytRTW1mSE9lV3dB?=
 =?utf-8?B?cHpQQ2pBeGtDVlQvT3ZsaHE5VTRSa0NjUlpCN3ZyUHpmL0E3bCs5eGM5TExE?=
 =?utf-8?B?ZGd5MFcrK016NGlkQkprYkdpQmF3R3dQOWo3dlBWSUpjWlNZMDF3Qithamt5?=
 =?utf-8?B?VmNvTjd4NC91K3U5MUpBeEdaR1dMRGFBSG9ISzU1YXV3RmFmNDNmWE5lMzRT?=
 =?utf-8?B?M3p4VjhCelVqQk90aG42UHlPYWJVR1JsR0JWVmdGUzEzU0Z3ZksrSkUzaVJU?=
 =?utf-8?B?SjRPNExKaHF2QnFtV3RCZ3FZckpCOVRKQ0NsYXRKaGpxbXgwc3M5dXNXTlhM?=
 =?utf-8?B?L3R3WTRBcGNoclJEOEFoT2lyYTM1K3JCTFN3cUNjMzBCQjlUbmt2RkRKMGJu?=
 =?utf-8?B?ODdaWG13OUdLdFZxNFVWaXhhYjRTSXQ0STJHOW9EbHp2R0U0cjl3VVlza29E?=
 =?utf-8?B?WGxIL2RaRTFDdWV6RDFTanZQc05mcGZJdlVmbUh0dEl0QllxSEczRmw4aVdo?=
 =?utf-8?B?emZILy9vYlc0cGcrYUxKc1BjaWRrRVNXVDdhMmQvbUs3VjlLTVNmNmZJVURj?=
 =?utf-8?B?dXZUSUphVFl0QjRWY0xlRDBST0srSkJGSDBZN3R4NFF2YmFQTnZxYTBUK25t?=
 =?utf-8?B?dDJNTzJtcUE1RmgxSjJjdStGNTZJZVJLNk9UalAxZUluZ3J3UzVNZnlEeDV0?=
 =?utf-8?B?MDl1YUJuN1R3MVZ6K2xQYTZ3elRPamhKSTlCc2dMZmprOFFIUUlwa1ZDeWs2?=
 =?utf-8?B?L0IxSG9FbmVaMnZiMlFmc2JQRVQ3SXhwL2FJT3VjbmhUdnEzYnFVazczajhD?=
 =?utf-8?B?Vk41VERLeEtoSFc2WXBEWDJpOE9GcHVKc2NLblRPMDBUZnhQQWx0YjBKYzR3?=
 =?utf-8?B?RC92SU12eWlRSS82elhKTzFzRHRLd2dzVS9wTkxWdXJJQyttRzhmRmUybUtQ?=
 =?utf-8?B?Y1BtVEFJc0lIWUxOY0lQeFdHY05zOUpQeURFeklqeHQzY0hLYlQ5eGE5UTlq?=
 =?utf-8?B?VWtFMmNsM3p3c3JCUFhJZzl3Zk5mcHhjR3FYM0dJbHh2eEt6TzFaR0h4TkdX?=
 =?utf-8?B?TmxzMmt1VHhNNTBLck5SeGdlLzQyemIwNVMwWTVJK1NHaVBaQ1pZTCt3V2Ex?=
 =?utf-8?B?SEV5NmRMRGtmVEtJUWxnSTNTK1hsMVpKVjBsZmNwZ3NpNG83NFN3T2N6WW1I?=
 =?utf-8?B?TWdwNHJBNWhnU1RvSjNtQm9LanFBWGd0Z1NKSTRJTjJxVGlwT292TUwvMm1L?=
 =?utf-8?B?Rkd6cGx3ZDB2MVM1RGZsNE5udGhqT1lmWGYxWks0ZHoybTNDaDlpK2UwQXF1?=
 =?utf-8?B?UnRNYjZOOFJDWXI4WHV4RloxVUVnOVM0MGJ2UXFINDB0Y0NqZENrOWUvWWVv?=
 =?utf-8?B?cUN1QXRuOHc2MlFzK3JoZ2hhU2licXdORk12TGU0dWZ0RGozSUlrZ0Z4K2I3?=
 =?utf-8?B?cVJ3RFpMMGt1OW1PRTAva0pnbkRMaWFhbzZzZnIvR0tuWnM5SENGbnRMQVFj?=
 =?utf-8?B?akxQWUhxZlhsTFFka1lDRE9FSWY5V0FVcUozeXBJaFA5WnZtRi9PNVhZU3pB?=
 =?utf-8?B?K2NJSG1lR0dQZEtiL2tYaWtGTHMyZSswYTY1MEFKc0FBM2QxdU1aNmJxdTR1?=
 =?utf-8?B?VGNycmsxQzNyL3VMTTMzaUViRlVsUW1SeFVidi9wUEVSNDNmdDE1VjVBZWF3?=
 =?utf-8?B?SHdmUXJWOWMyQ3pPbDhVWFZwdXNDQTJSMXJUZVpjc0V2YWFhQllEd1BZdm83?=
 =?utf-8?B?ZjlGS21mbkdRb01ldC9sZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdqZDdaOUN4dEtpYUtwMHlPdHhIMmhFRTI2TGRCeUpxKzU1akUyU2pQRllZ?=
 =?utf-8?B?VEZDNkcvSjlTS2JQbkdFUnhwdkR6TUsxNC95TXNsWnBsUlVFRjZPWTFqNDBU?=
 =?utf-8?B?Q0pheFRLVlRmNzNKOGkwaXlJY0Q4WGRlMXpZVUpkUUVaMjEvYmhiVEE0VHhC?=
 =?utf-8?B?V0VQWTEwTEpzd0FlUEw0elV0QUFKQ2hEUmQ0S0UrMW1kQ3drK1FqSmhVajEr?=
 =?utf-8?B?ci9tRmYxaHBaWitJMndwM3E2Wkd6Wm5OZmpMYkptdU1ycHpkNzVDZkJtdHM4?=
 =?utf-8?B?bFFJOStjYkZaSmdEdnZ1UXFpbTIvdUF4aUE5UHJGenlKa1FyMVAzc2pTWFlj?=
 =?utf-8?B?RTR1N0UrVldXbHlabUJTYVFwdlN1ZStWYjk2QktKZjlpOFE0Rkk3dW9XeDdC?=
 =?utf-8?B?VTkySXRBTU53QnBkU0owMjJnMmlFbE12Vk1vNnY2K2tPSUhJNGQxdzV6cXRF?=
 =?utf-8?B?SCtyc0NIbHF6d2lvSzVuRFpLeElJSU9jQjlPUE4vejM0Yzh5SSs1OUVQeW42?=
 =?utf-8?B?NjZZMjhJeklDMFlrSGZoa3NOQVpwaGgrUVVGangveXN0VUxsaGRQY2pqTDMr?=
 =?utf-8?B?V292dUh1TXE0Z28xWmp4U1NhTUJ2SW1EZitybldVekpucGlRcWJUY2szbllC?=
 =?utf-8?B?VTdPL3pzZENhZitsMUxHaER0eGVoN09EZWRhRC9GYWdMWkNqUDJKUm9FdGMr?=
 =?utf-8?B?d0V5Y05YanF4M1ZrWjI3Z0hJdjRGV0NBcmZjaVhGaEZ3Uks5bXI1em5FZjBZ?=
 =?utf-8?B?VnZPdmQvODlCa0xOVGp1VGVtcG9ZOGRheExuWnd1QWE4QTJkVG93SE5BYWZh?=
 =?utf-8?B?NTNucXp6U2c2ZHE0MFcydE1TOE56Q2p4ZnczeCt1alR4ZnErMm5pellXazF3?=
 =?utf-8?B?a0E4aFZvdFRuMTlrYnd4M2hIT2k1cGovY1dxOHdsR1N1cytTWG9MV1FLSXZz?=
 =?utf-8?B?VTE5dzg4ckhtbXVPMDZHZlNnU2d1eksyRldNcVprS3ZTZGdKem5wd2ROV2x5?=
 =?utf-8?B?eE5pa2tqRUVBYTcyZEc5T2x2dlZXQXUwamsvdE1lUExRVUZYdml2azV6RzUx?=
 =?utf-8?B?bjdid2VEVDBqd3Q5MFNuRmloc1Q4Snhqc3dpRFFxY3lid1NvSWlFM2Y0UWJK?=
 =?utf-8?B?Y1Fia1hFNzh1RGxxTTZTMmRGdTFSdVljSGFrN2VMdlV3aDl3SFpoYStVM3V0?=
 =?utf-8?B?T0Z2VVRQdXRIMDRSL2o1dEFqS3YwM1l2a3BiK3dBRUthcnFJMHpwSitlZm1O?=
 =?utf-8?B?UGg5VXF6MDJ2V1JMaC9jUmVRUnQ3blZEY3gwT1pCZFRFeTdOUlJWeWUzOXph?=
 =?utf-8?B?VHRNeHhoMS9rWnpDYk93b0hRVnN1ZFcwREs4bVdHeHc0VEdYRm1tRmEyMTJN?=
 =?utf-8?B?L1J6THFoTmtiaE5idXBmQUl5aVM0ekRSdDVwdWhwRTZHeHJpckhSSUlRYVE4?=
 =?utf-8?B?WWpkbHV6cW16SHZ0QkRTdUJSRkdyRkFFU21CUDZQSmJBS2VyNlZCY0h2UmQx?=
 =?utf-8?B?LzJVSUx3ckJPcUp3TWlJSXY4S2Fic3J2VU5tMlJQbDVZaFFoemdNelFyYmd5?=
 =?utf-8?B?NWhVRStNRitHdEVNL2hmMHhVOXUycmVqcERURy9ha0FNTVIyRmtzdVBGczAv?=
 =?utf-8?B?V20wSG11MXlhWUFtN01RWkU3VGNQZStvcU1tS3VYRDdldkpiczh4dDhCVHMy?=
 =?utf-8?B?RkFVUmFmUTRlZmZ4OVF4djFjTEhuUWFnRGMzeDJCN2VTdXQ0eFFmT01LeXZK?=
 =?utf-8?B?L0ZOUXZLMktIbHp5dUpOOXJLLzBOQWxMYkxHeGlLMlRpckc4a3pia0pBQXhL?=
 =?utf-8?B?dlRWaVQ2UkVvNGcwMDQ5aEEzVjNsaG81RkIxbENDWDNqVngxMkIwblo5TWR4?=
 =?utf-8?B?bFAvZTd4OE9UVjBvQXJVM3RjWkUyNlYxNnNxS3gzenZwdG1aMEFoRzNCdlNu?=
 =?utf-8?B?SDkvVytBOHNXNnkyQXBLSUNyRVpiVjFkckcydkZvdnhoN2syc1pGVTJ1a1J5?=
 =?utf-8?B?S0RoWU9vVDhJcTlXYzdDV0tYOXNBeElyalhyMDI1dm9zVnRHM3R6UTVaZkU5?=
 =?utf-8?B?MFgvRkwzTW1zQndZVkw5ODUzT0FjYW9MUXRla3NvWm9aODFkV2ZvREYwUUVa?=
 =?utf-8?Q?UANC23Md0nV2CSfnOxVi535kp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ec32ec-8721-4979-aa7d-08dce14c00b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:32:52.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg2ZweoTDH2DufusSR9TGLMCUx0zhiQ30KXH0gLf9MfRuck2QD103aPhi9NACl9SCHamXF/M2y3pSFfZZWob4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360
Received-SPF: permerror client-ip=40.107.94.53;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi Shiva,

On the subject:

s/earse/erase/

On Tue, Sep 24, 2024 at 04:50:35PM +0530, Shiva sagar Myana wrote:
> Ensure that the FIFO is checked for emptiness before popping data from it.
> Previously, the code directly popped the data from FIFO without checking, which

I'm not native english speaking but I think "from the FIFO" sounds better to me!

> could cause an assertion failure:
> ../util/fifo8.c:67: fifo8_pop: Assertion `fifo->num > 0
> 
> Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>

With above changes:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

Best regards,
Francisco

> ---
>  hw/ssi/xilinx_spips.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 71952a410d..adaf404f54 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -620,7 +620,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
>          } else if (s->snoop_state == SNOOP_STRIPING ||
>                     s->snoop_state == SNOOP_NONE) {
>              for (i = 0; i < num_effective_busses(s); ++i) {
> -                tx_rx[i] = fifo8_pop(&s->tx_fifo);
> +                if (!fifo8_is_empty(&s->tx_fifo)) {
> +                    tx_rx[i] = fifo8_pop(&s->tx_fifo);
> +                }
>              }
>              stripe8(tx_rx, num_effective_busses(s), false);
>          } else if (s->snoop_state >= SNOOP_ADDR) {
> -- 
> 2.34.1
> 

