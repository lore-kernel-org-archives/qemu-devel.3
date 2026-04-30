Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51791CD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYfI-0007A8-LL; Thu, 30 Apr 2026 17:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYfC-00078u-TU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:11:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIYfB-0003le-3z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:11:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so12230415e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777583471; x=1778188271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2d8AhPvxOgNXbHHOP+pS9E2glqx8OE+fYauqQN8rph4=;
 b=XO6Ql7qnC53oBswns+XMbaOAqVJ4M1LHfpLp4L/3Xx3KbwsGL+hBhR1bpjJ5QuyxgM
 8bHa2eKHH16MhZeoGDDOl/obstMqJ/0JpwzHFjc6QgEB5SIf0tSD5HLxNKbeGoCA8Gsi
 cCIWM/E8rUzg5PKixhxOW59HbMbmJK24ulGT1N13cvCfXUp8WjlI2F/4AZvqUa7vzfyi
 xRQbjma3P4C6Y33kzcXUD/1HaMNvFTDgmnZHONxXJzW0TUj82pm+qNMwYUQl1JNJdiGH
 jmBO/sFFpBIvjC0NlPBS5U90eAeeV7PQ2ZA7dBURSuCawwGXGXNzDwfXzukcJLsp9t/D
 iaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583471; x=1778188271;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2d8AhPvxOgNXbHHOP+pS9E2glqx8OE+fYauqQN8rph4=;
 b=MWfU93fackZl6ZMYrTTCFINabIQIgdye6o0EEJEEOaBl+maRI5KRltitZYx2M1WTOe
 OrZCGp4nJTva049m9T8i8WNjl+Y5ykun9sHYez09lHlMWsfnI8fneYVKX/zPLrPpyzvM
 0KJY0FYcPSXoxcH7o8nmhkuVAqmmZCyq5Hr0AW0EoSy6koW2YOmPxd1Ewh5LY9DvQ0ix
 cazv3haRI35kJLFEiYSUrJknLU9qjQoS1r9kd2MyGm5kTHAzNClSUIzQdrkHUdrWgZU7
 nCTXNTfRRkHO6OU55QSEAaiUrjjRududd56EHAHNtSew6saNpVejiXY+I4mhei6HgW4L
 TKrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KauHs02eD6zNjTh30HUQJnLGALCSSybVKL/Rkph4SVKxFRxXBinhqNF917pPLfCgQhRwtkJ/QIsMA@nongnu.org
X-Gm-Message-State: AOJu0Yxk2eq7KbG8u1M8wwTTmSq57dBLDes0ieG4HpRpaf1xWNabuNiB
 EGOlbdrNk9wnDQ8L70H3ohxjpv3efWTvVJ9LytLmyXYCg57Qz3BuaGdIepxFwV6kmaw=
X-Gm-Gg: AeBDietd9w7A9TZbgJ9t2C/hfkqSC8AytlY6KvTw109QXR9kqnvqOPYTjEUQeEOQ3Bc
 6SK2AHibYMApMrVDTIvJHdYq+umI9chUQTi3Sb5yv+aPb9WpBhtNvgfEit6A48+W9QvJJetC7cR
 6bLs/SeVuQGhUwSBu5Hyyz5x7CYTSeP8abHXLG76E0jG5Lz+5apSAXdLWOIG3k1Wbh03Il/WvPJ
 6x/yBXIw+Kj7kkwkQ1kwXBcvKT0FI4mvo9jYuULJkJUfDdjOKoVW8mXpsf7ElvIJ1S9gtnpRehd
 CGnop10NB7sr5r24PcBBVDl4hSDrjMYojzYkvW+LxMD1hQtSYyg6k11RVDWeuoZPoDEmMHWKpa1
 Y/3HK4c3WBk6IOSrL6lOylc0BG+K40iDB0jwrSs86AyVMIjkQ08IED9OJtEQUe5HSZp5GEHpShk
 lNwlOixUK3zq0LUdgbJJwUZiYY6h4JcfStPQVglW85Tr4NnEnIZIgWXmOX44rcWPlbEa1dTUWhL
 LY3
X-Received: by 2002:a05:600c:8217:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-48a84444973mr81372635e9.14.1777583471451; 
 Thu, 30 Apr 2026 14:11:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb2fa5sm5919245e9.12.2026.04.30.14.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 14:11:10 -0700 (PDT)
Message-ID: <75c8fcab-61eb-4c27-ad10-0180f335e85c@linaro.org>
Date: Thu, 30 Apr 2026 23:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] qemu/module: add a new QOM_EARLY init step
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430203842.29156-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430203842.29156-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 22:38, Pierrick Bouvier wrote:
> This step will be used to initialize fundamental QOM types, like OBJECT,
> INTERFACE or TARGET_INFO that will be introduced in this series. It may
> be used in the future if needed.
> 
> We need to patch all call sites to module_init(MODULE_INIT_QOM) to call
> module_init(MODULE_INIT_QOM_EARLY) as well.

Just wondering, could we add some module_type dependency, so
when module_call_init(MODULE_INIT_QOM) is called and
modules_init_done[MODULE_INIT_QOM_EARLY] is not set, then
it calls module_call_init(MODULE_INIT_QOM_EARLY) first.
Modifying module.c for that is trivial, but I couldn't find
where to register such dependency (keeping module.c generic).

> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   bsd-user/main.c                         | 1 +
>   include/qemu/module.h                   | 2 ++
>   linux-user/main.c                       | 1 +
>   qemu-img.c                              | 1 +
>   qemu-io.c                               | 1 +
>   qemu-nbd.c                              | 1 +
>   rust/hw/core/tests/tests.rs             | 1 +
>   scsi/qemu-pr-helper.c                   | 1 +
>   storage-daemon/qemu-storage-daemon.c    | 1 +
>   system/runstate.c                       | 1 +
>   tests/audio/test-audio.c                | 1 +
>   tests/qtest/bios-tables-test.c          | 1 +
>   tests/qtest/fuzz/fuzz.c                 | 1 +
>   tests/qtest/migration-test.c            | 1 +
>   tests/qtest/qos-test.c                  | 1 +
>   tests/qtest/tpm-crb-swtpm-test.c        | 1 +
>   tests/qtest/tpm-crb-test.c              | 1 +
>   tests/qtest/tpm-tis-device-swtpm-test.c | 1 +
>   tests/qtest/tpm-tis-device-test.c       | 1 +
>   tests/qtest/tpm-tis-i2c-test.c          | 1 +
>   tests/qtest/tpm-tis-swtpm-test.c        | 1 +
>   tests/qtest/tpm-tis-test.c              | 1 +
>   tests/unit/check-qom-interface.c        | 1 +
>   tests/unit/check-qom-proplist.c         | 1 +
>   tests/unit/test-authz-list.c            | 1 +
>   tests/unit/test-authz-listfile.c        | 1 +
>   tests/unit/test-authz-pam.c             | 1 +
>   tests/unit/test-authz-simple.c          | 1 +
>   tests/unit/test-char.c                  | 1 +
>   tests/unit/test-crypto-block.c          | 1 +
>   tests/unit/test-crypto-secret.c         | 1 +
>   tests/unit/test-crypto-tlscredsx509.c   | 1 +
>   tests/unit/test-crypto-tlssession.c     | 1 +
>   tests/unit/test-io-channel-buffer.c     | 1 +
>   tests/unit/test-io-channel-command.c    | 1 +
>   tests/unit/test-io-channel-file.c       | 1 +
>   tests/unit/test-io-channel-null.c       | 1 +
>   tests/unit/test-io-channel-socket.c     | 1 +
>   tests/unit/test-io-channel-tls.c        | 1 +
>   tests/unit/test-io-task.c               | 1 +
>   tests/unit/test-qdev-global-props.c     | 1 +
>   tests/unit/test-qdev.c                  | 1 +
>   tests/unit/test-smp-parse.c             | 1 +
>   tests/unit/test-throttle.c              | 1 +
>   tests/unit/test-vmstate.c               | 1 +
>   tests/unit/test-xs-node.c               | 1 +
>   tests/unit/test-yank.c                  | 1 +
>   tools/i386/qemu-vmsr-helper.c           | 1 +
>   48 files changed, 49 insertions(+)


