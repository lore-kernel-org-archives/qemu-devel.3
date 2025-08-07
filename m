Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD2FC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 05:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujt6V-0008BY-Cq; Thu, 07 Aug 2025 01:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujt6P-00087y-QC
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 01:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujt6M-00027q-Kv
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 01:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754544220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycNc2qC0lrBFU0rM+T5GvCymbvQbTe3GJR2hLFn8mzA=;
 b=E83RzZHwqhUjKiO3dsJ+f2pv0W+R/yRLGzIwR/aLx5z2omddmt9zU+1BNHIgVPH8hwhY1T
 whPMc0iGAGHzVF9S9quUjjX3ZVU+L+C7iHxKST62hbNh+6Nj18F8DytsG8ADx9Fva9wy/v
 XZamyasGQ2r5i3qrSjcB/1FH8IRkIXg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-Fytm-0bDObu1V9278VKvdw-1; Thu,
 07 Aug 2025 01:23:39 -0400
X-MC-Unique: Fytm-0bDObu1V9278VKvdw-1
X-Mimecast-MFC-AGG-ID: Fytm-0bDObu1V9278VKvdw_1754544218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0169C1955DB8; Thu,  7 Aug 2025 05:23:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70A161800447; Thu,  7 Aug 2025 05:23:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D35821E6A27; Thu, 07 Aug 2025 07:23:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
In-Reply-To: <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 (Manos Pitsidianakis's message of "Tue, 5 Aug 2025 19:22:14 +0300")
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
Date: Thu, 07 Aug 2025 07:23:34 +0200
Message-ID: <87ectnr9gp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Tue, Aug 5, 2025 at 7:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>>
>> On Tue, Aug 05, 2025 at 12:19:26PM +0300, Manos Pitsidianakis wrote:
>> > Add a backtrace_on_error meson feature (enabled with
>> > --enable-backtrace-on-error) that compiles system binaries with
>> > -rdynamic option and prints a function backtrace on error to stderr.
>> >
>> > Example output by adding an unconditional error_setg on error_abort in=
 hw/arm/boot.c:
>> >
>> >   ./qemu-system-aarch64(+0x13b4a2c) [0x55d015406a2c]
>> >   ./qemu-system-aarch64(+0x13b4abd) [0x55d015406abd]
>> >   ./qemu-system-aarch64(+0x13b4d49) [0x55d015406d49]
>> >   ./qemu-system-aarch64(error_setg_internal+0xe7) [0x55d015406f62]
>> >   ./qemu-system-aarch64(arm_load_dtb+0xbf) [0x55d014d7686f]
>> >   ./qemu-system-aarch64(+0xd2f1d8) [0x55d014d811d8]
>> >   ./qemu-system-aarch64(notifier_list_notify+0x44) [0x55d01540a282]
>> >   ./qemu-system-aarch64(qdev_machine_creation_done+0xa0) [0x55d01476ae=
17]
>> >   ./qemu-system-aarch64(+0xaa691e) [0x55d014af891e]
>> >   ./qemu-system-aarch64(qmp_x_exit_preconfig+0x72) [0x55d014af8a5d]
>> >   ./qemu-system-aarch64(qemu_init+0x2a89) [0x55d014afb657]
>> >   ./qemu-system-aarch64(main+0x2f) [0x55d01521e836]
>> >   /lib/x86_64-linux-gnu/libc.so.6(+0x29ca8) [0x7f3033d67ca8]
>> >   /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85) [0x7f3033d67=
d65]
>> >   ./qemu-system-aarch64(_start+0x21) [0x55d0146814f1]
>> >
>> >   Unexpected error in arm_load_dtb() at ../hw/arm/boot.c:529:
>>
>> From an end-user POV, IMHO the error messages need to be good enough
>> that such backtraces aren't needed to understand the problem. For
>> developers, GDB can give much better backtraces (file+line numbers,
>> plus parameters plus local variables) in the ideally rare cases that
>> the error message alone has insufficient info. So I'm not really
>> convinced that programs (in general, not just QEMU) should try to
>> create backtraces themselves.
>
> Hi Daniel,
>
> I don't think there's value in replacing gdb debugging with this, I
> agree. I think it has value for "fire and forget" uses, when errors
> happen unexpectedly and are hard to replicate and you only end up with
> log entries and no easy way to debug it.

Enable core dumps.  I doubt that's harder than recompiling and
redeploying QEMU with backtraces enabled.


