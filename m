Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D580C7882B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 13:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRfd-0007no-Eh; Wed, 25 Sep 2024 09:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1stRfa-0007eQ-Da
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:03:02 -0400
Received: from mail-me3aus01olkn2055.outbound.protection.outlook.com
 ([40.92.63.55] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1stRfY-0000CC-4j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 09:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Glrim9zZODXqDCYlH2RmbVTjcHyGl9IWrGEJ8qkk0gW8l29jWaYAMflBliv1qJyJhROePhvTBLyB5eRWF6yYJpRNiFhTCUiN+q7kcQ1h7Uw1ow1vEhVn1k/ScWuzFRGj34lEBHYAfQ8Im2qIaTFN5efoxuoJaxUrJ0BjARvTRsYI7jGz2nOMgUtSQSF3pVuA1CZxlsBUrStaG6onz6KKIzkxml1vYHNMrQfxNgQxwWe+xSwRI1FvOzJqzZE8AwIlRuysoH/o6PpRq+x+pYCxmDTwNb3PDYmKAF4vapGgPRadsKQolfHhDpNunTAyF8A0JX8hoM8O9mwF8sjtH6RV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80N19+LJCOxoQ+/2B5eyuh0jkdQyP3tSAPCxt/rmhoQ=;
 b=HAF+VcD/1NypK9egB2E24orILMpcQ8LWaKbegqivvTKa4CLERynUY0ntvVbCxrLb9/W5tNpp+lj0wHVbYhJsZ76kZZ6Y98eWWfDDt8G3unVh4bkBqul5npF3g3UI7SlyrUP96errEmrAMfR2Lw14PWUH1gcKOxzC6GBL0RjmoX6JvRMVd/SLwS8ck4xo05g4sNWc9Q+XJLfMpr2sZLqs/KfZQ4ijmnmJd/adth8U7Xs6LZnuquYiUQs1RHwSN/Wd5vB9inxZOTe6baMKZ+Ka+94rPv/uiUFQuzIo73vTJNF/CAM96MgEpqG8wTSVLz2/Md88loJUKgKACA4RtoBEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80N19+LJCOxoQ+/2B5eyuh0jkdQyP3tSAPCxt/rmhoQ=;
 b=sMt9H4pxU4mFjSI5yDuk/dERdylg0ej6NHO87jAwzRCjPeUl8oNjCo7qJfObjBNssZEFRtTp+0/BP/ob7euzsaMQY9KgXnWozC1yfOJLz0JFju0jSxbW07DMWje7KgaWMwNXNizbjKP32kffmRk+QPSxtrIt7JPjV0m3FrafP+KVlRYWbFc8q5QQwFBQ9DHE9Of4qE7ddojPNnTtaEBFpyCcFnCDJMna4nIIcxEKjpVS+9RDEIePx/jfFyY4qPiWsne3TyUtiT17coBKav4vHIc+LrIuWUnlwALVjrvZrgEGhJgw/rZh2A5/Ob8zyigadIZQ8kMc9B2HpCY1pxzkxQ==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by ME0P300MB0602.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 12:57:46 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 12:57:46 +0000
References: <20240924011156.48252-1-gaoshiyuan@baidu.com>
 <8d7b35ba-f9fa-446f-ac8b-471587c7666e@redhat.com>
 <8878123399e34a90bbac9a618be5c674@baidu.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: "Gao,Shiyuan" <gaoshiyuan@baidu.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Zuo,Boqun" <zuoboqun@baidu.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "alxndr@bu.edu" <alxndr@bu.edu>, "peterx@redhat.com" <peterx@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Date: Wed, 25 Sep 2024 20:07:39 +0800
In-reply-to: <8878123399e34a90bbac9a618be5c674@baidu.com>
Message-ID: <SY0P300MB1026126D4A2CD39D81F0DF9995692@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: KL1PR01CA0084.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::24) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87y13fzy9v.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|ME0P300MB0602:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f673d6-ff4e-4701-1123-08dcdd61a6c0
X-MS-Exchange-SLBlob-MailProps: RlF2DIMZ1qW18tu+T3uNUJ+nUgEM8mP7jxQb9gfrlXwnMgY3YATni+OcXXjIYb1TrdXyqkobRRiLSQh+EDiW7hx/eEkKxBvujDk8Os4q6MoBnOx21DLV+RNP7qYW3tATHmw/TmsM1m42ob1g6g1HxArxOuIpD4aNwzCl6XIhAEhZvBnpMvRXnrlXcbSDftQ+IDL38ZaLsmD/8H/9fqV/0Tp9lW78ViV9kxNVMBU7LL+c9X036LgRAwzdCdk+KU022Dy4VQWX+KefUubOcOcSj8FoSxZ03q32FeqivCC5u8RYdcuHsvBzUH1Zf6aCkZV9Yl/KnTEm92V7mKzEIVf5ZKLgAUffeph5jivKKOa86N8x+cu1oEglnfNPey8z7Lk8CU/Dps5AArLkLcmIueRsyWPeaa0KXF554UjswM1KNl0ll8cQkHaPnrEtV6IUXemD8HHuYGmy8o4TJmmln/KvxtQFLOR84RjAwt4i+dmPsmZ98fH79y9AHVQcdNaQ+a3/jm11xXEMIyqD2pq1ob4no21ojPXRS4Cef/Tn15SFobNhdghCPc7CmNw7W/igofWFyrg4xYDuTiHFTpG18HYYvys8dkQtyYzMXfgzWmagoFPHtG2wwSc6xWPjqrZoBS8G7+b7ehP2VCtKNUt7v9EcSaYhKOg0QgVKOKYEojzNpmWLoo6NCwJDcq2RyRj6iYwqv98G8JGd/kkP19/Oifx1TX240Kv/df//IEKPP2cMq38p/BaHKAHmTSRdr/Zw2G7DxDBvqPcaXhCQ5CfW2d1cDlxQnyCGeYzirPoAsSK4lvqIaNqnjpIZXChkABtWPvofPaSk6Ml7U0RHAAPpPJZIXH719wS6btuG
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|7092599003|461199028|5072599009|6090799003|15080799006|19110799003|3412199025|4302099013|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVVISXlkNEF2bktsZjVacFJKRVFiMGgwM1pvTWh6K3BlL3BzNjNuSlAwQUVH?=
 =?utf-8?B?QUxzSzZUY3NrSldCQWVxSlpMK1pqS3dzVWo3TlB5UmJEb295Zm4rZS9rR2Nu?=
 =?utf-8?B?T3REZ0JYVXdHU0JKMzZocmNTRWVnQWVoWGVxVHV4Y3BOTVp1N1oxYkxoenNV?=
 =?utf-8?B?U3dWYWtyMnNZajFVSnlPbUFjTmN4bFVuNWR4a1k3c1Zud1krMUI4TzZsaTI2?=
 =?utf-8?B?Zm5IYlEwd1FGaTd3REFvRkNRVXB6dnJwMkh4SThTdlE5L2E3cmh2WTdYeDR2?=
 =?utf-8?B?UTVuY21jaDh0bm4xZHkzNzNWdVhtcDAyQzF4Y3FvZ2daaVljSUN6RTJxSHZB?=
 =?utf-8?B?Zm9nN0pJZlZwWUtoQTVYVjJIZnlXSm55ZDE3aFlqWWNZOFo1ZWxnSXNZVzJy?=
 =?utf-8?B?MUg3elhsUWRBakFqUGxaSUZvZjhyS25XaGdVNmwyZGtSYXJ0UVpXUit2alBn?=
 =?utf-8?B?UjRDYUpuWnJjcHFMbyt5eVhjOEFIYXRhcmVNa21rN2RyUUpWVG5GeDBFY0lM?=
 =?utf-8?B?a05ram1MMk5tYThuZEw2NFhHczFESTMzaGQ2VDNVOWRURHFCYUp6TC82clV3?=
 =?utf-8?B?Y1BLUnIrSTZ3VmlaVkcrVGV1Q2phNmczWnpwQTFiajJ1MU1FWkVOakQ5SXdG?=
 =?utf-8?B?U25pcjJDa2IyL1VnSTg3MkJ1dURaSitmRDJ6QmVMbU5XQVYveExOY3UxaTNO?=
 =?utf-8?B?bm5CRnlVVmp1QWNZalJLOWVpK04vU09TbjFScG5XTFVYdmlFYlVLMk5tS3R3?=
 =?utf-8?B?QUZSN1Y2RVpUTW13b0ZtWGpHa2VReUF0Qnk2NXFqWWUrQmRvbHhwMkk1cmZ1?=
 =?utf-8?B?MnEvRDBXOW5WR1VXV0lzTVNnN1NHaVE3bFM0VjVkQ29WM3hkb01aVnFVL1cy?=
 =?utf-8?B?Y2hXQ0hmVXdwOU1aYU10S0E2TlhEQTZlZmZJSE5SRnhoMTVkQlZ2RlUycUFK?=
 =?utf-8?B?Zks0a0lrcmVoenBmcGk3ZW9ObFBzNnF4WWJXQS9OdlBlZ0lDb3pzNXErTmNa?=
 =?utf-8?B?TDF5QTNHbDMwdmJSM1h4MU96aXBDUmdVOHVyTm9POGFKd2diajdjblJYZFZY?=
 =?utf-8?B?TStDN0JaNHZQdmdWcncwQ3hkZ25yei9mQVRSZkhWZmxJRkhKVXY4RGNyVnVx?=
 =?utf-8?B?Rkh1b1RFRUwza1J1SGZhclVCUlVLTmdGNVF2YmVLM1FacHNGSHJLa09QZUZL?=
 =?utf-8?B?Qk8xYjU4NnhqMkNhdFVYT1VIcm03c3AvWUY3OUJ3RE1lRVV5WUxiWC9pVC92?=
 =?utf-8?B?WldhWTZCWnVDeTAxOFhwZlZCRGRNSjFaTzJqeU1haVpaS0MxQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2Z2YmxialRIZklYMXdNVmw1aFRiQklTT0d6Umx4VmdLc1FEQ21WeTdTTngr?=
 =?utf-8?B?WkxEY3NNWWZmZDJDNFdybGJxN3RoQnNzRzUzUi9YcTdZVVJER3Bzb3lBK21M?=
 =?utf-8?B?QnhuOVRPc2E5dUdGTnF0eUg5OUw5WE9zL1BJSXVCYTJZclhlTnM1U1hVcnVO?=
 =?utf-8?B?bmdBS2tJZnhvNnlYNDhPVTJKdXlNcW1rVDZQL1UwSm1ac1A3V2d6OHFkSTZz?=
 =?utf-8?B?V3BjaTNDNXhJY0h5K1JyVHpQN1d3dDU4YUVRZjNDVnVlOVJxWXFGaEY3VG1N?=
 =?utf-8?B?UmhTRmVKZVlZenVYb3lHMVBQQjRFTXNIeXRrbU1GRGI2ZHl6eHcrOWhwS09m?=
 =?utf-8?B?aHZ0U0xKUXgrMXA2eEgxbXNrV0QzcFNtYWxPUVNmOGo2bHl2YzEyc0pqSWQ0?=
 =?utf-8?B?bjFxdmFmZ2ordFBpSlNBeTlXaWQ0ajJaVWRpQXJzclRWMFpoNGdmVVV2Wmd2?=
 =?utf-8?B?eitxWDFzZjZ4WTVYbG9MVGZMSnpLdzY2bjNxN3dCYUpFTEl3RU9sT2kvbGVT?=
 =?utf-8?B?MnV4TkZTTlBYM2J1T1RTMTdtdGsvN01ZWUdaRmxsak03dXh6NmRBMm5IVEZq?=
 =?utf-8?B?K011NFBsMFNrZm0rUnRPWWszcmZnSnYwUzY4L2pTOHJHaFFXQ3hxeGtXeTJh?=
 =?utf-8?B?VGRTVFBhaUtwUXI0bTRwZ0ZqdTdGMFZVYW5UNmJ2ZStPRE1mbksyUW1MWlJt?=
 =?utf-8?B?TDdqWmJ0LzZZaEI4eWluMmdWZ242bEtReGE0eTRiYW1CbFRaalJ5aGU5SGNB?=
 =?utf-8?B?anc0MGljU1lMalBySWtKNWxyS0d4TnF6Tk5jOFMvUkJENXJHVmRoNTN2T2NE?=
 =?utf-8?B?cE9zSXVULzEvVW4wMjlnS0xIQ3VxOTNYQVAvenVncHcrdGdlK214UmFtQ1BP?=
 =?utf-8?B?U3N0c0gyNmRUTzA2Rkh3QUpNR1V6RkZ0TW9ZMXY5a1h0WWlseDVCK1BVdis0?=
 =?utf-8?B?YjdOWWdpMnlHVTdhQnZNRFZCK2JZeis4RWxkcnU2WnNUbW84OTdFWGxzUjdh?=
 =?utf-8?B?R3dOVVkvT2lobnZhalMyV2lwWUJBK3Vic3hOMVk2Q3cwTkFPVE1kVW8yQnZU?=
 =?utf-8?B?blZ0d3ZMR25WZG9VdUxNaWk4NCsvTWdSSTVFeUlyZjhtZEZBWWN1cHo0Wm03?=
 =?utf-8?B?cFJlWUE3a0Z6eUg4Tm9WUTNHd2Rjb3NjaUhwV29xREIwdXVGWmYvVFJ5NWVq?=
 =?utf-8?B?TXY0S05Ea0VXRXJrVmlRN29Fa0xiTHJwSys0c0NkZnl2RldMNGtRUWFhRVVk?=
 =?utf-8?B?Vi9MRlQwNUhrS2NxazJ5S3ZSL1lJQ2lzaXhpWnY5VkVWd0ZQakpoYnRZNy9l?=
 =?utf-8?B?R09QRFp5eEVycEtFQ3JsVTZHTDlxRnNNQ2gvZExHZ3lhbTAyZitUUUdkaWto?=
 =?utf-8?B?ejAwZDhSRUZ4N1ZwbFo5YVJrcmFCL0l4d2FrUGdiZDl2T0VOU3BHVGQzQ3Bs?=
 =?utf-8?B?b3RDNklDaCtBVVpOSS9LS2dsUmRmSExGTWpBRnp4My80ZTlidGF1YmhtcW5z?=
 =?utf-8?B?ZTBpdGNLVVUrblBSd1F3ZHQ4ZGYrZXlDaEVHcUhJQ2ZrNVp5RVhrSExoQlAy?=
 =?utf-8?B?NkZWU1pqSy9XeTVPc3cycFFGZTZzempRY2cvb2lqdDBUemljc3pML1FjVGJR?=
 =?utf-8?Q?fWkxG9fr5QbvQQwRkciIrY/X3B4FDcsyucvdiLUfd8RU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f673d6-ff4e-4701-1123-08dcdd61a6c0
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 12:57:46.2903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0602
Received-SPF: pass client-ip=40.92.63.55; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


"Gao,Shiyuan" via <qemu-devel@nongnu.org> writes:
>> >
>> > Introduce the virtio-pci and pci_bridge_pci address spaces to solve th=
is problem.
>> >
>> > Before:
>> > memory-region: pci_bridge_pci
>> >=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): pci=
_bridge_pci
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200000-00000000fe200fff (prio =
1, i/o): virtio-blk-pci-msix
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200000-00000000fe2=
0016f (prio 0, i/o): msix-table
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200800-00000000fe2=
00807 (prio 0, i/o): msix-pba
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000400000-000000a000403fff (prio =
1, i/o): virtio-pci
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000400000-000000a0004=
00fff (prio 0, i/o): virtio-pci-common-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000401000-000000a0004=
01fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000402000-000000a0004=
02fff (prio 0, i/o): virtio-pci-device-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000403000-000000a0004=
03fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>> >
>> > After:
>> > address-space: pci_bridge_pci
>> >=C2=A0=C2=A0=C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): pci=
_bridge_pci
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200000-00000000fe200fff (prio =
1, i/o): virtio-blk-pci-msix
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200000-00000000fe2=
0016f (prio 0, i/o): msix-table
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000fe200800-00000000fe2=
00807 (prio 0, i/o): msix-pba
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000400000-000000a000403fff (prio =
1, i/o): virtio-pci
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000400000-000000a0004=
00fff (prio 0, i/o): virtio-pci-common-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000401000-000000a0004=
01fff (prio 0, i/o): virtio-pci-isr-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000402000-000000a0004=
02fff (prio 0, i/o): virtio-pci-device-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000403000-000000a0004=
03fff (prio 0, i/o): virtio-pci-notify-virtio-blk
>> >
>> > address-space: virtio-pci
>> >=C2=A0=C2=A0=C2=A0 000000a000400000-000000a000403fff (prio 1, i/o): vir=
tio-pci
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000400000-000000a000400fff (prio =
0, i/o): virtio-pci-common-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000401000-000000a000401fff (prio =
0, i/o): virtio-pci-isr-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000402000-000000a000402fff (prio =
0, i/o): virtio-pci-device-virtio-blk
>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000000a000403000-000000a000403fff (prio =
0, i/o): virtio-pci-notify-virtio-blk
>> >
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
>> > Fixes: ffa8a3e ("virtio-pci: Add lookup subregion of VirtIOPCIRegion M=
R")
>>
>> Commit id is not unique. Use 12 digits please.
>
> Thanks, I will make changes in the next version.
>
>>
>> I'm still not quite sure if memory_region_find() is really the right
>> thing to use here, but I'm no expert on that so I'm hoping virtio/PCI
>> people can review.
>>
>
> Directly traversing the subregions of VirtIOPCIRegion's MR is a relativel=
y
> simple method(Now only notify region MR has subregion and only has one la=
yer).
>
> But if want to be more general, we need to consider multiple layers and
> the priority of subregions, which adds complexity.
>
> I think it would be better to use memory_region_find.
>
> Does anyone have any opinions?

I'm new to QEMU memory API, but here's my two cents.

What is special here is that virtio PCI transport provides a "PCI
configuration access capability" that allows accessing BAR-mapped virtio
config regions *BEFORE* BARs are initialized. At that time, the BAR
MemoryRegion is not yet added to the PCI MemoryRegion (and thus the
memory AddressSpace), and that prevents memory_region_find() from
working because the API requires the given MemoryRegion to be in an
AddressSpace.

I think it is reasonable to add one (or two, one for mmio and other
other port i/o?) per-virtio-device address space for such virtio config
regions. The PCI capability can be regarded as a window to a register
space that is inaccessible otherwise under certain conditions. Also,
device-specific address spaces are not rare today.

Directly travering the subregions does not look like a good approach as
it breaks abstraction. Accesses to memory regions require extra care
about RCU and refcount. Scatter such operations in multiple files will
make the abstraction harder to maintain.

Adding another API for finding a subregion within a region not in any
address space is an alternative, but I'm not sure if that looks like an
overkill.

--
Best Regards
Junjie Mao

