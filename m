Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB75C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonkc-0001rp-Fc; Tue, 28 Jul 2026 15:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wonkK-0001io-PP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wonkJ-00068R-0B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785267945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yhqUZp4AfZuFqXIoJbYQF1qSiaRBuiz7Xns+0L+/Nc=;
 b=HPoBVSUQN0UUqgk4l5RmLtk4XftJIvreecwKfMVmPip+dCGOhxdmMrHrvqJtdXQwXdrXbM
 XEyfHMvK0i7HkwxA5dAZWvbtJi+BE6JVZwwVx45n8RK4X3nhCTrX9ZWlpoxE5yrOGUf+jE
 xnScX9kfOGpVq2iyRNe/U/YM7RNvMxg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-SfwuI2VRNFabDBtLWcnQJA-1; Tue, 28 Jul 2026 15:45:44 -0400
X-MC-Unique: SfwuI2VRNFabDBtLWcnQJA-1
X-Mimecast-MFC-AGG-ID: SfwuI2VRNFabDBtLWcnQJA_1785267942
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a767b782so1206845e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785267942; x=1785872742; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6yhqUZp4AfZuFqXIoJbYQF1qSiaRBuiz7Xns+0L+/Nc=;
 b=M09jePbqaX9pzYXBjEicinu3QIbw51emmcdTTyqrhL5HCXEzI35hEwhksdoaEDExrT
 /V5Gnhacoxz0PBohWJRwwiXhq0rpak/fTXPo/ZC1H/HR3bPYuGloElOwscq+A/jz4uWU
 3qj+metMEd1dEPcSu4Ehgl7OXfTNabn1mVvFO0B38W2TuWv8X0+AGaTRXd3dQBw+owQe
 srgFw4t8sxw5mrqahuTFChVqP3ol3pCmjeVbbF3Q/lofcnYqYwSL0Njt97H4iIS9A3NB
 hbjn5OkSD1QZT4AuxTcCr03zpesRe0z6TmPIQhdVDpt5Otb1A1Q4PGb1dDlGH46ZB1CA
 lGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785267942; x=1785872742;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6yhqUZp4AfZuFqXIoJbYQF1qSiaRBuiz7Xns+0L+/Nc=;
 b=DdH7NB/cZAYqn74/05lHL94M8QBcCskfDhut2/6rOr+Ew3zbt5GQ7RbOBVgQxwzRNF
 Jdb+yvpbezdF7l1juSRbj2GeIV0e4rBCHe5Ly6QvXJssJ7m0uz200hs+h8skbigRWxsR
 UonXoWkWXszWV7zRW42NgKcQ6X3w5WSyJMBcJDN3JbKopPcOi3TBiEZQbcCODZgJ9jsz
 w8JLG4RFmUo9dTY+hVbtsem+WJUAd5Xiwh8Q72dGFh2RaGrEDDuUYCse+TF8EgsRZrOg
 muA3trLSUc2oIFFgMEISjNC1TBkLmsnP7z8k2nDErIxw8WVSjAQBFpFLxEiPsVd1Byst
 B/VQ==
X-Gm-Message-State: AOJu0YxP9DiqRc1KkONm40kQVYGolf4RZr7FZ6i4+NvIFb+GKkMJlAwJ
 3R/vPxAjJ7Ql/z7+nIYwNHUCdJZOoFsJ0RPVKRj56eGhX3EsDE5kmw1O2KMaWZ3ihARCJkhJsxT
 wfxvWKyn8uXJFH0DqvFGPnqzRFjzzSecmlSUhn5SJW3G/NGQaWUhJvwJU
X-Gm-Gg: AR+sD137imOAQ3rURRGq7Sn0gwxhUV5kSZkwsPNKq2fNE3i8n6I2wOIenIqQmRunyTF
 Jy9YiBHEMfDTY9Pz+8e5etG54rdPPwXBCxvPkYJPX4UjeXOpks/w107JTpld+8hdydgdmRNc9Rl
 FxaRLuNIHq9Equ0bGvddx+mnB1sghNX/Iv3eogCiPLZzrB9hdVhyR1eF+7VwACGq5KGhHabZ+xi
 AqNGmK93wgIePf+cu5CHH1pzB+HO0W+cknFBCMe/CQCWQn4HUMFOwwmTW0I1j/51P6HFRbsKW2+
 z/+HE4oDF56Amuh8USVfARCRtZlLh88x7WtNPUTSrCasB2pYezdfs/NWJhjpnecWl71TmSbnJte
 4BHSKV7MBCHnzPP38z8pg2So=
X-Received: by 2002:a05:600c:630d:b0:495:5365:c0d2 with SMTP id
 5b1f17b1804b1-496c6558b53mr48190225e9.14.1785267942129; 
 Tue, 28 Jul 2026 12:45:42 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:495:5365:c0d2 with SMTP id
 5b1f17b1804b1-496c6558b53mr48190005e9.14.1785267941701; 
 Tue, 28 Jul 2026 12:45:41 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd6d226sm2382985e9.10.2026.07.28.12.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:45:40 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:45:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Miku Hatsune <anznu1l@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 09/30] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <20260728154328-mutt-send-email-mst@kernel.org>
References: <cover.1785179875.git.mst@redhat.com>
 <a5cff318f06cd06b37224e15ee74d64d1df8b12b.1785179875.git.mst@redhat.com>
 <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65990a19-6a7e-4c1c-9354-0fffa13cbba9@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 28, 2026 at 11:40:24AM +0300, Michael Tokarev wrote:
> On 7/27/26 22:19, Michael S. Tsirkin wrote:
> > virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
> > queue, regardless of the size the device passes to virtio_add_queue().
> > 
> > This works by accident because QEMU mostly does not care about the ring
> > size - the guest is the one allocating memory here.  But this changes
> > with in-order vqs where qemu is the one allocating resources.
> > Now, specifying a larger vq than allocated causes an OOB memory access.
> > 
> > To fix:
> > - for new machine types, report the actual max queue size to guest
> > - for old machine types, use a compat property to allocate 1k sized
> >    queues
> > 
> > Fixes: 525d82e323 ("virtio: fix queue size validation against allocated maximum")
> 
> This is actually d530f2dfbd2 in the master branch.
> But his is an interesting case of the Fixes: tag.
> 
> The change it is fixing (this non-existing commit) is in
> the same pull request and comes right NEXT to this fix!
> So we fix something first and introduce it.. later? :)
> 
> It's a fun stuff.

Got some wires crossed here) thanks for noticing.


> But besides this, I wonder what can we do with that for
> the stable series...
> 
> > Fixes: CVE-2026-50626
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Message-ID: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
> > Acked-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reported-by: Miku Hatsune <anznu1l@gmail.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ...
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 805148678d..73b4d82b4a 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -41,6 +41,7 @@
> >   #include "hw/arm/smmuv3.h"
> >   GlobalProperty hw_compat_11_0[] = {
> > +    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
> 
> ..because it is adding a new field into the migration stream,
> which is a problem for stable series.


this is compat not a migration stream, right?
For stable, the value needs to be 1024 for all types.

> Or is it a problem in previous releases?
> 
> Thanks,
> 
> /mjt


