Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04425C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFCnk-0005pO-5F; Wed, 14 May 2025 10:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFCnO-0005mz-Ge
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uFCnL-0002j5-EK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747231753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQxsHOuQU8L5KFbmMmnhXYJ3WF+OAA11pUt+6vQYcKQ=;
 b=EwfCpSDNSfmvNO9r8vSFtDG92rZT5dTLzbWOc+8K/V8YmgZAPXyPOI/TRoyV6+cHUvU54M
 LtszhMOii6x8wfhtDaDN7fyInd4XLYdzT4qU9BZ+CRx6dAvqG2vEapRdYdrVmgjawM511x
 LCRMAZpWO8X5KJbcIHIIc6jiruwqnJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-Zx7A7GK3PxqqsKBXcyCyTg-1; Wed,
 14 May 2025 10:09:10 -0400
X-MC-Unique: Zx7A7GK3PxqqsKBXcyCyTg-1
X-Mimecast-MFC-AGG-ID: Zx7A7GK3PxqqsKBXcyCyTg_1747231749
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3BA21800374; Wed, 14 May 2025 14:09:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D1ED1800879; Wed, 14 May 2025 14:09:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4046A21E66C3; Wed, 14 May 2025 16:09:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  alex.bennee@linaro.org,  stefanha@redhat.com,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 pbonzini@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,
 berrange@redhat.com,  thuth@redhat.com,  Michael Roth
 <michael.roth@amd.com>
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
In-Reply-To: <20250507231442.879619-10-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Wed, 7 May 2025 16:14:39 -0700")
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
Date: Wed, 14 May 2025 16:09:05 +0200
Message-ID: <87h61n8eta.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Fails to build:

        /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_cpu_model_comparison':
        /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:66:(.text+0x10c9): undefined reference to `qmp_query_cpu_model_comparison'
        /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_cpu_model_baseline':
        /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:131:(.text+0x143c): undefined reference to `qmp_query_cpu_model_baseline'
        /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_set_cpu_topology':
        /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:306:(.text+0x1de1): undefined reference to `qmp_set_cpu_topology'
        /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-machine-target.c.o: in function `qmp_marshal_query_s390x_cpu_polarization':
        /work/armbru/qemu/bld-x86/qapi/qapi-commands-machine-target.c:362:(.text+0x20c6): undefined reference to `qmp_query_s390x_cpu_polarization'
        /usr/bin/ld: libqemu-x86_64-softmmu.a.p/meson-generated_.._qapi_qapi-commands-misc-target.c.o: in function `qmp_marshal_query_gic_capabilities':
        /work/armbru/qemu/bld-x86/qapi/qapi-commands-misc-target.c:393:(.text+0x2d2d): undefined reference to `qmp_query_gic_capabilities'
        collect2: error: ld returned 1 exit status

The next commit fixes it.  It then fails tests:

    stdout:
    --- /work/armbru/qemu/bld-x86/../tests/qapi-schema/unknown-expr-key.err
    +++ 
    @@ -1,3 +1,3 @@
     unknown-expr-key.json: In struct 'Bar':
     unknown-expr-key.json:2: struct has unknown keys 'bogus', 'phony'
    -Valid keys are 'base', 'data', 'features', 'if', 'struct'.
    +Valid keys are 'base', 'data', 'features', 'if', 'runtime_if', 'struct'.
    stderr:
    unknown-expr-key FAIL

Fixup:

diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/unknown-expr-key.err
index f2538e3ce7..8184f3c768 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1,3 +1,3 @@
 unknown-expr-key.json: In struct 'Bar':
 unknown-expr-key.json:2: struct has unknown keys 'bogus', 'phony'
-Valid keys are 'base', 'data', 'features', 'if', 'struct'.
+Valid keys are 'base', 'data', 'features', 'if', 'runtime_if', 'struct'.


