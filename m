Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C94C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trvLw-0003Hs-NB; Tue, 11 Mar 2025 04:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvLr-0003H8-K7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trvLp-0008Mg-C6
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741683153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ncLU2ZbE4A761FZF+OdNaG2Gvx+GdVPySuEN9A0CkwA=;
 b=QGpCTzvwzl1ck4Q1HqSO8Wb4cCppW8QwhQrF7GannaFV4k7K+EqSysVgO+qdnNtnRV/nFy
 txAmcUFDK/QuszLNZ9+eherhWIr5r1hS7hm6xuZS2pZ0ohzixnHv4Sk4s7FNbvXSVT2KA4
 VPc1w149EGxxGs99V9iYNYFtGU0RKjE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-rQTeB4LSO_C7eiIZAKucgA-1; Tue,
 11 Mar 2025 04:52:31 -0400
X-MC-Unique: rQTeB4LSO_C7eiIZAKucgA-1
X-Mimecast-MFC-AGG-ID: rQTeB4LSO_C7eiIZAKucgA_1741683150
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4402E1828B26; Tue, 11 Mar 2025 08:52:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC1F19560AD; Tue, 11 Mar 2025 08:52:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0095621E66C4; Tue, 11 Mar 2025 09:52:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 00/63] docs: Add new QAPI transmogrifier
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com> (John Snow's message of
 "Mon, 10 Mar 2025 23:41:58 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 09:52:24 +0100
Message-ID: <875xkg54qf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> This series is a "minimum viable" version of the new QAPI documentation
> system. It does the bare minimum under the new framework, saving the
> fancy features like the inliner for later. This version does add
> cross-references for all QAPI definitions and a shiny new QAPI Index.

PATCH 01,02 are not for merge.

> Patches 3-31 implement the qapi_domain extension.

These patches
Acked-by: Markus Armbruster <armbru@redhat.com>

> Patches 32-59 implement the qapidoc "Transmogrifier".

These patches
Acked-by: Markus Armbruster <armbru@redhat.com>
except for PATCH 32-34,41,59, which are R-by instead, and PATCH 38,
which is not for merge.

Queued except for 01,02,38.  Expect a pull request later today.

[...]


