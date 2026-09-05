Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2840C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 08:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2lV9-0002Xx-VN; Sat, 05 Sep 2026 04:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2lV8-0002Xm-4U
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 04:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2lV6-0000CI-Bu
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 04:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788595906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wFOGKF0sgUpyPyB7fIiIhR9y/kbkd0xvWb3cOFbdYwI=;
 b=A7bNvJeEw/WUfiZWAEDrzbD1ppkkHijdAnqyK5jcF/COm9FImHtIdS2cS3D70/yWXWRZvk
 bLlYvcGVIdLm60PCjv5jGbNfKiHaTTVJXKtrTW/mwZV9fwzI766E5JS5jyahDAtdS7IIEh
 x0kS2J5U2n8k6PkMS2CGj4nWoJuqHKs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-b8baU8LDNgi-xj08gEsYjw-1; Sat, 05 Sep 2026 04:11:45 -0400
X-MC-Unique: b8baU8LDNgi-xj08gEsYjw-1
X-Mimecast-MFC-AGG-ID: b8baU8LDNgi-xj08gEsYjw_1788595904
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccf17d3b0so11351765e9.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788595904; x=1789200704; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wFOGKF0sgUpyPyB7fIiIhR9y/kbkd0xvWb3cOFbdYwI=;
 b=qp9dxkC2G5wCKZrfHF7aowGvtlKwOlW4SnMrUYXLiNXvbHoxH4DKfPXEFtu98l1SRo
 UGAOxftOQDgHp/CXn0se9Aw2fVxRVLsBCjZYXVr93dCChps/uKe8cJKlEU0BKBjSBfOV
 QJDn2S9c/cz6ndyLNvQfaJB8OnfkN31isUPa2uoqyMKnIRiFA8vrnRDugpYfvGPBAPg7
 K2JNhMX8CYFzjf2S6nOS2POuEAtNFH2FI1gicfUQgXDCQsHSbvT4wGPhlPzQhL5FZimc
 wQ6MUtBRcxF1C+OwUsmOMn6WmkwKwHO3Ab1F2Cg7mImmkv6EP9KDLlZf06aKrtpNLS9I
 /1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788595904; x=1789200704;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wFOGKF0sgUpyPyB7fIiIhR9y/kbkd0xvWb3cOFbdYwI=;
 b=qG004A4rR3m84v45NYj0MfAoyvVXr7LOVB8pZdtqrbRePiAB0HFEy+AZn71Uk/vVXS
 p7CSCxewDK9GgvOMYmDOhU7oWcmU+0bpGsIaWR0X9UFj8HjjE1DFKZqSB+O4ZAYv2bqN
 /5SU4Kz7X4EUnoxP81drGHQ1DJdKSYG15SG37KeVrE1qfJc3D3G2GQ3EiIfk0OMLnfXS
 r50NV4MkPQyHYavXItI6by0pFOOV1ia9XyZEt3ifsJCWoMHCzpTvhkSFZELDkjqz+hMl
 uYzlhgTxqUOM7HzLhmYHTxh3OfcFRTZkgVbikZWQmr8VDkadvnf9bKZzGAWY5E1DEYy3
 SOCw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAxKL9890RMFExb5iwzyQSvlCM83qQoanFDzeRndxEbe9vBv6OHicwEL8TWwqdNJ3E9OFc372qmU+g@nongnu.org
X-Gm-Message-State: AFuF++nBuLZaAqcTJS9EEQpBepC/vu0qv5Nvkr2tG6pArzulnZSeAXl+
 e1gjc5RF5/ejr7mG8+yqcUmtdhSEbIPGbePVRsULXyLjtT6w9eCOdtK3zMCE3xv3ptBhaGZCeXv
 /nxunfEXxmOyqt78Ft5EVeJzVSrYPNh5xtDrPmA7p0N2FNtcWvto8Nht2jU5zgQid
X-Gm-Gg: AYBFou3uKN9xR9eetwuksekr2zYOOXSg6ZhCsYqpYYHvB8ckDj1FUJNnCb6yU4QlMOM
 ivgXuSHNAXGyF7JVwvVabs5g95iqhOo2GIhxqA3nYP5FeHK0OFI/TRGNsL/aEz9mcGroNPNGtcU
 zyIYFmbE/D7w80GhlGwjCIaN1wuDcGPXwP7a9TOQ0RSgqC1a6Ian+G+2YM9yvg0SDEd9cUokSDx
 uIoIEPboy7oW+z1MAbrw6o103uHZGm72b7KAFRoqGZZ+JFa/nnRoKToRFtGcsjmPfZk9fZJsYJM
 L4pQh5CEZwQz1YK6J7RXvgZlMMLFO53HVC23uOiiNQeaB/rlyAPhPlKzl4Ky7MDV9O4r2rJQ9xI
 Wvmq6KF7X7aXwVkq0zcCF7gQ=
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49cf7fe62e9mr219251035e9.1.1788595903859; 
 Sat, 05 Sep 2026 01:11:43 -0700 (PDT)
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49cf7fe62e9mr219249915e9.1.1788595903296; 
 Sat, 05 Sep 2026 01:11:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d0656e7bbsm20022345e9.10.2026.09.05.01.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 01:11:42 -0700 (PDT)
Date: Sat, 5 Sep 2026 04:11:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/1] net/tap-solaris: Fix resource leaks on error paths
Message-ID: <20260905041030-mutt-send-email-mst@kernel.org>
References: <20260905070448.34648-1-xiongweimin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905070448.34648-1-xiongweimin@kylinos.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 05, 2026 at 03:04:47PM +0800, Xiong Weimin wrote:
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Hi Michael,
> 
> Thanks for the careful review of v1 -- you were right that v1 was
> not ready to merge. Let me walk through the issues and the fixes
> in this v2.
> 
> 1. Patch format corruption
>    -----------------------
>    v1's diff ended up with "4321006" in the file mode line instead
>    of "100644", so `git am` could not apply it. v2 is generated by
>    `git diff` against a fresh checkout of net/tap-solaris.c from
>    master; `git apply --check` and `patch -p1` both pass cleanly.
> 
> 2. ip_fd was being closed while still in use
>    -----------------------------------------
>    In v1 I had `close(if_fd); close(ip_fd);` sitting next to each
>    other right before the SIOCSLIFMUXID ioctl() block. But the
>    next ioctl() uses ip_fd, so closing it there meant we were
>    issuing ioctl() on a stale fd. v2 removes that close entirely:
>    ip_fd is now closed only on the failure paths, and the SIOCSLIFMUXID
>    block uses a fully valid ip_fd.
> 
> 3. The label scheme was double-releasing muxids
>    ---------------------------------------------
>    v1 had separate `fail_arp_muxid` and `fail_arp_fd` labels, and
>    the SIOCSLIFMUXID failure path did
>        I_PUNLINK arp_muxid;
>        I_PUNLINK ip_muxid;
>        error_report(...);
>        goto fail_arp_muxid;
>    then fall-through into fail_arp_muxid which I_PUNLINK'd them
>    *again*. v2 fixes this by keeping the inline I_PUNLINK pair
>    in the SIOCSLIFMUXID failure path (those muxids were both
>    successfully established at that point) and `goto fail_if_fd`
>    to skip past the redundant muxid cleanup. The result is each
>    muxid and each fd is closed exactly once on every error path.
> 
> The new cleanup chain
> ---------------------
> 
>   fail_ip_muxid:  I_PUNLINK ip_muxid
>   fail_arp_fd:    close(arp_fd)
>   fail_if_fd:     close(if_fd)
>   fail_tap_fd:    close(tap_fd); close(ip_fd) if it was opened; ip_fd = 0
> 
> ip_fd is a function-static variable, so resetting it to 0 after
> close is required: the next tap_alloc() invocation starts with
> `if (ip_fd) close(ip_fd);`, and we must not close a fd that some
> other code now owns.
> 
> I considered folding the SIOCSLIFMUXID failure path into the goto
> chain as well, so that *every* cleanup is centralised, but that
> would have to either (a) duplicate the I_PUNLINK pair across two
> labels, or (b) reorder the chain so muxid cleanup runs before
> SIOCSLIFMUXID -- which doesn't make sense because those muxids
> don't exist before SIOCSLIFMUXID validates them. I think the
> current "inline I_PUNLINK at SIOCSLIFMUXID failure + goto
> fail_if_fd" is the cleanest decomposition, but if you prefer
> fully-centralised cleanup I'm happy to refactor it that way.
> 
> Testing
> -------
> I do not have access to a Solaris 11 host here, so this patch
> has not been tested on a real Solaris system. The change is
> purely a refactor of the existing control flow, and the goto-
> cleanup pattern mirrors the one used in net/tap-linux.c (which
> is tested regularly), so I am fairly confident -- but please
> flag anything that looks off and I will follow up.
> 
> Could you please take another look?

Sorry, as long as it's not tested - not really interested.

> Thanks,
> Weimin
> 
> ---
> Xiong Weimin (1):
>   net/tap-solaris: Fix resource leaks on error paths
> 
>  net/tap-solaris.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)


