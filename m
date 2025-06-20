Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD01C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSa0L-0000Id-L5; Fri, 20 Jun 2025 07:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSa0I-0000Hr-00
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSa0D-0000md-Hq
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750419227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4EM4PgoTHmx01ljO5geUpXFgDqfHPO1/nf+GfUWqjQ=;
 b=I9HQdBQmGaqPCPWLuWYkI1p9eSGoMao/2T/pwlSLo0MzhcaTDvkSkFUqCJTFQeEEs7+EPK
 idxV6i9Sp8EKEpEIa1c91WzVTLQGEndlwat9ZaefdepcX19KUk6UETS5z8lEOqJ8rMn8/P
 n3976dk6KKCL9tJF2310svSWA4JYeW8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-17Cw6o73M22Pn2oeUoygEw-1; Fri, 20 Jun 2025 07:33:46 -0400
X-MC-Unique: 17Cw6o73M22Pn2oeUoygEw-1
X-Mimecast-MFC-AGG-ID: 17Cw6o73M22Pn2oeUoygEw_1750419225
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450df53d461so14907425e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750419224; x=1751024024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4EM4PgoTHmx01ljO5geUpXFgDqfHPO1/nf+GfUWqjQ=;
 b=JnGarZgE78BcVJhbBvy3LjLiwlh8/S8p1vYSZvyIpvEBdenxJhhq0G8vGssFy0QY/l
 PiDMbgBqyjSP6xqyp0N2caZ5fsJRFQ9rVdf1A4NuoF0sZnu9E2y2P6vrjxXoWhQoyHs7
 hYCN/CDlmVE9GGhMskRZOiDNVVxvHv7dzgnTkTetNNw4I08+jsi9UIXxv5UpuvoNQasL
 MKv+atf0c6aOye/aPg5Lw/qb9XYzuqPh0K3Y+Qg1ZUQo9Rzu9mKeATomDXeaQNOGRpJW
 Dc+GzSZanrrIRWfLM/JZ2ewMBRmfIrcyRSgjDTZ3Ys7gxO63p2GTlkAAU/cp5VHTh0DC
 f37w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQDQRzGrddsxqkNiuTFEff3LifJFXSaY7+9WAJ3Z1BzM3OlTQYmC4aiy1IVUvSky3ACmCMxb+qbayK@nongnu.org
X-Gm-Message-State: AOJu0YzS85m42VWmDaxEmfT5u8f1/GFtw+FZlgTui82XEV6sz9PlRspu
 XOkKsteqKViWAhVj40umZ78YOlK+sGR1mUX36XWYMp7KzJ6ZdwlOms9Ol8KttgQfkkq24jodxZB
 bs5vob2e9h/c+/r+FUR7w9moXLyCzcIVXdCWUwM4UpzW9xCvT47kJtHOO
X-Gm-Gg: ASbGncv9UHrROEFVtdtNMudcPTnRpShwNV9CdCsl1K2o+Z15jjlzMMEWzoMnGITqccD
 wX84tpTj0uHTnEfyCh3HS7/ahk2qyipYvCTnyVay4lfWU7DcC3jYpJrSRXHB79+XeTWUOcnjvKR
 evPuAGvSqx2EyPQuGbMNMbjpj8kVJASprrts7vktziAjYlCmjFBCl3ub4TwKxANsW7kTFKmk7BO
 IEhRddGnEdYNJL79mCVd4nLp6ZXyGQh7IZXNCNa+uvGkkK7TqNdarUkP3BEA0EaMKTpmnZbiWKA
 AHLEh7K+E2HZX9qanRCExxod4Z+FwQSzeKc1nQ6qvVNNQtTz+UZxL6imhJhWZuX+unXCeg==
X-Received: by 2002:a05:600c:1f94:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-45365a05192mr23351575e9.30.1750419224148; 
 Fri, 20 Jun 2025 04:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3+b7gnke2fcZox0mHUfeZWF+KLRDOyUflD6hSufPO8ZNN750WMhD0wB8S91TCMUpl41ePYA==
X-Received: by 2002:a05:600c:1f94:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-45365a05192mr23351275e9.30.1750419223688; 
 Fri, 20 Jun 2025 04:33:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470371csm22300085e9.30.2025.06.20.04.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 04:33:42 -0700 (PDT)
Message-ID: <36766b91-b09e-43e3-922f-396da9e395ed@redhat.com>
Date: Fri, 20 Jun 2025 13:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/29] tests/qtest/bios-tables-test: Update DSDT blobs
 after GPEX _OSC change
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-11-eric.auger@redhat.com>
 <20250620095933.00006eae@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620095933.00006eae@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 6/20/25 10:59 AM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 11:46:39 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Update the reference DSDT blobs after GPEX _OSC change. The _OSC change
>> affects the aarch64 'virt' and the x86 'microvm' machines.
>>
>> DSDT diff is the same for all the machines/tests:
> Is this diff backwards?  It's the opposite of the one in patch 9.

argh. Most probably. I must have messed with the diff :-(

Eric
>
>
>
>> @@ -1798,6 +1798,8 @@
>>                      0x0000008000000000, // Length
>>                      ,, , AddressRangeMemory, TypeStatic)
>>              })
>> +            Name (SUPP, Zero)
>> +            Name (CTRL, Zero)
>>              Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
>>              {
>>                  CreateDWordField (Arg3, Zero, CDW1)
>> @@ -1805,26 +1807,27 @@
>>                  {
>>                      CreateDWordField (Arg3, 0x04, CDW2)
>>                      CreateDWordField (Arg3, 0x08, CDW3)
>> -                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> -                    Local0 &= 0x1F
>> +                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
>> +                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>> +                    CTRL &= 0x1F
>>                      If ((Arg1 != One))
>>                      {
>>                          CDW1 |= 0x08
>>                      }
>>
>> -                    If ((CDW3 != Local0))
>> +                    If ((CDW3 != CTRL))
>>                      {
>>                          CDW1 |= 0x10
>>                      }
>>
>> -                    CDW3 = Local0
>> +                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
>> +                    Return (Arg3)
>>                  }
>>                  Else
>>                  {
>>                      CDW1 |= 0x04
>> +                    Return (Arg3)
>>                  }
>> -
>> -                Return (Arg3)
>>              }
>>
>>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  tests/qtest/bios-tables-test-allowed-diff.h   |   6 ------
>>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5158 bytes
>>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5244 bytes
>>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6519 bytes
>>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7603 bytes
>>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5360 bytes
>>  tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 2985 bytes
>>  7 files changed, 6 deletions(-)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index 75f057767e..dfb8523c8b 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,7 +1 @@
>>  /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/aarch64/virt/DSDT",
>> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
>> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
>> -"tests/data/acpi/aarch64/virt/DSDT.topology",
>> -"tests/data/acpi/x86/microvm/DSDT.pcie",
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
>> index 36d3e5d5a5e47359b6dcb3706f98b4f225677591..acab6e65febbc210158d4c39be0680bbb90250f5 100644
>> GIT binary patch
>> delta 114
>> zcmX@3u}p)@CD<iIO@x7g>C8kfX{JVpjp}Y(OkR^V=X2?C2#NTx$NL96vvg%MIJ<-!
>> zF7RWWyjw`i#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;W@BMV  
>> FMgSUfAKd@|
>>
>> delta 152
>> zcmZ3caYlp7CD<jzM}&caNqQoeG*i3NMs+tXCWon;^SSgm<T!#u0|FR0oI`?q7)0DS
>> z<Nbr3S-P?roL#~V7kIEwUN5BOX9QAG;Or7^3{q7MBDmy1<N|?7lQS7>L29`;z&gYx
>> bO@^t12n&FO3qXoN;!Cm@@@?i7mSh9~5Tq&5
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
>> index e6154d0355f84fdcc51387b4db8f9ee63acae4e9..54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e 100644
>> GIT binary patch
>> delta 114
>> zcmZ3a`A37xCD<jTMudTZsdFNiG*i3lM)f&dOkR^VALY{H5EAiWkM|FDX6ediaCQkd
>> zT;Rt#Sx{KZ#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=1yTr  
>> FMgUJNAb|h?
>>
>> delta 152
>> zcmeyPu}G84CD<iokq83=(~XH-(oDVX8`bA<F*!`#e3VO%LyjXjG$4S1!#O0#he5=R
>> zGu}VgnWZb6!PzC;aDfN=WL9A<KO>Nm0%w<SW00z95Wyu6A{Piunw-g43sTF)0oEZl
>> bX);V5L|6bMTmVuG5?_+NkZ*Icup}b@<J&8B
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
>> index 33f011d6b635035a04c0b39ce9b4e219f7ae74b7..4330bc97cba0950191c45ac833533db7a190db81 100644
>> GIT binary patch
>> delta 114
>> zcmbPh{N0GlCD<jTT#|u->Fq==X{M&B8`a&on7k%!&gatO5EAiWkM|FDX6ediaCQkd
>> zT;Rt#dAE?3iE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w&Bnr6  
>> FYyg6XAvXX3
>>
>> delta 152
>> zcmexvG}oBRCD<iot|S8klg&gfX{L_p8`a&om>i~V&gatOkmCpr4G3W1a1IIbVGwcS
>> zjQ0<AX6ediaCQkdT;RbzdA*R9pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
>> bG#RE2A}jzBE&wS8i7&}s$hVnSIExJcpiV0*
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
>> index c0fdc6e9c1396cc2259dc4bc665ba023adcf4c9b..7fdbc03e2bf9fb7d35704779253de36e362f0bf9 100644
>> GIT binary patch
>> delta 207
>> zcmexwz1f<}CD<iovn&Gx)9r~|(oB6fHmbXEG5NM`&ga^|E+pc^9`7IQ%+i(3;Or7^
>> zxWJEfa-NKqiE%=80+)Qk0)a`BGZ||^GF%*BdErTuon69>6Ch#&AhCi3kjO%w$<JhL
>> aH-8e+V`TE0v{^|+kAs?qZ+<2t$p`>t?mg51
>>
>> delta 282
>> zcmdmN{ok6)CD<k8zbpd-Q^!OuX{N5b8`a&on4CK{=W}gfm*WTy4G3W1a1IIbVGwcS
>> zjQ0<AX6ediaCQkdT;Rbz*-%K!&j_TXz}Y3-7^JEiL~zN2$OQtECTB9%g4A+xfOUvX
>> unhaA15f%Um7l0Il#Fu0*<lEdYl+DQGFm>}EVLcA|TR*v9$aeB|nL7Yd7E^Zs
>>
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
>> index 029d03eecc4efddc001e5377e85ac8e831294362..969b4f6560d3ae39f5b7e0064b7122905476fce8 100644
>> GIT binary patch
>> delta 114
>> zcmbQH^+A)%CD<k8g9rly)24}B(oEex8`TB4nY<=#w&d315EAiWkM|FDX6ediaCQkd
>> zT;Rt#xm8%p#5kckflEGNfxx86nT)j{87>a6yzr#S&Mx7`2@o*>kXS(iNMs?;=D)&{  
>> Fi~vUbAmso6
>>
>> delta 152
>> zcmeyMIZcbpCD<iIOq79viGL!OG*hGhMs)#hCWon;ExGkL<T!#u0|FR0oI`?q7)0DS
>> z<Nbr3S-P?roL#~V7kIEwt`yetGXg0oaCQkd2C1qB5nS>ha)H34$(f9`Ahlc^U>#zU
>> bCd1T0gatst1t7&B@g>;{`8Hn{mSh9~yBaCk  
>>
>> diff --git a/tests/data/acpi/x86/microvm/DSDT.pcie b/tests/data/acpi/x86/microvm/DSDT.pcie
>> index 8eacd21d6ecdf9a3cd3e4f03cf1b40748dcbf53e..ba258f454dc0e59ef2fd67e0ce37e270e7c122e8 100644
>> GIT binary patch
>> delta 113
>> zcmX>vzEYgaCD<ioB{u^D)Axy7(oD|VH>#&HG5Ji`+{YxqAtd6%9`7IQ%+i(3;Or7^  
>> zxWJEf@*XZN6XS&H1TMLR1p<>MXEN4;WVkrM^1_oQJG+D%CqTpmKw<?6Ad!VUlTEm1
>> F0{}^9AprmY
>>
>> delta 151
>> zcmZ1}eqNl*CD<k8JU0Ualj}q-X(rE|8`V>pn4BhW?qd?*kmCpr4G3W1a1IIbVGwcS
>> zjQ0<AX6ediaCQkdT;Rbzc>|Z0pAkq&fwN1vF-TQ4h~Sb3kqZPSP0nPj1*zrY0P7H&
>> aG#RE2A}jzBE&wS8i7&}s$Tyjfdo}=5#47aw
>>


