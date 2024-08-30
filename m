Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530EECA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzgM-0003pO-Vv; Fri, 30 Aug 2024 07:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjzgL-0003jp-KY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjzgJ-0007YF-VX
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725016843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIu01+iaPPuX8ZyhNpaeHCroqd/3D86Rx8HIHUEG9aQ=;
 b=c/eKyd7K4FhoG3Yr0WZld9nJUeiqeExsBACTlHe/Bwv8tQ0vmHK48GbN8L2s8M2BBn9YTW
 XHN5xpczK3cnFBS3bXcqLqxhCUMSt13QeoLPrzw/LiiJynPd55E0kJPNxK+C730e2sXw+b
 aH2YJgUC9ZQbx6jQwqY52sY8jNuH+j4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-EXXE83-3M72nOGz5iE33Cg-1; Fri,
 30 Aug 2024 07:20:38 -0400
X-MC-Unique: EXXE83-3M72nOGz5iE33Cg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3DB41954B2F; Fri, 30 Aug 2024 11:20:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 483481956048; Fri, 30 Aug 2024 11:20:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21C2221E6A28; Fri, 30 Aug 2024 13:20:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
In-Reply-To: <20240820002318.1380276-8-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 Aug 2024 20:23:16 -0400")
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
Date: Fri, 30 Aug 2024 13:20:35 +0200
Message-ID: <87bk1acl4s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> This is being done for the sake of unifying the linting and static type
> analysis configurations between scripts/qapi and python/qemu/*.
>
> With this change, the qapi module will now be checked by mypy, flake8,
> pylint, isort etc under all python versions from 3.8 through 3.13 under
> a variety of different dependency configurations in the GitLab testing
> pipelines.
>
> The tests can be run locally, as always:
>
>> cd qemu.git/python
>> make check-minreqs
>> make check-tox
>> make check-dev
>
> "check-minreqs" is the must-pass GitLab test.
> "check-tox" is the optional allowed-to-fail GitLab test.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I don't understand why we have to keep Python code in its own directory
just to get it checked.  We wouldn't do that say for Rust code, would
we?  Anyway, if it's the price of checking, I'll pay[*].

[...]

> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index f3518d29a54..42912c91716 100644
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -11,9 +11,11 @@
>  execution environment.
>  """
>  
> +import os
>  import sys
>  
> -from qapi import main
> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
> +from qemu.qapi import main
>  
>  if __name__ == '__main__':
>      sys.exit(main.main())

Suggest to use the opportunity to rename to just qapi-gen (no .py) and
chmod +x, possibly in a separate patch.

[...]


[*] Grudgingly.


