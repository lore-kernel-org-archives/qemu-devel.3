Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0549CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeJb-0004eS-At; Tue, 13 Oct 2026 11:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGeJX-0004dx-OO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGeJV-0001hT-3r
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791904871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iw0msJZcqsJB/r+u+/gjGJBTHk2Bao323p5IUYaoW08=;
 b=LaG/rcAjVaat1eU9T2Ooo8aLuqWfKb7cSaJv5qKM4KCJuyWu9svruhDMidoJWn9TL+yQlf
 32VwYzXyUx1wDuhj4kswqEMeVA46nSvllloeDvNNXlNs45TvYso3LwGVJs0emc5k87aEDM
 arXhRjmzX6QGz/YS9PhBQj1GiPMN5+I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-u1jKdOoWN9q1wVy8I--tLQ-1; Tue, 13 Oct 2026 15:21:09 +0000
X-MC-Unique: u1jKdOoWN9q1wVy8I--tLQ-1
X-Mimecast-MFC-AGG-ID: u1jKdOoWN9q1wVy8I--tLQ_1791904869
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac54ecd5f0so398402a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791904869; cv=none;
 d=google.com; s=arc-20260327;
 b=Sizyowlp9gfXB0RQWH1Z+9zyf+UyHObyN+Fq/fw2pC9rKmQ4cXOPueo2Rnrd42YHa2
 SJyYIwvO8ONrU7W+JpWyhIYxU8URdQlspBXHNxMx1tgbKt8ugOxCf8ccAFuCgigcFPbv
 ILJphgFTx6xBBJL+5GWPoL+7oixyaMJYloZyyqaXSeV5GAeiglBMmhaK3Ys9ldDvLCPn
 UsSIdFsmFjFvQ1AJ1UH8xp1AOmJqynRRBuEY6KoFEu/XYAdixOBt4JNLX5AVnaZJgXeO
 Ec8C6pB2MJk8tsCcDSKvNLxFCRojtOIHoGyU8oBPkV+kKmXM9NQuvH6t0oZnjTaklTi2
 G6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Iw0msJZcqsJB/r+u+/gjGJBTHk2Bao323p5IUYaoW08=;
 fh=lW8xzSdEwaBIy9TNvG7wkGxSxV7QyaPtYtghnU5h7Fs=;
 b=fi+5VCmtZ3NRiJPHGK4VptaElrVN0aSLQHkx2vOc7EyJiFNlF3ndxfQUSOTNtpwzVk
 LOcwgrRD4FSDLJ/ZGJBy2yW+kRhOCefzyVH7Vu5xncVeJW+OJLW0HVaRDy7Kbk5EATeQ
 g8RP2fKitPOPLzEXIuF7ojC/8F9fkkOsiocfXmu/XYDkQ4pUF0yFjO7vlvDk4ClugEPI
 a1oRGJTnz94IURRhOMVHzHxPo2sfBVpubU0tODI8euc5O3E81JgvFM1qKdc6/KKSMyW7
 fKBndNKoQ4KfxdJ4XQN1he0QUvjggW6zSYgcefTAWeBTw61dSiI3e83NcmGZWd5/CcWu
 LahA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791904869; x=1792509669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iw0msJZcqsJB/r+u+/gjGJBTHk2Bao323p5IUYaoW08=;
 b=Q+ExdwnN6DoUL85wluc3wZF2qxtjurz6seVJsopFJA0GEq7UcLlfz2v5HPGFl/zd/F
 9X3ze1xLHCY0QBr8pEA8g/6ugmVMmSlwDR4ZPKtRI/JdaRViM7GvRphngEbAfhng/OC6
 EDIJ8n3OHHv3CrC8S9h/SOrYCVBB2bOsYW4MYBCzEXq0d18LC5yWGlcgPYt2XkRkOXYX
 qkWlMDLTOmZgn+YQ1vNDnqyr3uulDGL0zIYznygkLGgpU0QpMdTEeB0t27dyD/3QNEuT
 kCGoYmJtAER6rrx+AQOvQATzL0rASn/JXRPGvzUvGz5sdFp2UUeHktBJwV1nrB9w17lL
 RODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904869; x=1792509669;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iw0msJZcqsJB/r+u+/gjGJBTHk2Bao323p5IUYaoW08=;
 b=cXiU7HjJGCwbEdVIvgwoXtnkazBjrCNi1h9JEJHGJOTEtQ5Ti1r/UynTqtCJHljHgr
 2GVliBEqYCzKAnd0mOKzpCbq7kMxrf8F68OEe63RKIfJtwOMtxeCbmcKZjKyPouNf3Wd
 q21ISYgN+fNtHFO3cWlJfGUCsqD3/IW8uiMIzBRwmI9kEjHHLt60TKNb1eGsl/JDavZc
 CSYKG0tkBSkaGPbYftYnDwgkL8Jby05JT8sUEp51KtXdwo5JsdzYJc+52grudOvZt7nO
 OB+KJPK7WtSqgXUHGrVAZrKvpaxnZdXojk2GTR3tgEPEd4UrR4G+rrNSxFOjB+VfPJht
 Tz1w==
X-Gm-Message-State: AFq9FYIVXadHeyqb4CHx0OAHOGYcqdjc8TojBbvcA7Jm8EyWpyo3L4tA
 1HS3Unzy/NO+tuVJedIDxnbcBhkJqNJJyF0r9IyzWtxEi5Pd6yIggNi2tUgW4mtozJLHYMLOKUP
 SJ7VebPXEJ1TFdw61oknYHBej6R4HeC5BQbF7Zub4JMQk9HA6g1vhULvV/KYSp06kV0MAjETBXL
 1kdVeq6hvlHaPvHbw+NOYAQGi780wB5Og=
X-Gm-Gg: AYBFou1aX+3vEPpcWsLN3whcO6/llk6Qmgsqoyg+Ozlzu7OSklNfjZe+e0umLgi4vva
 jX9s11kHDlZJ3C4rpnqy7651lp/XzmN8FGxwhFPcfDGquwqKvwr7DLWzpIs7jJU5Un/YfLHKw3v
 Uvc3nMoW27m7n/+LCVRGZ2cI6jWq0NdP8HOMwozMwncjWfJcJMrzC5OhL/RZms0c0kwqJgxKo0Z
 SheQBQXFfxfsNPn71QJGDAg85VmEeIqvFEZJ/fLRwXZRvRVV8HFl6QTQjPbZcXaV5IiyzYywKtr
 Pg==
X-Received: by 2002:a17:90b:2d86:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ab3a33d959mr11529388a91.4.1791904867510; 
 Tue, 13 Oct 2026 08:21:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2d86:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ab3a33d959mr11529270a91.4.1791904865192; Tue, 13 Oct 2026
 08:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261009140431.3175479-1-armbru@redhat.com>
 <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
 <871p9tya83.fsf@pond.sub.org>
In-Reply-To: <871p9tya83.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 19:20:52 +0400
X-Gm-Features: AclHuK8kn9AAtdSQG2Nyyk4XKPrphiIdIQhmqrf5gHdmtFh9gi2Jiwmn15e-b00
Message-ID: <CAMxuvaxyrOtn5uXuWSuRL4KUTyAVZFAinniG-YZQfo4_ngizrA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] qapi: Preliminary work for better QOM
 introspection
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Oct 13, 2026 at 5:57=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi Markus
> >
> > On Fri, Oct 9, 2026 at 6:05=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau has patches to improve QOM introspection.  Late=
st
> >> version is
> >>
> >>     Subject: [PATCH v5 00/62] qom/qdev: associate properties with QAPI=
 schema types
> >>     Date: Fri, 11 Sep 2026 20:34:34 +0400
> >>     Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
> >>     https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a55b=
7760@redhat.com/
> >>
> >> The first few patches make the QAPI code generator emit type
> >> information for use by QOM introspection commands.  They refactor code
> >> to gain access to masked type names, and to make query-qmp-schema not
> >> elide types QOM introspection might want to refer to.
> >>
> >> My series does this in a different way I find simpler.  It is RFC
> >> because merging it only makes sense if Marc-Andr=C3=A9 finds it useful=
.
> >> Marc-Andr=C3=A9, please have a look.
> >
> > This is essentially doing the same introspection changes but at a
> > different level. If you ask me, since it's essentially code cleanup at
> > this point, I would rather merge my changes first and iterate on top.
> > But you are the gate keeper, so I wouldn't hold it, we need to move
> > on... I can rebase on top of your refactoring if you prefer.
>
> A rebase gives me a cleaner git history, which I like.  Asking you to do
> it feels a bit unfair, so I did it:
>
>     https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qom-props-qapi=
-types-v5-rebased

Awesome, I am happy with that! If you want to resubmit on ML or send
PR, up to you

I think the only local change I had (with the collected review
trailers), was BootCertificatesList conversion. But that can be a
follow up.

>
> I had to change "qapi: add type-infos generator" quite a bit (commit
> 465ae98da2).  Slightly simpler now.
>t

ok

> I resolved a rebase conflict in "qom: convert scalar properties to
> QAPI-aware registration".
>
> I dropped "qapi: expose integer signedness and width in introspection"
> because I don't agree with it, and couldn't be bothered to resolve the
> conflict (iirc).
>

Ok, let's discuss this separately

> I dropped "qapi: select introspectable types directly", because it's not
> needed anymore.
>


