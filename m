Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69BCCD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVaeJ-0002OZ-5y; Fri, 05 Jun 2026 15:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVaeH-0002OE-Vj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 15:56:10 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVaeG-0003Tf-Dt
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 15:56:09 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8ce3876a50cso22555756d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 12:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780689367; cv=none;
 d=google.com; s=arc-20240605;
 b=ZSm6XZiILpSbwWqsGwZueHvpinA/b/1P6fv1Nme4qN/z7jZL0oNoClGkQI7nCKWPms
 Ikoydm5aOkNaQSNN6+9yhJxGQyqQ8mO1m5QwuXWjvtPZUMqkjAqVibGAGU8Pqmxfw/zA
 6Vrzfhuhch/TtNzsIP010CNSrIsPXJFuOdQpT1Yb02tI6oyE37NagKNJSytWF3xVcfNI
 DsttxEw15hGURtOehRSnqvJzQm2ulc3wfC5ELnuDvCkC/cFDcwX43TjU+ZW4V3htFV6U
 FYZ8lX6pMC3/76fo/yxwxAJFPGX9UUDNHWvpH5QvIw7+tMDvcK20hRUeSNifoXoWQXqT
 Oh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2jOBzKraj8Tac6HZpZRnuMQfIEinK+Jwxt+Ap6RBI/k=;
 fh=V+8Y2dfmP7gNa41wl2sUg9JRC8kfTFFFbWTbWeSmL2s=;
 b=HdKRS8fC+R1f0VrrXkahaPKATCAjkVXnpFiBmHToPvTNgCvI4hyhq/qFNH2Sc4rsHQ
 nnnH6fm4SSW7iJPI5ZzFxIOYG8MhEYAP6FVmmpMLGPdAkt2woRrxwkEfbFVcRxBs9KfL
 2+fScz7aSRejRI9oVehyvOdNgycfe9qOVdOkNshaAU9SzrS+ze+eXfEMSE4gEcMZpKWq
 /jB9gJpbkARPgNoir0kyWHA7If9SN0jW6o8CYgFIWlodYAMNSVJfJSjTV4peTvof2rTK
 FPEaIM2IViHMMnNl3G/QZkNsP4luK9JiFFt2UxjfgFjUGOoCPegVp0BKwrmfC5ZnYjKV
 90rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780689367; x=1781294167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jOBzKraj8Tac6HZpZRnuMQfIEinK+Jwxt+Ap6RBI/k=;
 b=YloNp2wduAFZOb45u5Qkz/ms8UHZJ1p0RGZmTDFhm4rw1iJ752iTR6cEQB4fliBYnr
 lxXOqiM8RnB0JrNKFM2hXht3/FjTF/DIzFNkK0NJ0BNITgHJ2T0KpL5QBQbqLlYbKDIB
 +RiKM3Ktbp8TZdEbok8Xv49dkSZ6XK/9/77EEAsOlN5LnBwO8xAc4aVBZ2iauMge5JXB
 kZX42fHW1t3dhBiICWGYJz4ZR2GQ6x0+1gfRLTH9qB5ym1eoVB8+GoYLs8YnWKkQHuro
 N2wjowiw/aVRzSyBvprtY4TfRoFXqZ8sK8QD5uHHmNIvuPp+XMT5PhvoaQLfAbD8T2Dm
 tw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780689367; x=1781294167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2jOBzKraj8Tac6HZpZRnuMQfIEinK+Jwxt+Ap6RBI/k=;
 b=h1EStcBQOfyBj57iwd6bH36kg/C+A5f8XYl38OhYUhJW9tMSESYJOKrRJ2diGyfXX1
 JBNd3ZhDTVdgXoLAmewIZqRbHuwStr66+BqJOWfhQSt7ExWY8HTR0uOEeGr6HZ87E1I3
 Ze3Op6SK7GHegybdKPXkB4G00Y/nscwlaSqkyQUZRUQjwXKxOf0ZHxwsf2TCj2q5AsKX
 9zu4p2sgQC5lX+PFC8xti0Evwanut8kcvueVT+j2UMsfPXdfWQnC2TGvtCK0i7nQ6ysL
 Z14jfv2kKQY/7dHeFk97lMyU7ct6m2pVnr8ujPhOgYjLKwN+MH4G+m1aK2gh9Evk1u7y
 f31w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ECOSg1msOURh2VxDLO1W3Id1BbgITfHbwZ6pM7p+Ze7BIqk63LnxeqBYO8ve2W2/deKPEABqYzAzc@nongnu.org
X-Gm-Message-State: AOJu0YxH745tgU/G6dXOCudod3r6uib7I6AHuI6ZQ/yAEf5e5+8m916U
 4SxoXKNhZujFknI8am0AvVZUklOhi5np6o0XcCmqcq6eYtP7Pg7/JZATVibCU4TnD4SD/kyOgn/
 hLIM9VwyiKUqhIFJiqIia09X8Jmjy/1M=
X-Gm-Gg: Acq92OFlkr6wVPdxsazjsd6lyE9mPLws8Yd+55pKx8nI0xssZ2QLydq8lyqtXKIqYev
 nBuDUKePJjwH2UtAIoKImWJ7o03m19/IlJoMZrznCdSgHrm/j9uVbdP4KaDR9m8g/CH1DsZDM8d
 ByxP46veoJzymJhLjogLrUTC7GZmJale7Y8+cRXDPmtOalBmuPAmU4DcpsqZBUba5g1tnfZ2zS/
 FstXG0CG6BInQCG3EYQBvrbbOTT6sun0BuIgaAdfpaMGvBzYPZnHOyw0hI4b/VuA/8BajHdrh6o
 Dzyb9bJCzxObKijG1gEfJjBSu898xVeS/L6hZAO7h+fvj8ySssxYQY3bFMZrcC8=
X-Received: by 2002:a0c:e747:0:b0:8ce:b2e9:a4c1 with SMTP id
 6a1803df08f44-8cee5fe6a67mr73125506d6.14.1780689367093; Fri, 05 Jun 2026
 12:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com> <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
 <c091222b-6df5-4a88-92e1-15ec986046df@windriver.com>
In-Reply-To: <c091222b-6df5-4a88-92e1-15ec986046df@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Jun 2026 21:55:55 +0200
X-Gm-Features: AVVi8Ce3r9xnktEpEd89FcJNRoXCp9_stlFcnFBHAWTf8O5B4_1jGP3KwTpvr-I
Message-ID: <CANNYZj-S4ZEqttMv55rF8dcv6K+Spje1beXjgm5N-DWUGMh1oQ@mail.gmail.com>
Subject: Re: [OE-core] ui: Regression calling eglInitialize() since v11.0.0
To: Quan.Sun@windriver.com
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Randy MacLeod <randy.macleod@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=alex.kanavin@gmail.com; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 5 Jun 2026 at 17:21, Quan Sun via lists.openembedded.org
<Quan.Sun=3Dwindriver.com@lists.openembedded.org> wrote:
> I think I mentioned also in another email that this commit 52053b7e0a
> ("ui/sdl2: Implement dpy dmabuf functions") may have caused the issue,
> which added the sdl2_set_hint_x11_force_egl() function:
>
> static void sdl2_set_hint_x11_force_egl(void)

This is correct; I've confirmed it by adding a revert and re-running the te=
st.

> The above function probes whether EGL is available on the X display. If
> eglGetDisplay() returns EGL_NO_DISPLAY (which can happen with llvmpipe on
> certain VNC configurations, for example), the hint is never set, and SDL
> falls back to GLX.
> GLX then tries DRI3, finds only the vgem driver (no real GPU), and crashe=
s.
> In QEMU 10.2.0, this function didn't exist =E2=80=94 SDL would use whatev=
er GL
> backend
> was available (GLX with software rendering via llvmpipe worked fine becau=
se
> it didn't attempt DRI3).
> Possible Fixes could be: Setting the EGL hint unconditionally when on
> X11 (remove the probe):
>
> static void sdl2_set_hint_x11_force_egl(void)
> {
> #if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) &&
> defined(CONFIG_X11)
>      SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
> #endif
>
> }

All of this is yet more AI-generated nonsense, and none of it is true.

Quan, I appreciate you want to help, but please do not copy paste AI
slop without carefully checking its claims first. And if you do, make
it clear that you are providing 'AI advice'.

Otherwise it only multiplies confusion, and damages your own reputation.

Alex

