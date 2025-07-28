Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9761DC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugP1N-0008Ud-Ei; Mon, 28 Jul 2025 10:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugP0X-0008FC-4j
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugP0T-0003CJ-8N
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753713550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6taf5btQ1PfovtmesixXFkrl5QeNfb6sRCSYYTKW9vY=;
 b=W9v9uWoygcOgPF8AN2uMylW1SkVIoZR8V/EcPHqyKLT4f3t2dKHmpAtyvut4nMSJb+VQaJ
 inbDy1id4l1WvQALgO4Oi9q4zr9VA70+p1AeotdKDHBVwZs2ydgPCy7s4+9VbQpxeC52iv
 aGRsfd6YVU10AkFhNdUA6EyaWNUnmew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-vKRpvwAzPau21LiXcWQghA-1; Mon,
 28 Jul 2025 10:39:07 -0400
X-MC-Unique: vKRpvwAzPau21LiXcWQghA-1
X-Mimecast-MFC-AGG-ID: vKRpvwAzPau21LiXcWQghA_1753713546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 225E319560AE; Mon, 28 Jul 2025 14:39:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1C6F1800D8A; Mon, 28 Jul 2025 14:39:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6C5021E6A27; Mon, 28 Jul 2025 16:39:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: qos-test is annoyingly noisy
In-Reply-To: <ed3009be-8707-4340-a8ee-2523f77fe861@redhat.com> (Paolo
 Bonzini's message of "Wed, 23 Jul 2025 18:38:45 +0200")
References: <87o6tbnfqx.fsf@pond.sub.org>
 <ed3009be-8707-4340-a8ee-2523f77fe861@redhat.com>
Date: Mon, 28 Jul 2025 16:39:02 +0200
Message-ID: <87ms8omlbt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 7/23/25 16:28, Markus Armbruster wrote:
>> Noise starting with "stdout: " has been polluting output of "make check"
>> for a while.  I traced it to qos-test.  Output of "make
>> check-qtest-aarch64" appended as an example.
>> Blessed silence if I revert commit 30ea13e9d97d (tests/qtest: use
>> qos_printf instead of g_test_message).
>> Alex, what shall we do here?
>
> What is printing "stdout:", is it glib?  I think glib should be using g_test_message() to do those "stdout:" prints.

I doubt it's glib.  When I run the test directly, like

    $ QTEST_QEMU_BINARY=./qemu-system-aarch64 QTEST_QEMU_IMG=./qemu-img time /work/armbru/qemu/bld/tests/qtest/qos-test

I see the offending lines without "stdout:"

    # Start of vhost-user tests
    qemu-system-aarch64: Failed to set msg fds.
    qemu-system-aarch64: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
    qemu-system-aarch64: Failed to set msg fds.
    qemu-system-aarch64: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
        # # qos_test running single test in subprocess
        # # set_protocol_features: 0x42
        # # set_owner: start of session
        # # vhost-user: un-handled message: 14
        # # vhost-user: un-handled message: 14
        # # set_vring(0)=enabled
        # # set_vring(1)=enabled
        # # set_vring(0)=enabled
        # # set_vring(1)=enabled
        # # set_vring(0)=enabled
        # # set_vring(1)=enabled
        # # set_vring(0)=enabled
        # # set_vring(1)=enabled
        # # set_vring(0)=enabled
        # # set_vring(1)=enabled
        # # set_vring_num: 0/256
        # # set_vring_addr: 0x7f7fcc000000/0x7f7fcbfff000/0x7f7fcc001000
        # # set_vring_num: 1/256
    ok 28 /aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/migrate

I believe the prefix "stdout: <number>: UNKNOWN: " comes from the test
harness.

> But I agree a more practical alternative is a revert.

I'll post one.


