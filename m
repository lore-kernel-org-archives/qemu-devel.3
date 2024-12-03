Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA93CE6C616
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 08:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIO0x-0004S3-PZ; Tue, 03 Dec 2024 03:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIO0v-0004Rn-Mn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIO0u-000138-2h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 03:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733213527;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+wwFyIUU5avq2gAWwmP9/waa5PL61MA0EX17PoZE+k=;
 b=PMMexuKLboAd8j9w95HO+9G+7+eGTJObMTNXVoQLM/bw3Xiip0uQRpLKxqwGbY2EUrnRBW
 H7eRkkSCdnTFiVOsh6i4P+9wg+gJPNUbolT1wryyOClnVUoJYTO3bClzHHyVyeaGX7rGJS
 N/yPUdNqn5xT70Jv0dQDFQhkNN6p2XU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-XBi4polhNjONIYpmfptAMg-1; Tue,
 03 Dec 2024 03:12:05 -0500
X-MC-Unique: XBi4polhNjONIYpmfptAMg-1
X-Mimecast-MFC-AGG-ID: XBi4polhNjONIYpmfptAMg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC0C719560BC; Tue,  3 Dec 2024 08:12:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025471955D45; Tue,  3 Dec 2024 08:12:01 +0000 (UTC)
Date: Tue, 3 Dec 2024 08:11:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 11/22] tests/functional: switch over to using
 self.data_file(...)
Message-ID: <Z069ThRGuxIH1YVt@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-12-berrange@redhat.com>
 <544db3ce-f37b-4c09-85f5-b6ad96708292@redhat.com>
 <CAK3XEhMJLQ9TE+_pGHk=bkyV6GsDbC15VTavKgWHs75j7=7Big@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhMJLQ9TE+_pGHk=bkyV6GsDbC15VTavKgWHs75j7=7Big@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Tue, Dec 03, 2024 at 11:09:14AM +0530, Ani Sinha wrote:
> On Mon, Dec 2, 2024 at 3:02 PM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > > This removes direct path manipulation to figure out the source dir
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   tests/functional/test_acpi_bits.py | 22 +++++++---------------
> > >   1 file changed, 7 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
> > > index 4de5fae37e..948b134b16 100755
> > > --- a/tests/functional/test_acpi_bits.py
> > > +++ b/tests/functional/test_acpi_bits.py
> > > @@ -41,7 +41,6 @@
> > >   import tempfile
> > >   import zipfile
> > >
> > > -from pathlib import Path
> > >   from typing import (
> > >       List,
> > >       Optional,
> > > @@ -122,7 +121,6 @@ class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
> > >       def __init__(self, *args, **kwargs):
> > >           super().__init__(*args, **kwargs)
> > >           self._vm = None
> > > -        self._baseDir = None
> > >
> > >           self._debugcon_addr = '0x403'
> > >           self._debugcon_log = 'debugcon-log.txt'
> > > @@ -137,26 +135,22 @@ def _print_log(self, log):
> > >       def copy_bits_config(self):
> > >           """ copies the bios bits config file into bits.
> > >           """
> > > -        config_file = 'bits-cfg.txt'
> > > -        bits_config_dir = os.path.join(self._baseDir, 'acpi-bits',
> > > -                                       'bits-config')
> > > +        bits_config_file = self.data_file('acpi-bits',
> 
> I do not understand, Where is data_file coming from? AFAICS its not
> there in QemuBaseTest or QemuSystemTest or unittest.TestCase
> https://docs.python.org/3/library/unittest.html#unittest.TestCase
> 
> what am I missing or failing to see?

It is coming from patch 6 :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


