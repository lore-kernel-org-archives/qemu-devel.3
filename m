Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27431C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsQZZ-0003IM-Nk; Fri, 07 Aug 2026 15:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsQZW-0003Hj-4S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 15:49:38 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsQZU-0004Ns-PQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 15:49:37 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-51c15bf5000so18398941cf.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 12:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786132175; cv=none;
 d=google.com; s=arc-20260327;
 b=kQP0vFk8zA0LYqzeSDxFXfTkY5C0+SteXcxdbhayuLheOHWVNbgu2sXe04YEUmbv7Y
 72ZbUwWnLxyUMqKwGqKVEuNuYH9zPBwXxIAsjy1JI4dIm4TqdD9uaokPfnpbdgu+ti0m
 6EBxsxfy8wTItzZYjwI4hLwvYH6Xz8SZQHMbwPOyoNzJ1QjmwlyL6Pk7nG5KTr14BJHZ
 2v1D5qdFbM3+mIaivzF2txjqHUhQjJh13SPGVjat3+r82XOefAWWQggnjimzQh7MPhZr
 7NDeE05f6JzJGhUYqYCouqlu2EaAodObmpJhanJv44jHcml4V8jEbyaxDmZbVJj9LKab
 AbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qPlPrCC1wjDsIRLQ7uPOI/YmPR1YtWDgu2qpSGiMWkk=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=QLhTMnmdByHi7XgyX3GrCSv0AomKedG9Yda+T47sMbSbAh8pBiXrqRtmGHgyeuiRLz
 9l0mEmbw+hQXIb/o2b86Eukv/zi5G3sTpS/6Ic3EYMgAF+kpcEYfnhrkD+fcpm1AQ88W
 KmU4icxi/R6bduPn+un90jHUZQ9e23+C1r5meaXAWSh5r1+bEe/HsmKL7bq0IIxCWMF3
 g+lV4okJdkANhCEYh6NHzDn04mQrlZ5KASt7F7+b6cYzdm0XWMJVgOFnfUYi29ex1QCZ
 RRUnypuO+lya3jgpjn4nLWlbK4O3/G3uqE7MfMIiqLKBskWoHINXTzbvl+rlEROjhZkX
 tE9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786132175; x=1786736975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qPlPrCC1wjDsIRLQ7uPOI/YmPR1YtWDgu2qpSGiMWkk=;
 b=gUmwuYGmlRY6Z1T0VAU6PvkKjUpyRcr2oGHYkPB++k7tjrHkUB1RriFTWyIKpCtXlY
 HbJa46pWy5oNhIN6N+itFdlADLTacZPJ6BEWcocPIHKylDIqMHlahL0GkrKGjZRzT+tx
 a1U357ViYRPQU5kqQpBm7sByLH2hArQp7ZGnhb9Tqz7rS7QzsFzhLlN4WoNsqYb4Ha9Y
 cTj/vC0hwXZb4BGn1BOMPIc/PeB6bxSVVsvZkDt7EWlHbOTTrK1Zzt4Q2T1lOqORNt2p
 gW9EoVrQYyVnoPJWd3k3PnQmouoYQfW1Cyg9rVbExGuaKFtjTb0yHTfCs7aEwVXQMOZA
 sQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786132175; x=1786736975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qPlPrCC1wjDsIRLQ7uPOI/YmPR1YtWDgu2qpSGiMWkk=;
 b=JPJg7WadJQwioLkd/GBFckyvtkg5HnLSdjj5KivQ/Eu/E/pFuiAHu7xe5Zm7UTaHnt
 tX5ckc/OTFYcn7DZTNTlJAVg3xbFLtL23maZ6gzxa95N72qNh32aLI9KDd4emzolaGrN
 dYYHr+qp4+/DciS8P4bjdaZuw0ofcHf6G9yi1R8yhbOgaVb4fOuZwpFNWqblM/SRTYwV
 3hTFRqTRdyB1mwduY/05FZGI3fx2Ge8jN+gOc5kOedeaz867Mj38kkQcmG/ry7grX2Gb
 v92U2e3KpCSB9gKtSJfBbLw1G+eVYe0H0e6Uwb3aj6HvLHCxzPnfWpnH9MCFtDk4mk1z
 5/gA==
X-Gm-Message-State: AOJu0YzA9gg9GgupwBdcJA0rOD5m3AQmgxm3ya2cDwsdSTkaqjp/NK/k
 ywFSzT3SaHJygogp+3KjzYp+TATAWyxFOk2EJMe50ARH6sTRlrPoxBqUMgqA8y4CO6DfDj8ITOi
 BeBn03cMwlpEabZYZAXC5gL0aAqRurlo=
X-Gm-Gg: AR+sD10J5GVQNEw4baIybUJQqwMGEQquv4t6M/B9vrNUbwe0eIrxCxHAc/uyInXp+6y
 4pZr6vwwW3ZT2XDI8qjWI1KIOlcj6uGCvDp3D966+9Uvsk4Q+rDEWyQeVC98gh7JNbdQ82VrlHs
 zOrnqv8N38ZfxXp+nyeocDxK7eA26JdISKUu6nAkZg1vZUF2oHH9xY+KGbk7dpPUu0SYLLN/r43
 SVDDNtbtvacSeLazylJk3oWsHPnN3DCMcByq+ips4bZaMsoItwZcoZV4WmiviIu6R+cyAGgYAHp
 hIfv3nzTg/OXjHxbdJqLSosfRwBN4aUFVjJawAvfEqC+JQYk43cSB3qjKC84rxDiwWQNOHmh2cU
 1/a0=
X-Received: by 2002:a05:622a:5a1a:b0:51c:10e8:ac7 with SMTP id
 d75a77b69052e-52ce61a0400mr300087051cf.37.1786132174439; Fri, 07 Aug 2026
 12:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
 <20260728152308.GG371693@fedora>
In-Reply-To: <20260728152308.GG371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Fri, 7 Aug 2026 12:49:22 -0700
X-Gm-Features: AUfX_myXIEW3N1umee2ouDa9Cd7EMwKxvm6eLMFkeRcSylIW_CGpv9yHarg5uLU
Message-ID: <CA+spn3q=EZR1bx3tw-hnk=Hhqk1fNXmpqUoQwMv9km_hhcr3_Q@mail.gmail.com>
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82b.google.com
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

On Tue, Jul 28, 2026 at 8:23=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Why is base_addr a hwaddr? This is QEMU memory, not guest RAM. I
> expected this to be void *.
>

It doesn't need to be hwaddr.  I will change it to void *

> A size needs to be at least documented here to reduce the chance of
> memory bugs. Even better would be an interface like
> vhost_svq_vring_total_size() so the caller can fetch the number of bytes
> before allocating the memory.

I haved added in a vhost_svq_vring_total_size function to address this now.

Best,
Connor

