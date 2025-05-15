Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BE4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFU7M-0006d9-GC; Thu, 15 May 2025 04:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFU7I-0006ch-6m
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFU7G-0004cz-By
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747298335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Msc9NWa8vD+rgTN1oesOnMYyQfuwzO91FOM9Ti89hWY=;
 b=DOufpLBIMK07RUAAbngmrbrNncD04QmvFM14NcQ/d+ltX0YR/K1EZCAJyx3BJSV62CD7vU
 NIrtnzHD41IY5hC51WJEaPNsP11g5iiMKh9y0/zPB4PsOMFG0ViRDYC03c/NVw4kVvfibd
 SA+ZSyY5hnrm9AkzzE7IJCL+nUXHu3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-OypRIKMVNfS60HQX0KvHvw-1; Thu,
 15 May 2025 04:38:54 -0400
X-MC-Unique: OypRIKMVNfS60HQX0KvHvw-1
X-Mimecast-MFC-AGG-ID: OypRIKMVNfS60HQX0KvHvw_1747298333
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8EA1956050; Thu, 15 May 2025 08:38:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE6CF1956066; Thu, 15 May 2025 08:38:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43BAA21E66E3; Thu, 15 May 2025 10:38:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v4 0/6] python: add QAPI and qapidoc et al to python tests
In-Reply-To: <20250512193357.3388514-1-jsnow@redhat.com> (John Snow's message
 of "Mon, 12 May 2025 15:33:51 -0400")
References: <20250512193357.3388514-1-jsnow@redhat.com>
Date: Thu, 15 May 2025 10:38:50 +0200
Message-ID: <87o6vu2rqd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
> [Maybe this will change soon, but it's not true just yet.]
>
> Though I have been using black in my own development, I have not yet
> enabled it anywhere automatically. Maybe soon.

You lost my series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

:)


