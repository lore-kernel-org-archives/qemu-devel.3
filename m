Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692D0C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76ox-0007E4-06; Thu, 17 Sep 2026 03:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76ou-000713-8P
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x76os-0005WH-GV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SKXGIzs74P/PKp53kUW6JYT+pkwcW+Dt5BC9dWjBWnI=;
 b=JrNn3pQ04ZfyRmcgSs3G7P5+7gLJL7eZ4H4uHCpaeuxpr2gbRaSmQpyzKTN07/cdRdx4zK
 qmTXpZ0S2vMUzRrqYyydhVnQOgwuN3vwuoXPqXGg3xCgyvgjMfVdIg8YJ1OL0ZRiZVpIHi
 qvrGk3drtisFZa9UyMgpYgZmCmYDCG8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-C_a0pxAqPCSVzgzHqTU1ow-1; Thu, 17 Sep 2026 03:46:07 -0400
X-MC-Unique: C_a0pxAqPCSVzgzHqTU1ow-1
X-Mimecast-MFC-AGG-ID: C_a0pxAqPCSVzgzHqTU1ow_1789631166
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e7631c43aso7034165e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789631166; x=1790235966; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SKXGIzs74P/PKp53kUW6JYT+pkwcW+Dt5BC9dWjBWnI=;
 b=JcVpc7esFwEq7bK5TFYfvWYjew4+JHrrI3f1vTYkVTxLvGyAjsAeohVr5WHBwgTkfh
 Q+srYVgyc7wfi1QylV7/ofMz89hKtEAa71XwyfixdNqXxSeS8TrywelneFzcHJ4cabRm
 +e0u8JnylyWEPVdqdvuJKt/Q+6KHbbxh1+onXmSmzeNm+EfKJVxsD84rXjh+mhgIsRZ6
 QNTTLl2Ht6S3NnshYi4JXlHSu0l7JiVtIDrr0xDco0AFBzcdk0bplSPHKCC3uBhmIujB
 uVgkKaIhZM+t/EXS6M89SNmgelxVTt+LbPSQY2to8HZfTppGZCY2k2rwcpJAp46F2YMz
 wTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631166; x=1790235966;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SKXGIzs74P/PKp53kUW6JYT+pkwcW+Dt5BC9dWjBWnI=;
 b=WBpYI0nswyAanj9AwMrWMu4iHw6SqoZ+xQia9Pyf32gJVvfMEJFgpEYN09kp50zgvv
 qLRfbsxbMTqqaFha8e5x1oEX5JEWxtABh6GpwIkq5XY9dn2TUGpIYRZCGFP8dGkQhykt
 A6eGAZM/sFANBlklIpgLJBeVF/Ae/M6foF722ZGJVTV879rZj21annKkuD/uxdtRmMK8
 d0CTuXHkU6dMJWc8CTPjdjXQzoFQdOffRSmqoiyiZlylIMHd/wAh6eaIN9QY1DvNJwky
 g2VDQVPOGISO4+YclMgNW0cbpaMnnEjudDBlrV3H173BS8r/lZ6WvK4Tm/HAc0JT7quz
 jmvg==
X-Gm-Message-State: AFuF++mlMGeF/v5fRewwlO5S5rljrwmuj90ImGSuc/87JCp7QJi1AObf
 a+x5vAMdn8OJDEGXJOZyij4Y3J47Aj5RJF2bOc9+JfLMMax3weYru0ARerHITvX+uSfSWVHj5oR
 JfYDI3DUVnNQhd2jihj5Q1Ej7N94B4qZ0QBQyzNU3mA0ZtDWIDxCba2N3
X-Gm-Gg: AYBFou349X6IrVOQvKb1vO0XmWfVBUzx07+m4am1Spw7nY2aTxcOTZoRVEoGWh5y2UY
 Sj+R/Squqbjng2Cx9J55G0P+6twAHj/asVw9hZRvekMP3lYLdGVhnm7JE31vue/smaClcIkojSF
 gd3uibYFJg3Y3SCN/ubobX32RuuoHGTXlGVNU/TO0H+Cszb44ZWbmqkM06ZptJ4Fsz3cc+vWKkE
 XPxRA2MKzNtktxr6eq5jTh3vhh5FmRJYG249Vs4dS4UdYaCIatY4EHX2sTuf64ceLcYcnAeYoDq
 lnaosDb/ier2KnGcA5lFQzhp5viKfddCUa1Z4ykdK9OKPS8T1mnIQ2Qp5YbM+yBVtR7ugG//t+/
 Tt5FGMwddHFgpvHxypUbLvH5e6eZVENpUfVexT2tajkWGZg==
X-Received: by 2002:a05:600c:6097:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49eb7300f35mr102434445e9.6.1789631166551; 
 Thu, 17 Sep 2026 00:46:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6097:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49eb7300f35mr102434135e9.6.1789631166175; 
 Thu, 17 Sep 2026 00:46:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd227141sm63617225e9.2.2026.09.17.00.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:46:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:46:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v5 2/2] igvm: mark qigvm_find_param_entry as static
Message-ID: <aquaqH2f-tFrGg5W@sgarzare-redhat>
References: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
 <20260916-fix_offset-v5-2-11cf8ef37854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260916-fix_offset-v5-2-11cf8ef37854@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 16, 2026 at 05:10:06PM +0200, Luigi Leonardi wrote:
>Previous commit removed all external usage of `qigvm_find_param_entry`,
>therefore we can mark it as a static function.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c                | 2 +-
> include/system/igvm-internal.h | 4 ----
> 2 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


