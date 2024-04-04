Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729BCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 10:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsJxu-0007GT-P6; Thu, 04 Apr 2024 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rsJxq-0007Eu-Da
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rsJxn-0000yP-VS
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 06:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712225093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z263/9hSXsZRCkBqXvHRcW1KsKDTJJDM1gDP4mTwq14=;
 b=I9k3EvTtl8S+lG4WT/oLduoScN8jXTEIojti7tr5F76SGu4qj6anFxFLHY+VD3z8WV4cnL
 3qsTbeYV2SkW90tGf3V8yLl+XTglOi/IZ80kVLswchpwToZRlj5vCUpDF9D3ELFJAnm2PL
 N7w3NmorHLfLONjsLbmjxMAUumOWak8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-_5Qmx8RAPDSQl6t3aUXnRw-1; Thu, 04 Apr 2024 06:04:52 -0400
X-MC-Unique: _5Qmx8RAPDSQl6t3aUXnRw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-414ae9b8c04so5727635e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 03:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712225091; x=1712829891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z263/9hSXsZRCkBqXvHRcW1KsKDTJJDM1gDP4mTwq14=;
 b=WDdYDmeH53mUHJeTQphFnvUmXQEta4eqJD1yEzYd1GlrB28QNZ/GKpmSPIdNdMTmiq
 4QdIOmkfuB8fBZM9olX/D55ZEwcU+Wq+m8UCPBAOYXszqra8qtYLkRHULtYMJJIyvMXL
 ZV+m3aW3zYCK6y7UGMjYBeeqel7f5HT2Bqui8jYlrnHgxq3LH9NvtfxpqjwGgYLekYrc
 laYrSP1mfNp+O8q9V1zQ0rSTDidWTKoTSiDTjHnwE6C2iQpbY4m/v2VpA9m/fdz8ee/e
 td/nBecr11PkY37sYI0Xs7gXSi43c2ugtsKI0zyJF+K3QI5H7Uq8nUDyF3GIuHRqqYbW
 yvCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNz+vzZjdx7yzrbveEuD9WLVdoj+5DAuljnyMhIC//SDc3nlMlKFg1tBjucVvD1IykRYp4fWiO3GcDqYqBSnRMNOjjuk8=
X-Gm-Message-State: AOJu0Yzv6Vw6gw2elxwxBOV94UNLXFoqZlpGluLnxwZ4S9cf8KB1IyYG
 fqOGvEyvJ3+Q2lRO3yNJwp1Z74lDVVzLJwva+likLRWMfLUNuFc5IRABGPdKXtgG2mdDJPOFUir
 eN8vrqTFYoXIvSxyKeGGskhjFi+sEFK6XWbu2VoA2vi9KeoV7yqNNuJF9UfY9v6aQ2dRHEOQLG9
 o5iXLyXJH8IBdRwmKcRaVXwPwe1II=
X-Received: by 2002:a5d:6950:0:b0:343:6216:1c6 with SMTP id
 r16-20020a5d6950000000b00343621601c6mr1770096wrw.40.1712225091385; 
 Thu, 04 Apr 2024 03:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhBJwhcr9HnoTwJv+viaUrr/RVUWbVS4C4N2AiKvW2sla1E0WaTlGYAX2pX5jYIEhl7aGrKubZ0XFfECq49JM=
X-Received: by 2002:a5d:6950:0:b0:343:6216:1c6 with SMTP id
 r16-20020a5d6950000000b00343621601c6mr1770073wrw.40.1712225090980; Thu, 04
 Apr 2024 03:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Apr 2024 12:04:39 +0200
Message-ID: <CABgObfaXHZ-xFY+A6k7f+1evwGxcBTuw_su_WaCX5Tqfa8a48g@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] [for-9.0] esp: avoid explicit setting of DRQ
 within ESP state machine
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Mar 24, 2024 at 8:17=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Patches 1-4 update existing users of esp_fifo_pop_buf() and esp_fifo_pop(=
) with
> the internal cmdfifo to use the underlying Fifo8 device directly. The aim=
 is
> to ensure that all the esp_fifo_*() functions only operate on the ESP's h=
ardware
> FIFO.
>
> Patches 5-6 update esp_fifo_push() and esp_fifo_pop() to take ESPState di=
rectly
> as a parameter to prevent any usage that doesn't reference the ESP hardwa=
re
> FIFO.
>
> Patch 7 ensures that any usage of fifo8_push() for the ESP hardware FIFO =
is
> updated to use esp_fifo_push() instead.
>
> Patch 8 updates esp_fifo_pop_buf() to take ESPState directly as a paramet=
er
> to prevent any usage that doesn't reference the ESP hardware FIFO.
>
> Patch 9 introduces the esp_fifo_push_buf() function for pushing multiple =
bytes
> to the ESP hardware FIFO, and updates callers to use it accordingly.
>
> Patches 10-12 incorporate additional protection to prevent FIFO assert()s=
 and a
> cmdfifo buffer overflow discovered via fuzzing.
>
> Patch 13 is just code movement which avoids the use of a forward declarat=
ion whilst
> also making it easier to locate the mapping between ESP SCSI phases and t=
heir
> names.
>
> Patches 14 introduce a new esp_update_drq() function that implements the =
above
> DRQ logic which is called by both esp_fifo_{push,pop}_buf().
>
> Patch 15 updates esp_fifo_push() and esp_fifo_pop() to use the new esp_up=
date_drq()
> function. At this point all reads/writes to the ESP FIFO use the esp_fifo=
_*()
> functions and will set DRQ correctly.
>
> Patch 16 is a small update to the logic in esp_pdma_write() to ensure tha=
t
> esp_fifo_push() is always called for PDMA writes to the FIFO, thereby ens=
uring
> that esp_update_drq() remains correct even in the case of FIFO overflow.
>
> Finally patch 17 removes all manual calls to esp_raise_drq() and esp_lowe=
r_drq()
> since the DRQ signal is now updated correctly upon each FIFO read/write a=
ccess.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> v3:
> - Rebase onto master
> - Add patch 1 to move the internals of esp_fifo_pop_buf() to a new
>   esp_fifo8_pop_buf() function. This allows the FIFO wrap logic to still =
be
>   used for managing cmdfifo
> - Rework esp_cdb_length() into esp_cdb_ready() as suggested by Paolo in p=
atch
>   11
> - Update the logic in patch 12 to use the new esp_cdb_ready() function
>
> v2:
> - Rebase onto master
> - Add patches 9-12 to handle FIFO assert()s and cmdfifo overflow as repor=
ted by
>   Chuhong Yuan <hslester96@gmail.com>
>
>
> Mark Cave-Ayland (17):
>   esp.c: move esp_fifo_pop_buf() internals to new esp_fifo8_pop_buf()
>     function
>   esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>     do_command_phase()
>   esp.c: replace esp_fifo_pop_buf() with esp_fifo8_pop_buf() in
>     do_message_phase()
>   esp.c: replace cmdfifo use of esp_fifo_pop() in do_message_phase()
>   esp.c: change esp_fifo_push() to take ESPState
>   esp.c: change esp_fifo_pop() to take ESPState
>   esp.c: use esp_fifo_push() instead of fifo8_push()
>   esp.c: change esp_fifo_pop_buf() to take ESPState
>   esp.c: introduce esp_fifo_push_buf() function for pushing to the FIFO
>   esp.c: don't assert() if FIFO empty when executing non-DMA SELATNS
>   esp.c: rework esp_cdb_length() into esp_cdb_ready()
>   esp.c: prevent cmdfifo overflow in esp_cdb_ready()
>   esp.c: move esp_set_phase() and esp_get_phase() towards the beginning
>     of the file
>   esp.c: introduce esp_update_drq() and update esp_fifo_{push,pop}_buf()
>     to use it
>   esp.c: update esp_fifo_{push,pop}() to call esp_update_drq()
>   esp.c: ensure esp_pdma_write() always calls esp_fifo_push()
>   esp.c: remove explicit setting of DRQ within ESP state machine
>
>  hw/scsi/esp.c | 223 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 142 insertions(+), 81 deletions(-)
>
> --
> 2.39.2
>


