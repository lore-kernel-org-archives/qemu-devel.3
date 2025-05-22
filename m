Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6757AC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Df-000118-QF; Thu, 22 May 2025 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI3Dc-0000nH-FU
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:32:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI3DS-0006lc-Ud
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:32:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a36ab95a13so3114788f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747909915; x=1748514715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVfeZE4/OnXx9R+daZQfc/d9GFHawu2i98auKpXPFTE=;
 b=W6s/gVaZe53FadezNF2qTMsFXUmyFE9BEtKLgfRtrfefUhkA3yuoGpi7A/Tg/ue3NZ
 SC8XVGtgtJnmQT15t/d/s01LBRdwLxeCaTVV+E+Z4iD1nGa5qnwXp4nimUATC0bJvlmP
 gv9okl0cQvd1NGNyhZ392Hb4EYMQhxvlzDhJhB8NQxi7tKmgeEbUhfQyqhx4JzyghXsy
 0Qb79ccJUXzKcfeA1Adl6sz90MV3OlsIzTtk4003sKkV7SWArtrra4o+s3a75rEULXYY
 DRfHuTaqGrqgWGYkKolDu+OprncjZ7c9+Xv9N9+wyHnMnSgnfm7pFVlFfgcnGCQYkvz5
 4N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747909915; x=1748514715;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVfeZE4/OnXx9R+daZQfc/d9GFHawu2i98auKpXPFTE=;
 b=h6cgUc8hQyDTLLxlLv+8K6U8GXaTHJM3j5XFpwhspXIoo5O2L2hZ/wCWyeJz3GiW2H
 c8afMOxB4vFxcdExm2k/2o0joLFWIFWpQBersafiNMAa+OVQyP0ce4myHbCikq6nmOF6
 SLlMg/0UdeZxM8cDn2thbBbMxcdf+o5Q4E1fSQ/4wwaCs5fdDVTU+1p9EU9MvwjLuJ9t
 rq+VRZoyfxuMEI7MIUcoTnnYkoycQ7h8DCVBukmpiGbPR8azG0/b2PEZQSGY1gbHrul+
 7ds0uyJxUjQb9jIrnBjpSgafxIlsM9YX2GLv/lRRq+nEoYm3C6R4BpXMBuxWssL+NKw9
 DWvg==
X-Gm-Message-State: AOJu0YyWc5DhdmbOkjCh5dY43RXrE2XOReSsvKWEE383CqHtAvnMd1cJ
 +cniSk8R3TfqeJ/kSVwbZ7o5Hpt6x6iIo5QxKRSwdLdpS30jNGXUP3R0JIuvArTw7bA=
X-Gm-Gg: ASbGnctsiURq3w4H/UCdR32KY3HetIqKKlq50czVeyRm5VeZSyv4IsbFKGWoMGQd4OO
 RXgAa50GPYX7B6tDM7W9xrmf6Zxy0MyrUKLfy4pUSMlEC6s+97vmlvKavSxz5FgPzKfED7cQqfM
 Sg3i3c64wRIAz60ftc1jNEvgg6p5wGJlbR2P2LKzpWalcEQkk2HgY6v2+8D73YkWF8ptE4lM/uc
 lbrEYaiYjLqirH+ANqC/fqQlw/sTJzusGQ/5FXFHt276RZFoXkf67T28i2d6yWXOWkhBwzvL3iP
 skpsLJKk9RXu5M1DRwCEVkknYEjxtPDl5QR1H8AOct4TP1IMyQuB
X-Google-Smtp-Source: AGHT+IH8vsIljR4g3fT+QVZ5C0bTzA+s7wC7AyYRcniQBqZ6byLqy4PbKklkFpaKWN+L489FL877Cw==
X-Received: by 2002:a05:6000:2282:b0:3a3:7bbc:d94e with SMTP id
 ffacd0b85a97d-3a37bbcdc22mr10341995f8f.6.1747909915154; 
 Thu, 22 May 2025 03:31:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8caaasm22312941f8f.83.2025.05.22.03.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 03:31:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C09BA5F944;
 Thu, 22 May 2025 11:31:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Markus Armbruster
 <armbru@redhat.com>,  David Hildenbrand <david@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 05/20] tests/Makefile: include test-plugins in
 per-arch build deps
In-Reply-To: <15677d5c-cd86-4d75-a21e-0c011800cd55@daynix.com> (Akihiko
 Odaki's message of "Thu, 22 May 2025 14:37:44 +0900")
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-6-alex.bennee@linaro.org>
 <15677d5c-cd86-4d75-a21e-0c011800cd55@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 11:31:53 +0100
Message-ID: <87tt5d6ina.fsf@draig.linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
>> The user can run a subset of the tcg tests directly, e.g.:
>>    make run-tcg-tests-hexagon-linux-user
>> but in this case we fail if there has not been a full build to
>> ensure
>> all the test-plugins are there. Fix the dependency to ensure we always
>> will build them before running tests.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/Makefile.include | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 23fb722d42..7f7f62cbf6 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -46,7 +46,7 @@ $(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>           $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-hos=
t.mak))
>>     .PHONY: $(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%)
>> -$(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%): build-tcg-tests-%: $(BUILD_=
DIR)/tests/tcg/config-%.mak
>> +$(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%): build-tcg-tests-%: $(BUILD_=
DIR)/tests/tcg/config-%.mak test-plugins
>
> I don't think this is going to work.
>
> test-plugins will invoke run-ninja, which is defined as follows:
>
> run-ninja: config-host.mak
> ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
> 	+$(if $(MAKE.nq),@:,$(quiet-@)$(NINJA) $(NINJAFLAGS) \
> 	   $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat)
>
> $(ninja-cmd-goals) should contain test-plugins, but it doesn't if I
> understand it correctly.

It certainly does:

=E2=9E=9C  rm -rf tests/tcg/plugins/
=F0=9F=95=9911:31:03 alex@draig:qemu.git/builds/all  on =EE=82=A0 HEAD (61e=
51c3) (REBASING 5/26) [$?]=20
=E2=9E=9C  make test-plugins
/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson introspect --targets -=
-tests --benchmarks | /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python=
3 -B scripts/mtest2make.py > Makefile.mtest
[1/14] Compiling C object tests/tcg/plugins/libbb.so.p/bb.c.o
[2/14] Linking target tests/tcg/plugins/libbb.so
[3/14] Compiling C object tests/tcg/plugins/libempty.so.p/empty.c.o
[4/14] Linking target tests/tcg/plugins/libempty.so
[5/14] Compiling C object tests/tcg/plugins/libinline.so.p/inline.c.o
[6/14] Linking target tests/tcg/plugins/libinline.so
[7/14] Compiling C object tests/tcg/plugins/libinsn.so.p/insn.c.o
[8/14] Linking target tests/tcg/plugins/libinsn.so
[9/14] Compiling C object tests/tcg/plugins/libmem.so.p/mem.c.o
[10/14] Linking target tests/tcg/plugins/libmem.so
[11/14] Compiling C object tests/tcg/plugins/libreset.so.p/reset.c.o
[12/14] Linking target tests/tcg/plugins/libreset.so
[13/14] Compiling C object tests/tcg/plugins/libsyscall.so.p/syscall.c.o
[14/14] Linking target tests/tcg/plugins/libsyscall.so

>
>>   	$(call quiet-command, \
>>               $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
>>           "BUILD","$* guest-tests")

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

