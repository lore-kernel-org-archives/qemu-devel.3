Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9A7E7719C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 12:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWaOo-0006a0-4y; Sat, 11 Jan 2025 07:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaOj-0006Zi-AJ
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:15:25 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaOh-0004Uz-5m
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:15:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so33215945e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 04:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736597721; x=1737202521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgsI0QhZQ4PsPO2z1hPGYNxhDjWOjglByO+QA90ztwQ=;
 b=wxLdLlxTIxUkwuOgNPLrWzaFzew1m0f1iFU3wCWP3hCGfekJIgRI7deuh3MUOG8vK2
 VdSMC401zU7iyEQcWbOo/+p4h3KG7uFRPbmPnUzxlLBhP1b5AtHLhEGOClHVgwBbrcUU
 n++qZq4YRut4m7XBE8uWAsFQhmmvr7w1yDy/p5NCLC/XTOpKXqaOmDANcjyR8TQBb6Ss
 Hu87vHj67JnEIvXlZ4tryoEGhfkBBdM7cZdBq2xASej5Bx4j7IXlivi/pfzW9fQxE8aV
 lewiYU4B093egBvEy+z2Q0PEVMsxea8+DZo5Pjm/f3SpqRCgTn5tyifgRu/gBxkifphh
 oP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736597721; x=1737202521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YgsI0QhZQ4PsPO2z1hPGYNxhDjWOjglByO+QA90ztwQ=;
 b=MaC2oi8deIS1mnO/H0vncv45cj2H02AxKxY1ms9cVk3JJ9NQF1utIwpMgLyDmoNefR
 b/4XLR8WGQ+/xGxEbbdQdpBRaD8pybFqMPZVEEOhGXIreu4z6Ler7APsuJZOh0KUOo7g
 DWkU1ga8Dy3mfR+4dVMDZruM8//prjxSKtOjRCO0AQ/V2V/DljtHfoY/jYuctLzlErER
 ilfeEGj5Wv+lkSbqnNeN0uhoWGchBumakHIzerJz2h13ekyZKzHHzA2sTvaFPJ5Zqg5b
 kgDsBWFk2/V2oFaMVyW5SajckczGU8Vqs6tztarv7fb7FMeg9FlFWyHuJKTMwOaeu37y
 ++xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ1VZeEUpdgymRwXEZnahnT+cKovcIS8iJCqwie4x+rCgDS++JGm2WRT8/iYOOouHg7zpPIcHj+g6s@nongnu.org
X-Gm-Message-State: AOJu0YylUdF8AQX/0qLs7gVKFN/Xz8F1qgvCoK+26a030CQURVC4bxhb
 6F5ObiVxYWpRjOP+3owEybZRbcXFyKzQ6rSbZ7u3L/WZBDkoRtgk7TCWC1xaXr4=
X-Gm-Gg: ASbGncuQVC9VYeFtFg9qBk6N9Fn2hLIWCbhKe0O9kzumFueTf0gp4bC18wYFRlnetgu
 ZtOlgK7xEUOgT49D/3W/F9gby28t+Mdau/RWQb0R5gt3DzdLqXmxluT8Dh1SFH7QZn2nIz1LFzi
 N4uoOZiUFliEQxDgwFTVpt6E7MZzwpTYQzG1JooKdjKZpRXzM6Y3G9rfdnGtW2lwZaqfuNwL2DA
 cy8JJ4DjfwvPPFnNxuJzd5CJgs4e3nRPclNKSpC9AbrEcZSmVK82e8=
X-Google-Smtp-Source: AGHT+IEh8kzauEQ62XNQHD+GM0OZBBoFjOuKpX+UQsgxfWIRBSUIt2Er4+B1n6D8QUuGnKfozyWA0w==
X-Received: by 2002:a05:600c:4ed4:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-436e26c0a33mr141457185e9.15.1736597721372; 
 Sat, 11 Jan 2025 04:15:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d7fsm80653535e9.32.2025.01.11.04.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 04:15:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55A9C5F886;
 Sat, 11 Jan 2025 12:15:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Julian Ganz <neither@nut.email>,  qemu-devel@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
In-Reply-To: <0369698c-0fbe-45f8-bad9-1e6a7b1ed410@linaro.org> (Pierrick
 Bouvier's message of "Fri, 10 Jan 2025 13:02:51 -0800")
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <87frls6q2m.fsf@draig.linaro.org>
 <957c8754b588a3355e18519d644d9bb05d58645f@nut.email>
 <87cygu4s4a.fsf@draig.linaro.org>
 <0369698c-0fbe-45f8-bad9-1e6a7b1ed410@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 11 Jan 2025 12:15:18 +0000
Message-ID: <87frlpwnqh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/10/25 07:15, Alex Benn=C3=A9e wrote:
>> "Julian Ganz" <neither@nut.email> writes:
>>=20
>>> Hi Alex,
>>>
>>> January 9, 2025 at 3:04 PM, "Alex Benn=C3=A9e" wrote:
>>>> Julian Ganz <neither@nut.email> writes:
>>>>> We recently introduced new plugin API for registration of discontinui=
ty
>>>>>   related callbacks. This change introduces a minimal plugin showcasi=
ng
>>>>>   the new API. It simply counts the occurances of interrupts, excepti=
ons
>>>>>   and host calls per CPU and reports the counts when exitting.
>>>>>   ---
>>>>>   contrib/plugins/meson.build | 3 +-
>>>>>   contrib/plugins/traps.c | 96 +++++++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 98 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 contrib/plugins/traps.c
>>>>>
>>>>>   diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.bu=
ild
>>>>>   index 63a32c2b4f..9a3015e1c1 100644
>>>>>   --- a/contrib/plugins/meson.build
>>>>>   +++ b/contrib/plugins/meson.build
>>>>>   @@ -1,5 +1,6 @@
>>>>>   contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', '=
hotblocks',
>>>>>   - 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
>>>>>   + 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>>>>>   + 'traps']
>>>>>
>>>> I wonder if this is better in tests/tcg/plugins? We need to do somethi=
ng
>>>> to ensure it gets covered by CI although we might want to be smarter
>>>> about running it together with a test binary that will actually pick up
>>>> something.
>>>
>>> The callback is intended as an example. The patch-series does contain a
>>> dedicated testing plugin. And iirc the contrib plugins are now built
>>> with the rest of qemu anyway?
>> They do - however we generate additional tests with
>> tests/tcg/plugins
>> with the existing multiarch linux-user and softmmu check-tcg tests. Its
>> a fairly dumb expansion though:
>>    # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>>    # pre-requistes manually here as we can't use stems to handle it. We
>>    # only expand MULTIARCH_TESTS which are common on most of our targets
>>    # to avoid an exponential explosion as new tests are added. We also
>>    # add some special helpers the run-plugin- rules can use below.
>>    # In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS va=
riable.
>>    ifneq ($(MULTIARCH_TESTS),)
>>    $(foreach p,$(PLUGINS), \
>>            $(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
>>                    $(eval run-plugin-$(t)-with-$(p): $t $p) \
>>                    $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
>>    endif # MULTIARCH_TESTS
>>    endif # CONFIG_PLUGIN
>> We also have a hand-hacked test for validating memory
>> instrumentation:
>>    # Test plugin memory access instrumentation
>>    run-plugin-test-plugin-mem-access-with-libmem.so: \
>>            PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
>>    run-plugin-test-plugin-mem-access-with-libmem.so: \
>>            CHECK_PLUGIN_OUTPUT_COMMAND=3D \
>>            $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
>>            $(QEMU) $<
>>    test-plugin-mem-access: CFLAGS+=3D-pthread -O0
>>    test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
>> That said as I mention in the reply to the cover letter the traps
>> stuff
>> might be better exercised with the functional test so could utilise a
>> plugin built in contrib just as easily.
>>=20
>
> I agree, as it was discussed in previous versions, we should add a
> functional test for this. I'm not sure if we should write a custom and
> complicated test, or simply boot and shutdown an existing image, and
> call it a day.
>
> Do you have any opinion on this Alex?

An existing image based test would be fine although I'd favour one that
had multiple exception types (e.g. something with firmware and
hypervisor transitions on Arm or equivalent on other arches.)

>
>>>
>>>>> +QEMU_PLUGIN_EXPORT
>>>>>   +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *in=
fo,
>>>>>   + int argc, char **argv)
>>>>>   +{
>>>>>   + if (!info->system_emulation) {
>>>>>   + fputs("trap plugin can only be used in system emulation mode.\n",
>>>>>   + stderr);
>>>>>   + return -1;
>>>>>   + }
>>>>>   +
>>>>>   + max_vcpus =3D info->system.max_vcpus;
>>>>>   + traps =3D qemu_plugin_scoreboard_new(sizeof(TrapCounters));
>>>>>   + qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>>>>>   + qemu_plugin_vcpu_for_each(id, vcpu_init);
>>>>>
>>>> Hmm at first glances this seems redundant - however I guess this is
>>>> covering the use case you load the plugin after the system is up and
>>>> running.
>>>
>>> Yep, but really that was just me being paranoid.
>>>
>>>> I wonder if you have unearthed a foot-gun in the API that is easy to
>>>> fall into? Maybe we should expand qemu_plugin_register_vcpu_init_cb to
>>>> call the call back immediately for existing vcpus?
>>>
>>> Would probably not hurt.
>>>
>>> Regards,
>>> Julian
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

