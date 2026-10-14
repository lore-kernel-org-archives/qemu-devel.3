Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8640CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGzfm-0001CR-7X; Wed, 14 Oct 2026 10:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGzfl-0001CC-5b
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xGzfj-0000Io-A2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791986972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFXJG+1wr2MTAZU9FZY8DwGyyvO73fG/hqyLo/72K9U=;
 b=P0APich6IvwfCCUpoyds+4dwfagUwpx+ulWHwBU7Ejx7+HQOWJc8wEDZ5YSw9wU3ouhUoC
 +rWhDj0eDEFFBQbyaUTIIIr9rL0GQlbCBDPZZEmc7qj0nNDVsEzHom6W/apBUZm5zxPYyl
 oZ63wM692espPN4qg4vdMvLtDZeLwc4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-8vTRau3hMUu3LdmTv3PZ8w-1; Wed, 14 Oct 2026 14:09:31 +0000
X-MC-Unique: 8vTRau3hMUu3LdmTv3PZ8w-1
X-Mimecast-MFC-AGG-ID: 8vTRau3hMUu3LdmTv3PZ8w_1791986970
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so5226248a91.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 07:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791986970; cv=none;
 d=google.com; s=arc-20260327;
 b=nApkKfhYmUoUdEep8wqxmw19nX93xp8K6S7JV5j6IvLeYlPhqXpbRg5ky7Wh3HKQCV
 4j0AcPsNgb6+vkE1jdDKP4XYm+zPwKDRTRJRXm9Y0yTqUnwQOD5Vf+IAyufD7WDFTHTQ
 Gj78x79N5MnCqdWZIPTV4sdp8QpjcJykYzG//SmCUs8iJ2Tj2F/209bmeHgZuAAeKYl4
 JLDcPncbRbl0OHNcqPt8YScI88O5z+X/AagnO+I/hHHEOGg2/2EoOIGWXt1wncU4HoJ/
 vllj8RF92pyHedKsky8SftK159FUHGJ51/DFgBDajTpRH48BT4EfIiKeWaAwaH2jBCTV
 D+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KFXJG+1wr2MTAZU9FZY8DwGyyvO73fG/hqyLo/72K9U=;
 fh=lW8xzSdEwaBIy9TNvG7wkGxSxV7QyaPtYtghnU5h7Fs=;
 b=J5IWgFpLEConEpL6tiCrq+K3BBwdDBWta11Kh+WoFiolG5YSjqvyN25Hu1pGFudenD
 coXP+0OOcKFZX+zD5P59SYj5E8f0SpSYYnfec6KHVfUCGMAtb+K5jcocrXkFH9TTp9MX
 Ak8ljx5em7/NJrY6S4BdV6DncHgHDfhi2beXa6cvM8vAMjKheDhWgxTDD3FqZmtDwnBX
 T17LS2eRvjnQ7qveh6mJfvDv8hzGm708Uy1lXD8AkFpTCg7BlW42PNEBzChBeIwgEKfk
 EIbQ+DMEtq6dzJx950S+R4gJpYVVZ6e1JKGjF0xvAh1Db3oC0OCn5yzap2ePebRT+IpC
 LtXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791986970; x=1792591770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KFXJG+1wr2MTAZU9FZY8DwGyyvO73fG/hqyLo/72K9U=;
 b=X4kzTPl7per/++r8AZzyakcvDa2T5Km9opOSg7I2mk3SXj6AuiBMf1d//CxTgtQ+II
 Q1m8xYyfpjXlO4ccmMpFoIALdgtvDHG7+1Zzv23q+Qx7N6+1HzxyGk1FBQ8wu+gdHI9G
 ARwbenuHMHy0PAA0hHPClZ/ODPqF9o0Jd1OmLvWMSSsfJvxFN0jZJ5QPZfOEelDlr36X
 tXPExQe0sUJaYziXgCxS9iPeEOsv4TYpaZgtnQHbSZGOuUdpdZPtEQWaHGyAFln0Gyoc
 eiu6TMcok6kCij1LJ+xVMz6WHexYggHz+/Jwg1KaAENFW7xJYVCrlc2tTTBug6E01esS
 NvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986970; x=1792591770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KFXJG+1wr2MTAZU9FZY8DwGyyvO73fG/hqyLo/72K9U=;
 b=gCtYSUwUF7mABX3I35EByCBk0kuN92UDUEorE3h9wVD/F6ZpY9ttmDZxgi+OzGcO0w
 VSL3A2fG6vn3As7LRya7oGvdU0LxZHiPqJ3i/H1YAYto/PnIUMsd6/FLhFlhLPYJB9Eb
 YipS5we8/0Jzvmjt/P5G5S3rpJM0EtQWt3sZ22G7Vrn/Y8CIVqD1SjPZHcxw8mIeUEEe
 atatnR5mrSKi+1GJxiBDawmdYAElLLJk6SkuqSxCAb3LX7MxPbobVi0Dzhyx47obGK35
 1DSVhkBtpu7FcfBx5Mt2k5xAMRz0bZyVBX+sxoDyv0Ab2aJ8azeZHwRLkqhtogfRTuMm
 uMDA==
X-Gm-Message-State: AFq9FYIKmJq4EOjk0ZURB3AifQHFbbs02d40QZJ+s3u3hRMYs6X3qe7B
 ZbTNp8PFkVMhlGk35udYG8OXE6yZmHw3Q7kM10wQqp3GhTXIsNiv2qhlNtNZX/t4Qp+lUcoRuuX
 exBkOFV7pjiVU0uKTphmxEibaBATrUUyw2491KSXHA+Bt3hDmNPJkHTjQBFcL8O67UTd/VCzGR8
 XMNaVSxhsnRf6Fnq0Yvx1HWY3PHkEiqJQ=
X-Gm-Gg: AYBFou2AB/VHmhTL8uvrlIWx4rPA4ol/OF/g3716Ru/pbLtiTTfC3BVw9/gJ94z1aR8
 MgaV2HiMticeKYV7pe6vJMNbD0RLbwskRITi14W6tYEbGmiSKuZG183d4veJCGRDyjUmLj2AuQ7
 FzsTtHTNHTLV0xc+0jLRYuE1sedQyWRraoC9H2luEL3m0H21eaBYSL0AyZHhiEk0EnidSeTsjp9
 9ki6sZbN63KMKqklSmRP+UOXeVqOKb2KA8qv4aEVAvI2Mr3VVEqPT/n0ShcXyCm5MpUrCf5a/vg
 Mw==
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3abbe66e034mr8794904a91.20.1791986969868; 
 Wed, 14 Oct 2026 07:09:29 -0700 (PDT)
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3abbe66e034mr8794870a91.20.1791986969350; Wed, 14 Oct 2026
 07:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261009140431.3175479-1-armbru@redhat.com>
 <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
 <871p9tya83.fsf@pond.sub.org>
 <CAMxuvaxyrOtn5uXuWSuRL4KUTyAVZFAinniG-YZQfo4_ngizrA@mail.gmail.com>
 <87o6cwu816.fsf@pond.sub.org>
In-Reply-To: <87o6cwu816.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 14 Oct 2026 18:09:17 +0400
X-Gm-Features: AclHuK9LX3huAOuIJsZKSJ97H0R35VvYUZiFynztTLHfwjE1ZvIolaefy8G1Gsg
Message-ID: <CAMxuvay1K9gS8xRc_bH1f28txFZXAt9hjH7O4uQZtzffs8fJHA@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 10:10=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi
> >
> > On Tue, Oct 13, 2026 at 5:57=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Hi Markus
> >> >
> >> > On Fri, Oct 9, 2026 at 6:05=E2=80=AFPM Markus Armbruster <armbru@red=
hat.com> wrote:
> >> >>
> >> >> Marc-Andr=C3=A9 Lureau has patches to improve QOM introspection.  L=
atest
> >> >> version is
> >> >>
> >> >>     Subject: [PATCH v5 00/62] qom/qdev: associate properties with Q=
API schema types
> >> >>     Date: Fri, 11 Sep 2026 20:34:34 +0400
> >> >>     Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
> >> >>     https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a=
55b7760@redhat.com/
> >> >>
> >> >> The first few patches make the QAPI code generator emit type
> >> >> information for use by QOM introspection commands.  They refactor c=
ode
> >> >> to gain access to masked type names, and to make query-qmp-schema n=
ot
> >> >> elide types QOM introspection might want to refer to.
> >> >>
> >> >> My series does this in a different way I find simpler.  It is RFC
> >> >> because merging it only makes sense if Marc-Andr=C3=A9 finds it use=
ful.
> >> >> Marc-Andr=C3=A9, please have a look.
> >> >
> >> > This is essentially doing the same introspection changes but at a
> >> > different level. If you ask me, since it's essentially code cleanup =
at
> >> > this point, I would rather merge my changes first and iterate on top=
.
> >> > But you are the gate keeper, so I wouldn't hold it, we need to move
> >> > on... I can rebase on top of your refactoring if you prefer.
> >>
> >> A rebase gives me a cleaner git history, which I like.  Asking you to =
do
> >> it feels a bit unfair, so I did it:
> >>
> >>     https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qom-props-q=
api-types-v5-rebased
> >
> > Awesome, I am happy with that! If you want to resubmit on ML or send
> > PR, up to you
>
> Great!
>
> I'd like to have a closer look at a few more patches.  They look
> harmless at a glance.
>
> > I think the only local change I had (with the collected review
> > trailers), was BootCertificatesList conversion. But that can be a
> > follow up.
>
> Happy to squash it in, feel free to send me a delta, a revised patch, or
> something to git-fetch.

commit ed3c302c506fc9de30a540f7ed8274e82baa295c
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Wed Sep 23 14:32:43 2026 +0400

    hw/s390x: convert BootCertificatesList to QAPI-aware registration

    Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 9ca3b14442e1..97e122e3e7db 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -44,6 +44,7 @@
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-type-infos-machine-s390x.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
@@ -918,8 +919,10 @@ static void ccw_machine_class_init(ObjectClass
*oc, const void *data)
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");

-    object_class_property_add(oc, "boot-certs", "BootCertificatesList",
-                              machine_get_boot_certs,
machine_set_boot_certs, NULL, NULL);
+    object_class_property_add_qapi(oc, "boot-certs",
+                                   &BootCertificatesList_type_info,
+                                   machine_get_boot_certs,
+                                   machine_set_boot_certs, NULL, NULL);
     object_class_property_set_description(oc, "boot-certs",
             "provide paths to a directory and/or a certificate file
for secure boot");

>
> There's also a temporary test breakage in PATCH 15.  Could you have a
> look?

It needs a temporary non-QAPI local enum fixes, to set masked_name to
some value.

Or simply rebase "hw/gpio/pca955x: use QAPI enums" & "hw/i386: convert
PCSouthBridgeOption to QAPI enum" before that patch.


