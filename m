Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BDC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4gBa-0004lw-N5; Thu, 10 Sep 2026 10:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4gBY-0004lJ-SY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x4gBW-0007WI-Kd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 10:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789052128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpSn4nPuLtfLi5xnPGvOBmAcKHMA1qgeJOiBFY3JT4k=;
 b=i/iiqQr5v4tRm4R08SIVtlotQlzLVn4domBvNMRsREl/wjVXjve5/IvnydmkVESxmxgqLz
 3GPBGDFh7RRu8lJQEaI1UZLdtCh7ZCqcnBlxkis625hrHADKeJNlhFF0NO+zRy0s9aWR+n
 hXg8LT5DzpPIKLElz7twFT4AD61rbk8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-5OmwwbFvNoylhVMbZb7Tgg-1; Thu, 10 Sep 2026 10:55:26 -0400
X-MC-Unique: 5OmwwbFvNoylhVMbZb7Tgg-1
X-Mimecast-MFC-AGG-ID: 5OmwwbFvNoylhVMbZb7Tgg_1789052126
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39906175917so8871797a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789052126; cv=none;
 d=google.com; s=arc-20260327;
 b=BECEItkA0u65nsdIABYc1C7IfvOLIhoeKnG3q7fEh3BdUHyhmLn5+WdNA+uYXVvxCc
 uELship+T5Dj1ZmBGUBljPmhKbmn9/RLGKrby+Y6gM+jJXoh7gX584o/dr8fC2QmYaPi
 7Tq7sv3CP36+orhr9Ywm7JZTK3yc2f4eJv/zkASByGzp0oEU87JAJR1/gB5vqRAu9gc1
 C34gVmmFFkx6fOhukQ2cq8pY7x8GDQ8IlZgqGw1jvf50wSPYOqER3h00kf5Y+s53a2c4
 RGEPqkb7yM/WHigyMKO3GRSYXje1Edwtl/iPIry+uBBLXXdwvRXAHJ1I9ozdIJFarQy7
 KoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PpSn4nPuLtfLi5xnPGvOBmAcKHMA1qgeJOiBFY3JT4k=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=pesNurjvi7DdiMbp2eLHqXFSHU6vUSAvrwhLyT/Vp9XHrSwiLPWTsMoL+YC5Z6My/h
 AZfwbvUCDs/wm6eIboPEPeex7KGhx96lPePcbRiR3npoaPhxD0ytedeZYNzRcrECtpVS
 DppHsp+PUBHQYa1A4V3UzLK+x443P3QLs7Hd8mj9SmYIxTaziIX819ChFHSWBeCa2ZdX
 LIEc7bevSXjaZ+phCFm/eeJiEzli5v8YiVEPxz5xRCTGtwkAH5u/D4D3E3AefBqw53Io
 y5398IvlcnEbiRFc3SmbEUYDR5rv/NkoVQ9MpCfW786InBQBB5rrYs+r4Lgzxpwuwkvg
 /CHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789052126; x=1789656926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PpSn4nPuLtfLi5xnPGvOBmAcKHMA1qgeJOiBFY3JT4k=;
 b=VPvreRhtEo9GYtCpVTKvt1TdeWypzSKmWxvGD1JEFynrXQ+TovtgcrkcsmLATd9LFz
 bB0kkQjR42NgdhG/7XotjjLrYl29QhFbpeWeWOJ3WfcKhEWXu/mku0dvY/bHK4VgoDb2
 BfVcDZtXuXXxpu9S/vcclqssY2KYMX0Mlef5DKRZnFNnAWV8dqMRmmHvSFJfEiYa5/ez
 LTVK95qj6liRtiQJUy9ERqRjDJyT6nE3k8UU6ZiGV+BXzom+fBqCMSgLsOVZlMeeiRJ0
 oQnAgjtt7HLNMIZvuGbIjjszyNv/Sj0wt6USjhwM1sO+1VDV2ExdTyLVT1kVvcZN8+nh
 2J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052126; x=1789656926;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PpSn4nPuLtfLi5xnPGvOBmAcKHMA1qgeJOiBFY3JT4k=;
 b=JF1gK4LDBUan6Dgb5tXr3jzBUoZ6GfZ7wmw++fnzQsb/z3+pBQFF0dvZ/hMDKJV1i7
 UVnIkVGk782fGs3lTb2Oa/ZJ4lh6a0dOFtb+jsvW7oIEgnV0u+t7uKGBRY7ZcWsP5T9c
 ebFQr5+QeF0UmLgxHzgEnWU9WnPt0nxkE1rLIuRO4PhqrGmLk9PJZRpNwShLzD8xpmhv
 Ofdlnsa3Ix7FlXtGE9GdciaAjYv8Ci5WXUwiNOpxozMztnlAJL/TdClINvpOtzflec83
 ZTDwCv+9n5XZ7SkBXwYlagaYx14RTEru49zrDcd6kFnK+UCTwJ0YayEIIvIc1+y2I92Q
 miPQ==
X-Gm-Message-State: AFuF++k/ea83ych233BQQy7JXvx+Jq3x2X93Nt9WNMV0JGXnqHXjORCc
 /gPRJBJu9QhkwiKJ7Y2roqtTYeflZ1gsqpq65j9H5XPmO6ZyU/l3mJ4qx5oGGU76VdIjE2zJclz
 rc1i2zJ8uiRJ3WiBzoznm0HZMBdERvlsoqgSv1Ex9d2rs447qi/YGiuWkBrxIcnFATM4FJ/vqO/
 fyVAy/q7j48RtO8rTxMnUCDWdee2HK594=
X-Gm-Gg: AYBFou0u29YgmuIxfg3zwJ/6DguXmHtlUf0FOmKjAjyWVHnwTTQ9a1QN5NzaDpU/MVF
 W/sylxanApWEOErrCfJtviLr9hqq4OqIIVvOWzAHgzaXXcsGA+uj0+u2ZlXB2kSSFe5FVAkZLp1
 J+vu2k9rvodBmHc0g+3xUJ2+WAL7wIM1EJgEhLeYa+TAys+jfDgqcN04jdt8sRPrAkFAJ+d5cVh
 yURVcj5JtLJIy3d5+MxsFNg+qHmWfwxnWOr94TJ+wWyQihiIc2QfWaviuj/ixM9knEfvYZyw6mT
 mA==
X-Received: by 2002:a17:90b:17d2:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-39b2613e70emr57707217a91.11.1789052124951; 
 Thu, 10 Sep 2026 07:55:24 -0700 (PDT)
X-Received: by 2002:a17:90b:17d2:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-39b2613e70emr57707058a91.11.1789052123176; Thu, 10 Sep 2026
 07:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
 <CAFEAcA8hD2+8uupWy5jZbKYLLUPwkvX9LdCEGrdVL20L1f7mpw@mail.gmail.com>
In-Reply-To: <CAFEAcA8hD2+8uupWy5jZbKYLLUPwkvX9LdCEGrdVL20L1f7mpw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 18:55:11 +0400
X-Gm-Features: AcwNN1VmNsdLYOpUVpVhByrZjKgnh1ih8M5p06RQOZUUCoQxbST5HHgzp9IjJoE
Message-ID: <CAMxuvazBKab1h7-H55De4XRJFXtd=umAqCxc1WPz+iOKx7nrvA@mail.gmail.com>
Subject: Re: [GIT PULL 00/24] Various virtio-gpu/dmabuf related fixes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Thu, Sep 10, 2026 at 6:45=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 10 Sept 2026 at 14:30, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c78601=
3fb7:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stag=
ing (2026-09-10 11:08:04 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v1
> >
> > for you to fetch changes up to d26343c12d84227263b8d2fc89bac7632a98e00d=
:
> >
> >   contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09-1=
0 17:29:47 +0400)
> >
> > ----------------------------------------------------------------
> > Various virtio-gpu/dmabuf related fixes
> >
> > Hi,
> >
> > While working on CVE-2026-66020 (which had a few revision on list), I
> > kept finding several places where virtio-gpu scanout and dmabuf
> > ownership was unclear.
> >
> > The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
> > unmapped its memory. Following that path also found stale dmabuf
> > references, duplicated scanout bookkeeping, and inconsistent cleanup
> > between display backends.
> >
> > Those changes touch a lot of area and I have done basic testing with th=
e
> > various backends. I would not recommend backporting them all to stable.
> > The first 2 patches address CVE-2026-66020 in the general case and
> > should be safe to backport.
> >
> > thanks
> >
> > To: qemu-devel@nongnu.org
> > Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ---
> > Changes in v5:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> > - Link to v4: https://lore.kernel.org/qemu-devel/20260910-virtio-gpu-cl=
eanup-v4-0-7d623714bd71@redhat.com
>
> So is this different from the v4 on list? Please don't send pull
> requests as if they were new revisions of individual patch series.
> This is not the mechanism the project uses: pull requests should
> be an accumulation of whatever patches the maintainer of a
> subsystem has. Sometimes that will happen to be a single
> patchset, but usually not.

My bad, I should have cleaned-up the series cover letter. There is no
difference with v4 beside trailer tags.
I didn't include other pending ui or related patches, I could, but I
would rather have smaller PR.

I can send another PR if those extra lines in the cover letter are too
dirty. Let me know

thanks


