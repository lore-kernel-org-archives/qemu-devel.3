Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D12C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 22:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9tGC-0007vy-D0; Tue, 29 Apr 2025 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tG9-0007vN-Sc
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9tG8-00076H-7c
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 18:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745965018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubSeTtcfjSfz9gMCcJiIN/L+o5YJBUfRBCcZzyBCehA=;
 b=VozQsPC6hDOLc1JOgXgLUi4qP8D3NWfVFGuk5eW9QflaXt/b5coUOluIghiAYtklBdK3+n
 pNwfDfZ9kE2p5FYhLBHXgWaSS1lVXr+AccMUTtnSyY48cyaH39mnMgwcKgN9IBiob7KOBT
 oLPQK09TEYM9y8AGTjVipmoNrxgb5lg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-gM5IRydgPz-xFAVudoXbNg-1; Tue, 29 Apr 2025 18:16:57 -0400
X-MC-Unique: gM5IRydgPz-xFAVudoXbNg-1
X-Mimecast-MFC-AGG-ID: gM5IRydgPz-xFAVudoXbNg_1745965017
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e9083404b7so117863076d6.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 15:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745965017; x=1746569817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubSeTtcfjSfz9gMCcJiIN/L+o5YJBUfRBCcZzyBCehA=;
 b=F7rP/kPotE26uxTWVjSjqTPnZYJ8wUSvHV+O9oOFbHXfgnOSny30ckS1oTuUmt5Stl
 T2o2nzKi0JwKAP7OGhTgcBdzNht3JmVXoYdbkzpSSrtAM5YGBBSPWi7oS4wrZdOI5p3w
 gXkX8zMOJs/J4/3gLJA4k6/8ZgP9cMg30S1yKX8tlLrIrwEESyLUyiauwzbfkxK+OIm/
 ZO1cAnfiK2Mq1FT9wsfyJH5dsTfJ6ws/qctX2TzBFkOltDejKuuNI8Q4X9M96ttzMwH8
 Ro9u4k3IleX5dgnnC4De3Rx3GakmjIXP8PgIulGtXU07yXKKmZ9oZiSraITCyYsgBwIX
 HZug==
X-Gm-Message-State: AOJu0YwPa7NVS6vWC3dmZZrLbTh4iZYLUImS46tg4FK8qlQz4AZLOabH
 crVoCYx8YpPgZUuqTq2ndohB5/7DzwdJno2DSThUl4T7jZeBzNeyV9KhWj4+hdfPKVl3VJxhHqW
 m3TQFLDJunm0b42VzicF1A2jXbE+FYbUO6zc1Htn+5E1rVuvRSAJOSHk0U22y
X-Gm-Gg: ASbGncugwRfLnt/FbJSzS3+XC2ciolzyxQqMmtoBOrWJOSNhnEkI4efvyDU9UZxlKIE
 dXmuJpQMJX8zyCuxedGrqzQj/Nye+sX9hOw0ccgN5hhd9XjSvQQU89tC/UgKwj3/521wL5yMyIf
 yH1YLWvztvaXkS0+wuPg2DfxL/KCzAGdWRIbZSYWaucgv3KYS569A0b4PiyQk/Axa6vufqXv0pT
 NtqAEHuCM6Qyh789Sv73JsBZMC7oYNwl1dBHEFd+krzbx43YVvAaPzu6f9HssI49mAtE8yKakos
 hYs=
X-Received: by 2002:a05:6214:c2f:b0:6f4:cbcf:5d46 with SMTP id
 6a1803df08f44-6f4fced5afbmr17883436d6.20.1745965016697; 
 Tue, 29 Apr 2025 15:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWnmUPg0Vy42WlOX8JRAspZ7uWHfSq7yALI3lS4s/UeCUfHu5wtfgWnX1DVooiBKuHiFubA==
X-Received: by 2002:a05:6214:c2f:b0:6f4:cbcf:5d46 with SMTP id
 6a1803df08f44-6f4fced5afbmr17883166d6.20.1745965016426; 
 Tue, 29 Apr 2025 15:16:56 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe6d0de5sm773516d6.28.2025.04.29.15.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 15:16:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:16:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 2/4] scripts/vmstate-static-checker.py: Allow new name
 for ghes_addr_le field
Message-ID: <aBFP1AqJocemibBc@x1.local>
References: <20250429152141.294380-1-thuth@redhat.com>
 <20250429152141.294380-3-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429152141.294380-3-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 05:21:39PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> ghes_addr_le has been renamed to hw_error_le in commit 652f6d86cbb
> ("acpi/ghes: better name the offset of the hardware error firmware").
> Adjust the checker script to allow that changed field name.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  scripts/vmstate-static-checker.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
> index 9c0e6b81f21..25aca839a03 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -42,6 +42,7 @@ def check_fields_match(name, s_field, d_field):
>      # Some fields changed names between qemu versions.  This list
>      # is used to allow such changes in each section / description.
>      changed_names = {
> +        'acpi-ghes': ['ghes_addr_le', 'hw_error_le'],
>          'apic': ['timer', 'timer_expiry'],
>          'e1000': ['dev', 'parent_obj'],
>          'ehci': ['dev', 'pcidev'],
> -- 
> 2.49.0
> 

-- 
Peter Xu


