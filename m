Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438BAE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaae-0006u9-Im; Wed, 08 Jan 2025 13:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaac-0006tX-JS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:15:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVaaa-0004N3-TQ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736360132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIDtl75921090Wf+g/c3B2v7DKV9MAn9nwxBRn/3n8s=;
 b=ZZqJtlqfYiW7LuvnQWzibvCLzUeLRen+ur98Phs0mI7XnWuKp1d8MtDF/nV55QS0YirV7K
 EGvYVjw1oaEp+RISU6/iXtketXk0KWTRIcImzihnezl/h98jhSi84ZoSgQ87uTjsluPB6d
 7PlkFMyEvoNrdUfnG/mTko8ATENAkMs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-r3f6CT5qNA2Y7O2k53INzA-1; Wed, 08 Jan 2025 13:15:31 -0500
X-MC-Unique: r3f6CT5qNA2Y7O2k53INzA-1
X-Mimecast-MFC-AGG-ID: r3f6CT5qNA2Y7O2k53INzA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8fe8a0371so1941946d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736360130; x=1736964930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIDtl75921090Wf+g/c3B2v7DKV9MAn9nwxBRn/3n8s=;
 b=sU/ElYTrgwtbJNZ7mW0zzch1BX8bDUFGAduA/NRHE4I92MlYMha6vOoEwIb/h4G5GL
 3YSOEBa0DLR9mxmD2TdkHYlBXmWVyt+ZvpLgLfAZqmQNZHBR4Uni41+F5VMTdjQDQeor
 ZZCJFaxVUqpaT3WSDnNAiO2QptLl/jR6QaMj0qT+4whlQKh8B22NA/0wUjie8PaKt7KV
 0tIec97DBZz4ifKImJjpROnAILP1aGsK+COUT3i8MPRfBbS4huqq5w1yRdmLU9p6gBwS
 a/lWWHaO1UZ84V7Nw2YOdeFO4Ie9Lz/ZuqwdL/4im7IUyT+LuJ4Uii63JjDKcF+ptNkW
 Ob+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDg66daZJqHrTeFr+khpfc4K9JXYOOAWq1TxKoz4Mc20vJXR+KO2G5DtsNMfKr23xSMtUa31K0jwnf@nongnu.org
X-Gm-Message-State: AOJu0Yx5nYKg3aX8ln2Wtmacs626r9BQ5WJLj5MoEDR5rcLlfMyoRrZc
 X5LXlHt5lZ2MkpE4ToJwMgf8Vm6Z3sMdAQe4CbsXV/Qc/utiDLBicsUB36+OL6jPLxjx10BbGxo
 Mwrl7NaL85omRIE1GPIYA11lNNax+I24bquaFEX/Z0+ZLVYGBHCpH
X-Gm-Gg: ASbGncs0jhIR9JBfJtUY5CmEjyXqNHyw3iotNQLIysI8Mk7Lqk89Jm4MZyLeMBTYl0w
 BhwdO28+hRrCJX2Dl0DqkFhX35f6+3ksghNRfnVPckCX3UERTiirc1HpHqXFi6pmuF/OMZ6B4RX
 WBEx36lEybNaojqcAfRt7OqCt/rfhdXf/EyaCWvabv0UjLJyDvJOhw2rvTtlRhaOwAfEbn1eGMj
 +yGAxAjyuE3ZnAtfA5KWgUbKDZT0Y7OU+NBoV/zB0/0DXH0BgcYLWLuJHXOUAm5EIDZf08FcP29
 3j5GRMz6QOundnqmmw==
X-Received: by 2002:a05:6214:2f8e:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6df9b1b9147mr67998876d6.10.1736360130571; 
 Wed, 08 Jan 2025 10:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExpysP6RFMIZSoSaLSFcGanJOgOyYFPSsQVbXNijJRLBuZbnfLiofuktNVe/ZlTyv7nYGQeQ==
X-Received: by 2002:a05:6214:2f8e:b0:6d8:9c92:654a with SMTP id
 6a1803df08f44-6df9b1b9147mr67998306d6.10.1736360130286; 
 Wed, 08 Jan 2025 10:15:30 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea6a8sm193656226d6.17.2025.01.08.10.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:15:29 -0800 (PST)
Date: Wed, 8 Jan 2025 13:15:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v6 2/2] memory: Do not create circular reference with
 subregion
Message-ID: <Z37AvqZB5zrpoB_j@x1n>
References: <20250105-san-v6-0-11fc859b99b7@daynix.com>
 <20250105-san-v6-2-11fc859b99b7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250105-san-v6-2-11fc859b99b7@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Jan 05, 2025 at 05:56:19PM +0900, Akihiko Odaki wrote:
> memory_region_update_container_subregions() used to call
> memory_region_ref(), which creates a reference to the owner of the
> subregion, on behalf of the owner of the container. This results in a
> circular reference if the subregion and container have the same owner.
> 
> memory_region_ref() creates a reference to the owner instead of the
> memory region to match the lifetime of the owner and memory region. We
> do not need such a hack if the subregion and container have the same
> owner because the owner will be alive as long as the container is.
> Therefore, create a reference to the subregion itself instead ot its
> owner in such a case; the reference to the subregion is still necessary
> to ensure that the subregion gets finalized after the container.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  system/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 78e17e0efa83..16b051249c5f 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2644,7 +2644,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
>  
>      memory_region_transaction_begin();
>  
> -    memory_region_ref(subregion);
> +    object_ref(mr->owner == subregion->owner ?
> +               OBJECT(subregion) : subregion->owner);

Would you mind we make this slightly more readable?  E.g. introduce
memory_region_[un]ref_subregion(), with something like:

memory_region_ref_subregion(MemoryRegion *parent, MemoryRegion *child)
{
        if (parent->owner == child->owner) {
                /*
                 * Avoid possible circular ref on the owner object,
                 * fallback to use MR's own object refcount.
                 */
                object_ref(child);
        } else {
                memory_region_ref(child);
        }
}

So that we at least don't open code memory_region_ref(), meanwhile when
someone wants to grep memory_region_ref* these helpers will be obvious.

> +
>      QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
>          if (subregion->priority >= other->priority) {
>              QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
> @@ -2702,7 +2704,9 @@ void memory_region_del_subregion(MemoryRegion *mr,
>          assert(alias->mapped_via_alias >= 0);
>      }
>      QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
> -    memory_region_unref(subregion);
> +    object_unref(mr->owner == subregion->owner ?
> +                 OBJECT(subregion) : subregion->owner);
> +
>      memory_region_update_pending |= mr->enabled && subregion->enabled;
>      memory_region_transaction_commit();
>  }
> 
> -- 
> 2.47.1
> 

-- 
Peter Xu


