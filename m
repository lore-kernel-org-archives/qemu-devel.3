Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB210C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 23:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbpDy-0001hZ-Kz; Sat, 25 Jan 2025 18:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbpDw-0001hM-Jd
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 18:05:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tbpDu-0004Cy-7z
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 18:05:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso22853735e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 15:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737846351; x=1738451151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eercXj945o7oJZHQCGogwU6yR8cOAMFLmy9oLFZPEo8=;
 b=k7sxXjDXWYumpoTD3OGuzxFdLJKWQ1lTH8aUB0/lEw7bffBqIdFrMD8ytvu5CIG809
 jvsESHiR7ZDpdqyWl6U/JH9/Dd3g07JQCvckzxwE70GyQ4N0H2C7g0BnxR6AtxGi3+PZ
 lcF1ZQ9U3e5Y4ssDgcRLf0txwBWgvTR8MWYNTwdG6Tm/t2MrASQp+2IyrYqCOkqPBiAf
 /L/eNJoJtSpzufIO11XoGuBzlGHSpB2b2XXQGonNi8Fqe5m7XY7C7TU+1024DUMEWVzL
 6bN3y0KCCFe+jATVNpGuaXsVsCFMdegsW8Emh2Kjz0g9j43snmlJtAJtBp+TcnEAs8XM
 Kpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737846351; x=1738451151;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eercXj945o7oJZHQCGogwU6yR8cOAMFLmy9oLFZPEo8=;
 b=FNjwY4O9i1EwKti3qiBYUWgnzZNkmHZajfRZIUySVFsKvRX6LCWutu0qqpf18UP6p3
 HFs8QVQpeFc6zpIbCdWI73HusrShAVo+D/THiReOfTPdbTUY2sT52Aiph3kRtgVlA+m7
 h8uYkirHwdxdUr/PV9Ekw5Pf+VdNtv9+V7cbFCreq0AuwCjoxul0cS3h1VL2rRw9xn5H
 OOV7Nu2QIc5qpHsvw+malJ7eQVYFiaIf3GcfXgAMgx5Kad+IuySphtqdVDdSXp+dEqz6
 5ac1dqOXShQK69VC4KNGxj+GNgGRIvr4Jix/vgP2nUnlYmPihW5fk7pVURa/UVVADp54
 io0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2dM9lH5yaQHGod+igCuqEZ30fT5iq8q96hskPuV4uFrhh/JfDRU9K3uLVIz77sa+4lztWnF5JA2pU@nongnu.org
X-Gm-Message-State: AOJu0YxHEa7Wr6QmgoWD7e6QTujp9dlN3/E6U3X/eQxtOddeB+wIVSws
 lgPJW7vPzgNyA/CCygCh2TseD2YuX+C4edtD7YCzJHXGKyiqeeOsMyiGTC/lbOE=
X-Gm-Gg: ASbGncvOXJSJVc+PzOL6L41ouF3m8VOellDmAkNjXcEisR7YioWRbAeu48e6B/BKFst
 eEaIuY7zKboQCsO3k+HZOrmoLROc9MoCKmrzWAAhgb3k0czEc8DfT5qDTndge+ULFoeXZVMqAr0
 us+xNbG6BHkz8RbLl74UK5wxdfpbacwDy8qwpSTbUitZZICydFXgXFcT8TPIWMWqYitJGORS7iS
 QVV11QQzCUx6+H+yBmc14pOQe99PfmRtxSGzKWVs/rhTO3BVbWCsOAc6J8k8MIflkes1XX8xP5r
 JpY=
X-Google-Smtp-Source: AGHT+IFBrtduqdoIxt+Lashl/e2b6SIOlGV+KMO0hJYNQeiCYeSWDrZ3Hk7FZHhUDI4wIObI+7t77Q==
X-Received: by 2002:a05:600c:1c93:b0:434:fbda:1f36 with SMTP id
 5b1f17b1804b1-438914299bdmr309820165e9.20.1737846351098; 
 Sat, 25 Jan 2025 15:05:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm75127935e9.6.2025.01.25.15.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:05:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 870A55F94A;
 Sat, 25 Jan 2025 23:05:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PULL 15/32] tests/functional/aarch64: add tests for FEAT_RME
In-Reply-To: <a5f10050-1914-4f58-a71e-0703ab9a5a19@linaro.org> (Pierrick
 Bouvier's message of "Fri, 24 Jan 2025 08:18:56 -0800")
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
 <20250110131754.2769814-16-alex.bennee@linaro.org>
 <d9094d1e-10bc-4b15-9efe-ebc8bab5d158@redhat.com>
 <a5f10050-1914-4f58-a71e-0703ab9a5a19@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 25 Jan 2025 23:05:49 +0000
Message-ID: <877c6itrxu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Hi Thomas,
>
> On 1/24/25 05:29, Thomas Huth wrote:
>> On 10/01/2025 14.17, Alex Benn=C3=A9e wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> This boot an OP-TEE environment, and launch a nested guest VM inside it
>>> using the Realms feature. We do it for virt and sbsa-ref platforms.
>>    Hi,
>> FWIW, I just saw this test_aarch64_rme_virt test failing once.
>> Looking at
>> the console.log, it seems like the guest crashed somewhere at the end of=
 the
>> firmware or very early in the kernel:
>> EFI stub: Booting Linux Kernel...
>> 2025-01-24 13:25:28,226:
>> 2025-01-24 13:25:28,226:
>> 2025-01-24 13:25:28,227: Synchronous Exception at 0x00000000BF526498
>> 2025-01-24 13:25:28,227:
>> 2025-01-24 13:25:28,227:
>> 2025-01-24 13:25:28,228: Synchronous Exception at 0x00000000BF526498
>> I wasn't able to reproduce it afterwards anymore, but in case
>> somebody runs
>> into this later again and wonders if it is a later regression: It happen=
ed
>> for me with commit cf86770c7aa31ebd.
>>    Thomas
>>=20
>
> I met this kind of error before (not on rme), and if I remember well,
> it's coming from EDK2.
>
> We might have a race condition here.

I'm measuring a 1-3% hit rates:

  retry.py -n 400 -c -- ./pyvenv/bin/meson test --setup thorough --suite fu=
nc-thorough func-aarch64-aarch64_rme_virt func-aarch64-aarch64_rme_sbsaref =
-v

Gave:

  Results summary:
  0: 388 times (97.00%), avg time 196.924 (7.99 varience/2.83 deviation)
  1: 12 times (3.00%), avg time 1205.900 (0.00 varience/0.01 deviation)
  Ran command 400 times, 388 passes

It might be worth trying it under rr --chaos mode and seeing if that
shakes anything out.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

