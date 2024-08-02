Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6ACC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsg6-0001t4-UL; Fri, 02 Aug 2024 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsg5-0001sX-1O
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsg3-0007QX-E5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722606637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q50kx/vfMc2AnBs+VgOFD4F7FT6qiyCEzCwj/d9t2gM=;
 b=PZDctU1lLCGC0Sbz6GWJc9ga+ZjgDwEI23x31iLerIAsUm2V1EAqa1f7Zpp531xnsksr9t
 /21kP4cwbY2Jfa+YMdYR05kXNE4R7EEHgK6SuZ6Wt/oGAmieO+ramut8L+HS2Y+7yqaI+f
 s9a72yLV2/WhkkC99s268+DTCxfPzok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-1WpHJqFJP3u9fJoejCwSMw-1; Fri,
 02 Aug 2024 09:50:36 -0400
X-MC-Unique: 1WpHJqFJP3u9fJoejCwSMw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649C81955F43; Fri,  2 Aug 2024 13:50:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EA6019560AE; Fri,  2 Aug 2024 13:50:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1131B21E668F; Fri,  2 Aug 2024 15:50:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 6/6] qapi: expose all schema features to code
In-Reply-To: <20240801175913.669013-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 1 Aug 2024 18:59:13
 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-7-berrange@redhat.com>
Date: Fri, 02 Aug 2024 15:50:33 +0200
Message-ID: <87jzgzyqxi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Doesn't build for me:

    qapi/qapi-init-commands.c: In function =E2=80=98qmp_init_marshal=E2=80=
=99:
    qapi/qapi-init-commands.c:70:84: error: =E2=80=98QAPI_FEATURE_ALLOW_WRI=
TE_ONLY_OVERLAY=E2=80=99 undeclared (first use in this function)
       70 |                          qmp_marshal_blockdev_snapshot, QCO_ALL=
OW_PRECONFIG, 1u << QAPI_FEATURE_ALLOW_WRITE_ONLY_OVERLAY);
          |                                                                =
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    qapi/qapi-init-commands.c:70:84: note: each undeclared identifier is re=
ported only once for each function it appears in
    qapi/qapi-init-commands.c:464:70: error: =E2=80=98QAPI_FEATURE_SAVEVM_M=
ONITOR_NODES=E2=80=99 undeclared (first use in this function)
      464 |                          qmp_marshal_human_monitor_command, 0, =
1u << QAPI_FEATURE_SAVEVM_MONITOR_NODES);
          |                                                                =
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


