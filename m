Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B38FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3I7-0004WA-RK; Thu, 21 May 2026 09:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wQ3Hl-000465-GZ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1wQ3Hg-0008T5-Py
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779369468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQ/da3HOqjr5tcU2boocE3eWEwOGpppTDaQK0l87NXs=;
 b=ijRrzMFXSIk8i6bZFmgdZXGw1ADN0FoQ5PkoGglLrboGd6eN13vV7vpXWNP8vwdX7XnFnR
 XUmsfl2amLLeU51Tp7IlHiIVeISPHbc7MLZPA86Bd9e7ZQqzQ3jJw74B7i9DGApZwML3v1
 8aHLmOvRFn6Afs8sNV6H3r0ueQQjQAE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-xh1qRToiNI2KDbZ-Rymczw-1; Thu, 21 May 2026 09:17:46 -0400
X-MC-Unique: xh1qRToiNI2KDbZ-Rymczw-1
X-Mimecast-MFC-AGG-ID: xh1qRToiNI2KDbZ-Rymczw_1779369465
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-366015bca9bso5400177a91.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369465; cv=none;
 d=google.com; s=arc-20240605;
 b=lTp+LCvfqgPIyHX+nyFLIQuQ8H/huEujR2PNaBvrHz0WCIYAMy8DqyFd4PORMacRrc
 T1S6JkEUUuEF5oWbXSqN4b1hkKsfuZopHZr4qrkWJp4YWDtYuLNuPbVAXPaidjIhyXVL
 krVq4g53JVuUS1ywi6CK3YIs0Yuri3FFHj228c0HVYft4OtU2iJwLYW38+1sg/YG/Dgs
 mEyDJBksVKk1lkfCFOGPElCd2Fc54N1iHJcyXWJ1c4HRqe5QBIhXzwNPirPwiyJhJPwS
 s+v6+bLVRFO1MqC+U+Hmro7k/0+CtVP29eH9Lwg6nzLp3Q8yAyq2OXcJddcVbfYDr7+l
 Y+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CQ/da3HOqjr5tcU2boocE3eWEwOGpppTDaQK0l87NXs=;
 fh=khkGOyJySAcmMkOtlfvQfon0uhwEX933lgMavWf+zPw=;
 b=iw+Urk7hJFISohx8SIKFF4M+JsUClFdufnvcnXdAsRbqohFgvwYEFkc8esBTCyEqis
 T486phI4vNLXt0NmxQ0BsbChx/oAjxUihFYKfOrO2kp/inLdDjvE+ShBGs4kooXe8RsQ
 vgWptXnOgMlJLSl/vg67RnCJ2npyvqYHI0jCn6bnLfCazPo0GLNRjnn2aQnBLKOKAJir
 5TDd3cHiGK9d4NN0rZ0bZB4jwgvhaFM3nxEYhkefoKm/CCCrFYHvr9doUWFh7u913A3l
 WZy5K1S30D7E5y+SClmpcd+zhmRBXKqGdJCOHTdTOhgvwd3NiEk/HfnDZAl7z1ZR9X0K
 nLIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779369465; x=1779974265; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ/da3HOqjr5tcU2boocE3eWEwOGpppTDaQK0l87NXs=;
 b=pKNNUg5uhg1L1FU/xfjYTSaMUIzSlcq8S/WT+6FyrmCEYmWxW83kapvhdJz376rbBk
 QErThqYLL830+FzjYC7W++AlYHV2V91l7T5KOklJK9ksERHVep+3+Lx/xoKbZDU4Rwi+
 B2iclD3CUJfM/oLOZd/eiW9tDhghc0DohWeb0uo86zwDF7ujOx/mL196epeXK2OWa2Iz
 fYybItVr2Widpicujq7gh/z8W+44WX3CmFAE0VVSzBuMFCEKjk7auWSSaGDaZCkHStoD
 IlvlPgUIPFbkuCTimxcsq2YnzS79SiSN3S+ef8/vAqiZalcFSXgKrNFZ2RIsEGjGzY7b
 ZDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369465; x=1779974265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQ/da3HOqjr5tcU2boocE3eWEwOGpppTDaQK0l87NXs=;
 b=ljXZNcqT2l0jNgcRWRk+iESBcRSAk9wJPXaGvKEkNbeuU6ogqxaWBdqpZfSISGEXbC
 6VmNzPTf1BrrRYpHMi+tw9WY14reSmK3u8hhPhbpcoq4Bxk4XsNm79TV5JEzPuBFeHFi
 QaCfx2PX04vtdUV4Oe3oK1tNblnBLUJnxhnWiV09pION0Kog7So7UbfELzWO0eXdXYMN
 WIrtnzpgVxOPm5YaX1wZwH/2zbpdawYUHnfK+aOL6JKl9wWYK9HHpChhwU4DIg8O7yI1
 vKCVozaanTbwSr+ZLXhf4aOvGQThpdU6+liMWraGJzkkTrgdp+j0lTmkUP+hwBr4RpR0
 PAmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jDxlpXZ73BwqjvV4DwMFmhSKjScDNx0gMpEvxkI1Ox20UkLhnhgL4jOZ/eDbrnmOPmrpr9hmfwDz6@nongnu.org
X-Gm-Message-State: AOJu0Yym92E1EJgAzFonqsXlut0CgNYT0tL5Ud8vhwyPkLFvxag8Sbgh
 IO2tU0vDpm6+jG/GlLTYmuhLhBzs4EUHVWZYFh+F9CozgJZB4vvRpMY1Ra+NnSqSNc9+C4meMqP
 AB0AKrfR3c1cINYsnqEdUHNa1IvElc8+xUHId+9FVu3zdvipBmAGkTuxGhMXvWfa1ChthPDFaj9
 r96h6nkT5EuoH8czfZSvgMXeWPGzFajec=
X-Gm-Gg: Acq92OEi7Z42oibiNL2AXY2Wb8JN9gsKByrwkJByzB1q3aAKR6ruVFyMamgWBQvlaVX
 n6rO0wdrAVdpHcGkdSynS94O3kHvGrWHWvKS7IURrwlD+ojc6B6MT9hTyLOAV7vLrt680cjSgBV
 dVttfhVu4u1XV4/z55WxJIzuitPUG47HS0onfUcDWInh6T3vSmeZlur4GhweYWFanT4YqiXct5U
 TcR
X-Received: by 2002:a17:90b:4b85:b0:368:65d1:893 with SMTP id
 98e67ed59e1d1-36a475e08a0mr2486490a91.5.1779369465039; 
 Thu, 21 May 2026 06:17:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4b85:b0:368:65d1:893 with SMTP id
 98e67ed59e1d1-36a475e08a0mr2486456a91.5.1779369464499; Thu, 21 May 2026
 06:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
 <ag3OopKwGVUjSrrV@redhat.com>
 <e7f1fd11-774d-4610-8cca-a434f508e472@oss.qualcomm.com>
 <ag3xwssG6KZecv0o@redhat.com> <20260520191235-mutt-send-email-mst@kernel.org>
 <CAA8xKjWoMYBPedC5RP96=TOe2MzDwtsmBHFW=0Bq170YNsR9DQ@mail.gmail.com>
 <ag8DbJqLzvTlJRIe@redhat.com>
In-Reply-To: <ag8DbJqLzvTlJRIe@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 21 May 2026 15:17:33 +0200
X-Gm-Features: AVHnY4LAQnZ0bmHVA7KsCLnuv6GmBlAgfLfXGObSBT4ZDWF4WPGCnLghEtRhKwk
Message-ID: <CAA8xKjWmoGkNnNvazuw43H6gLYF-F2N+2q-969At5wkFsSNYqA@mail.gmail.com>
Subject: Re: RFC: GitLab issues for security disclosures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Pedro Sampaio <psampaio@redhat.com>, 
 Yogesh Mittal <ymittal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

On Thu, May 21, 2026 at 3:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, May 21, 2026 at 02:45:08PM +0200, Mauro Matteo Cascella wrote:
> > On Thu, May 21, 2026 at 1:14=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > > something I was unaware of previously, is that gitlab is a CNA:
> > > https://about.gitlab.com/security/cve/
> > >
> > > so using gitlab issues means assigning CVE #s should be super easy.
> >
> > Red Hat is a CNA too, QEMU CVEs are currently being reserved by Red Hat=
.
> >
> > In fact, Red Hat is a root CNA:
> > https://www.cve.org/Media/News/item/blog/2023/01/10/Why-Red-Hat-Became-=
Root
> >
> > Projects like glibc, postgresql and curl now operate as independent
> > CNAs under Red Hat, retaining complete end-to-end ownership over CVE
> > assignment. Is it time for QEMU to follow suit?
>
> Is there any guidance on the process & implications of taking that
> route, specifically as an OSS project ?
>
> I've found this:
>
>   https://github.com/ossf/wg-vulnerability-disclosures/blob/main/docs/gui=
des/becoming-a-cna-as-an-open-source-org-or-project.md
>
> And there are obligations/requirements there which I would not be
> very comfortable with agreeing to with my QEMU hat on.
>
>  * CNA must provide a phone number for the primary POC.
>
> I'm guessing the phone number is intended for someone/org to escalate
> urgent issues ?
>
> Related to this I see
>
>  * CNA either should or must publish CVE Records within 24 hours
>    of publication of a CVE ID.
>
> and similarly in
>
>   https://www.cve.org/ResourcesSupport/AllResources/CNARules#section_2_su=
b_cnas
>
>    "3.2.2.2 The administrative POC MUST include both email
>     addresses and phone numbers and MAY include additional
>     contact methods."
>
>    "3.2.2.5 The administrative POC MUST respond in a timely manner.
>     Automated responses do not qualify as =E2=80=9Ca timely manner.=E2=80=
=9D"
>
> As a co-operative volunteer project, my view is that we do not owe
> anyone a guranteed or timely response. Yes, many of us are employed
> by vendors to work on QEMU, but our work in the upstream community
> context is still on a best effort basis.
>
> If someone requires an urgent or guaranteed response, whether to a CVE
> or any other kind of issue, then the obligation needs to fall on the
> paid vendors who distribute QEMU rather than any individual upstream
> maintainers.

Pedro, Yogesh, can you help answer Daniel's questions?

Thanks,

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


