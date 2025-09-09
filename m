Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A571BCAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvwR5-00082b-Iw; Tue, 09 Sep 2025 07:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwQz-00081a-AE
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvwQr-0006BZ-QM
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 07:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757416957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZuFo7C7Jz4OAynZGsPU3CYiGUn+fE3QqRU/rjiP1fI=;
 b=d3iLrQch7jAzjNvnJhrFxoAN9l+T5owzlzqC2694oAydikVTCiihOZ67A3dDi5CR6yJpe7
 ggpiwh7iznomfkeBsp98ved9yEyZTQiJGqeUxLxKvPET9h47hPAeCUrMfdzenEv4W51CI/
 RH/80rZyphrpcd5x6BfwluP2vdlUhh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-kzaBJaxNMs-4wvIsFka1ww-1; Tue,
 09 Sep 2025 07:22:34 -0400
X-MC-Unique: kzaBJaxNMs-4wvIsFka1ww-1
X-Mimecast-MFC-AGG-ID: kzaBJaxNMs-4wvIsFka1ww_1757416953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D45BC180057A; Tue,  9 Sep 2025 11:22:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57B711800578; Tue,  9 Sep 2025 11:22:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD9BC21E6A27; Tue, 09 Sep 2025 13:22:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 01/12] monitor: Clean up HMP gdbserver error reporting
In-Reply-To: <aKRXoaeXjwXzWdoe@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 Aug 2025 11:53:21 +0100")
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-2-armbru@redhat.com>
 <aKRXoaeXjwXzWdoe@redhat.com>
Date: Tue, 09 Sep 2025 13:22:29 +0200
Message-ID: <87ikhrzx8q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 08, 2025 at 10:08:12AM +0200, Markus Armbruster wrote:
>> HMP command gdbserver used to emit two error messages for certain
>> errors.  For instance, with -M none:
>>=20
>>     (qemu) gdbserver
>>     gdbstub: meaningless to attach gdb to a machine without any CPU.
>>     Could not open gdbserver on device 'tcp::1234'
>>=20
>> The first message is the specific error, and the second one a generic
>> additional message that feels superfluous to me.
>>=20
>> Commit c0e6b8b798b (system: propagate Error to gdbserver_start (and
>> other device setups)) turned the first message into a warning:
>>=20
>>     warning: gdbstub: meaningless to attach gdb to a machine without any=
 CPU.
>>     Could not open gdbserver on device 'tcp::1234'
>>=20
>> This is arguably worse.
>>=20
>> hmp_gdbserver() passes &error_warn to gdbserver_start(), so that
>> failure gets reported as warning, and then additionally emits the
>> generic error on failure.  This is a misuse of &error_warn.
>>=20
>> Instead, receive the error in &err and report it, as usual.  With
>> this, gdbserver reports just the error:
>>=20
>>     gdbstub: meaningless to attach gdb to a machine without any CPU.
>
> What do you think about an alternative of removing "gdbstub: "
> from all the errors raised in  'gdbserver_start' & similar, and
> then using
>
>   error_prepend(err, "Could not open gdbserver on device '%s'", device);
>
> in hmp_gdbserver ?

This would change the error message from

    (qemu) gdbserver=20
    gdbstub: meaningless to attach gdb to a machine without any CPU.

to

    (qemu) gdbserver=20
    Could not open gdbserver on device 'tcp::1234': meaningless to attach g=
db to a machine without any CPU.

Longer, but doesn't tell me anything new beyond reminding me that
gdbserver's argument defaults to "tcp::1234".

This instance of gdbserver_start() is additionally called by
qemu_machine_creation_done() in system/vl.c on behalf of command line
option gdb.  The error message would change from

    $ qemu-system-x86_64 -M none -gdb ""
    qemu-system-x86_64: -gdb : gdbstub: meaningless to attach gdb to a mach=
ine without any CPU.

to

    $ qemu-system-x86_64 -M none -gdb ""
    qemu-system-x86_64: -gdb : meaningless to attach gdb to a machine witho=
ut any CPU.

Improvement.  Howver, we better drop the prefix from all error messages
emitted here, not just this one.

There's another instance of gdbserver_start() in gdbstub/user.c, called
by main() in bsduser/main.c and in linux-user/main.c on behalf of
command line option -g / -gdb.  Same silly prefix:

    $ qemu-x86_64 -g x,y /bin/ls
    qemu-x86_64: gdbstub: unknown option "y"
    Usage: -g {port|path}[,suspend=3D{y|n}]

> I don't feel too strongly, so in any case for the patch as is,

Separate patch to strip "gdbstub: " from all error messages?

> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks!


