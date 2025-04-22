Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E0DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77JW-0000PB-4y; Tue, 22 Apr 2025 02:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u77JU-0000OJ-4k
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u77JR-0007lX-KC
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745304055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgNJcNeMcsSLKrSk4rBLJqZw3LYLW2wAAfHIes2MAbA=;
 b=de5yrCr3pDFzhOuzOUv+UiBgUJxFYKGYpSSaFK3nrq1+vEJedbNiU/i06Vh2UdQ5udJlz9
 Swp9OkxbnnM3KsqQ8/+9wMmxwJ6dzrJ3+4PIAJDZqaosdMdwW2bq4J19NqMv+m1S7B8Ro4
 +/k0M6+w97EWpgeriR2E13vLf08XYoo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-2dMMwvtTOzGkwABCi9HRtQ-1; Tue,
 22 Apr 2025 02:40:52 -0400
X-MC-Unique: 2dMMwvtTOzGkwABCi9HRtQ-1
X-Mimecast-MFC-AGG-ID: 2dMMwvtTOzGkwABCi9HRtQ_1745304051
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62DCE18001D5; Tue, 22 Apr 2025 06:40:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0112C180045C; Tue, 22 Apr 2025 06:40:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BDF3221E6768; Tue, 22 Apr 2025 08:40:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 5/5] qapi: delete un-needed python static analysis
 configs
In-Reply-To: <20250417213114.2336239-6-jsnow@redhat.com> (John Snow's message
 of "Thu, 17 Apr 2025 17:31:14 -0400")
References: <20250417213114.2336239-1-jsnow@redhat.com>
 <20250417213114.2336239-6-jsnow@redhat.com>
Date: Tue, 22 Apr 2025 08:40:48 +0200
Message-ID: <87fri08zrj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Since the previous commit, python/setup.cfg applies to scripts/qapi/ as
> well.  Configuration files in scripts/qapi/ override python/setup.cfg.
>
> scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
> python/setup.cfg exactly, and can go.
>
> The differences between scripts/qapi/mypy.ini and python/setup.cfg are
> harmless: warn_unused_configs is actually the default for strict, so
> this is vestigial.

Could you insert my "[PATCH] python: Drop redundant warn_unused_configs
= True" right before this patch, and delete the explanation?

>                    namespace_packages being set to True is a requirement
> for the PEP420 nested package structure of QEMU but not for
> scripts/qapi, but has no effect on type checking the QAPI
> code. warn_unused_ignores is used in python/ to be able to target a wide
> variety of mypy versions; some of which that have added new ignore
> categories that are not present in older versions.
>
> Ultimately, scripts/qapi/mypy.ini can be removed without any real change
> in behavior to how mypy enforces type safety there.
>
> The pylint config is being left in place because the settings differ
> enough from the python/ directory settings that we need a chit-chat on
> how to merge them O:-)
>
> Signed-off-by: John Snow <jsnow@redhat.com>


