Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A30CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOyFT-0006tN-9F; Mon, 18 May 2026 09:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOyFR-0006t2-1L
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOyFP-0000bn-Ad
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779111784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6xl4vtfU/9eU5S3Bj29pWLnEDSBcRAFl0XN5zIKTZc=;
 b=ZXv+UwvaBo74JvTcaAn+y8xKjRUaokwAhlUSl7zmWxMa1LSJ66cavwC7SjFC5iBzeIWCTh
 PqjmCcN1WFp4L1+b0LXvnbZntWX0H8YnugmdnZ7dF/M3uO80SWbOTZoF6OjJOHU+vIvcqm
 iILdM01pDAWuB8hhhlulCckL9NJq9Ag=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-FLkICtZeMXWp2aCPYyDvgg-1; Mon, 18 May 2026 09:43:01 -0400
X-MC-Unique: FLkICtZeMXWp2aCPYyDvgg-1
X-Mimecast-MFC-AGG-ID: FLkICtZeMXWp2aCPYyDvgg_1779111780
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48feb8b9acfso14065555e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779111780; x=1779716580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6xl4vtfU/9eU5S3Bj29pWLnEDSBcRAFl0XN5zIKTZc=;
 b=c0baG1RbrxvoXgmiV+cvlHCWl5AFnWRoXRe+cN8I1RJGwjaIpfSxZqI+conE/Wj9JF
 +jOoUKxCeCncNDzv7hUkYQFC9h5v4RLnTea8X674hysGwKVJYAcT8jFc1eYo48Wl/iJ9
 XZq2nvkYIw+TQmQ7lBObzjpcdcA5AwzkWNP/Zy9tpdjn/1j3+xkqZSYNW8NCgayw3HMj
 R7p0Toqy5of+A53LtMPb9dPIiiHs8vXnvePLe2rfiZjF91ttlM7FBC++66a8xMCFgeWD
 4Z34OxEsF0lYOnxOT8/M7i4HnljSqN2i07GQOwh1jrHf80kzMe3UGg/N8aOZMk97cRUN
 Swqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779111780; x=1779716580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6xl4vtfU/9eU5S3Bj29pWLnEDSBcRAFl0XN5zIKTZc=;
 b=a7HfmU4CvrY/8DKYpXuzxq+PuDO937HOQ6CRyELZ7xiieER5TnbeRqgeJmOxWg4EdC
 U9MkGrH2LS0ucHKmv41KPLxxHnvg4/gzubnPDHvOd2eOH51+9mIPxJIzN6jF3wUfYw2Z
 EBe8JwI1lV+zKIl3kUu5f6UESqSqkDy6rj/jmPyjCgj5wBbrnxPoFOmjHQf20j2DQPsR
 4Gy6/quwTtTicTcEeDKgZSpScEPRee5hYkVMprpcqDuyNj7jEgw+MvVUwmTv3bcpQBO0
 b9up6peM7TXamZAzyo4bx5H2RftHmBZKg3yYewsNh2oN6//kOxbuaMjAthYfQXJirgx5
 KWCA==
X-Gm-Message-State: AOJu0Yy3ssXntC7HZTAXgrmPdldX3Hej8oJoC0pFbfaTTXoMHrizbyHq
 cQGSBrUJ9UnpKZU/uJqBkxQsM47jDb4qGghKi1G68sC4+0eqtcDe6PykVvuuVK7v3BQoJtua7JW
 eLnv9LhVscwuO0dt4rOt9EPgqZDAGqXrOxc3taurPeTOL8uYK/aEFc/hL
X-Gm-Gg: Acq92OH4zojmfwfoJfy0k1D8xWz+WvjiQtJDuKxau6FErzAUW90+5Ety99Cg2Noh2jK
 TpLByHxcUEGDMYMK+pxDytPkxXW8Sp5f3lCZG6APtnOzT5kyApQfEx0WYVcDIDqAAyoaDsDLDH5
 sfumLRQWUOrQCNK2Cx21LNx3NCcdtwfsqnaQa+WuF7FIq73bF8EIxNht71qP3ZL/CuFrlA/zkHi
 kXKmRq5ATWhGuU3//4Vq+s6Fw8sx5aq3C6dvhJzMHQFK8PS8kzkEWPFtrMJpRqQvIWjVk6Lhee+
 FMLp7j48NWXP4P0r4TjD82pArDoAiecMhMQYVPkRmv5hWy37iTw4hlSV/beULuwbL7C0yRmoTcN
 zVsqtlg==
X-Received: by 2002:a05:600c:a406:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-48fe632a9f4mr181880195e9.23.1779111780231; 
 Mon, 18 May 2026 06:43:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-48fe632a9f4mr181879935e9.23.1779111779853; 
 Mon, 18 May 2026 06:42:59 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm37096706f8f.14.2026.05.18.06.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 06:42:59 -0700 (PDT)
Date: Mon, 18 May 2026 15:42:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Che Kao <skps96g313.cs10@gmail.com>
Subject: Re: [PATCH] apic: fix delivery bitmask with modified xAPIC ids
Message-ID: <20260518154257.20e0d83c@imammedo>
In-Reply-To: <20260515103848.3883904-1-pbonzini@redhat.com>
References: <20260515103848.3883904-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 15 May 2026 12:38:48 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Self-IPIs (or all-but-self IPIs) in QEMU can cause a out-of-bounds access
> to deliver_bitmask, because the access uses the APIC ID register which
> is writable by the guest.  However, foreach_apic uses the delivery
> bitmask indexes to look up the local_apics[] array, which is indexed
> by *initial* APIC id.  Using the right id fixes both a possible heap
> write overflow if the modified APIC id is too large for max_apic_words,
> and a mis-delivery of both self and all-but-self IPIs.
> 
> Reported-by: Wei Che Kao <skps96g313.cs10@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/intc/apic.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index e5ea8312617..0e8932005fa 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -648,13 +648,6 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
>      APICCommonState *apic_iter;
>      uint32_t deliver_bitmask_size = max_apic_words * sizeof(uint32_t);
>      g_autofree uint32_t *deliver_bitmask = g_new(uint32_t, max_apic_words);
> -    uint32_t current_apic_id;
> -
> -    if (is_x2apic_mode(s)) {
> -        current_apic_id = s->initial_apic_id;
> -    } else {
> -        current_apic_id = s->id;
> -    }
>  
>      switch (dest_shorthand) {
>      case 0:
> @@ -662,14 +655,20 @@ static void apic_deliver(APICCommonState *s, uint32_t dest, uint8_t dest_mode,
>          break;
>      case 1:
>          memset(deliver_bitmask, 0x00, deliver_bitmask_size);
> -        apic_set_bit(deliver_bitmask, current_apic_id);
> +        /*
> +         * The self and all-but-self cases do not use apic_match_dest() and
> +         * directly fill in deliver_bitmask; the bitmask's indexes in turn
> +         * map to local_apics[] slots which are never changed even if the
> +         * xAPIC id is modified.  So use s->initial_apic_id instead of s->id.
> +         */
> +        apic_set_bit(deliver_bitmask, s->initial_apic_id);
>          break;
>      case 2:
>          memset(deliver_bitmask, 0xff, deliver_bitmask_size);
>          break;
>      case 3:
>          memset(deliver_bitmask, 0xff, deliver_bitmask_size);
> -        apic_reset_bit(deliver_bitmask, current_apic_id);
> +        apic_reset_bit(deliver_bitmask, s->initial_apic_id);
>          break;
>      }
>  


