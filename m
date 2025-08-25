Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259C8CA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 13:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqXES-00037A-Jj; Mon, 25 Aug 2025 09:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqXEL-000348-6s
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 09:27:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqXEG-0002BQ-7z
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 09:27:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c980bd5f48so843683f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756128436; x=1756733236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRTA+yIPBBUOy9tQ0E34i08KMApm/Bzb7hSUwOavlfo=;
 b=s0BfN/qQkewY9ovmHp9IESJUniIm1qkKX0sU/M5ebFXJkInyvgoIFIvQBxV8d6n/iZ
 /5qlDQYcOXPE7lKnpwVSbltyHv1ZFurNxSa3R0T4+R813QceF5hnKNYS0Sg7c2zKyRuv
 AAAcTiI8suOEIkJoRFdjmLDfvuwvhxDroDAzefFldcLULfSHiXE7ebp8k/wLXm8l8Pb8
 TmXtCykYwBFRGJycYpBEOZTZbMLnozVOEXnajS0TtzRJssvLt81FxTeSV33hSPYAeAq1
 Z69rwEValNl1fCIwN+dDFuV+UEhM3/l3VHmOQ0kSK6Ugd9J074otYKaPmPVeZOfVg1z8
 hn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756128436; x=1756733236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRTA+yIPBBUOy9tQ0E34i08KMApm/Bzb7hSUwOavlfo=;
 b=w0ecrlGxpLE57U55klavLCDvhPi59zoDW/g1jbg+DMs/aqegfcJcAPrc1wqOIZgvt4
 6XAwXL/hOsD4TOvavhEe3RC7zVetXY4WcKtWZT78UWJz70nZ6FyjmUW9jpgWCuhqcm5F
 gS8wb9HV+sBk8zTtIt+PuS2hq7hM7El79fyKv8tYyb8j6NmGUWZHjtw1gEX0cwdiX1po
 dC2RDlGMNBuBIbGc3zsp6YViIXJyODw+3LfCRM10CoHI/a461d2utgL6wlb8HNn0QsdI
 4PEtb59OGkTKO+UVB/hx0VTX7z5S4PzqXO8C6oaHMQYg2aai94pXehUnSBb4LYoMuGwr
 n8dA==
X-Gm-Message-State: AOJu0YyJkCTtnH+0flezwZdZ786gSeSU/xitm7rIQFAqsxrwcAJxAZZ0
 qc/BVT59S5YLuvzSHwRJ7V95xE0hR2PHnyzf/MZn6Rs38wUuh9pvrsEwe6ok25m+mZ4=
X-Gm-Gg: ASbGncuEvr/1DUd1cDurxcgQjvAL4SJ9bdV0PRjUiqLpJ6Uws6lL7nN9g3unzqgzGZw
 /htLdvMHh94WtcDxIect1GJJPSPcxsO9NftVzQwe9WFU6FaZelntek54fBUM0VI/e0N4kPw8g3Y
 7Mm5GGdgYclDFB/TPg6N/9w9c4lIIayM/8D/SAXPtW0kdqHF21Y869aBDmRCTK17MLN7R+RHiT5
 EXzrHjyjvZh6K5D5wV5lSZNISVYd/Z7Tzng5eL48GupgFirunmnCPaJt/duXPh4EK2lHEcCjwCL
 toPU6Y7iwoJX8tgabA3r93JrnazjQRkfsqxA2rcGnaTeBLujsQ+6BxQmyCibxSHMMFvUTAuCyQe
 NqH2445Lr2r3NilPjLFTtOpK+AbwAfroA3zuQMUXlLM25YRKnSpxesYFeZhctxPzIqQ==
X-Google-Smtp-Source: AGHT+IG44M2dD9dT5IaQHP94lCmozssD0u2o8VyPbrauqwTQyiGwqIc5tn8CQjXqSSLAAto4qyHYnQ==
X-Received: by 2002:a05:6000:2504:b0:3ca:3206:29f with SMTP id
 ffacd0b85a97d-3ca3206073cmr1999019f8f.40.1756128436082; 
 Mon, 25 Aug 2025 06:27:16 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7115ec8fcsm11639596f8f.45.2025.08.25.06.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 06:27:15 -0700 (PDT)
Message-ID: <2de22a4d-3e09-466a-ae66-e07c77c9532e@linaro.org>
Date: Mon, 25 Aug 2025 15:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ebpf functions can fail without setting an error
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <87ectns27j.fsf@pond.sub.org> <aKRWZwvbWzA0QbA_@redhat.com>
 <87sehfsife.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87sehfsife.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 25/8/25 14:19, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Thu, Aug 07, 2025 at 03:14:56PM +0200, Markus Armbruster wrote:
>>> Three functions in ebpf_rss.h take an Error ** argument and return bool.
>>> Good.
>>>
>>> They can all fail without setting an error.  Not good.
>>>
>>> The failures without error are:
>>>
>>> * All three stubs in ebpf_rss-stub.c always.  Oversight?
>>
>> Opps, yes, we really should have added error_setg() calls for diagnosis
>> if someone tries to use eBPF when QEMU build has it disabled.
> 
> Some stubs exist only to mollify the linker.  They are not meant to be
> called.  They should abort(), optionally with lipstick.

When a host feature availability is known a compile time.

These should be guarded with a if (feature_enabled()) to allow the
compiler to elide the call, thus removing the need for stubs.

> 
> Other stubs are called and should fail nicely.
> 
> Can you tell me offhand which kind these are?

When a host feature availability is known a runtime.

> 
>>> * Non-stub ebpf_rss_load() when ebpf_rss_is_loaded().  Are these
>>>    reachable?

meson calls:

   config_host_data.set('CONFIG_EBPF', libbpf.found())

(even QAPI uses CONFIG_EBPF, see qapi/ebpf.json).

The user API is via the 'ebpf-rss-fds' property,
evaluated in virtio_net_load_ebpf_fds() without returning
any error when 1/ ebpf_rss_load_fds() fails (due to real
error or no CONFIG_EBPF -- the stub).

IMO if the normal implementation function sets some errp,
then the stub must also set it ("feature not available").
Otherwise such function shouldn't take an errp at all.

Reasoning valid for:
- ebpf_rss_load
- ebpf_rss_load_fds
- ebpf_rss_set_all

As the name suggest, ebpf_rss_is_loaded() shouldn't be called
when eBPF not available, because ebpf_rss_load() would return
an error. Not reachable.

Unfortunately ebpf_rss_init() doesn't return anything. "Feature
available" and "Initialization successful" are different cases,
so having it return a boolean isn't really helpful. I'd have the
stub assert if reached, and check the feature availability upfront.

Declaring ebpf_available() in "ebpf/ebpf_rss.h" as:

   static inline bool ebpf_available(void)
   {
   #ifdef CONFIG_EBPF
       return true;
   #else
       return false;
   #endif
   }

along with the prototypes, would allow the compiler to elide the callees
when not available, removing the need for various stubs.

>>
>> This scenario should never happen, and we should add a call like
>>
>>    error_setg(errp, "eBPF program is already loaded");
>>
>> to report it correctly.
> 
> Is it a programming error when it happens?
> 
> 


