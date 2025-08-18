Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD20ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 15:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo1Uh-0005AN-64; Mon, 18 Aug 2025 11:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo1Ue-00059v-KV
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo1Uc-0000tx-Ti
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 11:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755529789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZfg/gADMq+6dY/eFTqZCkyaFl1t7eWl62cMvKJPE7s=;
 b=gIhcVtAs7PULRbjLiGNiVafhAE9ko4AlGKWFnNnfff8AIXc9CLMDTG5Y3t0gRXX09vboMg
 Hn9Kvn8OrMfZKFuyM3nQS6BkCsY1w59pDKaVCvVmabqa+EJ3CYPbzKzajQRj+tsGE/Q4FG
 xxK5gsD5sSW92gz9T8dZAJWoPSD77MA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-l74ADJm2OXW3xktudD-iSw-1; Mon,
 18 Aug 2025 11:09:46 -0400
X-MC-Unique: l74ADJm2OXW3xktudD-iSw-1
X-Mimecast-MFC-AGG-ID: l74ADJm2OXW3xktudD-iSw_1755529785
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193911955D61; Mon, 18 Aug 2025 15:09:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B19ED180028A; Mon, 18 Aug 2025 15:09:41 +0000 (UTC)
Date: Mon, 18 Aug 2025 16:09:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 8/8] qapi: switch to use QEMU_TEST_REGENERATE env var
Message-ID: <aKNCMR9N85AVsyMT@redhat.com>
References: <20250806164832.1382919-1-berrange@redhat.com>
 <20250806164832.1382919-9-berrange@redhat.com>
 <87cy96mhu5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cy96mhu5.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 08:46:10AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The QAPI_TEST_UPDATE env var can be set when running the QAPI
> > schema tests to regenerate the reference output. For consistent
> > naming with the tracetool test, change the env var name to
> > QEMU_TEST_REGENERATE.
> >
> > The test is modified to provide a hint about use of the new
> > env var and it is also added to the developer documentation.document its usage.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/testing/main.rst    | 12 ++++++++++++
> >  tests/qapi-schema/test-qapi.py |  7 +++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> > index 11f05c0006..fe233fcf7a 100644
> > --- a/docs/devel/testing/main.rst
> > +++ b/docs/devel/testing/main.rst
> > @@ -178,6 +178,18 @@ parser (either fixing a bug or extending/modifying the syntax). To do this:
> >  
> >    ``qapi-schema += foo.json``
> >  
> > +The reference output can be automatically updated to match the latest QAPI
> > +code generator by running the tests with the QEMU_TEST_REGENERATE environment
> > +variable set.
> > +
> > +.. code::
> > +
> > +   QEMU_TEST_REGENERATE=1 make check-qapi-schema
> > +
> > +The resulting changes must be reviewed by the author to ensure they match
> > +the intended results, before adding the updated reference output to the
> 
> Not sure about the comma.  I'm not a native speaker, though.

Yeah, the comma is redundant

> > +same commit that alters the generator code.
> > +
> >  .. _tracetool-tests:
> >  
> >  Tracetool tests
> > diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> > index 4be930228c..cf7fb8a6df 100755
> > --- a/tests/qapi-schema/test-qapi.py
> > +++ b/tests/qapi-schema/test-qapi.py
> > @@ -165,7 +165,7 @@ def test_and_diff(test_name, dir_name, update):
> >      if actual_out == expected_out and actual_err == expected_err:
> >          return 0
> >  
> > -    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> > +    print("%s: %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> 
> Is there a need for this, or is it just drive-by polishing?

Just making it more consistent in style with other error print()
statements we have in the file, as well as this new one I'm
adding.


> 
> >            file=sys.stderr)
> >      out_diff = difflib.unified_diff(expected_out, actual_out, outfp.name)
> >      err_diff = difflib.unified_diff(expected_err, actual_err, errfp.name)
> > @@ -173,6 +173,9 @@ def test_and_diff(test_name, dir_name, update):
> >      sys.stdout.writelines(err_diff)
> >  
> >      if not update:
> > +        print(("\n%s: set QEMU_TEST_REGENERATE=1 to recreate reference output" +
> > +               "if the QAPI schema generator was intentionally changed") % test_name,
> > +              file=sys.stderr)
> >          return 1
> >  
> >      try:
> > @@ -197,7 +200,7 @@ def main(argv):
> >      parser.add_argument('-d', '--dir', action='store', default='',
> >                          help="directory containing tests")
> >      parser.add_argument('-u', '--update', action='store_true',
> > -                        default='QAPI_TEST_UPDATE' in os.environ,
> > +                        default='QEMU_TEST_REGENERATE' in os.environ,
> >                          help="update expected test results")
> >      parser.add_argument('tests', nargs='*', metavar='TEST', action='store')
> >      args = parser.parse_args()
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


