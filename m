Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FBCC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpus-00036Y-Ry; Tue, 27 May 2025 04:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uJpup-00036O-JA
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uJpul-0000SK-Cc
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748335438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=et/BwbUsXqvzAlagMQrqMH5Ict+SSCZLV52FTdB5VKg=;
 b=ir3nXAA5RTm9JPOg5klzOYFxBwsy3Mq97Lks2pnbVWn13h3gxRnm79IvJ1wWo4Wky00GQR
 6dZ3pFovEleKcHBZ4Fqf33XUlkUtDQ+c9cud1hSzspC3yKHMkQKwrwd8h3zfIbQmLd1O5R
 ZmrLTTKdRo2mEqv59wwt/RKw8Drnnfw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-0Lr5BHPtOB-VCi7OVJkB2A-1; Tue, 27 May 2025 04:43:56 -0400
X-MC-Unique: 0Lr5BHPtOB-VCi7OVJkB2A-1
X-Mimecast-MFC-AGG-ID: 0Lr5BHPtOB-VCi7OVJkB2A_1748335435
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so17357995e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 01:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748335435; x=1748940235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et/BwbUsXqvzAlagMQrqMH5Ict+SSCZLV52FTdB5VKg=;
 b=ftnCBzh8cSN3EpEWg7/FVps0UBQFXQ4zhqY5nTe+7kKTXhbS8aJ4hArbT2Vcs2V2JA
 7gWUm9Yxtmhat5Mhnf2sJ8QGzSVOLqRlf/7xgyUEy1Y+itEyTJ3aoBipCN89YJEvsN4H
 hl9nNLhbVgBVZDzb43cL3GrYtWlZAWVl+gl+6Hyur9BzEUyyYC21xTET6o+ZjtI8mB23
 injcuOTVv/u7jedH4YPsX01OEgrpvbSkYhNdGyc4C1yu+J9zqtnpNUQNGNvjyRC/WCXT
 cErEGLah7mLTgf2Dr3/uze9vSoQAsJ9E9WVhexlIwcXI/k36nSmaYkaFKzKXv2reOZFR
 QxtA==
X-Gm-Message-State: AOJu0YwYU2qT5ObIzwFGZF9DS1t7J8SguTLNWRPEgRTkx0+NvrpEMcBX
 GwzqXuzD6Xbj1go8Ox8PI3SnWOZ3BXU517QI7oeq9F9mHzQQrqxd7HQiMj8Jnj43z+kCZ/dRXbk
 uOTmAxmp+kAhi/1SyyKbqD3N46aV/CDP1y4c4HTrW6KQmbJv/FRzpdJmk
X-Gm-Gg: ASbGncteRVJTAV0Z8lzW3xvM+UVNRkdv3Zr7umL9tl/+uMSU7IK2C0JWeGjyRlxuLmC
 N00ifrqLfFHFWqoE9dLJZ5qkvZ0Lxe44x6iolK85Tc02MGuw2240YVRfvGeZWxjt6Hkg6YGMHiD
 hy9PuG7n4Csikj7Ij3mDl8iXip7Az9K00bGOBA6znsoTYUXLvDTDZhSWmJkfTsaOAupJc8qqIoq
 aw/5Tkq7LKxbI7f5z+J/ewWIXl4bm6lHTSV2pLAXB+Fbu4N6nOzphZeInNVMY4Mhu8DdzbMGvwQ
X-Received: by 2002:a05:600c:648a:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-44c92f21e1fmr89008645e9.24.1748335435070; 
 Tue, 27 May 2025 01:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4/xLgi7TVojFWWBHEUr97ghnhwtRSly8NKc/JgDyee7S/qO+UrpjbQLPWqhJ/k1VYUYBYJQ==
X-Received: by 2002:a05:600c:648a:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-44c92f21e1fmr89008415e9.24.1748335434691; 
 Tue, 27 May 2025 01:43:54 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142b8sm258180035e9.30.2025.05.27.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 01:43:54 -0700 (PDT)
Date: Tue, 27 May 2025 10:43:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, berrange@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, brian.cain@oss.qualcomm.com
Subject: Re: [PATCH] tests/unit/test-util-sockets: fix mem-leak on error object
Message-ID: <vrczuxngojoryf26h5k2gycypoeiwoqchd5sevxa4anmwq3dd3@aofc7j55qwcu>
References: <518d94c7db20060b2a086cf55ee9bffab992a907.1748280011.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518d94c7db20060b2a086cf55ee9bffab992a907.1748280011.git.matheus.bernardino@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Matheus

On 2025-05-26 10:20, Matheus Tavares Bernardino wrote:
> The test fails with --enable-asan as the error struct is never freed.
> In the case where the test expects a success but it fails, let's also
> report the error for debugging (it will be freed internally).

Oh, nice catch. Thanks!

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

> 
> Fixes 316e8ee8d6 ("util/qemu-sockets: Refactor inet_parse() to use QemuOpts")
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/unit/test-util-sockets.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 8492f4d68f..ee66d727c3 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -341,8 +341,12 @@ static void inet_parse_test_helper(const char *str,
>      int rc = inet_parse(&addr, str, &error);
>  
>      if (success) {
> +        if (error) {
> +            error_report_err(error);
> +        }
>          g_assert_cmpint(rc, ==, 0);
>      } else {
> +        error_free(error);
>          g_assert_cmpint(rc, <, 0);
>      }
>      if (exp_addr != NULL) {
> -- 
> 2.37.2
> 


