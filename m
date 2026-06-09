Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B61FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyrm-0006nJ-Os; Tue, 09 Jun 2026 11:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWyrl-0006n8-2r
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wWyri-0001fw-CN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781020783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLTicZ1Ygyv0LrexYj2ncrk/NU58h5AWXiXKewzr9a4=;
 b=XwCHctJ47bge/lf7HJoFu4Y/5X4M8Vc0MzaUqNGxP7piGI+nXoiANoXHhJBWiWIP7AI/9u
 PU1yDLsjkr9CP7dGkf8cjRiKmNrJ2JPtyD6RMdxt+8kJzPvtLJIfNqkPs9fcabEamUK24l
 1avo9Z/r3yf7vvM9i2xxQAvdJF8nALU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_fTPb0kgPEmXRwBqvNfQsA-1; Tue, 09 Jun 2026 11:59:42 -0400
X-MC-Unique: _fTPb0kgPEmXRwBqvNfQsA-1
X-Mimecast-MFC-AGG-ID: _fTPb0kgPEmXRwBqvNfQsA_1781020781
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490d3f03883so12389075e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781020781; x=1781625581; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XLTicZ1Ygyv0LrexYj2ncrk/NU58h5AWXiXKewzr9a4=;
 b=Syk04h0WxWmfIcypatSO6OTkgjy+UkVFVW5RcbI5XH0sqPeHnOiVkAWd8+sxXnT/RU
 wv6uLl768LRdk0QIbW1yIIIDlf8OmIg6whT7MdgP+XrmrYBPgaz9zqTRj4o4CcSXG6jn
 mFCdfH+lNOW/EwAd+VCWRaj81wOX1brcMNXHWOBWWkIva0ACkeryrqWzmqxFpzfhipKr
 qKMKfXIPnwAH+pFIBpbezYSGXuyuJwoUbfH0pXVZKrSdTByEM/zvGCAkfo1Rqh6AsyOr
 yujzWZ+S4ZxOjxzXoq+3wtSDSpwhRvJG8XC+aPxR7KrdNt8r9MwPfA3qEcd9hXxdzXvO
 25Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020781; x=1781625581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XLTicZ1Ygyv0LrexYj2ncrk/NU58h5AWXiXKewzr9a4=;
 b=CNW0auN+I+finjdxNS/ygnKGYzvjKSNl31AToXPz5ONfJS7xc6IcIAN/+92Ug2ebm0
 L8EhXJNzpDc/0+/oCJNoBEWHHC0oFQaJgl5ZMJAzCCGppgpkMLdxkdBVpaWAgXgwbPd1
 ynUmiFHUMV33p0LrKUHHpRY4krGQXPEm7c0n+UaDCrg1KHGpM/TQbGylGsrjwPjLTX2l
 U6JVjfhbnbeLi6/HLTBReG+ca4sgUfw+vH5Yhu7aUzfgh2InENg8DJfg+omAqNjCxiKt
 Sz2IXlnIUXeaoBEHrJD5dNSmzOdsI3A/6qtG+Evd+JSN3VMeSbrwYxup8VK8NSZwhbJ5
 e8+Q==
X-Gm-Message-State: AOJu0YxUXT5yLlayVC8LEOTSRJfa0fzKf22qSjXTTJ5RUrKEKcxcFx8/
 xRs9Kb9ce4YVAnPjT0Ieo360KQ/MTIvpKjaVuamQ+9RmV9nXUKJUq18sIMtPLmdJJ2EjKa6SMc1
 0ne1BDuyAm/mrTSpNUI/MSr3u9NU0w1oxJnJG7G84EWNzh7JsUfIlw4d+
X-Gm-Gg: Acq92OG+cp+1eBBwZLVgeBImBUgBUzMau4F+HDvCIrdNMCYA27LzMFffKRugEq2xwSE
 EDgky0fzTfdQ88dkMcKj2dTDHyrpNqfjy1aW0G1J4seGwV8RW5rnk18zwjbLVqmHTaMioFScQ07
 d3jNSjEQdU7/wNrfgGFSsrzA/Aa23wL46oPPTW6rgr/hlwVUTQzC79x9JpEy6izaaujMhTcDrYq
 9rVskF1R33lkmh9pXskN6QzO5WCU07dFBj19E9VWONZVNDzbeWonoR0smdGnHjKWtJM1vPN+fxX
 kRzny4o1vQiHzIZwYBVn/7XuXN0vVdf2sIP3Jt+1k7D7U4EEA+6D9Y7MtqyiE5twki6Jofb8bC5
 GKUIvdoksbYpJyCpey1G0dxSesf58szOrZ4J7w9zp4aSaKZFA492Jmg==
X-Received: by 2002:a05:600c:8183:b0:490:958c:46dc with SMTP id
 5b1f17b1804b1-490c25b0a60mr311654585e9.17.1781020780875; 
 Tue, 09 Jun 2026 08:59:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:490:958c:46dc with SMTP id
 5b1f17b1804b1-490c25b0a60mr311653885e9.17.1781020780273; 
 Tue, 09 Jun 2026 08:59:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c1149sm432954125e9.4.2026.06.09.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:59:39 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:59:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: helei <lhestz@163.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
Message-ID: <20260609115607-mutt-send-email-mst@kernel.org>
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606043251-mutt-send-email-mst@kernel.org>
 <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
 <20260606102015-mutt-send-email-mst@kernel.org>
 <9b5b6607-13f5-4b61-88be-d8386a0d1b00@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b5b6607-13f5-4b61-88be-d8386a0d1b00@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 10:35:14PM +0800, helei wrote:
> 
> 
> On 6/7/26 10:18, Michael S. Tsirkin wrote:
> > On Sun, Jun 07, 2026 at 08:15:19AM +0800, helei wrote:
> >>
> >> On 6/6/26 16:37, Michael S. Tsirkin wrote:
> >>> On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
> >>>> The virtio-crypto spec does not dictate a maximum length limit for
> >>>> asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
> >>>> the linux kernels's internal limit for akcipher keys (see
> >>>> keyctl framework and the add_key syscall).
> >>> We have max_size - doesn't that apply?
> >>> backends/cryptodev-builtin.c actually sets it:
> >>> backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
> >>> backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
> >>
> >> Thanks for your review!  I have verified via testing that all processing
> >> requests in the dataq are strictly
> >>
> >> bounded by max_size, but session creation requests in the ctrlq are not.
> > 
> > 
> > 
> > well if we read the spec it's vague
> > 
> >   max_size is defined as "the maximum size of the variable-length parameters of data operation of
> >   each crypto request's content." and
> >   The driver SHOULD read max_size to discover the maximum size of the variable-length parameters of
> >   data operation of the crypto request's content
> > 
> > 
> >   so data operation.
> > 
> >   however:
> > 
> >   "The device MUST set max_size to show the
> >   maximum size of crypto request the device supports".
> > 
> >   seems to cover all requests?
> > 
> the original architectural intent was almost certainly for max_size to
> govern data-plane payloads, while control messages are handled by their
> own independent limits (max_cipher_key_len and max_auth_key_len).
> both upstream linux guest driver (virtio_crypto_skcipher_algs.c) and
> qemu's builtin-backend actually implement it exactly this way:
> - data path enforces max_size by checking it against payload length
> (note that cryptodev-builtin recently capped this to 1MB via CVE-2025-14876)
> - control path completely ignores max_size when creating sessions

we can add akcipher key length feature but what to do about existing
guests?

could max_size be a way to fix it?

> > 
> > 
> > btw vhost user sets max_size to max u64 - is that sane?
> > 
> this is sane for an out-of-process data plane from a transport
> perspective, but it creates a practical catch when backed by a dpdk
> implementation:
> - in dpdk vhost_crypto.c, vhost_crypto_check_cipher_request() enforces a
> strict check: src_data_len <= RTE_MBUF_DEFAULT_BUF_SIZE (2176 bytes)
> - the guest kernel driver simply wraps the incoming sg list and passes
> it to virtqueue directly.
> this creates a tricky situation for users: because vhost-user claims
> max_size is max_u64, the users has no way of knowing this 2KB ceiling
> exists unless they explicitly know the host backend is dpdk and look at
> its source code.

worth fixing maybe.

> >   
> > 
> >>>
> >>>> Maybe we should update the virtio-spec and add a max_akcipher_key_len
> >>>> field for virtio crypto devices.
> >>> maybe
> >>>
> >>>> helei (1):
> >>>>    hw/virtio-crypto: enforce max akcipher key length
> >>>>
> >>>>   hw/virtio/virtio-crypto.c | 13 +++++++++++++
> >>>>   1 file changed, 13 insertions(+)
> >>>>
> >>>> -- 
> >>>> 2.43.0
> > 


