Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A04AC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMYA-0003Ht-PW; Tue, 04 Feb 2025 12:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMY5-0003HF-Uu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMY4-0000nR-5q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738689438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EF1aKWjXDK0s5pYyzWzruFk/aZgJr2WHBwIj97Q+fRI=;
 b=dakgxZct6GCy2TMu6IxGNZ3EOtqWefItqnpmo5wKd2rBqsWzewkwjrPh9cWKj0ufy7zx7W
 Z/6parEVZBcAvnE4Volzvaa3j3x9oE41MCIEB5rc4EFwCt/0jAhW6GNN1HDko478i43P31
 +ud4ud98MO1SKj1Rh8/PnDXp/YeBErU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-daST7g10OFeZeZBDp7bZUw-1; Tue, 04 Feb 2025 12:17:15 -0500
X-MC-Unique: daST7g10OFeZeZBDp7bZUw-1
X-Mimecast-MFC-AGG-ID: daST7g10OFeZeZBDp7bZUw
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467bb8aad28so62332161cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738689435; x=1739294235;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EF1aKWjXDK0s5pYyzWzruFk/aZgJr2WHBwIj97Q+fRI=;
 b=RoNJIjMfr7goSMs2aPFiI2uiUqZVjVRq8A7WGnfMnVoc162u7kGFNe8Jxr21uYN0jo
 ICqXtzxPKqQf+ehGRZclePCMQICGrVzA+xCZvz89QrFk5+e+hIqYgdhrAVYgDEuyhnHW
 MF3eS4ykOxRrTab9DMEOnOMDAF+3Ufsrk79+FKzgkRwmGfc2Trs1cI7NX7bEr9v2mQ2Z
 RNnmmpmDsEkomWCsModo6lPQPJHvPyWz8Hac0ovHeFUG4AFIDVZWJe2bN/KYsvzUxZiG
 0FxsX01S5m8KIyAP3L8xv0qb2fal0BSATSBlIMENoi7NuGBX1MnHUKGpHvIBQxpjd6ij
 08hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXmDO4UEsJJHHyoXRsDMkbourIsDXnxd9IDBX2/RHq0+1/oElX8i6ZwfWjkgCyOhLvozEAd1sOStP3@nongnu.org
X-Gm-Message-State: AOJu0YxgLsLa6MkLTCE4tlKZJk0sjdvoiAsU5/WW7Nj6ABa+iFrlARui
 7FVlubBZww0CWNZcsMTD8kPT9W/v45+zb6+808neZP9kwitjN9g2bxK0qoLIVTPcHEBgUiqzxfG
 f5qLSqZssIbiIS2HZ+C6Kv0Qj5aMZhDCgw1FfwYwZceHI9+YcJ75J
X-Gm-Gg: ASbGncspQGF+etd6OOQERdplsKIb3d9TFIPpeu6YDg0mNCRwG/vXfaIfzbp4d+aVdz8
 tmQVVFHX8d4O8wDz6DCFLr1Hd52fBm+pysBgSTVEvEVCvZJoLC2hyjmIS/iKUW+0XHlDno1g354
 gxO14KZSmDqzqX2joWviF5JgqQgu1mW+5oKJ7N5c64IQ1BuHNXBrJOFKMuUzcHPtCrITRZjxEag
 gWDH31y5doDqwNW0ySzZFbYfz5NiYZteJ/OdkPoAMZaJPT04HVIWrgOZ8dearX+gL/fhUG6txia
 i9ez94+bT3cdJGt28RfUjp2fOgqUD5o7hNCirHQ1lzDDO5Du
X-Received: by 2002:a05:622a:1a0d:b0:46e:548f:ab8d with SMTP id
 d75a77b69052e-46fd0b68d36mr371888551cf.37.1738689435393; 
 Tue, 04 Feb 2025 09:17:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMZrkvUzANp+Vtn32tNv8gwb9qdGA0LKFSlOhffU2oEyMLz/aqkDnaQy98hKUID+Nqtbqa3w==
X-Received: by 2002:a05:622a:1a0d:b0:46e:548f:ab8d with SMTP id
 d75a77b69052e-46fd0b68d36mr371888011cf.37.1738689434987; 
 Tue, 04 Feb 2025 09:17:14 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0c90d2sm60982721cf.28.2025.02.04.09.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:17:14 -0800 (PST)
Date: Tue, 4 Feb 2025 12:17:12 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 4/6] numa: Introduce and use ram_block_notify_remap()
Message-ID: <Z6JLmG8srpk9_3Jn@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-5-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201095726.3768796-5-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 01, 2025 at 09:57:24AM +0000, “William Roche wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Notify registered listeners about the remap at the end of
> qemu_ram_remap() so e.g., a memory backend can re-apply its
> settings correctly.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: William Roche <william.roche@oracle.com>

IIUC logically speaking we don't need a global remap notifier - here a
per-ramblock notifier looks more reasonable, like RAMBlock.resized().
It'll change the notify path from O(N**2) to O(N).  After all, backend1's
notifier won't care other ramblock's remap() events but only itself's.

It's not a huge deal as I expect we don't have a huge amount of ramblocks,
but looks like this series will miss the recent pull anyway..  so let me
comment as so on this one for consideration when respin.

We could also merge partial of the series to fix hugetlb poisoning first,
as this one looks like can be separately done too.

Thanks,

-- 
Peter Xu


