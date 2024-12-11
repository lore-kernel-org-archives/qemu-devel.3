Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C3E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 21:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLURH-000342-Nv; Wed, 11 Dec 2024 16:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLURG-00033A-5z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLURD-0006O8-La
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 16:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733953203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+iIpMJ7Mmlq+/TJBhxnVJ87RlxR384cnSjftygfvb/I=;
 b=aUG0wI4/3UWqg4if6BhquepJLF664OqHrud5JnfE4mvbXku9O47K15vgjvuqaxBZ1lMXMA
 IKJxqLOojSEoEY4hLA4drYODPcyxrSN67nDGOLmz/dGXsk+Bogw4Kdf3O8Nezh5um9/K9Y
 SXCBxDsixq9F1CwJ9+ASEppTTUanRNg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-nE86j7r_NpihZ9PMrrEwTQ-1; Wed, 11 Dec 2024 16:40:01 -0500
X-MC-Unique: nE86j7r_NpihZ9PMrrEwTQ-1
X-Mimecast-MFC-AGG-ID: nE86j7r_NpihZ9PMrrEwTQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4675749a982so80331591cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 13:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733953201; x=1734558001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iIpMJ7Mmlq+/TJBhxnVJ87RlxR384cnSjftygfvb/I=;
 b=M1/qJvUz0D43soNn4vEbXpFjzyxrTfffTt/uXfR0NeOy7Tri8X3NNkX4CFM2Xptixo
 QW2rvW/hYbXe94riXeScOVU+tLj5ZWblTghlhMeV/6J0n+bRQFkHGg6A64VlrpTnNVdl
 dTgnxPQaegjafh2uHUIfTOYVRYuQGgb7X6o4uwj1FjHp5mkUVcWQj3aQhdUeaoMnvhpx
 4gTpfxzhheYUTljRgTgnU8MD1UvL/hRjlXZ1klSFb4A1zx62hJc+PyRuCj3hzHar24D3
 /UyRPM1kOGX0w0/3mWXFur97E4wa90LT4Tlus3xe/c1JJZAKXwEBKBHm3ff3yuWWt8uE
 C7DQ==
X-Gm-Message-State: AOJu0YyzicHtwaUOK6BT9r9FVnPiGLcy0ZnSQvf0McQd/DHEj+ezK5TD
 oK/o17CKOjci6NqHb7WW3QRTBJRZqUtyoSREIKHOsuS3bUqdY/BONl7QIKr58crGYcpcwL0pezY
 BG9F2BXZYkkaB2P+UYxqCrtp4qYozYLLdcOJrpLU78P8A63fh8kpE
X-Gm-Gg: ASbGncsZaqQAEAMpFT9KAZKi44Shu7cjA7y1ihDKiNbsneHL5ikc2/f9y2OM/0+8Zt+
 KgBo+xLdetaKZKGaDdrmqIrphae02zdGK/rzPHi4TlAsS9/5MGchKzKt2hWWB2MY1XFr5fFImsH
 GKPtFIlA5Mm8njcEQWw/w+0w/3QMBqnX+sxWqaR8UAQII26Kh3OQv0orDBCmGWWEjbiiMjve72r
 9gZuFH4rn9jtvKtv7O5e+t6Mg22j6QnVnZ2PiAKCzeXofEiD1iNzwnguZC2IybUOQQWGfeWREL6
 IxFYyOrF6nPlB9c=
X-Received: by 2002:a05:622a:353:b0:467:770f:70a0 with SMTP id
 d75a77b69052e-4679615fbc8mr19502211cf.10.1733953201214; 
 Wed, 11 Dec 2024 13:40:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQSD/eRmJp7yOE7sWD/crMQlEmVahrjZOWr+Av/gyj5VA+Ymo3oqRzkuJeNIfk8LmFzSgZFw==
X-Received: by 2002:a05:622a:353:b0:467:770f:70a0 with SMTP id
 d75a77b69052e-4679615fbc8mr19502001cf.10.1733953200933; 
 Wed, 11 Dec 2024 13:40:00 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46787387ed9sm14368921cf.87.2024.12.11.13.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 13:39:59 -0800 (PST)
Date: Wed, 11 Dec 2024 16:39:57 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
Message-ID: <Z1oGrWlUaB5O3n5X@x1n>
References: <20241211201739.1380222-1-peterx@redhat.com>
 <87pllyezmh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pllyezmh.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 11, 2024 at 05:25:10PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Coroutines are used in many cases in block layers. It's also used in live
> > migration when on destination side, and it'll be handy to diagnose crashes
> > within a coroutine when we want to also know what other coroutines are
> > doing.
> 
> Not sure if you've seen this message on the list:
> 
> https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net

No I didn't.  I only started looking at this because I got a bug a few days
ago that I need to look at the main coroutine where dest crashed, then
Stefan told me this script and also told me it only works with live session.
Ideally I'll need coredump debug-ability, then I figured it isn't too hard.

I saw that it didn't yet land gdb, and it's much more involved even if it
could be more generic.  Not sure how the block developers think, personally
I prefer this much smaller change because it works on old systems, where I
can easily install gdb with package managers.

-- 
Peter Xu


