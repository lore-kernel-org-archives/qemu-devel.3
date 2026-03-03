Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5710EC1429
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNIX-000301-V7; Tue, 03 Mar 2026 05:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxNIP-0002z6-Fh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxNIN-00044L-Qc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772534886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m/qcXj6mGP3zYdxM5zi6RmYl905Ja2cTV3CJXRm4xps=;
 b=fyQ68rZvYsu7jZ7dngGBXuY01es6mUPzhlpKnxArE0TfrP2baerVKfgLttYHaAiOR7gi/P
 lvP20nye3uEIX428ETvs6Dj5KY9qmbebEdWIZ4E+8wZH+jMqDQlb+jWBgDg19k8qvRm9tv
 Jt8OglFsNm02Iy8RtlP4xbLb0D4Kdr4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-0Cdd1Aw_M_iyRRj4WNItrA-1; Tue, 03 Mar 2026 05:48:05 -0500
X-MC-Unique: 0Cdd1Aw_M_iyRRj4WNItrA-1
X-Mimecast-MFC-AGG-ID: 0Cdd1Aw_M_iyRRj4WNItrA_1772534884
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35986cc87a6so2365973a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772534884; cv=none;
 d=google.com; s=arc-20240605;
 b=TAV1HQAXfqbhBwFimx0nMTeviU6skf4k3/YDnlsZnhlU6oc+XkqNGiRlqz9H1DVnqQ
 FI2gp40/lghrDoVimAeSTkOnYbVK4Nv4jf0en6ER1+97OrGVnbRTZRlhT78ye0ELlKzC
 HKiX+r9EHsrdJQBsPYiIHyAO37gMsgr30n3UyUMayrrHf6vWp/UlCnkHR2PqyaYi0UEv
 AFMBBnA4vEhJCngWVviGttosmRnh5NfFmuvTtH7C7+s6wQHiyRGZ2oWLSO4yyZCuJ7Z2
 2aINNVwPy7tVUJsxpnzWoyBwHvzZllQu433fkVI6KlgFH1qSrRJfKfzYCaYOWftQUp9A
 uAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m/qcXj6mGP3zYdxM5zi6RmYl905Ja2cTV3CJXRm4xps=;
 fh=QmwjdY2nhcKgGa8S9UuEhm2CAVeDmSPQrlx6n4fZTbM=;
 b=Q7iXUySYaiLS9TjX6hXMHnCHG4HEHc+snZswUVAHq5/JrY+xP51prfvalhORIfZPh+
 VVfq4Ues/8Q21SHATjkDEnHAGKeV8XgG3zDbLB6bpFMJSxsp6gimmCkJtwoy0aDqfDPV
 S4ulky/iOYUyp9TZ5+2tB3IEkeJR0FllU4Bqo/tHZwsYK6w7Kt/1kpqHNB2wfE4K0Map
 YZK0NjBxbnEb0bl6RCZvnQi+jH07Iaqv2eTaHq8/CE5kYPV4EYWR8HC7eJQ+ErdtCGzP
 DT8IgxdoaY77T1pAHzIoSLieWGxxSgxj9Va7FoHwzxBpTZCgIpOa8AHowL6FfruiBRRb
 wDKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772534884; x=1773139684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/qcXj6mGP3zYdxM5zi6RmYl905Ja2cTV3CJXRm4xps=;
 b=noVEo+FP4aF0EcsmC46CEX+p6dgfUkJGX6iW82RTBkzsj+YcVSvSXYTBHGlzGhf33r
 5knlaaiubDSNLCXuJBA5Vd8qTBtcrervjI/Ik7I5/jP2XyvDTg6dtuvw1Kow3oqpPOkx
 K4N3tSIhiTKzl7CvXSjy6n1IYHtNP3dGA4t7+RnZR8AwaDgemz4L1mVHARrSY7ihFI6X
 YZ6BKNdg6ps/7z95/UsuYxpqBO3CjjAZ8VEKePaH4ac0LMANx7m7AbMhSJRLNHJfbf5z
 wK6VI4oOOP6tDAIoOIfkch/AGktvDCQEGI8VeEjSjSiHVfYBIPz7i8AaJY+DETFpMbQ8
 w81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772534884; x=1773139684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m/qcXj6mGP3zYdxM5zi6RmYl905Ja2cTV3CJXRm4xps=;
 b=Pk/kcK1g9qsNhyMZx2uTAmrHI9/Ff7laMEJTjNH4Aqz1dzM0T/94o0Mw8vqfQIzvm2
 vs9Qqk8Wm6KvZWfggZPeo1cpjgMbVeByVdlPyAGPeCIrmJKoVHpCwS0ULL52AkIw5gsn
 R6Mk6eFN5yGzrGE/jGVqD9obgExCB6nMkW0eTIEuY90zoTai2+8Cz1zXETgUSRneQUsh
 ITJC/oegrVSOihoNKwQ75hUpcFeYRQtkMRn3TdhChNnO/V42epMmpVTHwb0UUyD2ueIE
 bNFCnrw04l7h+Gb53+RRDMzLjGeSt2rfFNqGVuWCF6VAf+eMrBBSBeQVgdJBtcaCNJXD
 xF0w==
X-Gm-Message-State: AOJu0YwlyadZ0Wvu/t3mBvB6QUM7JBBSLB7H7oOD347oCfgE0jdayLIQ
 PvqIWeVybVgO6nuTUoMc4Ru7sK6GFRwW0z+XI6DVBYshZoersb9aISzwqYDJefpv8gWYZIwykSC
 thQOrDuXzeTuAcOQKOueHFZxjGtust3IJSzBZkBEVYG9PEtdLf9IYxq1uMN3ia3/Zv2ygcUSclA
 uIpSr5dR7/LdLFthZcb+iPTz6WVM3bjPw=
X-Gm-Gg: ATEYQzyQsxJtilGI0+Rh5l4MszLgA+Rf8QUlxEgvSWccmUmbO5tT7us7fDb/k5A5Yvo
 gT/YMOUFj7YxlyWDpkQN37wJZIQdWa2gbXlvOYR7EjGEdyTh+U8/2biMTbgQxM84e57ksftkqPJ
 9xtoO2Ei3tUtVWkhlN4tgJTKetiMoaA9yXxA+VT1e3kzaF7gYPFKSqvwENnk+MIIT6yjzfmAUlP
 ptzpeDtl3Xm0Uvn5qMAUhGDOBsVNMMSZRWQFLK5tUaAaESHM2QNpUCnlUPZX5jqwr1euTMBbdYY
 Jal9mmlaKp2oG3VnP7LP640=
X-Received: by 2002:a17:90a:fc4d:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-35965ccbc07mr12186742a91.29.1772534884105; 
 Tue, 03 Mar 2026 02:48:04 -0800 (PST)
X-Received: by 2002:a17:90a:fc4d:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-35965ccbc07mr12186724a91.29.1772534883724; Tue, 03 Mar 2026
 02:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-10-marcandre.lureau@redhat.com>
 <99b0ab59-c1dc-4d23-addc-7bf4b87bfa03@kernel.org>
In-Reply-To: <99b0ab59-c1dc-4d23-addc-7bf4b87bfa03@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 3 Mar 2026 11:47:52 +0100
X-Gm-Features: AaiRm50RcuiyIwROlMmdwKZbzjq0MW23AX7s8d9DGltnMotTX0VCM0Qi-B83jOo
Message-ID: <CAMxuvazwmjjpnpsWpOd_=HcS-6ynpVjAw2u3R=VuE=Lhg=AnKw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] system/ram-discard-manager: implement replay via
 is_populated iteration
To: David Hildenbrand <david@kernel.org>
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MXG_EMAIL_FRAG=0.099, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
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

Hi

On Thu, Feb 26, 2026 at 5:02=E2=80=AFPM David Hildenbrand <david@kernel.org=
> wrote:
>
> On 2/26/26 14:59, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Replace the source-level replay wrappers with a new
> > replay_by_populated_state() helper that iterates the section at
> > min-granularity, calls is_populated() for each chunk, and aggregates
> > consecutive chunks of the same state before invoking the callback.
> >
> > This moves the iteration logic from individual sources into the manager=
,
> > preparing for multi-source aggregation where the manager must combine
> > state from multiple sources anyway.
> >
> > The replay_populated/replay_discarded vtable entries in
> > RamDiscardSourceClass are no longer called but remain in the interface
> > for now; they will be removed in follow-up commits along with the
> > now-dead source implementations.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
>
> Isn't it significantly more expensive for large guests to possibly
> iterate in 4k granularity?

It's a bit hard to say. How likely is it to have a very large
RamDiscardManager with a min-granularity of 4k?

>
> The nice thing about the old implementation was that we could just scan
> a bitmap, that is ideally in 2M granularity.

We can still iterate with 2M granularity after this patch. However, it
may be less effective than iterating using find_next_bit(). Whether
this is noticeable remains to be seen.

Note: this change was a suggestion from Peter in v1, as discussed in
https://patchew.org/QEMU/20260204100708.724800-1-marcandre.lureau@redhat.co=
m/20260204100708.724800-7-marcandre.lureau@redhat.com/#aZyQWOQeKeT5yzIv@x1.=
local


