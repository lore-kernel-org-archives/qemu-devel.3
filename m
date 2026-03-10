Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722DAFD2D93
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxR0-00021l-CM; Tue, 10 Mar 2026 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxQu-0001sN-Vr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:47:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxQs-0004bl-D0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:47:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 798214D211;
 Tue, 10 Mar 2026 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbgC6gMDI4w2drEthFWx0JpWXVmiDG4Wzm19OcMcZ2c=;
 b=SagRbUEmAUB8Ca0Dm3panvxwF8Gj5wLezROdyhLNi+pxy9oXt+qsmUnjUHI1mJ3QPHrO9l
 trUrQsvHQFt3PbuL9/1JV5+Brju6JhGyxYPmkW/rbCj1CGsTVsAIBAaDlUUxLff4g3efIc
 G/BAZlzxH+6N9AAGSNhuitc2HRGFblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbgC6gMDI4w2drEthFWx0JpWXVmiDG4Wzm19OcMcZ2c=;
 b=xbz05U8p+59VyA6G6uRFsFUh9Elnb1ViOa4ViVWk85cPR4uGjVIk1GlOKUN0e+H8rEQrxb
 O3RAHZjBrZIRKiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbgC6gMDI4w2drEthFWx0JpWXVmiDG4Wzm19OcMcZ2c=;
 b=SagRbUEmAUB8Ca0Dm3panvxwF8Gj5wLezROdyhLNi+pxy9oXt+qsmUnjUHI1mJ3QPHrO9l
 trUrQsvHQFt3PbuL9/1JV5+Brju6JhGyxYPmkW/rbCj1CGsTVsAIBAaDlUUxLff4g3efIc
 G/BAZlzxH+6N9AAGSNhuitc2HRGFblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbgC6gMDI4w2drEthFWx0JpWXVmiDG4Wzm19OcMcZ2c=;
 b=xbz05U8p+59VyA6G6uRFsFUh9Elnb1ViOa4ViVWk85cPR4uGjVIk1GlOKUN0e+H8rEQrxb
 O3RAHZjBrZIRKiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C543F4AB;
 Tue, 10 Mar 2026 13:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JituL/AgsGn8aAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:47:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
In-Reply-To: <20260309155219.62400-28-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org>
Date: Tue, 10 Mar 2026 10:47:26 -0300
Message-ID: <87h5qn23v5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Warning-Options.html
>> Level 2 warns also about calls that might overflow the destination
>> buffer given an argument of sufficient length or magnitude. At level
>> 2, unknown numeric arguments are assumed to have the minimum
>> representable value for signed types with a precision greater than 1,
>> and the maximum representable value otherwise. Unknown string
>> arguments whose length cannot be assumed to be bounded either by the
>> directive=E2=80=99s precision, or by a finite set of string literals the=
y may
>> evaluate to, or the character array they may point to, are assumed to
>> be 1 character long.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <20260305-nvme-v4-4-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index 102f0cbb13e..f45885f05a1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -694,6 +694,7 @@ warn_flags =3D [
>    '-Wempty-body',
>    '-Wendif-labels',
>    '-Wexpansion-to-defined',
> +  '-Wformat-overflow=3D2',
>    '-Wformat-security',
>    '-Wformat-y2k',
>    '-Wignored-qualifiers',

This gives me:

../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_pins=
=E2=80=99:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=80=99=
 may write a
terminating nul past the end of the destination
[-Werror=3Dformat-overflow=3D]

../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_level_hi=
gh=E2=80=99:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=80=99=
 may write a
terminating nul past the end of the destination
[-Werror=3Dformat-overflow=3D]

../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_mode=
l_expansion_kvm=E2=80=99:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 direc=
tive writing
between 1 and 10 bytes into a region of size 5
[-Werror=3Dformat-overflow=3D]

../configure
--target-list=3Dx86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,ppc=
64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-sof=
tmmu
--disable-plugins --enable-modules --enable-werror
--enable-trace-backends=3Dlog,dtrace --enable-debug --enable-docs
--enable-rust --enable-strict-rust-lints

gcc version 7.5.0 (SUSE Linux)

