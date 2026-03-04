Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F1CEFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr3W-0000uT-3B; Wed, 04 Mar 2026 13:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr3N-0000qy-6P
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:34:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr3I-0001CO-F4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v03ULlem4EI11j+dcPRhbiwq8a1Dyj1WkJKoatvE/I4=;
 b=Jibl9OyjJSHIXQ0VvXJYW4XKcKoslaVOi1IutOxHWKxVyzD5Xhcacsj+wbYt9hZ0aGcp8F
 lWjLADwPyKcPn3KNwdLjKnc+ZDVbkZqUAFF2kVkneCUwyAOLVI/1XHHvNw38sAon+2M0UE
 1DFVsL1QR84VKVZ19RVy6PY/f8f6sSY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-AlkpWLrMOsGmR3sVgt07gQ-1; Wed, 04 Mar 2026 13:34:30 -0500
X-MC-Unique: AlkpWLrMOsGmR3sVgt07gQ-1
X-Mimecast-MFC-AGG-ID: AlkpWLrMOsGmR3sVgt07gQ_1772649270
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-506b4005ab7so717822851cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649270; x=1773254070; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v03ULlem4EI11j+dcPRhbiwq8a1Dyj1WkJKoatvE/I4=;
 b=iH0ScbA5VnqOxDvzbAcfVYZBfLS2RQCd0+KOxju7mhG2VQ+ySYqOa3gn1jpsK42Gb/
 0RcH4p2BfeohNfJauLle+RNIMyhMI4yQcb6k2jaUbW+aDf2t7L8OdXSNFSc7eU0ugXKO
 3h3xUwX/XM0APoofZj1/yAJHayJt5mvqp6LzUZWIC+8M8z1OgQnr7ZMDb1FlOqmMKg5x
 41gJ1ptcm7UcTDzeGHbs76QAn2ZAG+aSAn800IhFEl1AclurHKCocrRH2+e4wr1aEMlK
 SNIM+EpQB/XLaOQpNPfiz5LxQMKvGRP2N5DT2LVw+arT8O3ov1CZEPLVlOIQZsLgRYVS
 KT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649270; x=1773254070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v03ULlem4EI11j+dcPRhbiwq8a1Dyj1WkJKoatvE/I4=;
 b=KcPKnAP6+wMNmLY7cvcsOdZZWWYzJLvoDxsnNKxxMb0WzG1m9Hbal7oaVbJCtRDLHs
 mhUNRTWYLgWb7S0eZe9VNyMvHutMRp6+8jieGFack7WhQ7+qawPlg9ID7bf1xK6J1QZJ
 JETeAbBcZvPPRkB+ReRVC+VlMyjMKGCsVY4gvzPl8yO/x+/fIsjQLzBBgB5OB6lkwy/e
 tw/SSkslTv+JSRdk5JjaPWM+kMMAUx5ubQL9GS43oZx/LilvRTqadipxNzblyVnpkWsv
 tvXa36XAOP7rBhZZFCWRvycBGBVqCHLmSkT7jt4oSvE5lKa7oRdWjAQhxnxyqKwQK6Q9
 0dCQ==
X-Gm-Message-State: AOJu0YzuKKDyoQ8AquWq0jDiYOzssNpFwxzZDMbDwbxdQ+AEDUMHhz7+
 HTEM6E0MNm8YPs2Js+eJgLdCMrVvNawJSvs98b/pyqWZMRJW2SPritBZSty5Kl3zKxvX0YZjzW+
 xB9gtVbH6zVOnNd/TCH0Y1CWrRhMe4digQFYJ7hi/f7Wh8fZjLGzuD1RF
X-Gm-Gg: ATEYQzynInyq3qJqh2NY+Z71f3bfeJqfq8Y6OlRWHPv4NZAQjnjVd7IJLaEgtkqwbeS
 RhiHb7CZWSyRG+ZbglZ+DYNJkLoacAjHvyWezh4/c6bBtvgyOrXjR6yVKjH2s4htfvIFlMBN9sw
 oFR+yPCo+ulZjvisrk8ionKWqG5Lji5eg8BaWTT2xYE0gfH+Z2hDdKn/tnLshZoetVSH9fIDoiC
 4p6SoLm/OguUy99lOtNxTCUYMImKT6VcjOdX+CyC72rwQGGTfv06kHpVioaz/oUBDFDMAiXBlsi
 h7E9MPCSIVZZ3o95saU3IMtKUVg2osjzMTS9mPXbPQNOZ2DqIR0QcNqMX6xy0lNyPM9SajiLC0s
 +bxrKey5argNdUQ==
X-Received: by 2002:ac8:5e51:0:b0:506:2116:4b86 with SMTP id
 d75a77b69052e-508dae09bd2mr38462851cf.0.1772649270015; 
 Wed, 04 Mar 2026 10:34:30 -0800 (PST)
X-Received: by 2002:ac8:5e51:0:b0:506:2116:4b86 with SMTP id
 d75a77b69052e-508dae09bd2mr38462381cf.0.1772649269468; 
 Wed, 04 Mar 2026 10:34:29 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5074481c0e5sm179359341cf.0.2026.03.04.10.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:34:28 -0800 (PST)
Date: Wed, 4 Mar 2026 13:34:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 6/7] system/memory: Allow mtree_print_mr() to display
 distinct address width
Message-ID: <aah7KlidOr367dFO@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-7-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Feb 26, 2026 at 11:02:24PM +0100, Philippe Mathieu-Daudé wrote:
> mtree_print_mr() display addresses using 16 chars on 64-bit
> binaries, and 8 chars on 32-bit ones. Some MR / AS don't
> always benefit of 16 chars, for example the ISA I/O region
> fits in 16 bits, and displaying 12 extra '0' in 64-bit
> binaries isn't really a good user experience.
> 
> Add an extra @width argument to mtree_print_mr(). Next
> commit will make use of it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


