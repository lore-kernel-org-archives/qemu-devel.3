Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E03C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbuv-0002E8-QJ; Fri, 20 Jun 2025 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSbuu-0002Dt-4N
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:36:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uSbuo-0001Aw-PV
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:36:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad56cbc7b07so310504466b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750426579; x=1751031379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB4JEJnsPCpYuaPFuj/LnSZGFhUGvc8XENnOvSEvthI=;
 b=citOoMa8jxzCcAFiqLOXMZLf07YQKI/4jTgpAZp1ijpFOfFEJFCcx+kQgOesFUU5xO
 yvVQLa4ekfkOI9BFhCQ68ZaSqo7aHXfcM2eqU4wwocT7ZCg8jwfFV5t90xZx7I+L4XGP
 ouhTGU6/Lg1L69VzJX5Scbnnnf+Hgsc5ME+IaeS+ikJK81+m1ZK/tLvrZ+p9rHdB0of0
 nNM82xUR1v4r4cI+tVqeqpv9nkrjVOPCn0ZxsgEZUjSRTtDdXOM4oGzfBiFMU0yHbW3s
 KDDfJrk6VB6YWjJBqcKtZD/lT+vF99MAzcZXgeHyypgdFecxHgiuaw2QpNyhTX6hFRnS
 nWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750426579; x=1751031379;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QB4JEJnsPCpYuaPFuj/LnSZGFhUGvc8XENnOvSEvthI=;
 b=pcrkVZeWWER+IN+1gcY3iF2gnPWgyQqsIxr4+ZTeKydjT1flgHVpgmKWBOIhklFRsa
 Xsh6r3VUwbC7Xdfac6BIoYhc9nGHnU0UwtgYQmX8H8HXgTvBGNccao0Nv1Qfzg/UC8Yg
 8qVH5qllL87yQLxQ0LJH8Mx2SotYzGAgP7ctO2t3iez1DwJIkN2TEBXVNWkZ1Nl0d4Uq
 3+uiFkyi5ec8g0IWvXdeCfStgtOFTajfnOsiMLEUxNPGRdim6dMf2Z94V1Sd36a/Ce5K
 Dv9/xWGyExXoI7Gqy+DBkfMvMwluaKGKvI8XMZw40dmuGv5Tpk4v4bE2FU6LN3byV2fp
 M+QQ==
X-Gm-Message-State: AOJu0YyBYg7eNGxZ0sVgYLtFaAyUAGMk4FbSUlY7NQgwbleLnnX8SuEp
 AwDaDku3rPwfaa3/DH/dRI9b0qFcZv60Fnh+Bd/Iqg83iOBgfdGeu0YKWFq51MAXF+k=
X-Gm-Gg: ASbGncvfxNfM+HiOdh+ZUyavayNMLMWWPXHLskFN+l5Ii4Y3DebuzKqMBS2aZDtBSyH
 whsTib8uWacN4HJRbI84GRch8NtG1+trrbbqGp5WxzuxAPVEH7pAXQVk9PEBNTvKlZTgHjm7m4A
 wh98/CWTuPdrCMmBKHrttiPt2xMcFQeE1qSnCE/CtJqeo5JicsE/sVHhnWFYMJLJ6LJm62LtV2u
 Jb7b2nAc++z/WJMqjq/Dx1cjeWEcq9rOov4tcgE/+WR/FOBnWUfKKfUo/zcsCGQUgfNCKPMJnIv
 7p9SzuJCHXVNNmE1eut6m/ssyRQJKOdrSqT4MJI0hOXQKJGIKZ7RRVHLiQVbhEg=
X-Google-Smtp-Source: AGHT+IG2rInnDHZyIj89bAYkbqAgLml9UXKICFI1aci/zBjLQpqNIzZbpauksKvffGuEb505MSVSdA==
X-Received: by 2002:a17:907:940d:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-ae057cc5eb2mr294740466b.54.1750426578632; 
 Fri, 20 Jun 2025 06:36:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054080a61sm166144566b.106.2025.06.20.06.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:36:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55B7E5F876;
 Fri, 20 Jun 2025 14:36:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v12 5/7] plugins: Add memory hardware address read/write
 API
In-Reply-To: <168f9716-1b1c-42fe-9be8-f6b895a9095f@gmail.com> (Rowan Hart's
 message of "Tue, 17 Jun 2025 08:46:11 -0700")
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-6-rowanbhart@gmail.com>
 <87h60evf6t.fsf@draig.linaro.org>
 <168f9716-1b1c-42fe-9be8-f6b895a9095f@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 20 Jun 2025 14:36:17 +0100
Message-ID: <87pleysffy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rowan Hart <rowanbhart@gmail.com> writes:

>> My main concern about the long list of caveats for writing memory is the
>> user will almost certainly cause weird things to happen which will then
>> be hard to debug. I can see the patcher example however it would be
>> useful to know what other practical uses this interface provides.
>>
> Of course! My main personal intent here is to facilitate introspection
> and manipulation of guest state for security analysis. Some examples
> of why the memory/register R/W primitives are necessary here include:
>
> Fuzzing:
> - Read registers and memory for tracing control flow, comparison
>   operands, and profiled values (e.g. memcmp arguments)
> - Write memory to inject test cases into the guest (for me and other
>   fuzzer developers, this is the biggest reason!)
> - Write registers to reset execution or skip over complex checks like
>   checksums
> - Read and write memory, and read and write registers, to do basic
>   snapshot/restore by tracking dirty pages and resetting them
>
> Virtual Machine Introspection (for malware analysis and reverse
> engineering):
> - Read memory and registers to find kernel, analyze kernel structures,
>   and retrieve info like process lists, memory mappings
> - Read memory and registers to quickly trace malware execution in VM
> - Write memory and registers to test behavior under various
>   conditions, like skipping into checks (motivating example: what
>   happens if you skip into the kill switch statement for WannaCry)
>
> Runtime patching (as in the example):
> - Writing memory to patch critical legacy code in production often can
>   no longer be built or patched via means other than by applying
>   binary patches (this is a real problem for e.g. the government, to
>   the point where DARPA ran a program
>   https://www.darpa.mil/research/programs/assured-micropatching to
>   work on it!)
> - Writing registers to skip over broken code, redirect to patch code, etc.
>
> Ultimately, the caveats boil down to "don't modify stuff that's
> touched by currently executing code". I personally don't think that's
> unreasonable (as long as it's in the doc-strings) because for any
> plugin that needs to write memory, ensuring the write consistency is
> probably the easiest problem to solve and people working in this space
> are used to having way worse and jankier workarounds.

I dread to think what jankier workarounds are!

However I accept that a doc string warning will do for now. I think if
we can strengthen the guarantee at a later date to make the feature more
bullet proof we should. For example we could use start/end_exclusive to
halt the other threads while patching is taking place and then trigger a
full tb-flush to be safe. It depends how often we expect to be patching
things out?

Richard,

Do you have any view about this?

> These plugin
> functions make life way easier for them. I have been in touch with 20+
> people from various companies and projects (including Microsoft, where
> I work, as well as other big and small tech) all working on plugins
> that could be better if this feature existed, so there is definitely a
> user-base and appetite for it!
>
> The last cool use-case is that this moves us a long way towards
> cleaning up the large number of QEMU forks out there designed for RE
> and security testing like QEMU-Nyx, qemuafl, symqemu, and many more.
> Instead of maintaining forks of QEMU (many of these are based on 4.2.0
> or older!) folks can just maintain a plugin, which lets them take
> advantage of updates and fixes without giant rebases. My goal is to
> kill these forks and have these projects write small, maintainable
> plugins instead, and the authors are on board :)

Absolutely - I would like to see that too. The main reason those forks
haven't been up-streamable is because they have to make fairly invasive
changes to the frontends to do their instrumentation. I want to grow the
API to the point we can support these more advanced use cases. I am
however being conservative in adding new APIs so we take the time to get
each one right and minimise:

  - leaking internal details and constricting future evolution of the emula=
tor
  - giving the users too many foot guns in the API

I'll have a look at the next version and see how we are doing.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

