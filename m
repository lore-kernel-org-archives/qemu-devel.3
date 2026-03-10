Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC68FD4F3F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w041F-00052I-Ep; Tue, 10 Mar 2026 16:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w041B-000524-Am
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0419-0007LH-8g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773175766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JUa5m9NbcRnNMy9IUEE/llzuD6RHQZHLUKQv6HDSaUc=;
 b=D6S8mhCRURiHeHOKVavzzXYU26FNcdjfYrwDVtjR4h7CarUHWZQV9K1JC0dfPi5C1GBwiv
 W9cWG6Cmu0Gy8n242F7mvT+33ev3tfi9czJdkgiTMhHgp1p/blrpyPLi5zeCqCxE7bZJM3
 88HpsifbEGJBkcvfbuGwrK1VgPuONXI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-cymqOLjgNXmcpHKjfnsa6A-1; Tue, 10 Mar 2026 16:49:25 -0400
X-MC-Unique: cymqOLjgNXmcpHKjfnsa6A-1
X-Mimecast-MFC-AGG-ID: cymqOLjgNXmcpHKjfnsa6A_1773175765
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd91c0262fso1040818485a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773175764; x=1773780564; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JUa5m9NbcRnNMy9IUEE/llzuD6RHQZHLUKQv6HDSaUc=;
 b=cO3tjd6MfzqQuNefw0TSbzszBNjtGg7qXogMykmluixhf67jjh/7Ap7ztSntx1dufx
 Cd1bbRKvCgIEyYhlPWvrWgDyyNv98NPqdkEDBiFwyEV9RooCIA3lOjnIFzamPFY30+57
 0of9cq5zpt6t5nbCNwOVpa0sYBqiBUcwb6qUfb8NJ2r5UYCarUJAdydemrl7PHSgBaGA
 9icxzsFWJ40JpkGqEEEB2hSNNEyDkUhiMLIY5piP8H6m5/1b5rmmJVLcxSw5UQaU0s/0
 TFiiTpEPfHaY1/e38/KAKMoUnW7IDGUyvlnEv0QCc9lhR8d7Quq7VDiAoIMWlMJ0MNYX
 9Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175764; x=1773780564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUa5m9NbcRnNMy9IUEE/llzuD6RHQZHLUKQv6HDSaUc=;
 b=SEONmAFRizACn90XclJcMuSpEMXKORTd/7RIr8Sdja/Uvy9FZXINHvio1OO2RDHA3i
 qMtsuqecHsdzf0uFgOSQjeSgGbDTLxoCFTBBfZal9ZupVxAE0NkI4Kcr6YEzHWS9+4kG
 uMTwQKRYvJZDc4GmLRvZ2XOFsTAZ7uHnWPtulY7BCIBlHVRmlbbAA51O6uxg6NpKQo3S
 rvvBHNSx5DTbyDhNVM9+ljfcXRSyyrGTI55ATOwJ6q6VdOGiu/jtdWwC+nCyRTZcaa7g
 +gLEh0b3mGCQPr7pKyDpw3hL8AZdkzestjHzfAQADHe+gGY4+wNulqY784Er/HvfaXxz
 +Szg==
X-Gm-Message-State: AOJu0YzLfT7cx1SBFT5vXnWf5//Avy3OCIPX0zr1YszV0T6Ie0xIFMLg
 4+s8lliPP0XOKtHcdeam/dD2mXHIq0G2/eUnOnFZbX1oQIgIaoJmlfi4ZA8jVveAnTY5inzL9wa
 VpzktaSWoSIht/uXz96RrQ58lJSMwpiHWgG6OnMSZWTnBsG+CfzoJ7Yun
X-Gm-Gg: ATEYQzyVynFgWB6oLLH8D2qeBuSoI4nfb4P7M54JKHGXZbrIPMUyMjPbuLY7ys0/8XY
 7gQ0k5P0rYAjO3JsPhYaeDR1aagURgCniQR9qhpz69P6PK3x82cFf3d74cTvT1B3DAvzqczwFrD
 6jCPFf07p+TAMo8fVaEE9w0PQwpA0gDstWotWsmEj3pAD8GkH3jG34APy3WSlJ6lG/uEoV0CU4H
 wjNY4DcZSdvlEvsYvgJdzVydiDmk3gI7oTtH53NLIfBMpgW4F9E0vcQkJv6t4WkhgU/xNHaCpcv
 KKgI0T/VbgzVtKapnpQp6BxuFV01DpLqj9whNxpOVxLFVzlPxfKM/QmkWM+LILUn8rBe02L9K5N
 kQK5OqyPZZ/Glqw==
X-Received: by 2002:a05:620a:2805:b0:8cb:52e0:15e7 with SMTP id
 af79cd13be357-8cda19f8c66mr42747185a.33.1773175764576; 
 Tue, 10 Mar 2026 13:49:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2805:b0:8cb:52e0:15e7 with SMTP id
 af79cd13be357-8cda19f8c66mr42738085a.33.1773175763645; 
 Tue, 10 Mar 2026 13:49:23 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fc09efsm4817985a.2.2026.03.10.13.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:49:23 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:49:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 8/8] migration/multifd: Fix leaks of TLS error objects
Message-ID: <abCD0UsimnNk2uGf@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310135540.8679-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 10, 2026 at 10:55:40AM -0300, Fabiano Rosas wrote:
> The code currently ignores errors from multifd threads that happen
> after a first error has already been propagated. Make sure the
> subsequent errors are freed appopriately.
> 
> This fixes a leak of the TLS session->werr when the certificate
> validation fails after multifd threads are already running. The first
> writes on the threads will fail deep into the gnutls stack.
> 
> No need to check if(err) because the callers are all under a similar
> check.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


