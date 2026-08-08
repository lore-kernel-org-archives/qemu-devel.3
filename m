Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A38C55174
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2026 05:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsZzI-00055p-HU; Sat, 08 Aug 2026 01:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsZzE-00055W-JO
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 01:52:49 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsZzC-0005cb-E3
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 01:52:47 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51a868b6962so2868321cf.2
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 22:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786168365; cv=none;
 d=google.com; s=arc-20260327;
 b=let4RZJOcynHLOxxU+ssrxtnLNzw6USm3w9P5qxzpduQrmZszAEQOXik1wv8fan3oz
 LIPImM4ihk2pVwWOJy5gMUpBwhfpuH2JIKHtaKxG72f27okhrmqe4CDzXsiItGm5V5B+
 nAS+afEVvxC+XuLNeHEg9MVEX5HoDzEe16tAUK5HkL4RL39CZVu/ygi9chtTBZw6StaA
 nMUtLvrgpEC7NRe6DaTKBHCus+dwfvGrATdetZg1Hv0HmYJjCdwneN1Jri9hQBFrEK2R
 aXGn3Kz3Y0dpghyVlht5k7w9yYn8OUfmSzxk7vz4maRn72aZQNzMsnRBPx+28LDMZSEW
 ZqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f73IJPUp6q0Wp68Ac+cralPtDGHihzN4LDNZXFWNQE4=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=lBuVICOCvkSxeqlVdP+NjyMsNy4kvdnMfviz9xn/opd8rTyra26gsEXXmSqTKPbMje
 vA1u8fJ6vp8UTpiL05TKXwTWxpLotHhlUYbb5qu7iqJ3PlnAfHmDj+woiKiOlOek397/
 Pmyrog+gq/+YW7eiO5O5rKJIMo6iQvXd5lbByfKwfBh+xYh28zOlpmDrPMcuhIjUK2SJ
 /fMNWKD6BEGxqlRkqYmkpIxUJHoaOoYlr6Sw1+2UJ7Egtph4CfjIBHc+KhGmyKFs0h5e
 K+cwn9QNq57c6G9/t8P0vyY394K1LMRzSMjsVPLtbE6ulLbeYahvYBle7z+7jdd9GCuy
 dfkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786168365; x=1786773165; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f73IJPUp6q0Wp68Ac+cralPtDGHihzN4LDNZXFWNQE4=;
 b=jmB0PG5Y2v0DGFir1t3ZVl4z47Y0Kyx+DXT0lFM9uFPDJOSpjvKwbxeiNxGbjvxqEd
 OQYS57cDkOobvXBrEoxcN8NbtSJhGarIet9kAYP6qXpbPbCIBigiC/NhK1Oqf0uBVTfC
 4AKW+WOUl8JLzQuK5BwQELAoa6kmsVPZ+WdCuRQwFwPecZz9HtYIDSVArEwMAnk0tHev
 WRxgLu7xazlelT6moKjoON3EYoReNZIGTZHthuczz3tUYk3G94d7Ub35xsuIejvjkrXr
 3FcoQV7E80sNyg9j7jSg+4tpeK7lSKXY/pC528w6L22lQnBj4ayBNko+AAJQfQyAshQ4
 czFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786168365; x=1786773165;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f73IJPUp6q0Wp68Ac+cralPtDGHihzN4LDNZXFWNQE4=;
 b=dnVr0Pfa2AXS1ziUC2Grqin59hWlabjFGXiM8MLbeSMkpzw2HJnIuZvL9CIEjzdvdC
 T/SsO2tKTZXzlgJPzxpAAZBosxS4KvkkYWBUEkIrQMx+A4CTTaxOz3KwhGUgE8egH4W8
 c9EPX4XJWCtNgjb6M928urn0JjWbYW+5FDdBHtKaGvURashV2fZdzyAHzZq3l2aoNCdy
 FL1GEM2wfsdkg6HLZu0Vari4YQSjy8GHLF8zEWLAyjJxjbp5C5KbolUkksYonda0gcyf
 7JCgt/GmvejCPCC1phWJ7m9jWN1GLVIN4UXtLqVoscHoAi4Xv+uSvRDISlojgJYqPTnU
 edGQ==
X-Gm-Message-State: AOJu0YwcS2RfW8rr4JctIdU3Fpthh9OGIwpOthu8eYPyEWeBwo4HxssR
 P+fcigdAfAl0lheAkRs+Rs6oLR2btx14n5gOEPKoa1ZcueWT1/BM3tnZXVCEbTyja3CZcTl8UgQ
 Wff4bABumeWY+KVCh7OkWqdyX3Sg58Lw=
X-Gm-Gg: AR+sD123yO8585zgjYHlgCTtuQUYIWRzq4lTb6DRNHRvd9YklAnv8cVVmjcDC1MJXpG
 IMquU3r8ANMtYkJVApDZ1s1bdatnIWsCTt3J2cRvej/HV6bEV/fTmBpchUA8YbaNGNKc5xzqRoZ
 iGakO+kq/9YJRhEK+DdUbANk6nYsu0tMym+EFvS7a5unr2DVcDrApqMLOCUNV9ngtSuTMK6QcYc
 5pzJ+Iyx9WRDNPeaxloRUyWKYcGO5Rg8YrRwBVbNCE+4N6U1CFUton2K8NuT9/nn4T3yBA7xtNc
 cAJZBSoLeFeersATXAYDP/uv4DrEgo99VrUeXoNoKnkWPkey4zf1D40rLJ+8DN6fUcGX1WGb5NZ
 KXlU=
X-Received: by 2002:ac8:7c4f:0:b0:51c:1132:c7f7 with SMTP id
 d75a77b69052e-52d20a3212bmr73283081cf.29.1786168364959; Fri, 07 Aug 2026
 22:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
 <ba6158dd-7b7b-4457-9256-497ab60a27d3@redhat.com>
In-Reply-To: <ba6158dd-7b7b-4457-9256-497ab60a27d3@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Fri, 7 Aug 2026 22:52:33 -0700
X-Gm-Features: AUfX_mz29_PGUItMUHiK2fhIF6i4er8uxAWBlXK1AVB5x0b6YqHJWCDPmzom6BY
Message-ID: <CA+spn3qP1xahLRTNutmOLvDEXJXHh9W1tMeGeKiiDiz-ntyknw@mail.gmail.com>
Subject: Re: [PATCH RFC 10/15] hw/virtio/vhost-shadow-virtqueue: range
 boundary in translation
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 3, 2026 at 5:56=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
>
> It=E2=80=99s not immediately obvious what is ensuring that `iov_len` can =
never
> be 0. Sure, it would be wrong and makes no sense, but that is why I
> think an `assert(iovec[i].iov_len > 0)` would be appropriate.
>
> (Looks like `virtqueue_map_desc()` is what rejects zero length, but that
> is not really local to this code path, so not immediately obvious.)
>
> Hanna
>

From the QEMU Coding Style guidelines on error-handling it looks like
errors that
could be initiated by a malfunctioning guest should not cause Qemu to
exit. Would it be
more appropriate to return false when zero-length is detected?  That follow=
s
the existing error path returning up to vhost_handle_guest_kick, which
renders the svq
unresponsive to future kicks.

Best,
Connor

