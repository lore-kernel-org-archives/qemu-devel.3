Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A663BEC1113
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZsU-0005mi-Tr; Mon, 23 Feb 2026 12:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuZsS-0005lv-E7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:37:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuZsP-0007XV-CF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771868264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RB6w5qBp9bxCdc9Z/nzSE6UzRNqy37VnyUtnjmBblA=;
 b=YekJmjIhPgq/8pZVXIF1m5Vznm1YEBPDJqBXgb6dgVYIoidenLFr8Kjhfpa0ae6+9x0HFg
 +mm/9zQDfqPMb0QhD5NlswTXa4FM3aUcN34HvwDCI27pzIZOupXoM2YA7cDHc+piSSnKRb
 BtuGn7qk97PAQSkZdlZm8wsLK1uNTFI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-4OdHyJODPXSDoRaZQL6c7w-1; Mon, 23 Feb 2026 12:37:42 -0500
X-MC-Unique: 4OdHyJODPXSDoRaZQL6c7w-1
X-Mimecast-MFC-AGG-ID: 4OdHyJODPXSDoRaZQL6c7w_1771868261
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-896fa0fcf27so610347416d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771868261; x=1772473061; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2RB6w5qBp9bxCdc9Z/nzSE6UzRNqy37VnyUtnjmBblA=;
 b=SIB9cEkdWFf+qSuFTx+j3konuFoSBJo324DQ77+p7SQPQGw5pHjc/7kUYsB5PoHuxF
 ZFC1H2gwJSIkubf3DqI7WZCWvcBMkpkJNi4lCTcnItJNaMNev6hp/X8ZV7qllklvQgOx
 NbAm3cpyj/t7Wlseb90oaZwBK1UOqnsLoxOzPKYnyt11jPMN+COCmCm3COnBLgDlASVG
 9vGsEHoiqj4K6SGVw11bg2Lr8XQk3KyjAjuwDpVivHP5dH1KtRk0XuUF6Kls5OxHJ+7Q
 jQuHW8RDrjrqYgJfvGp3FTp2q4Au4aNrAkignoa4LtruSqT0+9hTLUbDYsl9XuIayoVt
 l1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771868261; x=1772473061;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RB6w5qBp9bxCdc9Z/nzSE6UzRNqy37VnyUtnjmBblA=;
 b=g8Y/pEzITqgn/fpuK/puTjjYjkbq1E+AJG2J06eoFqU5ij4sye7BYMfsNJg9dp5Z7o
 l7liV0Z/FTkZAPG3hYJS3BQO9hBwJYwc4OhXgxz74EqLMf+ES6/PtMoJbea0P+ucKeP8
 jjTPOxQ7KVBU9UJySs+o27d+duyZaqsHccl2eRRf9cvDBCoxDqGfdPUBnAMCeJMCDyQm
 QyFL8ib0lPKXHZVm0BZaMfLQUMM6+21UjHY+tVOgLmz0NTOUvdTQadiaTZM6/uGwz7QR
 jaSOYxPUOcKhY40kSaGCsRUBS/MPWOGIpHzXS5hYD9uHVmhy8u3wfFFapKOGhvk4tIMd
 6fSg==
X-Gm-Message-State: AOJu0Ywq7XTYlwLP7Z334wsvzk67BlqCRqTVdtOt1yaHmr4h5kszOfrI
 ysDu19SORGrM3sSZc6HRRvqv6IPas0onwO+BST2EUXI8wKJybDZpK6f8piWGI40kWDtRlM6Ne14
 B4OYQcAJZEXo+10x0TObB4TCQQH8LdXKa5TnpYx9TbS+R4jJ13OmS5ojI
X-Gm-Gg: ATEYQzxOc28zCBwCOLi5xDdexpCCtwKNsYnVYTbr9tqgLxbGzNFbYjE2WWVn4q+8vdX
 Q3UoNExJ3We1rs8OXBGEKk7guOexd01Fubpjp663ekD61ySh7bzPKpC+MiE/yMu5iORkfRKFP/A
 TM2sxjqKqtD5llINKUGK1wl49Kv4KfZxtQAx+GdK8d9QFLLkfBxxyQvBpMI/TFPlqvZbtgWSuis
 Eib7BKPVJKKS8B1t4kGGtQ20m4uJrhXMRvBZjEZO/y3i8G464uiNqK0uFKmi5lZZoDWgY03Y+bi
 SYvGaRyvGGsly8GLOysCU5J7i4KBOIOZ5PuM9lBd0JKvA/1JMuvPqRZ+p+7SK3Tu4gnEnKCS1b0
 RjWqk+Vx7aBmv7w==
X-Received: by 2002:a05:6214:f03:b0:890:8285:e1a3 with SMTP id
 6a1803df08f44-89979f35c62mr140897996d6.63.1771868261090; 
 Mon, 23 Feb 2026 09:37:41 -0800 (PST)
X-Received: by 2002:a05:6214:f03:b0:890:8285:e1a3 with SMTP id
 6a1803df08f44-89979f35c62mr140897456d6.63.1771868260576; 
 Mon, 23 Feb 2026 09:37:40 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997c8adf68sm69016986d6.20.2026.02.23.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:37:40 -0800 (PST)
Date: Mon, 23 Feb 2026 12:37:28 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH 06/10] system/memory: split RamDiscardManager into source
 and manager
Message-ID: <aZyQWOQeKeT5yzIv@x1.local>
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-7-marcandre.lureau@redhat.com>
 <aZdnDrs9ivLctEIj@x1.local>
 <CAMxuvax5uYVr0V3qKFV3t63BLkdqJco5thx23EKggH_dbKsAdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvax5uYVr0V3qKFV3t63BLkdqJco5thx23EKggH_dbKsAdQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 20, 2026 at 09:28:23PM +0100, Marc-André Lureau wrote:
> Do you mean that we could drop replay_populated/replay_discarded from
> the source? I think we could. replay_by_populated_state() already
> handles the aggregation logic by using is_populated() alone. There
> isn't much gain in the above implementation narrowing the iteration
> from the first source replay.

Yes, then we can also get rid of special casing the first source (where we
may invoke other sources' hooks within the 1st source's cb functions), and
the skip_source logics.

Thanks,

-- 
Peter Xu


