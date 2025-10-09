Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A58CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rGz-000283-GZ; Thu, 09 Oct 2025 10:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rGq-0001zt-S5
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rGi-0007kq-Mq
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760018716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sg+YNn/0/p0cCMW1xeb3N240EOGBaiOyzWzIOd/ajdk=;
 b=FKBF5h5C5lHTaq7smSTYJtprlPznwhS7ycZHlugyKraZAk3yQqBh/o1JYeK+EUyRRvNMln
 wiPU2Kec2CwlWdkkVNW+DY/g1GIj9yYXLB7eLi6Vmkz2lucr3NR74T9YOb9BD66DLfwnYp
 U3XmHSAisQea1pDNpgY+h9fm8JwtBzQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-kaaFfu_MMfyPVrNrOvXkrA-1; Thu,
 09 Oct 2025 10:05:11 -0400
X-MC-Unique: kaaFfu_MMfyPVrNrOvXkrA-1
X-Mimecast-MFC-AGG-ID: kaaFfu_MMfyPVrNrOvXkrA_1760018710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E4E81955E85; Thu,  9 Oct 2025 14:05:09 +0000 (UTC)
Received: from localhost (unknown [10.45.224.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E98E1800576; Thu,  9 Oct 2025 14:05:07 +0000 (UTC)
Date: Thu, 9 Oct 2025 15:05:05 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Chenxi Mao <maochenxi@bosc.ac.cn>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1] Fix build break when LTO is enabled
Message-ID: <20251009140505.GF1460@redhat.com>
References: <20251009070010.1863345-1-maochenxi@bosc.ac.cn>
 <CAFEAcA9oHpFmxmWV6dwVsQdJ6=_fKUrB4coD8m-QNi_KMMgSfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9oHpFmxmWV6dwVsQdJ6=_fKUrB4coD8m-QNi_KMMgSfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 09, 2025 at 02:32:00PM +0100, Peter Maydell wrote:
> On Thu, 9 Oct 2025 at 14:15, Chenxi Mao <maochenxi@bosc.ac.cn> wrote:
> >
> > QEMU build fails when LTO is enabled:
> > ../configure --target-list=riscv64-softmmu --enable-lto
> > make
...
> Hi; there's already a patch on list for this:
> 
> https://patchew.org/QEMU/20251001124055.2743244-1-rjones@redhat.com/

And it's nothing to do with LTO.  This is caused by an update in curl
which fixed some (already crazy) compiler macros to detect this stuff:

https://github.com/curl/curl/commit/79b4e56b3f30dc1ac28a81128a07d27338e5219e

> Looks like that missed the elf2dmp usage though:

I'll post an update with Chenxi Mao's S-O-B attached, in a minute.

Rich.

> > diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
> > index 21306b3fd4..fa8da0f9a2 100644
> > --- a/contrib/elf2dmp/download.c
> > +++ b/contrib/elf2dmp/download.c
> > @@ -27,8 +27,8 @@ bool download_url(const char *name, const char *url)
> >      if (curl_easy_setopt(curl, CURLOPT_URL, url) != CURLE_OK
> >              || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) != CURLE_OK
> >              || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) != CURLE_OK
> > -            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
> > -            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) != CURLE_OK
> > +            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK
> > +            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) != CURLE_OK
> >              || curl_easy_perform(curl) != CURLE_OK) {
> >          unlink(name);
> >          fclose(file);
> 
> 
> thanks
> -- PMM

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


