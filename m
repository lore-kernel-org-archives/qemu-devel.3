Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D20CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 16:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCKU6-0005xg-5Q; Fri, 24 Oct 2025 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCKTu-0005nC-63
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vCKTq-0000OO-Cn
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 12:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761322646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shQ9lzocb8ivK7uVigEXdwgj9omNkQ2gln0ib1yGGOo=;
 b=Ww+lFj3HuC6PqfO9PMSPcgagbB+0htGilkGKaOKPPdzMvmpg0aEDGz0ei+yvG/QEsBsL8z
 2lxe10tt5YpL9BNaCj7Pnl+qDYu7fUWWmLL7zTFFElBwl6Rz4chac0JC+0b4YWp1H6JXK9
 90Kp9ddUJWGBgRoFa+OJQV7FdiQ854c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-jvkScyJjOUeuJfEVJPvhMw-1; Fri, 24 Oct 2025 12:17:23 -0400
X-MC-Unique: jvkScyJjOUeuJfEVJPvhMw-1
X-Mimecast-MFC-AGG-ID: jvkScyJjOUeuJfEVJPvhMw_1761322643
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-890f1090e81so570763085a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 09:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761322643; x=1761927443;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shQ9lzocb8ivK7uVigEXdwgj9omNkQ2gln0ib1yGGOo=;
 b=Mo+xezWMXjKGlVkrmsEqCNN/5Sf2M0Hw5wX5uKOGNxHpNbPjXTSJ28FA/tVTxVjLGQ
 bH9wFeYPlvB/4hpOdGIAIv0JQWzSySLys+9Q3q04n9aCRPQqdbN7FNHQZIsA1nQeFc+u
 +BMIeMhceaYT6SAvTiXhu2jfiWlzHV/U8/layzeP4QXLy/B9wGITk8t/7ZN49RDL4ZVF
 Zqogw6QpvgJQYO/JeKd6pg6g65PuPLjrwhEGLsWB4/sUu+PMUgGbgnKQGLbELT47OCGw
 xGCVBkCHec+naugFsESMl+Cc9pfDy8Vf2tnHpK7jS3aTTu9nH4vQWYMdnzjrf9mGq4GQ
 6omg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD7+rSd2i9VM7kUwbi6Qm4ZaAUroSWNwFTuW41MeEFeY/auAU4qB9TG1ouIf4WYqlayup0zGC5oTgS@nongnu.org
X-Gm-Message-State: AOJu0Yw+wUkw1VO4MGSYUle19ff9DmWD4Pp7gW6dtVjGiM8QzTzcuQMS
 lY8iyOPPm564Oh6uIO9PEwztc5EpRXYmrpzx12zlRvOycOb0tTrPXbiMXgCcwENzjWEzi5KQ7PO
 9rgQwX7BJIT+WVku0XoSyAgPqn+hN3QINMMOxRmeUuPbSLXjB3rHgX1oa
X-Gm-Gg: ASbGnct/Un22zcaIx88swMYvQ7DsHGGwxIrfcda6KCXfnfKBS0JqXgjCcVh+Ir4mZL0
 XQU6/fedJ+Xurs/REQk3XEmZPG3fWZz1sZ/PIvPcwaqx5kdWE/PAPtaM1O6bHEfmBjQSP7V1ImJ
 W6kST37i8ZaK9jQaqTnSsZ28j0bDWL/pTM2KTS9SSqZZ02uybvIxhYsppl+wxnNYVCkWBPxhdwm
 cydh5Sdp4TsvvtuJyG1exAgAihUPQaCFOENkumNo4UPDGVR5iAi3AYb5DQNaON4HYWaFawQlphH
 TT0wgq9AkqHFsNCHvv/RDj4EkJmUdYlkYCDgkmx7e8geJSoYIxG7uFhjxcZvQZt5Ho8=
X-Received: by 2002:a05:620a:2950:b0:85b:e8ca:8ac7 with SMTP id
 af79cd13be357-89dbff855afmr372535185a.31.1761322643071; 
 Fri, 24 Oct 2025 09:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPH/5ceUAS9kpKSKZ6q0OrcEBT9HQFOUu5D9E7DXPmCuMQ2NANoU8UCsY6aXdaxQIXUYeubw==
X-Received: by 2002:a05:620a:2950:b0:85b:e8ca:8ac7 with SMTP id
 af79cd13be357-89dbff855afmr372529885a.31.1761322642592; 
 Fri, 24 Oct 2025 09:17:22 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0dbc9850sm418379485a.6.2025.10.24.09.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:17:21 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:17:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
Message-ID: <aPumkKBx4PoGSwNv@x1.local>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
 <874irozabw.fsf@pond.sub.org> <87v7k4xuhk.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7k4xuhk.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 24, 2025 at 04:08:39PM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> [...]
> 
> >> But wow, the migrate_add_blocker API design is unpleasant with its
> >> pair of "Error **" parameters - it is practically designed to
> >> maximise confusion & surprise.
> >
> > It's quite a sight, isn't it?
> >
> > I'll give it a quick Friday afternoon try.
> 
> Alright, my confusion has been maximised.  Giving up on this.

Besides the use of two Error** that might be confusing, what is more
confusing (if not wrong..): migrate_add_blocker() will take ownership of
the 1st Error**, no matter whether the helper succeeded or not. However, it
only resets the first Error** if failed.

I think it means if migrate_add_blocker() succeeded, the caller will have a
non-NULL pointer, even if it has lost the ownership of that pointer.

I'm guessing it never caused issue only because we don't usually
error_free() the migration blocker anywhere.. but I think maybe we should
at least do an error_copy() in add_blockers()..

-- 
Peter Xu


