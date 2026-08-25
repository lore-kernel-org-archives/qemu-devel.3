Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A69C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyl3k-0003Aj-Nw; Tue, 25 Aug 2026 02:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyl3j-0003AY-50
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyl3h-0003nO-NA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787640895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdCq4JNB1CvxXilXe4cbo+rB4hiFA/p6L/HXPsEYRpc=;
 b=czQnaE/icYjmeyF/kOnqNlTP3qKZMQhUZR9ExMGmpuZHuPw0WOuo0luAI1gA4iUTFi47UU
 MkUgOxnIi8mswlZNH86HJ3K8ZTTI81/aRXaGcjW4FWh2D4yVw6reFrYWLaeKSdYMBc4ZJ6
 BuI3A/PKxeSGPc9AvKWfnBphzkWULYw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-7SO2X1A7PduWcuJrfR78kQ-1; Tue,
 25 Aug 2026 02:54:52 -0400
X-MC-Unique: 7SO2X1A7PduWcuJrfR78kQ-1
X-Mimecast-MFC-AGG-ID: 7SO2X1A7PduWcuJrfR78kQ_1787640891
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01B4195F161; Tue, 25 Aug 2026 06:54:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9BF1426; Tue, 25 Aug 2026 06:54:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7DC5621E6920; Tue, 25 Aug 2026 08:54:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@mailo.com>,  Warner Losh <imp@bsdimp.com>,  Kohei Tokunaga
 <ktokunaga.mail@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Kyle Evans <kevans@freebsd.org>,  Michael Roth
 <michael.roth@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 16/16] sphinx: drop qapidoc back-compat overboiled
 spaghetti dinner
In-Reply-To: <20260825051441.1562454-17-jsnow@redhat.com> (John Snow's message
 of "Tue, 25 Aug 2026 01:14:41 -0400")
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-17-jsnow@redhat.com>
Date: Tue, 25 Aug 2026 08:54:47 +0200
Message-ID: <87pkz6pu4o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Drop the disgusting amount of hacks required to keep qapidoc working
> on older Sphinx versions, enjoying the cutting edge technology of
> 2023.
>
> This felt like an achievement to have written, and equally feels an
> achievement to have deleted.
>
> A note on the content_node parameter: Sphinx has been gradually
> implementing typing support and renaming parameters to be
> consistent. As a result of losing our intermediate compatibility shim,
> mypy and pylint now check directly against the Sphinx version. So,
> alongside removing compat gunk, we need to fix up some parameter
> naming for the Sphinx upgrade, too.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This repays the technical debt you had to take on to make the rewritten
Sphinx QAPI doc extension work, which massively improved the rendering
of QMP and QGA reference manuals.  The impressive and ugly work goes,
the impressive and lovely work stays.  Thank you!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


