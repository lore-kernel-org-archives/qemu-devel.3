Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E05D132D3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7y3c-0005OK-P5; Mon, 04 Nov 2024 09:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7y3J-0005M3-W3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7y3H-0001Tf-MR
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730730450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTGEwhCT8hhD7r51rSqL2rFj/gm7aU24XxE68FPJ2XE=;
 b=UuHFKCt7hCbURvVipAdMWGfH1QaDu2NWlO0JB47ABQPcrdESGVI2cGPctyJ8i8wOz4IYIw
 VEVA8asktYoBFOm7FDJhfFacwaJoTFBxjlCB0wCdNWQIqOIQicW1AIQHVdGEbyGksYxNvG
 Ujkl9tUSOC/J2xu9k8+BYX6nzV+i+JE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-pdUIyYoBNPmfr924xJLQ3g-1; Mon, 04 Nov 2024 09:27:29 -0500
X-MC-Unique: pdUIyYoBNPmfr924xJLQ3g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e4b7c8f4so2982938e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730730448; x=1731335248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oTGEwhCT8hhD7r51rSqL2rFj/gm7aU24XxE68FPJ2XE=;
 b=PyaE1qsfa+Asd6vXwoJ65ThWr+PTj6Hnt3mWWwJDtpSv8Rcia8kqYFDPTNs/IpGW0D
 AOrsoSLdqzxT8uDLVLSkVHpchIaldGKoZQ3iZDdMfn/3vY7EMeFcJ5da3ZuiXyVdL/uH
 ypmw6plu5k9dAd7lbgCTEfeN/caRWOIOa3gi71Yx0SDkoN70HxNgqwk/cmLK1Qn0UABf
 QlOZF94CISINy3l95jyjpQ5owcwEF+FaInITcVsH19vP++4Yk6dtnQhjyvUk7+z+z/HB
 66muSwDKsNZBH2P/oGMi6woQzz+kSoOtZyVVgi0KTqeBe/i+mN9AI0HLgg8r2OeyMqR2
 tgvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgnVEaKRVJrzoRSSWYCvMYisKVMLbL4FRIDjCiq7iG3GBiDx+ng2Oc7R9LXmD7yVg1UXI6pMkQIxkW@nongnu.org
X-Gm-Message-State: AOJu0Yx55Fs7rOWYD3HkyFauF8+wJmBIOHEZKAS32Xh2dC45pD+cKOKq
 aDhpPxqW3KF8PcGGv0wuvF19uxSd42YbkZKN2RPZmsl2AjxQq5kKBcSESr30I5YhNq+Wg3bTa8Z
 k+LInHJHEYhTmAE8DzJEihfghtePoPbeI4tqq98svix8iaW212SPE
X-Received: by 2002:a05:6512:1590:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-53b34c5f77bmr15041804e87.39.1730730447676; 
 Mon, 04 Nov 2024 06:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhFA2XdRNordUGlHR6vowAO+4EIFUogyl7A57fA3uxb9QO8/Vzuy4zcATr3jt7aE+WyQzBtg==
X-Received: by 2002:a05:6512:1590:b0:534:543e:1895 with SMTP id
 2adb3069b0e04-53b34c5f77bmr15041771e87.39.1730730447145; 
 Mon, 04 Nov 2024 06:27:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abf3sm13362914f8f.101.2024.11.04.06.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 06:27:26 -0800 (PST)
Message-ID: <63c232c2-a325-48d6-8ed4-753a7c6e3b4e@redhat.com>
Date: Mon, 4 Nov 2024 15:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_EGxj2aqc_2-kY@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Zx_EGxj2aqc_2-kY@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Daniel,

On 10/28/24 18:04, Daniel P. Berrangé wrote:
> On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
>> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
>>>> On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>> On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
>>>>>> On 10/25/24 15:06, Daniel P. Berrangé wrote:
>>>>>>> Also, is this naming convention really the same one that users
>>>>>>> will see when they look at /proc/cpuinfo to view features ? It
>>>>>> No it is not. I do agree that the custom cpu model is very low level. It
>>>>>> is very well suited to test all series turning ID regs as writable but
>>>>>> this would require an extra layer that adapts /proc/cpuinfo feature
>>>>>> level to this regid/field abstraction.
>>>>>>
>>>>>> In /cpu/proc you will see somethink like:
>>>>>>  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp
>>>>>> asimdhp cpuid asimdrdm lrcpc dcpop asimddp
>>>>> Right, IMHO, this is the terminology that QEMU must use in user
>>>>> facing APIs.
>>>> /proc/cpuinfo's naming is rather weird for historical
>>>> reasons (for instance there is only one FEAT_FP16 feature
>>>> but cpuinfo lists "fphp" and "asimdhp" separately).
>>> There's plenty of wierd history in x86 too. In this
>>> case I might suggest just picking one of the two
>>> common names, and ignoring the other.
>>>
>>> If we really wanted to, we could alias the 2nd name
>>> to the first, but its likely not worth the bother.
>> Or we could use the standard set of architectural
>> feature names, and not have the problem at all, and not
>> have to document what we mean by our nonstandard names.
>> (cpuinfo names do actually mostly line up with the
>> standard names, just not 100%. Similarly gcc/clang command
>> line options are mostly the architectural feature name.)
> Ah, right, yes. Sorry I mis-understood you originally to be suggesting
> the same low level names as this patch.
If my understanding is correct, Peter suggested to rely on the
terminology used in

https://developer.arm.com/documentation/109697/2024_09

the doc pointed to by Oliver.

So I think the next step is to understand how those "high level" features do map onto low level ID register field values. I think a high level feature can map onto separate fields in separate ID regs. This may not be the most common case though. 

Thanks

Eric

>
> With regards,
> Daniel


