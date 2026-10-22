Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFE606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TaZgWfLT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsNR-0000yp-L3; Thu, 22 Oct 2026 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJsNG-0000xU-Lf
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJsNE-0007HJ-NU
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792673903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=A2mfhmc4rlME0go+H2kIe1FLfAVfeWmRaMrReLtjH74=;
 b=TaZgWfLTUxHPBbqp06QqUId3YvVa7LuhLkC58CDC2akvsuqVGgMihs3loepOY1wnsvjvIQ
 S3V016GVYgeuNVKZRjpyQ6cBRVZSAgepCoT+GrCB0reuIQTsynFpxupXGOMYhPFNqWdGpe
 KboPHpfOgj2X0zhm4Pe8DDEx44MYodc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-psJSocJqOua54FE67QUmPw-1; Thu,
 22 Oct 2026 08:58:20 -0400
X-MC-Unique: psJSocJqOua54FE67QUmPw-1
X-Mimecast-MFC-AGG-ID: psJSocJqOua54FE67QUmPw_1792673899
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E28A1955F05; Thu, 22 Oct 2026 12:58:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3562D1800480; Thu, 22 Oct 2026 12:58:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE30121E6A04; Thu, 22 Oct 2026 14:58:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: qemu-system-x86_64 appears to have sgx-epc, but not memory-backend-epc
Date: Thu, 22 Oct 2026 14:58:16 +0200
Message-ID: <87zew5j3iv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

My build of qemu-system-x86_64 has device sgx-epc:

 --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc"}}
 <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}

The device as a link property to a memory-backend-epc:

 --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-epc"}}
 <-- {"return": [...
                 {"name": "memdev", "type": "link<memory-backend-epc>"},
                 ...]}

However, type memory-backend-epc does not exist:

 --> {"execute": "qom-list-types", "arguments": {"implements": "memory-backend"}}
 <-- {"return": [{"name": "memory-backend-ram", "parent": "memory-backend"}, {"name": "memory-backend-file", "parent": "memory-backend"}, {"name": "memory-backend-memfd", "parent": "memory-backend"}, {"name": "memory-backend-shm", "parent": "memory-backend"}]}

The example from docs/system/i386/sgx.rst

    Launching a guest
    -----------------

    To launch a SGX guest:

    .. parsed-literal::

      |qemu_system_x86| \\
       -cpu host,+sgx-provisionkey \\
       -object memory-backend-epc,id=mem1,size=64M,prealloc=on \\
       -M sgx-epc.0.memdev=mem1,sgx-epc.0.node=0

does not work:

    qemu-system-x86_64: invalid object type: memory-backend-epc

CONFIG_SGX is enabled in my build:

    $ find bld-x86 -name \*.h -exec grep CONFIG_SGX {} +
    bld-x86/x86_64-softmmu-config-devices.h:#define CONFIG_SGX 1
    bld-x86/config-poison.h:#pragma GCC poison CONFIG_SGX


