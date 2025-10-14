Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3675BCCD185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 01:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Tci-0002RK-C9; Mon, 13 Oct 2025 21:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1v8Tch-0002RC-Ma
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 21:14:43 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <navidem@google.com>)
 id 1v8Tcf-0003mc-B1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 21:14:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-639102bba31so909675a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 18:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1760404478; x=1761009278; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=depUnSTPyQX/kQi4tNswxfK2BIXr7nT3ERAJrxuE3c8=;
 b=gEWGORMtHKozhSkOpvEB661NRHlLQ+4X4XMqI1YjP4czGrSXmXTw+YAFb22/35Uw9q
 9wFcALBHA6hhVwcC9pQjUY4Bp6OdPthKZefVoOYkV2CEY540cbi60sf1HorKYf4vR6+B
 uneY7TK9dRv03CQU21o1G51AIlCqGBKT8FLk6iCz8bDakfC6kEHl9ofGDnJXfgZpkLEt
 xQC+Kpfhoi+N01HCmsH2izNzTlA8wfzJoUA+Nu+wHoFwF+AwUTFz5bX5lrWHsU/xynMo
 asoIuwWYRMJWR2q/1LuYH0PNRv8+sAh8HqykgqTVrDYEg4V3UIQbLBy7QWv+E42wuPqi
 x6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760404478; x=1761009278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=depUnSTPyQX/kQi4tNswxfK2BIXr7nT3ERAJrxuE3c8=;
 b=IKZAvCksRXUsg60shRmY8VUZjPPYkBwYTzvA7pRFbMuTokxfd9CXHLqw5eeKFG9Rd7
 66qBSCHsz4YyUXlujO1b+kzsG4IJrOOj7M1d4k/82CSD5d83TvqNlHfNjuNQXntJUxZJ
 T55QHtISkQOR/uF+A8D19EuB2jTVK0/XKqA55KYjhePfHG7sAKzoeRNLWFos8Gpj4sGv
 T9G6fquVxSmtpUOJmeyZ1bLFsQawICiAgJ2vTGJx6y4McJ7jKntQKHMNFciA6eeazwbi
 P30mqUVAzjblqBRqkZ21AHXFJkca1TbrttlZR8JkQerWrY/sIW8Gyi32HodA6oSqvalR
 tYMw==
X-Gm-Message-State: AOJu0YxKwFfJ0+ihnYnf7gQ7K3s8sXNpFkB8euZ5vJzQqsmyujm8ULbP
 k98EImvd/90D4SVL3OeKDVoDJ5B0G2389t83XjVn8Yf/EAkRtV7ypzVsrFp0pmVKu+wVG77XL+U
 MRBtZkDOCM65QaVeTdAATlYdzKbTIAsSUKUWlwcWL
X-Gm-Gg: ASbGncsv8ZY6uzTVZaNVNMRJ5ghOyOpCUlOgkm0jQSNs19vgvmi7NWzhvACw4Rsq1Df
 L7YdNTqyDtgTI3NppYavb2opACKix4B3V376UardhZZozfDQPeMV4Eqhcd1yUyM79aismh3Zm0N
 0XWGoLl0So0jJ/jtRDByjpIkMep2DMzaNdewEw0j059E8f7gJ+M8GIcdYVjbOuWPy5BU3RhW6Q+
 0XoOxYJGw36hBXhV1MltM3c1LdhXI2A/U6JnDPWGatlMMiqEsolhaE9ti6L314=
X-Google-Smtp-Source: AGHT+IGu1lyMjFVlVZthKbsiKJJHTiOzou5/JRA81x7AemkHQMI/7oI0uuNUbzLrJvBuZrATptq4o1tGS25sG7NCEFI=
X-Received: by 2002:a17:907:94d0:b0:b04:7232:3e97 with SMTP id
 a640c23a62f3a-b50aa3921edmr2466828366b.21.1760404478370; Mon, 13 Oct 2025
 18:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251008191936.3069950-1-navidem@google.com>
 <CAHUE=o-X1sJXn6SWATUUjX2GHUsh8mufk3MZHVkKDzzFGtbSyA@mail.gmail.com>
In-Reply-To: <CAHUE=o-X1sJXn6SWATUUjX2GHUsh8mufk3MZHVkKDzzFGtbSyA@mail.gmail.com>
From: Navid Emamdoost <navidem@google.com>
Date: Mon, 13 Oct 2025 18:14:26 -0700
X-Gm-Features: AS18NWBqBfLXq33Z-t4isq02CqQT3Cml1Ui_N9YKl1N1uZlvjXi850mqno5vPRo
Message-ID: <CAGXevkjvVQE98WqE6-QcWc5jYvgycymhJYmVnEGUTdwNwNyH6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libqos: pci: Avoid fatal assert on zero-sized BARs in
 fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, zsm@google.com, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=navidem@google.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -178
X-Spam_score: -17.9
X-Spam_bar: -----------------
X-Spam_report: (-17.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.268,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Alexander,

On Fri, Oct 10, 2025 at 8:59=E2=80=AFAM Alexander Bulekov <alxndr@bu.edu> w=
rote:
>
> On 251008 1919, Navid Emamdoost wrote:
> > The qpci_iomap() function fails with a fatal g_assert(addr) if it
> > probes a PCI BAR that has a size of zero. This is expected behavior
> > for certain devices, like the Q35 PCI Host Bridge, which have valid but
> > unimplemented BARs.
> > This assertion blocks the creation of fuzz targets for complex machine
> > types that include these devices.
> > Make the check conditional on !CONFIG_FUZZ. In fuzzing builds, a
> > zero-sized BAR is now handled gracefully by returning an empty BAR
> > struct, allowing fuzzing to proceed. The original assertion is kept for
> > all other builds to maintain strict checking for qtest and production
> > environments.
>
> Is there a way to determine whether a BAR is unimplememnted from the
> PCIDev in generic_fuzz.c:pci_enum so that we can skip the call to iomap?
>

Fair point. I don't think we have a reliable way to determine if a BAR
is truly unimplemented from the PCIDevice model without probing it. If
we moved that hardware probe into pci_enum, it would become
inefficient for all the BARs that are implemented, as they would be
probed twice: once in pci_enum just to check, and then again inside
qpci_iomap to do the actual mapping. That's why I think delegating
this check to qpci_iomap is the cleaner approach.

> >
> > Signed-off-by: Navid Emamdoost <navidem@google.com>
> > ---
> >  tests/qtest/libqos/pci.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
> > index a59197b992..df9e2a3993 100644
> > --- a/tests/qtest/libqos/pci.c
> > +++ b/tests/qtest/libqos/pci.c
> > @@ -541,6 +541,22 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uin=
t64_t *sizeptr)
> >          addr &=3D PCI_BASE_ADDRESS_MEM_MASK;
> >      }
> >
> > +#ifdef CONFIG_FUZZ
> > +    /*
> > +     * During fuzzing runs, an unimplemented BAR (addr=3D0) is not a f=
atal
> > +     * error. This occurs when probing devices like the Q35 host bridg=
e. We
> > +     * return gracefully to allow fuzzing to continue. In non-fuzzing =
builds,
> > +     * we retain the original g_assert() to catch unexpected behavior.
> > +     */
> > +    if (!addr) {
> > +        if (sizeptr) {
> > +            *sizeptr =3D 0;
> > +        }
> > +        memset(&bar, 0, sizeof(bar));
> > +        return bar;
> > +    }
> > +#endif
> > +
> >      g_assert(addr); /* Must have *some* size bits */
> >
> >      size =3D 1U << ctz32(addr);
> > --
> > 2.51.0.710.ga91ca5db03-goog
> >
> >



--=20
Thank you,
Navid.

