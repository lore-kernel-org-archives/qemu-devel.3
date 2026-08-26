Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42319C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDJI-0001r0-NB; Wed, 26 Aug 2026 09:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDJE-0001jq-SS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzDJ9-0000GH-5E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787749486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
 b=i+0qPnV+2ySestF3H3Lwti26st1iDHKX7qDMeQeZ5Z/x2HXCjdvxOP4X0il9Blhe89AIFF
 NUhlyC+rcANqnhXYF8zL9VJevFaaTDva9EdfqaTW66WvAuc9PC2NHqbn9HlD2uhq3u3HUp
 xmMlxDWrOqLAGBEwX6DUi8IduVJTkZ0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-04J9jeTLNpeGyYLpo0wraA-1; Wed, 26 Aug 2026 09:04:45 -0400
X-MC-Unique: 04J9jeTLNpeGyYLpo0wraA-1
X-Mimecast-MFC-AGG-ID: 04J9jeTLNpeGyYLpo0wraA_1787749483
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388cfc4848dso1103858a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787749483; cv=none;
 d=google.com; s=arc-20260327;
 b=P9WMQTR9cJk90GNjLpOP8gJ2XpCiXHdzA1gTIZEPjRWHGWBTl+QJA4E0LHhBARSwKI
 utgSStvnlF1a3Lf9fI5NF17lu1JSx/txpMRz+wjHFCFQl1BoYM+p9C497X7o5Ga+n6oZ
 k1SepBe4yvVCwEjzb0PM1Yo3uRaADhzowTi4YIOh9AqWcxpE1Lj/uJy/kgjYZsIzzXe7
 Fdds7xkQDbkl36Smo/+NXdcEcQxoCt+YmmS75i7vKPiEeq9kjaQVmhonC475wXl1owfP
 DSRrQXBbGGlRDKuUxC2Yiwovoo3VB3jAvDp280iuJroQgQYouQMIYvjNboCxzTTJKIqi
 75WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
 fh=8Wo7/+QCM+mmxGBCH8dn+sX4s+CZ4s5NapnPAl8coEY=;
 b=iKnmuJyk2I1qsfWotQmz5rpJWu7DlFNKaEihDKnCe0fxw37oVEl4UcDtcfC/2GccuH
 ZEMjwqQVemqHNorQmq9uaZzgWWlniyNXEm/6gVPPTapXz0SGFZJVhDTE6+mou6mXpfNI
 IaonPmFCK4p476/Fmouvt+vDsIR61IKPVRVhqAoB6PFSmYnN9QlzQNmn6J7WvoDeQBSw
 hDg3Jppm3G2BgIQyRpEsoIrBgh3kb37P+hok9GsODcBKSkKgB6QdsDKksh1u/uS2rsHu
 nrwW0t+WmJyHULo48sNwev1qzOPbA9xJ8vftoDmSgIkEjmiEqc+M02NSqJzwfxFn6Y+6
 6kBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787749483; x=1788354283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
 b=WLpkUX465GQCGuhj93hbuCxlxHpQ/yII8Puzh7fj/VWRq/z34lH83YA//eK091YDBy
 gPai7oBMkiivDmUbwagQu8UVRVcXoQaT2ygkXWWWMDf59uY1qYqtRUOF8J+I+5Oj1oc7
 /iGTsB/dAfU6xyGiy/02zvqSs8hLBNrqGfwJo6R7bcgYW2HDuB1GLUBQteyk4rn8JRQP
 Yf29775IJMjV4nHAMUGznKVkGb73YdlZ9Mk9MGhwhQiT95q4hA4JJAcqzorlowJsULLh
 Z2A9VtRQwWD5cvmn/WyaLMK3H9mqs4OIjegqMYfLKC67T33ZGTeFceaLxu8JDWW7P8Zz
 hgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749483; x=1788354283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
 b=Jmfd17H9s7xjH3iRlcfSIxGI3LgzfaZUaxkqwy4xJB+tfUrU5ZwNfNL/VCjzEZVB8B
 qA74xr0IN2Gt8CtEdO5dK+1VT1fef9IogqFv7QuAX8r1iAzv8n1RDFcW07RwO1wfgEgi
 jJZNcRXajJSJO4kxJUv6Rh4rBpm6vlPCMKR4cKg40jOJpcFogAjCCb+8rO0kiTwI7Y8k
 C+HN1TxZ4GzOOTzqYiIUQdaWugunWWCL7SV5cDdMhHuExVh9Xigo22jbakKxto8Cjz9c
 BChc3ly/2vvPZsX/71McIOpttqvsBdfeF9WRR36pmZdq59gWyJ3Z1GEITPUnLQvaxUep
 dSBQ==
X-Gm-Message-State: AFuF++mHFlGS4su/Y3+LsuqHNfLUzWwnJBV7cd0IylxAAYJHqD7V7XNp
 RpDPakbmX0he9CTUGAyrXBxXa5TgE2hLR2qi9Pb+VHV9AeQMl/QDEbh2mWXmVMS746PCgLBMbmW
 nlq5zLCqunWPlYKNOlbvBXUDFl8yWxQMhqcnmfPFJKm6KL13hgKzWz4WDzMiiPWYVAaMtznPfEo
 lOiQHoI5WtdqVbDCBX5y6MDedWzeeE7rQ=
X-Gm-Gg: AR+sD11/fka9xvau83LhKzVzU+8SZCdRdMkoxmFpXq7giCJn48n8AZmJmpUEiekJfen
 oA2eTb35tZ6+ASYuFPIriM2Vf9rCMAZcvNR0Neeq4FdpTFquecJm30vpzrw6WOsIf963DI+IrYN
 a/fPgmZ0JMpyvGKo+x1FZOuWhNXn9k9tGVkKtVs5MutIWXnx7PT3FmJyRR3CX8EihDq7ICPUNsB
 F+HFiUG3/xKo+5KVnFVI4sJh/ildYEcx+zjla9+6HaJwKYV9cSrEnDgRgqlqFz6MJm8Ua7QGRQ1
 Bg==
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr14606895a91.15.1787749482476; 
 Wed, 26 Aug 2026 06:04:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr14606542a91.15.1787749481523; Wed, 26 Aug 2026
 06:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
 <ao6pyiBkHZJz_9JR@redhat.com>
 <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com>
 <ao65_XCKmkpm9s2F@redhat.com>
In-Reply-To: <ao65_XCKmkpm9s2F@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 17:04:29 +0400
X-Gm-Features: AcwNN1UokCmDa7kHDxB9ZTq3xrLUmyLSJ7h0c4jfatvRCC3sSrStOXkF7y4zowA
Message-ID: <CAMxuvayGzQtu1COC5G1D+CKZuXmhCeDV5fZMvYtiK95eMh+i3A@mail.gmail.com>
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Richard Henderson <richard.henderson@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 kvm@vger.kernel.org, 
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On Wed, Aug 26, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Aug 26, 2026 at 01:41:55PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Aug 26, 2026 at 12:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 11:09:43PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> > > > monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changi=
ng
> > > > the first parameter from Monitor * to MonitorHMP * to enforce type
> > > > safety. The implementation is also simplified: monitor_hmp_vprintf =
now
> > > > directly calls g_strdup_vprintf + monitor_puts, removing the virtua=
l
> > > > dispatch via moncls->vprintf.
> > > >
> > > > The dev_print() callbacks are temporarily using the MONITOR_HMP(mon=
)
> > > > cast, they are fixed in the following commits.
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  audio/audio-hmp-cmds.c                  |   6 +-
> > > >  backends/cryptodev-hmp-cmds.c           |   9 +-
> > > >  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
> > > >  chardev/char-hmp-cmds.c                 |  12 +-
> > > >  disas/disas-mon.c                       |  10 +-
> > > >  docs/devel/style.rst                    |   2 +-
> > > >  docs/devel/writing-monitor-commands.rst |   8 +-
> > > >  dump/dump-hmp-cmds.c                    |   5 +-
> > > >  hw/char/virtio-serial-bus.c             |  10 +-
> > > >  hw/core/machine-hmp-cmds.c              | 213 +++++++++++---------=
--
> > > >  hw/core/sysbus.c                        |   5 +-
> > > >  hw/hexagon/hexagon_tlb.c                |  44 ++---
> > > >  hw/i386/kvm/xen-stubs.c                 |   6 +-
> > > >  hw/i386/kvm/xen_evtchn.c                |  21 +--
> > > >  hw/i386/sgx-hmp-stub.c                  |   3 +-
> > > >  hw/i386/sgx.c                           |  29 ++-
> > > >  hw/misc/auxbus.c                        |   9 +-
> > > >  hw/misc/mos6522-stub.c                  |   3 +-
> > > >  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
> > > >  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
> > > >  hw/pci/pci-stub.c                       |   3 +-
> > > >  hw/s390x/s390-skeys.c                   |   9 +-
> > > >  hw/s390x/s390-stattrib.c                |  20 +--
> > > >  hw/uefi/ovmf-log.c                      |   5 +-
> > > >  hw/usb/bus.c                            |  11 +-
> > > >  hw/usb/host-libusb.c                    |  21 ++-
> > > >  hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++----=
-----------
> > > >  hw/xen/xen-bus.c                        |   5 +-
> > > >  include/disas/disas.h                   |   4 +-
> > > >  include/monitor/hmp.h                   |  12 +-
> > > >  migration/dirtyrate.c                   |  46 +++--
> > > >  migration/migration-hmp-cmds.c          | 301 ++++++++++++++++----=
------------
> > > >  monitor/hmp-cmds.c                      | 141 +++++++--------
> > > >  monitor/hmp.c                           | 143 +++++++--------
> > > >  monitor/monitor-internal.h              |   6 -
> > > >  monitor/monitor.c                       |  33 ++--
> > > >  net/net-hmp-cmds.c                      |  31 ++--
> > > >  net/slirp.c                             |  31 ++--
> > > >  qom/qom-hmp-cmds.c                      |  27 ++-
> > > >  replay/replay-debugging.c               |   5 +-
> > > >  stats/stats-hmp-cmds.c                  |  57 +++---
> > > >  stubs/hmp-cmd-info_sev.c                |   3 +-
> > > >  stubs/monitor-core.c                    |   2 +-
> > > >  system/dirtylimit-hmp-cmds.c            |  10 +-
> > > >  system/qdev-monitor.c                   |  19 +-
> > > >  system/runstate-hmp-cmds.c              |  16 +-
> > > >  system/tpm-hmp-cmds.c                   |  29 ++-
> > > >  target/i386/cpu-apic.c                  |   3 +-
> > > >  target/i386/monitor.c                   | 152 ++++++++--------
> > > >  target/i386/sev.c                       |  35 ++--
> > > >  target/m68k/monitor.c                   |   3 +-
> > > >  target/ppc/monitor.c                    |   3 +-
> > > >  target/riscv/monitor.c                  |  55 +++---
> > > >  target/sh4/monitor.c                    |  29 ++-
> > > >  target/sparc/monitor.c                  |   3 +-
> > > >  target/xtensa/monitor.c                 |   3 +-
> > > >  tests/unit/test-util-sockets.c          |   2 +-
> > > >  tools/qemu-vnc/clipboard.c              |   4 +-
> > > >  tools/qemu-vnc/stubs.c                  |   2 +-
> > > >  trace/trace-hmp-cmds.c                  |  12 +-
> > > >  ui/ui-hmp-cmds.c                        | 115 ++++++------
> > > >  util/error-report.c                     |   2 +-
> > > >  util/qemu-print.c                       |  11 +-
> > > >  63 files changed, 1219 insertions(+), 1327 deletions(-)
> > >
> > >
> > >
> > >
> > > > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > > > index 5d4143d425a1..5938f2b6c338 100644
> > > > --- a/util/qemu-print.c
> > > > +++ b/util/qemu-print.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include "qemu/osdep.h"
> > > >  #include "monitor/monitor.h"
> > > >  #include "monitor/hmp.h"
> > > > +#include "qom/object.h"
> > > >  #include "qemu/qemu-print.h"
> > > >
> > > >  /*
> > > > @@ -23,8 +24,13 @@
> > > >  int qemu_vprintf(const char *fmt, va_list ap)
> > > >  {
> > > >      Monitor *cur_mon =3D monitor_cur();
> > > > +
> > > > +    /* for all monitors: QMP & HMP */
> > > >      if (cur_mon) {
> > > > -        return monitor_vprintf(cur_mon, fmt, ap);
> > > > +        /* don't use monitor_cur_hmp(), to avoid a second lookup *=
/
> > > > +        MonitorHMP *hmp =3D (MonitorHMP *)
> > > > +            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP)=
;
> > > > +        return monitor_hmp_vprintf(hmp, fmt, ap);
> > >
> > > This isn't the same semantics AFAICT.
> > >
> > > Original code, if monitor_cur() =3D=3D QMP, we call monitor_vprintf()
> > > which will return -1.
> > >
> > > New code, if monitor_cur() =3D=3D QMP, we will get a NULL back from
> > > object_dynamic_cast which we then pass into monitor_hmp_vprintf
> > > which will then crash on monitor_puts() IIUC.
> >
> > monitor_hmp_vprintf() has an early return, if given NULL monitor, it re=
turns -1.
>
> Hmm, I feel like we should be dealing with NULL in this method, as it
> is surprising to be calling a monitor_hmp_XXX method in scenario where
> QMP is a (theoretical) possibility.

"hmp" would be NULL in that case, but I agree it's a bit confusing.

I would go as far and make hmp required for the call, but I can't
review all the code paths to monitor_hmp_(v)printf()
I'll add an early return in qemu-print.c

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


