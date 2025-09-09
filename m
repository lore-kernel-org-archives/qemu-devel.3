Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE795CA1016
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 00:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvlvZ-0006kr-3M; Mon, 08 Sep 2025 20:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvlvX-0006k4-0j
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 20:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uvlvT-0005cs-66
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 20:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757376571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RqK5M8ZFfagXaizrMyULzZoJgahY2Gby2TYMMHPahNg=;
 b=Qhuq5eO9GlBcvDkwuypSeHHtPr4Qlf3YoSFPHys//XlBtvXgZ8UCpwhkEO5ieEsTDTtxyU
 PYoz5V6MBrzvwIV6K1nqdcVLDuJQHib9oo7Cu0mZGeS0JXXlWVyTQrCSdaCVhM2zFSnt9r
 fS25/0fzaMhi6kJ7fGYgXXcZHHOM2oE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-T9wwrH2jPxipb2xTfbc9SQ-1; Mon, 08 Sep 2025 20:09:30 -0400
X-MC-Unique: T9wwrH2jPxipb2xTfbc9SQ-1
X-Mimecast-MFC-AGG-ID: T9wwrH2jPxipb2xTfbc9SQ_1757376570
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8080713fa17so1085944885a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 17:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757376570; x=1757981370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqK5M8ZFfagXaizrMyULzZoJgahY2Gby2TYMMHPahNg=;
 b=w6PV9QOayGhG1P/vk7zfutzBZacFbnQV2x+SvY8soNtBX3ThaDHtgIdCEo/RqAYvM9
 w3V1a4nLQoHzd2TP2jXKICRdHXwjX67XRqNBruDVOhnOtY67WEJ9RGP+mBcyPOLM7sAj
 bUggaZotLBvHVvOOT/U/8OnITdh+JjNRdJwc4BYY0fgpAoBSaNfJLij2J1U5u9yz5oxK
 Q7CoE35rn9C1uSBophTsfsngSJvvHoje/dfnEJUrwBXzxe9OOcNqNfu9Cxaxr/+kEkh3
 F25vj/5Cbx9iRhKIP0Yi2A2JXHgBvdJH8q+gqUtf2k/5dGOwsVzTk62K/+ElWMUPKjuj
 dnRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXwmlL2oVObPq2pDXF0JG2EhQNYD3LZ3NlVAuDAql+5+V4B2qTgoYwnb90zx4V4nzjBRtgVhUZgAzj@nongnu.org
X-Gm-Message-State: AOJu0YxTdOuzmIRUn6g2rMN6zpWTc8a9FmpWWemagrogyiZ9PA3t2XH4
 wSdG+FEXK9r8HDDE3W6YB4w7cpzTfm3sm0lUoHvd+iWiuRJ3o/Gpch64kLt5bcAXK1swpx7Tp/b
 aIVU0ie2YUz9t2c0NjEPojQpuMwpiAQ0vPmT7Lww/YanwfjW9/pCTX1OZ
X-Gm-Gg: ASbGnctMLoe5BPJmcIaupqkWCio4/YzDx12IN1z9eUCkatJFyPEEtIJ4ygImnVUZljX
 wRB+5bWiwy1SlQ+zwnrAxKkr/CXEalX5xV5dMhtX95v/J6RnnxrBAQBkKYS20R/H4lukqDUn6Em
 tc2xOdQKJC/AzEdWujBrfj0fb39FF0sjlDXVYYIMvztW0ortv/+fvsZWkd5fIbRMYrUK3RNk4DD
 uXNAyDSWUjNIn6FrqA+GBOx86s0mnT7wwPlTnWvJB50YdT97D5XuE7ubsRq6onEHWGWspToPx8J
 PJtSwmMGVTQV9A+qmIFOy+nyr+agvVkvs8r07xrIgWe2mBTvMRH/DQ5Sa53eRoqkkN7+g+gqo+9
 S8agk1DDkJmNqu3BHydqnxA==
X-Received: by 2002:a05:620a:6cca:b0:809:8ef7:8546 with SMTP id
 af79cd13be357-813c39a1990mr1289671985a.75.1757376569905; 
 Mon, 08 Sep 2025 17:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzYTWJThWfB8Fq2Dz2Cs3pBcmAdDQwsZS4xI8X9GzOOgs1bTmHk7ojvBW7JszUwK//Mu+3bA==
X-Received: by 2002:a05:620a:6cca:b0:809:8ef7:8546 with SMTP id
 af79cd13be357-813c39a1990mr1289668185a.75.1757376569427; 
 Mon, 08 Sep 2025 17:09:29 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b58c54d9asm29889985a.1.2025.09.08.17.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 17:09:28 -0700 (PDT)
Date: Mon, 8 Sep 2025 20:09:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 05/10] util: drop qemu_socket_try_set_nonblock()
Message-ID: <aL9wNo_fLNHERRJ3@x1.local>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903094411.1029449-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:44:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Now we can use qemu_set_blocking() in these cases.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


