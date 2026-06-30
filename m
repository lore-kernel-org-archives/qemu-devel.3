Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C2FC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYHz-0005cI-FK; Tue, 30 Jun 2026 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weYHn-0005at-3g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weYHl-0004b7-LE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 09:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782825237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fxDeuFtAamJnUx68ai6yqnwyLW2L/ImIpa9F1jTftA=;
 b=UjapWvJlnTomMEyrB1OMOJnTT6gvxFOvdlrr5F4RsnyXpp5zUOa/niUJG0tnYv/ie/6el9
 mDZdhib4dVV9qPJNtBgWbQvATmrUZtUqGwVmhhQsIcUeQ+Q5LkOY+5TqWHNyO7diwmud8I
 Zs76pgnYTHzesHz5VpK1teSdAX6ni2k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Pdd7xFltOUa2om0Bw4ZTPw-1; Tue, 30 Jun 2026 09:13:55 -0400
X-MC-Unique: Pdd7xFltOUa2om0Bw4ZTPw-1
X-Mimecast-MFC-AGG-ID: Pdd7xFltOUa2om0Bw4ZTPw_1782825234
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493a5d7eaedso21199465e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 06:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782825234; x=1783430034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fxDeuFtAamJnUx68ai6yqnwyLW2L/ImIpa9F1jTftA=;
 b=Tdh07cUk737xgV58TOlNcT8KU/4gJtNcPD7ci86OVLU6ulpTu+SnayxcruEzWr78+Q
 CXmSQLMmsoIKzUCZh3/42K+VM9J/k1YBtEUACKepFAGHkLohIltPPj7RsMgT5XYCHn8W
 ivn+JEfokxU9P/gxSrCLqQGlD8LW/POO+Z4Vey8QN7lzGxzgTMm4Cv/xrbaWltSwWdbf
 TJ/4FStExEXNJ6pSem9YlJKRcOkcTntEc4RYhXJnsYIjo+IGfalu8Yr8XXxlvKeswgPq
 75lfamYgtxYUpmvmVx5zS4tdWrnAEGcVe8asdmbojK8tTPJvhZ3gdva2L3gPBxgdfleX
 9h1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qr7/PsM9KmdZiY7ajPH/JlCRJKhFy/GWv5Imhp6o0fwJQp1Ch+5ZLeMcz8zmD514acYkkeqIO9cCy@nongnu.org
X-Gm-Message-State: AOJu0YwcIoMiuuozCBxy+n4dB08LX6SNzeyaADxjGRB6b1vIt9L0RFOW
 qyyD7Cy3bpzIeAOmNZnc1Swwie0uAVfwVKsjWW3ObhK7UVgUCh/fmFITKmis7cbkz/ikx+6r60r
 CxVxPWGfxbpXk76u71aQwdiusN2WTOVE+qJdSSPIENIJ5aBExCA/+R6y6
X-Gm-Gg: AfdE7cnMSxamcLD4RTJCrkZXaqEVaC3+VkGaVk+RjCdcuyGl352BRSGhBAqMlunD772
 jFscIgnsdr99Inkkinem+Ej9uKrkodtf/h0dTXACs1eByeOanahKIxC9tdUHfqYtaz4ThS0AJwL
 MfZFao8aPAYZxQKjwjyh1FYlJNjvXWdwB5lucEG4v79o3u/hFw++lZMRstXMgiHsI9NI4n8jLq0
 yBD9We7IJID+LG/wOy6i1gpmarXIRMss9j93CUL9ri8ukXU7u5IcXf9fCsWWaZGD3R1+UP5KkSH
 6yxs3NbzdU/2JQJkvuJMVPzATOnInI2OEOvJXUb+d4PR5GfoxVRMEwS4MixoNXlgr9jyJQhH7oh
 qZOUjy6ZqlkmAjf+r8dJx2fj8uWATxKR1WYfwPuasXmRRVTjm6MDvtMXZUyQ=
X-Received: by 2002:a05:600c:8b71:b0:493:aaf5:6e04 with SMTP id
 5b1f17b1804b1-493bda4ae27mr9082545e9.15.1782825234240; 
 Tue, 30 Jun 2026 06:13:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8b71:b0:493:aaf5:6e04 with SMTP id
 5b1f17b1804b1-493bda4ae27mr9082245e9.15.1782825233830; 
 Tue, 30 Jun 2026 06:13:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cd303csm66624125e9.6.2026.06.30.06.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 06:13:53 -0700 (PDT)
Message-ID: <a034d5c4-02a5-43a1-b453-2c1dec59a5cc@redhat.com>
Date: Tue, 30 Jun 2026 15:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, skolothumtho@nvidia.com, nicolinc@nvidia.com,
 nathanc@nvidia.com
References: <20260630083042.2692392-1-eric.auger@redhat.com>
 <20260630083042.2692392-3-eric.auger@redhat.com>
 <akOJ8SNPV_I48tD_@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <akOJ8SNPV_I48tD_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/30/26 11:18 AM, Daniel P. Berrangé wrote:
> On Tue, Jun 30, 2026 at 10:30:20AM +0200, Eric Auger wrote:
>> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
>> emulated SMMUv3 MMIO register interface. Currently the value is
>> not checked.
>>
>> The SMMU spec says: "Except for readback of a written value, the
>> effective LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of
>> input StreamID range checking and upper/lower/linear Stream table
>> index address calculation."
>>
>> So for STE lookup make sure log2size is capped at SMMU_IDR1.SIDSIZE.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
> Can you add the "Resolves: bug URL" to the commit message so it
> gets auto-closed on merge.

sure. Thanks for the hint

Eric
>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0a8d2fbb6a7..db5aca26ec0 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -672,6 +672,15 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
>>      /*
>>       * Check SID range against both guest-configured and implementation limits
>>       */
>> +    if (log2size > SMMU_IDR1_SIDSIZE) {
>> +        /*
>> +         * spec says: Except for readback of a written value, the effective
>> +         * LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of input StreamID
>> +         * range checking and upper/lower/linear Stream table index address
>> +         * calculation.
>> +         */
>> +        log2size = SMMU_IDR1_SIDSIZE;
>> +    }
>>      if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
>>          event->type = SMMU_EVT_C_BAD_STREAMID;
>>          return -EINVAL;
>> -- 
>> 2.53.0
>>
> With regards,
> Daniel


