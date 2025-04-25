Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A3C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 06:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8CHP-0001Q3-IV; Fri, 25 Apr 2025 02:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8CHN-0001PR-RG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8CHL-0001D5-59
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 02:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745561473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gol0gbuqyk32LqFeT7gwdf+qJyTFT7UZ5mT1uOEKlNU=;
 b=BDch9VNYajw+Ko9Dt8ksegMz7EUUu3UIWxZRFSY+aD2vMTf8E6ggsF9fphJ0sZOs327f+K
 ZJefBT8bW0XUxxgd7JjPQqPRJbvQc14lce2z55U+x7xLlgDKh4lMggIHeHk6sz2UIpNPjA
 RtLoRkVvvmjm6Q4UtCusVCK2jqhJHc0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-63E4rpAHNAqQM0H3TLRY5g-1; Fri,
 25 Apr 2025 02:11:11 -0400
X-MC-Unique: 63E4rpAHNAqQM0H3TLRY5g-1
X-Mimecast-MFC-AGG-ID: 63E4rpAHNAqQM0H3TLRY5g_1745561470
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 509581956095; Fri, 25 Apr 2025 06:11:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5197195608D; Fri, 25 Apr 2025 06:11:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DE9321E66C3; Fri, 25 Apr 2025 08:11:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Cleber
 Rosa <crosa@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/6] python: add QAPI and qapidoc et al to python
 linter tests
In-Reply-To: <20250424210904.2505114-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 24 Apr 2025 17:08:58 -0400")
References: <20250424210904.2505114-1-jsnow@redhat.com>
Date: Fri, 25 Apr 2025 08:11:07 +0200
Message-ID: <87ikmsixdw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Hiya, this series turns on automated linting for scripts/qapi,
> docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.
>
> This includes flake8/isort/pylint/mypy for scripts/qapi, but omits mypy
> from the Sphinx plugins owing to my inability to strictly type the
> extensions given the wide versions of Sphinx we actually support.
>
> Though I have been using black in my own development, I have not yet
> enabled it anywhere automatically. Maybe soon.
>
> NOTE: the latest Fedora image doesn't have Python38 anymore; this series
> does not address that. A more substantial fix for testing will be
> forthcoming.

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>


