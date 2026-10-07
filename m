Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6582CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWn4-0007D4-CV; Wed, 07 Oct 2026 14:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWn1-0007Cp-Va
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWn0-0003H7-Bq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791399293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkNYxRHQdnxLuv0WMLeqPWCzytTTLeXrxrp3NIqVDw4=;
 b=I+7EmDfBeQ3LTFPhGQaBCMvj/7/9QCC4c4VEpL8Q+FVqgubmUnhTiNRhWlqSC5+lMNg054
 21xyKn7ZwDWQiSqaMEkIWeUbMsdhMoahmLriHnOu642MLAubm1cqpi6+Psus9yWmJELjN4
 0GeO3R1UWHwSPW8DavWlGXu+keyxCi4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-HumtCnrAMxqk5yGGXVMJ6w-1; Wed, 07 Oct 2026 14:54:52 -0400
X-MC-Unique: HumtCnrAMxqk5yGGXVMJ6w-1
X-Mimecast-MFC-AGG-ID: HumtCnrAMxqk5yGGXVMJ6w_1791399292
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8881abf79a4so63465337b3.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791399292; cv=none;
 d=google.com; s=arc-20260327;
 b=hcd+5qCv9A0hDFFL0XtpuXiHincAnM+3Bldwdbk9RggSEI7Ex47/KKpVkP4h3jRi5i
 9BZ9Rd9vaXLVKUDmRixrnAQCMc3wnenME9SnEUxWysHlo9l7gxU5nK6n+b9JHtfctZnO
 Im+9FOJRtVo7YSaWt9qxSwgsi7PexqNLasr+kLWPj/r9hVw8Ps0gir4Ti6CTlaLgbZlu
 erv5tXddmlol4R+byKOx/NfAPsm1y8AjfCCl06PWF4miZFfV3T6wTGKd/fyD1Er6ps61
 6CB0Wr0R6V6kHHAIxEhE0LBUYi58xJf3KGHexUzT54V2tjxRexlj2tyRJNOGsi6+9fhQ
 ox/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UkNYxRHQdnxLuv0WMLeqPWCzytTTLeXrxrp3NIqVDw4=;
 fh=9fdqRXfOBOypzKvXtoydzTfP73jPiZvb0xAMRDNN+Ys=;
 b=b399ovQ9lxOh1wc8oiiMFq4467ulsCXbmQQh01izPebl/VMwR5Yi/amkH/Hu8/bumP
 NL6+6eTCHncpnxI2c3y+JZpW1TiSBh7BvlI88ejWGgSsGy/By8yrcy7wxuWU/4c19WEm
 7EZXKJ7LBkn1o3QZNTGPHNnThIg5TCNGkOeoCsgxKn5JkpNkKrOzO8RjAssLOZFZRKZK
 EEUJGhZtt7TdnBbwUBXKFZIMm8f/E1sAfgm+Incv/6w3fDiMSXoTC379ySke3F7MWCMK
 NkX7198skjSSAiM4jjiEm+M7LEVAz2XDulfNT8reepwDRxcmtVnVFVIXOYReGhB7SeXX
 Oxkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791399292; x=1792004092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UkNYxRHQdnxLuv0WMLeqPWCzytTTLeXrxrp3NIqVDw4=;
 b=qoJBsM5xAYaqPfXAnHOTtn0ku33mQnSA2vYiuRQ448jN+t5RsNyALIQHRcXvPSXUnM
 unhKQgbEIIb/QStmNinq6YW7kmSPOjMSoMpc6oDGf93rnoF4NKT5jplQbwsQTyf6AONY
 NE7JTPrAncH7+FlXrhzgVrLXCZPKxOupBIf/gCp/LL/k7vhpr+v4eJyj6AjG6NGvKPxL
 BZwfumrKF8HpxuoZqnHYgVCI5ARF4SVMInQB0XLfjIPbs5jb0isewVLLY0Jxaqmg7J/B
 3R9UK8CP1gocuhqk9Z7ylGpGTRst6ClA12F9uH4EMWwGycDbcfB1lgO2fUl7iY3PD18W
 rO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791399292; x=1792004092;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UkNYxRHQdnxLuv0WMLeqPWCzytTTLeXrxrp3NIqVDw4=;
 b=SegYi6rNKF0WmiPUCS4HMDEU/C+rtegFdDJhhsUxgSS0IUPrFiFi2inn+998YG/Kjl
 S9PnaGljwpRrOGiOusSd2JyR/beljp3Xh18MQpWezkrVVi0fleYPJETNz2kT+nTbr/jZ
 L2A+GCIO6Rh8YagXUe5Z/E5aIAxyV6JvuNo8nHzZQF5f4oVfXzdAOG278HfmOFKFBzur
 w1vNPunvQrXOz4F6KnUhaZURZt8fEFWBtqKu6ozcegcK3YPIqtUHkZlklOwuRsQENe+k
 TJXTrnTDYKopQab+/TLOBefk8JfqfV/+aMjrkZgbQJIVWFUJgDwzmuuWqvUYq8ItXr5z
 ilQg==
X-Gm-Message-State: AFq9FYK8pB8OC1W4uVO3ooWngc1h8wxEFQSmrlaQcIylgWBLCQcCNEw5
 9BCGj1XPP8dAGhfCykQu87848Z0wiprNqI5olviuBfbIi8o+YvhNXuyEhDzjdyWh6apD5JXUuqa
 /EBTZMrIN9j7Fc/2baL2cVkuoTcjltrCJ2PfitD1SyCxZDs9p1uTlr5cmTXXSGdU73wbUXWCIxL
 /pmtWEIu+QvU85z9AGQg1vGoRq06fT+Oc=
X-Gm-Gg: AYBFou0ZloYEKcsFn+3J5wkLvrkJZj+QR+bR1UpTa9MTxKdfSAcfrCssfYG+QvakHIB
 x95TrTRfpgcUgrsGrUVWmOClmNG+O2humGTm1ylbh7DIPGpYKDnag+02Jwy84QJRUL4MQ+tYDQH
 +ZYAHf2IdOIDNzb2Mq4LHdKot2bvoL/ZIv+l0yy8muZLb7mnajsMgcp+LqmYtpncycFEGxUPF28
 1fqKbcEcreZEqk3
X-Received: by 2002:a05:690e:bc7:b0:677:c92c:52f0 with SMTP id
 956f58d0204a3-67909f0c4d8mr2050396d50.15.1791399291421; 
 Wed, 07 Oct 2026 11:54:51 -0700 (PDT)
X-Received: by 2002:a05:690e:bc7:b0:677:c92c:52f0 with SMTP id
 956f58d0204a3-67909f0c4d8mr2050383d50.15.1791399290976; Wed, 07 Oct 2026
 11:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260929223044.2998391-1-jsnow@redhat.com>
 <87ik3nti0x.fsf@pond.sub.org>
In-Reply-To: <87ik3nti0x.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 7 Oct 2026 14:54:39 -0400
X-Gm-Features: AclHuK9aYezqbUXUiBej5xQXey8rXYFm318wzCDA3hkPn1fn2KF40u-ZGtjB8rg
Message-ID: <CAFn=p-Yoa5pEgVAj_BqiBeACppadzgBBgVTUtq0EquOoWc6u8w@mail.gmail.com>
Subject: Re: [PATCH] qapi: convert intro sections fixup
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Looping back to stuff that got missed:

Split how? I think I have to rephrase this a bit, because when it gets
inlined, it (might) be lacking the context of what specifically it
refers to, i.e. "Most of these" might become ambiguous.


