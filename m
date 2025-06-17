Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBD6C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYe3-0007us-BM; Tue, 17 Jun 2025 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRYMG-0006F7-7v
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uRUjw-0005KH-Ro
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 07:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750160668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ui2dokFBRe+yMsLoNKf9x65K9ZSJTOImNBpB+tNnWs=;
 b=GxCg5c/ijGWMlK71eEoNa+rGrDuUrnFGGcl6BpiakMwQ+Do29jfKKTKavFwZJ9VOSEsZ9g
 P31lpvwrcobJswnOT1hJaaEJ1o2U6wMYtf75UCAdGMsm6jHOnyjQtV0TgtmqM0CZCYIr47
 YGgafPq0umNvm64MQYECDkSnti7TBBk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-rZkC8GorPFaxyQ2KNxTMxA-1; Tue,
 17 Jun 2025 07:44:26 -0400
X-MC-Unique: rZkC8GorPFaxyQ2KNxTMxA-1
X-Mimecast-MFC-AGG-ID: rZkC8GorPFaxyQ2KNxTMxA_1750160665
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F151800290; Tue, 17 Jun 2025 11:44:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE1D195608F; Tue, 17 Jun 2025 11:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38E5921E6A27; Tue, 17 Jun 2025 13:44:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 4/6] python: add qapi static analysis tests
In-Reply-To: <20250605182014.561172-5-jsnow@redhat.com> (John Snow's message
 of "Thu, 5 Jun 2025 14:20:12 -0400")
References: <20250605182014.561172-1-jsnow@redhat.com>
 <20250605182014.561172-5-jsnow@redhat.com>
Date: Tue, 17 Jun 2025 13:44:22 +0200
Message-ID: <87plf2vbhl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Update the python tests to also check QAPI and the QAPI Sphinx
> extensions. The docs/sphinx/qapidoc_legacy.py file is not included in
> these checks, as it is destined for removal soon. mypy is also not
> called on the QAPI Sphinx extensions, owing to difficulties supporting
> Sphinx 3.x - 8.x while maintaining static type checking support. mypy
> *is* called on all of the QAPI tools themselves, though.
>
> flake8, isort and mypy use the tool configuration from the existing
> python directory (in setup.cfg). pylint continues to use the special
> configuration located in scripts/qapi/ - that configuration is more
> permissive. If we wish to unify the two configurations, that's a
> separate series and a discussion for a later date.
>
> The list of pylint ignores is also updated, owing again to the wide
> window of pylint version support: newer versions require pragmas to
> occasionally silence the "too many positional arguments" warning, but
> older versions do not have such a warning category and will instead yelp
> about an unrecognized option. Silence that warning, too.
>
> As a result of this patch, one would be able to run any of the following
> tests locally from the qemu.git/python directory and have it cover the
> QAPI tooling as well. All of the following options run the python tests,
> static analysis tests, and linter checks; but with different
> combinations of dependencies and interpreters.
>
> - "make check-minreqs" Run tests specifically under our oldest supported
>   Python and our oldest supported dependencies. This is the test that
>   runs on GitLab as "check-python-minreqs". This helps ensure we do not
>   regress support on older platforms accidentally.
>
> - "make check-tox" Runs the tests under the newest supported
>   dependencies, but under each supported version of Python in turn. At
>   time of writing, this is Python 3.8 to 3.13 inclusive. This test helps

Missed this: it's 3.9 since

commit d64db833d6e3cbe9ea5f36342480f920f3675cea
Author: Thomas Huth <thuth@redhat.com>
Date:   Fri Apr 25 14:07:10 2025 +0200

    Drop support for Python 3.8
=20=20=20=20
    Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
    this version already, so the "python" CI job is currently failing.
    Thus it's time to drop support for this Python version in QEMU, too.
=20=20=20=20
    While we're at it, also look for "python3.13" in the configure script.
=20=20=20=20
    Message-ID: <20250425120710.879518-1-thuth@redhat.com>
    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
    Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    Signed-off-by: Thomas Huth <thuth@redhat.com>

Too late to adjust the commit message.  Is there anything else in need
of adjustment?

[...]


