Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99CBFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSF8-0005hp-UC; Mon, 27 Apr 2026 16:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHSEZ-0005Vr-Ff
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:07:13 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHSEX-00059R-DC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:07:11 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so9259800d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320428; cv=none;
 d=google.com; s=arc-20240605;
 b=YyEvOGUMEuTbzoRLFtom1TrV9v3btrJMDzlDvW4ZpRwM0AdJJ6OlZxzNx3ep2Y/0hg
 iBHOwi/FAgXeQden1fdP0RShvd6m5TyxmXEAzAytS7e7h7nH/F8KEnPXrjRLnzlPa1eA
 QXbTPdJW9S3LkEfdB3EgX3IBaIlMSjwJBLB1TOBFB28FUTasf6cU5H4T3UkCy6Vk6CG6
 BzuMiyy+bD4oUIZObWAoLFpa+SxF89sS46IjGzoyzJeTOFiWYhwQVF9RfdSoyyFF0qdj
 Zcqv/pYt5PebJOvjD5GJPnt3HSjms0UI0vxdAx+nJbOet0kmhnS+HPR/bps5p7XsZqoq
 v8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xn/TBp/Nx6/YQ4VrEjz2EiO9GEMY9btDVQDgIILDIIs=;
 fh=1Xd7Wzgni5O6OiQrUAllr3/n2A2vZ24jpGmDtX3IXEk=;
 b=GptLggTWRHtMaJM3lR1ANkWVNmrQhJ082hY9aHwqlMRCqTg98z6AdbFRGvnSicWgjb
 nDJtDds/3BtUkY9eskBW2ROwaU4ZqTn9cZN/6WtdhvXDe6bP898Za3gbPwW/vGX/bVRe
 TXPPid2KtpAtp2/KnvEGTracalhM/26Q/VWR2nRG0Z0HRlwX8OqkjSZ+YKH3ph6kUuOU
 p25S3C8K52thaCiMRgqCd1EheL7dTVvv3sp2kQH0lEbim5WC8GNY16qRd+aIAj9Fd7md
 WH9OuIBMTnU0xoL2zSMpYyXVC4+TW4jiz8Ab8ZO2oM+u24CsTVVFw4ITxD559WoHU5Xj
 X4FQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777320428; x=1777925228; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn/TBp/Nx6/YQ4VrEjz2EiO9GEMY9btDVQDgIILDIIs=;
 b=qPbUaJgzWMn6queBydNKAKhrlzcZsMaT9Y/Z6bXAyNxvy6UiaQXyedDVnt0cw5yTu6
 0taD0BrfVOLBxPSGvltbrLtQWfJnGibKzNVVjSZOPrbb1epV/L/XiAbJcyC64lP94MQ6
 xsu8+7Q390/iI7ubZi0nALw200JUvNCNlj0idatNCnSRar0wRps44klxP2MsMkKjghRI
 9EZJNjh3jBG2BCw86X9Thp/uNv3mNdgVeRRNZHCtfIaC86jHDxSk0MLMiXT8HrhP1c7Y
 0RslL6ngc0Xed/xAjP6JMb/GJjYcW4umjXEvuFxX4dLtm3PDS/6p/I1aXKjJkoGdsZWN
 8Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320428; x=1777925228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xn/TBp/Nx6/YQ4VrEjz2EiO9GEMY9btDVQDgIILDIIs=;
 b=cQUwimklbG7s+6bJEZDqElqZ+r8GiVSwsWwjzmuhguiyBJtDEa+2HhfUMk/v6Pdm4V
 EyQO++8Bu8Evpick3M4LIRITwSXtUyYZt/VaLOPW1GabBUoknzmCx334XNbfQ7OpazA9
 LLL7CF52dXrteUAwk5wS2brdEDDaNvMsC2szmQHicmiC6cD0R7Q/tKnR6Zii+eNL3PJC
 Hmlu1sHlGGh8QQ9KatGc/+uqUj2wNd82yEwvx33tqzqS1rgtJ2w3fYFUEo0C75nJTaOr
 Je/zzrpFvBlGYJUMeScxG3tn6HDRSDkHNLo5+VNnnfMEn6WtJfRTQG6721BLjXZLV+Wg
 zREg==
X-Gm-Message-State: AOJu0YysAJNNQeyzMzuASz41+J+GDSUUivOlWose4O7RhvQq9uoBdUB5
 epN7h+v+OJljXnXW/ePb6a6Th8x0U+0kzW8np0097AcBG1/PVq8rOcYbNJFth6UjKVfJyEzKQiM
 WkD41eRVH6wajQmsaggffwRytiiKEsnw5p2iJiuPpNhH1z/1PauPa
X-Gm-Gg: AeBDievScEuhgRpRQEOv1dCAu18cYHqgDQGHRiuvcFpZjhdIqQNwAuq4kC3EZgIp9cV
 q0yE3MgVN5PU3praiZqMgyyZ465GI63+t9aNUXAFKzLPCJ9n7s4YUZ+qA4UBwzxb1/Z86tg4wRB
 iNcdFAcUduK3VeXXGSwYks6nYN5yCoq69Fcu3dX49ejx8flGgFcljuY6NjV8Ws3feqqC825p/wB
 dChFjapFRJV3xe4nktdn9ILA7oHYK1X32H6Q0tFvqt6EVaDyPAHBiec2hJjuFS48KV2do6Sku+K
 ZP2qZ0Kfr0z32yWW2Sjit/wKNB00hwYsE0aUHP4X92UHSjRzmUS3aYI+OeGFMo8HUwhIxlKjauC
 TqqaG7bUeEbTy
X-Received: by 2002:a05:690e:4149:b0:654:fd9:2e88 with SMTP id
 956f58d0204a3-65bee827fdemr105862d50.31.1777320428223; Mon, 27 Apr 2026
 13:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-41-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-41-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 21:06:55 +0100
X-Gm-Features: AVHnY4LCWLL58TeycfO7g1mW80IJnQkVTMeSNMy2Mx9VI966I-9ViZbIV21LtOg
Message-ID: <CAFEAcA_7LT-gpArvYpabe9UiFPDGDMEsGOTMeivw90SVDjabeg@mail.gmail.com>
Subject: Re: [PATCH 41/41] qtest: add "qom-tests" command
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 27 Apr 2026 at 20:50, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Add a new "qom-tests" to exercise basic object lifecycle. Instantiate
> all non-abstract objects, get and set properties and unref.
>
> This should quickly find leaks and other related issues that are
> eventually triggerable at run-time with QMP qom commands.

Can we have a comment please that says what you think the
basic object lifecycle is?

Also, the qom-test already has coverage of "init the object,
introspect its properties, unref it" -- how does this differ?
Does it duplicate parts of it? (qom-test is already a very
slow test so we don't want to duplicate work if we can avoid it.)

-- PMM

