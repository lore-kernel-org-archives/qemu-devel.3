Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F795C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UM2-00060s-5G; Wed, 23 Sep 2026 17:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9ULw-00060W-F8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9ULu-0000jw-Cg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790198284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2AZFjpcIARkJn/GLQMRyfI66GxHkwJSsLIvWhvhY3Q=;
 b=LRzSWstrpB6vH4ZtmEayxnbRD3tR7WvuD3kI+eHwQ2kVzAbez8x1x/fhkSwwmpM94JsXec
 /xhXLF1JHjRkOW4kKhkNjDsO87BtxTtLS9j6rUSd6L+j4Xzm/AvjSXqdx3cTLSqeQI8M7T
 vJRSq9q5ZThpaOiEkR0PcUcxzTevndE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-kHk1fRg5MCC0aOyZUxkoBg-1; Wed, 23 Sep 2026 17:18:00 -0400
X-MC-Unique: kHk1fRg5MCC0aOyZUxkoBg-1
X-Mimecast-MFC-AGG-ID: kHk1fRg5MCC0aOyZUxkoBg_1790198280
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6714b504d08so2138447d50.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790198280; cv=none;
 d=google.com; s=arc-20260327;
 b=PoYVYNdx1ne/wwgg239lF0g+JsiZ6hwIwJU59mjt+W2ARvnQVlnlEO9YvSue/lLzyd
 ASu/mEF+Lgi/9gulSt4FTWn0lM5rNNvScxNgkHjjle3/2aoavkqiUJSHsgnIQ37SLFEd
 f6UcfSO5VQFbnrQsfLP/IZqv46KRlqbM07oY+iOLiuHhtu4t6Ov+5N3R46+CK+5q55gJ
 PiX9YibQwZyCPJBD6TsUr+8Mv6FsW+LIHgM/8E/tMfPuy5Pio/BFKJYQz9VAsjtid/Zd
 BTh7j+a5S9LAfzh4Dd9RKm/hOm6rsplF8loBe3gCsbN4GnWkzFocfsJGLOhTsCj9w8F7
 PIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w2AZFjpcIARkJn/GLQMRyfI66GxHkwJSsLIvWhvhY3Q=;
 fh=b0Z3lWGcCo1hESi6SCJ0YxnP/BPVR7A0V6Qykw4FH5U=;
 b=KW6hAtvdozRanlHO2/9YqpjLwszfcDmYASKXItXIPEPoVPZ9a4Rnm32Q2MRhDI1U82
 gTCICuV/ABC52Feywb9NFmVnjBoTOrlxP9A5pIfWaEx1OHCLsoKW6CFHB1zMBoAWrOfU
 tPUWDumMVLD3e97YvYBVKeRr50RdwzQrCaLlhdNbRhkH5NZSzzfJQkwLicEnnLu1VazA
 8ZJclY7LVx4J3rZToEFDUoSRCipHwmiAI+tY/JjdwKt/RVloavAMiMKpXEdlD0ns/kpS
 wqu2xsApcqwusFhlBK/xU1Lg78LBHRwZwe2Cjyxh2ojKeUnjRsPYy4n0/toOJoFpTw1A
 ftIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790198280; x=1790803080; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w2AZFjpcIARkJn/GLQMRyfI66GxHkwJSsLIvWhvhY3Q=;
 b=nH04/GCLIxgEEM+wWcN+5NZzLSa67C9n6VIqSx+88T6kZo9sz/EU/O0Heqg8lqeJyd
 kJ/qkfgQgSX9G8sada94lNQnia4MD+NAsxJjjn31jHoiqZe+E9O867bApBfsBQ+HN+Rm
 Y7R34hiZ9IcKJ3SZA/bwQU3tAv6i3FhmbxCRHJylnXHPwm7fZ6/PCLCOzJWL3cekKnx5
 7Pz3I9+z6NBt5GAErt36s5ZnMYAUwoYN6rgGxFvI/+rwCkKCqx6QEHrWyZI64PGNWKBf
 jgz7vpL6iZR8HR5Z4HsPweUDARe0sTPQW873v89jqe41fZp5VHnZUzjb8pDlmdUdbQFO
 VheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790198280; x=1790803080;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w2AZFjpcIARkJn/GLQMRyfI66GxHkwJSsLIvWhvhY3Q=;
 b=s/SBc+w003GFOhUARNWJphLat45k47LLc51QLXrFj05UHnDksia/qXye74WqK4+gqs
 oPsid8kZEZ6Oq/BT7JchzP4jRmOgPapYXmrAA2TYSZHmETkyq/CInEY/WoNqIez62mxZ
 vpnHGjGpUJR1riAPOpB4rVeQduv+8vIhDbGFxeaCdFBcxY6E0N6gFrNFTRp0DLp+ogS4
 fZ8g35Fz9/96ou5fnjVf/TRY9OszyBuRT0vL2dJVq8UB+U0LOBlxngQr7ed80tjAJjtN
 tk25MWzNSFbu/2UZ06zorTfr9fMfUYOvMG+oI4U4zI9ZvZ/Ua1ug4RehB6okBdRrR0A7
 +8EA==
X-Gm-Message-State: AFuF++lFH3yp6A2TI5jXawDPvx3oX7iF0NCbTdq/76EYo0UIJAUW82Qu
 3jbcRVpWAORw1PTfN4U/09QHcn23l/GVA2ZsBVa+cqMQ1dnIBh7DPW4dhK8uuEOxaasrHMgfqS4
 RRL2GkOBoquLMPVUxMAUmHrf2titoCOqWYDjliTz2A7jg6mFimgXC6QZvRkCPRDgmuLPqXkxRNe
 uBPUDyZNk8WFeydmkEuhljyA7XEDoU3MU=
X-Gm-Gg: AYBFou06CjFqKwJj0nmRGhie/6Sb0ivGhFkBeJ3vjwS0wqbh3NeRdEtD2p9JN7a1pVF
 DTMgQnCN0hj8P9Itqz7O8qpH2Mw2mZnLIypmhMmtT7khSR1FkT1jT2HCwWCo/olB2QStOROSXhQ
 2c29HsyJg8n8fMOW/WOOLmfb0nJvqlqjC9xA/UfqMgELuImlvbCXeSvrzOYR30tyhTwnpjM+3oy
 RyLXVXSGPANkaYi
X-Received: by 2002:a05:690e:8d:b0:671:2a94:b4ae with SMTP id
 956f58d0204a3-672ed2723aamr234820d50.36.1790198279983; 
 Wed, 23 Sep 2026 14:17:59 -0700 (PDT)
X-Received: by 2002:a05:690e:8d:b0:671:2a94:b4ae with SMTP id
 956f58d0204a3-672ed2723aamr234812d50.36.1790198279567; Wed, 23 Sep 2026
 14:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205712.1862167-1-jsnow@redhat.com>
 <20260921205712.1862167-10-jsnow@redhat.com>
 <87bj9outu5.fsf@pond.sub.org>
In-Reply-To: <87bj9outu5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 17:17:47 -0400
X-Gm-Features: AcwNN1XqYbLvl4IlAga18m3Kx1js7FYxSwrL2WaV2YxjGHZOVI_5s9amGlrRPNk
Message-ID: <CAFn=p-Zst9xHD+DYsVoWU6Oef-0uho+ra6CT+S7jt7eBkUu+1A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] qapi: split intro sections for data structs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 23, 2026 at 6:48=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > The structs of concern in this patch are those for which no other QAPI
> > definition uses as a data type to describe its own arguments or as a
> > branch of a union: i.e. they are not currently inlined and as such the
> > precise semantics of their intro/details split is *currently* of less
> > concern.
> >
> > Of course, they could be inlined in the future, so the semantics of
> > this split are still worth investigating.
> >
> > Review notes: Similar notes as previous patches in this series with
> > respect to how splits were determined, and why details were not
> > physically relocated.
>
> Help me out, please: which notes exactly?

*cough* I am drowning in rebases. Sorry, leftover from an earlier revision.

Removing this paragraph, but what it *was* referring to was the fact
that I left "plaintext" sections in place instead of relocating them,
and that the splits I made were effectively arbitrary based on vibes.



>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/acpi.json       | 3 +--
> >  qapi/block-core.json | 5 ++---
> >  qapi/compat.json     | 3 +--
> >  qapi/machine.json    | 9 ++++-----
> >  4 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/qapi/acpi.json b/qapi/acpi.json
> > index 291a04a7ea4..82e82d7cf89 100644
> > --- a/qapi/acpi.json
> > +++ b/qapi/acpi.json
> > @@ -13,8 +13,7 @@
> >
> >  ##
> >  # @AcpiTableOptions:
> > -#
> > -# Specify an ACPI table on the command line to load.
> > +#     Specify an ACPI table on the command line to load.
> >  #
> >  # At most one of @file and @data can be specified.  The list of files
> >  # specified by any one of them is loaded and concatenated in order.
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 13981d7e69d..741c8165c06 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -843,9 +843,8 @@
> >
> >  ##
> >  # @BlockMeasureInfo:
> > -#
> > -# Image file size calculation information.  This structure describes
> > -# the size requirements for creating a new image file.
> > +#     Image file size calculation information.  This structure
> > +#     describes the size requirements for creating a new image file.
> >  #
> >  # The size requirements depend on the new image file format.  File
> >  # size always equals virtual disk size for the 'raw' format, even for
> > diff --git a/qapi/compat.json b/qapi/compat.json
> > index ef1853b9acd..b42d142ddcc 100644
> > --- a/qapi/compat.json
> > +++ b/qapi/compat.json
> > @@ -37,8 +37,7 @@
> >
> >  ##
> >  # @CompatPolicy:
> > -#
> > -# Policy for handling deprecated management interfaces.
> > +#     Policy for handling deprecated management interfaces.
> >  #
> >  # This is intended for testing users of the management interfaces.
> >  #
>    # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
>    # with feature 'deprecated' or 'unstable'.  We may want to extend it
>    # to cover semantic aspects and CLI.
>    #
>    # Limitation: deprecated-output policy @hide is not implemented for
>    # enumeration values.  They behave the same as with policy @accept.
>
> "This is intended for" caught my eyes.  Inlining it feels problematic.
> For starters, how will "this" be interpreted in the new context?
>
> Fortunately, this won't be inlined any time soon: it's used just as
> argument of -compat, and the CLI isn't QAPIfied.
>
> Similar difficulties can arise whenever we inline more than just member
> descriptions.  Avoiding them now feels impractical; we'll have to read
> the texts in the contexts where the inliner puts them.  I see a lot of
> proofreading and doc editing in our future.

Will reshuffle this bit.

Yes, there needs to be a doc review push - this is more than I can
handle on my own, but if each maintainer could be bribed to review
*just* their own module, we could probably make sure we hit all of the
glaring problems...

>
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 00a03e57b98..b18c6d94a38 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1629,9 +1629,9 @@
> >
> >  ##
> >  # @SMPConfiguration:
> > -#
> > -# Schema for CPU topology configuration.  A missing value lets QEMU
> > -# figure out a suitable value based on the ones that are provided.
> > +#     Schema for CPU topology configuration.  A missing value lets
> > +#     QEMU figure out a suitable value based on the ones that are
> > +#     provided.
> >  #
> >  # The members other than @cpus and @maxcpus define a topology of
> >  # containers.
> > @@ -1890,8 +1890,7 @@
> >
> >  ##
> >  # @CpuModelInfo:
> > -#
> > -# Virtual CPU model.
> > +#     Virtual CPU model.
> >  #
> >  # A CPU model consists of the name of a CPU definition, to which delta
> >  # changes are applied (e.g. features added/removed).  Most magic
>


