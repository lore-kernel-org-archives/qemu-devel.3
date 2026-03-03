Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3276EC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNsu-00064z-4o; Tue, 03 Mar 2026 06:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNss-00064j-Ux
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:25:51 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNsp-0006Oz-Th
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:25:48 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ae222d87dso4991996d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:25:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537147; cv=none;
 d=google.com; s=arc-20240605;
 b=izvAgkpdLvqgPiMxJXdXVHAimy7aRSdP23MgVbnDt0qIxMPZeAWnzkGTPCpagQEtbv
 OEmwF2I2m2GmvG7q60Tc7kXprueVXBsebt0v5CTq4h6IwX78AO3Mcr9gZI+/DsActmNV
 XOfmiQz9eeKebA05iQSyOpFNrzB+45Yj0xvG66bYYYCU1Am3HQygcMqyl5n9AQkSnz7z
 VjJpEHNR2AmDvZ+/8uuQ6baQ4kJoGhkZyfajf0HwXm4TBqEsOehLlWYEy0Udqpl6O0YS
 cchGq1QIfFKLoHXDQYLN9xlI/fgCb/UXd3VuXoqYshwVq2zji/adKIENvBv8gNTZ2kyd
 0W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wlBn0WEfQJ+tIVomWPQfmh4kj6g122O/Tv3r4t2YMNA=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=N7846+Q4NvVCPWxE9WCDFEV9DqX4AaYaqi6GBGCVWsLjD8rA5YhePXUyo/BmEB5WVX
 Uoa7G0T1gMqbyJJRYFuQvTlsJiwyhIxg1jQ7bOw1fVwwJ9exgHUfjHvhfaVC75IclDtH
 fLg7QhurpZfX5gkY/ruj/pReC9g0jqnoZafo2WPdWMRKucbQZFbcVuZbxbSy/TF+Fguh
 l1ZfFWr7MZLf2/wF7j1/q5vGxh+8FMQU/Op8/hWTqHdtQ0y2Cm9xVwbc+TQRej37rBEs
 swW+5xYut8W7NNaukQ6FMiDViDygTEXsMyeCiDpXLy2z4jYL35eW+CvD+Zu8V+bRdtzA
 O/DA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537147; x=1773141947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wlBn0WEfQJ+tIVomWPQfmh4kj6g122O/Tv3r4t2YMNA=;
 b=x0m5GDVPQEhhG1efZg6fDZnAmKqARBrWniru3bgDjhg306JCG1FaUsoq73U6uSfTKb
 zZ+jcMBRQ8hcLokfh2SoWjSXD29oajCHSZpINWnUGBOQY8vQyxZkBd9XWSJKgroIpB0M
 y1pAhpB9iGU/h3rFQapQ80xHwVigywV/DBHFjl3Blc2eyL8Cgundx750SdgcYsx8DTgo
 wY24aBJaUuCoViOH50VjihVTmuO0EZi1PfLj7IRc/LZfAOoKELgv5aKOZkdop2tXrdv9
 pn9GuSOu78GTOzlaf+/Uh1AK8Vo8RDsFvAmn6lFVY2De4/wty23D/hamG8ApuFTOMv0p
 qOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537147; x=1773141947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlBn0WEfQJ+tIVomWPQfmh4kj6g122O/Tv3r4t2YMNA=;
 b=c+doMZK/V+StK1dysWhAWYE2rbZxqkGS8+k9o20w16T9Jb4zOSy6tr/NfCJkOj64cJ
 KRbnWn5JJH0T2vsc01u4fM+ifmZ58UtktlYW6Uo2rhbIIQD1b2Z+WlRy5EU+9nA1JdYD
 w+5l1njma5uDpsQrqBOzZFfpIVVhnRHHpTb6/Ud6PbBOnJ09NzpNj8y4c1e/0Yvh6sHE
 lNYSPXeR7QzMmKHjLO9vIHyKxg1ZFk3roTusQLkv9+8k0ATEqAIFnwMdGM6SGy7kZp5T
 UrwuWYCvkS63mZuOhK5YlfXxNP6ea44u1YCxATABpe/9KiLfZwhVrXgdNT6W/+slhLoL
 h79g==
X-Gm-Message-State: AOJu0YzhvoAa8G3b6ownXHSN+vhfnv8CvUeqf2C/Aor8KrYmrP2vb7of
 mFe/68bNJvAjau0K3sb1UXHr+Gq00OAp4WBuG62XzSuJaEtsH38F9bsqKuPyzHkQ9imovK7dzx8
 IYV2QoBiWdb8jCeCqzR9mSs1m1MrSI5OsiE32f8YGAw==
X-Gm-Gg: ATEYQzxIZV5vvCwoB3icvAHoiL6hD1DGmSf5UmdihIUH4bdQfZG54sRh+oHpCEHnh2T
 oA8ZtIfigdVFmQQWP09Xo6jbnkv9PX7fwxBpiLGSrNmv22Tb7JgR/5mStGBtGludZKIHYI1hSA4
 bDLeUyEBowd1HWId4a9z3Yj/093Rhhlbv4T6USRXy2HR4W4OYHfKzeRDtCIq1JncUhuHpUKCmSH
 4XWqfbkJKrGFmvi3aYLmmOXAve5FdqtHsD4dXsCwt1MFp6mzdokdkjoimdM7BU8bufq9MoELxe5
 ETczyZIgOhAGAX6JA6ul6kvuB0k7RRVSlrJ0hbn+7uaL3slrXb/NFEn5QZ775+98wFw=
X-Received: by 2002:a05:690e:4243:b0:64a:cf34:d9ac with SMTP id
 956f58d0204a3-64cc20d2d3dmr10091821d50.29.1772537146620; Tue, 03 Mar 2026
 03:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-4-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-4-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:25:34 +0000
X-Gm-Features: AaiRm52_aAmb42dXlBQMmKQAWPnkMY7-5TzxobI5-majXAkfREvhExiRWMQJgGo
Message-ID: <CAFEAcA8Kc_Nmvbr00zH_5MQKjhtt6USUg7fio-5V8qkG-gYnPw@mail.gmail.com>
Subject: Re: [PATCH 03/12] hw/char/serial: Prefer fifo8 methods over
 open-coding
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Use fifo8_is_empty() and fifo8_is_full() to improve readability of the
> code.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

