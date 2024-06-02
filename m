Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A24C25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 13:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDl6E-0004wF-8B; Sun, 02 Jun 2024 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDl6D-0004vw-EU
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDl6B-0002Dj-AM
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 09:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717334289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Osbdw5Mb6J3O8yuX1fbN/4N6ifMRmtJJGTXYdeIpE0=;
 b=izchJ0sayg4X+wmsgojWUgZGFSsDcC15UNnEDalAkCU7z0PeD3NLsqvRLYT8sgCLExso8V
 hQ+ZWdsXwn7LQaz237VS0iWykf16pvqxYSudG08/R/cgWCR+tsS446iLz5zxdHUY5vU40w
 qfUWeRSEdjJFkQ6ygioLS359H62w/ak=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-oIGo9217MdGfzasnKaqsWQ-1; Sun, 02 Jun 2024 09:18:07 -0400
X-MC-Unique: oIGo9217MdGfzasnKaqsWQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b82d434c6so2015774e87.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 06:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717334286; x=1717939086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Osbdw5Mb6J3O8yuX1fbN/4N6ifMRmtJJGTXYdeIpE0=;
 b=g02+EiDWXx84CJbrUwWB2YnxqDPNmlL7CNY1F00z+EEIa0m9RBxiU/+psFR+B12CHj
 jT38IL0WEZDv97omcl26/Xg+UioJ66YUd5tIZC7heR2t4jJT4gGzM6gcTiNZGNwwH9do
 jE95vkvDj7uxk0BK9T53OYNfBFfRrKixoC3ZQDDi6pZq/XdLWYRXG3WDIVUUa0V08dtl
 l+pLRyIyQ+iCn3xv53nbxbEj5f/HYaobJ5HLtDUh2jHpzLeT8tcLvBAARNzqV7MOp8k+
 uvGlUo58BZ2XEXsmN1AAv1AZ2jvRv1M14NRYIjFZDQ0bJ5YxTF7NQKdAjOWtjzg8AQdN
 dM8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8YpiUJSaZlCf4H5gIjwcu0XHD7v9Ic7Sap7eOqTXyz/SN7Oy7t8wXQKhbjBpkwjnQGgTs3UPD4N9ex0kWSYHOupOM8YM=
X-Gm-Message-State: AOJu0Yy2X4lPeYU8GNWNcb9XdB3FIDMGyS7f25HTXGNzORxPH09j/bS4
 15Ykzf0uegtmirKJe1k3mNkDdsXBtf9Q2Fsj2zFzWAD2lNakhzO2kbS12JMiQdiLjfxUtP4FC9a
 j7Kgi6fNW170deiR1Ha9FdQmcQp69ct7ABzrkoGJ87eiEPdaGYVDz
X-Received: by 2002:ac2:5dc9:0:b0:52b:7c41:698 with SMTP id
 2adb3069b0e04-52b89573bd4mr4624655e87.18.1717334285768; 
 Sun, 02 Jun 2024 06:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYnpMG94nldzVwrdMRk6FS1bXYhOk46IiZFidNMwdwGR2OgGmkcI5iwA4/jxtd09qS16UjmQ==
X-Received: by 2002:ac2:5dc9:0:b0:52b:7c41:698 with SMTP id
 2adb3069b0e04-52b89573bd4mr4624639e87.18.1717334285134; 
 Sun, 02 Jun 2024 06:18:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213411b25dsm59547425e9.40.2024.06.02.06.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 06:18:04 -0700 (PDT)
Date: Sun, 2 Jun 2024 09:18:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>
Cc: pbonzini@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user-test: no set non-blocking for cal fd less
 than 0.
Message-ID: <20240602091427-mutt-send-email-mst@kernel.org>
References: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Apr 11, 2024 at 03:35:55PM +0800, Yuxue Liu yuxue.liu@jaguarmicro.com wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> In the scenario where vhost-user sets eventfd to -1,
> qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
> receives, it does not perform blocking operations on the descriptor
> with fd=-1, so non-blocking operations should not be performed here
> either.This is a normal use case. Calling g_unix_set_fd_nonblocking
> at this point will cause the test to interrupt.
> 
> When vhost_user_write sets the call fd to -1, it sets the number of
> fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
> be 0.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>  tests/qtest/vhost-user-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index d4e437265f..7c8ef6268d 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>      case VHOST_USER_SET_VRING_KICK:
>      case VHOST_USER_SET_VRING_CALL:
>          /* consume the fd */
> -        qemu_chr_fe_get_msgfds(chr, &fd, 1);
> +        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
> +            qos_printf("call fd :%d, no set non-blocking\n", fd);
> +            break;
> +        }

I don't get how this is supposed to help. Did you test this?

>          /*
>           * This is a non-blocking eventfd.
>           * The receive function forces it to be blocking,
> -- 
> 2.43.0


