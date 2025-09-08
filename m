Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD1CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvc9L-00028t-Gv; Mon, 08 Sep 2025 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvc90-00024D-OO
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvc8s-0003rf-T7
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757338962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MPFszoK9nD4YbwL3xcbeFYxGkX+thnAMZC0vjgkOb0k=;
 b=LIyXy6V0EBb4l+9oT4JT4wjYU+Bnw2PHJu6jtGEdEwkpfrR4oKi1jor8ldarrn3ZmaeAKy
 3XXDDRXpJg/vNm8KN9aW1SOnl4aM4oZyzgyIumAwsWujFR/d/rw8j9UIluETCfyPGzoHcf
 OyZdW/77u0HqJmcUxxtnWHBoisUElbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-kzVRqPx8OR-jCG_7kEdt2w-1; Mon,
 08 Sep 2025 09:42:41 -0400
X-MC-Unique: kzVRqPx8OR-jCG_7kEdt2w-1
X-Mimecast-MFC-AGG-ID: kzVRqPx8OR-jCG_7kEdt2w_1757338960
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A8E180045C; Mon,  8 Sep 2025 13:42:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD0D0180057C; Mon,  8 Sep 2025 13:42:37 +0000 (UTC)
Date: Mon, 8 Sep 2025 14:42:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: should the functional-testing scratch_file() utility guarantee
 that the path it returns doesn't exist?
Message-ID: <aL7dSumeu9RI6-5O@redhat.com>
References: <CAFEAcA9kGOre7sWjjEi1jAGkkNB4EVQnvq3u5fY79HZjSzSZHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9kGOre7sWjjEi1jAGkkNB4EVQnvq3u5fY79HZjSzSZHQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 08, 2025 at 02:13:54PM +0100, Peter Maydell wrote:
> The functional testing framework includes a utility function
> scratch_file() which you can use to get a path for a scratch
> file to use in the test. However, it doesn't do anything to
> ensure that the path it returns doesn't already exist.
> Should it?

No, we need to be able to use scratch_file() to refer to
previously created resources. For example, when we extract
files from an archive, we want to then reference those, or
when we uncompress a file.

> I ran into this with the aarch64/test_rme_sbsaref.py test:
> this does:
>         rme_stack = self.scratch_file('.')
> to get a scratch path, and then uses it both to place
> specific files:
>         pflash0 = join(rme_stack, 'out', 'SBSA_FLASH0.fd')
> and to place subdirectories:
>         efi = join(rme_stack, 'out', 'EFI')
>         os.makedirs(efi, exist_ok=True)
> 
> In the original version of this test we used os.mkdir(efi),
> but this fails sometimes because the directory already exists
> (typically if the test was interrupted during a previous run);
> see this email for the error log:
> https://lore.kernel.org/qemu-devel/CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.co/m

We have a tearDown function which purges everything under the
scratch dir location, so if a test is interrupted in a "normal"
way we should be safe on re-run. Only if python is hard-terminated
would the tearDown method fail to get run.

Perhaps we should proactively purge the scratch location in
the setUp method too, as a safety net against previous unclean
shutdown, as the intent of the 'scratch file' concept is that
the test should have a clean environment when it starts running.


> Secondary question: is it OK to pass '.' to this function
> and then construct filenames based on the return value,
> or would it be better to call scratch_file('out', 'SBSA_FLASH0.fd')
> etc and have the utility function construct the whole path?

My recommendation  / preferred coding style for func tests is to
always pass the set of sub-dir/file components to scratch_file(),
and never try to manually construct file paths using 'join'.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


