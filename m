Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5F8C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO3q-0005PF-7x; Fri, 26 Jan 2024 10:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTO3j-0005O8-1x
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:24:03 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTO3h-00040A-5P
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:23:58 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cf4d2175b2so2951791fa.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706282635; x=1706887435; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1ht+FqmP9vIb7hfD6gvXtG+LTWdyqOSqgkdz54Gekh4=;
 b=pBuT3lk3p4PRgVXk2nrESSYOW32GsZ7MzpQhRrmB+N2tcnKNSPbtJhx5sVY8jn4Agh
 kxwwHuCg2ng4ESW8aere9feOVIqphvpETWC9JqHhBCCE/581iHhYQNR7ILtz+uoCQJBv
 DqEdvS8ccE0hl5IrY1ylaVOqtY1xwIjBGV+0gxRmgAf352G/5bGotB7Dthj2ElB0KEOr
 2sQmsszHPl1J1IR8MLtweark5XkoPIebh7n65aTDYH8CY/4OM0KZh+NPPB09Gopep2df
 5Ko/ogdzd83x+AlA7+VZSZ5SA9CqCQ2ipdduBjIU4VStLPX3E488enl7WIy192lf7T7/
 omIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282635; x=1706887435;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ht+FqmP9vIb7hfD6gvXtG+LTWdyqOSqgkdz54Gekh4=;
 b=oZJNMu/R1RJsN9mkWOZQbtAKY6YW45S54wFLxSJn3N4XtKOEQ8MZVOD6GiVp48kdPO
 VtS/nPzYWtRWGiop3AZHNZBeBk7AXuDoHgBDcFT39xqCXNqAPo0cOFC74fFFQaCIK0nW
 Z1Q9oz9Lu7tULUvhRcSld8k3Bg14wVuKZlURRvQcD8u+Tu0jB1E9CXo8mMrqZEvRigQW
 9+Vm7mpxc4B2xUrzpVj6ChZomzhzLOSm5StsRd1p6U6cJUCw3MD9do4eoZK9bcGHpVqt
 Pl0gCUqxZS3yVNVzfsVxM0BPvICqW9V8soCF9514ylMfcslVcQnwB81+RebLAMkd4HLI
 mSaw==
X-Gm-Message-State: AOJu0YwXdZxl57eVx534Edj3ddWdyd0vTcrZLOMNzpyIK+cbJmIfc8ZD
 n0XdL9vPKtL/iKvMln++HqOrT+eDAOztyNCDhDo3ATUaZgiXNvBuQRb6HoTWk1wDG2nLPOCFOGk
 MKfYkyGSfiFNAg3EC+vW5GZKq/Mt/U3CSNOgddYoJ0jKddpLL
X-Google-Smtp-Source: AGHT+IHuNu1YcMu9wlC4y/IwLwCK21QBR/JZIxU8CxLgI0KHskKKCbT9rEXyLuTcZkNQ01o4ppkznOCxqusWsbqxbqU=
X-Received: by 2002:a2e:be8a:0:b0:2cf:dcc:c8d8 with SMTP id
 a10-20020a2ebe8a000000b002cf0dccc8d8mr735234ljr.202.1706282635019; Fri, 26
 Jan 2024 07:23:55 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 15:23:44 +0000
Message-ID: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
Subject: spapr watchdog vs watchdog_perform_action() / QMP watchdog-set-action
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 qemu-ppc <qemu-ppc@nongnu.org>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi; one of the "bitesized tasks" we have listed is to convert
watchdog timers which directly call qemu_system_reset_request() on
watchdog timeout to call watchdog_perform_action() instead. This
means they honour the QMP commands that let the user specifiy
the behaviour on watchdog expiry:
https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-141
https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-129
(choices include reset, power off the system, do nothing, etc).

There are only a few remaining watchdogs that don't use the
watchdog_perform_action() function. In most cases the change
is obvious and easy: just make them do that instead of calling
qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).

However, the hw/watchdog/spapr_watchdog.c case is trickier. As
far as I can tell from the sources, this is a watchdog set up via
a hypercall, and the guest makes a choice of "power off, restart,
or dump and restart" for its on-expiry action.

What should this watchdog's interaction with the watchdog-set-action
QMP command be? If the user says "do X" and the guest says "do Y",
which do we do? (With the current code, we always honour what
the guest asks for and ignore what the user asks for.)

(The bitesized task for watchdog_perform_action() is
https://gitlab.com/qemu-project/qemu/-/issues/2124 . For the
purposes of this email thread I'm only after a concrete decision
about what we think the right thing is, not for any code. Then
I can write that up in the bug for potential new contributors.)

thanks
-- PMM

