Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F5ECD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdVh-0005PF-7I; Mon, 08 Jun 2026 13:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdVc-0005Ng-Bv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wWdVa-0005G8-3A
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780938689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQI+XNi+8PQA7/vciu2dpfojFl+k1DC10d2RhqaZ1FU=;
 b=In/B1Sjnve/Q6Mp8+hhn+W2sIcyVzJwk3twcMn95EJaDJA2KyF6RqK6r6BlR2cwbfxw89F
 xjghNEOULXjAQg7OMtnEWmG1MymvxuhpOAH1CTqpm7pYRVtUtZseRhvUAQGEfOr/Zf9hni
 ChrJbax/WheLICmitX3DQQsTUly+Vog=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-oLgCGeN3Me2NqMwztvkAew-1; Mon, 08 Jun 2026 13:11:27 -0400
X-MC-Unique: oLgCGeN3Me2NqMwztvkAew-1
X-Mimecast-MFC-AGG-ID: oLgCGeN3Me2NqMwztvkAew_1780938685
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so17418785e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780938685; x=1781543485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RQI+XNi+8PQA7/vciu2dpfojFl+k1DC10d2RhqaZ1FU=;
 b=ScDI7W8ND34s7K/I4nT/Fcmr2rGTK/Qg+3X5hzQmw3sunWF47WX9AlGSm+4+Jwcec9
 5euL3FvZPZZCeXCzHOas2IEzc5i64PifemEHZP8yy6OUa9cBmHSo2GYIar49E50Euf/s
 Z46URNkkQ7hS2WAyvUenDoLj1HNxFGn4Pi3baPbgkkno/dCQK8f3/Fqoo59X9OXvnbAk
 gDf62mdQqSzRIsXf62IkYRFyTCQx3F+/tNkqd2vNBeEeXOmetekCgIr45LQZMfJuhA27
 btcK8GLl3fqQtSe+Q4iahHoU1h6v+9FmYexsfTT8PX9MLqaC8yqN4otQLRBYCxmjuAKw
 J21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938685; x=1781543485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RQI+XNi+8PQA7/vciu2dpfojFl+k1DC10d2RhqaZ1FU=;
 b=CcXZ3Tk2mR5gz2VkcoV9oeG8OLuiZ+ISFK+p4BPCXwaKChS56gAjAmxW2GBP2krsMs
 hTHEixhDDEjCxR7pybB7+Utb8+RccTrh1TpMi4bSc+aj6CurBxK95Yj6bmH/xGhmCdnb
 c2LUC7FYC5z47LhJW4tl0BTpj1K69quO/HA4mNrE6rSW02G/QsAqp+P1juekzpaVNgRV
 U34D2QeHBfI4JDw2dAVlA6i0ne42b+Ff4Dqpsr7wZVi3M5je8IyNLyWuC1dzTrYBW4Oa
 fnoJre4m/s0Yyw3IxtMz4oFI/oI6HENh1uGTRbRVhVLK9dvKc+6YRm26SR8escPPvE2r
 ZMXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u0M3XXfmf2U3Sm5hAjyySKI9IfrcSU7QBVeTP65Qegv2sLKxyubPerE3Q6EGsD3E47unaI79V61QR@nongnu.org
X-Gm-Message-State: AOJu0YxqbXStCw2TXgqLiHoRBnnouL8x3wtNJKFbhMoFiDGuAKReonti
 1CIWb3l6MWPErvWMXoAbL4eHmJd9VzkfUOIJ8EdtCTErCsqScpLE9bgI2L/E9VonsFEnjqNAtKF
 VjHXT/i0pgy9kW8bDE10C8/dNfuOl8EVUUYHH416xL7bGsvh0oW3Nunuc
X-Gm-Gg: Acq92OGg7wSBzhG+yzewxWg+QAPS6vLNadDkDaKTSQtKe0DqPw7TkkdSqU3Eqz9K1/u
 aRDkyaBlRqNtJnk0gHxODNSYoppjZT4rVeMuZt6zVEytceGYwSg26eJZhzKwMW0o7WX7lMo85iC
 3vgvpTY8oHWnOs0JrpsMh6GF5tyX5WGEOOGfZaNhT1tSxDoJUcnFRz05ns/nwGGbeRPwCOCah0n
 pSgrOWKrKRVY0j4ByvMvBqjQE6eI1cYP4Z8/72hSLThX0oUYxEyGNtjMOFK7+FhHQTIHkoLxiZi
 4dxmfUQB9bgjBwu+1eTTVdBfsIcQniHcDSO1o2VjjSWGI5J1Z//b6NciUTCgMOAcKwnrkVr0RmM
 y9s90n7tGMXRiEF2jsYvnGuKPVg4w166BbJFntt5mvoolElGR+jtVWOSfIiNbiH9hGTOAeDbod0
 w=
X-Received: by 2002:a05:600c:529b:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-490c2625f9bmr247580035e9.31.1780938685407; 
 Mon, 08 Jun 2026 10:11:25 -0700 (PDT)
X-Received: by 2002:a05:600c:529b:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-490c2625f9bmr247579565e9.31.1780938685034; 
 Mon, 08 Jun 2026 10:11:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bda4fd52sm394739295e9.0.2026.06.08.10.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 10:11:24 -0700 (PDT)
Message-ID: <0c05cb81-c3b7-44cb-8a5e-70b7eef1853d@redhat.com>
Date: Mon, 8 Jun 2026 19:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/21] tests: acpi: arm/virt: update expected GTDT blob
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-18-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-18-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Expected diff from base GTDT is an addition of watchdog
> timer block:
> 
>    [000h 0000 004h]                   Signature : "GTDT"    [Generic Timer Description Table]
>   -[004h 0004 004h]                Table Length : 00000068
>   +[004h 0004 004h]                Table Length : 00000084
>    [008h 0008 001h]                    Revision : 03
>   -[009h 0009 001h]                    Checksum : 93
>   +[009h 0009 001h]                    Checksum : 39
>    [00Ah 0010 006h]                      Oem ID : "BOCHS "
>    [010h 0016 008h]                Oem Table ID : "BXPC    "
>    [018h 0024 004h]                Oem Revision : 00000001
>   @@ -48,17 +48,30 @@
>                                       Always On : 0
>    [050h 0080 008h]  Counter Read Block Address : FFFFFFFFFFFFFFFF
> 
>   -[058h 0088 004h]        Platform Timer Count : 00000000
>   -[05Ch 0092 004h]       Platform Timer Offset : 00000000
>   +[058h 0088 004h]        Platform Timer Count : 00000001
>   +[05Ch 0092 004h]       Platform Timer Offset : 00000068
>    [060h 0096 004h]      Virtual EL2 Timer GSIV : 00000000
>    [064h 0100 004h]     Virtual EL2 Timer Flags : 00000000
> 
>   -Raw Table Data: Length 104 (0x68)
>   +[068h 0104 001h]               Subtable Type : 01 [Generic Watchdog Timer]
>   +[069h 0105 002h]                      Length : 001C
>   +[06Bh 0107 001h]                    Reserved : 00
>   +[06Ch 0108 008h]       Refresh Frame Address : 000000000C000000
>   +[074h 0116 008h]       Control Frame Address : 000000000C001000
>   +[07Ch 0124 004h]             Timer Interrupt : 00000090
>   +[080h 0128 004h] Timer Flags (decoded below) : 00000000
>   +                                Trigger Mode : 0
>   +                                    Polarity : 0
>   +                                    Security : 0
>   +
>   +Raw Table Data: Length 132 (0x84)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/aarch64/virt/GTDT.gwdt      | Bin 0 -> 132 bytes
>  2 files changed, 1 deletion(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 3e9be28cc4..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/GTDT",
> diff --git a/tests/data/acpi/aarch64/virt/GTDT.gwdt b/tests/data/acpi/aarch64/virt/GTDT.gwdt
> new file mode 100644
> index 0000000000000000000000000000000000000000..e0c2151fa7d3432740bb997d7d33669e30f133aa
> GIT binary patch
> literal 132
> zcmZ<{aS3T*U|?Xjbn<uh2v%^42yj+VP*7lGU|;~TLG*tpU|?WikOdJ83=DD%3=Av`
> i3=Gmxz7&*(sRilFfQo?tqYRkh0h0m{dIFfkzyJV@>lgt5
> 
> literal 0
> HcmV?d00001
> 


