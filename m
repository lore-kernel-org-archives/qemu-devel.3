Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8205BC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0Nh-00050l-SX; Wed, 29 Jul 2026 05:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0NV-0004tA-S1
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp0NS-00058V-BK
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785316501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYr0+FiHmRj8yNdI0i2RKV5Ne11x9RSo4XasXZfEr/s=;
 b=QgvUbnbRbVM2ENHbtAVav+zQLxxdczBy+5VhZfELyDaciRD58N5jvxOpn3Hs9Z/x8ikrj9
 NahqLVoANb2X0nND9UmqPmV0H8DZV+qlSBxvvNsIME8IppA4jLuMEOe+cTWAvJzyHl2KV+
 LptH199gnPc/uzEfpnsI7k1tP363lL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-VfkjduedOFOkU9Ka3gbADQ-1; Wed, 29 Jul 2026 05:15:00 -0400
X-MC-Unique: VfkjduedOFOkU9Ka3gbADQ-1
X-Mimecast-MFC-AGG-ID: VfkjduedOFOkU9Ka3gbADQ_1785316499
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4956c1655c3so3789575e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785316499; x=1785921299; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYr0+FiHmRj8yNdI0i2RKV5Ne11x9RSo4XasXZfEr/s=;
 b=bBpHhhnmtI3PRaAvoMw8Wu7CNP8pB1iIHuT00iU6UTnhzjM166XPwmbga2IxSUBRYk
 8ZfzXpV1KgcyvEqCt/4tQMfiNBjuQouc3FiyqMwaLQQnue5R9aWrtQyLFHZfDA1CeIzB
 yxu61GuM3+INv2HqyVnFOQE8sqQe47rFqCEXfuybpOeSBb/cgDh/vURpobIQuZv7hFbm
 wNSILV7GnZ7EZDnEBLYQcrrfaCJ+hOR/tITxJ+Cteg8O7o2Bpx9Df3TviHr6NvU9hiZH
 9VAjRquua9U9lifpnY9QKkotPiLQX+8dOZ81gszBgNykndnPGaE9rsiK/FuzeiLf8jhT
 FUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785316499; x=1785921299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rYr0+FiHmRj8yNdI0i2RKV5Ne11x9RSo4XasXZfEr/s=;
 b=lzMmaUezxQdDAKTO5lN1Di7ix5TZWRCJIVX6vfMJWlsymvgMl67v4KEIu0UE5Bxmdi
 yDDvezxxHhTlGD+UAjdhk7Weuxdzeu0599LJ3+zRCXtStqyAMwe9ffuacf5QDH2vUSas
 z4SM1X5lOMz0k2SKg1pSvm/FR9m3qhjAPB9OjkwFpncGFql0JRnvJJeqhAS5goQPAmU2
 fW9TjmLZ4yn3stXHvZHNPmsbzRir9IqbrzNcDkaAxOUvUHNWI3iZ4iJ9fmTBASN1w7Hl
 FUp9IF5H0nWiNM0ckTjisYyL5Jk/SnYNldAyoDmxJTRbI3lq6ERpPRfJyM44dyt2glU4
 wkfQ==
X-Gm-Message-State: AOJu0YyKu8RmmeLMaQ0ONAh2jCdFGEO6b0jvk5pLy9zgB4cFSMhN6+Jw
 Hec/zpzB1Z7Ao2ZQ9mrQ59PnAkH88E4Vb5Gkjv/6bVm/hDenY3rAwnJ3MoMc11z6S0Wavdijtwg
 23G+pa04yrxAEUmRXgYoXkRhBa6IPBztYn97+24vmB4rVSIArByjKNaVu
X-Gm-Gg: AR+sD10yS9iXvpkJNT07by4npYGsgIg3YXt6bHOlhnkAC2espP4/pNfVMjZYP2NiuYw
 2CFiPM/R5X8YzDRvixRzXm8grV7V2jT1GwtSY2MRm+5YDoi62wDvtvoaAMpqfUr4ojASmLGIY35
 CCVxJcZeb/w4+GP1O6AMJNpAAfhJVjuK1TsSmdKODp5Qo1zOzpQnWCzr1hcOsLli3xGWa6L0SuJ
 EyG1d8iwlnfQH+dRA4MNnmO8u5TYGWrOuXInuteOF8XLXKUVAp8rHEsbaHrjiF73barKj3eZ2z8
 pWJ27MZYfSEcWbJnXHNTO4mFtzAt8KjrVU9GgQTErC04s+2SrQG0ld+mpVhR2pxzM+MyAKBGuHl
 Ob2pFtxERKmOWhcq7z5p+JGE=
X-Received: by 2002:a05:600c:8b78:b0:495:5d6d:9cb3 with SMTP id
 5b1f17b1804b1-496c65996aemr61940885e9.37.1785316498645; 
 Wed, 29 Jul 2026 02:14:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8b78:b0:495:5d6d:9cb3 with SMTP id
 5b1f17b1804b1-496c65996aemr61940375e9.37.1785316498118; 
 Wed, 29 Jul 2026 02:14:58 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef25sm6233060f8f.24.2026.07.29.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 02:14:57 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:14:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 virtio-fs@lists.linux.dev, Kevin Wolf <kwolf@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, Raphael Norwitz <rnorwitz@nvidia.com>
Subject: Re: [PATCH v5 2/6] vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
Message-ID: <20260729045541-mutt-send-email-mst@kernel.org>
References: <20260728100841.3475774-1-dtalexundeer@yandex-team.ru>
 <20260728100841.3475774-3-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728100841.3475774-3-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 28, 2026 at 03:08:37PM +0500, Alexandr Moshkov wrote:
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT was introduced to allow
> the back-end to suspend in-flight I/O during GET_VRING_BASE instead of
> draining it, enabling live migration of in-flight requests. However,
> this behaviour is tied to the protocol feature itself — once negotiated,

Can we please avoid em-dashes and all kind of unicode fanciness in
commit log? I worry if we do this the next step is emojis) Let's stick
to ASCII with the exception of UTF-8 in contributor names.

Thanks.

> there is no way for the front-end to tell the back-end to fall back to
> the normal drain behaviour on a per-stop basis. This makes it impossible
> to selectively use suspend semantics only during live migration while
> keeping drain semantics in other cases.


So what are the "other cases"?

> 
> Introduce a separate message VHOST_USER_GET_VRING_BASE_SKIP_DRAIN (id=45)
> guarded by a new protocol feature
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN. The message is identical
> to GET_VRING_BASE except that the back-end must immediately suspend all
> in-flight I/O and record it in the inflight region. This way the front-end
> has explicit per-call control: send GET_VRING_BASE for normal drain, send
> GET_VRING_BASE_SKIP_DRAIN when immediate suspend is needed.
> 
> The new feature requires both VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
> and VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD to be negotiated.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  docs/interop/vhost-user.rst       | 88 +++++++++++++++++++------------
>  hw/virtio/vhost-user.c            | 44 ++++++++++++++--
>  hw/virtio/vhost.c                 |  2 +-
>  include/hw/virtio/vhost-backend.h |  1 +
>  include/hw/virtio/vhost-user.h    |  1 +
>  5 files changed, 95 insertions(+), 41 deletions(-)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index c83ae2accb..d2e0efaeaa 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -445,6 +445,7 @@ replies, except for the following requests:
>  * ``VHOST_USER_GET_FEATURES``
>  * ``VHOST_USER_GET_PROTOCOL_FEATURES``
>  * ``VHOST_USER_GET_VRING_BASE``
> +* ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>  
> @@ -523,7 +524,7 @@ must start a ring upon receiving a kick (that is, detecting that file
>  descriptor is readable) on the descriptor specified by
>  ``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
>  ``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
> -``VHOST_USER_GET_VRING_BASE``.
> +``VHOST_USER_GET_VRING_BASE`` or ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``.
>  
>  Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
>  
> @@ -1101,29 +1102,30 @@ Protocol features
>  
>  .. code:: c
>  
> -  #define VHOST_USER_PROTOCOL_F_MQ                       0
> -  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                1
> -  #define VHOST_USER_PROTOCOL_F_RARP                     2
> -  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                3
> -  #define VHOST_USER_PROTOCOL_F_MTU                      4
> -  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ              5
> -  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN             6
> -  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION           7
> -  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                8
> -  #define VHOST_USER_PROTOCOL_F_CONFIG                   9
> -  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD         10
> -  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER           11
> -  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD          12
> -  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE            13
> -  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS    14
> -  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS     15
> -  #define VHOST_USER_PROTOCOL_F_STATUS                  16
> -  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                17
> -  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
> -  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
> -  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
> -  #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES           21
> -  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP               22
> +  #define VHOST_USER_PROTOCOL_F_MQ                         0
> +  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                  1
> +  #define VHOST_USER_PROTOCOL_F_RARP                       2
> +  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                  3
> +  #define VHOST_USER_PROTOCOL_F_MTU                        4
> +  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ                5
> +  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN               6
> +  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION             7
> +  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                  8
> +  #define VHOST_USER_PROTOCOL_F_CONFIG                     9
> +  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD           10
> +  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER             11
> +  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD            12
> +  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE              13
> +  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS      14
> +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS       15
> +  #define VHOST_USER_PROTOCOL_F_STATUS                    16
> +  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                  17
> +  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT             18
> +  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE              19
> +  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT   20
> +  #define VHOST_USER_PROTOCOL_F_GPA_ADDRESSES             21
> +  #define VHOST_USER_PROTOCOL_F_SHMEM_MAP                 22
> +  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN 23
>  
>  Front-end message types
>  -----------------------
> @@ -1320,17 +1322,11 @@ Front-end message types
>    set to 0.
>  
>    By default, the back-end must complete all inflight I/O requests for the
> -  specified vring before stopping it.
> -
> -  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
> -  feature has been negotiated, the back-end may suspend in-flight I/O
> -  requests and record them as described in :ref:`Inflight I/O tracking
> -  <inflight_io_tracking>` instead of completing them before stopping the vring.
> -  How to suspend an in-flight request depends on the implementation of the back-end
> -  but it typically can be done by aborting or cancelling the underlying I/O
> -  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
> -  protocol feature must only be negotiated if
> -  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
> +  specified vring before stopping it. If the
> +  ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN`` protocol feature has
> +  been negotiated, the front-end may instead use
> +  ``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN`` to request the back-end to
> +  suspend in-flight I/O immediately.
>  
>  ``VHOST_USER_SET_VRING_KICK``
>    :id: 12
> @@ -1833,6 +1829,28 @@ Front-end message types
>  
>    * The size may be 0 if the region is unused.
>  
> +``VHOST_USER_GET_VRING_BASE_SKIP_DRAIN``
> +  :id: 45
> +  :equivalent ioctl: N/A
> +  :request payload: vring state description
> +  :reply payload: vring descriptor index/indices
> +
> +  This message requires the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN``
> +  protocol feature to be negotiated.
> +
> +  Identical to ``VHOST_USER_GET_VRING_BASE`` except that the back-end
> +  must not wait for inflight I/O requests to complete before stopping
> +  the vring.  Instead, the back-end must immediately suspend all
> +  in-flight I/O requests and record them as described in
> +  :ref:`Inflight I/O tracking <inflight_io_tracking>`. How to suspend
> +  an in-flight request depends on the implementation of the back-end,
> +  but it typically can be done by aborting or cancelling the underlying
> +  I/O request.
> +
> +  The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN`` protocol feature
> +  must only be negotiated if both ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
> +  and ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` are also negotiated.
> +
>  Back-end message types
>  ----------------------
>  
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index d627351f45..bf455daa44 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -101,6 +101,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_DEVICE_STATE_FD = 42,
>      VHOST_USER_CHECK_DEVICE_STATE = 43,
>      VHOST_USER_GET_SHMEM_CONFIG = 44,
> +    VHOST_USER_GET_VRING_BASE_SKIP_DRAIN = 45,
>      VHOST_USER_MAX
>  } VhostUserRequest;
>  
> @@ -167,6 +168,7 @@ static const char *vhost_req_name(VhostUserRequest req)
>      VHOST_USER_CASE(GET_SHARED_OBJECT)
>      VHOST_USER_CASE(SET_DEVICE_STATE_FD)
>      VHOST_USER_CASE(CHECK_DEVICE_STATE)
> +    VHOST_USER_CASE(GET_VRING_BASE_SKIP_DRAIN)
>      default:
>          return "<unknown>";
>      }
> @@ -1399,12 +1401,18 @@ static VhostUserHostNotifier *fetch_notifier(VhostUserState *u,
>      return g_ptr_array_index(u->notifiers, idx);
>  }
>  
> -static int vhost_user_get_vring_base(struct vhost_dev *dev,
> -                                     struct vhost_vring_state *ring)
> +static int get_vring_base(struct vhost_dev *dev,
> +                          struct vhost_vring_state *ring,
> +                          bool skip_drain)
>  {
>      int ret;
> +    int request = VHOST_USER_GET_VRING_BASE;
> +    if (skip_drain) {
> +        request = VHOST_USER_GET_VRING_BASE_SKIP_DRAIN;
> +    }
> +
>      VhostUserMsg msg = {
> -        .hdr.request = VHOST_USER_GET_VRING_BASE,
> +        .hdr.request = request,
>          .hdr.flags = VHOST_USER_VERSION,
>          .payload.state = *ring,
>          .hdr.size = sizeof(msg.payload.state),
> @@ -1424,9 +1432,9 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>          return ret;
>      }
>  
> -    if (msg.hdr.request != VHOST_USER_GET_VRING_BASE) {
> +    if (msg.hdr.request != request) {
>          error_report("Received unexpected msg type. Expected %d received %d",
> -                     VHOST_USER_GET_VRING_BASE, msg.hdr.request);
> +                     request, msg.hdr.request);
>          return -EPROTO;
>      }
>  
> @@ -1440,6 +1448,25 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
>      return 0;
>  }
>  
> +static int vhost_user_get_vring_base(struct vhost_dev *dev,
> +                                     struct vhost_vring_state *ring)
> +{
> +    return get_vring_base(dev, ring, false);
> +}
> +
> +static int vhost_user_get_vring_base_skip_drain(struct vhost_dev *dev,
> +                                     struct vhost_vring_state *ring)
> +{
> +    bool skip_drain_supported = vhost_user_has_protocol_feature(dev,
> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
> +
> +    if (!skip_drain_supported) {
> +        return 0;
> +    }
> +
> +    return get_vring_base(dev, ring, true);
> +}
> +
>  static int vhost_set_vring_file(struct vhost_dev *dev,
>                                  VhostUserRequest request,
>                                  struct vhost_vring_file *file)
> @@ -2551,6 +2578,12 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                                 VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
>          }
>  
> +        if (!virtio_has_feature(protocol_features,
> +                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT)) {
> +            protocol_features &= ~(1ULL <<
> +                             VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
> +        }
> +
>          /* final set of protocol features */
>          u->protocol_features = protocol_features;
>          err = vhost_user_set_protocol_features(dev, u->protocol_features);
> @@ -3409,6 +3442,7 @@ const VhostOps user_ops = {
>          .vhost_set_vring_num = vhost_user_set_vring_num,
>          .vhost_set_vring_base = vhost_user_set_vring_base,
>          .vhost_get_vring_base = vhost_user_get_vring_base,
> +        .vhost_get_vring_base_skip_drain = vhost_user_get_vring_base_skip_drain,
>          .vhost_set_vring_kick = vhost_user_set_vring_kick,
>          .vhost_set_vring_call = vhost_user_set_vring_call,
>          .vhost_set_vring_err = vhost_user_set_vring_err,
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2a62550222..2c7f464d55 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1502,7 +1502,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
>  {
>      if (skip_drain) {
>          assert(vhost_user_has_protocol_feature(dev,
> -               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT));
> +               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN));
>      }
>      int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_state state = {
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> index d878d7b733..daa979a1aa 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -190,6 +190,7 @@ typedef struct VhostOps {
>      vhost_set_vring_num_op vhost_set_vring_num;
>      vhost_set_vring_base_op vhost_set_vring_base;
>      vhost_get_vring_base_op vhost_get_vring_base;
> +    vhost_get_vring_base_op vhost_get_vring_base_skip_drain;
>      vhost_set_vring_kick_op vhost_set_vring_kick;
>      vhost_set_vring_call_op vhost_set_vring_call;
>      vhost_set_vring_err_op vhost_set_vring_err;
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
> index 06c360af18..47c13f8677 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -36,6 +36,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT = 20,
>      VHOST_USER_PROTOCOL_F_GPA_ADDRESSES = 21,
>      VHOST_USER_PROTOCOL_F_SHMEM = 22,
> +    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN = 23,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>  
> -- 
> 2.34.1


