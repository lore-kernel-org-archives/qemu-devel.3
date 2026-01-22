Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8183C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viroE-00025M-KN; Thu, 22 Jan 2026 05:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viroB-00024R-F5
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viro9-0000n4-7C
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769077255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tPfYmGzEXirxtwkfATh3Dk9U8JU6CQPXfb1UZsbWegc=;
 b=BY4gG/73IHjKlOfGL3yUME8AIpz4ElswBZwE6Ksq1/mXCEfpfR9/iQnSQuEZP8UpEhYGk0
 wjgPqyg1cJhZDvr/3r1XYJoaNuSKsNQn6HSm6rxzYofb2BojbtBYmPe/bgVnHTiBAAqgp6
 iveM6fpnWB3t/yZ6GWIqxIPA8yKMjAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-1P_xKNaFPYWPeDPSKGgHCw-1; Thu, 22 Jan 2026 05:20:54 -0500
X-MC-Unique: 1P_xKNaFPYWPeDPSKGgHCw-1
X-Mimecast-MFC-AGG-ID: 1P_xKNaFPYWPeDPSKGgHCw_1769077253
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso6421605e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769077253; x=1769682053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=tPfYmGzEXirxtwkfATh3Dk9U8JU6CQPXfb1UZsbWegc=;
 b=bdAqLY+s71PwS2/Xvz+hJRUDNP6MNbMDzXz10JcfMxy8/qeC7ET7lyqPGBEfO5T4jC
 rGKfnmY0JiDBJE14m5V6PNzaoIqmHkq2lVndejP5owoYvdorIT8BII0sP+i/0KL5jMdi
 gGP97wABimnPVFbiGPtygE81BeoDDxx2gu745JS/hUpDFv1U8o6Mqv6fj75hyzvOxVp3
 hx+dwmmhB/zVzLAiflMrT7Nw0aAMTrB9LgwdwHFDVqdzGDWBHfWI6je7dG62dbPwZOxf
 fuoMbibSPtxXlNUXMGFQmmBM/e+s7IZ/7//wEsnEWbvmocLe+MIWIfMjNHWfOBq9D+Kn
 uYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769077253; x=1769682053;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPfYmGzEXirxtwkfATh3Dk9U8JU6CQPXfb1UZsbWegc=;
 b=lFe/+JUB2PPCOa8JT+/GCtSWlm5fD94c31f4LsJFL3s0XAlIHkNOG6cFCRp3nx0XYj
 yvUUfpprTrpRNcUPsmCdTrm5gt7zethMY5T2RWdzdpMDCWQotkKOcRkdOpjzS//YZR4y
 mPXsKbKG2GtUEaeVWnvVdHC3fiu8SVnwRG4MOjAf7iVjhtmqFOUL2zZpKdmVDfs4gPvO
 jOwqEL/w89JoXlWAqtOMDLoSq6bEDAy/Yd3FzUZW/qyGnRxCGsG/qDuOct4+fftL85CH
 7RVD5Bh4AqkY7AgyS/bPoeYENDkj/q2lyVvbUFDNzzgrv3/ka5Z4NAXA1HeUOhFspHnT
 B2Ng==
X-Gm-Message-State: AOJu0YyqmV0EmLe9VkYK5m2BrAh/0VCVZxOpdVmcuCoubj42V6kU+Zjs
 1gpyhTAf1dPiMvd1R0Ng8RQfQpdNgUK3+D2nzugt5JuP0uW9CWVetp44pUiv9Y8+zOSQsAyhM6r
 WxG5F/ddesz3Cs12Ogn04Tms8m2YFjLeNbtMd+ds7lcoBQNLQP9M2aVCR
X-Gm-Gg: AZuq6aKiegHzorvom7ihgl+n4PKMUqhNBYrXh+dJDtrJkbxzQ4b5fJEsUFJmLUTIbBC
 SmMflBAZ43ZlhcRFWrKg04QYKoDtXRKizPuAgdoBnbjdho5YQ4ca2+CCjY4YqVgC2H7JBQJ+vxX
 Avwqe4RdPbqYL6s018iZLQo/9mKAtMg48IxIbBj+EHUdawrJksQdrS6h5XRcQiGmGMAMxZRyoge
 FkTRQoe1JhuH7usP5nkhi28pgZuE27+DCvY/0Nvdi/hhp2gWQwQ2pYD/qN6vOobr91K8vVz7DJ9
 DPqb0jkwYCDO6e1qfN+QNJzCFKg0ABPrzjKAU89B9Wf+C0YeJg/lZUPoL4pAvK5cWgfC3eeMjlc
 FbakSTtg=
X-Received: by 2002:a05:600c:1554:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-4804b5d0a5bmr6991825e9.33.1769077252725; 
 Thu, 22 Jan 2026 02:20:52 -0800 (PST)
X-Received: by 2002:a05:600c:1554:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-4804b5d0a5bmr6991405e9.33.1769077252251; 
 Thu, 22 Jan 2026 02:20:52 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm39650775f8f.30.2026.01.22.02.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 02:20:51 -0800 (PST)
Message-ID: <832432e2-1f02-443d-8708-95ed5d7882bb@redhat.com>
Date: Thu, 22 Jan 2026 11:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20260122090352.9901-1-thuth@redhat.com>
 <aXHtxBfuIRsJ3P_M@redhat.com>
 <CAMxuvaygPAOJiZcRCZ=W+Ly=b8Nq9L1y2sRtraz_+hfiXwLVvQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAMxuvaygPAOJiZcRCZ=W+Ly=b8Nq9L1y2sRtraz_+hfiXwLVvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/01/2026 11.11, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 22, 2026 at 1:28 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> We stopped supported 32-bit Windows hosts a while ago already, so
>>> let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
>>> that this switch is not about 32-bit Windows anymore.
>>>
>>> The patch has been created with a simple sed statement:
>>>
>>>   sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   meson.build           |  2 +-
>>>   qapi/char.json        |  4 +--
>>>   qapi/misc.json        |  2 +-
>>>   qga/qapi-schema.json  | 76 +++++++++++++++++++++----------------------
>>>   include/qemu/futex.h  |  2 +-
>>>   include/qemu/xattr.h  |  2 +-
>>>   hw/usb/host-libusb.c  | 18 +++++-----
>>>   io/channel-watch.c    | 10 +++---
>>>   ui/gtk.c              |  2 +-
>>>   util/cacheflush.c     |  4 +--
>>>   util/sys_membarrier.c |  2 +-
>>>   scripts/checkpatch.pl |  2 +-
>>>   12 files changed, 63 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index a84f14258b0..01b9a5c22ce 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
>>>   config_host_data.set('CONFIG_LIBUDEV', libudev.found())
>>>   config_host_data.set('CONFIG_LINUX', host_os == 'linux')
>>>   config_host_data.set('CONFIG_POSIX', host_os != 'windows')
>>> -config_host_data.set('CONFIG_WIN32', host_os == 'windows')
>>> +config_host_data.set('CONFIG_WIN64', host_os == 'windows')
>>
>> While relevant to qapi file conditions, from a C code pov all of these
>> are redundant as the compiler has all these facts built-in
>>
>>    #ifdef CONFIG_LINUX =>    #ifdef __linux__
>>    #ifdef CONFIG_POSIX =>    #if !defined(_WIN32)
>>    #ifdef CONFIG_WIN32 =>    #ifdef _WIN32
>>
>> NB,  _WIN32 *is* set on 64-bit Windows platforms too, so using
>> _WIN64 is only needed if you have a code path that is exclusively
>> 64-bit only, so there's little need for us to use _WIN64.
>>
>> And of course we are horribly inconsistent in what we use:
>>
>> $ git grep -E '#if.*_WIN32' | wc -l
>> 284
>>
>> $ git grep -E '#if.*__linux__' | wc -l
>> 90
>>
>> $ git grep -E '#if.*CONFIG_LINUX' | wc -l
>> 142
>> $ git grep -E '#if.*CONFIG_WIN' | wc -l
>> 16
>>
> 
> There is also G_OS_*
> $ git grep G_OS_UNIX | wc -l
> 15
> $ git grep G_OS_WIN32 | wc -l
> 23
> 
> Replacing WIN32 with WIN64 doesn't make much sense. It should be
> either WINDOWS or WIN32.
> 
> The Windows API is still called that way, even on 64-bit systems:
> https://learn.microsoft.com/en-us/windows/win32/

Oh, ok! Then I'll simply drop this patch (and let others come up with a 
patch in case they want to replace CONFIG_WIN32 with _WIN32 or G_OS_WIN32 or 
whatever).

  Thomas


