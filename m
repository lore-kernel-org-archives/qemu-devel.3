Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913EDCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 21:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSiKj-0007cu-66; Thu, 28 May 2026 17:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiKH-0007Tf-Dp
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSiKF-0003tM-4k
 for qemu-devel@nongnu.org; Thu, 28 May 2026 17:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780003894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tWcDsQIvH7c520FFWbwC4f4nsmnBdtgZ8M3dmHBsENw=;
 b=TAQlZnzHJVXZemexbDJonf+ApSlB/aGCNC4s09OQJhF/GyapY0fqQJnc3XgSaudsQWA5qG
 WDPJv2CJSOx+10Z61Sq+JYygBWwU3mBw6MzveigAbumyYyPXR7AbZcUbwuymGBb/4oKCmm
 N4OLqOWNJTZdTbsuA0kgmIlnoHL8rQc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-OSI4HOOWMW-325oGeaDCxw-1; Thu, 28 May 2026 17:31:32 -0400
X-MC-Unique: OSI4HOOWMW-325oGeaDCxw-1
X-Mimecast-MFC-AGG-ID: OSI4HOOWMW-325oGeaDCxw_1780003892
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d51ffb59so64371151cf.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780003892; x=1780608692; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tWcDsQIvH7c520FFWbwC4f4nsmnBdtgZ8M3dmHBsENw=;
 b=adO/ayakxGs90UetCW28cWkiCrkF3uj4d3a04t1Rp9ECxzkNs7HF77qGd5C777tV1G
 quSTI3gbmE4vdi6CMusxIx4wX72B8+WvnTFRfJla1lX3iuFk62qbk3Rp+BkVEFp1Xoe6
 msNhbt3xBy9+WKx2ceOeOGOfiuUFU02SFoU+hXQHcp/2Gww6UKoOAjCjOuEVsomru0xs
 CFHVYSOgK+fXhCohxfWy1DzO2y+qA6dp+BYnv5kB4OEL1H/QWV11Dl4t8Aj7r7UO3BNo
 G+IXSLV7JmMK4AwGpQfvmc3SNxRSucMYWUstgZ6pxIsIaDLmiRGkvRWAx+G+4SMo0GOa
 e31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780003892; x=1780608692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWcDsQIvH7c520FFWbwC4f4nsmnBdtgZ8M3dmHBsENw=;
 b=SlNF6nnkZPLMjT9JLIOxP4Qb0IRH4BIqnBPkcjWYT3iXIv4FIWK95WnxW5OS4QwVmj
 FMpg1VD7B7CvRLDwjV21Ti5EmYvmaocgK+v1pAkk2L+Oyw1QpTzjUMlZhKWal8+q3MVw
 QsaCJ3LKWPVwKG0o7wrIFntSon61J/J5nWyCXjgrip+XMCOdPDRtVbGmZqOfLznrmJK2
 DTJB0V9K75pw5LAlQFuh9FhyzrTDAvFeIGbD1I488Ed1vf+zxiNgb9t0OBUVc7YJYz7M
 UEEDxMF/SYzu9Zak28I8o4ZO9T7SXU6myrjVyRwFrBASL0gf7OA0s8CosNPKtm8rXO1g
 Rwxg==
X-Gm-Message-State: AOJu0YycNdN+ZhnXdIRdiYtRQ+xgENTULpjGZN3KZ3nLcD1/AWWCHfdo
 R9ainQzBj8tWkVpoD/KHsXGrwYdNzWMTGp6oMzKgot+sLT/VUF5idm1GlemZ0y687atv/r1dmuN
 C112itRhOy1RpcB3/8d8fEInOqC5mxIvJz4zFvNuIdtH4gtrORj+Etcny+73wLtKkmHFNP8uqzh
 d9g5VERuKveIJiSFloL4lNp1ucPKBWQFgIR2dU7Q==
X-Gm-Gg: Acq92OEJs0A3VSHrjwoIZK7Qosjnek2hUXxmv+1SdWBKTT/dODwzy+M26sGOHWtxj67
 XrDSwd3XPbKWE/th4vbZ3AkCrDGppTyzlUdPqEEUpL3H1mGOg4xw/np5orvqfsfhqCXyk0pTSEH
 B6ZdILYI4H+6q5e7e5g72d0nVnLCNWWPlGOginnoMGuctalkifH4B6OFqY7F9skcKi77EDGvXwd
 IFDkgv3X66NB82yZ/UcfC8YHpZMDkkRgTujzTT2Gf63Du/qKKKzUZwg/PPlxcYcH31hOTtt7bJD
 ywTDvgXv6tPpmuF/ayan9qHpLNLnJRPF/+Flkti6eNhi5BfLYttrtIXBRCdn9mVgFCrwF/nD9h9
 hSEQoA5G9b1FRFswfoTB05yRgN9wm7SNmqvXltmmdu4yaMtRFmKIVmX1ZcA==
X-Received: by 2002:a05:622a:1912:b0:50d:8389:c3f3 with SMTP id
 d75a77b69052e-5172dda23e3mr2706721cf.54.1780003891972; 
 Thu, 28 May 2026 14:31:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1912:b0:50d:8389:c3f3 with SMTP id
 d75a77b69052e-5172dda23e3mr2706051cf.54.1780003891479; 
 Thu, 28 May 2026 14:31:31 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706af131dsm85098131cf.21.2026.05.28.14.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:31:31 -0700 (PDT)
Date: Thu, 28 May 2026 17:31:27 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH v2 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <ahi0Lw4sruGnLFje@x1.local>
References: <20260528212912.367967-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260528212912.367967-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

This should have RFC tag, and shouldn't be v2...  please ignore, sorry.

-- 
Peter Xu


