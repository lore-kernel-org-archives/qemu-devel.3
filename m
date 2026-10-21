Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B860A2602
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iW6mTO1Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUrz-0006fd-9A; Wed, 21 Oct 2026 07:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJUrw-0006f2-2Y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJUru-0003Qj-4W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792583548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=10kRkgvtVgyuuM2kFhkiuVh4IUVzpveJSbO8hnprEfc=;
 b=iW6mTO1Yicjvb/se34/p+1avSFPiSowmQM412lpk/hgB5v/XgmUUTsafYSu4gZ0rHnxfbA
 QVidUfHMxFRWXKC69kwNrJ+fFLIWvKXgsARZG6MSzFX0+dDrEXZFwUoEyKDwDOt09LAxY+
 7KMmMrsdSVrsdSM185GcZReL/ckBfDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-5rrcJro0P8qiUwj6adwdLA-1; Wed,
 21 Oct 2026 11:52:25 +0000
X-MC-Unique: 5rrcJro0P8qiUwj6adwdLA-1
X-Mimecast-MFC-AGG-ID: 5rrcJro0P8qiUwj6adwdLA_1792583543
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03651195605E; Wed, 21 Oct 2026 11:52:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D220830000E7; Wed, 21 Oct 2026 11:52:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47D5921E6A04; Wed, 21 Oct 2026 13:52:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane
 Chen <kane_chen@aspeedtech.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: qemu-system-arm dies on introspection of ast2700-a1 and ast2700-a2
Date: Wed, 21 Oct 2026 13:52:19 +0200
Message-ID: <87qzhjmft8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Watch this:

    $ qemu-system-arm -S -nodefaults -display none -M none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "package": "v11.1.0-2545-g2d150b99ce"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute": "qom-list-properties", "arguments": {"typename": "ast2700-a1"}}
    qemu-system-arm: unknown type 'cortex-a35-arm-cpu'
    [Exit 1 ]

Same for ast2700-a2.

I found the folllowing in their .instance_init() method
aspeed_soc_ast2700_init():

    for (i = 0; i < sc->num_cpus; i++) {
        if (qtest_enabled() && !target_aarch64()) {
            /*
             * Introspection qtest just want to create this object
             * without realizing it. ARM_CPU_TYPE_NAME("cortex-a35")
             * is not available on 32-bit binary: skip it since we
             * won't even realize it.
             */
            continue;
        }
        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
                                aspeed_soc_cpu_type(sc->valid_cpu_types));
    }

This seems to paper over the bug so make the tests pass.  That's wrong.

.instance_init() must not fail and must not exit(), regardless of
context.

object_initialize_child() exit()s when the type doesn't exist, because
&error_fatal gets passed to in type_get_or_load_by_name() in
object_initialize_child().

The narrow fix is to make type "cortex-a35-arm-cpu" exist, or to make
the two bad types "ast2700-a1" and "ast2700-a2" not exist.


