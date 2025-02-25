Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54480C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmq66-0007gf-8e; Tue, 25 Feb 2025 03:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmq63-0007gA-M2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmq5y-00045Z-K0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740471312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkRx57SfpfBR44BQeKjf5mSFKTxvgvdOgb7ypLvIXNU=;
 b=hZWm6mLGnSvLEKxPzS/a+M/3XWZxw+L2XdL3R64tj7rBdmbSUZ52jow5cMHFMDq7fFH9QE
 +kJk/EADHJhgtmAqxdF5Zz3PDoMagiM4OGm/vHMa3r+mZMWdHdb3rdjVzOQRM5CkDavnTT
 Sj6Ql5z6UckqBDtJ+/CPQQBi/brgHio=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-0ktU5mHCPpuY_AzSDknNzQ-1; Tue,
 25 Feb 2025 03:15:07 -0500
X-MC-Unique: 0ktU5mHCPpuY_AzSDknNzQ-1
X-Mimecast-MFC-AGG-ID: 0ktU5mHCPpuY_AzSDknNzQ_1740471306
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A25351801A1C; Tue, 25 Feb 2025 08:15:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FA5A19560A3; Tue, 25 Feb 2025 08:15:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1EA121E6741; Tue, 25 Feb 2025 09:15:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 05/10] qapi/parser: adjust info location for doc body
 section
In-Reply-To: <20250224033741.222749-6-jsnow@redhat.com> (John Snow's message
 of "Sun, 23 Feb 2025 22:37:36 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-6-jsnow@redhat.com>
Date: Tue, 25 Feb 2025 09:15:02 +0100
Message-ID: <87mseacuex.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

> Instead of using the info object for the doc block as a whole (which
> always points to the very first line of the block), update the info
> pointer for each call to ensure_untagged_section when the existing
> section is otherwise empty. This way, Sphinx error information will
> match precisely to where the text actually starts.
>
> For example, this patch will move the info pointer for the "Hello!"
> untagged section ...
>
>> ##       <-- from here ...
>> # Hello! <-- ... to here.
>> ##
>
> Signed-off-by: John Snow <jsnow@redhat.com>

This patch would be easier to accept with a test case where it improves
the error location.  I tried to construct one quickly, but failed.  Can
you help?


