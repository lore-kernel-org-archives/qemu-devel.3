Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27EDC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1omc-0002V7-F8; Wed, 02 Sep 2026 13:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1oma-0002Uk-5y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1omY-0000H5-CR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788370192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tX50KD1doKQcyPXzatYwWK0t2I//3MxKXnuaVUH73xs=;
 b=U6Gz1r0+CeSxE6YZUyh8JuxZ2LaRrfYtGelxacEju3ccJLoWNj7JkbbFNrB+8hN18PiYlQ
 Zeid4qRtmfOnErt/s6hzKUHB6Q2Oa2CLoCbR5nNByd0pqOrKrj5bsRK6+LyVLlS+/hNLB+
 Ezea/6GtDFX9oBDyuNjx1ZMVa6SmmRA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-gcNhPutAOru18Cf_WeVCwA-1; Wed, 02 Sep 2026 13:29:51 -0400
X-MC-Unique: gcNhPutAOru18Cf_WeVCwA-1
X-Mimecast-MFC-AGG-ID: gcNhPutAOru18Cf_WeVCwA_1788370191
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66e509682ccso1839628d50.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788370191; cv=none;
 d=google.com; s=arc-20260327;
 b=JW69/h608qIWh33OAFgnkRMiGbsUgUFeykaGyJbISdSLiq5gh1FRLIdRQVkwMnC71C
 /oBQz2WnaUqC7cJUGDL9gB5kLFF100Tpoe5PaWwZXnz1puLu2DgqIYt2LyEsYstVogC3
 3KJDrnyySdRKqovnlivJeKXvoLqwi7qgRh9DxGXZLbHy35/leKY4j+WwHfvt9Y5AuB6V
 vVAeZaYnIyOFuK0qFudien9z7DWiUqFKPB/uC66XWTGx93ZODQ4XVUW8XK6garQmeZIo
 iATYogKJcPNeZ6hPKUfzzn0geOC7GbvVcvW0yqzyrhtichOpWXVBQ26NY5bSw7EbWxv7
 EXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tX50KD1doKQcyPXzatYwWK0t2I//3MxKXnuaVUH73xs=;
 fh=AbAvM6kPqbNBTMzrTjiicXfNVusUB91J2Imip4ziZX0=;
 b=ozS90rb1nXmk6nReEi5xoooFF0LtgXZKgYXLINirAc9fV3CkOuWT+1WtJX9jg2z68E
 DENBgHZb9m1sWCH5cO5yZ5xkFhOpXNVaKjfF8EYEIXJkDnWp9bPntYcuEPhBOdUuGvld
 PRW8vmzjIhJLy178Yg4LOojsh4PiKNBkkyxBCVe7dV14c99ViKV57BWLjGJAF8W4np4N
 ErzkXbW1wVcWozRBiiGyPO2v0YALn3LBjX6cewSo6Skh2ue7KNWXSegIgX+mSs/a9Nu6
 kx/orBssXDn2i9PBbjNFN1Lg7rztz9ivRxPxKm4SpiYkCWLOzv3pOKKIJJ+9i3RC7inz
 zGfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788370191; x=1788974991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tX50KD1doKQcyPXzatYwWK0t2I//3MxKXnuaVUH73xs=;
 b=H1rAjS4/m4E8YonIOhGDX+YcgKHP7YCykVNkZ/fBO5Vrbb08JjE2K+IRCWemKb8tzd
 f4C/4yHFmCF93Ydd+Txxb39669bQ95Xp2SexA6RszwcsGPNvwnW4p0P4XNCdd23utd37
 Mf2vz14grLeHChIerzpfNsAIxajQXyufAhJES4QHADgI3eTBIDsQnjfauB1769rSDNmA
 ths5uuo16NZOimcvB076QtuVRN0RJeyHUUxzSZ2++UD5YHXERVbzldNQ7XyqgxQNCBJn
 Ju5IP+CZlzKQraAPDf7WAc69A/p1GxqErghPILxXgVy0ZaXwJzI+eSsYMimu/3p3b0xZ
 BMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788370191; x=1788974991;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tX50KD1doKQcyPXzatYwWK0t2I//3MxKXnuaVUH73xs=;
 b=WrAZpxvJxQLfgUBHq7/8y0m2plXG8fQgxgfd4V4Sly73uKZLzhfTdoaOctbjtLCvc+
 Gs5eBCRJwJuG6FKkRekkgh2nh/R1bBf8F16A6n66rXn9XutaOo8hQWCmmVi8Rpp0MHdo
 oV/5Pqj1H1jUiN2JIRLiA1Zf0V655BFkeKVNdUVp0FqkcVWt+TZvzDN9DLaz+ZhqRUQd
 isau/hZNIeE9sgt+7uAnY1RDpaKIEkdZtrOVaa68aFOAMqsXifMYCM+4xbgXr9h5zntH
 lEIzeMDo2qzCUHZdIvj2jYeDk/BNh6d+wU0yBvsbFj75a2zKumytN/bTKIWwP6Z+M56J
 y9sg==
X-Gm-Message-State: AFuF++kocRTc5izTIlEk2GPbJd8ING/poDMSXwtD7F+Ft9cy5aNxSo90
 xxusOUmgzLKKuA+TeZznEuzZyp7K83jYTJq8VP7eEJAMoBnuG6Mlq/iHM12fW3bY0TL5lGuK6dK
 tUa8YZpYjfpK9LLWyZfu0r7pUdFObBplS5wAPcF9fM9hXCdOv1ldJVFCdbN+5EAP0VOywW6BOMd
 2tdg59YMcvaJS7u9b5zp2hPih0gFHXuOU=
X-Gm-Gg: AYBFou2Zgsv+kDxhjnIqhuoRw03mQ2AdhACv8umAJbzoK4YVy4g/FY6sQ7/VWmPp9t/
 4vGH1On97zmltM1wpEH0E1Ye5UsZqJVQpAiaK7p1cbf8c7MG07e+mJmvebZBOiyULEiZx85EI79
 Um3+2I2lLOx1vazT7LsLe5wpfF79zNQaaI5prY0qRRzrj1z1quvpzmKxh4Tt7meNaCRnw7Ea/9V
 2lZ/5j30OVvKIr6
X-Received: by 2002:a05:690e:c4a:b0:66f:a87e:4f2 with SMTP id
 956f58d0204a3-66fa87e07damr588239d50.17.1788370190324; 
 Wed, 02 Sep 2026 10:29:50 -0700 (PDT)
X-Received: by 2002:a05:690e:c4a:b0:66f:a87e:4f2 with SMTP id
 956f58d0204a3-66fa87e07damr588227d50.17.1788370189845; Wed, 02 Sep 2026
 10:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
 <apftNyHCjxBCheyK@sirius.home.kraxel.org>
In-Reply-To: <apftNyHCjxBCheyK@sirius.home.kraxel.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 13:29:38 -0400
X-Gm-Features: AcwNN1WmrZD02IhMKA43Gb-iisWJbaBbDbPMV1jKkt4WFR2nHgUzTEBdccbcj20
Message-ID: <CAFn=p-Yn8=ZUdYFF3LhapQzkff+yCNttgdgdeY_3NNtp08QGOA@mail.gmail.com>
Subject: Re: Async machine appliance for testing (python)
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 2, 2026 at 5:36=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
>
>   Hi,
>
> > Before I dig in, I wanted to ask if this would be a helpful project.
> > The main selling points would be:
> >
> > (1) Ability to split it out from the main QEMU tree, like QMP was, for
> > use in external testing
>
> I'd still love to see this happening.
>
> > (4) Ability to add listeners/event handlers to watch for specific
> > patterns and trigger asynchronously when they occur; i.e. ability to
> > handle and watch for specific patterns in an arbitrary order without
> > deadlocking your test
>
> That sounds very useful to me.
>
> take care,
>   Gerd

Got it. When I handle some of the more obviously pressing issues with
our build system as a result of the py312 upgrade, I will work to
resuscitate this project and I will reach out to you (hopefully)
before long for some early feedback on the API.

One of the big challenges here is designing an API that allows us to
safely split it out from the QEMU tree without boxing ourselves into a
corner with options management. QMP is relatively stable and so was
easy to fork out, but the machine appliance makes a lot more
assumptions about how to manage the QEMU process and there's a bit of
design risk inherent to splitting it out. I think I have some good
ideas for how to do this without accidentally reinventing libvirt
again, but we'll see.

Thanks,
--js


