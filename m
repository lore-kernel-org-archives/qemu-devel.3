Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5086AF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcnD-0004OX-2U; Mon, 09 Mar 2026 11:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzcnA-0004Mq-4Y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzcn7-0006Pr-D8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773071108;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dmArbA0Rw2lwgzBGLkfglbNeb4agGR5yae96cgwMLXA=;
 b=QXX1SNhoOKMrs4P79UF8DLZuae9aL+IjIdZAt++IKG/niHfEvR/u+zGAen1zD3i5A7O8F3
 A5fw+kY7W1dkLQzbJoasxaXo51LFP388SI5KQ8QAkJuNslB89QpEHh3pfKdTYJnycJtOWl
 QpSLMT0mU8Hm2d0ZTcHk7qipjM20fA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-vekj-ZdDOKyhjyiHzp9pow-1; Mon,
 09 Mar 2026 11:45:03 -0400
X-MC-Unique: vekj-ZdDOKyhjyiHzp9pow-1
X-Mimecast-MFC-AGG-ID: vekj-ZdDOKyhjyiHzp9pow_1773071103
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDB4C18005B3; Mon,  9 Mar 2026 15:45:02 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 819BB1956095; Mon,  9 Mar 2026 15:45:01 +0000 (UTC)
Date: Mon, 9 Mar 2026 15:44:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: running a single functional test: where do the logs go?
Message-ID: <aa7q-dzkQRbf-wrK@redhat.com>
References: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8FhiJZy6NqRUVnWQ+L6=fE8Ssqs9FEW2eO2eAVTrL=_w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 09, 2026 at 11:55:58AM +0000, Peter Maydell wrote:
> The functional test documentation suggests running a single test
> with the build/run script. But if you do this where do the logfiles go?
> As you can see from this transcript, they don't seem to get written
> into the place that a "make check-functional" run puts them:
> 
> $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> total 16
> -rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
> -rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
> -rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
> drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch
> $ date
> Mon Mar  9 11:20:13 GMT 2026
> $ time QEMU_TEST_QEMU_BINARY=./build/san/qemu-system-arm

BTW this is previously needed, but is now overkill wit the 'run' script.
QEMU_TEST_QEMU_BINARY=qemu-system-arm is sufficient, as meson's devenv
sets $PATH to include the locally built binary dirs first.

> ./build/san/run tests/functional/arm/test_emcraft_sf2.py
> TAP version 13
> ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
> 1..1
> 
> real    3m24.394s
> user    3m21.314s
> sys     0m3.100s
> $ ls -l build/san/tests/functional/arm/test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2/
> total 16
> -rw-r--r-- 1 pm215 pm215 3084 Mar  9 10:51 base.log
> -rw-r--r-- 1 pm215 pm215  825 Mar  9 10:51 console.log
> -rw-r--r-- 1 pm215 pm215  235 Mar  9 10:54 default.log
> drwxr-xr-x 3 pm215 pm215 4096 Mar  9 10:51 scratch
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


