Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C288C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBUb-0001vO-Cu; Thu, 19 Feb 2026 16:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBUZ-0001uw-OG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:23:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vtBUX-0008Az-Dy
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771536199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwEE9vCU5oXu2LlOS7AwD08Wz3vqIpSEQ4CVFUj1nuQ=;
 b=UiyBrTtUJC+i+elVx7IAI+aaXUIS05oBWe5U2e6GDmNCdL/nCZkwjBwJeetUSnSqRTezxZ
 uq/C1n9FYg4P1S1/YlJhD21tMdP7ky3bNFm3DCvWBtwjTwive5NQ4FutmP1sK26PjBZYyo
 R++32gM82IML9Iq3wTaYuRoHvmwxJj4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-UIZJBXTRMF2BSBoBNqkXFg-1; Thu, 19 Feb 2026 16:23:18 -0500
X-MC-Unique: UIZJBXTRMF2BSBoBNqkXFg-1
X-Mimecast-MFC-AGG-ID: UIZJBXTRMF2BSBoBNqkXFg_1771536197
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-506c0da79c5so127362171cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771536197; x=1772140997; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XwEE9vCU5oXu2LlOS7AwD08Wz3vqIpSEQ4CVFUj1nuQ=;
 b=uCBxADlLoDEvj31hKalRQoL16XoDK+ocZHFC4s9XuYQ09Dxn8JcmjwhY9AW9DWQxHX
 +JXy6waqebhD3S9c17NP6CS2oOzPEJdnqluN6mpRH9WBpeiUn203qoufF6nPBsR69DAl
 kN5OBejrlmyPV5pi2CNIAxRturbIaHmuMiyYOwcuf658muiftYQ1gIZ181nd4bSFknKF
 tcfCDu6XcpyytHLQbEOcWBt0OTWumDcAxoCeO/WhZVeznAeMmcCu9k/UnCO9uMa3wCGv
 URCsyCVqiispBiKLuolYCzXCN6Xl589jYz/xWXI9l1LhrMU/s+mMl1G28qhYQWNj52iz
 hxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536197; x=1772140997;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwEE9vCU5oXu2LlOS7AwD08Wz3vqIpSEQ4CVFUj1nuQ=;
 b=qZFalFyW0B6xz3S4L2NqhRwDOksEj1f//lPLLfse4HDVdo9erN3YJjMAHN5W7mROmX
 5OTyaf6t0/NYJ1AyxlIudgWTBaX+HvlLF5hd9BeUbH8kZU3wyNfU7kcDB6O0i7hwbGCy
 VrGT23xnaKyqILUOJOCOyuzXYL+yH1x7E4lEsvxDn6fKuvWuq2Wi3qgE0+5pK7dJPcKW
 8h4HWaaZ6YF+aWtegv9MC/7xci5yINUT4t5aSgMQQjosTzkEkaBV3jczQqyjrspwDfP2
 u6+SW53DQB3chGt8U4C6XYaH7122wxGc/dJyl20nl/MwD9cG5fixo4n/xLzImwLf0eqY
 ZHAg==
X-Gm-Message-State: AOJu0YxMTnzOcuKCKxuRmmnSNARcaxV1xmqv84i1Gc3vX7SS6rzdSxaB
 3i7QPoUwsVHPQzngCs50KpVG9ZBVdPY3cunKSTxF/zwmfhlIXqZVs7j+uneOkOuXouD6S9GZv0n
 zzQPIcGDZ50AP/5QRdDxBfJw1Eaklw5UEQbbDGC7tW8g/p+ri1Uh6YYdr
X-Gm-Gg: AZuq6aJ8d/wNZqQKerlBipkvn+obQu1Dla8wpBVz2riByDmHYht3pV1v2JKVNWqze/T
 JwdsmDYOPVPst2scR4afCR+LKk/OuP8nMf1tr5Q3+fkdNvT0ycPoOxg9ptFIHx+rFObhlcLqS4G
 k+Bo9SLVoT2Xdv0FenPb6zk4mI1Vc/9KubI3Lb9VInge51iXsD6HQQgFS98WCUGYyI75KQ2qZlM
 5TZOeNg4Vn7lxRD+UR5tBcAaBAH+kYVAXadkASDv2SnsO1hwx0gHnXZuAWvU3CaoVQSbJTwFyc+
 PjmHceiE+yWUaY1qc4wvQpkOvY+yTE5a36uvGyXXoXUVfrS5njEheSe9Rym0D/BXl/21M5b6j6s
 R+Z9D91Pvb28c4Q==
X-Received: by 2002:a05:622a:1910:b0:4ee:1ed1:43c6 with SMTP id
 d75a77b69052e-506b3f7e123mr256230911cf.10.1771536197337; 
 Thu, 19 Feb 2026 13:23:17 -0800 (PST)
X-Received: by 2002:a05:622a:1910:b0:4ee:1ed1:43c6 with SMTP id
 d75a77b69052e-506b3f7e123mr256230521cf.10.1771536196815; 
 Thu, 19 Feb 2026 13:23:16 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847d77cesm217229351cf.3.2026.02.19.13.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 13:23:16 -0800 (PST)
Date: Thu, 19 Feb 2026 16:23:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v9 18/19] multifd: Fix hang if send thread errors during
 sync
Message-ID: <aZd_OTfcrkRYQ-nt@x1.local>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
 <20260218-colo_unit_test_multifd-v9-18-d8dbdb0ca6f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218-colo_unit_test_multifd-v9-18-d8dbdb0ca6f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 18, 2026 at 10:29:38PM +0100, Lukas Straub wrote:
> When a send thread encounters an error (as is the case with yank),
> it sets multifd_send_state->exiting and the other threads exit too.
> This races with multifd_send_sync_main() which now hangs at
> qemu_sem_wait(&p->sem_sync) in multifd_send_sync_main() line 647
> as it waits for threads that have exited.
> 
> Fix this by kicking the semaphores when exiting the send threads.
> 
> I encountered this hang when stress testing the colo unit test,
> though I was unable to write a migration test to reliably hit this.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/multifd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 220ed8564960fdabc58e4baa069dd252c8ad293c..e8c85cb6c48deaee2c9bda7b821a976166d78c9c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -677,6 +677,7 @@ static void *multifd_send_thread(void *opaque)
>          qemu_sem_wait(&p->sem);
>  
>          if (multifd_send_should_exit()) {
> +            multifd_send_kick_main(p);
>              break;
>          }

Looks like normal migration cancellation will only error out the main
channel not multifd ones, hence the main sync will always properly done via
the sem_sync.  So maybe yank behaves differently indeed and less people use
yank in multifd migrations.  Looks fine to do extra kick for this path, as
long as we'll destroy the two semaphores later for each migration attempt.

Said that, special casing this path looks weird.

We could move the kick main at the end to be out of "err" case, so we
always kick it?  We can add a comment explaining that.

-- 
Peter Xu


