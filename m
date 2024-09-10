Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104DAEE01E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8K7-0000lt-S7; Tue, 10 Sep 2024 17:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so8K5-0000kq-SB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so8K3-0001qw-Ub
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726003370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ut/l3DhG7NvkkZ37nwZL682ZZRD4ptTfK4S40XB5pDc=;
 b=BHfybfuZoVewKYJq5w2Q8Y7TTfc9vu4xEjuFxhn34Xk2OygoBGvb8GJgcgI3dthXivqZXB
 ZnoYgh/SmNakuxq6pGTqY2v6uSU67X/kUg/B1mD5Li38iVoqN3DASLZ4EwWG89+uxTlXNp
 4ebXCnlT1SmLoF3gSmdVayPeaeMkt7Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-qC6yOn8RM8yjnb8s7LX2Fw-1; Tue, 10 Sep 2024 17:22:49 -0400
X-MC-Unique: qC6yOn8RM8yjnb8s7LX2Fw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a99fcd374cso648635585a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003368; x=1726608168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut/l3DhG7NvkkZ37nwZL682ZZRD4ptTfK4S40XB5pDc=;
 b=Zwdqe4nZMOgFuXIEWjaF3pz//Y+tHxfgeZr2Cspj0CQcX52+LT4PajlAqwDCZcTjb7
 BV8NGPwEgA1cIEcA4vB6STP1HdKIyD7Z+o9KZ92pjI+L8KkHge6Vfo2of7AH52yV9xAt
 IaoHeoIEoCWcQC66KT97ykEu4t59cnAWlPAtc+ILna9XBpc7IYUW2vFk/ysDpkwwzb3/
 m6DnLr8TG7r3dWuQ7m0kqtp049piq2GIiNznn7JiHtziY+Dssaf7mrAYDwnLCwTG2xWi
 V52XWnvWoYU9zvCMd8pY7pPD7TnzYKlwiZ12MsYtOGp3voySnzubLGk9VJIT1s5applh
 Klqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5DBTzx1Ri00Y2skB/fUI7oIF2POpkuHE0dfwUxoyLD0YzOu29EKdJuacCJXhoSgtAuN0v+5iayf4O@nongnu.org
X-Gm-Message-State: AOJu0YzeRTNFupAAhvauSbL39T14MSayWUi9SLXSzWFYyGP0dHx2k/+F
 vyAlZoEgC/yqENzD04sjYov7FPcODgCAonaoaOR06kavJnR3KNnAaHg5WHuaZi5X2qkWlnCCwaS
 jajkal+acEEK9wo3GhZG6Y5oHeYYp261UhEZ2qRFrnZ1KjdPaAyXj
X-Received: by 2002:a05:620a:40cc:b0:7a1:d08d:e2fa with SMTP id
 af79cd13be357-7a9973283dcmr2291392485a.1.1726003368535; 
 Tue, 10 Sep 2024 14:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKayKFE/YhVxWwTQvBU1F9O/IbE82YiYeQIJn0vCAYsPEFo8R/uQzpG9DZvlWPhDLAOzDMQw==
X-Received: by 2002:a05:620a:40cc:b0:7a1:d08d:e2fa with SMTP id
 af79cd13be357-7a9973283dcmr2291387485a.1.1726003368066; 
 Tue, 10 Sep 2024 14:22:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a03b3asm341818785a.81.2024.09.10.14.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:22:47 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:22:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Message-ID: <ZuC4pYT-atQwWePv@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frq8lcgp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 09, 2024 at 06:54:46PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
> >> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
> >> >
> >> > Despite the fact that the responsive CPU throttle is enabled,
> >> > the dirty sync count may not always increase because this is
> >> > an optimization that might not happen in any situation.
> >> >
> >> > This test case just making sure it doesn't interfere with any
> >> > current functionality.
> >> >
> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> >> 
> >> tests/qtest/migration-test already runs 75 different
> >> subtests, takes up a massive chunk of our "make check"
> >> time, and is very commonly a "times out" test on some
> >> of our CI jobs. It runs on five different guest CPU
> >> architectures, each one of which takes between 2 and
> >> 5 minutes to complete the full migration-test.
> >> 
> >> Do we really need to make it even bigger?
> >
> > I'll try to find some time in the next few weeks looking into this to see
> > whether we can further shrink migration test times after previous attemps
> > from Dan.  At least a low hanging fruit is we should indeed put some more
> > tests into g_test_slow(), and this new test could also be a candidate (then
> > we can run "-m slow" for migration PRs only).
> 
> I think we could (using -m slow or any other method) separate tests
> that are generic enough that every CI run should benefit from them
> vs. tests that are only useful once someone starts touching migration
> code. I'd say very few in the former category and most of them in the
> latter.
> 
> For an idea of where migration bugs lie, I took a look at what was
> fixed since 2022:
> 
> # bugs | device/subsystem/arch
> ----------------------------------
>     54 | migration
>     10 | vfio
>      6 | ppc
>      3 | virtio-gpu
>      2 | pcie_sriov, tpm_emulator,
>           vdpa, virtio-rng-pci
>      1 | arm, block, gpio, lasi,
>           pci, s390, scsi-disk,
>           virtio-mem, TCG

Just curious; how did you collect these?

> 
> From these, ignoring the migration bugs, the migration-tests cover some
> of: arm, ppc, s390, TCG. The device_opts[1] patch hasn't merged yet, but
> once it is, then virtio-gpu would be covered and we could investigate
> adding some of the others.
> 
> For actual migration code issues:
> 
> # bugs | (sub)subsystem | kind
> ----------------------------------------------
>     13 | multifd        | correctness/races
>      8 | ram            | correctness
>      8 | rdma:          | general programming

8 rdma bugs??? ouch..

>      7 | qmp            | new api bugs
>      5 | postcopy       | races
>      4 | file:          | leaks
>      3 | return path    | races
>      3 | fd_cleanup     | races
>      2 | savevm, aio/coroutines
>      1 | xbzrle, colo, dirtyrate, exec:,
>           windows, iochannel, qemufile,
>           arch (ppc64le)
> 
> Here, the migration-tests cover well: multifd, ram, qmp, postcopy,
> file, rp, fd_cleanup, iochannel, qemufile, xbzrle.
> 
> My suggestion is we run per arch:
> 
> "/precopy/tcp/plain"
> "/precopy/tcp/tls/psk/match",
> "/postcopy/plain"
> "/postcopy/preempt/plain"
> "/postcopy/preempt/recovery/plain"
> "/multifd/tcp/plain/cancel"
> "/multifd/tcp/uri/plain/none"

Don't you want to still keep a few multifd / file tests?

IIUC some file ops can still be relevant to archs.  Multifd still has one
bug that can only reproduce on arm64.. but not x86_64.  I remember it's a
race condition when migration finishes, and the issue could be memory
ordering relevant, but maybe not.

> 
> and x86 gets extra:
> 
> "/precopy/unix/suspend/live"
> "/precopy/unix/suspend/notlive"
> "/dirty_ring"

dirty ring will be disabled anyway when !x86, so probably not a major
concern.

> 
> (the other dirty_* tests are too slow)

These are the 10 slowest tests when I run locally:

/x86_64/migration/multifd/tcp/tls/x509/allow-anon-client 2.41
/x86_64/migration/postcopy/recovery/plain 2.43
/x86_64/migration/multifd/tcp/tls/x509/default-host 2.66
/x86_64/migration/multifd/tcp/tls/x509/override-host 2.86
/x86_64/migration/postcopy/tls/psk 2.91
/x86_64/migration/postcopy/preempt/recovery/tls/psk 3.08
/x86_64/migration/postcopy/preempt/tls/psk 3.30
/x86_64/migration/postcopy/recovery/tls/psk 3.81
/x86_64/migration/vcpu_dirty_limit 13.29
/x86_64/migration/precopy/unix/xbzrle 27.55

Are you aware of people using xbzrle at all?

> 
> All the rest go behind a knob that people touching migration code will
> enable.
> 
> wdyt?

Agree with the general idea, but I worry above exact list can be too small.

IMHO we can definitely, at least, move the last two into slow list
(vcpu_dirty_limit and xbzrle), then it'll already save us 40sec each run..

> 
> 1- allows adding devices to QEMU cmdline for migration-test
> https://lore.kernel.org/r/20240523201922.28007-4-farosas@suse.de
> 

-- 
Peter Xu


