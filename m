Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F1BCA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uofNz-0000II-H1; Wed, 20 Aug 2025 05:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uofNx-0000Hs-M1
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uofNu-0003wI-Le
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755683129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dNaFxK6SMP/v3Qa2rgnfCcBBvOnb894f5VAoZsyv9IE=;
 b=BBuzrweKdjbjDyVZGj2v04wbSD5xJtGdCpEsm6zX4fAjS0XoEDJt9ZWO25Dlca3BH5mmP1
 EHkFLJ8TQHbBFCk+fKq+jHFnfqmQP0KPlh5pqhU6bX5BXK30VbEJ27FmDwkGsyRRdX54jk
 +Haz7vhl0tq1koNjDQq+lcZ5eBrAnb8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-IJfVsn1DNTOl_PwWoeQZUQ-1; Wed,
 20 Aug 2025 05:45:26 -0400
X-MC-Unique: IJfVsn1DNTOl_PwWoeQZUQ-1
X-Mimecast-MFC-AGG-ID: IJfVsn1DNTOl_PwWoeQZUQ_1755683125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC3741800352; Wed, 20 Aug 2025 09:45:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8457A180044F; Wed, 20 Aug 2025 09:45:21 +0000 (UTC)
Date: Wed, 20 Aug 2025 10:45:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 13/14] iotests/151: ensure subprocesses are cleaned up
Message-ID: <aKWZEYBOIjgNCEqS@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-14-berrange@redhat.com>
 <CAFn=p-ZveuA+4X5GkfPBxvcFESH43D48YWTiZnpo3GGKfkd0XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-ZveuA+4X5GkfPBxvcFESH43D48YWTiZnpo3GGKfkd0XA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 19, 2025 at 05:37:04PM -0400, John Snow wrote:
> On Tue, Jul 15, 2025 at 10:32 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The iotest 151 creates a bunch of subprocesses, with their stdout
> > connected to a pipe but never reads any data from them and does
> > not gurantee the processes are killed on cleanup.
> >
> > This triggers resource leak warnings from python when the
> > subprocess.Popen object is garbage collected.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/151 | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
> > index f2ff9c5dac..06ee3585db 100755
> > --- a/tests/qemu-iotests/151
> > +++ b/tests/qemu-iotests/151
> > @@ -263,6 +263,11 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
> >                          break
> >                      except subprocess.TimeoutExpired:
> >                          self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
> > +                try:
> > +                    p.kill()
> > +                    p.stdout.close()
> > +                except:
> > +                    pass
> 
> You can decide how much you care here, but using "except Exception:"
> will allow critical exceptions to still crash the program, like
> KeyboardInterrupt and SystemExit et al. It's good hygiene for things
> that may or may not hang so you can still use Ctrl+C.

Yes, that should be changed as you describe.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


