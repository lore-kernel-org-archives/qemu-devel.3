Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B16C5DF8C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLA8-0008O1-2S; Fri, 21 Aug 2026 05:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxLA7-0008Ne-2N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:03:43 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxLA4-0004nH-PK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:03:41 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so383123966b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787303018; cv=none;
 d=google.com; s=arc-20260327;
 b=XDEk90ghrdEgY+4SRhTKD//nGdgXVDT6Zii2mzN0cfjWeaiRJ61ZqK9/vXyFaYIstM
 WFkSjfKrgojLNnJi29YkZkAtPIHt/rdGjUDS62sNQaeBR/qpQt1Anzbk6j/rS2jVmhZi
 uudlkcZ0n8IRyNhUPu50jCKkOIgG6Gluy0YnXH4GIHEZNGwI/jrzqSZeINUCgtDCiXDF
 2OsB0JnxyVPmIjiPe3iyXfKbSdJN3om0UvipCNQ724pXCndC3NBgH3Fx6XbyikhWHMcd
 u3SCj4FjQ7f4mRVRTP3uQBta6L8gYn4CP+uWaGNKK/D4yqX1v64v4vZPARnS43jaQ/WF
 Ep7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZVxJHt/4b5mqJ4x+qkllSoDNCMU8pX9It2YrUvfMLUs=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=UHtFumRRVGyPBil0c+OjQ6zLEniG/Y/2kb0WU9FVH0jhrzrMPS4NQwc5rKcT74QpFi
 LP2fCwSQt9TVxlV0KZwIF4r8es2guQOQnj6lBN6SokxJ+2KsekBql1oHsZ6Tzem53Ik1
 4cI1Rdyh0pydGK3Rb53dk16NsxEV99CWQ6nb7/kKyHZSZcQQWWBwpyDH0YO/qC5I21cZ
 HF78fCz4vh+9H4jIwYnER1Aj+qUuKi0eASiqPYZcjDpMXlQrVwZHFZUGcrtoXHqkH3Ys
 1ph6seXiLOCnWKr9qSIVqX/IGzKq3LYa3nJZq3XYknCd1D6zLi3QXAT8/kSaEeQw4IaC
 dgxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787303018; x=1787907818; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVxJHt/4b5mqJ4x+qkllSoDNCMU8pX9It2YrUvfMLUs=;
 b=WYUzUuPJPy053S1QH2LnfP+6Q9nkbJuo3eXpAOCFOkx5C9o2tQnBlUbXJHNO/omo0U
 5PnmL/vLkL71blSfNo/0UY8yruN2U++xqCxYlBrg94UjbwiEd+OthFU5kx3asCny0vHj
 WwsHFz+qmQbvWDFjLE96ujOflA2y0vF5o05ArgrqNVG2fTbQm2YDMQECynzhoV02Ly37
 tdvOY6NcPFZR0hrqhN70r7/kuabt+GWrIj4T7ugAzzWyEaD7RBlyuVa8SmtDx3ovJnB5
 pE7Ck3UqiP4lJTpnOqBbmN8nCT1eljsSi5ug0iYAXRZ8Xf6evQ2BC9nH8IezzwM1uG5u
 Ffpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787303018; x=1787907818;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVxJHt/4b5mqJ4x+qkllSoDNCMU8pX9It2YrUvfMLUs=;
 b=fN4ENTmkof8q3cEucrMIgUe+Q87sefYRt44vT90vZ9JDL6AersbVc8G0lnGMUHzm7F
 axynLQe9ryGAtyo86ZJFA2noC4TRFj8pvSdWQzH7HJosfO1NUTDNQUC9xQzo2vSVTERu
 OknbtlkZos/cpb6S6A5aGjYivVDA9b4hUJBApZyIi29SIZGBMCQUv3+nPtfY3dTEg92y
 1vQKdwt4d4ZCLZk85cR6Uc3Db9gGWxQ+Ca88Uigpr+BGoR+ooQNafVpQCyaLyX+F2k7/
 YDAXH8zt/nCJ4d3Q11/F3BCiTCgTRw3UYETDxTDUqGLrceGouG4uxZo43es5u3twG5H+
 xkYA==
X-Gm-Message-State: AFuF++mSK75zvQRk+is8NQl1rVYYaRT9yFvgKkpITu8ftspek+Eal5Zl
 qBMXN76LJalCyWQdPJeuY2I1mTwMY3U5q+ItgXa9gGMh3rHxHs61nUN2Dtixel+x4eOktoLM5EA
 8OLGuRTS7c+4fsUUVP0hSxoxDeoqubj0=
X-Gm-Gg: AR+sD1052b/GHZtPhFNazAQDQy4IRK8n4N9yE/GEozxb9lX/WCmwJvG9nsMQWYoMATO
 VPnWlFu9jv6Zub39a5c87molX8r3rjCN8UOBP92DoFF7VfG8Ko1iBGb/0Z/TOyHMUvl/f5gKV/U
 8zuZkkLg+sJ2nURl1TdAzD88uwVhH+sc88Rdvl3zlQdiUUVowe7YIImt7lrVhsmNqiU0ars+deN
 vw4U5gFmH4afjh/5bFJYckdepFAI92Uu5iYrvGT2Z8xmi+BglUTxiOUDKPsm3kbT4tR+jetWj48
 0RlqWBlQ4b6q6ESiTAFH6ACvfu6jqZAdiSSXmnRNZgS5
X-Received: by 2002:a17:907:9481:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c246d58210bmr368237266b.2.1787303007829; Fri, 21 Aug 2026
 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-3-zhangckid@gmail.com>
 <20260819182509.GC222512@fedora>
In-Reply-To: <20260819182509.GC222512@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 21 Aug 2026 17:02:50 +0800
X-Gm-Features: AcwNN1UnRYY2lueBQPTMmtTfTvNIn8EkVboHHpGnUm7ksm9B38XABWH0PHqChU8
Message-ID: <CAK3tnvJ65gWa6x0Ck2hhtVqUBcw+X_ngB-aVjQW6O3qLOyogxA@mail.gmail.com>
Subject: Re: [PATCH V12 02/15] iothread: introduce holder tracking
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x630.google.com
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

On Thu, Aug 20, 2026 at 2:25=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Aug 15, 2026 at 01:48:16AM +0800, Zhang Chen wrote:
> > +static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > +                                   const IOThreadHolder *holder_b)
> > +{
> > +    const char *name_a, *name_b;
> > +
> > +    if (holder_a->type !=3D holder_b->type) {
> > +        return holder_b->type - holder_a->type;
>
> This isn't a bug, but compare functions return negative for a < b, 0 for
> equals, and positive for a > b. That's how the strcmp() below behaves.
> Here holder_b->type - holder_a->type reverses the order. Luckily I don't
> think anything relies on ordering, so it doesn't really matter, but it's
> inconsistent and a little confusing.
>
> I suggest holder_a->type - holder_b->type instead.

OK, will fix in the next version.

Thanks

Chen

