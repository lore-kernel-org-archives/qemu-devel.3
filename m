Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6672C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSTA-0004L7-RS; Mon, 29 Jul 2024 11:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYST8-0004DO-SF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:39:26 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYST7-0003Y9-1R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:39:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a10835480bso5454680a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722267563; x=1722872363; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAaECwIohdTcRxD66PZ+czjrv1KtXk3qx/5j9/cG0yg=;
 b=nOsYtzIcFfPJ1Xi0vSSJWJDLlp9XvxIDAoifjaWBdLfYwBIl2fbblQHGRcbkbZ4OPQ
 rrBlI8OwECvoOvpmG6jTLOUSbcBlJYmGWGE3E60ibw30rrBMYiBUEVM7znlhvKW9KOI5
 wH+BXMIsJKmDuDq8CH/O6uK3RBOXvUR4OPy36kZib9hZ3MSQVjTjuzipZaynuS9Xky7m
 gaQQNFVRgMUxtYykyf6/fkTHvWHjgpGDraR/WNXBQKBZ3zLaGJ563uErUvSwXu4OmbcL
 JYYICO0amE5MXmN7P25soiafranrFBm1PL6cQN9/HwK1xGZjT9nF9yf1OLBsHlVGC6z6
 CJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722267563; x=1722872363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAaECwIohdTcRxD66PZ+czjrv1KtXk3qx/5j9/cG0yg=;
 b=WcY2XDHnfHVASSqwB3HZ2bg5N+Qyi3/+XIB+EgCSu07NSlnDb3ovr0sgk1AvgJun9o
 Ez4bh0NZCAxccL1mrjAehgGQm2peFbTaPXs7OebBzV6+PNxGfoqf1A3OT2i+N8sQU7mR
 WhPOcUcBaiqpx4FUWNwKa/yxAgf2gREhvjoC5B1f7ybz7iOQ6hUdL27ZtOspCOnPsYX1
 aob7bz2UGlvbVu2crG7tOt1mBqKd5lwq5xHSioq941lS20dn0FbKHOFuhkGpBu3PSdH0
 ogcR7D1Ew5su9SY3LDhtwMjYXQl8mhVdD6ZjN4342/80vT3e+c0W5TLNObRhRqRUmNAL
 PZng==
X-Gm-Message-State: AOJu0Yy8gbleXbEd1JA7ut4FYt2l3COz/ZcJlvz7+UW4GGp76I0rKU5d
 Qz65x1lYhW3EDQSIQgRkhnPjiaK+HjXIFZ54qy3i6LJJhuTzZjGGxfoapr0Wf1tnL4L360uWIkC
 JbmfxXufX47qo3AaQB/HxSDe0tN6uEobVm5juhQ==
X-Google-Smtp-Source: AGHT+IEvL2Qc9pTW+fj+dQlO/Isk3veoaCARkRDeHTnlRC8QCGCk8hGQ2u24cQ6bjPbE23yN3hEFf+UIWF4hOjtv18E=
X-Received: by 2002:a05:6402:3481:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5b0225c52f4mr5591102a12.31.1722267563299; Mon, 29 Jul 2024
 08:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-3-philmd@linaro.org>
In-Reply-To: <20240719181041.49545-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:39:12 +0100
Message-ID: <CAFEAcA80FOgY1tYDeG8DnFwwvGkXyK=tqi4AdGj-53ef+uJm3Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] hw/char/pl011: Remove unused 'readbuff' field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 19 Jul 2024 at 19:10, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since its introduction in commit cdbdb648b7 ("ARM Versatile
> Platform Baseboard emulation.") PL011State::readbuff as never
> been used. Remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

