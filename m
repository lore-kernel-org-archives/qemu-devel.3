Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5962EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKJg-0004ct-TC; Tue, 18 Aug 2026 09:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwKJc-0004X7-Dl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wwKJa-0004aB-Ve
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2885430a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787061437; x=1787666237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6M8/qmFtcWp5GcVEIBQIyg423xO2KTmgapaXy3+63Y0=;
 b=E3B18GNSKLkjORbFk8xM3mYSxv3E0JmkdRcq4oGlIsCoIX1Nqq8DQrjrQ6Wt/08csA
 aGjCi3S/pjqV7GDZF2FYg+uxKw/pVf3v1l7ou6IM0h9e3c7sV+6lnKBRWuFranBacQBN
 nlkDUvFaw/uEw2bWyhFmxsLgUfWd26EiPAchmNMTUrH8t3ZToLE/Htf/praMWAa7Qjer
 yMKeALOrdblx01704sXaBVYW+zGodev1gMAelJHZEX+p6jaMZnh14Mz2MIuUhMFr55ac
 +B9zQa7dltQRPVlm8Aa1uHUfV8zpTEmr/uHXEBZQX5a4gM8RrK5wlfNj/nQ5vUs7wE5l
 v9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061437; x=1787666237;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6M8/qmFtcWp5GcVEIBQIyg423xO2KTmgapaXy3+63Y0=;
 b=lotOmfU7eAC3+mguaThY+HQKDB5oB1SkpTFnimr7nSmItCpsSRtB2ARft+USs3eBBh
 OO3YvEVFgYZAJDYR0YYjKt771/+tGVMRPrIPnecgPwsBpnhtlLeWYkyRz4HuM8UXzUHF
 imo8p4ZxH1L4Eb1GKMWMIhBhp2rZXoGU6HbgeMkHFj9CiVGM04kZqGDvmxcYulmMmY6D
 +MSYylnFO8ducO1Wj03G1XBHuDeEh6/fYzSEPCDUd+bobK+Jet9wa8hI5qK91tGiv2fI
 Up+SFSWA/oNZ+Nhag6vyQYP6sb0/JNvMyKtw0uVn7RjlGZjaG9uPV2IkVOVU11GUzDjK
 3dcA==
X-Gm-Message-State: AOJu0YxPNVE4n8e8lIdUqILl4KhACYxRt8pvCzqGKmRr3VJdnT6YZBdT
 ViJbpVtAcxfIkgx6Ql1Ez7zYGUJahcYbH0cHhrRuS2Gy4FTTw0H9o4rD
X-Gm-Gg: AR+sD10u4GCmWv+whrHJ1MKiKz8D6wjT6xuqn3aliaJ68VDcBoHYDRjz+AzGiWeM9Jg
 FnATrzXsL417IrMAlvmRch+ibVg8E535FyrhBIQUV8ILTKP5cPym6QE0Xic0R6n4v9wztxENsnC
 aK3G/WMKMxDVEIlYVknKj7kUsG2ANKSyVTZN1QKL0NonGSGwRl0zWRUgINprSPMBwJFZPXz5Rnm
 gle71qsDukHQZBG0Xi5uIx3UFKD23e8R99LkMLKCifCmkWAAgx8NgVhL1JZFOmjtF5K14uMysi/
 v4XOdHk4DZqMzaeGMCC9ccDSx38eSW+MQGLzolNOgdn3WqUm/3gEzyrOOsAWYlpfuhXyn7AOsuU
 0zUFGhvLrhV8zxFK2bH9ipYzJ7ROfLMuRfTbErTfWpg8TAL0VvLnA8XK6F+L785CJQPM8/UalKl
 Y/+Xs8AESkob1tkhTjV8qDnxkMwbbVGX2gpLkT7aCn/xRF68QHmIcoAcnDuAEW71JCVHBqHiX4i
 f4=
X-Received: by 2002:a05:6300:6697:b0:3c3:c080:71ca with SMTP id
 adf61e73a8af0-3ccd9fef1b4mr14538584637.0.1787061437477; 
 Tue, 18 Aug 2026 06:57:17 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc13c03320esm2152832a12.25.2026.08.18.06.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 06:57:16 -0700 (PDT)
Message-ID: <4a0b20e5-947c-45a4-8fcf-89c77e0a4cfb@gmail.com>
Date: Tue, 18 Aug 2026 21:57:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Jack Wang <jinpu.wang@ionos.com>, Juraj Marcin <jmarcin@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com> <aoRXk0H1muF_gZJP@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aoRXk0H1muF_gZJP@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 2026/8/18 21:01, Peter Xu wrote:
> On Tue, Aug 18, 2026 at 07:57:06PM +0800, Yanfei Xu wrote:
>> Hi Peter,
> Hi, Yanfei,
>
>> No objection to removing the dead code — it clearly never worked
>>
>> I do have one question about the direction, though. The removed logic
>> was the only in-tree attempt at MR unregistration for the non-pin-all
>> path. Without it, registered MRs grow monotonically over a migration,
>> and with large, widely-spread dirty memory over chunks the accumulated
>> MR metadata (user + kernel) can cost more than pin-all and even perform
>> worse — which rather defeats the purpose of not pinning everything.
>>
>> do we still intend to keep and improve the non-pin-all path going
>> forward? If so, some form of dynamic MR unregistration will eventually
>> be needed and it might be worth keeping this code，or at least leaving
>> a TODO to mark the gap?
> Thanks for taking a look.  This is a valid question to ask.
>
> Though it was there for 13 years without being "enhanced", it means the
> possibility we leverage it in the next couple of years is low.
>
> You also discussed the other side of things: I am not a frequent RDMA user,
> but my understanding is frequent MR reg operations already slow down
> migration quite a bit.  It means dynamic management including unregisters
> will be even worse.  AFAICT, it'll be a challenging task if we want to keep
> the performance in bar and add a hard throttle to pinned memory.

One advantage of non-pin-all is that it neither sends the all-zero chunk
nor registers the corresponding MRs. For guests with a low dirty-page
workload and a large number of zero pages, this lets it migrate faster
than pin-all and pin less guest memory during the migration.

>
> Obviously, RDMA migration users care a bunch on performance.
>
> So I see no good reason to not drop it.  Even if someone will work out that
> problem, it's still not much code to add, and it'll likely be easier we
> design it from scratch with the demand, and without worry of breaking
> anyone.

Got it, thanks for the explanation.

Regards,
Yanfei

>
> When that happens (if it ever will..), someone should also send an update
> to MAINTAINER file on RDMA migration to change it out of Odd Fixes stage..
>
> Thanks,
>

