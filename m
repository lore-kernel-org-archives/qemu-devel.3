Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBBEEC048B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMdZ-0008SZ-Aw; Tue, 03 Mar 2026 05:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMdW-0008Rn-Tc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:05:55 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxMdV-0004VU-B1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:05:54 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad46a44easo4589113d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532352; cv=none;
 d=google.com; s=arc-20240605;
 b=gimbIlcCF1Hf3L8JYIOgH7/YIg0QEmkt6nBUEmKm7bQIp45c7yqiJbHXlTZc9RJ3bl
 4vVAuul6XBqc1keKopheaRy8Utny2GG7ywkiZXtPssTSJllOkMJb0x2E8KP5dzVxeLRa
 oVmSnKBDoojPZX5xWaoG2DHIRpvlkOdl12mXtIl59ex9v8PFQNJwIYNmSKEpIpGQlQtW
 GaDLVnbo1XnVYJ9+ROiHzHBM+nbrKELiqh+u8F1IFXzD/4s0os63Ulsij4B89vjXrIcR
 pgV4UIEnwxr80GWlYVxT7Bs69n5cokNdkCpPGNQmcQL0N6UR5Xjlnb6ff0Qv1CTMYM/4
 aeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aNuxz4n4+KbIzJ44/0gryLsO0yaOIawHyhJIwBoOn+8=;
 fh=G0XyrnbfJb+gtQB9Ni02xOrN748RkeIGIfEaxMkh8xE=;
 b=SqRuB+hbXMFVaUfMK8bJoBQoo+uZIN0QVB92MUKn1HY+NBhV8VrZQLn1z7qmdXPhlC
 hOYYOOgrvyqhuXaqahCRq6wxblfblWQNo7dJiQbJUA0I4HVBnyytUUIfvdtmmNcaRsaD
 bYzWhzhqV+ezchvYcW59n+X8hCmk9EUIcsI7LoGjUcpc4b2HNpgjkSUAfqYWm8mohkuj
 GDK7PSPam6+qaUSVGrCIwAIOCrNEoN5E5NRpThXD5AmT7kGt74anVH5Tnii5eTHafZdR
 AwwhIQUYOg3CTg34rbvxpRuKWvhy0AKr2Rm+HHri06eymWHr2IFXV9ejvi7HVdZU2y4k
 5ikg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772532352; x=1773137152; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNuxz4n4+KbIzJ44/0gryLsO0yaOIawHyhJIwBoOn+8=;
 b=gJKGe4Eu4QuruFS2cftyR+MfF738hr4O3ialw6IicVXV6VH6CZvefpJI1ImlcAfWtQ
 tL6ttqqRDLcJrM1fiT5QwElqMaX/qzVmxPdStQtgIY06hlGC1h15kQYNTEYHXhdwo+Ds
 yhijDHEEFyJvFsr2pjDEfdbK/fwHwYp+Z2LNOXOyiNoPsq2xgsLGqM7iRVYlnL3FwQO7
 zRhakvc+dHg1fCKu28e2tH5r3fEjV4ZtuaBsago/s5x77K2mtM5a+AWiJLa4JJJ5invS
 P0p22xmrNZAnorPBT90z3R7G97fxBp9+d9EvE8Rzbwa8fqSsxAurkcb9v4AH/TEJbF4H
 Kedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532352; x=1773137152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNuxz4n4+KbIzJ44/0gryLsO0yaOIawHyhJIwBoOn+8=;
 b=a7v9ULoOfdgoU1Bf5YMMTGoiojcK9uNlAMRIZYB07AK0HHCw9fmoqXpqYE+mpuTJWy
 AAzvx2wDn0iouS/u8FddHcj601oIQVWCscOzAuVKR5CDfYWjyBhL3RspKdt7mVYs0GzI
 IdUWnP7Xq15EzngnyuidaBajlZOG5UGry/QrHrfZhwiVEDI+UdPjBUp2/LtvLoWrdjyJ
 v2vCALK3wMCKxxD6Ytx+Nx+ywvVU1IHQ/HjdC4qxj7TgXbULfu15tUCt1NdHEzrQ6XmY
 eeFCVpyOcwmsl2Fu6iZU094DTDGelnR6wEm16cgSvm30zJ8SPaqbZrkb8nddqTbYYi8z
 iCJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1xaTPTVaN8WRNpwWLtm1GI9W3ozif46/vN/CajooKeqf9QeVzOMUgi0fJJ6Qo82YjbGGKmGXurO8M@nongnu.org
X-Gm-Message-State: AOJu0YzCF5ZJJu5uHATreAaYOy5JmvXpVrUmM3XoQs5MQKmBjJJg+vhX
 3xYFvavTV2GzmOg8qNul7M43nt4uLzqYOonbVwrTDSCO3jzeqOgl1dBjvBlrqPwGzCrhBBN+2eo
 bJzKRr2MJf0MQQvFlAWS2dfAXNP9ucM2CvPHvR5FCbg==
X-Gm-Gg: ATEYQzw/r3+DcJLQjW9OOsi/Log2pgLX2JrsucxEMxe35cvjpg6ud3fugl3BOCyyqBn
 +zaY4tt4EA4bQTsdAX8O06nd3UUVDRu8jlzyfJ8Zpc3WiSCartJYwMRcCeZzcwYgCI9SjcQeMkp
 TqIttiHDO5nMyC+T5v5FusaAsthvGxCkuZAxxfRMUSl7A1cdcZ/OH+fHunKBSpz0waxCu/OfVtw
 gCziV33euE8sx9OOFC4GErSTiVGuQFbNqbMRLE4Ob/glLlYdxFifL5NZQ0l1tc1IKEygEzUKnx8
 vjumsitwpe7rhGJb2tNHmWFAxmKADDwybIlmxyFIdF0+Zb4iGhdrMKiV8Bjzfjlyljs=
X-Received: by 2002:a53:b4cd:0:b0:64c:a3d5:631 with SMTP id
 956f58d0204a3-64cc22bea64mr9792544d50.63.1772532351953; Tue, 03 Mar 2026
 02:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <aaadd0B4kP9amEbz@redhat.com>
 <CAFEAcA_YMukxSh0YWsxADasT69BZ=BR1Q1NkGeGWzjXQoUifSg@mail.gmail.com>
 <aaaxZKWz7NlJSD2I@redhat.com>
In-Reply-To: <aaaxZKWz7NlJSD2I@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:05:40 +0000
X-Gm-Features: AaiRm50AXUE2YxImkL0EYe1-83KW-kfXkowQZr4cUBzhUh2AZXC9CAwsMMpIz2w
Message-ID: <CAFEAcA_nCSah+orZrMvsit=iWWp8o9J_Y8Fg7sMJP7XeV0_GBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 3 Mar 2026 at 10:01, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Tue, Mar 03, 2026 at 09:36:45AM +0000, Peter Maydell wrote:
> > On Tue, 3 Mar 2026 at 08:41, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> > > GCC documents the possibility of false positives, but I would conside=
r
> > > that caveat to apply to CLang too. It may simply have different false
> > > positives or at a lower rate.
> >
> > I'm told that clang/LLVM doesn't have any "middle-end warnings", so
> > it won't have the same problem that the sanitizers might change IR code
> > in a way that results in a warning firing that didn't before. So I
> > think this "sanitizers change warning behaviour" is specific to GCC.
> >
> > > If using sanitizers, it is expected behaviour that there can be false
> > > positives, and if the user doesn't want the build to break as a resul=
t
> > > of that, then *the user* can choose to disable -Werror with the suita=
ble
> > > configure warnings.
> >
> > It is expected *for GCC*. I don't think it's expected for LLVM/clang.
>
> Oh, so you mean CLang errors from sanitizers are not influenced by
> the use of -Werror ?

I mean that (in my understanding) whether you use -fsanitizer=3D... or not
does not affect the set of compile time warnings that clang emits.
Sanitizer errors themselves are runtime ones and the controls on what
the runtime does when it hits a sanitizer error are entirely different.

This specific case we're seeing with the rtl8139 code is not
a sanitizer warning, it's a plain old -Wstringop-overflow
compiler warning. The sanitizer only affects things because in gcc
the sanitizer pass is in a place in codegen which happens before some
warnings are emitted, so the things it does to the IR can affect
what warnings are generated.

thanks
-- PMM

