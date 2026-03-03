Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89003EC0489
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMf5-0000tt-CL; Tue, 03 Mar 2026 05:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxMf3-0000tV-Ji
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:07:29 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxMf1-00058H-40
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaRFpE7ZUMGIOyCzvyLJRnHDc09ZYlyWZ+VbST1FAiR/AflPhz7Q7wxUe1bBcbz8JvrsdC9cnpTzNlA7pa4oveNEP36bjHKrsEWmUfEYqIkAyijfUU+xxrTOBT+NqufAkh5EieJfCvQaUhMLKFbMdf05ERAQIv7WEs79HR1qJP4ZeguYVOtMrBK4ptHFpMFnpXKIX4qIIMS5cvHsDYIm1Nchpmh3FDsN3SAqRpEYHzoyoA1x5CQHffGCa701SSDMJ4GOFNfsxzC0/IHRebIBeh68IC6Blt1A8s1OUa2qaiBjyE2EJaJ4M9Mup0OzwqnEBbKP6ueeE0PiDXo67OIZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U2TJy6wnNRVSc+84RiLaUyqqp5oEUg3VmZg/0C/Q18=;
 b=PasESAjOa7aBUTmfkLg8AFcBfJLOuCo8kvOO3Lz1f3smNGrTzVpuPK3PBZ7eu51mmQMSdD94l25HPmYkhVg48zDb5oWXKpz3ZgrzVJjU+jwXU+OLtDAE+6pMpP/fGnaWG5IXvUCLLJ/bhEnOSVdhnl4kzNKK0mQSveahtthzjES4BsQupmCzI9/zXWhSPcHHprhqJY9flcpeQG9N0co9JlrGFdms84ZZ8Fo1zN9P4xid6sN9WffnhV8HU2ysVrKiJdwX7kMRCxnhGpf7cgQf7GGI9lpXUDB9n1jzZBTfbJ+YWNLTf5BHgWDartrBf/gn+HPxmyOkgqghEbz5lNTQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U2TJy6wnNRVSc+84RiLaUyqqp5oEUg3VmZg/0C/Q18=;
 b=dl4gxyEquTiCi9zLInwJpivJsWAuR3ODobEXpoLZzIvF6v0VAAuVdz7PNuc5euTr/LpBny3ttJSAo+NeruUo4mg7aGpLehSlp0e36qgHoxExfs0I8blA958BX0COYDeWiKz8nOSEa0EHFpG3zBKJdeHv3+7tgeGLRiMCrHvIFfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by ZR4P278MB1902.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:07:20 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 10:07:20 +0000
Message-ID: <ce239ef4-c87f-431e-a082-34d4a1ecbf41@epfl.ch>
Date: Tue, 3 Mar 2026 11:07:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
 <11fbe855-37cb-4703-b143-66563b881a4e@epfl.ch>
 <b88345b8-5561-4b09-b42d-dafafd798217@epfl.ch>
 <a84d40f6-0466-4744-95e6-5a1f8743c2b4@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <a84d40f6-0466-4744-95e6-5a1f8743c2b4@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms040605000501020709040303"
X-ClientProxiedBy: GV0P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::9) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|ZR4P278MB1902:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b88f93-76db-4a9b-7913-08de790ca85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: xa8l0Bk1O9Nd5Wr4EKMyuoCfpw67wGL1JGUGU2rHZnUJinfeH31rBDS2OESpHypBvcAUw97ysOHHVXarb/MIbJaqKsP0Ve/lTERyE2L5Ml7V9HiG5cQ12WxlZmzwJHf+TBAatay2Gpxx3XukWIwHGJ8U3SvRYwpa1+GsvlND4aVtiQXB9aVm6Ge/wJgqne84Z++e+rwGFifzcfUmm57NjKgEHFVoOEFCHsORzacCgXCjwCWhdosKuOnVZc9ky6rTWAU/1R4E5XCUF2eemhEprkbhMd4rHW6d6TGJf2MvhiyYTl4DYwjys19njcw49SsrNMQKeItyRHY/QJK3fLqEZuur2q1eDdQVqXnvzy1GD4fDyR1d0BfCaDvd0Lwrbt3FFfTcqVaAdW+dyQVVmOqEbEMLWnBJiO8omIl1D3kkHXmLNZFg99gv//gVswYD4vzneOPhwgzFRW8pJV4ppVKsMc76+UaleHC6+AW8ohUeVU2sv5IkiwrWUOJrmgPlCQKMhr6AkVaR2LWNI7bDagl7iYRpJHvP5+dtskZK216PUdfHO43vgvoO2juM/Abb6b0xkMJZpJLxkYUo2MvZJiB+TPanP9OoCQDE//mHLsnj4Oz08jKGHuFQ7k+LM29a6h+rPoAvW2qXGHcx5XovrJVvNhOs3T9/cVIyEW5tOZDFEFuPe7bCRZGRmp8r2R0zQ1bOcbdR8ul7zgeilgwXVNeGegpwuwIcrsUdv+cv+DN66GA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThCcGc4YWYrTXU0VHNJSzNDZ0d3MDBZQlJrSlV6R0dsZ0swellpWUhocHJx?=
 =?utf-8?B?eDRoMG9XbFp5NjhLQXpsY2E4U0Z3aEMvNHJoaUVrY09lVUh2T092QW5rNFAy?=
 =?utf-8?B?RlAwNHZMVnU4dFdIYmhtTHVTNmNsVWkwekFOOWVjT2h4blpnWkRoOGFvWG94?=
 =?utf-8?B?aDdIWFFwUVNaWmJTdU1ibk9hYUFqTk51eG1ydTNQdC9SZE85bmRheFpUdmVJ?=
 =?utf-8?B?ME5lWDlxbU44ZFFjZkhpMWNYRG5WbFJLQlNKQXdzNXZHTlhIdDlwMUdtbUkv?=
 =?utf-8?B?anJLZlZHT3RqUFQ5OVovLzVQRGxkNjJhd0lPM2E4eXI2djE0VFlUYktYNlV1?=
 =?utf-8?B?MGg0blF6Y1lLdkFuTkhuYWcrWDdiQTh6c3h3UGtHOHlRVUNlU3kxSkFkandm?=
 =?utf-8?B?RlJ3bXZybVFRWlhOMFZkRmdLZHNwUWU1T1Y0eWxSejVWQmh6a0lFbzFZWXR5?=
 =?utf-8?B?OGdBU0lLL3RvTWlJbzArNmZjbXZZdlAxTjRqdUtUYXg3dWowMnZ6emZwZHk4?=
 =?utf-8?B?VnFSc2dkM1NQYmNEbjZlenRTRkE3OWNsWXNyZ1habExFaTM1VEUzTjJwbHZM?=
 =?utf-8?B?YjZmdzdMS3BZSCtSRkVaVUpOMWl5a0JuaXQ1OEwwU1NRQ3hZVWY5VVZkNzdK?=
 =?utf-8?B?TmZEZFBuQXZieGJVTHMrUVExWUYyUkF2cUtmM0x1L1pXMm9vdjF6M2kyVm5F?=
 =?utf-8?B?eThiSXRNY2lvcElaeTBIV1FFaTlmeEZad3Z2a0VqdFdUcW5aeUxHSkh6b0E4?=
 =?utf-8?B?ZWpsUTg2bHdQV3BRYXRyMFc2VFNmUHpzVW1RZ3JoWS9MSXBRVUFDR3YwcVpP?=
 =?utf-8?B?d3RNZlNmMks0WUVMSWZIblFZVHA1QnZ4N0hSdmVYK0Q1TVExSnZQTlNJUUgx?=
 =?utf-8?B?OWV6by9ZL0xkRktZWWtvcFM0SlVnanl3QzhrZmRRZXA4U0oxM21XKzRFT0pM?=
 =?utf-8?B?Tmh1T1BxY3FFMXZxdUk5KzdCSDVmRnA3M3JnSTV4QTBTWWk5K3hvcHNUbUFo?=
 =?utf-8?B?czh0dTVUTjdSbTR0aDJpbU9YUjZyTDBLbFVHbzlLbkJUYisyZ092a25nN3dR?=
 =?utf-8?B?SHltcXdRSFp2TWF0Qkt1MHpxZTBFY0sxWWRxdjZzbkZkVW1ZUnB1UmtXY0I2?=
 =?utf-8?B?T0taSmRqc3h2eHVIT1Q5Q0l2VFc2cW1sMGRVQ2haeG5teVhFZzFnaENWcjRN?=
 =?utf-8?B?MEpoM25VS2dOT2F0RHRTQ3pPbkI3L00zMHRVaTdkSXpDdUx2Mll6RGlycTl1?=
 =?utf-8?B?RFBST3RNc3JyVGp2OVY4N0Y3K1VxM1NBS0c2Y1ZUU1MxSmNNNk4ycllhRnAy?=
 =?utf-8?B?cnI2WXE4WkJTMTBTZjl6YWJzK0k0SktDeFB4clF4a2dwbHdpak1EMldBZnFK?=
 =?utf-8?B?MDBZYVN0ZjdwOXdZRWhuU1Z6TG5QN2R6ZjRONXpRWGVtaEhxQ1JKQmMvMUs0?=
 =?utf-8?B?S1pMWTZ2MTJlQ21xUzk4RGZwNkxvSGZaSmh4QlRlT0gxb1M3T0lZUSsvTEtV?=
 =?utf-8?B?dUphbXJuTktVd3VHSkh4VGJGcFRJNTVjeVVSRlBlVEpMd1ByRGR3Yk0xRG1n?=
 =?utf-8?B?TkJCRjhJcUhoT0NmcytmampVTDhvbFdUSUxJMVd4MzI0eUVFOVdRMnQ0ZEpM?=
 =?utf-8?B?eWhRSWVabU5ITlkxcWVlb2paMW1hcTB0MlNtMHFZOFB5d05YSHRKMFA1cENI?=
 =?utf-8?B?QzVFK29FOG94YUg4QnpPM2ZxMGE1dGlUUlQvMUt2TFd2U20vZ3EwaXZQZ3Qy?=
 =?utf-8?B?MEI0TlQ1N3ljMmtEUjdXZ0tEOWtzcWsvbHlhR0FUaERtUkRIRTJFT0E0bFF3?=
 =?utf-8?B?N0xTRFBVTW11SkJJaWZNNVlOdzB0TXFYWjJHeHRmdjJldnFZTkltREVjeGsv?=
 =?utf-8?B?cjdablJON2VRWVk0WEoxT24vZUNBQk9VMVNLMkJ6Uml6MEE0T2g0UkVBN1E3?=
 =?utf-8?B?dTVqdGs4bGFKWDYxZ3R4aGd4NmsyRVZoKzE2WWplYmg2WmVjRXFzTFpFKzdo?=
 =?utf-8?B?WEFielJjV3pIaVhDZlZUc25BdWxKVytEMDJzaXVZM3JKR3FhVDJHeHhmTDdU?=
 =?utf-8?B?M0ErRXhoYWJqQ3BQeEtvOHVpa1lyc1pKNXVrL2FUTXhsNXZEd2wwVDVBaDZY?=
 =?utf-8?B?ZnpuUHZyU1ZxWE4wLzhzK1RNNGg2dkdiR1FVeGdJemZwZkZBOXJkKy9iaDZj?=
 =?utf-8?B?d09pd1dCdVcybVNSYlo0bFFOeldWWXExeVY1OWhsVlJoVXl5RnhBNStRK1Ro?=
 =?utf-8?B?bVlQUlhISVdHR20rWXNPU2RxQXU1SDd6L1IrYUNMMmQ2ZEJ6bW5aMzVyMUd2?=
 =?utf-8?B?R0t4dVpONVgrVnRsUzgzQkVNR1BrZ25TeW5ualdsSWV1b2RDcFdKdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b88f93-76db-4a9b-7913-08de790ca85e
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:07:20.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siQbKyXDE7py7N5b6Z8ay9yyJe85nGow0tXRfUGiPkYyLdjlvKsrCRbKoLIqslL36Zho6agsWbjtnD3n166VXAV6eE5D/Ua7i+oBORuBT/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1902
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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

--------------ms040605000501020709040303
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2026 19:02, Pierrick Bouvier wrote:
> On 3/2/26 6:58 AM, Florian Hofhammer wrote:
>> On 02/03/2026 14:59, Florian Hofhammer wrote:
>>> The test executes a non-existent syscall, which the syscall plugin
>>> intercepts and redirects to a clean exit.
>>> Due to architecture-specific quirks, the architecture-specific Makefi=
les
>>> require setting specific compiler and linker flags in some cases.
>>
>> Please disregard this patch and use the other version I just sent, I
>> forgot to update the commit message for this one. My apologies for tha=
t!
>>
>=20
> Hi Florian, no worries.
>=20
> What is the other version you sent?
> Feel free to send a v6 for the series if needed, it's more clear than f=
ix on individual commits.

Ack, going to send a v6.

>=20
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   MAINTAINERS                                   |   1 +
>>>   tests/tcg/arm/Makefile.target                 |   6 +
>>>   tests/tcg/multiarch/Makefile.target           |  17 ++-
>>>   .../{ =3D> plugin}/check-plugin-output.sh       |   0
>>>   .../{ =3D> plugin}/test-plugin-mem-access.c     |   0
>>>   .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 +++++++++++++++=
+++
>>>   tests/tcg/plugins/meson.build                 |   1 +
>>>   tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++=

>>>   8 files changed, 282 insertions(+), 3 deletions(-)
>>>   rename tests/tcg/multiarch/{ =3D> plugin}/check-plugin-output.sh (1=
00%)
>>>   rename tests/tcg/multiarch/{ =3D> plugin}/test-plugin-mem-access.c =
(100%)
>>>   create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
>>>   create mode 100644 tests/tcg/plugins/setpc.c
>>>

Best regards,
Florian

--------------ms040605000501020709040303
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMwMzEwMDcxOVowLwYJKoZI
hvcNAQkEMSIEINrf1sUJrJIVAY2p+h+dKe5uqJnwo6CD0Nl0OAoXiBDVMIGFBgkrBgEEAYI3
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
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBANa5m7QMsa0WYpVp2q4qgvpCxG+5
Z5b6apCks5hFZFWFzOmqWZ3zsqcl08ilPs2t4glwHMrUB9nm4mVTgnoaZIr1jOIhvNZm50iP
qrN2ekH9M7OXmN7MoPrka14M1HrZ31/EYHz/X7wE5ZIQDZscpXwn1mOzG+Al6HssTCsvvRq9
601rqRA5Zr4G5BGB7ZmJJWXnKnQ+4bG4Q/HhTcSkOQ+uO4opAAJKGT8hDHGw8bYWKplwm34q
1ymVLY8cO22zpKeY1AYbybPvzhyjcufQMQMbba7aNmYO/q3jtXxPDaPbDkA7+fWDgC4KgTEL
EirRCOqhIvU3Jszd/rqivSITQ/8AAAAAAAA=

--------------ms040605000501020709040303--

