Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8AC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KuT-0004oW-9F; Tue, 21 May 2024 04:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9KuR-0004nw-0Y; Tue, 21 May 2024 04:31:47 -0400
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9KuO-0006Pr-Lw; Tue, 21 May 2024 04:31:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk+wUnHqsuD5VSQkNtQ0mNMhp1jXLRRAcQWkUlkKplDzuVI6/iH/oSWM9mlyo9PKnzOjrqb/9nAGT4sTUvtv4r5D4Y12WMuyBI5IR/GmoCNj0JmX1uF5xBgBCItL7OcBUUW8W94e77D8PNP+lSdTyUf+tqfQoRTaifN+To+IeFE2WqBDVxWF8zewfulEoXRL1rxGSrasPvgiCatxW+TNn/fk6nT4cFO9eIvTp/ADU3dy99xWeK698KKxxMHooeHVIjgk+gwiNWDRtOsWxp2n50Juj0nG3OQAsjiqwl0nCLB49x7dH0nxc+YVqtH3scZg9w6514HHVn0oIh5C6/SyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAL16uYKcSCKd7J3/soX0fJsBfbvCCLE7WndjJVU0ro=;
 b=TlRlV2PocyEENKST8Nu6Mt7GqVceOfKt+JgTAxaGgu1r3ANaWmMYp1mtIJ9JxhBv6gElC5yHynvVrKAY1rBAh7M/W0A0poQZcwPLNKjMWoAH9vn6/CtnPuGm7NE0LLUaQQ4V+knedqrHr0q/m15CQTzCWO3RC8smn9b32dUWZsndggROogXm/lZj8CCex74hOOAEpkFSPFXC6YoQbvLvq42HDTOEpZuevB6pk+FFQ+n1DD9KcWY3UCE/4q5VvLmPYZSIES7uc8jct2F7bAQsSJQCF2lcYV2aPrwsRLRvxwLSELY/BUaGwhk72WXqUhp9oaLKi7Tsi/7QnBjZS3OyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAL16uYKcSCKd7J3/soX0fJsBfbvCCLE7WndjJVU0ro=;
 b=AbEpuJvuGHxlgME3C/YjchiEGq0tf/EIMRoRASmE2j/aBrk01l6ZttraN+Gov6ZSjn+UefAjFfu8aoDQrrZkPl950qwBfRmV2AWywtqzIYY6dw+Jjvnhqa6ewE+5H5VBYdFv3MAzZYYWIyEDte5OVEKPObYiwVvjFHfhXiaQXgUFTTK9pMK91yU5KvfINye+OCFfraFw8zLdA6rJz/NYSDuzXZQMEvuRZ/X5B4GY/sHcG/Vw6GIqJKh/IUti5NlMZX6Arih4OsDr+jn7+9dQD8FvawKoI56mqrtmpNYw4JQ+qN9aNzi71iSjlBW6xpbPJweD7BHphQRYlvmudPr3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM9PR08MB6132.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:31:38 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:31:38 +0000
Message-ID: <aca29848-228f-4eb9-a16a-61d64d729b32@virtuozzo.com>
Date: Tue, 21 May 2024 10:31:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] qcow2: make function update_refcount_discard()
 global
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0147.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::40) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM9PR08MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4715ca65-bcc8-4144-2dab-08dc79706ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEFUTlJwU1F1MHBhQll3ZFp6ZzZBSEVPTVkrbHUwby9JL1Fkb2g5UUw4N3Vz?=
 =?utf-8?B?REZDbDRFUStaWmRJMXQvTXhzK3Bxdm5NS0ZUQ2Fwd3ViMUNpdTJrT0lHQnNW?=
 =?utf-8?B?QnlBVXVMRTZtalE4L0RIUEZOWll2MkFLVG9iTFlKaUZyWVBvVEtlRzZ0aVI1?=
 =?utf-8?B?WUZSb0diTHRQbEc5ZlpnSUZUdCtpUlpRcTE2cGFTMFhTRENUdUo3QzFCM2Yr?=
 =?utf-8?B?NyttaGcybS9hbERUcUVLOFVFbit2dHdEbFhWM0t6L3Z6S3NDUlcyS3hzRStZ?=
 =?utf-8?B?TFF2MDZITzNRcE9wWDM5N2hDTENlaUpGT2k3aTY4cE9YenR5M1VHMWFYQ1VV?=
 =?utf-8?B?clBKZDgwS04zNXM5TjBYNmdpNlNkSWFWZHJUV3Q3ZmxsMmRjRkg0dC9pOWtv?=
 =?utf-8?B?aW4zVWJaQWJ1Wm5JOWxUcm0xK0FUMDB6K3BSblJMckxicjlQVXRqTnZHTUJV?=
 =?utf-8?B?SGdUYkpaV0Fud3Vtd0p4UWJ3MGxWZ096ek1ySHd5bHByS3NGbFdSc2d3YnpU?=
 =?utf-8?B?MENwcEFhTG1iM2YyaFpqNnFxL01maVZEUVRKSXlNV1VhWUVycW5KM0VqMFE1?=
 =?utf-8?B?QmhZU29RZHhPclROb1lxdWNTYTZUOFg4Q3daaktydDd3MG5KaU0rbDFYZHV3?=
 =?utf-8?B?TDliWWpVYlN3MHJlYVdHVjZSeWZlZkxJeGp0RXNDcER2VVgwNm9qOU0rK3Jh?=
 =?utf-8?B?ZXYxYmVJa2s3Z3lWTlU3VjJZVUx6NE9GcHc4Q1AwSzBGeWJzYXlQZFRuUk9m?=
 =?utf-8?B?dGUrRFVBTFh5dUtQWlJLR2F4c0NuRFBwUmphVW93MEx2ajZ1SWhlNVYrYzI1?=
 =?utf-8?B?MXVTR0VpTG1TWjJjN1JRRmtXWnNPZFlNTlc3M2RmRGhzMk92dDRFaWNUVjlw?=
 =?utf-8?B?S082NDJQYmk0bmkzUlM5ZWFOVCtiNmJnVjFDNTRiKy9tOWswb0htVFJndm5M?=
 =?utf-8?B?cjk3M09GUkNCZFhtYzJqM2RXWm1VUnViYXpKeEhNUENwYjBXZ3hVQ1oxUVYx?=
 =?utf-8?B?S293RTV2alFxMTMzWmk1b3BUdkhZNmJkYWUzUGFwODdPVkozQ0xZR3lxNFJB?=
 =?utf-8?B?QXU5dWIvNG1IQjBqWjZLQk1qaG5TdHdnTjNGTDIza0hXWGpHMDQxSGl6QVpj?=
 =?utf-8?B?TVRKNERCVGYyYVFlT3JQMytsK2QxdXkrNjJndkpSN2NjYTNNemsrem5Ucmlp?=
 =?utf-8?B?MHgzeHVYTDdwcW9RbjBQaXNqNUtoUzRLdzBEamhyNmtlVkhKT01UbE1NSEp1?=
 =?utf-8?B?ZE1wbmtPZ3djV25wVTBpVUpiMkg0ZDhPYlJVNVMvckhTdHFnQ2FQUnBoRlMv?=
 =?utf-8?B?bGs2MkJ4Ynh3N3NHOTlVV203bHdvWGtoWlBjM3dTSHhjWE5oSHBXVVVIcnJ4?=
 =?utf-8?B?TTNFTTYyWnMyWlFiNVVRK3phZjV4ZHJVZ2RXRGFIc0VTMkFPZWNXRjN0Szc0?=
 =?utf-8?B?SUNEQVdTeXA2ekZUSzNvQTRzN0tRVzlOQnZOOE1JcndWQm5PMGNOK0xUM0Vm?=
 =?utf-8?B?TCtXd1VEdFhrT0FCOWtmMTFGdm9paUxsdzAxSXdSVHlISlpLU245ODZtRXFC?=
 =?utf-8?B?QlZNcStmZnYwbjhoQXJMcW9sR0FaVFJXQUM1Ulc3dHJZWVhXVTZVMElFZWpu?=
 =?utf-8?B?UTZ0L1JMQjJtaVJheGw3Sk9uZjdBY0JMc2hUWjUyS3loWDlIR1pHWTRMWGs4?=
 =?utf-8?B?YzZKSmpWR3FWVHJRQlZyaXJpVVRZNG1qdWl3bWZFcEE4eWNYYVgwQjFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDExYmgvVjlMSFRzZDQ5alFaRmZLS2VtM2IwZnlBcGlLUnRGbEdZdmNpdWlh?=
 =?utf-8?B?RnFsQ1V5YzlFVlB1T3kzQWFldGVpOXg2NFlRN1UvRHBNYzJudG5jZ1ZiWTU2?=
 =?utf-8?B?NVRnUjNvR2kwZURYbW16Z0x3c25DNXJxQk4zWlhJejFsaGVZQWJLdUs5K3A2?=
 =?utf-8?B?S1FYNHlya2dHSlpqTy9qcVlIb1RXa1A1M2hYZEw3VUdWMWt4dE11dkZCSXNT?=
 =?utf-8?B?Y3RIaUhBWldyYm55Nm5CVEZUSi9tU3BQNjJlUXlUODNybDFDRmhmMVNrME9s?=
 =?utf-8?B?K0NnUHJjWWtpem52U3g0U2dJZFQxSDdyY1pjcVVWYlB0M2RNVkN3Nmw4dXFy?=
 =?utf-8?B?N3p5TXVucVJ0ODYvRkJWZThLWnl5bEhCNy93VTFSOGt0ZzBPSU9lblpBOUdJ?=
 =?utf-8?B?TDlSenJnWDR1MGcyM1FwbHZoUWN3dkJuZGNLc1VTMDZwRDFaSUtYVDQ3ZHhJ?=
 =?utf-8?B?TWh0NmRrRWt6bkJZK0xKT1dsQk42UmJoZVMyU1A1NVpSMS9HSzRWdEd5aXpS?=
 =?utf-8?B?eHAvVEs4TFpwOFdzaWZHWUdlZFdCR0ZFRXJtcFA1R2xkanZqaU9pV3JoTGgz?=
 =?utf-8?B?RDRZaDhHOXJpbDEzTWNyd24zNW5QK2czUUw0TWEwNUJUVHMzbkJPeVlKelZk?=
 =?utf-8?B?MmJUcXdoR0NNYTRlZG5XcjZOMkZQZk9OelRZTnpoaE15YVQyOGNGM2VnTzFK?=
 =?utf-8?B?djN0QTljcGpRNWV1cXZybGtuSEtEZ1c3RjN5dzkxQnViWC8xdHpsNXoxejN6?=
 =?utf-8?B?WWxmdGUxUmdNRnd2ZThNUDlVNEUrc2JhNG5GVkVPbWNIWG9IUkxHNVhyOXJU?=
 =?utf-8?B?Mmp1SmlRWXBPc1liQ0VROGxVcU5DY3hvanl4Q1hRS1BINW1hTlVOemppaXcy?=
 =?utf-8?B?WHlTVFc0cmJWNTFpbjgzU0d5dUZLcGliUmx1ZnZoMnQ5UEZtUStSWW5xWGlv?=
 =?utf-8?B?WHhOb2FFcVZGcFhFcHV5NEphRi93eS9WS09OMXI5S3NVbzM0Y21Pc0NuWFk1?=
 =?utf-8?B?MzhNaVJrZkV1WkFTVzR6OVJjcm5aRE81SEpUWXo5ODUzdTFtcGVoM1Zkd21p?=
 =?utf-8?B?dEdwMUJBZzI1TjJKSkJKVjZvQmpoMjZNVnE0VERVeU5OQnd5Ny9pbU50Ukc2?=
 =?utf-8?B?a21aUGxHM2lsTnM0RURFUWdZMUJobTNGdEc1US9URjFXd0JJMHVjNHpDOU43?=
 =?utf-8?B?WUJ6ZXVNeVYxbVVNU0dEc3JsalhVam16ZWlLYmc0ektSL0VJYW4wZGxpS0Fp?=
 =?utf-8?B?YWIyVi90cHZLUHM1dUtvdVdmZmRpNnFhTnNkZHZOL2VwZnVyN0tPZldrckF0?=
 =?utf-8?B?Q3VzS2F4Y21tNDVXcElzcG4rb3JicStndytESlhtUkg1NDFFYXNQYjRUelFK?=
 =?utf-8?B?UmxVa0pHT21kajM4K3BuYzd3aUl3bDZ5RmlyOWE1R3BYNWNIVEdMT0g4a1Iz?=
 =?utf-8?B?dzkrb2Y3ZVBMTTd2RVFSZk9YbExEUFhGbDJnRlovNjR4bUVOMjhUdzNiSEJG?=
 =?utf-8?B?dEhsU3I0VGVrV0xyQWpDM3dWZG9yZmxtS3A2eEFRYVlzb0xLZzN3cVNvMXl6?=
 =?utf-8?B?M1Y3aHpLS2ExQ3NDY3ZUSnJhUXBNNDVTRThBNjNLS3dZTHk1NGpBakFsVGtk?=
 =?utf-8?B?TkxYUGZOb0F6OVRjNGlOcWlSbHBnNFpXVm41MWI5Q0hVUExWdmRkWGMycUgw?=
 =?utf-8?B?WUl3VTFNY1hEYWo0RU1uVXJaaGZKd0llUVBtdEpqenNLODEzQ0N5QW94NVlC?=
 =?utf-8?B?SzcxRllPSmhjS3p1RzlodmhFcGkxSzd5aFI2cXErZ1FRaC9XSjhrYnd3Z2RL?=
 =?utf-8?B?TXh1U3JDQVh0aFB1TU9tQTUwL0lFU0IrTE9yMy9yZWtlbkVicnNxaUZIUWRQ?=
 =?utf-8?B?WUx0dDBXeUdjVVV6WlVnUzFndngrRjI3emxOMTI4SHlmaWJZWXJvZHdpWUNH?=
 =?utf-8?B?bkRvZlRReUhHbTlXVXFjSVZuUVl6WVozZzd0cWE2YmJpSzJJNFAzcjNacVhQ?=
 =?utf-8?B?UWNUNGhtUWRtM3BNZkZSVEhrOFFqelhIdHJJQ2E4bGpyQXlwaVRaS0VwZVYw?=
 =?utf-8?B?OUN2bFVIRVQrQVM3ZFFidGxDckNHeGVsekhLd3ZuMHpkUit5cHRxVUoxNTgx?=
 =?utf-8?B?MTN6K3lRdW16Z0dLYm5JdGN4elZTRjhaNGoyd2FhOXdNQkE3R3BXYk1TODRP?=
 =?utf-8?Q?OZOGa9DbKm6Ve6N7RbqLxVA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4715ca65-bcc8-4144-2dab-08dc79706ebc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:31:38.2323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaVsSv/7JlDb8VXDqfq1y0KMi1IHGiO+ngVkPesSZ9hMNoD70sBHVGbG2WF28evzLprshpj6l6A+dme6J9n2m1Btje90a3rpa+hMINzWnBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6132
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



On 5/13/24 08:31, Andrey Drobyshev wrote:
> We are going to need it for discarding separate subclusters.  The
> function itself doesn't do anything with the refcount tables, it simply
> adds a discard request to the queue, so rename it to qcow2_queue_discard().
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/qcow2-refcount.c | 8 ++++----
>   block/qcow2.h          | 2 ++
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 0266542cee..2026f5fa21 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -754,8 +754,8 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
>       }
>   }
>   
> -static void update_refcount_discard(BlockDriverState *bs,
> -                                    uint64_t offset, uint64_t length)
> +void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
> +                         uint64_t length)
>   {
>       BDRVQcow2State *s = bs->opaque;
>       Qcow2DiscardRegion *d, *p, *next;
> @@ -902,7 +902,7 @@ update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
>               }
>   
>               if (s->discard_passthrough[type]) {
> -                update_refcount_discard(bs, cluster_offset, s->cluster_size);
> +                qcow2_queue_discard(bs, cluster_offset, s->cluster_size);
>               }
>           }
>       }
> @@ -3619,7 +3619,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
>           /* discard refblock from the cache if refblock is cached */
>           qcow2_cache_discard(s->refcount_block_cache, refblock);
>       }
> -    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
> +    qcow2_queue_discard(bs, discard_block_offs, s->cluster_size);
>   
>       return 0;
>   }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index a9e3481c6e..197bdcdf53 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -891,6 +891,8 @@ int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *re
>                                          BdrvCheckMode fix);
>   
>   void GRAPH_RDLOCK qcow2_process_discards(BlockDriverState *bs, int ret);
> +void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
> +                         uint64_t length);
>   
>   int GRAPH_RDLOCK
>   qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


