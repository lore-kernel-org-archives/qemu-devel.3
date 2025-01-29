Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F911C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 18:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdCi7-000137-N2; Wed, 29 Jan 2025 13:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdCi6-00012l-Eo
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdCi4-0001Sc-DG
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738174962;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tb+VxBeVRP1K3YKLK5zyLRggcJ7gBLmy1svQpdOeFzs=;
 b=dY/U4/X/tJQkIAJTg0IdQ4QrJkqllSiH+DXM3ITQP5Dz2+Ww0ciVzxCUbWLpEXpoasG1NK
 /mcBdJjvubbHbKwC7JsZfzrk0MTsLMmtOezGIZE7//NQHIRruWE5YV/Mc1pPx9RxoP85Bp
 bNmhnJNnWttU2umRmKgn+jnRH8Sc1aE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-_b2tt9HgOFemHt50RCg8og-1; Wed, 29 Jan 2025 13:22:41 -0500
X-MC-Unique: _b2tt9HgOFemHt50RCg8og-1
X-Mimecast-MFC-AGG-ID: _b2tt9HgOFemHt50RCg8og
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43651b1ba8aso49400375e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 10:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738174960; x=1738779760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tb+VxBeVRP1K3YKLK5zyLRggcJ7gBLmy1svQpdOeFzs=;
 b=LJ5pNhJPg1/55rXmUQ2YqScVU50bWg/0HuCiAmMYOKyfSuMEpLPGzsGrH5LFqTrivO
 8+Zzx3zse2ghW3/G5Na0Ycw0PQMY+xdhwfp85gq0QReUofapfXmaooRcvNirNuvXwMvT
 +PHX7y2GkdW2w2riL1TxomYsfHRAy1weRRxmYAZm3K0OJT/2KRB/vMWJ2A9vfoyasUDW
 r5KH0taex3ZFMHjJ3acBYx8AevSgMYzBbausPyJjYa5u/tyToSp0RPbf/VRxKBg7nl2N
 QknIzqljek4NxDvoRm9UFylV045sQhayySVbzwA/Mzasv7PFyQWyeGU+U3iTlBYHNomD
 Aobw==
X-Gm-Message-State: AOJu0Yzh0raUhF5ww3zAHct4K/ZXv1BQagHvB9PJtBoDy5Nv1DOnhtoz
 1pNr4DLwvDLD0rHEHu64fQGi7zwtu3p/zdaotnNBC53a7LnwhmytpD1SSIawm7Rfm//Q1Z9y+CI
 +hLRBlqeQCXOhtGwk3ELQwCZpj34lIxJlWAymyaTz4Yum07pnDm0Q
X-Gm-Gg: ASbGncsHcCKkHKG90mwV5COc/0CAuPKk5BnfRl9fz+OAV8B2emB7rYpko7n8TyyA5Gt
 je48ykTYKKju5LZrSVPaxJQ2KTCoZyO0UwQFLZbMRRjCNQrxS1JZzwphan34xbpeh/fydxuO3ZA
 LMSUhW7ylp85UpGFcSfmZpUzJhhPw/xcxPovur3bRAIIvhVGkAE/2/7u2TtZOHx0pqZNrl8NC8v
 7CD0F19ynkTHcLws1e0LPSnqwCOe7bn62zI4qBWpf5UNOS2H5dgj27/MPQDs8LeUgfFBk4zQcOf
 qHYlfOf7UOJkrjqOHbqfqo8LIgtmzLINaDysugo8rSthHdav+vsp
X-Received: by 2002:a05:600c:870a:b0:434:fff1:1ade with SMTP id
 5b1f17b1804b1-438dc3cb7c8mr36918485e9.13.1738174959798; 
 Wed, 29 Jan 2025 10:22:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5VhkkZiV2lRgWqEJYJyPx9Bqk4nthUGv5Qq1Fa5em4KoUN1ZO6DmVWt2yMRMiuW+ZVa3EAw==
X-Received: by 2002:a05:600c:870a:b0:434:fff1:1ade with SMTP id
 5b1f17b1804b1-438dc3cb7c8mr36918305e9.13.1738174959493; 
 Wed, 29 Jan 2025 10:22:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11ae6sm31783085e9.6.2025.01.29.10.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 10:22:38 -0800 (PST)
Message-ID: <5298fb54-1bcf-4871-9272-d5d1ec99830c@redhat.com>
Date: Wed, 29 Jan 2025 19:22:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Cedric Le Goater <clegoate@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <79e908f3-3f93-4245-9e5e-25b8a1026322@redhat.com> <Z5KDC4RiimTBmb-g@x1n>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z5KDC4RiimTBmb-g@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Peter,

On 1/23/25 6:57 PM, Peter Xu wrote:
> On Thu, Jan 23, 2025 at 10:16:23AM +0100, Eric Auger wrote:
>> I haven't seen any follow-up on this series. Is anyone still looking at
>> this issue? Peter gave some guidance about the way to rework the reset
>> chain. Is it still up to date?
> I didn't continue looking at this issue since that time (and also stopped
> working on vIOMMU stuff).  No plan to continue from my side..  I suppose
> nobody else has either, or I should have got some email like this. :)
>
> It may not be uptodate indeed, so may worth rechecking its validity.

thanks for the update. I will try to pursue the efforts then

Eric
>
> Thanks,
>


