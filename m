Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8092C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94NJ-0006ET-LS; Tue, 22 Sep 2026 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94NH-0006Dt-7j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x94NF-0006n0-Iw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790098424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi+qvRAas+uFJKuqkVBomroa/mxGDCtc3HMUOajhkRU=;
 b=D8zSvuIGIl7HCN6nXLhWBT1OedFTpmlvJhLM4MHEDNWTPU5+uxerDwcV5Yy4Ty3jMmsSKg
 bVULHAeTZ9kwSPedNtsTKxrOJqjwiGHENQO7DNd3rn62fmsR9GyiQzIRTEhJKjjv/kUvXk
 s67V+8H0TsdH7oXOqgrTTgdtT+wV+yk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-0nrjGZ52NvyYg_HgS3wAhw-1; Tue, 22 Sep 2026 13:33:42 -0400
X-MC-Unique: 0nrjGZ52NvyYg_HgS3wAhw-1
X-Mimecast-MFC-AGG-ID: 0nrjGZ52NvyYg_HgS3wAhw_1790098422
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6716c35e36dso77701d50.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790098422; cv=none;
 d=google.com; s=arc-20260327;
 b=J5VQYCeXYPVxLMhvGRDfN6Noo3al4q3TDGp3Lhh2TlHOS41MvMudFSaLBlTr20nyrQ
 uYJ/u9pcRubhFbspIi6za6Ayy0RnnIP2c25MfjQb5mVwvoOWupFB5QWYrAp2mKGlLGjs
 7Xvbz52gSrWD0+HQ8d6nRcW5KDwSiAyc362fzd71PYGbqjmPx15rRN9MFEnAmtVq3hCE
 +W0XMF6+/H9bRlY/kjzpmPs8+YCJOsOVHtonpoFU3o1QQ9pqF4n7E8wGNwCgpL7E31Jb
 UA5EWtDc+g1qv/vRcDGsQ4EI9Gm2GNpJ7m7D6RDhKkmh/G3S+8CnZiJS6io2ryc+0o2i
 KH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pi+qvRAas+uFJKuqkVBomroa/mxGDCtc3HMUOajhkRU=;
 fh=4SpBrKxBueTKlh2nVNOI1f4PgGJNaXa+zdI/ORe/sas=;
 b=NB7fTQWyxJD22Kuh8dHkX8SlpEJ9mvgdqJ6ZpJPwgvN0IOOI1a51mrqAHqg5Jtp7FM
 tGw66oDl3Y3am1ozfexBa/gymHQ8KY5LdGry98VjrLahAYOTun32hCNHk62nlHwYUY3N
 4XfcRIpzID1hV08UGtqejT80/xOxFUdeNQeqXlUlIsS/QagwrATW8SjIbi86XvaIRydj
 d2AoMxoKDInHaLqj4JN/eCRtdyFptrLLVHLGOdk2FrSRJBbnmfn5Wjd0RlitHvbfTT7s
 iqZnlvOGSOKoaXhZdVKQEPFRe6zVz+/4qpqnrxAebeYJLKVMtAPos+h+VTD6TcSYwUAi
 TzHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790098422; x=1790703222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pi+qvRAas+uFJKuqkVBomroa/mxGDCtc3HMUOajhkRU=;
 b=f+bBhl3ZaXUkcqeIsZCxtneaqCfi0YnFb5X1vUnGIC246Oevm+2CaUAxRBloHKQKXP
 3zokS358e2xgJNW+n9/QKsQi/JdnwygfKOo/3LGGkRATP94OFxX6R7jzeeFiWNylSRO0
 1Uz+Wem/fHPYvx+/6MMCCePlEtiACOS4MaFJcW2cZWT3rm9Bk5Qu1mEe8eianNbaIKGz
 xq/yMpWJqOVLHDDNIqcqbO5dfOZFYYHOj7uWeNTHyjo0F1lAPge3StiJTf6GK+yH8tb0
 x9BOo6nbm5VqoN1HNKw1gOjfqpJL09VCOJacaMzPCppZziOgESkLbbOVmeDmypNWY7QZ
 Gacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790098422; x=1790703222;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pi+qvRAas+uFJKuqkVBomroa/mxGDCtc3HMUOajhkRU=;
 b=PMR5UrjHS3ap9jeIMcTf9fDmAN7JY4cmPZTpAM/cwpRt6CKn/GHc8zHVCwVDY9pz5r
 ATvdPaqh+xxc2D3Gaf+B5lR5JrWr/aWNTDDOAm9211+vyhvFhZUB4lqoF/Fa7I3OjTxB
 XXsUQsy9Ky2Zi9CdBAAY401g5t274e5hqPqeC7w0QI6vXoDlYtsj2e2DXe7yEw8U9w+v
 00z0sUAtrHxylA2Ai8m1JytPuAx2ZQJV4AOSQ95uQfDMbgKI0+wjSc6RdN89opn2pe40
 GrxowhqnNRw9nNOAbSAzco5cmPuaC57eofZagLpEFfCQdQi0UQcMC5gFnYUYxiw8Lhi2
 ohSA==
X-Gm-Message-State: AFuF++nRvlQ930xp9lNyoGJbC2NtvNA6M7artFsmwO0APb2/gaDzqlId
 uo/4kskHQnis/XVSaX8n+MsgrnHmo1e3rJkjcNGaVbHFi9DKxt2eywb+uVBa+q5M3uugOOTra4s
 BoGGbFvbkcAAYsukWCOMrwc2Wws82Ms7Ey1sThTnah/qiUCFFSLueQZKY1rOvigyjIqO3c2TDzg
 HgQ8TbeDjrCDwtYln5zF1GNKQn90hFi/c=
X-Gm-Gg: AYBFou2xm2bJEgyHx+ZAad/+1ulvFUpmfPP/e9Aa5T7C1y0FvM0v1H4chpQneuUmPow
 uqR4tZBmFO6m2GAB0aypaECUCbpkzTPia00pMrN1dIVFZG8HpBiPKydZtBiWvluer8CXbe3mMZ5
 7OGbFW2OgaMd12pchWoT0j/wZDBJN99P9xefXOnkuauByo4y6loFB+t7U/S4CvMEgK1iU0VRKxn
 gsvOS0ovwPWGBQK
X-Received: by 2002:a05:690e:2417:b0:672:a52c:daf6 with SMTP id
 956f58d0204a3-672d598af82mr121474d50.105.1790098422088; 
 Tue, 22 Sep 2026 10:33:42 -0700 (PDT)
X-Received: by 2002:a05:690e:2417:b0:672:a52c:daf6 with SMTP id
 956f58d0204a3-672d598af82mr121461d50.105.1790098421508; Tue, 22 Sep 2026
 10:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205147.1857168-1-jsnow@redhat.com>
 <20260921205147.1857168-6-jsnow@redhat.com>
 <87a4p949td.fsf@pond.sub.org>
In-Reply-To: <87a4p949td.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 13:33:29 -0400
X-Gm-Features: AcwNN1VJths39qZrc4v0LUEU6RbXIedhUY2La6Vrx-msYZq7nYVB99cKcqeO0nk
Message-ID: <CAFn=p-aj_EzNGKLb8vs3zSht2gdt2B3o2v8GsthcKfhjHLUfBg@mail.gmail.com>
Subject: Re: [PATCH 5/9] qapi: split intros at natural cutoff points for
 qga/qapi-schema.json
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, 
 Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Tue, Sep 22, 2026 at 10:53=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Note that these intro conversions introduce a new intro/details split
> > point. This new split point may or may not change the rendered output
> > depending on if any documentation is generated for this definition.
>
> Uh, we generate documentation for *all* definitions.

I meant ... generated from the definition itself and inserted. We
don't "generate" documentation for every doc block.

>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qga/qapi-schema.json | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index b592b14a011..19b0958b84e 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -401,8 +401,7 @@
> >
> >  ##
> >  # @guest-fsfreeze-status:
> > -#
> > -# Get guest fsfreeze state.
> > +#     Get guest fsfreeze state.
> >  #
> >  # .. note:: This may fail to properly report the current state as a
> >  #    result of some other guest processes having issued an fs
>
> This one does affect rendered docs: the auto-generated Returns moves
> from below the note to above, where it belongs.
>
> > @@ -925,9 +924,8 @@
> >
> >  ##
> >  # @GuestNVMeSmart:
> > -#
> > -# NVMe smart information, based on NVMe specification, section
> > -# <SMART / Health Information (Log Identifier 02h)>
> > +#     NVMe smart information, based on NVMe specification, section
> > +#     <SMART / Health Information (Log Identifier 02h)>
> >  #
> >  # TODO: document members briefly
> >  #
> > @@ -1816,8 +1814,7 @@
> >
> >  ##
> >  # @guest-get-load:
> > -#
> > -# Retrieve CPU process load information
> > +#     Retrieve CPU process load information
> >  #
> >  # .. note:: Windows does not have load average API, so QGA emulates it
> >  #    by calculating the average CPU usage in the last 1, 5, 15 minutes
>
> These don't.
>
> A possible commit message correction:
>
>   Note that these intro conversions introduce a new intro/details split
>   point. Only the first one affects the rendered output.

Sure.


