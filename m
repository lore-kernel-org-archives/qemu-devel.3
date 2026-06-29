Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAub-0005Ww-LJ; Mon, 29 Jun 2026 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAuQ-0005VF-Lx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1weAuO-0006hy-RA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782735376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vF1n9jI7Ss0PvjereA62Q4UNq6mjKPEXnD1SCg3WI8A=;
 b=ZmiDSiYBeGGxP62G8bA0xmWkvfZsatXZge6D+xSnhi79nj+miBLQkVgfbwuVzxMUy0xZUz
 ajLAPo/ocT8TtrKP1bJzh1T550NAI6CA8pH7Bie5S4SKJHV3B+gqjkxYX0UMVIhytbi5MI
 e+Z3+yUMgygKR1kJ0zTPN2p3Clt5fUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-K9O4x-4LMJiy1NGv2Qz7Vw-1; Mon, 29 Jun 2026 08:16:13 -0400
X-MC-Unique: K9O4x-4LMJiy1NGv2Qz7Vw-1
X-Mimecast-MFC-AGG-ID: K9O4x-4LMJiy1NGv2Qz7Vw_1782735373
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493ae33c70eso7543215e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782735372; x=1783340172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vF1n9jI7Ss0PvjereA62Q4UNq6mjKPEXnD1SCg3WI8A=;
 b=fK7suDsqwXp8rfYUawzOCsr3ofXRlKQysdi/722mJXV14m50V3xYM6eFQsjfId3izy
 to/E/IgqNhftWvZ+Ixd1JZA/WQavKpXxwjV60qORLEbcszQeyaqpwDzA1g1i+fUHVrvW
 YlfA/TKZjpnhizEmyxFOXqr0pIWLI9auwSmZj7hf+QCtnQmoVA/k7lOk6kGbnoLxvmvs
 glgqZktdjj8hVXWlJwf8u/YuMFNQRStpTwAYFEYGUesDAKqrgWkBjDedx5OHhaIGDsPZ
 rsKzo7yWH+LV2FWFZnv8jnanpi0YpMmihxbOKjVlDd9pua0tjIe8DzI5jwtkyOkBgCTh
 TjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782735372; x=1783340172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vF1n9jI7Ss0PvjereA62Q4UNq6mjKPEXnD1SCg3WI8A=;
 b=VNXJtNjNzSCpMKfcA1ZBJJACiLXezcS92DLoV/WYXf6huHCG2/p9B2mFGlgEnV8bki
 KTl1exhAPpuIom4l1WNhtAI1iXmi9o4kUTzVarCxbWy87CPR47O9B7W79o0DZJsl8xIi
 CmO/lGENKIUNP5FP97REMtOSW0LNNXQIBRhF/YPNnm2QO21ce7HULHXBvTnRv/cxHH+f
 Jwc0VkHQt9TGWnaeiaxGH8gBwSqEG8QuXFreqYNu1uJVKUSG4xtuVPq+vXldDlAVKn9x
 w7h8VGhv8EvE5HgE/0fWw8sKK5J2QTtiQ0TkxHbYb//SJwcSS7q9H/RO+Qg8oAaFc0+L
 kDXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xZ6ple7i0MmGd+YPSrVz0YRayf3D3KiPX5HFmLTicI2HmfUvi9hkgH7+YBo8ajyXYlkV0oKCpVHO+@nongnu.org
X-Gm-Message-State: AOJu0Yz4pgWs331gwkG6z9n3clcjI88JoBMQ65CbE3KDhWh66PlaxFp7
 xBU9lqdGRpsHOotiw0SMXtfQZEd4cRMXqY0ogreH0QPKSfcc4wlVtDzxMmJVO2s92nCGgjwc2p+
 algcwky3yMl1J//XpdmKcfhFwNMF/k4JduOQCc+geE/PFHtR0eRaqf7m+
X-Gm-Gg: AfdE7clzPnSPdrrNIJQmu5xY9BtN4U2SxqPC5dSweb6dZWFPJLmKFulpwDi59ir8k1Z
 9ZmNE5MsGmx2RFMdExRvJtrdMw8FKcXLXjlJJSJrzHa5kjlwnnRVEFEBBpJP9dYvdBgdZmwvOhD
 zWQEKH8vu7pcLexhpFHeE2nb9+kp2oLvmGVYjtvoGTeZuA0DiK3gaFSiOUVAzDyNhcFTpgKNxGh
 K4Vohz6oFh8Usq37078qyqDjpHmQoaixjQogVUd91h4OGDnCyhsnyQysP1mWfbKcoBcgKCGScNp
 k3sV4rRscmxtdWfk41Q0RVE3pd7S/4xytqokapMKfpR12UCHR2w0LUYO8quKT6+1+tN1XZadhlD
 LOl8bZDrfZvAp+ElYhwubo6P84GFTxpUTZWShhVnTmcvc4qmF5FhAVQ==
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr195120765e9.30.1782735372574; 
 Mon, 29 Jun 2026 05:16:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c3c1:20b0:492:4335:4d4c with SMTP id
 5b1f17b1804b1-492668833c0mr195120205e9.30.1782735372116; 
 Mon, 29 Jun 2026 05:16:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49392c991aesm131405775e9.0.2026.06.29.05.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 05:16:10 -0700 (PDT)
Message-ID: <79a38231-6ae5-437f-ae43-74707c928224@redhat.com>
Date: Mon, 29 Jun 2026 14:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/17] tests: acpi: arm/virt: update expected WDAT blob
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-11-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-11-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/24/26 12:28 PM, Igor Mammedov wrote:
> replace blank table with a new one:
> 
>   [000h 0000 004h]                   Signature : "WDAT"    [Watchdog Action Table]
>   [004h 0004 004h]                Table Length : 00000104
>   [008h 0008 001h]                    Revision : 01
>   [009h 0009 001h]                    Checksum : 3B
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
>   [018h 0024 004h]                Oem Revision : 00000001
>   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>   [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
>   [024h 0036 004h]               Header Length : 00000020
>   [028h 0040 002h]                 PCI Segment : 00FF
>   [02Ah 0042 001h]                     PCI Bus : FF
>   [02Bh 0043 001h]                  PCI Device : FF
>   [02Ch 0044 001h]                PCI Function : FF
>   [02Dh 0045 003h]                    Reserved : 000000
>   [030h 0048 004h]                Timer Period : 00000001
>   [034h 0052 004h]                   Max Count : 000927C0
>   [038h 0056 004h]                   Min Count : 00001388
>   [03Ch 0060 001h]       Flags (decoded below) : 81
>                                        Enabled : 1
>                            Stopped When Asleep : 1
>   [03Dh 0061 003h]                    Reserved : 000000
>   [040h 0064 004h]        Watchdog Entry Count : 00000008
> 
>   [044h 0068 001h]             Watchdog Action : 08
>   [045h 0069 001h]                 Instruction : 00
>   [046h 0070 002h]                    Reserved : 0000
> 
>   [048h 0072 00Ch]             Register Region : [Generic Address Structure]
>   [048h 0072 001h]                    Space ID : 00 [SystemMemory]
>   [049h 0073 001h]                   Bit Width : 20
>   [04Ah 0074 001h]                  Bit Offset : 00
>   [04Bh 0075 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [04Ch 0076 008h]                     Address : 000000000C001000
> 
>   [054h 0084 004h]                       Value : 00000001
>   [058h 0088 004h]               Register Mask : 00000001
> 
>   [05Ch 0092 001h]             Watchdog Action : 01
>   [05Dh 0093 001h]                 Instruction : 02
>   [05Eh 0094 002h]                    Reserved : 0000
> 
>   [060h 0096 00Ch]             Register Region : [Generic Address Structure]
>   [060h 0096 001h]                    Space ID : 00 [SystemMemory]
>   [061h 0097 001h]                   Bit Width : 20
>   [062h 0098 001h]                  Bit Offset : 00
>   [063h 0099 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [064h 0100 008h]                     Address : 000000000C000000
> 
>   [06Ch 0108 004h]                       Value : 00000001
>   [070h 0112 004h]               Register Mask : 00000007
> 
>   [074h 0116 001h]             Watchdog Action : 06
>   [075h 0117 001h]                 Instruction : 03
>   [076h 0118 002h]                    Reserved : 0000
> 
>   [078h 0120 00Ch]             Register Region : [Generic Address Structure]
>   [078h 0120 001h]                    Space ID : 00 [SystemMemory]
>   [079h 0121 001h]                   Bit Width : 20
>   [07Ah 0122 001h]                  Bit Offset : 00
>   [07Bh 0123 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [07Ch 0124 008h]                     Address : 000000000C001008
> 
>   [084h 0132 004h]                       Value : 00000000
>   [088h 0136 004h]               Register Mask : FFFFFFFF
> 
>   [08Ch 0140 001h]             Watchdog Action : 09
>   [08Dh 0141 001h]                 Instruction : 82
>   [08Eh 0142 002h]                    Reserved : 0000
> 
>   [090h 0144 00Ch]             Register Region : [Generic Address Structure]
>   [090h 0144 001h]                    Space ID : 00 [SystemMemory]
>   [091h 0145 001h]                   Bit Width : 20
>   [092h 0146 001h]                  Bit Offset : 00
>   [093h 0147 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [094h 0148 008h]                     Address : 000000000C001000
> 
>   [09Ch 0156 004h]                       Value : 00000001
>   [0A0h 0160 004h]               Register Mask : 00000001
> 
>   [0A4h 0164 001h]             Watchdog Action : 0A
>   [0A5h 0165 001h]                 Instruction : 00
>   [0A6h 0166 002h]                    Reserved : 0000
> 
>   [0A8h 0168 00Ch]             Register Region : [Generic Address Structure]
>   [0A8h 0168 001h]                    Space ID : 00 [SystemMemory]
>   [0A9h 0169 001h]                   Bit Width : 20
>   [0AAh 0170 001h]                  Bit Offset : 00
>   [0ABh 0171 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [0ACh 0172 008h]                     Address : 000000000C001000
> 
>   [0B4h 0180 004h]                       Value : 00000000
>   [0B8h 0184 004h]               Register Mask : 00000001
> 
>   [0BCh 0188 001h]             Watchdog Action : 0B
>   [0BDh 0189 001h]                 Instruction : 82
>   [0BEh 0190 002h]                    Reserved : 0000
> 
>   [0C0h 0192 00Ch]             Register Region : [Generic Address Structure]
>   [0C0h 0192 001h]                    Space ID : 00 [SystemMemory]
>   [0C1h 0193 001h]                   Bit Width : 20
>   [0C2h 0194 001h]                  Bit Offset : 00
>   [0C3h 0195 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [0C4h 0196 008h]                     Address : 000000000C001000
> 
>   [0CCh 0204 004h]                       Value : 00000000
>   [0D0h 0208 004h]               Register Mask : 00000001
> 
>   [0D4h 0212 001h]             Watchdog Action : 20
>   [0D5h 0213 001h]                 Instruction : 00
>   [0D6h 0214 002h]                    Reserved : 0000
> 
>   [0D8h 0216 00Ch]             Register Region : [Generic Address Structure]
>   [0D8h 0216 001h]                    Space ID : 00 [SystemMemory]
>   [0D9h 0217 001h]                   Bit Width : 20
>   [0DAh 0218 001h]                  Bit Offset : 00
>   [0DBh 0219 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [0DCh 0220 008h]                     Address : 000000000C001000
> 
>   [0E4h 0228 004h]                       Value : 00000004
>   [0E8h 0232 004h]               Register Mask : 00000004
> 
>   [0ECh 0236 001h]             Watchdog Action : 21
>   [0EDh 0237 001h]                 Instruction : 82
>   [0EEh 0238 002h]                    Reserved : 0000
> 
>   [0F0h 0240 00Ch]             Register Region : [Generic Address Structure]
>   [0F0h 0240 001h]                    Space ID : 00 [SystemMemory]
>   [0F1h 0241 001h]                   Bit Width : 20
>   [0F2h 0242 001h]                  Bit Offset : 00
>   [0F3h 0243 001h]        Encoded Access Width : 03 [DWord Access:32]
>   [0F4h 0244 008h]                     Address : 000000000C000000
> 
>   [0FCh 0252 004h]                       Value : 00000004
>   [100h 0256 004h]               Register Mask : 00000004
> 
> Raw Table Data: Length 260 (0x104)
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/aarch64/virt/WDAT.wdat      | Bin 0 -> 260 bytes
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 135186b40b..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/aarch64/virt/WDAT.wdat",
> diff --git a/tests/data/acpi/aarch64/virt/WDAT.wdat b/tests/data/acpi/aarch64/virt/WDAT.wdat
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..d5adacf9114637d8803d08906ff1e29ac61f5fe0 100644
> GIT binary patch
> literal 260
> zcmZXOK@NgI3`O4vF`x@byg*$Mjv=^kCkZBU9awQJZ&p(1B&bcAwm<K;ecx}dG(f1E
> zXZz@-8M;<PBmmZ16+lr{z~)btGhbi?GEanrk^*Op%cs@+r=JYk@zHbs;iGQ%_k0R#
> Y9+OSa{H}$nYB)I0_dnOT-}Sg>0T&h&0RR91
> 
> literal 0
> HcmV?d00001
> 

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


