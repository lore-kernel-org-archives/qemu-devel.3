Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AC6C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62M7-0002BQ-Jz; Mon, 14 Sep 2026 04:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x62M5-00029i-WE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:48:02 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x62M4-0007Uh-6c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5NOt33+X9NdD4OWqBd8VWQiQmXSDaR6oiNxPhJ2biP0HWV/ssvs7BQOXOnbKXGi+A9CwEXCcVTT5pxwgPePYpnrKFyuB2A4+wtNCNk3hr6WWuLI1O2U6IzU91w2hf6PFJvl4SmR5aCzhDpIIqNyRyJZqjwLvH4jGc2aSyDpH0TzACU6FqVblE00MoFGugt9U5iZ1t45aVF0F3epEAZX+To6n6hiPEooXsLbm5Si+KdDBk37CvkNz9wwSEsMyoUedo8aQn35cWcWw+cKynGZ+DkcE6EF+G0AhwTV7Aa/BOQ8S8uSf6sSkQE+fNuTZ58JHXWYIjEM4dzPATyuMhWn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRmHnXaNKYltMwT2B8cNfAsU0vD9XkjREdTFvFyojlo=;
 b=xUWP1Z2JfsAWSU6baDB4IILItHWhCVaX3lRxFRCTBCskPbkf82yUe5rgeM9zhN8xNazgR7sVMXMcLDx77pd1PGtqlq2KHT9F3wPeqGF+RNl1FXw7yxgJJKAuwWikOzom5iTV9AQF4bnThZ5hw8lWEZKL6QNK+cmXIX75YoFlF55wSp5qnSoBL5JxIHQsscDvGDzHw0QFcS5KkYeMyYtsBlrZsy1iDdyzVV00QxSNgVILak+a+Z7wyEOa8SvSRt/LanXx2dyB/JxcTtyUYfy/8EemIEDwtwpunlTm0MscbF02Z9QOKitfxpbdyyXUZyGDKNRyP/VHOe/FOAvyY3c1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRmHnXaNKYltMwT2B8cNfAsU0vD9XkjREdTFvFyojlo=;
 b=NwZY1wymeYM33GqIxRkgYMWUggtKK6SsiRZi7TJUiCLAmP0VEt4DQfxckxgXJj4omhLShWM/vUS+tfv6YOdQ+Nfq9QBnyOQX5S0G8czz7yCkg1gfOQY3Ed1KwZIx8bYZZy8Dbp0izOewT3MeBH094C5GGMLNkL3t+DpM2N6OCbIpCrKsGmRF4+QtfHtJDyRQlFAwQJe6Y7BdiNF12v3qBaSAaGxkMIkHJGHzfb7VpXWPNC3Zby3G9uTJ268Pfl40ss52uRDdCKx+PsiPPPCnxkCxUhUaBjc2Wlv2hwsqQxBG5iojB+S2IiMPekLLgwTy8w94OZTZTHniMLnUK7r9mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV2PR08MB11692.eurprd08.prod.outlook.com (2603:10a6:150:300::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 08:47:56 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:47:56 +0000
Message-ID: <2c7441f3-5fca-423b-bdd0-f155bc9ff472@virtuozzo.com>
Date: Mon, 14 Sep 2026 10:47:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/ahci-test: replace HMP usage with QMP
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>
References: <20260914075321.2429457-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260914075321.2429457-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0107.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV2PR08MB11692:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef99697-872a-46eb-5795-08df123cdf28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|5023799004|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: JRS5z23lp3N/I4UtgA8KwLhjUEXbeuRiobnBBzqziQuzND0fVcVKXf4VdoW1dmwKlLnXXMLbc1Px/pJkVtOXluJCIVpWZ8ZTkp8NeF5pdY9DoYJmZaF7EvH24LfRAUIfI9rNKctvyo+cMKK5iY4gClSJVftRRtlPd9JLoVoedGtCFrlGl464qDI1HI3qEd62N4AKuF+kzE9FQYqhde1KJ4tEMyC5rZzsCU4exITbJVE7yQg17nSAns/s1DcpARJ9wkXwncWOsjyTaVTu26684mUi/PkNcH51AfqP3VXUCcJZ0EG0QWGbrUhOktYvNakAqgqmlelgPQsIoBNZZvR3vSahaOGIVTBWpqkvfT2+hRSQVHUbUOwWWSmHbQ2rWk0uOELX3wM4NQ8jhnEgMhpbYokKWpAJ9dEKHc/0iAgaQrH4Wh1IKTsN09Mr5AYI9+5Dlw3aRA4i1rmYVhKtNztqE/bXeczNLeErsNVYs6LHHbU8d4vQ0LvZuIzXjRjJIrnRJK85xkbDVN2NaX7AwCq0phbwlgQCvtzOIAlFr+NM1Pstjm3Oj491LtinJgwxbRLCWCfrI0e8AzA+wDXdfLdsZGuKW9JkWAOm/Cng+2E75s9uJ89r43qPuIjn2Zpc89W1ZOXa6zRvRTxl2EWixru5yQlqhztAJehp+Rzz7VbfYRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(5023799004)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZoTGpreFYxWDR4b3VBakRJWmQ1RE9lc2t0UzFNTU51WGFmU1A2T3hyNE5y?=
 =?utf-8?B?N2htQmFER24reGJxNkRVRis0UzRpdFFrS0VFYXl4ZVRjTjNlMlJnME1hSFJN?=
 =?utf-8?B?NEJmTXhDREViUG9hc1Y5SVB1QlErcmpGR3paYXpOQi8xNmpOOUlRTXo5MHJD?=
 =?utf-8?B?bSt0MVhsaUd0aEVYS25PM0FVWUU2OFpwTExmWkw3UkNtSGxxTzBlbG16U3BC?=
 =?utf-8?B?OFJTYWlKQWs1R285K1RFTHpZanYrVXMxVUFLQitCdUVzb2VOWTBNQ0pXZ2o5?=
 =?utf-8?B?OHRaN0tyV3o1eTFiWmo0dGxaZlFxVHBHclNyalIrdTUyT2orLzZDNExtUzFK?=
 =?utf-8?B?MUN3R3R1dk1rV2FKTHdrUFA1VTc3U0ozQ2VPclpVZHd3dmNaVmZ5M04xUkF0?=
 =?utf-8?B?OHVmMklYS3MveVBodnZqQlE5cit4dzc4U1p2alJ5aVV1OExSa1Y0c1JCOVU1?=
 =?utf-8?B?cHFDUVBRZ1FQb3RoeFNCRzNMSWlTZ2U3M09QRE9Jc09lcmVzRFJOUlg0SlhI?=
 =?utf-8?B?TWFDcU45UldWcFRYbDN1R3gvUDNUelFkOHdTbzFCM2toU0luRWladStMSkhq?=
 =?utf-8?B?cFNMY2pmRU9qdVBBbGgzWnk4SjNPWHhGS2VpbWYrSCtrUEVZMzlkcCtnU0F1?=
 =?utf-8?B?dXBGOHpvcGVMNFRwWGl5Zy9KVHBPUVJQSVowZWMzMXl1NFVPd05QaEFvdGVV?=
 =?utf-8?B?OFQzZnBhMWRjZUNjYzRxekV5eVQ5cjB4SUNMU2lDM1hwZytiaGo2aE5zVGNa?=
 =?utf-8?B?MXNacjF1VE92MGdacXYwYk1iRzdGbmJhd2dDWW5OZ0JFTStEZFd0YWRTQTQ1?=
 =?utf-8?B?Nlh6djhmNFJzaDV6cHNpVDRMenMxbTV4eTA2eDhvMVhCTnNBa0UvZ0dtSmFO?=
 =?utf-8?B?N3Joa2dxM0ZLL1N4OWRGKzBjU1N5NkduM0V3cWloVitHeURLNlk5TEtVNVc1?=
 =?utf-8?B?QmxlcGFNTGdBSjNZWVE0Z1RsdGNXb2wySGhDaUN3a21wUkVkTGRVbUxOU0ZN?=
 =?utf-8?B?V0UxNkRpaTd6alBBVk52bnRkcWxVSjhIYWxIN3pVa2FMYnpDRURhdDJLamtx?=
 =?utf-8?B?Z1hGZ2srbGFuZm9jTi83TUd4dSt0eHVTMlVTRWsyTEQwSlZmRTZIRDhUSUxT?=
 =?utf-8?B?UEZjWmdid2hjWjcwM3htMEM2eDV2Y1R2MmRnbFZLMjVycTlSbytIY1hqZXlp?=
 =?utf-8?B?QkNWcXkwcFVKVHJEUDNZUEhIV3UvYW5kL010YndlT0RzQS9mUXBUeFcxaEtH?=
 =?utf-8?B?bVlYZCtKZjBzVnpmM0p0S0FIUlpPNG1iZlI2UXgyb2VMejl2SHkvR2pkdWpp?=
 =?utf-8?B?K28rS3ZOQktHOUVhcGliN0s2M3ZmenFUaUJ5eXhDNkROODJ3clFZenBTTkpy?=
 =?utf-8?B?aWhlRHIreEN2MUxBVXVaYnJWUW84QzdwdWZFYmJaRU1XcWVWTGEwSWJnWFhF?=
 =?utf-8?B?dC8wRW81YWRmSWQ1YzBKeVFyZjN6Yk9ja2lyV1prUFI4T0NLSnBYeDN2RVc0?=
 =?utf-8?B?eDVsa0c2alBBVitCaWxwYWJOQlNxU1BIWTE4b3phd251eGk0K3NRaUhRRDhW?=
 =?utf-8?B?a0dNa0gxMUdXdWpTVmo4NjZWdjYyYUpMSmx0ZG8wWjlpNWlDR0U4bGRLR2lv?=
 =?utf-8?B?eWJwL2dVMzdyZ2hCd3BIb3M5VDYxbXY1MVBOOGtEL0piRXEwb2h6MG9ja0Ew?=
 =?utf-8?B?R2ZJMTZjZFV4dWY5TWVHMlJIV2U0bmttVkIvelA4RGlDWTdYK3V2T2FCMmxi?=
 =?utf-8?B?ajQ5TFRGK2NndmlWcjNCZEdBNS9OaVNmSXNQRnVZbmc0N0liZjZxY3VyUEp5?=
 =?utf-8?B?QnhVcFV3U1JSaGVNa1dFSFQ3ZjJFWXowWXVuelVMQVdBbEQxem92eWhRbU5E?=
 =?utf-8?B?dlpBVEZ5eHZ2a2NtLzJvY1gyQzYxb2EwUXhWODZUQlUxdEZCZlVpcitpM3Ix?=
 =?utf-8?B?MUhWZWdGSmFad2pXdVB3cHdtUXFWbk5MUjA0bzdNTnF0STZ3M1RDRzd0TGgw?=
 =?utf-8?B?RVlNMmVjZmd0TkV6MHloVmpUV1laa3RZWWtPRzdSL2t0a3pqY0tnSDl5ZVRC?=
 =?utf-8?B?Q3pUci9TNzIrN1Z4MDVjOUMrV09TeXcxNmZPOHVGLzAzY2RHYzREc0ZiZ1hk?=
 =?utf-8?B?NU13TEdEQ0VtS1pSd1hLK2hiR2RPSCszVW0wREtheDZpcmR0c2FZdDVCdCtx?=
 =?utf-8?B?ZlRkdEQ5SnBoSWRyeWdtOG9vV3czR0NuMlcrQ3dncDJacTU4Z25ZSi82RFdL?=
 =?utf-8?B?Vk1rQzh6SmhESVdTdW5GM3g4NW1qRVBmTG9NdkNnVzc3L29RWWFuZDhrSk1i?=
 =?utf-8?B?dkl2YUxFUXpjSjFrNUsxU3B4ZkdyQ1VJSmlVZVZWQ1lIWHBlVXFXRGY1ZVZ3?=
 =?utf-8?Q?DYCPWOzx3M7pNH4bSLxp1MHlmlPJ0JL07GxZ3kG5sT2Nw?=
X-MS-Exchange-AntiSpam-MessageData-1: 6zzjCsmxroNgkg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef99697-872a-46eb-5795-08df123cdf28
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:47:56.2476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuUWyPtb/cP3xEdbX3/DD9aX9XiSKZFfAMnSDDzbCJ4lUhBylwPybl7iy9PsxE2xK56aHa1cRuLxs8kD+ZwqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11692
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 9/14/26 09:53, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Use qemu-io command instead.
>
> (CI didn't catch this because build-without-defaults doesn't build ahci..)
>
> CC: Denis V. Lunev <den@openvz.org>
> Fixes: bc4f7b451e1f ("tests/qtest/ahci: fix a racy deadlock in the engine stop test")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/ahci-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index c49aa618629b..925f139d7590 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1916,7 +1916,7 @@ static void test_write_engine_stop_in_flight(void)
>       * Retire the abandoned write. handle_cmd() drops a command that arrives
>       * while the drive is still busy and nothing retries it.
>       */
> -    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"aio_flush\""));
> +    qtest_qemu_io(ahci->parent->qts, "drive0", "aio_flush");
>  
>      /* Round-trip through the device to confirm qemu is still alive. */
>      ahci_px_rreg(ahci, port, AHCI_PX_TFD);
Reviewed-by: Denis V. Lunev  <den@openvz.org>

