Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B85CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvC3-0000M5-0x; Tue, 26 Aug 2025 11:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvBR-0000FV-CW
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:02:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uqvBB-0001qe-Nv
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:02:01 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b4717543ed9so3867524a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756220490; x=1756825290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ACjgcDLvoon9NUbIZIUiX3lyOafa5nmRxOYvYUER44U=;
 b=YNFPzd3s6+DjXeVV3OTMZ4dKSHylqmGRQqoFZSqS/gw9fkBZsulUmYUouJJ/G5qh3u
 L7IgHqnjDagJVaMMiI8JIH79iY3av/21HabWaSwJ7MPt1LWPn2KPyVQYw4D1M1fhQ46y
 vnEZ7EB1CLPxJZqSm7jZ24lOrjXbl/cPyISQQcWvgU90aGxBd0l4JuogW6GMvVGfuJzW
 RCvE4uxgXmSLNOMYS9qkK6lDL5/2WTAsI6Q3p8Q6psU8rT5pzcGDY6NfXyF7d52l0lqh
 Yp01wtWaWrMoCG7iXaX9xzd0euJr1j5weRtyeLbGoOcWvDSl9bvxvsUL4ZqAO/dK01IS
 7Vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756220490; x=1756825290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ACjgcDLvoon9NUbIZIUiX3lyOafa5nmRxOYvYUER44U=;
 b=UgtpzxKkKjcXcbgQDe7g66UUwgRm4SvyVHngH2fkl5GIvJVLfI4C1+Pex9nr5QHZ20
 8n8tXrc+MbOoP/7ZU1ZE4cw/0ZC57C54JKl7i6sL84YPFHq8LLqBo6K2sBI5LU2cEDcC
 7iyIB43ri74uET+4tro755vFxslr8K/ZJEWV76wvVqGk3C/h83Okkow01Fo3Igculzvz
 KP/1EGvTgTBBUuzr7YU6UDz/ubZlvcSMH5jcwKMzg8pGevHk4yAh7OcmJO7g4XuzwHZU
 hX0KZ0kgaYrcRVdXWCiQFH8QFllvvwwGmphnaWi8Z0td0SL7yH/nTFBaV1yXPyhxV/Kh
 HSrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsa8h+LMQHZY556NUVBaIDkCpe20w/9vBk7xCaILq6KIl75OT7NKmav0r/xzlFdrptXuQODMnYP3OQ@nongnu.org
X-Gm-Message-State: AOJu0YxMYwufce2NPHNt2Z4AxFXeojCwIJsviUTl8JNP/HYvMer2Hfqg
 MyXGp/9ad2gO6snELoRZIBWUTaE5A1GuN2zoYM2HzdSVpAtM7cS5ATaIm4UPoJwdByU=
X-Gm-Gg: ASbGncuq2UcTTF6hnMeF6KUcXJPOcoGbCuFdz/9CKl5edOLFA+RvoqpuFrpMynSp/bH
 doFvw+I/nKfO9uVDbqC1VDgXJZOBLAZYCGv13lJQS8NhjiPCJ44oxNQIz/oY9siPbn4MebQWsou
 ct5CyRUEBU5aDAU9bUihQz6i3Nbq6HFAzFyQUdSIATtE1zZXIN6CGcbq4OdmKV3rQKhe18h5Qjy
 rBXQbtSMi2ccajg8XdKELd0Rkl0HlYS1ZCbtc3m67ZrcqhV+xbbFc2OcdH7YduVa6Rmy9vHtbz0
 dzIYbMlm/rPN2I3LUpI34MEh3/J0oA0xW44xicifl0GKvZ0v1RShEwRFDnypOMNynuWjJnkmp/Y
 qQm6/vU4hi1L09IZ9NXO03d86HRUae0gB8A==
X-Google-Smtp-Source: AGHT+IFzkcNmizfxVp90cJeGRZGtt8sjPgJbBdjTdgJgjIyg8JZ4xp+YWZR1k22vtP5uCgX3xVSpaw==
X-Received: by 2002:a17:902:dad1:b0:242:9bc6:63c3 with SMTP id
 d9443c01a7336-2462efaa3b8mr223283535ad.54.1756220489616; 
 Tue, 26 Aug 2025 08:01:29 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.38.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-246687b4f93sm98119355ad.58.2025.08.26.08.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 08:01:29 -0700 (PDT)
Message-ID: <9e08e638-9ab7-44cd-98cb-bd1a5b826f91@linaro.org>
Date: Tue, 26 Aug 2025 12:02:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, 1844144@gmail.com, Jan Richter <jarichte@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
 <57b7b6c1-1820-4475-b84a-05b37cfbefdf@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <57b7b6c1-1820-4475-b84a-05b37cfbefdf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Thomas,

On 8/26/25 05:06, Thomas Huth wrote:
> On 25/08/2025 16.04, Gustavo Romero wrote:
> ...
>>> Anyway, shifting to a different test harness here makes me wonder whether the whole reverse_debug test should maybe be rather moved to tests/tcg instead, where we already have the basic support for the stuff from tests/ guest-debug/ ?
>>> The aarch64 would require a different guest payload, of course, in that case, so not sure whether it's feasible?
>>
>> I think reverse_debugging is really a functional test. It requires GDB, yes,
>> but also QMP and booting a whole kernel and the feature itself makes me think
>> it's a functional test. I wouldn't move it to tcg-check just for the sake of
>> no adding a new way to run test in meson.build in functional tests.
> 
> Ok, fair point. But thinking about this twice, wouldn't it be nicer to keep the current test harness and simply launch the script from the test_* methods instead?

If no additional module is used, then GDB needs to execute the test_* scripts via '-x' option
because only this way the script can do "import gdb", hence we need a runner that will call gdb
and pass the script to it.

Naturally, we can instead use a module like pygdbmi (as Manos suggested) or aautils (with the
caveats I mentioned about having to deal with GDB packets directly) that will simply wrap up
calling gdb and passing it the script with subprocess etc., so no need to augment the test harness.

The trade off I can see is: re-use the runner we use in check-tcg and augment the test
harness to accommodate it in the functional tests _vs_ use the "runner" from another module,
bring another python dependency and deal with another GDB API (I like using GDB native Python
API because it's simple, sufficient and self-contained, but I'm open to experiment with pygdbmi),
use another runner (other than the one in tests/guest-debug/test_gdbstub.py) and don't modify the
test harness.


> You could redirect stdout of the script into a log file, so that it cannot mess with the TAP output of the test. Or is there something that I missed and this cannot work?

Yeah, I really tried it but redirecting to a file using GDB Python
API didn't work :-(

I've tried to redirect GDB's output from the test script using
"set logging redirect on" but something is off. I even tried on GDB
master, but besides direct not taking effect (output is still printed
to the stdout) I got a GDB internal error when switching it off.

So, yes, it would work (even adding a # in the output messages so the
TAP protocol would simply ignore the lines at the same time we would
be able to see the output from GDB), but I was not able to make it work
with GDB native Python API, so turned to use the "exitcode".


Cheers,
Gustavo

