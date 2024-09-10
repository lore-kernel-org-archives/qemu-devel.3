Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54869ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4dt-0007MV-Qd; Tue, 10 Sep 2024 13:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4dr-0007Eu-Sz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so4dq-0003YX-8k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725989221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwxjXMUQr4Xjv38FMLIjh5rAgIpVCJme6TNvtU0kcfE=;
 b=cHO7BRZGh2fWZgZDNv9ddlkSbLodCtNqUyt3nCcJk3SoK2eqF47QxdaTU81g4mq3B3GA8K
 UKza1afdbEBR4i9M4tI5VOCAXv2S7uRQZB4jzCa4HF6i60oWbpWoA2L4NJS6oGgIJK6dCE
 XQbzrd5BtzaLzDd4b2erCEXgixoVpe0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-uQOiYQABME6UKfPrCe7fAw-1; Tue, 10 Sep 2024 13:27:00 -0400
X-MC-Unique: uQOiYQABME6UKfPrCe7fAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb827e9b6so8285065e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989219; x=1726594019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwxjXMUQr4Xjv38FMLIjh5rAgIpVCJme6TNvtU0kcfE=;
 b=Rv3q2M5lPpr6EHDK5pzEfk56Ave8IqBR8upuzT3s0PYqUs6kDHS0jO44mJgwFUXtrN
 h02TVCdqC8Urg6tu3Zj5Mcwl9uD2cGL+WNu0NyYRA2v/Gwa0jQWl11kKV5FvIaht0I+1
 WVZLjZHpidyEl+p60dsDIJFr0FACymLWkhQXqXv7rrMvcjnWr5O4Hcv7B/Hst+F34rto
 KLAnEZQKnobaQh1OTyLZkVsWGuJEUVmIMYmLo0xyJXLCH9FTWRqhD4UlMYC9OfRLdUBZ
 YCbINs/Fa5J2AmILXpbNuhKQZ5/GW12Fy4Ynzujilpftzj4Ne4zEbrdokRCzbm6NHOgG
 P9yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVrPNklaroghsTNBPLd90xJf237w5+/Hd6XzBC3R40F9bZmw7AsJ7rW1X/Gdy7qCmX9Vp/VRzcjcc@nongnu.org
X-Gm-Message-State: AOJu0YzlCmCpi4SBN+s3VLDwCpQzvHJ1nOuXbKoNb6ziNahV5YfS2rwu
 j/BhaKBkIX+hPaGTL9+l29bu58dN/EMfrZyx6Rzp/BvNdRpitrmP9/IjXzGkbmNW5LIYan7spy3
 P51dQx36kbMqPF+9zEs4dy3hg+46CzURnnlv2bQdMMPnWn38d+K2Z
X-Received: by 2002:a05:600c:3109:b0:42c:b9dd:93ee with SMTP id
 5b1f17b1804b1-42ccd35fcbemr3063335e9.34.1725989219155; 
 Tue, 10 Sep 2024 10:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAuysiFODPzDSAUAn9inzDiiewuatunlg5RkzOWXPsNMzHD7oMQCUa9BlVeRGfjbysCE/RHQ==
X-Received: by 2002:a05:600c:3109:b0:42c:b9dd:93ee with SMTP id
 5b1f17b1804b1-42ccd35fcbemr3063035e9.34.1725989218332; 
 Tue, 10 Sep 2024 10:26:58 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb44887sm119093435e9.23.2024.09.10.10.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:26:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:26:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] docs/devel: Prohibit calling object_unparent() for
 memory region
Message-ID: <20240910132635-mutt-send-email-mst@kernel.org>
References: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 29, 2024 at 02:46:48PM +0900, Akihiko Odaki wrote:
> Previously it was allowed to call object_unparent() for a memory region
> in instance_finalize() of its parent. However, such a call typically
> has no effect because child objects get unparented before
> instance_finalize().
> 
> Worse, memory regions typically gets finalized when they get unparented
> before instance_finalize(). This means calling object_unparent() for
> them in instance_finalize() is to call the function for an object
> already finalized, which should be avoided.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

who's applying this? Paolo?

> ---
>  docs/devel/memory.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 69c5e3f914ac..83760279e3db 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -168,11 +168,10 @@ and VFIOQuirk in hw/vfio/pci.c.
>  
>  You must not destroy a memory region as long as it may be in use by a
>  device or CPU.  In order to do this, as a general rule do not create or
> -destroy memory regions dynamically during a device's lifetime, and only
> -call object_unparent() in the memory region owner's instance_finalize
> -callback.  The dynamically allocated data structure that contains the
> -memory region then should obviously be freed in the instance_finalize
> -callback as well.
> +destroy memory regions dynamically during a device's lifetime, and do not
> +call object_unparent().  The dynamically allocated data structure that contains
> +the memory region then should be freed in the instance_finalize callback, which
> +is called after it gets unparented.
>  
>  If you break this rule, the following situation can happen:
>  
> @@ -199,8 +198,9 @@ but nevertheless it is used in a few places.
>  
>  For regions that "have no owner" (NULL is passed at creation time), the
>  machine object is actually used as the owner.  Since instance_finalize is
> -never called for the machine object, you must never call object_unparent
> -on regions that have no owner, unless they are aliases or containers.
> +never called for the machine object, you must never free regions that have no
> +owner, unless they are aliases or containers, which you can manually call
> +object_unparent() for.
>  
>  
>  Overlapping regions and priority
> 
> ---
> base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
> change-id: 20240829-memory-cfd3ee0af44d
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


