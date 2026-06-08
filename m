Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1CCCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWVWD-0006yy-Ue; Mon, 08 Jun 2026 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wWVWA-0006yR-Ri
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wWVW9-0008WC-9r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 04:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780907970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cNtrY+Jbl2MypUHSRT0ebdCYjVy/dpUjWAOOWrFAghA=;
 b=Gc7muxUYsLjLbIWvg0kUuLde/ZM9tJ6OJrRqfFyg2RQL0Ybws837vLQRh0yQ1JukUp4JMJ
 K77Dv1aVibO5Gp2hdnZhpiJvBHN0VZ1GFqvVlgK2as/jB33ZS6jnvSdEbTaXU+JR/A2KJ/
 hli3cUmtmw4/qIDvboyj4hUi/IpOK54=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-19iiwWBrNQyBIyBeSjb0zQ-1; Mon,
 08 Jun 2026 04:39:27 -0400
X-MC-Unique: 19iiwWBrNQyBIyBeSjb0zQ-1
X-Mimecast-MFC-AGG-ID: 19iiwWBrNQyBIyBeSjb0zQ_1780907966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2571956063; Mon,  8 Jun 2026 08:39:25 +0000 (UTC)
Received: from localhost (unknown [10.44.33.129])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE2BF1956053; Mon,  8 Jun 2026 08:39:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: Re: [PATCH v6 00/17] target/s390x: Extend qemu CPACF support
In-Reply-To: <20260526121550.5296-1-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260526121550.5296-1-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 08 Jun 2026 10:39:22 +0200
Message-ID: <87y0gpmnnp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 26 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> This patch series extends the s390 qemu CPACF support to be able to
> run a subset of the CPACF instruction cross platform. There have been
> requests on the kernel crypto mailing list about a way to test
> s390 specific crypto implementations. For example a way to test
> s390 CPACF exploitation code like the s390_aes.ko kernel module.
>
> So here now is a set of patches verified on x86 and s390 which
> over (slow but working) support for a subset of the subfunctions of
> some of the CPACF instructions.
>
> Test: As this series is more or less complete, a full blown linux
> can be run and the 'usual' in-kernel crpyto modules will be
> automatically loaded which run a bunch of test cases. So there
> is now support for these kernel modules:
> * sha256_s390x (autoloaded, sha256)
> * sha512_s390x (autoloaded, sha512)
> * aes_s390x (autoloaded, clear key aes ecb, cbc, ctr, xts)
> * pkey_pckmo (autoloaded, derive AES protected key from clear key)
> * paes_s390x (not autoloaded, protected key aes ecb, cbc, ctr, xts)
> All these modules run selftests if configured by the kernel (which is
> enabled by default). Failures are reported via syslog. Additionally
> the aes testcases from libica can be run either inside such an qemu
> environment or with a static build executed with the qemu tcg
> application qemu-s390x --cpu max <static-build-libica-test>.

So the test setup here would be to leverage the kernel tests, but not
any QEMU tests? (I'm wondering if there's a way to integrate this into
normal CI workflows; can we use the libica testcases for that? I'm not
really familiar with how this is used.)

Also, is there any public documentation for these instructions? If not,
it would be helpful if someone with access to the documentation could
give an R-b here.

Otherwise, nothing bad jumped out at me.


