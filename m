Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoGM-0000xn-0A; Tue, 28 Oct 2025 14:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDoFi-0000GN-D8
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDoFZ-00026y-MK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761675408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnENuPDQaLlrJ0UVxQkXQUiAAOZqFEg8qhARQdruJDg=;
 b=i1qqs+lD/EbuG9qe/KkTpm3jZIW2aoY4MlhUjAviB1EDECYaZVGN6Fa5vz/H90/daoUEsl
 bxsdIasiC+nILlsrEqEOqtf7M6X36/KIsGZQdrBrlGNP4qQ+iv1QJG8ZLyoRUK2W5VfW7b
 zAMW1BYytSYRJxq5i1N9uYUHwAEiY/s=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-3pua95BFPseO6-jBm0Y_4w-1; Tue, 28 Oct 2025 14:16:47 -0400
X-MC-Unique: 3pua95BFPseO6-jBm0Y_4w-1
X-Mimecast-MFC-AGG-ID: 3pua95BFPseO6-jBm0Y_4w_1761675407
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4e8984d8833so288085321cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761675407; x=1762280207;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnENuPDQaLlrJ0UVxQkXQUiAAOZqFEg8qhARQdruJDg=;
 b=wOgeUpfSTJRvsTJO+gpzRVJwmN+JevvdMaOF1AfN7jZYeaRl2+BMvwKOxWZRD9pRSD
 s+MZuI1U7E508Ac3dP98idCOr/orCWoxRY/EdelBO682jQdxT+6HH2dLTlauVo15PdRJ
 xf8gjdW5KwxaXZtOWr8+Snl6PM8/SQt3TjTFDSOJ67LEhYeBVD2zHsVnu+eKEut05jOJ
 n/4DNdf5zRwtF0eaRNzNldd0FzHk0kmKsm9t9i85HTGU+9ZlKV+eW7RDiz48OHin7NQs
 m0n4sMrR4+vY8JJEkBtXwbsnldq2cd9KjmasgG05+C8G7e8hzwYCmEX6mO7SDjT2YndC
 5o4Q==
X-Gm-Message-State: AOJu0Yz64AUAsPuL/E8Q/j3ltQ9WDfxdoA+CgGOou0SV3kPAjrgz98Sq
 dibT9rzunQkXRrvvs71aoRV0EkJriM+zlYsIbASvcQ0WJOULfZ+V0vjTlgvYJlj8agnD3AiAXeW
 gS88de4/DiyPKNJyImcnjgvKvFoEqcVDe3Hrh9w6B0pO+SEplC+1kd9jv
X-Gm-Gg: ASbGncvomjXBgboPQk0e/50syKudQZf1eVxbo7Ob15YGhHjlsM9lh9Cz0ZMItBZCFA/
 jEP+zyjQqPO5eIUfo9UpJRQ4hjb3oxgqb4qSG5deY2eiQVZxzuusmNG+FLPPnl04X9Q62hMN3z/
 nDYaVwpbwqRrbBMXDmom2d0cIkPs9CuVwiG5McXeyx0anWsEoHZC5MvmD+a6wUfQ58TpDF6Lz80
 7Vzj+X1MOAIXtLPlbLdgcgOvbko9m6bvpBLvQGLSypHxCLUG/g7ORyEm3mqsSYcP9Ru5DKLT1Fr
 9epzmuDiC11bY6WMJZE441SEfqy5vHZf5OF7l1kBnDnzLMq4zSwTc5z1p6YdIpsIxBI=
X-Received: by 2002:a05:622a:a6d8:b0:4e8:85e8:801a with SMTP id
 d75a77b69052e-4ed15e5cd0bmr721581cf.40.1761675406808; 
 Tue, 28 Oct 2025 11:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGanjQyxNK9RqpGQ5UgSRLYN3fZuDQYGVxk6TiLkbibmOOZAt55VEdCWH4kB84CJa/tYWMIhQ==
X-Received: by 2002:a05:622a:a6d8:b0:4e8:85e8:801a with SMTP id
 d75a77b69052e-4ed15e5cd0bmr721191cf.40.1761675406372; 
 Tue, 28 Oct 2025 11:16:46 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87fc49e3370sm83479796d6.59.2025.10.28.11.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 11:16:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:16:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 02/13] migration: Properly wait on G_IO_IN when peeking
 messages
Message-ID: <aQEIi6HZCiTeHinJ@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-3-peterx@redhat.com>
 <aPtqvjF7Jw17040Z@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPtqvjF7Jw17040Z@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 24, 2025 at 01:02:06PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 22, 2025 at 03:26:01PM -0400, Peter Xu wrote:
> > migration_channel_read_peek() used to do explicit waits of a short period
> > when peeking message needs retry.  Replace it with explicit polls on the io
> > channel, exactly like what qemu_fill_buffer() does.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks both for the fast reviews. I queued patches 1-2 in advance for 10.2.

-- 
Peter Xu


