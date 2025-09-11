Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BF3CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 12:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwg8P-0002QL-6x; Thu, 11 Sep 2025 08:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwg8M-0002PI-Gc
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwg8E-0008Gz-9v
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 08:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757592624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2SdUvC2ubGxk30ZeDssCzCm4f5QjPRrWZPkHiwST+sU=;
 b=BARm1L3KvKu686wt2wPrmGc0YP7u76SPukmDUDGLjlKJnV67sFHRFAjaYEUsPaCZGr3Ipd
 emZM/fbM3M+9tc0TRzPpGaN/+acGHheQYf8lzQuyhdPRKHvkNFsj+D++7z6n76JKs0KfVK
 8PXfMqwFFzfdtKi9xyxGO9pRQuutP9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-vGcAXZUNOxqwNaRc-8a34Q-1; Thu,
 11 Sep 2025 08:10:20 -0400
X-MC-Unique: vGcAXZUNOxqwNaRc-8a34Q-1
X-Mimecast-MFC-AGG-ID: vGcAXZUNOxqwNaRc-8a34Q_1757592619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B77411800562; Thu, 11 Sep 2025 12:10:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3C2300021A; Thu, 11 Sep 2025 12:10:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FEF821E6A27; Thu, 11 Sep 2025 14:10:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Greg Kurz
 <groug@kaod.org>
Subject: The different ways QEMU logs stuff
Date: Thu, 11 Sep 2025 14:10:15 +0200
Message-ID: <87bjnhgpg8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

I fell into another rabbit hole: logging.  Here's my trip report.

We have:

* util/error-report.c

  - To stderr (or current monitor, but that's not relevant here)

  - Format:
        [TIME ][GUEST-NAME ]PROGNAME:LOCATION: (|warning: |info: )MESSAGE
    where the optional parts are controlled by -msg

  - Maintained: see MAINTAINERS "Error reporting"

* util/log.c

  - Control:

    =C2=B7 Some logging is always on

    =C2=B7 Some logging is off by default, enabled per "log item" with -d

    =C2=B7 Some can additionally be limited to address ranges with -dfilter

  - To the file given by -D (default stderr), or with -d tid to files
    with names derived from the pattern given by -D (%d is replaced by
    the thread ID)

  - Format:
        [TIME ]MESSAGE
    where the optional part is controlled by -msg timestamp (-msg
    guest-name has no effect here)

  - Not covered by MAINTAINERS

* Tracing

  - Control: off by default, enabled with -trace per trace point (and
    also -d trace: --- I find that duplication bizarre)

  - Run time control with HMP commands trace-event, trace-file, QMP
    commands trace-event-get-state, trace-event-set-state

  - To whatever backends are compiled in:

    =C2=B7 "log" wraps around util/log.c's always-on logging

    =C2=B7 "simple" logs to a binary file given by -trace file=3D

    =C2=B7 "syslog" logs to POSIX syslog

    =C2=B7 "ftrace", "dtrace", "ust" integrate with Linux ftrace, DTrace /
      SystemTap, and LTTng userspace tracing, respectively

  - Maintained: see MAINTAINERS "Traicing"

* Unstructured ad hoc printing to stdout or stderr

I think that's it.

Observations:

* Mixing logs with different formats in one destination makes them
  needlessly hard to read and parse.

  Daniel's "util: sync error_report & qemu_log output more closely"
  series makes util/error-report.c and util/log.c use a common message
  prefix

      [TIME ][GUEST-NAME ]PROGNAME\(THREAD-NAME\):...

  where the optional parts are controlled by -msg.  Continues prior work
  in that direction: commit 012842c0755 (log: make '-msg timestamp=3Don'
  apply to all qemu_log usage).

* Spreading logs over multiple destinations can make the order hard to
  determine.

  -D splits util/log.c from util/error-report.c.

  -d tid further splits per thread.

  Splitting per thread feels fairly redundant once the prefix includes
  the thread name.  Thread names is easier to make sense of than numeric
  thread IDs in the split filenames.

  To keep the complete log in one place, avoid -D, and enable trace
  backend "log".

* In my view, util/log.c consists of three layers.  Form bottom to top:

  * Logging messages: qemu_log()

  * Control of what to log ("log items"): qemu_log_mask()

  * Address filtering: qemu_log_in_addr_range()

  The bottom layer is also used by trace backend "log".

* Tracing vs. "log items"

  Tracing and "log items" both provide opt-in logging.

  Why do we have two?  Feels like an accident to me.

  When to use which?  I guess people pick whatever they're familiar
  with.

  Would we be better off with just one?  I wish...

  Which one?  Clearly tracing, because tracing backends provide plenty
  of useful functionality "log items" lack.

  "Log items" support per-thread log files.  With tracing, you could
  instead split by thread names once Daniel's series is in.

  Address range filtering is only used with "log items".  It could just
  as easily be used with tracing.

Thoughts?


