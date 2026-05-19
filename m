Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA79CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 11:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPICk-0000m9-5a; Tue, 19 May 2026 07:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPICb-0000kF-8K
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPICX-00033H-Mw
 for qemu-devel@nongnu.org; Tue, 19 May 2026 07:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779188488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Ejoitg6tNWT22lI6/y1nFQ95G1vWx/TTNxFeaaLoX0=;
 b=LZ4boBeu2pLdGCK5neO0UEY/M5e0qQprGAyvIfhVNZj2jmcOpXT2mh6niLzCGNZdE8/cGz
 yTX0hPVX45hHhSiD6jkfxFieY92w4znh0ta0VQ5yNcu37/wDWZcJVYSv9u0RPaosK9ZPqf
 epx1eoDzYdbf6ynLoA0pu2pHiX9U6Y8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-t_2nxOVCNvueTaI1ZI2OCQ-1; Tue, 19 May 2026 07:01:26 -0400
X-MC-Unique: t_2nxOVCNvueTaI1ZI2OCQ-1
X-Mimecast-MFC-AGG-ID: t_2nxOVCNvueTaI1ZI2OCQ_1779188486
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fda34ed0aso13267735e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779188485; x=1779793285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ejoitg6tNWT22lI6/y1nFQ95G1vWx/TTNxFeaaLoX0=;
 b=oDMyYF4kQOcrXEvHb3Bl+ix+hkod3453AwSITNy4/RyZSgYMnq9O57UFOxOndNdD5X
 uBoWzw+1MXrlEgfZlQ3+tkI8fLoxtWYI3oLjbUO6sKA7fwAlhlkEZ2TmXwtfZJOP6rbn
 F34HHHWJj8wfc//n+JLngdFnutAFyV/oCTjAebJWwAnTv4vh62ZiBpyZYvjN004v8EKm
 MqV3Uae40PfevbJPc8pIuS1Ntul2qeSluB2jENfTBy8Tyvc/M7TdA4G1YGrwYzpnYvoJ
 kv7FaFcD9Xu2wqCOTru6oETBYoIahwAaZG0RS5cHgx2hrRSeLhcaW90SlVDFF6K9Fmgh
 89kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779188485; x=1779793285;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ejoitg6tNWT22lI6/y1nFQ95G1vWx/TTNxFeaaLoX0=;
 b=LcBktQ8SxK0/20Evpa9+qZS/Z5wu7dqLD8JsoWRyq0y0ENH9f8T/jyROOOj1be8y2M
 Cmgo56dTNPbVpRw53ZUZS7u9RvKIDy/OXwacHuTOf4fQqhH2jqGvach9EN7ggLUfNh2O
 fvW1wpzp99piCR71q9wNTFcRitWe6IU8iE0/s4PjsiZ+Rsig5pwS3WXT4FT6PdX+rheT
 +o1t9oT6yCgtNDq56fRUneyBWoO8v1vut3ldRvF8Y1dD8Bq2nccPQ68+4mDQjmI8Vd4l
 TV9lRFAxkQPbd4eDw2HpG0MnwLzGWcECZD020l5Oqup8NOH1B94zfOSKNjrEJ8oO8cyJ
 TEag==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VtV2l5hb/UWoP0PHYJVOpBH+J2E9CiWXqpvKzjJTRTygH+eH4g/KYHvcBFaCv63gFQNZhPHI03ObQ@nongnu.org
X-Gm-Message-State: AOJu0Yx6R+VWzoCUYRW/r9FinoWljtgprxMAPWGauXv8ofCNL+CiqSiN
 xnQuf8V4MwfmJUnRaLJrg3tFKXIDtg9fbyP+tomZYefOJa83Y2l4GzNVBJ+Gq0xI/kO5IND9rTl
 2+175UWHeO8m4nYyjji8A0OiCYj62BcAlExT24dccDOaQTn2PdeQr14i2
X-Gm-Gg: Acq92OE38DiUVZG1zsJ8II93eM5fM13FEB40GsTGztTgBEKTYP5Vz73RzNRGP0eZGmZ
 6cLyByoUBQsabK0EfxaBEKpjrihDAUHwWR5theejNB5d9YeEefxSoLq9a9Xyg8uIdRGTsQQGuUi
 y6WFS4wQe+8+A+x1e2J8+RpY2EiDFpkQJbGn1P2c0wArHI40hPPSA146u80wmJxdsLtdjeREDI0
 7faS+3v4tGYgQ1PIN2bZ54GaoIGF3XlRN2N+jfT9tVYz4qUYc7mWxT+YKCLrR8utbtlfVY3m07a
 xOZ8gll9i8vumVmkG6xXJSa1cXwgAQxqg5q/ku2C0+WLwa/ftXYB4Yux2Ksc29ZiPelkVxYVZFL
 VjFz9Su30lNxbj7gvQ2EEcLQlmQhBJIc7JPKTQbAZHSPR058=
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48fe61ed21amr311757065e9.20.1779188485658; 
 Tue, 19 May 2026 04:01:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48fe61ed21amr311756545e9.20.1779188485240; 
 Tue, 19 May 2026 04:01:25 -0700 (PDT)
Received: from [10.33.192.243] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8344asm541645845e9.1.2026.05.19.04.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 04:01:24 -0700 (PDT)
Message-ID: <f246df1c-aaa1-4c64-8c40-c7bc5a0339f5@redhat.com>
Date: Tue, 19 May 2026 13:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/rtc: Fix a possible year-2038 integer overflow
 problem
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>
References: <20260518160255.1844308-1-thuth@redhat.com>
 <ags5_IDkvxClCdHm@redhat.com> <ags7xIsUG2DqX5vu@redhat.com>
 <dbc6464c-2685-46c4-803c-6af53d345083@linaro.org>
 <c9fa27e3-0939-4490-b350-7a625ebcdcdb@redhat.com>
 <b70b35ef-1761-4624-9f98-7c1ae161ed9a@redhat.com>
 <CAFEAcA9JaXVTNbAXbaTDM-bN=HEZHEX6+cDLiTx8n2=Di04LFQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9JaXVTNbAXbaTDM-bN=HEZHEX6+cDLiTx8n2=Di04LFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/05/2026 12.21, Peter Maydell wrote:
> On Tue, 19 May 2026 at 10:27, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 19/05/2026 11.18, Thomas Huth wrote:
>>> On 19/05/2026 10.24, Philippe Mathieu-Daudé wrote:
>>>> "32-bit *host* OS".
>>>>
>>>> Per ./configure script, we still allow:
>>>> - x86_64 x32 ABI      (CPU_CFLAGS="-mx32")
>>>
>>> We should maybe deprecate that x32 ABI ...
>>>
>>>> - sparc32             (CPU_CFLAGS="-m32 -mv8plus -mcpu=ultrasparc")
>>>
>>> ... and that one as well?
>>>
>>>> - s390                (CPU_CFLAGS="-m31")
> 
>>> Uh, we really still allow 31-bit s390 hosts here? I think this could be
>>> removed nowadays, also upstream kernel recently ditched the 31-bit userspace:
>>>
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>>> commit/?id=8e0b986c59c67e08ada646249f834655a9e6da16
>>>
>>> Question is whether we can remove it immediately, or whether it needs to be
>>> deprecated first?
>>
>> Ah, wait, we completely disallow disallow 32-bit hosts nowadays:
>>
>>    https://gitlab.com/qemu-project/qemu/-/commit/372ec46b9f1215f48a4717f2b7ed969f65bfadc6
> 
> We relaxed that check before the 11.0 release in commit cf634dfcd8fc.
> We require a 64-bit host for the emulator binaries but still permit
> 32-bit host builds for the tools.

Ah, thanks, that was the part that I missed!

  Thomas


