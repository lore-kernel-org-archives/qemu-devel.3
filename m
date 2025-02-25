Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA0C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtn3-0004f7-2J; Tue, 25 Feb 2025 07:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmtmu-0004el-4H
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmtmq-0007jh-SX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740485503;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhU4fU4HGrZRzrMTbc4d7sC1urs0CJhb6FwuyuYLqFY=;
 b=eVlxjMOSBIaop7wKQpSyn66kTgDI5YmoOql8H04sLs9mvSZzvT7TAcEgAfoPnIKHAtNLVL
 0Uxco7ApOA+/M1zTcH51Pmcbw5mtHE8QF+3RQTdj+8bprCVffW+tAGuSfwwydgKE4yR6b8
 bfE7zrispx85JqRJvDG8MtDx0QEFcP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-tWm0ZZrRMqeSslMztF88Ug-1; Tue,
 25 Feb 2025 07:11:39 -0500
X-MC-Unique: tWm0ZZrRMqeSslMztF88Ug-1
X-Mimecast-MFC-AGG-ID: tWm0ZZrRMqeSslMztF88Ug_1740485498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DE00180087F; Tue, 25 Feb 2025 12:11:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8626A1955BD4; Tue, 25 Feb 2025 12:11:36 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:11:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Victor Toso <victortoso@redhat.com>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] qapi: pluggable backend code generators
Message-ID: <Z72zdbM2GFq9OwXD@redhat.com>
References: <20250217134927.1288486-1-berrange@redhat.com>
 <87ikp5ujxi.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikp5ujxi.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 20, 2025 at 08:58:17AM +0100, Markus Armbruster wrote:
> Cc: John for advice on my somewhat nebulous mypy worries at the end.
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The 'qapi.backend.QAPIBackend' class defines an API contract for
> > code generators. The current generator is put into a new class
> > 'qapi.backend.QAPICBackend' and made to be the default impl.
> >
> > A custom generator can be requested using the '-k' arg which takes
> > a fully qualified python class name
> >
> >    qapi-gen.py -k the.python.module.QAPIMyBackend
> 
> I understand why that will be useful, but explaining it briefly in the
> commit message wouldn't hurt.

I expanded on this.


> > +class QAPIBackend(ABC):
> > +
> > +    def run(self,
> > +            schema_file: str,
> > +            output_dir: str,
> > +            prefix: str,
> > +            unmask: bool = False,
> > +            builtins: bool = False,
> > +            gen_tracing: bool = False) -> None:
> > +        """
> > +        Run the code generator for the given schema into the target directory.
> > +
> > +        :param schema_file: The primary QAPI schema file.
> > +        :param output_dir: The output directory to store generated code.
> > +        :param prefix: Optional C-code prefix for symbol names.
> > +        :param unmask: Expose non-ABI names through introspection?
> > +        :param builtins: Generate code for built-in types?
> > +
> > +        :raise QAPIError: On failures.
> > +        """
> > +        assert invalid_prefix_char(prefix) is None
> > +
> > +        schema = QAPISchema(schema_file)
> 
> Hmm.  This makes the backend run the frontend.  Could we keep this in
> main.py instead?

Yes, that is better, and eliminates the need for the extra
'run' method to call 'generate'.

> > +        self.generate(schema, output_dir, prefix, unmask, builtins, gen_tracing)
> > +
> > +    @abstractmethod
> > +    def generate(self,
> > +                 schema: QAPISchema,
> > +                 output_dir: str,
> > +                 prefix: str,
> > +                 unmask: bool,
> > +                 builtins: bool,
> > +                 gen_tracing: bool) -> None:
> > +        """
> > +        Generate code for the given schema into the target directory.
> > +
> > +        :param schema: The primary QAPI schema object.
> > +        :param output_dir: The output directory to store generated code.
> > +        :param prefix: Optional C-code prefix for symbol names.
> > +        :param unmask: Expose non-ABI names through introspection?
> > +        :param builtins: Generate code for built-in types?
> > +
> > +        :raise QAPIError: On failures.
> > +        """
> > +        pass
> 
> pylint prefers not to pass:
> 
>     scripts/qapi/backend.py:68:8: W0107: Unnecessary pass statement (unnecessary-pass)

Fun, I expected it to be a syntax error to not have a statement in the
method body, but pylint is right.


> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 324081b9fc..35552dffce 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -8,53 +8,18 @@
> >  """
> >  
> >  import argparse
> > +from importlib import import_module
> >  import sys
> > -from typing import Optional
> >  
> > -from .commands import gen_commands
> > -from .common import must_match
> >  from .error import QAPIError
> > -from .events import gen_events
> > -from .features import gen_features
> > -from .introspect import gen_introspect
> > -from .schema import QAPISchema
> > -from .types import gen_types
> > -from .visit import gen_visit
> > +from .backend import invalid_prefix_char
> 
> isort wants you to put this above from .error, like this:
> 
>    from .backend import invalid_prefix_char
>    from .error import QAPIError

Yep, I forgot we sorted imports


> > +def import_class_from_string(path):
> > +    module_path, _, class_name = path.rpartition('.')
> > +    mod = import_module(module_path)
> > +    klass = getattr(mod, class_name)
> > +    return klass
> 
> Lacks error handling, see appended test cases.
> 
> Moreover, mypy points out
> 
>     scripts/qapi/main.py:18: error: Function is missing a type annotation  [no-untyped-def]
> 
> The argument is str, but what is returned?
> 
> The function name suggests it returns a class.
> 
> As coded, the function could return pretty much anything.
> 
> The caller actually needs a QAPIBackend class.
> 
> We need a checked cast to QAPIBackend class somewhere.  If you put it in
> this function, it returns a QAPIBackend class, and its name should be
> adjusted accordingly.  import_backend() maybe?

Yeah, with all the error checking needed for the scenarios you
illustrate below, this method was better turned into a more
specialized "create_backend" method.

> 
> >  
> >  
> >  def main() -> int:
> > @@ -77,6 +42,8 @@ def main() -> int:
> >      parser.add_argument('-u', '--unmask-non-abi-names', action='store_true',
> >                          dest='unmask',
> >                          help="expose non-ABI names in introspection")
> > +    parser.add_argument('-k', '--backend', default="qapi.backend.QAPICBackend",
> 
> Any particular reason for picking -k for --backend?

There is a 'k' in 'backend' was the extent of my decision making:-)

> -b is taken, but -B would be available.

I've used -B now.


> > @@ -92,13 +59,15 @@ def main() -> int:
> >          print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
> >          return 1
> >  
> > +    backendclass = import_class_from_string(args.backend)
> >      try:
> > -        generate(args.schema,
> > -                 output_dir=args.output_dir,
> > -                 prefix=args.prefix,
> > -                 unmask=args.unmask,
> > -                 builtins=args.builtins,
> > -                 gen_tracing=not args.suppress_tracing)
> > +        backend = backendclass()
> > +        backend.run(args.schema,
> > +                    output_dir=args.output_dir,
> > +                    prefix=args.prefix,
> > +                    unmask=args.unmask,
> > +                    builtins=args.builtins,
> > +                    gen_tracing=not args.suppress_tracing)
> >      except QAPIError as err:
> >          print(err, file=sys.stderr)
> >          return 1
> 
> The connection to the backend moves to run-time: static import
> statements get replaced by a dynamic import_module().  Fine, it's what
> it takes to support pluggable backends.
> 
> However, it might hide the bundled backend from tools like mypy.  Would
> that be bad?  I'm not sure.
> 
> If it is, we could avoid it pretty easily: instead of defaulting the
> module name, so we dynamically load the bundled backend module by
> default, default the class, so we create the bundled backend class by
> default.

Yes, in v2 I've kept QAPICBackend as an explicit import so we
avoid any questions about hiding from mypy.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


