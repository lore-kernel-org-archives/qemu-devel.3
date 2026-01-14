Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94631D37E4F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2v3-00064t-CP; Wed, 14 Jan 2026 10:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2ur-0005vY-1k
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2up-0003pu-Lk
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768404969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yFREpAotJMpoOXOn0epbHgD3xLWzMM8N9fE0gBuHRFI=;
 b=M71cZUBNSDiVtZGygFv1xf47biEiQMMGiFx1ZvjsXAoparFsXY+j9jB+Eo491DNoCA6EBO
 rfiJo/JKOq8Exa9dS+2+2le1mKo2PuY3NSM1rRFdEzHYl9REulysUlY700ZUXF1+XkzS5Y
 wKe7Vvx0hfslgwDxSFrknr+lwX7Ki1k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-1r-z5dzMOPC35N8AZnCCiw-1; Wed, 14 Jan 2026 10:36:07 -0500
X-MC-Unique: 1r-z5dzMOPC35N8AZnCCiw-1
X-Mimecast-MFC-AGG-ID: 1r-z5dzMOPC35N8AZnCCiw_1768404967
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b2e235d4d2so3418576885a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768404967; x=1769009767; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yFREpAotJMpoOXOn0epbHgD3xLWzMM8N9fE0gBuHRFI=;
 b=qJeGi1uXLb7csY4YaEOu1D7uRd41TKw31A/FGqi3G+CXOyQbntK5XAq5wQednhWmkE
 19P+euZ++S+PP/9aLS7G7xg8/3ryFFEltnAPRD9dLBEqHOZAPIpbZC+LB9ffXwmCfzrH
 dXUO1ARVukIATFcyH64wXqF09pmKN8e8WmmdGFfxF4OEq+xbREs7VlinsfCcFIpOuYhD
 HTIqIs/YZSSo/d5wtvrwLdHfXSoptdYK1jkxh0c6qpsi8pFZZxCeaUj3f5K5mxfSFdye
 ddWzdavwOHcVGVygx0SJznOXXy7vcxyYSt9tqJjHw4wqxIsSBekikP1VyQQR0uTPU42F
 ycng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768404967; x=1769009767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFREpAotJMpoOXOn0epbHgD3xLWzMM8N9fE0gBuHRFI=;
 b=DE4WkpsACN5hySX5J/29Thg7adQIFIt/B3GZy0KT5kRyVU1t1CXEe7PYKr2vd3cnC4
 V51CDxfXGjIw3SNv6GDm0JQ3pvoVVd9minmGuznesgWayeCtwcJOlmIlDzFfEGtx/Ugk
 e/h8PFSLbyNYIuRJE6J55yFjbzvGoHCz6AXhs4tf7w/19MV2j7t9xkIT5D9IfPe+8jQJ
 KmTJHAW58gmKmqqSvsqr8lQlPD2GlgR8vB+EDmzHSK7SfgnExJY5uVr6tKozOSJo9x38
 z6SAGdYVOXFlGL9LgtHg/m1AIXhL41nYab+xjnZi4jBTSnrNWAluJS2tlEAoILvhwucS
 1dFQ==
X-Gm-Message-State: AOJu0YxFGI6RJyKStNoLjk44DEyPpWq3UDzvYvE246KXABZNm7Lj6uPz
 sgzo+fyShTiLBUWlrnqi3xFJ3GTmdheaQsuPv61BLO8BM/RXcJUHX5TknguA4CASbJSPhK8bmES
 Fsp07FNcfj6I34oF+rs7wOfl9FxbLip+wp95IaBSPOQk6HLEhB56CCHZNo5K8JLPJ
X-Gm-Gg: AY/fxX6RfKZNskhUJuJ9fogNS+nxMLP2oVRGVaAC9wzK9sNjMhg6afYLHxuybuYetSC
 nu1E11AqaSBmWG5HzOxuPeq+dFjCYoapPQBrwbAR7qTV6R7aXo1qvXL3D6hWiC00g/N5Hz/tgtz
 244imYJsw3qBuszJT1D6/sekf1kUV6IsOYqEIgcwhDQtvmFjQG694CEiEx5WgzEHeuqUwditSTc
 SVYA1sTiKtBthc3qlBC6RioDcZE442Ol1lRUrf3wVwNQPZaXr7OojVlrE9mv8L7DcOX1F32191n
 C/N5NILtscd2uUqo8jd3IQRTgZWSVCA7YRhyShLmSKU23NxeuiWYJ5lT80/Hx12zIx7eU+BREEE
 htKk=
X-Received: by 2002:a05:620a:2902:b0:8b2:1f8d:f115 with SMTP id
 af79cd13be357-8c52fbfa45emr433983085a.65.1768404966617; 
 Wed, 14 Jan 2026 07:36:06 -0800 (PST)
X-Received: by 2002:a05:620a:2902:b0:8b2:1f8d:f115 with SMTP id
 af79cd13be357-8c52fbfa45emr433977985a.65.1768404966202; 
 Wed, 14 Jan 2026 07:36:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530a6bdbdsm180992085a.10.2026.01.14.07.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:36:05 -0800 (PST)
Date: Wed, 14 Jan 2026 10:36:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
Message-ID: <aWe35LsGn_68MIUu@x1.local>
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-3-peterx@redhat.com>
 <CAE8KmOz9XtaEY+LMD9CCCR_bMXe04chGHdvuwVqsYRNe+AtUJg@mail.gmail.com>
 <aV6UhNJzQLnDaJvO@x1.local>
 <CAE8KmOzPHTf6eaufn3dWTJJ2nsifdxZzwENK2hD_LZLGiE-pcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzPHTf6eaufn3dWTJJ2nsifdxZzwENK2hD_LZLGiE-pcQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 08, 2026 at 03:11:32PM +0530, Prasad Pandit wrote:
> On Wed, 7 Jan 2026 at 22:45, Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Jan 07, 2026 at 05:07:40PM +0530, Prasad Pandit wrote:
> > > On Wed, 7 Jan 2026 at 02:04, Peter Xu <peterx@redhat.com> wrote:
> > > > The parameter can be instead passed into the function.
> > >
> > > * It'll help to include - why? pass the parameter instead.
> >
> > I want to remove special and unnecessary fields in MigrateCommon struct.
> >
> > I'll add a sentence when repost.
> ...
> > > * To keep it consistent, maybe we can call the variable 'stage' as above?
> >
> > Personally I prefer fail_stage, e.g. fail_stage=NONE means it never fails.
> > stage==NONE is less clear.
> 
> * Let's make it fail_stage in both places then?

Could you explain what's the 2nd place to use it besides the parameter in
test_postcopy_recovery_common()?

> 
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks,

> 
> Thank you.
> ---
>   - Prasad
> 

-- 
Peter Xu


