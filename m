Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RZk+q+YQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVeK-00082k-D1; Wed, 21 Oct 2026 08:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJVe9-00082G-UT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xJVe7-0000oj-QF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792586539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=seGNpU6Y4R+v0RUdVhvd8T5kjew1RPcyH9v+QpV1zv0=;
 b=RZk+q+YQK7g0JUs2Rv4zhP3Esdd7MmH/KF2dp69HJ3TeVLAyk08orMV5umg8H8eE324eHd
 UMJ2pFl8YMmXORczot83MdWW8OuYz0UoGIKsmTouol7YPsPyJh30Y+ahbI7vbIfsnWziRw
 Q68Bi8qIbJxK8JZJXiH6SwqM4dlCGKk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-253fcqu9NJG63pdc1FPFDQ-1; Wed,
 21 Oct 2026 12:42:14 +0000
X-MC-Unique: 253fcqu9NJG63pdc1FPFDQ-1
X-Mimecast-MFC-AGG-ID: 253fcqu9NJG63pdc1FPFDQ_1792586533
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99E491955F44; Wed, 21 Oct 2026 12:42:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6E371956040; Wed, 21 Oct 2026 12:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80E2321E6A04; Wed, 21 Oct 2026 14:42:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org
Subject: Introspecting max32-riscv-cpu after rva23s64-riscv-cpu crashes
Date: Wed, 21 Oct 2026 14:42:09 +0200
Message-ID: <87ld7rmdi6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

    $ qemu-system-riscv64 -S -nodefaults -display none -M none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11}, "package": "v11.1.0-2545-g2d150b99ce-dirty"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
    {"return": {}}
    {"execute": "qom-list-properties", "arguments": {"typename": "rva23s64-riscv-cpu"}}
    [Expected output...]
    {"execute": "qom-list-properties", "arguments": {"typename": "max32-riscv-cpu"}}
    **
    ERROR:../target/riscv/cpu.c:516:satp_mode_str: code should not be reached
    Bail out! ERROR:../target/riscv/cpu.c:516:satp_mode_str: code should not be reached
    Aborted                    (core dumped) ../qemu/bld/qemu-system-riscv64 -S -nodefaults -display none -M none -qmp stdio

This is satp_mode_str(VM_1_10_SV39, false).  Interesting part of stack
backtrace:

    #4  0x00007f9d6e7cd447 in g_assertion_message_expr ()
        at /lib64/libglib-2.0.so.0
    #5  0x000055801fc2f556 in satp_mode_str
        (satp_mode=<optimized out>, is_32_bit=<optimized out>)
        at ../target/riscv/cpu.c:516
    #6  0x000055801fca193c in riscv_cpu_set_profile
        (cpu=0x55802e5b8c90, profile=profile@entry=0x5580209732e0 <RVA22S64>, enabled=enabled@entry=true) at ../target/riscv/tcg/tcg-cpu.c:1305
    #7  0x000055801fca1cf7 in riscv_cpu_add_profiles (cpu_obj=<optimized out>)
        at ../target/riscv/tcg/tcg-cpu.c:1549
    #8  riscv_cpu_add_user_properties (obj=0x55802e5b8c90)
        at ../target/riscv/tcg/tcg-cpu.c:1622
    #9  riscv_tcg_cpu_instance_init (cs=<optimized out>)
        at ../target/riscv/tcg/tcg-cpu.c:1741
    #10 0x000055801fd178a7 in object_init_with_type
        (obj=0x55802e5b8c90, ti=<optimized out>) at ../qom/object.c:430
    #11 object_init_with_type (obj=0x55802e5b8c90, ti=<optimized out>)
        at ../qom/object.c:426
    #12 object_init_with_type (obj=0x55802e5b8c90, ti=0x55802e2e0250)
        at ../qom/object.c:426
    #13 object_initialize_with_type
        (obj=0x55802e5b8c90, size=<optimized out>, type=0x55802e2e0250)
        at ../qom/object.c:512
    #14 0x000055801fd17c5f in object_new_with_type (type=0x55802e2e0250)
        at ../qom/object.c:710
    #15 0x000055801fe17276 in qmp_qom_list_properties
        (typename=0x55802e5ab3d0 "max32-riscv-cpu", errp=0x22c5a0, 
        errp@entry=0x7ffe4a494aa0) at ../qom/qom-qmp-cmds.c:283


