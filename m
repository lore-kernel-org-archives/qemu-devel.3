Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121810706C1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Lh5-0004WF-Hk; Sat, 14 Mar 2026 05:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1Lh2-0004W4-12
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:54:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1Lh0-00057u-IA
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:53:59 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48374014a77so29064305e9.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773482035; x=1774086835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtG+fUElE2P2S+fzsGIfdaDn0vJVjqmw6NSGMQWVeos=;
 b=r8zXjif7QlHN76vBwM7E8kjQk8ZNFXwqF07AqaB4Uxd1or6JybOS++mWWYtTYRCLSZ
 KREoZE2u98IxE0iOgRiKnytLBoO91H44eFKryit0TfNhNQEjjBoKgfsJ484BG7RoLhoW
 RE/nJrTI3ZY5NmGQNonXF1iDo2GmHjQQZbBhBszExtu76+f1p8d7yhhNolBq2r/xgXB+
 SliFLGmsHhQ5xd6so5bVdCGNwY1+m6/Jw4vq+E6f374SwmFdeDXWx3jGrAm+blH9liVU
 tEYc2MPFKECqkS3xfgRXCz+fMEPZcgtI7k0HUKVGkHFsqXKA1Jn0iQkYmUlGedVqEqy6
 Jpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773482035; x=1774086835;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtG+fUElE2P2S+fzsGIfdaDn0vJVjqmw6NSGMQWVeos=;
 b=gk4HqcZde1PLoHykzBM7PbAmbIls01nOSSrfhe8b5kAVv0L3xZYd0FuZTBnfzxWn3W
 Fyz7eg/09SsObUWYl9fNeaX6Ay+g82VOlMVMhllwII62H4huXYHZGP92dZoyA9G/woCU
 wJXLY7V3hUJEsvd4xbqpsoACgEla33QHqy4no1Pm2xgadc/z9M994jVeKjaizGWtK+8n
 Tdok5TKz/FSV2ecIJOjgAE/d2AO7NfQIVEIL+U1OVRSvrExLdUsmdZh8ReTLmO1vCxmp
 Qe3Amp5XvXn/5Jr8NOWCNnEDlyjSBBYzZs6T43b8pOEH9ZrGrwM7g3DQzotyXYrOnCRp
 d3tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHvDjqLex6bVTvxKrANPcnYG98wTC7pzehKj280OmzWedxm9x0JSCQJDDBAAtKphnoTZOXw6mmIIg0@nongnu.org
X-Gm-Message-State: AOJu0YxxPTPvrp8CKO1l6okXB3CGtP/3fp35ToEUkYTSQSG4qWxajtXy
 ljx4lAGMjzktBQwtQqoB4dowtxnKJ8VdIs7LWSXEXFi/QB9647tEjvL+nQsKAX2uxl4=
X-Gm-Gg: ATEYQzyLIjvfBqDekiaO+05vFKjMq53KzE0cHiKPZ9v/0SnnoXetr6qQGafA4uiyDQC
 gCqT4lOz3KY/8+82zBBNSd3753K/roacZP8U9xYgkNOiig1PQrzZHKGaKgDaW9+qtltdE7i4MwU
 XNTnpyLCJneiRaMmQ0C7r8aDTfBPLpR6bbtDqGeLEprvdsHtGxd5ndV+x1DL4c0WC3C2/LXeY2D
 DdPAUy52aRFrE77FJ5qduoKveERrVmdPgzTnKR3h30E4i4I50znuL0uvayRlnCTNxExUQ8B93c6
 dIq0j+AfsfH/8idXT0E/7tWVWTk0KLfbMU48rUG7anrmiksHjYwiYzXgu6CB90EnRcuS/Jj0B4O
 GDM6rfeoh4+LPDcZoxEqOP/xffHwG5nT08xrxwsWpQNh/mzkovTArFd7E5HWkGmMXr3JD/YsKXj
 ia8uXrznR5OTguoR6JpGMYYFsqDRIbspF6awKma1uQHdEvjgMsMB9bVtnQDG82N6aylg==
X-Received: by 2002:a05:600c:3550:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-4855670c971mr110405175e9.29.1773482035301; 
 Sat, 14 Mar 2026 02:53:55 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5e9179sm264520115e9.3.2026.03.14.02.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 02:53:54 -0700 (PDT)
Message-ID: <5950bda3-585a-49c1-a1ef-c7b7653d89aa@linaro.org>
Date: Sat, 14 Mar 2026 10:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] tests/qtest: Don't dup machine name in
 qtest_cb_for_every_machine callbacks
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-2-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260313182957.28432-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 13/3/26 19:29, Fabiano Rosas wrote:
> The qtest_get_machines function caches the list of machines in a
> static variable. Dup'ing the machine->name string only serves to leak
> that memory when a single test is executed.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/cpu-plug-test.c | 11 +++++------
>   tests/qtest/qom-test.c      |  3 +--
>   tests/qtest/test-hmp.c      |  3 +--
>   3 files changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

