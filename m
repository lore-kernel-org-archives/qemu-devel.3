Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7AC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wopP3-0002fJ-3Q; Tue, 28 Jul 2026 17:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wopP0-0002eq-KF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wopOz-0008T8-6V
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 17:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785274311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QPaPOi3C2bC9g/j69WMfi5I1Ym7wUv2GjVevnkuL1w=;
 b=PoIkFsOQ71S6g6g1OiFh3TMh6WHriC9ce/NgnxkTee1VD80F8d8z+2+ykVC3uuqkVw9wos
 Absm1I+VbJc1tQM+T57/P/wBP8ceyCmFfmk7SI+xyjri5iCDx8bTuYtjLnnppxT+9YCcmk
 TdCqJ90RKaMPwgXp6p67YvZG4QwOzUA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-eO_LDX7NNyWarg_U9SWimw-1; Tue, 28 Jul 2026 17:31:48 -0400
X-MC-Unique: eO_LDX7NNyWarg_U9SWimw-1
X-Mimecast-MFC-AGG-ID: eO_LDX7NNyWarg_U9SWimw_1785274308
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f08560ea44so3769466d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785274308; x=1785879108; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4QPaPOi3C2bC9g/j69WMfi5I1Ym7wUv2GjVevnkuL1w=;
 b=MULoIUtH5vbT5KXMfPrk+DoocFHmHUc4MHgrKb938tsxllv8QI6CKFWUtf7M6Xtrtk
 H2QUZdsTgShU4hgwxaefawQ/dFlF3hEGD2g09qu80Por/jIxuZzWmKzVD+VplaB+LdEC
 ewggi97z0QY+KOKxAtz0OrRCWi8GhPlEmCu8R8XLWvMKBWN4jLfLFNmntI/xTH/n5lUq
 HS/Kjk4DjCHbP5DYOW5QYzfw3GedlhyUVJq4YlqLBdHX/og3Aj4RtOKsIDu1S8zUZPkM
 1YyPIOl1RpEbmZ9YvxekT5Cl4nJWDZA3paczSQfJWEvTkKOYp9yJ8RCZLiJlnnHR1RKZ
 /GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274308; x=1785879108;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4QPaPOi3C2bC9g/j69WMfi5I1Ym7wUv2GjVevnkuL1w=;
 b=TPE66UEca+swz+NA3y9QP2cw+J7OQZNNpmu9B0j3hfh2ns5Co9372YbOsPSHHIPR/B
 PbfjjfT1/OQexu8QpjHbSLCtfVLLuBr+m/PeSw/cSYR+q17F5WIIc59anEPX4oBugGBU
 A3+0VExmvCGohwbi2NQ2wTkSYcr9BERJN53eS4lnu1Os1m2qaJScn5ycis+sVfr7dftd
 p3AgMlCtSiCnaWlE8gwZWENi2eCAafzii1F1f9rR92qgicaScdAB4AZ3GJ61eSihUrvv
 OIgOHr67V/pw5ElDKBlV6NgmWIUuRcBg7B5U2b/3M8KvzbGh3lkhA2YZpg6Bl/JmWOzu
 AvTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOkrSBjHezQ6gyAjhIGkZlPK5nbTQ9qawQ/reV37G8Cnqh/QStrEGmZQFGRDpRk3b1QZzC/P/u7G/E@nongnu.org
X-Gm-Message-State: AOJu0YwzHnyOED2pFEt1sdO5+R1S1+5thtEG2bKAMU585JFewyRzMFC9
 dhHldRzoK2pvnrGFZwSVjt857BY2Xq1gbqGdRJhBCDev8KeyNsO4ppxvHxvxi7Ms+6KWVy9+fWh
 DJmKL1aD/Ou6kTI7oqPuhchO5cy6L1/tpiQfc2Hys/FEAmIPKu6hzW+Rp
X-Gm-Gg: AR+sD130UmmFOijjjk96/XsbpoKiFUVo9NNCIv0Wt55Upe8QPKzItJUeNmYmBlC00fS
 FkVt48RJx6Y/qK82TSIEDQtENotvcB7y0yhT/vKXy9Dw11JwXZHoLneat7CE9fv7OH91vIv44Dm
 FJFaCMyIMlZsAvrl0etomSNqO79Aym/yemRR4ESS2ffxfWBDZS5Qd/ffPOJtQJy99Rtl6rOSH+5
 SrhjC2jzyTTq7GOTOA/iLvK0Cpm0oh6E2OhFmPPa2iTuadHoINBInfGGErBV1fKxWk0oIjFs+nL
 kzSqAcV2wpiQG6sL068HSQGjfOcDQrk9SfHZbCJTQmQ83mYMz/BDmWUxTn1Q9k3oK+9oEkxrWYc
 KaOYub2EJLUJnkQWSJ1B42vG2OpdmuCvsVMVg9Xz/XC2GnUH5W/F89AbHwso=
X-Received: by 2002:a05:6214:1245:b0:8f3:e97:59b8 with SMTP id
 6a1803df08f44-9081730a0c8mr46788486d6.29.1785274307644; 
 Tue, 28 Jul 2026 14:31:47 -0700 (PDT)
X-Received: by 2002:a05:6214:1245:b0:8f3:e97:59b8 with SMTP id
 6a1803df08f44-9081730a0c8mr46788146d6.29.1785274307113; 
 Tue, 28 Jul 2026 14:31:47 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9081dd8cb0dsm8330266d6.48.2026.07.28.14.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:31:46 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:31:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amkfwdkkwBlt7hfA@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com>
 <amjXxDH73ah-dUGE@redhat.com> <amjiLyOJF92okvik@x1.local>
 <87o6fqopgn.fsf@suse.de> <amkVJZ14O60zAeVt@x1.local>
 <87ecgmomm5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecgmomm5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 28, 2026 at 06:00:50PM -0300, Fabiano Rosas wrote:
> If I'm not mistaken the watch only dispatches when there's IO.

Listening sockets are registered with:

        socket_connect_incoming ->
        qio_net_listener_set_client_func_full ->
        qio_net_listener_set_client_func_internal ->
        qio_net_listener_watch

So the watcher is on the listening socket, not IO socket.

qio_net_listener_channel_func() will accept() and create the IO socket,
then it does the callback to socket_accept_incoming_migration() on the IO
socket just created.

-- 
Peter Xu


