Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606C6C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYz8-0000kG-Ds; Mon, 24 Aug 2026 14:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@citrix.com>)
 id 1wyYz5-0000jt-US
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 14:01:24 -0400
Received: from mail-southcentralusazon11011042.outbound.protection.outlook.com
 ([40.93.194.42] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.cooper@citrix.com>)
 id 1wyYz4-0006VM-1N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 14:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRhus86doozq+tax/aCrEsz7DUBHHCuvEIQIuZPb3TJXiiokJOqgNjCM1OKt2bOpdtIfTvt3E4+OlsEY50/sDDbcacppGw7VfxMRUvNdqiUosQFD08lbx6HUjscdpn5vfJRxV/aLAqv1uqH9xiIfZAukHIz6RXym3E0u9QVmmXd8iBB5nl0A3h29qp1+xfu7e7L2Vu+a1VySe8LYitJYwbwRNT8f7c4OF7NEbMhC/fWGoftLiMJ0k8HNmz9eXH5vmxyUHrE7mOUsKHJcGNHStazuzSgLI6TcFSqvg/99+M8cL/+G5zELUyK04N4s1bZezcVU2uaI498Omm9BJcHS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ICbahNI9SzHs3KL+ndDaQxrDtFROP5FKgMakgp4Zww=;
 b=E3ldTcSljVTcCAmTON+nrH55C8ZtEQKYmgx+4WcyCopgQ6Rp7ab8UbQt6tDk/O+n834AWo/rLe5iWWR+qcyU23apTjUew5JBjfKBRW+Hsofph1fPcJAKz+p2f61T7NR5egAdWWpwuYdttu1hAT6LybYOWGcHj55TlWPgYzcFyPuLnHyPbexoyf69wEtXviVT1lRxALPZ+q4pQDhoz8kDw0vVKtACtOtm32CP9yA43HGYwv0pqQR4HnJNK8jGGwVaYi+oOnr2MANX5Rfejmmpnr7+U9x9i1c8N/A7gwHjMX7UiH7fAWMTXprZdqT0Hx+T2hRPBsDXi8wuRFGQkw3nJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ICbahNI9SzHs3KL+ndDaQxrDtFROP5FKgMakgp4Zww=;
 b=xnwdFFFUZ5yThA57YTsv8EbRujJOifHqsKqC/wi/NKqeqgB4nFoQhm1iX2ny2IuYPFkE0z8k8mxLMBHbaKNDMs2lY4DgTMlHy457b2bWfcVrH6c1VYq4q8HESWT1ttqahKjFK7s1IDNKd2c1K/7E+lhCPB3x0CAqx9giHhtNaI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by LV5PR03MB8412.namprd03.prod.outlook.com (2603:10b6:408:35f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:56:16 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:56:16 +0000
Message-ID: <ea290b1f-5d40-48e3-9a64-1799244c6e64@citrix.com>
Date: Mon, 24 Aug 2026 18:56:11 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "anthony@xenproject.org" <anthony@xenproject.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Saleab, Micheal" <Micheal.Saleab@amd.com>,
 "john.ernberg@actia.se" <john.ernberg@actia.se>,
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Subject: Re: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
To: Peter Maydell <peter.maydell@linaro.org>,
 "Frager, Neal" <neal.frager@amd.com>
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
 <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
 <BL1PR12MB50322B1D97569B5CADEC8E55F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA9rWqo92nt1StDuBwUjbV0eqdAA921nozpjQHDF_ARJyg@mail.gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAFEAcA9rWqo92nt1StDuBwUjbV0eqdAA921nozpjQHDF_ARJyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0358.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::21) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|LV5PR03MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fb5c23-3ed3-4740-b11c-08df0208fe89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RU2oSGHjF3o88MCcxcxg+XuZIdfXZGSmjJBC2wpTMT6CtIaqsCx9uFXD0PgY8RXVJFM034Qv54hcRZ8z45tq9TFwMtjCq6SG2D+cDDm0e74jjHU9ZXhj1282QlPjNXK6cNTUAjOyjl0/MqPwFkEWFQdVLsv4S3TlNUw44PBqejFe1/yegH7FClxsh45OVexT5fV2jJk6SnUY8u2+Eyx0KO/2yi/N5KrszaFsq8rh0wYGSkmLrVGSVJPx8TSl6XCs/HNOuE2ycb1fRCOt14MXAjBlqWscieoVp/y7ymUeIDgQyvnIdPgqqFibBWgBkN7LrlyeShADAhC9JnGq8c0q9k9Lgd2uya7PMLKbmS1RzUu3hkaAIYuLzKWuR/ltqAdTTKsOLB0pXYa9Nig+fDpSLXdFpWk3uw0CdujerGH+3XtcF7Y/8r0tttB3MgtMNR6poOs1GuCT8aQAisYKDVpUf4rLyJruoMfm32gxilcGyVVKiy3A6lvuCGPlqvp9O9Gf4UIRumaGMA5v6J2r5tfh55017iV65P73b/5u4uVOp6r+dGmf/PE4lYY5HC0XQFYGnOn5zVQ4G8zjn2hT1HHTsAIoJfbUT8SIWVyacEw4Hz+zV9biHof7X8TaA3L7EIpLeTJT1DQf8biVx1mlgdHqjyeBA2dJEjIokSauigF7WEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8275.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJzeG4yY1JUbzlLVnA0ZkxOMVgxWHJPVEdjVDBOckV5REFxa0lEL2xUeHZs?=
 =?utf-8?B?emdFTlRRUVUwaXUvVG9WRytPaThaU29BcEJoaXdUSGhYVnFWMjM2RU1EM3I4?=
 =?utf-8?B?V1FCQUNYUEg2Wk5PUXVBNFZpc1VDUEdubG1iOXczM3hscjM2YUE0d3gwZTFN?=
 =?utf-8?B?dHQ2ZGpXSzhwVER6NWRlZXh6Z3JuUG8rYWVTL1BYcWVQWlBUKzM5U2xYUEd4?=
 =?utf-8?B?WWxBYTlWZ0o5OVJpTFhTeTAvbk1GTnVrNjBKNlpLR1pwR0d6OXY4dm1VY1Bo?=
 =?utf-8?B?TWpPZ3ExRytpbHhwNWRJaXFsVWJTSGRkTzlsdEMvSzJqdHl2WjlDT016d3g5?=
 =?utf-8?B?emRKUFl3ZGdJYlNhN0Ryb2F2YXdmekx0bGtNUytDZmNWaXhocnpGSzFTMFU3?=
 =?utf-8?B?ZFhVNFhKM3hzNWZmcXFxN2V6QXZpdk9CdkhmbElKaDZFWEJ3ME9mWGpLR25Z?=
 =?utf-8?B?ZTFBZS9MU24rZ3hrZ1B1RFZmQ002MUppc3BIRHBNU1luczYzejFMRmVNaDNk?=
 =?utf-8?B?OHhaYklRNnB4c1c3dWErMzIrbmJUMXlnUVNjK1ZsTVA1dzdBMTVxRzNvaG9l?=
 =?utf-8?B?Z2tMd3RETDBaWFVkRi9aTWFJS0swaHFraFBqb0FXNGdsaE1oK0UrQVhPdFcr?=
 =?utf-8?B?SzhaQ2todDFLQVhLZEcvTGFkUUlCcGxSbUoxRC9RUHVzRE1HNFZycnB0NVRF?=
 =?utf-8?B?SHIrM3BFeVJjVGZBNmdwWVYwTTd6dk5IcFlPYk5XKzRHWTVHR05SVUtwSm9G?=
 =?utf-8?B?UURxRk5hQ0ZLbG5wQklLWWxTMGxVeDlVQ0NvV1hOTFN6WTJGVTVCcUhUSENk?=
 =?utf-8?B?WEdOV0VGSjhyTXAvRHZGMFJRYVk5RTRkV3ZNMzVRL2hMWVN3aVo2T1pBR3po?=
 =?utf-8?B?ZmJmd3kzRm1mTld2Vi85QllKdmhzZ3IzTlBoUmpzUXhUa0FZNFVoZEpWR05O?=
 =?utf-8?B?ZkQ2VWJxaDlpNUZDejdXcENYYzVEYlVaNy8zM3dhY09SZlRaVGpodDQyZFhT?=
 =?utf-8?B?ZTJ0cUtYWm9rZWo1amdjUEZ6aitVLzlnaDZVbVZQN1ZvdUpOSnZpaXlyQ2pX?=
 =?utf-8?B?aWMyRGMwNTFOYWUzRjZZNmtjVFE4QjRwakh0T3U0TjhXdENZeXE0YUJFVDBE?=
 =?utf-8?B?eHlXYkRndmNwUjNOajFoTXdPN3FtM2xmc0ljN0xuYVJUVHdIb05EeENDcnlL?=
 =?utf-8?B?VXZrb2lZMGFzeVJmUEhuQldNU3BWRE5DbEVPbkdURnpuUXRDeWF1THdtVis0?=
 =?utf-8?B?MHRsVTJ2dEMzNzhZSzF1YmRjQUhCK1hXcmd2ZC9YL0hwb2RXeFlNay9mUFJx?=
 =?utf-8?B?bEhkRC9ud2VpcVFXSVdaS1hwbnpWNFh4UlJMbnVqanNEak1BZWJyODBHRmlR?=
 =?utf-8?B?KzF0VHovdDlhNnhqNlpqUFc5NXVxUUZ4ZHRaeFVmNEhRS2t5Y0RwTnVPaEJ4?=
 =?utf-8?B?UEVsWkhTcDIyc1FaZjZEZ0c4SVJ1WmEybmFHOWxyZ242eVNtTGltUHZRZ05D?=
 =?utf-8?B?akxOeTArM3JUc0lTeEx2U2hEb3htdXBWUkRBZDRjOWtRNGNCSGkzNENRcFhU?=
 =?utf-8?B?TEJXSWJONGh4RDZibzBIMS9aWEhlTFEvUkNsQ1FpNVRYdTRaZFJTcWE3ZXQv?=
 =?utf-8?B?bGs5TmJVWTFaNWJ5RkhZbXduZElaSDJKWVJEM0l3a1NINE04SU0rU1Z3bE4v?=
 =?utf-8?B?eS95c0k5TXZ1VGEydVc3MFZ6Z0pVS2pKRksxeE0zVi8xdEVtZ3NFendZZjlN?=
 =?utf-8?B?a1Yzby9JR3pXRWJDeXNMaWRseHhHMHllQ0MwMUg2eEVtQlFCc09sTXE3eXd6?=
 =?utf-8?B?Sms1WE5ia2RBczV6SEFabE9RQkl1OGhDSFlwN01lcVBzTngxQUlkYUVENEtl?=
 =?utf-8?B?LzBpNWhnNnpLTzlUYzA2WnJyUlJiM0Q1c0E5a2JyeHN2TmJYRnVGcW5PMDRl?=
 =?utf-8?B?Tm1TeWhrOGtDZGxISTRubVpaNmRQL0RZT0FYUy9QUkVvSWZhenZUOHV5MVRO?=
 =?utf-8?B?RDdId0NBWUpvNXdJZmprc25mU21ma1FhM0FnMWFHN3NORzdpTWVtRmZtUVlS?=
 =?utf-8?B?R2ZDREI3QldmK29UZDRLL213S1ZzMmt0MUlzc0p2OGd6cVFwMzNNTW5hbEZR?=
 =?utf-8?B?VHE0NEVSSFk3NnMrcVp6S2R0cExSUm9YbVNqUUs2RjMwalE1L1BKWmxxMFBq?=
 =?utf-8?B?dnREU2JjVHVSTnNhazZPTkVhait2VytNcW5KWExZL1ZGajNGVEZmYjdTVUow?=
 =?utf-8?B?SjR2bTJ4em9DQmR6MGdHRnF1cGFrQ3c3cGt1dUZ5Tm5YVjN3Q1gwaGg0aEx4?=
 =?utf-8?B?THNxZFB1SW5MdEhheGpQZnZqbktObFJpKzdzbWtwQ0M0aVRZSXEyUT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fb5c23-3ed3-4740-b11c-08df0208fe89
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:56:16.4964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IclTcyAiQzZBQl0/70ikw92l5/5ee4P6Vzl5tj/Y1/w8hgM/x47t2hyrLOn9ZiAk6aviEEHB00BUJtA/kdVYaeYPvaAh1IyhoCkrOxh12cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8412
Received-SPF: pass client-ip=40.93.194.42;
 envelope-from=andrew.cooper@citrix.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 24/08/2026 3:13 pm, Peter Maydell wrote:
> On Mon, 24 Aug 2026 at 14:31, Frager, Neal <neal.frager@amd.com> wrote:
>> AMD General
>>
>> Hi Peter,
>>
>>> Hi Stewart,
>>>
>>>> The -I$(XEN_ROOT)/tools/include added to QEMU's extra-cflags causes
>>>> __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included,
>>>> triggering an include-order assertion. Downgrade to a warning since the
>>>> version is consistent in cross-compile.
>>>> Ref: https://github.com/qemu/qemu/commit/e2abfe5ec6
>>>> This is a buildroot issue, so I don't believe it's necessary to fix from the
>>>> qemu side.
>>> I am not sure I fully agree here. While this is a buildroot identified issue,
>>> there could be other use cases for __XEN_INTERFACE_VERSION__ to be defined
>>> before xen_native.h is included.
>>> But what, though?
>>> And what we have found is that if
>>> __XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included, it
>>> is not a hard error.  For buildroot, the qemu works just fine in spite of
>>> this.
>>
>>> I think that just means you got lucky. Either there is a hard requirement
>>> for one header to be included before the other (in which case it must
>>> be a #error, and whatever is causing the mis-ordering to happen must be
>>> fixed), or it's fine for the ordering to be either way (in which case it
>>> doesn't even need to be a #warning).
>> From my view, the order the header files are included does not matter, and
>> this should not be an error.  I agree with removing the warning as well, if
>> that is what we all agree on in the end.
> The rationale for the header ordering is in the comment in include/hw/xen/xen.h:
>
> /*
>  * C files using Xen toolstack libraries will have included those headers
>  * already via xen_native.h, and having __XEM_TOOLS__ defined will have

Lovely typo there.

The define __XEN_TOOLS__ is woefully misnamed.  This is an error of
Xen's, which I've not had time to fix yet.

It should be named __XEN_UNSTABLE_APIS__, and thinking of it like this
will make it's purpose a whole lot clearer.

>  * automatically set __XEN_INTERFACE_VERSION__ to the latest supported
>  * by the *system* Xen headers which were transitively included.
>  *
>  * C files which are part of the internal emulation, and which did not
>  * include xen_native.h, may need this defined so that the Xen headers
>  * imported to include/hw/xen/interface/ will expose the appropriate API
>  * version.
>  *
>  * This is why there's a rule that xen_native.h must be included first.
>  */
>
> ...basically, if something doesn't include xen_native.h before xen.h
> then __XEN_INTERFACE_VERSION__ can end up defined to the wrong thing.
> (Disclaimer: I'm not a Xen expert, I'm just applying Chesterton's Fence.)

__XEN_INTERFACE_VERSION__ does alter structures.  It must be consistent
across a codebase.

~Andrew

