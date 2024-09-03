Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B5DCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWww-0000fK-U1; Tue, 03 Sep 2024 13:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWww-0000cG-5D
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:04:14 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWws-0001iq-OP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 13:04:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4280ca0791bso48519055e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725383048; x=1725987848; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SzD5+zVDqSDxG8DuYOWElnkzoc20vrPEEDM4mF8RX8s=;
 b=Tl0qxFb08jvcQA5jsW0+J5IEr6i+0I486Qt+9daDel8nx95vEQnv5S7vm2COggLZyW
 WcxLFi1XnKEThhgVd1b7W6h7W7BHIV8xwvs+E+cEip1VqvLBt5SSqyF3AX9i+tUifeUl
 GuPnwtayYdWxSJfPpRJ0eOKi5aYaksieyZFjRCd5XketkrZE9hi4JdT7HVgLgxHV+t7B
 B24axvCeRe0wZDeUTHhBqC7xHbKSztBGk3q5/yO30skM60mZVf011JrGqsvsH/WRAQ/4
 JxeqOZ13+c2/tH5MQ+QFTUcUkuVE4G0lDPEs/7Z1SaiA35ZKqGwMpbZxCIKW2ibZaNZV
 zyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383048; x=1725987848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzD5+zVDqSDxG8DuYOWElnkzoc20vrPEEDM4mF8RX8s=;
 b=jMjNN3zZSA2ywEgFkLOsLEyI7Z0MnNPOd3gxqdn7koTEFG6lnv05+WOFdjAgChPKBo
 lCN0bvgudx4/TYnGqBRb+UebNwl83i1RdgpBhCpX8cyitt3G2/kbRL8LwMVlt4YpWSNX
 mcwXyawyxjlyHL4xID+aVS6uPjkkrZ1RPTxXQL9dlLst4OIcRZR+EW/uFzbxH2q2CBZk
 sGklt4df1eR4NvqNIg8sxxPZXk4KGxb0eshe0FpfNOqLSaQAJpA6MmzaPytJY+cDi22R
 qrgQvOAirFqwBGj3G+v0UIeTaYHcKtkX+Wy4Dm+LVaYK5z7MRJovI3TeTrZymxuRv5cw
 Pccw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbY5Y1i8otI5KKvpkV5wrNUdVmS3lHcSr3Tp+xiE9KxWLEnRFvYWzy0hivW/iHpuYL2zxkqw/38VR+@nongnu.org
X-Gm-Message-State: AOJu0YzpsFDMQVpEFOLdNMOhPCPHV7EzlFwEqL6GlnaNItOrvclFNjY4
 PRQZDsVb1irf/zv6hfWBD7iRIjzgXRy79XK0IDDEe9fsCrecjHwBrHUosxgCIwJulUbAmQxFUoa
 Y8CjKD+aQ9Ky9M3RrF1UejfQzW/VPiijku+mC/Q==
X-Google-Smtp-Source: AGHT+IGQvP78rXaruSU+62ABZodVX3t6snswbk8HN5iVHXY2LD0ih4YlU6X7RqLFa6sHkUE6tQtbSefzaPpdLPNlhSQ=
X-Received: by 2002:adf:e2c6:0:b0:374:c671:2324 with SMTP id
 ffacd0b85a97d-376dea47305mr1124877f8f.44.1725383048189; Tue, 03 Sep 2024
 10:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <762867ba-8980-44f6-a9a6-5e766bc6a60b@redhat.com>
In-Reply-To: <762867ba-8980-44f6-a9a6-5e766bc6a60b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 18:03:43 +0100
Message-ID: <CAFEAcA-uTqq9Ke4pS59aQ_9t7KObRxff8DN_rY-2JkfSCQkASQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 3 Sept 2024 at 17:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 9/3/24 18:06, Peter Maydell wrote:
> > This patchset removes the various Arm machines which we deprecated
> > for the 9.0 release and are therefore allowed to remove for the 9.2
> > release:
> >   akita, borzoi, cheetah, connex, mainstone, n800, n810,
> >   spitz, terrier, tosa, verdex, z2
> > We get to drop over 30,000 lines of unmaintained code. So it's
> > a big patchset but it's almost all deletions.
> >
> > We have some command line options which were documented as only used
> > by the pxa2xx LCD display driver: -portrait and -rotate.  These
> > allowed the user to tell the display device to rotate its output by
> > 90/180/270 degrees (and the ui input layer to correspondingly rotate
> > mouse event coordinates to match).  I didn't realize these existed
> > when we deprecated the pxa2xx machines -- do we need a separate
> > deprecate-and-drop period to remove the command line options?  (If
> > so, I can drop the relevant patch from this series.)
>
> They are not specific to PXA; PXA LCD is the only one that supports
> passing it to the guest, but the logic is generic: if (for whatever
> reason) your VM generates output that is rotated, you can use the option
> to rotate mouse input.
>
> It's okay to remove it without deprecation notice, but also to keep it.
> Your choice, it's not a lot of code.

Well, the documentation for them says:
 -portrait       rotate graphical output 90 deg left (only PXA LCD)
 -rotate <deg>   rotate graphical output some deg left (only PXA LCD)

so the original intent was clearly (a) that the main effect
was rotation of the graphical output and (b) that these were
only effective for PXA.

The PXA display device doesn't pass anything through to the guest,
by the way -- it just draws the pixels in the guest framebuffer
in a different place in the UI window. As the FIXME comment in
pxa2xx_lcd.c notes, this should really have been done in common
code, not in a specific display driver.

As we both note, the UI input layer part *is* generic code so it
will do the rotation regardless of whether the display device is
also rotating the guest output. But that seems to me more of
an accident than an intentional feature.

I don't care very much because there's not that much code
involved. It's all separated out into patch 24 of this series:
https://patchew.org/QEMU/20240903160751.4100218-1-peter.maydell@linaro.org/20240903160751.4100218-25-peter.maydell@linaro.org/

-- PMM

