Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C9DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wghrN-0001Ye-AG; Mon, 06 Jul 2026 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wghrH-0001YF-IK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wghrG-00050g-7Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783338689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MZeVVmFL+eaMn/AIwJDbn1+Nrnqjph+bxM7usbiNTo=;
 b=fRVdC/rQArVGEDHPSCscAbN1tzwXtTj0dnTtTJBd4qH7cnHrtFUht8sOhpn6sRnmGFkF39
 GSHyp5yf7z14rO9nffF1gXJ2HfEkXlpN3+ZSAfjN0tq1OmbNor5D8/YNb8eKs15Q01X7ks
 giK6TpWJwU3Kk3TPs4rtENQyiQPwlwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-FBV5qYOOOjKZ1L1QYtkYug-1; Mon,
 06 Jul 2026 07:51:23 -0400
X-MC-Unique: FBV5qYOOOjKZ1L1QYtkYug-1
X-Mimecast-MFC-AGG-ID: FBV5qYOOOjKZ1L1QYtkYug_1783338682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D08071955F73; Mon,  6 Jul 2026 11:51:21 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32FA41956049; Mon,  6 Jul 2026 11:51:21 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf
 protected keys
In-Reply-To: <20260706094317.17032-11-freude@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Mon, 06 Jul 2026 13:51:19 +0200
Message-ID: <87v7asjpzc.fsf@redhat.com>
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

On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:

> Add base support for cpacf protected key handling.
>
> The qemu version provided here is only a fake intended to make
> protected key available for developing and testing purpose:
> * The protected key is 'derived' from the clear key by xoring
>   the fixed pattern 0xAAAA... onto the key value.
> * The AES Wrapping Key Verification Pattern is a fixed
>   value of 32 bytes 0xFACEFACE...
>
> Add preprocessor defines for the xor pattern and wkvp used to
> construct ('encrypt') a protected key from a clear key value with
> this implementation. Also add some static functions to 'encrypt'
> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>
> The preprocessor defines shall be used later in testcases to
> construct and decode protected keys.

Hmm... so does that mean that we only provide the protected key handling
in the !KVM case for people who want to run via tcg for some development
purposes? Does the user actually get some kind of notice in that case,
if for example they run with !KVM due to some configuration hiccup? IOW,
do users get some clue that they are running with a fake placeholder
implementation, other than the setup being slow?

>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
>  target/s390x/tcg/cpacf_aes.c | 39 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)


