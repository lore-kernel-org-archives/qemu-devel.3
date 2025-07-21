Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF11C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwsF-0006uZ-0W; Mon, 21 Jul 2025 16:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1udwsC-0006tS-5g; Mon, 21 Jul 2025 16:12:32 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chichikalyuk@gmail.com>)
 id 1udwsA-0007N6-5y; Mon, 21 Jul 2025 16:12:31 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-32b43cce9efso40603631fa.3; 
 Mon, 21 Jul 2025 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753128747; x=1753733547; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6X57D9h3fZQwbp9rJ9R1YByGkHp+bI3VYHvZ1CCm5Q=;
 b=evSDvH7fxsimX7BQCX17YpoKK97CGvIzO/gJ9Q6AGOmwdajydhezyCEwYlAttsh8ab
 ixNPumD4hTUtoYCs8TKbrMAkgGOXUvbAI15i8O4F2gXeFEfzfDmN6qrhGSWojBh/NSPP
 XTXgZaqbE2U362f9yeKbGDYm/tDM8SctrF680wAcAABXB/qe7LT1S4u70RGlUh8JJb1W
 WBwds7PUyktGYv8UmAkl3LBSgIEHiGAl7v0RGjXcZhqbuuRtabka1UmInEi+GJbjnYSL
 VRWvIcFS0cPv6T6jMc50nbfHNQ5WmLHJlT4vACReaM3A9L6gMO32frb3/AwLK3H7iyFu
 wnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753128747; x=1753733547;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6X57D9h3fZQwbp9rJ9R1YByGkHp+bI3VYHvZ1CCm5Q=;
 b=Jiui4sRtupOlAsHK7NlhxX5IbvT3vuC4QUcWtcjx9kPDOP8E1S1LnwKXpgHFmufQFR
 ALo2hR9Jo1c/KZ78DrJ0xbNxgVv7yLpu8rws6TlQl+hLkqrJkVdZzdgff4z8y1RspfkE
 vYJxhgwba05+BsZtwTDf7WzdMe1kJLPSO3j9Y64kaJ2fKVedGkcP7v+2iQgBvYXGEDEL
 j8+6sAkNhQTbu+UwJs+HHe6Y/v19IAT2VBuKydcXwzIbiibwqZ/TSaS2xEBF7pUpPAqR
 UwoIb9oWj4WBLIUBoUZ1ZVA5mRlAotGHpyrY74/WBasJ5hx0SVoQQrtJltc2YYoC22+2
 0BPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOiJ7RvSdptOfHXXD2zlcdkpHSlCjfLCoS7SBE8oex3djskHV1y1fHWwKLNM/etkRcoHkoFARypQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyh/xmKdKGJ7ktsGvZh5fgX8TSQezHv+VsfCLl7uIfC3hLlWwql
 Qgm5xyKcmIdh0b06cXIez2UHLvGk4UJHUotZW5xg2ExTy5IL9neEZSp9
X-Gm-Gg: ASbGncsd/OGIkZO4lR4jAU0rl+t4SUJ7LJlFxBCEirXc9eVVlGfWmjEBd9dtg1kKStO
 2gRfapPxLHAq4FTnBNNMbjLHVvA85l7XlLrDfpPoYWZnkE8InR9RYXwkHt78JOyDttBpHn5JVax
 RcB1BLEWTFJnGpPysr9lCu14xOSKEDIrN8VJ+tOJPqjplX6FOe9KMUwcFQaXBXq5jNztfe40GFk
 O4akyZcKosop5byIFL9/Vv8OkuFx/Rev1M3FDXY/2gJqu35kNu8SL8ihm4PCaRZQntNlOuY6a58
 hgoqUbMiufwl4tt4piSk68gjorxkMA0Gmsd+qYXWIXJNTV1Esp1Mo7tZ6v1RJDGWUtLoLb4b1+O
 u1BNCAZdWKKPWLtmTBQTpQstNXq3SAd6F3nw+FlnvHmKXG7aaL5EnxDk6Rt8Uuqt4qNXM9X1Vrc
 w=
X-Google-Smtp-Source: AGHT+IFNCcs75/5DbyllzyHq2/mNK8dps+hQVHFYeGgUzMgxfnxJEo4Z4eLig/5FpjPZ99SB+75E9g==
X-Received: by 2002:a05:651c:2115:b0:32c:bc69:e926 with SMTP id
 38308e7fff4ca-3308f4c10b9mr60465631fa.7.1753128747169; 
 Mon, 21 Jul 2025 13:12:27 -0700 (PDT)
Received: from smtpclient.apple (m91-129-105-190.cust.tele2.ee.
 [91.129.105.190]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-330a91da0dbsm14333931fa.89.2025.07.21.13.12.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Jul 2025 13:12:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.71\))
Subject: Re: [PATCH 1/4] hw: acpi: add support for SPCR revision 3
From: Vadim Chichikalyuk <chichikalyuk@gmail.com>
In-Reply-To: <20250721103937.00007933@huawei.com>
Date: Mon, 21 Jul 2025 23:12:02 +0300
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Vadim Chichikalyuk <chichikalyuk@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <98B4B864-6AF6-4B34-B52B-4C15667B4913@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
 <20250718162045.49012-2-chichikalyuk@gmail.com>
 <20250721103937.00007933@huawei.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3826.700.71)
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=chichikalyuk@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


> On 21 Jul 2025, at 12:39, Jonathan Cameron via <qemu-devel@nongnu.org> =
wrote:
>=20
> On Fri, 18 Jul 2025 19:20:42 +0300
> Vadim Chichikalyuk <chichikalyuk@gmail.com> wrote:
>=20
>> The UART clock frequency field of the SPCR table was added in =
revision 3.
>> Currently, build_spcr() treats revision 3 tables the same as revision =
2 and
>> only includes this field in revision 4 tables.
>=20
> Given this isn't in the ACPI spec, I'd make sure you have a reference =
to the MS
> documentation for this. I think it is this one:
> =
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-=
port-console-redirection-table

I=E2=80=99m going off of the following line in the revision history =
table on that MS page,=20
suggesting there was a revision 3 with just the clock frequency added:
"Changed Table Revision to 3 and created field for UART Clock Frequency. =
Edited formatting."

>=20
>> ---
>> hw/acpi/aml-build.c | 20 +++++++++++---------
>> 1 file changed, 11 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 1e685f982f..9855d5f053 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -2123,20 +2123,22 @@ void build_spcr(GArray *table_data, =
BIOSLinker *linker,
>>     build_append_int_noprefix(table_data, f->pci_flags, 4);
>>     /* PCI Segment */
>>     build_append_int_noprefix(table_data, f->pci_segment, 1);
>> -    if (rev < 4) {
>> +    if (rev < 3) {
>>         /* Reserved */
>>         build_append_int_noprefix(table_data, 0, 4);
>>     } else {
>>         /* UartClkFreq */
>>         build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
>> -        /* PreciseBaudrate */
>> -        build_append_int_noprefix(table_data, f->precise_baudrate, =
4);
>> -        /* NameSpaceStringLength */
>> -        build_append_int_noprefix(table_data, =
f->namespace_string_length, 2);
>> -        /* NameSpaceStringOffset */
>> -        build_append_int_noprefix(table_data, =
f->namespace_string_offset, 2);
>> -        /* NamespaceString[] */
>> -        g_array_append_vals(table_data, name, =
f->namespace_string_length);
>> +        if (rev >=3D 4) {
>> +            /* PreciseBaudrate */
>=20
> Obviously historical, but this does seem like a lot of unnecessary =
comments
> given the clear naming of the input parameters!
>=20

Absolutely, I=E2=80=99ll remove those that don=E2=80=99t add any useful =
information in v2.=

