Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBA4C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrf4j-0002VL-No; Wed, 05 Aug 2026 13:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrf4i-0002Um-7D
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrf4g-0004qy-9p
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785949596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aj9NoEJZPsIHGe466zl47eTvqENcTxsPftBJefv4usc=;
 b=BAF/2ahE5FPp7w+1+X2dHZUnWc5qmqiHzIZncnfvUDKefwOQesB3aOTnpBZrAzSphdoRKn
 nHF+TLTNzHhnZk4rNgP3tVcySEeaTFAMWkl0F2ZA4tYbJTKP+lutpvQLzF4dFGmigNJWuk
 duDzRAcd6+JtSrRRJKkn6Yb5l5wIcQI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-J5hxVgB_Oh6PAqUpkuFY8Q-1; Wed, 05 Aug 2026 13:06:34 -0400
X-MC-Unique: J5hxVgB_Oh6PAqUpkuFY8Q-1
X-Mimecast-MFC-AGG-ID: J5hxVgB_Oh6PAqUpkuFY8Q_1785949593
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f835ac1aeso803758f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785949593; x=1786554393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aj9NoEJZPsIHGe466zl47eTvqENcTxsPftBJefv4usc=;
 b=YiJvfGe8gquSkgUOyBRuXTaydg6OCpKy8JWmzWn1+DXeJJM9GksjMX50AlaftvqxY0
 k7mSoEBIaXAQopb4rkDGSMGiOl3jvTaeTCTPjDF7VeIesGIo/T8JdqhDsTOZ8DhZtDYZ
 WtjwLDM3vVpaZRHsCpKnT45TwUQgvyoUwFHkTEh19mhphrPaCBk8rpOE9z8PdfGuGdZc
 DEgnmIPQneqtIajlVE7YoNnjmhRtXT4LhYcpsMG6JZ/rtd01/J8wjwiEQap0+xdY4ydO
 A2p/9inNnAav7upx2NIh7C0lAbMneapABL4QlI/pOfdfHl0N1spK3B0x+y2d45x0rtPK
 ST+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785949593; x=1786554393;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aj9NoEJZPsIHGe466zl47eTvqENcTxsPftBJefv4usc=;
 b=GWxqh+0oUwNyjMLHZZ9O1VSKaYhmhbejeB6jsu4siCNOqmjM91u5ibJsn/OhXSF/FM
 Pc/KeAAH9jB0GA9c9sRRGLo12ybq6klPFyB0rXD8eH01WKW0/0JBiTgcV5UzjHLXBjiP
 XzvhXTwAE3HF3FmR1VMxeUe6haVWh9BQgkJaHPl9/77nJ44m8wzHaYesq0pA/E+Q8Ikb
 6wnftPFDmIxzxTm75vvm/HWP5CGp+Eg/QdbamVrB9WmdbqojbLfuwb8Uf2XCz1RNOCzY
 SnTTdcV2fXoqKc/+rrxwirRKPHSpZO4WNItcfnaFfJf40pd3t1+wdp2XIGY60VEgNqJ/
 TECw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNzqsnFSZfmkzXa6Fhidi5YpoZH4wMB+m8psjgl9Vg0LXaQDYJ/tnOwELkctqGX5H3HXyHGRvlFegp@nongnu.org
X-Gm-Message-State: AOJu0YwM6IzNCu4l/O/9DaHy9Sedjm09DLvTONQF7ylmnkOR/GP3tT6+
 N4Yo1KQJHX4lqn6QS0UZIVBpfTBVkTXjZgvUy8TKmnH5kGxih6UGn+yH7DLz2QfE3rWA1qCU1/9
 CKpFD8DM52/xjiumi6SPGLbgrKoCMuaYsKa5j9legEex16Sp2oKt3ne6v
X-Gm-Gg: AR+sD13fV5O2iHObcYOGi391QRO3f2OuMWLCTKspfuWbN+lkSJQHKCgq+VQFmHW7Qaq
 33ora1nltiTqhz28dWFKU/pK0Hp64iS+ZzR8Awcpqz7wtJ10wCe+9sHzAnNetwtEqWmoKg5lAg2
 vBqAWVKULwSP0Z8pbIluZ7KKY58T2yq+qH6JaoRtLEWMKihvupy0OZinm8ftdvN9OKR2dy+ZWQt
 ZhzWvmROCAELUHz969S4VyU/88lnBw3tYARXpQa7PO8aQuEBFQs/0Yan7XxRiyy4DgDyUAmG/ph
 13kvf4Kqme/TJtrF8ORw0BN6P6MoXbJ1k/+MPJuxxaRAt1zTgs4jLhOEA26Ox9vi9AZ1eKEjPOG
 /jqSp2Xv0o6L6N40pFyjqz/mKu457vJlRgx/Vt5CKcfwpf2ymYvdQPh3mEphW6kUbVUk/60Z0wL
 2lm0LT4HLI8HWe2sTNCdzjeooW
X-Received: by 2002:adf:ea89:0:b0:47f:9751:cb3d with SMTP id
 ffacd0b85a97d-47fec4f229bmr12291794f8f.8.1785949592979; 
 Wed, 05 Aug 2026 10:06:32 -0700 (PDT)
X-Received: by 2002:adf:ea89:0:b0:47f:9751:cb3d with SMTP id
 ffacd0b85a97d-47fec4f229bmr12291715f8f.8.1785949592538; 
 Wed, 05 Aug 2026 10:06:32 -0700 (PDT)
Received: from ?IPV6:2003:cf:d706:f1f0:10e1:24f6:18:83f2?
 (p200300cfd706f1f010e124f6001883f2.dip0.t-ipconnect.de.
 [2003:cf:d706:f1f0:10e1:24f6:18:83f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23e533sm10367934f8f.28.2026.08.05.10.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 10:06:31 -0700 (PDT)
Message-ID: <9f9dcb50-aab4-43ab-8563-63a9559f7d11@redhat.com>
Date: Wed, 5 Aug 2026 19:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qcow2: repair a dirty image when it becomes writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
References: <20260731220039.1765584-1-den@openvz.org>
 <20260731220039.1765584-3-den@openvz.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260731220039.1765584-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

On 01.08.26 00:00, Denis V. Lunev wrote:
> A dirty image must be repaired before anything allocates a cluster in
> it. qcow2_do_open() does that, but only for a node that is writable
> from the start. A node opened read-only skips it, and nothing revisits
> the question once that node becomes writable, which block-commit does
> routinely: commit_active_start() and commit_start() reopen the base
> read-write for the duration of the job.
>
> With lazy refcounts the on-disk refcount block then still accounts for
> the metadata clusters only, so the allocator restarts at the front of
> the image and hands out clusters that L2 entries point at. Two guest
> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
> stays clear, and a clean close clears the dirty bit, so no later open
> repairs the image either.
>
> Do the repair in qcow2_reopen_commit_post(). bdrv_reopen_prepare() runs
> before bdrv_list_refresh_perms(), so it holds no BLK_PERM_WRITE and,
> with auto-read-only, bs->file may still have an O_RDONLY descriptor.
> commit_post cannot reject the reopen, so signal corruption if the
> repair fails rather than let writes alias live clusters. An inactive
> node is skipped: bdrv_activate() calls qcow2_do_open() again through
> qcow2_co_invalidate_cache().
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/qcow2.c              | 14 ++++++++++++++
>   tests/qemu-iotests/039     | 24 ++++++++++++++++++++++++
>   tests/qemu-iotests/039.out | 17 +++++++++++++++++
>   3 files changed, 55 insertions(+)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1543255eba..e660655a0d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2147,8 +2147,22 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
>   
>   static void qcow2_reopen_commit_post(BDRVReopenState *state)
>   {
> +    BDRVQcow2State *s = state->bs->opaque;
> +
>       GRAPH_RDLOCK_GUARD_MAINLOOP();
>   
> +    if (bdrv_is_writable(state->bs) &&
> +        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
> +        BdrvCheckResult result = {0};
> +        int ret;
> +
> +        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0 || result.check_errors) {
> +            qcow2_signal_corruption(state->bs, true, -1, -1,
> +                                    "Could not repair dirty image");
> +        }

Should we return here? I don’t think we should go on into the 
`qcow2_reopen_bitmaps_rw()` path.

Hanna

> +    }
> +
>       if (state->flags & BDRV_O_RDWR) {
>           Error *local_err = NULL;
>   


