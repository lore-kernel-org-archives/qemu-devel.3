Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A5BE85379
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8gX5-00060P-Ft; Fri, 03 Apr 2026 11:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gWy-0005zr-TH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:33:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gWx-00077G-GN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:33:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so13012385e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775230434; x=1775835234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BWbGG2IpnckHtELhYyTa577ujwKnNKDEg3yiU/MIL0I=;
 b=iDlsQPpmBAD4/4qKrISD6dbb8ihjConZmV8RioZu9JZVTW2FMct9xgr2Bk2k456dmE
 xIfL1P/lfalDbRMUvFcUbHbegeuUyIXbJqcsUC1WEGpYFmoR6szVAcPniooFdYHHv091
 VJG71CMcB4TOnX87Zcs9XfQ0zRGTeXvUoWlLl8C0Ja7jg9RTjJ3OX3v8bdREIAkY2Q/1
 CaTJcsg+jHE1gW9iGskoLGwIln6xqvLE5x1MsG6tgOZf2B4PS9s+EBpdLkzR4ZqGmBi8
 69+J0O81V3fca9vI0g6aiuBYiUkecc9p4U/mbhB8oobFiW9SJ33fTamuaoFimSAxfDus
 k0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775230434; x=1775835234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BWbGG2IpnckHtELhYyTa577ujwKnNKDEg3yiU/MIL0I=;
 b=N2QY3KcceNsgIBeNiVn+UmJuoK3JlfZqZ4F3IhQpahUq/546wa6ykN6fff1DHnI9EE
 2ahG8C2Z4lVx/lOaDtkyj7IpdQjuUYIu7trp9K8HmKRn1/OmeyuB5pIzvhF3u72+J7eE
 VEgqjR2EUtNwAlEyau0h7MBSgPQOxbPNyEK+Ey9DoLn2iZqmzbqQi7tREAcemaHvqRY0
 Iuol4HSkBfYPSGwAMZxJlbnVajvrXuIJhc4PmH0xNlUrzaKx6NHnaYMJ7rdn3ZFhOcAw
 IXa9T8IyZZSR0la4x+lr4FsfyaARF8Qyxq+sKu9MvFaueqy0+REq+c2L7oU6nd7Fv/Or
 xflw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCBO8mYsR2SGdZKifRoWDlVs/Mm9hhmZ/iH5ScKzho4Lz/ij+Hnab+V8Ju1YWVaOsECVZzzalPnPtL@nongnu.org
X-Gm-Message-State: AOJu0Yx8QYUrPnTfk4uXt+OJ8SU3eokgZiimGJoPQ9DQ1ihXCV9C4JjZ
 jSAa/eIlhlaxTJHUApEDB4wS+Gb1k+Ghmj7GdI24N/X/bJJa2le1ZGzNI7UpaP/vTMc=
X-Gm-Gg: ATEYQzwbTU/cH4e+4fcNYp2Jg7xA6a+Qm0udZIoGAeLzpITSgUtZMOF1aDU1t/aMF8f
 6OEReMvA4PPs90n/RtmoymcktXntd25YPbU+bSUj60dwbuq6Bg2qJsSJd2PTOZO1oDLY/AsRtne
 gASpOgu1/U7MTTePF95t4sJKidhkAdZPgKwtngeQKr2vG5EO4h5saUV70xixLC+uzdpVRA8LkZA
 bft7S/4bl8yb79M3fAXvN6BhD4I5owQ61trJIYgb1Tf49JBS0/CHMjIhey+6i6otYb94vwsqfNF
 E19NiGDTlzTb37qZP7BnaZHn0niX6EVSCrmFyMKq8o8JLdzPLoTJgSdI7w8VDUto/5ifCVRtoLT
 vCVVBhSzTIIFbtz8YQHOou+huo1QsoRUkGHBP14Eir4y3dhx3yxTpREtuoJuVpTSwdRCLAcyHUC
 3tys3jR5OjxWCMDL2JIC2HMuJUhXTF+osERD74uI28oIiHpNOXgULxQqAIfJKyrn6Wmw==
X-Received: by 2002:a05:600c:1d1d:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-488997854ebmr53118745e9.14.1775230433711; 
 Fri, 03 Apr 2026 08:33:53 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d2738sm17774841f8f.24.2026.04.03.08.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 08:33:52 -0700 (PDT)
Message-ID: <695a7724-1440-4956-bcd9-fd2e3283464d@linaro.org>
Date: Fri, 3 Apr 2026 17:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent on
 32bit hosts
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block <qemu-block@nongnu.org>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/4/26 12:43, Michael Tokarev wrote:
> This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
> buildable on 32bit hosts again.  The patches are simple enough to be
> picked up for 11.0.  The one from Helge is marked as RFC still, but
> I'd love for it to be accepted the way it is.

v11.0.0-rc2 is already out, these look (in particular the atomic patch)
too late to me.

Is it doable distributions use v9.2 for qemu-guest-agent / qemu-img /
qemu-nbd on 32-bit hosts?

