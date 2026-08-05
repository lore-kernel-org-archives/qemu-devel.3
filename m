Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B6C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrlJM-0003YR-GK; Wed, 05 Aug 2026 19:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrlJK-0003Xw-Ty
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 19:46:10 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrlJJ-0005ql-K4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 19:46:10 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-51c04bf4711so14292231cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785973568; cv=none;
 d=google.com; s=arc-20260327;
 b=RJMfuUn3/xqE0iv17O0J3YO6UrYK2ZyqmnG80XLHAzapqgypfgZdq/7vXpB7TLUZAu
 HMZAa73JUL9mASSIQoWgjEojuWkpRQDP8n7E0M1TTrHbCw23CcQVDKaGnvPDqQsQ9iHy
 mtCglAulAJwrxa1IPQWXbT+VDVOuQLWCEzkPu72qUXGXKYqFkq2TvjhJ8omps1tK5w3M
 skPYkPd6GAotFRLthuPw/i0SE7/Qw3qQKvfnUrNjtMfD1S8LSExCtvXJCwkvKTK3+uvs
 t5DfTPHhHPDv6X7k9AlFGOn2rHs3KlWNQQRE3bMaynlx7LW7PR8kJk7CxZbWHveAUaMe
 v5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bBoUgyuLcxLRQy3pxTBFtiWOKZu+vFLM2ROsWki0jc8=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=pVF92D/3cORcHT3+7hBc4s93QORNRpUJ9QW9agqhA3q5rXYqTNUvu+5kXVri8uKq5F
 Jrqg20jlfTGz8/NDzRJVvz+qc3nCENnTfD5Ds20UU2Pkrg/R4XFkCAuVP9oPaxXERYXe
 kjCFpCPF5JkFl0meUYSSxkhDmb34i5F294lSWxgBJCKujYyQq2JgClL79lC8DDSLZFuN
 ypNHEwSLKJV2Ut2b2Q+5zbqpH4XNiDqQqokPb2A12wjIsUt6Bs1o+l/hLlcGj4w3L1Gc
 myQXHLFqnUt6C9r4E2xjXKSaPEF6nMRyk4AgoStSLf2mK7qqGN9/wltQKCAmkuL4H6C0
 aMGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785973568; x=1786578368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bBoUgyuLcxLRQy3pxTBFtiWOKZu+vFLM2ROsWki0jc8=;
 b=fw2qaW+RLzXrZog0ZY91EvFkos0jw/EVUU31D4wxrTSt858YlPjKgYtYoJTeFW7qJq
 USHvXKul+Nf+Uw/eJSItLLitO/QOHT8pboySN8WzAIovH9w+hb0Di3kj68X4E+0dXaos
 jVkdCRDwjvFLch3I/5lnVsuyxcEGmpmLwVAuG5r4wpKv8XXsTFTx5snmBHQQMKUC/s2x
 z88mLPunnoE8Wyx7gHlcDO3CcniFPv5iA29Poc4csYmQhgrmzjDtg6/3pLwNZj5EugAk
 AFgBfF5OKyg45gtqev+Kin5rKPUjLqtvwz8PVo0VhEoWTI/mmTJ/4KzYnwIMTU9eL/kp
 bdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785973568; x=1786578368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bBoUgyuLcxLRQy3pxTBFtiWOKZu+vFLM2ROsWki0jc8=;
 b=k0jAhJL7NtYR0770kP/RqCK/2Nn0UGtMsiIfXTI3oniu54WkfpDSOfpP5AlTATmJKk
 Qd4b+i8ChReqO8yEDacGYc08rpCLvP4O3Fu019X55VAkKY2b2FjEJnkeTj8fT2QU/77M
 NOU3eNjX+6AT/LT5szTJ4FpkC+SYQSKaPKPcAMWj2lgYhUgZwyh8QcMLr46A1dkQr/Wd
 KTAnX/YV3o76WUR6l8MVqM1G09iQmiSl4bjuFqNnvak2nZ48U+g7fQ6VeU0KPdEF+OTH
 Mv3NJiX9uUoknepgFPCrAkqL+5bh26Nxxr4KasTtmYDXRIKqBKVlnVfwt/DFK3JBtzt/
 /yHA==
X-Gm-Message-State: AOJu0YwW52nScU7U4XpBvtgsr/bir0XpwZB7N/a3wPPrUorEXtchMuZl
 cUtDcujAkFfiJrIaHpf4t6SrKcXSrrw0A8wSlw5Sex5IeszDEhJdo/exWByumbGVkM1GKqFgtDq
 2BMvRgcCYra4vsQPhT07O5qRkV90QcGo=
X-Gm-Gg: AR+sD13n2+pEqTl/p/pitE+rUDauWG0DCIwn/WffA8pq9leptvsQOhyI5PakFkAdhL4
 2IyiiUctpU9Qp0+cEzDgRwOrOolqWJTG813BviGdBlAihmbgv0nDdCU9g26721XTKZO3MWzAQLJ
 CHj+g1Q+mxhMiVso4Tpq1mwzrGhLbkluPZTRO08CPFm+AE4muwXXJ8/rPCnsvGUCS0yzyqnEAGl
 jOFsosJEXNt9tTeGOsTtR39Jz0mlC7ibyZLos6KN3+tHc0Te/gX04vOpd5XxwkDgzC9ufWg4Qhd
 ImZGAANX+z7SMyKf3LVpqs78qjPou49Kr3ZJgbma3bGINx8pB+e8jyucxdxtMhO9cM8gtnau20t
 a58w=
X-Received: by 2002:a05:620a:6406:b0:934:946d:599d with SMTP id
 af79cd13be357-936491c0d2amr1089166785a.33.1785973563793; Wed, 05 Aug 2026
 16:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-5-6b97c439eb28@gmail.com>
 <e40ea812-8774-46c3-aee6-511c6fbd07cc@redhat.com>
In-Reply-To: <e40ea812-8774-46c3-aee6-511c6fbd07cc@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 5 Aug 2026 16:45:51 -0700
X-Gm-Features: AUfX_mzXgSOHiICY1ddqK-TuDzFkaEE3jBELqqIvC9vbvc2AV0fuGlTf_pfRFfA
Message-ID: <CA+spn3ouZF2kRnvsBrasxdCwfmuXfK25mqgCcvpe0Oc3Y_aRwA@mail.gmail.com>
Subject: Re: [PATCH RFC 05/15] vhost-user: add memory_isolation to
 VhostUserState
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x831.google.com
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

On Mon, Aug 3, 2026 at 5:29=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> > -           netdev->u.passt.memory_isolation) {
> > +            netdev->u.passt.memory_isolation) {
> >               memory_isolation =3D true;
> >           }
>
> I think this part of the hunk should be squashed into HEAD^.
>
> Hanna
>

And squashed!  This patch has also been swapped with the previous one to
avoid dead code.

