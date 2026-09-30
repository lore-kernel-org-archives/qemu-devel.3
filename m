Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681D6CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuyv-00079Q-G3; Wed, 30 Sep 2026 10:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBuyp-00078t-Rp
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBuyn-0001QL-Rc
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790777296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsXM6L2YhyUmsUZYqEZ4zdiIFt5coOEZCDGsrciV76k=;
 b=ePWlb+gDdh4WGCnorUkMIeE2VKiySpW1jucTGvMWa4bYi/Ra6c55mvqkQyQq2hq5fULpKY
 i4yqD1B9HjC+uyF7kXbe84CKnBbU42Xj2fn3wKQz2Wn0xmiBjec1Tl/gs9bMc2tnKSr8uA
 qN2hmI9Tt12aL5y+wbltTvhnAk28pag=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-50MRpfzHMwGWYfPaKPCMPQ-1; Wed, 30 Sep 2026 10:08:12 -0400
X-MC-Unique: 50MRpfzHMwGWYfPaKPCMPQ-1
X-Mimecast-MFC-AGG-ID: 50MRpfzHMwGWYfPaKPCMPQ_1790777291
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67139d2e528so7804543d50.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790777291; cv=none;
 d=google.com; s=arc-20260327;
 b=fTgPRkpm2KKvLGR8tSbZH5wkxdoMFkws239YPk0L2Ubf4dBVigPaYtyWvlm82yDGwx
 +T507LZXNMVvwcdUnX1XMPeKMdP6AyH1a79eo0wVJ+2b0F6rdyNcQ64AciGrPwQM8NFE
 7N2R2+OEZHqJzv+Ox8vnoKJF6sAnmf6u9Noc0poGUUj+mBYWNEv03CBgh+lcYjX5oSZX
 7ve0Hvi2KuNMheMD8EcKo1QqH0Mx2qIN3CrVvQyS6pppOo+zVysNl6z58AGDEihKwXUB
 Tf/FrjoxaCB3lT1nwt7YxIYnwu5bofvsYYKvCOJLhhcribn/7FmNgIvenGa9Q3gl0Gi3
 Vc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KsXM6L2YhyUmsUZYqEZ4zdiIFt5coOEZCDGsrciV76k=;
 fh=9fdqRXfOBOypzKvXtoydzTfP73jPiZvb0xAMRDNN+Ys=;
 b=ZNTx5JiFSXWF16HfBAHSSgsIej+gHIhpXpSvLBFMpd2puL1rr01sBnZXgsDYZB56GI
 7EO1kiSHEGdD/b+4U7dOWi8kVvLj+el3A/PyY33AEfVLGbQPVXMUR/B8MLxEeYYWRtba
 RFhBbjEo28GkFsu07LI/lcNj7w0p3lJTwIx5+/XeOHuYvlr8gMaISYaQAlQQk6IHAnvQ
 +J3ALGrdf2aRKWhUDytq64taJZFcvpyaZKnaJR8mtLvC9uEzSyJIQGO833h9wj6Us9Y8
 kw7Td4ujFAS97lYitw7LnzG4Gaq/yRJYhHGQL3GS/Ceu3Q8gauHqrkf3/HtZb4Ms73A2
 njww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790777291; x=1791382091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KsXM6L2YhyUmsUZYqEZ4zdiIFt5coOEZCDGsrciV76k=;
 b=NMfNj+OsviaJT5ZUi8KdZwuyPeMJUaIfYvn01G/6rZp4hNv3XeB4tiqSo747dhEnBL
 kT+Dmg2tVh9jX2ByB9HcEJnK0zTm+RM9QhwIACQDYWHXNcr0yk2Kz9GTeVvdHxRxgx3U
 6BDLWTFdxos34JPgktSz0/QCBEWvqOtmgQEOvGouncGUkuEU5ZkmVHGZx4blCdl4dUAj
 Pz9DnNWb7/sFY3Xv2XHnIHaiGhJsoWw2ePkIDunIkzIXdJZu7qgO/ICB57u3b9jrKutw
 aLZtSOLsORR3USbcHWUV8vavPbAUdl5XFfsyb4gue8W0m1s/c0sHqiq9kRhNilKpbKj4
 ZSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790777291; x=1791382091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KsXM6L2YhyUmsUZYqEZ4zdiIFt5coOEZCDGsrciV76k=;
 b=jt20C6HNLV5A26NjDI7GAOKLmzw/+zVbpAxb70niXjXgXuD8kj9YI0HR9yqrbHwry1
 hYh/kuWQNcegKD6Tacrv3WGpW51cvSvcoDMdUV9IsMyHNxkCF8eKB/dJ3UIgwKuyWCpq
 B5Q7YSwJuk9CNIqKLjJkaxl67XbotXyTLPndEFqXPxm1IvVBXorgBohDSzCUZjEbIhAH
 CRbEnSHjlFjjgRvMQjVSnuwCF9tWQ4JN8zRxUjm+UxpfVsqcU3GxpeJLvafpRIDONGPu
 OG+6KcLaVAQuqv+c6ehXEGqE8jSLhkSIWDM4ZNAymqAYsPxrJr02Oxpe2Gxal69dGBfv
 c8Kg==
X-Gm-Message-State: AFq9FYI2aI16IAHE+urUJbsNScwdZNSqfZpft+2y4CWxjV646QQKAVRj
 O9YOWueXWxNEmbek1wtixWfBJoyYb+bL+3NuYw1sZt10FjDxMlnfAhE6L/UN6Df/eRAXnYi570c
 hMx21sy9zgV752uoT7MZ7B5Z3p6Ork19vR2brBpIJnd/hElXaNMOrg28o4UG0ulrOH1k9n9aaj4
 aSL4+exFwCGLCi9XL5u7dwRgKUjJmczo8=
X-Gm-Gg: AYBFou00PyoYizQs8ytnSOzyGWzU8eoPY31LI7MU7KGP7sn+pvapAgutRfoW9OAHvFX
 6V+zTlEsBRaP5LADwQm+WbKuF9zW13JFOA/H4Fnbln/dgwpYLrtaldUDLg7dXZSbGdj9obw8MHv
 7jCALKoSwW6EHV5/aluPyW71/U6v8M7XvS0XCnCzXB5B4jKcnA5hfCML1iN1lB1rw7SVFwRg/IU
 LwdQkLp+ePxGUn+
X-Received: by 2002:a05:690e:2150:b0:674:1f9a:9e88 with SMTP id
 956f58d0204a3-6768351cc3amr645895d50.90.1790777291149; 
 Wed, 30 Sep 2026 07:08:11 -0700 (PDT)
X-Received: by 2002:a05:690e:2150:b0:674:1f9a:9e88 with SMTP id
 956f58d0204a3-6768351cc3amr645849d50.90.1790777290495; Wed, 30 Sep 2026
 07:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260929223044.2998391-1-jsnow@redhat.com>
 <87ik3nti0x.fsf@pond.sub.org>
In-Reply-To: <87ik3nti0x.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 30 Sep 2026 10:07:56 -0400
X-Gm-Features: AclHuK_ZoCZH32Wycc7rCWBDkD8a-J2Id0Tt4sE3rcP4FZD2Rmwmwm9R4rKHLlU
Message-ID: <CAFn=p-bpoMEVWeS=wexWcT7t7RBHyupFtKdMkqjUs0tKkSV8oA@mail.gmail.com>
Subject: Re: [PATCH] qapi: convert intro sections fixup
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Sep 30, 2026 at 1:39=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > "We" (Me, I, Myself) missed two last spots during bulk conversion of th=
e
> > intro section syntax.
> >
> > Some definitions are still intentionally left without an intro
> > section: BlockdevSnapshotSync is the only case I am presently aware
> > of.
>
> There are quite a few more, but BlockdevSnapshotSync is the only one
> followed by a plain section.
>
> > The remaining two were genuinely just missed; convert them now.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine-s390x.json |  4 ++--
> >  qapi/qom.json           | 14 +++++++-------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> > index 8d8cbe2fb75..9ae559bbc2d 100644
> > --- a/qapi/machine-s390x.json
> > +++ b/qapi/machine-s390x.json
> > @@ -150,8 +150,8 @@
> >
> >  ##
> >  # @DummyBootCertificates:
> > -#
> > -# Not used by QMP; hack to let us use BootCertificatesList internally.
> > +#     Not used by QMP; hack to let us use BootCertificatesList
> > +#     internally.
> >  #
> >  # Since: 11.2
> >  ##
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index e03ede34421..2d0d0e47fbb 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1039,13 +1039,13 @@
> >
> >  ##
> >  # @SevSnpGuestProperties:
> > -#
> > -# Properties for sev-snp-guest objects.  Most of these are direct
> > -# arguments for the KVM_SNP_* interfaces documented in the Linux
> > -# kernel source under
> > -# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
> > -# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
> > -# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
> > +#     Properties for sev-snp-guest objects.  Most of these are direct
> > +#     arguments for the KVM_SNP_* interfaces documented in the Linux
> > +#     kernel source under
> > +#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
> > +#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
> > +#     commands documented in the SEV-SNP Firmware ABI Specification
> > +#     (Rev 0.9).
> >  #
> >  # More usage information is also available in the QEMU source tree
> >  # under docs/amd-memory-encryption.
>
> Hmm, shouldn't we split this one?

With fresh eyes in the morning, yes. I was thinking this was dev info
at the time, but I see now it's *usage* info, so... yes. Hang on.


