Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6425DC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwhv-000870-9q; Mon, 17 Aug 2026 08:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvwhl-00086N-PL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wvwhg-00032y-Mj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786970674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mztjpgg+4NFm8M9u1SpZgGaaU/tEPv5YOuQtv0ot9tQ=;
 b=GXn3jWO6PXtanC4TKvrwzproPjmLeG+bWh8mdVxWafai7ARf1LPG1X6bTlE9mXX/cHpw/D
 w8raxTGmJF72WXEvrgZ5WqLBbvIbyw/o+ZNkBc2kbIGYsJfFlPbFqSeuOMa2rPzlh8SNd/
 pYiqsZm04klYuohLR4EAJjk1R1cNvAE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-g-fRs7RxNcCM10mlFJwnxA-1; Mon, 17 Aug 2026 08:44:32 -0400
X-MC-Unique: g-fRs7RxNcCM10mlFJwnxA-1
X-Mimecast-MFC-AGG-ID: g-fRs7RxNcCM10mlFJwnxA_1786970672
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a0fab609c4so4251908a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786970671; x=1787575471; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mztjpgg+4NFm8M9u1SpZgGaaU/tEPv5YOuQtv0ot9tQ=;
 b=ZdCjTKKRF+xlY4atX3t4V8+WPgQJlnm2sslT5jYoD8T5YyAgFjEakKO7yQdrzwkoWv
 dvHyEhpfxh2hKDrdGdykFOYU6WXR3bkXQ3KzdjdA0sK3MljJWaJKh2lp9sjseHX490gS
 VJ3X0Piir6KeTVdZHCrOa2WPYq3XSgrbZYZn68cCz5v6p8+Z2Eo1Y2qOh3x00a2A+bNW
 4i31EFDTMnUaheTPXTIqr8yB/2VaWmSMgJKzkjSSGOIgzCcklt8O1fK7casPf5+WCh57
 GTrrgsDcsle23CMo7mRVyvwZUlVSpQYAhQDovQdJxjjV4p9dDN3c93gx7P2T+SQljmHQ
 sftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970671; x=1787575471;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mztjpgg+4NFm8M9u1SpZgGaaU/tEPv5YOuQtv0ot9tQ=;
 b=RHS37JY1wbVMQzTaHS5uVaYjOxHqSNL68sz8QBig/QKhlm7YRtH6Pb9VOTWZHwDX6G
 GEZ/lcHIeF2GGpxbpjIHowAbDkAQg7+iRw8BN5UzREs08sYHoasZbjnRWhCbve1EzO8K
 U3//VliKkatHCTfeqQT8yxGIfJQXrl1NBc/EVgTzB9x+lLOUXfGBImOp9G2jsnLeA6qG
 dJbjYqqNBuQjuHYhJqSZrzNfbwFQz2/k+JaGkz/WoYMBRPQcgTkz3YgkPvS2WP6WEnHL
 WilxN00w9ExNnllm6+Jbq7pbucK7305ePCHGj7l9xSHEjE+aPp32Rf+vwo5OqRHzewda
 7G3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7tr6dD0HeR4eGKRlz8g4Cyej4/n4bBj59SUfmsLsIrXxqZv/crsAnxjeoSb326cllbI1F7apIw6bC@nongnu.org
X-Gm-Message-State: AOJu0YyqqkIxqIkWI8WE0JWyBYarvBmB8pttac2NxunQoaF/0ut3apSp
 LIFRXAySr7CCrR+GarMt5AeoU3X7D7/XgeMGU3Svi/lDdHvJwpXOFxQ1ii1mSCo1IMyc5KoEv7y
 9CMWxq11zDbLUI7TF/FwNM+2jaILvhQmf8NlNRPnkCn2ELvZIEi52oHg4
X-Gm-Gg: AR+sD13GuK7HP+xpFn62Rxq3TEc1NkietjuAHYyllk5iKBHzEDjGIVlOIEuNKBwE5qS
 ruzK17B5Ua6kvAKEGqIrTz1KoOEEPTTXC5KB1aRQ0qqaw6omFGkRPxQ6C2LRYftHZvO44McHIbb
 ju28PurTjNIdVzlbo89YQNonDib8QM1xi7S9m+9yjoXBXCd+waPLOQNKNd//aE3tjXeyam4SoUA
 eCV+Z6Y38iQd+Im3Ci4tKsG7L5GLh4/kU0G+L1HqLvadYsIqBtsbXU3ov88FTTgvKnIfsO4ZiJV
 qbyErbWhGAfONLxJ3ids5NSnlJkXaLjIcCEA4hW9ArfAnv5LVNvVnisq2aChNdC05iIF
X-Received: by 2002:a17:906:6a1c:b0:c16:785:cfb6 with SMTP id
 a640c23a62f3a-c212a22b5c8mr1080133066b.3.1786970671504; 
 Mon, 17 Aug 2026 05:44:31 -0700 (PDT)
X-Received: by 2002:a17:906:6a1c:b0:c16:785:cfb6 with SMTP id
 a640c23a62f3a-c212a22b5c8mr1080130966b.3.1786970671083; 
 Mon, 17 Aug 2026 05:44:31 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c217fe69cf4sm54247466b.3.2026.08.17.05.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:44:30 -0700 (PDT)
Date: Mon, 17 Aug 2026 08:44:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Message-ID: <aoMCIYgJcmIbcVeE@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-4-michael.roth@amd.com>
 <cc83a207-c89f-4ec7-864a-db0115c4f641@oss.qualcomm.com>
 <an8Nn5cb52ev4MF2@x1.local>
 <8e376be3-446c-4783-9081-a633ddbc7a74@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e376be3-446c-4783-9081-a633ddbc7a74@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Mon, Aug 17, 2026 at 06:05:45AM +0200, Philippe Mathieu-Daudé wrote:
> I'd rather avoid kvm_enabled() checks in kvm-specific API (accel/kvm/).
> 
> If ram_block_rebind() is KVM-specific, why expose it as RAMBlock API?

I only started to remember why this patch existed.. after this series
applied, kvm_create_guest_memfd() can be invoked from hostmem code, so we
need this patch to fail on old kernels that do not support init shared (old
kernel case, user triggerable).

-- 
Peter Xu


