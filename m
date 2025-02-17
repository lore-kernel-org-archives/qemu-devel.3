Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF082C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 20:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk7cv-0008Ep-6O; Mon, 17 Feb 2025 15:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk7ct-0008EO-Og; Mon, 17 Feb 2025 15:21:59 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk7cs-0007Yr-2t; Mon, 17 Feb 2025 15:21:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e04c044224so2861395a12.0; 
 Mon, 17 Feb 2025 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739823716; x=1740428516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZREVhBW3YhrKhq8Mmtpeghu4/sgYahbIKLxpHaZzI+U=;
 b=aRcET85iRw6XspJFGMqdhcaea5Y/AHY4VyrJueL3zJ7RYMACWXaTwH6e3fOcnT9YV/
 qpti1/muv2lA3QNB17l+sexgsEiaIUtcYE5QW/vF3vhs2zr8zO4BuMMGYKtDVte+ZfHw
 21WwjME8sxUuXG3XPqt8I+l5fPbki022UuCkJ15ExwMG+5ecT+HVDRKZy4MtvbbfBlMW
 zlwRT1CYeqTHJRYtlkoUiMzVIHLY8mWz2re8SAXATJyyDKF6LuUI/4rPWGa07gpogYUd
 IS2zuOCm2Hfrvvvl8vHRNgCZOWPKrx52QOEdGxXZpAOI4EHYYa3NQGKx4LVKhgVhNjjN
 N+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739823716; x=1740428516;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZREVhBW3YhrKhq8Mmtpeghu4/sgYahbIKLxpHaZzI+U=;
 b=PgHJQ7d/LZZ/i4wxwyCD7dTnGJQmUYMZXiPFXu0UuX51wxPrFsRQaoV7OEo6nGFXP7
 fjC7tZi8PQ1wGmA5I0xjMh09PCz33uyVSeDNWPx3fOX69SA95DiGK2FLq1L4aa2v2C7a
 XB/Q6/bax8aYt8+8i+IZxX3jLnoirsGeNHnrJGAqppwsEJLoDAFihCetgsJUk5fZ5ms+
 FbxegXe7WkM/V0ttAcn31vrT4ndv34luyFa5jXeVKKmwwzDd2VspEFV32icFEfAxCWsD
 n08QLuyRg/ztKWEvchMqXzTr08400+GYvTAZ0vsV8xFlEcdhpqb9kyt8diKFJsZeHm2K
 ecZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY03KB9VSAZSoPFOxph7GTl/YtMHubPwmLWPoTuoaen5ip8kMySIOyzkTU56Gc3wSLtkzg2LAgvw==@nongnu.org
X-Gm-Message-State: AOJu0YxhSY7/CWnWq7ZtIwUrZNHKkQApJCijo71xwGOeRbI14DtC8qwb
 DlC2tceE9T3U7azJAsGQV3MHSCKLSeDo4V6wZuE/Nk27J8J0Vg5g
X-Gm-Gg: ASbGncvMaF8zolIv09/GE3RzGaMpbw1H/9Wz8DTevpixV+V/gQPTRpc92KuvInh+NoF
 ZSwVZeqw8DACl/MxWYkk5W8k4JWWloHtMJARntNzvzkN+ZIhicmHjayZXwocrwgHg13y79/qCLL
 nn7i81mYhrLWbA8xgCQwVEH5Ts17CGzYmEhcyohcJTFAexbe/JkO8OXey0a/j7JWV8yLHfZt6az
 ej7cRXJ4f09Vk9RhYK5AkrqEPnxFDJtiDx5q9ocMlsxsxQveJC+jUeyi5Nf3UYId883a80hYWk3
 MXajM9Kfo8WqKAmicX98J/X9O3Qfe7NASmsqG1E92D7K561DZD7I0SXNoQ0mHEHkrp4=
X-Google-Smtp-Source: AGHT+IGB+mXrZxdoCgvz0cS1ItCP9y/c0lo4fDogI3gBVx6GCPITv6JcAhkjS8+n5Cf41bHcid5klw==
X-Received: by 2002:a05:6402:27d3:b0:5d0:ed71:3ce4 with SMTP id
 4fb4d7f45d1cf-5e036049b1fmr12517559a12.6.1739823715616; 
 Mon, 17 Feb 2025 12:21:55 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-175-027.77.191.pool.telefonica.de.
 [77.191.175.27]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e075f59e3csm244342a12.43.2025.02.17.12.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 12:21:55 -0800 (PST)
Date: Mon, 17 Feb 2025 19:39:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_03/18=5D_hw/gpio/pca955*=3A_Mov?=
 =?US-ASCII?Q?e_Kconfig_switches_next_to_implementations?=
In-Reply-To: <CAFEAcA8yayMSe+64VDV8TwSMi7u0_wLM+y9-TKsnaZS5seNKZA@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-4-shentey@gmail.com>
 <CAFEAcA8yayMSe+64VDV8TwSMi7u0_wLM+y9-TKsnaZS5seNKZA@mail.gmail.com>
Message-ID: <18125593-7729-40FA-9FC1-7DC912287503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 17=2E Februar 2025 13:35:04 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> While at it and since they are user-creatable, build them when
>> CONFIG_I2C_DEVICES is set=2E
>
>The patch subject says this is just a rearrangement
>of the Kconfig stanzas with no behaviour change, but then the
>commit message body includes one=2E
>
>If you want to build these when CONFIG_I2C_DEVICES is set,
>that should be its own patch that does that=2E
>
>(The move of the Kconfig bits to hw/gpio is fixing a bug
>in 6328d8ffa6cb9d ("misc/pca955*: Move models under hw/gpio"),
>which moved the code but forgot to move the Kconfig sections=2E)

Okay, I'll split the patch and use above commit message=2E

>
>Separately, it's unclear to me how worthwhile it is to add
>these to CONFIG_I2C_DEVICES, because they're GPIO devices,
>which means there's not much you can do with them as a user:
>as far as I know you can't wire the output/input GPIO lines
>up to anything=2E We have the device models mainly for boards
>which provide them, so that guest code that expects to see
>them doesn't fall over on bootup, and because the board
>model code does have the APIs to wire up the GPIO lines=2E

It's basically to satisfy Linux which will clog the i2c bus if such a GPIO=
 expander is configured in the DTB but missing in the emulation (it will de=
fer probing which will never make progress)=2E Once it is its own patch we =
can decide separately how to proceed with it, e=2Eg=2E dropping=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

