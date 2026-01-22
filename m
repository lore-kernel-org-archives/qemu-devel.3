Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBEAD6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 19:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj094-0005I1-P3; Thu, 22 Jan 2026 14:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vj08w-0005DW-83
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 14:14:58 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vj08u-0002i8-KS
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 14:14:58 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6581327d6baso2143732a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 11:14:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109290; cv=none;
 d=google.com; s=arc-20240605;
 b=gotKLVpyT/IiFefqnb/z/D8Url/p2L3RmBQiAHu35fUjX5s/BItJIZDKoHV0/jzhrf
 IcLDOIEC18qt7CSUEFL2q+LV9z+bWb8YKifGrVngPlJHoHe1dotBH6KveNJobG+Xzznw
 Mh8CiFAA4Yh2Sztwe5ULVcx9rv08PrHYz+3YgAXDwD4gWe4cfVprFiluVAuZBhNt6xZc
 VX1xilfEajcbVCEd0d/ba2vmRI2cP0Qhh7LJmQY2WRmflzJcx+hyjIrUdJAhzzlpcnJK
 rvHf3Yp+sW+YHna0sHq+I/x6WyiS1y7g0/JAliFVhVZU46SMhSzuRptJB/XlhbWCAtDy
 zLOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IJ/sGHSNHA4btWTNxQgApXnTAKcFvCnphzdMReBDQ2I=;
 fh=rDPILd64SuZi26kZyOlI1A5tRiwyHEXsW57CytekB/c=;
 b=SVn3UzewJWSrlXf7bZCQu9qrA6G/fNEOxRREeTNwLYhX8I5XYGbV1zdzPK1KkP2mR8
 YLUQLlFlIVlfVuhos5/3wnVo9JYnb9d88BJ/wpHjpsVtbo1Nm3F5SBR/HEsMODp6PS5A
 BYEaodpW0O1GKbqazh+pnGA8S4SJvBJyptZq9579zqe7oTUACViTQcbiHC/uorsBmRwC
 i8nDgsSy3+smr695R+Yr+BXOxYL+vXJZOme005cYIdlNh3XvEDQLprBuX+CIHVb67Kwi
 IEA+b9xFqgBUoL7hoN6QpiDN0SIQMGXje5vXv0HISNT0DBVGfPN4riIMQig0/1gDhosc
 FPyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769109290; x=1769714090; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ/sGHSNHA4btWTNxQgApXnTAKcFvCnphzdMReBDQ2I=;
 b=NUChscTMfngInor++T4MhSuJcF6a0wbjvn72o4NJ7FKetnHS7d6HFVocEqtGBnx9DC
 UYaILRkqEvzoVnFeWApEOt0o0VDUsqRE2GzEXFhV1YAC4wi+g5RIyxgQE3S1SCh0gGGX
 hQeqrsfqr0dQyddr9q7WuuVe3N1XwGuRPGW0Fzm/KEPvval8g0zSgdJxj9zZpV34zw/i
 sHYsLPsd3ba0Iq85T+DvEyWAZb+KkpJec3dbCfBtRNHiW0Y0LjmsqPu6yq3a4G/soybh
 kTWURk1RbaPkOtcZqQYjdH3nvfM/Jp+m1yCCuKuys//LwXSNp19cTXjmKFci8l/sOGjN
 pWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769109290; x=1769714090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJ/sGHSNHA4btWTNxQgApXnTAKcFvCnphzdMReBDQ2I=;
 b=D4Dsvy8elgcZIqN5StZ7GTepkXfGz+1rpVwxC5eAhP20F/m86+cJGi86hwWALo8CYs
 5gYsPbEllrscnQmOx7Io7N+gX7h9V3TLbwyLTmvVKo/LOX8gNn9GpIThzJhoQvaDAvsN
 0hWhSZZhPCDfEjE1TwJfr07gPvuh64SsmlewgMPujrDyahQefhVL15BQB2RIG5XD7TKM
 ksBSwA/iVspDgzGIK5GAtPjHFhokFXL4kTS3PKRFrwZ+UdeXVZm8iVovRHud92hnTKY3
 bQgk3MW7vb8+x1tTJGFStaXlVU89wF5JNxQW6ZZltW5OG2pFr5k1TxfTgIfrbrTloILF
 0qWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaP7f/U0Wb5JUgXQjFYOt6BzL0fw+dOMzAD6xezQTglHJ/6t96Qgd2L5f9fbMvVRIh4/+x7b0B93Se@nongnu.org
X-Gm-Message-State: AOJu0Yw8R//sfT1XljpM4YMAkCD6R/CdrvYOizfyohsRHOC/NfCreQ22
 RChr9943y4bgT27Xc6gFYYuF+t5cCIpDw+k0Crrr4FJxNujmSLYSxdp1JbfCTsYkWWtt1HoSajE
 4Zyoe7A0dJzWQQm8JzXw2Qog38SNStvc=
X-Gm-Gg: AZuq6aJ9lqmlgQnrcHUmF+8vFq+FmS6HbHK0ae1d4vIOyZ6XcvMcT0KmWQ+7iNHJu1X
 9ZiipdzOAyvuF66g0OS2gBhEbdcNgMoFoO8+jUqCIT9WeAzFjVkcP1aDTFBEwFxcz/zknIzc/xk
 K2vcxw8Oxd5mMXuv/QLSgSi7Zvnfy7hgFOGoG1vwnUUDiW1nOZp/U64vR0ZQwgf41bZOqFzZIEC
 qY68rhrLystujQPEm+VwH73mp8AOGfTZVG3e0cNNdOaDKMCYgiZ2hPbsg0swLTkUNsYpQ==
X-Received: by 2002:a05:6402:3594:b0:658:370f:79e1 with SMTP id
 4fb4d7f45d1cf-6584875e33fmr397402a12.4.1769109290255; Thu, 22 Jan 2026
 11:14:50 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
In-Reply-To: <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 22 Jan 2026 14:14:36 -0500
X-Gm-Features: AZwV_QhUVsYAQme0MbqbFeqPikNKUWX_YeCbht9OywCS7cmGsV91TJnyqw7RgIg
Message-ID: <CAJSP0QWW4r6NrGyVowxf7X-1NkF9jNwZ70WQVNZB4Zdtv3QvUg@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Thu, Jan 22, 2026 at 5:43=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 22/01/2026 11.14, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> >> Hi Marc-Andr=C3=A9,
> >> I haven't seen discussion about the project ideas you posted, so I'll
> >> try to kick it off here for the mkosi idea here.
> >>
> >> Thomas: Would you like to co-mentor the following project with
> >> Marc-Andr=C3=A9? Also, do you have any concerns about the project idea=
 from
> >> the maintainer perspective?
>
> I'm fine with co-mentoring the project, but could you do me a favour and =
add
> some wording about AI tools to
> https://wiki.qemu.org/Google_Summer_of_Code_2026 to set the expectations
> right? Since we don't allow AI generated code in QEMU, I'd appreciate if =
we
> could state this in a prominent place here to avoid that some people thin=
k
> they could get some quick money here by using AI tools, just to finally
> discover that AI generated code is not allowed in the QEMU project. Thank=
s!

Yes. As part of our GSoC application I am going to combine the 3
statements about AI that are currently spread throughout the wiki page
into a single section.

Stefan

