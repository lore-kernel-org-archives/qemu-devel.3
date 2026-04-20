Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D49DF5A8C6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEvS3-00063m-Ox; Mon, 20 Apr 2026 16:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEvS1-00063Q-Hy
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEvS0-0004Oh-3I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776717754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NklzYsQmRE/PNXFHL6O53ZZy6dAX1nvLQ9antW+VHGg=;
 b=eAO8bS7VxdY9HG8xva/uZEEWFQmkcl2hO3mIRlx4orsHQWU26WasddThfbUUOEL08Otq2B
 GIOm7zqYpELszvOkdC72HDUl+5izj4JQE8w/Bvue/BY4YHcJEh2BkhRxsWhM86YQaCR0Fk
 F8AhJ7O3aeMIfaAIxk5bXDWKgjrt7J8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ARRjGT81OMCWtCskmXREFA-1; Mon, 20 Apr 2026 16:42:30 -0400
X-MC-Unique: ARRjGT81OMCWtCskmXREFA-1
X-Mimecast-MFC-AGG-ID: ARRjGT81OMCWtCskmXREFA_1776717749
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eaaf673eb4so32372585a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776717749; x=1777322549; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NklzYsQmRE/PNXFHL6O53ZZy6dAX1nvLQ9antW+VHGg=;
 b=PCE7chZei4VJSOsw9U0kUmGZAAHXzSdJGzHWpT6EtY6LfbUa3vGdBobsVUZO5d/oSr
 v8jjr/OKRWQwPvSzTZb/sr6UH/MVsRKOj36fgbsXsyn/4d2Mcs16jML5UVACMEIoWh7J
 jMl32I2QnfQI0GJogcsnHPiLwUl7TOLKtDRO5wfGV5EwxaqQRgJ0WmOXR2P6/1dOOVhG
 k0Z06PuDy3ldicqY6Ma7P6sq0JINirTyQvJ5jceM3/PLMFeN/wxuvE3JsWPWGnrIuAJl
 H5JPUaXezKRj+4t49UAr5T0TQoPE5Cha5gqUIr8fWZ2T8q488GpouRDfR3O+Eu0k6kSu
 c8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776717749; x=1777322549;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NklzYsQmRE/PNXFHL6O53ZZy6dAX1nvLQ9antW+VHGg=;
 b=SxUsi1BeM9EDwM+wfJKl1iCnreEQl6fnetjDL2Ru+qzZr/Qlcy/yJXBvM/jR9G1aXs
 7N9Q7awQOx1bvsa4cb0BHACmLTy2rZhlQu44+Rsk7BkGlQhvevTCyw4GV5+2oprRgkf0
 YrOheDaabGqIXWqPmuX4zfGJbHgPgX0o+HveYhrzCvIUSEIGl5AB1WXcS/4wfmcuyhK1
 RGJcfYFEZqr9ihiVqIHqnKXUasz/mhAtQZi6DpdxVIlDIVMKzhc/DkX9+k+EZck6sP3d
 tw5NbOIJQRMV7QaMV9Tr8/9woQ2g1QwgkXRrCnqUDMcQklsZ4E+mXrn5cQ/cuRgQ8Dwp
 5wbg==
X-Gm-Message-State: AOJu0Yx1TqL1eDfoiJRIuz+Gp2rGyZAM8mf4kS585ATGhDmJGruwUiVK
 45NceZLAi7+fsEqXtnwdKV1T7GcLd/uguzvmPAAZrJB5mHSbPczy9cQE6cTkRN5wcY4TAS94Nee
 huf5BW5HxhBwQ6DTnsPPAWObqOFvy4zgYnYyKiZgYj5R/YULVsTG6MwYe
X-Gm-Gg: AeBDiev9s/y3X4Ob743ebR5hEpgX4sQgU/QSM/2+UNqxg2bmTCD7BSmyw6iy8nQUeVk
 pgnyZ1AQNk4PWZCGbA0SQQEppGHRDgBffhL+nkPBNYGzuYwcJg9A0MM2+wbY/G/Grhyj6Wr7Pr0
 30aC2CThr11VfiCuX7YOVZqGMHkAUuQIJHBH8c1NQL3TELw1hxc3D+DJFOohkZ92JIevABkVala
 Sguza1ArzwcL7x9JKNcartkslGtURyYME3jiZA8q+/nr9KXh8L5FSoZTDaRuGN4GQNQXAisKpU+
 Nmdein1YiYwyy4TVdM6ojD15DgYnz9Qr7aiZD4+FE/voMMZe4bbEqWvSUxeB1iPv4tCG6zAK98z
 VjTIpGycn0/pE2mkYVziSBeqojZ61Tjxh/A9sWzh86c4Q0NExLlk+fECzeA==
X-Received: by 2002:a05:620a:4509:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-8e79218171fmr2003477385a.57.1776717749404; 
 Mon, 20 Apr 2026 13:42:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4509:b0:8d3:cdeb:6d3a with SMTP id
 af79cd13be357-8e79218171fmr2003473185a.57.1776717748850; 
 Mon, 20 Apr 2026 13:42:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d93c3083sm853669185a.35.2026.04.20.13.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 13:42:28 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:42:27 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, steven.sistare@oracle.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: fix abort when re-migrating after cancel
 during SETUP
Message-ID: <aeaPsxYhYo1AXrlB@x1.local>
References: <20260417184742.293061-1-marcandre.lureau@redhat.com>
 <aeaBKzauFijGRhWr@x1.local>
 <CAJ+F1CKboKMKA0MbGhURhCSW5HkOM0+jQ4Sj4nWEXbLafpS1fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKboKMKA0MbGhURhCSW5HkOM0+jQ4Sj4nWEXbLafpS1fQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Mon, Apr 20, 2026 at 11:50:24PM +0400, Marc-André Lureau wrote:
> This is a bit over my head, I am not familiar with CPR. If you can
> take it from there, I am fine. I just wanted to fix the crash :)

Sure :) I'll have a closer look at this.

-- 
Peter Xu


