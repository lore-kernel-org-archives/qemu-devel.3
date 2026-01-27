Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C91D2F033
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjsj-0008Od-0u; Tue, 27 Jan 2026 09:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjrP-000828-Ut
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:16:12 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vkjrJ-0000gO-7W
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:16:02 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-658ad86082dso576814a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 06:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769523347; cv=none;
 d=google.com; s=arc-20240605;
 b=ZkF6pqD/UodgPsCaILGgsLT8yErPrOJxqUn9qgwNSrrr+k4jgk46M8CNzEXD7NWTFc
 b7xdoMsgUtFd52TlmRUmObdT2n3S0jM/pxKL3pPYfDBPz5p0/W+l/4nxUab0GOrUpJbI
 leojMNX58tg6PylQJLghD9TqtoRrqtltD0dc/O6rrgUPuB4vsPLk5iQkeA4poUqELYjj
 v3zEzFpWPA49j4j3k6Frqa8QQDCQR9VW7sGmYy9i5Gn7p5bxli6SYvOm47ceHChNvlEE
 5nCQscejRJZVV0XEKu53uwVXAS3mz/Nut6kjuBCDe3fahcBAZldgB8cyiQtScSaSe1QL
 BIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GLbiF1IyZPp/T8r4kh3zX4pVEjDnyrX1mrjLQME69P0=;
 fh=csq2lIN7PLnSM24P1KVZjMpFV2adD2H/fL+m0KeiV9M=;
 b=FB4HiVz0xaF9htvipn2GLgdKmFH5HzoAoplklSCawqzSKajfHJTEyuXNzs8HC4o1hh
 +NmkW1lnsx9qqUilf/Qj++a9VNsltIj242NFY/F8QwNVtyfQUW9NfayhzHDP9TVkeSVQ
 qzsXTpOvJeODjHF+9kqkC9NzRRvEFJd5Q6xyEflir+P3vd6rRU2PrGlZznv+bYmyDruM
 cR7F7BzRW7QVpG1RSeEg7obzXu+EbZ6Qnrq0uasUPkH9BiNTW6uen78SZljzlDSHu5g5
 HZRg3B2ekVVdyc/z6mS0V54QzexCW3eRXl7DZr0893F/AeXm8CVnvZgRHrnbxRh5cf4z
 qQmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769523347; x=1770128147; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLbiF1IyZPp/T8r4kh3zX4pVEjDnyrX1mrjLQME69P0=;
 b=Pv01P5DfqGL4pjogEuBXvEXVoO1iBPBgZ4AF4fovYEMO97LjG9orV+oyxDAhD42EP2
 gfvHHSQJ9L/Eqq+ZuYhPWIE0BAtcyUPdrP4nFiLLSFQcQcjvErgIym6njsR9snqU5DCe
 WeKbOEHrYFjQSO8d3igLkem1P8JQ/U+9GcYGEvTTYlpNkCLzXJauWh1OicAbUeJqSodM
 QdL/XAADcfGvl8PLLD+Lmza9Do01vxic3i15tIr38u3ZyMfvVnlQuU1dmw1G1P5psJgs
 2QyjEgkc0UIu3yiuUeDMuPZr2idvl+kL1QCkljg14FLTKZt+FFhZgdTKysAjI0ApIGWp
 JsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769523347; x=1770128147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLbiF1IyZPp/T8r4kh3zX4pVEjDnyrX1mrjLQME69P0=;
 b=ZdYmd3qEon72u6NqsEeK4SESS8LCJQbLU7HeFHXiPnuZkeoqjLFsYUGSLQoajqzVGu
 e2gZ2HOewEJm4MWVvllgBtT55lwZRbobV5j4oIvXAjf65YOGOAPdyAXqOl8l9prdYrwi
 tyfzQy+uxzqxxDZoG4mrFswGwtPbYdvO7SI5PClUsWQtRbisr8hYKvP2S7p/HJ95ls7o
 UX9TbJHdi3uWCn40YL6QU0/AdGWudb62hYUAHROrxL0NzpDI+SZ8YbiuvtRk08iiz5tO
 7GCAGkbOD6MhuQehS5/33F2HIoAJ6zXgm8b4TN6wR0try2Mty1xLT21aWf+SXf94c+AY
 KYNQ==
X-Gm-Message-State: AOJu0Yw24qwaSRF2Z+SUhWe8k/jCjt3tAo8Up3hp0enF+2EoWNLtoZhC
 ZvTETdBf05E2tgcyAvIj8KpDMpA9iUs243vGl7b8+mwjI1WTrvVZjO0JOezDosuihjDD6Gd3h1z
 Y7vG3uldFLkDC06P9pX98LwD9mmZu850=
X-Gm-Gg: AZuq6aL8rVfZVPHiFO4xIg8jWiErZQ2qSFXMlwLPKlLENS+FeYy6i6/8GIo3etPJLhA
 5SOjFGFy2Yz7Vdp3nS55+ZE+Eidztadr14yL0rDlbqcIkfvqmskPLIufQ9dhWwH7nPnZvQQm/uR
 XTnclOrnMgfAdCoPv7yk8CUoMj3iaJ4DSJVtp9lgyjMJf4KcuQMwjeihCG3se9eFOvflIWYsUmL
 Wl6jwA/jHwIVFPcP4jbN62+mQ16d1yhQlAa72NHKvHIv2+h3iu2DRHxvicq/aPByqF2UtVIt/S8
 mE2A
X-Received: by 2002:a17:906:6a01:b0:b8a:f9d7:1aec with SMTP id
 a640c23a62f3a-b8dab15b734mr150184266b.10.1769523346927; Tue, 27 Jan 2026
 06:15:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aXiFBwcLg4PQ/4m7@fedora>
In-Reply-To: <aXiFBwcLg4PQ/4m7@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Jan 2026 09:15:34 -0500
X-Gm-Features: AZwV_QgT0Rw1U9KUEEVJyOOVyteHUrByewQIHIWfVSpxhCJGe_pPA2lGbCMICRg
Message-ID: <CAJSP0QU9aQTa9_7w1XnBchhmxMTUQjqG79tm-MS7fmhtW27ahg@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
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

On Tue, Jan 27, 2026 at 4:27=E2=80=AFAM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code internship
> > program again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email by
> > January 30th.
> >
>
> Hello,
>
> We came up with the following idea.

Great project idea! I have edited it to get closer to the new 2-5
sentence recommendation and posted it here:
https://wiki.qemu.org/Google_Summer_of_Code_2026#virtio-rtc_vhost-user_devi=
ce

I listed the project size as 175 or 350 hours. This will depend on the
intern's experience level. Someone familiar with Rust and who has done
their research on virtio-rtc could implement it more quickly. Someone
less experienced or investing more time in testing could spend more
time on the project.

Feel free to edit the project idea on the wiki.

Stefan

