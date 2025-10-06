Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A5FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5md5-0005an-ND; Mon, 06 Oct 2025 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5md1-0005aM-PM
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5mcq-0000YP-Qs
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759762538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGeKpmvGFjAC3L5Ns3QegL+jSbtjh0A4fSppkK/dMHc=;
 b=AFjiOO7LtyLVS1rUdrgCQUnj+UIXlqvsLR1qNumhI/c7vT60+bndckHv6rEETasVSm3oks
 nidcez+SSSeyIhF2x+63tT7QevBh+AZ8BC2QDsb85v1OvdxHJZ4E/rfpwmi2oq0KUlM4bo
 Yuum7Jg/K5AWnzSlzjhdVHKr8uozob8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-bxzGbsgrNtagDUDVKlYh_w-1; Mon, 06 Oct 2025 10:55:36 -0400
X-MC-Unique: bxzGbsgrNtagDUDVKlYh_w-1
X-Mimecast-MFC-AGG-ID: bxzGbsgrNtagDUDVKlYh_w_1759762535
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e44b9779eso18683225e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759762535; x=1760367335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGeKpmvGFjAC3L5Ns3QegL+jSbtjh0A4fSppkK/dMHc=;
 b=GPVebLV/6HEyFoLMzpgUiUkpoTMX+wajDin2XrSyKcNkFoYJhrfibcLYKC1W8Ipl4h
 11xUjIOcq6l41YD2lNfxQRtOOwFTSrf/4Er/oJwg0DhvdKssvzc2QJCCMiSOY82ksGO6
 eJ4FCre2r15gJ6xALwKdAb3qEMdpiofnH4eN3N/nsO+NS8snsT4IFNRU9uTer//JPVz8
 6LI424jSPdCp/XoDlEjega7EtDxPdvAXnS5jjExSCOX1Gl2vBZBrWUBKHz8GPKCoqG6Q
 5UpR9AmYMjVe4xXyBQ5bOt8o74UnI4Kub7kZ6t38EwI0q+BKSTQKHHzDN8jXp3wqMCis
 lyig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2gHtkMsXQhmoH4AXwpQbpr+SoU9TeTUQs/lq+IHC5VycluQdk9axttmsT9gUHkp+HkSo8qzg6jEFC@nongnu.org
X-Gm-Message-State: AOJu0Yy7q0B/ylDiJKftHczbpTi82XN2SeDHAKkKX5rPU8aSKHesxqb2
 PwEYcSaXm3kTTQJYTNdQHd2vZyTyiuBHZnajLvZE2oShpOoyNC56gMEo1DyIEVhiC/kHKeQaCUk
 DBrKHLD0wsUY7htmdwWtDbUIS4hOfmDUC9Sn8EUG+ZYlxAnR+A/s3TfkS
X-Gm-Gg: ASbGncsUucvQj7Tg9uovZ6wCSKYovE/8O1YT/UtuqzF+VoPrjfhedt113hY5y5A246K
 KH+FPBC9E9plsj+toGwPAKVNfDvDT+N6m7oAh/qGDcCVeD8ef6mpM868OOlxJlx8Rlu8GYtMa2X
 jUOzGwnGxbh74S/uYmoR75hxfURpaMHITrQa7lTdqcfNd1lrAqTXXIagWSmb0E3AU9QFMYArNEd
 rPAoIhN4eC4QpGVlV97aCmPiqMI1W/MsWwgKaP/mznjyfn7VSxtTF3VPQizk/gdBpngtBbyAYCC
 zIR9XRN3OTi4ZZY8NR7i8oVztG3T2c+hP9RUgzA=
X-Received: by 2002:a05:600c:4510:b0:46e:4925:c74f with SMTP id
 5b1f17b1804b1-46e7113f7ddmr89109325e9.20.1759762535288; 
 Mon, 06 Oct 2025 07:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeMo01a7RRU9PbpZzBUvuSZ1t8vA55SXbocj/1QYP0Qq6etq1XjgSZl8pKDkMdrq+NQzlhBA==
X-Received: by 2002:a05:600c:4510:b0:46e:4925:c74f with SMTP id
 5b1f17b1804b1-46e7113f7ddmr89109165e9.20.1759762534685; 
 Mon, 06 Oct 2025 07:55:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b86e1sm253870605e9.5.2025.10.06.07.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 07:55:33 -0700 (PDT)
Date: Mon, 6 Oct 2025 10:55:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, farosas@suse.de,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: Re: [PATCH v6 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
Message-ID: <20251006105159-mutt-send-email-mst@kernel.org>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-17-vsementsov@yandex-team.ru>
 <87v7kskvut.fsf@pond.sub.org>
 <20251006092735-mutt-send-email-mst@kernel.org>
 <878qhoksd3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qhoksd3.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 06, 2025 at 04:38:32PM +0200, Markus Armbruster wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Oct 06, 2025 at 03:23:06PM +0200, Markus Armbruster wrote:
> >> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> >> 
> >> > To migrate virtio-net TAP device backend (including open fds) locally,
> >> > user should simply set migration parameter
> >> >
> >> >    backend-transfer = ["virtio-net-tap"]
> >> >
> >> > Why not simple boolean? To simplify migration to further versions,
> >> > when more devices will support backend-transfer migration.
> >> >
> >> > Alternatively, we may add per-device option to disable backend-transfer
> >> > migration, but still:
> >> >
> >> > 1. It's more comfortable to set same capabilities/parameters on both
> >> > source and target QEMU, than care about each device.
> >> >
> >> > 2. To not break the design, that machine-type + device options +
> >> > migration capabilities and parameters are fully define the resulting
> >> > migration stream. We'll break this if add in future more
> >> > backend-transfer support in devices under same backend-transfer=true
> >> > parameter.
> >> >
> >> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> > ---
> >> >  include/qapi/util.h | 17 ++++++++++++++++
> >> >  migration/options.c | 32 ++++++++++++++++++++++++++++++
> >> >  migration/options.h |  2 ++
> >> >  qapi/migration.json | 47 ++++++++++++++++++++++++++++++++++++---------
> >> >  4 files changed, 89 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/include/qapi/util.h b/include/qapi/util.h
> >> > index 29bc4eb865..b953402416 100644
> >> > --- a/include/qapi/util.h
> >> > +++ b/include/qapi/util.h
> >> > @@ -69,4 +69,21 @@ int parse_qapi_name(const char *name, bool complete);
> >> >          _len;                                                       \
> >> >      })
> >> >  
> >> > +/*
> >> > + * For any GenericList @list, return true if it contains specified
> >> > + * element.
> >> > + */
> >> > +#define QAPI_LIST_CONTAINS(list, el)                                \
> >> > +    ({                                                              \
> >> > +        bool _found = false;                                        \
> >> > +        typeof_strip_qual(list) _tail;                              \
> >> > +        for (_tail = list; _tail != NULL; _tail = _tail->next) {    \
> >> > +            if (_tail->value == el) {                               \
> >> > +                _found = true;                                      \
> >> > +                break;                                              \
> >> > +            }                                                       \
> >> > +        }                                                           \
> >> > +        _found;                                                     \
> >> > +    })
> >> > +
> >> 
> >> Not a fan of lengthy macros.
> >> 
> >> There's a single use below: migrate_virtio_net_tap().  I can't see
> >> potential uses for such a search in existing code.
> >
> > However, QAPI_LIST_FOR_EACH can potentially be used to implement
> > QAPI_LIST_LENGTH.
> >
> > #define QAPI_LIST_FOR_EACH(list, tail)                    \
> >         for (tail = list; tail != NULL; tail = tail->next)
> >
> > and
> >
> > #define QAPI_LIST_LENGTH(list)                                      \
> >     ({                                                              \
> >         size_t _len = 0;                                            \
> >         typeof_strip_qual(list) _tail;                              \
> >         QAPI_LIST_FOR_EACH(list, tail) {                            \
> >             _len++;                                                 \
> >         }                                                           \
> >         _len;                                                       \
> >     })
> 
> Yes, but would QAPI_LIST_FOR_EACH be better than the straightfoward &
> simple for-loop?
> 
> [...]

Well I don't really remember off hand how QAPI lists work so for me I'd
have to otherwise go read the code to check this is the right way to
walk this list.

Which reminds me, why are these custom like this and not just QLIST?


-- 
MST


