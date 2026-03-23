Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1554F483C6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hx3-0007ps-5U; Mon, 23 Mar 2026 12:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4hwt-0007iN-2J
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:16:16 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4hwq-0001dF-Eb
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:16:14 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7986fb839f5so43475057b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774282569; cv=none;
 d=google.com; s=arc-20240605;
 b=DkwGHBUzbXZHTYbYFH6u8jKBBDtY5JNtAAkE4lQnvk9K7Zj8qA2JWWvxCudouxNOfi
 5Ws1Tq70abwkIReMaEnYpofpJjGYaEm+rHtQ9figI5zbknC4qa5IkWN1iLzr0LcFUMQc
 YRRTwJ2YOnzGDCseSeOHwi7rzN9aKPGmqQ3MhIAb6AwLZzyO8W6mEQIWqXbQmrHAZpdl
 wYc08QiqOqCPWDZS2fRpYqU5QdtGM9u5Cr2ukjDHgrBDrILSB4jEI9oD8+8EOvcl9eA7
 suc7HUukqXvfgF+63T+O+BpFbJJtr1YijjEizkr1NtSVr2Ol+KIJk6bU5UdVfo5pBlN3
 N9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VIYsd1UHMj+DQbBwzdI8c+MElysBCLs4EQd1MM1yzzE=;
 fh=UWl137STQqxEr1K9+5b1WykodOUPgfSuBIvU+QTWstg=;
 b=FZneUSmVZy9AtXTCybnfXPgez9MuStX7JrB+EtFloX+3AALrn5VJ5aa+3j7iLsmWJW
 cIATFVFCekLMBmz8ba6hmmBkjbyHRHtgXFVO078wWVp/r9ifayDwDT7sxe9axgK/+oDt
 pQF4iWdSGmj4QKtOHJHdWIohQJTsGzEWqaBJMWqmWAH2wTWjUV19uGkfL014SxDYwrgf
 Q4AXxf/j+rClxGNGaj2QAMWrX4Hcjg2grwDNor3imJC2JxugIuFGscJKuIjC5TXocCnW
 SPyimujo0RdPzgKDtLxxo2PTl2ZD2Q1y35CJUNRvz5qnuF0gQkd9TjJ1TMdo8WtRtKg3
 AxDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774282569; x=1774887369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIYsd1UHMj+DQbBwzdI8c+MElysBCLs4EQd1MM1yzzE=;
 b=DVTOhlMGOZJD4l/GMyuj9xYrGJmS8Mk913WAU/KCxtSNJMuE3USubs6p30LKgbbexY
 myb1+q7LBMZAuVw8bmHnIWC8RSAEinjzopnmxwN4vK+ErQso4cPwcnIP1H1i9aVGT1Ot
 oZXGttpwtlpblbdduEiJ3CAeuHKNQB7Ztj11nMFqHmxrfHVJ9jn/jw1a5U9aCpSBjfDI
 qePjr007rrqxZLXil9iXOHd9QIHXHIByLnfw4yvBj4lf/kQXr+ZQfktkBawACrnMmtHK
 5+GoxHEjMhQccUXU5jIlS/hOI+nqUZhSsSr7QXuysgkgQmzjo2lL95cdYZW4evxDvQXO
 NeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774282569; x=1774887369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VIYsd1UHMj+DQbBwzdI8c+MElysBCLs4EQd1MM1yzzE=;
 b=VYPDA/5VTuq19NmMQ/IJQvLAZtb6l62FUqsEI+zCbeYYdoDRrw2edknMiqcy0LoNCh
 qMejzgIUmHDOpB9254kfxFo5r/hm4MXBOurLfzX1+mAWW/ALq5oIO92/HUlIXikkC9ch
 Wi9YtnZhbNV+1xyQyUWr23e7P+oZQ6IuAGhUaLaZAShQwGsBVddGZWpITM+pLlvDkwSf
 7WcPUIaQIQtS5wQ98UaGTSvtzsRTMRQIhfmbvkE/ZvLW9iFeYgeW6gkmpPk2NhBXL1bH
 NHcM6rGhJrVsaZEf2Hxmo8Kdd31lnmvNOMu8I8gqqfTp3sS4Jo7za7vHv5slDMPdqb50
 8B/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLFaqvoD+2GWw+lFA248s/i43Inl9gXVSRNH+mm3yaUXyts2eWzRVbiPw704T+8KLDYS7D1RXZxHcD@nongnu.org
X-Gm-Message-State: AOJu0YwzOIuCo4VwEOjYDYVgyDVfYef1sCBcxnMAHsKEqDm2EHZZCxyE
 9hzhRsSawFpDkQNoSDYCvUMqzx+qz3IHdeGCXrV+cJ/uK1jFjR5LaRVIB/Z8bKmivrEUcnVzLiA
 QUJoxb5dE6hI9S7oplKZ2QHp03vnh6mwtsdZ5AYH+0A==
X-Gm-Gg: ATEYQzxNOZIrX8JL0INEdqljjv48ARrQ2Q96ZYocmheRLtDpCyRv0e8rVmZAv3uqsoH
 fNyK5qe1Jt3kE3c1EQezBjxVMHRl7uGLXec7kszL+sot3k2RHmmuGpw1D+8JU79qWuN2dd5A2Rl
 qkm4c0q/GaYPMuLsYF3TSB9SKiNkJS8ILbwOr6SyhcN8vGYJJCri6EwCeqaIK+meCwWZVTklQnP
 yZ17Uwj7zd275I7iFXDHvUKO5aaB2SCEr70ipCPM2Kwfo2n9iayfLQhomXxfsPyhT8QK4+FL7nH
 X1LIHeetwdpw4DNNEKU5pw6hmyBjLlidqHnK4RXYneWBUguibsfSG/LT3BgpaHwZuPQ=
X-Received: by 2002:a05:690c:3482:b0:79a:b193:8938 with SMTP id
 00721157ae682-79ab1938effmr51724157b3.13.1774282568242; Mon, 23 Mar 2026
 09:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
 <20260323095706-mutt-send-email-mst@kernel.org> <acFUnqeSF2RMDiIe@redhat.com>
 <CAFEAcA_QV3k9bbayQh76-ASdHiJeWNSGY32DeDZJ0UrrC-WXLg@mail.gmail.com>
 <acFjLhpXlo2fv9Z6@redhat.com>
In-Reply-To: <acFjLhpXlo2fv9Z6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 16:15:56 +0000
X-Gm-Features: AaiRm50aACR4r2RwnsQWTDh2RAp_NouKK5tG5rUdzRTxXNjf81c3ag-rqlJMAZA
Message-ID: <CAFEAcA-kuHOhsYEBUi3ty8eaK86+nE7jKHp=cXCungO6S0NE=w@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 23 Mar 2026 at 15:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 23, 2026 at 03:25:10PM +0000, Peter Maydell wrote:
> > On Mon, 23 Mar 2026 at 14:56, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Mon, Mar 23, 2026 at 09:57:24AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> > > > > On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > > > > > > virtio_net_handle_rss() enforces that indirections_len is a n=
on-zero
> > > > > > > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > > > > > > virtio_net_rss_post_load() applies none of these checks to va=
lues
> > > > > > > restored from the migration stream.
> > > > > > >
> > > > > > > A crafted migration stream can set indirections_len to 0.  Ev=
en if it
> > > > > >
> > > > > > The migration stream originating from the source QEMU is truste=
d.
> > > > >
> > > > > Is it? In https://www.qemu.org/docs/master/system/security.html w=
e say:
> > > > >
> > > > > # The following entities are untrusted, meaning that they may be =
buggy
> > > > > # or malicious:
> > > > >
> > > > > #  * Guest
> > > > > #  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> > > > > #  * Network protocols (e.g. NBD, live migration)
> > > > > #  * User-supplied files (e.g. disk images, kernels, device trees=
)
> > > > > #  * Passthrough devices (e.g. PCI, USB)
> > > > >
> > > > > which explicitly lists "live migration" as an untrusted entity.
> > > > >
> > > > > I would definitely be extremely cautious about having a threat
> > > > > model where I had to distrust inbound migration data, but the
> > > > > above does suggest we aim to handle that, and we have I think
> > > > > in the past taken patches which add sanity-checking to the
> > > > > migration data.
> > > >
> > > > And we even assigned a low priority CVEs to these.
> > >
> > > Do you have an example of that ?
> >
> > Here's one from last year:
> > https://access.redhat.com/security/cve/cve-2025-54566
>
> I think this one is valid, because it involves incorrect handling
> of settings that are controlled by the guest OS. There's no
> external party claimed to be modifying the migration stream IIUC

I think the "guest OS sets things wrongly" is CVE-2025-54567,
and 54566 is specifically for the "migration stream is malicious"
case. The commit fixing them:
https://gitlab.com/qemu-project/qemu/-/commit/cad9aa6fbdccd95e56e10cfa57c35=
4a20a333717
fixes both at the same time, by providing a validation function
and calling it both (a) when the guest OS writes the settings
and (b) in post_load. If we trust migration data then we don't need
to validate it in post-load, we could just say "make sure your
source QEMU has the fix for (a) and that you've restarted the guest".

> > I vaguely recall we had a set of them some years ago too
> > (probably somebody specifically looking for flaws in the
> > category). https://access.redhat.com/security/cve/cve-2013-4536
> > might be an example of that.
>
> I think this one is probably issued in error.
>
> If we're considering that the migration data stream is modifiable
> by an attacker, the implication is that the attacker has arbitrary
> read and write over the entire of guest RAM. That in turn implies
> no guest OS can ever be trusted after a migration has been performed,

> That is certainly not the case though.

Trusted by whom? If I'm a cloud vendor then I don't trust the
guest OS in the first place. QEMU itself should consider everything
in guest RAM untrusted data, because it's guest-controlled.
You can probably have setups where the user who owns the VM might
be able to modify the migration stream but no third party can
(e.g. if you give them the ability to vmsave/vmload to a file
that they own), in the same way you can give the VM owner the
ability to directly write to the disk images the VM is using
without that being a way for them to escape to the host.

> I don't accept scope for CVEs in QEMU for an external attacker modifying
> the migration data stream or saved state file contents though. AFAICS,
> such possibilities imply gross misconfiguration of QEMU by the mgmt app,
> and should be CVEs in the mgmt app instead.

I agree that you have a pretty weird threat/operating model if
you allow the migration-stream to be considered untrusted, because
it's reasonable and sensible to secure it. But I have a vague
recollection that this language is in the doc precisely because
at least one person/party has argued in the past in favour of
treating the migration stream as on the security boundary. I don't
object to our deciding we want to call the migration-stream trusted --
but I do think this is a policy change from our current stance.

Paolo, Stefan, do you happen to remember anything about this ?

thanks
-- PMM

