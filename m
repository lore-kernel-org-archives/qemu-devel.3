Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03184FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDLB-0008Vf-Rl; Wed, 29 Apr 2026 18:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIDL8-0008Qq-II
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIDL6-0004W1-Er
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777501501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPj6dPFBLNuybl3WQ0+pZciHgSjWDD5e5ordoa+G8QE=;
 b=ASI6zCwO1KgP2mhUR5GR8P3v0SGYCwS7/sUwPPP24OlHZNKJo5TrZG0nfdyKBAd1xLa3nE
 a0hLcXjWIN+N0VLunJwe8xKJnqYOAmip1KB+MNPkVNicGJiRREQ087GiLrKfszx1pgYdvD
 CM7J/YcgAdO/grSsIxfcM1xdUsiqSVE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-WZne_vlNPEq2ERdHGJZDjA-1; Wed, 29 Apr 2026 18:25:00 -0400
X-MC-Unique: WZne_vlNPEq2ERdHGJZDjA-1
X-Mimecast-MFC-AGG-ID: WZne_vlNPEq2ERdHGJZDjA_1777501500
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb9f8bbbb3so430137185a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777501500; x=1778106300; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rPj6dPFBLNuybl3WQ0+pZciHgSjWDD5e5ordoa+G8QE=;
 b=FUb9PlXZWYZJowFz1GXLZ5JT2wy8iq5S2UWJFV82YicNfv5zU4OcRiyttJWa0deNaH
 AHvedANA2o0piSikknLKHBYBclar3/2GjRZahjxl1SORjgeu8S4/Udu3+ceTzjPmpVMV
 ziXk6s1BsVTO9FhvFplY4aRwdjYXzJv22YlRGdvwlk6aUJmPdzJSjZ48kJXVp9kgpHI6
 yUpS/VfMZKHh59ZqlWFSsAjCWoLwRutHIBepnUn7NhIr0Vg278S5pJjf1tJNH/X4YbP5
 OKPL/d6S/h0iPQv/C3/u3OttvBk22RKeKvCEZPt1dPUFHuK3piSI5zsNexVyM6xB09hO
 KSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501500; x=1778106300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPj6dPFBLNuybl3WQ0+pZciHgSjWDD5e5ordoa+G8QE=;
 b=njHK9V6FvkqNSS+OEF+1rdGNSegFxCtwjBMPhRZEnGrHqb3OyduXNkRBbaMmOrIsAx
 hCz4oGA/XlpGmZJ7qUxQNP256BV6rpw67AK3XjbooYXTwuk1C+gi0RAkilG0baA7nVvv
 d/eOfrRiXgmHkzd36YTvUIlGCjA+duUq+KQjWG+2zFoLJCQNgXbv3/Fz4DSgnHUcHJZw
 wuxUAB03rJts/fxSG5CXtZnP/JMJIqIF2dRy28w4ONANN5m7ZJ+2HmOi8cEHnGlMBsYF
 RwSrVooqBjBsiTJD87SRi5rNmadMf1nr1zu3iPuScXcCQOJlw4KV1nLe17uFJxibrSeL
 ktkw==
X-Gm-Message-State: AOJu0YwSFSnKhhWInFtpk2r8GHXKDBbpqDPHAkeBjTGK9RCxvx0Vc1iB
 27pvAB1iJro1K5V/wfnBWM4PCdZ/qjya9OV8UrzmfU8MoRW3HRyv4d/YXSxHXKoD2dXmmITgmn6
 iGzQEl72UdqE9WEsCQzN1T4J1qrokucJrwiF+lGDktjfkawyuvflpateS
X-Gm-Gg: AeBDievuwnzgEaC+1nk5p6x0ZwW2vIsEMjnGOkeabknfM0GoKeZcpEBe2hO0ANu+UK8
 FuYtOdUzAEPYAdmv0Sg/u9BS0ELzDHTI3RJcR1kgCxTaH2Aad6+LYNVefC2KckXLzGdUvaxZzK4
 pYPWtBVQqyEcHL2ZXYW+ktld2StS2qfUbeprVWKEQc1vWp/IFsOcjbjqUhIm6mUkUjc7R7/LdNQ
 G9LZ9FEsQkE6tR3IDa4or7penEJxh2x/4iWPe3pgGDEV4PMx4AF/8s2sYABrcaIRYe988D+sHJB
 Uq1j0b4PHvTRiLRyAyaWg4tzsLRquIYPJgYXioD9rLbHNwDAh/N3EhkwAjrIc2eZCP1UnFaKKCm
 o+xwy+wFhyXj2n45zS0IdLsas0EqXDjRu8tmSI276NIt6/9ZyA/QVixAK2A==
X-Received: by 2002:a05:620a:1a10:b0:8eb:605f:6cd3 with SMTP id
 af79cd13be357-8f919a50ca7mr663892585a.39.1777501499693; 
 Wed, 29 Apr 2026 15:24:59 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:8eb:605f:6cd3 with SMTP id
 af79cd13be357-8f919a50ca7mr663888285a.39.1777501499137; 
 Wed, 29 Apr 2026 15:24:59 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93cffa5afsm289220585a.18.2026.04.29.15.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:24:58 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:24:57 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 12/41] RFC net/colo-compare: guard finalize against
 uninitialized state
Message-ID: <afKFOdYcwXuHYJKH@x1.local>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-12-c413f3605311@redhat.com>
 <afJw9Pz0alpWvRdd@x1.local>
 <CAJ+F1CLUKC=m2WmWj+LYk-YUY3687FCEd7ddV9TrmoKfvLN5UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CLUKC=m2WmWj+LYk-YUY3687FCEd7ddV9TrmoKfvLN5UA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 30, 2026 at 01:09:09AM +0400, Marc-André Lureau wrote:
> Yes, I have mixed feelings. On one hand, I'd rather have clean up code
> for each field that doesn't depend on some extra state that can also
> change meaning Otoh, I like the simplicity of your earlier patch too.
> I'd say take what you prefer, you are the maintainer here :)

I'm not. :)

$ ./scripts/get_maintainer.pl -f net/colo-compare.c
Zhang Chen <zhangckid@gmail.com> (supporter:COLO Proxy)
Li Zhijian <lizhijian@fujitsu.com> (supporter:COLO Proxy)
Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
qemu-devel@nongnu.org (open list:All patches CC here)

No strong feelings. I have a slight preference, but either way is fine by
me. In case you prefer the current one, feel free to still take:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks for looking into all these.

-- 
Peter Xu


