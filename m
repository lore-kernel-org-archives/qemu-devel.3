Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6EB606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UzR6u+RD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW6jV-00015X-Nz; Wed, 25 Nov 2026 01:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xW6jP-00014T-5m
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xW6jN-000548-Px
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 01:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795589028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgdppwJMl2RylOYO9aCrS/2hiranjtRJgIlzxga98Yw=;
 b=UzR6u+RDrw4Dk3gX6tLnqQgn3EL937VR2ZbD13Ekkfjkqu+9tY475LoOfLsjvte0nW0x5a
 WUiUZBTE1YZdngobQChvnPjdOzH/T+Zu3R3mr5YXnBcMce5iUNR9/X6lhvhNRZBSeprQwL
 I9AD/69HNh6CPmzF1QEc8iWIJKiA3R8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-l1nZeXQcM_yiZLe0Wjn8qw-1; Wed,
 25 Nov 2026 06:43:44 +0000
X-MC-Unique: l1nZeXQcM_yiZLe0Wjn8qw-1
X-Mimecast-MFC-AGG-ID: l1nZeXQcM_yiZLe0Wjn8qw_1795589023
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05E68195605F; Wed, 25 Nov 2026 06:43:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BC701800551; Wed, 25 Nov 2026 06:43:41 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH for-11.2 4/4] hw/display/vmware-vga: Check incoming
 migration width and height
From: marcandre.lureau@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20261124095719.4126146-5-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
 <20261124095719.4126146-5-peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 10:43:28 +0400
Message-Id: <179558900828.814245.6113881036964319235.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=796;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MkIqsdrp9AF8sKbBz8RUtB6BqOshoNAc0JTLzb6HevU=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBrBoOUV36DXhbdo9ll83zfj7I9wYmY+28Kj2tR/
 5qTgnfkokKJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCawaDlAAKCRDa6OEJdZac
 5dQvD/ifyx5mpWxJdqkxDzY3N3azJTtkKvYfsJJxZHPnSXgzNiMkHhsKEP7j30Q5K7K0t76NsaH
 cF6FdFjG1vKbwH9p3PAxorF5hZC660B8OzVPIaVmUjymoApOqHQQtvs9adrF9cAbu7wdjEIWsxP
 6MPN1Sv3hcuu0ussBuOWIvEixwp/lXGVTCxSLHIaxhirB2rdk/rUC9HH1xgsIO9dIYbBXT5mbHn
 C44sMHKIoxjiuauYKUenEIlkBHFEWbhK8NXVIDNdfvHXwgVAzsXwRBV1wFHwFJOvVF//51VjPb/
 EnxRdDKx+z1zZcGDPHf25bYumwm2FSFHlEyr2M1ra03cWkJD2G9Ng1ol3DEu8ntzNRl89MID8aV
 mKWDYFXufAZ6Se65J2/nD9MT2b/UfGFrBxvS/Bftlm4fOkJudo7d9RHlBBexF2jdJ2Hm6YXl5LV
 VbKQvvXeL7PMkSuQe2GHVNnYuHQ+mKIyERdUffonR1nzv9HjTZTMCiZzcg7o7lay2PLz3Zh0lf4
 3a/nBrMS5WUcQUfc2LP186eXHhcZbJF95do9MHZdZ3eloIsNnzjt45rjLzxlYMf8uQT7W9WsUNb
 WjDk00f67ToT98B9yBEK5yPEu5HzbASRsVWetxKCANFtf2IOPWcINeraknlChO6cWiz0HfOOgGS
 sipkD06ofdKsb
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Tue, 24 Nov 2026 09:57:19 +0000, Peter Maydell <peter.maydell@linaro.org> wrote:
> The vmware-vga code sanitizes the screen width and height when the
> guest tries to set them.  Apply similar checks on the incoming
> migration data.  This prevents a manipulated migration stream from
> being able to cause us to create a surface that exceeds the size of
> vram.
> 
> Since we already put in a check against creating a surface that
> is too large, the checks here are for:
>  * ruling out a negative width and height
>  * catching the issue and failing migration rather than letting
>    it pass and then coping with the out-of-range values later
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


