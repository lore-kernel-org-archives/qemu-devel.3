Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCEAC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6Jf-0001Q4-Md; Thu, 05 Jun 2025 04:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uN6Jd-0001Pc-HX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:51:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uN6JW-0002O1-NJ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:51:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-601f278369bso1407959a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749113462; x=1749718262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEOqDrbm+GTTAleydpUhg4R7Dn74K7wTFs/YapJexqA=;
 b=aYHd/8nhqnuh1JtIXF9kZjNFKEHFkhA4HNV1Yv5eRIrHQZFvuh6Sk2VzektOYFBnoK
 KfW37EcfYdbfsKOD86CFrvJpo7eWV8UgZGWGnCdQ4llFUMZKel9POBvJaD+RVaNfAmZF
 OnWXAxFOzoP3PkW+KA/fQ7Z+o74jMGkhIBmmu1/F9w7McAftwUvHsjKftoyXEIWay+gE
 hHT5LJ42lTicS0m+Tlu15Fu38oYaNTjrSw0RFRWZMZn4zAYWfABchaxD2TJZziH7WsF/
 PjBQ6d2N5js79KwUDkrycg1XBMaf2gEA91PEO4FBD36BitkB6y61S5kK3af4afEa4Lsd
 GUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749113462; x=1749718262;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FEOqDrbm+GTTAleydpUhg4R7Dn74K7wTFs/YapJexqA=;
 b=X3Z+zk12K6CtTpijLYemrfqSRJS//yUIJjoAJJzEHc0yMFTrgXUyCny4dZbLggpLCg
 43BkpGp9pwdUhgZ762T9oSasSE0Jnu6oetVYklCsbMOC6Duqd+ELrsLsdmyCZoKTj6Io
 NEbx5kIEcC8d0gLc3K8h9P5DsMw3JZnvE9PA2crJTcDgHHyTkwz8RT3vmhM3hQNax+rt
 iHGqGRAXCfIwLmxND5zAWcT6c/Sy+Ik8T/wMDSomaXTBiFjKdifrKpruL//EeRs/cWh5
 VSTRyhNDIwH9wr+6nNJo7E75KGajGxTMtqpNV4BkXQW3DBqBnOItlXvzm+sPvQy0a55f
 6mIA==
X-Gm-Message-State: AOJu0YxwGMdJfLMKXXd1YTbTY4/HfcCPZpOJy2ia8UJVzHh5BuCa630T
 GF+qMPtW9a24rQ4hls8TLQO1ZBKZ4WPOZFdZpnYLTM/0a7JQdeoxsOEqKKJQG+38+Ow=
X-Gm-Gg: ASbGncutwbhJdBtdR34zYwjfW4Ii/UrbqVfhgWh3GEzlblAR73/BiEh7rHZ+pF1ktT9
 Lsy0Go0bdbnJvltw3I87NMzFn7XC8+VySBuarPlhwbNXuZcSuZyONM0jT9cmyUITx/BqIVU0HAk
 g4rv/NZaA0jlC1R8QE8i16rhTL83FG7VIaRRN0RD2epJgF14/rnjl9VnQwAb/Blu5rUQUWJEevm
 LfOJLnpYAehWvrymIwX02ulUn7z50KN9B9ZdR7t18qlRia0pbVEE+LCSt1TWQDIWyotUUEExkhu
 VRbH9dpXCr5GC/JTquvwzRy0wcZukda08KFGWYDu+LpSC2/aUIyy
X-Google-Smtp-Source: AGHT+IEFIPNOwM12PfFmRnRYt9wEpmW6/T0LAWP8eJ78RW6gCLXi40VCYVLyXPDRukCryUwop7vrUQ==
X-Received: by 2002:a05:6402:3591:b0:607:27bb:7bf with SMTP id
 4fb4d7f45d1cf-60727bb09f7mr1674199a12.32.1749113462258; 
 Thu, 05 Jun 2025 01:51:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60727b8bdf5sm750673a12.66.2025.06.05.01.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 01:51:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 869985F7E4;
 Thu, 05 Jun 2025 09:51:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  John
 Snow <jsnow@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Alexandre Iooss
 <erdnaxe@crans.org>,  Gustavo Romero <gustavo.romero@linaro.org>,  Markus
 Armbruster <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Julian Armistead
 <julian.armistead@linaro.org>,  Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [PATCH v4 03/17] tests/tcg: make aarch64 boot.S handle
 different starting modes
In-Reply-To: <e037e38c-dd8d-4f65-b2d5-2629be5f6740@daynix.com> (Akihiko
 Odaki's message of "Thu, 5 Jun 2025 17:29:16 +0900")
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-4-alex.bennee@linaro.org>
 <e037e38c-dd8d-4f65-b2d5-2629be5f6740@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 09:51:00 +0100
Message-ID: <874iwu372j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/06/03 20:01, Alex Benn=C3=A9e wrote:
>> Currently the boot.S code assumes everything starts at EL1. This will
>> break things like the memory test which will barf on unaligned memory
>> access when run at a higher level.
>> Adapt the boot code to do some basic verification of the starting
>> mode
>> and the minimal configuration to move to the lower exception levels.
>> With this we can run the memory test with:
>>    -M virt,secure=3Don
>>    -M virt,secure=3Don,virtualization=3Don
>>    -M virt,virtualisation=3Don
>> If a test needs to be at a particular EL it can use the semihosting
>> command line to indicate the level we should execute in.
>> Cc: Julian Armistead <julian.armistead@linaro.org>
>> Cc: Jim MacArthur <jim.macarthur@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v4
>>    - drop post eret nops
>>    - proper error string for EL0 error case
>>    - clamp any invalid target EL value to 1
>> v3
>>    - create system stack so we _exit cleanly
>>    - normalise EL string before compares
>>    - catch when we start in a lower EL than we asked for
>>    - default to EL1 when arg unclear
>> v2
>>    - allow tests to control the final EL we end up at
>>    - use tabs consistently
>>    - validate command line arg is between 1 and 3
>> ---
>>   tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
>>   tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++-
>>   2 files changed, 169 insertions(+), 6 deletions(-)
>> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
>> b/tests/tcg/aarch64/Makefile.softmmu-target
>> index 9c52475b7a..f7a7d2b800 100644
>> --- a/tests/tcg/aarch64/Makefile.softmmu-target
>> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
>> @@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
>>     # vtimer test needs EL2
>>   QEMU_EL2_MACHINE=3D-machine virt,virtualization=3Don,gic-version=3D2 -=
cpu cortex-a57 -smp 4
>> -run-vtimer: QEMU_OPTS=3D$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
>> +QEMU_EL2_BASE_ARGS=3D-semihosting-config enable=3Don,target=3Dnative,ch=
ardev=3Doutput,arg=3D"2"
>> +run-vtimer: QEMU_OPTS=3D$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kern=
el
>>     # Simple Record/Replay Test
>>   .PHONY: memory-record
>> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/=
boot.S
>> index a5df9c173d..8bfa4e4efc 100644
>> --- a/tests/tcg/aarch64/system/boot.S
>> +++ b/tests/tcg/aarch64/system/boot.S
>> @@ -16,6 +16,7 @@
>>   #define semihosting_call hlt 0xf000
>>   #define SYS_WRITEC	0x03	/* character to debug channel */
>>   #define SYS_WRITE0	0x04	/* string to debug channel */
>> +#define SYS_GET_CMDLINE 0x15	/* get command line */
>>   #define SYS_EXIT	0x18
>>     	.align	12
>> @@ -70,21 +71,172 @@ lower_a32_sync:
>>   lower_a32_irq:
>>   lower_a32_fiq:
>>   lower_a32_serror:
>> +	adr	x1, .unexp_excp
>> +exit_msg:
>>   	mov	x0, SYS_WRITE0
>> -	adr	x1, .error
>>   	semihosting_call
>>   	mov	x0, 1 /* EXIT_FAILURE */
>>   	bl 	_exit
>>   	/* never returns */
>>     	.section .rodata
>> -.error:
>> -	.string "Terminated by exception.\n"
>> +.unexp_excp:
>> +	.string "Unexpected exception.\n"
>> +.high_el_msg:
>> +	.string "Started in lower EL than requested.\n"
>> +.unexp_el0:
>> +	.string "Started in invalid EL.\n"
>> +
>> +	.align 8
>> +.get_cmd:
>
> Please do not send a new version without addressing all comments for
> the previous versions or at least noting there are unaddressed
> comments:
> https://lore.kernel.org/qemu-devel/7a76e746-9022-48cf-8216-775071e6d631@d=
aynix.com
>
> Following the best practices in docs/devel/submitting-a-patch.rst will
> ensure a smoother patch review. It is fine for me if you submit a new
> version noting unaddressed comments, but some may disagree.

There is no style guide for assembler. I have made the strings
consistently use the . prefix.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

