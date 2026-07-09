Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B7C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkYQ-0005QR-4F; Thu, 09 Jul 2026 04:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whkYO-0005Pu-8w
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whkYM-0008I5-GJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783587377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XIkjV8uQN+E7UDM75C6OnX9of1wNRO/MR2KWCmhFKnY=;
 b=Au8+AeaJq/gyuU8G3tT+Ze6haTI/gkZjKin489PvX34kxcOoVyFitjmu6UeIGZiW1Ge0Ev
 hp/jRLt2UWDbR/O0UiGIRysTuFcDtKpcpMhSRfApFGPGZ2BTg8GXulPbxNCXK5RgjFhw2Z
 8QyiZDj5BZ+n6kYpiZVetrqzRB4B5BE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-FiDChr5XOw6T7D4JGbQeWQ-1; Thu,
 09 Jul 2026 04:56:13 -0400
X-MC-Unique: FiDChr5XOw6T7D4JGbQeWQ-1
X-Mimecast-MFC-AGG-ID: FiDChr5XOw6T7D4JGbQeWQ_1783587372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3516A1955DCF; Thu,  9 Jul 2026 08:56:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5EFF1800347; Thu,  9 Jul 2026 08:56:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7841B21E6920; Thu, 09 Jul 2026 10:56:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com> (Max Filippov's
 message of "Wed, 8 Jul 2026 08:05:41 -0700")
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Date: Thu, 09 Jul 2026 10:56:09 +0200
Message-ID: <875x2oh786.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Max Filippov <jcmvbkbc@gmail.com> writes:

> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
>
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
>
>   linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> index a7059aacd9cb..b5ea65f3d393 100644
> --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>      assert(qemu);
>  
>      if (!getenv("QEMU_RTSIG_MAP")) {
> -        char **new_argv = malloc((argc + 2) + sizeof(char *));
> +        char **new_argv = malloc((argc + 2) * sizeof(char *));

If you can switch to glib's malloc, then g_new(argc + 2, sizeof(char *))
is better.  Yes, @argc can't become big enough for the multiplication to
overflow, but g_new() removes the need for reasoning.

>          int tsig1, hsig1, count1, tsig2, hsig2, count2;
>          char rt_sigmap[64];


