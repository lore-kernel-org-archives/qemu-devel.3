Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96D606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hv1D2Wam
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW6jI-00011p-OC; Wed, 25 Nov 2026 01:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xW6jG-00010O-O2
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:43:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xW6jF-00053K-4L
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795589019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpHSR/ZAnhe+FpQIz/Z9GVJCF43oiyRYlQVbTC5LvaU=;
 b=Hv1D2Wam1Q8QuTG/efN7QWbv4JCH/p6GEaZURjUGCiVuMrGHRvQl4cp4XgONrsPzo0iuVL
 dkvEpoHFYn9VHpWr/LifvQ1JUDRVwIm3vuX5rpIZ/guXGNv4rjoSeHfOqQBgJ6UqXE1vqQ
 HLmUp4YLMNw7J7M7SRRFVskjLdX1W8Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-gw1k5d2zMg-wwK-XnaFomg-1; Wed,
 25 Nov 2026 06:43:37 +0000
X-MC-Unique: gw1k5d2zMg-wwK-XnaFomg-1
X-Mimecast-MFC-AGG-ID: gw1k5d2zMg-wwK-XnaFomg_1795589016
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 640AD1956050; Wed, 25 Nov 2026 06:43:36 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8449630000E7; Wed, 25 Nov 2026 06:43:35 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH for-11.2 1/4] hw/display/vmware_vga: Zero-initialize
 scratch space
From: marcandre.lureau@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20261124095719.4126146-2-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-2-peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 10:43:28 +0400
Message-Id: <179558900825.814245.12253482073540915243.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=677;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=m2SjYq+c3PhuGXGGa3msKxT/bg9WO+CfkNiEPEvQXv8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBrBoOUchdgdJ9y5GDc6AYfj69Hw9cGDy/Cq+4so
 DHbfYOpvLmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCawaDlAAKCRDa6OEJdZac
 5d4CEACD2u3yDG24bcwqwZjSzbolNUwMgmH9v4Fx0rYmENxqoHRFeZvsyyOkubzzL1gN4oBgKJ/
 eJtD5jgp81Oesa9+oaVSCckdJIzHzuxt0LHlTE4KoysKQjoTbHadAHZufO5l+X9goQ5xf4CcFsk
 qwoRCQkeLbhoFkvisXxzNil+FIUPdOuwtFx+r1xzWIB6z5rY4myuYGWVlU5YemiB2Rgnv5hcH7K
 zC3VuHnoOAv5n+uSrEgS4gMBajIWWdwgpOUaVCKgypqFbzXpSVmfm97MqJRHWCs8yobRIYNa37b
 fHRJMhlCQDuGgKu6H5qhmAVID/LbqoRzv4YvjAHat/cFTwrFwq9nKzE0+AOJ+Q/OSt8F/EchJZ2
 68yBxXyNHbuGkurI8ZwCGxbXKVhmeNlmJU4u99TcJcUthhKLBNYwgTdSTd117UOphe9jWdaFyPV
 fw6TgNfIPKCEENmHmM8StMqp96n1D68qm3bbdZ4snTH7ul5ZGNvi6+awxORitsAMl+02ipOZJPv
 ET+CgUDsXgLOCFmMhF3ljdXEiPcvhh6ejMYcHxC4jL/XH0R9P05f7Y89ntfC1aJ91OAWjRNKW2W
 Pxd31X1XhlRDFll3SsfUxf7hQbZxraPVQucSngCm+0RCnR8zwweXzIt3ZziQbiWtTldObvRXWPW
 r5NBGEROWf60Y+w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 09:57:16 +0000, Peter Maydell <peter.maydell@linaro.org> wrote:
> The vmware_vga device has a set of scratch registers which the guest
> can use for anything it likes; we implement these by backing them
> with a lump of memory pointed to by s->scratch. However, we allocate
> it with g_malloc(), which means they start out with uninitialized
> contents. We should zero this memory so that we don't potentially
> leak host memory contents to the guest, and so that the guest will
> always see deterministic values.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


