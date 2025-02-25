Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD2DC021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuE7-0002Qp-KV; Tue, 25 Feb 2025 07:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmuE5-0002Qf-LB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:39:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmuE0-0002vZ-JM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740487186;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL8JVxIFwjtX9fF1kRYqg5eSq3ZwSVh+vhf7ANOCzR4=;
 b=MeInLe+54rRS8RvCd81p/+tm6TUuouy7QrPDZhKdI9uGQb+5E5hViLSkidmh4nIuklvKDM
 PXYKIo2IvC4XMnxNwcelsI1bE/tEdMTgMo4J6GnwHk8aOwsd1BnrgS9RkyHG3nHxRz+fBx
 FUTyBEt0PyWDnO4y+UwGFQayeGYFUjU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-qnGuozgZP3CZe0srW0bKTw-1; Tue,
 25 Feb 2025 07:39:42 -0500
X-MC-Unique: qnGuozgZP3CZe0srW0bKTw-1
X-Mimecast-MFC-AGG-ID: qnGuozgZP3CZe0srW0bKTw_1740487181
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12E4F196E078; Tue, 25 Feb 2025 12:39:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A7A819560AE; Tue, 25 Feb 2025 12:39:37 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:39:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Victor Toso <victortoso@redhat.com>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2] qapi: pluggable backend code generators
Message-ID: <Z726Bod5m07H-euc@redhat.com>
References: <20250224182030.2089959-1-berrange@redhat.com>
 <87msea9pdv.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msea9pdv.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Tue, Feb 25, 2025 at 01:31:56PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The 'qapi.backend.QAPIBackend' class defines an API contract for code
> > generators. The current generator is put into a new class
> > 'qapi.backend.QAPICBackend' and made to be the default impl.
> >
> > A custom generator can be requested using the '-k' arg which takes a
> 
> Missed an instance of -k.  Can fix this myself.
> 
> > fully qualified python class name
> >
> >    qapi-gen.py -B the.python.module.QAPIMyBackend
> >
> > This allows out of tree code to use the QAPI generator infrastructure
> > to create new language bindings for QAPI schemas. This has the caveat
> > that the QAPI generator APIs are not guaranteed stable, so consumers
> > of this feature may have to update their code to be compatible with
> > future QEMU releases.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---

> > -def generate(schema_file: str,
> > -             output_dir: str,
> > -             prefix: str,
> > -             unmask: bool = False,
> > -             builtins: bool = False,
> > -             gen_tracing: bool = False) -> None:
> > -    """
> > -    Generate C code for the given schema into the target directory.
> > +def create_backend(path: str) -> QAPIBackend:
> > +    if path is None:
> > +        return QAPICBackend()
> >  
> > -    :param schema_file: The primary QAPI schema file.
> > -    :param output_dir: The output directory to store generated code.
> > -    :param prefix: Optional C-code prefix for symbol names.
> > -    :param unmask: Expose non-ABI names through introspection?
> > -    :param builtins: Generate code for built-in types?
> > +    if "." not in path:
> > +        print(f"Missing qualified module path in '{path}'", file=sys.stderr)
> > +        sys.exit(1)
> >  
> > -    :raise QAPIError: On failures.
> > -    """
> > -    assert invalid_prefix_char(prefix) is None
> > +    module_path, _, class_name = path.rpartition('.')
> 
> I'd like to tweak this to
> 
>        module_path, dot, class_name = path.rpartition('.')
>        if not dot:
>            print(f"argument of -B must be of the form MODULE.CLASS",
>                  file=sys.stderr)
>            sys.exit(1)

Yep, sure thing.

> 
> > +    try:
> > +        mod = import_module(module_path)
> > +    except Exception as ex:
> 
> pylint complains:
> 
>     scripts/qapi/main.py:39:11: W0718: Catching too general exception Exception (broad-exception-caught)
> 
> I can't see offhand what exception(s) we're supposed to catch here, so
> let's not worry about this now.

Yeah, I was concerned that by putting specialized exception
classes here, we would miss some possible scenarios, and IMHO
the completeness of catching Exception is better than the
technical purity of pylint's complaint. 


> > +    if not hasattr(mod, class_name):
> > +        print(f"Module '{module_path}' has no class '{class_name}'", file=sys.stderr)
> 
> pycodestyle-3 complains:
> 
>     scripts/qapi/main.py:44:80: E501 line too long (85 > 79 characters)
> 
> Let's break the line after the comma, and also start the error message
> in lower case for consistency with error messages elsewhere.
> 
> > +        sys.exit(1)
> > +    klass = getattr(mod, class_name)
> 
> Alternatively
> 
>        try:
>            klass = getattr(mod, class_name)
>        except AttributeError:
>            print(f"module '{module_path}' has no class '{class_name}'",
>                  file=sys.stderr)
>            sys.exit(1)
> 
> Admittedly a matter of taste.  I tend to avoid the
> 
>     if frobnicate would fail:
>         error out
>     frobnicate
> 
> pattern when practical.

I guess I tend to avoid using exception catching for such flow
control, but I don't mind that much either way.


> > -    schema = QAPISchema(schema_file)
> > -    gen_types(schema, output_dir, prefix, builtins)
> > -    gen_features(schema, output_dir, prefix)
> > -    gen_visit(schema, output_dir, prefix, builtins)
> > -    gen_commands(schema, output_dir, prefix, gen_tracing)
> > -    gen_events(schema, output_dir, prefix)
> > -    gen_introspect(schema, output_dir, prefix, unmask)
> > +        return backend
> > +    except Exception as ex:
> 
> Likewise too general exception.
> 
> I'd like to shrink the try block and reduce the nesting:
> 
>        try:
>            backend = klass()
>        except Exception as ex:
>            print(f"Backend '{path}' cannot be instantiated: {ex}", file=sys.stderr)
>            sys.exit(1)
> 
>        if not isinstance(backend, QAPIBackend):
>            print(f"Backend '{path}' must be an instance of QAPIBackend", file=sys.stderr)
>            sys.exit(1)
> 
>        return backend

Sure, fine with me.


> Good enough.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> No need to respin, I can make the tweaks I suggested myself.  Feel free
> to challenge my suggestions, of course.

Thank you, it is all fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


