Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F989CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bR4-0001qC-Qc; Wed, 08 Oct 2025 17:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bQz-0001oZ-UK
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bQh-0000EU-L9
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759957827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZ44dzM1ejvcMkH27a0yMrGed/hrdPmL3DMovwbbDXc=;
 b=TCDqxcoDuMwiL3nqpbcNiKGZL6MaQytWYAeBtU8ppf6r+AWtW6CSc7pXUsIykngrWMPxr3
 p3jK1n49Xam/F3QtKjZH9cFkqvm4XFW0Fxm94auFaYUFj6vj7XGD2ft+oXmzV3oM0b8f2V
 qDBst/00C5IiXiuvviPQWSJgSlv+CCQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-vs6Cu8KjO1KMNYmlpUDqjA-1; Wed, 08 Oct 2025 17:10:25 -0400
X-MC-Unique: vs6Cu8KjO1KMNYmlpUDqjA-1
X-Mimecast-MFC-AGG-ID: vs6Cu8KjO1KMNYmlpUDqjA_1759957825
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78ea15d3583so11723716d6.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957825; x=1760562625;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZ44dzM1ejvcMkH27a0yMrGed/hrdPmL3DMovwbbDXc=;
 b=aqPEEGYiEIJ4rytvLMfrFhjbKvupE3GfVxIySe8t0NZJ9caKAUluNqk172tkWZ8B+V
 EnzIsL+7iWunBKbIyZTCCmSTRSuQcWrNcOtffjTDBKI65zcmAculb4+lHNQgWPiPXGdN
 X76pVnHQwUMS284hbEsOMEkjearY5+uwPuwQkTGA3SzlMIupm/2cGKgvpwVdoqYo4wD2
 z4UKkVxXFQRixHYBRFu3E8v7s4x8mMaSDdFblLTOe8JySHM6PIgxTB2ZkizqMxYWclt2
 9JUfQ8uN5dPr3HoF/XiS87JdXi5GiwMzEYHethg2H9ZM1yvk8pz/JkShLM8fbdvmImMw
 flYQ==
X-Gm-Message-State: AOJu0YxEDh0qF0snOG0IEjtS30f2R+ZmQC0uXPR87wNzu3Q1DYvocIgJ
 S3eySH6rs/Sm0tw4AHzzG+o8WnayVzP2/lGb7a5n4W8FuQSyCndd+fDGmD1LNBJRdMwA4tC/TNQ
 i2OBTR5cpMu5JBokatfcfCAulvnaOP/Xwfc9yjhsfmLTQv5pi2SGpexCR
X-Gm-Gg: ASbGncuCmvGGzaF4atNU2W0FM7O4SIwivaUg9K3CEcdJ05BYcah98zvDfVD6i08nmoh
 TUeUshOaPZ2o+Ih2RJW3X6avF/ZZNbFeXiKS61zxk08vFDrgyKv5gaT5wR7BIq2xGMCKDKdqkdS
 RT99RVUstL9+Wrj/cW7jNsF83yqSbcsUcDoOetXyy6/zg86tOdHCVakhPZIXMKRH/Toz/e9kfgB
 ygHZrI54/qtUR87p8971+oTKiirVGZclniYd/wfVR5EKXhWJz2jCZzN1qpwzUkIswzSHrqxjdIx
 6U+PBW5psuvf3PUzJvBNf6xgjs8L6hr/8XS4MA==
X-Received: by 2002:a05:6214:2583:b0:7d2:f787:1978 with SMTP id
 6a1803df08f44-87b2103b6a8mr59845396d6.3.1759957825140; 
 Wed, 08 Oct 2025 14:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFhIocWy/x1gMig7deU+57pv1S58Rm1BpmHjWf/9y4QhffhBOPzd51/UFFy4AwB+THgO6QQg==
X-Received: by 2002:a05:6214:2583:b0:7d2:f787:1978 with SMTP id
 6a1803df08f44-87b2103b6a8mr59844976d6.3.1759957824534; 
 Wed, 08 Oct 2025 14:10:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53e3f8sm169128556d6.26.2025.10.08.14.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:10:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:10:22 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Message-ID: <aObTPn4jDknrMi6g@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
 <ac9d95ef-f9c4-4cf8-bccd-6fce9e49e702@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac9d95ef-f9c4-4cf8-bccd-6fce9e49e702@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 26, 2025 at 03:41:42AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 28/08/2025 04:59, Peter Xu wrote:
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index bcd7aae2f2..2b995513aa 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3068,7 +3068,6 @@ static void rdma_cm_poll_handler(void *opaque)
> >   {
> >       RDMAContext *rdma = opaque;
> >       struct rdma_cm_event *cm_event;
> > -    MigrationIncomingState *mis = migration_incoming_get_current();
> >   
> >       if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
> >           error_report("get_cm_event failed %d", errno);
> > @@ -3087,10 +3086,6 @@ static void rdma_cm_poll_handler(void *opaque)
> >               }
> >           }
> >           rdma_ack_cm_event(cm_event);
> 
> 
> This above line should be removed as well, otherwise it will cause a double cm_event free.

Good catch, thanks.  This fn is completely removed in the last patch, hence
it'll be an internal difference within the series.

Said that, I wonder if I should squash the last patch into this one
instead, because after this patch applied, we should be polling the fd in
two threads (main, and the loadvm thread), and operating on it concurrently
too.. which looks risky if not racy already..

> 
> 
> 
> 
> > -        if (mis->loadvm_co) {
> > -            qemu_coroutine_enter(mis->loadvm_co);
> > -        }
> > -        return;
> >       }
> >       rdma_ack_cm_event(cm_event);
> >   }

-- 
Peter Xu


