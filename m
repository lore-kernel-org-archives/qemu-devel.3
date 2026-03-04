Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065B4EFCE38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxr2F-0007MO-GD; Wed, 04 Mar 2026 13:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2C-0007Ln-Hs
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxr2B-00015a-9Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772649202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TH/cFZzO+ZASso0lfUMBee+o1sRzBuDNGDvEaraKcao=;
 b=EWm30yukkmDp1HZ/sZiX/sInfofskhPY7sPVT2XOzex64gThRhNqfKuOx/88AEzd6Jfm2c
 578bbqMfvAJ6bNcZ65+BVbF0XFd5hMZn4VUmSgko52YKV1yfjmMe/jB+ynVXFdcdr6C5Te
 Nf5YuqilVBymoFRxv2sttQZ4odqgJTs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-JGBQYPx8Piur9Yq_084tKQ-1; Wed, 04 Mar 2026 13:33:21 -0500
X-MC-Unique: JGBQYPx8Piur9Yq_084tKQ-1
X-Mimecast-MFC-AGG-ID: JGBQYPx8Piur9Yq_084tKQ_1772649201
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899f1c1e4d6so261167396d6.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772649201; x=1773254001; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TH/cFZzO+ZASso0lfUMBee+o1sRzBuDNGDvEaraKcao=;
 b=NzmI1UrDaH5ERMwRKwM3tEYzZzd/90ih/es0V33Zi6SY8gyWXWsoEqxLoWm8DTqjo8
 PD6C+vZFHeoWgNt/4I1aJ2rAIAFQ/k8rKSYRV3lx4XS4aQkYavc7/K525L+wAGFBo2D2
 JgctP/3Afd9pYzHfUUwx7OqH7OxH4v49LaNRn8fsgIioNc7J+4jugBS33hudB+oyW015
 K2EExlx8OqmEV86XI1M9X9e1QmCHWHxfY1ijJCXGNe3QkTlNRoQlHV9XbKO4cjezEaJi
 SgoQqS+IJ1i3wDzR/m06c8iAM4wmJ82Nbg+CVBo1j/SNRACN+agquZsRhiR1hHWZSjsS
 S9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772649201; x=1773254001;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TH/cFZzO+ZASso0lfUMBee+o1sRzBuDNGDvEaraKcao=;
 b=waKDxGpFpsRgfvdqhIiSggSIjHinMxiTzx/9a2t6BEfknbaWlzP3HdzWYwmGEyzxx9
 LUQvlN/h6cTnIgGKnS4Tqu2YjZSVQy1BMeAzoxDBJXFzNJ+Zy+Hn/LC1x9d4UZ9L3WCA
 IydpH7iFRV28+VS+GoLx4ziwTIIjlEaMZyolFhbZrnOcSj+3Jv8pffsb45LJWTCFVg0a
 aMe0pcN9/Qz2VvaQTNyT15ZV4tyYsMrX/TgbvDKfukhCJ/OwZErw6+z0vdGiK6bybXRE
 rdfrsRsAIb1jxvs63s4d2LZfEadgUoYbl1LF7yCR9B1HsQuKAAqvt+Ws/ZLEZnwuMJNm
 tr5Q==
X-Gm-Message-State: AOJu0Yw3TgjhmieWRkTNx7FLfbOMXKHrDkTUOSzlGkXDPbZK5aFpR+eF
 50/5JlJpyvVdjkirhI6q5NOB5zgA0SydOA9Ew7xByKSYnUWrK2ph0QV7fMdZHC5wFBASvn+4LyN
 gJHRWfSax3sFU7F7ddEO3EVazp6nCCqDQKHCv+RK0BWL9eD9Pa86z8LGt
X-Gm-Gg: ATEYQzzeTpnOQwJVuYvtuOgWSZS9xgGfh/McWWyQ3LeKMwW3m11klHT2Jl0DuFzdd8M
 3H+XSS/7z+TUp2SlUlFvWn4AOI3uj5A6dk+6GGfTNoOEjMWnzFUp3+/0p6gBBN/kAo5iLqrerX3
 /FfaEVLIDmXQh05ZvNOLpqV1AXtRpya2Yzu7HJgsD54oSspv0OVHSjhb6tk4fs3QaYhOCF8AfGK
 srFffdymOkPQxubCD6wDby7NNkePP6Yqt2/ETteKCSUB6SOMKwgB4r845zqSvRDGbOTtSsUbvj6
 9uufz5z4NZxDYF5oPgt6LzZGp4wcRQMhwPiRG5jZTc6SqKdacrFbjnQvTDcrI5cwU6GlaI6z/AQ
 w8pswLsxG8ByxYA==
X-Received: by 2002:a05:6214:1c0e:b0:89a:b20:9f43 with SMTP id
 6a1803df08f44-89a19aee86cmr45359656d6.24.1772649200591; 
 Wed, 04 Mar 2026 10:33:20 -0800 (PST)
X-Received: by 2002:a05:6214:1c0e:b0:89a:b20:9f43 with SMTP id
 6a1803df08f44-89a19aee86cmr45359186d6.24.1772649200112; 
 Wed, 04 Mar 2026 10:33:20 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899e89bf39bsm101027696d6.18.2026.03.04.10.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 10:33:19 -0800 (PST)
Date: Wed, 4 Mar 2026 13:33:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 2/7] system/ramblock: Constify various RAMBlock arguments
Message-ID: <aah65IsLODmLEL1e@x1.local>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226220226.20164-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 26, 2026 at 11:02:20PM +0100, Philippe Mathieu-Daudé wrote:
> Mark the RAMBlock structure const when is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


