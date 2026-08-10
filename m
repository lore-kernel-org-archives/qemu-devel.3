Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46BAC5B567
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtVkH-0002EU-7H; Mon, 10 Aug 2026 15:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wtVkF-0002EC-8d
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:33:11 -0400
Received: from mail-northeuropeazon11020123.outbound.protection.outlook.com
 ([52.101.84.123] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wtVkD-0000i1-I7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 15:33:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3MAkt1WxuCalp+oIAywJ0fCtYUK7q3E89ZjOO4a2/XfwRuyF1T4pAEo5XeLWSvWmxLL1nbbRJL82aFhVr3Z/Gaq06YN8U7Qc1GLkiVyGd0tEGVvBJKbhWKLS29nYDGgt4XVDK+ka27OZ5Q1uZJ2xcyHWx2/J6Wa/2bgAmHCcOLlbJ7QaY+ywKn/rIznInmHJMs0l2R3FmRDgwIwqqRF/BzNkgDodqVHnjz7a4TMntbntsazwA0GDczP8x7eXWvThee6MIym7EfJLMLN6NnZ6QWNFGFfNr7wQorio+plg2HBqhWZHpx9G8yDFPRWsItlwRA0xUrmu3F1beEGUcPHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbDTGRjzvvAC8MxVSNmTvZn/qwOYFErBdVlUzXMLIJI=;
 b=OiBLCJApA56Y+pGlRXs7rl1UPR61YDkWyrfeEUZRYWl9wGpRPjOz8O4NfKTc61+E9AjMNiJx7mciFS/c/AI+uhti9rcCAasTP292JnpFcFoUMIZ/d+WJ/zzojsyKAq+zpuPjBEkRohVJuuOOfUqu+soLVZMMVmhN1TZpxgF8TZsukrafDl5z4HxHYGUa9/Sx0cPhQwXYO1g80qJlpG6m3Q1x0d2pgv2oneIYd90Ja/9036cd6QIBEWMoqAT7TFtNBMkfvRxMQ/cPIJT9WyUqwc5VXR+tdqAx1mjdROSonbrfr2BXw4CDKZoBmBA5hAAjKUf43pZJRNJ4Joql+n63hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbDTGRjzvvAC8MxVSNmTvZn/qwOYFErBdVlUzXMLIJI=;
 b=dSNYnpMdyKgXXDgwJxZIDbTIGGRae/g4cJ7bcphSc8/DwSb1qmYgJ08LGiuI0lus94nlLPWUs++tWi5S4Kq3K7OgL7LDWwlbXyNEE3MOJmWDGkRBEbP7SzCJqBLb32sst52v59Iv6RKy3TXOddbM9KHfDtB+AJRMrYgsMW9JNXq9Vr4/nIOqMvfLF17UvLCM0GUD9EkPteEeNT+4zge/fzfHwJwEaFi3roSeknxiITRYmtXGRc18sP1iWGCKISWzZvd8ljvMzUPClg1gKQkok6ruj2wE6t9W6/hRbdZrGuw/YD3/SxLZmJImnUVOrOxcRtC2ZdeGQ4SgdeW+y8nNyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB6620.eurprd08.prod.outlook.com (2603:10a6:10:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:28:03 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:28:03 +0000
Message-ID: <4388199e-a638-475f-b27f-9a0eb8941f3f@virtuozzo.com>
Date: Mon, 10 Aug 2026 21:28:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260731134046.1015479-1-den@openvz.org>
 <e8921043-2405-4b20-95f8-7cfc2d9bd8f9@redhat.com>
 <877bm3yg02.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <877bm3yg02.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0063.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: ad8e5678-edd9-43b1-7f29-08def7157f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10070799003|6133799003|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +XcYii0htgjZJp9+LVZR0Cv5A7NtsGiBYMOzPJVjaeKRskMh2JHXcPsobhnl/BXn366kKYEj+ghtCNN4yo5LdWqKZWKGkkmKrRl1w5s+HLrkbjx0yKMCX+T0yrDI3Q6DKov1x24kRbM/g8qZ1lVgS/nn3osOGUtWFgtPoS9CtiIylx1ZlhY2UE0zBV0yLFzgbzr8dBU/qmUV8Q3FLK3aIRAqfuJF/skIXkwHqjpL2/eLVdM0seCSZN/E+0ItB0kOQOLE4O0Rp9otibaNHFdw/efpP+WN5u5hu8NWXBJojbYuebUgjDJ0uTFegoonSoGy4JZm00lQOwHy4tDAJ/YqTAqNyRCiu9ev76/vmhnUBSnvrD+VeUmo50OXOMZSnWRF8KRkJuoIdBlHxVUSPjvsHnPRm8tE2bUThTSFJ0n4rqmIujB2t+ZP9pr8P95Rh9KlI+s4zHmT68XPOzX2lHhBmBBqvtC3pENN1li1aVJmgwPssuUI1ZhUEhq0fHpr7Xc+BnTa3SZIn+Usl6EmZ8auvagTdmp0x+ShKlsTUloNZqMvUhocVW7eBa1iUewBqGuqdhkBLLVtkoCkaq5kgAGrEkgTNBTBV1sr0I2SKE8dCYUh2G3CpcuSsh9BF2bi8VL41OTKqvmc6BpjiY0s6G/cRTeFET71E1ZiMlNGbkCC3Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10070799003)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllGOFJkdXZCaWJwbVlxTEdiL1k1YlBLRUZlY1poLzUzMDFkMjA0eW1URFln?=
 =?utf-8?B?OTRHdnJ2elVabUxIOXorT0VRRTNuTUx6OEpmMGtnS0VBNUQrdkozT2pPSzVV?=
 =?utf-8?B?ekZsaEJnS1NqOGpPSTVBdVhDR01lbkhpMjY4RjBGVFNUdGpaYjJBRk5HRlZV?=
 =?utf-8?B?UlBFQ3UrNVhQRVVyMjBFbThCZW12QnZnSW03UUZ1TnRtUGNMMStVYi84Znpv?=
 =?utf-8?B?bjNsMi9rcG5vVHB6aTh0MXlaWXJ3cjVxL21CKy9GZndBYWpKcTFRRXltOHZC?=
 =?utf-8?B?KzRGTDFHRi92eDdlUG5idVlqeGZBRFZ3M3JVTGh2RXg1bVF0OFlRRThiNGI2?=
 =?utf-8?B?Unl4bnVEelRiNnlTY08vUlE4OUJJWWJqSGRMVEpReCtPdEZXc2p3Y1VUTTZH?=
 =?utf-8?B?a2pUd3FnV3lWdWxGY2psTmxvaFNjUlgxQTk2WDRTZ2hKdnNLa2tOWllVQWZq?=
 =?utf-8?B?Sk5hMXc5TDhwSlZNdTd0VytJN1ZLRXRRVTk4YmVBcWFTNE43ck1VRGlNVTlq?=
 =?utf-8?B?cXJUQmg1TUdkdEJnU2g4bzFHWU9zUzVST1NXbHJOVzdDekxNMXhTVURSY0tK?=
 =?utf-8?B?SXBwYlBqWGVNc3BGOUl5aGxSbk5adlltS0RQR3VJcktDTmpvTGw2UGtWb0Fx?=
 =?utf-8?B?L0QyWCtzSkhoYUo5K1BjNU1ubnFiWEt4V2MvaW1ja1BhZG9WUVRsUjlEa2Uw?=
 =?utf-8?B?SUErSW5UVjlBSzZVbkpxN2JzVkRSd0NYMXR6azRZL1RiRVNCWW9Fa2lOeEsv?=
 =?utf-8?B?ZkNaeWhHMHdsa0M2b1R6UzlUaW85eXdHamYwejZrSzdCTVNnaVJnMENwSXJZ?=
 =?utf-8?B?TDBkQXNTYnVvMFNoNEpZREhXcDliZ2tHS2tMa1N2VndiOGxQYmtFRWVvOFhX?=
 =?utf-8?B?RDhPdytoWWJ1SUF0blYvUUdwbFp0cVZkYjVhejRtblZpVjRCZTU1V1UvN2FW?=
 =?utf-8?B?R3llaWpJNnNGa0g3NlhhdytsdnlLU09rdVc0REE4UEFMeEs1dDdwdXBQNUtP?=
 =?utf-8?B?cU9OQmdqN08vWFgvTnJxRllaQVB5SW1KWndyYk1YNThFNDZiWSt6VTZaRTlU?=
 =?utf-8?B?NlZGYkhHMVQya3FZR2pVUzA5SnFEREhmMlJLVWhWdUR4empZZGFOYjdxR2VP?=
 =?utf-8?B?MU5SMDJhSXdHZnJvVkhjckcrT1VRVG15V0dWRUY3am5hNGpaNGkzVUV6WTZS?=
 =?utf-8?B?TUhIeDZhZ29haVZvMkU2MitqcjlmTEJ2bm5oc0dpcEt5LzFDaFBiUHpHTnhh?=
 =?utf-8?B?RGhVcWFBSm0rdjBZSlluSXNFRlNHdjFWeFdSdVJ2Q2ZaNThvYS9ORWY3d21l?=
 =?utf-8?B?OTdhSUE2ZXlSU29HWXJ0TEViRWNpa3lmcEhhYmxsZ01iWDIxaDY1aHMxSzMr?=
 =?utf-8?B?dU5NSzlPbGtvM2d0eVNYaUVvVVNGWS9ISzBpdnUzejNWOEc4UnlwZmtobG40?=
 =?utf-8?B?WGNIQTNIKzdMYkRCTmMyNHBrdXVobkh3K0IrQTVGaDhQU0RkR3JVUFBQZjVw?=
 =?utf-8?B?TS81K3o1RURPTmRCYmRXMTlhOUYwTDI2QW9hbVZENEZFWDJoYVZ1TVJrSzdJ?=
 =?utf-8?B?QkRjN04vQ09XY3VNbG9XQmMrNXp4MEx1RUhzbXZ1U0p2aW9nSDRMQ0RkWUpq?=
 =?utf-8?B?RGFkSWJUWUxNRlQ2aTZTeDA2ZlpjZThlNWNaWkhXSWtnUHE5dVcwMS9yNC96?=
 =?utf-8?B?czFBWllZVUMvQjVLaktOV3RLK0pvODVKT1JwM1FuSDVLV0kwSFQ4Q2tuVjJI?=
 =?utf-8?B?VHpRQ0tpcm9IOG9zMWhuTHFnUjA2WFUyNlFJRC9TRVUzRjIyS0xzUnAxUFdu?=
 =?utf-8?B?dnhibGNybnpYclJjSTB3Y29NbFBkbUVtV3YyZkRnWHp1dDFzUDdGRVFGRWxQ?=
 =?utf-8?B?SmJocnJOdjBCc2pYSXhteUtNWFBDeGZ4bXE5aGVDbnZvb09iWlJxdkVIajRp?=
 =?utf-8?B?NkxzUDVaenlwR1BZeDlrQXhWOElxdUpOUjJjRGxoZ2FuT0M5Wm12R0Rvbzd2?=
 =?utf-8?B?dFpGeWJQazk1WTdWN0xaQ3dPbkQ0bW92TUg1aG1YM2lBWHJnN3JTK2xTUHdL?=
 =?utf-8?B?N1dvR2RKUW1KazM3bCt1WGJrV2N2TEZhUXVCemI3V0RwV25yYXVNdGNhL0Z5?=
 =?utf-8?B?WDgzSGQzMzN5cFpPTVdIUzcyTWtuV0s4YTNadThnRThmMnJHTnhsV3pPbThV?=
 =?utf-8?B?a1o4MTBRa1c3TzAxM1lZZHZacEZxcWRpQlQyaVplYW4vdnZMMlk0Nk1wTVFy?=
 =?utf-8?B?RUpzQ3VXOEswZk1iYVBjSlZxYXJ2MzBjMC9RSmdhOWxYREV4UHpGZHdkaDdW?=
 =?utf-8?B?THFreFAyK2NzZmlCaWU1T2lPNml6RFUxU0hVM25FYklXYktSZVNEdjA1bFJ0?=
 =?utf-8?Q?kzeI2W7nlAJKiBflSuSDtvftr9Lmu+sw73Wvpmjh9qLr0?=
X-MS-Exchange-AntiSpam-MessageData-1: w9L+hNAfDrj76A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8e5678-edd9-43b1-7f29-08def7157f2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:28:03.4694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gvqlFx7Agp1uWKbvG4ctlS+3x0AZZzK28BUDDAWRr89mebipA4uExkmabUPl7rBoOicfWzLTZVOEmhYDSEa0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6620
Received-SPF: pass client-ip=52.101.84.123; envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 8/6/26 07:28, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>
>> On 31/07/2026 15.40, Denis V. Lunev wrote:
>>> Patches sometimes carry a hunk whose entire content is one or two
>>> added blank lines. It changes nothing, it makes the diff longer and
>>> it survives review because nobody looks twice at a blank line. The
>>> blank line itself is perfectly fine, the gratuitous hunk is not.
>> Well, I wouldn't say that the blank line itself is fine. It depends.
>> In source code, there normally should not be more than one empty line between code blocks, that's why I complained to the patch in your pull request.
> For what it's worth, Python style *demands* two blank lines in places.
> Here's what happens when I delete one of them:
>
>     $ pycodestyle scripts/qapi/parser.py 
>     scripts/qapi/parser.py:656:1: E302 expected 2 blank lines, found 1
>
> Why?  PEP 8 "Style Guide for Python Code" section "Blank Lines":
>
> --> Surround top-level function and class definitions with two blank
> --> lines.
>
>     Method definitions inside a class are surrounded by a single blank
>     line.
>
>     Extra blank lines may be used (sparingly) to separate groups of
>     related functions. Blank lines may be omitted between a bunch of
>     related one-liners (e.g. a set of dummy implementations).
>
>     Use blank lines in functions, sparingly, to indicate logical
>     sections.
>
>     Python accepts the control-L (i.e. ^L) form feed character as
>     whitespace; many tools treat these characters as page separators, so
>     you may use them to separate pages of related sections of your
>     file. Note, some editors and web-based code viewers may not
>     recognize control-L as a form feed and will show another glyph in
>     its place.
>
> We run pycodestyle via flake8 from python/tests/linters.py.  Still not
> part of "make check".
>
> [...]
>
That is actually the difference in between what is done in
the kernel and here.

There are 3 main notes:
* kernel check is not running always, it is hidden under
  --strict-only
* kernel check is not executed over Python
* kernel check catches consecutive blank lines

Here my check is different - I am trying to catch junk
hunk, which was missed with manual eye review - just
blank line. Such hunks at my opinion are absolutely
useless and that is worth to flag.

Thus kernel style check would be complementary to my
one and they are orthogonal.

I propose to stay with this version. Anyway, if you
prefer, I could port Linux one. We could try to make
voting :-)

Thank you in advance,
    Den 

