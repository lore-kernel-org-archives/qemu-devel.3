Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E26C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 06:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5fdU-0003UR-8D; Fri, 18 Apr 2025 02:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5fdB-0003P2-6k; Fri, 18 Apr 2025 02:55:21 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u5fd7-0004PJ-15; Fri, 18 Apr 2025 02:55:18 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso1138485a91.2; 
 Thu, 17 Apr 2025 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744959313; x=1745564113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zE3VYyJM4u91oaT272fs/Lb82dU6BoeKgOTBkGAnBu0=;
 b=QiX/rFvWrdmATHqKFkUufpCivgyyi8e5oE/gOAHEDDnDG32gxf7iPkf0z2loNvWMIa
 wKOWHg9gJNlusSeq1UaIXwgoqyeMDq0+4Bvd5rrdLEhtHreYoiKbvC6Z03Owy27of2Vc
 nPaNhdY+bqfwe5r4lHgflC4vr2fugUn4rbx5WIw9pdJGVzn5lybZAWpxlfeVQqT3tsTQ
 lEymO+fC7yeZV5Zuh0IXmg7X5zloRhtZ/PmXLCDnGbjsp5SgGR4oYXxMCHHk3BTRn5PG
 djzJEGPFteXgffo0GQYcYCzdsulEJ/n2O2S0s/XDzjWg6JY9DvqklDkfTw02CxgLwQPw
 wZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744959313; x=1745564113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zE3VYyJM4u91oaT272fs/Lb82dU6BoeKgOTBkGAnBu0=;
 b=p9/gBWMYoLC26B7ImciXjLGWaAbyucJHMB3dKl6YThUpit2sXU1HK5GLeCsOQkCzT7
 xPQRKguMtlZMjy/myyFPavebnN4CzRKAorpiAUwrUD+LDDgkxz74U6zB1ZXh8A7Grq8w
 BMecrk/HsRdAAoeexDCi6KW1QLWUuiNHwW7uzBj6su0RgAn01WChdMiLw7PZ8t7pLbzK
 cEfRy3lhpGqD8wT+qAGznfTnwk+GZZNaXKMb9UQ1no9w64ihna+mgR5UVQrhKloouYrK
 clG94B5+hxsntrXxO5FpI2YEURtIrqrhozc5E1SXWWW5lz0DX9QK2mwUdoeRR15q4+HR
 UDkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf9HwcS9EbsMW+Y+kbn/0IOYsHwPY9dq/LP38SWj8IeuMMll/9LXaFSb0MeaajEGI+9BNvgwKu8CKmgg==@nongnu.org,
 AJvYcCVsLjPbfCVP+jp2NZA0lqXiQnI2xBDYlOT8Z48zCnsW952rzylB/X+r6lNPrXLDy4TMyILR9b8dFkHhKA==@nongnu.org,
 AJvYcCVtfHjPkV+pdEw0cBpGx1OTXhjPee7zOw2qqtBhCehBiOLKXdfPrfnXrz/oNEkhHc/5O1pWzFUpFw==@nongnu.org,
 AJvYcCWaf9avp1PpDRX2o8EyjYFd+XG/zC8WA1MOA701NvoGcNu5ojDXHn+vWANWUfZGB1NYNS/7u0ii0LA=@nongnu.org,
 AJvYcCXbDNy9loKHgUJNnFYgAW3Z5YO3d1ioDatpRJi6j9Olentn0v7xVeahHYdLFLncxz93rxSQge9QhPNjog==@nongnu.org
X-Gm-Message-State: AOJu0Yz+KpU0kfgR1faeJadMQPfIH+XKXkrpzPQP983H+u4a4D4G9A1t
 uUnLnxYz+nE4tiv+2ofbXn+lGed29OIMr06CZDXVQesyOy+vziNiR+tGRh7ZGlK70HNDOnwc9KU
 x18RGW5ey9NclVdmtnwXMdJSHQUU=
X-Gm-Gg: ASbGncvlTbf0hgAXoECevtwgsogbUgU+uzzvt6gqPED9NZWWwe4ErFsi6qEL95AtE8T
 HK43G7OFTu2KEXil/MB7YM/SVWwI71YXCeRSPzWenbJWuFHKA0jVyutRgiXbbHhwnBelUDhyshz
 8WNZW0e7SMx85WfpUzx/aMRQ==
X-Google-Smtp-Source: AGHT+IEkswcbCVI7/mUhn3wxHieDdDPozlUfys+cT2bFQ15bD/nf3bmeEmrpvKBq7tfaRK8O2YCPo2tfq0I+FHdD86Y=
X-Received: by 2002:a17:90a:fc4f:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-3087bb2cbabmr2357908a91.6.1744959313243; Thu, 17 Apr 2025
 23:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <58863961cf88a72b76a90279da09ea332943924d.1744787186.git.ktokunaga.mail@gmail.com>
 <1e658b6e-02ed-47d1-9c19-d5753cc6e6c8@linaro.org>
In-Reply-To: <1e658b6e-02ed-47d1-9c19-d5753cc6e6c8@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 18 Apr 2025 15:55:01 +0900
X-Gm-Features: ATxdqUGu39lF6lPk8TSLhKph8MX3trqBTUhhySRtvszhNLQrTN5JRUPtO00LlLU
Message-ID: <CAEDrbUYfR6KxTf1fkasMBin5kB83iKebmuAC9ToJnF_2A-T8jw@mail.gmail.com>
Subject: Re: [PATCH 13/19] include/qemu/osdep.h: Add Emscripten-specific OS
 dependencies
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000038bc70633080041"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102e.google.com
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

--000000000000038bc70633080041
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

> You shouldn't have to modify this file, likely a rebase typo.

Thank you for pointing this out. I'll fix this in the next version of the
series.

--000000000000038bc70633080041
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>&gt; You shouldn&#39;=
t have to modify this file, likely a rebase typo.</div><div dir=3D"ltr"><br=
></div><div dir=3D"ltr">Thank you for pointing this out. I&#39;ll fix this =
in the next version of the<br>series.<br><br></div></div>

--000000000000038bc70633080041--

