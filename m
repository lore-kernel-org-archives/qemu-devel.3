Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C07F55100
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyuCB-0006z1-BE; Sat, 07 Mar 2026 11:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyuC8-0006yj-IB
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:08:01 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyuC6-00060U-Ih
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 11:07:59 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64c97997b0fso7296971d50.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 08:07:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772899676; cv=none;
 d=google.com; s=arc-20240605;
 b=kCjrlPcuuWAgLgBV7Z7rLwUwH+kGU+XtRD/FHD2Bsd5bM4rhrAjaboeRrraGZC6rfe
 AGFgdQKTezhxHgMnNWXY1Tsmt+vQHE+UUml+iz2JcwyajCVjGKXBNdZzbGlbxxb9RcrP
 2kI8yazoGBoAOdOFHqMmpqf/J7JberzfuaQUxkGAocgxJg8I4vNK/JMM5aZTVa5BfnNu
 s0BN8zCrCYuQwwtKy8temFSqoljhfm4JgptcaPz/XbRnlxBOU29kAgjyLPGDk19ZUMvS
 ebtvCdUXWp4B1Ycn45skBXqmE4m2DNE5Je1jdbQpqwVFSBDgigvKcMBru0HzNQFxkeDd
 uEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=jbdokrxry/+gOpyfyeVT+LvOwdRXhkB8OM1gU8cd80g=;
 fh=MzUcy3tyVEHKwL229u6HkegZMk5Q8mTbxEL4x3WlqPg=;
 b=g/95OVJqI8XMkLkT6nw5xZW33mylSK5WcvZaHHFTKINe5cbrSoC9RqnBR5fHerSo9w
 TBlkv8g3kFV+FVeNwL44dW3PIJbvpHtWNGZi2VNz0GQcUmKePiaktthcejsJgCZ7fjS3
 5oPAwnWfQ42v7VktDH2bMtQ1L2lY9FB7HbyMIdx/aUFeZAUTGFlzCik+aUOX6z7w+Wyl
 M/LBdIw63zfcQyQfzW9PtJaGmMZcKodU9qYfvgFUyaAAprENCEwttZnAYNFnMYpPnlFp
 6UiXGFqQ7tQq61lNbxgLyalBw7UK2ExCRtLUuGv7k1PgOdRb97gQjRLlxYcOw7g3wAHH
 ecWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772899676; x=1773504476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jbdokrxry/+gOpyfyeVT+LvOwdRXhkB8OM1gU8cd80g=;
 b=on+DYTivZOnsndFOSSzQMjdppB8SKTA9mdMGE69SnwPMkpFc7Jnz3HTEf5KoYAVE6g
 nv3rgc5w940RdatOV9YorMwk/QqeZgDiu55FW8+DW409yTxtgSl8MtAm8e45iUeO72xV
 stDdmQBqpmFCbLf31EjdZavQAZkB6Ti+DGimA5HOR5IKOoSQgHjhcOKE+Sy8nIGbKUW5
 rCPUjbytneulMi9+kxxwAVvQ6X487L9EqumliVdf7TTrZD9GK8XdhB4pIslxfTKmbzlv
 Df/ZF0c+WgoXkiwk626X4KfgA9hJ96KY03cMcxWnQdg1d7XhIXN6fjqrsNveBAMvgSm9
 oJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772899676; x=1773504476;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jbdokrxry/+gOpyfyeVT+LvOwdRXhkB8OM1gU8cd80g=;
 b=AwykqB87hy9r4m/L0xLWxc0n1m3qt9V8yRd6b6ckYlvbwZcPtg3FV9121TC8ntIBrp
 Rn2ut7uOF/AqLjtuVPAAXfmimSp3d+veBQphXtZYk9iBRN3Cb8gn685VRIoHdvgCfB+x
 pQNeJXpgsPB9JsObnNKgSM7yI6NeLMLs1MFjZlLAY36HDiZItdJAjin14vCf/6hD6Crx
 rUmYa0xE+oM9alGF590+lRkU0LkJAIBw2ebQeSzNRzyBHPNiair1K19Q+XNuLZ25JTn4
 TL7090tsKP3MLpIGSIA3g0dBts7P370wm8Z5OO2z3wtp1z46flwtUoNxGYo+1JJMlLc1
 H08g==
X-Gm-Message-State: AOJu0YyM7cqZ+klSlTvRPe89r0gQiIUDbXp4bGJFzbeMVirm+ujt9m67
 WR+p305uC6LrN3rUt6EsbT3f926Dx6+2yNuqNbWNkIYPJ+f+ypj8BpTQ1x7BVoT62znO6rFBVxz
 D/bEoz/GHsNxsAHI0HSzZQmXJPJdg8gyN7yaLEYDSldHTK5FDktO4jVE=
X-Gm-Gg: ATEYQzy9rmNvRphQyPC17tM8yI+Ay7FopS9Cf4nFgqiwyt8dXR8SqMu2aUj4Is3UBdp
 vVfRY/FTywckE8q2GGRObBShno1fMooqClrO1ya89yelFSJDF+Q5Evh9sTMtznekup6oXy6UvuG
 ayl9yh0tFEShRnLC9lw6r6iQy7+5VydhS4B/u6a3zF2ocliEHZdreRSQo8/GxRmGGmle1wds6o0
 yLsD9mGNh5gqb2MGWYuordpKK+AN+fRlylznEr4BvQ52LWnKlMDi8gnMbPrQaObCoofC0UREurj
 JBwzcEM70yKP/n/4d+AB6dUTnDjdtVjPPx773B6mFdBptiEGi9rjgDN7VttKBrQOkogxnMQlkqU
 Hyw==
X-Received: by 2002:a53:ecc3:0:b0:644:444f:3bd1 with SMTP id
 956f58d0204a3-64d143192f8mr4498603d50.68.1772899676472; Sat, 07 Mar 2026
 08:07:56 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Mar 2026 16:07:44 +0000
X-Gm-Features: AaiRm53wcaO9Hr9d5qs_4nHuFhe45NewtKgH8RS48NAVoo9UCElhbJykygMqPoQ
Message-ID: <CAFEAcA9X5khjbOYcnbQVG9vRNhMRS7WB4eMo-UhSJD+cpWx9Zg@mail.gmail.com>
Subject: memory leaks in dbus-display-test
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

Hi; the dbus-display-test when built with the clang address sanitizer
produces a lot of memory leaks. Repro:

1) configure with:
'--cc=clang' '--cxx=clang++' '--enable-ubsan' '--enable-asan'
'--target-list=x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user'
'--disable-docs' '--enable-debug'

and build.

2) run the test with:

(cd build/x86-tgt-san-dbg/ && QTEST_QEMU_BINARY=./qemu-system-x86_64
./tests/qtest/dbus-display-test ) 2>&1|less

The 'console' subtest will cause it to output a lot of leak reports, e.g.

Direct leak of 208 byte(s) in 2 object(s) allocated from:
    #0 0x64e038cdfadd in calloc
(/home/pm215/qemu/build/x86-tgt-san-dbg/tests/qtest/dbus-display-test+0x258add)
(BuildId: aa998e9bf2752fab128fa39c22c94bbb5b77ce2d)
    #1 0x7ef13b191771 in g_malloc0
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7ef13b2b7f65 in g_type_create_instance
(/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x40f65) (BuildId:
91bcc5d52326f5490fa62acc824cb87c700d0f8a)
    #3 0x7ef13b29da63
(/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x26a63) (BuildId:
91bcc5d52326f5490fa62acc824cb87c700d0f8a)
    #4 0x7ef13b29f015 in g_object_new_with_properties
(/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x28015) (BuildId:
91bcc5d52326f5490fa62acc824cb87c700d0f8a)
    #5 0x7ef13b29ff70 in g_object_new
(/lib/x86_64-linux-gnu/libgobject-2.0.so.0+0x28f70) (BuildId:
91bcc5d52326f5490fa62acc824cb87c700d0f8a)
    #6 0x7ef13b428809
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14e809) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #7 0x7ef13b3e7d96
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x10dd96) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #8 0x7ef13b3e83c2
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x10e3c2) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #9 0x7ef13b3fcad7
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x122ad7) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #10 0x7ef13b38b7ba
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17ba) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #11 0x7ef13b38b7f4
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17f4) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #12 0x7ef13b18b45d
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #13 0x7ef13b1ea976
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #14 0x7ef13b18bf46 in g_main_loop_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #15 0x7ef13b3f4581
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x11a581) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #16 0x7ef13b1b9e61
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8be61) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #17 0x64e038cdd3dc in asan_thread_start(void*) asan_interceptors.cpp.o

Indirect leak of 1228800 byte(s) in 1 object(s) allocated from:
    #0 0x64e038cdf8f3 in malloc
(/home/pm215/qemu/build/x86-tgt-san-dbg/tests/qtest/dbus-display-test+0x2588f3)
(BuildId: aa998e9bf2752fab128fa39c22c94bbb5b77ce2d)
    #1 0x7ef13b190ac9 in g_malloc
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7ef13b1a6532 in g_memdup2
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x78532) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x7ef13b1d2d81 in g_variant_new_fixed_array
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xa4d81) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #4 0x7ef13b425412
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14b412) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #5 0x7ef13b42520c
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x14b20c) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #6 0x7ef13b3f0190 in g_dbus_message_new_from_blob
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x116190) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #7 0x7ef13b3fc6a2
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x1226a2) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #8 0x7ef13b38b7ba  (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17ba)
(BuildId: ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #9 0x7ef13b38b7f4  (/lib/x86_64-linux-gnu/libgio-2.0.so.0+0xb17f4)
(BuildId: ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #10 0x7ef13b18b45d
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #11 0x7ef13b1ea976
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #12 0x7ef13b18bf46 in g_main_loop_run
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5df46) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #13 0x7ef13b3f4581
(/lib/x86_64-linux-gnu/libgio-2.0.so.0+0x11a581) (BuildId:
ebdb30973c66c71f7f9fc82981b95f418ea1dfb1)
    #14 0x7ef13b1b9e61
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x8be61) (BuildId:
116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #15 0x64e038cdd3dc in asan_thread_start(void*) asan_interceptors.cpp.o

and many others, for a total of:

SUMMARY: AddressSanitizer: 1232414 byte(s) leaked in 86 allocation(s).

Nothing in the backtraces is in the test program itself -- it all
goes straight from libglib to libgio to libglib again. So I'm
not sure exactly what's going on here, but presumably we're
failing to dereference something we ought to.

Could you have a look, please?

thanks
-- PMM

