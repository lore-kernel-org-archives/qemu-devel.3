Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A51EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGjx-0007xp-9F; Fri, 10 Jan 2025 10:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWGjt-0007xQ-U9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:15:57 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWGjs-0004Bs-6U
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:15:57 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so1246181f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736522152; x=1737126952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8OrkEcpVp6PRABm6koS5t9LlffJxSoL18R8jm19ocw=;
 b=IRgBESHjSQ0KsP90gzIMO84Ie+PfoZXc0iHYNxFwouRlnL0uS73FAJfEP0KSv1cMg3
 cN7dw32AyeHHYL8a3Zjtw55IWseqZswzN1FrUTcTM5oQiSzFicIKNbzlDA4WTCvsr7Pc
 rLAlFZcnPNi+iqox+eABz0u1XFAvsHMQXGisNoVSDaicjSUAdx9xXAQgsin6dJGZxuLm
 G6GoVngBBxUrRbbmQCYKB22lloOEHCk7mvrqPUnMbIHMzx+vwSTBBCL80+6MV8PalNiR
 NZkSx/ItdMWisIIz802r2uF46fSiJ0WnFGD0fbiSCmNRdPgw4rSGoTNKOEhv7lIM5IB+
 E0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736522152; x=1737126952;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8OrkEcpVp6PRABm6koS5t9LlffJxSoL18R8jm19ocw=;
 b=g1CDhcRFNscEvnUFoE2z1TRlkuLCgeJADDNd+61Pda15WJ7uI9DRjesmwDHz2LI6aH
 8RILa7gMSdXcKuk4q+URi6gDUc6SBmsj1yj2xamHRGt11nsDGh2FHQttvHLHISO/aKkP
 ja58c6D25FJDVW/nxynrQs0nNg2cgGi2VRn3EDL+LhTqLA/jucF8OWi7lCoFODWDMWTc
 UegEzF6gbTc517f1FWJm6Z9QtXFRpqfs0Pg8bMunDIhp5Mr+G4CGErGnrNTniQMjf4X3
 JgaAWdeZ07+zH83ANhqqRW4vkRXgyOgGxeGR6hCQzgCg79W/1rV/YW3xpx+h+gXPOpq5
 03dA==
X-Gm-Message-State: AOJu0YxqR/k5KZovFOghTwggSw+2xvwicNtFM+mh2hW/Tywh9yGjy2it
 e2VQFgtlEovFjVEcJ0QzDDfAyTT/z9F2mlEVX2bg9azw/RCmMCMuZxunOKaiNfE=
X-Gm-Gg: ASbGncs4l019xprSAHtxJuQMe/NWzgYj2a/TyCVzd5VRLlxOxjkW4ZolTY7GAu7VP5D
 VsVRD3D8RoUkg9rgyyMJuFC6nO5XxMzEDMi9n39xZx3Zyi6eD8O4rwIuapWqRwlycWXR/u465Zn
 RXJ8tJ48o9LC6r/7PZUSDaM7v/JX6ZQOzPCWsfZytttUl9T1/yv63LCNvQoKGC5fPJaLQTBWzkc
 P+tFGzP9eInAlXqbcGliLBux3a57aodrhRkVMYAHXoBNyRl28AjFJk=
X-Google-Smtp-Source: AGHT+IH6ec5IaRl8vuTEgSfGSFMUN02hCSpqDi3u/y7gaojYLpBjFfUvCaZVnrB/ArLCgg7/J0jgkQ==
X-Received: by 2002:a05:6000:410a:b0:38a:9d7c:897d with SMTP id
 ffacd0b85a97d-38a9d7c89demr53744f8f.25.1736522151410; 
 Fri, 10 Jan 2025 07:15:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2df2faesm90312405e9.26.2025.01.10.07.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 07:15:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65CF65F8C8;
 Fri, 10 Jan 2025 15:15:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <neither@nut.email>
Cc: qemu-devel@nongnu.org,  "Alexandre Iooss" <erdnaxe@crans.org>,  "Mahmoud
 Mandour" <ma.mandourr@gmail.com>,  "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
In-Reply-To: <957c8754b588a3355e18519d644d9bb05d58645f@nut.email> (Julian
 Ganz's message of "Fri, 10 Jan 2025 11:49:57 +0000")
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <87frls6q2m.fsf@draig.linaro.org>
 <957c8754b588a3355e18519d644d9bb05d58645f@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 10 Jan 2025 15:15:49 +0000
Message-ID: <87cygu4s4a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

"Julian Ganz" <neither@nut.email> writes:

> Hi Alex,
>
> January 9, 2025 at 3:04 PM, "Alex Benn=C3=A9e" wrote:
>> Julian Ganz <neither@nut.email> writes:
>> > We recently introduced new plugin API for registration of discontinuity
>> >  related callbacks. This change introduces a minimal plugin showcasing
>> >  the new API. It simply counts the occurances of interrupts, exceptions
>> >  and host calls per CPU and reports the counts when exitting.
>> >  ---
>> >  contrib/plugins/meson.build | 3 +-
>> >  contrib/plugins/traps.c | 96 +++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 98 insertions(+), 1 deletion(-)
>> >  create mode 100644 contrib/plugins/traps.c
>> >=20
>> >  diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> >  index 63a32c2b4f..9a3015e1c1 100644
>> >  --- a/contrib/plugins/meson.build
>> >  +++ b/contrib/plugins/meson.build
>> >  @@ -1,5 +1,6 @@
>> >  contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'ho=
tblocks',
>> >  - 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
>> >  + 'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>> >  + 'traps']
>> >=20
>> I wonder if this is better in tests/tcg/plugins? We need to do something
>> to ensure it gets covered by CI although we might want to be smarter
>> about running it together with a test binary that will actually pick up
>> something.
>
> The callback is intended as an example. The patch-series does contain a
> dedicated testing plugin. And iirc the contrib plugins are now built
> with the rest of qemu anyway?

They do - however we generate additional tests with tests/tcg/plugins
with the existing multiarch linux-user and softmmu check-tcg tests. Its
a fairly dumb expansion though:

  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
  # pre-requistes manually here as we can't use stems to handle it. We
  # only expand MULTIARCH_TESTS which are common on most of our targets
  # to avoid an exponential explosion as new tests are added. We also
  # add some special helpers the run-plugin- rules can use below.
  # In more, extra tests can be added using ADDITIONAL_PLUGINS_TESTS variab=
le.

  ifneq ($(MULTIARCH_TESTS),)
  $(foreach p,$(PLUGINS), \
          $(foreach t,$(MULTIARCH_TESTS) $(ADDITIONAL_PLUGINS_TESTS),\
                  $(eval run-plugin-$(t)-with-$(p): $t $p) \
                  $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
  endif # MULTIARCH_TESTS
  endif # CONFIG_PLUGIN

We also have a hand-hacked test for validating memory instrumentation:

  # Test plugin memory access instrumentation
  run-plugin-test-plugin-mem-access-with-libmem.so: \
          PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
  run-plugin-test-plugin-mem-access-with-libmem.so: \
          CHECK_PLUGIN_OUTPUT_COMMAND=3D \
          $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
          $(QEMU) $<

  test-plugin-mem-access: CFLAGS+=3D-pthread -O0
  test-plugin-mem-access: LDFLAGS+=3D-pthread -O0

That said as I mention in the reply to the cover letter the traps stuff
might be better exercised with the functional test so could utilise a
plugin built in contrib just as easily.

>
>> > +QEMU_PLUGIN_EXPORT
>> >  +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>> >  + int argc, char **argv)
>> >  +{
>> >  + if (!info->system_emulation) {
>> >  + fputs("trap plugin can only be used in system emulation mode.\n",
>> >  + stderr);
>> >  + return -1;
>> >  + }
>> >  +
>> >  + max_vcpus =3D info->system.max_vcpus;
>> >  + traps =3D qemu_plugin_scoreboard_new(sizeof(TrapCounters));
>> >  + qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> >  + qemu_plugin_vcpu_for_each(id, vcpu_init);
>> >=20
>> Hmm at first glances this seems redundant - however I guess this is
>> covering the use case you load the plugin after the system is up and
>> running.
>
> Yep, but really that was just me being paranoid.
>
>> I wonder if you have unearthed a foot-gun in the API that is easy to
>> fall into? Maybe we should expand qemu_plugin_register_vcpu_init_cb to
>> call the call back immediately for existing vcpus?
>
> Would probably not hurt.
>
> Regards,
> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

