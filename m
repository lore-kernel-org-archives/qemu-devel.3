Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B22606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wqt4h11T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNmn9-0004m8-4W; Mon, 02 Nov 2026 02:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNmml-0004fi-7t
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNmmh-0000Y5-JI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793605730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juS9I+PXsTYwYbg3KY1UWMe8bHhGaM6r0E2W/eWiN5Y=;
 b=Wqt4h11TG0Eh0xBn1LNvXQ23FlRxwQq/eYCL4hXWA5rgHktufUz5QWwVPGJR/s6TQsBRdH
 zBPfWLa2M7tFtJ3LeacXATOwSIH33aL0smIyXQHtGofjxqmjWomKuWPvC1ChS2Tym3OoOB
 baMYXzt38/8Z7CMnGUqtplj63GPRN7I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-3u6dgEFVPpK5x11RWvURow-1; Mon,
 02 Nov 2026 02:48:47 -0500
X-MC-Unique: 3u6dgEFVPpK5x11RWvURow-1
X-Mimecast-MFC-AGG-ID: 3u6dgEFVPpK5x11RWvURow_1793605726
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8AA61956066; Mon,  2 Nov 2026 07:48:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E56B67D6; Mon,  2 Nov 2026 07:48:44 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/4] net: Pad short packets in qemu_send_packet and
 qemu_sendv_packet
From: marcandre.lureau@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowangio@gmail.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20261027174625.4025878-4-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
 <20261027174625.4025878-4-peter.maydell@linaro.org>
Date: Mon, 02 Nov 2026 11:48:36 +0400
Message-Id: <179360571624.2763172.7914119075103403787.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=J/1h91+kBJHVJ6U8Z2V3RHwd7zEoJAyI1WgHWWrZQkk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6EBW1supt5tRJAPlqAVb44/InYki9dR6/nU9m
 xrc1H1eXp+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauhAVgAKCRDa6OEJdZac
 5ZrLD/4j3j2EGtCDYkspIOj4W/eHNVvGMaRDzK59rU7pcGXT2JV9Hx2JRZOs0obvuGs13EXHI3I
 H7IRd/U7FkX6hZS6jZmRJ77o075mak1yxk34XzxD5YiWlWixeqZf1jJV6bCatXB6X/UO3U3JPQQ
 BZkGU4QOW6IMRXA1G8yCOwKh5ipaqvNLv8FX/seMdzTFke0DeacYmqwP6ghSGt3JxbbMAf2RfXp
 FXT5NztH3SLMOMt/aoq+eeUSnSOaaCKv/gIw0zyf1tRaj6B7iwxxefIorqKfDPFLug2PgQpRr/k
 aPV+Qv1SfYsKtwYrNp9+UQd9UxJPkYip3jXNILboO7ED4K9IYWzE+61JyI/D6dbPfOSgoRD3E9P
 VyOC8YdCgLjIcQCMgQ7GblAtHguVMFaBFQRTAsCMamk/WRpCyQeERQ1Yy2bUfRjjkUtINWMigZw
 +HIt65YMws2hPcyb+e1FqMLdJKt7O9Sqmz/WOTA9yZyp8Kle7P764ZdqPW3LZNK5kW/i45GoCSp
 4/L+eEoQ+rACU+rbXO6I4uijmnhjKNsMANsF/f0ouQl4sCfKSnZFdhsCye+Olcu4wEPiJcHf1cL
 QvXFhFiIAO4bf5T2JiFJeJWXhEKNg9TAO8lvNhZqYtmMHKrJ7eNjXQ8XIKdPj1Ruu7PfZO4hQrq
 nplINM5vilOIOTg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Now that we can rely on do_not_pad being correct for all
> NetClientInfo structs, we can pad short packets in the
> qemu_send_packet() and qemu_sendv_packet() family of functions.
> 
> If the callsite is already padding, then this will have no effect,
> but callsites like the socket and dgram backends will now correctly
> add padding.  This fixes the bug where when two QEMU instances are
> connected via one of those backends a short ARP packet transmitted by
> one is not correctly padded by the other and gets dropped.
> 
> Note that if we pad a packet, our return value on success will
> be the size of the padded packet, not the original. This is OK
> because this function (like the NetQueueDeliverFunc function type
> documented in include/net/queue.h and which we will eventually
> end up calling and returning the return value of) returns
>    >0 - success
>     0 - queue packet for future redelivery
>    <0 - failure (discard packet)
> and doesn't guarantee to return exactly the size of the packet
> sent. None of the callers try to use the return value as an
> exact size.
> 
> Cc: qemu-stable@nongu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2362
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-ID: <20261027174625.4025878-4-peter.maydell@linaro.org>
> ---
>  include/net/eth.h | 22 ++++++++++++++++++++++
>  net/eth.c         | 18 ++++++++++++++++++
>  net/net.c         | 22 ++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 46dc9ed5acd9..042b2fc42db4 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -437,4 +437,26 @@ eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>  bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
>                           const void *pkt, size_t pkt_size);
>  
> +/**
> + * eth_pad_short_frame_iov - pad a short frame, iovec version
> + *
> + * This is equivalent to eth_pad_short_frame(), except that it works
> + * on a packet stored in a struct iovec.
> + *
> + * If the Ethernet frame size is shorter than 60 bytes, it will be padded to
> + * 60 bytes at the address @padded_pkt (and the caller will need to handle
> + * it as a not-in-an-iovec packet).
> + *
> + * @padded_pkt: buffer address to hold the padded frame
> + * @padded_buflen: pointer holding length of @padded_pkt. If the frame is
> + *                 padded, the length will be updated to the padded one.
> + * @iov: iovec holding the original Ethernet frame
> + * @iovcnt: number of elements in @iov
> + * @pkt_size: size of the original Ethernet frame (i.e. iov_size(iov, iovcnt))
> + * @return true if the frame is padded, otherwise false
> + */
> +bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
> +                             const struct iovec *iov, int iovcnt,
> +                             size_t pkt_size);
> +
>  #endif
> diff --git a/net/eth.c b/net/eth.c
> index 12ec316e240e..14006222d68d 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -536,3 +536,21 @@ bool eth_pad_short_frame(uint8_t *padded_pkt, size_t *padded_buflen,
>  
>      return true;
>  }
> +
> +bool eth_pad_short_frame_iov(uint8_t *padded_pkt, size_t *padded_buflen,
> +                             const struct iovec *iov, int iovcnt,
> +                             size_t pkt_size)
> +{
> +    assert(padded_buflen && *padded_buflen >= ETH_ZLEN);
> +
> +    if (pkt_size >= ETH_ZLEN) {
> +        return false;
> +    }
> +
> +    /* pad to minimum Ethernet frame length */
> +    iov_to_buf(iov, iovcnt, 0, padded_pkt, pkt_size);
> +    memset(&padded_pkt[pkt_size], 0, ETH_ZLEN - pkt_size);
> +    *padded_buflen = ETH_ZLEN;
> +
> +    return true;

assert(pkt_size == iov_size(iov, iovcnt)) or just drop pkt_size
argument and comput it?

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


