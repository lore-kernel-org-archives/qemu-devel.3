Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3411DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCWD-00019T-BV; Wed, 14 May 2025 09:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uFCVy-00017h-MP
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:51:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uFCVw-0000oX-Al
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:51:18 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a206845eadso2410166f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747230673; x=1747835473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XagMRq6IZYSP4GiDDSzm7JdrDd/4kLKpYUHl3d1dJzQ=;
 b=TsamiROBa7nkuVa/H0OUvHvIpw3puC6C2SRD71NYt1/N03hss8MP4bKvg8+7moaNO0
 Z135mm+ogJE0tpQl6MLv8jRSA+8izlXmcWoKeBhEets/0X07YWHVVeHI7BWIQEBbXirP
 03hct0wWfXozYlVp0NLnadx7lPlIWc04amDQe66sq7XFKbr4629HovBXyHHHE+Px+kyH
 5DU5SvyLdFbMWsxHE1JFU5TtBtqaoOpa5yDxtPWkFNCGbTPl5zg55hFr9Vhnu4pLcUqS
 KuB9wCXPZXeUheOZzsu+ZdMKQYUFP+WTJ/s2N35fGchgXO/hWkxfX5FlvmJmQOPH5PFE
 utSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747230673; x=1747835473;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XagMRq6IZYSP4GiDDSzm7JdrDd/4kLKpYUHl3d1dJzQ=;
 b=lAHW5etg4PwF9CuQtMsqsp+GuwIzqHj0dXGZkpzDYe94cLX6/Wydk0e7Y5nqoc79Ob
 ECqFlkFHWXTRXuQM67+TSPJ6PVwRs14ST79FghUp/vJ1EThGO/bjK8Rj+tAYWaMp55zj
 2vbhFtTws4QHEhsrfrJKWyTPopcKsYNrs0lKIRLyNEAtXoK3N9iTub9qapeeqsMXBe0p
 cWsgePSRwI5GctOK7f6CH/B3wdsr50ehxqpUTey4IIBiSGliqPHI2K3+B45iShgvq31U
 dQDWVkHKUGBI0uywj37dxpxagvd91SGFYAXh7f+C4l3p6VbiBtcNBRqCsYCHSHgUdzrO
 tCaQ==
X-Gm-Message-State: AOJu0YzblfRcUb7By/PH4QGbo9vGwxBfDun9JkG/uKlxiDMq0FOiuz15
 IKbca1MCOzq78VSV2I+nAZz2bD+hNrMarQDJfA/ynnOH35zC7DCnVXj+K/5s/1w=
X-Gm-Gg: ASbGnctY3rYUgqafb/ZPYf9VNpi4UcN4cGHthzw9ZM3uVwI0Kob3ta0LhEVD+GbT/R3
 0shS8mMpx78Hcsp2bt4szJKLH6lTiPjBJGyCM4jRuTXsPBWOGb9e8J8D5yyUxt3LE6LN1FXFGgs
 C0rDtnDHqfdRlBTMiwkIMWWxZi5UbM/7wOHWo8LLJOipPS3lcJm/vzaU6Zxrz2Mv+w+jciegq1E
 UDG+tp0oV4Yu5AkQTikXplB6JpiSRzBK4ZMg4w9oakpiu4K9Ax7Xe//L21BKocnyNsuWDPQ2zQJ
 E8+QOgyGwDCEIUTG9WR3qsPzR1xiSb1Q/QnO5W/56axWTzwN3OGPVw==
X-Google-Smtp-Source: AGHT+IHZWxAUwgmI09md/lwh0gZ8SSHJwT8Urs5yv71uzd9dN2Cqn/GJ7LqB+cWwYYXvBlWGmyfZHg==
X-Received: by 2002:a05:6000:2902:b0:3a0:aed9:e34 with SMTP id
 ffacd0b85a97d-3a349952861mr3052417f8f.48.1747230673441; 
 Wed, 14 May 2025 06:51:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5e1sm19568750f8f.89.2025.05.14.06.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 06:51:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CE1945F8AE;
 Wed, 14 May 2025 14:51:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Markus
 Armbruster <armbru@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Julian Armistead
 <julian.armistead@linaro.org>,  Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [PATCH v2 03/14] tests/tcg: make aarch64 boot.S handle
 different starting modes
In-Reply-To: <d2429cfd-d1b1-435c-b202-7f90f7365bf2@daynix.com> (Akihiko
 Odaki's message of "Sat, 10 May 2025 13:21:47 +0900")
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-4-alex.bennee@linaro.org>
 <d2429cfd-d1b1-435c-b202-7f90f7365bf2@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 14 May 2025 14:51:11 +0100
Message-ID: <87r00rxpv4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

> On 2025/05/06 21:57, Alex Benn=C3=A9e wrote:
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
<snip>
>> +
>> +	/* sanity check, clamp to 1 if invalid */
>> +	cmp w11, #'0'
>> +	b.lt 1f
>> +	cmp w11, #'4'
>> +	b.ge 1f
>> +	sub	w11, w11, #'0'
>> +	b 2f
>> +1:	mov w11, #1
>> +
>> +2:
>
> This "sanity check" made me wonder what it is for. This code is simply
> unnecessary if any unknown values are to be ignored and is a bit
> misleading to have this code as it looks like it adds an additional
> behavior. "sub w11, w11, #'0'" is also unnecessary; we can compare w11
> with '2' and '3' later instead.
>
> The patch message says this sanity check was added with v2 so I looked
> for a previous review and found this:
> https://lore.kernel.org/qemu-devel/svmkvs.2mf5q4qhsfz83@linaro.org/
>
>> cmp w11, #'0'
>> b.lt curr_sp0_sync
>> cmp w11, #'4'
>> b.ge curr_sp0_sync
>
> Now I get the original intent; it was to raise an error instead of
> simply ignoring unknown values. However I also see a few problems with
> this original code:
> - It still ignores unknown strings that are longer than one character.

I'm not intending to handle longer strings in assembly - I think we can
live with accepting "1junk" to "3foo".

> - curr_sp0_sync leads to the code that writes a message saying
>   "Terminated by exception.", which is incorrect.
> - "cmp w11, #'0'" is unnecessary if you check the value after "sub
>   w11, w11, #'0'".

I'll clean that up.

>
>> +	/* Determine current Exception Level */
>> +	mrs	x0, CurrentEL
>> +	lsr	x0, x0, #2	  /* CurrentEL[3:2] contains the current EL */
>> +
>> +	/* Branch based on current EL */
>> +	cmp	x0, #3
>> +	b.eq	setup_el3
>> +	cmp	x0, #2
>> +	b.eq	setup_el2
>> +	cmp	x0, #1
>> +	b.eq	at_testel	     /* Already at EL1, skip transition */
>> +	/* Should not be at EL0 - error out */
>> +	b	curr_sp0_sync
>> +
>> +setup_el3:
>> +	/* Ensure we trap if we get anything wrong */
>> +	adr	x0, vector_table
>> +	msr	vbar_el3, x0
>> +
>> +	/* Does the test want to be at EL3? */
>> +	cmp	w11, #3
>> +	beq	at_testel
>> +
>> +	/* Configure EL3 to for lower states (EL2 or EL1) */
>> +	mrs	x0, scr_el3
>> +	orr	x0, x0, #(1 << 10)    /* RW =3D 1: EL2/EL1 execution state is AArc=
h64 */
>> +	orr	x0, x0, #(1 << 0)     /* NS =3D 1: Non-secure state */
>> +	msr	scr_el3, x0
>> +
>> +	/*
>> +	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
>> +	 * otherwise we should just jump straight to EL1.
>> +	 */
>> +	mrs	x0, id_aa64pfr0_el1
>> +	ubfx	x0, x0, #8, #4	      /* Extract EL2 field (bits 11:8) */
>> +	cbz	x0, el2_not_present   /* If field is 0 no EL2 */
>> +
>> +
>> +	/* Prepare SPSR for exception return to EL2 */
>> +	mov	x0, #0x3c9	      /* DAIF bits and EL2h mode (9) */
>> +	msr	spsr_el3, x0
>> +
>> +	/* Set EL2 entry point */
>> +	adr	x0, setup_el2
>> +	msr	elr_el3, x0
>> +
>> +	/* Return to EL2 */
>> +	eret
>> +	nop
>
> Why is a nop placed here?

Left over debug. I'll drop it.
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

