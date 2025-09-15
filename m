Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A7CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy9Ez-0008RU-30; Mon, 15 Sep 2025 09:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uy9Es-0008G9-Rz
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:27:27 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uy9EN-0007j9-0H
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:27:08 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d60150590so25773947b3.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757942804; x=1758547604; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3QZ2Wx1HpeTG6nb+EFKIpGJJt1y4dxGPuginnej6FHY=;
 b=Eb7d+xh61INdlRsTivXk2SZrJfyMXOaC5M5zXMEvKNrkpVsuSPDXmu5yYnFjPEXw9F
 NlVBzhgUSrhsf9VK9ok9WCMptSLOPNH3/xrDpsh8yChrqxO+4wKa0pGaksQxuqCSxTee
 WGt0Gzz91+OYcBmPE5gOwhggMFZ3HyLXKMPGJP+8mo9Qy6T/C6vVZ9Kwx2yc92kfSSJ9
 QPZBA9JDTzT1rMs1R/m1wugD7j7YFFVSW+A73/hUxebQCYpsEYvV81p5e65laqhlrEN3
 FmNaTzAoGeMQAc1R6oUAoPo9KtvxtjTj2pQFR7qnZ0F0TqqtJLGga00a7yLApBhFXTtm
 BZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942805; x=1758547605;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QZ2Wx1HpeTG6nb+EFKIpGJJt1y4dxGPuginnej6FHY=;
 b=RaHnDhXOiaYDvmcq9TUXh2x+sGQq1KWrtuXBHLJouJR+HaXlQOwnqBkkS11NmTD2Xa
 Gn0jgS3/l0zJxBTErxEwcyQbcoFX9DlHN9ESHYzZ9IbNz1Uf7t8J2+m2L8sdeQTc24Oz
 vKJePGP8NmlfAud+R5AHrHRaapvfGB7u6am+9oJ2cMCm1Ji8zIZZqzog22h4E6nUzQNC
 UkDv/siET0TWQZBvuKghg+lkHtI8cR4dOIFkajG7J9OkersnTjCMe7Q3z4AOZRXXuY1q
 7ibIcW21p0QxzJZ3OtgltIsRnj14R4TDqUlWj4M0RAN5sRAX682+mTrve/4eKGi4CKnN
 /Ovg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv7n8a4Qe587SwhXpvSV0/rhWooYp3L4s9t9IPz+YHgVxEpZ6xLCvKZqpFtw9OscHsEx+hjQNvb+pT@nongnu.org
X-Gm-Message-State: AOJu0YwF0iN331ol8wwbxQL+W/VudK2qJBaF2thCGhkylJiQjnsT8JOv
 vrx+7+AZt+Wlh6CpakPQ4hlhdEZukfRSHGL0QPy4+UBsSh1ODpmkhdXLb/NWWlArGMGgtIHKJGJ
 nuYRNqnPTbeoGKQtq4/3vaWzuxKb1gFFSEVQeOer2iA==
X-Gm-Gg: ASbGncu6h0MjrgihV0RTky8hgOAqcfHWi8ME+H60MN50gfJDEh5rj7lVsuF4bmJi6XM
 Pp3Nh6EcGBNPWh1fY+bRxORMIixBtMDJ1tGmFSAMYaxUElYEU02tOJWI4PHtIabOQe2AOJ55pwK
 pn0Ow6riSovyYUIOcMWxUEpXduM9slVDZB0p9p5Qjo3aElhXtEiEIqFDp+EV66wIXYpFnxpbRqj
 7RKcbaz
X-Google-Smtp-Source: AGHT+IEhA9KMQU4R0BLymNyjfWKQ1eyEZJ2OXZdM/4BT3SnZfYSA3Ezf2CgI3uqKoFcw0/gwt1CXodH/EHRZ1Zh6ZrY=
X-Received: by 2002:a05:690c:724a:b0:735:4c38:5413 with SMTP id
 00721157ae682-7354c386134mr10202837b3.9.1757942804377; Mon, 15 Sep 2025
 06:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-25-pbonzini@redhat.com>
 <aL7oe3sis3bKJhLW@redhat.com> <20250910131633.4b66856d@fedora>
 <CABgObfZz8pYRSDMw0Hq+wpcWPL1Oaq_TPtcbSAnLZW0Gr3XSng@mail.gmail.com>
 <20250910145631.32a805dd@fedora>
In-Reply-To: <20250910145631.32a805dd@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Sep 2025 14:26:32 +0100
X-Gm-Features: Ac12FXwd8_GJLwxWa-UydgzDLfrOS0SgKJmcmm9eUIvCtZUZ-d8Ujos7Ofnk10k
Message-ID: <CAFEAcA818dNUH51ih0dxWtDY30K1kiYxN1Y987tSsYaxziuELw@mail.gmail.com>
Subject: Re: [PULL 24/28] hpet: switch to fine-grained device locking
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 10 Sept 2025 at 13:57, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 10 Sep 2025 13:23:10 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> > I've only looked at it briefly, but it fails on the bql_locked()
> > assertion of xen_evtchn_set_gsi().
> >
> > I think the assertion can be moved inside "if (gsi && gsi == s->callback_gsi)".
>
> given it's manipulating interrupts,
> shouldn't we take BQL when doing so?

Yes, if you call qemu_irq_* then you must hold the BQL, because
you can't guarantee what's on the other end and it may be assuming
it has the BQL.

-- PMM

