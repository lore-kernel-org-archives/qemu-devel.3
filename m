Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9E4FED2F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bgg-0007dc-1p; Thu, 12 Mar 2026 04:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0bgX-0007cv-Rn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:46:27 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0bgW-0000cP-2N
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:46:25 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-661568ce781so961102a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 01:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773305181; cv=none;
 d=google.com; s=arc-20240605;
 b=Pj3DBiXEUDtiVIM0yzxUbRuHoLY+PgtX0V1xcObjomMX5K2pHRXOrMSmYGaglHV5qN
 +4gdohXMaJScC/vj4lDlYgMEMxxARqbjZOrg0XYZerkEpQPLZ/+5RA4k/ybMbDxCQPKF
 1CfXvIHrKvClMc1WEvFxu+PDnn0WnqUYExIVeBvoOgiEEB7Pt/QH/n5i7s3HyspIE/w4
 92uiiaVCEm7TVBvapczFZrRRIIpY4jT9TFnDpKli5WC/A2AhRYpbzQB6oTeNe0gkzS+s
 wf4ZUbBKH3+Kk0PRcT0WCihEIO3zq3NPF8TSzo+SeIdvjktBURHVaghj51Dq+oT3KIoL
 ZCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XttKHAPipNCZuC9KuhzFY/Vqvrdbc5O2QCI0yQ7oG/E=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=cjRNMqCMY64S9XFRIpLFON4E+2wvX7e+aTZZhUhjEHPG03B0Qz8nToJUjoz9A1h0tl
 khYgtLh1+2wAxDJ+4SChsuUQt8PZeNea5uRF0h/RLYA8zhq2lKXualST6oUoVNbXyKDj
 opW1+Y/1SHfOwkVQeIaIfdMSwO8IJSKjoR+2Z/L//B+s1t6hUbWMrL7NA523JuRZX4zt
 JqbX1AGTPKnfTEDFGvY5CuQ2P8tC2ExDEOBiEG5asfQsIyiKzQAyz89H2YJ+KMmq9QIZ
 o/EEJdsoQpMwl6Lr1FqgsKuQExpn8ao9JU5bFOi1ys6eIx3pERzzx0wNZZyBi1oPB5HD
 OpIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773305181; x=1773909981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XttKHAPipNCZuC9KuhzFY/Vqvrdbc5O2QCI0yQ7oG/E=;
 b=PWC5XrGkWjLrbJPgwzVf7MGSQtq/gqB4ncM0R0BwVBH7kupfXO76gDPjUCEyHKCgie
 iYwiG2tmpl1kM+Q+ylXYWsfY/hBSHiw2GI7SqxjtfMCyp4E4gIcfPH+kMEDmOwp86eiL
 +sXfnSANz873vZ5aGuvAtqvPpCztod4saV3pIEh2QbA3Xwv9V6wgLyZiIqAGshEQaLgz
 rsqLc4xZy+HP2QgA4iSfhBmeL9Aa963tR7Y1/EU7BmH7Xe7FHSH9KfPIEkv8MkSf2u7G
 lqLVaryfoPmqarDTk7MC+PGHa3HxIisTiIJAzRFvv+Oqj0JblSXsQCu5i2yZs7P2HVsL
 PzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773305181; x=1773909981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XttKHAPipNCZuC9KuhzFY/Vqvrdbc5O2QCI0yQ7oG/E=;
 b=S35SzF8krt5XXmdQ6kUcV+dVcCpGtDwMzch/c0G32+QrOabgB4Y1kcemj3D+2MxZN3
 KwxN/vWSxhnuAOpbZEaGgazAswp/5ccBcmGI+4QTwmuL62f3B3b4MysmpCpKBKQde02/
 0zvbv+7esq/hm6S+elld4D1MwIynUhKxM4Zxnkv2dtMLAEtGfVULQgTrMTrb7XlTxHyy
 90Ae6Pu9pYeVQg6qiD1+cg9aWjYNVKrXJ3COkzEtI85MeH/PNtXaYOnT+rLVqyFYCyXy
 GvdibzoW/2AV/sPZa2MMYsm4hmbmQiv0F8jxYvoHH8Ucco/YbXa5PuNBraGKwSEuGTc5
 aaUA==
X-Gm-Message-State: AOJu0YzNSIhlAIQNqGYaRDq+imUkIj386pHLUIy9lE4eaZAl8b/leejT
 RFxyzH9Zxh9BS1MJAVHrDdp6SSUxperCWbtypImRq2PzjvyA08hCcwEWSwA9j15JRueAQCiwsxZ
 kboiafZxz6A9hyvtt5PWiOkuMVQwH8tY=
X-Gm-Gg: ATEYQzy3YJcWcupi6EBUFI94d8NXPrmL17Xx8HyVkHaXrgqlZzgRyg8FlRqAn3TEatg
 77WMEG5ifGNstyuC6BEzhiYbj+gnmL8vQGFQW/Za9DC/lorzOEUVttb6ZB4RZ9YGmqj7rJfIyvB
 /RQW49CX5EO/bNC/DF5VgnPASjGTWeTbM2F/wAOqvmDvEk76KptEG6AzsTcCRW8CfJ8kgCPpUil
 RlezuqVOiXAq4KPCUNRD/9IEKGWGfqF6/Q1+8DYxhEAS+TJhQCtzHZ8KOzX9eg40ZQM9avxfbSW
 0/PuMFpB
X-Received: by 2002:a05:6402:a290:20b0:663:4bea:c74f with SMTP id
 4fb4d7f45d1cf-6634beac860mr883246a12.17.1773305180563; Thu, 12 Mar 2026
 01:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
 <20260309084422.GG39949@fedora>
 <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
 <20260312053601.GB116604@fedora>
 <CAK3tnvKfeKBxigGsS8B-PiBuq2w5i7Dp3sBfXzZKoaDFr4QBRw@mail.gmail.com>
 <20260312073616.GA129138@fedora>
In-Reply-To: <20260312073616.GA129138@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 12 Mar 2026 16:45:44 +0800
X-Gm-Features: AaiRm52iDeklo2bjDHN13cvB__abjSgKTQx4TD56dYSzckTaTWX64_a3lcXMsZA
Message-ID: <CAK3tnvL+LohU7EWCjBSRbT5aF-YjoGHDPWU0-nSpGZGrP6_GSw@mail.gmail.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Mar 12, 2026 at 3:36=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Thu, Mar 12, 2026 at 02:31:32PM +0800, Zhang Chen wrote:
> > On Thu, Mar 12, 2026 at 1:36=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Tue, Mar 10, 2026 at 06:15:16PM +0800, Zhang Chen wrote:
> > > > On Mon, Mar 9, 2026 at 4:44=E2=80=AFPM Stefan Hajnoczi <stefanha@re=
dhat.com> wrote:
> > > > >
> > > > > On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> > > > > > @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Objec=
t *obj)
> > > > > >
> > > > > >      qemu_bh_delete(s->event_bh);
> > > > > >
> > > > > > -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > > > > +    /*
> > > > > > +     * Use the device's canonical path as the holder ID to tra=
ck IOThread
> > > > > > +     * usage and ensure the AioContext remains valid during th=
e device's
> > > > > > +     * lifecycle.
> > > > > > +     */
> > > > > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, =
NULL);
> > > > >
> > > > > Should NULL be path?
> > > > >
> > > >
> > > > Yes, here code in the finalize function need to waiting for the
> > > > coroutine to complete processing
> > > > Or do you have any other suggestion?
> > >
> > > I'm not sure I understand. My question was about:
> > >
> > >   AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
> > >                                                           ^^^^
> > >
> > > NULL is passed as the argument but this function has a 'path' local
> > > variable. The path variable should be passed instead of NULL.
> >
> > Let me explain in detail.
> > colo-compare have two real holders for the iothread,
> > 1. colo_compare_timer_init.
> > 2. worker_context for chardev handlers.
> >
> > I try to make them use one pair of iothread_get/put.
>
> I suggest storing the AioContext pointer in a new CompareState field in
> colo_compare_iothread() and and then using it in colo_compare_finalize()
> instead of calling iothread_get_aio_context(s->iothread, NULL).

OK, it works and fewer misunderstandings.

Thanks
Chen

>
> Stefan

