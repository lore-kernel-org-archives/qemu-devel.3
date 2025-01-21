Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44956C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCcT-0004ra-BS; Tue, 21 Jan 2025 06:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taCcP-0004rE-5q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:40:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1taCcH-0003BU-Cw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737459618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Elt+lFLmwXJG20xP3B41lkgHw56Aa5HMxnF3Sst+52E=;
 b=cXvqgpx+VXgEgZE/mMfwDkVBVt1IkMRg2ipzlkDlKq6aPWmVpM3JzBgJXrxLKo7bf8+Ut2
 A4TPIan48vz90cLnf8HAl0ojsBJweMr9WYRNNbsaplxs+p042puQS0yjRXYJBLePgRudlr
 SgbOQmpmsmchxz0XckFpWaPC3owa3jo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-iR7lWcbiNCKN_eK5R5Mh3g-1; Tue,
 21 Jan 2025 06:40:15 -0500
X-MC-Unique: iR7lWcbiNCKN_eK5R5Mh3g-1
X-Mimecast-MFC-AGG-ID: iR7lWcbiNCKN_eK5R5Mh3g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15BAF195604F; Tue, 21 Jan 2025 11:40:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.23])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DA8119560AD; Tue, 21 Jan 2025 11:40:08 +0000 (UTC)
Date: Tue, 21 Jan 2025 12:40:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fahrzin Hemmati <fahhem@fahhem.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH] Skip resizing image to the same size
Message-ID: <Z4-HlVbF2gRAgi86@redhat.com>
References: <20250120103711.836753-1-fahhem@fahhem.com>
 <Z45ANK-m2XZazDi3@redhat.com>
 <CAHJ_xmW3YCrKEpNGBJxRzqM99Aoe=nwOSJWF+BO5VbySP9763g@mail.gmail.com>
 <b3e7b218-66eb-4d5f-b9ed-6a20dbca2a8a@tls.msk.ru>
 <CAHJ_xmVDZ159ixki4qpvOMdA1zLpwSkVnB_ukx_EfW1ve0o=+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ_xmVDZ159ixki4qpvOMdA1zLpwSkVnB_ukx_EfW1ve0o=+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 20.01.2025 um 23:21 hat Fahrzin Hemmati geschrieben:
> Happy to wait until your patchset is in.
> 
> Yes, this is a no-op, but it reads the entire disk image to perform that
> no-op, so this is merely a time-saving improvement, not a behavior change.

Can you give more context on what exactly you're doing that it reads the
entire disk image just to resize it? This sounds completely unexpected
and if it does, there may be a different problem to be solved.

In my test, for a raw image, I see a single ftruncate() call, which is
unnecessary, but shouldn't cause any measurable time difference for the
qemu-img run. qcow2 has a little more code in QEMU to figure out that
there is nothing to do, but it doesn't involve any syscall and certainly
not reading the whole image.

Kevin

> On Mon Jan 20, 2025, 09:49 PM GMT, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 
> 20.01.2025 23:17, Fahrzin Hemmati wrote:
> 
> My apologies, I saw the Signed-off-by requirement at first, but as I
> followed the docs I got to "git publish" and didn't realize "git publish"
> was
> actually able to send emails on my system (I don't remember setting up any
> SMTP settings). By that time, I forgot and thought this patch was short
> enough to not warrant much of a commit message.
> 
> The main practical advantage is for users that call "qemu-img resize" via
> scripts or other systems (like Packer in my case) that don't check the
> image
> size ahead of time. I can upstream this change into them (by using
> "qemu-img info —output=json ...") but I figured it would be useful to more
> users here.
> 
> This could trivially be added to block/io.c:bdrv_co_truncate(), as well as
> blockdev.c:qmp_block_resize() with a little more work. I'm not familiar
> with those workflows, but if needed I can do that as well.
> 
> Here's the new patch:
> 
> From 17f5c5f03d930c4816b92b97e0e54db0725d7b94 Mon Sep 17 00:00:00 2001
> From: Fahrzin Hemmati <fahhem@fahhem.com <mailto:fahhem@fahhem.com>>
> Date: Mon, 20 Jan 2025 01:56:24 -0800
> Subject: [PATCH] Skip resizing image to the same size
> 
> Higher-level software, such as Packer, blindly call "qemu-img resize"
> even when the size is the same. This change can be pushed to those
> users, but it's very cheap to check and can save many other users more
> time here.
> 
> Signed-off-by: Fahrzin Hemmati <fahhem@fahhem.com <mailto:fahhem@fahhem.com
> >>
> ---
> qemu-img.c | 6 ++++++
> tests/qemu-iotests/061 | 8 ++++++++
> tests/qemu-iotests/061.out | 9 +++++++++
> 3 files changed, 23 insertions(+)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 2f2fac90e8..3345c4e63f 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4184,6 +4184,12 @@ static int img_resize(int argc, char **argv)
> goto out;
> }
> 
> + if (total_size == current_size) {
> + qprintf(quiet, "Image already has the desired size.\n");
> + ret = 0;
> + goto out;
> + }
> 
> 
> 
> I don't think this is necessary: the actual operation is a no-op
> anyway, there's no need to special-case it.
> 
> Please also refrain from changing qemu-img until my refresh
> patchset is either accepted or rejected. It was a large work
> and it'd be sad to lose it.
> 
> Thanks,
> 
> /mjt


