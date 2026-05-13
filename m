Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83683CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 08:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN5O3-0005DC-Mr; Wed, 13 May 2026 04:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN5Nt-00055V-74
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:56:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN5Nn-0006Uo-Pd
 for qemu-devel@nongnu.org; Wed, 13 May 2026 04:56:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488d2079582so68079375e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778662558; x=1779267358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ld4VK9mS6QSxZTRtwB228V+13Txvl727ahjr0Bu4EWg=;
 b=Ykj5wNpIrw0oaKuUPIEItl/kj8BQYQZiDJZ4kRhlkpK7Uz1DcsogideWtLMsg28JJ7
 ZwOR2TlA1bkO+x6nDHPshYrAE2LGVwhUQICtFWDTGOGUqw6q+gLiJpAEhY52qZm52+1n
 OyPibjSnbGv2OcrPrVbQwO8eYEDelJs/AL4jn70REavemXQeQf+VX9Eq1FBQ++ML9NUW
 rWro3eluWL9ymmZ9PUu1GCr1knMra/FBR7hkxZGPgrbWTRe+U35clp3qNEpKgzJxKG4p
 TIwTa8VE/20QUWGZViDkJG6S4zKOb4pRrQZqPV8rV+FO+TFbPDx5wdnDCLCu1/IPKJ7D
 l+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778662558; x=1779267358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ld4VK9mS6QSxZTRtwB228V+13Txvl727ahjr0Bu4EWg=;
 b=Rv4d/d5P+QvVdoB/N5a80U+GhmMpNTXWGhTW4xqXQYXKTgYFK01kEai0XKDWTCdzbq
 lDqdnaBOgydSRbEYuxDxgQX+WJSoXLNs3vx9GdWzmyWinZbJa7pInFJR+L+lIj1A40fA
 lmArCu0sEceqz0i7pHwz7Tb3O9QWfllt+aTgkLKCDSvp1EjnqCf9cjYEDIdBYgWKf0p3
 37T7lX87RePIhKa+EFofSS2ZO9gPG0kAhju96BVErya/RQrGuzqkdZ5igjLUzLUKpunM
 8P6oa6829grWe58+vc8ZhAhfagqfMadu7kp92Mutu5poZ05Nma9w3C22exM+14b0Zum/
 +YFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gWM1KJLu4vuqdlEm/pxgtU1mIxC4ACTMANZBu9OSsmqH7od41iMC3mL8yb2BuAphy/Esiy+rY9TJU@nongnu.org
X-Gm-Message-State: AOJu0Ywc9S+1NPln81sbBxTLExHpL5GYih9i2A8+N8Hw936w2y3+82Bf
 kFbiC4aX2RiaByGT7pfn/UmwvOUahJBW3HXy5mkJp9CI/odTXKUd/IyXjKbabDXvkn0=
X-Gm-Gg: Acq92OFtC8EXpmwJJhykeZFN0SE+FxSk7ULTxL/Eu9a4inHihqYtu7ignV3Kx3t2UoX
 aAa1m3PhLqNb9PbY/fL5Ex+T1PbAwkzEfXs1VUzmdnEj//AeUrgSGnkcj6W5UYkRSGq3B8fd3TZ
 p4vyheV7XgrZqRxiZ6Oj0eB4dmTuBJrpDLAuQv7iqY+Gix89gUPFhoMKyIxfigx+sHsFgnrV0zV
 moFS5o51D3elrHt+TXViNTdHsoXOEl+BrH9pcYCmadXMmo/NlNiOP4KJaCPQZBUbe4p/mJZ+PZp
 wHdmZZMLhKA2mNwhxcIfHaNw7mySkRdFhsH8neC1hf9seVF49nC4h00wKRhdPlkcwdgRtx4/9x+
 smqDyW/D80CrkAvWu8lFD3BYaHLR5mmwInI3OTsoZ+qVRmT70ZftNOL7ZCcka4XLWe7dzsf6v1R
 ebhxnS76xa+tmdom4+oojMFjYv1zuEfkjJpFtPID2yAoa1DujWe4k/CqSRWDUQf4exvg==
X-Received: by 2002:a05:600c:4450:b0:48a:56de:d62a with SMTP id
 5b1f17b1804b1-48fce9b3926mr23003505e9.11.1778662557839; 
 Wed, 13 May 2026 01:55:57 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d74536sm60874375e9.15.2026.05.13.01.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 01:55:56 -0700 (PDT)
Message-ID: <971d39fb-b570-4588-8bac-7e7924f91067@linaro.org>
Date: Wed, 13 May 2026 10:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <253ecaac-ac2e-43a8-97e8-9251f114df3f@linaro.org>
 <CACGkMEsvtHiyNviz+vKL3SPZSU7xjWEK75y8js_bf+w6-WKdPA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CACGkMEsvtHiyNviz+vKL3SPZSU7xjWEK75y8js_bf+w6-WKdPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/5/26 10:38, Jason Wang wrote:
> On Wed, May 13, 2026 at 3:11 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 6/5/26 14:01, Markus Armbruster wrote:
>>> I'm cc'ing reviewers and lists mentioned below, and frequent
>>> contributors to MAINTAINERS.
>>>
>>> There are a number of MAINTAINERS entries with S: other than "Orphan"
>>> without M:
>>
>> ...
>>
>>> Unless somebody steps up to server as M: or at least R:, we should
>>> downgrade to S: Orphan.  Volunteers?
>>
>> 'Network device backends' (net/), 'eBPF' (ebpf/) and 'Network devices'
>> (hw/net/) patches are left unattented on the list since 6 weeks, all
>> maintained by Jason (first 2 listed as 'Maintained', last one as 'Odd
>> Fixes'). These sections don't have co-maintainers. Shoud we be worried?
> 
> It should not be. I will wrap things up soon and will continue the
> role as maintainer.

Nice to hear you are well Jason! I'm reassured :)

