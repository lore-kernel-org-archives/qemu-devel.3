Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573B9C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ohn-0001WT-Vz; Wed, 02 Sep 2026 13:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1ohl-0001WL-Vq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1ohj-0007fy-Ga
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788369894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
 b=i6FDsv//FDOJhBw5HQd2LhSl5NZON+ywm5Qwz8yAVJ3Y4TA/FOFtqehWCU0Bhee7++jc2Q
 0KXyoIVg9QaSJbvCYH17R0yof+U/KtsVS90Xu5J2QaZauBGQvvTwHYjApI7JnmKKKVPQbo
 +IZEC59Pdbjsg3zyKRTeNXvDvyzv19k=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-0Le41cQzO3uofgQVwlSXZw-1; Wed, 02 Sep 2026 13:24:53 -0400
X-MC-Unique: 0Le41cQzO3uofgQVwlSXZw-1
X-Mimecast-MFC-AGG-ID: 0Le41cQzO3uofgQVwlSXZw_1788369893
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c767e23f6so1316298d50.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788369893; cv=none;
 d=google.com; s=arc-20260327;
 b=mfPzfUw3AWLyY8bPmeGcu8VCLiwWwA5Fn5ykpQyjRLgJ8XoWGGjinNBR5xZbVYIBkP
 f+7KbX+Hx20b18/Ms6loFGYBB6D8Q//z9p9ab+TrgCDOkc+jIWk8rUJ3n/jmxutsZJ/Q
 La/mP9zHxKxQszV0IiWmkS9niV9P3AJPBZkAnrCymHtX3k5O8HYI6LaCGww56VSrZGjM
 wu3XDlQvCRtqpHTJSl85SVkWxcgh65N5bbK3dZOnezUy1t28Mdj2MIB9+PlKAkK0VkiR
 u5x8ElN2XnM8CgHJfZNvZjKkQZS5Dx+M0kr7s/+AzVwW05LqEBPSLI7pwUM4C64UPKDv
 ILUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
 fh=60V1tAG+kWPZTX8HCTMXfOXb3Vr/kV6rH1RFz0AmpMo=;
 b=sxul1p40r5RWQGBWB7f3XX2gbionysk9wZrvGytHM5bYn4XX5jNE5dvA7lFtmWGXux
 5fWVWjOgNM0kUN+oxvvmam1O/bZQkjTF3vcy9L7T0mg+gO2jW9RjZxIxsCKYpkej9ZRW
 5mzxbGbjTS3WOwKzAahT6c19ewXjDjSmxgrnw+bZsGqUDbfOUgOOd4h/8czg3DTe7+TL
 7Rvx4b5pXdW7wMPMiry1CniF9LkKeLJQC4BW0oBiM3s+PoT2NQ2pU2RNyVa5NUwjJ3QV
 7eDhkgSyKdyTp9skvMr5q6xmbrpPzA7GhYVdalBBHfGtdDztV2kP/enV8aC+SlM5xU2O
 PRQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788369893; x=1788974693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
 b=j8+62Wq8MVdD7eYOO6gTKEpNHW01QiCzB3GT8tticd7kR2/A5Wm410mL0Xo/gJVssv
 Qh3CdVp3ghWL2aHEaotLXgRjEkhvzcOW6rHq/nEVZ5OH8JbEYuB2SqHoj4qUGLk3W/9F
 ia82Aq2E6U+CCfgBM5peWwJ9COTIopklzlSnc94/vr3bSW9nVoc/MAKmzD2GnKhGBko3
 XLIeCbxbpFTKlPrvq93wGovm9ZuI4pjCA41UAlzmNKJLWXviVklNw2/1P0kgVzAplayM
 fRlrT1EryH/+g0SCb1HRIScrxjtbqAGFzxw4rYdC/XYfBnXEj51l5MkdVjUeCzIt0QJF
 J0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788369893; x=1788974693;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JtfXQonqbMU0qfMOMFckgTdI7kxhGi1jaT13EBgtRUU=;
 b=iuWE4NbLUXAZhw/JuBdYZ2QIOG3a7rpU9xznsQEGriDM8zQRsJipuXP/gLXgYhtckN
 tzY8INxEmU47GRnP+mmppC98zyYm0jeE+UPLWmG3XcPRFch62K0OSU/rSmz/7WAMXBnO
 GEgA4LLJAIRqnd2b2MOHMmXIR80d6Ids2IeT1D6LJYH0LYeQ/5CDuiZ+XVEwB5RqJAvv
 0/b363PCqSIqMSk5/6yvH0WzbCxBeK5frE1McoGY0fM6pqXyW0j7siF5kiAEbakVfFLe
 0XYvkwG+weCuy5IGQ3GM18ESapIJRosK67ZBemzpULkTo7NeMKYVQ6RA8lCtUYro5cm2
 3mbA==
X-Gm-Message-State: AFuF++nMvGztCwTwEzjwoR7CXqriLIEd/OlB/FLrUGdz+kYOd7Xtc/Fa
 tq1tkcVDFSOWIfk4rYlBA2Gvg3jroiKMa+HMYZ65WZKKuDkzcIf1lxTxKAZ5SQO/BOcjeY7QM4y
 cx0aTZUept8Rd6eywo5OXgwhCl+UMPeVmoLqa/8c1agw7vURd8kC0dZlg8azQLtSJ5K0sYk13yM
 oXiNR8W5+NTSG5LRN61qW2Ew9KNN5U8a4=
X-Gm-Gg: AYBFou0TCeIfqArynq27FY6kye9ohMqADcbNuDiy+LXvyA016ZoPbUwQ4hvQ3REtxTc
 FpcJB2efH9kP0e+VyKg4DBeK6NIMXPY8QvOoNbZkH3+2frlKCGregePVZM85+kVXRdkvgvOEFE8
 Ix5uJsqG0V82xPRNxgKF9MLNhStXUN1o723c5mmKy59vGTuvcXl5GRiAreiWiD8yBfwNp1C3pqQ
 qlhoq9hIIONOwCF
X-Received: by 2002:a53:c051:0:20b0:66d:2c09:fb70 with SMTP id
 956f58d0204a3-66f9b6c6c7emr1994045d50.0.1788369892881; 
 Wed, 02 Sep 2026 10:24:52 -0700 (PDT)
X-Received: by 2002:a53:c051:0:20b0:66d:2c09:fb70 with SMTP id
 956f58d0204a3-66f9b6c6c7emr1993889d50.0.1788369887644; Wed, 02 Sep 2026
 10:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260831201945.287730-1-jsnow@redhat.com>
 <871pbd9qpy.fsf@pond.sub.org>
 <CAFn=p-YBpsxy-3tr0SZ0CBfXUYnb6eg6AxNWpwUQmsuY5ZuykA@mail.gmail.com>
 <874ig7539j.fsf@pond.sub.org>
In-Reply-To: <874ig7539j.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 13:24:36 -0400
X-Gm-Features: AcwNN1XBjb54T3mVZMsXOfq2ujX90-DJwsczseD1fmwpMjm1p4yXf5IyvbishUI
Message-ID: <CAFn=p-ZMj03qA0tvLU34FHLcwBJjU0c2q2Ex1p06FJfZpwyuJA@mail.gmail.com>
Subject: Re: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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

On Wed, Sep 2, 2026 at 6:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Sep 1, 2026 at 7:05=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >>
> >> Series
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>
> >
> > Thank you for your suffering :)
>
> You're welcome; it's my job[*]!
>
> > So, I think there's actually no real problem in checking in a partial
> > conversion as the infrastructure was coded specifically to allow it,
> > however you're the maintainer so I will follow your lead. I'm more
> > interested in moving forward than telling you how to do your job ;)
> >
> > The series will eventually enforce strict ordering, so there is no
> > chance we will miss anything. If we send a PR now, we also don't have
> > to keep rebasing the partial series against master. If you don't want
> > to submit a PR, please create a branch I can track and submit patches
> > against, and please periodically rebase it against origin/master.
>
> I worry a bit that having intros split about half between two styles
> would cause confusion and friction.  I'd much prefer to get to >90%
> fairly quickly.  If we think that's possible, I'm happy to queue up
> things in my tree, and take care of the rebasing.

Everything up until the "convert multi-paragraph intros" patch (#44 in
my pending work) is approximately 87% of the total volume of
conversions. In the most recent off-list mail I sent you, that's
Sections 1-7 -- which is essentially all of the stuff that was
factored out as "semi-trivial"/"simple", plus the "TODO" conversions.
I believe these are pretty trivial to burn through, but would require
a bit of dedicated time. We could probably do it in a week if we
really pushed ...

Existing volume of what you have reviewed and accepted is 55%.

Well, either way, I just don't want to have to juggle so many patches
in the interim, so I am pushing a bit to just merge it to make
subsequent series easier to rebase and juggle so that e.g. I don't
have to have increasingly long "based-on" tags.

(Makes sad, pouting noises.)

>
>
> [*] Some days my compensation is compensation for suffering ;)
>


