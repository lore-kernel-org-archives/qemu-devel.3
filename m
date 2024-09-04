Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308DDCD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsrs-0000RM-Oc; Wed, 04 Sep 2024 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slsre-0007ur-7c
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:28:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1slsrZ-0008G8-Th
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:28:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so1072726a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725467288; x=1726072088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXXhl4CJXDtlxvl2crNT0P+bjEEaqNFUweTP6XymyCU=;
 b=n848wT47o9dtUOacwEFLVt4zU2G3JtMyEUD5FoKMtSXYIrZnbES8lM/W7TYyQVYAwN
 Vwt/FJxP77ck95MtmznC/P7tr7eHfuZPJCbtr0WNmo9eWDuWwsecFvgNXj/W2XYov2VR
 HZxwPmQmZVAGwG+2+tt68gNSzxNalnqz1d9xMP1Z/8Mcmcpah17dnNQKWqxQXdy51MOu
 aRSoUZP+cXaxgGNWb4RSAxjIuUUJv2Sz+jgZaN/k6fbkfbbeZ9eJ42ID/ByBqJFfb911
 TtOXtwvVOmB6MTJISuEyfKqtm98o92p5VZPkxAmLCaGV3ejv5CCBKI6/diMMXjhne44F
 yrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725467288; x=1726072088;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fXXhl4CJXDtlxvl2crNT0P+bjEEaqNFUweTP6XymyCU=;
 b=vbf0wqo2f0qNEWa4qXwgj6I3/78FFoBJLIXfI7wVo20ZPBE5rghKb8w5Rej9vPOQwQ
 YZYUEXXj9c6LDshGj17Nqn36IUiQlIta17XCEI37gKjU1RXrqktCdADAZlU36oGlAybr
 nbl4qEoJBqVFSS29LEUs4FGHNUKuYMn/ybJQ2nO6uQSuaK0xnPjRYgL7bpRSOViiIN+5
 GuSotEI0Ekd3z9ETuNZZlzxQ5gIM8Hft5QQagW/2919I3VlEE8BBlHUsOjfU6gz4uU1l
 ojkhMULZ+R49kuabAzzdwz8RWDGi2S8Bm+QDO+tZ06Jdidp1Tsb5gQUKStsnr74mAGjE
 KZZQ==
X-Gm-Message-State: AOJu0YyaanLctA7PtXKhbPGkQy1fr8422Q94x5F8jk/DnFxHFDSx1ZDs
 yWO7pTviKQLGwlJP0RNjlddRWLyTtHkNdnPZ3UpiIOOhNhYkoIiAJgfZ0b9hJIA=
X-Google-Smtp-Source: AGHT+IE+a04CMF5mIPgjMeSDWgKqe3dkJ48b/JodS4r+2C99Se4PrMwU7wW3sGQnlL5h+BsM5vuRTA==
X-Received: by 2002:a05:6402:2549:b0:5c2:2b1d:31e6 with SMTP id
 4fb4d7f45d1cf-5c2caf311a6mr1987152a12.29.1725467286859; 
 Wed, 04 Sep 2024 09:28:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc698132sm94729a12.76.2024.09.04.09.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:28:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37ECA5FA1C;
 Wed,  4 Sep 2024 17:28:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Xingtao Yao
 <yaoxt.fnst@fujitsu.com>
Subject: Re: [PATCH v7 6/6] tests/tcg/multiarch: add test for plugin memory
 access
In-Reply-To: <87seuftoif.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 04 Sep 2024 16:41:28 +0100")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <20240724194708.1843704-7-pierrick.bouvier@linaro.org>
 <87seuftoif.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 04 Sep 2024 17:28:05 +0100
Message-ID: <87jzfrtmcq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>
>> Add an explicit test to check expected memory values are read/written.
>> 8,16,32 load/store are tested for all arch.
>> 64,128 load/store are tested for aarch64/x64.
>> atomic operations (8,16,32,64) are tested for x64 only.
>>
>> By default, atomic accesses are non atomic if a single cpu is running,
>> so we force creation of a second one by creating a new thread first.
>>
>> load/store helpers code path can't be triggered easily in user mode (no
>> softmmu), so we can't test it here.
>>
>> Output of test-plugin-mem-access.c is the list of expected patterns in
>> plugin output. By reading stdout, we can compare to plugins output and
>> have a multiarch test.
>>
>> Can be run with:
>> make -C build/tests/tcg/$ARCH-linux-user run-plugin-test-plugin-mem-acce=
ss-with-libmem.so
>>
>> Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  tests/tcg/multiarch/test-plugin-mem-access.c  | 175 ++++++++++++++++++
>>  tests/tcg/multiarch/Makefile.target           |   7 +
>>  .../tcg/multiarch/check-plugin-mem-access.sh  |  30 +++
>>  3 files changed, 212 insertions(+)
>>  create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
>>  create mode 100755 tests/tcg/multiarch/check-plugin-mem-access.sh
>>
>> diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/mu=
ltiarch/test-plugin-mem-access.c
>> new file mode 100644
>> index 00000000000..09d1fa22e35
> <snip>
>> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/M=
akefile.target
>> index 5e3391ec9d2..d90cbd3e521 100644
>> --- a/tests/tcg/multiarch/Makefile.target
>> +++ b/tests/tcg/multiarch/Makefile.target
>> @@ -170,5 +170,12 @@ run-plugin-semiconsole-with-%:
>>  TESTS +=3D semihosting semiconsole
>>  endif
>>
>
> Also you need:
>
> test-plugin-mem-access: CFLAGS+=3D-pthread
> test-plugin-mem-access: LDFLAGS+=3D-pthread
>
> So less tolerant gcc's include pthread (otherwise the alpha-linux-user
> fails), with that fix I get:
>
>    TEST    check plugin libmem.so output with test-plugin-mem-access
>   ",store_u8,.*,8,store,0xf1" not found in test-plugin-mem-access-with-li=
bmem.so.pout
>   make[1]: *** [Makefile:181: run-plugin-test-plugin-mem-access-with-libm=
em.so] Error 1
>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:56: run-tcg-=
tests-alpha-linux-user] Error 2

And ensure we enable BWX for alpha so it emits bytes stores instead of
faking it with masking:

modified   tests/tcg/alpha/Makefile.target
@@ -13,3 +13,5 @@ test-cmov: test-cond.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
=20
 run-test-cmov: test-cmov
+
+test-plugin-mem-access: CFLAGS+=3D-mbwx

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

