Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E5C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vim-00040n-Fz; Wed, 09 Apr 2025 09:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2Vil-00040U-GG; Wed, 09 Apr 2025 09:44:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2Vij-00054Q-QE; Wed, 09 Apr 2025 09:44:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af5085f7861so4312634a12.3; 
 Wed, 09 Apr 2025 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744206239; x=1744811039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7WRCxQ0fv6SIwvkMjGKsLDz17EPd/4X8bE5zQtlb7Dc=;
 b=NDStpoHaGJ4mkW6KkdYXHFiDbzaalbE9bKUSYkVeMFZc3g4wJc08XfkRT2qeBEsm9w
 fnp6uH1zG5zUJzRoapSNcEjMyhX7NJB3249aqtxW4AvxgkLvp2AlGs68Pb+nnU5no/5W
 qN9O6VEF/c9IdQ/WoJkvBqzGkFpRBEFsVQ0Uu3xgSdGBpKi7U52rV2pduVguEUWgv/Sj
 6x0SUHvYw9ztztEnIFJ4qaUKGwWvASgbws0jwlnVWa+5EOExUrpQ7KVGQKAruikai+pg
 RZmOdrFY+r3pxddZCXb+VSXhWkLPt4rXPgESxCRa5+8hdkt63zVb+Q4b3AnFjwCzJ9zX
 TvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744206239; x=1744811039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7WRCxQ0fv6SIwvkMjGKsLDz17EPd/4X8bE5zQtlb7Dc=;
 b=KO1NK5LDFUhaXefXMDfzH6hFRjXSd8lE/D2623nkuYfwp3t+ssGodkkNvb/UaZd1RD
 QNHG9/FBGyROyVEYE7Ljs80FArMnQwU7bK0s5zBOF5zNfozZDjoMNCzINgSg2Lw/YeEz
 S1VhQIX1FObWHOQBoDSibbTjYy/g1vC283qrEFKfw7Rm2m3nOi+v4+ayQVb4MrjUDTPl
 kel0SjzSbvrzsCEY733sk8Xg88nNQAjup/yIxn32usHvZSuNVNTbbcCb+Jx36ez8+GK3
 FQCMTOGf5n4yZtkSWVAodZfbeOuj+qlLSorRwdpTfs85LMekOKUdjY6sUpcwW1rFyc6x
 hFyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5rPzluOX0gM8jkt/ZHYmsG2Fi2S6mBZ1MlGNcJLdE743K5xxE8IVCYtftvhvEEjMqSb9njX3kULlIHQ==@nongnu.org,
 AJvYcCV6UUTVMixw9yyu2M25zGS5LWQnJmsCWRRr4LrcnaA3nqWywzTaybVYLCRXlvCP9trqZJCrayBxaPc2+Q==@nongnu.org,
 AJvYcCXNqJDaI6tMggSxtq9eKAqBZwIMbLstp5a5ISmlNVfbMmNj1jXB1wcLEpF1qU0Gi0Yaw/hPoHwEUw==@nongnu.org,
 AJvYcCXk51l3ffEVNEpFWgE0QZQsAUNV4pRK8EKxB9c+D6we8reOm70XBKSeCOK6QacBih30Asv1MQzWSmDhAQ==@nongnu.org
X-Gm-Message-State: AOJu0YwOk6tI0JFSszZ0JCB/6BZMHUAgOmp2IzPw9wQLKE1F5bqpB2O8
 9KwQK8hbWkyJD3SfXZrFZzeNBEhGANt7hYPaozC9+Kks6KsJUWhIUvVcwcHVWIji0x2kvUU9u38
 Ist+LZ0o/X3FRLr0UMKQCVfOzfQo=
X-Gm-Gg: ASbGncvJvNWBfm025ug4zFLk1d3Y8MyPCwtzPg4CMeJHL6AOs7LDSkQaT3rYwZc0Uvi
 YaOpTOU7j7LVbBQoAm3kxNjeq2puWk6y9n1857E9CIl7eLOxhEFawqp3ol7rLd2K/rvldN/r1ig
 vS6vHJZJEecRwqfCV4efaDE9fwbIVTssuNOjqV90Thc8nPpcVKsn4z
X-Google-Smtp-Source: AGHT+IFXWzfqLakx9M6dZ4ALZPiTfKwNqyqk2jNeFcKr4bAQKWLoP0KEuP5C/HqKpuL+JFdqJZAecFQa35Kb/Axltl0=
X-Received: by 2002:a17:90b:524c:b0:2ff:7031:e380 with SMTP id
 98e67ed59e1d1-306dd51c1fbmr3380071a91.10.1744206238901; Wed, 09 Apr 2025
 06:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <2be81d2f86704662c9fa33ceb46077804e34ac77.1744032780.git.ktokunaga.mail@gmail.com>
 <e6cbd3ae-356d-4805-bca1-90b0e98c4d0d@linaro.org>
In-Reply-To: <e6cbd3ae-356d-4805-bca1-90b0e98c4d0d@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 9 Apr 2025 22:43:47 +0900
X-Gm-Features: ATxdqUGJYbgVid8JPlWlvpIaqs2sT8XB3K0JkCxK41xJBRJFA261zBnrmDF4fJM
Message-ID: <CAEDrbUZwvhV_kiAZEdnk4AwPfpspEOLfhMsOuf_A+u2C4JK8fQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] various: Fix type conflict of GLib function pointers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000048f169063258a961"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000048f169063258a961
Content-Type: text/plain; charset="UTF-8"

Hi Philippe, thank you for the comments.

> > +static gpointer g_qtest_set_command_cb(
> > +    bool (*pc_cb)(CharBackend *chr, gchar **words))
> > +{
>
> Why not use a GThreadFunc prototype, casting the argument?

Sure, I'll fix this.

> OK for the rest, but it might help to merge by corresponding maintainers
> if split in 3 distinct patches.

Thank you for the suggestion. I'll split it to distinct patches in the next
version of the series.

--00000000000048f169063258a961
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe, thank you for the comments. =
<br><br>&gt; &gt; +static gpointer g_qtest_set_command_cb(<br>&gt; &gt; + =
=C2=A0 =C2=A0bool (*pc_cb)(CharBackend *chr, gchar **words))<br>&gt; &gt; +=
{<br>&gt;<br>&gt; Why not use a GThreadFunc prototype, casting the argument=
?<br><br>Sure, I&#39;ll fix this.<br><br>&gt; OK for the rest, but it might=
 help to merge by corresponding maintainers<br>&gt; if split in 3 distinct =
patches.<br><br>Thank you for the suggestion. I&#39;ll split it to distinct=
 patches in the next<br>version of the series.</div>
</div>

--00000000000048f169063258a961--

