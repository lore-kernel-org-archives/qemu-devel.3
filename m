Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10BCCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWOl-0005PK-IU; Wed, 07 Oct 2026 14:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEWOj-0005Ou-Sl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEWOh-0000dq-5h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791397786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A8G5P/uxKE+r6g9rv5CbEuE6xzzXVMy7d29dniRWfK4=;
 b=eZDHHtRysvwyf46KAB/xQ1MSC1pXpW6qox2z6bFc3aw7QivEJUNa3fHo/lI3qDSJOlh8Jz
 +5uHU90LmlA7osdHTF4tjjly2hkfcrx4IbBiKGm7UvZZPoVlb1c1R31qAfdnof+8USkOME
 DXnCsLSjWDUERwJzKfrBUkwAs9nvKiA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-AUgNL5N2O0KMvld_1qRvvg-1; Wed, 07 Oct 2026 14:29:44 -0400
X-MC-Unique: AUgNL5N2O0KMvld_1qRvvg-1
X-Mimecast-MFC-AGG-ID: AUgNL5N2O0KMvld_1qRvvg_1791397784
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so762685485a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791397784; x=1792002584; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A8G5P/uxKE+r6g9rv5CbEuE6xzzXVMy7d29dniRWfK4=;
 b=Mbxr6SBXvIlAz8ZuO3ObN+DjO2mfgQL3H39KhnFT1LE5RQYCYJOzMCcU+EAx6GQB6t
 unb0j3uh4oaCnFfffmF3XT41MZa4QSmQpaw4M/0SCW+T2vmmzATu4CmmynTqxlk3P2um
 cFLsQMtrSwPhM7aRN/ejPUTFiGUFC1WO7byjaQ/fhdvwrmeyyV1Z8xNTlZdZ9X6GEt7v
 /k6dhE20gOHwV5NYtEQfTIWbXtclsC+pOHoJOVW34++3bvfQkUteTLSWwbMCoH4SCzbH
 Jhm8EQ8o7zgb5TixZjJ1KyIoD/VDX72iWVW33csfxFgF8CpohiA26ZRtHzr0t8uO2xJx
 k3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397784; x=1792002584;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A8G5P/uxKE+r6g9rv5CbEuE6xzzXVMy7d29dniRWfK4=;
 b=qzMUAR75t7u7U/zUWHE0Q+sCH75T1xVxfvZ9gwuiaxRzlHpjAWsLEZ0wWSJCWC+rnp
 Tn90i7WpRNJTEOUuygAwPTpiwC5AsVXRk5ZCLqXJZqfuutQgv6SMBKojuAnigeyb4O/e
 Y3dsbSK06OJSsHhfRcRku5sKnLgWFbly2TPYmPaTs2vKWFRO1sCf2KwJHmKrGYqaHCcR
 GEt+D5Nr/kGjQz+HDLMFeceVJ/Z0n6lwkOF47VcMYQJhnK+5S+qY0vxysWo6vwB7g0ge
 sZYKlpAr4TFt8XNcSE+cB5vJcT2AmqSeHCYsE9Ezioxt79kcELAjmEfy5JjNnrJ+QG/S
 XSFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW7JL0x9J0XGskFrqANJjdCFk7vR95VrSTyWYv4MBTC6qntkBRhhlyYYGik+kzAdgAJvSW1VHtnHAt@nongnu.org
X-Gm-Message-State: AFuF++n01AayaM+O7ZmRA+waeNpvxXnQZfqyucMVx6imWYWOZvIj4cKg
 wyjR49VyuO6duA1CxOOlHqoBItj2w63YHDV96c1zEr3ONnNIRx3Cgb0ERpDuJaxlde4Nsm7G3VY
 jsUaTxhST9Fg12D+y3PTEknUF52htSqO6py13faM70tKahkHaCpBAgmXp
X-Gm-Gg: AYBFou0hNXz/pfCVMIZWLpqnsnzNTpF/zggigD3NNv5ybC4OspR0a7S+igPdRX738U6
 cyKWXFHMNiJe1gT0qU2T+tErXRWxbsR6xaaQnsZuF61rRKSyBGUdc/CR2PGkP9yPW6ndtCZ3/cS
 uqT+yOxcVDr0RFs+b4fQH4trtGkEtDW98PzGpispa4KxcGlDFL5ngqJkpSjDx+SQdIoR/1W2p4o
 iAiqBI2ucXKUbLlrK3u4oAB2/8CiuXyYBoV2uJA6Swh3ygv5y4LY/MbZNh2hUu9A7nnCgWKei4w
 EeNf2WQpLbOW9iAHMzEisfo3xCUI1bWUpomKcXlWJWzaeUB4jow4pqdoWCUCmJc28o2xx68=
X-Received: by 2002:a05:620a:1991:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-93e9b80d1bamr622446485a.46.1791397783846; 
 Wed, 07 Oct 2026 11:29:43 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:93c:8881:8df3 with SMTP id
 af79cd13be357-93e9b80d1bamr622438785a.46.1791397783160; 
 Wed, 07 Oct 2026 11:29:43 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9199dd901edsm15371366d6.38.2026.10.07.11.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:29:42 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:29:41 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
Message-ID: <asaPlV0HAyfQm_PS@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
 <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Wed, Oct 07, 2026 at 05:06:57PM +0200, Denis V. Lunev wrote:
> The problem is that we come to this situation with
> OpenStack on top of libvirt and only after that
> we see QEMU, which is just obey rulez from it.
> It is very complex to say how we are able to reach
> this situation in the real life. My problem is that
> this case was not alone and we get a lot of VMs
> died on this update (around 30) when QEMU has rejected
> bind in production.
> 
> QEMU can not control this (command line arrives from
> libvirt) and just dies (almost silently).
> 
> I understand that this is difficult to argue and the
> kludge is not fine, but crashes are unfortunately
> real :(

Understood.

One thing I can think of that we need host-nodes= is when different
backends may be bound to different numa node, but since the current use
case already enabled memcg and looks like it can shift to completely
different numa nodes, it doesn't seem to be the case.

So it looks like a real issue and also looks severe, but it's a matter of
whether it should be fixed in qemu.  If we want to fix it in QEMU, we
should have some solid reasoning.

Thanks,

-- 
Peter Xu


