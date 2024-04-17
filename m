Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC43C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx9Y0-000751-RH; Wed, 17 Apr 2024 13:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx9Xz-00074q-8x
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:58:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx9Xx-0002VA-Kr
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713376692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZ22YfF7k2UjJPv5CNJMHCm6CPoIEnqBIekaj7agEpE=;
 b=Fw6r3fmo526hSqalorCetMW0ANEQQbNDxl3E5e3voFHPLC1PETcvg7q7NeJ2uSfRuXCg9m
 Rk5Q9Bf1ZCofqz4kVaWuRYJdTIAzxOwb+KEByV193cYjueomNtLOM9SxFpAsNPOniX0fLM
 WXQBgaeEM/ha3GFPts6ivBdxOq/w4Yc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-RpG8L4m-NlGYWaYsVEqJkQ-1; Wed, 17 Apr 2024 13:58:10 -0400
X-MC-Unique: RpG8L4m-NlGYWaYsVEqJkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54D9C18A8263
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 17:58:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FF6492BC7;
 Wed, 17 Apr 2024 17:58:09 +0000 (UTC)
Date: Wed, 17 Apr 2024 18:58:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v5 0/3] Add support for the RAPL MSRs series
Message-ID: <ZiANq0CG08nWA7sL@redhat.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <CABgObfamLi+Nz1sTC7PaDFg6jXT=4521SO11gbTysBo08jyp3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfamLi+Nz1sTC7PaDFg6jXT=4521SO11gbTysBo08jyp3g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 12, 2024 at 12:57:11PM +0200, Paolo Bonzini wrote:
> On Thu, Apr 11, 2024 at 2:14 PM Anthony Harivel <aharivel@redhat.com> wrote:
> >
> > Dear maintainers,
> >
> > First of all, thank you very much for your review of my patch
> > [1].
> >
> > In this version (v5), I have attempted to address all the problems
> > addressed by Daniel during the last review. I've been more careful with
> > all the remarks made.
> >
> > However, one question remains unanswered pointing the issue with the
> > location of "/var/local/run/qemu-vmsr-helper.sock", created by
> > compute_default_paths(). QEMU is not allowed to reach the socket here.
> 
> If I understand correctly the question, that is expected. This is a
> privileged functionality and therefore it requires manual intervention
> to change the owner of the socket and allow QEMU to access it.

In the systemd case, it will set the owner and mode, but in the
non-system case, I wonder if it worth making this helper program
have "--socket-owner" and "--socket-mode" args, so it can create
the socket with the right mode/owner immediately, rather than
expecting the admin to manuall chmod+chown after start the
helper


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


