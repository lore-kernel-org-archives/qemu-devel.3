Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411CC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgJQ8-00088I-Hh; Fri, 07 Feb 2025 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tgJQ7-000883-74; Fri, 07 Feb 2025 03:09:03 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tgJQ5-0000tk-Ov; Fri, 07 Feb 2025 03:09:02 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43626213fffso17069045e9.1; 
 Fri, 07 Feb 2025 00:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738915739; x=1739520539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfuB8UaY4MnnUB3yo93YJbez+5tWGjee/zrK0ccjw/A=;
 b=PeRQ+Qkc+FS5jpsqCjmk6M/JAHtNQyZpgeoGPnctrlF6o+SxJEWF8g+uzCV7MPBY9K
 vHiZxZXaYn7YXprIlBNgsZ7ykmMcq4Y0z551TT+v4+dbUAeL+i5D+uUfd8DP5eESQ4Go
 6tZ5q2FKtYJl5h8YGq1G0HklTbv88sU7Lpa+TWtVIskxcp7Aw5dwQtM88NxIRvy0iO9E
 Grz94I10khdNUuUN//xhAllDp0U1wUePsqp2ecPK8LU/MTCF5FkOa4nUVZrSJ7nAkE8H
 FSvT3zgVQ3JXLk5ai3snVz1pjlrNMoLkQvejdkzCtg6IL4AbRc0L3WY8UywfG5CXMqbe
 xxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738915739; x=1739520539;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfuB8UaY4MnnUB3yo93YJbez+5tWGjee/zrK0ccjw/A=;
 b=gG7qx4KhhaQmoDpZKoAjn7g+EVH/j7SwDsrATnrkPtnogRJy3ZGRLPgCdcF5LIMrQN
 kkZAmwWoIcVu1Iev5YXr3NO1/J5uZ1m0zlVNfuAKlbVYqwz/9xmeY5Yqg4TKGkHwiru7
 vkwrTzOHM08IHwmU4u2LT3l+076l2qa5ZeCcXV3jgNvNEobno8PHQ5/PSdaMh3h/7asU
 VMG8+uGQexuDx6Z1FIr6d5oXnyQ4zeC6UQgsdAak635e5hl7LLOq/jEPN5gKTLxxyxPN
 5vrMh+KA/JvPgenYXM5jkT6uULqoML2YlRhhzBDAP7SI9QiSHjO2GFxFF0EpMkgsYy+C
 sCtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpIWwqo5qSiT3KReEYufbHVGoGK5mv7YLRh+dkYvLuMRq+KkpL/Vj6zP8N53/brdsOvXu7fIp/mA==@nongnu.org
X-Gm-Message-State: AOJu0Yzyt0SLXMWeTCuMcjNtVmGoCL9K9qM7WlvF22ghWBSjYq+UyZD+
 6KupGCxzsok/Ypi7BuJR0jIjbJEnG1RlipNjSBsFvsbDSUH++MvB
X-Gm-Gg: ASbGnctXU5HlfHeKeVfOLyeMBwV/y0/bQxx9S0Q56ZkfWWEr1epJ2E/qLQDDNIJVIi7
 QepbbjdaO9UuUzuHkZs86RJfUiWyupbph3fHlGHe1DOrQL1zPBvftzr86vLyi2kA5zNgi0/CgUd
 cy7VUjA25DWhfmQ7ZSLuSBUd4fhnujh8WA6MA5e0trIqT4bWIznOG5XhU6wxGO2wkhYNS0MzZFL
 MpJP+k2COfEOkr9x4gkxobY01vzuAwE2tnF0zHMsnRt3FjthckBNbIiTAA/7OaWoJoyfFi+g8qM
 eCD2wvK7UKtAh715GHx+Ed+a76c129aLD+2zq1107OubpVK3U2g/XuhO/ESeSa7GCGfwFijGIA4
 =
X-Google-Smtp-Source: AGHT+IGgmuTPGJyM/wYc4viViwPqeX3f8eYGXPM/2ZXN76gbX9t3MSVPHlKvUvQBIFAgeE+oH3jVGA==
X-Received: by 2002:a5d:6487:0:b0:38d:b349:2db2 with SMTP id
 ffacd0b85a97d-38dc99a099bmr1231986f8f.22.1738915739402; 
 Fri, 07 Feb 2025 00:08:59 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf004300ecd7bea232a7e2ce.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:ecd7:bea2:32a7:e2ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc09fc2d9sm3157748f8f.6.2025.02.07.00.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 00:08:58 -0800 (PST)
Date: Fri, 07 Feb 2025 08:08:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_13/18=5D_hw/arm/fsl-imx?=
 =?US-ASCII?Q?8mp=3A_Implement_gneral_purpose_timers?=
In-Reply-To: <CAFEAcA93kevhjQHWjbZFMRaka2LSTr+jYcT7aA_AyrTDsKcubw@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-14-shentey@gmail.com>
 <CAFEAcA93kevhjQHWjbZFMRaka2LSTr+jYcT7aA_AyrTDsKcubw@mail.gmail.com>
Message-ID: <1C1367FE-A7FF-4673-8858-10A22E35DF75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
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



Am 6=2E Februar 2025 17:29:16 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  docs/system/arm/imx8mp-evk=2Erst |  1 +
>>  include/hw/arm/fsl-imx8mp=2Eh    | 11 +++++++
>>  include/hw/timer/imx_gpt=2Eh     |  1 +
>>  hw/arm/fsl-imx8mp=2Ec            | 53 ++++++++++++++++++++++++++++++++=
++
>>  hw/timer/imx_gpt=2Ec             | 25 ++++++++++++++++
>>  hw/arm/Kconfig                 |  1 +
>>  6 files changed, 92 insertions(+)
>
>Typo in the subject: "general"=2E Otherwise

Will be fixed in v3=2E
>
>Reviewed-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>

Thanks,
Bernhard

>
>thanks
>-- PMM

