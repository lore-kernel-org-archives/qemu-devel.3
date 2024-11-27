Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F72D6ACDD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGJ4z-0000am-Kp; Wed, 27 Nov 2024 09:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tGJ4x-0000aP-P1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 09:31:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tGJ4w-0003p5-9K
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 09:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732717896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+FzrJweF4/ZYmvibDdtt3f7noBLIlQSqxzZRpbw10k=;
 b=P5ZHY8Z0NCSo0bx9S+J0LpwuYOTCgnf0ql/DDvgMyXAYnO8yhkDWp3Gd51MXqq8DOGfYWr
 QN7z//5K6s+n63zVxfSnaO2wzFSArPjehH9OnrinRGw5HpdgHtBomQ0ELsJzdVgXOpfz4A
 /WSIQ67KzW8R8zCNI5/aYTreSBVqCqQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-xw6IPWJ2OESyPmZpdB_2CA-1; Wed, 27 Nov 2024 09:31:34 -0500
X-MC-Unique: xw6IPWJ2OESyPmZpdB_2CA-1
X-Mimecast-MFC-AGG-ID: xw6IPWJ2OESyPmZpdB_2CA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d41f4c5866so88803446d6.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 06:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732717894; x=1733322694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+FzrJweF4/ZYmvibDdtt3f7noBLIlQSqxzZRpbw10k=;
 b=C8sgfVOL9fiY+Hv0yW1eD2JqcSF7bPgaKtEsNjaWlnswWBAbc3ERy86G3aep9WlH5J
 71CVQhEzP6tnuUP6vx6P8vz/JY+hRo0psEh1o7Rd+gGc6RJ6cTdYUZ7YRj00M65qcNN2
 fXbdO/UB3hmDxd/IH/4LkwpZ5u3QvIwTPi+icY3OjuI4v186l5wCyxdEjbQ0aZ7Ho5Ej
 ii8RxdIiUI3BtxnFQDInOl3h8v5aF3IQPZ/JThIwIHidkzQtwt3SemEpCKzJdyTuaM/P
 whdBnlPKEl9KAvQnmS2CoTnghqLfc+AThu0E0BYuDQkNwE3N0e1ivWE8A7V0N1vMGYNx
 SPOw==
X-Gm-Message-State: AOJu0YwLz1enuuOnlGhgNApl5h8+ob8eIi/BhYVM0RL5b9yp2GHhmndP
 l8w4zxIj23N6kVsgaYJreCLsL070kXTsfRepXYAolHykxrt7GZmiKOWbR+wSUm1N8UvvQHpD/8T
 UjRw36FoLXKTxWZwHvtUBGoZRJIfbqdsXtUfRVYq7Jd6lH4vcu957
X-Gm-Gg: ASbGncv59qpfFfVo2UYthXUOTd1a9ciuvKSnKct6tGmN4AHH1sxMgUH7ZyA0cWVIBrt
 aYL3OXyS1FzZMdQsrYb+GN/JqiYiTDvWXLJGlwRiTMAaI9z4VuiQoDWngD/3sR8jxzP5hXN/t3n
 cb18UiGmY10lmjC4T6pS/HREvETb1jvIk2HqIvjZ7PXfDSpn6pmB4itGvbDP/a5JoLGKOWYaPX1
 BUT2LkNs1b28spaVSvjiKMoRy6JlqhJ83X67E8Dbq0k/epiriZorAHOy28uVLQwwp2I6rdgD4Go
 OQTgeWCjP28=
X-Received: by 2002:a05:6214:21a9:b0:6d1:8755:5cbe with SMTP id
 6a1803df08f44-6d864d0308cmr36658566d6.8.1732717894205; 
 Wed, 27 Nov 2024 06:31:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdSUr8s2mMKx19p9iDANUBskWdlnpc2sh9QamSWQWXZsRPDQWxBDjJCDCgprtuQ3g87Rjevg==
X-Received: by 2002:a05:6214:21a9:b0:6d1:8755:5cbe with SMTP id
 6a1803df08f44-6d864d0308cmr36658366d6.8.1732717893889; 
 Wed, 27 Nov 2024 06:31:33 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b61c88sm66618396d6.121.2024.11.27.06.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 06:31:33 -0800 (PST)
Date: Wed, 27 Nov 2024 09:31:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com, chen.zhang@intel.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: correct multifd receive thread name
Message-ID: <Z0ctQzDaImBmHrh5@x1n>
References: <20241127111528.167330-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127111528.167330-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, Nov 27, 2024 at 04:45:28PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Multifd receive threads run on the destination side.
> Correct the thread name marco to indicate the same.
> 
> Fixes: e620b1e4770b ("migration: Put thread names together with macros")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 0956e9274b..3857905c0e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -37,7 +37,7 @@
>  #define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
>  
>  #define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
> -#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
> +#define  MIGRATION_THREAD_DST_MULTIFD       "mig/dst/recv_%d"
>  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> -- 
> 2.47.0
> 

queued for 9.2, thanks.

-- 
Peter Xu


