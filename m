Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DFC5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYIu-0002FM-6K; Thu, 30 Jul 2026 17:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wpYIs-0002EW-Bv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:28:34 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wpYIq-00089X-VW
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:28:34 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-529a1ee0e62so1399091cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 14:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785446911; cv=none;
 d=google.com; s=arc-20260327;
 b=eeTj4/WnA+TfAvdp8rLVVLSAVqEfIGrd4/BZsu2ZHzetcM2zhPQKn0rFSYCCP9zxzV
 sPuqVt1STzUj/dU+WGZGJiMDujPuWhla12PBI/Y2QsUlGgNfJYtfsN4sRbZ1Fv3BwcWt
 Om7YSa8L+HMF7UlAmmxCKPvb87aYdOo92/hXCpLTxrJoQiu5ktgSzF6ZAsx1YZNLHTby
 ytnex4vL12x5/dmXeVQuRLnI20q/UFAmb6ZV38ORU/30/2Nx34BMLNv2LzJ7q7YUjuS4
 P8X2xPDfTYAg/RdZzWEQ1lScKvxF8gQr0ViUSEqR2ZBJv+MQxWmbUiHyZHwxrOrNSJ+I
 EDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8U5244hAigndAEdl7eLC13olLEushepCON12adQSRDs=;
 fh=5c2zzDCO3AarKeAiMGTbVWF3GfaVX9WQmTkvlSIBr/A=;
 b=TsOvnCM4+gBV2ELU+4CmsFT53XqXdw99VN/el03ldXRsve6QWmZ09O1bHtWjJo4lnF
 4w5jWtiTv9LAVoCF1G7U+5K1hFLqi6/WWCpSIslE68FIFkjFoCoEXXPKMBUHHyf2B056
 qNrV1tXoSIWn13kuRFFV3VwwP6K7k/Db+EFrvWBxuNNIyetouz2tIeumPFzNIgm7fsn7
 PvkyB8AAPwKWo59CNwB/vH3Q6i48yMUcPF7Fd8aKFmRqOLGRXtuw3Q5WtUpEqT3WI5nm
 mFVUSZi5OG/seAZ2qiPIm15Ph9oGZaCMAuS/PI6+hsEZOt92CWcEl5YV9DZLm2fhfHgT
 CV0g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785446911; x=1786051711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8U5244hAigndAEdl7eLC13olLEushepCON12adQSRDs=;
 b=fTVZNhHXwxxVLInFy9pmrnAZhq7wmpshXxlweyQS/GkdWraNBClaEkTaiKG421u0oN
 Gf4OMjm77TKF9IZUeT5SJjWUBh1r+Obn71p1rhusksfQPaN2xXYBo45zVcfZ3wQM3mjj
 5CwQocroqEeLcrhgzx7t8mZespV7EQME89nmUf4tGwU7PyJn62londA+BRjrogw45Emr
 9Oqi6KEZo00sI1v9G4yHHJ/nkckyg3r5pG0WJ8pJ7aBzBqA1TKU78yI6UUgTX1JfGYpx
 0ysHGW5KN7ZaEGAMP25X8NoX6AWS7VZPOMGDhJB/cAqAJtNjAbeY7wBW6WT+mfmthuQt
 vRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785446911; x=1786051711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8U5244hAigndAEdl7eLC13olLEushepCON12adQSRDs=;
 b=TDTf7aL+T5skc2cBKjxkKSMcKnQoY+ajBpGZmhihZzmMJqEk/fTckbACUQfSUBzNl/
 yAwAaEPdYpMfxEqiiJbGBfstTKBAN3KkhnTT8dN1RtYR/9xkL0RLSIgqInwMFIP39GnQ
 WzfDjuOduJ1g//GXt8DHjDK8ugF/1tKR6YeMrpmN1S+89w1qROPl60uc8Tut7UNRvGcx
 S0POy3/hZ+DqPHu498RmPrd5+BNt4q1xBVKhaI3d5hptYc2zFU/t3+YySX+sWBMRgTYY
 gj7mWoLh86BCKIpqoTbBfT8+CxgnylhDzD59nhBwd4KS+2lyXDfvMCtOyDa4On63Jxe9
 DvZA==
X-Gm-Message-State: AOJu0Yw5XQ4CUrfLVVSsRyKxPeUR2wrT9HTIOnRN84LOOdi0cCeMkhxT
 P15FytKTiXhP4aSFa3iNuay00YdjGN9aoIhcf8SwNc9sWlEqRa4w/Ovi6fHfj6dIlCBi9nCKeZi
 ogTH1TDrlZXNNy1v1UPa0a1A6Gq36Ln0=
X-Gm-Gg: AR+sD10NLb2vyp9AEoKnbi2ufM3CXA0/rIf370rKSwBZKZ2q53nTGjOSz59cRm14i2B
 RfzTlydnUve2cAQdP2zo6izKhcpTTFkbKMnSv0KQPcqFNJ088bk7OxGln0XyCq6IhcNGSu4QCMr
 uQMTobCywukS4cxmA7kjCHdUZt/BMpUlacqGZe7NNNRnfLaxSYqMqjXoerRCHSYv3PaPtI27vdX
 2cPowWXKc/9fgq2MMAWGNJS1UAHTMgSi9Qte9bDbmBR1zcJPiSzxtZRC2t7p1R0NmloEEHbwA+B
 ya1ea71DODXpQll30G+Rikbc9ZnW7SWbb5nvvSK+H2RDf6GlA4ftVbauHtTPLAOICanFbjr9iQ=
 =
X-Received: by 2002:a05:622a:248b:b0:51c:f3:34e3 with SMTP id
 d75a77b69052e-52b3849c151mr47267131cf.28.1785446911402; Thu, 30 Jul 2026
 14:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-5-6b97c439eb28@gmail.com>
 <20260727190604.GD371693@fedora>
In-Reply-To: <20260727190604.GD371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 30 Jul 2026 14:28:20 -0700
X-Gm-Features: AUfX_mx1j5MBaUGOE6NKwGCPoRQwCG8zc56N5iSyDBsMPzBNCOI9mFAWQ7QJtrA
Message-ID: <CA+spn3rAiRCs3KAL55-qCJVWzUX7p+riyLW2s_dqKmS+tbX4jg@mail.gmail.com>
Subject: Re: [PATCH RFC 05/15] vhost-user: add memory_isolation to
 VhostUserState
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jul 24, 2026 at 4:09=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The signature of the stub for !defined(CONFIG_VHOST_USER) is not
> updated, breaking builds.
>
> Regards,
> Akihiko Odaki

Good catch!  I have fixed this in passt.c, which I believe is the only
location affected.

On Mon, Jul 27, 2026 at 12:06=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Jul 23, 2026 at 03:30:04PM -0700, Connor Kite wrote:
> > @@ -73,12 +74,14 @@ typedef struct VhostUserState {
> >      int memory_slots;
> >      bool supports_config;
> >      bool supports_inflight_migration;
> > +    bool memory_isolation;
> >  } VhostUserState;
> >
> >  /**
> >   * vhost_user_init() - initialise shared vhost_user state
> >   * @user: allocated area for storing shared state
> >   * @chr: the chardev for the vhost socket
> > + * @memory_isolation: disables device access to guest memory
>
> "Device" is confusing because it has several meanings. "vhost-user
> back-end" would be clearer.
>
> "Disables" is also a little confusing because the vhost-user back-end
> still needs to access guest memory somehow. Memory access cannot be
> completely disabled. Something like "restricts vhost-user back-end
> access to guest memory via bounce buffers" could be clearer, but it's up
> to you. We probably don't want to repeat the full explanation in every
> comment about memory isolation, so it's fine to omit the details as long
> as there is user-facing documentation somewhere that explains what the
> feature does.

Perhaps for brevity it might make sense to say "@memory_isolation: restrict
direct access to guest memory from back-end".

