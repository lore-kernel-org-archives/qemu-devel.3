Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D938FD2ED12
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9dw-0007ay-5S; Tue, 20 Jan 2026 06:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9dq-0007YH-Vx
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vi9do-0004V3-R9
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768907480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TxS1R7yv0cCAnM2W2jf0MASw9kSOSzlNKXyFYinRKFI=;
 b=XVIH0S3CU+r+8DvA5U8jk0khF6M5J7/95x6jzAglSNzqQ/BD4lKjSHUlgl01+K5BLuizBe
 Rhd5ERd0pp5okhaVjV3VehLaY7myrYbOTKlcT76Kf5mL94sApLvAq8TvJcnyMMvmmI1w3i
 Y9/N78afM1TKNuQcUpqEd3Lo5MJTtPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-erNxWxDIM5yLc8778TikYw-1; Tue, 20 Jan 2026 06:11:18 -0500
X-MC-Unique: erNxWxDIM5yLc8778TikYw-1
X-Mimecast-MFC-AGG-ID: erNxWxDIM5yLc8778TikYw_1768907477
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso49301995e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907477; cv=none;
 d=google.com; s=arc-20240605;
 b=QHOovfv85AiF3gwbvCCKqUecpjgXnHLHnhOagtumTgYp3oxBQ584Cji/i+MaXF60Jd
 4cQXPhXJ8Ma2EjD9XI/favAxGLAtudj9628dXY0VqQyj5USSqyKdQuAQxOb8fBHEKw5D
 jju/e8RC7rnpy1AMMhHAq0GbHtGHkVDoLcDciWy4pjQnU5xhsoIYedwobLy0DxB2qH/D
 MCHaaIhBAW16BFh/zfrW6J/nbSrQzf8ekKwcGSB2EwBEbdBL+vhaHj7TePckm9kSN/9R
 qCy/By56whZSgD3viOYHUM21puCZJmMmYwnQLXsLjrqYTUAf0bYBOQTlA0vCDD62frpz
 YAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TxS1R7yv0cCAnM2W2jf0MASw9kSOSzlNKXyFYinRKFI=;
 fh=SJ3HPovJyRUvRbjEYgfW8f8/HsJC2a+l/HOVRBs3/Wg=;
 b=ZiyPYuEX3kYw+ygheOZitZmqiyEBtyVjEc3M/IT3S/yP1ad3rru9hi6HVvWto9kfHV
 sem7XxroVDALPok4HJBtfmz1FW0yts0O0OaKishywzVvcMzGm0NMxPJlAOyS+e+amJu0
 JxjZmE1cgDpP3HQm83FHAzDGKzrMB7CKr+ygVawYNEbU5B6RIJGI91+otokHHsDrpMqX
 35WqzRtRbKUmJvOZdxECuhIOjIYuTWPki7zcap9SZg69EXz/r7hEKZaLNRHIxSyizNl7
 roJt5Z6CcRPTGVnMUu+qry0ApgyjqgQ0Z1SKbsg4w8SZkgnoZ2GtyOYgRJ/jN5ccYPrZ
 D2KQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768907477; x=1769512277; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TxS1R7yv0cCAnM2W2jf0MASw9kSOSzlNKXyFYinRKFI=;
 b=Vfqfi4fieIOFZ/OCmp0eGkRYU4t0o4rvfZfEECKWUqTrEJLxsXfM8t5b8gOvJLw95i
 Q+UR54FgW/FDkA/7JXizHOeGAHPCxADA5FhhkeSWh43nYAg+cyOZFZaDEhQ2/97oWBy2
 jDoz0mloQkFhBMYJawgAQyHAPD1bJKm9ZLELEJMg1a1snAs/PmoPI9xziHE1+FtO6aId
 F0w2GR9Fhy9VgAq4UAT4UyX/tXWZj5lrVVe0+bJ3ClbaN3GPU8zhJy5lOpw6ZbFTpMwV
 ZGlmg0aM7tILr/zeW+49A3q9i0It2FwYbOdbXL1Pwzwo3XZ3KW6E6cqmn1JLMfQCoBi9
 SqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768907477; x=1769512277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxS1R7yv0cCAnM2W2jf0MASw9kSOSzlNKXyFYinRKFI=;
 b=cFfyE14Gjc9lDqbsc8E/nUySFZqMTPfum0NDsYdV4iAAWEoXdtv7yj0JCiipNmFuDC
 hUFTlZbtuVOp133xaYRshsC4ozlou8OaDf8gDLB7X1AdnYQGPVXnijykncwMVR0lKZlg
 WWdfxzBBXxKB7rznbHErgZS1/H34hdZMSvB+tzi7yNYvOp36+Dtm8w5xW8ll+43YPAkj
 TEbbnY8Xq5k6JMZgq048u3nbywyuL/OQqDL0KVKsR3f41ATB3KGEZx1OsYj+B7/UhVBb
 rf6zu6bHneI7L9cfTjlk1vZW5ZrTTItxQ82ooorgVTRzAubOMgUBEmDo3U2eLUd/7BAe
 mgww==
X-Gm-Message-State: AOJu0YxUoVTaOSfJfhkPt/QtPWUIOz4IBUBBKzBKBy8UQRz9jxAbhhUO
 JC2aeFsKrEqWUJvVJinlz4kLzGOaAk4+kUmJrFLAfm07gy5CpMyHa3/Mkdsm9DhTspDJjs+5La+
 xJC++X3EeAT7d4vPtJ0DRR8W+qOMoYgYfSTgDvGdDsOBlg8AzRpmk04w/F9h5I7/W+E6GWghKWa
 PgeE1ErmN3XJzNZH0b6vvg73U008VgN/Ea5cToos79kg==
X-Gm-Gg: AY/fxX67hQRpe2N2Z4OTiM82iCBgaMsE3o4X25sjZxam0+aIVa2k0ZtZAw6m9v7N0tR
 UnPyveEY30WGN+oUr8gGHe26Tq4Z+AhwC1xN+QboBZ7NejkBeX1SWSGrFu0IlDI72xCSykGLVQS
 NdYphmFrzJq7fdROTeVDM0WXqCUH0zHDufQtM1jxV1tSsxoCsj5OpDqmwzTz5e4YOyKQWMjjDOG
 pcxVY2AKiPkZ3Kozh06SHVG7TFxikdAtMl1wXWWkZQUeJsUBRgOHryX
X-Received: by 2002:a05:600c:458c:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4801e3342bamr138372425e9.23.1768907476657; 
 Tue, 20 Jan 2026 03:11:16 -0800 (PST)
X-Received: by 2002:a05:600c:458c:b0:47d:6856:9bd9 with SMTP id
 5b1f17b1804b1-4801e3342bamr138372005e9.23.1768907476170; Tue, 20 Jan 2026
 03:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-17-farosas@suse.de>
In-Reply-To: <20260109124043.25019-17-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 20 Jan 2026 16:40:57 +0530
X-Gm-Features: AZwV_QhOBoh_qnDbn55X14gMInmpVjTdSR857keGZZqIsi65MBLpVnIjukjZIAs
Message-ID: <CAE8KmOzCMq7rcQyoS8TX6aXXPqn17H6mLwSCjWeHG=H3Mw=3vQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] migration/channel: Rename
 migration_channel_connect
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 9 Jan 2026 at 18:18, Fabiano Rosas <farosas@suse.de> wrote:
> Rename migration_channel_connect to indicate this is the source
> side. Future patches will do similar changes to the incoming side and
> this will avoid inconsistencies in naming.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c | 9 +--------
>  migration/channel.h | 2 +-
>  migration/exec.c    | 2 +-
>  migration/fd.c      | 2 +-
>  migration/file.c    | 2 +-
>  migration/socket.c  | 2 +-
>  migration/tls.c     | 2 +-
>  7 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index b8d757c17b..f41333adcc 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -61,14 +61,7 @@ out:
>      }
>  }
>
> -
> -/**
> - * @migration_channel_connect - Create new outgoing migration channel
> - *
> - * @s: Current migration state
> - * @ioc: Channel to which we are connecting
> - */
> -void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
> +void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>  {
>      trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>
> diff --git a/migration/channel.h b/migration/channel.h
> index b361e1c838..574bfec65c 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -28,7 +28,7 @@ typedef enum {
>
>  void migration_channel_process_incoming(QIOChannel *ioc);
>
> -void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
> +void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc);
>
>  int migration_channel_read_peek(QIOChannel *ioc,
>                                  const char *buf,
> diff --git a/migration/exec.c b/migration/exec.c
> index d83a07435a..d1629944dc 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>      }
>
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>
> diff --git a/migration/fd.c b/migration/fd.c
> index 0144a70742..150b236fbf 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>
> diff --git a/migration/file.c b/migration/file.c
> index 7bb9c1c79f..935402f36b 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>          return;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>  }
>
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/socket.c b/migration/socket.c
> index 298bac30cc..611915f84d 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -73,7 +73,7 @@ static void socket_outgoing_migration(QIOTask *task,
>      }
>
>      trace_migration_socket_outgoing_connected();
> -    migration_channel_connect(data->s, sioc);
> +    migration_channel_connect_outgoing(data->s, sioc);
>      return;
>  err:
>      trace_migration_socket_outgoing_error(error_get_pretty(err));
> diff --git a/migration/tls.c b/migration/tls.c
> index 837b08294f..89ba52de02 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -114,7 +114,7 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      }
>
>      trace_migration_tls_outgoing_handshake_complete();
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>  }
>
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> --

* Looks right.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


