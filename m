Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFAD7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI5As-00080u-VL; Mon, 02 Dec 2024 07:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Al-0007ur-HS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI5Aj-0005Bm-9f
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 07:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733141100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q31lHkN5ecN6uYOgMvneVhYFZm6AvdSWJvrjauCqsGY=;
 b=iw5spTW2ptvGqh6bnegTmYa/azwS91ytnwXfZJ0T1aK7DPI+xlbdARjHzpJT6kbhexM5xR
 sxG49C+FIIyuj9wnSi4WguBBEzu3U0HgkEi0iwgpADuMBiy7mSSPK2kTEeOxn8Taau15ql
 tNnQG0attOD0Sr3EowHbHIinPD9rOyI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-_lI4zF1rOUeWiGYrr6gpnQ-1; Mon,
 02 Dec 2024 07:04:58 -0500
X-MC-Unique: _lI4zF1rOUeWiGYrr6gpnQ-1
X-Mimecast-MFC-AGG-ID: _lI4zF1rOUeWiGYrr6gpnQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BBDB1955DBD; Mon,  2 Dec 2024 12:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64F991956052; Mon,  2 Dec 2024 12:04:55 +0000 (UTC)
Date: Mon, 2 Dec 2024 12:04:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 15/22] tests/functional: add common zip_extract helper
Message-ID: <Z02iYw9K7nInTyjY@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-16-berrange@redhat.com>
 <068fdd45-924f-4dd5-8bb4-447402f1c5e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <068fdd45-924f-4dd5-8bb4-447402f1c5e4@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 02, 2024 at 11:04:12AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > This mirrors the existing archive_extract and cpio_extract helpers
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/utils.py | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
> > index 1bf1c410d5..41bd1df666 100644
> > --- a/tests/functional/qemu_test/utils.py
> > +++ b/tests/functional/qemu_test/utils.py
> > @@ -46,6 +46,13 @@ def archive_extract(archive, dest_dir, member=None):
> >           else:
> >               tf.extractall(path=dest_dir)
> > +def zip_extract(archive, dest_dir, member=None):
> > +    with zipfile.ZipFile(archive, 'r') as zf:
> > +        if member:
> > +            zf.extract(member=member, path=dest_dir)
> > +        else:
> > +            zf.extractall(path=dest_dir)
> 
> Don't you need to "import zipfile" here now, too?

Yes, now I'm wondering how my testing passed - wonder if this is only
being used from some skipped tests that I forgot to exercise.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


