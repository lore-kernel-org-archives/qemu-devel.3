Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD47D47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggwm-0005ZT-6G; Fri, 16 Jan 2026 05:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vggwk-0005Z6-2h
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vggwh-0004oS-MT
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768558846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xzOgohv7yBKn77oDEMKGcZu4sw47w1zDBXcdbHXO4s=;
 b=FmYbxHS1koNv/mSFm19pAkeh0qveLXpcyRqVyH7PK5/e5p8iFf9pqKyHVFEgpmFAiSYETA
 54SnrD3o8owkHaSkyi6zU2um9Fvng/OUlSMQlPUjm3n1hjNUVMP6LkkxQWZBAINO8MhAdS
 SjRFvVVs0KSqgF2B5dWIVST0ewJXoKQ=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-fnWoSXyQOXWeQf3rgW73yQ-1; Fri, 16 Jan 2026 05:20:45 -0500
X-MC-Unique: fnWoSXyQOXWeQf3rgW73yQ-1
X-Mimecast-MFC-AGG-ID: fnWoSXyQOXWeQf3rgW73yQ_1768558844
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6446c91addfso3119254d50.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768558844; x=1769163644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xzOgohv7yBKn77oDEMKGcZu4sw47w1zDBXcdbHXO4s=;
 b=Ci7AMJgEKUeJA/fw5TSChVNksPGNY9cuiRlgb21ccApm+Mju0IFzuUZPMsexfuw7VB
 4SVJl3yNLA/jlfWuB08hoDbca3xM2Rc82NNaKTHW06Ow4DHu6cyjrvjwriPAEidqKkjz
 Ba2b1MtUsYzf86mPRzHnesbwwcwsiC5BXiRvGWUzYHtL7D8Y63X4hNNWqu8cdPb47VDD
 f2d2ytkdDN6BcRqxZy6/YGzdn/AubkbyFvc2di50DWs2o+A1tZ2wK3JpJ22o/wLoLxCn
 Z/vZ/CZ4Xlu3I6JKVnMtzmvQ0jvfQLwMYlYCNivYwpJJXWtav554Rp/DmE4klQBsV4qk
 W1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558844; x=1769163644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xzOgohv7yBKn77oDEMKGcZu4sw47w1zDBXcdbHXO4s=;
 b=n6P02rzx5zjBludBdoYECZbaYZZHbCUICsVzcheLwYTP2x6HwMUUfHUifpFDL69RYE
 LOhrbus5bXsdRGd9hLWaAWdNlKxI8LwTuYinEiOnIvLpKAxOGizfUJdIhkHR9hykyayq
 8RvJTceUVavF5rl6edkaG9K28atQI23V2SYcl22rlG6NQN3vecqE/3QyNiq4RmNECqFy
 xkc6q8p/omzmi/mvHRcpUeE9EeCvHUaQPIjNu8edTu3VrNcVAQ/s+kg0dRCAulk2tPnS
 /zYaIuht923IWHSv6SDbQ9QTu3Xg7rMTgDOk1e5BJ+E46DTdfl7pi1NZneWVCF1inkGa
 E/PA==
X-Gm-Message-State: AOJu0YxImkALyqiV+vR3YvCzUPebBjt9V0Dha8zGdGkrsNcJh8oKMrhe
 UYvkQxmnR1kWVefVZcEXqqFClBXsD/vk1qerUMXjz5trXNZ+AnAUYnWccvOvzzQFdW3l3q+tWwn
 2K+epSh6K3CZDwrwdiGeg4N5RLaC5UjkaOTghx1qpf9Ne/6qRYK/uB5mkI0ERBs2J3kn4IlBmav
 GJuzNzsWPDsricXcpAh3v1bDTcETrPe1KlBruXAnA=
X-Gm-Gg: AY/fxX5b8aa1LQSm90Q8WY7yWcw6zPjIfxtZj2myptVa0YOShrAH8r3AVCJ6Xxnjjse
 KfUAuepBroBiY4v6NQQVKCjVUKOveXlThQBAWIFGoQi1/B9A9j2hDZ8blzYl6XQyg3EExapNpTZ
 GEhG+5ROjPDe+lS+WsAy7F77bFU+5Wh9r0uDK5feBc3U5c8uevexSZEZ+RiT3BiA==
X-Received: by 2002:a05:690e:d59:b0:643:ab7e:8dd0 with SMTP id
 956f58d0204a3-6491775094fmr1704498d50.61.1768558844265; 
 Fri, 16 Jan 2026 02:20:44 -0800 (PST)
X-Received: by 2002:a05:690e:d59:b0:643:ab7e:8dd0 with SMTP id
 956f58d0204a3-6491775094fmr1704479d50.61.1768558843942; Fri, 16 Jan 2026
 02:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20251111091058.879669-1-aesteve@redhat.com>
 <20251111091058.879669-6-aesteve@redhat.com>
In-Reply-To: <20251111091058.879669-6-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 16 Jan 2026 11:20:25 +0100
X-Gm-Features: AZwV_QhH2vWtalzgHTYeFRTLWAQ07Yy9iVdhnwDM0droQF-iLirn9XI0wObMWTQ
Message-ID: <CADSE00+24EjXdRMDXXf7tgWLaH2gqeDhL_OeRbmZQ2e8JULPXA@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] vhost_user.rst: Add GET_SHMEM_CONFIG message
To: qemu-devel@nongnu.org
Cc: dbassey@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 manos.pitsidianakis@linaro.org, 
 slp@redhat.com, stefanha@redhat.com, Fabiano Rosas <farosas@suse.de>,
 jasowang@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com, hi@alyssa.is,
 stevensd@chromium.org, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Nov 11, 2025 at 10:11=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:
>
> Add GET_SHMEM_CONFIG vhost-user frontend
> message to the spec documentation.
>
> Reviewed-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 6c1d66d7d3..6a1ecd7f48 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -371,6 +371,20 @@ MMAP request
>    - 0: Pages are mapped read-only
>    - 1: Pages are mapped read-write
>
> +VIRTIO Shared Memory Region configuration
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-------------+---------+------------+----+--------------+
> +| num regions | padding | mem size 0 | .. | mem size 255 |
> ++-------------+---------+------------+----+--------------+
> +
> +:num regions: a 32-bit number of regions
> +
> +:padding: 32-bit
> +
> +:mem size: contains ``num regions`` 64-bit fields representing the size =
of each
> +           VIRTIO Shared Memory Region
> +

When implementing this for rust-vmm, the mem size came up a bit
confusing. In the last patch (7/7) of this series, the implementation
uses `num regions` as a count for the number of valid regions (thus
accounting for gaps in the shmem region mapping). Thus, `mem size` has
this confusing statement saying that it containers `num regions`
fields. It should say it contains 256 fields (it is only sent once
during initialization, so no need to save bytes here), with only `num
regions` that are valid (i.e., greater than 0). Maybe it could even
discard the `num regions` field, and send only the full array.
Thoughts?

As much as I wanted this series merged, this deserves a clarification.
So I can either send a new version of the series or split the last
three patches into a different series. Hopefully it only requires one
more version though.


>  C structure
>  -----------
>
> @@ -397,6 +411,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
>            VhostUserMMap mmap;
> +          VhostUserShMemConfig shmem;
>        };
>    } QEMU_PACKED VhostUserMsg;
>
> @@ -1761,6 +1776,30 @@ Front-end message types
>    Using this function requires prior negotiation of the
>    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
>
> +``VHOST_USER_GET_SHMEM_CONFIG``
> +  :id: 44
> +  :equivalent ioctl: N/A
> +  :request payload: N/A
> +  :reply payload: ``struct VhostUserShMemConfig``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the front-en=
d
> +  to gather the VIRTIO Shared Memory Region configuration. The back-end =
will
> +  respond with the number of VIRTIO Shared Memory Regions it requires, a=
nd
> +  each shared memory region size in an array. The shared memory IDs are
> +  represented by the array index. The information returned shall comply
> +  with the following rules:
> +
> +  * The shared information will remain valid and unchanged for the entir=
e
> +    lifetime of the connection.
> +
> +  * The Shared Memory Region size must be a multiple of the page size
> +    supported by mmap(2).
> +
> +  * The size may be 0 if the region is unused. This can happen when the
> +    device does not support an optional feature but does support a featu=
re
> +    that uses a higher shmid.
> +
>  Back-end message types
>  ----------------------
>
> --
> 2.49.0
>


