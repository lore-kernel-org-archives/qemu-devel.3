Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF55EF8FFA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoLU-000695-L8; Wed, 04 Mar 2026 10:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxoLN-00068W-II
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:41:02 -0500
Received: from
 mail-switzerlandnorthazon11021117.outbound.protection.outlook.com
 ([40.107.167.117] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxoLJ-000245-9w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSwryGjCZl4MoRIzBexaiDLVWvtsaT0RFC7fAuOYDkhlyT/TjCYvMQh4WKOEhJJKfryKbc7tYsklI7uRYhZz5/Ev9YvjSsr4nZkxxUMKawt5lJtEWIwaJ1XkvQrf9wPofxKHEP+RAkp13HeScXRDxycHYvRSNCOEK4mR6WDSVZBp37bzV4dkqaHq8fc+j9bMb/HqqoV2BAPvWMeiJBra8awUWOtRvLLxw28Z5eSWWdBFvJ++GbkVPEqVe31TbdtWoXRZmoG8XSJRR9uVt1eoH9AYUdnOOj0YQbpQ9waRhwyZ/hPjl6NaMS1h2gPVagpy43pXZKVnTjxk+skv/nDgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Doj7hHYExmjj7refl1hfUJ/YiFrJ8w5SCr6AkRi1WoE=;
 b=dsExSiXo7ubKn/hEBEWa6bRRWSA8rtP3bBWWTS/NR4/UQ5pUOJZSYd+zxeIw69V6furF+jPMw8wZoAK+VKcW4aPaXVJPkGphC8484h0H/ABv+FihYH/r29jU2Dxw266Hv4q/e/GKF5+MMEsRjbXVo8ibxrIP474VGUsitj/jzSfL5iwdGoEC3Nafmyl5GxoA5vB95nuvQ4s3nkssy9Yt/hkGhJw52n8r6kD/DDGDHM3PXoIu6djXc9W4ZsZx5AIrtv7XPgxBGyEyCD1kIZVi8b+2bEPmbBMxXwj2Rbd84pxMNVOdodZgmk+rYnBUO1LcEX82tEyVoLAmhRZXt1G0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Doj7hHYExmjj7refl1hfUJ/YiFrJ8w5SCr6AkRi1WoE=;
 b=bV4QlfoE19oEaR/Y8+pIv5Xc4t/O6uRHK7w9+cmQ43GXWZS99qIHU/t0uCvf16OEg/s83qOqFk+bQUmfFlCOCEnHq+mVobZ4GqifhxHcsqwimTElT734sPLnBD3bCAuHEHhJ3Jlg39xyAzqIoCwCb/XPsXc2nJsg+J5Ol2xKMBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB0877.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:35:51 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:35:51 +0000
Message-ID: <5b8bbc1e-cb8b-44ea-822b-0bdcb6ac225f@epfl.ch>
Date: Wed, 4 Mar 2026 16:35:50 +0100
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: Re: [PATCH v6 4/7] tests/tcg: add tests for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
 <20260303-setpc-v5-v6-4-15c77cfe184e@epfl.ch>
 <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
Content-Language: en-US
In-Reply-To: <430d1aa6-c36c-4399-8e5f-b38a9ae1bd35@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms010501070603040805010401"
X-ClientProxiedBy: GVAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::14) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB0877:EE_
X-MS-Office365-Filtering-Correlation-Id: aa469c36-e3fc-4c63-6810-08de7a03b728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|786006|366016; 
X-Microsoft-Antispam-Message-Info: A9lfxm1//xJam8nRzQ8luBdQptFo70eI+HVaB6IJjWJlhuT7J3QWLW1AerA1SSg7WMp6fsbuNKey66yPJTex7UuOcvwW9VxGRiEq6KxrT7T0bdn9ee733Teygilhy7NgSfQ9wE/8zfTVdxg34lotanvYc7Y655hWJ3jx0r4AhzcLCMOLRMOTh1soIsZQcTLyfxnq0WgXOpwOv3gADmKa5uy477I0rjx3+sImIPKXsJudN9TQuWHc2rFQYsDRkkodYJD9mFn1fg5akC5NCulMid39q8XqtkaLFFlm39BI5DxqE2uBaSkYw2gblueS79X7TuOUr8xzkJzN6d209JCG7zysmr0z6fMXAzEIMLlh2NgsQN6XeXKrDs5AA5pfhz1ZZtluwNXj7yhg/u8CVPk0fvL/EVnfAw9ZrYkfXEi3spisyK5+/wOg3oeDbcLJmu3KwwB7uO1E1HsTu31GoI+2FB+LabT2MgBc4hptcPSpwtGzSbXhX1lOX3UtbbSeT5QTHqTE/7YvMKC/exPqlOrwpGylcNfazHtN7WqOWpBPwhFyrQa4PRme/FvweS+UdvdLNElRIj/DdkkeHmOh0iUG8fZoPK9fIQvEqphE1mDWBk0u6e3xmGN32SNjBlxan/zoSsEmDrmEsm5lLDk3TehIUnZdDzAO21hPgsTMjRVJM9Q+QRqoWLGH+gSgP9Egdk/g91SO6OYQrVM2CcAzk/NZQLxFGhWQ1nKKv0g+YIW6vYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(786006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hBdWU1RUg5UTFCUHRUREx6bmZiRS9LN2ZHS3FjV014Q3ZoU3U2Y3hXVkI3?=
 =?utf-8?B?MTVyRnY1eGFNM3MyRnp4SmcvcjRmcGFadGRWTHZpRkdrdVdQOUY3ZFF0UlFW?=
 =?utf-8?B?dkltVVR5NXhHQWhmcEh0MjhoempCVkc4M1NPd2R6OGdzTTVwM1FVd0xGWk15?=
 =?utf-8?B?R3Y3dU82T3k1cWpyUVpnMXpSUXpIa0dNdHY2OHZLZEdzdWo3S2VQZnBOQ3Yy?=
 =?utf-8?B?YlJIWW9XTE44YkdOMzZraEExZGN5Q2FWR2l6M21NZlYrZmV4WXFHVU1mYnkw?=
 =?utf-8?B?MzhhdnZ3bXJaVTFhUGJhZ3h2Z3I0N2lEMTVmQlM5S1dlMTRZdGwwR1dkS2cr?=
 =?utf-8?B?bE5LT1JabWkzQkt0TUdIM1hvSjN2bjg0RWcxcGp5NENFVUE0KzkzajlSSjJ3?=
 =?utf-8?B?bnRVZnF3QmRXQ0d6WVA4Nm4xY1VRS3g1TGNCNmNOUUZSUG5uNjRkR1FzNTVW?=
 =?utf-8?B?STh4Wk8xbU1WMXNBVGRFejdmVjBHc05KQ0xIcVp3aXlvMnozNW8zZ2hWSU96?=
 =?utf-8?B?bVQ0emZtYW5vaXJlMWRyeDVKcFBra044UDVDVGVTK0I2RHJWQzlyMllBUlFZ?=
 =?utf-8?B?ZnNKL1g0N1pPU0xvS0Q4YUs0bkkxS3drZXU2dnhvSFZTNWFsNDgrRlR0M1Bo?=
 =?utf-8?B?MDRLak9EZ3l5MFYzM0NFUXJTR0JhZ2EwNmhCbGNJOXFHTzQrdzNvakczT3Bo?=
 =?utf-8?B?cnVScHcvQTY3TXRvN1BvdmVMRnBhcytGeU9kV0lrWEYxYTFzaldaTmhlZTFx?=
 =?utf-8?B?MGszbEFKUDhmMWlpUGxMYlhCTUN3VmFPbnVKc2I5b293NDdPS3djR1Q1UHpZ?=
 =?utf-8?B?aFJCbGZXaWliaTNKQnp4TEVyWGFLWFZSV3hHM0h6ekp3RFJnTVJIc3NpUWNu?=
 =?utf-8?B?ai9vVTRXYmk0dW9nWEJyclZPMlQ1ODVUNDdpVU1oRWlDUzBIUVBwWkJ5Y0x1?=
 =?utf-8?B?WW1aWmg2c3F2MDltTnNuVlVRYzNNU1lDb1hNVnZmSzg2Z0d0ZVcwNWU5a0dr?=
 =?utf-8?B?dTVGZ1g4NXMyNEVoM0s3aHZxMUJFZWFSclp1NEgwL0JnSjBjbXY1bHYzZ1Ni?=
 =?utf-8?B?MDdMcHNJdFlSZlk4YkFyaGRDNVRXUzFWZDcvNWhwcjJtcHk1OVJadzZhUmZX?=
 =?utf-8?B?ejg2UW5DTmZJS0srU2gzU2Z1Rmp2c0RvWlp4cHlrZW9aaEQxTlJFUkgxS1hv?=
 =?utf-8?B?NzZqdTBmbStmbk0wMU42aktjOWhLSWR2MzNWcERQSEdrdVpSNjRFb2NKeEpP?=
 =?utf-8?B?eU5DaE8wbzRPT0V1d2lPVGFPS3I0YVdXR2NCaUJIclJhOHZsaEx0Nkd5TGhx?=
 =?utf-8?B?UGYxOENoYTZYZFRIcXd4SXBidUUzWTMyandrS3R5bWJwNUVzNVR0QnlTVE92?=
 =?utf-8?B?VnNPMWQ2bWc0OUxFdENQQkI0UzJhdEVlZTJQcXZjcHBHZ05ZMHpJeCswWFlF?=
 =?utf-8?B?Ull2NUFlU0V2SmI5RXlnU1NUdHpXbDZOMFowSzl6UlZMSUxPQUhUckpmOTR1?=
 =?utf-8?B?Z1JWbElZbHN5OFA1Y3RwS2xwa3A0akNIMVVKMFF4cUxYdXNBYkY2UXBlUVpI?=
 =?utf-8?B?ZytJS1hLV3RJTzcydC9HcnA5VmFqT0l0R09RNXg4dmgzY1VCQmN3S01mU0xy?=
 =?utf-8?B?akxZdFNwRHFsUStKQmI5WlBYaUJZOGZjWUsyUFpDbk5yQitReEJZblphamxH?=
 =?utf-8?B?dDNCYURzczlhK1g1bGlBNGVNZlJtOUVRdUlXaHd1enp6R3h0Q3IycU1XY3BE?=
 =?utf-8?B?UkFYRjVWMzRFb3FVNXNKbXNhS0I3SGNkQ1pMdWZkSDRsMkZsSThKYk1BZFpZ?=
 =?utf-8?B?SDFsN20walA3ZmVnTEdxZVFWa3E1VjEyMkRUTFNRdHlwZklpeTJ5eStuMVVJ?=
 =?utf-8?B?M1FEWEcwcGppdkE5MlFBcjJqMUxoTWc3YTdjckROcGtMN2VNWnhjMGcvU2R4?=
 =?utf-8?B?QTlDVHFqU1RSNWtxQ2ljY1lqd25xMUFoMzFhRFBrNzlaN0JyOGFzMlpVVm9m?=
 =?utf-8?B?MjhBRTk5QzM4bmR3MmdUMDhSMzlGNG16cnF0U3Z5TE1XRlRRZW9rK0RocUZO?=
 =?utf-8?B?aFRTSVEraXF6ZlBla3IyZDlVWWtHYXorczRaZUMyQW9DWk9iYkNRdmdZNTQr?=
 =?utf-8?B?bW43MWpSeTZHejFacDBEZktzUHNhU1R1Szd5M3RHNnZySW16alo4a2pycmpi?=
 =?utf-8?B?OTZzNjVQTVVTUVZrZDY5dlhRaEtkMFZCNFVIWXhPK0FOWlI2bnJIRWdYRm9r?=
 =?utf-8?B?dHNjWTlTM1F4am00UHVrbFhHQzVWS3JVWEFDNFlYYnY5My9EaDQwcXhmWVNj?=
 =?utf-8?B?eHJyaUJIbGZBcEhuNXA5VUFrZC9YTVVwUzQzWUo1bFJrNVpnOTlidz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: aa469c36-e3fc-4c63-6810-08de7a03b728
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:35:51.1637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keMg8kX0V+3iqepg+QSe0CKXCgcV75pkVptDNlr4Oyp5kS3b2W2oBV/fU9odHXBK+AuXFxU/USG++0J8RunSTrkZBFSG8bG9DdPYyEb+O+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0877
Received-SPF: pass client-ip=40.107.167.117;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--------------ms010501070603040805010401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2026 20:46, Pierrick Bouvier wrote:
> On 3/3/26 5:07 AM, Florian Hofhammer wrote:
>> The test plugin intercepts execution in different contexts. Without th=
e
>> plugin, any of the implemented test functions would trigger an assert
>> and fail. With the plugin, control flow is redirected to skip the asse=
rt
>> and return cleanly via the qemu_plugin_set_pc() API.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   MAINTAINERS                                        |   1 +
>>   tests/tcg/arm/Makefile.target                      |   6 +
>>   tests/tcg/multiarch/Makefile.target                |  17 ++-
>>   .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0
>>   .../{ =3D> plugin}/test-plugin-mem-access.c          |   0
>>   tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 140 +++++++++++=
++++++++++
>>   tests/tcg/plugins/meson.build                      |   1 +
>>   tests/tcg/plugins/setpc.c                          | 120 +++++++++++=
+++++++
>>   8 files changed, 282 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6698e5ff69..63c0af4d86 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4104,6 +4104,7 @@ S: Maintained
>>   F: docs/devel/tcg-plugins.rst
>>   F: plugins/
>>   F: tests/tcg/plugins/
>> +F: tests/tcg/multiarch/plugin/
>>   F: tests/functional/aarch64/test_tcg_plugins.py
>>   F: contrib/plugins/
>>   F: scripts/qemu-plugin-symbols.py
>> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.ta=
rget
>> index 6189d7a0e2..613bbf0939 100644
>> --- a/tests/tcg/arm/Makefile.target
>> +++ b/tests/tcg/arm/Makefile.target
>> @@ -78,4 +78,10 @@ sha512-vector: sha512.c
>>     ARM_TESTS +=3D sha512-vector
>>   +ifeq ($(CONFIG_PLUGIN),y)
>> +# Require emitting arm32 instructions, otherwise the vCPU might accid=
entally
>> +# try to execute Thumb instructions in arm32 mode after qemu_plugin_s=
et_pc()
>> +test-plugin-set-pc: CFLAGS+=3D-marm
>> +endif
>> +
>=20
> Is that still needed?

Yes, unfortunately. The compiler emits Thumb2 instructions where it
deems it appropriate but the addresses of functions/labels are still at
least 2-byte aligned and therefore don't have the bottom bit set.
Setting the PC to an even address therefore makes the vCPU think the
target is in arm32 mode, and it tries to execute the Thumb2 instructions
in arm32 mode. I'd either need to ensure that the targets are always in
Thumb2 mode and set the bottom bit myself, or ensure that everything is
in arm32 mode from the start.

>>   TESTS +=3D $(ARM_TESTS)
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch=
/Makefile.target
>> index 07d0b27bdd..a347efbadf 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
>>   VPATH            +=3D $(MULTIARCH_SRC)/linux
>>   MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))=

>>   endif
>> +ifeq ($(CONFIG_PLUGIN),y)
>> +VPATH            +=3D $(MULTIARCH_SRC)/plugin
>> +MULTIARCH_SRCS +=3D $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))=

>> +endif
>>   MULTIARCH_TESTS =3D $(MULTIARCH_SRCS:.c=3D)
>>     #
>> @@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so=
: \
>>       PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>>   run-plugin-test-plugin-mem-access-with-libmem.so: \
>>       CHECK_PLUGIN_OUTPUT_COMMAND=3D \
>> -    $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>> +    $(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
>>       $(QEMU) $<
>>   run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
>> +run-plugin-test-plugin-set-pc-with-libsetpc.so:
>>     EXTRA_RUNS_WITH_PLUGIN +=3D run-plugin-test-plugin-mem-access-with=
-libmem.so \
>> -              run-plugin-test-plugin-syscall-filter-with-libsyscall.s=
o
>> -else
>> +              run-plugin-test-plugin-syscall-filter-with-libsyscall.s=
o \
>> +              run-plugin-test-plugin-set-pc-with-libsetpc.so
>> +
>> +else # CONFIG_PLUGIN=3Dn
>> +# Do not build the syscall skipping test if it's not tested with the =
setpc
>> +# plugin because it will simply fail the test.
>> +MULTIARCH_TESTS :=3D $(filter-out test-plugin-set-pc, $(MULTIARCH_TES=
TS))
>> +
>>   # test-plugin-syscall-filter needs syscall plugin to succeed
>>   test-plugin-syscall-filter: CFLAGS+=3D-DSKIP
>>   endif
>> diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/mu=
ltiarch/plugin/check-plugin-output.sh
>> similarity index 100%
>> rename from tests/tcg/multiarch/check-plugin-output.sh
>> rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
>> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/=
multiarch/plugin/test-plugin-mem-access.c
>> similarity index 100%
>> rename from tests/tcg/multiarch/test-plugin-mem-access.c
>> rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
>> diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/t=
cg/multiarch/plugin/test-plugin-set-pc.c
>> new file mode 100644
>> index 0000000000..40d9a9e8f0
>> --- /dev/null
>> +++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>> @@ -0,0 +1,140 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
>> + *
>> + * This test set exercises the qemu_plugin_set_pc() function in four =
different
>> + * contexts:
>> + * 1. in a syscall callback,
>> + * 2. in an instruction callback during normal execution,
>> + * 3. in an instruction callback during signal handling,
>> + * 4. in a memory access callback.
>> + * Note: using the volatile guards is necessary to prevent the compil=
er from
>> + * doing dead code elimination even on -O0, which would cause everyth=
ing after
>> + * the asserts and thus also the target labels to be optimized away.
>> + */
>> +#include <assert.h>
>> +#include <signal.h>
>> +#include <stdint.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +#include <setjmp.h>
>> +
>> +#define NOINLINE __attribute__((noinline))
>=20
> Test being compiled in O0, it should not need any noinline attribute.

Ack, removed.

>> +#define NORETURN __attribute__((noreturn))
>=20
> It's used in a single place, simply move the the attribute there, no ne=
ed for another define.

Ditto.

>> +
>> +static int signal_handled;
>> +/*
>> + * The volatile variable is used as a guard to prevent the compiler f=
rom
>> + * optimizing away "unreachable" labels.
>> + */
>> +static volatile uint32_t guard =3D 1;
>> +
>=20
> As mentioned on v4, you can simply use an external function for failing=
 the test, which won't be tainted with noreturn attribute.
> This way, you don't need any guard at all or assert(0), and resulting c=
ode is linear and easier to read.
> It test completes, it all worked. If it crashes, something was wrong.
>=20
> void panic(void)
> {
>      g_assert_not_reached();
> }
>=20
> void test_...() {
> ...
> on_panic:
>      panic();
> after_panic:
>      printf("Hello World\n");
> }

I've reworked it to look similar to this (without g_assert_not_reached()
though, because glib is not available in the test itself). Still
required some shuffling of stuff to make sure the compiler doesn't
optimize things away then :) Especially on hexagon, which is the only
target (by default) built with clang instead of gcc. Clang/LLVM seems to
be way more aggressive even at -O0 to do deadcode elimination and
inlining, so I had to add extra CFLAGS for the hexagon target.

>> + * This test executes a magic syscall which communicates two addresse=
s to the
>> + * plugin via the syscall arguments. Whenever we reach the "bad" inst=
ruction
>> + * during normal execution, the plugin should redirect control flow t=
o the
>> + * "good" instruction instead.
>> + */
>> +NOINLINE void test_insn(void)
>> +{
>> +    long ret =3D syscall(4095, &&bad_insn, &&good_insn, NULL);
>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected va=
lue");
>> +    if (guard) {
>> +bad_insn:
>> +        assert(0 && "PC redirection in instruction callback failed");=

>> +    } else {
>> +good_insn:
>> +        return;
>> +    }
>> +}
>> +
>> +/*
>> + * This signal handler communicates a "bad" and a "good" address to t=
he plugin
>> + * similar to the previous test, and skips to the "good" address when=
 the "bad"
>> + * one is reached. This serves to test whether PC redirection via
>> + * qemu_plugin_set_pc() also works properly in a signal handler conte=
xt.
>> + */
>> +NOINLINE void usr1_handler(int signum)
>> +{
>> +    long ret =3D syscall(4095, &&bad_signal, &&good_signal, NULL);
>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected va=
lue");
>> +    if (guard) {
>> +bad_signal:
>> +        assert(0 && "PC redirection in instruction callback failed");=

>> +    } else {
>> +good_signal:
>> +        signal_handled =3D 1;
>> +        return;
>> +    }
>> +}
>> +
>> +/*
>> + * This test sends a signal to the process, which should trigger the =
above
>> + * signal handler. The signal handler should then exercise the PC red=
irection
>> + * functionality in the context of a signal handler, which behaves a =
bit
>> + * differently from normal execution.
>> + */
>> +NOINLINE void test_sighandler(void)
>> +{
>> +    struct sigaction sa =3D {0};
>> +    sa.sa_handler =3D usr1_handler;
>> +    sigaction(SIGUSR1, &sa, NULL);
>> +    pid_t pid =3D getpid();
>> +    kill(pid, SIGUSR1);
>> +    assert(signal_handled =3D=3D 1 && "Signal handler was not execute=
d properly");
>> +}
>> +
>> +/*
>> + * This test communicates a "good" address and the address of a local=
 variable
>> + * to the plugin. Upon accessing the local variable, the plugin shoul=
d then
>> + * redirect control flow to the "good" address via qemu_plugin_set_pc=
().
>> + */
>> +NOINLINE void test_mem(void)
>> +{
>> +    long ret =3D syscall(4095, NULL, &&good_mem, &guard);
>=20
> Since you use two different syscall numbers, it's worth adding two defi=
nes, that you will duplicate in test and plugin.
> Alternatively, you can use the first parameter of syscall to identify w=
hich kind of "service" you want from plugin, with defines duplicated betw=
een test and plugin again.
> Feel free to pick the solution you prefer.
>=20
> Reading 4095 the first time here felt like it was a typo mistake.

Ack, reworked this to be clearer.

>=20
>> +    assert(ret =3D=3D 0 && "Syscall filter did not return expected va=
lue");
>> +    if (guard) {
>> +        assert(0 && "PC redirection in memory access callback failed"=
);
>> +    } else {
>> +good_mem:
>> +        return;
>> +    }
>> +}
>> +
>> +/*
>> + * This test executes a magic syscall which is intercepted and its ac=
tual
>> + * execution skipped via the qemu_plugin_set_pc() API. In a proper pl=
ugin,
>> + * syscall skipping would rather be implemented via the syscall filte=
ring
>> + * callback, but we want to make sure qemu_plugin_set_pc() works in d=
ifferent
>> + * contexts.
>> + */
>> +NOINLINE NORETURN
>> +void test_syscall(void)
>> +{
>> +    syscall(4096, &&good_syscall);
>> +    if (guard) {
>> +        assert(0 && "PC redirection in syscall callback failed");
>> +    } else {
>> +good_syscall:
>> +        /*
>> +         * Note: we execute this test last and exit straight from her=
e because
>> +         * when the plugin redirects control flow upon syscall, the s=
tack frame
>> +         * for the syscall function (and potential other functions in=
 the call
>> +         * chain in libc) is still live and the stack is not unwound =
properly.
>> +         * Thus, returning from here is risky and breaks on some arch=
itectures,
>> +         * so we just exit directly from this test.
>> +         */
>> +        _exit(EXIT_SUCCESS);
>> +    }
>> +}
>> +
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +    test_insn();
>> +    test_sighandler();
>> +    test_mem();
>> +    test_syscall();
>> +}
>> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.b=
uild
>> index c5e49753fd..b3e3a9a6d0 100644
>> --- a/tests/tcg/plugins/meson.build
>> +++ b/tests/tcg/plugins/meson.build
>> @@ -7,6 +7,7 @@ test_plugins =3D [
>>   'mem.c',
>>   'patch.c',
>>   'reset.c',
>> +'setpc.c',
>>   'syscall.c',
>>   ]
>>   diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
>> new file mode 100644
>> index 0000000000..72ae31a0ef
>> --- /dev/null
>> +++ b/tests/tcg/plugins/setpc.c
>> @@ -0,0 +1,120 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
>> + */
>> +#include <assert.h>
>> +#include <glib.h>
>> +#include <inttypes.h>
>> +#include <unistd.h>
>> +
>> +#include <qemu-plugin.h>
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>> +
>> +static uint64_t source_pc;
>> +static uint64_t target_pc;
>> +static uint64_t target_vaddr;
>> +
>> +static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index=
,
>> +                         int64_t num, uint64_t a1, uint64_t a2,
>> +                         uint64_t a3, uint64_t a4, uint64_t a5,
>> +                         uint64_t a6, uint64_t a7, uint64_t a8)
>> +{
>> +    if (num =3D=3D 4096) {
>> +        qemu_plugin_outs("Marker syscall detected, jump to clean retu=
rn\n");
>> +        qemu_plugin_set_pc(a1);
>> +    }
>> +}
>> +
>> +static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcp=
u_index,
>> +                                int64_t num, uint64_t a1, uint64_t a2=
,
>> +                                uint64_t a3, uint64_t a4, uint64_t a5=
,
>> +                                uint64_t a6, uint64_t a7, uint64_t a8=
,
>> +                                uint64_t *sysret)
>> +{
>> +    if (num =3D=3D 4095) {
>> +        qemu_plugin_outs("Communication syscall detected, set target_=
pc / "
>> +                         "target_vaddr\n");
>> +        source_pc =3D a1;
>> +        target_pc =3D a2;
>> +        target_vaddr =3D a3;
>> +        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63)=
 {
>> +            /*
>> +             * Some architectures (e.g., m68k) use 32-bit addresses w=
ith the
>> +             * top bit set, which causes them to get sign-extended so=
mewhere in
>> +             * the chain to this callback. We mask the top bits off h=
ere to get
>> +             * the actual addresses.
>> +             */
>=20
> This looks like an actual bug. Using a backtrace here, can you find whi=
ch function extended it?
> Parameter should be treated as unsigned everywhere, else something is r=
eally going wrong.

tl;dr: register values are considered signed in the syscall handling
code, which seems incorrect to me. Details below.

This seems to be a bigger issue in the syscall handling code and I'm
surprised this never surfaced before. Generally, the CPUArchState struct
in target/*/cpu.h defines the registers as unsigned types. When a
syscall is encountered, the main cpu loop calls do_syscall() from
linux-user/syscall.c, which takes and returns abi_long values. abi_long
is defined as either int32_t or target_long in include/user/abitypes.h
and therefore a signed type, so the register values get converted from
unsigned to signed types here. do_syscall() passes those abi_long values
on, e.g., to record_syscall_start() and send_through_syscall_filters(),
which still take the register values in as abi_long. Those in turn
however pass the values on to qemu_plugin_vcpu_syscall() and
qemu_plugin_vcpu_syscall_filter(), respectively. Those two functions now
take uint64_t values for the arguments, so for 32-bit architectures the
conversion chain is uint32_t (CPUArchState) -> int32_t (do_syscall) ->
uint64_t (callbacks).

This seems to be some bigger refactoring changing all those abi_longs to
abi_ulongs. Would you like me to prepare a separate patch series for
this?

>=20
>> +            qemu_plugin_outs("High bit in addresses detected: possibl=
e sign "
>> +                             "extension in syscall, masking off top b=
its\n");
>> +            source_pc &=3D UINT32_MAX;
>> +            target_pc &=3D UINT32_MAX;
>> +            target_vaddr &=3D UINT32_MAX;
>> +        }
>> +        *sysret =3D 0;
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
>> +{
>> +    uint64_t vaddr =3D (uint64_t)userdata;
>> +    if (vaddr =3D=3D source_pc) {
>> +        g_assert(target_pc !=3D 0);
>> +        g_assert(target_vaddr =3D=3D 0);
>> +
>> +        qemu_plugin_outs("Marker instruction detected, jump to clean =
return\n");
>> +        qemu_plugin_set_pc(target_pc);
>> +    }
>> +}
>> +
>> +static void vcpu_mem_access(unsigned int vcpu_index,
>> +                            qemu_plugin_meminfo_t info,
>> +                            uint64_t vaddr, void *userdata)
>> +{
>> +    if (vaddr !=3D 0 && vaddr =3D=3D target_vaddr) {
>> +        g_assert(source_pc =3D=3D 0);
>> +        g_assert(target_pc !=3D 0);
>> +        qemu_plugin_mem_value val =3D qemu_plugin_mem_get_value(info)=
;
>> +        /* target_vaddr points to our volatile guard =3D=3D> should a=
lways be 1 */
>> +        g_assert(val.type =3D=3D QEMU_PLUGIN_MEM_VALUE_U32);
>> +        g_assert(val.data.u32 =3D=3D 1);
>> +
>> +        qemu_plugin_outs("Marker mem access detected, jump to clean r=
eturn\n");
>> +        qemu_plugin_set_pc(target_pc);
>> +    }
>=20
> Thanks for adding this case also!
> So you'll definitely need a read for this precise test, to be able to k=
eep a load. If it would work with a local variable, that's good, else, tr=
y with a local static (eventually marked volatile if it helps), and in la=
st case, use a global variable.

Works fine with a local variable!

>=20
>> +}
>> +
>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb =
*tb)
>> +{
>> +    size_t insns =3D qemu_plugin_tb_n_insns(tb);
>> +    for (size_t i =3D 0; i < insns; i++) {
>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb,=
 i);
>> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
>> +        /*
>> +         * Note: we cannot only register the callbacks if the instruc=
tion is
>> +         * in one of the functions of interest, because symbol lookup=
 for
>> +         * filtering does not work for all architectures (e.g., ppc64=
).
>> +         */
>=20
> Too sad :)
> It's not a problem to instrument all instructions though.
>=20
>> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
>> +                                               QEMU_PLUGIN_CB_RW_REGS=
_PC,
>> +                                               (void *)insn_vaddr);
>> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
>> +                                         QEMU_PLUGIN_CB_RW_REGS_PC,
>> +                                         QEMU_PLUGIN_MEM_R, NULL);
>> +    }
>> +}
>> +
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>> +                                           const qemu_info_t *info,
>> +                                           int argc, char **argv)
>> +{
>> +
>> +    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
>> +    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filt=
er);
>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> +    return 0;
>> +}
>>
>=20
> Thanks for the update.
> Test looks good, and minus the style nits reported, it looks quite read=
y.
> It would be nice if we could sort the signed parameter extension also t=
o avoid a hack on this.
>=20
> Regards,
> Pierrick

Best regards,
Florian

--------------ms010501070603040805010401
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwNDE1MzU1MFowLwYJKoZI
hvcNAQkEMSIEIIaD5SzfTF1pAtufBM313JbEr6/f9+ewn+vDVqXiVYzhMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBANhyGWupGx5j4gnPEjH1D8yPgit8
V2b93i74R/A5zX7+NvaNWDcHCMAW2VVzYtEgHepEhUnsvvmyn7VD5LqoK6XJTKgK6QbLaLak
d2APU+0Ug9puMYKFxQA7/gBVJ2YMIzgPa9pbaUV/IOaDIrPfr++i/a7Tw3ycbAizsaOwq/ok
qGYJpv5J/jydwnNWFsissJyQ2BwVKILJoOr3EebAA5RDCLZKw+YzP1lj0pIPPOBTkEUgzd9v
ysgxtnfsWZykgly3nNxL0j8MmD3JEpvwW9y1qxhwL7lUqzzoCCZrvKJ9nJ6TUbOfdHX1a21F
7GZq9EYBlvsWPtRgi8bTaAsNw/QAAAAAAAA=

--------------ms010501070603040805010401--

