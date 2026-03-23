Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EDF4611B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fjP-0003YP-Px; Mon, 23 Mar 2026 09:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fjO-0003XS-AU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:54:10 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4fjL-00069u-18
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:54:10 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79a535e7c00so19480607b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 06:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774274046; cv=none;
 d=google.com; s=arc-20240605;
 b=I5D0Kd0/VAAW1tP02Pn08nsIYi38gJi2WASM81MRJozlu/x0D5xMUTixFhdDfhnkOc
 hWoMdR5lOkDOAf7QmWhlRyiwVgZUwW7EtbjmVyUwSO5ZJQtqSJ6fJf0pMgzK8Zl1TsVq
 AvVZ5XP5N/5eehgJdEKM5Tm2xiY8iMwUPZh+THSM65eFxdxf80nXwkahxvRBNXzN2j3e
 zfKDzUQjsjVze5JNBviZVRKmMlnduzEJ1n4/cMaiu6MNA91FAbGlFo0V609qShqfuvbK
 6hohjVFTMyZkteAO/cahsuzMjgge7aRhZinAGFU6/d46/IqLZKgBc8uqhXNPNj/GnYKn
 AJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BvvvyMb4roAGhWs9kCeRW7PnBYD2B1ap9bxk2IMNFFs=;
 fh=6tjkLqsPCH+lXmxS40SIQCAggQNvaMd05f9FWKEZo0E=;
 b=WWISljxl0peXHom3MFnZUoqbwZRqGSKV9tlANUS5UIfoOespJND3RF6kd3QL5vlFXz
 NJHKgoaRt5k6zCv0Ofe2xQcV6AqHU0IkcbvcuqvSPQop5TXVLDc2Q2KbqBS3y8e51+YP
 QJNlef6y9okYNFJRUVv6wq9KWW+Niv38gNGkH34R+wVcvNSA0G/tyRb1yW2yEifw0Ux9
 e5xQuh76IObe5KG25pv4jXkbjOlt2tt4r2A4CI0fI2qjosSTME66aI5CcTj2TwIwFrEw
 gTz81oqmByfLrZVLka24gn+ePjSTb/YJRSB5yLeV6skAtewph9r9dinP/azwPY8bWbQj
 crhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774274046; x=1774878846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvvvyMb4roAGhWs9kCeRW7PnBYD2B1ap9bxk2IMNFFs=;
 b=IQQi8ZA30sGZP5aZDRvOtH44nOKprpI8HW3CmNa2gjHsRrx8It1uxxPggq+aP5Jfvx
 cBqQ2ZWf0OSZLQO1fGpUo8BqTu75+YFiLwyWpN5YLA6rxQVoqXtV6M1n9NaPEkCZ65np
 DEpMARJKZkbVv04eydbrU9KDnwEzAl4jBJyds0V43eonp+GPXlh/tXDhB4HPTJfCpPiU
 SZmK8JnOv1nyXgmq4enT+kBfrHHEiAnOqI0JYW3DVPmpaxLr8NLT9ootxUuz5Cu3JrAV
 CVjvBGWQC5eV7jJEtiJ6fZmAfh4VlbuQBxzwc6Gv5Em97Qy2XsI8mC2WZyAFurk/pyBk
 b/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274046; x=1774878846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BvvvyMb4roAGhWs9kCeRW7PnBYD2B1ap9bxk2IMNFFs=;
 b=jlKcvxL7MwukPZZiiBmqpMIOiqqHaO6yfh0yArVRRTsK5Q1tCq1OQDmyJhPLghxQE1
 F1Mr62v5xCDOYdfpmP09Go3T4MzROxHi1iFIULzJmCLTxKGUB9kd+gHE7ZQSfxAo0JNd
 SeAvx+YpmsNhY2ELqtNmg4ZeKX6FCPMq1ynagCPsGVqWs/6n5OfM1fY5g5Kdp4etYmRr
 klXaQGFNr8ULWMjVhVz0PGOUfXU35GA+4/Zh8mlJi6NQR53ACDKWJhHQjfeLxupBEeF2
 WTcMkedAkEHyDyt6W9HaRLddIYtAsOyRwpnHbV1pdm82FtCtIGxYIjxgZXRqOjniLTSt
 N5Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4UZxh02gQ6U54Ey+KualYQ94LpCe0Z2aGbKYFxANZfUTDggwS3O7q4nng7O1IvzSp38vvqRWSbKGC@nongnu.org
X-Gm-Message-State: AOJu0Yyz5yOs7uCe1TcFPE96nVWf10gvXfC9TwOGRDmnCH71808FVs/H
 JIZx36065zVV7YO5JN2WkabwbMYrcLDuBjl9FumHWnAWrnE/4hjrxa7ZX9nPRkcSFVsX/ETCvqx
 NZWxAq5UfDZSQP7imaMBXySe5u/Vfn3Hj4NXKmHjn0g==
X-Gm-Gg: ATEYQzxc76zU5e2ArR3Y/OSenSMPi646KFjFDErNPYlFqK6GvKXvHCUjjIa5AdGqKk5
 jyVX5adA+6pLxEerKLzpYrftfxKaZPT6Ul6JYYaZxLnsjtgzPbiZ/OppmvWy4hPNdSiluwMPpQf
 FEG5DBe7OMCSH8gAi/F2qyAGSO4DBjbCme/e3loZnLs8s6kM4o5Oo8+lkTQZsjvf01yJ1FNqbr4
 CvhF3SfgmNFFiQAPJV7Afh8XM1i2sdE89Z7fAoY4rpLkK8mgHF1re8jooRO/4rL/XzJFhNZ8JdH
 47XN1/wMHXQYu2zGGAbmaU8sngS97Bj4PV1MdBLwWveyT4P71VZrejByCwGwSp1M+ts=
X-Received: by 2002:a05:690c:6893:b0:79a:b46c:e614 with SMTP id
 00721157ae682-79ab46cf332mr38260477b3.16.1774274045644; Mon, 23 Mar 2026
 06:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
In-Reply-To: <acFDFHsh8Rjhfncc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 13:53:53 +0000
X-Gm-Features: AaiRm52xYyvmjhuImqAkZGp1jn5uC0nJiYY8VFGKzFxPqLsA-jgN3NIcb6TFSqE
Message-ID: <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, 
 mst@redhat.com, yuri.benditovich@daynix.com, akihiko.odaki@daynix.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > virtio_net_handle_rss() enforces that indirections_len is a non-zero
> > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > virtio_net_rss_post_load() applies none of these checks to values
> > restored from the migration stream.
> >
> > A crafted migration stream can set indirections_len to 0.  Even if it
>
> The migration stream originating from the source QEMU is trusted.

Is it? In https://www.qemu.org/docs/master/system/security.html we say:

# The following entities are untrusted, meaning that they may be buggy
# or malicious:

#  * Guest
#  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
#  * Network protocols (e.g. NBD, live migration)
#  * User-supplied files (e.g. disk images, kernels, device trees)
#  * Passthrough devices (e.g. PCI, USB)

which explicitly lists "live migration" as an untrusted entity.

I would definitely be extremely cautious about having a threat
model where I had to distrust inbound migration data, but the
above does suggest we aim to handle that, and we have I think
in the past taken patches which add sanity-checking to the
migration data.

thanks
-- PMM

