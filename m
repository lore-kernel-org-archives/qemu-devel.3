Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76896D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1obL-0001Cf-3M; Fri, 18 Oct 2024 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1obF-0001Bk-V1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1obE-0005dn-2G
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729264143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdxZ8/ZiJB7I6MWZqwFtw0ZOwZ10i/ZCOegjVYgqpx8=;
 b=Ckpp6pN/xwvNckkqiBWfaQLzXy62+VohZcm75prxkv5GLv6SKmCRu6M/MmizukKjqeFWf2
 ND9f1HC8hZKXneXOrp1wdR+GukLWBm9lAHyDL3Usf6mvZQZPMB/85yyFT76kTw0uGPp1q/
 O4UPGi1BnKZaBV0jgZaKh5x6XTDQpD4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-aO8TlqujMTWykuzCvs_5Uw-1; Fri, 18 Oct 2024 11:09:02 -0400
X-MC-Unique: aO8TlqujMTWykuzCvs_5Uw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbe3f76876so66660696d6.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729264141; x=1729868941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdxZ8/ZiJB7I6MWZqwFtw0ZOwZ10i/ZCOegjVYgqpx8=;
 b=EfxhOxFHYiNKz9z84OwcmQwmQuf55a9Ns8GL1xVmikgep5/wsMTht4p6o9I2pEbFkH
 tYJkHrjkX6vNrPWvYZPSvHka1dRYnH/RpdaY3i5e5Q1TcYha9iBR0Tuxps79DdRKVFps
 qdsqfDqR8U+3Ck7vJNNSfAUjz7+/zUEVEzwUJTPO/eYhHuVg8pJCOZvDb8dnx9CJVOrt
 8n39P9EePx4W6pJHHmrVmQ0p7EBZcKLdPLP1rM2mRMMqBNEQ1zQBYOR5/WNZl9uTsSTC
 b3ThEPFuxxFXijXa61gacbKxbyzbLjqv9UUxQSp93kST5LSsGL5by7bp3BF+B5P56LIq
 E+0g==
X-Gm-Message-State: AOJu0YyMdRgPI6vSbFZ88Nf7Xv8hEqHUuXV+GpZR1tSANmZMeZryKa01
 cLxsA9xTnPji5y/5g3Cva1CvsOlmuACENgXzkyLkoOdwglbBUGZpdEKdZAex3Fb+YCkazH4rWy8
 QovXIlnBUpx7rmeE3bFGORSKdSoxNbfuLurPVxUC/PMOkJuqy2uu7KxSeE2KO
X-Received: by 2002:a05:6214:3a81:b0:6cb:ca0a:4749 with SMTP id
 6a1803df08f44-6cde1b82eeemr50520486d6.21.1729264141452; 
 Fri, 18 Oct 2024 08:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4r7LKezVq7mWurTIya8NTo1L8OFUrPR+MeUrRIxBo9nUZOc4C+FUAxrz3FZhDdz0R/lx+7A==
X-Received: by 2002:a05:6214:3a81:b0:6cb:ca0a:4749 with SMTP id
 6a1803df08f44-6cde1b82eeemr50519736d6.21.1729264140875; 
 Fri, 18 Oct 2024 08:09:00 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde114e81esm7818836d6.53.2024.10.18.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 08:09:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:08:58 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 0/6] migration: auto-converge refinements for huge VM
Message-ID: <ZxJ6CoP3WUfj1jVg@x1n>
References: <cover.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729146786.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 02:42:49PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> v4:
> 1. split the [PATCH v3 1/6] into smaller patches.
> 2. refine some comment and commit message
> 3. fix race issue for the throttle_dirty_sync_timer
> 4. refine the util function cpu_throttle_dirty_sync_timer

queued, with a fixup squashed to patch 5 per discussion, thanks.

-- 
Peter Xu


