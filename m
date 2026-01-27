Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EEED2F037
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjum-0002Fg-1u; Tue, 27 Jan 2026 09:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjuj-00023c-3N
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:19:29 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjug-00023J-6w
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:19:27 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65819e75691so9982976a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523559; cv=none;
 d=google.com; s=arc-20240605;
 b=HWNvTq9RhiuO6uQyyr+5tdLOTAkTragD2REdjG4dpz62hOq1PEr9D9EL18ET2i5sk1
 0BTcsawrdGxhqjk0PMTsWWSPfcR0lg+aY0O1Zvuvpn0egsan3Rtp+LM1PBpBPBsybcqv
 yjMpHmLyV3GKOKqrmenJEAy4kwsgHWq6vJVyXWMAls7d3A0Tq3KxMqfja6EoXHjD1szE
 Ix81qUSEOQpZQQ2zqGUwGLif1fGS2Wr29hKkVTSAa/9gLBacwxcGoCfRIWoNm9GRvJ8w
 7aL5c8AhG7mKyth0CtlBHHPY+qbupCKtKPQ0l5cn0nMvZmt9AaOPvQyo44GxHUUzDiLn
 LxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VKiuTkJYE06Lgz/n80ZUl4qT2rrzEkJRyX893wVmM2Y=;
 fh=CV/dqRIWguRoJ/y/MVfZNp3Z59pc2N3jZK7l3YuHCIU=;
 b=OgFAe7FD3v9DelGSLUISP3eHHYqaxzjPiPVr8+2SSnP1qB0LjdORRLkjjjKcrQceYN
 B9eKPv/U9KLY2Iq0sbw78sRR0OOTVvJejM5eSQlvqF89c8avLtC/R2DBBHjiZlCVFLag
 iNja15gK0nt14h7Q0zZA0VkJ8A27q4tmb9foGR3Upp1jR00WCEvj7xhDLhdV1Og+rf0/
 Ja+vsppTjgzUAXu0mWyIhQYdkjLsS1IRsBUP2rgwt2dm70ZOpjhl6j07Ros6KkaBYSZz
 8Bx0ibYTFxN3euix33rml0g5xCw8mCEU2ALle3HjdOGbj9RJQ4a/s7KQdLmYOiw4u7C+
 //bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769523559; x=1770128359; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKiuTkJYE06Lgz/n80ZUl4qT2rrzEkJRyX893wVmM2Y=;
 b=Ae23VbXPtqodjL/kZ1w6BsMEMdV9iRTbn4dbNck0gcPL/Dzf7Ei0l1FWUJx9AtNVsv
 +UdGc+nF0toWhibuY45B8dXrlhW4omFnG2uXZ6HsmBkYraxHdD/BzxtsWdMVWG5fcW7m
 W4akyWWlfSaNfFy14ZmI7COPsVYM/GuQGZWY8xu1cgGdVR7lQ3SNXsWz1+kvC5AjQXJw
 YARWz81x4EWGkWI8OLnR9EG4Wzvbz4mUNbhkDXZGkp6e89aY2wgns2qHjIGsdfHVhrDE
 2x6cG/F1ELifVaRsiToYknoZ4+w1FmLKMTMxJz+4oPO7/LJlS+S5/Sxce+1OWCCz+REA
 /EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769523559; x=1770128359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VKiuTkJYE06Lgz/n80ZUl4qT2rrzEkJRyX893wVmM2Y=;
 b=mqyl1rRSwcNWFXOBjENVJ/bXEzn08WoC/l6jeQFH39VoeZ4UYXLHKK7iqBFrR0sPM8
 KAn9Z/bdImpwxMoYjy6BYIzntrME+u4TjbAfvZVu8TI0XPzrT3p3W3M9eO9EJNicsf6B
 qoWZVqrB6JHjv2seb9IVBvFSlkKYf+p20YpLI8V/H5Rnp7gwzFxwmT6o8HbfaKhvRfiD
 cCBWph8bCuVCsisP1G+/V29MqKfHsowr2jtE6+qcG7Y0JjhfNQATfmTKHtPKP5dsdM4Q
 e5cBOsSf5ZotSk40aguqlxx4dd97f2a5lAA03uycQvhKyOEIfcsvSP16dWFgreGJfFU8
 mNkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJga/mSS3SstWaqwQeDkFnuMxAQMnHvXt1be0o6tdWKzim/J/xtww2UuNkzTsbQ8GO1Jgn916FJcXi@nongnu.org
X-Gm-Message-State: AOJu0Ywep+6lfGV/eEZuCoozxA3OYeYnXoYTmMU5ZXgXvNa9E+5irrjX
 ESaWNdQ47JwQ2u+WglAE5JHlY/Jn/3DNRMQ6J2qcgmqVS1kqBQPVJBqfb6aj02ZZTqNhwQceAzW
 0s/d7p5EcQSKBtZ+vNAoaacqGSwtmyMg=
X-Gm-Gg: AZuq6aLxt1nTfsF0g4+SiRWDk9Eja0nt2Ygem4vjaNZceOjlSxf6g0DC6o7OFlFUAzT
 kRyF/76S00vnbXvXrHURq2q7DFwgJ+276re2q3AkrFdoAjcOnU59mrpLOBWxPG5wKEdayTfJTXx
 mKqybRUSoxehgHJtt7kslUBItBgEtto6mEi8DQdJbxe00B7eaVnVFNmeXhJey2Mw7H9P3CWNbMh
 vXLq/3uq0ZG+KrHDVgsAv74IO5nMR5XTMbBf8n8jD22w9osLd0JqgfXsY34Sf+NyxKOBCO+HTj9
 avye
X-Received: by 2002:a05:6402:13cd:b0:64b:46ce:4706 with SMTP id
 4fb4d7f45d1cf-658a601598dmr1061746a12.1.1769523558946; Tue, 27 Jan 2026
 06:19:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <CAGxU2F4K5mAhwKSLkCk+f17=1FA51WG_XEzhSr_hxNKJTAGi3Q@mail.gmail.com>
In-Reply-To: <CAGxU2F4K5mAhwKSLkCk+f17=1FA51WG_XEzhSr_hxNKJTAGi3Q@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Jan 2026 09:19:06 -0500
X-Gm-Features: AZwV_Qjy-_kYacMG8ZkkvHrkO0IeQfXdaCNrJ3EiacBY_1YmYMCp9mRdGWf8M4M
Message-ID: <CAJSP0QWw_nvDgMgtzi4jZjQ_q=qSRtpA2rN=_49wfOcRhC4jOQ@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Tue, Jan 27, 2026 at 3:35=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, 26 Jan 2026 at 23:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > Hi Marc-Andr=C3=A9,
> > I would like to submit QEMU's GSoC application in the next day or two.
> > A minimum of 4 project ideas is mentioned in the latest guidelines
> > from Google and we're currently at 3 ideas. Do you want to update the
> > project idea based on the feedback so we can add it to the list?
> > https://wiki.qemu.org/Internships/ProjectIdeas/mkosiTestAssets
>
> Hi Stefan,
> FYI we are going to submit 2 projects for SVSM and 1 for rust-vmm
> (virtio-rtc device) soon.

Great, I'm looking forward to adding them.

Stefan

