Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A7BC88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4k3g-0007Jb-9c; Thu, 10 Sep 2026 15:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4k3c-0007Iz-U5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:03:36 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4k3Z-0000PO-K8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:03:34 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-90cd4631090so1249186d6.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789067012; x=1789671812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UzMypnwj851tykAnD7KYpstHaBktoBEhep7rnfObKgg=;
 b=J3Jnvmv5reHDBqyRCqgljEtfXS1uAfLxeOn6efHotjiaNk2+BpDPILZ1BKNfRZewj+
 irestzXxAtyIwhSp/upxn3XlxbgtGoDWcXciu1BDdBVi9XnwSIT9dd8gJPP5Pwt+SJU3
 afW4A6ZBUV0Mfu+oU9UW+SSnLlzLcUcjLCggaWBzDOPLe7uH95OG5UKLCu+eg2mqhlS2
 OiD06BGCko3YlhfRfvCzA0fgAPRdEfNv5M8UwS6gLaQKZrkpU/9XduGUyIbhQPF2+C0Z
 vCnUF5o+1+cTh41eQ5Uz6+WCpJB2UDT5eJG7ES171FUsjc0YqMZMeGvgYn06NyCPV9B2
 NCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789067012; x=1789671812;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzMypnwj851tykAnD7KYpstHaBktoBEhep7rnfObKgg=;
 b=cYEV61UQHXCjFqmOEFVm8zS/3Dsz2kE4Fggw6cRjVpWkszCt3f4c2fVpQq097CDetA
 OgercdlDop5tahp7NQy/IofeBcw3V8p7yd7uoqcAvl235oZ1WiIneqlFTCEsse6S3Sn3
 zHCIfJOZKKUZwjBrD/VkQTjo/QrQijxsCf7ozHrX3EUXpIgpDku8oS9LZArcm5uoJ2Lo
 HPmdJ+1TIehDEDidxhX8mMi21vwGQkNZT62A/h62UAhrFOQgmA0IyznqPpgLjB9x0xBC
 JKAQEXLqe4dIgXqsBVS9fAUVj1RRBtK7Co7zhzKNkOYve+ldYI8jsSzUJOLG0gGin8wl
 JlhA==
X-Gm-Message-State: AFuF++mrjdWMhQlBN30GpR7MRG45EdEeqL0a/f3RyU8XpTTMvtnO4xWL
 Gl/fwzmSMIZ+DunlABwXeO9C8O+x4uxv0MryPv7YxVgPTRK4OX1g0v4wGZiQwa+McayxPYJbfaC
 1oS56
X-Gm-Gg: AYBFou1qI9pdQVX679GxfSEypjPkfoXdpRb/aNeJfqFxxbO7qC4FHeX6rvrbnay8n13
 yW+ZuJLhP8WkAFgIfZiVyLWn0G4hyFuf6sQDVFs6UXSgXruQTrsvD7j1LYYQWNZ1B6upQiSbHOg
 aVQ36OyeSXIG5vGlV0BUdPLC6j8Me1l3aDFba8PyL0xMKOn26ppQxDbjYEHUauhFA81F/0tXhdU
 7l6ATcjFxlJM3c0IrShBRNgvYzLL8lcMxNg+UDQhA4fRyyOokfJauN4nFT4j1N4+DLe6mWdtUQ7
 ehNqbnkUpw2eDY270RwWo2syWOMTQYuz0JjyBrbReaV0rkrgs8WNnMnppYsP+IfWgW2bdtYHG1k
 1jfmOnBLPdbhjT2jIf00vTuqlnr+7o2z3nNgewBUoaZfhEbq/FaoYImWse/e/cTAC/PQglvwMT9
 7zbiNXLx0+dJcTTKBYSspXnRjgcTt9L6EvdrSi/eGfijuvvwUCcdhppbR2+Hkl1jfKRZcSf8uqO
 9CQC9qtOFcP+asT49xjCPXvLRc=
X-Received: by 2002:a17:90b:2685:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-39d7791458cmr7310175a91.7.1789066304689; 
 Thu, 10 Sep 2026 11:51:44 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm889912c88.12.2026.09.10.11.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 11:51:44 -0700 (PDT)
Message-ID: <b596fc04-3df6-40e7-b7d4-b87207df1741@linaro.org>
Date: Thu, 10 Sep 2026 08:51:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposed QEMU 11.2 release schedule
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
References: <CAJ+F1CLTUd1HxdZQ=Ot2eMKcHTiP52f2V-=mehfOcFzN0UtXsg@mail.gmail.com>
 <CAFEAcA-Z1_=NSi2xvpYcac6t1vP8aHWxaebrHD5CdnRt0p2gMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-Z1_=NSi2xvpYcac6t1vP8aHWxaebrHD5CdnRt0p2gMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
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

On 9/8/26 03:02, Peter Maydell wrote:
> On Tue, 8 Sept 2026 at 12:16, Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>> Hi Stefan & all,
>>
>> Would that be a suitable release schedule? It's a bit earlier than
>> last year (https://wiki.qemu.org/Planning/10.2 release date 12-23)
>>
>> 2026-08-12 Beginning of development phase
>> 2026-11-09 Soft feature freeze. Only bug fixes after this point. All
>> feature changes must be already in a sub maintainer tree and all pull
>> requests from submaintainers must have been sent to the list by this
>> date.
>> 2026-11-16 Hard feature freeze. Tag rc0
>> 2026-11-23 Tag rc1
>> 2026-11-30 Tag rc2
>> 2026-12-07 Tag rc3
>> 2026-12-14 Release, or tag rc4 if needed
>> 2026-12-21 Release, if we needed an rc4
> 
> Richard is running the release this cycle, so up to him, but
> I would suggest that this is too close to Christmas and would
> move it a week earlier.
Yes, I think one week earlier.  That also ties in well with having hard 
freeze just before KVM forum, which starts 2026-11-12.

Thanks for bringing this up; I'm not sure why I missed doing it myself.

r~

