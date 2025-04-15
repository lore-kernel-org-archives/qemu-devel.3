Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0335C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4h8q-0007oZ-DO; Tue, 15 Apr 2025 10:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4h8j-0007a1-Ks
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:19:57 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4h8g-00058V-H7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:19:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so676190b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744726787; x=1745331587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=raEG3kX+Qy4bzv6k4Hc1I+Zs+er638cBPXUP2pO60AM=;
 b=rmg8xnS6bISldQ+GLRoHqZDxandeoiyA+7r8xmhkyFZerI4twdmC7yKvcy3BtbXV5J
 qXXmO/FoxTaLeUSiEqQPSUoNZKJYvd6HCnHQH5QCWkQXKpLo77vbKQIY6aIjJMPjKWlv
 AY0HilyVwcSesP3nodXZgjcqTXFYYnrVnfSdaTLeyXh7OiUAXU/iiM8+oIUXkjYfz0Ti
 EzBCh9wRDjDxrWkwVzKKINPhKSbI+Pj3l+TmVK8ni6A7NgseeG+sGsTApWjJuEDr6DVw
 lg+9WRNMF7Y3Dm+qlOeLfcCxMZqKcxjA0GfUK4WwO74iyrnr+iEQmonGjof5NaL39SwE
 c2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744726787; x=1745331587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=raEG3kX+Qy4bzv6k4Hc1I+Zs+er638cBPXUP2pO60AM=;
 b=W4ZCqef7QGPVstRdeEp+OIBLiwSpnX8+6j1CSVg37AboBeksQugZC/3yzizecWbp2C
 62aa/eGceSAR22Dp+7BCtxjPbGc5Ia2Eh5fIYwtP0yDPOI0f8PUAPKB1aaxESQjprl8+
 bthBgQYrOxuCWEFcQK6HSVCVzZQE8INP68vh58wJafyBCcvG8ogOlRRPYSyEWZL55z0R
 Hy14R59/bvxF0aZHRiCPQj72i9WEt2AbYektuT+HmB/SUQEDadPKLq5w6LXP8rab2Ss/
 FpybhhvrQ+ItaVuyVU0pPNs/YTVVUUiowN0JTjnS8cB+OU7V3fW+dqdrimsBUldHUTaj
 46sQ==
X-Gm-Message-State: AOJu0YyH0VAxZO9EqEZoElFxalmCuyt8SB0quIzbXKjthJWCTyBUYNcQ
 rzttZclOqt+f+pO0yv9y430oN/zm/jii45G9He8R95MXG2Z5p5Hgt13qWVvxoNX9CjYIdAc4Aaq
 Y
X-Gm-Gg: ASbGnctKkKNyVtMYhSF/al1Nlr/OT8/uQSqE9iTVZR2skE3X4+rRI28pUB9x87BMD3m
 TZLSrOhUCB+ipg+Y7BIAHjaZG85vtTiQpkkA5nNxc5dxBX1snR4BbT71rXSZ8glJRPESia+6saw
 TkEnM4R3n7+iN2BZ8PcbtQ+0pe8sin/47ejhZS9TOg7ahNqiqZx0iD4wGWYwVB9KOPth3w4qTa0
 8yATUR6Y8bojgt5f/3GrhNhFCUZkBb49viaDP8JJmoL1lPevruS1P37jLxrgEbTYALrp78OL6yl
 We2OFQkIaR/UcPSfomgd+hEn2aaGJZ2jmnZduU48ypyPD/pJaiVIgAg0jLtF7eeS9rGR2WTHGsN
 6LrOaQr314cBaGuDWUw==
X-Google-Smtp-Source: AGHT+IFNM4jbD3p77Pa3QeA0MBWptqDza+WQAAsPhhslGHx/6TqTeQNodU29EFVi5FFBz2LBJ3910A==
X-Received: by 2002:a05:6a21:158e:b0:1f5:9d1e:4e32 with SMTP id
 adf61e73a8af0-201799749fbmr25376126637.29.1744726787413; 
 Tue, 15 Apr 2025 07:19:47 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b02a11d2f78sm10992244a12.44.2025.04.15.07.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 07:19:46 -0700 (PDT)
Message-ID: <0d08036b-0b9f-4a8b-8ffc-fa57aec19be7@linaro.org>
Date: Tue, 15 Apr 2025 07:19:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] include: Add a header to define host PCI MMIO
 functions
To: qemu-devel@nongnu.org
References: <20250414213616.2675-1-alifm@linux.ibm.com>
 <20250414213616.2675-3-alifm@linux.ibm.com>
 <71997461-7470-452b-9df1-3efa6d6f68c4@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <71997461-7470-452b-9df1-3efa6d6f68c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 4/14/25 23:43, Philippe Mathieu-Daudé wrote:
>> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)
> 
> Is it really worth inlining?
> 
>> +{
>> +    uint8_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_8(ioaddr);
>> +#else
>> +    ret = ldub_he_p(ioaddr);
>> +#endif

Since the non-s390x path is a single byte load, yes, it probably is worth inlining.


r~


