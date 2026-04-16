Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BD7F8A144
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDI2I-0000IM-5G; Thu, 16 Apr 2026 04:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDI22-0000HF-FI
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDI20-0002S5-AL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 04:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776327898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=329OjxAIu5+b3t+gmMY9eTsIcA9Y3WORX+tgGe9YVB4=;
 b=cn/kywkQEtanUE1Je/8F2QONLBzPa9Ja0yeKBGPAsmn7rrE7OPLgSjU80h/uznE5PpZZZn
 3WoUP7CjeiFb9Tba3xJSV+eFkOCna6YBJcC8TnRd8N9AGZXwHKeCvkAUfEdjIHhTP9RGQ0
 aE4PKUOqW+CCyQYNpjPWIBDTuNFZtFM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-pFtsdJcvPouomPMEYJCKPA-1; Thu, 16 Apr 2026 04:24:56 -0400
X-MC-Unique: pFtsdJcvPouomPMEYJCKPA-1
X-Mimecast-MFC-AGG-ID: pFtsdJcvPouomPMEYJCKPA_1776327895
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d121c4271so4878912f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 01:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776327895; x=1776932695; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=329OjxAIu5+b3t+gmMY9eTsIcA9Y3WORX+tgGe9YVB4=;
 b=sm8F8DJSecnKfeszgLmIpR4PZdvFQ6e6TdDZJECqmhU5YUNj4tmfQp1jj/ECqP/DV6
 3PJ9J3JP4BXatbDVaUDURRSE/G0jummnx876w/+kV4awUxxc9bii8eSM/GOU1NQK2xWA
 gPOBEAsudDC2NUn9wHwiw6/lLhbxhsfsxJzpi7hvmx8Ax036b/nQek7P8fO6qpGmbZAq
 7eCfdDt4x0LXJS4a4+WCIIzxESpC7sn5VdFH5dZWVRe8PjWvT8gwcK93Q8LvU4YV+yyS
 YWOx5ag/p/R0rH61vvVYHng8Jle5CLb61L+AfplA/kZYn/PvR0B5rmQKwh+T1YockiX6
 3IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776327895; x=1776932695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=329OjxAIu5+b3t+gmMY9eTsIcA9Y3WORX+tgGe9YVB4=;
 b=gTQJnq44lT6RM/baLjSslvBtmQbIF/mcY/dI8aY+/Ibp8lGAMlnD5RLhTf3qzutx6u
 HBbXA7tkVdo3+IoJo4csEhjXsEVIx20v1BN/TZUp3QECE9RlYXJvMUi9oDaRqb2t+ZxN
 zsqp0eRt3AlR6MIk90FY8UVCHaIK53ymTdLHYK+a3ewsRBctssZvAVWecWHr0k36VNm4
 lkXOHwzQoKWNepm13ljUVJSadp7L22ZpTfh8Kohzkg+zHxGVcxKr2HtF8bXvdHfMqFmN
 jEfvec5dnRPf1eYkFokvSLOv2X+nYLBYc/aU1YQ/pThNp/FRDBM7ZtpUHOnYolcRgzgP
 l4RA==
X-Gm-Message-State: AOJu0Yxx+2V419aWXvvaIdrBV4NTJ/J//b6s0ElQV6hsSWtFJN4Z64Hi
 6xKwXa3i5r7gU+kw2ez2/G9AGM7bqrB2Nhz7P4I8SkFuE0nkjtuFlmU3mdDDw/jdud+Ike9qEQw
 cTubV2A60a3YOwcBlSQSL03iVaEeBlmN2ng33rLHvnHXjadbYGSCXmi4u
X-Gm-Gg: AeBDieua00b8SX5D3Q7/5QEoUQk8/SWjcHOJkvIGIVsoYDRGxLkpeuVFJV4YnZO/Sc0
 6Ar9r4lfCBiq6pmcVun7kTXO7pcWstbLMQbS+qX0evjnoTrU53tWg9MIf6mELGcgl90q43Tgh/Z
 Q8F1WHrd20KXh2FkClqCPrT6B/UJKc4NDUoeEkXeyKMXa/ymO4dyVz5DnHfna7ClgM4kf1uxjzP
 eAI+T+IyTpyQDbAtlHO0QNIXOEB2gvs4El11MVwenA/lmkkylHQrPjzcpKIuAQKVh7z6Bcm19JP
 fcDvI2Ub7UELaYbETiMRIOeGdaQqXYy+PChtllW40weEbX2ELmiotll+nWVJhFA2kXgf8whzBwS
 FmFvuwMLwhGUO
X-Received: by 2002:a05:6000:2583:b0:43d:7d24:b506 with SMTP id
 ffacd0b85a97d-43d7d24b82bmr20052512f8f.38.1776327895262; 
 Thu, 16 Apr 2026 01:24:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2583:b0:43d:7d24:b506 with SMTP id
 ffacd0b85a97d-43d7d24b82bmr20052458f8f.38.1776327894727; 
 Thu, 16 Apr 2026 01:24:54 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5eb4sm11961093f8f.20.2026.04.16.01.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:24:54 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:24:51 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Joao Martins <joao.m.martins@oracle.com>, Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/14] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <aeCcj8V0VRGcel8l@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-5-peterx@redhat.com>
 <adfdUBTJweN-V-ZP@fedora> <ad-7f30zV6XfYEE1@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-7f30zV6XfYEE1@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2026-04-15 12:23, Peter Xu wrote:
> On Thu, Apr 09, 2026 at 07:10:56PM +0200, Juraj Marcin wrote:
> > > -    /**
> > > -     * @state_pending_exact
> > > -     *
> > > -     * This calculates the exact remaining data to transfer
> > > +     * @save_query_pending
> > >       *
> > > -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> > > -     * pending data.
> > > +     * This estimates the remaining data to transfer on the source side.
> > > +     * It's highly suggested that the module should implement both fastpath
> > > +     * and slowpath version of it when it can be slow (for more information
> > > +     * please check pending->fastpath field).
> > 
> > There is no pending->fastpath field anymore.
> 
> Yep I missed it..  When at it, I rewrote this part to make it read better,
> latest version now:
> 
>     /**
>      * @save_query_pending
>      *
>      * This estimates the remaining data to transfer on the source side.
>      *
>      * When @exact is true, a module must report accurate results.  When
>      * @exact is false, a module may report estimates.
>      *
>      * It's highly recommended that modules implement a faster version of
>      * the query path (for example, by proper caching on the counters) if
>      * an accurate query will be time-consuming.
>      *
>      * @opaque: data pointer passed to register_savevm_live()
>      * @pending: pointer to a MigPendingData struct
>      * @exact: set to true for an accurate (slow) query
>      */
>

Looks good, thanks!

> 
> [...]
> 
> > Apart from that one comment above, it looks good to me!
> > 
> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> 
> Thanks, Juraj!
> 
> -- 
> Peter Xu
> 


