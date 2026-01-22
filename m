Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2ABC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vipq2-0000Zm-Ju; Thu, 22 Jan 2026 03:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vippv-0000Z4-Bq
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vippt-0007b4-23
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769069674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMYQ8GzmeRcpapOKsMg/s69pOX1q15ZDJ92bLdviSfs=;
 b=eXDY3/h9AXXmV7Xk7CUpjPNEKqt7CCDiURFIsgEaJbYCq2VCdaYSDL3hfs+CHrchHnIBTE
 VrEGQpIA0nbYjvXb/5d1ktj7rNCZHs+gCAzw6JCO1CQP2OFiBUt8bCJ2576nVSRWPZjK4D
 G497XUw8MLGeKe4JVarbSqYI49/1uGc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-vKKjCtJnPCmwO4PVdpQmbA-1; Thu, 22 Jan 2026 03:14:33 -0500
X-MC-Unique: vKKjCtJnPCmwO4PVdpQmbA-1
X-Mimecast-MFC-AGG-ID: vKKjCtJnPCmwO4PVdpQmbA_1769069672
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso9077175e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:14:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769069672; cv=none;
 d=google.com; s=arc-20240605;
 b=J5CjPeyKkcN0RKMf71cjqHdV1zdwXCFXKY2JEw5N3jtV+lN2zyx96Z5VCiE7nU4phW
 IaJX+BP8NC/aI3FE52Kfj4rVOK5mQ3QuWszE3Oal0NTpoZCIhpX3RKZQyORnu46mHfOa
 wulPBOjI7VmmMGfXTK+zX1y1qG+l9CxKutmX26lZyYLJAPNTqmFvhVHiAz6RwUWyQ6xU
 dwaXKextYtb9rbgapjn/nkLKmMDreUBWXUwSXvMDY1hP2vaBCZUm/XVcOxmkw5rZlo4w
 3CiHSz1DYRl0s/D8R4cHIQRS3edx9Ik505yYxA9Ul8Z3UK++s0HBpFEHPeXkzPeXcI5G
 S5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HMYQ8GzmeRcpapOKsMg/s69pOX1q15ZDJ92bLdviSfs=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=KcL+bFqC9gZD2tbtqzwcoFNUljaaV9gchqzQZnHvBGrkDIIuAeil1852ATX7ZCYWYm
 rY+K72SavF/j8N/svBru5fcYWfDb55NQaxt0wHi3UCBUHcoiNtGoGhbZU5AJrbEwCP+Y
 ye5zeklwrCkjPvHUznt26lxxwqPNAwHYM01e9o/v3XyICQi9kDFW2IHYQMQezpWsE1gP
 IuWQCZnL8cadci4eCdnjP5Nf+rAoPDHcUWUY4vbaAhtGV4M5JhHQaHXPx3odJrwTWmCX
 W5RqT2nkqQKC4qvWur4NaLrN/uoLf2Obly4SCIoQYAhx4pCcPReiLyCZ4Ks/dCSC1GON
 fl6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769069672; x=1769674472; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HMYQ8GzmeRcpapOKsMg/s69pOX1q15ZDJ92bLdviSfs=;
 b=jLLE6HXVskm2M2ceofQcsuteULZ1XN08UgB7lxHIXh1S7bLvBPgejuZcn5KGxpcakC
 W0J968ego6ziiiLnPfeIe1qCAaTuA26Hc5IWB6kfG/uBAuCnsdVLR53bisfskbgkwyxv
 WTaRQdEkuVigwX79HKpY98gi4PL2JSU36uvNbcklPWrJO7ekev3HcWmMYQyan9jS5iFX
 G4fxmXSFdnDizTlMzZiLc3vTvQr7rJuQ+E5y0VWatxp3SIqvAVA5RdKj9HS0ozishpNP
 ZCQ4AfQGp8n3l+IFXGaIv6MBSDrNG50ya1V+n9Et1isPXsSi9rfSejfT2KPIum8LcynY
 sVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769069672; x=1769674472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMYQ8GzmeRcpapOKsMg/s69pOX1q15ZDJ92bLdviSfs=;
 b=X+pg8idbSOeqf9LobbK/nNxbdDzVucUjTwOaK1e3HzeLjLGUutvpVQ+lOntl22z4Gj
 G8uhMt50ZwfKv76lvYQAK9MOqnN3EekrS1BkhR2nszv4uSXHRm4pyOMotLKJRhEUduJd
 oVALJU97TQrkDIRfDviZXqa3aH21BZZ/YUCHhWnRdxn3E4nx6Hzm8JR405Nv0u6PivTk
 a5Pq49m33L9NBjEH29smV+NtbqieU3/MUbbM2DbXCMlx8rRHV+mv2eR9ix9KErDjz8xT
 +JXJ+ZUL1UMRim/XlhEkVdUp++X59El5F3NGf3oZUIKdSN4/80zJIpa3tUXXGbNOZSRt
 IgKg==
X-Gm-Message-State: AOJu0Yyea2WA8cAsRZP4zbiPRuFXJqETz57xRmK+nk63xiFF9mshjSed
 5x3hhfrYSB+tNdSVbaiykNqZZimQzdlL+wGv+gXZwCcuAsJDltQ650pMD69zsh6yaOJx9bszD6m
 qLCyi+vq0VPm1KOAup0BpRdQS67UyNfJJ5xWAdECNeN2V+0cpmWXqcucDdkqNMkAk6o6//JugKO
 kgcC3R6goArvmy4Yi36NzZytNoJKcg8bc=
X-Gm-Gg: AZuq6aJdPQKMiuMKoZIt7/qL9XnKquph3Lya4XNiKuJzh4ww0LfcJdzMOs2LsbQQsM4
 I2zz4PLxu/6OvTXgBw3goslvnsV4xxbU290VNkjrQy8lMWs9PAgc+P1t05GcNpysc3lrbOdLKiK
 Ba4b0bp21EFkRx295LVS8uyw3rhtLNhT/p/++G0q7+shCUGbl/jdS17YEX+u+kc1weLP8yc65zP
 Zht2cb7wE3ucbZ3uYcgT8SVI0FWjqRm05h5E/FDxdbDRPRMXQcwxc/q
X-Received: by 2002:a05:600c:19ce:b0:479:2651:3f9c with SMTP id
 5b1f17b1804b1-4803e7a4621mr110835055e9.14.1769069671783; 
 Thu, 22 Jan 2026 00:14:31 -0800 (PST)
X-Received: by 2002:a05:600c:19ce:b0:479:2651:3f9c with SMTP id
 5b1f17b1804b1-4803e7a4621mr110834845e9.14.1769069671411; Thu, 22 Jan 2026
 00:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOwKaETNiiin6JATUFzRt=DxtaXVaoTw3EgvGe-N+6qWhw@mail.gmail.com>
 <877btallqy.fsf@suse.de>
In-Reply-To: <877btallqy.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Jan 2026 13:44:13 +0530
X-Gm-Features: AZwV_QgnAZh4Mk7-yrHfiIWuWpYeYYSfXHuKMMk8Tgw8lccBCdONJEYw3QnladA
Message-ID: <CAE8KmOzokNWorvOXfWXxib-YhhUXgncZtBHR+-u8sa81VxPvXg@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 22 Jan 2026 at 02:35, Fabiano Rosas <farosas@suse.de> wrote:
> > On Wed, 14 Jan 2026 at 18:55, Fabiano Rosas <farosas@suse.de> wrote:
> >>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> >> @@ -1539,7 +1429,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> >>              migrate_get_current()->has_block_bitmap_mapping = true;
> >>          }
> >>
> >> -        migrate_params_apply(params);
> >> +        migrate_params_apply(&tmp);
> >
> > * This change looks unrelated to the rest of this patch. I see it is
> > done in another [PATCH 5/5] ... QAPI_MERGE patch, we should move this
> > there.
> >
>
> This is the only reason we can use QAPI_CLONE_MEMBERS. The params
> contain only the information that came from QAPI. What we really want to
> apply is what's in tmp. I refer to it in the commit message:
>
> "use the temporary object, which already contains the current migration
> parameters plus the new ones and was just validated by
> migration_params_check"

* Yes, here we are changing from params to &tpm. And the other [PATCH
5/5] changes the same from

     void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
              ...
     -        migrate_params_apply(&tmp);
    +        migrate_params_apply(tmp);

along with other related changes. I was thinking we change
'migrate_params_apply' in [PATCH 2/5] and 'qmp_migrate_set_parameters'
in [PATCH 5/5].

Thank you.
---
  - Prasad


