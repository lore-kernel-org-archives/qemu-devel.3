Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208ACC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEMD-0000BO-CJ; Wed, 26 Feb 2025 05:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEMB-0000Am-Sp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEM6-000155-Ib
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740564569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8GfFnJOfXeT4FHfwDwNrTxytL0CKV3CwzTnVNcvhu0M=;
 b=I0wxkcQrqXvY6b+OJviH9GxYqfh8WbL3JLvOMlYZgtPeIBmPXHstqU8rpapjqJpRbiPNry
 kdywrSVAi7qoSs5IhlYvPomGlmj2GVOX8uRLY+9uQYQBZrno3qVVDBvhn8ig7PbIMctVCA
 M0bGFfDuAhz+qCPofh6KKsWi3g1+ZJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-ODgT81vCOOS2c8_stQxhHg-1; Wed,
 26 Feb 2025 05:09:25 -0500
X-MC-Unique: ODgT81vCOOS2c8_stQxhHg-1
X-Mimecast-MFC-AGG-ID: ODgT81vCOOS2c8_stQxhHg_1740564564
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC37F19373DC; Wed, 26 Feb 2025 10:09:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 729FC1800352; Wed, 26 Feb 2025 10:09:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDA5021E66B9; Wed, 26 Feb 2025 11:09:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Cleber Rosa <crosa@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/10] qapi: misc testing and doc patches
In-Reply-To: <20250224033741.222749-1-jsnow@redhat.com> (John Snow's message
 of "Sun, 23 Feb 2025 22:37:31 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
Date: Wed, 26 Feb 2025 11:09:21 +0100
Message-ID: <87r03lyq3y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1684045409
>
> This is a series of random qapi and documentation patches;
>
> Patches 1-3: Formalize QAPI python testing (finally ...)
> Patches 4-10: Miscellaneous patches and fixes related to the
> documentation overhaul project; but were standalone enough that they
> could be excised from a fairly lengthy series ...
>
> Markus: I think everything here is suitable for merging, even though
> some of it might lack a little context. The more I pull out of that big
> series, the easier that series will be to review :)
>
> Please stage as much as you feel comfortable doing, you can skip any
> individual patch at your discretion.

I'm queuing the no-brainers immediately: PATCH 01,02,04,06

I had a question on PATCH 03, and I'm holding the patch for now.

I'm not sure I like PATCH 05 without a case where it shows improvement.
I tried to find one, but no luck, yet.  Holding for now.

I still need to review PATCH 07 in detail.  Holding for now.

PATCH 08 depends on it.  Holding for now.

PATCH 09 has no use, yet.  I'd prefer you resubmit it together with
something that uses it, at your convenience.

Similar for PATCH 10.

I expect to queue the patches I'm holding, i.e. 03,05,07,08, in due
time.

Thanks!


