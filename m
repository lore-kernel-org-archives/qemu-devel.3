Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DFFC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 19:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEvIh-0001ly-DJ; Tue, 13 May 2025 15:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEv4W-0006GB-9Z
 for qemu-devel@nongnu.org; Tue, 13 May 2025 15:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uEv4U-0004nM-8d
 for qemu-devel@nongnu.org; Tue, 13 May 2025 15:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747163624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wsbvUCYjcoe8W4spK/AnjRJPXz0/5crbq4dT0MZ7EqQ=;
 b=hF2uwwqq8MjhrdI6ZA+slPMRnmvFmI5HGUpFRJqTVBhHxNriSP9MlRs2cjJfjcmRN+m/jp
 ys6c5W1E+oxED097MOx7RpjnkXBsNG1QhQjGZ0kUKO2GLypCv2FAf2tnVUBbNSI3IG4h3/
 QKbAKWW0ERAdZlNmyGua5hWBtDIFZ6c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-iFK4_xYPOnCy47B7eImqcQ-1; Tue, 13 May 2025 15:13:42 -0400
X-MC-Unique: iFK4_xYPOnCy47B7eImqcQ-1
X-Mimecast-MFC-AGG-ID: iFK4_xYPOnCy47B7eImqcQ_1747163618
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c955be751aso1079080585a.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 12:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747163618; x=1747768418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsbvUCYjcoe8W4spK/AnjRJPXz0/5crbq4dT0MZ7EqQ=;
 b=hnKZdhapF8B8XdiMVZXGG+vOWniBwF70uhD5XMsEtzx796Pqzoc2bGkQguzD/bo8tt
 ixTWrEzM0zyWWyaKRjFgtXBatNadgx3FvGy89mB1BYr/xf/W5PlS8vK6GSvplIcqA6Kq
 a1/5Wkn2gNXDYsndoJxFXHQsh5/hQ45nsKpQ0x6Qkz/DSfN9494fS90nTN9voNoH/q6w
 J2AoEHwcKgvbHkAdN7pguCwfgNXnoNor2kX0OtQzNF3r48+SN6vl9achn/TEkovUzUDd
 WUgsW0gkRZPvT7FccMhdhdejLHNv66FtXO1Wuq2sdeMB/VztbUqWsBClM1X2VyN8JvSw
 TTcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR+Ltr8c+pR5MgaY6++yVGOqYTeX0LuvL6x8/Jwf6qsISaD/YH3uN0bNUVzeO2WULbnmWHs3/Ql8Zn@nongnu.org
X-Gm-Message-State: AOJu0YwtNmTGzbYsGBreJhb46YBsatchLkXM9DHUDiT8TLz8aXmTQaiF
 xUtAigosxitmVtiLGtOAKni3g/KMC201xpegBD4vNjqyjMFLKuoOGi94oPumUP02YxX/XftwFt6
 zZzjAZ7bKj3uIOvnu0zaKkuOVSdIR4TcOM4MIGgheTqg0V+uIbm4W
X-Gm-Gg: ASbGncuG2jg9X9ckAWqZjRVXqeYWJSuyBrrg9EWYM+9g7Av8qEQ8lNasCebIi5DmEk8
 mn1aucAtill47p380wg5Kwd/gGLqpIOVCiy8A1JVGjFRkz3sPmE8+OdwLRp8foxpLXn4ZtwE23d
 MCKy3E+RsUR+K68kDxeL5FtfSifKXHeqa5QV+aj1Wq7kyI/Zh7I0Wfzm/vn9cYsT2TUEpxXkHcK
 Zlptlv41gjuJ8dbdwEAbv6l0re9qzhKW68UDDPZxiwCM7ar94/+yNvlcYnA/xYzQ4kOuB5smOOr
 o5U=
X-Received: by 2002:a05:620a:1a03:b0:7ca:c584:7beb with SMTP id
 af79cd13be357-7cd287e10edmr86085985a.16.1747163617967; 
 Tue, 13 May 2025 12:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfeuacXNNmrIJMK9DBecUpq9KwnaGntUy6WGDNKtHMJN6d7LjsCZKQTNaeee+9cUSHz0i6hA==
X-Received: by 2002:a05:620a:1a03:b0:7ca:c584:7beb with SMTP id
 af79cd13be357-7cd287e10edmr86082585a.16.1747163617634; 
 Tue, 13 May 2025 12:13:37 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd00f6423esm739544785a.30.2025.05.13.12.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 12:13:36 -0700 (PDT)
Date: Tue, 13 May 2025 15:13:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 07/10] migration: Replace QemuSemaphore with QemuEvent
Message-ID: <aCOZ3SMr56NufUF0@x1.local>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-7-f7f69247d303@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250511-event-v3-7-f7f69247d303@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On Sun, May 11, 2025 at 03:08:24PM +0900, Akihiko Odaki wrote:
> rp_pong_acks tells if it has ever received one pong. QemuEvent is
> better suited for this usage because it represents a boolean rather
> than integer and will not decrement with the wait operation.
> 
> pause_event can utilize qemu_event_reset() to discard events.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  migration/migration.h |  6 +++---
>  migration/migration.c | 29 +++++++++++++----------------
>  2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index d53f7cad84d8..11dba5f4da77 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -342,11 +342,11 @@ struct MigrationState {
>           */
>          QemuSemaphore rp_sem;
>          /*
> -         * We post to this when we got one PONG from dest. So far it's an
> +         * We set this when we got one PONG from dest. So far it's an
>           * easy way to know the main channel has successfully established
>           * on dest QEMU.
>           */
> -        QemuSemaphore rp_pong_acks;
> +        QemuEvent rp_pong_acks;

If to do the switch then it needs a rename too because "acks" imply a
non-boolean.

For this one, when introduced it was indeed kept in mind that it might at
some point be useful to count for more than one.

For the other one, it is definitely an improvement to use QemuEvent
especially on the tricky reset..

How about keeping rp_pong_acks as-is, and keep the patch for replacing
pause_sem?

Thanks,

-- 
Peter Xu


