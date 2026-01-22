Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4334FC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visL4-0002a6-7R; Thu, 22 Jan 2026 05:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1visL3-0002YE-BL
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:54:57 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1visL1-0004Yb-Uc
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:54:57 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-790b7b3e594so8519117b3.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769079294; cv=none;
 d=google.com; s=arc-20240605;
 b=gPmwsu7z4xXDKCOiP9ypZ/YdHzEG5mfEVxCO54TtA57zjBOUfl5yzKlpEU0WfekXfE
 I9/dpY9PmhS22vnWEKfLxquWaO4ZKHcgxwvWmWDDBv8UZj4g8OTgQbO30BFwa+YszppU
 2759lCfXUM3VeGnt4CeYaVqstCA+TB9MaumqqguuJ6rbA1Y5v9+cFt4FtNpB0AsFiPTB
 rDeecG7e8SPHuHHgrfBCW9egQ3pKcccOoEsnCEd5qcIyNyeSOZ7L52DD1sxRtwOPnRbG
 FABbgXGYDfadxT3FUamIHTZEstufvvkcUJV68vEt+sFcTYkS/a0wUV7DZZapv3EScsyZ
 FOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KBLZUlYPi9OL0gX4++Jxct32vanQpImbAVqWFhCNfPQ=;
 fh=N+o+eq/4hPV1kfIhajX2ZrYDjGiRW7QZ0l8rzgjYU2A=;
 b=fIRMD7a7eLoEc87/2kldVoQkSZATNGQQllMS7WO9YmhVNMyhyrsD/7yiOQtkwaY0VP
 zJ/O9/yYeXDJPgFI8HT1rVwWlXIXvMyRaNT0Xj7E2covQmNKwr/taX3moBOY65YaG5+i
 fmyzxYvrLrAIJvZt4fEaFvX0Twa3iiBo3k2Eu88jJnfBe+qxM8Vz+VeeKVM9k2rd5fse
 5Fng0Kk70Y6rrU86Ncnq9XIRSJkZXXzNtQOenarkPYkL4GiQTsSxFAlrBuu/M5B3PxeK
 +pZEi5S72BtnfYmeqVi/Tc2/YKJ/vijCm6TUwRezKEE0zDT7bn/XBP71/ioXJpQ6AqT/
 d2Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769079294; x=1769684094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBLZUlYPi9OL0gX4++Jxct32vanQpImbAVqWFhCNfPQ=;
 b=uML74NAJEus15GUHmuxlQi+a5zIhHdhAwURehe1TZnuV2qdGBS/lDYaZBZNBXi0mgu
 7RyS5g5OBz01/b4rnL+HSWgwE17hP4wjXlwjm0691tQExX7Ot+BcP6qXbyqjGHTdt0Oe
 9YVMv4yPr6tUCNJiC8hu5YdOHGAkkMI/2QeJ8X5uYL66GMc45vkv+RudZMMcBwBASY1A
 fjivYxzw74vUm845Oxt4CkUHmG6nOtbDZX3WVvarszqda+OcvtVHUQ/pQTiMAaaqKZAV
 7NCrC1HPc8z9b6CsXPXbsVtlqV9AyVHFcKnw6pxbF6bYop+tgygEsEXBNORd7XNPR6iZ
 m6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769079294; x=1769684094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KBLZUlYPi9OL0gX4++Jxct32vanQpImbAVqWFhCNfPQ=;
 b=sJ9ri05egx98+6xtvtq1pncjkACrM5Luelf2TRb2vwaUPtl3DfxtnZDqVC6jfRjFbY
 pjGR0GSaiXsAcEmvgx6+g3b+YAz3U++2qeJQ+jVWcPQcS/FqIOhSVt8y/iJcv3Ayv+DT
 bTWu2J9YgllqQjYnTtahUsCLfhfY12hobAbAobwEv+4CDvYVBM99OMCl5CjmnNKLPMMi
 I1lNEGGvPOkT6iQ1jIVJXxiqoJeNIUaZKPBiP2sljjyYrxo9NgzKh0vPOfsd3Vfsd5M4
 EXibOt3dtsOCJwTy4tzsM2mFFTHp6k0Jv+IikFlco/UVJ035hmQWZVsKVXhKji0Ez1tm
 RMQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0y6rSKW6dZBAjmMLIYnIDg7VSHp6hWa9cN3SfO6N2hpCiJFgf6fGNQY/YgBemoMDYLebodwrD0qiN@nongnu.org
X-Gm-Message-State: AOJu0Yx4cSzoX7tXhJl+lHn+lkEHncv3WkMNpCaivX8Cx7pkwcB5N3HA
 wndXzWrshisSPUX7RbrZRtmiV0zdBK5EQGxu+TdlE9JjL84CYLEZzM69n+pXnaESUe4lc1JfDGh
 L3PDyyaBi4xtgHvBpEDj3LPtCLxjS+LbVv/Dt7g0gWg==
X-Gm-Gg: AZuq6aKwmJqjhUJL7mJQCMas+aEYx0YiONVU4njkD01sBc9TY5o8Skhaaxr7hq2MIoh
 nNHhcoYfAOrhoCa7Lfusgcv6aDl1BMpfqndoTZiEndebV3iLr4r6aC1De7uUQLYkrkIVtbopFpE
 Hk4ewdA5DDIT1hIuExcI39ym+8gdBV2gD4JMiV+5//9m/OqQT4fX+bupucmUV2DO1BY2Q8za9Vt
 RN9XtXAe4LsrrUJnDaoJ98ZJ69ltC40vYiTfguP7K1ux6lXblNikKLP2aK0ShLhwgoO7g==
X-Received: by 2002:a05:690c:6612:b0:78c:5c75:c4a4 with SMTP id
 00721157ae682-793c523afa0mr186863137b3.4.1769079294240; Thu, 22 Jan 2026
 02:54:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
In-Reply-To: <aXH-TlzxZ1gDvPH2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 10:54:42 +0000
X-Gm-Features: AZwV_Qg8al33RpykEsKfUtlazBeorOsv3iS7Irhtzt5-pkGepdY89pm5xR88IRo
Message-ID: <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Once we have written some scripts that can build gcc, binutils, linux,
> busybox we've opened the door to be able to support every machine type
> on every target, provided there has been a gcc/binutils/linux port at
> some time (which covers practically everything). Adding new machines
> becomes cheap then - just a matter of identifying the Linux Kconfig
> settings, and everything else stays the same. Adding new targets means
> adding a new binutils build target, which should again we relatively
> cheap, and also infrequent. This has potential to be massively more
> sustainable than a reliance on distros, and should put us on a pathway
> that would let us cover almost everything we ship.

Isn't that essentially reimplementing half of buildroot, or the
system image builder that Rob Landley uses to produce toybox
test images ?

thanks
-- PMM

